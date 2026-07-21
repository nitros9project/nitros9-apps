**********************************************************************
* BBS.read - OS-9 Level 2 BBS command
*
* Syntax: BBS.read
* Purpose: Read messages and navigate next, previous, reply, and thread relationships.
* Separates visible message numbers, index records, and body-file offsets.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       BBS.read
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
WorkBuffer_001      rmb       3         ; reserve 3 byte(s) in the module workspace
WorkByte_007        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_008        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_001        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_002        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_003        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_004        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_005        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_006        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_002      rmb       6         ; reserve 6 byte(s) in the module workspace
WorkBuffer_003      rmb       3         ; reserve 3 byte(s) in the module workspace
WorkByte_009        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_007        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_010        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_004      rmb       6         ; reserve 6 byte(s) in the module workspace
WorkByte_011        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_012        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_008        rmb       2         ; reserve 2 byte(s) in the module workspace
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
WorkBuffer_005      rmb       64        ; reserve 64 byte(s) in the module workspace
WorkWord_009        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_010        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_006      rmb       6         ; reserve 6 byte(s) in the module workspace
WorkWord_011        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_012        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_013        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_007      rmb       16        ; reserve 16 byte(s) in the module workspace
WorkBuffer_008      rmb       80        ; reserve 80 byte(s) in the module workspace
WorkWord_014        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_015        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_009      rmb       20        ; reserve 20 byte(s) in the module workspace
WorkBuffer_010      rmb       30        ; reserve 30 byte(s) in the module workspace
WorkByte_028        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_029        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_030        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_031        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_011      rmb       4         ; reserve 4 byte(s) in the module workspace
WorkWord_016        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_012      rmb       24        ; reserve 24 byte(s) in the module workspace
WorkBuffer_013      rmb       40        ; reserve 40 byte(s) in the module workspace
WorkByte_032        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_014      rmb       399       ; reserve 399 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.read/ ; store an OS-9 high-bit-terminated string
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
Data_001            fcb       $0A       ; store byte data
                    fcc       "High    message is #" ; store literal character data
Text_001            fcc       "Current message is #" ; store literal character data
Text_002            fcc       "[N]ext, [P]revious, [T]hread, [R]eply, [Q]uit or Msg #" ; store literal character data
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
                    fcb       $0D       ; store byte data
Text_013            fcc       "BBS.msg.lst" ; store literal character data
                    fcb       $0D       ; store byte data
Text_014            fcc       "BBS.reply" ; store literal character data
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
                    ldy       #0        ; set y to the constant 0
                    os9       F$SUser   ; change the process user ID to Y
                    sty       <WorkWord_006,u ; store y at <WorkWord_006,u
                    leax      >Text_004,pc ; form the address >Text_004,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    sta       WorkByte_001,u ; store a at WorkByte_001,u
                    leax      >Text_013,pc ; form the address >Text_013,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    bcc       Branch_002 ; branch when carry is clear; target Branch_002
                    ldb       #3        ; set b to the constant 3
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
Branch_002          sta       WorkByte_003,u ; store a at WorkByte_003,u
                    leax      >Text_005,pc ; form the address >Text_005,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    sta       WorkByte_002,u ; store a at WorkByte_002,u
                    leax      <WorkBuffer_005,u ; form the address <WorkBuffer_005,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    ldd       #0        ; set d to the constant 0
                    std       <WorkWord_005,u ; store d at <WorkWord_005,u
