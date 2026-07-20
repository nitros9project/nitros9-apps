**********************************************************************
* BBS.build - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       BBS.build
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

U0000               rmb       2         ; reserve 2 byte(s) in the module workspace
U0002               rmb       1         ; reserve 1 byte(s) in the module workspace
U0003               rmb       1         ; reserve 1 byte(s) in the module workspace
U0004               rmb       1         ; reserve 1 byte(s) in the module workspace
U0005               rmb       2         ; reserve 2 byte(s) in the module workspace
U0007               rmb       1         ; reserve 1 byte(s) in the module workspace
U0008               rmb       1         ; reserve 1 byte(s) in the module workspace
U0009               rmb       2         ; reserve 2 byte(s) in the module workspace
U000B               rmb       1         ; reserve 1 byte(s) in the module workspace
U000C               rmb       1         ; reserve 1 byte(s) in the module workspace
U000D               rmb       2         ; reserve 2 byte(s) in the module workspace
U000F               rmb       2         ; reserve 2 byte(s) in the module workspace
U0011               rmb       3         ; reserve 3 byte(s) in the module workspace
U0014               rmb       80        ; reserve 80 byte(s) in the module workspace
U0064               rmb       32        ; reserve 32 byte(s) in the module workspace
U0084               rmb       1         ; reserve 1 byte(s) in the module workspace
U0085               rmb       8199      ; reserve 8199 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.build/ ; store an OS-9 high-bit-terminated string
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
L0081               fcb       $0A       ; store byte data
                    fcb       $0A       ; store byte data
                    fcc       "    Please enter message now            (Blank line ends)" ; store literal character data
                    fcb       $0D       ; store byte data
L00BD               fcc       "----------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
L00FE               fcb       $0A       ; store byte data
                    fcc       "[a]bort [d]one [e]dit [C]ontinue or [L]ist" ; store literal character data
                    fcb       $0D       ; store byte data
L012A               fcc       "Enter line #" ; store literal character data
                    fcb       $0D       ; store byte data
L0137               fcc       ">" ; store literal character data
L0138               fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
L013A               fcb       $08       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $08       ; store byte data

start               stx       U0005,u   ; store x at U0005,u
                    lda       #2        ; set a to the constant 2
                    ldb       #27       ; set b to the constant 27
                    os9       I$Create  ; invoke the OS-9 I$Create service
                    lbcs      ErrExit   ; branch when carry reports an error or unsigned underflow; target ErrExit
                    sta       U0000,u   ; store a at U0000,u
                    leax      >L0081,pc ; form the address >L0081,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      ErrExit   ; branch when carry reports an error or unsigned underflow; target ErrExit
                    leax      >L00BD,pc ; form the address >L00BD,pc in x
                    ldy       #80       ; set y to the constant 80
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      ErrExit   ; branch when carry reports an error or unsigned underflow; target ErrExit
                    ldd       #0        ; set d to the constant 0
                    std       U0007,u   ; store d at U0007,u
                    sta       U0004,u   ; store a at U0004,u
L0173               ldd       U0007,u   ; load d from U0007,u
                    addd      #1        ; add to d using #1
                    std       U0007,u   ; store d at U0007,u
                    cmpd      #99       ; compare d with #99 and set the condition codes
                    bge       L018B     ; branch when the signed value is greater than or equal; target L018B
                    lbsr      L0290     ; call subroutine L0290
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bls       L018B     ; branch when the unsigned value is lower or equal; target L018B
                    bra       L0173     ; continue execution at L0173

L018B               leax      >L00FE,pc ; form the address >L00FE,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L0137,pc ; form the address >L0137,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      U0003,u   ; form the address U0003,u in x
                    clra                ; clear a to zero and set the condition codes
                    ldy       #1        ; set y to the constant 1
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    leax      >L0138,pc ; form the address >L0138,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lda       U0003,u   ; load a from U0003,u
                    anda      #223      ; mask a using #223
                    cmpa      #65       ; compare a with #65 and set the condition codes
                    lbeq      L0310     ; branch when the values are equal or the result is zero; target L0310
                    cmpa      #68       ; compare a with #68 and set the condition codes
                    lbeq      L02DF     ; branch when the values are equal or the result is zero; target L02DF
                    cmpa      #69       ; compare a with #69 and set the condition codes
                    beq       L01E1     ; branch when the values are equal or the result is zero; target L01E1
                    cmpa      #67       ; compare a with #67 and set the condition codes
                    beq       L01D8     ; branch when the values are equal or the result is zero; target L01D8
                    cmpa      #76       ; compare a with #76 and set the condition codes
                    beq       L0251     ; branch when the values are equal or the result is zero; target L0251
                    bra       L018B     ; continue execution at L018B

