**********************************************************************
* BBS.mail.post - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       BBS.mail.post
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
U0003               rmb       1         ; reserve 1 byte(s) in the module workspace
U0004               rmb       1         ; reserve 1 byte(s) in the module workspace
U0005               rmb       1         ; reserve 1 byte(s) in the module workspace
U0006               rmb       1         ; reserve 1 byte(s) in the module workspace
U0007               rmb       2         ; reserve 2 byte(s) in the module workspace
U0009               rmb       1         ; reserve 1 byte(s) in the module workspace
U000A               rmb       1         ; reserve 1 byte(s) in the module workspace
U000B               rmb       1         ; reserve 1 byte(s) in the module workspace
U000C               rmb       1         ; reserve 1 byte(s) in the module workspace
U000D               rmb       2         ; reserve 2 byte(s) in the module workspace
U000F               rmb       2         ; reserve 2 byte(s) in the module workspace
U0011               rmb       2         ; reserve 2 byte(s) in the module workspace
U0013               rmb       1         ; reserve 1 byte(s) in the module workspace
U0014               rmb       1         ; reserve 1 byte(s) in the module workspace
U0015               rmb       2         ; reserve 2 byte(s) in the module workspace
U0017               rmb       2         ; reserve 2 byte(s) in the module workspace
U0019               rmb       200       ; reserve 200 byte(s) in the module workspace
U00E1               rmb       200       ; reserve 200 byte(s) in the module workspace
U01A9               rmb       1         ; reserve 1 byte(s) in the module workspace
U01AA               rmb       5         ; reserve 5 byte(s) in the module workspace
U01AF               rmb       1         ; reserve 1 byte(s) in the module workspace
U01B0               rmb       2         ; reserve 2 byte(s) in the module workspace
U01B2               rmb       2         ; reserve 2 byte(s) in the module workspace
U01B4               rmb       60        ; reserve 60 byte(s) in the module workspace
U01F0               rmb       2         ; reserve 2 byte(s) in the module workspace
U01F2               rmb       2         ; reserve 2 byte(s) in the module workspace
U01F4               rmb       20        ; reserve 20 byte(s) in the module workspace
U0208               rmb       30        ; reserve 30 byte(s) in the module workspace
U0226               rmb       6         ; reserve 6 byte(s) in the module workspace
U022C               rmb       2         ; reserve 2 byte(s) in the module workspace
U022E               rmb       2         ; reserve 2 byte(s) in the module workspace
U0230               rmb       8000      ; reserve 8000 byte(s) in the module workspace
U2170               rmb       80        ; reserve 80 byte(s) in the module workspace
U21C0               rmb       1         ; reserve 1 byte(s) in the module workspace
U21C1               rmb       231       ; reserve 231 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.mail.post/ ; store an OS-9 high-bit-terminated string
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
L0085               fcc       "BBS.mail.inx" ; store literal character data
                    fcb       $0D       ; store byte data
L0092               fcc       "BBS.mail" ; store literal character data
                    fcb       $0D       ; store byte data
L009B               fcc       "Enter subject of message" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $0A       ; store byte data
                    fcc       ">" ; store literal character data
L00B6               fcb       $00       ; store byte data
                    fcb       $1B       ; store byte data
L00B8               fcb       $0A       ; store byte data
                    fcb       $0A       ; store byte data
                    fcc       "    Please enter message now            (Blank line ends)" ; store literal character data
                    fcb       $0D       ; store byte data
L00F4               fcc       "----------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
L0135               fcc       "/dd/bbs/BBS.alias" ; store literal character data
                    fcb       $0D       ; store byte data
L0147               fcb       $0A       ; store byte data
                    fcc       "[a]bort [d]one [e]dit [C]ontinue or [L]ist" ; store literal character data
                    fcb       $0D       ; store byte data
L0173               fcc       "Enter line #" ; store literal character data
                    fcb       $0D       ; store byte data
L0180               fcc       ">" ; store literal character data
L0181               fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
L0183               fcc       "Sorry...cannot locate that name" ; store literal character data
                    fcb       $0D       ; store byte data
L01A3               fcc       "Enter the name of the Person to send mail to" ; store literal character data
                    fcb       $0D       ; store byte data
L01D0               fcb       $08       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $08       ; store byte data

