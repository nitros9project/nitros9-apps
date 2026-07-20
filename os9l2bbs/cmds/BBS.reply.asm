**********************************************************************
* BBS.reply - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       BBS.reply
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
U0008               rmb       2         ; reserve 2 byte(s) in the module workspace
U000A               rmb       2         ; reserve 2 byte(s) in the module workspace
U000C               rmb       1         ; reserve 1 byte(s) in the module workspace
U000D               rmb       1         ; reserve 1 byte(s) in the module workspace
U000E               rmb       1         ; reserve 1 byte(s) in the module workspace
U000F               rmb       1         ; reserve 1 byte(s) in the module workspace
U0010               rmb       2         ; reserve 2 byte(s) in the module workspace
U0012               rmb       2         ; reserve 2 byte(s) in the module workspace
U0014               rmb       2         ; reserve 2 byte(s) in the module workspace
U0016               rmb       1         ; reserve 1 byte(s) in the module workspace
U0017               rmb       1         ; reserve 1 byte(s) in the module workspace
U0018               rmb       2         ; reserve 2 byte(s) in the module workspace
U001A               rmb       2         ; reserve 2 byte(s) in the module workspace
U001C               rmb       200       ; reserve 200 byte(s) in the module workspace
U00E4               rmb       1         ; reserve 1 byte(s) in the module workspace
U00E5               rmb       5         ; reserve 5 byte(s) in the module workspace
U00EA               rmb       1         ; reserve 1 byte(s) in the module workspace
U00EB               rmb       2         ; reserve 2 byte(s) in the module workspace
U00ED               rmb       2         ; reserve 2 byte(s) in the module workspace
U00EF               rmb       60        ; reserve 60 byte(s) in the module workspace
U012B               rmb       2         ; reserve 2 byte(s) in the module workspace
U012D               rmb       2         ; reserve 2 byte(s) in the module workspace
U012F               rmb       20        ; reserve 20 byte(s) in the module workspace
U0143               rmb       30        ; reserve 30 byte(s) in the module workspace
U0161               rmb       6         ; reserve 6 byte(s) in the module workspace
U0167               rmb       2         ; reserve 2 byte(s) in the module workspace
U0169               rmb       2         ; reserve 2 byte(s) in the module workspace
U016B               rmb       2         ; reserve 2 byte(s) in the module workspace
U016D               rmb       2         ; reserve 2 byte(s) in the module workspace
U016F               rmb       6         ; reserve 6 byte(s) in the module workspace
U0175               rmb       2         ; reserve 2 byte(s) in the module workspace
U0177               rmb       2         ; reserve 2 byte(s) in the module workspace
U0179               rmb       2         ; reserve 2 byte(s) in the module workspace
U017B               rmb       16        ; reserve 16 byte(s) in the module workspace
U018B               rmb       8000      ; reserve 8000 byte(s) in the module workspace
U20CB               rmb       80        ; reserve 80 byte(s) in the module workspace
U211B               rmb       32        ; reserve 32 byte(s) in the module workspace
U213B               rmb       1         ; reserve 1 byte(s) in the module workspace
U213C               rmb       399       ; reserve 399 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.reply/ ; store an OS-9 high-bit-terminated string
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
L0081               fcc       "BBS.msg.inx" ; store literal character data
                    fcb       $0D       ; store byte data
L008D               fcc       "BBS.msg" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $0A       ; store byte data
                    fcc       "Enter subject of message" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $0A       ; store byte data
                    fcb       $3E       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $1C       ; store byte data
L00B3               fcb       $0A       ; store byte data
                    fcb       $0A       ; store byte data
                    fcc       "    Please enter message now            (Blank line ends)" ; store literal character data
                    fcb       $0D       ; store byte data
L00EF               fcc       "----------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
L0130               fcc       "/dd/bbs/BBS.alias" ; store literal character data
                    fcb       $0D       ; store byte data
L0142               fcb       $0A       ; store byte data
                    fcc       "[a]bort [d]one [e]dit [C]ontinue or [L]ist" ; store literal character data
                    fcb       $0D       ; store byte data
L016E               fcc       "Enter line #" ; store literal character data
                    fcb       $0D       ; store byte data
L017B               fcb       $3E       ; store byte data
L017C               fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
L017E               fcb       $08       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $08       ; store byte data
L0181               fcc       "/dd/bbs/BBS.userstats" ; store literal character data
                    fcb       $0D       ; store byte data
