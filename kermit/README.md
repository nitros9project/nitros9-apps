# Kermit

OS-9/6809 Kermit, version 21 release 5 (1990), from the OS-9/6809 archive:
`TELECOM/Kermit_21_5.lzh`. It sends and receives text and binary files,
runs as a server or talks to one, and has a simple terminal mode. See
`kermit.doc` for its use.

It descends from Columbia University's UNIX Kermit (1981-1983); `os9ker.c`
lists its authors, the last of them James Jones and Simmule Turner. The
archive's `Read.Me`, by Eddie Kuns, says:

> Kermit is Public Domain.  Post this version of Kermit wherever you wish.
> Please, however, post the archive intact, with all files, full source, and
> documentation.

The sources and documentation are as archived, with CR line endings
converted to LF, apart from the archived program, `CMDS/kermit`, which is
not kept here. The OS-9/6809 makefile, `makefile` in the archive, is
`os9.mak` here, because `makefile` and `Makefile` are one name on macOS.
`makefile.68k` is the archive's makefile for OS-9/68000.

Kermit builds two ways:

    make             cross-build on a host with c3 (Makefile)
    make -f os9.mak  build on OS-9 with cc1; installed as the makefile
                     when the source is copied to a NitrOS-9 disk

## Changes from the archive

- `os9inc.h` defines `cleareof`, as c3's `stdio.h` does, when `stdio.h`
  has not; Microware's does not.
- `os9.mak` compiles with `cc1`, where it had `cc`, and links with `rlink`
  against KLibc, which has the terminal get/set status calls the Microware
  library lacks. It defines `LEVEL2`, which makes `time.h`'s ticks per
  second (`tps`) 100 rather than 10; Kermit's timeouts are counted in
  `tps`, and at 10 they last a fifth of their intended length on the
  Pico-Thing's 50-tick clock. The c3 build defines `COCO`, which makes
  c3's `tps` 60.
