**********************************************************************
* BBS.delete - OS-9 Level 2 BBS command
*
* Syntax: BBS.delete
* Purpose: Mark selected messages deleted in the current board index.
* Deletion is logical until BBS.pack rewrites the base.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       BBS.delete
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
WorkBuffer_001      rmb       4         ; reserve 4 byte(s) in the module workspace
WorkByte_004        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_005        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_001        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_002      rmb       12        ; reserve 12 byte(s) in the module workspace
WorkByte_006        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_003      rmb       6         ; reserve 6 byte(s) in the module workspace
WorkByte_007        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_008        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_004      rmb       11        ; reserve 11 byte(s) in the module workspace
WorkBuffer_005      rmb       64        ; reserve 64 byte(s) in the module workspace
WorkBuffer_006      rmb       60        ; reserve 60 byte(s) in the module workspace
WorkByte_009        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_007      rmb       203       ; reserve 203 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.delete/ ; store an OS-9 high-bit-terminated string
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
Text_001            fcc       "High message is #" ; store literal character data
Data_001            fcb       $00       ; store byte data
                    fcb       $11       ; store byte data
Text_002            fcc       "Enter message number to delete" ; store literal character data
                    fcb       $0D       ; store byte data
Text_003            fcc       ">Msg #    User name              Date        Subject" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcc       "-------------------------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
Text_004            fcc       "BBS.msg.inx" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcc       "                                       " ; store literal character data
Text_005            fcc       "          ******   DELETED   ******" ; store literal character data
                    fcb       $0D       ; store byte data
Text_006            fcc       "Sorry, you cannot delete that message" ; store literal character data
                    fcb       $0D       ; store byte data

start               os9       F$ID      ; retrieve the current process and user IDs
                    sty       WorkBuffer_001,u ; store y at WorkBuffer_001,u
                    ldy       #0        ; set y to the constant 0
                    os9       F$SUser   ; change the process user ID to Y
                    leax      >Text_004,pc ; form the address >Text_004,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    sta       WorkByte_001,u ; store a at WorkByte_001,u
                    leax      <WorkBuffer_005,u ; form the address <WorkBuffer_005,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    ldd       <WorkBuffer_005,u ; load d from <WorkBuffer_005,u
                    leax      WorkBuffer_002,u ; form the address WorkBuffer_002,u in x
                    lbsr      Routine_001 ; call subroutine Routine_001
                    leax      >Text_001,pc ; form the address >Text_001,pc in x
                    ldy       >Data_001,pc ; load y from >Data_001,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      WorkBuffer_002,u ; form the address WorkBuffer_002,u in x
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
                    clr       <WorkByte_006,u ; clear <WorkByte_006,u to zero and set the condition codes
                    leax      <WorkBuffer_003,u ; form the address <WorkBuffer_003,u in x
                    lda       #13       ; set a to the constant 13
                    sta       $02,x     ; store a at $02,x
                    lbsr      Routine_002 ; call subroutine Routine_002
                    cmpd      #1        ; compare d with #1 and set the condition codes
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    cmpd      <WorkBuffer_005,u ; compare d with <WorkBuffer_005,u and set the condition codes
                    lbhi      Branch_002 ; branch when the unsigned value is higher; target Branch_002
                    std       WorkBuffer_002,u ; store d at WorkBuffer_002,u
                    ldy       WorkBuffer_001,u ; load y from WorkBuffer_001,u
                    beq       Branch_003 ; branch when the values are equal or the result is zero; target Branch_003
                    bsr       Routine_003 ; call subroutine Routine_003
                    leax      <WorkBuffer_006,u ; form the address <WorkBuffer_006,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    ldy       WorkBuffer_001,u ; load y from WorkBuffer_001,u
                    cmpy      >WorkByte_009,u ; compare y with >WorkByte_009,u and set the condition codes
                    lbne      Branch_004 ; branch when the values differ or the result is nonzero; target Branch_004
Branch_003          bsr       Routine_003 ; call subroutine Routine_003
                    leax      <WorkBuffer_006,u ; form the address <WorkBuffer_006,u in x
                    ldd       #-1       ; set d to the constant -1
                    std       ,x        ; store d at ,x
                    ldy       #64       ; set y to the constant 64
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >Text_005,pc ; form the address >Text_005,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    bra       Branch_002 ; continue execution at Branch_002
Routine_003         clr       <WorkByte_007,u ; clear <WorkByte_007,u to zero and set the condition codes
                    clr       <WorkByte_008,u ; clear <WorkByte_008,u to zero and set the condition codes
                    lda       #6        ; set a to the constant 6
                    sta       WorkByte_002,u ; store a at WorkByte_002,u
                    ldd       WorkBuffer_002,u ; load d from WorkBuffer_002,u
Branch_005          aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    rol       <WorkByte_008,u ; rotate left through carry the value at <WorkByte_008,u
                    dec       WorkByte_002,u ; decrement the value at WorkByte_002,u
                    bne       Branch_005 ; branch when the values differ or the result is nonzero; target Branch_005
                    std       <WorkBuffer_004,u ; store d at <WorkBuffer_004,u
                    ldx       <WorkByte_007,u ; load x from <WorkByte_007,u
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    pshs      u         ; save u on the stack
                    ldu       <WorkBuffer_004,u ; load u from <WorkBuffer_004,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    puls      pc,u      ; restore pc,u and return to the caller
Branch_002          clrb                ; clear b to zero and set the condition codes
Branch_001          pshs      b         ; save b on the stack
                    ldy       WorkBuffer_001,u ; load y from WorkBuffer_001,u
                    os9       F$SUser   ; change the process user ID to Y
                    puls      b         ; restore b from the stack
                    os9       F$Exit    ; terminate the process with status B
