# Walk 1.2

James Delaney's 1992 CoCo 3 OS-9 screen saver/demo. An animated character
walks around a graphics screen, gestures, and displays phrases.
Copyright (c) 1992 James Delaney. The original documentation states that
the program is distributed free of charge; the author retains copyright
to the control program and icons.

## Cross-build with c3

Requires a C-Cubed checkout and LWTOOLS (`lwasm`, `lwar`, `lwlink`) on PATH.
In the coco-shelf layout, c3 is found at `../../nitros9-languages/c3`.
Build its host tools and runtime once, then build Walk:

```sh
make -C ../../nitros9-languages/c3 runtime
make
```

For another layout, specify the c3 source directory:

```sh
make C3ROOT=/path/to/c3
```

The result is `build/walk`, an OS-9 module for the CoCo 3. Build artifacts
stay under `build/`. The bundled 1992 executable has been removed.
`make clean` removes generated files. The original native OS-9 makefile is
retained in `Makefile.os9`.

The host Makefile runs the in-tree preprocessor, single-pass compiler,
optimizer, assembly translator, assembler, and linker. It builds a small
support archive from c3's graphics, random-number, sleep, and Unix-time
library sources. `cross-defs.sed` supplies the additional OS-9 status codes.
`gpbuf.c` emits the get/put buffer commands using c3's current calling
convention; the older graphics library implementation expects stack arguments.
The original C sources have LF line endings, and shared buffer/file/character
declarations in `walkoth.c` now match their definitions in `walk.c`.

## Launch in MAME

```sh
make run
```

This builds a private NitrOS-9 Level 2 boot disk at
`build/emulator/walk.dsk`, boots a 512K CoCo 3 in MAME, loads the standard
fonts, and starts Walk automatically. `make disk` builds the disk without
launching it. All boot modules and disk files are built under `build/`.

Requires a neighboring NitrOS-9 checkout, ToolShed `os9`, MAME, and your
CoCo 3/FDC ROMs. Override paths as needed:

```sh
make run NITROS9DIR=/path/to/nitros9 MAME_ROM_PATH=/path/to/roms
```

`MAME` selects the emulator executable; `MAME_FLAGS` defaults to
`-window -skip_gameinfo -ramsize 512k`. The ROM directory defaults to
`~/.local/share/mame/roms`. MAME boots from floppy, so allow time for OS-9
to load. Press a key in the demo to exit to the shell.

## Run on NitrOS-9

```sh
make stage
```

This stages the rebuilt command and its graphics as:

```text
build/dist/CMDS/walk
build/dist/SYS/walk.ike
```

Copy these to the target's execution directory and `/dd/sys`, respectively.
When using ToolShed to copy to a disk image, set the command's execute
attributes after copying:

```sh
os9 copy -r build/dist/CMDS/walk disk.dsk,CMDS/walk
os9 attr -e -pe disk.dsk,CMDS/walk
os9 copy -r build/dist/SYS/walk.ike disk.dsk,SYS/walk.ike
```

The destination directories must already exist. Run `walk` from a CoCo 3
OS-9 Level 2 graphics-capable window. It looks for its icons in the current
directory, `/dd/gfx/walk.ike`, then `/dd/sys/walk.ike`.
Keys `m`/`h`, `t`, `r`, `l`, `w`, and `b` trigger actions; another key exits.

The rebuilt executable has been booted in MAME, with animation and text
verified in screen captures. It has not been tested on physical hardware.

## Origin

Downloaded from the Microware OS-9 archive as
[Walk_1_2_ScreenSaver.lzh](https://microware.com/index.php/os-9-archive-new/file/2638-os-9-archive).
No new license is asserted over the original source or icon data.
