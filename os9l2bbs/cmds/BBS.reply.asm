**********************************************************************
* BBS.reply - OS-9 Level 2 BBS command
*
* Syntax: BBS.reply
* Purpose: Compose a response linked to an existing message thread.
* Reads the parent index/body record and appends a new message.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
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

WorkByte_001        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_002        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_003        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_004        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_005        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_006        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_007        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_008        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_001        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_002        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_009        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_010        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_011        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_012        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_003        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_004        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_005        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_013        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_014        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_006        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_007        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_001      rmb       200       ; reserve 200 byte(s) in the module workspace
WorkByte_015        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_002      rmb       5         ; reserve 5 byte(s) in the module workspace
WorkByte_016        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_008        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_009        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_003      rmb       60        ; reserve 60 byte(s) in the module workspace
WorkWord_010        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_011        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_004      rmb       20        ; reserve 20 byte(s) in the module workspace
WorkBuffer_005      rmb       30        ; reserve 30 byte(s) in the module workspace
WorkBuffer_006      rmb       6         ; reserve 6 byte(s) in the module workspace
WorkWord_012        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_013        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_014        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_015        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_007      rmb       6         ; reserve 6 byte(s) in the module workspace
WorkWord_016        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_017        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_018        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_008      rmb       16        ; reserve 16 byte(s) in the module workspace
WorkBuffer_009      rmb       8000      ; reserve 8000 byte(s) in the module workspace
WorkBuffer_010      rmb       80        ; reserve 80 byte(s) in the module workspace
WorkBuffer_011      rmb       32        ; reserve 32 byte(s) in the module workspace
WorkByte_017        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_012      rmb       399       ; reserve 399 byte(s) in the module workspace
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
Text_001            fcc       "BBS.msg.inx" ; store literal character data
                    fcb       $0D       ; store byte data
Text_002            fcc       "BBS.msg" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $0A       ; store byte data
                    fcc       "Enter subject of message" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $0A       ; store byte data
                    fcb       $3E       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $1C       ; store byte data
Data_001            fcb       $0A       ; store byte data
                    fcb       $0A       ; store byte data
                    fcc       "    Please enter message now            (Blank line ends)" ; store literal character data
                    fcb       $0D       ; store byte data
Text_003            fcc       "----------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
Text_004            fcc       "/dd/bbs/BBS.alias" ; store literal character data
                    fcb       $0D       ; store byte data
Data_002            fcb       $0A       ; store byte data
                    fcc       "[A]bort [D]one [E]dit [C]ontinue or [L]ist" ; store literal character data
                    fcb       $0D       ; store byte data
Text_005            fcc       "Enter line #" ; store literal character data
                    fcb       $0D       ; store byte data
Data_003            fcb       $3E       ; store byte data
Data_004            fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
Data_005            fcb       $08       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $08       ; store byte data
Text_006            fcc       "/dd/bbs/BBS.userstats" ; store literal character data
                    fcb       $0D       ; store byte data
Text_007            fcc       "User name not found!" ; store literal character data
                    fcb       $0D       ; store byte data
Text_008            fcc       "Address message to (BLANK for ALL)" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $0A       ; store byte data
start               stx       WorkWord_001,u ; store x at WorkWord_001,u
                    clr       >WorkByte_016,u ; clear >WorkByte_016,u to zero and set the condition codes
                    clr       >WorkByte_015,u ; clear >WorkByte_015,u to zero and set the condition codes
                    clr       WorkByte_007,u ; clear WorkByte_007,u to zero and set the condition codes
                    os9       F$ID      ; retrieve the current process and user IDs
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    sty       WorkWord_002,u ; store y at WorkWord_002,u
                    ldy       #0        ; set y to the constant 0
                    os9       F$SUser   ; change the process user ID to Y
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      >Text_001,pc ; form the address >Text_001,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    sta       WorkByte_001,u ; store a at WorkByte_001,u
                    leax      >WorkWord_008,u ; form the address >WorkWord_008,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    lda       #6        ; set a to the constant 6
                    sta       WorkByte_004,u ; store a at WorkByte_004,u
                    ldd       >WorkWord_008,u ; load d from >WorkWord_008,u
                    addd      #1        ; add to d using #1
                    std       >WorkWord_008,u ; store d at >WorkWord_008,u
                    clr       WorkByte_011,u ; clear WorkByte_011,u to zero and set the condition codes
                    clr       WorkByte_012,u ; clear WorkByte_012,u to zero and set the condition codes