Branch_004          leax      >Text_006,pc ; form the address >Text_006,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    bra       Branch_002 ; continue execution at Branch_002
Routine_002         pshs      y         ; save y on the stack
Branch_006          lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      Branch_007 ; branch when the values are equal or the result is zero; target Branch_007
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_006 ; branch when carry reports an error or unsigned underflow; target Branch_006
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_006 ; branch when the unsigned value is higher; target Branch_006
                    leax      -$01,x    ; form the address -$01,x in x
Branch_008          lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_009 ; branch when carry reports an error or unsigned underflow; target Branch_009
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_009 ; branch when the unsigned value is higher; target Branch_009
                    bra       Branch_008 ; continue execution at Branch_008
Branch_009          pshs      x         ; save x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    clr       WorkByte_004,u ; clear WorkByte_004,u to zero and set the condition codes
                    clr       WorkByte_005,u ; clear WorkByte_005,u to zero and set the condition codes
                    ldd       #1        ; set d to the constant 1
                    std       WorkWord_001,u ; store d at WorkWord_001,u
Branch_010          lda       ,-x       ; load a from ,-x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_011 ; branch when carry reports an error or unsigned underflow; target Branch_011
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_011 ; branch when the unsigned value is higher; target Branch_011
                    suba      #48       ; subtract from a using #48
                    sta       WorkByte_003,u ; store a at WorkByte_003,u
                    ldd       #0        ; set d to the constant 0
Branch_012          tst       WorkByte_003,u ; set condition codes from WorkByte_003,u without changing it
                    beq       Branch_013 ; branch when the values are equal or the result is zero; target Branch_013
                    addd      WorkWord_001,u ; add to d using WorkWord_001,u
                    dec       WorkByte_003,u ; decrement the value at WorkByte_003,u
                    bra       Branch_012 ; continue execution at Branch_012
Branch_013          addd      WorkByte_004,u ; add to d using WorkByte_004,u
                    std       WorkByte_004,u ; store d at WorkByte_004,u
                    lda       #10       ; set a to the constant 10
                    sta       WorkByte_003,u ; store a at WorkByte_003,u
                    ldd       #0        ; set d to the constant 0
Branch_014          tst       WorkByte_003,u ; set condition codes from WorkByte_003,u without changing it
                    beq       Branch_015 ; branch when the values are equal or the result is zero; target Branch_015
                    addd      WorkWord_001,u ; add to d using WorkWord_001,u
                    dec       WorkByte_003,u ; decrement the value at WorkByte_003,u
                    bra       Branch_014 ; continue execution at Branch_014
Branch_015          std       WorkWord_001,u ; store d at WorkWord_001,u
                    bra       Branch_010 ; continue execution at Branch_010
Branch_011          ldd       WorkByte_004,u ; load d from WorkByte_004,u
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
                    std       WorkWord_001,u ; store d at WorkWord_001,u
                    ldd       WorkByte_004,u ; load d from WorkByte_004,u
                    lbsr      Routine_004 ; call subroutine Routine_004
                    ldd       #1000     ; set d to the constant 1000
                    std       WorkWord_001,u ; store d at WorkWord_001,u
                    ldd       WorkByte_004,u ; load d from WorkByte_004,u
                    bsr       Routine_004 ; call subroutine Routine_004
                    ldd       #100      ; set d to the constant 100
                    std       WorkWord_001,u ; store d at WorkWord_001,u
                    ldd       WorkByte_004,u ; load d from WorkByte_004,u
                    bsr       Routine_004 ; call subroutine Routine_004
                    ldd       #10       ; set d to the constant 10
                    std       WorkWord_001,u ; store d at WorkWord_001,u
                    ldd       WorkByte_004,u ; load d from WorkByte_004,u
                    bsr       Routine_004 ; call subroutine Routine_004
                    ldd       #1        ; set d to the constant 1
                    std       WorkWord_001,u ; store d at WorkWord_001,u
                    ldd       WorkByte_004,u ; load d from WorkByte_004,u
                    bsr       Routine_004 ; call subroutine Routine_004
                    lda       #13       ; set a to the constant 13
                    sta       ,x        ; store a at ,x
                    puls      x         ; restore x from the stack
                    ldb       #32       ; set b to the constant 32
Branch_016          lda       ,x        ; load a from ,x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bne       Branch_017 ; branch when the values differ or the result is nonzero; target Branch_017
                    stb       ,x+       ; store b at ,x+
                    bra       Branch_016 ; continue execution at Branch_016
Branch_017          lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_018 ; branch when carry reports an error or unsigned underflow; target Branch_018
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_018 ; branch when the unsigned value is higher; target Branch_018
                    bra       Branch_017 ; continue execution at Branch_017
Branch_018          leax      -$01,x    ; form the address -$01,x in x
                    rts                 ; return to the caller
Routine_004         subd      WorkWord_001,u ; subtract from d using WorkWord_001,u
                    bcs       Branch_019 ; branch when carry reports an error or unsigned underflow; target Branch_019
                    inc       ,x        ; increment the value at ,x
                    bra       Routine_004 ; continue execution at Routine_004
Branch_019          addd      WorkWord_001,u ; add to d using WorkWord_001,u
                    std       WorkByte_004,u ; store d at WorkByte_004,u
                    leax      $01,x     ; form the address $01,x in x
                    rts                 ; return to the caller
Branch_007          ldd       #-1       ; set d to the constant -1
                    puls      pc,y      ; restore pc,y and return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
