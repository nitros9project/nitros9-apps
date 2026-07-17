********************************************************************
* DMTIM - DeskMate 3 date and time utility
*
* Reconstructed from the original Tandy OS-9 module. Executable
* regions are represented by 6809 instructions; strings, tables,
* initialized workspace, and graphics are explicit data directives.
* No bytes are imported from the original binary at assembly time.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/16  Codex
* Fully disassembled, annotated, and verified against the binary.
*

                    nam       DMTIM
                    ttl       DeskMate 3 date and time utility

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct
atrv                set       $00

                    mod       eom,name,tylg,atrv,start,$03D4

name                fcs       /DMTIM/ ; OS-9 module name

Addr_0001           equ       $0001     ; absolute address used by original code
Addr_0003           equ       $0003     ; absolute address used by original code
Addr_0008           equ       $0008     ; absolute address used by original code
Addr_000B           equ       $000B     ; absolute address used by original code
Addr_0020           equ       $0020     ; absolute address used by original code
Addr_0024           equ       $0024     ; absolute address used by original code
Addr_0025           equ       $0025     ; absolute address used by original code
Addr_0040           equ       $0040     ; absolute address used by original code
Addr_0100           equ       $0100     ; absolute address used by original code
Addr_0101           equ       $0101     ; absolute address used by original code
Addr_0301           equ       $0301     ; absolute address used by original code
Addr_0501           equ       $0501     ; absolute address used by original code
DeskMateService     equ       $0000     ; absolute address used by original code

start               jmp       >DeskMateService ; dispatch control through the selected target
                    leax      Data_0529,PCR ; form the referenced address without reading memory
                    tfr       X,D       ; copy the source register into the destination register
                    addd      #Addr_0100 ; add the operand to the running value
Code_001E           clrb                ; clear the selected byte or register
Code_001F           tfr       A,DP      ; copy the source register into the destination register
Code_0021           tfr       D,U       ; copy the source register into the destination register
Code_0023           sts       $02,U     ; save the current value in working storage
Code_0026           leas      $03D3,U   ; form the referenced address without reading memory
                    leax      Data_0B9C,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $07       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $06       ; private DeskMate service selector
                    leax      Data_139E,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $08       ; private DeskMate service selector
                    lbra      Code_04F8 ; continue at the distant control-flow target
Data_0041           fcc       "("                            ; embedded text or resource bytes
Data_0042           fcb       $04       ; table, bitmap, or initialized data bytes
Data_0043           fcb       $07       ; table, bitmap, or initialized data bytes
Data_0044           fcc       " "                            ; embedded text or resource bytes
                    fcb       $0C,$00   ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $C0       ; table, bitmap, or initialized data bytes
Data_0049           fcb       $1F,$1D,$1F,$1E,$1F,$1E ; table, bitmap, or initialized data bytes
                    fcb       $1F,$1F,$1E,$1F,$1E,$1F ; table, bitmap, or initialized data bytes
Data_0055           fcc       "Date is:"                     ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_005E           fcc       "Time is:"                     ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "Press [B"                     ; embedded text or resource bytes
Data_006F           fcc       "REAK] to ca"                  ; embedded text or resource bytes
Data_007A           fcc       "ncel"                         ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "Press [ENTER] to cont"        ; embedded text or resource bytes
                    fcc       "inue"                         ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_0099           fcc       "Format is : MM/DD/YY "        ; embedded text or resource bytes
                    fcc       "        "                     ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_00B7           fcc       "Format is : HH:MM:SS "        ; embedded text or resource bytes
                    fcc       "AM or PM"                     ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_00D5           lda       ,X+       ; fetch the next value and advance the source pointer
                    bne       Code_00D5 ; branch when the compared values differ
                    rts                 ; return to the caller
Code_00DA           pshs      A         ; preserve the listed registers on the stack
                    clra                ; clear the selected byte or register
                    tfr       D,X       ; copy the source register into the destination register
                    ldb       ,S+       ; load the value needed by the following operation
                    tfr       D,Y       ; copy the source register into the destination register
                    rts                 ; return to the caller
Code_00E4           leax      $4B,U     ; form the referenced address without reading memory
                    lda       #$20      ; load the value needed by the following operation
                    ldb       #$13      ; load the value needed by the following operation
Code_00EB           sta       ,X+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bpl       Code_00EB ; branch while the tested value is nonnegative
                    leax      $4B,U     ; form the referenced address without reading memory
                    clr       $08,X     ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      $66,U     ; form the referenced address without reading memory
                    os9       F$Time    ; request the named OS-9 service
                    lbsr      Code_0465 ; call the referenced helper routine
Code_00FF           leax      Data_0041,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
Data_010A           fcc       "3"                            ; embedded text or resource bytes
                    ldd       #Addr_0101 ; load the value needed by the following operation
                    lbsr      Code_00DA ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    leax      Data_0055,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
                    ldd       #Data_010A ; load the value needed by the following operation
                    lbsr      Code_00DA ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    leax      $4B,U     ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
                    ldd       #Code_030A ; load the value needed by the following operation
                    lbsr      Code_00DA ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    leax      $54,U     ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
                    ldd       #Addr_0301 ; load the value needed by the following operation
                    lbsr      Code_00DA ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    leax      Data_005E,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
                    lbsr      Code_00D5 ; call the referenced helper routine
                    pshs      X         ; preserve the listed registers on the stack
                    ldd       #Data_0801 ; load the value needed by the following operation
                    lbsr      Code_00DA ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    puls      X         ; restore the listed registers from the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
                    lbsr      Code_00D5 ; call the referenced helper routine
                    pshs      X         ; preserve the listed registers on the stack
                    ldd       #Data_0701 ; load the value needed by the following operation
                    lbsr      Code_00DA ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    puls      X         ; restore the listed registers from the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
                    lda       #$88      ; load the value needed by the following operation
                    sta       Data_0043 ; save the current value in working storage
                    rts                 ; return to the caller
Code_0180           pshs      Y,X,D     ; preserve the listed registers on the stack
                    ldd       #Addr_0501 ; load the value needed by the following operation
                    lbsr      Code_00DA ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    lda       #$20      ; load the value needed by the following operation
                    ldb       #$1E      ; load the value needed by the following operation
Code_0190           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "B"                            ; embedded text or resource bytes
                    decb                ; decrement the selected counter
                    bne       Code_0190 ; branch when the compared values differ
                    puls      PC,Y,X,D  ; restore the listed registers from the stack
Code_0199           clr       Data_006F ; clear the selected byte or register
                    ldd       #Data_010A ; load the value needed by the following operation
                    lbsr      Code_00DA ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    lda       Data_0043 ; load the value needed by the following operation
                    leax      $4B,U     ; form the referenced address without reading memory
                    bra       Code_01BD ; continue at the selected control-flow target
Code_01AC           inc       Data_006F ; advance the selected counter
                    ldd       #Code_030A ; load the value needed by the following operation
                    lbsr      Code_00DA ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    lda       Data_0043 ; load the value needed by the following operation
                    leax      $54,U     ; form the referenced address without reading memory
