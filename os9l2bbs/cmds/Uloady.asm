**********************************************************************
* Uloady - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       Uloady
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
U0006               rmb       2         ; reserve 2 byte(s) in the module workspace
U0008               rmb       2         ; reserve 2 byte(s) in the module workspace
U000A               rmb       2         ; reserve 2 byte(s) in the module workspace
U000C               rmb       2         ; reserve 2 byte(s) in the module workspace
U000E               rmb       1         ; reserve 1 byte(s) in the module workspace
U000F               rmb       1         ; reserve 1 byte(s) in the module workspace
U0010               rmb       2         ; reserve 2 byte(s) in the module workspace
U0012               rmb       32        ; reserve 32 byte(s) in the module workspace
U0032               rmb       1         ; reserve 1 byte(s) in the module workspace
U0033               rmb       1         ; reserve 1 byte(s) in the module workspace
U0034               rmb       128       ; reserve 128 byte(s) in the module workspace
U00B4               rmb       896       ; reserve 896 byte(s) in the module workspace
U0434               rmb       2         ; reserve 2 byte(s) in the module workspace
U0436               rmb       32        ; reserve 32 byte(s) in the module workspace
U0456               rmb       1         ; reserve 1 byte(s) in the module workspace
U0457               rmb       431       ; reserve 431 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /Uloady/ ; store an OS-9 high-bit-terminated string
                    fcc       "Copyright (C) 1988By Keith AlphonsoLicenced to Alpha Software TechnologiesAll rights reserved" ; store literal character data
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
L007E               fcc       "File open, ready to recieve..." ; store literal character data
                    fcb       $0D       ; store byte data
L009D               fcc       "Enter filename to upload: " ; store literal character data
L00B7               fcc       "Upload aborted!" ; store literal character data
                    fcb       $0D       ; store byte data
L00C7               fcc       "Upload successful!" ; store literal character data
                    fcb       $0D       ; store byte data
start               pshs      x         ; save x on the stack
                    os9       F$ID      ; invoke the OS-9 F$ID service
                    ldb       #255      ; set b to the constant 255
                    os9       F$SPrior  ; invoke the OS-9 F$SPrior service
                    lda       0,x       ; load a from 0,x
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       L0102     ; branch when the values differ or the result is nonzero; target L0102
                    leax      >L009D,pc ; form the address >L009D,pc in x
                    ldy       #25       ; set y to the constant 25
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      <U0012,u  ; form the address <U0012,u in x
                    ldy       #32       ; set y to the constant 32
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
L0102               stx       <U0010,u  ; store x at <U0010,u
                    lda       #2        ; set a to the constant 2
                    ldb       #27       ; set b to the constant 27
                    os9       I$Create  ; invoke the OS-9 I$Create service
                    lbcs      L03ED     ; branch when carry reports an error or unsigned underflow; target L03ED
                    sta       U0001,u   ; store a at U0001,u
                    clr       U0003,u   ; clear U0003,u to zero and set the condition codes
                    clr       U0002,u   ; clear U0002,u to zero and set the condition codes
                    clr       >U00B4,u  ; clear >U00B4,u to zero and set the condition codes
                    dec       >U00B4,u  ; decrement the value at >U00B4,u
                    leax      >L007E,pc ; form the address >L007E,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lda       #6        ; set a to the constant 6
                    sta       U0008,u   ; store a at U0008,u
                    leax      >U0436,u  ; form the address >U0436,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    lbcs      L03ED     ; branch when carry reports an error or unsigned underflow; target L03ED
                    leax      >U0456,u  ; form the address >U0456,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    lbcs      L03ED     ; branch when carry reports an error or unsigned underflow; target L03ED
                    leax      >U0456,u  ; form the address >U0456,u in x
                    leax      -$20,x    ; form the address -$20,x in x
                    clr       <$002B,x  ; clear <$002B,x to zero and set the condition codes
                    clr       <$002C,x  ; clear <$002C,x to zero and set the condition codes
                    clr       <$002E,x  ; clear <$002E,x to zero and set the condition codes
                    clr       <$002F,x  ; clear <$002F,x to zero and set the condition codes
                    clr       <$0030,x  ; clear <$0030,x to zero and set the condition codes
                    clr       <$0031,x  ; clear <$0031,x to zero and set the condition codes
                    clr       <$0038,x  ; clear <$0038,x to zero and set the condition codes
                    clr       <$0039,x  ; clear <$0039,x to zero and set the condition codes
                    clr       <$0024,x  ; clear <$0024,x to zero and set the condition codes
                    clr       <$002D,x  ; clear <$002D,x to zero and set the condition codes
                    clr       <$0027,x  ; clear <$0027,x to zero and set the condition codes
                    clr       <$0028,x  ; clear <$0028,x to zero and set the condition codes
                    clr       <$0029,x  ; clear <$0029,x to zero and set the condition codes
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    leax      >U0456,u  ; form the address >U0456,u in x
                    os9       I$SetStt  ; invoke the OS-9 I$SetStt service
