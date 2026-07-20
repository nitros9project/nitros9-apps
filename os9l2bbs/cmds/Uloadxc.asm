**********************************************************************
* Uloadxc - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       Uloadxc
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
U0007               rmb       1         ; reserve 1 byte(s) in the module workspace
U0008               rmb       1         ; reserve 1 byte(s) in the module workspace
U0009               rmb       1         ; reserve 1 byte(s) in the module workspace
U000A               rmb       1         ; reserve 1 byte(s) in the module workspace
U000B               rmb       2         ; reserve 2 byte(s) in the module workspace
U000D               rmb       32        ; reserve 32 byte(s) in the module workspace
U002D               rmb       1         ; reserve 1 byte(s) in the module workspace
U002E               rmb       1         ; reserve 1 byte(s) in the module workspace
U002F               rmb       128       ; reserve 128 byte(s) in the module workspace
U00AF               rmb       2         ; reserve 2 byte(s) in the module workspace
U00B1               rmb       32        ; reserve 32 byte(s) in the module workspace
U00D1               rmb       1         ; reserve 1 byte(s) in the module workspace
U00D2               rmb       431       ; reserve 431 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /Uloadxc/ ; store an OS-9 high-bit-terminated string
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
L007F               fcc       "File open, ready to recieve..." ; store literal character data
                    fcb       $0D       ; store byte data
L009E               fcc       "Enter filename to upload: " ; store literal character data
L00B8               fcc       "Upload aborted!" ; store literal character data
                    fcb       $0D       ; store byte data
L00C8               fcc       "Upload successful!" ; store literal character data
                    fcb       $0D       ; store byte data
start               pshs      x         ; save x on the stack
                    os9       F$ID      ; invoke the OS-9 F$ID service
                    ldb       #255      ; set b to the constant 255
                    os9       F$SPrior  ; invoke the OS-9 F$SPrior service
                    lda       0,x       ; load a from 0,x
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       L0102     ; branch when the values differ or the result is nonzero; target L0102
                    leax      >L009E,pc ; form the address >L009E,pc in x
                    ldy       #25       ; set y to the constant 25
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      U000D,u   ; form the address U000D,u in x
                    ldy       #32       ; set y to the constant 32
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
L0102               stx       U000B,u   ; store x at U000B,u
                    lda       #2        ; set a to the constant 2
                    ldb       #27       ; set b to the constant 27
                    os9       I$Create  ; invoke the OS-9 I$Create service
                    lbcs      L0320     ; branch when carry reports an error or unsigned underflow; target L0320
                    sta       U0001,u   ; store a at U0001,u
                    clr       U0003,u   ; clear U0003,u to zero and set the condition codes
                    clr       U0002,u   ; clear U0002,u to zero and set the condition codes
                    clr       >U00AF,u  ; clear >U00AF,u to zero and set the condition codes
                    dec       >U00AF,u  ; decrement the value at >U00AF,u
                    leax      >L007F,pc ; form the address >L007F,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lda       #4        ; set a to the constant 4
                    sta       U0006,u   ; store a at U0006,u
                    leax      >U00B1,u  ; form the address >U00B1,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    lbcs      L0320     ; branch when carry reports an error or unsigned underflow; target L0320
                    leax      >U00D1,u  ; form the address >U00D1,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    lbcs      L0320     ; branch when carry reports an error or unsigned underflow; target L0320
                    leax      >U00D1,u  ; form the address >U00D1,u in x
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
                    leax      >U00D1,u  ; form the address >U00D1,u in x
                    os9       I$SetStt  ; invoke the OS-9 I$SetStt service
L017F               tst       U0006,u   ; set condition codes from U0006,u without changing it
                    beq       L018B     ; branch when the values are equal or the result is zero; target L018B
                    dec       U0006,u   ; decrement the value at U0006,u
                    lda       #67       ; set a to the constant 67
                    sta       U0000,u   ; store a at U0000,u
                    bra       L018F     ; continue execution at L018F
L018B               lda       #21       ; set a to the constant 21
                    sta       U0000,u   ; store a at U0000,u
L018F               leax      U0000,u   ; form the address U0000,u in x
                    lda       #1        ; set a to the constant 1
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    clr       U0004,u   ; clear U0004,u to zero and set the condition codes
                    lda       U0003,u   ; load a from U0003,u
                    inca                ; increment a
                    sta       U0003,u   ; store a at U0003,u
                    cmpa      #10       ; compare a with #10 and set the condition codes
                    bcs       L01AA     ; branch when carry reports an error or unsigned underflow; target L01AA
                    ldb       #1        ; set b to the constant 1
                    lbra      L0319     ; continue execution at L0319
