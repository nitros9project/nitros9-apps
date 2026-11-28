/*
**              SLED6.C
**
**              This file contains all the screen processing functions
**              that are used in SLED.  Only these functions and the
**              defines in the header SLEDEF.H need to be changed for
**              different terminal types or systems.
**
**              NOTE: This file is for COCO3 specific window functions.
**
**              These are the functions contained herein:
**
**              pos_cur();
**              write_stat(),
**              c_owset(),
**              c_owend(),
**              b_owset();
**              b_owend();
**              open_scrn(),
**              close_scrn(),
**              ins_line(),
**              del_line(),
*/

#include <stdio.h>
#include "sledef.h"

/*
**     LOCAL VARIABLES
*/

direct FLAG window_set;

/*
**     GLOBAL VARIABLES
*/

extern direct struct sled_size scrn_siz;
extern direct struct scrn def_scrn;

/*
**      The position cursor function: Moves cursor to the screen column
**                                    and row passed.
*/

int pos_cur(int x, int y)
{
    CurXY(STDERR,x,y);
    return 0;
}

/*
**              Write a message to the STAT line
**
**      Used for the Option Flags "Indent, Word-Wrap, Auto-Indent"
*/

int write_stat(int pos, char *s)
{
    if(pos > scrn_siz.colm)             /* Skip if there is no room    */
        return 0;

    CurOff(STDERR);                     /* Turn the cursor off          */
    open_scrn();                        /* Open to the full size screen */
    BColor(STDERR,BLACK);

    if(def_scrn.mtype == MONO)
        FColor(STDERR,WHITE);
    else
        FColor(STDERR,RED);

    CurXY(STDERR,pos,STATLINE);         /* Move to the correct position */
    fputs(s,stdout);                    /* Write out the flag           */
    close_scrn();                       /* Close up the screen          */
    BColor(STDERR,def_scrn.bcolor);
    FColor(STDERR,def_scrn.fcolor);
    CurOn(STDERR);                      /* Turn the cursor back on      */
    return 0;
}                                       /* and return.                  */


/*
**                      Create Overlay Windows
**
**      Opens TWO overlay windows. One is opened slightly larger than the
**      next in reverse colors to make a border that is useful in text
**      screens.
*/

int c_owset(void)
{
    int offset = ((scrn_siz.colm / 2) - 18);

    if (window_set == NO) {                 /* If a window is not open */
        if(def_scrn.mtype == MONO) {
            OWSet(STDERR,1,offset,9,38,3,11,11);    /* Open 1st window */
            OWSet(STDERR,1,offset - 1,8,38,3,10,9); /* Open 2nd window */
        }else{
            OWSet(STDERR,1,offset,9,38,3,BLACK,BLACK);
            OWSet(STDERR,1,offset - 1,8,38,3,WHITE,RED);
        }
    }
    window_set = YES;                               /* Set the flag    */
    return 0;
}

/*
**                      Close Overlay Window
**
**      Closes BOTH overlay windows if they are opened.
*/

int c_owend(void)
{
    if (window_set == YES){         /* If a window is already open */
        OWEnd(STDERR);              /* Close it                    */
        OWEnd(STDERR);

        window_set = NO;            /* And set the flag            */
    }
    return 0;
}

/*
**      Open the large box overlay windows
*/

int b_owset(void)
{
    int offset = ((scrn_siz.colm / 2) - 18);

    if(def_scrn.mtype == MONO) {
        OWSet(STDERR, 1, offset, 4, 39, 15, 11, 11);
        OWSet(STDERR, 1, offset - 1, 3, 39, 15, 10, 9);
    }
    else{
        OWSet(STDERR, 1, offset, 4, 39, 15, 2, 2);
        OWSet(STDERR, 1, offset - 1, 3, 39, 15, 7, 4);
    }
    return 0;
}

/*
**      Close boxed overlay windows.
*/

int b_owend(void)
{
    OWEnd(STDERR);
    OWEnd(STDERR);
    return 0;
}

/*
**      Open up the screen Window to full size
*/

int open_scrn(void)
{
    CWArea(STDERR,0,1,scrn_siz.colm + 2,scrn_siz.row);
    return 0;
}

/*
**      Close up the screen Window
*/

int close_scrn(void)
{
    CWArea(STDERR,0,1,scrn_siz.colm + 2,scrn_siz.row - 1);
    return 0;
}

/*
**      Insert a screen line - Inserts a line on the screen only. Does NOT
**                             affect the edit or text buffers.
*/

int ins_line(void)
{
    InsLin(STDERR);
    return 0;
}

/*
**      Delete a screen line - Same as ins_line() but deletes it instead.
*/

int del_line(void)
{
    DelLin(STDERR);
    return 0;
}
