**********************************************************************
* BBS.post - OS-9 Level 2 BBS command
*
* Syntax: BBS.post
* Purpose: Compose and append a public board message.
* Data: bbs.msg, bbs.msg.inx, /dd/bbs/bbs.alias, and BBS.userstats.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
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

WorkByte_001        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_002        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_003        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_004        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_005        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_006        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_007        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_008        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_001        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_009        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_010        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_011        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_012        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_002        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_003        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_004        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_013        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_014        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_005        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_006        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_001      rmb       200       ; reserve 200 byte(s) in the module workspace
WorkByte_015        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_002      rmb       5         ; reserve 5 byte(s) in the module workspace
WorkByte_016        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_007        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_008        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_003      rmb       60        ; reserve 60 byte(s) in the module workspace
WorkWord_009        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_010        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_004      rmb       20        ; reserve 20 byte(s) in the module workspace
WorkBuffer_005      rmb       30        ; reserve 30 byte(s) in the module workspace
WorkBuffer_006      rmb       6         ; reserve 6 byte(s) in the module workspace
WorkWord_011        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_012        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_013        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_014        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_007      rmb       6         ; reserve 6 byte(s) in the module workspace
WorkWord_015        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_016        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_017        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_008      rmb       16        ; reserve 16 byte(s) in the module workspace
WorkBuffer_009      rmb       200       ; reserve 200 byte(s) in the module workspace
WorkBuffer_010      rmb       8000      ; reserve 8000 byte(s) in the module workspace
WorkBuffer_011      rmb       80        ; reserve 80 byte(s) in the module workspace
WorkByte_017        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_012      rmb       231       ; reserve 231 byte(s) in the module workspace
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
Text_001            fcc       "BBS.msg.inx" ; store literal character data
                    fcb       $0D       ; store byte data
Text_002            fcc       "BBS.msg" ; store literal character data
                    fcb       $0D       ; store byte data
Data_001            fcb       $0A       ; store byte data
                    fcc       "Enter subject of message" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $0A       ; store byte data
                    fcc       ">" ; store literal character data
Text_003            fcc       "Address message to (BLANK for ALL):" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $0A       ; store byte data
                    fcb       $3E       ; store byte data
Data_002            fcb       $00       ; store byte data
                    fcb       $1C       ; store byte data
Data_003            fcb       $0A       ; store byte data
                    fcb       $0A       ; store byte data
                    fcc       "    Please enter message now            (Blank line ends)" ; store literal character data
                    fcb       $0D       ; store byte data
Text_004            fcc       "----------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
Text_005            fcc       "/dd/bbs/BBS.alias" ; store literal character data
                    fcb       $0D       ; store byte data
Data_004            fcb       $0A       ; store byte data
                    fcc       "[A]bort [D]one [E]dit [C]ontinue or [L]ist" ; store literal character data
                    fcb       $0D       ; store byte data
Text_006            fcc       "Enter line #" ; store literal character data
                    fcb       $0D       ; store byte data
Data_005            fcb       $3E       ; store byte data
Data_006            fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
Data_007            fcb       $08       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $08       ; store byte data
Text_007            fcc       "/dd/bbs/BBS.userstats" ; store literal character data
                    fcb       $0D       ; store byte data
Text_008            fcc       "User name not found!" ; store literal character data
                    fcb       $0D       ; store byte data
start               clr       >WorkByte_016,u ; clear >WorkByte_016,u to zero and set the condition codes
                    clr       >WorkByte_015,u ; clear >WorkByte_015,u to zero and set the condition codes
                    clr       WorkByte_007,u ; clear WorkByte_007,u to zero and set the condition codes
                    os9       F$ID      ; retrieve the current process and user IDs
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    sty       WorkWord_001,u ; store y at WorkWord_001,u
                    ldy       #0        ; set y to the constant 0
                    os9       F$SUser   ; change the process user ID to Y
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      >Text_001,pc ; form the address >Text_001,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    sta       WorkByte_001,u ; store a at WorkByte_001,u
                    leax      >WorkWord_007,u ; form the address >WorkWord_007,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    os9       I$Close   ; close path A
                    leax      >Text_001,pc ; form the address >Text_001,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    sta       WorkByte_001,u ; store a at WorkByte_001,u
                    lda       #6        ; set a to the constant 6
                    sta       WorkByte_004,u ; store a at WorkByte_004,u
                    ldd       >WorkWord_007,u ; load d from >WorkWord_007,u
                    addd      #1        ; add to d using #1
                    std       >WorkWord_007,u ; store d at >WorkWord_007,u
                    clr       WorkByte_011,u ; clear WorkByte_011,u to zero and set the condition codes
                    clr       WorkByte_012,u ; clear WorkByte_012,u to zero and set the condition codes
