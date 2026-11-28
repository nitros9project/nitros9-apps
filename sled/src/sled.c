/*
 *
 *                MAIN PROGRAM FILE FOR SLED
 *
 *           This file contains the main, the primary program loop,
 *           the initialization and ending routines
 *           Contained in order are the functions -
 *
 *                main(),
 *                edit(),
 *                set_scrn(),
 *                get_siz(),
 *                set_work(),
 *                set_pos(),
 *                finish(),
 *                fix_scrn(),
 *                puta(),
 *                catch(),
 *                usr_free_space(),
 *                show_ruler();
 *
 *           This is the main module file for sled
 *           Operation is explained in SLED.DOCS
 *
 *           Last UpDate 09-20-85   changed Version Number and fixed screen
 *                                  sizing routines for enhanced compatibility
 *
 *           Additions by Mark Griffith:
 *
 *           Added Windowing functions:                16 May 1987
 *           Added Ruler Bar at screen top:            17 May 1987
 *           Added conditional compilation:            16 Jun 1987
 *           Added setting Kybd pause char to 0:    15 Jul 1987
 *           Added color and screen enhancements:      22 Oct 1987
 *           Revised colors:                           13 Mar 1988
 */
/*
 *                INCLUDES
 */

#include <stdio.h>
#include <ctype.h>
#include <setjmp.h>
#include "sledef.h"

/*
 *                GLOBAL VARIABLES
 */

direct struct position current;        /* holds info about screen and */
                                       /* text buffer positions       */
direct struct sled_size scrn_siz;           /* holds size of term's screen */
direct struct work_buf work_ln;        /* working area for current    */
                                       /* line                        */
static direct struct termopts desc_buf,   /* holds terminal parameters   */
                           scrn_buf;   /* first before sled & during  */
                                       /* run. Used for USER command  */
direct jmp_buf vector;                 /* holds position for jumps    */
                                       /* out of commands via <ESC>   */
direct FLAG insert_flag,               /* indicates insert mode stat. */
            safe_flag,                 /* so that there is enough mem */
            finish_flag,               /* to tell write not to delete */
            update_flag,
            wrap_flag,
            indent_flag;
direct int margin;                     /* holds current left margin   */
direct char *tab_str,*safe_line;       /* records tab stops for TAB   */

/* Additional structures for the CoCo3 ONLY */

#ifdef COCO3
   direct struct scrn def_scrn;
   static char palette[16];
#endif

/*
 *               MAIN - program starts here
 */

int main(int argc, char *argv[])
{
    static FLAG fr_flag;

    if(argc > 3) {                      /* if command line is wrong    */
        puts("\nUsage: sled [file [lines]]");
        exit(20);
    }
    get_size();
    set_scrn();
    set_work();
    set_pos();
    set_null();

    fr_flag = NO;                       /* set first time flag         */
    finish_flag = NO;                   /* set finish_flag for writes  */
    update_flag = NO;                   /* set for buffer updating     */
    wrap_flag = NO;                     /* word wrap toggle flag       */
    indent_flag = NO;                   /* auto-indent toggle flag     */
    insert_flag = NO;                   /* insert toggle flag          */

    setjmp(vector);                     /* set jump for <ESC>s out of  */
                                        /* commands                    */
    intercept(sled_catch);                   /* <ESC> returns here          */

    if(fr_flag == NO) {                 /* if the 1st time             */
        fr_flag = YES;
        first_read(argc,argv);          /* do the 1st file read        */
    }
    refresh(0,NO);                      /* Refresh after an intercept  */
    edit();                             /* Main program functions      */
    finish();                           /* clean up at end             */
    return 0;
}

/*
 *                 EDIT - The main loop
 */

int edit(void)
{
    int test = 0, c;

    do {
        pos_cur(current.col,current.cursor_row);

        c = getchar();
        if(c == EOF) return 0;
        if(c != 0) {              /* get a character   */
            if(' ' <= c && c <= '~') {             /* if it's printable */
                if(current.buffer_end == MAXLINES) /* and room remains  */
                    usr_msgs("\n BUFFER FULL");

            test = add_char(c);                 /* output the character */
            }
        else
            test = command(c);           /* otherwise check for command */
        }
    }while(test != EOF);                   /* if command is end, end Do */
    return 0;
}

/*
 *         SET SCREEN  echo and keyboard ECT
 */

