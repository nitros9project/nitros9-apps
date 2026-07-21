**********************************************************************
* BBS.login - OS-9 Level 2 BBS command
*
* Syntax: BBS.login
* Purpose: Authenticate a caller and run the command configured in BBS.users.
* Displays motd/eotd and updates userlog, BBS.userstats, and OS-9 identity.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       BBS.login
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

WorkWord_001        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_001        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_002        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_003        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_004        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_001      rmb       5         ; reserve 5 byte(s) in the module workspace
WorkByte_005        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_006        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_007        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_008        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_009        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_002      rmb       3         ; reserve 3 byte(s) in the module workspace
WorkWord_002        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_010        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_011        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_003        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_004        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_005        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_006        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_007        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_008        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_009        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_010        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_012        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_011        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_013        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_012        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_013        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_014        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_015        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_016        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_014        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_015        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_016        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_017        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_017        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_003      rmb       8         ; reserve 8 byte(s) in the module workspace
WorkBuffer_004      rmb       3         ; reserve 3 byte(s) in the module workspace
WorkByte_018        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_019        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_020        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_005      rmb       32        ; reserve 32 byte(s) in the module workspace
WorkBuffer_006      rmb       200       ; reserve 200 byte(s) in the module workspace
WorkBuffer_007      rmb       200       ; reserve 200 byte(s) in the module workspace
WorkBuffer_008      rmb       400       ; reserve 400 byte(s) in the module workspace
WorkByte_021        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_009      rmb       599       ; reserve 599 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.login/ ; store the non-conflicting OS-9 module name
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
Data_001            fcb       $2F       ; store byte data
                    fcb       $50       ; store byte data
                    fcb       $0D       ; store byte data
Data_002            fcb       $0A       ; store byte data
                    fcc       "Enter your user name-->" ; store literal character data
Data_003            fcb       $00       ; store byte data
                    fcb       $18       ; store byte data
Text_001            fcc       "Enter your Password--->" ; store literal character data
Data_004            fcb       $00       ; store byte data
                    fcb       $17       ; store byte data
Text_002            fcc       "Motd" ; store literal character data
                    fcb       $0D       ; store byte data
Text_003            fcc       "Shell" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
Text_004            fcc       "BBS.users" ; store literal character data
                    fcb       $0D       ; store byte data
Text_005            fcc       "Invald name/password!!!" ; store literal character data
                    fcb       $0D       ; store byte data
Data_005            fcb       $0A       ; store byte data
                    fcc       "OS9 Level II BBS" ; store literal character data
                    fcb       $0D       ; store byte data
Text_006            fcc       "By Alpha Software Technologies" ; store literal character data
                    fcb       $0D       ; store byte data
Text_007            fcc       "Copyright (c) 1988" ; store literal character data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
Data_006            fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
Text_008            fcc       "date" ; store literal character data
                    fcb       $0D       ; store byte data
Data_007            fcb       $74       ; store byte data
                    fcb       $0D       ; store byte data
Text_009            fcc       "                                       " ; store literal character data
Text_010            fcc       ":" ; store literal character data
Text_011            fcc       "Sorry, but I cannot log you on" ; store literal character data
                    fcb       $0D       ; store byte data
Text_012            fcc       "Welcome, " ; store literal character data
                    fcb       $0D       ; store byte data
Data_008            fcb       $0A       ; store byte data
                    fcc       "Verifying Password...Please wait" ; store literal character data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
Data_009            fcb       $0A       ; store byte data
                    fcc       "Entering system..." ; store literal character data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
Text_013            fcc       "Userlog" ; store literal character data
                    fcb       $0D       ; store byte data
Text_014            fcc       "     List of today's callers" ; store literal character data
                    fcb       $0D       ; store byte data
Text_015            fcc       "=================================" ; store literal character data
                    fcb       $0D       ; store byte data
Text_016            fcc       "eotd" ; store literal character data
                    fcb       $0D       ; store byte data
Data_010            fcb       $58       ; store byte data
Data_011            fcb       $08       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $08       ; store byte data
Text_017            fcc       "/dd/bbs/BBS.userstats" ; store literal character data
                    fcb       $0D       ; store byte data
Text_018            fcc       "I'm sorry but you don't have any more time on-line" ; store literal character data
                    fcb       $0D       ; store byte data
