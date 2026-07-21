**********************************************************************
* BBS.forward - OS-9 Level 2 BBS command
*
* Syntax: BBS.forward
* Purpose: Read forward through the current message base from a selected position.
* Data: bbs.msg and bbs.msg.inx.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       BBS.forward
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
WorkWord_003        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_004        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_001      rmb       6         ; reserve 6 byte(s) in the module workspace
WorkWord_005        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_006        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_007        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_002      rmb       18        ; reserve 18 byte(s) in the module workspace
WorkByte_009        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_010        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_008        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_009        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_010        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_003      rmb       6         ; reserve 6 byte(s) in the module workspace
WorkBuffer_004      rmb       3         ; reserve 3 byte(s) in the module workspace
WorkByte_011        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_011        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_012        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_005      rmb       6         ; reserve 6 byte(s) in the module workspace
WorkByte_013        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_014        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_012        rmb       2         ; reserve 2 byte(s) in the module workspace
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
WorkByte_028        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_029        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_006      rmb       64        ; reserve 64 byte(s) in the module workspace
WorkBuffer_007      rmb       80        ; reserve 80 byte(s) in the module workspace
WorkWord_013        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_014        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_008      rmb       20        ; reserve 20 byte(s) in the module workspace
WorkBuffer_009      rmb       30        ; reserve 30 byte(s) in the module workspace
WorkByte_030        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_031        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_032        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_033        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_010      rmb       4         ; reserve 4 byte(s) in the module workspace
WorkWord_015        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_034        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_011      rmb       399       ; reserve 399 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.forward/ ; store an OS-9 high-bit-terminated string
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
Text_001            fcc       "High message is #" ; store literal character data
Data_001            fcb       $00       ; store byte data
                    fcb       $11       ; store byte data
Text_002            fcc       "Enter starting message #" ; store literal character data
                    fcb       $0D       ; store byte data
Text_003            fcc       ">" ; store literal character data
Text_004            fcc       "BBS.msg.inx" ; store literal character data
                    fcb       $0D       ; store byte data
Text_005            fcc       "BBS.msg" ; store literal character data
                    fcb       $0D       ; store byte data
Text_006            fcc       "******   DELETED   ******" ; store literal character data
                    fcb       $0D       ; store byte data
Text_007            fcc       "Message :" ; store literal character data
Text_008            fcc       "From    :" ; store literal character data
Text_009            fcc       "To      :" ; store literal character data
Text_010            fcc       "Left on :" ; store literal character data
Text_011            fcc       "About   :" ; store literal character data
Data_002            fcb       $00       ; store byte data
                    fcb       $09       ; store byte data
Text_012            fcc       "----------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
Data_003            fcb       $0A       ; store byte data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
Text_013            fcc       "Press <SPACE> to skip a message" ; store literal character data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
Text_014            fcc       "BBS.msg.lst" ; store literal character data
                    fcb       $0D       ; store byte data
Text_015            fcc       "/dd/bbs/BBS.userstats" ; store literal character data
                    fcb       $0D       ; store byte data
Text_016            fcc       "/dd/bbs/BBS.alias" ; store literal character data
                    fcb       $0D       ; store byte data
Text_017            fcc       "Unknown User" ; store literal character data
                    fcb       $0D       ; store byte data
Text_018            fcc       "All Users" ; store literal character data
                    fcb       $0D       ; store byte data

