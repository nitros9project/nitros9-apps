#!/usr/bin/env python3
"""Run ViewGIF's non-display decoder against fixtures on OS-9."""
import argparse
import json
from pathlib import Path
import re
import shutil
import subprocess
import time


def norm(data):return data.replace(b'\r\n',b'\n').replace(b'\r',b'\n')


def main():
    p=argparse.ArgumentParser(description=__doc__)
    for name in ('boot','firmware','emulator','os9','modules'):p.add_argument('--'+name,type=Path,required=True)
    p.add_argument('--seconds',type=int,default=30)
    a=p.parse_args();out=a.modules.resolve()/'runtime';out.mkdir(exist_ok=True)
    disk=out/'test.dsk';shutil.copyfile(a.boot,disk)
    def tool(*args,check=True):return subprocess.run([str(a.os9.resolve()),*map(str,args)],check=check,capture_output=True)
    for d in ('VGTEST','VGTEST/CMDS'):tool('makdir',str(disk)+','+d)
    for name in ('viewgif','viewvef'):
        tool('copy',a.modules/name,str(disk)+',VGTEST/CMDS/'+name)
        tool('attr','-q','-e','-pe','-pr',str(disk)+',VGTEST/CMDS/'+name)
    gif=b'GIF87a\x01\x00\x01\x00\x80\x00\x00'+b'\0\0\0\xff\xff\xff'+b',\0\0\0\0\x01\0\x01\0\0\x02\x02\x44\x01\0;'
    (out/'tiny.gif').write_bytes(gif);tool('copy',out/'tiny.gif',str(disk)+',VGTEST/tiny.gif')
    cases={'tiny':b'\1\0','stripes':bytes([1,1]+[0]*254),'allcolors':bytes([1]*256),'interlaced':bytes([1]*256)}
    commands=['chx /dd/vgtest/cmds','chd /dd/vgtest','echo VGREADY']
    for name in cases:
        if name!='tiny':tool('copy',Path(__file__).parent/'fixtures'/(name+'.gif'),str(disk)+',VGTEST/'+name+'.gif')
        commands.append('viewgif '+name+'.gif -n -f -d -b=16 -u='+name+'.colors >'+name+'.info')
    commands.append('echo VGDONE')
    startup=out/'startup';startup.write_bytes(('\r'.join(commands)+'\r').encode())
    tool('copy','-r',startup,str(disk)+',startup');tool('attr','-q','-npe','-npw','-pr','-ne','-w','-r',str(disk)+',startup')
    fram=out/'state.fram';fram.unlink(missing_ok=True);log=out/'console.log'
    with log.open('wb') as stream:
        proc=subprocess.Popen([str(a.emulator.resolve()),'--timeout=900000000','-f',str(fram),'-d',str(disk),str(a.firmware.resolve())],stdout=stream,stderr=subprocess.STDOUT,stdin=subprocess.DEVNULL)
        try:
            deadline=time.monotonic()+a.seconds
            while proc.poll() is None and time.monotonic()<deadline:
                if re.search(rb'VGDONE\n|Error #|viewgif:',norm(log.read_bytes())):break
                time.sleep(.1)
        finally:
            if proc.poll() is None:proc.terminate()
            proc.wait(timeout=10)
    console=norm(log.read_bytes());results={}
    for name,wanted in cases.items():
        actual=out/(name+'.colors');actual.unlink(missing_ok=True)
        extracted=tool('copy',str(disk)+',VGTEST/'+actual.name,actual,check=False).returncode==0
        results[name]=b'VGDONE\n' in console and extracted and actual.read_bytes()==wanted
        print(name+' GIF decode:', 'PASS' if results[name] else 'FAIL')
    good=all(results.values())
    if not good:print(console.decode('latin1')[-1800:])
    (out/'results.json').write_text(json.dumps({'cases':results,'console':console.decode('latin1')},indent=2)+'\n')
    return 0 if good else 1


if __name__=='__main__':raise SystemExit(main())
