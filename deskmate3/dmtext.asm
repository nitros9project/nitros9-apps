********************************************************************
* DMTEXT - DeskMate 3 text editor
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

                    nam       DMTEXT
                    ttl       DeskMate 3 text editor

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct
atrv                set       $00

                    mod       eom,name,tylg,atrv,start,$0457

name                fcs       /DMTEXT/ ; OS-9 module name

Addr_0001           equ       $0001     ; absolute address used by original code
Addr_0002           equ       $0002     ; absolute address used by original code
Addr_0004           equ       $0004     ; absolute address used by original code
Addr_0005           equ       $0005     ; absolute address used by original code
Addr_0006           equ       $0006     ; absolute address used by original code
Addr_0008           equ       $0008     ; absolute address used by original code
Addr_000A           equ       $000A     ; absolute address used by original code
Addr_000C           equ       $000C     ; absolute address used by original code
Addr_000D           equ       $000D     ; absolute address used by original code
Addr_000E           equ       $000E     ; absolute address used by original code
Addr_0010           equ       $0010     ; absolute address used by original code
Addr_0012           equ       $0012     ; absolute address used by original code
Addr_0014           equ       $0014     ; absolute address used by original code
Addr_0018           equ       $0018     ; absolute address used by original code
Addr_001E           equ       $001E     ; absolute address used by original code
Addr_0029           equ       $0029     ; absolute address used by original code
Addr_002A           equ       $002A     ; absolute address used by original code
Addr_002E           equ       $002E     ; absolute address used by original code
Addr_0036           equ       $0036     ; absolute address used by original code
Addr_0038           equ       $0038     ; absolute address used by original code
Addr_003A           equ       $003A     ; absolute address used by original code
Addr_003E           equ       $003E     ; absolute address used by original code
Addr_0040           equ       $0040     ; absolute address used by original code
Addr_0042           equ       $0042     ; absolute address used by original code
Addr_0044           equ       $0044     ; absolute address used by original code
Addr_0048           equ       $0048     ; absolute address used by original code
Addr_004A           equ       $004A     ; absolute address used by original code
Addr_004C           equ       $004C     ; absolute address used by original code
Addr_004E           equ       $004E     ; absolute address used by original code
Addr_0050           equ       $0050     ; absolute address used by original code
Addr_0052           equ       $0052     ; absolute address used by original code
Addr_0054           equ       $0054     ; absolute address used by original code
Addr_0056           equ       $0056     ; absolute address used by original code
Addr_0058           equ       $0058     ; absolute address used by original code
Addr_005A           equ       $005A     ; absolute address used by original code
Addr_005C           equ       $005C     ; absolute address used by original code
Addr_005E           equ       $005E     ; absolute address used by original code
Addr_0061           equ       $0061     ; absolute address used by original code
Addr_0063           equ       $0063     ; absolute address used by original code
Addr_00FF           equ       $00FF     ; absolute address used by original code
Addr_0137           equ       $0137     ; absolute address used by original code
Addr_013C           equ       $013C     ; absolute address used by original code
Addr_0D13           equ       $0D13     ; absolute address used by original code
Addr_121A           equ       $121A     ; absolute address used by original code
Addr_2000           equ       $2000     ; absolute address used by original code
Addr_2028           equ       $2028     ; absolute address used by original code
Addr_400D           equ       $400D     ; absolute address used by original code
Addr_4016           equ       $4016     ; absolute address used by original code
Addr_4018           equ       $4018     ; absolute address used by original code
Addr_402A           equ       $402A     ; absolute address used by original code
Addr_7FFF           equ       $7FFF     ; absolute address used by original code
Addr_A80F           equ       $A80F     ; absolute address used by original code
Addr_A817           equ       $A817     ; absolute address used by original code
Addr_A81D           equ       $A81D     ; absolute address used by original code
Addr_A82B           equ       $A82B     ; absolute address used by original code
DeskMateService     equ       $0000     ; absolute address used by original code

start               jmp       >DeskMateService ; dispatch control through the selected target
Code_0016           leas      $0456,U   ; form the referenced address without reading memory
Code_001A           pshs      X         ; preserve the listed registers on the stack
Code_001C           leax      Data_2B00,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $07       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
Data_0027           fcb       $06       ; private DeskMate service selector
Code_0028           leax      Data_3302,PCR ; form the referenced address without reading memory
Code_002C           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $08       ; private DeskMate service selector
Code_0030           puls      X         ; restore the listed registers from the stack
                    lbra      Code_0035 ; continue at the distant control-flow target
Code_0035           stx       DeskMateService ; save the current value in working storage
                    pshs      X         ; preserve the listed registers on the stack
                    leax      $6B,U     ; form the referenced address without reading memory
Code_003C           lbsr      Code_142F ; call the referenced helper routine
                    tfr       X,Y       ; copy the source register into the destination register
                    puls      X         ; restore the listed registers from the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
Data_0046           fcc       "3"                            ; embedded text or resource bytes
                    lda       ,X        ; load the value needed by the following operation
                    cmpa      #$0D      ; compare against the limit and set condition flags
Code_004B           beq       Code_0071 ; branch when the compared values are equal
Code_004D           ldb       $01,X     ; load the value needed by the following operation
Code_004F           cmpb      #$3A      ; compare against the limit and set condition flags
Code_0051           bne       Code_005F ; branch when the compared values differ
Code_0053           cmpa      #$31      ; compare against the limit and set condition flags
Code_0055           beq       Code_005B ; branch when the compared values are equal
Code_0057           cmpa      #$32      ; compare against the limit and set condition flags
Code_0059           bne       Code_0071 ; branch when the compared values differ
Code_005B           std       ,Y++      ; store the value and advance the destination pointer
                    leax      $02,X     ; form the referenced address without reading memory
Code_005F           clrb                ; clear the selected byte or register
Code_0060           lda       B,X       ; load the value needed by the following operation
Code_0062           cmpa      #$0D      ; compare against the limit and set condition flags
                    beq       Code_0071 ; branch when the compared values are equal
                    cmpa      #$2E      ; compare against the limit and set condition flags
                    beq       Code_0071 ; branch when the compared values are equal
Code_006A           sta       B,Y       ; save the current value in working storage
                    incb                ; advance the selected counter
                    cmpb      #$08      ; compare against the limit and set condition flags
                    bne       Code_0060 ; branch when the compared values differ
Code_0071           leax      Data_0812,PCR ; form the referenced address without reading memory
                    leay      $76,U     ; form the referenced address without reading memory
Code_0078           lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,Y+       ; store the value and advance the destination pointer
                    bne       Code_0078 ; branch when the compared values differ
                    lbsr      Code_1C4C ; call the referenced helper routine
                    ldy       DeskMateService ; load the value needed by the following operation
                    sty       Addr_0002 ; save the current value in working storage
                    sty       Addr_0004 ; save the current value in working storage
                    sty       Addr_0008 ; save the current value in working storage
                    lda       #$1A      ; load the value needed by the following operation
                    sta       ,Y        ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    sta       Addr_0052 ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    lbsr      Code_0720 ; call the referenced helper routine
                    lda       Addr_004A ; load the value needed by the following operation
                    deca                ; decrement the selected counter
                    sta       Code_0051 ; save the current value in working storage
                    lda       #$FF      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1E       ; private DeskMate service selector
                    lbsr      Code_08A5 ; call the referenced helper routine
                    lbsr      Code_0E49 ; call the referenced helper routine
                    ldx       #DeskMateService ; load the value needed by the following operation
                    stx       Addr_0012 ; save the current value in working storage
                    stx       Addr_0014 ; save the current value in working storage
                    stx       Addr_001E ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    sta       Code_004B ; save the current value in working storage
                    sta       Addr_004C ; save the current value in working storage
                    sta       Code_004D ; save the current value in working storage
                    sta       Code_004F ; save the current value in working storage
                    sta       Addr_0050 ; save the current value in working storage
                    sta       Code_0057 ; save the current value in working storage
                    sta       Code_0060 ; save the current value in working storage
                    sta       Addr_0061 ; save the current value in working storage
                    sta       Addr_004E ; save the current value in working storage
                    lda       #$01      ; load the value needed by the following operation
                    sta       Code_0053 ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "N"                            ; embedded text or resource bytes
                    tst       $24,X     ; set condition flags from the current value
                    beq       Code_00D9 ; branch when the compared values are equal
                    lbsr      start     ;00D5: 17 FF 3B       '.. ; call the referenced helper routine
                    fcb       $14       ; private DeskMate service selector
Code_00D9           lda       #$02      ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    lda       #$02      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "!"                            ; embedded text or resource bytes
                    ldd       #Addr_0036 ; load the value needed by the following operation
                    leax      $7A,U     ; form the referenced address without reading memory
Code_00EC           sta       ,X+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bne       Code_00EC ; branch when the compared values differ
                    leax      $00BB,U   ; form the referenced address without reading memory
                    leay      $0116,U   ; form the referenced address without reading memory
                    ldd       #Addr_2028 ; load the value needed by the following operation
Code_00FC           sta       ,X+       ; store the value and advance the destination pointer
                    sta       ,Y+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bne       Code_00FC ; branch when the compared values differ
                    stb       ,X        ; save the current value in working storage
                    stb       ,Y        ; save the current value in working storage
                    leax      $6B,U     ; form the referenced address without reading memory
                    lda       ,X        ; load the value needed by the following operation
                    cmpa      #$20      ; compare against the limit and set condition flags
                    beq       Code_0121 ; branch when the compared values are equal
                    lbsr      Code_12D6 ; call the referenced helper routine
                    tstb                ; set condition flags from the current value
                    bne       Code_011B ; branch when the compared values differ
                    lbsr      Code_12A6 ; call the referenced helper routine
                    bcc       Code_0121 ; branch when carry is clear
Code_011B           leax      $6B,U     ; form the referenced address without reading memory
                    lbsr      Code_142F ; call the referenced helper routine
Code_0121           ldx       Addr_0008 ; load the value needed by the following operation
                    lbsr      Code_0ADF ; call the referenced helper routine
                    stx       Addr_000C ; save the current value in working storage
                    lda       Code_004F ; load the value needed by the following operation
                    bne       Code_014A ; branch when the compared values differ
                    ldy       Addr_0008 ; load the value needed by the following operation
                    lbsr      Code_0C92 ; call the referenced helper routine
                    cmpb      #$16      ; compare against the limit and set condition flags
                    bcs       Code_0142 ; branch when carry reports an unsigned underflow or error
                    ldx       Addr_0002 ; load the value needed by the following operation
                    lbsr      Code_0C20 ; call the referenced helper routine
                    stx       Addr_0002 ; save the current value in working storage
                    lda       #$01      ; load the value needed by the following operation
                    sta       Code_0053 ; save the current value in working storage
Code_0141           decb                ; decrement the selected counter
Code_0142           stb       Addr_004C ; save the current value in working storage
                    ldd       Addr_0008 ; load the value needed by the following operation
Code_0146           subd      Addr_000C ; subtract the operand from the running value
                    stb       Code_004D ; save the current value in working storage
Code_014A           lbsr      Code_0966 ; call the referenced helper routine
                    lda       Code_0053 ; load the value needed by the following operation
                    lbsr      Code_2170 ; call the referenced helper routine
                    ldb       Code_004D ; load the value needed by the following operation
                    lda       Addr_004C ; load the value needed by the following operation
                    lbsr      Code_08AE ; call the referenced helper routine
                    lbsr      Code_1A03 ; call the referenced helper routine
                    lda       Code_0055 ; load the value needed by the following operation
                    lbeq      Code_0121 ; take the distant branch when values are equal
                    ldx       Addr_0008 ; load the value needed by the following operation
                    stx       Addr_000A ; save the current value in working storage
                    cmpa      #$20      ; compare against the limit and set condition flags
                    lbcs      Code_0220 ; take the distant branch when carry reports an error
                    cmpa      #$80      ; compare against the limit and set condition flags
                    lbcc      Code_0220 ; take the distant branch when carry is clear
                    lbsr      Code_0DD4 ; call the referenced helper routine
                    bcs       Code_0196 ; branch when carry reports an unsigned underflow or error
                    pshs      X         ; preserve the listed registers on the stack
                    leax      $55,U     ; form the referenced address without reading memory
                    tfr       X,Y       ; copy the source register into the destination register
                    leay      $01,Y     ; form the referenced address without reading memory
                    clrb                ; clear the selected byte or register
                    lbsr      Code_023F ; call the referenced helper routine
                    bcs       Code_0187 ; branch when carry reports an unsigned underflow or error
                    incb                ; advance the selected counter
Code_0187           lbsr      Code_0256 ; call the referenced helper routine
                    lbsr      Code_023F ; call the referenced helper routine
                    bcc       Code_0190 ; branch when carry is clear
                    incb                ; advance the selected counter
Code_0190           clra                ; clear the selected byte or register
                    cmpd      ,S++      ; compare against the limit and set condition flags
                    bls       Code_019C ; branch when the unsigned value is at or below the limit
Code_0196           lbsr      Code_0A50 ; call the referenced helper routine
                    lbra      Code_0121 ; continue at the distant control-flow target
Code_019C           lbsr      Code_0DB6 ; call the referenced helper routine
                    clr       Code_0059 ; clear the selected byte or register
                    ldx       Addr_0008 ; load the value needed by the following operation
                    ldb       Code_0055 ; load the value needed by the following operation
                    lda       Addr_004E ; load the value needed by the following operation
                    bne       Code_01BD ; branch when the compared values differ
                    lda       ,X        ; load the value needed by the following operation
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bcc       Code_01DD ; branch when carry is clear
                    cmpa      #$0A      ; compare against the limit and set condition flags
                    bne       Code_01BD ; branch when the compared values differ
                    cmpb      #$20      ; compare against the limit and set condition flags
                    beq       Code_0215 ; branch when the compared values are equal
                    lda       #$01      ; load the value needed by the following operation
                    sta       Addr_0054 ; save the current value in working storage
                    bra       Code_01DD ; continue at the selected control-flow target
Code_01BD           lda       Code_004D ; load the value needed by the following operation
                    cmpa      Code_0051 ; compare against the limit and set condition flags
                    bne       Code_01D6 ; branch when the compared values differ
                    cmpb      #$20      ; compare against the limit and set condition flags
                    beq       Code_01D6 ; branch when the compared values are equal
                    pshs      B         ; preserve the listed registers on the stack
                    ldx       Addr_000C ; load the value needed by the following operation
                    lbsr      Code_0A63 ; call the referenced helper routine
                    cmpb      Code_0051 ; compare against the limit and set condition flags
                    puls      B         ; restore the listed registers from the stack
                    bcs       Code_01D6 ; branch when carry reports an unsigned underflow or error
                    inc       Code_0059 ; advance the selected counter
Code_01D6           ldx       Addr_0008 ; load the value needed by the following operation
                    lbsr      Code_0D9D ; call the referenced helper routine
                    bra       Code_01F0 ; continue at the selected control-flow target
Code_01DD           stb       ,X+       ; store the value and advance the destination pointer
                    ldb       Code_004D ; load the value needed by the following operation
                    cmpb      Code_0051 ; compare against the limit and set condition flags
                    bne       Code_01F0 ; branch when the compared values differ
                    ldx       Addr_000C ; load the value needed by the following operation
                    lbsr      Code_0A63 ; call the referenced helper routine
                    cmpb      Code_0051 ; compare against the limit and set condition flags
                    bls       Code_01F0 ; branch when the unsigned value is at or below the limit
                    inc       Code_0059 ; advance the selected counter
Code_01F0           lda       Code_004B ; load the value needed by the following operation
                    beq       Code_01F7 ; branch when the compared values are equal
                    lbsr      Code_0956 ; call the referenced helper routine
Code_01F7           lda       Addr_004C ; load the value needed by the following operation
                    cmpa      #$15      ; compare against the limit and set condition flags
                    bne       Code_0212 ; branch when the compared values differ
                    lda       Code_004D ; load the value needed by the following operation
                    cmpa      Code_0051 ; compare against the limit and set condition flags
                    bcs       Code_0212 ; branch when carry reports an unsigned underflow or error
                    tst       Addr_004E ; set condition flags from the current value
                    bne       Code_0212 ; branch when the compared values differ
                    ldx       Addr_0002 ; load the value needed by the following operation
                    lbsr      Code_0C20 ; call the referenced helper routine
                    stx       Addr_0002 ; save the current value in working storage
                    lda       #$01      ; load the value needed by the following operation
                    sta       Code_0053 ; save the current value in working storage
Code_0212           lbsr      Code_1FD7 ; call the referenced helper routine
Code_0215           ldx       Addr_0008 ; load the value needed by the following operation
                    ldb       Code_0059 ; load the value needed by the following operation
                    incb                ; advance the selected counter
                    abx                 ; add the operand to the running value
                    stx       Addr_0008 ; save the current value in working storage
                    lbra      Code_0121 ; continue at the distant control-flow target
Code_0220           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1B       ; private DeskMate service selector
                    lda       Code_0055 ; load the value needed by the following operation
                    leax      Data_02ED,PCR ; form the referenced address without reading memory
                    lbsr      Code_02DC ; call the referenced helper routine
                    lbcs      Code_0121 ; take the distant branch when carry reports an error
                    leax      Data_030C,PCR ; form the referenced address without reading memory
                    pshs      B         ; preserve the listed registers on the stack
                    clra                ; clear the selected byte or register
                    aslb                ; shift left and update carry
                    addb      ,S+       ; add the operand to the running value
                    abx                 ; add the operand to the running value
                    pshs      X         ; preserve the listed registers on the stack
                    rts                 ; return to the caller
Code_023F           tst       Addr_004E ; set condition flags from the current value
                    bne       Code_0253 ; branch when the compared values differ
                    pshs      X         ; preserve the listed registers on the stack
                    ldx       Addr_0008 ; load the value needed by the following operation
                    lda       ,X        ; load the value needed by the following operation
                    puls      X         ; restore the listed registers from the stack
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bcc       Code_0255 ; branch when carry is clear
                    cmpa      #$0A      ; compare against the limit and set condition flags
                    beq       Code_0255 ; branch when the compared values are equal
Code_0253           orcc      #$01      ; set the selected flag bits
Code_0255           rts                 ; return to the caller
Code_0256           pshs      Y,X       ; preserve the listed registers on the stack
                    stb       Addr_005C ; save the current value in working storage
                    stx       Code_001A ; save the current value in working storage
                    ldy       Addr_0008 ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
Code_0260           cmpy      DeskMateService ; compare against the limit and set condition flags
                    beq       Code_026D ; branch when the compared values are equal
                    lda       ,-Y       ; load the value needed by the following operation
                    incb                ; advance the selected counter
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bhi       Code_0260 ; branch when the unsigned value is above the limit
Code_026C           decb                ; decrement the selected counter
Code_026D           stb       Addr_005A ; save the current value in working storage
                    pshs      B         ; preserve the listed registers on the stack
                    clrb                ; clear the selected byte or register
Code_0272           cmpx      $03,S     ; compare against the limit and set condition flags
                    beq       Code_0280 ; branch when the compared values are equal
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    incb                ; advance the selected counter
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bhi       Code_0272 ; branch when the unsigned value is above the limit
                    decb                ; decrement the selected counter
                    leax      -$01,X    ; form the referenced address without reading memory
Code_0280           addb      ,S+       ; add the operand to the running value
                    bsr       Code_02CF ; call the referenced helper routine
                    pshs      B         ; preserve the listed registers on the stack
                    cmpx      $03,S     ; compare against the limit and set condition flags
                    bne       Code_029D ; branch when the compared values differ
                    tstb                ; set condition flags from the current value
                    beq       Code_029D ; branch when the compared values are equal
                    tfr       B,A       ; copy the source register into the destination register
                    ldx       Code_001A ; load the value needed by the following operation
                    ldb       Addr_004A ; load the value needed by the following operation
                    subb      Addr_005A ; subtract the operand from the running value
Code_0295           abx                 ; add the operand to the running value
                    ldb       Addr_004A ; load the value needed by the following operation
                    deca                ; decrement the selected counter
                    bne       Code_0295 ; branch when the compared values differ
                    stx       Code_001A ; save the current value in working storage
Code_029D           ldy       Addr_0008 ; load the value needed by the following operation
                    ldb       Addr_005C ; load the value needed by the following operation
                    leay      B,Y       ; form the referenced address without reading memory
                    clrb                ; clear the selected byte or register
Code_02A5           cmpy      Addr_0004 ; compare against the limit and set condition flags
                    beq       Code_02B2 ; branch when the compared values are equal
                    lda       ,Y+       ; fetch the next value and advance the source pointer
                    incb                ; advance the selected counter
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bhi       Code_02A5 ; branch when the unsigned value is above the limit
                    decb                ; decrement the selected counter
Code_02B2           pshs      B         ; preserve the listed registers on the stack
                    ldy       $04,S     ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
Code_02B8           cmpy      Code_001A ; compare against the limit and set condition flags
                    beq       Code_02C5 ; branch when the compared values are equal
                    lda       ,-Y       ; load the value needed by the following operation
                    incb                ; advance the selected counter
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bhi       Code_02B8 ; branch when the unsigned value is above the limit
                    decb                ; decrement the selected counter
Code_02C5           addb      ,S+       ; add the operand to the running value
                    bsr       Code_02CF ; call the referenced helper routine
                    addb      ,S+       ; add the operand to the running value
                    clra                ; clear the selected byte or register
                    puls      Y,X       ; restore the listed registers from the stack
                    rts                 ; return to the caller
Code_02CF           tfr       B,A       ; copy the source register into the destination register
                    clrb                ; clear the selected byte or register
Code_02D2           cmpa      Addr_004A ; compare against the limit and set condition flags
                    bcs       Code_02DB ; branch when carry reports an unsigned underflow or error
                    suba      Addr_004A ; subtract the operand from the running value
                    incb                ; advance the selected counter
                    bra       Code_02D2 ; continue at the selected control-flow target
Code_02DB           rts                 ; return to the caller
Code_02DC           clrb                ; clear the selected byte or register
Code_02DD           lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    beq       Code_02EA ; branch when the compared values are equal
                    cmpa      Code_0055 ; compare against the limit and set condition flags
                    beq       Code_02EC ; branch when the compared values are equal
                    incb                ; advance the selected counter
                    bra       Code_02DD ; continue at the selected control-flow target
Code_02EA           orcc      #$01      ; set the selected flag bits
Code_02EC           rts                 ; return to the caller
Data_02ED           fcb       $00,$E9,$E9,$AF,$88,$0D ; table, bitmap, or initialized data bytes
                    fcb       $89,$8C,$0C,$0A,$08,$09 ; table, bitmap, or initialized data bytes
                    fcb       $1C,$1A,$18,$19,$13,$12 ; table, bitmap, or initialized data bytes
                    fcb       $10,$11,$05,$B1,$B2,$B3 ; table, bitmap, or initialized data bytes
                    fcb       $B4,$B5,$B6,$B7,$B8,$BA ; table, bitmap, or initialized data bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
Data_030C           fcb       $16,$00   ; table, bitmap, or initialized data bytes
                    fcc       "W"                            ; embedded text or resource bytes
                    fcb       $16,$00   ; table, bitmap, or initialized data bytes
                    fcc       "q"                            ; embedded text or resource bytes
                    fcb       $16,$00   ; table, bitmap, or initialized data bytes
                    fcc       "n"                            ; embedded text or resource bytes
                    fcb       $16,$00   ; table, bitmap, or initialized data bytes
                    fcc       "V"                            ; embedded text or resource bytes
                    fcb       $16,$00   ; table, bitmap, or initialized data bytes
                    fcc       "p"                            ; embedded text or resource bytes
                    fcb       $16,$00   ; table, bitmap, or initialized data bytes
                    fcc       "s"                            ; embedded text or resource bytes
                    fcb       $16,$00,$B3,$16,$00,$CF ; table, bitmap, or initialized data bytes
                    fcb       $16,$00,$E0,$16,$00,$E2 ; table, bitmap, or initialized data bytes
                    fcb       $16,$00,$E4,$16,$00,$E6 ; table, bitmap, or initialized data bytes
                    fcb       $16,$00,$E8,$16,$01,$1F ; table, bitmap, or initialized data bytes
                    fcb       $16,$01   ; table, bitmap, or initialized data bytes
                    fcc       "Y"                            ; embedded text or resource bytes
                    fcb       $16,$01   ; table, bitmap, or initialized data bytes
                    fcc       "["                            ; embedded text or resource bytes
                    fcb       $16,$01   ; table, bitmap, or initialized data bytes
                    fcc       "]"                            ; embedded text or resource bytes
                    fcb       $16,$01   ; table, bitmap, or initialized data bytes
                    fcc       "`"                            ; embedded text or resource bytes
                    fcb       $16,$01,$7F,$16,$01,$8B ; table, bitmap, or initialized data bytes
                    fcb       $16,$01,$96,$16,$01,$A3 ; table, bitmap, or initialized data bytes
                    fcb       $16,$01,$EE,$16,$02,$E6 ; table, bitmap, or initialized data bytes
                    fcb       $16,$02,$E8,$16,$02,$BE ; table, bitmap, or initialized data bytes
                    fcb       $16,$02,$E7,$16,$02,$FF ; table, bitmap, or initialized data bytes
                    fcb       $16,$03,$0F,$16,$00,$03 ; table, bitmap, or initialized data bytes
                    fcb       $16,$FD,$B8,$17,$13 ; table, bitmap, or initialized data bytes
                    fcc       "] "                           ; embedded text or resource bytes
                    fcb       $05,$17,$13,$96,$0F ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $17,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "}"                            ; embedded text or resource bytes
                    fcb       $17,$FC,$9A,$17,$86,$01 ; table, bitmap, or initialized data bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "S"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "T"                            ; embedded text or resource bytes
                    fcb       $16,$FD,$9E,$03 ; table, bitmap, or initialized data bytes
                    fcc       "N"                            ; embedded text or resource bytes
                    fcb       $17,$0A,$08,$16,$FD,$96 ; table, bitmap, or initialized data bytes
                    fcb       $17,$09,$8B,$16,$00,$B6 ; table, bitmap, or initialized data bytes
                    fcb       $17,$0A   ; table, bitmap, or initialized data bytes
                    fcc       "@%8"                          ; embedded text or resource bytes
                    fcb       $8C,$00,$00,$26,$04,$0D ; table, bitmap, or initialized data bytes
                    fcc       "N"                            ; embedded text or resource bytes
                    fcb       $26       ; table, bitmap, or initialized data bytes
                    fcc       "/"                            ; embedded text or resource bytes
                    fcb       $17,$0A,$14,$9E,$08,$C6 ; table, bitmap, or initialized data bytes
                    fcb       $0D,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "N"                            ; embedded text or resource bytes
                    fcb       $26,$0E,$A6,$84,$81 ; table, bitmap, or initialized data bytes
                    fcc       " $"                           ; embedded text or resource bytes
                    fcb       $04,$81,$0A,$26,$04,$E7 ; table, bitmap, or initialized data bytes
                    fcb       $84       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $03,$17,$09,$E2,$0F ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "K'"                           ; embedded text or resource bytes
                    fcb       $03,$17,$05,$92,$0C ; table, bitmap, or initialized data bytes
                    fcc       "W"                            ; embedded text or resource bytes
                    fcb       $17,$1C,$0E,$0F ; table, bitmap, or initialized data bytes
                    fcc       "Y"                            ; embedded text or resource bytes
                    fcb       $16,$FE   ; table, bitmap, or initialized data bytes
                    fcc       "G"                            ; embedded text or resource bytes
                    fcb       $17,$06,$7F,$16,$FD ; table, bitmap, or initialized data bytes
                    fcc       "M"                            ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       "MDDLHH"                       ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "M"                            ; embedded text or resource bytes
                    fcb       $91       ; table, bitmap, or initialized data bytes
                    fcc       "Q%"                           ; embedded text or resource bytes
                    fcb       $08,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "M"                            ; embedded text or resource bytes
                    fcb       $17,$07   ; table, bitmap, or initialized data bytes
                    fcc       "c"                            ; embedded text or resource bytes
                    fcb       $16,$FD   ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
                    fcb       $9E,$02,$17,$06,$9F,$9F ; table, bitmap, or initialized data bytes
                    fcb       $08,$16,$FD ; table, bitmap, or initialized data bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $17,$FC,$1D,$0C ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $10,$17,$0B ; table, bitmap, or initialized data bytes
                    fcc       "j"                            ; embedded text or resource bytes
                    fcb       $D7       ; table, bitmap, or initialized data bytes
                    fcc       "U5"                           ; embedded text or resource bytes
                    fcb       $06,$17,$FC,$10,$0B,$16 ; table, bitmap, or initialized data bytes
                    fcb       $FD       ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $17,$07   ; table, bitmap, or initialized data bytes
                    fcc       "  ;"                    ;0409: 20 20 3B       ' ; embedded text or resource bytes
                    fcb       $17,$07   ; table, bitmap, or initialized data bytes
                    fcc       ": 6"                          ; embedded text or resource bytes
                    fcb       $17,$06,$D8 ; table, bitmap, or initialized data bytes
                    fcc       " 1"                           ; embedded text or resource bytes
                    fcb       $17,$06,$F4 ; table, bitmap, or initialized data bytes
                    fcc       " ,"                           ; embedded text or resource bytes
