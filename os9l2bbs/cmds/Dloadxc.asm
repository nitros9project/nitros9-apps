**********************************************************************
* Dloadxc - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       Dloadxc
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
U0009               rmb       2         ; reserve 2 byte(s) in the module workspace
U000B               rmb       10        ; reserve 10 byte(s) in the module workspace
U0015               rmb       1         ; reserve 1 byte(s) in the module workspace
U0016               rmb       1         ; reserve 1 byte(s) in the module workspace
U0017               rmb       1         ; reserve 1 byte(s) in the module workspace
U0018               rmb       128       ; reserve 128 byte(s) in the module workspace
U0098               rmb       1         ; reserve 1 byte(s) in the module workspace
U0099               rmb       1         ; reserve 1 byte(s) in the module workspace
U009A               rmb       32        ; reserve 32 byte(s) in the module workspace
U00BA               rmb       2         ; reserve 2 byte(s) in the module workspace
U00BC               rmb       1         ; reserve 1 byte(s) in the module workspace
U00BD               rmb       231       ; reserve 231 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /Dloadxc/ ; store an OS-9 high-bit-terminated string
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
L007F               fcc       "Enter filename to download-->" ; store literal character data
L009C               fcb       $00       ; store byte data
                    fcb       $1D       ; store byte data
L009E               fcc       "File open, ready to send..." ; store literal character data
                    fcb       $0D       ; store byte data
L00BA               fcc       "File transfer successful" ; store literal character data
                    fcb       $0D       ; store byte data
L00D3               fcc       "File transfer unsuccessful" ; store literal character data
                    fcb       $0D       ; store byte data
L00EE               fcc       "Press <CTRL><x> to abort" ; store literal character data
                    fcb       $0D       ; store byte data
L0107               fcb       $04       ; store byte data
L0108               fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
L010A               fcc       "Total number of blocks to download:" ; store literal character data
L012D               lda       #255      ; set a to the constant 255
                    sta       U0002,u   ; store a at U0002,u
                    leax      >U00BC,u  ; form the address >U00BC,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    leax      -$20,x    ; form the address -$20,x in x
                    clr       <$0024,x  ; clear <$0024,x to zero and set the condition codes
                    leax      >U00BC,u  ; form the address >U00BC,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$SetStt  ; invoke the OS-9 I$SetStt service
                    rts                 ; return to the caller
start               lda       0,x       ; load a from 0,x
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       L016A     ; branch when the values differ or the result is nonzero; target L016A
                    leax      >L007F,pc ; form the address >L007F,pc in x
                    ldy       >L009C,pc ; load y from >L009C,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      >U009A,u  ; form the address >U009A,u in x
                    ldy       #32       ; set y to the constant 32
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
L016A               stx       >U00BA,u  ; store x at >U00BA,u
                    lbsr      L012D     ; call subroutine L012D
                    lda       #1        ; set a to the constant 1
                    ldx       >U00BA,u  ; load x from >U00BA,u
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L031D     ; branch when carry reports an error or unsigned underflow; target L031D
                    sta       U0000,u   ; store a at U0000,u
                    leax      >L010A,pc ; form the address >L010A,pc in x
                    ldy       #35       ; set y to the constant 35
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lda       U0000,u   ; load a from U0000,u
                    ldb       #2        ; set b to the constant 2
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    tfr       u,y       ; copy the register values specified by u,y
                    puls      u         ; restore u from the stack
                    lda       #7        ; set a to the constant 7
                    sta       U0006,u   ; store a at U0006,u
L019E               tfr       x,d       ; copy the register values specified by x,d
                    lsra                ; shift a right logically
                    rorb                ; rotate b right through carry
                    tfr       d,x       ; copy the register values specified by d,x
                    tfr       y,d       ; copy the register values specified by y,d
                    rora                ; rotate a right through carry
                    rorb                ; rotate b right through carry
                    tfr       d,y       ; copy the register values specified by d,y
                    dec       U0006,u   ; decrement the value at U0006,u
                    bne       L019E     ; branch when the values differ or the result is nonzero; target L019E
                    tfr       y,d       ; copy the register values specified by y,d
                    leax      U000B,u   ; form the address U000B,u in x
                    addd      #1        ; add to d using #1
                    lbsr      L039D     ; call subroutine L039D
                    leax      U000B,u   ; form the address U000B,u in x
                    ldy       #5        ; set y to the constant 5
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      >L0108,pc ; form the address >L0108,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L00EE,pc ; form the address >L00EE,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L009E,pc ; form the address >L009E,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
L01EA               leax      U0001,u   ; form the address U0001,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lda       U0001,u   ; load a from U0001,u
                    cmpa      #67       ; compare a with #67 and set the condition codes
                    beq       L0206     ; branch when the values are equal or the result is zero; target L0206
                    cmpa      #24       ; compare a with #24 and set the condition codes
                    lbeq      L030F     ; branch when the values are equal or the result is zero; target L030F
                    cmpa      #21       ; compare a with #21 and set the condition codes
                    bne       L01EA     ; branch when the values differ or the result is nonzero; target L01EA
                    bra       L0208     ; continue execution at L0208
