**********************************************************************
* Dloady - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       Dloady
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
U0003               rmb       2         ; reserve 2 byte(s) in the module workspace
U0005               rmb       2         ; reserve 2 byte(s) in the module workspace
U0007               rmb       1         ; reserve 1 byte(s) in the module workspace
U0008               rmb       2         ; reserve 2 byte(s) in the module workspace
U000A               rmb       2         ; reserve 2 byte(s) in the module workspace
U000C               rmb       10        ; reserve 10 byte(s) in the module workspace
U0016               rmb       1         ; reserve 1 byte(s) in the module workspace
U0017               rmb       1         ; reserve 1 byte(s) in the module workspace
U0018               rmb       1         ; reserve 1 byte(s) in the module workspace
U0019               rmb       1024      ; reserve 1024 byte(s) in the module workspace
U0419               rmb       1         ; reserve 1 byte(s) in the module workspace
U041A               rmb       1         ; reserve 1 byte(s) in the module workspace
U041B               rmb       32        ; reserve 32 byte(s) in the module workspace
U043B               rmb       2         ; reserve 2 byte(s) in the module workspace
U043D               rmb       1         ; reserve 1 byte(s) in the module workspace
U043E               rmb       231       ; reserve 231 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /Dloady/ ; store an OS-9 high-bit-terminated string
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
L007E               fcc       "Enter filename to download-->" ; store literal character data
L009B               fcb       $00       ; store byte data
                    fcb       $1D       ; store byte data
L009D               fcc       "File open, ready to send..." ; store literal character data
                    fcb       $0D       ; store byte data
L00B9               fcc       "File transfer successful" ; store literal character data
                    fcb       $0D       ; store byte data
L00D2               fcc       "File transfer unsuccessful" ; store literal character data
                    fcb       $0D       ; store byte data
L00ED               fcc       "Press <CTRL><x> to abort" ; store literal character data
                    fcb       $0D       ; store byte data
L0106               fcb       $04       ; store byte data
L0107               fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
L0109               fcc       "Total number of blocks to download:" ; store literal character data
L012C               clr       U0002,u   ; clear U0002,u to zero and set the condition codes
                    leax      >U043D,u  ; form the address >U043D,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    leax      -$20,x    ; form the address -$20,x in x
                    clr       <$0024,x  ; clear <$0024,x to zero and set the condition codes
                    leax      >U043D,u  ; form the address >U043D,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$SetStt  ; invoke the OS-9 I$SetStt service
                    rts                 ; return to the caller
start               lda       0,x       ; load a from 0,x
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       L0167     ; branch when the values differ or the result is nonzero; target L0167
                    leax      >L007E,pc ; form the address >L007E,pc in x
                    ldy       >L009B,pc ; load y from >L009B,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      >U041B,u  ; form the address >U041B,u in x
                    ldy       #32       ; set y to the constant 32
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
L0167               stx       >U043B,u  ; store x at >U043B,u
                    lbsr      L012C     ; call subroutine L012C
                    lda       #1        ; set a to the constant 1
                    ldx       >U043B,u  ; load x from >U043B,u
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L032E     ; branch when carry reports an error or unsigned underflow; target L032E
                    sta       U0000,u   ; store a at U0000,u
                    leax      >L0109,pc ; form the address >L0109,pc in x
                    ldy       #35       ; set y to the constant 35
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lda       U0000,u   ; load a from U0000,u
                    ldb       #2        ; set b to the constant 2
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    tfr       u,y       ; copy the register values specified by u,y
                    puls      u         ; restore u from the stack
                    lda       #10       ; set a to the constant 10
                    sta       U0007,u   ; store a at U0007,u
L019B               tfr       x,d       ; copy the register values specified by x,d
                    lsra                ; shift a right logically
                    rorb                ; rotate b right through carry
                    tfr       d,x       ; copy the register values specified by d,x
                    tfr       y,d       ; copy the register values specified by y,d
                    rora                ; rotate a right through carry
                    rorb                ; rotate b right through carry
                    tfr       d,y       ; copy the register values specified by d,y
                    dec       U0007,u   ; decrement the value at U0007,u
                    bne       L019B     ; branch when the values differ or the result is nonzero; target L019B
                    tfr       y,d       ; copy the register values specified by y,d
                    leax      U000C,u   ; form the address U000C,u in x
                    addd      #1        ; add to d using #1
                    lbsr      L03AE     ; call subroutine L03AE
                    leax      U000C,u   ; form the address U000C,u in x
                    ldy       #5        ; set y to the constant 5
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      >L0107,pc ; form the address >L0107,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L00ED,pc ; form the address >L00ED,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L009D,pc ; form the address >L009D,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
L01E7               leax      U0001,u   ; form the address U0001,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lda       U0001,u   ; load a from U0001,u
                    cmpa      #67       ; compare a with #67 and set the condition codes
                    beq       L0203     ; branch when the values are equal or the result is zero; target L0203
                    cmpa      #24       ; compare a with #24 and set the condition codes
                    lbeq      L0320     ; branch when the values are equal or the result is zero; target L0320
                    cmpa      #21       ; compare a with #21 and set the condition codes
                    bne       L01E7     ; branch when the values differ or the result is nonzero; target L01E7
                    bra       L0207     ; continue execution at L0207
