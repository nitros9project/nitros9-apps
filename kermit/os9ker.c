char scid[] = "$Header: os9ker, v21.5 90/06/02 15:10:43 SrT $";

/* os9ker.c  OS-9 kermit main program */

#define EXTERN               /* global variables are actually declared here */

#include "os9inc.h"

/*
* K e r m i t  File Transfer Utility
*
* UNIX Kermit, Columbia University, 1981, 1982, 1983
* Bill Catchings, Bob Cattani, Chris Maio, Frank da Cruz, Alan Crosswell
*
*  Also:
*  Jim Guyton, Rand Corporation
*  Walter Underwood, Ford Aerospace
*  Glenn Seaton, Kennedy Space Center
*  Bradley Bosch,
*  Robert Larson, U. of Southern California <Blarson@usc-ecl>
*  James Jones
*  Simmule Turner (simmy@nu.cs.fsu.edu)
*
* usage:
*  kermit c [xlbe line baud escapechar]    to connect
*  kermit s [d..ifxlb line baud] file ...  to send files
*  kermit r [d..ifxlb line baud]           to receive files
*
* where
*  c = connect, s = send, r = receive,
*  d = debug, i = image mode, f = no filename conversion, l = tty line,
*  b = baud rate, e = escape char, x = kill xon/xoff on comm path.
*
*  For remote Kermit, format is either:
*      kermit r                to receive files
*  or  kermit s file ...       to send files
*
* OS-9 Version and differences
*  kermit s[ifxdl] path filename   is send format
* OS-9 version has time-out on rx data of MAXTRY if not server "W"ait mode.
*
* Host Server command
*  kermit h[idxfl path]            host server mode
*  kermit g[idxf]l path filename   get file from a server
*  kermit q[idxf]l path            tell host server to terminate
*/

/* Modification History:
*
* 08/18/88 SrT
*  - Removed all of those damn tabs, and cleaned up source.
* 08/17/88 SrT
*  - added ability to send a file using standard input
*    e.g. tar cvf - /dd ! kermit sil /m -
*    Altered options. -x = -h, and -f = -q, again to mimic C-Kermit,
*    also -X = -x, and -F = -f.
*    Option '-k' to allow received data to be sent to stdout.
* 08/16/88 SrT
*  - Added display of status packets, in a manner more
*    consistent with C-Kermit.  Changed baud rate setting to
*    Level II's enhanced driver (baud rate changing with setstat).
* 07/14/88 SrT
*  - Added session logging, and a command mode.  Changed default
*    escape character from ~ to #.  Command mode is entered by
*    typing the escape character followed by c.
* 07/12/88 SrT
*  - added baud rate from command line (executes xmode).
*
* Long interval up through early 1988--modified by James Jones
*  - cleaned up coding style
*  - modified rpack() support to improve timeout setup and cut overhead
*    by reading all pending characters
*  - modified to support repeat-count and conform a little bit better to
*    the way the da Cruz book says things should be (initial timeout,
*    honoring the other fellow's request for timeout interval, etc.)
*  - corrected server bug noticed by Jim Omura.
*  - corrected my own mistake in transcribing from da Cruz text on
*    uncontrollifying characters in what is bufemp() in this version.
*  - in view of Kermit's avoidance of control characters (save for SOH),
*    and to let the user avoid buffer overruns, made wiping xon/xoff
*    fields in path descriptors optional (we also actually look at the
*    return values from our reads now...).
* 07/02/85 ral
*  - Add connect command from Brad Bosch's os9 kermit
*  - Rewrite setstat/getstat for putting in raw mode (os9raw.c)
*  - Add flushinput call to send packet routine
*  - Rewrite timeout code to be system independent and more
*    comprehensive.  (routine readtimed)
*  - Add compile switches for timeout
*  - Add nooverlap switch for good performance on CoCo and others
*    (coco can't overlap disk and serial i/o, and will timeout
*    often if the code assumes it can. Others should overlap to
*    maximize performance.)
*  - Fix problems with image vs. text.  Make CRLF processing the
*    default, (eliminate 'u' mode)
*  - Make lowercasing of received filenames the default
*  - Add handling of nak and timeout in get and quit commands
*  - Allow / in filenames sent in get command
*  - Fix long-standing bug in receiving SOH in the middle of a
*    packet
*  - Miscellaneous indentation and other coding fixes.
*    (Don't blame the indentation on me, someone's tab to space
*    converter must have done this mess.)
* 06/29/85 ral
*  - Split into smaller separately compilable files,
*    move #defines, #includes, and global variables to os9inc.h
*    rename everything so it fits with Columbia distribution
*
* April 9, 1985
*  - Move Option messages, debug show Rpack rx cksum if bad.
* Feburary 27, 1985
*  - Defined rpack type char for OS-9/68k
* December 12, 1984
*  - fix OS-9 time-out, Server to standard
* November 19, 1984
*  - Added OS9 time-out for Rx data.  W.G. Seaton
* November 14, 1984
*  - Added Host Server Mode  W.G. Seaton
*  - Added include kermserv.c for server function
*  - Added include kermget.c for get function
* November  9, 1984
*  - Modified for OS9  by W.G. Seaton,NASA KSC
* Oct. 17
*  - Included fixes from Alan Crosswell (CUCCA) for IBM_UTS:
*  - Changed MYEOL character from \n to \r.
*  - Change char to int in bufill so getc would return -1 on
*    EOF instead of 255 (-1 truncated to 8 bits)
*  - Added read() in rpack to eat the EOL character
*  - Added fflush() call in printmsg to force the output
*
*  NOTE: The last three changes are not conditionally compiled
*  since they should work equally well on any system.
*
*  Added support for error packets and cleaned up the printing routines.
*
*/

