**********************************************************************
* BBS.pack - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       BBS.pack
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
U0005               rmb       3         ; reserve 3 byte(s) in the module workspace
U0008               rmb       1         ; reserve 1 byte(s) in the module workspace
U0009               rmb       1         ; reserve 1 byte(s) in the module workspace
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
U0018               rmb       32        ; reserve 32 byte(s) in the module workspace
U0038               rmb       232       ; reserve 232 byte(s) in the module workspace
U0120               rmb       2         ; reserve 2 byte(s) in the module workspace
U0122               rmb       2         ; reserve 2 byte(s) in the module workspace
U0124               rmb       60        ; reserve 60 byte(s) in the module workspace
U0160               rmb       80        ; reserve 80 byte(s) in the module workspace
U01B0               rmb       2         ; reserve 2 byte(s) in the module workspace
U01B2               rmb       62        ; reserve 62 byte(s) in the module workspace
U01F0               rmb       1         ; reserve 1 byte(s) in the module workspace
U01F1               rmb       399       ; reserve 399 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.pack/ ; store an OS-9 high-bit-terminated string
                    fcc       "Copyright (C) 1988" ; store literal character data
                    fcc       "By Keith Alphonso" ; store literal character data
                    fcc       "Licenced to Alpha Software Technologies" ; store literal character data
                    fcc       "All rights reserved" ; store literal character data
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
L0080               fcc       "BBS.msg" ; store literal character data
                    fcb       $0D       ; store byte data
L0088               fcc       "BBS.msg.inx" ; store literal character data
                    fcb       $0D       ; store byte data
L0094               fcc       "BBs.msg.lst" ; store literal character data
                    fcb       $0D       ; store byte data
L00A0               fcb       $0A       ; store byte data
                    fcc       "One moment please..." ; store literal character data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
L00B7               fcc       "msg.scratch" ; store literal character data
                    fcb       $0D       ; store byte data
L00C3               fcc       "inx.scratch" ; store literal character data
                    fcb       $0D       ; store byte data
L00CF               fcc       "." ; store literal character data
                    fcb       $0D       ; store byte data
                    fcc       "Rename" ; store literal character data
                    fcb       $0D       ; store byte data
L00D8               fcc       "Packing message..." ; store literal character data
                    fcb       $0D       ; store byte data

start               lda       0,x       ; load a from 0,x
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L00FA     ; branch when the values are equal or the result is zero; target L00FA
                    lda       #1        ; set a to the constant 1
                    os9       I$ChgDir  ; invoke the OS-9 I$ChgDir service
                    lbcs      L02F7     ; branch when carry reports an error or unsigned underflow; target L02F7
L00FA               leax      >U01F0,u  ; form the address >U01F0,u in x
                    stx       <U0014,u  ; store x at <U0014,u
                    clr       <U0016,u  ; clear <U0016,u to zero and set the condition codes
                    clr       <U0017,u  ; clear <U0017,u to zero and set the condition codes
                    os9       F$ID      ; invoke the OS-9 F$ID service
                    sty       U000A,u   ; store y at U000A,u
                    ldy       #0        ; set y to the constant 0
                    os9       F$SUser   ; invoke the OS-9 F$SUser service
                    clr       U0009,u   ; clear U0009,u to zero and set the condition codes
                    clr       U0008,u   ; clear U0008,u to zero and set the condition codes
                    leax      >L00A0,pc ; form the address >L00A0,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L0088,pc ; form the address >L0088,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L02F7     ; branch when carry reports an error or unsigned underflow; target L02F7
                    sta       U0000,u   ; store a at U0000,u
                    leax      >L0080,pc ; form the address >L0080,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L02F7     ; branch when carry reports an error or unsigned underflow; target L02F7
                    sta       U0001,u   ; store a at U0001,u
                    leax      >L00B7,pc ; form the address >L00B7,pc in x
                    lda       #2        ; set a to the constant 2
                    ldb       #11       ; set b to the constant 11
                    os9       I$Create  ; invoke the OS-9 I$Create service
                    lbcs      L02F7     ; branch when carry reports an error or unsigned underflow; target L02F7
                    sta       U0002,u   ; store a at U0002,u
                    leax      >L00C3,pc ; form the address >L00C3,pc in x
                    lda       #2        ; set a to the constant 2
                    ldb       #11       ; set b to the constant 11
                    os9       I$Create  ; invoke the OS-9 I$Create service
                    sta       U0003,u   ; store a at U0003,u
                    clr       U000C,u   ; clear U000C,u to zero and set the condition codes
                    clr       U000D,u   ; clear U000D,u to zero and set the condition codes
                    clr       U000E,u   ; clear U000E,u to zero and set the condition codes
                    clr       U000F,u   ; clear U000F,u to zero and set the condition codes
                    leax      >U0120,u  ; form the address >U0120,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       U0000,u   ; load a from U0000,u
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lbcs      L02F7     ; branch when carry reports an error or unsigned underflow; target L02F7
                    lda       U0002,u   ; load a from U0002,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
