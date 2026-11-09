/********************************************************************/
/*                                                                  */
/* The ppc program reads in a text file and prints it on standard   */
/*   output with pagination and line numbering.  In addition, some  */
/*   standard comments are recognised.  These comments must start   */
/*   in column 1 and must not contain spaces.  Recognised comments  */
/*   are as follows:                                                */
/*                                                                  */
/*   page  - - - forces start of new output page                    */
/*   noprint - - supresses output lines                             */
/*   print - - - restarts output                                    */
/*                                                                  */
/*                                                                  */
/*     Modified and put back in the public domain by                */
/*      Carl Kreider                                                */
/********************************************************************/
#include <stdio.h>
#define LMAX 121
#define PAGBOT 60
int  curlin, pagno, linno;
int  nflag=TRUE;                            /* true is numbers */
int  sflag=FALSE;                          /* true is suppress */
char tbuf[6];                              /* time read buffer */
char buf[LMAX];                            /* read line buffer */
FILE *fp, *fopen();
main(argc,argv)
int  argc;
char *argv[];
   {
   char ch, *p;
   if (argc < 2)
         {
         help(' ');                                 /* no args */
         exit (0);
         }
   while (--argc)
      {
      argv++;
      if (**argv == '-')
            {
            p = *argv;
            if ((ch = *++p) == 'n')
                  nflag = FALSE;                 /* no numbers */
               else
                  help(ch);
            }
         else
            {
            if ((fp=fopen(*argv,"r"))==NULL)
                  fprintf(stderr,"Can't open %s\n",*argv);
               else
                  paginate(*argv);
            }
      }
   }
/*page*/
paginate(name)
char *name;
   {
   pagno=linno=curlin=0;
   getime(tbuf);
   header(name);
   while (fgets(buf,LMAX,fp)!=NULL)
      {
      ++linno;                              /* bump line count */
      ++curlin;
      if (strcmp("/*page*/\n",buf)==0)
         {
         curlin=PAGBOT;
         continue;
         }
      if (strcmp("/*noprint*/\n",buf)==0)
         {
         sflag=TRUE;
         continue;
         }
      if (strcmp("/*print*/\n",buf)==0)
         {
         sflag=FALSE;
         continue;
         }
      if (!sflag)
         {
         if (curlin >= PAGBOT)
               header(name);
         if (nflag)
               printf("%3d=",linno);
         printf("%s",buf);
         }
      }
   fclose(fp);
   putchar('\f');
   }
/*page*/
/*
** help - tell the operator how to use us
*/
help(ch)
char ch;
   {
   printf(" Unknown option: %c\n\n",ch);
   printf(" Usage: ppc [-n] file1 file2 .. filen\n");
   printf("    -n supresses line numbers\n");
   printf("    /*page*/ forces page\n");
   printf("    /*noprint*/ turns printing off\n");
   printf("    /*print*/   turns printing on\n");
   exit(0);
   }
/*
** header - print a page header with prog name, date,
**          time and page number.  Do and eject if
**          not at the top of the page.
*/
header(name)
char *name;
   {
   if (curlin)
         putchar('\f');
   curlin=0;
   printf("\n\n%-43s ",name);
   printf("%02d/%02d/%02d  %02d:%02d:%02d",
          tbuf[1], tbuf[2], tbuf[0],
          tbuf[3], tbuf[4], tbuf[5]);
   printf("       Page %3d\n\n",++pagno);
   }