Branch_003          ldd       <WorkBuffer_005,u ; load d from <WorkBuffer_005,u
                    leax      <WorkBuffer_002,u ; form the address <WorkBuffer_002,u in x
                    lbsr      Routine_001 ; call subroutine Routine_001
                    leax      >Data_001,pc ; form the address >Data_001,pc in x
                    ldy       #21       ; set y to the constant 21
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      <WorkBuffer_002,u ; form the address <WorkBuffer_002,u in x
                    ldy       #6        ; set y to the constant 6
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    ldd       <WorkWord_005,u ; load d from <WorkWord_005,u
                    leax      <WorkBuffer_002,u ; form the address <WorkBuffer_002,u in x
                    lbsr      Routine_001 ; call subroutine Routine_001
                    leax      >Text_001,pc ; form the address >Text_001,pc in x
                    ldy       #20       ; set y to the constant 20
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      <WorkBuffer_002,u ; form the address <WorkBuffer_002,u in x
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
                    leax      <WorkBuffer_004,u ; form the address <WorkBuffer_004,u in x
                    ldy       #6        ; set y to the constant 6
                    clra                ; clear a to zero and set the condition codes
Branch_004          os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    bcs       Branch_004 ; branch when carry reports an error or unsigned underflow; target Branch_004
                    lda       <WorkBuffer_004,u ; load a from <WorkBuffer_004,u
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    blt       Branch_005 ; branch when the signed value is less; target Branch_005
                    anda      #223      ; mask a using #223
                    cmpa      #81       ; compare a with #81 and set the condition codes
                    lbeq      Branch_006 ; branch when the values are equal or the result is zero; target Branch_006
                    cmpa      #78       ; compare a with #78 and set the condition codes
                    lbeq      Branch_007 ; branch when the values are equal or the result is zero; target Branch_007
                    cmpa      #80       ; compare a with #80 and set the condition codes
                    lbeq      Branch_008 ; branch when the values are equal or the result is zero; target Branch_008
                    cmpa      #84       ; compare a with #84 and set the condition codes
                    lbeq      Branch_009 ; branch when the values are equal or the result is zero; target Branch_009
                    cmpa      #82       ; compare a with #82 and set the condition codes
                    lbeq      Branch_010 ; branch when the values are equal or the result is zero; target Branch_010
Branch_005          clr       <WorkByte_010,u ; clear <WorkByte_010,u to zero and set the condition codes
                    leax      <WorkBuffer_004,u ; form the address <WorkBuffer_004,u in x
                    lbsr      Routine_002 ; call subroutine Routine_002
                    cmpd      #0        ; compare d with #0 and set the condition codes
                    lbeq      Branch_003 ; branch when the values are equal or the result is zero; target Branch_003
                    cmpd      <WorkBuffer_005,u ; compare d with <WorkBuffer_005,u and set the condition codes
                    lbhi      Branch_003 ; branch when the unsigned value is higher; target Branch_003
                    std       <WorkWord_005,u ; store d at <WorkWord_005,u
                    lbra      Branch_011 ; continue execution at Branch_011
Branch_007          ldd       <WorkWord_005,u ; load d from <WorkWord_005,u
                    addd      #1        ; add to d using #1
                    cmpd      <WorkBuffer_005,u ; compare d with <WorkBuffer_005,u and set the condition codes
                    lbgt      Branch_003 ; branch when the signed value is greater; target Branch_003
                    std       <WorkWord_005,u ; store d at <WorkWord_005,u
                    lbra      Branch_011 ; continue execution at Branch_011
Branch_008          ldd       <WorkWord_005,u ; load d from <WorkWord_005,u
                    subd      #1        ; subtract from d using #1
                    lbeq      Branch_003 ; branch when the values are equal or the result is zero; target Branch_003
                    std       <WorkWord_005,u ; store d at <WorkWord_005,u
                    lbra      Branch_011 ; continue execution at Branch_011
Branch_009          leax      >WorkBuffer_012,u ; form the address >WorkBuffer_012,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcs       Branch_012 ; branch when carry reports an error or unsigned underflow; target Branch_012
                    ldd       <WorkWord_005,u ; load d from <WorkWord_005,u
                    addd      #1        ; add to d using #1
                    std       <WorkWord_005,u ; store d at <WorkWord_005,u
                    leay      >WorkBuffer_010,u ; form the address >WorkBuffer_010,u in y
                    leax      >WorkBuffer_013,u ; form the address >WorkBuffer_013,u in x
