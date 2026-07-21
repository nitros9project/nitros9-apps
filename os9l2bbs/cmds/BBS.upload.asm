**********************************************************************
* BBS.upload - OS-9 Level 2 BBS command
*
* Syntax: BBS.upload [directory]
* Purpose: Select an upload protocol, receive a file, and register it for validation.
* Dispatches Uload* and updates BBS.userstats after success.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       BBS.upload
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

WorkByte_001        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_001        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_001      rmb       13        ; reserve 13 byte(s) in the module workspace
WorkWord_002        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_003        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_004        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_002      rmb       6         ; reserve 6 byte(s) in the module workspace
WorkWord_005        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_006        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_007        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_003      rmb       16        ; reserve 16 byte(s) in the module workspace
WorkBuffer_004      rmb       27        ; reserve 27 byte(s) in the module workspace
WorkWord_008        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_009        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_002        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_005      rmb       64        ; reserve 64 byte(s) in the module workspace
WorkBuffer_006      rmb       31        ; reserve 31 byte(s) in the module workspace
WorkByte_003        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_007      rmb       8499      ; reserve 8499 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.upload/ ; store an OS-9 high-bit-terminated string
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
Text_001            fcc       "Uloadx" ; store literal character data
                    fcb       $0D       ; store byte data
Text_002            fcc       "Uloadxc" ; store literal character data
                    fcb       $0D       ; store byte data
Text_003            fcc       "Uloady" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcc       "Uloadyb" ; store literal character data
                    fcb       $0D       ; store byte data
Text_004            fcc       "Uloada" ; store literal character data
                    fcb       $0D       ; store byte data
Text_005            fcc       "Enter your upload protocol" ; store literal character data
                    fcb       $0D       ; store byte data
Data_001            fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
                    fcc       "[A] Ascii" ; store literal character data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
                    fcc       "[X] xmodem" ; store literal character data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
                    fcc       "[C] xmodem (CRC)" ; store literal character data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
                    fcc       "[Y] ymodem" ; store literal character data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
                    fcc       "[Q] quit" ; store literal character data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
                    fcc       "Protocol?" ; store literal character data
Text_006            fcc       "Enter filename to upload:" ; store literal character data
Text_007            fcc       "DLD.lst" ; store literal character data
                    fcb       $0D       ; store byte data
Data_002            fcb       $0D       ; store byte data
                    fcb       $0A       ; store byte data
Text_008            fcc       "Enter a one-line description of this file" ; store literal character data
                    fcb       $0D       ; store byte data
Data_003            fcb       $3E       ; store byte data
                    fcb       $0D       ; store byte data
Text_009            fcc       "/dd/bbs/BBS.userstats" ; store literal character data
                    fcb       $0D       ; store byte data
start               lda       ,x        ; load a from ,x
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_001 ; branch when the values are equal or the result is zero; target Branch_001
                    lda       #1        ; set a to the constant 1
                    os9       I$ChgDir  ; change the current directory to the path at X
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
Branch_001          leax      >Text_007,pc ; form the address >Text_007,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    bcs       Branch_003 ; branch when carry reports an error or unsigned underflow; target Branch_003
                    sta       WorkWord_001,u ; store a at WorkWord_001,u
                    bra       Branch_004 ; continue execution at Branch_004
Branch_003          cmpb      #216      ; compare b with #216 and set the condition codes
                    lbne      Branch_002 ; branch when the values differ or the result is nonzero; target Branch_002
                    ldb       #27       ; set b to the constant 27
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    sta       WorkWord_001,u ; store a at WorkWord_001,u
Branch_004          leax      >Text_005,pc ; form the address >Text_005,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Data_001,pc ; form the address >Data_001,pc in x
                    ldy       #74       ; set y to the constant 74
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      WorkByte_001,u ; form the address WorkByte_001,u in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Read    ; read up to Y bytes from path A into X
                    leax      >Data_002,pc ; form the address >Data_002,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    anda      #223      ; mask a using #223
                    cmpa      #65       ; compare a with #65 and set the condition codes
                    lbeq      Branch_005 ; branch when the values are equal or the result is zero; target Branch_005
                    cmpa      #88       ; compare a with #88 and set the condition codes
                    lbeq      Branch_006 ; branch when the values are equal or the result is zero; target Branch_006
                    cmpa      #67       ; compare a with #67 and set the condition codes
                    lbeq      Branch_007 ; branch when the values are equal or the result is zero; target Branch_007
                    cmpa      #89       ; compare a with #89 and set the condition codes
                    lbeq      Branch_008 ; branch when the values are equal or the result is zero; target Branch_008
                    cmpa      #81       ; compare a with #81 and set the condition codes
                    lbeq      Branch_009 ; branch when the values are equal or the result is zero; target Branch_009
                    bra       Branch_001 ; continue execution at Branch_001
