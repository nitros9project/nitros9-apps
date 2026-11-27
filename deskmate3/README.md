# DeskMate 3

DeskMate 3 applications and supporting files for the CoCo 3, packaged as a
bootable NitrOS-9 disk. The tree contains the desktop, text editor, paint,
terminal, calendar, cards, ledger, backup and disk utilities, plus help files
and sample data.

## Building

With LWTOOLS and ToolShed's `os9` command on `PATH`, run from this directory:

```sh
make NITROS9DIR=/path/to/nitros9
```

The build assembles the original 6809 code and creates `DeskMate3.dsk`.
It builds the required NitrOS-9 Level Two CoCo 3 modules through the neighboring
checkout's CoCo 3 recipe, using a 32-column terminal. Temporary OS modules
are kept under `.nitros9/`.

`make clean` removes the generated disk, listings, maps and temporary OS
modules. Existing source notices and package-specific redistribution terms
continue to apply; see the repository's [source and licensing notes](../README.md#source-and-licensing).
