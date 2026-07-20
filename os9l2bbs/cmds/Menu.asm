**********************************************************************
* Menu - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       menu
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
U0005               rmb       2         ; reserve 2 byte(s) in the module workspace
U0007               rmb       2         ; reserve 2 byte(s) in the module workspace
U0009               rmb       2         ; reserve 2 byte(s) in the module workspace
U000B               rmb       1         ; reserve 1 byte(s) in the module workspace
U000C               rmb       1         ; reserve 1 byte(s) in the module workspace
U000D               rmb       2         ; reserve 2 byte(s) in the module workspace
U000F               rmb       2         ; reserve 2 byte(s) in the module workspace
U0011               rmb       2         ; reserve 2 byte(s) in the module workspace
U0013               rmb       2         ; reserve 2 byte(s) in the module workspace
U0015               rmb       4         ; reserve 4 byte(s) in the module workspace
U0019               rmb       4         ; reserve 4 byte(s) in the module workspace
U001D               rmb       1         ; reserve 1 byte(s) in the module workspace
U001E               rmb       1         ; reserve 1 byte(s) in the module workspace
U001F               rmb       1         ; reserve 1 byte(s) in the module workspace
U0020               rmb       1         ; reserve 1 byte(s) in the module workspace
U0021               rmb       16        ; reserve 16 byte(s) in the module workspace
U0031               rmb       8         ; reserve 8 byte(s) in the module workspace
U0039               rmb       3         ; reserve 3 byte(s) in the module workspace
U003C               rmb       3         ; reserve 3 byte(s) in the module workspace
U003F               rmb       3         ; reserve 3 byte(s) in the module workspace
U0042               rmb       3         ; reserve 3 byte(s) in the module workspace
U0045               rmb       9         ; reserve 9 byte(s) in the module workspace
U004E               rmb       23        ; reserve 23 byte(s) in the module workspace
U0065               rmb       32        ; reserve 32 byte(s) in the module workspace
U0085               rmb       206       ; reserve 206 byte(s) in the module workspace
U0153               rmb       40        ; reserve 40 byte(s) in the module workspace
U017B               rmb       120       ; reserve 120 byte(s) in the module workspace
U01F3               rmb       3200      ; reserve 3200 byte(s) in the module workspace
U0E73               rmb       2         ; reserve 2 byte(s) in the module workspace
U0E75               rmb       80        ; reserve 80 byte(s) in the module workspace
U0EC5               rmb       1         ; reserve 1 byte(s) in the module workspace
U0EC6               rmb       4449      ; reserve 4449 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /menu/ ; store an OS-9 high-bit-terminated string
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
L007C               fcc       "shell" ; store literal character data
                    fcb       $0D       ; store byte data
L0082               fcc       "Usage is:" ; store literal character data
                    fcb       $0A       ; store byte data
                    fcc       "MENU <menuname> <cmdname>" ; store literal character data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
L00A7               fcb       $0A       ; store byte data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
L00AA               fcc       "Sorry, you do not have access to that option" ; store literal character data
                    fcb       $0D       ; store byte data
L00D7               fcc       "a user priority level has been specified incorrectly!" ; store literal character data
                    fcb       $0D       ; store byte data
L010D               fcc       "/dd/bbs/BBS.userstats" ; store literal character data
                    fcb       $0D       ; store byte data
L0123               fcc       "I'm sorry, but your time has expired!" ; store literal character data
                    fcb       $0D       ; store byte data
L0149               fcc       "WARNING!!  You have only a few minutes left online!" ; store literal character data
                    fcb       $0D       ; store byte data
L017D               fcb       $1F       ; store byte data
                    fcb       $1C       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $1E       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $1E       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $1E       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $1E       ; store byte data
                    fcb       $1F       ; store byte data
start               pshs      u,y,x,d   ; save u,y,x,d on the stack
                    os9       F$ID      ; invoke the OS-9 F$ID service
                    sty       <U0013,u  ; store y at <U0013,u
                    puls      u,y,x,d   ; restore u,y,x,d from the stack
                    ldd       #2573     ; set d to the constant 2573
                    std       >U0E73,u  ; store d at >U0E73,u
                    sty       U000B,u   ; store y at U000B,u
                    leay      <U0045,u  ; form the address <U0045,u in y