Data_041B           fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $26,$1F,$C6,$16,$9E,$02 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $04,$17,$07,$E2 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $04,$9C,$00 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $26,$F2,$9F,$02,$17,$06 ; table, bitmap, or initialized data bytes
                    fcc       "W"                            ; embedded text or resource bytes
                    fcb       $9F,$08,$86,$01,$97 ; table, bitmap, or initialized data bytes
                    fcc       "S "                           ; embedded text or resource bytes
                    fcb       $09,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $9E,$02,$17,$06 ; table, bitmap, or initialized data bytes
                    fcc       "H"                            ; embedded text or resource bytes
                    fcb       $9F,$08   ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $06       ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $17,$FB,$C6,$1D,$26,$FA ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $06,$16,$FC,$CC,$9E,$0C ; table, bitmap, or initialized data bytes
                    fcb       $17,$07,$C6,$9C,$04,$22 ; table, bitmap, or initialized data bytes
                    fcb       $E9,$96   ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $C6,$15,$D7 ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $81,$15,$26 ; table, bitmap, or initialized data bytes
                    fcc       "!4"                           ; embedded text or resource bytes
                    fcb       $10,$17,$06,$0F ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $10,$C1,$16 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $04,$C6,$16,$E0,$E0,$17 ; table, bitmap, or initialized data bytes
                    fcb       $07,$8E,$9C,$00 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $26,$F6,$86,$01,$97 ; table, bitmap, or initialized data bytes
                    fcc       "S"                            ; embedded text or resource bytes
                    fcb       $9F,$02,$9E,$02,$17,$05 ; table, bitmap, or initialized data bytes
                    fcb       $FF,$9F,$08 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $B5,$17,$07,$0E ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $B0,$17,$06,$D5 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $AB,$9E,$00,$9F,$08 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $17,$9E,$04,$9F,$08,$17 ; table, bitmap, or initialized data bytes
                    fcb       $06       ; table, bitmap, or initialized data bytes
                    fcc       "6"                            ; embedded text or resource bytes
                    fcb       $9C,$00   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $0C,$C6,$15,$17,$07 ; table, bitmap, or initialized data bytes
                    fcc       "X"                            ; embedded text or resource bytes
                    fcb       $9C,$00   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $26,$F6,$9F,$02,$0F ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $86,$01,$97 ; table, bitmap, or initialized data bytes
                    fcc       "S"                            ; embedded text or resource bytes
                    fcb       $16,$FC   ; table, bitmap, or initialized data bytes
                    fcc       "]"                            ; embedded text or resource bytes
                    fcb       $9E,$08,$17,$06,$16,$D6 ; table, bitmap, or initialized data bytes
                    fcc       "R:"                           ; embedded text or resource bytes
                    fcb       $9F,$08,$0F ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $16,$FC   ; table, bitmap, or initialized data bytes
                    fcc       "N"                            ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       "Q"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "M"                            ; embedded text or resource bytes
                    fcb       $9E,$02,$17,$05,$B1,$9F ; table, bitmap, or initialized data bytes
                    fcb       $08,$16,$FC ; table, bitmap, or initialized data bytes
                    fcc       "@"                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "K"                            ; embedded text or resource bytes
                    fcb       $26,$06,$17,$0E,$12,$16 ; table, bitmap, or initialized data bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       "6"                            ; embedded text or resource bytes
                    fcb       $17,$04   ; table, bitmap, or initialized data bytes
                    fcc       "h"                            ; embedded text or resource bytes
                    fcb       $16,$FC   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "K"                            ; embedded text or resource bytes
                    fcb       $26       ; table, bitmap, or initialized data bytes
                    fcc       ";"                      ;04F4: 3B             ' ; embedded text or resource bytes
                    fcb       $86,$01,$97 ; table, bitmap, or initialized data bytes
                    fcc       "S"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "T1"                           ; embedded text or resource bytes
                    fcb       $C8       ; table, bitmap, or initialized data bytes
                    fcc       "d0"                           ; embedded text or resource bytes
                    fcb       $C9,$01   ; table, bitmap, or initialized data bytes
                    fcc       "q"                            ; embedded text or resource bytes
                    fcb       $17,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $AF,$A1   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C8       ; table, bitmap, or initialized data bytes
                    fcc       "v"                            ; embedded text or resource bytes
                    fcb       $AF,$A1   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C8       ; table, bitmap, or initialized data bytes
                    fcc       "z"                            ; embedded text or resource bytes
                    fcb       $AF,$A4   ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $C8       ; table, bitmap, or initialized data bytes
                    fcc       "d"                            ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       "6"                            ; embedded text or resource bytes
                    fcb       $17       ; table, bitmap, or initialized data bytes
                    fcc       "#"                            ; embedded text or resource bytes
                    fcb       $FD       ; table, bitmap, or initialized data bytes
                    fcc       "M"                            ; embedded text or resource bytes
                    fcb       $26,$14   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C8       ; table, bitmap, or initialized data bytes
                    fcc       "z"                            ; embedded text or resource bytes
                    fcb       $86,$01,$10 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $84       ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $07,$97   ; table, bitmap, or initialized data bytes
                    fcc       "j"                            ; embedded text or resource bytes
                    fcb       $17,$0F,$E0 ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $03,$17,$0D ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $17,$0B,$C0,$17,$FA,$DD ; table, bitmap, or initialized data bytes
                    fcb       $17       ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $17,$FA,$D8 ; table, bitmap, or initialized data bytes
                    fcc       "7"                            ; embedded text or resource bytes
                    fcb       $16,$FB,$E2,$9E,$00,$9C ; table, bitmap, or initialized data bytes
                    fcb       $04,$10   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $FB,$DA,$86,$01,$97 ; table, bitmap, or initialized data bytes
                    fcc       "S"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "T"                            ; embedded text or resource bytes
                    fcb       $17,$FA,$C3 ; table, bitmap, or initialized data bytes
                    fcc       "Q%m"                          ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "j"                            ; embedded text or resource bytes
                    fcb       $17,$FA,$BB ; table, bitmap, or initialized data bytes
                    fcc       "N"                            ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       "Q"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $A6,$88,$1C ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "Q"                            ; embedded text or resource bytes
                    fcb       $97,$26,$A6,$88,$1D,$97 ; table, bitmap, or initialized data bytes
                    fcc       "#o"                           ; embedded text or resource bytes
                    fcb       $0C       ; table, bitmap, or initialized data bytes
                    fcc       "o"                            ; embedded text or resource bytes
                    fcb       $0D,$86,$FF,$A7,$88,$1A ; table, bitmap, or initialized data bytes
                    fcb       $17,$02   ; table, bitmap, or initialized data bytes
                    fcc       "m$"                           ; embedded text or resource bytes
                    fcb       $0B       ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $C9,$01   ; table, bitmap, or initialized data bytes
                    fcc       "q0"                           ; embedded text or resource bytes
                    fcb       $8D,$00   ; table, bitmap, or initialized data bytes
                    fcc       "p"                            ; embedded text or resource bytes
                    fcb       $16,$00   ; table, bitmap, or initialized data bytes
                    fcc       "E"                            ; embedded text or resource bytes
                    fcb       $9E,$00,$10,$9E,$04,$0D ; table, bitmap, or initialized data bytes
                    fcc       "K'"                           ; embedded text or resource bytes
                    fcb       $0A,$9E,$0E,$17,$05 ; table, bitmap, or initialized data bytes
                    fcc       "N"                            ; embedded text or resource bytes
                    fcb       $10,$9E,$10 ; table, bitmap, or initialized data bytes
                    fcc       "1!"                           ; embedded text or resource bytes
                    fcb       $9F,$16,$10,$9F,$18,$17 ; table, bitmap, or initialized data bytes
                    fcb       $1A,$D8,$9E,$16,$0D ; table, bitmap, or initialized data bytes
                    fcc       "K'"                           ; embedded text or resource bytes
                    fcb       $02,$9E,$0E,$17,$03 ; table, bitmap, or initialized data bytes
                    fcc       "W%"                           ; embedded text or resource bytes
                    fcb       $05,$81,$1A,$26,$F7 ; table, bitmap, or initialized data bytes
                    fcc       "O4"                           ; embedded text or resource bytes
                    fcb       $05,$96   ; table, bitmap, or initialized data bytes
                    fcc       "JJ"                           ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "Q"                            ; embedded text or resource bytes
                    fcb       $9E,$16,$17,$1A,$BA ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $12       ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $C9,$01   ; table, bitmap, or initialized data bytes
                    fcc       "q0"                           ; embedded text or resource bytes
                    fcb       $8D,$00,$1B,$AF,$A4,$8E ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$AF,$22,$17,$0C ; table, bitmap, or initialized data bytes
                    fcb       $10,$17,$0B,$1E,$0D ; table, bitmap, or initialized data bytes
                    fcc       "K'"                           ; embedded text or resource bytes
                    fcb       $03,$17,$03 ; table, bitmap, or initialized data bytes
                    fcc       "z"                            ; embedded text or resource bytes
                    fcb       $17,$FA   ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $17,$16,$FE ; table, bitmap, or initialized data bytes
                    fcc       "dDevice error"                ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "Increase Printer Page"        ; embedded text or resource bytes
                    fcc       " Width "                      ; embedded text or resource bytes
                    fcb       $26       ; table, bitmap, or initialized data bytes
                    fcc       " Try Again"                   ; embedded text or resource bytes
                    fcb       $00,$96   ; table, bitmap, or initialized data bytes
                    fcc       "K'"                           ; embedded text or resource bytes
                    fcb       $05,$17,$03,$B4 ; table, bitmap, or initialized data bytes
                    fcc       " 8"                           ; embedded text or resource bytes
                    fcb       $86,$01,$97 ; table, bitmap, or initialized data bytes
                    fcc       "S"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "T"                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $26       ; table, bitmap, or initialized data bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $9E,$08,$A6,$84,$81,$1A ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $26,$97   ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $17,$07   ; table, bitmap, or initialized data bytes
                    fcc       "* "                           ; embedded text or resource bytes
                    fcb       $1F,$17,$03,$C8 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $1A,$17,$03 ; table, bitmap, or initialized data bytes
                    fcc       "9 "                           ; embedded text or resource bytes
                    fcb       $15,$9E,$00,$9C,$04 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $0F,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "K'"                           ; embedded text or resource bytes
                    fcb       $05,$17,$03,$05 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $06,$03   ; table, bitmap, or initialized data bytes
                    fcc       "K"                            ; embedded text or resource bytes
                    fcb       $9E,$08,$9F,$1C,$17,$0A ; table, bitmap, or initialized data bytes
                    fcb       $97,$16,$FD,$E8,$0D ; table, bitmap, or initialized data bytes
                    fcc       "K"                            ; embedded text or resource bytes
                    fcb       $26,$0C,$9E,$00,$9C,$04 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $03,$17,$17 ; table, bitmap, or initialized data bytes
                    fcc       "m"                            ; embedded text or resource bytes
                    fcb       $17,$0A,$84,$16,$FA,$AF ; table, bitmap, or initialized data bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "K"                            ; embedded text or resource bytes
                    fcb       $26,$F9,$9E,$00,$9C,$04 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $F0,$17,$17,$AE ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $EB,$17,$00,$03,$16,$FA ; table, bitmap, or initialized data bytes
                    fcb       $9A,$96   ; table, bitmap, or initialized data bytes
                    fcc       "Q"                            ; embedded text or resource bytes
                    fcb       $81       ; table, bitmap, or initialized data bytes
                    fcc       "(%"                           ; embedded text or resource bytes
                    fcb       $26,$97   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $17,$F9,$81 ; table, bitmap, or initialized data bytes
                    fcc       "N"                            ; embedded text or resource bytes
                    fcb       $A6,$88   ; table, bitmap, or initialized data bytes
                    fcc       "#"                            ; embedded text or resource bytes
                    fcb       $81       ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $26,$04,$86,$26 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $02,$86   ; table, bitmap, or initialized data bytes
                    fcc       "M"                            ; embedded text or resource bytes
                    fcb       $97,$26,$17,$01 ; table, bitmap, or initialized data bytes
                    fcc       ">$"                           ; embedded text or resource bytes
                    fcb       $0C,$17,$03,$A6,$17,$F9 ; table, bitmap, or initialized data bytes
                    fcc       "fN"                           ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $A7,$88   ; table, bitmap, or initialized data bytes
                    fcc       "#"                            ; embedded text or resource bytes
                    fcb       $86,$01,$97 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $17,$00   ; table, bitmap, or initialized data bytes
                    fcc       "f"                            ; embedded text or resource bytes
                    fcb       $17,$07,$8C,$9E,$00,$9C ; table, bitmap, or initialized data bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "'U"                           ; embedded text or resource bytes
                    fcb       $C6,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $C8       ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $9E,$02,$A6,$84,$A7,$A0 ; table, bitmap, or initialized data bytes
                    fcb       $E7,$84   ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $9E,$08,$A6,$84,$A7,$A0 ; table, bitmap, or initialized data bytes
                    fcb       $E7,$84,$0D ; table, bitmap, or initialized data bytes
                    fcc       "K'"                           ; embedded text or resource bytes
                    fcb       $09       ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $9E,$1C,$A6,$84,$A7,$A0 ; table, bitmap, or initialized data bytes
                    fcb       $E7,$84,$9E,$00,$17,$19 ; table, bitmap, or initialized data bytes
                    fcb       $8B,$9E,$02,$17,$03,$EF ; table, bitmap, or initialized data bytes
                    fcb       $9F,$02,$10,$9E,$08,$10 ; table, bitmap, or initialized data bytes
                    fcb       $9F,$0A,$17,$05,$97,$C1 ; table, bitmap, or initialized data bytes
                    fcb       $15       ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $0A,$9E,$02,$17,$05,$1C ; table, bitmap, or initialized data bytes
                    fcb       $9F,$02   ; table, bitmap, or initialized data bytes
                    fcc       "Z "                           ; embedded text or resource bytes
                    fcb       $F2,$D7   ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $9E,$08,$17,$03,$CF,$9F ; table, bitmap, or initialized data bytes
                    fcb       $0C,$DC,$08,$93,$0C,$D7 ; table, bitmap, or initialized data bytes
                    fcc       "M"                            ; embedded text or resource bytes
                    fcb       $86,$01,$97 ; table, bitmap, or initialized data bytes
                    fcc       "SO"                           ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "09"                           ; embedded text or resource bytes
Code_0720           pshs      Y,X,D     ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "N"                            ; embedded text or resource bytes
                    lda       $23,X     ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $09       ; private DeskMate service selector
                    cmpa      #$28      ; compare against the limit and set condition flags
                    beq       Code_0780 ; branch when the compared values are equal
                    lda       #$55      ; load the value needed by the following operation
                    sta       Code_0028 ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    sta       Addr_0029 ; save the current value in working storage
                    sta       Data_0027 ; save the current value in working storage
                    ldb       #$01      ; load the value needed by the following operation
                    std       Addr_002A ; save the current value in working storage
                    ldb       #$0A      ; load the value needed by the following operation
                    std       Code_002C ; save the current value in working storage
                    ldb       #$16      ; load the value needed by the following operation
                    std       Addr_002E ; save the current value in working storage
                    ldd       #Addr_A80F ; load the value needed by the following operation
                    std       Addr_0036 ; save the current value in working storage
                    ldd       #Addr_A817 ; load the value needed by the following operation
                    std       Addr_0038 ; save the current value in working storage
                    ldd       #Addr_0D13 ; load the value needed by the following operation
                    std       Addr_003E ; save the current value in working storage
                    ldd       #Data_141A ; load the value needed by the following operation
                    std       Addr_0040 ; save the current value in working storage
                    ldd       #Data_041B ; load the value needed by the following operation
                    std       Data_0046 ; save the current value in working storage
                    ldd       #Addr_400D ; load the value needed by the following operation
                    std       Addr_003A ; save the current value in working storage
                    ldd       #Addr_4016 ; load the value needed by the following operation
                    std       Code_003C ; save the current value in working storage
                    ldd       #Data_0A11 ; load the value needed by the following operation
                    std       Addr_0042 ; save the current value in working storage
                    ldd       #Addr_121A ; load the value needed by the following operation
                    std       Addr_0044 ; save the current value in working storage
                    ldd       #Data_041B ; load the value needed by the following operation
                    std       Addr_0048 ; save the current value in working storage
                    lda       #$4E      ; load the value needed by the following operation
                    leax      Data_2267,PCR ; form the referenced address without reading memory
                    bra       Code_07CF ; continue at the selected control-flow target
Code_0780           lda       #$AA      ; load the value needed by the following operation
                    sta       Code_0028 ; save the current value in working storage
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Addr_0029 ; save the current value in working storage
                    sta       Data_0027 ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    ldb       #$01      ; load the value needed by the following operation
                    std       Addr_002A ; save the current value in working storage
                    ldb       #$06      ; load the value needed by the following operation
                    std       Code_002C ; save the current value in working storage
                    ldb       #$0C      ; load the value needed by the following operation
                    std       Addr_002E ; save the current value in working storage
                    ldd       #Addr_A81D ; load the value needed by the following operation
                    std       Addr_0036 ; save the current value in working storage
                    ldd       #Addr_A82B ; load the value needed by the following operation
                    std       Addr_0038 ; save the current value in working storage
                    ldd       #Data_1E27 ; load the value needed by the following operation
                    std       Addr_003E ; save the current value in working storage
                    ldd       #Data_2833 ; load the value needed by the following operation
                    std       Addr_0040 ; save the current value in working storage
                    ldd       #Code_0836 ; load the value needed by the following operation
                    std       Data_0046 ; save the current value in working storage
                    ldd       #Addr_4018 ; load the value needed by the following operation
                    std       Addr_003A ; save the current value in working storage
                    ldd       #Addr_402A ; load the value needed by the following operation
                    std       Code_003C ; save the current value in working storage
                    ldd       #Data_1622 ; load the value needed by the following operation
                    std       Addr_0042 ; save the current value in working storage
                    ldd       #Data_2332 ; load the value needed by the following operation
                    std       Addr_0044 ; save the current value in working storage
                    ldd       #Code_0836 ; load the value needed by the following operation
                    std       Addr_0048 ; save the current value in working storage
                    lda       #$27      ; load the value needed by the following operation
                    leax      Data_2276,PCR ; form the referenced address without reading memory
Code_07CF           sta       Addr_004A ; save the current value in working storage
                    deca                ; decrement the selected counter
                    sta       Code_0051 ; save the current value in working storage
                    ldb       #$0E      ; load the value needed by the following operation
                    leay      Data_2258,PCR ; form the referenced address without reading memory
Code_07DA           lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,Y+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bne       Code_07DA ; branch when the compared values differ
                    puls      PC,Y,X,D  ; restore the listed registers from the stack
                    fcc       "46"                           ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $D6,$26,$91,$26 ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $22,$97,$1A,$86,$01,$D0 ; table, bitmap, or initialized data bytes
                    fcb       $1A       ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "L "                           ; embedded text or resource bytes
                    fcb       $F9,$8E,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $89,$01   ; table, bitmap, or initialized data bytes
                    fcc       ",J"                           ; embedded text or resource bytes
                    fcb       $26,$F9   ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $10,$17,$04,$FB,$10,$A3 ; table, bitmap, or initialized data bytes
                    fcb       $E1       ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "C5"                           ; embedded text or resource bytes
                    fcb       $B6       ; table, bitmap, or initialized data bytes
                    fcc       "O5"                           ; embedded text or resource bytes
                    fcb       $B6       ; table, bitmap, or initialized data bytes
Data_0812           fcc       "DOC"                          ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_0816           clr       Addr_005C ; clear the selected byte or register
                    sta       Addr_005A ; save the current value in working storage
                    stb       Code_005B ; save the current value in working storage
                    lda       #$16      ; load the value needed by the following operation
                    suba      Addr_005A ; subtract the operand from the running value
                    cmpa      Code_005B ; compare against the limit and set condition flags
                    bcc       Code_0826 ; branch when carry is clear
                    sta       Code_005B ; save the current value in working storage
Code_0826           lda       Addr_005A ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
                    pshs      X         ; preserve the listed registers on the stack
                    lbsr      Code_08AE ; call the referenced helper routine
                    puls      X         ; restore the listed registers from the stack
                    ldb       Addr_004A ; load the value needed by the following operation
Code_0832           lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpa      #$20      ; compare against the limit and set condition flags
Code_0836           bcs       Code_083E ; branch when carry reports an unsigned underflow or error
                    lbsr      Code_08B9 ; call the referenced helper routine
                    decb                ; decrement the selected counter
                    bra       Code_0832 ; continue at the selected control-flow target
Code_083E           cmpa      #$0B      ; compare against the limit and set condition flags
                    beq       Code_085A ; branch when the compared values are equal
                    cmpa      #$1A      ; compare against the limit and set condition flags
                    beq       Code_086F ; branch when the compared values are equal
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    beq       Code_084E ; branch when the compared values are equal
                    lda       #$20      ; load the value needed by the following operation
                    bra       Code_0850 ; continue at the selected control-flow target
Code_084E           lda       #$80      ; load the value needed by the following operation
Code_0850           lbsr      Code_08B9 ; call the referenced helper routine
                    pshs      X         ; preserve the listed registers on the stack
                    lbsr      Code_0CE3 ; call the referenced helper routine
                    puls      X         ; restore the listed registers from the stack
Code_085A           inc       Addr_005A ; advance the selected counter
                    lda       Addr_005A ; load the value needed by the following operation
                    cmpa      #$16      ; compare against the limit and set condition flags
                    beq       Code_086C ; branch when the compared values are equal
                    dec       Code_005B ; decrement the selected counter
                    bne       Code_0826 ; branch when the compared values differ
                    tst       Addr_005C ; set condition flags from the current value
                    beq       Code_086C ; branch when the compared values are equal
                    bsr       Code_0879 ; call the referenced helper routine
Code_086C           clr       Addr_0054 ; clear the selected byte or register
                    rts                 ; return to the caller
Code_086F           lda       #$01      ; load the value needed by the following operation
                    sta       Code_005B ; save the current value in working storage
                    sta       Addr_005C ; save the current value in working storage
                    lda       #$81      ; load the value needed by the following operation
                    bra       Code_0850 ; continue at the selected control-flow target
Code_0879           tst       Addr_0054 ; set condition flags from the current value
                    beq       Code_089E ; branch when the compared values are equal
                    ldb       Addr_005A ; load the value needed by the following operation
                    cmpb      #$16      ; compare against the limit and set condition flags
                    beq       Code_089E ; branch when the compared values are equal
                    pshs      B         ; preserve the listed registers on the stack
                    ldx       #DeskMateService ; load the value needed by the following operation
                    clra                ; clear the selected byte or register
                    incb                ; advance the selected counter
                    incb                ; advance the selected counter
                    tfr       D,Y       ; copy the source register into the destination register
                    lda       #$16      ; load the value needed by the following operation
                    suba      ,S+       ; subtract the operand from the running value
                    ldb       Addr_004A ; load the value needed by the following operation
                    pshs      U         ; preserve the listed registers on the stack
                    ldu       #Addr_2000 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "%"                            ; embedded text or resource bytes
                    puls      U         ; restore the listed registers from the stack
Code_089E           rts                 ; return to the caller
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $17,$F7   ; table, bitmap, or initialized data bytes
                    fcc       "p"                            ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
Code_08A5           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "-"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $00       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_08AE           inca                ; advance the selected counter
                    inca                ; advance the selected counter
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1B       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_08B9           pshs      X,D       ; preserve the listed registers on the stack
                    tst       Code_004B ; set condition flags from the current value
                    beq       Code_08E5 ; branch when the compared values are equal
                    leax      -$01,X    ; form the referenced address without reading memory
                    cmpx      Addr_0010 ; compare against the limit and set condition flags
                    beq       Code_08C7 ; branch when the compared values are equal
                    bcc       Code_08E5 ; branch when carry is clear
Code_08C7           cmpx      Addr_000E ; compare against the limit and set condition flags
                    bcs       Code_08E5 ; branch when carry reports an unsigned underflow or error
                    puls      X,D       ; restore the listed registers from the stack
                    cmpb      #$01      ; compare against the limit and set condition flags
                    beq       Code_08DB ; branch when the compared values are equal
                    pshs      X,D       ; preserve the listed registers on the stack
                    ldb       #$40      ; load the value needed by the following operation
                    lbsr      start     ;08D5: 17 F7 3B       '.. ; call the referenced helper routine
                    fcb       $02       ; private DeskMate service selector
                    bra       Code_08FD ; continue at the selected control-flow target
Code_08DB           pshs      X,D       ; preserve the listed registers on the stack
                    ldb       #$40      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $01       ; private DeskMate service selector
                    bra       Code_08FD ; continue at the selected control-flow target
Code_08E5           puls      X,D       ; restore the listed registers from the stack
                    cmpb      #$01      ; compare against the limit and set condition flags
                    beq       Code_08F5 ; branch when the compared values are equal
                    pshs      X,D       ; preserve the listed registers on the stack
                    ldb       #$00      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $02       ; private DeskMate service selector
                    bra       Code_08FD ; continue at the selected control-flow target