Branch_002          aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    rol       WorkByte_012,u ; rotate left through carry the value at WorkByte_012,u
                    dec       WorkByte_004,u ; decrement the value at WorkByte_004,u
                    bne       Branch_002 ; branch when the values differ or the result is nonzero; target Branch_002
                    std       WorkWord_002,u ; store d at WorkWord_002,u
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    ldx       WorkByte_011,u ; load x from WorkByte_011,u
                    pshs      u         ; save u on the stack
                    ldu       WorkWord_002,u ; load u from WorkWord_002,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    puls      u         ; restore u from the stack
                    leax      >WorkBuffer_006,u ; form the address >WorkBuffer_006,u in x
                    os9       F$Time    ; read the current system date and time
                    leax      >Data_001,pc ; form the address >Data_001,pc in x
                    ldy       >Data_002,pc ; load y from >Data_002,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    clra                ; clear a to zero and set the condition codes
                    leax      >WorkBuffer_005,u ; form the address >WorkBuffer_005,u in x
                    ldy       #30       ; set y to the constant 30
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    leax      >Text_005,pc ; form the address >Text_005,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    sta       WorkByte_003,u ; store a at WorkByte_003,u
Branch_003          leax      >Text_003,pc ; form the address >Text_003,pc in x
                    ldy       #38       ; set y to the constant 38
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >WorkBuffer_009,u ; form the address >WorkBuffer_009,u in x
                    ldy       #200      ; set y to the constant 200
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    ble       Branch_004 ; branch when the signed value is less than or equal; target Branch_004
Branch_005          lda       ,x+       ; load a from ,x+
                    anda      #223      ; mask a using #223
                    sta       -$01,x    ; store a at -$01,x
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       Branch_005 ; branch when the values differ or the result is nonzero; target Branch_005
Branch_006          leax      <WorkBuffer_001,u ; form the address <WorkBuffer_001,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       WorkByte_003,u ; load a from WorkByte_003,u
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    bcs       Branch_007 ; branch when carry reports an error or unsigned underflow; target Branch_007
                    leay      >WorkBuffer_009,u ; form the address >WorkBuffer_009,u in y
                    leax      <WorkBuffer_001,u ; form the address <WorkBuffer_001,u in x
Branch_008          lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    beq       Branch_009 ; branch when the values are equal or the result is zero; target Branch_009
                    anda      #223      ; mask a using #223
                    cmpa      ,y+       ; compare a with ,y+ and set the condition codes
                    bne       Branch_006 ; branch when the values differ or the result is nonzero; target Branch_006
                    bra       Branch_008 ; continue execution at Branch_008
Branch_009          lda       ,y+       ; load a from ,y+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       Branch_006 ; branch when the values differ or the result is nonzero; target Branch_006
                    lbsr      Routine_001 ; call subroutine Routine_001
                    std       >WorkWord_012,u ; store d at >WorkWord_012,u
                    lda       WorkByte_003,u ; load a from WorkByte_003,u
                    pshs      u         ; save u on the stack
                    ldu       #0        ; set u to the constant 0
                    ldx       #0        ; set x to the constant 0
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    puls      u         ; restore u from the stack
                    bra       Branch_010 ; continue execution at Branch_010
Branch_007          leax      >Text_008,pc ; form the address >Text_008,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       WorkByte_003,u ; load a from WorkByte_003,u
                    pshs      u         ; save u on the stack
                    ldu       #0        ; set u to the constant 0
                    ldx       #0        ; set x to the constant 0
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbra      Branch_003 ; continue execution at Branch_003
Branch_004          ldd       #-1       ; set d to the constant -1
                    std       >WorkWord_012,u ; store d at >WorkWord_012,u
Branch_010          leax      >Data_003,pc ; form the address >Data_003,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      >Text_004,pc ; form the address >Text_004,pc in x
                    ldy       #80       ; set y to the constant 80
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    ldd       #0        ; set d to the constant 0
                    std       WorkByte_009,u ; store d at WorkByte_009,u
Branch_011          ldd       WorkByte_009,u ; load d from WorkByte_009,u
                    addd      #1        ; add to d using #1
                    std       WorkByte_009,u ; store d at WorkByte_009,u
                    cmpd      #99       ; compare d with #99 and set the condition codes
                    bge       Branch_012 ; branch when the signed value is greater than or equal; target Branch_012
                    lbsr      Routine_002 ; call subroutine Routine_002
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bls       Branch_012 ; branch when the unsigned value is lower or equal; target Branch_012
                    bra       Branch_011 ; continue execution at Branch_011
