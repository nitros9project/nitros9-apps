*  makefile for ppc, built on OS-9 with cc1
*
*  cc1 writes the program to the execution directory.
CC = cc1

ppc: ppc.r
  cc1 ppc.r -f=ppc
