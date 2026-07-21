**********************************************************************
* DLD.add - OS-9 Level 2 BBS command
*
* Syntax: DLD.add [directory]
* Purpose: Register a file copied into a download directory outside BBS.upload.
* Updates DLD.lst, DLD.dsc, and DLD.key.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       DLD.add
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
WorkBuffer_001      rmb       80        ; reserve 80 byte(s) in the module workspace
WorkBuffer_002      rmb       32        ; reserve 32 byte(s) in the module workspace
WorkBuffer_003      rmb       27        ; reserve 27 byte(s) in the module workspace
WorkWord_001        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_002        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_006        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_004      rmb       64        ; reserve 64 byte(s) in the module workspace
WorkBuffer_005      rmb       31        ; reserve 31 byte(s) in the module workspace
WorkBuffer_006      rmb       65        ; reserve 65 byte(s) in the module workspace
WorkBuffer_007      rmb       12        ; reserve 12 byte(s) in the module workspace
WorkWord_003        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_004        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_005        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_008      rmb       3         ; reserve 3 byte(s) in the module workspace
WorkByte_007        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_008        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_009        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_006        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_010        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_011        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_007        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_008        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_009      rmb       3         ; reserve 3 byte(s) in the module workspace
WorkByte_012        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_010      rmb       8399      ; reserve 8399 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /DLD.add/ ; store an OS-9 high-bit-terminated string
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
Text_001            fcc       "Enter filename to add:" ; store literal character data
Text_002            fcc       "DLD.lst" ; store literal character data
                    fcb       $0D       ; store byte data
Text_003            fcc       "DLD.key" ; store literal character data
                    fcb       $0D       ; store byte data
Text_004            fcc       "DLD.dsc" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $0A       ; store byte data
Text_005            fcc       "Enter a one-line description of this file" ; store literal character data
                    fcb       $0D       ; store byte data
Text_006            fcc       "----------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
Data_001            fcb       $3E       ; store byte data
                    fcb       $0D       ; store byte data
Text_007            fcc       "     Enter file keywords now            (Blank line ends)" ; store literal character data
                    fcb       $0D       ; store byte data
Data_002            fcb       $0A       ; store byte data
                    fcb       $0A       ; store byte data
                    fcc       "   Enter long description now          (Blank line ends)" ; store literal character data
                    fcb       $0D       ; store byte data
Text_008            fcc       "Enter keyword:" ; store literal character data
Data_003            fcb       $0A       ; store byte data
                    fcc       "[D]one [E]dit [C]ontinue or [L]ist" ; store literal character data
                    fcb       $0D       ; store byte data
Data_004            fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
Text_009            fcc       "Enter line #" ; store literal character data
                    fcb       $0D       ; store byte data
Data_005            fcb       $08       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $08       ; store byte data
start               lda       ,x        ; load a from ,x
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_001 ; branch when the values are equal or the result is zero; target Branch_001
                    lda       #1        ; set a to the constant 1
                    os9       I$ChgDir  ; change the current directory to the path at X
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
Branch_001          leax      >Text_002,pc ; form the address >Text_002,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    bcc       Branch_003 ; branch when carry is clear; target Branch_003
                    cmpb      #216      ; compare b with #216 and set the condition codes
                    lbne      Branch_002 ; branch when the values differ or the result is nonzero; target Branch_002
                    ldb       #27       ; set b to the constant 27
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
Branch_003          sta       WorkByte_002,u ; store a at WorkByte_002,u
                    leax      >Text_003,pc ; form the address >Text_003,pc in x
                    lda       #2        ; set a to the constant 2
                    os9       I$Open    ; open the path at X using access mode A
                    bcc       Branch_004 ; branch when carry is clear; target Branch_004
                    cmpb      #216      ; compare b with #216 and set the condition codes
                    lbne      Branch_002 ; branch when the values differ or the result is nonzero; target Branch_002
                    ldb       #27       ; set b to the constant 27
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
Branch_004          sta       WorkByte_003,u ; store a at WorkByte_003,u
                    leax      >Text_004,pc ; form the address >Text_004,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    bcc       Branch_005 ; branch when carry is clear; target Branch_005
                    cmpb      #216      ; compare b with #216 and set the condition codes
                    lbne      Branch_002 ; branch when the values differ or the result is nonzero; target Branch_002
                    ldb       #27       ; set b to the constant 27
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
Branch_005          sta       WorkByte_004,u ; store a at WorkByte_004,u
                    leax      >Text_001,pc ; form the address >Text_001,pc in x
                    ldy       #22       ; set y to the constant 22
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      <WorkBuffer_003,u ; form the address <WorkBuffer_003,u in x
                    ldy       #27       ; set y to the constant 27
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
Branch_006          lda       WorkByte_002,u ; load a from WorkByte_002,u
                    leax      >WorkBuffer_005,u ; form the address >WorkBuffer_005,u in x
                    ldy       #96       ; set y to the constant 96
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcs       Branch_007 ; branch when carry reports an error or unsigned underflow; target Branch_007
                    leay      <WorkBuffer_003,u ; form the address <WorkBuffer_003,u in y
