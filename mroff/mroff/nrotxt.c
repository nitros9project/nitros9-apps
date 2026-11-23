/*
**      insert bold face text
**       called from text
*/

#include "nro.h"

/*
** write some blanks
*/
blanks(n)
register int   n;
   {
   while (n-- > 0)
      prchar(' ');
   }


/*
**      end current filled line
*/
brk()
   {
   if (outp > 0)
      {
      outbuf[outp] = EOS;                   /* write over last blank */
      put(outbuf);
      }
   outp = outw = outwds = 0;
   outbuf[0] = EOS;
   }


/*
** make bold by char,bs,char
*/
bold(p0, p1, size)
char  *p0, *p1;
int   size;
   {
   register char  *p = p1;
   char  *q = p0;
   char  c;

   while ((c = *q++) && ((p - p1) < size))
      {
      if (isalnum(c))
         {
         *p++ = c;                               /* copy the char .. */
         *p++ = '\b';                         /* copy the back space */
         }
      *p++ = c;                       /* copy the char once or again */
      }
   *p = EOS; 
   strcpy(p0, p1);                                   /* copy it back */
   }

/*page*/
/*
**      Expand escape sequences for "text" and "command"
*/
expesc(p, q)
char  *p, *q;
   {
   char  *s = p;
   register char  *t = q;
   char  c;

   while (c = *s++)
      {
      if (c != eschr)
         *t++ = c;                       /* nothing fancy, just copy */
      else
         {
         c = *s++;                              /* skip and get next */
         switch (c)
            {
            case 'n' :                   /* probably number register */
               t += getnr(&s, t);
               break;

            case '&' :
               *t++ = *s++ | 0x80;               /* make not command */
               break;

            case '"' :
               *--s = '\0';             /* kill the rest of the line */
               break;

            case '*' :
               t += getstr(&s, t);
               break;

            case ' ' :
               *t++ = c | 0x80;                /* mark as unpaddable */
               break;

            default  :
               *t++ = c;                      /* assume it was eschr */
               break;

            }
         }
      }
   *t = EOS;
   strcpy(p, q);
   }
/*page*/
/*
** expands title to include page number
**  no multi-width characters allowed
*/
expttl(s, n)
register char  **s;
int   n;
   {
   char  *save;
   char  *p;

   if ((p = index(*s, pgchr)) == 0)      /* first check for page num */
      strcpy(temp, *s);
   else
      {
      strncpy(temp, *s, p - *s);                  /* copy first part */
      temp[p - *s] = EOS;
      itoa(n, strend(temp));                      /* add page number */
      strcat(temp, ++p);                         /* then second part */
      *s = temp;                            /* and reset the pointer */
      }
   if (index(temp, eschr))
      if (save = malloc(MAXLINE + 1))
         {
         expesc(temp, save);
         free(save);
         }
   return (strlen(*s = temp));               /* now tell him how big */
   }


/*
** get a number register
*/
getnr(s, t)
char  **s, *t;
   {
   register char  *p = *s;
   int   rgndx, incr = 0;
   char  c;

   if ((c = *p) == '+')
      incr = 1;
   else
      if (c == '-')
         incr = -1;
   if (incr)
      ++p;
   if (isalpha(c = *p++))
      {
      *s = p;
      nr[rgndx = c - 'A'] += incr;
      return (strlen(itoa(nr[rgndx], t)));
      }
   return (0);
   }

/*page*/
/*
** get a three part title
*/
gettl(s, ttl1, ttl2, ttl3)
char  *s, **ttl1, **ttl2, **ttl3;
   {
   register char  *p1, *p2, *p3, *p4, c;

   p1 = *ttl1;
   s = skipbl(skipwd(s));                             /* eat command */
   c = *s++;                                   /* pick up lead delim */
   strncpy(p1, s, 132);             /* copy whole thing to title buf */
   if ((p4 = rindex(p1, c)) != NULL)
      *p4 = '\0';                             /* wipe terminal delim */
   if ((p3 = rindex(p1, c)) != NULL)
      *p3 = '\0';                               /* wipe ttl2/3 delim */
   if ((p2 = rindex(p1, c)) != NULL)
      *p2 = '\0';                               /* wipe ttl1/2 delim */
   if (!p2 || !p3 || !p4)              /* make sure all delims there */
      {
      error("gettl: delim error", p1,  0);
      *p1 = '\0';                                     /* kill string */
      *ttl3 = *ttl2 = p1;                 /* all parts point to null */
      }
   else
      {
      *ttl3 = p3 + 1;                      /* advance past delimiter */
      *ttl2 = p2 + 1;                      /* advance past delimiter */
      }
   }


