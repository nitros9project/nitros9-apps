/*
** macro support stuff
*/

#include "nro.h"

/*
**      Define a macro
*/
defmac(p, ifp)
char  *p;
FILE  *ifp;
   {
   char  *q;

   p = skipbl(skipwd(p));
   getwrd(p, macname);
   if (!isalpha(*macname) || !isalpha(*(macname + 1)))
         error("mroff: illegal macro definition name", macname, -1);
   macname[2] = EOS;                   /* truncate to two characters */
   *(q = macdef) = '\0';
   while (getlin(p, ifp) != EOF)
      {
      if (p[0] == cmdchr && ((p[1] == cmdchr) ||
         (tolower(p[1]) == 'e' && tolower(p[2]) == 'n') ||
         (tolower(p[1]) == 'e' && tolower(p[2]) == 'm')))
            break;
      if ((q - macdef + strlen(p)) > MXMLEN)
         error("mroff: macro definition too long", 0, -1);
      else
         {
         strcat(q, p);                             /* copy next line */
         strcat(q, "\n");                         /* add back return */
         q = strend(q);                            /* update pointer */
         }
      }

   if (putmac(macname, macdef, &mhead) == ERR)
         error("mroff: macro definition table full", 0, -1);
   }


/*
**      Get macro definition from table
*/
MACS  *getmac(name, list)
char  *name;
MACS  *list;
   {
   while (list)
      {
      if (!strcmp(list->mname, name))
         return (list);                                  /* found it */
      list = list->mlink;
      }
   return (NULL);                                /* couldn't find it */
   }
/*page*/
/*
**      Evaluate macro expansion
**       called by comand for type MACRO
*/
maceval(p, m)
register char  *p;
char  m[];
   {
   int   i, j;
   char  *argp[10];
   char  c;

   *p = EOS;                       /* replace command char  with EOS */

   for (i = 0; i < 10; ++i)
      argp[i] = p;                         /* init arg array to null */

   p = skipwd(++p);                                   /* eat command */

   for (i = 0; i < 10; ++i)                        /* now parse args */
      {
      p = skipbl(p);                             /* skip white space */
      if (*p == EOS)
         break;
      if (*p == '"')                      /* check for quoted string */
         {
         argp[i] = ++p;                              /* save pointer */
         while (*p != '"' && *p != EOS)        /* and search for end */
            ++p;
         }
      else
         {
         argp[i] = p;         /* nothing special, just stack arg pnt */
         p = skipwd(p);                          /* and skip the arg */
         }
      if (*p)                                   /* still more to do? */
         *p++ = '\0';                  /* now terminate the argument */
      }

   for (i = strlen(m) - 1; i >= 0; --i)     /* put macro & args back */
      {
      if (i > 0 && m[i - 1] != '$')
         putbak(m[i]);
      else
         {
         if (!isdigit(m[i]))
            putbak(m[i]);
         else
            {
            pbstr(argp[m[i] - '0']);
            --i;                                  /* skip lead slash */
            }
         }
      }
   }
/*page*/
/*
**      Put macro definition into table
*/
putmac(name, p, listp)
char  *name, *p;
MACS  **listp;
   {
   MACS  *temp;

   if (temp = getmac(name, *listp))
      free(temp->mdef);
   else
      {
      if ((temp = malloc(sizeof(MACS))) == NULL)
            return (ERR);
      strcpy(temp->mname, name);
      temp->mlink = listp->mlink;        /* copy head to new element */
      *listp = temp;                        /* make new element head */
      }
   if ((temp->mdef = malloc(strlen(p + 1))) == NULL)
      return (ERR);
   strcpy(temp->mdef, p);
   return (OK);
   }