Branch_008          lda       ,x+       ; load a from ,x+
                    cmpa      ,y+       ; compare a with ,y+ and set the condition codes
                    bne       Branch_006 ; branch when the values differ or the result is nonzero; target Branch_006
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_009 ; branch when the values are equal or the result is zero; target Branch_009
                    bra       Branch_008 ; continue execution at Branch_008
Branch_009          ldb       #218      ; set b to the constant 218
                    lbra      Branch_002 ; continue execution at Branch_002
Branch_007          cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      Branch_002 ; branch when the values differ or the result is nonzero; target Branch_002
                    lda       WorkByte_002,u ; load a from WorkByte_002,u
                    ldb       #5        ; set b to the constant 5
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; query status code B for path A
                    tfr       u,y       ; copy the register values specified by u,y
                    puls      u         ; restore u from the stack
                    stx       >WorkWord_005,u ; store x at >WorkWord_005,u
                    sty       >WorkBuffer_008,u ; store y at >WorkBuffer_008,u
                    ldx       #0        ; set x to the constant 0
                    pshs      u         ; save u on the stack
                    ldu       #0        ; set u to the constant 0
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    puls      u         ; restore u from the stack
Branch_010          lda       WorkByte_002,u ; load a from WorkByte_002,u
                    leax      >WorkBuffer_005,u ; form the address >WorkBuffer_005,u in x
                    ldy       #96       ; set y to the constant 96
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcs       Branch_011 ; branch when carry reports an error or unsigned underflow; target Branch_011
                    lda       >WorkBuffer_006,u ; load a from >WorkBuffer_006,u
                    cmpa      #1        ; compare a with #1 and set the condition codes
                    bne       Branch_010 ; branch when the values differ or the result is nonzero; target Branch_010
                    lda       WorkByte_002,u ; load a from WorkByte_002,u
                    ldb       #5        ; set b to the constant 5
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; query status code B for path A
                    tfr       u,d       ; copy the register values specified by u,d
                    subd      #96       ; subtract from d using #96
                    bge       Branch_012 ; branch when the signed value is greater than or equal; target Branch_012
                    leax      -$01,x    ; form the address -$01,x in x
Branch_012          tfr       d,u       ; copy the register values specified by d,u
                    ldy       ,s        ; load y from the current stack frame at ,s
                    lda       $01,y     ; load a from $01,y
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    tfr       u,y       ; copy the register values specified by u,y
                    puls      u         ; restore u from the stack
                    stx       >WorkWord_005,u ; store x at >WorkWord_005,u
                    sty       >WorkBuffer_008,u ; store y at >WorkBuffer_008,u
                    bra       Branch_013 ; continue execution at Branch_013
