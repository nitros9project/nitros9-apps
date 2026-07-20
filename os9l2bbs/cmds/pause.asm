**********************************************************************
* pause - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       pause
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

U0000               rmb       1         ; reserve 1 byte(s) in the module workspace
U0001               rmb       1         ; reserve 1 byte(s) in the module workspace
U0002               rmb       2         ; reserve 2 byte(s) in the module workspace
U0004               rmb       400       ; reserve 400 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /pause/ ; store an OS-9 high-bit-terminated string
L0012               fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
start               lda       ,x+       ; load a from ,x+
                    cmpa      #34       ; compare a with #34 and set the condition codes
                    beq       L0028     ; branch when the values are equal or the result is zero; target L0028
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       start     ; branch when the values differ or the result is nonzero; target start
                    leax      >L0065,pc ; form the address >L0065,pc in x
                    ldy       #28       ; set y to the constant 28
                    bra       L0041     ; continue execution at L0041
L0028               clr       U0001,u   ; clear U0001,u to zero and set the condition codes
                    stx       U0002,u   ; store x at U0002,u
L002C               lda       ,x+       ; load a from ,x+
                    cmpa      #34       ; compare a with #34 and set the condition codes
                    beq       L003A     ; branch when the values are equal or the result is zero; target L003A
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L003A     ; branch when the values are equal or the result is zero; target L003A
                    inc       U0001,u   ; increment the value at U0001,u
                    bra       L002C     ; continue execution at L002C
L003A               ldb       U0001,u   ; load b from U0001,u
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    ldx       U0002,u   ; load x from U0002,u
L0041               lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    bcs       L0062     ; branch when carry reports an error or unsigned underflow; target L0062
                    clra                ; clear a to zero and set the condition codes
                    ldy       #1        ; set y to the constant 1
                    leax      U0000,u   ; form the address U0000,u in x
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    bcs       L0062     ; branch when carry reports an error or unsigned underflow; target L0062
                    lda       #1        ; set a to the constant 1
                    leax      >L0012,pc ; form the address >L0012,pc in x
                    ldy       #2        ; set y to the constant 2
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    clrb                ; clear b to zero and set the condition codes
L0062               os9       F$Exit    ; invoke the OS-9 F$Exit service
L0065               fcc       "Press any key to continue..." ; store literal character data
                    fcb       $0D       ; store byte data

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
