**********************************************************************
* DLD.validate - OS-9 Level 2 BBS command
*
* Syntax: DLD.validate [directory]
* Purpose: Review uploads, collect descriptions/keywords, and publish accepted files.
* Updates DLD.lst, DLD.dsc, and DLD.key and may delete rejected files.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       DLD.validate
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
WorkBuffer_001      rmb       80        ; reserve 80 byte(s) in the module workspace
WorkBuffer_002      rmb       32        ; reserve 32 byte(s) in the module workspace
WorkWord_001        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_002        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_003        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_004        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_005        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_006        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_009        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_010        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_007        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_011        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_012        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_008        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_009        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_003      rmb       3         ; reserve 3 byte(s) in the module workspace
WorkBuffer_004      rmb       12        ; reserve 12 byte(s) in the module workspace
WorkWord_010        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_011        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_005      rmb       27        ; reserve 27 byte(s) in the module workspace
WorkWord_012        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_013        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_013        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_006      rmb       64        ; reserve 64 byte(s) in the module workspace
WorkByte_014        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_007      rmb       8399      ; reserve 8399 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /DLD.validate/ ; store an OS-9 high-bit-terminated string
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
                    fcb       $0A       ; store byte data
                    fcc       "   Enter long description now          (Blank line ends)" ; store literal character data
                    fcb       $0D       ; store byte data
Text_001            fcc       "----------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
Text_002            fcc       "     Enter file keywords now            (Blank line ends)" ; store literal character data
                    fcb       $0D       ; store byte data
Text_003            fcc       "Enter keyword:" ; store literal character data
Data_002            fcb       $0A       ; store byte data
                    fcc       "[D]one [E]dit [C]ontinue or [L]ist" ; store literal character data
                    fcb       $0D       ; store byte data
Text_004            fcc       "Enter line #" ; store literal character data
                    fcb       $0D       ; store byte data
Data_003            fcb       $3E       ; store byte data
Data_004            fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
Data_005            fcb       $0A       ; store byte data
                    fcc       "Programs to be validated" ; store literal character data
                    fcb       $0D       ; store byte data
Text_005            fcc       "File name      Description" ; store literal character data
                    fcb       $0D       ; store byte data
Text_006            fcc       "----------------------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
Text_007            fcc       "[D]ownload, [V]alidate [K]ill or [N]ext:" ; store literal character data
Text_008            fcc       "DLD.lst" ; store literal character data
                    fcb       $0D       ; store byte data
Text_009            fcc       "DLD.dsc" ; store literal character data
                    fcb       $0D       ; store byte data
Text_010            fcc       "DLD.key" ; store literal character data
                    fcb       $0D       ; store byte data
Text_011            fcc       "                                                                               " ; store literal character data
Data_006            fcb       $0D       ; store byte data
                    fcb       $0A       ; store byte data
                    fcc       "Enter your download protocol" ; store literal character data
                    fcb       $0D       ; store byte data
Data_007            fcb       $0A       ; store byte data
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
Text_012            fcc       "dloadx" ; store literal character data
                    fcb       $0D       ; store byte data
Text_013            fcc       "dloadxc" ; store literal character data
                    fcb       $0D       ; store byte data
Text_014            fcc       "dloady" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcc       "dloadyb" ; store literal character data
                    fcb       $0D       ; store byte data
Data_008            fcb       $0A       ; store byte data
                    fcc       "Enter a one line description" ; store literal character data
                    fcb       $0D       ; store byte data
Text_015            fcc       "Delete file? (Y/N):" ; store literal character data
Data_009            fcb       $08       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $08       ; store byte data
start               lda       ,x        ; load a from ,x
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_001 ; branch when the values are equal or the result is zero; target Branch_001
                    lda       #1        ; set a to the constant 1
                    os9       I$ChgDir  ; change the current directory to the path at X
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
Branch_001          leax      >Text_010,pc ; form the address >Text_010,pc in x
                    lda       #2        ; set a to the constant 2
                    os9       I$Open    ; open the path at X using access mode A
                    bcc       Branch_003 ; branch when carry is clear; target Branch_003
                    cmpb      #216      ; compare b with #216 and set the condition codes
                    lbne      Branch_002 ; branch when the values differ or the result is nonzero; target Branch_002
                    ldb       #27       ; set b to the constant 27
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
Branch_003          sta       WorkByte_004,u ; store a at WorkByte_004,u
                    leax      >Text_009,pc ; form the address >Text_009,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    bcc       Branch_004 ; branch when carry is clear; target Branch_004
                    cmpb      #216      ; compare b with #216 and set the condition codes
                    lbne      Branch_002 ; branch when the values differ or the result is nonzero; target Branch_002
                    ldb       #27       ; set b to the constant 27
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
Branch_004          sta       WorkByte_005,u ; store a at WorkByte_005,u
                    leax      >Data_005,pc ; form the address >Data_005,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Text_005,pc ; form the address >Text_005,pc in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Text_006,pc ; form the address >Text_006,pc in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    ldx       #0        ; set x to the constant 0
                    stx       <WorkWord_001,u ; store x at <WorkWord_001,u
                    stx       <WorkWord_002,u ; store x at <WorkWord_002,u
                    stx       <WorkWord_003,u ; store x at <WorkWord_003,u
                    stx       <WorkWord_004,u ; store x at <WorkWord_004,u
                    leax      >Text_008,pc ; form the address >Text_008,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    sta       WorkByte_003,u ; store a at WorkByte_003,u
