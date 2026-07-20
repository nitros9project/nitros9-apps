**********************************************************************
* DLD.add - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       DLD.add
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
U0005               rmb       80        ; reserve 80 byte(s) in the module workspace
U0055               rmb       32        ; reserve 32 byte(s) in the module workspace
U0075               rmb       27        ; reserve 27 byte(s) in the module workspace
U0090               rmb       2         ; reserve 2 byte(s) in the module workspace
U0092               rmb       2         ; reserve 2 byte(s) in the module workspace
U0094               rmb       1         ; reserve 1 byte(s) in the module workspace
U0095               rmb       64        ; reserve 64 byte(s) in the module workspace
U00D5               rmb       31        ; reserve 31 byte(s) in the module workspace
U00F4               rmb       65        ; reserve 65 byte(s) in the module workspace
U0135               rmb       12        ; reserve 12 byte(s) in the module workspace
U0141               rmb       2         ; reserve 2 byte(s) in the module workspace
U0143               rmb       2         ; reserve 2 byte(s) in the module workspace
U0145               rmb       2         ; reserve 2 byte(s) in the module workspace
U0147               rmb       3         ; reserve 3 byte(s) in the module workspace
U014A               rmb       1         ; reserve 1 byte(s) in the module workspace
U014B               rmb       1         ; reserve 1 byte(s) in the module workspace
U014C               rmb       1         ; reserve 1 byte(s) in the module workspace
U014D               rmb       2         ; reserve 2 byte(s) in the module workspace
U014F               rmb       1         ; reserve 1 byte(s) in the module workspace
U0150               rmb       1         ; reserve 1 byte(s) in the module workspace
U0151               rmb       2         ; reserve 2 byte(s) in the module workspace
U0153               rmb       2         ; reserve 2 byte(s) in the module workspace
U0155               rmb       3         ; reserve 3 byte(s) in the module workspace
U0158               rmb       1         ; reserve 1 byte(s) in the module workspace
U0159               rmb       8399      ; reserve 8399 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /DLD.add/ ; store an OS-9 high-bit-terminated string
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
L007F               fcc       "Enter filename to add:" ; store literal character data
L0095               fcc       "DLD.lst" ; store literal character data
                    fcb       $0D       ; store byte data
L009D               fcc       "DLD.key" ; store literal character data
                    fcb       $0D       ; store byte data
L00A5               fcc       "DLD.dsc" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0A       ; store byte data
L00AF               fcc       "Enter a one-line description of this file" ; store literal character data
                    fcb       $0D       ; store byte data
L00D9               fcc       "----------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
L011A               fcb       $3E       ; store byte data
                    fcb       $0D       ; store byte data
L011C               fcc       "     Enter file keywords now            (Blank line ends)" ; store literal character data
                    fcb       $0D       ; store byte data
L0156               fcb       $0A       ; store byte data
                    fcb       $0A       ; store byte data
                    fcc       "   Enter long description now          (Blank line ends)" ; store literal character data
                    fcb       $0D       ; store byte data
L0191               fcc       "Enter keyword:" ; store literal character data
L019F               fcb       $0A       ; store byte data
                    fcc       "[d]one [e]dit [C]ontinue or [L]ist" ; store literal character data
                    fcb       $0D       ; store byte data
L01C3               fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
L01C5               fcc       "Enter line #" ; store literal character data
                    fcb       $0D       ; store byte data
L01D2               fcb       $08       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $08       ; store byte data
start               lda       0,x       ; load a from 0,x
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L01E4     ; branch when the values are equal or the result is zero; target L01E4
                    lda       #1        ; set a to the constant 1
                    os9       I$ChgDir  ; invoke the OS-9 I$ChgDir service
                    lbcs      L0599     ; branch when carry reports an error or unsigned underflow; target L0599
L01E4               leax      >L0095,pc ; form the address >L0095,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    bcc       L01FE     ; branch when carry is clear; target L01FE
                    cmpb      #216      ; compare b with #216 and set the condition codes
                    lbne      L0599     ; branch when the values differ or the result is nonzero; target L0599
                    ldb       #27       ; set b to the constant 27
                    os9       I$Create  ; invoke the OS-9 I$Create service
                    lbcs      L0599     ; branch when carry reports an error or unsigned underflow; target L0599
