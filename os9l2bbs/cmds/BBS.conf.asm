**********************************************************************
* BBS.conf - OS-9 Level 2 BBS command
*
* Syntax: BBS.conf
* Purpose: Join conference mode and exchange characters with other participants.
* Shared state: Conf.dat participant records and character slots.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       BBS.conf
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

WorkWord_001        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_002        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_003        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_004        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_005        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_006        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_001      rmb       200       ; reserve 200 byte(s) in the module workspace
buffer              rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_002      rmb       419       ; reserve 419 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.conf/ ; store an OS-9 high-bit-terminated string
confdat             fcc       "Conf.dat" ; store literal character data
Data_001            fcb       $0D       ; store byte data
                    fcb       $0A       ; store byte data
handle              fcc       "Enter your handle:" ; store literal character data
prompt              fcc       "Press <CTRL><Z> to exit         <CTRL><X> who's in conf mode" ; store literal character data
                    fcb       $0D       ; store byte data
line                fcc       "------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
confwho             fcc       "BBS.conf.who" ; store literal character data
                    fcb       $0D       ; store byte data

Icpt                ldx       WorkWord_004,u ; load x from WorkWord_004,u
Branch_001          ldd       ,x++      ; load d from ,x++
                    leax      $01,x     ; form the address $01,x in x
                    cmpd      WorkWord_002,u ; compare d with WorkWord_002,u and set the condition codes
                    bne       Branch_001 ; branch when the values differ or the result is nonzero; target Branch_001
                    leax      -$03,x    ; form the address -$03,x in x
                    clr       ,x        ; clear ,x to zero and set the condition codes
                    clr       $01,x     ; clear $01,x to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      u         ; save u on the stack
                    ldu       WorkWord_003,u ; load u from WorkWord_003,u
                    os9       F$UnLink  ; release the linked module at U
                    puls      u         ; restore u from the stack
                    clrb                ; clear b to zero and set the condition codes
                    os9       F$Exit    ; terminate the process with status B
                    fcb       $3B       ; store byte data

start               leax      >Icpt,pc  ; form the address >Icpt,pc in x
                    os9       F$Icpt    ; install the signal-intercept routine at X
                    os9       F$ID      ; retrieve the current process and user IDs
                    leay      $01,y     ; form the address $01,y in y
                    sty       WorkWord_002,u ; store y at WorkWord_002,u
                    leax      >handle,pc ; form the address >handle,pc in x
                    ldy       #18       ; set y to the constant 18
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    clra                ; clear a to zero and set the condition codes
                    leax      >buffer,u ; form the address >buffer,u in x
                    ldy       #20       ; set y to the constant 20
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    leax      >prompt,pc ; form the address >prompt,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >line,pc  ; form the address >line,pc in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >confdat,pc ; form the address >confdat,pc in x
                    lda       #65       ; set a to the constant 65
                    pshs      u         ; save u on the stack
                    os9       F$Link    ; link the module named at X
                    bcc       Branch_002 ; branch when carry is clear; target Branch_002
                    cmpb      #221      ; compare b with #221 and set the condition codes
                    lbne      Branch_003 ; branch when the values differ or the result is nonzero; target Branch_003
                    os9       F$Load    ; load the module file named at X
                    lbcs      Branch_003 ; branch when carry reports an error or unsigned underflow; target Branch_003
Branch_002          tfr       u,d       ; copy the register values specified by u,d
                    puls      u         ; restore u from the stack
                    std       WorkWord_003,u ; store d at WorkWord_003,u
                    sty       WorkWord_004,u ; store y at WorkWord_004,u
                    leax      WorkBuffer_001,u ; form the address WorkBuffer_001,u in x
                    stx       WorkWord_005,u ; store x at WorkWord_005,u
                    stx       WorkWord_006,u ; store x at WorkWord_006,u
Branch_004          ldd       ,y        ; load d from ,y
                    beq       Branch_005 ; branch when the values are equal or the result is zero; target Branch_005
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    beq       Branch_005 ; branch when the values are equal or the result is zero; target Branch_005
                    leay      $03,y     ; form the address $03,y in y
                    bra       Branch_004 ; continue execution at Branch_004
Branch_005          ldd       WorkWord_002,u ; load d from WorkWord_002,u
                    std       ,y++      ; store d at ,y++
                    lda       #1        ; set a to the constant 1
                    sta       ,y        ; store a at ,y
Branch_006          lbsr      Code_001  ; call subroutine Code_001
                    lbsr      Routine_001 ; call subroutine Routine_001
                    bra       Branch_006 ; continue execution at Branch_006
Code_001            ldx       WorkWord_004,u ; load x from WorkWord_004,u
Branch_007          ldd       ,x++      ; load d from ,x++
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    lbeq      Branch_008 ; branch when the values are equal or the result is zero; target Branch_008
                    cmpd      WorkWord_002,u ; compare d with WorkWord_002,u and set the condition codes
                    beq       Branch_009 ; branch when the values are equal or the result is zero; target Branch_009
                    leax      $01,x     ; form the address $01,x in x
                    bra       Branch_007 ; continue execution at Branch_007
Branch_009          lda       ,x+       ; load a from ,x+
                    beq       Branch_010 ; branch when the values are equal or the result is zero; target Branch_010
                    rts                 ; return to the caller
Branch_010          lda       #1        ; set a to the constant 1
                    sta       -$01,x    ; store a at -$01,x
                    leax      >Data_001,pc ; form the address >Data_001,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    ldx       WorkWord_004,u ; load x from WorkWord_004,u
                    leax      >$0104,x  ; form the address >$0104,x in x
                    clrb                ; clear b to zero and set the condition codes
