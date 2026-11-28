# Kermit

OS-9/6809 Kermit, version 21 release 5 (1990), from the OS-9/6809 archive
`TELECOM/Kermit_21_5.lzh`. It sends and receives text and binary files,
operates as a server or client, and provides a serial terminal mode.
See [kermit.doc](kermit.doc) for commands and usage.

It descends from Columbia University's UNIX Kermit (1981–1983);
[os9ker.c](os9ker.c) lists its authors, including James Jones and Simmule
Turner. The [original release notes](ARCHIVE-NOTES.md), by Eddie Kuns, say:

> Kermit is Public Domain. Post this version of Kermit wherever you wish.
> Please, however, post the archive intact, with all files, full source, and
> documentation.

## Host builds

Run from this directory with the selected toolchain on `PATH`:

```sh
make COMPILER=c3
make COMPILER=cmoc
make COMPILER=llvm
```

C3 is the default. Each build validates the OS-9 module's length, parity,
program type, CRC and embedded command name before installing it as `kermit`.
Separate outputs and logs are retained in `build/out/<compiler>/<OPT>/`.
Do not run builds of the same output configuration concurrently; builds
that install the root `kermit` command should also run one at a time.

| Compiler | Requirements and settings |
| --- | --- |
| C3 | C3 host tools and LWTOOLS; `C3BASE` points to the C3 headers/runtime installation. Override the driver with `C3`. |
| CMOC | CMOC with K&R compatibility and LWTOOLS; `CMOC_OS9_DIR` points to a built `nitros9-c-libs` checkout. Override the driver with `CMOC`. |
| LLVM | LLVM-MC6809 and OS-9 picolibc; set `LLVM_CC`, `LLVM_SYSROOT` and `LLVM_OS9_COMPAT_ROOT` (the `nitros9-c-libs/llvm` directory). |

For LLVM, the compatibility library is built from source with `JOBS=8` by
default. To use an already built archive, also set `LLVM_OS9_COMPAT_LIB`.
The headers must match that archive. `OPT=Os` is the default; LLVM also accepts
`OPT=Oz` and the numbered optimization levels. C3 and CMOC use their default
optimization settings; `OPT` does not change their compiler flags.

The modern host builds use `TICKS=60` for serial timeouts. Set `TICKS=50`
for a system whose clock runs at 50 ticks per second. The wire protocol's
end-of-line byte is explicitly CR, independent of the compiler's C newline. CMOC requests an additional 4 KiB of stack
space; actual stack requirements still need runtime validation.

```sh
make test   # Host tests for message formatting and bounded output
make clean  # Remove generated commands, objects, logs and metadata
```

Successful compilation and module validation do not establish runtime
correctness. Serial transfers, terminal restoration, shell spawning and
signal-driven timeout recovery still need execution on OS-9 with each ABI.

## Native OS-9 builds

The preserved native build remains available:

```text
make -f os9.mak
```

It uses `cc1` and `rlink` with KLibc, which provides terminal status calls
missing from the Microware library. The archive's OS-9/6809 `makefile` is
named [os9.mak](os9.mak) here because `makefile` and `Makefile` collide on
case-insensitive filesystems. [makefile.68k](makefile.68k) is the historical
OS-9/68000 build. These native paths have not been revalidated by the host
compiler checks.

## Changes from the archive

CR line endings were converted to LF; the archived `CMDS/kermit` executable
is not retained. Original release notes are preserved in
[ARCHIVE-NOTES.md](ARCHIVE-NOTES.md).

Host portability changes include standard declarations, removal of
compiler-specific direct-page qualifiers for CMOC/LLVM, explicit non-local
jump return values, standard octal LF escapes, portable stream error
clearing, and distinct names for globals that conflict with standard C
functions. The CMOC/LLVM message functions use real variadic arguments and
a bounded formatter for Kermit's `%s`, `%d`, `%03d` and `%%` messages.
The legacy C3/native message implementations remain available.

The existing native `os9.mak` selects `cc1`, `rlink` and KLibc and defines
`LEVEL2` for the historical library's timeout convention.

## VBCC builds

This package also supports `make vbcc` using the shared 6809 VBCC build
configuration. See [VBCC setup, local toolchain fixes, validation limits and
module sizes](../build-support/vbcc/README.md). Outputs are in
`build/out/vbcc/Os/`.