start               clr       >U01AF,u  ; clear >U01AF,u to zero and set the condition codes
                    clr       >U01A9,u  ; clear >U01A9,u to zero and set the condition codes
                    clr       U0006,u   ; clear U0006,u to zero and set the condition codes
                    os9       F$ID      ; invoke the OS-9 F$ID service
                    lbcs      L05C5     ; branch when carry reports an error or unsigned underflow; target L05C5
                    sty       U0007,u   ; store y at U0007,u
                    ldy       #0        ; set y to the constant 0
                    os9       F$SUser   ; invoke the OS-9 F$SUser service
                    lbcs      L05C5     ; branch when carry reports an error or unsigned underflow; target L05C5
L01F2               leax      >L01A3,pc ; form the address >L01A3,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L0180,pc ; form the address >L0180,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    clra                ; clear a to zero and set the condition codes
                    leax      >U00E1,u  ; form the address >U00E1,u in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    lbls      L05BE     ; branch when the unsigned value is lower or equal; target L05BE
L021E               lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L022E     ; branch when the values are equal or the result is zero; target L022E
                    cmpa      #97       ; compare a with #97 and set the condition codes
                    bcs       L021E     ; branch when carry reports an error or unsigned underflow; target L021E
                    anda      #223      ; mask a using #223
                    sta       -$01,x    ; store a at -$01,x
                    bra       L021E     ; continue execution at L021E
L022E               leax      >L0135,pc ; form the address >L0135,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L05C5     ; branch when carry reports an error or unsigned underflow; target L05C5
                    sta       U0002,u   ; store a at U0002,u
L023D               leax      <U0019,u  ; form the address <U0019,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       U0002,u   ; load a from U0002,u
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    bcs       L027D     ; branch when carry reports an error or unsigned underflow; target L027D
L024B               lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L025B     ; branch when the values are equal or the result is zero; target L025B
                    cmpa      #97       ; compare a with #97 and set the condition codes
                    bcs       L024B     ; branch when carry reports an error or unsigned underflow; target L024B
                    anda      #223      ; mask a using #223
                    sta       -$01,x    ; store a at -$01,x
                    bra       L024B     ; continue execution at L024B
L025B               leax      <U0019,u  ; form the address <U0019,u in x
                    leay      >U00E1,u  ; form the address >U00E1,u in y
L0262               lda       ,y+       ; load a from ,y+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L026E     ; branch when the values are equal or the result is zero; target L026E
                    cmpa      ,x+       ; compare a with ,x+ and set the condition codes
                    beq       L0262     ; branch when the values are equal or the result is zero; target L0262
                    bra       L023D     ; continue execution at L023D
L026E               lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    bne       L023D     ; branch when the values differ or the result is nonzero; target L023D
                    lbsr      L0758     ; call subroutine L0758
                    std       >U022E,u  ; store d at >U022E,u
                    bra       L0293     ; continue execution at L0293
L027D               cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      L05C5     ; branch when the values differ or the result is nonzero; target L05C5
                    leax      >L0183,pc ; form the address >L0183,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbra      L01F2     ; continue execution at L01F2
L0293               leax      >L0085,pc ; form the address >L0085,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L0806     ; branch when carry reports an error or unsigned underflow; target L0806
                    sta       U0000,u   ; store a at U0000,u
                    leax      >U01B0,u  ; form the address >U01B0,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       U0000,u   ; load a from U0000,u
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lbcs      L05C5     ; branch when carry reports an error or unsigned underflow; target L05C5
                    lda       U0000,u   ; load a from U0000,u
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    leax      >L0085,pc ; form the address >L0085,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L05C5     ; branch when carry reports an error or unsigned underflow; target L05C5
                    sta       U0000,u   ; store a at U0000,u
                    lda       #6        ; set a to the constant 6
                    sta       U0003,u   ; store a at U0003,u
                    ldd       >U01B0,u  ; load d from >U01B0,u
                    addd      #1        ; add to d using #1
                    std       >U01B0,u  ; store d at >U01B0,u
                    clr       U000B,u   ; clear U000B,u to zero and set the condition codes
                    clr       U000C,u   ; clear U000C,u to zero and set the condition codes
