/* os9inc.h
 * OS-9 kermit includes, defines, and global variable declarations */

#define VERSION 21  /* Unix-OS-9 Version number  */
#define RELEASE 5   /* Update release */

/* most conditional compilation has been removed.    */
#define OS9     1   /* OS-9 */

#include <time.h>

#ifdef COCO
/* coco cannot handle floppy and other i/o at the same time */
#define nooverlap
#endif

#ifndef EXTERN
#define EXTERN extern  /* global varibles are extern in all but one module */
#endif

#ifdef OSK
#define DIRECT
#else
#ifndef DIRECT
#define DIRECT direct
#endif
#endif

#include <stdio.h>       /* Standard UNIX definitions */

#ifndef OSK
#define sleep(sec) tsleep((sec) * tps + 1)
#endif

#include <signal.h>
#include <setjmp.h>

/* Symbol Definitions */

#define MAXPACKSIZ  94      /* Maximum packet size */
#define MAXCODE      5      /* Maximum code length for a byte */

#define SOH          1      /* Start of header */
#define CR          13      /* ASCII Carriage Return */
#define SP          32      /* ASCII space */
#define DEL        127      /* Delete (rubout) */

#define ESCCHR     '#'      /* Escape character (Unix doesn't use me much) */

#define MAXTRY       5      /* Times to retry a packet */
#define MYQUOTE    '#'      /* Quote character I will use */
#define MY8QUOTE   '&'      /* Eighth-bit quote character (if you insist) */
#define MYREPEAT   '~'      /* Repeat prefix I will use */
#define MYPAD        0      /* Number of padding characters I will need */
#define MYPCHAR      0      /* Padding character I need (NULL) */

#define MYEOL     '\n'      /* End-Of-Line character I need */

#define UNKNOWN     -1      /* Haven't seen other side's 8th-bit info */
#define WILLING      0      /* Other side is willing to quote 8th bit */
#define REQUESTED    1      /* Other side wants 8th-bit quoting */
#define REFUSED      2      /* Other side refuses to do 8th-bit quoting */

#define MYTIME      10      /* Seconds after which I should be timed out */
#define MAXTIM      60      /* Maximum timeout interval */
#define MINTIM       2      /* Minumum timeout interval */

#define ONECHARCHK  '1'     /* one-char checksum */
#define TWOCHARCHK  '2'     /* two-char checksum */
#define CCITTCHK    '3'     /* CCITT 16-bit CRC */

#define STOPCUR     ctl('X')
#define STOPALL     ctl('Z')

#define TRUE        -1      /* Boolean constants */
#define FALSE        0

/* Macro Definitions */

/* tochar:  converts a control character to a printable one by adding a space.
 * unchar:  undoes tochar.
 * ctl:     converts between control characters and printable characters by
 *          toggling the control bit (ie. ^A becomes A and A becomes ^A).  */

#define tochar(ch)    ((ch) + ' ')
#define unchar(ch)    ((ch) - ' ')
#define ctl(ch)       ((ch) ^ 64 )


/* Global Variables */
extern int          errno;          /* System error number */
EXTERN DIRECT int   size;           /* Size of present data */
EXTERN DIRECT int   rpsiz;          /* Maximum receive packet size */
EXTERN DIRECT int   spsiz;          /* Maximum send packet size */
EXTERN DIRECT int   pad;            /* How much padding to send */
EXTERN DIRECT int   timint;         /* Timeout for foreign host on sends */
EXTERN DIRECT int   n;              /* Packet number */
EXTERN DIRECT int   numtry;         /* Times this packet retried */
EXTERN DIRECT int   oldtry;         /* Times previous packet retried */
EXTERN DIRECT int   ttyfd;          /* path # of tty for I/O, 0->remote */
EXTERN DIRECT int   server;         /* Host server mode flag */
EXTERN DIRECT int   hflg;           /* Host Server flag */
EXTERN DIRECT int   rptflg;         /* Run-length enable flag */
EXTERN DIRECT int   bit8flag;       /* Eighth-bit quote flag */
EXTERN DIRECT int   bit8status;     /* Eighth-bit quoting status */
EXTERN DIRECT int   gflg;           /* Get file flag */
EXTERN DIRECT int   kflg;           /* Received data to stdout */
EXTERN DIRECT int   local;          /* TRUE means we're a local kermit */
EXTERN DIRECT int   image;          /* TRUE means 8-bit mode */
EXTERN DIRECT int   debug;          /* debugging output level (0 = none) */
EXTERN DIRECT int   filnamcnv;      /* TRUE => file name case conversion */
EXTERN DIRECT int   wantxon;        /* TRUE => don't mung xon/xoff */
EXTERN DIRECT int   filecount;      /* Number of files left to send */
EXTERN DIRECT int   bctu;           /* Which checksum type */
EXTERN DIRECT int   bctr;           /* Requested checksum type */
EXTERN DIRECT int   cx;             /* Cancel current file */
EXTERN DIRECT int   cz;             /* Cancel entire batch */
EXTERN DIRECT int   sentxz;         /**/

EXTERN DIRECT char  state;                  /* automaton's present state */
EXTERN char         rpack();                /* Function to receive packet  */
EXTERN DIRECT char  padchar;                /* Padding character to send */
EXTERN DIRECT char  eol;                    /* End-Of-Line character to send */
EXTERN DIRECT char  escchr;                 /* Connect escape character */
EXTERN DIRECT char  quote;                  /* other guy's quote char */
EXTERN DIRECT char  quote8;                 /* other guy's 8th-bit quote */
EXTERN DIRECT char  rptq;                   /* other guy's repeat character */
EXTERN DIRECT char  **filelist;             /* List of files to be sent */
EXTERN DIRECT char  *filnam;                /* Current file name */
EXTERN char         recpkt[MAXPACKSIZ];     /* Receive packet buffer */
EXTERN char         packet[MAXPACKSIZ + 5]; /* Packet buffer */
EXTERN int          catcher();              /* intercept routine */

EXTERN DIRECT FILE  *fp;                    /* => current disk file */
EXTERN DIRECT FILE  *log;                   /* => Logfile */

EXTERN jmp_buf      env;                    /* for timeout longjump */

#include <sgstat.h>
EXTERN
struct sgbuf insave, outsave, linesave;     /* scf modes for devices */