L0197               fcc       "User name not found!" ; store literal character data
                    fcb       $0D       ; store byte data
L01AC               fcc       "Address message to (BLANK for ALL)" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $0A       ; store byte data
start               stx       U0008,u   ; store x at U0008,u
                    clr       >U00EA,u  ; clear >U00EA,u to zero and set the condition codes
                    clr       >U00E4,u  ; clear >U00E4,u to zero and set the condition codes
                    clr       U0006,u   ; clear U0006,u to zero and set the condition codes
                    os9       F$ID      ; invoke the OS-9 F$ID service
                    lbcs      L063B     ; branch when carry reports an error or unsigned underflow; target L063B
                    sty       U000A,u   ; store y at U000A,u
                    ldy       #0        ; set y to the constant 0
                    os9       F$SUser   ; invoke the OS-9 F$SUser service
                    lbcs      L063B     ; branch when carry reports an error or unsigned underflow; target L063B
                    leax      >L0081,pc ; form the address >L0081,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L063B     ; branch when carry reports an error or unsigned underflow; target L063B
                    sta       U0000,u   ; store a at U0000,u
                    leax      >U00EB,u  ; form the address >U00EB,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       U0000,u   ; load a from U0000,u
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lbcs      L063B     ; branch when carry reports an error or unsigned underflow; target L063B
                    lda       #6        ; set a to the constant 6
                    sta       U0003,u   ; store a at U0003,u
                    ldd       >U00EB,u  ; load d from >U00EB,u
                    addd      #1        ; add to d using #1
                    std       >U00EB,u  ; store d at >U00EB,u
                    clr       U000E,u   ; clear U000E,u to zero and set the condition codes
                    clr       U000F,u   ; clear U000F,u to zero and set the condition codes
L0224               aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    rol       U000F,u   ; rotate left through carry the value at U000F,u
                    dec       U0003,u   ; decrement the value at U0003,u
                    bne       L0224     ; branch when the values differ or the result is nonzero; target L0224
                    std       <U0010,u  ; store d at <U0010,u
                    lda       U0000,u   ; load a from U0000,u
                    ldx       U000E,u   ; load x from U000E,u
                    pshs      u         ; save u on the stack
                    ldu       <U0010,u  ; load u from <U0010,u
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    lbcs      L063B     ; branch when carry reports an error or unsigned underflow; target L063B
                    puls      u         ; restore u from the stack
                    leax      >U0161,u  ; form the address >U0161,u in x
                    os9       F$Time    ; invoke the OS-9 F$Time service
                    ldx       U0008,u   ; load x from U0008,u
                    leay      >U0143,u  ; form the address >U0143,u in y
                    ldb       #30       ; set b to the constant 30
L0250               lda       ,x+       ; load a from ,x+
                    sta       ,y+       ; store a at ,y+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L025B     ; branch when the values are equal or the result is zero; target L025B
                    decb                ; decrement b
                    bne       L0250     ; branch when the values differ or the result is nonzero; target L0250
L025B               leax      >L0130,pc ; form the address >L0130,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L063B     ; branch when carry reports an error or unsigned underflow; target L063B
                    sta       U0002,u   ; store a at U0002,u
L026A               leax      >L01AC,pc ; form the address >L01AC,pc in x
                    ldy       #36       ; set y to the constant 36
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      >U213B,u  ; form the address >U213B,u in x
                    ldy       #200      ; set y to the constant 200
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    ble       L02F1     ; branch when the signed value is less than or equal; target L02F1
L0289               lda       ,x+       ; load a from ,x+
                    anda      #223      ; mask a using #223
                    sta       -$01,x    ; store a at -$01,x
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       L0289     ; branch when the values differ or the result is nonzero; target L0289
L0293               leax      <U001C,u  ; form the address <U001C,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       U0002,u   ; load a from U0002,u
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    bcs       L02D4     ; branch when carry reports an error or unsigned underflow; target L02D4
                    leay      >U213B,u  ; form the address >U213B,u in y
                    leax      <U001C,u  ; form the address <U001C,u in x