Code_08F5           pshs      X,D       ; preserve the listed registers on the stack
                    ldb       #$00      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $01       ; private DeskMate service selector
Code_08FD           puls      X,D       ; restore the listed registers from the stack
                    rts                 ; return to the caller
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       "#"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $9C,$18,$26,$04,$86,$1A ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $0A,$A6,$80,$81 ; table, bitmap, or initialized data bytes
                    fcc       " $"                           ; embedded text or resource bytes
                    fcb       $04,$0A   ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $86,$0D,$8D,$0D ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $0A,$81,$1A ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $04,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $26,$E2,$1C,$FE ; table, bitmap, or initialized data bytes
                    fcc       "94"                           ; embedded text or resource bytes
                    fcb       $02,$81,$1A,$26,$02,$86 ; table, bitmap, or initialized data bytes
                    fcb       $0D,$D6   ; table, bitmap, or initialized data bytes
                    fcc       "j"                            ; embedded text or resource bytes
                    fcb       $17,$F6,$E1 ; table, bitmap, or initialized data bytes
                    fcc       "T$"                           ; embedded text or resource bytes
                    fcb       $0C,$C1,$02,$26,$08,$1C ; table, bitmap, or initialized data bytes
                    fcb       $FE       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $02,$86,$1A ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $02,$A6,$E4 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $04,$81,$1A,$26,$06,$96 ; table, bitmap, or initialized data bytes
                    fcc       "j"                            ; embedded text or resource bytes
                    fcb       $17,$F6,$C3 ; table, bitmap, or initialized data bytes
                    fcc       "R5"                           ; embedded text or resource bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
Code_0956           clr       Code_004B ; clear the selected byte or register
                    ldx       #DeskMateService ; load the value needed by the following operation
                    stx       Addr_000E ; save the current value in working storage
                    stx       Addr_0010 ; save the current value in working storage
                    lda       #$01      ; load the value needed by the following operation
                    sta       Code_0053 ; save the current value in working storage
                    sta       Addr_0054 ; save the current value in working storage
                    rts                 ; return to the caller
Code_0966           tst       Code_004B ; set condition flags from the current value
                    beq       Code_097A ; branch when the compared values are equal
                    ldx       Addr_0008 ; load the value needed by the following operation
                    ldy       Code_001C ; load the value needed by the following operation
                    cmpx      Code_001C ; compare against the limit and set condition flags
                    bcs       Code_0975 ; branch when carry reports an unsigned underflow or error
                    exg       X,Y       ; exchange the two register values
Code_0975           stx       Addr_000E ; save the current value in working storage
                    sty       Addr_0010 ; save the current value in working storage
Code_097A           rts                 ; return to the caller
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "K"                            ; embedded text or resource bytes
                    fcb       $26       ; table, bitmap, or initialized data bytes
                    fcc       "S"                            ; embedded text or resource bytes
                    fcb       $9E,$14   ; table, bitmap, or initialized data bytes
                    fcc       "'O"                           ; embedded text or resource bytes
                    fcb       $17,$04   ; table, bitmap, or initialized data bytes
                    fcc       "N%"                           ; embedded text or resource bytes
                    fcb       $15       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $10,$9E,$12,$1F,$10,$D3 ; table, bitmap, or initialized data bytes
                    fcb       $14,$1F,$02 ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $17,$F8,$C0,$D3,$14,$10 ; table, bitmap, or initialized data bytes
                    fcb       $A3,$E1   ; table, bitmap, or initialized data bytes
                    fcc       "#"                            ; embedded text or resource bytes
                    fcb       $04,$17,$00,$B0 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $17,$04,$12,$9E,$08,$DC ; table, bitmap, or initialized data bytes
                    fcb       $14,$17,$02,$A6,$9E,$14 ; table, bitmap, or initialized data bytes
                    fcb       $9F,$1A,$9E,$12,$10,$9E ; table, bitmap, or initialized data bytes
                    fcb       $08,$17,$02,$85,$9E,$08 ; table, bitmap, or initialized data bytes
                    fcb       $17,$01   ; table, bitmap, or initialized data bytes
                    fcc       "#"                            ; embedded text or resource bytes
                    fcb       $17,$02   ; table, bitmap, or initialized data bytes
                    fcc       "K"                            ; embedded text or resource bytes
                    fcb       $9F,$18,$17,$16,$B2,$0F ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $9E,$18,$9C,$02 ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $02,$9F,$02,$86,$01,$97 ; table, bitmap, or initialized data bytes
                    fcc       "S9"                           ; embedded text or resource bytes
                    fcb       $10,$9E,$0E,$9E,$10,$9C ; table, bitmap, or initialized data bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $01,$17,$00,$92,$1F,$10 ; table, bitmap, or initialized data bytes
                    fcb       $9E,$0E,$9F,$08,$17,$02 ; table, bitmap, or initialized data bytes
                    fcb       $8D,$9E,$08,$17,$00,$F0 ; table, bitmap, or initialized data bytes
                    fcb       $17,$02,$18,$9F,$18,$17 ; table, bitmap, or initialized data bytes
                    fcb       $16,$7F,$0F ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $9E,$18,$9C,$02 ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $02,$9F,$02,$17,$FF ; table, bitmap, or initialized data bytes
                    fcc       "R9"                           ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "K',"                          ; embedded text or resource bytes
                    fcb       $9E,$10,$10,$9E,$0E,$9C ; table, bitmap, or initialized data bytes
                    fcb       $04,$26   ; table, bitmap, or initialized data bytes
Data_0A11           fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $1F,$17,$00 ; table, bitmap, or initialized data bytes
                    fcc       "\0"                           ; embedded text or resource bytes
                    fcb       $01,$9F,$14,$9F,$1A,$17 ; table, bitmap, or initialized data bytes
                    fcb       $02,$E2   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $11,$DC,$00,$D3,$06,$93 ; table, bitmap, or initialized data bytes
                    fcb       $14,$DD,$12,$9E,$0E,$1F ; table, bitmap, or initialized data bytes
                    fcb       $02,$17,$02,$0B ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $07,$8D,$1B,$8E,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $9F,$14,$17,$FF,$19 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
Data_0A3E           fcc       "Not enough memory"            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_0A50           leay      $0171,U   ; form the referenced address without reading memory
                    leax      >Data_0A3E,PCR ; form the referenced address without reading memory
                    stx       ,Y        ; save the current value in working storage
                    ldx       #DeskMateService ; load the value needed by the following operation
                    stx       $02,Y     ; save the current value in working storage
                    lbsr      Code_11E2 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_0A63           tfr       X,Y       ; copy the source register into the destination register
Code_0A65           lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpa      #$21      ; compare against the limit and set condition flags
                    bcc       Code_0A65 ; branch when carry is clear
                    leax      -$01,X    ; form the referenced address without reading memory
                    lbsr      Code_0A73 ; call the referenced helper routine
                    tfr       X,D       ; copy the source register into the destination register
                    rts                 ; return to the caller
Code_0A73           pshs      Y         ; preserve the listed registers on the stack
                    tfr       X,D       ; copy the source register into the destination register
                    subd      ,S++      ; subtract the operand from the running value
                    tfr       D,X       ; copy the source register into the destination register
                    rts                 ; return to the caller
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $C1,$16   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $0B,$A6,$80,$81 ; table, bitmap, or initialized data bytes
                    fcc       " $"                           ; embedded text or resource bytes
                    fcb       $F6       ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $81,$1A,$26,$F1 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
Code_0A8D           clr       Code_004F ; clear the selected byte or register
                    lda       Code_004D ; load the value needed by the following operation
                    sta       Addr_005A ; save the current value in working storage
                    lda       Addr_004C ; load the value needed by the following operation
                    sta       Code_005B ; save the current value in working storage
Code_0A97           lda       Code_005B ; load the value needed by the following operation
                    beq       Code_0AB4 ; branch when the compared values are equal
Code_0A9B           lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bcc       Code_0A9B ; branch when carry is clear
                    dec       Code_005B ; decrement the selected counter
                    cmpa      #$1A      ; compare against the limit and set condition flags
                    bne       Code_0A97 ; branch when the compared values differ
                    inc       Code_005B ; advance the selected counter
                    lda       Addr_004C ; load the value needed by the following operation
                    suba      Code_005B ; subtract the operand from the running value
                    sta       Addr_004C ; save the current value in working storage
                    leax      -$01,X    ; form the referenced address without reading memory
                    lbsr      Code_0ADF ; call the referenced helper routine
Code_0AB4           pshs      X         ; preserve the listed registers on the stack
                    lbsr      Code_0ACF ; call the referenced helper routine
                    puls      X         ; restore the listed registers from the stack
                    cmpb      Addr_005A ; compare against the limit and set condition flags
                    bcs       Code_0AC4 ; branch when carry reports an unsigned underflow or error
                    ldb       Addr_005A ; load the value needed by the following operation
                    leax      B,X       ; form the referenced address without reading memory
                    rts                 ; return to the caller
Code_0AC4           stb       Addr_005A ; save the current value in working storage
                    lda       Code_004D ; load the value needed by the following operation
                    suba      Addr_005A ; subtract the operand from the running value
                    sta       Code_004F ; save the current value in working storage
                    leax      B,X       ; form the referenced address without reading memory
                    rts                 ; return to the caller
Code_0ACF           tfr       X,Y       ; copy the source register into the destination register
Code_0AD1           lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bcc       Code_0AD1 ; branch when carry is clear
                    leax      -$01,X    ; form the referenced address without reading memory
                    lbsr      Code_0A73 ; call the referenced helper routine
                    tfr       X,D       ; copy the source register into the destination register
                    rts                 ; return to the caller
Code_0ADF           cmpx      DeskMateService ; compare against the limit and set condition flags
                    beq       Code_0AEB ; branch when the compared values are equal
                    lda       ,-X       ; load the value needed by the following operation
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bcc       Code_0ADF ; branch when carry is clear
                    leax      $01,X     ; form the referenced address without reading memory
Code_0AEB           rts                 ; return to the caller
                    fcb       $9E,$00,$9C,$08 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $05,$96   ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $26,$01   ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       "M'"                           ; embedded text or resource bytes
                    fcb       $0A,$0A   ; table, bitmap, or initialized data bytes
                    fcc       "M"                            ; embedded text or resource bytes
                    fcb       $9E,$02,$17,$FF,$8B,$9F ; table, bitmap, or initialized data bytes
                    fcb       $08       ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       "Q"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "M"                            ; embedded text or resource bytes
                    fcb       $17,$00,$1E ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $9E,$08,$9C,$04 ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $16,$96   ; table, bitmap, or initialized data bytes
                    fcc       "M"                            ; embedded text or resource bytes
                    fcb       $91       ; table, bitmap, or initialized data bytes
                    fcc       "Q$"                           ; embedded text or resource bytes
                    fcb       $0A,$0C   ; table, bitmap, or initialized data bytes
                    fcc       "M"                            ; embedded text or resource bytes
                    fcb       $9E,$02,$17,$FF ; table, bitmap, or initialized data bytes
                    fcc       "m"                            ; embedded text or resource bytes
                    fcb       $9F,$08   ; table, bitmap, or initialized data bytes
                    fcc       "9O"                           ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "M"                            ; embedded text or resource bytes
                    fcb       $17,$00   ; table, bitmap, or initialized data bytes
                    fcc       " 9"                           ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $26,$11,$9E,$02,$9C,$00 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $14,$17,$00,$D3,$9F,$02 ; table, bitmap, or initialized data bytes
                    fcb       $86,$02,$97 ; table, bitmap, or initialized data bytes
                    fcc       "S "                           ; embedded text or resource bytes
                    fcb       $02,$0A   ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $9E,$02,$17,$FF ; table, bitmap, or initialized data bytes
                    fcc       "G"                            ; embedded text or resource bytes
                    fcb       $9F,$08   ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $9E,$0C,$17,$00,$D2,$9C ; table, bitmap, or initialized data bytes
                    fcb       $04,$22,$1C,$96 ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $81,$15,$26,$0D,$9E,$02 ; table, bitmap, or initialized data bytes
                    fcb       $17,$00,$C3,$9F,$02,$86 ; table, bitmap, or initialized data bytes
                    fcb       $03,$97   ; table, bitmap, or initialized data bytes
                    fcc       "S "                           ; embedded text or resource bytes
                    fcb       $02,$0C   ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $9E,$02,$17,$FF ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $9F,$08   ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $9E,$08,$17,$00 ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $9F,$08,$17,$FF ; table, bitmap, or initialized data bytes
                    fcc       "f"                            ; embedded text or resource bytes
                    fcb       $9C,$0C   ; table, bitmap, or initialized data bytes
                    fcc       "'#"                           ; embedded text or resource bytes
                    fcb       $9F,$1A,$17,$00,$A5,$1F ; table, bitmap, or initialized data bytes
                    fcb       $12,$9C,$1A ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $18,$9E,$02,$17,$00,$93 ; table, bitmap, or initialized data bytes
                    fcb       $9F,$02,$1F ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $17,$00,$8C,$1F,$12,$9C ; table, bitmap, or initialized data bytes
                    fcb       $1A,$26,$EE,$86,$01,$97 ; table, bitmap, or initialized data bytes
                    fcc       "S"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "T"                            ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "O9"                           ; embedded text or resource bytes
                    fcb       $9E,$08,$17,$00 ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $9F,$08,$9C,$02 ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $0F,$9E,$02,$17,$00 ; table, bitmap, or initialized data bytes
                    fcc       "W"                            ; embedded text or resource bytes
                    fcb       $9C,$08,$22,$F9,$9F,$02 ; table, bitmap, or initialized data bytes
                    fcb       $86,$01,$97 ; table, bitmap, or initialized data bytes
                    fcc       "S"                            ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "O9"                           ; embedded text or resource bytes
                    fcb       $A6,$80,$81 ; table, bitmap, or initialized data bytes
                    fcc       "!$"                           ; embedded text or resource bytes
                    fcb       $FA,$81,$0B ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $F6,$81,$1A ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $0A,$A6,$80,$81 ; table, bitmap, or initialized data bytes
                    fcc       "!$"                           ; embedded text or resource bytes
                    fcb       $04,$81,$1A,$26,$F6,$A6 ; table, bitmap, or initialized data bytes
                    fcb       $82       ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $9C,$00   ; table, bitmap, or initialized data bytes
                    fcc       "'*0"                          ; embedded text or resource bytes
                    fcb       $01,$9C,$00 ; table, bitmap, or initialized data bytes
                    fcc       "'$"                           ; embedded text or resource bytes
                    fcb       $A6,$82,$81 ; table, bitmap, or initialized data bytes
                    fcc       "!$"                           ; embedded text or resource bytes
                    fcb       $F6,$81,$0B ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $F2,$9C,$00 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $16,$A6,$82,$81 ; table, bitmap, or initialized data bytes
                    fcc       "!%"                           ; embedded text or resource bytes
                    fcb       $F6,$9C,$00 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $0C,$A6,$82,$81 ; table, bitmap, or initialized data bytes
                    fcc       "!$"                           ; embedded text or resource bytes
                    fcb       $F6,$81,$0B ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $F2       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
Code_0C0A           cmpx      DeskMateService ; compare against the limit and set condition flags
                    beq       Code_0C1D ; branch when the compared values are equal
                    leax      -$01,X    ; form the referenced address without reading memory
Code_0C10           cmpx      DeskMateService ; compare against the limit and set condition flags
                    beq       Code_0C1D ; branch when the compared values are equal
                    lda       ,-X       ; load the value needed by the following operation
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bcc       Code_0C10 ; branch when carry is clear
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    rts                 ; return to the caller
Code_0C1D           lda       ,X        ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_0C20           lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bcc       Code_0C20 ; branch when carry is clear
                    rts                 ; return to the caller
Code_0C27           ldx       Addr_0002 ; load the value needed by the following operation
                    ldb       #$15      ; load the value needed by the following operation
Code_0C2B           pshs      X         ; preserve the listed registers on the stack
                    bsr       Code_0C20 ; call the referenced helper routine
                    cmpx      Addr_0004 ; compare against the limit and set condition flags
                    bhi       Code_0C39 ; branch when the unsigned value is above the limit
                    leas      $02,S     ; form the referenced address without reading memory
                    decb                ; decrement the selected counter
                    bne       Code_0C2B ; branch when the compared values differ
                    rts                 ; return to the caller
Code_0C39           puls      X         ; restore the listed registers from the stack
                    rts                 ; return to the caller
Code_0C3C           pshs      U         ; preserve the listed registers on the stack
                    tfr       Y,U       ; copy the source register into the destination register
                    ldy       Code_001A ; load the value needed by the following operation
                    beq       Code_0C4D ; branch when the compared values are equal
Code_0C45           lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,U+       ; store the value and advance the destination pointer
                    leay      -$01,Y    ; form the referenced address without reading memory
                    bne       Code_0C45 ; branch when the compared values differ
Code_0C4D           tfr       U,Y       ; copy the source register into the destination register
                    puls      PC,U      ; restore the listed registers from the stack
Code_0C51           pshs      U,X       ; preserve the listed registers on the stack
                    ldx       Addr_0004 ; load the value needed by the following operation
                    leax      D,X       ; form the referenced address without reading memory
                    tfr       X,U       ; copy the source register into the destination register
                    ldd       Addr_0004 ; load the value needed by the following operation
                    subd      ,S++      ; subtract the operand from the running value
                    tfr       D,Y       ; copy the source register into the destination register
                    leay      $01,Y     ; form the referenced address without reading memory
                    ldx       Addr_0004 ; load the value needed by the following operation
                    stu       Addr_0004 ; save the current value in working storage
                    lbsr      Code_0C6A ; call the referenced helper routine
                    puls      PC,U      ; restore the listed registers from the stack
Code_0C6A           leax      $01,X     ; form the referenced address without reading memory
                    leau      $01,U     ; form the referenced address without reading memory
Code_0C6E           lda       ,-X       ; load the value needed by the following operation
                    sta       ,-U       ; save the current value in working storage
                    leay      -$01,Y    ; form the referenced address without reading memory
                    bne       Code_0C6E ; branch when the compared values differ
                    rts                 ; return to the caller
Code_0C77           pshs      X         ; preserve the listed registers on the stack
                    leax      D,X       ; form the referenced address without reading memory
                    pshs      X,D       ; preserve the listed registers on the stack
                    ldd       Addr_0004 ; load the value needed by the following operation
                    addd      #Addr_0001 ; add the operand to the running value
                    subd      $02,S     ; subtract the operand from the running value
                    std       Code_001A ; save the current value in working storage
                    ldd       Addr_0004 ; load the value needed by the following operation
                    subd      ,S++      ; subtract the operand from the running value
                    std       Addr_0004 ; save the current value in working storage
                    puls      Y,X       ; restore the listed registers from the stack
                    lbsr      Code_0C3C ; call the referenced helper routine
                    rts                 ; return to the caller
Code_0C92           pshs      Y         ; preserve the listed registers on the stack
                    ldx       Addr_0002 ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
Code_0C97           lbsr      Code_0C20 ; call the referenced helper routine
                    incb                ; advance the selected counter
                    cmpx      ,S        ; compare against the limit and set condition flags
                    bls       Code_0C97 ; branch when the unsigned value is at or below the limit
                    decb                ; decrement the selected counter
                    puls      Y         ; restore the listed registers from the stack
                    rts                 ; return to the caller
Code_0CA3           lda       #$16      ; load the value needed by the following operation
                    ldb       Addr_004A ; load the value needed by the following operation
                    ldx       #DeskMateService ; load the value needed by the following operation
                    ldy       #Addr_0002 ; load the value needed by the following operation
                    pshs      U         ; preserve the listed registers on the stack
                    ldu       #Addr_2000 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "'"                            ; embedded text or resource bytes
                    puls      U         ; restore the listed registers from the stack
                    rts                 ; return to the caller
Code_0CBA           lda       #$16      ; load the value needed by the following operation
                    ldb       Addr_004A ; load the value needed by the following operation
                    ldx       #DeskMateService ; load the value needed by the following operation
                    ldy       #Addr_0002 ; load the value needed by the following operation
                    pshs      U         ; preserve the listed registers on the stack
                    ldu       #Addr_2000 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $26       ; private DeskMate service selector
                    puls      U         ; restore the listed registers from the stack
                    rts                 ; return to the caller
Code_0CD1           leax      $0171,U   ; form the referenced address without reading memory
                    pshs      X,D       ; preserve the listed registers on the stack
                    lda       #$20      ; load the value needed by the following operation
                    ldb       Addr_004A ; load the value needed by the following operation
Code_0CDB           sta       ,X+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bne       Code_0CDB ; branch when the compared values differ
                    puls      X,D       ; restore the listed registers from the stack
                    rts                 ; return to the caller
Code_0CE3           cmpb      #$01      ; compare against the limit and set condition flags
                    beq       Code_0D01 ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0C       ; private DeskMate service selector
                    tfr       X,D       ; copy the source register into the destination register
                    lda       Addr_004A ; load the value needed by the following operation
                    pshs      B         ; preserve the listed registers on the stack
                    suba      ,S+       ; subtract the operand from the running value
                    beq       Code_0D01 ; branch when the compared values are equal
                    tfr       A,B       ; copy the source register into the destination register
                    clra                ; clear the selected byte or register
                    tfr       D,Y       ; copy the source register into the destination register
                    clrb                ; clear the selected byte or register
                    bsr       Code_0CD1 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $22       ; private DeskMate service selector
Code_0D01           rts                 ; return to the caller
Code_0D02           ldx       Addr_0004 ; load the value needed by the following operation
                    ldy       DeskMateService ; load the value needed by the following operation
                    lbsr      Code_0A73 ; call the referenced helper routine
                    leax      $01,X     ; form the referenced address without reading memory
                    tfr       X,D       ; copy the source register into the destination register
                    addd      Addr_0014 ; add the operand to the running value
                    pshs      D         ; preserve the listed registers on the stack
                    ldd       Addr_0006 ; load the value needed by the following operation
                    subd      ,S++      ; subtract the operand from the running value
                    tfr       D,X       ; copy the source register into the destination register
                    rts                 ; return to the caller
                    fcb       $9E,$08,$9C,$02 ; table, bitmap, or initialized data bytes
                    fcc       "'p"                           ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "K'"                           ; embedded text or resource bytes
                    fcb       $03,$17,$FC ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $9E,$08,$1F,$12,$A6,$82 ; table, bitmap, or initialized data bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "M"                            ; embedded text or resource bytes
                    fcb       $26,$13,$81,$0B,$26,$1C ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $10,$17,$FD,$A6,$9F,$0C ; table, bitmap, or initialized data bytes
                    fcb       $0A       ; table, bitmap, or initialized data bytes
                    fcc       "L5"                           ; embedded text or resource bytes
                    fcb       $10,$A6,$82 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $0D,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "O'"                           ; embedded text or resource bytes
                    fcb       $09,$10,$9C,$04 ; table, bitmap, or initialized data bytes
                    fcc       "'C"                           ; embedded text or resource bytes
                    fcb       $A6,$A4,$1F ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $9F,$08,$0D ; table, bitmap, or initialized data bytes
                    fcc       "N"                            ; embedded text or resource bytes
                    fcb       $26,$0A,$81 ; table, bitmap, or initialized data bytes
                    fcc       " %1"                          ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $A7,$84   ; table, bitmap, or initialized data bytes
                    fcc       " ("                           ; embedded text or resource bytes
                    fcb       $17,$00   ; table, bitmap, or initialized data bytes
                    fcc       "E"                            ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $81       ; table, bitmap, or initialized data bytes
                    fcc       " $"                           ; embedded text or resource bytes
                    fcb       $1F,$D6   ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "O'"                           ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $D7       ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $17,$FD   ; table, bitmap, or initialized data bytes
                    fcc       "h"                            ; embedded text or resource bytes
                    fcb       $1F,$12,$96 ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $81,$0B   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $06,$86,$01,$97 ; table, bitmap, or initialized data bytes
                    fcc       "T"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "W"                            ; embedded text or resource bytes
                    fcb       $17,$12,$83 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $03,$17,$12 ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "O9"                           ; embedded text or resource bytes
                    fcb       $86,$01,$D6 ; table, bitmap, or initialized data bytes
                    fcc       "N"                            ; embedded text or resource bytes
                    fcb       $26,$02,$86,$FF,$17,$F2 ; table, bitmap, or initialized data bytes
                    fcc       "x"                            ; embedded text or resource bytes
                    fcb       $1E       ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
Code_0D9D           pshs      X,D       ; preserve the listed registers on the stack
                    ldd       #Addr_0001 ; load the value needed by the following operation
                    lbsr      Code_0C51 ; call the referenced helper routine
                    puls      X,D       ; restore the listed registers from the stack
                    stb       ,X        ; save the current value in working storage
                    rts                 ; return to the caller
Code_0DAA           lda       ,X        ; load the value needed by the following operation
                    pshs      X,D       ; preserve the listed registers on the stack
                    ldd       #Addr_0001 ; load the value needed by the following operation
                    lbsr      Code_0C77 ; call the referenced helper routine
                    puls      PC,X,D    ; restore the listed registers from the stack
Code_0DB6           ldb       Code_004F ; load the value needed by the following operation
                    beq       Code_0DD3 ; branch when the compared values are equal
                    pshs      X         ; preserve the listed registers on the stack
                    clra                ; clear the selected byte or register
                    ldx       Addr_0008 ; load the value needed by the following operation
                    pshs      X,D       ; preserve the listed registers on the stack
                    lbsr      Code_0C51 ; call the referenced helper routine
                    puls      X,D       ; restore the listed registers from the stack
                    lda       #$20      ; load the value needed by the following operation
Code_0DC8           sta       ,X+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bne       Code_0DC8 ; branch when the compared values differ
                    stb       Code_004F ; save the current value in working storage
                    stx       Addr_0008 ; save the current value in working storage
                    puls      X         ; restore the listed registers from the stack
Code_0DD3           rts                 ; return to the caller
Code_0DD4           lbsr      Code_0D02 ; call the referenced helper routine
                    bls       Code_0DDF ; branch when the unsigned value is at or below the limit
                    tsta                ; set condition flags from the current value
                    beq       Code_0DDF ; branch when the compared values are equal
                    andcc     #$FE      ; mask off unwanted bits
                    rts                 ; return to the caller
Code_0DDF           orcc      #$01      ; set the selected flag bits
                    rts                 ; return to the caller
Data_0DE2           fcc       "("                            ; embedded text or resource bytes
                    fcb       $08,$0A,$18,$04,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $10,$0A,$18,$04,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
Data_0DF2           fcc       "Formatting Text Buffe"        ; embedded text or resource bytes
                    fcc       "r"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_0E09           fcc       "Please Wait..."               ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_0E18           pshs      Y,X,D     ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       ">"                            ; embedded text or resource bytes
                    pshs      A         ; preserve the listed registers on the stack
                    leax      >Data_0DE2,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    ldx       $03,S     ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
                    ldx       #DeskMateService ; load the value needed by the following operation
                    ldy       #Addr_0001 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    leax      >Data_0E09,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
                    puls      A         ; restore the listed registers from the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    puls      PC,Y,X,D  ; restore the listed registers from the stack
