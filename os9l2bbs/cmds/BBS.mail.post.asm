**********************************************************************
* BBS.mail.post - OS-9 Level 2 BBS command
*
* Syntax: BBS.mail.post
* Purpose: Resolve a recipient and append private mail using the common line editor.
* Data: BBS.mail, BBS.mail.inx, and /dd/bbs/bbs.alias.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       BBS.mail.post
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
WorkWord_001        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_008        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_009        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_010        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_011        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_002        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_003        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_004        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_012        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_013        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_005        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_006        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_001      rmb       200       ; reserve 200 byte(s) in the module workspace
WorkBuffer_002      rmb       200       ; reserve 200 byte(s) in the module workspace
WorkByte_014        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_003      rmb       5         ; reserve 5 byte(s) in the module workspace
WorkByte_015        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_007        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_008        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_004      rmb       60        ; reserve 60 byte(s) in the module workspace
WorkWord_009        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_010        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_005      rmb       20        ; reserve 20 byte(s) in the module workspace
WorkBuffer_006      rmb       30        ; reserve 30 byte(s) in the module workspace
WorkBuffer_007      rmb       6         ; reserve 6 byte(s) in the module workspace
WorkWord_011        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_012        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_008      rmb       8000      ; reserve 8000 byte(s) in the module workspace
WorkBuffer_009      rmb       80        ; reserve 80 byte(s) in the module workspace
WorkByte_016        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_010      rmb       231       ; reserve 231 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.mail.post/ ; store an OS-9 high-bit-terminated string
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
Text_001            fcc       "BBS.mail.inx" ; store literal character data
                    fcb       $0D       ; store byte data
Text_002            fcc       "BBS.mail" ; store literal character data
                    fcb       $0D       ; store byte data
Text_003            fcc       "Enter subject of message" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $0A       ; store byte data
                    fcc       ">" ; store literal character data
Data_001            fcb       $00       ; store byte data
                    fcb       $1B       ; store byte data
Data_002            fcb       $0A       ; store byte data
                    fcb       $0A       ; store byte data
                    fcc       "    Please enter message now            (Blank line ends)" ; store literal character data
                    fcb       $0D       ; store byte data
Text_004            fcc       "----------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
Text_005            fcc       "/dd/bbs/BBS.alias" ; store literal character data
                    fcb       $0D       ; store byte data
Data_003            fcb       $0A       ; store byte data
                    fcc       "[A]bort [D]one [E]dit [C]ontinue or [L]ist" ; store literal character data
                    fcb       $0D       ; store byte data
Text_006            fcc       "Enter line #" ; store literal character data
                    fcb       $0D       ; store byte data
Text_007            fcc       ">" ; store literal character data
Data_004            fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
Text_008            fcc       "Sorry...cannot locate that name" ; store literal character data
                    fcb       $0D       ; store byte data
Text_009            fcc       "Enter the name of the Person to send mail to" ; store literal character data
                    fcb       $0D       ; store byte data
Data_005            fcb       $08       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $08       ; store byte data

start               clr       >WorkByte_015,u ; clear >WorkByte_015,u to zero and set the condition codes
                    clr       >WorkByte_014,u ; clear >WorkByte_014,u to zero and set the condition codes
                    clr       WorkByte_007,u ; clear WorkByte_007,u to zero and set the condition codes
                    os9       F$ID      ; retrieve the current process and user IDs
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    sty       WorkWord_001,u ; store y at WorkWord_001,u
                    ldy       #0        ; set y to the constant 0
                    os9       F$SUser   ; change the process user ID to Y
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
Branch_002          leax      >Text_009,pc ; form the address >Text_009,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Text_007,pc ; form the address >Text_007,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    clra                ; clear a to zero and set the condition codes
                    leax      >WorkBuffer_002,u ; form the address >WorkBuffer_002,u in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    lbls      Branch_003 ; branch when the unsigned value is lower or equal; target Branch_003
Branch_004          lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_005 ; branch when the values are equal or the result is zero; target Branch_005
                    cmpa      #97       ; compare a with #97 and set the condition codes
                    bcs       Branch_004 ; branch when carry reports an error or unsigned underflow; target Branch_004
                    anda      #223      ; mask a using #223
                    sta       -$01,x    ; store a at -$01,x
                    bra       Branch_004 ; continue execution at Branch_004