Code_01BD           clr       Addr_0040 ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    lbsr      Code_0A09 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    bne       Code_0207 ; branch when the compared values differ
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "E"                            ; embedded text or resource bytes
                    pshs      B         ; preserve the listed registers on the stack
                    cmpy      #Code_00FF ; compare against the limit and set condition flags
                    beq       Code_01E1 ; branch when the compared values are equal
                    cmpx      #Code_00FF ; compare against the limit and set condition flags
                    beq       Code_01E1 ; branch when the compared values are equal
                    cmpy      #Addr_0008 ; compare against the limit and set condition flags
                    beq       Code_01E1 ; branch when the compared values are equal
                    lda       #$0D      ; load the value needed by the following operation
                    bra       Code_01E3 ; continue at the selected control-flow target
Code_01E1           lda       #$05      ; load the value needed by the following operation
Code_01E3           puls      B         ; restore the listed registers from the stack
                    cmpb      #$01      ; compare against the limit and set condition flags
                    bne       Code_0207 ; branch when the compared values differ
                    cmpy      #Addr_0001 ; compare against the limit and set condition flags
                    ble       Code_01FF ; branch when the signed value is at or below the limit
                    cmpy      #Addr_0003 ; compare against the limit and set condition flags
                    bgt       Code_0207 ; branch when the signed value is above the limit
                    lda       #$44      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $02       ; private DeskMate service selector
                    lda       #$0A      ; load the value needed by the following operation
                    bra       Code_0207 ; continue at the selected control-flow target
Code_01FF           lda       #$55      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $02       ; private DeskMate service selector
                    lda       #$0C      ; load the value needed by the following operation
Code_0207           tst       Data_0042 ; set condition flags from the current value
                    beq       Code_0210 ; branch when the compared values are equal
                    clr       Data_0042 ; clear the selected byte or register
                    lbsr      Code_0180 ; call the referenced helper routine
Code_0210           cmpa      #$05      ; compare against the limit and set condition flags
                    lbeq      Code_02B9 ; take the distant branch when values are equal
                    cmpa      #$0C      ; compare against the limit and set condition flags
                    bne       Code_023C ; branch when the compared values differ
                    tst       Data_006F ; set condition flags from the current value
                    beq       Code_023C ; branch when the compared values are equal
                    tst       Data_0042 ; set condition flags from the current value
                    bne       Code_0225 ; branch when the compared values differ
                    lbsr      Code_0180 ; call the referenced helper routine
Code_0225           ldd       #Code_030A ; load the value needed by the following operation
                    lbsr      Code_00DA ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    leax      $54,U     ; form the referenced address without reading memory
                    ldy       #Addr_000B ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $22       ; private DeskMate service selector
                    bra       Code_026E ; continue at the selected control-flow target
Code_023C           cmpa      #$0A      ; compare against the limit and set condition flags
                    bne       Code_025B ; branch when the compared values differ
                    tst       Data_006F ; set condition flags from the current value
                    bne       Code_025B ; branch when the compared values differ
                    ldd       #Data_010A ; load the value needed by the following operation
                    lbsr      Code_00DA ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    leax      $4B,U     ; form the referenced address without reading memory
                    ldy       #Addr_0008 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $22       ; private DeskMate service selector
                    bra       Code_026E ; continue at the selected control-flow target
Code_025B           cmpa      #$0D      ; compare against the limit and set condition flags
                    beq       Code_026C ; branch when the compared values are equal
                    tst       Data_006F ; set condition flags from the current value
                    lbeq      Code_0199 ; take the distant branch when values are equal
                    lda       #$8B      ; load the value needed by the following operation
                    sta       Data_0043 ; save the current value in working storage
                    lbra      Code_01AC ; continue at the distant control-flow target
Code_026C           inc       Addr_0040 ; advance the selected counter
Code_026E           tst       Data_006F ; set condition flags from the current value
                    bne       Code_027C ; branch when the compared values differ
                    inc       Data_006F ; advance the selected counter
                    leax      $4B,U     ; form the referenced address without reading memory
                    leay      $63,U     ; form the referenced address without reading memory
                    bra       Code_0284 ; continue at the selected control-flow target
Code_027C           clr       Data_006F ; clear the selected byte or register
                    leax      $54,U     ; form the referenced address without reading memory
                    leay      $60,U     ; form the referenced address without reading memory
Code_0284           bsr       Code_02BA ; call the referenced helper routine
                    beq       Code_02B1 ; branch when the compared values are equal
                    clr       Data_007A ; clear the selected byte or register
                    lbsr      Code_0335 ; call the referenced helper routine
                    tst       Data_006F ; set condition flags from the current value
                    beq       Code_029B ; branch when the compared values are equal
                    lda       Data_007A ; load the value needed by the following operation
                    cmpa      #$03      ; compare against the limit and set condition flags
                    beq       Code_029B ; branch when the compared values are equal
                    inc       Data_0042 ; advance the selected counter
                    bra       Code_02CD ; continue at the selected control-flow target
Code_029B           tst       Data_007A ; set condition flags from the current value
                    beq       Code_02CD ; branch when the compared values are equal
                    tst       Data_006F ; set condition flags from the current value
                    beq       Code_02A8 ; branch when the compared values are equal
                    lbsr      Code_03BB ; call the referenced helper routine
                    bra       Code_02AB ; continue at the selected control-flow target
Code_02A8           lbsr      Code_03F8 ; call the referenced helper routine
Code_02AB           tst       Data_0042 ; set condition flags from the current value
                    beq       Code_02B1 ; branch when the compared values are equal
                    bra       Code_02CD ; continue at the selected control-flow target
Code_02B1           bra       Code_02F1 ; continue at the selected control-flow target
Code_02B3           leax      $66,U     ; form the referenced address without reading memory
                    os9       F$STime   ; request the named OS-9 service
Code_02B9           rts                 ; return to the caller
Code_02BA           pshs      X         ; preserve the listed registers on the stack
                    ldb       Data_0043 ; load the value needed by the following operation
                    andb      #$0F      ; mask off unwanted bits
                    decb                ; decrement the selected counter
Code_02C1           lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bne       Code_02CA ; branch when the compared values differ
                    decb                ; decrement the selected counter
                    bne       Code_02C1 ; branch when the compared values differ
Code_02CA           tstb                ; set condition flags from the current value
                    puls      PC,X      ; restore the listed registers from the stack
Code_02CD           ldd       #Addr_0501 ; load the value needed by the following operation
                    lbsr      Code_00DA ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    tst       Data_006F ; set condition flags from the current value
                    beq       Code_02E6 ; branch when the compared values are equal
                    leax      Data_0099,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
                    lbra      Code_0199 ; continue at the distant control-flow target
Code_02E6           leax      Data_00B7,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
                    lbra      Code_01AC ; continue at the distant control-flow target
Code_02F1           tst       Data_006F ; set condition flags from the current value
                    beq       Code_0311 ; branch when the compared values are equal
                    ldd       #Data_010A ; load the value needed by the following operation
                    lbsr      Code_00DA ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    leax      $4B,U     ; form the referenced address without reading memory
                    ldy       #Addr_0008 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $22       ; private DeskMate service selector
Code_030A           lda       #$8B      ; load the value needed by the following operation
                    sta       Data_0043 ; save the current value in working storage
                    lbra      Code_01AC ; continue at the distant control-flow target
