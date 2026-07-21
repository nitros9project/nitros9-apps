**********************************************************************
* BBS.mail.readD - OS-9 Level 2 BBS command
*
* Syntax: BBS.mail.readD
* Purpose: Read private mail and delete each handled item.
* Data: BBS.mail and BBS.mail.inx; shell compatibility affects deletion errors.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       BBS.mail.readD
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
WorkByte_002        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_003        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_001      rmb       3         ; reserve 3 byte(s) in the module workspace
WorkByte_004        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_005        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_002        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_002      rmb       8         ; reserve 8 byte(s) in the module workspace
WorkBuffer_003      rmb       3         ; reserve 3 byte(s) in the module workspace
WorkByte_006        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_004      rmb       13        ; reserve 13 byte(s) in the module workspace
WorkByte_007        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_008        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_009        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_010        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_011        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_012        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_013        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_014        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_015        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_005      rmb       64        ; reserve 64 byte(s) in the module workspace
WorkBuffer_006      rmb       80        ; reserve 80 byte(s) in the module workspace
WorkWord_003        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_004        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_007      rmb       20        ; reserve 20 byte(s) in the module workspace
WorkBuffer_008      rmb       30        ; reserve 30 byte(s) in the module workspace
WorkByte_016        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_017        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_009      rmb       6         ; reserve 6 byte(s) in the module workspace
WorkBuffer_010      rmb       62        ; reserve 62 byte(s) in the module workspace
WorkByte_018        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_011      rmb       139       ; reserve 139 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.mail.readD/ ; store an OS-9 high-bit-terminated string
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
                    fcc       "High message is #" ; store literal character data
                    fcb       $00       ; store byte data
                    fcb       $11       ; store byte data
                    fcc       "Enter message #" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcc       ">" ; store literal character data
Text_001            fcc       "BBS.mail.inx" ; store literal character data
                    fcb       $0D       ; store byte data
Text_002            fcc       "BBS.mail" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcc       "******   DELETED   ******" ; store literal character data
                    fcb       $0D       ; store byte data
Data_001            fcb       $0A       ; store byte data
                    fcb       $0A       ; store byte data
                    fcc       "From    :" ; store literal character data
Text_003            fcc       "Left on :" ; store literal character data
Text_004            fcc       "About   :" ; store literal character data
Data_002            fcb       $00       ; store byte data
                    fcb       $09       ; store byte data
Text_005            fcc       "---------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
Data_003            fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
Data_004            fcb       $0A       ; store byte data
                    fcc       "That's all the mail that was left for you" ; store literal character data
                    fcb       $0D       ; store byte data
Text_006            fcc       "Sorry, you have no mail" ; store literal character data
                    fcb       $0D       ; store byte data
Text_007            fcc       "Checking for mail..." ; store literal character data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
Text_008            fcc       "Re-Read? (Y/N):" ; store literal character data
                    fcb       $0D       ; store byte data
Text_009            fcc       "BBS.mail.delete" ; store literal character data
                    fcb       $0D       ; store byte data

start               os9       F$ID      ; retrieve the current process and user IDs
                    sty       WorkBuffer_002,u ; store y at WorkBuffer_002,u
                    ldy       #0        ; set y to the constant 0
                    os9       F$SUser   ; change the process user ID to Y
                    leax      >Text_001,pc ; form the address >Text_001,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    sta       WorkByte_001,u ; store a at WorkByte_001,u
                    leax      >Text_002,pc ; form the address >Text_002,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    sta       WorkWord_001,u ; store a at WorkWord_001,u
                    clr       WorkByte_003,u ; clear WorkByte_003,u to zero and set the condition codes
                    leax      >Text_007,pc ; form the address >Text_007,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      <WorkBuffer_005,u ; form the address <WorkBuffer_005,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
Branch_002          leax      >WorkWord_003,u ; form the address >WorkWord_003,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcs       Branch_003 ; branch when carry reports an error or unsigned underflow; target Branch_003
                    ldd       >WorkBuffer_010,u ; load d from >WorkBuffer_010,u
                    cmpd      WorkBuffer_002,u ; compare d with WorkBuffer_002,u and set the condition codes
                    bne       Branch_002 ; branch when the values differ or the result is nonzero; target Branch_002
                    bra       Branch_004 ; continue execution at Branch_004