Branch_011          cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      Branch_002 ; branch when the values differ or the result is nonzero; target Branch_002
Branch_013          leax      >Text_005,pc ; form the address >Text_005,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Data_001,pc ; form the address >Data_001,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >WorkBuffer_004,u ; form the address >WorkBuffer_004,u in x
                    ldy       #64       ; set y to the constant 64
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lda       #255      ; set a to the constant 255
                    sta       >WorkByte_006,u ; store a at >WorkByte_006,u
                    leax      <WorkBuffer_003,u ; form the address <WorkBuffer_003,u in x
                    lda       WorkByte_004,u ; load a from WorkByte_004,u
                    ldb       #2        ; set b to the constant 2
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; query status code B for path A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    tfr       u,y       ; copy the register values specified by u,y
                    puls      u         ; restore u from the stack
                    stx       >WorkWord_001,u ; store x at >WorkWord_001,u
                    sty       >WorkWord_002,u ; store y at >WorkWord_002,u
                    ldy       #96       ; set y to the constant 96
                    leax      <WorkBuffer_003,u ; form the address <WorkBuffer_003,u in x
                    lda       WorkByte_002,u ; load a from WorkByte_002,u
                    os9       I$Write   ; write Y bytes from X to path A
                    lda       WorkByte_003,u ; load a from WorkByte_003,u
                    ldb       #2        ; set b to the constant 2
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; query status code B for path A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    puls      u         ; restore u from the stack
                    leax      >Text_007,pc ; form the address >Text_007,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Text_006,pc ; form the address >Text_006,pc in x
                    ldy       #65       ; set y to the constant 65
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    ldd       >WorkWord_005,u ; load d from >WorkWord_005,u
                    std       >WorkWord_003,u ; store d at >WorkWord_003,u
                    ldd       >WorkBuffer_008,u ; load d from >WorkBuffer_008,u
                    std       >WorkWord_004,u ; store d at >WorkWord_004,u
Branch_014          leax      >Text_008,pc ; form the address >Text_008,pc in x
                    ldy       #14       ; set y to the constant 14
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >WorkBuffer_007,u ; form the address >WorkBuffer_007,u in x
                    ldy       #12       ; set y to the constant 12
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lbcs      Branch_014 ; branch when carry reports an error or unsigned underflow; target Branch_014
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    lbls      Branch_015 ; branch when the unsigned value is lower or equal; target Branch_015
                    lda       WorkByte_003,u ; load a from WorkByte_003,u
                    ldy       #16       ; set y to the constant 16
                    os9       I$Write   ; write Y bytes from X to path A
                    bra       Branch_014 ; continue execution at Branch_014
Branch_015          leax      >Data_002,pc ; form the address >Data_002,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    leax      >Text_006,pc ; form the address >Text_006,pc in x
                    ldy       #80       ; set y to the constant 80
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    ldd       #0        ; set d to the constant 0
                    std       >WorkByte_008,u ; store d at >WorkByte_008,u
                    sta       WorkByte_005,u ; store a at WorkByte_005,u
Branch_016          ldd       >WorkByte_008,u ; load d from >WorkByte_008,u
                    addd      #1        ; add to d using #1
                    std       >WorkByte_008,u ; store d at >WorkByte_008,u
                    cmpd      #99       ; compare d with #99 and set the condition codes
                    bge       Branch_017 ; branch when the signed value is greater than or equal; target Branch_017
                    lbsr      Routine_001 ; call subroutine Routine_001
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bls       Branch_017 ; branch when the unsigned value is lower or equal; target Branch_017
                    bra       Branch_016 ; continue execution at Branch_016
Branch_017          leax      >Data_003,pc ; form the address >Data_003,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Data_001,pc ; form the address >Data_001,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      WorkByte_001,u ; form the address WorkByte_001,u in x
                    clra                ; clear a to zero and set the condition codes
                    ldy       #1        ; set y to the constant 1
                    os9       I$Read    ; read up to Y bytes from path A into X
                    leax      >Data_004,pc ; form the address >Data_004,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    anda      #223      ; mask a using #223
                    cmpa      #68       ; compare a with #68 and set the condition codes
                    lbeq      Branch_018 ; branch when the values are equal or the result is zero; target Branch_018
                    cmpa      #69       ; compare a with #69 and set the condition codes
                    beq       Branch_019 ; branch when the values are equal or the result is zero; target Branch_019
                    cmpa      #67       ; compare a with #67 and set the condition codes
                    beq       Branch_020 ; branch when the values are equal or the result is zero; target Branch_020
                    cmpa      #76       ; compare a with #76 and set the condition codes
                    lbeq      Branch_021 ; branch when the values are equal or the result is zero; target Branch_021
                    bra       Branch_017 ; continue execution at Branch_017
