**********************************************************************
* BBS.mail.delete - OS-9 Level 2 BBS command
*
* Syntax: BBS.mail.delete
* Purpose: Delete selected private-mail records belonging to the current user.
* Data: BBS.mail and BBS.mail.inx in the mailroom.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       BBS.mail.delete
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
WorkBuffer_001      rmb       3         ; reserve 3 byte(s) in the module workspace
WorkByte_004        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_001        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_002        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_005        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_006        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_007        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_008        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_002      rmb       232       ; reserve 232 byte(s) in the module workspace
WorkWord_003        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_004        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_003      rmb       60        ; reserve 60 byte(s) in the module workspace
WorkBuffer_004      rmb       80        ; reserve 80 byte(s) in the module workspace
WorkWord_005        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_005      rmb       60        ; reserve 60 byte(s) in the module workspace
WorkWord_006        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_006      rmb       200       ; reserve 200 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.mail.delete/ ; store an OS-9 high-bit-terminated string
Text_001            fcc       "BBS.mail.inx" ; store literal character data
                    fcb       $0D       ; store byte data
Text_002            fcc       "BBS.mail" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $0A       ; store byte data
                    fcb       $0A       ; store byte data
                    fcc       "From    :Left on :About   :" ; store literal character data
                    fcb       $00       ; store byte data
                    fcb       $09       ; store byte data
                    fcc       "----------------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
Text_003            fcc       "Deleting mail..." ; store literal character data
                    fcb       $0D       ; store byte data
Data_001            fcb       $0A       ; store byte data
                    fcc       "One moment please..." ; store literal character data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
Text_004            fcc       "mail.scratch.inx" ; store literal character data
                    fcb       $0D       ; store byte data
Text_005            fcc       "mail.scratch" ; store literal character data
                    fcb       $0D       ; store byte data
Data_002            fcb       $2E       ; store byte data
                    fcb       $0D       ; store byte data
                    fcc       "Rename" ; store literal character data
                    fcb       $0D       ; store byte data

start               os9       F$ID      ; retrieve the current process and user IDs
                    sty       WorkWord_002,u ; store y at WorkWord_002,u
                    ldy       #0        ; set y to the constant 0
                    os9       F$SUser   ; change the process user ID to Y
                    leax      >Data_001,pc ; form the address >Data_001,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Text_001,pc ; form the address >Text_001,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    sta       WorkByte_001,u ; store a at WorkByte_001,u
                    leax      >Text_002,pc ; form the address >Text_002,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    sta       WorkByte_002,u ; store a at WorkByte_002,u
                    leax      >Text_004,pc ; form the address >Text_004,pc in x
                    lda       #2        ; set a to the constant 2
                    ldb       #11       ; set b to the constant 11
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    sta       WorkByte_003,u ; store a at WorkByte_003,u
                    leax      >Text_005,pc ; form the address >Text_005,pc in x
                    lda       #2        ; set a to the constant 2
                    ldb       #11       ; set b to the constant 11
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    sta       WorkBuffer_001,u ; store a at WorkBuffer_001,u
                    clr       WorkByte_005,u ; clear WorkByte_005,u to zero and set the condition codes
                    clr       WorkByte_006,u ; clear WorkByte_006,u to zero and set the condition codes
                    clr       WorkByte_007,u ; clear WorkByte_007,u to zero and set the condition codes
                    clr       WorkByte_008,u ; clear WorkByte_008,u to zero and set the condition codes
                    leax      >WorkWord_003,u ; form the address >WorkWord_003,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    lda       WorkByte_003,u ; load a from WorkByte_003,u
                    os9       I$Write   ; write Y bytes from X to path A
Branch_002          leax      >WorkWord_005,u ; form the address >WorkWord_005,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcs       Branch_003 ; branch when carry reports an error or unsigned underflow; target Branch_003
                    cmpy      #64       ; compare y with #64 and set the condition codes
                    bne       Branch_003 ; branch when the values differ or the result is nonzero; target Branch_003
                    ldd       >WorkWord_006,u ; load d from >WorkWord_006,u
                    cmpd      WorkWord_002,u ; compare d with WorkWord_002,u and set the condition codes
                    beq       Branch_004 ; branch when the values are equal or the result is zero; target Branch_004
                    ldd       WorkByte_005,u ; load d from WorkByte_005,u
                    std       >WorkWord_005,u ; store d at >WorkWord_005,u
                    ldd       WorkByte_007,u ; load d from WorkByte_007,u
                    std       >WorkBuffer_005,u ; store d at >WorkBuffer_005,u
                    lda       WorkByte_003,u ; load a from WorkByte_003,u
                    os9       I$Write   ; write Y bytes from X to path A