Branch_002          aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    rol       WorkByte_012,u ; rotate left through carry the value at WorkByte_012,u
                    dec       WorkByte_004,u ; decrement the value at WorkByte_004,u
                    bne       Branch_002 ; branch when the values differ or the result is nonzero; target Branch_002
                    std       <WorkWord_003,u ; store d at <WorkWord_003,u
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    ldx       WorkByte_011,u ; load x from WorkByte_011,u
                    pshs      u         ; save u on the stack
                    ldu       <WorkWord_003,u ; load u from <WorkWord_003,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    puls      u         ; restore u from the stack
                    leax      >WorkBuffer_006,u ; form the address >WorkBuffer_006,u in x
                    os9       F$Time    ; read the current system date and time
                    ldx       WorkWord_001,u ; load x from WorkWord_001,u
                    leay      >WorkBuffer_005,u ; form the address >WorkBuffer_005,u in y
                    ldb       #30       ; set b to the constant 30
Branch_003          lda       ,x+       ; load a from ,x+
                    sta       ,y+       ; store a at ,y+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_004 ; branch when the values are equal or the result is zero; target Branch_004
                    decb                ; decrement b
                    bne       Branch_003 ; branch when the values differ or the result is nonzero; target Branch_003
Branch_004          leax      >Text_004,pc ; form the address >Text_004,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    sta       WorkByte_003,u ; store a at WorkByte_003,u
Branch_005          leax      >Text_008,pc ; form the address >Text_008,pc in x
                    ldy       #36       ; set y to the constant 36
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >WorkByte_017,u ; form the address >WorkByte_017,u in x
                    ldy       #200      ; set y to the constant 200
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    ble       Branch_006 ; branch when the signed value is less than or equal; target Branch_006
Branch_007          lda       ,x+       ; load a from ,x+
                    anda      #223      ; mask a using #223
                    sta       -$01,x    ; store a at -$01,x
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       Branch_007 ; branch when the values differ or the result is nonzero; target Branch_007
Branch_008          leax      <WorkBuffer_001,u ; form the address <WorkBuffer_001,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       WorkByte_003,u ; load a from WorkByte_003,u
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    bcs       Branch_009 ; branch when carry reports an error or unsigned underflow; target Branch_009
                    leay      >WorkByte_017,u ; form the address >WorkByte_017,u in y
                    leax      <WorkBuffer_001,u ; form the address <WorkBuffer_001,u in x
Branch_010          lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    beq       Branch_011 ; branch when the values are equal or the result is zero; target Branch_011
                    anda      #223      ; mask a using #223
                    cmpa      ,y+       ; compare a with ,y+ and set the condition codes
                    bne       Branch_008 ; branch when the values differ or the result is nonzero; target Branch_008
                    bra       Branch_010 ; continue execution at Branch_010
Branch_011          lda       ,y+       ; load a from ,y+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       Branch_008 ; branch when the values differ or the result is nonzero; target Branch_008
                    lbsr      Routine_001 ; call subroutine Routine_001
                    std       >WorkWord_013,u ; store d at >WorkWord_013,u
                    lda       WorkByte_003,u ; load a from WorkByte_003,u
                    pshs      u         ; save u on the stack
                    ldu       #0        ; set u to the constant 0
                    ldx       #0        ; set x to the constant 0
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    puls      u         ; restore u from the stack
                    bra       Branch_012 ; continue execution at Branch_012
Branch_009          leax      >Text_007,pc ; form the address >Text_007,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       WorkByte_003,u ; load a from WorkByte_003,u
                    pshs      u         ; save u on the stack
                    ldu       #0        ; set u to the constant 0
                    ldx       #0        ; set x to the constant 0
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbra      Branch_005 ; continue execution at Branch_005
Branch_006          ldd       #-1       ; set d to the constant -1
                    std       >WorkWord_013,u ; store d at >WorkWord_013,u
