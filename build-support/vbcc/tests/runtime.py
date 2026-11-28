#!/usr/bin/env python3
"""Run file/stdio/editor fixtures on an isolated NitrOS-9 disk."""
import argparse
import binascii
import hashlib
import json
from pathlib import Path
import re
import shutil
import subprocess
import time

p=argparse.ArgumentParser(description=__doc__)
for n in ('boot','firmware','emulator','os9','modules'):p.add_argument('--'+n,type=Path,required=True)
p.add_argument('--seconds',type=int,default=90)
a=p.parse_args();root=a.modules.resolve();out=root/'tests';out.mkdir(exist_ok=True)
(out/'results.json').unlink(missing_ok=True)
disk=out/'test.dsk';shutil.copyfile(a.boot,disk)
def tool(*args,check=True):return subprocess.run([str(a.os9.resolve()),*map(str,args)],capture_output=True,check=check)
def put(path,data):
    f=out/'upload';f.write_bytes(data);tool('copy','-r',f,str(disk)+','+path)
def fixture(value):
    if isinstance(value,dict):
        if 'hex' in value:return bytes.fromhex(value['hex'])
        value=value['text']
    return value.replace('\n','\r').encode('ascii')
def norm(data):return data.replace(b'\r\n',b'\n').replace(b'\r',b'\n')
for d in ('VBTEST','VBTEST/CMDS','SYS/UUCP'):
    if tool('dir',str(disk)+','+d,check=False).returncode:tool('makdir',str(disk)+','+d)
cases=json.loads((Path(__file__).parent/'cli-cases.json').read_text())
cases += [dict(app='sort',id='sort-normal',args=[],input='beta\nalpha\nalpha\n',output='alpha\nalpha\nbeta\n'),
          dict(app='sort',id='sort-numeric',args=['-n'],input='20\n3\n100\n-2\n',output='-2\n3\n20\n100\n')]
modules={c['app'] for c in cases}|{'kermit','uuencode','uudecode','fixtext','uuname','man','mroff','ppc','wrap','ptrfix','accfix'}
for name in sorted(modules):
    tool('copy','-r',root/name/name,str(disk)+',VBTEST/CMDS/'+name)
    tool('attr','-q','-e','-pe','-pr',str(disk)+',VBTEST/CMDS/'+name)
commands=['chx /dd/vbtest/cmds','chd /dd/vbtest','echo VBSTART']
checks=[]
for i,case in enumerate(cases):
    directory='case'+str(i);tool('makdir',str(disk)+',VBTEST/'+directory)
    commands.append('chd /dd/vbtest/'+directory)
    data=bytes.fromhex(case['input_hex']) if 'input_hex' in case else fixture(case['input'])
    replacements={};files=[]
    for kind in ('files','output_files'):
        for j,(token,value) in enumerate(case.get(kind,{}).items()):
            name=value.get('path') if isinstance(value,dict) else None
            name=name or ('file'+str(j) if kind=='files' else 'saved'+str(j))
            replacements['@'+token+'@']=name
            if kind=='files':put('VBTEST/'+directory+'/'+name,fixture(value))
            else:files.append((directory+'/'+name,fixture(value)))
    if replacements and 'input' in case:
        text=case['input']
        for token,value in replacements.items():text=text.replace(token,value)
        data=fixture(text)
    put('VBTEST/'+directory+'/input',data)
    words=[case['app']]+['input' if x=='INPUT' else replacements.get(x,x) for x in case['args']]
    command=' '.join(words)+('' if 'INPUT' in case['args'] else ' <input')+' >output'
    commands+=['echo VBCASE'+str(i),command]
    checks.append(dict(id=case['app']+'/'+case['id'],file=directory+'/output',expected=case.get('output'),contains=case.get('output_contains'),files=files))
