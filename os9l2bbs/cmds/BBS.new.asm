**********************************************************************
* BBS.new - OS-9 Level 2 BBS command
*
* Syntax: BBS.new
* Purpose: Read board messages newer than the caller previous-visit state.
* Data: current message base and per-user statistics.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       BBS.new
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
WorkBuffer_001      rmb       3         ; reserve 3 byte(s) in the module workspace
WorkByte_008        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_009        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_001        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_002        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_003        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_004        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_005        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_006        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_007        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_002      rmb       6         ; reserve 6 byte(s) in the module workspace
WorkWord_008        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_009        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_010        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_003      rmb       16        ; reserve 16 byte(s) in the module workspace
WorkBuffer_004      rmb       6         ; reserve 6 byte(s) in the module workspace
WorkBuffer_005      rmb       3         ; reserve 3 byte(s) in the module workspace
WorkByte_010        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_006      rmb       9         ; reserve 9 byte(s) in the module workspace
WorkByte_011        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_012        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_011        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_013        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_014        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_015        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_016        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_017        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_018        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_019        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_020        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_021        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_022        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_023        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_024        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_025        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_026        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_027        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_007      rmb       64        ; reserve 64 byte(s) in the module workspace
WorkBuffer_008      rmb       80        ; reserve 80 byte(s) in the module workspace
WorkWord_012        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_013        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_009      rmb       20        ; reserve 20 byte(s) in the module workspace
WorkBuffer_010      rmb       30        ; reserve 30 byte(s) in the module workspace
WorkByte_028        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_029        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_030        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_031        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_011      rmb       4         ; reserve 4 byte(s) in the module workspace
WorkWord_014        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_032        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_012      rmb       399       ; reserve 399 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.new/ ; store an OS-9 high-bit-terminated string
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
Text_001            fcc       "BBS.msg.inx" ; store literal character data
                    fcb       $0D       ; store byte data
Text_002            fcc       "BBS.msg" ; store literal character data
                    fcb       $0D       ; store byte data
Text_003            fcc       "******   DELETED   ******" ; store literal character data
                    fcb       $0D       ; store byte data
Text_004            fcc       "Message :" ; store literal character data
Text_005            fcc       "From    :" ; store literal character data
Text_006            fcc       "To      :" ; store literal character data
Text_007            fcc       "Left on :" ; store literal character data
Text_008            fcc       "About   :" ; store literal character data
Data_001            fcb       $00       ; store byte data
                    fcb       $09       ; store byte data
Text_009            fcc       "----------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
Data_002            fcb       $0A       ; store byte data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
Text_010            fcc       "Press <SPACE> to skip a message" ; store literal character data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
Text_011            fcc       "BBS.msg.lst" ; store literal character data
                    fcb       $0D       ; store byte data
Text_012            fcc       "No new messages to read." ; store literal character data
                    fcb       $0D       ; store byte data
Text_013            fcc       "/dd/bbs/BBS.userstats" ; store literal character data
                    fcb       $0D       ; store byte data
Text_014            fcc       "/dd/bbs/BBS.alias" ; store literal character data
                    fcb       $0D       ; store byte data
Text_015            fcc       "Unknown User" ; store literal character data
                    fcb       $0D       ; store byte data
Text_016            fcc       "All Users" ; store literal character data
                    fcb       $0D       ; store byte data

start               os9       F$ID      ; retrieve the current process and user IDs
                    sty       WorkWord_002,u ; store y at WorkWord_002,u
                    ldy       #0        ; set y to the constant 0
                    sty       <WorkWord_005,u ; store y at <WorkWord_005,u
                    os9       F$SUser   ; change the process user ID to Y
                    leax      >Text_001,pc ; form the address >Text_001,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    sta       WorkByte_002,u ; store a at WorkByte_002,u
                    leax      >Text_002,pc ; form the address >Text_002,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    sta       WorkByte_003,u ; store a at WorkByte_003,u
                    leax      >Text_011,pc ; form the address >Text_011,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    bcc       Branch_002 ; branch when carry is clear; target Branch_002
                    cmpb      #216      ; compare b with #216 and set the condition codes
                    lbne      Branch_001 ; branch when the values differ or the result is nonzero; target Branch_001
                    ldb       #3        ; set b to the constant 3
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
Branch_002          sta       WorkByte_004,u ; store a at WorkByte_004,u
                    leax      <WorkBuffer_007,u ; form the address <WorkBuffer_007,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       WorkByte_002,u ; load a from WorkByte_002,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