Branch_005          ldd       <WorkWord_001,u ; load d from <WorkWord_001,u
                    std       >WorkWord_005,u ; store d at >WorkWord_005,u
                    ldd       <WorkWord_002,u ; load d from <WorkWord_002,u
                    std       >WorkWord_006,u ; store d at >WorkWord_006,u
                    lda       WorkByte_003,u ; load a from WorkByte_003,u
                    pshs      u         ; save u on the stack
                    ldx       <WorkWord_001,u ; load x from <WorkWord_001,u
                    ldu       <WorkWord_002,u ; load u from <WorkWord_002,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    puls      u         ; restore u from the stack
                    leax      >WorkBuffer_005,u ; form the address >WorkBuffer_005,u in x
                    ldy       #96       ; set y to the constant 96
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lbcs      Branch_006 ; branch when carry reports an error or unsigned underflow; target Branch_006
                    pshs      u         ; save u on the stack
                    ldb       #5        ; set b to the constant 5
                    os9       I$GetStt  ; query status code B for path A
                    tfr       u,y       ; copy the register values specified by u,y
                    puls      u         ; restore u from the stack
                    stx       <WorkWord_001,u ; store x at <WorkWord_001,u
                    sty       <WorkWord_002,u ; store y at <WorkWord_002,u
                    tst       >WorkByte_013,u ; set condition codes from >WorkByte_013,u without changing it
                    lbne      Branch_007 ; branch when the values differ or the result is nonzero; target Branch_007
                    clrb                ; clear b to zero and set the condition codes
                    leax      >WorkBuffer_005,u ; form the address >WorkBuffer_005,u in x
Branch_008          lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_009 ; branch when the values are equal or the result is zero; target Branch_009
                    incb                ; increment b
                    bra       Branch_008 ; continue execution at Branch_008
Branch_009          stb       WorkByte_007,u ; store b at WorkByte_007,u
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    leax      >WorkBuffer_005,u ; form the address >WorkBuffer_005,u in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    ldb       #15       ; set b to the constant 15
                    subb      WorkByte_007,u ; subtract from b using WorkByte_007,u
                    blt       Branch_010 ; branch when the signed value is less; target Branch_010
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       #1        ; set a to the constant 1
                    leax      >Text_011,pc ; form the address >Text_011,pc in x
                    os9       I$Write   ; write Y bytes from X to path A
Branch_010          leax      >WorkBuffer_006,u ; form the address >WorkBuffer_006,u in x
                    ldy       #65       ; set y to the constant 65
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
Branch_011          leax      >Text_007,pc ; form the address >Text_007,pc in x
                    ldy       #40       ; set y to the constant 40
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      WorkByte_006,u ; form the address WorkByte_006,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; read up to Y bytes from path A into X
                    leax      >Data_006,pc ; form the address >Data_006,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       WorkByte_006,u ; load a from WorkByte_006,u
                    anda      #223      ; mask a using #223
                    cmpa      #86       ; compare a with #86 and set the condition codes
                    lbeq      Branch_012 ; branch when the values are equal or the result is zero; target Branch_012
                    cmpa      #68       ; compare a with #68 and set the condition codes
                    lbeq      Branch_013 ; branch when the values are equal or the result is zero; target Branch_013
                    cmpa      #78       ; compare a with #78 and set the condition codes
                    lbeq      Branch_007 ; branch when the values are equal or the result is zero; target Branch_007
                    cmpa      #75       ; compare a with #75 and set the condition codes
                    lbeq      Branch_014 ; branch when the values are equal or the result is zero; target Branch_014
                    lbra      Branch_011 ; continue execution at Branch_011
