**********************************************************************
* BBS.create - OS-9 Level 2 BBS command
*
* Syntax: BBS.create [directory]
* Purpose: Initialize an empty message body file and message index.
* Creates bbs.msg and bbs.msg.inx for a new board.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* annotated source and normalized comments.
*          2026/07/21  Codex
* refined command annotations and normalized formatting.
**********************************************************************

                    nam       BBS.create
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; executable object module
atrv                set       ReEnt+rev ; reentrant module with revision encoded below
rev                 set       $01       ; original module revision

                    mod       eom,name,tylg,atrv,start,size ; declare the OS-9 module header and entry point

IndexPath           rmb       1         ; open path number for the new message index
MessagePath         rmb       1         ; open path number for the new message-body file
IndexHeader         rmb       64        ; zero-initialized header block for BBS.msg.inx
ReservedWorkspace   rmb       200       ; retain the command's original minimum data allocation
size                equ       .         ; total per-process workspace size

name                fcs       /BBS.create/ ; os-9 module name
                    fcc       "Copyright (C) 1988" ; original embedded copyright notice
                    fcc       "By Keith Alphonso" ; original author credit
                    fcc       "Licenced to Alpha Software Technologies" ; original publisher credit and spelling
                    fcc       "All rights reserved" ; original rights notice
LicensePayload      fcb       $EC,$E6,$EA,$F5,$E9,$A0,$E2 ; opaque high-bit-set licensing payload
                    fcb       $ED,$F1,$E9,$F0,$EF,$F4,$F0 ; preserved byte-for-byte from the original
IndexFilename       fcc       "BBS.msg.inx" ; fixed-size message index created in the current directory
                    fcb       C$CR      ; terminate the OS-9 pathname
MessageFilename     fcc       "BBS.msg" ; variable-length message-body store created beside the index
                    fcb       C$CR      ; terminate the OS-9 pathname

* create both files before publishing the initial 64-byte index header. The command
* ignores its parameter pointer, so the shell's current data directory selects where
* the files are made; the historical "[directory]" syntax is therefore misleading.
start               leax      >IndexFilename,pc ; select the index pathname
                    lda       #11       ; preserve the original create mode and share bits
                    tfr       a,b       ; use the same original byte as file attributes
                    os9       I$Create  ; create or replace BBS.msg.inx
                    lbcs      Exit      ; return the create error to the shell
                    sta       IndexPath,u ; retain the open index path

                    leax      >MessageFilename,pc ; select the body-store pathname
                    lda       #11       ; preserve the original create mode and share bits
                    tfr       a,b       ; use the same original byte as file attributes
                    os9       I$Create  ; create or replace BBS.msg
                    lbcs      Exit      ; return without initializing the index if this fails
                    sta       MessagePath,u ; retain the body path, although this module never closes it

* the first three words are the only header fields explicitly initialized. OS-9 gives
* a new process zeroed data memory, so the remaining 58 bytes are already clear.
                    leax      IndexHeader,u ; select the complete header workspace
                    ldd       #0        ; initialize two header bytes at a time
                    std       ,x        ; clear the high-message word
                    std       2,x       ; clear the next reserved header word
                    std       4,x       ; clear the third header word

                    lda       IndexPath,u ; select BBS.msg.inx
                    ldy       #64       ; publish one complete header block
                    os9       I$Write   ; establish the first record at offset 64
                    lbcs      Exit      ; return an index write error
                    os9       I$Close   ; flush and release the index path
                    lbcs      Exit      ; preserve a close error as the exit status

                    clrb                ; report success; OS-9 reclaims the body path at exit
Exit                os9       F$Exit    ; return status B to the invoking shell

                    emod                ; append the OS-9 module CRC placeholder and trailer
eom                 equ       *         ; mark the module's end for the header
                    end                 ; finish this assembly unit