L01D8               ldd       U0007,u   ; load d from U0007,u
                    subd      #1        ; subtract from d using #1
                    std       U0007,u   ; store d at U0007,u
                    bra       L0173     ; continue execution at L0173

L01E1               leax      >L012A,pc ; form the address >L012A,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L0137,pc ; form the address >L0137,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    clra                ; clear a to zero and set the condition codes
                    leax      <U0011,u  ; form the address <U0011,u in x
                    ldy       #3        ; set y to the constant 3
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    lbsr      L04AD     ; call subroutine L04AD
                    cmpd      U0007,u   ; compare d with U0007,u and set the condition codes
                    lbcc      L018B     ; branch when carry is clear; target L018B
                    std       U000F,u   ; store d at U000F,u
                    leax      <U0011,u  ; form the address <U0011,u in x
                    lbsr      L0514     ; call subroutine L0514
                    leax      <U0011,u  ; form the address <U0011,u in x
                    lda       #58       ; set a to the constant 58
                    sta       $02,x     ; store a at $02,x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    ldd       U000F,u   ; load d from U000F,u
                    leax      >U0084,u  ; form the address >U0084,u in x
                    lda       #80       ; set a to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      d,x       ; form the address d,x in x
                    ldy       #80       ; set y to the constant 80
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    tfr       y,d       ; copy the register values specified by y,d
                    stb       U0004,u   ; store b at U0004,u
                    dec       U0004,u   ; decrement the value at U0004,u
                    leay      <U0014,u  ; form the address <U0014,u in y
L0243               lda       ,x+       ; load a from ,x+
                    sta       ,y+       ; store a at ,y+
                    decb                ; decrement b
                    bne       L0243     ; branch when the values differ or the result is nonzero; target L0243
                    ldd       U000F,u   ; load d from U000F,u
                    bsr       L0290     ; call subroutine L0290
                    lbra      L018B     ; continue execution at L018B

L0251               ldd       #0        ; set d to the constant 0
                    std       U0007,u   ; store d at U0007,u
L0256               ldd       U0007,u   ; load d from U0007,u
                    addd      #1        ; add to d using #1
                    std       U0007,u   ; store d at U0007,u
                    leax      <U0011,u  ; form the address <U0011,u in x
                    lbsr      L0514     ; call subroutine L0514
                    leax      <U0011,u  ; form the address <U0011,u in x
                    lda       #58       ; set a to the constant 58
                    sta       $02,x     ; store a at $02,x
                    lda       #1        ; set a to the constant 1
                    ldy       #3        ; set y to the constant 3
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      >U0084,u  ; form the address >U0084,u in x
                    ldd       U0007,u   ; load d from U0007,u
                    lda       #80       ; set a to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      d,x       ; form the address d,x in x
                    ldy       #80       ; set y to the constant 80
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bhi       L0256     ; branch when the unsigned value is higher; target L0256
                    lbra      L018B     ; continue execution at L018B

L0290               leax      <U0011,u  ; form the address <U0011,u in x
                    pshs      d         ; save d on the stack
                    lbsr      L0514     ; call subroutine L0514
                    leax      <U0011,u  ; form the address <U0011,u in x
                    lda       #58       ; set a to the constant 58
                    sta       $02,x     ; store a at $02,x
                    lda       #1        ; set a to the constant 1
                    ldy       #3        ; set y to the constant 3
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      ErrExit   ; branch when carry reports an error or unsigned underflow; target ErrExit
                    leax      <U0014,u  ; form the address <U0014,u in x
                    ldb       U0004,u   ; load b from U0004,u
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    puls      d         ; restore d from the stack
                    lda       #80       ; set a to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      >U0084,u  ; form the address >U0084,u in x
                    leax      d,x       ; form the address d,x in x
                    leay      <U0014,u  ; form the address <U0014,u in y
                    ldb       #80       ; set b to the constant 80
                    lda       U0004,u   ; load a from U0004,u
                    beq       L02D8     ; branch when the values are equal or the result is zero; target L02D8
                    sta       U000B,u   ; store a at U000B,u
