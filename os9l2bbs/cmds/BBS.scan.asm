**********************************************************************
* BBS.scan - OS-9 Level 2 BBS command
*
* Syntax: BBS.scan
* Purpose: Display compact headings from the current message index.
* Avoids loading complete message bodies unless selected elsewhere.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       BBS.scan
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
WorkWord_001        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_001      rmb       6         ; reserve 6 byte(s) in the module workspace
WorkBuffer_002      rmb       3         ; reserve 3 byte(s) in the module workspace
WorkByte_008        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_002        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_009        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_003      rmb       6         ; reserve 6 byte(s) in the module workspace
WorkByte_010        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_011        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_003        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_012        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_013        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_014        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_015        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_016        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_017        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_018        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_019        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_020        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_004      rmb       64        ; reserve 64 byte(s) in the module workspace
WorkBuffer_005      rmb       4         ; reserve 4 byte(s) in the module workspace
WorkBuffer_006      rmb       20        ; reserve 20 byte(s) in the module workspace
WorkBuffer_007      rmb       30        ; reserve 30 byte(s) in the module workspace
WorkByte_021        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_022        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_023        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_008      rmb       205       ; reserve 205 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.scan/ ; store an OS-9 high-bit-terminated string
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
Text_001            fcc       "High message is #" ; store literal character data
Data_001            fcb       $00       ; store byte data
                    fcb       $11       ; store byte data
Text_002            fcc       "Enter starting message #" ; store literal character data
                    fcb       $0D       ; store byte data
Text_003            fcc       ">" ; store literal character data
Text_004            fcc       "Msg #    User name              Date        Subject" ; store literal character data
                    fcb       $0D       ; store byte data
Text_005            fcc       "----------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
Text_006            fcc       "BBS.msg.inx" ; store literal character data
                    fcb       $0D       ; store byte data
Text_007            fcc       "                                       " ; store literal character data
Text_008            fcc       "          ******   DELETED   ******" ; store literal character data
                    fcb       $0D       ; store byte data
start               leax      >Text_006,pc ; form the address >Text_006,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    sta       WorkByte_001,u ; store a at WorkByte_001,u
                    leax      <WorkBuffer_004,u ; form the address <WorkBuffer_004,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    ldd       <WorkBuffer_004,u ; load d from <WorkBuffer_004,u
                    leax      WorkBuffer_001,u ; form the address WorkBuffer_001,u in x
                    lbsr      Routine_001 ; call subroutine Routine_001
                    leax      >Text_001,pc ; form the address >Text_001,pc in x
                    ldy       >Data_001,pc ; load y from >Data_001,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      WorkBuffer_001,u ; form the address WorkBuffer_001,u in x
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
                    leax      <WorkBuffer_003,u ; form the address <WorkBuffer_003,u in x
                    ldy       #6        ; set y to the constant 6
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    clr       <WorkByte_009,u ; clear <WorkByte_009,u to zero and set the condition codes
                    leax      <WorkBuffer_003,u ; form the address <WorkBuffer_003,u in x
                    lbsr      Routine_002 ; call subroutine Routine_002
                    cmpd      #1        ; compare d with #1 and set the condition codes
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    cmpd      <WorkBuffer_004,u ; compare d with <WorkBuffer_004,u and set the condition codes
                    lbhi      Branch_002 ; branch when the unsigned value is higher; target Branch_002
                    std       WorkBuffer_001,u ; store d at WorkBuffer_001,u
                    clr       <WorkByte_010,u ; clear <WorkByte_010,u to zero and set the condition codes
                    clr       <WorkByte_011,u ; clear <WorkByte_011,u to zero and set the condition codes
                    lda       #6        ; set a to the constant 6
                    sta       WorkByte_002,u ; store a at WorkByte_002,u
                    ldd       WorkBuffer_001,u ; load d from WorkBuffer_001,u