L02DA               aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    rol       U000C,u   ; rotate left through carry the value at U000C,u
                    dec       U0003,u   ; decrement the value at U0003,u
                    bne       L02DA     ; branch when the values differ or the result is nonzero; target L02DA
                    std       U000D,u   ; store d at U000D,u
                    lda       U0000,u   ; load a from U0000,u
                    ldx       U000B,u   ; load x from U000B,u
                    pshs      u         ; save u on the stack
                    ldu       U000D,u   ; load u from U000D,u
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    lbcs      L05C5     ; branch when carry reports an error or unsigned underflow; target L05C5
                    puls      u         ; restore u from the stack
                    leax      >U0226,u  ; form the address >U0226,u in x
                    os9       F$Time    ; invoke the OS-9 F$Time service
                    leax      >L009B,pc ; form the address >L009B,pc in x
                    ldy       >L00B6,pc ; load y from >L00B6,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L05C5     ; branch when carry reports an error or unsigned underflow; target L05C5
                    clra                ; clear a to zero and set the condition codes
                    leax      >U0208,u  ; form the address >U0208,u in x
                    ldy       #30       ; set y to the constant 30
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    leax      >L00B8,pc ; form the address >L00B8,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L05C5     ; branch when carry reports an error or unsigned underflow; target L05C5
                    leax      >L00F4,pc ; form the address >L00F4,pc in x
                    ldy       #80       ; set y to the constant 80
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L05C5     ; branch when carry reports an error or unsigned underflow; target L05C5
                    ldd       #0        ; set d to the constant 0
                    std       U0009,u   ; store d at U0009,u
L033F               ldd       U0009,u   ; load d from U0009,u
                    addd      #1        ; add to d using #1
                    std       U0009,u   ; store d at U0009,u
                    cmpd      #99       ; compare d with #99 and set the condition codes
                    bge       L0357     ; branch when the signed value is greater than or equal; target L0357
                    lbsr      L0467     ; call subroutine L0467
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bls       L0357     ; branch when the unsigned value is lower or equal; target L0357
                    bra       L033F     ; continue execution at L033F
L0357               leax      >L0147,pc ; form the address >L0147,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L0180,pc ; form the address >L0180,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      U0005,u   ; form the address U0005,u in x
                    clra                ; clear a to zero and set the condition codes
                    ldy       #1        ; set y to the constant 1
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    leax      >L0181,pc ; form the address >L0181,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lda       U0005,u   ; load a from U0005,u
                    anda      #223      ; mask a using #223
                    cmpa      #65       ; compare a with #65 and set the condition codes
                    lbeq      L05BE     ; branch when the values are equal or the result is zero; target L05BE
                    cmpa      #68       ; compare a with #68 and set the condition codes
                    lbeq      L04BC     ; branch when the values are equal or the result is zero; target L04BC
                    cmpa      #69       ; compare a with #69 and set the condition codes
                    beq       L03AF     ; branch when the values are equal or the result is zero; target L03AF
                    cmpa      #67       ; compare a with #67 and set the condition codes
                    beq       L03A6     ; branch when the values are equal or the result is zero; target L03A6
                    cmpa      #76       ; compare a with #76 and set the condition codes
                    lbeq      L0426     ; branch when the values are equal or the result is zero; target L0426
                    bra       L0357     ; continue execution at L0357
L03A6               ldd       U0009,u   ; load d from U0009,u
                    subd      #1        ; subtract from d using #1
                    std       U0009,u   ; store d at U0009,u
                    bra       L033F     ; continue execution at L033F
L03AF               leax      >L0173,pc ; form the address >L0173,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L0180,pc ; form the address >L0180,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    clra                ; clear a to zero and set the condition codes
                    leax      >U01AA,u  ; form the address >U01AA,u in x
                    ldy       #3        ; set y to the constant 3
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    lbsr      L0758     ; call subroutine L0758
                    cmpd      U0009,u   ; compare d with U0009,u and set the condition codes
                    lbcc      L0357     ; branch when carry is clear; target L0357
                    std       <U0017,u  ; store d at <U0017,u
                    leax      >U01AA,u  ; form the address >U01AA,u in x
                    lbsr      L07C8     ; call subroutine L07C8
                    leax      >U01AA,u  ; form the address >U01AA,u in x
                    lda       #58       ; set a to the constant 58
                    sta       $02,x     ; store a at $02,x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    ldd       <U0017,u  ; load d from <U0017,u
                    leax      >U0230,u  ; form the address >U0230,u in x
                    lda       #80       ; set a to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      d,x       ; form the address d,x in x
                    ldy       #80       ; set y to the constant 80
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    tfr       y,d       ; copy the register values specified by y,d
                    stb       U0006,u   ; store b at U0006,u
                    dec       U0006,u   ; decrement the value at U0006,u
                    leay      >U2170,u  ; form the address >U2170,u in y
