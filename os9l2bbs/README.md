# OS-9 Level 2 BBS

This directory preserves the OS-9 Level 2 BBS package originally distributed
by **Alpha Software Technologies**. The material is retained for historical
reference, study, and continued maintenance within the NitrOS-9 applications
collection.

## Provenance

The original distribution disk is preserved unchanged at
[`reference/os9l2bbs.dsk`](reference/os9l2bbs.dsk). Its provenance and SHA-256
checksum are recorded in [`reference/README.md`](reference/README.md).

The reference image is a historical artifact. It is not build output and must
not be overwritten by a newly assembled disk image.

## Alpha Software Technologies and Keith Alphonso

Alpha Software Technologies was a Louisiana software company founded by
**Keith J. Alphonso**. It served the Tandy Color Computer and OS-9 community
during the late 1980s and early 1990s. Notices embedded in this package date
parts of the software to 1988 and 1989, credit Alphonso as their author, and
identify Alpha Software Technologies as the licensee or distributor.

Historical accounts of CoCoFest remember Alphonso demonstrating Alpha Software
Technologies products including the OS-9 Level II BBS package, Data Windows,
Presto Partner, and other OS-9 utilities. See Allen Huffman's
[*CoCoFest Chronicles*](https://colorcomputerarchive.com/repo/Documents/Books/CoCoFest%20Chronicles%20%28Allen%20Huffman%29.pdf)
in the Color Computer Archive.

Keith Joseph Alphonso was born December 11, 1965, in New Orleans, Louisiana,
and died September 6, 2025, in Slidell, Louisiana. He earned bachelor's and
master's degrees, with his graduate degree in computer science, and continued
his technology career as CTO of Geocent and later as a Senior Solutions
Architect at Sev1Tech. His obituary remembers both his technical ability and
the warmth, generosity, and friendship he shared with others. See the
[obituary published by Honaker Funeral Home](https://www.honakerforestlawn.com/obituary/keith-alphonso).

This preserved package is part of Alphonso's early computing legacy and of the
broader history of commercial and community-supported OS-9 software.

## Current state

- `cmds/` contains 6809 assembly representations of the BBS command modules.
  The sources have been annotated and formatted for readability while
  preserving their instructions, operands, numeric values, branch targets,
  directives, and data.
- `bbs/` contains the BBS menus, configuration, data, scripts, and supporting
  files used to construct an operational disk.
- `game/` contains the accompanying game files and utilities.
- `6809l2/` contains the OS-9 Level 2 build definition. Its generated disk is
  `6809l2/OS9L2BBS.dsk`, separate from the preserved reference image.

The buildable sources are a maintained reconstruction of the package; the
generated disk should not be assumed to be byte-for-byte identical to the
original distribution image unless that is verified separately.

See [`ARCHITECTURE.md`](ARCHITECTURE.md) for the recovered runtime model,
command families, persistent data files, and source-annotation conventions.
See [`COMMANDS.md`](COMMANDS.md) for a maintenance-oriented command and module
reference derived from the original Release 3.00 manual.

No ownership, licensing, or redistribution rights are implied by the presence
of the historical material in this repository.