L0180               tst       U0008,u   ; set condition codes from U0008,u without changing it
                    beq       L018C     ; branch when the values are equal or the result is zero; target L018C
                    dec       U0008,u   ; decrement the value at U0008,u
                    lda       #67       ; set a to the constant 67
                    sta       U0000,u   ; store a at U0000,u
                    bra       L0190     ; continue execution at L0190
L018C               lda       #21       ; set a to the constant 21
                    sta       U0000,u   ; store a at U0000,u
L0190               leax      U0000,u   ; form the address U0000,u in x
                    lda       #1        ; set a to the constant 1
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    clr       U0004,u   ; clear U0004,u to zero and set the condition codes
                    clr       U0005,u   ; clear U0005,u to zero and set the condition codes
                    lda       U0003,u   ; load a from U0003,u
                    inca                ; increment a
                    sta       U0003,u   ; store a at U0003,u
                    cmpa      #10       ; compare a with #10 and set the condition codes
                    bcs       L01AD     ; branch when carry reports an error or unsigned underflow; target L01AD
                    ldb       #1        ; set b to the constant 1
                    lbra      L03E6     ; continue execution at L03E6
L01AD               clra                ; clear a to zero and set the condition codes
                    ldb       #1        ; set b to the constant 1
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    bcc       L01C5     ; branch when carry is clear; target L01C5
                    ldy       U0004,u   ; load y from U0004,u
                    leay      $01,y     ; form the address $01,y in y
                    sty       U0004,u   ; store y at U0004,u
                    cmpy      #5376     ; compare y with #5376 and set the condition codes
                    bcc       L0180     ; branch when carry is clear; target L0180
                    bra       L01AD     ; continue execution at L01AD
L01C5               leax      U0000,u   ; form the address U0000,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lda       U0000,u   ; load a from U0000,u
                    cmpa      #1        ; compare a with #1 and set the condition codes
                    beq       L020A     ; branch when the values are equal or the result is zero; target L020A
                    cmpa      #2        ; compare a with #2 and set the condition codes
                    beq       L01E7     ; branch when the values are equal or the result is zero; target L01E7
                    cmpa      #4        ; compare a with #4 and set the condition codes
                    lbeq      L03C1     ; branch when the values are equal or the result is zero; target L03C1
                    cmpa      #24       ; compare a with #24 and set the condition codes
                    lbeq      L03F0     ; branch when the values are equal or the result is zero; target L03F0
                    bra       L01AD     ; continue execution at L01AD
L01E7               leax      <U0032,u  ; form the address <U0032,u in x
                    tst       U0008,u   ; set condition codes from U0008,u without changing it
                    beq       L01F4     ; branch when the values are equal or the result is zero; target L01F4
                    ldy       #1028     ; set y to the constant 1028
                    bra       L01F8     ; continue execution at L01F8
L01F4               ldy       #1027     ; set y to the constant 1027
L01F8               sty       U0006,u   ; store y at U0006,u
                    clr       U0004,u   ; clear U0004,u to zero and set the condition codes
                    clr       U0005,u   ; clear U0005,u to zero and set the condition codes
                    bsr       L022D     ; call subroutine L022D
                    lbcs      L018C     ; branch when carry reports an error or unsigned underflow; target L018C
                    inc       U0002,u   ; increment the value at U0002,u
                    lbra      L0311     ; continue execution at L0311