Branch_012          leax      >Data_004,pc ; form the address >Data_004,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Data_005,pc ; form the address >Data_005,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      WorkByte_006,u ; form the address WorkByte_006,u in x
                    clra                ; clear a to zero and set the condition codes
                    ldy       #1        ; set y to the constant 1
                    os9       I$Read    ; read up to Y bytes from path A into X
                    leax      >Data_006,pc ; form the address >Data_006,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       WorkByte_006,u ; load a from WorkByte_006,u
                    anda      #223      ; mask a using #223
                    cmpa      #65       ; compare a with #65 and set the condition codes
                    lbeq      Branch_013 ; branch when the values are equal or the result is zero; target Branch_013
                    cmpa      #68       ; compare a with #68 and set the condition codes
                    lbeq      Branch_014 ; branch when the values are equal or the result is zero; target Branch_014
                    cmpa      #69       ; compare a with #69 and set the condition codes
                    beq       Branch_015 ; branch when the values are equal or the result is zero; target Branch_015
                    cmpa      #67       ; compare a with #67 and set the condition codes
                    beq       Branch_016 ; branch when the values are equal or the result is zero; target Branch_016
                    cmpa      #76       ; compare a with #76 and set the condition codes
                    lbeq      Branch_017 ; branch when the values are equal or the result is zero; target Branch_017
                    bra       Branch_012 ; continue execution at Branch_012
Branch_016          ldd       WorkByte_009,u ; load d from WorkByte_009,u
                    subd      #1        ; subtract from d using #1
                    std       WorkByte_009,u ; store d at WorkByte_009,u
                    bra       Branch_011 ; continue execution at Branch_011
Branch_015          leax      >Text_006,pc ; form the address >Text_006,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Data_005,pc ; form the address >Data_005,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    clra                ; clear a to zero and set the condition codes
                    leax      >WorkBuffer_002,u ; form the address >WorkBuffer_002,u in x
                    ldy       #3        ; set y to the constant 3
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lbsr      Routine_001 ; call subroutine Routine_001
                    cmpd      WorkByte_009,u ; compare d with WorkByte_009,u and set the condition codes
                    lbcc      Branch_012 ; branch when carry is clear; target Branch_012
                    std       <WorkWord_006,u ; store d at <WorkWord_006,u
                    leax      >WorkBuffer_002,u ; form the address >WorkBuffer_002,u in x
                    lbsr      Routine_003 ; call subroutine Routine_003
                    leax      >WorkBuffer_002,u ; form the address >WorkBuffer_002,u in x
                    lda       #58       ; set a to the constant 58
                    sta       $02,x     ; store a at $02,x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    ldd       <WorkWord_006,u ; load d from <WorkWord_006,u
                    leax      >WorkBuffer_010,u ; form the address >WorkBuffer_010,u in x
                    lda       #80       ; set a to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      d,x       ; form the address d,x in x
                    ldy       #80       ; set y to the constant 80
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    tfr       y,d       ; copy the register values specified by y,d
                    stb       WorkByte_007,u ; store b at WorkByte_007,u
                    dec       WorkByte_007,u ; decrement the value at WorkByte_007,u
                    leay      >WorkBuffer_011,u ; form the address >WorkBuffer_011,u in y
Branch_018          lda       ,x+       ; load a from ,x+
                    sta       ,y+       ; store a at ,y+
                    decb                ; decrement b
                    bne       Branch_018 ; branch when the values differ or the result is nonzero; target Branch_018
                    ldd       <WorkWord_006,u ; load d from <WorkWord_006,u
                    bsr       Routine_002 ; call subroutine Routine_002
                    lbra      Branch_012 ; continue execution at Branch_012
Branch_017          ldd       #0        ; set d to the constant 0
                    std       WorkByte_009,u ; store d at WorkByte_009,u