Branch_005          lda       WorkByte_002,u ; load a from WorkByte_002,u
                    leax      >WorkBuffer_004,u ; form the address >WorkBuffer_004,u in x
                    ldy       #80       ; set y to the constant 80
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    bcs       Branch_003 ; branch when carry reports an error or unsigned underflow; target Branch_003
                    lda       WorkBuffer_001,u ; load a from WorkBuffer_001,u
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    tfr       y,d       ; copy the register values specified by y,d
                    addd      WorkByte_007,u ; add to d using WorkByte_007,u
                    std       WorkByte_007,u ; store d at WorkByte_007,u
                    bcc       Branch_006 ; branch when carry is clear; target Branch_006
                    ldd       WorkByte_005,u ; load d from WorkByte_005,u
                    addd      #1        ; add to d using #1
                    std       WorkByte_005,u ; store d at WorkByte_005,u
Branch_006          cmpy      #1        ; compare y with #1 and set the condition codes
                    bhi       Branch_005 ; branch when the unsigned value is higher; target Branch_005
                    bra       Branch_002 ; continue execution at Branch_002
Branch_004          leax      >Text_003,pc ; form the address >Text_003,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    ldd       >WorkWord_003,u ; load d from >WorkWord_003,u
                    subd      #1        ; subtract from d using #1
                    std       >WorkWord_003,u ; store d at >WorkWord_003,u
Branch_007          lda       WorkByte_002,u ; load a from WorkByte_002,u
                    leax      >WorkBuffer_004,u ; form the address >WorkBuffer_004,u in x
                    ldy       #80       ; set y to the constant 80
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    bcs       Branch_003 ; branch when carry reports an error or unsigned underflow; target Branch_003
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bhi       Branch_007 ; branch when the unsigned value is higher; target Branch_007
                    lbra      Branch_002 ; continue execution at Branch_002
Branch_003          ldd       WorkByte_005,u ; load d from WorkByte_005,u
                    std       >WorkWord_004,u ; store d at >WorkWord_004,u
                    ldd       WorkByte_007,u ; load d from WorkByte_007,u
                    std       >WorkBuffer_003,u ; store d at >WorkBuffer_003,u
                    pshs      u         ; save u on the stack
                    lda       WorkByte_003,u ; load a from WorkByte_003,u
                    ldx       #0        ; set x to the constant 0
                    ldu       #0        ; set u to the constant 0
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    puls      u         ; restore u from the stack
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      >WorkWord_003,u ; form the address >WorkWord_003,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       WorkByte_003,u ; load a from WorkByte_003,u
                    os9       I$Write   ; write Y bytes from X to path A
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    os9       I$Close   ; close path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    lda       WorkByte_002,u ; load a from WorkByte_002,u
                    os9       I$Close   ; close path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    lda       WorkByte_003,u ; load a from WorkByte_003,u
                    os9       I$Close   ; close path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    lda       WorkBuffer_001,u ; load a from WorkBuffer_001,u
                    os9       I$Close   ; close path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      >Text_001,pc ; form the address >Text_001,pc in x
                    os9       I$Delete  ; delete the path named at X
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      >Text_002,pc ; form the address >Text_002,pc in x
                    os9       I$Delete  ; delete the path named at X
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    lbsr      Routine_001 ; call subroutine Routine_001
                    clrb                ; clear b to zero and set the condition codes
Branch_001          pshs      b         ; save b on the stack
                    ldy       WorkWord_002,u ; load y from WorkWord_002,u
                    os9       F$SUser   ; change the process user ID to Y
                    puls      b         ; restore b from the stack
                    os9       F$Exit    ; terminate the process with status B
Routine_001         leax      >Data_002,pc ; form the address >Data_002,pc in x
                    lda       #131      ; set a to the constant 131
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    sta       WorkWord_001,u ; store a at WorkWord_001,u
                    clr       WorkByte_004,u ; clear WorkByte_004,u to zero and set the condition codes