L01FE               sta       U0001,u   ; store a at U0001,u
                    leax      >L009D,pc ; form the address >L009D,pc in x
                    lda       #2        ; set a to the constant 2
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    bcc       L021A     ; branch when carry is clear; target L021A
                    cmpb      #216      ; compare b with #216 and set the condition codes
                    lbne      L0599     ; branch when the values differ or the result is nonzero; target L0599
                    ldb       #27       ; set b to the constant 27
                    os9       I$Create  ; invoke the OS-9 I$Create service
                    lbcs      L0599     ; branch when carry reports an error or unsigned underflow; target L0599
L021A               sta       U0002,u   ; store a at U0002,u
                    leax      >L00A5,pc ; form the address >L00A5,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    bcc       L0236     ; branch when carry is clear; target L0236
                    cmpb      #216      ; compare b with #216 and set the condition codes
                    lbne      L0599     ; branch when the values differ or the result is nonzero; target L0599
                    ldb       #27       ; set b to the constant 27
                    os9       I$Create  ; invoke the OS-9 I$Create service
                    lbcs      L0599     ; branch when carry reports an error or unsigned underflow; target L0599
L0236               sta       U0003,u   ; store a at U0003,u
                    leax      >L007F,pc ; form the address >L007F,pc in x
                    ldy       #22       ; set y to the constant 22
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      <U0075,u  ; form the address <U0075,u in x
                    ldy       #27       ; set y to the constant 27
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
L0250               lda       U0001,u   ; load a from U0001,u
                    leax      >U00D5,u  ; form the address >U00D5,u in x
                    ldy       #96       ; set y to the constant 96
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    bcs       L0273     ; branch when carry reports an error or unsigned underflow; target L0273
                    leay      <U0075,u  ; form the address <U0075,u in y
L0262               lda       ,x+       ; load a from ,x+
                    cmpa      ,y+       ; compare a with ,y+ and set the condition codes
                    bne       L0250     ; branch when the values differ or the result is nonzero; target L0250
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L026E     ; branch when the values are equal or the result is zero; target L026E
                    bra       L0262     ; continue execution at L0262
L026E               ldb       #218      ; set b to the constant 218
                    lbra      L0599     ; continue execution at L0599
L0273               cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      L0599     ; branch when the values differ or the result is nonzero; target L0599
                    lda       U0001,u   ; load a from U0001,u
                    ldb       #5        ; set b to the constant 5
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    tfr       u,y       ; copy the register values specified by u,y
                    puls      u         ; restore u from the stack
                    stx       >U0145,u  ; store x at >U0145,u
                    sty       >U0147,u  ; store y at >U0147,u
                    ldx       #0        ; set x to the constant 0
                    pshs      u         ; save u on the stack
                    ldu       #0        ; set u to the constant 0
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    puls      u         ; restore u from the stack
L029C               lda       U0001,u   ; load a from U0001,u
                    leax      >U00D5,u  ; form the address >U00D5,u in x
                    ldy       #96       ; set y to the constant 96
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    bcs       L02E2     ; branch when carry reports an error or unsigned underflow; target L02E2
                    lda       >U00F4,u  ; load a from >U00F4,u
                    cmpa      #1        ; compare a with #1 and set the condition codes
                    bne       L029C     ; branch when the values differ or the result is nonzero; target L029C
                    lda       U0001,u   ; load a from U0001,u
                    ldb       #5        ; set b to the constant 5
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    tfr       u,d       ; copy the register values specified by u,d
                    subd      #96       ; subtract from d using #96
                    bge       L02C5     ; branch when the signed value is greater than or equal; target L02C5
                    leax      -$01,x    ; form the address -$01,x in x
L02C5               tfr       d,u       ; copy the register values specified by d,u
                    ldy       0,s       ; load y from the current stack frame at 0,s
                    lda       $01,y     ; load a from $01,y
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    lbcs      L0599     ; branch when carry reports an error or unsigned underflow; target L0599
                    tfr       u,y       ; copy the register values specified by u,y
                    puls      u         ; restore u from the stack
                    stx       >U0145,u  ; store x at >U0145,u
                    sty       >U0147,u  ; store y at >U0147,u
                    bra       L02E8     ; continue execution at L02E8
