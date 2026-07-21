**********************************************************************
* BBS.build - OS-9 Level 2 BBS command
*
* Syntax: BBS.build <file>
* Purpose: Create a text file with the BBS interactive line editor.
* The editor supports list, edit, continue, done, and abort operations.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       BBS.build
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
WorkWord_002        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_004        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_005        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_003        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_006        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_007        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_004        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_005        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_001      rmb       3         ; reserve 3 byte(s) in the module workspace
WorkBuffer_002      rmb       80        ; reserve 80 byte(s) in the module workspace
WorkBuffer_003      rmb       32        ; reserve 32 byte(s) in the module workspace
WorkByte_008        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_004      rmb       8199      ; reserve 8199 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.build/ ; store an OS-9 high-bit-terminated string
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
Data_001            fcb       $0A       ; store byte data
                    fcb       $0A       ; store byte data
                    fcc       "    Please enter message now            (Blank line ends)" ; store literal character data
                    fcb       $0D       ; store byte data
Text_001            fcc       "----------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
Data_002            fcb       $0A       ; store byte data
                    fcc       "[A]bort [D]one [E]dit [C]ontinue or [L]ist" ; store literal character data
                    fcb       $0D       ; store byte data
Text_002            fcc       "Enter line #" ; store literal character data
                    fcb       $0D       ; store byte data
Text_003            fcc       ">" ; store literal character data
Data_003            fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
Data_004            fcb       $08       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $08       ; store byte data

start               stx       WorkWord_002,u ; store x at WorkWord_002,u
                    lda       #2        ; set a to the constant 2
                    ldb       #27       ; set b to the constant 27
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    lbcs      ErrExit   ; branch when carry reports an error or unsigned underflow; target ErrExit
                    sta       WorkWord_001,u ; store a at WorkWord_001,u
                    leax      >Data_001,pc ; form the address >Data_001,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ErrExit   ; branch when carry reports an error or unsigned underflow; target ErrExit
                    leax      >Text_001,pc ; form the address >Text_001,pc in x
                    ldy       #80       ; set y to the constant 80
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ErrExit   ; branch when carry reports an error or unsigned underflow; target ErrExit
                    ldd       #0        ; set d to the constant 0
                    std       WorkByte_004,u ; store d at WorkByte_004,u
                    sta       WorkByte_003,u ; store a at WorkByte_003,u
Branch_001          ldd       WorkByte_004,u ; load d from WorkByte_004,u
                    addd      #1        ; add to d using #1
                    std       WorkByte_004,u ; store d at WorkByte_004,u
                    cmpd      #99       ; compare d with #99 and set the condition codes
                    bge       Branch_002 ; branch when the signed value is greater than or equal; target Branch_002
                    lbsr      Routine_001 ; call subroutine Routine_001
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bls       Branch_002 ; branch when the unsigned value is lower or equal; target Branch_002
                    bra       Branch_001 ; continue execution at Branch_001

Branch_002          leax      >Data_002,pc ; form the address >Data_002,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Text_003,pc ; form the address >Text_003,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      WorkByte_002,u ; form the address WorkByte_002,u in x
                    clra                ; clear a to zero and set the condition codes
                    ldy       #1        ; set y to the constant 1
                    os9       I$Read    ; read up to Y bytes from path A into X
                    leax      >Data_003,pc ; form the address >Data_003,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       WorkByte_002,u ; load a from WorkByte_002,u
                    anda      #223      ; mask a using #223
                    cmpa      #65       ; compare a with #65 and set the condition codes
                    lbeq      Branch_003 ; branch when the values are equal or the result is zero; target Branch_003
                    cmpa      #68       ; compare a with #68 and set the condition codes
                    lbeq      Branch_004 ; branch when the values are equal or the result is zero; target Branch_004
                    cmpa      #69       ; compare a with #69 and set the condition codes
                    beq       Branch_005 ; branch when the values are equal or the result is zero; target Branch_005
                    cmpa      #67       ; compare a with #67 and set the condition codes
                    beq       Branch_006 ; branch when the values are equal or the result is zero; target Branch_006
                    cmpa      #76       ; compare a with #76 and set the condition codes
                    beq       Branch_007 ; branch when the values are equal or the result is zero; target Branch_007
                    bra       Branch_002 ; continue execution at Branch_002

Branch_006          ldd       WorkByte_004,u ; load d from WorkByte_004,u
                    subd      #1        ; subtract from d using #1
                    std       WorkByte_004,u ; store d at WorkByte_004,u
                    bra       Branch_001 ; continue execution at Branch_001