/*
** get a string substitution
*/
getstr(s, t)
char  **s, *t;
   {
   register char  *p = *s;

   MACS  *temp;

   macname[0] = *p++;
   macname[1] = *p++;
   macname[2] = '\0';
   if (temp = getmac(macname, shead))
      {
      strcpy(t, temp->mdef);
      *s = p;
      return (strlen(temp->mdef));
      }
   return (0);
   }


/*page*/
/*
**      get non-blank word from p0 into p1.
**       return pointer updated past word
*/
getwrd(f, t)
char  *f, *t;
   {
   register char  *p;
   char  *q = t;
   char  c, c1;                   /* c1 saves first char of the word */

   sentence = 0;
   if ((c1 = *(p = skipbl(f))) == EOS)  /* look for trailing blanks */
      p = f;               /* nothing but blanks so set to return 0 */
   else
      {
      while (*p != ' ' && *p != EOS && *p != '\t')
         *q++ = *p++;
      if ((c = *(q - 1)) == '"')
            c = *(q - 2);
      if (c == '?' || c == '!' || (c == '.' && (*p == EOS || islower(c1))))
         {
         *q++ = ' ';
         sentence = TRUE;
         }
      }
   *q = EOS;
#ifdef DEBUG
   if (debug > 2)
         fprintf(stderr, "getwrd found <%s>\n", t);
#endif
   return (p - f);                        /* aka characters consumed */
   }


/*
**      delete leading blanks, set tival
**       only call text
*/
leadbl(p)
char  *p;
   {
   register char *q;

   brk();
   q = skipbl(p);
   if (*q != '\0')
      tival += (q - p);              /* tival only if not blank line */
   return (q);                                  /* new start of line */
   }
/*page*/
/*
**      put out page footer
*/
pfoot()
   {
   skip(m3val[0]);
   if (m4val[0] > 0)
      {
      if ((curpag & 1) == 0)
         puttl(efl, efc, efr, curpag);
      else
         puttl(ofl, ofc, ofr, curpag);
      skip(m4val[0] - 1);
      }
   }



/*
**      put out page header
*/
phead()
   {
   curpag = newpag;
   if (curpag >= frstpg && curpag <= lastpg)
      prflg = TRUE;
   else
      prflg = FALSE;
   ++newpag;
   if (m1val[0] > 0)
      {
      skip(m1val[0] - 1);
      if ((curpag & 1) == 0)
         puttl(ehl, ehc, ehr, curpag);
      else
         puttl(ohl, ohc, ohr, curpag);
      }
   skip(m2val[0]);
   lineno = m1val[0] + m2val[0] + 1;
   }
/*page*/
/*
**      put out line with proper spacing and indenting
*/
put(p)
char  *p;
   {
   char  *q;

   if (lineno == 0 || lineno > bottom)
      phead();

   if (!bsflg)
      {
      if (strkovr(p, rsbuf))
         {
         blanks(poval[0] + tival);
         *(q = strend(rsbuf)) = '\n';
         *++q = EOS;
         putlin(rsbuf);
         }
      }
   blanks(poval[0] + tival);
   putlin(p);
   scrlf();
   tival = inval[0];
   skip(min(lsval[0] - 1, bottom - lineno));
   lineno = lineno + lsval[0];
   if (lineno > bottom)
      pfoot();
   }


/*
**  routine to put out a three part title, which may include a
**   page number, but may not include overstrike or underline.
*/
puttl(s1, s2, s3, pgno)
char  *s1, *s2, *s3;                              /* the three parts */
int   pgno;                                       /* the page number */
   {
   int   l1, l2, l3, gap1, gap2;          /* sizes of parts and gaps */

   memset(ttlbuf, ' ', ltval[0]);          /* first clear the buffer */
   l1 = expttl(&s1, pgno);                   /* expand the left part */
   strncpy(ttlbuf, s1, l1);                     /* copy all but null */
   l2 = expttl(&s2, pgno);                 /* expand the middle part */
   strncpy(&ttlbuf[((ltval[0] - l2) >> 1)], s2, l2);  /* copy middle */
   l3 = expttl(&s3, pgno);                  /* expand the right part */
   strcpy(&ttlbuf[ltval[0] - l3], s3);   /* copy right part and null */
   blanks(poval[0]);                          /* put out page offset */
   putlin(ttlbuf);                           /* now the title itself */
   scrlf();                                    /* terminate the line */
   }