L02E2               cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      L0599     ; branch when the values differ or the result is nonzero; target L0599
L02E8               leax      >L00AF,pc ; form the address >L00AF,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L011A,pc ; form the address >L011A,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      >U0095,u  ; form the address >U0095,u in x
                    ldy       #64       ; set y to the constant 64
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    lda       #255      ; set a to the constant 255
                    sta       >U0094,u  ; store a at >U0094,u
                    leax      <U0075,u  ; form the address <U0075,u in x
                    lda       U0003,u   ; load a from U0003,u
                    ldb       #2        ; set b to the constant 2
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    lbcs      L0599     ; branch when carry reports an error or unsigned underflow; target L0599
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    lbcs      L0599     ; branch when carry reports an error or unsigned underflow; target L0599
                    tfr       u,y       ; copy the register values specified by u,y
                    puls      u         ; restore u from the stack
                    stx       >U0090,u  ; store x at >U0090,u
                    sty       >U0092,u  ; store y at >U0092,u
                    ldy       #96       ; set y to the constant 96
                    leax      <U0075,u  ; form the address <U0075,u in x
                    lda       U0001,u   ; load a from U0001,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lda       U0002,u   ; load a from U0002,u
                    ldb       #2        ; set b to the constant 2
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    lbcs      L0599     ; branch when carry reports an error or unsigned underflow; target L0599
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    lbcs      L0599     ; branch when carry reports an error or unsigned underflow; target L0599
                    puls      u         ; restore u from the stack
                    leax      >L011C,pc ; form the address >L011C,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L00D9,pc ; form the address >L00D9,pc in x
                    ldy       #65       ; set y to the constant 65
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    ldd       >U0145,u  ; load d from >U0145,u
                    std       >U0141,u  ; store d at >U0141,u
                    ldd       >U0147,u  ; load d from >U0147,u
                    std       >U0143,u  ; store d at >U0143,u
L0382               leax      >L0191,pc ; form the address >L0191,pc in x
                    ldy       #14       ; set y to the constant 14
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      >U0135,u  ; form the address >U0135,u in x
                    ldy       #12       ; set y to the constant 12
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    lbcs      L0382     ; branch when carry reports an error or unsigned underflow; target L0382
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    lbls      L03B2     ; branch when the unsigned value is lower or equal; target L03B2
                    lda       U0002,u   ; load a from U0002,u
                    ldy       #16       ; set y to the constant 16
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    bra       L0382     ; continue execution at L0382
L03B2               leax      >L0156,pc ; form the address >L0156,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L0599     ; branch when carry reports an error or unsigned underflow; target L0599
                    leax      >L00D9,pc ; form the address >L00D9,pc in x
                    ldy       #80       ; set y to the constant 80
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L0599     ; branch when carry reports an error or unsigned underflow; target L0599
                    ldd       #0        ; set d to the constant 0
                    std       >U014B,u  ; store d at >U014B,u
                    sta       U0004,u   ; store a at U0004,u
L03DB               ldd       >U014B,u  ; load d from >U014B,u
                    addd      #1        ; add to d using #1
                    std       >U014B,u  ; store d at >U014B,u
                    cmpd      #99       ; compare d with #99 and set the condition codes
                    bge       L03F7     ; branch when the signed value is greater than or equal; target L03F7
                    lbsr      L0510     ; call subroutine L0510
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bls       L03F7     ; branch when the unsigned value is lower or equal; target L03F7
                    bra       L03DB     ; continue execution at L03DB
L03F7               leax      >L019F,pc ; form the address >L019F,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L011A,pc ; form the address >L011A,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      U0000,u   ; form the address U0000,u in x
                    clra                ; clear a to zero and set the condition codes
                    ldy       #1        ; set y to the constant 1
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    leax      >L01C3,pc ; form the address >L01C3,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lda       U0000,u   ; load a from U0000,u
                    anda      #223      ; mask a using #223
                    cmpa      #68       ; compare a with #68 and set the condition codes
                    lbeq      L0563     ; branch when the values are equal or the result is zero; target L0563
                    cmpa      #69       ; compare a with #69 and set the condition codes
                    beq       L044D     ; branch when the values are equal or the result is zero; target L044D
                    cmpa      #67       ; compare a with #67 and set the condition codes
                    beq       L0440     ; branch when the values are equal or the result is zero; target L0440
                    cmpa      #76       ; compare a with #76 and set the condition codes
                    lbeq      L04C7     ; branch when the values are equal or the result is zero; target L04C7
                    bra       L03F7     ; continue execution at L03F7