Branch_012          leax      >Data_001,pc ; form the address >Data_001,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      >Text_003,pc ; form the address >Text_003,pc in x
                    ldy       #80       ; set y to the constant 80
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    ldd       #0        ; set d to the constant 0
                    std       WorkByte_009,u ; store d at WorkByte_009,u
Branch_013          ldd       WorkByte_009,u ; load d from WorkByte_009,u
                    addd      #1        ; add to d using #1
                    std       WorkByte_009,u ; store d at WorkByte_009,u
                    cmpd      #99       ; compare d with #99 and set the condition codes
                    bge       Branch_014 ; branch when the signed value is greater than or equal; target Branch_014
                    lbsr      Routine_002 ; call subroutine Routine_002
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bls       Branch_014 ; branch when the unsigned value is lower or equal; target Branch_014
                    bra       Branch_013 ; continue execution at Branch_013
Branch_014          leax      >Data_002,pc ; form the address >Data_002,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Data_003,pc ; form the address >Data_003,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      WorkByte_006,u ; form the address WorkByte_006,u in x
                    clra                ; clear a to zero and set the condition codes
                    ldy       #1        ; set y to the constant 1
                    os9       I$Read    ; read up to Y bytes from path A into X
                    leax      >Data_004,pc ; form the address >Data_004,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       WorkByte_006,u ; load a from WorkByte_006,u
                    anda      #223      ; mask a using #223
                    cmpa      #65       ; compare a with #65 and set the condition codes
                    lbeq      Branch_015 ; branch when the values are equal or the result is zero; target Branch_015
                    cmpa      #68       ; compare a with #68 and set the condition codes
                    lbeq      Branch_016 ; branch when the values are equal or the result is zero; target Branch_016
                    cmpa      #69       ; compare a with #69 and set the condition codes
                    beq       Branch_017 ; branch when the values are equal or the result is zero; target Branch_017
                    cmpa      #67       ; compare a with #67 and set the condition codes
                    beq       Branch_018 ; branch when the values are equal or the result is zero; target Branch_018
                    cmpa      #76       ; compare a with #76 and set the condition codes
                    beq       Branch_019 ; branch when the values are equal or the result is zero; target Branch_019
                    bra       Branch_014 ; continue execution at Branch_014
Branch_018          ldd       WorkByte_009,u ; load d from WorkByte_009,u
                    subd      #1        ; subtract from d using #1
                    std       WorkByte_009,u ; store d at WorkByte_009,u
                    bra       Branch_013 ; continue execution at Branch_013
Branch_017          leax      >Text_005,pc ; form the address >Text_005,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Data_003,pc ; form the address >Data_003,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    clra                ; clear a to zero and set the condition codes
                    leax      >WorkBuffer_002,u ; form the address >WorkBuffer_002,u in x
                    ldy       #3        ; set y to the constant 3
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lbsr      Routine_001 ; call subroutine Routine_001
                    cmpd      WorkByte_009,u ; compare d with WorkByte_009,u and set the condition codes
                    lbcc      Branch_014 ; branch when carry is clear; target Branch_014
                    std       <WorkWord_007,u ; store d at <WorkWord_007,u
                    leax      >WorkBuffer_002,u ; form the address >WorkBuffer_002,u in x
                    lbsr      Routine_003 ; call subroutine Routine_003
                    leax      >WorkBuffer_002,u ; form the address >WorkBuffer_002,u in x
                    lda       #58       ; set a to the constant 58
                    sta       $02,x     ; store a at $02,x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    ldd       <WorkWord_007,u ; load d from <WorkWord_007,u
                    leax      >WorkBuffer_009,u ; form the address >WorkBuffer_009,u in x
                    lda       #80       ; set a to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      d,x       ; form the address d,x in x
                    ldy       #80       ; set y to the constant 80
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    ldd       <WorkWord_007,u ; load d from <WorkWord_007,u
                    bsr       Routine_002 ; call subroutine Routine_002
                    lbra      Branch_014 ; continue execution at Branch_014
Branch_019          ldd       #0        ; set d to the constant 0
                    std       WorkByte_009,u ; store d at WorkByte_009,u