start               os9       F$ID      ; retrieve the current process and user IDs
                    sty       WorkWord_002,u ; store y at WorkWord_002,u
                    ldd       #0        ; set d to the constant 0
                    std       WorkWord_001,u ; store d at WorkWord_001,u
                    ldy       #0        ; set y to the constant 0
                    os9       F$SUser   ; change the process user ID to Y
                    leax      >Text_004,pc ; form the address >Text_004,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    sta       WorkByte_002,u ; store a at WorkByte_002,u
                    leax      >Text_014,pc ; form the address >Text_014,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    bcc       Branch_002 ; branch when carry is clear; target Branch_002
                    cmpb      #216      ; compare b with #216 and set the condition codes
                    lbne      Branch_001 ; branch when the values differ or the result is nonzero; target Branch_001
                    ldb       #11       ; set b to the constant 11
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
Branch_002          sta       WorkByte_004,u ; store a at WorkByte_004,u
                    leax      >Text_005,pc ; form the address >Text_005,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    sta       WorkByte_003,u ; store a at WorkByte_003,u
                    leax      <WorkBuffer_006,u ; form the address <WorkBuffer_006,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       WorkByte_002,u ; load a from WorkByte_002,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    ldd       <WorkBuffer_006,u ; load d from <WorkBuffer_006,u
                    leax      <WorkBuffer_003,u ; form the address <WorkBuffer_003,u in x
                    lbsr      Routine_001 ; call subroutine Routine_001
                    leax      >Text_001,pc ; form the address >Text_001,pc in x
                    ldy       >Data_001,pc ; load y from >Data_001,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      <WorkBuffer_003,u ; form the address <WorkBuffer_003,u in x
                    ldy       #6        ; set y to the constant 6
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      >Text_002,pc ; form the address >Text_002,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      >Text_003,pc ; form the address >Text_003,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      <WorkBuffer_005,u ; form the address <WorkBuffer_005,u in x
                    ldy       #6        ; set y to the constant 6
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    clr       <WorkByte_012,u ; clear <WorkByte_012,u to zero and set the condition codes
                    leax      <WorkBuffer_005,u ; form the address <WorkBuffer_005,u in x
                    lbsr      Routine_002 ; call subroutine Routine_002
                    cmpd      #1        ; compare d with #1 and set the condition codes
                    lbcs      Branch_003 ; branch when carry reports an error or unsigned underflow; target Branch_003
                    cmpd      <WorkBuffer_006,u ; compare d with <WorkBuffer_006,u and set the condition codes
                    lbhi      Branch_003 ; branch when the unsigned value is higher; target Branch_003
                    std       <WorkBuffer_003,u ; store d at <WorkBuffer_003,u
                    clr       <WorkByte_013,u ; clear <WorkByte_013,u to zero and set the condition codes
                    clr       <WorkByte_014,u ; clear <WorkByte_014,u to zero and set the condition codes
                    lda       #6        ; set a to the constant 6
                    sta       WorkByte_006,u ; store a at WorkByte_006,u
                    ldd       <WorkBuffer_003,u ; load d from <WorkBuffer_003,u
Branch_004          aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    rol       <WorkByte_014,u ; rotate left through carry the value at <WorkByte_014,u
                    dec       WorkByte_006,u ; decrement the value at WorkByte_006,u
                    bne       Branch_004 ; branch when the values differ or the result is nonzero; target Branch_004
                    std       <WorkWord_012,u ; store d at <WorkWord_012,u
                    ldx       <WorkByte_013,u ; load x from <WorkByte_013,u
                    lda       WorkByte_002,u ; load a from WorkByte_002,u
                    pshs      u         ; save u on the stack
                    ldu       <WorkWord_012,u ; load u from <WorkWord_012,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    puls      u         ; restore u from the stack
                    ldd       <WorkBuffer_003,u ; load d from <WorkBuffer_003,u
                    subd      #1        ; subtract from d using #1
                    std       <WorkBuffer_003,u ; store d at <WorkBuffer_003,u
Branch_005          lda       WorkByte_004,u ; load a from WorkByte_004,u
                    leax      <WorkWord_009,u ; form the address <WorkWord_009,u in x
                    ldy       #4        ; set y to the constant 4
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcs       Branch_006 ; branch when carry reports an error or unsigned underflow; target Branch_006
                    ldd       <WorkWord_009,u ; load d from <WorkWord_009,u
                    cmpd      WorkWord_002,u ; compare d with WorkWord_002,u and set the condition codes
                    bne       Branch_005 ; branch when the values differ or the result is nonzero; target Branch_005
                    ldd       <WorkWord_010,u ; load d from <WorkWord_010,u
                    cmpd      <WorkBuffer_006,u ; compare d with <WorkBuffer_006,u and set the condition codes
                    bcc       Branch_007 ; branch when carry is clear; target Branch_007
                    pshs      u         ; save u on the stack
                    lda       WorkByte_004,u ; load a from WorkByte_004,u
                    ldb       #5        ; set b to the constant 5
                    os9       I$GetStt  ; query status code B for path A
                    leau      -$02,u    ; form the workspace or data address -$02,u in u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    puls      u         ; restore u from the stack
                    leax      <WorkBuffer_006,u ; form the address <WorkBuffer_006,u in x
                    ldy       #2        ; set y to the constant 2
                    os9       I$Write   ; write Y bytes from X to path A
                    bra       Branch_007 ; continue execution at Branch_007
