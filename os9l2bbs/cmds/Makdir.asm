**********************************************************************
* Makdir - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       Makdir
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

U0000               rmb       400       ; reserve 400 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /Makdir/ ; store an OS-9 high-bit-terminated string
start               ldb       #63       ; set b to the constant 63
                    os9       I$MakDir  ; invoke the OS-9 I$MakDir service
                    bcs       L001B     ; branch when carry reports an error or unsigned underflow; target L001B
                    clrb                ; clear b to zero and set the condition codes
L001B               os9       F$Exit    ; invoke the OS-9 F$Exit service

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
