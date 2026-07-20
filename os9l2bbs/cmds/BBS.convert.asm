**********************************************************************
* BBS.convert - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
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
U003F               rmb       400       ; reserve 400 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.convert/ ; store an OS-9 high-bit-terminated string
L0018               fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
msginx              fcc       "BBS.msg.inx" ; store literal character data
                    fcb       $0D       ; store byte data

start               leax      >msginx,pc ; form the address >msginx,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; Open BBS.msg.inx
                    lbcs      ErrExit   ; Exit on error
                    sta       inxpath,u ; Save the path

Loop                lda       inxpath,u ; Get the path
                    leax      buffer,u  ; form the address buffer,u in x
                    ldy       #62       ; set y to the constant 62
                    os9       I$Read    ; Read 62 bytes
                    lbcs      Exit      ; Exit on error/EOF

                    leax      >L0018,pc ; form the address >L0018,pc in x
                    ldy       #2        ; set y to the constant 2
                    lda       inxpath,u ; load a from inxpath,u
                    os9       I$Write   ; Write $FFFF to BBS.msg.inx
                    bra       Loop      ; Repeat for next block

Exit                clrb                ; clear b to zero and set the condition codes
ErrExit             os9       F$Exit    ; invoke the OS-9 F$Exit service

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