Branch_020          ldd       WorkByte_009,u ; load d from WorkByte_009,u
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
                    leax      >WorkBuffer_009,u ; form the address >WorkBuffer_009,u in x
                    ldd       WorkByte_009,u ; load d from WorkByte_009,u
                    lda       #80       ; set a to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      d,x       ; form the address d,x in x
                    ldy       #80       ; set y to the constant 80
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bhi       Branch_020 ; branch when the unsigned value is higher; target Branch_020
                    lbra      Branch_014 ; continue execution at Branch_014
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
                    leax      >WorkBuffer_010,u ; form the address >WorkBuffer_010,u in x
                    ldb       WorkByte_007,u ; load b from WorkByte_007,u
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      d         ; restore d from the stack
                    lda       #80       ; set a to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      >WorkBuffer_009,u ; form the address >WorkBuffer_009,u in x
                    leax      d,x       ; form the address d,x in x
                    leay      >WorkBuffer_010,u ; form the address >WorkBuffer_010,u in y
                    ldb       #80       ; set b to the constant 80
                    lda       WorkByte_007,u ; load a from WorkByte_007,u
                    beq       Branch_021 ; branch when the values are equal or the result is zero; target Branch_021
                    sta       <WorkByte_013,u ; store a at <WorkByte_013,u
Branch_022          lda       ,y+       ; load a from ,y+
                    sta       ,x+       ; store a at ,x+
                    decb                ; decrement b
                    dec       <WorkByte_013,u ; decrement the value at <WorkByte_013,u
                    bne       Branch_022 ; branch when the values differ or the result is nonzero; target Branch_022
Branch_021          clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    lbsr      Routine_004 ; call subroutine Routine_004
                    rts                 ; return to the caller
Branch_016          leax      <WorkBuffer_001,u ; form the address <WorkBuffer_001,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       WorkByte_003,u ; load a from WorkByte_003,u
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
Branch_023          lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    bne       Branch_023 ; branch when the values differ or the result is nonzero; target Branch_023
                    lbsr      Routine_001 ; call subroutine Routine_001
                    cmpd      WorkWord_002,u ; compare d with WorkWord_002,u and set the condition codes
                    bne       Branch_016 ; branch when the values differ or the result is nonzero; target Branch_016
                    leax      <WorkBuffer_001,u ; form the address <WorkBuffer_001,u in x
                    leay      >WorkBuffer_004,u ; form the address >WorkBuffer_004,u in y
Branch_024          lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    beq       Branch_025 ; branch when the values are equal or the result is zero; target Branch_025
                    sta       ,y+       ; store a at ,y+
                    bra       Branch_024 ; continue execution at Branch_024
Branch_025          lda       #13       ; set a to the constant 13
                    sta       ,y        ; store a at ,y
                    ldd       >WorkWord_009,u ; load d from >WorkWord_009,u
                    std       >WorkWord_010,u ; store d at >WorkWord_010,u
                    ldd       >WorkBuffer_003,u ; load d from >WorkBuffer_003,u
                    std       >WorkWord_011,u ; store d at >WorkWord_011,u
                    ldd       WorkWord_002,u ; load d from WorkWord_002,u
                    std       >WorkWord_012,u ; store d at >WorkWord_012,u
                    leax      >WorkWord_010,u ; form the address >WorkWord_010,u in x
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
                    ldx       >WorkWord_009,u ; load x from >WorkWord_009,u
                    lda       WorkByte_002,u ; load a from WorkByte_002,u
                    ldu       >WorkBuffer_003,u ; load u from >WorkBuffer_003,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    puls      u         ; restore u from the stack
                    lda       #0        ; set a to the constant 0
                    sta       <WorkWord_004,u ; store a at <WorkWord_004,u
                    ldd       #1        ; set d to the constant 1
                    std       <WorkWord_005,u ; store d at <WorkWord_005,u
