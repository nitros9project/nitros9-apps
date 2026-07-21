**********************************************************************
* BBS.archive - OS-9 Level 2 BBS command
*
* Syntax: BBS.archive
* Purpose: Remove old board messages and optionally append readable copies to an archive file.
* Data: current bbs.msg/bbs.msg.inx plus an operator-selected text archive.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       BBS.archive
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

WorkByte_001        rmb       1         ; reserve 1 byte(s) in the module workspace
InxPath             rmb       1         ; reserve 1 byte(s) in the module workspace
MsgPath             rmb       1         ; reserve 1 byte(s) in the module workspace
AliasPath           rmb       1         ; reserve 1 byte(s) in the module workspace
TmpPath             rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_001        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_002        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_003        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_001      rmb       36        ; reserve 36 byte(s) in the module workspace
WorkByte_002        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_003        rmb       1         ; reserve 1 byte(s) in the module workspace
ABuf                rmb       6         ; reserve 6 byte(s) in the module workspace
BBuf                rmb       6         ; reserve 6 byte(s) in the module workspace
WorkBuffer_002      rmb       3         ; reserve 3 byte(s) in the module workspace
WorkByte_004        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_004        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_005        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_003      rmb       10        ; reserve 10 byte(s) in the module workspace
WorkByte_006        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_007        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_008        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_009        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_010        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_011        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_012        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_013        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_014        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_015        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_016        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_017        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_018        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_019        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_020        rmb       1         ; reserve 1 byte(s) in the module workspace
buffer              rmb       64        ; reserve 64 byte(s) in the module workspace
WorkBuffer_004      rmb       80        ; reserve 80 byte(s) in the module workspace
WorkWord_005        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_006        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_005      rmb       20        ; reserve 20 byte(s) in the module workspace
WorkBuffer_006      rmb       30        ; reserve 30 byte(s) in the module workspace
WorkByte_021        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_022        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_023        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_024        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_007      rmb       4         ; reserve 4 byte(s) in the module workspace
WorkWord_007        rmb       2         ; reserve 2 byte(s) in the module workspace
TmpName             rmb       200       ; reserve 200 byte(s) in the module workspace
WorkByte_025        rmb       1         ; reserve 1 byte(s) in the module workspace
stack               rmb       399       ; reserve 399 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.archive/ ; store an OS-9 high-bit-terminated string
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
HighMsg             fcc       "High message is #" ; store literal character data
Data_001            fcb       $00       ; store byte data
                    fcb       $11       ; store byte data
NewHigh             fcc       "Enter new high message #" ; store literal character data
                    fcb       $0D       ; store byte data
FileName            fcc       "Enter output filename (BLANK = none)" ; store literal character data
                    fcb       $0D       ; store byte data
Text_001            fcc       ">" ; store literal character data
bbsmsginx           fcc       "BBS.msg.inx" ; store literal character data
                    fcb       $0D       ; store byte data
bbsmsg              fcc       "BBS.msg" ; store literal character data
                    fcb       $0D       ; store byte data
bbspack             fcc       "BBS.pack" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcc       "******   DELETED   ******" ; store literal character data
                    fcb       $0D       ; store byte data
message             fcc       "Message :" ; store literal character data
Text_002            fcc       "From    :" ; store literal character data
Text_003            fcc       "To      :" ; store literal character data
Text_004            fcc       "Left on :" ; store literal character data
Text_005            fcc       "About   :" ; store literal character data
Data_002            fcb       $00       ; store byte data
                    fcb       $09       ; store byte data
dashline            fcc       "----------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
Data_003            fcb       $0A       ; store byte data
                    fcb       $0A       ; store byte data
Data_004            fcb       $0D       ; store byte data
                    fcc       "BBS.msg.lst" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcc       "/dd/bbs/BBS.userstats" ; store literal character data
                    fcb       $0D       ; store byte data
bbsalias            fcc       "/dd/bbs/BBS.alias" ; store literal character data
                    fcb       $0D       ; store byte data
unkuser             fcc       "Unknown User" ; store literal character data
                    fcb       $0D       ; store byte data
allusers            fcc       "All Users" ; store literal character data
                    fcb       $0D       ; store byte data
Data_005            fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
saving              fcc       "Saving Messages..." ; store literal character data
                    fcb       $0D       ; store byte data