start               leax      >Data_001,pc ; form the address >Data_001,pc in x
                    lda       #2        ; set a to the constant 2
                    os9       I$Open    ; open the path at X using access mode A
                    bcc       Branch_001 ; branch when carry is clear; target Branch_001
                    lda       #255      ; set a to the constant 255
Branch_001          sta       WorkByte_004,u ; store a at WorkByte_004,u
                    ldy       #0        ; set y to the constant 0
                    os9       F$SUser   ; change the process user ID to Y
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    clr       WorkByte_007,u ; clear WorkByte_007,u to zero and set the condition codes
                    leax      >Text_002,pc ; form the address >Text_002,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    bcs       Branch_003 ; branch when carry reports an error or unsigned underflow; target Branch_003
                    leax      <WorkBuffer_006,u ; form the address <WorkBuffer_006,u in x
                    sta       WorkByte_003,u ; store a at WorkByte_003,u
Branch_004          ldy       #200      ; set y to the constant 200
                    lda       WorkByte_003,u ; load a from WorkByte_003,u
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    bcs       Branch_005 ; branch when carry reports an error or unsigned underflow; target Branch_005
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    bra       Branch_004 ; continue execution at Branch_004
Branch_005          lda       WorkByte_003,u ; load a from WorkByte_003,u
                    os9       I$Close   ; close path A
Branch_003          leax      >Data_005,pc ; form the address >Data_005,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Text_006,pc ; form the address >Text_006,pc in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Text_007,pc ; form the address >Text_007,pc in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
Branch_006          leax      >Data_002,pc ; form the address >Data_002,pc in x
                    ldy       >Data_003,pc ; load y from >Data_003,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >WorkBuffer_007,u ; form the address >WorkBuffer_007,u in x
                    clra                ; clear a to zero and set the condition codes
                    ldy       #200      ; set y to the constant 200
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    bcs       Branch_006 ; branch when carry reports an error or unsigned underflow; target Branch_006
                    sty       <WorkWord_004,u ; store y at <WorkWord_004,u
                    lbsr      Routine_001 ; call subroutine Routine_001
                    lbsr      Routine_002 ; call subroutine Routine_002
                    leax      >Text_001,pc ; form the address >Text_001,pc in x
                    ldy       >Data_004,pc ; load y from >Data_004,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >WorkBuffer_008,u ; form the address >WorkBuffer_008,u in x
Branch_007          ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcs       Branch_007 ; branch when carry reports an error or unsigned underflow; target Branch_007
                    lda       ,x        ; load a from ,x
                    cmpa      #8        ; compare a with #8 and set the condition codes
                    beq       Branch_008 ; branch when the values are equal or the result is zero; target Branch_008
                    pshs      x         ; save x on the stack
                    leax      >Data_010,pc ; form the address >Data_010,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      x         ; restore x from the stack
                    lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       Branch_007 ; branch when the values differ or the result is nonzero; target Branch_007
                    leax      >WorkBuffer_008,u ; form the address >WorkBuffer_008,u in x
                    lbsr      Routine_001 ; call subroutine Routine_001
                    leax      >Data_006,pc ; form the address >Data_006,pc in x
                    ldy       #2        ; set y to the constant 2
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbsr      Routine_003 ; call subroutine Routine_003
                    bra       Branch_009 ; continue execution at Branch_009
Branch_008          leay      >WorkBuffer_008,u ; form the address >WorkBuffer_008,u in y
                    sty       <WorkByte_010,u ; store y at <WorkByte_010,u
                    cmpx      <WorkByte_010,u ; compare x with <WorkByte_010,u and set the condition codes
                    beq       Branch_007 ; branch when the values are equal or the result is zero; target Branch_007
                    pshs      x         ; save x on the stack
                    leax      >Data_011,pc ; form the address >Data_011,pc in x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      x         ; restore x from the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    bra       Branch_007 ; continue execution at Branch_007
Branch_009          leax      >Data_008,pc ; form the address >Data_008,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Text_004,pc ; form the address >Text_004,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    sta       WorkByte_002,u ; store a at WorkByte_002,u
Branch_010          leax      <WorkBuffer_006,u ; form the address <WorkBuffer_006,u in x
                    ldb       #200      ; set b to the constant 200
                    lda       #13       ; set a to the constant 13