L02A8               lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    beq       L02B6     ; branch when the values are equal or the result is zero; target L02B6
                    anda      #223      ; mask a using #223
                    cmpa      ,y+       ; compare a with ,y+ and set the condition codes
                    bne       L0293     ; branch when the values differ or the result is nonzero; target L0293
                    bra       L02A8     ; continue execution at L02A8
L02B6               lda       ,y+       ; load a from ,y+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       L0293     ; branch when the values differ or the result is nonzero; target L0293
                    lbsr      L07D2     ; call subroutine L07D2
                    std       >U0169,u  ; store d at >U0169,u
                    lda       U0002,u   ; load a from U0002,u
                    pshs      u         ; save u on the stack
                    ldu       #0        ; set u to the constant 0
                    ldx       #0        ; set x to the constant 0
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    puls      u         ; restore u from the stack
                    bra       L02F8     ; continue execution at L02F8
L02D4               leax      >L0197,pc ; form the address >L0197,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lda       U0002,u   ; load a from U0002,u
                    pshs      u         ; save u on the stack
                    ldu       #0        ; set u to the constant 0
                    ldx       #0        ; set x to the constant 0
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    lbra      L026A     ; continue execution at L026A
L02F1               ldd       #-1       ; set d to the constant -1
                    std       >U0169,u  ; store d at >U0169,u
L02F8               leax      >L00B3,pc ; form the address >L00B3,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L063B     ; branch when carry reports an error or unsigned underflow; target L063B
                    leax      >L00EF,pc ; form the address >L00EF,pc in x
                    ldy       #80       ; set y to the constant 80
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L063B     ; branch when carry reports an error or unsigned underflow; target L063B
                    ldd       #0        ; set d to the constant 0
                    std       U000C,u   ; store d at U000C,u
L031D               ldd       U000C,u   ; load d from U000C,u
                    addd      #1        ; add to d using #1
                    std       U000C,u   ; store d at U000C,u
                    cmpd      #99       ; compare d with #99 and set the condition codes
                    bge       L0335     ; branch when the signed value is greater than or equal; target L0335
                    lbsr      L0432     ; call subroutine L0432
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bls       L0335     ; branch when the unsigned value is lower or equal; target L0335
                    bra       L031D     ; continue execution at L031D
L0335               leax      >L0142,pc ; form the address >L0142,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L017B,pc ; form the address >L017B,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      U0005,u   ; form the address U0005,u in x
                    clra                ; clear a to zero and set the condition codes
                    ldy       #1        ; set y to the constant 1
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    leax      >L017C,pc ; form the address >L017C,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lda       U0005,u   ; load a from U0005,u
                    anda      #223      ; mask a using #223
                    cmpa      #65       ; compare a with #65 and set the condition codes
                    lbeq      L063E     ; branch when the values are equal or the result is zero; target L063E
                    cmpa      #68       ; compare a with #68 and set the condition codes
                    lbeq      L0487     ; branch when the values are equal or the result is zero; target L0487
                    cmpa      #69       ; compare a with #69 and set the condition codes
                    beq       L038B     ; branch when the values are equal or the result is zero; target L038B
                    cmpa      #67       ; compare a with #67 and set the condition codes
                    beq       L0382     ; branch when the values are equal or the result is zero; target L0382
                    cmpa      #76       ; compare a with #76 and set the condition codes
                    beq       L03F1     ; branch when the values are equal or the result is zero; target L03F1
                    bra       L0335     ; continue execution at L0335
L0382               ldd       U000C,u   ; load d from U000C,u
                    subd      #1        ; subtract from d using #1
                    std       U000C,u   ; store d at U000C,u
                    bra       L031D     ; continue execution at L031D
L038B               leax      >L016E,pc ; form the address >L016E,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L017B,pc ; form the address >L017B,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    clra                ; clear a to zero and set the condition codes
                    leax      >U00E5,u  ; form the address >U00E5,u in x
                    ldy       #3        ; set y to the constant 3
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    lbsr      L07D2     ; call subroutine L07D2
                    cmpd      U000C,u   ; compare d with U000C,u and set the condition codes
                    lbcc      L0335     ; branch when carry is clear; target L0335
                    std       <U001A,u  ; store d at <U001A,u
                    leax      >U00E5,u  ; form the address >U00E5,u in x
                    lbsr      L0842     ; call subroutine L0842
                    leax      >U00E5,u  ; form the address >U00E5,u in x
                    lda       #58       ; set a to the constant 58
                    sta       $02,x     ; store a at $02,x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    ldd       <U001A,u  ; load d from <U001A,u
                    leax      >U018B,u  ; form the address >U018B,u in x
                    lda       #80       ; set a to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      d,x       ; form the address d,x in x
                    ldy       #80       ; set y to the constant 80
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    ldd       <U001A,u  ; load d from <U001A,u
                    bsr       L0432     ; call subroutine L0432
                    lbra      L0335     ; continue execution at L0335