Branch_006          cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      Branch_001 ; branch when the values differ or the result is nonzero; target Branch_001
                    lda       WorkByte_004,u ; load a from WorkByte_004,u
                    leax      WorkWord_002,u ; form the address WorkWord_002,u in x
                    ldy       #2        ; set y to the constant 2
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      <WorkBuffer_006,u ; form the address <WorkBuffer_006,u in x
                    os9       I$Write   ; write Y bytes from X to path A
Branch_007          lda       WorkByte_004,u ; load a from WorkByte_004,u
                    os9       I$Close   ; close path A
                    leax      >Text_013,pc ; form the address >Text_013,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
Branch_008          lda       WorkByte_002,u ; load a from WorkByte_002,u
                    ldy       #64       ; set y to the constant 64
                    leax      >WorkWord_013,u ; form the address >WorkWord_013,u in x
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lbcs      Branch_009 ; branch when carry reports an error or unsigned underflow; target Branch_009
                    ldd       <WorkBuffer_003,u ; load d from <WorkBuffer_003,u
                    addd      #1        ; add to d using #1
                    std       <WorkBuffer_003,u ; store d at <WorkBuffer_003,u
                    leax      >Data_003,pc ; form the address >Data_003,pc in x
                    ldy       #2        ; set y to the constant 2
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    ldd       <WorkBuffer_003,u ; load d from <WorkBuffer_003,u
                    leax      <WorkBuffer_004,u ; form the address <WorkBuffer_004,u in x
                    lbsr      Routine_001 ; call subroutine Routine_001
                    leax      >Text_007,pc ; form the address >Text_007,pc in x
                    ldy       >Data_002,pc ; load y from >Data_002,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      <WorkBuffer_004,u ; form the address <WorkBuffer_004,u in x
Branch_010          lda       ,x+       ; load a from ,x+
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       Branch_010 ; branch when the values are equal or the result is zero; target Branch_010
                    leax      -$01,x    ; form the address -$01,x in x
                    ldy       #6        ; set y to the constant 6
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    ldd       >WorkWord_013,u ; load d from >WorkWord_013,u
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    lbeq      Branch_011 ; branch when the values are equal or the result is zero; target Branch_011
                    leax      >Text_008,pc ; form the address >Text_008,pc in x
                    ldy       >Data_002,pc ; load y from >Data_002,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >WorkBuffer_008,u ; form the address >WorkBuffer_008,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      >Text_009,pc ; form the address >Text_009,pc in x
                    ldy       >Data_002,pc ; load y from >Data_002,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    ldd       >WorkWord_015,u ; load d from >WorkWord_015,u
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    beq       Branch_012 ; branch when the values are equal or the result is zero; target Branch_012
                    leax      >Text_016,pc ; form the address >Text_016,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    sta       WorkByte_005,u ; store a at WorkByte_005,u
Branch_013          leax      >WorkByte_034,u ; form the address >WorkByte_034,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       WorkByte_005,u ; load a from WorkByte_005,u
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    bcs       Branch_014 ; branch when carry reports an error or unsigned underflow; target Branch_014
                    leax      >WorkByte_034,u ; form the address >WorkByte_034,u in x
