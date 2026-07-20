**********************************************************************
* BBS.post - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       BBS.post
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
U000A               rmb       1         ; reserve 1 byte(s) in the module workspace
U000B               rmb       1         ; reserve 1 byte(s) in the module workspace
U000C               rmb       1         ; reserve 1 byte(s) in the module workspace
U000D               rmb       1         ; reserve 1 byte(s) in the module workspace
U000E               rmb       2         ; reserve 2 byte(s) in the module workspace
U0010               rmb       2         ; reserve 2 byte(s) in the module workspace
U0012               rmb       2         ; reserve 2 byte(s) in the module workspace
U0014               rmb       1         ; reserve 1 byte(s) in the module workspace
U0015               rmb       1         ; reserve 1 byte(s) in the module workspace
U0016               rmb       2         ; reserve 2 byte(s) in the module workspace
U0018               rmb       2         ; reserve 2 byte(s) in the module workspace
U001A               rmb       200       ; reserve 200 byte(s) in the module workspace
U00E2               rmb       1         ; reserve 1 byte(s) in the module workspace
U00E3               rmb       5         ; reserve 5 byte(s) in the module workspace
U00E8               rmb       1         ; reserve 1 byte(s) in the module workspace
U00E9               rmb       2         ; reserve 2 byte(s) in the module workspace
U00EB               rmb       2         ; reserve 2 byte(s) in the module workspace
U00ED               rmb       60        ; reserve 60 byte(s) in the module workspace
U0129               rmb       2         ; reserve 2 byte(s) in the module workspace
U012B               rmb       2         ; reserve 2 byte(s) in the module workspace
U012D               rmb       20        ; reserve 20 byte(s) in the module workspace
U0141               rmb       30        ; reserve 30 byte(s) in the module workspace
U015F               rmb       6         ; reserve 6 byte(s) in the module workspace
U0165               rmb       2         ; reserve 2 byte(s) in the module workspace
U0167               rmb       2         ; reserve 2 byte(s) in the module workspace
U0169               rmb       2         ; reserve 2 byte(s) in the module workspace
U016B               rmb       2         ; reserve 2 byte(s) in the module workspace
U016D               rmb       6         ; reserve 6 byte(s) in the module workspace
U0173               rmb       2         ; reserve 2 byte(s) in the module workspace
U0175               rmb       2         ; reserve 2 byte(s) in the module workspace
U0177               rmb       2         ; reserve 2 byte(s) in the module workspace
U0179               rmb       16        ; reserve 16 byte(s) in the module workspace
U0189               rmb       200       ; reserve 200 byte(s) in the module workspace
U0251               rmb       8000      ; reserve 8000 byte(s) in the module workspace
U2191               rmb       80        ; reserve 80 byte(s) in the module workspace
U21E1               rmb       1         ; reserve 1 byte(s) in the module workspace
U21E2               rmb       231       ; reserve 231 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.post/ ; store an OS-9 high-bit-terminated string
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
L0080               fcc       "BBS.msg.inx" ; store literal character data
                    fcb       $0D       ; store byte data
L008C               fcc       "BBS.msg" ; store literal character data
                    fcb       $0D       ; store byte data
L0094               fcb       $0A       ; store byte data
                    fcc       "Enter subject of message" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $0A       ; store byte data
                    fcc       ">" ; store literal character data
L00B0               fcc       "Address message to (BLANK for ALL):" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $0A       ; store byte data
                    fcb       $3E       ; store byte data
L00D6               fcb       $00       ; store byte data
                    fcb       $1C       ; store byte data
L00D8               fcb       $0A       ; store byte data
                    fcb       $0A       ; store byte data
                    fcc       "    Please enter message now            (Blank line ends)" ; store literal character data
                    fcb       $0D       ; store byte data
L0114               fcc       "----------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
L0155               fcc       "/dd/bbs/BBS.alias" ; store literal character data
                    fcb       $0D       ; store byte data
L0167               fcb       $0A       ; store byte data
                    fcc       "[a]bort [d]one [e]dit [C]ontinue or [L]ist" ; store literal character data
                    fcb       $0D       ; store byte data
L0193               fcc       "Enter line #" ; store literal character data
                    fcb       $0D       ; store byte data
L01A0               fcb       $3E       ; store byte data
L01A1               fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
L01A3               fcb       $08       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $08       ; store byte data
L01A6               fcc       "/dd/bbs/BBS.userstats" ; store literal character data
                    fcb       $0D       ; store byte data
