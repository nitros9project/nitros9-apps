**********************************************************************
* AnsiFilt - OS-9 Level 2 BBS command
*
* Syntax: AnsiFilt <input> or <producer> | AnsiFilt
* Purpose: Translate ANSI terminal sequences into CoCo OS-9 display operations.
* State: parser state, numeric parameters, cursor controls, and translated output.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
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
WorkByte_001        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_002        rmb       1         ; reserve 1 byte(s) in the module workspace
InEscSeq            rmb       1         ; reserve 1 byte(s) in the module workspace
XSave               rmb       2         ; reserve 2 byte(s) in the module workspace
WriteBuf            rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_001      rmb       499       ; reserve 499 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /AnsiFilt/ ; store an OS-9 high-bit-terminated string
                    fcb       $0A       ; store byte data

start               lbsr      Setup     ; call subroutine Setup
ReadLoop            clra                ; clear a to zero and set the condition codes
                    leax      ReadBuf,u ; form the address ReadBuf,u in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcs       Error     ; branch when carry reports an error or unsigned underflow; target Error
                    lda       ReadBuf,u ; load a from ReadBuf,u
                    lbsr      Routine_001 ; call subroutine Routine_001
                    bra       ReadLoop  ; continue execution at ReadLoop

Error               cmpb      #E$EOF    ; compare b with #E$EOF and set the condition codes
                    lbne      ErrExit   ; branch when the values differ or the result is nonzero; target ErrExit
                    bra       Exit      ; continue execution at Exit
Exit                clrb                ; clear b to zero and set the condition codes
ErrExit             os9       F$Exit    ; terminate the process with status B

Setup               clr       InEscSeq,u ; clear InEscSeq,u to zero and set the condition codes
                    leax      WriteBuf,u ; form the address WriteBuf,u in x
                    stx       XSave,u   ; store x at XSave,u
                    lda       #1        ; set a to the constant 1
                    sta       ColCount,u ; store a at ColCount,u
                    sta       RowCount,u ; store a at RowCount,u
                    sta       WorkByte_001,u ; store a at WorkByte_001,u
                    sta       WorkByte_002,u ; store a at WorkByte_002,u
                    rts                 ; return to the caller

Routine_001         cmpa      #32       ; is it a space?
                    bcs       Branch_001 ; no, go check others
                    tst       <InEscSeq ; in an ESC sequence?
                    lbne      Branch_002 ; yes, go handle it

* Write the character to the output path
                    pshs      a         ; save a on the stack
                    leax      ,s        ; form the address ,s in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A

                    inc       ColCount,u ; increment the number of chars written
                    lda       ColCount,u ; load a from ColCount,u
                    cmpa      #128      ; have we written 128?
                    bls       Branch_003 ; no, so return

                    lda       #1        ; reset the column count
                    sta       ColCount,u ; store a at ColCount,u
                    inc       RowCount,u ; increment the row count
                    lda       RowCount,u ; load a from RowCount,u
                    cmpa      #23       ; have we written 24 rows?
                    bls       Branch_003 ; no, so return

                    lda       #23       ; reset the row count
                    sta       RowCount,u ; store a at RowCount,u
Branch_003          puls      pc,a      ; clean the stack and return

Branch_001          cmpa      #27       ; is it an ESC?
                    beq       HandleESC ; yes, go handle it
                    cmpa      #7        ; is it a BEL character?
                    beq       HandleBEL ; yes, go handle it
                    cmpa      #8        ; is it a BS character?
                    beq       HandleBS  ; yes, go handle it
                    cmpa      #10       ; is it an LF character?
                    beq       HandleLF  ; yes, go handle it
                    cmpa      #13       ; is it a CR character?
                    beq       HandleCR  ; yes, go handle it
                    rts                 ; something else, so return

HandleESC           lda       #1        ; parsing an ESC seq, so set the flag
                    sta       InEscSeq,u ; store a at InEscSeq,u
                    leax      WriteBuf,u ; set X to the buffer
                    lda       #27       ; save the ESC code in the buffer
                    sta       ,x+       ; increment the buffer pointer
                    stx       XSave,u   ; save a copy of the pointer
                    rts                 ; ... and return

* Write the BEL to the output path
HandleBEL           pshs      a         ; save a on the stack
                    leax      ,s        ; form the address ,s in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      pc,a      ; restore pc,a and return to the caller