L02CF               lda       ,y+       ; load a from ,y+
                    sta       ,x+       ; store a at ,x+
                    decb                ; decrement b
                    dec       U000B,u   ; decrement the value at U000B,u
                    bne       L02CF     ; branch when the values differ or the result is nonzero; target L02CF
L02D8               clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    lbsr      L0320     ; call subroutine L0320
                    rts                 ; return to the caller

L02DF               lda       #0        ; set a to the constant 0
                    sta       U0009,u   ; store a at U0009,u
L02E3               lda       U0009,u   ; load a from U0009,u
                    inca                ; increment a
                    sta       U0009,u   ; store a at U0009,u
                    cmpa      U0008,u   ; compare a with U0008,u and set the condition codes
                    bhi       Exit      ; branch when the unsigned value is higher; target Exit
                    ldb       #80       ; set b to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      >U0084,u  ; form the address >U0084,u in x
                    leax      d,x       ; form the address d,x in x
                    ldy       #80       ; set y to the constant 80
                    lda       U0000,u   ; load a from U0000,u
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      ErrExit   ; branch when carry reports an error or unsigned underflow; target ErrExit
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bls       Exit      ; branch when the unsigned value is lower or equal; target Exit
                    tfr       y,d       ; copy the register values specified by y,d
                    bra       L02E3     ; continue execution at L02E3

Exit                clrb                ; clear b to zero and set the condition codes
ErrExit             os9       F$Exit    ; invoke the OS-9 F$Exit service

L0310               lda       U0000,u   ; load a from U0000,u
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    ldx       U0005,u   ; load x from U0005,u
                    lda       #1        ; set a to the constant 1
                    os9       I$Delete  ; invoke the OS-9 I$Delete service
                    bcs       ErrExit   ; branch when carry reports an error or unsigned underflow; target ErrExit
                    bra       Exit      ; continue execution at Exit

L0320               lbsr      L0478     ; call subroutine L0478
                    ldb       U0004,u   ; load b from U0004,u
                    leay      b,y       ; form the address b,y in y
                    pshs      y         ; save y on the stack
                    negb                ; negate b
                    sex                 ; sign-extend b into d
                    leay      d,y       ; form the address d,y in y
                    clr       U0004,u   ; clear U0004,u to zero and set the condition codes
                    cmpy      #0        ; compare y with #0 and set the condition codes
                    lbeq      L03EF     ; branch when the values are equal or the result is zero; target L03EF
                    pshs      y,x       ; save y,x on the stack
                    lda       #13       ; set a to the constant 13
L033B               sta       ,x+       ; store a at ,x+
                    leay      -$01,y    ; form the address -$01,y in y
                    bne       L033B     ; branch when the values differ or the result is nonzero; target L033B
                    puls      y,x       ; restore y,x from the stack
L0343               pshs      y,x       ; save y,x on the stack
                    leax      U0003,u   ; form the address U0003,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    bcs       L037C     ; branch when carry reports an error or unsigned underflow; target L037C
                    lda       U0003,u   ; load a from U0003,u
                    cmpa      #1        ; compare a with #1 and set the condition codes
                    beq       L0380     ; branch when the values are equal or the result is zero; target L0380
                    cmpa      #8        ; compare a with #8 and set the condition codes
                    beq       L03A2     ; branch when the values are equal or the result is zero; target L03A2
                    cmpa      #24       ; compare a with #24 and set the condition codes
                    beq       L03C6     ; branch when the values are equal or the result is zero; target L03C6
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      L03ED     ; branch when the values are equal or the result is zero; target L03ED
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    bcs       L037C     ; branch when carry reports an error or unsigned underflow; target L037C
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    puls      y,x       ; restore y,x from the stack
                    lda       U0003,u   ; load a from U0003,u
                    sta       ,x+       ; store a at ,x+
                    leay      -$01,y    ; form the address -$01,y in y
                    lbeq      L0416     ; branch when the values are equal or the result is zero; target L0416
                    bra       L0343     ; continue execution at L0343

L037C               puls      y,x       ; restore y,x from the stack
                    bra       L0343     ; continue execution at L0343