Branch_005          leax      >Text_006,pc ; form the address >Text_006,pc in x
                    ldy       #25       ; set y to the constant 25
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      <WorkBuffer_004,u ; form the address <WorkBuffer_004,u in x
                    ldy       #27       ; set y to the constant 27
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    bcs       Branch_005 ; branch when carry reports an error or unsigned underflow; target Branch_005
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    lbls      Branch_009 ; branch when the unsigned value is lower or equal; target Branch_009
                    lda       #17       ; set a to the constant 17
                    ldb       #3        ; set b to the constant 3
                    leax      >Text_004,pc ; form the address >Text_004,pc in x
                    pshs      u         ; save u on the stack
                    leau      <WorkBuffer_004,u ; form the workspace or data address <WorkBuffer_004,u in u
                    os9       F$Fork    ; spawn the module at X with parameters at U
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    clrb                ; clear b to zero and set the condition codes
                    os9       F$Wait    ; wait for a child process to terminate
                    tstb                ; set condition codes from b without changing it
                    lbne      Branch_002 ; branch when the values differ or the result is nonzero; target Branch_002
                    puls      u         ; restore u from the stack
                    lbra      Branch_010 ; continue execution at Branch_010
Branch_006          leax      >Text_006,pc ; form the address >Text_006,pc in x
                    ldy       #25       ; set y to the constant 25
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      <WorkBuffer_004,u ; form the address <WorkBuffer_004,u in x
                    ldy       #27       ; set y to the constant 27
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    bcs       Branch_006 ; branch when carry reports an error or unsigned underflow; target Branch_006
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    lbls      Branch_009 ; branch when the unsigned value is lower or equal; target Branch_009
                    lda       #17       ; set a to the constant 17
                    ldb       #3        ; set b to the constant 3
                    leax      >Text_001,pc ; form the address >Text_001,pc in x
                    pshs      u         ; save u on the stack
                    leau      <WorkBuffer_004,u ; form the workspace or data address <WorkBuffer_004,u in u
                    os9       F$Fork    ; spawn the module at X with parameters at U
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    clrb                ; clear b to zero and set the condition codes
                    os9       F$Wait    ; wait for a child process to terminate
                    tstb                ; set condition codes from b without changing it
                    lbne      Branch_002 ; branch when the values differ or the result is nonzero; target Branch_002
                    puls      u         ; restore u from the stack
                    lbra      Branch_010 ; continue execution at Branch_010
Branch_007          leax      >Text_006,pc ; form the address >Text_006,pc in x
                    ldy       #25       ; set y to the constant 25
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      <WorkBuffer_004,u ; form the address <WorkBuffer_004,u in x
                    ldy       #27       ; set y to the constant 27
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    bcs       Branch_007 ; branch when carry reports an error or unsigned underflow; target Branch_007
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    lbls      Branch_009 ; branch when the unsigned value is lower or equal; target Branch_009
                    lda       #17       ; set a to the constant 17
                    ldb       #3        ; set b to the constant 3
                    leax      >Text_002,pc ; form the address >Text_002,pc in x
                    pshs      u         ; save u on the stack
                    leau      <WorkBuffer_004,u ; form the workspace or data address <WorkBuffer_004,u in u
                    os9       F$Fork    ; spawn the module at X with parameters at U
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    clrb                ; clear b to zero and set the condition codes
                    os9       F$Wait    ; wait for a child process to terminate
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    tstb                ; set condition codes from b without changing it
                    lbne      Branch_002 ; branch when the values differ or the result is nonzero; target Branch_002
                    puls      u         ; restore u from the stack
                    lbra      Branch_010 ; continue execution at Branch_010