Branch_019          ldd       WorkByte_009,u ; load d from WorkByte_009,u
                    addd      #1        ; add to d using #1
                    std       WorkByte_009,u ; store d at WorkByte_009,u
                    leax      >WorkBuffer_002,u ; form the address >WorkBuffer_002,u in x
                    lbsr      Routine_003 ; call subroutine Routine_003
                    leax      >WorkBuffer_002,u ; form the address >WorkBuffer_002,u in x
                    lda       #58       ; set a to the constant 58
                    sta       $02,x     ; store a at $02,x
                    lda       #1        ; set a to the constant 1
                    ldy       #3        ; set y to the constant 3
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >WorkBuffer_010,u ; form the address >WorkBuffer_010,u in x
                    ldd       WorkByte_009,u ; load d from WorkByte_009,u
                    lda       #80       ; set a to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      d,x       ; form the address d,x in x
                    ldy       #80       ; set y to the constant 80
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bhi       Branch_019 ; branch when the unsigned value is higher; target Branch_019
                    lbra      Branch_012 ; continue execution at Branch_012
Routine_002         leax      >WorkBuffer_002,u ; form the address >WorkBuffer_002,u in x
                    pshs      d         ; save d on the stack
                    lbsr      Routine_003 ; call subroutine Routine_003
                    leax      >WorkBuffer_002,u ; form the address >WorkBuffer_002,u in x
                    lda       #58       ; set a to the constant 58
                    sta       $02,x     ; store a at $02,x
                    lda       #1        ; set a to the constant 1
                    ldy       #3        ; set y to the constant 3
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      >WorkBuffer_011,u ; form the address >WorkBuffer_011,u in x
                    ldb       WorkByte_007,u ; load b from WorkByte_007,u
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      d         ; restore d from the stack
                    lda       #80       ; set a to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      >WorkBuffer_010,u ; form the address >WorkBuffer_010,u in x
                    leax      d,x       ; form the address d,x in x
                    leay      >WorkBuffer_011,u ; form the address >WorkBuffer_011,u in y
                    ldb       #80       ; set b to the constant 80
                    lda       WorkByte_007,u ; load a from WorkByte_007,u
                    beq       Branch_020 ; branch when the values are equal or the result is zero; target Branch_020
                    sta       <WorkByte_013,u ; store a at <WorkByte_013,u
Branch_021          lda       ,y+       ; load a from ,y+
                    sta       ,x+       ; store a at ,x+
                    decb                ; decrement b
                    dec       <WorkByte_013,u ; decrement the value at <WorkByte_013,u
                    bne       Branch_021 ; branch when the values differ or the result is nonzero; target Branch_021
Branch_020          clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    lbsr      Routine_004 ; call subroutine Routine_004
                    rts                 ; return to the caller
Branch_014          leax      <WorkBuffer_001,u ; form the address <WorkBuffer_001,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       WorkByte_003,u ; load a from WorkByte_003,u
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
Branch_022          lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    bne       Branch_022 ; branch when the values differ or the result is nonzero; target Branch_022
                    lbsr      Routine_001 ; call subroutine Routine_001
                    cmpd      WorkWord_001,u ; compare d with WorkWord_001,u and set the condition codes
                    bne       Branch_014 ; branch when the values differ or the result is nonzero; target Branch_014
                    leax      <WorkBuffer_001,u ; form the address <WorkBuffer_001,u in x
                    leay      >WorkBuffer_004,u ; form the address >WorkBuffer_004,u in y
Branch_023          lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    beq       Branch_024 ; branch when the values are equal or the result is zero; target Branch_024
                    sta       ,y+       ; store a at ,y+
                    bra       Branch_023 ; continue execution at Branch_023
Branch_024          lda       #13       ; set a to the constant 13
                    sta       ,y        ; store a at ,y
                    ldd       >WorkWord_008,u ; load d from >WorkWord_008,u
                    std       >WorkWord_009,u ; store d at >WorkWord_009,u
                    ldd       >WorkBuffer_003,u ; load d from >WorkBuffer_003,u
                    std       >WorkWord_010,u ; store d at >WorkWord_010,u
                    ldd       WorkWord_001,u ; load d from WorkWord_001,u
                    std       >WorkWord_011,u ; store d at >WorkWord_011,u
                    leax      >WorkWord_009,u ; form the address >WorkWord_009,u in x
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    ldy       #64       ; set y to the constant 64
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      >Text_002,pc ; form the address >Text_002,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    sta       WorkByte_002,u ; store a at WorkByte_002,u
                    pshs      u         ; save u on the stack
                    ldx       >WorkWord_008,u ; load x from >WorkWord_008,u
                    lda       WorkByte_002,u ; load a from WorkByte_002,u
                    ldu       >WorkBuffer_003,u ; load u from >WorkBuffer_003,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    puls      u         ; restore u from the stack
                    lda       #0        ; set a to the constant 0
                    sta       <WorkWord_003,u ; store a at <WorkWord_003,u
                    ldd       #1        ; set d to the constant 1
                    std       <WorkWord_004,u ; store d at <WorkWord_004,u
