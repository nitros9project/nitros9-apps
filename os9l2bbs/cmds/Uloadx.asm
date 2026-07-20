**********************************************************************
* Uloadx - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       Uloadx
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
U0004               rmb       2         ; reserve 2 byte(s) in the module workspace
U0006               rmb       1         ; reserve 1 byte(s) in the module workspace
U0007               rmb       2         ; reserve 2 byte(s) in the module workspace
U0009               rmb       32        ; reserve 32 byte(s) in the module workspace
U0029               rmb       1         ; reserve 1 byte(s) in the module workspace
U002A               rmb       1         ; reserve 1 byte(s) in the module workspace
U002B               rmb       128       ; reserve 128 byte(s) in the module workspace
U00AB               rmb       1         ; reserve 1 byte(s) in the module workspace
U00AC               rmb       32        ; reserve 32 byte(s) in the module workspace
U00CC               rmb       1         ; reserve 1 byte(s) in the module workspace
U00CD               rmb       431       ; reserve 431 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /Uloadx/ ; store an OS-9 high-bit-terminated string
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
                    bne       L0101     ; branch when the values differ or the result is nonzero; target L0101
                    leax      >L009D,pc ; form the address >L009D,pc in x
                    ldy       #25       ; set y to the constant 25
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      U0009,u   ; form the address U0009,u in x
                    ldy       #32       ; set y to the constant 32
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
L0101               stx       U0007,u   ; store x at U0007,u
                    lda       #2        ; set a to the constant 2
                    ldb       #27       ; set b to the constant 27
                    os9       I$Create  ; invoke the OS-9 I$Create service
                    lbcs      L02BD     ; branch when carry reports an error or unsigned underflow; target L02BD
                    sta       U0001,u   ; store a at U0001,u
                    clr       U0003,u   ; clear U0003,u to zero and set the condition codes
                    clr       U0002,u   ; clear U0002,u to zero and set the condition codes
                    clr       >U00AB,u  ; clear >U00AB,u to zero and set the condition codes
                    dec       >U00AB,u  ; decrement the value at >U00AB,u
                    leax      >L007E,pc ; form the address >L007E,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >U00AC,u  ; form the address >U00AC,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    lbcs      L02BD     ; branch when carry reports an error or unsigned underflow; target L02BD
                    leax      >U00CC,u  ; form the address >U00CC,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    lbcs      L02BD     ; branch when carry reports an error or unsigned underflow; target L02BD
                    leax      >U00CC,u  ; form the address >U00CC,u in x
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
                    leax      >U00CC,u  ; form the address >U00CC,u in x
                    os9       I$SetStt  ; invoke the OS-9 I$SetStt service
L017A               lda       #21       ; set a to the constant 21
                    sta       U0000,u   ; store a at U0000,u
                    leax      U0000,u   ; form the address U0000,u in x
                    lda       #1        ; set a to the constant 1
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    clr       U0004,u   ; clear U0004,u to zero and set the condition codes
                    lda       U0003,u   ; load a from U0003,u
                    inca                ; increment a
                    sta       U0003,u   ; store a at U0003,u
                    cmpa      #10       ; compare a with #10 and set the condition codes
                    bcs       L0199     ; branch when carry reports an error or unsigned underflow; target L0199
                    ldb       #1        ; set b to the constant 1
                    lbra      L02B6     ; continue execution at L02B6
L0199               clra                ; clear a to zero and set the condition codes
                    ldb       #1        ; set b to the constant 1
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    bcc       L01B1     ; branch when carry is clear; target L01B1
                    ldy       U0004,u   ; load y from U0004,u
                    leay      $01,y     ; form the address $01,y in y
                    sty       U0004,u   ; store y at U0004,u
                    cmpy      #4096     ; compare y with #4096 and set the condition codes
                    bcc       L017A     ; branch when carry is clear; target L017A
                    bra       L0199     ; continue execution at L0199
L01B1               leax      U0000,u   ; form the address U0000,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lda       U0000,u   ; load a from U0000,u
                    cmpa      #1        ; compare a with #1 and set the condition codes
                    beq       L01CF     ; branch when the values are equal or the result is zero; target L01CF
                    cmpa      #4        ; compare a with #4 and set the condition codes
                    lbeq      L0291     ; branch when the values are equal or the result is zero; target L0291
                    cmpa      #24       ; compare a with #24 and set the condition codes
                    lbeq      L02C0     ; branch when the values are equal or the result is zero; target L02C0
                    bra       L0199     ; continue execution at L0199
L01CF               leax      <U0029,u  ; form the address <U0029,u in x
                    lda       #131      ; set a to the constant 131
                    sta       U0006,u   ; store a at U0006,u
                    clr       U0004,u   ; clear U0004,u to zero and set the condition codes
                    bsr       L01E3     ; call subroutine L01E3
                    lbcs      L017A     ; branch when carry reports an error or unsigned underflow; target L017A
                    inc       U0002,u   ; increment the value at U0002,u
                    lbra      L0232     ; continue execution at L0232
