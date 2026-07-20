**********************************************************************
* AnsiFilt - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       AnsiFilt
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

ReadBuf             rmb       1         ; reserve 1 byte(s) in the module workspace
ColCount            rmb       1         ; reserve 1 byte(s) in the module workspace
RowCount            rmb       1         ; reserve 1 byte(s) in the module workspace
U0003               rmb       1         ; reserve 1 byte(s) in the module workspace
U0004               rmb       1         ; reserve 1 byte(s) in the module workspace
InEscSeq            rmb       1         ; reserve 1 byte(s) in the module workspace
XSave               rmb       2         ; reserve 2 byte(s) in the module workspace
WriteBuf            rmb       1         ; reserve 1 byte(s) in the module workspace
U0009               rmb       499       ; reserve 499 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /AnsiFilt/ ; store an OS-9 high-bit-terminated string
                    fcb       $0A       ; store byte data

start               lbsr      Setup     ; call subroutine Setup
ReadLoop            clra                ; clear a to zero and set the condition codes
                    leax      ReadBuf,u ; form the address ReadBuf,u in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    bcs       Error     ; branch when carry reports an error or unsigned underflow; target Error
                    lda       ReadBuf,u ; load a from ReadBuf,u
                    lbsr      L0049     ; call subroutine L0049
                    bra       ReadLoop  ; continue execution at ReadLoop

Error               cmpb      #E$EOF    ; compare b with #E$EOF and set the condition codes
                    lbne      ErrExit   ; branch when the values differ or the result is nonzero; target ErrExit
                    bra       Exit      ; continue execution at Exit
Exit                clrb                ; clear b to zero and set the condition codes
ErrExit             os9       F$Exit    ; invoke the OS-9 F$Exit service

Setup               clr       InEscSeq,u ; clear InEscSeq,u to zero and set the condition codes
                    leax      WriteBuf,u ; form the address WriteBuf,u in x
                    stx       XSave,u   ; store x at XSave,u
                    lda       #1        ; set a to the constant 1
                    sta       ColCount,u ; store a at ColCount,u
                    sta       RowCount,u ; store a at RowCount,u
                    sta       U0003,u   ; store a at U0003,u
                    sta       U0004,u   ; store a at U0004,u
                    rts                 ; return to the caller

L0049               cmpa      #32       ; Is it a space?
                    bcs       L007A     ; no, go check others
                    tst       <InEscSeq ; In an ESC sequence?
                    lbne      L00F2     ; Yes, go handle it

* Write the character to the output path
                    pshs      a         ; save a on the stack
                    leax      0,s       ; form the address 0,s in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service

                    inc       ColCount,u ; Increment the number of chars written
                    lda       ColCount,u ; load a from ColCount,u
                    cmpa      #128      ; Have we written 128?
                    bls       L0078     ; No, so return

                    lda       #1        ; Reset the column count
                    sta       ColCount,u ; store a at ColCount,u
                    inc       RowCount,u ; Increment the row count
                    lda       RowCount,u ; load a from RowCount,u
                    cmpa      #23       ; Have we written 24 rows?
                    bls       L0078     ; No, so return

                    lda       #23       ; Reset the row count
                    sta       RowCount,u ; store a at RowCount,u
L0078               puls      pc,a      ; Clean the stack and return

L007A               cmpa      #27       ; Is it an ESC?
                    beq       HandleESC ; Yes, go handle it
                    cmpa      #7        ; Is it a BEL character?
                    beq       HandleBEL ; Yes, go handle it
                    cmpa      #8        ; Is it a BS character?
                    beq       HandleBS  ; Yes, go handle it
                    cmpa      #10       ; Is it an LF character?
                    beq       HandleLF  ; Yes, go handle it
                    cmpa      #13       ; Is it a CR character?
                    beq       HandleCR  ; Yes, go handle it
                    rts                 ; Something else, so return

HandleESC           lda       #1        ; Parsing an ESC seq, so set the flag
                    sta       InEscSeq,u ; store a at InEscSeq,u
                    leax      WriteBuf,u ; Set X to the buffer
                    lda       #27       ; Save the ESC code in the buffer
                    sta       ,x+       ; Increment the buffer pointer
                    stx       XSave,u   ; Save a copy of the pointer
                    rts                 ; ... and return

* Write the BEL to the output path
HandleBEL           pshs      a         ; save a on the stack
                    leax      0,s       ; form the address 0,s in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    puls      pc,a      ; restore pc,a and return to the caller

