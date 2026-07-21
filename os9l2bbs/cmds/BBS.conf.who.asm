**********************************************************************
* BBS.conf.who - OS-9 Level 2 BBS command
*
* Syntax: BBS.conf.who
* Purpose: List users currently registered in the shared conference module.
* Reads Conf.dat without joining the conference.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       BBS.conf.who
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
WorkWord_001        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_003        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_004        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_002        rmb       2         ; reserve 2 byte(s) in the module workspace
dataddr             rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_003        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_001      rmb       200       ; reserve 200 byte(s) in the module workspace
WorkByte_005        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_002      rmb       599       ; reserve 599 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.conf.who/ ; store an OS-9 high-bit-terminated string
confdat             fcc       "Conf.dat" ; store literal character data
                    fcb       $0D       ; store byte data
bbsalias            fcc       "/dd/bbs/BBS.alias" ; store literal character data
                    fcb       $0D       ; store byte data
noone               fcc       "No one is in conference" ; store literal character data
                    fcb       $0D       ; store byte data
these               fcc       "These people are in conference" ; store literal character data
                    fcb       $0D       ; store byte data
line                fcc       "------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data

start               leax      >confdat,pc ; form the address >confdat,pc in x
                    lda       #65       ; set a to the constant 65
                    pshs      u         ; save u on the stack
                    os9       F$Link    ; link to Conf.dat
                    lbcs      Branch_001 ; branch if conference empty
                    tfr       u,d       ; move module offset to D
                    puls      u         ; restore u from the stack
                    std       dataddr,u ; save module offset
                    sty       WorkWord_003,u ; store y at WorkWord_003,u
                    leax      >these,pc ; form the address >these,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >line,pc  ; form the address >line,pc in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    ldx       WorkWord_003,u ; load x from WorkWord_003,u
Branch_002          ldd       ,x++      ; load d from ,x++
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    beq       Branch_003 ; branch when the values are equal or the result is zero; target Branch_003
                    leax      $01,x     ; form the address $01,x in x
                    cmpd      #0        ; compare d with #0 and set the condition codes
                    beq       Branch_002 ; branch when the values are equal or the result is zero; target Branch_002
                    pshs      x         ; save x on the stack
                    subd      #1        ; subtract from d using #1
                    lbsr      Routine_001 ; call subroutine Routine_001
                    puls      x         ; restore x from the stack
                    bra       Branch_002 ; continue execution at Branch_002
Branch_003          clrb                ; clear b to zero and set the condition codes
                    pshs      u         ; save u on the stack
                    ldu       dataddr,u ; load u from dataddr,u
                    os9       F$UnLink  ; release the linked module at U
                    puls      u         ; restore u from the stack
                    clrb                ; clear b to zero and set the condition codes
                    os9       F$Exit    ; terminate the process with status B
Branch_001          leax      >noone,pc ; form the address >noone,pc in x
                    lda       #1        ; set a to the constant 1
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    clrb                ; clear b to zero and set the condition codes
                    os9       F$Exit    ; terminate the process with status B
Routine_001         std       WorkWord_001,u ; store d at WorkWord_001,u
                    leax      >bbsalias,pc ; form the address >bbsalias,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_004 ; branch when carry reports an error or unsigned underflow; target Branch_004
                    sta       WorkByte_001,u ; store a at WorkByte_001,u
Branch_005          leax      WorkBuffer_001,u ; form the address WorkBuffer_001,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lbcs      Branch_004 ; branch when carry reports an error or unsigned underflow; target Branch_004
Branch_006          lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    bne       Branch_006 ; branch when the values differ or the result is nonzero; target Branch_006
                    lbsr      Routine_002 ; call subroutine Routine_002
                    cmpd      WorkWord_001,u ; compare d with WorkWord_001,u and set the condition codes
                    bne       Branch_005 ; branch when the values differ or the result is nonzero; target Branch_005
                    leax      WorkBuffer_001,u ; form the address WorkBuffer_001,u in x
                    leay      >WorkByte_005,u ; form the address >WorkByte_005,u in y
Branch_007          lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    beq       Branch_008 ; branch when the values are equal or the result is zero; target Branch_008
                    sta       ,y+       ; store a at ,y+
                    bra       Branch_007 ; continue execution at Branch_007
Branch_008          lda       #13       ; set a to the constant 13
                    sta       ,y        ; store a at ,y
                    leax      >WorkByte_005,u ; form the address >WorkByte_005,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    rts                 ; return to the caller
Routine_002         pshs      y         ; save y on the stack
Branch_009          lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      Branch_010 ; branch when the values are equal or the result is zero; target Branch_010
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_009 ; branch when carry reports an error or unsigned underflow; target Branch_009
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_009 ; branch when the unsigned value is higher; target Branch_009
                    leax      -$01,x    ; form the address -$01,x in x