L01AA               clra                ; clear a to zero and set the condition codes
                    ldb       #1        ; set b to the constant 1
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    bcc       L01C3     ; branch when carry is clear; target L01C3
                    lda       U0004,u   ; load a from U0004,u
                    inca                ; increment a
                    sta       U0004,u   ; store a at U0004,u
                    cmpa      #254      ; compare a with #254 and set the condition codes
                    bcc       L017F     ; branch when carry is clear; target L017F
                    ldx       #2        ; set x to the constant 2
                    os9       F$Sleep   ; invoke the OS-9 F$Sleep service
                    bra       L01AA     ; continue execution at L01AA
L01C3               leax      U0000,u   ; form the address U0000,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lda       U0000,u   ; load a from U0000,u
                    cmpa      #1        ; compare a with #1 and set the condition codes
                    beq       L01E1     ; branch when the values are equal or the result is zero; target L01E1
                    cmpa      #4        ; compare a with #4 and set the condition codes
                    lbeq      L02F4     ; branch when the values are equal or the result is zero; target L02F4
                    cmpa      #24       ; compare a with #24 and set the condition codes
                    lbeq      L0323     ; branch when the values are equal or the result is zero; target L0323
                    bra       L01AA     ; continue execution at L01AA
L01E1               leax      <U002D,u  ; form the address <U002D,u in x
                    tst       U0006,u   ; set condition codes from U0006,u without changing it
                    beq       L01EC     ; branch when the values are equal or the result is zero; target L01EC
                    lda       #132      ; set a to the constant 132
                    bra       L01EE     ; continue execution at L01EE
L01EC               lda       #131      ; set a to the constant 131
L01EE               sta       U0005,u   ; store a at U0005,u
                    clr       U0004,u   ; clear U0004,u to zero and set the condition codes
                    bsr       L01FD     ; call subroutine L01FD
                    lbcs      L018B     ; branch when carry reports an error or unsigned underflow; target L018B
                    inc       U0002,u   ; increment the value at U0002,u
                    lbra      L0250     ; continue execution at L0250
L01FD               clra                ; clear a to zero and set the condition codes
                    ldb       #1        ; set b to the constant 1
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    bcc       L0219     ; branch when carry is clear; target L0219
                    inc       U0004,u   ; increment the value at U0004,u
                    lda       U0004,u   ; load a from U0004,u
                    cmpa      #255      ; compare a with #255 and set the condition codes
                    bhi       L0232     ; branch when the unsigned value is higher; target L0232
                    pshs      x         ; save x on the stack
                    ldx       #1        ; set x to the constant 1
                    os9       F$Sleep   ; invoke the OS-9 F$Sleep service
                    puls      x         ; restore x from the stack
                    bra       L01FD     ; continue execution at L01FD
L0219               clr       U0004,u   ; clear U0004,u to zero and set the condition codes
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    bcs       L0236     ; branch when carry reports an error or unsigned underflow; target L0236
                    tfr       y,d       ; copy the register values specified by y,d
                    leax      b,x       ; form the address b,x in x
                    lda       U0005,u   ; load a from U0005,u
                    stb       U0005,u   ; store b at U0005,u
                    suba      U0005,u   ; subtract from a using U0005,u
                    sta       U0005,u   ; store a at U0005,u
                    bne       L01FD     ; branch when the values differ or the result is nonzero; target L01FD
                    rts                 ; return to the caller
L0232               lda       #255      ; set a to the constant 255
                    rola                ; rotate a left through carry
                    rts                 ; return to the caller
L0236               pshs      x         ; save x on the stack
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
L0250               lda       <U002D,u  ; load a from <U002D,u
                    inca                ; increment a
                    cmpa      U0002,u   ; compare a with U0002,u and set the condition codes
                    lbeq      L02D8     ; branch when the values are equal or the result is zero; target L02D8
                    deca                ; decrement a
                    cmpa      U0002,u   ; compare a with U0002,u and set the condition codes
                    beq       L0264     ; branch when the values are equal or the result is zero; target L0264
                    dec       U0002,u   ; decrement the value at U0002,u
                    lbra      L018B     ; continue execution at L018B
L0264               coma                ; complement every bit in a
                    cmpa      <U002E,u  ; compare a with <U002E,u and set the condition codes
                    beq       L026F     ; branch when the values are equal or the result is zero; target L026F
                    dec       U0002,u   ; decrement the value at U0002,u
                    lbra      L018B     ; continue execution at L018B
