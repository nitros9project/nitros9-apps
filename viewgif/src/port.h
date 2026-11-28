#ifndef VIEWGIF_PORT_H
#define VIEWGIF_PORT_H
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>
#include <os.h>
#ifdef VIEWGIF_LLVM
#define open cmoc_open
#define creat cmoc_creat
#define itoa cmoc_itoa
#endif
#ifdef VIEWGIF_C3
typedef char vg_byte; /* C3 chars already hold unsigned byte values. */
#else
typedef unsigned char vg_byte;
#endif
/* CMOC's built-in printf otherwise pulls in a second formatting engine. */
#ifdef VIEWGIF_CMOC
#define VG_INFO(...) fprintf(stdout,__VA_ARGS__)
#else
#define VG_INFO printf
#endif
/* CoCo palette indices fit in four bits. */
struct trantype { char addval; char maps; };
#define VG_MAP1(e) ((e).maps & 15)
#define VG_MAP2(e) (((unsigned)(e).maps >> 4) & 15)
#define VG_SET1(e,v) ((e).maps=((e).maps & 0xf0)|((v)&15))
#define VG_SET2(e,v) ((e).maps=((e).maps & 15)|(((v)&15)<<4))
#if defined(VIEWGIF_LLVM) || defined(VIEWGIF_TEST_NUMBERS)
int vg_atoi(char *text);
#else
#define vg_atoi atoi
#endif
int addbyte(vg_byte c);
int addpixel(int c);
int bell(void);
int checksig(void);
int colorval(int r, int g, int b);
int curoff(void);
int cval(char * cm);
int doline(void);
int dwend(void);
int dwset(int sty);
int error(char * str, int errnum);
int fatal(char * str);
int fixgmap(void);
int flushwin(void);
int getblk(int grp, int bfn, int row);
int initwin(void);
int initwin2(void);
int killbuf(int grp, int bfn);
int killwind(void);
int makerand(void);
int vg_rand(void);
int minadd(vg_byte * colors, int add);
int minadd2(vg_byte * colors, int add);
int ncolor(char * cm1, char * cm2, int r, int g, int b);
int nearcolr(char * cm1, char * cm2);
int newwin(void);
int newwind(void);
int palette(int prn, int ctn);
int process(int code);
int putblk(int grp, int bfn, int row);
int rand85(int n);
int readext(void);
int readimag(void);
int readrast(unsigned width, unsigned height);
int readscrn(void);
int readuse(void);
int saveimag(void);
int setmap(void);
int setmap2(void);
int toler2(char * cm1, char * cm2, int r, int g, int b);
int tolerval(char * cm, int r, int g, int b);
int usage(void);
int waituser(void);
int writechr(char c);
int writemem(char * str, int size);
int writestr(int file, char * str);
int writeuse(void);
int vg_sleep(int ticks);
int vg_select(void);
int vg_attach(char * str);
int vg_detach(int dte);
int vg_procid(void);
int vg_ready(int path);
char * vg_mapgpb(int path, int grp, int bfn, int action);
#endif
