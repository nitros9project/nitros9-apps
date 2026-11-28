#!/usr/bin/env python3
"""Build and validate OS-9 Kermit with C3, CMOC or LLVM-MC6809."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import shlex
import shutil
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]
REPO = ROOT.parent
SOURCES = ['os9cli.c', 'os9cmd.c', 'os9con.c', 'os9ker.c', 'os9rec.c',
           'os9sen.c', 'os9srv.c', 'os9utl.c']


def module_info(path):
    data = path.read_bytes()
    if len(data) < 16 or data[:2] != b'\x87\xcd':
        raise ValueError('Not an OS-9 module')
    size = int.from_bytes(data[2:4], 'big')
    if size != len(data) or data[6] != 0x11:
        raise ValueError('Invalid module length or program type')
    parity = 0
    for byte in data[:9]:
        parity ^= byte
    if parity != 255:
        raise ValueError('Invalid module header parity')
    crc = 0xffffff
    for byte in data:
        crc ^= byte << 16
        for _ in range(8):
            crc <<= 1
            if crc & 0x1000000:
                crc ^= 0x800063
            crc &= 0xffffff
    if crc != 0x800fe3:
        raise ValueError('Invalid module CRC')
    return dict(module_bytes=size, data_bytes=int.from_bytes(data[11:13], 'big'),
                module_sha256=hashlib.sha256(data).hexdigest(), crc_valid=True)


def run(command, cwd, log, env):
    log.write('$ ' + shlex.join(map(str, command)) + '\n')
    log.flush()
    subprocess.run(list(map(str, command)), cwd=cwd, env=env, stdout=log,
                   stderr=subprocess.STDOUT, check=True)


def build(args):
    if args.compiler == 'vbcc':
        if args.opt != 'Os':raise ValueError('VBCC builds currently require --opt Os')
        return subprocess.call([sys.executable, str(REPO/'build-support/vbcc.py'), '--package', 'kermit', '--ticks', str(args.ticks)])
    env = os.environ.copy()
    out = ROOT / 'build/out' / args.compiler / args.opt
    out.mkdir(parents=True, exist_ok=True)
    binary = out / 'kermit'
    binary.unlink(missing_ok=True)
    (out / 'module.json').unlink(missing_ok=True)
    work = out / 'src'
    if work.exists():
        shutil.rmtree(work)
    work.mkdir()
    sources = SOURCES + (['message.c'] if args.compiler != 'c3' else [])
    for name in [*sources, 'os9inc.h', 'message.h']:
        shutil.copyfile(ROOT / name, work / name)
    logs = out / 'logs'
    logs.mkdir(exist_ok=True)
    if args.compiler == 'c3':
        compiler = env.get('C3', 'c3')
        base = [compiler, '-r', '-dCOCO', '-dKERMIT_HOST', '-dKERMIT_TPS=' + str(args.ticks)]
        suffix = '.r'
        link = [compiler]
        end = ['-f=kermit', '-m=1k']
    elif args.compiler == 'cmoc':
        compiler = env.get('CMOC', 'cmoc')
        library = Path(env.get('CMOC_OS9_DIR', REPO.parent / 'nitros9-c-libs')).resolve()
        if not (library / 'lib/libc.a').is_file():
            raise ValueError('Build CMOC libc.a first; set CMOC_OS9_DIR')
        base = [compiler, '--os9', '--add-os9-stack-space=4096', '-I' + str(library / 'include'), '-DCOCO',
                '-DKERMIT_HOST', '-DKERMIT_MODERN', '-DCMOC_KR_COMPAT',
                '-DKERMIT_TPS=' + str(args.ticks), '-Waccept-word-sized-return-type-mismatch', '-Wno-const']
        suffix = '.o'
        link = [compiler, '--os9', '--add-os9-stack-space=4096', '-o', 'kermit']
        end = ['-L' + str(library / 'lib'), '-lc']
    else:
        compiler = env.get('LLVM_CC', 'clang')
        sysroot = Path(env.get('LLVM_SYSROOT', REPO.parent / 'picolibc/builddir-mc6809-os9-Os/stage/usr/local')).resolve()
        compat = Path(env.get('LLVM_OS9_COMPAT_ROOT', REPO.parent / 'nitros9-c-libs/llvm')).resolve()
        if not (sysroot / 'include/stdio.h').is_file():
            raise ValueError('Set LLVM_SYSROOT to an OS-9 picolibc installation')
        library = Path(env.get('LLVM_OS9_COMPAT_LIB', out / 'compat/libcmoc_os9_compat.a')).resolve()
        if 'LLVM_OS9_COMPAT_LIB' not in env:
            if not (compat / 'Makefile').is_file():
                raise ValueError('Set LLVM_OS9_COMPAT_ROOT to nitros9-c-libs/llvm')
            resolved_cc = shutil.which(compiler)
            if not resolved_cc:
                raise ValueError('LLVM compiler not found: ' + compiler)
            with (logs / 'compat.log').open('w') as log:
                run(['make', '-j' + str(args.jobs), '-C', compat,
                     'LLVM_BIN=' + str(Path(resolved_cc).resolve().parent),
                     'OS9_SYSROOT=' + str(sysroot), 'OPT=' + args.opt,
                     'OUT=' + str(out / 'compat')], work, log, env)
        if not library.is_file():
            raise ValueError('Missing LLVM OS-9 compatibility library: ' + str(library))
        base = [compiler, '--target=mc6809-unknown-os9', '--sysroot=' + str(sysroot),
                '-' + args.opt, '-std=gnu89', '-ffunction-sections', '-fdata-sections',
                '-I' + str(compat / 'include'), '-DCOCO', '-DKERMIT_HOST',
                '-DKERMIT_MODERN', '-DKERMIT_LLVM', '-DKERMIT_TPS=' + str(args.ticks),
                '-Wno-implicit-int', '-Wno-deprecated-non-prototype',
                '-Wno-implicit-function-declaration']
        suffix = '.o'
        link = base
        end = [library, '-Wl,--gc-sections', '-Wl,-Map=' + str(out / 'kermit.map'), '-o', 'kermit']
    objects = []
    failures = []
    for name in sources:
        obj = Path(name).with_suffix(suffix)
        with (logs / (Path(name).stem + '.log')).open('w') as log:
            try:
                command = base + [name] if args.compiler == 'c3' else base + ['-c' if args.compiler == 'llvm' else '--compile', '-o', obj, name]
                run(command, work, log, env)
                objects.append(obj)
            except subprocess.CalledProcessError:
                failures.append(name)
    if failures:
        raise ValueError('Compile failed: ' + ', '.join(failures) + '; see ' + str(logs))
    with (logs / 'link.log').open('w') as log:
        run([*link, *objects, *end], work, log, env)
    built = work / 'kermit'
    info = module_info(built)
    data = built.read_bytes()
    start = int.from_bytes(data[4:6], 'big')
    if data[start:start + 6] != b'kermi\xf4':
        raise ValueError('Expected OS-9 module name kermit')
    built.replace(binary)
    info.update(compiler=args.compiler, optimization=args.opt, ticks_per_second=args.ticks,
                runtime_tested=False)
    (out / 'module.json').write_text(json.dumps(info, indent=2) + '\n')
    print(str(binary) + ': ' + str(info['module_bytes']) + ' module bytes, ' + str(info['data_bytes']) + ' data bytes; not runtime tested')
    return 0


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', choices=('c3', 'cmoc', 'llvm', 'vbcc'), default='c3')
    parser.add_argument('--opt', choices=('Os', 'Oz', 'O0', 'O1', 'O2', 'O3'), default='Os')
    parser.add_argument('--ticks', type=int, default=60)
    parser.add_argument('--jobs', type=int, default=8)
    args = parser.parse_args()
    try:
        if args.ticks not in (50, 60) or args.jobs < 1:
            raise ValueError('ticks must be 50 or 60 and jobs must be positive')
        return build(args)
    except (OSError, ValueError, subprocess.CalledProcessError) as error:
        print('Build failed: ' + str(error), file=sys.stderr)
        return 1


if __name__ == '__main__':
    sys.exit(main())
