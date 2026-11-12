# Carl Kreider's public-domain C tools, cross-built with c3.
dirs = uniq cb ppc dgrep lb

.PHONY: all clean

all:
	$(foreach dir,$(dirs),$(MAKE) -C $(dir) &&) :

clean:
	$(foreach dir,$(dirs),$(MAKE) -C $(dir) clean &&) :