Branch_008          pshs      u         ; save u on the stack
                    lda       WorkByte_004,u ; load a from WorkByte_004,u
                    inca                ; increment a
                    sta       WorkByte_004,u ; store a at WorkByte_004,u
                    ldb       #32       ; set b to the constant 32
                    mul                 ; multiply a by b and return the product in d
                    tfr       d,x       ; copy the register values specified by d,x
                    lda       WorkWord_001,u ; load a from WorkWord_001,u
                    ldu       #0        ; set u to the constant 0
                    exg       x,u       ; exchange the register values specified by x,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    puls      u         ; restore u from the stack
                    leax      WorkBuffer_002,u ; form the address WorkBuffer_002,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       WorkWord_001,u ; load a from WorkWord_001,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcs       Branch_009 ; branch when carry reports an error or unsigned underflow; target Branch_009
                    leay      >Text_004,pc ; form the address >Text_004,pc in y
                    leax      WorkBuffer_002,u ; form the address WorkBuffer_002,u in x
Branch_010          lda       ,x+       ; load a from ,x+
                    bmi       Branch_011 ; branch when the result is negative; target Branch_011
                    cmpa      ,y+       ; compare a with ,y+ and set the condition codes
                    bne       Branch_012 ; branch when the values differ or the result is nonzero; target Branch_012
                    bra       Branch_010 ; continue execution at Branch_010
Branch_012          leax      WorkBuffer_002,u ; form the address WorkBuffer_002,u in x
                    leay      >Text_005,pc ; form the address >Text_005,pc in y
Branch_013          lda       ,x+       ; load a from ,x+
                    bmi       Branch_014 ; branch when the result is negative; target Branch_014
                    cmpa      ,y+       ; compare a with ,y+ and set the condition codes
                    bne       Branch_015 ; branch when the values differ or the result is nonzero; target Branch_015
                    bra       Branch_013 ; continue execution at Branch_013
Branch_015          bra       Branch_008 ; continue execution at Branch_008
Branch_009          cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      Branch_001 ; branch when the values differ or the result is nonzero; target Branch_001
                    lda       WorkWord_001,u ; load a from WorkWord_001,u
                    os9       I$Close   ; close path A
                    rts                 ; return to the caller
Branch_011          anda      #127      ; mask a using #127
                    cmpa      ,y+       ; compare a with ,y+ and set the condition codes
                    bne       Branch_012 ; branch when the values differ or the result is nonzero; target Branch_012
                    lda       ,y+       ; load a from ,y+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       Branch_012 ; branch when the values differ or the result is nonzero; target Branch_012
                    leax      WorkBuffer_002,u ; form the address WorkBuffer_002,u in x
                    leay      >Text_001,pc ; form the address >Text_001,pc in y
                    bra       Branch_016 ; continue execution at Branch_016
Branch_014          anda      #127      ; mask a using #127
                    cmpa      ,y+       ; compare a with ,y+ and set the condition codes
                    bne       Branch_015 ; branch when the values differ or the result is nonzero; target Branch_015
                    lda       #13       ; set a to the constant 13
                    cmpa      ,y+       ; compare a with ,y+ and set the condition codes
                    bne       Branch_015 ; branch when the values differ or the result is nonzero; target Branch_015
                    leax      WorkBuffer_002,u ; form the address WorkBuffer_002,u in x
                    leay      >Text_002,pc ; form the address >Text_002,pc in y
Branch_016          lda       ,y+       ; load a from ,y+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_017 ; branch when the values are equal or the result is zero; target Branch_017
                    sta       ,x+       ; store a at ,x+
                    bra       Branch_016 ; continue execution at Branch_016
Branch_017          lda       ,-x       ; load a from ,-x
                    ora       #128      ; set selected bits in a using #128
                    sta       ,x        ; store a at ,x
                    lda       WorkByte_004,u ; load a from WorkByte_004,u
                    ldb       #32       ; set b to the constant 32
                    mul                 ; multiply a by b and return the product in d
                    tfr       d,x       ; copy the register values specified by d,x
                    lda       WorkWord_001,u ; load a from WorkWord_001,u
                    ldb       #5        ; set b to the constant 5
                    pshs      u         ; save u on the stack
                    ldu       #0        ; set u to the constant 0
                    exg       x,u       ; exchange the register values specified by x,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    puls      u         ; restore u from the stack
                    leax      WorkBuffer_002,u ; form the address WorkBuffer_002,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       WorkWord_001,u ; load a from WorkWord_001,u
                    os9       I$Write   ; write Y bytes from X to path A
                    lbra      Branch_008 ; continue execution at Branch_008

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