commands.append('chd /dd/vbtest')
payload=bytes(range(256))+b'\x00\xff\r\nBinary\0end'
put('VBTEST/payload',payload)
encoded=b'begin 644 independent\r'+b''.join(binascii.b2a_uu(payload[i:i+45]).replace(b'\n',b'\r') for i in range(0,len(payload),45))+b' \rend\r'
put('VBTEST/known',encoded)
put('VBTEST/text',b'A\tB\r')
put('SYS/UUCP/Parameters',b'nodename = vbtest\r')
put('SYS/UUCP/Systems',b'alpha Any ACU\rbeta Any ACU\r')
commands += ['kermit >kermit-help','uuencode decoded payload >encoded','uudecode encoded','uudecode known',
             'fixtext text >fixed','uuname -l >local','uuname >systems','man -? >man-help',
             'wrap >wrap.log','ptrfix >ptrfix.log','accfix >accfix.log']
checks += [dict(id='compiler/pointer-subtraction',file='ptrfix.log',expected='POINTER SUBTRACTION PASS\n'),dict(id='compiler/accumulator-restore',file='accfix.log',expected='ACCUMULATOR RESTORE PASS\n'),dict(id='linker/wrap',file='wrap.log',expected='PCREL WRAP PASS\n'),dict(id='kermit/usage',file='kermit-help',contains='OS-9 Kermit'),
           dict(id='uuencode/roundtrip',file='decoded',binary=payload),
           dict(id='uudecode/independent',file='independent',binary=payload),
           dict(id='fixtext/tab',file='fixed',expected='A        B\n'),
           dict(id='uuname/local',file='local',expected='vbtest\n'),
           dict(id='uuname/systems',file='systems',expected='alpha\nbeta\n')]
commands=[item for i,c in enumerate(commands) for item in ('echo VBCMD'+str(i),c)]
commands += ['echo VBDONE']
put('startup', ('\r'.join(commands)+'\r').encode('ascii'))
tool('attr','-q','-npe','-npw','-pr','-ne','-w','-r',str(disk)+',startup')
fram=out/'state.fram';fram.unlink(missing_ok=True);log=out/'console.log'
with log.open('wb') as stream:
    proc=subprocess.Popen([str(a.emulator.resolve()),'--timeout=4000000000','-f',str(fram),'-d',str(disk),str(a.firmware.resolve())],stdout=stream,stderr=subprocess.STDOUT,stdin=subprocess.DEVNULL)
    try:
        deadline=time.monotonic()+a.seconds
        while proc.poll() is None and time.monotonic()<deadline:
            if b'VBDONE\n' in norm(log.read_bytes()):break
            time.sleep(.1)
    finally:
        if proc.poll() is None:proc.terminate()
        proc.wait(timeout=10)
console=norm(log.read_bytes());complete=b'VBDONE\n' in console
results=[]
for i,c in enumerate(checks):
    dest=out/('actual'+str(i));dest.unlink(missing_ok=True)
    found=tool('copy','-r',str(disk)+',VBTEST/'+c['file'],dest,check=False).returncode==0
    actual=dest.read_bytes() if found else b''
    good=complete and found
    if c.get('expected') is not None:
        # ppc reads the real guest clock; compare every other output byte.
        date=rb'\d\d/\d\d/\d\d  \d\d:\d\d:\d\d'
        good=good and re.sub(date,b'<clock>',norm(actual))==re.sub(date,b'<clock>',c['expected'].encode('ascii'))
    elif 'binary' in c:good=good and actual==c['binary']
    else:
        needles=c['contains'] if isinstance(c['contains'],list) else [c['contains']]
        good=good and all(n.encode('ascii') in actual for n in needles)
    for j,(path,expected) in enumerate(c.get('files',[])):
        f=out/('saved%d-%d'%(i,j));f.unlink(missing_ok=True)
        got=tool('copy','-r',str(disk)+',VBTEST/'+path,f,check=False).returncode==0
        good=good and got and f.read_bytes()==expected
    result=dict(id=c['id'],status='PASS' if good else 'FAIL',actual_hex=actual.hex())
    results.append(result);print(result['id'],result['status'],flush=True)
(out/'results.json').write_text(json.dumps(dict(complete=complete,cases=results),indent=2)+'\n')
if not complete:print(console.decode('latin1')[-2500:])
raise SystemExit(0 if complete and all(c['status']=='PASS' for c in results) else 1)
