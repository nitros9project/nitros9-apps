/*
**  man.c
**
**  This is a utility originally developed by Pete Lyall and grossly
**  hacked upon by me (Mark Griffith).
**
**  It assumes a lot, and has everything hardcoded into it, but you can
**  use it, or hack it to develop something better.
*/

#include <stdio.h>
#include <strings.h>

#define TRUE 1
#define FALSE 0

extern int optind, opterr;
extern char *optarg;

#define CLS     putc('\x0c',stderr);

main(argc,argv)
int argc;
char *argv[];
{
     int result, found, option, 
     helponly = FALSE, 
     manonly = FALSE, 
     nofilter = FALSE,
     clibonly = FALSE,
     ndxfound = FALSE;
     char pname[128], cmd[80], ndxbuff[80], *ndxptr;
     
     FILE *ndxfile;

     while((option = getopt(argc, argv, "mhcfk:?")) != EOF)
          switch(tolower(option))
          {
          case 'm':
               manonly = TRUE;
               helponly = FALSE;
               clibonly = FALSE;
               break;

          case 'h':
               helponly = TRUE;
               manonly = FALSE;
               clibonly = FALSE;
               break;

          case 'f':
               nofilter = TRUE;
               break;

          case 'c':
               clibonly = TRUE;
               manonly = FALSE;
               helponly = FALSE;
               break;

          case 'k':
               helpman(optarg);
               exit(0);

          case '?':
          default :
               usage();
          }

     if(optind == argc)
          usage();

     for(; optind < argc; optind++)
     {
          found = FALSE;

          strcat(strcpy(pname,"/dd/defs/"),argv[optind]);

         /* search the DEFS directory */

          if(access(pname,0) == 0)
          {
               found = TRUE;
               sprintf(cmd, "%s%s", nofilter ? "list " : "more ", pname);
               CLS
               result = system(cmd);
               exit(0);
          }

          if(!(manonly || clibonly))

          /* search the help directory */

          {
               strcat(strcpy(pname,"/dd/text/help/"),argv[optind]);
               if(access(pname,0) == 0)
               {
                    found = TRUE;
                    sprintf(cmd, "%s%s", nofilter ? "list " : "more ", pname);
                    CLS
                    result = system(cmd);
                    exit(0);
               }
          }

          if(!(helponly || clibonly))
          {

          /*
          ** search the docs directory
          **
          ** first look for straight text files with a .docs extension
          */

               strcat(strcat(strcpy(pname,"/dd/text/docs/"),argv[optind]), ".docs");
               if(access(pname,0) == 0)
               {
                    found = TRUE;
                    sprintf(cmd, "%s%s", nofilter ? "list " : "more ", pname);
                    CLS
                    result = system(cmd);
                    exit(0);
               }

          /*
          ** look for TEXTFORMTTER files with a .tdoc extension
          */

               strcat(strcat(strcpy(pname,"/dd/text/docs/"),argv[optind]), ".tdoc");
               if(access(pname,0) == 0)
               {
                    found = TRUE;
                    sprintf(cmd, "tsfmt %s%s", pname, nofilter ? "" : "! more");
                    CLS
                    result = system(cmd);
                    exit(0);
               }

          /*
          ** look for mroff formatted files with a .mdoc extension
          */

               strcat(strcat(strcpy(pname,"/dd/text/docs/"),argv[optind]), ".mdoc");
               if(access(pname,0) == 0)
               {
                    found = TRUE;
                    sprintf(cmd, "mroff %s%s", pname, nofilter ? "" : "! more");
                    CLS
                    result = system(cmd);
                    exit(0);
               }

          /*
          ** look for preformatted manual files with a .man extension
          */

               strcat(strcat(strcpy(pname,"/dd/text/man/"),argv[optind]), ".man");
               if(access(pname,0) == 0)
               {
                    found = TRUE;
                    sprintf(cmd, "%s%s", nofilter ? "list " : "more ", pname);
                    CLS
                    result = system(cmd);
                    exit(0);
               }

          /*
          ** look for mroff formatted manual files with a .mman extension
          */

               strcat(strcat(strcpy(pname,"/dd/text/man/"),argv[optind]), ".mman");
               if(access(pname,0) == 0)
               {
                    found = TRUE;
                    sprintf(cmd, "mroff %s%s", pname, nofilter ? "" : "! more");
                    CLS
                    result = system(cmd);
                    exit(0);
               }
          }
          if(!(manonly || helponly))
          {

          /*
          ** look for clib mroff files with a .man extension
          */

               strcat(strcat(strcpy(pname,"/dd/text/clib/man/"),argv[optind]), ".man");
               if(access(pname,0) == 0)
               {
                    found = TRUE;
                    sprintf(cmd, "%s%s", nofilter ? "list " : "more ", pname);

                    chdir("/dd/text/clib/man");     /* to find header file */

                    CLS
                    result = system(cmd);
                    exit(0);
               }

              /* couldn't find it - check the man page index */

             ndxfound = FALSE;

             if((ndxfile = fopen("/dd/text/clib/man/man.index", "r")) != NULL)
             {
                 while(fgets(ndxbuff,80,ndxfile) != NULL)
                 {
                     if(strnucmp(argv[optind], ndxbuff, strlen(argv[optind])) == 0)
                     {
                         ndxptr = index(ndxbuff,' ') + 1;
                         *rindex(ndxbuff,'\r') = '\0';
                         ndxfound = TRUE;
                         break;
                     }
                 }
                 fclose(ndxfile);
     
                 if(ndxfound)
                 {
                     strcat(strcpy(pname,"/dd/text/clib/man/"),ndxptr);
                     if(access(pname,0) == 0)
                     {
                         found = TRUE;
                         sprintf(cmd, "%s%s", nofilter ? "list " : "more ", pname);

                         CLS
                         result = system(cmd);
                         exit(0);
                     }
                }
           }
       }

       if(!found)
           printf("\nSorry - couldn't find any information on '%s'\n", argv[optind]);     
    }

}

usage()
{
     fprintf(stderr,"\nUsage: man -mhfk [keyword]  subject1 ... subjectN\n");
     fprintf(stderr,"\n       -m  manual pages (for programs) only \n");
     fprintf(stderr,"       -h  help files only\n");
     fprintf(stderr,"       -c  C library manual pages only\n");
     fprintf(stderr,"       -k  search for keyword 's'\n");
     fprintf(stderr,"       -f  no output filtering [e.g. 'more']\n");
     exit(0);
}
/*
** helpman - Search and Print clib help file for strings
*/

helpman(s)
char *s;
{
     char line[256];
     FILE *fp;

     printf("\nSearching for %s....\n\n", s);

     if ((fp = fopen("/dd/text/clib/man/man.help", "r")) == NULL)
        exit(errno);

     while (fgets(line, 256, fp) != NULL) {
        if ((findstr(1, line, s) > 0))
           printf("%s", line);
     }
     fclose(fp);
}