HandleBS            pshs      a         ; save a on the stack
                    dec       ColCount,u ; Decrement the column count
                    bne       bs1       ; Branch if col count not zero
                    lda       #1        ; Reset the column count
                    sta       ColCount,u ; store a at ColCount,u
                    bra       bsret     ; ... and return

* Write the BS to the output path
bs1                 leax      0,s       ; form the address 0,s in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
bsret               puls      pc,a      ; Clean the stack and return

* Write the LF to the output path
HandleLF            pshs      a         ; save a on the stack
                    leax      0,s       ; form the address 0,s in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service

                    inc       RowCount,u ; Increment the row count
                    lda       RowCount,u ; load a from RowCount,u
                    cmpa      #23       ; compare a with #23 and set the condition codes
                    bls       lfret     ; Return if less than 24 rows
                    lda       #23       ; Reset the row count
                    sta       RowCount,u ; store a at RowCount,u
lfret               puls      pc,a      ; Clean the stack and return

* Write the CR to the output path
HandleCR            pshs      a         ; save a on the stack
                    leax      0,s       ; form the address 0,s in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service

                    lda       #1        ; Reset the col count
                    sta       ColCount,u ; store a at ColCount,u
                    puls      pc,a      ; Clean the stack and return

L00F2               cmpa      #65       ; Is it less than 'A'?
                    bcs       L0101     ; Yes, append it to the save sequence
                    cmpa      #91       ; It is a '['?
                    beq       L0101     ; Yes, append it to the save sequence
                    cmpa      #122      ; Is it greater than 'z'?
                    bhi       L0101     ; Yes, append it to the save sequence
                    lbra      L0108     ; continue execution at L0108

* Append the char to the ESC sequence buffer
L0101               ldx       XSave,u   ; load x from XSave,u
                    sta       ,x+       ; store a at ,x+
                    stx       XSave,u   ; store x at XSave,u
                    rts                 ; return to the caller

L0108               clr       InEscSeq,u ; Reset the ESC sequence flag
                    ldx       XSave,u   ; Get the buffer pointer
                    sta       ,x+       ; Save the current character
                    stx       XSave,u   ; ... and save the new pointer
                    cmpa      #72       ; Is it an 'H'?
                    lbeq      Esc_Hf    ; Yes, handle it
                    cmpa      #65       ; Is it an 'A'?
                    lbeq      Esc_A     ; Yes, handle it
                    cmpa      #66       ; Is it a 'B'?
                    lbeq      Esc_B     ; Yes, handle it
                    cmpa      #67       ; Is it a 'C'?
                    lbeq      Esc_C     ; branch when the values are equal or the result is zero; target Esc_C
                    cmpa      #68       ; compare a with #68 and set the condition codes
                    lbeq      Esc_D     ; branch when the values are equal or the result is zero; target Esc_D
                    cmpa      #102      ; compare a with #102 and set the condition codes
                    lbeq      Esc_Hf    ; branch when the values are equal or the result is zero; target Esc_Hf
                    cmpa      #115      ; compare a with #115 and set the condition codes
                    lbeq      Esc_s     ; branch when the values are equal or the result is zero; target Esc_s
                    cmpa      #117      ; compare a with #117 and set the condition codes
                    lbeq      Esc_u     ; branch when the values are equal or the result is zero; target Esc_u
                    cmpa      #74       ; compare a with #74 and set the condition codes
                    lbeq      Esc_J     ; branch when the values are equal or the result is zero; target Esc_J
                    cmpa      #107      ; compare a with #107 and set the condition codes
                    lbeq      Esc_k     ; branch when the values are equal or the result is zero; target Esc_k
                    cmpa      #109      ; compare a with #109 and set the condition codes
                    lbeq      Esc_m     ; branch when the values are equal or the result is zero; target Esc_m

* Write the buffer to the output path
L0152               leax      WriteBuf,u ; form the address WriteBuf,u in x
                    pshs      x         ; save x on the stack
                    ldd       XSave,u   ; load d from XSave,u
                    subd      0,s       ; subtract from d using 0,s
                    leas      $02,s     ; adjust the system stack pointer
                    tfr       d,y       ; copy the register values specified by d,y
                    leax      WriteBuf,u ; form the address WriteBuf,u in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    clr       InEscSeq,u ; clear InEscSeq,u to zero and set the condition codes
                    rts                 ; return to the caller