Branch_003          lda       WorkByte_004,u ; load a from WorkByte_004,u
                    leax      <WorkWord_003,u ; form the address <WorkWord_003,u in x
                    ldy       #4        ; set y to the constant 4
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcs       Branch_004 ; branch when carry reports an error or unsigned underflow; target Branch_004
                    ldd       <WorkWord_003,u ; load d from <WorkWord_003,u
                    cmpd      WorkWord_002,u ; compare d with WorkWord_002,u and set the condition codes
                    bne       Branch_003 ; branch when the values differ or the result is nonzero; target Branch_003
                    ldd       <WorkWord_004,u ; load d from <WorkWord_004,u
                    addd      #1        ; add to d using #1
                    std       <WorkBuffer_004,u ; store d at <WorkBuffer_004,u
                    bra       Branch_005 ; continue execution at Branch_005
Branch_004          cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      Branch_001 ; branch when the values differ or the result is nonzero; target Branch_001
                    ldd       #1        ; set d to the constant 1
                    std       <WorkBuffer_004,u ; store d at <WorkBuffer_004,u
Branch_005          ldd       <WorkBuffer_004,u ; load d from <WorkBuffer_004,u
                    cmpd      <WorkBuffer_007,u ; compare d with <WorkBuffer_007,u and set the condition codes
                    lbhi      Branch_006 ; branch when the unsigned value is higher; target Branch_006
                    clr       <WorkByte_011,u ; clear <WorkByte_011,u to zero and set the condition codes
                    clr       <WorkByte_012,u ; clear <WorkByte_012,u to zero and set the condition codes
                    lda       #6        ; set a to the constant 6
                    sta       WorkByte_006,u ; store a at WorkByte_006,u
                    ldd       <WorkBuffer_004,u ; load d from <WorkBuffer_004,u
Branch_007          aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    rol       <WorkByte_012,u ; rotate left through carry the value at <WorkByte_012,u
                    dec       WorkByte_006,u ; decrement the value at WorkByte_006,u
                    bne       Branch_007 ; branch when the values differ or the result is nonzero; target Branch_007
                    std       <WorkWord_011,u ; store d at <WorkWord_011,u
                    ldx       <WorkByte_011,u ; load x from <WorkByte_011,u
                    lda       WorkByte_002,u ; load a from WorkByte_002,u
                    pshs      u         ; save u on the stack
                    ldu       <WorkWord_011,u ; load u from <WorkWord_011,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    puls      u         ; restore u from the stack
                    ldd       <WorkBuffer_004,u ; load d from <WorkBuffer_004,u
                    subd      #1        ; subtract from d using #1
                    std       <WorkBuffer_004,u ; store d at <WorkBuffer_004,u
                    lda       WorkByte_004,u ; load a from WorkByte_004,u
                    pshs      u         ; save u on the stack
                    ldu       #0        ; set u to the constant 0
                    tfr       u,x       ; copy the register values specified by u,x
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    puls      u         ; restore u from the stack
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
Branch_008          lda       WorkByte_004,u ; load a from WorkByte_004,u
                    leax      <WorkWord_003,u ; form the address <WorkWord_003,u in x
                    ldy       #4        ; set y to the constant 4
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcs       Branch_009 ; branch when carry reports an error or unsigned underflow; target Branch_009
                    ldd       <WorkWord_003,u ; load d from <WorkWord_003,u
                    cmpd      WorkWord_002,u ; compare d with WorkWord_002,u and set the condition codes
                    bne       Branch_008 ; branch when the values differ or the result is nonzero; target Branch_008
                    ldd       <WorkWord_004,u ; load d from <WorkWord_004,u
                    cmpd      <WorkBuffer_007,u ; compare d with <WorkBuffer_007,u and set the condition codes
                    bcc       Branch_010 ; branch when carry is clear; target Branch_010
                    pshs      u         ; save u on the stack
                    lda       WorkByte_004,u ; load a from WorkByte_004,u
                    ldb       #5        ; set b to the constant 5
                    os9       I$GetStt  ; query status code B for path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leau      -$02,u    ; form the workspace or data address -$02,u in u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    puls      u         ; restore u from the stack
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      <WorkBuffer_007,u ; form the address <WorkBuffer_007,u in x
                    ldy       #2        ; set y to the constant 2
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    bra       Branch_010 ; continue execution at Branch_010
Branch_009          cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      Branch_001 ; branch when the values differ or the result is nonzero; target Branch_001
                    lda       WorkByte_004,u ; load a from WorkByte_004,u
                    leax      WorkWord_002,u ; form the address WorkWord_002,u in x
                    ldy       #2        ; set y to the constant 2
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      <WorkBuffer_007,u ; form the address <WorkBuffer_007,u in x
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
Branch_010          lda       WorkByte_004,u ; load a from WorkByte_004,u
                    os9       I$Close   ; close path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      >Text_010,pc ; form the address >Text_010,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