Branch_025          lda       <WorkWord_003,u ; load a from <WorkWord_003,u
                    inca                ; increment a
                    sta       <WorkWord_003,u ; store a at <WorkWord_003,u
                    cmpa      WorkByte_010,u ; compare a with WorkByte_010,u and set the condition codes
                    bhi       Branch_026 ; branch when the unsigned value is higher; target Branch_026
                    ldb       #80       ; set b to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      >WorkBuffer_010,u ; form the address >WorkBuffer_010,u in x
                    leax      d,x       ; form the address d,x in x
                    ldy       #80       ; set y to the constant 80
                    lda       WorkByte_002,u ; load a from WorkByte_002,u
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bls       Branch_026 ; branch when the unsigned value is lower or equal; target Branch_026
                    tfr       y,d       ; copy the register values specified by y,d
                    addd      <WorkWord_004,u ; add to d using <WorkWord_004,u
                    std       <WorkWord_004,u ; store d at <WorkWord_004,u
                    bra       Branch_025 ; continue execution at Branch_025
Branch_026          ldd       >WorkBuffer_003,u ; load d from >WorkBuffer_003,u
                    addd      <WorkWord_004,u ; add to d using <WorkWord_004,u
                    std       >WorkBuffer_003,u ; store d at >WorkBuffer_003,u
                    bcc       Branch_027 ; branch when carry is clear; target Branch_027
                    ldd       >WorkWord_008,u ; load d from >WorkWord_008,u
                    addd      #1        ; add to d using #1
                    std       >WorkWord_008,u ; store d at >WorkWord_008,u
Branch_027          pshs      u         ; save u on the stack
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    ldx       #0        ; set x to the constant 0
                    ldu       #0        ; set u to the constant 0
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    puls      u         ; restore u from the stack
                    leax      >WorkWord_007,u ; form the address >WorkWord_007,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      >Text_007,pc ; form the address >Text_007,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    bcc       Branch_028 ; branch when carry is clear; target Branch_028
                    ldb       #27       ; set b to the constant 27
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
Branch_028          sta       WorkByte_008,u ; store a at WorkByte_008,u
Branch_029          leax      >WorkWord_013,u ; form the address >WorkWord_013,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       WorkByte_008,u ; load a from WorkByte_008,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcs       Branch_030 ; branch when carry reports an error or unsigned underflow; target Branch_030
                    ldd       >WorkWord_013,u ; load d from >WorkWord_013,u
                    cmpd      WorkWord_001,u ; compare d with WorkWord_001,u and set the condition codes
                    bne       Branch_029 ; branch when the values differ or the result is nonzero; target Branch_029
                    bra       Branch_031 ; continue execution at Branch_031
Branch_030          cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      Branch_001 ; branch when the values differ or the result is nonzero; target Branch_001
                    lbra      Branch_032 ; continue execution at Branch_032
Branch_031          ldd       >WorkWord_015,u ; load d from >WorkWord_015,u
                    addd      #1        ; add to d using #1
                    std       >WorkWord_015,u ; store d at >WorkWord_015,u
                    lda       WorkByte_008,u ; load a from WorkByte_008,u
                    ldb       #5        ; set b to the constant 5
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; query status code B for path A
                    tfr       u,d       ; copy the register values specified by u,d
                    subd      #32       ; subtract from d using #32
                    bge       Branch_033 ; branch when the signed value is greater than or equal; target Branch_033
                    leax      -$01,x    ; form the address -$01,x in x
Branch_033          ldu       ,s        ; load u from the current stack frame at ,s
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       WorkByte_008,u ; load a from WorkByte_008,u
                    tfr       y,u       ; copy the register values specified by y,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    puls      u         ; restore u from the stack
                    leax      >WorkWord_013,u ; form the address >WorkWord_013,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       WorkByte_008,u ; load a from WorkByte_008,u
                    os9       I$Write   ; write Y bytes from X to path A
                    lbra      Branch_013 ; continue execution at Branch_013