Branch_005          leax      >Text_005,pc ; form the address >Text_005,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    sta       WorkByte_003,u ; store a at WorkByte_003,u
Branch_006          leax      <WorkBuffer_001,u ; form the address <WorkBuffer_001,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       WorkByte_003,u ; load a from WorkByte_003,u
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    bcs       Branch_007 ; branch when carry reports an error or unsigned underflow; target Branch_007
Branch_008          lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_009 ; branch when the values are equal or the result is zero; target Branch_009
                    cmpa      #97       ; compare a with #97 and set the condition codes
                    bcs       Branch_008 ; branch when carry reports an error or unsigned underflow; target Branch_008
                    anda      #223      ; mask a using #223
                    sta       -$01,x    ; store a at -$01,x
                    bra       Branch_008 ; continue execution at Branch_008
Branch_009          leax      <WorkBuffer_001,u ; form the address <WorkBuffer_001,u in x
                    leay      >WorkBuffer_002,u ; form the address >WorkBuffer_002,u in y
Branch_010          lda       ,y+       ; load a from ,y+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_011 ; branch when the values are equal or the result is zero; target Branch_011
                    cmpa      ,x+       ; compare a with ,x+ and set the condition codes
                    beq       Branch_010 ; branch when the values are equal or the result is zero; target Branch_010
                    bra       Branch_006 ; continue execution at Branch_006
Branch_011          lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    bne       Branch_006 ; branch when the values differ or the result is nonzero; target Branch_006
                    lbsr      Routine_001 ; call subroutine Routine_001
                    std       >WorkWord_012,u ; store d at >WorkWord_012,u
                    bra       Branch_012 ; continue execution at Branch_012
Branch_007          cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      Branch_001 ; branch when the values differ or the result is nonzero; target Branch_001
                    leax      >Text_008,pc ; form the address >Text_008,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbra      Branch_002 ; continue execution at Branch_002
Branch_012          leax      >Text_001,pc ; form the address >Text_001,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_013 ; branch when carry reports an error or unsigned underflow; target Branch_013
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
                    clr       WorkByte_010,u ; clear WorkByte_010,u to zero and set the condition codes
                    clr       WorkByte_011,u ; clear WorkByte_011,u to zero and set the condition codes
Branch_014          aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    rol       WorkByte_011,u ; rotate left through carry the value at WorkByte_011,u
                    dec       WorkByte_004,u ; decrement the value at WorkByte_004,u
                    bne       Branch_014 ; branch when the values differ or the result is nonzero; target Branch_014
                    std       WorkWord_002,u ; store d at WorkWord_002,u
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    ldx       WorkByte_010,u ; load x from WorkByte_010,u
                    pshs      u         ; save u on the stack
                    ldu       WorkWord_002,u ; load u from WorkWord_002,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    puls      u         ; restore u from the stack
                    leax      >WorkBuffer_007,u ; form the address >WorkBuffer_007,u in x
                    os9       F$Time    ; read the current system date and time
                    leax      >Text_003,pc ; form the address >Text_003,pc in x
                    ldy       >Data_001,pc ; load y from >Data_001,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    clra                ; clear a to zero and set the condition codes
                    leax      >WorkBuffer_006,u ; form the address >WorkBuffer_006,u in x
                    ldy       #30       ; set y to the constant 30
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    leax      >Data_002,pc ; form the address >Data_002,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      >Text_004,pc ; form the address >Text_004,pc in x
                    ldy       #80       ; set y to the constant 80
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    ldd       #0        ; set d to the constant 0
                    std       WorkByte_008,u ; store d at WorkByte_008,u
Branch_015          ldd       WorkByte_008,u ; load d from WorkByte_008,u
                    addd      #1        ; add to d using #1
                    std       WorkByte_008,u ; store d at WorkByte_008,u
                    cmpd      #99       ; compare d with #99 and set the condition codes
                    bge       Branch_016 ; branch when the signed value is greater than or equal; target Branch_016
                    lbsr      Routine_002 ; call subroutine Routine_002
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bls       Branch_016 ; branch when the unsigned value is lower or equal; target Branch_016
                    bra       Branch_015 ; continue execution at Branch_015