Branch_003          aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    rol       <WorkByte_011,u ; rotate left through carry the value at <WorkByte_011,u
                    dec       WorkByte_002,u ; decrement the value at WorkByte_002,u
                    bne       Branch_003 ; branch when the values differ or the result is nonzero; target Branch_003
                    std       <WorkWord_003,u ; store d at <WorkWord_003,u
                    ldx       <WorkByte_010,u ; load x from <WorkByte_010,u
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    pshs      u         ; save u on the stack
                    ldu       <WorkWord_003,u ; load u from <WorkWord_003,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    puls      u         ; restore u from the stack
                    leax      >Text_004,pc ; form the address >Text_004,pc in x
                    ldy       #80       ; set y to the constant 80
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      >Text_005,pc ; form the address >Text_005,pc in x
                    ldy       #80       ; set y to the constant 80
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
Branch_004          lda       WorkByte_001,u ; load a from WorkByte_001,u
                    ldy       #64       ; set y to the constant 64
                    leax      <WorkBuffer_005,u ; form the address <WorkBuffer_005,u in x
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    ldd       <WorkBuffer_005,u ; load d from <WorkBuffer_005,u
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    lbeq      Branch_005 ; branch when the values are equal or the result is zero; target Branch_005
                    ldd       WorkBuffer_001,u ; load d from WorkBuffer_001,u
                    leax      WorkBuffer_002,u ; form the address WorkBuffer_002,u in x
                    lbsr      Routine_001 ; call subroutine Routine_001
                    ldd       WorkBuffer_001,u ; load d from WorkBuffer_001,u
                    addd      #1        ; add to d using #1
                    std       WorkBuffer_001,u ; store d at WorkBuffer_001,u
                    leax      WorkBuffer_002,u ; form the address WorkBuffer_002,u in x
                    ldy       #5        ; set y to the constant 5
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      >Text_007,pc ; form the address >Text_007,pc in x
                    ldy       #4        ; set y to the constant 4
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      <WorkBuffer_006,u ; form the address <WorkBuffer_006,u in x
                    clr       WorkByte_004,u ; clear WorkByte_004,u to zero and set the condition codes
                    clr       WorkByte_005,u ; clear WorkByte_005,u to zero and set the condition codes
Branch_006          lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_007 ; branch when the values are equal or the result is zero; target Branch_007
                    inc       WorkByte_005,u ; increment the value at WorkByte_005,u
                    bra       Branch_006 ; continue execution at Branch_006