L0380               puls      y,x       ; restore y,x from the stack
                    leay      -$01,y    ; form the address -$01,y in y
                    beq       L039D     ; branch when the values are equal or the result is zero; target L039D
                    lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L039B     ; branch when the values are equal or the result is zero; target L039B
                    pshs      y,x       ; save y,x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    bra       L0380     ; continue execution at L0380

L039B               leax      -$01,x    ; form the address -$01,x in x
L039D               leay      $01,y     ; form the address $01,y in y
                    lbra      L0343     ; continue execution at L0343

L03A2               puls      y,x       ; restore y,x from the stack
                    leay      $01,y     ; form the address $01,y in y
                    cmpy      0,s       ; compare y with 0,s and set the condition codes
                    bhi       L03C1     ; branch when the unsigned value is higher; target L03C1
                    pshs      y,x       ; save y,x on the stack
                    leax      >L013A,pc ; form the address >L013A,pc in x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    puls      y,x       ; restore y,x from the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    lbra      L0343     ; continue execution at L0343

L03C1               leay      -$01,y    ; form the address -$01,y in y
                    lbra      L0343     ; continue execution at L0343

L03C6               puls      y,x       ; restore y,x from the stack
                    leay      $01,y     ; form the address $01,y in y
                    cmpy      0,s       ; compare y with 0,s and set the condition codes
                    bhi       L03C1     ; branch when the unsigned value is higher; target L03C1
                    pshs      y,x       ; save y,x on the stack
                    leax      >L013A,pc ; form the address >L013A,pc in x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    puls      y,x       ; restore y,x from the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    cmpy      0,s       ; compare y with 0,s and set the condition codes
                    lbhi      L0343     ; branch when the unsigned value is higher; target L0343
                    pshs      y,x       ; save y,x on the stack
                    bra       L03C6     ; continue execution at L03C6

L03ED               puls      y,x       ; restore y,x from the stack
L03EF               lda       #13       ; set a to the constant 13
                    sta       ,x+       ; store a at ,x+
                    pshs      y,x       ; save y,x on the stack
                    leax      >L0138,pc ; form the address >L0138,pc in x
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
                    lbsr      L0491     ; call subroutine L0491
                    rts                 ; return to the caller

                    fcc       "50" ; store literal character data

L0416               puls      d         ; restore d from the stack
                    pshs      y         ; save y on the stack
                    subd      0,s       ; subtract from d using 0,s
                    leas      $02,s     ; adjust the system stack pointer
                    addd      #1        ; add to d using #1
                    tfr       d,y       ; copy the register values specified by d,y
                    clrb                ; clear b to zero and set the condition codes
L0424               leay      -$01,y    ; form the address -$01,y in y
                    beq       L0442     ; branch when the values are equal or the result is zero; target L0442
                    lda       ,-x       ; load a from ,-x
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       L0453     ; branch when the values are equal or the result is zero; target L0453
                    pshs      y,x       ; save y,x on the stack
                    leax      >L013A,pc ; form the address >L013A,pc in x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    incb                ; increment b
                    puls      y,x       ; restore y,x from the stack
                    bra       L0424     ; continue execution at L0424

L0442               lda       #13       ; set a to the constant 13
                    sta       <$004F,x  ; store a at <$004F,x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    puls      y         ; restore y from the stack
                    rts                 ; return to the caller

L0453               lda       #13       ; set a to the constant 13
                    sta       ,x+       ; store a at ,x+
                    pshs      y,x       ; save y,x on the stack
                    stb       U0004,u   ; store b at U0004,u
                    leay      <U0014,u  ; form the address <U0014,u in y
L045E               lda       ,x+       ; load a from ,x+
                    sta       ,y+       ; store a at ,y+
                    decb                ; decrement b
                    bne       L045E     ; branch when the values differ or the result is nonzero; target L045E
                    leax      >L0138,pc ; form the address >L0138,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    puls      y,x       ; restore y,x from the stack
                    lbsr      L0491     ; call subroutine L0491
                    rts                 ; return to the caller