* Clear the screen
L0168               fcb       $0C       ; store byte data
Esc_J               lbsr      L0397     ; call subroutine L0397
                    lda       ,x+       ; load a from ,x+
                    cmpa      #50       ; compare a with #50 and set the condition codes
                    bne       L0152     ; branch when the values differ or the result is nonzero; target L0152
                    leax      >L0168,pc ; form the address >L0168,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lda       #1        ; set a to the constant 1
                    sta       ColCount,u ; store a at ColCount,u
                    sta       RowCount,u ; store a at RowCount,u
                    rts                 ; return to the caller

L0186               fcb       $04       ; store byte data
Esc_k               lbsr      L0397     ; call subroutine L0397
                    leax      >L0186,pc ; form the address >L0186,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    rts                 ; return to the caller

L0198               fcb       $02       ; store byte data
Esc_Hf              lbsr      L0397     ; call subroutine L0397
                    lbsr      L03A7     ; call subroutine L03A7
                    sta       RowCount,u ; store a at RowCount,u
                    adda      #31       ; add to a using #31
                    pshs      a         ; save a on the stack
                    lda       ,x+       ; load a from ,x+
                    cmpa      #59       ; compare a with #59 and set the condition codes
                    beq       L01B0     ; branch when the values are equal or the result is zero; target L01B0
                    puls      a         ; restore a from the stack
                    lbra      L0152     ; continue execution at L0152
L01B0               lbsr      L03A7     ; call subroutine L03A7
                    sta       ColCount,u ; store a at ColCount,u
                    adda      #31       ; add to a using #31
                    pshs      a         ; save a on the stack
                    leax      >L0198,pc ; form the address >L0198,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      0,s       ; form the address 0,s in x
                    ldy       #2        ; set y to the constant 2
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leas      $02,s     ; adjust the system stack pointer
                    rts                 ; return to the caller

L01D2               fcb       $09       ; store byte data
Esc_A               lbsr      L0397     ; call subroutine L0397
                    lbsr      L03A7     ; call subroutine L03A7
                    pshs      a         ; save a on the stack
                    lda       RowCount,u ; load a from RowCount,u
                    suba      0,s       ; subtract from a using 0,s
                    bgt       L01E3     ; branch when the signed value is greater; target L01E3
                    lda       #1        ; set a to the constant 1
L01E3               sta       RowCount,u ; store a at RowCount,u
                    leax      >L01D2,pc ; form the address >L01D2,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
L01EF               tst       0,s       ; set condition codes from 0,s without changing it
                    beq       L01FA     ; branch when the values are equal or the result is zero; target L01FA
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    dec       0,s       ; decrement the value at 0,s
                    bne       L01EF     ; branch when the values differ or the result is nonzero; target L01EF
L01FA               leas      $01,s     ; adjust the system stack pointer
                    rts                 ; return to the caller

L01FD               fcb       $0A       ; store byte data
Esc_B               lbsr      L0397     ; call subroutine L0397
                    lbsr      L03A7     ; call subroutine L03A7
                    pshs      a         ; save a on the stack
                    lda       RowCount,u ; load a from RowCount,u
                    adda      0,s       ; add to a using 0,s
                    cmpa      #23       ; compare a with #23 and set the condition codes
                    bls       L021C     ; branch when the unsigned value is lower or equal; target L021C
                    suba      #23       ; subtract from a using #23
                    pshs      a         ; save a on the stack
                    lda       $01,s     ; load a from the current stack frame at $01,s
                    suba      0,s       ; subtract from a using 0,s
                    leas      $01,s     ; adjust the system stack pointer
                    sta       0,s       ; store a in the current stack frame at 0,s
                    lda       #23       ; set a to the constant 23
L021C               sta       RowCount,u ; store a at RowCount,u
                    leax      >L01FD,pc ; form the address >L01FD,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    bra       L01EF     ; continue execution at L01EF

L022A               fcb       $06       ; store byte data
Esc_C               lbsr      L0397     ; call subroutine L0397
                    lbsr      L03A7     ; call subroutine L03A7
                    pshs      a         ; save a on the stack
                    lda       ColCount,u ; load a from ColCount,u
                    adda      0,s       ; add to a using 0,s
                    cmpa      #80       ; compare a with #80 and set the condition codes
                    bls       L0249     ; branch when the unsigned value is lower or equal; target L0249
                    suba      #80       ; subtract from a using #80
                    pshs      a         ; save a on the stack
                    lda       $01,s     ; load a from the current stack frame at $01,s
                    suba      0,s       ; subtract from a using 0,s
                    sta       $01,s     ; store a in the current stack frame at $01,s
                    leas      $01,s     ; adjust the system stack pointer
                    lda       #80       ; set a to the constant 80
