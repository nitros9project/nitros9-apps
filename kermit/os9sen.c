/* os9sen.c */
/* send file routines of os9 kermit */

#include "os9inc.h"
#include <ctype.h>

/* s e n d s w
 *
 *  Sendsw is the state table switcher for sending files.  It loops until
 *  either it finishes, or an error is encountered.  The routines called
 *  by sendsw are responsible for changing the state. */

sendsw()
{ char sinit(), sfile(), sdata(), seof(), sbreak();

  state = 'S';                          /* Send initiate is the start state */
  n = 0;                                       /* Initialize message number */
  bit8status = UNKNOWN;

  numtry = 0;                                           /* Say no tries yet */
  for (;;)                                  /* Do this as long as necessary */
  { if (debug)
      printf("sendsw state: %c, Packet # %d\n", state, n);

    switch (state)
    { case 'S' :
        bctu = 1;
        state = sinit('S');                                    /* Send-Init */
        bctu = bctr;
        break;
      case 'F' :
        state = sfile();                                       /* Send-File */
        break;
      case 'D' :
        state = sdata();                                       /* Send-Data */
        break;
      case 'Z' :
        state = seof();                                 /* Send-End-of-File */
        break;
      case 'B' :
        state = sbreak();                                     /* Send-Break */
        break;
      case 'C' :
        if (local)
          putc('\n', stderr);
        cx = FALSE;
        return (TRUE);                                          /* Complete */
      case 'A' :
        if (local)
          putc('\n', stderr);
        cx = FALSE;
        return (cx = FALSE);                                     /* "Abort" */
      default  :
        putc('\n', stderr);
        return (cx = FALSE);                               /* Unknown, fail */
    }
  }
}

/*  s i n i t
 *
 *  Send Initiate: send this host's parameters and get other side's back. */

char sinit(type)
char type;
{ int num, len;                                    /* Packet number, length */

  if (numtry++ > MAXTRY)
    return ('A');                             /* If too many tries, give up */

  spar(packet);                                 /* Fill up init info packet */

  flushinput();                                      /* Flush pending input */

  spack(type, n, 9, packet);                             /* Send an S packet */
  switch (rpack(&len, &num, recpkt))                 /* What was the reply? */
  { case 'N' :
      return (state);                                  /* NAK, try it again */

    case 'Y' :                                                       /* ACK */
      if (n != num)                        /* If wrong ACK, stay in S state */
        return (state);                                    /* and try again */
      rpar(len, recpkt);                      /* Get other side's init info */

      if (local && type != 'I')
        putc('S', stderr);

      if (eol == 0)
        eol = '\n';                               /* Check and set defaults */

      if (quote == 0)
        quote = '#';

      numtry = 0;                                      /* Reset try counter */
      n = (n + 1) & 63;                                /* Bump packet count */
      return ('F');                                /* OK, switch state to F */

    case 'E' :                                     /* Error packet received */
      if (type == 'I')       /* Server's don't need to know about I packets */
        return('F');                                         /* S-INIT okay */
      else
      { prerrpkt(recpkt);                                   /* Print it out */
        return ('A');                                          /* and abort */
      }

    case FALSE :
      return (state);                         /* Receive failure, try again */

    default  :
      return ('A');                          /* Anything else, just "abort" */
  }
}

/* s f i l e
 *
 *  Send File Header. */

char sfile()
{ int num, len;                                    /* Packet number, length */
  char filnam1[50];                                  /* Converted file name */
  register char *cp;                                        /* char pointer */
  register char *newfilnam;                 /* Pointer to file name to send */

  if (numtry++ > MAXTRY)
    return ('A');                             /* If too many tries, give up */

  if (fp == NULL)                                    /* If not already open, */
  { if (debug)
      printf("   Opening %s for sending.\n", filnam);

    if (*filnam == '-')
    { kflg = 1;                                  /* Received data from stdin */
      fp = stdin;
      strcpy(filnam, "stdin");
    }
    else
    { if ((fp = fopen(filnam, "r")) == NULL)
      { error("Cannot open file %s", filnam);
        return ('A');                           /* bad file pointer, give up */
      }
    }
  }

  strcpy(filnam1, filnam);                                /* Copy file name */
  newfilnam = cp = filnam1;

  while (*cp != '\0')                        /* Strip all leading directory */
    if (*cp++ == '/')                     /* names (i.e. up to the last /). */
      newfilnam = cp;

  if (filnamcnv)                           /* Convert lower case to upper   */
    for (cp = newfilnam; *cp != '\0'; cp++)
      if (islower(*cp))
        *cp = toupper(*cp);

  len = cp - newfilnam;                   /* Compute length of new filename */

  putc('\n', stderr);
  printmsg("Sending %s as %s", filnam, newfilnam);
  spack('F', n, len, newfilnam);                        /* Send an F packet */

  switch (rpack(&len, &num, recpkt))                 /* What was the reply? */
  { case 'N' :                             /* NAK, just stay in this state, */
      num = (--num < 0 ? 63 : num);      /* unless it's NAK for next packet */
      if (n != num)                        /* which is just like an ACK for */
        return (state);                   /* this packet so fall thru to... */

    case 'Y' :                                                       /* ACK */
      if (n != num)
        return (state);                    /* If wrong ACK, stay in F state */

      if (local)
        putc('F', stderr);

      numtry = 0;                                      /* Reset try counter */
      n = (n + 1) & 63;                                /* Bump packet count */
      size = bufill(packet);                    /* Get first data from file */
      return ('D');                                    /* Switch state to D */

    case 'E' :                                     /* Error packet received */
      prerrpkt(recpkt);                                     /* Print it out */
      return ('A');                                            /* and abort */

    case FALSE :
      return (state);                         /* Receive failure, stay in F */

    default  :
      return ('A');                         /* Something else, just "abort" */
  }
}

