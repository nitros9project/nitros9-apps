**********************************************************************
* BBS.archive - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
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

U0000               rmb       1         ; reserve 1 byte(s) in the module workspace
InxPath             rmb       1         ; reserve 1 byte(s) in the module workspace
MsgPath             rmb       1         ; reserve 1 byte(s) in the module workspace
AliasPath           rmb       1         ; reserve 1 byte(s) in the module workspace
TmpPath             rmb       2         ; reserve 2 byte(s) in the module workspace
U0006               rmb       2         ; reserve 2 byte(s) in the module workspace
U0008               rmb       2         ; reserve 2 byte(s) in the module workspace
U000A               rmb       2         ; reserve 2 byte(s) in the module workspace
U000C               rmb       36        ; reserve 36 byte(s) in the module workspace
U0030               rmb       1         ; reserve 1 byte(s) in the module workspace
U0031               rmb       1         ; reserve 1 byte(s) in the module workspace
ABuf                rmb       6         ; reserve 6 byte(s) in the module workspace
BBuf                rmb       6         ; reserve 6 byte(s) in the module workspace
U003E               rmb       3         ; reserve 3 byte(s) in the module workspace
U0041               rmb       1         ; reserve 1 byte(s) in the module workspace
U0042               rmb       2         ; reserve 2 byte(s) in the module workspace
U0044               rmb       1         ; reserve 1 byte(s) in the module workspace
U0045               rmb       10        ; reserve 10 byte(s) in the module workspace
U004F               rmb       1         ; reserve 1 byte(s) in the module workspace
U0050               rmb       1         ; reserve 1 byte(s) in the module workspace
U0051               rmb       1         ; reserve 1 byte(s) in the module workspace
U0052               rmb       1         ; reserve 1 byte(s) in the module workspace
U0053               rmb       1         ; reserve 1 byte(s) in the module workspace
U0054               rmb       1         ; reserve 1 byte(s) in the module workspace
U0055               rmb       1         ; reserve 1 byte(s) in the module workspace
U0056               rmb       1         ; reserve 1 byte(s) in the module workspace
U0057               rmb       1         ; reserve 1 byte(s) in the module workspace
U0058               rmb       1         ; reserve 1 byte(s) in the module workspace
U0059               rmb       1         ; reserve 1 byte(s) in the module workspace
U005A               rmb       1         ; reserve 1 byte(s) in the module workspace
U005B               rmb       1         ; reserve 1 byte(s) in the module workspace
U005C               rmb       1         ; reserve 1 byte(s) in the module workspace
U005D               rmb       1         ; reserve 1 byte(s) in the module workspace
buffer              rmb       64        ; reserve 64 byte(s) in the module workspace
U009E               rmb       80        ; reserve 80 byte(s) in the module workspace
U00EE               rmb       2         ; reserve 2 byte(s) in the module workspace
U00F0               rmb       2         ; reserve 2 byte(s) in the module workspace
U00F2               rmb       20        ; reserve 20 byte(s) in the module workspace
U0106               rmb       30        ; reserve 30 byte(s) in the module workspace
U0124               rmb       1         ; reserve 1 byte(s) in the module workspace
U0125               rmb       1         ; reserve 1 byte(s) in the module workspace
U0126               rmb       1         ; reserve 1 byte(s) in the module workspace
U0127               rmb       1         ; reserve 1 byte(s) in the module workspace
U0128               rmb       4         ; reserve 4 byte(s) in the module workspace
U012C               rmb       2         ; reserve 2 byte(s) in the module workspace
TmpName             rmb       200       ; reserve 200 byte(s) in the module workspace
U01F6               rmb       1         ; reserve 1 byte(s) in the module workspace
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
L0094               fcb       $00       ; store byte data
                    fcb       $11       ; store byte data
NewHigh             fcc       "Enter new high message #" ; store literal character data
                    fcb       $0D       ; store byte data
FileName            fcc       "Enter output filename (BLANK = none)" ; store literal character data
                    fcb       $0D       ; store byte data
L00D4               fcc       ">" ; store literal character data
bbsmsginx           fcc       "BBS.msg.inx" ; store literal character data
                    fcb       $0D       ; store byte data
