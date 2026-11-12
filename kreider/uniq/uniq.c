#define VERSION "uniq.c -- OS9 Version 1.0 -- 07/01/84"
/*
**  uniq - report repeated lines in a file
**
**  Adapted for BDS C by Jeff Martin, from a program by the same
**  name written to run under the Unix (tm) operating system.
**
**  Converted to MW C by Carl Kreider and returned
**   to the public domain
**
**  From the manual page for the Unix command:
**
**    "Uniq reads the input file comparing adjacent lines.  In the
**    normal case, the second and succeeding copies  of repeated
**    lines  are removed; the remainder is written on the output
**    file.   Input and output should always  be different.  Note
**    that repeated  lines must be adjacent in order  to be found.
**    If the -u flag is used, just the lines that
**    are not repeated in the original file  are output.  The -d
**    option specifies that  one copy of just the repeated lines is
**    to be  written.  The normal mode output is the  union of the
**    -u and -d mode outputs.
**
**    "The -c option supersedes -u and -d and generates an output
**    report in default style but with each  line preceded by a
**    count  of the number of times it occurred.
**
**    "The n arguments specify skipping an initial portion of each
**    line in the comparison:
**
**    -n    The first n fields together with any blanks before
**      each are ignored.  A field is  defined  as a string of
**      non-space, non-tab characters  separated by tabs and
**      spaces from its neighbors.
**
**    ^n    The first n characters are ignored.  Fields are
**      skipped before characters."
**
*/
  
  
#include <stdio.h>
#include <ctype.h>
 
#define MAXLINE 160
 
int   fields;
int   letters;
int   linec;
int   debuger;
char  mode;
int   uniq;
char  b1[1000], b2[1000];

FILE *infile;
/*page*/
main(argc, argv)
int argc;
char *argv[];
   {
 
   fields = 0;
   letters = 0;
   linec = 0;
   uniq = 0;
   debuger = 0;
   mode = '\0';
   infile = stdin;

   while (argc > 1)
      {
      if (*argv[1] == '-')
            {
            if (isdigit(argv[1][1]))
                  fields = atoi(&argv[1][1]);
               else 
                   mode = tolower(argv[1][1]);
            argc--;
            argv++;
            continue;
            }
      if (*argv[1] == '^')
            {
            letters = atoi(&argv[1][1]);
            argc--;
            argv++;
            continue;
            }
      if (argc == 2)
            if ((infile = fopen(argv[1], "r")) == NULL)
                  {
                  printf("can't open infile %s\n", argv[1]);
                  exit (0);
                  }
      break;
      }
 
   if (mode == 'h')
         usage();
 
   if (gline(b1))
         exit (0);
   for(;;)
      {
      linec++;
      if (gline(b2))
            {
             pline(b1);
             exit (0);
             }
      if (!equal(b1, b2))
            {
            pline(b1);
            linec = 0;
            do {
               linec++;
               if (gline(b1))
                     {
                     pline(b2);
                     exit (0);
                     }
               } while (equal(b1, b2));
            pline(b2);
            linec = 0;
            }
      }
   }
 
usage()
   {
   puts("\nUsage: UNIQ [-u][-d][-c] [-n] [^n] input [>output]");
   puts("   -u ==> just output unrepeated lines");
   puts("   -d ==> output one copy of just repeated lines");
   puts("   (default) ==> union of -u and -d options");
   puts("   -c ==> prefix each output line with count of occurrences");
   puts("   -n ==> skip first n fields in comparison");
   puts("   ^n ==> ignore first n characters after skipped fields");
   exit (0);
    }
 

gline(buf)
char buf[];
   {
   if (fgets(buf, MAXLINE, infile) == NULL)
         {
         *buf = 0;
         return(1);
         }
   buf[strlen(buf)-1] = '\0';
   return(0);
   }

 
pline(buf)
char buf[];
   {
   switch(mode)
      {
      case 'u':
         if (uniq)
               {
               uniq = 0;
               return;
               }
         break;
 
      case 'd':
         if (uniq)
               break;
         return;
 
      case 'c':
         printd(linec);
         putchar(' ');
      }
   uniq = 0;
   puts(buf);
   }
 

equal(s1, s2)
char s1[], s2[];
   {
   char c;
 
   s1 = skip(s1);
   s2 = skip(s2);
   while ((c = *s1++) != 0)
      if (c != *s2++) 
            return(0);
   if (*s2 != 0)
         return(0);
   uniq++;
   return(1);
   }

 
skip(s)
char *s;
   {
   int nf, nl;
 
   nf = nl = 0;
   while (nf++ < fields)
      {
      while (*s == ' ' || *s == '\t')
         s++;
      while (!(*s == ' ' || *s == '\t' || *s == 0))
         s++;
      }
   while (nl++ < letters && *s != 0)
      s++;
   return(s);
   }


/*
**  printd
**   print 'n' as decimal
*/
printd(n) 
int n;

   {
   int   a;

   if (a = n / 10)                  /* call self till a = 0 (false) */
      printd(a);
   putchar((n % 10) + '0');
   }
