*  makefile for dgrep (DECUS grep), built on OS-9 with cc1
*
*  It is named dgrep so it does not replace NitrOS-9's own grep.  cc1
*  writes the program to the execution directory.
CC = cc1

dgrep: grep.r
  cc1 grep.r -f=dgrep

grep.r: grep.h