L01E3               clra                ; clear a to zero and set the condition codes
                    ldb       #1        ; set b to the constant 1
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    bcc       L01FB     ; branch when carry is clear; target L01FB
                    ldy       U0004,u   ; load y from U0004,u
                    leay      $01,y     ; form the address $01,y in y
                    sty       U0004,u   ; store y at U0004,u
                    cmpy      #4096     ; compare y with #4096 and set the condition codes
                    bhi       L0214     ; branch when the unsigned value is higher; target L0214
                    bra       L01E3     ; continue execution at L01E3
L01FB               clr       U0004,u   ; clear U0004,u to zero and set the condition codes
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    bcs       L0218     ; branch when carry reports an error or unsigned underflow; target L0218
                    tfr       y,d       ; copy the register values specified by y,d
                    leax      b,x       ; form the address b,x in x
                    lda       U0006,u   ; load a from U0006,u
                    stb       U0006,u   ; store b at U0006,u
                    suba      U0006,u   ; subtract from a using U0006,u
                    sta       U0006,u   ; store a at U0006,u
                    bne       L01E3     ; branch when the values differ or the result is nonzero; target L01E3
                    rts                 ; return to the caller
L0214               lda       #255      ; set a to the constant 255
                    rola                ; rotate a left through carry
                    rts                 ; return to the caller
L0218               pshs      x         ; save x on the stack
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
L0232               lda       <U0029,u  ; load a from <U0029,u
                    inca                ; increment a
                    cmpa      U0002,u   ; compare a with U0002,u and set the condition codes
                    lbeq      L0275     ; branch when the values are equal or the result is zero; target L0275
                    deca                ; decrement a
                    cmpa      U0002,u   ; compare a with U0002,u and set the condition codes
                    beq       L0246     ; branch when the values are equal or the result is zero; target L0246
                    dec       U0002,u   ; decrement the value at U0002,u
                    lbra      L017A     ; continue execution at L017A
L0246               coma                ; complement every bit in a
                    cmpa      <U002A,u  ; compare a with <U002A,u and set the condition codes
                    beq       L0251     ; branch when the values are equal or the result is zero; target L0251
                    dec       U0002,u   ; decrement the value at U0002,u
                    lbra      L017A     ; continue execution at L017A
L0251               leax      <U002B,u  ; form the address <U002B,u in x
                    ldb       #128      ; set b to the constant 128
                    clra                ; clear a to zero and set the condition codes
L0257               adda      ,x+       ; add to a using ,x+
                    decb                ; decrement b
                    bne       L0257     ; branch when the values differ or the result is nonzero; target L0257
                    cmpa      >U00AB,u  ; compare a with >U00AB,u and set the condition codes
                    beq       L0267     ; branch when the values are equal or the result is zero; target L0267
                    dec       U0002,u   ; decrement the value at U0002,u
                    lbra      L017A     ; continue execution at L017A
L0267               lda       U0001,u   ; load a from U0001,u
                    leax      <U002B,u  ; form the address <U002B,u in x
                    ldy       #128      ; set y to the constant 128
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    bra       L0277     ; continue execution at L0277
L0275               dec       U0002,u   ; decrement the value at U0002,u
L0277               ldx       #10       ; set x to the constant 10
                    os9       F$Sleep   ; invoke the OS-9 F$Sleep service
                    lda       #6        ; set a to the constant 6
                    sta       U0000,u   ; store a at U0000,u
                    lda       #1        ; set a to the constant 1
                    leax      U0000,u   ; form the address U0000,u in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    clr       U0003,u   ; clear U0003,u to zero and set the condition codes
                    lbra      L0199     ; continue execution at L0199
L0291               lda       #6        ; set a to the constant 6
                    sta       U0000,u   ; store a at U0000,u
                    lda       #1        ; set a to the constant 1
                    leax      U0000,u   ; form the address U0000,u in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lda       U0001,u   ; load a from U0001,u
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lbsr      L02E1     ; call subroutine L02E1
                    leax      >L00C7,pc ; form the address >L00C7,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    clrb                ; clear b to zero and set the condition codes
L02B6               pshs      b         ; save b on the stack
                    lbsr      L02E1     ; call subroutine L02E1
                    puls      b         ; restore b from the stack
L02BD               os9       F$Exit    ; invoke the OS-9 F$Exit service
L02C0               bsr       L02E1     ; call subroutine L02E1
                    leax      >L00B7,pc ; form the address >L00B7,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lda       U0001,u   ; load a from U0001,u
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    ldx       U0007,u   ; load x from U0007,u
                    os9       I$Delete  ; invoke the OS-9 I$Delete service
                    lbcs      L02B6     ; branch when carry reports an error or unsigned underflow; target L02B6
                    ldb       #1        ; set b to the constant 1
                    bra       L02B6     ; continue execution at L02B6
L02E1               leax      >U00AC,u  ; form the address >U00AC,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$SetStt  ; invoke the OS-9 I$SetStt service
                    rts                 ; return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