Branch_020          ldd       >WorkByte_008,u ; load d from >WorkByte_008,u
                    subd      #1        ; subtract from d using #1
                    std       >WorkByte_008,u ; store d at >WorkByte_008,u
                    bra       Branch_016 ; continue execution at Branch_016
Branch_019          leax      >Text_009,pc ; form the address >Text_009,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Data_001,pc ; form the address >Data_001,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    clra                ; clear a to zero and set the condition codes
                    leax      >WorkBuffer_009,u ; form the address >WorkBuffer_009,u in x
                    ldy       #3        ; set y to the constant 3
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lbsr      Routine_002 ; call subroutine Routine_002
                    cmpd      >WorkByte_008,u ; compare d with >WorkByte_008,u and set the condition codes
                    lbcc      Branch_017 ; branch when carry is clear; target Branch_017
                    std       >WorkWord_008,u ; store d at >WorkWord_008,u
                    leax      >WorkBuffer_009,u ; form the address >WorkBuffer_009,u in x
                    lbsr      Routine_003 ; call subroutine Routine_003
                    leax      >WorkBuffer_009,u ; form the address >WorkBuffer_009,u in x
                    lda       #58       ; set a to the constant 58
                    sta       $02,x     ; store a at $02,x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    ldd       >WorkWord_008,u ; load d from >WorkWord_008,u
                    leax      >WorkByte_012,u ; form the address >WorkByte_012,u in x
                    lda       #80       ; set a to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      d,x       ; form the address d,x in x
                    ldy       #80       ; set y to the constant 80
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    tfr       y,d       ; copy the register values specified by y,d
                    stb       WorkByte_005,u ; store b at WorkByte_005,u
                    dec       WorkByte_005,u ; decrement the value at WorkByte_005,u
                    leay      WorkBuffer_001,u ; form the address WorkBuffer_001,u in y
Branch_022          lda       ,x+       ; load a from ,x+
                    sta       ,y+       ; store a at ,y+
                    decb                ; decrement b
                    bne       Branch_022 ; branch when the values differ or the result is nonzero; target Branch_022
                    ldd       >WorkWord_008,u ; load d from >WorkWord_008,u
                    bsr       Routine_001 ; call subroutine Routine_001
                    lbra      Branch_017 ; continue execution at Branch_017
Branch_021          ldd       #0        ; set d to the constant 0
                    std       >WorkByte_008,u ; store d at >WorkByte_008,u
Branch_023          ldd       >WorkByte_008,u ; load d from >WorkByte_008,u
                    addd      #1        ; add to d using #1
                    std       >WorkByte_008,u ; store d at >WorkByte_008,u
                    leax      >WorkBuffer_009,u ; form the address >WorkBuffer_009,u in x
                    lbsr      Routine_003 ; call subroutine Routine_003
                    leax      >WorkBuffer_009,u ; form the address >WorkBuffer_009,u in x
                    lda       #58       ; set a to the constant 58
                    sta       $02,x     ; store a at $02,x
                    lda       #1        ; set a to the constant 1
                    ldy       #3        ; set y to the constant 3
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >WorkByte_012,u ; form the address >WorkByte_012,u in x
                    ldd       >WorkByte_008,u ; load d from >WorkByte_008,u
                    lda       #80       ; set a to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      d,x       ; form the address d,x in x
                    ldy       #80       ; set y to the constant 80
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bhi       Branch_023 ; branch when the unsigned value is higher; target Branch_023
                    lbra      Branch_017 ; continue execution at Branch_017
Routine_001         leax      >WorkBuffer_009,u ; form the address >WorkBuffer_009,u in x
                    pshs      d         ; save d on the stack
                    lbsr      Routine_003 ; call subroutine Routine_003
                    leax      >WorkBuffer_009,u ; form the address >WorkBuffer_009,u in x
                    lda       #58       ; set a to the constant 58
                    sta       $02,x     ; store a at $02,x
                    lda       #1        ; set a to the constant 1
                    ldy       #3        ; set y to the constant 3
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    leax      WorkBuffer_001,u ; form the address WorkBuffer_001,u in x
                    ldb       WorkByte_005,u ; load b from WorkByte_005,u
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      d         ; restore d from the stack
                    lda       #80       ; set a to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      >WorkByte_012,u ; form the address >WorkByte_012,u in x
                    leax      d,x       ; form the address d,x in x
                    leay      WorkBuffer_001,u ; form the address WorkBuffer_001,u in y
                    ldb       #80       ; set b to the constant 80
                    lda       WorkByte_005,u ; load a from WorkByte_005,u
                    beq       Branch_024 ; branch when the values are equal or the result is zero; target Branch_024
                    sta       >WorkByte_010,u ; store a at >WorkByte_010,u