L01BC               fcc       "User name not found!" ; store literal character data
                    fcb       $0D       ; store byte data
start               clr       >U00E8,u  ; clear >U00E8,u to zero and set the condition codes
                    clr       >U00E2,u  ; clear >U00E2,u to zero and set the condition codes
                    clr       U0006,u   ; clear U0006,u to zero and set the condition codes
                    os9       F$ID      ; invoke the OS-9 F$ID service
                    lbcs      L066A     ; branch when carry reports an error or unsigned underflow; target L066A
                    sty       U0008,u   ; store y at U0008,u
                    ldy       #0        ; set y to the constant 0
                    os9       F$SUser   ; invoke the OS-9 F$SUser service
                    lbcs      L066A     ; branch when carry reports an error or unsigned underflow; target L066A
                    leax      >L0080,pc ; form the address >L0080,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L066A     ; branch when carry reports an error or unsigned underflow; target L066A
                    sta       U0000,u   ; store a at U0000,u
                    leax      >U00E9,u  ; form the address >U00E9,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       U0000,u   ; load a from U0000,u
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lbcs      L066A     ; branch when carry reports an error or unsigned underflow; target L066A
                    lda       U0000,u   ; load a from U0000,u
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    leax      >L0080,pc ; form the address >L0080,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L066A     ; branch when carry reports an error or unsigned underflow; target L066A
                    sta       U0000,u   ; store a at U0000,u
                    lda       #6        ; set a to the constant 6
                    sta       U0003,u   ; store a at U0003,u
                    ldd       >U00E9,u  ; load d from >U00E9,u
                    addd      #1        ; add to d using #1
                    std       >U00E9,u  ; store d at >U00E9,u
                    clr       U000C,u   ; clear U000C,u to zero and set the condition codes
                    clr       U000D,u   ; clear U000D,u to zero and set the condition codes
L0237               aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    rol       U000D,u   ; rotate left through carry the value at U000D,u
                    dec       U0003,u   ; decrement the value at U0003,u
                    bne       L0237     ; branch when the values differ or the result is nonzero; target L0237
                    std       U000E,u   ; store d at U000E,u
                    lda       U0000,u   ; load a from U0000,u
                    ldx       U000C,u   ; load x from U000C,u
                    pshs      u         ; save u on the stack
                    ldu       U000E,u   ; load u from U000E,u
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    lbcs      L066A     ; branch when carry reports an error or unsigned underflow; target L066A
                    puls      u         ; restore u from the stack
                    leax      >U015F,u  ; form the address >U015F,u in x
                    os9       F$Time    ; invoke the OS-9 F$Time service
                    leax      >L0094,pc ; form the address >L0094,pc in x
                    ldy       >L00D6,pc ; load y from >L00D6,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L066A     ; branch when carry reports an error or unsigned underflow; target L066A
                    clra                ; clear a to zero and set the condition codes
                    leax      >U0141,u  ; form the address >U0141,u in x
                    ldy       #30       ; set y to the constant 30
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    leax      >L0155,pc ; form the address >L0155,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L066A     ; branch when carry reports an error or unsigned underflow; target L066A
                    sta       U0002,u   ; store a at U0002,u
L0286               leax      >L00B0,pc ; form the address >L00B0,pc in x
                    ldy       #38       ; set y to the constant 38
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      >U0189,u  ; form the address >U0189,u in x
                    ldy       #200      ; set y to the constant 200
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    ble       L030D     ; branch when the signed value is less than or equal; target L030D
L02A5               lda       ,x+       ; load a from ,x+
                    anda      #223      ; mask a using #223
                    sta       -$01,x    ; store a at -$01,x
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       L02A5     ; branch when the values differ or the result is nonzero; target L02A5
L02AF               leax      <U001A,u  ; form the address <U001A,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       U0002,u   ; load a from U0002,u
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    bcs       L02F0     ; branch when carry reports an error or unsigned underflow; target L02F0
                    leay      >U0189,u  ; form the address >U0189,u in y
                    leax      <U001A,u  ; form the address <U001A,u in x
L02C4               lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    beq       L02D2     ; branch when the values are equal or the result is zero; target L02D2
                    anda      #223      ; mask a using #223
                    cmpa      ,y+       ; compare a with ,y+ and set the condition codes
                    bne       L02AF     ; branch when the values differ or the result is nonzero; target L02AF
                    bra       L02C4     ; continue execution at L02C4
