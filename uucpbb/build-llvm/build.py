#!/usr/bin/env python3
"""LLVM builds of UUCPbb and OS-9 module size measurements."""
import argparse
import csv
import concurrent.futures
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
from datetime import datetime, timezone

ROOT = Path(__file__).resolve().parent


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def revision(path):
    result = subprocess.run(['git', '-C', str(path), 'rev-parse', 'HEAD'],
                            stdout=subprocess.PIPE, stderr=subprocess.DEVNULL, text=True)
    return result.stdout.strip() if result.returncode == 0 else 'unknown'


def module_info(path):
    data = path.read_bytes()
    if len(data) < 16 or data[:2] != b'\x87\xcd':
        raise ValueError('Output is not an OS-9 module')
    size = int.from_bytes(data[2:4], 'big')
    if size != len(data):
        raise ValueError('Declared module size differs from file size')
    parity = 0
    for b in data[:9]:
        parity ^= b
    if parity != 255:
        raise ValueError('Invalid module header parity')
    crc = 0xffffff
    for b in data:
        crc ^= b << 16
        for _ in range(8):
            crc <<= 1
            if crc & 0x1000000:
                crc ^= 0x800063
            crc &= 0xffffff
    if crc != 0x800fe3:
        raise ValueError('Invalid module CRC')
    if data[6] != 0x11:
        raise ValueError('Expected a 6809 executable program module')
    return {'module_bytes': size, 'data_bytes': int.from_bytes(data[11:13], 'big'),
            'module_sha256': digest(path), 'crc_valid': True}


def run(command, cwd, log):
    log.write('$ ' + repr(command) + '\n')
    log.flush()
    subprocess.run(command, cwd=cwd, stdout=log, stderr=subprocess.STDOUT, check=True)


