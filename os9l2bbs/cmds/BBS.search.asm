**********************************************************************
* BBS.search - OS-9 Level 2 BBS command
*
* Syntax: BBS.search
* Purpose: Search message subjects for caller-entered text.
* Scans bbs.msg.inx and reports matching visible messages.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       BBS.search
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
WorkByte_002        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_001        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_002        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_002      rmb       6         ; reserve 6 byte(s) in the module workspace
WorkBuffer_003      rmb       3         ; reserve 3 byte(s) in the module workspace
WorkByte_003        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_003        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_004        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_004      rmb       34        ; reserve 34 byte(s) in the module workspace
WorkByte_005        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_006        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_007        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_008        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_009        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_010        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_011        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_012        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_013        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_005      rmb       64        ; reserve 64 byte(s) in the module workspace
WorkBuffer_006      rmb       4         ; reserve 4 byte(s) in the module workspace
WorkBuffer_007      rmb       20        ; reserve 20 byte(s) in the module workspace
WorkBuffer_008      rmb       30        ; reserve 30 byte(s) in the module workspace
WorkByte_014        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_015        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_016        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_009      rmb       205       ; reserve 205 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.search/ ; store an OS-9 high-bit-terminated string
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
                    fcc       "High message is #" ; store literal character data
                    fcb       $00       ; store byte data
                    fcb       $11       ; store byte data
Text_001            fcc       "Enter subject search text" ; store literal character data
                    fcb       $0D       ; store byte data
Text_002            fcc       ">" ; store literal character data
Text_003            fcc       "Msg #    User name              Date        Subject" ; store literal character data
                    fcb       $0D       ; store byte data
Text_004            fcc       "----------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
Text_005            fcc       "BBS.msg.inx" ; store literal character data
                    fcb       $0D       ; store byte data
Text_006            fcc       "                                       " ; store literal character data
Text_007            fcc       "          ******   DELETED   ******" ; store literal character data
                    fcb       $0D       ; store byte data
start               leax      >Text_005,pc ; form the address >Text_005,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    sta       WorkBuffer_001,u ; store a at WorkBuffer_001,u
                    leax      <WorkBuffer_005,u ; form the address <WorkBuffer_005,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       WorkBuffer_001,u ; load a from WorkBuffer_001,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    ldd       #0        ; set d to the constant 0
                    std       WorkBuffer_002,u ; store d at WorkBuffer_002,u
Branch_002          leax      >Text_001,pc ; form the address >Text_001,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      >Text_002,pc ; form the address >Text_002,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      <WorkBuffer_004,u ; form the address <WorkBuffer_004,u in x
                    ldy       #30       ; set y to the constant 30
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    bcs       Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    clr       <WorkByte_004,u ; clear <WorkByte_004,u to zero and set the condition codes
                    leax      <WorkBuffer_004,u ; form the address <WorkBuffer_004,u in x
                    leax      >Text_003,pc ; form the address >Text_003,pc in x
                    ldy       #80       ; set y to the constant 80
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      >Text_004,pc ; form the address >Text_004,pc in x
                    ldy       #80       ; set y to the constant 80
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
Branch_003          lda       WorkBuffer_001,u ; load a from WorkBuffer_001,u
                    ldy       #64       ; set y to the constant 64
                    leax      >WorkBuffer_006,u ; form the address >WorkBuffer_006,u in x
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lbcs      Branch_004 ; branch when carry reports an error or unsigned underflow; target Branch_004
                    ldd       WorkBuffer_002,u ; load d from WorkBuffer_002,u
                    addd      #1        ; add to d using #1
                    std       WorkBuffer_002,u ; store d at WorkBuffer_002,u
                    leay      >WorkBuffer_008,u ; form the address >WorkBuffer_008,u in y
                    ldb       #30       ; set b to the constant 30
Branch_005          leax      <WorkBuffer_004,u ; form the address <WorkBuffer_004,u in x
Branch_006          lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_007 ; branch when the values are equal or the result is zero; target Branch_007
                    decb                ; decrement b
                    beq       Branch_003 ; branch when the values are equal or the result is zero; target Branch_003
                    cmpa      ,y+       ; compare a with ,y+ and set the condition codes
                    bne       Branch_005 ; branch when the values differ or the result is nonzero; target Branch_005
                    bra       Branch_006 ; continue execution at Branch_006
