# VBCC builds for NitrOS-9 C applications

`make vbcc` at the repository root builds all 39 C commands with the 6809
VBCC preview, vasm and vlink. Outputs are in each package's
`build/out/vbcc/Os/`; source preparation, logs and intermediates are in
`build-support/vbcc/out/`. Original application sources are retained; legacy
C corrections are applied to disposable copies. Assembly-only packages are
built by their existing make targets.

## Toolchain setup

Use the **6809 Release 1 Preview 2026-01-25**, vbcc V0.9i pre / hc12 backend
V1.0. The outer preview archive SHA-256 is
`18db043d4d4c8b0a16d4fa4b813616f277fcfb3667be0eda2334a8b8b024917e`;
its compiler `vbcc.tar.gz` SHA-256 is
`e1e80894c972bc38a1fe2804fe4bce8559e4be6e53e4c878de6f459a6929637e`.
Install the preview's native host tools and `targets/6809-os9` runtime.
Toolchain sources retain their upstream licenses and are not vendored here.

Three compiler fixes, an EOF wrapper fix, and a vlink fix are required by this
build configuration. The helpers build private copies; they do not change
the installed toolchain. With the preview and vlink 0.18a sources extracted:

```sh
export VBCC_ROOT=/path/to/installed/vbcc
python3 build-support/vbcc/prepare_compiler.py --source /path/to/vbcc-sources
python3 build-support/vbcc/prepare_vlink.py --source /path/to/vlink-sources
python3 build-support/vbcc/prepare_runtime.py \
  --root "$VBCC_ROOT" --source /path/to/preview/libsrc/6809-os9/rw.s
export VBCC_CC="$PWD/build-support/vbcc/out/compiler/bin/vbcchc12"
export VBCC_VLINK="$PWD/build-support/vbcc/out/vlink/vlink"
export VBCC_RW_OBJECT="$PWD/build-support/vbcc/out/io/rw.o"
export VBCC_OS9_COMPAT_ROOT=/path/to/nitros9-c-libs/llvm
make vbcc
```

Compiler/linker helper output directories must not already exist. Use
`--out` to choose another directory. `VBCC_OS9_COMPAT_ROOT` supplies portable
OS-9 C wrappers and headers; its sibling `lib/getopt.c` is also required.
The assembly bridge in this directory implements the VBCC calling convention
for those wrappers. It does not use LLVM's assembly bridge.

The frontend patch preserves one-past-array offsets. The backend patches fix
an index register overwritten during pointer subtraction, and accumulator
restoration around argument pushes; see the
[pointer report](issues/pointer-subtraction/README.md) and
[row-mapping report](issues/accumulator-restore/README.md). The EOF wrapper
returns zero bytes for OS-9 E$EOF. The vlink patch allows 16-bit PC-relative
wraparound only for the OS-9/6809 output target, needed by larger UUCPbb
commands. These are local proposed fixes, not claims of upstream acceptance.

## Selecting commands

```sh
python3 build-support/vbcc.py --target sort
python3 build-support/vbcc.py --package kreider
make -C sled vbcc
make -C uucpbb commands COMPILER=vbcc
```

Kermit, SLED, UUCPbb and ViewGIF's existing `build/build.py --compiler vbcc` entry
points also delegate to the shared builder. VBCC currently uses `-O=1023`;
other optimization selectors do not change that setting. `--ticks` sets
Kermit's clock rate (default 60 Hz). Legacy package Makefiles also install
the command at their historical output paths. The root target builds C
commands only; disk packaging remains package-specific. UUCPbb's native
`uumon` assembly component is retained for disk packaging.

Every linked command is checked for its exact OS-9 module name, header parity,
module size and CRC,
and initial code/data block allocation is limited to the eight process
blocks. This does not prove sufficient heap space for every workload.
Build metadata includes compiler/linker hashes and starts with
`runtime_tested: false`; successful linking alone is not runtime validation.

## Runtime validation

`tests/runtime.py` copies a Pico-Thing NitrOS-9 boot disk, installs the built
commands and runs CLI/editor fixtures with `usim09pt`. Pass `--boot`,
`--firmware`, `--emulator`, `--os9` (ToolShed) and `--modules` (the common
output directory). Results and the scratch disk remain under `out/tests/`.
Run `python3 build-support/vbcc/tests/build_regressions.py` before the CLI
suite to build its PC-relative wrap module and safe compiler controls. The
regression sources are `tests/wrap.c`, `wrap.s` and the pointer issue folder.
The intentionally faulty compiler controls must run on separate scratch
boots: their stores through address zero can corrupt the running process.

SLED's `tests/interactive.py` and ViewGIF's `tests/runtime.py` and
`tests/graphics.py` accept the VBCC module paths directly. Networking,
mail/news delivery, authentication, serial transfers and all UUCPbb workflows
require additional integration testing; build support does not establish
that those workflows work.

## Module sizes

Sizes below are module bytes, including the OS-9 header and CRC, with the
local fixes and `-O=1023`. They exclude separately allocated process data.

| Command | Bytes |
| --- | ---: |
| adduser | 18572 |
| cb | 10048 |
| chown | 10971 |
| cnvrtmail | 27874 |
| dgrep | 12996 |
| dotilde | 18016 |
| ed | 19107 |
| expire | 21122 |
| fileserv | 32331 |
| fixtext | 8720 |
| kermit | 28614 |
| lb | 10487 |
| login | 23361 |
| mailx | 48732 |
| man | 12203 |
| mroff | 18944 |
| postnews | 33207 |
| ppc | 8459 |
| readnews | 39961 |
| rmail | 34764 |
| rnews | 30230 |
| sled | 25140 |
| sort | 19396 |
| subscribe | 18101 |
| umacs | 23867 |
| umacsc | 23137 |
| uniq | 9486 |
| unsubscribe | 18122 |
| uucico | 47562 |
| uuclean | 29293 |
| uucp | 21349 |
| uudecode | 8573 |
| uuencode | 7748 |
| uulog | 16383 |
| uuname | 8182 |
| uuxqt | 22021 |
| viewgif | 24304 |
| viewvef | 5515 |
| whoami | 9088 |

Largest commands (including uucico, mailx and readnews) initially occupy all eight process blocks. Their stock preview heap allocator may be unable to grow the data area; substantial UUCP workloads remain unverified.

The module-name section is explicitly protected from section garbage collection. ViewGIF uses the existing decimal parser and opens GIF input in binary mode to avoid text translation.

## Recorded validation

The final build passed 77 native CLI/compiler/linker checks, four GIF decoder
fixtures, exact 320 × 192 VEF comparisons in static and flicker modes, live
flicker alternation and ViewVEF playback, and SLED editing/save/reopen tests.
The color bars shift at rows 64 and 128. SLED also builds with C3, CMOC and LLVM after the prompt-flush fix. See [validation.json](validation.json)
for module sizes, hashes and the limits of this coverage.

SLED flushes stdout and stderr before each raw keyboard read, so replacement
and save prompts are fully visible while waiting for an answer.
