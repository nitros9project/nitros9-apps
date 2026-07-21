**********************************************************************
* BBS.who - OS-9 Level 2 BBS command
*
* Syntax: BBS.who
* Purpose: List callers currently online.
* Walks OS-9 process descriptors and extracts BBS session identities.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       BBS.who
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
WorkWord_001        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_002        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_001      rmb       200       ; reserve 200 byte(s) in the module workspace
WorkBuffer_002      rmb       200       ; reserve 200 byte(s) in the module workspace
WorkByte_006        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_003      rmb       911       ; reserve 911 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.who/ ; store an OS-9 high-bit-terminated string
Text_001            fcc       "Unknown User" ; store literal character data
                    fcb       $0D       ; store byte data
Text_002            fcc       "/dd/bbs/BBS.alias" ; store literal character data
                    fcb       $0D       ; store byte data
Text_003            fcc       "The following users are on-line" ; store literal character data
                    fcb       $0D       ; store byte data
Text_004            fcc       "-------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
start               clra                ; clear a to zero and set the condition codes
                    leax      >WorkBuffer_002,u ; form the address >WorkBuffer_002,u in x
                    ldb       #200      ; set b to the constant 200
Branch_001          sta       ,x+       ; store a at ,x+
                    decb                ; decrement b
                    bne       Branch_001 ; branch when the values differ or the result is nonzero; target Branch_001
                    clr       WorkByte_002,u ; clear WorkByte_002,u to zero and set the condition codes
                    leax      >Text_002,pc ; form the address >Text_002,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    sta       WorkByte_001,u ; store a at WorkByte_001,u
                    leax      >Text_003,pc ; form the address >Text_003,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Text_004,pc ; form the address >Text_004,pc in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
Branch_003          leax      >WorkByte_006,u ; form the address >WorkByte_006,u in x
                    lda       WorkByte_002,u ; load a from WorkByte_002,u
                    os9       F$GPrDsc  ; copy the requested process descriptor into X
                    bcs       Branch_004 ; branch when carry reports an error or unsigned underflow; target Branch_004
                    ldd       $08,x     ; load d from $08,x
                    bsr       Routine_001 ; call subroutine Routine_001
Branch_004          lda       WorkByte_002,u ; load a from WorkByte_002,u
                    inca                ; increment a
                    sta       WorkByte_002,u ; store a at WorkByte_002,u
                    cmpa      #255      ; compare a with #255 and set the condition codes
                    bcs       Branch_003 ; branch when carry reports an error or unsigned underflow; target Branch_003
                    lbra      Branch_005 ; continue execution at Branch_005
Routine_001         leax      >WorkBuffer_002,u ; form the address >WorkBuffer_002,u in x
Branch_006          cmpd      ,x        ; compare d with ,x and set the condition codes
                    beq       Branch_007 ; branch when the values are equal or the result is zero; target Branch_007
                    pshs      d         ; save d on the stack
                    ldd       ,x++      ; load d from ,x++
                    beq       Branch_008 ; branch when the values are equal or the result is zero; target Branch_008
                    puls      d         ; restore d from the stack
                    bra       Branch_006 ; continue execution at Branch_006
Branch_007          rts                 ; return to the caller
Branch_008          puls      d         ; restore d from the stack
                    std       -$02,x    ; store d at -$02,x
                    std       WorkWord_001,u ; store d at WorkWord_001,u
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    pshs      u         ; save u on the stack
                    ldu       #0        ; set u to the constant 0
                    ldx       #0        ; set x to the constant 0
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    puls      u         ; restore u from the stack
Branch_009          lda       WorkByte_001,u ; load a from WorkByte_001,u
                    leax      WorkBuffer_001,u ; form the address WorkBuffer_001,u in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    bcs       Branch_010 ; branch when carry reports an error or unsigned underflow; target Branch_010
Branch_011          lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    beq       Branch_012 ; branch when the values are equal or the result is zero; target Branch_012
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       Branch_011 ; branch when the values differ or the result is nonzero; target Branch_011
                    bra       Branch_009 ; continue execution at Branch_009
Branch_012          lda       #13       ; set a to the constant 13
                    sta       -$01,x    ; store a at -$01,x
                    lbsr      Routine_002 ; call subroutine Routine_002
                    cmpd      WorkWord_001,u ; compare d with WorkWord_001,u and set the condition codes
                    beq       Branch_013 ; branch when the values are equal or the result is zero; target Branch_013
                    bra       Branch_009 ; continue execution at Branch_009