Branch_011          sta       ,x+       ; store a at ,x+
                    decb                ; decrement b
                    bne       Branch_011 ; branch when the values differ or the result is nonzero; target Branch_011
                    leax      <WorkBuffer_006,u ; form the address <WorkBuffer_006,u in x
                    clr       WorkByte_006,u ; clear WorkByte_006,u to zero and set the condition codes
                    lda       WorkByte_002,u ; load a from WorkByte_002,u
                    ldy       #200      ; set y to the constant 200
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    bcs       Branch_012 ; branch when carry reports an error or unsigned underflow; target Branch_012
                    lbsr      Routine_001 ; call subroutine Routine_001
                    leay      >WorkBuffer_007,u ; form the address >WorkBuffer_007,u in y
Branch_013          lda       ,y+       ; load a from ,y+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_014 ; branch when the values are equal or the result is zero; target Branch_014
                    cmpa      #90       ; compare a with #90 and set the condition codes
                    bls       Branch_015 ; branch when the unsigned value is lower or equal; target Branch_015
                    anda      #223      ; mask a using #223
Branch_015          cmpa      ,x+       ; compare a with ,x+ and set the condition codes
                    bne       Branch_010 ; branch when the values differ or the result is nonzero; target Branch_010
                    inc       WorkByte_006,u ; increment the value at WorkByte_006,u
                    bra       Branch_013 ; continue execution at Branch_013
Branch_014          lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    bne       Branch_010 ; branch when the values differ or the result is nonzero; target Branch_010
                    leay      >WorkBuffer_008,u ; form the address >WorkBuffer_008,u in y
Branch_016          lda       ,y+       ; load a from ,y+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_017 ; branch when the values are equal or the result is zero; target Branch_017
                    cmpa      #90       ; compare a with #90 and set the condition codes
                    bls       Branch_018 ; branch when the unsigned value is lower or equal; target Branch_018
                    anda      #223      ; mask a using #223
Branch_018          cmpa      ,x+       ; compare a with ,x+ and set the condition codes
                    bne       Branch_010 ; branch when the values differ or the result is nonzero; target Branch_010
                    bra       Branch_016 ; continue execution at Branch_016
Branch_017          lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    bne       Branch_010 ; branch when the values differ or the result is nonzero; target Branch_010
                    leay      >WorkByte_021,u ; form the address >WorkByte_021,u in y
                    clr       <WorkWord_003,u ; clear <WorkWord_003,u to zero and set the condition codes
Branch_019          inc       <WorkWord_003,u ; increment the value at <WorkWord_003,u
                    lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    beq       Branch_020 ; branch when the values are equal or the result is zero; target Branch_020
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_020 ; branch when the values are equal or the result is zero; target Branch_020
                    sta       ,y+       ; store a at ,y+
                    bra       Branch_019 ; continue execution at Branch_019
Branch_020          pshs      y,x       ; save y,x on the stack
                    lbsr      Routine_004 ; call subroutine Routine_004
                    puls      y,x       ; restore y,x from the stack
                    lda       #13       ; set a to the constant 13
                    sta       ,y        ; store a at ,y
                    inc       <WorkWord_003,u ; increment the value at <WorkWord_003,u
                    bsr       Routine_005 ; call subroutine Routine_005
                    std       <WorkWord_006,u ; store d at <WorkWord_006,u
                    tfr       d,y       ; copy the register values specified by d,y
                    os9       F$SUser   ; change the process user ID to Y
                    bsr       Routine_005 ; call subroutine Routine_005
                    std       <WorkWord_005,u ; store d at <WorkWord_005,u
                    lda       WorkByte_002,u ; load a from WorkByte_002,u
                    os9       I$Close   ; close path A
                    lbra      Branch_021 ; continue execution at Branch_021
Branch_012          leax      >Text_005,pc ; form the address >Text_005,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       WorkByte_002,u ; load a from WorkByte_002,u
                    os9       I$Close   ; close path A
                    inc       WorkByte_007,u ; increment the value at WorkByte_007,u
                    lda       WorkByte_007,u ; load a from WorkByte_007,u
                    cmpa      #3        ; compare a with #3 and set the condition codes
                    bgt       Branch_022 ; branch when the signed value is greater; target Branch_022
                    lbra      Branch_006 ; continue execution at Branch_006
Branch_023          ldd       #0        ; set d to the constant 0
                    puls      pc,y      ; restore pc,y and return to the caller
Branch_022          leax      >Text_011,pc ; form the address >Text_011,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    pshs      u         ; save u on the stack
                    lbra      Branch_024 ; continue execution at Branch_024