Branch_011          lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_012 ; branch when carry reports an error or unsigned underflow; target Branch_012
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_012 ; branch when the unsigned value is higher; target Branch_012
                    bra       Branch_011 ; continue execution at Branch_011
Branch_012          pshs      x         ; save x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    clr       WorkByte_003,u ; clear WorkByte_003,u to zero and set the condition codes
                    clr       WorkByte_004,u ; clear WorkByte_004,u to zero and set the condition codes
                    ldd       #1        ; set d to the constant 1
                    std       WorkWord_002,u ; store d at WorkWord_002,u
Branch_013          lda       ,-x       ; load a from ,-x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_014 ; branch when carry reports an error or unsigned underflow; target Branch_014
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_014 ; branch when the unsigned value is higher; target Branch_014
                    suba      #48       ; subtract from a using #48
                    sta       WorkByte_002,u ; store a at WorkByte_002,u
                    ldd       #0        ; set d to the constant 0
Branch_015          tst       WorkByte_002,u ; set condition codes from WorkByte_002,u without changing it
                    beq       Branch_016 ; branch when the values are equal or the result is zero; target Branch_016
                    addd      WorkWord_002,u ; add to d using WorkWord_002,u
                    dec       WorkByte_002,u ; decrement the value at WorkByte_002,u
                    bra       Branch_015 ; continue execution at Branch_015
Branch_016          addd      WorkByte_003,u ; add to d using WorkByte_003,u
                    std       WorkByte_003,u ; store d at WorkByte_003,u
                    lda       #10       ; set a to the constant 10
                    sta       WorkByte_002,u ; store a at WorkByte_002,u
                    ldd       #0        ; set d to the constant 0
Branch_017          tst       WorkByte_002,u ; set condition codes from WorkByte_002,u without changing it
                    beq       Branch_018 ; branch when the values are equal or the result is zero; target Branch_018
                    addd      WorkWord_002,u ; add to d using WorkWord_002,u
                    dec       WorkByte_002,u ; decrement the value at WorkByte_002,u
                    bra       Branch_017 ; continue execution at Branch_017
Branch_018          std       WorkWord_002,u ; store d at WorkWord_002,u
                    bra       Branch_013 ; continue execution at Branch_013
Branch_014          ldd       WorkByte_003,u ; load d from WorkByte_003,u
                    puls      x         ; restore x from the stack
                    puls      pc,y      ; restore pc,y and return to the caller

unused              std       WorkByte_003,u ; store d at WorkByte_003,u
                    lda       #48       ; set a to the constant 48
                    sta       ,x        ; store a at ,x
                    sta       $01,x     ; store a at $01,x
                    sta       $02,x     ; store a at $02,x
                    sta       $03,x     ; store a at $03,x
                    sta       $04,x     ; store a at $04,x
                    ldd       #10000    ; set d to the constant 10000
                    std       WorkWord_002,u ; store d at WorkWord_002,u
                    ldd       WorkByte_003,u ; load d from WorkByte_003,u
                    lbsr      Routine_003 ; call subroutine Routine_003
                    ldd       #1000     ; set d to the constant 1000
                    std       WorkWord_002,u ; store d at WorkWord_002,u
                    ldd       WorkByte_003,u ; load d from WorkByte_003,u
                    bsr       Routine_003 ; call subroutine Routine_003
                    ldd       #100      ; set d to the constant 100
                    std       WorkWord_002,u ; store d at WorkWord_002,u
                    ldd       WorkByte_003,u ; load d from WorkByte_003,u
                    bsr       Routine_003 ; call subroutine Routine_003
                    ldd       #10       ; set d to the constant 10
                    std       WorkWord_002,u ; store d at WorkWord_002,u
                    ldd       WorkByte_003,u ; load d from WorkByte_003,u
                    bsr       Routine_003 ; call subroutine Routine_003
                    ldd       #1        ; set d to the constant 1
                    std       WorkWord_002,u ; store d at WorkWord_002,u
                    ldd       WorkByte_003,u ; load d from WorkByte_003,u
                    bsr       Routine_003 ; call subroutine Routine_003
                    lda       #13       ; set a to the constant 13
                    sta       ,x        ; store a at ,x
                    rts                 ; return to the caller
Routine_003         subd      WorkWord_002,u ; subtract from d using WorkWord_002,u
                    bcs       Branch_019 ; branch when carry reports an error or unsigned underflow; target Branch_019
                    inc       ,x        ; increment the value at ,x
                    bra       Routine_003 ; continue execution at Routine_003
Branch_019          addd      WorkWord_002,u ; add to d using WorkWord_002,u
                    std       WorkByte_003,u ; store d at WorkByte_003,u
                    leax      $01,x     ; form the address $01,x in x
                    rts                 ; return to the caller
Branch_010          lda       #1        ; set a to the constant 1
                    bra       Branch_004 ; continue execution at Branch_004
                    fcb       $5F       ; store byte data
Branch_004          os9       F$Exit    ; terminate the process with status B

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
