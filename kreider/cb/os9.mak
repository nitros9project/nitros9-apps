*  makefile for cb, built on OS-9 with cc1
*
*  cc1 writes the program to the execution directory.
cb: cb.c
  cc1 cb.c -f=cb