HandleBS            pshs      a         ; save a on the stack
                    dec       ColCount,u ; decrement the column count
                    bne       bs1       ; branch if col count not zero
                    lda       #1        ; reset the column count
                    sta       ColCount,u ; store a at ColCount,u
                    bra       bsret     ; ... and return

* Write the BS to the output path
bs1                 leax      ,s        ; form the address ,s in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
bsret               puls      pc,a      ; clean the stack and return

* Write the LF to the output path
HandleLF            pshs      a         ; save a on the stack
                    leax      ,s        ; form the address ,s in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A

                    inc       RowCount,u ; increment the row count
                    lda       RowCount,u ; load a from RowCount,u
                    cmpa      #23       ; compare a with #23 and set the condition codes
                    bls       lfret     ; return if less than 24 rows
                    lda       #23       ; reset the row count
                    sta       RowCount,u ; store a at RowCount,u
lfret               puls      pc,a      ; clean the stack and return

* Write the CR to the output path
HandleCR            pshs      a         ; save a on the stack
                    leax      ,s        ; form the address ,s in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A

                    lda       #1        ; reset the col count
                    sta       ColCount,u ; store a at ColCount,u
                    puls      pc,a      ; clean the stack and return

Branch_002          cmpa      #65       ; is it less than 'A'?
                    bcs       Branch_004 ; yes, append it to the save sequence
                    cmpa      #91       ; it is a '['?
                    beq       Branch_004 ; yes, append it to the save sequence
                    cmpa      #122      ; is it greater than 'z'?
                    bhi       Branch_004 ; yes, append it to the save sequence
                    lbra      Branch_005 ; continue execution at Branch_005

* Append the char to the ESC sequence buffer
Branch_004          ldx       XSave,u   ; load x from XSave,u
                    sta       ,x+       ; store a at ,x+
                    stx       XSave,u   ; store x at XSave,u
                    rts                 ; return to the caller

Branch_005          clr       InEscSeq,u ; reset the ESC sequence flag
                    ldx       XSave,u   ; get the buffer pointer
                    sta       ,x+       ; save the current character
                    stx       XSave,u   ; ... and save the new pointer
                    cmpa      #72       ; is it an 'H'?
                    lbeq      Esc_Hf    ; yes, handle it
                    cmpa      #65       ; is it an 'A'?
                    lbeq      Esc_A     ; yes, handle it
                    cmpa      #66       ; is it a 'B'?
                    lbeq      Esc_B     ; yes, handle it
                    cmpa      #67       ; is it a 'C'?
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
Branch_006          leax      WriteBuf,u ; form the address WriteBuf,u in x
                    pshs      x         ; save x on the stack
                    ldd       XSave,u   ; load d from XSave,u
                    subd      ,s        ; subtract from d using ,s
                    leas      $02,s     ; adjust the system stack pointer
                    tfr       d,y       ; copy the register values specified by d,y
                    leax      WriteBuf,u ; form the address WriteBuf,u in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    clr       InEscSeq,u ; clear InEscSeq,u to zero and set the condition codes
                    rts                 ; return to the caller

* Clear the screen
Data_001            fcb       $0C       ; store byte data
Esc_J               lbsr      Code_001  ; call subroutine Code_001
                    lda       ,x+       ; load a from ,x+
                    cmpa      #50       ; compare a with #50 and set the condition codes
                    bne       Branch_006 ; branch when the values differ or the result is nonzero; target Branch_006
                    leax      >Data_001,pc ; form the address >Data_001,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    lda       #1        ; set a to the constant 1
                    sta       ColCount,u ; store a at ColCount,u
                    sta       RowCount,u ; store a at RowCount,u
                    rts                 ; return to the caller

Data_002            fcb       $04       ; store byte data
Esc_k               lbsr      Code_001  ; call subroutine Code_001
                    leax      >Data_002,pc ; form the address >Data_002,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    rts                 ; return to the caller