L02D2               lda       ,y+       ; load a from ,y+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       L02AF     ; branch when the values differ or the result is nonzero; target L02AF
                    lbsr      L07FD     ; call subroutine L07FD
                    std       >U0167,u  ; store d at >U0167,u
                    lda       U0002,u   ; load a from U0002,u
                    pshs      u         ; save u on the stack
                    ldu       #0        ; set u to the constant 0
                    ldx       #0        ; set x to the constant 0
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    puls      u         ; restore u from the stack
                    bra       L0314     ; continue execution at L0314
L02F0               leax      >L01BC,pc ; form the address >L01BC,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lda       U0002,u   ; load a from U0002,u
                    pshs      u         ; save u on the stack
                    ldu       #0        ; set u to the constant 0
                    ldx       #0        ; set x to the constant 0
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    lbra      L0286     ; continue execution at L0286
L030D               ldd       #-1       ; set d to the constant -1
                    std       >U0167,u  ; store d at >U0167,u
L0314               leax      >L00D8,pc ; form the address >L00D8,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L066A     ; branch when carry reports an error or unsigned underflow; target L066A
                    leax      >L0114,pc ; form the address >L0114,pc in x
                    ldy       #80       ; set y to the constant 80
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L066A     ; branch when carry reports an error or unsigned underflow; target L066A
                    ldd       #0        ; set d to the constant 0
                    std       U000A,u   ; store d at U000A,u
L0339               ldd       U000A,u   ; load d from U000A,u
                    addd      #1        ; add to d using #1
                    std       U000A,u   ; store d at U000A,u
                    cmpd      #99       ; compare d with #99 and set the condition codes
                    bge       L0351     ; branch when the signed value is greater than or equal; target L0351
                    lbsr      L0461     ; call subroutine L0461
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bls       L0351     ; branch when the unsigned value is lower or equal; target L0351
                    bra       L0339     ; continue execution at L0339
L0351               leax      >L0167,pc ; form the address >L0167,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L01A0,pc ; form the address >L01A0,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      U0005,u   ; form the address U0005,u in x
                    clra                ; clear a to zero and set the condition codes
                    ldy       #1        ; set y to the constant 1
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    leax      >L01A1,pc ; form the address >L01A1,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lda       U0005,u   ; load a from U0005,u
                    anda      #223      ; mask a using #223
                    cmpa      #65       ; compare a with #65 and set the condition codes
                    lbeq      L0663     ; branch when the values are equal or the result is zero; target L0663
                    cmpa      #68       ; compare a with #68 and set the condition codes
                    lbeq      L04B6     ; branch when the values are equal or the result is zero; target L04B6
                    cmpa      #69       ; compare a with #69 and set the condition codes
                    beq       L03A9     ; branch when the values are equal or the result is zero; target L03A9
                    cmpa      #67       ; compare a with #67 and set the condition codes
                    beq       L03A0     ; branch when the values are equal or the result is zero; target L03A0
                    cmpa      #76       ; compare a with #76 and set the condition codes
                    lbeq      L0420     ; branch when the values are equal or the result is zero; target L0420
                    bra       L0351     ; continue execution at L0351
L03A0               ldd       U000A,u   ; load d from U000A,u
                    subd      #1        ; subtract from d using #1
                    std       U000A,u   ; store d at U000A,u
                    bra       L0339     ; continue execution at L0339
L03A9               leax      >L0193,pc ; form the address >L0193,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L01A0,pc ; form the address >L01A0,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    clra                ; clear a to zero and set the condition codes
                    leax      >U00E3,u  ; form the address >U00E3,u in x
                    ldy       #3        ; set y to the constant 3
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    lbsr      L07FD     ; call subroutine L07FD
                    cmpd      U000A,u   ; compare d with U000A,u and set the condition codes
                    lbcc      L0351     ; branch when carry is clear; target L0351
                    std       <U0018,u  ; store d at <U0018,u
                    leax      >U00E3,u  ; form the address >U00E3,u in x
                    lbsr      L086D     ; call subroutine L086D
                    leax      >U00E3,u  ; form the address >U00E3,u in x
                    lda       #58       ; set a to the constant 58
                    sta       $02,x     ; store a at $02,x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    ldd       <U0018,u  ; load d from <U0018,u
                    leax      >U0251,u  ; form the address >U0251,u in x
                    lda       #80       ; set a to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      d,x       ; form the address d,x in x
                    ldy       #80       ; set y to the constant 80
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    tfr       y,d       ; copy the register values specified by y,d
                    stb       U0006,u   ; store b at U0006,u
                    dec       U0006,u   ; decrement the value at U0006,u
                    leay      >U2191,u  ; form the address >U2191,u in y
