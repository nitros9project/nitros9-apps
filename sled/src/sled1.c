/*
 *                   SLED1
 *         character and command processing for sled
 *
 *         functions included in this file -
 *
 *         add_char(),
 *         command(),
 *         adv_col(),
 *         dec_col(),
 *         adv_line(),
 *         dec_line(),
 *         insert_char(),
 *         del_char(),
 *         erase_to_end();
 *
 *         Modifications by Mark Griffith
 *
 *         Added screen insert and delete code:     13 Apr 1987
 *         Fixed screen printing after line insert: 14 Apr 1987
 *         Increased speed of Insert mode:          18 Apr 1987
 *         Fixed first blank line problem:          19 Apr 1987
 *         Set default command action to Beep:      19 Apr 1987
 *         Increased speed of character delete:     19 May 1987
 *         Added Windowing:                         17 May 1987
 *         Added single character insert:           21 May 1987
 *         Added auto-line insert in insert mode:   21 May 1987
 *         Added Word-Wrap function:                 6 Jun 1987
 *         Added Auto-Indent function:              12 Jun 1987
 *         Added the Update text command:            7 Mar 1988
 *         Changed the User command:                 7 Mar 1988
 *         Added Change Directory command:          29 Mar 1988
 *
 *                     INCLUDE FILES
 */

#include <stdio.h>
#include "sledef.h"

/*
 *                   GLOBAL VARIABLES
 */

direct FLAG ref_flag;

/*
 *                   EXTERNALS
 */

extern direct int margin;
extern direct FLAG insert_flag,
                   wrap_flag,
                   indent_flag,
                   update_flag;
extern direct struct position current;
extern direct struct sled_size scrn_siz;
extern direct struct work_buf work_ln;
extern direct struct glob_info glob_pos;
extern direct struct scrn def_scrn;

/*
 *          ADDs CHARacters to buffer and screen
 */

int add_char(int c)
/* add new character to screen & text buffer */
{
    ref_flag = YES;

    if(insert_flag == YES) {                    /* if insert mode is ON */

  /*  If the line lenght after inserting the next character will be       */
  /*  greater than the screen width, we need to insert a new screen line. */

        if(work_ln.new_ln == YES && work_ln.last_char +1 == scrn_siz.colm) {
            pos_cur(0,current.cursor_row + 1);
            ins_line();
        }

  /*  Now, insert that character into the buffer */

        store_ln(&work_ln,current.text_row);
        insert_char(c,current.text_row,current.col);
        retrv_ln(&work_ln,current.text_row);

  /*  Print the next line down if it's part of the current screen line  */

        if(work_ln.new_ln == NO)
            print_next(current.cursor_row, current.text_row);
        else
            ln_to_scrn(work_ln.temp_ln,current.cursor_row,work_ln.new_ln);

    }else{                                  /* If insert is OFF */
        putchar(c);
        work_ln.change_flag = YES;
    }
    if(current.col >= work_ln.last_char) {    /* if past old Line End */
        work_ln.temp_ln[work_ln.last_char] = SPACE; /* set new Line End */
        work_ln.last_char = current.col + 1;

        if(work_ln.last_char > scrn_siz.colm)
            work_ln.last_char = scrn_siz.colm;

        work_ln.temp_ln[work_ln.last_char] = EOS;
    }
    work_ln.temp_ln[current.col] = c;       /* store new char       */
    adv_col();                              /* advance one char pos */
    return(0);                              /* Always return NOT EOF*/
    return 0;
}

/*
 *         COMMAND processor
 */

