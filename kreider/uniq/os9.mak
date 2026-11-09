*  makefile for uniq, built on OS-9 with cc1
*
*  cc1 writes the program to the execution directory.
uniq: uniq.c
  cc1 uniq.c -f=uniq
