*  makefile for man on the Pico-Thing, built with make and cc1
*
*  man calls getopt and strnucmp, which are in KLibc rather than the
*  Microware library, so build KLibc in ../KLIBC first.  cc1 always links
*  the Microware library, so man is linked with rlink, which writes it to
*  the execution directory and cuts a -l path at 15 characters.  cc1 -r
*  leaves man.r here.
CC = cc1

man: man.r
  rlink ../KLIBC/sys.a/rels/cstart.r man.r -l=../KLIBC/clib.l -l=/dd/lib/sys.l -o=man
