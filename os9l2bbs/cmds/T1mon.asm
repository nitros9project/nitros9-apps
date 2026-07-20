**********************************************************************
* T1mon - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
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

U0000               rmb       1         ; reserve 1 byte(s) in the module workspace
U0001               rmb       2         ; reserve 2 byte(s) in the module workspace
U0003               rmb       1         ; reserve 1 byte(s) in the module workspace
U0004               rmb       1         ; reserve 1 byte(s) in the module workspace
U0005               rmb       1         ; reserve 1 byte(s) in the module workspace
U0006               rmb       2         ; reserve 2 byte(s) in the module workspace
U0008               rmb       32        ; reserve 32 byte(s) in the module workspace
U0028               rmb       1         ; reserve 1 byte(s) in the module workspace
U0029               rmb       599       ; reserve 599 byte(s) in the module workspace
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
L007D               fcc       "Login" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcc       "Monitor" ; store literal character data
                    fcb       $0D       ; store byte data
L008B               fcb       $0D       ; store byte data
                    fcb       $0A       ; store byte data
                    fcc       "Monitoring " ; store literal character data
L0098               fcc       "110  Baud 300  Baud 600  Baud 1200 Baud 2400 Baud " ; store literal character data
L00CA               fcc       "8 bits, no parity" ; store literal character data
                    fcb       $0D       ; store byte data
L00DC               fcc       "User name            Date                time" ; store literal character data
                    fcb       $0D       ; store byte data
L010A               fcc       "------------------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
L0153               fcb       $2F       ; store byte data
                    fcb       $70       ; store byte data
                    fcb       $0D       ; store byte data
L0156               fcc       "Modem.set" ; store literal character data
                    fcb       $0D       ; store byte data
start               clr       U0003,u   ; clear U0003,u to zero and set the condition codes
                    stx       U0006,u   ; store x at U0006,u
                    lda       #255      ; set a to the constant 255
                    sta       U0003,u   ; store a at U0003,u
                    leax      >L0284,pc ; form the address >L0284,pc in x
                    os9       F$Icpt    ; invoke the OS-9 F$Icpt service
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    inca                ; increment a
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    inca                ; increment a
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    leax      >L0153,pc ; form the address >L0153,pc in x
                    lda       #2        ; set a to the constant 2
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    leax      >L00DC,pc ; form the address >L00DC,pc in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L010A,pc ; form the address >L010A,pc in x
                    ldy       #80       ; set y to the constant 80
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    os9       I$Close   ; invoke the OS-9 I$Close service
L019D               ldx       U0006,u   ; load x from U0006,u
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L027E     ; branch when carry reports an error or unsigned underflow; target L027E
                    os9       I$Dup     ; invoke the OS-9 I$Dup service
                    os9       I$Dup     ; invoke the OS-9 I$Dup service
                    leax      >L0156,pc ; form the address >L0156,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    bcs       L01D7     ; branch when carry reports an error or unsigned underflow; target L01D7
L01B9               leax      <U0028,u  ; form the address <U0028,u in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    bcs       L01D4     ; branch when carry reports an error or unsigned underflow; target L01D4
                    pshs      a         ; save a on the stack
                    lda       #1        ; set a to the constant 1
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    puls      a         ; restore a from the stack
                    bra       L01B9     ; continue execution at L01B9
L01D4               os9       I$Close   ; invoke the OS-9 I$Close service
L01D7               leax      U0008,u   ; form the address U0008,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    leax      -$20,x    ; form the address -$20,x in x
                    lda       #1        ; set a to the constant 1
                    sta       U0005,u   ; store a at U0005,u
                    sta       <$0035,x  ; store a at <$0035,x
                    clr       <$0024,x  ; clear <$0024,x to zero and set the condition codes
                    leax      U0008,u   ; form the address U0008,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$SetStt  ; invoke the OS-9 I$SetStt service
                    clr       U0004,u   ; clear U0004,u to zero and set the condition codes
L01F4               leax      U0000,u   ; form the address U0000,u in x
                    clr       0,x       ; clear 0,x to zero and set the condition codes
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    bcc       L020A     ; branch when carry is clear; target L020A
                    ldx       #10       ; set x to the constant 10
                    os9       F$Sleep   ; invoke the OS-9 F$Sleep service
                    bra       L01F4     ; continue execution at L01F4
L020A               lda       U0000,u   ; load a from U0000,u
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L0212     ; branch when the values are equal or the result is zero; target L0212
                    bra       L01F4     ; continue execution at L01F4
L0212               leax      U0008,u   ; form the address U0008,u in x
                    leax      -$20,x    ; form the address -$20,x in x
                    lda       #1        ; set a to the constant 1
                    sta       <$0024,x  ; store a at <$0024,x
                    leax      U0008,u   ; form the address U0008,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$SetStt  ; invoke the OS-9 I$SetStt service
                    leax      -$20,x    ; form the address -$20,x in x
                    ldb       <$0035,x  ; load b from <$0035,x
                    lda       #10       ; set a to the constant 10
                    mul                 ; multiply a by b and return the product in d
                    leax      >L0098,pc ; form the address >L0098,pc in x
                    leax      d,x       ; form the address d,x in x
                    ldy       #10       ; set y to the constant 10
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      >L00CA,pc ; form the address >L00CA,pc in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L007D,pc ; form the address >L007D,pc in x
                    ldy       #1        ; set y to the constant 1
                    pshs      u         ; save u on the stack
                    leau      >L008B,pc ; form the workspace or data address >L008B,pc in u
                    lda       #17       ; set a to the constant 17
                    ldb       #3        ; set b to the constant 3
                    os9       F$Fork    ; invoke the OS-9 F$Fork service
                    lbcs      L027E     ; branch when carry reports an error or unsigned underflow; target L027E
                    ldu       0,s       ; load u from the current stack frame at 0,s
                    sta       U0001,u   ; store a at U0001,u
                    puls      u         ; restore u from the stack
                    os9       F$Wait    ; invoke the OS-9 F$Wait service
                    lbcs      L027E     ; branch when carry reports an error or unsigned underflow; target L027E
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    inca                ; increment a
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    inca                ; increment a
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    os9       F$Wait    ; invoke the OS-9 F$Wait service
                    lbra      L019D     ; continue execution at L019D
L027E               os9       F$PErr    ; invoke the OS-9 F$PErr service
                    lbra      L019D     ; continue execution at L019D
L0284               rti                 ; restore the interrupt frame and return

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
