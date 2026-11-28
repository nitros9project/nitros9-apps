#!/usr/bin/env python3
"""Exercise editing, saving, reopening and discarding on a prepared CoCo 3 boot.

The original disk is copied. Requires MAME CoCo 3 ROMs and ToolShed os9.
Screenshots and the edited disk remain beside the tested module.
"""
import argparse
import json
import hashlib
from pathlib import Path
import shutil
import subprocess

p=argparse.ArgumentParser(description=__doc__)
for name in ('boot','roms','mame','os9','module'):
    p.add_argument('--'+name,type=Path,required=True)
a=p.parse_args()
out=a.module.resolve().parent/'interactive';out.mkdir(exist_ok=True)
for stale in list(out.glob('*.png'))+[out/'result.json']:
    stale.unlink(missing_ok=True)
disk=out/'test.dsk';shutil.copyfile(a.boot,disk)
def tool(*args):
    return subprocess.run([str(a.os9.resolve()),*map(str,args)],check=True,capture_output=True)
tool('copy','-r',a.module,str(disk)+',CMDS/sled')
tool('attr','-q','-e','-pe',str(disk)+',CMDS/sled')
fixture=out/'input.txt';fixture.write_bytes(b'alpha\rbeta\r\r'+b't'*100+b'\ra\tb')
tool('copy','-r',fixture,str(disk)+',edit.txt')
lines=['local nk=manager.machine.natkeyboard','nk.in_use=true','emu.wait(2)',
       'nk:post("DOS\\r")','emu.wait(55)']
def command(text):
    lines.append('nk.in_use=true')
    text+='\r'
    for i in range(0,len(text),8):
        lines.extend(['nk:post('+json.dumps(text[i:i+8])+')','emu.wait(2)'])
    lines.extend(['emu.wait(25)','nk.in_use=false'])
def press(row,name,ctrl=False,alt=False):
    if alt:lines.append('manager.machine.ioport.ports[":row6"].fields["ALT"]:set_value(1)')
    if ctrl:lines.append('manager.machine.ioport.ports[":row6"].fields["CTRL"]:set_value(1)')
    expr='manager.machine.ioport.ports[":row'+str(row)+'"].fields['+json.dumps(name)+']'
    lines.extend([expr+':set_value(1)','emu.wait(2/60)',expr+':set_value(0)'])
    if ctrl:lines.append('manager.machine.ioport.ports[":row6"].fields["CTRL"]:set_value(0)')
    if alt:lines.append('manager.machine.ioport.ports[":row6"].fields["ALT"]:set_value(0)')
    lines.append('emu.wait(2)')
def snap(name):
    lines.append('for _,s in pairs(manager.machine.screens) do s:snapshot('+json.dumps(str(out/(name+'.png')))+');break end')
command('/dd/cmds/sled /dd/edit.txt')
press(3,'z  Z')                       # overwrite alpha -> zlpha
press(3,'LEFT');press(6,'F1')          # insert before first character
press(3,'x  X');snap('inserted');press(0,'d  D',True);snap('deleted')   # xzlpha -> xlpha
press(0,'b  B',True);press(3,'LEFT');press(6,'F1')     # top; overwrite mode
press(0,'a  A',True)                  # insert a blank line before xlpha
press(1,'k  K');press(6,'ENTER')       # k then existing xlpha
press(1,'j  J',True);press(1,'k  K',True) # remove beta
snap('edited')
press(2,'q  Q',True);snap('save-prompt')
press(3,'y  Y');lines.append('emu.wait(12)');snap('replace-prompt')
press(3,'y  Y');lines.append('emu.wait(12)');snap('saved-shell')
command('/dd/cmds/sled /dd/edit.txt');snap('reopened')
press(3,'z  Z');press(2,'q  Q',True);press(1,'n  N')
lines.append('emu.wait(10)');snap('discarded-shell')
command('/dd/cmds/sled /dd/edit.txt')
press(1,'m  M',alt=True);press(1,'m  M',alt=True)
press(2,'w  W',True);command('/dd/block.txt')
press(2,'q  Q',True);press(1,'n  N');lines.append('emu.wait(10)')
snap('block-output-shell')
command('/dd/cmds/sled')
press(0,'a  A');press(0,'b  B');press(6,'ENTER');press(0,'c  C')
press(2,'q  Q',True);press(3,'y  Y');lines.append('emu.wait(10)')
command('/dd/new.txt')
press(3,'y  Y');lines.append('emu.wait(12)');snap('new-file-shell')
lines.append('manager.machine:exit()')
script=out/'test.lua';script.write_text('\n'.join(lines)+'\n')
with (out/'mame.log').open('w') as log:
    subprocess.run([str(a.mame.resolve()),'coco3','-noreadconfig','-rompath',str(a.roms.resolve()),
        '-skip_gameinfo','-ext','fdc','-ext:fdc:wd17xx:0','525qd','-flop1',str(disk),
        '-nothrottle','-video','soft','-window','-sound','none','-cfg_directory',str(out/'cfg'),
        '-nvram_directory',str(out/'nvram'),'-autoboot_script',str(script),'-seconds_to_run','600'],
        stdout=log,stderr=subprocess.STDOUT,timeout=240,check=True)
result=out/'edited.txt';result.unlink(missing_ok=True)
tool('copy',str(disk)+',edit.txt',result)
expected=b'k\rxlpha\r\r'+b't'*100+b'\ra   b\r'
assert result.read_bytes()==expected,(result.read_bytes(),expected)
block=out/'block.txt';block.unlink(missing_ok=True)
tool('copy',str(disk)+',block.txt',block)
assert block.read_bytes()==b'k\r',block.read_bytes()
newfile=out/'new.txt';newfile.unlink(missing_ok=True)
tool('copy',str(disk)+',new.txt',newfile)
assert newfile.read_bytes()==b'ab\rc\r',newfile.read_bytes()
for name in ('edited','save-prompt','replace-prompt','saved-shell','reopened','discarded-shell'):
    assert (out/(name+'.png')).is_file(),name+' screenshot missing'
report={'module_sha256':hashlib.sha256(a.module.read_bytes()).hexdigest(),
        'expected_file_hex':expected.hex(),'actual_file_hex':result.read_bytes().hex(),
        'checks':['overwrite','insert character','delete character','add line','delete line',
                  'blank line','long line','tab expansion','final carriage return','save','reopen','discard','save unnamed buffer','write marked block']}
(out/'result.json').write_text(json.dumps(report,indent=2)+'\n')
metadata=a.module.with_suffix('.json')
if metadata.is_file():
    info=json.loads(metadata.read_text())
    assert info['module_sha256']==report['module_sha256'],'module changed during testing'
    info.update(runtime_tested=True,runtime_checks=report['checks'])
    metadata.write_text(json.dumps(info,indent=2)+'\n')
print('PASS: overwrite, insert/delete character, add/delete line, blank/long/tabbed lines, save, reopen, discard, save unnamed buffer, write marked block')
print('Inspect terminal screenshots in',out)