L0203               lda       #1        ; set a to the constant 1
                    sta       U0002,u   ; store a at U0002,u
L0207               lda       #2        ; set a to the constant 2
                    sta       <U0016,u  ; store a at <U0016,u
                    lda       #1        ; set a to the constant 1
                    sta       <U0017,u  ; store a at <U0017,u
                    coma                ; complement every bit in a
                    sta       <U0018,u  ; store a at <U0018,u
L0215               leax      <U0019,u  ; form the address <U0019,u in x
                    ldy       #1024     ; set y to the constant 1024
                    lda       U0000,u   ; load a from U0000,u
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lbcs      L02EE     ; branch when carry reports an error or unsigned underflow; target L02EE
                    cmpy      #1024     ; compare y with #1024 and set the condition codes
                    beq       L023D     ; branch when the values are equal or the result is zero; target L023D
                    tfr       y,d       ; copy the register values specified by y,d
                    leax      d,x       ; form the address d,x in x
                    clra                ; clear a to zero and set the condition codes
L0230               sta       ,x+       ; store a at ,x+
                    leay      $01,y     ; form the address $01,y in y
                    cmpy      #1024     ; compare y with #1024 and set the condition codes
                    bcs       L0230     ; branch when carry reports an error or unsigned underflow; target L0230
                    leax      <U0019,u  ; form the address <U0019,u in x
L023D               tst       U0002,u   ; set condition codes from U0002,u without changing it
                    bne       L0259     ; branch when the values differ or the result is nonzero; target L0259
                    clr       >U0419,u  ; clear >U0419,u to zero and set the condition codes
                    ldy       #1024     ; set y to the constant 1024
L0249               lda       ,x+       ; load a from ,x+
                    adda      >U0419,u  ; add to a using >U0419,u
                    sta       >U0419,u  ; store a at >U0419,u
                    leay      -$01,y    ; form the address -$01,y in y
                    bne       L0249     ; branch when the values differ or the result is nonzero; target L0249
                    bra       L02AA     ; continue execution at L02AA
L0259               ldd       #0        ; set d to the constant 0
                    std       >U0419,u  ; store d at >U0419,u
                    ldy       #1024     ; set y to the constant 1024
                    sty       U0003,u   ; store y at U0003,u
L0267               lda       ,x+       ; load a from ,x+
                    clrb                ; clear b to zero and set the condition codes
                    eora      >U0419,u  ; toggle selected bits in a using >U0419,u
                    eorb      >U041A,u  ; toggle selected bits in b using >U041A,u
                    std       >U0419,u  ; store d at >U0419,u
                    lda       #8        ; set a to the constant 8
                    sta       U0005,u   ; store a at U0005,u
L027A               lda       >U0419,u  ; load a from >U0419,u
                    bita      #128      ; test selected bits in a using #128
                    beq       L0292     ; branch when the values are equal or the result is zero; target L0292
                    ldd       >U0419,u  ; load d from >U0419,u
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    eora      #16       ; toggle selected bits in a using #16
                    eorb      #33       ; toggle selected bits in b using #33
                    std       >U0419,u  ; store d at >U0419,u
                    bra       L0298     ; continue execution at L0298
L0292               aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    std       >U0419,u  ; store d at >U0419,u
L0298               dec       U0005,u   ; decrement the value at U0005,u
                    bne       L027A     ; branch when the values differ or the result is nonzero; target L027A
                    ldy       U0003,u   ; load y from U0003,u
                    leay      -$01,y    ; form the address -$01,y in y
                    sty       U0003,u   ; store y at U0003,u
                    bne       L0267     ; branch when the values differ or the result is nonzero; target L0267
                    ldd       >U0419,u  ; load d from >U0419,u
L02AA               leax      <U0016,u  ; form the address <U0016,u in x
                    tst       U0002,u   ; set condition codes from U0002,u without changing it
                    beq       L02B7     ; branch when the values are equal or the result is zero; target L02B7
                    ldy       #1029     ; set y to the constant 1029
                    bra       L02BB     ; continue execution at L02BB
L02B7               ldy       #1028     ; set y to the constant 1028
L02BB               lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      U0001,u   ; form the address U0001,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lda       U0001,u   ; load a from U0001,u
                    cmpa      #21       ; compare a with #21 and set the condition codes
                    beq       L02AA     ; branch when the values are equal or the result is zero; target L02AA
                    cmpa      #6        ; compare a with #6 and set the condition codes
                    beq       L02E0     ; branch when the values are equal or the result is zero; target L02E0
                    cmpa      #24       ; compare a with #24 and set the condition codes
                    beq       L0320     ; branch when the values are equal or the result is zero; target L0320
                    cmpa      #67       ; compare a with #67 and set the condition codes
                    beq       L02AA     ; branch when the values are equal or the result is zero; target L02AA
                    ldb       #1        ; set b to the constant 1
                    bra       L032E     ; continue execution at L032E