Branch_011          lda       WorkByte_002,u ; load a from WorkByte_002,u
                    ldy       #64       ; set y to the constant 64
                    leax      >WorkWord_012,u ; form the address >WorkWord_012,u in x
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lbcs      Branch_012 ; branch when carry reports an error or unsigned underflow; target Branch_012
                    ldd       <WorkBuffer_004,u ; load d from <WorkBuffer_004,u
                    addd      #1        ; add to d using #1
                    std       <WorkBuffer_004,u ; store d at <WorkBuffer_004,u
                    leax      >Data_002,pc ; form the address >Data_002,pc in x
                    ldy       #2        ; set y to the constant 2
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    ldd       <WorkBuffer_004,u ; load d from <WorkBuffer_004,u
                    leax      <WorkBuffer_005,u ; form the address <WorkBuffer_005,u in x
                    lbsr      Routine_001 ; call subroutine Routine_001
                    leax      >Text_004,pc ; form the address >Text_004,pc in x
                    ldy       >Data_001,pc ; load y from >Data_001,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      <WorkBuffer_005,u ; form the address <WorkBuffer_005,u in x
Branch_013          lda       ,x+       ; load a from ,x+
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       Branch_013 ; branch when the values are equal or the result is zero; target Branch_013
                    leax      -$01,x    ; form the address -$01,x in x
                    ldy       #6        ; set y to the constant 6
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    ldd       >WorkWord_012,u ; load d from >WorkWord_012,u
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    lbeq      Branch_014 ; branch when the values are equal or the result is zero; target Branch_014
                    leax      >Text_005,pc ; form the address >Text_005,pc in x
                    ldy       >Data_001,pc ; load y from >Data_001,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >WorkBuffer_009,u ; form the address >WorkBuffer_009,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      >Text_006,pc ; form the address >Text_006,pc in x
                    ldy       >Data_001,pc ; load y from >Data_001,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    ldd       >WorkWord_014,u ; load d from >WorkWord_014,u
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    beq       Branch_015 ; branch when the values are equal or the result is zero; target Branch_015
                    leax      >Text_014,pc ; form the address >Text_014,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    sta       WorkByte_005,u ; store a at WorkByte_005,u
Branch_016          leax      >WorkByte_032,u ; form the address >WorkByte_032,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       WorkByte_005,u ; load a from WorkByte_005,u
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    bcs       Branch_017 ; branch when carry reports an error or unsigned underflow; target Branch_017
                    leax      >WorkByte_032,u ; form the address >WorkByte_032,u in x
Branch_018          lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    bne       Branch_018 ; branch when the values differ or the result is nonzero; target Branch_018
                    lda       #13       ; set a to the constant 13
                    sta       -$01,x    ; store a at -$01,x
                    lbsr      Routine_002 ; call subroutine Routine_002
                    cmpd      >WorkWord_014,u ; compare d with >WorkWord_014,u and set the condition codes
                    bne       Branch_016 ; branch when the values differ or the result is nonzero; target Branch_016
                    leax      >WorkByte_032,u ; form the address >WorkByte_032,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       WorkByte_005,u ; load a from WorkByte_005,u
                    os9       I$Close   ; close path A
                    lbra      Branch_019 ; continue execution at Branch_019