L03F1               ldd       #0        ; set d to the constant 0
                    std       U000C,u   ; store d at U000C,u
L03F6               ldd       U000C,u   ; load d from U000C,u
                    addd      #1        ; add to d using #1
                    std       U000C,u   ; store d at U000C,u
                    leax      >U00E5,u  ; form the address >U00E5,u in x
                    lbsr      L0842     ; call subroutine L0842
                    leax      >U00E5,u  ; form the address >U00E5,u in x
                    lda       #58       ; set a to the constant 58
                    sta       $02,x     ; store a at $02,x
                    lda       #1        ; set a to the constant 1
                    ldy       #3        ; set y to the constant 3
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      >U018B,u  ; form the address >U018B,u in x
                    ldd       U000C,u   ; load d from U000C,u
                    lda       #80       ; set a to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      d,x       ; form the address d,x in x
                    ldy       #80       ; set y to the constant 80
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bhi       L03F6     ; branch when the unsigned value is higher; target L03F6
                    lbra      L0335     ; continue execution at L0335
L0432               leax      >U00E5,u  ; form the address >U00E5,u in x
                    pshs      d         ; save d on the stack
                    lbsr      L0842     ; call subroutine L0842
                    leax      >U00E5,u  ; form the address >U00E5,u in x
                    lda       #58       ; set a to the constant 58
                    sta       $02,x     ; store a at $02,x
                    lda       #1        ; set a to the constant 1
                    ldy       #3        ; set y to the constant 3
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L063B     ; branch when carry reports an error or unsigned underflow; target L063B
                    leax      >U20CB,u  ; form the address >U20CB,u in x
                    ldb       U0006,u   ; load b from U0006,u
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    puls      d         ; restore d from the stack
                    lda       #80       ; set a to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      >U018B,u  ; form the address >U018B,u in x
                    leax      d,x       ; form the address d,x in x
                    leay      >U20CB,u  ; form the address >U20CB,u in y
                    ldb       #80       ; set b to the constant 80
                    lda       U0006,u   ; load a from U0006,u
                    beq       L0480     ; branch when the values are equal or the result is zero; target L0480
                    sta       <U0016,u  ; store a at <U0016,u
L0476               lda       ,y+       ; load a from ,y+
                    sta       ,x+       ; store a at ,x+
                    decb                ; decrement b
                    dec       <U0016,u  ; decrement the value at <U0016,u
                    bne       L0476     ; branch when the values differ or the result is nonzero; target L0476
L0480               clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    lbsr      L0642     ; call subroutine L0642
                    rts                 ; return to the caller
L0487               leax      <U001C,u  ; form the address <U001C,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       U0002,u   ; load a from U0002,u
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    lbcs      L063B     ; branch when carry reports an error or unsigned underflow; target L063B
L0497               lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    bne       L0497     ; branch when the values differ or the result is nonzero; target L0497
                    lbsr      L07D2     ; call subroutine L07D2
                    cmpd      U000A,u   ; compare d with U000A,u and set the condition codes
                    bne       L0487     ; branch when the values differ or the result is nonzero; target L0487
                    leax      <U001C,u  ; form the address <U001C,u in x
                    leay      >U012F,u  ; form the address >U012F,u in y
L04AC               lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    beq       L04B6     ; branch when the values are equal or the result is zero; target L04B6
                    sta       ,y+       ; store a at ,y+
                    bra       L04AC     ; continue execution at L04AC
