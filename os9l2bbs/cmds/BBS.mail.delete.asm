**********************************************************************
* BBS.mail.delete - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       BBS.mail.delete
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
U0003               rmb       3         ; reserve 3 byte(s) in the module workspace
U0006               rmb       1         ; reserve 1 byte(s) in the module workspace
U0007               rmb       2         ; reserve 2 byte(s) in the module workspace
U0009               rmb       2         ; reserve 2 byte(s) in the module workspace
U000B               rmb       1         ; reserve 1 byte(s) in the module workspace
U000C               rmb       1         ; reserve 1 byte(s) in the module workspace
U000D               rmb       1         ; reserve 1 byte(s) in the module workspace
U000E               rmb       1         ; reserve 1 byte(s) in the module workspace
U000F               rmb       232       ; reserve 232 byte(s) in the module workspace
U00F7               rmb       2         ; reserve 2 byte(s) in the module workspace
U00F9               rmb       2         ; reserve 2 byte(s) in the module workspace
U00FB               rmb       60        ; reserve 60 byte(s) in the module workspace
U0137               rmb       80        ; reserve 80 byte(s) in the module workspace
U0187               rmb       2         ; reserve 2 byte(s) in the module workspace
U0189               rmb       60        ; reserve 60 byte(s) in the module workspace
U01C5               rmb       2         ; reserve 2 byte(s) in the module workspace
U01C7               rmb       200       ; reserve 200 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.mail.delete/ ; store an OS-9 high-bit-terminated string
L001C               fcc       "BBS.mail.inx" ; store literal character data
                    fcb       $0D       ; store byte data
L0029               fcc       "BBS.mail" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $0A       ; store byte data
                    fcb       $0A       ; store byte data
                    fcc       "From    :Left on :About   :" ; store literal character data
                    fcb       $00       ; store byte data
                    fcb       $09       ; store byte data
                    fcc       "----------------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
L0098               fcc       "Deleting mail..." ; store literal character data
                    fcb       $0D       ; store byte data
L00A9               fcb       $0A       ; store byte data
                    fcc       "One moment please..." ; store literal character data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
L00C0               fcc       "mail.scratch.inx" ; store literal character data
                    fcb       $0D       ; store byte data
L00D1               fcc       "mail.scratch" ; store literal character data
                    fcb       $0D       ; store byte data
L00DE               fcb       $2E       ; store byte data
                    fcb       $0D       ; store byte data
                    fcc       "Rename" ; store literal character data
                    fcb       $0D       ; store byte data

start               os9       F$ID      ; invoke the OS-9 F$ID service
                    sty       U0009,u   ; store y at U0009,u
                    ldy       #0        ; set y to the constant 0
                    os9       F$SUser   ; invoke the OS-9 F$SUser service
                    leax      >L00A9,pc ; form the address >L00A9,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L001C,pc ; form the address >L001C,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L024F     ; branch when carry reports an error or unsigned underflow; target L024F
                    sta       U0000,u   ; store a at U0000,u
                    leax      >L0029,pc ; form the address >L0029,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L024F     ; branch when carry reports an error or unsigned underflow; target L024F
                    sta       U0001,u   ; store a at U0001,u
                    leax      >L00C0,pc ; form the address >L00C0,pc in x
                    lda       #2        ; set a to the constant 2
                    ldb       #11       ; set b to the constant 11
                    os9       I$Create  ; invoke the OS-9 I$Create service
                    lbcs      L024F     ; branch when carry reports an error or unsigned underflow; target L024F
                    sta       U0002,u   ; store a at U0002,u
                    leax      >L00D1,pc ; form the address >L00D1,pc in x
                    lda       #2        ; set a to the constant 2
                    ldb       #11       ; set b to the constant 11
                    os9       I$Create  ; invoke the OS-9 I$Create service
                    sta       U0003,u   ; store a at U0003,u
                    clr       U000B,u   ; clear U000B,u to zero and set the condition codes
                    clr       U000C,u   ; clear U000C,u to zero and set the condition codes
                    clr       U000D,u   ; clear U000D,u to zero and set the condition codes
                    clr       U000E,u   ; clear U000E,u to zero and set the condition codes
                    leax      >U00F7,u  ; form the address >U00F7,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       U0000,u   ; load a from U0000,u
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lbcs      L024F     ; branch when carry reports an error or unsigned underflow; target L024F
                    lda       U0002,u   ; load a from U0002,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
