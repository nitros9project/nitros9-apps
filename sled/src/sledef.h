#ifndef SLEDEF_H
#define SLEDEF_H
#include "sled_port.h"
/*
 *
 *                 FILE OF DEFINITIONS FOR SLED
 *
 */

#define COCO3                      /* Use the CoCo3 screen functions */

/*  DELETE THE ABOVE LINE TO USE THE GENERIC TERMINAL SCREEN FUNCTIONS !!  */
#define LASTLINE (scrn_siz.row - 2)
#define STATLINE (scrn_siz.row - 1)
#define BUFSTART 2
#define SCRN_TOP 0
#define YES 1
#define NO 0
#define TRUE 1
#define FALSE 0
#define ERROR (-1)
#define STDERR 2
#define STDOUT 1
#define SYSERR 0
#define SET 1
#define UNSET 0
#define MARKING 2
#define MAXLINES 1000               /* This is the maximum number of */
                                    /* lines - for OS9/68K try more  */
#define EOR '\x0D'
#define EOS '\0'

#define SPACE '\x20'
#define ESCAPE '\x1B'

/*  Change these defines as needed for different terminals  */

#define BEEP      putc('\x07',stderr);     /* Guess ??                     */
#define CLR_LIN   putc('\x03',stderr);     /* Clear current screen line    */
#define CLR_EOL   putc('\x04',stderr);     /* Clear to end of current line */
#define CLS       putc('\x0C',stderr);     /* Clear the screen             */
#define CUR_ON    fputs("\x05\x21",stderr);   /* Turn the cursor on        */
#define CUR_OFF   fputs("\x05\x20",stderr);   /* Turn the cursor off       */
#define REV_ON    fputs("\x1F\x20",stderr);   /* Turn reverse printing on  */
#define REV_OFF   fputs("\x1F\x21",stderr);   /* Turn revsrse printing off */
#define BLINK_ON  fputs("\x1F\x24",stderr);   /* Turn on blinking          */
#define BLINK_OFF fputs("\x1F\x25",stderr);   /* Turn blinking off         */
#define MOVE_RIGHT putchar('\x06');  /* Move the cursor one pos right */

/*
 *  These are the Only requirements besides the X/Y cursor positioning
 *  used by the function pos_cur() located in this header file.
 *
 *  The terminal must be able to:
 *
 *  (1) Home and clear the screen.
 *  (2) Clear from the current cursor position to the end of the line
 *  (3) Move the cursor one character to the right without destroying
 *      characters.
 *
 *
 *                KEYBOARD DEFINES
 *
 *
 *            THESE ARE THE CURSOR POSITIONING CODES
 *            THAT MIGHT NEED TO BE ALTERED FOR DIFFERENT TERMINALS
 *
 *      The ASCII Codes for these are:
 *
 *             <leftarrow>      Hex 1C
 *             <rightarrow>     Hex 1D
 *             <uparrow>        Hex 1E
 *             <downarrow>      Hex 1F  or Linefeed (Hex 0A)
 *             <TAB>            Hex 09
 *
 *   According to what the terminal has, the paging keys and others
 *   may have to be changed around. Check for any duplication of codes.
 *
 *
 *  These are the codes for the Radio Shack Color Computer 3 Keyboard
 */

#define ENTER '\r'            /* Control M */
#define LEFTARR '\x08'        /* Control H */
#define UPARR '\x0C'          /* Control L */
#define RIGHTARR '\x09'       /* Control I */
#define DOWNARR '\x0A'        /* Control J */
#define TAB '\x19'            /* Control Y or Shift Rightarrow */
#define DETAB '\x18'          /* Control X or Shift  Leftarrow */
#define PAGE_UP '\x1C'        /* Shift Uparrow */
#define PAGE_DOWN '\x1A'      /* Control Z Shift Downarrow */
#define NOND_CR '\x16'        /* Control V */
#define QUIT '\x11'           /* Control Q */
#define MARGIN '\x13'         /* Control S */
#define GET_NEXT '\x0E'       /* Control N */
#define TOG_TAB '\x14'        /* Control T */
#define GO_TO_TOP '\x02'      /* Control B */
#define GO_TO_END '\x05'      /* Control E or BREAK */
#define GO_TO_LINE '\x10'     /* Control P */
#define KILL_LINE '\x0B'      /* Control K */
#define ADD_LINE '\x01'       /* Control A */
#define ERASE_TO_END '\x03'   /* Control C or SHIFT-BREAK */
#define DEL_CHAR '\x04'       /* Control D */
#define OUTPUT '\x0F'         /* Control O */
#define PUT_FILE '\x17'       /* Control W */
#define GET_FILE '\x12'       /* Control R */
#define TEMP_GET '\x06'       /* Control F */
#define GLOBAL '\x07'         /* Control G */
#define UPDATE '\x15'         /* Control U */
#define USER 0xF5           /* Alt U     */
#define MARK 0xED           /* Alt M     */
#define CHGDIR 0xE4         /* Alt D     */
#define HELP_MSG    0xE8    /* ALT H    */
#define INSERT_MODE 0xB1    /* F1       */
#define WORD_WRAP   0xB2    /* F2       */
#define AUTO_INDENT 0xB3    /* Shift-F1 */

/*
 *
 *                STRUCTURE DEFINITIONS
 *
 */

struct position {
  int col,
      cursor_row,
      text_row,
      top_screen,
      buffer_end;
};

struct sled_size {
  int colm,
      row;
};

struct work_buf {
 char *temp_ln,
      change_flag,
      new_ln;
 int last_char;
};

struct storage {
  char *line,
       glob_flag,
       new_line;
  int length;
};

struct rw_dat {
  int lines;
  char *name;
};
struct glob_info {
  int start,
      num,
      marker;
};

/* The following structures are defined for CoCo3 ONLY compilation */

#ifdef COCO3

struct scrn {
  int wtype,
      mtype,
      fcolor,
      bcolor,
      border;
};

#define COMP    0
#define RGB     1
#define MONO    2

#define WHITE   '\x00'
#define BLUE    '\x01'
#define BLACK   '\x02'
#define GREEN   '\x03'
#define RED     '\x04'
#define YELLOW  '\x05'
#define PURPLE  '\x06'
#define CYAN    '\x07'

#endif
/*
 *
 *          TYPE DEFS
 *
 */

 typedef char FLAG;


#include "sled_proto.h"
#endif
