#!/usr/bin/env python3
"""Shared VBCC/vasm/vlink OS-9 application builder."""
import argparse
from concurrent.futures import ThreadPoolExecutor
import hashlib
import json
import os
from pathlib import Path
import re
import shutil
import subprocess
import sys

ROOT=Path(__file__).resolve().parent
REPO=ROOT.parent
sys.path.insert(0,str(ROOT))
from os9_module import module_info

def run(cmd,cwd,log):
    with Path(log).open('a') as f:
        f.write('$ '+repr(list(map(str,cmd)))+'\n');f.flush()
        subprocess.run(list(map(str,cmd)),cwd=cwd,stdout=f,stderr=subprocess.STDOUT,check=True)

def sanitize(s):
    return re.sub(r'\b([A-Za-z_]\w*)\$(\w+)',r'\1__\2',s)

class Toolchain:
    def __init__(self,out):
        self.out=out.resolve();self.out.mkdir(parents=True,exist_ok=True)
        self.root=Path(os.environ['VBCC_ROOT']).resolve()
        self.target=self.root/'targets/6809-os9'
        self.cc=Path(os.environ.get('VBCC_CC',self.root/'bin/vbcchc12')).resolve();self.asm=self.root/'bin/vasm6809_std';self.ld=Path(os.environ.get('VBCC_VLINK',self.root/'bin/vlink')).resolve()
        self.rw=Path(os.environ.get('VBCC_RW_OBJECT',self.target/'lib/bench-rw.o')).resolve()
        if not self.rw.is_file():raise ValueError('Set VBCC_RW_OBJECT to the EOF wrapper produced by vbcc/prepare_runtime.py')
        self.runtime=self.out/'runtime';self.runtime.mkdir(exist_ok=True)
        compat=Path(os.environ.get('VBCC_OS9_COMPAT_ROOT',REPO.parent/'nitros9-c-libs/llvm')).resolve()
        for folder in ('include','src'):
            for path in (compat/folder).glob('*.[ch]'):
                s=path.read_text()
                if 'include_next' in s:continue
                s=sanitize(s)
                if path.name=='os9abi.h':
                    s=re.sub(r'^#define (\w+)([^\n]*)$',lambda m:'#ifndef '+m[1]+'\n'+m[0]+'\n#endif',s,flags=re.M)
                if path.name=='files.c':
                    s=s.replace('extern char __os9_progname[];', 'char *vb_progname(void);').replace('return __os9_progname;', 'return vb_progname();')
                (self.runtime/path.name).write_text(s)
        if not (self.runtime/'kernel.c').is_file():raise ValueError('VBCC_OS9_COMPAT_ROOT must contain nitros9-c-libs/llvm sources')
        (self.runtime/'os9.h').write_text('#ifndef APPS_VBCC_OS9_H\n#define APPS_VBCC_OS9_H\n#include "'+str(self.target/'include/os9.h')+'"\n#endif\n')
        self.inc=['-I'+str(self.runtime),'-I'+str(ROOT/'vbcc/include'),'-I'+str(self.target/'include')]
    def compile(self,source,out,defs=()):
        source=Path(source).resolve();out=Path(out).resolve();out.parent.mkdir(parents=True,exist_ok=True)
        assembly=out.with_suffix('.s');log=out.with_suffix('.log');log.write_text('')
        run([self.cc,'-cpu=6809','-DAPPS_VBCC','-pcrel','-drel','-O=1023',*self.inc,*defs,source,'-o='+str(assembly)],source.parent,log)
        # Give each function a code section so vlink can discard unused API wrappers.
        s=assembly.read_text()
        for name in re.findall(r'\.type\s+([\w.]+),@function',s):
            s=re.sub(r'^'+re.escape(name)+r':',lambda m:'\t.section .text.'+name+',"acrx"\n'+m[0],s,flags=re.M)
        assembly.write_text(s)
        run([self.asm,'-quiet','-Fvobj','-nowarn=62','-opt-branch','-opt-offset',assembly,'-o',out],source.parent,log)
        return out
    def build_runtime(self):
        sources=['kernel','files','extensions','calendar','commands','signals','modules','password','pattern','chcodes','diagnostics','compat']
        tasks=[(self.runtime/(n+'.c'),self.runtime/(n+'.o')) for n in sources]
        getopt=Path(os.environ.get('VBCC_OS9_COMPAT_ROOT',REPO.parent/'nitros9-c-libs/llvm')).resolve().parent/'lib/getopt.c'
        (self.runtime/'getopt.c').write_text(getopt.read_text().replace('#include <arg.h>','').replace('getopt(', 'vb_getopt(').replace('optind','vb_optind').replace('opterr','vb_opterr').replace('optarg','vb_optarg').replace('optopt','vb_optopt'))
        tasks.append((self.runtime/'getopt.c',self.runtime/'getopt.o'))
        tasks.append((ROOT/'vbcc/bridge.c',self.runtime/'bridge.o'))
        def one(pair):
            try:return self.compile(*pair,defs=['-DCMOC_HOST_TEST'])
            except subprocess.CalledProcessError:return None
        with ThreadPoolExecutor(max_workers=8) as pool:objects=list(pool.map(one,tasks))
        failures=[str(p[0]) for p,obj in zip(tasks,objects) if obj is None]
        if failures:raise ValueError('Runtime compile failed: '+', '.join(failures))
        native=self.runtime/'native.o';log=native.with_suffix('.log');log.write_text('')
        run([self.asm,'-quiet','-Fvobj',ROOT/'vbcc/native.s','-o',native],self.runtime,log)
        return objects+[native]
    def archive(self,objects,name):
        path=self.runtime/(name+'.a')
        with path.open('wb') as f:
            f.write(b'!<arch>\n')
            for i,obj in enumerate(objects):
                data=Path(obj).read_bytes();member='o%d.o/'%i
                header=f'{member:<16}{0:<12}{0:<6}{0:<6}{"100644":<8}{len(data):<10}`\n'
                f.write(header.encode());f.write(data)
                if len(data)%2:f.write(b'\n')
        return path
    def link(self,objects,name,out,extra=()):
        dest=Path(out).resolve()/name;dest.unlink(missing_ok=True)
        log=dest.with_suffix('.map');log.write_text('')
        run([self.ld,'-bos9-6809','-gc-all','-P__modname','-M','-L'+str(self.target/'lib'),self.target/'lib/startup.o',self.rw,*objects,*extra,'-o',dest,'-lvc','-los9'],dest.parent,log)
        info=module_info(dest)
        data=dest.read_bytes();offset=int.from_bytes(data[4:6],'big')
        encoded=name[:-1].encode()+bytes([ord(name[-1])|128])
        if data[offset:offset+len(encoded)]!=encoded:raise ValueError('Wrong OS-9 module name: '+name)
        blocks=(info['module_bytes']+8191)//8192+(info['data_bytes']+8191)//8192
        if blocks>8:raise ValueError(name+' exceeds the OS-9 process address space')
        info.update(compiler='vbcc',optimization='O=1023',runtime_tested=False,process_blocks=blocks,compiler_sha256=hashlib.sha256(self.cc.read_bytes()).hexdigest(),linker_sha256=hashlib.sha256(self.ld.read_bytes()).hexdigest())
        (dest.with_suffix('.json')).write_text(json.dumps(info,indent=2)+'\n')
        print(name,info['module_bytes'],'bytes',flush=True)
        return dest