Branch_003          cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      Branch_001 ; branch when the values differ or the result is nonzero; target Branch_001
                    tst       WorkByte_003,u ; set condition codes from WorkByte_003,u without changing it
                    beq       Branch_005 ; branch when the values are equal or the result is zero; target Branch_005
                    leax      >Data_004,pc ; form the address >Data_004,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       WorkWord_001,u ; load a from WorkWord_001,u
                    os9       I$Close   ; close path A
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    os9       I$Close   ; close path A
                    ldy       WorkBuffer_002,u ; load y from WorkBuffer_002,u
                    os9       F$SUser   ; change the process user ID to Y
                    leax      >Text_009,pc ; form the address >Text_009,pc in x
                    ldy       #1        ; set y to the constant 1
                    leau      >WorkByte_018,u ; form the workspace or data address >WorkByte_018,u in u
                    lda       #17       ; set a to the constant 17
                    ldb       #3        ; set b to the constant 3
                    os9       F$Chain   ; replace this process with the module at X
Branch_005          leax      >Text_006,pc ; form the address >Text_006,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbra      Branch_006 ; continue execution at Branch_006
Branch_004          inc       WorkByte_003,u ; increment the value at WorkByte_003,u
                    ldd       >WorkWord_003,u ; load d from >WorkWord_003,u
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    lbeq      Branch_002 ; branch when the values are equal or the result is zero; target Branch_002
                    leax      >Data_001,pc ; form the address >Data_001,pc in x
                    ldy       >Data_002,pc ; load y from >Data_002,pc
                    leay      $02,y     ; form the address $02,y in y
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >WorkBuffer_007,u ; form the address >WorkBuffer_007,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      >Text_003,pc ; form the address >Text_003,pc in x
                    ldy       >Data_002,pc ; load y from >Data_002,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      <WorkBuffer_003,u ; form the address <WorkBuffer_003,u in x
                    ldb       >WorkByte_017,u ; load b from >WorkByte_017,u
                    clra                ; clear a to zero and set the condition codes
                    lbsr      Routine_001 ; call subroutine Routine_001
                    lda       <WorkByte_006,u ; load a from <WorkByte_006,u
                    sta       <WorkByte_007,u ; store a at <WorkByte_007,u
                    lda       <WorkBuffer_004,u ; load a from <WorkBuffer_004,u
                    sta       <WorkByte_008,u ; store a at <WorkByte_008,u
                    lda       #47       ; set a to the constant 47
                    sta       <WorkByte_009,u ; store a at <WorkByte_009,u
                    ldb       >WorkBuffer_009,u ; load b from >WorkBuffer_009,u
                    clra                ; clear a to zero and set the condition codes
                    leax      <WorkBuffer_003,u ; form the address <WorkBuffer_003,u in x
                    lbsr      Routine_001 ; call subroutine Routine_001
                    lda       <WorkByte_006,u ; load a from <WorkByte_006,u
                    sta       <WorkByte_010,u ; store a at <WorkByte_010,u
                    lda       <WorkBuffer_004,u ; load a from <WorkBuffer_004,u
                    sta       <WorkByte_011,u ; store a at <WorkByte_011,u
                    lda       #47       ; set a to the constant 47
                    sta       <WorkByte_012,u ; store a at <WorkByte_012,u
                    ldb       >WorkByte_016,u ; load b from >WorkByte_016,u
                    clra                ; clear a to zero and set the condition codes
                    leax      <WorkBuffer_003,u ; form the address <WorkBuffer_003,u in x
                    lbsr      Routine_001 ; call subroutine Routine_001
                    lda       <WorkByte_006,u ; load a from <WorkByte_006,u
                    sta       <WorkByte_013,u ; store a at <WorkByte_013,u
                    lda       <WorkBuffer_004,u ; load a from <WorkBuffer_004,u
                    sta       <WorkByte_014,u ; store a at <WorkByte_014,u
                    lda       #13       ; set a to the constant 13
                    sta       <WorkByte_015,u ; store a at <WorkByte_015,u
                    leax      <WorkByte_007,u ; form the address <WorkByte_007,u in x