Branch_015          lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    bne       Branch_015 ; branch when the values differ or the result is nonzero; target Branch_015
                    lda       #13       ; set a to the constant 13
                    sta       -$01,x    ; store a at -$01,x
                    lbsr      Routine_002 ; call subroutine Routine_002
                    cmpd      >WorkWord_015,u ; compare d with >WorkWord_015,u and set the condition codes
                    bne       Branch_013 ; branch when the values differ or the result is nonzero; target Branch_013
                    leax      >WorkByte_034,u ; form the address >WorkByte_034,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       WorkByte_005,u ; load a from WorkByte_005,u
                    os9       I$Close   ; close path A
                    lbra      Branch_016 ; continue execution at Branch_016
Branch_014          leax      >Text_017,pc ; form the address >Text_017,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       WorkByte_005,u ; load a from WorkByte_005,u
                    os9       I$Close   ; close path A
                    lbra      Branch_016 ; continue execution at Branch_016
Branch_012          leax      >Text_018,pc ; form the address >Text_018,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
Branch_016          leax      >Text_010,pc ; form the address >Text_010,pc in x
                    ldy       >Data_002,pc ; load y from >Data_002,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      <WorkBuffer_004,u ; form the address <WorkBuffer_004,u in x
                    ldb       >WorkByte_031,u ; load b from >WorkByte_031,u
                    clra                ; clear a to zero and set the condition codes
                    lbsr      Routine_001 ; call subroutine Routine_001
                    lda       <WorkByte_011,u ; load a from <WorkByte_011,u
                    sta       <WorkByte_015,u ; store a at <WorkByte_015,u
                    lda       <WorkWord_011,u ; load a from <WorkWord_011,u
                    sta       <WorkByte_016,u ; store a at <WorkByte_016,u
                    lda       #47       ; set a to the constant 47
                    sta       <WorkByte_017,u ; store a at <WorkByte_017,u
                    ldb       >WorkByte_032,u ; load b from >WorkByte_032,u
                    clra                ; clear a to zero and set the condition codes
                    leax      <WorkBuffer_004,u ; form the address <WorkBuffer_004,u in x
                    lbsr      Routine_001 ; call subroutine Routine_001
                    lda       <WorkByte_011,u ; load a from <WorkByte_011,u
                    sta       <WorkByte_018,u ; store a at <WorkByte_018,u
                    lda       <WorkWord_011,u ; load a from <WorkWord_011,u
                    sta       <WorkByte_019,u ; store a at <WorkByte_019,u
                    lda       #47       ; set a to the constant 47
                    sta       <WorkByte_020,u ; store a at <WorkByte_020,u
                    ldb       >WorkByte_030,u ; load b from >WorkByte_030,u
                    clra                ; clear a to zero and set the condition codes
                    leax      <WorkBuffer_004,u ; form the address <WorkBuffer_004,u in x
                    lbsr      Routine_001 ; call subroutine Routine_001
                    lda       <WorkByte_011,u ; load a from <WorkByte_011,u
                    sta       <WorkByte_021,u ; store a at <WorkByte_021,u
                    lda       <WorkWord_011,u ; load a from <WorkWord_011,u
                    sta       <WorkByte_022,u ; store a at <WorkByte_022,u
                    lda       #32       ; set a to the constant 32
                    sta       <WorkByte_023,u ; store a at <WorkByte_023,u
                    ldb       >WorkByte_033,u ; load b from >WorkByte_033,u
                    clra                ; clear a to zero and set the condition codes
                    leax      <WorkBuffer_004,u ; form the address <WorkBuffer_004,u in x
                    lbsr      Routine_001 ; call subroutine Routine_001
                    lda       <WorkByte_011,u ; load a from <WorkByte_011,u
                    sta       <WorkByte_024,u ; store a at <WorkByte_024,u
                    lda       <WorkWord_011,u ; load a from <WorkWord_011,u
                    sta       <WorkByte_025,u ; store a at <WorkByte_025,u
                    lda       #58       ; set a to the constant 58
                    sta       <WorkByte_026,u ; store a at <WorkByte_026,u
                    ldb       >WorkBuffer_010,u ; load b from >WorkBuffer_010,u
                    clra                ; clear a to zero and set the condition codes
                    leax      <WorkBuffer_004,u ; form the address <WorkBuffer_004,u in x
                    lbsr      Routine_001 ; call subroutine Routine_001
                    lda       <WorkByte_011,u ; load a from <WorkByte_011,u
                    sta       <WorkByte_027,u ; store a at <WorkByte_027,u
                    lda       <WorkWord_011,u ; load a from <WorkWord_011,u
                    sta       <WorkByte_028,u ; store a at <WorkByte_028,u
                    lda       #13       ; set a to the constant 13
                    sta       <WorkByte_029,u ; store a at <WorkByte_029,u
                    leax      <WorkByte_015,u ; form the address <WorkByte_015,u in x