Branch_032          leax      >WorkWord_013,u ; form the address >WorkWord_013,u in x
                    ldd       #1        ; set d to the constant 1
                    std       >WorkWord_014,u ; store d at >WorkWord_014,u
                    ldd       #0        ; set d to the constant 0
                    std       >WorkWord_015,u ; store d at >WorkWord_015,u
                    std       >WorkWord_016,u ; store d at >WorkWord_016,u
                    std       >WorkBuffer_008,u ; store d at >WorkBuffer_008,u
                    std       >WorkWord_017,u ; store d at >WorkWord_017,u
                    ldd       WorkWord_001,u ; load d from WorkWord_001,u
                    std       >WorkWord_013,u ; store d at >WorkWord_013,u
                    leax      >WorkBuffer_007,u ; form the address >WorkBuffer_007,u in x
                    os9       F$Time    ; read the current system date and time
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      >WorkWord_013,u ; form the address >WorkWord_013,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       WorkByte_008,u ; load a from WorkByte_008,u
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
Branch_013          clrb                ; clear b to zero and set the condition codes
                    ldy       WorkWord_001,u ; load y from WorkWord_001,u
                    os9       F$SUser   ; change the process user ID to Y
Branch_001          os9       F$Exit    ; terminate the process with status B
Routine_004         lbsr      Code_001  ; call subroutine Code_001
                    ldb       WorkByte_007,u ; load b from WorkByte_007,u
                    leay      b,y       ; form the address b,y in y
                    pshs      y         ; save y on the stack
                    negb                ; negate b
                    sex                 ; sign-extend b into d
                    leay      d,y       ; form the address d,y in y
                    clr       WorkByte_007,u ; clear WorkByte_007,u to zero and set the condition codes
                    cmpy      #0        ; compare y with #0 and set the condition codes
                    lbeq      Branch_034 ; branch when the values are equal or the result is zero; target Branch_034
                    pshs      y,x       ; save y,x on the stack
                    lda       #13       ; set a to the constant 13
Branch_035          sta       ,x+       ; store a at ,x+
                    leay      -$01,y    ; form the address -$01,y in y
                    bne       Branch_035 ; branch when the values differ or the result is nonzero; target Branch_035
                    puls      y,x       ; restore y,x from the stack
Branch_036          pshs      y,x       ; save y,x on the stack
                    leax      WorkByte_006,u ; form the address WorkByte_006,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcs       Branch_037 ; branch when carry reports an error or unsigned underflow; target Branch_037
                    lda       WorkByte_006,u ; load a from WorkByte_006,u
                    cmpa      #1        ; compare a with #1 and set the condition codes
                    beq       Branch_038 ; branch when the values are equal or the result is zero; target Branch_038
                    cmpa      #8        ; compare a with #8 and set the condition codes
                    beq       Branch_039 ; branch when the values are equal or the result is zero; target Branch_039
                    cmpa      #24       ; compare a with #24 and set the condition codes
                    beq       Branch_040 ; branch when the values are equal or the result is zero; target Branch_040
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      Branch_041 ; branch when the values are equal or the result is zero; target Branch_041
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    bcs       Branch_037 ; branch when carry reports an error or unsigned underflow; target Branch_037
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      y,x       ; restore y,x from the stack
                    lda       WorkByte_006,u ; load a from WorkByte_006,u
                    sta       ,x+       ; store a at ,x+
                    leay      -$01,y    ; form the address -$01,y in y
                    lbeq      Branch_042 ; branch when the values are equal or the result is zero; target Branch_042
                    bra       Branch_036 ; continue execution at Branch_036
Branch_037          puls      y,x       ; restore y,x from the stack
                    bra       Branch_036 ; continue execution at Branch_036
Branch_038          puls      y,x       ; restore y,x from the stack
                    leay      -$01,y    ; form the address -$01,y in y
                    beq       Branch_043 ; branch when the values are equal or the result is zero; target Branch_043
                    lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_044 ; branch when the values are equal or the result is zero; target Branch_044
                    pshs      y,x       ; save y,x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    bra       Branch_038 ; continue execution at Branch_038
Branch_044          leax      -$01,x    ; form the address -$01,x in x
Branch_043          leay      $01,y     ; form the address $01,y in y
                    lbra      Branch_036 ; continue execution at Branch_036
Branch_039          puls      y,x       ; restore y,x from the stack
                    leay      $01,y     ; form the address $01,y in y
                    cmpy      ,s        ; compare y with ,s and set the condition codes
                    bhi       Branch_045 ; branch when the unsigned value is higher; target Branch_045
                    pshs      y,x       ; save y,x on the stack
                    leax      >Data_007,pc ; form the address >Data_007,pc in x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      y,x       ; restore y,x from the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    lbra      Branch_036 ; continue execution at Branch_036
Branch_045          leay      -$01,y    ; form the address -$01,y in y
                    lbra      Branch_036 ; continue execution at Branch_036