Branch_007          lda       ,x+       ; load a from ,x+
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       Branch_007 ; branch when the values are equal or the result is zero; target Branch_007
                    leax      -$01,x    ; form the address -$01,x in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      >Text_004,pc ; form the address >Text_004,pc in x
                    ldy       >Data_002,pc ; load y from >Data_002,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >WorkBuffer_008,u ; form the address >WorkBuffer_008,u in x
                    ldy       #30       ; set y to the constant 30
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    bra       Branch_008 ; continue execution at Branch_008
Branch_008          leax      >Text_005,pc ; form the address >Text_005,pc in x
                    ldy       #64       ; set y to the constant 64
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       WorkWord_001,u ; load a from WorkWord_001,u
                    ldx       >WorkWord_003,u ; load x from >WorkWord_003,u
                    pshs      u         ; save u on the stack
                    ldu       >WorkWord_004,u ; load u from >WorkWord_004,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    puls      u         ; restore u from the stack
Branch_009          lda       WorkWord_001,u ; load a from WorkWord_001,u
                    leax      <WorkBuffer_006,u ; form the address <WorkBuffer_006,u in x
                    ldy       #80       ; set y to the constant 80
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bhi       Branch_009 ; branch when the unsigned value is higher; target Branch_009
                    leax      >Text_005,pc ; form the address >Text_005,pc in x
                    ldy       #64       ; set y to the constant 64
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Text_008,pc ; form the address >Text_008,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      WorkBuffer_001,u ; form the address WorkBuffer_001,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; read up to Y bytes from path A into X
                    leax      >Data_003,pc ; form the address >Data_003,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       WorkBuffer_001,u ; load a from WorkBuffer_001,u
                    cmpa      #121      ; compare a with #121 and set the condition codes
                    lbeq      Branch_008 ; branch when the values are equal or the result is zero; target Branch_008
                    cmpa      #89       ; compare a with #89 and set the condition codes
                    lbeq      Branch_008 ; branch when the values are equal or the result is zero; target Branch_008
                    lbra      Branch_002 ; continue execution at Branch_002
Branch_006          clrb                ; clear b to zero and set the condition codes
Branch_001          pshs      b         ; save b on the stack
                    ldy       WorkBuffer_002,u ; load y from WorkBuffer_002,u
                    os9       F$SUser   ; change the process user ID to Y
                    puls      b         ; restore b from the stack
                    os9       F$Exit    ; terminate the process with status B

                    pshs      y         ; save y on the stack
Branch_010          lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      Branch_011 ; branch when the values are equal or the result is zero; target Branch_011
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_010 ; branch when carry reports an error or unsigned underflow; target Branch_010
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_010 ; branch when the unsigned value is higher; target Branch_010
                    leax      -$01,x    ; form the address -$01,x in x
Branch_012          lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_013 ; branch when carry reports an error or unsigned underflow; target Branch_013
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_013 ; branch when the unsigned value is higher; target Branch_013
                    bra       Branch_012 ; continue execution at Branch_012
Branch_013          pshs      x         ; save x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    clr       WorkByte_004,u ; clear WorkByte_004,u to zero and set the condition codes
                    clr       WorkByte_005,u ; clear WorkByte_005,u to zero and set the condition codes
                    ldd       #1        ; set d to the constant 1
                    std       WorkWord_002,u ; store d at WorkWord_002,u
Branch_014          lda       ,-x       ; load a from ,-x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_015 ; branch when carry reports an error or unsigned underflow; target Branch_015
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_015 ; branch when the unsigned value is higher; target Branch_015
                    suba      #48       ; subtract from a using #48
                    sta       WorkByte_002,u ; store a at WorkByte_002,u
                    ldd       #0        ; set d to the constant 0
Branch_016          tst       WorkByte_002,u ; set condition codes from WorkByte_002,u without changing it
                    beq       Branch_017 ; branch when the values are equal or the result is zero; target Branch_017
                    addd      WorkWord_002,u ; add to d using WorkWord_002,u
                    dec       WorkByte_002,u ; decrement the value at WorkByte_002,u
                    bra       Branch_016 ; continue execution at Branch_016
