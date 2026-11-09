*  makefile for lb, built on OS-9 with cc1
*
*  cc1 writes the program to the execution directory.
CC = cc1

lb: lb.r
  cc1 lb.r -f=lb
