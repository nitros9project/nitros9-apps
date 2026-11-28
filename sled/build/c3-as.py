#!/usr/bin/env python3
"""Split C3's zero reservations from initialized vsects before assembly.

The standard bridge emits a loaded image for an entire initialized vsect.
SLED's zero-filled line-pointer table must remain BSS rather than padding
that image. Splitting a generated rmb into its own vsect preserves symbol
order and the common data section while giving the bridge a pure BSS region.
"""
import os
from pathlib import Path
import re
import shutil
import subprocess
import sys


def split_regions(text):
    result=[]
    region=None
    for line in text.splitlines():
        fields=line.split()
        directive=fields[0].lower() if fields else ''
        if directive=='vsect':
            region=line
        elif directive=='endsect':
            region=None
        if region and re.match(r'^\s*(?:[A-Za-z_]\w*:?\s+)?rmb\s+\S+',line,re.I):
            result += [' endsect',region,line,' endsect',region]
        else:
            result.append(line)
    return '\n'.join(result)+'\n'


def main():
    args=sys.argv[1:]
    source=next((Path(arg) for arg in args if not arg.startswith('-')),None)
    if source is None:raise SystemExit('No C3 assembly source')
    sparse=source.with_suffix('.sparse.a')
    sparse.write_text(split_regions(source.read_text()))
    assembler=os.environ.get('C3_ASM_REAL') or shutil.which('c3-as')
    if not assembler:raise SystemExit('c3-as not found')
    return subprocess.call([assembler,*[str(sparse) if arg==str(source) else arg for arg in args]])


if __name__=='__main__':raise SystemExit(main())