L01A1               lda       ,x+       ; load a from ,x+
                    cmpx      U000B,u   ; compare x with U000B,u and set the condition codes
                    lbhi      L0586     ; branch when the unsigned value is higher; target L0586
                    sta       ,y+       ; store a at ,y+
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    bne       L01A1     ; branch when the values differ or the result is nonzero; target L01A1
                    lda       #13       ; set a to the constant 13
                    sta       -$01,y    ; store a at -$01,y
                    leay      <U0065,u  ; form the address <U0065,u in y
L01B6               lda       ,x+       ; load a from ,x+
                    cmpx      U000B,u   ; compare x with U000B,u and set the condition codes
                    lbhi      L0586     ; branch when the unsigned value is higher; target L0586
                    sta       ,y+       ; store a at ,y+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       L01B6     ; branch when the values differ or the result is nonzero; target L01B6
                    leax      >L010D,pc ; form the address >L010D,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L027C     ; branch when carry reports an error or unsigned underflow; target L027C
                    sta       U0000,u   ; store a at U0000,u
L01D3               leax      <U0019,u  ; form the address <U0019,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       U0000,u   ; load a from U0000,u
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    bcs       L01EC     ; branch when carry reports an error or unsigned underflow; target L01EC
                    ldd       <U0013,u  ; load d from <U0013,u
                    cmpd      <U0019,u  ; compare d with <U0019,u and set the condition codes
                    bne       L01D3     ; branch when the values differ or the result is nonzero; target L01D3
                    bra       L01F4     ; continue execution at L01F4
L01EC               lda       U0000,u   ; load a from U0000,u
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lbra      L027C     ; continue execution at L027C
L01F4               ldd       <U0031,u  ; load d from <U0031,u
                    cmpd      #0        ; compare d with #0 and set the condition codes
                    lbeq      L0277     ; branch when the values are equal or the result is zero; target L0277
                    ldb       <U0021,u  ; load b from <U0021,u
                    clra                ; clear a to zero and set the condition codes
                    addd      <U0031,u  ; add to d using <U0031,u
                    cmpd      #60       ; compare d with #60 and set the condition codes
                    bcs       L0263     ; branch when carry reports an error or unsigned underflow; target L0263
L020C               subd      #60       ; subtract from d using #60
                    pshs      d         ; save d on the stack
                    lda       <U0020,u  ; load a from <U0020,u
                    inca                ; increment a
                    cmpa      #24       ; compare a with #24 and set the condition codes
                    bcs       L0258     ; branch when carry reports an error or unsigned underflow; target L0258
                    clr       <U0020,u  ; clear <U0020,u to zero and set the condition codes
                    lda       <U001F,u  ; load a from <U001F,u
                    inca                ; increment a
                    leax      >L017D,pc ; form the address >L017D,pc in x
                    ldb       <U001E,u  ; load b from <U001E,u
                    decb                ; decrement b
                    leax      b,x       ; form the address b,x in x
                    cmpa      0,x       ; compare a with 0,x and set the condition codes
                    bcs       L0253     ; branch when carry reports an error or unsigned underflow; target L0253
                    lda       #1        ; set a to the constant 1
                    sta       <U001F,u  ; store a at <U001F,u
                    lda       <U001E,u  ; load a from <U001E,u
                    inca                ; increment a
                    cmpa      #12       ; compare a with #12 and set the condition codes
                    blt       L024E     ; branch when the signed value is less; target L024E
                    lda       #1        ; set a to the constant 1
                    sta       <U001E,u  ; store a at <U001E,u
                    lda       <U001D,u  ; load a from <U001D,u
                    inca                ; increment a
                    cmpa      #100      ; compare a with #100 and set the condition codes
                    bcs       L0249     ; branch when carry reports an error or unsigned underflow; target L0249
                    clra                ; clear a to zero and set the condition codes
L0249               sta       <U001D,u  ; store a at <U001D,u
                    bra       L025B     ; continue execution at L025B
L024E               sta       <U001E,u  ; store a at <U001E,u
                    bra       L025B     ; continue execution at L025B
L0253               sta       <U001F,u  ; store a at <U001F,u
                    bra       L025B     ; continue execution at L025B