L0417               lda       ,x+       ; load a from ,x+
                    sta       ,y+       ; store a at ,y+
                    decb                ; decrement b
                    bne       L0417     ; branch when the values differ or the result is nonzero; target L0417
                    ldd       <U0017,u  ; load d from <U0017,u
                    bsr       L0467     ; call subroutine L0467
                    lbra      L0357     ; continue execution at L0357
L0426               ldd       #0        ; set d to the constant 0
                    std       U0009,u   ; store d at U0009,u
L042B               ldd       U0009,u   ; load d from U0009,u
                    addd      #1        ; add to d using #1
                    std       U0009,u   ; store d at U0009,u
                    leax      >U01AA,u  ; form the address >U01AA,u in x
                    lbsr      L07C8     ; call subroutine L07C8
                    leax      >U01AA,u  ; form the address >U01AA,u in x
                    lda       #58       ; set a to the constant 58
                    sta       $02,x     ; store a at $02,x
                    lda       #1        ; set a to the constant 1
                    ldy       #3        ; set y to the constant 3
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      >U0230,u  ; form the address >U0230,u in x
                    ldd       U0009,u   ; load d from U0009,u
                    lda       #80       ; set a to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      d,x       ; form the address d,x in x
                    ldy       #80       ; set y to the constant 80
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bhi       L042B     ; branch when the unsigned value is higher; target L042B
                    lbra      L0357     ; continue execution at L0357
L0467               leax      >U01AA,u  ; form the address >U01AA,u in x
                    pshs      d         ; save d on the stack
                    lbsr      L07C8     ; call subroutine L07C8
                    leax      >U01AA,u  ; form the address >U01AA,u in x
                    lda       #58       ; set a to the constant 58
                    sta       $02,x     ; store a at $02,x
                    lda       #1        ; set a to the constant 1
                    ldy       #3        ; set y to the constant 3
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L05C5     ; branch when carry reports an error or unsigned underflow; target L05C5
                    leax      >U2170,u  ; form the address >U2170,u in x
                    ldb       U0006,u   ; load b from U0006,u
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    puls      d         ; restore d from the stack
                    lda       #80       ; set a to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      >U0230,u  ; form the address >U0230,u in x
                    leax      d,x       ; form the address d,x in x
                    leay      >U2170,u  ; form the address >U2170,u in y
                    ldb       #80       ; set b to the constant 80
                    lda       U0006,u   ; load a from U0006,u
                    beq       L04B5     ; branch when the values are equal or the result is zero; target L04B5
                    sta       <U0013,u  ; store a at <U0013,u
L04AB               lda       ,y+       ; load a from ,y+
                    sta       ,x+       ; store a at ,x+
                    decb                ; decrement b
                    dec       <U0013,u  ; decrement the value at <U0013,u
                    bne       L04AB     ; branch when the values differ or the result is nonzero; target L04AB
L04B5               clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    lbsr      L05C8     ; call subroutine L05C8
                    rts                 ; return to the caller
L04BC               leax      >L0135,pc ; form the address >L0135,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L05C5     ; branch when carry reports an error or unsigned underflow; target L05C5
                    sta       U0002,u   ; store a at U0002,u
L04CB               leax      <U0019,u  ; form the address <U0019,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       U0002,u   ; load a from U0002,u
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    lbcs      L05C5     ; branch when carry reports an error or unsigned underflow; target L05C5
L04DB               lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    bne       L04DB     ; branch when the values differ or the result is nonzero; target L04DB
                    lbsr      L0758     ; call subroutine L0758
                    cmpd      U0007,u   ; compare d with U0007,u and set the condition codes
                    bne       L04CB     ; branch when the values differ or the result is nonzero; target L04CB
                    leax      <U0019,u  ; form the address <U0019,u in x
                    leay      >U01F4,u  ; form the address >U01F4,u in y