start               os9       F$ID      ; retrieve the current process and user IDs
                    ldb       #214      ; set b to the constant 214
                    cmpy      #0        ; compare y with #0 and set the condition codes
                    lbne      Exit      ; branch when the values differ or the result is nonzero; target Exit
                    sty       WorkBuffer_001,u ; store y at WorkBuffer_001,u
                    ldd       #0        ; set d to the constant 0
                    std       WorkWord_003,u ; store d at WorkWord_003,u

* Open bbs.msg.inx
                    leax      >bbsmsginx,pc ; form the address >bbsmsginx,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Exit      ; branch when carry reports an error or unsigned underflow; target Exit
                    sta       InxPath,u ; store a at InxPath,u

* Open bbs.msg
                    leax      >bbsmsg,pc ; form the address >bbsmsg,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Exit      ; branch when carry reports an error or unsigned underflow; target Exit
                    sta       MsgPath,u ; store a at MsgPath,u

* Read 64 bytes from bbs.msg.inx
                    leax      <buffer,u ; form the address <buffer,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       InxPath,u ; load a from InxPath,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lbcs      Exit      ; branch when carry reports an error or unsigned underflow; target Exit

                    ldd       <buffer,u ; load d from <buffer,u
                    leax      <BBuf,u   ; form the address <BBuf,u in x
                    lbsr      CvtDec    ; call subroutine CvtDec
                    leax      >HighMsg,pc ; form the address >HighMsg,pc in x
                    ldy       >Data_001,pc ; load y from >Data_001,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      Exit      ; branch when carry reports an error or unsigned underflow; target Exit
                    leax      <BBuf,u   ; form the address <BBuf,u in x
                    ldy       #6        ; set y to the constant 6
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Exit      ; branch when carry reports an error or unsigned underflow; target Exit
                    ldd       #0        ; set d to the constant 0
                    std       <BBuf,u   ; store d at <BBuf,u
                    leax      >NewHigh,pc ; form the address >NewHigh,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Exit      ; branch when carry reports an error or unsigned underflow; target Exit
                    leax      >Text_001,pc ; form the address >Text_001,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      Exit      ; branch when carry reports an error or unsigned underflow; target Exit
                    leax      <WorkBuffer_003,u ; form the address <WorkBuffer_003,u in x
                    ldy       #6        ; set y to the constant 6
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lbcs      Exit      ; branch when carry reports an error or unsigned underflow; target Exit
                    clr       <WorkByte_005,u ; clear <WorkByte_005,u to zero and set the condition codes
                    leax      <WorkBuffer_003,u ; form the address <WorkBuffer_003,u in x
                    lbsr      Routine_001 ; call subroutine Routine_001
                    cmpd      #1        ; compare d with #1 and set the condition codes
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    cmpd      <buffer,u ; compare d with <buffer,u and set the condition codes
                    lbhi      Branch_001 ; branch when the unsigned value is higher; target Branch_001
                    std       WorkWord_002,u ; store d at WorkWord_002,u
                    ldd       <buffer,u ; load d from <buffer,u
                    subd      WorkWord_002,u ; subtract from d using WorkWord_002,u
                    std       WorkWord_002,u ; store d at WorkWord_002,u
                    leax      >FileName,pc ; form the address >FileName,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Text_001,pc ; form the address >Text_001,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >TmpName,u ; form the address >TmpName,u in x
                    ldy       #32       ; set y to the constant 32
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bls       Branch_002 ; branch when the unsigned value is lower or equal; target Branch_002
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    bcc       Branch_003 ; branch when carry is clear; target Branch_003
                    ldb       #3        ; set b to the constant 3
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    lbcs      Exit      ; branch when carry reports an error or unsigned underflow; target Exit
                    bra       Branch_003 ; continue execution at Branch_003

Branch_002          lda       #255      ; set a to the constant 255
                    sta       TmpPath,u ; store a at TmpPath,u
                    bra       Branch_004 ; continue execution at Branch_004

Branch_003          sta       TmpPath,u ; store a at TmpPath,u
                    pshs      u         ; save u on the stack
                    ldb       #2        ; set b to the constant 2
                    os9       I$GetStt  ; query status code B for path A
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    puls      u         ; restore u from the stack
                    leax      >saving,pc ; form the address >saving,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
