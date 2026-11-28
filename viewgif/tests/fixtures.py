"""Expected pixel streams for the checked-in, generated GIF fixtures."""
from pathlib import Path


def expected(name):
    if name in ('bars','flicker'): return bytes(((x//16)+(y//32))%8 for y in range(96) for x in range(128))
    if name=='stripes': return bytes(i%2 for i in range(1024))
    pixels=bytes(((i*73)^(i>>3)^(i>>8))&255 for i in range(16384))
    if name=='interlaced':
        return b''.join(pixels[y*128:(y+1)*128] for start,step in ((0,8),(4,8),(2,4),(1,2)) for y in range(start,128,step))
    return pixels