TARGETS={
 'sled':('sled/src', ['sled.c']+['sled%d.c'%i for i in range(1,7)]+['sled_port.c'],['-DSLED_VBCC']),
 'viewgif':('viewgif/src',['viewgif.c','gifwin.c','setmap.c','numbers.c'],['-DVIEWGIF_VBCC','-DVIEWGIF_TEST_NUMBERS']),
 'viewvef':('viewgif/src',['viewvef.c','numbers.c'],['-DVIEWGIF_VBCC','-DVIEWGIF_TEST_NUMBERS']),
 'kermit':('kermit',['os9cli.c','os9cmd.c','os9con.c','os9ker.c','os9rec.c','os9sen.c','os9srv.c','os9utl.c','message.c'],['-DCOCO','-DKERMIT_HOST','-DKERMIT_MODERN','-DKERMIT_VBCC','-DKERMIT_TPS=60']),
 'uniq':('kreider/uniq',['uniq.c'],[]),
 'cb':('kreider/cb',['cb.c'],[]),
 'ppc':('kreider/ppc',['ppc.c'],[]),
 'dgrep':('kreider/dgrep',['grep.c'],[]),
 'lb':('kreider/lb',['lb.c'],[]),
 'ed':('ed',None,[]),
 'sort':('sort',None,[]),
 'mroff':('mroff/mroff',None,[]),
 'man':('mroff/man',['man.c'],['-Dgetopt=vb_getopt','-Doptind=vb_optind','-Dopterr=vb_opterr','-Doptarg=vb_optarg']),
 'umacs':('uemacs',None,['-DOS9','-DANSI']),
 'umacsc':('uemacs',None,['-DOS9','-DCOCO']),
}

