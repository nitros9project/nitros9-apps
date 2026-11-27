#include "os9inc.h"
#include <ctype.h>

/* 05/14/88 SRT - Initial coding
 *
 * Command mode for kermit. */

char
  *copy   = "copy",  *cwd    = "cwd",    *date    = "date",  *dir    = "dir",
  *delete = "del",   *renamecmd = "rename", *spaceXX = "free",  *typeXX = "list";

extern char c_buffer[];

#ifdef OSK
extern char **environ;
char *argv[] = { "shell", NULL, NULL };
int os9exec();
#endif
#ifndef KERMIT_HOST
int os9fork();
#endif

command()
{ char command[81], *v[40];
  FILE *input = stdin;
  struct sgbuf current, tmpsg;

  _gs_opt(0, &current);
  memcpy(&tmpsg, &insave, sizeof(tmpsg));

  if (tmpsg.sg_class == 0)
  { tmpsg.sg_kbich =
    tmpsg.sg_kbach = 0;
    _ss_opt(0, &tmpsg);
  }

  fputs("\n[Back at Local System]\n", stderr);
  while (TRUE)
  { fputs("\nKermit-09> ", stderr);
    fgets(command, 80, stdin);

    if (ferror(input) || feof(input))
    { clearerr(input);
      cleareof(input);
      continue;
    }

    if (command[0] == '!' || !strncmp(command, "push", 2))
    { _ss_opt(0, &insave);
#ifdef OSK
      if (os9exec(os9fork, argv[0], argv, environ, 0, 0) == (-1))
#else
      if (os9fork("shell", 1, "\n", 1, 1, 0) == (-1))
#endif
        printmsg("can't escape to shell.");
      else
        wait(0);
      _ss_opt(0, &tmpsg);
    }

    else if (!strncmp(command, "bye", 3))
    { strcpy(c_buffer, "F");
      client('G');
    }

    else if (!strncmp(command, "close session", 7))
    { if (session_log)
      { fclose(session_log);
        session_log = NULL;
      }
    }

    else if (!strncmp(command, copy, 3))
      doexec(copy, command);

    else if (!strncmp(command, cwd, 3))
    { if (vector(command, v) > 0 && chdir(*v) == -1)
        fprintf(stderr, "CWD failed with ERROR #%03d\n", errno);
    }

    else if (!strncmp(command, "connect", 1))
      break;

    else if (!strncmp(command, date, 3))
    { strcpy(command, "date t\n");
      doexec(date, command);
    }

    else if (!strncmp(command, "dial", 3))
    { if (vector(command, v) > 0)
      {  dial(*v);
         break;
      }
    }

    else if (!strncmp(command, dir, 3))
      doexec(dir, command);

    else if (!strncmp(command, delete, 3))
      doexec(delete, command);

    else if (!strncmp(command, "get", 3))
    { filecount = vector(command, v) - 1;
      if (filecount < 0)
      { fprintf(stderr, "Filenames required\n");
        continue;
      }

      fp = NULL;
      filelist = v;
      filnam = *filelist++;
      gflg = 1;
      client(0);
      gflg = 0;
    }

    else if (!strncmp(command, "help", 3) || command[0] == '?')
    { fprintf(stderr,"  !         bye      close    connect\n");
      fprintf(stderr,"  copy      cwd      date     dial\n");
      fprintf(stderr,"  dir       debug    delete   get\n");
      fprintf(stderr,"  image     help     log      quit\n");
      fprintf(stderr,"  receive   rename   remote   send\n");
      fprintf(stderr," *set       space   *take     type\n");
    }

    else if (!strncmp(command, "image", 3))
    { image = !image;
      fprintf(stderr, "Image mode is %s\n", image ? "on" : "off");
    }

    else if (!strncmp(command, "log session", 5))
    { if (session_log)
      { fprintf(stderr,"Already logging session - must close this one\n");
        continue;
      }
      else
      { if (vector(command,v) < 1)
          v[1] = "session.log";

        if ((session_log = fopen(v[1], "w")) == NULL)
          fprintf(stderr,"Can't open '%s'\n",v[1]);
      }
    }

    else if (!strncmp(command, "quit", 3))
    { _ss_opt(0, &current);
      return (-1);
    }

    else if (!strncmp(command, "receive", 3))
       printmsg(recsw('R') == FALSE ? "Receive failed." : "done.");

    else if (!strncmp(command, renamecmd, 3))
      doexec(renamecmd, command);

    else if (!strncmp(command, "send", 3))
    { filecount = vector(command, v) - 1;
      if (filecount < 0)
      { fprintf(stderr, "Filenames required\n");
        continue;
      }
      fp = NULL;
      filelist = v;
      filnam = *filelist++;

      printmsg(sendsw() == FALSE ? "Send failed." : "done.");
    }

    else if (!strncmp(command, "set block-check", 5))
    { if (vector(command,v) > 1)
        bctr = atoi(v[1]);
    }

    else if (!strncmp(command, "set debug-level", 5))
    { if (vector(command,v) > 1)
        debug = atoi(v[1]);
    }

    else if (!strncmp(command, "space", 3))
      doexec(spaceXX, command);

    else if (!strncmp(command, "type", 3))
      doexec(typeXX, command);

    else if (!strncmp(command, "remote", 3))
    { int t = kflg;

      filecount = vector(command, v);
      filelist = v;
      doremote(filelist, filecount);

      kflg = t;
    }
    else
      fprintf(stderr, "Unknown command\n");
  }

  _ss_opt(0, &current);
  return(0);
}