Routine_005         pshs      y         ; save y on the stack
Branch_025          lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_023 ; branch when the values are equal or the result is zero; target Branch_023
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_025 ; branch when carry reports an error or unsigned underflow; target Branch_025
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_025 ; branch when the unsigned value is higher; target Branch_025
                    leax      -$01,x    ; form the address -$01,x in x
Branch_026          lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_027 ; branch when carry reports an error or unsigned underflow; target Branch_027
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_027 ; branch when the unsigned value is higher; target Branch_027
                    bra       Branch_026 ; continue execution at Branch_026
Branch_027          pshs      x         ; save x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    clr       <WorkByte_010,u ; clear <WorkByte_010,u to zero and set the condition codes
                    clr       <WorkByte_011,u ; clear <WorkByte_011,u to zero and set the condition codes
                    ldd       #1        ; set d to the constant 1
                    std       <WorkWord_002,u ; store d at <WorkWord_002,u
Branch_028          lda       ,-x       ; load a from ,-x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_029 ; branch when carry reports an error or unsigned underflow; target Branch_029
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_029 ; branch when the unsigned value is higher; target Branch_029
                    suba      #48       ; subtract from a using #48
                    sta       WorkByte_005,u ; store a at WorkByte_005,u
                    ldd       #0        ; set d to the constant 0
Branch_030          tst       WorkByte_005,u ; set condition codes from WorkByte_005,u without changing it
                    beq       Branch_031 ; branch when the values are equal or the result is zero; target Branch_031
                    addd      <WorkWord_002,u ; add to d using <WorkWord_002,u
                    dec       WorkByte_005,u ; decrement the value at WorkByte_005,u
                    bra       Branch_030 ; continue execution at Branch_030
Branch_031          addd      <WorkByte_010,u ; add to d using <WorkByte_010,u
                    std       <WorkByte_010,u ; store d at <WorkByte_010,u
                    lda       #10       ; set a to the constant 10
                    sta       WorkByte_005,u ; store a at WorkByte_005,u
                    ldd       #0        ; set d to the constant 0
Branch_032          tst       WorkByte_005,u ; set condition codes from WorkByte_005,u without changing it
                    beq       Branch_033 ; branch when the values are equal or the result is zero; target Branch_033
                    addd      <WorkWord_002,u ; add to d using <WorkWord_002,u
                    dec       WorkByte_005,u ; decrement the value at WorkByte_005,u
                    bra       Branch_032 ; continue execution at Branch_032
Branch_033          std       <WorkWord_002,u ; store d at <WorkWord_002,u
                    bra       Branch_028 ; continue execution at Branch_028
Branch_029          ldd       <WorkByte_010,u ; load d from <WorkByte_010,u
                    puls      x         ; restore x from the stack
                    puls      pc,y      ; restore pc,y and return to the caller
Branch_021          leax      >Text_012,pc ; form the address >Text_012,pc in x
                    lda       #1        ; set a to the constant 1
                    ldy       #9        ; set y to the constant 9
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    leax      >WorkBuffer_007,u ; form the address >WorkBuffer_007,u in x
                    ldb       WorkByte_006,u ; load b from WorkByte_006,u
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       WorkByte_004,u ; load a from WorkByte_004,u
                    bmi       Branch_034 ; branch when the result is negative; target Branch_034
                    os9       I$Write   ; write Y bytes from X to path A
Branch_034          lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    lda       #1        ; set a to the constant 1
                    leay      $01,y     ; form the address $01,y in y
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    leax      >Data_009,pc ; form the address >Data_009,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    ldb       #21       ; set b to the constant 21
                    subb      WorkByte_006,u ; subtract from b using WorkByte_006,u
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    leax      >Text_009,pc ; form the address >Text_009,pc in x
                    lda       WorkByte_004,u ; load a from WorkByte_004,u
                    bmi       Branch_035 ; branch when the result is negative; target Branch_035
                    os9       I$Write   ; write Y bytes from X to path A
