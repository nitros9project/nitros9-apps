**********************************************************************
* Tsmon - OS-9 Level 2 BBS command
*
* Syntax: Tsmon [-m] <port>
* Purpose: Detect caller baud, initialize the modem, and start BBS.login plus Monitor.
* Cycles 300/1200/2400 baud and sends modem.set at session boundaries.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       Tsmon
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
WorkWord_001        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_001      rmb       32        ; reserve 32 byte(s) in the module workspace
WorkByte_007        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_002      rmb       599       ; reserve 599 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /Tsmon/ ; store an OS-9 high-bit-terminated string
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
Text_001            fcc       "BBS.login" ; BBS-specific login module forked for the caller
                    fcb       $0D       ; store byte data
Text_002            fcc       "Monitor" ; store literal character data
                    fcb       $0D       ; store byte data
Data_001            fcb       $0D       ; store byte data
                    fcb       $0A       ; store byte data
                    fcc       "Monitoring " ; store literal character data
Text_003            fcc       "110  Baud 300  Baud 600  Baud 1200 Baud 2400 Baud " ; store literal character data
Text_004            fcc       "8 bits, no parity" ; store literal character data
                    fcb       $0D       ; store byte data
Text_005            fcc       "User name            Date                time" ; store literal character data
                    fcb       $0D       ; store byte data
Text_006            fcc       "------------------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
Data_002            fcb       $2F       ; store byte data
                    fcb       $70       ; store byte data
                    fcb       $0D       ; store byte data
Text_007            fcc       "Modem.set" ; store literal character data
                    fcb       $0D       ; store byte data
Text_008            fcc       "/Wb" ; store literal character data
                    fcb       $0D       ; store byte data
start               clr       WorkByte_004,u ; clear WorkByte_004,u to zero and set the condition codes
                    stx       WorkWord_001,u ; store x at WorkWord_001,u
Branch_001          lda       ,x+       ; load a from ,x+
                    cmpa      #45       ; compare a with #45 and set the condition codes
                    beq       Branch_002 ; branch when the values are equal or the result is zero; target Branch_002
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       Branch_001 ; branch when the values differ or the result is nonzero; target Branch_001
                    bra       Branch_003 ; continue execution at Branch_003
Branch_002          lda       ,x+       ; load a from ,x+
                    anda      #223      ; mask a using #223
                    cmpa      #77       ; compare a with #77 and set the condition codes
                    bne       Branch_003 ; branch when the values differ or the result is nonzero; target Branch_003
                    lda       #255      ; set a to the constant 255
                    sta       WorkByte_004,u ; store a at WorkByte_004,u
                    stx       WorkWord_001,u ; store x at WorkWord_001,u
Branch_003          leax      >Text_008,pc ; form the address >Text_008,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    leax      >Data_003,pc ; form the address >Data_003,pc in x
                    os9       F$Icpt    ; install the signal-intercept routine at X
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Close   ; close path A
                    inca                ; increment a
                    os9       I$Close   ; close path A
                    inca                ; increment a
                    os9       I$Close   ; close path A
                    leax      >Data_002,pc ; form the address >Data_002,pc in x
                    lda       #2        ; set a to the constant 2
                    os9       I$Open    ; open the path at X using access mode A
                    leax      >Text_005,pc ; form the address >Text_005,pc in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Text_006,pc ; form the address >Text_006,pc in x
                    ldy       #80       ; set y to the constant 80
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    os9       I$Close   ; close path A
Branch_004          ldx       WorkWord_001,u ; load x from WorkWord_001,u
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    os9       I$Dup     ; duplicate path A into the next free path number
                    os9       I$Dup     ; duplicate path A into the next free path number
                    leax      >Text_007,pc ; form the address >Text_007,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    bcs       Branch_005 ; branch when carry reports an error or unsigned underflow; target Branch_005
Branch_006          leax      <WorkByte_007,u ; form the address <WorkByte_007,u in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    bcs       Branch_007 ; branch when carry reports an error or unsigned underflow; target Branch_007
                    pshs      a         ; save a on the stack
Branch_008          lda       #1        ; set a to the constant 1
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    lda       ,x        ; load a from ,x
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_009 ; branch when the values are equal or the result is zero; target Branch_009
                    leax      $01,x     ; form the address $01,x in x
                    pshs      x         ; save x on the stack
                    ldx       #5        ; set x to the constant 5
                    os9       F$Sleep   ; sleep for the number of ticks in X
                    puls      x         ; restore x from the stack
                    bra       Branch_008 ; continue execution at Branch_008
Branch_009          puls      a         ; restore a from the stack
                    bra       Branch_006 ; continue execution at Branch_006
Branch_007          os9       I$Close   ; close path A
Branch_005          leax      WorkBuffer_001,u ; form the address WorkBuffer_001,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$GetStt  ; query status code B for path A
                    leax      -$20,x    ; form the address -$20,x in x
                    lda       #3        ; set a to the constant 3
                    sta       WorkByte_006,u ; store a at WorkByte_006,u
                    sta       <$0035,x  ; store a at <$0035,x
                    clr       <$0024,x  ; clear <$0024,x to zero and set the condition codes
                    leax      WorkBuffer_001,u ; form the address WorkBuffer_001,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$SetStt  ; apply status operation B to path A
                    clr       WorkByte_005,u ; clear WorkByte_005,u to zero and set the condition codes