Branch_007          ldd       >WorkBuffer_006,u ; load d from >WorkBuffer_006,u
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    lbeq      Branch_008 ; branch when the values are equal or the result is zero; target Branch_008
                    ldd       WorkBuffer_002,u ; load d from WorkBuffer_002,u
                    leax      WorkBuffer_003,u ; form the address WorkBuffer_003,u in x
                    lbsr      Routine_001 ; call subroutine Routine_001
                    leax      WorkBuffer_003,u ; form the address WorkBuffer_003,u in x
                    ldy       #5        ; set y to the constant 5
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      >Text_006,pc ; form the address >Text_006,pc in x
                    ldy       #4        ; set y to the constant 4
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      >WorkBuffer_007,u ; form the address >WorkBuffer_007,u in x
                    clr       WorkByte_001,u ; clear WorkByte_001,u to zero and set the condition codes
                    clr       WorkByte_002,u ; clear WorkByte_002,u to zero and set the condition codes
Branch_009          lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_010 ; branch when the values are equal or the result is zero; target Branch_010
                    inc       WorkByte_002,u ; increment the value at WorkByte_002,u
                    bra       Branch_009 ; continue execution at Branch_009
Branch_010          leax      >WorkBuffer_007,u ; form the address >WorkBuffer_007,u in x
                    ldy       WorkByte_001,u ; load y from WorkByte_001,u
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    ldd       #22       ; set d to the constant 22
                    subd      WorkByte_001,u ; subtract from d using WorkByte_001,u
                    tfr       d,y       ; copy the register values specified by d,y
                    leax      >Text_006,pc ; form the address >Text_006,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      WorkBuffer_003,u ; form the address WorkBuffer_003,u in x
                    ldb       >WorkByte_015,u ; load b from >WorkByte_015,u
                    clra                ; clear a to zero and set the condition codes
                    lbsr      Routine_001 ; call subroutine Routine_001
                    lda       <WorkByte_003,u ; load a from <WorkByte_003,u
                    sta       <WorkByte_005,u ; store a at <WorkByte_005,u
                    lda       <WorkWord_003,u ; load a from <WorkWord_003,u
                    sta       <WorkByte_006,u ; store a at <WorkByte_006,u
                    lda       #47       ; set a to the constant 47
                    sta       <WorkByte_007,u ; store a at <WorkByte_007,u
                    ldb       >WorkByte_016,u ; load b from >WorkByte_016,u
                    clra                ; clear a to zero and set the condition codes
                    leax      WorkBuffer_003,u ; form the address WorkBuffer_003,u in x
                    lbsr      Routine_001 ; call subroutine Routine_001
                    lda       <WorkByte_003,u ; load a from <WorkByte_003,u
                    sta       <WorkByte_008,u ; store a at <WorkByte_008,u
                    lda       <WorkWord_003,u ; load a from <WorkWord_003,u
                    sta       <WorkByte_009,u ; store a at <WorkByte_009,u
                    lda       #47       ; set a to the constant 47
                    sta       <WorkByte_010,u ; store a at <WorkByte_010,u
                    ldb       >WorkByte_014,u ; load b from >WorkByte_014,u
                    clra                ; clear a to zero and set the condition codes
                    leax      WorkBuffer_003,u ; form the address WorkBuffer_003,u in x
                    lbsr      Routine_001 ; call subroutine Routine_001
                    lda       <WorkByte_003,u ; load a from <WorkByte_003,u
                    sta       <WorkByte_011,u ; store a at <WorkByte_011,u
                    lda       <WorkWord_003,u ; load a from <WorkWord_003,u
                    sta       <WorkByte_012,u ; store a at <WorkByte_012,u
                    lda       #13       ; set a to the constant 13
                    sta       <WorkByte_013,u ; store a at <WorkByte_013,u
                    leax      <WorkByte_005,u ; form the address <WorkByte_005,u in x
                    ldy       #8        ; set y to the constant 8
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    ldy       #5        ; set y to the constant 5
                    leax      >Text_006,pc ; form the address >Text_006,pc in x
                    os9       I$Write   ; write Y bytes from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    leax      >WorkBuffer_008,u ; form the address >WorkBuffer_008,u in x
                    ldy       #30       ; set y to the constant 30
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    lbra      Branch_003 ; continue execution at Branch_003
Branch_008          leax      >Text_007,pc ; form the address >Text_007,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbra      Branch_003 ; continue execution at Branch_003
Branch_004          clrb                ; clear b to zero and set the condition codes
Branch_001          os9       F$Exit    ; terminate the process with status B
                    fcb       $34       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $A6       ; store byte data
                    fcb       $80       ; store byte data
                    fcb       $81       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $CB       ; store byte data
                    fcb       $81       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $F4       ; store byte data
                    fcb       $81       ; store byte data
                    fcb       $39       ; store byte data
                    fcb       $22       ; store byte data
                    fcb       $F0       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $A6       ; store byte data
                    fcb       $80       ; store byte data
                    fcb       $81       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $81       ; store byte data
                    fcb       $39       ; store byte data
                    fcb       $22       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $F4       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $1F       ; store byte data
                    fcc       "oEoF" ; store literal character data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $47       ; store byte data
                    fcb       $A6       ; store byte data
                    fcb       $82       ; store byte data
                    fcb       $81       ; store byte data
                    fcc       "0%." ; store literal character data
                    fcb       $81       ; store byte data
                    fcc       /9"*/ ; store literal character data
                    fcb       $80       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $A7       ; store byte data
                    fcb       $42       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcc       "mB'" ; store literal character data
                    fcb       $06       ; store byte data
                    fcb       $E3       ; store byte data
                    fcc       "GjB " ; store literal character data
                    fcb       $F6       ; store byte data
                    fcb       $E3       ; store byte data
                    fcb       $45       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $45       ; store byte data
                    fcb       $86       ; store byte data
                    fcb       $0A       ; store byte data
                    fcb       $A7       ; store byte data
                    fcb       $42       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcc       "mB'" ; store literal character data
                    fcb       $06       ; store byte data
                    fcb       $E3       ; store byte data
                    fcc       "GjB " ; store literal character data
                    fcb       $F6       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $47       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $45       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $A0       ; store byte data