L04B6               lda       #13       ; set a to the constant 13
                    sta       0,y       ; store a at 0,y
                    ldd       >U00ED,u  ; load d from >U00ED,u
                    std       >U012B,u  ; store d at >U012B,u
                    ldd       >U00EF,u  ; load d from >U00EF,u
                    std       >U012D,u  ; store d at >U012D,u
                    ldd       U000A,u   ; load d from U000A,u
                    std       >U0167,u  ; store d at >U0167,u
                    leax      >U012B,u  ; form the address >U012B,u in x
                    lda       U0000,u   ; load a from U0000,u
                    ldy       #64       ; set y to the constant 64
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L063B     ; branch when carry reports an error or unsigned underflow; target L063B
                    leax      >L008D,pc ; form the address >L008D,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L063B     ; branch when carry reports an error or unsigned underflow; target L063B
                    sta       U0001,u   ; store a at U0001,u
                    pshs      u         ; save u on the stack
                    ldx       >U00ED,u  ; load x from >U00ED,u
                    lda       U0001,u   ; load a from U0001,u
                    ldu       >U00EF,u  ; load u from >U00EF,u
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    lbcs      L063B     ; branch when carry reports an error or unsigned underflow; target L063B
                    puls      u         ; restore u from the stack
                    lda       #0        ; set a to the constant 0
                    sta       <U0012,u  ; store a at <U0012,u
                    ldd       #1        ; set d to the constant 1
                    std       <U0014,u  ; store d at <U0014,u
L0510               lda       <U0012,u  ; load a from <U0012,u
                    inca                ; increment a
                    sta       <U0012,u  ; store a at <U0012,u
                    cmpa      U000D,u   ; compare a with U000D,u and set the condition codes
                    bhi       L0541     ; branch when the unsigned value is higher; target L0541
                    ldb       #80       ; set b to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      >U018B,u  ; form the address >U018B,u in x
                    leax      d,x       ; form the address d,x in x
                    ldy       #80       ; set y to the constant 80
                    lda       U0001,u   ; load a from U0001,u
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L063B     ; branch when carry reports an error or unsigned underflow; target L063B
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bls       L0541     ; branch when the unsigned value is lower or equal; target L0541
                    tfr       y,d       ; copy the register values specified by y,d
                    addd      <U0014,u  ; add to d using <U0014,u
                    std       <U0014,u  ; store d at <U0014,u
                    bra       L0510     ; continue execution at L0510
L0541               ldd       >U00EF,u  ; load d from >U00EF,u
                    addd      <U0014,u  ; add to d using <U0014,u
                    std       >U00EF,u  ; store d at >U00EF,u
                    bcc       L0559     ; branch when carry is clear; target L0559
                    ldd       >U00ED,u  ; load d from >U00ED,u
                    addd      #1        ; add to d using #1
                    std       >U00ED,u  ; store d at >U00ED,u
L0559               pshs      u         ; save u on the stack
                    lda       U0000,u   ; load a from U0000,u
                    ldx       #0        ; set x to the constant 0
                    ldu       #0        ; set u to the constant 0
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    lbcs      L063B     ; branch when carry reports an error or unsigned underflow; target L063B
                    puls      u         ; restore u from the stack
                    leax      >U00EB,u  ; form the address >U00EB,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       U0000,u   ; load a from U0000,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L063B     ; branch when carry reports an error or unsigned underflow; target L063B
                    leax      >L0181,pc ; form the address >L0181,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    bcc       L0591     ; branch when carry is clear; target L0591
                    ldb       #27       ; set b to the constant 27
                    os9       I$Create  ; invoke the OS-9 I$Create service
                    lbcs      L063B     ; branch when carry reports an error or unsigned underflow; target L063B
L0591               sta       U0007,u   ; store a at U0007,u
L0593               leax      >U016B,u  ; form the address >U016B,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       U0007,u   ; load a from U0007,u
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    bcs       L05AD     ; branch when carry reports an error or unsigned underflow; target L05AD
                    ldd       >U016B,u  ; load d from >U016B,u
                    cmpd      U000A,u   ; compare d with U000A,u and set the condition codes
                    bne       L0593     ; branch when the values differ or the result is nonzero; target L0593
                    bra       L05B6     ; continue execution at L05B6
L05AD               cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      L063B     ; branch when the values differ or the result is nonzero; target L063B
                    lbra      L05F4     ; continue execution at L05F4
L05B6               ldd       >U0175,u  ; load d from >U0175,u
                    addd      #1        ; add to d using #1
                    std       >U0175,u  ; store d at >U0175,u
                    lda       U0007,u   ; load a from U0007,u
                    ldb       #5        ; set b to the constant 5
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    tfr       u,d       ; copy the register values specified by u,d
                    subd      #32       ; subtract from d using #32
                    bge       L05D3     ; branch when the signed value is greater than or equal; target L05D3
                    leax      -$01,x    ; form the address -$01,x in x