Branch_016          leax      >Data_003,pc ; form the address >Data_003,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Text_007,pc ; form the address >Text_007,pc in x
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
                    lbeq      Branch_003 ; branch when the values are equal or the result is zero; target Branch_003
                    cmpa      #68       ; compare a with #68 and set the condition codes
                    lbeq      Branch_017 ; branch when the values are equal or the result is zero; target Branch_017
                    cmpa      #69       ; compare a with #69 and set the condition codes
                    beq       Branch_018 ; branch when the values are equal or the result is zero; target Branch_018
                    cmpa      #67       ; compare a with #67 and set the condition codes
                    beq       Branch_019 ; branch when the values are equal or the result is zero; target Branch_019
                    cmpa      #76       ; compare a with #76 and set the condition codes
                    lbeq      Branch_020 ; branch when the values are equal or the result is zero; target Branch_020
                    bra       Branch_016 ; continue execution at Branch_016
Branch_019          ldd       WorkByte_008,u ; load d from WorkByte_008,u
                    subd      #1        ; subtract from d using #1
                    std       WorkByte_008,u ; store d at WorkByte_008,u
                    bra       Branch_015 ; continue execution at Branch_015
Branch_018          leax      >Text_006,pc ; form the address >Text_006,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Text_007,pc ; form the address >Text_007,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    clra                ; clear a to zero and set the condition codes
                    leax      >WorkBuffer_003,u ; form the address >WorkBuffer_003,u in x
                    ldy       #3        ; set y to the constant 3
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lbsr      Routine_001 ; call subroutine Routine_001
                    cmpd      WorkByte_008,u ; compare d with WorkByte_008,u and set the condition codes
                    lbcc      Branch_016 ; branch when carry is clear; target Branch_016
                    std       <WorkWord_006,u ; store d at <WorkWord_006,u
                    leax      >WorkBuffer_003,u ; form the address >WorkBuffer_003,u in x
                    lbsr      Routine_003 ; call subroutine Routine_003
                    leax      >WorkBuffer_003,u ; form the address >WorkBuffer_003,u in x
                    lda       #58       ; set a to the constant 58
                    sta       $02,x     ; store a at $02,x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    ldd       <WorkWord_006,u ; load d from <WorkWord_006,u
                    leax      >WorkBuffer_008,u ; form the address >WorkBuffer_008,u in x
                    lda       #80       ; set a to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      d,x       ; form the address d,x in x
                    ldy       #80       ; set y to the constant 80
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    tfr       y,d       ; copy the register values specified by y,d
                    stb       WorkByte_007,u ; store b at WorkByte_007,u
                    dec       WorkByte_007,u ; decrement the value at WorkByte_007,u
                    leay      >WorkBuffer_009,u ; form the address >WorkBuffer_009,u in y
Branch_021          lda       ,x+       ; load a from ,x+
                    sta       ,y+       ; store a at ,y+
                    decb                ; decrement b
                    bne       Branch_021 ; branch when the values differ or the result is nonzero; target Branch_021
                    ldd       <WorkWord_006,u ; load d from <WorkWord_006,u
                    bsr       Routine_002 ; call subroutine Routine_002
                    lbra      Branch_016 ; continue execution at Branch_016
Branch_020          ldd       #0        ; set d to the constant 0
                    std       WorkByte_008,u ; store d at WorkByte_008,u
Branch_022          ldd       WorkByte_008,u ; load d from WorkByte_008,u
                    addd      #1        ; add to d using #1
                    std       WorkByte_008,u ; store d at WorkByte_008,u
                    leax      >WorkBuffer_003,u ; form the address >WorkBuffer_003,u in x
                    lbsr      Routine_003 ; call subroutine Routine_003
                    leax      >WorkBuffer_003,u ; form the address >WorkBuffer_003,u in x
                    lda       #58       ; set a to the constant 58
                    sta       $02,x     ; store a at $02,x
                    lda       #1        ; set a to the constant 1
                    ldy       #3        ; set y to the constant 3
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >WorkBuffer_008,u ; form the address >WorkBuffer_008,u in x
                    ldd       WorkByte_008,u ; load d from WorkByte_008,u
                    lda       #80       ; set a to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      d,x       ; form the address d,x in x
                    ldy       #80       ; set y to the constant 80
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bhi       Branch_022 ; branch when the unsigned value is higher; target Branch_022
                    lbra      Branch_016 ; continue execution at Branch_016