Code_0E49           bsr       Code_0E5D ; call the referenced helper routine
                    leax      Data_1779,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $06       ; private DeskMate service selector
                    lbsr      Code_0F0D ; call the referenced helper routine
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Addr_0063 ; save the current value in working storage
                    clr       Code_0062 ; clear the selected byte or register
                    rts                 ; return to the caller
Code_0E5D           leax      Data_1936,PCR ; form the referenced address without reading memory
                    stx       Data_1921,PCR ; save the current value in working storage
                    leay      Data_1952,PCR ; form the referenced address without reading memory
                    sty       ,X++      ; store the value and advance the destination pointer
                    leay      Data_195B,PCR ; form the referenced address without reading memory
                    sty       ,X++      ; store the value and advance the destination pointer
                    leay      Data_1965,PCR ; form the referenced address without reading memory
                    sty       ,X++      ; store the value and advance the destination pointer
                    leay      Data_196E,PCR ; form the referenced address without reading memory
                    sty       ,X++      ; store the value and advance the destination pointer
                    leay      Data_1978,PCR ; form the referenced address without reading memory
                    sty       ,X++      ; store the value and advance the destination pointer
                    leay      Data_1981,PCR ; form the referenced address without reading memory
                    sty       ,X++      ; store the value and advance the destination pointer
                    stx       Data_1928,PCR ; save the current value in working storage
                    leay      Data_1989,PCR ; form the referenced address without reading memory
                    sty       ,X++      ; store the value and advance the destination pointer
                    leay      Data_1991,PCR ; form the referenced address without reading memory
                    sty       ,X++      ; store the value and advance the destination pointer
                    leay      Data_199B,PCR ; form the referenced address without reading memory
                    sty       ,X++      ; store the value and advance the destination pointer
                    leay      Data_19A5,PCR ; form the referenced address without reading memory
                    sty       ,X++      ; store the value and advance the destination pointer
                    leay      Data_1981,PCR ; form the referenced address without reading memory
                    sty       ,X++      ; store the value and advance the destination pointer
                    leax      Data_194C,PCR ; form the referenced address without reading memory
                    stx       Data_192F,PCR ; save the current value in working storage
                    leay      Data_19AF,PCR ; form the referenced address without reading memory
                    sty       ,X++      ; store the value and advance the destination pointer
                    leay      Data_19B7,PCR ; form the referenced address without reading memory
                    sty       ,X++      ; store the value and advance the destination pointer
                    leay      Data_1981,PCR ; form the referenced address without reading memory
                    sty       ,X++      ; store the value and advance the destination pointer
                    rts                 ; return to the caller
Code_0ED4           lda       #$03      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    ldd       Addr_002A ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    leax      Data_18E1,PCR ; form the referenced address without reading memory
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "6"                            ; embedded text or resource bytes
                    ldd       Code_002C ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    clrb                ; clear the selected byte or register
                    leax      Data_18E6,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "6"                            ; embedded text or resource bytes
                    ldd       Addr_002E ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    clrb                ; clear the selected byte or register
                    leax      Data_18EC,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "6"                            ; embedded text or resource bytes
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_0F0D           pshs      Y,X,D     ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    pshs      U         ; preserve the listed registers on the stack
                    ldb       Code_0028 ; load the value needed by the following operation
                    lda       #$0E      ; load the value needed by the following operation
                    ldx       #DeskMateService ; load the value needed by the following operation
                    ldy       #DeskMateService ; load the value needed by the following operation
                    ldu       #Code_026C ; load the value needed by the following operation
Code_0F23           pshs      A         ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $11       ; private DeskMate service selector
                    leay      $01,Y     ; form the referenced address without reading memory
                    puls      A         ; restore the listed registers from the stack
                    deca                ; decrement the selected counter
                    bne       Code_0F23 ; branch when the compared values differ
                    puls      U         ; restore the listed registers from the stack
                    bsr       Code_0ED4 ; call the referenced helper routine
                    ldd       #Addr_0137 ; load the value needed by the following operation
                    leax      Data_17A9,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    ldd       #Addr_013C ; load the value needed by the following operation
                    leax      Data_1845,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    ldd       #Code_0141 ; load the value needed by the following operation
                    leax      Data_1893,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    ldd       #Code_0146 ; load the value needed by the following operation
                    leax      Data_17F7,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    puls      PC,Y,X,D  ; restore the listed registers from the stack
                    fcb       $17,$F0,$AA,$17,$17,$F0 ; table, bitmap, or initialized data bytes
                    fcb       $A6       ; table, bitmap, or initialized data bytes
                    fcc       "Y"                            ; embedded text or resource bytes
                    fcb       $86,$01,$0D ; table, bitmap, or initialized data bytes
                    fcc       "c-"                           ; embedded text or resource bytes
                    fcb       $0F,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "b"                            ; embedded text or resource bytes
                    fcb       $26,$0B,$17,$F0,$98 ; table, bitmap, or initialized data bytes
                    fcc       "YO"                           ; embedded text or resource bytes
                    fcb       $17,$F0,$93,$10 ; table, bitmap, or initialized data bytes
                    fcc       "_9"                           ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "b"                            ; embedded text or resource bytes
                    fcb       $26       ; table, bitmap, or initialized data bytes
                    fcc       "t"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $17,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "H0"                           ; embedded text or resource bytes
                    fcb       $8D,$09   ; table, bitmap, or initialized data bytes
                    fcc       "Q"                            ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $81,$02   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $0E,$22,$06,$DC ; table, bitmap, or initialized data bytes
                    fcc       ",0"                           ; embedded text or resource bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $08,$DC   ; table, bitmap, or initialized data bytes
                    fcc       ".0"                           ; embedded text or resource bytes
                    fcb       $0B       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $02,$DC   ; table, bitmap, or initialized data bytes
                    fcc       "*4"                           ; embedded text or resource bytes
                    fcb       $06,$86,$03,$17,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "f"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $06,$17,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "`"                            ; embedded text or resource bytes
                    fcb       $0B,$C6   ; table, bitmap, or initialized data bytes
                    fcc       "@"                            ; embedded text or resource bytes
                    fcb       $17,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "Z6"                           ; embedded text or resource bytes
                    fcb       $17,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "V"                            ; embedded text or resource bytes
                    fcb       $17,$C6,$00,$17,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $1C       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $F4,$1F,$89,$96 ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $C1,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "'1"                           ; embedded text or resource bytes
                    fcb       $C1,$08,$26,$07,$81,$01 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $E4       ; table, bitmap, or initialized data bytes
                    fcc       "J "                           ; embedded text or resource bytes
                    fcb       $AE,$C1,$09,$26,$07,$81 ; table, bitmap, or initialized data bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $D9       ; table, bitmap, or initialized data bytes
                    fcc       "L "                           ; embedded text or resource bytes
                    fcb       $A3,$C1,$8A ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $04,$C1,$05,$26,$9B,$17 ; table, bitmap, or initialized data bytes
                    fcb       $FE,$E5,$17,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "!Y"                           ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "b"                            ; embedded text or resource bytes
                    fcb       $C6,$FF,$D7 ; table, bitmap, or initialized data bytes
                    fcc       "c_9"                          ; embedded text or resource bytes
                    fcb       $86,$FF,$97 ; table, bitmap, or initialized data bytes
                    fcc       "c"                            ; embedded text or resource bytes
                    fcb       $8D,$03,$0F ; table, bitmap, or initialized data bytes
                    fcc       "b9"                           ; embedded text or resource bytes
                    fcb       $17,$F0,$0C ; table, bitmap, or initialized data bytes
Data_1007           fcb       $17,$86,$03,$17,$F0,$06 ; table, bitmap, or initialized data bytes
                    fcb       $10,$96   ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $17,$01,$03,$81,$02 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $10,$22,$1C ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$08,$D4,$17,$EF,$F3 ; table, bitmap, or initialized data bytes
                    fcc       "80"                           ; embedded text or resource bytes
                    fcb       $8D,$08,$FC ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $1A       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$08,$D6,$17,$EF,$E5 ; table, bitmap, or initialized data bytes
                    fcc       "80"                           ; embedded text or resource bytes
                    fcb       $8D,$08,$F5 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $0C       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$08,$D8,$17,$EF,$D7 ; table, bitmap, or initialized data bytes
                    fcc       "80"                           ; embedded text or resource bytes
                    fcb       $8D,$08,$EE ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $17,$12   ; table, bitmap, or initialized data bytes
                    fcc       "@"                            ; embedded text or resource bytes
                    fcb       $17,$EF,$CB,$16,$17,$13 ; table, bitmap, or initialized data bytes
                    fcc       "I]'"                          ; embedded text or resource bytes
                    fcb       $FA       ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $12,$C1,$0D ; table, bitmap, or initialized data bytes
                    fcc       "'2"                           ; embedded text or resource bytes
                    fcb       $C1,$05,$26,$F0,$17,$EF ; table, bitmap, or initialized data bytes
                    fcb       $B7       ; table, bitmap, or initialized data bytes
                    fcc       "Y"                            ; embedded text or resource bytes
                    fcb       $17,$00,$93 ; table, bitmap, or initialized data bytes
                    fcc       "_ "                           ; embedded text or resource bytes
                    fcb       $14,$C1,$AF,$26,$04,$96 ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $C1,$B1   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $DA,$C1,$B9 ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $D6,$17,$EF,$9D ; table, bitmap, or initialized data bytes
                    fcc       "Y4"                           ; embedded text or resource bytes
                    fcb       $06       ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $17,$EF,$96,$10,$17,$EF ; table, bitmap, or initialized data bytes
                    fcb       $92       ; table, bitmap, or initialized data bytes
                    fcc       "75"                           ; embedded text or resource bytes
                    fcb       $06,$8D   ; table, bitmap, or initialized data bytes
                    fcc       "\9"                           ; embedded text or resource bytes
                    fcb       $AE,$8D,$09 ; table, bitmap, or initialized data bytes
                    fcc       "vm"                           ; embedded text or resource bytes
                    fcb       $86,$26,$BA,$17,$EF,$81 ; table, bitmap, or initialized data bytes
                    fcc       "Y4"                           ; embedded text or resource bytes
                    fcb       $06       ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $17,$EF   ; table, bitmap, or initialized data bytes
                    fcc       "z"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $06,$D6   ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $C1,$02   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $08,$22,$04,$8B,$06 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $02,$8B,$0B ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$06,$BB,$E6,$86 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $04,$C1,$AF,$26,$04,$D6 ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $D7       ; table, bitmap, or initialized data bytes
                    fcc       "PM"                           ; embedded text or resource bytes
                    fcb       $26,$05,$17,$01,$BE ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $10,$81,$01,$26,$05,$17 ; table, bitmap, or initialized data bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "1 "                           ; embedded text or resource bytes
                    fcb       $07,$81,$02,$26,$03,$17 ; table, bitmap, or initialized data bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "jO"                           ; embedded text or resource bytes
                    fcb       $17,$EF   ; table, bitmap, or initialized data bytes
                    fcc       "=7"                           ; embedded text or resource bytes
                    fcb       $8D,$09   ; table, bitmap, or initialized data bytes
                    fcc       "m"                            ; embedded text or resource bytes
                    fcb       $E4,$26,$02,$8D,$14 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "94"                           ; embedded text or resource bytes
                    fcb       $04,$17,$EF ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $17,$8D   ; table, bitmap, or initialized data bytes
                    fcc       "#"                            ; embedded text or resource bytes
                    fcb       $86,$01,$97 ; table, bitmap, or initialized data bytes
                    fcc       "S"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "T5"                           ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "94p"                          ; embedded text or resource bytes
                    fcb       $8E,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $10,$8E,$00,$0E,$CE,$02 ; table, bitmap, or initialized data bytes
                    fcc       "p"                            ; embedded text or resource bytes
                    fcb       $17,$EF,$10,$11 ; table, bitmap, or initialized data bytes
                    fcc       "1!"                           ; embedded text or resource bytes
                    fcb       $17,$EF,$0A,$11 ; table, bitmap, or initialized data bytes
                    fcc       "5p9"                          ; embedded text or resource bytes
                    fcb       $17,$EF,$03 ; table, bitmap, or initialized data bytes
                    fcc       "Y46"                          ; embedded text or resource bytes
                    fcb       $16,$FE,$1C ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "4@1"                          ; embedded text or resource bytes
                    fcb       $8D,$08,$03,$C6,$06 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$08,$9D ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $8D,$08,$CB,$81,$02 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $18,$26,$0C ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $8D,$07,$F6,$C6,$05 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $07       ; table, bitmap, or initialized data bytes
                    fcc       "3F "                          ; embedded text or resource bytes
                    fcb       $0A,$C6,$03 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $8D,$07,$EF ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "3K"                           ; embedded text or resource bytes
                    fcb       $EF,$8D,$08,$B9 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "o"                            ; embedded text or resource bytes
                    fcb       $C0       ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $26,$FB   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "5@"                           ; embedded text or resource bytes
                    fcb       $10,$AE,$A4 ; table, bitmap, or initialized data bytes
                    fcc       "4 O4 "                        ; embedded text or resource bytes
                    fcb       $10,$AE,$A4,$A7,$A4 ; table, bitmap, or initialized data bytes
                    fcc       "5 1"                          ; embedded text or resource bytes
                    fcb       $22       ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $26,$F2   ; table, bitmap, or initialized data bytes
                    fcc       "5 "                           ; embedded text or resource bytes
                    fcb       $DC,$00,$10,$93,$04,$26 ; table, bitmap, or initialized data bytes
                    fcb       $03,$17,$00,$1B ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $88,$11,$0D ; table, bitmap, or initialized data bytes
                    fcc       "K'"                           ; embedded text or resource bytes
                    fcb       $03,$17,$00,$11 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $88,$11,$DC,$14,$10,$83 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$26,$03,$17,$00 ; table, bitmap, or initialized data bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "946_"                         ; embedded text or resource bytes
                    fcb       $A6,$80   ; table, bitmap, or initialized data bytes
                    fcc       ". 4 "                         ; embedded text or resource bytes
                    fcb       $10,$AE,$A4 ; table, bitmap, or initialized data bytes
                    fcc       "m"                            ; embedded text or resource bytes
                    fcb       $A4,$26,$11,$A7,$A4 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $10,$AE,$8D,$08 ; table, bitmap, or initialized data bytes
                    fcc       "[m"                           ; embedded text or resource bytes
                    fcb       $85,$26,$02,$A7,$85 ; table, bitmap, or initialized data bytes
                    fcc       "\5"                           ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "5 1"                          ; embedded text or resource bytes
                    fcb       $22       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $DC       ; table, bitmap, or initialized data bytes
                    fcc       "569"                          ; embedded text or resource bytes
Data_11B8           fcc       "("                            ; embedded text or resource bytes
                    fcb       $01,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "#"                            ; embedded text or resource bytes
                    fcb       $05,$00   ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $1C       ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $01,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $05,$00   ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $1C       ; table, bitmap, or initialized data bytes
Data_11C8           fcc       "Press any key to cont"        ; embedded text or resource bytes
                    fcc       "inue"                         ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_11E2           leax      >Data_11B8,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    ldd       #Data_1007 ; load the value needed by the following operation
                    tst       $02,Y     ; set condition flags from the current value
                    beq       Code_11F3 ; branch when the compared values are equal
                    ldb       #$03      ; load the value needed by the following operation
Code_11F3           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    ldx       ,Y        ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "6"                            ; embedded text or resource bytes
                    ldd       #Code_1206 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    clra                ; clear the selected byte or register
Code_1206           clrb                ; clear the selected byte or register
                    leax      >Data_11C8,PCR ; form the referenced address without reading memory
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    ldb       #$80      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1C       ; private DeskMate service selector
                    pshs      U         ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $19       ; private DeskMate service selector
                    puls      U         ; restore the listed registers from the stack
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    lda       #$01      ; load the value needed by the following operation
                    sta       Code_0053 ; save the current value in working storage
                    sta       Addr_0054 ; save the current value in working storage
                    rts                 ; return to the caller
Data_122A           fcc       "Disk drive error"             ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_123B           fcc       "Disk full. Save on an"        ; embedded text or resource bytes
                    fcc       "other disk!"                  ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_125C           leay      $0171,U   ; form the referenced address without reading memory
                    leax      >Data_122A,PCR ; form the referenced address without reading memory
                    cmpb      #$F8      ; compare against the limit and set condition flags
                    bne       Code_1273 ; branch when the compared values differ
                    leax      >Data_123B,PCR ; form the referenced address without reading memory
                    stx       ,Y        ; save the current value in working storage
                    ldx       #Addr_7FFF ; load the value needed by the following operation
                    bra       Code_1278 ; continue at the selected control-flow target
Code_1273           stx       ,Y        ; save the current value in working storage
                    ldx       #DeskMateService ; load the value needed by the following operation
Code_1278           stx       $02,Y     ; save the current value in working storage
                    lbsr      Code_11E2 ; call the referenced helper routine
                    rts                 ; return to the caller
                    fcb       $86,$01,$97 ; table, bitmap, or initialized data bytes
                    fcc       "S"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "T1"                           ; embedded text or resource bytes
                    fcb       $C9,$00   ; table, bitmap, or initialized data bytes
                    fcc       "d0"                           ; embedded text or resource bytes
                    fcb       $C9,$00   ; table, bitmap, or initialized data bytes
                    fcc       "k"                            ; embedded text or resource bytes
                    fcb       $AF,$A1   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C9,$00   ; table, bitmap, or initialized data bytes
                    fcc       "v"                            ; embedded text or resource bytes
                    fcb       $AF,$A1   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C9,$00   ; table, bitmap, or initialized data bytes
                    fcc       "z"                            ; embedded text or resource bytes
                    fcb       $AF,$A4   ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $C9,$00   ; table, bitmap, or initialized data bytes
                    fcc       "d"                            ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       "6"                            ; embedded text or resource bytes
                    fcb       $17,$16   ; table, bitmap, or initialized data bytes
                    fcc       "sM"                           ; embedded text or resource bytes
                    fcb       $26       ; table, bitmap, or initialized data bytes
                    fcc       "/"                            ; embedded text or resource bytes
Code_12A6           leax      >$007A,U  ; form the referenced address without reading memory
                    lda       #$01      ; load the value needed by the following operation
                    os9       I$Open    ; request the named OS-9 service
                    bcc       Code_12B7 ; branch when carry is clear
                    cmpb      #$D8      ; compare against the limit and set condition flags
                    bne       Code_12D0 ; branch when the compared values differ
                    bra       Code_12D5 ; continue at the selected control-flow target
Code_12B7           sta       Code_006A ; save the current value in working storage
                    ldx       DeskMateService ; load the value needed by the following operation
                    stx       Addr_0002 ; save the current value in working storage
                    stx       Addr_0008 ; save the current value in working storage
                    stx       Addr_000A ; save the current value in working storage
                    stx       Addr_000C ; save the current value in working storage
                    stx       Addr_0004 ; save the current value in working storage
                    lda       #$1A      ; load the value needed by the following operation
                    sta       ,X        ; save the current value in working storage
                    clr       Code_004F ; clear the selected byte or register
                    lbsr      Code_150B ; call the referenced helper routine
                    bcc       Code_12D5 ; branch when carry is clear
Code_12D0           lbsr      Code_125C ; call the referenced helper routine
                    orcc      #$01      ; set the selected flag bits
Code_12D5           rts                 ; return to the caller
Code_12D6           leay      >$0064,U  ; form the referenced address without reading memory
                    leax      >$006B,U  ; form the referenced address without reading memory
                    stx       ,Y++      ; store the value and advance the destination pointer
                    leax      >$0076,U  ; form the referenced address without reading memory
                    stx       ,Y++      ; store the value and advance the destination pointer
                    leax      >$007A,U  ; form the referenced address without reading memory
                    stx       ,Y        ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    sta       ,X        ; save the current value in working storage
                    leay      >$0064,U  ; form the referenced address without reading memory
                    lda       #$36      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "J"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
                    fcb       $86,$01,$97 ; table, bitmap, or initialized data bytes
                    fcc       "S"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "T"                            ; embedded text or resource bytes
                    fcb       $9E,$00,$9C,$04,$10 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $00,$9E,$17,$ED,$08,$0C ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$00,$BA,$17,$EC,$FE ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
                    fcb       $CC,$08,$05,$17,$EC,$F7 ; table, bitmap, or initialized data bytes
                    fcb       $0B       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$00,$B3,$17,$00,$97 ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $17,$EC,$EB,$22,$96 ; table, bitmap, or initialized data bytes
                    fcc       "k"                            ; embedded text or resource bytes
                    fcb       $81       ; table, bitmap, or initialized data bytes
                    fcc       " ')"                          ; embedded text or resource bytes
                    fcb       $CC,$09,$05,$17,$EC,$DE ; table, bitmap, or initialized data bytes
                    fcb       $0B       ; table, bitmap, or initialized data bytes
                    fcc       "_0"                           ; embedded text or resource bytes
                    fcb       $8D,$00,$AF,$17,$EC,$D5 ; table, bitmap, or initialized data bytes
                    fcc       "6"                            ; embedded text or resource bytes
                    fcb       $CC,$09,$10,$17,$EC,$CE ; table, bitmap, or initialized data bytes
                    fcb       $0B,$17,$EC,$CA ; table, bitmap, or initialized data bytes
                    fcc       "4O_0"                         ; embedded text or resource bytes
                    fcb       $C9,$00   ; table, bitmap, or initialized data bytes
                    fcc       "k"                            ; embedded text or resource bytes
                    fcb       $17,$EC,$C0,$0A,$17,$EC ; table, bitmap, or initialized data bytes
                    fcb       $BC       ; table, bitmap, or initialized data bytes
                    fcc       "31"                           ; embedded text or resource bytes
                    fcb       $C9,$01   ; table, bitmap, or initialized data bytes
                    fcc       "q"                            ; embedded text or resource bytes
                    fcb       $DC       ; table, bitmap, or initialized data bytes
                    fcc       ":"                            ; embedded text or resource bytes
                    fcb       $ED,$A1,$DC ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $ED,$A1,$CC,$07,$0A,$ED ; table, bitmap, or initialized data bytes
                    fcb       $A1,$DC   ; table, bitmap, or initialized data bytes
                    fcc       "H"                            ; embedded text or resource bytes
                    fcb       $ED,$A1,$DC ; table, bitmap, or initialized data bytes
                    fcc       "B"                            ; embedded text or resource bytes
                    fcb       $ED,$A1,$DC ; table, bitmap, or initialized data bytes
                    fcc       "D"                            ; embedded text or resource bytes
                    fcb       $ED,$A1   ; table, bitmap, or initialized data bytes
                    fcc       "14"                           ; embedded text or resource bytes
                    fcb       $17,$02   ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "Z--"                          ; embedded text or resource bytes
                    fcb       $26       ; table, bitmap, or initialized data bytes
                    fcc       "$0"                           ; embedded text or resource bytes
                    fcb       $C9,$00   ; table, bitmap, or initialized data bytes
                    fcc       "k"                            ; embedded text or resource bytes
                    fcb       $A6,$84,$81 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $26,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "O1"                           ; embedded text or resource bytes
                    fcb       $8D,$00   ; table, bitmap, or initialized data bytes
                    fcc       "["                            ; embedded text or resource bytes
                    fcb       $17,$00   ; table, bitmap, or initialized data bytes
                    fcc       "cM"                           ; embedded text or resource bytes
                    fcb       $26,$16   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $03,$17,$FF ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $9E,$04,$10,$9E,$00,$17 ; table, bitmap, or initialized data bytes
                    fcb       $00,$E8   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $07       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $17,$EC   ; table, bitmap, or initialized data bytes
                    fcc       "iW5"                          ; embedded text or resource bytes
                    fcb       $06,$17,$EC ; table, bitmap, or initialized data bytes
                    fcc       "c"                            ; embedded text or resource bytes
                    fcb       $0B       ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $17,$EC   ; table, bitmap, or initialized data bytes
                    fcc       "^7"                           ; embedded text or resource bytes
                    fcb       $17,$EC   ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $17       ; table, bitmap, or initialized data bytes
                    fcc       "94"                           ; embedded text or resource bytes
                    fcb       $10,$10,$8E,$00,$00,$A6 ; table, bitmap, or initialized data bytes
                    fcb       $80       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "1! "                          ; embedded text or resource bytes
                    fcb       $F8       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $00,$04,$07,$18,$04,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $18       ; table, bitmap, or initialized data bytes
                    fcc       "Save?     yes      no"        ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "Filename: "                   ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "4 1"                          ; embedded text or resource bytes
                    fcb       $C9,$00   ; table, bitmap, or initialized data bytes
                    fcc       "d"                            ; embedded text or resource bytes
                    fcb       $AF,$A1   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C9,$00   ; table, bitmap, or initialized data bytes
                    fcc       "v"                            ; embedded text or resource bytes
                    fcb       $AF,$A1   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C9,$00   ; table, bitmap, or initialized data bytes
                    fcc       "z"                            ; embedded text or resource bytes
                    fcb       $AF,$A1,$A7,$A4 ; table, bitmap, or initialized data bytes
                    fcc       "5 O"                          ; embedded text or resource bytes
                    fcb       $A7,$84,$1F ; table, bitmap, or initialized data bytes
                    fcc       "!1"                           ; embedded text or resource bytes
                    fcb       $C9,$00   ; table, bitmap, or initialized data bytes
                    fcc       "d"                            ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       "6"                            ; embedded text or resource bytes
                    fcb       $17,$EB   ; table, bitmap, or initialized data bytes
Data_141A           fcb       $F8,$16,$17,$13 ; table, bitmap, or initialized data bytes
                    fcc       "N4"                           ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "4@"                           ; embedded text or resource bytes
                    fcb       $17,$EB,$ED,$19 ; table, bitmap, or initialized data bytes
                    fcc       "5@"                           ; embedded text or resource bytes
                    fcb       $17,$F9   ; table, bitmap, or initialized data bytes
                    fcc       "d5"                           ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
Code_142F           clra                ; clear the selected byte or register
                    sta       $0A,X     ; save the current value in working storage
                    ldb       #$20      ; load the value needed by the following operation