L0478               pshs      y,x,d     ; save y,x,d on the stack
                    leax      <U0064,u  ; form the address <U0064,u in x
                    clra                ; clear a to zero and set the condition codes
                    ldb       #0        ; set b to the constant 0
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    leax      -$20,x    ; form the address -$20,x in x
                    clr       <$0024,x  ; clear <$0024,x to zero and set the condition codes
                    leax      <$0020,x  ; form the address <$0020,x in x
                    os9       I$SetStt  ; invoke the OS-9 I$SetStt service
                    puls      pc,y,x,d  ; restore pc,y,x,d and return to the caller

L0491               pshs      y,x,d     ; save y,x,d on the stack
                    leax      <U0064,u  ; form the address <U0064,u in x
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

L04AD               pshs      y         ; save y on the stack
L04AF               lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      L0545     ; branch when the values are equal or the result is zero; target L0545
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L04AF     ; branch when carry reports an error or unsigned underflow; target L04AF
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L04AF     ; branch when the unsigned value is higher; target L04AF
                    leax      -$01,x    ; form the address -$01,x in x
L04C1               lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L04CD     ; branch when carry reports an error or unsigned underflow; target L04CD
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L04CD     ; branch when the unsigned value is higher; target L04CD
                    bra       L04C1     ; continue execution at L04C1

L04CD               pshs      x         ; save x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    clr       U000B,u   ; clear U000B,u to zero and set the condition codes
                    clr       U000C,u   ; clear U000C,u to zero and set the condition codes
                    ldd       #1        ; set d to the constant 1
                    std       U000D,u   ; store d at U000D,u
L04DA               lda       ,-x       ; load a from ,-x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L050E     ; branch when carry reports an error or unsigned underflow; target L050E
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L050E     ; branch when the unsigned value is higher; target L050E
                    suba      #48       ; subtract from a using #48
                    sta       U0002,u   ; store a at U0002,u
                    ldd       #0        ; set d to the constant 0
L04EB               tst       U0002,u   ; set condition codes from U0002,u without changing it
                    beq       L04F5     ; branch when the values are equal or the result is zero; target L04F5
                    addd      U000D,u   ; add to d using U000D,u
                    dec       U0002,u   ; decrement the value at U0002,u
                    bra       L04EB     ; continue execution at L04EB

L04F5               addd      U000B,u   ; add to d using U000B,u
                    std       U000B,u   ; store d at U000B,u
                    lda       #10       ; set a to the constant 10
                    sta       U0002,u   ; store a at U0002,u
                    ldd       #0        ; set d to the constant 0
L0500               tst       U0002,u   ; set condition codes from U0002,u without changing it
                    beq       L050A     ; branch when the values are equal or the result is zero; target L050A
                    addd      U000D,u   ; add to d using U000D,u
                    dec       U0002,u   ; decrement the value at U0002,u
                    bra       L0500     ; continue execution at L0500

L050A               std       U000D,u   ; store d at U000D,u
                    bra       L04DA     ; continue execution at L04DA
L050E               ldd       U000B,u   ; load d from U000B,u
                    puls      x         ; restore x from the stack
                    puls      pc,y      ; restore pc,y and return to the caller

L0514               pshs      y         ; save y on the stack
                    std       U000B,u   ; store d at U000B,u
                    lda       #48       ; set a to the constant 48
                    sta       0,x       ; store a at 0,x
                    sta       $01,x     ; store a at $01,x
                    ldd       #10       ; set d to the constant 10
                    std       U000D,u   ; store d at U000D,u
                    ldd       U000B,u   ; load d from U000B,u
                    bsr       L0536     ; call subroutine L0536
                    ldd       #1        ; set d to the constant 1
                    std       U000D,u   ; store d at U000D,u
                    ldd       U000B,u   ; load d from U000B,u
                    bsr       L0536     ; call subroutine L0536
                    lda       #13       ; set a to the constant 13
                    sta       0,x       ; store a at 0,x
                    puls      pc,y      ; restore pc,y and return to the caller

L0536               subd      U000D,u   ; subtract from d using U000D,u
                    bcs       L053E     ; branch when carry reports an error or unsigned underflow; target L053E
                    inc       0,x       ; increment the value at 0,x
                    bra       L0536     ; continue execution at L0536

L053E               addd      U000D,u   ; add to d using U000D,u
                    std       U000B,u   ; store d at U000B,u
                    leax      $01,x     ; form the address $01,x in x
                    rts                 ; return to the caller

L0545               ldd       #-1       ; set d to the constant -1
                    puls      pc,y      ; restore pc,y and return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