Data_003            fcb       $02       ; store byte data
Esc_Hf              lbsr      Code_001  ; call subroutine Code_001
                    lbsr      Routine_002 ; call subroutine Routine_002
                    sta       RowCount,u ; store a at RowCount,u
                    adda      #31       ; add to a using #31
                    pshs      a         ; save a on the stack
                    lda       ,x+       ; load a from ,x+
                    cmpa      #59       ; compare a with #59 and set the condition codes
                    beq       Branch_007 ; branch when the values are equal or the result is zero; target Branch_007
                    puls      a         ; restore a from the stack
                    lbra      Branch_006 ; continue execution at Branch_006
Branch_007          lbsr      Routine_002 ; call subroutine Routine_002
                    sta       ColCount,u ; store a at ColCount,u
                    adda      #31       ; add to a using #31
                    pshs      a         ; save a on the stack
                    leax      >Data_003,pc ; form the address >Data_003,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      ,s        ; form the address ,s in x
                    ldy       #2        ; set y to the constant 2
                    os9       I$Write   ; write Y bytes from X to path A
                    leas      $02,s     ; adjust the system stack pointer
                    rts                 ; return to the caller

Data_004            fcb       $09       ; store byte data
Esc_A               lbsr      Code_001  ; call subroutine Code_001
                    lbsr      Routine_002 ; call subroutine Routine_002
                    pshs      a         ; save a on the stack
                    lda       RowCount,u ; load a from RowCount,u
                    suba      ,s        ; subtract from a using ,s
                    bgt       Branch_008 ; branch when the signed value is greater; target Branch_008
                    lda       #1        ; set a to the constant 1
Branch_008          sta       RowCount,u ; store a at RowCount,u
                    leax      >Data_004,pc ; form the address >Data_004,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
Branch_009          tst       ,s        ; set condition codes from ,s without changing it
                    beq       Branch_010 ; branch when the values are equal or the result is zero; target Branch_010
                    os9       I$Write   ; write Y bytes from X to path A
                    dec       ,s        ; decrement the value at ,s
                    bne       Branch_009 ; branch when the values differ or the result is nonzero; target Branch_009
Branch_010          leas      $01,s     ; adjust the system stack pointer
                    rts                 ; return to the caller

Data_005            fcb       $0A       ; store byte data
Esc_B               lbsr      Code_001  ; call subroutine Code_001
                    lbsr      Routine_002 ; call subroutine Routine_002
                    pshs      a         ; save a on the stack
                    lda       RowCount,u ; load a from RowCount,u
                    adda      ,s        ; add to a using ,s
                    cmpa      #23       ; compare a with #23 and set the condition codes
                    bls       Branch_011 ; branch when the unsigned value is lower or equal; target Branch_011
                    suba      #23       ; subtract from a using #23
                    pshs      a         ; save a on the stack
                    lda       $01,s     ; load a from the current stack frame at $01,s
                    suba      ,s        ; subtract from a using ,s
                    leas      $01,s     ; adjust the system stack pointer
                    sta       ,s        ; store a in the current stack frame at ,s
                    lda       #23       ; set a to the constant 23
Branch_011          sta       RowCount,u ; store a at RowCount,u
                    leax      >Data_005,pc ; form the address >Data_005,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    bra       Branch_009 ; continue execution at Branch_009

Data_006            fcb       $06       ; store byte data
Esc_C               lbsr      Code_001  ; call subroutine Code_001
                    lbsr      Routine_002 ; call subroutine Routine_002
                    pshs      a         ; save a on the stack
                    lda       ColCount,u ; load a from ColCount,u
                    adda      ,s        ; add to a using ,s
                    cmpa      #80       ; compare a with #80 and set the condition codes
                    bls       Branch_012 ; branch when the unsigned value is lower or equal; target Branch_012
                    suba      #80       ; subtract from a using #80
                    pshs      a         ; save a on the stack
                    lda       $01,s     ; load a from the current stack frame at $01,s
                    suba      ,s        ; subtract from a using ,s
                    sta       $01,s     ; store a in the current stack frame at $01,s
                    leas      $01,s     ; adjust the system stack pointer
                    lda       #80       ; set a to the constant 80
Branch_012          sta       ColCount,u ; store a at ColCount,u
                    leax      >Data_006,pc ; form the address >Data_006,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    lbra      Branch_009 ; continue execution at Branch_009

