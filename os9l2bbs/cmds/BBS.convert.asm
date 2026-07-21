**********************************************************************
* BBS.convert - OS-9 Level 2 BBS command
*
* Syntax: BBS.convert [directory]
* Purpose: Convert a Release 2.0 message base to the Release 3.0 representation.
* Data: bbs.msg and bbs.msg.inx in the selected directory.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* annotated source and normalized comments.
*          2026/07/21  Codex
* refined command annotations and normalized formatting.
**********************************************************************

                    nam       BBS.convert
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; executable object module
atrv                set       ReEnt+rev ; reentrant module with revision encoded below
rev                 set       $01       ; original module revision

                    mod       eom,name,tylg,atrv,start,size ; declare the OS-9 module header and entry point

IndexPath           rmb       1         ; update-mode path for the index being converted
Release2RecordPrefix rmb      62        ; unchanged prefix of one 64-byte pre-3.0 record
ReservedWorkspace   rmb       400       ; retain the command's original minimum data allocation
size                equ       .         ; total per-process workspace size

name                fcs       /BBS.convert/ ; os-9 module name
Release3IndexMarker fdb       $FFFF     ; replacement for each record's trailing two-byte field
IndexFilename       fcc       "BBS.msg.inx" ; index in the shell's current data directory
                    fcb       C$CR      ; terminate the OS-9 pathname

* both formats use 64-byte records. The first 62 bytes pass untouched through the
* read buffer; the converter overwrites only the final word with the release 3.0
* $FFFF marker, then continues at the next 64-byte boundary.
start               leax      >IndexFilename,pc ; select BBS.msg.inx
                    lda       #UPDAT.   ; conversion needs one shared read/write cursor
                    os9       I$Open    ; open the index in place
                    lbcs      ErrorExit ; return an open failure unchanged
                    sta       IndexPath,u ; retain the update-mode path

ConvertNextRecord   lda       IndexPath,u ; select the index for the next old record
                    leax      Release2RecordPrefix,u ; receive the unchanged record prefix
                    ldy       #62       ; advance to the old record's trailing word
                    os9       I$Read    ; leave the cursor where the replacement belongs
                    lbcs      ConversionComplete ; eof terminates a successful conversion

                    leax      >Release3IndexMarker,pc ; select the new trailing $FFFF field
                    ldy       #2        ; append exactly one word per old record
                    lda       IndexPath,u ; restore the shared update path
                    os9       I$Write   ; replace the old trailing field with $FFFF
                    bra       ConvertNextRecord ; continue at the next 64-byte record

ConversionComplete clrb                ; treat eof as normal completion
ErrorExit           os9       F$Exit    ; return status B to the invoking shell

                    emod                ; append the OS-9 module CRC placeholder and trailer
eom                 equ       *         ; mark the module's end for the header
                    end                 ; finish this assembly unit