Branch_013          lda       ,x        ; load a from ,x
                    anda      #223      ; mask a using #223
                    sta       ,x        ; store a at ,x
                    lda       ,y+       ; load a from ,y+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_014 ; branch when the values are equal or the result is zero; target Branch_014
                    anda      #223      ; mask a using #223
                    cmpa      ,x+       ; compare a with ,x+ and set the condition codes
                    bne       Branch_009 ; branch when the values differ or the result is nonzero; target Branch_009
                    bra       Branch_013 ; continue execution at Branch_013
Branch_012          cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      Branch_001 ; branch when the values differ or the result is nonzero; target Branch_001
                    lbra      Branch_003 ; continue execution at Branch_003
Branch_014          ldd       <WorkWord_005,u ; load d from <WorkWord_005,u
                    lbra      Branch_011 ; continue execution at Branch_011
Branch_010          ldy       WorkWord_002,u ; load y from WorkWord_002,u
                    os9       F$SUser   ; change the process user ID to Y
                    lda       #17       ; set a to the constant 17
                    ldb       #3        ; set b to the constant 3
                    leax      >Text_014,pc ; form the address >Text_014,pc in x
                    ldy       #80       ; set y to the constant 80
                    pshs      u         ; save u on the stack
                    leau      >WorkBuffer_010,u ; form the workspace or data address >WorkBuffer_010,u in u
                    os9       F$Fork    ; spawn the module at X with parameters at U
                    puls      u         ; restore u from the stack
                    lbcs      Branch_003 ; branch when carry reports an error or unsigned underflow; target Branch_003
                    clrb                ; clear b to zero and set the condition codes
                    os9       F$Wait    ; wait for a child process to terminate
                    tstb                ; set condition codes from b without changing it
                    lbne      Branch_003 ; branch when the values differ or the result is nonzero; target Branch_003
                    ldy       #0        ; set y to the constant 0
                    os9       F$SUser   ; change the process user ID to Y
                    ldd       <WorkBuffer_005,u ; load d from <WorkBuffer_005,u
                    addd      #1        ; add to d using #1
                    std       <WorkBuffer_005,u ; store d at <WorkBuffer_005,u
                    lbra      Branch_003 ; continue execution at Branch_003
Branch_011          lda       WorkByte_003,u ; load a from WorkByte_003,u
                    leax      WorkWord_003,u ; form the address WorkWord_003,u in x
                    ldy       #4        ; set y to the constant 4
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcs       Branch_015 ; branch when carry reports an error or unsigned underflow; target Branch_015
                    ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    cmpd      WorkWord_002,u ; compare d with WorkWord_002,u and set the condition codes
                    bne       Branch_011 ; branch when the values differ or the result is nonzero; target Branch_011
                    ldd       <WorkWord_004,u ; load d from <WorkWord_004,u
                    cmpd      <WorkWord_005,u ; compare d with <WorkWord_005,u and set the condition codes
                    bcc       Branch_016 ; branch when carry is clear; target Branch_016
                    pshs      u         ; save u on the stack
                    lda       WorkByte_003,u ; load a from WorkByte_003,u
                    ldb       #5        ; set b to the constant 5
                    os9       I$GetStt  ; query status code B for path A
                    leau      -$02,u    ; form the workspace or data address -$02,u in u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    puls      u         ; restore u from the stack
                    leax      <WorkWord_005,u ; form the address <WorkWord_005,u in x
                    ldy       #2        ; set y to the constant 2
                    os9       I$Write   ; write Y bytes from X to path A
                    bra       Branch_016 ; continue execution at Branch_016
Branch_015          cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      Branch_001 ; branch when the values differ or the result is nonzero; target Branch_001
                    lda       WorkByte_003,u ; load a from WorkByte_003,u
                    leax      WorkWord_002,u ; form the address WorkWord_002,u in x
                    ldy       #2        ; set y to the constant 2
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      <WorkWord_005,u ; form the address <WorkWord_005,u in x
                    os9       I$Write   ; write Y bytes from X to path A
