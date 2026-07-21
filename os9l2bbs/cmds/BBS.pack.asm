**********************************************************************
* BBS.pack - OS-9 Level 2 BBS command
*
* Syntax: BBS.pack <directory>
* Purpose: Rewrite a message base and discard storage occupied by deleted messages.
* Rebuilds bbs.msg and bbs.msg.inx as a consistent pair.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
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

WorkByte_001        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_002        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_003        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_004        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_005        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_001      rmb       3         ; reserve 3 byte(s) in the module workspace
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
WorkBuffer_002      rmb       32        ; reserve 32 byte(s) in the module workspace
WorkBuffer_003      rmb       232       ; reserve 232 byte(s) in the module workspace
WorkWord_005        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_006        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_004      rmb       60        ; reserve 60 byte(s) in the module workspace
WorkBuffer_005      rmb       80        ; reserve 80 byte(s) in the module workspace
WorkWord_007        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_006      rmb       62        ; reserve 62 byte(s) in the module workspace
WorkByte_014        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_007      rmb       399       ; reserve 399 byte(s) in the module workspace
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
Text_001            fcc       "BBS.msg" ; store literal character data
                    fcb       $0D       ; store byte data
Text_002            fcc       "BBS.msg.inx" ; store literal character data
                    fcb       $0D       ; store byte data
Text_003            fcc       "BBs.msg.lst" ; store literal character data
                    fcb       $0D       ; store byte data
Data_001            fcb       $0A       ; store byte data
                    fcc       "One moment please..." ; store literal character data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
Text_004            fcc       "msg.scratch" ; store literal character data
                    fcb       $0D       ; store byte data
Text_005            fcc       "inx.scratch" ; store literal character data
                    fcb       $0D       ; store byte data
Text_006            fcc       "." ; store literal character data
                    fcb       $0D       ; store byte data
                    fcc       "Rename" ; store literal character data
                    fcb       $0D       ; store byte data
Text_007            fcc       "Packing message..." ; store literal character data
                    fcb       $0D       ; store byte data

start               lda       ,x        ; load a from ,x
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_001 ; branch when the values are equal or the result is zero; target Branch_001
                    lda       #1        ; set a to the constant 1
                    os9       I$ChgDir  ; change the current directory to the path at X
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
Branch_001          leax      >WorkByte_014,u ; form the address >WorkByte_014,u in x
                    stx       <WorkWord_004,u ; store x at <WorkWord_004,u
                    clr       <WorkByte_012,u ; clear <WorkByte_012,u to zero and set the condition codes
                    clr       <WorkByte_013,u ; clear <WorkByte_013,u to zero and set the condition codes
                    os9       F$ID      ; retrieve the current process and user IDs
                    sty       WorkWord_001,u ; store y at WorkWord_001,u
                    ldy       #0        ; set y to the constant 0
                    os9       F$SUser   ; change the process user ID to Y
                    clr       WorkByte_007,u ; clear WorkByte_007,u to zero and set the condition codes
                    clr       WorkByte_006,u ; clear WorkByte_006,u to zero and set the condition codes
                    leax      >Data_001,pc ; form the address >Data_001,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Text_002,pc ; form the address >Text_002,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    sta       WorkByte_001,u ; store a at WorkByte_001,u
                    leax      >Text_001,pc ; form the address >Text_001,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    sta       WorkByte_002,u ; store a at WorkByte_002,u
                    leax      >Text_004,pc ; form the address >Text_004,pc in x
                    lda       #2        ; set a to the constant 2
                    ldb       #11       ; set b to the constant 11
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    sta       WorkByte_003,u ; store a at WorkByte_003,u
                    leax      >Text_005,pc ; form the address >Text_005,pc in x
                    lda       #2        ; set a to the constant 2
                    ldb       #11       ; set b to the constant 11
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    sta       WorkByte_004,u ; store a at WorkByte_004,u
                    clr       WorkByte_008,u ; clear WorkByte_008,u to zero and set the condition codes
                    clr       WorkByte_009,u ; clear WorkByte_009,u to zero and set the condition codes
                    clr       WorkByte_010,u ; clear WorkByte_010,u to zero and set the condition codes
                    clr       WorkByte_011,u ; clear WorkByte_011,u to zero and set the condition codes
                    leax      >WorkWord_005,u ; form the address >WorkWord_005,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    lda       WorkByte_003,u ; load a from WorkByte_003,u
                    os9       I$Write   ; write Y bytes from X to path A