Branch_040          puls      y,x       ; restore y,x from the stack
                    leay      $01,y     ; form the address $01,y in y
                    cmpy      ,s        ; compare y with ,s and set the condition codes
                    bhi       Branch_045 ; branch when the unsigned value is higher; target Branch_045
                    pshs      y,x       ; save y,x on the stack
                    leax      >Data_007,pc ; form the address >Data_007,pc in x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      y,x       ; restore y,x from the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    cmpy      ,s        ; compare y with ,s and set the condition codes
                    lbhi      Branch_036 ; branch when the unsigned value is higher; target Branch_036
                    pshs      y,x       ; save y,x on the stack
                    bra       Branch_040 ; continue execution at Branch_040
Branch_041          puls      y,x       ; restore y,x from the stack
Branch_034          lda       #13       ; set a to the constant 13
                    sta       ,x+       ; store a at ,x+
                    pshs      y,x       ; save y,x on the stack
                    leax      >Data_006,pc ; form the address >Data_006,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    puls      y,x       ; restore y,x from the stack
                    puls      d         ; restore d from the stack
                    pshs      y         ; save y on the stack
                    subd      ,s        ; subtract from d using ,s
                    leas      $02,s     ; adjust the system stack pointer
                    tfr       d,y       ; copy the register values specified by d,y
                    leay      $01,y     ; form the address $01,y in y
                    lbsr      Routine_005 ; call subroutine Routine_005
                    rts                 ; return to the caller
                    fcc       "50" ; store literal character data
Branch_042          puls      d         ; restore d from the stack
                    pshs      y         ; save y on the stack
                    subd      ,s        ; subtract from d using ,s
                    leas      $02,s     ; adjust the system stack pointer
                    addd      #1        ; add to d using #1
                    tfr       d,y       ; copy the register values specified by d,y
                    clrb                ; clear b to zero and set the condition codes
Branch_046          leay      -$01,y    ; form the address -$01,y in y
                    beq       Branch_047 ; branch when the values are equal or the result is zero; target Branch_047
                    lda       ,-x       ; load a from ,-x
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       Branch_048 ; branch when the values are equal or the result is zero; target Branch_048
                    pshs      y,x       ; save y,x on the stack
                    leax      >Data_007,pc ; form the address >Data_007,pc in x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    incb                ; increment b
                    puls      y,x       ; restore y,x from the stack
                    bra       Branch_046 ; continue execution at Branch_046
Branch_047          lda       #13       ; set a to the constant 13
                    sta       <$004F,x  ; store a at <$004F,x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    puls      y         ; restore y from the stack
                    rts                 ; return to the caller
Branch_048          lda       #13       ; set a to the constant 13
                    sta       ,x+       ; store a at ,x+
                    pshs      y,x       ; save y,x on the stack
                    stb       WorkByte_007,u ; store b at WorkByte_007,u
                    leay      >WorkBuffer_011,u ; form the address >WorkBuffer_011,u in y
Branch_049          lda       ,x+       ; load a from ,x+
                    sta       ,y+       ; store a at ,y+
                    decb                ; decrement b
                    bne       Branch_049 ; branch when the values differ or the result is nonzero; target Branch_049
                    leax      >Data_006,pc ; form the address >Data_006,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    puls      y,x       ; restore y,x from the stack
                    lbsr      Routine_005 ; call subroutine Routine_005
                    rts                 ; return to the caller
Code_001            pshs      y,x,d     ; save y,x,d on the stack
                    leax      >WorkByte_017,u ; form the address >WorkByte_017,u in x
                    clra                ; clear a to zero and set the condition codes
                    ldb       #0        ; set b to the constant 0
                    os9       I$GetStt  ; query status code B for path A
                    leax      -$20,x    ; form the address -$20,x in x
                    clr       <$0024,x  ; clear <$0024,x to zero and set the condition codes
                    leax      <$0020,x  ; form the address <$0020,x in x
                    os9       I$SetStt  ; apply status operation B to path A
                    puls      pc,y,x,d  ; restore pc,y,x,d and return to the caller
Routine_005         pshs      y,x,d     ; save y,x,d on the stack
                    leax      >WorkByte_017,u ; form the address >WorkByte_017,u in x
                    clra                ; clear a to zero and set the condition codes
                    ldb       #0        ; set b to the constant 0
                    os9       I$GetStt  ; query status code B for path A
                    leax      -$20,x    ; form the address -$20,x in x
                    lda       #1        ; set a to the constant 1
                    sta       <$0024,x  ; store a at <$0024,x
                    leax      <$0020,x  ; form the address <$0020,x in x
                    clra                ; clear a to zero and set the condition codes
                    os9       I$SetStt  ; apply status operation B to path A
                    puls      pc,y,x,d  ; restore pc,y,x,d and return to the caller