Branch_035          lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    pshs      u         ; save u on the stack
                    lda       #1        ; set a to the constant 1
                    os9       I$Close   ; close path A
                    lda       WorkByte_004,u ; load a from WorkByte_004,u
                    bmi       Branch_036 ; branch when the result is negative; target Branch_036
                    os9       I$Dup     ; duplicate path A into the next free path number
                    leax      >Text_008,pc ; form the address >Text_008,pc in x
                    leau      >Data_007,pc ; form the workspace or data address >Data_007,pc in u
                    ldy       #2        ; set y to the constant 2
                    lda       #17       ; set a to the constant 17
                    ldb       #3        ; set b to the constant 3
                    os9       F$Fork    ; spawn the module at X with parameters at U
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    os9       F$Wait    ; wait for a child process to terminate
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    lda       #1        ; set a to the constant 1
                    os9       I$Close   ; close path A
Branch_036          clra                ; clear a to zero and set the condition codes
                    os9       I$Dup     ; duplicate path A into the next free path number
                    puls      u         ; restore u from the stack
                    leax      >Text_017,pc ; form the address >Text_017,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    bcc       Branch_037 ; branch when carry is clear; target Branch_037
                    ldb       #27       ; set b to the constant 27
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
Branch_037          sta       <WorkBuffer_002,u ; store a at <WorkBuffer_002,u
Branch_038          leax      <WorkWord_009,u ; form the address <WorkWord_009,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       <WorkBuffer_002,u ; load a from <WorkBuffer_002,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcs       Branch_039 ; branch when carry reports an error or unsigned underflow; target Branch_039
                    ldd       <WorkWord_009,u ; load d from <WorkWord_009,u
                    cmpd      <WorkWord_006,u ; compare d with <WorkWord_006,u and set the condition codes
                    bne       Branch_038 ; branch when the values differ or the result is nonzero; target Branch_038
                    bra       Branch_040 ; continue execution at Branch_040
Branch_039          cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      Branch_002 ; branch when the values differ or the result is nonzero; target Branch_002
                    lbra      Branch_041 ; continue execution at Branch_041
Branch_042          leax      >Text_018,pc ; form the address >Text_018,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbra      Branch_024 ; continue execution at Branch_024
Branch_040          ldd       <WorkWord_010,u ; load d from <WorkWord_010,u
                    addd      #1        ; add to d using #1
                    std       <WorkWord_010,u ; store d at <WorkWord_010,u
                    leax      <WorkByte_012,u ; form the address <WorkByte_012,u in x
                    os9       F$Time    ; read the current system date and time
                    lda       <WorkByte_014,u ; load a from <WorkByte_014,u
                    cmpa      <WorkByte_012,u ; compare a with <WorkByte_012,u and set the condition codes
                    bne       Branch_043 ; branch when the values differ or the result is nonzero; target Branch_043
                    ldd       <WorkByte_015,u ; load d from <WorkByte_015,u
                    cmpd      <WorkWord_011,u ; compare d with <WorkWord_011,u and set the condition codes
                    bne       Branch_043 ; branch when the values differ or the result is nonzero; target Branch_043
                    bra       Branch_044 ; continue execution at Branch_044
Branch_043          ldd       <WorkWord_005,u ; load d from <WorkWord_005,u
                    std       <WorkBuffer_003,u ; store d at <WorkBuffer_003,u
Branch_044          ldd       <WorkBuffer_003,u ; load d from <WorkBuffer_003,u
                    cmpd      #1        ; compare d with #1 and set the condition codes
                    lbeq      Branch_042 ; branch when the values are equal or the result is zero; target Branch_042
                    lda       <WorkBuffer_002,u ; load a from <WorkBuffer_002,u
                    ldb       #5        ; set b to the constant 5
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; query status code B for path A
                    tfr       u,d       ; copy the register values specified by u,d
                    subd      #32       ; subtract from d using #32
                    bge       Branch_045 ; branch when the signed value is greater than or equal; target Branch_045
                    leax      -$01,x    ; form the address -$01,x in x
Branch_045          ldu       ,s        ; load u from the current stack frame at ,s
                    stx       <WorkWord_007,u ; store x at <WorkWord_007,u
                    std       <WorkWord_008,u ; store d at <WorkWord_008,u
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       <WorkBuffer_002,u ; load a from <WorkBuffer_002,u
                    tfr       y,u       ; copy the register values specified by y,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    puls      u         ; restore u from the stack
                    leax      <WorkWord_009,u ; form the address <WorkWord_009,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       <WorkBuffer_002,u ; load a from <WorkBuffer_002,u
                    os9       I$Write   ; write Y bytes from X to path A
                    os9       I$Close   ; close path A
                    lbra      Branch_046 ; continue execution at Branch_046
