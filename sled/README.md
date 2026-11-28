# SLED 2.2

Mark Griffith's full-screen editor for the CoCo 3 running OS-9 Level II or
NitrOS-9 Level 2. SLED provides insert and overwrite modes, line and character
editing, search/replace, marked blocks, word wrap and automatic indentation.

Run `sled [filename [#lines]]` in a CoWin window at least 40 columns by 16 rows.
The editing area is capped at 80 by 24 characters. The editor keeps up to 1,000
screen lines in memory and supports reading and writing larger files in portions.
See the [original manual](docs/manual.txt) and [key reference](sled.hlp).

## Build

All application code is C. No archived executable or assembly source is used.
From this directory:

```sh
make c3
make cmoc
make llvm
```

Each target creates `sled` and retains the compiler-specific module, linker map,
validation record and logs in `build/out/<compiler>/Os/`. The builder validates
the OS-9 header, name, parity, CRC and initial process address-space requirement.

- **C3:** C3 and LWTOOLS on `PATH`; set `C3BASE` to the C3 installation. The build
  adapter preserves the line-pointer table as uninitialized data.
- **CMOC:** CMOC and LWTOOLS on `PATH`; set `CMOC_OS9_DIR` to a built
  `nitros9-c-libs` checkout containing `include/` and `lib/libc.a`.
- **LLVM:** set `LLVM_CC` to LLVM-MC6809's `clang`, `LLVM_SYSROOT` to an OS-9
  picolibc installation, and `LLVM_OS9_COMPAT_ROOT` to `nitros9-c-libs/llvm`.
  The builder builds its compatibility library unless `LLVM_OS9_COMPAT_LIB`
  specifies an existing one. Use a version containing the syscall-register
  snapshot fix from [nitros9-c-libs PR #43](https://github.com/nitros9project/nitros9-c-libs/pull/43).

`COMPILER` defaults to `c3`; `OPT` defaults to `Os` and affects LLVM. `make clean`
removes generated modules and test output.

## Editing and saving

Arrow keys move the cursor. F1 toggles insertion, Control-D deletes a character,
Control-A inserts a line, Control-K deletes a line, and Control-Q quits. At quit,
answer the save prompt, then confirm replacement of the original file. Without
an original filename, SLED asks for a destination.

Saves first collect output in a process-specific `sledtmp.*` file in the current
data directory. Existing recovery files are skipped. The complete temporary
copy is retained until the destination closes successfully. Replacement uses C
file I/O and works with absolute paths; it does not require a `rename` command.
Replacement is not atomic. After a failed save or interrupted replacement, keep
and inspect the temporary file before retrying.

This is an OS-9 text editor: saved records use carriage returns, tabs expand to
four-column stops, trailing spaces are trimmed, and an unterminated final record
receives a carriage return. It is not a binary-preserving editor.

## Validation

The emulator test edits a real file, exercises character and line insertion and
deletion, saves, reopens, modifies and discards. It compares the resulting file
bytes, including blank lines, a line longer than the screen, expanded tabs and
an unterminated final record. Screenshots preserve the editing, prompts,
reopened buffer and restored shell for inspection. A separate case saves a new
unnamed buffer to a supplied filename and checks writing a marked block to a
separate file.

```sh
make test COMPILER=c3 BOOT=/path/to/cowin-boot.dsk ROMS=/path/to/roms \
  MAME=/path/to/mame OS9=/path/to/toolshed/os9
```

The boot disk must start an interactive shell with CoWin and grfdrv available
and contain a `CMDS` directory. Tests modify a scratch copy, not the supplied disk.

Validated module sizes for this port (compiler versions and library builds can
change these):

| Compiler | Module bytes | Initial data bytes |
| --- | ---: | ---: |
| C3 | 22,330 | 6,925 |
| CMOC | 24,551 | 31,087 |
| LLVM `-Os` | 31,207 | 8,798 |

Initial data is the OS-9 header's memory request, including runtime reservations;
CMOC reserves heap space up front. It is separate from the module file size.

## Source and terms

Imported from `Sled_2_2` in the [Microware OS-9 archive](https://microware.com/index.php/os-9-archive-new/file/2584-os-9-archive).
The downloaded archive is 54,850 bytes, SHA-256
`4c187cf266534f55b06a362f5c019b55dea0d8154a68ad7915e462d293e4307b`.
The seven C files, definition header, manual, help and historical CC3IO patch
note were retained with normalized line endings. The archived binary was omitted.

The manual credits Richard Johnson's original editor and Mark Griffith's CoCo
adaptation. Griffith's version is **not public domain**. Its notice reads:

> (c) 1985, 1987, 1988
> All rights reserved by the author
>
> Copying for personal or educational benefit
> is allowed, but this program may not be
> sold individually or as part of a package,
> in whole or in part without the written
> consent of the authors.

The manual also expressly forbids sale or promotional use without written
consent. Preserve these terms; no broader license is asserted here.

The port adds ANSI declarations and shared OS-9/CoWin C wrappers, corrects
archived spelling and type errors, bounds prompt and word-wrap buffers, uses
byte-oriented keyboard input, and repairs current-line and end-of-file saving.
The [historical CC3IO note](docs/cc3io-note.txt) describes an old OS-9 patch;
it is not an instruction to patch a current NitrOS-9 installation.
