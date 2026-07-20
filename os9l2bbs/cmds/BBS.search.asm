**********************************************************************
* BBS.search - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       BBS.search
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

U0000               rmb       3         ; reserve 3 byte(s) in the module workspace
U0003               rmb       1         ; reserve 1 byte(s) in the module workspace
U0004               rmb       1         ; reserve 1 byte(s) in the module workspace
U0005               rmb       2         ; reserve 2 byte(s) in the module workspace
U0007               rmb       2         ; reserve 2 byte(s) in the module workspace
U0009               rmb       6         ; reserve 6 byte(s) in the module workspace
U000F               rmb       3         ; reserve 3 byte(s) in the module workspace
U0012               rmb       1         ; reserve 1 byte(s) in the module workspace
U0013               rmb       2         ; reserve 2 byte(s) in the module workspace
U0015               rmb       1         ; reserve 1 byte(s) in the module workspace
U0016               rmb       34        ; reserve 34 byte(s) in the module workspace
U0038               rmb       1         ; reserve 1 byte(s) in the module workspace
U0039               rmb       1         ; reserve 1 byte(s) in the module workspace
U003A               rmb       1         ; reserve 1 byte(s) in the module workspace
U003B               rmb       1         ; reserve 1 byte(s) in the module workspace
U003C               rmb       1         ; reserve 1 byte(s) in the module workspace
U003D               rmb       1         ; reserve 1 byte(s) in the module workspace
U003E               rmb       1         ; reserve 1 byte(s) in the module workspace
U003F               rmb       1         ; reserve 1 byte(s) in the module workspace
U0040               rmb       1         ; reserve 1 byte(s) in the module workspace
U0041               rmb       64        ; reserve 64 byte(s) in the module workspace
U0081               rmb       4         ; reserve 4 byte(s) in the module workspace
U0085               rmb       20        ; reserve 20 byte(s) in the module workspace
U0099               rmb       30        ; reserve 30 byte(s) in the module workspace
U00B7               rmb       1         ; reserve 1 byte(s) in the module workspace
U00B8               rmb       1         ; reserve 1 byte(s) in the module workspace
U00B9               rmb       1         ; reserve 1 byte(s) in the module workspace
U00BA               rmb       205       ; reserve 205 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.search/ ; store an OS-9 high-bit-terminated string
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
                    fcc       "High message is #" ; store literal character data
                    fcb       $00       ; store byte data
                    fcb       $11       ; store byte data
L0095               fcc       "Enter subject search text" ; store literal character data
                    fcb       $0D       ; store byte data
L00AF               fcc       ">" ; store literal character data
L00B0               fcc       "Msg #    User name              Date        Subject" ; store literal character data
                    fcb       $0D       ; store byte data
L00E4               fcc       "----------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
L0125               fcc       "BBS.msg.inx" ; store literal character data
                    fcb       $0D       ; store byte data
L0131               fcc       "                                       " ; store literal character data
L0158               fcc       "          ******   DELETED   ******" ; store literal character data
                    fcb       $0D       ; store byte data
start               leax      >L0125,pc ; form the address >L0125,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L031D     ; branch when carry reports an error or unsigned underflow; target L031D
                    sta       U0000,u   ; store a at U0000,u
                    leax      <U0041,u  ; form the address <U0041,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       U0000,u   ; load a from U0000,u
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lbcs      L031D     ; branch when carry reports an error or unsigned underflow; target L031D
                    ldd       #0        ; set d to the constant 0
                    std       U0009,u   ; store d at U0009,u
L01A0               leax      >L0095,pc ; form the address >L0095,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L031D     ; branch when carry reports an error or unsigned underflow; target L031D
                    leax      >L00AF,pc ; form the address >L00AF,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L031D     ; branch when carry reports an error or unsigned underflow; target L031D
                    leax      <U0016,u  ; form the address <U0016,u in x
                    ldy       #30       ; set y to the constant 30
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    bcs       L01A0     ; branch when carry reports an error or unsigned underflow; target L01A0
                    clr       <U0015,u  ; clear <U0015,u to zero and set the condition codes
                    leax      <U0016,u  ; form the address <U0016,u in x
                    leax      >L00B0,pc ; form the address >L00B0,pc in x
                    ldy       #80       ; set y to the constant 80
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L031D     ; branch when carry reports an error or unsigned underflow; target L031D
                    leax      >L00E4,pc ; form the address >L00E4,pc in x
                    ldy       #80       ; set y to the constant 80
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L031D     ; branch when carry reports an error or unsigned underflow; target L031D
L01F3               lda       U0000,u   ; load a from U0000,u
                    ldy       #64       ; set y to the constant 64
                    leax      >U0081,u  ; form the address >U0081,u in x
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lbcs      L031C     ; branch when carry reports an error or unsigned underflow; target L031C
                    ldd       U0009,u   ; load d from U0009,u
                    addd      #1        ; add to d using #1
                    std       U0009,u   ; store d at U0009,u
                    leay      >U0099,u  ; form the address >U0099,u in y
                    ldb       #30       ; set b to the constant 30