Code_1434           stb       A,X       ; save the current value in working storage
                    inca                ; advance the selected counter
                    cmpa      #$0A      ; compare against the limit and set condition flags
                    bne       Code_1434 ; branch when the compared values differ
                    rts                 ; return to the caller
                    fcb       $86,$01,$97 ; table, bitmap, or initialized data bytes
                    fcc       "S"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "T"                            ; embedded text or resource bytes
                    fcb       $9E,$04,$10,$9E,$00,$96 ; table, bitmap, or initialized data bytes
                    fcc       "K'"                           ; embedded text or resource bytes
                    fcb       $0B,$9E,$10,$10,$9E,$0E ; table, bitmap, or initialized data bytes
                    fcb       $9C,$04   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "4 "                           ; embedded text or resource bytes
                    fcb       $AC,$E1   ; table, bitmap, or initialized data bytes
                    fcc       "'(400"                        ; embedded text or resource bytes
                    fcb       $C9,$00   ; table, bitmap, or initialized data bytes
                    fcc       "k"                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "K'"                           ; embedded text or resource bytes
                    fcb       $07       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C9,$01   ; table, bitmap, or initialized data bytes
                    fcc       "q"                            ; embedded text or resource bytes
                    fcb       $17,$FF,$C2,$86,$18,$10 ; table, bitmap, or initialized data bytes
                    fcb       $8E,$00,$00,$17,$FF,$7F ; table, bitmap, or initialized data bytes
                    fcc       "M50"                          ; embedded text or resource bytes
                    fcb       $26,$09,$8D,$0D,$0D ; table, bitmap, or initialized data bytes
                    fcc       "K'"                           ; embedded text or resource bytes
                    fcb       $03,$17,$F4,$D2 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $17,$EB,$8B ; table, bitmap, or initialized data bytes
                    fcc       "79"                           ; embedded text or resource bytes
                    fcb       $9F,$18,$10,$9F,$16 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C9,$00   ; table, bitmap, or initialized data bytes
                    fcc       "z"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $87       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C9,$00   ; table, bitmap, or initialized data bytes
                    fcc       "z"                            ; embedded text or resource bytes
                    fcb       $CC,$02,$1B,$10 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $83       ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $0F,$97   ; table, bitmap, or initialized data bytes
                    fcc       "j"                            ; embedded text or resource bytes
                    fcb       $8D,$18   ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $05,$96   ; table, bitmap, or initialized data bytes
                    fcc       "j"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $8F       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $0C       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C9,$00   ; table, bitmap, or initialized data bytes
                    fcc       "z"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $87,$17,$FD,$A1,$1A,$01 ; table, bitmap, or initialized data bytes
                    fcc       "94@"                          ; embedded text or resource bytes
                    fcb       $9E,$16,$10,$8E,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $8D,$1E   ; table, bitmap, or initialized data bytes
                    fcc       "K"                            ; embedded text or resource bytes
                    fcb       $A6,$80,$9F,$1A,$81,$0B ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $1E,$81,$0A,$26,$02,$86 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $A7,$C0   ; table, bitmap, or initialized data bytes
                    fcc       "1!"                           ; embedded text or resource bytes
                    fcb       $10,$8C,$0C,$00,$26,$0E ; table, bitmap, or initialized data bytes
                    fcb       $8D,$1D   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $19,$9E,$1A,$10,$8E,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $8D,$1E   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $9C,$18,$26,$D6,$10,$8C ; table, bitmap, or initialized data bytes
                    fcb       $00,$00   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $04,$8D,$05 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "_5"                           ; embedded text or resource bytes
                    fcb       $C0,$96   ; table, bitmap, or initialized data bytes
                    fcc       "j0"                           ; embedded text or resource bytes
                    fcb       $8D,$1E,$0E,$10 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $8A       ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
Code_150B           lda       #$01      ; load the value needed by the following operation
                    sta       Code_0053 ; save the current value in working storage
                    lda       Code_006A ; load the value needed by the following operation
                    ldb       #$02      ; load the value needed by the following operation
                    pshs      U         ; preserve the listed registers on the stack
                    os9       I$GetStt  ; request the named OS-9 service
                    tfr       U,X       ; copy the source register into the destination register
                    puls      U         ; restore the listed registers from the stack
                    bcs       Code_1590 ; branch when carry reports an unsigned underflow or error
                    stx       Code_0016 ; save the current value in working storage
                    lbsr      Code_0DD4 ; call the referenced helper routine
                    bcs       Code_1533 ; branch when carry reports an unsigned underflow or error
                    cmpx      Code_0016 ; compare against the limit and set condition flags
                    bcc       Code_1538 ; branch when carry is clear
                    leax      $FF00,X   ; form the referenced address without reading memory
                    beq       Code_1533 ; branch when the compared values are equal
                    stx       Code_0016 ; save the current value in working storage
                    bra       Code_1538 ; continue at the selected control-flow target
Code_1533           lbsr      Code_0A50 ; call the referenced helper routine
                    bra       Code_158F ; continue at the selected control-flow target
Code_1538           lbsr      Code_0DB6 ; call the referenced helper routine
                    ldd       Code_0016 ; load the value needed by the following operation
                    ldx       Addr_0008 ; load the value needed by the following operation
                    lbsr      Code_0C51 ; call the referenced helper routine
                    ldx       Addr_0008 ; load the value needed by the following operation
                    ldy       Code_0016 ; load the value needed by the following operation
                    lda       Code_006A ; load the value needed by the following operation
                    os9       I$Read    ; request the named OS-9 service
                    pshs      B,CC      ; preserve the listed registers on the stack
                    lda       Code_006A ; load the value needed by the following operation
                    os9       I$Close   ; request the named OS-9 service
                    puls      B,CC      ; restore the listed registers from the stack
                    bcs       Code_1591 ; branch when carry reports an unsigned underflow or error
                    ldx       Addr_000C ; load the value needed by the following operation
                    ldy       #DeskMateService ; load the value needed by the following operation
Code_155D           ldb       #$FF      ; load the value needed by the following operation
Code_155F           incb                ; advance the selected counter
                    cmpx      Addr_0004 ; compare against the limit and set condition flags
                    beq       Code_1572 ; branch when the compared values are equal
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpa      #$21      ; compare against the limit and set condition flags
                    bcs       Code_155D ; branch when carry reports an unsigned underflow or error
                    cmpb      Code_0051 ; compare against the limit and set condition flags
                    bcs       Code_155F ; branch when carry reports an unsigned underflow or error
                    leay      $01,Y     ; form the referenced address without reading memory
                    bra       Code_155D ; continue at the selected control-flow target
Code_1572           pshs      Y         ; preserve the listed registers on the stack
                    lbsr      Code_0D02 ; call the referenced helper routine
                    cmpx      ,S++      ; compare against the limit and set condition flags
                    bcc       Code_1584 ; branch when carry is clear
                    ldx       Addr_0008 ; load the value needed by the following operation
                    ldd       Code_0016 ; load the value needed by the following operation
                    lbsr      Code_0C77 ; call the referenced helper routine
                    bra       Code_1533 ; continue at the selected control-flow target
Code_1584           ldx       Addr_0008 ; load the value needed by the following operation
                    lbsr      Code_0ADF ; call the referenced helper routine
                    lbsr      Code_0C0A ; call the referenced helper routine
                    lbsr      Code_2076 ; call the referenced helper routine
Code_158F           clra                ; clear the selected byte or register
Code_1590           rts                 ; return to the caller
Code_1591           ldx       Addr_0008 ; load the value needed by the following operation
                    ldd       Code_0016 ; load the value needed by the following operation
                    lbsr      Code_0C77 ; call the referenced helper routine
                    orcc      #$01      ; set the selected flag bits
                    rts                 ; return to the caller
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $16       ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "["                            ; embedded text or resource bytes
                    fcb       $17,$EA   ; table, bitmap, or initialized data bytes
                    fcc       "n"                            ; embedded text or resource bytes
                    fcb       $10,$EC,$A4 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$00,$B1,$0D ; table, bitmap, or initialized data bytes
                    fcc       "Z'"                           ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$00,$DF,$17,$EA ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $0D,$EC,$22 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$00,$9F,$0D ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $26,$04   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$00,$CD,$17,$EA ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $0D,$96   ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "["                            ; embedded text or resource bytes
                    fcb       $C6,$80,$17,$EA ; table, bitmap, or initialized data bytes
                    fcc       "@"                            ; embedded text or resource bytes
                    fcb       $1D       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $22,$81,$0D ; table, bitmap, or initialized data bytes
                    fcc       "'\"                           ; embedded text or resource bytes
                    fcb       $81,$08,$26,$08,$0D ; table, bitmap, or initialized data bytes
                    fcc       "Z'"                           ; embedded text or resource bytes
                    fcb       $EC,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "Z "                           ; embedded text or resource bytes
                    fcb       $C0,$81,$09,$26,$08,$0D ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $26,$E0,$0C ; table, bitmap, or initialized data bytes
                    fcc       "Z "                           ; embedded text or resource bytes
                    fcb       $B4,$81,$05,$26,$D8 ; table, bitmap, or initialized data bytes
                    fcc       " _4`"                         ; embedded text or resource bytes
                    fcb       $17,$EA,$16,$19,$1F,$01 ; table, bitmap, or initialized data bytes
                    fcb       $1F       ; table, bitmap, or initialized data bytes
                    fcc       "05`M-"                        ; embedded text or resource bytes
                    fcb       $C7,$A1   ; table, bitmap, or initialized data bytes
                    fcc       "$%C"                          ; embedded text or resource bytes
                    fcb       $A1       ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $22       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $E1,$26   ; table, bitmap, or initialized data bytes
                    fcc       "%;"                     ;1611: 25 3B          '% ; embedded text or resource bytes
                    fcb       $E1       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $22       ; table, bitmap, or initialized data bytes
                    fcc       "7"                            ; embedded text or resource bytes
                    fcb       $E1       ; table, bitmap, or initialized data bytes
                    fcc       "(%+"                          ; embedded text or resource bytes
                    fcb       $E1       ; table, bitmap, or initialized data bytes
                    fcc       ")"                            ; embedded text or resource bytes
                    fcb       $22,$19,$0F ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $1F       ; table, bitmap, or initialized data bytes
Data_1622           fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "]"                            ; embedded text or resource bytes
                    fcb       $10,$26,$00,$0A,$96 ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $91       ; table, bitmap, or initialized data bytes
                    fcc       "["                            ; embedded text or resource bytes
                    fcb       $10,$26,$FF ; table, bitmap, or initialized data bytes
                    fcc       "v'"                           ; embedded text or resource bytes
                    fcb       $9C,$17,$E9,$DE,$17 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $96,$E1   ; table, bitmap, or initialized data bytes
                    fcc       "*%"                           ; embedded text or resource bytes
                    fcb       $0A,$E1   ; table, bitmap, or initialized data bytes
                    fcc       "+"                            ; embedded text or resource bytes
                    fcb       $22,$06,$86,$01,$97 ; table, bitmap, or initialized data bytes
                    fcc       "Z "                           ; embedded text or resource bytes
                    fcb       $DB,$1F,$10 ; table, bitmap, or initialized data bytes
                    fcc       "]"                            ; embedded text or resource bytes
                    fcb       $26,$E7,$16,$FF,$80,$1F ; table, bitmap, or initialized data bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "]'"                           ; embedded text or resource bytes
                    fcb       $F8,$17,$E9,$BD,$17,$86 ; table, bitmap, or initialized data bytes
                    fcb       $FF,$97   ; table, bitmap, or initialized data bytes
                    fcc       "Z "                           ; embedded text or resource bytes
                    fcb       $D9       ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $04,$08,$0A,$AA,$AF,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0A,$00,$0E,$00,$0A,$00 ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $00,$0A,$00,$CA,$00,$08 ; table, bitmap, or initialized data bytes
                    fcb       $C3,$0A,$00,$0A ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $0A,$00,$0A,$0F,$0A,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0A,$AA,$AA,$00 ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $02,$08   ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $9C       ; table, bitmap, or initialized data bytes
                    fcc       " p "                          ; embedded text or resource bytes
                    fcb       $C0       ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $A0       ; table, bitmap, or initialized data bytes
                    fcc       ";"                      ;168B: 3B             ' ; embedded text or resource bytes
                    fcb       $A0       ; table, bitmap, or initialized data bytes
                    fcc       "/ ' *"                        ; embedded text or resource bytes
                    fcb       $A0       ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $04,$08,$0A,$AA,$AA,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0A,$00,$0A,$00,$0A,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0A,$00,$0A,$00,$0A,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0A,$00,$0A,$00,$0A,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0A,$00,$0A,$00,$0A,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0A,$AA,$AA,$00 ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $02,$08   ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $A0       ; table, bitmap, or initialized data bytes
                    fcc       "            *"                ; embedded text or resource bytes
                    fcb       $A0,$17,$E9 ; table, bitmap, or initialized data bytes
                    fcc       "G"                            ; embedded text or resource bytes
                    fcb       $0C       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "4@"                           ; embedded text or resource bytes
                    fcb       $8E,$FF,$DC,$17,$E9 ; table, bitmap, or initialized data bytes
                    fcc       "<O3"                          ; embedded text or resource bytes
                    fcb       $8D,$00   ; table, bitmap, or initialized data bytes
                    fcc       "c"                            ; embedded text or resource bytes
                    fcb       $CC,$01,$00 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$00   ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $10,$8E,$00,$03,$17,$E9 ; table, bitmap, or initialized data bytes
                    fcc       ")V"                           ; embedded text or resource bytes
                    fcb       $17,$E9   ; table, bitmap, or initialized data bytes
                    fcc       "%P"                           ; embedded text or resource bytes
                    fcb       $17,$E9   ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $19       ; table, bitmap, or initialized data bytes
                    fcc       "5@O"                          ; embedded text or resource bytes
                    fcb       $17,$E9,$1A ; table, bitmap, or initialized data bytes
                    fcc       "7"                            ; embedded text or resource bytes
                    fcb       $17,$F1,$A8,$17,$EF,$87 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $06,$17,$E9,$0E,$0B ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $A7,$8D,$00 ; table, bitmap, or initialized data bytes
                    fcc       "Y424@"                        ; embedded text or resource bytes
                    fcb       $17,$E8,$FF,$17 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$00   ; table, bitmap, or initialized data bytes
                    fcc       "/"                            ; embedded text or resource bytes
                    fcb       $17,$E8,$F7 ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
                    fcb       $8E,$FF,$D8,$17,$E8,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "O0"                           ; embedded text or resource bytes
                    fcb       $8D,$00   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $17,$E8,$E8 ; table, bitmap, or initialized data bytes
                    fcc       "V"                            ; embedded text or resource bytes
                    fcb       $17,$E8,$E4 ; table, bitmap, or initialized data bytes
                    fcc       "P5@O"                         ; embedded text or resource bytes
                    fcb       $17,$E8,$DD ; table, bitmap, or initialized data bytes
                    fcc       "7"                            ; embedded text or resource bytes
                    fcb       $17,$F1   ; table, bitmap, or initialized data bytes
                    fcc       "k"                            ; embedded text or resource bytes
                    fcb       $17,$EF   ; table, bitmap, or initialized data bytes
                    fcc       "J5"                           ; embedded text or resource bytes
                    fcb       $B2,$FC,$00,$0D ; table, bitmap, or initialized data bytes
                    fcc       "DMALT"                        ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $05,$05,$1E,$12,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U<P"                          ; embedded text or resource bytes
                    fcb       $1A,$05,$1E,$12,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U<DMHELP"                     ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "DMTEXT "                      ; embedded text or resource bytes
                    fcb       $00,$00,$0D,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $B1,$B2,$AF,$B3,$B4,$B5 ; table, bitmap, or initialized data bytes
                    fcb       $B6,$AF,$B7,$B8,$AF ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
Data_1779           fcb       $00,$04,$14 ; table, bitmap, or initialized data bytes
                    fcc       "T"                            ; embedded text or resource bytes
                    fcb       $14,$04,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "*******"                      ; embedded text or resource bytes
                    fcb       $00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "030"                          ; embedded text or resource bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $00,$00,$00,$00,$0C,$CC ; table, bitmap, or initialized data bytes
                    fcb       $0C,$CC,$0C,$CC,$0C,$CC ; table, bitmap, or initialized data bytes
                    fcb       $0C,$CC,$0C,$CC,$0C,$CC ; table, bitmap, or initialized data bytes
                    fcb       $00,$00   ; table, bitmap, or initialized data bytes
Data_17A9           fcc       "("                            ; embedded text or resource bytes
                    fcb       $04,$0C,$AA,$A8,$0A,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$8F,$F0,$AA,$A8,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$0A,$A8,$F2,$8F,$0A ; table, bitmap, or initialized data bytes
                    fcb       $AA,$F2,$8F,$0A,$AA,$A8 ; table, bitmap, or initialized data bytes
                    fcb       $F0,$AA,$AA,$A8,$F0,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$A8,$F0,$AA,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$AA,$AA,$A8,$F0,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$A8,$F0,$AA,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$AA   ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $02,$0C   ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $C1,$0F,$F0,$0C ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $1C       ; table, bitmap, or initialized data bytes
                    fcc       "0@"                           ; embedded text or resource bytes
                    fcb       $E1       ; table, bitmap, or initialized data bytes
                    fcc       "Q"                            ; embedded text or resource bytes
                    fcb       $C5       ; table, bitmap, or initialized data bytes
                    fcc       "Q"                            ; embedded text or resource bytes
                    fcb       $C5       ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
                    fcc       "Q"                            ; embedded text or resource bytes
                    fcb       $C5       ; table, bitmap, or initialized data bytes
                    fcc       "Q"                            ; embedded text or resource bytes
                    fcb       $C5       ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
Data_17F7           fcc       "("                            ; embedded text or resource bytes
                    fcb       $04,$0C,$AA,$AA,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC,$AA,$A3,$FF,$FF,$CA ; table, bitmap, or initialized data bytes
                    fcb       $8F,$C3,$C3,$F2 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $00,$00,$FC ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC,$8F,$C3,$C3,$F2,$A3 ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$CA,$AA ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC,$AA,$AA,$AA,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$AA,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $02,$0C   ; table, bitmap, or initialized data bytes
                    fcc       "UUT"                          ; embedded text or resource bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
                    fcc       "S"                            ; embedded text or resource bytes
                    fcb       $C1       ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "^x2H<<2H^xO"                  ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "S"                            ; embedded text or resource bytes
                    fcb       $C1       ; table, bitmap, or initialized data bytes
                    fcc       "T"                            ; embedded text or resource bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
Data_1845           fcc       "("                            ; embedded text or resource bytes
                    fcb       $04,$0C,$AA,$AA,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$A8   ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $AA,$AA,$A3,$CA,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcb       $8F,$F2,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC,$AA,$A8,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $A3,$FF,$FF,$CA,$AA ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $AA       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $AA       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $AA       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $AA,$AA,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $02,$0C   ; table, bitmap, or initialized data bytes
                    fcc       "UUV5Y"                        ; embedded text or resource bytes
                    fcb       $15       ; table, bitmap, or initialized data bytes
                    fcc       "S"                            ; embedded text or resource bytes
                    fcb       $C3       ; table, bitmap, or initialized data bytes
                    fcc       "G"                            ; embedded text or resource bytes
                    fcb       $E1,$1F,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $F8,$07,$E1 ; table, bitmap, or initialized data bytes
                    fcc       "G"                            ; embedded text or resource bytes
                    fcb       $E1       ; table, bitmap, or initialized data bytes
                    fcc       "G"                            ; embedded text or resource bytes
                    fcb       $E1       ; table, bitmap, or initialized data bytes
                    fcc       "G"                            ; embedded text or resource bytes
                    fcb       $E1       ; table, bitmap, or initialized data bytes
                    fcc       "@"                            ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
Data_1893           fcc       "("                            ; embedded text or resource bytes
                    fcb       $04,$0C,$AA,$AA,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$AA,$AA,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $AA       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $AA       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $AA       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $A3,$FF,$FF,$CA,$A8,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $AA       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC,$AA,$AA,$8F,$F2,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$A3,$CA,$AA,$AA,$A8 ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $AA       ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $02,$0C   ; table, bitmap, or initialized data bytes
                    fcc       "UU@"                          ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "G"                            ; embedded text or resource bytes
                    fcb       $E1       ; table, bitmap, or initialized data bytes
                    fcc       "G"                            ; embedded text or resource bytes
                    fcb       $E1       ; table, bitmap, or initialized data bytes
                    fcc       "G"                            ; embedded text or resource bytes
                    fcb       $E1,$07,$E1 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $F8,$1F,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "G"                            ; embedded text or resource bytes
                    fcb       $E1       ; table, bitmap, or initialized data bytes
                    fcc       "S"                            ; embedded text or resource bytes
                    fcb       $C3       ; table, bitmap, or initialized data bytes
                    fcc       "Y"                            ; embedded text or resource bytes
                    fcb       $15       ; table, bitmap, or initialized data bytes
                    fcc       "V5"                           ; embedded text or resource bytes
Data_18E1           fcc       "File"                         ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_18E6           fcc       "Block"                        ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_18EC           fcc       "Find"                         ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $00,$01,$09,$08,$00,$AA ; table, bitmap, or initialized data bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $00,$01,$09,$08,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $04,$01,$0A,$07,$00,$AA ; table, bitmap, or initialized data bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $09,$01,$0A,$07,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $0A,$01,$0A,$05,$00,$AA ; table, bitmap, or initialized data bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $16,$01,$0A,$05,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
Data_1921           fcb       $00,$00,$06,$07,$06,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1928           fcb       $00,$00,$05,$08,$05,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_192F           fcb       $00,$00,$03,$08,$03,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1936           fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00 ; table, bitmap, or initialized data bytes
Data_194C           fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
Data_1952           fcc       " "                            ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "  open"                       ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_195B           fcc       " "                            ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "  close"                      ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1965           fcc       " "                            ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "  save"                       ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_196E           fcc       " 1 "                          ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "merge"                        ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1978           fcc       " 2 print"                     ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1981           fcc       " ? help"                      ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1989           fcc       " 3 copy"                      ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1991           fcc       " 4 insert"                    ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_199B           fcc       " 5 delete"                    ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_19A5           fcc       " 6 select"                    ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_19AF           fcc       " 7 find"                      ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_19B7           fcc       " 8 change"                    ; embedded text or resource bytes
                    fcb       $00,$00,$00,$FF,$00,$FF ; table, bitmap, or initialized data bytes
                    fcb       $00,$01,$00,$00,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $00,$01,$FF,$FF,$00,$01 ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$00,$FF,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $01,$00,$FF,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $01,$FF,$FF,$00,$01,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$01 ; table, bitmap, or initialized data bytes
                    fcb       $00,$FF,$00,$00,$00,$01 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$01,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_1A03           clr       Addr_0058 ; clear the selected byte or register
Code_1A05           ldb       #$83      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    beq       Code_1A10 ; branch when the compared values are equal
                    sta       Code_0055 ; save the current value in working storage
                    rts                 ; return to the caller
Code_1A10           inc       Addr_0058 ; advance the selected counter
                    lda       Addr_0058 ; load the value needed by the following operation
                    cmpa      #$0A      ; compare against the limit and set condition flags
                    bne       Code_1A05 ; branch when the compared values differ
                    clr       Addr_0058 ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0C       ; private DeskMate service selector
                    bsr       Code_1A32 ; call the referenced helper routine
                    pshs      A         ; preserve the listed registers on the stack
                    tfr       X,D       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    puls      A         ; restore the listed registers from the stack
                    tsta                ; set condition flags from the current value
                    beq       Code_1A05 ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_1A32           pshs      Y,X       ; preserve the listed registers on the stack
                    pshs      U         ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $19       ; private DeskMate service selector
                    tstb                ; set condition flags from the current value
                    bne       Code_1A4F ; branch when the compared values differ
                    tfr       U,D       ; copy the source register into the destination register
                    puls      U         ; restore the listed registers from the stack
                    tsta                ; set condition flags from the current value
                    blt       Code_1A4C ; branch when the signed value is below the limit
                    leax      Data_2258,PCR ; form the referenced address without reading memory
                    bsr       Code_1A70 ; call the referenced helper routine
                    bsr       Code_1A9F ; call the referenced helper routine
Code_1A4C           clra                ; clear the selected byte or register
                    puls      PC,Y,X    ; restore the listed registers from the stack
Code_1A4F           tfr       U,X       ; copy the source register into the destination register
                    puls      U         ; restore the listed registers from the stack
                    pshs      B         ; preserve the listed registers on the stack
                    tfr       X,D       ; copy the source register into the destination register
                    tsta                ; set condition flags from the current value
                    blt       Code_1A6D ; branch when the signed value is below the limit
                    leax      Data_2258,PCR ; form the referenced address without reading memory
                    bsr       Code_1A70 ; call the referenced helper routine
                    pshs      Y,X,D     ; preserve the listed registers on the stack
                    bsr       Code_1A9F ;1A62: 8D 3B          '. ; call the referenced helper routine
                    puls      Y,X,D     ; restore the listed registers from the stack
                    lbsr      Code_1B49 ; call the referenced helper routine
Code_1A69           leas      $01,S     ; form the referenced address without reading memory
                    puls      PC,Y,X    ; restore the listed registers from the stack
Code_1A6D           clra                ; clear the selected byte or register
                    bra       Code_1A69 ; continue at the selected control-flow target
Code_1A70           ldy       #Addr_0001 ; load the value needed by the following operation
                    pshs      X,D       ; preserve the listed registers on the stack
                    cmpa      #$01      ; compare against the limit and set condition flags
                    bhi       Code_1A92 ; branch when the unsigned value is above the limit
Code_1A7A           cmpb      ,X        ; compare against the limit and set condition flags
                    bcs       Code_1A92 ; branch when carry reports an unsigned underflow or error
                    cmpb      $01,X     ; compare against the limit and set condition flags
                    bhi       Code_1A84 ; branch when the unsigned value is above the limit
                    puls      PC,X,D    ; restore the listed registers from the stack
Code_1A84           leay      $01,Y     ; form the referenced address without reading memory
                    leax      $02,X     ; form the referenced address without reading memory
                    pshs      B         ; preserve the listed registers on the stack
                    ldb       ,X        ; load the value needed by the following operation
                    cmpb      #$FF      ; compare against the limit and set condition flags
                    puls      B         ; restore the listed registers from the stack
                    bne       Code_1A7A ; branch when the compared values differ
Code_1A92           clra                ; clear the selected byte or register
                    ldb       #$FF      ; load the value needed by the following operation
                    tfr       D,Y       ; copy the source register into the destination register
                    puls      X,D       ; restore the listed registers from the stack
                    tst       Data_0027 ; set condition flags from the current value
                    beq       Code_1A9E ; branch when the compared values are equal
                    lsrb                ; shift right and expose the low bit through carry
Code_1A9E           rts                 ; return to the caller
Code_1A9F           tfr       Y,D       ; copy the source register into the destination register
                    cmpb      Addr_0063 ; compare against the limit and set condition flags
                    beq       Code_1ABC ; branch when the compared values are equal
                    ldb       Addr_0063 ; load the value needed by the following operation
                    blt       Code_1AB0 ; branch when the signed value is below the limit
                    pshs      Y,X       ; preserve the listed registers on the stack
                    clra                ; clear the selected byte or register
                    bsr       Code_1ABD ; call the referenced helper routine
                    puls      Y,X       ; restore the listed registers from the stack
Code_1AB0           tfr       Y,D       ; copy the source register into the destination register
                    stb       Addr_0063 ; save the current value in working storage
                    cmpb      #$FF      ; compare against the limit and set condition flags
                    beq       Code_1ABC ; branch when the compared values are equal
                    lda       #$40      ; load the value needed by the following operation
                    bsr       Code_1ABD ; call the referenced helper routine
Code_1ABC           rts                 ; return to the caller
Code_1ABD           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    pshs      A         ; preserve the listed registers on the stack
                    pshs      B         ; preserve the listed registers on the stack
                    decb                ; decrement the selected counter
                    aslb                ; shift left and update carry
                    abx                 ; add the operand to the running value
                    ldb       ,S        ; load the value needed by the following operation
                    cmpb      #$03      ; compare against the limit and set condition flags
                    bhi       Code_1B06 ; branch when the unsigned value is above the limit
                    lda       #$03      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    ldb       ,X        ; load the value needed by the following operation
                    lda       Addr_004A ; load the value needed by the following operation
                    cmpa      #$27      ; compare against the limit and set condition flags
                    bne       Code_1ADD ; branch when the compared values differ
                    lsrb                ; shift right and expose the low bit through carry