Branch_017          lda       ,x+       ; load a from ,x+
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       Branch_017 ; branch when the values are equal or the result is zero; target Branch_017
                    leax      -$01,x    ; form the address -$01,x in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      >Text_011,pc ; form the address >Text_011,pc in x
                    ldy       >Data_002,pc ; load y from >Data_002,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >WorkBuffer_009,u ; form the address >WorkBuffer_009,u in x
                    ldy       #30       ; set y to the constant 30
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    bra       Branch_018 ; continue execution at Branch_018
Branch_011          leax      >Text_006,pc ; form the address >Text_006,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbra      Branch_008 ; continue execution at Branch_008
Branch_018          leax      >Text_012,pc ; form the address >Text_012,pc in x
                    ldy       #80       ; set y to the constant 80
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       WorkByte_003,u ; load a from WorkByte_003,u
                    ldx       >WorkWord_013,u ; load x from >WorkWord_013,u
                    pshs      u         ; save u on the stack
                    ldu       >WorkWord_014,u ; load u from >WorkWord_014,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    puls      u         ; restore u from the stack
Branch_019          clra                ; clear a to zero and set the condition codes
                    ldb       #1        ; set b to the constant 1
                    os9       I$GetStt  ; query status code B for path A
                    bcs       Branch_020 ; branch when carry reports an error or unsigned underflow; target Branch_020
                    leax      WorkByte_001,u ; form the address WorkByte_001,u in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    lbeq      Branch_008 ; branch when the values are equal or the result is zero; target Branch_008
Branch_020          lda       WorkByte_003,u ; load a from WorkByte_003,u
                    leax      >WorkBuffer_007,u ; form the address >WorkBuffer_007,u in x
                    ldy       #80       ; set y to the constant 80
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bhi       Branch_019 ; branch when the unsigned value is higher; target Branch_019
                    leax      >Text_012,pc ; form the address >Text_012,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Data_003,pc ; form the address >Data_003,pc in x
                    ldy       #5        ; set y to the constant 5
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    ldd       WorkWord_001,u ; load d from WorkWord_001,u
                    addd      #1        ; add to d using #1
                    std       WorkWord_001,u ; store d at WorkWord_001,u
                    lbra      Branch_008 ; continue execution at Branch_008
Branch_009          leax      >Text_015,pc ; form the address >Text_015,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    bcc       Branch_021 ; branch when carry is clear; target Branch_021
                    ldb       #27       ; set b to the constant 27
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
Branch_021          sta       WorkByte_008,u ; store a at WorkByte_008,u
Branch_022          leax      WorkWord_003,u ; form the address WorkWord_003,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       WorkByte_008,u ; load a from WorkByte_008,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcs       Branch_023 ; branch when carry reports an error or unsigned underflow; target Branch_023
                    ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    cmpd      WorkWord_002,u ; compare d with WorkWord_002,u and set the condition codes
                    bne       Branch_022 ; branch when the values differ or the result is nonzero; target Branch_022
                    bra       Branch_024 ; continue execution at Branch_024
Branch_023          cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      Branch_001 ; branch when the values differ or the result is nonzero; target Branch_001
                    lbra      Branch_025 ; continue execution at Branch_025
