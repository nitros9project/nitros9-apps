#!/usr/bin/env python3
"""Check ViewGIF display/VEF export and ViewVEF playback on a prepared CoCo 3 disk.

The boot disk must start an interactive shell with CoWin, grfdrv, and its usual
fonts/patterns loaded. Its CMDS directory must exist. A scratch copy is modified.
Snapshots are retained for visual inspection; VEF pixels are compared exactly.
"""
import argparse
import json
import hashlib
from pathlib import Path
import shutil
import subprocess
from png_pixels import read_rgb

p=argparse.ArgumentParser(description=__doc__)
for name in ('boot','roms','mame','os9','modules'):
    p.add_argument('--'+name,type=Path,required=True)
p.add_argument('--flicker',action='store_true',help='verify two different exported frames and live alternation')
a=p.parse_args()
out=a.modules.resolve()/('graphics-flicker' if a.flicker else 'graphics');out.mkdir(exist_ok=True)
disk=out/'test.dsk';shutil.copyfile(a.boot,disk)
def tool(*args):
    return subprocess.run([str(a.os9.resolve()),*map(str,args)],check=True,capture_output=True)
for suffix in ('','.2'):
    try:tool('del',str(disk)+',bars.vef'+suffix)
    except subprocess.CalledProcessError as error:
        if error.returncode!=216:raise
for name in ('viewgif','viewvef'):
    tool('copy','-r',a.modules/name,str(disk)+',CMDS/'+name)
    tool('attr','-q','-e','-pe',str(disk)+',CMDS/'+name)
tool('copy','-r',Path(__file__).parent/'fixtures'/('flicker.gif' if a.flicker else 'bars.gif'),str(disk)+',bars.gif')
def run_display(command,name,delay):
    lines=['manager.machine.ioport.ports[":screen_config"].fields["Monitor Type"]:set_value(1)',
           'local mem=manager.machine.devices[":maincpu"].spaces["program"];local base={}',
           'local tap=mem:install_write_tap(0xff9d,0xff9e,"video-base",function(offset,data,mask) base[offset]=data end)',
           'local nk=manager.machine.natkeyboard','nk.in_use=true','emu.wait(2)',
           'nk:post("DOS\\r")','emu.wait(55)']
    text=command+'\r'
    for offset in range(0,len(text),8):
        lines.extend(['nk:post('+json.dumps(text[offset:offset+8])+')','emu.wait(2)'])
    lines.extend(['emu.wait('+str(delay)+')',
        'manager.machine.ioport.ports[":screen_config"].fields["Monitor Type"]:set_value(1)',
        'emu.wait(1)',
        'for _,screen in pairs(manager.machine.screens) do screen:snapshot('+json.dumps(str(out/(name+'.png')))+');break end',
        'emu.wait(1)','manager.machine:exit()'])
    if a.flicker:
        # Exporting two screens can outlast the initial delay. A completed
        # viewer switches video banks steadily; exporting stays on one bank.
        ready=[
            'local ready=false',
            'for second=1,240 do local last=nil;local changes=0;for frame=1,60 do emu.wait(1/60);local value=(base[0xff9d] or 0)*256+(base[0xff9e] or 0);if last and value~=last then changes=changes+1 end;last=value end;if changes>=15 then ready=true;print("Flicker ready after extra seconds",second);break end end',
            'assert(ready,"viewer did not reach steady flicker")']
        point=next(i for i,line in enumerate(lines) if 'screen:snapshot(' in line)
        lines[point:point]=ready
        lines=lines[:-2]
        lines.extend(['local banks={}',
            'for i=1,12 do emu.wait(1/60);banks[(base[0xff9d] or 0)*256+(base[0xff9e] or 0)]=true; for _,screen in pairs(manager.machine.screens) do screen:snapshot('+json.dumps(str(out/(name+'-')))+'..i..".png");break end end',
            'local f=assert(io.open('+json.dumps(str(out/(name+'.banks')))+',"w"));for bank in pairs(banks) do f:write(bank,"\\n") end;f:close()',
            'emu.wait(1)','manager.machine:exit()'])
    script=out/(name+'.lua');script.write_text('\n'.join(lines)+'\n')
    with (out/(name+'.log')).open('w') as log:
        subprocess.run([str(a.mame.resolve()),'coco3','-noreadconfig','-rompath',str(a.roms.resolve()),
            '-skip_gameinfo','-ext','fdc','-ext:fdc:wd17xx:0','525qd','-flop1',str(disk),
            '-nothrottle','-video','soft','-window','-sound','none','-cfg_directory',str(out/'cfg'),
            '-nvram_directory',str(out/'nvram'),'-autoboot_script',str(script),'-seconds_to_run','600'],
            stdout=log,stderr=subprocess.STDOUT,timeout=240,check=True)