def build(args):
    source = Path(os.environ.get('UUCPBB_SOURCE', ROOT.parent)).resolve()
    src = source / 'src'
    if not (src / 'uucp.h').is_file():
        raise ValueError('Set UUCPBB_SOURCE to the original uucpbb directory')
    projects = source.parents[2]
    compiler = shutil.which(os.environ.get('LLVM_CC', str(projects / 'llvm-mc6809/build/bin/clang')))
    if not compiler:
        raise ValueError('MC6809 clang not found; set LLVM_CC')
    sysroot = Path(os.environ.get('LLVM_SYSROOT', projects /
        'picolibc/builddir-mc6809-os9-Os/stage/usr/local')).resolve()
    for name in ('include/stdio.h', 'lib/libc.a', 'lib/libos9.a'):
        if not (sysroot / name).is_file():
            raise ValueError('Missing OS-9 sysroot file ' + str(sysroot / name))
    targets = json.loads((ROOT / 'targets.json').read_text())
    selected = sorted(targets) if args.target == 'all' else [args.target]
    if any(t not in targets for t in selected):
        raise ValueError('Unknown target; use make targets')
    out = ROOT / 'out' / args.opt
    out.mkdir(parents=True, exist_ok=True)
    work = out / 'src'
    # Always regenerate only the disposable source/object area.
    if work.exists():
        shutil.rmtree(work)
    shutil.copytree(src, work)
    logs = out / 'logs'
    logs.mkdir(exist_ok=True)
    with (logs / 'patch.log').open('w') as stream:
        run(['patch', '--batch', '-p1', '-i', str(ROOT / 'patches/llvm.patch')], work, stream)
    base = [compiler, '--target=mc6809-unknown-os9', '--sysroot=' + str(sysroot),
            '-' + args.opt, '-ffunction-sections', '-fdata-sections', '-std=gnu89', '-D_VOID_', '-Dm6809', '-DOS9',
            '-DSHELLPLUS', '-DNEWCLIB', '-include', str(ROOT / 'compat/llvm.h'),
            '-I', str(ROOT / 'compat'),
            '-idirafter', str(work / 'header'), '-Wno-implicit-function-declaration',
            '-Wno-implicit-int', '-Wno-deprecated-non-prototype']
    if args.opt == 'Oz':
        base.append('-DUUCPBB_LLVM_OZ')
    compatibility_root = Path(os.environ.get('LLVM_OS9_COMPAT_ROOT',
                                              projects / 'cmoc_os9/llvm')).resolve()
    compatibility_library = None
    if compatibility_root.is_dir():
        with (logs / 'os9-compat.make.log').open('w') as stream:
            run(['make', '-C', str(compatibility_root),
                 'LLVM_BIN=' + str(Path(compiler).parent),
                 'OS9_SYSROOT=' + str(sysroot), 'OPT=' + args.opt,
                 'OUT=' + str(out / 'os9-compat')], work, stream)
        compatibility_library = out / 'os9-compat/libcmoc_os9_compat.a'
        base += ['-I' + str(compatibility_root / 'include'), '-include',
                 str(compatibility_root / 'include/cmoc_os9_compat.h')]
    elif 'LLVM_OS9_COMPAT_ROOT' in os.environ:
        raise ValueError('Missing LLVM compatibility directory: ' + str(compatibility_root))
    needed = sorted({s for t in selected for s in targets[t]})
    # Object errors are retained and prevent affected targets from linking.
    def compile_file(name):
        obj = work / (Path(name).stem + '.o')
        log = logs / (Path(name).stem + '.compile.log')
        cmd = base + ['-c', str(work / name), '-o', str(obj)]
        with log.open('w') as stream:
            try:
                run(cmd, work, stream)
                return name, True
            except subprocess.CalledProcessError:
                return name, False
    with concurrent.futures.ThreadPoolExecutor(max_workers=args.jobs) as pool:
        compiled = dict(pool.map(compile_file, needed))
    # Archive adapters separately so unused helpers do not pull their runtime
    # dependencies into every program module.
    compat_obj = work / 'libuucpbb-compat.a'
    compat_objects = []
    for compat_source in sorted([*(ROOT / 'compat').glob('*.c'), *(ROOT / 'compat').glob('*.S')]):
        name = compat_source.stem
        obj = work / ('llvm-' + compat_source.name + '.o')
        with (logs / ('llvm-' + compat_source.name + '.compile.log')).open('w') as stream:
            compat_flags = ([compiler, '--target=mc6809-unknown-os9']
                            if compat_source.suffix == '.S' else base)
            run(compat_flags + ['-c', str(compat_source),
                        '-o', str(obj)], work, stream)
        compat_objects.append(str(obj))
    with (logs / 'llvm-compat.archive.log').open('w') as stream:
        run([str(Path(compiler).parent / 'llvm-ar'), 'rcs', str(compat_obj)]
            + compat_objects, work, stream)
    version = subprocess.check_output([compiler, '--version'], text=True).strip()
    resource = Path(subprocess.check_output(
        [compiler, '--target=mc6809-unknown-os9', '-print-resource-dir'], text=True).strip())
    context = dict(compiler_version=version, compiler_sha256=digest(Path(compiler)),
                   source_revision=revision(src), flags=base,
                   source_sha256={str(p.relative_to(src)): digest(p)
                                  for p in sorted(src.rglob('*')) if p.is_file()},
                   library_sha256={str(p.relative_to(sysroot)): digest(p)
                                   for p in sorted(sysroot.rglob('*')) if p.is_file()},
                   runtime_sha256={p.name: digest(p) for p in sorted(
                       (resource / 'lib/mc6809-unknown-os9').glob('*')) if p.is_file()},
                   patch_sha256=digest(ROOT / 'patches/llvm.patch'),
                   harness_sha256={str(p.relative_to(ROOT)): digest(p) for p in
                       [ROOT/'build.py', ROOT/'targets.json', *sorted((ROOT/'compat').glob('*'))]
                       if p.is_file()})
    if compatibility_library:
        context['os9_compat_library_sha256'] = digest(compatibility_library)
        context['os9_compat_source_sha256'] = {str(p.relative_to(compatibility_root)): digest(p)
            for directory in ('src', 'include') for p in sorted(
                (compatibility_root / directory).rglob('*')) if p.is_file()}
    context_text = json.dumps(context, indent=2) + '\n'
    context_hash = hashlib.sha256(context_text.encode()).hexdigest()
    contexts = out / 'contexts'
    contexts.mkdir(exist_ok=True)
    (contexts / (context_hash + '.json')).write_text(context_text)
    failures = 0
    for target in selected:
        binary = out / target
        metadata_path = out / (target + '.json')
        # Remove earlier results before attempting this target.
        for p in (binary, metadata_path, out / (target + '.map')):
            if p.exists():
                p.unlink()
        failed_sources = [s for s in targets[target] if not compiled[s]]
        metadata = dict(target=target, optimization=args.opt, status='BUILDFAIL',
                        module_bytes=None, data_bytes=None, runtime_tested=False,
                        built_at=datetime.now(timezone.utc).isoformat(),
                        context_sha256=context_hash)
        if failed_sources:
            metadata['reason'] = 'Compile failed: ' + ', '.join(failed_sources)
        else:
            cmd = base + [str(work / (Path(s).stem + '.o')) for s in targets[target]]
            cmd += [str(compat_obj), '-Wl,--gc-sections', '-Wl,-Map=' + str(out / (target + '.map')), '-o', str(binary)]
            if compatibility_library:
                cmd.insert(cmd.index('-Wl,-Map=' + str(out / (target + '.map'))), str(compatibility_library))
            metadata['command'] = cmd
            with (logs / (target + '.link.log')).open('w') as stream:
                try:
                    run(cmd, work, stream)
                    metadata.update(module_info(binary), status='OK')
                except (subprocess.CalledProcessError, ValueError) as error:
                    metadata['reason'] = 'Link or module validation failed; see logs/' + target + '.link.log'
                    if binary.exists():
                        binary.unlink()
        if metadata['status'] != 'OK':
            failures += 1
        metadata_path.write_text(json.dumps(metadata, indent=2) + '\n')
        print(target + ': ' + (str(metadata['module_bytes']) + ' bytes'
                              if metadata['status'] == 'OK' else metadata['reason']))
    sizes()
    return 1 if failures else 0