Branch_024          ldd       <WorkWord_006,u ; load d from <WorkWord_006,u
                    addd      WorkWord_001,u ; add to d using WorkWord_001,u
                    std       <WorkWord_006,u ; store d at <WorkWord_006,u
                    lda       WorkByte_008,u ; load a from WorkByte_008,u
                    ldb       #5        ; set b to the constant 5
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; query status code B for path A
                    tfr       u,d       ; copy the register values specified by u,d
                    subd      #32       ; subtract from d using #32
                    bge       Branch_026 ; branch when the signed value is greater than or equal; target Branch_026
                    leax      -$01,x    ; form the address -$01,x in x
Branch_026          ldu       ,s        ; load u from the current stack frame at ,s
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       WorkByte_008,u ; load a from WorkByte_008,u
                    tfr       y,u       ; copy the register values specified by y,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    puls      u         ; restore u from the stack
                    leax      WorkWord_003,u ; form the address WorkWord_003,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       WorkByte_008,u ; load a from WorkByte_008,u
                    os9       I$Write   ; write Y bytes from X to path A
                    os9       I$Close   ; close path A
                    lbra      Branch_003 ; continue execution at Branch_003
Branch_025          leax      WorkWord_003,u ; form the address WorkWord_003,u in x
                    ldd       #1        ; set d to the constant 1
                    std       WorkWord_004,u ; store d at WorkWord_004,u
                    std       <WorkWord_006,u ; store d at <WorkWord_006,u
                    ldd       #0        ; set d to the constant 0
                    std       <WorkWord_005,u ; store d at <WorkWord_005,u
                    std       <WorkBuffer_002,u ; store d at <WorkBuffer_002,u
                    std       <WorkWord_007,u ; store d at <WorkWord_007,u
                    ldd       WorkWord_002,u ; load d from WorkWord_002,u
                    std       WorkWord_003,u ; store d at WorkWord_003,u
                    leax      <WorkBuffer_001,u ; form the address <WorkBuffer_001,u in x
                    os9       F$Time    ; read the current system date and time
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      WorkWord_003,u ; form the address WorkWord_003,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       WorkByte_008,u ; load a from WorkByte_008,u
                    os9       I$Write   ; write Y bytes from X to path A
                    os9       I$Close   ; close path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
Branch_003          clrb                ; clear b to zero and set the condition codes
Branch_001          os9       F$Exit    ; terminate the process with status B
Routine_002         pshs      y         ; save y on the stack
Branch_027          lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      Branch_028 ; branch when the values are equal or the result is zero; target Branch_028
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_027 ; branch when carry reports an error or unsigned underflow; target Branch_027
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_027 ; branch when the unsigned value is higher; target Branch_027
                    leax      -$01,x    ; form the address -$01,x in x
Branch_029          lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_030 ; branch when carry reports an error or unsigned underflow; target Branch_030
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_030 ; branch when the unsigned value is higher; target Branch_030
                    bra       Branch_029 ; continue execution at Branch_029
Branch_030          pshs      x         ; save x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    clr       <WorkByte_009,u ; clear <WorkByte_009,u to zero and set the condition codes
                    clr       <WorkByte_010,u ; clear <WorkByte_010,u to zero and set the condition codes
                    ldd       #1        ; set d to the constant 1
                    std       <WorkWord_008,u ; store d at <WorkWord_008,u
Branch_031          lda       ,-x       ; load a from ,-x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_032 ; branch when carry reports an error or unsigned underflow; target Branch_032
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_032 ; branch when the unsigned value is higher; target Branch_032
                    suba      #48       ; subtract from a using #48
                    sta       WorkByte_007,u ; store a at WorkByte_007,u
                    ldd       #0        ; set d to the constant 0
Branch_033          tst       WorkByte_007,u ; set condition codes from WorkByte_007,u without changing it
                    beq       Branch_034 ; branch when the values are equal or the result is zero; target Branch_034
                    addd      <WorkWord_008,u ; add to d using <WorkWord_008,u
                    dec       WorkByte_007,u ; decrement the value at WorkByte_007,u
                    bra       Branch_033 ; continue execution at Branch_033
Branch_034          addd      <WorkByte_009,u ; add to d using <WorkByte_009,u
                    std       <WorkByte_009,u ; store d at <WorkByte_009,u
                    lda       #10       ; set a to the constant 10
                    sta       WorkByte_007,u ; store a at WorkByte_007,u
                    ldd       #0        ; set d to the constant 0