L0440               ldd       >U014B,u  ; load d from >U014B,u
                    subd      #1        ; subtract from d using #1
                    std       >U014B,u  ; store d at >U014B,u
                    bra       L03DB     ; continue execution at L03DB
L044D               leax      >L01C5,pc ; form the address >L01C5,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L011A,pc ; form the address >L011A,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    clra                ; clear a to zero and set the condition codes
                    leax      >U0155,u  ; form the address >U0155,u in x
                    ldy       #3        ; set y to the constant 3
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    lbsr      L0728     ; call subroutine L0728
                    cmpd      >U014B,u  ; compare d with >U014B,u and set the condition codes
                    lbcc      L03F7     ; branch when carry is clear; target L03F7
                    std       >U0153,u  ; store d at >U0153,u
                    leax      >U0155,u  ; form the address >U0155,u in x
                    lbsr      L07AD     ; call subroutine L07AD
                    leax      >U0155,u  ; form the address >U0155,u in x
                    lda       #58       ; set a to the constant 58
                    sta       $02,x     ; store a at $02,x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    ldd       >U0153,u  ; load d from >U0153,u
                    leax      >U0158,u  ; form the address >U0158,u in x
                    lda       #80       ; set a to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      d,x       ; form the address d,x in x
                    ldy       #80       ; set y to the constant 80
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    tfr       y,d       ; copy the register values specified by y,d
                    stb       U0004,u   ; store b at U0004,u
                    dec       U0004,u   ; decrement the value at U0004,u
                    leay      U0005,u   ; form the address U0005,u in y
L04B7               lda       ,x+       ; load a from ,x+
                    sta       ,y+       ; store a at ,y+
                    decb                ; decrement b
                    bne       L04B7     ; branch when the values differ or the result is nonzero; target L04B7
                    ldd       >U0153,u  ; load d from >U0153,u
                    bsr       L0510     ; call subroutine L0510
                    lbra      L03F7     ; continue execution at L03F7
L04C7               ldd       #0        ; set d to the constant 0
                    std       >U014B,u  ; store d at >U014B,u
L04CE               ldd       >U014B,u  ; load d from >U014B,u
                    addd      #1        ; add to d using #1
                    std       >U014B,u  ; store d at >U014B,u
                    leax      >U0155,u  ; form the address >U0155,u in x
                    lbsr      L07AD     ; call subroutine L07AD
                    leax      >U0155,u  ; form the address >U0155,u in x
                    lda       #58       ; set a to the constant 58
                    sta       $02,x     ; store a at $02,x
                    lda       #1        ; set a to the constant 1
                    ldy       #3        ; set y to the constant 3
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      >U0158,u  ; form the address >U0158,u in x
                    ldd       >U014B,u  ; load d from >U014B,u
                    lda       #80       ; set a to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      d,x       ; form the address d,x in x
                    ldy       #80       ; set y to the constant 80
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bhi       L04CE     ; branch when the unsigned value is higher; target L04CE
                    lbra      L03F7     ; continue execution at L03F7
L0510               leax      >U0155,u  ; form the address >U0155,u in x
                    pshs      d         ; save d on the stack
                    lbsr      L07AD     ; call subroutine L07AD
                    leax      >U0155,u  ; form the address >U0155,u in x
                    lda       #58       ; set a to the constant 58
                    sta       $02,x     ; store a at $02,x
                    lda       #1        ; set a to the constant 1
                    ldy       #3        ; set y to the constant 3
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L0599     ; branch when carry reports an error or unsigned underflow; target L0599
                    leax      U0005,u   ; form the address U0005,u in x
                    ldb       U0004,u   ; load b from U0004,u
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    puls      d         ; restore d from the stack
                    lda       #80       ; set a to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      >U0158,u  ; form the address >U0158,u in x
                    leax      d,x       ; form the address d,x in x
                    leay      U0005,u   ; form the address U0005,u in y
                    ldb       #80       ; set b to the constant 80
                    lda       U0004,u   ; load a from U0004,u
                    beq       L055C     ; branch when the values are equal or the result is zero; target L055C
                    sta       >U014F,u  ; store a at >U014F,u