Code_1ADD           clra                ; clear the selected byte or register
                    cmpb      #$00      ; compare against the limit and set condition flags
                    bne       Code_1AE3 ; branch when the compared values differ
                    incb                ; advance the selected counter
Code_1AE3           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    puls      B         ; restore the listed registers from the stack
                    leax      Data_2248,PCR ; form the referenced address without reading memory
                    cmpb      #$02      ; compare against the limit and set condition flags
                    bcs       Code_1AF9 ; branch when carry reports an unsigned underflow or error
                    bhi       Code_1AF7 ; branch when the unsigned value is above the limit
                    leax      $05,X     ; form the referenced address without reading memory
                    bra       Code_1AF9 ; continue at the selected control-flow target
Code_1AF7           leax      $0B,X     ; form the referenced address without reading memory
Code_1AF9           puls      B         ; restore the listed registers from the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "6"                            ; embedded text or resource bytes
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    bra       Code_1B44 ; continue at the selected control-flow target
Code_1B06           ldd       #Addr_000D ; load the value needed by the following operation
                    pshs      D         ; preserve the listed registers on the stack
                    ldb       $01,X     ; load the value needed by the following operation
                    incb                ; advance the selected counter
                    tst       Data_0027 ; set condition flags from the current value
                    bne       Code_1B13 ; branch when the compared values differ
                    incb                ; advance the selected counter
Code_1B13           lda       #$08      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    subd      #Addr_0001 ; subtract the operand from the running value
                    pshs      D         ; preserve the listed registers on the stack
                    ldd       #DeskMateService ; load the value needed by the following operation
                    pshs      D         ; preserve the listed registers on the stack
                    ldb       ,X        ; load the value needed by the following operation
                    decb                ; decrement the selected counter
                    tst       Data_0027 ; set condition flags from the current value
                    bne       Code_1B28 ; branch when the compared values differ
                    decb                ; decrement the selected counter
Code_1B28           lda       #$08      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    addd      #Addr_0005 ; add the operand to the running value
                    pshs      D         ; preserve the listed registers on the stack
                    lda       $09,S     ; load the value needed by the following operation
                    beq       Code_1B38 ; branch when the compared values are equal
                    ldb       Addr_0029 ; load the value needed by the following operation
                    bra       Code_1B3A ; continue at the selected control-flow target
Code_1B38           ldb       Code_0028 ; load the value needed by the following operation
Code_1B3A           pshs      B         ; preserve the listed registers on the stack
                    tfr       S,X       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $13       ; private DeskMate service selector
                    leas      $0B,S     ; form the referenced address without reading memory
Code_1B44           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_1B49           cmpy      #Addr_00FF ; compare against the limit and set condition flags
                    beq       Code_1BB4 ; branch when the compared values are equal
                    cmpy      #Addr_0004 ; compare against the limit and set condition flags
                    bcs       Code_1B9C ; branch when carry reports an unsigned underflow or error
                    beq       Code_1B96 ; branch when the compared values are equal
                    cmpy      #Addr_0006 ; compare against the limit and set condition flags
                    bhi       Code_1B92 ; branch when the unsigned value is above the limit
                    tfr       Y,D       ; copy the source register into the destination register
                    stb       Addr_0063 ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    ldb       $02,S     ; load the value needed by the following operation
                    cmpb      #$02      ; compare against the limit and set condition flags
                    bcs       Code_1B6C ; branch when carry reports an unsigned underflow or error
                    bhi       Code_1B7D ; branch when the unsigned value is above the limit
                    lda       #$10      ; load the value needed by the following operation
Code_1B6C           cmpy      #Addr_0006 ; compare against the limit and set condition flags
                    beq       Code_1B76 ; branch when the compared values are equal
                    adda      #$0C      ; add the operand to the running value
                    bra       Code_1B78 ; continue at the selected control-flow target
Code_1B76           adda      #$0A      ; add the operand to the running value
Code_1B78           sta       Code_0055 ; save the current value in working storage
                    clr       Code_0062 ; clear the selected byte or register
                    rts                 ; return to the caller
Code_1B7D           cmpb      #$05      ; compare against the limit and set condition flags
                    bne       Code_1B8C ; branch when the compared values differ
                    lda       #$13      ; load the value needed by the following operation
                    cmpy      #Addr_0005 ; compare against the limit and set condition flags
                    beq       Code_1B78 ; branch when the compared values are equal
                    deca                ; decrement the selected counter
                    bra       Code_1B78 ; continue at the selected control-flow target
Code_1B8C           cmpb      #$04      ; compare against the limit and set condition flags
                    bne       Code_1B6C ; branch when the compared values differ
                    clra                ; clear the selected byte or register
                    rts                 ; return to the caller
Code_1B92           lda       #$BA      ; load the value needed by the following operation
                    bra       Code_1B78 ; continue at the selected control-flow target
Code_1B96           clr       Addr_0050 ; clear the selected byte or register
                    lda       #$AF      ; load the value needed by the following operation
                    bra       Code_1B78 ; continue at the selected control-flow target
Code_1B9C           clra                ; clear the selected byte or register
                    tst       Code_004B ; set condition flags from the current value
                    beq       Code_1BA7 ; branch when the compared values are equal
                    ldb       $02,S     ; load the value needed by the following operation
                    cmpb      #$03      ; compare against the limit and set condition flags
                    bcc       Code_1BB3 ; branch when carry is clear
Code_1BA7           tfr       Y,D       ; copy the source register into the destination register
                    stb       Addr_005C ; save the current value in working storage
                    stb       Addr_0063 ; save the current value in working storage
                    stb       Code_0062 ; save the current value in working storage
                    lda       #$8C      ; load the value needed by the following operation
                    sta       Code_0055 ; save the current value in working storage
Code_1BB3           rts                 ; return to the caller
Code_1BB4           tfr       D,X       ; copy the source register into the destination register
                    ldb       $02,S     ; load the value needed by the following operation
                    cmpb      #$02      ; compare against the limit and set condition flags
                    beq       Code_1C2F ; branch when the compared values are equal
                    cmpb      #$05      ; compare against the limit and set condition flags
                    beq       Code_1C2F ; branch when the compared values are equal
                    cmpb      #$04      ; compare against the limit and set condition flags
                    beq       Code_1C2F ; branch when the compared values are equal
                    tfr       X,D       ; copy the source register into the destination register
                    suba      #$02      ; subtract the operand from the running value
                    bcs       Code_1C2F ; branch when carry reports an unsigned underflow or error
                    pshs      D         ; preserve the listed registers on the stack
                    ldb       $04,S     ; load the value needed by the following operation
                    cmpb      #$03      ; compare against the limit and set condition flags
                    puls      D         ; restore the listed registers from the stack
                    beq       Code_1BE1 ; branch when the compared values are equal
                    tst       Code_004B ; set condition flags from the current value
                    beq       Code_1C14 ; branch when the compared values are equal
                    pshs      D         ; preserve the listed registers on the stack
                    lbsr      Code_0956 ; call the referenced helper routine
                    puls      D         ; restore the listed registers from the stack
                    bra       Code_1C16 ; continue at the selected control-flow target
Code_1BE1           tst       Code_004B ; set condition flags from the current value
                    bne       Code_1BEF ; branch when the compared values differ
                    std       Addr_005E ; save the current value in working storage
                    bsr       Code_1C31 ; call the referenced helper routine
                    stx       Addr_000A ; save the current value in working storage
                    lda       #$B6      ; load the value needed by the following operation
                    bra       Code_1B78 ; continue at the selected control-flow target
Code_1BEF           tsta                ; set condition flags from the current value
                    bne       Code_1C00 ; branch when the compared values differ
                    tstb                ; set condition flags from the current value
                    bne       Code_1C14 ; branch when the compared values differ
                    ldx       Addr_000A ; load the value needed by the following operation
                    cmpx      Addr_0002 ; compare against the limit and set condition flags
                    bne       Code_1C14 ; branch when the compared values differ
                    lda       #$0C      ; load the value needed by the following operation
                    lbra      Code_1B78 ; continue at the distant control-flow target
Code_1C00           cmpa      #$15      ; compare against the limit and set condition flags
                    bne       Code_1C14 ; branch when the compared values differ
                    pshs      D         ; preserve the listed registers on the stack
                    lbsr      Code_1C3D ; call the referenced helper routine
                    puls      D         ; restore the listed registers from the stack
                    cmpx      Addr_000A ; compare against the limit and set condition flags
                    bne       Code_1C14 ; branch when the compared values differ
                    lda       #$0A      ; load the value needed by the following operation
                    lbra      Code_1B78 ; continue at the distant control-flow target
Code_1C14           clr       Code_0053 ; clear the selected byte or register
Code_1C16           ldx       Addr_0008 ; load the value needed by the following operation
                    stx       Addr_000A ; save the current value in working storage
                    tst       Code_004B ; set condition flags from the current value
                    beq       Code_1C23 ; branch when the compared values are equal
                    cmpd      Addr_005E ; compare against the limit and set condition flags
                    beq       Code_1C2F ; branch when the compared values are equal
Code_1C23           std       Addr_005E ; save the current value in working storage
                    bsr       Code_1C31 ; call the referenced helper routine
                    clrb                ; clear the selected byte or register
                    stb       Code_0062 ; save the current value in working storage
                    stb       Code_0055 ; save the current value in working storage
                    lda       #$FF      ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_1C2F           clra                ; clear the selected byte or register
                    rts                 ; return to the caller
Code_1C31           sta       Addr_004C ; save the current value in working storage
                    stb       Code_004D ; save the current value in working storage
                    ldx       Addr_0002 ; load the value needed by the following operation
                    lbsr      Code_0A8D ; call the referenced helper routine
                    stx       Addr_0008 ; save the current value in working storage
                    rts                 ; return to the caller
Code_1C3D           lbsr      Code_0C27 ; call the referenced helper routine
                    lbsr      Code_0C20 ; call the referenced helper routine
                    lda       ,-X       ; load the value needed by the following operation
                    cmpa      #$0B      ; compare against the limit and set condition flags
                    bne       Code_1C4B ; branch when the compared values differ
                    leax      -$01,X    ; form the referenced address without reading memory
Code_1C4B           rts                 ; return to the caller
Code_1C4C           clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       ","                            ; embedded text or resource bytes
                    tfr       Y,D       ; copy the source register into the destination register
                    subd      DeskMateService ; subtract the operand from the running value
                    std       Addr_0006 ; save the current value in working storage
                    std       Code_0016 ; save the current value in working storage
                    rts                 ; return to the caller
                    fcb       $17,$ED,$F2 ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $06,$00,$01,$06,$1C,$04 ; table, bitmap, or initialized data bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $18       ; table, bitmap, or initialized data bytes
                    fcc       "Find "                        ; embedded text or resource bytes
                    fcb       $00,$00,$01,$06,$1E,$07 ; table, bitmap, or initialized data bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $18       ; table, bitmap, or initialized data bytes
                    fcc       "Change "                      ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "to     "                      ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "4 4"                          ; embedded text or resource bytes
                    fcb       $06,$17,$E3,$84,$16 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $C9,$01   ; table, bitmap, or initialized data bytes
                    fcc       "q_"                           ; embedded text or resource bytes
                    fcb       $A6,$85,$A7,$A5 ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $C1       ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $26,$F7   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $06,$17,$05,$94,$86,$80 ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $8A,$14,$17,$08,$05,$97 ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $81,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "'C"                           ; embedded text or resource bytes
                    fcb       $81,$05   ; table, bitmap, or initialized data bytes
                    fcc       "'7M"                          ; embedded text or resource bytes
                    fcb       $26       ; table, bitmap, or initialized data bytes
                    fcc       "84T"                          ; embedded text or resource bytes
                    fcb       $17,$E3   ; table, bitmap, or initialized data bytes
                    fcc       "V"                            ; embedded text or resource bytes
                    fcb       $19,$C1,$01,$26 ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $1F       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $EE       ; table, bitmap, or initialized data bytes
                    fcc       "c0"                           ; embedded text or resource bytes
                    fcb       $8D,$FF,$98,$0D ; table, bitmap, or initialized data bytes
                    fcc       "]'"                           ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $0D,$A1,$01 ; table, bitmap, or initialized data bytes
                    fcc       "/"                            ; embedded text or resource bytes
                    fcb       $14,$A0,$03,$A1,$01 ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $0E,$E1,$84 ; table, bitmap, or initialized data bytes
                    fcc       "/"                            ; embedded text or resource bytes
                    fcb       $0A,$E0,$02 ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $06       ; table, bitmap, or initialized data bytes
                    fcc       "5T"                           ; embedded text or resource bytes
                    fcb       $86,$0D   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $0C       ; table, bitmap, or initialized data bytes
                    fcc       "5T"                           ; embedded text or resource bytes
                    fcb       $86,$05   ; table, bitmap, or initialized data bytes
                    fcc       " Q5TO_ "                      ; embedded text or resource bytes
                    fcb       $B2       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $02,$D7   ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $C6       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $A6,$85,$81 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $26,$0B   ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $C1,$FF,$26,$F5 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "_O "                          ; embedded text or resource bytes
                    fcb       $9B       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $D1       ; table, bitmap, or initialized data bytes
                    fcc       "\$"                           ; embedded text or resource bytes
                    fcb       $02,$D6   ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $D7       ; table, bitmap, or initialized data bytes
                    fcc       "[1"                           ; embedded text or resource bytes
                    fcb       $C9,$01   ; table, bitmap, or initialized data bytes
                    fcc       "q_"                           ; embedded text or resource bytes
                    fcb       $A6,$85,$A1,$A5,$26,$07 ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $C1       ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $26,$F5   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "O_"                           ; embedded text or resource bytes
                    fcb       $DD,$1E,$96 ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $D6       ; table, bitmap, or initialized data bytes
                    fcc       "["                            ; embedded text or resource bytes
                    fcb       $10,$AE,$E4,$9E,$1E ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $06,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $26,$02,$E6,$A4,$E7,$A4 ; table, bitmap, or initialized data bytes
                    fcc       "5 4"                          ; embedded text or resource bytes
                    fcb       $06,$17,$E2,$CD ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $17,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "F"                            ; embedded text or resource bytes
                    fcb       $17,$E2,$C6,$17 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $06       ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $81       ; table, bitmap, or initialized data bytes
                    fcc       "a%"                           ; embedded text or resource bytes
                    fcb       $06,$81   ; table, bitmap, or initialized data bytes
                    fcc       "{$"                           ; embedded text or resource bytes
                    fcb       $02,$80   ; table, bitmap, or initialized data bytes
                    fcc       " 9O"                          ; embedded text or resource bytes
                    fcb       $DD,$18   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C9,$00,$BB,$10,$9E,$08 ; table, bitmap, or initialized data bytes
                    fcb       $10,$9C,$1E ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "1?4 5 "                       ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "Y"                            ; embedded text or resource bytes
                    fcb       $1F       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $D3,$18,$10,$93,$04 ; table, bitmap, or initialized data bytes
                    fcc       "$C1!_4 "                      ; embedded text or resource bytes
                    fcb       $A6,$A0,$81,$0A,$26,$04 ; table, bitmap, or initialized data bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       "  "                           ; embedded text or resource bytes
                    fcb       $0A,$81,$0B,$26,$04,$0C ; table, bitmap, or initialized data bytes
                    fcc       "Y "                           ; embedded text or resource bytes
                    fcb       $EE,$8D,$BC,$97 ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $A6,$85,$8D,$B6,$91 ; table, bitmap, or initialized data bytes
                    fcc       "\'"                           ; embedded text or resource bytes
                    fcb       $0A,$81   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $26,$CC,$96 ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $81,$0D,$26,$C6 ; table, bitmap, or initialized data bytes
                    fcc       "O\"                           ; embedded text or resource bytes
                    fcb       $10,$93,$18,$26,$D1 ; table, bitmap, or initialized data bytes
                    fcc       "5 "                           ; embedded text or resource bytes
                    fcb       $A6,$A0,$81 ; table, bitmap, or initialized data bytes
                    fcc       " %"                           ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "1?"                           ; embedded text or resource bytes
                    fcb       $10,$9F,$1E,$1A,$01 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $1F       ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $17,$ED,$1A ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $10,$17,$EE ; table, bitmap, or initialized data bytes
                    fcc       "]"                            ; embedded text or resource bytes
                    fcb       $AC,$E4   ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $06,$10,$AE,$E4,$10,$9F ; table, bitmap, or initialized data bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $10,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "O9"                           ; embedded text or resource bytes
                    fcb       $86,$01,$97 ; table, bitmap, or initialized data bytes
                    fcc       "S"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "T0"                           ; embedded text or resource bytes
                    fcb       $8D,$FE,$7F,$17,$E2 ; table, bitmap, or initialized data bytes
                    fcc       "-8"                           ; embedded text or resource bytes
                    fcb       $CC,$00,$01,$17,$04 ; table, bitmap, or initialized data bytes
                    fcc       "J0"                           ; embedded text or resource bytes
                    fcb       $8D,$FE   ; table, bitmap, or initialized data bytes
                    fcc       "y"                            ; embedded text or resource bytes
                    fcb       $17,$F5,$C7 ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $17,$E2,$1B,$22,$0F ; table, bitmap, or initialized data bytes
                    fcc       "]"                            ; embedded text or resource bytes
                    fcb       $CC,$00,$06 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C9,$00,$BB ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $C9,$00   ; table, bitmap, or initialized data bytes
                    fcc       "`"                            ; embedded text or resource bytes
                    fcb       $17,$FE,$7F,$81,$05 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $1A,$17,$FF ; table, bitmap, or initialized data bytes
                    fcc       "L%"                           ; embedded text or resource bytes
                    fcb       $10,$9E,$00,$9F,$02,$9F ; table, bitmap, or initialized data bytes
                    fcb       $08,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $86,$01,$97 ; table, bitmap, or initialized data bytes
                    fcc       "S"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "T "                           ; embedded text or resource bytes
                    fcb       $05,$10,$9F,$08,$8D,$99 ; table, bitmap, or initialized data bytes
Data_1E27           fcc       "O"                            ; embedded text or resource bytes
                    fcb       $17,$E1,$E8 ; table, bitmap, or initialized data bytes
                    fcc       "79"                           ; embedded text or resource bytes
                    fcb       $86,$01,$97 ; table, bitmap, or initialized data bytes
                    fcc       "S"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "T0"                           ; embedded text or resource bytes
                    fcb       $8D,$FE   ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $17,$E1,$D9 ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
                    fcb       $CC,$00,$01,$17,$03,$F6 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FE   ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $17,$F5   ; table, bitmap, or initialized data bytes
                    fcc       "s_"                           ; embedded text or resource bytes
                    fcb       $17,$E1,$C7,$22,$CC,$03 ; table, bitmap, or initialized data bytes
                    fcb       $01,$17,$03,$E4 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FE   ; table, bitmap, or initialized data bytes
                    fcc       ")"                            ; embedded text or resource bytes
                    fcb       $17,$F5   ; table, bitmap, or initialized data bytes
                    fcc       "a_"                           ; embedded text or resource bytes
                    fcb       $17,$E1,$B5,$22,$CC,$00 ; table, bitmap, or initialized data bytes
                    fcb       $08,$97   ; table, bitmap, or initialized data bytes
                    fcc       "]0"                           ; embedded text or resource bytes
                    fcb       $C9,$00,$BB ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $C9,$00   ; table, bitmap, or initialized data bytes
                    fcc       "`"                            ; embedded text or resource bytes
                    fcb       $17,$FE,$19,$81,$05,$10 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $00,$F8,$CC,$03,$08 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C9,$01,$16 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $C9,$00   ; table, bitmap, or initialized data bytes
                    fcc       "a"                            ; embedded text or resource bytes
                    fcb       $17,$FE,$05,$81,$05,$10 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $00,$E4,$D6 ; table, bitmap, or initialized data bytes
                    fcc       "`"                            ; embedded text or resource bytes
                    fcb       $17,$FE,$CE ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $01,$17,$F2 ; table, bitmap, or initialized data bytes
                    fcc       "`5"                           ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $0A,$16,$FF ; table, bitmap, or initialized data bytes
                    fcc       "x"                            ; embedded text or resource bytes
                    fcb       $D6       ; table, bitmap, or initialized data bytes
                    fcc       "`"                            ; embedded text or resource bytes
                    fcb       $17,$FE,$BD ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $F6,$10,$9F,$08,$1F ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $17,$EC   ; table, bitmap, or initialized data bytes
                    fcc       "6"                            ; embedded text or resource bytes
                    fcb       $9F,$02,$9F,$0C,$0F ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $86,$01,$97 ; table, bitmap, or initialized data bytes
                    fcc       "T"                            ; embedded text or resource bytes
                    fcb       $1F       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $93,$0C,$D7 ; table, bitmap, or initialized data bytes
                    fcc       "MO4"                          ; embedded text or resource bytes
                    fcb       $06,$C6,$16,$17,$E9 ; table, bitmap, or initialized data bytes
                    fcc       "S5"                           ; embedded text or resource bytes
                    fcb       $06,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $17,$E9,$E4,$D6 ; table, bitmap, or initialized data bytes
                    fcc       "`"                            ; embedded text or resource bytes
                    fcb       $9E,$08   ; table, bitmap, or initialized data bytes
                    fcc       "O4"                           ; embedded text or resource bytes
                    fcb       $04,$1F,$02 ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $A6,$80,$81,$0B ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $81       ; table, bitmap, or initialized data bytes
                    fcc       " $"                           ; embedded text or resource bytes
                    fcb       $F5,$E1,$E4 ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $1D       ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $1F,$02,$17,$E1 ; table, bitmap, or initialized data bytes
                    fcc       "*$"                           ; embedded text or resource bytes
                    fcb       $A6,$E0   ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $04,$A0,$E0 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $06,$0C   ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       "Z_"                           ; embedded text or resource bytes
                    fcb       $17,$E9,$B4 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $06,$1F,$89 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $CE       ; table, bitmap, or initialized data bytes
                    fcc       "2a"                           ; embedded text or resource bytes
                    fcb       $17,$E1,$0E ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $17,$00,$89 ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $8C,$26,$8D ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $C9,$01,$16,$1F ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $D6       ; table, bitmap, or initialized data bytes
                    fcc       "a:"                           ; embedded text or resource bytes
                    fcb       $1E,$12,$D6 ; table, bitmap, or initialized data bytes
                    fcc       "`"                            ; embedded text or resource bytes
                    fcb       $DB       ; table, bitmap, or initialized data bytes
                    fcc       "Y"                            ; embedded text or resource bytes
                    fcb       $17,$E3   ; table, bitmap, or initialized data bytes
                    fcc       "7"                            ; embedded text or resource bytes
                    fcb       $DB       ; table, bitmap, or initialized data bytes
                    fcc       "a"                            ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       "Y"                            ; embedded text or resource bytes
                    fcb       $9B       ; table, bitmap, or initialized data bytes
                    fcc       "`4"                           ; embedded text or resource bytes
                    fcb       $02,$E0,$E0 ; table, bitmap, or initialized data bytes
                    fcc       "#"                            ; embedded text or resource bytes
                    fcb       $12       ; table, bitmap, or initialized data bytes
                    fcc       "O4"                           ; embedded text or resource bytes
                    fcb       $06       ; table, bitmap, or initialized data bytes
                    fcc       "4 "                           ; embedded text or resource bytes
                    fcb       $17,$ED,$CF ; table, bitmap, or initialized data bytes
                    fcc       "5 "                           ; embedded text or resource bytes
                    fcb       $AC,$E1   ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $04,$17,$EB,$14 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $9E,$08,$D6 ; table, bitmap, or initialized data bytes
                    fcc       "`"                            ; embedded text or resource bytes
                    fcb       $DB       ; table, bitmap, or initialized data bytes
                    fcc       "YO"                           ; embedded text or resource bytes
                    fcb       $17,$ED   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $9E,$08,$D6 ; table, bitmap, or initialized data bytes
                    fcc       "aO4"                          ; embedded text or resource bytes
                    fcb       $06,$17,$ED,$00 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $06,$DD,$1A ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C9,$01,$16,$10,$9E,$08 ; table, bitmap, or initialized data bytes
                    fcb       $17,$EC,$DD,$9E,$08,$17 ; table, bitmap, or initialized data bytes
                    fcb       $EB       ; table, bitmap, or initialized data bytes
                    fcc       "{"                            ; embedded text or resource bytes
                    fcb       $17,$EC,$A3,$17,$01,$0C ; table, bitmap, or initialized data bytes
                    fcb       $16,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "-O"                           ; embedded text or resource bytes
                    fcb       $17,$E0,$A2 ; table, bitmap, or initialized data bytes
                    fcc       "79"                           ; embedded text or resource bytes
                    fcb       $00,$04,$14,$18,$03,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $18       ; table, bitmap, or initialized data bytes
                    fcc       "Replace?    yes     n"        ; embedded text or resource bytes
                    fcc       "o"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FF,$DD,$17,$E0 ; table, bitmap, or initialized data bytes
                    fcc       "z8"                           ; embedded text or resource bytes
                    fcb       $CC,$15,$05,$17,$E0 ; table, bitmap, or initialized data bytes
                    fcc       "s"                            ; embedded text or resource bytes
                    fcb       $0B       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FF,$D6,$17,$F4,$13 ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $17,$E0   ; table, bitmap, or initialized data bytes
                    fcc       "g"                            ; embedded text or resource bytes
                    fcb       $22       ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $C9,$01   ; table, bitmap, or initialized data bytes
                    fcc       "q"                            ; embedded text or resource bytes
                    fcb       $DC       ; table, bitmap, or initialized data bytes
                    fcc       "6"                            ; embedded text or resource bytes
                    fcb       $ED,$A1,$DC ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
                    fcb       $ED,$A1,$CC,$14,$16,$ED ; table, bitmap, or initialized data bytes
                    fcb       $A1,$DC   ; table, bitmap, or initialized data bytes
                    fcc       "F"                            ; embedded text or resource bytes
                    fcb       $ED,$A1,$DC ; table, bitmap, or initialized data bytes
                    fcc       ">"                            ; embedded text or resource bytes
                    fcb       $ED,$A1,$DC ; table, bitmap, or initialized data bytes
                    fcc       "@"                            ; embedded text or resource bytes
                    fcb       $ED,$A1   ; table, bitmap, or initialized data bytes
                    fcc       "14"                           ; embedded text or resource bytes
                    fcb       $17,$F5,$CC ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $17,$E0   ; table, bitmap, or initialized data bytes
                    fcc       "@7"                           ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       "Z9"                           ; embedded text or resource bytes
