/*
 *
 *                 SLED2
 *
 *          This file contains storage management and text buffer functions
 *
 *                        store_ln(),
 *                        struct storage *new_store(),
 *                        retrv_ln(),
 *                        insert_ln(),
 *                        char *strsave(),
 *                        save_change(),
 *                        set_null(),
 *                        list_out(),
 *                        delete_ln(),
 *                        move(),
 *                        find_str(),
 *                        print_next(),
 *                        wrap_word(),
 *                        indent_line(),
 *
 *            Modifications by Mark Griffith:
 *
 *            Fixed one extra output line bug: 19 Apr 1987
 *            Added Print_Next function:       29 May 1987
 *            Added Word-Wrap function:         6 Jun 1987
 *            Added Auto-Indent function:      12 Jun 1987
 */

#include <stdio.h>
#include "sledef.h"

struct storage *text[MAXLINES];

extern direct int margin;
extern direct struct position current;
extern direct struct sled_size scrn_siz;
extern direct struct work_buf work_ln;
extern direct struct glob_info glob_pos;
extern direct FLAG safe_flag;
extern direct char *safe_line;

/*
 *
 *            STORE LiNe into text buffer
 *
 */

int store_ln(struct work_buf *ptr, int pos)
/* store a work line into the text buffer */
{
    struct storage *np;
    char *ln;

    if((np = text[pos]) == 0){           /* Is this line in use ?  */
        np = new_store();                   /* If not allocate space  */
            if(np == 0)                  /* If no space is availabl*/
                return(0);               /* return 0            */

        text[pos] = np;                     /* set text line to ptr   */
    }
    if((ln = strsave(ptr->temp_ln)) == 0)  /* save work line       */
        usr_free_space();

    free(np->line);                         /* free old line          */
    np->line = ln;                          /* set pointer to new line*/
    np->new_line = ptr->new_ln;             /* set newline            */
    np->length = strlen(np->line);          /* and length             */

    return(TRUE);                           /* return NOT 0        */
    return 0;
}

/*
 *
 *               NEW STORagE allocation
 *
 */

struct storage * new_store(void)
/* get a new blank text line */
{
    char s[1];
    struct storage *ptr;

    s[0] = EOS;                               /* set string to blank */
    ptr = (struct storage *) malloc(sizeof(*ptr));    /* get storage */

    if(ptr != 0){
        if((ptr->line = strsave(s)) != 0){
            ptr->length = 0;                /* copy blankline to new */
        ptr->new_line = NO;
        return(ptr);
        }else
            free(ptr);                      /* if we can't get a new  */
    }                                       /* line return pointer to */
                                            /* free memory            */
    usr_msgs("\n No More Room");            /* Abort                  */
}

/*
 *
 *        RETReiVe a LiNe from storage
 *
 */

int retrv_ln(struct work_buf *ptr, int pos)
/* put line at position into ptr              */
{
    struct storage *op;
    int i;

    clear_work(ptr);                          /* clear work area        */

    if((op = text[pos]) != 0){             /* if text is at line pos */
        if(op->line != 0){               /* if the line isn't blank*/
            ptr->last_char = strlen(op->line);   /* set length             */
            strcpy(ptr->temp_ln,op->line);    /* copy line to workspace */
        }
        ptr->new_ln = op->new_line;         /* set newline            */
    }
    return 0;
}

/*
 *
 *                  INSERT LiNe into buffer
 *
 */

int insert_ln(int pos, int num)
/* insert a newline at position moving all    */
/* remaining lines down                       */
{
    extern direct FLAG ref_flag;

    register int i;
    int last;
    struct storage *ptr;

    ref_flag = NO;
    if(pos < 0 || num < 0 || pos > current.buffer_end || num > MAXLINES - current.buffer_end)
        return ERROR;
    last = pos + num;

    for(;pos < last; pos++){                    /* move and insert until  */
        if((ptr = new_store()) == 0){        /* no more lines remain   */
            usr_free_space();
        }                                       /* and exit               */

        for(i=current.buffer_end; i > pos; i--) /* move all lines         */
            text[i] = text[i - 1];

        text[pos] = ptr;                         /* store line             */
        current.buffer_end++;                    /* extend end pointer     */
    }
    return(TRUE);
    return 0;
}

/*
 *
 *                 STRing SAVE
 *
 */

char * strsave(char *s)
/* get space to save string s and copy it     */
{
    char *p;

    if((p = malloc(strlen(s) + 1)) != 0)
        strcpy(p,s);

    return(p);
}