Branch_017          leax      >Text_015,pc ; form the address >Text_015,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       WorkByte_005,u ; load a from WorkByte_005,u
                    os9       I$Close   ; close path A
                    lbra      Branch_019 ; continue execution at Branch_019
Branch_015          leax      >Text_016,pc ; form the address >Text_016,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
Branch_019          leax      >Text_007,pc ; form the address >Text_007,pc in x
                    ldy       >Data_001,pc ; load y from >Data_001,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      <WorkBuffer_005,u ; form the address <WorkBuffer_005,u in x
                    ldb       >WorkByte_029,u ; load b from >WorkByte_029,u
                    clra                ; clear a to zero and set the condition codes
                    lbsr      Routine_001 ; call subroutine Routine_001
                    lda       <WorkByte_010,u ; load a from <WorkByte_010,u
                    sta       <WorkByte_013,u ; store a at <WorkByte_013,u
                    lda       <WorkBuffer_006,u ; load a from <WorkBuffer_006,u
                    sta       <WorkByte_014,u ; store a at <WorkByte_014,u
                    lda       #47       ; set a to the constant 47
                    sta       <WorkByte_015,u ; store a at <WorkByte_015,u
                    ldb       >WorkByte_030,u ; load b from >WorkByte_030,u
                    clra                ; clear a to zero and set the condition codes
                    leax      <WorkBuffer_005,u ; form the address <WorkBuffer_005,u in x
                    lbsr      Routine_001 ; call subroutine Routine_001
                    lda       <WorkByte_010,u ; load a from <WorkByte_010,u
                    sta       <WorkByte_016,u ; store a at <WorkByte_016,u
                    lda       <WorkBuffer_006,u ; load a from <WorkBuffer_006,u
                    sta       <WorkByte_017,u ; store a at <WorkByte_017,u
                    lda       #47       ; set a to the constant 47
                    sta       <WorkByte_018,u ; store a at <WorkByte_018,u
                    ldb       >WorkByte_028,u ; load b from >WorkByte_028,u
                    clra                ; clear a to zero and set the condition codes
                    leax      <WorkBuffer_005,u ; form the address <WorkBuffer_005,u in x
                    lbsr      Routine_001 ; call subroutine Routine_001
                    lda       <WorkByte_010,u ; load a from <WorkByte_010,u
                    sta       <WorkByte_019,u ; store a at <WorkByte_019,u
                    lda       <WorkBuffer_006,u ; load a from <WorkBuffer_006,u
                    sta       <WorkByte_020,u ; store a at <WorkByte_020,u
                    lda       #32       ; set a to the constant 32
                    sta       <WorkByte_021,u ; store a at <WorkByte_021,u
                    ldb       >WorkByte_031,u ; load b from >WorkByte_031,u
                    clra                ; clear a to zero and set the condition codes
                    leax      <WorkBuffer_005,u ; form the address <WorkBuffer_005,u in x
                    lbsr      Routine_001 ; call subroutine Routine_001
                    lda       <WorkByte_010,u ; load a from <WorkByte_010,u
                    sta       <WorkByte_022,u ; store a at <WorkByte_022,u
                    lda       <WorkBuffer_006,u ; load a from <WorkBuffer_006,u
                    sta       <WorkByte_023,u ; store a at <WorkByte_023,u
                    lda       #58       ; set a to the constant 58
                    sta       <WorkByte_024,u ; store a at <WorkByte_024,u
                    ldb       >WorkBuffer_011,u ; load b from >WorkBuffer_011,u
                    clra                ; clear a to zero and set the condition codes
                    leax      <WorkBuffer_005,u ; form the address <WorkBuffer_005,u in x
                    lbsr      Routine_001 ; call subroutine Routine_001
                    lda       <WorkByte_010,u ; load a from <WorkByte_010,u
                    sta       <WorkByte_025,u ; store a at <WorkByte_025,u
                    lda       <WorkBuffer_006,u ; load a from <WorkBuffer_006,u
                    sta       <WorkByte_026,u ; store a at <WorkByte_026,u
                    lda       #13       ; set a to the constant 13
                    sta       <WorkByte_027,u ; store a at <WorkByte_027,u
                    leax      <WorkByte_013,u ; form the address <WorkByte_013,u in x
