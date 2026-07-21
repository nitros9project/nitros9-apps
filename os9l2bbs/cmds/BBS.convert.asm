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
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       BBS.convert
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

inxpath             rmb       1         ; reserve 1 byte(s) in the module workspace
buffer              rmb       62        ; reserve 62 byte(s) in the module workspace
ReservedWorkspace   rmb       400       ; retain the command's original minimum data allocation
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.convert/ ; store an OS-9 high-bit-terminated string
Release3IndexMarker fcb       $FF       ; replacement marker written while converting the index
                    fcb       $FF       ; store byte data
msginx              fcc       "BBS.msg.inx" ; store literal character data
                    fcb       $0D       ; store byte data

start               leax      >msginx,pc ; form the address >msginx,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open BBS.msg.inx
                    lbcs      ErrExit   ; exit on error
                    sta       inxpath,u ; save the path

Loop                lda       inxpath,u ; get the path
                    leax      buffer,u  ; form the address buffer,u in x
                    ldy       #62       ; set y to the constant 62
                    os9       I$Read    ; read 62 bytes
                    lbcs      Exit      ; exit on error/EOF

                    leax      >Release3IndexMarker,pc ; supply the Release 3 marker byte
                    ldy       #2        ; set y to the constant 2
                    lda       inxpath,u ; load a from inxpath,u
                    os9       I$Write   ; write $FFFF to BBS.msg.inx
                    bra       Loop      ; repeat for next block

Exit                clrb                ; clear b to zero and set the condition codes
ErrExit             os9       F$Exit    ; terminate the process with status B

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