Branch_026          lda       <WorkWord_004,u ; load a from <WorkWord_004,u
                    inca                ; increment a
                    sta       <WorkWord_004,u ; store a at <WorkWord_004,u
                    cmpa      WorkByte_010,u ; compare a with WorkByte_010,u and set the condition codes
                    bhi       Branch_027 ; branch when the unsigned value is higher; target Branch_027
                    ldb       #80       ; set b to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      >WorkBuffer_009,u ; form the address >WorkBuffer_009,u in x
                    leax      d,x       ; form the address d,x in x
                    ldy       #80       ; set y to the constant 80
                    lda       WorkByte_002,u ; load a from WorkByte_002,u
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bls       Branch_027 ; branch when the unsigned value is lower or equal; target Branch_027
                    tfr       y,d       ; copy the register values specified by y,d
                    addd      <WorkWord_005,u ; add to d using <WorkWord_005,u
                    std       <WorkWord_005,u ; store d at <WorkWord_005,u
                    bra       Branch_026 ; continue execution at Branch_026
Branch_027          ldd       >WorkBuffer_003,u ; load d from >WorkBuffer_003,u
                    addd      <WorkWord_005,u ; add to d using <WorkWord_005,u
                    std       >WorkBuffer_003,u ; store d at >WorkBuffer_003,u
                    bcc       Branch_028 ; branch when carry is clear; target Branch_028
                    ldd       >WorkWord_009,u ; load d from >WorkWord_009,u
                    addd      #1        ; add to d using #1
                    std       >WorkWord_009,u ; store d at >WorkWord_009,u
Branch_028          pshs      u         ; save u on the stack
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    ldx       #0        ; set x to the constant 0
                    ldu       #0        ; set u to the constant 0
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    puls      u         ; restore u from the stack
                    leax      >WorkWord_008,u ; form the address >WorkWord_008,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      >Text_006,pc ; form the address >Text_006,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    bcc       Branch_029 ; branch when carry is clear; target Branch_029
                    ldb       #27       ; set b to the constant 27
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
Branch_029          sta       WorkByte_008,u ; store a at WorkByte_008,u
Branch_030          leax      >WorkWord_014,u ; form the address >WorkWord_014,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       WorkByte_008,u ; load a from WorkByte_008,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcs       Branch_031 ; branch when carry reports an error or unsigned underflow; target Branch_031
                    ldd       >WorkWord_014,u ; load d from >WorkWord_014,u
                    cmpd      WorkWord_002,u ; compare d with WorkWord_002,u and set the condition codes
                    bne       Branch_030 ; branch when the values differ or the result is nonzero; target Branch_030
                    bra       Branch_032 ; continue execution at Branch_032
Branch_031          cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      Branch_001 ; branch when the values differ or the result is nonzero; target Branch_001
                    lbra      Branch_033 ; continue execution at Branch_033
Branch_032          ldd       >WorkWord_016,u ; load d from >WorkWord_016,u
                    addd      #1        ; add to d using #1
                    std       >WorkWord_016,u ; store d at >WorkWord_016,u
                    lda       WorkByte_008,u ; load a from WorkByte_008,u
                    ldb       #5        ; set b to the constant 5
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; query status code B for path A
                    tfr       u,d       ; copy the register values specified by u,d
                    subd      #32       ; subtract from d using #32
                    bge       Branch_034 ; branch when the signed value is greater than or equal; target Branch_034
                    leax      -$01,x    ; form the address -$01,x in x
Branch_034          ldu       ,s        ; load u from the current stack frame at ,s
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       WorkByte_008,u ; load a from WorkByte_008,u
                    tfr       y,u       ; copy the register values specified by y,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    puls      u         ; restore u from the stack
                    leax      >WorkWord_014,u ; form the address >WorkWord_014,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       WorkByte_008,u ; load a from WorkByte_008,u
                    os9       I$Write   ; write Y bytes from X to path A
                    lbra      Branch_035 ; continue execution at Branch_035
Branch_033          leax      >WorkWord_014,u ; form the address >WorkWord_014,u in x
                    ldd       #1        ; set d to the constant 1
                    std       >WorkWord_015,u ; store d at >WorkWord_015,u
                    ldd       #0        ; set d to the constant 0
                    std       >WorkWord_016,u ; store d at >WorkWord_016,u
                    std       >WorkWord_017,u ; store d at >WorkWord_017,u
                    std       >WorkBuffer_008,u ; store d at >WorkBuffer_008,u
                    std       >WorkWord_018,u ; store d at >WorkWord_018,u
                    ldd       WorkWord_002,u ; load d from WorkWord_002,u
                    std       >WorkWord_014,u ; store d at >WorkWord_014,u
                    leax      >WorkBuffer_007,u ; form the address >WorkBuffer_007,u in x
                    os9       F$Time    ; read the current system date and time
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      >WorkWord_014,u ; form the address >WorkWord_014,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       WorkByte_008,u ; load a from WorkByte_008,u
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
Branch_035          clrb                ; clear b to zero and set the condition codes
                    ldy       WorkWord_002,u ; load y from WorkWord_002,u
                    os9       F$SUser   ; change the process user ID to Y