bbsmsg              fcc       "BBS.msg" ; store literal character data
                    fcb       $0D       ; store byte data
bbspack             fcc       "BBS.pack" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcc       "******   DELETED   ******" ; store literal character data
                    fcb       $0D       ; store byte data
message             fcc       "Message :" ; store literal character data
L0115               fcc       "From    :" ; store literal character data
L011E               fcc       "To      :" ; store literal character data
L0127               fcc       "Left on :" ; store literal character data
L0130               fcc       "About   :" ; store literal character data
L0139               fcb       $00       ; store byte data
                    fcb       $09       ; store byte data
dashline            fcc       "----------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
L017C               fcb       $0A       ; store byte data
                    fcb       $0A       ; store byte data
L017E               fcb       $0D       ; store byte data
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
L01CA               fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
saving              fcc       "Saving Messages..." ; store literal character data
                    fcb       $0D       ; store byte data

start               os9       F$ID      ; invoke the OS-9 F$ID service
                    ldb       #214      ; set b to the constant 214
                    cmpy      #0        ; compare y with #0 and set the condition codes
                    lbne      Exit      ; branch when the values differ or the result is nonzero; target Exit
                    sty       U000C,u   ; store y at U000C,u
                    ldd       #0        ; set d to the constant 0
                    std       U000A,u   ; store d at U000A,u

* Open bbs.msg.inx
                    leax      >bbsmsginx,pc ; form the address >bbsmsginx,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      Exit      ; branch when carry reports an error or unsigned underflow; target Exit
                    sta       InxPath,u ; store a at InxPath,u

* Open bbs.msg
                    leax      >bbsmsg,pc ; form the address >bbsmsg,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      Exit      ; branch when carry reports an error or unsigned underflow; target Exit
                    sta       MsgPath,u ; store a at MsgPath,u

* Read 64 bytes from bbs.msg.inx
                    leax      <buffer,u ; form the address <buffer,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       InxPath,u ; load a from InxPath,u
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lbcs      Exit      ; branch when carry reports an error or unsigned underflow; target Exit

                    ldd       <buffer,u ; load d from <buffer,u
                    leax      <BBuf,u   ; form the address <BBuf,u in x
                    lbsr      CvtDec    ; call subroutine CvtDec
                    leax      >HighMsg,pc ; form the address >HighMsg,pc in x
                    ldy       >L0094,pc ; load y from >L0094,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      Exit      ; branch when carry reports an error or unsigned underflow; target Exit
                    leax      <BBuf,u   ; form the address <BBuf,u in x
                    ldy       #6        ; set y to the constant 6
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      Exit      ; branch when carry reports an error or unsigned underflow; target Exit
                    ldd       #0        ; set d to the constant 0
                    std       <BBuf,u   ; store d at <BBuf,u
                    leax      >NewHigh,pc ; form the address >NewHigh,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      Exit      ; branch when carry reports an error or unsigned underflow; target Exit
                    leax      >L00D4,pc ; form the address >L00D4,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      Exit      ; branch when carry reports an error or unsigned underflow; target Exit
                    leax      <U0045,u  ; form the address <U0045,u in x
                    ldy       #6        ; set y to the constant 6
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    lbcs      Exit      ; branch when carry reports an error or unsigned underflow; target Exit
                    clr       <U0044,u  ; clear <U0044,u to zero and set the condition codes
                    leax      <U0045,u  ; form the address <U0045,u in x
                    lbsr      L057D     ; call subroutine L057D
                    cmpd      #1        ; compare d with #1 and set the condition codes
                    lbcs      L054D     ; branch when carry reports an error or unsigned underflow; target L054D
                    cmpd      <buffer,u ; compare d with <buffer,u and set the condition codes
                    lbhi      L054D     ; branch when the unsigned value is higher; target L054D
                    std       U0008,u   ; store d at U0008,u
                    ldd       <buffer,u ; load d from <buffer,u
                    subd      U0008,u   ; subtract from d using U0008,u
                    std       U0008,u   ; store d at U0008,u
                    leax      >FileName,pc ; form the address >FileName,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L00D4,pc ; form the address >L00D4,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      >TmpName,u ; form the address >TmpName,u in x
                    ldy       #32       ; set y to the constant 32
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bls       L02E0     ; branch when the unsigned value is lower or equal; target L02E0
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    bcc       L02E6     ; branch when carry is clear; target L02E6
                    ldb       #3        ; set b to the constant 3
                    os9       I$Create  ; invoke the OS-9 I$Create service
                    lbcs      Exit      ; branch when carry reports an error or unsigned underflow; target Exit
                    bra       L02E6     ; continue execution at L02E6