L020A               leax      <U0032,u  ; form the address <U0032,u in x
                    tst       U0008,u   ; set condition codes from U0008,u without changing it
                    beq       L0217     ; branch when the values are equal or the result is zero; target L0217
                    ldy       #132      ; set y to the constant 132
                    bra       L021B     ; continue execution at L021B
L0217               ldy       #131      ; set y to the constant 131
L021B               sty       U0006,u   ; store y at U0006,u
                    clr       U0004,u   ; clear U0004,u to zero and set the condition codes
                    clr       U0005,u   ; clear U0005,u to zero and set the condition codes
                    bsr       L022D     ; call subroutine L022D
                    lbcs      L018C     ; branch when carry reports an error or unsigned underflow; target L018C
                    inc       U0002,u   ; increment the value at U0002,u
                    lbra      L027F     ; continue execution at L027F
L022D               clra                ; clear a to zero and set the condition codes
                    ldb       #1        ; set b to the constant 1
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    bcc       L0245     ; branch when carry is clear; target L0245
                    ldy       U0004,u   ; load y from U0004,u
                    leay      $01,y     ; form the address $01,y in y
                    sty       U0004,u   ; store y at U0004,u
                    cmpy      #4096     ; compare y with #4096 and set the condition codes
                    bhi       L0261     ; branch when the unsigned value is higher; target L0261
                    bra       L022D     ; continue execution at L022D
L0245               clr       U0004,u   ; clear U0004,u to zero and set the condition codes
                    clr       U0005,u   ; clear U0005,u to zero and set the condition codes
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    bcs       L0265     ; branch when carry reports an error or unsigned underflow; target L0265
                    tfr       y,d       ; copy the register values specified by y,d
                    leax      d,x       ; form the address d,x in x
                    ldd       U0006,u   ; load d from U0006,u
                    sty       U0006,u   ; store y at U0006,u
                    subd      U0006,u   ; subtract from d using U0006,u
                    std       U0006,u   ; store d at U0006,u
                    bne       L022D     ; branch when the values differ or the result is nonzero; target L022D
                    rts                 ; return to the caller
L0261               lda       #255      ; set a to the constant 255
                    rola                ; rotate a left through carry
                    rts                 ; return to the caller
L0265               pshs      x         ; save x on the stack
                    ldx       #60       ; set x to the constant 60
                    os9       F$Sleep   ; invoke the OS-9 F$Sleep service
                    puls      x         ; restore x from the stack
                    clra                ; clear a to zero and set the condition codes
                    ldb       #1        ; set b to the constant 1
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lda       #255      ; set a to the constant 255
                    rola                ; rotate a left through carry
                    rts                 ; return to the caller
L027F               lda       <U0032,u  ; load a from <U0032,u
                    inca                ; increment a
                    cmpa      U0002,u   ; compare a with U0002,u and set the condition codes
                    lbeq      L03A5     ; branch when the values are equal or the result is zero; target L03A5
                    deca                ; decrement a
                    cmpa      U0002,u   ; compare a with U0002,u and set the condition codes
                    beq       L0293     ; branch when the values are equal or the result is zero; target L0293
                    dec       U0002,u   ; decrement the value at U0002,u
                    lbra      L018C     ; continue execution at L018C
L0293               coma                ; complement every bit in a
                    cmpa      <U0033,u  ; compare a with <U0033,u and set the condition codes
                    beq       L029E     ; branch when the values are equal or the result is zero; target L029E
                    dec       U0002,u   ; decrement the value at U0002,u
                    lbra      L018C     ; continue execution at L018C
L029E               leax      <U0034,u  ; form the address <U0034,u in x
                    tst       U0008,u   ; set condition codes from U0008,u without changing it
                    bne       L02BA     ; branch when the values differ or the result is nonzero; target L02BA
                    ldb       #128      ; set b to the constant 128
                    clra                ; clear a to zero and set the condition codes