Branch_001          os9       F$Exit    ; terminate the process with status B
Branch_015          ldb       #1        ; set b to the constant 1
                    bra       Branch_001 ; continue execution at Branch_001
Routine_004         lbsr      Code_001  ; call subroutine Code_001
                    ldb       WorkByte_007,u ; load b from WorkByte_007,u
                    leay      b,y       ; form the address b,y in y
                    pshs      y         ; save y on the stack
                    negb                ; negate b
                    sex                 ; sign-extend b into d
                    leay      d,y       ; form the address d,y in y
                    clr       WorkByte_007,u ; clear WorkByte_007,u to zero and set the condition codes
                    cmpy      #0        ; compare y with #0 and set the condition codes
                    lbeq      Branch_036 ; branch when the values are equal or the result is zero; target Branch_036
                    pshs      y,x       ; save y,x on the stack
                    lda       #13       ; set a to the constant 13
Branch_037          sta       ,x+       ; store a at ,x+
                    leay      -$01,y    ; form the address -$01,y in y
                    bne       Branch_037 ; branch when the values differ or the result is nonzero; target Branch_037
                    puls      y,x       ; restore y,x from the stack
Branch_038          pshs      y,x       ; save y,x on the stack
                    leax      WorkByte_006,u ; form the address WorkByte_006,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcs       Branch_039 ; branch when carry reports an error or unsigned underflow; target Branch_039
                    lda       WorkByte_006,u ; load a from WorkByte_006,u
                    cmpa      #1        ; compare a with #1 and set the condition codes
                    beq       Branch_040 ; branch when the values are equal or the result is zero; target Branch_040
                    cmpa      #8        ; compare a with #8 and set the condition codes
                    beq       Branch_041 ; branch when the values are equal or the result is zero; target Branch_041
                    cmpa      #24       ; compare a with #24 and set the condition codes
                    beq       Branch_042 ; branch when the values are equal or the result is zero; target Branch_042
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      Branch_043 ; branch when the values are equal or the result is zero; target Branch_043
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    bcs       Branch_039 ; branch when carry reports an error or unsigned underflow; target Branch_039
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      y,x       ; restore y,x from the stack
                    lda       WorkByte_006,u ; load a from WorkByte_006,u
                    sta       ,x+       ; store a at ,x+
                    leay      -$01,y    ; form the address -$01,y in y
                    lbeq      Branch_044 ; branch when the values are equal or the result is zero; target Branch_044
                    bra       Branch_038 ; continue execution at Branch_038
Branch_039          puls      y,x       ; restore y,x from the stack
                    bra       Branch_038 ; continue execution at Branch_038
Branch_040          puls      y,x       ; restore y,x from the stack
                    leay      -$01,y    ; form the address -$01,y in y
                    beq       Branch_045 ; branch when the values are equal or the result is zero; target Branch_045
                    lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_046 ; branch when the values are equal or the result is zero; target Branch_046
                    pshs      y,x       ; save y,x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    bra       Branch_040 ; continue execution at Branch_040
Branch_046          leax      -$01,x    ; form the address -$01,x in x
Branch_045          leay      $01,y     ; form the address $01,y in y
                    lbra      Branch_038 ; continue execution at Branch_038
Branch_041          puls      y,x       ; restore y,x from the stack
                    leay      $01,y     ; form the address $01,y in y
                    cmpy      ,s        ; compare y with ,s and set the condition codes
                    bhi       Branch_047 ; branch when the unsigned value is higher; target Branch_047
                    pshs      y,x       ; save y,x on the stack
                    leax      >Data_005,pc ; form the address >Data_005,pc in x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      y,x       ; restore y,x from the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    lbra      Branch_038 ; continue execution at Branch_038