Branch_004          lda       InxPath,u ; load a from InxPath,u
                    leax      >WorkWord_005,u ; form the address >WorkWord_005,u in x
                    ldy       #2        ; set y to the constant 2
                    os9       I$Read    ; read up to Y bytes from path A into X
                    ldb       #5        ; set b to the constant 5
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; query status code B for path A
                    leau      -$02,u    ; form the workspace or data address -$02,u in u
                    cmpu      #0        ; compare u with #0 and set the condition codes
                    bge       Branch_005 ; branch when the signed value is greater than or equal; target Branch_005
                    leax      -$01,x    ; form the address -$01,x in x
Branch_005          os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    puls      u         ; restore u from the stack
                    lbcs      Exit      ; branch when carry reports an error or unsigned underflow; target Exit
                    leax      >Data_005,pc ; form the address >Data_005,pc in x
                    ldy       #2        ; set y to the constant 2
                    os9       I$Write   ; write Y bytes from X to path A
                    ldy       #62       ; set y to the constant 62
                    leax      >WorkWord_005,u ; form the address >WorkWord_005,u in x
                    leax      $02,x     ; form the address $02,x in x
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    ldd       <BBuf,u   ; load d from <BBuf,u
                    addd      #1        ; add to d using #1
                    std       <BBuf,u   ; store d at <BBuf,u
                    ldd       >WorkWord_005,u ; load d from >WorkWord_005,u
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    lbeq      Branch_006 ; branch when the values are equal or the result is zero; target Branch_006
                    leax      >Text_002,pc ; form the address >Text_002,pc in x
                    ldy       >Data_002,pc ; load y from >Data_002,pc
                    lda       TmpPath,u ; load a from TmpPath,u
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >WorkBuffer_005,u ; form the address >WorkBuffer_005,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       <TmpPath  ; load a from <TmpPath
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Exit      ; branch when carry reports an error or unsigned underflow; target Exit
                    leax      >Text_003,pc ; form the address >Text_003,pc in x
                    ldy       >Data_002,pc ; load y from >Data_002,pc
                    lda       TmpPath,u ; load a from TmpPath,u
                    os9       I$Write   ; write Y bytes from X to path A
                    ldd       >WorkWord_007,u ; load d from >WorkWord_007,u
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    beq       Branch_007 ; branch when the values are equal or the result is zero; target Branch_007
                    leax      >bbsalias,pc ; form the address >bbsalias,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Exit      ; branch when carry reports an error or unsigned underflow; target Exit
                    sta       AliasPath,u ; store a at AliasPath,u
Branch_008          leax      >WorkByte_025,u ; form the address >WorkByte_025,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       AliasPath,u ; load a from AliasPath,u
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    bcs       Branch_009 ; branch when carry reports an error or unsigned underflow; target Branch_009
                    leax      >WorkByte_025,u ; form the address >WorkByte_025,u in x
Branch_010          lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    bne       Branch_010 ; branch when the values differ or the result is nonzero; target Branch_010
                    lda       #13       ; set a to the constant 13
                    sta       -$01,x    ; store a at -$01,x
                    lbsr      Routine_001 ; call subroutine Routine_001
                    cmpd      >WorkWord_007,u ; compare d with >WorkWord_007,u and set the condition codes
                    bne       Branch_008 ; branch when the values differ or the result is nonzero; target Branch_008
                    leax      >WorkByte_025,u ; form the address >WorkByte_025,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       TmpPath,u ; load a from TmpPath,u
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       AliasPath,u ; load a from AliasPath,u
                    os9       I$Close   ; close path A
                    lbra      Branch_011 ; continue execution at Branch_011

Branch_009          leax      >unkuser,pc ; form the address >unkuser,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       TmpPath,u ; load a from TmpPath,u
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       AliasPath,u ; load a from AliasPath,u
                    os9       I$Close   ; close path A
                    lbra      Branch_011 ; continue execution at Branch_011