L0411               lda       ,x+       ; load a from ,x+
                    sta       ,y+       ; store a at ,y+
                    decb                ; decrement b
                    bne       L0411     ; branch when the values differ or the result is nonzero; target L0411
                    ldd       <U0018,u  ; load d from <U0018,u
                    bsr       L0461     ; call subroutine L0461
                    lbra      L0351     ; continue execution at L0351
L0420               ldd       #0        ; set d to the constant 0
                    std       U000A,u   ; store d at U000A,u
L0425               ldd       U000A,u   ; load d from U000A,u
                    addd      #1        ; add to d using #1
                    std       U000A,u   ; store d at U000A,u
                    leax      >U00E3,u  ; form the address >U00E3,u in x
                    lbsr      L086D     ; call subroutine L086D
                    leax      >U00E3,u  ; form the address >U00E3,u in x
                    lda       #58       ; set a to the constant 58
                    sta       $02,x     ; store a at $02,x
                    lda       #1        ; set a to the constant 1
                    ldy       #3        ; set y to the constant 3
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      >U0251,u  ; form the address >U0251,u in x
                    ldd       U000A,u   ; load d from U000A,u
                    lda       #80       ; set a to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      d,x       ; form the address d,x in x
                    ldy       #80       ; set y to the constant 80
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bhi       L0425     ; branch when the unsigned value is higher; target L0425
                    lbra      L0351     ; continue execution at L0351
L0461               leax      >U00E3,u  ; form the address >U00E3,u in x
                    pshs      d         ; save d on the stack
                    lbsr      L086D     ; call subroutine L086D
                    leax      >U00E3,u  ; form the address >U00E3,u in x
                    lda       #58       ; set a to the constant 58
                    sta       $02,x     ; store a at $02,x
                    lda       #1        ; set a to the constant 1
                    ldy       #3        ; set y to the constant 3
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L066A     ; branch when carry reports an error or unsigned underflow; target L066A
                    leax      >U2191,u  ; form the address >U2191,u in x
                    ldb       U0006,u   ; load b from U0006,u
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    puls      d         ; restore d from the stack
                    lda       #80       ; set a to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      >U0251,u  ; form the address >U0251,u in x
                    leax      d,x       ; form the address d,x in x
                    leay      >U2191,u  ; form the address >U2191,u in y
                    ldb       #80       ; set b to the constant 80
                    lda       U0006,u   ; load a from U0006,u
                    beq       L04AF     ; branch when the values are equal or the result is zero; target L04AF
                    sta       <U0014,u  ; store a at <U0014,u
L04A5               lda       ,y+       ; load a from ,y+
                    sta       ,x+       ; store a at ,x+
                    decb                ; decrement b
                    dec       <U0014,u  ; decrement the value at <U0014,u
                    bne       L04A5     ; branch when the values differ or the result is nonzero; target L04A5
L04AF               clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    lbsr      L066D     ; call subroutine L066D
                    rts                 ; return to the caller
L04B6               leax      <U001A,u  ; form the address <U001A,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       U0002,u   ; load a from U0002,u
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    lbcs      L066A     ; branch when carry reports an error or unsigned underflow; target L066A
L04C6               lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    bne       L04C6     ; branch when the values differ or the result is nonzero; target L04C6
                    lbsr      L07FD     ; call subroutine L07FD
                    cmpd      U0008,u   ; compare d with U0008,u and set the condition codes
                    bne       L04B6     ; branch when the values differ or the result is nonzero; target L04B6
                    leax      <U001A,u  ; form the address <U001A,u in x
                    leay      >U012D,u  ; form the address >U012D,u in y
L04DB               lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    beq       L04E5     ; branch when the values are equal or the result is zero; target L04E5
                    sta       ,y+       ; store a at ,y+
                    bra       L04DB     ; continue execution at L04DB