Code_0311           ldd       #Code_030A ; load the value needed by the following operation
                    lbsr      Code_00DA ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    leax      $54,U     ; form the referenced address without reading memory
                    ldy       #Addr_000B ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $22       ; private DeskMate service selector
                    tst       Addr_0040 ; set condition flags from the current value
                    beq       Code_032E ; branch when the compared values are equal
                    tst       Data_0042 ; set condition flags from the current value
                    beq       Code_02B3 ; branch when the compared values are equal
Code_032E           lda       #$88      ; load the value needed by the following operation
                    sta       Data_0043 ; save the current value in working storage
                    lbra      Code_0199 ; continue at the distant control-flow target
Code_0335           pshs      Y         ; preserve the listed registers on the stack
                    clrb                ; clear the selected byte or register
                    leay      $008B,U   ; form the referenced address without reading memory
Code_033C           lda       ,X+       ; fetch the next value and advance the source pointer
                    beq       Code_03AB ; branch when the compared values are equal
                    cmpa      #$30      ; compare against the limit and set condition flags
                    bcs       Code_035F ; branch when carry reports an unsigned underflow or error
                    cmpa      #$39      ; compare against the limit and set condition flags
                    bhi       Code_035F ; branch when the unsigned value is above the limit
                    clr       Data_0041 ; clear the selected byte or register
                    cmpb      #$02      ; compare against the limit and set condition flags
                    beq       Code_0353 ; branch when the compared values are equal
                    sta       B,Y       ; save the current value in working storage
                    incb                ; advance the selected counter
                    bra       Code_033C ; continue at the selected control-flow target
Code_0353           pshs      A         ; preserve the listed registers on the stack
                    lda       $01,Y     ; load the value needed by the following operation
                    sta       ,Y        ; save the current value in working storage
                    puls      A         ; restore the listed registers from the stack
                    sta       $01,Y     ; save the current value in working storage
                    bra       Code_033C ; continue at the selected control-flow target
Code_035F           cmpa      #$20      ; compare against the limit and set condition flags
                    beq       Code_038D ; branch when the compared values are equal
                    tst       Data_0041 ; set condition flags from the current value
                    bne       Code_036B ; branch when the compared values differ
                    sta       Data_0041 ; save the current value in working storage
                    bra       Code_038D ; continue at the selected control-flow target
Code_036B           tst       Data_006F ; set condition flags from the current value
                    bne       Code_038B ; branch when the compared values differ
                    cmpa      #$4D      ; compare against the limit and set condition flags
                    beq       Code_0377 ; branch when the compared values are equal
                    cmpa      #$6D      ; compare against the limit and set condition flags
                    bne       Code_038B ; branch when the compared values differ
Code_0377           lda       Data_0041 ; load the value needed by the following operation
                    anda      #$DF      ; mask off unwanted bits
                    cmpa      #$50      ; compare against the limit and set condition flags
                    bne       Code_0383 ; branch when the compared values differ
                    sta       Data_0044 ; save the current value in working storage
                    bra       Code_038D ; continue at the selected control-flow target
Code_0383           cmpa      #$41      ; compare against the limit and set condition flags
                    bne       Code_038B ; branch when the compared values differ
                    sta       Data_0044 ; save the current value in working storage
                    bra       Code_038D ; continue at the selected control-flow target
Code_038B           inc       Data_0042 ; advance the selected counter
Code_038D           cmpb      #$01      ; compare against the limit and set condition flags
                    bne       Code_039D ; branch when the compared values differ
                    pshs      A         ; preserve the listed registers on the stack
                    lda       ,Y        ; load the value needed by the following operation
                    sta       $01,Y     ; save the current value in working storage
                    lda       #$30      ; load the value needed by the following operation
                    sta       ,Y        ; save the current value in working storage
                    puls      A         ; restore the listed registers from the stack
Code_039D           puls      Y         ; restore the listed registers from the stack
                    tstb                ; set condition flags from the current value
                    beq       Code_03A9 ; branch when the compared values are equal
                    inc       Data_007A ; advance the selected counter
                    lbsr      Code_0437 ; call the referenced helper routine
                    sta       ,Y+       ; store the value and advance the destination pointer
Code_03A9           bra       Code_0335 ; continue at the selected control-flow target
Code_03AB           tstb                ; set condition flags from the current value
                    beq       Code_03B9 ; branch when the compared values are equal
                    puls      Y         ; restore the listed registers from the stack
                    lbsr      Code_0437 ; call the referenced helper routine
                    sta       ,Y+       ; store the value and advance the destination pointer
                    inc       Data_007A ; advance the selected counter
                    pshs      Y         ; preserve the listed registers on the stack
Code_03B9           puls      PC,Y      ; restore the listed registers from the stack
Code_03BB           leay      $63,U     ; form the referenced address without reading memory
                    lda       $02,Y     ; load the value needed by the following operation
                    cmpa      #$63      ; compare against the limit and set condition flags
                    bhi       Code_0430 ; branch when the unsigned value is above the limit
                    lda       ,Y        ; load the value needed by the following operation
                    deca                ; decrement the selected counter
                    cmpa      #$0B      ; compare against the limit and set condition flags
                    bhi       Code_0430 ; branch when the unsigned value is above the limit
                    ldb       $01,Y     ; load the value needed by the following operation
                    beq       Code_0430 ; branch when the compared values are equal
                    leax      Data_0049,PCR ; form the referenced address without reading memory
                    cmpb      A,X       ; compare against the limit and set condition flags
                    bhi       Code_0430 ; branch when the unsigned value is above the limit
                    cmpa      #$01      ; compare against the limit and set condition flags
                    bne       Code_03E5 ; branch when the compared values differ
                    cmpb      #$1D      ; compare against the limit and set condition flags
                    bcs       Code_03E5 ; branch when carry reports an unsigned underflow or error
                    lda       $02,Y     ; load the value needed by the following operation
                    anda      #$03      ; mask off unwanted bits
                    bne       Code_0430 ; branch when the compared values differ
Code_03E5           leax      $63,U     ; form the referenced address without reading memory
                    leay      $66,U     ; form the referenced address without reading memory
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       $01,Y     ; save the current value in working storage
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       $02,Y     ; save the current value in working storage
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,Y        ; save the current value in working storage
                    rts                 ; return to the caller
Code_03F8           leay      $60,U     ; form the referenced address without reading memory
                    lda       ,Y+       ; fetch the next value and advance the source pointer
                    cmpa      #$0C      ; compare against the limit and set condition flags
                    bhi       Code_0430 ; branch when the unsigned value is above the limit
                    ldb       Data_0044 ; load the value needed by the following operation
                    cmpb      #$50      ; compare against the limit and set condition flags
                    bne       Code_040B ; branch when the compared values differ
                    adda      #$0C      ; add the operand to the running value
                    bra       Code_0410 ; continue at the selected control-flow target
Code_040B           cmpa      #$0C      ; compare against the limit and set condition flags
                    bne       Code_0410 ; branch when the compared values differ
                    clra                ; clear the selected byte or register