L04F0               lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    beq       L04FA     ; branch when the values are equal or the result is zero; target L04FA
                    sta       ,y+       ; store a at ,y+
                    bra       L04F0     ; continue execution at L04F0
L04FA               lda       #13       ; set a to the constant 13
                    sta       0,y       ; store a at 0,y
                    ldd       >U01B2,u  ; load d from >U01B2,u
                    std       >U01F0,u  ; store d at >U01F0,u
                    ldd       >U01B4,u  ; load d from >U01B4,u
                    std       >U01F2,u  ; store d at >U01F2,u
                    ldd       U0007,u   ; load d from U0007,u
                    std       >U022C,u  ; store d at >U022C,u
                    leax      >U01F0,u  ; form the address >U01F0,u in x
                    lda       U0000,u   ; load a from U0000,u
                    ldy       #64       ; set y to the constant 64
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L05C5     ; branch when carry reports an error or unsigned underflow; target L05C5
                    leax      >L0092,pc ; form the address >L0092,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L05C5     ; branch when carry reports an error or unsigned underflow; target L05C5
                    sta       U0001,u   ; store a at U0001,u
                    pshs      u         ; save u on the stack
                    ldx       >U01B2,u  ; load x from >U01B2,u
                    lda       U0001,u   ; load a from U0001,u
                    ldu       >U01B4,u  ; load u from >U01B4,u
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    lbcs      L05C5     ; branch when carry reports an error or unsigned underflow; target L05C5
                    puls      u         ; restore u from the stack
                    lda       #0        ; set a to the constant 0
                    sta       U000F,u   ; store a at U000F,u
                    ldd       #1        ; set d to the constant 1
                    std       <U0011,u  ; store d at <U0011,u
L0553               lda       U000F,u   ; load a from U000F,u
                    inca                ; increment a
                    sta       U000F,u   ; store a at U000F,u
                    cmpa      U000A,u   ; compare a with U000A,u and set the condition codes
                    bhi       L0582     ; branch when the unsigned value is higher; target L0582
                    ldb       #80       ; set b to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      >U0230,u  ; form the address >U0230,u in x
                    leax      d,x       ; form the address d,x in x
                    ldy       #80       ; set y to the constant 80
                    lda       U0001,u   ; load a from U0001,u
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L05C5     ; branch when carry reports an error or unsigned underflow; target L05C5
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bls       L0582     ; branch when the unsigned value is lower or equal; target L0582
                    tfr       y,d       ; copy the register values specified by y,d
                    addd      <U0011,u  ; add to d using <U0011,u
                    std       <U0011,u  ; store d at <U0011,u
                    bra       L0553     ; continue execution at L0553
L0582               ldd       >U01B4,u  ; load d from >U01B4,u
                    addd      <U0011,u  ; add to d using <U0011,u
                    std       >U01B4,u  ; store d at >U01B4,u
                    bcc       L059A     ; branch when carry is clear; target L059A
                    ldd       >U01B2,u  ; load d from >U01B2,u
                    addd      #1        ; add to d using #1
                    std       >U01B2,u  ; store d at >U01B2,u
L059A               pshs      u         ; save u on the stack
                    lda       U0000,u   ; load a from U0000,u
                    ldx       #0        ; set x to the constant 0
                    ldu       #0        ; set u to the constant 0
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    lbcs      L05C5     ; branch when carry reports an error or unsigned underflow; target L05C5
                    puls      u         ; restore u from the stack
                    leax      >U01B0,u  ; form the address >U01B0,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       U0000,u   ; load a from U0000,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L05C5     ; branch when carry reports an error or unsigned underflow; target L05C5
L05BE               clrb                ; clear b to zero and set the condition codes
                    ldy       U0007,u   ; load y from U0007,u
                    os9       F$SUser   ; invoke the OS-9 F$SUser service
L05C5               os9       F$Exit    ; invoke the OS-9 F$Exit service
L05C8               lbsr      L0721     ; call subroutine L0721
                    ldb       U0006,u   ; load b from U0006,u
                    leay      b,y       ; form the address b,y in y
                    pshs      y         ; save y on the stack
                    negb                ; negate b
                    sex                 ; sign-extend b into d
                    leay      d,y       ; form the address d,y in y
                    clr       U0006,u   ; clear U0006,u to zero and set the condition codes
                    cmpy      #0        ; compare y with #0 and set the condition codes
                    lbeq      L0697     ; branch when the values are equal or the result is zero; target L0697
                    pshs      y,x       ; save y,x on the stack
                    lda       #13       ; set a to the constant 13
