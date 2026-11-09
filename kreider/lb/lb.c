/*
** LIB
**  program to split the MW C library (clib.l) into rof modules
**   so that inclusions/changes can be made and the modules
**   merged together again.  To that end, a vertical file of
**   the names of the modules generated is written to disk to
**   be used, with an editor, to create the shell script to
**   create a new library.
**
**  copyright 1984 by Carl R. Kreider
**   released to the public domain for non-commercial use
*/
#include <stdio.h>
/* misc. constants */
#define ROFSYNC     0x62CD2387
#define SYMLEN      9                        /* Length of symbols */
#define MAXNAME     16                   /* length of module name */
/* temporaries */
char  modname[MAXNAME],                    /* module name storage */
      *mnp,                             /* pointer to module name */
      c,                                        /* useful storage */
      symname[SYMLEN+2],                   /* symbol temp storage */
      *snp;                                  /* pointer to symbol */
int   count,
      refcnt;
/*  universal 3 byte ref struct  */
struct refblk {
      char r_flag;                               /* type/location */
      unsigned r_offset;
      } ref;
/* rof header structure */
struct mhed {
      long h_synch;
      char h_typlan;
      char h_attrev;
      char h_valid;
      char h_date[5];
      char h_edit;
      char h_spare;
      unsigned h_glbl;
      unsigned h_dglbl;
      unsigned h_data;
      unsigned h_ddata;
      unsigned h_ocode;
      unsigned h_stack;
      unsigned h_entry;
      } rofhed, *rhp;                         /* struct & pointer */
FILE  *ifp,                                            /* in file */
      *ofp,                                           /* out file */
      *lfp;                                       /* listing file */
/*page*/
main(argc,argv)
int argc;
char **argv;
   {
   char   fmodname[250];
   rhp = &rofhed;
   if (argc != 2)
         {
         fprintf(stderr,"syntax: %s infile\n",argv[0]);
         fprintf(stderr,"   splits infile into ROF modules\n");
         exit (0);
         }
   if ((ifp = fopen(*++argv,"r")) == NULL)
         oerror(*argv);
   if ((lfp = fopen("modlist","w")) == NULL)
         oerror("modlist");
   while (TRUE)
      {
      if (fread(rhp,sizeof(rofhed),1,ifp) == NULL)  /* get header */
            break;                              /* go check error */
      if (rhp->h_synch != ROFSYNC)          /* check for ROF file */
            error(*argv," is not ROF");
      mnp = modname;
      while (*mnp++ = getc(ifp))         /* copy mod name to temp */
            ;                                       /* copies nul */
      --mnp;                                 /* backup pointer up */
      strcpy(fmodname,"X.");
      strcat(fmodname,modname);
      strcat(fmodname,".r");
      if ((ofp = fopen(fmodname,"w")) == NULL)   /* open "modname" */
            oerror(modname);
      if (fwrite(rhp,sizeof(rofhed),1,ofp) == NULL) /* write header */
            werror(modname);
      fputs(modname,ofp);              /* copy modname to outfile */
      putc('\0',ofp);
      *mnp++ = '\n';                         /* print termination */
      *mnp = '\0';
      fputs(modname,lfp);                   /* write to list file */
      putglb(*argv);              /* write the global defs & refs */
      putcode(*argv);                    /* write the code & data */
      putref(*argv);                       /* write external refs */
      putloc(*argv);                          /* write local refs */
      fclose(ofp);
      }
   if (!feof(ifp))
         error(*argv);
   fclose(ifp);
   fclose(lfp);
   }
/*page*/
/* copy the globals to the new file & record in list file */
putglb(s)
char  *s;
   {
   count = getw(ifp);                          /* read glob count */
   putw(count,ofp);                           /* write glob count */
   while (count--)
      {
      snp = symname;
      while (*snp++ = getc(ifp))             /* get a symbol name */
            ;                           /* this while copies null */
      --snp;
      fputs(symname,ofp);
      putc('\0',ofp);
      *snp++ = '\n';
      *snp = '\0';
      fputs("        ",lfp);
      fputs(symname,lfp);
      if (fread(&ref,sizeof(ref),1,ifp) == NULL)
            rerror(s);
      if (fwrite(&ref,sizeof(ref),1,ofp) == NULL)
            werror(modname);
      }
   }
/* copy external references to new file */
putref(s)
char  *s;
   {
   count = getw(ifp);                          /* read glob count */
   putw(count,ofp);                           /* write glob count */
   while (count--)
      {
      snp = symname;
      while (*snp++ = getc(ifp))             /* get a symbol name */
            ;                           /* this while copies null */
      --snp;
      fputs(symname,ofp);
      putc('\0',ofp);
      refcnt = getw(ifp);
      putw(refcnt,ofp);
      while (refcnt--)
         {
         if (fread(&ref,sizeof(ref),1,ifp) == NULL)
               rerror(s);
         if (fwrite(&ref,sizeof(ref),1,ofp) == NULL)
               werror(modname);
         }
      }
   }
/*page*/
/*  copy code & data to new file */
putcode(s)
char  *s;
   {
   count = rhp->h_ocode + rhp->h_ddata + rhp->h_data;
   while (count--)
      putc(getc(ifp),ofp);                       /* slow but easy */
   }
/*  copy local ref info to new file */
putloc(s)
char  *s;
   {
   count = getw(ifp);                           /* get local refs */
   putw(count,ofp);                                /* to new file */
   while (count--)
      {
      if (fread(&ref,sizeof(ref),1,ifp) == NULL)    /* copy a ref */
            rerror(s);
      if (fwrite(&ref,sizeof(ref),1,ofp) == NULL)
            werror(,modname);
      }
   }
werror(s)
char  *s;
   {
   error("Write error on ",s);
   }
rerror(s)
char  *s;
   {
   error("Read error on ",s);
   }
oerror(s)
char  *s;
   {
   error("Can't open ",s);
   }
error(s1,s2)
char  *s1,  *s2;
   {
   fputs(s1,stdout);
   puts(s2);
   exit ();
   }