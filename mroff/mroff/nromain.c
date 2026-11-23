/*
**      Word Processor
**      similar to Unix NROFF or RSX-11M RNO -
**      adaptation of text processor given in
**      "Software Tools", Kernighan and Plauger.
*/

#define MAIN
#include "nro.h"
int   trap();

main(argc, argv)
int   argc;
char  *argv[];
   {
   int   i;
   char dev_name[32];
   char temp[32];

   intercept(trap);
   init();

   for (i = 1; i < argc; ++i)
      {
      if (*argv[i] == '-')
         pswitch(argv[i]);
      else
         {
         pushfp(argv[i]);
         while (flevel)
            {
            if (getlin(ibuf, fpstack[flevel - 1]) == 0)
               popfp();
            else
               {
               if (ibuf[0] == cmdchr)
                  comand(ibuf);
               else
                  text(ibuf);
               }
            }
         }
      }
   if (lineno > 0)
         space(HUGE);
   if (bsflg == 0)
         setcooked();
   }

/*page*/
/*
**      initialize parameters for mroff word processor
*/
init()
   {
   int   i;
   char  tbuf[6];

   fill = YES;
   lsval[0] = lsval[1] = 1;
   ltval[0] = ltval[1] = rmval[0] = rmval[1] = PAGEWIDTH;
   inval[0] = inval[1] = poval[0] = poval[1] = 0;
   ceval = ulval = cuval = boval = tival = 0;
   juval = YES;
   bsflg = TRUE;
   pgchr = '%';
   cmdchr = '.';
   eschr = '\\';
   prflg = TRUE;
   sprdir = 0;
   for (i = 0; i < 26; ++i)
      nr[i] = 0;
   curpag = 0;
   newpag = 1;
   lineno = 0;
   plval = PAGELEN;
   m1val[0] = m1val[1] = m2val[0] = m2val[1] = 2;
   m3val[0] = m3val[1] = m4val[0] = m4val[1] = 2;
   bottom = plval - m4val[0] - m3val[0];
   frstpg = 0;
   lastpg = 30000;
   ehead[0] = ohead[0] = '\0';
   efoot[0] = ofoot[0] = '\0';
   efl = efc = efr = efoot;
   ofl = ofc = ofr = ofoot;
   ehl = ehc = ehr = ehead;
   ohl = ohc = ohr = ohead;
   outw = outwds = outp = 0;
   ppb = NULL;
   mhead = shead = NULL;
   getime(tbuf);
   nr['Y' - 'A'] = tbuf[0];
   nr['M' - 'A'] = tbuf[1];
   nr['D' - 'A'] = tbuf[2];
   }
/*page*/
/*
**      process switch values from command line
*/
pswitch(p)
register char  *p;
   {
   int   n;

   ++p;                                                 /* skip '-' */
   while (*p)
      {
      switch (tolower(*p++))
         {
         case 'd':
            ++debug;
            break;

         case 'p':
            set(&poval[0], atoi(p), '1', 0, 0, HUGE);
            while (isdigit(*p++)); /* walk over digits - PWL */
            return(0); /* changed from break */

         case 'o':
            frstpg = atoi(p);
            while (isdigit(*p++))
               ;                       /* skip first number and '-' */
            lastpg = (((n = atoi(p)) > 0) ? n : 30000);
            return (0);           /* this is termial option so exit */

         case 'b':
            bsflg = FALSE;
            setraw();
            break;

         default:
            error("mroff: illegal switch", p, 0);
            error("Usage: mroff [-on-n] [-pxx] [-b] infile ... [>outfile]", 0, 0);
            exit (0);
         }
      }
   }
/*page*/
/*
**      Command processor for MROFF text processor
**
*/