Data_007            fcb       $08       ; store byte data
Esc_D               lbsr      Code_001  ; call subroutine Code_001
                    lbsr      Routine_002 ; call subroutine Routine_002
                    pshs      a         ; save a on the stack
                    lda       ColCount,u ; load a from ColCount,u
                    suba      ,s        ; subtract from a using ,s
                    bgt       Branch_013 ; branch when the signed value is greater; target Branch_013
                    deca                ; decrement a
                    adda      ,s        ; add to a using ,s
                    sta       ,s        ; store a in the current stack frame at ,s
                    lda       #1        ; set a to the constant 1
Branch_013          sta       ColCount,u ; store a at ColCount,u
                    leax      >Data_007,pc ; form the address >Data_007,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    lbra      Branch_009 ; continue execution at Branch_009

Esc_s               lda       ColCount,u ; load a from ColCount,u
                    sta       WorkByte_001,u ; store a at WorkByte_001,u
                    lda       RowCount,u ; load a from RowCount,u
                    sta       WorkByte_002,u ; store a at WorkByte_002,u
                    rts                 ; return to the caller

Esc_u               lda       WorkByte_002,u ; load a from WorkByte_002,u
                    sta       RowCount,u ; store a at RowCount,u
                    adda      #31       ; add to a using #31
                    pshs      a         ; save a on the stack
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    sta       ColCount,u ; store a at ColCount,u
                    adda      #31       ; add to a using #31
                    pshs      a         ; save a on the stack
                    leax      >Data_003,pc ; form the address >Data_003,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      ,s        ; form the address ,s in x
                    ldy       #2        ; set y to the constant 2
                    os9       I$Write   ; write Y bytes from X to path A
                    leas      $02,s     ; adjust the system stack pointer
                    rts                 ; return to the caller

Esc_m               lbsr      Code_001  ; call subroutine Code_001
Branch_014          lda       ,x        ; load a from ,x
                    cmpa      #109      ; compare a with #109 and set the condition codes
                    beq       Branch_015 ; branch when the values are equal or the result is zero; target Branch_015
                    lbsr      Routine_002 ; call subroutine Routine_002
                    bsr       Routine_003 ; call subroutine Routine_003
                    lda       ,x+       ; load a from ,x+
                    cmpa      #59       ; compare a with #59 and set the condition codes
                    beq       Branch_014 ; branch when the values are equal or the result is zero; target Branch_014
Branch_015          rts                 ; return to the caller

Routine_003         pshs      x         ; save x on the stack
                    cmpa      #0        ; compare a with #0 and set the condition codes
                    beq       Branch_016 ; branch when the values are equal or the result is zero; target Branch_016
                    cmpa      #4        ; compare a with #4 and set the condition codes
                    beq       Branch_017 ; branch when the values are equal or the result is zero; target Branch_017
                    cmpa      #5        ; compare a with #5 and set the condition codes
                    beq       Branch_018 ; branch when the values are equal or the result is zero; target Branch_018
                    cmpa      #7        ; compare a with #7 and set the condition codes
                    beq       Branch_019 ; branch when the values are equal or the result is zero; target Branch_019
                    cmpa      #8        ; compare a with #8 and set the condition codes
                    beq       Branch_020 ; branch when the values are equal or the result is zero; target Branch_020
                    cmpa      #40       ; compare a with #40 and set the condition codes
                    lbge      Branch_021 ; branch when the signed value is greater than or equal; target Branch_021
                    cmpa      #30       ; compare a with #30 and set the condition codes
                    bge       Branch_022 ; branch when the signed value is greater than or equal; target Branch_022
                    puls      pc,x      ; restore pc,x and return to the caller

Data_008            fcb       $1B       ; store byte data
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

Branch_016          leax      >Data_008,pc ; form the address >Data_008,pc in x
                    ldy       #12       ; set y to the constant 12
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      pc,x      ; restore pc,x and return to the caller

Data_009            fcb       $1F       ; store byte data
                    fcb       $22       ; store byte data

Branch_017          leax      >Data_009,pc ; form the address >Data_009,pc in x
Branch_023          ldy       #2        ; set y to the constant 2
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      pc,x      ; restore pc,x and return to the caller

Data_010            fcb       $1F       ; store byte data
                    fcb       $24       ; store byte data

Branch_018          leax      >Data_010,pc ; form the address >Data_010,pc in x
                    bra       Branch_023 ; continue execution at Branch_023

Data_011            fcb       $1F       ; store byte data
                    fcb       $20       ; store byte data