Branch_012          leax      >Data_008,pc ; form the address >Data_008,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Data_003,pc ; form the address >Data_003,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >WorkBuffer_006,u ; form the address >WorkBuffer_006,u in x
                    ldy       #64       ; set y to the constant 64
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lda       #255      ; set a to the constant 255
                    sta       >WorkByte_013,u ; store a at >WorkByte_013,u
                    lda       WorkByte_005,u ; load a from WorkByte_005,u
                    ldb       #2        ; set b to the constant 2
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; query status code B for path A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    tfr       u,y       ; copy the register values specified by u,y
                    puls      u         ; restore u from the stack
                    stx       >WorkWord_012,u ; store x at >WorkWord_012,u
                    sty       >WorkWord_013,u ; store y at >WorkWord_013,u
                    lda       WorkByte_003,u ; load a from WorkByte_003,u
                    pshs      u         ; save u on the stack
                    ldx       <WorkWord_003,u ; load x from <WorkWord_003,u
                    ldu       <WorkWord_004,u ; load u from <WorkWord_004,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    puls      u         ; restore u from the stack
                    leax      >WorkBuffer_005,u ; form the address >WorkBuffer_005,u in x
                    ldy       #96       ; set y to the constant 96
                    lda       WorkByte_003,u ; load a from WorkByte_003,u
                    os9       I$Write   ; write Y bytes from X to path A
                    pshs      u         ; save u on the stack
                    ldb       #5        ; set b to the constant 5
                    os9       I$GetStt  ; query status code B for path A
                    tfr       u,y       ; copy the register values specified by u,y
                    puls      u         ; restore u from the stack
                    stx       <WorkWord_003,u ; store x at <WorkWord_003,u
                    sty       <WorkWord_004,u ; store y at <WorkWord_004,u
                    lbra      Branch_015 ; continue execution at Branch_015
Branch_006          cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      Branch_002 ; branch when the values differ or the result is nonzero; target Branch_002
                    lda       WorkByte_003,u ; load a from WorkByte_003,u
                    ldb       #2        ; set b to the constant 2
                    pshs      u         ; save u on the stack
                    ldx       <WorkWord_003,u ; load x from <WorkWord_003,u
                    ldu       <WorkWord_004,u ; load u from <WorkWord_004,u
                    os9       I$SetStt  ; apply status operation B to path A
                    puls      u         ; restore u from the stack
                    lbra      Branch_016 ; continue execution at Branch_016
Branch_015          lda       WorkByte_004,u ; load a from WorkByte_004,u
                    ldb       #2        ; set b to the constant 2
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; query status code B for path A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    puls      u         ; restore u from the stack
                    leax      >Text_002,pc ; form the address >Text_002,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Text_001,pc ; form the address >Text_001,pc in x
                    ldy       #65       ; set y to the constant 65
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    ldd       >WorkWord_005,u ; load d from >WorkWord_005,u
                    std       >WorkWord_010,u ; store d at >WorkWord_010,u
                    ldd       >WorkWord_006,u ; load d from >WorkWord_006,u
                    std       >WorkWord_011,u ; store d at >WorkWord_011,u
Branch_017          leax      >Text_003,pc ; form the address >Text_003,pc in x
                    ldy       #14       ; set y to the constant 14
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >WorkBuffer_004,u ; form the address >WorkBuffer_004,u in x
                    ldy       #12       ; set y to the constant 12
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lbcs      Branch_017 ; branch when carry reports an error or unsigned underflow; target Branch_017
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    lbls      Branch_018 ; branch when the unsigned value is lower or equal; target Branch_018
                    lda       WorkByte_004,u ; load a from WorkByte_004,u
                    ldy       #16       ; set y to the constant 16
                    os9       I$Write   ; write Y bytes from X to path A
                    bra       Branch_017 ; continue execution at Branch_017
Branch_018          leax      >Data_001,pc ; form the address >Data_001,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    leax      >Text_001,pc ; form the address >Text_001,pc in x
                    ldy       #80       ; set y to the constant 80
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    ldd       #0        ; set d to the constant 0
                    std       >WorkByte_009,u ; store d at >WorkByte_009,u
                    sta       WorkByte_008,u ; store a at WorkByte_008,u
Branch_019          ldd       >WorkByte_009,u ; load d from >WorkByte_009,u
                    addd      #1        ; add to d using #1
                    std       >WorkByte_009,u ; store d at >WorkByte_009,u
                    cmpd      #99       ; compare d with #99 and set the condition codes
                    bge       Branch_020 ; branch when the signed value is greater than or equal; target Branch_020
                    lbsr      Routine_001 ; call subroutine Routine_001
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bls       Branch_020 ; branch when the unsigned value is lower or equal; target Branch_020
                    bra       Branch_019 ; continue execution at Branch_019
