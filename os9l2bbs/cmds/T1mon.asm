**********************************************************************
* T1mon - OS-9 Level 2 BBS command
*
* Syntax: T1mon
* Purpose: Provide limited low-speed monitoring for the CoCo 3 internal serial port.
* Not reliable for chat, conference, upload, or download.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       T1mon
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
WorkByte_004        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_002        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_001      rmb       32        ; reserve 32 byte(s) in the module workspace
WorkByte_005        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_002      rmb       599       ; reserve 599 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /T1mon/ ; store an OS-9 high-bit-terminated string
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
                    fcc       "Monitor" ; store literal character data
                    fcb       $0D       ; store byte data
Data_001            fcb       $0D       ; store byte data
                    fcb       $0A       ; store byte data
                    fcc       "Monitoring " ; store literal character data
Text_002            fcc       "110  Baud 300  Baud 600  Baud 1200 Baud 2400 Baud " ; store literal character data
Text_003            fcc       "8 bits, no parity" ; store literal character data
                    fcb       $0D       ; store byte data
Text_004            fcc       "User name            Date                time" ; store literal character data
                    fcb       $0D       ; store byte data
Text_005            fcc       "------------------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
Data_002            fcb       $2F       ; store byte data
                    fcb       $70       ; store byte data
                    fcb       $0D       ; store byte data
Text_006            fcc       "Modem.set" ; store literal character data
                    fcb       $0D       ; store byte data
start               clr       WorkByte_002,u ; clear WorkByte_002,u to zero and set the condition codes
                    stx       WorkWord_002,u ; store x at WorkWord_002,u
                    lda       #255      ; set a to the constant 255
                    sta       WorkByte_002,u ; store a at WorkByte_002,u
                    leax      >Code_001,pc ; form the address >Code_001,pc in x
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
                    leax      >Text_004,pc ; form the address >Text_004,pc in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Text_005,pc ; form the address >Text_005,pc in x
                    ldy       #80       ; set y to the constant 80
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    os9       I$Close   ; close path A
Branch_001          ldx       WorkWord_002,u ; load x from WorkWord_002,u
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    os9       I$Dup     ; duplicate path A into the next free path number
                    os9       I$Dup     ; duplicate path A into the next free path number
                    leax      >Text_006,pc ; form the address >Text_006,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    bcs       Branch_003 ; branch when carry reports an error or unsigned underflow; target Branch_003
Branch_004          leax      <WorkByte_005,u ; form the address <WorkByte_005,u in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    bcs       Branch_005 ; branch when carry reports an error or unsigned underflow; target Branch_005
                    pshs      a         ; save a on the stack
                    lda       #1        ; set a to the constant 1
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    puls      a         ; restore a from the stack
                    bra       Branch_004 ; continue execution at Branch_004
Branch_005          os9       I$Close   ; close path A
Branch_003          leax      WorkBuffer_001,u ; form the address WorkBuffer_001,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$GetStt  ; query status code B for path A
                    leax      -$20,x    ; form the address -$20,x in x
                    lda       #1        ; set a to the constant 1
                    sta       WorkByte_004,u ; store a at WorkByte_004,u
                    sta       <$0035,x  ; store a at <$0035,x
                    clr       <$0024,x  ; clear <$0024,x to zero and set the condition codes
                    leax      WorkBuffer_001,u ; form the address WorkBuffer_001,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$SetStt  ; apply status operation B to path A
                    clr       WorkByte_003,u ; clear WorkByte_003,u to zero and set the condition codes
Branch_006          leax      WorkByte_001,u ; form the address WorkByte_001,u in x
                    clr       ,x        ; clear ,x to zero and set the condition codes
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcc       Branch_007 ; branch when carry is clear; target Branch_007
                    ldx       #10       ; set x to the constant 10
                    os9       F$Sleep   ; sleep for the number of ticks in X
                    bra       Branch_006 ; continue execution at Branch_006
Branch_007          lda       WorkByte_001,u ; load a from WorkByte_001,u
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_008 ; branch when the values are equal or the result is zero; target Branch_008
                    bra       Branch_006 ; continue execution at Branch_006
Branch_008          leax      WorkBuffer_001,u ; form the address WorkBuffer_001,u in x
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
                    leax      >Text_002,pc ; form the address >Text_002,pc in x
                    leax      d,x       ; form the address d,x in x
                    ldy       #10       ; set y to the constant 10
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >Text_003,pc ; form the address >Text_003,pc in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Text_001,pc ; form the address >Text_001,pc in x
                    ldy       #1        ; set y to the constant 1
                    pshs      u         ; save u on the stack
                    leau      >Data_001,pc ; form the workspace or data address >Data_001,pc in u
                    lda       #17       ; set a to the constant 17
                    ldb       #3        ; set b to the constant 3
                    os9       F$Fork    ; spawn the module at X with parameters at U
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    ldu       ,s        ; load u from the current stack frame at ,s
                    sta       WorkWord_001,u ; store a at WorkWord_001,u
                    puls      u         ; restore u from the stack
                    os9       F$Wait    ; wait for a child process to terminate
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Close   ; close path A
                    inca                ; increment a
                    os9       I$Close   ; close path A
                    inca                ; increment a
                    os9       I$Close   ; close path A
                    os9       F$Wait    ; wait for a child process to terminate
                    lbra      Branch_001 ; continue execution at Branch_001
Branch_002          os9       F$PErr    ; print the error message for status B
                    lbra      Branch_001 ; continue execution at Branch_001
Code_001            rti                 ; restore the interrupt frame and return

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
