#!/usr/bin/env python3
"""Attribute loaded module bytes using retained LWLINK/LLD maps (exclude RAM)."""
import argparse
from collections import Counter
import json
from pathlib import Path
import re

APPS={'viewgif.r','gifwin.r','setmap.r','viewvef.r','numbers.r',
      'viewgif.o','gifwin.o','setmap.o','viewvef.o','numbers.o'}


def report(root,compiler,name):
    binary=root/compiler/'Os'/name
    groups=Counter();objects=Counter()
    for line in binary.with_suffix('.map').read_text().splitlines():
        if compiler=='llvm':
            match=re.match(r'\s*[0-9a-f]+\s+[0-9a-f]+\s+([0-9a-f]+)\s+\d+\s+(\S+):\(([^)]+)\)',line)
            if not match:continue
            size,obj,section=match.groups();size=int(size,16)
            if not section.startswith(('.text','.rodata','.data','.init_array','.fini_array','.os9_reloc')):continue
            if obj in APPS:group='application'
            elif obj=='<internal>':group='pooled strings and linker tables'
            elif 'libcmoc_os9_compat' in obj:group='OS-9 compatibility library'
            elif Path(obj).name.startswith(('libc.a(','libos9.a(','libm.a(')):group='picolibc'
            else:group='compiler runtime and startup'
        else:
            match=re.match(r'Section: (\S+) \((.*)\) load at ([0-9A-F]+), length ([0-9A-F]+)',line)
            if not match:continue
            section,obj,address,size=match.groups();size=int(size,16)
            if section in ('bss','stack','directpage'):continue
            if obj in APPS:group='application'
            elif Path(obj).name in ('crt0.o','fpdummy.o','crt.os9_o'):group='startup'
            else:group='libraries'
        groups[group]+=size
        objects[Path(obj).name]+=size
    total=binary.stat().st_size
    groups['module header, name, CRC and padding']=total-sum(groups.values())
    assert groups['module header, name, CRC and padding']>=0,'map does not match loaded sections'
    return {'module_bytes':total,'loaded_bytes':dict(groups),
            'largest_objects':[{'object':obj,'bytes':size} for obj,size in objects.most_common(12)]}


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--root',type=Path,default=Path(__file__).parent/'out')
    args=parser.parse_args()
    data={c:{n:report(args.root,c,n) for n in ('viewgif','viewvef')} for c in ('c3','cmoc','llvm')}
    print(json.dumps(data,indent=2))


if __name__=='__main__':main()
