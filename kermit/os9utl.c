/* os9utl.c */
/* Packet handling and misc. routines for OS-9 Kermit */

#include "os9inc.h"

#define SIGYOBRO 24

/* KERMIT utilities. */
static int datardy=0;

/* s p a c k
 *
 *  Send a Packet */

spack(type, num, len, data)
char type;
int num, len;
char *data;
{ int i;                                          /* Character loop counter */
  unsigned chksum;                                              /* Checksum */
  char buffer[100];                                        /* Packet Buffer */
  register char *bufp;                                    /* Buffer pointer */

  if (type != 'Y' && type != 'N')
    flushinput();                                     /* dump any leftovers */
  len &= 0x7f;                                /* Make sure len is not > 127 */
  if (len > MAXPACKSIZ)                 /* Make sure not larger than buffer */
    len = MAXPACKSIZ - 4;                                 /* IF so limit it */

  if (debug > 1)                                 /* Display outgoing packet */
  { if (data != NULL)
      data[len] = '\0';                  /* Null-terminate data to print it */
    printf("  spack type: %c\n", type);
    printf("     num:  %d\n", num);
    printf("     len:  %d\n", len);
    if (data != NULL)
      printf("    data: \"%s\"\n", data);
  }

  bufp = buffer;                                   /* Set up buffer pointer */
  for (i = 0; i < pad; i++)
    write(ttyfd, &padchar, 1);                         /* Issue any padding */

  *bufp++ = SOH;                            /* Packet marker, ASCII 1 (SOH) */
  chksum = *bufp++ = tochar(len + bctu + 2);     /* Initialize the checksum */
  chksum += (*bufp++ = tochar(num));                     /* Update checksum */
  chksum += (*bufp++ = type);                            /* Update checksum */

  for (i = len; --i >= 0; )
    chksum += (*bufp++ = *data++);                       /* Get a character */

  /* Compute final checksum */
  if (bctu == 1)
  { chksum = (((chksum & 0300) >> 6) + chksum)&077;
    *bufp++ = tochar(chksum);                       /* Put it in the packet */
  }
  else
  { *bufp++ = tochar((chksum >> 6) & 077);
    *bufp++ = tochar(chksum & 077);
  }

  *bufp++ = eol;                            /* Extra-packet line terminator */
  write(ttyfd, buffer, bufp - buffer);                   /* Send the packet */
}

static jmp_buf ttyenv;

catcher(signal)
register int signal;
{ if (signal == SIGYOBRO)
  { datardy = 1;
    longjmp(ttyenv);
  }

  exit(signal);
}

/* Check keyboard for input */
tstkbd()
{ register int echo_save = 0;
  char c;

  while (_gs_rdy(0) >= 0)
  { if (!echo_save)
    { _gs_opt(0, &insave);
      echo_save = insave.sg_echo;
      insave.sg_echo = 0;
      _ss_opt(0, &insave);
    }

    read(0, &c, 1);

    switch(c)
    { case STOPALL:
        cx = cz = TRUE;
        printmsg("User aborted entire transfer");
        break;
      case STOPCUR:
        cx = TRUE;
        printmsg("User aborted current file");
        break;
    }
  }

  if (echo_save)
  { insave.sg_echo = echo_save;
    _ss_opt(0, &insave);
  }
}

/* t t y i n
 *
 * Read from ttyfd (buffered)
 *
 * added to take advantage of the revised getstat(1, pathno)
 * by jej, 02/25/86 */

char rbuf[256];
char *rtop = rbuf;
char *rcursor = rbuf;

static int imask;

#define ttyin() (((rcursor < rtop) ? *rcursor++ : ttyrefill())&imask)

char ttyrefill()
{ register int qty;

  if ((qty = _gs_rdy(ttyfd)) < 0)
  { datardy = 0;
    if (setjmp(ttyenv) == 0)
    { if (_ss_ssig(ttyfd, SIGYOBRO) != (-1))
        if (!datardy)
        { if (sleep(timint) == 0)
          { _ss_rel(ttyfd);
            longjmp(env);
          }
        }
    }

    if ((qty = _gs_rdy(ttyfd)) < 0)
    { error("can't stat");
      longjmp(env);
    }
  }

  if ((qty = read(ttyfd, rbuf, qty)) < 0)
  { error("read error");
    longjmp(env);
  }
  rcursor = rbuf;
  rtop = rcursor + qty;
  return (*rcursor++);
}

/* r p a c k
 *
 *  Read a Packet */

