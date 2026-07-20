**********************************************************************
* Monitor - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       Monitor
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
U0004               rmb       2         ; reserve 2 byte(s) in the module workspace
U0006               rmb       2         ; reserve 2 byte(s) in the module workspace
U0008               rmb       32        ; reserve 32 byte(s) in the module workspace
U0028               rmb       255       ; reserve 255 byte(s) in the module workspace
U0127               rmb       1         ; reserve 1 byte(s) in the module workspace
U0128               rmb       1         ; reserve 1 byte(s) in the module workspace
U0129               rmb       711       ; reserve 711 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /Monitor/ ; store an OS-9 high-bit-terminated string
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
start               lda       0,x       ; load a from 0,x
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L00A0     ; branch when the values are equal or the result is zero; target L00A0
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    inca                ; increment a
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    inca                ; increment a
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L0106     ; branch when carry reports an error or unsigned underflow; target L0106
                    os9       I$Dup     ; invoke the OS-9 I$Dup service
                    os9       I$Dup     ; invoke the OS-9 I$Dup service
L00A0               clra                ; clear a to zero and set the condition codes
                    ldb       #14       ; set b to the constant 14
                    leax      U0008,u   ; form the address U0008,u in x
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    lbcs      L0106     ; branch when carry reports an error or unsigned underflow; target L0106
                    lda       #241      ; set a to the constant 241
                    pshs      u         ; save u on the stack
                    os9       F$Link    ; invoke the OS-9 F$Link service
                    lbcs      L0106     ; branch when carry reports an error or unsigned underflow; target L0106
                    tfr       u,y       ; copy the register values specified by u,y
                    puls      u         ; restore u from the stack
                    ldx       $0F,y     ; load x from $0F,y
                    leax      $01,x     ; form the address $01,x in x
                    stx       U0004,u   ; store x at U0004,u
L00C1               ldx       #1        ; set x to the constant 1
                    os9       F$Sleep   ; invoke the OS-9 F$Sleep service
                    ldx       U0004,u   ; load x from U0004,u
                    lda       0,x       ; load a from 0,x
                    bita      #32       ; test selected bits in a using #32
                    beq       L00C1     ; branch when the values are equal or the result is zero; target L00C1
                    os9       F$ID      ; invoke the OS-9 F$ID service
                    sta       U0002,u   ; store a at U0002,u
                    leax      >U0127,u  ; form the address >U0127,u in x
                    os9       F$GPrDsc  ; invoke the OS-9 F$GPrDsc service
                    lda       >U0128,u  ; load a from >U0128,u
                    sta       U0000,u   ; store a at U0000,u
                    lda       #255      ; set a to the constant 255
                    sta       U0001,u   ; store a at U0001,u
                    clr       U0003,u   ; clear U0003,u to zero and set the condition codes
                    leax      <U0028,u  ; form the address <U0028,u in x
                    stx       U0006,u   ; store x at U0006,u
L00EC               lda       U0001,u   ; load a from U0001,u
L00EE               leax      >U0127,u  ; form the address >U0127,u in x
                    os9       F$GPrDsc  ; invoke the OS-9 F$GPrDsc service
                    bcs       L0117     ; branch when carry reports an error or unsigned underflow; target L0117
                    lda       >U0128,u  ; load a from >U0128,u
                    cmpa      U0000,u   ; compare a with U0000,u and set the condition codes
                    beq       L0109     ; branch when the values are equal or the result is zero; target L0109
                    cmpa      #0        ; compare a with #0 and set the condition codes
                    beq       L0117     ; branch when the values are equal or the result is zero; target L0117
                    bra       L00EE     ; continue execution at L00EE
L0105               clrb                ; clear b to zero and set the condition codes
L0106               os9       F$Exit    ; invoke the OS-9 F$Exit service
L0109               lda       U0001,u   ; load a from U0001,u
                    cmpa      U0002,u   ; compare a with U0002,u and set the condition codes
                    beq       L0117     ; branch when the values are equal or the result is zero; target L0117
                    ldx       U0006,u   ; load x from U0006,u
                    sta       ,x+       ; store a at ,x+
                    stx       U0006,u   ; store x at U0006,u
                    inc       U0003,u   ; increment the value at U0003,u
L0117               dec       U0001,u   ; decrement the value at U0001,u
                    cmpa      #3        ; compare a with #3 and set the condition codes
                    beq       L011F     ; branch when the values are equal or the result is zero; target L011F
                    bra       L00EC     ; continue execution at L00EC
L011F               leax      <U0028,u  ; form the address <U0028,u in x
L0122               tst       U0003,u   ; set condition codes from U0003,u without changing it
                    lbeq      L0105     ; branch when the values are equal or the result is zero; target L0105
                    dec       U0003,u   ; decrement the value at U0003,u
                    lda       ,x+       ; load a from ,x+
                    clrb                ; clear b to zero and set the condition codes
L012D               os9       F$Send    ; invoke the OS-9 F$Send service
                    bcc       L0122     ; branch when carry is clear; target L0122
                    pshs      x,a       ; save x,a on the stack
                    ldx       #1        ; set x to the constant 1
                    os9       F$Sleep   ; invoke the OS-9 F$Sleep service
                    puls      x,a       ; restore x,a from the stack
                    bra       L012D     ; continue execution at L012D

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