Branch_011          lda       ,x+       ; load a from ,x+
                    incb                ; increment b
                    cmpa      #58       ; compare a with #58 and set the condition codes
                    beq       Branch_012 ; branch when the values are equal or the result is zero; target Branch_012
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       Branch_011 ; branch when the values differ or the result is nonzero; target Branch_011
Branch_012          lda       #58       ; set a to the constant 58
                    sta       -$01,x    ; store a at -$01,x
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    ldx       WorkWord_004,u ; load x from WorkWord_004,u
                    leax      >$0104,x  ; form the address >$0104,x in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    ldx       WorkWord_004,u ; load x from WorkWord_004,u
                    leax      <$003C,x  ; form the address <$003C,x in x
                    lda       #1        ; set a to the constant 1
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      WorkBuffer_001,u ; form the address WorkBuffer_001,u in x
                    stx       WorkWord_001,u ; store x at WorkWord_001,u
                    ldd       WorkWord_005,u ; load d from WorkWord_005,u
                    subd      WorkWord_001,u ; subtract from d using WorkWord_001,u
                    tfr       d,y       ; copy the register values specified by d,y
                    leax      WorkBuffer_001,u ; form the address WorkBuffer_001,u in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    rts                 ; return to the caller
Branch_008          ldb       #1        ; set b to the constant 1
                    lbra      Branch_003 ; continue execution at Branch_003
Routine_001         clra                ; clear a to zero and set the condition codes
                    ldb       #1        ; set b to the constant 1
                    os9       I$GetStt  ; query status code B for path A
                    bcs       Branch_013 ; branch when carry reports an error or unsigned underflow; target Branch_013
                    ldy       #1        ; set y to the constant 1
                    ldx       WorkWord_005,u ; load x from WorkWord_005,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lda       ,x+       ; load a from ,x+
                    cmpa      #8        ; compare a with #8 and set the condition codes
                    beq       Branch_014 ; branch when the values are equal or the result is zero; target Branch_014
                    cmpa      #26       ; compare a with #26 and set the condition codes
                    lbeq      Branch_015 ; branch when the values are equal or the result is zero; target Branch_015
                    cmpa      #24       ; compare a with #24 and set the condition codes
                    lbeq      Branch_016 ; branch when the values are equal or the result is zero; target Branch_016
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_017 ; branch when the values are equal or the result is zero; target Branch_017
                    leay      >buffer,u ; form the address >buffer,u in y
                    sty       WorkWord_001,u ; store y at WorkWord_001,u
                    cmpx      WorkWord_001,u ; compare x with WorkWord_001,u and set the condition codes
                    lbeq      Branch_013 ; branch when the values are equal or the result is zero; target Branch_013
                    stx       WorkWord_005,u ; store x at WorkWord_005,u
                    bra       Branch_018 ; continue execution at Branch_018
Branch_017          leax      >Data_001,pc ; form the address >Data_001,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    ldx       WorkWord_004,u ; load x from WorkWord_004,u
                    leax      <$003C,x  ; form the address <$003C,x in x
                    leay      WorkBuffer_001,u ; form the address WorkBuffer_001,u in y
                    sty       WorkWord_005,u ; store y at WorkWord_005,u
                    ldb       #255      ; set b to the constant 255
Branch_019          lda       ,y+       ; load a from ,y+
                    sta       ,x+       ; store a at ,x+
                    decb                ; decrement b
                    bne       Branch_019 ; branch when the values differ or the result is nonzero; target Branch_019
                    lda       #58       ; set a to the constant 58
                    sta       ,x+       ; store a at ,x+
                    ldx       WorkWord_004,u ; load x from WorkWord_004,u
Branch_020          ldd       ,x++      ; load d from ,x++
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    beq       Branch_013 ; branch when the values are equal or the result is zero; target Branch_013
                    clr       ,x+       ; clear ,x+ to zero and set the condition codes
                    bra       Branch_020 ; continue execution at Branch_020
Branch_013          clra                ; clear a to zero and set the condition codes
Branch_018          rts                 ; return to the caller
Branch_014          leax      -$02,x    ; form the address -$02,x in x
                    cmpx      WorkWord_006,u ; compare x with WorkWord_006,u and set the condition codes
                    bls       Branch_021 ; branch when the unsigned value is lower or equal; target Branch_021
                    stx       WorkWord_005,u ; store x at WorkWord_005,u
Branch_021          rts                 ; return to the caller
Branch_015          ldx       WorkWord_004,u ; load x from WorkWord_004,u
Branch_022          ldd       ,x++      ; load d from ,x++
                    leax      $01,x     ; form the address $01,x in x
                    cmpd      WorkWord_002,u ; compare d with WorkWord_002,u and set the condition codes
                    bne       Branch_022 ; branch when the values differ or the result is nonzero; target Branch_022
                    leax      -$03,x    ; form the address -$03,x in x
                    clr       ,x        ; clear ,x to zero and set the condition codes
                    clr       $01,x     ; clear $01,x to zero and set the condition codes
                    pshs      u         ; save u on the stack
                    ldu       WorkWord_003,u ; load u from WorkWord_003,u
                    os9       F$UnLink  ; release the linked module at U
                    puls      u         ; restore u from the stack
                    clrb                ; clear b to zero and set the condition codes
Branch_003          os9       F$Exit    ; terminate the process with status B
Branch_016          lda       #17       ; set a to the constant 17
                    ldb       #3        ; set b to the constant 3
                    ldy       #1        ; set y to the constant 1
                    leax      >confwho,pc ; form the address >confwho,pc in x
                    pshs      u         ; save u on the stack
                    leau      >Data_001,pc ; form the workspace or data address >Data_001,pc in u
                    os9       F$Fork    ; spawn the module at X with parameters at U
                    os9       F$Wait    ; wait for a child process to terminate
                    puls      u         ; restore u from the stack
                    rts                 ; return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