Branch_020          lda       ,x+       ; load a from ,x+
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       Branch_020 ; branch when the values are equal or the result is zero; target Branch_020
                    leax      -$01,x    ; form the address -$01,x in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      >Text_008,pc ; form the address >Text_008,pc in x
                    ldy       >Data_001,pc ; load y from >Data_001,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >WorkBuffer_010,u ; form the address >WorkBuffer_010,u in x
                    ldy       #30       ; set y to the constant 30
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    bra       Branch_021 ; continue execution at Branch_021
Branch_014          leax      >Text_003,pc ; form the address >Text_003,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbra      Branch_011 ; continue execution at Branch_011
Branch_021          leax      >Text_009,pc ; form the address >Text_009,pc in x
                    ldy       #80       ; set y to the constant 80
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       WorkByte_003,u ; load a from WorkByte_003,u
                    ldx       >WorkWord_012,u ; load x from >WorkWord_012,u
                    pshs      u         ; save u on the stack
                    ldu       >WorkWord_013,u ; load u from >WorkWord_013,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    puls      u         ; restore u from the stack
Branch_022          clra                ; clear a to zero and set the condition codes
                    ldb       #1        ; set b to the constant 1
                    os9       I$GetStt  ; query status code B for path A
                    bcs       Branch_023 ; branch when carry reports an error or unsigned underflow; target Branch_023
                    leax      WorkByte_001,u ; form the address WorkByte_001,u in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    lbeq      Branch_011 ; branch when the values are equal or the result is zero; target Branch_011
Branch_023          lda       WorkByte_003,u ; load a from WorkByte_003,u
                    leax      >WorkBuffer_008,u ; form the address >WorkBuffer_008,u in x
                    ldy       #80       ; set y to the constant 80
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bhi       Branch_022 ; branch when the unsigned value is higher; target Branch_022
                    leax      >Text_009,pc ; form the address >Text_009,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Data_002,pc ; form the address >Data_002,pc in x
                    ldy       #5        ; set y to the constant 5
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    ldd       <WorkWord_005,u ; load d from <WorkWord_005,u
                    addd      #1        ; add to d using #1
                    std       <WorkWord_005,u ; store d at <WorkWord_005,u
                    lbra      Branch_011 ; continue execution at Branch_011
Branch_012          leax      >Text_013,pc ; form the address >Text_013,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    bcc       Branch_024 ; branch when carry is clear; target Branch_024
                    ldb       #27       ; set b to the constant 27
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
Branch_024          sta       WorkBuffer_001,u ; store a at WorkBuffer_001,u
Branch_025          leax      <WorkWord_006,u ; form the address <WorkWord_006,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       WorkBuffer_001,u ; load a from WorkBuffer_001,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcs       Branch_026 ; branch when carry reports an error or unsigned underflow; target Branch_026
                    ldd       <WorkWord_006,u ; load d from <WorkWord_006,u
                    cmpd      WorkWord_002,u ; compare d with WorkWord_002,u and set the condition codes
                    bne       Branch_025 ; branch when the values differ or the result is nonzero; target Branch_025
                    bra       Branch_027 ; continue execution at Branch_027
Branch_026          cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      Branch_001 ; branch when the values differ or the result is nonzero; target Branch_001
                    lbra      Branch_028 ; continue execution at Branch_028
