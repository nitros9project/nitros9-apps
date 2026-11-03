/*
 * The routines in this file provide support for ANSI style terminals
 * over a serial line. The serial I/O services are provided by routines in
 * "termio.c". It compiles into nothing if not an ANSI device.
 */

#include        <stdio.h>
#include        "ueed.h"

#ifdef ANSI
#ifdef OS9
#include        <os9.h>
#endif

#define NROW    24                      /* Screen size if the terminal  */
#define NCOL    80                      /* does not say.                */
#define BEL     0x07                    /* BEL character.               */
#define ESC     0x1B                    /* ESC character.               */

extern  int     ttopen();               /* Forward references.          */
extern  int     ttgetc();
extern  int     ttputc();
extern  int     ttflush();
extern  int     ttclose();
extern  int     ansimove();
extern  int     ansieeol();
extern  int     ansieeop();
extern  int     ansibeep();
extern  int     ansiopen();

/*
 * Standard terminal interface dispatch table. Most of the fields point into
 * "termio" code.
 */
TERM    term    = {
        NROW-1,
        NCOL,
        ansiopen,
        ttclose,
        ttgetc,
        ttputc,
        ttflush,
        ansimove,
        ansieeol,
        ansieeop,
        ansibeep
};

ansimove(row, col)
{
        ttputc(ESC);
        ttputc('[');
        ansiparm(row+1);
        ttputc(';');
        ansiparm(col+1);
        ttputc('H');
}

ansieeol()
{
        ttputc(ESC);
        ttputc('[');
        ttputc('K');
}

ansieeop()
{
        ttputc(ESC);
        ttputc('[');
        ttputc('J');
}

ansibeep()
{
        ttputc(BEL);
        ttflush();
}

ansiparm(n)
register int    n;
{
        register int    q;

        q = n/10;
        if (q != 0)
                ansiparm(q);
        ttputc((n%10) + '0');
}

#ifdef OS9
#define SS_READY 0x01                   /* GetStat: is input waiting?   */
#define SS_SCSIZ 0x26                   /* GetStat: screen size         */
#define MAXROW  127                     /* A window's rows are a char.  */
#define MAXCOL  255
#define WAITTKS 30                      /* Ticks to wait for a reply.   */

/*
 * Ask about the terminal: an I$GetStt call on the standard input path.
 * Return 0 and the registers it answered with, or -1 if it failed.
 */
ansistat(code, rp)
int     code;
struct registers *rp;
{
        rp->rg_a = 0;
        rp->rg_b = code;
        return (_os9(I_GETSTT, rp));
}

/*
 * Read one byte of the terminal's reply, or return -1 if none arrives within
 * WAITTKS ticks.
 */
ansiwait()
{
        register int    t;
        struct registers r;

        for (t = 0; t < WAITTKS; ++t) {
                if (ansistat(SS_READY, &r) == 0)
                        return (ttgetc() & 0xFF);
                tsleep(1);
        }
        return (-1);
}

/*
 * Read a decimal number from the reply into *np, and return the byte that
 * ends it, or -1 if the reply stops.
 */
ansinum(np)
int     *np;
{
        register int    c;

        *np = 0;
        while ((c = ansiwait()) >= '0' && c <= '9')
                *np = *np * 10 + c - '0';
        return (c);
}

/*
 * Find the screen size. Send the cursor to row 999, column 999 and ask where
 * it went, as xterm's resize does: a VT100-class terminal stops it at its
 * last row and column and answers ESC [ rows ; cols R. ESC 7 and ESC 8 put
 * the cursor back. If nothing answers, take the size the device reports
 * through SS.ScSiz. If that fails too, keep the compiled-in size.
 */
ansisize()
{
        int     rows;
        int     cols;
        struct registers r;

        ttputc(ESC);
        ttputc('7');
        ttputc(ESC);
        ttputc('[');
        ansiparm(999);
        ttputc(';');
        ansiparm(999);
        ttputc('H');
        ttputc(ESC);
        ttputc('[');
        ttputc('6');
        ttputc('n');
        ttputc(ESC);
        ttputc('8');
        ttflush();
        if (ansiwait() != ESC || ansiwait() != '['
        || ansinum(&rows) != ';' || ansinum(&cols) != 'R') {
                if (ansistat(SS_SCSIZ, &r) != 0)
                        return;
                cols = r.rg_x;
                rows = r.rg_y;
        }
        if (rows < 2 || cols < 2)
                return;
        term.t_nrow = (rows > MAXROW ? MAXROW : rows) - 1;
        term.t_ncol = cols > MAXCOL ? MAXCOL : cols;
}
#endif

#endif

ansiopen()
{
#ifdef V7
        register char *cp;
        char *getenv();

        if ((cp = getenv("TERM")) == NULL) {
                puts("Shell variable TERM not defined!");
                exit(1);
        }
        if (strcmp(cp, "vt100") != 0) {
                puts("Terminal type not 'vt100'!");
                exit(1);
        }
#endif
        ttopen();
#ifdef ANSI
#ifdef OS9
        ansisize();
#endif
#endif
}