def sizes():
    fields = ['target', 'optimization', 'status', 'module_bytes', 'data_bytes',
              'runtime_tested', 'built_at', 'context_sha256']
    rows = []
    for path in sorted((ROOT / 'out').glob('*/*.json')):
        if path.name == 'context.json':
            continue
        metadata = json.loads(path.read_text())
        context_path = path.parent / 'contexts' / (metadata['context_sha256'] + '.json')
        if digest(context_path) != metadata['context_sha256']:
            raise ValueError('Build context changed: ' + str(context_path))
        if metadata['status'] == 'OK':
            info = module_info(path.parent / metadata['target'])
            if info['module_sha256'] != metadata['module_sha256']:
                raise ValueError('Binary changed since measurement: ' + str(path))
        rows.append({k: metadata[k] for k in fields})
    with (ROOT / 'results.csv').open('w', newline='') as stream:
        writer = csv.DictWriter(stream, fields)
        writer.writeheader()
        writer.writerows(rows)
    print('\ntarget           opt   status       module    data')
    for row in rows:
        print('{target:16} {optimization:5} {status:10} {module_bytes!s:>8} {data_bytes!s:>7}'.format(**row))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('action', choices=['build', 'sizes', 'targets'])
    parser.add_argument('--opt', default='Os', choices=['O0', 'O1', 'O2', 'O3', 'Os', 'Oz'])
    parser.add_argument('--target', default='all')
    parser.add_argument('--jobs', type=int, default=8)
    args = parser.parse_args()
    try:
        if args.jobs < 1:
            raise ValueError('jobs must be positive')
        if args.action == 'build':
            return build(args)
        if args.action == 'sizes':
            sizes()
        else:
            print('\n'.join(sorted(json.loads((ROOT / 'targets.json').read_text()))))
    except (ValueError, OSError, subprocess.CalledProcessError) as error:
        print('Build failed: ' + str(error), file=sys.stderr)
        return 1
    return 0


if __name__ == '__main__':
    sys.exit(main())
