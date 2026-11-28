#!/usr/bin/env python3
"""Build a private vlink with 6809 16-bit PC-relative wraparound support."""
import argparse
import hashlib
from pathlib import Path
import shutil
import subprocess
p=argparse.ArgumentParser(description=__doc__)
p.add_argument('--source',type=Path,required=True)
p.add_argument('--out',type=Path,default=Path(__file__).resolve().parent/'out/vlink')
a=p.parse_args()
source=a.source.resolve();out=a.out.resolve()
if out==source or source in out.parents or out in source.parents:raise SystemExit('Use a separate output directory')
if out.exists():raise SystemExit('Output exists; select a new directory')
if hashlib.sha256((source/'targets.c').read_bytes()).hexdigest()!='4616dc3a36f3abda91b75d95a2b0af75406bcfccd2a38f0aaadc2870b71f491c':
    raise SystemExit('Unrecognized vlink targets.c; review the relocation patch first')
shutil.copytree(source,out,ignore=shutil.ignore_patterns('objects','vlink','.git'))
with (out/'build.log').open('w') as log:
    subprocess.run(['patch','--batch','-p1','-i',str(Path(__file__).resolve().parent/'patches/vlink-pcrel.patch')],cwd=out,stdout=log,stderr=subprocess.STDOUT,check=True)
    subprocess.run(['make','-j4','CC=cc','LD=cc'],cwd=out,stdout=log,stderr=subprocess.STDOUT,check=True)
print(out/'vlink')
