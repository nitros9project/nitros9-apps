#ifndef UUCPBB_LLVM_COMPAT_H
#define UUCPBB_LLVM_COMPAT_H
#include <stdio.h>
#include <time.h>
#include <errno.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>
/* The original compiler supplied these declarations implicitly. */
char *strend(char *);
int strucmp(const char *, const char *);
int strnucmp(const char *, const char *, unsigned int);
long _gs_size(int);
int _errmsg(int, const char *, ...);
struct sgtbuf {
    unsigned char t_year, t_month, t_day, t_hour, t_minute, t_second;
};
time_t uucpbb_time(time_t *);
char *uucpbb_ctime(const time_t *);
int getime(struct sgtbuf *);
long o2utime(const struct sgtbuf *);
int uucpbb_open(const char *, int);
int uucpbb_access(const char *, int);
int uucpbb_creat(const char *, int);
int uucpbb_mknod(const char *, int);
int uucpbb_chown(const char *, unsigned);
int uucpbb_compare(const void *, const void *);
FILE *uucpbb_popen(const char *, const char *);
int uucpbb_pclose(FILE *);
#define I_GETSTT 0x8d
#define I_SETSTT 0x8e
int _ss_size(int, unsigned long);
int findstr(int, const char *, const char *);
char *strhcpy(char *, const char *);
long htol(const char *);
#define SIGWAKE 1
#define E_DEVBSY 250
#define E_SHARE 253
#define SS_DEVNM 14
#define SS_BREAK 29
struct registers {
    unsigned char rg_cc, rg_a, rg_b, rg_dp;
    unsigned rg_x, rg_y, rg_u;
};
#define F_UNLOAD 0x1d
int _os9(int, struct registers *);
#endif