L04E5               lda       #13       ; set a to the constant 13
                    sta       0,y       ; store a at 0,y
                    ldd       >U00EB,u  ; load d from >U00EB,u
                    std       >U0129,u  ; store d at >U0129,u
                    ldd       >U00ED,u  ; load d from >U00ED,u
                    std       >U012B,u  ; store d at >U012B,u
                    ldd       U0008,u   ; load d from U0008,u
                    std       >U0165,u  ; store d at >U0165,u
                    leax      >U0129,u  ; form the address >U0129,u in x
                    lda       U0000,u   ; load a from U0000,u
                    ldy       #64       ; set y to the constant 64
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L066A     ; branch when carry reports an error or unsigned underflow; target L066A
                    leax      >L008C,pc ; form the address >L008C,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L066A     ; branch when carry reports an error or unsigned underflow; target L066A
                    sta       U0001,u   ; store a at U0001,u
                    pshs      u         ; save u on the stack
                    ldx       >U00EB,u  ; load x from >U00EB,u
                    lda       U0001,u   ; load a from U0001,u
                    ldu       >U00ED,u  ; load u from >U00ED,u
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    lbcs      L066A     ; branch when carry reports an error or unsigned underflow; target L066A
                    puls      u         ; restore u from the stack
                    lda       #0        ; set a to the constant 0
                    sta       <U0010,u  ; store a at <U0010,u
                    ldd       #1        ; set d to the constant 1
                    std       <U0012,u  ; store d at <U0012,u
L053F               lda       <U0010,u  ; load a from <U0010,u
                    inca                ; increment a
                    sta       <U0010,u  ; store a at <U0010,u
                    cmpa      U000B,u   ; compare a with U000B,u and set the condition codes
                    bhi       L0570     ; branch when the unsigned value is higher; target L0570
                    ldb       #80       ; set b to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      >U0251,u  ; form the address >U0251,u in x
                    leax      d,x       ; form the address d,x in x
                    ldy       #80       ; set y to the constant 80
                    lda       U0001,u   ; load a from U0001,u
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L066A     ; branch when carry reports an error or unsigned underflow; target L066A
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bls       L0570     ; branch when the unsigned value is lower or equal; target L0570
                    tfr       y,d       ; copy the register values specified by y,d
                    addd      <U0012,u  ; add to d using <U0012,u
                    std       <U0012,u  ; store d at <U0012,u
                    bra       L053F     ; continue execution at L053F
L0570               ldd       >U00ED,u  ; load d from >U00ED,u
                    addd      <U0012,u  ; add to d using <U0012,u
                    std       >U00ED,u  ; store d at >U00ED,u
                    bcc       L0588     ; branch when carry is clear; target L0588
                    ldd       >U00EB,u  ; load d from >U00EB,u
                    addd      #1        ; add to d using #1
                    std       >U00EB,u  ; store d at >U00EB,u
L0588               pshs      u         ; save u on the stack
                    lda       U0000,u   ; load a from U0000,u
                    ldx       #0        ; set x to the constant 0
                    ldu       #0        ; set u to the constant 0
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    lbcs      L066A     ; branch when carry reports an error or unsigned underflow; target L066A
                    puls      u         ; restore u from the stack
                    leax      >U00E9,u  ; form the address >U00E9,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       U0000,u   ; load a from U0000,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L066A     ; branch when carry reports an error or unsigned underflow; target L066A
                    leax      >L01A6,pc ; form the address >L01A6,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    bcc       L05C0     ; branch when carry is clear; target L05C0
                    ldb       #27       ; set b to the constant 27
                    os9       I$Create  ; invoke the OS-9 I$Create service
                    lbcs      L066A     ; branch when carry reports an error or unsigned underflow; target L066A
L05C0               sta       U0007,u   ; store a at U0007,u
L05C2               leax      >U0169,u  ; form the address >U0169,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       U0007,u   ; load a from U0007,u
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    bcs       L05DC     ; branch when carry reports an error or unsigned underflow; target L05DC
                    ldd       >U0169,u  ; load d from >U0169,u
                    cmpd      U0008,u   ; compare d with U0008,u and set the condition codes
                    bne       L05C2     ; branch when the values differ or the result is nonzero; target L05C2
                    bra       L05E5     ; continue execution at L05E5
L05DC               cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      L066A     ; branch when the values differ or the result is nonzero; target L066A
                    lbra      L0623     ; continue execution at L0623