Branch_041          leax      <WorkWord_009,u ; form the address <WorkWord_009,u in x
                    ldd       #1        ; set d to the constant 1
                    std       <WorkWord_010,u ; store d at <WorkWord_010,u
                    ldd       #0        ; set d to the constant 0
                    std       <WorkWord_013,u ; store d at <WorkWord_013,u
                    std       <WorkWord_014,u ; store d at <WorkWord_014,u
                    std       <WorkWord_016,u ; store d at <WorkWord_016,u
                    std       <WorkWord_015,u ; store d at <WorkWord_015,u
                    std       <WorkByte_014,u ; store d at <WorkByte_014,u
                    std       <WorkByte_016,u ; store d at <WorkByte_016,u
                    std       <WorkWord_017,u ; store d at <WorkWord_017,u
                    ldd       <WorkWord_005,u ; load d from <WorkWord_005,u
                    std       <WorkBuffer_003,u ; store d at <WorkBuffer_003,u
                    ldd       <WorkWord_006,u ; load d from <WorkWord_006,u
                    std       <WorkWord_009,u ; store d at <WorkWord_009,u
                    leax      <WorkByte_012,u ; form the address <WorkByte_012,u in x
                    os9       F$Time    ; read the current system date and time
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    lda       <WorkBuffer_002,u ; load a from <WorkBuffer_002,u
                    ldb       #5        ; set b to the constant 5
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; query status code B for path A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    tfr       u,d       ; copy the register values specified by u,d
                    puls      u         ; restore u from the stack
                    stx       <WorkWord_007,u ; store x at <WorkWord_007,u
                    std       <WorkWord_008,u ; store d at <WorkWord_008,u
                    leax      <WorkWord_009,u ; form the address <WorkWord_009,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       <WorkBuffer_002,u ; load a from <WorkBuffer_002,u
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    os9       I$Close   ; close path A
Branch_046          pshs      u         ; save u on the stack
                    ldb       <WorkWord_003,u ; load b from <WorkWord_003,u
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    leax      >Text_003,pc ; form the address >Text_003,pc in x
                    leau      >WorkByte_021,u ; form the workspace or data address >WorkByte_021,u in u
                    lda       #17       ; set a to the constant 17
                    ldb       #3        ; set b to the constant 3
                    os9       F$Fork    ; spawn the module at X with parameters at U
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    os9       F$Wait    ; wait for a child process to terminate
                    lbra      Branch_047 ; continue execution at Branch_047
Routine_002         leax      <WorkBuffer_005,u ; form the address <WorkBuffer_005,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$GetStt  ; query status code B for path A
                    leax      -$20,x    ; form the address -$20,x in x
                    clr       <$0024,x  ; clear <$0024,x to zero and set the condition codes
                    leax      <WorkBuffer_005,u ; form the address <WorkBuffer_005,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$SetStt  ; apply status operation B to path A
                    rts                 ; return to the caller
Routine_003         leax      <WorkBuffer_005,u ; form the address <WorkBuffer_005,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$GetStt  ; query status code B for path A
                    leax      -$20,x    ; form the address -$20,x in x
                    lda       #1        ; set a to the constant 1
                    sta       <$0024,x  ; store a at <$0024,x
                    leax      <WorkBuffer_005,u ; form the address <WorkBuffer_005,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$SetStt  ; apply status operation B to path A
                    rts                 ; return to the caller
Branch_024          puls      u         ; restore u from the stack
                    ldy       #0        ; set y to the constant 0
                    os9       F$SUser   ; change the process user ID to Y
                    leax      >Text_016,pc ; form the address >Text_016,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    bcs       Branch_048 ; branch when carry reports an error or unsigned underflow; target Branch_048
                    sta       WorkByte_001,u ; store a at WorkByte_001,u
Branch_049          leax      <WorkBuffer_006,u ; form the address <WorkBuffer_006,u in x
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    ldy       #200      ; set y to the constant 200
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    bcs       Branch_048 ; branch when carry reports an error or unsigned underflow; target Branch_048
                    lda       #1        ; set a to the constant 1
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    bra       Branch_049 ; continue execution at Branch_049
Branch_048          clrb                ; clear b to zero and set the condition codes
                    os9       F$Exit    ; terminate the process with status B
