/* os9rec.c */
/* receive file routines for os9 kermit */

#include "os9inc.h"
#include <ctype.h>

/* r e c s w
 *
 * This is the state table switcher for receiving files. */

recsw(mystate)
char mystate;
{ char rinit(), rfile(), rdata();                   /* Use these procedures */

  if ((state = mystate) == 'R')
  { n = 0;                                     /* Initialize message number */
    bit8status = UNKNOWN;
  }
  numtry = 0;                                           /* Say no tries yet */

  for (;;)
  { if (debug)
      printf(" recsw state: %c\n", state);
    switch (state)                                         /* Do until done */
    { case 'R' :
        bctu = 1;
        state = rinit();                                    /* Receive-Init */
        bctu = bctr;
        break;
      case 'F' :
        state = rfile();                                    /* Receive-File */
        break;
      case 'D' :
        state = rdata();                                    /* Receive-Data */
        break;
      case 'C' :
        if (local && !kflg)
          putc('\n', stderr);
        cx = FALSE;
        return (TRUE);                                    /* Complete state */
      case 'A' :
        if (local && !kflg)
          putc('\n', stderr);
        cx = FALSE;
        return (FALSE);                                    /* "Abort" state */
      }
  }
}

/* r i n i t
 *
 *  Receive Initialization */

char rinit()
{ int len, num;                                    /* Packet length, number */
  char sfile();                             /* routine used for get command */

  sentxz =
  rptflg = FALSE;

  if (numtry++ > MAXTRY)
    return ('A');                             /* If too many tries, "abort" */

  switch (rpack(&len, &num, packet))                        /* Get a packet */
  { case 'S' :                                                 /* Send-Init */
      rpar(len, packet);                   /* Get the other guy's init data */
      spar(packet);                        /* Fill packet with my init info */
      spack('Y', n, 9, packet);                   /* ACK with my parameters */
      oldtry = numtry;                                /* Save old try count */
      numtry = 0;                                    /* Start a new counter */
      n = (n + 1) & 63;                       /* Bump packet number, mod 64 */

      if (local && !kflg)
        putc('S', stderr);

      return ('F');                             /* Enter File-Receive state */

    case 'E' :                                     /* Error packet received */
      prerrpkt(packet);                                     /* Print it out */
      return ('A');                                            /* and abort */

    case FALSE :                                      /* Didn't get packet, */
    case 'N' :                                              /* or got a NAK */
      if (gflg)
        spack('R', n, strlen(filnam), filnam);        /* request file again */
      else
        spack('N', n, 0, 0);                                /* Return a NAK */
      return (state);                                        /* Keep trying */

    case 'Y' :
      return (state);                                /* Ignore leftover ACK */
                                                /* (or bad ACK of R packet) */
    default  :
      return ('A');                         /* Unknown packet type, "abort" */
    }
}

/* r f i l e
 *
 *  Receive File Header */
char filnam1[50];                          /* Holds the converted file name */

char rfile()
{ int num, len;                                    /* Packet number, length */

  if (numtry++ > MAXTRY)
    return ('A');                              /* "abort" if too many tries */

  switch (rpack(&len, &num, packet))                        /* Get a packet */
  { case 'S' :                             /* Send-Init, maybe our ACK lost */
      if (oldtry++ > MAXTRY)
        return ('A');                          /* If too many tries "abort" */
      if (num != ((n == 0) ? 63 : n - 1))
        return ('A');                       /* Not previous packet, "abort" */

      /* Previous packet, mod 64 */
      /* ack with our Send-Init parameters */
      spar(packet);
      bctu = 1;
      spack('Y', num, 9, packet);
      bctu = bctr;
      numtry = 0;                                      /* Reset try counter */
      return (state);                                 /* Stay in this state */

    case 'Z' :                                               /* End-Of-File */
      if (oldtry++ > MAXTRY)
        return ('A');
      if (num != ((n == 0) ? 63 : n - 1))
        return ('A');                       /* Not previous packet, "abort" */
      spack('Y', num, 0, 0);
      numtry = 0;

      if (local && !kflg)
        putc('Z', stderr);

      return (state);                                 /* Stay in this state */

    case 'F' :                               /* File Header (what we want!) */
      if (num != n)
        return ('A');                        /* packet number must be right */

      strcpy(filnam1, packet);                        /* Copy the file name */
      if (filnamcnv)
      {                                      /* Convert upper case to lower */
        for (filnam = filnam1; *filnam != '\0'; filnam++)
          if (isupper(*filnam))
            *filnam = tolower(*filnam);
      }

      /* Try to open a new file */
      if (kflg)
        fp = stdout;
      else
      { if ((fp = fopen(filnam1, "w")) == NULL)
        { error("Cannot create %s", filnam1);
          return ('A');                                          /* Give up */
        }
      }

      /* OK, give message */
      putc('\n', stderr);
      printmsg("Receiving %s as %s", packet, filnam1);
      if (local && !kflg)
        putc('F', stderr);

      spack('Y', n, 0, 0);                   /* Acknowledge the file header */
      oldtry = numtry;                                /* Reset try counters */
      numtry = 0;
      n = (n + 1) & 63;                       /* Bump packet number, mod 64 */
      return ('D');                                 /* Switch to Data state */

    case 'B' :                                  /* Break transmission (EOT) */
      if (num != n)
        return ('A');                      /* Need right packet number here */
      if (local && !kflg)
        putc('B', stderr);

      spack('Y', n, 0, 0);                                        /* Say OK */
      return ('C');                                 /* Go to complete state */

    case 'E' :                                     /* Error packet received */
      prerrpkt(packet);                                     /* Print it out */
      return ('A');                                            /* and abort */

    case FALSE :                                       /* Didn't get packet */
      spack('N', n, 0, 0);                                    /* Send a NAK */
      return (state);                                    /* but keep trying */

    case 'X':                                     /* Receive file to stdout */
       if (num != n)                         /* Need to have correct packet */
         return('A');

       spack('Y', n, 0, 0);                          /* Ack the Text-Header */
       oldtry = numtry;                               /* Reset our counters */
       numtry = 0;
       n = (n + 1) & 63;                            /* Bump packet counters */
       kflg = 1;                                /* We are sending to stdout */
       fp = stdout;
       putc('\n', fp);
       bufemp(packet, len);                      /* Display the Text-Header */
       putc('\n', fp);
       return('D');                                 /* Switch to data state */

    default:
      return ('A');                              /* Unknown packet, "abort" */
    }
}