L0551               lda       ,y+       ; load a from ,y+
                    sta       ,x+       ; store a at ,x+
                    decb                ; decrement b
                    dec       >U014F,u  ; decrement the value at >U014F,u
                    bne       L0551     ; branch when the values differ or the result is nonzero; target L0551
L055C               clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    lbsr      L059C     ; call subroutine L059C
                    rts                 ; return to the caller
L0563               lda       #0        ; set a to the constant 0
                    sta       >U014D,u  ; store a at >U014D,u
L0569               lda       >U014D,u  ; load a from >U014D,u
                    inca                ; increment a
                    sta       >U014D,u  ; store a at >U014D,u
                    cmpa      >U014C,u  ; compare a with >U014C,u and set the condition codes
                    bhi       L0598     ; branch when the unsigned value is higher; target L0598
                    ldb       #80       ; set b to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      >U0158,u  ; form the address >U0158,u in x
                    leax      d,x       ; form the address d,x in x
                    ldy       #80       ; set y to the constant 80
                    lda       U0003,u   ; load a from U0003,u
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L0599     ; branch when carry reports an error or unsigned underflow; target L0599
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bls       L0598     ; branch when the unsigned value is lower or equal; target L0598
                    tfr       y,d       ; copy the register values specified by y,d
                    bra       L0569     ; continue execution at L0569
L0598               clrb                ; clear b to zero and set the condition codes
L0599               os9       F$Exit    ; invoke the OS-9 F$Exit service
L059C               lbsr      L06F3     ; call subroutine L06F3
                    ldb       U0004,u   ; load b from U0004,u
                    leay      b,y       ; form the address b,y in y
                    pshs      y         ; save y on the stack
                    negb                ; negate b
                    sex                 ; sign-extend b into d
                    leay      d,y       ; form the address d,y in y
                    clr       U0004,u   ; clear U0004,u to zero and set the condition codes
                    cmpy      #0        ; compare y with #0 and set the condition codes
                    lbeq      L066B     ; branch when the values are equal or the result is zero; target L066B
                    pshs      y,x       ; save y,x on the stack
                    lda       #13       ; set a to the constant 13
L05B7               sta       ,x+       ; store a at ,x+
                    leay      -$01,y    ; form the address -$01,y in y
                    bne       L05B7     ; branch when the values differ or the result is nonzero; target L05B7
                    puls      y,x       ; restore y,x from the stack
L05BF               pshs      y,x       ; save y,x on the stack
                    leax      U0000,u   ; form the address U0000,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    bcs       L05F8     ; branch when carry reports an error or unsigned underflow; target L05F8
                    lda       U0000,u   ; load a from U0000,u
                    cmpa      #1        ; compare a with #1 and set the condition codes
                    beq       L05FC     ; branch when the values are equal or the result is zero; target L05FC
                    cmpa      #8        ; compare a with #8 and set the condition codes
                    beq       L061E     ; branch when the values are equal or the result is zero; target L061E
                    cmpa      #24       ; compare a with #24 and set the condition codes
                    beq       L0642     ; branch when the values are equal or the result is zero; target L0642
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      L0669     ; branch when the values are equal or the result is zero; target L0669
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    bcs       L05F8     ; branch when carry reports an error or unsigned underflow; target L05F8
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    puls      y,x       ; restore y,x from the stack
                    lda       U0000,u   ; load a from U0000,u
                    sta       ,x+       ; store a at ,x+
                    leay      -$01,y    ; form the address -$01,y in y
                    lbeq      L0692     ; branch when the values are equal or the result is zero; target L0692
                    bra       L05BF     ; continue execution at L05BF
L05F8               puls      y,x       ; restore y,x from the stack
                    bra       L05BF     ; continue execution at L05BF
L05FC               puls      y,x       ; restore y,x from the stack
                    leay      -$01,y    ; form the address -$01,y in y
                    beq       L0619     ; branch when the values are equal or the result is zero; target L0619
                    lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L0617     ; branch when the values are equal or the result is zero; target L0617
                    pshs      y,x       ; save y,x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    bra       L05FC     ; continue execution at L05FC
