# Mark Griffith's mroff and man, cross-built with c3.
dirs = mroff man

.PHONY: all clean

all:
	$(foreach dir,$(dirs),$(MAKE) -C $(dir) &&) :

clean:
	$(foreach dir,$(dirs),$(MAKE) -C $(dir) clean &&) :
