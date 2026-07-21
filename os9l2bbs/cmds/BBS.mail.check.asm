**********************************************************************
* BBS.mail.check - OS-9 Level 2 BBS command
*
* Syntax: BBS.mail.check
* Purpose: Report whether the authenticated user has unread private mail.
* Scans BBS.mail.inx using the current OS-9 user identity.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       BBS.mail.check
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

WorkBuffer_001      rmb       3         ; reserve 3 byte(s) in the module workspace
WorkByte_001        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_001        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_002        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_002      rmb       3         ; reserve 3 byte(s) in the module workspace
WorkByte_003        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_004        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_002        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_003      rmb       34        ; reserve 34 byte(s) in the module workspace
WorkBuffer_004      rmb       64        ; reserve 64 byte(s) in the module workspace
WorkBuffer_005      rmb       160       ; reserve 160 byte(s) in the module workspace
WorkBuffer_006      rmb       60        ; reserve 60 byte(s) in the module workspace
WorkWord_003        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_005        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_007      rmb       201       ; reserve 201 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.mail.check/ ; store an OS-9 high-bit-terminated string
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
Text_001            fcc       "BBS.mail.inx" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcc       "BBS.mail" ; store literal character data
                    fcb       $0D       ; store byte data
Text_002            fcc       "/dd/bbs/BBS.alias" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
Data_001            fcb       $0A       ; store byte data
                    fcc       "Checking mailbox..." ; store literal character data
                    fcb       $0D       ; store byte data
Data_002            fcb       $0A       ; store byte data
                    fcc       "All previously sent mail has been read." ; store literal character data
                    fcb       $0D       ; store byte data
Text_003            fcc       "Mail to " ; store literal character data
Text_004            fcc       " has not yet been read." ; store literal character data
                    fcb       $0D       ; store byte data

start               os9       F$ID      ; retrieve the current process and user IDs
                    sty       WorkBuffer_003,u ; store y at WorkBuffer_003,u
                    ldy       #0        ; set y to the constant 0
                    os9       F$SUser   ; change the process user ID to Y
                    leax      >Text_001,pc ; form the address >Text_001,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    sta       WorkBuffer_001,u ; store a at WorkBuffer_001,u
                    clr       WorkWord_001,u ; clear WorkWord_001,u to zero and set the condition codes
                    leax      >Text_002,pc ; form the address >Text_002,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    sta       WorkBuffer_002,u ; store a at WorkBuffer_002,u
                    leax      >Data_001,pc ; form the address >Data_001,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      <WorkBuffer_004,u ; form the address <WorkBuffer_004,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       WorkBuffer_001,u ; load a from WorkBuffer_001,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
Branch_002          leax      >WorkBuffer_006,u ; form the address >WorkBuffer_006,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       WorkBuffer_001,u ; load a from WorkBuffer_001,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcs       Branch_003 ; branch when carry reports an error or unsigned underflow; target Branch_003
                    ldd       >WorkWord_003,u ; load d from >WorkWord_003,u
                    cmpd      WorkBuffer_003,u ; compare d with WorkBuffer_003,u and set the condition codes
                    bne       Branch_002 ; branch when the values differ or the result is nonzero; target Branch_002
                    bra       Branch_004 ; continue execution at Branch_004
Branch_003          cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      Branch_001 ; branch when the values differ or the result is nonzero; target Branch_001
                    tst       WorkWord_001,u ; set condition codes from WorkWord_001,u without changing it
                    beq       Branch_005 ; branch when the values are equal or the result is zero; target Branch_005
                    lbra      Branch_006 ; continue execution at Branch_006
Branch_005          leax      >Data_002,pc ; form the address >Data_002,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbra      Branch_006 ; continue execution at Branch_006
Branch_004          inc       <WorkWord_001 ; increment the value at <WorkWord_001
                    pshs      u         ; save u on the stack
                    lda       WorkBuffer_002,u ; load a from WorkBuffer_002,u
                    ldx       #0        ; set x to the constant 0
                    ldu       #0        ; set u to the constant 0
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    puls      u         ; restore u from the stack
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
Branch_007          lda       WorkBuffer_002,u ; load a from WorkBuffer_002,u
                    ldy       #200      ; set y to the constant 200
                    leax      <WorkBuffer_005,u ; form the address <WorkBuffer_005,u in x
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    clr       WorkByte_002,u ; clear WorkByte_002,u to zero and set the condition codes
Branch_008          inc       WorkByte_002,u ; increment the value at WorkByte_002,u
                    lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    bne       Branch_008 ; branch when the values differ or the result is nonzero; target Branch_008
                    dec       WorkByte_002,u ; decrement the value at WorkByte_002,u
                    lbsr      Routine_001 ; call subroutine Routine_001
                    cmpd      >WorkByte_005,u ; compare d with >WorkByte_005,u and set the condition codes
                    bne       Branch_007 ; branch when the values differ or the result is nonzero; target Branch_007
                    leax      >Text_003,pc ; form the address >Text_003,pc in x
                    ldy       #8        ; set y to the constant 8
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      <WorkBuffer_005,u ; form the address <WorkBuffer_005,u in x
                    ldb       WorkByte_002,u ; load b from WorkByte_002,u
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >Text_004,pc ; form the address >Text_004,pc in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbra      Branch_002 ; continue execution at Branch_002
Branch_006          clrb                ; clear b to zero and set the condition codes
Branch_001          pshs      b         ; save b on the stack
                    ldy       WorkBuffer_003,u ; load y from WorkBuffer_003,u
                    os9       F$SUser   ; change the process user ID to Y
                    puls      b         ; restore b from the stack
                    os9       F$Exit    ; terminate the process with status B
