#!/usr/bin/env python3
"""Regenerate original test data; requires Pillow (generated with 11.3.0)."""
from pathlib import Path
from PIL import Image

out=Path(__file__).parent/'fixtures'
out.mkdir(exist_ok=True)
for name in ('stripes','allcolors','interlaced'):
    size=32 if name=='stripes' else 128
    data=bytes(i%2 for i in range(1024)) if name=='stripes' else bytes(((i*73)^(i>>3)^(i>>8))&255 for i in range(16384))
    image=Image.frombytes('P',(size,size),data)
    image.putpalette([v for i in range(256) for v in (i,i,i)])
    image.save(out/(name+'.gif'),optimize=False,interlace=name=='interlaced')

image=Image.new('P',(128,96))
colors=[(0,0,0),(255,0,0),(0,255,0),(0,0,255),(255,255,0),(0,255,255),(255,0,255),(255,255,255)]
image.putpalette([v for rgb in colors+[(0,0,0)]*248 for v in rgb])
# Rotate bands every 32 source rows so a stale scanline cannot pass export.
image.putdata([((x//16)+(y//32))%8 for y in range(96) for x in range(128)])
image.save(out/'bars.gif',optimize=False,interlace=False)

# Mid-gray needs two different CoCo frames in alternating-screen mode.
colors[4]=(127,127,127)
image.putpalette([v for rgb in colors+[(0,0,0)]*248 for v in rgb])
image.save(out/'flicker.gif',optimize=False,interlace=False)