L05D3               ldu       0,s       ; load u from the current stack frame at 0,s
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       U0007,u   ; load a from U0007,u
                    tfr       y,u       ; copy the register values specified by y,u
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    lbcs      L063B     ; branch when carry reports an error or unsigned underflow; target L063B
                    puls      u         ; restore u from the stack
                    leax      >U016B,u  ; form the address >U016B,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       U0007,u   ; load a from U0007,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbra      L0634     ; continue execution at L0634
L05F4               leax      >U016B,u  ; form the address >U016B,u in x
                    ldd       #1        ; set d to the constant 1
                    std       >U016D,u  ; store d at >U016D,u
                    ldd       #0        ; set d to the constant 0
                    std       >U0175,u  ; store d at >U0175,u
                    std       >U0177,u  ; store d at >U0177,u
                    std       >U017B,u  ; store d at >U017B,u
                    std       >U0179,u  ; store d at >U0179,u
                    ldd       U000A,u   ; load d from U000A,u
                    std       >U016B,u  ; store d at >U016B,u
                    leax      >U016F,u  ; form the address >U016F,u in x
                    os9       F$Time    ; invoke the OS-9 F$Time service
                    lbcs      L063B     ; branch when carry reports an error or unsigned underflow; target L063B
                    leax      >U016B,u  ; form the address >U016B,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       U0007,u   ; load a from U0007,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L063B     ; branch when carry reports an error or unsigned underflow; target L063B
L0634               clrb                ; clear b to zero and set the condition codes
                    ldy       U000A,u   ; load y from U000A,u
                    os9       F$SUser   ; invoke the OS-9 F$SUser service
L063B               os9       F$Exit    ; invoke the OS-9 F$Exit service
L063E               ldb       #1        ; set b to the constant 1
                    bra       L063B     ; continue execution at L063B
L0642               lbsr      L079B     ; call subroutine L079B
                    ldb       U0006,u   ; load b from U0006,u
                    leay      b,y       ; form the address b,y in y
                    pshs      y         ; save y on the stack
                    negb                ; negate b
                    sex                 ; sign-extend b into d
                    leay      d,y       ; form the address d,y in y
                    clr       U0006,u   ; clear U0006,u to zero and set the condition codes
                    cmpy      #0        ; compare y with #0 and set the condition codes
                    lbeq      L0711     ; branch when the values are equal or the result is zero; target L0711
                    pshs      y,x       ; save y,x on the stack
                    lda       #13       ; set a to the constant 13
L065D               sta       ,x+       ; store a at ,x+
                    leay      -$01,y    ; form the address -$01,y in y
                    bne       L065D     ; branch when the values differ or the result is nonzero; target L065D
                    puls      y,x       ; restore y,x from the stack
L0665               pshs      y,x       ; save y,x on the stack
                    leax      U0005,u   ; form the address U0005,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    bcs       L069E     ; branch when carry reports an error or unsigned underflow; target L069E
                    lda       U0005,u   ; load a from U0005,u
                    cmpa      #1        ; compare a with #1 and set the condition codes
                    beq       L06A2     ; branch when the values are equal or the result is zero; target L06A2
                    cmpa      #8        ; compare a with #8 and set the condition codes
                    beq       L06C4     ; branch when the values are equal or the result is zero; target L06C4
                    cmpa      #24       ; compare a with #24 and set the condition codes
                    beq       L06E8     ; branch when the values are equal or the result is zero; target L06E8
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      L070F     ; branch when the values are equal or the result is zero; target L070F
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    bcs       L069E     ; branch when carry reports an error or unsigned underflow; target L069E
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    puls      y,x       ; restore y,x from the stack
                    lda       U0005,u   ; load a from U0005,u
                    sta       ,x+       ; store a at ,x+
                    leay      -$01,y    ; form the address -$01,y in y
                    lbeq      L0738     ; branch when the values are equal or the result is zero; target L0738
                    bra       L0665     ; continue execution at L0665
L069E               puls      y,x       ; restore y,x from the stack
                    bra       L0665     ; continue execution at L0665