L0617               leax      -$01,x    ; form the address -$01,x in x
L0619               leay      $01,y     ; form the address $01,y in y
                    lbra      L05BF     ; continue execution at L05BF
L061E               puls      y,x       ; restore y,x from the stack
                    leay      $01,y     ; form the address $01,y in y
                    cmpy      0,s       ; compare y with 0,s and set the condition codes
                    bhi       L063D     ; branch when the unsigned value is higher; target L063D
                    pshs      y,x       ; save y,x on the stack
                    leax      >L01D2,pc ; form the address >L01D2,pc in x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    puls      y,x       ; restore y,x from the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    lbra      L05BF     ; continue execution at L05BF
L063D               leay      -$01,y    ; form the address -$01,y in y
                    lbra      L05BF     ; continue execution at L05BF
L0642               puls      y,x       ; restore y,x from the stack
                    leay      $01,y     ; form the address $01,y in y
                    cmpy      0,s       ; compare y with 0,s and set the condition codes
                    bhi       L063D     ; branch when the unsigned value is higher; target L063D
                    pshs      y,x       ; save y,x on the stack
                    leax      >L01D2,pc ; form the address >L01D2,pc in x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    puls      y,x       ; restore y,x from the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    cmpy      0,s       ; compare y with 0,s and set the condition codes
                    lbhi      L05BF     ; branch when the unsigned value is higher; target L05BF
                    pshs      y,x       ; save y,x on the stack
                    bra       L0642     ; continue execution at L0642
L0669               puls      y,x       ; restore y,x from the stack
L066B               lda       #13       ; set a to the constant 13
                    sta       ,x+       ; store a at ,x+
                    pshs      y,x       ; save y,x on the stack
                    leax      >L01C3,pc ; form the address >L01C3,pc in x
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
                    lbsr      L070C     ; call subroutine L070C
                    rts                 ; return to the caller
                    fcc       "50" ; store literal character data
L0692               puls      d         ; restore d from the stack
                    pshs      y         ; save y on the stack
                    subd      0,s       ; subtract from d using 0,s
                    leas      $02,s     ; adjust the system stack pointer
                    addd      #1        ; add to d using #1
                    tfr       d,y       ; copy the register values specified by d,y
                    clrb                ; clear b to zero and set the condition codes
L06A0               leay      -$01,y    ; form the address -$01,y in y
                    beq       L06BE     ; branch when the values are equal or the result is zero; target L06BE
                    lda       ,-x       ; load a from ,-x
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       L06CF     ; branch when the values are equal or the result is zero; target L06CF
                    pshs      y,x       ; save y,x on the stack
                    leax      >L01D2,pc ; form the address >L01D2,pc in x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    incb                ; increment b
                    puls      y,x       ; restore y,x from the stack
                    bra       L06A0     ; continue execution at L06A0
L06BE               lda       #13       ; set a to the constant 13
                    sta       <$004F,x  ; store a at <$004F,x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    puls      y         ; restore y from the stack
                    rts                 ; return to the caller
L06CF               lda       #13       ; set a to the constant 13
                    sta       ,x+       ; store a at ,x+
                    pshs      y,x       ; save y,x on the stack
                    stb       U0004,u   ; store b at U0004,u
                    leay      U0005,u   ; form the address U0005,u in y
L06D9               lda       ,x+       ; load a from ,x+
                    sta       ,y+       ; store a at ,y+
                    decb                ; decrement b
                    bne       L06D9     ; branch when the values differ or the result is nonzero; target L06D9
                    leax      >L01C3,pc ; form the address >L01C3,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    puls      y,x       ; restore y,x from the stack
                    lbsr      L070C     ; call subroutine L070C
                    rts                 ; return to the caller
L06F3               pshs      y,x,d     ; save y,x,d on the stack
                    leax      <U0055,u  ; form the address <U0055,u in x
                    clra                ; clear a to zero and set the condition codes
                    ldb       #0        ; set b to the constant 0
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    leax      -$20,x    ; form the address -$20,x in x
                    clr       <$0024,x  ; clear <$0024,x to zero and set the condition codes
                    leax      <$0020,x  ; form the address <$0020,x in x
                    os9       I$SetStt  ; invoke the OS-9 I$SetStt service
                    puls      pc,y,x,d  ; restore pc,y,x,d and return to the caller