doexec(a, b)
char *a, *b;
{ int status = 0, l;
  register char *c = b;

  while (*c != ' ' && *c != '\n')
    c++;
  if (*c == ' ')
    c++;
  l = strlen(c);

#ifdef DEBUG
  fprintf(stderr, "Module   ='%s'\n", a);
  fprintf(stderr, "Parameter='%s", c);
  fprintf(stderr, "Len      = %d\n", l);
#endif

  if ((os9fork(a, l, c, 0, 0, 0)) < 0)
  { fprintf(stderr, "%s could not be forked, ERROR #%03d\n", a, errno);
    return (0);
  }
  wait(&status);

  if (status)
    fprintf(stderr, "Command '%s' returned with ERROR #%03d\n", a, errno);

  return (0);
}

/* Turn a line into a vector of pointers.
 * similar to argc,argv.  Skip over first
 * one since it is the command.
 *
 * 05/15/88 Srt */
vector(s, p)
char *s, *p[];
{ register char *c = s;
  int i = 0;

  while (*c != ' ' && *c != '\n')
    c++;

  while (*c == ' ')
    c++;
  if (*c == '\n')
    return 0;

  p[i++] = c;

  while (*c != '\n')
  { if (*c == ' ')
    { *(c++) = '\0';
      while (*c == ' ')
        c++;
      if (*c != '\n')
        p[i++] = c;
    }
    else
      c++;
  }
  *c = '\0';
  p[i] = NULL;
  return (i);
}

doremote(v, count)
char **v;
int count;
{ register char *p;
  char code, temp[100];
  extern DIRECT char *bscan;
  int i, l, generic = 1, pos;

  if (count < 1)
    return(FALSE);

  p = *v++;

  if (!strncmp("command", p, 3))
  { if (count < 2)
      return(FALSE);
    generic = 0;
  }
  else if (!strncmp("copy", p, 3))
    code = 'K';
  else if (!strncmp("cwd", p, 2))
    code = 'C';
  else if (!strncmp("delete", p, 2))
    code = 'E';
  else if (!strncmp("directory", p, 2))
    code = 'D';
  else if (!strncmp("login", p, 1))
    code = 'I';
  else if (!strncmp("rename", p, 1))
    code = 'R';
  else if (!strncmp("space", p, 1))
    code = 'U';
  else if (!strncmp("type", p, 1))
    code = 'T';
  else
  { fprintf(stderr,"  command  copy       cwd\n");
    fprintf(stderr,"  delete   directory  login\n");
    fprintf(stderr,"  rename   space      type\n");
    return(FALSE);
  }

  if (count == 1)
  { temp[0] = code;
    temp[1] = tochar(0);
    temp[2] = '\0';
  }
  else
  { if (generic)
    { pos     = 1;
      temp[0] = code;
    }
    else
      pos = 0;

    for (i=1; i<count; i++)
    { l = strlen(*v);
      if (l+pos > 94)
      { fprintf(stderr,"Argument list too long, for remote command!\n");
        return(FALSE);
      }
      if (generic)
        temp[pos++] = tochar(l);
      strcpy(&temp[pos], *v++);
      pos += l;
      if (!generic)
        temp[pos++] = ' ';
    }

    if (!generic)
      temp[pos-1] = '\0';
  }

  /* BUG--Handle repeat counts ++SrT */
  for (p=temp, bscan=c_buffer; *p; p++)
    encode(1, *p);

  if (strlen(c_buffer) > 90)
  { fprintf(stderr,"Argument list too long for remote command!\n");
    return(FALSE);
  }

  return(client(generic ? 'G': 'C'));
}

dial(c)
   char *c;
{
   FILE *numbers;
   char *ptr, line[80];

   if (isdigit(*c))
   {
      write(ttyfd, "ATDT", 4);   /* ATM0D? */
      write(ttyfd, c, strlen(c));
      write(ttyfd, "\n", 1);
   }
   else
   {
      if ((numbers = fopen("/dd/sys/numbers", "r")) == NULL)
         if ((numbers = fopen("/d0/sys/numbers", "r")) == NULL)
            /* Error -- could not find the numbers file */
            return 0;
      while (fgets(line, 80, numbers) != NULL)
      {
         if (!strncmp(line, c, 3))  /* Only unique to the first 3 chars? */
         {
            for (c = line; *c != ',' && *c != '\n'; c++)
               ;
            if (*c == ',')
               c++;
            write(ttyfd, "ATDT", 4);  /* ATM0D? */
            write(ttyfd, c, strlen(c));
            write(ttyfd, "\n", 1);
            fclose(numbers);
            return 0;
         }
      }
      fclose(numbers);
      /* Error -- could not find the system in the numbers file */
   }
}
