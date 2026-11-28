# Module size investigation

All numbers are loaded OS-9 module bytes, including headers and CRC, using
C3/CMOC defaults and LLVM `-Os`. RAM reservations and stack space are separate.
The baseline is the imported build before this size investigation, not a rebuild
of the 1989 binaries. The archive has no original link map or build recipe, so
its exact instruction-by-instruction difference cannot be attributed reliably.

## Results

| Compiler | ViewGIF before | ViewGIF after | Saved | ViewVEF before | ViewVEF after | Saved |
|---|---:|---:|---:|---:|---:|---:|
| C3 | 20,646 | 19,956 | 690 | 5,708 | 4,267 | 1,441 |
| CMOC | 23,729 | 21,697 | 2,032 | 7,661 | 2,805 | 4,856 |
| LLVM | 32,736 | 31,666 | 1,070 | 12,746 | 4,801 | 7,945 |

The archived binaries are 18,720 bytes for ViewGIF and 4,483 for ViewVEF.
C3 ViewGIF is now 1,236 bytes (6.6%) larger than the archive; C3 ViewVEF is
216 bytes smaller. CMOC ViewVEF is 1,678 bytes smaller than the archive.
LLVM ViewVEF is 318 bytes larger.

## What was removed

Each row below was measured in sequence, with the preceding changes already
applied. No options, input checks, or stack checks were removed.

| Change | C3 GIF / VEF saved | CMOC GIF / VEF saved | LLVM GIF / VEF saved |
|---|---:|---:|---:|
| Remove unused graphics helper functions | 211 / 134 | 282 / 136 | 0 / 0 |
| Replace ViewVEF's usage/error `printf` calls with plain writes | 0 / 1,187 | 0 / 4,578 | 0 / 6,385 |
| Specialize private full-screen/scanline helpers to their actual callers | 186 / 120 | 202 / 142 | 94 / 38 |
| Group unchanged ViewGIF usage text into plain writes | 293 / 0 | 290 / 0 | 188 / 0 |
| Use a decimal-only option parser in LLVM | 0 / 0 | 0 / 0 | 796 / 1,530 |
| Route CMOC info output through its existing OS-9 formatter | 0 / 0 | 1,258 / 0 | 0 / 0 |
| Correct the native LLVM register-copy loops (8-byte increase) | 0 / 0 | 0 / 0 | −8 / −8 |

C3 and CMOC link whole source objects, retaining unused helpers; LLVM already
removed them with section garbage collection. The helper specialization keeps
both screen types and both alternating-screen paths, but stops passing constant
coordinates, dimensions, and colors through a general-purpose interface.

ViewVEF uses low-level file I/O throughout. Its few diagnostic messages were its
only formatted-I/O consumers, so removing those calls also removed formatter,
stream, buffering, and associated runtime dependencies. The net library reduction
is larger than the formatter routine itself.

LLVM's `atoi` implementation used `strtol`, pulling in long parsing and division
support. The viewer only needs decimal option values. The replacement retains
whitespace, signs, and the valid signed 16-bit range. A trial of that parser
increased C3 by 77 bytes per command and increased CMOC by 58/1 bytes, so those
compilers retain their smaller library implementations.

CMOC's map showed both `printf.os9_o` and `obj_base/printf.o`. Calls to `printf`
selected the compiler formatter, while `fprintf` selected the OS-9 library
formatter. Routing ViewGIF's info messages through `fprintf(stdout,...)` leaves
one engine. The additional stream argument slightly increases application code,
but removes 1,395 library bytes, for a net saving of 1,258 bytes.

## What remains in the modules

Application columns include instructions, literal strings, initialized data,
and object-specific initialization records. Compiler startup is separated where
the map allows it. LLVM pools some literals in a linker-owned section.

| Component | C3 GIF | C3 VEF | CMOC GIF | CMOC VEF | LLVM GIF | LLVM VEF |
|---|---:|---:|---:|---:|---:|---:|
| Application | 14,734 | 1,790 | 15,267 | 1,938 | 16,394 | 1,921 |
| Startup / compiler runtime | 398 | 398 | 290 | 290 | 2,782 | 1,635 |
| C libraries | 4,801 | 2,056 | 6,117 | 554 | 9,529 | 486 |
| LLVM OS-9 compatibility library | — | — | — | — | 1,083 | 611 |
| LLVM pooled strings/linker tables | — | — | — | — | 1,853 | 125 |
| Header, name, CRC, padding | 23 | 23 | 23 | 23 | 25 | 23 |

The LLVM compatibility layer is not the largest contributor. ViewGIF's picolibc
contribution is 9,529 bytes, including about 3.7 KiB in the integer formatting
object, plus its separate compiler runtime/startup. ViewGIF still needs formatted
image information and buffered input, so those dependencies remain. C3 ViewVEF
still includes stream cleanup reachable from its standard startup, even though
its own code no longer uses streams.

Further reductions would require changes to the standard runtimes, the remaining
formatter, or the decoder/palette algorithms. These changes keep the portable C
implementation and the added malformed-input checks.

## Reproduce and verify

Builds now retain `viewgif.map` and `viewvef.map` for every compiler. Run:

```sh
python3 build/sizes.py
```

The script totals loaded sections and excludes BSS, stack, direct-page RAM, and
ELF debug information. CMOC's initialized `rwdata` image does occupy module bytes
and is included. Full before/after totals, largest linked objects, and controlled
intermediate measurements are in [sizes.json](sizes.json).

Validation includes exact host pixel tests, malformed-input rejection, ten
numeric-parser cases, four OS-9 decode cases per compiler, and MAME graphics/VEF
checks. Display, playback and alternating-screen mode are checked for all three
compilers, including both exported frames, their averaged colors, distinct
screen captures and repeated video-bank changes. The former LLVM black-window
failure came from the compatibility library stopping its register-copy loop at
the first zero byte; the fixed library copies all ten register bytes.