int set_scrn(void)
{
    /*  set echo off and change <ESC> to keyboard abort for catching  */

    if(getstat(0,1,&desc_buf) == ERROR)
        exit(1);

    memcpy(&scrn_buf,&desc_buf,32);

    scrn_buf.op_backsp = 0;   /* Set the terminal and screen parameters to */
    scrn_buf.op_echo = 0;     /* those needed by SLED */
    scrn_buf.op_pause = 0;
    scrn_buf.op_psch  = 0;
    scrn_buf.op_eorch = 0;
    scrn_buf.op_eofch = 0xFE;
    scrn_buf.op_dlnch = 0xFE;
    scrn_buf.op_rlnch = 0xFE;
    scrn_buf.op_kbich = 0x1B;
    scrn_buf.op_kbach = 0xFD;

    if(setstat(0,1,&scrn_buf) == ERROR)
        exit(2);
    return 0;
}

/*
 *               SCReeN SIZE
 */

int get_size(void)
{
    struct registers reg;
    memset(&reg,0,sizeof(reg));

    reg.rg_a = 1;                     /* Set to do the SSsize Getstat call */
    reg.rg_b = 0x26;

    if(_os9(I_GETSTT,&reg) == 0) {    /* If the call is successful set the */
        scrn_siz.colm = reg.rg_x - 2; /* screen display to the window size */
        scrn_siz.row = reg.rg_y - 1;
    } else {
        scrn_siz.colm = 78;           /* If not, default to a 80x24 screen */
        scrn_siz.row = 23;
    }

#ifdef COCO3

    if(scrn_siz.colm < 38 || scrn_siz.row < 15) {
        fputs("SCREEN SIZE TOO SMALL\n",stderr);
        exit(0);
    }

    if(scrn_siz.colm > 78) scrn_siz.colm = 78;
    if(scrn_siz.row > 23) scrn_siz.row = 23;

    if((_gs_styp(STDERR, &def_scrn.wtype)) == ERROR)  /* get screen type */
        exit(errno);

    if((_gs_palt(STDERR, &palette[0])) == ERROR)      /* Get palette regs */
        exit(errno);

    if((_gs_fbrg(STDERR, &def_scrn.fcolor,&def_scrn.bcolor,&def_scrn.border)) == ERROR)
        exit(errno);                  /* Get the palettes being used */

    reg.rg_a = 1;                     /* Set to do the Montyp Getstat call */
    reg.rg_b = 0x92;
    reg.rg_x = 0;

    if(_os9(I_GETSTT,&reg) == 0)      /* If the call is successful set the */
        def_scrn.mtype = reg.rg_x;    /* monitor type */
    else
        def_scrn.mtype = MONO;        /* or default to a MONO monitor */

    setbuf(stdin,0);               /* set terminal for single */
    setbuf(stdout,0);              /* character I/O */

    Border(STDERR,BLACK);             /* Set up initial screen colors */
    BColor(STDERR,BLACK);

    if(def_scrn.wtype < 3) {          /* If its a text window */
        Palette(STDERR, 8,63);        /* Set up the palette registers */
        Palette(STDERR, 9,palette[def_scrn.fcolor]);
        Palette(STDERR,10,0);
        Palette(STDERR,11,18);
        Palette(STDERR,12,36);
        Palette(STDERR,13,54);
        Palette(STDERR,14,9);
        Palette(STDERR,15,63);
    }
    CLS                               /* Clear to all black */
    tsleep(10);                       /* sleep a bit to settle screen */

    if(scrn_siz.colm > 40) {          /* If it's not a 40 col window */
        FColor(STDERR, YELLOW);
        pos_cur(scrn_siz.colm - 13,scrn_siz.row);
        write(1,"SLED Ver 2.2",12);
    }
    if(def_scrn.mtype == MONO) {      /* White on black for Mono */
        def_scrn.fcolor = WHITE;
        def_scrn.bcolor = BLACK;
        Palette(STDERR,0,63);
        Palette(STDERR,3,63);
    }
    FColor(STDERR,def_scrn.fcolor);   /* Return to default screen colors */
    BColor(STDERR,def_scrn.bcolor);
    show_ruler();                     /* and print the ruler bar */
    CLS                               /* Clear to new colors */

#endif

#ifndef COCO3
    CLS
    setbuf(stdin,0);               /* set terminal for single  */
    setbuf(stdout,0);              /* character I/O */
#endif

    return 0;
}

/*
**            SET WORKing Buffer
*/

int set_work(void)
{
    register int i;

    if((work_ln.temp_ln = malloc(scrn_siz.colm + 1)) == 0 || (safe_line = malloc(scrn_siz.colm + 1)) == 0){
        fix_scrn();
        exit(3);
    }
    clear_work(&work_ln);              /* clear it */
    work_ln.change_flag = YES;         /* set for 1st time */
    safe_flag = YES;
    return 0;
}