L070C               pshs      y,x,d     ; save y,x,d on the stack
                    leax      <U0055,u  ; form the address <U0055,u in x
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
L0728               pshs      y         ; save y on the stack
L072A               lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      L07EE     ; branch when the values are equal or the result is zero; target L07EE
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L072A     ; branch when carry reports an error or unsigned underflow; target L072A
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L072A     ; branch when the unsigned value is higher; target L072A
                    leax      -$01,x    ; form the address -$01,x in x
L073C               lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L0748     ; branch when carry reports an error or unsigned underflow; target L0748
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L0748     ; branch when the unsigned value is higher; target L0748
                    bra       L073C     ; continue execution at L073C
L0748               pshs      x         ; save x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    clr       >U014F,u  ; clear >U014F,u to zero and set the condition codes
                    clr       >U0150,u  ; clear >U0150,u to zero and set the condition codes
                    ldd       #1        ; set d to the constant 1
                    std       >U0151,u  ; store d at >U0151,u
L075B               lda       ,-x       ; load a from ,-x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L07A5     ; branch when carry reports an error or unsigned underflow; target L07A5
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L07A5     ; branch when the unsigned value is higher; target L07A5
                    suba      #48       ; subtract from a using #48
                    sta       >U014A,u  ; store a at >U014A,u
                    ldd       #0        ; set d to the constant 0
L076E               tst       >U014A,u  ; set condition codes from >U014A,u without changing it
                    beq       L077E     ; branch when the values are equal or the result is zero; target L077E
                    addd      >U0151,u  ; add to d using >U0151,u
                    dec       >U014A,u  ; decrement the value at >U014A,u
                    bra       L076E     ; continue execution at L076E
L077E               addd      >U014F,u  ; add to d using >U014F,u
                    std       >U014F,u  ; store d at >U014F,u
                    lda       #10       ; set a to the constant 10
                    sta       >U014A,u  ; store a at >U014A,u
                    ldd       #0        ; set d to the constant 0
L078F               tst       >U014A,u  ; set condition codes from >U014A,u without changing it
                    beq       L079F     ; branch when the values are equal or the result is zero; target L079F
                    addd      >U0151,u  ; add to d using >U0151,u
                    dec       >U014A,u  ; decrement the value at >U014A,u
                    bra       L078F     ; continue execution at L078F
L079F               std       >U0151,u  ; store d at >U0151,u
                    bra       L075B     ; continue execution at L075B
L07A5               ldd       >U014F,u  ; load d from >U014F,u
                    puls      x         ; restore x from the stack
                    puls      pc,y      ; restore pc,y and return to the caller
L07AD               pshs      y         ; save y on the stack
                    std       >U014F,u  ; store d at >U014F,u
                    lda       #48       ; set a to the constant 48
                    sta       0,x       ; store a at 0,x
                    sta       $01,x     ; store a at $01,x
                    ldd       #10       ; set d to the constant 10
                    std       >U0151,u  ; store d at >U0151,u
                    ldd       >U014F,u  ; load d from >U014F,u
                    bsr       L07D9     ; call subroutine L07D9
                    ldd       #1        ; set d to the constant 1
                    std       >U0151,u  ; store d at >U0151,u
                    ldd       >U014F,u  ; load d from >U014F,u
                    bsr       L07D9     ; call subroutine L07D9
                    lda       #13       ; set a to the constant 13
                    sta       0,x       ; store a at 0,x
                    puls      pc,y      ; restore pc,y and return to the caller
L07D9               subd      >U0151,u  ; subtract from d using >U0151,u
                    bcs       L07E3     ; branch when carry reports an error or unsigned underflow; target L07E3
                    inc       0,x       ; increment the value at 0,x
                    bra       L07D9     ; continue execution at L07D9
L07E3               addd      >U0151,u  ; add to d using >U0151,u
                    std       >U014F,u  ; store d at >U014F,u
                    leax      $01,x     ; form the address $01,x in x
                    rts                 ; return to the caller
L07EE               ldd       #-1       ; set d to the constant -1
                    puls      pc,y      ; restore pc,y and return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
