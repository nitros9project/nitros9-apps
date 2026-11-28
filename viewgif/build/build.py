#!/usr/bin/env python3
"""Build ViewGIF and ViewVEF as validated OS-9/6809 modules."""
import argparse
import json
import os
from pathlib import Path
import shlex
import shutil
import subprocess
import sys

ROOT=Path(__file__).resolve().parents[1]
REPO=ROOT.parent
sys.path.insert(0,str(REPO/'build-support'))
from os9_module import module_info
SOURCES=['viewgif.c','gifwin.c','setmap.c','viewvef.c']
TARGETS={'viewgif':['viewgif','gifwin','setmap'],'viewvef':['viewvef']}


def run(command,cwd,log):
    command=list(map(str,command))
    log.write('$ '+shlex.join(command)+'\n');log.flush()
    subprocess.run(command,cwd=cwd,stdout=log,stderr=subprocess.STDOUT,check=True)


def build(args):
    out=ROOT/'build/out'/args.compiler/args.opt
    out.mkdir(parents=True,exist_ok=True)
    for name in TARGETS:
        (out/name).unlink(missing_ok=True)
        (out/(name+'.json')).unlink(missing_ok=True)
    work=out/'src'
    if work.exists():shutil.rmtree(work)
    shutil.copytree(ROOT/'src',work)
    logs=out/'logs';logs.mkdir(exist_ok=True)
    env=os.environ
    if args.compiler=='c3':
        compiler=env.get('C3','c3');suffix='.r'
        os.environ['C3_ASM']=str(ROOT/'build/c3-as.py')
        base=[compiler,'-dVIEWGIF_C3','-r']
        link=[compiler];extra=[]
    elif args.compiler=='cmoc':
        compiler=env.get('CMOC','cmoc');suffix='.o'
        lib=Path(env.get('CMOC_OS9_DIR',REPO.parent/'nitros9-c-libs')).resolve()
        if not (lib/'lib/libc.a').is_file():raise ValueError('Set CMOC_OS9_DIR to a built nitros9-c-libs checkout')
        base=[compiler,'--os9','-DVIEWGIF_CMOC','--add-os9-stack-space=4096','-I'+str(lib/'include'),'-Wno-const']
        link=[compiler,'--os9','--add-os9-stack-space=4096'];extra=['-L'+str(lib/'lib'),'-lc']
    else:
        compiler=env.get('LLVM_CC','clang');suffix='.o'
        sysroot=Path(env.get('LLVM_SYSROOT',REPO.parent/'picolibc/builddir-mc6809-os9-Os/stage/usr/local')).resolve()
        compat=Path(env.get('LLVM_OS9_COMPAT_ROOT',REPO.parent/'nitros9-c-libs/llvm')).resolve()
        library=Path(env.get('LLVM_OS9_COMPAT_LIB',out/'compat/libcmoc_os9_compat.a')).resolve()
        if not (sysroot/'include/stdio.h').is_file():raise ValueError('Set LLVM_SYSROOT to OS-9 picolibc')
        if 'LLVM_OS9_COMPAT_LIB' not in env:
            cc=shutil.which(compiler)
            if not cc:raise ValueError('LLVM_CC not found')
            with (logs/'compat.log').open('w') as log:
                run(['make','-j'+str(args.jobs),'-C',compat,'LLVM_BIN='+str(Path(cc).resolve().parent),'OS9_SYSROOT='+str(sysroot),'OPT='+args.opt,'OUT='+str(out/'compat')],work,log)
        if not library.is_file():raise ValueError('Missing LLVM compatibility library '+str(library))
        base=[compiler,'--target=mc6809-unknown-os9','--sysroot='+str(sysroot),'-'+args.opt,'-std=gnu89','-DVIEWGIF_LLVM','-I'+str(compat/'include'),'-ffunction-sections','-fdata-sections','-Wno-return-type']
        link=base;extra=[library,'-Wl,--gc-sections','-Wl,--defsym=__stack_size=1024','-Wl,-Map='+str(out/'viewgif.map')]
    sources=SOURCES+(['numbers.c'] if args.compiler=='llvm' else [])
    failed=[]
    for name in sources:
        obj=Path(name).with_suffix(suffix)
        with (logs/(name+'.log')).open('w') as log:
            try:
                cmd=base+[name] if args.compiler=='c3' else base+['-c' if args.compiler=='llvm' else '--compile','-o',obj,name]
                if args.compiler=='llvm' and args.opt=='Oz' and name=='setmap.c':
                    # Current LLVM-MC6809 rejects setmap2 at -Oz with its
                    # PHANTOM_CARRY invariant guard. Keep this file at -Os.
                    cmd=['-Os' if str(arg)=='-Oz' else arg for arg in cmd]
                run(cmd,work,log)
            except subprocess.CalledProcessError:failed.append(name)
    if failed:raise ValueError('Compile failed: '+', '.join(failed)+'; see '+str(logs))
    if args.compiler!='llvm':
        real=shutil.which('lwlink')
        if not real:raise ValueError('lwlink not found')
        wrappers=out/'tools';wrappers.mkdir(exist_ok=True)
        wrapper=wrappers/'lwlink'
        shutil.copyfile(ROOT/'build/lwlink-map.py',wrapper);wrapper.chmod(0o755)
        env['VIEWGIF_REAL_LWLINK']=str(Path(real).resolve())
        env['PATH']=str(wrappers)+os.pathsep+env.get('PATH','')
        if args.compiler=='cmoc':link=link+['--lwlink='+str(wrapper)]
    for name,stems in TARGETS.items():
        env['VIEWGIF_LINK_MAP']=str(out/(name+'.map'))
        objects=[stem+suffix for stem in stems]+(['numbers'+suffix] if args.compiler=='llvm' else [])
        command=link+objects+['-f='+name] if args.compiler=='c3' else link+['-o',name]+objects+[('-Wl,-Map='+str(out/(name+'.map'))) if str(arg).startswith('-Wl,-Map=') else arg for arg in extra]
        with (logs/(name+'.link.log')).open('w') as log:run(command,work,log)
        binary=work/name;info=module_info(binary)
        # One of the eight logical 8 KiB slots must remain for the GP buffer.
        blocks=(info['module_bytes']+8191)//8192+(info['data_bytes']+8191)//8192
        if blocks>7:raise ValueError(name+' leaves no 8 KiB slot for graphics mapping')
        info['process_blocks']=blocks
        data=binary.read_bytes();offset=int.from_bytes(data[4:6],'big');encoded=name[:-1].encode()+bytes([ord(name[-1])|128])
        if data[offset:offset+len(encoded)]!=encoded:raise ValueError('Wrong OS-9 module name')
        binary.replace(out/name)
        info.update(compiler=args.compiler,optimization=args.opt,runtime_tested=False,
                    file_optimizations={source:('Os' if args.compiler=='llvm' and args.opt=='Oz' and source=='setmap.c' else args.opt if args.compiler=='llvm' else 'compiler default') for source in sources})
        (out/(name+'.json')).write_text(json.dumps(info,indent=2)+'\n')
        print(args.compiler,name,info['module_bytes'],'module bytes,',info['data_bytes'],'data bytes',flush=True)
    return 0


def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--compiler',choices=('c3','cmoc','llvm'),default='c3')
    p.add_argument('--opt',choices=('Os','Oz','O0','O1','O2','O3'),default='Os')
    p.add_argument('--jobs',type=int,default=8)
    args=p.parse_args()
    try:
        if args.jobs<1:raise ValueError('jobs must be positive')
        return build(args)
    except (ValueError,OSError,subprocess.CalledProcessError) as error:
        print('Build failed:',error,file=sys.stderr);return 1


if __name__=='__main__':raise SystemExit(main())
