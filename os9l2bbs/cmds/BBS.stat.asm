**********************************************************************
* BBS.stat - OS-9 Level 2 BBS command
*
* Syntax: BBS.stat
* Purpose: Display the current user usage totals.
* Reads /dd/bbs/BBS.userstats.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       BBS.stat
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
WorkWord_001        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_002        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_003        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_001      rmb       8         ; reserve 8 byte(s) in the module workspace
WorkWord_004        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_005        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_006        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_007        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_002      rmb       6         ; reserve 6 byte(s) in the module workspace
WorkBuffer_003      rmb       8         ; reserve 8 byte(s) in the module workspace
WorkBuffer_004      rmb       3         ; reserve 3 byte(s) in the module workspace
WorkWord_008        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_005        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_005      rmb       400       ; reserve 400 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.stat/ ; store an OS-9 high-bit-terminated string
Text_001            fcc       "User Statistics:" ; store literal character data
                    fcb       $0D       ; store byte data
Text_002            fcc       "----------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
Text_003            fcc       "Last on         : " ; store literal character data
Text_004            fcc       "Times called    : " ; store literal character data
Text_005            fcc       "Messages left   : " ; store literal character data
Text_006            fcc       "Messages read   : " ; store literal character data
Text_007            fcc       "Files downloaded: " ; store literal character data
Text_008            fcc       "Files uploaded  : " ; store literal character data
Text_009            fcc       "Time this login : " ; store literal character data
Text_010            fcc       "User # to check:" ; store literal character data
Text_011            fcc       "/dd/bbs/BBS.userstats" ; store literal character data
Text_012            fcc       "           January February    March    April      May     June     July   AugustSeptember  October November December" ; store literal character data
Text_013            fcc       ", 19" ; store literal character data
Data_001            fcb       $3A       ; store byte data
start               leax      >Text_011,pc ; form the address >Text_011,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    sta       WorkByte_001,u ; store a at WorkByte_001,u
                    os9       F$ID      ; retrieve the current process and user IDs
                    sty       WorkWord_002,u ; store y at WorkWord_002,u
                    lda       #13       ; set a to the constant 13
                    sta       <WorkByte_005,u ; store a at <WorkByte_005,u
                    ldd       WorkWord_002,u ; load d from WorkWord_002,u
                    cmpd      #0        ; compare d with #0 and set the condition codes
                    bne       Branch_002 ; branch when the values differ or the result is nonzero; target Branch_002
                    lbsr      Routine_001 ; call subroutine Routine_001
Branch_002          leax      WorkWord_003,u ; form the address WorkWord_003,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcs       Branch_003 ; branch when carry reports an error or unsigned underflow; target Branch_003
                    ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    cmpd      WorkWord_002,u ; compare d with WorkWord_002,u and set the condition codes
                    beq       Branch_004 ; branch when the values are equal or the result is zero; target Branch_004
                    bra       Branch_002 ; continue execution at Branch_002
Branch_003          cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      Branch_005 ; branch when the values differ or the result is nonzero; target Branch_005
                    lbra      Branch_001 ; continue execution at Branch_001
Branch_004          leax      >Text_001,pc ; form the address >Text_001,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Text_002,pc ; form the address >Text_002,pc in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Text_003,pc ; form the address >Text_003,pc in x
                    ldy       #18       ; set y to the constant 18
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      <WorkBuffer_002,u ; form the address <WorkBuffer_002,u in x
                    lbsr      Routine_002 ; call subroutine Routine_002
                    leax      >Text_004,pc ; form the address >Text_004,pc in x
                    ldy       #18       ; set y to the constant 18
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    ldd       WorkBuffer_001,u ; load d from WorkBuffer_001,u
                    lbsr      Routine_003 ; call subroutine Routine_003
                    leax      >Text_007,pc ; form the address >Text_007,pc in x
                    ldy       #18       ; set y to the constant 18
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    ldd       <WorkWord_006,u ; load d from <WorkWord_006,u
                    lbsr      Routine_003 ; call subroutine Routine_003
                    leax      >Text_008,pc ; form the address >Text_008,pc in x
                    ldy       #18       ; set y to the constant 18
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    ldd       <WorkWord_007,u ; load d from <WorkWord_007,u
                    lbsr      Routine_003 ; call subroutine Routine_003
                    leax      >Text_005,pc ; form the address >Text_005,pc in x
                    ldy       #18       ; set y to the constant 18
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    ldd       <WorkWord_004,u ; load d from <WorkWord_004,u
                    lbsr      Routine_003 ; call subroutine Routine_003
                    leax      >Text_006,pc ; form the address >Text_006,pc in x
                    ldy       #18       ; set y to the constant 18
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    ldd       <WorkWord_005,u ; load d from <WorkWord_005,u
                    lbsr      Routine_003 ; call subroutine Routine_003
                    ldd       <WorkBuffer_003,u ; load d from <WorkBuffer_003,u
                    beq       Branch_006 ; branch when the values are equal or the result is zero; target Branch_006
                    leax      >Text_009,pc ; form the address >Text_009,pc in x
                    ldy       #18       ; set y to the constant 18
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    ldd       <WorkBuffer_003,u ; load d from <WorkBuffer_003,u
                    lbsr      Routine_003 ; call subroutine Routine_003