UUCP_TARGETS=json.loads((REPO/'uucpbb/build-llvm/targets.json').read_text())
for _name,_sources in UUCP_TARGETS.items():
    TARGETS[_name]=('uucpbb/src',_sources,['-D_VOID_','-Dm6809','-DOS9','-DSHELLPLUS','-DNEWCLIB','-DUSE_C_G_CHKSUM'])

def prepare(tc):
    tree=tc.out/'source'
    if tree.exists():shutil.rmtree(tree)
    for folder in sorted(set(cfg[0] for cfg in TARGETS.values())):
        dest=tree/folder;dest.mkdir(parents=True,exist_ok=True)
        for source in (REPO/folder).glob('*'):
            if source.suffix not in ('.c','.h'):continue
            shutil.copyfile(source,dest/source.name)
        if folder=='uucpbb/src':shutil.copytree(REPO/folder/'header',dest/'header')
    log=tc.out/'prepare.log';log.write_text('')
    run(['patch','--batch','-p1','-i',ROOT/'vbcc/portable.patch'],tree,log)
    run(['patch','--batch','-p1','-i',REPO/'uucpbb/build-llvm/patches/llvm.patch'],tree/'uucpbb/src',log)
    for source in tree.rglob('*'):
        if source.suffix not in ('.c','.h'):continue
        folder=source.parent.relative_to(tree).as_posix()
        text=source.read_text()
        text=sanitize(text)
        text=text.replace('bench_getime','getime')
        text=text.replace('defined(__clang__)', 'defined(__clang__) || defined(APPS_VBCC)')
        text=re.sub(r'__attribute__\s*\(\([^)]*\)\)','',text)
        text=re.sub(r',\s*atol\(\)', '',text)
        text=re.sub(r'\bNULL\b','0',text)
        text=re.sub(r'EXTERN int\s+errno;[^\n]*','',text)
        text=re.sub(r'^#define (E_FULL|isblank|SS_SIZE)\b',r'#undef \1\n#define \1',text,flags=re.M)
        if folder=='mroff/mroff':
            text=text.replace("worked = index(p, '\\b')","worked = (index(p, '\\b') != 0)")
            text=text.replace('listp->mlink','(*listp)->mlink').replace('malloc(strlen(p + 1))','malloc(strlen(p) + 1)')
            text=re.sub(r'^leadbl\(', 'char *leadbl(',text,flags=re.M)
            if source.name=='nro.h':text+='\nchar *leadbl();\n'
        if folder=='uemacs':
            text=re.sub(r'((?:\b\w+->\w+\s*=\s*(?:/\*.*?\*/\s*)?){2,})0;',lambda m:' '.join(n+' = 0;' for n in re.findall(r'(\w+->\w+)\s*=',m[1])),text,flags=re.S)
            text=text.replace('kbdmip == kbdm[NKBDM-6]','kbdmip >= &kbdm[NKBDM-6]')
            text=text.replace('#define BENCH_STREAM 1','')
            if source.name=='ueansi.c':text=text.replace('        ansisize();','        if(__isatty(0)) ansisize();')
            if source.name=='uetermio.c':
                text=text.replace('ttopen()\n{','ttopen()\n{\n        if(!__isatty(0)) return 0;').replace('ttclose()\n{','ttclose()\n{\n        if(!__isatty(0)) return 0;')
            text=re.sub(r'(stdin|stdout)->_flag [^;]+;',lambda m:m[1]+'->flags &= ~(_CLE|_LINEBUF);',text)
        if folder=='viewgif/src':
            if source.name=='port.h':text=text.replace('#ifdef VIEWGIF_CMOC','#if defined(VIEWGIF_CMOC) || defined(VIEWGIF_VBCC)')
            text=text.replace('fopen(argv[1],"r")','fopen(argv[1],"rb")')
        if source.name=='uudecode.c':
            text=text.replace("dest[sizeof (dest) - 1] = '\\0';", "dest[sizeof (dest) - 1] = '\\0';\n               dest[strcspn(dest, \"\\r\\n\")] = 0;")
            text=text.replace('fopen (dest, "w")','fopen (dest, "wb")')
        if source.name=='uuencode.c':
            text=text.replace('fopen (argv[2], "r")','fopen (argv[2], "rb")').replace('in = stdin;','in = stdin;\n     stdin->flags &= ~_CLE;')
        # VBCC's errno is an unsigned byte in its direct-page runtime.
        text=re.sub(r'^\s*extern int\s+errno;[^\n]*','',text,flags=re.M)
        source.write_text(text)
    for source in tree.rglob('*.c'):
        if source.relative_to(tree).parts[0]!='sled':
            source.write_text('#include \"'+str(ROOT/'vbcc/include/port.h')+'\"\n'+source.read_text())
    return tree

