# VBCC 6809: accumulator restore and argument-push interaction

Affected preview and source archive are the same as the adjacent
[pointer-subtraction report](../pointer-subtraction/README.md). This reproducer
maps 192 input rows to themselves, using defined C89 arithmetic and array
accesses. Compile `probe.c` separately from `check.c`:

```sh
vbcchc12 -cpu=6809 -pcrel -drel -O=1023 probe.c -o=probe.s
```

The pristine optimized compiler produces `stock.s`. Its native NitrOS-9
execution prints `ACCUMULATOR RESTORE FAIL`; the corrected compiler produces
`fixed.s` and prints `ACCUMULATOR RESTORE PASS`. A host C build also passes.

Two backend interactions are involved:

1. The emitter eliminates adjacent `puls a,b` / `pshs b,a;ga` entirely.
   The pair has no net stack effect, but it **loads D from the stack**.
   Removing both loses that restore. The proposed change replaces the pair
   with `ldd 0,s`.
2. The `pulled_acc` handling calls `get_acc` before a PUSH instruction.
   The long-argument PUSH implementation already saves D in its own scratch
   slot because its pushes change the stack. An additional stack save causes
   the restore to consume an argument word. The proposed change lets PUSH
   use its own preservation logic.

The attached patch addresses both interactions. It is a proposal for Volker
to review, not a claim that every backend case or CPU variant is validated.

The application symptom was ViewGIF showing uninterrupted vertical bars
instead of shifts at rows 64 and 128. The independent row-mapping control
checks every row; display and VEF pixel tests separately check the application.