Branch_020          leax      >Data_002,pc ; form the address >Data_002,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Data_003,pc ; form the address >Data_003,pc in x
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
                    cmpa      #68       ; compare a with #68 and set the condition codes
                    lbeq      Branch_021 ; branch when the values are equal or the result is zero; target Branch_021
                    cmpa      #69       ; compare a with #69 and set the condition codes
                    beq       Branch_022 ; branch when the values are equal or the result is zero; target Branch_022
                    cmpa      #67       ; compare a with #67 and set the condition codes
                    beq       Branch_023 ; branch when the values are equal or the result is zero; target Branch_023
                    cmpa      #76       ; compare a with #76 and set the condition codes
                    lbeq      Branch_024 ; branch when the values are equal or the result is zero; target Branch_024
                    bra       Branch_020 ; continue execution at Branch_020
Branch_023          ldd       >WorkByte_009,u ; load d from >WorkByte_009,u
                    subd      #1        ; subtract from d using #1
                    std       >WorkByte_009,u ; store d at >WorkByte_009,u
                    bra       Branch_019 ; continue execution at Branch_019
Branch_022          leax      >Text_004,pc ; form the address >Text_004,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Data_003,pc ; form the address >Data_003,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    clra                ; clear a to zero and set the condition codes
                    leax      >WorkBuffer_003,u ; form the address >WorkBuffer_003,u in x
                    ldy       #3        ; set y to the constant 3
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lbsr      Routine_002 ; call subroutine Routine_002
                    cmpd      >WorkByte_009,u ; compare d with >WorkByte_009,u and set the condition codes
                    lbcc      Branch_020 ; branch when carry is clear; target Branch_020
                    std       >WorkWord_009,u ; store d at >WorkWord_009,u
                    leax      >WorkBuffer_003,u ; form the address >WorkBuffer_003,u in x
                    lbsr      Routine_003 ; call subroutine Routine_003
                    leax      >WorkBuffer_003,u ; form the address >WorkBuffer_003,u in x
                    lda       #58       ; set a to the constant 58
                    sta       $02,x     ; store a at $02,x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    ldd       >WorkWord_009,u ; load d from >WorkWord_009,u
                    leax      >WorkByte_014,u ; form the address >WorkByte_014,u in x
                    lda       #80       ; set a to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      d,x       ; form the address d,x in x
                    ldy       #80       ; set y to the constant 80
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    tfr       y,d       ; copy the register values specified by y,d
                    stb       WorkByte_008,u ; store b at WorkByte_008,u
                    dec       WorkByte_008,u ; decrement the value at WorkByte_008,u
                    leay      WorkBuffer_001,u ; form the address WorkBuffer_001,u in y
Branch_025          lda       ,x+       ; load a from ,x+
                    sta       ,y+       ; store a at ,y+
                    decb                ; decrement b
                    bne       Branch_025 ; branch when the values differ or the result is nonzero; target Branch_025
                    ldd       >WorkWord_009,u ; load d from >WorkWord_009,u
                    bsr       Routine_001 ; call subroutine Routine_001
                    lbra      Branch_020 ; continue execution at Branch_020
Branch_024          ldd       #0        ; set d to the constant 0
                    std       >WorkByte_009,u ; store d at >WorkByte_009,u
Branch_026          ldd       >WorkByte_009,u ; load d from >WorkByte_009,u
                    addd      #1        ; add to d using #1
                    std       >WorkByte_009,u ; store d at >WorkByte_009,u
                    leax      >WorkBuffer_003,u ; form the address >WorkBuffer_003,u in x
                    lbsr      Routine_003 ; call subroutine Routine_003
                    leax      >WorkBuffer_003,u ; form the address >WorkBuffer_003,u in x
                    lda       #58       ; set a to the constant 58
                    sta       $02,x     ; store a at $02,x
                    lda       #1        ; set a to the constant 1
                    ldy       #3        ; set y to the constant 3
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >WorkByte_014,u ; form the address >WorkByte_014,u in x
                    ldd       >WorkByte_009,u ; load d from >WorkByte_009,u
                    lda       #80       ; set a to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      d,x       ; form the address d,x in x
                    ldy       #80       ; set y to the constant 80
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bhi       Branch_026 ; branch when the unsigned value is higher; target Branch_026
                    lbra      Branch_020 ; continue execution at Branch_020
Routine_001         leax      >WorkBuffer_003,u ; form the address >WorkBuffer_003,u in x
                    pshs      d         ; save d on the stack
                    lbsr      Routine_003 ; call subroutine Routine_003
                    leax      >WorkBuffer_003,u ; form the address >WorkBuffer_003,u in x
                    lda       #58       ; set a to the constant 58
                    sta       $02,x     ; store a at $02,x
                    lda       #1        ; set a to the constant 1
                    ldy       #3        ; set y to the constant 3
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    leax      WorkBuffer_001,u ; form the address WorkBuffer_001,u in x
                    ldb       WorkByte_008,u ; load b from WorkByte_008,u
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      d         ; restore d from the stack
                    lda       #80       ; set a to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      >WorkByte_014,u ; form the address >WorkByte_014,u in x
                    leax      d,x       ; form the address d,x in x
                    leay      WorkBuffer_001,u ; form the address WorkBuffer_001,u in y
                    ldb       #80       ; set b to the constant 80
                    lda       WorkByte_008,u ; load a from WorkByte_008,u
                    beq       Branch_027 ; branch when the values are equal or the result is zero; target Branch_027
                    sta       >WorkByte_011,u ; store a at >WorkByte_011,u
