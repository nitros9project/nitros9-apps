ifndef NITROS9DIR
NITROS9DIR := $(abspath ../nitros9)
endif

NITROS9_APPS_DIR := $(CURDIR)

export NITROS9DIR
export NITROS9_APPS_DIR

include $(NITROS9DIR)/rules.mak

dirs = cpm deskmate3 multivue os9l2bbs uucpbb
legacydirs = ed uemacs
dskdirs = deskmate3 multivue os9l2bbs uucpbb

.PHONY: all clean dsk dskcopy dskclean info

all:
	$(foreach dir,$(dirs),$(MAKE) -C $(dir) &&) :

clean:
	$(foreach dir,$(dirs) $(legacydirs),$(MAKE) -C $(dir) clean &&) :

dsk:
	$(foreach dir,$(dskdirs),$(MAKE) -C $(dir) dsk &&) :

dskcopy:
	$(foreach dir,$(dskdirs),$(MAKE) -C $(dir) dskcopy &&) :

dskclean:
	$(foreach dir,$(dskdirs),$(MAKE) -C $(dir) dskclean &&) :

info:
	@$(foreach dir,$(dskdirs),$(MAKE) -C $(dir) info; $(ECHO);)