Branch_047          leay      -$01,y    ; form the address -$01,y in y
                    lbra      Branch_038 ; continue execution at Branch_038
Branch_042          puls      y,x       ; restore y,x from the stack
                    leay      $01,y     ; form the address $01,y in y
                    cmpy      ,s        ; compare y with ,s and set the condition codes
                    bhi       Branch_047 ; branch when the unsigned value is higher; target Branch_047
                    pshs      y,x       ; save y,x on the stack
                    leax      >Data_005,pc ; form the address >Data_005,pc in x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      y,x       ; restore y,x from the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    cmpy      ,s        ; compare y with ,s and set the condition codes
                    lbhi      Branch_038 ; branch when the unsigned value is higher; target Branch_038
                    pshs      y,x       ; save y,x on the stack
                    bra       Branch_042 ; continue execution at Branch_042
Branch_043          puls      y,x       ; restore y,x from the stack
Branch_036          lda       #13       ; set a to the constant 13
                    sta       ,x+       ; store a at ,x+
                    pshs      y,x       ; save y,x on the stack
                    leax      >Data_004,pc ; form the address >Data_004,pc in x
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
Branch_044          puls      d         ; restore d from the stack
                    pshs      y         ; save y on the stack
                    subd      ,s        ; subtract from d using ,s
                    leas      $02,s     ; adjust the system stack pointer
                    addd      #1        ; add to d using #1
                    tfr       d,y       ; copy the register values specified by d,y
                    clrb                ; clear b to zero and set the condition codes
Branch_048          leay      -$01,y    ; form the address -$01,y in y
                    beq       Branch_049 ; branch when the values are equal or the result is zero; target Branch_049
                    lda       ,-x       ; load a from ,-x
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       Branch_050 ; branch when the values are equal or the result is zero; target Branch_050
                    pshs      y,x       ; save y,x on the stack
                    leax      >Data_005,pc ; form the address >Data_005,pc in x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    incb                ; increment b
                    puls      y,x       ; restore y,x from the stack
                    bra       Branch_048 ; continue execution at Branch_048
Branch_049          lda       #13       ; set a to the constant 13
                    sta       <$004F,x  ; store a at <$004F,x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    puls      y         ; restore y from the stack
                    rts                 ; return to the caller
Branch_050          lda       #13       ; set a to the constant 13
                    sta       ,x+       ; store a at ,x+
                    pshs      y,x       ; save y,x on the stack
                    stb       WorkByte_007,u ; store b at WorkByte_007,u
                    leay      >WorkBuffer_010,u ; form the address >WorkBuffer_010,u in y
Branch_051          lda       ,x+       ; load a from ,x+
                    sta       ,y+       ; store a at ,y+
                    decb                ; decrement b
                    bne       Branch_051 ; branch when the values differ or the result is nonzero; target Branch_051
                    leax      >Data_004,pc ; form the address >Data_004,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    puls      y,x       ; restore y,x from the stack
                    lbsr      Routine_005 ; call subroutine Routine_005
                    rts                 ; return to the caller
Code_001            pshs      y,x,d     ; save y,x,d on the stack
                    leax      >WorkBuffer_011,u ; form the address >WorkBuffer_011,u in x
                    clra                ; clear a to zero and set the condition codes
                    ldb       #0        ; set b to the constant 0
                    os9       I$GetStt  ; query status code B for path A
                    leax      -$20,x    ; form the address -$20,x in x
                    clr       <$0024,x  ; clear <$0024,x to zero and set the condition codes
                    leax      <$0020,x  ; form the address <$0020,x in x
                    os9       I$SetStt  ; apply status operation B to path A
                    puls      pc,y,x,d  ; restore pc,y,x,d and return to the caller
Routine_005         pshs      y,x,d     ; save y,x,d on the stack
                    leax      >WorkBuffer_011,u ; form the address >WorkBuffer_011,u in x
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
Branch_052          lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      Branch_053 ; branch when the values are equal or the result is zero; target Branch_053
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_052 ; branch when carry reports an error or unsigned underflow; target Branch_052
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_052 ; branch when the unsigned value is higher; target Branch_052
                    leax      -$01,x    ; form the address -$01,x in x