L06A2               puls      y,x       ; restore y,x from the stack
                    leay      -$01,y    ; form the address -$01,y in y
                    beq       L06BF     ; branch when the values are equal or the result is zero; target L06BF
                    lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L06BD     ; branch when the values are equal or the result is zero; target L06BD
                    pshs      y,x       ; save y,x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    bra       L06A2     ; continue execution at L06A2
L06BD               leax      -$01,x    ; form the address -$01,x in x
L06BF               leay      $01,y     ; form the address $01,y in y
                    lbra      L0665     ; continue execution at L0665
L06C4               puls      y,x       ; restore y,x from the stack
                    leay      $01,y     ; form the address $01,y in y
                    cmpy      0,s       ; compare y with 0,s and set the condition codes
                    bhi       L06E3     ; branch when the unsigned value is higher; target L06E3
                    pshs      y,x       ; save y,x on the stack
                    leax      >L017E,pc ; form the address >L017E,pc in x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    puls      y,x       ; restore y,x from the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    lbra      L0665     ; continue execution at L0665
L06E3               leay      -$01,y    ; form the address -$01,y in y
                    lbra      L0665     ; continue execution at L0665
L06E8               puls      y,x       ; restore y,x from the stack
                    leay      $01,y     ; form the address $01,y in y
                    cmpy      0,s       ; compare y with 0,s and set the condition codes
                    bhi       L06E3     ; branch when the unsigned value is higher; target L06E3
                    pshs      y,x       ; save y,x on the stack
                    leax      >L017E,pc ; form the address >L017E,pc in x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    puls      y,x       ; restore y,x from the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    cmpy      0,s       ; compare y with 0,s and set the condition codes
                    lbhi      L0665     ; branch when the unsigned value is higher; target L0665
                    pshs      y,x       ; save y,x on the stack
                    bra       L06E8     ; continue execution at L06E8
L070F               puls      y,x       ; restore y,x from the stack
L0711               lda       #13       ; set a to the constant 13
                    sta       ,x+       ; store a at ,x+
                    pshs      y,x       ; save y,x on the stack
                    leax      >L017C,pc ; form the address >L017C,pc in x
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
                    lbsr      L07B5     ; call subroutine L07B5
                    rts                 ; return to the caller
                    fcc       "50" ; store literal character data
L0738               puls      d         ; restore d from the stack
                    pshs      y         ; save y on the stack
                    subd      0,s       ; subtract from d using 0,s
                    leas      $02,s     ; adjust the system stack pointer
                    addd      #1        ; add to d using #1
                    tfr       d,y       ; copy the register values specified by d,y
                    clrb                ; clear b to zero and set the condition codes
L0746               leay      -$01,y    ; form the address -$01,y in y
                    beq       L0764     ; branch when the values are equal or the result is zero; target L0764
                    lda       ,-x       ; load a from ,-x
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       L0775     ; branch when the values are equal or the result is zero; target L0775
                    pshs      y,x       ; save y,x on the stack
                    leax      >L017E,pc ; form the address >L017E,pc in x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    incb                ; increment b
                    puls      y,x       ; restore y,x from the stack
                    bra       L0746     ; continue execution at L0746
L0764               lda       #13       ; set a to the constant 13
                    sta       <$004F,x  ; store a at <$004F,x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    puls      y         ; restore y from the stack
                    rts                 ; return to the caller
L0775               lda       #13       ; set a to the constant 13
                    sta       ,x+       ; store a at ,x+
                    pshs      y,x       ; save y,x on the stack
                    stb       U0006,u   ; store b at U0006,u
                    leay      >U20CB,u  ; form the address >U20CB,u in y
L0781               lda       ,x+       ; load a from ,x+
                    sta       ,y+       ; store a at ,y+
                    decb                ; decrement b
                    bne       L0781     ; branch when the values differ or the result is nonzero; target L0781
                    leax      >L017C,pc ; form the address >L017C,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    puls      y,x       ; restore y,x from the stack
                    lbsr      L07B5     ; call subroutine L07B5
                    rts                 ; return to the caller
L079B               pshs      y,x,d     ; save y,x,d on the stack
                    leax      >U211B,u  ; form the address >U211B,u in x
                    clra                ; clear a to zero and set the condition codes
                    ldb       #0        ; set b to the constant 0
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    leax      -$20,x    ; form the address -$20,x in x
                    clr       <$0024,x  ; clear <$0024,x to zero and set the condition codes
                    leax      <$0020,x  ; form the address <$0020,x in x
                    os9       I$SetStt  ; invoke the OS-9 I$SetStt service
                    puls      pc,y,x,d  ; restore pc,y,x,d and return to the caller