Code_0410           sta       -$01,Y    ; save the current value in working storage
                    lda       ,Y+       ; fetch the next value and advance the source pointer
                    cmpa      #$3B      ;0414: 81 3B          '. ; compare against the limit and set condition flags
                    bhi       Code_0430 ; branch when the unsigned value is above the limit
                    lda       ,Y+       ; fetch the next value and advance the source pointer
                    cmpa      #$3B      ;041A: 81 3B          '. ; compare against the limit and set condition flags
                    bhi       Code_0430 ; branch when the unsigned value is above the limit
                    leax      $60,U     ; form the referenced address without reading memory
                    leay      $66,U     ; form the referenced address without reading memory
                    ldb       #$03      ; load the value needed by the following operation
Code_0426           lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       B,Y       ; save the current value in working storage
                    incb                ; advance the selected counter
                    cmpb      #$06      ; compare against the limit and set condition flags
                    bne       Code_0426 ; branch when the compared values differ
                    rts                 ; return to the caller
Code_0430           inc       Data_0042 ; advance the selected counter
                    lda       #$41      ; load the value needed by the following operation
                    sta       Data_0044 ; save the current value in working storage
                    rts                 ; return to the caller
Code_0437           pshs      X,B       ; preserve the listed registers on the stack
                    leax      $008B,U   ; form the referenced address without reading memory
                    ldb       ,X+       ; fetch the next value and advance the source pointer
                    clra                ; clear the selected byte or register
                    subb      #$30      ; subtract the operand from the running value
                    beq       Code_0449 ; branch when the compared values are equal
Code_0444           adda      #$0A      ; add the operand to the running value
                    decb                ; decrement the selected counter
                    bne       Code_0444 ; branch when the compared values differ
Code_0449           adda      ,X+       ; add the operand to the running value
                    suba      #$30      ; subtract the operand from the running value
                    puls      PC,X,B    ; restore the listed registers from the stack
Code_044F           pshs      X,D       ; preserve the listed registers on the stack
                    leax      $008B,U   ; form the referenced address without reading memory
                    clra                ; clear the selected byte or register
Code_0456           subb      #$0A      ; subtract the operand from the running value
                    bmi       Code_045D ; branch while the tested value is negative
                    inca                ; advance the selected counter
                    bra       Code_0456 ; continue at the selected control-flow target
Code_045D           addb      #$3A      ; add the operand to the running value
                    adda      #$30      ; add the operand to the running value
                    std       ,X++      ; store the value and advance the destination pointer
                    puls      PC,X,D    ; restore the listed registers from the stack
Code_0465           leax      $66,U     ; form the referenced address without reading memory
                    ldb       $01,X     ; load the value needed by the following operation
                    bsr       Code_044F ; call the referenced helper routine
                    pshs      X         ; preserve the listed registers on the stack
                    leay      $4B,U     ; form the referenced address without reading memory
                    leax      $008B,U   ; form the referenced address without reading memory
                    ldd       ,X++      ; fetch the next value and advance the source pointer
                    std       ,Y++      ; store the value and advance the destination pointer
                    puls      X         ; restore the listed registers from the stack
                    lda       #$2F      ; load the value needed by the following operation
                    sta       ,Y+       ; store the value and advance the destination pointer
                    ldb       $02,X     ; load the value needed by the following operation
                    bsr       Code_044F ; call the referenced helper routine
                    pshs      X         ; preserve the listed registers on the stack
                    leax      $008B,U   ; form the referenced address without reading memory
                    ldd       ,X++      ; fetch the next value and advance the source pointer
                    std       ,Y++      ; store the value and advance the destination pointer
                    puls      X         ; restore the listed registers from the stack
                    lda       #$2F      ; load the value needed by the following operation
                    sta       ,Y+       ; store the value and advance the destination pointer
                    ldb       ,X        ; load the value needed by the following operation
                    bsr       Code_044F ; call the referenced helper routine
                    pshs      X         ; preserve the listed registers on the stack
                    leax      $008B,U   ; form the referenced address without reading memory
                    ldd       ,X++      ; fetch the next value and advance the source pointer
                    std       ,Y++      ; store the value and advance the destination pointer
                    puls      X         ; restore the listed registers from the stack
                    leay      $54,U     ; form the referenced address without reading memory
                    lda       #$41      ; load the value needed by the following operation
                    sta       Data_0044 ; save the current value in working storage
                    sta       $09,Y     ; save the current value in working storage
                    lda       #$4D      ; load the value needed by the following operation
                    sta       $0A,Y     ; save the current value in working storage
                    ldb       $03,X     ; load the value needed by the following operation
                    cmpb      #$0C      ; compare against the limit and set condition flags
                    blt       Code_04BE ; branch when the signed value is below the limit
                    subb      #$0C      ; subtract the operand from the running value
                    lda       #$50      ; load the value needed by the following operation
                    sta       Data_0044 ; save the current value in working storage
                    sta       $09,Y     ; save the current value in working storage
Code_04BE           tstb                ; set condition flags from the current value
                    bne       Code_04C3 ; branch when the compared values differ
                    addb      #$0C      ; add the operand to the running value
Code_04C3           bsr       Code_044F ; call the referenced helper routine
                    pshs      X         ; preserve the listed registers on the stack
                    leax      $008B,U   ; form the referenced address without reading memory
                    ldd       ,X++      ; fetch the next value and advance the source pointer
                    std       ,Y++      ; store the value and advance the destination pointer
                    puls      X         ; restore the listed registers from the stack
                    lda       #$3A      ; load the value needed by the following operation
                    sta       ,Y+       ; store the value and advance the destination pointer
                    ldb       $04,X     ; load the value needed by the following operation
                    lbsr      Code_044F ; call the referenced helper routine
                    pshs      X         ; preserve the listed registers on the stack
                    leax      $008B,U   ; form the referenced address without reading memory
                    ldd       ,X++      ; fetch the next value and advance the source pointer
                    std       ,Y++      ; store the value and advance the destination pointer
                    puls      X         ; restore the listed registers from the stack
                    lda       #$3A      ; load the value needed by the following operation
                    sta       ,Y+       ; store the value and advance the destination pointer
                    ldb       $05,X     ; load the value needed by the following operation
                    lbsr      Code_044F ; call the referenced helper routine
                    leax      $008B,U   ; form the referenced address without reading memory
                    ldd       ,X++      ; fetch the next value and advance the source pointer
                    std       ,Y++      ; store the value and advance the destination pointer
                    rts                 ; return to the caller
Code_04F8           pshs      Y,X,DP,D,CC ; preserve the listed registers on the stack
                    stu       DeskMateService ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "3"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       ">"                            ; embedded text or resource bytes
                    pshs      A         ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    lbsr      Code_00E4 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $16       ; private DeskMate service selector
                    lbsr      Code_0199 ; call the referenced helper routine
                    puls      A         ; restore the listed registers from the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    puls      Y,X,DP,D,CC ; restore the listed registers from the stack
                    ldu       DeskMateService ; load the value needed by the following operation
                    lds       $02,U     ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "W"                            ; embedded text or resource bytes