Branch_007          leax      <WorkBuffer_006,u ; form the address <WorkBuffer_006,u in x
                    ldy       WorkByte_004,u ; load y from WorkByte_004,u
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    ldd       #22       ; set d to the constant 22
                    subd      WorkByte_004,u ; subtract from d using WorkByte_004,u
                    tfr       d,y       ; copy the register values specified by d,y
                    leax      >Text_007,pc ; form the address >Text_007,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      WorkBuffer_002,u ; form the address WorkBuffer_002,u in x
                    ldb       >WorkByte_022,u ; load b from >WorkByte_022,u
                    clra                ; clear a to zero and set the condition codes
                    lbsr      Routine_001 ; call subroutine Routine_001
                    lda       <WorkByte_008,u ; load a from <WorkByte_008,u
                    sta       <WorkByte_012,u ; store a at <WorkByte_012,u
                    lda       <WorkWord_002,u ; load a from <WorkWord_002,u
                    sta       <WorkByte_013,u ; store a at <WorkByte_013,u
                    lda       #47       ; set a to the constant 47
                    sta       <WorkByte_014,u ; store a at <WorkByte_014,u
                    ldb       >WorkByte_023,u ; load b from >WorkByte_023,u
                    clra                ; clear a to zero and set the condition codes
                    leax      WorkBuffer_002,u ; form the address WorkBuffer_002,u in x
                    lbsr      Routine_001 ; call subroutine Routine_001
                    lda       <WorkByte_008,u ; load a from <WorkByte_008,u
                    sta       <WorkByte_015,u ; store a at <WorkByte_015,u
                    lda       <WorkWord_002,u ; load a from <WorkWord_002,u
                    sta       <WorkByte_016,u ; store a at <WorkByte_016,u
                    lda       #47       ; set a to the constant 47
                    sta       <WorkByte_017,u ; store a at <WorkByte_017,u
                    ldb       >WorkByte_021,u ; load b from >WorkByte_021,u
                    clra                ; clear a to zero and set the condition codes
                    leax      WorkBuffer_002,u ; form the address WorkBuffer_002,u in x
                    lbsr      Routine_001 ; call subroutine Routine_001
                    lda       <WorkByte_008,u ; load a from <WorkByte_008,u
                    sta       <WorkByte_018,u ; store a at <WorkByte_018,u
                    lda       <WorkWord_002,u ; load a from <WorkWord_002,u
                    sta       <WorkByte_019,u ; store a at <WorkByte_019,u
                    lda       #13       ; set a to the constant 13
                    sta       <WorkByte_020,u ; store a at <WorkByte_020,u
                    leax      <WorkByte_012,u ; form the address <WorkByte_012,u in x
                    ldy       #8        ; set y to the constant 8
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    ldy       #5        ; set y to the constant 5
                    leax      >Text_007,pc ; form the address >Text_007,pc in x
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      >WorkBuffer_007,u ; form the address >WorkBuffer_007,u in x
                    ldy       #30       ; set y to the constant 30
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    lbra      Branch_004 ; continue execution at Branch_004
Branch_005          ldd       WorkBuffer_001,u ; load d from WorkBuffer_001,u
                    addd      #1        ; add to d using #1
                    std       WorkBuffer_001,u ; store d at WorkBuffer_001,u
                    leax      >Text_008,pc ; form the address >Text_008,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbra      Branch_004 ; continue execution at Branch_004
Branch_002          clrb                ; clear b to zero and set the condition codes
Branch_001          os9       F$Exit    ; terminate the process with status B
Routine_002         pshs      y         ; save y on the stack
Branch_008          lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      Branch_009 ; branch when the values are equal or the result is zero; target Branch_009
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_008 ; branch when carry reports an error or unsigned underflow; target Branch_008
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_008 ; branch when the unsigned value is higher; target Branch_008
                    leax      -$01,x    ; form the address -$01,x in x
Branch_010          lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_011 ; branch when carry reports an error or unsigned underflow; target Branch_011
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_011 ; branch when the unsigned value is higher; target Branch_011
                    bra       Branch_010 ; continue execution at Branch_010
Branch_011          pshs      x         ; save x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    clr       WorkByte_006,u ; clear WorkByte_006,u to zero and set the condition codes
                    clr       WorkByte_007,u ; clear WorkByte_007,u to zero and set the condition codes
                    ldd       #1        ; set d to the constant 1
                    std       WorkWord_001,u ; store d at WorkWord_001,u
Branch_012          lda       ,-x       ; load a from ,-x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_013 ; branch when carry reports an error or unsigned underflow; target Branch_013
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_013 ; branch when the unsigned value is higher; target Branch_013
                    suba      #48       ; subtract from a using #48
                    sta       WorkByte_003,u ; store a at WorkByte_003,u
                    ldd       #0        ; set d to the constant 0
Branch_014          tst       WorkByte_003,u ; set condition codes from WorkByte_003,u without changing it
                    beq       Branch_015 ; branch when the values are equal or the result is zero; target Branch_015
                    addd      WorkWord_001,u ; add to d using WorkWord_001,u
                    dec       WorkByte_003,u ; decrement the value at WorkByte_003,u
                    bra       Branch_014 ; continue execution at Branch_014
Branch_015          addd      WorkByte_006,u ; add to d using WorkByte_006,u
                    std       WorkByte_006,u ; store d at WorkByte_006,u
                    lda       #10       ; set a to the constant 10
                    sta       WorkByte_003,u ; store a at WorkByte_003,u
                    ldd       #0        ; set d to the constant 0
