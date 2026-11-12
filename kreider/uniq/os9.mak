*  makefile for uniq, built on OS-9 with cc1
*
*  cc1 writes the program to the execution directory.
CC = cc1

uniq: uniq.r
  cc1 uniq.r -f=uniq