Branch_003          ldd       <WorkByte_012,u ; load d from <WorkByte_012,u
                    addd      #1        ; add to d using #1
                    std       <WorkByte_012,u ; store d at <WorkByte_012,u
                    leax      >WorkWord_007,u ; form the address >WorkWord_007,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lbcs      Branch_004 ; branch when carry reports an error or unsigned underflow; target Branch_004
                    cmpy      #64       ; compare y with #64 and set the condition codes
                    lbne      Branch_004 ; branch when the values differ or the result is nonzero; target Branch_004
                    ldd       >WorkWord_007,u ; load d from >WorkWord_007,u
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    beq       Branch_005 ; branch when the values are equal or the result is zero; target Branch_005
                    ldd       WorkByte_008,u ; load d from WorkByte_008,u
                    std       >WorkWord_007,u ; store d at >WorkWord_007,u
                    ldd       WorkByte_010,u ; load d from WorkByte_010,u
                    std       >WorkBuffer_006,u ; store d at >WorkBuffer_006,u
                    lda       WorkByte_003,u ; load a from WorkByte_003,u
                    os9       I$Write   ; write Y bytes from X to path A
Branch_006          lda       WorkByte_002,u ; load a from WorkByte_002,u
                    leax      >WorkBuffer_005,u ; form the address >WorkBuffer_005,u in x
                    ldy       #80       ; set y to the constant 80
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    bcs       Branch_004 ; branch when carry reports an error or unsigned underflow; target Branch_004
                    lda       WorkByte_004,u ; load a from WorkByte_004,u
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    tfr       y,d       ; copy the register values specified by y,d
                    addd      WorkByte_010,u ; add to d using WorkByte_010,u
                    std       WorkByte_010,u ; store d at WorkByte_010,u
                    bcc       Branch_007 ; branch when carry is clear; target Branch_007
                    ldd       WorkByte_008,u ; load d from WorkByte_008,u
                    addd      #1        ; add to d using #1
                    std       WorkByte_008,u ; store d at WorkByte_008,u
Branch_007          cmpy      #1        ; compare y with #1 and set the condition codes
                    bhi       Branch_006 ; branch when the unsigned value is higher; target Branch_006
                    bra       Branch_003 ; continue execution at Branch_003
Branch_005          ldx       <WorkWord_004,u ; load x from <WorkWord_004,u
                    ldd       <WorkByte_012,u ; load d from <WorkByte_012,u
                    std       ,x++      ; store d at ,x++
                    stx       <WorkWord_004,u ; store x at <WorkWord_004,u
                    leax      >Text_007,pc ; form the address >Text_007,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    ldd       >WorkWord_005,u ; load d from >WorkWord_005,u
                    subd      #1        ; subtract from d using #1
                    std       >WorkWord_005,u ; store d at >WorkWord_005,u
Branch_008          lda       WorkByte_002,u ; load a from WorkByte_002,u
                    leax      >WorkBuffer_005,u ; form the address >WorkBuffer_005,u in x
                    ldy       #80       ; set y to the constant 80
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    bcs       Branch_004 ; branch when carry reports an error or unsigned underflow; target Branch_004
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bhi       Branch_008 ; branch when the unsigned value is higher; target Branch_008
                    lbra      Branch_003 ; continue execution at Branch_003
