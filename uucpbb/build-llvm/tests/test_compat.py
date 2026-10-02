#!/usr/bin/env python3
"""Host regression checks for the port's algorithms and clock conversion.
Kernel services are mocked; this does not replace OS-9 execution tests.
"""
import ctypes
from datetime import datetime, timezone
import os
from pathlib import Path
import sys
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]

class CompatibilityTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.temp = tempfile.TemporaryDirectory(prefix='uucpbb-tests-')
        work = Path(cls.temp.name)
        (work/'os9.h').write_text('int _os_time(unsigned char *);\n')
        (work/'mock.c').write_text('''
#include <errno.h>
#include <string.h>
static unsigned char packet[6];
static int error;
void set_clock(const unsigned char *p, int fail) { memcpy(packet,p,6); error=fail; }
int _os_time(unsigned char *p) { if (error) { errno=EIO; return error; } memcpy(p,packet,6); return 0; }
''')
        with (work/'mock.c').open('a') as mock:
            mock.write(r'''
#include <stdio.h>
static int paths[256], fail_kind, duplicate_calls, spawned_input, spawned_output;
static char spawned_name[80], spawned_args[80];
void reset_pipe(int failure) {
    memset(paths,0,sizeof(paths)); paths[0]=10; paths[1]=11; paths[2]=12;
    fail_kind=failure; duplicate_calls=0;
}
int live_paths(void) { int i,n=0; for(i=0;i<256;i++) n+=paths[i]!=0; return n; }
int path_token(int fd) { return paths[fd]; }
int child_input(void) { return spawned_input; }
int child_output(void) { return spawned_output; }
const char *child_name(void) { return spawned_name; }
const char *child_args(void) { return spawned_args; }
int uucpbb_open(const char *name, int mode) {
    int i;
    if (strcmp(name,"/pipe") || mode!=3 || fail_kind==4) return -1;
    for(i=0;i<256;i++) if(!paths[i]) { paths[i]=30; return i; }
    return -1;
}
int mock_dup(int fd) {
    int i;
    duplicate_calls++;
    if ((fail_kind==1 && duplicate_calls==2) || (fail_kind==5 && duplicate_calls==1)) return -1;
    for(i=0;i<256;i++) if(!paths[i]) { paths[i]=paths[fd]; return i; }
    return -1;
}
int mock_close(int fd) { paths[fd]=0; return 0; }
FILE *mock_fdopen(int fd,const char *mode) {
    (void)mode;
    return fail_kind==3 ? 0 : (FILE *)(long)(fd+8);
}
int mock_fileno(FILE *f) { return (int)((long)f-8); }
int mock_fclose(FILE *f) { return mock_close(mock_fileno(f)); }
int os9fork(const char *name,int length,const void *args,int type,int language,int pages) {
    (void)type; (void)language; (void)pages;
    spawned_input=paths[0]; spawned_output=paths[1];
    strcpy(spawned_name,name); memcpy(spawned_args,args,length); spawned_args[length]=0;
    return fail_kind==2 ? -1 : 42;
}
int wait(int *status) { *status=7; return 42; }
''')
        cc = os.environ.get('HOST_CC', '/usr/bin/clang' if sys.platform == 'darwin' else 'cc')
        cls.libpath = work/'compat.so'
        subprocess.run([cc, '-dynamiclib' if sys.platform == 'darwin' else '-shared', '-fPIC', '-std=gnu89', '-Wall', '-Wextra', '-Werror',
                        '-Ddup=mock_dup', '-Dclose=mock_close', '-Dfdopen=mock_fdopen',
                        '-Dfileno=mock_fileno', '-Dfclose=mock_fclose',
                        '-I'+str(work), '-I'+str(ROOT/'compat'),
                        str(ROOT/'compat/arguments.c'), str(ROOT/'compat/helpers.c'), str(ROOT/'compat/strings.c'),
                        str(ROOT/'compat/clock.c'), str(ROOT/'compat/pipes.c'), str(work/'mock.c'), '-o', str(cls.libpath)], check=True)
        cls.lib = ctypes.CDLL(str(cls.libpath), use_errno=True)
        cls.lib.uucpbb_time.argtypes = [ctypes.POINTER(ctypes.c_long)]
        cls.lib.uucpbb_time.restype = ctypes.c_long
        cls.lib.uucpbb_ctime.argtypes = [ctypes.POINTER(ctypes.c_long)]
        cls.lib.uucpbb_ctime.restype = ctypes.c_char_p
        cls.lib.set_clock.argtypes = [ctypes.c_void_p, ctypes.c_int]
        cls.lib.strhcpy.argtypes = [ctypes.c_void_p, ctypes.c_void_p]
        cls.lib.strhcpy.restype = ctypes.c_void_p
        cls.lib.htol.argtypes = [ctypes.c_char_p]
        cls.lib.htol.restype = ctypes.c_long
        cls.lib.patmatch.argtypes = [ctypes.c_char_p, ctypes.c_char_p, ctypes.c_int]
        cls.lib.findstr.argtypes = [ctypes.c_int, ctypes.c_char_p, ctypes.c_char_p]
        cls.lib.uucpbb_popen.argtypes = [ctypes.c_char_p, ctypes.c_char_p]
        cls.lib.uucpbb_popen.restype = ctypes.c_void_p
        cls.lib.uucpbb_pclose.argtypes = [ctypes.c_void_p]
        cls.lib.uucpbb_module_name.argtypes = [ctypes.c_char_p]
        cls.lib.uucpbb_module_name.restype = ctypes.c_void_p
        cls.lib.uucpbb_parameters.argtypes = [ctypes.c_void_p, ctypes.c_int]
        cls.lib.uucpbb_parameters.restype = ctypes.c_void_p
        cls.lib.free.argtypes = [ctypes.c_void_p]
        cls.lib.child_name.restype = ctypes.c_char_p
        cls.lib.child_args.restype = ctypes.c_char_p
        cls.lib.crc.argtypes = [ctypes.c_void_p, ctypes.c_int, ctypes.c_void_p]

    @classmethod
    def tearDownClass(cls):
        cls.temp.cleanup()

    def test_clock_boundaries(self):
        for date in [(1900,1,1,0,0,0), (1969,12,31,23,59,59), (1970,1,1,0,0,0),
                     (2000,2,29,12,34,56), (2026,10,1,20,25,11), (2038,1,19,3,14,8),
                     (2100,3,1,0,0,0), (2155,12,31,23,59,59)]:
            with self.subTest(date=date):
                packet = (ctypes.c_ubyte*6)(date[0]-1900, *date[1:])
                self.lib.set_clock(packet, 0)
                result = ctypes.c_long(-123)
                expected = int(datetime(*date, tzinfo=timezone.utc).timestamp())
                self.assertEqual(self.lib.uucpbb_time(ctypes.byref(result)), expected)
                self.assertEqual(result.value, expected)
                self.assertIn(str(date[0]).encode(), self.lib.uucpbb_ctime(ctypes.byref(result)))

    def test_clock_error_preserves_output(self):
        packet = (ctypes.c_ubyte*6)(126,10,1,0,0,0)
        self.lib.set_clock(packet, 1)
        output=ctypes.c_long(123)
        self.assertEqual(self.lib.uucpbb_time(ctypes.byref(output)), -1)
        self.assertEqual(output.value, 123)
        self.assertNotEqual(ctypes.get_errno(), 0)

    def test_invalid_leap_day(self):
        self.lib.set_clock((ctypes.c_ubyte*6)(200,2,29,0,0,0), 0)
        self.assertEqual(self.lib.uucpbb_time(None), -1)

    def test_high_bit_name_copy(self):
        output=ctypes.create_string_buffer(16)
        self.assertEqual(self.lib.strhcpy(output,b'co\xefo'),ctypes.addressof(output))
        self.assertEqual(output.value,b'coo')
        self.lib.strhcpy(output, b'/term\0')
        self.assertEqual(output.value,b'/term')

    def test_pattern_and_position(self):
        for pattern,text,case,want in [(b'*uuxqt*',b'42 UUXQT',1,1),
            (b'*uuxqt*',b'42 UUXQT',0,0), (b'a?c',b'abc',0,1),
            (b'a?c',b'ac',0,0), (b'*',b'',0,1), (b'foo',b'foobar',0,0)]:
            self.assertEqual(self.lib.patmatch(pattern,text,case),want)
        self.assertEqual(self.lib.findstr(1,b'xxFrom bob',b'From '),3)
        self.assertEqual(self.lib.findstr(4,b'xxFrom bob',b'From '),0)
        self.assertEqual(self.lib.findstr(0,b'abc',b'a'),0)
        self.assertEqual(self.lib.htol(b'  FfAa12'),0xffaa12)

    def test_kernel_argument_terminators(self):
        for source,want in [(b'program\n',b'program'),(b'program\r',b'program'),(b'program',b'program')]:
            pointer=self.lib.uucpbb_module_name(source)
            self.assertEqual(ctypes.string_at(pointer),want)
            self.lib.free(pointer)
        source=ctypes.create_string_buffer(b'hello\n')
        pointer=self.lib.uucpbb_parameters(source,6)
        self.assertEqual(ctypes.string_at(pointer),b'hello\r')
        self.assertEqual(source.value,b'hello\n')
        self.lib.free(pointer)
        self.assertFalse(self.lib.uucpbb_parameters(None,1))
        self.assertFalse(self.lib.uucpbb_module_name(b'\n'))

    def test_pipe_redirection_and_wait(self):
        for mode in (b'r', b'w'):
            with self.subTest(mode=mode):
                self.lib.reset_pipe(0)
                stream=self.lib.uucpbb_popen(b'fileserv hello world',mode)
                self.assertTrue(stream)
                self.assertEqual(self.lib.child_name(),b'fileserv')
                self.assertEqual(self.lib.child_args(),b'hello world\r')
                self.assertEqual(self.lib.child_output() if mode==b'r' else self.lib.child_input(),30)
                self.assertEqual([self.lib.path_token(i) for i in range(3)],[10,11,12])
                self.assertEqual(self.lib.live_paths(),4)
                self.assertEqual(self.lib.uucpbb_pclose(stream),7)
                self.assertEqual(self.lib.live_paths(),3)

    def test_pipe_failure_cleanup(self):
        for failure in range(1,6):
            with self.subTest(failure=failure):
                self.lib.reset_pipe(failure)
                self.assertFalse(self.lib.uucpbb_popen(b'fileserv hello',b'r'))
                self.assertEqual(self.lib.live_paths(),3)
                self.assertEqual([self.lib.path_token(i) for i in range(3)],[10,11,12])

    def test_crc_matches_real_module(self):
        binary=(ROOT/'out/Os/uuencode').read_bytes()
        state=(ctypes.c_ubyte*3)(255,255,255)
        data=ctypes.create_string_buffer(binary[:-3])
        self.lib.crc(data,len(binary)-3,state)
        self.assertEqual(bytes(b ^ 255 for b in state),binary[-3:])
        state2=(ctypes.c_ubyte*3)(255,255,255)
        for part in (binary[:9],binary[9:-3]):
            buf=ctypes.create_string_buffer(part)
            self.lib.crc(buf,len(part),state2)
        self.assertEqual(bytes(state2),bytes(state))

if __name__=='__main__':
    unittest.main()