L0211               leax      <U0016,u  ; form the address <U0016,u in x
L0214               lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L0223     ; branch when the values are equal or the result is zero; target L0223
                    decb                ; decrement b
                    beq       L01F3     ; branch when the values are equal or the result is zero; target L01F3
                    cmpa      ,y+       ; compare a with ,y+ and set the condition codes
                    bne       L0211     ; branch when the values differ or the result is nonzero; target L0211
                    bra       L0214     ; continue execution at L0214
L0223               ldd       >U0081,u  ; load d from >U0081,u
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    lbeq      L030C     ; branch when the values are equal or the result is zero; target L030C
                    ldd       U0009,u   ; load d from U0009,u
                    leax      U000F,u   ; form the address U000F,u in x
                    lbsr      L0387     ; call subroutine L0387
                    leax      U000F,u   ; form the address U000F,u in x
                    ldy       #5        ; set y to the constant 5
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L031D     ; branch when carry reports an error or unsigned underflow; target L031D
                    leax      >L0131,pc ; form the address >L0131,pc in x
                    ldy       #4        ; set y to the constant 4
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L031D     ; branch when carry reports an error or unsigned underflow; target L031D
                    leax      >U0085,u  ; form the address >U0085,u in x
                    clr       U0003,u   ; clear U0003,u to zero and set the condition codes
                    clr       U0004,u   ; clear U0004,u to zero and set the condition codes
L025C               lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L0266     ; branch when the values are equal or the result is zero; target L0266
                    inc       U0004,u   ; increment the value at U0004,u
                    bra       L025C     ; continue execution at L025C
L0266               leax      >U0085,u  ; form the address >U0085,u in x
                    ldy       U0003,u   ; load y from U0003,u
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L031D     ; branch when carry reports an error or unsigned underflow; target L031D
                    ldd       #22       ; set d to the constant 22
                    subd      U0003,u   ; subtract from d using U0003,u
                    tfr       d,y       ; copy the register values specified by d,y
                    leax      >L0131,pc ; form the address >L0131,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L031D     ; branch when carry reports an error or unsigned underflow; target L031D
                    leax      U000F,u   ; form the address U000F,u in x
                    ldb       >U00B8,u  ; load b from >U00B8,u
                    clra                ; clear a to zero and set the condition codes
                    lbsr      L0387     ; call subroutine L0387
                    lda       <U0012,u  ; load a from <U0012,u
                    sta       <U0038,u  ; store a at <U0038,u
                    lda       <U0013,u  ; load a from <U0013,u
                    sta       <U0039,u  ; store a at <U0039,u
                    lda       #47       ; set a to the constant 47
                    sta       <U003A,u  ; store a at <U003A,u
                    ldb       >U00B9,u  ; load b from >U00B9,u
                    clra                ; clear a to zero and set the condition codes
                    leax      U000F,u   ; form the address U000F,u in x
                    lbsr      L0387     ; call subroutine L0387
                    lda       <U0012,u  ; load a from <U0012,u
                    sta       <U003B,u  ; store a at <U003B,u
                    lda       <U0013,u  ; load a from <U0013,u
                    sta       <U003C,u  ; store a at <U003C,u
                    lda       #47       ; set a to the constant 47
                    sta       <U003D,u  ; store a at <U003D,u
                    ldb       >U00B7,u  ; load b from >U00B7,u
                    clra                ; clear a to zero and set the condition codes
                    leax      U000F,u   ; form the address U000F,u in x
                    lbsr      L0387     ; call subroutine L0387
                    lda       <U0012,u  ; load a from <U0012,u
                    sta       <U003E,u  ; store a at <U003E,u
                    lda       <U0013,u  ; load a from <U0013,u
                    sta       <U003F,u  ; store a at <U003F,u
                    lda       #13       ; set a to the constant 13
                    sta       <U0040,u  ; store a at <U0040,u
                    leax      <U0038,u  ; form the address <U0038,u in x
                    ldy       #8        ; set y to the constant 8
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L031D     ; branch when carry reports an error or unsigned underflow; target L031D
                    ldy       #5        ; set y to the constant 5
                    leax      >L0131,pc ; form the address >L0131,pc in x
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L031D     ; branch when carry reports an error or unsigned underflow; target L031D
                    leax      >U0099,u  ; form the address >U0099,u in x
                    ldy       #30       ; set y to the constant 30
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L031D     ; branch when carry reports an error or unsigned underflow; target L031D
                    lbra      L01F3     ; continue execution at L01F3
