/*
 *
 *                   SLED4
 *
 *               Various I/O and string functions
 *
 *               functions in this file -
 *                   file_info(),
 *                   print_out(),
 *                   get_file(),
 *                   file_read(),
 *                   file_write(),
 *                   char *get_arg(),
 *                   midstr(),
 *                   parse_ln(),
 *                   file_clean(),
 *                   first_read(),
 *                   temp_read(),
 *                   fcopy();
 *
 *
 *    Update History:  09-20-85   To Correct an error in the File Read command
 *                     09-21-85   Made the Temporary read work like the normal
 *                                read command so that file merging is now
 *                                possible.
 *
 *    Updates by Mark Griffith:
 *
 *       Changed file_read() to allow linefeed characters thru: 3 Jun 1987
 *       Limited file_read to less than maximum buffer space
 *           to allow further editing of that portion:         10 Dec 1987
 *       Added process unique output file capability:          11 Dec 1987
 *       Added automatic deletion of first read file:          14 Dec 1987
 *       Added expansion of TAB characters:                    17 Dec 1987
 *       Added creation of new file if none exists:             6 Mar 1988
 *       Added auto file updating to read/write:               15 Mar 1998
 *       Added fcopy() to append remaining file on exit:       18 Mar 1988
 *       Added writing of marked blocks only:                  27 Mar 1988
 *
 */

#include "sledef.h"
#include <stdio.h>
#include <ctype.h>

/*
 *       LOCAL STATIC VARIABLES
 *
 */

static struct rw_dat rw_info;
static FILE *fd_read,*fd_write;
static FLAG fr_write;
static char tmpname[15] = "sledtmp.XXXXX";
static char read_fil[80];

/*
 *       EXTERNAL VARIABLES
 */

extern direct struct position current;
extern direct struct work_buf work_ln;
extern direct struct sled_size scrn_siz;
extern direct struct glob_info glob_pos;
extern direct char *tab_str;
extern struct storage *text[MAXLINES];
extern FLAG finish_flag,
            update_flag;

/*
 *
 *               FILE INFO gets name & lines to read/write
 *
 */
int file_info(char *message)
{

    int count,lines;
    char *str,*ptr[2];

        if((str = get_arg(message,'a')) == 0)
            return(0);

    if(glob_pos.marker == SET) {
        rw_info.name = str;
        rw_info.lines = glob_pos.num;
        return 2;
    }

    if((count = parse_ln(str,ptr,2)) > 0){
        if(count == 1)
            rw_info.name = 0;
        else
            rw_info.name = ptr[1];

        if(ptr[0][0] == '*')
            rw_info.lines = MAXLINES;
        else if(spatoi(ptr[0],2,&lines) == 1)
            rw_info.lines = lines;
        else
            return(0);

        return(count);
    }
    return(0);
    return 0;
}

/*
 *
 *                        PRINTOUT
 *
 */

int print_out(void)
{

FILE *fd;

    int c;

    file_info("\n OUTPUT ? ");

    if(rw_info.name != 0){
        if(strcmp(rw_info.name,"/p")) {
            if((fd = fopen(rw_info.name,"r")) != 0) {
                CLS
                fclose(fd);                    /* Close it again */
                fputs("\n File exists - Overwrite? (y/n) ",stderr);
                while((c = toupper(getchar())) != 'Y' && c != 'N')
                    ;

                if(c == 'N') {
                    if((fd = fopen(rw_info.name,"a+")) == 0) {
                        usr_msgs("\n Open ERROR");
                        return 0;
                    }else{
                        list_out(fd,rw_info.lines);
                        fclose(fd);
                        return 0;
                    }
                }
            }
        }
        if((fd = fopen(rw_info.name,"w")) == 0) { /* Overwrite the */
            usr_msgs("\n Open ERROR");               /* file */
            return 0;
        }
        list_out(fd,rw_info.lines);
        fclose(fd);
        return 0;
    }
  usr_msgs("\n Fmt = #lines Path");
    return 0;
}

/*
 *
 *                   GET FILE
 *
 */

int get_file(void)
{
    int count;
    FILE *fd;
    extern FLAG update_flag;

    if(update_flag == NO) {
        if((count=file_info("\n Read ? ")) == 0){
            usr_msgs("\n Fmt = #lines {opt. Path}");
        return 0;
        }
    }else{
        rw_info.name = 0;
        rw_info.lines = MAXLINES;
        current.text_row = current.buffer_end;
        count = 1;
    }
    if(count > 1 && rw_info.name != 0)
        if((fd = fopen(rw_info.name,"r")) == 0){
            usr_msgs("\n Can't OPEN Path for Read");
            return 0;
        }else{
            if(strlen(rw_info.name) >= sizeof(read_fil)) {fclose(fd);usr_msgs("\n File name too long");return ERROR;}
            strcpy(read_fil, rw_info.name);
            if(fd_read != 0)
                fclose(fd_read);
                fd_read = fd;
        }
    if(fd_read == 0) {usr_msgs("\n No input file open");return ERROR;}
    file_read(fd_read,rw_info.lines);
    return 0;
}