Branch_008          leax      >Text_006,pc ; form the address >Text_006,pc in x
                    ldy       #25       ; set y to the constant 25
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      <WorkBuffer_004,u ; form the address <WorkBuffer_004,u in x
                    ldy       #27       ; set y to the constant 27
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    bcs       Branch_008 ; branch when carry reports an error or unsigned underflow; target Branch_008
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    lbls      Branch_009 ; branch when the unsigned value is lower or equal; target Branch_009
                    lda       #17       ; set a to the constant 17
                    ldb       #3        ; set b to the constant 3
                    leax      >Text_003,pc ; form the address >Text_003,pc in x
                    pshs      u         ; save u on the stack
                    leau      <WorkBuffer_004,u ; form the workspace or data address <WorkBuffer_004,u in u
                    os9       F$Fork    ; spawn the module at X with parameters at U
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    clrb                ; clear b to zero and set the condition codes
                    os9       F$Wait    ; wait for a child process to terminate
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    tstb                ; set condition codes from b without changing it
                    lbne      Branch_002 ; branch when the values differ or the result is nonzero; target Branch_002
                    puls      u         ; restore u from the stack
                    lbra      Branch_010 ; continue execution at Branch_010
                    fcb       $86       ; store byte data
                    fcb       $11       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $8E       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $C6       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $8D       ; store byte data
                    fcb       $FD       ; store byte data
                    fcc       "~4@3" ; store literal character data
                    fcb       $C9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $2D       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $8B       ; store byte data
                    fcb       $5F       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $83       ; store byte data
                    fcb       $5D       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $26       ; store byte data
                    fcb       $01       ; store byte data
                    fcc       "~5@" ; store literal character data
Branch_010          lda       WorkWord_001,u ; load a from WorkWord_001,u
                    leax      >WorkBuffer_006,u ; form the address >WorkBuffer_006,u in x
                    ldy       #96       ; set y to the constant 96
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcs       Branch_011 ; branch when carry reports an error or unsigned underflow; target Branch_011
                    leay      <WorkBuffer_004,u ; form the address <WorkBuffer_004,u in y
Branch_012          lda       ,x+       ; load a from ,x+
                    cmpa      ,y+       ; compare a with ,y+ and set the condition codes
                    bne       Branch_010 ; branch when the values differ or the result is nonzero; target Branch_010
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_013 ; branch when the values are equal or the result is zero; target Branch_013
                    bra       Branch_012 ; continue execution at Branch_012
Branch_013          ldb       #218      ; set b to the constant 218
                    lbra      Branch_002 ; continue execution at Branch_002
Branch_011          cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      Branch_002 ; branch when the values differ or the result is nonzero; target Branch_002
                    lda       WorkWord_001,u ; load a from WorkWord_001,u
                    ldb       #5        ; set b to the constant 5
                    ldx       #0        ; set x to the constant 0
                    pshs      u         ; save u on the stack
                    ldu       #0        ; set u to the constant 0
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    puls      u         ; restore u from the stack
Branch_014          lda       WorkWord_001,u ; load a from WorkWord_001,u
                    leax      >WorkBuffer_006,u ; form the address >WorkBuffer_006,u in x
                    ldy       #96       ; set y to the constant 96
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcs       Branch_015 ; branch when carry reports an error or unsigned underflow; target Branch_015
                    lda       >WorkByte_003,u ; load a from >WorkByte_003,u
                    cmpa      #1        ; compare a with #1 and set the condition codes
                    bne       Branch_014 ; branch when the values differ or the result is nonzero; target Branch_014
                    lda       WorkWord_001,u ; load a from WorkWord_001,u
                    ldb       #5        ; set b to the constant 5
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; query status code B for path A
                    tfr       u,d       ; copy the register values specified by u,d
                    subd      #96       ; subtract from d using #96
                    bge       Branch_016 ; branch when the signed value is greater than or equal; target Branch_016
                    leax      -$01,x    ; form the address -$01,x in x
Branch_016          ldy       ,s        ; load y from the current stack frame at ,s
                    tfr       d,u       ; copy the register values specified by d,u
                    lda       $01,y     ; load a from $01,y
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    puls      u         ; restore u from the stack
                    bra       Branch_017 ; continue execution at Branch_017