L05E3               sta       ,x+       ; store a at ,x+
                    leay      -$01,y    ; form the address -$01,y in y
                    bne       L05E3     ; branch when the values differ or the result is nonzero; target L05E3
                    puls      y,x       ; restore y,x from the stack
L05EB               pshs      y,x       ; save y,x on the stack
                    leax      U0005,u   ; form the address U0005,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    bcs       L0624     ; branch when carry reports an error or unsigned underflow; target L0624
                    lda       U0005,u   ; load a from U0005,u
                    cmpa      #1        ; compare a with #1 and set the condition codes
                    beq       L0628     ; branch when the values are equal or the result is zero; target L0628
                    cmpa      #8        ; compare a with #8 and set the condition codes
                    beq       L064A     ; branch when the values are equal or the result is zero; target L064A
                    cmpa      #24       ; compare a with #24 and set the condition codes
                    beq       L066E     ; branch when the values are equal or the result is zero; target L066E
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      L0695     ; branch when the values are equal or the result is zero; target L0695
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    bcs       L0624     ; branch when carry reports an error or unsigned underflow; target L0624
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    puls      y,x       ; restore y,x from the stack
                    lda       U0005,u   ; load a from U0005,u
                    sta       ,x+       ; store a at ,x+
                    leay      -$01,y    ; form the address -$01,y in y
                    lbeq      L06BE     ; branch when the values are equal or the result is zero; target L06BE
                    bra       L05EB     ; continue execution at L05EB
L0624               puls      y,x       ; restore y,x from the stack
                    bra       L05EB     ; continue execution at L05EB
L0628               puls      y,x       ; restore y,x from the stack
                    leay      -$01,y    ; form the address -$01,y in y
                    beq       L0645     ; branch when the values are equal or the result is zero; target L0645
                    lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L0643     ; branch when the values are equal or the result is zero; target L0643
                    pshs      y,x       ; save y,x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    bra       L0628     ; continue execution at L0628
L0643               leax      -$01,x    ; form the address -$01,x in x
L0645               leay      $01,y     ; form the address $01,y in y
                    lbra      L05EB     ; continue execution at L05EB
L064A               puls      y,x       ; restore y,x from the stack
                    leay      $01,y     ; form the address $01,y in y
                    cmpy      0,s       ; compare y with 0,s and set the condition codes
                    bhi       L0669     ; branch when the unsigned value is higher; target L0669
                    pshs      y,x       ; save y,x on the stack
                    leax      >L01D0,pc ; form the address >L01D0,pc in x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    puls      y,x       ; restore y,x from the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    lbra      L05EB     ; continue execution at L05EB
L0669               leay      -$01,y    ; form the address -$01,y in y
                    lbra      L05EB     ; continue execution at L05EB
L066E               puls      y,x       ; restore y,x from the stack
                    leay      $01,y     ; form the address $01,y in y
                    cmpy      0,s       ; compare y with 0,s and set the condition codes
                    bhi       L0669     ; branch when the unsigned value is higher; target L0669
                    pshs      y,x       ; save y,x on the stack
                    leax      >L01D0,pc ; form the address >L01D0,pc in x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    puls      y,x       ; restore y,x from the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    cmpy      0,s       ; compare y with 0,s and set the condition codes
                    lbhi      L05EB     ; branch when the unsigned value is higher; target L05EB
                    pshs      y,x       ; save y,x on the stack
                    bra       L066E     ; continue execution at L066E
L0695               puls      y,x       ; restore y,x from the stack
L0697               lda       #13       ; set a to the constant 13
                    sta       ,x+       ; store a at ,x+
                    pshs      y,x       ; save y,x on the stack
                    leax      >L0181,pc ; form the address >L0181,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    puls      y,x       ; restore y,x from the stack
                    puls      d         ; restore d from the stack
                    pshs      y         ; save y on the stack
                    subd      0,s       ; subtract from d using 0,s
                    leas      $02,s     ; adjust the system stack pointer
                    tfr       d,y       ; copy the register values specified by d,y
                    leay      $01,y     ; form the address $01,y in y
                    lbsr      L073B     ; call subroutine L073B
                    rts                 ; return to the caller
                    fcc       "50" ; store literal character data