L02E0               lda       #255      ; set a to the constant 255
                    sta       TmpPath,u ; store a at TmpPath,u
                    bra       L0301     ; continue execution at L0301

L02E6               sta       TmpPath,u ; store a at TmpPath,u
                    pshs      u         ; save u on the stack
                    ldb       #2        ; set b to the constant 2
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    puls      u         ; restore u from the stack
                    leax      >saving,pc ; form the address >saving,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
L0301               lda       InxPath,u ; load a from InxPath,u
                    leax      >U00EE,u  ; form the address >U00EE,u in x
                    ldy       #2        ; set y to the constant 2
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    ldb       #5        ; set b to the constant 5
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    leau      -$02,u    ; form the workspace or data address -$02,u in u
                    cmpu      #0        ; compare u with #0 and set the condition codes
                    bge       L031F     ; branch when the signed value is greater than or equal; target L031F
                    leax      -$01,x    ; form the address -$01,x in x
L031F               os9       I$Seek    ; invoke the OS-9 I$Seek service
                    puls      u         ; restore u from the stack
                    lbcs      Exit      ; branch when carry reports an error or unsigned underflow; target Exit
                    leax      >L01CA,pc ; form the address >L01CA,pc in x
                    ldy       #2        ; set y to the constant 2
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    ldy       #62       ; set y to the constant 62
                    leax      >U00EE,u  ; form the address >U00EE,u in x
                    leax      $02,x     ; form the address $02,x in x
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lbcs      L054D     ; branch when carry reports an error or unsigned underflow; target L054D
                    ldd       <BBuf,u   ; load d from <BBuf,u
                    addd      #1        ; add to d using #1
                    std       <BBuf,u   ; store d at <BBuf,u
                    ldd       >U00EE,u  ; load d from >U00EE,u
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    lbeq      L04CE     ; branch when the values are equal or the result is zero; target L04CE
                    leax      >L0115,pc ; form the address >L0115,pc in x
                    ldy       >L0139,pc ; load y from >L0139,pc
                    lda       TmpPath,u ; load a from TmpPath,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      >U00F2,u  ; form the address >U00F2,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       <TmpPath  ; load a from <TmpPath
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      Exit      ; branch when carry reports an error or unsigned underflow; target Exit
                    leax      >L011E,pc ; form the address >L011E,pc in x
                    ldy       >L0139,pc ; load y from >L0139,pc
                    lda       TmpPath,u ; load a from TmpPath,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    ldd       >U012C,u  ; load d from >U012C,u
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    beq       L03F0     ; branch when the values are equal or the result is zero; target L03F0
                    leax      >bbsalias,pc ; form the address >bbsalias,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      Exit      ; branch when carry reports an error or unsigned underflow; target Exit
                    sta       AliasPath,u ; store a at AliasPath,u
L039F               leax      >U01F6,u  ; form the address >U01F6,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       AliasPath,u ; load a from AliasPath,u
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    bcs       L03DB     ; branch when carry reports an error or unsigned underflow; target L03DB
                    leax      >U01F6,u  ; form the address >U01F6,u in x
L03B2               lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    bne       L03B2     ; branch when the values differ or the result is nonzero; target L03B2
                    lda       #13       ; set a to the constant 13
                    sta       -$01,x    ; store a at -$01,x
                    lbsr      L057D     ; call subroutine L057D
                    cmpd      >U012C,u  ; compare d with >U012C,u and set the condition codes
                    bne       L039F     ; branch when the values differ or the result is nonzero; target L039F
                    leax      >U01F6,u  ; form the address >U01F6,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       TmpPath,u ; load a from TmpPath,u
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lda       AliasPath,u ; load a from AliasPath,u
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lbra      L03FD     ; continue execution at L03FD