L02A8               adda      ,x+       ; add to a using ,x+
                    decb                ; decrement b
                    bne       L02A8     ; branch when the values differ or the result is nonzero; target L02A8
                    cmpa      >U00B4,u  ; compare a with >U00B4,u and set the condition codes
                    lbeq      L0302     ; branch when the values are equal or the result is zero; target L0302
                    dec       U0002,u   ; decrement the value at U0002,u
                    lbra      L018C     ; continue execution at L018C
L02BA               ldy       #128      ; set y to the constant 128
                    sty       U000A,u   ; store y at U000A,u
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       U000E,u   ; store d at U000E,u
L02C5               lda       ,x+       ; load a from ,x+
                    clrb                ; clear b to zero and set the condition codes
                    eora      U000E,u   ; toggle selected bits in a using U000E,u
                    eorb      U000F,u   ; toggle selected bits in b using U000F,u
                    std       U000E,u   ; store d at U000E,u
                    lda       #8        ; set a to the constant 8
                    sta       U000C,u   ; store a at U000C,u
L02D2               ldd       U000E,u   ; load d from U000E,u
                    bita      #128      ; test selected bits in a using #128
                    beq       L02E2     ; branch when the values are equal or the result is zero; target L02E2
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    eora      #16       ; toggle selected bits in a using #16
                    eorb      #33       ; toggle selected bits in b using #33
                    std       U000E,u   ; store d at U000E,u
                    bra       L02E6     ; continue execution at L02E6
L02E2               aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    std       U000E,u   ; store d at U000E,u
L02E6               dec       U000C,u   ; decrement the value at U000C,u
                    bne       L02D2     ; branch when the values differ or the result is nonzero; target L02D2
                    ldy       U000A,u   ; load y from U000A,u
                    leay      -$01,y    ; form the address -$01,y in y
                    sty       U000A,u   ; store y at U000A,u
                    bne       L02C5     ; branch when the values differ or the result is nonzero; target L02C5
                    ldd       U000E,u   ; load d from U000E,u
                    cmpd      >U00B4,u  ; compare d with >U00B4,u and set the condition codes
                    beq       L0302     ; branch when the values are equal or the result is zero; target L0302
                    dec       U0002,u   ; decrement the value at U0002,u
                    lbra      L018C     ; continue execution at L018C
L0302               lda       U0001,u   ; load a from U0001,u
                    leax      <U0034,u  ; form the address <U0034,u in x
                    ldy       #128      ; set y to the constant 128
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbra      L03A7     ; continue execution at L03A7
L0311               lda       <U0032,u  ; load a from <U0032,u
                    inca                ; increment a
                    cmpa      U0002,u   ; compare a with U0002,u and set the condition codes
                    lbeq      L03A5     ; branch when the values are equal or the result is zero; target L03A5
                    deca                ; decrement a
                    cmpa      U0002,u   ; compare a with U0002,u and set the condition codes
                    beq       L0325     ; branch when the values are equal or the result is zero; target L0325
                    dec       U0002,u   ; decrement the value at U0002,u
                    lbra      L018C     ; continue execution at L018C
L0325               coma                ; complement every bit in a
                    cmpa      <U0033,u  ; compare a with <U0033,u and set the condition codes
                    beq       L0330     ; branch when the values are equal or the result is zero; target L0330
                    dec       U0002,u   ; decrement the value at U0002,u
                    lbra      L018C     ; continue execution at L018C
L0330               leax      <U0034,u  ; form the address <U0034,u in x
                    tst       U0008,u   ; set condition codes from U0008,u without changing it
                    bne       L034F     ; branch when the values differ or the result is nonzero; target L034F
                    ldy       #1024     ; set y to the constant 1024
                    clra                ; clear a to zero and set the condition codes
L033C               adda      ,x+       ; add to a using ,x+
                    leay      -$01,y    ; form the address -$01,y in y
                    bne       L033C     ; branch when the values differ or the result is nonzero; target L033C
                    cmpa      >U0434,u  ; compare a with >U0434,u and set the condition codes
                    lbeq      L0302     ; branch when the values are equal or the result is zero; target L0302
                    dec       U0002,u   ; decrement the value at U0002,u
                    lbra      L018C     ; continue execution at L018C