L06BE               puls      d         ; restore d from the stack
                    pshs      y         ; save y on the stack
                    subd      0,s       ; subtract from d using 0,s
                    leas      $02,s     ; adjust the system stack pointer
                    addd      #1        ; add to d using #1
                    tfr       d,y       ; copy the register values specified by d,y
                    clrb                ; clear b to zero and set the condition codes
L06CC               leay      -$01,y    ; form the address -$01,y in y
                    beq       L06EA     ; branch when the values are equal or the result is zero; target L06EA
                    lda       ,-x       ; load a from ,-x
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       L06FB     ; branch when the values are equal or the result is zero; target L06FB
                    pshs      y,x       ; save y,x on the stack
                    leax      >L01D0,pc ; form the address >L01D0,pc in x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    incb                ; increment b
                    puls      y,x       ; restore y,x from the stack
                    bra       L06CC     ; continue execution at L06CC
L06EA               lda       #13       ; set a to the constant 13
                    sta       <$004F,x  ; store a at <$004F,x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    puls      y         ; restore y from the stack
                    rts                 ; return to the caller
L06FB               lda       #13       ; set a to the constant 13
                    sta       ,x+       ; store a at ,x+
                    pshs      y,x       ; save y,x on the stack
                    stb       U0006,u   ; store b at U0006,u
                    leay      >U2170,u  ; form the address >U2170,u in y
L0707               lda       ,x+       ; load a from ,x+
                    sta       ,y+       ; store a at ,y+
                    decb                ; decrement b
                    bne       L0707     ; branch when the values differ or the result is nonzero; target L0707
                    leax      >L0181,pc ; form the address >L0181,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    puls      y,x       ; restore y,x from the stack
                    lbsr      L073B     ; call subroutine L073B
                    rts                 ; return to the caller
L0721               pshs      y,x,d     ; save y,x,d on the stack
                    leax      >U21C0,u  ; form the address >U21C0,u in x
                    clra                ; clear a to zero and set the condition codes
                    ldb       #0        ; set b to the constant 0
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    leax      -$20,x    ; form the address -$20,x in x
                    clr       <$0024,x  ; clear <$0024,x to zero and set the condition codes
                    leax      <$0020,x  ; form the address <$0020,x in x
                    os9       I$SetStt  ; invoke the OS-9 I$SetStt service
                    puls      pc,y,x,d  ; restore pc,y,x,d and return to the caller
L073B               pshs      y,x,d     ; save y,x,d on the stack
                    leax      >U21C0,u  ; form the address >U21C0,u in x
                    clra                ; clear a to zero and set the condition codes
                    ldb       #0        ; set b to the constant 0
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    leax      -$20,x    ; form the address -$20,x in x
                    lda       #1        ; set a to the constant 1
                    sta       <$0024,x  ; store a at <$0024,x
                    leax      <$0020,x  ; form the address <$0020,x in x
                    clra                ; clear a to zero and set the condition codes
                    os9       I$SetStt  ; invoke the OS-9 I$SetStt service
                    puls      pc,y,x,d  ; restore pc,y,x,d and return to the caller
L0758               pshs      y         ; save y on the stack
L075A               lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      L0801     ; branch when the values are equal or the result is zero; target L0801
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L075A     ; branch when carry reports an error or unsigned underflow; target L075A
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L075A     ; branch when the unsigned value is higher; target L075A
                    leax      -$01,x    ; form the address -$01,x in x
L076C               lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L0778     ; branch when carry reports an error or unsigned underflow; target L0778
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L0778     ; branch when the unsigned value is higher; target L0778
                    bra       L076C     ; continue execution at L076C
L0778               pshs      x         ; save x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    clr       <U0013,u  ; clear <U0013,u to zero and set the condition codes
                    clr       <U0014,u  ; clear <U0014,u to zero and set the condition codes
                    ldd       #1        ; set d to the constant 1
                    std       <U0015,u  ; store d at <U0015,u
L0788               lda       ,-x       ; load a from ,-x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L07C1     ; branch when carry reports an error or unsigned underflow; target L07C1
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L07C1     ; branch when the unsigned value is higher; target L07C1
                    suba      #48       ; subtract from a using #48
                    sta       U0004,u   ; store a at U0004,u
                    ldd       #0        ; set d to the constant 0
