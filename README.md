# NitrOS-9 Applications

This repository contains applications and application suites for NitrOS-9:

- `cpm` — CP/M emulator and its packaged software collection
- `deskmate3` — DeskMate 3 application disk
- `ed` — OS-9 Level One port of the Unix `ed` editor
- `kermit` — OS-9 Kermit 21.5, public-domain file transfer over a serial line
- `kreider` — Carl Kreider's public-domain C tools: `uniq`, `cb`, `ppc`, `dgrep` and `lb`
- `mroff` — Mark Griffith's `mroff` text formatter and `man` reader, with the Kreider C library manual pages
- `multivue` — Multi-Vue graphical environment and applications
- `os9l2bbs` — OS-9 Level 2 BBS package
- `uemacs` — MicroEMACS port for OS-9
- `uucpbb` — UUCPbb communications package

## Building

A neighboring NitrOS-9 checkout is used by default:

```sh
make
```

Set `NITROS9DIR` when the NitrOS-9 checkout is elsewhere:

```sh
make NITROS9DIR=/path/to/nitros9
```

The default target builds each active application and the disk images for
packages that provide them. Use `make clean` to remove generated commands and
disk images. Most disk builds require the corresponding NitrOS-9 modules and
commands to have been built first.

## Source and licensing

These packages were migrated from the NitrOS-9 `3rdparty/packages` tree.
They retain their original source notices, documentation, and licensing
terms. No repository-wide license is asserted over packages that do not
already include one.
