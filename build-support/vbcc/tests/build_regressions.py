#!/usr/bin/env python3
"""Build the native PC-relative wrap and safe compiler regression modules."""
import importlib.util
import os
from pathlib import Path

base=Path(__file__).resolve().parents[1]
spec=importlib.util.spec_from_file_location('apps_vbcc',base.parent/'vbcc.py')
vbcc=importlib.util.module_from_spec(spec)
spec.loader.exec_module(vbcc)
tc=vbcc.Toolchain(base/'out')
for name in ['wrap','ptrfix','accfix']+(['accbad'] if os.environ.get('VBCC_STOCK_CC') else []):
    out=tc.out/name
    out.mkdir(exist_ok=True)
    if name=='wrap':
        obj=tc.compile(base/'tests/wrap.c',out/'wrap.o')
        native=out/'far.o';log=out/'far.log';log.write_text('')
        vbcc.run([tc.asm,'-quiet','-Fvobj',base/'tests/wrap.s','-o',native],out,log)
        tc.link([obj,native],name,out)
    else:
        if name=='accbad':tc.cc=Path(os.environ['VBCC_STOCK_CC']).resolve()
        sources=base/'issues'/('pointer-subtraction' if name=='ptrfix' else 'accumulator-restore')
        objects=[tc.compile(sources/source,out/Path(source).with_suffix('.o')) for source in ('check.c','probe.c')]
        tc.link(objects,name,out)