/* s d a t a
 *
 *  Send File Data */

char sdata()
{ int num, len;                                    /* Packet number, length */

  if (numtry++ > MAXTRY)
    return ('A');                             /* If too many tries, give up */

  spack('D', n, size, packet);                           /* Send a D packet */
  switch (rpack(&len, &num, recpkt))                 /* What was the reply? */
  { case 'N' :                             /* NAK, just stay in this state, */
      num = (--num < 0 ? 63 : num);        /* unless it's next packet's NAK */
      if (n != num)                        /* which is just like an ACK for */
        return (state);                   /* this packet so fall thru to... */

    case 'Y' :                                                       /* ACK */
      if (n != num)
        return (state);                               /* If wrong ACK, fail */
      numtry = 0;                                      /* Reset try counter */
      n = (n + 1) & 63;                                /* Bump packet count */

      if (local && (n & 3) == 0)
        putc('.', stderr);

      if (cx)
        return('Z');

      if (len > 0)
      { switch (*packet)
        { case 'Z':
            cz = TRUE;
          case 'X':
            cx = TRUE;
            return('Z');
         }
       }

      size = bufill(packet);                          /* Get data from file */
      return (size == EOF) ? 'Z' : 'D';

    case 'E' :                                     /* Error packet received */
      prerrpkt(recpkt);                                     /* Print it out */
      return ('A');                                            /* and abort */

    case FALSE :
      return (state);                         /* Receive failure, stay in D */

    default  :
      return ('A');                               /* Anything else, "abort" */
    }
}

/* s e o f
 *
 *  Send End-Of-File. */

char seof()
{ int num, len;                                    /* Packet number, length */

  if (numtry++ > MAXTRY)
    return ('A');                             /* If too many tries, "abort" */

  if (cx)
  { packet[0] = 'D';
    spack('Z', n, 1, packet);
  }
  else
    spack('Z', n, 0, packet);                          /* Send a 'Z' packet */

  switch (rpack(&len, &num, recpkt))                 /* What was the reply? */
  { case 'N' :                              /* NAK, just stay in this state */
      num = (--num < 0 ? 63 : num);          /* unless it's for next packet */
      if (n != num)                        /* which is just like an ACK for */
        return (state);                   /* this packet so fall thru to... */

    case 'Y' :                                                       /* ACK */
      if (n != num)
        return (state);                           /* If wrong ACK, hold out */

      if (local)
        putc('Z', stderr);

      numtry = 0;                                      /* Reset try counter */
      n = (n + 1) & 63;                            /* and bump packet count */

      if (debug)
        printf("     Closing input file %s, ", filnam);

      if (kflg)
        kflg = 0;
      else
        fclose(fp);                                 /* Close the input file */
      fp = NULL;                                       /* and forget the fp */
      cx = FALSE;

      if (debug)
        printf("looking for next file...\n");
      if (gnxtfl() == FALSE)                           /* No more files go? */
        return ('B');                       /* if not, break, EOT, all done */
      if (debug)
        printf("     New file is %s\n", filnam);
      return ('F');                        /* More files, switch state to F */

    case 'E' :                                     /* Error packet received */
      prerrpkt(recpkt);                                     /* Print it out */
      return ('A');                                            /* and abort */

    case FALSE :
      return (state);                         /* Receive failure, stay in Z */

    default  :
      return ('A');                              /* Something else, "abort" */
  }
}

/*  s b r e a k
 *
 *  Send Break (EOT) */

char sbreak()
{ int num, len;                                    /* Packet number, length */

  if (numtry++ > MAXTRY)
    return ('A');                              /* If too many tries "abort" */

  spack('B', n, 0, packet);                              /* Send a B packet */
  switch (rpack(&len, &num, recpkt))                 /* What was the reply? */
  { case 'N' :                             /* NAK, just stay in this state, */
      num = (--num < 0 ? 63 : num);        /* unless previous packet's NAK, */
      if (n != num)                        /* which is just like an ACK for */
        return (state);                   /* this packet so fall thru to... */

    case 'Y' :                                                       /* ACK */
      if (n != num)
        return (state);                               /* If wrong ACK, fail */

      if (local)
        putc('B', stderr);

      numtry = 0;                                      /* Reset try counter */
      n = (n + 1) & 63;                            /* and bump packet count */
      return ('C');                             /* Switch state to Complete */

    case 'E' :                                     /* Error packet received */
      prerrpkt(recpkt);                                     /* Print it out */
      return ('A');                                            /* and abort */

    case FALSE :
      return (state);                         /* Receive failure, stay in B */

    default  :
      return ('A');                                       /* Other, "abort" */
  }
}