# Separate boots avoid feeding the second command to an image window still
# consuming keyboard input. Timed pauses keep both images on screen.
run_display('/dd/cmds/viewgif /dd/bars.gif '+('' if a.flicker else '-f ')+'-d -s -v=/dd/bars.vef -p=300','viewgif',180)
run_display('/dd/cmds/viewvef /dd/bars.vef 300','viewvef',60)
frames=[]
for suffix in (('','.2') if a.flicker else ('',)):
    vef=out/('bars.vef'+suffix);vef.unlink(missing_ok=True)
    tool('copy',str(disk)+',bars.vef'+suffix,vef)
    data=vef.read_bytes()
    assert len(data)==32018,('VEF length',len(data))
    assert data[:2]==b'\0\0','VEF mode differs'
    frames.append(data)
if not a.flicker:
    expected_palette=bytes([0,36,18,9,54,27,45,63]+[0]*8)
    expected_pixels=b''.join(bytes([((i+y//64)%8)*17])*20 for y in range(192) for i in range(8))
    assert frames[0][2:18]==expected_palette,'VEF palette differs'
    assert frames[0][1298:]==expected_pixels,'VEF pixels differ'
else:
    def rgb(color):return tuple(v*85 for v in (((color>>4)&2)|((color>>2)&1),((color>>3)&2)|((color>>1)&1),((color>>2)&2)|(color&1)))
    images=[]
    for frame in frames:
        palette=[rgb(color) for color in frame[2:18]]
        images.append([palette[index] for value in frame[1298:] for index in (value>>4,value&15)])
    source=[(0,0,0),(255,0,0),(0,255,0),(0,0,255),(127,127,127),(0,255,255),(255,0,255),(255,255,255)]
    assert images[0]!=images[1],'flicker fixture did not produce different frames'
    for i,(first,second) in enumerate(zip(*images)):
        expected=source[((i%320)//40+(i//320)//64)%8]
        assert all(abs(first[c]+second[c]-2*expected[c])<=1 for c in range(3)),('flicker average differs',i,first,second,expected)
for name in ('viewgif','viewvef'):
    assert (out/(name+'.png')).is_file(),name+' snapshot missing'
    width,height,rows=read_rgb(out/(name+'.png'))
    samples=[]
    for i in range(8):
        x=int((i+0.5)*width/8)
        samples.append(rows[height//2][x*3:x*3+3])
    # NitrOS-9 translates the hardware palette according to its configured
    # monitor. Check visible bands here; the file palette is checked above.
    assert b'\0\0\0' in samples and b'\xff\xff\xff' in samples,name+' background/white band differs'
    assert len(set(samples))==8,name+' display is blank or missing color bars'

if a.flicker:
    for name in ('viewgif','viewvef'):
        assert len(set((out/(name+'.banks')).read_text().splitlines()))>=2,name+' did not alternate video banks'
        hashes=set()
        for i in range(1,13):
            width,height,rows=read_rgb(out/(name+'-'+str(i)+'.png'))
            hashes.add(hashlib.sha256(b''.join(rows)).hexdigest())
        assert len(hashes)>=2,name+' did not display different frames'
    print('Flicker: two correct VEF frames, distinct displayed frames and video-bank alternation PASS')
else:
    print('VEF export: exact palette and 320 x 192 pixels PASS')
print('Inspect display/playback snapshots in',out)