L0249               sta       ColCount,u ; store a at ColCount,u
                    leax      >L022A,pc ; form the address >L022A,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    lbra      L01EF     ; continue execution at L01EF

L0258               fcb       $08       ; store byte data
Esc_D               lbsr      L0397     ; call subroutine L0397
                    lbsr      L03A7     ; call subroutine L03A7
                    pshs      a         ; save a on the stack
                    lda       ColCount,u ; load a from ColCount,u
                    suba      0,s       ; subtract from a using 0,s
                    bgt       L026E     ; branch when the signed value is greater; target L026E
                    deca                ; decrement a
                    adda      0,s       ; add to a using 0,s
                    sta       0,s       ; store a in the current stack frame at 0,s
                    lda       #1        ; set a to the constant 1
L026E               sta       ColCount,u ; store a at ColCount,u
                    leax      >L0258,pc ; form the address >L0258,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    lbra      L01EF     ; continue execution at L01EF

Esc_s               lda       ColCount,u ; load a from ColCount,u
                    sta       U0003,u   ; store a at U0003,u
                    lda       RowCount,u ; load a from RowCount,u
                    sta       U0004,u   ; store a at U0004,u
                    rts                 ; return to the caller

Esc_u               lda       U0004,u   ; load a from U0004,u
                    sta       RowCount,u ; store a at RowCount,u
                    adda      #31       ; add to a using #31
                    pshs      a         ; save a on the stack
                    lda       U0003,u   ; load a from U0003,u
                    sta       ColCount,u ; store a at ColCount,u
                    adda      #31       ; add to a using #31
                    pshs      a         ; save a on the stack
                    leax      >L0198,pc ; form the address >L0198,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      0,s       ; form the address 0,s in x
                    ldy       #2        ; set y to the constant 2
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leas      $02,s     ; adjust the system stack pointer
                    rts                 ; return to the caller

Esc_m               lbsr      L0397     ; call subroutine L0397
L02B2               lda       0,x       ; load a from 0,x
                    cmpa      #109      ; compare a with #109 and set the condition codes
                    beq       L02C3     ; branch when the values are equal or the result is zero; target L02C3
                    lbsr      L03A7     ; call subroutine L03A7
                    bsr       L02C4     ; call subroutine L02C4
                    lda       ,x+       ; load a from ,x+
                    cmpa      #59       ; compare a with #59 and set the condition codes
                    beq       L02B2     ; branch when the values are equal or the result is zero; target L02B2
L02C3               rts                 ; return to the caller

L02C4               pshs      x         ; save x on the stack
                    cmpa      #0        ; compare a with #0 and set the condition codes
                    beq       L02F2     ; branch when the values are equal or the result is zero; target L02F2
                    cmpa      #4        ; compare a with #4 and set the condition codes
                    beq       L0303     ; branch when the values are equal or the result is zero; target L0303
                    cmpa      #5        ; compare a with #5 and set the condition codes
                    beq       L0314     ; branch when the values are equal or the result is zero; target L0314
                    cmpa      #7        ; compare a with #7 and set the condition codes
                    beq       L031C     ; branch when the values are equal or the result is zero; target L031C
                    cmpa      #8        ; compare a with #8 and set the condition codes
                    beq       L0328     ; branch when the values are equal or the result is zero; target L0328
                    cmpa      #40       ; compare a with #40 and set the condition codes
                    lbge      L0365     ; branch when the signed value is greater than or equal; target L0365
                    cmpa      #30       ; compare a with #30 and set the condition codes
                    bge       L0339     ; branch when the signed value is greater than or equal; target L0339
                    puls      pc,x      ; restore pc,x and return to the caller

L02E6               fcb       $1B       ; store byte data
                    fcb       $32       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $1B       ; store byte data
                    fcb       $33       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $21       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $23       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $25       ; store byte data

L02F2               leax      >L02E6,pc ; form the address >L02E6,pc in x
                    ldy       #12       ; set y to the constant 12
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    puls      pc,x      ; restore pc,x and return to the caller

L0301               fcb       $1F       ; store byte data
                    fcb       $22       ; store byte data

L0303               leax      >L0301,pc ; form the address >L0301,pc in x
L0307               ldy       #2        ; set y to the constant 2
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    puls      pc,x      ; restore pc,x and return to the caller