comand(p)
register char  *p;
   {
   int   ct, val;
   int   spval;                                       /* space value */
   int   rgndx;
   char  argtyp, c, *s;

   ct = comtyp(p, macbuf);
   val = getval(p, &argtyp);

#ifdef DEBUG
   if (debug > 0)
      {
      fprintf(stderr, "command: comtyp=%d\n", ct);
      fprintf(stderr, "command: val=%d argtyp=<%c>\n", val, argtyp);
      }
#endif

   switch (ct)
      {
      case UNKNOWN:
         error("mroff: unrecognized command", p, 0);
         break;

      case IG:  /* ignore */
         break;

      case BO: /* bold face */
         set(&boval, val, argtyp, 1, 0, HUGE, NO);
         cuval = ulval = 0;
         break;

      case BR: /* break */
         brk();
         break;

      case BS: /* backspaces in output */
         set(&bsflg, val, argtyp, 1, 0, 1, NO);
         setraw();                                 /* fix up the I/O */
         break;

      case CC: /* command character */
         if (argtyp)
               val = argtyp;            /* if anything, use as value */
         set(&cmdchr, val, '0', '.', 33, 126, NO);
         break;

      case CE: /* center */
         brk();
         set(&ceval, val, argtyp, 1, 0, HUGE, NO);
         break;

      case CU: /* continuous underline */
         set(&cuval, val, argtyp, 1, 0, HUGE, NO);
         ulval = boval = 0;
         break;

      case DE:
      case DM: /* define macro */
         defmac(p, fpstack[flevel - 1]);
         break;

      case DS:   /* define a string */
         p = skipbl(skipwd(p));                       /* eat command */
         getwrd(p, macname);           /* copy the name of the string*/
         macname[2] = EOS;         /* truncate the name to two chars */
         if (!isalpha(macname[0]) || !isalpha(macname[1]))
            {
            error("mroff: illegal string definition", p, -1);
            break;                               /* exit on bad spec */
            }
         p = skipbl(skipwd(p));        /* eat the name of the string */
         if ((c = *p) == '"' || c == '\'')
            {
            if ((s = index(++p, c)) == NULL)      /* skip and search */
               *--p = '\0';
            else
               *s = '\0';
            }
         if (putmac(macname, p, &shead) == ERR)
            error("mroff: macro definition table full", 0, -1);
         break;

      case EC: /* escape character */
         if (argtyp)
            val = argtyp;               /* if anything, use as value */
         set(&eschr, val, '0', '\\', 33, 126, NO);
         break;

   
      case EF: /* even footer */
         gettl(p, &efl, &efc, &efr);
         break;

      case EH: /* even header */
         gettl(p, &ehl, &ehc, &ehr);
         break;

      case EN: /* end macro definition */
         error("mroff: missing .de command", 0, 0);
         break;

      case FI: /* fill */
         brk();
         fill = YES;
         break;

      case FO: /* footer */
         gettl(p, &efl, &efc, &efr);
         gettl(p, &ofl, &ofc, &ofr);
         break;

      case TL:
      case HE: /* header */
         gettl(p, &ehl, &ehc, &ehr);
         gettl(p, &ohl, &ohc, &ohr);
         break;

      case IN: /* indenting */
         brk();
         set(&inval[0], val, argtyp, 0, 0, rmval[0] - 1, YES);
         tival = inval[0];
         break;

      case JU: /* justify */
         juval = YES;
         break;

      case LS: /* line spacing */
         set(&lsval[0], val, argtyp, 1, 1, HUGE, YES);
         break;

      case LT:  /* set length of title */
         set(&ltval[0], val, argtyp, PAGEWIDTH, 1, HUGE, YES);
         break;

      case M1: /* set topmost margin */
         set(&m1val[0], val, argtyp, 2, 0, HUGE, YES);
         break;

      case M2: /* set second top margin */
         set(&m2val[0], val, argtyp, 2, 0, HUGE, YES);
         break;

      case M3: /* set first bottom margin */
         set(&m3val[0], val, argtyp, 2, 0, HUGE, YES);
         bottom = plval - m4val[0] - m3val[0];
         break;

      case M4: /* set bottom-most margin */
         set(&m4val[0], val, argtyp, 2, 0, HUGE, YES);
         bottom = plval - m4val[0] - m3val[0];
         break;

      case MACRO: /* macro expansion */
         maceval(p, macbuf);
         break;

      case NE: /* need n lines */
         if ((bottom - lineno + 1) < (val * lsval[0]))
            space(HUGE);
         break;

      case NF: /* no fill */
         brk();
         fill = NO;
         break;

      case NJ: /* no justify */
         juval = NO;
         break;

      case NR: /* set number register */
         p = skipbl(skipwd(p));
         if (!isalpha(*p))
            error("mroff: invalid number register name", p, 0);
         else
            {
            rgndx = *p - 'A';
            p = skipwd(p);
            val = getval(p, &argtyp);
            set(&nr[rgndx], val, argtyp, 0, -HUGE, HUGE, NO);
            }
         break;

      case OF: /* odd footer */
         gettl(p, &ofl, &ofc, &ofr);
         break;

      case OH: /* odd header */
         gettl(p, &ohl, &ohc, &ohr);
         break;

      case PC: /* page number character */
         if (argtyp)
            val = argtyp;               /* if anything, use as value */
         set(&pgchr, val, '0', '%', 33, 126, NO);
         break;

      case BP:
      case PG: /* begin page */
         if (lineno > 0)
            space(HUGE);
         set(&curpag, val, argtyp, curpag + 1, -HUGE, HUGE, NO);
         newpag = curpag;
         break;

      case PL: /* page length */
         set(&plval, val, argtyp, PAGELEN,
               m1val[0] + m2val[0] + m3val[0] + m4val[0] + 1, HUGE, NO);
         bottom = plval - m3val[0] - m4val[0];
         break;

      case PN: /* page number */
         set(&curpag, val, argtyp, curpag + 1, -HUGE, HUGE, NO);
         newpag = curpag;
         break;

      case PO: /* page offset */
         set(&poval[0], val, argtyp, 0, 0, HUGE, YES);
         break;

      case RM: /* right margin */
         set(&rmval[0], val, argtyp, PAGEWIDTH, tival + 1, HUGE, YES);
         break;

      case SO: /* source file */
         p = skipbl(skipwd(p));
         if (getwrd(p, wrdbuf) != 0)
            pushfp(wrdbuf);
         break;

      case SP: /* space */
         set(&spval, val, argtyp, 1, 0, HUGE, NO);
         space(spval);
         break;

      case TI: /* temporary indent */
         brk();
         set(&tival, val, argtyp, 0, 0, rmval[0], NO);
         break;

      case UL: /* underline */
         set(&ulval, val, argtyp, 1, 0, HUGE, NO);
         cuval = boval = 0;
         break;
      }
   }
