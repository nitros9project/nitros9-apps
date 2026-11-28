#!/usr/bin/env python3
"""Build UUCPbb's C commands with C3, CMOC, LLVM, or VBCC."""
import argparse
import importlib.util
import json
import os
import re
from pathlib import Path
import shlex
import shutil
import subprocess
import sys

ROOT = Path(__file__).resolve().parent
PACKAGE = ROOT.parent
SHELF = PACKAGE.parents[1]
spec = importlib.util.spec_from_file_location('llvm_build', PACKAGE / 'build-llvm/build.py')
llvm = importlib.util.module_from_spec(spec)
spec.loader.exec_module(llvm)


def run(command, cwd, log, env):
    log.write('$ ' + shlex.join(map(str, command)) + '\n')
    log.flush()
    subprocess.run(list(map(str, command)), cwd=cwd, env=env, stdout=log,
                   stderr=subprocess.STDOUT, check=True)


def build(args):
    env = os.environ.copy()
    env['PATH'] = str(SHELF / 'bin') + os.pathsep + env.get('PATH', '')
    if args.compiler == 'vbcc':
        if args.opt != 'Os':raise ValueError('VBCC builds currently require --opt Os')
        targets=json.loads((PACKAGE/'build-llvm/targets.json').read_text())
        if args.target!='all' and args.target not in targets:raise ValueError('Unknown target: '+args.target)
        selection=['--package','uucpbb'] if args.target=='all' else ['--target',args.target]
        return subprocess.call([sys.executable,str(PACKAGE.parent/'build-support/vbcc.py'),*selection],env=env)
    if args.compiler == 'llvm':
        return subprocess.call([sys.executable, str(PACKAGE / 'build-llvm/build.py'),
                                'build', '--target', args.target, '--opt', args.opt,
                                '--jobs', str(args.jobs)], env=env)
    targets = json.loads((PACKAGE / 'build-llvm/targets.json').read_text())
    selected = sorted(targets) if args.target == 'all' else [args.target]
    if any(t not in targets for t in selected):
        raise ValueError('Unknown target: ' + args.target)
    compiler = shutil.which(env.get(args.compiler.upper(), args.compiler), path=env['PATH'])
    if not compiler:
        raise ValueError('Compiler not found; set ' + args.compiler.upper())
    out = ROOT / 'out' / args.compiler
    out.mkdir(parents=True, exist_ok=True)
    # Invalidate selected binaries before any preparation or compilation can fail.
    for target in selected:
        (out / target).unlink(missing_ok=True)
    work = out / 'src'
    if work.exists():
        shutil.rmtree(work)
    source = Path(env.get('UUCPBB_SOURCE', PACKAGE)).resolve()
    shutil.copytree(source / 'src', work)
    logs = out / 'logs'
    logs.mkdir(exist_ok=True)
    with (logs / 'patch.log').open('w') as log:
        run(['patch', '--batch', '-p1', '-i', ROOT / ('patches/' + args.compiler + '.patch')], work, log, env)
    if args.compiler == 'c3':
        env.setdefault('C3BASE', str(SHELF / 'nitros9-languages/c3'))
        if not (Path(env['C3BASE']) / 'defs/stdio.h').is_file():
            raise ValueError('C3BASE must contain defs/stdio.h: ' + env['C3BASE'])
        base = [compiler, '-r', '-dOS9', '-dm6809', '-dSHELLPLUS', '-dNEWCLIB', '-d_VOID_']
        suffix = '.r'
    else:
        library = Path(env.get('CMOC_OS9_DIR', SHELF / 'nitros9-c-libs')).resolve()
        if not (library / 'lib/libc.a').is_file():
            raise ValueError('Build the CMOC C library first; set CMOC_OS9_DIR')
        base = [compiler, '--os9', '-I' + str(library / 'include'), '-I' + str(work),
                '-DOS9', '-DSHELLPLUS', '-DNEWCLIB', '-D_VOID_', '-DCMOC_KR_COMPAT',
                '-DUSE_C_G_CHKSUM', '-Waccept-word-sized-return-type-mismatch', '-Wno-const']
        suffix = '.o'
        # UUCPbb supplies getopt and password functions itself. Do not link the
        # competing library implementations (which export additional symbols).
        archive = out / 'libc-uucpbb.a'
        members = subprocess.check_output(['lwar', '--list', 'libc.a'], cwd=library / 'lib', env=env, text=True)
        members = [line.split(':')[0].strip() for line in members.splitlines()]
        members = [name for name in members if Path(name).stem not in ('getopt', 'pwent')]
        archive.unlink(missing_ok=True)
        with (logs / 'archive.log').open('w') as log:
            run(['lwar', '-c', archive, *members], library / 'lib', log, env)
    compiled = {}
    for name in sorted({name for target in selected for name in targets[target]}):
        with (logs / (Path(name).stem + '.compile.log')).open('w') as log:
            try:
                command = base + [name] if args.compiler == 'c3' else base + ['--intermediate', '--compile', '-o', Path(name).with_suffix(suffix), name]
                run(command, work, log, env)
                compiled[name] = True
            except subprocess.CalledProcessError:
                compiled[name] = False
                log.flush()
                diagnostics = Path(log.name).read_text()
                assembly_errors = [line for line in diagnostics.splitlines() if ' : ERROR : ' in line]
                if args.compiler == 'cmoc' and assembly_errors and all('Byte overflow' in line for line in assembly_errors) and (work / Path(name).with_suffix('.s')).exists():
                    assembly = work / Path(name).with_suffix('.s')
                    long_assembly = assembly.with_suffix('.long.s')
                    long_assembly.write_text(re.sub(r'(?m)^(\s*)B(EQ|NE|HI|LS|CC|HS|CS|LO|VC|VS|PL|MI|GE|LT|GT|LE)\b', r'\1LB\2', assembly.read_text()))
                    try:
                        run(['lwasm', '-fobj', '--pragma=forwardrefmax', '-DOS9', '--output=' + str(Path(name).with_suffix(suffix)), long_assembly], work, log, env)
                        compiled[name] = True
                        continue
                    except subprocess.CalledProcessError:
                        pass
                print('Compile failed: ' + name + ' (see ' + str(log.name) + ')')
    failures = 0
    for target in selected:
        binary = out / target
        if any(not compiled[name] for name in targets[target]):
            failures += 1
            print(target + ': BUILDFAIL (compile)')
            continue
        objects = [Path(name).with_suffix(suffix) for name in targets[target]]
        if args.compiler == 'c3':
            command = [compiler, *objects, '-f=' + target, '-m=2k']
        else:
            command = [compiler, '--os9', '-o', target, *objects, '-L' + str(out), '-lc-uucpbb']
        with (logs / (target + '.link.log')).open('w') as log:
            try:
                run(command, work, log, env)
                built = work / target
                info = llvm.module_info(built)
                data = built.read_bytes()
                offset = int.from_bytes(data[4:6], 'big')
                name = bytearray()
                for byte in data[offset:]:
                    name.append(byte & 127)
                    if byte & 128:
                        break
                if name.decode('ascii') != target:
                    raise ValueError('Module name does not match command: ' + name.decode('ascii'))
                built.replace(binary)
                print(target + ': ' + str(info['module_bytes']) + ' bytes (not runtime tested)')
            except (subprocess.CalledProcessError, ValueError) as error:
                failures += 1
                binary.unlink(missing_ok=True)
                print(target + ': BUILDFAIL (' + str(error) + '; see ' + log.name + ')')
    return 1 if failures else 0


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', choices=('c3', 'cmoc', 'llvm', 'vbcc'), default='c3')
    parser.add_argument('--target', default='all')
    parser.add_argument('--opt', default='Os', choices=('O0', 'O1', 'O2', 'O3', 'Os', 'Oz'))
    parser.add_argument('--jobs', default=8, type=int)
    args = parser.parse_args()
    try:
        if args.jobs < 1:
            raise ValueError('jobs must be positive')
        return build(args)
    except (OSError, ValueError, subprocess.CalledProcessError) as error:
        print('Build failed: ' + str(error), file=sys.stderr)
        return 1


if __name__ == '__main__':
    sys.exit(main())