Branch_027          ldd       <WorkWord_009,u ; load d from <WorkWord_009,u
                    addd      <WorkWord_005,u ; add to d using <WorkWord_005,u
                    std       <WorkWord_009,u ; store d at <WorkWord_009,u
                    lda       WorkBuffer_001,u ; load a from WorkBuffer_001,u
                    ldb       #5        ; set b to the constant 5
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; query status code B for path A
                    tfr       u,d       ; copy the register values specified by u,d
                    subd      #32       ; subtract from d using #32
                    bge       Branch_029 ; branch when the signed value is greater than or equal; target Branch_029
                    leax      -$01,x    ; form the address -$01,x in x
Branch_029          ldu       ,s        ; load u from the current stack frame at ,s
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       WorkBuffer_001,u ; load a from WorkBuffer_001,u
                    tfr       y,u       ; copy the register values specified by y,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    puls      u         ; restore u from the stack
                    leax      <WorkWord_006,u ; form the address <WorkWord_006,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       WorkBuffer_001,u ; load a from WorkBuffer_001,u
                    os9       I$Write   ; write Y bytes from X to path A
                    os9       I$Close   ; close path A
                    lbra      Branch_030 ; continue execution at Branch_030
Branch_028          leax      <WorkWord_006,u ; form the address <WorkWord_006,u in x
                    ldd       #1        ; set d to the constant 1
                    std       <WorkWord_007,u ; store d at <WorkWord_007,u
                    std       <WorkWord_009,u ; store d at <WorkWord_009,u
                    ldd       #0        ; set d to the constant 0
                    std       <WorkWord_008,u ; store d at <WorkWord_008,u
                    std       <WorkBuffer_003,u ; store d at <WorkBuffer_003,u
                    std       <WorkWord_010,u ; store d at <WorkWord_010,u
                    ldd       WorkWord_002,u ; load d from WorkWord_002,u
                    std       <WorkWord_006,u ; store d at <WorkWord_006,u
                    leax      <WorkBuffer_002,u ; form the address <WorkBuffer_002,u in x
                    os9       F$Time    ; read the current system date and time
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      <WorkWord_006,u ; form the address <WorkWord_006,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       WorkBuffer_001,u ; load a from WorkBuffer_001,u
                    os9       I$Write   ; write Y bytes from X to path A
                    os9       I$Close   ; close path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    bra       Branch_030 ; continue execution at Branch_030
Branch_006          leax      >Text_012,pc ; form the address >Text_012,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
Branch_030          clrb                ; clear b to zero and set the condition codes
Branch_001          os9       F$Exit    ; terminate the process with status B
Routine_002         pshs      y         ; save y on the stack
Branch_031          lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      Branch_032 ; branch when the values are equal or the result is zero; target Branch_032
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_031 ; branch when carry reports an error or unsigned underflow; target Branch_031
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_031 ; branch when the unsigned value is higher; target Branch_031
                    leax      -$01,x    ; form the address -$01,x in x
Branch_033          lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_034 ; branch when carry reports an error or unsigned underflow; target Branch_034
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_034 ; branch when the unsigned value is higher; target Branch_034
                    bra       Branch_033 ; continue execution at Branch_033
Branch_034          pshs      x         ; save x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    clr       WorkByte_008,u ; clear WorkByte_008,u to zero and set the condition codes
                    clr       WorkByte_009,u ; clear WorkByte_009,u to zero and set the condition codes
                    ldd       #1        ; set d to the constant 1
                    std       WorkWord_001,u ; store d at WorkWord_001,u
Branch_035          lda       ,-x       ; load a from ,-x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_036 ; branch when carry reports an error or unsigned underflow; target Branch_036
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_036 ; branch when the unsigned value is higher; target Branch_036
                    suba      #48       ; subtract from a using #48
                    sta       WorkByte_007,u ; store a at WorkByte_007,u
                    ldd       #0        ; set d to the constant 0
Branch_037          tst       WorkByte_007,u ; set condition codes from WorkByte_007,u without changing it
                    beq       Branch_038 ; branch when the values are equal or the result is zero; target Branch_038
                    addd      WorkWord_001,u ; add to d using WorkWord_001,u
                    dec       WorkByte_007,u ; decrement the value at WorkByte_007,u
                    bra       Branch_037 ; continue execution at Branch_037