Branch_007          leax      >allusers,pc ; form the address >allusers,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       TmpPath,u ; load a from TmpPath,u
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
Branch_011          leax      >Text_004,pc ; form the address >Text_004,pc in x
                    ldy       >Data_002,pc ; load y from >Data_002,pc
                    lda       TmpPath,u ; load a from TmpPath,u
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      <WorkBuffer_002,u ; form the address <WorkBuffer_002,u in x
                    ldb       >WorkByte_022,u ; load b from >WorkByte_022,u
                    clra                ; clear a to zero and set the condition codes
                    lbsr      CvtDec    ; call subroutine CvtDec
                    lda       <WorkByte_004,u ; load a from <WorkByte_004,u
                    sta       <WorkByte_006,u ; store a at <WorkByte_006,u
                    lda       <WorkWord_004,u ; load a from <WorkWord_004,u
                    sta       <WorkByte_007,u ; store a at <WorkByte_007,u
                    lda       #47       ; set a to the constant 47
                    sta       <WorkByte_008,u ; store a at <WorkByte_008,u
                    ldb       >WorkByte_023,u ; load b from >WorkByte_023,u
                    clra                ; clear a to zero and set the condition codes
                    leax      <WorkBuffer_002,u ; form the address <WorkBuffer_002,u in x
                    lbsr      CvtDec    ; call subroutine CvtDec
                    lda       <WorkByte_004,u ; load a from <WorkByte_004,u
                    sta       <WorkByte_009,u ; store a at <WorkByte_009,u
                    lda       <WorkWord_004,u ; load a from <WorkWord_004,u
                    sta       <WorkByte_010,u ; store a at <WorkByte_010,u
                    lda       #47       ; set a to the constant 47
                    sta       <WorkByte_011,u ; store a at <WorkByte_011,u
                    ldb       >WorkByte_021,u ; load b from >WorkByte_021,u
                    clra                ; clear a to zero and set the condition codes
                    leax      <WorkBuffer_002,u ; form the address <WorkBuffer_002,u in x
                    lbsr      CvtDec    ; call subroutine CvtDec
                    lda       <WorkByte_004,u ; load a from <WorkByte_004,u
                    sta       <WorkByte_012,u ; store a at <WorkByte_012,u
                    lda       <WorkWord_004,u ; load a from <WorkWord_004,u
                    sta       <WorkByte_013,u ; store a at <WorkByte_013,u
                    lda       #32       ; set a to the constant 32
                    sta       <WorkByte_014,u ; store a at <WorkByte_014,u
                    ldb       >WorkByte_024,u ; load b from >WorkByte_024,u
                    clra                ; clear a to zero and set the condition codes
                    leax      <WorkBuffer_002,u ; form the address <WorkBuffer_002,u in x
                    lbsr      CvtDec    ; call subroutine CvtDec
                    lda       <WorkByte_004,u ; load a from <WorkByte_004,u
                    sta       <WorkByte_015,u ; store a at <WorkByte_015,u
                    lda       <WorkWord_004,u ; load a from <WorkWord_004,u
                    sta       <WorkByte_016,u ; store a at <WorkByte_016,u
                    lda       #58       ; set a to the constant 58
                    sta       <WorkByte_017,u ; store a at <WorkByte_017,u
                    ldb       >WorkBuffer_007,u ; load b from >WorkBuffer_007,u
                    clra                ; clear a to zero and set the condition codes
                    leax      <WorkBuffer_002,u ; form the address <WorkBuffer_002,u in x
                    lbsr      CvtDec    ; call subroutine CvtDec
                    lda       <WorkByte_004,u ; load a from <WorkByte_004,u
                    sta       <WorkByte_018,u ; store a at <WorkByte_018,u
                    lda       <WorkWord_004,u ; load a from <WorkWord_004,u
                    sta       <WorkByte_019,u ; store a at <WorkByte_019,u
                    lda       #13       ; set a to the constant 13
                    sta       <WorkByte_020,u ; store a at <WorkByte_020,u
                    leax      <WorkByte_006,u ; form the address <WorkByte_006,u in x
Branch_012          lda       ,x+       ; load a from ,x+
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       Branch_012 ; branch when the values are equal or the result is zero; target Branch_012
                    leax      -$01,x    ; form the address -$01,x in x
                    ldy       #200      ; set y to the constant 200
                    lda       TmpPath,u ; load a from TmpPath,u
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Exit      ; branch when carry reports an error or unsigned underflow; target Exit
                    leax      >Text_005,pc ; form the address >Text_005,pc in x
                    ldy       >Data_002,pc ; load y from >Data_002,pc
                    lda       TmpPath,u ; load a from TmpPath,u
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >WorkBuffer_006,u ; form the address >WorkBuffer_006,u in x
                    ldy       #30       ; set y to the constant 30
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Exit      ; branch when carry reports an error or unsigned underflow; target Exit
                    bra       Branch_013 ; continue execution at Branch_013

Branch_006          lbra      Branch_004 ; continue execution at Branch_004