Branch_005          leax      >Text_002,pc ; form the address >Text_002,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Text_003,pc ; form the address >Text_003,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    clra                ; clear a to zero and set the condition codes
                    leax      <WorkBuffer_001,u ; form the address <WorkBuffer_001,u in x
                    ldy       #3        ; set y to the constant 3
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lbsr      Routine_002 ; call subroutine Routine_002
                    cmpd      WorkByte_004,u ; compare d with WorkByte_004,u and set the condition codes
                    lbcc      Branch_002 ; branch when carry is clear; target Branch_002
                    std       WorkWord_005,u ; store d at WorkWord_005,u
                    leax      <WorkBuffer_001,u ; form the address <WorkBuffer_001,u in x
                    lbsr      Routine_003 ; call subroutine Routine_003
                    leax      <WorkBuffer_001,u ; form the address <WorkBuffer_001,u in x
                    lda       #58       ; set a to the constant 58
                    sta       $02,x     ; store a at $02,x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    ldd       WorkWord_005,u ; load d from WorkWord_005,u
                    leax      >WorkByte_008,u ; form the address >WorkByte_008,u in x
                    lda       #80       ; set a to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      d,x       ; form the address d,x in x
                    ldy       #80       ; set y to the constant 80
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    tfr       y,d       ; copy the register values specified by y,d
                    stb       WorkByte_003,u ; store b at WorkByte_003,u
                    dec       WorkByte_003,u ; decrement the value at WorkByte_003,u
                    leay      <WorkBuffer_002,u ; form the address <WorkBuffer_002,u in y
Branch_008          lda       ,x+       ; load a from ,x+
                    sta       ,y+       ; store a at ,y+
                    decb                ; decrement b
                    bne       Branch_008 ; branch when the values differ or the result is nonzero; target Branch_008
                    ldd       WorkWord_005,u ; load d from WorkWord_005,u
                    bsr       Routine_001 ; call subroutine Routine_001
                    lbra      Branch_002 ; continue execution at Branch_002

Branch_007          ldd       #0        ; set d to the constant 0
                    std       WorkByte_004,u ; store d at WorkByte_004,u
Branch_009          ldd       WorkByte_004,u ; load d from WorkByte_004,u
                    addd      #1        ; add to d using #1
                    std       WorkByte_004,u ; store d at WorkByte_004,u
                    leax      <WorkBuffer_001,u ; form the address <WorkBuffer_001,u in x
                    lbsr      Routine_003 ; call subroutine Routine_003
                    leax      <WorkBuffer_001,u ; form the address <WorkBuffer_001,u in x
                    lda       #58       ; set a to the constant 58
                    sta       $02,x     ; store a at $02,x
                    lda       #1        ; set a to the constant 1
                    ldy       #3        ; set y to the constant 3
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >WorkByte_008,u ; form the address >WorkByte_008,u in x
                    ldd       WorkByte_004,u ; load d from WorkByte_004,u
                    lda       #80       ; set a to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      d,x       ; form the address d,x in x
                    ldy       #80       ; set y to the constant 80
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bhi       Branch_009 ; branch when the unsigned value is higher; target Branch_009
                    lbra      Branch_002 ; continue execution at Branch_002

Routine_001         leax      <WorkBuffer_001,u ; form the address <WorkBuffer_001,u in x
                    pshs      d         ; save d on the stack
                    lbsr      Routine_003 ; call subroutine Routine_003
                    leax      <WorkBuffer_001,u ; form the address <WorkBuffer_001,u in x
                    lda       #58       ; set a to the constant 58
                    sta       $02,x     ; store a at $02,x
                    lda       #1        ; set a to the constant 1
                    ldy       #3        ; set y to the constant 3
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      ErrExit   ; branch when carry reports an error or unsigned underflow; target ErrExit
                    leax      <WorkBuffer_002,u ; form the address <WorkBuffer_002,u in x
                    ldb       WorkByte_003,u ; load b from WorkByte_003,u
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      d         ; restore d from the stack
                    lda       #80       ; set a to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      >WorkByte_008,u ; form the address >WorkByte_008,u in x
                    leax      d,x       ; form the address d,x in x
                    leay      <WorkBuffer_002,u ; form the address <WorkBuffer_002,u in y
                    ldb       #80       ; set b to the constant 80
                    lda       WorkByte_003,u ; load a from WorkByte_003,u
                    beq       Branch_010 ; branch when the values are equal or the result is zero; target Branch_010
                    sta       WorkByte_006,u ; store a at WorkByte_006,u