L05E5               ldd       >U0173,u  ; load d from >U0173,u
                    addd      #1        ; add to d using #1
                    std       >U0173,u  ; store d at >U0173,u
                    lda       U0007,u   ; load a from U0007,u
                    ldb       #5        ; set b to the constant 5
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    tfr       u,d       ; copy the register values specified by u,d
                    subd      #32       ; subtract from d using #32
                    bge       L0602     ; branch when the signed value is greater than or equal; target L0602
                    leax      -$01,x    ; form the address -$01,x in x
L0602               ldu       0,s       ; load u from the current stack frame at 0,s
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       U0007,u   ; load a from U0007,u
                    tfr       y,u       ; copy the register values specified by y,u
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    lbcs      L066A     ; branch when carry reports an error or unsigned underflow; target L066A
                    puls      u         ; restore u from the stack
                    leax      >U0169,u  ; form the address >U0169,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       U0007,u   ; load a from U0007,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbra      L0663     ; continue execution at L0663
L0623               leax      >U0169,u  ; form the address >U0169,u in x
                    ldd       #1        ; set d to the constant 1
                    std       >U016B,u  ; store d at >U016B,u
                    ldd       #0        ; set d to the constant 0
                    std       >U0173,u  ; store d at >U0173,u
                    std       >U0175,u  ; store d at >U0175,u
                    std       >U0179,u  ; store d at >U0179,u
                    std       >U0177,u  ; store d at >U0177,u
                    ldd       U0008,u   ; load d from U0008,u
                    std       >U0169,u  ; store d at >U0169,u
                    leax      >U016D,u  ; form the address >U016D,u in x
                    os9       F$Time    ; invoke the OS-9 F$Time service
                    lbcs      L066A     ; branch when carry reports an error or unsigned underflow; target L066A
                    leax      >U0169,u  ; form the address >U0169,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       U0007,u   ; load a from U0007,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L066A     ; branch when carry reports an error or unsigned underflow; target L066A
L0663               clrb                ; clear b to zero and set the condition codes
                    ldy       U0008,u   ; load y from U0008,u
                    os9       F$SUser   ; invoke the OS-9 F$SUser service
L066A               os9       F$Exit    ; invoke the OS-9 F$Exit service
L066D               lbsr      L07C6     ; call subroutine L07C6
                    ldb       U0006,u   ; load b from U0006,u
                    leay      b,y       ; form the address b,y in y
                    pshs      y         ; save y on the stack
                    negb                ; negate b
                    sex                 ; sign-extend b into d
                    leay      d,y       ; form the address d,y in y
                    clr       U0006,u   ; clear U0006,u to zero and set the condition codes
                    cmpy      #0        ; compare y with #0 and set the condition codes
                    lbeq      L073C     ; branch when the values are equal or the result is zero; target L073C
                    pshs      y,x       ; save y,x on the stack
                    lda       #13       ; set a to the constant 13
L0688               sta       ,x+       ; store a at ,x+
                    leay      -$01,y    ; form the address -$01,y in y
                    bne       L0688     ; branch when the values differ or the result is nonzero; target L0688
                    puls      y,x       ; restore y,x from the stack
L0690               pshs      y,x       ; save y,x on the stack
                    leax      U0005,u   ; form the address U0005,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    bcs       L06C9     ; branch when carry reports an error or unsigned underflow; target L06C9
                    lda       U0005,u   ; load a from U0005,u
                    cmpa      #1        ; compare a with #1 and set the condition codes
                    beq       L06CD     ; branch when the values are equal or the result is zero; target L06CD
                    cmpa      #8        ; compare a with #8 and set the condition codes
                    beq       L06EF     ; branch when the values are equal or the result is zero; target L06EF
                    cmpa      #24       ; compare a with #24 and set the condition codes
                    beq       L0713     ; branch when the values are equal or the result is zero; target L0713
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      L073A     ; branch when the values are equal or the result is zero; target L073A
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    bcs       L06C9     ; branch when carry reports an error or unsigned underflow; target L06C9
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    puls      y,x       ; restore y,x from the stack
                    lda       U0005,u   ; load a from U0005,u
                    sta       ,x+       ; store a at ,x+
                    leay      -$01,y    ; form the address -$01,y in y
                    lbeq      L0763     ; branch when the values are equal or the result is zero; target L0763
                    bra       L0690     ; continue execution at L0690
L06C9               puls      y,x       ; restore y,x from the stack
                    bra       L0690     ; continue execution at L0690