Branch_025          lda       ,y+       ; load a from ,y+
                    sta       ,x+       ; store a at ,x+
                    decb                ; decrement b
                    dec       >WorkByte_010,u ; decrement the value at >WorkByte_010,u
                    bne       Branch_025 ; branch when the values differ or the result is nonzero; target Branch_025
Branch_024          clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    lbsr      Routine_004 ; call subroutine Routine_004
                    rts                 ; return to the caller
Branch_018          lda       #0        ; set a to the constant 0
                    sta       >WorkWord_006,u ; store a at >WorkWord_006,u
Branch_026          lda       >WorkWord_006,u ; load a from >WorkWord_006,u
                    inca                ; increment a
                    sta       >WorkWord_006,u ; store a at >WorkWord_006,u
                    cmpa      >WorkByte_009,u ; compare a with >WorkByte_009,u and set the condition codes
                    bhi       Branch_027 ; branch when the unsigned value is higher; target Branch_027
                    ldb       #80       ; set b to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      >WorkByte_012,u ; form the address >WorkByte_012,u in x
                    leax      d,x       ; form the address d,x in x
                    ldy       #80       ; set y to the constant 80
                    lda       WorkByte_004,u ; load a from WorkByte_004,u
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bls       Branch_027 ; branch when the unsigned value is lower or equal; target Branch_027
                    tfr       y,d       ; copy the register values specified by y,d
                    bra       Branch_026 ; continue execution at Branch_026
Branch_027          clrb                ; clear b to zero and set the condition codes
Branch_002          os9       F$Exit    ; terminate the process with status B
Routine_004         lbsr      Code_001  ; call subroutine Code_001
                    ldb       WorkByte_005,u ; load b from WorkByte_005,u
                    leay      b,y       ; form the address b,y in y
                    pshs      y         ; save y on the stack
                    negb                ; negate b
                    sex                 ; sign-extend b into d
                    leay      d,y       ; form the address d,y in y
                    clr       WorkByte_005,u ; clear WorkByte_005,u to zero and set the condition codes
                    cmpy      #0        ; compare y with #0 and set the condition codes
                    lbeq      Branch_028 ; branch when the values are equal or the result is zero; target Branch_028
                    pshs      y,x       ; save y,x on the stack
                    lda       #13       ; set a to the constant 13
Branch_029          sta       ,x+       ; store a at ,x+
                    leay      -$01,y    ; form the address -$01,y in y
                    bne       Branch_029 ; branch when the values differ or the result is nonzero; target Branch_029
                    puls      y,x       ; restore y,x from the stack
Branch_030          pshs      y,x       ; save y,x on the stack
                    leax      WorkByte_001,u ; form the address WorkByte_001,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcs       Branch_031 ; branch when carry reports an error or unsigned underflow; target Branch_031
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    cmpa      #1        ; compare a with #1 and set the condition codes
                    beq       Branch_032 ; branch when the values are equal or the result is zero; target Branch_032
                    cmpa      #8        ; compare a with #8 and set the condition codes
                    beq       Branch_033 ; branch when the values are equal or the result is zero; target Branch_033
                    cmpa      #24       ; compare a with #24 and set the condition codes
                    beq       Branch_034 ; branch when the values are equal or the result is zero; target Branch_034
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      Branch_035 ; branch when the values are equal or the result is zero; target Branch_035
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    bcs       Branch_031 ; branch when carry reports an error or unsigned underflow; target Branch_031
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      y,x       ; restore y,x from the stack
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    sta       ,x+       ; store a at ,x+
                    leay      -$01,y    ; form the address -$01,y in y
                    lbeq      Branch_036 ; branch when the values are equal or the result is zero; target Branch_036
                    bra       Branch_030 ; continue execution at Branch_030