Branch_013          leax      >dashline,pc ; form the address >dashline,pc in x
                    ldy       #80       ; set y to the constant 80
                    lda       TmpPath,u ; load a from TmpPath,u
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       MsgPath,u ; load a from MsgPath,u
                    ldx       >WorkWord_005,u ; load x from >WorkWord_005,u
                    pshs      u         ; save u on the stack
                    ldu       >WorkWord_006,u ; load u from >WorkWord_006,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      Exit      ; branch when carry reports an error or unsigned underflow; target Exit
                    puls      u         ; restore u from the stack
Branch_014          clra                ; clear a to zero and set the condition codes
                    ldb       #1        ; set b to the constant 1
                    os9       I$GetStt  ; query status code B for path A
                    bcs       Branch_015 ; branch when carry reports an error or unsigned underflow; target Branch_015
                    leax      WorkByte_001,u ; form the address WorkByte_001,u in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    lbeq      Branch_004 ; branch when the values are equal or the result is zero; target Branch_004
Branch_015          lda       MsgPath,u ; load a from MsgPath,u
                    leax      >WorkBuffer_004,u ; form the address >WorkBuffer_004,u in x
                    ldy       #80       ; set y to the constant 80
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lda       TmpPath,u ; load a from TmpPath,u
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bhi       Branch_014 ; branch when the unsigned value is higher; target Branch_014
                    leax      >dashline,pc ; form the address >dashline,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       TmpPath,u ; load a from TmpPath,u
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Data_003,pc ; form the address >Data_003,pc in x
                    ldy       #5        ; set y to the constant 5
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    addd      #1        ; add to d using #1
                    std       WorkWord_003,u ; store d at WorkWord_003,u
                    ldd       <BBuf,u   ; load d from <BBuf,u
                    cmpd      WorkWord_002,u ; compare d with WorkWord_002,u and set the condition codes
                    lbcs      Branch_004 ; branch when carry reports an error or unsigned underflow; target Branch_004
Branch_001          lda       InxPath,u ; load a from InxPath,u
                    os9       I$Close   ; close path A
                    lda       MsgPath,u ; load a from MsgPath,u
                    os9       I$Close   ; close path A
                    lda       AliasPath,u ; load a from AliasPath,u
                    os9       I$Close   ; close path A
                    lda       TmpPath,u ; load a from TmpPath,u
                    os9       I$Close   ; close path A
                    leax      >bbspack,pc ; form the address >bbspack,pc in x
                    leau      >Data_004,pc ; form the workspace or data address >Data_004,pc in u
                    ldy       #1        ; set y to the constant 1
                    lda       #17       ; set a to the constant 17
                    ldb       #3        ; set b to the constant 3
                    os9       F$Fork    ; spawn the module at X with parameters at U
                    bcs       Exit      ; branch when carry reports an error or unsigned underflow; target Exit
                    clrb                ; clear b to zero and set the condition codes
                    os9       F$Wait    ; wait for a child process to terminate

Exit                os9       F$Exit    ; terminate the process with status B

Routine_001         pshs      y         ; save y on the stack
Branch_016          lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      Branch_017 ; branch when the values are equal or the result is zero; target Branch_017
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_016 ; branch when carry reports an error or unsigned underflow; target Branch_016
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_016 ; branch when the unsigned value is higher; target Branch_016
                    leax      -$01,x    ; form the address -$01,x in x
Branch_018          lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_019 ; branch when carry reports an error or unsigned underflow; target Branch_019
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_019 ; branch when the unsigned value is higher; target Branch_019
                    bra       Branch_018 ; continue execution at Branch_018
Branch_019          pshs      x         ; save x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    clr       <WorkByte_002,u ; clear <WorkByte_002,u to zero and set the condition codes
                    clr       <WorkByte_003,u ; clear <WorkByte_003,u to zero and set the condition codes
                    ldd       #1        ; set d to the constant 1
                    std       <ABuf,u   ; store d at <ABuf,u
Branch_020          lda       ,-x       ; load a from ,-x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_021 ; branch when carry reports an error or unsigned underflow; target Branch_021
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_021 ; branch when the unsigned value is higher; target Branch_021
                    suba      #48       ; subtract from a using #48
                    sta       WorkWord_001,u ; store a at WorkWord_001,u
                    ldd       #0        ; set d to the constant 0
Branch_022          tst       WorkWord_001,u ; set condition codes from WorkWord_001,u without changing it
                    beq       Branch_023 ; branch when the values are equal or the result is zero; target Branch_023
                    addd      <ABuf,u   ; add to d using <ABuf,u
                    dec       WorkWord_001,u ; decrement the value at WorkWord_001,u
                    bra       Branch_022 ; continue execution at Branch_022

