*  makefile for lb, built on OS-9 with cc1
*
*  cc1 writes the program to the execution directory.
lb: lb.c
  cc1 lb.c -f=lb