Code_1FD7           ldb       Addr_004C ; load the value needed by the following operation
                    stb       Addr_005A ; save the current value in working storage
                    ldx       Addr_000C ; load the value needed by the following operation
                    stx       Addr_0018 ; save the current value in working storage
                    cmpx      DeskMateService ; compare against the limit and set condition flags
                    beq       Code_2020 ; branch when the compared values are equal
                    lda       -$01,X    ; load the value needed by the following operation
                    cmpa      #$0A      ; compare against the limit and set condition flags
                    bne       Code_2020 ; branch when the compared values differ
                    pshs      X         ; preserve the listed registers on the stack
                    lbsr      Code_0C0A ; call the referenced helper routine
                    tfr       X,Y       ; copy the source register into the destination register
                    puls      D         ; restore the listed registers from the stack
                    pshs      Y         ; preserve the listed registers on the stack
                    tfr       D,X       ; copy the source register into the destination register
                    subd      ,S        ; subtract the operand from the running value
                    pshs      B         ; preserve the listed registers on the stack
                    ldb       Code_0051 ; load the value needed by the following operation
                    incb                ; advance the selected counter
                    subb      ,S+       ; subtract the operand from the running value
                    pshs      B         ; preserve the listed registers on the stack
                    lbsr      Code_0A63 ; call the referenced helper routine
                    incb                ; advance the selected counter
                    cmpb      ,S+       ; compare against the limit and set condition flags
                    puls      Y         ; restore the listed registers from the stack
                    bhi       Code_2020 ; branch when the unsigned value is above the limit
                    sty       Addr_0018 ; save the current value in working storage
                    dec       Addr_005A ; decrement the selected counter
                    cmpy      Addr_0002 ; compare against the limit and set condition flags
                    bcc       Code_2020 ; branch when carry is clear
                    sty       Addr_0002 ; save the current value in working storage
                    lda       #$01      ; load the value needed by the following operation
                    sta       Code_0053 ; save the current value in working storage
                    sta       Addr_0054 ; save the current value in working storage
                    bra       Code_2027 ; continue at the selected control-flow target
Code_2020           lbsr      Code_0C27 ; call the referenced helper routine
                    stb       Code_005B ; save the current value in working storage
                    stx       Code_0016 ; save the current value in working storage
Code_2027           lbsr      Code_2090 ; call the referenced helper routine
                    tst       Code_0053 ; set condition flags from the current value
                    bne       Code_2073 ; branch when the compared values differ
                    lda       Addr_005A ; load the value needed by the following operation
                    cmpa      #$15      ; compare against the limit and set condition flags
                    bne       Code_204B ; branch when the compared values differ
                    tst       Code_0057 ; set condition flags from the current value
                    bne       Code_203E ; branch when the compared values differ
                    cmpy      #Addr_0001 ; compare against the limit and set condition flags
                    beq       Code_204B ; branch when the compared values are equal
Code_203E           ldx       Addr_0002 ; load the value needed by the following operation
                    lbsr      Code_0C20 ; call the referenced helper routine
                    stx       Addr_0002 ; save the current value in working storage
                    lda       #$01      ; load the value needed by the following operation
                    sta       Code_0053 ; save the current value in working storage
                    bra       Code_2073 ; continue at the selected control-flow target
Code_204B           tst       Code_0057 ; set condition flags from the current value
                    bne       Code_206A ; branch when the compared values differ
                    lbsr      Code_0C27 ; call the referenced helper routine
                    cmpb      Code_005B ; compare against the limit and set condition flags
                    beq       Code_205E ; branch when the compared values are equal
                    bcs       Code_206A ; branch when carry reports an unsigned underflow or error
                    lda       #$01      ; load the value needed by the following operation
                    sta       Addr_0054 ; save the current value in working storage
                    bra       Code_206A ; continue at the selected control-flow target
Code_205E           cmpx      Code_0016 ; compare against the limit and set condition flags
                    bne       Code_206A ; branch when the compared values differ
                    tfr       Y,D       ; copy the source register into the destination register
                    cmpy      #Code_0016 ; compare against the limit and set condition flags
                    bcs       Code_206C ; branch when carry reports an unsigned underflow or error
Code_206A           ldb       #$16      ; load the value needed by the following operation
Code_206C           ldx       Addr_0018 ; load the value needed by the following operation
                    lda       Addr_005A ; load the value needed by the following operation
                    lbsr      Code_0816 ; call the referenced helper routine
Code_2073           clr       Code_0057 ; clear the selected byte or register
                    rts                 ; return to the caller
Code_2076           pshs      X         ; preserve the listed registers on the stack
                    leax      Data_0DF2,PCR ; form the referenced address without reading memory
                    lbsr      Code_0E18 ; call the referenced helper routine
                    puls      X         ; restore the listed registers from the stack
Code_2081           pshs      X         ; preserve the listed registers on the stack
                    lbsr      Code_20A5 ; call the referenced helper routine
                    puls      X         ; restore the listed registers from the stack
                    lbsr      Code_0C20 ; call the referenced helper routine
                    cmpx      Addr_0004 ; compare against the limit and set condition flags
                    bls       Code_2081 ; branch when the unsigned value is at or below the limit
                    rts                 ; return to the caller
Code_2090           ldx       Addr_0018 ; load the value needed by the following operation
                    ldy       #DeskMateService ; load the value needed by the following operation
Code_2096           pshs      Y         ; preserve the listed registers on the stack
                    lbsr      Code_20A5 ; call the referenced helper routine
                    puls      Y         ; restore the listed registers from the stack
                    leay      $01,Y     ; form the referenced address without reading memory
                    cmpx      #DeskMateService ; compare against the limit and set condition flags
                    bne       Code_2096 ; branch when the compared values differ
                    rts                 ; return to the caller
Code_20A5           clrb                ; clear the selected byte or register
                    stb       Addr_0056 ; save the current value in working storage
                    stb       Addr_005C ; save the current value in working storage
Code_20AA           clra                ; clear the selected byte or register
                    lda       D,X       ; load the value needed by the following operation
                    lbsr      Code_21F8 ; call the referenced helper routine
                    incb                ; advance the selected counter
                    cmpb      Code_0051 ; compare against the limit and set condition flags
                    bhi       Code_212F ; branch when the unsigned value is above the limit
                    cmpa      #$21      ; compare against the limit and set condition flags
                    bcc       Code_20AA ; branch when carry is clear
                    cmpa      #$0B      ; compare against the limit and set condition flags
                    bne       Code_20C8 ; branch when the compared values differ
Code_20BD           pshs      Y,X       ; preserve the listed registers on the stack
                    decb                ; decrement the selected counter
                    abx                 ; add the operand to the running value
                    lbsr      Code_0DAA ; call the referenced helper routine
                    puls      Y,X       ; restore the listed registers from the stack
                    bra       Code_20AA ; continue at the selected control-flow target
Code_20C8           cmpa      #$1A      ; compare against the limit and set condition flags
                    bne       Code_20DB ; branch when the compared values differ
                    pshs      X         ; preserve the listed registers on the stack
                    decb                ; decrement the selected counter
                    abx                 ; add the operand to the running value
                    incb                ; advance the selected counter
                    cmpx      Addr_0004 ; compare against the limit and set condition flags
                    puls      X         ; restore the listed registers from the stack
                    lbeq      Code_2165 ; take the distant branch when values are equal
                    bra       Code_20BD ; continue at the selected control-flow target
Code_20DB           cmpa      #$0D      ; compare against the limit and set condition flags
                    bne       Code_2117 ; branch when the compared values differ
Code_20DF           abx                 ; add the operand to the running value
                    tst       Addr_005C ; set condition flags from the current value
                    bne       Code_2116 ; branch when the compared values differ
                    tfr       X,Y       ; copy the source register into the destination register
                    clrb                ; clear the selected byte or register
Code_20E7           clra                ; clear the selected byte or register
                    lda       D,X       ; load the value needed by the following operation
                    cmpa      #$0B      ; compare against the limit and set condition flags
                    bne       Code_20F4 ; branch when the compared values differ
                    cmpb      Code_0051 ; compare against the limit and set condition flags
                    bcc       Code_2165 ; branch when carry is clear
                    bra       Code_2116 ; continue at the selected control-flow target
Code_20F4           cmpb      Code_0051 ; compare against the limit and set condition flags
                    bcc       Code_2116 ; branch when carry is clear
                    incb                ; advance the selected counter
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bcc       Code_20E7 ; branch when carry is clear
                    cmpa      #$0A      ; compare against the limit and set condition flags
                    bne       Code_2165 ; branch when the compared values differ
                    abx                 ; add the operand to the running value
                    pshs      B         ; preserve the listed registers on the stack
                    ldb       Code_0051 ; load the value needed by the following operation
                    incb                ; advance the selected counter
                    subb      ,S+       ; subtract the operand from the running value
                    pshs      B         ; preserve the listed registers on the stack
                    pshs      Y         ; preserve the listed registers on the stack
                    lbsr      Code_0A63 ; call the referenced helper routine
                    puls      X         ; restore the listed registers from the stack
                    cmpb      ,S+       ; compare against the limit and set condition flags
                    bcc       Code_2165 ; branch when carry is clear
Code_2116           rts                 ; return to the caller
Code_2117           sta       Addr_0056 ; save the current value in working storage
                    cmpa      #$0A      ; compare against the limit and set condition flags
                    bne       Code_211F ; branch when the compared values differ
                    inc       Addr_005C ; advance the selected counter
Code_211F           decb                ; decrement the selected counter
                    pshs      X         ; preserve the listed registers on the stack
                    abx                 ; add the operand to the running value
                    tfr       X,Y       ; copy the source register into the destination register
                    puls      X         ; restore the listed registers from the stack
                    lda       #$20      ; load the value needed by the following operation
                    sta       ,Y        ; save the current value in working storage
                    incb                ; advance the selected counter
                    lbra      Code_20AA ; continue at the distant control-flow target
Code_212F           cmpa      #$0B      ; compare against the limit and set condition flags
                    beq       Code_20BD ; branch when the compared values are equal
                    cmpa      #$21      ; compare against the limit and set condition flags
                    bcs       Code_2157 ; branch when carry reports an unsigned underflow or error
                    tst       Addr_0056 ; set condition flags from the current value
                    bne       Code_214A ; branch when the compared values differ
                    abx                 ; add the operand to the running value
                    lda       ,X        ; load the value needed by the following operation
                    cmpa      #$0B      ; compare against the limit and set condition flags
                    beq       Code_2165 ; branch when the compared values are equal
                    ldb       #$0B      ; load the value needed by the following operation
                    lbsr      Code_0D9D ; call the referenced helper routine
                    leax      $01,X     ; form the referenced address without reading memory
                    rts                 ; return to the caller
Code_214A           ldb       #$0A      ; load the value needed by the following operation
                    stb       ,Y+       ; store the value and advance the destination pointer
                    lda       Addr_0056 ; load the value needed by the following operation
                    cmpa      #$0A      ; compare against the limit and set condition flags
                    beq       Code_2165 ; branch when the compared values are equal
                    tfr       Y,X       ; copy the source register into the destination register
                    rts                 ; return to the caller
Code_2157           cmpa      #$1A      ; compare against the limit and set condition flags
                    beq       Code_2165 ; branch when the compared values are equal
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    lbeq      Code_20DF ; take the distant branch when values are equal
                    cmpa      #$0A      ; compare against the limit and set condition flags
                    bne       Code_2169 ; branch when the compared values differ
Code_2165           ldx       #DeskMateService ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_2169           decb                ; decrement the selected counter
                    abx                 ; add the operand to the running value
                    ldb       #$0A      ; load the value needed by the following operation
                    stb       ,X+       ; store the value and advance the destination pointer
                    rts                 ; return to the caller
Code_2170           clr       Code_0053 ; clear the selected byte or register
                    cmpa      #$01      ; compare against the limit and set condition flags
                    bne       Code_217F ; branch when the compared values differ
                    ldx       Addr_0002 ; load the value needed by the following operation
                    clra                ; clear the selected byte or register
                    ldb       #$16      ; load the value needed by the following operation
                    lbsr      Code_0816 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_217F           ldx       #DeskMateService ; load the value needed by the following operation
                    cmpa      #$02      ; compare against the limit and set condition flags
                    bne       Code_2194 ; branch when the compared values differ
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1B       ; private DeskMate service selector
                    lbsr      Code_0CA3 ; call the referenced helper routine
                    ldx       Addr_0002 ; load the value needed by the following operation
                    clra                ; clear the selected byte or register
                    ldb       #$01      ; load the value needed by the following operation
                    bra       Code_21A5 ; continue at the selected control-flow target
Code_2194           cmpa      #$03      ; compare against the limit and set condition flags
                    bne       Code_21A5 ; branch when the compared values differ
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1B       ; private DeskMate service selector
                    lbsr      Code_0CBA ; call the referenced helper routine
                    ldx       Addr_000C ; load the value needed by the following operation
                    lda       #$15      ; load the value needed by the following operation
                    ldb       #$01      ; load the value needed by the following operation
Code_21A5           lbsr      Code_21A9 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_21A9           cmpx      #DeskMateService ; compare against the limit and set condition flags
                    bne       Code_21B2 ; branch when the compared values differ
                    tst       Code_004B ; set condition flags from the current value
                    beq       Code_21F7 ; branch when the compared values are equal
Code_21B2           ldx       Addr_0008 ; load the value needed by the following operation
                    ldy       Addr_000A ; load the value needed by the following operation
                    cmpx      Addr_000A ; compare against the limit and set condition flags
                    bcc       Code_21BD ; branch when carry is clear
                    exg       X,Y       ; exchange the two register values
Code_21BD           lbsr      Code_0ADF ; call the referenced helper routine
                    pshs      X         ; preserve the listed registers on the stack
                    tfr       Y,X       ; copy the source register into the destination register
                    lbsr      Code_0ADF ; call the referenced helper routine
                    tfr       X,Y       ; copy the source register into the destination register
                    puls      X         ; restore the listed registers from the stack
                    sty       Addr_0018 ; save the current value in working storage
                    tfr       X,Y       ; copy the source register into the destination register
                    lbsr      Code_0C92 ; call the referenced helper routine
                    incb                ; advance the selected counter
                    pshs      B         ; preserve the listed registers on the stack
                    ldy       Addr_0018 ; load the value needed by the following operation
                    cmpy      Addr_0002 ; compare against the limit and set condition flags
                    bhi       Code_21E7 ; branch when the unsigned value is above the limit
                    ldy       Addr_0002 ; load the value needed by the following operation
                    sty       Addr_0018 ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    bra       Code_21EC ; continue at the selected control-flow target
Code_21E7           lbsr      Code_0C92 ; call the referenced helper routine
                    tfr       B,A       ; copy the source register into the destination register
Code_21EC           puls      B         ; restore the listed registers from the stack
                    pshs      A         ; preserve the listed registers on the stack
                    subb      ,S+       ; subtract the operand from the running value
                    ldx       Addr_0018 ; load the value needed by the following operation
                    lbsr      Code_0816 ; call the referenced helper routine
Code_21F7           rts                 ; return to the caller
Code_21F8           pshs      Y         ; preserve the listed registers on the stack
                    leay      >$0031,U  ; form the referenced address without reading memory
                    tst       Code_0030 ; set condition flags from the current value
                    beq       Code_221B ; branch when the compared values are equal
Code_2202           cmpa      #$FD      ; compare against the limit and set condition flags
                    beq       Code_222A ; branch when the compared values are equal
                    cmpa      #$FE      ; compare against the limit and set condition flags
                    beq       Code_221D ; branch when the compared values are equal
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    bne       Code_221B ; branch when the compared values differ
                    lda       ,Y        ; load the value needed by the following operation
                    pshs      X         ; preserve the listed registers on the stack
                    abx                 ; add the operand to the running value
                    sta       ,X        ; save the current value in working storage
                    stx       Addr_0002 ; save the current value in working storage
                    puls      X         ; restore the listed registers from the stack
                    bra       Code_2202 ; continue at the selected control-flow target
Code_221B           puls      PC,Y      ; restore the listed registers from the stack
Code_221D           lda       $01,Y     ; load the value needed by the following operation
                    pshs      X         ; preserve the listed registers on the stack
                    abx                 ; add the operand to the running value
                    sta       ,X        ; save the current value in working storage
                    stx       Addr_0008 ; save the current value in working storage
                    puls      X         ; restore the listed registers from the stack
                    bra       Code_2202 ; continue at the selected control-flow target
Code_222A           lda       $02,Y     ; load the value needed by the following operation
                    pshs      X         ; preserve the listed registers on the stack
                    abx                 ; add the operand to the running value
                    sta       ,X        ; save the current value in working storage
                    stx       Code_001C ; save the current value in working storage
                    puls      X         ; restore the listed registers from the stack
                    bra       Code_2202 ; continue at the selected control-flow target
                    fcc       "464"                          ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $1F,$01,$E6,$E0,$1F,$02 ; table, bitmap, or initialized data bytes
                    fcb       $17,$DD,$CE ; table, bitmap, or initialized data bytes
                    fcc       "D5"                           ; embedded text or resource bytes
                    fcb       $B6       ; table, bitmap, or initialized data bytes
Data_2248           fcc       "File"                         ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "Block"                        ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "Find"                         ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_2258           fcb       $00,$04,$05,$0A,$0B,$11 ; table, bitmap, or initialized data bytes
                    fcc       "()23<=FG"                     ; embedded text or resource bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
Data_2267           fcb       $00,$04,$0A,$0E,$16,$19 ; table, bitmap, or initialized data bytes
                    fcc       "78<=ABFG"                     ; embedded text or resource bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
Data_2276           fcb       $00,$08,$0C,$14,$18,$1E ; table, bitmap, or initialized data bytes
                    fcc       "7:<?ADFI"                     ; embedded text or resource bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
                    fcc       "4~"                           ; embedded text or resource bytes
                    fcb       $8D       ; table, bitmap, or initialized data bytes
                    fcc       "n"                            ; embedded text or resource bytes
                    fcb       $A6,$E4,$97,$13 ; table, bitmap, or initialized data bytes
                    fcc       "1J"                           ; embedded text or resource bytes
                    fcb       $C6,$07,$A6,$80,$A7,$A0 ; table, bitmap, or initialized data bytes
                    fcc       "Z."                           ; embedded text or resource bytes
                    fcb       $F9,$0F,$18,$0F,$19,$0F ; table, bitmap, or initialized data bytes
                    fcb       $15,$0F,$1A,$D6,$0E,$D1 ; table, bitmap, or initialized data bytes
                    fcb       $0C       ; table, bitmap, or initialized data bytes
                    fcc       "#"                            ; embedded text or resource bytes
                    fcb       $08,$03,$15,$0A,$0C,$0A ; table, bitmap, or initialized data bytes
                    fcb       $0C,$0C,$10,$0F,$11,$0F ; table, bitmap, or initialized data bytes
                    fcb       $17,$96,$13,$90,$0C ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $97,$11,$97,$17,$D6,$13 ; table, bitmap, or initialized data bytes
                    fcb       $D0,$11,$DB,$10,$D7,$14 ; table, bitmap, or initialized data bytes
                    fcb       $D6,$0E,$D0,$0C,$D7,$12 ; table, bitmap, or initialized data bytes
                    fcb       $96,$10,$9B,$0C ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $97,$1D,$0F,$16,$D6,$10 ; table, bitmap, or initialized data bytes
                    fcb       $DB,$16,$8D ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $96,$17,$17,$00 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $0C,$16,$96,$16,$91,$0C ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $08,$0C,$17,$96,$17,$91 ; table, bitmap, or initialized data bytes
                    fcb       $0E,$26,$E5,$17,$00 ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $17,$00   ; table, bitmap, or initialized data bytes
                    fcc       "85"                           ; embedded text or resource bytes
                    fcb       $FE       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $06,$17,$DD,$17 ; table, bitmap, or initialized data bytes
                    fcc       "/"                            ; embedded text or resource bytes
                    fcb       $1F,$8B   ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $1F,$03   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $1F,$02,$D6,$0F,$1F,$01 ; table, bitmap, or initialized data bytes
                    fcb       $17,$DD,$05 ; table, bitmap, or initialized data bytes
                    fcc       "D9"                           ; embedded text or resource bytes
                    fcb       $9E,$0A   ; table, bitmap, or initialized data bytes
                    fcc       "H"                            ; embedded text or resource bytes
                    fcb       $AE,$86   ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $E6,$80,$C4,$80,$17,$DC ; table, bitmap, or initialized data bytes
                    fcb       $F6,$0A   ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $D6,$14,$8D,$E1 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $D6,$0D,$1F,$02,$17,$DC ; table, bitmap, or initialized data bytes
                    fcb       $E8       ; table, bitmap, or initialized data bytes
                    fcc       "$9"                           ; embedded text or resource bytes
                    fcb       $0D,$15   ; table, bitmap, or initialized data bytes
                    fcc       "'6"                           ; embedded text or resource bytes
                    fcb       $D6       ; table, bitmap, or initialized data bytes