Branch_011          lda       ,y+       ; load a from ,y+
                    sta       ,x+       ; store a at ,x+
                    decb                ; decrement b
                    dec       WorkByte_006,u ; decrement the value at WorkByte_006,u
                    bne       Branch_011 ; branch when the values differ or the result is nonzero; target Branch_011
Branch_010          clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    lbsr      Routine_004 ; call subroutine Routine_004
                    rts                 ; return to the caller

Branch_004          lda       #0        ; set a to the constant 0
                    sta       WorkWord_003,u ; store a at WorkWord_003,u
Branch_012          lda       WorkWord_003,u ; load a from WorkWord_003,u
                    inca                ; increment a
                    sta       WorkWord_003,u ; store a at WorkWord_003,u
                    cmpa      WorkByte_005,u ; compare a with WorkByte_005,u and set the condition codes
                    bhi       Exit      ; branch when the unsigned value is higher; target Exit
                    ldb       #80       ; set b to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      >WorkByte_008,u ; form the address >WorkByte_008,u in x
                    leax      d,x       ; form the address d,x in x
                    ldy       #80       ; set y to the constant 80
                    lda       WorkWord_001,u ; load a from WorkWord_001,u
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      ErrExit   ; branch when carry reports an error or unsigned underflow; target ErrExit
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bls       Exit      ; branch when the unsigned value is lower or equal; target Exit
                    tfr       y,d       ; copy the register values specified by y,d
                    bra       Branch_012 ; continue execution at Branch_012

Exit                clrb                ; clear b to zero and set the condition codes
ErrExit             os9       F$Exit    ; terminate the process with status B

Branch_003          lda       WorkWord_001,u ; load a from WorkWord_001,u
                    os9       I$Close   ; close path A
                    ldx       WorkWord_002,u ; load x from WorkWord_002,u
                    lda       #1        ; set a to the constant 1
                    os9       I$Delete  ; delete the path named at X
                    bcs       ErrExit   ; branch when carry reports an error or unsigned underflow; target ErrExit
                    bra       Exit      ; continue execution at Exit

Routine_004         lbsr      Code_001  ; call subroutine Code_001
                    ldb       WorkByte_003,u ; load b from WorkByte_003,u
                    leay      b,y       ; form the address b,y in y
                    pshs      y         ; save y on the stack
                    negb                ; negate b
                    sex                 ; sign-extend b into d
                    leay      d,y       ; form the address d,y in y
                    clr       WorkByte_003,u ; clear WorkByte_003,u to zero and set the condition codes
                    cmpy      #0        ; compare y with #0 and set the condition codes
                    lbeq      Branch_013 ; branch when the values are equal or the result is zero; target Branch_013
                    pshs      y,x       ; save y,x on the stack
                    lda       #13       ; set a to the constant 13
Branch_014          sta       ,x+       ; store a at ,x+
                    leay      -$01,y    ; form the address -$01,y in y
                    bne       Branch_014 ; branch when the values differ or the result is nonzero; target Branch_014
                    puls      y,x       ; restore y,x from the stack
Branch_015          pshs      y,x       ; save y,x on the stack
                    leax      WorkByte_002,u ; form the address WorkByte_002,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcs       Branch_016 ; branch when carry reports an error or unsigned underflow; target Branch_016
                    lda       WorkByte_002,u ; load a from WorkByte_002,u
                    cmpa      #1        ; compare a with #1 and set the condition codes
                    beq       Branch_017 ; branch when the values are equal or the result is zero; target Branch_017
                    cmpa      #8        ; compare a with #8 and set the condition codes
                    beq       Branch_018 ; branch when the values are equal or the result is zero; target Branch_018
                    cmpa      #24       ; compare a with #24 and set the condition codes
                    beq       Branch_019 ; branch when the values are equal or the result is zero; target Branch_019
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      Branch_020 ; branch when the values are equal or the result is zero; target Branch_020
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    bcs       Branch_016 ; branch when carry reports an error or unsigned underflow; target Branch_016
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      y,x       ; restore y,x from the stack
                    lda       WorkByte_002,u ; load a from WorkByte_002,u
                    sta       ,x+       ; store a at ,x+
                    leay      -$01,y    ; form the address -$01,y in y
                    lbeq      Branch_021 ; branch when the values are equal or the result is zero; target Branch_021
                    bra       Branch_015 ; continue execution at Branch_015

Branch_016          puls      y,x       ; restore y,x from the stack
                    bra       Branch_015 ; continue execution at Branch_015