L017F               ldd       <U0016,u  ; load d from <U0016,u
                    addd      #1        ; add to d using #1
                    std       <U0016,u  ; store d at <U0016,u
                    leax      >U01B0,u  ; form the address >U01B0,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       U0000,u   ; load a from U0000,u
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lbcs      L0222     ; branch when carry reports an error or unsigned underflow; target L0222
                    cmpy      #64       ; compare y with #64 and set the condition codes
                    lbne      L0222     ; branch when the values differ or the result is nonzero; target L0222
                    ldd       >U01B0,u  ; load d from >U01B0,u
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    beq       L01E7     ; branch when the values are equal or the result is zero; target L01E7
                    ldd       U000C,u   ; load d from U000C,u
                    std       >U01B0,u  ; store d at >U01B0,u
                    ldd       U000E,u   ; load d from U000E,u
                    std       >U01B2,u  ; store d at >U01B2,u
                    lda       U0002,u   ; load a from U0002,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
L01BC               lda       U0001,u   ; load a from U0001,u
                    leax      >U0160,u  ; form the address >U0160,u in x
                    ldy       #80       ; set y to the constant 80
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    bcs       L0222     ; branch when carry reports an error or unsigned underflow; target L0222
                    lda       U0003,u   ; load a from U0003,u
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    tfr       y,d       ; copy the register values specified by y,d
                    addd      U000E,u   ; add to d using U000E,u
                    std       U000E,u   ; store d at U000E,u
                    bcc       L01DF     ; branch when carry is clear; target L01DF
                    ldd       U000C,u   ; load d from U000C,u
                    addd      #1        ; add to d using #1
                    std       U000C,u   ; store d at U000C,u
L01DF               cmpy      #1        ; compare y with #1 and set the condition codes
                    bhi       L01BC     ; branch when the unsigned value is higher; target L01BC
                    bra       L017F     ; continue execution at L017F
L01E7               ldx       <U0014,u  ; load x from <U0014,u
                    ldd       <U0016,u  ; load d from <U0016,u
                    std       ,x++      ; store d at ,x++
                    stx       <U0014,u  ; store x at <U0014,u
                    leax      >L00D8,pc ; form the address >L00D8,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    ldd       >U0120,u  ; load d from >U0120,u
                    subd      #1        ; subtract from d using #1
                    std       >U0120,u  ; store d at >U0120,u
L020A               lda       U0001,u   ; load a from U0001,u
                    leax      >U0160,u  ; form the address >U0160,u in x
                    ldy       #80       ; set y to the constant 80
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    bcs       L0222     ; branch when carry reports an error or unsigned underflow; target L0222
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bhi       L020A     ; branch when the unsigned value is higher; target L020A
                    lbra      L017F     ; continue execution at L017F
