**********************************************************************
* BBS.page - OS-9 Level 2 BBS command
*
* Syntax: BBS.page
* Purpose: Locate an online caller or sysop and send a paging signal.
* Uses the OS-9 process descriptors to identify the target process.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       BBS.page
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

WorkBuffer_001      rmb       8         ; reserve 8 byte(s) in the module workspace
WorkBuffer_002      rmb       41        ; reserve 41 byte(s) in the module workspace
WorkBuffer_003      rmb       463       ; reserve 463 byte(s) in the module workspace
WorkByte_001        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_002        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_003        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_004        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_001        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_002        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_003        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_004        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_005        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_006        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_005        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_006        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_004      rmb       64        ; reserve 64 byte(s) in the module workspace
WorkBuffer_005      rmb       64        ; reserve 64 byte(s) in the module workspace
WorkByte_007        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_006      rmb       64        ; reserve 64 byte(s) in the module workspace
WorkBuffer_007      rmb       200       ; reserve 200 byte(s) in the module workspace
WorkBuffer_008      rmb       200       ; reserve 200 byte(s) in the module workspace
WorkByte_008        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_009      rmb       599       ; reserve 599 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.page/ ; store an OS-9 high-bit-terminated string
Data_001            fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
Text_001            fcc       "/dd/bbs/BBS.alias" ; store literal character data
                    fcb       $0D       ; store byte data
Text_002            fcc       "User not currently on-line!" ; store literal character data
                    fcb       $0D       ; store byte data
Text_003            fcc       "User not in the alias list!" ; store literal character data
                    fcb       $0D       ; store byte data
Text_004            fcc       "User name to page:" ; store literal character data
Text_005            fcc       "Sending message now..." ; store literal character data
                    fcb       $0D       ; store byte data
Text_006            fcc       "Message recieved by user" ; store literal character data
                    fcb       $0D       ; store byte data
Text_007            fcc       "Enter message to send:" ; store literal character data
Data_002            fcb       $07       ; store byte data
                    fcb       $07       ; store byte data
                    fcb       $07       ; store byte data
                    fcb       $07       ; store byte data
                    fcc       "Page from " ; store literal character data
start               leax      >Text_004,pc ; form the address >Text_004,pc in x
                    ldy       #18       ; set y to the constant 18
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      >WorkBuffer_008,u ; form the address >WorkBuffer_008,u in x
                    ldy       #200      ; set y to the constant 200
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      >Text_001,pc ; form the address >Text_001,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    sta       >WorkByte_001,u ; store a at >WorkByte_001,u
Branch_002          leax      >WorkBuffer_007,u ; form the address >WorkBuffer_007,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       >WorkByte_001,u ; load a from >WorkByte_001,u
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lbcs      Branch_003 ; branch when carry reports an error or unsigned underflow; target Branch_003
                    leay      >WorkBuffer_008,u ; form the address >WorkBuffer_008,u in y
Branch_004          lda       ,x        ; load a from ,x
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    beq       Branch_005 ; branch when the values are equal or the result is zero; target Branch_005
                    anda      #223      ; mask a using #223
                    sta       ,x+       ; store a at ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       Branch_004 ; branch when the values differ or the result is nonzero; target Branch_004
Branch_005          leax      >WorkBuffer_007,u ; form the address >WorkBuffer_007,u in x
                    leay      >WorkBuffer_008,u ; form the address >WorkBuffer_008,u in y
Branch_006          lda       ,y+       ; load a from ,y+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_007 ; branch when the values are equal or the result is zero; target Branch_007
                    anda      #223      ; mask a using #223
                    cmpa      ,x+       ; compare a with ,x+ and set the condition codes
                    bne       Branch_002 ; branch when the values differ or the result is nonzero; target Branch_002
                    bra       Branch_006 ; continue execution at Branch_006
Branch_003          leax      >Text_003,pc ; form the address >Text_003,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbra      Branch_008 ; continue execution at Branch_008
Branch_007          lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    bne       Branch_002 ; branch when the values differ or the result is nonzero; target Branch_002
                    lbsr      Routine_001 ; call subroutine Routine_001
                    std       >WorkWord_004,u ; store d at >WorkWord_004,u
                    lda       >WorkByte_001,u ; load a from >WorkByte_001,u
                    pshs      u         ; save u on the stack
                    ldu       #0        ; set u to the constant 0
                    ldx       #0        ; set x to the constant 0
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    os9       F$ID      ; retrieve the current process and user IDs
                    sty       >WorkWord_006,u ; store y at >WorkWord_006,u