Branch_016          clr       <WorkByte_011,u ; clear <WorkByte_011,u to zero and set the condition codes
                    clr       <WorkByte_012,u ; clear <WorkByte_012,u to zero and set the condition codes
                    lda       #6        ; set a to the constant 6
                    sta       WorkByte_005,u ; store a at WorkByte_005,u
                    ldd       <WorkWord_005,u ; load d from <WorkWord_005,u
Branch_017          aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    rol       <WorkByte_012,u ; rotate left through carry the value at <WorkByte_012,u
                    dec       WorkByte_005,u ; decrement the value at WorkByte_005,u
                    bne       Branch_017 ; branch when the values differ or the result is nonzero; target Branch_017
                    std       <WorkWord_008,u ; store d at <WorkWord_008,u
                    ldx       <WorkByte_011,u ; load x from <WorkByte_011,u
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    pshs      u         ; save u on the stack
                    ldu       <WorkWord_008,u ; load u from <WorkWord_008,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    puls      u         ; restore u from the stack
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    ldy       #64       ; set y to the constant 64
                    leax      >WorkWord_014,u ; form the address >WorkWord_014,u in x
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lbcs      Branch_003 ; branch when carry reports an error or unsigned underflow; target Branch_003
                    leax      >Data_003,pc ; form the address >Data_003,pc in x
                    ldy       #2        ; set y to the constant 2
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    ldd       <WorkWord_005,u ; load d from <WorkWord_005,u
                    leax      <WorkBuffer_003,u ; form the address <WorkBuffer_003,u in x
                    lbsr      Routine_001 ; call subroutine Routine_001
                    leax      >Text_007,pc ; form the address >Text_007,pc in x
                    ldy       >Data_002,pc ; load y from >Data_002,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      <WorkBuffer_003,u ; form the address <WorkBuffer_003,u in x
Branch_018          lda       ,x+       ; load a from ,x+
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       Branch_018 ; branch when the values are equal or the result is zero; target Branch_018
                    leax      -$01,x    ; form the address -$01,x in x
                    ldy       #6        ; set y to the constant 6
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    ldd       >WorkWord_014,u ; load d from >WorkWord_014,u
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    lbeq      Branch_019 ; branch when the values are equal or the result is zero; target Branch_019
                    leax      >Text_008,pc ; form the address >Text_008,pc in x
                    ldy       >Data_002,pc ; load y from >Data_002,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >WorkBuffer_009,u ; form the address >WorkBuffer_009,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      >Text_009,pc ; form the address >Text_009,pc in x
                    ldy       >Data_002,pc ; load y from >Data_002,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    ldd       >WorkWord_016,u ; load d from >WorkWord_016,u
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    beq       Branch_020 ; branch when the values are equal or the result is zero; target Branch_020
                    leax      >Text_016,pc ; form the address >Text_016,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    sta       WorkByte_004,u ; store a at WorkByte_004,u
Branch_021          leax      >WorkByte_032,u ; form the address >WorkByte_032,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       WorkByte_004,u ; load a from WorkByte_004,u
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    bcs       Branch_022 ; branch when carry reports an error or unsigned underflow; target Branch_022
                    leax      >WorkByte_032,u ; form the address >WorkByte_032,u in x
Branch_023          lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    bne       Branch_023 ; branch when the values differ or the result is nonzero; target Branch_023
                    lda       #13       ; set a to the constant 13
                    sta       -$01,x    ; store a at -$01,x
                    lbsr      Routine_002 ; call subroutine Routine_002
                    cmpd      >WorkWord_016,u ; compare d with >WorkWord_016,u and set the condition codes
                    bne       Branch_021 ; branch when the values differ or the result is nonzero; target Branch_021
                    leax      >WorkByte_032,u ; form the address >WorkByte_032,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       WorkByte_004,u ; load a from WorkByte_004,u
                    os9       I$Close   ; close path A
                    lbra      Branch_024 ; continue execution at Branch_024
