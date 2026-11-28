#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include "os.h"

int _os_syscall(int code, registers_6809 *regs)
{
    (void)code; (void)regs;
    errno=ENOSYS;
    return -1;
}
int _gs_rdy(int path) { (void)path; return 0; }
int vg_host_creat(const char *path,int mode)
{
    (void)mode;
    return open(path,O_WRONLY|O_CREAT|O_TRUNC,0600);
}
char *itoa(int value,char *out) { sprintf(out,"%d",value); return out; }
static FILE *trace;
static void finish_trace(void) { if (trace) fclose(trace); }
void vg_test_pixel(int pixel)
{
    if (!trace) {
        const char *path=getenv("VIEWGIF_PIXEL_TRACE");
        if (!path || !(trace=fopen(path,"wb"))) exit(99);
        atexit(finish_trace);
    }
    if (putc(pixel,trace)==EOF) exit(99);
}