L0258               sta       <U0020,u  ; store a at <U0020,u
L025B               puls      d         ; restore d from the stack
                    cmpd      #60       ; compare d with #60 and set the condition codes
                    bcc       L020C     ; branch when carry is clear; target L020C
L0263               stb       <U0021,u  ; store b at <U0021,u
                    lda       #6        ; set a to the constant 6
                    leax      <U001D,u  ; form the address <U001D,u in x
                    leay      <U003F,u  ; form the address <U003F,u in y
L026E               ldb       ,x+       ; load b from ,x+
                    stb       ,y+       ; store b at ,y+
                    deca                ; decrement a
                    bne       L026E     ; branch when the values differ or the result is nonzero; target L026E
                    bra       L027C     ; continue execution at L027C
L0277               lda       #101      ; set a to the constant 101
                    sta       <U003F,u  ; store a at <U003F,u
L027C               leax      >U0153,u  ; form the address >U0153,u in x
                    stx       U0005,u   ; store x at U0005,u
                    leax      >U01F3,u  ; form the address >U01F3,u in x
                    stx       U0007,u   ; store x at U0007,u
                    leax      >U017B,u  ; form the address >U017B,u in x
                    stx       U0009,u   ; store x at U0009,u
                    leax      <U0065,u  ; form the address <U0065,u in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L0594     ; branch when carry reports an error or unsigned underflow; target L0594
                    sta       U0002,u   ; store a at U0002,u
L029C               ldx       U0005,u   ; load x from U0005,u
                    ldy       #1        ; set y to the constant 1
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    ldb       0,x       ; load b from 0,x
                    cmpb      #47       ; compare b with #47 and set the condition codes
                    beq       L02F4     ; branch when the values are equal or the result is zero; target L02F4
                    cmpb      #62       ; compare b with #62 and set the condition codes
                    lbeq      L03AB     ; branch when the values are equal or the result is zero; target L03AB
                    cmpb      #60       ; compare b with #60 and set the condition codes
                    lbeq      L03AB     ; branch when the values are equal or the result is zero; target L03AB
                    cmpb      #61       ; compare b with #61 and set the condition codes
                    lbeq      L03AB     ; branch when the values are equal or the result is zero; target L03AB
                    ldy       U0009,u   ; load y from U0009,u
                    pshs      d         ; save d on the stack
                    lda       #45       ; set a to the constant 45
                    sta       ,y+       ; store a at ,y+
                    ldd       #-1       ; set d to the constant -1
                    std       ,y++      ; store d at ,y++
                    puls      d         ; restore d from the stack
                    sty       U0009,u   ; store y at U0009,u
L02D0               cmpb      #97       ; compare b with #97 and set the condition codes
                    bcs       L02D8     ; branch when carry reports an error or unsigned underflow; target L02D8
                    andb      #223      ; mask b using #223
                    stb       0,x       ; store b at 0,x
L02D8               leax      $01,x     ; form the address $01,x in x
                    stx       U0005,u   ; store x at U0005,u
                    ldx       U0007,u   ; load x from U0007,u
                    ldy       #80       ; set y to the constant 80
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    lbcs      L0594     ; branch when carry reports an error or unsigned underflow; target L0594
                    sty       <$004E,x  ; store y at <$004E,x
                    leax      <$0050,x  ; form the address <$0050,x in x
                    stx       U0007,u   ; store x at U0007,u
                    bra       L029C     ; continue execution at L029C
L02F4               leax      >U0E75,u  ; form the address >U0E75,u in x
                    ldy       #80       ; set y to the constant 80
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    lbcs      L0594     ; branch when carry reports an error or unsigned underflow; target L0594
                    sty       <U0011,u  ; store y at <U0011,u
                    ldx       U0005,u   ; load x from U0005,u
                    lda       #255      ; set a to the constant 255
                    sta       0,x       ; store a at 0,x
                    lda       U0002,u   ; load a from U0002,u
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lbcs      L0594     ; branch when carry reports an error or unsigned underflow; target L0594
                    leax      <U0045,u  ; form the address <U0045,u in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L0594     ; branch when carry reports an error or unsigned underflow; target L0594
                    sta       U0001,u   ; store a at U0001,u
                    leax      >U0EC5,u  ; form the address >U0EC5,u in x
                    ldy       #4000     ; set y to the constant 4000
                    lda       U0001,u   ; load a from U0001,u
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    sty       <U0015,u  ; store y at <U0015,u
                    lbcs      L0594     ; branch when carry reports an error or unsigned underflow; target L0594
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    stx       U000B,u   ; store x at U000B,u
                    tfr       y,d       ; copy the register values specified by y,d
                    leax      d,x       ; form the address d,x in x
                    stx       U000F,u   ; store x at U000F,u
                    ldx       U000B,u   ; load x from U000B,u
                    ldy       #1        ; set y to the constant 1