L03DB               leax      >unkuser,pc ; form the address >unkuser,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       TmpPath,u ; load a from TmpPath,u
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lda       AliasPath,u ; load a from AliasPath,u
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lbra      L03FD     ; continue execution at L03FD

L03F0               leax      >allusers,pc ; form the address >allusers,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       TmpPath,u ; load a from TmpPath,u
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
L03FD               leax      >L0127,pc ; form the address >L0127,pc in x
                    ldy       >L0139,pc ; load y from >L0139,pc
                    lda       TmpPath,u ; load a from TmpPath,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      <U003E,u  ; form the address <U003E,u in x
                    ldb       >U0125,u  ; load b from >U0125,u
                    clra                ; clear a to zero and set the condition codes
                    lbsr      CvtDec    ; call subroutine CvtDec
                    lda       <U0041,u  ; load a from <U0041,u
                    sta       <U004F,u  ; store a at <U004F,u
                    lda       <U0042,u  ; load a from <U0042,u
                    sta       <U0050,u  ; store a at <U0050,u
                    lda       #47       ; set a to the constant 47
                    sta       <U0051,u  ; store a at <U0051,u
                    ldb       >U0126,u  ; load b from >U0126,u
                    clra                ; clear a to zero and set the condition codes
                    leax      <U003E,u  ; form the address <U003E,u in x
                    lbsr      CvtDec    ; call subroutine CvtDec
                    lda       <U0041,u  ; load a from <U0041,u
                    sta       <U0052,u  ; store a at <U0052,u
                    lda       <U0042,u  ; load a from <U0042,u
                    sta       <U0053,u  ; store a at <U0053,u
                    lda       #47       ; set a to the constant 47
                    sta       <U0054,u  ; store a at <U0054,u
                    ldb       >U0124,u  ; load b from >U0124,u
                    clra                ; clear a to zero and set the condition codes
                    leax      <U003E,u  ; form the address <U003E,u in x
                    lbsr      CvtDec    ; call subroutine CvtDec
                    lda       <U0041,u  ; load a from <U0041,u
                    sta       <U0055,u  ; store a at <U0055,u
                    lda       <U0042,u  ; load a from <U0042,u
                    sta       <U0056,u  ; store a at <U0056,u
                    lda       #32       ; set a to the constant 32
                    sta       <U0057,u  ; store a at <U0057,u
                    ldb       >U0127,u  ; load b from >U0127,u
                    clra                ; clear a to zero and set the condition codes
                    leax      <U003E,u  ; form the address <U003E,u in x
                    lbsr      CvtDec    ; call subroutine CvtDec
                    lda       <U0041,u  ; load a from <U0041,u
                    sta       <U0058,u  ; store a at <U0058,u
                    lda       <U0042,u  ; load a from <U0042,u
                    sta       <U0059,u  ; store a at <U0059,u
                    lda       #58       ; set a to the constant 58
                    sta       <U005A,u  ; store a at <U005A,u
                    ldb       >U0128,u  ; load b from >U0128,u
                    clra                ; clear a to zero and set the condition codes
                    leax      <U003E,u  ; form the address <U003E,u in x
                    lbsr      CvtDec    ; call subroutine CvtDec
                    lda       <U0041,u  ; load a from <U0041,u
                    sta       <U005B,u  ; store a at <U005B,u
                    lda       <U0042,u  ; load a from <U0042,u
                    sta       <U005C,u  ; store a at <U005C,u
                    lda       #13       ; set a to the constant 13
                    sta       <U005D,u  ; store a at <U005D,u
                    leax      <U004F,u  ; form the address <U004F,u in x
L049A               lda       ,x+       ; load a from ,x+
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       L049A     ; branch when the values are equal or the result is zero; target L049A
                    leax      -$01,x    ; form the address -$01,x in x
                    ldy       #200      ; set y to the constant 200
                    lda       TmpPath,u ; load a from TmpPath,u
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      Exit      ; branch when carry reports an error or unsigned underflow; target Exit
                    leax      >L0130,pc ; form the address >L0130,pc in x
                    ldy       >L0139,pc ; load y from >L0139,pc
                    lda       TmpPath,u ; load a from TmpPath,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      >U0106,u  ; form the address >U0106,u in x
                    ldy       #30       ; set y to the constant 30
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      Exit      ; branch when carry reports an error or unsigned underflow; target Exit
                    bra       L04D1     ; continue execution at L04D1