Branch_016          tst       WorkByte_003,u ; set condition codes from WorkByte_003,u without changing it
                    beq       Branch_017 ; branch when the values are equal or the result is zero; target Branch_017
                    addd      WorkWord_001,u ; add to d using WorkWord_001,u
                    dec       WorkByte_003,u ; decrement the value at WorkByte_003,u
                    bra       Branch_016 ; continue execution at Branch_016
Branch_017          std       WorkWord_001,u ; store d at WorkWord_001,u
                    bra       Branch_012 ; continue execution at Branch_012
Branch_013          ldd       WorkByte_006,u ; load d from WorkByte_006,u
                    puls      x         ; restore x from the stack
                    puls      pc,y      ; restore pc,y and return to the caller
Routine_001         pshs      x         ; save x on the stack
                    std       WorkByte_006,u ; store d at WorkByte_006,u
                    lda       #48       ; set a to the constant 48
                    sta       ,x        ; store a at ,x
                    sta       $01,x     ; store a at $01,x
                    sta       $02,x     ; store a at $02,x
                    sta       $03,x     ; store a at $03,x
                    sta       $04,x     ; store a at $04,x
                    ldd       #10000    ; set d to the constant 10000
                    std       WorkWord_001,u ; store d at WorkWord_001,u
                    ldd       WorkByte_006,u ; load d from WorkByte_006,u
                    lbsr      Routine_003 ; call subroutine Routine_003
                    ldd       #1000     ; set d to the constant 1000
                    std       WorkWord_001,u ; store d at WorkWord_001,u
                    ldd       WorkByte_006,u ; load d from WorkByte_006,u
                    bsr       Routine_003 ; call subroutine Routine_003
                    ldd       #100      ; set d to the constant 100
                    std       WorkWord_001,u ; store d at WorkWord_001,u
                    ldd       WorkByte_006,u ; load d from WorkByte_006,u
                    bsr       Routine_003 ; call subroutine Routine_003
                    ldd       #10       ; set d to the constant 10
                    std       WorkWord_001,u ; store d at WorkWord_001,u
                    ldd       WorkByte_006,u ; load d from WorkByte_006,u
                    bsr       Routine_003 ; call subroutine Routine_003
                    ldd       #1        ; set d to the constant 1
                    std       WorkWord_001,u ; store d at WorkWord_001,u
                    ldd       WorkByte_006,u ; load d from WorkByte_006,u
                    bsr       Routine_003 ; call subroutine Routine_003
                    lda       #13       ; set a to the constant 13
                    sta       ,x        ; store a at ,x
                    puls      x         ; restore x from the stack
                    ldb       #32       ; set b to the constant 32
Branch_018          lda       ,x        ; load a from ,x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bne       Branch_019 ; branch when the values differ or the result is nonzero; target Branch_019
                    stb       ,x+       ; store b at ,x+
                    bra       Branch_018 ; continue execution at Branch_018
Branch_019          lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_020 ; branch when carry reports an error or unsigned underflow; target Branch_020
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_020 ; branch when the unsigned value is higher; target Branch_020
                    bra       Branch_019 ; continue execution at Branch_019
Branch_020          leax      -$01,x    ; form the address -$01,x in x
                    rts                 ; return to the caller
Routine_003         subd      WorkWord_001,u ; subtract from d using WorkWord_001,u
                    bcs       Branch_021 ; branch when carry reports an error or unsigned underflow; target Branch_021
                    inc       ,x        ; increment the value at ,x
                    bra       Routine_003 ; continue execution at Routine_003
Branch_021          addd      WorkWord_001,u ; add to d using WorkWord_001,u
                    std       WorkByte_006,u ; store d at WorkByte_006,u
                    leax      $01,x     ; form the address $01,x in x
                    rts                 ; return to the caller
Branch_009          ldd       #-1       ; set d to the constant -1
                    puls      pc,y      ; restore pc,y and return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
