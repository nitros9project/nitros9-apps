# Carl Kreider's C tools for OS-9

Small C programs that Carl Kreider wrote, or converted to Microware C, and
placed in the public domain in the 1980s.  They come from the OS-9/6809
archive, with CR line endings converted to LF and otherwise as archived.
Each keeps its original notice; the archive path and that notice follow.

Each directory builds two ways:

```sh
make NITROS9DIR=/path/to/nitros9  # Cross-build with C3
make -f os9.mak                 # Native OS-9 build with cc1
```

C3 and LWTOOLS must be on `PATH`; set `C3BASE` to the C3 installation.
Run `make` here to build all five tools, or in an individual tool directory.
`make clean` removes generated commands and objects.

`os9.mak` is installed as the makefile when the source is copied to a
NitrOS-9 disk.

## uniq

Report or remove repeated adjacent lines.

Source archive: `APPS/Unpacked/SRC/uniq.lzh (uniq.c, uniq.doc)`.

> "Adapted for BDS C by Jeff Martin ... Converted to MW C by Carl
> Kreider and returned to the public domain"

## cb

C beautifier: re-indents C source.

Source archive: `PROG/Unpacked/SRC/cb_C_Beautifier.lzh (cb.c)`.

> "From the CIPG's UNIX system and modified to run under BDS C by
> William C. Colley, III / Released to the public domain via CUG ...
> Fixed to work with MW C and put back in the public domain by Carl
> Kreider 7-1-84"

## ppc

Lists a C file with page breaks and line numbers.

Source archive: `PROG/Unpacked/SRC/ppc_PrettyPrintC.lzh (ppc.c)`.

> "Modified and put back in the public domain by Carl Kreider"

## dgrep

Grep with regular expressions (DECUS grep); named dgrep so it does
not replace NitrOS-9's own grep.

Source archive: `APPS/Unpacked/SRC/grep.lzh (grep.c, grep.h, grep.hlp)`.

> "Copyright (C) 1980, DECUS / Converted for the Software Toolworks
> C/80 Version 2.0 compiler and Copyright 1983 William G. Hutchison,
> Jr. ... Converted to MW C and placed back in the public domain By:
> Carl Kreider"

## lb

Splits a ROF library such as clib.l into its modules, X.<name>.r,
and lists their names in modlist, so the library can be changed
and merged again.

Source archive: `PROG/Unpacked/SRC/lb_C_Lib_splitter.lzh (lb.c)`.

> "copyright 1984 by Carl R. Kreider / released to the public domain
> for non-commercial use"