Routine_001         pshs      y         ; save y on the stack
Branch_050          lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      Branch_051 ; branch when the values are equal or the result is zero; target Branch_051
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_050 ; branch when carry reports an error or unsigned underflow; target Branch_050
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_050 ; branch when the unsigned value is higher; target Branch_050
                    leax      -$01,x    ; form the address -$01,x in x
Branch_052          lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_053 ; branch when carry reports an error or unsigned underflow; target Branch_053
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_053 ; branch when the unsigned value is higher; target Branch_053
                    bra       Branch_052 ; continue execution at Branch_052
Branch_053          pshs      x         ; save x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    clr       <WorkByte_013,u ; clear <WorkByte_013,u to zero and set the condition codes
                    clr       <WorkByte_014,u ; clear <WorkByte_014,u to zero and set the condition codes
                    ldd       #1        ; set d to the constant 1
                    std       <WorkWord_005,u ; store d at <WorkWord_005,u
Branch_054          lda       ,-x       ; load a from ,-x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_055 ; branch when carry reports an error or unsigned underflow; target Branch_055
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_055 ; branch when the unsigned value is higher; target Branch_055
                    suba      #48       ; subtract from a using #48
                    sta       WorkByte_005,u ; store a at WorkByte_005,u
                    ldd       #0        ; set d to the constant 0
Branch_056          tst       WorkByte_005,u ; set condition codes from WorkByte_005,u without changing it
                    beq       Branch_057 ; branch when the values are equal or the result is zero; target Branch_057
                    addd      <WorkWord_005,u ; add to d using <WorkWord_005,u
                    dec       WorkByte_005,u ; decrement the value at WorkByte_005,u
                    bra       Branch_056 ; continue execution at Branch_056
Branch_057          addd      <WorkByte_013,u ; add to d using <WorkByte_013,u
                    std       <WorkByte_013,u ; store d at <WorkByte_013,u
                    lda       #10       ; set a to the constant 10
                    sta       WorkByte_005,u ; store a at WorkByte_005,u
                    ldd       #0        ; set d to the constant 0
Branch_058          tst       WorkByte_005,u ; set condition codes from WorkByte_005,u without changing it
                    beq       Branch_059 ; branch when the values are equal or the result is zero; target Branch_059
                    addd      <WorkWord_005,u ; add to d using <WorkWord_005,u
                    dec       WorkByte_005,u ; decrement the value at WorkByte_005,u
                    bra       Branch_058 ; continue execution at Branch_058
Branch_059          std       <WorkWord_005,u ; store d at <WorkWord_005,u
                    bra       Branch_054 ; continue execution at Branch_054
Branch_055          ldd       <WorkByte_013,u ; load d from <WorkByte_013,u
                    puls      x         ; restore x from the stack
                    puls      pc,y      ; restore pc,y and return to the caller
Routine_003         pshs      y         ; save y on the stack
                    std       <WorkByte_013,u ; store d at <WorkByte_013,u
                    lda       #48       ; set a to the constant 48
                    sta       ,x        ; store a at ,x
                    sta       $01,x     ; store a at $01,x
                    ldd       #10       ; set d to the constant 10
                    std       <WorkWord_005,u ; store d at <WorkWord_005,u
                    ldd       <WorkByte_013,u ; load d from <WorkByte_013,u
                    bsr       Routine_006 ; call subroutine Routine_006
                    ldd       #1        ; set d to the constant 1
                    std       <WorkWord_005,u ; store d at <WorkWord_005,u
                    ldd       <WorkByte_013,u ; load d from <WorkByte_013,u
                    bsr       Routine_006 ; call subroutine Routine_006
                    lda       #13       ; set a to the constant 13
                    sta       ,x        ; store a at ,x
                    puls      pc,y      ; restore pc,y and return to the caller
Routine_006         subd      <WorkWord_005,u ; subtract from d using <WorkWord_005,u
                    bcs       Branch_060 ; branch when carry reports an error or unsigned underflow; target Branch_060
                    inc       ,x        ; increment the value at ,x
                    bra       Routine_006 ; continue execution at Routine_006
Branch_060          addd      <WorkWord_005,u ; add to d using <WorkWord_005,u
                    std       <WorkByte_013,u ; store d at <WorkByte_013,u
                    leax      $01,x     ; form the address $01,x in x
                    rts                 ; return to the caller
Branch_051          ldd       #-1       ; set d to the constant -1
                    puls      pc,y      ; restore pc,y and return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