Routine_001         pshs      x         ; save x on the stack
                    std       WorkWord_001,u ; store d at WorkWord_001,u
                    lda       #48       ; set a to the constant 48
                    sta       ,x        ; store a at ,x
                    sta       $01,x     ; store a at $01,x
                    sta       $02,x     ; store a at $02,x
                    sta       $03,x     ; store a at $03,x
                    sta       $04,x     ; store a at $04,x
                    ldd       #10000    ; set d to the constant 10000
                    std       WorkWord_002,u ; store d at WorkWord_002,u
                    ldd       WorkWord_001,u ; load d from WorkWord_001,u
                    lbsr      Routine_002 ; call subroutine Routine_002
                    ldd       #1000     ; set d to the constant 1000
                    std       WorkWord_002,u ; store d at WorkWord_002,u
                    ldd       WorkWord_001,u ; load d from WorkWord_001,u
                    bsr       Routine_002 ; call subroutine Routine_002
                    ldd       #100      ; set d to the constant 100
                    std       WorkWord_002,u ; store d at WorkWord_002,u
                    ldd       WorkWord_001,u ; load d from WorkWord_001,u
                    bsr       Routine_002 ; call subroutine Routine_002
                    ldd       #10       ; set d to the constant 10
                    std       WorkWord_002,u ; store d at WorkWord_002,u
                    ldd       WorkWord_001,u ; load d from WorkWord_001,u
                    bsr       Routine_002 ; call subroutine Routine_002
                    ldd       #1        ; set d to the constant 1
                    std       WorkWord_002,u ; store d at WorkWord_002,u
                    ldd       WorkWord_001,u ; load d from WorkWord_001,u
                    bsr       Routine_002 ; call subroutine Routine_002
                    lda       #13       ; set a to the constant 13
                    sta       ,x        ; store a at ,x
                    puls      x         ; restore x from the stack
                    ldb       #32       ; set b to the constant 32
Branch_011          lda       ,x        ; load a from ,x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bne       Branch_012 ; branch when the values differ or the result is nonzero; target Branch_012
                    stb       ,x+       ; store b at ,x+
                    bra       Branch_011 ; continue execution at Branch_011
Branch_012          lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       Branch_013 ; branch when carry reports an error or unsigned underflow; target Branch_013
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       Branch_013 ; branch when the unsigned value is higher; target Branch_013
                    bra       Branch_012 ; continue execution at Branch_012
Branch_013          leax      -$01,x    ; form the address -$01,x in x
                    rts                 ; return to the caller
Routine_002         subd      WorkWord_002,u ; subtract from d using WorkWord_002,u
                    bcs       Branch_014 ; branch when carry reports an error or unsigned underflow; target Branch_014
                    inc       ,x        ; increment the value at ,x
                    bra       Routine_002 ; continue execution at Routine_002
Branch_014          addd      WorkWord_002,u ; add to d using WorkWord_002,u
                    std       WorkWord_001,u ; store d at WorkWord_001,u
                    leax      $01,x     ; form the address $01,x in x
                    rts                 ; return to the caller
                    fcb       $CC       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $A0       ; store byte data

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