L04CE               lbra      L0301     ; continue execution at L0301

L04D1               leax      >dashline,pc ; form the address >dashline,pc in x
                    ldy       #80       ; set y to the constant 80
                    lda       TmpPath,u ; load a from TmpPath,u
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lda       MsgPath,u ; load a from MsgPath,u
                    ldx       >U00EE,u  ; load x from >U00EE,u
                    pshs      u         ; save u on the stack
                    ldu       >U00F0,u  ; load u from >U00F0,u
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    lbcs      Exit      ; branch when carry reports an error or unsigned underflow; target Exit
                    puls      u         ; restore u from the stack
L04F3               clra                ; clear a to zero and set the condition codes
                    ldb       #1        ; set b to the constant 1
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    bcs       L050C     ; branch when carry reports an error or unsigned underflow; target L050C
                    leax      U0000,u   ; form the address U0000,u in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lda       U0000,u   ; load a from U0000,u
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    lbeq      L0301     ; branch when the values are equal or the result is zero; target L0301
L050C               lda       MsgPath,u ; load a from MsgPath,u
                    leax      >U009E,u  ; form the address >U009E,u in x
                    ldy       #80       ; set y to the constant 80
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    lda       TmpPath,u ; load a from TmpPath,u
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bhi       L04F3     ; branch when the unsigned value is higher; target L04F3
                    leax      >dashline,pc ; form the address >dashline,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       TmpPath,u ; load a from TmpPath,u
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L017C,pc ; form the address >L017C,pc in x
                    ldy       #5        ; set y to the constant 5
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    ldd       U000A,u   ; load d from U000A,u
                    addd      #1        ; add to d using #1
                    std       U000A,u   ; store d at U000A,u
                    ldd       <BBuf,u   ; load d from <BBuf,u
                    cmpd      U0008,u   ; compare d with U0008,u and set the condition codes
                    lbcs      L0301     ; branch when carry reports an error or unsigned underflow; target L0301
L054D               lda       InxPath,u ; load a from InxPath,u
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lda       MsgPath,u ; load a from MsgPath,u
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lda       AliasPath,u ; load a from AliasPath,u
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lda       TmpPath,u ; load a from TmpPath,u
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    leax      >bbspack,pc ; form the address >bbspack,pc in x
                    leau      >L017E,pc ; form the workspace or data address >L017E,pc in u
                    ldy       #1        ; set y to the constant 1
                    lda       #17       ; set a to the constant 17
                    ldb       #3        ; set b to the constant 3
                    os9       F$Fork    ; invoke the OS-9 F$Fork service
                    bcs       Exit      ; branch when carry reports an error or unsigned underflow; target Exit
                    clrb                ; clear b to zero and set the condition codes
                    os9       F$Wait    ; invoke the OS-9 F$Wait service

Exit                os9       F$Exit    ; invoke the OS-9 F$Exit service

L057D               pshs      y         ; save y on the stack
L057F               lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      L0669     ; branch when the values are equal or the result is zero; target L0669
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L057F     ; branch when carry reports an error or unsigned underflow; target L057F
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L057F     ; branch when the unsigned value is higher; target L057F
                    leax      -$01,x    ; form the address -$01,x in x
L0591               lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L059D     ; branch when carry reports an error or unsigned underflow; target L059D
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L059D     ; branch when the unsigned value is higher; target L059D
                    bra       L0591     ; continue execution at L0591
L059D               pshs      x         ; save x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    clr       <U0030,u  ; clear <U0030,u to zero and set the condition codes
                    clr       <U0031,u  ; clear <U0031,u to zero and set the condition codes
                    ldd       #1        ; set d to the constant 1
                    std       <ABuf,u   ; store d at <ABuf,u
L05AD               lda       ,-x       ; load a from ,-x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L05E6     ; branch when carry reports an error or unsigned underflow; target L05E6
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L05E6     ; branch when the unsigned value is higher; target L05E6
                    suba      #48       ; subtract from a using #48
                    sta       U0006,u   ; store a at U0006,u
                    ldd       #0        ; set d to the constant 0
