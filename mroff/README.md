# mroff, man and the Kreider C library manual

Mark Griffith's 1990 package of documentation for Carl Kreider's C library
(KLibc, in `nitros9-languages/ccompiler/klibc`), from the OS-9/6809 archive:
`PROG/Unpacked/SRC/CLib_Krieder_91_doc.lzh`. CR line endings are converted
to LF. Each file was first committed as archived, and every later change is
in a commit of its own. Griffith's [original notes](ARCHIVE-NOTES.md) and `NOTICE` describe the
package as he released it.

None of the files carries a copyright or licence notice.

| Directory | Contents |
|-----------|----------|
| `mroff`   | `mroff`, an nroff-like text formatter adapted from Kernighan and Plauger's *Software Tools*, with its manual, `mroff.mdoc` |
| `man`     | `man`, an on-line manual reader by Pete Lyall, reworked by Griffith |
| `clib`    | mroff sources for 106 KLibc pages, the `header` macros they include, `make.mans`, the print scripts, and `man.index` and `man.help` |

`mroff` and `man` each build two ways:

```sh
make NITROS9DIR=/path/to/nitros9  # Cross-build with C3
make -f os9.mak                 # Native OS-9 build with cc1 and KLibc
```

C3 and LWTOOLS must be on `PATH`; set `C3BASE` to the C3 installation.
`os9.mak` is installed as the makefile when sources are copied to a NitrOS-9 disk.

## Where man looks

`man name` shows the first of:

1. `/dd/defs/name`, a header file;
2. `/dd/text/help/name`, a help file;
3. `/dd/text/docs/name.docs` (plain text) or `name.mdoc` (mroff source);
4. `/dd/text/man/name.man` (formatted) or `name.mman` (mroff source);
5. `/dd/text/clib/man/name.man`, a formatted KLibc page, or the page
   `man.index` names for it (so `man rindex` finds `strings.man`).

`man -k word` lists the KLibc pages whose one-line summary in `man.help`
contains `word`. Pages go through `more`; `-f` uses `list` instead.

## Formatting the KLibc pages

The KLibc pages are shipped as mroff sources and formatted once, on the
target:

    chd /dd/text/clib
    make.mans

which writes each formatted page to `/dd/text/clib/man`. `printdocs`
prints the whole manual on `/p` instead.

## Changes from the archive

- `mroff` includes `sgstat.h`, where it had Griffith's own `scfstat.h`, and
  copies the terminal options as a whole.
- `mroff` and `man` define `TRUE` and `FALSE`.
- `man` looks under `/dd/text` where it had `/h1/misc`, and lists a page found
  through the index, where it formatted it a second time.
- `make.mans` does not format `sleep.txt` and `system.txt`, which are not in
  the archive, and runs mroff from the execution directory where it loaded
  it first, so a failed `load` no longer stops the script.
- `os9.mak` replaces mroff's archived makefile and links with `rlink`
  against KLibc.