Routine_002         leax      >WorkBuffer_003,u ; form the address >WorkBuffer_003,u in x
                    pshs      d         ; save d on the stack
                    lbsr      Routine_003 ; call subroutine Routine_003
                    leax      >WorkBuffer_003,u ; form the address >WorkBuffer_003,u in x
                    lda       #58       ; set a to the constant 58
                    sta       $02,x     ; store a at $02,x
                    lda       #1        ; set a to the constant 1
                    ldy       #3        ; set y to the constant 3
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      >WorkBuffer_009,u ; form the address >WorkBuffer_009,u in x
                    ldb       WorkByte_007,u ; load b from WorkByte_007,u
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      d         ; restore d from the stack
                    lda       #80       ; set a to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      >WorkBuffer_008,u ; form the address >WorkBuffer_008,u in x
                    leax      d,x       ; form the address d,x in x
                    leay      >WorkBuffer_009,u ; form the address >WorkBuffer_009,u in y
                    ldb       #80       ; set b to the constant 80
                    lda       WorkByte_007,u ; load a from WorkByte_007,u
                    beq       Branch_023 ; branch when the values are equal or the result is zero; target Branch_023
                    sta       <WorkByte_012,u ; store a at <WorkByte_012,u
Branch_024          lda       ,y+       ; load a from ,y+
                    sta       ,x+       ; store a at ,x+
                    decb                ; decrement b
                    dec       <WorkByte_012,u ; decrement the value at <WorkByte_012,u
                    bne       Branch_024 ; branch when the values differ or the result is nonzero; target Branch_024
Branch_023          clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    lbsr      Routine_004 ; call subroutine Routine_004
                    rts                 ; return to the caller
Branch_017          leax      >Text_005,pc ; form the address >Text_005,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    sta       WorkByte_003,u ; store a at WorkByte_003,u
Branch_025          leax      <WorkBuffer_001,u ; form the address <WorkBuffer_001,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       WorkByte_003,u ; load a from WorkByte_003,u
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
Branch_026          lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    bne       Branch_026 ; branch when the values differ or the result is nonzero; target Branch_026
                    lbsr      Routine_001 ; call subroutine Routine_001
                    cmpd      WorkWord_001,u ; compare d with WorkWord_001,u and set the condition codes
                    bne       Branch_025 ; branch when the values differ or the result is nonzero; target Branch_025
                    leax      <WorkBuffer_001,u ; form the address <WorkBuffer_001,u in x
                    leay      >WorkBuffer_005,u ; form the address >WorkBuffer_005,u in y
Branch_027          lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    beq       Branch_028 ; branch when the values are equal or the result is zero; target Branch_028
                    sta       ,y+       ; store a at ,y+
                    bra       Branch_027 ; continue execution at Branch_027
Branch_028          lda       #13       ; set a to the constant 13
                    sta       ,y        ; store a at ,y
                    ldd       >WorkWord_008,u ; load d from >WorkWord_008,u
                    std       >WorkWord_009,u ; store d at >WorkWord_009,u
                    ldd       >WorkBuffer_004,u ; load d from >WorkBuffer_004,u
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
                    ldu       >WorkBuffer_004,u ; load u from >WorkBuffer_004,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    puls      u         ; restore u from the stack
                    lda       #0        ; set a to the constant 0
                    sta       WorkWord_003,u ; store a at WorkWord_003,u
                    ldd       #1        ; set d to the constant 1
                    std       <WorkWord_004,u ; store d at <WorkWord_004,u
Branch_029          lda       WorkWord_003,u ; load a from WorkWord_003,u
                    inca                ; increment a
                    sta       WorkWord_003,u ; store a at WorkWord_003,u
                    cmpa      WorkByte_009,u ; compare a with WorkByte_009,u and set the condition codes
                    bhi       Branch_030 ; branch when the unsigned value is higher; target Branch_030
                    ldb       #80       ; set b to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      >WorkBuffer_008,u ; form the address >WorkBuffer_008,u in x
                    leax      d,x       ; form the address d,x in x
                    ldy       #80       ; set y to the constant 80
                    lda       WorkByte_002,u ; load a from WorkByte_002,u
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bls       Branch_030 ; branch when the unsigned value is lower or equal; target Branch_030
                    tfr       y,d       ; copy the register values specified by y,d
                    addd      <WorkWord_004,u ; add to d using <WorkWord_004,u
                    std       <WorkWord_004,u ; store d at <WorkWord_004,u
                    bra       Branch_029 ; continue execution at Branch_029
