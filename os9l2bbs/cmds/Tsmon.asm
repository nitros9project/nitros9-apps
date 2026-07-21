**********************************************************************
* Tsmon - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
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

U0000               rmb       1         ; reserve 1 byte(s) in the module workspace
U0001               rmb       1         ; reserve 1 byte(s) in the module workspace
U0002               rmb       1         ; reserve 1 byte(s) in the module workspace
U0003               rmb       1         ; reserve 1 byte(s) in the module workspace
U0004               rmb       1         ; reserve 1 byte(s) in the module workspace
U0005               rmb       1         ; reserve 1 byte(s) in the module workspace
U0006               rmb       2         ; reserve 2 byte(s) in the module workspace
U0008               rmb       32        ; reserve 32 byte(s) in the module workspace
U0028               rmb       1         ; reserve 1 byte(s) in the module workspace
U0029               rmb       599       ; reserve 599 byte(s) in the module workspace
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
L007D               fcc       "BBS.login" ; store literal character data
                    fcb       $0D       ; store byte data
L0083               fcc       "Monitor" ; store literal character data
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
L0160               fcc       "/Wb" ; store literal character data
                    fcb       $0D       ; store byte data
start               clr       U0003,u   ; clear U0003,u to zero and set the condition codes
                    stx       U0006,u   ; store x at U0006,u
L0168               lda       ,x+       ; load a from ,x+
                    cmpa      #45       ; compare a with #45 and set the condition codes
                    beq       L0174     ; branch when the values are equal or the result is zero; target L0174
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       L0168     ; branch when the values differ or the result is nonzero; target L0168
                    bra       L0182     ; continue execution at L0182
L0174               lda       ,x+       ; load a from ,x+
                    anda      #223      ; mask a using #223
                    cmpa      #77       ; compare a with #77 and set the condition codes
                    bne       L0182     ; branch when the values differ or the result is nonzero; target L0182
                    lda       #255      ; set a to the constant 255
                    sta       U0003,u   ; store a at U0003,u
                    stx       U0006,u   ; store x at U0006,u
L0182               leax      >L0160,pc ; form the address >L0160,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    leax      >L0320,pc ; form the address >L0320,pc in x
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
L01C0               ldx       U0006,u   ; load x from U0006,u
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    os9       I$Dup     ; invoke the OS-9 I$Dup service
                    os9       I$Dup     ; invoke the OS-9 I$Dup service
                    leax      >L0156,pc ; form the address >L0156,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    bcs       L020A     ; branch when carry reports an error or unsigned underflow; target L020A
L01D8               leax      <U0028,u  ; form the address <U0028,u in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    bcs       L0207     ; branch when carry reports an error or unsigned underflow; target L0207
                    pshs      a         ; save a on the stack
L01E6               lda       #1        ; set a to the constant 1
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lda       0,x       ; load a from 0,x
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L0203     ; branch when the values are equal or the result is zero; target L0203
                    leax      $01,x     ; form the address $01,x in x
                    pshs      x         ; save x on the stack
                    ldx       #5        ; set x to the constant 5
                    os9       F$Sleep   ; invoke the OS-9 F$Sleep service
                    puls      x         ; restore x from the stack
                    bra       L01E6     ; continue execution at L01E6
L0203               puls      a         ; restore a from the stack
                    bra       L01D8     ; continue execution at L01D8
L0207               os9       I$Close   ; invoke the OS-9 I$Close service
L020A               leax      U0008,u   ; form the address U0008,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    leax      -$20,x    ; form the address -$20,x in x
                    lda       #3        ; set a to the constant 3
                    sta       U0005,u   ; store a at U0005,u
                    sta       <$0035,x  ; store a at <$0035,x
                    clr       <$0024,x  ; clear <$0024,x to zero and set the condition codes
                    leax      U0008,u   ; form the address U0008,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$SetStt  ; invoke the OS-9 I$SetStt service
                    clr       U0004,u   ; clear U0004,u to zero and set the condition codes