Branch_054          lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_055 ; branch when carry reports an error or unsigned underflow; target Branch_055
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_055 ; branch when the unsigned value is higher; target Branch_055
                    bra       Branch_054 ; continue execution at Branch_054
Branch_055          pshs      x         ; save x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    clr       <WorkByte_013,u ; clear <WorkByte_013,u to zero and set the condition codes
                    clr       <WorkByte_014,u ; clear <WorkByte_014,u to zero and set the condition codes
                    ldd       #1        ; set d to the constant 1
                    std       <WorkWord_006,u ; store d at <WorkWord_006,u
Branch_056          lda       ,-x       ; load a from ,-x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_057 ; branch when carry reports an error or unsigned underflow; target Branch_057
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_057 ; branch when the unsigned value is higher; target Branch_057
                    suba      #48       ; subtract from a using #48
                    sta       WorkByte_005,u ; store a at WorkByte_005,u
                    ldd       #0        ; set d to the constant 0
Branch_058          tst       WorkByte_005,u ; set condition codes from WorkByte_005,u without changing it
                    beq       Branch_059 ; branch when the values are equal or the result is zero; target Branch_059
                    addd      <WorkWord_006,u ; add to d using <WorkWord_006,u
                    dec       WorkByte_005,u ; decrement the value at WorkByte_005,u
                    bra       Branch_058 ; continue execution at Branch_058
Branch_059          addd      <WorkByte_013,u ; add to d using <WorkByte_013,u
                    std       <WorkByte_013,u ; store d at <WorkByte_013,u
                    lda       #10       ; set a to the constant 10
                    sta       WorkByte_005,u ; store a at WorkByte_005,u
                    ldd       #0        ; set d to the constant 0
Branch_060          tst       WorkByte_005,u ; set condition codes from WorkByte_005,u without changing it
                    beq       Branch_061 ; branch when the values are equal or the result is zero; target Branch_061
                    addd      <WorkWord_006,u ; add to d using <WorkWord_006,u
                    dec       WorkByte_005,u ; decrement the value at WorkByte_005,u
                    bra       Branch_060 ; continue execution at Branch_060
Branch_061          std       <WorkWord_006,u ; store d at <WorkWord_006,u
                    bra       Branch_056 ; continue execution at Branch_056
Branch_057          ldd       <WorkByte_013,u ; load d from <WorkByte_013,u
                    puls      x         ; restore x from the stack
                    puls      pc,y      ; restore pc,y and return to the caller
Routine_003         pshs      y         ; save y on the stack
                    std       <WorkByte_013,u ; store d at <WorkByte_013,u
                    lda       #48       ; set a to the constant 48
                    sta       ,x        ; store a at ,x
                    sta       $01,x     ; store a at $01,x
                    ldd       #10       ; set d to the constant 10
                    std       <WorkWord_006,u ; store d at <WorkWord_006,u
                    ldd       <WorkByte_013,u ; load d from <WorkByte_013,u
                    bsr       Routine_006 ; call subroutine Routine_006
                    ldd       #1        ; set d to the constant 1
                    std       <WorkWord_006,u ; store d at <WorkWord_006,u
                    ldd       <WorkByte_013,u ; load d from <WorkByte_013,u
                    bsr       Routine_006 ; call subroutine Routine_006
                    lda       #13       ; set a to the constant 13
                    sta       ,x        ; store a at ,x
                    puls      pc,y      ; restore pc,y and return to the caller
Routine_006         subd      <WorkWord_006,u ; subtract from d using <WorkWord_006,u
                    bcs       Branch_062 ; branch when carry reports an error or unsigned underflow; target Branch_062
                    inc       ,x        ; increment the value at ,x
                    bra       Routine_006 ; continue execution at Routine_006
Branch_062          addd      <WorkWord_006,u ; add to d using <WorkWord_006,u
                    std       <WorkByte_013,u ; store d at <WorkByte_013,u
                    leax      $01,x     ; form the address $01,x in x
                    rts                 ; return to the caller
Branch_053          ldd       #-1       ; set d to the constant -1
                    puls      pc,y      ; restore pc,y and return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
