*  makefile for cb, built on OS-9 with cc1
*
*  cc1 writes the program to the execution directory.
CC = cc1

cb: cb.r
  cc1 cb.r -f=cb
