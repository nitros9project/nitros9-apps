/*
**      Parameter file for NRO word processor
**
*/
#include <stdio.h>
#include <ctype.h>
#include <os9.h>
#include <sgstat.h>

#define TRUE 1
#define FALSE 0

#define DEBUG
#ifdef MAIN
#define QQ
#else
#define QQ extern
#endif
#define  IG          0                              /* just ignore  */
#define  BP          1                            /* for UNIX nroff */
#define  PG          1                              /* begin page   */
#define  BR          2                              /* break        */
#define  CE          3                              /* center       */
#define  FI          4                              /* fill         */
#define  FO          5                              /* footer       */
#define  HE          6                              /* header       */
#define  TL          6                          /* UNIX nroff title */
#define  IN          7                              /* indent       */
#define  LS          8                              /* line spacing */
#define  NF          9                              /* no fill      */
#define  PL          10                             /* page lenght  */
#define  RM          11                             /* right margin */
#define  SP          12                             /* line space   */
#define  TI          13                             /* temp indent  */
#define  UL          14                             /* underline    */
#define  JU          15                             /* justify      */
#define  NJ          16                             /* no justify   */
#define  M1          17                             /* top margin   */
#define  M2          18                     /* second top margin    */
#define  M3          19                     /* first bottom margin  */
#define  M4          20                     /* bottom-most margin   */
#define  LT          21                          /* length of title */
#define  NE          22                             /* need n lines */
#define  PC          23                    /* page number character */
#define  CC          24                     /* control character    */
#define  PO          25                             /* page offset  */
#define  BO          26                             /* bold face    */
#define  EH          27     /* header for even numbered pages       */
#define  OH          28     /* header for odd numbered pages        */
#define  EF          29     /* footer for even numbered pages       */
#define  OF          30     /* footer for odd numbered pages        */
#define  SO          31                             /* source file  */
#define  CU          32                     /* continuous underline */
#define  MACRO       33                         /* macro definition */
#define  DE          34                        /* UNIX define macro */
#define  DM          34                             /* define macro */
#define  EN          99                     /* end macro definition */
#define  NR          35                     /* set number register  */
#define  BS          36            /* allow/disallow '\b' in output */
#define  EC          37                         /* escape character */
#define  DS          38                      /* define a string sub */
#define  PN          39                      /* set the page number */
#define  UNKNOWN     -1
#define  MAXTTL      133                              /* title size */
#define  MAXLINE     200         /* long enough for underline by bs */
#define  PAGELEN     66
#define  PAGEWIDTH   72
#define  HUGE        256
#define  RIGHT       1
#define  NFILES      6             /* nesting depth for input files */

#define  YES         1
#define  OK          1
#define  NO          0
#define  ERR         -1
#define  EOS         0

/*
 *      The parameter values selected for macro definitions
 *      are somewhat arbitrary.  MACBUF is the storage area
 *      for both macro names and definitions.  Since macro
 *      processing is handled by pushing back the expansion
 *      into the input buffer, the longest possible expansion
 *      would be MAXLINE characters.  Allowing for argument
 *      expansion, MXMLEN was chosen slightly less than MAXLINE.
 *      It is assumed that most macro definitions will not
 *      exceed 20 characters, hence MXMDEF of 100.
 */
#define  MXMLEN      150      /* maximum length of each  definition */
#define  MNLEN       10             /* maximum length of macro name */

typedef struct mnode {
   struct mnode *mlink;
   char  mname[3];
   char  *mdef;
   } MACS;

QQ MACS  *mhead;
QQ MACS  *shead;
QQ char  macname[MNLEN];
QQ char  macdef[MXMLEN];
QQ char  macbuf[MXMLEN];

QQ char  *ppb;                     /* pointer into push back buffer */
QQ char  pbb[MAXLINE];                          /* push back buffer */

QQ FILE  *fpstack[NFILES];
QQ char  ibuf[MAXLINE];                             /* input buffer */
/* control parameters for nro */
QQ int   fill;              /* fill if YES, init = YES              */
QQ int   lsval[2];          /* current line spacing, init = 1       */
QQ int   inval[2];          /* current indent, >= 0, init = 0       */
QQ int   rmval[2];          /* current right margin, init = 60      */
QQ int   tival;             /* current temp indent, init = 0        */
QQ int   ceval;             /* number of lines to center, init = 0  */
QQ int   ulval;           /* number of lines to underline, init = 0 */
QQ int   cuval;    /* no. lines to continuously underline, init = 0 */
QQ int   juval;             /* justify if YES, init = YES           */
QQ int   boval;           /* number of lines to bold face, init = 0 */
QQ int   bsflg;             /* can output contain '\b', init = TRUE */
QQ int   pgchr;             /* page number character, init = '#'    */
QQ int   cmdchr;            /* command character, init = '.'        */
QQ int   eschr;             /* escape character, init = '\'         */
QQ int   prflg;             /* print on or off, init = TRUE         */
QQ int   sprdir;            /* direction for spread(), init = 0     */
QQ int   flevel;          /* nesting depth for source cmd, init = 0 */
QQ int   nr[64];                            /* number registers     */

/* output buffer control parameters */
QQ int   sentence;                 /* true if found end of sentence */
QQ int   outp;      /* next avail char position in outbuf, init = 0 */
QQ int   outw;              /* width of text currently in buffer    */
QQ int   outwds;            /* number of words in buffer, init = 0  */
QQ char  outbuf[MAXLINE];           /* output of filled text        */
QQ char  wrdbuf[MAXLINE];           /* place to collect words in    */
QQ char  rsbuf[MAXLINE];            /* restrike buffer */

/* page control parameters for nro */
QQ int   curpag;            /* current output page number, init =0  */
QQ int   newpag;            /* next output page number, init = 1    */
QQ int   lineno;            /* next line to be printed, init = 0    */
QQ int   plval;             /* page length in lines, init = 66      */
QQ int   m1val[2];          /* margin before and including header   */
QQ int   m2val[2];          /* margin after header                  */
QQ int   m3val[2];          /* margin after last text line          */
QQ int   m4val[2];          /* bottom margin, including footer      */
QQ int   bottom;  /* last live line on page = plval - m3val - m4val */
QQ int   poval[2];          /* page offset from left, init = 0      */
QQ int   ltval[2];                             /* length of a title */
QQ int   frstpg;            /* first page to print, init = 0        */
QQ int   lastpg;            /* last page to print, init = 30000     */
QQ char  ehead[MAXTTL];     /* top of page title, init = '\0'       */
QQ char  ohead[MAXTTL];
QQ char  efoot[MAXTTL];     /* bottom of page title, init = '\0'    */
QQ char  ofoot[MAXTTL];
QQ char  *ehl, *ehc, *ehr, *ohl, *ohc, *ohr;     /* header pointers */
QQ char  *efl, *efc, *efr, *ofl, *ofc, *ofr;     /* footer pointers */
QQ char  ttlbuf[MAXTTL];                   /* place to build titles */
QQ char  temp[MAXTTL];                        /* title work scratch */

MACS  *getmac();
char  *skipbl();
char  *skipwd();
QQ int   debug; /* 1=comtyp,val,argtyp,getwrd;2=set;3=putwrd,getlin */

QQ struct sgbuf newstat, oldstat;
