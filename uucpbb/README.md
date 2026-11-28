# UUCPbb for OS-9


Build the 24 C commands from `src/` with one of three host toolchains:

```sh
make -C uucpbb commands COMPILER=c3
make -C uucpbb commands COMPILER=cmoc
make -C uucpbb commands COMPILER=llvm
```

Run these from the `nitros9-apps` directory. C3 is the default. To build a
single command, add `TARGET=whoami` (or another command name) to a `commands`
build. The default `make -C uucpbb` target builds release disks with C3,
preserving the parent application build's disk-generation behavior.

| Compiler | Requirements | Output |
| --- | --- | --- |
| C3 | C3 host tools, LWTOOLS, C3 headers and runtime libraries | `build/out/c3/` |
| CMOC | CMOC with K&R support, LWTOOLS, `nitros9-c-libs` CMOC library | `build/out/cmoc/` |
| LLVM | LLVM-MC6809, OS-9 picolibc sysroot, OS-9 compatibility library | `build-llvm/out/Os/` |

The build finds sibling `coco-shelf/bin`, `nitros9-languages/c3`, and
`nitros9-c-libs` installations by default. Set `C3`, `C3BASE`, `CMOC`, or
`CMOC_OS9_DIR` to override them. An existing `C3BASE` environment variable
must point to a valid C3 installation containing `defs/stdio.h`.
For LLVM, set `LLVM_CC`, `LLVM_SYSROOT`, and `LLVM_OS9_COMPAT_ROOT` as needed;
see [the LLVM build notes](build-llvm/README.md). LLVM also accepts `OPT=Oz`
and `JOBS=8`.

Source compatibility patches are applied to disposable build copies. The
CMOC patch incorporates the existing UUCPbb port from `nitros9-c-libs`,
including its shared declarations and OS-9 library adaptations. The C3 patch
adapts the legacy time structures to the current C3 headers. CMOC assembly
branch overflows are retried with long conditional branches. Build logs are
kept beside the output modules in `logs/`. Do not run two builds of the same
compiler/output configuration concurrently.

Every successful command must pass OS-9 module length, header parity, type,
and CRC checks. Passing these checks does not establish runtime correctness;
mail, news, modem, process, and terminal operations still require OS-9 testing.

### Release disks

```sh
make -C uucpbb dsk COMPILER=c3
make -C uucpbb dsk COMPILER=cmoc
make -C uucpbb dsk COMPILER=llvm
```

Disk creation additionally needs NitrOS-9 definitions (`NITROS9DIR`), LWASM,
and ToolShed's `os9` command on `PATH`. It requires a full build (`TARGET=all`).
The historical `uucpbb21_6809.dsk` and `uucpbb21_6309.dsk` names are retained;
both contain the selected compiler's 6809-compatible modules. These are not
separate 6309-optimized builds. Changing compilers rebuilds both images.
Run disk builds one at a time because they share these image names.

Commands are installed in `UUCP/CMDS_WIN`. These C builds use the OS-9 window
interface; the old preassembled termcap distribution is no longer packaged.
The assembly byte dumps in `cmds_6809` and `cmds_6309` have been removed.
The handwritten timesharing monitor is retained once as
[native/uumon.asm](native/uumon.asm) and assembled for disk packaging.

`make -C uucpbb clean` removes generated commands and disks.

## Original distribution notes

Documentation and sample files for the OS-9 UUCP package, UUCPbb
Copyright (C) 1990, 1993  Rick Adams and Bob Billson

This file is part of the OS-9 UUCP package, UUCPbb.

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

The author of UUCPbb, Bob Billson, can be contacted at:
bob@kc2wz.bubble.org  or  uunet!kc2wz!bob  or  by snail mail:
21 Bates Way, Westfield, NJ 07090

## Documentation and configuration

The [copying](copying) file contains the GNU General Public License.

The [doc](doc/) directory contains both doc and man pages files for the UUCPbb
package.  These files are formatted, ready-to-print on standard 8 1/2 x 11
inch paper, 66 lines per page.  There are no printer control codes embedded
in any of the files.

Please READ the documentation.  It will, I hope, make installing the program
easy.  If you find mistakes or unclear areas in the docs, please let me know.
I don't like documentation that is unclear.  While I am not a writer by
profession, I would like to make the files as useful as possible.  If they
are unclear, they are not very useful.

The [sample_config](sample_config/) directory contains various files which go in `/DD/SYS/UUCP` when
you are instructed to copy them there.  You should edit these files to
conform to YOUR system.  The file [uucpbb.doc](doc/uucpbb.doc) will explain what to change.
Each file contains an explanation of the file's contents.  It is not necessary
to delete this information after you finish installing UUCP.

## Historical companion archives

The original distribution included a `MISC` directory with the following archives.
These archives are not included in this checkout.

### SCF14.AR

Boisy Pitre's patch for OS-9/6809 Level 2 to allow SCF devices
to be made non-shareable.  Instructions for applying the patch are contained
in the archive.

### MCRON12.LZH

Boisy Pitre's multi-user version of CRON for OS-9/6809.
Instructions are contained in the archive.

### CONVERTPALM.LZH

Jeff Shepler's utility for use with his mailer, Palm.  If
you are running Palm with Rick's original UUCP on the CoCo, use this utility
to convert Palm's mail to the new form used by UUCPbb.

### UUTOOLS.LZH

A version of uuencode and uudecode which allows large files to
split into smaller files.  Many UUCP will reject mail files larger than about
100K.  UUE (uuencode) makes it easier to send a large file in smaller pieces.
UUD (uudecode) allows you to put these pieces back together and decode them
without a lot of hassles.  Only the OS-9/6809 executables are in this file.
Put these in your execution directory with names uue and uud.

### UUTOOLS_SRC.LZH

The source for UUE and UUD.  It includes makefiles for
the OS-9/6809 and OSK versions.  Put the executables in your execution
directory with the names uue and uud.

### CM.LZH

A mail monitor for use with UUCPbb under OSK.  It runs in the
background and checks for new mail at regular intervals.  This utility
was contributed by Boisy.  Questions or suggestions about it should be
sent to him.

### DESKTOP.LZH

Contributed by Boisy. The archive contains some AIF/icon
files for a particular GUI on the MM/1 called Desktop.

## VBCC builds

This package also supports `make vbcc` using the shared 6809 VBCC build
configuration. See [VBCC setup, local toolchain fixes, validation limits and
module sizes](../build-support/vbcc/README.md). Outputs are in
`build/out/vbcc/Os/`.