Branch_023          addd      <WorkByte_002,u ; add to d using <WorkByte_002,u
                    std       <WorkByte_002,u ; store d at <WorkByte_002,u
                    lda       #10       ; set a to the constant 10
                    sta       WorkWord_001,u ; store a at WorkWord_001,u
                    ldd       #0        ; set d to the constant 0
Branch_024          tst       WorkWord_001,u ; set condition codes from WorkWord_001,u without changing it
                    beq       Branch_025 ; branch when the values are equal or the result is zero; target Branch_025
                    addd      <ABuf,u   ; add to d using <ABuf,u
                    dec       WorkWord_001,u ; decrement the value at WorkWord_001,u
                    bra       Branch_024 ; continue execution at Branch_024

Branch_025          std       <ABuf,u   ; store d at <ABuf,u
                    bra       Branch_020 ; continue execution at Branch_020

Branch_021          ldd       <WorkByte_002,u ; load d from <WorkByte_002,u
                    puls      x         ; restore x from the stack
                    puls      pc,y      ; restore pc,y and return to the caller

* Convert the number in D to a decimal string
CvtDec              pshs      x         ; save x on the stack
                    std       <WorkByte_002,u ; store d at <WorkByte_002,u
                    lda       #48       ; set a to the constant 48
                    sta       ,x        ; store a at ,x
                    sta       $01,x     ; store a at $01,x
                    sta       $02,x     ; store a at $02,x
                    sta       $03,x     ; store a at $03,x
                    sta       $04,x     ; store a at $04,x
                    ldd       #10000    ; set d to the constant 10000
                    std       <ABuf,u   ; store d at <ABuf,u
                    ldd       <WorkByte_002,u ; load d from <WorkByte_002,u
                    lbsr      Routine_002 ; call subroutine Routine_002
                    ldd       #1000     ; set d to the constant 1000
                    std       <ABuf,u   ; store d at <ABuf,u
                    ldd       <WorkByte_002,u ; load d from <WorkByte_002,u
                    bsr       Routine_002 ; call subroutine Routine_002
                    ldd       #100      ; set d to the constant 100
                    std       <ABuf,u   ; store d at <ABuf,u
                    ldd       <WorkByte_002,u ; load d from <WorkByte_002,u
                    bsr       Routine_002 ; call subroutine Routine_002
                    ldd       #10       ; set d to the constant 10
                    std       <ABuf,u   ; store d at <ABuf,u
                    ldd       <WorkByte_002,u ; load d from <WorkByte_002,u
                    bsr       Routine_002 ; call subroutine Routine_002
                    ldd       #1        ; set d to the constant 1
                    std       <ABuf,u   ; store d at <ABuf,u
                    ldd       <WorkByte_002,u ; load d from <WorkByte_002,u
                    bsr       Routine_002 ; call subroutine Routine_002
                    lda       #13       ; set a to the constant 13
                    sta       ,x        ; store a at ,x
                    puls      x         ; restore x from the stack
                    ldb       #32       ; set b to the constant 32
Branch_026          lda       ,x        ; load a from ,x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bne       Branch_027 ; branch when the values differ or the result is nonzero; target Branch_027
                    stb       ,x+       ; store b at ,x+
                    bra       Branch_026 ; continue execution at Branch_026

Branch_027          lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_028 ; branch when carry reports an error or unsigned underflow; target Branch_028
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_028 ; branch when the unsigned value is higher; target Branch_028
                    bra       Branch_027 ; continue execution at Branch_027

Branch_028          leax      -$01,x    ; form the address -$01,x in x
                    rts                 ; return to the caller

Routine_002         subd      <ABuf,u   ; subtract from d using <ABuf,u
                    bcs       Branch_029 ; branch when carry reports an error or unsigned underflow; target Branch_029
                    inc       ,x        ; increment the value at ,x
                    bra       Routine_002 ; continue execution at Routine_002

Branch_029          addd      <ABuf,u   ; add to d using <ABuf,u
                    std       <WorkByte_002,u ; store d at <WorkByte_002,u
                    leax      $01,x     ; form the address $01,x in x
                    rts                 ; return to the caller

Branch_017          ldd       #-1       ; set d to the constant -1
                    puls      pc,y      ; restore pc,y and return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
