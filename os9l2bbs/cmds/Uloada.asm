**********************************************************************
* Uloada - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       Uloada
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

U0000               rmb       1         ; reserve 1 byte(s) in the module workspace
U0001               rmb       200       ; reserve 200 byte(s) in the module workspace
U00C9               rmb       1         ; reserve 1 byte(s) in the module workspace
U00CA               rmb       599       ; reserve 599 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /Uloada/ ; store an OS-9 high-bit-terminated string
L0013               fcc       "Enter filename to upload" ; store literal character data
L002B               fcc       "Press <CTRL><T> to terminal upload" ; store literal character data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
                    fcc       "Press <CTRL><x> to cancel" ; store literal character data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
L006A               fcb       $0A       ; store byte data
                    fcb       $3A       ; store byte data
start               lda       0,x       ; load a from 0,x
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       L008B     ; branch when the values differ or the result is nonzero; target L008B
                    leax      >L0013,pc ; form the address >L0013,pc in x
                    ldy       #24       ; set y to the constant 24
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      U0001,u   ; form the address U0001,u in x
                    ldy       #200      ; set y to the constant 200
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    leax      U0001,u   ; form the address U0001,u in x
L008B               lda       #3        ; set a to the constant 3
                    ldb       #27       ; set b to the constant 27
                    os9       I$Create  ; invoke the OS-9 I$Create service
                    lbcs      L00F0     ; branch when carry reports an error or unsigned underflow; target L00F0
                    sta       U0000,u   ; store a at U0000,u
                    leax      >L002B,pc ; form the address >L002B,pc in x
                    ldy       #63       ; set y to the constant 63
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      >L006A,pc ; form the address >L006A,pc in x
                    ldy       #2        ; set y to the constant 2
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
L00B2               clra                ; clear a to zero and set the condition codes
                    ldb       #1        ; set b to the constant 1
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    bcs       L00B2     ; branch when carry reports an error or unsigned underflow; target L00B2
                    ldy       #1        ; set y to the constant 1
                    leax      >U00C9,u  ; form the address >U00C9,u in x
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lda       0,x       ; load a from 0,x
                    cmpa      #20       ; compare a with #20 and set the condition codes
                    beq       L00EF     ; branch when the values are equal or the result is zero; target L00EF
                    cmpa      #24       ; compare a with #24 and set the condition codes
                    beq       L00EB     ; branch when the values are equal or the result is zero; target L00EB
                    lda       U0000,u   ; load a from U0000,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lda       0,x       ; load a from 0,x
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L00DC     ; branch when the values are equal or the result is zero; target L00DC
                    bra       L00B2     ; continue execution at L00B2
L00DC               leax      >L006A,pc ; form the address >L006A,pc in x
                    ldy       #2        ; set y to the constant 2
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    bra       L00B2     ; continue execution at L00B2
L00EB               lda       #1        ; set a to the constant 1
                    bra       L00F0     ; continue execution at L00F0
L00EF               clrb                ; clear b to zero and set the condition codes
L00F0               os9       F$Exit    ; invoke the OS-9 F$Exit service

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