int command(int c)
/* Choose the correct command and execute it     */
{
    char *str;                   /* ptr and func. for    */
                                            /* USER Command         */
    int x, ref_row, n;                      /* x is a temp. variable*/
                                            /* row to start refresh */
    register int i;
    char *dirname;
    char old_line[80];        /* Temp buffer for CR insert function */
    FLAG skip;                              /* skip refresh flag    */
                                            /* YES = skip refresh   */
    save_change();
    ref_flag = NO;
    skip = NO;
    ref_row = 0;

    switch(c)                               /* execute command  */
    {
    case LEFTARR :                          /* move left one char   */
        dec_col();                          /* Equal to non-destruc-*/
        skip = YES;                         /* tive backspace       */
        break;

    case UPARR :                            /* move up one line     */
        dec_line();
        skip = YES;
        break;

    case RIGHTARR :                         /* move right one char  */
        adv_col();
        skip = YES;
        break;

    case ENTER :                            /* End text line        */
        if(work_ln.new_ln == NO) {
            work_ln.new_ln = YES;
            work_ln.change_flag = YES;
        }
        if(indent_flag == YES)              /* Do a line indent if  */
            indent_line();                  /* the flag is set      */

        if(insert_flag == YES){             /* If insert mode is on */

      /* First, save the remainder of the line */

            i = current.col;
            n = 0;

            while(work_ln.temp_ln[i] != EOS)
                old_line[n++] = work_ln.temp_ln[i++];

            old_line[n] = EOS;              /* Set end of string */
            work_ln.temp_ln[current.col] = EOS;      /* Set new line end  */
            insert_ln(current.text_row + 1,1);       /* Get a new line    */
            work_ln.change_flag = YES;
            adv_line();
            pos_cur(0,current.cursor_row);  /* Insert a screen line */
            ins_line();                     /* for the remaining text */

      /* Now, copy the rest of the line to the new one */

            i = 0;
            n = margin;

            while(old_line[i] != EOS)
                work_ln.temp_ln[n++] = old_line[i++];

            work_ln.last_char = current.col = n;
            work_ln.change_flag = YES;
            save_change();
            skip = YES;
            break;
        }

    case NOND_CR :                          /* End screen line      */
        current.col = margin;               /* set column to start  */

    case DOWNARR :                          /* go to next line at   */
        adv_line();
        skip = YES;
        break;

    case INSERT_MODE :                      /* Toggle insert flag   */
        if(insert_flag == NO) {
            insert_flag = YES;
            write_stat(2,"Insert On");
        }
        else {
            insert_flag = NO;
            write_stat(2,"         ");
        }
        skip = YES;
        break;

    case MARGIN :                           /* Set Left margin      */
        margin = current.col;
        show_ruler();
        skip = YES;
        break;

    case TOG_TAB :                          /* Toggle tab at current*/
        toggle_tab();                       /* column position      */
        skip = YES;
        break;

    case TAB :                              /* tab right to next tab*/
        tab();                              /* stop or end of line  */
        skip = YES;
        break;

    case DETAB :                            /* tab left or to begin-*/
        detab();                            /* ing of line          */
        skip = YES;
        break;

    case MARK :
        if(glob_pos.marker == UNSET) {
            glob_pos.start = current.text_row;
            glob_pos.num = 1;
            glob_pos.marker = MARKING;
            BLINK_ON
            write_stat(42,"MARKING BLOCK");
            BLINK_OFF
        }else{
            if(glob_pos.marker == SET) {
                glob_pos.start = 0;
                glob_pos.num = 0;
                glob_pos.marker = UNSET;
                write_stat(42,"             ");
            }
            if(glob_pos.marker == MARKING) {
                if(current.text_row < glob_pos.start) {
                    glob_pos.num = (glob_pos.start - current.text_row) + 1;
                    glob_pos.start = current.text_row;
                }else
                    glob_pos.num = (current.text_row - glob_pos.start) + 1;

                glob_pos.marker = SET;
                write_stat(42,"Block Marked ");
            }
        }
        break;

    case PAGE_UP :                          /* Page one screen up   */
        page_up();
        break;

    case PAGE_DOWN :                        /* page one screen down */
        page_down();
        break;

    case GO_TO_TOP :                        /* Go to the beginning  */
        go_to_top();                        /* of the text buffer   */
        break;                              /* and display          */

    case GO_TO_END :                        /* go to the End of the */
        go_to_end();                        /* text buffer          */
        break;

    case GO_TO_LINE :                       /* Position to user     */
        c_owset();
        go_to_line();                       /* given line           */
        c_owend();
        break;

    case GLOBAL :                           /* Enter global command */
        c_owset();
        global();                           /* interpreter          */
        c_owend();
        break;

    case GET_NEXT :                         /* Find the next search str */
        find(" ",1,YES);
        break;

    case ADD_LINE :                         /* Add a blank line     */
        store_ln(&work_ln,current.text_row);
        insert_ln(current.text_row,1);
        retrv_ln(&work_ln,current.text_row);
        ins_line();
        skip = YES;
        break;

    case KILL_LINE :                        /* delete current line  */
        delete_ln(current.text_row,1);;
        del_line();
        refresh(LASTLINE, NO);
        skip = YES;
        break;

    case ERASE_TO_END :                     /* Erase to the end of  */
        erase_to_end(current.col);          /* the current line     */
        skip = YES;
        break;

    case DEL_CHAR :                             /* delete the character */
        store_ln(&work_ln,current.text_row);    /* at the current       */
        del_char(current.text_row,current.col); /* cursor position      */
        retrv_ln(&work_ln,current.text_row);

        if(work_ln.new_ln == NO)
            print_next(current.cursor_row, current.text_row);
        else
            ln_to_scrn(work_ln.temp_ln,current.cursor_row,work_ln.new_ln);

        skip = YES;
        break;

    case QUIT :                             /* the ONLY way to END  */
        return(EOF);                        /* Return ALL DONE      */
        break;

   case PUT_FILE :                          /* Write out to write   */
        c_owset();                          /* file.                */
        file_write();
        c_owend();
        break;

   case OUTPUT :                            /* Output to an alter-  */
        c_owset();                          /* nate file or device. */
        print_out();
        c_owend();
        skip = YES;
        break;

   case GET_FILE :                          /* Read from Read file  */
        c_owset();
        get_file();
        command(KILL_LINE);                 /* Kill the current     */
        c_owend();                          /* blank line.          */
        break;

   case TEMP_GET :                          /* Alternate file read  */
        c_owset();
        temp_read();
        c_owend();
        break;

   case UPDATE:                             /* Write out the buffer from  */
        c_owset();                          /* the start of the buffer */
        update_flag = YES;                  /* to the line before the */
        fputs("\n Updating Buffer...", stdout); /* current cursor row & the */
        file_write();                       /* read in as much text from */
        get_file();                         /* the read file as possible */
        c_owend();                          /* and redisplay the screen */
        go_to_top();                        /* starting at the top. */
        command(KILL_LINE);
        break;

   case USER :                              /* Let user access the  */
        c_owset();                          /* command shell        */
        if((str = get_arg("\n SYS : ",'a')) != 0){
            if((x=strlen(str)) < 81){
                str[x] = EOR;
                str[x + 1] = EOS;
                fix_scrn();

                if((x = system(str))!= 0){
                    fputs(" SYSTEM ERROR #",stdout);
                    puta(x,stdout);
                }
                puts("\n Press <ENTER>");
                while(getchar() != ENTER)
                    ;
                c_owend();
                set_scrn();
            }else {
                CLS
                usr_msgs("\n Command Line Too Long");
                c_owend();
            }
        }else {
            CLS
            usr_msgs("\n FMT - SYS : Shell Command");
            c_owend();
        }
        break;

   case HELP_MSG :                          /* Show help screens */
        show_help();
        skip = YES;
        break;

   case WORD_WRAP :                         /* Toggle Word Wrap     */
        if(wrap_flag == NO) {
            wrap_flag = YES;
            write_stat(15,"Word-Wrap");
        }
        else {
            wrap_flag = NO;
            write_stat(15,"         ");
        }
        skip = YES;
        break;

   case AUTO_INDENT :                       /* Toggle Auto Indent   */
        if(indent_flag == NO) {
            indent_flag = YES;
            write_stat(28,"Auto-Indent");
        }
        else {
            indent_flag = NO;
            write_stat(28,"           ");
            margin = 0;
        }
        skip = YES;
        break;

   case CHGDIR :                                /* Change directory */
        c_owset();
        if((dirname = get_arg("\n Dir: ",'a')) != 0){
            if(chdir(dirname) != 0)
                usr_msgs("\n Bad DIR name");
        }
        c_owend();
        skip = YES;
        break;

    default:

        BEEP   /*  If not a recognized command then BEEP at you  */
        skip = YES;
        break;

    skip = YES;
    }
    if(skip == NO)
    refresh(ref_row,ref_flag);                 /* refresh screen       */

    return(0);                                   /* Return Not DONE      */
    return 0;
}