L030C               leax      >L0158,pc ; form the address >L0158,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbra      L01F3     ; continue execution at L01F3
L031C               clrb                ; clear b to zero and set the condition codes
L031D               os9       F$Exit    ; invoke the OS-9 F$Exit service
                    fcb       $34       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $A6       ; store byte data
                    fcb       $80       ; store byte data
                    fcb       $81       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $CB       ; store byte data
                    fcb       $81       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $F4       ; store byte data
                    fcb       $81       ; store byte data
                    fcb       $39       ; store byte data
                    fcb       $22       ; store byte data
                    fcb       $F0       ; store byte data
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
                    fcc       "oEoF" ; store literal character data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $47       ; store byte data
                    fcb       $A6       ; store byte data
                    fcb       $82       ; store byte data
                    fcb       $81       ; store byte data
                    fcc       "0%." ; store literal character data
                    fcb       $81       ; store byte data
                    fcc       /9"*/ ; store literal character data
                    fcb       $80       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $A7       ; store byte data
                    fcb       $42       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcc       "mB'" ; store literal character data
                    fcb       $06       ; store byte data
                    fcb       $E3       ; store byte data
                    fcc       "GjB " ; store literal character data
                    fcb       $F6       ; store byte data
                    fcb       $E3       ; store byte data
                    fcb       $45       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $45       ; store byte data
                    fcb       $86       ; store byte data
                    fcb       $0A       ; store byte data
                    fcb       $A7       ; store byte data
                    fcb       $42       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcc       "mB'" ; store literal character data
                    fcb       $06       ; store byte data
                    fcb       $E3       ; store byte data
                    fcc       "GjB " ; store literal character data
                    fcb       $F6       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $47       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $45       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $A0       ; store byte data
L0387               pshs      x         ; save x on the stack
                    std       U0005,u   ; store d at U0005,u
                    lda       #48       ; set a to the constant 48
                    sta       0,x       ; store a at 0,x
                    sta       $01,x     ; store a at $01,x
                    sta       $02,x     ; store a at $02,x
                    sta       $03,x     ; store a at $03,x
                    sta       $04,x     ; store a at $04,x
                    ldd       #10000    ; set d to the constant 10000
                    std       U0007,u   ; store d at U0007,u
                    ldd       U0005,u   ; load d from U0005,u
                    lbsr      L03E6     ; call subroutine L03E6
                    ldd       #1000     ; set d to the constant 1000
                    std       U0007,u   ; store d at U0007,u
                    ldd       U0005,u   ; load d from U0005,u
                    bsr       L03E6     ; call subroutine L03E6
                    ldd       #100      ; set d to the constant 100
                    std       U0007,u   ; store d at U0007,u
                    ldd       U0005,u   ; load d from U0005,u
                    bsr       L03E6     ; call subroutine L03E6
                    ldd       #10       ; set d to the constant 10
                    std       U0007,u   ; store d at U0007,u
                    ldd       U0005,u   ; load d from U0005,u
                    bsr       L03E6     ; call subroutine L03E6
                    ldd       #1        ; set d to the constant 1
                    std       U0007,u   ; store d at U0007,u
                    ldd       U0005,u   ; load d from U0005,u
                    bsr       L03E6     ; call subroutine L03E6
                    lda       #13       ; set a to the constant 13
                    sta       0,x       ; store a at 0,x
                    puls      x         ; restore x from the stack
                    ldb       #32       ; set b to the constant 32
L03CD               lda       0,x       ; load a from 0,x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bne       L03D7     ; branch when the values differ or the result is nonzero; target L03D7
                    stb       ,x+       ; store b at ,x+
                    bra       L03CD     ; continue execution at L03CD
L03D7               lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L03E3     ; branch when carry reports an error or unsigned underflow; target L03E3
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L03E3     ; branch when the unsigned value is higher; target L03E3
                    bra       L03D7     ; continue execution at L03D7
L03E3               leax      -$01,x    ; form the address -$01,x in x
                    rts                 ; return to the caller
L03E6               subd      U0007,u   ; subtract from d using U0007,u
                    bcs       L03EE     ; branch when carry reports an error or unsigned underflow; target L03EE
                    inc       0,x       ; increment the value at 0,x
                    bra       L03E6     ; continue execution at L03E6
L03EE               addd      U0007,u   ; add to d using U0007,u
                    std       U0005,u   ; store d at U0005,u
                    leax      $01,x     ; form the address $01,x in x
                    rts                 ; return to the caller
                    fcb       $CC       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $A0       ; store byte data

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