Branch_017          puls      y,x       ; restore y,x from the stack
                    leay      -$01,y    ; form the address -$01,y in y
                    beq       Branch_022 ; branch when the values are equal or the result is zero; target Branch_022
                    lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_023 ; branch when the values are equal or the result is zero; target Branch_023
                    pshs      y,x       ; save y,x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    bra       Branch_017 ; continue execution at Branch_017

Branch_023          leax      -$01,x    ; form the address -$01,x in x
Branch_022          leay      $01,y     ; form the address $01,y in y
                    lbra      Branch_015 ; continue execution at Branch_015

Branch_018          puls      y,x       ; restore y,x from the stack
                    leay      $01,y     ; form the address $01,y in y
                    cmpy      ,s        ; compare y with ,s and set the condition codes
                    bhi       Branch_024 ; branch when the unsigned value is higher; target Branch_024
                    pshs      y,x       ; save y,x on the stack
                    leax      >Data_004,pc ; form the address >Data_004,pc in x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      y,x       ; restore y,x from the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    lbra      Branch_015 ; continue execution at Branch_015

Branch_024          leay      -$01,y    ; form the address -$01,y in y
                    lbra      Branch_015 ; continue execution at Branch_015

Branch_019          puls      y,x       ; restore y,x from the stack
                    leay      $01,y     ; form the address $01,y in y
                    cmpy      ,s        ; compare y with ,s and set the condition codes
                    bhi       Branch_024 ; branch when the unsigned value is higher; target Branch_024
                    pshs      y,x       ; save y,x on the stack
                    leax      >Data_004,pc ; form the address >Data_004,pc in x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      y,x       ; restore y,x from the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    cmpy      ,s        ; compare y with ,s and set the condition codes
                    lbhi      Branch_015 ; branch when the unsigned value is higher; target Branch_015
                    pshs      y,x       ; save y,x on the stack
                    bra       Branch_019 ; continue execution at Branch_019

Branch_020          puls      y,x       ; restore y,x from the stack
Branch_013          lda       #13       ; set a to the constant 13
                    sta       ,x+       ; store a at ,x+
                    pshs      y,x       ; save y,x on the stack
                    leax      >Data_003,pc ; form the address >Data_003,pc in x
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

Branch_021          puls      d         ; restore d from the stack
                    pshs      y         ; save y on the stack
                    subd      ,s        ; subtract from d using ,s
                    leas      $02,s     ; adjust the system stack pointer
                    addd      #1        ; add to d using #1
                    tfr       d,y       ; copy the register values specified by d,y
                    clrb                ; clear b to zero and set the condition codes
Branch_025          leay      -$01,y    ; form the address -$01,y in y
                    beq       Branch_026 ; branch when the values are equal or the result is zero; target Branch_026
                    lda       ,-x       ; load a from ,-x
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       Branch_027 ; branch when the values are equal or the result is zero; target Branch_027
                    pshs      y,x       ; save y,x on the stack
                    leax      >Data_004,pc ; form the address >Data_004,pc in x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    incb                ; increment b
                    puls      y,x       ; restore y,x from the stack
                    bra       Branch_025 ; continue execution at Branch_025

Branch_026          lda       #13       ; set a to the constant 13
                    sta       <$004F,x  ; store a at <$004F,x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    puls      y         ; restore y from the stack
                    rts                 ; return to the caller

Branch_027          lda       #13       ; set a to the constant 13
                    sta       ,x+       ; store a at ,x+
                    pshs      y,x       ; save y,x on the stack
                    stb       WorkByte_003,u ; store b at WorkByte_003,u
                    leay      <WorkBuffer_002,u ; form the address <WorkBuffer_002,u in y
Branch_028          lda       ,x+       ; load a from ,x+
                    sta       ,y+       ; store a at ,y+
                    decb                ; decrement b
                    bne       Branch_028 ; branch when the values differ or the result is nonzero; target Branch_028
                    leax      >Data_003,pc ; form the address >Data_003,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    puls      y,x       ; restore y,x from the stack
                    lbsr      Routine_005 ; call subroutine Routine_005
                    rts                 ; return to the caller

Code_001            pshs      y,x,d     ; save y,x,d on the stack
                    leax      <WorkBuffer_003,u ; form the address <WorkBuffer_003,u in x
                    clra                ; clear a to zero and set the condition codes
                    ldb       #0        ; set b to the constant 0
                    os9       I$GetStt  ; query status code B for path A
                    leax      -$20,x    ; form the address -$20,x in x
                    clr       <$0024,x  ; clear <$0024,x to zero and set the condition codes
                    leax      <$0020,x  ; form the address <$0020,x in x
                    os9       I$SetStt  ; apply status operation B to path A
                    puls      pc,y,x,d  ; restore pc,y,x,d and return to the caller

