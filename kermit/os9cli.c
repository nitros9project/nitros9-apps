/* os9cli.c */
/* client end - for server transactions */

#include "os9inc.h"

DIRECT char c_type;
char c_buffer[100];

client(ss)
char ss;
{ char sinit();

  bit8status = UNKNOWN;
  n      = 0;
  numtry = 0;
  state  = 'I';

  for (;;)
  { if (debug)
      printf("client state: %c\n", state);
    switch(state)
    { case 'A':
        return(FALSE);

      case 'I':
        bctu  = 1;
        state = sinit('I');
        if (state == 'F')
          state = 'E';
        n = 0;
        break;

      case 'E':
        if (ss)
        { c_type = ss;
          spack(c_type, n, strlen(c_buffer), c_buffer);
          return(cligen());
        }
        else
        { do
          { spack('R', n, strlen(filnam), filnam);
            state = recsw('R');
          } while (gnxtfl());
          return(TRUE);
        }
    }
  }
}

cligen()
{ register int retry;
  int len, num, t;

  for (retry=0; retry < MAXTRY; retry++)
  { t = rpack(&len, &num, recpkt);
    if (debug)
      printf("cligen state: %c\n",t);
    switch(t)
    { case 'N':
      case FALSE:
        spack(c_type, n, strlen(c_buffer), c_buffer);    
        break;

      case 'E':
        prerrpkt(recpkt);
        return(FALSE);

      case 'Y':
        fp = stdout;
        if (len)
        { putc('\n', fp);
          bufemp(recpkt,len);
          putc('\n', fp);
        }
        else if (c_buffer[0] == 'F')
          fprintf(fp,"\nServer Terminated\n");    
        fp = NULL;
        return(TRUE);

      case 'S':
        rpar(len, recpkt);
        spar(recpkt);
        spack('Y', n, 9, recpkt);
        bctu = bctr;
        n = 1;
        return(recsw('F'));

      case 'X':
        t = kflg;
        kflg = 1;
        spack('Y', n, 0, 0);
        n = 1;
        fp = stdout;
        numtry = 0;
        for (;;)
        { state = rdata();
          if (state == 'A' || state == 'F')
            break;
        }
        kflg = t;
        fp = NULL;
        return(state == 'A' ? FALSE : TRUE);
    }
  }
  return(FALSE);
}