L034A               pshs      x         ; save x on the stack
                    lda       #1        ; set a to the constant 1
                    ldb       #1        ; set b to the constant 1
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    lbcc      L0440     ; branch when carry is clear; target L0440
                    ldy       <U0015,u  ; load y from <U0015,u
                    ldx       0,s       ; load x from the current stack frame at 0,s
L035D               lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L0374     ; branch when the values are equal or the result is zero; target L0374
                    leay      -$01,y    ; form the address -$01,y in y
                    bne       L035D     ; branch when the values differ or the result is nonzero; target L035D
                    puls      x         ; restore x from the stack
                    lda       #1        ; set a to the constant 1
                    ldy       <U0015,u  ; load y from <U0015,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    bra       L037F     ; continue execution at L037F
L0374               puls      x         ; restore x from the stack
                    lda       #1        ; set a to the constant 1
                    ldy       <U0015,u  ; load y from <U0015,u
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
L037F               lbcs      L0594     ; branch when carry reports an error or unsigned underflow; target L0594
                    pshs      y         ; save y on the stack
                    ldd       <U0015,u  ; load d from <U0015,u
                    subd      0,s       ; subtract from d using 0,s
                    std       <U0015,u  ; store d at <U0015,u
                    cmpd      #0        ; compare d with #0 and set the condition codes
                    ble       L03A8     ; branch when the signed value is less than or equal; target L03A8
                    puls      d         ; restore d from the stack
                    leax      d,x       ; form the address d,x in x
                    lda       #1        ; set a to the constant 1
                    ldb       #1        ; set b to the constant 1
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    lbcc      L0440     ; branch when carry is clear; target L0440
                    cmpx      U000F,u   ; compare x with U000F,u and set the condition codes
                    bhi       L03A8     ; branch when the unsigned value is higher; target L03A8
                    bra       L034A     ; continue execution at L034A
L03A8               lbra      L03F9     ; continue execution at L03F9
L03AB               pshs      x,a       ; save x,a on the stack
                    ldy       U0009,u   ; load y from U0009,u
                    stb       ,y+       ; store b at ,y+
                    leax      >U0085,u  ; form the address >U0085,u in x
                    pshs      y         ; save y on the stack
                    ldy       #6        ; set y to the constant 6
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    leax      >U0085,u  ; form the address >U0085,u in x
                    lbsr      L0597     ; call subroutine L0597
                    puls      y         ; restore y from the stack
                    std       ,y++      ; store d at ,y++
                    sty       U0009,u   ; store y at U0009,u
                    puls      x,a       ; restore x,a from the stack
                    ldy       #1        ; set y to the constant 1
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    ldb       0,x       ; load b from 0,x
                    lbra      L02D0     ; continue execution at L02D0
L03DB               leax      >L0123,pc ; form the address >L0123,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbra      L0582     ; continue execution at L0582
L03EB               leax      >L0149,pc ; form the address >L0149,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    rts                 ; return to the caller
L03F9               leax      <U0039,u  ; form the address <U0039,u in x
                    os9       F$Time    ; invoke the OS-9 F$Time service
                    ldb       #6        ; set b to the constant 6
                    leax      <U0039,u  ; form the address <U0039,u in x
                    leay      <U003F,u  ; form the address <U003F,u in y
L0407               lda       ,x+       ; load a from ,x+
                    cmpa      ,y+       ; compare a with ,y+ and set the condition codes
                    lbhi      L03DB     ; branch when the unsigned value is higher; target L03DB
                    bcs       L0414     ; branch when carry reports an error or unsigned underflow; target L0414
                    decb                ; decrement b
                    bne       L0407     ; branch when the values differ or the result is nonzero; target L0407