Data_0529           fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00 ; table, bitmap, or initialized data bytes
Data_0701           fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00 ; table, bitmap, or initialized data bytes
Data_0801           fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00 ; table, bitmap, or initialized data bytes
Code_09FC           pshs      D         ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "/"                            ; embedded text or resource bytes
                    tfr       A,DP      ; copy the source register into the destination register
                    clrb                ; clear the selected byte or register
                    tfr       D,U       ; copy the source register into the destination register
                    puls      PC,D      ; restore the listed registers from the stack
Code_0A09           pshs      U,Y,X,DP,D ; preserve the listed registers on the stack
                    lbsr      Code_09FC ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "9"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "0"                            ; embedded text or resource bytes
                    sta       Code_0026 ; save the current value in working storage
                    ldd       ,S        ; load the value needed by the following operation
                    stb       Code_001F ; save the current value in working storage
                    tsta                ; set condition flags from the current value
                    bpl       Code_0A40 ; branch while the tested value is nonnegative
                    anda      #$7F      ; mask off unwanted bits
                    sta       Addr_0020 ; save the current value in working storage
                    stx       Code_0021 ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "I"                            ; embedded text or resource bytes
                    tfr       Y,D       ; copy the source register into the destination register
                    stb       Code_0023 ; save the current value in working storage
                    tfr       X,D       ; copy the source register into the destination register
                    stb       Addr_0024 ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "4"                            ; embedded text or resource bytes
                    clr       Code_001E ; clear the selected byte or register
                    lda       #$FF      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1E       ; private DeskMate service selector
Code_0A3D           lbsr      Code_0B5D ; call the referenced helper routine
Code_0A40           lbsr      Code_0B78 ; call the referenced helper routine
Code_0A43           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $18       ; private DeskMate service selector
                    anda      #$80      ; mask off unwanted bits
                    ora       #$03      ; set the selected flag bits
                    tfr       A,B       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1C       ; private DeskMate service selector
                    tstb                ; set condition flags from the current value
                    bpl       Code_0A58 ; branch while the tested value is nonnegative
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $16       ; private DeskMate service selector
Code_0A58           sta       Addr_0025 ; save the current value in working storage
                    ldx       Code_0021 ; load the value needed by the following operation
                    ldb       Code_001F ; load the value needed by the following operation
                    leay      B,X       ; form the referenced address without reading memory
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bcs       Code_0A7C ; branch when carry reports an unsigned underflow or error
                    cmpa      #$7E      ; compare against the limit and set condition flags
                    bhi       Code_0A7C ; branch when the unsigned value is above the limit
                    tst       Code_001E ; set condition flags from the current value
                    lbne      Code_0B3D ; take the distant branch when values differ
Code_0A6E           sta       ,Y        ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "C"                            ; embedded text or resource bytes
Code_0A74           tst       $01,Y     ; set condition flags from the current value
                    beq       Code_0A43 ; branch when the compared values are equal
                    inc       Code_001F ; advance the selected counter
                    bra       Code_0A40 ; continue at the selected control-flow target
Code_0A7C           cmpa      #$88      ; compare against the limit and set condition flags
                    beq       Code_0ACB ; branch when the compared values are equal
                    cmpa      #$08      ; compare against the limit and set condition flags
                    beq       Code_0AF0 ; branch when the compared values are equal
                    cmpa      #$09      ; compare against the limit and set condition flags
                    beq       Code_0A74 ; branch when the compared values are equal
                    cmpa      #$C9      ; compare against the limit and set condition flags
                    lbeq      Code_0B14 ; take the distant branch when values are equal
                    cmpa      #$E9      ; compare against the limit and set condition flags
                    lbeq      Code_0B14 ; take the distant branch when values are equal
                    cmpa      #$0C      ; compare against the limit and set condition flags
                    beq       Code_0B0A ; branch when the compared values are equal
                    cmpa      #$0A      ; compare against the limit and set condition flags
                    beq       Code_0AF8 ; branch when the compared values are equal
                    cmpa      #$8D      ; compare against the limit and set condition flags
                    bne       Code_0AB7 ; branch when the compared values differ
                    lda       #$0D      ; load the value needed by the following operation
                    sta       Addr_0025 ; save the current value in working storage
Code_0AA4           lda       #$20      ; load the value needed by the following operation
                    sta       ,Y+       ; store the value and advance the destination pointer
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "C"                            ; embedded text or resource bytes
                    tst       ,Y        ; set condition flags from the current value
                    beq       Code_0AB7 ; branch when the compared values are equal
                    inc       Code_001F ; advance the selected counter
                    lbsr      Code_0B78 ; call the referenced helper routine
                    bra       Code_0AA4 ; continue at the selected control-flow target
Code_0AB7           ldb       Code_001F ; load the value needed by the following operation
                    lda       Code_0026 ; load the value needed by the following operation
                    beq       Code_0AC1 ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "3"                            ; embedded text or resource bytes
Code_0AC1           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       ":"                            ; embedded text or resource bytes
                    lda       Addr_0025 ; load the value needed by the following operation
                    leas      $02,S     ; form the referenced address without reading memory
                    puls      PC,U,Y,X,DP ; restore the listed registers from the stack
Code_0ACB           tst       Code_001E ; set condition flags from the current value
                    bne       Code_0B22 ; branch when the compared values differ
                    tstb                ; set condition flags from the current value
                    beq       Code_0AE5 ; branch when the compared values are equal
                    tst       $01,Y     ; set condition flags from the current value
                    bne       Code_0ADC ; branch when the compared values differ
                    lda       #$20      ; load the value needed by the following operation
                    cmpa      ,Y        ; compare against the limit and set condition flags
                    bne       Code_0AE5 ; branch when the compared values differ
Code_0ADC           dec       Code_001F ; decrement the selected counter
                    lbsr      Code_0B78 ; call the referenced helper routine
                    ldx       Code_0021 ; load the value needed by the following operation
                    ldb       Code_001F ; load the value needed by the following operation
Code_0AE5           lda       #$20      ; load the value needed by the following operation
                    sta       B,X       ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "C"                            ; embedded text or resource bytes
Code_0AED           lbra      Code_0A43 ; continue at the distant control-flow target
Code_0AF0           tstb                ; set condition flags from the current value
                    beq       Code_0AED ; branch when the compared values are equal
                    dec       Code_001F ; decrement the selected counter
                    lbra      Code_0A40 ; continue at the distant control-flow target
Code_0AF8           lda       Addr_0020 ; load the value needed by the following operation
Code_0AFA           deca                ; decrement the selected counter
                    bmi       Code_0B05 ; branch while the tested value is negative
                    incb                ; advance the selected counter
                    tst       B,X       ; set condition flags from the current value
                    bne       Code_0AFA ; branch when the compared values differ
Code_0B02           lbra      Code_0AC1 ; continue at the distant control-flow target
Code_0B05           stb       Code_001F ; save the current value in working storage
                    lbra      Code_0A40 ; continue at the distant control-flow target
Code_0B0A           lda       Addr_0020 ; load the value needed by the following operation
Code_0B0C           deca                ; decrement the selected counter
                    bmi       Code_0B05 ; branch while the tested value is negative
                    decb                ; decrement the selected counter
                    bmi       Code_0B02 ; branch while the tested value is negative
                    bra       Code_0B0C ; continue at the selected control-flow target
