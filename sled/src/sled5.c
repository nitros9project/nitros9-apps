/*
 *
 *                      SLED5
 *
 *             This file contains the global functions for SLED
 *
 *             functions :
 *                 global(),
 *                 parse_glob(),
 *                 copy(),
 *                 replace(),
 *                 find(),
 *                 spatoi(),
 *
 *              Modifications by Mark Griffith:
 *
 *              Changed global delete/move/copy to use new
 *                  block marking function:                 27 Mar 1988
 *
 *              Changed FIND command - added "next" option: 29 Mar 1988
 */

#include <ctype.h>
#include <stdio.h>
#include "sledef.h"

/*
 *             VARIABLES
 */

direct struct glob_info glob_pos;

extern direct struct position current;
extern direct struct work_buf work_ln;
extern direct struct sled_size scrn_siz;
extern direct int margin;

/*
 *
 *                     GLOBAL interpreter
 *
 */

int global(void)
{
    int count,start,lines;
    char *str,ch,*ptr[4];

    if((str = get_arg("\n Global ? ",'p')) == 0)
        return(0);

    if((count = parse_glob(str,ptr,4)) == 0)
        return(0);

    ch = toupper(ptr[0][0]);

    switch (ch) {

    case 'C' :
        c_owend();
        copy();
        break;

    case 'M' :
        c_owend();
        move();
        break;

    case 'F' :
        if(count < 1){
            usr_msgs("\n FMT - F/str/#");
            return(0);
        }else if(count > 2){
            if(midstr("*",ptr[2],0,strlen(ptr[2])) != ERROR)
                lines = MAXLINES;
            else if(spatoi(ptr[2],1,&lines) != 1)
            lines = 1;
        }else
            lines = 1;

        c_owend();
        find(ptr[1],lines,0);    /* Do the first find */
        break;

    case 'R' :
        if(count < 3){
            usr_msgs("\n FMT - R/search/replace/#");
            return(0);
        }else if(count > 3){
            if(midstr("*",ptr[3],0,strlen(ptr[3])) != ERROR)
                lines = MAXLINES;
            else if(spatoi(ptr[3],1,&lines) != 1)
                lines = 1;
        }else
            lines = 1;

#ifdef COCO3
    CLS
    fputs("\n Working....",stderr);
#endif
        replace(ptr[1],ptr[2],lines);
        c_owend();
        break;

    case 'A' :
    case 'K' :
        if(count == 0) {
            if(ch == 'A')
                usr_msgs("\n FMT - A #lines");
            else
                usr_msgs("\n FMT - K #lines");
            return(0);
        }
        if(count == 2){
            start = current.text_row;

            if(midstr("*",ptr[1],0,strlen(ptr[1])) != ERROR) {
                lines = current.buffer_end - current.text_row;
            }else if(spatoi(ptr[1],2,&lines) != 1){
                usr_msgs("\n ERROR in Lines Spec");
                return(0);
            }
        }else{
            start = glob_pos.start;
            lines = glob_pos.num;
        }
        if(ch == 'A')
            insert_ln(start,lines);
        else{
            delete_ln(start,lines);
            glob_pos.start = 0;
            glob_pos.num = 0;
            glob_pos.marker = UNSET;
            c_owend();
            write_stat(42,"              ");
        }
        break;

    default :
        usr_msgs("\n Only C,M,A,F,R,K Allowed");
         break;
    }
    c_owend();
    return(0);
    return 0;
}

/*
 *      PARSE GLOBal command string
 */

int parse_glob(char *str, char *ptr[], int num)
{
    char dlim;
    int count = 0;

    while(*str == ' ')               /* skip blanks */
        str++;

    if(*str == EOS)
        return(0);

    ptr[0] = str;
    str++;
    count++;

    if(*str == EOS)
        return(count);

    dlim = *str;
    *str = EOS;
    str++;

    while(*str != EOS && count < num){
        if(*str == dlim){
            *str = EOS;
            str++;
        }else{
            ptr[count++] = str;
            while(*str != dlim && *str != EOS)
                str++;
        }
    }
    *str = EOS;
    return(count);
    return 0;
}

/*
 *      COPY a block of text from one position to another
 */

int copy(void)
{
    int row,old_end,count,pos;

    old_end = current.buffer_end;
    pos = glob_pos.start;
    row = current.buffer_end;

    for(count = 0;count < glob_pos.num; count++,pos++,row++){
        retrv_ln(&work_ln,pos);
        if((insert_ln(row,1) == ERROR) || (store_ln(&work_ln,row) == 0)){
            while(--current.buffer_end >= old_end)
                delete_ln(current.buffer_end,1);
            current.buffer_end++;
            usr_msgs("\n Can't Copy");
        }
    }
    row = glob_pos.start;                   /* save for further copies */
    glob_pos.start = old_end;

    move();

    glob_pos.start = row;                   /* restore to old position */
    return 0;
}

/*
 *      REPLACE a block of text
 */

int replace(char *search, char *repl, int num)
{
    register int i;
    int slen,rlen,row,j;

    slen = strlen(search);
    rlen = strlen(repl);

    while(num-- > 0){
        if((row = find_str(search)) != ERROR){
            current.text_row = row;

        for(i = slen; i > 0; i--)
            del_char(row,current.col);

        for(i = rlen - 1;i >= 0; i--)
            insert_char(repl[i],row,current.col);
        }else
            num = 0;
   }
   current.top_screen = ((current.text_row - current.cursor_row) >= 0 ? (current.text_row - current.cursor_row) : 0);
    return 0;
}

/*
 *      FIND a string
 */

int find(char *str, int times, int find_next)
{
    int x,safe;
    register int i;
    static char s[40];
    safe = x = current.text_row;

    if(find_next == YES)                /* Point to the previous string */
        str = &s[0];

    for(i=0;i < times && x < current.buffer_end;i++){
        if((x = find_str(str)) != ERROR){
            retrv_ln(&work_ln,x);
            current.col++;
            safe = current.text_row = x;
        }else
            x = ++current.text_row;
    }
    current.text_row = safe;
    current.top_screen = ((current.text_row - current.cursor_row) >= 0 ? (current.text_row - current.cursor_row) : 0);

    if(find_next == NO)                 /* Copy the new string to the */
        strcpy(s, str);                 /* static storage buffer      */
    return 0;
}

/*
 *
 *                        SPecial ATOI function
 *
 */

int spatoi(char *str, int num, int ptr[])
/* convert numbers to integers */
{

    int d,count;
    register int i;

    for(count = 0;count < num;count++){
        d=0;
        while(isspace(*str) != 0)
            str++;

        if(isdigit(*str) == FALSE)
            return(count);

        for(i=0; *str >= '0' && *str <= '9';i++){
            d = (d * 10) + (*str - '0');
            str++;
        }
        ptr[count] = d;
    }
    return(count);
    return 0;
}
