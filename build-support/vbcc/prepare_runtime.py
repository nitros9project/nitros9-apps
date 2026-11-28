#!/usr/bin/env python3
"""Build the preview OS-9 EOF wrapper in a private output directory."""
import argparse
import hashlib
from pathlib import Path
import shutil
import subprocess
p=argparse.ArgumentParser(description=__doc__)
p.add_argument('--source',type=Path,required=True,help='Preview libsrc/6809-os9/rw.s')
p.add_argument('--root',type=Path,required=True,help='Installed VBCC root')
p.add_argument('--out',type=Path,default=Path(__file__).resolve().parent/'out/io')
a=p.parse_args()
if hashlib.sha256(a.source.read_bytes()).hexdigest()!='7859349154591f4cd698af5ce7daddb638596769328d26e55d8f72006e6cd4f6':
    p.error('Unrecognized preview rw.s; review patch before applying')
out=a.out.resolve();out.mkdir(parents=True,exist_ok=True)
if a.source.resolve()==out/'rw.s':p.error('Output must be separate from source')
shutil.copyfile(a.source,out/'rw.s')
subprocess.run(['patch','--batch','-p1','-i',str(Path(__file__).resolve().parent/'patches/vbcc-os9-rw.patch')],cwd=out,check=True)
subprocess.run([str(a.root.resolve()/'bin/vasm6809_std'),'-quiet','-Fvobj','-I'+str(a.root.resolve()/'targets/6809-os9/include'),str(out/'rw.s'),'-o',str(out/'rw.o')],check=True)
print(out/'rw.o')
