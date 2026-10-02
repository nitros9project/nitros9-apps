# UUCPbb LLVM builds for OS-9/6809

From uucpbb:

```sh
make -C build-llvm                   # attempt all 24 C commands at -Os
make -C build-llvm OPT=Oz
make -C build-llvm TARGET=uuencode    # one command
make -C build-llvm targets
make -C build-llvm sizes
```

The harness builds original `src/` files in fresh copies under `out/<OPT>/src/`.
Successful modules, linker maps, metadata and detailed compile/link logs live
under `out/<OPT>/`. `results.csv` includes both successful sizes and BUILDFAIL
rows. A build returns nonzero if any requested target fails. Other targets
continue and their valid modules are retained. Rebuilding a selected target
removes its earlier binary and measurements before attempting the new link.
Do not run two builds with the same OPT concurrently; source/object copies are
shared within that optimization directory. Different optimization directories
are independent. Run `make sizes` after concurrent builds.

LLVM defaults to `llvm-mc6809/build/bin/clang` and the OS-9 sysroot to
`picolibc/builddir-mc6809-os9-Os/stage/usr/local`, under the Projects directory
containing coco-shelf. Override using exported variables or make variables:

```sh
make -C build-llvm LLVM_CC=/path/to/clang LLVM_SYSROOT=/path/to/os9/sysroot
```

UUCPBB_SOURCE optionally overrides the parent uucpbb directory. JOBS controls
parallel object compilation (default 8). OPT accepts O0, O1, O2, O3, Os, Oz.
The sysroot must contain OS-9 picolibc headers, libc.a and libos9.a. Changing
OPT changes UUCPbb's compilation, not the sysroot's library optimization.

## Current port coverage

All 24 C commands build at both -Os and -Oz with the LLVM OS-9 compatibility
library installed. Both full builds return success, and all 48 modules pass
header, size, parity, 6809 program-type and CRC validation. These are build
results, not OS-9 functional-test results: process, pipe, terminal/window,
modem and UUCP configuration behavior still needs execution on a booted system.
The original terminal/window build variants and assembly-only uumon are outside
this harness; it does not generate release disk images.

`targets.json` records the original src/Makefile dependencies, plus pwent.c
for uulog, uuxqt, rnews, expire and fileserv. Those commands use the legacy
password API, which picolibc does not supply. Keep the manifest synchronized
when the original dependencies change.

The current compiler triggers its PHANTOM_CARRY invariant assertion in
`wtdata`, `rdpacket` and `g_chksum` in gproto.c, and in `genseq` at -Oz.
The disposable patch marks only those functions `optnone,noinline` (genseq
only for -Oz); the remaining code uses the requested optimization. The
compiler guard remains enabled. These explicit workarounds are included in
the recorded source patch and flags, so the results are not pure -Os/-Oz
comparisons for those commands.

## Compatibility and measurements

`patches/llvm.patch` adapts only the disposable source copy: it removes legacy
compiler qualifiers and obsolete declarations, renames symbols that conflict
with modern libc, fixes time_t pointer types, uses picolibc directory entries,
and corrects several invalid calls and format arguments. Float/long printf
initialization calls are removed because picolibc supplies formatting directly.
All original sources, build files, documentation and distributions stay unchanged.

The local compat/ archive contains real OS-9 path, status, process, module and
pipe adapters, plus string, password-CRC and pattern helpers. System calls use
LLVM register constraints; assembly stubs preserve the per-process U register
where the kernel consumes it. The signal trampoline also preserves LLVM's
24-byte virtual-register area before calling a C handler. Compile-time layout
checks protect the assembly argument blocks and OS-9 descriptor/options packets.
Function/data sections and linker garbage collection discard unused helpers.

Clock conversion treats the OS-9 packet as wall-clock time without a timezone
database. UUCPbb's Parameters timezone remains the RFC date label. This avoids
pulling the host-style DST machinery into every command and brings mailx below
the OS-9 module size limit. The original 16-KiB heap request and 2-KiB stack
settings are retained; actual available memory and behavior need OS-9 tests.

The password reader uses POSIX O_RDONLY and appends a NUL after readln. The
legacy header directory is a fallback and cannot override picolibc's standard
headers. No dummy system-operation implementations are used.

Successful modules must pass sync-byte, length, header-parity, 6809 program-type
and CRC checks before a size is reported. Metadata references an immutable
build context with compiler/version, source hashes, library/runtime hashes,
flags and compatibility hashes. `make sizes` revalidates binaries and context
hashes before writing the CSV. Module bytes include the OS-9 header and CRC;
data bytes are the header's requested data area, not total runtime memory.
Compare equivalent stack/heap and library settings, and run the same real OS-9
functional tests before using these measurements to select a compiler setting.

Commit only the harness files. Generated out/ and results.csv are ignored.

## LLVM OS-9 compatibility library

The llvm-os9 branch of cmoc_os9 provides getuid, asetuid and readln adapters.
When `Projects/cmoc_os9/llvm` exists, the harness rebuilds and links its
`libcmoc_os9_compat.a` automatically under out/<OPT>/os9-compat, keeping
generated library files inside this build directory. Override its location when needed:

```sh
make -C build-llvm TARGET=whoami LLVM_OS9_COMPAT_ROOT=/path/to/cmoc_os9/llvm
```

The adapter uses LLVM-native system calls and picolibc headers. Its readln
converts a final OS-9 CR to C's LF; the password reader supplies the NUL.
The local process adapters normalize module names and final parameter LFs
before calling F$Fork/F$Chain.
Compiler flags, library and compatibility-source hashes enter build metadata.
The additional UUCPbb adapters live in this harness's compat/ archive.

Run `make test` for host regression checks of clock boundaries (including
post-2038 dates), high-bit string decoding, pattern/search helpers, CRCs against
a generated module, kernel argument terminators, and pipe redirection/error cleanup. Kernel services are
mocked in those tests. Run `make` first to supply the module CRC fixture.
OS-9 execution still requires a boot environment.