/*page*/
/*
**      put word in output buffer
*/
putwrd(wrdbuf)
char  *wrdbuf;
   {
   int   w;
   int   last;
   int   llval;
   char  *p0, *p1;
   int   nextra;

   w = width(wrdbuf);
   last = strlen(wrdbuf) + outp;                /* new end of outbuf */
   llval = rmval[0] - tival;
#ifdef DEBUG
   if (debug > 1)
      fprintf(stderr, "w=%d last=%d llval=%d outp=%d outw=%d\n",
               w, last, llval, outp, outw);
#endif
   if ((outp > 0) && (((outw + w) > llval) || (last > MAXLINE)))
      {
      last -= outp;                        /* remember end of wrdbuf */
      if (juval == YES)
         {
         nextra = llval - outw + 1;
         if (outbuf[outp - 2] == ' ')
            {
            --outp;
            ++nextra;
            }
         spread(outbuf, outp - 1, nextra, outwds);
         if ((nextra > 0) && (outwds > 1))
            outp += (nextra - 1);
         }
      brk();
      }
   p0 = wrdbuf;
   p1 = outbuf + outp;
   strcpy(p1, p0);
   outp = last;
   outbuf[outp++] = ' ';
   outw += (w + 1);
   ++outwds;
   }
/*page*/
/*
** special cr lf, place to add at traps
*/
scrlf()
   {
   prchar('\n');
   if (!bsflg)
      prchar('\l');
   }


/*
**      skips the number of lines specified by n.
*/
skip(n)
int   n;
   {
   int   i;

   for (i = 0; i < n; ++i)
      scrlf();
   }


/*
**      space vertically n lines
*/
space(n)
int   n;
   {
   brk();
   if (lineno <= bottom)
      {
      if (lineno == 0)
         phead();
      skip(min(n, bottom + 1 - lineno));
      lineno += n;
      if (lineno > bottom)
         pfoot();
      }
   }
/*page*/
/*
**      spread words to justify right margin
*/
spread(p, outp, nextra, outwds)
char  p[];
int   outp, nextra, outwds;
   {
   int   i, j;
   int   nb, ne, nholes;

   if ((nextra > 0) && (outwds > 1))
      {
      sprdir = ~sprdir;
      ne = nextra;
      nholes = outwds - 1;                    /* holes between words */
      i = outp - 1;                      /* last non-blank character */
      j = min(MAXLINE - 2, i + ne);       /* leave room for CR, EOS  */

      while ((i < j) && (i > 0))
         {
         p[j] = p[i];
         if (p[i] == ' ')
            {
            if (sprdir == 0)
               nb = (ne - 1)/nholes + 1;
            else
               nb = ne/nholes;
            ne -= nb;
            --nholes;

            for (; nb > 0; --nb)
               {
               --j;
               p[j] = ' ';
               }
            }
         --i;
         --j;
         }
      }
   }
/*page*/
/*
**      split overstrikes (backspaces) into seperate buffer
*/
strkovr(p, q)
char  *p, *q;
   {
   register char  *pp = p;
   int   worked;

   if (worked = index(p, '\b'))
      {
      while (*p)
         {
         *q = ' ';
         *pp = *p++;
         if (*p == '\b' && !iscntrl(*pp))
            {
            *q = *pp;
            ++p;
            *pp = *p++;
            }
         ++q;
         ++pp;
         }
      *q = *pp = EOS;
      }
   return (worked);
   }
/*page*/
/*
**      underline a line
**       underlines all if continuous or only alpha-numeric
**       expands input into temp and then replaces input with temp
*/
underl(p0, p1, size)
char  *p0, *p1;
int   size;
   {
   register char  *p = p1, *q = p0, c;

   while ((c = *q++) && ((p - p1) < size))
      {
      if (isalnum(c) || (isprint(c) && (cuval > 0)))   /* check char */
         {
         *p++ = '_';                           /* copy an underscore */
         *p++ = '\b';                             /* and a backspace */
         }
      *p++ = c;                                      /* now the char */
      }
   *p = EOS;                             /* terminate the new string */
   strcpy(p0, p1);                           /* replace old with new */
   }


/*
**      compute width of character string
**       counts trailing spaces too
*/
width(s)
register char  *s;
   {
   int   w = 0;

   while (*s != EOS)
      {
      if (*s == '\b')
         --w;
      else
         ++w;
      ++s;
      }
   return (w);
   }