Code_0B14           lda       #$FF      ; load the value needed by the following operation
                    com       Code_001E ; invert every bit in the selected value
                    beq       Code_0B1C ; branch when the compared values are equal
                    lda       #$01      ; load the value needed by the following operation
Code_0B1C           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1E       ; private DeskMate service selector
                    bra       Code_0AED ; continue at the selected control-flow target
Code_0B22           tstb                ; set condition flags from the current value
                    bne       Code_0B28 ; branch when the compared values differ
                    incb                ; advance the selected counter
                    stb       Code_001F ; save the current value in working storage
Code_0B28           leax      B,X       ; form the referenced address without reading memory
Code_0B2A           lda       ,X+       ; fetch the next value and advance the source pointer
                    beq       Code_0B32 ; branch when the compared values are equal
                    sta       -$02,X    ; save the current value in working storage
                    bra       Code_0B2A ; continue at the selected control-flow target
Code_0B32           lda       #$20      ; load the value needed by the following operation
                    sta       -$02,X    ; save the current value in working storage
                    dec       Code_001F ; decrement the selected counter
                    bsr       Code_0B78 ; call the referenced helper routine
                    lbra      Code_0A3D ; continue at the distant control-flow target
Code_0B3D           tst       $01,Y     ; set condition flags from the current value
                    lbeq      Code_0A6E ; take the distant branch when values are equal
                    pshs      Y,A       ; preserve the listed registers on the stack
Code_0B45           lda       ,Y+       ; fetch the next value and advance the source pointer
                    bne       Code_0B45 ; branch when the compared values differ
                    leay      -$02,Y    ; form the referenced address without reading memory
Code_0B4B           lda       ,-Y       ; load the value needed by the following operation
                    sta       $01,Y     ; save the current value in working storage
                    cmpy      $01,S     ; compare against the limit and set condition flags
                    bne       Code_0B4B ; branch when the compared values differ
                    puls      X,A       ; restore the listed registers from the stack
                    sta       ,X        ; save the current value in working storage
                    bsr       Code_0B5D ; call the referenced helper routine
                    lbra      Code_0A74 ; continue at the distant control-flow target
Code_0B5D           ldx       Code_0021 ; load the value needed by the following operation
                    ldb       Code_001F ; load the value needed by the following operation
                    pshs      B         ; preserve the listed registers on the stack
                    leax      B,X       ; form the referenced address without reading memory
Code_0B65           bsr       Code_0B78 ; call the referenced helper routine
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    beq       Code_0B73 ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "C"                            ; embedded text or resource bytes
                    inc       Code_001F ; advance the selected counter
                    bra       Code_0B65 ; continue at the selected control-flow target
Code_0B73           puls      B         ; restore the listed registers from the stack
                    stb       Code_001F ; save the current value in working storage
                    rts                 ; return to the caller
Code_0B78           ldb       Code_001F ; load the value needed by the following operation
                    clra                ; clear the selected byte or register
Code_0B7B           inca                ; advance the selected counter
                    subb      Addr_0020 ; subtract the operand from the running value
                    bhi       Code_0B7B ; branch when the unsigned value is above the limit
                    beq       Code_0B85 ; branch when the compared values are equal
                    deca                ; decrement the selected counter
                    addb      Addr_0020 ; add the operand to the running value