Branch_028          lda       ,y+       ; load a from ,y+
                    sta       ,x+       ; store a at ,x+
                    decb                ; decrement b
                    dec       >WorkByte_011,u ; decrement the value at >WorkByte_011,u
                    bne       Branch_028 ; branch when the values differ or the result is nonzero; target Branch_028
Branch_027          clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    lbsr      Routine_004 ; call subroutine Routine_004
                    rts                 ; return to the caller
Branch_021          lda       #0        ; set a to the constant 0
                    sta       >WorkWord_007,u ; store a at >WorkWord_007,u
Branch_029          lda       >WorkWord_007,u ; load a from >WorkWord_007,u
                    inca                ; increment a
                    sta       >WorkWord_007,u ; store a at >WorkWord_007,u
                    cmpa      >WorkByte_010,u ; compare a with >WorkByte_010,u and set the condition codes
                    bhi       Branch_030 ; branch when the unsigned value is higher; target Branch_030
                    ldb       #80       ; set b to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      >WorkByte_014,u ; form the address >WorkByte_014,u in x
                    leax      d,x       ; form the address d,x in x
                    ldy       #80       ; set y to the constant 80
                    lda       WorkByte_005,u ; load a from WorkByte_005,u
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bls       Branch_030 ; branch when the unsigned value is lower or equal; target Branch_030
                    tfr       y,d       ; copy the register values specified by y,d
                    bra       Branch_029 ; continue execution at Branch_029
Branch_030          lbra      Branch_005 ; continue execution at Branch_005
Branch_013          leax      >Data_007,pc ; form the address >Data_007,pc in x
                    ldy       #63       ; set y to the constant 63
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      WorkByte_006,u ; form the address WorkByte_006,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; read up to Y bytes from path A into X
                    leax      >Data_006,pc ; form the address >Data_006,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       WorkByte_006,u ; load a from WorkByte_006,u
                    anda      #223      ; mask a using #223
                    cmpa      #88       ; compare a with #88 and set the condition codes
                    beq       Branch_031 ; branch when the values are equal or the result is zero; target Branch_031
                    cmpa      #67       ; compare a with #67 and set the condition codes
                    beq       Branch_032 ; branch when the values are equal or the result is zero; target Branch_032
                    cmpa      #89       ; compare a with #89 and set the condition codes
                    beq       Branch_033 ; branch when the values are equal or the result is zero; target Branch_033
                    cmpa      #81       ; compare a with #81 and set the condition codes
                    lbeq      Branch_016 ; branch when the values are equal or the result is zero; target Branch_016
                    bra       Branch_013 ; continue execution at Branch_013
Branch_031          leax      >Text_012,pc ; form the address >Text_012,pc in x
                    bra       Branch_034 ; continue execution at Branch_034
Branch_032          leax      >Text_013,pc ; form the address >Text_013,pc in x
                    bra       Branch_034 ; continue execution at Branch_034
Branch_033          leax      >Text_014,pc ; form the address >Text_014,pc in x
                    bra       Branch_034 ; continue execution at Branch_034
                    fcb       $30       ; store byte data
                    fcb       $8D       ; store byte data
                    fcb       $FB       ; store byte data
                    fcb       $35       ; store byte data
Branch_034          ldb       WorkByte_007,u ; load b from WorkByte_007,u
                    incb                ; increment b
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       #17       ; set a to the constant 17
                    ldb       #3        ; set b to the constant 3
                    pshs      u         ; save u on the stack
                    leau      >WorkBuffer_005,u ; form the workspace or data address >WorkBuffer_005,u in u
                    os9       F$Fork    ; spawn the module at X with parameters at U
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    clrb                ; clear b to zero and set the condition codes
                    os9       F$Wait    ; wait for a child process to terminate
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    puls      u         ; restore u from the stack
                    tstb                ; set condition codes from b without changing it
                    lbne      Branch_013 ; branch when the values differ or the result is nonzero; target Branch_013
