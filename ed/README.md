# ed

The Unix `ed` line editor, ported from Minix to OS-9 Level One.
It fits the Level One memory space, does not depend on terminal control
sequences, and can read editing instructions from a script.

## Building

From this directory, cross-build with C3:

```sh
make NITROS9DIR=/path/to/nitros9
```

C3 and LWTOOLS must be on `PATH`; set `C3BASE` to the C3 installation.
The result is the OS-9 command `ed`. Run `make clean` to remove build outputs.

On OS-9, use the preserved native build:

```sh
make -f os9.mak
```

Without Make, run the supplied procedures:

```text
shell compile
shell makelib
shell makeed
```

## VBCC builds

This package also supports `make vbcc` using the shared 6809 VBCC build
configuration. See [VBCC setup, local toolchain fixes, validation limits and
module sizes](../build-support/vbcc/README.md). Outputs are in
`build/out/vbcc/Os/`.