Branch_038          addd      WorkByte_008,u ; add to d using WorkByte_008,u
                    std       WorkByte_008,u ; store d at WorkByte_008,u
                    lda       #10       ; set a to the constant 10
                    sta       WorkByte_007,u ; store a at WorkByte_007,u
                    ldd       #0        ; set d to the constant 0
Branch_039          tst       WorkByte_007,u ; set condition codes from WorkByte_007,u without changing it
                    beq       Branch_040 ; branch when the values are equal or the result is zero; target Branch_040
                    addd      WorkWord_001,u ; add to d using WorkWord_001,u
                    dec       WorkByte_007,u ; decrement the value at WorkByte_007,u
                    bra       Branch_039 ; continue execution at Branch_039
Branch_040          std       WorkWord_001,u ; store d at WorkWord_001,u
                    bra       Branch_035 ; continue execution at Branch_035
Branch_036          ldd       WorkByte_008,u ; load d from WorkByte_008,u
                    puls      x         ; restore x from the stack
                    puls      pc,y      ; restore pc,y and return to the caller
Routine_001         pshs      x         ; save x on the stack
                    std       WorkByte_008,u ; store d at WorkByte_008,u
                    lda       #48       ; set a to the constant 48
                    sta       ,x        ; store a at ,x
                    sta       $01,x     ; store a at $01,x
                    sta       $02,x     ; store a at $02,x
                    sta       $03,x     ; store a at $03,x
                    sta       $04,x     ; store a at $04,x
                    ldd       #10000    ; set d to the constant 10000
                    std       WorkWord_001,u ; store d at WorkWord_001,u
                    ldd       WorkByte_008,u ; load d from WorkByte_008,u
                    lbsr      Routine_003 ; call subroutine Routine_003
                    ldd       #1000     ; set d to the constant 1000
                    std       WorkWord_001,u ; store d at WorkWord_001,u
                    ldd       WorkByte_008,u ; load d from WorkByte_008,u
                    bsr       Routine_003 ; call subroutine Routine_003
                    ldd       #100      ; set d to the constant 100
                    std       WorkWord_001,u ; store d at WorkWord_001,u
                    ldd       WorkByte_008,u ; load d from WorkByte_008,u
                    bsr       Routine_003 ; call subroutine Routine_003
                    ldd       #10       ; set d to the constant 10
                    std       WorkWord_001,u ; store d at WorkWord_001,u
                    ldd       WorkByte_008,u ; load d from WorkByte_008,u
                    bsr       Routine_003 ; call subroutine Routine_003
                    ldd       #1        ; set d to the constant 1
                    std       WorkWord_001,u ; store d at WorkWord_001,u
                    ldd       WorkByte_008,u ; load d from WorkByte_008,u
                    bsr       Routine_003 ; call subroutine Routine_003
                    lda       #13       ; set a to the constant 13
                    sta       ,x        ; store a at ,x
                    puls      x         ; restore x from the stack
                    ldb       #32       ; set b to the constant 32
Branch_041          lda       ,x        ; load a from ,x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bne       Branch_042 ; branch when the values differ or the result is nonzero; target Branch_042
                    stb       ,x+       ; store b at ,x+
                    bra       Branch_041 ; continue execution at Branch_041
Branch_042          lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_043 ; branch when carry reports an error or unsigned underflow; target Branch_043
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_043 ; branch when the unsigned value is higher; target Branch_043
                    bra       Branch_042 ; continue execution at Branch_042
Branch_043          leax      -$01,x    ; form the address -$01,x in x
                    rts                 ; return to the caller
Routine_003         subd      WorkWord_001,u ; subtract from d using WorkWord_001,u
                    bcs       Branch_044 ; branch when carry reports an error or unsigned underflow; target Branch_044
                    inc       ,x        ; increment the value at ,x
                    bra       Routine_003 ; continue execution at Routine_003
Branch_044          addd      WorkWord_001,u ; add to d using WorkWord_001,u
                    std       WorkByte_008,u ; store d at WorkByte_008,u
                    leax      $01,x     ; form the address $01,x in x
                    rts                 ; return to the caller
Branch_032          ldd       #-1       ; set d to the constant -1
                    puls      pc,y      ; restore pc,y and return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