Code_0B85           adda      Code_0023 ; add the operand to the running value
                    addb      Addr_0024 ; add the operand to the running value
                    pshs      Y,X       ; preserve the listed registers on the stack
                    pshs      A         ; preserve the listed registers on the stack
                    clra                ; clear the selected byte or register
                    tfr       D,X       ; copy the source register into the destination register
                    puls      B         ; restore the listed registers from the stack
                    tfr       D,Y       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    puls      PC,Y,X    ; restore the listed registers from the stack
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $80       ; table, bitmap, or initialized data bytes
Data_0B9C           fcc       "?"                            ; embedded text or resource bytes
                    fcb       $F0,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0,$00,$F0,$00,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<?"                           ; embedded text or resource bytes
                    fcb       $F0,$03,$C0,$0F,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$00,$00,$00,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "<?"                           ; embedded text or resource bytes
                    fcb       $F0,$00,$00,$00,$F0,$0F ; table, bitmap, or initialized data bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $F0,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $FF,$FC,$F0,$00 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $F0,$00,$00,$03,$00,$0C ; table, bitmap, or initialized data bytes
                    fcb       $C0       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $F0,$00   ; table, bitmap, or initialized data bytes
                    fcc       "<?"                           ; embedded text or resource bytes
                    fcb       $FC,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "<?"                           ; embedded text or resource bytes
                    fcb       $FC,$00,$00,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$00   ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $F0,$00   ; table, bitmap, or initialized data bytes
                    fcc       "<?"                           ; embedded text or resource bytes
                    fcb       $FC,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "<?"                           ; embedded text or resource bytes
                    fcb       $FC,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$03,$C0 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $F0,$00   ; table, bitmap, or initialized data bytes
                    fcc       "<?"                           ; embedded text or resource bytes
                    fcb       $FC,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "<?"                           ; embedded text or resource bytes
                    fcb       $FC,$00,$00,$0F,$C0 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0,$0F,$F0,$00 ; table, bitmap, or initialized data bytes
                    fcc       "<?"                           ; embedded text or resource bytes
                    fcb       $FC,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "<?"                           ; embedded text or resource bytes
                    fcb       $FC,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC,$F0,$00,$F0,$00 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC,$03,$C0,$0F,$00,$03 ; table, bitmap, or initialized data bytes
                    fcb       $00,$0C,$C0 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $F0,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $FF,$FC,$F0,$00 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $F0,$00,$00,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$00   ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $F0,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $FF,$FC,$F0,$00 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $F0,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$03,$C0 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $F0,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $FF,$FC,$F0,$00 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $F0,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "<<"                           ; embedded text or resource bytes
                    fcb       $00,$00,$03,$C0,$03,$C0 ; table, bitmap, or initialized data bytes
                    fcb       $03,$C0,$03,$C0,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $03,$C0,$0C ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $00,$00,$03,$C0,$03,$C0 ; table, bitmap, or initialized data bytes
                    fcb       $03,$C0,$03,$C0,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0F,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "<<<<<"                        ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "<<<<<"                        ; embedded text or resource bytes
                    fcb       $F0,$F0,$00,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $03,$00,$0F,$C0 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $FF,$FC,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$00,$0F,$C0 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0,$0F,$C0 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $FF,$FC,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$00,$00,$F0,$0F,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00   ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $F0,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "<?"                           ; embedded text or resource bytes
                    fcb       $F0,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $FC,$03,$C3 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FF,$C3,$C0 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FF,$00,$00,$03,$FF,$0F ; table, bitmap, or initialized data bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0,$F0,$FF,$FF,$F0,$F0 ; table, bitmap, or initialized data bytes
                    fcb       $F0,$F0,$FF,$00,$00,$03 ; table, bitmap, or initialized data bytes
                    fcb       $00,$0C,$C0,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $F0,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "<?"                           ; embedded text or resource bytes
                    fcb       $F0,$00,$00,$00,$00,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$00   ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $F0,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "<?"                           ; embedded text or resource bytes
                    fcb       $F0,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $F0,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $FF,$FC,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<?"                           ; embedded text or resource bytes
                    fcb       $F0,$00,$00,$03,$00,$0C ; table, bitmap, or initialized data bytes
                    fcb       $C0,$00,$00,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "<?"                           ; embedded text or resource bytes
                    fcb       $F0,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$03,$C0,$00,$00,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "<?"                           ; embedded text or resource bytes
                    fcb       $F0,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $F0,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $FF,$FC,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "<?"                           ; embedded text or resource bytes
                    fcb       $F0,$00,$00,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<?"                           ; embedded text or resource bytes
                    fcb       $F0,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "<?"                           ; embedded text or resource bytes
                    fcb       $F0,$00,$00,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$00,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "<?"                           ; embedded text or resource bytes
                    fcb       $F0,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC,$F0,$00 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $F0,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "<?"                           ; embedded text or resource bytes
                    fcb       $F0,$00   ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $FF,$F0,$00,$00,$0F,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<<<"                          ; embedded text or resource bytes
                    fcb       $00,$FF,$C0 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "?<"                           ; embedded text or resource bytes
                    fcb       $F3,$F0,$00,$00,$0F,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0F,$00,$FF,$F0,$0F,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0F,$00,$00,$00,$FF,$F0 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$0F,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<<<<"                         ; embedded text or resource bytes
                    fcb       $0F,$F0,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$F0 ; table, bitmap, or initialized data bytes
                    fcb       $03,$CC,$0F,$00,$0F,$00 ; table, bitmap, or initialized data bytes
                    fcb       $FF,$C0   ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$F0,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$0F,$C0,$0F,$C0,$0F ; table, bitmap, or initialized data bytes
                    fcb       $C0,$03,$00,$03,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$03,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0,$0C,$C0,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0,$FF,$FC ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0,$FF,$FC ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0,$00,$00,$00,$00,$03 ; table, bitmap, or initialized data bytes
                    fcb       $C0,$0F,$FC ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $C0,$0F,$F0,$03,$CC ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $F0,$03,$C0,$00,$00,$0F ; table, bitmap, or initialized data bytes
                    fcb       $0C,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$F0,$03,$C0,$0F ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $0C       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$00,$00,$00,$0F,$C0 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0,$0F,$C0 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $C0,$F0,$FC,$F3,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "?<"                           ; embedded text or resource bytes
                    fcb       $00,$00,$03,$C0,$00,$C0 ; table, bitmap, or initialized data bytes
                    fcb       $03,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$F0,$03,$C0,$0F,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0F,$00,$0F,$00,$03,$C0 ; table, bitmap, or initialized data bytes
                    fcb       $00,$F0,$00,$00,$0F,$00 ; table, bitmap, or initialized data bytes
                    fcb       $03,$C0,$00,$F0,$00,$F0 ; table, bitmap, or initialized data bytes
                    fcb       $00,$F0,$03,$C0,$0F,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$03,$C0 ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $CC,$0F,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $CC,$03,$C0,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$03,$C0,$03 ; table, bitmap, or initialized data bytes
                    fcb       $C0       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC,$03,$C0,$03,$C0,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$0F ; table, bitmap, or initialized data bytes
                    fcb       $00,$03,$00,$0C,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$0F,$F0,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$0F,$00,$0F ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$0C,$00 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$F0,$03,$C0,$0F,$00 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $00,$00,$00,$0F,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<<<"                          ; embedded text or resource bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       "?<<<"                         ; embedded text or resource bytes
                    fcb       $0F,$F0,$00,$00,$03,$C0 ; table, bitmap, or initialized data bytes
                    fcb       $0F,$C0,$03,$C0,$03,$C0 ; table, bitmap, or initialized data bytes
                    fcb       $03,$C0,$03,$C0,$0F,$F0 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$0F,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<<"                           ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$F0,$03,$C0 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC,$00,$00,$0F,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<<"                           ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $03,$F0,$00 ; table, bitmap, or initialized data bytes
                    fcc       "<<<"                          ; embedded text or resource bytes
                    fcb       $0F,$F0,$00,$00,$00,$F0 ; table, bitmap, or initialized data bytes
                    fcb       $03,$F0,$0C,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0,$FF,$FC,$00,$F0,$00 ; table, bitmap, or initialized data bytes
                    fcb       $F0,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "<<"                           ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "<<"                           ; embedded text or resource bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $F0,$00,$00,$0F,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<<<"                          ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "<<<<"                         ; embedded text or resource bytes
                    fcb       $0F,$F0,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC,$00   ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$F0,$03,$C0,$0F,$00 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$00,$00,$0F,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<<<<"                         ; embedded text or resource bytes
                    fcb       $0F,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "<<<<"                         ; embedded text or resource bytes
                    fcb       $0F,$F0,$00,$00,$0F,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<<<<"                         ; embedded text or resource bytes
                    fcb       $0F,$FC,$00 ; table, bitmap, or initialized data bytes
                    fcc       "<<<"                          ; embedded text or resource bytes
                    fcb       $0F,$F0,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$0F,$00,$0F,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$0F,$00,$0F,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0F,$00,$00,$00,$0F,$00 ; table, bitmap, or initialized data bytes
                    fcb       $03,$00,$0C,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$F0,$03,$C0,$0F,$00 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$0F,$00,$03,$C0,$00 ; table, bitmap, or initialized data bytes
                    fcb       $F0,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$0F,$F0,$00,$00,$0F ; table, bitmap, or initialized data bytes
                    fcb       $F0,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$0F,$00,$03,$C0,$00 ; table, bitmap, or initialized data bytes
                    fcb       $F0,$03,$C0,$0F,$00 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$00,$00,$0F,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<<"                           ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$F0,$03,$C0,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $03,$C0,$00,$00,$0F,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $0C,$C3,$FC,$C3 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $C3,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $00,$0F,$F0,$00,$00,$03 ; table, bitmap, or initialized data bytes
                    fcb       $C0,$0F,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<<<<?"                        ; embedded text or resource bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       "<<<<"                         ; embedded text or resource bytes
                    fcb       $00,$00   ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "<<<<?"                        ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "<<<<?"                        ; embedded text or resource bytes
                    fcb       $F0,$00,$00,$0F,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<<<"                          ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "<<"                           ; embedded text or resource bytes
                    fcb       $0F,$F0,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $C0       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "<<<<<<<"                      ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $C0,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$00,$00,$0F,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<<<"                          ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       "<<<<"                         ; embedded text or resource bytes
                    fcb       $0F,$F0,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "<<<<<<?"                      ; embedded text or resource bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       "<<<<<<"                       ; embedded text or resource bytes
                    fcb       $00,$00,$0F,$F0,$03,$C0 ; table, bitmap, or initialized data bytes
                    fcb       $03,$C0,$03,$C0,$03,$C0 ; table, bitmap, or initialized data bytes
                    fcb       $03,$C0,$0F,$F0,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $03,$FC,$00,$F0,$00,$F0 ; table, bitmap, or initialized data bytes
                    fcb       $00,$F0,$00,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0,$0F,$C0,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "<<<<<"                        ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $C0       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "<<<<"                         ; embedded text or resource bytes
                    fcb       $00,$00   ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC,$00,$00,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $FF,$FC,$FF,$FC,$F3 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$00   ; table, bitmap, or initialized data bytes
                    fcc       "<<<<?<?"                      ; embedded text or resource bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       "<<<<"                         ; embedded text or resource bytes
                    fcb       $00,$00,$0F,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<<<<<<<<<<"                   ; embedded text or resource bytes
                    fcb       $0F,$F0,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "<<<<<<?"                      ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$00,$00,$0F,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<<<<<<<<?"                    ; embedded text or resource bytes
                    fcb       $F0,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$00   ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "<<<<<<?"                      ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "<<"                           ; embedded text or resource bytes
                    fcb       $00,$00,$0F,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<<<"                          ; embedded text or resource bytes
                    fcb       $00,$0F,$F0,$00 ; table, bitmap, or initialized data bytes
                    fcc       "<<<"                          ; embedded text or resource bytes
                    fcb       $0F,$F0,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC,$03,$C0,$03,$C0,$03 ; table, bitmap, or initialized data bytes
                    fcb       $C0,$03,$C0,$03,$C0,$03 ; table, bitmap, or initialized data bytes
                    fcb       $C0,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "<<<<<<<<<<<<"                 ; embedded text or resource bytes
                    fcb       $0F,$F0,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "<<<<<<<<"                     ; embedded text or resource bytes
                    fcb       $0F,$F0,$0F,$F0,$03,$C0 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F3       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $FF,$FC,$FF,$FC,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$00   ; table, bitmap, or initialized data bytes
                    fcc       "<<<<"                         ; embedded text or resource bytes
                    fcb       $0F,$F0,$03,$C0,$0F,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<<<<"                         ; embedded text or resource bytes
                    fcb       $00,$00   ; table, bitmap, or initialized data bytes
                    fcc       "<<<<<<"                       ; embedded text or resource bytes
                    fcb       $0F,$F0,$03,$C0,$03,$C0 ; table, bitmap, or initialized data bytes
                    fcb       $03,$C0,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC,$00   ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$F0,$03,$C0,$0F,$00 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC,$00,$00,$0F,$F0,$0F ; table, bitmap, or initialized data bytes
                    fcb       $00,$0F,$00,$0F,$00,$0F ; table, bitmap, or initialized data bytes
                    fcb       $00,$0F,$00,$0F,$F0,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$0F,$00,$03,$C0,$00 ; table, bitmap, or initialized data bytes
                    fcb       $F0,$00   ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$0C,$00,$00,$03,$FC ; table, bitmap, or initialized data bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $03,$FC,$00,$00,$00,$C0 ; table, bitmap, or initialized data bytes
                    fcb       $03,$F0,$0F ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC,$03,$C0,$03,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $C0,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$0F,$F0,$00 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $0F,$FC   ; table, bitmap, or initialized data bytes
                    fcc       "<<"                           ; embedded text or resource bytes
                    fcb       $0F,$FC,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "<<<<?"                        ; embedded text or resource bytes
                    fcb       $F0,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$0F,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<<<"                          ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "<<"                           ; embedded text or resource bytes
                    fcb       $0F,$F0,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $0F,$FC   ; table, bitmap, or initialized data bytes
                    fcc       "<<<<"                         ; embedded text or resource bytes
                    fcb       $0F,$FC,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$0F,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<<?"                          ; embedded text or resource bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$0F,$F0,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $F0,$03,$C0,$03,$C0,$03 ; table, bitmap, or initialized data bytes
                    fcb       $C0,$0F,$F0,$03,$C0,$03 ; table, bitmap, or initialized data bytes
                    fcb       $C0,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$0F,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<<<<"                         ; embedded text or resource bytes
                    fcb       $0F,$FC,$00 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $0F,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "<<<<<<"                       ; embedded text or resource bytes
                    fcb       $00,$00,$00,$00,$03,$C0 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$03,$C0,$03,$C0 ; table, bitmap, or initialized data bytes
                    fcb       $03,$C0,$03,$C0,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$F0,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$F0,$00,$F0,$00,$F0 ; table, bitmap, or initialized data bytes
                    fcb       $00,$F0,$0F,$C0 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "<<<"                          ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $C0       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "<<"                           ; embedded text or resource bytes
                    fcb       $00,$00,$03,$C0,$03,$C0 ; table, bitmap, or initialized data bytes
                    fcb       $03,$C0,$03,$C0,$03,$C0 ; table, bitmap, or initialized data bytes
                    fcb       $03,$C0,$03,$C0,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0,$FF,$FC,$FF,$FC,$F3 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "?<<<<<<<"                     ; embedded text or resource bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0F,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "<<<<<<"                       ; embedded text or resource bytes
                    fcb       $0F,$F0,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00   ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "<<<<?"                        ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$00,$00,$00,$00,$0F ; table, bitmap, or initialized data bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       "<<<<"                         ; embedded text or resource bytes
                    fcb       $0F,$FC,$00 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "?<<"                          ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$0F,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$0F,$F0,$00 ; table, bitmap, or initialized data bytes
                    fcc       "<?"                           ; embedded text or resource bytes
                    fcb       $F0,$00,$00,$03,$C0,$03 ; table, bitmap, or initialized data bytes
                    fcb       $C0,$0F,$F0,$03,$C0,$03 ; table, bitmap, or initialized data bytes
                    fcb       $C0,$03,$C0,$00,$F0,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "<<<<<<<<"                     ; embedded text or resource bytes
                    fcb       $0F,$F0,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00   ; table, bitmap, or initialized data bytes
                    fcc       "<<<<"                         ; embedded text or resource bytes
                    fcb       $0C       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $0F,$F0,$03,$C0,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F3       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $FF,$FC,$FF,$FC ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "<<"                           ; embedded text or resource bytes
                    fcb       $0F,$F0,$03,$C0,$0F,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<<"                           ; embedded text or resource bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "<<<<<<"                       ; embedded text or resource bytes
                    fcb       $0F,$FC,$00 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $0F,$F0,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC,$00,$F0,$03,$C0,$0F ; table, bitmap, or initialized data bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$F0,$00,$F0,$03,$C0 ; table, bitmap, or initialized data bytes
                    fcb       $00,$F0,$00,$F0,$00 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$00,$03,$C0,$03,$C0 ; table, bitmap, or initialized data bytes
                    fcb       $03,$C0,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $03,$C0,$03,$C0,$03,$C0 ; table, bitmap, or initialized data bytes
                    fcb       $0F,$00,$03,$C0,$03,$C0 ; table, bitmap, or initialized data bytes
                    fcb       $00,$F0,$03,$C0,$03,$C0 ; table, bitmap, or initialized data bytes
                    fcb       $0F,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0F,$0C   ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
Data_139E           fcb       $CC,$CC   ; table, bitmap, or initialized data bytes
                    fcc       "33"                           ; embedded text or resource bytes
                    fcb       $CC,$CC   ; table, bitmap, or initialized data bytes
                    fcc       "33"                           ; embedded text or resource bytes
                    fcb       $CC,$CC   ; table, bitmap, or initialized data bytes
                    fcc       "33"                           ; embedded text or resource bytes
                    fcb       $CC,$CC   ; table, bitmap, or initialized data bytes
                    fcb       $33,$33   ; table, bitmap, or initialized data bytes

                    emod
eom                 equ       *
                    end