L0414               cmpb      #3        ; compare b with #3 and set the condition codes
                    bgt       L0431     ; branch when the signed value is greater; target L0431
                    ldd       <U003C,u  ; load d from <U003C,u
                    addb      #5        ; add to b using #5
                    cmpb      #60       ; compare b with #60 and set the condition codes
                    bcs       L0429     ; branch when carry reports an error or unsigned underflow; target L0429
                    subb      #60       ; subtract from b using #60
                    inca                ; increment a
                    cmpa      #24       ; compare a with #24 and set the condition codes
                    bcs       L0429     ; branch when carry reports an error or unsigned underflow; target L0429
                    clra                ; clear a to zero and set the condition codes
L0429               cmpd      <U0042,u  ; compare d with <U0042,u and set the condition codes
                    bls       L0431     ; branch when the unsigned value is lower or equal; target L0431
                    bsr       L03EB     ; call subroutine L03EB
L0431               leax      >U0E75,u  ; form the address >U0E75,u in x
                    ldy       <U0011,u  ; load y from <U0011,u
                    leay      -$01,y    ; form the address -$01,y in y
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
L0440               leax      U0003,u   ; form the address U0003,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    ldy       #2        ; set y to the constant 2
                    lda       #1        ; set a to the constant 1
                    pshs      x         ; save x on the stack
                    leax      >L00A7,pc ; form the address >L00A7,pc in x
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    puls      x         ; restore x from the stack
                    lda       0,x       ; load a from 0,x
                    cmpa      #63       ; compare a with #63 and set the condition codes
                    lbeq      L027C     ; branch when the values are equal or the result is zero; target L027C
                    cmpa      #97       ; compare a with #97 and set the condition codes
                    bcs       L046B     ; branch when carry reports an error or unsigned underflow; target L046B
                    anda      #223      ; mask a using #223
                    sta       0,x       ; store a at 0,x
L046B               lda       0,x       ; load a from 0,x
                    leax      >U0153,u  ; form the address >U0153,u in x
                    clrb                ; clear b to zero and set the condition codes
L0472               tst       0,x       ; set condition codes from 0,x without changing it
                    bmi       L03F9     ; branch when the result is negative; target L03F9
                    cmpa      ,x+       ; compare a with ,x+ and set the condition codes
                    beq       L0482     ; branch when the values are equal or the result is zero; target L0482
                    incb                ; increment b
                    cmpb      #40       ; compare b with #40 and set the condition codes
                    bls       L0472     ; branch when the unsigned value is lower or equal; target L0472
                    lbra      L03F9     ; continue execution at L03F9
L0482               pshs      b         ; save b on the stack
                    lda       #3        ; set a to the constant 3
                    mul                 ; multiply a by b and return the product in d
                    leax      >U017B,u  ; form the address >U017B,u in x
                    leax      d,x       ; form the address d,x in x
                    lda       ,x+       ; load a from ,x+
                    cmpa      #60       ; compare a with #60 and set the condition codes
                    beq       L04DF     ; branch when the values are equal or the result is zero; target L04DF
                    cmpa      #62       ; compare a with #62 and set the condition codes
                    beq       L04EF     ; branch when the values are equal or the result is zero; target L04EF
                    cmpa      #61       ; compare a with #61 and set the condition codes
                    beq       L04FF     ; branch when the values are equal or the result is zero; target L04FF
L049B               puls      b         ; restore b from the stack
                    lda       #80       ; set a to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    pshs      u         ; save u on the stack
                    leau      >U01F3,u  ; form the workspace or data address >U01F3,u in u
                    leau      d,u       ; form the workspace or data address d,u in u
                    lda       U0001,u   ; load a from U0001,u
                    anda      #223      ; mask a using #223
                    cmpa      #67       ; compare a with #67 and set the condition codes
                    bne       L04CC     ; branch when the values differ or the result is nonzero; target L04CC
                    lda       U0002,u   ; load a from U0002,u
                    anda      #223      ; mask a using #223
                    cmpa      #72       ; compare a with #72 and set the condition codes
                    bne       L04CC     ; branch when the values differ or the result is nonzero; target L04CC
                    lda       U0003,u   ; load a from U0003,u
                    anda      #223      ; mask a using #223
                    cmpa      #77       ; compare a with #77 and set the condition codes
                    lbeq      L0557     ; branch when the values are equal or the result is zero; target L0557
                    cmpa      #88       ; compare a with #88 and set the condition codes
                    lbeq      L0549     ; branch when the values are equal or the result is zero; target L0549
                    cmpa      #68       ; compare a with #68 and set the condition codes
                    beq       L053B     ; branch when the values are equal or the result is zero; target L053B
