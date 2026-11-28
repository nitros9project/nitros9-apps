#ifndef VG_HOST_OS_H
#define VG_HOST_OS_H
#include <errno.h>
#include <stdint.h>
typedef struct { unsigned char cc,a,b,dp; intptr_t x,y,u,s; } registers_6809;
int _os_syscall(int code, registers_6809 *regs);
int _gs_rdy(int path);
int vg_host_creat(const char *path, int mode);
char *itoa(int value, char *out);
void vg_test_pixel(int pixel);
#define creat vg_host_creat
#endif