Branch_030          ldd       >WorkBuffer_004,u ; load d from >WorkBuffer_004,u
                    addd      <WorkWord_004,u ; add to d using <WorkWord_004,u
                    std       >WorkBuffer_004,u ; store d at >WorkBuffer_004,u
                    bcc       Branch_031 ; branch when carry is clear; target Branch_031
                    ldd       >WorkWord_008,u ; load d from >WorkWord_008,u
                    addd      #1        ; add to d using #1
                    std       >WorkWord_008,u ; store d at >WorkWord_008,u
Branch_031          pshs      u         ; save u on the stack
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
Branch_003          clrb                ; clear b to zero and set the condition codes
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
                    lbeq      Branch_032 ; branch when the values are equal or the result is zero; target Branch_032
                    pshs      y,x       ; save y,x on the stack
                    lda       #13       ; set a to the constant 13
Branch_033          sta       ,x+       ; store a at ,x+
                    leay      -$01,y    ; form the address -$01,y in y
                    bne       Branch_033 ; branch when the values differ or the result is nonzero; target Branch_033
                    puls      y,x       ; restore y,x from the stack
Branch_034          pshs      y,x       ; save y,x on the stack
                    leax      WorkByte_006,u ; form the address WorkByte_006,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcs       Branch_035 ; branch when carry reports an error or unsigned underflow; target Branch_035
                    lda       WorkByte_006,u ; load a from WorkByte_006,u
                    cmpa      #1        ; compare a with #1 and set the condition codes
                    beq       Branch_036 ; branch when the values are equal or the result is zero; target Branch_036
                    cmpa      #8        ; compare a with #8 and set the condition codes
                    beq       Branch_037 ; branch when the values are equal or the result is zero; target Branch_037
                    cmpa      #24       ; compare a with #24 and set the condition codes
                    beq       Branch_038 ; branch when the values are equal or the result is zero; target Branch_038
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      Branch_039 ; branch when the values are equal or the result is zero; target Branch_039
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    bcs       Branch_035 ; branch when carry reports an error or unsigned underflow; target Branch_035
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      y,x       ; restore y,x from the stack
                    lda       WorkByte_006,u ; load a from WorkByte_006,u
                    sta       ,x+       ; store a at ,x+
                    leay      -$01,y    ; form the address -$01,y in y
                    lbeq      Branch_040 ; branch when the values are equal or the result is zero; target Branch_040
                    bra       Branch_034 ; continue execution at Branch_034
Branch_035          puls      y,x       ; restore y,x from the stack
                    bra       Branch_034 ; continue execution at Branch_034
Branch_036          puls      y,x       ; restore y,x from the stack
                    leay      -$01,y    ; form the address -$01,y in y
                    beq       Branch_041 ; branch when the values are equal or the result is zero; target Branch_041
                    lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_042 ; branch when the values are equal or the result is zero; target Branch_042
                    pshs      y,x       ; save y,x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    bra       Branch_036 ; continue execution at Branch_036
Branch_042          leax      -$01,x    ; form the address -$01,x in x
Branch_041          leay      $01,y     ; form the address $01,y in y
                    lbra      Branch_034 ; continue execution at Branch_034
Branch_037          puls      y,x       ; restore y,x from the stack
                    leay      $01,y     ; form the address $01,y in y
                    cmpy      ,s        ; compare y with ,s and set the condition codes
                    bhi       Branch_043 ; branch when the unsigned value is higher; target Branch_043
                    pshs      y,x       ; save y,x on the stack
                    leax      >Data_005,pc ; form the address >Data_005,pc in x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      y,x       ; restore y,x from the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    lbra      Branch_034 ; continue execution at Branch_034
Branch_043          leay      -$01,y    ; form the address -$01,y in y
                    lbra      Branch_034 ; continue execution at Branch_034
Branch_038          puls      y,x       ; restore y,x from the stack
                    leay      $01,y     ; form the address $01,y in y
                    cmpy      ,s        ; compare y with ,s and set the condition codes
                    bhi       Branch_043 ; branch when the unsigned value is higher; target Branch_043
                    pshs      y,x       ; save y,x on the stack
                    leax      >Data_005,pc ; form the address >Data_005,pc in x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      y,x       ; restore y,x from the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    cmpy      ,s        ; compare y with ,s and set the condition codes
                    lbhi      Branch_034 ; branch when the unsigned value is higher; target Branch_034
                    pshs      y,x       ; save y,x on the stack
                    bra       Branch_038 ; continue execution at Branch_038
