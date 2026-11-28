# VBCC 6809: subtraction operand overwritten during code generation

The 6809 backend emits incorrect code for the valid C89 expression in `probe.c` when compiled with `-O=1023`. Compile `probe.c` separately from `check.c`. The array and its one-past pointer are valid; the expected destination is `records[6]`.

Affected release: vbcc V0.9i pre, hc12 backend V1.0, 6809 Release 1 Preview 2026-01-25.
Source `vbcc.tar.gz` SHA-256: `e1e80894c972bc38a1fe2804fe4bce8559e4be6e53e4c878de6f459a6929637e`.
Pristine `machines/hc12/machine.c` SHA-256: `dfe5c2a851cae252c99b12559278ab273efc0146006be390cef6ecc06c509c16`.

## Reproduction

```sh
vbcchc12 -cpu=6809 -pcrel -drel -O=1023 probe.c -o=probe.s
vbcchc12 -cpu=6809 -pcrel -drel -O=0 check.c -o=check.s
```

For the second command, supply the OS-9 target include directory with `-I/path/to/targets/6809-os9/include`. Assemble both files and link with the OS-9 startup and C library. Expected output: `POINTER SUBTRACTION PASS`.

The code-generation problem can also be inspected without linking. In `ptr02.s`, X initially contains `8 * (count + 1)`. The next `ldx (top),u` destroys that offset. The generated negation and `leax d,x` then compute `top - top`, producing address zero instead of the record address. Subsequent stores use that incorrect address.

`ptr00.s` is pristine source at `-O=0`; `ptr02.s` is pristine source at `-O=1023`; `ptrarr.s` includes only the previously identified frontend one-past-array fix; `ptrfix.s` includes that fix and the proposed backend correction. This subtraction problem is independent of the frontend array-offset issue.

## Proposed correction

See `vbcc-pointer-subtract.patch`. When a SUB destination index register aliases its right operand, use the accumulator for the calculation rather than loading the left operand into that index register first. This is a proposed fix for review, restricted to CPU 6809; other targets and broader backend cases have not been validated.

The original application symptom was sort output containing only carriage returns. With this backend correction the tested normal and numeric sort outputs are correct. Application runtime tests are separate from the small compiler reproducer.

## Native controls

On an isolated Pico-Thing NitrOS-9 boot, pristine `-O=0` and the patched
`-O=1023` controls both print `POINTER SUBTRACTION PASS`. The pristine
optimized control writes through address zero and corrupts its failure
message; it must not share a boot with later tests. The array-fix-only
control has the same incorrect optimized assembly. No complete native
failure-message matrix is claimed.