Branch_015          cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      Branch_002 ; branch when the values differ or the result is nonzero; target Branch_002
Branch_017          ldx       #0        ; set x to the constant 0
                    ldy       #0        ; set y to the constant 0
                    stx       <WorkWord_008,u ; store x at <WorkWord_008,u
                    sty       <WorkWord_009,u ; store y at <WorkWord_009,u
                    leax      >Text_008,pc ; form the address >Text_008,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Data_003,pc ; form the address >Data_003,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      <WorkBuffer_005,u ; form the address <WorkBuffer_005,u in x
                    ldy       #64       ; set y to the constant 64
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    clr       <WorkByte_002,u ; clear <WorkByte_002,u to zero and set the condition codes
                    leax      <WorkBuffer_004,u ; form the address <WorkBuffer_004,u in x
                    ldy       #-1       ; set y to the constant -1
                    sty       <WorkWord_008,u ; store y at <WorkWord_008,u
                    sty       <WorkWord_009,u ; store y at <WorkWord_009,u
                    ldy       #96       ; set y to the constant 96
                    lda       WorkWord_001,u ; load a from WorkWord_001,u
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >Text_009,pc ; form the address >Text_009,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    bcc       Branch_018 ; branch when carry is clear; target Branch_018
                    ldb       #27       ; set b to the constant 27
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
Branch_018          sta       WorkBuffer_001,u ; store a at WorkBuffer_001,u
                    os9       F$ID      ; retrieve the current process and user IDs
                    sty       <WorkWord_002,u ; store y at <WorkWord_002,u
Branch_019          leax      <WorkWord_003,u ; form the address <WorkWord_003,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       WorkBuffer_001,u ; load a from WorkBuffer_001,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcs       Branch_020 ; branch when carry reports an error or unsigned underflow; target Branch_020
                    ldd       <WorkWord_003,u ; load d from <WorkWord_003,u
                    cmpd      <WorkWord_002,u ; compare d with <WorkWord_002,u and set the condition codes
                    bne       Branch_019 ; branch when the values differ or the result is nonzero; target Branch_019
                    bra       Branch_021 ; continue execution at Branch_021
Branch_020          cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      Branch_002 ; branch when the values differ or the result is nonzero; target Branch_002
                    lbra      Branch_022 ; continue execution at Branch_022
Branch_021          ldd       <WorkBuffer_003,u ; load d from <WorkBuffer_003,u
                    addd      #1        ; add to d using #1
                    std       <WorkBuffer_003,u ; store d at <WorkBuffer_003,u
                    lda       WorkBuffer_001,u ; load a from WorkBuffer_001,u
                    ldb       #5        ; set b to the constant 5
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; query status code B for path A
                    tfr       u,d       ; copy the register values specified by u,d
                    subd      #32       ; subtract from d using #32
                    bge       Branch_023 ; branch when the signed value is greater than or equal; target Branch_023
                    leax      -$01,x    ; form the address -$01,x in x
Branch_023          ldu       ,s        ; load u from the current stack frame at ,s
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       WorkBuffer_001,u ; load a from WorkBuffer_001,u
                    tfr       y,u       ; copy the register values specified by y,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    puls      u         ; restore u from the stack
                    leax      <WorkWord_003,u ; form the address <WorkWord_003,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       WorkBuffer_001,u ; load a from WorkBuffer_001,u
                    os9       I$Write   ; write Y bytes from X to path A
                    os9       I$Close   ; close path A
                    lbra      Branch_009 ; continue execution at Branch_009
Branch_022          leax      <WorkWord_003,u ; form the address <WorkWord_003,u in x
                    ldd       #1        ; set d to the constant 1
                    std       <WorkWord_004,u ; store d at <WorkWord_004,u
                    std       <WorkWord_006,u ; store d at <WorkWord_006,u
                    ldd       #0        ; set d to the constant 0
                    std       <WorkWord_005,u ; store d at <WorkWord_005,u
                    std       <WorkBuffer_003,u ; store d at <WorkBuffer_003,u
                    std       <WorkWord_007,u ; store d at <WorkWord_007,u
                    ldd       <WorkWord_002,u ; load d from <WorkWord_002,u
                    std       <WorkWord_003,u ; store d at <WorkWord_003,u
                    leax      <WorkBuffer_002,u ; form the address <WorkBuffer_002,u in x
                    os9       F$Time    ; read the current system date and time
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    leax      <WorkWord_003,u ; form the address <WorkWord_003,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       WorkBuffer_001,u ; load a from WorkBuffer_001,u
                    os9       I$Write   ; write Y bytes from X to path A
                    os9       I$Close   ; close path A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
Branch_009          clrb                ; clear b to zero and set the condition codes
Branch_002          os9       F$Exit    ; terminate the process with status B

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