L0206               clr       U0002,u   ; clear U0002,u to zero and set the condition codes
L0208               lda       #1        ; set a to the constant 1
                    sta       <U0015,u  ; store a at <U0015,u
                    sta       <U0016,u  ; store a at <U0016,u
                    coma                ; complement every bit in a
                    sta       <U0017,u  ; store a at <U0017,u
L0214               leax      <U0018,u  ; form the address <U0018,u in x
                    ldy       #128      ; set y to the constant 128
                    lda       U0000,u   ; load a from U0000,u
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lbcs      L02DD     ; branch when carry reports an error or unsigned underflow; target L02DD
                    cmpy      #128      ; compare y with #128 and set the condition codes
                    beq       L023C     ; branch when the values are equal or the result is zero; target L023C
                    tfr       y,d       ; copy the register values specified by y,d
                    leax      d,x       ; form the address d,x in x
                    clra                ; clear a to zero and set the condition codes
L022F               sta       ,x+       ; store a at ,x+
                    leay      $01,y     ; form the address $01,y in y
                    cmpy      #128      ; compare y with #128 and set the condition codes
                    bcs       L022F     ; branch when carry reports an error or unsigned underflow; target L022F
                    leax      <U0018,u  ; form the address <U0018,u in x
L023C               tst       U0002,u   ; set condition codes from U0002,u without changing it
                    beq       L0255     ; branch when the values are equal or the result is zero; target L0255
                    clr       >U0098,u  ; clear >U0098,u to zero and set the condition codes
                    ldb       #128      ; set b to the constant 128
L0246               lda       ,x+       ; load a from ,x+
                    adda      >U0098,u  ; add to a using >U0098,u
                    sta       >U0098,u  ; store a at >U0098,u
                    decb                ; decrement b
                    bne       L0246     ; branch when the values differ or the result is nonzero; target L0246
                    bra       L029D     ; continue execution at L029D
L0255               ldd       #0        ; set d to the constant 0
                    std       >U0098,u  ; store d at >U0098,u
                    lda       #128      ; set a to the constant 128
                    sta       U0003,u   ; store a at U0003,u
L0260               lda       ,x+       ; load a from ,x+
                    clrb                ; clear b to zero and set the condition codes
                    eora      >U0098,u  ; toggle selected bits in a using >U0098,u
                    eorb      >U0099,u  ; toggle selected bits in b using >U0099,u
                    std       >U0098,u  ; store d at >U0098,u
                    lda       #8        ; set a to the constant 8
                    sta       U0004,u   ; store a at U0004,u
L0273               lda       >U0098,u  ; load a from >U0098,u
                    bita      #128      ; test selected bits in a using #128
                    beq       L028B     ; branch when the values are equal or the result is zero; target L028B
                    ldd       >U0098,u  ; load d from >U0098,u
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    eora      #16       ; toggle selected bits in a using #16
                    eorb      #33       ; toggle selected bits in b using #33
                    std       >U0098,u  ; store d at >U0098,u
                    bra       L0291     ; continue execution at L0291
L028B               aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    std       >U0098,u  ; store d at >U0098,u
L0291               dec       U0004,u   ; decrement the value at U0004,u
                    bne       L0273     ; branch when the values differ or the result is nonzero; target L0273
                    dec       U0003,u   ; decrement the value at U0003,u
                    bne       L0260     ; branch when the values differ or the result is nonzero; target L0260
                    ldd       >U0098,u  ; load d from >U0098,u
L029D               leax      <U0015,u  ; form the address <U0015,u in x
                    tst       U0002,u   ; set condition codes from U0002,u without changing it
                    beq       L02AA     ; branch when the values are equal or the result is zero; target L02AA
                    ldy       #132      ; set y to the constant 132
                    bra       L02AE     ; continue execution at L02AE
L02AA               ldy       #133      ; set y to the constant 133
L02AE               lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      U0001,u   ; form the address U0001,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lda       U0001,u   ; load a from U0001,u
                    cmpa      #21       ; compare a with #21 and set the condition codes
                    beq       L029D     ; branch when the values are equal or the result is zero; target L029D
                    cmpa      #6        ; compare a with #6 and set the condition codes
                    beq       L02CF     ; branch when the values are equal or the result is zero; target L02CF
                    cmpa      #24       ; compare a with #24 and set the condition codes
                    beq       L030F     ; branch when the values are equal or the result is zero; target L030F
                    lda       #1        ; set a to the constant 1
                    bra       L031D     ; continue execution at L031D
L02CF               lda       <U0016,u  ; load a from <U0016,u
                    inca                ; increment a
                    sta       <U0016,u  ; store a at <U0016,u
                    coma                ; complement every bit in a
                    sta       <U0017,u  ; store a at <U0017,u
                    lbra      L0214     ; continue execution at L0214