Branch_022          leax      >Text_017,pc ; form the address >Text_017,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       WorkByte_004,u ; load a from WorkByte_004,u
                    os9       I$Close   ; close path A
                    lbra      Branch_024 ; continue execution at Branch_024
Branch_020          leax      >Text_018,pc ; form the address >Text_018,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
Branch_024          leax      >Text_010,pc ; form the address >Text_010,pc in x
                    ldy       >Data_002,pc ; load y from >Data_002,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      <WorkBuffer_003,u ; form the address <WorkBuffer_003,u in x
                    ldb       >WorkByte_029,u ; load b from >WorkByte_029,u
                    clra                ; clear a to zero and set the condition codes
                    lbsr      Routine_001 ; call subroutine Routine_001
                    lda       <WorkByte_009,u ; load a from <WorkByte_009,u
                    sta       <WorkByte_013,u ; store a at <WorkByte_013,u
                    lda       <WorkWord_007,u ; load a from <WorkWord_007,u
                    sta       <WorkByte_014,u ; store a at <WorkByte_014,u
                    lda       #47       ; set a to the constant 47
                    sta       <WorkByte_015,u ; store a at <WorkByte_015,u
                    ldb       >WorkByte_030,u ; load b from >WorkByte_030,u
                    clra                ; clear a to zero and set the condition codes
                    leax      <WorkBuffer_003,u ; form the address <WorkBuffer_003,u in x
                    lbsr      Routine_001 ; call subroutine Routine_001
                    lda       <WorkByte_009,u ; load a from <WorkByte_009,u
                    sta       <WorkByte_016,u ; store a at <WorkByte_016,u
                    lda       <WorkWord_007,u ; load a from <WorkWord_007,u
                    sta       <WorkByte_017,u ; store a at <WorkByte_017,u
                    lda       #47       ; set a to the constant 47
                    sta       <WorkByte_018,u ; store a at <WorkByte_018,u
                    ldb       >WorkByte_028,u ; load b from >WorkByte_028,u
                    clra                ; clear a to zero and set the condition codes
                    leax      <WorkBuffer_003,u ; form the address <WorkBuffer_003,u in x
                    lbsr      Routine_001 ; call subroutine Routine_001
                    lda       <WorkByte_009,u ; load a from <WorkByte_009,u
                    sta       <WorkByte_019,u ; store a at <WorkByte_019,u
                    lda       <WorkWord_007,u ; load a from <WorkWord_007,u
                    sta       <WorkByte_020,u ; store a at <WorkByte_020,u
                    lda       #32       ; set a to the constant 32
                    sta       <WorkByte_021,u ; store a at <WorkByte_021,u
                    ldb       >WorkByte_031,u ; load b from >WorkByte_031,u
                    clra                ; clear a to zero and set the condition codes
                    leax      <WorkBuffer_003,u ; form the address <WorkBuffer_003,u in x
                    lbsr      Routine_001 ; call subroutine Routine_001
                    lda       <WorkByte_009,u ; load a from <WorkByte_009,u
                    sta       <WorkByte_022,u ; store a at <WorkByte_022,u
                    lda       <WorkWord_007,u ; load a from <WorkWord_007,u
                    sta       <WorkByte_023,u ; store a at <WorkByte_023,u
                    lda       #58       ; set a to the constant 58
                    sta       <WorkByte_024,u ; store a at <WorkByte_024,u
                    ldb       >WorkBuffer_011,u ; load b from >WorkBuffer_011,u
                    clra                ; clear a to zero and set the condition codes
                    leax      <WorkBuffer_003,u ; form the address <WorkBuffer_003,u in x
                    lbsr      Routine_001 ; call subroutine Routine_001
                    lda       <WorkByte_009,u ; load a from <WorkByte_009,u
                    sta       <WorkByte_025,u ; store a at <WorkByte_025,u
                    lda       <WorkWord_007,u ; load a from <WorkWord_007,u
                    sta       <WorkByte_026,u ; store a at <WorkByte_026,u
                    lda       #13       ; set a to the constant 13
                    sta       <WorkByte_027,u ; store a at <WorkByte_027,u
                    leax      <WorkByte_013,u ; form the address <WorkByte_013,u in x