Branch_009          leax      >WorkByte_008,u ; form the address >WorkByte_008,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       >WorkByte_001,u ; load a from >WorkByte_001,u
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
Branch_010          lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    bne       Branch_010 ; branch when the values differ or the result is nonzero; target Branch_010
                    lda       #13       ; set a to the constant 13
                    sta       -$01,x    ; store a at -$01,x
                    lbsr      Routine_001 ; call subroutine Routine_001
                    cmpd      >WorkWord_006,u ; compare d with >WorkWord_006,u and set the condition codes
                    bne       Branch_009 ; branch when the values differ or the result is nonzero; target Branch_009
                    clr       >WorkByte_003,u ; clear >WorkByte_003,u to zero and set the condition codes
Branch_011          lda       >WorkByte_003,u ; load a from >WorkByte_003,u
                    inca                ; increment a
                    sta       >WorkByte_003,u ; store a at >WorkByte_003,u
                    beq       Branch_012 ; branch when the values are equal or the result is zero; target Branch_012
                    leax      WorkBuffer_001,u ; form the address WorkBuffer_001,u in x
                    os9       F$GPrDsc  ; copy the requested process descriptor into X
                    bcs       Branch_011 ; branch when carry reports an error or unsigned underflow; target Branch_011
                    ldd       WorkBuffer_002,u ; load d from WorkBuffer_002,u
                    cmpd      >WorkWord_004,u ; compare d with >WorkWord_004,u and set the condition codes
                    bne       Branch_011 ; branch when the values differ or the result is nonzero; target Branch_011
                    bra       Branch_013 ; continue execution at Branch_013
