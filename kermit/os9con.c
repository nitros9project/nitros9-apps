/* os9con.c connect for os9 kermit */
/* V 21.1 Simmule Turner */

#include "os9inc.h"
#include <errno.h>

static char escdisp[3];                 /* display form of escape character */
static DIRECT int logon = TRUE;

#ifdef OSK
extern char **environ;
char *argv[] = { "shell", NULL, NULL };
int os9exec();
#endif
int os9fork();

char *chelp[] =
{   "C to close the connection, or:\r\l", 
    "  0 (zero) to send a null\r\l",
    "  P Push to system command processor\r\l",
    "  Q Quit logging\r\l",
    "  R Resume logging\r\l",
    "  ? for help\r\l",
    " escape character twice to send the escape character.\r\l\r\l", NULL
};

int get_action()
{ char chr;

  printmsg("%s \l", escdisp);
  read(0, &chr, 1);

  switch (chr)
  { case '0' :
      write(ttyfd, &chr, 1);
      return FALSE;
    case '!' :
    case 'p' :
    case 'P' :
      cook(1, &outsave);                          /* restore to cooked mode */
      cook(0, &insave);                 /* Must be in reverse order of save */
#ifdef OSK
      if (os9exec(os9fork, argv[0], argv, environ, 0, 0) == ( - 1))
#else
      if (os9fork("shell", 1, "\n", 1, 1, 0) == ( - 1))
#endif
        printmsg("can't escape to shell.");
      else
        wait(0);
      raw(0, &insave);                    /* put it back to raw for packets */
      raw(1, &outsave);
      return FALSE;
    case '8' :
      bit8flag = !bit8flag;
      return FALSE;
    case 'c' :
    case 'C' :
      return command();
    case 'q' :
    case 'Q' :
      logon = FALSE;
      break;
    case 'r' :
    case 'R' :
      logon = TRUE;
      break;
    case '?' :
      blurb(chelp);
      return FALSE;
    default  :
      if (chr != escchr)
        chr = '\x7';                                           /* i.e. BEL! */
      write(ttyfd, &chr, 1);
      return FALSE;
    }
}

connect()
{ char cbuf[256];
  register char *buf;
  register int cnt, tmp, flag;

  if (!local)                       /* Nothing to connect to in remote mode */
  { printmsg("No line specified for connection.");
    return ;
  }

  raw(0, &insave);                                 /* Put input in raw mode */
  raw(1, &outsave);                               /* Put output in raw mode */

  if (escchr < ' ')
  { escdisp[0] = '^';
    escdisp[1] = ctl(escchr);
    escdisp[2] = 0;
  }
  else
  { escdisp[0] = escchr;
    escdisp[1] = 0;
  }

  printmsg("connected escape = %s ...\r\l", escdisp);

  for (;;)
  { if ((tmp = _gs_rdy(ttyfd)) < 0)
    { if (errno != E_NOTRDY)
        printmsg("_gs_rdy() errno = %d\r\l", errno);
    }
    else if ((tmp = read(ttyfd, cbuf, tmp)) < 0)
      printmsg("read() errno = %d\r\l", errno);
    else
    { if (!image)
      { for (buf = &cbuf[tmp]; buf > cbuf; )
          *--buf &= '\177';
      }
      if (write(1, cbuf, tmp) < 0)
        printmsg("write() errno = %d\r\l", errno);

      if (log && logon)
        if (fwrite(cbuf, 1, tmp, log) == NULL)
        { fprintf(stderr, "ERR:  Closing log file\n");
          fclose(log);
        }
    }

    if ((tmp = _gs_rdy(0)) > 0)
    { cnt = read(0, cbuf, 1);
      if ((*cbuf & '\177') != escchr)
        write(ttyfd, cbuf, cnt);
      else
        if (get_action())
          break;
    }
    tsleep(1);                         /* give the other processes a chance */
  }

  cook(1, &outsave);                                  /* restore scf status */
  cook(0, &insave);                      /* Must be done in opposite order! */
  printmsg("disconnected.");
}