/*
 *         SET POSition for first screen
 */

int set_pos(void)
/* set 1st position to screen 0,0 and text line 0 */
{
    register int i;

    current.col = current.cursor_row = current.text_row = current.top_screen = 0;
    current.buffer_end = 1;
    insert_flag = NO;
    margin = 0;                             /* 1st left margin equals zero */
                                            /* allocate tab string to */
    if((tab_str = malloc(scrn_siz.colm)) == 0) /* screen line width  */
        exit(5);

    for(i=0 ; i < scrn_siz.colm; i++)       /* set initial tabs at every */
        if((i % 4) == 0)                    /* four places */
            tab_str[i] = SET;
        else
            tab_str[i] = UNSET;
    return 0;
}

/*
 *           FINISH routine
 */

int finish(void)
/* clean up and allow for a last save before exit unless */
{               /* the text buffer is empty */
    int c;

    save_change();
    ensure_end();
    if(current.buffer_end > 1 || work_ln.last_char > 0) {
        finish_flag = YES;
        update_flag = NO;
        c_owset();
        fputs("\n Save before quitting (y/n)? ",stdout);

        while(( c = toupper(getchar()) ) != 'Y' && c != 'N')
            ;
        current.text_row = 0;

        if( c == 'Y') {
            CLS
            file_write();
        }
    }
    f_clean();
    c_owend();

#ifdef COCO3
    /* Reset the screen to what it was when SLED started */

    CWArea(STDERR, 0, 0, scrn_siz.colm + 2, scrn_siz.row + 1);
    FColor(STDERR,def_scrn.fcolor);
    BColor(STDERR,def_scrn.bcolor);
    Border(STDERR,def_scrn.border);
    Palette(STDERR, 8,palette[8]);
    Palette(STDERR, 9,palette[9]);
    Palette(STDERR,10,palette[10]);
    Palette(STDERR,11,palette[11]);
    Palette(STDERR,12,palette[12]);
    Palette(STDERR,13,palette[13]);
    Palette(STDERR,14,palette[14]);
    Palette(STDERR,15,palette[15]);

#endif

    fix_scrn();

    return 0;
}

/*
 *           FIXES SCREEN to it's original state
 */

int fix_scrn(void)
/* makes screen normal at end and for USER command */
{
    c_owend();
    CLS
    if(setstat(0,1,&desc_buf) == ERROR)                 /* make it normal */
        exit(4);
    return 0;
}

/*
 *                 Put an Absolute value to fd.
 */

int puta(int num, FILE *fd)
{
    int i, d;
    char str[7];

    str[6] = EOS;
    for(i = 5;i > 0;i--) {
        str[i] = (num % 10) + '0';
        num /= 10;
        if (num == 0)
            break;
    }
    return(fputs(&str[i],fd));
    return 0;
}

/*
 *              Catch all Aborts
 */

void sled_catch(int signal)
{
    usr_msgs("\n Command Interupted");      /* tell user of the <ESC>     */
    c_owend();                              /* Close the overlays if open */
}

/*
 *                     USeR FREE some SPACE
 */

int usr_free_space(void)
{
    if(work_ln.change_flag == YES){
        free(safe_line);
        safe_flag = NO;
    }
    save_change();

#ifdef COCO3
    c_owset();
#else
    pos_cur(0,STATLINE - 2);
#endif
    usr_msgs("\n BUFFER FULL");
    return 0;
}

#ifdef COCO3

/*
**  Draw the ruler at the screen top with marker for the left margin
*/
int show_ruler(void)
{
    static char *ruler;

    ruler = "....|....1....|....2....|....3....|....4....|....5....|....6....|....7....|.....";

    CurOff(STDERR);
    CWArea(STDERR, 0, 0, scrn_siz.colm + 2, scrn_siz.row + 1);
    BColor(STDERR, BLACK);
    FColor(STDERR, GREEN);

    if(margin == 0) {
        write(1,ruler,scrn_siz.colm);
    }else{
        write(1,ruler,scrn_siz.colm);
        FColor(STDERR,RED);
        CurXY(STDERR, margin, 0);
        fputs("M", stderr);
    }
    close_scrn();
    FColor(STDERR, def_scrn.fcolor);
    BColor(STDERR, def_scrn.bcolor);
    CurOn(STDERR);
    return 0;
}

#endif
