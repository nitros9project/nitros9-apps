**********************************************************************
* Dloada - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       Dloada
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

U0000               rmb       1         ; reserve 1 byte(s) in the module workspace
U0001               rmb       32        ; reserve 32 byte(s) in the module workspace
U0021               rmb       1         ; reserve 1 byte(s) in the module workspace
U0022               rmb       599       ; reserve 599 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /Dloada/ ; store an OS-9 high-bit-terminated string
L0013               fcc       "Enter filename to Download-->" ; store literal character data
L0030               fcc       "Press <SPACE> to abort" ; store literal character data
                    fcb       $0D       ; store byte data
L0047               fcc       "Press <ENTER> to begin" ; store literal character data
                    fcb       $0D       ; store byte data
L005E               fcb       $18       ; store byte data
L005F               fcb       $20       ; store byte data
start               lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    bcs       L0069     ; branch when carry reports an error or unsigned underflow; target L0069
                    bra       L008B     ; continue execution at L008B
L0069               leax      >L0013,pc ; form the address >L0013,pc in x
                    ldy       #29       ; set y to the constant 29
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      U0001,u   ; form the address U0001,u in x
                    ldy       #32       ; set y to the constant 32
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    leax      U0001,u   ; form the address U0001,u in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L00F4     ; branch when carry reports an error or unsigned underflow; target L00F4
L008B               sta       U0000,u   ; store a at U0000,u
                    leax      >L0030,pc ; form the address >L0030,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L0047,pc ; form the address >L0047,pc in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
L00A5               leax      <U0021,u  ; form the address <U0021,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lda       <U0021,u  ; load a from <U0021,u
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    lbeq      L00F3     ; branch when the values are equal or the result is zero; target L00F3
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       L00A5     ; branch when the values differ or the result is nonzero; target L00A5
                    leax      >L005E,pc ; form the address >L005E,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
L00C8               lda       U0000,u   ; load a from U0000,u
                    leax      <U0021,u  ; form the address <U0021,u in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    bcs       L00F3     ; branch when carry reports an error or unsigned underflow; target L00F3
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    clra                ; clear a to zero and set the condition codes
                    ldb       #1        ; set b to the constant 1
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    bcs       L00C8     ; branch when carry reports an error or unsigned underflow; target L00C8
                    ldy       #1        ; set y to the constant 1
                    leax      <U0021,u  ; form the address <U0021,u in x
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lda       0,x       ; load a from 0,x
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    bne       L00C8     ; branch when the values differ or the result is nonzero; target L00C8
L00F3               clrb                ; clear b to zero and set the condition codes
L00F4               pshs      b         ; save b on the stack
                    leax      >L005F,pc ; form the address >L005F,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    puls      b         ; restore b from the stack
                    os9       F$Exit    ; invoke the OS-9 F$Exit service

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