/*page*/
/*
**      decodes mroff command and returns its associated
**      value.
*/
comtyp(p, m)
char  *p, *m;                    /* command line and place for macro */
   {
   char  c1, c2;
   MACS  *temp;

   getwrd(++p, wrdbuf);                              /* assume macro */
   wrdbuf[2] = EOS;                                      /* truncate */
   if ((temp = getmac(wrdbuf, mhead)) != NULL)
      {
      strcpy(m, temp->mdef);                          /* return in m */
      return (MACRO);
      }

   c1 = tolower(*p++);
   c2 = tolower(*p);
   if (c1 == '.' || c1 == '*') return (IG);
   if (c1 == 'b')
      {
      if (c2 == 'p') return (BP);
      if (c2 == 'o') return (BO);
      if (c2 == 'r') return (BR);
      if (c2 == 's') return (BS);
      }
   if (c1 == 'c')
      {
      if (c2 == 'c') return (CC);
      if (c2 == 'e') return (CE);
      if (c2 == 'u') return (CU);
      }
   if (c1 == 'd')
      {
      if (c2 == 'm') return (DM);
      if (c2 == 's') return (DS);
      if (c2 == 'e') return (DE);
      }
   if (c1 == 'e')
      {
      if (c2 == 'c') return (EC);
      if (c2 == 'f') return (EF);
      if (c2 == 'h') return (EH);
      if (c2 == 'n') return (EN);
      }
   if (c1 == 'f')
      {
      if (c2 == 'i') return (FI);
      if (c2 == 'o') return (FO);
      }
   if (c1 == 'h' && c2 == 'e') return (HE);
   if (c1 == 'i' && c2 == 'n') return (IN);
   if (c1 == 'j' && c2 == 'u') return (JU);
   if (c1 == 'l')
      {
      if (c2 == 't') return (LT);
      if (c2 == 's') return (LS);
      }
   if (c1 == 'm')
      {
      if (c2 == '1') return (M1);
      if (c2 == '2') return (M2);
      if (c2 == '3') return (M3);
      if (c2 == '4') return (M4);
      }
   if (c1 == 'n')
      {
      if (c2 == 'e') return (NE);
      if (c2 == 'f') return (NF);
      if (c2 == 'j') return (NJ);
      if (c2 == 'r') return (NR);
      }
   if (c1 == 'o')
      {
      if (c2 == 'f') return (OF);
      if (c2 == 'h') return (OH);
      }
   if (c1 == 'p')
      {
      if (c2 == 'c') return (PC);
      if (c2 == 'g') return (PG);
      if (c2 == 'l') return (PL);
      if (c2 == 'n') return (PN);
      if (c2 == 'o') return (PO);
      }
   if (c1 == 'r' && c2 == 'm') return (RM);
   if (c1 == 's')
      {
      if (c2 == 'o') return (SO);
      if (c2 == 'p') return (SP);
      }
   if (c1 == 't' && c2 == 'i') return (TI);
   if (c1 == 't' && c2 == 'l') return (TL);
   if (c1 == 'u' && c2 == 'l') return (UL);
   return (UNKNOWN);
   }
