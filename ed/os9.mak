*  makefile for ed on OS-9, built with make and cc1, which writes ed to
*  the execution directory
*
*  The line that links every object is too long for c.link, so most go in a
*  library.  c.link reads a library once, in order, so each member must
*  follow one that refers to it.  docmd.r and setbuf.r refer to members that
*  refer back to them, so no order works for them, and they are linked
*  directly instead.
CC = cc1

DIRECTR = docmd.r setbuf.r
LIB1 = subst.r set.r move.r join.r gettxt.r getrhs.r maksub.r getfn.r
LIB2 = dowrite.r doread.r egets.r doprnt.r doglob.r getlst.r getone.r
LIB3 = getnum.r find.r del.r ckglob.r optpat.r getpat.r makepat.r unmkpat.r
LIB4 = dodash.r esc.r matchs.r deflt.r catsub.r append.r ins.r getptr.r
LIB5 = amatch.r omatch.r bitmap.r
RFILES = ed.r $(DIRECTR) $(LIB1) $(LIB2) $(LIB3) $(LIB4) $(LIB5)

ed: $(RFILES)
  -del objs.l
  merge $(LIB1) >objs.1
  merge $(LIB2) >objs.2
  merge $(LIB3) >objs.3
  merge $(LIB4) >objs.4
  merge $(LIB5) >objs.5
  merge objs.1 objs.2 objs.3 objs.4 objs.5 >objs.l
  del objs.1 objs.2 objs.3 objs.4 objs.5
  cc1 ed.r $(DIRECTR) -l=objs.l -f=ed

$(RFILES): ed.h tools.h