Branch_006          leax      >Text_002,pc ; form the address >Text_002,pc in x
                    lda       #1        ; set a to the constant 1
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
Branch_001          clrb                ; clear b to zero and set the condition codes
Branch_005          os9       F$Exit    ; terminate the process with status B
Routine_003         leax      <WorkBuffer_004,u ; form the address <WorkBuffer_004,u in x
                    lbsr      Routine_004 ; call subroutine Routine_004
                    leax      <WorkBuffer_004,u ; form the address <WorkBuffer_004,u in x
Branch_007          lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    beq       Branch_007 ; branch when the values are equal or the result is zero; target Branch_007
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       Branch_008 ; branch when the values differ or the result is nonzero; target Branch_008
                    leax      -$01,x    ; form the address -$01,x in x
Branch_008          leax      -$01,x    ; form the address -$01,x in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    rts                 ; return to the caller
Routine_002         lda       $01,x     ; load a from $01,x
                    ldb       #9        ; set b to the constant 9
                    mul                 ; multiply a by b and return the product in d
                    pshs      x         ; save x on the stack
                    leax      >Text_012,pc ; form the address >Text_012,pc in x
                    leax      d,x       ; form the address d,x in x
                    ldy       #10       ; set y to the constant 10
Branch_009          lda       ,x+       ; load a from ,x+
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    bne       Branch_010 ; branch when the values differ or the result is nonzero; target Branch_010
                    leay      -$01,y    ; form the address -$01,y in y
                    bne       Branch_009 ; branch when the values differ or the result is nonzero; target Branch_009
Branch_010          leax      -$01,x    ; form the address -$01,x in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    ldx       ,s        ; load x from the current stack frame at ,s
                    ldb       $02,x     ; load b from $02,x
                    clra                ; clear a to zero and set the condition codes
                    leax      <WorkBuffer_004,u ; form the address <WorkBuffer_004,u in x
                    lbsr      Routine_004 ; call subroutine Routine_004
                    leax      <WorkBuffer_004,u ; form the address <WorkBuffer_004,u in x
                    leax      $03,x     ; form the address $03,x in x
                    ldy       #2        ; set y to the constant 2
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >Text_013,pc ; form the address >Text_013,pc in x
                    ldy       #4        ; set y to the constant 4
                    os9       I$Write   ; write Y bytes from X to path A
                    ldx       ,s        ; load x from the current stack frame at ,s
                    ldb       ,x        ; load b from ,x
                    clra                ; clear a to zero and set the condition codes
                    leax      <WorkBuffer_004,u ; form the address <WorkBuffer_004,u in x
                    lbsr      Routine_004 ; call subroutine Routine_004
                    leax      <WorkWord_008,u ; form the address <WorkWord_008,u in x
                    ldy       #2        ; set y to the constant 2
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >Text_012,pc ; form the address >Text_012,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    clra                ; clear a to zero and set the condition codes
                    ldx       ,s        ; load x from the current stack frame at ,s
                    ldb       $03,x     ; load b from $03,x
                    leax      <WorkBuffer_004,u ; form the address <WorkBuffer_004,u in x
                    lbsr      Routine_004 ; call subroutine Routine_004
                    leax      <WorkWord_008,u ; form the address <WorkWord_008,u in x
                    ldy       #2        ; set y to the constant 2
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >Data_001,pc ; form the address >Data_001,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    clra                ; clear a to zero and set the condition codes
                    ldx       ,s        ; load x from the current stack frame at ,s
                    ldb       $04,x     ; load b from $04,x
                    leax      <WorkBuffer_004,u ; form the address <WorkBuffer_004,u in x
                    lbsr      Routine_004 ; call subroutine Routine_004
                    leax      <WorkBuffer_004,u ; form the address <WorkBuffer_004,u in x
                    leax      $03,x     ; form the address $03,x in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    puls      pc,x      ; restore pc,x and return to the caller
Routine_005         pshs      y         ; save y on the stack
Branch_011          lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      Branch_012 ; branch when the values are equal or the result is zero; target Branch_012
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_011 ; branch when carry reports an error or unsigned underflow; target Branch_011
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_011 ; branch when the unsigned value is higher; target Branch_011
                    leax      -$01,x    ; form the address -$01,x in x
Branch_013          lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_014 ; branch when carry reports an error or unsigned underflow; target Branch_014
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_014 ; branch when the unsigned value is higher; target Branch_014
                    bra       Branch_013 ; continue execution at Branch_013