/*page*/
/*
**      retrieves optional argument following mroff command.
**      returns positive integer value with sign (if any)
**      saved in character addressed by p_argt.
*/
getval(p, p_argt)
char  *p, *p_argt;
   {
   p = skipbl(skipwd(p));
   *p_argt = *p;
   if ((*p == '+') || (*p == '-'))
      ++p;
   return (atoi(p));
   }


/*
**      set parameter and check range
*/
set(param, val, type, defval, minval, maxval, flag)
int   *param, val;
char  type;
int   defval, minval, maxval, flag;
   {
#ifdef DEBUG
   if (debug > 1)
      fprintf(stderr, "set: val=%d type=%d def=%d min=%d max=%d\n",
         val, type, defval, minval, maxval);
#endif
   if (flag == YES && type != 0)        /* stacked, but not default? */
      *(param + 1) = *param;                   /* push the old value */
   switch(type)
      {
      case '\0':
         if (flag == YES)            /* is this a stacked parameter? */
            {
            *param = *(param + 1);                  /* pop old value */
            *(param + 1) = defval;                  /* stack default */
            }
         else
            *param = defval;                     /* just use default */
         break;
      case '+':
         *param += val;
         break;
      case '-':
         *param -= val;
         break;
      default:
         *param = val;
         break;
      }
   *param = max(min(*param, maxval), minval);
#ifdef DEBUG
   if (debug > 1)
      fprintf(stderr, "final value is %d\n", *param);
#endif
   }


/*page*/
/*
**      Text processing portion of MROFF word processor
*/
text(p)
char  *p;
   {
   int   i;

   if (*p == ' ' || *p == '\0')
         p = leadbl(p);               /* force a break and set tival */
   if (ulval > 0)
      {
      underl(p, wrdbuf, MAXLINE);
      --ulval;
      }
   if (cuval > 0)
      {
      underl(p, wrdbuf, MAXLINE);
      --cuval;
      }
   if (boval > 0)
      {
      bold(p, wrdbuf, MAXLINE);
      --boval;
      }
   if (ceval > 0)
      {
      tival = max((rmval[0] + tival - width(p)) >> 1, 0);  /* center */
      put(p);
      --ceval;
      }
   else
      if (*p == '\0')
         put(p);                                   /* all blank line */
      else
         if (fill == NO)
            put(p);                                      /* unfilled */
         else
            while (i = getwrd(p, wrdbuf))
               {
               p += i;
               putwrd(wrdbuf);
               }
   }
/*page*/

/*
** error handler
*/
error(s1, s2, n)
char  *s1, *s2;
int   n;
   {
   fputs(s1, stderr);
   if (s2)
     {
     fputs(" <", stderr);
     fputs(s2, stderr);
     putc('>', stderr);
     }
   putc('\n', stderr);
   if (n)
         exit(n);
   }