Branch_025          lda       ,x+       ; load a from ,x+
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       Branch_025 ; branch when the values are equal or the result is zero; target Branch_025
                    leax      -$01,x    ; form the address -$01,x in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      >Text_011,pc ; form the address >Text_011,pc in x
                    ldy       >Data_002,pc ; load y from >Data_002,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >WorkBuffer_010,u ; form the address >WorkBuffer_010,u in x
                    ldy       #30       ; set y to the constant 30
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    bra       Branch_026 ; continue execution at Branch_026
Branch_019          leax      >Text_006,pc ; form the address >Text_006,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbra      Branch_003 ; continue execution at Branch_003
Branch_026          leax      >Text_012,pc ; form the address >Text_012,pc in x
                    ldy       #80       ; set y to the constant 80
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       WorkByte_002,u ; load a from WorkByte_002,u
                    ldx       >WorkWord_014,u ; load x from >WorkWord_014,u
                    pshs      u         ; save u on the stack
                    ldu       >WorkWord_015,u ; load u from >WorkWord_015,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    puls      u         ; restore u from the stack
Branch_027          lda       WorkByte_002,u ; load a from WorkByte_002,u
                    leax      >WorkBuffer_008,u ; form the address >WorkBuffer_008,u in x
                    ldy       #80       ; set y to the constant 80
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bhi       Branch_027 ; branch when the unsigned value is higher; target Branch_027
                    leax      >Text_012,pc ; form the address >Text_012,pc in x
                    ldy       #80       ; set y to the constant 80
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    ldd       <WorkWord_006,u ; load d from <WorkWord_006,u
                    addd      #1        ; add to d using #1
                    std       <WorkWord_006,u ; store d at <WorkWord_006,u
                    lbra      Branch_003 ; continue execution at Branch_003
Branch_006          leax      >Text_015,pc ; form the address >Text_015,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    bcc       Branch_028 ; branch when carry is clear; target Branch_028
                    ldb       #27       ; set b to the constant 27
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
Branch_028          sta       WorkBuffer_001,u ; store a at WorkBuffer_001,u
Branch_029          leax      <WorkWord_009,u ; form the address <WorkWord_009,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       WorkBuffer_001,u ; load a from WorkBuffer_001,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcs       Branch_030 ; branch when carry reports an error or unsigned underflow; target Branch_030
                    ldd       <WorkWord_009,u ; load d from <WorkWord_009,u
                    cmpd      WorkWord_002,u ; compare d with WorkWord_002,u and set the condition codes
                    bne       Branch_029 ; branch when the values differ or the result is nonzero; target Branch_029
                    bra       Branch_031 ; continue execution at Branch_031
Branch_030          cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      Branch_001 ; branch when the values differ or the result is nonzero; target Branch_001
                    lbra      Branch_032 ; continue execution at Branch_032
Branch_031          ldd       >WorkWord_012,u ; load d from >WorkWord_012,u
                    addd      <WorkWord_006,u ; add to d using <WorkWord_006,u
                    std       >WorkWord_012,u ; store d at >WorkWord_012,u
                    lda       WorkBuffer_001,u ; load a from WorkBuffer_001,u
                    ldb       #5        ; set b to the constant 5
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; query status code B for path A
                    tfr       u,d       ; copy the register values specified by u,d
                    subd      #32       ; subtract from d using #32
                    bge       Branch_033 ; branch when the signed value is greater than or equal; target Branch_033
                    leax      -$01,x    ; form the address -$01,x in x
