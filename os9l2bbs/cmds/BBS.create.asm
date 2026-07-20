**********************************************************************
* BBS.create - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       BBS.create
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

inxpath             rmb       1         ; reserve 1 byte(s) in the module workspace
msgpath             rmb       1         ; reserve 1 byte(s) in the module workspace
buffer              rmb       64        ; reserve 64 byte(s) in the module workspace
U0042               rmb       200       ; reserve 200 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.create/ ; store an OS-9 high-bit-terminated string
                    fcc       "Copyright (C) 1988" ; store literal character data
                    fcc       "By Keith Alphonso" ; store literal character data
                    fcc       "Licenced to Alpha Software Technologies" ; store literal character data
                    fcc       "All rights reserved" ; store literal character data
                    fcb       $EC       ; store byte data
                    fcb       $E6       ; store byte data
                    fcb       $EA       ; store byte data
                    fcb       $F5       ; store byte data
                    fcb       $E9       ; store byte data
                    fcb       $A0       ; store byte data
                    fcb       $E2       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $F1       ; store byte data
                    fcb       $E9       ; store byte data
                    fcb       $F0       ; store byte data
                    fcb       $EF       ; store byte data
                    fcb       $F4       ; store byte data
                    fcb       $F0       ; store byte data
msginx              fcc       "BBS.msg.inx" ; store literal character data
                    fcb       $0D       ; store byte data
bbsmsg              fcc       "BBS.msg" ; store literal character data
                    fcb       $0D       ; store byte data

* Create BBS.msg.inx
start               leax      >msginx,pc ; form the address >msginx,pc in x
                    lda       #11       ; set a to the constant 11
                    tfr       a,b       ; copy the register values specified by a,b
                    os9       I$Create  ; invoke the OS-9 I$Create service
                    lbcs      Exit      ; Exit on error
                    sta       inxpath,u ; store a at inxpath,u

* Create BBS.msg
                    leax      >bbsmsg,pc ; form the address >bbsmsg,pc in x
                    lda       #11       ; set a to the constant 11
                    tfr       a,b       ; copy the register values specified by a,b
                    os9       I$Create  ; invoke the OS-9 I$Create service
                    lbcs      Exit      ; branch when carry reports an error or unsigned underflow; target Exit
                    sta       msgpath,u ; store a at msgpath,u

* Clear the first six bytes
                    leax      buffer,u  ; form the address buffer,u in x
                    ldd       #0        ; set d to the constant 0
                    std       0,x       ; store d at 0,x
                    std       $02,x     ; store d at $02,x
                    std       $04,x     ; store d at $04,x

* Write the buffer to BBS.msg.inx
                    lda       inxpath,u ; load a from inxpath,u
                    ldy       #64       ; set y to the constant 64
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      Exit      ; branch when carry reports an error or unsigned underflow; target Exit

* Close BBS.msg.inx
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lbcs      Exit      ; branch when carry reports an error or unsigned underflow; target Exit

                    clrb                ; clear b to zero and set the condition codes
Exit                os9       F$Exit    ; invoke the OS-9 F$Exit service

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
