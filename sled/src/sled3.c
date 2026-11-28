/*
 *                      SLED3
 *
 *              a file of screen handling functions for SLED
 *
 *              functions =
 *                         ln_to_scrn(),
 *                         refresh(),
 *                         usr_msgs(),
 *                         toggle_tab(),
 *                         tab(),
 *                         detab(),
 *                         page_up(),
 *                         page_down(),
 *                         go_to_top(),
 *                         go_to_end(),
 *                         go_to_line(),
 *                         show_help(),
 *                         press_enter(),
 *
 *              Modifications by Mark Griffith:
 *
 *              Improved speed of screen refresh: 11 Apr 1987
 *              Adding Windowing functions      : 16 May 1987
 *              Added help messages screens     : 22 May 1987
 *              Added Windows to Help Messages  : 21 Oct 1987
 *
 */

#include <stdio.h>
#include "sledef.h"
#include <setjmp.h>

extern direct FLAG insert_flag;
extern direct struct sled_size scrn_siz;
extern direct struct position current;
extern direct struct work_buf work_ln;
extern direct struct scrn def_scrn;
extern direct jmp_buf vector;
extern direct int margin;
extern direct char *tab_str;
extern direct struct glob_info glob_pos;

/*
 *             send a LiNe TO the SCReeN
 */

int ln_to_scrn(char lin[], int pos, int new)
{
   pos_cur(0,pos);
   write(1,lin,strlen(lin));
   CLR_EOL

   if (new == NO) {
      pos_cur(scrn_siz.colm,pos);
      write(1,"-",1);
   }
    return 0;
}

/*
 *          REFRESH screen
 */

int refresh(int row, int partial)
{
   int trow;
   static int hi_light;

   while((trow = row + current.top_screen) < current.buffer_end && row <= LASTLINE){
      retrv_ln(&work_ln,trow);
      if(trow >= glob_pos.start && trow <= (glob_pos.start + (glob_pos.num - 1))) {
         FColor(STDERR,RED);
         hi_light = YES;
      }
      else{
         if(hi_light == YES) {
            FColor(STDERR,def_scrn.fcolor);
            hi_light = NO;
         }
      }
      ln_to_scrn(work_ln.temp_ln,row,work_ln.new_ln);

      if(partial == YES && work_ln.new_ln == YES){
         retrv_ln(&work_ln,current.text_row);
         return 0;
      }
      row++;
   }
   for(;row <= LASTLINE;row++){  /*   blank out remaining screen, if any */
      pos_cur(0,row);
      CLR_EOL
   }
   retrv_ln(&work_ln,current.text_row);
    return 0;
}

/*
 *            send the USeR MeSsaGeS
 */

int usr_msgs(char *message)
{
   extern FLAG finish_flag;

   c_owset();
   CLS
   fputs(message,stdout);
   fputs(" - <ENTER>",stdout);

   while(getchar() != ENTER);

   if(finish_flag == YES){
      finish_flag = NO;
      c_owend();
      refresh(0,NO);
   }

   c_owend();
   longjmp(vector,0);
    return 0;
}

/*
 *             TOGGLE TAB position on or off
 */

int toggle_tab(void)
{
   char *stop;
   stop = tab_str + current.col;
   if(*stop == UNSET)
      *stop = SET;
   else
       *stop = UNSET;
    return 0;
}

/*
 *        TAB to next stop
 *
 *  NOTE: Two different routines are included in this function, one for
 *        if insert is on, and one if it is not.  The reason for this is
 *        it made the function too slow if it was not checked first, hence
 *        the two routines.  They are both basically the same.
 */

int tab(void)
{
   register int i;
   FLAG NEWLINE = NO;

   if(insert_flag == NO){
      for(i=current.col + 1;i < scrn_siz.colm- 1; i++){
         if(tab_str[i] == SET)
            break;
      }
      if(i < scrn_siz.colm)
         current.col = i;
      else
          current.col = scrn_siz.colm - 1;
   }
   else{
      for(i=current.col + 1;i < scrn_siz.colm- 1; i++){
         if(work_ln.new_ln == YES && work_ln.last_char + 1 == scrn_siz.colm){
            if(NEWLINE == NO){
               pos_cur(0,current.cursor_row+1);
               ins_line();
               NEWLINE = YES;
            }
         }
         insert_char(SPACE,current.text_row,current.col);

         if(tab_str[i] == SET)
            break;
      }
      if(i < scrn_siz.colm)
         current.col = i;
      else
          current.col = scrn_siz.colm - 1;

      ln_to_scrn(work_ln.temp_ln,current.cursor_row,work_ln.new_ln);

      if(work_ln.new_ln == NO)
         print_next(current.cursor_row,current.text_row);

   }
    return 0;
}

/*
 *                DETAB to previous tab stop
 */

int detab(void)
{
   register int i;

   for(i= current.col - 1; i > 0 ; i--)
      if(tab_str[i] == SET)
         break;

   if(i > 0)
      current.col = i;
   else
       current.col = 0;
    return 0;
}

/*
 *                   PAGE UP
 */

