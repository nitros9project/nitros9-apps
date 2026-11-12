#!/bin/sh
set -eu
: "${C3ROOT:?Set C3ROOT to the c3 source directory}"
lb=$C3ROOT/lwbackend
# These c3 library sources use the register-first ABI. Get/put commands
# are implemented separately in gpbuf.c because getput.a uses the old ABI.
for src in lib/cgfx/window.a lib/cgfx/text.a lib/cgfx/draw.a lib/cgfx/config.a lib/cgfx/status.a lib/cgfx/nobuffer.a lib/lib.a/utime.a lib/lib.a/rand.a lib/lib.a/sleep.a; do
    name=$(basename "$src" .a)
    sed '/^[ \t]*ifp1/,/^[ \t]*endc/d' "$C3ROOT/$src" |
        sed -f "$lb/os9defs.sed" -f cross-defs.sed |
        awk -f "$lb/c3lw.awk" > "build/$name.s"
    lwasm --format=obj -o "build/$name.o" "build/$name.s"
done
rm -f build/libsupport.a
lwar -c build/libsupport.a build/window.o build/text.o build/draw.o build/config.o build/status.o build/nobuffer.o build/utime.o build/rand.o build/sleep.o