char rpack(savelen, num, data)
int *savelen, *num;                                /* Packet length, number */
char *data;                                                  /* Packet data */
{ char t;                                        /* Current input character */
  register char *dscan;                              /* packet data scanner */
  register int len;                                /* Data character number */
  register char type;                                        /* Packet type */
  unsigned cchksum,                              /* Our (computed) checksum */
    rchksum;                           /* Checksum received from other host */

  imask = image ? 0377 : 0177;

  if (setjmp(env))
  { if (debug)
      printf("packet read timeout\n");
    else
      if (local)
        putc('T', stderr);
    return (FALSE);                                      /* fail on timeout */
  }

  while ((ttyin()&0177) != SOH)
    ;                                             /* Wait for packet header */

  cchksum = t = ttyin();                              /* Start the checksum */
  *savelen = len = unchar(t) - bctu - 2;                 /* Character count */

  cchksum += (t = ttyin());                              /* Update checksum */
  *num = unchar(t);                                        /* Packet number */

  cchksum += (t = ttyin());                              /* Update checksum */
  type = t;                                                  /* Packet type */

  for (dscan = data; len > 0; len--)
    cchksum += (*dscan++ = (t = ttyin()));               /* Update checksum */

  t = ttyin()&0177;                     /* don't use parity bit of checksum */

  *dscan = 0;                                   /* Mark the end of the data */
  rchksum = unchar(t);                                /* Convert to numeric */
  if (bctu == 2)
    rchksum = (rchksum << 6) | unchar(t = ttyin()); 

  if (debug > 1)                                 /* Display incoming packet */
  { printf("  rpack type: %c\n", type);
    printf("     num:  %d\n", *num);
    printf("     len:  %d\n", *savelen);
    printf("    bctu:  %d, %x\n", bctu, cchksum&07777);
    if (data != NULL)
      printf("    data: \"%s\"\n", data);
  }

  if (bctu == 1)
    /* Fold in bits 7, 8 to compute final checksum */
    cchksum = (((cchksum & 0300) >> 6) + cchksum)&077;
  else
    cchksum &= 07777;

  if (cchksum != rchksum)
  { if (debug > 1)
      printf("Rx Checksum Error was %02x sb %02x\n", rchksum, cchksum);
    else if (local)
       putc('%', stderr);
    return (FALSE);
  }

  if (local)
    tstkbd();                        /* Check for File interruptions/aborts */

  return (type);                              /* All OK, return packet type */
}

/* b u f i l l
 *
 *  Get a bufferful of data from the file that's being sent.
 *  Control-quoting, eighth-bit quoting, and run length coding are done. */

/* static */ DIRECT char *bscan;

bufill(buffer)
char buffer[];                                                    /* Buffer */
{ register char *bold, *blimit;
  register int c1;
  static int count = 0;
  static int c;
  static char leftover[6];

  bscan = buffer;
  blimit = buffer + spsiz - 8;

  /* copy leftovers into buffer... */
  bold = leftover;
  while (*bscan++ = *bold++)
    ;
  bscan--;

  do
  { bold = bscan;
    if (count == 0)
    {                       /* prime the pump with a run of identical bytes */
      if ((c = xgetc()) == EOF)
        break;
      do
      { count++;
      } while ((c1 = xgetc()) == c);
      xungetc(c1);
    }
    count -= encode(count, c);
  } while (bscan < blimit);

  strcpy(leftover, bold);
  *(bscan = bold) = '\0';

  return ((bscan == buffer) ? EOF : bscan - buffer);
}

/* x g e t c
 *
 * An unfortunately necessary layer around getc(), needed now that we're
 * doing run-length coding to hide CR -> CRLF from bufill(). */

static DIRECT int sawcr = FALSE;

int xgetc()
{ register int result;

  if (image)
    return getc(fp);

  if (sawcr)
  { sawcr = FALSE;
    return '\l';
  }

  if ((result = getc(fp)) == '\n')
    sawcr = TRUE;
  return result;
}

/* x u n g e t c
 *
 * a layer around ungetc() analogous to xgetc() -- see xgetc() above for
 * discussion. */

xungetc(c)
register int c;
{ if (image)
    ungetc(c, fp);
  else if (c == '\l')
    sawcr = TRUE;
  else
  { sawcr = FALSE;
    ungetc(c, fp);
  }
}

/* e n c o d e
 *
 * appends encoded characters to a buffer, as pointed at by bscan
 * (note--we terminate the buffer with '\0' to make life easier for bufill())
 * We return the number of characters we actually managed to put out the
 * code for. */