Branch_039          puls      y,x       ; restore y,x from the stack
Branch_032          lda       #13       ; set a to the constant 13
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
Branch_040          puls      d         ; restore d from the stack
                    pshs      y         ; save y on the stack
                    subd      ,s        ; subtract from d using ,s
                    leas      $02,s     ; adjust the system stack pointer
                    addd      #1        ; add to d using #1
                    tfr       d,y       ; copy the register values specified by d,y
                    clrb                ; clear b to zero and set the condition codes
Branch_044          leay      -$01,y    ; form the address -$01,y in y
                    beq       Branch_045 ; branch when the values are equal or the result is zero; target Branch_045
                    lda       ,-x       ; load a from ,-x
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       Branch_046 ; branch when the values are equal or the result is zero; target Branch_046
                    pshs      y,x       ; save y,x on the stack
                    leax      >Data_005,pc ; form the address >Data_005,pc in x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    incb                ; increment b
                    puls      y,x       ; restore y,x from the stack
                    bra       Branch_044 ; continue execution at Branch_044
Branch_045          lda       #13       ; set a to the constant 13
                    sta       <$004F,x  ; store a at <$004F,x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    puls      y         ; restore y from the stack
                    rts                 ; return to the caller
Branch_046          lda       #13       ; set a to the constant 13
                    sta       ,x+       ; store a at ,x+
                    pshs      y,x       ; save y,x on the stack
                    stb       WorkByte_007,u ; store b at WorkByte_007,u
                    leay      >WorkBuffer_009,u ; form the address >WorkBuffer_009,u in y
Branch_047          lda       ,x+       ; load a from ,x+
                    sta       ,y+       ; store a at ,y+
                    decb                ; decrement b
                    bne       Branch_047 ; branch when the values differ or the result is nonzero; target Branch_047
                    leax      >Data_004,pc ; form the address >Data_004,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    puls      y,x       ; restore y,x from the stack
                    lbsr      Routine_005 ; call subroutine Routine_005
                    rts                 ; return to the caller
Code_001            pshs      y,x,d     ; save y,x,d on the stack
                    leax      >WorkByte_016,u ; form the address >WorkByte_016,u in x
                    clra                ; clear a to zero and set the condition codes
                    ldb       #0        ; set b to the constant 0
                    os9       I$GetStt  ; query status code B for path A
                    leax      -$20,x    ; form the address -$20,x in x
                    clr       <$0024,x  ; clear <$0024,x to zero and set the condition codes
                    leax      <$0020,x  ; form the address <$0020,x in x
                    os9       I$SetStt  ; apply status operation B to path A
                    puls      pc,y,x,d  ; restore pc,y,x,d and return to the caller
Routine_005         pshs      y,x,d     ; save y,x,d on the stack
                    leax      >WorkByte_016,u ; form the address >WorkByte_016,u in x
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
Branch_048          lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      Branch_049 ; branch when the values are equal or the result is zero; target Branch_049
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_048 ; branch when carry reports an error or unsigned underflow; target Branch_048
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_048 ; branch when the unsigned value is higher; target Branch_048
                    leax      -$01,x    ; form the address -$01,x in x
Branch_050          lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_051 ; branch when carry reports an error or unsigned underflow; target Branch_051
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_051 ; branch when the unsigned value is higher; target Branch_051
                    bra       Branch_050 ; continue execution at Branch_050
Branch_051          pshs      x         ; save x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    clr       <WorkByte_012,u ; clear <WorkByte_012,u to zero and set the condition codes
                    clr       <WorkByte_013,u ; clear <WorkByte_013,u to zero and set the condition codes
                    ldd       #1        ; set d to the constant 1
                    std       <WorkWord_005,u ; store d at <WorkWord_005,u
Branch_052          lda       ,-x       ; load a from ,-x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_053 ; branch when carry reports an error or unsigned underflow; target Branch_053
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_053 ; branch when the unsigned value is higher; target Branch_053
                    suba      #48       ; subtract from a using #48
                    sta       WorkByte_005,u ; store a at WorkByte_005,u
                    ldd       #0        ; set d to the constant 0