Branch_031          puls      y,x       ; restore y,x from the stack
                    bra       Branch_030 ; continue execution at Branch_030
Branch_032          puls      y,x       ; restore y,x from the stack
                    leay      -$01,y    ; form the address -$01,y in y
                    beq       Branch_037 ; branch when the values are equal or the result is zero; target Branch_037
                    lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_038 ; branch when the values are equal or the result is zero; target Branch_038
                    pshs      y,x       ; save y,x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    bra       Branch_032 ; continue execution at Branch_032
Branch_038          leax      -$01,x    ; form the address -$01,x in x
Branch_037          leay      $01,y     ; form the address $01,y in y
                    lbra      Branch_030 ; continue execution at Branch_030
Branch_033          puls      y,x       ; restore y,x from the stack
                    leay      $01,y     ; form the address $01,y in y
                    cmpy      ,s        ; compare y with ,s and set the condition codes
                    bhi       Branch_039 ; branch when the unsigned value is higher; target Branch_039
                    pshs      y,x       ; save y,x on the stack
                    leax      >Data_005,pc ; form the address >Data_005,pc in x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      y,x       ; restore y,x from the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    lbra      Branch_030 ; continue execution at Branch_030
Branch_039          leay      -$01,y    ; form the address -$01,y in y
                    lbra      Branch_030 ; continue execution at Branch_030
Branch_034          puls      y,x       ; restore y,x from the stack
                    leay      $01,y     ; form the address $01,y in y
                    cmpy      ,s        ; compare y with ,s and set the condition codes
                    bhi       Branch_039 ; branch when the unsigned value is higher; target Branch_039
                    pshs      y,x       ; save y,x on the stack
                    leax      >Data_005,pc ; form the address >Data_005,pc in x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      y,x       ; restore y,x from the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    cmpy      ,s        ; compare y with ,s and set the condition codes
                    lbhi      Branch_030 ; branch when the unsigned value is higher; target Branch_030
                    pshs      y,x       ; save y,x on the stack
                    bra       Branch_034 ; continue execution at Branch_034
Branch_035          puls      y,x       ; restore y,x from the stack
Branch_028          lda       #13       ; set a to the constant 13
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
Branch_036          puls      d         ; restore d from the stack
                    pshs      y         ; save y on the stack
                    subd      ,s        ; subtract from d using ,s
                    leas      $02,s     ; adjust the system stack pointer
                    addd      #1        ; add to d using #1
                    tfr       d,y       ; copy the register values specified by d,y
                    clrb                ; clear b to zero and set the condition codes
Branch_040          leay      -$01,y    ; form the address -$01,y in y
                    beq       Branch_041 ; branch when the values are equal or the result is zero; target Branch_041
                    lda       ,-x       ; load a from ,-x
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       Branch_042 ; branch when the values are equal or the result is zero; target Branch_042
                    pshs      y,x       ; save y,x on the stack
                    leax      >Data_005,pc ; form the address >Data_005,pc in x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    incb                ; increment b
                    puls      y,x       ; restore y,x from the stack
                    bra       Branch_040 ; continue execution at Branch_040
Branch_041          lda       #13       ; set a to the constant 13
                    sta       <$004F,x  ; store a at <$004F,x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    puls      y         ; restore y from the stack
                    rts                 ; return to the caller
Branch_042          lda       #13       ; set a to the constant 13
                    sta       ,x+       ; store a at ,x+
                    pshs      y,x       ; save y,x on the stack
                    stb       WorkByte_005,u ; store b at WorkByte_005,u
                    leay      WorkBuffer_001,u ; form the address WorkBuffer_001,u in y
Branch_043          lda       ,x+       ; load a from ,x+
                    sta       ,y+       ; store a at ,y+
                    decb                ; decrement b
                    bne       Branch_043 ; branch when the values differ or the result is nonzero; target Branch_043
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
Branch_044          lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      Branch_045 ; branch when the values are equal or the result is zero; target Branch_045
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_044 ; branch when carry reports an error or unsigned underflow; target Branch_044
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_044 ; branch when the unsigned value is higher; target Branch_044
                    leax      -$01,x    ; form the address -$01,x in x