L015B               leax      >U0187,u  ; form the address >U0187,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       U0000,u   ; load a from U0000,u
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    bcs       L01E5     ; branch when carry reports an error or unsigned underflow; target L01E5
                    cmpy      #64       ; compare y with #64 and set the condition codes
                    bne       L01E5     ; branch when the values differ or the result is nonzero; target L01E5
                    ldd       >U01C5,u  ; load d from >U01C5,u
                    cmpd      U0009,u   ; compare d with U0009,u and set the condition codes
                    beq       L01B5     ; branch when the values are equal or the result is zero; target L01B5
                    ldd       U000B,u   ; load d from U000B,u
                    std       >U0187,u  ; store d at >U0187,u
                    ldd       U000D,u   ; load d from U000D,u
                    std       >U0189,u  ; store d at >U0189,u
                    lda       U0002,u   ; load a from U0002,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
L018A               lda       U0001,u   ; load a from U0001,u
                    leax      >U0137,u  ; form the address >U0137,u in x
                    ldy       #80       ; set y to the constant 80
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    bcs       L01E5     ; branch when carry reports an error or unsigned underflow; target L01E5
                    lda       U0003,u   ; load a from U0003,u
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    tfr       y,d       ; copy the register values specified by y,d
                    addd      U000D,u   ; add to d using U000D,u
                    std       U000D,u   ; store d at U000D,u
                    bcc       L01AD     ; branch when carry is clear; target L01AD
                    ldd       U000B,u   ; load d from U000B,u
                    addd      #1        ; add to d using #1
                    std       U000B,u   ; store d at U000B,u
L01AD               cmpy      #1        ; compare y with #1 and set the condition codes
                    bhi       L018A     ; branch when the unsigned value is higher; target L018A
                    bra       L015B     ; continue execution at L015B
L01B5               leax      >L0098,pc ; form the address >L0098,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    ldd       >U00F7,u  ; load d from >U00F7,u
                    subd      #1        ; subtract from d using #1
                    std       >U00F7,u  ; store d at >U00F7,u
L01CD               lda       U0001,u   ; load a from U0001,u
                    leax      >U0137,u  ; form the address >U0137,u in x
                    ldy       #80       ; set y to the constant 80
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    bcs       L01E5     ; branch when carry reports an error or unsigned underflow; target L01E5
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bhi       L01CD     ; branch when the unsigned value is higher; target L01CD
                    lbra      L015B     ; continue execution at L015B
L01E5               ldd       U000B,u   ; load d from U000B,u
                    std       >U00F9,u  ; store d at >U00F9,u
                    ldd       U000D,u   ; load d from U000D,u
                    std       >U00FB,u  ; store d at >U00FB,u
                    pshs      u         ; save u on the stack
                    lda       U0002,u   ; load a from U0002,u
                    ldx       #0        ; set x to the constant 0
                    ldu       #0        ; set u to the constant 0
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    puls      u         ; restore u from the stack
                    lbcs      L024F     ; branch when carry reports an error or unsigned underflow; target L024F
                    leax      >U00F7,u  ; form the address >U00F7,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       U0002,u   ; load a from U0002,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lda       U0000,u   ; load a from U0000,u
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lbcs      L024F     ; branch when carry reports an error or unsigned underflow; target L024F
                    lda       U0001,u   ; load a from U0001,u
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lbcs      L024F     ; branch when carry reports an error or unsigned underflow; target L024F
                    lda       U0002,u   ; load a from U0002,u
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lbcs      L024F     ; branch when carry reports an error or unsigned underflow; target L024F
                    lda       U0003,u   ; load a from U0003,u
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lbcs      L024F     ; branch when carry reports an error or unsigned underflow; target L024F
                    leax      >L001C,pc ; form the address >L001C,pc in x
                    os9       I$Delete  ; invoke the OS-9 I$Delete service
                    lbcs      L024F     ; branch when carry reports an error or unsigned underflow; target L024F
                    leax      >L0029,pc ; form the address >L0029,pc in x
                    os9       I$Delete  ; invoke the OS-9 I$Delete service
                    lbcs      L024F     ; branch when carry reports an error or unsigned underflow; target L024F
                    lbsr      L025C     ; call subroutine L025C
                    clrb                ; clear b to zero and set the condition codes
L024F               pshs      b         ; save b on the stack
                    ldy       U0009,u   ; load y from U0009,u
                    os9       F$SUser   ; invoke the OS-9 F$SUser service
                    puls      b         ; restore b from the stack
                    os9       F$Exit    ; invoke the OS-9 F$Exit service