int page_up(void)
{
   save_change();

   if((current.top_screen - LASTLINE) < 0)
      current.top_screen = 0;
   else
       current.top_screen -= LASTLINE;

   current.text_row = current.top_screen + current.cursor_row;
   retrv_ln(&work_ln,current.text_row);
    return 0;
}

/*
 *                    PAGE DOWN
 */

int page_down(void)
{
   save_change();

   if((current.top_screen + LASTLINE) > current.buffer_end - 1)
      current.top_screen = current.buffer_end - 1;
   else
       current.top_screen += LASTLINE;

   if((current.top_screen + current.cursor_row) >= current.buffer_end)
      current.cursor_row = current.buffer_end - current.top_screen - 1;

   current.text_row = current.top_screen + current.cursor_row;
   retrv_ln(&work_ln,current.text_row);
    return 0;
}

/*
 *                  GO TO TOP
 */

int go_to_top(void)
{
   save_change();
   current.cursor_row = current.text_row = current.top_screen = 0;
   retrv_ln(&work_ln,current.text_row);
    return 0;
}

/*
 *                  GO TO END
 */

int go_to_end(void)
{
   save_change();

   if((current.buffer_end - LASTLINE) < 0)
      current.text_row = current.cursor_row = current.top_screen = 0;
   else{
      current.top_screen = (current.buffer_end - LASTLINE);
      current.text_row = current.buffer_end;
      current.cursor_row = LASTLINE;
   }
   retrv_ln(&work_ln,current.text_row);
    return 0;
}

/*
 *                  GO TO LINE
 */

int go_to_line(void)
{
   char *str;
   int line;

   if((str = get_arg("\n Text Pos ? ",'n')) == 0) {
      CLS
          usr_msgs("\n FMT - Text Pos ? #textline");
   }
   if(spatoi(str,1,&line) == 0)
      return 0;

   if(line >= current.buffer_end)
      line = current.buffer_end - 1;

   current.text_row = line;
   current.top_screen = current.text_row - current.cursor_row;

   if(current.top_screen < 0){
      current.top_screen = 0;
      current.cursor_row = current.text_row;
   }

    return 0;
}

/*
**             Show Help Messages
**
** A maximum of 13 lines are used and less than 40 columns.
** Pressing any key other than ENTER returns to edit mode
*/

int show_help(void)
{
   int quit = NO;

#ifdef COCO3
    b_owset();                      /* Open the box overlays */
#else
   fix_scrn();
#endif

   puts(" \n Cursor Positioning:\n");
   puts(" Arrow Keys - Move one space each way");
   puts(" Shifted-UP-DOWN-Arrow: Page UP / DOWN");
   puts(" Shifted-LEFT-RIGHT Arrow: TAB / DETAB\n");
   puts(" Cntl-B: Go to file beginning");
   puts(" Cntl-E: Go to file end");
   puts(" Cntl-P: Go to a specific line number");
   puts(" Cntl-V: Insert a LF at cursor position");

   if((press_enter()) == YES){
      puts("\n     File I/O:\n");
      puts(" Cntl-R: Read from a file");
      puts(" Cntl-W: Write to a file");
      puts(" Cntl-F: Alternate file read");
      puts(" Cntl-O: Alternate file output/print");
      puts(" Cntl-U: Update buffer");
   }
   else
      quit = YES;

   if(quit == NO){
      if((press_enter()) == YES){
         puts("\n     Editing Commands:\n");
         puts(" Cntl-D: Delete one character");
         puts(" Cntl-A: Insert one line");
         puts(" Cntl-K: Kill (delete) one line");
         puts(" Cntl-C: Clear to the End-of-Line");
         puts(" Cntl-G: Enter Global Commands\n");
         puts(" F1    : Toggle insert mode");
         puts(" F2    : Toggle Word-Wrap mode");
         puts(" Shft-F1 Toggle Auto-Indent mode");
      }
      else
         quit = YES;
   }
   if(quit == NO){
      if((press_enter()) == YES){
         puts("\n     Global Commands:\n");
         puts(" F/str/#      : Find <str> #times");
         puts(" R/str/nstr/# : Replace <str> with");
         puts("                <nstr> #times\n");
         puts(" K # : Kill #lines");
         puts(" A # : Add #lines");
         puts(" C # : Copy #lines (if already set)");
         puts(" M # : Move #lines (if already set)");
         puts(" Alt-M Block mark/start/end/finish");
         puts(" Ctl-N Find next occurance");
      }
      else
         quit = YES;
   }
   if(quit == NO){
      if((press_enter()) == YES){
         puts("\n     Misc Commands:\n");
         puts(" Cntl-T: Set TAB at cursor position");
         puts(" Cntl-S: Set MARGIN at cursor position");
         puts(" Alt -U: Enter USER command parser\n");
         puts(" Cntl-Q: Quit SLED");
      }
      else
         quit = YES;
   }
   if(quit == NO)
      press_enter();

#ifdef COCO3
   b_owend();                   /* Close both overlay windows */
#else
   set_scrn();
#endif

    return 0;
}                               /* Return to editing */

/*
 *            Wait for ENTER to be pressed
 */

int press_enter(void)
{
   fputs("\n <ENTER> to continue ",stdout);
   if(getchar() == ENTER){
      CLS
          return(YES);
   }
   else
       return(NO);
    return 0;
}