Branch_012          leax      >Text_002,pc ; form the address >Text_002,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbra      Branch_008 ; continue execution at Branch_008
Branch_013          lbsr      Code_001  ; call subroutine Code_001
                    leax      >Text_007,pc ; form the address >Text_007,pc in x
                    ldy       #22       ; set y to the constant 22
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >WorkBuffer_007,u ; form the address >WorkBuffer_007,u in x
                    ldy       #200      ; set y to the constant 200
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      >Text_005,pc ; form the address >Text_005,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       #47       ; set a to the constant 47
                    sta       >WorkByte_007,u ; store a at >WorkByte_007,u
                    leax      >WorkByte_007,u ; form the address >WorkByte_007,u in x
                    lda       #2        ; set a to the constant 2
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    sta       >WorkByte_002,u ; store a at >WorkByte_002,u
                    leax      >Data_002,pc ; form the address >Data_002,pc in x
                    ldy       #14       ; set y to the constant 14
                    lda       >WorkByte_002,u ; load a from >WorkByte_002,u
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >WorkByte_008,u ; form the address >WorkByte_008,u in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >WorkBuffer_007,u ; form the address >WorkBuffer_007,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       >WorkByte_002,u ; load a from >WorkByte_002,u
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      >Text_006,pc ; form the address >Text_006,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbra      Branch_008 ; continue execution at Branch_008
Code_001            leax      >Data_001,pc ; form the address >Data_001,pc in x
                    tfr       x,d       ; copy the register values specified by x,d
                    ldx       #76       ; set x to the constant 76
                    ldy       #2        ; set y to the constant 2
                    pshs      u         ; save u on the stack
                    leau      >WorkBuffer_004,u ; form the workspace or data address >WorkBuffer_004,u in u
                    os9       F$CpyMem  ; copy Y bytes between process address spaces
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    puls      u         ; restore u from the stack
                    leax      >Data_001,pc ; form the address >Data_001,pc in x
                    tfr       x,d       ; copy the register values specified by x,d
                    ldx       >WorkBuffer_004,u ; load x from >WorkBuffer_004,u
                    ldy       #64       ; set y to the constant 64
                    pshs      u         ; save u on the stack
                    leau      >WorkBuffer_004,u ; form the workspace or data address >WorkBuffer_004,u in u
                    os9       F$CpyMem  ; copy Y bytes between process address spaces
                    puls      u         ; restore u from the stack
                    leax      >WorkBuffer_004,u ; form the address >WorkBuffer_004,u in x
                    tfr       x,d       ; copy the register values specified by x,d
                    ldx       #136      ; set x to the constant 136
                    ldy       #2        ; set y to the constant 2
                    pshs      u         ; save u on the stack
                    leau      >WorkWord_001,u ; form the workspace or data address >WorkWord_001,u in u
                    os9       F$CpyMem  ; copy Y bytes between process address spaces
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    puls      u         ; restore u from the stack
                    leax      >WorkBuffer_004,u ; form the address >WorkBuffer_004,u in x
                    tfr       x,d       ; copy the register values specified by x,d
                    ldx       >WorkWord_001,u ; load x from >WorkWord_001,u
                    ldy       #64       ; set y to the constant 64
                    pshs      u         ; save u on the stack
                    leau      >WorkBuffer_005,u ; form the workspace or data address >WorkBuffer_005,u in u
                    os9       F$CpyMem  ; copy Y bytes between process address spaces
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    puls      u         ; restore u from the stack
                    ldb       <WorkBuffer_003,u ; load b from <WorkBuffer_003,u
                    lsrb                ; shift b right logically
                    lsrb                ; shift b right logically
                    leax      >WorkBuffer_005,u ; form the address >WorkBuffer_005,u in x
                    lda       b,x       ; load a from b,x
                    pshs      a         ; save a on the stack
                    ldb       <WorkBuffer_003,u ; load b from <WorkBuffer_003,u
                    andb      #3        ; mask b using #3
                    lda       #64       ; set a to the constant 64
                    mul                 ; multiply a by b and return the product in d
                    puls      a         ; restore a from the stack
                    addb      #3        ; add to b using #3
                    tfr       d,x       ; copy the register values specified by d,x
                    leay      >WorkBuffer_004,u ; form the address >WorkBuffer_004,u in y
                    tfr       y,d       ; copy the register values specified by y,d
                    ldy       #2        ; set y to the constant 2
                    pshs      u         ; save u on the stack
                    leau      >WorkWord_002,u ; form the workspace or data address >WorkWord_002,u in u
                    os9       F$CpyMem  ; copy Y bytes between process address spaces
                    puls      u         ; restore u from the stack
                    ldx       >WorkWord_002,u ; load x from >WorkWord_002,u
                    leax      $04,x     ; form the address $04,x in x
                    leay      >WorkBuffer_004,u ; form the address >WorkBuffer_004,u in y
                    tfr       y,d       ; copy the register values specified by y,d
                    ldy       #2        ; set y to the constant 2
                    pshs      u         ; save u on the stack
                    leau      >WorkWord_002,u ; form the workspace or data address >WorkWord_002,u in u
                    os9       F$CpyMem  ; copy Y bytes between process address spaces
                    puls      u         ; restore u from the stack
                    leax      >WorkBuffer_004,u ; form the address >WorkBuffer_004,u in x
                    tfr       x,d       ; copy the register values specified by x,d
                    ldx       >WorkWord_002,u ; load x from >WorkWord_002,u
                    leax      $04,x     ; form the address $04,x in x
                    ldy       #2        ; set y to the constant 2
                    pshs      u         ; save u on the stack
                    leau      >WorkWord_003,u ; form the workspace or data address >WorkWord_003,u in u
                    os9       F$CpyMem  ; copy Y bytes between process address spaces
                    puls      u         ; restore u from the stack
                    ldx       >WorkWord_002,u ; load x from >WorkWord_002,u
                    ldd       >WorkWord_003,u ; load d from >WorkWord_003,u
                    leax      d,x       ; form the address d,x in x
                    leay      >WorkBuffer_004,u ; form the address >WorkBuffer_004,u in y
                    tfr       y,d       ; copy the register values specified by y,d
                    ldy       #64       ; set y to the constant 64
                    pshs      u         ; save u on the stack
                    leau      >WorkBuffer_006,u ; form the workspace or data address >WorkBuffer_006,u in u
                    os9       F$CpyMem  ; copy Y bytes between process address spaces
                    puls      u         ; restore u from the stack
                    leax      >WorkBuffer_006,u ; form the address >WorkBuffer_006,u in x
Branch_014          lda       ,x+       ; load a from ,x+
                    bpl       Branch_014 ; branch when the result is nonnegative; target Branch_014
                    anda      #127      ; mask a using #127
                    sta       -$01,x    ; store a at -$01,x
                    lda       #13       ; set a to the constant 13
                    sta       ,x        ; store a at ,x
                    rts                 ; return to the caller