/*
*  m a i n
*
*  Main routine - parse command and options, set up the
*  tty lines, and dispatch to the appropriate routine.
*/

main(argc, argv)
int argc;
char **argv;
{ char *ttyname;                              /* tty name for LINE argument */
  register char *cp;
  int qflg, cflg, rflg, sflg;      /* flags for GET, CONNECT, RECEIVE, SEND */
  extern char c_buffer[];

  if (argc < 2)
    usage();                            /* Make sure there's a command line */

  cp = *++argv;
  argv++;
  argc -= 2;                                     /* Set up pointers to args */

  /*  Initialize these values and hope the first packet gets across OK */
  eol = CR;                                     /* EOL for outgoing packets */
  quote = '#';                           /* Standard control-quote char "#" */
  pad = 0;                                                    /* No padding */
  padchar = '\0';                         /* Use null if any padding wanted */
  bctu = bctr = 1;                       /* Default to 1 character checksum */
  cflg = sflg = rflg = 0;                       /* Turn off all parse flags */
  server = qflg = gflg = hflg = 0;
  ttyname = NULL;                                 /* Default is remote mode */
  cx = cz =
  sentxz  = FALSE;

  session_log = NULL;
  kflg = 0;

  image = FALSE;
  wantxon = filnamcnv = TRUE;

  escchr = ESCCHR;                              /* Default escape character */

  while ((*cp) != NULL)                   /* Parse characters in first arg. */
  { switch (*cp++)
    { case '1':
      case '2':
        bctr = *(cp-1) - '0';
        break;
      case 'c' :
        cflg++;
        break;                                       /* C = Connect command */
      case 's' :
        sflg++;
        break;                                          /* S = Send command */
      case 'r' :
        rflg++;
        break;                                       /* R = Receive command */
      case 'g' :
        gflg++;
        break;                                  /* G = Get file from server */
      case 'x' :
        hflg++;
        break;                                   /* H = Host Server Command */
      case 'f' :
        qflg++;
        break;                              /* Q = tell remote Host to quit */
      case 'd' :
        debug++;
        break;                            /* D = Increment debug mode count */
      case 'k' :
        kflg++;
        break;
      case 'X' :
        wantxon = FALSE;
        break;                                     /* X = don't do xon/xoff */
      case 'F' :
        filnamcnv = FALSE;
        break;                              /* F = don't do case conversion */
      case 'i' :
        image = TRUE;
        break;                           /* I = Image mode; no CRLF mapping */
      case 'l' :                             /* L = specify tty line to use */
        if (argc--)
          ttyname = *argv++;
        else
          usage();
        if (debug)
          printf("Line to remote host is %s\n", ttyname);
        break;
      case '8' :                               /* 8 = do eighth-bit quoting */
        bit8flag = TRUE;
        break;
      case 'e' :                                 /* E = specify escape char */
        if (argc--)
          escchr = **argv++;
        else
          usage();
        break;
      }
  }

  /* Done parsing--only one command allowed */
  if ((cflg + qflg + gflg + hflg + sflg + rflg + kflg) != 1)
    usage();

  if (ttyname)
  {                         /* LINE was specified, we operate in local mode */
    ttyfd = open(ttyname, 3);                   /* Open the line for update */
    if (ttyfd < 0)
    { printmsg("Cannot open %s", ttyname);
      exit(1);
    }
    local = TRUE;                           /* Indicate we're in local mode */
  }
  else
  {
    /* No LINE specified so we operate in remote mode
     * (i.e. controlling tty is the communications line) */
    ttyfd = 0;
    local = FALSE;
  }

  printf("%s\n",scid);

  /* Tell User Options and Modes Invoked. */
  if (debug)
  { printf("Debugging level = %d\n\n", debug);
    if (cflg)
      puts("Connect command");
    else if (sflg)
      puts("Send command");
    else if (rflg || kflg)
      puts("Receive command");
    else if (gflg)
      puts("Get command");
    else if (hflg)
      puts("Host Server command");
    else if (qflg)
      puts("Quit to Host Server command");
   }

  /* Put the proper tty into the correct mode */
  if (local)                                    /* Local, use assigned line */
    raw(ttyfd, &linesave);                 /* put assigned line in raw mode */
  else
  {                                       /* If remote, use controlling tty */
    raw(0, &insave);                               /* put input in raw mode */
    raw(1, &outsave);                                   /* ditto for output */
  }

  /* All set up, now execute the command that was given. */
  intercept(
#ifdef KERMIT_MODERN
            (sighandler_t)
#endif
            catcher);
  timint = MYTIME;                            /* how long to wait 1st time? */

  if (cflg)
    connect();                                           /* Connect command */
  else
  { if (gflg)
    {                                                /* Set up Get Function */
      /* Get file to request */
      if (argc--)
        filnam = *argv++;
      else
        usage();                                    /* Parameter error quit */
      fp = NULL;                                       /* No files open yet */
      filelist = argv;                   /* set up list of files to request */
      filecount = argc;                           /* Number of files to get */
      client(0);                                      /* Initate remote Get */
    }

    if (hflg)
      servsw();                                      /* Initate Server Mode */

    if (qflg)
    { strcpy(c_buffer,"F");                            /* Initate Quit mode */
      client('G');
    }

    if (sflg)
    {                                                       /* Send command */
      /* Get file to send */
      if (argc--)
        filnam = *argv++;
      else
      { if (local)                                 /* restore assigned line */
          cook(ttyfd, &linesave);
        else
        {                           /* restore controlling scf device modes */
          cook(1, &outsave);
          cook(0, &insave);
        }
        usage();
      }

      fp = NULL;                               /* Indicate no file open yet */
      filelist = argv;                  /* Set up the rest of the file list */
      filecount = argc;                     /* Number of files left to send */
      /* Send the file(s) */
      printmsg(sendsw() == FALSE ? "Send failed." : "done.");
    }

    if (rflg || kflg)
    {                                                    /* Receive command */
      printmsg(recsw('R') == FALSE ? "Receive failed." : "done.");
    }
  }

  if (local)
    cook(ttyfd, &linesave);                        /* restore assigned line */
  else
  { cook(1, &outsave);                     /* restore controlling scf modes */
    cook(0, &insave);                                   /* in reverse order */
  }
}