Routine_001         pshs      y         ; save y on the stack
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
                    sta       WorkByte_001,u ; store a at WorkByte_001,u
                    ldd       #0        ; set d to the constant 0
Branch_015          tst       WorkByte_001,u ; set condition codes from WorkByte_001,u without changing it
                    beq       Branch_016 ; branch when the values are equal or the result is zero; target Branch_016
                    addd      WorkWord_002,u ; add to d using WorkWord_002,u
                    dec       WorkByte_001,u ; decrement the value at WorkByte_001,u
                    bra       Branch_015 ; continue execution at Branch_015
Branch_016          addd      WorkByte_003,u ; add to d using WorkByte_003,u
                    std       WorkByte_003,u ; store d at WorkByte_003,u
                    lda       #10       ; set a to the constant 10
                    sta       WorkByte_001,u ; store a at WorkByte_001,u
                    ldd       #0        ; set d to the constant 0
Branch_017          tst       WorkByte_001,u ; set condition codes from WorkByte_001,u without changing it
                    beq       Branch_018 ; branch when the values are equal or the result is zero; target Branch_018
                    addd      WorkWord_002,u ; add to d using WorkWord_002,u
                    dec       WorkByte_001,u ; decrement the value at WorkByte_001,u
                    bra       Branch_017 ; continue execution at Branch_017
Branch_018          std       WorkWord_002,u ; store d at WorkWord_002,u
                    bra       Branch_013 ; continue execution at Branch_013
Branch_014          ldd       WorkByte_003,u ; load d from WorkByte_003,u
                    puls      x         ; restore x from the stack
                    puls      pc,y      ; restore pc,y and return to the caller

                    pshs      x         ; save x on the stack
                    std       WorkByte_003,u ; store d at WorkByte_003,u
                    lda       #48       ; set a to the constant 48
                    sta       ,x        ; store a at ,x
                    sta       $01,x     ; store a at $01,x
                    sta       $02,x     ; store a at $02,x
                    sta       $03,x     ; store a at $03,x
                    sta       $04,x     ; store a at $04,x
                    ldd       #10000    ; set d to the constant 10000
                    std       WorkWord_002,u ; store d at WorkWord_002,u
                    ldd       WorkByte_003,u ; load d from WorkByte_003,u
                    lbsr      Routine_002 ; call subroutine Routine_002
                    ldd       #1000     ; set d to the constant 1000
                    std       WorkWord_002,u ; store d at WorkWord_002,u
                    ldd       WorkByte_003,u ; load d from WorkByte_003,u
                    bsr       Routine_002 ; call subroutine Routine_002
                    ldd       #100      ; set d to the constant 100
                    std       WorkWord_002,u ; store d at WorkWord_002,u
                    ldd       WorkByte_003,u ; load d from WorkByte_003,u
                    bsr       Routine_002 ; call subroutine Routine_002
                    ldd       #10       ; set d to the constant 10
                    std       WorkWord_002,u ; store d at WorkWord_002,u
                    ldd       WorkByte_003,u ; load d from WorkByte_003,u
                    bsr       Routine_002 ; call subroutine Routine_002
                    ldd       #1        ; set d to the constant 1
                    std       WorkWord_002,u ; store d at WorkWord_002,u
                    ldd       WorkByte_003,u ; load d from WorkByte_003,u
                    bsr       Routine_002 ; call subroutine Routine_002
                    lda       #13       ; set a to the constant 13
                    sta       ,x        ; store a at ,x
                    puls      x         ; restore x from the stack
                    ldb       #32       ; set b to the constant 32
Branch_019          lda       ,x        ; load a from ,x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bne       Branch_020 ; branch when the values differ or the result is nonzero; target Branch_020
                    stb       ,x+       ; store b at ,x+
                    bra       Branch_019 ; continue execution at Branch_019
Branch_020          lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_021 ; branch when carry reports an error or unsigned underflow; target Branch_021
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_021 ; branch when the unsigned value is higher; target Branch_021
                    bra       Branch_020 ; continue execution at Branch_020
Branch_021          leax      -$01,x    ; form the address -$01,x in x
                    rts                 ; return to the caller
Routine_002         subd      WorkWord_002,u ; subtract from d using WorkWord_002,u
                    bcs       Branch_022 ; branch when carry reports an error or unsigned underflow; target Branch_022
                    inc       ,x        ; increment the value at ,x
                    bra       Routine_002 ; continue execution at Routine_002
Branch_022          addd      WorkWord_002,u ; add to d using WorkWord_002,u
                    std       WorkByte_003,u ; store d at WorkByte_003,u
                    leax      $01,x     ; form the address $01,x in x
                    rts                 ; return to the caller
Branch_010          ldd       #-1       ; set d to the constant -1
                    puls      pc,y      ; restore pc,y and return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