L0799               tst       U0004,u   ; set condition codes from U0004,u without changing it
                    beq       L07A4     ; branch when the values are equal or the result is zero; target L07A4
                    addd      <U0015,u  ; add to d using <U0015,u
                    dec       U0004,u   ; decrement the value at U0004,u
                    bra       L0799     ; continue execution at L0799
L07A4               addd      <U0013,u  ; add to d using <U0013,u
                    std       <U0013,u  ; store d at <U0013,u
                    lda       #10       ; set a to the constant 10
                    sta       U0004,u   ; store a at U0004,u
                    ldd       #0        ; set d to the constant 0
L07B1               tst       U0004,u   ; set condition codes from U0004,u without changing it
                    beq       L07BC     ; branch when the values are equal or the result is zero; target L07BC
                    addd      <U0015,u  ; add to d using <U0015,u
                    dec       U0004,u   ; decrement the value at U0004,u
                    bra       L07B1     ; continue execution at L07B1
L07BC               std       <U0015,u  ; store d at <U0015,u
                    bra       L0788     ; continue execution at L0788
L07C1               ldd       <U0013,u  ; load d from <U0013,u
                    puls      x         ; restore x from the stack
                    puls      pc,y      ; restore pc,y and return to the caller
L07C8               pshs      y         ; save y on the stack
                    std       <U0013,u  ; store d at <U0013,u
                    lda       #48       ; set a to the constant 48
                    sta       0,x       ; store a at 0,x
                    sta       $01,x     ; store a at $01,x
                    ldd       #10       ; set d to the constant 10
                    std       <U0015,u  ; store d at <U0015,u
                    ldd       <U0013,u  ; load d from <U0013,u
                    bsr       L07EF     ; call subroutine L07EF
                    ldd       #1        ; set d to the constant 1
                    std       <U0015,u  ; store d at <U0015,u
                    ldd       <U0013,u  ; load d from <U0013,u
                    bsr       L07EF     ; call subroutine L07EF
                    lda       #13       ; set a to the constant 13
                    sta       0,x       ; store a at 0,x
                    puls      pc,y      ; restore pc,y and return to the caller
L07EF               subd      <U0015,u  ; subtract from d using <U0015,u
                    bcs       L07F8     ; branch when carry reports an error or unsigned underflow; target L07F8
                    inc       0,x       ; increment the value at 0,x
                    bra       L07EF     ; continue execution at L07EF
L07F8               addd      <U0015,u  ; add to d using <U0015,u
                    std       <U0013,u  ; store d at <U0013,u
                    leax      $01,x     ; form the address $01,x in x
                    rts                 ; return to the caller
L0801               ldd       #-1       ; set d to the constant -1
                    puls      pc,y      ; restore pc,y and return to the caller
L0806               leax      >L0085,pc ; form the address >L0085,pc in x
                    lda       #11       ; set a to the constant 11
                    tfr       a,b       ; copy the register values specified by a,b
                    os9       I$Create  ; invoke the OS-9 I$Create service
                    lbcs      L05C5     ; branch when carry reports an error or unsigned underflow; target L05C5
                    sta       U0000,u   ; store a at U0000,u
                    leax      >L0092,pc ; form the address >L0092,pc in x
                    lda       #11       ; set a to the constant 11
                    tfr       a,b       ; copy the register values specified by a,b
                    os9       I$Create  ; invoke the OS-9 I$Create service
                    lbcs      L05C5     ; branch when carry reports an error or unsigned underflow; target L05C5
                    sta       U0001,u   ; store a at U0001,u
                    leax      >U01B0,u  ; form the address >U01B0,u in x
                    ldd       #0        ; set d to the constant 0
                    std       0,x       ; store d at 0,x
                    std       $02,x     ; store d at $02,x
                    std       $04,x     ; store d at $04,x
                    lda       U0000,u   ; load a from U0000,u
                    ldy       #64       ; set y to the constant 64
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L05C5     ; branch when carry reports an error or unsigned underflow; target L05C5
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lbcs      L05C5     ; branch when carry reports an error or unsigned underflow; target L05C5
                    lda       U0000,u   ; load a from U0000,u
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lda       U0001,u   ; load a from U0001,u
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lbra      L0293     ; continue execution at L0293

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
