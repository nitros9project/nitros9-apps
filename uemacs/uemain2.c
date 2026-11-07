/*
 * This program is in public domain; written by Dave G. Conroy.
 * This file contains the main driving routine, and some keyboard processing
 * code, for the MicroEMACS screen editor.
 *
 * REVISION HISTORY:
 *
 * 1.0  Steve Wilhite, 30-Nov-85
 *      - Removed the old LK201 and VT100 logic. Added code to support the
 *        DEC Rainbow keyboard (which is a LK201 layout) using the the Level
 *        1 Console In ROM INT. See "rainbow.h" for the function key definitions
.
 *
 * 2.0  George Jones, 12-Dec-85
 *      - Ported to Amiga.
 */
#include        <stdio.h>
#include        "ueed.h"
#ifdef VMS
#include        <ssdef.h>
#define GOOD    (SS$_NORMAL)
#endif

#ifndef GOOD
#define GOOD    0
#endif

#include "uemain.h"
        
/*
 * This is the general command execution routine. It handles the fake binding
 * of all the keys to "self-insert". It also clears out the "thisflag" word,
 * and arranges to move it to the "lastflag", so that the next command can
 * look at it. Return the status of command.
 */
execute(c, f, n)
int c,f,n;
{
        register KEYTAB *ktp;
        int status;

        status = TRUE;
        ktp = &keytab[0];                       /* Look in key table.   */
        while (ktp->k_code) {
                if (ktp->k_code == c) {
                        thisflag = 0;
                        status = (*ktp->k_fp)(f, n);
                        lastflag = thisflag;
                        return(status);
                }
                ++ktp;
        }

        /*
         * If a space was typed, fill column is defined, the argument is non-
         * negative, and we are now past fill column, perform word wrap.
         */
        if (c == ' ' && fillcol > 0 && n>=0 && getccol(FALSE) > fillcol)
                wrapword();

        if ((c>=0x20 && c<=0x7E)                /* Self inserting.      */
        ||  (c>=0xA0 && c<=0xFE)) {
                if (n <= 0) {                   /* Fenceposts.          */
                        lastflag = 0;
                }
                thisflag = 0;                   /* For the future.      */
                linsert(n, c);
                lastflag = thisflag;
                return(TRUE);
        } else {
                lastflag = 0;                   /* Fake last flags.     */
                return(FALSE);
        }
}

/*
 * Read in a key.
 * Do the standard keyboard preprocessing. Convert the keys to the internal
 * character set.
 */
getkey()
{
        register int    c;

        c = (*term.t_getchar)();
#ifdef DEBUG
        printf("%4X",c);
#endif

#ifdef RAINBOW

        if (c & Function_Key)
                {
                int i;

                for (i = 0; i < lk_map_size; i++)
                        if (c == lk_map[i][0])
                                return lk_map[i][1];
                }
        else if (c == Shift + 015) return CTRL | 'J';
        else if (c == Shift + 0x7F) return META | 0x7F;
#endif

#ifdef ANSI
#ifdef OS9
        if ((c & 0xFF) >= 0x80 && (c & 0xFF) <= 0x9F)
                return (ptkey(c & 0xFF));
#endif
#endif

        if (c == METACH) {                      /* Apply M- prefix      */
#ifdef DEBUG
                printf("META");
#endif
                c = getctl();
#ifdef DEBUG
                printf("CTL=%4X",c);
#endif
#ifdef ANSI
                if (c == '[')                   /* ANSI cursor key?     */
                        return (ansikey());
#endif
                return (META | c);
        }

        if (c>=0x00 && c<=0x1F)                 /* C0 control -> C-     */
                c = CTRL | (c+'@');
#ifdef DEBUG
        printf("CTRL=%4X",c);
#endif
        return (c);
}

#ifdef ANSI
#ifdef OS9
/*
 * Map a Pico-Thing cursor or editing key, which arrives as one byte from $80
 * to $9F, to the command it stands for. Shift and the arrows act as the
 * arrows alone; Ctrl-Left and Ctrl-Right move by words, Ctrl-Up and
 * Ctrl-Down go to the start and end of the buffer. The pound sign ($9C) is
 * text. Any other key in the range, a function key or Insert, comes back as
 * the unbound M-[.
 */
ptkey(c)
register int    c;
{
        switch (c) {
        case 0x8C:                              /* Up                   */
        case 0x90:
                return (CTRL | 'P');
        case 0x8D:                              /* Down                 */
        case 0x91:
                return (CTRL | 'N');
        case 0x8E:                              /* Left                 */
        case 0x92:
                return (CTRL | 'B');
        case 0x8F:                              /* Right                */
        case 0x93:
                return (CTRL | 'F');
        case 0x94:                              /* Ctrl-Up              */
                return (META | '<');
        case 0x95:                              /* Ctrl-Down            */
                return (META | '>');
        case 0x96:                              /* Ctrl-Left            */
                return (META | 'B');
        case 0x97:                              /* Ctrl-Right           */
                return (META | 'F');
        case 0x98:                              /* Home                 */
                return (CTRL | 'A');
        case 0x99:                              /* End                  */
                return (CTRL | 'E');
        case 0x9A:                              /* Page Up              */
                return (META | 'V');
        case 0x9B:                              /* Page Down            */
                return (CTRL | 'V');
        case 0x9C:                              /* Pound sign           */
                return (c);
        case 0x9E:                              /* Delete               */
                return (CTRL | 'D');
        }
        return (META | '[');
}
#endif

/*
 * Finish reading an ANSI key sequence after ESC [.  Parameters run up to a
 * final byte in @ to ~.  The arrows act as C-P, C-N, C-F and C-B; any other
 * sequence is consumed whole, so its bytes are not inserted as text, and
 * comes back as the unbound M-[.
 */
ansikey()
{
        register int    c;
        int             plain;

        plain = TRUE;
        while ((c = (*term.t_getchar)()) < '@' || c > '~')
                plain = FALSE;
        if (plain) {
                switch (c) {
                case 'A':
                        return (CTRL | 'P');
                case 'B':
                        return (CTRL | 'N');
                case 'C':
                        return (CTRL | 'F');
                case 'D':
                        return (CTRL | 'B');
                }
        }
        return (META | '[');
}
#endif

/*
 * Get a key.
 * Apply control modifications to the read key.
 */
getctl()
{
        register int    c;

        c = (*term.t_getchar)();
        if (c>='a' && c<='z')                   /* Force to upper       */
                c -= 0x20;
        if (c>=0x00 && c<=0x1F)                 /* C0 control -> C-     */
                c = CTRL | (c+'@');
        return (c);
}

/*
 * Fancy quit command, as implemented by Norm. If the current buffer has
 * changed do a write current buffer and exit emacs, otherwise simply exit.
 */
quickexit(f, n)
{
        if ((curbp->b_flag&BFCHG) != 0          /* Changed.             */
        && (curbp->b_flag&BFTEMP) == 0)         /* Real.                */
                filesave(f, n);
        quit(f, n);                             /* conditionally quit   */
}