L06CD               puls      y,x       ; restore y,x from the stack
                    leay      -$01,y    ; form the address -$01,y in y
                    beq       L06EA     ; branch when the values are equal or the result is zero; target L06EA
                    lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L06E8     ; branch when the values are equal or the result is zero; target L06E8
                    pshs      y,x       ; save y,x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    bra       L06CD     ; continue execution at L06CD
L06E8               leax      -$01,x    ; form the address -$01,x in x
L06EA               leay      $01,y     ; form the address $01,y in y
                    lbra      L0690     ; continue execution at L0690
L06EF               puls      y,x       ; restore y,x from the stack
                    leay      $01,y     ; form the address $01,y in y
                    cmpy      0,s       ; compare y with 0,s and set the condition codes
                    bhi       L070E     ; branch when the unsigned value is higher; target L070E
                    pshs      y,x       ; save y,x on the stack
                    leax      >L01A3,pc ; form the address >L01A3,pc in x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    puls      y,x       ; restore y,x from the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    lbra      L0690     ; continue execution at L0690
L070E               leay      -$01,y    ; form the address -$01,y in y
                    lbra      L0690     ; continue execution at L0690
L0713               puls      y,x       ; restore y,x from the stack
                    leay      $01,y     ; form the address $01,y in y
                    cmpy      0,s       ; compare y with 0,s and set the condition codes
                    bhi       L070E     ; branch when the unsigned value is higher; target L070E
                    pshs      y,x       ; save y,x on the stack
                    leax      >L01A3,pc ; form the address >L01A3,pc in x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    puls      y,x       ; restore y,x from the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    cmpy      0,s       ; compare y with 0,s and set the condition codes
                    lbhi      L0690     ; branch when the unsigned value is higher; target L0690
                    pshs      y,x       ; save y,x on the stack
                    bra       L0713     ; continue execution at L0713
L073A               puls      y,x       ; restore y,x from the stack
L073C               lda       #13       ; set a to the constant 13
                    sta       ,x+       ; store a at ,x+
                    pshs      y,x       ; save y,x on the stack
                    leax      >L01A1,pc ; form the address >L01A1,pc in x
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
                    lbsr      L07E0     ; call subroutine L07E0
                    rts                 ; return to the caller
                    fcc       "50" ; store literal character data
L0763               puls      d         ; restore d from the stack
                    pshs      y         ; save y on the stack
                    subd      0,s       ; subtract from d using 0,s
                    leas      $02,s     ; adjust the system stack pointer
                    addd      #1        ; add to d using #1
                    tfr       d,y       ; copy the register values specified by d,y
                    clrb                ; clear b to zero and set the condition codes
L0771               leay      -$01,y    ; form the address -$01,y in y
                    beq       L078F     ; branch when the values are equal or the result is zero; target L078F
                    lda       ,-x       ; load a from ,-x
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       L07A0     ; branch when the values are equal or the result is zero; target L07A0
                    pshs      y,x       ; save y,x on the stack
                    leax      >L01A3,pc ; form the address >L01A3,pc in x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    incb                ; increment b
                    puls      y,x       ; restore y,x from the stack
                    bra       L0771     ; continue execution at L0771
L078F               lda       #13       ; set a to the constant 13
                    sta       <$004F,x  ; store a at <$004F,x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    puls      y         ; restore y from the stack
                    rts                 ; return to the caller
L07A0               lda       #13       ; set a to the constant 13
                    sta       ,x+       ; store a at ,x+
                    pshs      y,x       ; save y,x on the stack
                    stb       U0006,u   ; store b at U0006,u
                    leay      >U2191,u  ; form the address >U2191,u in y
L07AC               lda       ,x+       ; load a from ,x+
                    sta       ,y+       ; store a at ,y+
                    decb                ; decrement b
                    bne       L07AC     ; branch when the values differ or the result is nonzero; target L07AC
                    leax      >L01A1,pc ; form the address >L01A1,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    puls      y,x       ; restore y,x from the stack
                    lbsr      L07E0     ; call subroutine L07E0
                    rts                 ; return to the caller
