ifndef NITROS9DIR
NITROS9DIR := $(abspath ../nitros9)
endif

NITROS9_APPS_DIR := $(CURDIR)

export NITROS9DIR
export NITROS9_APPS_DIR

include $(NITROS9DIR)/rules.mak

dirs = cpm deskmate3 multivue os9l2bbs uucpbb
legacydirs = ed uemacs

.PHONY: all clean

all:
	$(foreach dir,$(dirs),$(MAKE) -C $(dir) &&) :

clean:
	$(foreach dir,$(dirs) $(legacydirs),$(MAKE) -C $(dir) clean &&) :
