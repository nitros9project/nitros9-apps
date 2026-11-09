*  makefile for ppc, built on OS-9 with cc1
*
*  cc1 writes the program to the execution directory.
ppc: ppc.c
  cc1 ppc.c -f=ppc
