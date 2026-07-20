**********************************************************************
* DLD.list - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       DLD.list
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
U0002               rmb       1         ; reserve 1 byte(s) in the module workspace
U0003               rmb       31        ; reserve 31 byte(s) in the module workspace
U0022               rmb       1         ; reserve 1 byte(s) in the module workspace
U0023               rmb       1         ; reserve 1 byte(s) in the module workspace
U0024               rmb       463       ; reserve 463 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /DLD.list/ ; store an OS-9 high-bit-terminated string
L0015               fcc       "DLD.lst" ; store literal character data
                    fcb       $0D       ; store byte data
L001D               fcc       "No files found." ; store literal character data
                    fcb       $0D       ; store byte data
L002D               fcc       "                                                                               " ; store literal character data
                    fcb       $0D       ; store byte data
L007D               fcc       "File name      Description" ; store literal character data
                    fcb       $0D       ; store byte data
L0098               fcc       "--------------------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
start               clr       U0002,u   ; clear U0002,u to zero and set the condition codes
                    lda       0,x       ; load a from 0,x
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L00F4     ; branch when the values are equal or the result is zero; target L00F4
                    lda       #1        ; set a to the constant 1
                    os9       I$ChgDir  ; invoke the OS-9 I$ChgDir service
                    lbcs      L0192     ; branch when carry reports an error or unsigned underflow; target L0192
L00F4               leax      >L0015,pc ; form the address >L0015,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L0192     ; branch when carry reports an error or unsigned underflow; target L0192
                    sta       U0000,u   ; store a at U0000,u
L0103               clra                ; clear a to zero and set the condition codes
                    ldb       #1        ; set b to the constant 1
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    lbcc      L0191     ; branch when carry is clear; target L0191
                    lda       U0000,u   ; load a from U0000,u
                    leax      U0003,u   ; form the address U0003,u in x
                    ldy       #96       ; set y to the constant 96
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lbcs      L017C     ; branch when carry reports an error or unsigned underflow; target L017C
                    lda       <U0022,u  ; load a from <U0022,u
                    cmpa      #255      ; compare a with #255 and set the condition codes
                    bne       L0103     ; branch when the values differ or the result is nonzero; target L0103
                    tst       U0002,u   ; set condition codes from U0002,u without changing it
                    bne       L0143     ; branch when the values differ or the result is nonzero; target L0143
                    leax      >L007D,pc ; form the address >L007D,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L0098,pc ; form the address >L0098,pc in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lda       #255      ; set a to the constant 255
                    sta       U0002,u   ; store a at U0002,u
L0143               clrb                ; clear b to zero and set the condition codes
                    leax      U0003,u   ; form the address U0003,u in x
L0146               lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L014F     ; branch when the values are equal or the result is zero; target L014F
                    incb                ; increment b
                    bra       L0146     ; continue execution at L0146
L014F               stb       U0001,u   ; store b at U0001,u
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    leax      U0003,u   ; form the address U0003,u in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    ldb       #15       ; set b to the constant 15
                    subb      U0001,u   ; subtract from b using U0001,u
                    blt       L016D     ; branch when the signed value is less; target L016D
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       #1        ; set a to the constant 1
                    leax      >L002D,pc ; form the address >L002D,pc in x
                    os9       I$Write   ; invoke the OS-9 I$Write service
L016D               leax      <U0023,u  ; form the address <U0023,u in x
                    ldy       #65       ; set y to the constant 65
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbra      L0103     ; continue execution at L0103
L017C               cmpb      #211      ; compare b with #211 and set the condition codes
                    bne       L0192     ; branch when the values differ or the result is nonzero; target L0192
                    tst       U0002,u   ; set condition codes from U0002,u without changing it
                    bne       L0191     ; branch when the values differ or the result is nonzero; target L0191
                    leax      >L001D,pc ; form the address >L001D,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
L0191               clrb                ; clear b to zero and set the condition codes
L0192               os9       F$Exit    ; invoke the OS-9 F$Exit service

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
