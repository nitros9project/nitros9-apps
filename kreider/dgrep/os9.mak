*  makefile for dgrep (DECUS grep), built on OS-9 with cc1
*
*  It is named dgrep so it does not replace NitrOS-9's own grep.  cc1
*  writes the program to the execution directory.
dgrep: grep.c grep.h
  cc1 grep.c -f=dgrep
