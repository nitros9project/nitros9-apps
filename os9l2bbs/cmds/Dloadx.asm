**********************************************************************
* Dloadx - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       Dloadx
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
U0002               rmb       2         ; reserve 2 byte(s) in the module workspace
U0004               rmb       2         ; reserve 2 byte(s) in the module workspace
U0006               rmb       2         ; reserve 2 byte(s) in the module workspace
U0008               rmb       10        ; reserve 10 byte(s) in the module workspace
U0012               rmb       1         ; reserve 1 byte(s) in the module workspace
U0013               rmb       1         ; reserve 1 byte(s) in the module workspace
U0014               rmb       1         ; reserve 1 byte(s) in the module workspace
U0015               rmb       128       ; reserve 128 byte(s) in the module workspace
U0095               rmb       1         ; reserve 1 byte(s) in the module workspace
U0096               rmb       32        ; reserve 32 byte(s) in the module workspace
U00B6               rmb       2         ; reserve 2 byte(s) in the module workspace
U00B8               rmb       1         ; reserve 1 byte(s) in the module workspace
U00B9               rmb       231       ; reserve 231 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /Dloadx/ ; store an OS-9 high-bit-terminated string
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
L012C               leax      >U00B8,u  ; form the address >U00B8,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    leax      -$20,x    ; form the address -$20,x in x
                    clr       <$0024,x  ; clear <$0024,x to zero and set the condition codes
                    leax      >U00B8,u  ; form the address >U00B8,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$SetStt  ; invoke the OS-9 I$SetStt service
                    rts                 ; return to the caller
start               lda       0,x       ; load a from 0,x
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       L0165     ; branch when the values differ or the result is nonzero; target L0165
                    leax      >L007E,pc ; form the address >L007E,pc in x
                    ldy       >L009B,pc ; load y from >L009B,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      >U0096,u  ; form the address >U0096,u in x
                    ldy       #32       ; set y to the constant 32
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
L0165               stx       >U00B6,u  ; store x at >U00B6,u
                    lbsr      L012C     ; call subroutine L012C
                    lda       #1        ; set a to the constant 1
                    ldx       >U00B6,u  ; load x from >U00B6,u
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L02B5     ; branch when carry reports an error or unsigned underflow; target L02B5
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
                    lda       #7        ; set a to the constant 7
                    sta       U0002,u   ; store a at U0002,u
L0199               tfr       x,d       ; copy the register values specified by x,d
                    lsra                ; shift a right logically
                    rorb                ; rotate b right through carry
                    tfr       d,x       ; copy the register values specified by d,x
                    tfr       y,d       ; copy the register values specified by y,d
                    rora                ; rotate a right through carry
                    rorb                ; rotate b right through carry
                    tfr       d,y       ; copy the register values specified by d,y
                    dec       U0002,u   ; decrement the value at U0002,u
                    bne       L0199     ; branch when the values differ or the result is nonzero; target L0199
                    tfr       y,d       ; copy the register values specified by y,d
                    leax      U0008,u   ; form the address U0008,u in x
                    addd      #1        ; add to d using #1
                    lbsr      L0335     ; call subroutine L0335
                    leax      U0008,u   ; form the address U0008,u in x
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
L01E5               leax      U0001,u   ; form the address U0001,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lda       U0001,u   ; load a from U0001,u
                    cmpa      #24       ; compare a with #24 and set the condition codes
                    lbeq      L02A7     ; branch when the values are equal or the result is zero; target L02A7
                    cmpa      #21       ; compare a with #21 and set the condition codes
                    bne       L01E5     ; branch when the values differ or the result is nonzero; target L01E5
                    lda       #1        ; set a to the constant 1
                    sta       <U0012,u  ; store a at <U0012,u
                    sta       <U0013,u  ; store a at <U0013,u
                    coma                ; complement every bit in a
                    sta       <U0014,u  ; store a at <U0014,u
L0207               leax      <U0015,u  ; form the address <U0015,u in x
                    ldy       #128      ; set y to the constant 128
                    lda       U0000,u   ; load a from U0000,u
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    bcs       L0275     ; branch when carry reports an error or unsigned underflow; target L0275
                    cmpy      #128      ; compare y with #128 and set the condition codes
                    beq       L022D     ; branch when the values are equal or the result is zero; target L022D
                    tfr       y,d       ; copy the register values specified by y,d
                    leax      d,x       ; form the address d,x in x
                    clra                ; clear a to zero and set the condition codes
L0220               sta       ,x+       ; store a at ,x+
                    leay      $01,y     ; form the address $01,y in y
                    cmpy      #128      ; compare y with #128 and set the condition codes
                    bcs       L0220     ; branch when carry reports an error or unsigned underflow; target L0220
                    leax      <U0015,u  ; form the address <U0015,u in x
L022D               clr       >U0095,u  ; clear >U0095,u to zero and set the condition codes
                    ldb       #128      ; set b to the constant 128
L0233               lda       ,x+       ; load a from ,x+
                    adda      >U0095,u  ; add to a using >U0095,u
                    sta       >U0095,u  ; store a at >U0095,u
                    decb                ; decrement b
                    bne       L0233     ; branch when the values differ or the result is nonzero; target L0233