L04CC               lda       U0001,u   ; load a from U0001,u
                    anda      #223      ; mask a using #223
                    cmpa      #69       ; compare a with #69 and set the condition codes
                    bne       L051F     ; branch when the values differ or the result is nonzero; target L051F
                    lda       U0002,u   ; load a from U0002,u
                    anda      #223      ; mask a using #223
                    cmpa      #88       ; compare a with #88 and set the condition codes
                    bne       L051F     ; branch when the values differ or the result is nonzero; target L051F
                    lbra      L0582     ; continue execution at L0582
L04DF               ldd       <U0013,u  ; load d from <U0013,u
                    lbeq      L049B     ; branch when the values are equal or the result is zero; target L049B
                    cmpd      0,x       ; compare d with 0,x and set the condition codes
                    lbcs      L049B     ; branch when carry reports an error or unsigned underflow; target L049B
                    bra       L050D     ; continue execution at L050D
L04EF               ldd       <U0013,u  ; load d from <U0013,u
                    lbeq      L049B     ; branch when the values are equal or the result is zero; target L049B
                    cmpd      0,x       ; compare d with 0,x and set the condition codes
                    lbhi      L049B     ; branch when the unsigned value is higher; target L049B
                    bra       L050D     ; continue execution at L050D
L04FF               ldd       <U0013,u  ; load d from <U0013,u
                    lbeq      L049B     ; branch when the values are equal or the result is zero; target L049B
                    cmpd      0,x       ; compare d with 0,x and set the condition codes
                    lbeq      L049B     ; branch when the values are equal or the result is zero; target L049B
L050D               leax      >L00AA,pc ; form the address >L00AA,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    puls      b         ; restore b from the stack
                    lbra      L03F9     ; continue execution at L03F9
L051F               ldy       <U004E,u  ; load y from <U004E,u
                    leax      >L007C,pc ; form the address >L007C,pc in x
                    ldb       #3        ; set b to the constant 3
                    lda       #17       ; set a to the constant 17
                    os9       F$Fork    ; invoke the OS-9 F$Fork service
                    puls      u         ; restore u from the stack
                    bcc       L0535     ; branch when carry is clear; target L0535
                    os9       F$PErr    ; invoke the OS-9 F$PErr service
L0535               os9       F$Wait    ; invoke the OS-9 F$Wait service
                    lbra      L03F9     ; continue execution at L03F9
L053B               tfr       u,x       ; copy the register values specified by u,x
                    puls      u         ; restore u from the stack
                    leax      $04,x     ; form the address $04,x in x
                    lda       #1        ; set a to the constant 1
                    os9       I$ChgDir  ; invoke the OS-9 I$ChgDir service
                    lbra      L027C     ; continue execution at L027C
L0549               tfr       u,x       ; copy the register values specified by u,x
                    puls      u         ; restore u from the stack
                    leax      $04,x     ; form the address $04,x in x
                    lda       #4        ; set a to the constant 4
                    os9       I$ChgDir  ; invoke the OS-9 I$ChgDir service
                    lbra      L027C     ; continue execution at L027C
L0557               tfr       u,x       ; copy the register values specified by u,x
                    puls      u         ; restore u from the stack
                    leay      <U0045,u  ; form the address <U0045,u in y
                    leax      $04,x     ; form the address $04,x in x
L0560               lda       ,x+       ; load a from ,x+
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       L0560     ; branch when the values are equal or the result is zero; target L0560
                    leax      -$01,x    ; form the address -$01,x in x
L0568               lda       ,x+       ; load a from ,x+
                    sta       ,y+       ; store a at ,y+
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    bne       L0568     ; branch when the values differ or the result is nonzero; target L0568
                    lda       #13       ; set a to the constant 13
                    sta       -$01,y    ; store a at -$01,y
                    leay      <U0065,u  ; form the address <U0065,u in y