Branch_054          tst       WorkByte_005,u ; set condition codes from WorkByte_005,u without changing it
                    beq       Branch_055 ; branch when the values are equal or the result is zero; target Branch_055
                    addd      <WorkWord_005,u ; add to d using <WorkWord_005,u
                    dec       WorkByte_005,u ; decrement the value at WorkByte_005,u
                    bra       Branch_054 ; continue execution at Branch_054
Branch_055          addd      <WorkByte_012,u ; add to d using <WorkByte_012,u
                    std       <WorkByte_012,u ; store d at <WorkByte_012,u
                    lda       #10       ; set a to the constant 10
                    sta       WorkByte_005,u ; store a at WorkByte_005,u
                    ldd       #0        ; set d to the constant 0
Branch_056          tst       WorkByte_005,u ; set condition codes from WorkByte_005,u without changing it
                    beq       Branch_057 ; branch when the values are equal or the result is zero; target Branch_057
                    addd      <WorkWord_005,u ; add to d using <WorkWord_005,u
                    dec       WorkByte_005,u ; decrement the value at WorkByte_005,u
                    bra       Branch_056 ; continue execution at Branch_056
Branch_057          std       <WorkWord_005,u ; store d at <WorkWord_005,u
                    bra       Branch_052 ; continue execution at Branch_052
Branch_053          ldd       <WorkByte_012,u ; load d from <WorkByte_012,u
                    puls      x         ; restore x from the stack
                    puls      pc,y      ; restore pc,y and return to the caller
Routine_003         pshs      y         ; save y on the stack
                    std       <WorkByte_012,u ; store d at <WorkByte_012,u
                    lda       #48       ; set a to the constant 48
                    sta       ,x        ; store a at ,x
                    sta       $01,x     ; store a at $01,x
                    ldd       #10       ; set d to the constant 10
                    std       <WorkWord_005,u ; store d at <WorkWord_005,u
                    ldd       <WorkByte_012,u ; load d from <WorkByte_012,u
                    bsr       Routine_006 ; call subroutine Routine_006
                    ldd       #1        ; set d to the constant 1
                    std       <WorkWord_005,u ; store d at <WorkWord_005,u
                    ldd       <WorkByte_012,u ; load d from <WorkByte_012,u
                    bsr       Routine_006 ; call subroutine Routine_006
                    lda       #13       ; set a to the constant 13
                    sta       ,x        ; store a at ,x
                    puls      pc,y      ; restore pc,y and return to the caller
Routine_006         subd      <WorkWord_005,u ; subtract from d using <WorkWord_005,u
                    bcs       Branch_058 ; branch when carry reports an error or unsigned underflow; target Branch_058
                    inc       ,x        ; increment the value at ,x
                    bra       Routine_006 ; continue execution at Routine_006
Branch_058          addd      <WorkWord_005,u ; add to d using <WorkWord_005,u
                    std       <WorkByte_012,u ; store d at <WorkByte_012,u
                    leax      $01,x     ; form the address $01,x in x
                    rts                 ; return to the caller
Branch_049          ldd       #-1       ; set d to the constant -1
                    puls      pc,y      ; restore pc,y and return to the caller
Branch_013          leax      >Text_001,pc ; form the address >Text_001,pc in x
                    lda       #11       ; set a to the constant 11
                    tfr       a,b       ; copy the register values specified by a,b
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    sta       WorkByte_001,u ; store a at WorkByte_001,u
                    leax      >Text_002,pc ; form the address >Text_002,pc in x
                    lda       #11       ; set a to the constant 11
                    tfr       a,b       ; copy the register values specified by a,b
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    sta       WorkByte_002,u ; store a at WorkByte_002,u
                    leax      >WorkWord_007,u ; form the address >WorkWord_007,u in x
                    ldd       #0        ; set d to the constant 0
                    std       ,x        ; store d at ,x
                    std       $02,x     ; store d at $02,x
                    std       $04,x     ; store d at $04,x
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    ldy       #64       ; set y to the constant 64
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    os9       I$Close   ; close path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    os9       I$Close   ; close path A
                    lda       WorkByte_002,u ; load a from WorkByte_002,u
                    os9       I$Close   ; close path A
                    lbra      Branch_012 ; continue execution at Branch_012

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
