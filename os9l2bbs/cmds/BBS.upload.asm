**********************************************************************
* BBS.upload - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       BBS.upload
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

U0000               rmb       1         ; reserve 1 byte(s) in the module workspace
U0001               rmb       2         ; reserve 2 byte(s) in the module workspace
U0003               rmb       13        ; reserve 13 byte(s) in the module workspace
U0010               rmb       2         ; reserve 2 byte(s) in the module workspace
U0012               rmb       2         ; reserve 2 byte(s) in the module workspace
U0014               rmb       2         ; reserve 2 byte(s) in the module workspace
U0016               rmb       6         ; reserve 6 byte(s) in the module workspace
U001C               rmb       2         ; reserve 2 byte(s) in the module workspace
U001E               rmb       2         ; reserve 2 byte(s) in the module workspace
U0020               rmb       2         ; reserve 2 byte(s) in the module workspace
U0022               rmb       16        ; reserve 16 byte(s) in the module workspace
U0032               rmb       27        ; reserve 27 byte(s) in the module workspace
U004D               rmb       2         ; reserve 2 byte(s) in the module workspace
U004F               rmb       2         ; reserve 2 byte(s) in the module workspace
U0051               rmb       1         ; reserve 1 byte(s) in the module workspace
U0052               rmb       64        ; reserve 64 byte(s) in the module workspace
U0092               rmb       31        ; reserve 31 byte(s) in the module workspace
U00B1               rmb       1         ; reserve 1 byte(s) in the module workspace
U00B2               rmb       8499      ; reserve 8499 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.upload/ ; store an OS-9 high-bit-terminated string
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
L0082               fcc       "Uloadx" ; store literal character data
                    fcb       $0D       ; store byte data
L0089               fcc       "Uloadxc" ; store literal character data
                    fcb       $0D       ; store byte data
L0091               fcc       "Uloady" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcc       "Uloadyb" ; store literal character data
                    fcb       $0D       ; store byte data
L00A0               fcc       "Uloada" ; store literal character data
                    fcb       $0D       ; store byte data
L00A7               fcc       "Enter your upload protocol" ; store literal character data
                    fcb       $0D       ; store byte data
L00C2               fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
                    fcc       "[a] Ascii" ; store literal character data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
                    fcc       "[x] xmodem" ; store literal character data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
                    fcc       "[C] xmodem (CRC)" ; store literal character data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
                    fcc       "[y] ymodem" ; store literal character data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
                    fcc       "[q] quit" ; store literal character data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
                    fcc       "Protocol?" ; store literal character data
L010C               fcc       "Enter filename to upload:" ; store literal character data
L0125               fcc       "DLD.lst" ; store literal character data
                    fcb       $0D       ; store byte data
L012D               fcb       $0D       ; store byte data
                    fcb       $0A       ; store byte data
L012F               fcc       "Enter a one-line description of this file" ; store literal character data
                    fcb       $0D       ; store byte data
L0159               fcb       $3E       ; store byte data
                    fcb       $0D       ; store byte data
L015B               fcc       "/dd/bbs/BBS.userstats" ; store literal character data
                    fcb       $0D       ; store byte data
start               lda       0,x       ; load a from 0,x
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L0180     ; branch when the values are equal or the result is zero; target L0180
                    lda       #1        ; set a to the constant 1
                    os9       I$ChgDir  ; invoke the OS-9 I$ChgDir service
                    lbcs      L04B2     ; branch when carry reports an error or unsigned underflow; target L04B2
L0180               leax      >L0125,pc ; form the address >L0125,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    bcs       L018F     ; branch when carry reports an error or unsigned underflow; target L018F
                    sta       U0001,u   ; store a at U0001,u
                    bra       L01A0     ; continue execution at L01A0
L018F               cmpb      #216      ; compare b with #216 and set the condition codes
                    lbne      L04B2     ; branch when the values differ or the result is nonzero; target L04B2
                    ldb       #27       ; set b to the constant 27
                    os9       I$Create  ; invoke the OS-9 I$Create service
                    lbcs      L04B2     ; branch when carry reports an error or unsigned underflow; target L04B2
                    sta       U0001,u   ; store a at U0001,u