Routine_005         pshs      y,x,d     ; save y,x,d on the stack
                    leax      <WorkBuffer_003,u ; form the address <WorkBuffer_003,u in x
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

Routine_002         pshs      y         ; save y on the stack
Branch_029          lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      Branch_030 ; branch when the values are equal or the result is zero; target Branch_030
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_029 ; branch when carry reports an error or unsigned underflow; target Branch_029
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_029 ; branch when the unsigned value is higher; target Branch_029
                    leax      -$01,x    ; form the address -$01,x in x
Branch_031          lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_032 ; branch when carry reports an error or unsigned underflow; target Branch_032
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_032 ; branch when the unsigned value is higher; target Branch_032
                    bra       Branch_031 ; continue execution at Branch_031

Branch_032          pshs      x         ; save x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    clr       WorkByte_006,u ; clear WorkByte_006,u to zero and set the condition codes
                    clr       WorkByte_007,u ; clear WorkByte_007,u to zero and set the condition codes
                    ldd       #1        ; set d to the constant 1
                    std       WorkWord_004,u ; store d at WorkWord_004,u
Branch_033          lda       ,-x       ; load a from ,-x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_034 ; branch when carry reports an error or unsigned underflow; target Branch_034
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_034 ; branch when the unsigned value is higher; target Branch_034
                    suba      #48       ; subtract from a using #48
                    sta       WorkByte_001,u ; store a at WorkByte_001,u
                    ldd       #0        ; set d to the constant 0
Branch_035          tst       WorkByte_001,u ; set condition codes from WorkByte_001,u without changing it
                    beq       Branch_036 ; branch when the values are equal or the result is zero; target Branch_036
                    addd      WorkWord_004,u ; add to d using WorkWord_004,u
                    dec       WorkByte_001,u ; decrement the value at WorkByte_001,u
                    bra       Branch_035 ; continue execution at Branch_035

Branch_036          addd      WorkByte_006,u ; add to d using WorkByte_006,u
                    std       WorkByte_006,u ; store d at WorkByte_006,u
                    lda       #10       ; set a to the constant 10
                    sta       WorkByte_001,u ; store a at WorkByte_001,u
                    ldd       #0        ; set d to the constant 0
Branch_037          tst       WorkByte_001,u ; set condition codes from WorkByte_001,u without changing it
                    beq       Branch_038 ; branch when the values are equal or the result is zero; target Branch_038
                    addd      WorkWord_004,u ; add to d using WorkWord_004,u
                    dec       WorkByte_001,u ; decrement the value at WorkByte_001,u
                    bra       Branch_037 ; continue execution at Branch_037

Branch_038          std       WorkWord_004,u ; store d at WorkWord_004,u
                    bra       Branch_033 ; continue execution at Branch_033
Branch_034          ldd       WorkByte_006,u ; load d from WorkByte_006,u
                    puls      x         ; restore x from the stack
                    puls      pc,y      ; restore pc,y and return to the caller

Routine_003         pshs      y         ; save y on the stack
                    std       WorkByte_006,u ; store d at WorkByte_006,u
                    lda       #48       ; set a to the constant 48
                    sta       ,x        ; store a at ,x
                    sta       $01,x     ; store a at $01,x
                    ldd       #10       ; set d to the constant 10
                    std       WorkWord_004,u ; store d at WorkWord_004,u
                    ldd       WorkByte_006,u ; load d from WorkByte_006,u
                    bsr       Routine_006 ; call subroutine Routine_006
                    ldd       #1        ; set d to the constant 1
                    std       WorkWord_004,u ; store d at WorkWord_004,u
                    ldd       WorkByte_006,u ; load d from WorkByte_006,u
                    bsr       Routine_006 ; call subroutine Routine_006
                    lda       #13       ; set a to the constant 13
                    sta       ,x        ; store a at ,x
                    puls      pc,y      ; restore pc,y and return to the caller

Routine_006         subd      WorkWord_004,u ; subtract from d using WorkWord_004,u
                    bcs       Branch_039 ; branch when carry reports an error or unsigned underflow; target Branch_039
                    inc       ,x        ; increment the value at ,x
                    bra       Routine_006 ; continue execution at Routine_006

Branch_039          addd      WorkWord_004,u ; add to d using WorkWord_004,u
                    std       WorkByte_006,u ; store d at WorkByte_006,u
                    leax      $01,x     ; form the address $01,x in x
                    rts                 ; return to the caller

Branch_030          ldd       #-1       ; set d to the constant -1
                    puls      pc,y      ; restore pc,y and return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