L02DD               cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      L031D     ; branch when the values differ or the result is nonzero; target L031D
                    leax      >L0107,pc ; form the address >L0107,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      U0001,u   ; form the address U0001,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lda       U0001,u   ; load a from U0001,u
                    cmpa      #6        ; compare a with #6 and set the condition codes
                    bne       L030F     ; branch when the values differ or the result is nonzero; target L030F
                    leax      >L00BA,pc ; form the address >L00BA,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    bra       L031C     ; continue execution at L031C
L030F               leax      >L00D3,pc ; form the address >L00D3,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
L031C               clrb                ; clear b to zero and set the condition codes
L031D               pshs      b         ; save b on the stack
                    bsr       L0326     ; call subroutine L0326
                    puls      b         ; restore b from the stack
                    os9       F$Exit    ; invoke the OS-9 F$Exit service
L0326               leax      >U00BC,u  ; form the address >U00BC,u in x
                    leax      -$20,x    ; form the address -$20,x in x
                    lda       #1        ; set a to the constant 1
                    sta       <$0024,x  ; store a at <$0024,x
                    leax      >U00BC,u  ; form the address >U00BC,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$SetStt  ; invoke the OS-9 I$SetStt service
                    rts                 ; return to the caller
                    fcb       $34       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $A6       ; store byte data
                    fcb       $80       ; store byte data
                    fcb       $81       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $FA       ; store byte data
                    fcb       $81       ; store byte data
                    fcb       $39       ; store byte data
                    fcb       $22       ; store byte data
                    fcb       $F6       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $A6       ; store byte data
                    fcb       $80       ; store byte data
                    fcb       $81       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $81       ; store byte data
                    fcb       $39       ; store byte data
                    fcb       $22       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $F4       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $1F       ; store byte data
                    fcc       "oGoH" ; store literal character data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $49       ; store byte data
                    fcb       $A6       ; store byte data
                    fcb       $82       ; store byte data
                    fcb       $81       ; store byte data
                    fcc       "0%." ; store literal character data
                    fcb       $81       ; store byte data
                    fcc       /9"*/ ; store literal character data
                    fcb       $80       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $A7       ; store byte data
                    fcb       $45       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcc       "mE'" ; store literal character data
                    fcb       $06       ; store byte data
                    fcb       $E3       ; store byte data
                    fcc       "IjE " ; store literal character data
                    fcb       $F6       ; store byte data
                    fcb       $E3       ; store byte data
                    fcb       $47       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $47       ; store byte data
                    fcb       $86       ; store byte data
                    fcb       $0A       ; store byte data
                    fcb       $A7       ; store byte data
                    fcb       $45       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcc       "mE'" ; store literal character data
                    fcb       $06       ; store byte data
                    fcb       $E3       ; store byte data
                    fcc       "IjE " ; store literal character data
                    fcb       $F6       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $49       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $47       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $A0       ; store byte data
L039D               std       U0007,u   ; store d at U0007,u
                    lda       #48       ; set a to the constant 48
                    sta       0,x       ; store a at 0,x
                    sta       $01,x     ; store a at $01,x
                    sta       $02,x     ; store a at $02,x
                    sta       $03,x     ; store a at $03,x
                    sta       $04,x     ; store a at $04,x
                    ldd       #10000    ; set d to the constant 10000
                    std       U0009,u   ; store d at U0009,u
                    ldd       U0007,u   ; load d from U0007,u
                    lbsr      L03DE     ; call subroutine L03DE
                    ldd       #1000     ; set d to the constant 1000
                    std       U0009,u   ; store d at U0009,u
                    ldd       U0007,u   ; load d from U0007,u
                    bsr       L03DE     ; call subroutine L03DE
                    ldd       #100      ; set d to the constant 100
                    std       U0009,u   ; store d at U0009,u
                    ldd       U0007,u   ; load d from U0007,u
                    bsr       L03DE     ; call subroutine L03DE
                    ldd       #10       ; set d to the constant 10
                    std       U0009,u   ; store d at U0009,u
                    ldd       U0007,u   ; load d from U0007,u
                    bsr       L03DE     ; call subroutine L03DE
                    ldd       #1        ; set d to the constant 1
                    std       U0009,u   ; store d at U0009,u
                    ldd       U0007,u   ; load d from U0007,u
                    bsr       L03DE     ; call subroutine L03DE
                    lda       #13       ; set a to the constant 13
                    sta       0,x       ; store a at 0,x
                    rts                 ; return to the caller
L03DE               subd      U0009,u   ; subtract from d using U0009,u
                    bcs       L03E6     ; branch when carry reports an error or unsigned underflow; target L03E6
                    inc       0,x       ; increment the value at 0,x
                    bra       L03DE     ; continue execution at L03DE
L03E6               addd      U0009,u   ; add to d using U0009,u
                    std       U0007,u   ; store d at U0007,u
                    leax      $01,x     ; form the address $01,x in x
                    rts                 ; return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