/*
 *
 *                            SAVE CHANGEs to buffer
 *
 */

int save_change(void)
/* save any change to a line */
{
    if(work_ln.change_flag == NO)
        return 0;

    ln_to_scrn(work_ln.temp_ln,current.cursor_row,work_ln.new_ln);
    store_ln(&work_ln,current.text_row);
    work_ln.change_flag = NO;
    return 0;
}

/*
 *
 *              SET buffer to all NULLs
 *
 */

int set_null(void)
/* initialize buffer to empty */
{
    register int i;
    struct storage *new_store();

    for(i = 0; i < MAXLINES;i++)
        text[i] = 0;

    text[0] = new_store();
    current.buffer_end = 1;
    return 0;
}

/*
 *
 *               CLEAR WORKing buffer
 *
 */

int clear_work(struct work_buf *ptr)
/* set working line to empty */
{
    register int i;

    for(i = 0; i < scrn_siz.colm; i++)
        ptr->temp_ln[i] = SPACE;

    ptr->temp_ln[scrn_siz.colm] = EOS;
    ptr->temp_ln[0] = EOS;
    ptr->change_flag = NO;
    ptr->new_ln = NO;
    ptr->last_char = 0;
    return 0;
}

/*
 *
 *                   LIST OUT lines to file
 *
 */

int list_out(FILE *fd, int lines)
{
    register int i;
    int j, start;
    char outbuf[82];
    extern FLAG finish_flag;

    if(glob_pos.marker == SET)
        start = glob_pos.start;
    else
        start = current.text_row;

    lines = lines + start;
    if(lines >= current.buffer_end)
        text[current.buffer_end - 1]->new_line = YES;

#ifdef COCO3
    CLS
    fputs("\n Writing....",stderr);
#else
    pos_cur(0,STATLINE);
    fputs(" Writing....",stderr);
#endif

    for(i = start; i < lines && i < current.buffer_end - 1; i++){
        strcpy(outbuf,text[i]->line);
        j = strlen(outbuf);

        if(text[i]->new_line == YES) {
            for(j--; j > 0 && outbuf[j] == ' '; j--)
                ;
            j++;
            outbuf[j++] = EOR;
        }else{
            if(i == current.buffer_end - 1)
                return 0;

            if(j == 0) outbuf[j++] = EOR;
        }
        if(write(fileno(fd),outbuf,j) != j)
            usr_msgs("\n ERROR on Write");
    }
    return 0;
}

/*
 *
 *                    DELETE a LiNe
 *
 */

int delete_ln(int row, int num)
/* delete num lines at position row */
{
    struct storage *ptr;
    register int j;
    int last,i;

    last = row + num;
    for(i=row;i < last && row < current.buffer_end;i++){
        if((ptr = text[row]) != 0){      /* if the position is used */
            if(ptr->line != 0)           /* and the line is used    */
                free(ptr->line);            /* give the space back     */

            free(ptr);                      /* give the space back     */
            text[row] = 0;               /* set pointer to 0     */
        }
        current.buffer_end--;

        for(j=row;j < current.buffer_end;j++)       /* Move remaining  */
            text[j] = text[j + 1];                  /* lines down to   */
                                                    /* fill in space   */
        text[current.buffer_end] = 0;            /* and set lastline*/
    }
    if(row == 0 && current.buffer_end == 0){
        text[row] = new_store();
        current.buffer_end = 1;
    }else if(row >= current.buffer_end){
        current.text_row = current.buffer_end - 1;;
        if(current.text_row < current.top_screen)
            current.top_screen = current.text_row;

        if((current.top_screen + current.cursor_row) >= current.buffer_end)
            current.cursor_row = current.text_row - current.top_screen;
    }
    retrv_ln(&work_ln,current.text_row);
    if(safe_flag == NO)
        if((safe_line = malloc(scrn_siz.colm + 1)) != 0)
            safe_flag = YES;
    return 0;
}
/*
 *
 *                      MOVE text
 *
 */

int move(void)
/* move text lines from one place to another  */
{
    extern direct struct glob_info glob_pos;

    struct storage *ptr;
    int count,low,high,test;
    register int i;

    if((count = glob_pos.num) < 1)
        return 0;

    if((current.text_row >= glob_pos.start) && current.text_row <= (glob_pos.start + count)){
        usr_msgs("\n Move Conflict");
    }

    if((test = glob_pos.start - current.text_row) > 0){
        low = current.text_row;
        high = glob_pos.start;

        while(count-- > 0){
            ptr = text[high];

            for(i = high; i > low;i--)
                text[i] = text[i - 1];

            text[low] = ptr;
            low++;
            high++;
        }
    }else if(test < 0){
        low = glob_pos.start + count - 1;
        high = current.text_row - 1;

        while(count-- > 0){
            ptr = text[low];

            for(i = low;i < high;i++)
                text[i] = text[i + 1];

            text[high] = ptr;
            low--;
            high--;
        }
    }
    return 0;
}