L07C6               pshs      y,x,d     ; save y,x,d on the stack
                    leax      >U21E1,u  ; form the address >U21E1,u in x
                    clra                ; clear a to zero and set the condition codes
                    ldb       #0        ; set b to the constant 0
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    leax      -$20,x    ; form the address -$20,x in x
                    clr       <$0024,x  ; clear <$0024,x to zero and set the condition codes
                    leax      <$0020,x  ; form the address <$0020,x in x
                    os9       I$SetStt  ; invoke the OS-9 I$SetStt service
                    puls      pc,y,x,d  ; restore pc,y,x,d and return to the caller
L07E0               pshs      y,x,d     ; save y,x,d on the stack
                    leax      >U21E1,u  ; form the address >U21E1,u in x
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
L07FD               pshs      y         ; save y on the stack
L07FF               lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      L08A6     ; branch when the values are equal or the result is zero; target L08A6
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L07FF     ; branch when carry reports an error or unsigned underflow; target L07FF
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L07FF     ; branch when the unsigned value is higher; target L07FF
                    leax      -$01,x    ; form the address -$01,x in x
L0811               lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L081D     ; branch when carry reports an error or unsigned underflow; target L081D
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L081D     ; branch when the unsigned value is higher; target L081D
                    bra       L0811     ; continue execution at L0811
L081D               pshs      x         ; save x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    clr       <U0014,u  ; clear <U0014,u to zero and set the condition codes
                    clr       <U0015,u  ; clear <U0015,u to zero and set the condition codes
                    ldd       #1        ; set d to the constant 1
                    std       <U0016,u  ; store d at <U0016,u
L082D               lda       ,-x       ; load a from ,-x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L0866     ; branch when carry reports an error or unsigned underflow; target L0866
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L0866     ; branch when the unsigned value is higher; target L0866
                    suba      #48       ; subtract from a using #48
                    sta       U0004,u   ; store a at U0004,u
                    ldd       #0        ; set d to the constant 0
L083E               tst       U0004,u   ; set condition codes from U0004,u without changing it
                    beq       L0849     ; branch when the values are equal or the result is zero; target L0849
                    addd      <U0016,u  ; add to d using <U0016,u
                    dec       U0004,u   ; decrement the value at U0004,u
                    bra       L083E     ; continue execution at L083E
L0849               addd      <U0014,u  ; add to d using <U0014,u
                    std       <U0014,u  ; store d at <U0014,u
                    lda       #10       ; set a to the constant 10
                    sta       U0004,u   ; store a at U0004,u
                    ldd       #0        ; set d to the constant 0
L0856               tst       U0004,u   ; set condition codes from U0004,u without changing it
                    beq       L0861     ; branch when the values are equal or the result is zero; target L0861
                    addd      <U0016,u  ; add to d using <U0016,u
                    dec       U0004,u   ; decrement the value at U0004,u
                    bra       L0856     ; continue execution at L0856
L0861               std       <U0016,u  ; store d at <U0016,u
                    bra       L082D     ; continue execution at L082D
L0866               ldd       <U0014,u  ; load d from <U0014,u
                    puls      x         ; restore x from the stack
                    puls      pc,y      ; restore pc,y and return to the caller
L086D               pshs      y         ; save y on the stack
                    std       <U0014,u  ; store d at <U0014,u
                    lda       #48       ; set a to the constant 48
                    sta       0,x       ; store a at 0,x
                    sta       $01,x     ; store a at $01,x
                    ldd       #10       ; set d to the constant 10
                    std       <U0016,u  ; store d at <U0016,u
                    ldd       <U0014,u  ; load d from <U0014,u
                    bsr       L0894     ; call subroutine L0894
                    ldd       #1        ; set d to the constant 1
                    std       <U0016,u  ; store d at <U0016,u
                    ldd       <U0014,u  ; load d from <U0014,u
                    bsr       L0894     ; call subroutine L0894
                    lda       #13       ; set a to the constant 13
                    sta       0,x       ; store a at 0,x
                    puls      pc,y      ; restore pc,y and return to the caller
L0894               subd      <U0016,u  ; subtract from d using <U0016,u
                    bcs       L089D     ; branch when carry reports an error or unsigned underflow; target L089D
                    inc       0,x       ; increment the value at 0,x
                    bra       L0894     ; continue execution at L0894
L089D               addd      <U0016,u  ; add to d using <U0016,u
                    std       <U0014,u  ; store d at <U0014,u
                    leax      $01,x     ; form the address $01,x in x
                    rts                 ; return to the caller
L08A6               ldd       #-1       ; set d to the constant -1
                    puls      pc,y      ; restore pc,y and return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