L0227               dec       U0004,u   ; decrement the value at U0004,u
                    beq       L020A     ; branch when the values are equal or the result is zero; target L020A
                    ldx       #2        ; set x to the constant 2
                    os9       F$Sleep   ; invoke the OS-9 F$Sleep service
                    clra                ; clear a to zero and set the condition codes
                    ldb       #1        ; set b to the constant 1
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    bcs       L0227     ; branch when carry reports an error or unsigned underflow; target L0227
                    leax      U0000,u   ; form the address U0000,u in x
                    clr       0,x       ; clear 0,x to zero and set the condition codes
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    bcc       L0255     ; branch when carry is clear; target L0255
                    ldx       #10       ; set x to the constant 10
                    os9       F$Sleep   ; invoke the OS-9 F$Sleep service
                    lda       #1        ; set a to the constant 1
                    bsr       L0273     ; call subroutine L0273
                    clr       U0004,u   ; clear U0004,u to zero and set the condition codes
                    bra       L0227     ; continue execution at L0227
L0255               lda       U0000,u   ; load a from U0000,u
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L0283     ; branch when the values are equal or the result is zero; target L0283
                    clr       U0004,u   ; clear U0004,u to zero and set the condition codes
                    lda       U0005,u   ; load a from U0005,u
                    cmpa      #4        ; compare a with #4 and set the condition codes
                    beq       L026B     ; branch when the values are equal or the result is zero; target L026B
                    lda       #4        ; set a to the constant 4
                    sta       U0005,u   ; store a at U0005,u
                    bsr       L0273     ; call subroutine L0273
                    bra       L0227     ; continue execution at L0227
L026B               lda       #1        ; set a to the constant 1
                    sta       U0005,u   ; store a at U0005,u
                    bsr       L0273     ; call subroutine L0273
                    bra       L0227     ; continue execution at L0227
L0273               leax      U0008,u   ; form the address U0008,u in x
                    leax      -$20,x    ; form the address -$20,x in x
                    sta       <$0035,x  ; store a at <$0035,x
                    leax      U0008,u   ; form the address U0008,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$SetStt  ; invoke the OS-9 I$SetStt service
                    rts                 ; return to the caller
L0283               leax      U0008,u   ; form the address U0008,u in x
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
                    lbcs      L031A     ; branch when carry reports an error or unsigned underflow; target L031A
                    ldu       0,s       ; load u from the current stack frame at 0,s
                    sta       U0001,u   ; store a at U0001,u
                    lda       U0003,u   ; load a from U0003,u
                    bne       L02E9     ; branch when the values differ or the result is nonzero; target L02E9
                    leau      >L008B,pc ; form the workspace or data address >L008B,pc in u
                    leax      >L0083,pc ; form the address >L0083,pc in x
                    lda       #17       ; set a to the constant 17
                    os9       F$Fork    ; invoke the OS-9 F$Fork service
                    lbcs      L031A     ; branch when carry reports an error or unsigned underflow; target L031A
L02E9               puls      u         ; restore u from the stack
                    lbcs      L031A     ; branch when carry reports an error or unsigned underflow; target L031A
                    sta       U0002,u   ; store a at U0002,u
                    os9       F$Wait    ; invoke the OS-9 F$Wait service
                    pshs      a         ; save a on the stack
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    inca                ; increment a
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    inca                ; increment a
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    puls      a         ; restore a from the stack
                    cmpa      U0001,u   ; compare a with U0001,u and set the condition codes
                    bne       L0314     ; branch when the values differ or the result is nonzero; target L0314
                    ldx       #60       ; set x to the constant 60
                    os9       F$Sleep   ; invoke the OS-9 F$Sleep service
                    lda       U0002,u   ; load a from U0002,u
                    clrb                ; clear b to zero and set the condition codes
                    os9       F$Send    ; invoke the OS-9 F$Send service
L0314               os9       F$Wait    ; invoke the OS-9 F$Wait service
                    lbra      L01C0     ; continue execution at L01C0
L031A               os9       F$PErr    ; invoke the OS-9 F$PErr service
                    lbra      L01C0     ; continue execution at L01C0
L0320               fcb       $3B       ; store byte data

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