Data_2332           fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $8D       ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $0D,$11   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $0E       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$03,$85,$0D,$18 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $03,$8D   ; table, bitmap, or initialized data bytes
                    fcc       "2 "                           ; embedded text or resource bytes
                    fcb       $04,$17,$DC,$C8 ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $D6,$1D   ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $8D,$17,$D6,$11,$D1,$12 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $0C       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$03   ; table, bitmap, or initialized data bytes
                    fcc       "n"                            ; embedded text or resource bytes
                    fcb       $0D,$19   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $15,$17,$DC,$AD ; table, bitmap, or initialized data bytes
                    fcc       "A9O"                          ; embedded text or resource bytes
                    fcb       $1F,$02,$D6,$0D ; table, bitmap, or initialized data bytes
                    fcc       "T"                            ; embedded text or resource bytes
                    fcb       $DB,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $1F,$01,$17,$DC,$9D ; table, bitmap, or initialized data bytes
                    fcc       "D94"                          ; embedded text or resource bytes
                    fcb       $10,$17,$DC,$96,$1F ; table, bitmap, or initialized data bytes
                    fcc       "4 0"                          ; embedded text or resource bytes
                    fcb       $8D,$02,$BF,$17,$DC,$8C ; table, bitmap, or initialized data bytes
                    fcb       $06,$AE   ; table, bitmap, or initialized data bytes
                    fcc       "b"                            ; embedded text or resource bytes
                    fcb       $17,$DC,$86 ; table, bitmap, or initialized data bytes
                    fcc       "F50"                          ; embedded text or resource bytes
                    fcb       $17,$DC,$80,$03 ; table, bitmap, or initialized data bytes
                    fcc       "94~"                          ; embedded text or resource bytes
                    fcb       $17,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "]"                            ; embedded text or resource bytes
                    fcb       $0F,$18,$0F,$19,$0F ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $C6,$80,$17,$DC ; table, bitmap, or initialized data bytes
                    fcc       "n"                            ; embedded text or resource bytes
                    fcb       $1D,$97,$1C,$17,$DC ; table, bitmap, or initialized data bytes
                    fcc       "h"                            ; embedded text or resource bytes
                    fcb       $18       ; table, bitmap, or initialized data bytes
                    fcc       "M"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "I"                            ; embedded text or resource bytes
                    fcb       $17,$DC   ; table, bitmap, or initialized data bytes
                    fcc       "_E"                           ; embedded text or resource bytes
                    fcb       $D7       ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $9F       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $10,$9F   ; table, bitmap, or initialized data bytes
                    fcc       "6"                            ; embedded text or resource bytes
                    fcb       $C1,$01,$26,$0C,$86,$0D ; table, bitmap, or initialized data bytes
                    fcb       $10,$8C,$00,$FF,$26,$02 ; table, bitmap, or initialized data bytes
                    fcb       $86,$05,$97,$1C,$1F ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $C1,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "'("                           ; embedded text or resource bytes
                    fcb       $D7,$1B,$D1,$10 ; table, bitmap, or initialized data bytes
                    fcc       "%_"                           ; embedded text or resource bytes
                    fcb       $D1,$1D,$22 ; table, bitmap, or initialized data bytes
                    fcc       "["                            ; embedded text or resource bytes
                    fcb       $D1,$14   ; table, bitmap, or initialized data bytes
                    fcc       "'O"                           ; embedded text or resource bytes
                    fcb       $D0,$10,$DB,$11,$D1,$0E ; table, bitmap, or initialized data bytes
                    fcc       "$G4"                          ; embedded text or resource bytes
                    fcb       $04,$17,$FF ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $A6,$E0,$D6,$1B,$D7,$14 ; table, bitmap, or initialized data bytes
                    fcb       $97,$13,$17,$FF ; table, bitmap, or initialized data bytes
                    fcc       "' 2"                          ; embedded text or resource bytes
                    fcb       $96,$1C,$81,$0C ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $0C,$81,$0A ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $16,$0D,$1A ; table, bitmap, or initialized data bytes
                    fcc       "''"                           ; embedded text or resource bytes
                    fcb       $0F,$1A   ; table, bitmap, or initialized data bytes
                    fcc       "  "                           ; embedded text or resource bytes
                    fcb       $D6,$14,$D1,$10,$10 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "^Z"                           ; embedded text or resource bytes
                    fcb       $D7,$1B,$16,$FF,$C6,$D6 ; table, bitmap, or initialized data bytes
                    fcb       $14,$D1,$1D,$10 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $00,$1E   ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $D7,$1B,$16,$FF,$B8,$86 ; table, bitmap, or initialized data bytes
                    fcb       $FF,$97,$1A,$17,$FE,$FE ; table, bitmap, or initialized data bytes
                    fcb       $D6,$1C,$96,$13 ; table, bitmap, or initialized data bytes
                    fcc       "2b5"                          ; embedded text or resource bytes
                    fcb       $F8,$96,$1D ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $91,$1B,$26 ; table, bitmap, or initialized data bytes
                    fcc       "+"                            ; embedded text or resource bytes
                    fcb       $0C,$19,$D6,$11,$D1,$12 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $E9,$0C,$11,$17,$FE,$D4 ; table, bitmap, or initialized data bytes
                    fcb       $0C,$13,$8D ; table, bitmap, or initialized data bytes
                    fcc       "G"                            ; embedded text or resource bytes
                    fcb       $17,$DB,$C1,$26,$D6,$1D ; table, bitmap, or initialized data bytes
                    fcb       $17,$FE,$AC,$17,$DB,$B8 ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $96,$11,$9B,$0C ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $17,$FE,$AC,$17,$FE,$B8 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $BF,$96,$10 ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $91,$1B,$26,$BC,$0C,$18 ; table, bitmap, or initialized data bytes
                    fcb       $0D,$11   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $B9,$17,$FE,$A6,$0A,$11 ; table, bitmap, or initialized data bytes
                    fcb       $0A,$13,$8D,$17,$17,$DB ; table, bitmap, or initialized data bytes
                    fcb       $91       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $D6,$10,$17,$FE ; table, bitmap, or initialized data bytes
                    fcc       "|"                            ; embedded text or resource bytes
                    fcb       $17,$DB,$88 ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $96,$11,$17,$FE,$7F,$17 ; table, bitmap, or initialized data bytes
                    fcb       $FE,$8B   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $92,$D6,$10,$17,$FE ; table, bitmap, or initialized data bytes
                    fcc       "i"                            ; embedded text or resource bytes
                    fcb       $17,$DB   ; table, bitmap, or initialized data bytes
                    fcc       "u"                            ; embedded text or resource bytes
                    fcb       $0C,$1F,$10 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $1F,$01   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $04,$1F,$02,$CE ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $00,$DC,$0C ; table, bitmap, or initialized data bytes
                    fcc       "94~"                          ; embedded text or resource bytes
                    fcb       $17,$FE   ; table, bitmap, or initialized data bytes
                    fcc       "B"                            ; embedded text or resource bytes
                    fcb       $17,$DB   ; table, bitmap, or initialized data bytes
                    fcc       "[9"                           ; embedded text or resource bytes
                    fcb       $17,$DB   ; table, bitmap, or initialized data bytes
                    fcc       "W0"                           ; embedded text or resource bytes
                    fcb       $97,$26,$EC,$E4,$D7,$1F ; table, bitmap, or initialized data bytes
                    fcc       "M*!"                          ; embedded text or resource bytes
                    fcb       $84,$7F,$97 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $9F       ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $17,$DB   ; table, bitmap, or initialized data bytes
                    fcc       "DI"                           ; embedded text or resource bytes
                    fcb       $1F       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $D7       ; table, bitmap, or initialized data bytes
                    fcc       "#"                            ; embedded text or resource bytes
                    fcb       $1F,$10,$D7 ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $17,$DB   ; table, bitmap, or initialized data bytes
                    fcc       "84"                           ; embedded text or resource bytes
                    fcb       $0F,$1E,$86,$FF,$17,$DB ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $1E,$17,$01,$1D,$17,$01 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $17,$DB,$26,$18,$84,$80 ; table, bitmap, or initialized data bytes
                    fcb       $8A,$03,$1F,$89,$17,$DB ; table, bitmap, or initialized data bytes
                    fcb       $1C,$1C   ; table, bitmap, or initialized data bytes
                    fcc       "]*"                           ; embedded text or resource bytes
                    fcb       $04,$17,$DB,$15,$16,$97 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $9E       ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $D6,$1F   ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $85,$81   ; table, bitmap, or initialized data bytes
                    fcc       " %"                           ; embedded text or resource bytes
                    fcb       $18,$81   ; table, bitmap, or initialized data bytes
                    fcc       "~"                            ; embedded text or resource bytes
                    fcb       $22,$14,$0D,$1E,$10,$26 ; table, bitmap, or initialized data bytes
                    fcb       $00,$CF,$A7,$A4,$17,$DA ; table, bitmap, or initialized data bytes
                    fcb       $F9       ; table, bitmap, or initialized data bytes
                    fcc       "Cm!'"                         ; embedded text or resource bytes
                    fcb       $CB,$0C,$1F ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $C4,$81,$88 ; table, bitmap, or initialized data bytes
                    fcc       "'K"                           ; embedded text or resource bytes
                    fcb       $81,$08   ; table, bitmap, or initialized data bytes
                    fcc       "'l"                           ; embedded text or resource bytes
                    fcb       $81,$09   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $EC,$81,$C9,$10 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $00,$86,$81,$E9,$10 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $00,$80,$81,$0C ; table, bitmap, or initialized data bytes
                    fcc       "'r"                           ; embedded text or resource bytes
                    fcb       $81,$0A   ; table, bitmap, or initialized data bytes
                    fcc       "'\"                           ; embedded text or resource bytes
                    fcb       $81,$8D,$26,$17,$86,$0D ; table, bitmap, or initialized data bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $A7,$A0,$17,$DA,$C1 ; table, bitmap, or initialized data bytes
                    fcc       "Cm"                           ; embedded text or resource bytes
                    fcb       $A4       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $07,$0C,$1F,$17,$00,$C3 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $ED,$D6,$1F,$96,$26 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $04,$17,$DA,$AC ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $17,$DA,$A8 ; table, bitmap, or initialized data bytes
                    fcc       ":"                            ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       "%2b5"                         ; embedded text or resource bytes
                    fcb       $F8,$0D,$1E,$26 ; table, bitmap, or initialized data bytes
                    fcc       "S]'"                          ; embedded text or resource bytes
                    fcb       $13       ; table, bitmap, or initialized data bytes
                    fcc       "m!"                           ; embedded text or resource bytes
                    fcb       $26,$06,$86 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $A1,$A4,$26,$09,$0A,$1F ; table, bitmap, or initialized data bytes
                    fcb       $17,$00,$97,$9E ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $D6,$1F,$86 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $A7,$85,$17,$DA,$80 ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $16,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "S]'"                          ; embedded text or resource bytes
                    fcb       $FA,$0A,$1F,$16,$FF ; table, bitmap, or initialized data bytes
                    fcc       "H"                            ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       " J+"                          ; embedded text or resource bytes
                    fcb       $08       ; table, bitmap, or initialized data bytes
                    fcc       "\m"                           ; embedded text or resource bytes
                    fcb       $85,$26,$F8,$16,$FF,$BC ; table, bitmap, or initialized data bytes
                    fcb       $D7,$1F,$16,$FF ; table, bitmap, or initialized data bytes
                    fcc       "6"                            ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       " J+"                          ; embedded text or resource bytes
                    fcb       $F6       ; table, bitmap, or initialized data bytes
                    fcc       "Z+"                           ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $F8,$86,$FF,$03,$1E ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $02,$86,$01,$17,$DA ; table, bitmap, or initialized data bytes
                    fcc       "M"                            ; embedded text or resource bytes
                    fcb       $1E       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $CB       ; table, bitmap, or initialized data bytes
                    fcc       "]"                            ; embedded text or resource bytes
                    fcb       $26,$03   ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $D7,$1F   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $85,$A6,$80 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $04,$A7,$1E ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $F8,$86   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $A7,$1E,$0A,$1F,$8D ; table, bitmap, or initialized data bytes
                    fcc       ">"                            ; embedded text or resource bytes
                    fcb       $16,$FF,$00 ; table, bitmap, or initialized data bytes
                    fcc       "m!"                           ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
                    fcc       "+4"                           ; embedded text or resource bytes
                    fcb       $22,$A6,$A0,$26,$FC ; table, bitmap, or initialized data bytes
                    fcc       "1>"                           ; embedded text or resource bytes
                    fcb       $A6,$A2,$A7 ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $10,$AC   ; table, bitmap, or initialized data bytes
                    fcc       "a"                            ; embedded text or resource bytes
                    fcb       $26,$F7   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $12,$A7,$84,$8D,$03,$16 ; table, bitmap, or initialized data bytes
                    fcb       $FF,$17,$9E ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $D6,$1F   ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $85,$8D,$11,$A6,$80 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $08,$17,$D9,$FE ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $0C,$1F   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $F2       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $04,$D7,$1F ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $D6,$1F   ; table, bitmap, or initialized data bytes
                    fcc       "OL"                           ; embedded text or resource bytes
                    fcb       $D0       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $22,$FB   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $DB       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $9B       ; table, bitmap, or initialized data bytes
                    fcc       "#"                            ; embedded text or resource bytes
                    fcb       $DB       ; table, bitmap, or initialized data bytes
                    fcc       "$404"                         ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $1F,$01   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $04,$1F,$02,$17,$D9,$D5 ; table, bitmap, or initialized data bytes
                    fcc       "D5"                           ; embedded text or resource bytes
                    fcb       $B0       ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $08,$00,$03,$0C ; table, bitmap, or initialized data bytes
                    fcc       "0?"                           ; embedded text or resource bytes
                    fcb       $03,$03,$00,$C0 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $0C,$03   ; table, bitmap, or initialized data bytes
                    fcc       "?00"                          ; embedded text or resource bytes
                    fcb       $00,$00,$03,$03 ; table, bitmap, or initialized data bytes
                    fcc       "?0"                           ; embedded text or resource bytes
                    fcb       $0C,$03,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "00?"                          ; embedded text or resource bytes
                    fcb       $03,$0C   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C0,$00,$03,$0F ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $03,$03,$03,$00,$C0,$F0 ; table, bitmap, or initialized data bytes
                    fcb       $FC,$FF,$F0,$F0,$F0,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$03,$03,$03 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $0F,$03,$00,$00,$F0,$F0 ; table, bitmap, or initialized data bytes
                    fcb       $F0,$FF,$FC,$F0,$C0,$00 ; table, bitmap, or initialized data bytes
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
                    fcb       $00,$00,$00,$80,$81,$00 ; table, bitmap, or initialized data bytes
                    fcb       $84,$85,$00,$82,$83,$00 ; table, bitmap, or initialized data bytes
                    fcb       $86,$87,$00,$00,$04,$08 ; table, bitmap, or initialized data bytes
                    fcb       $18,$03,$00,$FF,$FF,$07 ; table, bitmap, or initialized data bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
                    fcc       "  Save as:"                   ; embedded text or resource bytes
                    fcb       $00,$00,$02,$0C,$1C,$07 ; table, bitmap, or initialized data bytes
                    fcb       $00,$AA   ; table, bitmap, or initialized data bytes
                    fcc       "8Use "                        ; embedded text or resource bytes
                    fcb       $22       ; table, bitmap, or initialized data bytes
                    fcc       "1:"                           ; embedded text or resource bytes
                    fcb       $22       ; table, bitmap, or initialized data bytes
                    fcc       " or "                         ; embedded text or resource bytes
                    fcb       $22       ; table, bitmap, or initialized data bytes
                    fcc       "2:"                           ; embedded text or resource bytes
                    fcb       $22       ; table, bitmap, or initialized data bytes
                    fcc       " to"                          ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "specify a data folder"        ; embedded text or resource bytes
                    fcb       $00,$00   ; table, bitmap, or initialized data bytes
                    fcc       "Filename must be 1-8"         ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "characters, begin wit"        ; embedded text or resource bytes
                    fcc       "h"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "a-z "                         ; embedded text or resource bytes
                    fcb       $26       ; table, bitmap, or initialized data bytes
                    fcc       " contain a-z or 0-9"          ; embedded text or resource bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $08       ; table, bitmap, or initialized data bytes
                    fcc       "4r"                           ; embedded text or resource bytes
                    fcb       $A6,$26,$A7,$8D,$FF ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $17,$FB   ; table, bitmap, or initialized data bytes
                    fcc       "}"                            ; embedded text or resource bytes
                    fcb       $17,$D8,$96 ; table, bitmap, or initialized data bytes
                    fcc       ">"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       ")"                            ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "+"                            ; embedded text or resource bytes
                    fcb       $AE,$A4,$9F ; table, bitmap, or initialized data bytes
                    fcc       "'3"                           ; embedded text or resource bytes
                    fcb       $8D,$FF,$D0,$EF,$A4,$17 ; table, bitmap, or initialized data bytes
                    fcb       $00,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FF   ; table, bitmap, or initialized data bytes
                    fcc       ":"                            ; embedded text or resource bytes
                    fcb       $17,$D8   ; table, bitmap, or initialized data bytes
                    fcc       "{8"                           ; embedded text or resource bytes
                    fcb       $AE       ; table, bitmap, or initialized data bytes
                    fcc       "a"                            ; embedded text or resource bytes
                    fcb       $26,$04   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "6O_"                          ; embedded text or resource bytes
                    fcb       $17,$D8   ; table, bitmap, or initialized data bytes
                    fcc       "m"                            ; embedded text or resource bytes
                    fcb       $0A,$8E,$00,$0B ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $15,$17,$D8 ; table, bitmap, or initialized data bytes
                    fcc       "dD"                           ; embedded text or resource bytes
                    fcb       $10,$AE   ; table, bitmap, or initialized data bytes
                    fcc       "c"                            ; embedded text or resource bytes
                    fcb       $AE,$A4,$CC,$90,$00,$17 ; table, bitmap, or initialized data bytes
                    fcb       $FC,$F5   ; table, bitmap, or initialized data bytes
                    fcc       "M'"                           ; embedded text or resource bytes
                    fcb       $0A,$81,$0D ; table, bitmap, or initialized data bytes
                    fcc       "'B"                           ; embedded text or resource bytes
                    fcb       $81,$05   ; table, bitmap, or initialized data bytes
                    fcc       "'3 -4v"                       ; embedded text or resource bytes
                    fcb       $17,$D8   ; table, bitmap, or initialized data bytes
                    fcc       "F>4"                          ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "m"                            ; embedded text or resource bytes
                    fcb       $8D,$FF,$02,$26,$04 ; table, bitmap, or initialized data bytes
                    fcc       "J*"                           ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $17,$D8   ; table, bitmap, or initialized data bytes
                    fcc       "6="                           ; embedded text or resource bytes
                    fcb       $17,$D8   ; table, bitmap, or initialized data bytes
                    fcc       "2E5"                          ; embedded text or resource bytes
                    fcb       $02,$17,$D8 ; table, bitmap, or initialized data bytes
                    fcc       ",="                           ; embedded text or resource bytes
                    fcb       $8C,$00,$FF ; table, bitmap, or initialized data bytes
                    fcc       "5v"                           ; embedded text or resource bytes
                    fcb       $26,$15,$86,$05 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $06       ; table, bitmap, or initialized data bytes
                    fcc       "5v"                           ; embedded text or resource bytes
                    fcb       $86,$0A   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $BF,$9E   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $AF,$A4,$A7,$E4 ; table, bitmap, or initialized data bytes
                    fcc       "_5r5"                         ; embedded text or resource bytes
                    fcb       $88,$A6,$80,$81 ; table, bitmap, or initialized data bytes
                    fcc       " '"                           ; embedded text or resource bytes
                    fcb       $FA,$A6,$84 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $1F,$81   ; table, bitmap, or initialized data bytes
                    fcc       ":"                            ; embedded text or resource bytes
                    fcb       $26,$0E,$A6,$84,$80 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $81,$02   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $06       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FE,$CE ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $11,$AE,$A4,$A6,$E4,$17 ; table, bitmap, or initialized data bytes
                    fcb       $D7,$EC   ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $C4,$EF   ; table, bitmap, or initialized data bytes
                    fcc       "]'O0"                         ; embedded text or resource bytes
                    fcb       $8D,$FE,$E6 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
Data_2833           fcb       $E6,$84,$0D ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $26,$08   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FE,$A7,$17,$D7,$D3 ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       ")"                            ; embedded text or resource bytes
                    fcb       $8B,$02,$17,$D7,$CB ; table, bitmap, or initialized data bytes
                    fcc       "="                            ; embedded text or resource bytes
                    fcb       $D1       ; table, bitmap, or initialized data bytes
                    fcc       "+'"                           ; embedded text or resource bytes
                    fcb       $06,$D7   ; table, bitmap, or initialized data bytes
                    fcc       "+"                            ; embedded text or resource bytes
                    fcb       $17,$D7,$C1 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $C6,$03,$D7 ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $10,$8E,$00,$01 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $8E,$00,$01,$17,$D7,$B1 ; table, bitmap, or initialized data bytes
                    fcc       "D"                            ; embedded text or resource bytes
                    fcb       $AE,$E4,$17,$D7,$AB,$0A ; table, bitmap, or initialized data bytes
                    fcb       $AF,$E4   ; table, bitmap, or initialized data bytes
                    fcc       "1!Z"                          ; embedded text or resource bytes
                    fcb       $26,$EB   ; table, bitmap, or initialized data bytes
                    fcc       "2b"                           ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       ")L"                           ; embedded text or resource bytes
                    fcb       $17,$D7,$9B ; table, bitmap, or initialized data bytes
                    fcc       "="                            ; embedded text or resource bytes
                    fcb       $16,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "+"                            ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       ")"                            ; embedded text or resource bytes
                    fcb       $17,$D7,$92 ; table, bitmap, or initialized data bytes
                    fcc       "7o"                           ; embedded text or resource bytes
                    fcb       $E4,$DE   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $AE,$A4,$EF,$A4,$8D,$04 ; table, bitmap, or initialized data bytes
                    fcc       "5r5"                          ; embedded text or resource bytes
                    fcb       $88,$A6,$80,$A7,$C0,$26 ; table, bitmap, or initialized data bytes
                    fcb       $FA       ; table, bitmap, or initialized data bytes
                    fcc       "9("                           ; embedded text or resource bytes
                    fcb       $0B,$02,$0C,$14,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U8P"                          ; embedded text or resource bytes
                    fcb       $17,$02,$18,$14,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U8"                           ; embedded text or resource bytes
                    fcb       $02,$03,$00,$06,$05 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FF,$FC,$00,$00,$00,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$00,$00,$00,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$FF,$F0,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$F0,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$03,$FF,$FF,$FC,$02 ; table, bitmap, or initialized data bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $03,$05,$7F,$E0,$00,$FF ; table, bitmap, or initialized data bytes
                    fcb       $F0,$00,$FF,$FF,$FC,$FF ; table, bitmap, or initialized data bytes
                    fcb       $C0,$00,$00,$1F,$FE,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$0E,$08,$00,$01,$04 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$C8,$00,$18,$01 ; table, bitmap, or initialized data bytes
                    fcb       $08,$00   ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $00,$01,$18,$00,$18,$01 ; table, bitmap, or initialized data bytes
                    fcc       "X"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "-4"                           ; embedded text or resource bytes
                    fcb       $06,$17,$D7,$17,$0F,$C1 ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $26,$04,$1F,$10 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8B       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $06,$17,$D7,$09 ; table, bitmap, or initialized data bytes
                    fcc       "D"                            ; embedded text or resource bytes
                    fcb       $17,$D7,$05 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       ":"                            ; embedded text or resource bytes
                    fcb       $17,$D6,$FF ; table, bitmap, or initialized data bytes
                    fcc       "594H"                         ; embedded text or resource bytes
                    fcb       $17,$F9,$DC ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $E9,$FE,$0C,$10,$DF ; table, bitmap, or initialized data bytes
                    fcc       ",46"                          ; embedded text or resource bytes
                    fcb       $17,$D6,$EC,$16,$0F ; table, bitmap, or initialized data bytes
                    fcc       "1O0"                          ; embedded text or resource bytes
                    fcb       $8D,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "h"                            ; embedded text or resource bytes
                    fcb       $17,$D6,$E1 ; table, bitmap, or initialized data bytes
                    fcc       "80"                           ; embedded text or resource bytes
                    fcb       $8D,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "p"                            ; embedded text or resource bytes
                    fcb       $17,$D6,$D9 ; table, bitmap, or initialized data bytes
                    fcc       "G"                            ; embedded text or resource bytes
                    fcb       $C6,$0C,$E7,$84,$17,$D6 ; table, bitmap, or initialized data bytes
                    fcb       $D1       ; table, bitmap, or initialized data bytes
                    fcc       "G"                            ; embedded text or resource bytes
                    fcb       $C6,$02,$E7,$84,$8E,$1F ; table, bitmap, or initialized data bytes
                    fcb       $1A,$10,$8E,$0B,$06,$86 ; table, bitmap, or initialized data bytes
                    fcb       $FF,$17,$D6,$C0,$0E ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $0A,$17,$D6,$BA,$0E,$17 ; table, bitmap, or initialized data bytes
                    fcb       $D6,$B6   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $DD       ; table, bitmap, or initialized data bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $17,$D6,$B0 ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $17,$D6,$AC ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $C6       ; table, bitmap, or initialized data bytes
                    fcc       "@"                            ; embedded text or resource bytes
                    fcb       $8E,$00,$02 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $1F,$86   ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $8D,$84,$8E,$00,$07 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $1A,$86   ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $17,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "z"                            ; embedded text or resource bytes
                    fcb       $DC       ; table, bitmap, or initialized data bytes
                    fcc       ".M"                           ; embedded text or resource bytes
                    fcb       $26,$04,$17,$D6,$8E ; table, bitmap, or initialized data bytes
                    fcc       "4]"                           ; embedded text or resource bytes
                    fcb       $26,$04,$17,$D6,$87 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $AE       ; table, bitmap, or initialized data bytes
                    fcc       "d"                            ; embedded text or resource bytes
                    fcb       $A6,$94,$80 ; table, bitmap, or initialized data bytes
                    fcc       "0'"                           ; embedded text or resource bytes
                    fcb       $04,$81,$03 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $06,$17,$D6 ; table, bitmap, or initialized data bytes
                    fcc       "wN"                           ; embedded text or resource bytes
                    fcb       $A6,$84,$8E,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $04,$17,$D6 ; table, bitmap, or initialized data bytes
                    fcc       "lD"                           ; embedded text or resource bytes
                    fcb       $17,$D6   ; table, bitmap, or initialized data bytes
                    fcc       "h@"                           ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $17,$01   ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $C6       ; table, bitmap, or initialized data bytes
                    fcc       ")="                           ; embedded text or resource bytes
                    fcb       $17,$D6   ; table, bitmap, or initialized data bytes
                    fcc       "\N0"                          ; embedded text or resource bytes
                    fcb       $88,$26   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8B,$DE   ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $10,$AE   ; table, bitmap, or initialized data bytes
                    fcc       "d"                            ; embedded text or resource bytes
                    fcb       $10,$AE,$22,$CC,$01,$F4 ; table, bitmap, or initialized data bytes
                    fcb       $17,$D6   ; table, bitmap, or initialized data bytes
                    fcc       "HL"                           ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $01,$01,$97 ; table, bitmap, or initialized data bytes
                    fcc       "0'1"                          ; embedded text or resource bytes
                    fcb       $1F,$89,$17,$D6 ; table, bitmap, or initialized data bytes
                    fcc       ":K"                           ; embedded text or resource bytes
                    fcb       $AE,$C4   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $1F,$AF,$C1 ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $26,$F7   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FE,$F7,$DE ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $EF,$84,$96 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $A7,$04,$17,$D6 ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $0F,$C1   ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $26,$04,$C6,$06,$E7,$05 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $17,$F8,$86,$C6,$01,$E7 ; table, bitmap, or initialized data bytes
                    fcb       $8D,$FE,$DE,$0D ; table, bitmap, or initialized data bytes
                    fcc       "0'"                           ; embedded text or resource bytes
                    fcb       $05,$17,$F9,$89 ; table, bitmap, or initialized data bytes
                    fcc       " -"                           ; embedded text or resource bytes
                    fcb       $1F,$13,$17,$D6,$00 ; table, bitmap, or initialized data bytes
                    fcc       "E"                            ; embedded text or resource bytes
                    fcb       $1E       ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $D7       ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $DF       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $10,$9F   ; table, bitmap, or initialized data bytes
                    fcc       "6"                            ; embedded text or resource bytes
                    fcb       $11,$83,$00,$FF,$26,$08 ; table, bitmap, or initialized data bytes
                    fcb       $C1,$01,$26,$04,$C6,$05 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $17,$D5,$E4,$1D,$17,$D5 ; table, bitmap, or initialized data bytes
                    fcb       $E0,$16,$1F,$89,$C1,$0D ; table, bitmap, or initialized data bytes
                    fcb       $26,$01   ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "3'"                           ; embedded text or resource bytes
                    fcb       $18       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $02,$96   ; table, bitmap, or initialized data bytes
                    fcc       "7"                            ; embedded text or resource bytes
                    fcb       $81,$03   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $02,$22,$0E,$86,$01,$D6 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $C1,$05,$10 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
                    fcc       "LL"                           ; embedded text or resource bytes
                    fcb       $16,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "H"                            ; embedded text or resource bytes
                    fcb       $C1,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "'9"                           ; embedded text or resource bytes
                    fcb       $C1,$05   ; table, bitmap, or initialized data bytes
                    fcc       "'f"                           ; embedded text or resource bytes
                    fcb       $C1,$09   ; table, bitmap, or initialized data bytes
                    fcc       "''"                           ; embedded text or resource bytes
                    fcb       $C1,$08   ; table, bitmap, or initialized data bytes
                    fcc       "'(4"                          ; embedded text or resource bytes
                    fcb       $06,$17,$D5,$A7,$18 ; table, bitmap, or initialized data bytes
                    fcc       "]'"                           ; embedded text or resource bytes
                    fcb       $11,$96   ; table, bitmap, or initialized data bytes
                    fcc       "7"                            ; embedded text or resource bytes
                    fcb       $81,$03,$22,$10,$86,$01 ; table, bitmap, or initialized data bytes
                    fcb       $D6       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $C1,$05   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $8D       ; table, bitmap, or initialized data bytes
                    fcc       "T5"                           ; embedded text or resource bytes
                    fcb       $06,$16,$FF,$7F,$96 ; table, bitmap, or initialized data bytes
                    fcc       "2 "                           ; embedded text or resource bytes
                    fcb       $F5,$86,$02,$16,$FF,$10 ; table, bitmap, or initialized data bytes
                    fcb       $86,$01,$16,$FF,$0B,$9E ; table, bitmap, or initialized data bytes
                    fcc       ",H"                           ; embedded text or resource bytes
                    fcb       $AE,$86   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $01,$10,$AE ; table, bitmap, or initialized data bytes
                    fcc       "d"                            ; embedded text or resource bytes
                    fcb       $EE,$A4,$96 ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $8B       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C6       ; table, bitmap, or initialized data bytes
                    fcc       ":"                            ; embedded text or resource bytes
                    fcb       $ED,$C1,$C6,$08,$86 ; table, bitmap, or initialized data bytes
                    fcc       " m"                           ; embedded text or resource bytes
                    fcb       $84       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $02,$A6,$80,$A7,$C0 ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $26,$F3   ; table, bitmap, or initialized data bytes
                    fcc       "o"                            ; embedded text or resource bytes
                    fcb       $C4,$A6,$E4 ; table, bitmap, or initialized data bytes
                    fcc       "o"                            ; embedded text or resource bytes
                    fcb       $E4,$17,$D5 ; table, bitmap, or initialized data bytes
                    fcc       "SJ"                           ; embedded text or resource bytes
                    fcb       $E7       ; table, bitmap, or initialized data bytes
                    fcc       "a "                           ; embedded text or resource bytes
                    fcb       $04,$86,$FF,$A7,$E4 ; table, bitmap, or initialized data bytes
                    fcc       "562"                          ; embedded text or resource bytes
                    fcb       $E9,$01,$F4 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $C8,$E7   ; table, bitmap, or initialized data bytes
                    fcc       "a "                           ; embedded text or resource bytes
                    fcb       $F4       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $16,$91   ; table, bitmap, or initialized data bytes
                    fcc       "1'"                           ; embedded text or resource bytes
                    fcb       $1E       ; table, bitmap, or initialized data bytes
                    fcc       "J4"                           ; embedded text or resource bytes
                    fcb       $02,$CC,$00,$FF ; table, bitmap, or initialized data bytes
                    fcc       "m"                            ; embedded text or resource bytes
                    fcb       $E0,$26,$02,$1E,$89 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FD,$FA,$A7,$84,$17 ; table, bitmap, or initialized data bytes
                    fcb       $D5       ; table, bitmap, or initialized data bytes
                    fcc       "#"                            ; embedded text or resource bytes
                    fcb       $13       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $09,$E7,$84,$17,$D5,$1B ; table, bitmap, or initialized data bytes
                    fcb       $13       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $16,$97   ; table, bitmap, or initialized data bytes
                    fcc       "19("                          ; embedded text or resource bytes
                    fcb       $80       ; table, bitmap, or initialized data bytes
Data_2B00           fcc       "?"                            ; embedded text or resource bytes
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
                    fcb       $00,$00,$00,$00,$00,$CC ; table, bitmap, or initialized data bytes
                    fcb       $CC       ; table, bitmap, or initialized data bytes
                    fcc       "33"                           ; embedded text or resource bytes
                    fcb       $CC,$CC   ; table, bitmap, or initialized data bytes
                    fcc       "33"                           ; embedded text or resource bytes
                    fcb       $CC,$CC   ; table, bitmap, or initialized data bytes
                    fcc       "33"                           ; embedded text or resource bytes
                    fcb       $CC,$CC   ; table, bitmap, or initialized data bytes
                    fcc       "33("                          ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
Data_3302           fcb       $CC,$CC   ; table, bitmap, or initialized data bytes
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