Branch_004          ldd       WorkByte_008,u ; load d from WorkByte_008,u
                    std       >WorkWord_006,u ; store d at >WorkWord_006,u
                    ldd       WorkByte_010,u ; load d from WorkByte_010,u
                    std       >WorkBuffer_004,u ; store d at >WorkBuffer_004,u
                    pshs      u         ; save u on the stack
                    lda       WorkByte_003,u ; load a from WorkByte_003,u
                    ldx       #0        ; set x to the constant 0
                    ldu       #0        ; set u to the constant 0
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    puls      u         ; restore u from the stack
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    leax      >WorkWord_005,u ; form the address >WorkWord_005,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       WorkByte_003,u ; load a from WorkByte_003,u
                    os9       I$Write   ; write Y bytes from X to path A
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    os9       I$Close   ; close path A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    lda       WorkByte_002,u ; load a from WorkByte_002,u
                    os9       I$Close   ; close path A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    lda       WorkByte_003,u ; load a from WorkByte_003,u
                    os9       I$Close   ; close path A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    lda       WorkByte_004,u ; load a from WorkByte_004,u
                    os9       I$Close   ; close path A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    leax      >Text_002,pc ; form the address >Text_002,pc in x
                    os9       I$Delete  ; delete the path named at X
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    leax      >Text_001,pc ; form the address >Text_001,pc in x
                    os9       I$Delete  ; delete the path named at X
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    leax      >Text_004,pc ; form the address >Text_004,pc in x
                    leay      >Text_002,pc ; form the address >Text_002,pc in y
                    lbsr      Routine_001 ; call subroutine Routine_001
                    leax      >Text_005,pc ; form the address >Text_005,pc in x
                    leay      >Text_001,pc ; form the address >Text_001,pc in y
                    lbsr      Routine_001 ; call subroutine Routine_001
                    leax      >Text_003,pc ; form the address >Text_003,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_009 ; branch when carry reports an error or unsigned underflow; target Branch_009
                    sta       WorkByte_005,u ; store a at WorkByte_005,u
Branch_010          lda       WorkByte_005,u ; load a from WorkByte_005,u
                    leax      <WorkWord_002,u ; form the address <WorkWord_002,u in x
                    ldy       #4        ; set y to the constant 4
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lbcs      Branch_009 ; branch when carry reports an error or unsigned underflow; target Branch_009
                    leax      >WorkByte_014,u ; form the address >WorkByte_014,u in x
                    clr       WorkByte_007,u ; clear WorkByte_007,u to zero and set the condition codes
Branch_011          ldd       ,x++      ; load d from ,x++
                    cmpd      <WorkWord_003,u ; compare d with <WorkWord_003,u and set the condition codes
                    bhi       Branch_012 ; branch when the unsigned value is higher; target Branch_012
                    inc       WorkByte_007,u ; increment the value at WorkByte_007,u
Branch_012          cmpx      <WorkWord_004,u ; compare x with <WorkWord_004,u and set the condition codes
                    bcs       Branch_011 ; branch when carry reports an error or unsigned underflow; target Branch_011
                    ldd       <WorkWord_003,u ; load d from <WorkWord_003,u
                    subd      WorkByte_006,u ; subtract from d using WorkByte_006,u
                    std       <WorkWord_003,u ; store d at <WorkWord_003,u
                    lda       WorkByte_005,u ; load a from WorkByte_005,u
                    ldb       #5        ; set b to the constant 5
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; query status code B for path A
                    leau      -$02,u    ; form the workspace or data address -$02,u in u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    puls      u         ; restore u from the stack
                    leax      <WorkWord_003,u ; form the address <WorkWord_003,u in x
                    ldy       #2        ; set y to the constant 2
                    os9       I$Write   ; write Y bytes from X to path A
                    bra       Branch_010 ; continue execution at Branch_010
Branch_009          clrb                ; clear b to zero and set the condition codes
Branch_002          pshs      b         ; save b on the stack
                    ldy       WorkWord_001,u ; load y from WorkWord_001,u
                    os9       F$SUser   ; change the process user ID to Y
                    puls      b         ; restore b from the stack
                    os9       F$Exit    ; terminate the process with status B
Routine_001         leax      >Text_006,pc ; form the address >Text_006,pc in x
                    lda       #131      ; set a to the constant 131
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    sta       WorkBuffer_001,u ; store a at WorkBuffer_001,u
                    clr       <WorkBuffer_003,u ; clear <WorkBuffer_003,u to zero and set the condition codes
Code_001            pshs      u         ; save u on the stack
                    lda       <WorkBuffer_003,u ; load a from <WorkBuffer_003,u
                    inca                ; increment a
                    sta       <WorkBuffer_003,u ; store a at <WorkBuffer_003,u
                    ldb       #32       ; set b to the constant 32
                    mul                 ; multiply a by b and return the product in d
                    tfr       d,x       ; copy the register values specified by d,x
                    lda       WorkBuffer_001,u ; load a from WorkBuffer_001,u
                    ldu       #0        ; set u to the constant 0
                    exg       x,u       ; exchange the register values specified by x,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    puls      u         ; restore u from the stack
                    leax      <WorkBuffer_002,u ; form the address <WorkBuffer_002,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       WorkBuffer_001,u ; load a from WorkBuffer_001,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcs       Branch_013 ; branch when carry reports an error or unsigned underflow; target Branch_013
                    leay      >Text_004,pc ; form the address >Text_004,pc in y
                    leax      <WorkBuffer_002,u ; form the address <WorkBuffer_002,u in x