Branch_010          leax      >Text_001,pc ; form the address >Text_001,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    rts                 ; return to the caller
Branch_013          leax      WorkBuffer_001,u ; form the address WorkBuffer_001,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    rts                 ; return to the caller
Branch_005          clrb                ; clear b to zero and set the condition codes
Branch_002          os9       F$Exit    ; terminate the process with status B
Routine_002         pshs      y         ; save y on the stack
Branch_014          lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      Branch_015 ; branch when the values are equal or the result is zero; target Branch_015
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_014 ; branch when carry reports an error or unsigned underflow; target Branch_014
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_014 ; branch when the unsigned value is higher; target Branch_014
                    leax      -$01,x    ; form the address -$01,x in x
Branch_016          lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_017 ; branch when carry reports an error or unsigned underflow; target Branch_017
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_017 ; branch when the unsigned value is higher; target Branch_017
                    bra       Branch_016 ; continue execution at Branch_016
Branch_017          pshs      x         ; save x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    clr       WorkByte_004,u ; clear WorkByte_004,u to zero and set the condition codes
                    clr       WorkByte_005,u ; clear WorkByte_005,u to zero and set the condition codes
                    ldd       #1        ; set d to the constant 1
                    std       WorkWord_002,u ; store d at WorkWord_002,u
Branch_018          lda       ,-x       ; load a from ,-x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_019 ; branch when carry reports an error or unsigned underflow; target Branch_019
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_019 ; branch when the unsigned value is higher; target Branch_019
                    suba      #48       ; subtract from a using #48
                    sta       WorkByte_003,u ; store a at WorkByte_003,u
                    ldd       #0        ; set d to the constant 0
Branch_020          tst       WorkByte_003,u ; set condition codes from WorkByte_003,u without changing it
                    beq       Branch_021 ; branch when the values are equal or the result is zero; target Branch_021
                    addd      WorkWord_002,u ; add to d using WorkWord_002,u
                    dec       WorkByte_003,u ; decrement the value at WorkByte_003,u
                    bra       Branch_020 ; continue execution at Branch_020
Branch_021          addd      WorkByte_004,u ; add to d using WorkByte_004,u
                    std       WorkByte_004,u ; store d at WorkByte_004,u
                    lda       #10       ; set a to the constant 10
                    sta       WorkByte_003,u ; store a at WorkByte_003,u
                    ldd       #0        ; set d to the constant 0
Branch_022          tst       WorkByte_003,u ; set condition codes from WorkByte_003,u without changing it
                    beq       Branch_023 ; branch when the values are equal or the result is zero; target Branch_023
                    addd      WorkWord_002,u ; add to d using WorkWord_002,u
                    dec       WorkByte_003,u ; decrement the value at WorkByte_003,u
                    bra       Branch_022 ; continue execution at Branch_022
Branch_023          std       WorkWord_002,u ; store d at WorkWord_002,u
                    bra       Branch_018 ; continue execution at Branch_018
Branch_019          ldd       WorkByte_004,u ; load d from WorkByte_004,u
                    puls      x         ; restore x from the stack
                    puls      pc,y      ; restore pc,y and return to the caller
                    fcb       $ED       ; store byte data
                    fcb       $43       ; store byte data
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
                    fcb       $47       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $43       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $29       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $E8       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $47       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $43       ; store byte data
                    fcb       $8D       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $47       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $43       ; store byte data
                    fcb       $8D       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $0A       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $47       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $43       ; store byte data
                    fcb       $8D       ; store byte data
                    fcb       $0E       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $47       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $43       ; store byte data
                    fcb       $8D       ; store byte data
                    fcb       $05       ; store byte data
                    fcb       $86       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $A7       ; store byte data
                    fcb       $84       ; store byte data
                    fcb       $39       ; store byte data
                    fcb       $A3       ; store byte data
                    fcb       $47       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $6C       ; store byte data
                    fcb       $84       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $F8       ; store byte data
                    fcb       $E3       ; store byte data
                    fcb       $47       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $43       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $39       ; store byte data
Branch_015          ldd       #0        ; set d to the constant 0
                    rts                 ; return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