/*
 *
 *                    FIND A STRING in text buffer
 *
 */

int find_str(char *str)
/* locate str in the remainder of the buffer  */
{
    register int i;
    int len,leng,x;
    char buffer[256];

    len = strlen(str);

    for(i = current.text_row;i < current.buffer_end;i++){
        strcpy(buffer,text[i]->line);
        if( text[i]->new_line == NO){

            for(x = text[i]->length;x < scrn_siz.colm;x++)
                buffer[x] = ' ';

            strncpy(&buffer[scrn_siz.colm],text[i + 1]->line,len);
            buffer[scrn_siz.colm + len] = EOS;
            leng = scrn_siz.colm + len;
        }else
            leng = text[i]->length;

        if((x = midstr(str,buffer,current.col,leng)) != ERROR) {
            current.col = ((x >= scrn_siz.colm) ? (scrn_siz.colm - 1) : x);
            return(i);
        }
        current.col = margin;
    }
    current.col = margin;
    return(ERROR);
    return 0;
}

/*
**      Print_Next -- Prints the next buffer line to the screen.
**
**                    Used by Insert and delete functions for lines
**                    longer than the screen width.
*/

int print_next(int cursor_row, int text_row)
{
    ln_to_scrn(work_ln.temp_ln,cursor_row,work_ln.new_ln);
    if(cursor_row != LASTLINE) {
        retrv_ln(&work_ln,++text_row);
        pos_cur(0,++cursor_row);
        ln_to_scrn(work_ln.temp_ln,cursor_row,work_ln.new_ln);
        retrv_ln(&work_ln,current.text_row);
    }
    return 0;
}

/*
**      Wrap-Word -- Takes any broken word and moves the entire word to
**                   the next line and inserts it if the word-wrap option
**                   is turned on.
*/

int wrap_word(void)
{
    register int i;
    int n;
    char c, word[80];

    i = scrn_siz.colm;
    n = 0;

    while(i > 0 && work_ln.temp_ln[i - 1] != SPACE) --i;
    if(i == 0) return 0;
    --i;

    work_ln.temp_ln[scrn_siz.colm] = EOS;       /* Set the current line  */
    work_ln.temp_ln[i] = EOS;                   /* parameters to delete  */
    work_ln.last_char = i;                      /* The last partial word */
    work_ln.new_ln = YES;                       /* and end it with a CR. */
    work_ln.change_flag = YES;

    while(work_ln.temp_ln[++i] != EOS)          /* Copy the partial word */
        word[n++] = work_ln.temp_ln[i];         /* to a temp location.   */

    word[n] = EOS;              /* Set the last space as the end of line */

    if ((current.text_row + 1) < current.buffer_end) {  /* Insert a new */
        insert_ln(current.text_row + 1, 1);           /* line into the */
        ins_line();                                     /* buffer if this */
    }                                                   /* is not the last */
                                                        /* line. */
    adv_line();
    i = 0;
    n = margin;                  /* Set to the margin in case indent is on */

    work_ln.temp_ln[0] = SPACE;     /* Clear out the beginning of the line */
    while(word[i] != EOS)                       /* Now copy the partial  */
        work_ln.temp_ln[n++] = word[i++];       /* word to the next line */

    work_ln.last_char = current.col = n;
    work_ln.temp_ln[work_ln.last_char] = EOS;
    work_ln.change_flag = YES;
    save_change();

    return 0;
}

/*
**           Indent_Line -- Adds spaces to the beginning of a line so it
**                          matches the indent of the line above.
**
**           (Does this by setting the left margin to match. Sneaky!)
*/

int indent_line(void)
{
    register int i = (-1);
    char c;

    while((c = work_ln.temp_ln[++i]) == SPACE) /* Find the first character */
        ;
    margin = i;                                /* and set the margin there */
    return 0;
}

/* Keep one empty sentinel after the last edited line for the streaming writer. */
int ensure_end(void)
{
 struct storage *last;
 last=text[current.buffer_end-1];
 if(last->length) last->new_line=YES;
 if(last->length || last->new_line) return insert_ln(current.buffer_end,1);
 return 0;
}