L01A0               leax      >L00A7,pc ; form the address >L00A7,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L00C2,pc ; form the address >L00C2,pc in x
                    ldy       #74       ; set y to the constant 74
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      U0000,u   ; form the address U0000,u in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    leax      >L012D,pc ; form the address >L012D,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lda       U0000,u   ; load a from U0000,u
                    anda      #223      ; mask a using #223
                    cmpa      #65       ; compare a with #65 and set the condition codes
                    lbeq      L01F6     ; branch when the values are equal or the result is zero; target L01F6
                    cmpa      #88       ; compare a with #88 and set the condition codes
                    lbeq      L023A     ; branch when the values are equal or the result is zero; target L023A
                    cmpa      #67       ; compare a with #67 and set the condition codes
                    lbeq      L027E     ; branch when the values are equal or the result is zero; target L027E
                    cmpa      #89       ; compare a with #89 and set the condition codes
                    lbeq      L02C6     ; branch when the values are equal or the result is zero; target L02C6
                    cmpa      #81       ; compare a with #81 and set the condition codes
                    lbeq      L04B1     ; branch when the values are equal or the result is zero; target L04B1
                    bra       L0180     ; continue execution at L0180
L01F6               leax      >L010C,pc ; form the address >L010C,pc in x
                    ldy       #25       ; set y to the constant 25
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      <U0032,u  ; form the address <U0032,u in x
                    ldy       #27       ; set y to the constant 27
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    bcs       L01F6     ; branch when carry reports an error or unsigned underflow; target L01F6
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    lbls      L04B1     ; branch when the unsigned value is lower or equal; target L04B1
                    lda       #17       ; set a to the constant 17
                    ldb       #3        ; set b to the constant 3
                    leax      >L00A0,pc ; form the address >L00A0,pc in x
                    pshs      u         ; save u on the stack
                    leau      <U0032,u  ; form the workspace or data address <U0032,u in u
                    os9       F$Fork    ; invoke the OS-9 F$Fork service
                    lbcs      L04B2     ; branch when carry reports an error or unsigned underflow; target L04B2
                    clrb                ; clear b to zero and set the condition codes
                    os9       F$Wait    ; invoke the OS-9 F$Wait service
                    tstb                ; set condition codes from b without changing it
                    lbne      L04B2     ; branch when the values differ or the result is nonzero; target L04B2
                    puls      u         ; restore u from the stack
                    lbra      L0336     ; continue execution at L0336
L023A               leax      >L010C,pc ; form the address >L010C,pc in x
                    ldy       #25       ; set y to the constant 25
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      <U0032,u  ; form the address <U0032,u in x
                    ldy       #27       ; set y to the constant 27
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    bcs       L023A     ; branch when carry reports an error or unsigned underflow; target L023A
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    lbls      L04B1     ; branch when the unsigned value is lower or equal; target L04B1
                    lda       #17       ; set a to the constant 17
                    ldb       #3        ; set b to the constant 3
                    leax      >L0082,pc ; form the address >L0082,pc in x
                    pshs      u         ; save u on the stack
                    leau      <U0032,u  ; form the workspace or data address <U0032,u in u
                    os9       F$Fork    ; invoke the OS-9 F$Fork service
                    lbcs      L04B2     ; branch when carry reports an error or unsigned underflow; target L04B2
                    clrb                ; clear b to zero and set the condition codes
                    os9       F$Wait    ; invoke the OS-9 F$Wait service
                    tstb                ; set condition codes from b without changing it
                    lbne      L04B2     ; branch when the values differ or the result is nonzero; target L04B2
                    puls      u         ; restore u from the stack
                    lbra      L0336     ; continue execution at L0336
L027E               leax      >L010C,pc ; form the address >L010C,pc in x
                    ldy       #25       ; set y to the constant 25
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      <U0032,u  ; form the address <U0032,u in x
                    ldy       #27       ; set y to the constant 27
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    bcs       L027E     ; branch when carry reports an error or unsigned underflow; target L027E
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    lbls      L04B1     ; branch when the unsigned value is lower or equal; target L04B1
                    lda       #17       ; set a to the constant 17
                    ldb       #3        ; set b to the constant 3
                    leax      >L0089,pc ; form the address >L0089,pc in x
                    pshs      u         ; save u on the stack
                    leau      <U0032,u  ; form the workspace or data address <U0032,u in u
                    os9       F$Fork    ; invoke the OS-9 F$Fork service
                    lbcs      L04B2     ; branch when carry reports an error or unsigned underflow; target L04B2
                    clrb                ; clear b to zero and set the condition codes
                    os9       F$Wait    ; invoke the OS-9 F$Wait service
                    lbcs      L04B2     ; branch when carry reports an error or unsigned underflow; target L04B2
                    tstb                ; set condition codes from b without changing it
                    lbne      L04B2     ; branch when the values differ or the result is nonzero; target L04B2
                    puls      u         ; restore u from the stack
                    lbra      L0336     ; continue execution at L0336
