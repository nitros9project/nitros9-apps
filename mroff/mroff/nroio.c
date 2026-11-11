/*
**  I/O routines
**   primatives for roff, higher level than C
*/

#include "nro.h"

/*
**      retrieve one line of input text
*/
getlin(p, ifp)
char  *p;
FILE *ifp;
   {
   int   c;
   register char  *q = p;

   while ((*q++ = c = ngetc(ifp)) != EOF && c != '\n' && (q - p) < MAXLINE)
      ;
   *--q = '\0';
#ifdef DEBUG
   if (debug > 2)
      fprintf(stderr, "getline found: <%s>\n", p);
#endif
   if (index(p, eschr))
      expesc(p, temp);
   return (c != EOF);                          /* true except at eof */
   }


/*
**      get character from input file or push back buffer
*/
ngetc(ifp)
FILE *ifp;
   {
   int   c;

   if (ppb >= &pbb[0])
      c = *ppb--;
   else
      c = getc(ifp);
   return (c);
   }

/*page*/
/*
** routine to stack an fp and open a new file
**  flevel points to next slot in stack
*/
pushfp(name)
char  *name;
   {
   if (flevel == NFILES)
      error("mroff: .so files nested too deep", name, 0);
   else
      {
      if ((fpstack[flevel++] = fopen(name, "r")) == NULL)
         {
         error("mroff: pushfp can't open", name, 0);
         --flevel;
         return (ERR);
         }
      else
         return (OK);
      }
   }


/*
**  routine to unstack an fp
**   leaves pointer pointing to empty slot
*/
popfp()
   {
   if (flevel == 0)
      error("mroff: .so stack empty", 0, 0);
   else
      fclose(fpstack[--flevel]);
   }
/*page*/
/*
** push a string back onto the input
*/
pbstr(p)
char  p[];
   {
   int   i;

   for (i = strlen(p) - 1; i >= 0; --i)
      putbak(p[i]);
   }


/*
**      Push character back into input stream
*/
putbak(c)
char  c;
   {
   if (ppb < &pbb[0])
      {
      ppb = &pbb[0];
      *ppb = c;
      }
   else
      {
      if (ppb >= &pbb[MAXLINE - 1])
         error("mroff: push back buffer overflow", 0, -1);
      *++ppb = c;
      }
   }


/*
**      output a null terminated string
*/
putlin(p)
char  *p;
   {
   while (*p != EOS)
      prchar(*p++);
   }


/*
** putchar with test for printing
*/
prchar(c)
char  c;
   {
   if (prflg)
      putchar(c & 0x7f);
   }

/*page*/
/*
** f i x p a t h
**  initialize a new descriptor
**   delete any lines not necessary to copy to new
*/


fixpath(pn)
int   pn;
   {
   getstat(SS_OPT, pn, &oldstat);                  /* get port parms */

   memset(&newstat, 0,sizeof(newstat));  /* PWL - zero out new descriptor */

   /* now copy over necessary bytes */
   newstat.sg_class = oldstat.sg_class;   /* dev class, 0=scf, 1=rbf */
   newstat.sg_case= oldstat.sg_case;     /* 0 = both, 1 = upper only */
   newstat.sg_delete = oldstat.sg_delete;         /* delete sequence */
   newstat.sg_echo = oldstat.sg_echo;                 /* 0 = no echo */
   newstat.sg_nulls = oldstat.sg_nulls;    /* end of line null count */
   newstat.sg_pause = oldstat.sg_pause;  /* 0 = no end of page pause */
   newstat.sg_page = oldstat.sg_page;              /* lines per page */
   newstat.sg_bspch = oldstat.sg_bspch;       /* backspace character */
   newstat.sg_dlnch = oldstat.sg_dlnch;     /* delete line character */
   newstat.sg_eorch = oldstat.sg_eorch;   /* end of record character */
   newstat.sg_eofch = oldstat.sg_eofch;     /* end of file character */
   newstat.sg_rlnch = oldstat.sg_rlnch;    /* reprint line character */
   newstat.sg_dulnch = oldstat.sg_dulnch;/* duplicate last line char */
   newstat.sg_psch = oldstat.sg_psch;             /* pause character */
   newstat.sg_kbich = oldstat.sg_kbich;    /* keyboard int character */
   newstat.sg_kbach = oldstat.sg_kbach;       /* keyboard abort char */
   newstat.sg_bsech = oldstat.sg_bsech;       /* backspace echo char */
   newstat.sg_bellch = oldstat.sg_bellch;    /* overflow char (bell) */
   newstat.sg_parity = oldstat.sg_parity;    /* device init (parity) */
   newstat.sg_baud = oldstat.sg_baud;                   /* baud rate */
   newstat.sg_d2p = oldstat.sg_d2p;    /* offset to second dev name  */
   newstat.sg_xon = oldstat.sg_xon;               /* xmit start char */
   newstat.sg_xoff = oldstat.sg_xoff;              /* xmit stop char */
   newstat.sg_err = oldstat.sg_err;      /* most recent error status */
   newstat.sg_tbl = oldstat.sg_tbl; /* pointer to user avail dev tbl */
   }


setraw()
   {
   fixpath(1);
   setstat(SS_OPT, 1, &newstat);
   }


setcooked()
   {
   setstat(SS_OPT, 1, &oldstat);
   }


trap(sig)
int   sig;
   {
   if (bsflg == 0)
      setcooked();
   exit (sig);
   }