Branch_007          lda       WorkByte_003,u ; load a from WorkByte_003,u
                    pshs      u         ; save u on the stack
                    ldx       <WorkWord_003,u ; load x from <WorkWord_003,u
                    ldu       <WorkWord_004,u ; load u from <WorkWord_004,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    puls      u         ; restore u from the stack
                    leax      >WorkBuffer_005,u ; form the address >WorkBuffer_005,u in x
                    ldy       #96       ; set y to the constant 96
                    os9       I$Write   ; write Y bytes from X to path A
                    pshs      u         ; save u on the stack
                    ldb       #5        ; set b to the constant 5
                    os9       I$GetStt  ; query status code B for path A
                    tfr       u,y       ; copy the register values specified by u,y
                    puls      u         ; restore u from the stack
                    stx       <WorkWord_003,u ; store x at <WorkWord_003,u
                    sty       <WorkWord_004,u ; store y at <WorkWord_004,u
                    lbra      Branch_005 ; continue execution at Branch_005
Branch_014          leax      >Text_015,pc ; form the address >Text_015,pc in x
                    ldy       #19       ; set y to the constant 19
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      WorkByte_006,u ; form the address WorkByte_006,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; read up to Y bytes from path A into X
                    leax      >Data_004,pc ; form the address >Data_004,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       WorkByte_006,u ; load a from WorkByte_006,u
                    anda      #223      ; mask a using #223
                    cmpa      #89       ; compare a with #89 and set the condition codes
                    lbne      Branch_007 ; branch when the values differ or the result is nonzero; target Branch_007
                    leax      >WorkBuffer_005,u ; form the address >WorkBuffer_005,u in x
                    os9       I$Delete  ; delete the path named at X
                    lda       #1        ; set a to the constant 1
                    sta       >WorkByte_013,u ; store a at >WorkByte_013,u
                    lda       WorkByte_003,u ; load a from WorkByte_003,u
                    pshs      u         ; save u on the stack
                    ldx       <WorkWord_003,u ; load x from <WorkWord_003,u
                    ldu       <WorkWord_004,u ; load u from <WorkWord_004,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    puls      u         ; restore u from the stack
                    leax      >WorkBuffer_005,u ; form the address >WorkBuffer_005,u in x
                    ldy       #96       ; set y to the constant 96
                    lda       WorkByte_003,u ; load a from WorkByte_003,u
                    os9       I$Write   ; write Y bytes from X to path A
                    pshs      u         ; save u on the stack
                    ldb       #5        ; set b to the constant 5
                    os9       I$GetStt  ; query status code B for path A
                    tfr       u,y       ; copy the register values specified by u,y
                    puls      u         ; restore u from the stack
                    stx       <WorkWord_003,u ; store x at <WorkWord_003,u
                    sty       <WorkWord_004,u ; store y at <WorkWord_004,u
                    lbra      Branch_005 ; continue execution at Branch_005
Branch_016          clrb                ; clear b to zero and set the condition codes
Branch_002          os9       F$Exit    ; terminate the process with status B
Routine_004         lbsr      Code_001  ; call subroutine Code_001
                    ldb       WorkByte_008,u ; load b from WorkByte_008,u
                    leay      b,y       ; form the address b,y in y
                    pshs      y         ; save y on the stack
                    negb                ; negate b
                    sex                 ; sign-extend b into d
                    leay      d,y       ; form the address d,y in y
                    clr       WorkByte_008,u ; clear WorkByte_008,u to zero and set the condition codes
                    cmpy      #0        ; compare y with #0 and set the condition codes
                    lbeq      Branch_035 ; branch when the values are equal or the result is zero; target Branch_035
                    pshs      y,x       ; save y,x on the stack
                    lda       #13       ; set a to the constant 13
Branch_036          sta       ,x+       ; store a at ,x+
                    leay      -$01,y    ; form the address -$01,y in y
                    bne       Branch_036 ; branch when the values differ or the result is nonzero; target Branch_036
                    puls      y,x       ; restore y,x from the stack
Branch_037          pshs      y,x       ; save y,x on the stack
                    leax      WorkByte_006,u ; form the address WorkByte_006,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcs       Branch_038 ; branch when carry reports an error or unsigned underflow; target Branch_038
                    lda       WorkByte_006,u ; load a from WorkByte_006,u
                    cmpa      #1        ; compare a with #1 and set the condition codes
                    beq       Branch_039 ; branch when the values are equal or the result is zero; target Branch_039
                    cmpa      #8        ; compare a with #8 and set the condition codes
                    beq       Branch_040 ; branch when the values are equal or the result is zero; target Branch_040
                    cmpa      #24       ; compare a with #24 and set the condition codes
                    beq       Branch_041 ; branch when the values are equal or the result is zero; target Branch_041
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      Branch_042 ; branch when the values are equal or the result is zero; target Branch_042
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    bcs       Branch_038 ; branch when carry reports an error or unsigned underflow; target Branch_038
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      y,x       ; restore y,x from the stack
                    lda       WorkByte_006,u ; load a from WorkByte_006,u
                    sta       ,x+       ; store a at ,x+
                    leay      -$01,y    ; form the address -$01,y in y
                    lbeq      Branch_043 ; branch when the values are equal or the result is zero; target Branch_043
                    bra       Branch_037 ; continue execution at Branch_037