/*
 *
 *                          FILE READ
 *
 */

int file_read(FILE *fd, int lines)
{
    register int i;
    int c,count,row;

    if(fd == 0 || lines < 1) return ERROR;
    count = 0;
    c = EOL;
    row = current.text_row;

#ifdef COCO3
   CLS
   fputs("\n Reading....",stdout);
#endif

    while( ++count < lines && c != EOF){
        work_ln.new_ln = NO;
        row++;

        if(insert_ln(row,1) == ERROR)
            return 0;

        if(count == (MAXLINES - 400)) {
            CLS
            command(KILL_LINE);
            usr_msgs("\n Edit buffer full");
        }

        for(i = 0; i < scrn_siz.colm && work_ln.new_ln == NO; i++)
            if((c = getc(fd)) == EOR || c==EOF) {
                work_ln.last_char = i;
                work_ln.new_ln = YES;
            }else{
                if(c == '\n')
                    c = SPACE;

                if(c == '\t') {
                    c = SPACE;
                    while(i < scrn_siz.colm - 1 && tab_str[i + 1] != SET)
                        work_ln.temp_ln[i++] = c;
                }

                if(isprint(c)) {            /* If a printable character */
                    work_ln.temp_ln[i] = c; /* store it in the buffer */

                    if(i == (scrn_siz.colm - 1))
                        work_ln.last_char = scrn_siz.colm;
                }
            }
            if(i == scrn_siz.colm)
                if((c = getc(fd)) == EOR || c == EOF)
                    work_ln.new_ln = YES;
                else
                    ungetc(c,fd);

            work_ln.temp_ln[work_ln.last_char] = EOS;
            if(c == EOF && work_ln.last_char == 0) work_ln.new_ln = NO;
            store_ln(&work_ln,row);
    }
    return 0;
}

/*
 *
 *                          FILE WRITE
 *
 */

int file_write(void)
{
    register int i;
    struct storage *ptr;
    int count;
    FILE *fd;

    save_change();
    ensure_end();
    if(finish_flag == NO && update_flag == NO) {
        if((count = file_info("\n Write ? ")) == 0){
            usr_msgs("\n Fmt = #lines {opt. Path}");
            return 0;
        }
    }else{
        rw_info.name = 0;

        if(update_flag == YES) {
            rw_info.lines = current.text_row - 1;
            current.text_row = 0;
            count = 1;
        }else{
            rw_info.lines = MAXLINES;
            count = 1;
        }
    }

    if(fr_write == NO && rw_info.name == 0){

        if((fd = fopen(tmpname,"w")) == 0){
            usr_msgs("\n ERROR on OPEN for Write");
            return 0;
        }else{
            fr_write = YES;
            fd_write = fd;
        }
    }
    if(count > 1 && rw_info.name != 0){
        if((fd = fopen(rw_info.name,"a+")) == 0){
            usr_msgs("\n ERROR on OPEN for Write");
            return 0;
        }else{
            if(fd_write != 0)
                fclose(fd_write);

            fd_write = fd;
        }
    }

    list_out(fd_write,rw_info.lines);
    fr_write = YES;

    if(finish_flag == NO)
        if(glob_pos.marker == SET) {
            delete_ln(glob_pos.start,glob_pos.num);
            glob_pos.start = 0;
            glob_pos.num = 0;
            glob_pos.marker = UNSET;
            c_owend();
            write_stat(42,"               ");
        }else
            delete_ln(current.text_row,rw_info.lines);
    else
        fcopy();            /* Copy remaining portion to output file */
    return 0;
}

/*
 *
 *    gets Additional Command Keystrokes From the Keyboard
 *
 */

char * get_arg(char *message, char kind)
{
    static char str[86];
    int c,i;
    i=0;str[0]=EOS;
    fputs(message,stdout);
    for(;;) {
        c=getchar();
        if(c==EOF || c==ENTER || c=='\n') {str[i]=EOS;return str;}
        if(c==LEFTARR) {
            if(i>0) {--i;putchar(c);}
        } else if(i < sizeof(str)-1 && c>=SPACE && c<127 &&
                  (kind!='n' || isdigit(c) || c==SPACE || c=='*')) {
            str[i++]=c;putchar(c);
        }
    }
}

/*
 *
 *        MIDSTR Finds str s1 in s2
 *
 */

int midstr(char *s1, char *s2, int pos, int len)
{

    int i,j;

    for(;s2[pos] != '\0'; pos++){
        for(i=pos, j=0; s1[j] != '\0' && s2[i]==s1[j] && i < len; i++,j++)
            ;
        if(s1[j] == '\0')
            return(pos);
    }
    return(ERROR);
    return 0;
}