L025C               leax      >L00DE,pc ; form the address >L00DE,pc in x
                    lda       #131      ; set a to the constant 131
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L024F     ; branch when carry reports an error or unsigned underflow; target L024F
                    sta       U0007,u   ; store a at U0007,u
                    clr       U0006,u   ; clear U0006,u to zero and set the condition codes
L026D               pshs      u         ; save u on the stack
                    lda       U0006,u   ; load a from U0006,u
                    inca                ; increment a
                    sta       U0006,u   ; store a at U0006,u
                    ldb       #32       ; set b to the constant 32
                    mul                 ; multiply a by b and return the product in d
                    tfr       d,x       ; copy the register values specified by d,x
                    lda       U0007,u   ; load a from U0007,u
                    ldu       #0        ; set u to the constant 0
                    exg       x,u       ; exchange the register values specified by x,u
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    puls      u         ; restore u from the stack
                    leax      U000F,u   ; form the address U000F,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       U0007,u   ; load a from U0007,u
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    bcs       L02B4     ; branch when carry reports an error or unsigned underflow; target L02B4
                    leay      >L00C0,pc ; form the address >L00C0,pc in y
                    leax      U000F,u   ; form the address U000F,u in x
L0298               lda       ,x+       ; load a from ,x+
                    bmi       L02C0     ; branch when the result is negative; target L02C0
                    cmpa      ,y+       ; compare a with ,y+ and set the condition codes
                    bne       L02A2     ; branch when the values differ or the result is nonzero; target L02A2
                    bra       L0298     ; continue execution at L0298
L02A2               leax      U000F,u   ; form the address U000F,u in x
                    leay      >L00D1,pc ; form the address >L00D1,pc in y
L02A8               lda       ,x+       ; load a from ,x+
                    bmi       L02D4     ; branch when the result is negative; target L02D4
                    cmpa      ,y+       ; compare a with ,y+ and set the condition codes
                    bne       L02B2     ; branch when the values differ or the result is nonzero; target L02B2
                    bra       L02A8     ; continue execution at L02A8
L02B2               bra       L026D     ; continue execution at L026D
L02B4               cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      L024F     ; branch when the values differ or the result is nonzero; target L024F
                    lda       U0007,u   ; load a from U0007,u
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    rts                 ; return to the caller
L02C0               anda      #127      ; mask a using #127
                    cmpa      ,y+       ; compare a with ,y+ and set the condition codes
                    bne       L02A2     ; branch when the values differ or the result is nonzero; target L02A2
                    lda       ,y+       ; load a from ,y+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       L02A2     ; branch when the values differ or the result is nonzero; target L02A2
                    leax      U000F,u   ; form the address U000F,u in x
                    leay      >L001C,pc ; form the address >L001C,pc in y
                    bra       L02E6     ; continue execution at L02E6
L02D4               anda      #127      ; mask a using #127
                    cmpa      ,y+       ; compare a with ,y+ and set the condition codes
                    bne       L02B2     ; branch when the values differ or the result is nonzero; target L02B2
                    lda       #13       ; set a to the constant 13
                    cmpa      ,y+       ; compare a with ,y+ and set the condition codes
                    bne       L02B2     ; branch when the values differ or the result is nonzero; target L02B2
                    leax      U000F,u   ; form the address U000F,u in x
                    leay      >L0029,pc ; form the address >L0029,pc in y
L02E6               lda       ,y+       ; load a from ,y+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L02F0     ; branch when the values are equal or the result is zero; target L02F0
                    sta       ,x+       ; store a at ,x+
                    bra       L02E6     ; continue execution at L02E6
L02F0               lda       ,-x       ; load a from ,-x
                    ora       #128      ; set selected bits in a using #128
                    sta       0,x       ; store a at 0,x
                    lda       U0006,u   ; load a from U0006,u
                    ldb       #32       ; set b to the constant 32
                    mul                 ; multiply a by b and return the product in d
                    tfr       d,x       ; copy the register values specified by d,x
                    lda       U0007,u   ; load a from U0007,u
                    ldb       #5        ; set b to the constant 5
                    pshs      u         ; save u on the stack
                    ldu       #0        ; set u to the constant 0
                    exg       x,u       ; exchange the register values specified by x,u
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    lbcs      L024F     ; branch when carry reports an error or unsigned underflow; target L024F
                    puls      u         ; restore u from the stack
                    leax      U000F,u   ; form the address U000F,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       U0007,u   ; load a from U0007,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbra      L026D     ; continue execution at L026D

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