int encode(count, c)
int count, c;
{ register int c7, qty;

  if (!rptflg || count < 3)
    qty = 1;
  else
  { qty = (count > 94) ? 94 : count;
    *bscan++ = rptq;
    *bscan++ = tochar(qty);
  }

  c7 = c & 0177;
  if (bit8flag && c != c7)
  { *bscan++ = quote8;
    c = c7;
  }

  if (c7 < SP || c7 == DEL)
  { c = ctl(c);
    *bscan++ = quote;
  }
  else
    if (c7 == quote || (rptflg && c7 == rptq) || (bit8flag && c7 == quote8))
      *bscan++ = quote;

  *bscan++ = c;
  *bscan = '\0';

  return qty;
}

/* b u f e m p
 *
 *  Put data from an incoming packet into a file. */

bufemp(buffer, len)
register char *buffer;                                            /* Buffer */
int len;                                                          /* Length */
{ register char *blimit;
  register char t, t7, bit8;
  register int count;

  for (blimit = buffer + len; buffer < blimit; )
  { t = *buffer++;

    if (rptflg && t == MYREPEAT)
    { count = unchar(*buffer++);
      t = *buffer++;
    }
    else
      count = 1;

    if (bit8flag && t == MY8QUOTE)
    { t = *buffer++;
      bit8 = '\200';
    }
    else
      bit8 = '\0';

    if (t == MYQUOTE)
    { t = *buffer++;                            /* Get the quoted character */
      t7 = t & 0177;                        /* and its low-order seven bits */
      if (t7 > 62 && t7 < 96)
        t = ctl(t);                       /* really needs controllification */
    }

    t |= bit8;

    if (t != '\l' || image)
    { while (--count >= 0)
        putc(t, fp);
    }
  }
  return(!ferror(fp));
}

/* g n x t f l
 *
 *  Get next file in a file group */

gnxtfl()
{ if (server || cz)
    return (cz = FALSE);                       /* If server no multi send   */
  if (debug)
    printf("     gnxtfl: filelist = \"%s\"\n", *filelist);
  filnam = *(filelist++);
  return (filecount-- > 0);
}

/* s p a r
 *
 *  Fill the data array with my send-init parameters */

spar(data)
register char data[];
{ data[0] = tochar(MAXPACKSIZ);             /* Biggest packet I can receive */
  data[1] = tochar(MYTIME);                  /* When I want to be timed out */
  data[2] = tochar(MYPAD);                       /* How much padding I need */
  data[3] = ctl(MYPCHAR);                       /* Padding character I want */
  data[4] = tochar(MYEOL);                  /* End-Of-Line character I want */
  data[5] = MYQUOTE;                      /* Control-Quote character I send */

  switch (bit8status)
  { case UNKNOWN :
    case WILLING :
      /* If user asked for 8th-bit quoting, tell them what we want;
       * otherwise, be agreeable. */
      data[6] = bit8flag ? MY8QUOTE : 'Y';
      break;
    case REFUSED :
      /* they don't want 8th-bit quoting!
       * bit8flag has already been turned off, so nothing to do but... */
      data[6] = 'N';
      break;
    case REQUESTED :
      /* they do want 8th-bit quoting...go along with it. */
      bit8flag = TRUE;
      data[6] = 'Y';
      break;
  }

  data[7] = bctr + '0';                                /* Checksum I can do */
  data[8] = rptflg ? rptq : MYREPEAT;            /* Repeat-coding character */
}

/*  r p a r
 *
 *  Get the other host's send-init parameters */

rpar(len, data)
register int len;
char data[];
{ spsiz = unchar(data[0]);                      /* Maximum send packet size */
  timint = unchar(data[1]);                       /* When I should time out */
  if (timint < MINTIM)                       /* (make sure it's plausible!) */
    timint = MINTIM;
  else
    if (timint > MAXTIM)
      timint = MAXTIM;

  pad = unchar(data[2]);                          /* Number of pads to send */
  padchar = ctl(data[3]);                      /* Padding character to send */
  eol = unchar(data[4]);                       /* EOL character I must send */
  quote = data[5];                         /* Incoming data quote character */
  if (len < 7)
  {                                  /* does other side want 8th-bit quote? */
    bit8status = REFUSED;
    bit8flag = FALSE;
  }
  else if ((quote8 = data[6]) == 'Y')
     bit8status = WILLING;
  else if ((quote8 > 32 && quote8 < 63) || (quote8 > 95 && quote8 < 127))
     bit8status = REQUESTED;
  else
  { bit8status = REFUSED;
     bit8flag = FALSE;
  }

  bctr = 1;
  if (len >= 8)
  { bctr = data[7] - '0';
    if ((bctr < 1) || (bctr > 2))
      bctr = 1;
  }

  if (len < 9)                        /* does other side want repeat-count? */
    rptflg = FALSE;
  else
  { rptq = data[8];
    rptflg = ((rptq > 32 && rptq < 63) || (rptq > 95 && rptq < 127));
  }
}

