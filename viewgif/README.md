# ViewGIF 2.0 and ViewVEF

Vaughn Cato's GIF viewer for the Color Computer 3 running OS-9 Level 2 or
NitrOS-9 Level 2. ViewGIF converts GIF images to the CoCo palette, with optional
dithering and alternating screens. ViewVEF displays its saved VEF images.

## Build

Run from this directory:

```sh
make COMPILER=c3
make COMPILER=cmoc
make COMPILER=llvm
```

Each build produces `viewgif` and `viewvef` here, with isolated outputs and module
metadata under `build/out/<compiler>/<OPT>/`. The default LLVM optimization is
`Os`. Module headers, parity, CRC, embedded command names, and room for an 8 KiB
graphics-buffer mapping are checked.

- **C3:** put the cross compiler and its assembler/linker on `PATH`; set `C3BASE`
  to the C3 installation. `C3` overrides the driver. The local assembler adapter
  keeps large uninitialized tables out of the loaded module.
- **CMOC:** put `cmoc`, `lwasm`, and `lwlink` on `PATH`. Set `CMOC_OS9_DIR` to a
  built `nitros9-c-libs` checkout containing `include/` and `lib/libc.a`.
- **LLVM-MC6809:** set `LLVM_CC` to its Clang, `LLVM_SYSROOT` to the staged OS-9
  picolibc installation, and `LLVM_OS9_COMPAT_ROOT` to `nitros9-c-libs/llvm`.
  The build makes the compatibility archive, or uses `LLVM_OS9_COMPAT_LIB` if
  supplied. `OPT=Oz` compiles `setmap.c` at `Os` to avoid the current backend's
  PHANTOM_CARRY failure; this exception is recorded in the metadata.

These are OS-9/6809 commands, not host executables. Graphics require the CoCo 3
window driver, `/w`, and enough available memory for the program and screens.

## Use

```text
viewgif picture.gif -f
viewgif picture.gif -n -f -d -u=colors
viewgif picture.gif -f -v=picture.vef
viewvef picture.vef
```

`-f` disables alternating screens; `-n` disables display, `-d` disables dithering,
and `-u` records color usage. The original manuals are preserved as
[viewgif.doc](viewgif.doc) and [viewvef.doc](viewvef.doc).

The decoder supports GIF87a with a global color table, including interlacing.
It rejects GIF89a and local image color tables. It is not a modern animated-GIF
viewer. Display, palette conversion, flicker, and VEF output retain the original
CoCo-specific design; validation coverage is described below.

## Verification

`make test` uses a host C compiler to check exact decoded pixels for five
generated fixtures, including a 256-color image, an interlaced image, and
color bands that vary horizontally and vertically. It also checks ten decimal
option-parser cases. It also
checks rejection of truncated signatures, descriptors, palettes, and raster data.
The fixtures exercise LZW code-width growth and dictionary resets. The host
platform shim supplies no working graphics system calls.

`python3 tests/runtime.py --help` describes the OS-9 emulator test. Supply a
Pico-Thing boot disk, matching firmware, `usim09pt`, ToolShed `os9`, and the
compiler's module directory with `--modules build/out/cmoc/Os`, for example.
The test copies the boot disk, installs both commands in that scratch copy,
and checks color-usage output from four decode cases. It does not exercise
CoCo graphics or ViewVEF playback.

`python3 tests/graphics.py --help` describes the separate MAME check. Supply a
prepared CoCo 3 boot disk with CoWin, grfdrv, fonts and patterns initialized,
matching local ROMs, ToolShed `os9`, and a compiler's module directory. It drives
the commands at the interactive shell, checks the exported VEF palette and all
320 × 192 pixels exactly, and checks the visible color bars in both ViewGIF and ViewVEF snapshots.
It uses separate emulator boots for display and playback. Add `--flicker` to
check two different exported frames, their averaged colors, and live alternation
of both the displayed images and GIME video banks. The harness waits for steady
alternation after export before inspecting the files.
No boot image or ROM is distributed here.

## Module sizes

See [the size investigation](docs/sizes.md) for measured savings, linked-runtime
contributions, and reproduction commands. Builds retain maps for all compilers;
`python3 build/sizes.py` reports the current loaded-byte breakdown.

## Current validation

C3, CMOC and LLVM pass decoding, exact VEF export, visible display and playback,
and the separate alternating-screen test. LLVM needs the corrected native
register-copy loops in `nitros9-c-libs/llvm/src/native.S`: `LEAU` does not set the
zero flag, so both copy loops must explicitly compare U with zero. Without that
fix, returned X/Y values can remain unchanged and graphics writes use an invalid
buffer pointer. The correction is tracked in
[nitros9-c-libs PR #43](https://github.com/nitros9project/nitros9-c-libs/pull/43). A separate CoWin fix returns X/Y correctly when a get/put buffer
is mapped a second time; its runtime regression is in NitrOS-9's
`tests/cowin-mapgpb.c`, tracked in
[NitrOS-9 PR #521](https://github.com/nitros9project/nitros9/pull/521).

## Provenance and source terms

Imported the four C sources and two manuals from
[Microware's ViewGif_2_0.lzh archive](https://microware.com/index.php/os-9-archive-new/file/2633-os-9-archive).
The 30,992-byte archive has SHA-256
`9a0be6218ec942dbbc0854176adddf0e047e929bce87f45064ddca5df121ee99`.
The archived executable files were not imported. Line endings were normalized.

Copyright 1989 Vaughn Cato. The decoder also credits Ben Samit and Scott Hemphill.
The notice in `src/viewgif.c` permits reuse provided the resulting program's
source is freely available to the public and those three authors receive credit.
That notice is retained; the manual's public-domain wording does not replace it.

This import replaces embedded assembly with C and library system-call wrappers,
adds prototypes and build support, packs the LZW dictionary and palette tables
to fit the 6809 address space, and checks malformed input. Dithering uses a small
deterministic generator. Generated test fixtures are original test data.