L02E0               lda       <U0017,u  ; load a from <U0017,u
                    inca                ; increment a
                    sta       <U0017,u  ; store a at <U0017,u
                    coma                ; complement every bit in a
                    sta       <U0018,u  ; store a at <U0018,u
                    lbra      L0215     ; continue execution at L0215
L02EE               cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      L032E     ; branch when the values differ or the result is nonzero; target L032E
                    leax      >L0106,pc ; form the address >L0106,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      U0001,u   ; form the address U0001,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lda       U0001,u   ; load a from U0001,u
                    cmpa      #6        ; compare a with #6 and set the condition codes
                    bne       L0320     ; branch when the values differ or the result is nonzero; target L0320
                    leax      >L00B9,pc ; form the address >L00B9,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    bra       L032D     ; continue execution at L032D
L0320               leax      >L00D2,pc ; form the address >L00D2,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
L032D               clrb                ; clear b to zero and set the condition codes
L032E               pshs      b         ; save b on the stack
                    bsr       L0337     ; call subroutine L0337
                    puls      b         ; restore b from the stack
                    os9       F$Exit    ; invoke the OS-9 F$Exit service
L0337               leax      >U043D,u  ; form the address >U043D,u in x
                    leax      -$20,x    ; form the address -$20,x in x
                    lda       #1        ; set a to the constant 1
                    sta       <$0024,x  ; store a at <$0024,x
                    leax      >U043D,u  ; form the address >U043D,u in x
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
                    fcc       "oHoI" ; store literal character data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $4A       ; store byte data
                    fcb       $A6       ; store byte data
                    fcb       $82       ; store byte data
                    fcb       $81       ; store byte data
                    fcc       "0%." ; store literal character data
                    fcb       $81       ; store byte data
                    fcc       /9"*/ ; store literal character data
                    fcb       $80       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $A7       ; store byte data
                    fcb       $46       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcc       "mF'" ; store literal character data
                    fcb       $06       ; store byte data
                    fcb       $E3       ; store byte data
                    fcc       "JjF " ; store literal character data
                    fcb       $F6       ; store byte data
                    fcb       $E3       ; store byte data
                    fcb       $48       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $48       ; store byte data
                    fcb       $86       ; store byte data
                    fcb       $0A       ; store byte data
                    fcb       $A7       ; store byte data
                    fcb       $46       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcc       "mF'" ; store literal character data
                    fcb       $06       ; store byte data
                    fcb       $E3       ; store byte data
                    fcc       "JjF " ; store literal character data
                    fcb       $F6       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $4A       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $48       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $A0       ; store byte data
L03AE               std       U0008,u   ; store d at U0008,u
                    lda       #48       ; set a to the constant 48
                    sta       0,x       ; store a at 0,x
                    sta       $01,x     ; store a at $01,x
                    sta       $02,x     ; store a at $02,x
                    sta       $03,x     ; store a at $03,x
                    sta       $04,x     ; store a at $04,x
                    ldd       #10000    ; set d to the constant 10000
                    std       U000A,u   ; store d at U000A,u
                    ldd       U0008,u   ; load d from U0008,u
                    lbsr      L03EF     ; call subroutine L03EF
                    ldd       #1000     ; set d to the constant 1000
                    std       U000A,u   ; store d at U000A,u
                    ldd       U0008,u   ; load d from U0008,u
                    bsr       L03EF     ; call subroutine L03EF
                    ldd       #100      ; set d to the constant 100
                    std       U000A,u   ; store d at U000A,u
                    ldd       U0008,u   ; load d from U0008,u
                    bsr       L03EF     ; call subroutine L03EF
                    ldd       #10       ; set d to the constant 10
                    std       U000A,u   ; store d at U000A,u
                    ldd       U0008,u   ; load d from U0008,u
                    bsr       L03EF     ; call subroutine L03EF
                    ldd       #1        ; set d to the constant 1
                    std       U000A,u   ; store d at U000A,u
                    ldd       U0008,u   ; load d from U0008,u
                    bsr       L03EF     ; call subroutine L03EF
                    lda       #13       ; set a to the constant 13
                    sta       0,x       ; store a at 0,x
                    rts                 ; return to the caller
L03EF               subd      U000A,u   ; subtract from d using U000A,u
                    bcs       L03F7     ; branch when carry reports an error or unsigned underflow; target L03F7
                    inc       0,x       ; increment the value at 0,x
                    bra       L03EF     ; continue execution at L03EF
L03F7               addd      U000A,u   ; add to d using U000A,u
                    std       U0008,u   ; store d at U0008,u
                    leax      $01,x     ; form the address $01,x in x
                    rts                 ; return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
