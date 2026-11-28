#!/usr/bin/env python3
"""Check exact decoded pixels and malformed input without OS-9 dependencies."""
import os
from pathlib import Path
import subprocess
import tempfile
from fixtures import expected

ROOT=Path(__file__).resolve().parents[1]
with tempfile.TemporaryDirectory(prefix='viewgif-host-') as directory:
    out=Path(directory);program=out/'viewgif'
    cmd=[os.environ.get('HOST_CC','cc'),'-std=gnu89','-DVIEWGIF_TEST','-DVIEWGIF_TEST_NUMBERS','-I'+str(ROOT/'tests/host'),'-I'+str(ROOT/'src'),'-Wno-pointer-to-int-cast','-Wno-return-type','-Wno-pointer-sign','-Wno-incompatible-pointer-types',*map(str,[ROOT/'src/viewgif.c',ROOT/'src/gifwin.c',ROOT/'src/setmap.c',ROOT/'src/numbers.c',ROOT/'tests/host/platform.c']),'-o',str(program)]
    subprocess.run(cmd,check=True)
    number_test=out/'numbers'
    subprocess.run([os.environ.get('HOST_CC','cc'),'-std=gnu89','-DVIEWGIF_TEST_NUMBERS',
        '-I'+str(ROOT/'tests/host'),'-I'+str(ROOT/'src'),str(ROOT/'tests/numbers_test.c'),
        str(ROOT/'src/numbers.c'),'-o',str(number_test)],check=True)
    subprocess.run([str(number_test)],check=True)
    print('decimal options: 10 cases PASS')
    for name in ('stripes','allcolors','interlaced','bars','flicker'):
        pixels=out/(name+'.pixels');stats=out/(name+'.colors')
        run=subprocess.run([str(program),str(ROOT/'tests/fixtures'/(name+'.gif')),'-n','-f','-d','-u='+stats.name],cwd=out,env={**os.environ,'VIEWGIF_PIXEL_TRACE':str(pixels)},capture_output=True)
        assert run.returncode==0,(name,run.stderr)
        assert pixels.read_bytes()==expected(name),(name,'decoded pixels differ')
        wanted=bytes([1,1]+[0]*254) if name=='stripes' else bytes([1]*8+[0]*248) if name in ('bars','flicker') else bytes([1]*256)
        assert stats.read_bytes()==wanted,(name,'color usage differs')
        print(name+': exact pixels PASS')
    valid=(ROOT/'tests/fixtures/stripes.gif').read_bytes()
    for name,data in [('signature',b'not a GIF'),('screen',valid[:10]),('palette',valid[:20]),('raster',valid[:-10])]:
        bad=out/(name+'.gif');bad.write_bytes(data)
        run=subprocess.run([str(program),str(bad),'-n','-f','-d','-u=badcolors'],cwd=out,env={**os.environ,'VIEWGIF_PIXEL_TRACE':str(out/'badpixels')},capture_output=True,timeout=5)
        assert run.returncode!=0,(name,'malformed input succeeded')
        assert b'viewgif:' in run.stderr,(name,run.stderr)
        print(name+': rejection PASS')