L0222               ldd       U000C,u   ; load d from U000C,u
                    std       >U0122,u  ; store d at >U0122,u
                    ldd       U000E,u   ; load d from U000E,u
                    std       >U0124,u  ; store d at >U0124,u
                    pshs      u         ; save u on the stack
                    lda       U0002,u   ; load a from U0002,u
                    ldx       #0        ; set x to the constant 0
                    ldu       #0        ; set u to the constant 0
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    puls      u         ; restore u from the stack
                    lbcs      L02F7     ; branch when carry reports an error or unsigned underflow; target L02F7
                    leax      >U0120,u  ; form the address >U0120,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       U0002,u   ; load a from U0002,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lda       U0000,u   ; load a from U0000,u
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lbcs      L02F7     ; branch when carry reports an error or unsigned underflow; target L02F7
                    lda       U0001,u   ; load a from U0001,u
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lbcs      L02F7     ; branch when carry reports an error or unsigned underflow; target L02F7
                    lda       U0002,u   ; load a from U0002,u
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lbcs      L02F7     ; branch when carry reports an error or unsigned underflow; target L02F7
                    lda       U0003,u   ; load a from U0003,u
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lbcs      L02F7     ; branch when carry reports an error or unsigned underflow; target L02F7
                    leax      >L0088,pc ; form the address >L0088,pc in x
                    os9       I$Delete  ; invoke the OS-9 I$Delete service
                    lbcs      L02F7     ; branch when carry reports an error or unsigned underflow; target L02F7
                    leax      >L0080,pc ; form the address >L0080,pc in x
                    os9       I$Delete  ; invoke the OS-9 I$Delete service
                    lbcs      L02F7     ; branch when carry reports an error or unsigned underflow; target L02F7
                    leax      >L00B7,pc ; form the address >L00B7,pc in x
                    leay      >L0088,pc ; form the address >L0088,pc in y
                    lbsr      L0304     ; call subroutine L0304
                    leax      >L00C3,pc ; form the address >L00C3,pc in x
                    leay      >L0080,pc ; form the address >L0080,pc in y
                    lbsr      L0304     ; call subroutine L0304
                    leax      >L0094,pc ; form the address >L0094,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L02F6     ; branch when carry reports an error or unsigned underflow; target L02F6
                    sta       U0004,u   ; store a at U0004,u
L02AD               lda       U0004,u   ; load a from U0004,u
                    leax      <U0010,u  ; form the address <U0010,u in x
                    ldy       #4        ; set y to the constant 4
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lbcs      L02F6     ; branch when carry reports an error or unsigned underflow; target L02F6
                    leax      >U01F0,u  ; form the address >U01F0,u in x
                    clr       U0009,u   ; clear U0009,u to zero and set the condition codes
L02C3               ldd       ,x++      ; load d from ,x++
                    cmpd      <U0012,u  ; compare d with <U0012,u and set the condition codes
                    bhi       L02CD     ; branch when the unsigned value is higher; target L02CD
                    inc       U0009,u   ; increment the value at U0009,u
L02CD               cmpx      <U0014,u  ; compare x with <U0014,u and set the condition codes
                    bcs       L02C3     ; branch when carry reports an error or unsigned underflow; target L02C3
                    ldd       <U0012,u  ; load d from <U0012,u
                    subd      U0008,u   ; subtract from d using U0008,u
                    std       <U0012,u  ; store d at <U0012,u
                    lda       U0004,u   ; load a from U0004,u
                    ldb       #5        ; set b to the constant 5
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    leau      -$02,u    ; form the workspace or data address -$02,u in u
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    puls      u         ; restore u from the stack
                    leax      <U0012,u  ; form the address <U0012,u in x
                    ldy       #2        ; set y to the constant 2
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    bra       L02AD     ; continue execution at L02AD
L02F6               clrb                ; clear b to zero and set the condition codes
L02F7               pshs      b         ; save b on the stack
                    ldy       U000A,u   ; load y from U000A,u
                    os9       F$SUser   ; invoke the OS-9 F$SUser service
                    puls      b         ; restore b from the stack
                    os9       F$Exit    ; invoke the OS-9 F$Exit service
L0304               leax      >L00CF,pc ; form the address >L00CF,pc in x
                    lda       #131      ; set a to the constant 131
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L02F7     ; branch when carry reports an error or unsigned underflow; target L02F7
                    sta       U0005,u   ; store a at U0005,u
                    clr       <U0038,u  ; clear <U0038,u to zero and set the condition codes