Branch_008          clrb                ; clear b to zero and set the condition codes
Branch_001          os9       F$Exit    ; terminate the process with status B
Routine_001         pshs      y         ; save y on the stack
Branch_015          lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      Branch_016 ; branch when the values are equal or the result is zero; target Branch_016
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_015 ; branch when carry reports an error or unsigned underflow; target Branch_015
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_015 ; branch when the unsigned value is higher; target Branch_015
                    leax      -$01,x    ; form the address -$01,x in x
Branch_017          lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_018 ; branch when carry reports an error or unsigned underflow; target Branch_018
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_018 ; branch when the unsigned value is higher; target Branch_018
                    bra       Branch_017 ; continue execution at Branch_017
Branch_018          pshs      x         ; save x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    clr       >WorkByte_005,u ; clear >WorkByte_005,u to zero and set the condition codes
                    clr       >WorkByte_006,u ; clear >WorkByte_006,u to zero and set the condition codes
                    ldd       #1        ; set d to the constant 1
                    std       >WorkWord_005,u ; store d at >WorkWord_005,u
Branch_019          lda       ,-x       ; load a from ,-x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_020 ; branch when carry reports an error or unsigned underflow; target Branch_020
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_020 ; branch when the unsigned value is higher; target Branch_020
                    suba      #48       ; subtract from a using #48
                    sta       >WorkByte_004,u ; store a at >WorkByte_004,u
                    ldd       #0        ; set d to the constant 0
Branch_021          tst       >WorkByte_004,u ; set condition codes from >WorkByte_004,u without changing it
                    beq       Branch_022 ; branch when the values are equal or the result is zero; target Branch_022
                    addd      >WorkWord_005,u ; add to d using >WorkWord_005,u
                    dec       >WorkByte_004,u ; decrement the value at >WorkByte_004,u
                    bra       Branch_021 ; continue execution at Branch_021
Branch_022          addd      >WorkByte_005,u ; add to d using >WorkByte_005,u
                    std       >WorkByte_005,u ; store d at >WorkByte_005,u
                    lda       #10       ; set a to the constant 10
                    sta       >WorkByte_004,u ; store a at >WorkByte_004,u
                    ldd       #0        ; set d to the constant 0
Branch_023          tst       >WorkByte_004,u ; set condition codes from >WorkByte_004,u without changing it
                    beq       Branch_024 ; branch when the values are equal or the result is zero; target Branch_024
                    addd      >WorkWord_005,u ; add to d using >WorkWord_005,u
                    dec       >WorkByte_004,u ; decrement the value at >WorkByte_004,u
                    bra       Branch_023 ; continue execution at Branch_023
Branch_024          std       >WorkWord_005,u ; store d at >WorkWord_005,u
                    bra       Branch_019 ; continue execution at Branch_019
Branch_020          ldd       >WorkByte_005,u ; load d from >WorkByte_005,u
                    puls      x         ; restore x from the stack
                    puls      pc,y      ; restore pc,y and return to the caller
                    fcb       $ED       ; store byte data
                    fcb       $C9       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $0C       ; store byte data
                    fcb       $86       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $A7       ; store byte data
                    fcb       $84       ; store byte data
                    fcb       $A7       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $A7       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $A7       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $A7       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $C9       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $0E       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $C9       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $0C       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $39       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $E8       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $C9       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $0E       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $C9       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $0C       ; store byte data
                    fcb       $8D       ; store byte data
                    fcb       $2C       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $C9       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $0E       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $C9       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $0C       ; store byte data
                    fcb       $8D       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $0A       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $C9       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $0E       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $C9       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $0C       ; store byte data
                    fcb       $8D       ; store byte data
                    fcb       $12       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $C9       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $0E       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $C9       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $0C       ; store byte data
                    fcb       $8D       ; store byte data
                    fcb       $05       ; store byte data
                    fcb       $86       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $A7       ; store byte data
                    fcb       $84       ; store byte data
                    fcb       $39       ; store byte data
                    fcb       $A3       ; store byte data
                    fcb       $C9       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $0E       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $6C       ; store byte data
                    fcb       $84       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $F6       ; store byte data
                    fcb       $E3       ; store byte data
                    fcb       $C9       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $0E       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $C9       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $0C       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $39       ; store byte data
Branch_016          ldb       #1        ; set b to the constant 1
                    lbra      Branch_001 ; continue execution at Branch_001

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