/* f l u s h i n p u t
 *
 *  Dump all pending input to clear stacked up NACK's. */
flushinput()
{ register int qty;

  if ((qty = _gs_rdy(ttyfd)) > 0)
    read(ttyfd, rbuf, qty);
  rcursor = rtop = rbuf;
}

/* Kermit printing routines:
 *
 *  usage    - print command line options showing proper syntax
 *  printmsg -   like printf with "Kermit: " prepended
 *  error    - like printmsg if local kermit; sends a error packet if remote
 *  prerrpkt - print contents of error packet received from remote host */

/* u s a g e
 *
 *  Print summary of usage info and quit */

char *utab[] =
{ "Usage: kermit [-opt{flags} [line esc.char]]\n", "\n", 
    "    -s file(s)   send (use '-s -' to send from stdin)\n", 
    "    -r           receive\n",
    "    -k           receive to stdout\n", 
    "    -g file(s)   get remote file(s) from server\n", 
    "    -x           enter server mode\n", 
    "    -f           finish remote server\n",
    " flags--\n", 
    "     l           set communication line\n", 
    "     e           set the escape character\n", 
    "     i           binary file or OS-9 to OS-9\n", 
    "     d           increase debug level\n", 
    "     X           disable xon/xoff\n", 
    "     F           No filename conversions\n", 
    "     1,2         block check type\n",
    "     8           Toggle 8-bit data\n", NULL
};

usage()
{ printf("OS-9 Kermit Version %d Release %d\n\n", VERSION, RELEASE);
  blurb(utab);
  exit(0);
}

/* p r i n t m s g
 *
 *  Print message on standard output if not remote. */

/*VARARGS1*/
printmsg(fmt, a1, a2, a3, a4, a5)
register char *fmt;
{ if (local && !kflg)
  { fputs("Kermit: ", stderr);
    fprintf(stderr, fmt, a1, a2, a3, a4, a5);
    putc('\n', stderr);
  }
}

/* e r r o r
 *
 *  Print error message.
 *
 *  If local, print error message with printmsg.
 *  If remote, send an error packet with the message. */

/*VARARGS1*/
error(fmt, a1, a2, a3, a4, a5)
char *fmt;
{ char msg[80];
  register int len;

  if (!local || server)
  { sprintf(msg, fmt, a1, a2, a3, a4, a5);              /* Make it a string */
    len = strlen(msg);
    spack('E', n, len, msg);                       /* Send the error packet */
  }
  else
    printmsg(fmt, a1, a2, a3, a4, a5);
}

/* p r e r r p k t
 *
 *  Print contents of error packet received from remote host. */
prerrpkt(msg)
register char *msg;
{ fprintf(stderr, "Kermit aborting; remote host error msg:\n%s\n", msg);
}

/* 06/30/85 ral Initial coding, partially adapted from 
 *              code by Bradley Bosch */

/* save current state in savesg and force path into raw mode */
raw(path, savesg)
int path;
struct sgbuf*savesg;
{ struct sgbuf tempsg;

  _gs_opt(path, savesg);
  _gs_opt(path, &tempsg);

  if (tempsg.sg_class == 0)
  {                                           /* only change things for scf */
    tempsg.sg_delete = tempsg.sg_backsp = tempsg.sg_echo  = tempsg.sg_alf   = 
    tempsg.sg_pause  = tempsg.sg_dlnch  = tempsg.sg_eorch = tempsg.sg_eofch = 
    tempsg.sg_rlnch  = tempsg.sg_dulnch = tempsg.sg_psch  = tempsg.sg_kbich = 
    tempsg.sg_kbach = 0;

    if (!wantxon)
      tempsg.sg_xon = tempsg.sg_xoff = 0;

    _ss_opt(path, &tempsg);
  }
}

cook(path, savesg)
int path;
struct sgbuf*savesg;
{ _ss_opt(path, savesg);
}

blurb(msgtab)
char **msgtab;
{ register char **mscan;

  for (mscan = msgtab; *mscan; mscan++)
    fputs(*mscan, stderr);
}