L034F               ldy       #1024     ; set y to the constant 1024
                    sty       U000A,u   ; store y at U000A,u
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       U000E,u   ; store d at U000E,u
L035A               lda       ,x+       ; load a from ,x+
                    clrb                ; clear b to zero and set the condition codes
                    eora      U000E,u   ; toggle selected bits in a using U000E,u
                    eorb      U000F,u   ; toggle selected bits in b using U000F,u
                    std       U000E,u   ; store d at U000E,u
                    lda       #8        ; set a to the constant 8
                    sta       U000C,u   ; store a at U000C,u
L0367               ldd       U000E,u   ; load d from U000E,u
                    bita      #128      ; test selected bits in a using #128
                    beq       L0377     ; branch when the values are equal or the result is zero; target L0377
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    eora      #16       ; toggle selected bits in a using #16
                    eorb      #33       ; toggle selected bits in b using #33
                    std       U000E,u   ; store d at U000E,u
                    bra       L037B     ; continue execution at L037B
L0377               aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    std       U000E,u   ; store d at U000E,u
L037B               dec       U000C,u   ; decrement the value at U000C,u
                    bne       L0367     ; branch when the values differ or the result is nonzero; target L0367
                    ldy       U000A,u   ; load y from U000A,u
                    leay      -$01,y    ; form the address -$01,y in y
                    sty       U000A,u   ; store y at U000A,u
                    bne       L035A     ; branch when the values differ or the result is nonzero; target L035A
                    ldd       U000E,u   ; load d from U000E,u
                    cmpd      >U0434,u  ; compare d with >U0434,u and set the condition codes
                    beq       L0397     ; branch when the values are equal or the result is zero; target L0397
                    dec       U0002,u   ; decrement the value at U0002,u
                    lbra      L018C     ; continue execution at L018C
L0397               lda       U0001,u   ; load a from U0001,u
                    leax      <U0034,u  ; form the address <U0034,u in x
                    ldy       #1024     ; set y to the constant 1024
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    bra       L03A7     ; continue execution at L03A7
L03A5               dec       U0002,u   ; decrement the value at U0002,u
L03A7               ldx       #10       ; set x to the constant 10
                    os9       F$Sleep   ; invoke the OS-9 F$Sleep service
                    lda       #6        ; set a to the constant 6
                    sta       U0000,u   ; store a at U0000,u
                    lda       #1        ; set a to the constant 1
                    leax      U0000,u   ; form the address U0000,u in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    clr       U0003,u   ; clear U0003,u to zero and set the condition codes
                    lbra      L01AD     ; continue execution at L01AD
L03C1               lda       #6        ; set a to the constant 6
                    sta       U0000,u   ; store a at U0000,u
                    lda       #1        ; set a to the constant 1
                    leax      U0000,u   ; form the address U0000,u in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lda       U0001,u   ; load a from U0001,u
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lbsr      L0412     ; call subroutine L0412
                    leax      >L00C7,pc ; form the address >L00C7,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    clrb                ; clear b to zero and set the condition codes
L03E6               pshs      b         ; save b on the stack
                    lbsr      L0412     ; call subroutine L0412
                    puls      b         ; restore b from the stack
L03ED               os9       F$Exit    ; invoke the OS-9 F$Exit service
L03F0               bsr       L0412     ; call subroutine L0412
                    leax      >L00B7,pc ; form the address >L00B7,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lda       U0001,u   ; load a from U0001,u
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    ldx       <U0010,u  ; load x from <U0010,u
                    os9       I$Delete  ; invoke the OS-9 I$Delete service
                    lbcs      L03E6     ; branch when carry reports an error or unsigned underflow; target L03E6
                    ldb       #1        ; set b to the constant 1
                    bra       L03E6     ; continue execution at L03E6
L0412               leax      >U0436,u  ; form the address >U0436,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$SetStt  ; invoke the OS-9 I$SetStt service
                    rts                 ; return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