L0577               lda       ,x+       ; load a from ,x+
                    sta       ,y+       ; store a at ,y+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       L0577     ; branch when the values differ or the result is nonzero; target L0577
                    lbra      L027C     ; continue execution at L027C
L0582               clrb                ; clear b to zero and set the condition codes
                    os9       F$Exit    ; invoke the OS-9 F$Exit service
L0586               leax      >L0082,pc ; form the address >L0082,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    clrb                ; clear b to zero and set the condition codes
L0594               os9       F$Exit    ; invoke the OS-9 F$Exit service
L0597               pshs      y         ; save y on the stack
L0599               lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      L064E     ; branch when the values are equal or the result is zero; target L064E
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L0599     ; branch when carry reports an error or unsigned underflow; target L0599
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L0599     ; branch when the unsigned value is higher; target L0599
                    leax      -$01,x    ; form the address -$01,x in x
L05AB               lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L05B7     ; branch when carry reports an error or unsigned underflow; target L05B7
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L05B7     ; branch when the unsigned value is higher; target L05B7
                    bra       L05AB     ; continue execution at L05AB
L05B7               pshs      x         ; save x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    clr       U000B,u   ; clear U000B,u to zero and set the condition codes
                    clr       U000C,u   ; clear U000C,u to zero and set the condition codes
                    ldd       #1        ; set d to the constant 1
                    std       U000D,u   ; store d at U000D,u
L05C4               lda       ,-x       ; load a from ,-x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L05F8     ; branch when carry reports an error or unsigned underflow; target L05F8
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L05F8     ; branch when the unsigned value is higher; target L05F8
                    suba      #48       ; subtract from a using #48
                    sta       U0004,u   ; store a at U0004,u
                    ldd       #0        ; set d to the constant 0
L05D5               tst       U0004,u   ; set condition codes from U0004,u without changing it
                    beq       L05DF     ; branch when the values are equal or the result is zero; target L05DF
                    addd      U000D,u   ; add to d using U000D,u
                    dec       U0004,u   ; decrement the value at U0004,u
                    bra       L05D5     ; continue execution at L05D5
L05DF               addd      U000B,u   ; add to d using U000B,u
                    std       U000B,u   ; store d at U000B,u
                    lda       #10       ; set a to the constant 10
                    sta       U0004,u   ; store a at U0004,u
                    ldd       #0        ; set d to the constant 0
L05EA               tst       U0004,u   ; set condition codes from U0004,u without changing it
                    beq       L05F4     ; branch when the values are equal or the result is zero; target L05F4
                    addd      U000D,u   ; add to d using U000D,u
                    dec       U0004,u   ; decrement the value at U0004,u
                    bra       L05EA     ; continue execution at L05EA
L05F4               std       U000D,u   ; store d at U000D,u
                    bra       L05C4     ; continue execution at L05C4
L05F8               ldd       U000B,u   ; load d from U000B,u
                    puls      x         ; restore x from the stack
                    puls      pc,y      ; restore pc,y and return to the caller
                    fcb       $ED       ; store byte data
                    fcb       $4B       ; store byte data
                    fcb       $86       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $A7       ; store byte data
                    fcb       $84       ; store byte data
                    fcb       $A7       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $A7       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $A7       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $A7       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $4D       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $4B       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $29       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $E8       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $4D       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $4B       ; store byte data
                    fcb       $8D       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $4D       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $4B       ; store byte data
                    fcb       $8D       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $0A       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $4D       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $4B       ; store byte data
                    fcb       $8D       ; store byte data
                    fcb       $0E       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $4D       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $4B       ; store byte data
                    fcb       $8D       ; store byte data
                    fcb       $05       ; store byte data
                    fcb       $86       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $A7       ; store byte data
                    fcb       $84       ; store byte data
                    fcb       $39       ; store byte data
                    fcb       $A3       ; store byte data
                    fcb       $4D       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $6C       ; store byte data
                    fcb       $84       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $F8       ; store byte data
                    fcb       $E3       ; store byte data
                    fcb       $4D       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $4B       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $39       ; store byte data
L064E               leax      >L00D7,pc ; form the address >L00D7,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lda       #1        ; set a to the constant 1
                    lbra      L0594     ; continue execution at L0594

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