L05BE               tst       U0006,u   ; set condition codes from U0006,u without changing it
                    beq       L05C9     ; branch when the values are equal or the result is zero; target L05C9
                    addd      <ABuf,u   ; add to d using <ABuf,u
                    dec       U0006,u   ; decrement the value at U0006,u
                    bra       L05BE     ; continue execution at L05BE

L05C9               addd      <U0030,u  ; add to d using <U0030,u
                    std       <U0030,u  ; store d at <U0030,u
                    lda       #10       ; set a to the constant 10
                    sta       U0006,u   ; store a at U0006,u
                    ldd       #0        ; set d to the constant 0
L05D6               tst       U0006,u   ; set condition codes from U0006,u without changing it
                    beq       L05E1     ; branch when the values are equal or the result is zero; target L05E1
                    addd      <ABuf,u   ; add to d using <ABuf,u
                    dec       U0006,u   ; decrement the value at U0006,u
                    bra       L05D6     ; continue execution at L05D6

L05E1               std       <ABuf,u   ; store d at <ABuf,u
                    bra       L05AD     ; continue execution at L05AD

L05E6               ldd       <U0030,u  ; load d from <U0030,u
                    puls      x         ; restore x from the stack
                    puls      pc,y      ; restore pc,y and return to the caller

* Convert the number in D to a decimal string
CvtDec              pshs      x         ; save x on the stack
                    std       <U0030,u  ; store d at <U0030,u
                    lda       #48       ; set a to the constant 48
                    sta       0,x       ; store a at 0,x
                    sta       $01,x     ; store a at $01,x
                    sta       $02,x     ; store a at $02,x
                    sta       $03,x     ; store a at $03,x
                    sta       $04,x     ; store a at $04,x
                    ldd       #10000    ; set d to the constant 10000
                    std       <ABuf,u   ; store d at <ABuf,u
                    ldd       <U0030,u  ; load d from <U0030,u
                    lbsr      L0657     ; call subroutine L0657
                    ldd       #1000     ; set d to the constant 1000
                    std       <ABuf,u   ; store d at <ABuf,u
                    ldd       <U0030,u  ; load d from <U0030,u
                    bsr       L0657     ; call subroutine L0657
                    ldd       #100      ; set d to the constant 100
                    std       <ABuf,u   ; store d at <ABuf,u
                    ldd       <U0030,u  ; load d from <U0030,u
                    bsr       L0657     ; call subroutine L0657
                    ldd       #10       ; set d to the constant 10
                    std       <ABuf,u   ; store d at <ABuf,u
                    ldd       <U0030,u  ; load d from <U0030,u
                    bsr       L0657     ; call subroutine L0657
                    ldd       #1        ; set d to the constant 1
                    std       <ABuf,u   ; store d at <ABuf,u
                    ldd       <U0030,u  ; load d from <U0030,u
                    bsr       L0657     ; call subroutine L0657
                    lda       #13       ; set a to the constant 13
                    sta       0,x       ; store a at 0,x
                    puls      x         ; restore x from the stack
                    ldb       #32       ; set b to the constant 32
L063E               lda       0,x       ; load a from 0,x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bne       L0648     ; branch when the values differ or the result is nonzero; target L0648
                    stb       ,x+       ; store b at ,x+
                    bra       L063E     ; continue execution at L063E

L0648               lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L0654     ; branch when carry reports an error or unsigned underflow; target L0654
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L0654     ; branch when the unsigned value is higher; target L0654
                    bra       L0648     ; continue execution at L0648

L0654               leax      -$01,x    ; form the address -$01,x in x
                    rts                 ; return to the caller

L0657               subd      <ABuf,u   ; subtract from d using <ABuf,u
                    bcs       L0660     ; branch when carry reports an error or unsigned underflow; target L0660
                    inc       0,x       ; increment the value at 0,x
                    bra       L0657     ; continue execution at L0657

L0660               addd      <ABuf,u   ; add to d using <ABuf,u
                    std       <U0030,u  ; store d at <U0030,u
                    leax      $01,x     ; form the address $01,x in x
                    rts                 ; return to the caller

L0669               ldd       #-1       ; set d to the constant -1
                    puls      pc,y      ; restore pc,y and return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