Branch_014          lda       ,x+       ; load a from ,x+
                    bmi       Branch_015 ; branch when the result is negative; target Branch_015
                    cmpa      ,y+       ; compare a with ,y+ and set the condition codes
                    bne       Branch_016 ; branch when the values differ or the result is nonzero; target Branch_016
                    bra       Branch_014 ; continue execution at Branch_014
Branch_016          leax      <WorkBuffer_002,u ; form the address <WorkBuffer_002,u in x
                    leay      >Text_005,pc ; form the address >Text_005,pc in y
Branch_017          lda       ,x+       ; load a from ,x+
                    bmi       Branch_018 ; branch when the result is negative; target Branch_018
                    cmpa      ,y+       ; compare a with ,y+ and set the condition codes
                    bne       Branch_019 ; branch when the values differ or the result is nonzero; target Branch_019
                    bra       Branch_017 ; continue execution at Branch_017
Branch_019          bra       Code_001  ; continue execution at Code_001
Branch_013          cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      Branch_002 ; branch when the values differ or the result is nonzero; target Branch_002
                    lda       WorkBuffer_001,u ; load a from WorkBuffer_001,u
                    os9       I$Close   ; close path A
                    rts                 ; return to the caller
Branch_015          anda      #127      ; mask a using #127
                    cmpa      ,y+       ; compare a with ,y+ and set the condition codes
                    bne       Branch_016 ; branch when the values differ or the result is nonzero; target Branch_016
                    lda       ,y+       ; load a from ,y+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       Branch_016 ; branch when the values differ or the result is nonzero; target Branch_016
                    leax      <WorkBuffer_002,u ; form the address <WorkBuffer_002,u in x
                    leay      >Text_002,pc ; form the address >Text_002,pc in y
                    bra       Branch_020 ; continue execution at Branch_020
Branch_018          anda      #127      ; mask a using #127
                    cmpa      ,y+       ; compare a with ,y+ and set the condition codes
                    bne       Branch_019 ; branch when the values differ or the result is nonzero; target Branch_019
                    lda       #13       ; set a to the constant 13
                    cmpa      ,y+       ; compare a with ,y+ and set the condition codes
                    bne       Branch_019 ; branch when the values differ or the result is nonzero; target Branch_019
                    leax      <WorkBuffer_002,u ; form the address <WorkBuffer_002,u in x
                    leay      >Text_001,pc ; form the address >Text_001,pc in y
Branch_020          lda       ,y+       ; load a from ,y+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_021 ; branch when the values are equal or the result is zero; target Branch_021
                    sta       ,x+       ; store a at ,x+
                    bra       Branch_020 ; continue execution at Branch_020
Branch_021          lda       ,-x       ; load a from ,-x
                    ora       #128      ; set selected bits in a using #128
                    sta       ,x        ; store a at ,x
                    lda       <WorkBuffer_003,u ; load a from <WorkBuffer_003,u
                    ldb       #32       ; set b to the constant 32
                    mul                 ; multiply a by b and return the product in d
                    tfr       d,x       ; copy the register values specified by d,x
                    lda       WorkBuffer_001,u ; load a from WorkBuffer_001,u
                    ldb       #5        ; set b to the constant 5
                    pshs      u         ; save u on the stack
                    ldu       #0        ; set u to the constant 0
                    exg       x,u       ; exchange the register values specified by x,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    puls      u         ; restore u from the stack
                    leax      <WorkBuffer_002,u ; form the address <WorkBuffer_002,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       WorkBuffer_001,u ; load a from WorkBuffer_001,u
                    os9       I$Write   ; write Y bytes from X to path A
                    ldb       #211      ; set b to the constant 211
                    lbra      Branch_013 ; continue execution at Branch_013
                    fcb       $16       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $40       ; store byte data

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