Branch_047          puls      u         ; restore u from the stack
                    ldy       #0        ; set y to the constant 0
                    os9       F$SUser   ; change the process user ID to Y
                    leax      >Text_016,pc ; form the address >Text_016,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    bcs       Branch_050 ; branch when carry reports an error or unsigned underflow; target Branch_050
                    sta       WorkByte_001,u ; store a at WorkByte_001,u
Branch_051          leax      <WorkBuffer_006,u ; form the address <WorkBuffer_006,u in x
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    ldy       #200      ; set y to the constant 200
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    bcs       Branch_050 ; branch when carry reports an error or unsigned underflow; target Branch_050
                    lda       #1        ; set a to the constant 1
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    bra       Branch_051 ; continue execution at Branch_051
Branch_050          cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      Branch_002 ; branch when the values differ or the result is nonzero; target Branch_002
                    leax      >Text_017,pc ; form the address >Text_017,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    sta       <WorkBuffer_002,u ; store a at <WorkBuffer_002,u
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    pshs      u         ; save u on the stack
                    ldx       <WorkWord_007,u ; load x from <WorkWord_007,u
                    ldu       <WorkWord_008,u ; load u from <WorkWord_008,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    puls      u         ; restore u from the stack
                    leax      <WorkWord_009,u ; form the address <WorkWord_009,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       <WorkBuffer_002,u ; load a from <WorkBuffer_002,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    leax      <WorkByte_014,u ; form the address <WorkByte_014,u in x
                    os9       F$Time    ; read the current system date and time
                    ldd       <WorkWord_005,u ; load d from <WorkWord_005,u
                    cmpd      #0        ; compare d with #0 and set the condition codes
                    beq       Branch_052 ; branch when the values are equal or the result is zero; target Branch_052
                    lda       <WorkByte_012,u ; load a from <WorkByte_012,u
                    cmpa      <WorkByte_014,u ; compare a with <WorkByte_014,u and set the condition codes
                    bne       Branch_053 ; branch when the values differ or the result is nonzero; target Branch_053
                    ldd       <WorkWord_011,u ; load d from <WorkWord_011,u
                    cmpd      <WorkByte_015,u ; compare d with <WorkByte_015,u and set the condition codes
                    bne       Branch_053 ; branch when the values differ or the result is nonzero; target Branch_053
                    lda       <WorkByte_017,u ; load a from <WorkByte_017,u
                    suba      <WorkByte_013,u ; subtract from a using <WorkByte_013,u
                    ldb       #60       ; set b to the constant 60
                    mul                 ; multiply a by b and return the product in d
                    std       <WorkWord_005,u ; store d at <WorkWord_005,u
                    lda       <WorkWord_017,u ; load a from <WorkWord_017,u
                    suba      <WorkWord_012,u ; subtract from a using <WorkWord_012,u
                    tfr       a,b       ; copy the register values specified by a,b
                    sex                 ; sign-extend b into d
                    addd      <WorkWord_005,u ; add to d using <WorkWord_005,u
                    std       <WorkWord_005,u ; store d at <WorkWord_005,u
                    ldd       <WorkBuffer_003,u ; load d from <WorkBuffer_003,u
                    subd      <WorkWord_005,u ; subtract from d using <WorkWord_005,u
                    bgt       Branch_054 ; branch when the signed value is greater; target Branch_054
                    ldd       #1        ; set d to the constant 1
Branch_054          std       <WorkBuffer_003,u ; store d at <WorkBuffer_003,u
                    bra       Branch_052 ; continue execution at Branch_052
Branch_053          ldd       <WorkWord_005,u ; load d from <WorkWord_005,u
                    std       <WorkBuffer_003,u ; store d at <WorkBuffer_003,u
Branch_052          lda       <WorkBuffer_002,u ; load a from <WorkBuffer_002,u
                    pshs      u         ; save u on the stack
                    ldx       <WorkWord_007,u ; load x from <WorkWord_007,u
                    ldu       <WorkWord_008,u ; load u from <WorkWord_008,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    puls      u         ; restore u from the stack
                    leax      <WorkWord_009,u ; form the address <WorkWord_009,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       <WorkBuffer_002,u ; load a from <WorkBuffer_002,u
                    os9       I$Write   ; write Y bytes from X to path A
                    bcs       Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    clrb                ; clear b to zero and set the condition codes