Branch_035          tst       WorkByte_007,u ; set condition codes from WorkByte_007,u without changing it
                    beq       Branch_036 ; branch when the values are equal or the result is zero; target Branch_036
                    addd      <WorkWord_008,u ; add to d using <WorkWord_008,u
                    dec       WorkByte_007,u ; decrement the value at WorkByte_007,u
                    bra       Branch_035 ; continue execution at Branch_035
Branch_036          std       <WorkWord_008,u ; store d at <WorkWord_008,u
                    bra       Branch_031 ; continue execution at Branch_031
Branch_032          ldd       <WorkByte_009,u ; load d from <WorkByte_009,u
                    puls      x         ; restore x from the stack
                    puls      pc,y      ; restore pc,y and return to the caller
Routine_001         pshs      x         ; save x on the stack
                    std       <WorkByte_009,u ; store d at <WorkByte_009,u
                    lda       #48       ; set a to the constant 48
                    sta       ,x        ; store a at ,x
                    sta       $01,x     ; store a at $01,x
                    sta       $02,x     ; store a at $02,x
                    sta       $03,x     ; store a at $03,x
                    sta       $04,x     ; store a at $04,x
                    ldd       #10000    ; set d to the constant 10000
                    std       <WorkWord_008,u ; store d at <WorkWord_008,u
                    ldd       <WorkByte_009,u ; load d from <WorkByte_009,u
                    lbsr      Routine_003 ; call subroutine Routine_003
                    ldd       #1000     ; set d to the constant 1000
                    std       <WorkWord_008,u ; store d at <WorkWord_008,u
                    ldd       <WorkByte_009,u ; load d from <WorkByte_009,u
                    bsr       Routine_003 ; call subroutine Routine_003
                    ldd       #100      ; set d to the constant 100
                    std       <WorkWord_008,u ; store d at <WorkWord_008,u
                    ldd       <WorkByte_009,u ; load d from <WorkByte_009,u
                    bsr       Routine_003 ; call subroutine Routine_003
                    ldd       #10       ; set d to the constant 10
                    std       <WorkWord_008,u ; store d at <WorkWord_008,u
                    ldd       <WorkByte_009,u ; load d from <WorkByte_009,u
                    bsr       Routine_003 ; call subroutine Routine_003
                    ldd       #1        ; set d to the constant 1
                    std       <WorkWord_008,u ; store d at <WorkWord_008,u
                    ldd       <WorkByte_009,u ; load d from <WorkByte_009,u
                    bsr       Routine_003 ; call subroutine Routine_003
                    lda       #13       ; set a to the constant 13
                    sta       ,x        ; store a at ,x
                    puls      x         ; restore x from the stack
                    ldb       #32       ; set b to the constant 32
Branch_037          lda       ,x        ; load a from ,x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bne       Branch_038 ; branch when the values differ or the result is nonzero; target Branch_038
                    stb       ,x+       ; store b at ,x+
                    bra       Branch_037 ; continue execution at Branch_037
Branch_038          lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_039 ; branch when carry reports an error or unsigned underflow; target Branch_039
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_039 ; branch when the unsigned value is higher; target Branch_039
                    bra       Branch_038 ; continue execution at Branch_038
Branch_039          leax      -$01,x    ; form the address -$01,x in x
                    rts                 ; return to the caller
Routine_003         subd      <WorkWord_008,u ; subtract from d using <WorkWord_008,u
                    bcs       Branch_040 ; branch when carry reports an error or unsigned underflow; target Branch_040
                    inc       ,x        ; increment the value at ,x
                    bra       Routine_003 ; continue execution at Routine_003
Branch_040          addd      <WorkWord_008,u ; add to d using <WorkWord_008,u
                    std       <WorkByte_009,u ; store d at <WorkByte_009,u
                    leax      $01,x     ; form the address $01,x in x
                    rts                 ; return to the caller
Branch_028          ldd       #-1       ; set d to the constant -1
                    puls      pc,y      ; restore pc,y and return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