L07B5               pshs      y,x,d     ; save y,x,d on the stack
                    leax      >U211B,u  ; form the address >U211B,u in x
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
L07D2               pshs      y         ; save y on the stack
L07D4               lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      L087B     ; branch when the values are equal or the result is zero; target L087B
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L07D4     ; branch when carry reports an error or unsigned underflow; target L07D4
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L07D4     ; branch when the unsigned value is higher; target L07D4
                    leax      -$01,x    ; form the address -$01,x in x
L07E6               lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L07F2     ; branch when carry reports an error or unsigned underflow; target L07F2
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L07F2     ; branch when the unsigned value is higher; target L07F2
                    bra       L07E6     ; continue execution at L07E6
L07F2               pshs      x         ; save x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    clr       <U0016,u  ; clear <U0016,u to zero and set the condition codes
                    clr       <U0017,u  ; clear <U0017,u to zero and set the condition codes
                    ldd       #1        ; set d to the constant 1
                    std       <U0018,u  ; store d at <U0018,u
L0802               lda       ,-x       ; load a from ,-x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L083B     ; branch when carry reports an error or unsigned underflow; target L083B
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L083B     ; branch when the unsigned value is higher; target L083B
                    suba      #48       ; subtract from a using #48
                    sta       U0004,u   ; store a at U0004,u
                    ldd       #0        ; set d to the constant 0
L0813               tst       U0004,u   ; set condition codes from U0004,u without changing it
                    beq       L081E     ; branch when the values are equal or the result is zero; target L081E
                    addd      <U0018,u  ; add to d using <U0018,u
                    dec       U0004,u   ; decrement the value at U0004,u
                    bra       L0813     ; continue execution at L0813
L081E               addd      <U0016,u  ; add to d using <U0016,u
                    std       <U0016,u  ; store d at <U0016,u
                    lda       #10       ; set a to the constant 10
                    sta       U0004,u   ; store a at U0004,u
                    ldd       #0        ; set d to the constant 0
L082B               tst       U0004,u   ; set condition codes from U0004,u without changing it
                    beq       L0836     ; branch when the values are equal or the result is zero; target L0836
                    addd      <U0018,u  ; add to d using <U0018,u
                    dec       U0004,u   ; decrement the value at U0004,u
                    bra       L082B     ; continue execution at L082B
L0836               std       <U0018,u  ; store d at <U0018,u
                    bra       L0802     ; continue execution at L0802
L083B               ldd       <U0016,u  ; load d from <U0016,u
                    puls      x         ; restore x from the stack
                    puls      pc,y      ; restore pc,y and return to the caller
L0842               pshs      y         ; save y on the stack
                    std       <U0016,u  ; store d at <U0016,u
                    lda       #48       ; set a to the constant 48
                    sta       0,x       ; store a at 0,x
                    sta       $01,x     ; store a at $01,x
                    ldd       #10       ; set d to the constant 10
                    std       <U0018,u  ; store d at <U0018,u
                    ldd       <U0016,u  ; load d from <U0016,u
                    bsr       L0869     ; call subroutine L0869
                    ldd       #1        ; set d to the constant 1
                    std       <U0018,u  ; store d at <U0018,u
                    ldd       <U0016,u  ; load d from <U0016,u
                    bsr       L0869     ; call subroutine L0869
                    lda       #13       ; set a to the constant 13
                    sta       0,x       ; store a at 0,x
                    puls      pc,y      ; restore pc,y and return to the caller
L0869               subd      <U0018,u  ; subtract from d using <U0018,u
                    bcs       L0872     ; branch when carry reports an error or unsigned underflow; target L0872
                    inc       0,x       ; increment the value at 0,x
                    bra       L0869     ; continue execution at L0869
L0872               addd      <U0018,u  ; add to d using <U0018,u
                    std       <U0016,u  ; store d at <U0016,u
                    leax      $01,x     ; form the address $01,x in x
                    rts                 ; return to the caller
L087B               ldd       #-1       ; set d to the constant -1
                    puls      pc,y      ; restore pc,y and return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