Branch_038          puls      y,x       ; restore y,x from the stack
                    bra       Branch_037 ; continue execution at Branch_037
Branch_039          puls      y,x       ; restore y,x from the stack
                    leay      -$01,y    ; form the address -$01,y in y
                    beq       Branch_044 ; branch when the values are equal or the result is zero; target Branch_044
                    lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_045 ; branch when the values are equal or the result is zero; target Branch_045
                    pshs      y,x       ; save y,x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    bra       Branch_039 ; continue execution at Branch_039
Branch_045          leax      -$01,x    ; form the address -$01,x in x
Branch_044          leay      $01,y     ; form the address $01,y in y
                    lbra      Branch_037 ; continue execution at Branch_037
Branch_040          puls      y,x       ; restore y,x from the stack
                    leay      $01,y     ; form the address $01,y in y
                    cmpy      ,s        ; compare y with ,s and set the condition codes
                    bhi       Branch_046 ; branch when the unsigned value is higher; target Branch_046
                    pshs      y,x       ; save y,x on the stack
                    leax      >Data_009,pc ; form the address >Data_009,pc in x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      y,x       ; restore y,x from the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    lbra      Branch_037 ; continue execution at Branch_037
Branch_046          leay      -$01,y    ; form the address -$01,y in y
                    lbra      Branch_037 ; continue execution at Branch_037
Branch_041          puls      y,x       ; restore y,x from the stack
                    leay      $01,y     ; form the address $01,y in y
                    cmpy      ,s        ; compare y with ,s and set the condition codes
                    bhi       Branch_046 ; branch when the unsigned value is higher; target Branch_046
                    pshs      y,x       ; save y,x on the stack
                    leax      >Data_009,pc ; form the address >Data_009,pc in x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      y,x       ; restore y,x from the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    cmpy      ,s        ; compare y with ,s and set the condition codes
                    lbhi      Branch_037 ; branch when the unsigned value is higher; target Branch_037
                    pshs      y,x       ; save y,x on the stack
                    bra       Branch_041 ; continue execution at Branch_041
Branch_042          puls      y,x       ; restore y,x from the stack
Branch_035          lda       #13       ; set a to the constant 13
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
Branch_043          puls      d         ; restore d from the stack
                    pshs      y         ; save y on the stack
                    subd      ,s        ; subtract from d using ,s
                    leas      $02,s     ; adjust the system stack pointer
                    addd      #1        ; add to d using #1
                    tfr       d,y       ; copy the register values specified by d,y
                    clrb                ; clear b to zero and set the condition codes
Branch_047          leay      -$01,y    ; form the address -$01,y in y
                    beq       Branch_048 ; branch when the values are equal or the result is zero; target Branch_048
                    lda       ,-x       ; load a from ,-x
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       Branch_049 ; branch when the values are equal or the result is zero; target Branch_049
                    pshs      y,x       ; save y,x on the stack
                    leax      >Data_009,pc ; form the address >Data_009,pc in x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    incb                ; increment b
                    puls      y,x       ; restore y,x from the stack
                    bra       Branch_047 ; continue execution at Branch_047
Branch_048          lda       #13       ; set a to the constant 13
                    sta       <$004F,x  ; store a at <$004F,x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    puls      y         ; restore y from the stack
                    rts                 ; return to the caller
Branch_049          lda       #13       ; set a to the constant 13
                    sta       ,x+       ; store a at ,x+
                    pshs      y,x       ; save y,x on the stack
                    stb       WorkByte_008,u ; store b at WorkByte_008,u
                    leay      WorkBuffer_001,u ; form the address WorkBuffer_001,u in y
Branch_050          lda       ,x+       ; load a from ,x+
                    sta       ,y+       ; store a at ,y+
                    decb                ; decrement b
                    bne       Branch_050 ; branch when the values differ or the result is nonzero; target Branch_050
                    leax      >Data_004,pc ; form the address >Data_004,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    puls      y,x       ; restore y,x from the stack
                    lbsr      Routine_005 ; call subroutine Routine_005
                    rts                 ; return to the caller
Code_001            pshs      y,x,d     ; save y,x,d on the stack
                    leax      <WorkBuffer_002,u ; form the address <WorkBuffer_002,u in x
                    clra                ; clear a to zero and set the condition codes
                    ldb       #0        ; set b to the constant 0
                    os9       I$GetStt  ; query status code B for path A
                    leax      -$20,x    ; form the address -$20,x in x
                    clr       <$0024,x  ; clear <$0024,x to zero and set the condition codes
                    leax      <$0020,x  ; form the address <$0020,x in x
                    os9       I$SetStt  ; apply status operation B to path A
                    puls      pc,y,x,d  ; restore pc,y,x,d and return to the caller