Branch_046          lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_047 ; branch when carry reports an error or unsigned underflow; target Branch_047
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_047 ; branch when the unsigned value is higher; target Branch_047
                    bra       Branch_046 ; continue execution at Branch_046
Branch_047          pshs      x         ; save x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    clr       >WorkByte_010,u ; clear >WorkByte_010,u to zero and set the condition codes
                    clr       >WorkByte_011,u ; clear >WorkByte_011,u to zero and set the condition codes
                    ldd       #1        ; set d to the constant 1
                    std       >WorkWord_007,u ; store d at >WorkWord_007,u
Branch_048          lda       ,-x       ; load a from ,-x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_049 ; branch when carry reports an error or unsigned underflow; target Branch_049
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_049 ; branch when the unsigned value is higher; target Branch_049
                    suba      #48       ; subtract from a using #48
                    sta       >WorkByte_007,u ; store a at >WorkByte_007,u
                    ldd       #0        ; set d to the constant 0
Branch_050          tst       >WorkByte_007,u ; set condition codes from >WorkByte_007,u without changing it
                    beq       Branch_051 ; branch when the values are equal or the result is zero; target Branch_051
                    addd      >WorkWord_007,u ; add to d using >WorkWord_007,u
                    dec       >WorkByte_007,u ; decrement the value at >WorkByte_007,u
                    bra       Branch_050 ; continue execution at Branch_050
Branch_051          addd      >WorkByte_010,u ; add to d using >WorkByte_010,u
                    std       >WorkByte_010,u ; store d at >WorkByte_010,u
                    lda       #10       ; set a to the constant 10
                    sta       >WorkByte_007,u ; store a at >WorkByte_007,u
                    ldd       #0        ; set d to the constant 0
Branch_052          tst       >WorkByte_007,u ; set condition codes from >WorkByte_007,u without changing it
                    beq       Branch_053 ; branch when the values are equal or the result is zero; target Branch_053
                    addd      >WorkWord_007,u ; add to d using >WorkWord_007,u
                    dec       >WorkByte_007,u ; decrement the value at >WorkByte_007,u
                    bra       Branch_052 ; continue execution at Branch_052
Branch_053          std       >WorkWord_007,u ; store d at >WorkWord_007,u
                    bra       Branch_048 ; continue execution at Branch_048
Branch_049          ldd       >WorkByte_010,u ; load d from >WorkByte_010,u
                    puls      x         ; restore x from the stack
                    puls      pc,y      ; restore pc,y and return to the caller
Routine_003         pshs      y         ; save y on the stack
                    std       >WorkByte_010,u ; store d at >WorkByte_010,u
                    lda       #48       ; set a to the constant 48
                    sta       ,x        ; store a at ,x
                    sta       $01,x     ; store a at $01,x
                    ldd       #10       ; set d to the constant 10
                    std       >WorkWord_007,u ; store d at >WorkWord_007,u
                    ldd       >WorkByte_010,u ; load d from >WorkByte_010,u
                    bsr       Routine_006 ; call subroutine Routine_006
                    ldd       #1        ; set d to the constant 1
                    std       >WorkWord_007,u ; store d at >WorkWord_007,u
                    ldd       >WorkByte_010,u ; load d from >WorkByte_010,u
                    bsr       Routine_006 ; call subroutine Routine_006
                    lda       #13       ; set a to the constant 13
                    sta       ,x        ; store a at ,x
                    puls      pc,y      ; restore pc,y and return to the caller
Routine_006         subd      >WorkWord_007,u ; subtract from d using >WorkWord_007,u
                    bcs       Branch_054 ; branch when carry reports an error or unsigned underflow; target Branch_054
                    inc       ,x        ; increment the value at ,x
                    bra       Routine_006 ; continue execution at Routine_006
Branch_054          addd      >WorkWord_007,u ; add to d using >WorkWord_007,u
                    std       >WorkByte_010,u ; store d at >WorkByte_010,u
                    leax      $01,x     ; form the address $01,x in x
                    rts                 ; return to the caller
Branch_045          ldd       #-1       ; set d to the constant -1
                    puls      pc,y      ; restore pc,y and return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