/* r d a t a
 *
 *  Receive Data */

char rdata()
{ int num, len;                                    /* Packet number, length */

  if (numtry++ > MAXTRY)
    return ('A');                              /* "abort" if too many tries */

  switch (rpack(&len, &num, packet))                          /* Get packet */
  { case 'D' :                                           /* Got Data packet */
      if (num != n)                                        /* wrong packet! */
      { if (oldtry++ > MAXTRY ||                          /* Too many tries */
          (num != ((n == 0) ? 63 : n - 1)))             /* not prev. packet */
          return ('A');
        spack('Y', num, 6, packet);                       /* Yes, re-ACK it */
        numtry = 0;                                    /* Reset try counter */
        return (state);                                /* Don't write data! */
      }

      /* Got data with right packet number */
      if (cx)
      { if (sentxz)
        { error("User interrupted transfer.");
          state = 'A';
        }
        else
        { packet[0] = cz ? 'Z': 'X';
          spack('Y', n, 1, packet);
          state = 'D';
          sentxz = TRUE;
        }
      }
      else
      { if (local && !kflg && (n & 3) == 0)
          putc('.', stderr);

        if (bufemp(packet, len))              /* Write the data to the file */
        { spack('Y', n, 0, 0);                    /* Acknowledge the packet */
          state = 'D';
        }
        else
        { fclose(fp);
          error("Error #%03d, Writing to %s", errno, filnam1);
          state = 'A';
        }
      }

      oldtry = numtry;                            /* Reset the try counters */
      numtry = 0;
      n = (n + 1) & 63;                       /* Bump packet number, mod 64 */
      return state;                                 /* Remain in data state */

    case 'F' :                                         /* Got a File Header */
      if (oldtry++ > MAXTRY ||                            /* too many tries */
        (num != ((n == 0) ? 63 : n - 1)))               /* not prev. packet */
        return ('A');
      spack('Y', num, 0, 0);                                /* ACK it again */
      numtry = 0;                                      /* Reset try counter */
      return (state);                                 /* Stay in Data state */

    case 'Z' :                                               /* End-Of-File */
      if (num != n)
        return ('A');                      /* Must have right packet number */

#ifdef nooverlap
      /* can't handle disk and serial i/o at the same time */
      if (!kflg)
      { fclose(fp);                                       /* close the file */
        if (cx || (len && *packet == 'D'))
          unlink(filnam1);
      }
      spack('Y', n, 0, 0);                            /* Ack the 'Z' packet */
#else
      /* ACK before close to allow i/o overlap */
      spack('Y', n, 0, 0);                                   /* OK, ACK it. */
      if (!kflg)
      { fclose(fp);                                       /* close the file */
        if (cx || (len && *packet == 'D'))
          unlink(filnam1);
      }
#endif
      if (local && !kflg)
        putc('Z', stderr);

      n = (n + 1) & 63;                               /* Bump packet number */
      return ('F');                        /* Go back to Receive File state */

    case 'E' :                                     /* Error packet received */
      prerrpkt(packet);                                     /* Print it out */
      return ('A');                                            /* and abort */

    case FALSE :                                       /* Didn't get packet */
      spack('N', n, 0, 0);                                  /* Return a NAK */
      return (state);                                        /* Keep trying */

    default  :
      return ('A');                              /* Unknown packet, "abort" */
    }
}