Branch_002          os9       F$Exit    ; terminate the process with status B
Routine_004         leax      >Text_013,pc ; form the address >Text_013,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    bcc       Branch_055 ; branch when carry is clear; target Branch_055
                    cmpb      #216      ; compare b with #216 and set the condition codes
                    lbne      Branch_002 ; branch when the values differ or the result is nonzero; target Branch_002
                    leax      >Text_013,pc ; form the address >Text_013,pc in x
                    lda       #3        ; set a to the constant 3
                    ldb       #11       ; set b to the constant 11
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    leax      >Text_014,pc ; form the address >Text_014,pc in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Text_015,pc ; form the address >Text_015,pc in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
Branch_055          sta       WorkBuffer_001,u ; store a at WorkBuffer_001,u
                    pshs      u         ; save u on the stack
                    ldb       #2        ; set b to the constant 2
                    os9       I$GetStt  ; query status code B for path A
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    puls      u         ; restore u from the stack
                    leax      >WorkBuffer_007,u ; form the address >WorkBuffer_007,u in x
                    ldy       <WorkWord_004,u ; load y from <WorkWord_004,u
                    leay      -$01,y    ; form the address -$01,y in y
                    os9       I$Write   ; write Y bytes from X to path A
                    sty       <WorkByte_010,u ; store y at <WorkByte_010,u
                    ldd       #24       ; set d to the constant 24
                    subd      <WorkByte_010,u ; subtract from d using <WorkByte_010,u
                    blt       Branch_056 ; branch when the signed value is less; target Branch_056
                    tfr       d,y       ; copy the register values specified by d,y
                    leax      >Text_009,pc ; form the address >Text_009,pc in x
                    lda       WorkBuffer_001,u ; load a from WorkBuffer_001,u
                    os9       I$Write   ; write Y bytes from X to path A
Branch_056          leax      <WorkBuffer_004,u ; form the address <WorkBuffer_004,u in x
                    os9       F$Time    ; read the current system date and time
                    bsr       Routine_006 ; call subroutine Routine_006
                    os9       I$Close   ; close path A
                    rts                 ; return to the caller
Routine_006         lda       <WorkByte_018,u ; load a from <WorkByte_018,u
                    bsr       Routine_007 ; call subroutine Routine_007
                    leax      >Text_010,pc ; form the address >Text_010,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       WorkBuffer_001,u ; load a from WorkBuffer_001,u
                    os9       I$Write   ; write Y bytes from X to path A
                    lda       <WorkByte_019,u ; load a from <WorkByte_019,u
                    bsr       Routine_007 ; call subroutine Routine_007
                    leax      >Text_010,pc ; form the address >Text_010,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       WorkBuffer_001,u ; load a from WorkBuffer_001,u
                    os9       I$Write   ; write Y bytes from X to path A
                    lda       <WorkByte_020,u ; load a from <WorkByte_020,u
                    bsr       Routine_007 ; call subroutine Routine_007
                    leax      >Data_006,pc ; form the address >Data_006,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       WorkBuffer_001,u ; load a from WorkBuffer_001,u
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    rts                 ; return to the caller
Routine_007         clrb                ; clear b to zero and set the condition codes
Branch_057          cmpa      #10       ; compare a with #10 and set the condition codes
                    blt       Branch_058 ; branch when the signed value is less; target Branch_058
                    incb                ; increment b
                    suba      #10       ; subtract from a using #10
                    bra       Branch_057 ; continue execution at Branch_057
Branch_058          addb      #48       ; add to b using #48
                    stb       WorkByte_008,u ; store b at WorkByte_008,u
                    adda      #48       ; add to a using #48
                    sta       WorkByte_009,u ; store a at WorkByte_009,u
                    leax      WorkByte_008,u ; form the address WorkByte_008,u in x
                    ldy       #2        ; set y to the constant 2
                    lda       WorkBuffer_001,u ; load a from WorkBuffer_001,u
                    os9       I$Write   ; write Y bytes from X to path A
                    rts                 ; return to the caller
Routine_001         pshs      x         ; save x on the stack
Branch_059          lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_060 ; branch when the values are equal or the result is zero; target Branch_060
                    cmpa      #90       ; compare a with #90 and set the condition codes
                    bls       Branch_059 ; branch when the unsigned value is lower or equal; target Branch_059
                    anda      #223      ; mask a using #223
                    sta       -$01,x    ; store a at -$01,x
                    bra       Branch_059 ; continue execution at Branch_059
Branch_060          puls      pc,x      ; restore pc,x and return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