Branch_014          pshs      x         ; save x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    clr       WorkByte_003,u ; clear WorkByte_003,u to zero and set the condition codes
                    clr       WorkByte_004,u ; clear WorkByte_004,u to zero and set the condition codes
                    ldd       #1        ; set d to the constant 1
                    std       WorkWord_001,u ; store d at WorkWord_001,u
Branch_015          lda       ,-x       ; load a from ,-x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_016 ; branch when carry reports an error or unsigned underflow; target Branch_016
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_016 ; branch when the unsigned value is higher; target Branch_016
                    suba      #48       ; subtract from a using #48
                    sta       WorkByte_002,u ; store a at WorkByte_002,u
                    ldd       #0        ; set d to the constant 0
Branch_017          tst       WorkByte_002,u ; set condition codes from WorkByte_002,u without changing it
                    beq       Branch_018 ; branch when the values are equal or the result is zero; target Branch_018
                    addd      WorkWord_001,u ; add to d using WorkWord_001,u
                    dec       WorkByte_002,u ; decrement the value at WorkByte_002,u
                    bra       Branch_017 ; continue execution at Branch_017
Branch_018          addd      WorkByte_003,u ; add to d using WorkByte_003,u
                    std       WorkByte_003,u ; store d at WorkByte_003,u
                    lda       #10       ; set a to the constant 10
                    sta       WorkByte_002,u ; store a at WorkByte_002,u
                    ldd       #0        ; set d to the constant 0
Branch_019          tst       WorkByte_002,u ; set condition codes from WorkByte_002,u without changing it
                    beq       Branch_020 ; branch when the values are equal or the result is zero; target Branch_020
                    addd      WorkWord_001,u ; add to d using WorkWord_001,u
                    dec       WorkByte_002,u ; decrement the value at WorkByte_002,u
                    bra       Branch_019 ; continue execution at Branch_019
Branch_020          std       WorkWord_001,u ; store d at WorkWord_001,u
                    bra       Branch_015 ; continue execution at Branch_015
Branch_016          ldd       WorkByte_003,u ; load d from WorkByte_003,u
                    puls      x         ; restore x from the stack
                    puls      pc,y      ; restore pc,y and return to the caller
Routine_004         std       WorkByte_003,u ; store d at WorkByte_003,u
                    lda       #48       ; set a to the constant 48
                    sta       ,x        ; store a at ,x
                    sta       $01,x     ; store a at $01,x
                    sta       $02,x     ; store a at $02,x
                    sta       $03,x     ; store a at $03,x
                    sta       $04,x     ; store a at $04,x
                    ldd       #10000    ; set d to the constant 10000
                    std       WorkWord_001,u ; store d at WorkWord_001,u
                    ldd       WorkByte_003,u ; load d from WorkByte_003,u
                    lbsr      Routine_006 ; call subroutine Routine_006
                    ldd       #1000     ; set d to the constant 1000
                    std       WorkWord_001,u ; store d at WorkWord_001,u
                    ldd       WorkByte_003,u ; load d from WorkByte_003,u
                    bsr       Routine_006 ; call subroutine Routine_006
                    ldd       #100      ; set d to the constant 100
                    std       WorkWord_001,u ; store d at WorkWord_001,u
                    ldd       WorkByte_003,u ; load d from WorkByte_003,u
                    bsr       Routine_006 ; call subroutine Routine_006
                    ldd       #10       ; set d to the constant 10
                    std       WorkWord_001,u ; store d at WorkWord_001,u
                    ldd       WorkByte_003,u ; load d from WorkByte_003,u
                    bsr       Routine_006 ; call subroutine Routine_006
                    ldd       #1        ; set d to the constant 1
                    std       WorkWord_001,u ; store d at WorkWord_001,u
                    ldd       WorkByte_003,u ; load d from WorkByte_003,u
                    bsr       Routine_006 ; call subroutine Routine_006
                    lda       #13       ; set a to the constant 13
                    sta       ,x        ; store a at ,x
                    rts                 ; return to the caller
Routine_006         subd      WorkWord_001,u ; subtract from d using WorkWord_001,u
                    bcs       Branch_021 ; branch when carry reports an error or unsigned underflow; target Branch_021
                    inc       ,x        ; increment the value at ,x
                    bra       Routine_006 ; continue execution at Routine_006
Branch_021          addd      WorkWord_001,u ; add to d using WorkWord_001,u
                    std       WorkByte_003,u ; store d at WorkByte_003,u
                    leax      $01,x     ; form the address $01,x in x
                    rts                 ; return to the caller
Branch_012          ldb       #1        ; set b to the constant 1
                    lbra      Branch_005 ; continue execution at Branch_005
Routine_001         leax      >Text_010,pc ; form the address >Text_010,pc in x
                    ldy       #16       ; set y to the constant 16
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      <WorkBuffer_004,u ; form the address <WorkBuffer_004,u in x
                    ldy       #5        ; set y to the constant 5
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lbsr      Routine_005 ; call subroutine Routine_005
                    std       WorkWord_002,u ; store d at WorkWord_002,u
                    rts                 ; return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
