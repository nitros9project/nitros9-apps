/*
 * sort.h - shared definitions for sort, a text sort for OS-9/6809.
 *
 * Lines are read into one arena: text grows up from the bottom and a
 * record for each line grows down from the top.  When the arena is full
 * its records are sorted and written to a temporary file as a run; the
 * runs are then merged.  Input that fits in one arena never touches a
 * temporary file.
 *
 * K&R C, for both c3 and the Microware cc1: no prototypes, no void, no
 * struct assignment, no unsigned char.
 */

#include <stdio.h>

#define CR      13
#define MAXKEYS 8       /* -k options */
#define MAXRUNS 256     /* runs waiting to be merged */
#define MAXFAN  12      /* runs merged at once: 16 paths less stdin,
                           stdout, stderr and the output */
#define TNAMSIZ 80      /* temporary file pathname */

/* exit statuses are OS-9 error numbers, so the shell's message fits */
#define EX_OK    0
#define EX_USAGE 187    /* E$IllArg: illegal argument */
#define EX_MEM   207    /* E$MemFul: memory full */
#define ERRCODE  (errno ? errno : 1)    /* after a failed system call */

/* a sort key: fields and characters count from 1; f2 == 0 means to the
   end of the line and c2 == 0 to the end of field f2 */
struct key {
        int f1, c1, f2, c2;
};

/* one line: its text (without the CR) and its first key */
struct rec {
        char *t;
        unsigned l;
        char *k;
        unsigned kl;
};

/* a run waiting in a temporary file */
struct run {
        int id;                 /* temporary file number */
        long size;              /* bytes */
        long lines;
};

/* options */
extern int rflag, fflag, nflag, bflag, uflag, vflag;
extern int tchar;               /* field separator, or -1 for blanks */
extern struct key keys[];
extern int nkeys;
extern char *outname;           /* -o, or NULL for stdout */
extern char *tdir;              /* -T, or NULL for the default */
extern int aborted;             /* signal received, or 0 */
extern int errno;

/* the arena */
extern char *abase, *atop;
extern unsigned asize;
extern unsigned maxlen;         /* longest line seen */
extern long tlines, tbytes;     /* totals read */

/* the runs */
extern struct run runs[];
extern int nruns;

/* compare.c */
extern int fold[];
int initcmp();
int keyfind();
int cmprec();
int setkey();

/* msort.c */
struct rec **msort();

/* input.c */
int inopen();
int readarena();
int resetarena();
unsigned nrecs();
struct rec *recbase();

/* runs.c */
int initruns();
int newrun();
int openrun();
int killrun();
int cleanup();
int fail();
int checkabort();
int wopen();
int wput();
int wclose();
long writerecs();
extern long wbytes;

/* merge.c */
int mergeall();

char *sbrk();
