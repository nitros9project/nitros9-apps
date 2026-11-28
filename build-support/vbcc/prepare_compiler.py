#!/usr/bin/env python3
"""Build a private VBCC compiler with the local frontend and backend fixes."""
import argparse
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
p=argparse.ArgumentParser(description=__doc__)
p.add_argument('--stock',action='store_true',help='Build supplied sources without applying local patches')
p.add_argument('--source',type=Path,required=True)
p.add_argument('--out',type=Path,default=Path(__file__).resolve().parent/'out/compiler')
a=p.parse_args();source=a.source.resolve();out=a.out.resolve()
if out==source or source in out.parents or out in source.parents:raise SystemExit('Use a separate output directory')
if out.exists():raise SystemExit('Output exists; select a new directory')
shutil.copytree(source,out,ignore=shutil.ignore_patterns('.git','objects','bin'))
(out/'bin').mkdir();(out/'objects/hc12').mkdir(parents=True)
cc='cc -std=c99 -O2 -Wno-format-security -Wno-error=implicit-function-declaration -Wno-error=int-conversion'
commands=[['patch','--batch','-p1','-i',str(Path(__file__).resolve().parent/'patches/vbcc-pointer-subtract.patch')],
          ['make','TARGET=hc12','CC='+cc,'bin/dtgen'],
          ['bin/dtgen','machines/hc12/machine.dt','objects/hc12/dt.h','objects/hc12/dt.c'],
          ['make','-j4','TARGET=hc12','CC='+cc,'bin/vbcchc12']]
if a.stock:commands=commands[1:]
else:
    commands.insert(1,['patch','--batch','-p1','-i',str(Path(__file__).resolve().parent/'patches/vbcc-acc-restore.patch')])
    frontend=hashlib.sha256((source/'type_expr.c').read_bytes()).hexdigest()
    if frontend=='3efdd0064263dfdb68a53edf6abf45ed546b272451c3107db2106ab304005b91':
        commands.insert(0,['patch','--batch','-p1','-i',str(Path(__file__).resolve().parent/'patches/vbcc-array-offset.patch')])
    elif frontend!='4e1d4726127f0c567cddac05148050826cb78300fa39b0e9f0f4bb443d006aca':
        raise SystemExit('Unrecognized type_expr.c; review the frontend patch before building')
with (out/'build.log').open('wb') as log:
    for cmd in commands:
        subprocess.run(cmd,cwd=out,input=b'\n'*256,stdout=log,stderr=subprocess.STDOUT,check=True)
compiler=out/'bin/vbcchc12'
patches={} if a.stock else {n:hashlib.sha256((Path(__file__).resolve().parent/'patches'/n).read_bytes()).hexdigest() for n in ('vbcc-array-offset.patch','vbcc-pointer-subtract.patch','vbcc-acc-restore.patch')}
(out/'PATCH.json').write_text(json.dumps({'source_backend_sha256':hashlib.sha256((source/'machines/hc12/machine.c').read_bytes()).hexdigest(),'source_frontend_sha256':hashlib.sha256((source/'type_expr.c').read_bytes()).hexdigest(),'compiler_sha256':hashlib.sha256(compiler.read_bytes()).hexdigest(),'patches':patches,'commands':commands},indent=2)+'\n')

print(compiler)
