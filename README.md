# NitrOS-9 Applications

This repository contains applications and application suites for NitrOS-9:

- [cpm](cpm/README.md) — CP/M emulator and its packaged software collection
- [deskmate3](deskmate3/README.md) — DeskMate 3 application disk
- [ed](ed/README.md) — OS-9 Level One port of the Unix `ed` editor
- [kermit](kermit/README.md) — OS-9 Kermit 21.5, public-domain file transfer over a serial line
- [kreider](kreider/README.md) — Carl Kreider's public-domain C tools: `uniq`, `cb`, `ppc`, `dgrep` and `lb`
- [mroff](mroff/README.md) — Mark Griffith's `mroff` text formatter and `man` reader, with the Kreider C library manual pages
- [multivue](multivue/README.md) — Multi-Vue graphical environment and applications
- [os9l2bbs](os9l2bbs/README.md) — OS-9 Level 2 BBS package
- [sort](sort/README.md) — a text sort with no limit on the number of lines, using temporary files
- [uemacs](uemacs/README.md) — MicroEMACS port for OS-9
- [uucpbb](uucpbb/README.md) — UUCPbb communications package

## Building

A neighboring NitrOS-9 checkout is used by default:

```sh
make
```

Set `NITROS9DIR` when the NitrOS-9 checkout is elsewhere:

```sh
make NITROS9DIR=/path/to/nitros9
```

C source builds require the C3 host tools and LWTOOLS on `PATH`, with
`C3BASE` pointing to the C3 headers and runtime installation. Assembly builds
use LWASM; disk packaging also needs ToolShed's `os9` command. Kermit and UUCPbb
additionally support CMOC and LLVM; see each application's README for its
compiler selection and dependencies.

The default target builds each active application and the disk images for
packages that provide them. Use `make clean` to remove generated commands and
disk images. Most disk builds require the corresponding NitrOS-9 modules and
commands to have been built first.

## Source and licensing

These packages were migrated from the NitrOS-9 `3rdparty/packages` tree.
They retain their original source notices, documentation, and licensing
terms. No repository-wide license is asserted over packages that do not
already include one.