Branch_033          ldu       ,s        ; load u from the current stack frame at ,s
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       WorkBuffer_001,u ; load a from WorkBuffer_001,u
                    tfr       y,u       ; copy the register values specified by y,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    puls      u         ; restore u from the stack
                    leax      <WorkWord_009,u ; form the address <WorkWord_009,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       WorkBuffer_001,u ; load a from WorkBuffer_001,u
                    os9       I$Write   ; write Y bytes from X to path A
                    os9       I$Close   ; close path A
                    lbra      Branch_034 ; continue execution at Branch_034
Branch_032          leax      <WorkWord_009,u ; form the address <WorkWord_009,u in x
                    ldd       #1        ; set d to the constant 1
                    std       <WorkWord_010,u ; store d at <WorkWord_010,u
                    std       >WorkWord_012,u ; store d at >WorkWord_012,u
                    ldd       #0        ; set d to the constant 0
                    std       >WorkWord_011,u ; store d at >WorkWord_011,u
                    std       >WorkBuffer_007,u ; store d at >WorkBuffer_007,u
                    std       >WorkWord_013,u ; store d at >WorkWord_013,u
                    ldd       WorkWord_002,u ; load d from WorkWord_002,u
                    std       <WorkWord_009,u ; store d at <WorkWord_009,u
                    leax      >WorkBuffer_006,u ; form the address >WorkBuffer_006,u in x
                    os9       F$Time    ; read the current system date and time
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      <WorkWord_009,u ; form the address <WorkWord_009,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       WorkBuffer_001,u ; load a from WorkBuffer_001,u
                    os9       I$Write   ; write Y bytes from X to path A
                    os9       I$Close   ; close path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
Branch_034          clrb                ; clear b to zero and set the condition codes
Branch_001          os9       F$Exit    ; terminate the process with status B
Routine_002         pshs      y         ; save y on the stack
Branch_035          lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      Branch_036 ; branch when the values are equal or the result is zero; target Branch_036
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_035 ; branch when carry reports an error or unsigned underflow; target Branch_035
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_035 ; branch when the unsigned value is higher; target Branch_035
                    leax      -$01,x    ; form the address -$01,x in x
Branch_037          lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_038 ; branch when carry reports an error or unsigned underflow; target Branch_038
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_038 ; branch when the unsigned value is higher; target Branch_038
                    bra       Branch_037 ; continue execution at Branch_037
Branch_038          pshs      x         ; save x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    clr       WorkByte_007,u ; clear WorkByte_007,u to zero and set the condition codes
                    clr       WorkByte_008,u ; clear WorkByte_008,u to zero and set the condition codes
                    ldd       #1        ; set d to the constant 1
                    std       WorkWord_001,u ; store d at WorkWord_001,u
Branch_039          lda       ,-x       ; load a from ,-x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_040 ; branch when carry reports an error or unsigned underflow; target Branch_040
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_040 ; branch when the unsigned value is higher; target Branch_040
                    suba      #48       ; subtract from a using #48
                    sta       WorkByte_006,u ; store a at WorkByte_006,u
                    ldd       #0        ; set d to the constant 0
Branch_041          tst       WorkByte_006,u ; set condition codes from WorkByte_006,u without changing it
                    beq       Branch_042 ; branch when the values are equal or the result is zero; target Branch_042
                    addd      WorkWord_001,u ; add to d using WorkWord_001,u
                    dec       WorkByte_006,u ; decrement the value at WorkByte_006,u
                    bra       Branch_041 ; continue execution at Branch_041
Branch_042          addd      WorkByte_007,u ; add to d using WorkByte_007,u
                    std       WorkByte_007,u ; store d at WorkByte_007,u
                    lda       #10       ; set a to the constant 10
                    sta       WorkByte_006,u ; store a at WorkByte_006,u
                    ldd       #0        ; set d to the constant 0