L02C6               leax      >L010C,pc ; form the address >L010C,pc in x
                    ldy       #25       ; set y to the constant 25
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      <U0032,u  ; form the address <U0032,u in x
                    ldy       #27       ; set y to the constant 27
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    bcs       L02C6     ; branch when carry reports an error or unsigned underflow; target L02C6
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    lbls      L04B1     ; branch when the unsigned value is lower or equal; target L04B1
                    lda       #17       ; set a to the constant 17
                    ldb       #3        ; set b to the constant 3
                    leax      >L0091,pc ; form the address >L0091,pc in x
                    pshs      u         ; save u on the stack
                    leau      <U0032,u  ; form the workspace or data address <U0032,u in u
                    os9       F$Fork    ; invoke the OS-9 F$Fork service
                    lbcs      L04B2     ; branch when carry reports an error or unsigned underflow; target L04B2
                    clrb                ; clear b to zero and set the condition codes
                    os9       F$Wait    ; invoke the OS-9 F$Wait service
                    lbcs      L04B2     ; branch when carry reports an error or unsigned underflow; target L04B2
                    tstb                ; set condition codes from b without changing it
                    lbne      L04B2     ; branch when the values differ or the result is nonzero; target L04B2
                    puls      u         ; restore u from the stack
                    lbra      L0336     ; continue execution at L0336
                    fcb       $86       ; store byte data
                    fcb       $11       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $8E       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $C6       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $8D       ; store byte data
                    fcb       $FD       ; store byte data
                    fcc       "~4@3" ; store literal character data
                    fcb       $C9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $2D       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $8B       ; store byte data
                    fcb       $5F       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $83       ; store byte data
                    fcb       $5D       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $26       ; store byte data
                    fcb       $01       ; store byte data
                    fcc       "~5@" ; store literal character data
L0336               lda       U0001,u   ; load a from U0001,u
                    leax      >U0092,u  ; form the address >U0092,u in x
                    ldy       #96       ; set y to the constant 96
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    bcs       L0359     ; branch when carry reports an error or unsigned underflow; target L0359
                    leay      <U0032,u  ; form the address <U0032,u in y
L0348               lda       ,x+       ; load a from ,x+
                    cmpa      ,y+       ; compare a with ,y+ and set the condition codes
                    bne       L0336     ; branch when the values differ or the result is nonzero; target L0336
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L0354     ; branch when the values are equal or the result is zero; target L0354
                    bra       L0348     ; continue execution at L0348
L0354               ldb       #218      ; set b to the constant 218
                    lbra      L04B2     ; continue execution at L04B2
L0359               cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      L04B2     ; branch when the values differ or the result is nonzero; target L04B2
                    lda       U0001,u   ; load a from U0001,u
                    ldb       #5        ; set b to the constant 5
                    ldx       #0        ; set x to the constant 0
                    pshs      u         ; save u on the stack
                    ldu       #0        ; set u to the constant 0
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    puls      u         ; restore u from the stack
L0370               lda       U0001,u   ; load a from U0001,u
                    leax      >U0092,u  ; form the address >U0092,u in x
                    ldy       #96       ; set y to the constant 96
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    bcs       L03A7     ; branch when carry reports an error or unsigned underflow; target L03A7
                    lda       >U00B1,u  ; load a from >U00B1,u
                    cmpa      #1        ; compare a with #1 and set the condition codes
                    bne       L0370     ; branch when the values differ or the result is nonzero; target L0370
                    lda       U0001,u   ; load a from U0001,u
                    ldb       #5        ; set b to the constant 5
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    tfr       u,d       ; copy the register values specified by u,d
                    subd      #96       ; subtract from d using #96
                    bge       L0399     ; branch when the signed value is greater than or equal; target L0399
                    leax      -$01,x    ; form the address -$01,x in x
L0399               ldy       0,s       ; load y from the current stack frame at 0,s
                    tfr       d,u       ; copy the register values specified by d,u
                    lda       $01,y     ; load a from $01,y
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    puls      u         ; restore u from the stack
                    bra       L03AD     ; continue execution at L03AD