Branch_010          dec       WorkByte_005,u ; decrement the value at WorkByte_005,u
                    beq       Branch_005 ; branch when the values are equal or the result is zero; target Branch_005
                    ldx       #2        ; set x to the constant 2
                    os9       F$Sleep   ; sleep for the number of ticks in X
                    clra                ; clear a to zero and set the condition codes
                    ldb       #1        ; set b to the constant 1
                    os9       I$GetStt  ; query status code B for path A
                    bcs       Branch_010 ; branch when carry reports an error or unsigned underflow; target Branch_010
                    leax      WorkByte_001,u ; form the address WorkByte_001,u in x
                    clr       ,x        ; clear ,x to zero and set the condition codes
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcc       Branch_011 ; branch when carry is clear; target Branch_011
                    ldx       #10       ; set x to the constant 10
                    os9       F$Sleep   ; sleep for the number of ticks in X
                    lda       #1        ; set a to the constant 1
                    bsr       Routine_001 ; call subroutine Routine_001
                    clr       WorkByte_005,u ; clear WorkByte_005,u to zero and set the condition codes
                    bra       Branch_010 ; continue execution at Branch_010
Branch_011          lda       WorkByte_001,u ; load a from WorkByte_001,u
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_012 ; branch when the values are equal or the result is zero; target Branch_012
                    clr       WorkByte_005,u ; clear WorkByte_005,u to zero and set the condition codes
                    lda       WorkByte_006,u ; load a from WorkByte_006,u
                    cmpa      #4        ; compare a with #4 and set the condition codes
                    beq       Branch_013 ; branch when the values are equal or the result is zero; target Branch_013
                    lda       #4        ; set a to the constant 4
                    sta       WorkByte_006,u ; store a at WorkByte_006,u
                    bsr       Routine_001 ; call subroutine Routine_001
                    bra       Branch_010 ; continue execution at Branch_010
Branch_013          lda       #1        ; set a to the constant 1
                    sta       WorkByte_006,u ; store a at WorkByte_006,u
                    bsr       Routine_001 ; call subroutine Routine_001
                    bra       Branch_010 ; continue execution at Branch_010
Routine_001         leax      WorkBuffer_001,u ; form the address WorkBuffer_001,u in x
                    leax      -$20,x    ; form the address -$20,x in x
                    sta       <$0035,x  ; store a at <$0035,x
                    leax      WorkBuffer_001,u ; form the address WorkBuffer_001,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$SetStt  ; apply status operation B to path A
                    rts                 ; return to the caller
Branch_012          leax      WorkBuffer_001,u ; form the address WorkBuffer_001,u in x
                    leax      -$20,x    ; form the address -$20,x in x
                    lda       #1        ; set a to the constant 1
                    sta       <$0024,x  ; store a at <$0024,x
                    leax      WorkBuffer_001,u ; form the address WorkBuffer_001,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$SetStt  ; apply status operation B to path A
                    leax      -$20,x    ; form the address -$20,x in x
                    ldb       <$0035,x  ; load b from <$0035,x
                    lda       #10       ; set a to the constant 10
                    mul                 ; multiply a by b and return the product in d
                    leax      >Text_003,pc ; form the address >Text_003,pc in x
                    leax      d,x       ; form the address d,x in x
                    ldy       #10       ; set y to the constant 10
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >Text_004,pc ; form the address >Text_004,pc in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Text_001,pc ; form the address >Text_001,pc in x
                    ldy       #1        ; set y to the constant 1
                    pshs      u         ; save u on the stack
                    leau      >Data_001,pc ; form the workspace or data address >Data_001,pc in u
                    lda       #17       ; set a to the constant 17
                    ldb       #3        ; set b to the constant 3
                    os9       F$Fork    ; spawn the module at X with parameters at U
                    lbcs      Branch_014 ; branch when carry reports an error or unsigned underflow; target Branch_014
                    ldu       ,s        ; load u from the current stack frame at ,s
                    sta       WorkByte_002,u ; store a at WorkByte_002,u
                    lda       WorkByte_004,u ; load a from WorkByte_004,u
                    bne       Branch_015 ; branch when the values differ or the result is nonzero; target Branch_015
                    leau      >Data_001,pc ; form the workspace or data address >Data_001,pc in u
                    leax      >Text_002,pc ; form the address >Text_002,pc in x
                    lda       #17       ; set a to the constant 17
                    os9       F$Fork    ; spawn the module at X with parameters at U
                    lbcs      Branch_014 ; branch when carry reports an error or unsigned underflow; target Branch_014
Branch_015          puls      u         ; restore u from the stack
                    lbcs      Branch_014 ; branch when carry reports an error or unsigned underflow; target Branch_014
                    sta       WorkByte_003,u ; store a at WorkByte_003,u
                    os9       F$Wait    ; wait for a child process to terminate
                    pshs      a         ; save a on the stack
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Close   ; close path A
                    inca                ; increment a
                    os9       I$Close   ; close path A
                    inca                ; increment a
                    os9       I$Close   ; close path A
                    puls      a         ; restore a from the stack
                    cmpa      WorkByte_002,u ; compare a with WorkByte_002,u and set the condition codes
                    bne       Branch_016 ; branch when the values differ or the result is nonzero; target Branch_016
                    ldx       #60       ; set x to the constant 60
                    os9       F$Sleep   ; sleep for the number of ticks in X
                    lda       WorkByte_003,u ; load a from WorkByte_003,u
                    clrb                ; clear b to zero and set the condition codes
                    os9       F$Send    ; send signal B to process A
Branch_016          os9       F$Wait    ; wait for a child process to terminate
                    lbra      Branch_004 ; continue execution at Branch_004
Branch_014          os9       F$PErr    ; print the error message for status B
                    lbra      Branch_004 ; continue execution at Branch_004
Data_003            fcb       $3B       ; store byte data

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