Branch_017          addd      WorkByte_004,u ; add to d using WorkByte_004,u
                    std       WorkByte_004,u ; store d at WorkByte_004,u
                    lda       #10       ; set a to the constant 10
                    sta       WorkByte_002,u ; store a at WorkByte_002,u
                    ldd       #0        ; set d to the constant 0
Branch_018          tst       WorkByte_002,u ; set condition codes from WorkByte_002,u without changing it
                    beq       Branch_019 ; branch when the values are equal or the result is zero; target Branch_019
                    addd      WorkWord_002,u ; add to d using WorkWord_002,u
                    dec       WorkByte_002,u ; decrement the value at WorkByte_002,u
                    bra       Branch_018 ; continue execution at Branch_018
Branch_019          std       WorkWord_002,u ; store d at WorkWord_002,u
                    bra       Branch_014 ; continue execution at Branch_014
Branch_015          ldd       WorkByte_004,u ; load d from WorkByte_004,u
                    puls      x         ; restore x from the stack
                    puls      pc,y      ; restore pc,y and return to the caller
Routine_001         pshs      x         ; save x on the stack
                    std       WorkByte_004,u ; store d at WorkByte_004,u
                    lda       #48       ; set a to the constant 48
                    sta       ,x        ; store a at ,x
                    sta       $01,x     ; store a at $01,x
                    sta       $02,x     ; store a at $02,x
                    sta       $03,x     ; store a at $03,x
                    sta       $04,x     ; store a at $04,x
                    ldd       #10000    ; set d to the constant 10000
                    std       WorkWord_002,u ; store d at WorkWord_002,u
                    ldd       WorkByte_004,u ; load d from WorkByte_004,u
                    lbsr      Routine_002 ; call subroutine Routine_002
                    ldd       #1000     ; set d to the constant 1000
                    std       WorkWord_002,u ; store d at WorkWord_002,u
                    ldd       WorkByte_004,u ; load d from WorkByte_004,u
                    bsr       Routine_002 ; call subroutine Routine_002
                    ldd       #100      ; set d to the constant 100
                    std       WorkWord_002,u ; store d at WorkWord_002,u
                    ldd       WorkByte_004,u ; load d from WorkByte_004,u
                    bsr       Routine_002 ; call subroutine Routine_002
                    ldd       #10       ; set d to the constant 10
                    std       WorkWord_002,u ; store d at WorkWord_002,u
                    ldd       WorkByte_004,u ; load d from WorkByte_004,u
                    bsr       Routine_002 ; call subroutine Routine_002
                    ldd       #1        ; set d to the constant 1
                    std       WorkWord_002,u ; store d at WorkWord_002,u
                    ldd       WorkByte_004,u ; load d from WorkByte_004,u
                    bsr       Routine_002 ; call subroutine Routine_002
                    lda       #13       ; set a to the constant 13
                    sta       ,x        ; store a at ,x
                    puls      x         ; restore x from the stack
                    ldb       #32       ; set b to the constant 32
Branch_020          lda       ,x        ; load a from ,x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bne       Branch_021 ; branch when the values differ or the result is nonzero; target Branch_021
                    stb       ,x+       ; store b at ,x+
                    bra       Branch_020 ; continue execution at Branch_020
Branch_021          lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_022 ; branch when carry reports an error or unsigned underflow; target Branch_022
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_022 ; branch when the unsigned value is higher; target Branch_022
                    bra       Branch_021 ; continue execution at Branch_021
Branch_022          leax      -$01,x    ; form the address -$01,x in x
                    rts                 ; return to the caller
Routine_002         subd      WorkWord_002,u ; subtract from d using WorkWord_002,u
                    bcs       Branch_023 ; branch when carry reports an error or unsigned underflow; target Branch_023
                    inc       ,x        ; increment the value at ,x
                    bra       Routine_002 ; continue execution at Routine_002
Branch_023          addd      WorkWord_002,u ; add to d using WorkWord_002,u
                    std       WorkByte_004,u ; store d at WorkByte_004,u
                    leax      $01,x     ; form the address $01,x in x
                    rts                 ; return to the caller
Branch_011          ldd       #-1       ; set d to the constant -1
                    puls      pc,y      ; restore pc,y and return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