L03A7               cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      L04B2     ; branch when the values differ or the result is nonzero; target L04B2
L03AD               ldx       #0        ; set x to the constant 0
                    ldy       #0        ; set y to the constant 0
                    stx       <U004D,u  ; store x at <U004D,u
                    sty       <U004F,u  ; store y at <U004F,u
                    leax      >L012F,pc ; form the address >L012F,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L0159,pc ; form the address >L0159,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      <U0052,u  ; form the address <U0052,u in x
                    ldy       #64       ; set y to the constant 64
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    clr       <U0051,u  ; clear <U0051,u to zero and set the condition codes
                    leax      <U0032,u  ; form the address <U0032,u in x
                    ldy       #-1       ; set y to the constant -1
                    sty       <U004D,u  ; store y at <U004D,u
                    sty       <U004F,u  ; store y at <U004F,u
                    ldy       #96       ; set y to the constant 96
                    lda       U0001,u   ; load a from U0001,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      >L015B,pc ; form the address >L015B,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    bcc       L040D     ; branch when carry is clear; target L040D
                    ldb       #27       ; set b to the constant 27
                    os9       I$Create  ; invoke the OS-9 I$Create service
                    lbcs      L04B2     ; branch when carry reports an error or unsigned underflow; target L04B2
L040D               sta       U0003,u   ; store a at U0003,u
                    os9       F$ID      ; invoke the OS-9 F$ID service
                    sty       <U0010,u  ; store y at <U0010,u
L0416               leax      <U0012,u  ; form the address <U0012,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       U0003,u   ; load a from U0003,u
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    bcs       L042F     ; branch when carry reports an error or unsigned underflow; target L042F
                    ldd       <U0012,u  ; load d from <U0012,u
                    cmpd      <U0010,u  ; compare d with <U0010,u and set the condition codes
                    bne       L0416     ; branch when the values differ or the result is nonzero; target L0416
                    bra       L0438     ; continue execution at L0438
L042F               cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      L04B2     ; branch when the values differ or the result is nonzero; target L04B2
                    lbra      L0476     ; continue execution at L0476
L0438               ldd       <U0022,u  ; load d from <U0022,u
                    addd      #1        ; add to d using #1
                    std       <U0022,u  ; store d at <U0022,u
                    lda       U0003,u   ; load a from U0003,u
                    ldb       #5        ; set b to the constant 5
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    tfr       u,d       ; copy the register values specified by u,d
                    subd      #32       ; subtract from d using #32
                    bge       L0453     ; branch when the signed value is greater than or equal; target L0453
                    leax      -$01,x    ; form the address -$01,x in x
L0453               ldu       0,s       ; load u from the current stack frame at 0,s
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       U0003,u   ; load a from U0003,u
                    tfr       y,u       ; copy the register values specified by y,u
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    lbcs      L04B2     ; branch when carry reports an error or unsigned underflow; target L04B2
                    puls      u         ; restore u from the stack
                    leax      <U0012,u  ; form the address <U0012,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       U0003,u   ; load a from U0003,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lbra      L04B1     ; continue execution at L04B1
L0476               leax      <U0012,u  ; form the address <U0012,u in x
                    ldd       #1        ; set d to the constant 1
                    std       <U0014,u  ; store d at <U0014,u
                    std       <U001E,u  ; store d at <U001E,u
                    ldd       #0        ; set d to the constant 0
                    std       <U001C,u  ; store d at <U001C,u
                    std       <U0022,u  ; store d at <U0022,u
                    std       <U0020,u  ; store d at <U0020,u
                    ldd       <U0010,u  ; load d from <U0010,u
                    std       <U0012,u  ; store d at <U0012,u
                    leax      <U0016,u  ; form the address <U0016,u in x
                    os9       F$Time    ; invoke the OS-9 F$Time service
                    lbcs      L04B2     ; branch when carry reports an error or unsigned underflow; target L04B2
                    leax      <U0012,u  ; form the address <U0012,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       U0003,u   ; load a from U0003,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lbcs      L04B2     ; branch when carry reports an error or unsigned underflow; target L04B2
L04B1               clrb                ; clear b to zero and set the condition codes
L04B2               os9       F$Exit    ; invoke the OS-9 F$Exit service

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
