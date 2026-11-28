#ifndef APPS_VBCC_PORT_H
#define APPS_VBCC_PORT_H
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <errno.h>
#include "cmoc_os9.h"
typedef cmoc_sighandler_t sighandler_t;
#define direct
#define system cmoc_system
#define wait cmoc_wait
#define signal cmoc_signal
#define open cmoc_open
#define creat cmoc_creat
#define access cmoc_access
#define itoa cmoc_itoa
#ifndef E_NOTRDY
#define E_NOTRDY 246
#endif
#ifndef E_FULL
#define E_FULL 248
#endif
#define SS_SCSIZ 0x26
#define I_GETSTT 0x8d
#define I_SETSTT 0x8e
#define _ss_size vb_ss_size
int vb_ss_size(int,unsigned long);
int vb_getstat(int,int,...);
#define getstat vb_getstat
int vb_setstat(int,int,...);
#define setstat vb_setstat
int _os9(int,struct registers *);
#define findstr vb_findstr
int vb_findstr(int,const char *,const char *);
#define index strchr
#define rindex strrchr
struct sgtbuf {unsigned char t_year,t_month,t_day,t_hour,t_minute,t_second;};
char *mktemp(char *);
int __isatty(int);
int getime(void *);
char *strend(char *);
time_t uucpbb_time(time_t *);
char *uucpbb_ctime(const time_t *);
int uucpbb_open(const char *,int);
int uucpbb_creat(const char *,int);
int uucpbb_access(const char *,int);
int uucpbb_mknod(const char *,int);
int uucpbb_chown(const char *,unsigned);
int uucpbb_compare(const void *,const void *);
FILE *uucpbb_popen(const char *,const char *);
int uucpbb_pclose(FILE *);
char *strhcpy(char *,const char *);
int getopt(int,char **,const char *);
extern int optind,opterr;
extern char *optarg;
#endif