L0316               pshs      u         ; save u on the stack
                    lda       <U0038,u  ; load a from <U0038,u
                    inca                ; increment a
                    sta       <U0038,u  ; store a at <U0038,u
                    ldb       #32       ; set b to the constant 32
                    mul                 ; multiply a by b and return the product in d
                    tfr       d,x       ; copy the register values specified by d,x
                    lda       U0005,u   ; load a from U0005,u
                    ldu       #0        ; set u to the constant 0
                    exg       x,u       ; exchange the register values specified by x,u
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    puls      u         ; restore u from the stack
                    leax      <U0018,u  ; form the address <U0018,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       U0005,u   ; load a from U0005,u
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    bcs       L0362     ; branch when carry reports an error or unsigned underflow; target L0362
                    leay      >L00B7,pc ; form the address >L00B7,pc in y
                    leax      <U0018,u  ; form the address <U0018,u in x
L0345               lda       ,x+       ; load a from ,x+
                    bmi       L036E     ; branch when the result is negative; target L036E
                    cmpa      ,y+       ; compare a with ,y+ and set the condition codes
                    bne       L034F     ; branch when the values differ or the result is nonzero; target L034F
                    bra       L0345     ; continue execution at L0345
L034F               leax      <U0018,u  ; form the address <U0018,u in x
                    leay      >L00C3,pc ; form the address >L00C3,pc in y
L0356               lda       ,x+       ; load a from ,x+
                    bmi       L0383     ; branch when the result is negative; target L0383
                    cmpa      ,y+       ; compare a with ,y+ and set the condition codes
                    bne       L0360     ; branch when the values differ or the result is nonzero; target L0360
                    bra       L0356     ; continue execution at L0356
L0360               bra       L0316     ; continue execution at L0316
L0362               cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      L02F7     ; branch when the values differ or the result is nonzero; target L02F7
                    lda       U0005,u   ; load a from U0005,u
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    rts                 ; return to the caller
L036E               anda      #127      ; mask a using #127
                    cmpa      ,y+       ; compare a with ,y+ and set the condition codes
                    bne       L034F     ; branch when the values differ or the result is nonzero; target L034F
                    lda       ,y+       ; load a from ,y+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       L034F     ; branch when the values differ or the result is nonzero; target L034F
                    leax      <U0018,u  ; form the address <U0018,u in x
                    leay      >L0088,pc ; form the address >L0088,pc in y
                    bra       L0396     ; continue execution at L0396
L0383               anda      #127      ; mask a using #127
                    cmpa      ,y+       ; compare a with ,y+ and set the condition codes
                    bne       L0360     ; branch when the values differ or the result is nonzero; target L0360
                    lda       #13       ; set a to the constant 13
                    cmpa      ,y+       ; compare a with ,y+ and set the condition codes
                    bne       L0360     ; branch when the values differ or the result is nonzero; target L0360
                    leax      <U0018,u  ; form the address <U0018,u in x
                    leay      >L0080,pc ; form the address >L0080,pc in y
L0396               lda       ,y+       ; load a from ,y+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L03A0     ; branch when the values are equal or the result is zero; target L03A0
                    sta       ,x+       ; store a at ,x+
                    bra       L0396     ; continue execution at L0396
L03A0               lda       ,-x       ; load a from ,-x
                    ora       #128      ; set selected bits in a using #128
                    sta       0,x       ; store a at 0,x
                    lda       <U0038,u  ; load a from <U0038,u
                    ldb       #32       ; set b to the constant 32
                    mul                 ; multiply a by b and return the product in d
                    tfr       d,x       ; copy the register values specified by d,x
                    lda       U0005,u   ; load a from U0005,u
                    ldb       #5        ; set b to the constant 5
                    pshs      u         ; save u on the stack
                    ldu       #0        ; set u to the constant 0
                    exg       x,u       ; exchange the register values specified by x,u
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    lbcs      L02F7     ; branch when carry reports an error or unsigned underflow; target L02F7
                    puls      u         ; restore u from the stack
                    leax      <U0018,u  ; form the address <U0018,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       U0005,u   ; load a from U0005,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    ldb       #211      ; set b to the constant 211
                    lbra      L0362     ; continue execution at L0362
                    fcb       $16       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $40       ; store byte data

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