/*
 *
 *            ADVance one CHARacter
 *
 */

int adv_col(void)
{
    if((++current.col) >= scrn_siz.colm) {

  /*  Do the indent first in case the word is wrapped around */

        if(indent_flag == YES)
            indent_line();

        current.col = margin;

  /*  Now, wrap the word around if the Word-Wrap flag is set. If not,
  **  just advance to the next line.
  */
        if(wrap_flag == YES)
            wrap_word();
        else
            adv_line();
    }
    return 0;
}

/*
 *           DECrement one COLumn position
 */

int dec_col(void)
{
    if((--current.col) < margin) {
        current.col = scrn_siz.colm - 1;
        dec_line();
    }
    return 0;
}

/*
 *           ADVance one LINE
 */

int adv_line(void)
{
    save_change();

    if((current.text_row + 1) >= current.buffer_end)
        insert_ln(current.buffer_end,1);

    current.text_row++;

    if((current.cursor_row + 1) == STATLINE) {
        current.top_screen++;
        putchar('\r');
        retrv_ln(&work_ln,current.text_row);

       if(current.text_row >= glob_pos.start && current.text_row <= (glob_pos.start + (glob_pos.num - 1)))
            FColor(STDERR,RED);

        ln_to_scrn(work_ln.temp_ln,current.cursor_row,work_ln.new_ln);
    } else
        current.cursor_row++;

    retrv_ln(&work_ln,current.text_row);
    FColor(STDERR,def_scrn.fcolor);
    return 0;
}