def build_apps(tc,selected,install=False,ticks=60):
    runtime=tc.build_runtime();tree=prepare(tc)
    failed=[]
    for name in selected:
        folder,names,defs=TARGETS[name]
        if name=='kermit':defs=[d.replace('KERMIT_TPS=60','KERMIT_TPS='+str(ticks)) for d in defs]
        dest=tc.out/name;dest.mkdir(exist_ok=True)
        source=tree/folder
        if names is None:
            names=sorted(p.name for p in source.glob('*.c'))
            if name in ('umacs','umacsc'):
                names=[n for n in names if n not in ('ueansi.c','uecoco.c','uetcap.c','uevt52.c')]
                names+=['ueansi.c' if name=='umacs' else 'uecoco.c']
        if folder=='uucpbb/src':defs=defs+['-I'+str(source/'header')]
        (dest/name).unlink(missing_ok=True)
        (dest/(name+'.json')).unlink(missing_ok=True)
        package=REPO/folder.split('/')[0]/'build/out/vbcc/Os'
        package.mkdir(parents=True,exist_ok=True)
        for suffix in ('','.json'):(package/(name+suffix)).unlink(missing_ok=True)
        objects=[];errors=[]
        for n in names:
            try:objects.append(tc.compile(source/n,dest/Path(n).with_suffix('.o'),defs))
            except subprocess.CalledProcessError:errors.append(n)
        if errors:
            failed.append(name);print(name,'compile failed:',','.join(errors),flush=True);continue
        try:
            archive=tc.archive([o for o in runtime if not (folder=='uucpbb/src' and o.stem=='password')], 'uucp' if folder=='uucpbb/src' else 'apps')
            tc.link([*objects,archive],name,dest)
            for suffix in ('','.json','.map'):shutil.copyfile(dest/(name+suffix),package/(name+suffix))
            if install and not folder.startswith('uucpbb/'):
                where=REPO/folder
                if where.name=='src':where=where.parent
                shutil.copyfile(dest/name,where/name)
        except (ValueError,subprocess.CalledProcessError):
            for suffix in ('','.json'):(dest/(name+suffix)).unlink(missing_ok=True)
            failed.append(name);print(name,'link failed',flush=True)
    if failed:raise ValueError('Failed targets: '+', '.join(failed))

def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--runtime-only',action='store_true')
    p.add_argument('--out',type=Path,default=ROOT/'vbcc/out')
    p.add_argument('--target',default='all')
    p.add_argument('--package')
    p.add_argument('--install',action='store_true')
    p.add_argument('--ticks',type=int,default=60)
    a=p.parse_args()
    if a.runtime_only:Toolchain(a.out).build_runtime();return
    selected=([n for n,(folder,_,_) in TARGETS.items() if folder.split('/')[0]==a.package] if a.package else list(TARGETS) if a.target=='all' else a.target.split(','))
    if not selected or a.ticks<1:p.error('invalid package or tick rate')
    if any(n not in TARGETS for n in selected):p.error('unknown target')
    # Invalidate published outputs even if toolchain/runtime preparation fails.
    for name in selected:
        folder=TARGETS[name][0].split('/')[0]
        for dest in (a.out.resolve()/name/name,REPO/folder/'build/out/vbcc/Os'/name):
            for suffix in ('','.json','.map'):dest.with_name(dest.name+suffix).unlink(missing_ok=True)
    tc=Toolchain(a.out)
    build_apps(tc,selected,a.install,a.ticks)
if __name__=='__main__':
    try:main()
    except (OSError,ValueError,KeyError,subprocess.CalledProcessError) as error:
        print('Build failed:',error,file=sys.stderr);raise SystemExit(1)