/*
 *
 *                   PARSE LiNe
 *
 */

int parse_ln(char *str, char **ptr, int num)
{
    register int count = 0;

    while(*str != EOS && count < num){
        while(isspace(*str) != 0){
            *str = EOS;
            str++;
        }
        if(*str != EOS){
            ptr[count++] = str;
            while(*str != EOS && isspace(*str) == 0)
                str++;
        }
    }
    return(count);
    return 0;
}
/*
 *
 *                          File CLEAN
 *
 *    Closes any opened paths and prompts for deletion of the read
 *    file if a temp file was created.  Deletes the old file and
 *    renames the temp file to the original file name.
 */

int f_clean(void)
{
    int c,failed;
    FILE *source,*dest;
    char *name;

    if(fd_read != 0) {fclose(fd_read);fd_read=0;}
    if(fd_write != 0) {
        failed=fclose(fd_write);fd_write=0;
        if(failed) {usr_msgs("\n Close failed; temp kept");return ERROR;}
    }
    if((source=fopen(tmpname,"r")) == 0) return 0;
    c_owset();
    CLS
    if(read_fil[0] == EOS) {
        name=get_arg("\n Save as: ",'a');
        if(name[0] == EOS || strlen(name) >= sizeof(read_fil)) {fclose(source);return ERROR;}
        strcpy(read_fil,name);
    }
    fputs("\n Replace ",stderr);fputs(read_fil,stderr);fputs(" (y/n) ",stderr);
    do {c=getchar();if(c==EOF) {fclose(source);return ERROR;}} while((c=toupper(c))!='Y' && c!='N');
    if(c=='N') {fclose(source);c_owend();return 0;}
    /* Keep the complete temporary copy until the destination closes cleanly.
       This also supports absolute paths without an external rename command. */
    dest=fopen(read_fil,"w");
    if(dest==0) {fclose(source);usr_msgs("\n Cannot open destination; temp kept");return ERROR;}
    failed=0;
    while((c=getc(source))!=EOF) if(putc(c,dest)==EOF) {failed=1;break;}
    if(ferror(source)) failed=1;
    if(fclose(source)) failed=1;
    if(fclose(dest)) failed=1;
    if(failed) {usr_msgs("\n Save failed; temporary file kept");return ERROR;}
    unlink(tmpname);
    c_owend();
    return 0;
}

/*
 *
 *                   FIRST file READ
 *
 */

int first_read(int count, char *args[])
{
    FILE *fd;
    int lines;

    if(mktemp(tmpname)) {fix_scrn();fputs("No temp name\n",stderr);exit(20);}
    if(count > 1 && strlen(args[1]) >= sizeof(read_fil)) {fix_scrn();exit(20);}

    if(count < 2){
        fd_read = 0;
        return 0;
    }
    c_owset();

    if(count == 3){
        if(spatoi(args[2],2,&lines) != 1)
            rw_info.lines = MAXLINES;
        else
            rw_info.lines = lines;
    }else
        rw_info.lines = MAXLINES;

    if((fd = fopen(args[1],"r")) == 0){    /* Try to open the file */
        if((fd = fopen(args[1],"w+")) == 0) {
            puts("\n Create ERROR - Press <ENTER>");
        }else{
            strcpy(read_fil, args[1]);
            fd_read = fd;
            puts("\n New file - <ENTER>");
            while(getchar() != ENTER)
                ;
        }
    }else{
        strcpy(read_fil, args[1]);
        fd_read = fd;
        file_read(fd_read,rw_info.lines);
    }

    command(KILL_LINE);        /* delete first line which is always blank */
                               /* and is not part of the file anyway */
    c_owend();
    return 0;
}

/*
 *
 *                          TEMPorary file READ
 *
 */

int temp_read(void)
{
    FILE *fd;
    static FILE *fd_temp;

    if(file_info("\n Alt Read ? ") == 0){
        usr_msgs("\n FMT - #lines {optional Path}");
        return 0;
    }

    if(rw_info.name != 0)
        if((fd = fopen(rw_info.name,"r")) == 0){
            usr_msgs("\n Can't OPEN Path");
            return 0;
        }else{
            if(fd_temp != 0)
                fclose(fd_temp);
                fd_temp = fd;
        }
    file_read(fd_temp,rw_info.lines);
    return 0;
}

/*
**      Fcopy - Copies any remaining unread portion of a file to
**              to the output file when quiting the editor
*/

int fcopy(void)
{
    register int c;

    if(fd_read == 0 || fd_write == 0) return 0;
    while ((c = getc(fd_read)) != EOF) {
        if ((putc(c,fd_write)) == ERROR) {
            CLS
            usr_msgs("\n ERROR on Write");
            return 0;
        }
    }
    return 0;
}