Branch_019          leax      >Data_011,pc ; form the address >Data_011,pc in x
                    bra       Branch_023 ; continue execution at Branch_023

Data_012            fcb       $1B       ; store byte data
                    fcb       $32       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $1B       ; store byte data
                    fcb       $33       ; store byte data
                    fcb       $02       ; store byte data

Branch_020          leax      >Data_012,pc ; form the address >Data_012,pc in x
                    ldy       #6        ; set y to the constant 6
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      pc,x      ; restore pc,x and return to the caller

Data_013            fcb       $1B       ; store byte data
                    fcb       $32       ; store byte data

Branch_022          cmpa      #37       ; compare a with #37 and set the condition codes
                    ble       Branch_024 ; branch when the signed value is less than or equal; target Branch_024
                    puls      pc,x      ; restore pc,x and return to the caller

Branch_024          suba      #30       ; subtract from a using #30
                    pshs      a         ; save a on the stack
                    leax      >Data_013,pc ; form the address >Data_013,pc in x
                    ldy       #2        ; set y to the constant 2
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      a         ; restore a from the stack
                    leax      >Data_014,pc ; form the address >Data_014,pc in x
                    leax      a,x       ; form the address a,x in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      pc,x      ; restore pc,x and return to the caller

Data_015            fcb       $1B       ; store byte data
                    fcb       $33       ; store byte data

Branch_021          cmpa      #47       ; compare a with #47 and set the condition codes
                    ble       Branch_025 ; branch when the signed value is less than or equal; target Branch_025
                    puls      pc,x      ; restore pc,x and return to the caller

Branch_025          suba      #40       ; subtract from a using #40
                    pshs      a         ; save a on the stack
                    leax      >Data_015,pc ; form the address >Data_015,pc in x
                    ldy       #2        ; set y to the constant 2
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >Data_014,pc ; form the address >Data_014,pc in x
                    puls      a         ; restore a from the stack
                    leax      a,x       ; form the address a,x in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A

                    puls      pc,x      ; restore pc,x and return to the caller

Data_014            fcb       $02       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $05       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $07       ; store byte data
                    fcb       $00       ; store byte data

Code_001            leax      WriteBuf,u ; form the address WriteBuf,u in x
                    leax      $01,x     ; form the address $01,x in x
                    lda       ,x+       ; load a from ,x+
                    cmpa      #91       ; compare a with #91 and set the condition codes
                    beq       Branch_026 ; branch when the values are equal or the result is zero; target Branch_026
                    leas      $02,s     ; adjust the system stack pointer
                    lbra      Branch_006 ; continue execution at Branch_006
Branch_026          rts                 ; return to the caller

Routine_002         lda       ,x        ; load a from ,x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    blt       Branch_027 ; branch when the signed value is less; target Branch_027
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bgt       Branch_027 ; branch when the signed value is greater; target Branch_027
Branch_028          lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    blt       Branch_029 ; branch when the signed value is less; target Branch_029
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bgt       Branch_029 ; branch when the signed value is greater; target Branch_029
                    bra       Branch_028 ; continue execution at Branch_028
Branch_029          leax      -$01,x    ; form the address -$01,x in x
                    tfr       x,y       ; copy the register values specified by x,y
                    pshs      x         ; save x on the stack
                    ldb       #1        ; set b to the constant 1
                    ldx       #0        ; set x to the constant 0
Branch_030          pshs      b         ; save b on the stack
                    lda       ,-y       ; load a from ,-y
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    blt       Branch_031 ; branch when the signed value is less; target Branch_031
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bgt       Branch_031 ; branch when the signed value is greater; target Branch_031
                    suba      #48       ; subtract from a using #48
                    mul                 ; multiply a by b and return the product in d
                    abx                 ; advance x by the unsigned offset in b
                    puls      b         ; restore b from the stack
                    lda       #10       ; set a to the constant 10
                    mul                 ; multiply a by b and return the product in d
                    bra       Branch_030 ; continue execution at Branch_030

Branch_031          puls      b         ; restore b from the stack
                    tfr       x,d       ; copy the register values specified by x,d
                    tfr       b,a       ; copy the register values specified by b,a
                    puls      pc,x      ; restore pc,x and return to the caller

Branch_027          lda       #1        ; set a to the constant 1
                    rts                 ; return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
