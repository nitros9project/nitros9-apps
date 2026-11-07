include $(NITROS9DIR)/rules.mak

CFLAGS += -y -q

RFILES = amatch.r append.r bitmap.r catsub.r ckglob.r deflt.r del.r docmd.r \
	dodash.r doglob.r doprnt.r doread.r dowrite.r ed.r egets.r esc.r \
	find.r getfn.r getlst.r getnum.r getone.r getpat.r getptr.r getrhs.r \
	gettxt.r ins.r join.r makepat.r maksub.r matchs.r move.r omatch.r \
	optpat.r set.r setbuf.r subst.r unmkpat.r

# c3 -r compiles x.c to x.r
%.r: %.c
	$(CC) $(CFLAGS) $< -r

all: ed

ed: $(RFILES)
	$(CC) $(RFILES) -f=$@

$(RFILES): ed.h tools.h

clean:
	$(RM) $(RFILES) ed
