#ifndef SLED_PORT_H
#define SLED_PORT_H
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>
#include <os.h>
#include <setjmp.h>
#include <signal.h>
#define direct
#ifdef SLED_LLVM
#define system cmoc_system
#endif
int sled_key(void);
#undef getchar
#define getchar sled_key
/* The SCF option packet is exactly 32 bytes on OS-9/6809. */
struct termopts {
 char op_class,op_case,op_backsp,op_delete,op_echo,op_alf,op_nulls,
 op_pause,op_page,op_bspch,op_dlnch,op_eorch,op_eofch,op_rlnch,
 op_dulnch,op_psch,op_kbich,op_kbach,op_bsech,op_bellch,
 op_parity,op_baud,rest[10];
};
struct registers {int rg_x,rg_y; char rg_a,rg_b;};
#define I_GETSTT 0x8d
#ifndef EOL
#define EOL '\r'
#endif
int sled_os9(int code, struct registers *r);
#define _os9 sled_os9
int slgetopt(int code,int path,void *buf);
int slsetopt(int code,int path,void *buf);
#define getstat slgetopt
#define setstat slsetopt
int _gs_styp(int path,int *type);
int _gs_palt(int path,char *pal);
int _gs_fbrg(int path,int *fg,int *bg,int *border);
int CurXY(int path,int x,int y);
int CurOn(int path);
int CurOff(int path);
int InsLin(int path);
int DelLin(int path);
int FColor(int path,int color);
int BColor(int path,int color);
int Border(int path,int color);
int Palette(int path,int index,int color);
int CWArea(int path,int x,int y,int w,int h);
int OWSet(int path,int save,int x,int y,int w,int h,int fg,int bg);
int OWEnd(int path);
int sled_temp(char *name);
#define mktemp sled_temp
void sled_sleep(int ticks);
#define tsleep sled_sleep
#endif