L0240               leax      <U0012,u  ; form the address <U0012,u in x
                    ldy       #132      ; set y to the constant 132
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      U0001,u   ; form the address U0001,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lda       U0001,u   ; load a from U0001,u
                    cmpa      #21       ; compare a with #21 and set the condition codes
                    beq       L0240     ; branch when the values are equal or the result is zero; target L0240
                    cmpa      #6        ; compare a with #6 and set the condition codes
                    beq       L0268     ; branch when the values are equal or the result is zero; target L0268
                    cmpa      #24       ; compare a with #24 and set the condition codes
                    beq       L02A7     ; branch when the values are equal or the result is zero; target L02A7
                    lda       #1        ; set a to the constant 1
                    bra       L02B5     ; continue execution at L02B5
L0268               lda       <U0013,u  ; load a from <U0013,u
                    inca                ; increment a
                    sta       <U0013,u  ; store a at <U0013,u
                    coma                ; complement every bit in a
                    sta       <U0014,u  ; store a at <U0014,u
                    bra       L0207     ; continue execution at L0207
L0275               cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      L02B5     ; branch when the values differ or the result is nonzero; target L02B5
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
                    bne       L02A7     ; branch when the values differ or the result is nonzero; target L02A7
                    leax      >L00B9,pc ; form the address >L00B9,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    bra       L02B4     ; continue execution at L02B4
L02A7               leax      >L00D2,pc ; form the address >L00D2,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
L02B4               clrb                ; clear b to zero and set the condition codes
L02B5               pshs      b         ; save b on the stack
                    bsr       L02BE     ; call subroutine L02BE
                    puls      b         ; restore b from the stack
                    os9       F$Exit    ; invoke the OS-9 F$Exit service
L02BE               leax      >U00B8,u  ; form the address >U00B8,u in x
                    leax      -$20,x    ; form the address -$20,x in x
                    lda       #1        ; set a to the constant 1
                    sta       <$0024,x  ; store a at <$0024,x
                    leax      >U00B8,u  ; form the address >U00B8,u in x
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
                    fcc       "oDoE" ; store literal character data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $46       ; store byte data
                    fcb       $A6       ; store byte data
                    fcb       $82       ; store byte data
                    fcb       $81       ; store byte data
                    fcc       "0%." ; store literal character data
                    fcb       $81       ; store byte data
                    fcc       /9"*/ ; store literal character data
                    fcb       $80       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $A7       ; store byte data
                    fcb       $43       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcc       "mC'" ; store literal character data
                    fcb       $06       ; store byte data
                    fcb       $E3       ; store byte data
                    fcc       "FjC " ; store literal character data
                    fcb       $F6       ; store byte data
                    fcb       $E3       ; store byte data
                    fcb       $44       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $44       ; store byte data
                    fcb       $86       ; store byte data
                    fcb       $0A       ; store byte data
                    fcb       $A7       ; store byte data
                    fcb       $43       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcc       "mC'" ; store literal character data
                    fcb       $06       ; store byte data
                    fcb       $E3       ; store byte data
                    fcc       "FjC " ; store literal character data
                    fcb       $F6       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $46       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $44       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $A0       ; store byte data
L0335               std       U0004,u   ; store d at U0004,u
                    lda       #48       ; set a to the constant 48
                    sta       0,x       ; store a at 0,x
                    sta       $01,x     ; store a at $01,x
                    sta       $02,x     ; store a at $02,x
                    sta       $03,x     ; store a at $03,x
                    sta       $04,x     ; store a at $04,x
                    ldd       #10000    ; set d to the constant 10000
                    std       U0006,u   ; store d at U0006,u
                    ldd       U0004,u   ; load d from U0004,u
                    lbsr      L0376     ; call subroutine L0376
                    ldd       #1000     ; set d to the constant 1000
                    std       U0006,u   ; store d at U0006,u
                    ldd       U0004,u   ; load d from U0004,u
                    bsr       L0376     ; call subroutine L0376
                    ldd       #100      ; set d to the constant 100
                    std       U0006,u   ; store d at U0006,u
                    ldd       U0004,u   ; load d from U0004,u
                    bsr       L0376     ; call subroutine L0376
                    ldd       #10       ; set d to the constant 10
                    std       U0006,u   ; store d at U0006,u
                    ldd       U0004,u   ; load d from U0004,u
                    bsr       L0376     ; call subroutine L0376
                    ldd       #1        ; set d to the constant 1
                    std       U0006,u   ; store d at U0006,u
                    ldd       U0004,u   ; load d from U0004,u
                    bsr       L0376     ; call subroutine L0376
                    lda       #13       ; set a to the constant 13
                    sta       0,x       ; store a at 0,x
                    rts                 ; return to the caller
L0376               subd      U0006,u   ; subtract from d using U0006,u
                    bcs       L037E     ; branch when carry reports an error or unsigned underflow; target L037E
                    inc       0,x       ; increment the value at 0,x
                    bra       L0376     ; continue execution at L0376
L037E               addd      U0006,u   ; add to d using U0006,u
                    std       U0004,u   ; store d at U0004,u
                    leax      $01,x     ; form the address $01,x in x
                    rts                 ; return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