Branch_043          tst       WorkByte_006,u ; set condition codes from WorkByte_006,u without changing it
                    beq       Branch_044 ; branch when the values are equal or the result is zero; target Branch_044
                    addd      WorkWord_001,u ; add to d using WorkWord_001,u
                    dec       WorkByte_006,u ; decrement the value at WorkByte_006,u
                    bra       Branch_043 ; continue execution at Branch_043
Branch_044          std       WorkWord_001,u ; store d at WorkWord_001,u
                    bra       Branch_039 ; continue execution at Branch_039
Branch_040          ldd       WorkByte_007,u ; load d from WorkByte_007,u
                    puls      x         ; restore x from the stack
                    puls      pc,y      ; restore pc,y and return to the caller
Routine_001         pshs      x         ; save x on the stack
                    std       WorkByte_007,u ; store d at WorkByte_007,u
                    lda       #48       ; set a to the constant 48
                    sta       ,x        ; store a at ,x
                    sta       $01,x     ; store a at $01,x
                    sta       $02,x     ; store a at $02,x
                    sta       $03,x     ; store a at $03,x
                    sta       $04,x     ; store a at $04,x
                    ldd       #10000    ; set d to the constant 10000
                    std       WorkWord_001,u ; store d at WorkWord_001,u
                    ldd       WorkByte_007,u ; load d from WorkByte_007,u
                    lbsr      Routine_003 ; call subroutine Routine_003
                    ldd       #1000     ; set d to the constant 1000
                    std       WorkWord_001,u ; store d at WorkWord_001,u
                    ldd       WorkByte_007,u ; load d from WorkByte_007,u
                    bsr       Routine_003 ; call subroutine Routine_003
                    ldd       #100      ; set d to the constant 100
                    std       WorkWord_001,u ; store d at WorkWord_001,u
                    ldd       WorkByte_007,u ; load d from WorkByte_007,u
                    bsr       Routine_003 ; call subroutine Routine_003
                    ldd       #10       ; set d to the constant 10
                    std       WorkWord_001,u ; store d at WorkWord_001,u
                    ldd       WorkByte_007,u ; load d from WorkByte_007,u
                    bsr       Routine_003 ; call subroutine Routine_003
                    ldd       #1        ; set d to the constant 1
                    std       WorkWord_001,u ; store d at WorkWord_001,u
                    ldd       WorkByte_007,u ; load d from WorkByte_007,u
                    bsr       Routine_003 ; call subroutine Routine_003
                    lda       #13       ; set a to the constant 13
                    sta       ,x        ; store a at ,x
                    puls      x         ; restore x from the stack
                    ldb       #32       ; set b to the constant 32
Branch_045          lda       ,x        ; load a from ,x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bne       Branch_046 ; branch when the values differ or the result is nonzero; target Branch_046
                    stb       ,x+       ; store b at ,x+
                    bra       Branch_045 ; continue execution at Branch_045
Branch_046          lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_047 ; branch when carry reports an error or unsigned underflow; target Branch_047
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_047 ; branch when the unsigned value is higher; target Branch_047
                    bra       Branch_046 ; continue execution at Branch_046
Branch_047          leax      -$01,x    ; form the address -$01,x in x
                    rts                 ; return to the caller
Routine_003         subd      WorkWord_001,u ; subtract from d using WorkWord_001,u
                    bcs       Branch_048 ; branch when carry reports an error or unsigned underflow; target Branch_048
                    inc       ,x        ; increment the value at ,x
                    bra       Routine_003 ; continue execution at Routine_003
Branch_048          addd      WorkWord_001,u ; add to d using WorkWord_001,u
                    std       WorkByte_007,u ; store d at WorkByte_007,u
                    leax      $01,x     ; form the address $01,x in x
                    rts                 ; return to the caller
Branch_036          ldd       #-1       ; set d to the constant -1
                    puls      pc,y      ; restore pc,y and return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
