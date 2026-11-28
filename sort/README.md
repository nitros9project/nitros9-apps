# sort

A text sort for OS-9/6809 with no limit on the number of lines: input that
does not fit in memory is sorted in memory-sized runs, written to temporary
files, and merged.

    sort [-rfnubv] [-t c] [-k f1[.c1][,f2[.c2]]]... [-o out] [-T dir]
         [-m size[k]] [file...]

With no files, or `-`, it reads standard input. The sorted lines go to
standard output, or to `-o out`, which may be one of the inputs.

| Option | Meaning |
|---|---|
| `-r` | reverse the order |
| `-f` | fold lower case to upper case when comparing |
| `-n` | compare as numbers: leading blanks, an optional `-`, digits and an optional `.fraction`, of any length |
| `-b` | ignore leading blanks in keys |
| `-u` | output only the first of each group of lines with equal keys |
| `-t c` | fields are separated by `c`; without it, a field is a run of blanks and the non-blanks after them |
| `-k f1[.c1][,f2[.c2]]` | sort on fields `f1` to `f2` (from 1), starting at character `c1` and ending at `c2`; several `-k` are compared in turn; without `f2` the key runs to the end of the line |
| `-o out` | write to `out` |
| `-T dir` | put temporary files in `dir` |
| `-m size` | use an arena of `size` bytes (`k` for 1024), to leave memory for other things |
| `-v` | report progress on standard error |

A program built with `cc1` splits its arguments at commas as well as spaces
(Microware's start-up code does), so give `-k` a key with a comma as a
separate, quoted argument: `-k "3,3"`. The c3 build does not split at
commas, so `-k3,3` works with it too.

The sort is stable: lines with equal keys keep their input order. Lines end
with a CR; a last line without one is still a line. The exit status is 0, or an
OS-9 error number so that the shell's message fits: 187 (illegal argument)
for a usage error, 207 (memory full) when the memory is too small for a
line, the error from a failed read or write (248 when a disk is full), or
the signal if `sort` is interrupted.

## Temporary files

Without `-T`, temporary files go in `/r0`, and if that cannot be used (it is
missing, unformatted or full) in the current data directory, with a message.
They are named `sort<pid>.<n>` and are deleted when `sort` finishes, fails
or is interrupted.

## How it works

1. Input is read straight into one arena, as much memory as the process can
   get (or `-m`). Text grows up from the bottom and a record for each line
   grows down from the top.
2. When the arena is full its records are sorted with a stable merge sort of
   pointers (insertion sort for slices of 8; input already in order is
   detected and left alone) and written to a temporary file as a run. Input
   that fits in one arena goes straight to the output.
3. The runs are merged up to 12 at a time, each through its own buffer, with
   a small heap choosing the next line. While there are too many runs, the
   cheapest group of adjacent runs is merged into one, just enough for the
   final merge to take the rest at once. Merging only adjacent runs keeps the
   sort stable.

Comparisons use a table for `-f` and compare numbers as digit strings, so
there is no floating point and no limit on their length.

## Building

```sh
make NITROS9DIR=/path/to/nitros9  # Cross-build with C3
make -f os9.mak                 # Native OS-9 build with cc1
```

C3 and LWTOOLS must be on `PATH`; set `C3BASE` to the C3 installation.
`os9.mak` is installed as the makefile when sources are copied to a NitrOS-9 disk.