/*
 *           DECrement one LINE
 */

int dec_line(void)
{
    save_change();
    if((current.text_row + 1) < BUFSTART) {
        BEEP
        return(0);
    } else {
        current.text_row--;
        retrv_ln(&work_ln,current.text_row);

        if((current.cursor_row - 1) < SCRN_TOP) {
            current.top_screen--;
            ins_line();

            if(current.text_row >= glob_pos.start && current.text_row <= (glob_pos.start + (glob_pos.num - 1)))
            FColor(STDERR,RED);
            ln_to_scrn(work_ln.temp_ln,SCRN_TOP,YES);
        } else
            current.cursor_row--;
    }
    FColor(STDERR,def_scrn.fcolor);
    return 0;
}
/*
 *           INSERT A CHARACTER
 */

int insert_char(char c, int row, int col)
{
    register int i;
    char ch;

    retrv_ln(&work_ln,row);

    if(scrn_siz.colm <= work_ln.last_char)
        ch = work_ln.temp_ln[scrn_siz.colm - 1];
    else{
        ch = SPACE;
        work_ln.last_char++;
    }

    for(i = (scrn_siz.colm - 1);i > col; i--)
        work_ln.temp_ln[i] = work_ln.temp_ln[i - 1];

    work_ln.temp_ln[work_ln.last_char] = EOS;
    work_ln.temp_ln[col] = c;

    if(work_ln.new_ln == YES && work_ln.last_char == scrn_siz.colm){
        work_ln.new_ln = NO;
        store_ln(&work_ln,row);
        insert_ln((row + 1),1);
        retrv_ln(&work_ln,(row+1));
        work_ln.new_ln = YES;
        store_ln(&work_ln,(row + 1));
        retrv_ln(&work_ln,row);
    }else
        store_ln(&work_ln,row);

    row++;
    if(work_ln.new_ln != YES && row < current.buffer_end)
        insert_char(ch,row,0);
    return 0;
}

/*
 *                   DELete CHARacter
 */

int del_char(int row, int col)
{
    char ch;
    register int i;

    retrv_ln(&work_ln,row);

    if(work_ln.new_ln == NO){
        retrv_ln(&work_ln,(row + 1));
        ch = work_ln.temp_ln[0];
        retrv_ln(&work_ln,row);

        if(work_ln.last_char != scrn_siz.colm){
            work_ln.temp_ln[work_ln.last_char] = 0;
            ref_flag = NO;
        }
         work_ln.last_char = scrn_siz.colm;
    }else
        ch = EOS;

    for(i = col;i < work_ln.last_char; i++)
        work_ln.temp_ln[i] = work_ln.temp_ln[i + 1];

    work_ln.temp_ln[scrn_siz.colm - 1] = ch;
    store_ln(&work_ln,row);
    row++;

    if(work_ln.new_ln == NO && row < current.buffer_end)
        del_char(row,0);
    return 0;
}

/*
 *                  ERASE TO END of line
 */

int erase_to_end(int col)
{
    register int i;

    for(i = col; i <= scrn_siz.colm; i++)        /* Blank out the rest */
        work_ln.temp_ln[i] = SPACE;             /* of the line        */

    work_ln.temp_ln[col] = EOS;
    work_ln.last_char = col;
    work_ln.new_ln = NO;
    work_ln.change_flag = YES;
    save_change();                              /* Save the changed line */
    return 0;
}                                               /* and re-display it     */