L0312               fcb       $1F       ; store byte data
                    fcb       $24       ; store byte data

L0314               leax      >L0312,pc ; form the address >L0312,pc in x
                    bra       L0307     ; continue execution at L0307

L031A               fcb       $1F       ; store byte data
                    fcb       $20       ; store byte data

L031C               leax      >L031A,pc ; form the address >L031A,pc in x
                    bra       L0307     ; continue execution at L0307

L0322               fcb       $1B       ; store byte data
                    fcb       $32       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $1B       ; store byte data
                    fcb       $33       ; store byte data
                    fcb       $02       ; store byte data

L0328               leax      >L0322,pc ; form the address >L0322,pc in x
                    ldy       #6        ; set y to the constant 6
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    puls      pc,x      ; restore pc,x and return to the caller

L0337               fcb       $1B       ; store byte data
                    fcb       $32       ; store byte data

L0339               cmpa      #37       ; compare a with #37 and set the condition codes
                    ble       L033F     ; branch when the signed value is less than or equal; target L033F
                    puls      pc,x      ; restore pc,x and return to the caller

L033F               suba      #30       ; subtract from a using #30
                    pshs      a         ; save a on the stack
                    leax      >L0337,pc ; form the address >L0337,pc in x
                    ldy       #2        ; set y to the constant 2
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    puls      a         ; restore a from the stack
                    leax      >L038F,pc ; form the address >L038F,pc in x
                    leax      a,x       ; form the address a,x in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    puls      pc,x      ; restore pc,x and return to the caller

L0363               fcb       $1B       ; store byte data
                    fcb       $33       ; store byte data

L0365               cmpa      #47       ; compare a with #47 and set the condition codes
                    ble       L036B     ; branch when the signed value is less than or equal; target L036B
                    puls      pc,x      ; restore pc,x and return to the caller

L036B               suba      #40       ; subtract from a using #40
                    pshs      a         ; save a on the stack
                    leax      >L0363,pc ; form the address >L0363,pc in x
                    ldy       #2        ; set y to the constant 2
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      >L038F,pc ; form the address >L038F,pc in x
                    puls      a         ; restore a from the stack
                    leax      a,x       ; form the address a,x in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service

                    puls      pc,x      ; restore pc,x and return to the caller

L038F               fcb       $02       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $05       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $07       ; store byte data
                    fcb       $00       ; store byte data

L0397               leax      WriteBuf,u ; form the address WriteBuf,u in x
                    leax      $01,x     ; form the address $01,x in x
                    lda       ,x+       ; load a from ,x+
                    cmpa      #91       ; compare a with #91 and set the condition codes
                    beq       L03A6     ; branch when the values are equal or the result is zero; target L03A6
                    leas      $02,s     ; adjust the system stack pointer
                    lbra      L0152     ; continue execution at L0152
L03A6               rts                 ; return to the caller

L03A7               lda       0,x       ; load a from 0,x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    blt       L03E7     ; branch when the signed value is less; target L03E7
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bgt       L03E7     ; branch when the signed value is greater; target L03E7
L03B1               lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    blt       L03BD     ; branch when the signed value is less; target L03BD
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bgt       L03BD     ; branch when the signed value is greater; target L03BD
                    bra       L03B1     ; continue execution at L03B1
L03BD               leax      -$01,x    ; form the address -$01,x in x
                    tfr       x,y       ; copy the register values specified by x,y
                    pshs      x         ; save x on the stack
                    ldb       #1        ; set b to the constant 1
                    ldx       #0        ; set x to the constant 0
L03C8               pshs      b         ; save b on the stack
                    lda       ,-y       ; load a from ,-y
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    blt       L03DF     ; branch when the signed value is less; target L03DF
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bgt       L03DF     ; branch when the signed value is greater; target L03DF
                    suba      #48       ; subtract from a using #48
                    mul                 ; multiply a by b and return the product in d
                    abx                 ; advance x by the unsigned offset in b
                    puls      b         ; restore b from the stack
                    lda       #10       ; set a to the constant 10
                    mul                 ; multiply a by b and return the product in d
                    bra       L03C8     ; continue execution at L03C8

L03DF               puls      b         ; restore b from the stack
                    tfr       x,d       ; copy the register values specified by x,d
                    tfr       b,a       ; copy the register values specified by b,a
                    puls      pc,x      ; restore pc,x and return to the caller

L03E7               lda       #1        ; set a to the constant 1
                    rts                 ; return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