L026F               leax      <U002F,u  ; form the address <U002F,u in x
                    tst       U0006,u   ; set condition codes from U0006,u without changing it
                    bne       L028B     ; branch when the values differ or the result is nonzero; target L028B
                    ldb       #128      ; set b to the constant 128
                    clra                ; clear a to zero and set the condition codes
L0279               adda      ,x+       ; add to a using ,x+
                    decb                ; decrement b
                    bne       L0279     ; branch when the values differ or the result is nonzero; target L0279
                    cmpa      >U00AF,u  ; compare a with >U00AF,u and set the condition codes
                    lbeq      L02CA     ; branch when the values are equal or the result is zero; target L02CA
                    dec       U0002,u   ; decrement the value at U0002,u
                    lbra      L018B     ; continue execution at L018B
L028B               lda       #128      ; set a to the constant 128
                    sta       U0007,u   ; store a at U0007,u
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       U0009,u   ; store d at U0009,u
L0293               lda       ,x+       ; load a from ,x+
                    clrb                ; clear b to zero and set the condition codes
                    eora      U0009,u   ; toggle selected bits in a using U0009,u
                    eorb      U000A,u   ; toggle selected bits in b using U000A,u
                    std       U0009,u   ; store d at U0009,u
                    lda       #8        ; set a to the constant 8
                    sta       U0008,u   ; store a at U0008,u
L02A0               ldd       U0009,u   ; load d from U0009,u
                    bita      #128      ; test selected bits in a using #128
                    beq       L02B0     ; branch when the values are equal or the result is zero; target L02B0
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    eora      #16       ; toggle selected bits in a using #16
                    eorb      #33       ; toggle selected bits in b using #33
                    std       U0009,u   ; store d at U0009,u
                    bra       L02B4     ; continue execution at L02B4
L02B0               aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    std       U0009,u   ; store d at U0009,u
L02B4               dec       U0008,u   ; decrement the value at U0008,u
                    bne       L02A0     ; branch when the values differ or the result is nonzero; target L02A0
                    dec       U0007,u   ; decrement the value at U0007,u
                    bne       L0293     ; branch when the values differ or the result is nonzero; target L0293
                    ldd       U0009,u   ; load d from U0009,u
                    cmpd      >U00AF,u  ; compare d with >U00AF,u and set the condition codes
                    beq       L02CA     ; branch when the values are equal or the result is zero; target L02CA
                    dec       U0002,u   ; decrement the value at U0002,u
                    lbra      L018B     ; continue execution at L018B
L02CA               lda       U0001,u   ; load a from U0001,u
                    leax      <U002F,u  ; form the address <U002F,u in x
                    ldy       #128      ; set y to the constant 128
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    bra       L02DA     ; continue execution at L02DA
L02D8               dec       U0002,u   ; decrement the value at U0002,u
L02DA               ldx       #60       ; set x to the constant 60
                    os9       F$Sleep   ; invoke the OS-9 F$Sleep service
                    lda       #6        ; set a to the constant 6
                    sta       U0000,u   ; store a at U0000,u
                    lda       #1        ; set a to the constant 1
                    leax      U0000,u   ; form the address U0000,u in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    clr       U0003,u   ; clear U0003,u to zero and set the condition codes
                    lbra      L01AA     ; continue execution at L01AA
L02F4               lda       #6        ; set a to the constant 6
                    sta       U0000,u   ; store a at U0000,u
                    lda       #1        ; set a to the constant 1
                    leax      U0000,u   ; form the address U0000,u in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lda       U0001,u   ; load a from U0001,u
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lbsr      L0344     ; call subroutine L0344
                    leax      >L00C8,pc ; form the address >L00C8,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    clrb                ; clear b to zero and set the condition codes
L0319               pshs      b         ; save b on the stack
                    lbsr      L0344     ; call subroutine L0344
                    puls      b         ; restore b from the stack
L0320               os9       F$Exit    ; invoke the OS-9 F$Exit service
L0323               bsr       L0344     ; call subroutine L0344
                    leax      >L00B8,pc ; form the address >L00B8,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lda       U0001,u   ; load a from U0001,u
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    ldx       U000B,u   ; load x from U000B,u
                    os9       I$Delete  ; invoke the OS-9 I$Delete service
                    lbcs      L0319     ; branch when carry reports an error or unsigned underflow; target L0319
                    ldb       #1        ; set b to the constant 1
                    bra       L0319     ; continue execution at L0319
L0344               leax      >U00B1,u  ; form the address >U00B1,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$SetStt  ; invoke the OS-9 I$SetStt service
                    rts                 ; return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