Routine_005         pshs      y,x,d     ; save y,x,d on the stack
                    leax      <WorkBuffer_002,u ; form the address <WorkBuffer_002,u in x
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
Branch_051          lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      Branch_052 ; branch when the values are equal or the result is zero; target Branch_052
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_051 ; branch when carry reports an error or unsigned underflow; target Branch_051
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_051 ; branch when the unsigned value is higher; target Branch_051
                    leax      -$01,x    ; form the address -$01,x in x
Branch_053          lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_054 ; branch when carry reports an error or unsigned underflow; target Branch_054
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_054 ; branch when the unsigned value is higher; target Branch_054
                    bra       Branch_053 ; continue execution at Branch_053
Branch_054          pshs      x         ; save x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    clr       >WorkByte_011,u ; clear >WorkByte_011,u to zero and set the condition codes
                    clr       >WorkByte_012,u ; clear >WorkByte_012,u to zero and set the condition codes
                    ldd       #1        ; set d to the constant 1
                    std       >WorkWord_008,u ; store d at >WorkWord_008,u
Branch_055          lda       ,-x       ; load a from ,-x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_056 ; branch when carry reports an error or unsigned underflow; target Branch_056
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_056 ; branch when the unsigned value is higher; target Branch_056
                    suba      #48       ; subtract from a using #48
                    sta       WorkByte_002,u ; store a at WorkByte_002,u
                    ldd       #0        ; set d to the constant 0
Branch_057          tst       WorkByte_002,u ; set condition codes from WorkByte_002,u without changing it
                    beq       Branch_058 ; branch when the values are equal or the result is zero; target Branch_058
                    addd      >WorkWord_008,u ; add to d using >WorkWord_008,u
                    dec       WorkByte_002,u ; decrement the value at WorkByte_002,u
                    bra       Branch_057 ; continue execution at Branch_057
Branch_058          addd      >WorkByte_011,u ; add to d using >WorkByte_011,u
                    std       >WorkByte_011,u ; store d at >WorkByte_011,u
                    lda       #10       ; set a to the constant 10
                    sta       WorkByte_002,u ; store a at WorkByte_002,u
                    ldd       #0        ; set d to the constant 0
Branch_059          tst       WorkByte_002,u ; set condition codes from WorkByte_002,u without changing it
                    beq       Branch_060 ; branch when the values are equal or the result is zero; target Branch_060
                    addd      >WorkWord_008,u ; add to d using >WorkWord_008,u
                    dec       WorkByte_002,u ; decrement the value at WorkByte_002,u
                    bra       Branch_059 ; continue execution at Branch_059
Branch_060          std       >WorkWord_008,u ; store d at >WorkWord_008,u
                    bra       Branch_055 ; continue execution at Branch_055
Branch_056          ldd       >WorkByte_011,u ; load d from >WorkByte_011,u
                    puls      x         ; restore x from the stack
                    puls      pc,y      ; restore pc,y and return to the caller
Routine_003         pshs      y         ; save y on the stack
                    std       >WorkByte_011,u ; store d at >WorkByte_011,u
                    lda       #48       ; set a to the constant 48
                    sta       ,x        ; store a at ,x
                    sta       $01,x     ; store a at $01,x
                    ldd       #10       ; set d to the constant 10
                    std       >WorkWord_008,u ; store d at >WorkWord_008,u
                    ldd       >WorkByte_011,u ; load d from >WorkByte_011,u
                    bsr       Routine_006 ; call subroutine Routine_006
                    ldd       #1        ; set d to the constant 1
                    std       >WorkWord_008,u ; store d at >WorkWord_008,u
                    ldd       >WorkByte_011,u ; load d from >WorkByte_011,u
                    bsr       Routine_006 ; call subroutine Routine_006
                    lda       #13       ; set a to the constant 13
                    sta       ,x        ; store a at ,x
                    puls      pc,y      ; restore pc,y and return to the caller
Routine_006         subd      >WorkWord_008,u ; subtract from d using >WorkWord_008,u
                    bcs       Branch_061 ; branch when carry reports an error or unsigned underflow; target Branch_061
                    inc       ,x        ; increment the value at ,x
                    bra       Routine_006 ; continue execution at Routine_006
Branch_061          addd      >WorkWord_008,u ; add to d using >WorkWord_008,u
                    std       >WorkByte_011,u ; store d at >WorkByte_011,u
                    leax      $01,x     ; form the address $01,x in x
                    rts                 ; return to the caller
Branch_052          ldd       #-1       ; set d to the constant -1
                    puls      pc,y      ; restore pc,y and return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
