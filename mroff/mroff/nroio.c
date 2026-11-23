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
   register char  *f, *t;
   int   n;

   getstat(SS_OPT, pn, &oldstat);                  /* get port parms */

   f = (char *)&oldstat;                  /* copy the port options */
   t = (char *)&newstat;
   for (n = sizeof(newstat); n > 0; --n)
      *t++ = *f++;
   newstat.sg_backsp = 0;                     /* 0 = BSE, 1 = BSE-SP-BSE */
   newstat.sg_alf = 0;                       /* 0 = no auto line feed */
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
