"""Read the RGB8, noninterlaced PNG snapshots emitted by MAME (stdlib only)."""
import struct
import zlib


def read_rgb(path):
    data=path.read_bytes()
    assert data[:8]==b'\x89PNG\r\n\x1a\n','not PNG'
    pos=8;payload=bytearray()
    while pos<len(data):
        length=struct.unpack('>I',data[pos:pos+4])[0]
        kind=data[pos+4:pos+8];chunk=data[pos+8:pos+8+length];pos+=length+12
        if kind==b'IHDR':
            width,height,depth,color,compression,filters,interlace=struct.unpack('>IIBBBBB',chunk)
            assert (depth,color,compression,filters,interlace)==(8,2,0,0,0),'unsupported PNG format'
        elif kind==b'IDAT':payload.extend(chunk)
    raw=zlib.decompress(payload);stride=width*3;rows=[];above=bytearray(stride)
    for y in range(height):
        offset=y*(stride+1);kind=raw[offset];row=bytearray(raw[offset+1:offset+1+stride])
        assert kind<=4,'invalid PNG filter'
        for x in range(stride):
            a=row[x-3] if x>=3 else 0;b=above[x];c=above[x-3] if x>=3 else 0
            if kind==0:predict=0
            elif kind==1:predict=a
            elif kind==2:predict=b
            elif kind==3:predict=(a+b)//2
            else:
                p=a+b-c;pa,pb,pc=abs(p-a),abs(p-b),abs(p-c)
                predict=a if pa<=pb and pa<=pc else b if pb<=pc else c
            row[x]=(row[x]+predict)&255
        rows.append(bytes(row));above=row
    return width,height,rows
