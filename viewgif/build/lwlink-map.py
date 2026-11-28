#!/usr/bin/env python3
"""Retain an LWLINK map before the compiler removes its intermediate files."""
import os
from pathlib import Path
import shutil
import subprocess
import sys

args=sys.argv[1:]
requested=next((arg.split('=',1)[1] for arg in args if arg.startswith(('--map=','-m='))),None)
if requested is None:
    for i,arg in enumerate(args[:-1]):
        if arg in ('--map','-m'):requested=args[i+1]
retained=Path(os.environ['VIEWGIF_LINK_MAP'])
if requested is None:
    args.append('--map='+str(retained))
status=subprocess.call([os.environ['VIEWGIF_REAL_LWLINK'],*args])
if status==0 and requested is not None and Path(requested).resolve()!=retained.resolve():
    shutil.copyfile(requested,retained)
raise SystemExit(status)
