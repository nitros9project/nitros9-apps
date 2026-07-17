********************************************************************
* DMCALN - DeskMate 3 calendar
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

                    nam       DMCALN
                    ttl       DeskMate 3 calendar

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct
atrv                set       $00

                    mod       eom,name,tylg,atrv,start,$5684

name                fcs       /DMCALN/ ; OS-9 module name

Addr_0001           equ       $0001     ; absolute address used by original code
Addr_0002           equ       $0002     ; absolute address used by original code
Addr_0003           equ       $0003     ; absolute address used by original code
Addr_0004           equ       $0004     ; absolute address used by original code
Addr_0005           equ       $0005     ; absolute address used by original code
Addr_0006           equ       $0006     ; absolute address used by original code
Addr_0007           equ       $0007     ; absolute address used by original code
Addr_0008           equ       $0008     ; absolute address used by original code
Addr_0009           equ       $0009     ; absolute address used by original code
Addr_000A           equ       $000A     ; absolute address used by original code
Addr_000B           equ       $000B     ; absolute address used by original code
Addr_000C           equ       $000C     ; absolute address used by original code
Addr_000D           equ       $000D     ; absolute address used by original code
Addr_000E           equ       $000E     ; absolute address used by original code
Addr_000F           equ       $000F     ; absolute address used by original code
Addr_0010           equ       $0010     ; absolute address used by original code
Addr_0011           equ       $0011     ; absolute address used by original code
Addr_0012           equ       $0012     ; absolute address used by original code
Addr_0014           equ       $0014     ; absolute address used by original code
Addr_0015           equ       $0015     ; absolute address used by original code
Addr_0017           equ       $0017     ; absolute address used by original code
Addr_0018           equ       $0018     ; absolute address used by original code
Addr_0019           equ       $0019     ; absolute address used by original code
Addr_001B           equ       $001B     ; absolute address used by original code
Addr_001D           equ       $001D     ; absolute address used by original code
Addr_001E           equ       $001E     ; absolute address used by original code
Addr_001F           equ       $001F     ; absolute address used by original code
Addr_0021           equ       $0021     ; absolute address used by original code
Addr_0025           equ       $0025     ; absolute address used by original code
Addr_0026           equ       $0026     ; absolute address used by original code
Addr_0029           equ       $0029     ; absolute address used by original code
Addr_002A           equ       $002A     ; absolute address used by original code
Addr_002B           equ       $002B     ; absolute address used by original code
Addr_002D           equ       $002D     ; absolute address used by original code
Addr_002E           equ       $002E     ; absolute address used by original code
Addr_0031           equ       $0031     ; absolute address used by original code
Addr_0033           equ       $0033     ; absolute address used by original code
Addr_0034           equ       $0034     ; absolute address used by original code
Addr_0190           equ       $0190     ; absolute address used by original code
Addr_0191           equ       $0191     ; absolute address used by original code
Addr_021F           equ       $021F     ; absolute address used by original code
Addr_027F           equ       $027F     ; absolute address used by original code
Addr_03E8           equ       $03E8     ; absolute address used by original code
Addr_07C2           equ       $07C2     ; absolute address used by original code
Addr_0E48           equ       $0E48     ; absolute address used by original code
Addr_1F1A           equ       $1F1A     ; absolute address used by original code
Addr_2000           equ       $2000     ; absolute address used by original code
Addr_270F           equ       $270F     ; absolute address used by original code
Addr_3F1A           equ       $3F1A     ; absolute address used by original code
Addr_4302           equ       $4302     ; absolute address used by original code
Addr_6618           equ       $6618     ; absolute address used by original code
Addr_9000           equ       $9000     ; absolute address used by original code
Addr_9999           equ       $9999     ; absolute address used by original code
Addr_FFD8           equ       $FFD8     ; absolute address used by original code
Addr_FFF8           equ       $FFF8     ; absolute address used by original code
Addr_FFFF           equ       $FFFF     ; absolute address used by original code
DeskMateService     equ       $0000     ; absolute address used by original code

start               jmp       >DeskMateService ; dispatch control through the selected target
Code_0016           leas      $5683,U   ; form the referenced address without reading memory
Code_001A           pshs      X         ; preserve the listed registers on the stack
Code_001C           leax      Data_2EE1,PCR ; form the referenced address without reading memory
Code_0020           lbsr      start     ; invoke the patched DeskMate service dispatcher
Data_0023           fcb       $07       ; private DeskMate service selector
Code_0024           lbsr      start     ; invoke the patched DeskMate service dispatcher
Data_0027           fcb       $06       ; private DeskMate service selector
Code_0028           leax      Data_36E3,PCR ; form the referenced address without reading memory
Code_002C           lbsr      start     ; invoke the patched DeskMate service dispatcher
Data_002F           fcb       $08       ; private DeskMate service selector
Code_0030           puls      X         ; restore the listed registers from the stack
Code_0032           lbra      Code_0159 ; continue at the distant control-flow target
Data_0035           fcc       "("                            ; embedded text or resource bytes
Data_0036           fcb       $10       ; table, bitmap, or initialized data bytes
Data_0037           fcb       $AA       ; table, bitmap, or initialized data bytes
Data_0038           fcb       $AA       ; table, bitmap, or initialized data bytes
Data_0039           fcb       $AA       ; table, bitmap, or initialized data bytes
Data_003A           fcb       $AA       ; table, bitmap, or initialized data bytes
Data_003B           fcb       $AA       ; table, bitmap, or initialized data bytes
Data_003C           fcb       $AA       ; table, bitmap, or initialized data bytes
Data_003D           fcb       $AA       ; table, bitmap, or initialized data bytes
Data_003E           fcb       $AA       ; table, bitmap, or initialized data bytes
Data_003F           fcb       $AA       ; table, bitmap, or initialized data bytes
Data_0040           fcb       $AA,$AA   ; table, bitmap, or initialized data bytes
Data_0042           fcb       $AA,$AA   ; table, bitmap, or initialized data bytes
Data_0044           fcb       $AA,$AA   ; table, bitmap, or initialized data bytes
Data_0046           fcb       $AA       ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
Data_0048           fcc       "U"                            ; embedded text or resource bytes
Data_0049           fcc       "UU"                           ; embedded text or resource bytes
Data_004B           fcc       "U"                            ; embedded text or resource bytes
Data_004C           fcc       "UU"                           ; embedded text or resource bytes
Data_004E           fcc       "U"                            ; embedded text or resource bytes
Data_004F           fcc       "U"                            ; embedded text or resource bytes
Data_0050           fcc       "U"                            ; embedded text or resource bytes
Data_0051           fcc       "UU"                           ; embedded text or resource bytes
Data_0053           fcc       "UU"                           ; embedded text or resource bytes
Data_0055           fcb       $FF       ; table, bitmap, or initialized data bytes
Data_0056           fcb       $FF       ; table, bitmap, or initialized data bytes
Data_0057           fcb       $0A,$AA   ; table, bitmap, or initialized data bytes
Data_0059           fcb       $0A,$AA   ; table, bitmap, or initialized data bytes
Data_005B           fcb       $0A       ; table, bitmap, or initialized data bytes
Data_005C           fcb       $AA       ; table, bitmap, or initialized data bytes
Data_005D           fcb       $0A       ; table, bitmap, or initialized data bytes
Data_005E           fcb       $AA       ; table, bitmap, or initialized data bytes
Data_005F           fcb       $0A       ; table, bitmap, or initialized data bytes
Data_0060           fcb       $AA,$0A   ; table, bitmap, or initialized data bytes
Data_0062           fcb       $AA,$0A   ; table, bitmap, or initialized data bytes
Data_0064           fcb       $AA       ; table, bitmap, or initialized data bytes
Data_0065           fcb       $0A       ; table, bitmap, or initialized data bytes
Data_0066           fcb       $AA       ; table, bitmap, or initialized data bytes
Data_0067           fcc       "P"                            ; embedded text or resource bytes
Data_0068           fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
Data_006A           fcb       $00       ; table, bitmap, or initialized data bytes
Data_006B           fcc       "P"                            ; embedded text or resource bytes
Data_006C           fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
Data_006E           fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
Data_0070           fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
Data_0072           fcb       $00       ; table, bitmap, or initialized data bytes
Data_0073           fcc       "P"                            ; embedded text or resource bytes
Data_0074           fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
Data_0076           fcb       $00       ; table, bitmap, or initialized data bytes
Data_0077           fcb       $AA       ; table, bitmap, or initialized data bytes
Data_0078           fcb       $00,$AA   ; table, bitmap, or initialized data bytes
Data_007A           fcb       $00       ; table, bitmap, or initialized data bytes
Data_007B           fcb       $AA,$00   ; table, bitmap, or initialized data bytes
Data_007D           fcb       $AA,$00,$AA ; table, bitmap, or initialized data bytes
Data_0080           fcb       $00,$AA   ; table, bitmap, or initialized data bytes
Data_0082           fcb       $00,$AA   ; table, bitmap, or initialized data bytes
Data_0084           fcb       $00,$AA   ; table, bitmap, or initialized data bytes
Data_0086           fcb       $00,$00   ; table, bitmap, or initialized data bytes
Data_0088           fcb       $AA,$00   ; table, bitmap, or initialized data bytes
Data_008A           fcb       $AA,$00   ; table, bitmap, or initialized data bytes
Data_008C           fcb       $AA,$00   ; table, bitmap, or initialized data bytes
Data_008E           fcb       $AA,$00   ; table, bitmap, or initialized data bytes
Data_0090           fcb       $AA,$00   ; table, bitmap, or initialized data bytes
Data_0092           fcb       $AA       ; table, bitmap, or initialized data bytes
Data_0093           fcb       $00,$AA,$00,$AA ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $00,$00,$00,$AA,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$AA,$AA ; table, bitmap, or initialized data bytes
Data_00AF           fcb       $AA,$AA,$AA,$AA,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$AA,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
Data_00BA           fcc       "UU"                           ; embedded text or resource bytes
Data_00BC           fcc       "UUU"                          ; embedded text or resource bytes
Data_00BF           fcc       "U"                            ; embedded text or resource bytes
Data_00C0           fcc       "UUUUUUU"                      ; embedded text or resource bytes
                    fcb       $00,$00,$0A,$AA,$0A,$AA ; table, bitmap, or initialized data bytes
                    fcb       $0A,$AA,$0A,$AA,$0A,$AA ; table, bitmap, or initialized data bytes
                    fcb       $0A,$AA,$0A,$AA ; table, bitmap, or initialized data bytes
                    fcc       "UUUUUUUUUUUUUU_"              ; embedded text or resource bytes
                    fcb       $FF,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
                    fcc       "PUPUP"                        ; embedded text or resource bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $00,$00,$0A,$AA,$0A,$AA ; table, bitmap, or initialized data bytes
                    fcb       $0A,$AA,$0A,$AA ; table, bitmap, or initialized data bytes
Data_00FF           fcb       $0A       ; table, bitmap, or initialized data bytes
Data_0100           fcb       $AA       ; table, bitmap, or initialized data bytes
Data_0101           fcb       $0A,$AA,$0A,$AA,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$01,$00,$01,$00,$01 ; table, bitmap, or initialized data bytes
                    fcb       $00,$01,$00,$01,$00,$01 ; table, bitmap, or initialized data bytes
                    fcb       $00,$01,$00,$01,$00,$05 ; table, bitmap, or initialized data bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
                    fcc       "UUUUU"                        ; embedded text or resource bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $00,$05,$AA,$A0,$AA,$A0 ; table, bitmap, or initialized data bytes
                    fcb       $AA,$A0,$AA,$A0,$AA,$A0 ; table, bitmap, or initialized data bytes
                    fcb       $AA,$A0,$AA,$A0,$AA,$A0 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$AA,$A0,$AA,$A0 ; table, bitmap, or initialized data bytes
                    fcb       $AA,$A0,$AA,$A0,$AA,$A0 ; table, bitmap, or initialized data bytes
                    fcb       $AA,$A0,$AA,$A0 ; table, bitmap, or initialized data bytes
Data_0147           fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
Data_0153           fcb       $00,$00   ; table, bitmap, or initialized data bytes
Data_0155           fcb       $00,$00,$00,$00 ; table, bitmap, or initialized data bytes
Code_0159           stx       Addr_000F ; save the current value in working storage
                    stu       Addr_000D ; save the current value in working storage
                    sts       DeskMateService ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $00       ; private DeskMate service selector
                    lda       #$28      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $09       ; private DeskMate service selector
                    leax      Data_0037,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $06       ; private DeskMate service selector
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "3"                            ; embedded text or resource bytes
                    lbsr      Code_0FA1 ; call the referenced helper routine
                    lbsr      Code_17CA ; call the referenced helper routine
                    leay      $13,U     ; form the referenced address without reading memory
                    sty       Addr_0011 ; save the current value in working storage
                    leax      $534B,U   ; form the referenced address without reading memory
                    stx       start     ; save the current value in working storage
                    clr       $0A,X     ; clear the selected byte or register
Code_018F           ldy       #Addr_000A ; load the value needed by the following operation
                    ldd       #Code_2020 ; load the value needed by the following operation
                    lbsr      Code_0783 ; call the referenced helper routine
                    leay      Data_0477,PCR ; form the referenced address without reading memory
                    sty       Addr_0015 ; save the current value in working storage
                    leay      $5357,U   ; form the referenced address without reading memory
                    clr       $3D,Y     ; clear the selected byte or register
                    sty       Addr_0017 ; save the current value in working storage
                    leax      $51B9,U   ; form the referenced address without reading memory
                    stx       Data_0046 ; save the current value in working storage
                    ldd       #Code_2020 ; load the value needed by the following operation
                    ldy       #Addr_0190 ; load the value needed by the following operation
                    lbsr      Code_0783 ; call the referenced helper routine
                    lda       #$8C      ; load the value needed by the following operation
                    sta       $51B9,U   ; save the current value in working storage
                    leax      $4FEC,U   ; form the referenced address without reading memory
                    stx       Data_0040 ; save the current value in working storage
                    leax      $018F,X   ; form the referenced address without reading memory
                    stx       Data_0042 ; save the current value in working storage
                    leax      $3D,X     ; form the referenced address without reading memory
                    stx       Data_0044 ; save the current value in working storage
                    leax      $4FEC,U   ; form the referenced address without reading memory
                    stx       Data_0082 ; save the current value in working storage
                    leax      -$06,X    ; form the referenced address without reading memory
                    stx       Data_0074 ; save the current value in working storage
                    leax      -$06,X    ; form the referenced address without reading memory
                    stx       Data_0076 ; save the current value in working storage
                    leax      $0090,U   ; form the referenced address without reading memory
                    stx       Data_0080 ; save the current value in working storage
                    leax      $04,X     ; form the referenced address without reading memory
                    stx       Data_0070 ; save the current value in working storage
                    stx       Data_0072 ; save the current value in working storage
                    stx       Data_007B ; save the current value in working storage
                    leax      Data_0147,PCR ; form the referenced address without reading memory
                    ldy       Data_0082 ; load the value needed by the following operation
Code_01F4           lda       #$06      ; load the value needed by the following operation
                    sta       Data_0053 ; save the current value in working storage
Code_01F8           ldd       ,X++      ; fetch the next value and advance the source pointer
                    std       ,--Y      ; save the current value in working storage
                    dec       Data_0053 ; decrement the selected counter
                    bne       Code_01F8 ; branch when the compared values differ
                    ldx       Data_0076 ; load the value needed by the following operation
                    ldd       Data_0072 ; load the value needed by the following operation
                    std       ,X        ; save the current value in working storage
                    ldx       #Addr_07C2 ; load the value needed by the following operation
                    ldd       #Data_0101 ; load the value needed by the following operation
                    sta       Addr_000B ; save the current value in working storage
                    std       Data_0092 ; save the current value in working storage
                    stx       Data_0090 ; save the current value in working storage
                    lbsr      Code_0536 ; call the referenced helper routine
                    lbsr      Code_0795 ; call the referenced helper routine
                    ldx       Addr_000F ; load the value needed by the following operation
                    lda       ,X        ; load the value needed by the following operation
Code_021C           cmpa      #$0D      ; compare against the limit and set condition flags
                    beq       Code_024A ; branch when the compared values are equal
Code_0220           cmpa      #$20      ; compare against the limit and set condition flags
                    beq       Code_024A ; branch when the compared values are equal
                    cmpa      #$30      ; compare against the limit and set condition flags
                    beq       Code_024A ; branch when the compared values are equal
                    cmpa      #$33      ; compare against the limit and set condition flags
                    beq       Code_024A ; branch when the compared values are equal
                    cmpa      #$34      ; compare against the limit and set condition flags
                    beq       Code_024A ; branch when the compared values are equal
                    ldy       start     ; load the value needed by the following operation
                    lbsr      Code_078C ; call the referenced helper routine
                    lda       #$3E      ; load the value needed by the following operation
                    ldy       Addr_0011 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "J"                            ; embedded text or resource bytes
                    tstb                ; set condition flags from the current value
                    bne       Code_024A ; branch when the compared values differ
                    lbsr      Code_057D ; call the referenced helper routine
                    lbsr      Code_0795 ; call the referenced helper routine
                    bra       Code_0258 ; continue at the selected control-flow target
Code_024A           ldx       start     ; load the value needed by the following operation
                    ldd       #Code_2020 ; load the value needed by the following operation
                    ldy       #Addr_000A ; load the value needed by the following operation
                    lbsr      Code_0783 ; call the referenced helper routine
                    clr       $0A,X     ; clear the selected byte or register
Code_0258           bsr       Code_025C ; call the referenced helper routine
                    bra       Code_0258 ; continue at the selected control-flow target
Code_025C           clra                ; clear the selected byte or register
Code_025D           sta       Data_0053 ; save the current value in working storage
                    ldb       #$80      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    bne       Code_025D ; branch when the compared values differ
                    lda       Data_0053 ; load the value needed by the following operation
                    ldb       Data_005B ; load the value needed by the following operation
                    cmpb      #$0F      ; compare against the limit and set condition flags
                    bne       Code_0275 ; branch when the compared values differ
                    cmpa      #$8C      ; compare against the limit and set condition flags
                    lbeq      Code_1A0E ; take the distant branch when values are equal
Code_0275           cmpa      #$BA      ; compare against the limit and set condition flags
                    lbeq      Code_037C ; take the distant branch when values are equal
                    cmpa      #$09      ; compare against the limit and set condition flags
                    lbeq      Code_0367 ; take the distant branch when values are equal
                    cmpa      #$20      ; compare against the limit and set condition flags
                    lbeq      Code_0367 ; take the distant branch when values are equal
                    cmpa      #$08      ; compare against the limit and set condition flags
                    lbeq      Code_036E ; take the distant branch when values are equal
                    cmpa      #$0C      ; compare against the limit and set condition flags
                    lbeq      Code_0361 ; take the distant branch when values are equal
                    cmpa      #$0A      ; compare against the limit and set condition flags
                    lbeq      Code_035B ; take the distant branch when values are equal
                    cmpa      #$19      ; compare against the limit and set condition flags
                    lbeq      Code_0440 ; take the distant branch when values are equal
                    cmpa      #$18      ; compare against the limit and set condition flags
                    lbeq      Code_040A ; take the distant branch when values are equal
                    cmpa      #$11      ; compare against the limit and set condition flags
                    lbeq      Code_0450 ; take the distant branch when values are equal
                    cmpa      #$10      ; compare against the limit and set condition flags
                    lbeq      Code_0444 ; take the distant branch when values are equal
                    clr       Data_1514,PCR ; clear the selected byte or register
                    leax      Code_0795,PCR ; form the referenced address without reading memory
                    pshs      X         ; preserve the listed registers on the stack
                    cmpa      #$05      ; compare against the limit and set condition flags
                    lbeq      Code_03BC ; take the distant branch when values are equal
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    lbeq      Code_03EB ; take the distant branch when values are equal
                    cmpa      #$AF      ; compare against the limit and set condition flags
                    lbeq      Code_03F0 ; take the distant branch when values are equal
                    suba      #$B2      ; subtract the operand from the running value
                    lbeq      Code_03C6 ; take the distant branch when values are equal
                    deca                ; decrement the selected counter
                    lbeq      Code_03D7 ; take the distant branch when values are equal
                    deca                ; decrement the selected counter
                    lbeq      Code_03DC ; take the distant branch when values are equal
                    deca                ; decrement the selected counter
                    lbeq      Code_03E1 ; take the distant branch when values are equal
                    suba      #$02      ; subtract the operand from the running value
                    lbeq      Code_03E6 ; take the distant branch when values are equal
                    deca                ; decrement the selected counter
                    lbeq      Code_03EB ; take the distant branch when values are equal
                    deca                ; decrement the selected counter
                    lbeq      Code_03FD ; take the distant branch when values are equal
                    puls      X         ; restore the listed registers from the stack
                    lbsr      Code_1A62 ; call the referenced helper routine
                    lbsr      Code_17F9 ; call the referenced helper routine
                    lda       Data_005B ; load the value needed by the following operation
                    ldb       Code_0030 ; load the value needed by the following operation
                    decb                ; decrement the selected counter
                    beq       Code_030C ; branch when the compared values are equal
                    decb                ; decrement the selected counter
                    beq       Code_033F ;0302: 27 3B          '' ; branch when the compared values are equal
                    decb                ; decrement the selected counter
                    beq       Code_030C ; branch when the compared values are equal
                    decb                ; decrement the selected counter
                    decb                ; decrement the selected counter
                    beq       Code_034E ; branch when the compared values are equal
                    rts                 ; return to the caller
Code_030C           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    tsta                ; set condition flags from the current value
                    lbeq      Code_03AE ; take the distant branch when values are equal
                    deca                ; decrement the selected counter
                    lbeq      Code_03CE ; take the distant branch when values are equal
                    deca                ; decrement the selected counter
                    lbeq      Code_03F5 ; take the distant branch when values are equal
                    deca                ; decrement the selected counter
                    lbeq      Code_0405 ; take the distant branch when values are equal
                    deca                ; decrement the selected counter
                    lbeq      Code_036E ; take the distant branch when values are equal
                    deca                ; decrement the selected counter
                    lbeq      Code_0367 ; take the distant branch when values are equal
                    deca                ; decrement the selected counter
                    lbeq      Code_037C ; take the distant branch when values are equal
                    ldb       Code_002C ; load the value needed by the following operation
                    cmpb      #$28      ; compare against the limit and set condition flags
                    bcs       Code_034B ; branch when carry reports an unsigned underflow or error
                    lbsr      Code_1BF9 ; call the referenced helper routine
                    lbra      Code_07CB ; continue at the distant control-flow target
Code_033F           cmpa      #$04      ; compare against the limit and set condition flags
                    lbeq      Code_040A ; take the distant branch when values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    lbeq      Code_0440 ; take the distant branch when values are equal
Code_034B           lbra      Code_1AD7 ; continue at the distant control-flow target
Code_034E           cmpa      #$04      ; compare against the limit and set condition flags
                    lbeq      Code_0444 ; take the distant branch when values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    lbeq      Code_0450 ; take the distant branch when values are equal
                    rts                 ; return to the caller
Code_035B           ldb       Code_0028 ; load the value needed by the following operation
                    addb      #$07      ; add the operand to the running value
                    bra       Code_036A ; continue at the selected control-flow target
Code_0361           ldb       Code_0028 ; load the value needed by the following operation
                    subb      #$07      ; subtract the operand from the running value
                    bra       Code_036A ; continue at the selected control-flow target
Code_0367           ldb       Code_0028 ; load the value needed by the following operation
                    incb                ; advance the selected counter
Code_036A           lbsr      Code_1B0F ; call the referenced helper routine
                    rts                 ; return to the caller
Code_036E           ldb       Code_0028 ; load the value needed by the following operation
                    decb                ; decrement the selected counter
                    bra       Code_036A ; continue at the selected control-flow target
Data_0373           fcb       $FC,$00,$0D ; table, bitmap, or initialized data bytes
Data_0376           fcc       "DMALT"                        ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
Code_037C           ldx       #Addr_FFD8 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "O"                            ; embedded text or resource bytes
                    leau      >Data_0373,PCR ; form the referenced address without reading memory
                    ldd       #Data_0100 ; load the value needed by the following operation
                    leax      >Data_0376,PCR ; form the referenced address without reading memory
                    ldy       #Addr_0003 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "V"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "P"                            ; embedded text or resource bytes
                    lbsr      Code_0536 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "-"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $00       ; private DeskMate service selector
                    lbsr      Code_0FA1 ; call the referenced helper routine
                    lbsr      Code_17CA ; call the referenced helper routine
                    lbra      Code_0795 ; continue at the distant control-flow target
Code_03AE           lbsr      Code_1006 ; call the referenced helper routine
                    bsr       Code_03B6 ; call the referenced helper routine
                    lbra      Code_0795 ; continue at the distant control-flow target
Code_03B6           tsta                ; set condition flags from the current value
                    lbeq      Code_0570 ; take the distant branch when values are equal
                    deca                ; decrement the selected counter
Code_03BC           lbeq      Code_06A6 ; take the distant branch when values are equal
                    deca                ; decrement the selected counter
                    lbeq      Code_0638 ; take the distant branch when values are equal
                    deca                ; decrement the selected counter
Code_03C6           lbeq      Code_158F ; take the distant branch when values are equal
                    deca                ; decrement the selected counter
                    beq       Code_03F0 ; branch when the compared values are equal
                    rts                 ; return to the caller
Code_03CE           lbsr      Code_106D ; call the referenced helper routine
                    bsr       Code_03D6 ; call the referenced helper routine
Code_03D3           lbra      Code_07CB ; continue at the distant control-flow target
Code_03D6           tsta                ; set condition flags from the current value
Code_03D7           lbeq      Code_2330 ; take the distant branch when values are equal
                    deca                ; decrement the selected counter
Code_03DC           lbeq      Code_234C ; take the distant branch when values are equal
                    deca                ; decrement the selected counter
Code_03E1           lbeq      Code_1317 ; take the distant branch when values are equal
                    deca                ; decrement the selected counter
Code_03E6           lbeq      Code_116E ; take the distant branch when values are equal
                    deca                ; decrement the selected counter
Code_03EB           lbeq      Code_1BF9 ; take the distant branch when values are equal
                    deca                ; decrement the selected counter
Code_03F0           lbeq      Code_1517 ; take the distant branch when values are equal
                    rts                 ; return to the caller
Code_03F5           lbsr      Code_1119 ; call the referenced helper routine
                    bsr       Code_03FC ; call the referenced helper routine
                    bra       Code_03D3 ; continue at the selected control-flow target
Code_03FC           tsta                ; set condition flags from the current value
Code_03FD           lbeq      Code_123E ; take the distant branch when values are equal
                    deca                ; decrement the selected counter
                    beq       Code_03F0 ; branch when the compared values are equal
                    rts                 ; return to the caller
Code_0405           lbsr      Code_1517 ; call the referenced helper routine
                    bra       Code_03D3 ; continue at the selected control-flow target
Code_040A           bsr       Code_040E ; call the referenced helper routine
                    bra       Code_0456 ; continue at the selected control-flow target
Code_040E           lda       Data_0092 ; load the value needed by the following operation
                    deca                ; decrement the selected counter
                    bgt       Code_0417 ; branch when the signed value is above the limit
                    bsr       Code_041A ; call the referenced helper routine
                    lda       #$0C      ; load the value needed by the following operation
Code_0417           sta       Data_0092 ; save the current value in working storage
                    rts                 ; return to the caller
Code_041A           ldx       Data_0090 ; load the value needed by the following operation
                    beq       Code_043D ; branch when the compared values are equal
                    leax      -$01,X    ; form the referenced address without reading memory
                    stx       Data_0090 ; save the current value in working storage
                    rts                 ; return to the caller
Code_0423           ldx       Data_0090 ; load the value needed by the following operation
                    cmpx      #Addr_270F ; compare against the limit and set condition flags
                    bcc       Code_043D ; branch when carry is clear
                    leax      $01,X     ; form the referenced address without reading memory
                    stx       Data_0090 ; save the current value in working storage
                    rts                 ; return to the caller
Code_042F           lda       Data_0092 ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    cmpa      #$0C      ; compare against the limit and set condition flags
                    bls       Code_043A ; branch when the unsigned value is at or below the limit
                    bsr       Code_0423 ; call the referenced helper routine
                    lda       #$01      ; load the value needed by the following operation
Code_043A           sta       Data_0092 ; save the current value in working storage
                    rts                 ; return to the caller
Code_043D           leas      $02,S     ; form the referenced address without reading memory
                    rts                 ; return to the caller
Code_0440           bsr       Code_042F ; call the referenced helper routine
                    bra       Code_0456 ; continue at the selected control-flow target
Code_0444           lda       #$01      ; load the value needed by the following operation
                    cmpa      Data_0092 ; compare against the limit and set condition flags
                    bne       Code_044C ; branch when the compared values differ
                    bsr       Code_041A ; call the referenced helper routine
Code_044C           sta       Data_0092 ; save the current value in working storage
                    bra       Code_0456 ; continue at the selected control-flow target
Code_0450           bsr       Code_0423 ; call the referenced helper routine
                    lda       #$01      ; load the value needed by the following operation
                    sta       Data_0092 ; save the current value in working storage
Code_0456           lbsr      Code_07B2 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_045A           ldd       Data_0070 ; load the value needed by the following operation
                    ldx       Data_0074 ; load the value needed by the following operation
                    subd      -$06,X    ; subtract the operand from the running value
                    std       Data_0084 ; save the current value in working storage
Code_0462           leax      -$06,X    ; form the referenced address without reading memory
                    ldd       ,X        ; load the value needed by the following operation
                    addd      Data_0084 ; add the operand to the running value
                    std       ,X        ; save the current value in working storage
                    ldu       $02,X     ; load the value needed by the following operation
                    cmpu      #Addr_FFFF ; compare against the limit and set condition flags
                    bne       Code_0462 ; branch when the compared values differ
                    stx       Data_0076 ; save the current value in working storage
                    std       Data_0072 ; save the current value in working storage
                    rts                 ; return to the caller
Data_0477           fcc       "CAL"                          ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_047B           fcc       "("                            ; embedded text or resource bytes
                    fcb       $04,$11,$1C,$06,$00,$FF ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
Data_0483           fcc       "("                            ; embedded text or resource bytes
                    fcb       $03,$07,$19,$04,$00,$FF ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
                    fcb       $00,$00,$00,$01 ; table, bitmap, or initialized data bytes
                    fcc       "  save?"                      ; embedded text or resource bytes
                    fcb       $00,$00,$00,$00,$0C ; table, bitmap, or initialized data bytes
                    fcc       "yes"                          ; embedded text or resource bytes
                    fcb       $00,$00,$00,$00,$13 ; table, bitmap, or initialized data bytes
                    fcc       "no"                           ; embedded text or resource bytes
                    fcb       $00,$00,$01,$00,$01 ; table, bitmap, or initialized data bytes
Data_04AA           fcc       "filename:   "                 ; embedded text or resource bytes
                    fcb       $00,$00,$00,$00,$06 ; table, bitmap, or initialized data bytes
                    fcc       "Disk drive error"             ; embedded text or resource bytes
                    fcb       $00,$00,$00,$00,$08 ; table, bitmap, or initialized data bytes
                    fcc       "Disk is full"                 ; embedded text or resource bytes
                    fcb       $00,$00,$00,$00,$08 ; table, bitmap, or initialized data bytes
                    fcc       "Device error"                 ; embedded text or resource bytes
                    fcb       $00,$00,$00,$00,$06 ; table, bitmap, or initialized data bytes
                    fcc       "Incompatible file"            ; embedded text or resource bytes
                    fcb       $00,$00,$01,$00,$01 ; table, bitmap, or initialized data bytes
                    fcc       " Save data on another"        ; embedded text or resource bytes
                    fcc       " disk!"                       ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_0524           fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "V"                            ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "b"                            ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "j"                            ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "q"                            ; embedded text or resource bytes
                    fcb       $04,$82,$04,$97,$04,$A8 ; table, bitmap, or initialized data bytes
                    fcb       $04,$B9,$04,$CF ; table, bitmap, or initialized data bytes
Code_0536           pshs      U,Y,X,D   ; preserve the listed registers on the stack
                    ldx       Data_0090 ; load the value needed by the following operation
                    ldu       Data_0092 ; load the value needed by the following operation
                    pshs      U,X       ; preserve the listed registers on the stack
                    leax      Data_0153,PCR ; form the referenced address without reading memory
                    ldu       ,X        ; load the value needed by the following operation
                    lda       $02,X     ; load the value needed by the following operation
                    os9       F$Time    ; request the named OS-9 service
                    cmpa      $02,X     ; compare against the limit and set condition flags
                    bne       Code_0552 ; branch when the compared values differ
                    cmpu      ,X        ; compare against the limit and set condition flags
                    beq       Code_0565 ; branch when the compared values are equal
Code_0552           lda       $02,X     ; load the value needed by the following operation
                    tfr       A,B       ; copy the source register into the destination register
                    lda       $01,X     ; load the value needed by the following operation
                    std       Data_0092 ; save the current value in working storage
                    ldb       ,X        ; load the value needed by the following operation
                    ldx       #Code_076C ; load the value needed by the following operation
                    abx                 ; add the operand to the running value
                    stx       Data_0090 ; save the current value in working storage
                    lbsr      Code_1226 ; call the referenced helper routine
Code_0565           puls      U,X       ; restore the listed registers from the stack
                    tsta                ; set condition flags from the current value
                    beq       Code_056E ; branch when the compared values are equal
                    stx       Data_0090 ; save the current value in working storage
                    stu       Data_0092 ; save the current value in working storage
Code_056E           puls      PC,U,Y,X,D ; restore the listed registers from the stack
Code_0570           ldy       Addr_0011 ; load the value needed by the following operation
                    lda       #$3E      ; load the value needed by the following operation
                    lbsr      Code_2CF7 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    lbne      Code_05CE ; take the distant branch when values differ
Code_057D           lda       #$01      ; load the value needed by the following operation
                    ldx       Addr_0017 ; load the value needed by the following operation
                    os9       I$Open    ; request the named OS-9 service
                    bcc       Code_058B ; branch when carry is clear
                    cmpb      #$D8      ; compare against the limit and set condition flags
                    bne       Code_05D4 ; branch when the compared values differ
                    rts                 ; return to the caller
Code_058B           ldu       Addr_000D ; load the value needed by the following operation
                    sta       Data_003A ; save the current value in working storage
                    leax      $008A,U   ; form the referenced address without reading memory
                    ldy       #Addr_0006 ; load the value needed by the following operation
                    os9       I$Read    ; request the named OS-9 service
                    bcs       Code_05D1 ; branch when carry reports an unsigned underflow or error
                    ldx       Data_008C ; load the value needed by the following operation
                    cmpx      #Addr_4302 ; compare against the limit and set condition flags
                    beq       Code_05A8 ; branch when the compared values are equal
                    lda       #$07      ; load the value needed by the following operation
                    lbra      Code_05EF ; continue at the distant control-flow target
Code_05A8           ldx       Data_0080 ; load the value needed by the following operation
                    ldy       Data_008E ; load the value needed by the following operation
                    os9       I$Read    ; request the named OS-9 service
                    bcs       Code_05D1 ; branch when carry reports an unsigned underflow or error
                    clr       Data_0155,PCR ; clear the selected byte or register
                    lbsr      Code_0536 ; call the referenced helper routine
                    ldd       Data_0082 ; load the value needed by the following operation
                    subd      Data_008A ; subtract the operand from the running value
                    tfr       D,X       ; copy the source register into the destination register
                    ldy       Data_008A ; load the value needed by the following operation
                    lda       Data_003A ; load the value needed by the following operation
                    os9       I$Read    ; request the named OS-9 service
                    bcs       Code_05D1 ; branch when carry reports an unsigned underflow or error
                    os9       I$Close   ; request the named OS-9 service
                    bcs       Code_05D1 ; branch when carry reports an unsigned underflow or error
Code_05CE           lbra      Code_045A ; continue at the distant control-flow target
Code_05D1           os9       I$Close   ; request the named OS-9 service
Code_05D4           cmpb      #$F8      ; compare against the limit and set condition flags
                    bne       Code_05ED ; branch when the compared values differ
                    ldx       Addr_0017 ; load the value needed by the following operation
                    os9       I$Delete  ; request the named OS-9 service
                    leax      Data_047B,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    lda       #$05      ; load the value needed by the following operation
                    bsr       Code_0613 ; call the referenced helper routine
                    lda       #$08      ; load the value needed by the following operation
                    bra       Code_05F7 ; continue at the selected control-flow target
Code_05ED           lda       #$04      ; load the value needed by the following operation
Code_05EF           leax      Data_047B,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
Code_05F7           bsr       Code_0613 ; call the referenced helper routine
                    ldx       #Addr_0002 ; load the value needed by the following operation
                    ldy       #Addr_0003 ; load the value needed by the following operation
                    lda       #$03      ; load the value needed by the following operation
                    bsr       Code_062E ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $16       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1C       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $19       ; private DeskMate service selector
                    lda       #$01      ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_0613           leay      Data_0524,PCR ; form the referenced address without reading memory
                    asla                ; shift left and update carry
                    ldy       A,Y       ; load the value needed by the following operation
                    lbsr      Code_077A ; call the referenced helper routine
                    tfr       Y,U       ; copy the source register into the destination register
                    ldy       ,U++      ; fetch the next value and advance the source pointer
                    ldx       ,U++      ; fetch the next value and advance the source pointer
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    tfr       U,X       ; copy the source register into the destination register
                    clra                ; clear the selected byte or register
                    bra       Code_0632 ; continue at the selected control-flow target
Code_062E           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
Code_0632           clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
Code_0637           rts                 ; return to the caller
Code_0638           ldx       Data_0070 ; load the value needed by the following operation
                    cmpx      Data_0072 ; compare against the limit and set condition flags
                    bcc       Code_0637 ; branch when carry is clear
                    lda       #$38      ; load the value needed by the following operation
                    sta       Addr_0019 ; save the current value in working storage
                    ldy       Addr_0011 ; load the value needed by the following operation
                    ldx       #DeskMateService ; load the value needed by the following operation
                    lda       #$3E      ; load the value needed by the following operation
                    lbsr      Code_2B4E ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    bne       Code_06A5 ; branch when the compared values differ
Code_0650           ldu       Addr_000D ; load the value needed by the following operation
                    ldd       Data_0082 ; load the value needed by the following operation
                    subd      Data_0076 ; subtract the operand from the running value
                    std       Data_008A ; save the current value in working storage
                    ldd       #Addr_4302 ; load the value needed by the following operation
                    std       $008C,U   ; save the current value in working storage
                    ldd       Data_0072 ; load the value needed by the following operation
                    subd      Data_0080 ; subtract the operand from the running value
                    std       Data_008E ; save the current value in working storage
                    lda       #$02      ; load the value needed by the following operation
                    ldx       Addr_0017 ; load the value needed by the following operation
                    os9       I$Open    ; request the named OS-9 service
                    bcc       Code_0681 ; branch when carry is clear
                    cmpb      #$D8      ; compare against the limit and set condition flags
                    lbne      Code_05D4 ; take the distant branch when values differ
                    ldb       #$1B      ; load the value needed by the following operation
                    lda       #$02      ; load the value needed by the following operation
                    ldx       Addr_0017 ; load the value needed by the following operation
                    os9       I$Create  ; request the named OS-9 service
                    lbcs      Code_05D4 ; take the distant branch when carry reports an error
Code_0681           sta       Data_003A ; save the current value in working storage
                    leax      $008A,U   ; form the referenced address without reading memory
                    ldy       Data_008E ; load the value needed by the following operation
                    leay      $06,Y     ; form the referenced address without reading memory
                    lda       Data_003A ; load the value needed by the following operation
                    os9       I$Write   ; request the named OS-9 service
                    bcs       Code_06A0 ; branch when carry reports an unsigned underflow or error
                    ldx       Data_0076 ; load the value needed by the following operation
                    ldy       Data_008A ; load the value needed by the following operation
                    os9       I$Write   ; request the named OS-9 service
                    bcs       Code_06A0 ; branch when carry reports an unsigned underflow or error
                    os9       I$Close   ; request the named OS-9 service
Code_06A0           lbcs      Code_05D1 ; take the distant branch when carry reports an error
                    clra                ; clear the selected byte or register
Code_06A5           rts                 ; return to the caller
Code_06A6           ldx       Data_0070 ; load the value needed by the following operation
                    cmpx      Data_0072 ; compare against the limit and set condition flags
                    lbcc      Code_0771 ; take the distant branch when carry is clear
                    leax      Data_0483,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    lda       #$00      ; load the value needed by the following operation
                    lbsr      Code_0613 ; call the referenced helper routine
                    lda       #$01      ; load the value needed by the following operation
                    lbsr      Code_0613 ; call the referenced helper routine
                    lda       #$02      ; load the value needed by the following operation
                    lbsr      Code_0613 ; call the referenced helper routine
                    ldy       start     ; load the value needed by the following operation
                    lda       ,Y        ; load the value needed by the following operation
                    cmpa      #$20      ; compare against the limit and set condition flags
                    beq       Code_06DB ; branch when the compared values are equal
                    lda       #$03      ; load the value needed by the following operation
                    lbsr      Code_0613 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    ldx       start     ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
Code_06DB           clr       Addr_001B ; clear the selected byte or register
Code_06DD           leax      Data_14B8,PCR ; form the referenced address without reading memory
                    leay      Data_14DB,PCR ; form the referenced address without reading memory
                    tst       Addr_001B ; set condition flags from the current value
                    beq       Code_06EB ; branch when the compared values are equal
                    exg       X,Y       ; exchange the two register values
Code_06EB           ldd       #Addr_3F1A ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    tfr       Y,X       ; copy the source register into the destination register
                    ldb       #$28      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
Code_06FA           ldb       #$80      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    sta       Code_001A ; save the current value in working storage
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    beq       Code_0750 ; branch when the compared values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    bne       Code_070B ; branch when the compared values differ
Code_070A           rts                 ; return to the caller
Code_070B           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "E"                            ; embedded text or resource bytes
                    cmpb      #$01      ; compare against the limit and set condition flags
                    bne       Code_071B ; branch when the compared values differ
                    cmpy      #Data_00FF ; compare against the limit and set condition flags
                    beq       Code_070A ; branch when the compared values are equal
                    bra       Code_0750 ; continue at the selected control-flow target
Code_071B           cmpy      #Data_00FF ; compare against the limit and set condition flags
                    beq       Code_0743 ; branch when the compared values are equal
                    cmpx      #Addr_0009 ; compare against the limit and set condition flags
                    bcs       Code_06FA ; branch when carry reports an unsigned underflow or error
                    cmpx      #Addr_000E ; compare against the limit and set condition flags
                    bls       Code_073D ; branch when the unsigned value is at or below the limit
                    cmpx      #Addr_0010 ; compare against the limit and set condition flags
                    bcs       Code_06FA ; branch when carry reports an unsigned underflow or error
                    cmpx      #Addr_0014 ; compare against the limit and set condition flags
                    bhi       Code_06FA ; branch when the unsigned value is above the limit
Code_0735           tst       Addr_001B ; set condition flags from the current value
                    bne       Code_06FA ; branch when the compared values differ
                    com       Addr_001B ; invert every bit in the selected value
                    bra       Code_06DD ; continue at the selected control-flow target
Code_073D           tst       Addr_001B ; set condition flags from the current value
                    beq       Code_06FA ; branch when the compared values are equal
                    bra       Code_06DB ; continue at the selected control-flow target
Code_0743           lda       Code_001A ; load the value needed by the following operation
                    cmpa      #$09      ; compare against the limit and set condition flags
                    beq       Code_0735 ; branch when the compared values are equal
                    cmpa      #$08      ; compare against the limit and set condition flags
                    beq       Code_073D ; branch when the compared values are equal
                    lbra      Code_06FA ; continue at the distant control-flow target
Code_0750           tst       Addr_001B ; set condition flags from the current value
                    bne       Code_0771 ; branch when the compared values differ
                    ldy       Addr_0011 ; load the value needed by the following operation
                    lda       [,Y]      ; load the value needed by the following operation
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bne       Code_076C ; branch when the compared values differ
                    clr       Addr_0019 ; clear the selected byte or register
                    leax      Data_04AA,PCR ; form the referenced address without reading memory
                    lda       #$3E      ; load the value needed by the following operation
                    lbsr      Code_2B4E ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_076C ; branch when the compared values are equal
                    rts                 ; return to the caller
Code_076C           lbsr      Code_0650 ; call the referenced helper routine
                    bne       Code_070A ; branch when the compared values differ
Code_0771           ldu       Addr_000D ; load the value needed by the following operation
                    lds       DeskMateService ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "W"                            ; embedded text or resource bytes
Code_077A           leax      Data_0035,PCR ; form the referenced address without reading memory
                    tfr       X,D       ; copy the source register into the destination register
                    leay      D,Y       ; form the referenced address without reading memory
                    rts                 ; return to the caller
Code_0783           std       ,X++      ; store the value and advance the destination pointer
                    leay      -$02,Y    ; form the referenced address without reading memory
                    bne       Code_0783 ; branch when the compared values differ
                    rts                 ; return to the caller
Code_078A           sta       ,Y+       ; store the value and advance the destination pointer
Code_078C           lda       ,X+       ; fetch the next value and advance the source pointer
                    beq       Code_0794 ; branch when the compared values are equal
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    bne       Code_078A ; branch when the compared values differ
Code_0794           rts                 ; return to the caller
Code_0795           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    lbsr      Code_085F ; call the referenced helper routine
                    lbsr      Code_0BA4 ; call the referenced helper routine
                    lbsr      Code_0E22 ; call the referenced helper routine
                    lbsr      Code_0BDA ; call the referenced helper routine
                    lbsr      Code_0AA8 ; call the referenced helper routine
                    lbsr      Code_0A0B ; call the referenced helper routine
                    clr       Data_0039 ; clear the selected byte or register
                    lbsr      Code_0D87 ; call the referenced helper routine
                    bra       Code_07DE ; continue at the selected control-flow target
Code_07B2           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    lbsr      Code_0900 ; call the referenced helper routine
                    lbsr      Code_0E22 ; call the referenced helper routine
                    lda       #$01      ; load the value needed by the following operation
                    sta       Data_0093 ; save the current value in working storage
                    lbsr      Code_0BDA ; call the referenced helper routine
                    lbsr      Code_0AA8 ; call the referenced helper routine
                    lbsr      Code_0D87 ; call the referenced helper routine
                    bra       Code_07DE ; continue at the selected control-flow target
Code_07CB           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    lbsr      Code_085F ; call the referenced helper routine
                    lbsr      Code_0E22 ; call the referenced helper routine
                    lbsr      Code_0BDA ; call the referenced helper routine
                    lbsr      Code_0AA8 ; call the referenced helper routine
                    lbsr      Code_0D87 ; call the referenced helper routine
Code_07DE           lda       #$01      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $16       ; private DeskMate service selector
                    fcc       "9"                            ; embedded text or resource bytes
Data_07E9           fcb       $80,$80,$80,$80,$80,$80 ; table, bitmap, or initialized data bytes
                    fcb       $80,$80   ; table, bitmap, or initialized data bytes
Data_07F1           fcb       $80,$80,$80,$8F,$81,$81 ; table, bitmap, or initialized data bytes
                    fcb       $81,$81,$81,$81,$81,$81 ; table, bitmap, or initialized data bytes
                    fcb       $81,$81,$81,$81,$81,$81 ; table, bitmap, or initialized data bytes
                    fcb       $81,$81,$81,$81,$81,$81 ; table, bitmap, or initialized data bytes
                    fcb       $81,$81,$81,$81,$81,$81 ; table, bitmap, or initialized data bytes
                    fcb       $81,$81   ; table, bitmap, or initialized data bytes
Data_0811           fcb       $82,$80,$80,$80 ; table, bitmap, or initialized data bytes
Data_0815           fcb       $80,$80,$80,$8F ; table, bitmap, or initialized data bytes
Data_0819           fcc       "                     "        ; embedded text or resource bytes
                    fcc       "       "                      ; embedded text or resource bytes
                    fcb       $82,$80,$80,$80 ; table, bitmap, or initialized data bytes
Data_0839           fcb       $87,$87,$87,$90,$88,$88 ; table, bitmap, or initialized data bytes
                    fcb       $88,$88,$88,$88,$88,$88 ; table, bitmap, or initialized data bytes
                    fcb       $88,$88,$88,$88,$88,$88 ; table, bitmap, or initialized data bytes
                    fcb       $88,$88,$88,$88,$88,$88 ; table, bitmap, or initialized data bytes
                    fcb       $88,$88,$88,$88,$88,$88 ; table, bitmap, or initialized data bytes
                    fcb       $88,$88,$89,$87,$87,$87 ; table, bitmap, or initialized data bytes
Data_085D           fcb       $01,$00   ; table, bitmap, or initialized data bytes
Code_085F           lbsr      Code_0900 ; call the referenced helper routine
                    lbsr      Code_0A5E ; call the referenced helper routine
                    leax      >Data_0815,PCR ; form the referenced address without reading memory
                    ldy       #Code_0024 ; load the value needed by the following operation
                    ldb       #$02      ; load the value needed by the following operation
                    lda       #$04      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $22       ; private DeskMate service selector
                    lda       #$04      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    lda       #$05      ; load the value needed by the following operation
                    sta       ,-S       ; save the current value in working storage
Code_0884           ldb       #$02      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $22       ; private DeskMate service selector
                    inc       ,S        ; advance the selected counter
                    lda       ,S        ; load the value needed by the following operation
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    bls       Code_0884 ; branch when the unsigned value is at or below the limit
                    leas      $01,S     ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Data_089E           fcb       $08,$09,$06,$06,$04,$05 ; table, bitmap, or initialized data bytes
                    fcb       $05,$07,$0A,$08,$09,$09 ; table, bitmap, or initialized data bytes
Data_08AA           fcc       "JANUARY"                      ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "FEBRUARY"                     ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "MARCH"                        ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "APRIL"                        ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "MAY"                          ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "JUNE"                         ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "JULY"                         ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "AUGUST"                       ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "SEPTEMBER"                    ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "OCTOBER"                      ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "NOVEMBER"                     ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "DECEMBER"                     ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_0900           clrb                ; clear the selected byte or register
Code_0901           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    tsta                ; set condition flags from the current value
                    bne       Code_0901 ; branch when the compared values differ
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "E"                            ; embedded text or resource bytes
                    lda       #$06      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    ldb       #$02      ; load the value needed by the following operation
                    lda       #$01      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    leax      Data_0839,PCR ; form the referenced address without reading memory
                    ldy       #Code_0024 ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $22       ; private DeskMate service selector
                    ldb       #$02      ; load the value needed by the following operation
                    lda       #$02      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    lda       #$06      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    leax      Data_07F1,PCR ; form the referenced address without reading memory
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $22       ; private DeskMate service selector
                    ldb       #$0B      ; load the value needed by the following operation
                    lda       #$02      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    lda       #$02      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    leax      Data_0819,PCR ; form the referenced address without reading memory
                    ldy       #Addr_0012 ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $22       ; private DeskMate service selector
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    leax      Data_089E,PCR ; form the referenced address without reading memory
                    lda       Data_0092 ; load the value needed by the following operation
                    deca                ; decrement the selected counter
                    cmpa      #$0B      ; compare against the limit and set condition flags
                    bls       Code_096B ; branch when the unsigned value is at or below the limit
                    lda       #$0B      ; load the value needed by the following operation
Code_096B           ldb       A,X       ; load the value needed by the following operation
                    stb       Data_0035 ; save the current value in working storage
                    clrb                ; clear the selected byte or register
                    bra       Code_0974 ; continue at the selected control-flow target
Code_0972           addb      A,X       ; add the operand to the running value
Code_0974           deca                ; decrement the selected counter
                    bge       Code_0972 ; branch when the signed value is at least the limit
                    leax      Data_08AA,PCR ; form the referenced address without reading memory
                    abx                 ; add the operand to the running value
                    pshs      X         ; preserve the listed registers on the stack
                    clra                ; clear the selected byte or register
                    ldx       Data_0090 ; load the value needed by the following operation
                    bra       Code_0988 ; continue at the selected control-flow target
Code_0983           inca                ; advance the selected counter
                    leax      $FC18,X   ; form the referenced address without reading memory
Code_0988           cmpx      #Addr_03E8 ; compare against the limit and set condition flags
                    bcc       Code_0983 ; branch when carry is clear
                    sta       Addr_0031 ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    bra       Code_0996 ; continue at the selected control-flow target
Code_0992           inca                ; advance the selected counter
                    leax      -$64,X    ; form the referenced address without reading memory
Code_0996           cmpx      #Data_0064 ; compare against the limit and set condition flags
                    bcc       Code_0992 ; branch when carry is clear
                    sta       Code_0032 ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    bra       Code_09A3 ; continue at the selected control-flow target
Code_09A0           inca                ; advance the selected counter
                    leax      -$0A,X    ; form the referenced address without reading memory
Code_09A3           cmpx      #Addr_000A ; compare against the limit and set condition flags
                    bcc       Code_09A0 ; branch when carry is clear
                    sta       Addr_0033 ; save the current value in working storage
                    tfr       X,D       ; copy the source register into the destination register
                    stb       Addr_0034 ; save the current value in working storage
                    lda       #$02      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    ldb       Data_0035 ; load the value needed by the following operation
                    addb      #$06      ; add the operand to the running value
                    lsrb                ; shift right and expose the low bit through carry
                    addb      #$0C      ; add the operand to the running value
                    lda       #$02      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    lda       #$20      ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $02       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $02       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $02       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $02       ; private DeskMate service selector
                    lda       Addr_0031 ; load the value needed by the following operation
                    adda      #$30      ; add the operand to the running value
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $02       ; private DeskMate service selector
                    lda       Code_0032 ; load the value needed by the following operation
                    adda      #$30      ; add the operand to the running value
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $02       ; private DeskMate service selector
                    lda       Addr_0033 ; load the value needed by the following operation
                    adda      #$30      ; add the operand to the running value
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $02       ; private DeskMate service selector
                    lda       Addr_0034 ; load the value needed by the following operation
                    adda      #$30      ; add the operand to the running value
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $02       ; private DeskMate service selector
                    puls      X         ; restore the listed registers from the stack
                    ldb       Data_0035 ; load the value needed by the following operation
                    addb      #$06      ; add the operand to the running value
                    lsrb                ; shift right and expose the low bit through carry
                    negb                ; form the two's-complement negative value
                    addb      #$14      ; add the operand to the running value
                    lda       #$02      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_0A0B           nop       ;         leave processor state unchanged
                    ldy       #Addr_000A ; load the value needed by the following operation
                    ldb       #$02      ; load the value needed by the following operation
                    lda       #$0F      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    lda       #$02      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    leax      Data_07E9,PCR ; form the referenced address without reading memory
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $22       ; private DeskMate service selector
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    ldb       #$02      ; load the value needed by the following operation
                    lda       #$10      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $22       ; private DeskMate service selector
                    rts                 ; return to the caller
Data_0A3A           fcb       $05       ; table, bitmap, or initialized data bytes
                    fcc       "SUN  MON  TUE  WED  T"        ; embedded text or resource bytes
                    fcc       "HU  FRI  SAT"                 ; embedded text or resource bytes
                    fcb       $05,$00   ; table, bitmap, or initialized data bytes
Code_0A5E           lda       #$06      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    leax      Data_07F1,PCR ; form the referenced address without reading memory
                    ldy       #Addr_0004 ; load the value needed by the following operation
                    ldb       #$02      ; load the value needed by the following operation
                    lda       #$03      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $22       ; private DeskMate service selector
                    ldb       #$06      ; load the value needed by the following operation
                    lda       #$03      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      Data_085D,PCR ; form the referenced address without reading memory
                    clra                ; clear the selected byte or register
                    ldb       #$40      ; load the value needed by the following operation
                    leax      >Data_0A3A,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "6"                            ; embedded text or resource bytes
                    leax      Data_0811,PCR ; form the referenced address without reading memory
                    ldy       #Addr_0004 ; load the value needed by the following operation
                    ldb       #$22      ; load the value needed by the following operation
                    lda       #$03      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $22       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_0AA8           clr       Data_0038 ; clear the selected byte or register
                    clr       Code_0024 ; clear the selected byte or register
                    bra       Code_0ADD ; continue at the selected control-flow target
Code_0AAE           cmpa      Addr_0021 ; compare against the limit and set condition flags
                    blt       Code_0AC2 ; branch when the signed value is below the limit
                    lda       Data_0038 ; load the value needed by the following operation
                    adda      #$01      ; add the operand to the running value
                    daa                 ; adjust the accumulator to packed decimal
                    ldb       Data_0036 ; load the value needed by the following operation
                    addb      Addr_0021 ; add the operand to the running value
                    cmpb      Code_0024 ; compare against the limit and set condition flags
                    bgt       Code_0AC0 ; branch when the signed value is above the limit
                    clra                ; clear the selected byte or register
Code_0AC0           sta       Data_0038 ; save the current value in working storage
Code_0AC2           clrb                ; clear the selected byte or register
                    lda       Code_0024 ; load the value needed by the following operation
                    cmpa      Code_0028 ; compare against the limit and set condition flags
                    bne       Code_0ACB ; branch when the compared values differ
                    ldb       #$40      ; load the value needed by the following operation
Code_0ACB           lda       Data_0093 ; load the value needed by the following operation
                    beq       Code_0ADA ; branch when the compared values are equal
                    clrb                ; clear the selected byte or register
                    cmpa      Data_0038 ; compare against the limit and set condition flags
                    bne       Code_0ADA ; branch when the compared values differ
                    lda       Code_0024 ; load the value needed by the following operation
                    sta       Code_0028 ; save the current value in working storage
                    ldb       #$40      ; load the value needed by the following operation
Code_0ADA           lbsr      Code_0B28 ; call the referenced helper routine
Code_0ADD           inc       Code_0024 ; advance the selected counter
                    lda       Code_0024 ; load the value needed by the following operation
                    cmpa      #$25      ; compare against the limit and set condition flags
                    ble       Code_0AAE ; branch when the signed value is at or below the limit
                    ldd       #DeskMateService ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    ldd       #DeskMateService ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    lda       Data_0093 ; load the value needed by the following operation
                    sta       Data_0038 ; save the current value in working storage
                    rts                 ; return to the caller
Data_0AF8           fcb       $07,$0B,$0F,$13,$17,$1B ; table, bitmap, or initialized data bytes
                    fcb       $1F       ; table, bitmap, or initialized data bytes
Data_0AFF           fcb       $00,$05,$05,$06,$02,$08 ; table, bitmap, or initialized data bytes
                    fcb       $07       ; table, bitmap, or initialized data bytes
Data_0B06           fcb       $09,$04,$0B,$01,$0D ; table, bitmap, or initialized data bytes
Code_0B0B           clrb                ; clear the selected byte or register
                    bra       Code_0B12 ; continue at the selected control-flow target
Code_0B0E           addb      #$10      ; add the operand to the running value
                    suba      #$0A      ; subtract the operand from the running value
Code_0B12           cmpa      #$0A      ; compare against the limit and set condition flags
                    bcc       Code_0B0E ; branch when carry is clear
                    stb       ,-S       ; save the current value in working storage
                    ora       ,S+       ; set the selected flag bits
                    rts                 ; return to the caller
Code_0B1B           pshs      B         ; preserve the listed registers on the stack
                    lda       Code_0024 ; load the value needed by the following operation
                    suba      Addr_0021 ; subtract the operand from the running value
                    inca                ; advance the selected counter
                    bsr       Code_0B0B ; call the referenced helper routine
                    sta       Data_0038 ; save the current value in working storage
                    puls      B         ; restore the listed registers from the stack
Code_0B28           pshs      B         ; preserve the listed registers on the stack
                    clrb                ; clear the selected byte or register
                    lda       Code_0024 ; load the value needed by the following operation
                    deca                ; decrement the selected counter
                    bra       Code_0B33 ; continue at the selected control-flow target
Code_0B30           incb                ; advance the selected counter
                    suba      #$07      ; subtract the operand from the running value
Code_0B33           cmpa      #$07      ; compare against the limit and set condition flags
                    bcc       Code_0B30 ; branch when carry is clear
                    leax      >Data_0AF8,PCR ; form the referenced address without reading memory
                    lda       A,X       ; load the value needed by the following operation
                    sta       Addr_0025 ; save the current value in working storage
                    leax      >Data_0AFF,PCR ; form the referenced address without reading memory
                    aslb                ; shift left and update carry
                    ldd       B,X       ; load the value needed by the following operation
                    sta       Data_0027 ; save the current value in working storage
                    stb       Addr_0026 ; save the current value in working storage
                    ldb       Addr_0025 ; load the value needed by the following operation
                    lda       Addr_0026 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    lda       Data_0027 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    lda       Data_0038 ; load the value needed by the following operation
                    lsra                ; shift right and expose the low bit through carry
                    lsra                ; shift right and expose the low bit through carry
                    lsra                ; shift right and expose the low bit through carry
                    lsra                ; shift right and expose the low bit through carry
                    bne       Code_0B62 ; branch when the compared values differ
                    suba      #$10      ; subtract the operand from the running value
Code_0B62           adda      #$30      ; add the operand to the running value
                    ldb       ,S        ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $02       ; private DeskMate service selector
                    lda       Data_0038 ; load the value needed by the following operation
                    bne       Code_0B72 ; branch when the compared values differ
                    lda       #$20      ; load the value needed by the following operation
                    bra       Code_0B76 ; continue at the selected control-flow target
Code_0B72           anda      #$0F      ; mask off unwanted bits
                    adda      #$30      ; add the operand to the running value
Code_0B76           ldb       ,S+       ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $02       ; private DeskMate service selector
                    ldu       Data_0076 ; load the value needed by the following operation
Code_0B7E           pulu      Y,X,D     ; restore the listed registers from the stack
                    cmpu      Data_0074 ; compare against the limit and set condition flags
                    bhi       Code_0BA0 ; branch when the unsigned value is above the limit
                    cmpx      Data_0090 ; compare against the limit and set condition flags
                    bne       Code_0B7E ; branch when the compared values differ
                    tfr       Y,D       ; copy the source register into the destination register
                    cmpb      Data_0038 ; compare against the limit and set condition flags
                    bne       Code_0B7E ; branch when the compared values differ
                    cmpa      Data_0092 ; compare against the limit and set condition flags
                    bne       Code_0B7E ; branch when the compared values differ
                    lda       #$8E      ; load the value needed by the following operation
Code_0B95           clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $02       ; private DeskMate service selector
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_0BA0           lda       #$8D      ; load the value needed by the following operation
                    bra       Code_0B95 ; continue at the selected control-flow target
Code_0BA4           leax      Data_0819,PCR ; form the referenced address without reading memory
                    ldy       #Addr_000B ; load the value needed by the following operation
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    lda       #$0F      ; load the value needed by the following operation
                    sta       Data_0053 ; save the current value in working storage
Code_0BB5           ldb       #$02      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $22       ; private DeskMate service selector
                    inc       Data_0053 ; advance the selected counter
                    lda       Data_0053 ; load the value needed by the following operation
                    cmpa      #$17      ; compare against the limit and set condition flags
                    bls       Code_0BB5 ; branch when the unsigned value is at or below the limit
                    ldb       #$0F      ; load the value needed by the following operation
                    lda       #$17      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    ldy       #Addr_0015 ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
                    lbsr      start     ;0BD5: 17 F4 3B       '.. ; call the referenced helper routine
                    fcb       $22       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_0BDA           ldx       #DeskMateService ; load the value needed by the following operation
                    ldy       #Data_0074 ; load the value needed by the following operation
                    ldu       #Addr_027F ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
Code_0BE5           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $11       ; private DeskMate service selector
                    leay      $01,Y     ; form the referenced address without reading memory
                    cmpy      #Data_0077 ; compare against the limit and set condition flags
                    bls       Code_0BE5 ; branch when the unsigned value is at or below the limit
                    ldx       #Data_0060 ; load the value needed by the following operation
                    ldy       #Code_0032 ; load the value needed by the following operation
                    ldu       #Addr_021F ; load the value needed by the following operation
                    ldb       #$55      ; load the value needed by the following operation
Code_0BFD           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $11       ; private DeskMate service selector
                    leay      $0D,Y     ; form the referenced address without reading memory
                    cmpy      #Data_0073 ; compare against the limit and set condition flags
                    bls       Code_0BFD ; branch when the unsigned value is at or below the limit
                    ldy       #Addr_0026 ; load the value needed by the following operation
                    ldu       #Data_0073 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $12       ; private DeskMate service selector
                    leax      $3E,X     ; form the referenced address without reading memory
Code_0C17           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $12       ; private DeskMate service selector
                    leax      $40,X     ; form the referenced address without reading memory
                    cmpx      #Code_0220 ; compare against the limit and set condition flags
                    bls       Code_0C17 ; branch when the unsigned value is at or below the limit
                    ldb       #$AA      ; load the value needed by the following operation
                    ldx       #Data_00C0 ; load the value needed by the following operation
                    ldy       #Data_007A ; load the value needed by the following operation
                    ldu       #Data_00BA ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $12       ; private DeskMate service selector
                    ldx       #Code_0020 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $12       ; private DeskMate service selector
                    ldy       #Data_00BA ; load the value needed by the following operation
                    ldu       #Data_00BF ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $11       ; private DeskMate service selector
                    rts                 ; return to the caller
Data_0C46           fcb       $85,$80,$80,$84,$85,$84 ; table, bitmap, or initialized data bytes
                    fcb       $85,$84,$85,$84,$85,$84 ; table, bitmap, or initialized data bytes
                    fcb       $85,$84,$85,$84,$85,$80 ; table, bitmap, or initialized data bytes
                    fcb       $80,$84   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $85,$84   ; table, bitmap, or initialized data bytes
                    fcc       "  "                           ; embedded text or resource bytes
                    fcb       $85,$84   ; table, bitmap, or initialized data bytes
                    fcc       "  "                           ; embedded text or resource bytes
                    fcb       $85,$84   ; table, bitmap, or initialized data bytes
                    fcc       "  "                           ; embedded text or resource bytes
                    fcb       $85,$84   ; table, bitmap, or initialized data bytes
                    fcc       "  "                           ; embedded text or resource bytes
                    fcb       $85,$84   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $85,$80,$80,$84 ; table, bitmap, or initialized data bytes
                    fcc       "  "                           ; embedded text or resource bytes
                    fcb       $85,$84,$85,$80,$80,$84 ; table, bitmap, or initialized data bytes
                    fcb       $85,$84   ; table, bitmap, or initialized data bytes
                    fcc       "  "                           ; embedded text or resource bytes
                    fcb       $85,$80,$80,$84,$85,$80 ; table, bitmap, or initialized data bytes
                    fcb       $80,$84   ; table, bitmap, or initialized data bytes
                    fcc       "  "                           ; embedded text or resource bytes
                    fcb       $85,$84   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $85,$80,$84 ; table, bitmap, or initialized data bytes
                    fcc       "  "                           ; embedded text or resource bytes
                    fcb       $85,$84,$85,$80,$80,$84 ; table, bitmap, or initialized data bytes
                    fcb       $85,$84,$85,$84,$85,$84 ; table, bitmap, or initialized data bytes
                    fcb       $85,$84,$85,$80,$80,$84 ; table, bitmap, or initialized data bytes
                    fcc       "  "                           ; embedded text or resource bytes
                    fcb       $85,$84   ; table, bitmap, or initialized data bytes
                    fcc       "  "                           ; embedded text or resource bytes
                    fcb       $85,$84,$85,$80,$80,$84 ; table, bitmap, or initialized data bytes
                    fcb       $85,$84   ; table, bitmap, or initialized data bytes
                    fcc       "  "                           ; embedded text or resource bytes
                    fcb       $85,$80,$80,$84 ; table, bitmap, or initialized data bytes
                    fcc       "  "                           ; embedded text or resource bytes
                    fcb       $85,$84,$85,$80,$80,$84 ; table, bitmap, or initialized data bytes
                    fcb       $85,$80,$80,$84,$85,$84 ; table, bitmap, or initialized data bytes
                    fcc       "  "                           ; embedded text or resource bytes
                    fcb       $85,$80,$80,$84,$85,$84 ; table, bitmap, or initialized data bytes
                    fcb       $85,$84,$85,$80,$80,$84 ; table, bitmap, or initialized data bytes
                    fcb       $85,$80,$80,$84 ; table, bitmap, or initialized data bytes
                    fcc       "  "                           ; embedded text or resource bytes
                    fcb       $85,$84   ; table, bitmap, or initialized data bytes
                    fcc       "  "                           ; embedded text or resource bytes
                    fcb       $85,$84   ; table, bitmap, or initialized data bytes
                    fcc       "  "                           ; embedded text or resource bytes
                    fcb       $85,$84   ; table, bitmap, or initialized data bytes
                    fcc       "  "                           ; embedded text or resource bytes
                    fcb       $85,$84,$85,$80,$80,$84 ; table, bitmap, or initialized data bytes
                    fcb       $85,$84,$85,$84,$85,$80 ; table, bitmap, or initialized data bytes
                    fcb       $80,$84,$85,$84,$85,$84 ; table, bitmap, or initialized data bytes
                    fcb       $85,$80,$80,$84,$85,$80 ; table, bitmap, or initialized data bytes
                    fcb       $80,$84,$85,$84,$85,$84 ; table, bitmap, or initialized data bytes
                    fcb       $85,$80,$80,$84 ; table, bitmap, or initialized data bytes
                    fcc       "  "                           ; embedded text or resource bytes
                    fcb       $85,$84   ; table, bitmap, or initialized data bytes
                    fcc       "  "                           ; embedded text or resource bytes
                    fcb       $85,$84   ; table, bitmap, or initialized data bytes
                    fcc       "                    "         ; embedded text or resource bytes
Data_0D22           fcb       $84,$07,$05 ; table, bitmap, or initialized data bytes
                    fcc       "SUNDAY"                       ; embedded text or resource bytes
                    fcb       $07,$05,$00,$84,$07,$05 ; table, bitmap, or initialized data bytes
                    fcc       "MONDAY"                       ; embedded text or resource bytes
                    fcb       $07,$05,$00,$84,$07 ; table, bitmap, or initialized data bytes
                    fcc       "TUESDAY"                      ; embedded text or resource bytes
                    fcb       $07,$02,$00,$84 ; table, bitmap, or initialized data bytes
                    fcc       "WEDNESDAY"                    ; embedded text or resource bytes
                    fcb       $00,$00,$84,$04 ; table, bitmap, or initialized data bytes
                    fcc       "THURSDAY"                     ; embedded text or resource bytes
                    fcb       $04,$00,$84,$07,$05 ; table, bitmap, or initialized data bytes
                    fcc       "FRIDAY"                       ; embedded text or resource bytes
                    fcb       $07,$06,$00,$84,$04 ; table, bitmap, or initialized data bytes
                    fcc       "SATURDAY"                     ; embedded text or resource bytes
                    fcb       $04,$00   ; table, bitmap, or initialized data bytes
Code_0D76           lda       Addr_0021 ; load the value needed by the following operation
                    deca                ; decrement the selected counter
                    adda      Data_0093 ; add the operand to the running value
                    daa                 ; adjust the accumulator to packed decimal
                    bra       Code_0D81 ; continue at the selected control-flow target
Code_0D7E           adda      #$93      ; add the operand to the running value
                    daa                 ; adjust the accumulator to packed decimal
Code_0D81           cmpa      #$07      ; compare against the limit and set condition flags
                    bhi       Code_0D7E ; branch when the unsigned value is above the limit
                    deca                ; decrement the selected counter
                    rts                 ; return to the caller
Code_0D87           lda       Data_0038 ; load the value needed by the following operation
                    sta       Data_0093 ; save the current value in working storage
                    lbsr      Code_21DB ; call the referenced helper routine
                    lbsr      Code_1BE2 ; call the referenced helper routine
                    lda       Data_0038 ; load the value needed by the following operation
                    beq       Code_0DB3 ; branch when the compared values are equal
                    ldb       #$02      ; load the value needed by the following operation
                    lda       #$0F      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    lda       #$05      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    leax      Data_0D22,PCR ; form the referenced address without reading memory
                    bsr       Code_0D76 ; call the referenced helper routine
                    ldb       #$0C      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    abx                 ; add the operand to the running value
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
Code_0DB3           lda       Data_0038 ; load the value needed by the following operation
                    cmpa      Data_0039 ; compare against the limit and set condition flags
                    beq       Code_0E1C ; branch when the compared values are equal
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    leax      Data_0C46,PCR ; form the referenced address without reading memory
                    lda       Data_0038 ; load the value needed by the following operation
                    lsra                ; shift right and expose the low bit through carry
                    lsra                ; shift right and expose the low bit through carry
                    lsra                ; shift right and expose the low bit through carry
                    lsra                ; shift right and expose the low bit through carry
                    bne       Code_0DCC ; branch when the compared values differ
                    lda       #$0A      ; load the value needed by the following operation
Code_0DCC           ldb       #$14      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    abx                 ; add the operand to the running value
                    ldy       #Addr_0004 ; load the value needed by the following operation
                    lda       #$12      ; load the value needed by the following operation
                    sta       ,-S       ; save the current value in working storage
Code_0DD8           ldb       #$03      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $22       ; private DeskMate service selector
                    leax      $04,X     ; form the referenced address without reading memory
                    inc       ,S        ; advance the selected counter
                    lda       ,S        ; load the value needed by the following operation
                    cmpa      #$16      ; compare against the limit and set condition flags
                    bls       Code_0DD8 ; branch when the unsigned value is at or below the limit
                    leax      Data_0C46,PCR ; form the referenced address without reading memory
                    lda       Data_0038 ; load the value needed by the following operation
                    sta       Data_0039 ; save the current value in working storage
                    bne       Code_0DFA ; branch when the compared values differ
                    lda       #$0A      ; load the value needed by the following operation
Code_0DFA           anda      #$0F      ; mask off unwanted bits
                    ldb       #$14      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    abx                 ; add the operand to the running value
                    lda       #$12      ; load the value needed by the following operation
                    sta       ,S        ; save the current value in working storage
Code_0E04           ldb       #$07      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $22       ; private DeskMate service selector
                    leax      $04,X     ; form the referenced address without reading memory
                    inc       ,S        ; advance the selected counter
                    lda       ,S        ; load the value needed by the following operation
                    cmpa      #$16      ; compare against the limit and set condition flags
                    bls       Code_0E04 ; branch when the unsigned value is at or below the limit
                    leas      $01,S     ; form the referenced address without reading memory
Code_0E1C           clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_0E22           pshs      U,Y,X,D   ; preserve the listed registers on the stack
                    ldx       Data_0090 ; load the value needed by the following operation
                    lda       Data_0092 ; load the value needed by the following operation
                    ldb       #$01      ; load the value needed by the following operation
                    bsr       Code_0E53 ; call the referenced helper routine
Code_0E2C           sta       Addr_0021 ; save the current value in working storage
                    ldx       Data_0090 ; load the value needed by the following operation
                    lda       Data_0092 ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    cmpa      #$0C      ; compare against the limit and set condition flags
                    ble       Code_0E3B ; branch when the signed value is at or below the limit
                    lda       #$01      ; load the value needed by the following operation
                    leax      $01,X     ; form the referenced address without reading memory
Code_0E3B           ldb       #$01      ; load the value needed by the following operation
                    bsr       Code_0E53 ; call the referenced helper routine
                    suba      Addr_0021 ; subtract the operand from the running value
                    bge       Code_0E45 ; branch when the signed value is at least the limit
                    adda      #$07      ; add the operand to the running value
Code_0E45           tfr       A,B       ; copy the source register into the destination register
                    adda      #$28      ; add the operand to the running value
                    daa                 ; adjust the accumulator to packed decimal
                    sta       Data_0037 ; save the current value in working storage
                    addb      #$1C      ; add the operand to the running value
                    stb       Data_0036 ; save the current value in working storage
                    puls      U,Y,X,D   ; restore the listed registers from the stack
                    rts                 ; return to the caller
Code_0E53           suba      #$02      ; subtract the operand from the running value
                    bgt       Code_0E5B ; branch when the signed value is above the limit
                    adda      #$0C      ; add the operand to the running value
                    leax      -$01,X    ; form the referenced address without reading memory
Code_0E5B           sta       Addr_001E ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    std       Code_001C ; save the current value in working storage
                    bra       Code_0E66 ; continue at the selected control-flow target
Code_0E62           inca                ; advance the selected counter
                    leax      -$64,X    ; form the referenced address without reading memory
Code_0E66           cmpx      #Data_0064 ; compare against the limit and set condition flags
                    bcc       Code_0E62 ; branch when carry is clear
                    sta       Addr_001F ; save the current value in working storage
                    tfr       X,D       ; copy the source register into the destination register
                    stb       Code_0020 ; save the current value in working storage
                    lda       Addr_001E ; load the value needed by the following operation
                    ldb       #$0D      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    decb                ; decrement the selected counter
Code_0E77           inca                ; advance the selected counter
                    subb      #$05      ; subtract the operand from the running value
                    cmpb      #$05      ; compare against the limit and set condition flags
                    bcc       Code_0E77 ; branch when carry is clear
                    tfr       A,B       ; copy the source register into the destination register
                    clra                ; clear the selected byte or register
                    std       ,--S      ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    ldb       Addr_001F ; load the value needed by the following operation
                    aslb                ; shift left and update carry
                    std       ,--S      ; save the current value in working storage
                    ldb       Addr_001F ; load the value needed by the following operation
                    lsrb                ; shift right and expose the low bit through carry
                    lsrb                ; shift right and expose the low bit through carry
                    std       ,--S      ; save the current value in working storage
                    ldb       Code_0020 ; load the value needed by the following operation
                    lsrb                ; shift right and expose the low bit through carry
                    lsrb                ; shift right and expose the low bit through carry
                    addb      Code_0020 ; add the operand to the running value
                    addd      ,S++      ; add the operand to the running value
                    subd      ,S++      ; subtract the operand from the running value
                    addd      ,S++      ; add the operand to the running value
                    addd      Code_001C ; add the operand to the running value
                    bpl       Code_0EA2 ; branch while the tested value is nonnegative
                    addd      #Data_00AF ; add the operand to the running value
Code_0EA2           subd      #Addr_0007 ; subtract the operand from the running value
                    bpl       Code_0EA2 ; branch while the tested value is nonnegative
                    addd      #Addr_0008 ; add the operand to the running value
                    tfr       B,A       ; copy the source register into the destination register
                    rts                 ; return to the caller
                    fcb       $00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "4w"                           ; embedded text or resource bytes
                    fcb       $1F,$89,$17,$F1 ; table, bitmap, or initialized data bytes
                    fcc       "["                            ; embedded text or resource bytes
                    fcb       $0C       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $8D,$FF,$EE,$86 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C1       ; table, bitmap, or initialized data bytes
                    fcc       "d%"                           ; embedded text or resource bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $C0       ; table, bitmap, or initialized data bytes
                    fcc       "d"                            ; embedded text or resource bytes
                    fcb       $22,$F7,$A7,$A0,$86 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C1,$0A   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $C0,$0A,$22,$F7,$A7,$A0 ; table, bitmap, or initialized data bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C1,$01   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $C0,$01,$22,$F7,$A7,$A0 ; table, bitmap, or initialized data bytes
                    fcc       "o"                            ; embedded text or resource bytes
                    fcb       $A4,$C6,$00,$86,$16,$17 ; table, bitmap, or initialized data bytes
                    fcb       $F1       ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $0B,$CC,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FF,$B6,$17,$F1,$19 ; table, bitmap, or initialized data bytes
                    fcb       $0A       ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $17,$F1,$14,$1C ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $06,$17,$F1,$0E,$0B ; table, bitmap, or initialized data bytes
                    fcc       "5w9"                          ; embedded text or resource bytes
Data_0F09           fcb       $01,$08,$08 ; table, bitmap, or initialized data bytes
                    fcc       "open"                         ; embedded text or resource bytes
                    fcb       $00,$01,$08,$08 ; table, bitmap, or initialized data bytes
                    fcc       "close"                        ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_0F1A           fcb       $01,$08,$08 ; table, bitmap, or initialized data bytes
                    fcc       "save"                         ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_0F22           fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       " 2 print"                     ; embedded text or resource bytes
                    fcb       $00,$01   ; table, bitmap, or initialized data bytes
                    fcc       " ? help"                      ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_0F35           fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       " 3 copy"                      ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_0F3E           fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       " 4 insert"                    ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_0F49           fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       " 5 delete"                    ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_0F54           fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       " 7 find"                      ; embedded text or resource bytes
                    fcb       $00,$01   ; table, bitmap, or initialized data bytes
                    fcc       " 8 edit"                      ; embedded text or resource bytes
                    fcb       $00,$01   ; table, bitmap, or initialized data bytes
                    fcc       " ? help"                      ; embedded text or resource bytes
                    fcb       $00,$01   ; table, bitmap, or initialized data bytes
                    fcc       " 9 find date"                 ; embedded text or resource bytes
                    fcb       $00,$01   ; table, bitmap, or initialized data bytes
                    fcc       " ? help"                      ; embedded text or resource bytes
                    fcb       $00,$FF   ; table, bitmap, or initialized data bytes
Data_0F87           fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00 ; table, bitmap, or initialized data bytes
Data_0F91           fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
Data_0F9D           fcb       $00,$00,$00,$00 ; table, bitmap, or initialized data bytes
Code_0FA1           leay      >Data_0F87,PCR ; form the referenced address without reading memory
                    leax      >Data_0FFF,PCR ; form the referenced address without reading memory
                    sty       ,X        ; save the current value in working storage
                    leay      >Data_0F91,PCR ; form the referenced address without reading memory
                    leax      Data_1066,PCR ; form the referenced address without reading memory
                    sty       ,X        ; save the current value in working storage
                    leay      >Data_0F9D,PCR ; form the referenced address without reading memory
                    leax      Data_1112,PCR ; form the referenced address without reading memory
                    sty       ,X        ; save the current value in working storage
                    leax      Data_0F09,PCR ; form the referenced address without reading memory
                    leay      >Data_0F87,PCR ; form the referenced address without reading memory
Code_0FCA           stx       ,Y++      ; store the value and advance the destination pointer
Code_0FCC           tst       ,X+       ; set condition flags from the current value
                    bne       Code_0FCC ; branch when the compared values differ
                    tst       ,X        ; set condition flags from the current value
                    bpl       Code_0FCA ; branch while the tested value is nonnegative
                    rts                 ; return to the caller
Code_0FD5           lbsr      start     ;0FD5: 17 F0 3B       '.. ; call the referenced helper routine
                    fcc       "Y"                            ; embedded text or resource bytes
                    lda       #$03      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_0FE0           pshs      A         ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    lda       #$01      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    puls      PC,A      ; restore the listed registers from the stack
Data_0FF7           fcc       "("                            ; embedded text or resource bytes
                    fcb       $02,$01,$09,$09,$00,$AA ; table, bitmap, or initialized data bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
Data_0FFF           fcb       $00,$00,$07,$07,$05,$00 ; table, bitmap, or initialized data bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
Code_1006           bsr       Code_0FD5 ; call the referenced helper routine
                    lda       #$02      ; load the value needed by the following operation
                    sta       Data_1514,PCR ; save the current value in working storage
                    ldb       #$01      ; load the value needed by the following operation
                    ldx       Data_0070 ; load the value needed by the following operation
                    cmpx      Data_0072 ; compare against the limit and set condition flags
                    bcs       Code_1017 ; branch when carry reports an unsigned underflow or error
                    comb                ; invert every bit in the selected value
Code_1017           stb       Data_0F1A,PCR ; save the current value in working storage
                    stb       Data_0F22,PCR ; save the current value in working storage
                    leax      >Data_0FF7,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    clra                ; clear the selected byte or register
                    leax      >Data_0FFF,PCR ; form the referenced address without reading memory
                    lbsr      Code_2666 ; call the referenced helper routine
Code_102F           lbsr      Code_2776 ; call the referenced helper routine
                    cmpb      #$0D      ; compare against the limit and set condition flags
                    beq       Code_1046 ; branch when the compared values are equal
                    coma                ; invert every bit in the selected value
                    cmpb      #$05      ; compare against the limit and set condition flags
                    beq       Code_1046 ; branch when the compared values are equal
                    lda       #$03      ; load the value needed by the following operation
                    cmpb      #$B2      ; compare against the limit and set condition flags
                    beq       Code_1046 ; branch when the compared values are equal
                    cmpb      #$AF      ; compare against the limit and set condition flags
                    bne       Code_102F ; branch when the compared values differ
                    inca                ; advance the selected counter
Code_1046           tst       Data_0F1A,PCR ; set condition flags from the current value
                    bpl       Code_1050 ; branch while the tested value is nonnegative
                    cmpa      #$02      ; compare against the limit and set condition flags
                    beq       Code_102F ; branch when the compared values are equal
Code_1050           tst       Data_0F22,PCR ; set condition flags from the current value
                    bpl       Code_105A ; branch while the tested value is nonnegative
                    cmpa      #$03      ; compare against the limit and set condition flags
                    beq       Code_102F ; branch when the compared values are equal
Code_105A           lbsr      Code_0FE0 ; call the referenced helper routine
                    rts                 ; return to the caller
Data_105E           fcc       "("                            ; embedded text or resource bytes
                    fcb       $05,$01,$0A,$0A,$00,$AA ; table, bitmap, or initialized data bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
Data_1066           fcb       $00,$00,$08,$08,$06,$00 ; table, bitmap, or initialized data bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
Code_106D           lbsr      Code_0FD5 ; call the referenced helper routine
                    lda       #$03      ; load the value needed by the following operation
                    sta       Data_1514,PCR ; save the current value in working storage
                    ldb       #$01      ; load the value needed by the following operation
                    ldx       Data_0040 ; load the value needed by the following operation
                    lda       ,X        ; load the value needed by the following operation
                    cmpa      #$8C      ; compare against the limit and set condition flags
                    bne       Code_1081 ; branch when the compared values differ
                    comb                ; invert every bit in the selected value
Code_1081           stb       Data_0F35,PCR ; save the current value in working storage
                    ldb       #$01      ; load the value needed by the following operation
                    ldx       Data_0046 ; load the value needed by the following operation
                    lda       ,X        ; load the value needed by the following operation
                    cmpa      #$8C      ; compare against the limit and set condition flags
                    bne       Code_1090 ; branch when the compared values differ
                    comb                ; invert every bit in the selected value
Code_1090           stb       Data_0F3E,PCR ; save the current value in working storage
                    ldb       #$01      ; load the value needed by the following operation
                    ldx       Data_0070 ; load the value needed by the following operation
                    cmpx      Data_0072 ; compare against the limit and set condition flags
                    bcs       Code_109D ; branch when carry reports an unsigned underflow or error
                    comb                ; invert every bit in the selected value
Code_109D           stb       Data_0F54,PCR ; save the current value in working storage
                    stb       Data_0F49,PCR ; save the current value in working storage
                    leax      >Data_105E,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    clra                ; clear the selected byte or register
                    leax      >Data_1066,PCR ; form the referenced address without reading memory
                    lbsr      Code_2666 ; call the referenced helper routine
Code_10B5           lbsr      Code_2776 ; call the referenced helper routine
                    cmpb      #$0D      ; compare against the limit and set condition flags
                    beq       Code_10DF ; branch when the compared values are equal
                    coma                ; invert every bit in the selected value
                    cmpb      #$05      ; compare against the limit and set condition flags
                    beq       Code_10DF ; branch when the compared values are equal
                    clra                ; clear the selected byte or register
                    cmpb      #$B3      ; compare against the limit and set condition flags
                    beq       Code_10DF ; branch when the compared values are equal
                    cmpb      #$B4      ; compare against the limit and set condition flags
                    beq       Code_10DE ; branch when the compared values are equal
                    cmpb      #$B5      ; compare against the limit and set condition flags
                    beq       Code_10DD ; branch when the compared values are equal
                    cmpb      #$B7      ; compare against the limit and set condition flags
                    beq       Code_10DC ; branch when the compared values are equal
                    cmpb      #$B8      ; compare against the limit and set condition flags
                    beq       Code_10DB ; branch when the compared values are equal
                    cmpb      #$AF      ; compare against the limit and set condition flags
                    bne       Code_10B5 ; branch when the compared values differ
                    inca                ; advance the selected counter
Code_10DB           inca                ; advance the selected counter
Code_10DC           inca                ; advance the selected counter
Code_10DD           inca                ; advance the selected counter
Code_10DE           inca                ; advance the selected counter
Code_10DF           tst       Data_0F35,PCR ; set condition flags from the current value
                    bpl       Code_10E8 ; branch while the tested value is nonnegative
                    tsta                ; set condition flags from the current value
                    beq       Code_10B5 ; branch when the compared values are equal
Code_10E8           tst       Data_0F3E,PCR ; set condition flags from the current value
                    bpl       Code_10F2 ; branch while the tested value is nonnegative
                    cmpa      #$01      ; compare against the limit and set condition flags
                    beq       Code_10B5 ; branch when the compared values are equal
Code_10F2           tst       Data_0F49,PCR ; set condition flags from the current value
                    bpl       Code_10FC ; branch while the tested value is nonnegative
                    cmpa      #$02      ; compare against the limit and set condition flags
                    beq       Code_10B5 ; branch when the compared values are equal
Code_10FC           tst       Data_0F54,PCR ; set condition flags from the current value
                    bpl       Code_1106 ; branch while the tested value is nonnegative
                    cmpa      #$03      ; compare against the limit and set condition flags
                    beq       Code_10B5 ; branch when the compared values are equal
Code_1106           lbsr      Code_0FE0 ; call the referenced helper routine
                    rts                 ; return to the caller
Data_110A           fcc       "("                            ; embedded text or resource bytes
                    fcb       $0B,$01,$0C,$06,$00,$AA ; table, bitmap, or initialized data bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
Data_1112           fcb       $00,$00,$04,$0A,$02,$00 ; table, bitmap, or initialized data bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
Code_1119           lbsr      Code_0FD5 ; call the referenced helper routine
                    lda       #$04      ; load the value needed by the following operation
                    sta       Data_1514,PCR ; save the current value in working storage
                    leax      >Data_110A,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    clra                ; clear the selected byte or register
                    leax      >Data_1112,PCR ; form the referenced address without reading memory
                    lbsr      Code_2666 ; call the referenced helper routine
Code_1132           lbsr      Code_2776 ; call the referenced helper routine
                    cmpb      #$0D      ; compare against the limit and set condition flags
                    beq       Code_1148 ; branch when the compared values are equal
                    coma                ; invert every bit in the selected value
                    cmpb      #$05      ; compare against the limit and set condition flags
                    beq       Code_1148 ; branch when the compared values are equal
                    clra                ; clear the selected byte or register
                    cmpb      #$B9      ; compare against the limit and set condition flags
                    beq       Code_1148 ; branch when the compared values are equal
                    cmpb      #$AF      ; compare against the limit and set condition flags
                    bne       Code_1132 ; branch when the compared values differ
                    inca                ; advance the selected counter
Code_1148           lbsr      Code_0FE0 ; call the referenced helper routine
                    pshs      A         ; preserve the listed registers on the stack
                    lbsr      Code_17CA ; call the referenced helper routine
                    puls      PC,A      ; restore the listed registers from the stack
Data_1152           fcc       "Find: "                       ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1159           fcc       "                    "         ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_116E           ldx       Data_0070 ; load the value needed by the following operation
                    cmpx      Data_0072 ; compare against the limit and set condition flags
                    bcc       Code_1197 ; branch when carry is clear
                    leax      >Data_1152,PCR ; form the referenced address without reading memory
                    lda       #$14      ; load the value needed by the following operation
                    leau      >Data_1159,PCR ; form the referenced address without reading memory
                    clr       Data_005F ; clear the selected byte or register
                    lbsr      Code_1279 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_1191 ; branch when the compared values are equal
                    tst       Data_007D ; set condition flags from the current value
                    beq       Code_118E ; branch when the compared values are equal
                    ldx       Data_0070 ; load the value needed by the following operation
                    stx       Data_007B ; save the current value in working storage
Code_118E           lbsr      Code_2271 ; call the referenced helper routine
Code_1191           lda       #$01      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
Code_1197           rts                 ; return to the caller
Data_1198           fcc       "invalid entry"                ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_11A6           fcc       "Date to Find:  "              ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "/0/0/0/"                      ; embedded text or resource bytes
Data_11BD           fcc       "1-31-86   "                   ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_11C8           ldu       #DeskMateService ; load the value needed by the following operation
Code_11CB           lda       ,-X       ; load the value needed by the following operation
                    suba      #$30      ; subtract the operand from the running value
                    cmpa      #$09      ; compare against the limit and set condition flags
                    bhi       Code_11CB ; branch when the unsigned value is above the limit
                    ldb       #$01      ; load the value needed by the following operation
                    stb       Data_0053 ; save the current value in working storage
Code_11D7           ldb       Data_0053 ; load the value needed by the following operation
                    bpl       Code_11E0 ; branch while the tested value is nonnegative
                    ldb       #$0A      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    lda       #$64      ; load the value needed by the following operation
Code_11E0           mul                 ; multiply the two eight-bit accumulators
                    leau      D,U       ; form the referenced address without reading memory
                    ldb       Data_0053 ; load the value needed by the following operation
                    bmi       Code_11F4 ; branch while the tested value is negative
                    lda       #$0A      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    stb       Data_0053 ; save the current value in working storage
                    lda       ,-X       ; load the value needed by the following operation
                    suba      #$30      ; subtract the operand from the running value
                    cmpa      #$09      ; compare against the limit and set condition flags
                    bls       Code_11D7 ; branch when the unsigned value is at or below the limit
Code_11F4           rts                 ; return to the caller
Code_11F5           bsr       Code_11C8 ; call the referenced helper routine
                    lda       Data_0053 ; load the value needed by the following operation
                    cmpa      #$64      ; compare against the limit and set condition flags
                    bhi       Code_1201 ; branch when the unsigned value is above the limit
                    leau      $076C,U   ; form the referenced address without reading memory
Code_1201           cmpu      #Addr_9999 ; compare against the limit and set condition flags
                    bhi       Code_1239 ; branch when the unsigned value is above the limit
                    stu       Data_0090 ; save the current value in working storage
                    lbsr      Code_11C8 ; call the referenced helper routine
                    cmpu      #Addr_001F ; compare against the limit and set condition flags
                    bhi       Code_1239 ; branch when the unsigned value is above the limit
                    tfr       U,D       ; copy the source register into the destination register
                    stb       Data_0093 ; save the current value in working storage
                    lbsr      Code_11C8 ; call the referenced helper routine
                    cmpu      #Addr_000C ; compare against the limit and set condition flags
                    bhi       Code_1239 ; branch when the unsigned value is above the limit
                    tfr       U,D       ; copy the source register into the destination register
                    tstb                ; set condition flags from the current value
                    beq       Code_1239 ; branch when the compared values are equal
                    stb       Data_0092 ; save the current value in working storage
Code_1226           lbsr      Code_0E22 ; call the referenced helper routine
                    lda       Data_0093 ; load the value needed by the following operation
                    beq       Code_1239 ; branch when the compared values are equal
                    cmpa      Data_0036 ; compare against the limit and set condition flags
                    bhi       Code_1239 ; branch when the unsigned value is above the limit
                    lbsr      Code_0B0B ; call the referenced helper routine
                    sta       Data_0093 ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    bra       Code_123B ; continue at the selected control-flow target
Code_1239           lda       #$01      ; load the value needed by the following operation
Code_123B           sta       Data_005F ; save the current value in working storage
                    rts                 ; return to the caller
Code_123E           clr       Data_005F ; clear the selected byte or register
                    ldd       Data_0090 ; load the value needed by the following operation
                    std       Data_0060 ; save the current value in working storage
                    ldd       Data_0092 ; load the value needed by the following operation
                    std       Data_0062 ; save the current value in working storage
Code_1248           leax      Data_11A6,PCR ; form the referenced address without reading memory
                    lda       #$0A      ; load the value needed by the following operation
                    leau      Data_11BD,PCR ; form the referenced address without reading memory
                    lbsr      Code_1279 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_1266 ; branch when the compared values are equal
                    leax      Data_11BD,PCR ; form the referenced address without reading memory
                    leax      $0A,X     ; form the referenced address without reading memory
                    bsr       Code_11F5 ; call the referenced helper routine
                    tst       Data_005F ; set condition flags from the current value
                    bne       Code_1248 ; branch when the compared values differ
                    bra       Code_126E ; continue at the selected control-flow target
Code_1266           ldd       Data_0060 ; load the value needed by the following operation
                    std       Data_0090 ; save the current value in working storage
                    ldd       Data_0062 ; load the value needed by the following operation
                    std       Data_0092 ; save the current value in working storage
Code_126E           lbra      Code_1191 ; continue at the distant control-flow target
Data_1271           fcc       "("                            ; embedded text or resource bytes
                    fcb       $05,$07,$1E,$05,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
Code_1279           pshs      U,X,A     ; preserve the listed registers on the stack
                    leax      >Data_1271,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    tst       Data_005F ; set condition flags from the current value
                    beq       Code_129A ; branch when the compared values are equal
                    ldx       #Addr_0008 ; load the value needed by the following operation
                    ldy       #Addr_0002 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    leax      Data_1198,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
Code_129A           ldx       #Addr_0001 ; load the value needed by the following operation
                    ldy       #Addr_0001 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    puls      X,A       ; restore the listed registers from the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
                    puls      X         ; restore the listed registers from the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $16       ; private DeskMate service selector
                    ora       #$80      ; set the selected flag bits
Code_12B3           clrb                ; clear the selected byte or register
                    lbsr      Code_2891 ; call the referenced helper routine
                    stb       Data_007D ; save the current value in working storage
                    tsta                ; set condition flags from the current value
                    beq       Code_12C7 ; branch when the compared values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    beq       Code_12D0 ; branch when the compared values are equal
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    bne       Code_12B3 ; branch when the compared values differ
Code_12C4           lda       #$0D      ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_12C7           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "E"                            ; embedded text or resource bytes
                    cmpx      #Data_00FF ; compare against the limit and set condition flags
                    bne       Code_12C4 ; branch when the compared values differ
Code_12D0           clra                ; clear the selected byte or register
Code_12D1           rts                 ; return to the caller
Data_12D2           fcb       $1E       ; table, bitmap, or initialized data bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $06,$07,$00 ; table, bitmap, or initialized data bytes
                    fcc       "2B"                           ; embedded text or resource bytes
                    fcb       $06,$07,$01,$FF,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$0F   ; table, bitmap, or initialized data bytes
Data_12E1           fcc       "("                            ; embedded text or resource bytes
                    fcb       $06,$05,$1B,$08,$00,$FF ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
Data_12E9           fcc       " Delete   one day   m"        ; embedded text or resource bytes
                    fcc       "ore"                          ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1302           fcc       "Delete from: "                ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1310           fcc       "  to: "                       ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_1317           ldx       Data_0070 ; load the value needed by the following operation
                    cmpx      Data_0072 ; compare against the limit and set condition flags
                    bcc       Code_12D1 ; branch when carry is clear
                    leax      >Data_12E1,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    lda       #$04      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    leax      >Data_12E9,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    bra       Code_133E ; continue at the selected control-flow target
Code_133A           tst       Addr_0009 ; set condition flags from the current value
                    beq       Code_134A ; branch when the compared values are equal
Code_133E           leax      Data_14B8,PCR ; form the referenced address without reading memory
                    leay      Data_14DB,PCR ; form the referenced address without reading memory
                    bsr       Code_1391 ; call the referenced helper routine
                    clr       Addr_0009 ; clear the selected byte or register
Code_134A           ldb       #$80      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    bne       Code_136B ; branch when the compared values differ
                    lbsr      Code_1A62 ; call the referenced helper routine
                    cmpb      #$01      ; compare against the limit and set condition flags
                    beq       Code_13A2 ; branch when the compared values are equal
                    ldd       Addr_0006 ; load the value needed by the following operation
                    leax      Data_12D2,PCR ; form the referenced address without reading memory
                    lbsr      Code_1A47 ; call the referenced helper routine
                    tstb                ; set condition flags from the current value
                    beq       Code_133A ; branch when the compared values are equal
                    cmpb      #$01      ; compare against the limit and set condition flags
                    beq       Code_137C ; branch when the compared values are equal
                    bra       Code_134A ; continue at the selected control-flow target
Code_136B           cmpa      #$0D      ; compare against the limit and set condition flags
                    beq       Code_13AB ; branch when the compared values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    bne       Code_1374 ; branch when the compared values differ
Code_1373           rts                 ; return to the caller
Code_1374           cmpa      #$08      ; compare against the limit and set condition flags
                    beq       Code_133A ; branch when the compared values are equal
                    cmpa      #$09      ; compare against the limit and set condition flags
                    bne       Code_134A ; branch when the compared values differ
Code_137C           tst       Addr_0009 ; set condition flags from the current value
                    bne       Code_138E ; branch when the compared values differ
                    leax      Data_14DB,PCR ; form the referenced address without reading memory
                    leay      Data_14B8,PCR ; form the referenced address without reading memory
                    bsr       Code_1391 ; call the referenced helper routine
                    lda       #$01      ; load the value needed by the following operation
                    sta       Addr_0009 ; save the current value in working storage
Code_138E           lbra      Code_134A ; continue at the distant control-flow target
Code_1391           lda       #$34      ; load the value needed by the following operation
                    ldb       #$1E      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    tfr       Y,X       ; copy the source register into the destination register
                    ldb       #$32      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_13A2           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "E"                            ; embedded text or resource bytes
                    cmpx      #Data_00FF ; compare against the limit and set condition flags
                    beq       Code_1373 ; branch when the compared values are equal
Code_13AB           tst       Addr_0009 ; set condition flags from the current value
                    bne       Code_13D3 ; branch when the compared values differ
                    lbsr      Code_2212 ; call the referenced helper routine
                    rts                 ; return to the caller
                    fcc       "0-0-0"                        ; embedded text or resource bytes
Data_13B8           fcc       "          "                   ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "0-0-0"                        ; embedded text or resource bytes
Data_13C8           fcc       "          "                   ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_13D3           ldd       Data_0090 ; load the value needed by the following operation
                    std       Data_0060 ; save the current value in working storage
                    ldd       Data_0092 ; load the value needed by the following operation
                    std       Data_0062 ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    clr       Data_005F ; clear the selected byte or register
Code_13E1           tst       Data_005F ; set condition flags from the current value
                    beq       Code_13F8 ; branch when the compared values are equal
                    ldx       #Addr_0008 ; load the value needed by the following operation
                    ldy       #Addr_0004 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    leax      Data_1198,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
Code_13F8           ldx       #Addr_0001 ; load the value needed by the following operation
                    ldy       #Addr_0002 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    leax      Data_1302,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
                    leax      >Data_13B8,PCR ; form the referenced address without reading memory
                    lbsr      Code_14AE ; call the referenced helper routine
                    lda       #$0A      ; load the value needed by the following operation
                    ora       #$80      ; set the selected flag bits
Code_1416           clrb                ; clear the selected byte or register
                    lbsr      Code_2891 ; call the referenced helper routine
                    cmpa      #$05      ; compare against the limit and set condition flags
                    lbeq      Code_149D ; take the distant branch when values are equal
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    beq       Code_142A ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $19       ; private DeskMate service selector
                    bra       Code_1416 ; continue at the selected control-flow target
Code_142A           leax      >Data_13B8,PCR ; form the referenced address without reading memory
                    leax      $0A,X     ; form the referenced address without reading memory
                    lbsr      Code_11F5 ; call the referenced helper routine
                    tst       Data_005F ; set condition flags from the current value
                    bne       Code_13E1 ; branch when the compared values differ
                    ldd       Data_0090 ; load the value needed by the following operation
                    std       Data_0064 ; save the current value in working storage
                    ldd       Data_0092 ; load the value needed by the following operation
                    std       Data_0066 ; save the current value in working storage
Code_143F           tst       Data_005F ; set condition flags from the current value
                    beq       Code_1456 ; branch when the compared values are equal
                    ldx       #Addr_0008 ; load the value needed by the following operation
                    ldy       #Addr_0005 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    leax      Data_1198,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
Code_1456           ldx       #Addr_0008 ; load the value needed by the following operation
                    ldy       #Addr_0004 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    leax      Data_1310,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
                    leax      Data_13C8,PCR ; form the referenced address without reading memory
                    bsr       Code_14AE ; call the referenced helper routine
                    lda       #$0A      ; load the value needed by the following operation
                    ora       #$80      ; set the selected flag bits
Code_1473           clrb                ; clear the selected byte or register
                    lbsr      Code_2891 ; call the referenced helper routine
                    cmpa      #$05      ; compare against the limit and set condition flags
                    beq       Code_149D ; branch when the compared values are equal
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    beq       Code_1485 ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $19       ; private DeskMate service selector
                    bra       Code_1473 ; continue at the selected control-flow target
Code_1485           leax      Data_13C8,PCR ; form the referenced address without reading memory
                    leax      $0A,X     ; form the referenced address without reading memory
                    lbsr      Code_11F5 ; call the referenced helper routine
                    tst       Data_005F ; set condition flags from the current value
                    bne       Code_143F ; branch when the compared values differ
                    ldd       Data_0090 ; load the value needed by the following operation
                    std       Data_0068 ; save the current value in working storage
                    ldd       Data_0092 ; load the value needed by the following operation
                    std       Data_006A ; save the current value in working storage
                    lbsr      Code_22FA ; call the referenced helper routine
Code_149D           ldd       Data_0060 ; load the value needed by the following operation
                    std       Data_0090 ; save the current value in working storage
                    ldd       Data_0062 ; load the value needed by the following operation
                    std       Data_0092 ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $16       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $19       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_14AE           lda       #$09      ; load the value needed by the following operation
Code_14B0           ldb       #$20      ; load the value needed by the following operation
                    stb       A,X       ; save the current value in working storage
                    deca                ; decrement the selected counter
                    bge       Code_14B0 ; branch when the signed value is at least the limit
                    rts                 ; return to the caller
Data_14B8           fcc       "("                            ; embedded text or resource bytes
                    fcb       $04,$08,$0A,$AA,$AF,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0A,$00,$0E,$00,$0A,$00 ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $00,$0A,$00,$CA,$00,$08 ; table, bitmap, or initialized data bytes
                    fcb       $C3,$0A,$00,$0A ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $0A,$00,$0A,$0F,$0A,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0A,$AA,$AA,$00 ; table, bitmap, or initialized data bytes
Data_14DB           fcc       "("                            ; embedded text or resource bytes
                    fcb       $04,$08,$0A,$AA,$AA,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0A,$00,$0A,$00,$0A,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0A,$00,$0A,$00,$0A,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0A,$00,$0A,$00,$0A,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0A,$00,$0A,$00,$0A,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0A,$AA,$AA,$00 ; table, bitmap, or initialized data bytes
Data_14FE           fcc       "("                            ; embedded text or resource bytes
                    fcb       $04,$03,$1E,$0C,$00,$FF ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
Data_1506           fcc       "DMHELP"                       ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "DMCALN "                      ; embedded text or resource bytes
Data_1514           fcb       $00,$00,$0D ; table, bitmap, or initialized data bytes
Code_1517           leax      >Data_14FE,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    ldx       #Addr_FFF8 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "O"                            ; embedded text or resource bytes
                    leax      >Data_1506,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "V"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "P"                            ; embedded text or resource bytes
                    lda       #$01      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "-"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $00       ; private DeskMate service selector
                    lbsr      Code_0FA1 ; call the referenced helper routine
                    lbsr      Code_17CA ; call the referenced helper routine
                    lbsr      Code_0795 ; call the referenced helper routine
Code_1549           rts                 ; return to the caller
Data_154A           fcb       $1A       ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $06,$07,$00 ; table, bitmap, or initialized data bytes
                    fcc       ",:"                           ; embedded text or resource bytes
                    fcb       $06,$07,$01,$1A ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $08,$09,$02 ; table, bitmap, or initialized data bytes
                    fcc       ",:"                           ; embedded text or resource bytes
                    fcb       $08,$09,$03,$FF,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$0F   ; table, bitmap, or initialized data bytes
Data_1563           fcc       "("                            ; embedded text or resource bytes
                    fcb       $06,$05,$19,$08,$00,$FF ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
Data_156B           fcc       " Print   day      wee"        ; embedded text or resource bytes
                    fcc       "k"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1582           fcc       "month    all"                 ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_158F           ldx       Data_0070 ; load the value needed by the following operation
                    cmpx      Data_0072 ; compare against the limit and set condition flags
                    bcc       Code_1549 ; branch when carry is clear
                    leax      >Data_1563,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    lda       #$04      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    leax      >Data_156B,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
                    ldx       #Addr_0009 ; load the value needed by the following operation
                    ldy       #Addr_0002 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    leax      >Data_1582,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    leax      Data_14B8,PCR ; form the referenced address without reading memory
                    clr       Addr_000A ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
Code_15CA           lbsr      Code_164C ; call the referenced helper routine
                    leax      Data_14DB,PCR ; form the referenced address without reading memory
                    inc       Addr_000A ; advance the selected counter
                    ldb       Addr_000A ; load the value needed by the following operation
                    cmpb      #$03      ; compare against the limit and set condition flags
                    ble       Code_15CA ; branch when the signed value is at or below the limit
                    clr       Addr_000A ; clear the selected byte or register
Code_15DB           ldb       #$80      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    bne       Code_15FD ; branch when the compared values differ
                    lbsr      Code_1A62 ; call the referenced helper routine
                    cmpb      #$01      ; compare against the limit and set condition flags
                    beq       Code_1668 ; branch when the compared values are equal
                    ldd       Addr_0006 ; load the value needed by the following operation
                    leax      Data_154A,PCR ; form the referenced address without reading memory
                    lbsr      Code_1A47 ; call the referenced helper routine
                    cmpb      #$0F      ; compare against the limit and set condition flags
                    beq       Code_15DB ; branch when the compared values are equal
                    cmpb      Addr_000A ; compare against the limit and set condition flags
                    beq       Code_15DB ; branch when the compared values are equal
                    bra       Code_1636 ; continue at the selected control-flow target
Code_15FD           cmpa      #$0D      ; compare against the limit and set condition flags
                    beq       Code_1671 ; branch when the compared values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    beq       Code_1661 ; branch when the compared values are equal
                    ldb       Addr_000A ; load the value needed by the following operation
                    cmpa      #$0C      ; compare against the limit and set condition flags
                    bne       Code_1613 ; branch when the compared values differ
                    cmpb      #$02      ; compare against the limit and set condition flags
                    bcs       Code_1613 ; branch when carry reports an unsigned underflow or error
                    subb      #$02      ; subtract the operand from the running value
                    bra       Code_1636 ; continue at the selected control-flow target
Code_1613           cmpa      #$0A      ; compare against the limit and set condition flags
                    bne       Code_161F ; branch when the compared values differ
                    cmpb      #$01      ; compare against the limit and set condition flags
                    bhi       Code_15DB ; branch when the unsigned value is above the limit
                    addb      #$02      ; add the operand to the running value
                    bra       Code_1636 ; continue at the selected control-flow target
Code_161F           cmpa      #$08      ; compare against the limit and set condition flags
                    bne       Code_1629 ; branch when the compared values differ
                    tstb                ; set condition flags from the current value
                    ble       Code_15DB ; branch when the signed value is at or below the limit
                    decb                ; decrement the selected counter
                    bra       Code_1636 ; continue at the selected control-flow target
Code_1629           cmpa      #$09      ; compare against the limit and set condition flags
                    beq       Code_1631 ; branch when the compared values are equal
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bne       Code_15DB ; branch when the compared values differ
Code_1631           cmpb      #$03      ; compare against the limit and set condition flags
                    bcc       Code_15DB ; branch when carry is clear
                    incb                ; advance the selected counter
Code_1636           stb       ,-S       ; save the current value in working storage
                    leax      Data_14B8,PCR ; form the referenced address without reading memory
                    bsr       Code_164C ; call the referenced helper routine
                    ldb       Addr_000A ; load the value needed by the following operation
                    leax      Data_14DB,PCR ; form the referenced address without reading memory
                    bsr       Code_164C ; call the referenced helper routine
                    ldb       ,S+       ; load the value needed by the following operation
                    stb       Addr_000A ; save the current value in working storage
                    bra       Code_15DB ; continue at the selected control-flow target
Code_164C           lda       #$34      ; load the value needed by the following operation
                    cmpb      #$02      ; compare against the limit and set condition flags
                    bcs       Code_1654 ; branch when carry reports an unsigned underflow or error
                    lda       #$44      ; load the value needed by the following operation
Code_1654           andb      #$01      ; mask off unwanted bits
                    beq       Code_165A ; branch when the compared values are equal
                    addb      #$10      ; add the operand to the running value
Code_165A           addb      #$1A      ; add the operand to the running value
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_1661           lda       #$01      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_1668           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "E"                            ; embedded text or resource bytes
                    cmpx      #Data_00FF ; compare against the limit and set condition flags
                    beq       Code_1661 ; branch when the compared values are equal
Code_1671           lbra      Code_2466 ; continue at the distant control-flow target
Data_1674           fcc       "("                            ; embedded text or resource bytes
                    fcb       $04,$0C,$AA,$A8,$0A,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$8F,$F0,$AA,$A8,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$0A,$A8,$F2,$8F,$0A ; table, bitmap, or initialized data bytes
                    fcb       $AA,$F2,$8F,$0A,$AA,$A8 ; table, bitmap, or initialized data bytes
                    fcb       $F0,$AA,$AA,$A8,$F0,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$A8,$F0,$AA,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$AA,$AA,$A8,$F0,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$A8,$F0,$AA,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$AA   ; table, bitmap, or initialized data bytes
Data_16A7           fcc       "("                            ; embedded text or resource bytes
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
Data_16DA           fcc       "("                            ; embedded text or resource bytes
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
Data_170D           fcc       "("                            ; embedded text or resource bytes
                    fcb       $04,$0C,$AA,$AA,$A2,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$AA,$8E,$AA,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$AA,$A8,$FF,$FC,$AA ; table, bitmap, or initialized data bytes
                    fcb       $A3,$FF,$FC,$AA,$8F,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FC,$AA,$8F,$FF,$FC,$AA ; table, bitmap, or initialized data bytes
                    fcb       $A3,$FF,$FC,$AA,$A8,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FC,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $AA,$AA,$AA,$8E,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$A2,$AA ; table, bitmap, or initialized data bytes
Data_1740           fcc       "("                            ; embedded text or resource bytes
                    fcb       $04,$0C,$AA,$8A,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$B2,$AA,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $AA,$AA   ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $AA       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FF,$CA,$AA ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FF,$F2,$AA ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FF,$F2,$AA ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FF,$CA,$AA ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FF,$AA,$AA,$00 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $AA,$AA,$AA,$B2,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$8A,$AA,$AA ; table, bitmap, or initialized data bytes
Data_1773           fcc       "("                            ; embedded text or resource bytes
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
Data_17A6           fcb       $00,$01,$B0,$00,$00,$01 ; table, bitmap, or initialized data bytes
                    fcb       $D2,$00,$0D ; table, bitmap, or initialized data bytes
Data_17AF           fcb       $00,$01,$DC,$00,$00,$01 ; table, bitmap, or initialized data bytes
                    fcb       $FE,$00,$0D ; table, bitmap, or initialized data bytes
Data_17B8           fcb       $00,$02,$02,$00,$00,$02 ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $00,$0D   ; table, bitmap, or initialized data bytes
Data_17C1           fcb       $00,$02   ; table, bitmap, or initialized data bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $00,$00,$02 ; table, bitmap, or initialized data bytes
                    fcc       "R"                            ; embedded text or resource bytes
                    fcb       $00,$0D   ; table, bitmap, or initialized data bytes
Code_17CA           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    lda       #$AA      ; load the value needed by the following operation
                    ldx       #Addr_0004 ; load the value needed by the following operation
                    ldy       #Addr_0E48 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0E       ; private DeskMate service selector
                    lbsr      Code_186D ; call the referenced helper routine
                    lbsr      Code_187F ; call the referenced helper routine
                    lbsr      Code_1891 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    lbsr      Code_189E ; call the referenced helper routine
                    lbsr      Code_18AB ; call the referenced helper routine
                    lbsr      Code_18B8 ; call the referenced helper routine
                    lbsr      Code_18C5 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_17F9           ldd       Addr_0006 ; load the value needed by the following operation
                    leax      Data_1A9E,PCR ; form the referenced address without reading memory
                    lbsr      Code_1A47 ; call the referenced helper routine
Code_1802           stb       Data_005B ; save the current value in working storage
                    cmpb      Data_005C ; compare against the limit and set condition flags
                    beq       Code_1814 ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    bsr       Code_1815 ; call the referenced helper routine
                    bsr       Code_1823 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
Code_1814           rts                 ; return to the caller
Code_1815           lda       #$AA      ; load the value needed by the following operation
                    ldb       Data_005C ; load the value needed by the following operation
                    beq       Code_186D ; branch when the compared values are equal
                    decb                ; decrement the selected counter
                    beq       Code_187F ; branch when the compared values are equal
                    decb                ; decrement the selected counter
                    beq       Code_1891 ; branch when the compared values are equal
                    bra       Code_1831 ; continue at the selected control-flow target
Code_1823           lda       #$FF      ; load the value needed by the following operation
                    ldb       Data_005B ; load the value needed by the following operation
                    stb       Data_005C ; save the current value in working storage
                    beq       Code_1870 ; branch when the compared values are equal
                    decb                ; decrement the selected counter
                    beq       Code_1882 ; branch when the compared values are equal
                    decb                ; decrement the selected counter
                    beq       Code_1894 ; branch when the compared values are equal
Code_1831           decb                ; decrement the selected counter
                    lbeq      Code_18D2 ; take the distant branch when values are equal
                    decb                ; decrement the selected counter
                    lbeq      Code_18D8 ; take the distant branch when values are equal
                    decb                ; decrement the selected counter
                    lbeq      Code_18DE ; take the distant branch when values are equal
                    decb                ; decrement the selected counter
                    lbeq      Code_18E4 ; take the distant branch when values are equal
                    rts                 ; return to the caller
Code_1846           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    pshs      A         ; preserve the listed registers on the stack
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    lda       #$03      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    clra                ; clear the selected byte or register
                    puls      B         ; restore the listed registers from the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Data_1868           fcc       "File"                         ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_186D           clra                ; clear the selected byte or register
                    bra       Code_1872 ; continue at the selected control-flow target
Code_1870           lda       #$40      ; load the value needed by the following operation
Code_1872           ldb       #$03      ; load the value needed by the following operation
                    leax      >Data_1868,PCR ; form the referenced address without reading memory
                    bra       Code_1846 ; continue at the selected control-flow target
Data_187A           fcc       "Text"                         ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_187F           clra                ; clear the selected byte or register
                    bra       Code_1884 ; continue at the selected control-flow target
Code_1882           lda       #$40      ; load the value needed by the following operation
Code_1884           ldb       #$08      ; load the value needed by the following operation
                    leax      >Data_187A,PCR ; form the referenced address without reading memory
                    bra       Code_1846 ; continue at the selected control-flow target
Data_188C           fcc       "Date"                         ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_1891           clra                ; clear the selected byte or register
                    bra       Code_1896 ; continue at the selected control-flow target
Code_1894           lda       #$40      ; load the value needed by the following operation
Code_1896           ldb       #$0E      ; load the value needed by the following operation
                    leax      >Data_188C,PCR ; form the referenced address without reading memory
                    bra       Code_1846 ; continue at the selected control-flow target
Code_189E           ldb       #$36      ; load the value needed by the following operation
                    lda       #$01      ; load the value needed by the following operation
                    leax      Data_1674,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_18AB           ldb       #$3B      ;18AB: C6 3B          '. ; load the value needed by the following operation
                    lda       #$01      ; load the value needed by the following operation
                    leax      Data_170D,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_18B8           ldb       #$41      ; load the value needed by the following operation
                    lda       #$01      ; load the value needed by the following operation
                    leax      Data_1740,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_18C5           ldb       #$46      ; load the value needed by the following operation
                    lda       #$01      ; load the value needed by the following operation
                    leax      Data_1773,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_18D2           leax      Data_17A6,PCR ; form the referenced address without reading memory
                    bra       Code_18EA ; continue at the selected control-flow target
Code_18D8           leax      Data_17AF,PCR ; form the referenced address without reading memory
                    bra       Code_18EA ; continue at the selected control-flow target
Code_18DE           leax      Data_17B8,PCR ; form the referenced address without reading memory
                    bra       Code_18EA ; continue at the selected control-flow target
Code_18E4           leax      Data_17C1,PCR ; form the referenced address without reading memory
                    bra       Code_18EA ; continue at the selected control-flow target
Code_18EA           sta       ,X        ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $13       ; private DeskMate service selector
                    rts                 ; return to the caller
Data_18F1           fcb       $FF,$01,$90,$00 ; table, bitmap, or initialized data bytes
                    fcc       "f"                            ; embedded text or resource bytes
                    fcb       $01,$B2,$00 ; table, bitmap, or initialized data bytes
                    fcc       "s"                            ; embedded text or resource bytes
Data_18FA           fcb       $FF,$01,$B8,$00 ; table, bitmap, or initialized data bytes
                    fcc       "f"                            ; embedded text or resource bytes
                    fcb       $01,$DA,$00 ; table, bitmap, or initialized data bytes
                    fcc       "s"                            ; embedded text or resource bytes
Data_1903           fcb       $FF,$01,$DE,$00 ; table, bitmap, or initialized data bytes
                    fcc       "f"                            ; embedded text or resource bytes
                    fcb       $02,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "s"                            ; embedded text or resource bytes
Code_190C           pshs      Y,X       ; preserve the listed registers on the stack
                    ldd       Addr_0006 ; load the value needed by the following operation
                    leax      Data_1A80,PCR ; form the referenced address without reading memory
                    lbsr      Code_1A47 ; call the referenced helper routine
                    stb       Data_005D ; save the current value in working storage
                    cmpb      Data_005E ; compare against the limit and set condition flags
                    beq       Code_1929 ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    bsr       Code_192B ; call the referenced helper routine
                    bsr       Code_1943 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
Code_1929           puls      PC,Y,X    ; restore the listed registers from the stack
Code_192B           lda       #$AA      ; load the value needed by the following operation
                    ldb       Data_005E ; load the value needed by the following operation
                    lbeq      Code_19C2 ; take the distant branch when values are equal
                    decb                ; decrement the selected counter
                    lbeq      Code_195D ; take the distant branch when values are equal
                    decb                ; decrement the selected counter
                    lbeq      Code_1963 ; take the distant branch when values are equal
                    decb                ; decrement the selected counter
                    lbeq      Code_1969 ; take the distant branch when values are equal
                    rts                 ; return to the caller
Code_1943           lda       #$FF      ; load the value needed by the following operation
                    ldb       Data_005D ; load the value needed by the following operation
                    stb       Data_005E ; save the current value in working storage
                    lbeq      Code_19BE ; take the distant branch when values are equal
                    decb                ; decrement the selected counter
                    lbeq      Code_195D ; take the distant branch when values are equal
                    decb                ; decrement the selected counter
                    lbeq      Code_1963 ; take the distant branch when values are equal
                    decb                ; decrement the selected counter
                    lbeq      Code_1969 ; take the distant branch when values are equal
                    rts                 ; return to the caller
Code_195D           leax      >Data_18F1,PCR ; form the referenced address without reading memory
                    bra       Code_196D ; continue at the selected control-flow target
Code_1963           leax      >Data_18FA,PCR ; form the referenced address without reading memory
                    bra       Code_196D ; continue at the selected control-flow target
Code_1969           leax      >Data_1903,PCR ; form the referenced address without reading memory
Code_196D           lbra      Code_18EA ; continue at the distant control-flow target
Code_1970           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    lbsr      Code_1991 ; call the referenced helper routine
                    lbsr      Code_19C2 ; call the referenced helper routine
                    lbsr      Code_19E7 ; call the referenced helper routine
                    lbsr      Code_19F4 ; call the referenced helper routine
                    lbsr      Code_1A01 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
                    fcb       $AA,$00,$C8,$00 ; table, bitmap, or initialized data bytes
                    fcc       "f"                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $00,$BD   ; table, bitmap, or initialized data bytes
Code_1991           lda       #$AA      ; load the value needed by the following operation
                    ldx       #Addr_6618 ; load the value needed by the following operation
                    ldy       #Code_0E2C ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0E       ; private DeskMate service selector
                    pshs      U         ; preserve the listed registers on the stack
                    clrb                ; clear the selected byte or register
                    ldx       #Data_00BC ; load the value needed by the following operation
                    ldy       #Data_0065 ; load the value needed by the following operation
                    ldu       #Code_021C ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $11       ; private DeskMate service selector
                    ldu       #Data_0073 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $12       ; private DeskMate service selector
                    puls      U         ; restore the listed registers from the stack
                    rts                 ; return to the caller
Data_19B9           fcc       "Exit"                         ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_19BE           ldb       #$40      ; load the value needed by the following operation
                    bra       Code_19C3 ; continue at the selected control-flow target
Code_19C2           clrb                ; clear the selected byte or register
Code_19C3           pshs      B         ; preserve the listed registers on the stack
                    ldb       #$0E      ; load the value needed by the following operation
                    lda       #$0D      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    lda       #$01      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    clra                ; clear the selected byte or register
                    puls      B         ; restore the listed registers from the stack
                    leax      >Data_19B9,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    lbsr      Code_1D47 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_19E7           ldb       #$32      ; load the value needed by the following operation
                    lda       #$67      ; load the value needed by the following operation
                    leax      Data_1674,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_19F4           ldb       #$37      ; load the value needed by the following operation
                    lda       #$67      ; load the value needed by the following operation
                    leax      Data_16A7,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_1A01           ldb       #$3C      ; load the value needed by the following operation
                    lda       #$67      ; load the value needed by the following operation
                    leax      Data_16DA,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_1A0E           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    clrb                ; clear the selected byte or register
Code_1A13           lbsr      Code_1802 ; call the referenced helper routine
                    ldb       #$00      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1C       ; private DeskMate service selector
                    ldb       Data_005B ; load the value needed by the following operation
                    cmpa      #$09      ; compare against the limit and set condition flags
                    bne       Code_1A29 ; branch when the compared values differ
                    incb                ; advance the selected counter
                    cmpb      #$02      ; compare against the limit and set condition flags
                    bls       Code_1A29 ; branch when the unsigned value is at or below the limit
                    ldb       #$02      ; load the value needed by the following operation
Code_1A29           cmpa      #$08      ; compare against the limit and set condition flags
                    bne       Code_1A31 ; branch when the compared values differ
                    decb                ; decrement the selected counter
                    bpl       Code_1A31 ; branch while the tested value is nonnegative
                    clrb                ; clear the selected byte or register
Code_1A31           cmpa      #$0D      ; compare against the limit and set condition flags
                    beq       Code_1A42 ; branch when the compared values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    beq       Code_1A3D ; branch when the compared values are equal
                    cmpa      #$8A      ; compare against the limit and set condition flags
                    bne       Code_1A13 ; branch when the compared values differ
Code_1A3D           ldb       #$FF      ; load the value needed by the following operation
                    lbra      Code_1802 ; continue at the distant control-flow target
Code_1A42           lda       Data_005B ; load the value needed by the following operation
                    lbra      Code_030C ; continue at the distant control-flow target
Code_1A47           cmpb      ,X        ; compare against the limit and set condition flags
                    blt       Code_1A5A ; branch when the signed value is below the limit
                    cmpb      $01,X     ; compare against the limit and set condition flags
                    bgt       Code_1A5A ; branch when the signed value is above the limit
                    cmpa      $02,X     ; compare against the limit and set condition flags
                    blt       Code_1A5A ; branch when the signed value is below the limit
                    cmpa      $03,X     ; compare against the limit and set condition flags
                    bgt       Code_1A5A ; branch when the signed value is above the limit
Code_1A57           ldb       $04,X     ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_1A5A           leax      $05,X     ; form the referenced address without reading memory
                    tst       ,X        ; set condition flags from the current value
                    bmi       Code_1A57 ; branch while the tested value is negative
                    bra       Code_1A47 ; continue at the selected control-flow target
Code_1A62           pshs      Y,X       ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $19       ; private DeskMate service selector
                    stb       Code_0030 ; save the current value in working storage
                    stu       Addr_0006 ; save the current value in working storage
                    pshs      D         ; preserve the listed registers on the stack
                    tfr       U,D       ; copy the source register into the destination register
                    clra                ; clear the selected byte or register
                    std       Addr_0029 ; save the current value in working storage
                    tfr       U,D       ; copy the source register into the destination register
                    lsrb                ; shift right and expose the low bit through carry
                    std       Addr_0004 ; save the current value in working storage
                    puls      D         ; restore the listed registers from the stack
                    sty       Addr_002B ; save the current value in working storage
                    puls      Y,X       ; restore the listed registers from the stack
                    rts                 ; return to the caller
Data_1A80           fcb       $1C       ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $0D,$0E,$00 ; table, bitmap, or initialized data bytes
                    fcc       "25"                           ; embedded text or resource bytes
                    fcb       $0D,$0E,$01 ; table, bitmap, or initialized data bytes
                    fcc       "7:"                           ; embedded text or resource bytes
                    fcb       $0D,$0E,$02 ; table, bitmap, or initialized data bytes
                    fcc       "<?"                           ; embedded text or resource bytes
                    fcb       $0D,$0E,$03,$1A ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $0F,$16,$04,$FF,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$0F   ; table, bitmap, or initialized data bytes
Data_1A9E           fcb       $06,$0B,$00,$01,$00,$10 ; table, bitmap, or initialized data bytes
                    fcb       $17,$00,$01,$01,$1C ; table, bitmap, or initialized data bytes
                    fcc       "#"                            ; embedded text or resource bytes
                    fcb       $00,$01,$02 ; table, bitmap, or initialized data bytes
                    fcc       "69"                           ; embedded text or resource bytes
                    fcb       $00,$01,$03 ; table, bitmap, or initialized data bytes
                    fcc       ";>"                     ;1AB2: 3B 3E          ' ; embedded text or resource bytes
                    fcb       $00,$01,$04 ; table, bitmap, or initialized data bytes
                    fcc       "AD"                           ; embedded text or resource bytes
                    fcb       $00,$01,$05 ; table, bitmap, or initialized data bytes
                    fcc       "FI"                           ; embedded text or resource bytes
                    fcb       $00,$01,$06,$FF,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$0F   ; table, bitmap, or initialized data bytes
Data_1AC6           fcb       $0B,$13,$1B ; table, bitmap, or initialized data bytes
                    fcc       "#+3;C"                  ;1AC9: 23 2B 33 3B 43 '#+3 ; embedded text or resource bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
Data_1ACF           fcb       $0C,$10,$14,$19,$1D,$22 ; table, bitmap, or initialized data bytes
                    fcb       $26,$FF   ; table, bitmap, or initialized data bytes
Code_1AD7           lda       Addr_002A ; load the value needed by the following operation
                    leax      >Data_1AC6,PCR ; form the referenced address without reading memory
                    clrb                ; clear the selected byte or register
                    bra       Code_1AE1 ; continue at the selected control-flow target
Code_1AE0           incb                ; advance the selected counter
Code_1AE1           cmpa      B,X       ; compare against the limit and set condition flags
                    bhi       Code_1AE0 ; branch when the unsigned value is above the limit
                    stb       Addr_002D ; save the current value in working storage
                    beq       Code_1B0F ; branch when the compared values are equal
                    cmpb      #$07      ; compare against the limit and set condition flags
                    bls       Code_1AF0 ; branch when the unsigned value is at or below the limit
                    clrb                ; clear the selected byte or register
                    bra       Code_1B0F ; continue at the selected control-flow target
Code_1AF0           lda       Code_002C ; load the value needed by the following operation
                    leax      >Data_1ACF,PCR ; form the referenced address without reading memory
                    clrb                ; clear the selected byte or register
                    bra       Code_1AFA ; continue at the selected control-flow target
Code_1AF9           incb                ; advance the selected counter
Code_1AFA           cmpa      B,X       ; compare against the limit and set condition flags
                    bhi       Code_1AF9 ; branch when the unsigned value is above the limit
                    stb       Addr_002E ; save the current value in working storage
                    beq       Code_1B0F ; branch when the compared values are equal
                    cmpb      #$06      ; compare against the limit and set condition flags
                    bls       Code_1B09 ; branch when the unsigned value is at or below the limit
                    clrb                ; clear the selected byte or register
                    bra       Code_1B0F ; continue at the selected control-flow target
Code_1B09           decb                ; decrement the selected counter
                    lda       #$07      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    addb      Addr_002D ; add the operand to the running value
Code_1B0F           cmpb      Addr_0021 ; compare against the limit and set condition flags
                    blt       Code_1B1D ; branch when the signed value is below the limit
                    lda       Addr_0021 ; load the value needed by the following operation
                    adda      Data_0036 ; add the operand to the running value
                    stb       ,-S       ; save the current value in working storage
                    cmpa      ,S+       ; compare against the limit and set condition flags
                    bgt       Code_1B1E ; branch when the signed value is above the limit
Code_1B1D           clrb                ; clear the selected byte or register
Code_1B1E           stb       Data_002F ; save the current value in working storage
                    beq       Code_1B4F ; branch when the compared values are equal
                    lda       Code_0028 ; load the value needed by the following operation
                    cmpa      Data_002F ; compare against the limit and set condition flags
                    beq       Code_1B43 ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    tsta                ; set condition flags from the current value
                    beq       Code_1B35 ; branch when the compared values are equal
                    sta       Code_0024 ; save the current value in working storage
                    clrb                ; clear the selected byte or register
                    lbsr      Code_0B1B ; call the referenced helper routine
Code_1B35           lda       Data_002F ; load the value needed by the following operation
                    sta       Code_0024 ; save the current value in working storage
                    sta       Code_0028 ; save the current value in working storage
                    ldb       #$40      ; load the value needed by the following operation
                    lbsr      Code_0B1B ; call the referenced helper routine
                    lbsr      Code_0D87 ; call the referenced helper routine
Code_1B43           lda       Code_0030 ; load the value needed by the following operation
                    cmpa      #$02      ; compare against the limit and set condition flags
                    bne       Code_1B4F ; branch when the compared values differ
                    lbsr      Code_1BF9 ; call the referenced helper routine
                    lbsr      Code_07CB ; call the referenced helper routine
Code_1B4F           clra                ; clear the selected byte or register
                    rts                 ; return to the caller
Data_1B51           fcc       "                "             ; embedded text or resource bytes
Data_1B61           fcc       "                     "        ; embedded text or resource bytes
                    fcc       "                     "        ; embedded text or resource bytes
                    fcc       "                     "        ; embedded text or resource bytes
                    fcc       "                     "        ; embedded text or resource bytes
                    fcc       "                     "        ; embedded text or resource bytes
                    fcc       "       "                      ; embedded text or resource bytes
Code_1BD1           ldx       Data_0040 ; load the value needed by the following operation
                    ldb       #$0D      ; load the value needed by the following operation
                    stb       Data_003F ; save the current value in working storage
                    ldd       Data_0051 ; load the value needed by the following operation
                    std       Data_003D ; save the current value in working storage
                    leay      >Data_1B61,PCR ; form the referenced address without reading memory
                    clr       Data_0048 ; clear the selected byte or register
                    rts                 ; return to the caller
Code_1BE2           ldd       #Addr_000F ; load the value needed by the following operation
                    std       Data_0051 ; save the current value in working storage
                    lda       #$25      ; load the value needed by the following operation
                    sta       Data_003B ;1BE9: 97 3B          '. ; save the current value in working storage
                    bsr       Code_1BD1 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    lda       #$01      ; load the value needed by the following operation
                    sta       Data_0050 ; save the current value in working storage
                    lbsr      Code_2010 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_1BF9           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    ldb       #$FF      ; load the value needed by the following operation
                    lbsr      Code_1802 ; call the referenced helper routine
                    lbsr      Code_1970 ; call the referenced helper routine
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Data_005E ; save the current value in working storage
                    ldx       Data_0040 ; load the value needed by the following operation
                    ldu       #Addr_FFFF ; load the value needed by the following operation
                    lda       #$8C      ; load the value needed by the following operation
Code_1C10           leau      $01,U     ; form the referenced address without reading memory
                    cmpu      #Addr_0190 ; compare against the limit and set condition flags
                    bls       Code_1C1A ; branch when the unsigned value is at or below the limit
                    sta       ,X        ; save the current value in working storage
Code_1C1A           cmpa      ,X+       ; compare against the limit and set condition flags
                    bne       Code_1C10 ; branch when the compared values differ
                    tfr       U,D       ; copy the source register into the destination register
                    cmpd      #DeskMateService ; compare against the limit and set condition flags
                    bne       Code_1C29 ; branch when the compared values differ
                    subd      #Addr_0006 ; subtract the operand from the running value
Code_1C29           addd      Data_0078 ; add the operand to the running value
                    subd      #Addr_0001 ; subtract the operand from the running value
                    cmpd      #Code_018F ; compare against the limit and set condition flags
                    ble       Code_1C37 ; branch when the signed value is at or below the limit
                    ldd       #Code_018F ; load the value needed by the following operation
Code_1C37           ldx       Data_0040 ; load the value needed by the following operation
                    leax      D,X       ; form the referenced address without reading memory
                    stx       Data_0042 ; save the current value in working storage
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Data_0055 ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1E       ; private DeskMate service selector
                    bsr       Code_1BE2 ; call the referenced helper routine
Code_1C47           lda       #$01      ; load the value needed by the following operation
                    sta       Data_0050 ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    lda       #$5A      ; load the value needed by the following operation
                    sta       Data_0053 ; save the current value in working storage
Code_1C53           ldb       #$03      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    lbne      Code_1CEE ; take the distant branch when values differ
                    dec       Data_0053 ; decrement the selected counter
                    bgt       Code_1C53 ; branch when the signed value is above the limit
Code_1C61           lbsr      Code_1A62 ; call the referenced helper routine
                    lbsr      Code_190C ; call the referenced helper routine
                    ldb       Code_0030 ; load the value needed by the following operation
                    beq       Code_1CE0 ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1B       ; private DeskMate service selector
                    cmpb      #$01      ; compare against the limit and set condition flags
                    beq       Code_1C85 ; branch when the compared values are equal
                    cmpb      #$02      ; compare against the limit and set condition flags
                    beq       Code_1CC0 ; branch when the compared values are equal
                    cmpb      #$03      ; compare against the limit and set condition flags
                    beq       Code_1C85 ; branch when the compared values are equal
                    cmpb      #$05      ; compare against the limit and set condition flags
                    beq       Code_1CD0 ; branch when the compared values are equal
                    bra       Code_1C61 ; continue at the selected control-flow target
Code_1C85           ldb       Code_002C ; load the value needed by the following operation
                    cmpb      #$1E      ; compare against the limit and set condition flags
                    bls       Code_1CFC ; branch when the unsigned value is at or below the limit
                    lda       Addr_002A ; load the value needed by the following operation
                    cmpa      #$12      ; compare against the limit and set condition flags
                    bls       Code_1CFC ; branch when the unsigned value is at or below the limit
                    ldb       Data_005E ; load the value needed by the following operation
                    beq       Code_1CFC ; branch when the compared values are equal
                    cmpb      #$01      ; compare against the limit and set condition flags
                    bne       Code_1CAB ; branch when the compared values differ
Code_1C99           lbsr      Code_216D ; call the referenced helper routine
                    lda       #$01      ; load the value needed by the following operation
                    sta       Data_1514,PCR ; save the current value in working storage
                    lbsr      Code_1517 ; call the referenced helper routine
                    lbsr      Code_07CB ; call the referenced helper routine
                    lbra      Code_1BF9 ; continue at the distant control-flow target
Code_1CAB           cmpb      #$02      ; compare against the limit and set condition flags
                    lbeq      Code_1D54 ; take the distant branch when values are equal
                    cmpb      #$03      ; compare against the limit and set condition flags
                    lbeq      Code_1D94 ; take the distant branch when values are equal
                    cmpb      #$04      ; compare against the limit and set condition flags
                    bne       Code_1CBE ; branch when the compared values differ
                    lbsr      Code_213A ; call the referenced helper routine
Code_1CBE           bra       Code_1C61 ; continue at the selected control-flow target
Code_1CC0           ldb       Data_005E ; load the value needed by the following operation
                    cmpb      #$02      ; compare against the limit and set condition flags
                    lbeq      Code_1D67 ; take the distant branch when values are equal
                    cmpb      #$03      ; compare against the limit and set condition flags
                    lbeq      Code_1DA5 ; take the distant branch when values are equal
                    bra       Code_1C61 ; continue at the selected control-flow target
Code_1CD0           ldb       Data_005E ; load the value needed by the following operation
                    cmpb      #$02      ; compare against the limit and set condition flags
                    lbeq      Code_1DF5 ; take the distant branch when values are equal
                    cmpb      #$03      ; compare against the limit and set condition flags
                    lbeq      Code_1DFE ; take the distant branch when values are equal
                    bra       Code_1C61 ; continue at the selected control-flow target
Code_1CE0           ldb       #$83      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    lbeq      Code_1C61 ; take the distant branch when values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
Code_1CEE           sta       Data_003C ; save the current value in working storage
                    cmpa      #$AF      ; compare against the limit and set condition flags
                    beq       Code_1C99 ; branch when the compared values are equal
                    cmpa      #$8C      ; compare against the limit and set condition flags
                    beq       Code_1CFC ; branch when the compared values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    bne       Code_1D08 ; branch when the compared values differ
Code_1CFC           lbsr      Code_216D ; call the referenced helper routine
                    ldx       Data_0040 ; load the value needed by the following operation
                    leax      $018F,X   ; form the referenced address without reading memory
                    stx       Data_0042 ; save the current value in working storage
                    rts                 ; return to the caller
Code_1D08           cmpa      #$08      ; compare against the limit and set condition flags
                    bne       Code_1D10 ; branch when the compared values differ
                    lda       #$01      ; load the value needed by the following operation
                    bra       Code_1D56 ; continue at the selected control-flow target
Code_1D10           cmpa      #$88      ; compare against the limit and set condition flags
                    bne       Code_1D37 ; branch when the compared values differ
Code_1D14           ldb       #$00      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    bne       Code_1D14 ; branch when the compared values differ
                    cmpx      Data_0040 ; compare against the limit and set condition flags
                    beq       Code_1D34 ; branch when the compared values are equal
                    lbsr      Code_1EBB ; call the referenced helper routine
                    lda       #$20      ; load the value needed by the following operation
                    sta       ,X        ; save the current value in working storage
                    tst       Data_0055 ; set condition flags from the current value
                    bmi       Code_1D2E ; branch while the tested value is negative
                    lbsr      Code_2123 ; call the referenced helper routine
Code_1D2E           lbsr      Code_1FF4 ; call the referenced helper routine
                    lbsr      Code_2010 ; call the referenced helper routine
Code_1D34           lbra      Code_1C47 ; continue at the distant control-flow target
Code_1D37           cmpa      #$09      ; compare against the limit and set condition flags
                    bne       Code_1D50 ; branch when the compared values differ
                    lda       #$01      ; load the value needed by the following operation
                    sta       Data_0053 ; save the current value in working storage
                    lbsr      Code_1E69 ; call the referenced helper routine
Code_1D42           bsr       Code_1D47 ; call the referenced helper routine
                    lbra      Code_1C47 ; continue at the distant control-flow target
Code_1D47           ldb       Data_003F ; load the value needed by the following operation
                    lda       Data_003E ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_1D50           cmpa      #$0C      ; compare against the limit and set condition flags
                    bne       Code_1D63 ; branch when the compared values differ
Code_1D54           lda       #$19      ; load the value needed by the following operation
Code_1D56           sta       Data_0053 ; save the current value in working storage
                    inc       Data_0050 ; advance the selected counter
Code_1D5A           lbsr      Code_1EBB ; call the referenced helper routine
                    dec       Data_0053 ; decrement the selected counter
                    bne       Code_1D5A ; branch when the compared values differ
                    bra       Code_1D42 ; continue at the selected control-flow target
Code_1D63           cmpa      #$1C      ; compare against the limit and set condition flags
                    bne       Code_1D90 ; branch when the compared values differ
Code_1D67           clr       Data_0050 ; clear the selected byte or register
                    ldd       Data_003D ; load the value needed by the following operation
                    subd      #Addr_000F ; subtract the operand from the running value
                    bgt       Code_1D7D ; branch when the signed value is above the limit
                    ldd       #Addr_000F ; load the value needed by the following operation
                    subd      Data_0051 ; subtract the operand from the running value
                    cmpd      #Addr_0008 ; compare against the limit and set condition flags
                    bls       Code_1D7D ; branch when the unsigned value is at or below the limit
                    ldb       #$08      ; load the value needed by the following operation
Code_1D7D           decb                ; decrement the selected counter
                    blt       Code_1D8E ; branch when the signed value is below the limit
                    lda       #$19      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    stb       Data_0053 ; save the current value in working storage
                    bra       Code_1D8C ; continue at the selected control-flow target
Code_1D87           lbsr      Code_1EBB ; call the referenced helper routine
                    dec       Data_0053 ; decrement the selected counter
Code_1D8C           bne       Code_1D87 ; branch when the compared values differ
Code_1D8E           bra       Code_1D54 ; continue at the selected control-flow target
Code_1D90           cmpa      #$0A      ; compare against the limit and set condition flags
                    bne       Code_1DA1 ; branch when the compared values differ
Code_1D94           lda       #$19      ; load the value needed by the following operation
                    sta       Data_0053 ; save the current value in working storage
Code_1D98           lbsr      Code_1E69 ; call the referenced helper routine
                    dec       Data_0053 ; decrement the selected counter
                    bne       Code_1D98 ; branch when the compared values differ
                    bra       Code_1D42 ; continue at the selected control-flow target
Code_1DA1           cmpa      #$1A      ; compare against the limit and set condition flags
                    bne       Code_1DC6 ; branch when the compared values differ
Code_1DA5           clr       Data_0050 ; clear the selected byte or register
                    ldd       #Code_0016 ; load the value needed by the following operation
                    subd      Data_003D ; subtract the operand from the running value
                    bgt       Code_1DB0 ; branch when the signed value is above the limit
                    ldb       #$08      ; load the value needed by the following operation
Code_1DB0           lda       #$19      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    stb       Data_0053 ; save the current value in working storage
                    bra       Code_1DBC ; continue at the selected control-flow target
Code_1DB7           lbsr      Code_1E69 ; call the referenced helper routine
                    dec       Data_0053 ; decrement the selected counter
Code_1DBC           bne       Code_1DB7 ; branch when the compared values differ
                    inc       Data_0050 ; advance the selected counter
                    lbsr      Code_2010 ; call the referenced helper routine
                    lbra      Code_1D42 ; continue at the distant control-flow target
Code_1DC6           cmpa      #$0D      ; compare against the limit and set condition flags
                    bne       Code_1DDF ; branch when the compared values differ
                    lda       Data_0055 ; load the value needed by the following operation
                    pshs      A         ; preserve the listed registers on the stack
                    lda       #$01      ; load the value needed by the following operation
                    sta       Data_0055 ; save the current value in working storage
                    lda       #$8B      ; load the value needed by the following operation
                    sta       Data_003C ; save the current value in working storage
                    lbsr      Code_1E25 ; call the referenced helper routine
                    puls      A         ; restore the listed registers from the stack
                    sta       Data_0055 ; save the current value in working storage
                    bra       Code_1E18 ; continue at the selected control-flow target
Code_1DDF           cmpa      #$E9      ; compare against the limit and set condition flags
                    beq       Code_1DE7 ; branch when the compared values are equal
                    cmpa      #$E9      ; compare against the limit and set condition flags
                    bne       Code_1DF1 ; branch when the compared values differ
Code_1DE7           neg       Data_0055 ; form the two's-complement negative value
                    lda       Data_0055 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1E       ; private DeskMate service selector
                    bra       Code_1E18 ; continue at the selected control-flow target
Code_1DF1           cmpa      #$13      ; compare against the limit and set condition flags
                    bne       Code_1DFA ; branch when the compared values differ
Code_1DF5           lbsr      Code_1BE2 ; call the referenced helper routine
                    bra       Code_1E18 ; continue at the selected control-flow target
Code_1DFA           cmpa      #$12      ; compare against the limit and set condition flags
                    bne       Code_1E16 ; branch when the compared values differ
Code_1DFE           clr       Data_0050 ; clear the selected byte or register
                    lda       #$C8      ; load the value needed by the following operation
                    sta       Data_0053 ; save the current value in working storage
                    bra       Code_1E09 ; continue at the selected control-flow target
Code_1E06           lbsr      Code_1E69 ; call the referenced helper routine
Code_1E09           lda       ,X        ; load the value needed by the following operation
                    cmpa      #$8C      ; compare against the limit and set condition flags
                    bne       Code_1E06 ; branch when the compared values differ
                    inc       Data_0050 ; advance the selected counter
                    lbsr      Code_2010 ; call the referenced helper routine
                    bra       Code_1E18 ; continue at the selected control-flow target
Code_1E16           bsr       Code_1E1B ; call the referenced helper routine
Code_1E18           lbra      Code_1C47 ; continue at the distant control-flow target
Code_1E1B           lda       Data_003C ; load the value needed by the following operation
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bcs       Code_1E43 ; branch when carry reports an unsigned underflow or error
                    cmpa      #$7E      ; compare against the limit and set condition flags
                    bhi       Code_1E43 ; branch when the unsigned value is above the limit
Code_1E25           cmpx      Data_0042 ; compare against the limit and set condition flags
                    bhi       Code_1E2D ; branch when the unsigned value is above the limit
                    bsr       Code_1E44 ; call the referenced helper routine
                    cmpx      Data_0042 ; compare against the limit and set condition flags
Code_1E2D           lbhi      Code_2010 ; take the distant branch for unsigned higher
                    lda       #$8C      ; load the value needed by the following operation
                    cmpa      ,X        ; compare against the limit and set condition flags
                    bne       Code_1E39 ; branch when the compared values differ
                    sta       $01,X     ; save the current value in working storage
Code_1E39           lda       Data_003C ; load the value needed by the following operation
                    sta       ,X+       ; store the value and advance the destination pointer
                    lbsr      Code_1FA1 ; call the referenced helper routine
                    lbsr      Code_2018 ; call the referenced helper routine
Code_1E43           rts                 ; return to the caller
Code_1E44           ldb       Data_003F ; load the value needed by the following operation
                    cmpb      #$25      ; compare against the limit and set condition flags
                    beq       Code_1E61 ; branch when the compared values are equal
                    subb      Data_004E ; subtract the operand from the running value
                    blt       Code_1E61 ; branch when the signed value is below the limit
                    stb       ,-S       ; save the current value in working storage
Code_1E50           lbsr      Code_210C ; call the referenced helper routine
                    lda       #$20      ; load the value needed by the following operation
                    sta       ,X        ; save the current value in working storage
                    inc       Data_004E ; advance the selected counter
                    decb                ; decrement the selected counter
                    bge       Code_1E50 ; branch when the signed value is at least the limit
                    ldb       ,S+       ; load the value needed by the following operation
                    leax      B,X       ; form the referenced address without reading memory
                    rts                 ; return to the caller
Code_1E61           tst       Data_0055 ; set condition flags from the current value
                    bmi       Code_1E68 ; branch while the tested value is negative
                    lbsr      Code_210C ; call the referenced helper routine
Code_1E68           rts                 ; return to the caller
Code_1E69           cmpx      Data_0042 ; compare against the limit and set condition flags
                    bhi       Code_1E90 ; branch when the unsigned value is above the limit
                    lda       ,X        ; load the value needed by the following operation
                    cmpa      #$8C      ; compare against the limit and set condition flags
                    beq       Code_1E90 ; branch when the compared values are equal
                    lbsr      Code_1F90 ; call the referenced helper routine
                    lda       Data_0050 ; load the value needed by the following operation
                    pshs      A         ; preserve the listed registers on the stack
                    clr       Data_0050 ; clear the selected byte or register
                    bsr       Code_1EDD ; call the referenced helper routine
                    puls      A         ; restore the listed registers from the stack
                    sta       Data_0050 ; save the current value in working storage
                    cmpb      #$0D      ; compare against the limit and set condition flags
                    bne       Code_1E88 ; branch when the compared values differ
                    bsr       Code_1E91 ; call the referenced helper routine
Code_1E88           ldb       Data_003F ; load the value needed by the following operation
                    cmpb      Data_004E ; compare against the limit and set condition flags
                    bls       Code_1E90 ; branch when the unsigned value is at or below the limit
                    leax      -$01,X    ; form the referenced address without reading memory
Code_1E90           rts                 ; return to the caller
Code_1E91           lda       Data_0053 ; load the value needed by the following operation
                    cmpa      #$19      ; compare against the limit and set condition flags
                    bhi       Code_1E9D ; branch when the unsigned value is above the limit
                    inc       Data_0050 ; advance the selected counter
                    lbsr      Code_2010 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_1E9D           clrb                ; clear the selected byte or register
Code_1E9E           lda       B,X       ; load the value needed by the following operation
                    cmpa      #$8B      ; compare against the limit and set condition flags
                    beq       Code_1EB6 ; branch when the compared values are equal
                    incb                ; advance the selected counter
                    cmpb      #$18      ; compare against the limit and set condition flags
                    bls       Code_1E9E ; branch when the unsigned value is at or below the limit
                    ldb       #$18      ; load the value needed by the following operation
Code_1EAB           lda       B,X       ; load the value needed by the following operation
                    cmpa      #$20      ; compare against the limit and set condition flags
                    beq       Code_1EB6 ; branch when the compared values are equal
                    decb                ; decrement the selected counter
                    bge       Code_1EAB ; branch when the signed value is at least the limit
                    ldb       #$17      ; load the value needed by the following operation
Code_1EB6           addb      #$0D      ; add the operand to the running value
                    stb       Data_004E ; save the current value in working storage
                    rts                 ; return to the caller
Code_1EBB           ldb       Data_003F ; load the value needed by the following operation
                    cmpb      #$0D      ; compare against the limit and set condition flags
                    bhi       Code_1EC5 ; branch when the unsigned value is above the limit
                    cmpx      Data_0040 ; compare against the limit and set condition flags
                    bls       Code_1EDC ; branch when the unsigned value is at or below the limit
Code_1EC5           lbsr      Code_1F7D ; call the referenced helper routine
                    cmpb      #$25      ; compare against the limit and set condition flags
                    bne       Code_1ED4 ; branch when the compared values differ
                    lbsr      Code_2010 ; call the referenced helper routine
                    ldb       #$25      ; load the value needed by the following operation
                    stb       Data_003F ; save the current value in working storage
                    rts                 ; return to the caller
Code_1ED4           ldb       Data_003F ; load the value needed by the following operation
                    cmpb      Data_004E ; compare against the limit and set condition flags
                    bcs       Code_1EDC ; branch when carry reports an unsigned underflow or error
                    leax      $01,X     ; form the referenced address without reading memory
Code_1EDC           rts                 ; return to the caller
Code_1EDD           leay      $01,Y     ; form the referenced address without reading memory
                    leax      $01,X     ; form the referenced address without reading memory
                    ldb       Data_003F ; load the value needed by the following operation
                    incb                ; advance the selected counter
                    cmpb      Data_003B ;1EE4: D1 3B          '. ; compare against the limit and set condition flags
                    bls       Code_1EF4 ; branch when the unsigned value is at or below the limit
                    lbsr      Code_2097 ; call the referenced helper routine
                    ldd       Data_003D ; load the value needed by the following operation
                    addd      #Addr_0001 ; add the operand to the running value
                    std       Data_003D ; save the current value in working storage
                    ldb       #$0D      ; load the value needed by the following operation
Code_1EF4           stb       Data_003F ; save the current value in working storage
                    rts                 ; return to the caller
Code_1EF7           inc       Data_0048 ; advance the selected counter
                    ldb       ,X        ; load the value needed by the following operation
                    cmpb      #$20      ; compare against the limit and set condition flags
                    beq       Code_1F0D ; branch when the compared values are equal
                    cmpb      #$8C      ; compare against the limit and set condition flags
                    bne       Code_1F0F ; branch when the compared values differ
                    tst       Data_004F ; set condition flags from the current value
                    beq       Code_1F0D ; branch when the compared values are equal
                    ldb       Data_003F ; load the value needed by the following operation
                    stb       Data_004E ; save the current value in working storage
                    clr       Data_004F ; clear the selected byte or register
Code_1F0D           clr       Data_0048 ; clear the selected byte or register
Code_1F0F           cmpb      #$8B      ; compare against the limit and set condition flags
                    beq       Code_1F44 ; branch when the compared values are equal
                    ldb       Data_003F ; load the value needed by the following operation
                    cmpb      Data_003B ;1F15: D1 3B          '. ; compare against the limit and set condition flags
                    bne       Code_1F40 ; branch when the compared values differ
                    ldb       Data_003B ;1F19: D6 3B          '. ; load the value needed by the following operation
                    subb      #$0D      ; subtract the operand from the running value
                    cmpb      Data_0048 ; compare against the limit and set condition flags
                    bcc       Code_1F25 ; branch when carry is clear
                    ldb       #$01      ; load the value needed by the following operation
                    stb       Data_0048 ; save the current value in working storage
Code_1F25           ldb       Data_0048 ; load the value needed by the following operation
                    bsr       Code_1F60 ; call the referenced helper routine
                    lbsr      Code_1EDD ; call the referenced helper routine
                    ldb       Data_0048 ; load the value needed by the following operation
                    negb                ; form the two's-complement negative value
                    leax      B,X       ; form the referenced address without reading memory
                    bra       Code_1F3C ; continue at the selected control-flow target
Code_1F33           lbsr      Code_2086 ; call the referenced helper routine
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,Y+       ; store the value and advance the destination pointer
                    inc       Data_003F ; advance the selected counter
Code_1F3C           incb                ; advance the selected counter
                    ble       Code_1F33 ; branch when the signed value is at or below the limit
                    rts                 ; return to the caller
Code_1F40           lbsr      Code_1EDD ; call the referenced helper routine
                    rts                 ; return to the caller
Code_1F44           ldb       Data_003B ;1F44: D6 3B          '. ; load the value needed by the following operation
                    subb      Data_003F ; subtract the operand from the running value
                    stb       Data_0048 ; save the current value in working storage
                    negb                ; form the two's-complement negative value
                    bsr       Code_1F65 ; call the referenced helper routine
                    clr       Data_0048 ; clear the selected byte or register
                    leax      $01,X     ; form the referenced address without reading memory
                    lbsr      Code_2097 ; call the referenced helper routine
                    ldd       Data_003D ; load the value needed by the following operation
                    addd      #Addr_0001 ; add the operand to the running value
                    std       Data_003D ; save the current value in working storage
                    ldb       #$0D      ; load the value needed by the following operation
                    stb       Data_003F ; save the current value in working storage
                    rts                 ; return to the caller
Code_1F60           ldb       Data_0048 ; load the value needed by the following operation
                    negb                ; form the two's-complement negative value
                    leay      B,Y       ; form the referenced address without reading memory
Code_1F65           leay      $01,Y     ; form the referenced address without reading memory
                    tst       Data_004F ; set condition flags from the current value
                    beq       Code_1F71 ; branch when the compared values are equal
                    addb      Data_003B ;1F6B: DB 3B          '. ; add the operand to the running value
                    stb       Data_004E ; save the current value in working storage
                    clr       Data_004F ; clear the selected byte or register
Code_1F71           lda       #$20      ; load the value needed by the following operation
                    ldb       Data_0048 ; load the value needed by the following operation
                    bra       Code_1F7A ; continue at the selected control-flow target
Code_1F77           sta       ,Y+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
Code_1F7A           bgt       Code_1F77 ; branch when the signed value is above the limit
                    rts                 ; return to the caller
Code_1F7D           leay      -$01,Y    ; form the referenced address without reading memory
                    leax      -$01,X    ; form the referenced address without reading memory
                    ldb       Data_003F ; load the value needed by the following operation
                    decb                ; decrement the selected counter
                    cmpb      #$0D      ; compare against the limit and set condition flags
                    bcc       Code_1F8D ; branch when carry is clear
                    lbsr      Code_1FF4 ; call the referenced helper routine
                    ldb       Data_003B ;1F8B: D6 3B          '. ; load the value needed by the following operation
Code_1F8D           stb       Data_003F ; save the current value in working storage
                    rts                 ; return to the caller
Code_1F90           ldb       Data_003F ; load the value needed by the following operation
                    cmpb      #$25      ; compare against the limit and set condition flags
                    blt       Code_1FA0 ; branch when the signed value is below the limit
                    ldd       Data_003D ; load the value needed by the following operation
                    cmpd      #Code_0016 ; compare against the limit and set condition flags
                    blt       Code_1FA0 ; branch when the signed value is below the limit
                    bsr       Code_1FEC ; call the referenced helper routine
Code_1FA0           rts                 ; return to the caller
Code_1FA1           ldd       Data_003D ; load the value needed by the following operation
                    cmpd      #Code_0016 ; compare against the limit and set condition flags
                    blt       Code_1FEB ; branch when the signed value is below the limit
                    pshs      X         ; preserve the listed registers on the stack
                    lda       Data_003C ; load the value needed by the following operation
                    cmpa      #$8B      ; compare against the limit and set condition flags
                    beq       Code_1FE7 ; branch when the compared values are equal
                    ldb       #$25      ; load the value needed by the following operation
                    subb      Data_003F ; subtract the operand from the running value
                    beq       Code_1FE7 ; branch when the compared values are equal
                    lda       #$20      ; load the value needed by the following operation
                    ldb       #$0D      ; load the value needed by the following operation
                    subb      Data_003F ; subtract the operand from the running value
Code_1FBD           cmpa      B,X       ; compare against the limit and set condition flags
                    beq       Code_1FD2 ; branch when the compared values are equal
                    incb                ; advance the selected counter
                    ble       Code_1FBD ; branch when the signed value is at or below the limit
                    ldb       Data_003F ; load the value needed by the following operation
                    cmpb      #$24      ; compare against the limit and set condition flags
                    bne       Code_1FE9 ; branch when the compared values differ
                    lda       ,X        ; load the value needed by the following operation
                    cmpa      #$8C      ; compare against the limit and set condition flags
                    bne       Code_1FE7 ; branch when the compared values differ
                    bra       Code_1FE9 ; continue at the selected control-flow target
Code_1FD2           ldb       #$25      ; load the value needed by the following operation
                    subb      Data_003F ; subtract the operand from the running value
Code_1FD6           lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpa      #$20      ; compare against the limit and set condition flags
                    beq       Code_1FE9 ; branch when the compared values are equal
                    cmpa      #$8B      ; compare against the limit and set condition flags
                    beq       Code_1FE9 ; branch when the compared values are equal
                    cmpa      #$8C      ; compare against the limit and set condition flags
                    beq       Code_1FE9 ; branch when the compared values are equal
                    decb                ; decrement the selected counter
                    bgt       Code_1FD6 ; branch when the signed value is above the limit
Code_1FE7           bsr       Code_1FEC ; call the referenced helper routine
Code_1FE9           puls      X         ; restore the listed registers from the stack
Code_1FEB           rts                 ; return to the caller
Code_1FEC           ldd       Data_0051 ; load the value needed by the following operation
                    subd      #Addr_0001 ; subtract the operand from the running value
                    std       Data_0051 ; save the current value in working storage
                    rts                 ; return to the caller
Code_1FF4           ldd       Data_003D ; load the value needed by the following operation
                    cmpd      #Addr_000F ; compare against the limit and set condition flags
                    bgt       Code_2008 ; branch when the signed value is above the limit
                    cmpd      Data_0051 ; compare against the limit and set condition flags
                    ble       Code_200F ; branch when the signed value is at or below the limit
                    ldd       Data_0051 ; load the value needed by the following operation
                    addd      #Addr_0001 ; add the operand to the running value
                    std       Data_0051 ; save the current value in working storage
Code_2008           ldd       Data_003D ; load the value needed by the following operation
                    subd      #Addr_0001 ; subtract the operand from the running value
                    std       Data_003D ; save the current value in working storage
Code_200F           rts                 ; return to the caller
Code_2010           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    stx       Data_0049 ; save the current value in working storage
                    bra       Code_202E ; continue at the selected control-flow target
Code_2018           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    stx       Data_0049 ; save the current value in working storage
                    ldb       Data_003C ; load the value needed by the following operation
Code_2020           cmpb      #$8B      ; compare against the limit and set condition flags
                    beq       Code_202E ; branch when the compared values are equal
                    cmpb      #$20      ; compare against the limit and set condition flags
                    beq       Code_202E ; branch when the compared values are equal
                    ldb       Data_004E ; load the value needed by the following operation
                    cmpb      #$24      ; compare against the limit and set condition flags
                    bls       Code_2036 ; branch when the unsigned value is at or below the limit
Code_202E           lbsr      Code_1BD1 ; call the referenced helper routine
Code_2031           ldd       #Code_0016 ; load the value needed by the following operation
                    bra       Code_2058 ; continue at the selected control-flow target
Code_2036           cmpx      Data_0040 ; compare against the limit and set condition flags
                    bls       Code_2040 ; branch when the unsigned value is at or below the limit
                    ldb       #$0C      ; load the value needed by the following operation
                    subb      Data_003F ; subtract the operand from the running value
                    leax      B,X       ; form the referenced address without reading memory
Code_2040           ldb       #$0D      ; load the value needed by the following operation
                    stb       Data_003F ; save the current value in working storage
                    leay      Data_1B61,PCR ; form the referenced address without reading memory
                    clr       Data_0048 ; clear the selected byte or register
                    ldu       Data_0042 ; load the value needed by the following operation
                    ldb       $01,U     ; load the value needed by the following operation
                    cmpb      #$8C      ; compare against the limit and set condition flags
                    bne       Code_2056 ; branch when the compared values differ
                    tst       Data_0055 ; set condition flags from the current value
                    bne       Code_2031 ; branch when the compared values differ
Code_2056           ldd       Data_003D ; load the value needed by the following operation
Code_2058           std       Data_0059 ; save the current value in working storage
                    clr       Data_0056 ; clear the selected byte or register
                    clr       Data_0057 ; clear the selected byte or register
                    bra       Code_2067 ; continue at the selected control-flow target
Code_2060           lda       ,X        ; load the value needed by the following operation
                    sta       ,Y        ; save the current value in working storage
                    lbsr      Code_1EF7 ; call the referenced helper routine
Code_2067           lbsr      Code_2086 ; call the referenced helper routine
                    cmpx      Data_0049 ; compare against the limit and set condition flags
                    bls       Code_2060 ; branch when the unsigned value is at or below the limit
                    ldd       Data_0056 ; load the value needed by the following operation
                    cmpd      Data_0059 ; compare against the limit and set condition flags
                    blt       Code_2060 ; branch when the signed value is below the limit
                    ldd       Data_004C ; load the value needed by the following operation
                    std       Data_003D ; save the current value in working storage
                    tfr       B,A       ; copy the source register into the destination register
                    ldb       Data_004B ; load the value needed by the following operation
                    stb       Data_003F ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    ldx       Data_0049 ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_2086           cmpx      Data_0049 ; compare against the limit and set condition flags
                    bne       Code_2096 ; branch when the compared values differ
                    lda       Data_003F ; load the value needed by the following operation
                    sta       Data_004B ; save the current value in working storage
                    ldd       Data_003D ; load the value needed by the following operation
                    std       Data_004C ; save the current value in working storage
                    lda       #$01      ; load the value needed by the following operation
                    sta       Data_004F ; save the current value in working storage
Code_2096           rts                 ; return to the caller
Code_2097           pshs      X,D       ; preserve the listed registers on the stack
                    tst       Data_0050 ; set condition flags from the current value
                    beq       Code_2102 ; branch when the compared values are equal
                    bpl       Code_20A4 ; branch while the tested value is nonnegative
                    lbsr      Code_25FE ; call the referenced helper routine
                    bra       Code_2106 ; continue at the selected control-flow target
Code_20A4           ldd       Data_003D ; load the value needed by the following operation
                    cmpd      #Addr_000F ; compare against the limit and set condition flags
                    blt       Code_2102 ; branch when the signed value is below the limit
                    tfr       B,A       ; copy the source register into the destination register
                    ldb       #$0D      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    leax      Data_1B61,PCR ; form the referenced address without reading memory
                    clrb                ; clear the selected byte or register
                    ldy       #Addr_0019 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $22       ; private DeskMate service selector
                    leax      Data_1B61,PCR ; form the referenced address without reading memory
                    ldb       #$19      ; load the value needed by the following operation
Code_20C7           lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpa      #$8C      ; compare against the limit and set condition flags
                    beq       Code_20D2 ; branch when the compared values are equal
                    decb                ; decrement the selected counter
                    bne       Code_20C7 ; branch when the compared values differ
                    bra       Code_2102 ; continue at the selected control-flow target
Code_20D2           leax      Data_1B61,PCR ; form the referenced address without reading memory
                    ldb       #$19      ; load the value needed by the following operation
                    lda       #$20      ; load the value needed by the following operation
Code_20DA           sta       ,X+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bne       Code_20DA ; branch when the compared values differ
Code_20DF           ldd       Data_003D ; load the value needed by the following operation
                    addd      #Addr_0001 ; add the operand to the running value
                    std       Data_003D ; save the current value in working storage
                    cmpd      Data_0059 ; compare against the limit and set condition flags
                    bgt       Code_2102 ; branch when the signed value is above the limit
                    tfr       B,A       ; copy the source register into the destination register
                    ldb       #$0D      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    leax      Data_1B61,PCR ; form the referenced address without reading memory
                    clrb                ; clear the selected byte or register
                    ldy       #Addr_0019 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $22       ; private DeskMate service selector
                    bra       Code_20DF ; continue at the selected control-flow target
Code_2102           ldd       Data_003D ; load the value needed by the following operation
                    std       Data_0056 ; save the current value in working storage
Code_2106           leay      Data_1B61,PCR ; form the referenced address without reading memory
                    puls      PC,X,D    ; restore the listed registers from the stack
Code_210C           stx       ,--S      ; save the current value in working storage
                    ldx       Data_0042 ; load the value needed by the following operation
                    lda       ,X        ; load the value needed by the following operation
                    cmpa      #$8C      ; compare against the limit and set condition flags
                    bne       Code_211A ; branch when the compared values differ
Code_2116           lda       ,X        ; load the value needed by the following operation
                    sta       $01,X     ; save the current value in working storage
Code_211A           leax      -$01,X    ; form the referenced address without reading memory
                    cmpx      ,S        ; compare against the limit and set condition flags
                    bcc       Code_2116 ; branch when carry is clear
                    ldx       ,S++      ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_2123           lda       ,X        ; load the value needed by the following operation
                    cmpa      #$8C      ; compare against the limit and set condition flags
                    beq       Code_2139 ; branch when the compared values are equal
                    stx       ,--S      ; save the current value in working storage
Code_212B           lda       $01,X     ; load the value needed by the following operation
                    sta       ,X+       ; store the value and advance the destination pointer
                    cmpx      Data_0042 ; compare against the limit and set condition flags
                    bls       Code_212B ; branch when the unsigned value is at or below the limit
                    lda       $01,X     ; load the value needed by the following operation
                    sta       ,X        ; save the current value in working storage
                    ldx       ,S++      ; load the value needed by the following operation
Code_2139           rts                 ; return to the caller
Code_213A           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1B       ; private DeskMate service selector
                    lda       #$C8      ; load the value needed by the following operation
                    sta       Data_0053 ; save the current value in working storage
                    ldd       Data_003E ; load the value needed by the following operation
                    cmpd      Addr_0004 ; compare against the limit and set condition flags
                    bcs       Code_215B ; branch when carry reports an unsigned underflow or error
                    beq       Code_216C ; branch when the compared values are equal
Code_214B           lbsr      Code_1EBB ; call the referenced helper routine
                    dec       Data_0053 ; decrement the selected counter
                    beq       Code_2169 ; branch when the compared values are equal
                    ldd       Data_003E ; load the value needed by the following operation
                    cmpd      Addr_0004 ; compare against the limit and set condition flags
                    bne       Code_214B ; branch when the compared values differ
                    bra       Code_2169 ; continue at the selected control-flow target
Code_215B           lbsr      Code_1E69 ; call the referenced helper routine
                    dec       Data_0053 ; decrement the selected counter
                    beq       Code_2169 ; branch when the compared values are equal
                    ldd       Data_003E ; load the value needed by the following operation
                    cmpd      Addr_0004 ; compare against the limit and set condition flags
                    bne       Code_215B ; branch when the compared values differ
Code_2169           lbsr      Code_1D47 ; call the referenced helper routine
Code_216C           rts                 ; return to the caller
Code_216D           lbsr      Code_2212 ; call the referenced helper routine
                    ldu       #DeskMateService ; load the value needed by the following operation
                    ldx       Data_0040 ; load the value needed by the following operation
Code_2175           lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpa      #$8C      ; compare against the limit and set condition flags
                    beq       Code_2184 ; branch when the compared values are equal
                    leau      $01,U     ; form the referenced address without reading memory
                    cmpu      #Addr_0191 ; compare against the limit and set condition flags
                    bls       Code_2175 ; branch when the unsigned value is at or below the limit
Code_2183           rts                 ; return to the caller
Code_2184           stu       Data_006C ; save the current value in working storage
                    beq       Code_2183 ; branch when the compared values are equal
                    ldu       Data_0076 ; load the value needed by the following operation
                    leax      -$06,U    ; form the referenced address without reading memory
                    ldd       Data_0072 ; load the value needed by the following operation
                    std       ,X        ; save the current value in working storage
                    stx       Data_0076 ; save the current value in working storage
                    bra       Code_219A ; continue at the selected control-flow target
Code_2194           addd      Data_006C ; add the operand to the running value
                    pshu      Y,X,D     ; preserve the listed registers on the stack
                    leau      $0C,U     ; form the referenced address without reading memory
Code_219A           pulu      Y,X,D     ; restore the listed registers from the stack
                    leau      -$06,U    ; form the referenced address without reading memory
                    cmpx      Data_0090 ; compare against the limit and set condition flags
                    bhi       Code_2194 ; branch when the unsigned value is above the limit
                    bcs       Code_21A9 ; branch when carry reports an unsigned underflow or error
                    cmpy      Data_0092 ; compare against the limit and set condition flags
                    bhi       Code_2194 ; branch when the unsigned value is above the limit
Code_21A9           ldx       Data_0090 ; load the value needed by the following operation
                    ldy       Data_0092 ; load the value needed by the following operation
                    pshu      Y,X       ; preserve the listed registers on the stack
                    ldx       -$02,U    ; load the value needed by the following operation
                    stx       Data_006E ; save the current value in working storage
                    ldx       Data_0072 ; load the value needed by the following operation
                    ldd       Data_006C ; load the value needed by the following operation
                    leau      D,X       ; form the referenced address without reading memory
                    bra       Code_21C0 ; continue at the selected control-flow target
Code_21BC           lda       ,-X       ; load the value needed by the following operation
                    sta       ,-U       ; save the current value in working storage
Code_21C0           cmpx      Data_006E ; compare against the limit and set condition flags
                    bhi       Code_21BC ; branch when the unsigned value is above the limit
                    ldu       Data_0040 ; load the value needed by the following operation
                    bra       Code_21CA ; continue at the selected control-flow target
Code_21C8           sta       ,X+       ; store the value and advance the destination pointer
Code_21CA           lda       ,U+       ; fetch the next value and advance the source pointer
                    cmpa      #$8C      ; compare against the limit and set condition flags
                    bne       Code_21C8 ; branch when the compared values differ
                    ldd       Data_0072 ; load the value needed by the following operation
                    addd      Data_006C ; add the operand to the running value
                    std       Data_0072 ; save the current value in working storage
                    lbsr      Code_2415 ; call the referenced helper routine
                    rts                 ; return to the caller
                    fcc       "9"                            ; embedded text or resource bytes
Code_21DB           lbsr      Code_2415 ; call the referenced helper routine
                    ldu       Data_0076 ; load the value needed by the following operation
Code_21E0           pulu      Y,X,D     ; restore the listed registers from the stack
                    cmpu      Data_0074 ; compare against the limit and set condition flags
                    bhi       Code_220E ; branch when the unsigned value is above the limit
                    cmpx      Data_0090 ; compare against the limit and set condition flags
                    bne       Code_21E0 ; branch when the compared values differ
                    cmpy      Data_0092 ; compare against the limit and set condition flags
                    bne       Code_21E0 ; branch when the compared values differ
                    ldx       -$0C,U    ; load the value needed by the following operation
                    stx       Data_0053 ; save the current value in working storage
                    ldx       -$06,U    ; load the value needed by the following operation
Code_21F6           ldu       Data_0040 ; load the value needed by the following operation
Code_21F8           lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,U+       ; store the value and advance the destination pointer
                    cmpx      Data_0053 ; compare against the limit and set condition flags
                    bcs       Code_21F8 ; branch when carry reports an unsigned underflow or error
Code_2200           lda       #$8C      ; load the value needed by the following operation
                    sta       ,U+       ; store the value and advance the destination pointer
                    lda       #$20      ; load the value needed by the following operation
Code_2206           sta       ,U+       ; store the value and advance the destination pointer
                    cmpu      Data_0044 ; compare against the limit and set condition flags
                    bls       Code_2206 ; branch when the unsigned value is at or below the limit
Code_220D           rts                 ; return to the caller
Code_220E           ldu       Data_0040 ; load the value needed by the following operation
                    bra       Code_2200 ; continue at the selected control-flow target
Code_2212           ldu       Data_0076 ; load the value needed by the following operation
Code_2214           pulu      Y,X,D     ; restore the listed registers from the stack
                    cmpu      Data_0074 ; compare against the limit and set condition flags
                    bhi       Code_220D ; branch when the unsigned value is above the limit
                    cmpx      Data_0090 ; compare against the limit and set condition flags
                    bne       Code_2214 ; branch when the compared values differ
                    cmpy      Data_0092 ; compare against the limit and set condition flags
                    bne       Code_2214 ; branch when the compared values differ
Code_2224           leau      -$0C,U    ; form the referenced address without reading memory
                    stu       Data_0053 ; save the current value in working storage
                    ldd       ,U        ; load the value needed by the following operation
                    subd      $06,U     ; subtract the operand from the running value
                    std       Data_006C ; save the current value in working storage
                    ldx       ,U        ; load the value needed by the following operation
                    ldu       $06,U     ; load the value needed by the following operation
                    bra       Code_2236 ; continue at the selected control-flow target
Code_2234           sta       ,U+       ; store the value and advance the destination pointer
Code_2236           lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpx      Data_0072 ; compare against the limit and set condition flags
                    bls       Code_2234 ; branch when the unsigned value is at or below the limit
                    ldu       Data_0053 ; load the value needed by the following operation
Code_223E           pulu      Y,X,D     ; restore the listed registers from the stack
                    leau      $06,U     ; form the referenced address without reading memory
                    subd      Data_006C ; subtract the operand from the running value
                    pshu      Y,X,D     ; preserve the listed registers on the stack
                    leau      -$0C,U    ; form the referenced address without reading memory
                    cmpu      Data_0076 ; compare against the limit and set condition flags
                    bcc       Code_223E ; branch when carry is clear
                    ldx       Data_0076 ; load the value needed by the following operation
                    leax      $06,X     ; form the referenced address without reading memory
                    stx       Data_0076 ; save the current value in working storage
                    ldd       Data_0072 ; load the value needed by the following operation
                    subd      Data_006C ; subtract the operand from the running value
                    std       Data_0072 ; save the current value in working storage
                    lbsr      Code_2415 ; call the referenced helper routine
                    rts                 ; return to the caller
Data_225D           fcc       "("                            ; embedded text or resource bytes
                    fcb       $0B,$0B,$0E,$03,$00,$AA ; table, bitmap, or initialized data bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
Data_2265           fcc       "End of File"                  ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_2271           ldx       Data_007B ; load the value needed by the following operation
                    leau      Data_1159,PCR ; form the referenced address without reading memory
                    ldb       #$13      ; load the value needed by the following operation
                    lda       #$20      ; load the value needed by the following operation
Code_227B           lda       #$20      ; load the value needed by the following operation
                    cmpa      B,U       ; compare against the limit and set condition flags
                    bne       Code_2286 ; branch when the compared values differ
                    decb                ; decrement the selected counter
                    bge       Code_227B ; branch when the signed value is at least the limit
                    bra       Code_22D6 ; continue at the selected control-flow target
Code_2286           stb       Data_007A ; save the current value in working storage
                    clrb                ; clear the selected byte or register
                    bra       Code_22AB ; continue at the selected control-flow target
Code_228B           lda       B,U       ; load the value needed by the following operation
                    cmpa      B,X       ; compare against the limit and set condition flags
                    beq       Code_22A1 ; branch when the compared values are equal
                    cmpa      #$41      ; compare against the limit and set condition flags
                    bcs       Code_22A4 ; branch when carry reports an unsigned underflow or error
                    cmpa      #$5A      ; compare against the limit and set condition flags
                    bls       Code_229B ; branch when the unsigned value is at or below the limit
                    suba      #$40      ; subtract the operand from the running value
Code_229B           adda      #$20      ; add the operand to the running value
                    cmpa      B,X       ; compare against the limit and set condition flags
                    bne       Code_22A4 ; branch when the compared values differ
Code_22A1           incb                ; advance the selected counter
                    bra       Code_22A7 ; continue at the selected control-flow target
Code_22A4           leax      $01,X     ; form the referenced address without reading memory
                    clrb                ; clear the selected byte or register
Code_22A7           cmpb      Data_007A ; compare against the limit and set condition flags
                    bgt       Code_22D6 ; branch when the signed value is above the limit
Code_22AB           cmpx      Data_0072 ; compare against the limit and set condition flags
                    bcs       Code_228B ; branch when carry reports an unsigned underflow or error
Code_22AF           leax      >Data_225D,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    ldx       #DeskMateService ; load the value needed by the following operation
                    tfr       X,Y       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    leax      >Data_2265,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
                    ldb       #$80      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1C       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $19       ; private DeskMate service selector
                    ldx       Data_0070 ; load the value needed by the following operation
                    bra       Code_22F3 ; continue at the selected control-flow target
Code_22D6           stx       Data_007B ; save the current value in working storage
                    ldx       Data_007B ; load the value needed by the following operation
                    ldu       Data_0074 ; load the value needed by the following operation
                    leau      -$06,U    ; form the referenced address without reading memory
Code_22DE           leau      -$06,U    ; form the referenced address without reading memory
                    cmpu      Data_0076 ; compare against the limit and set condition flags
                    bcs       Code_22AF ; branch when carry reports an unsigned underflow or error
                    cmpx      ,U        ; compare against the limit and set condition flags
                    bcc       Code_22DE ; branch when carry is clear
                    ldd       $0A,U     ; load the value needed by the following operation
                    std       Data_0092 ; save the current value in working storage
                    ldd       $08,U     ; load the value needed by the following operation
                    std       Data_0090 ; save the current value in working storage
                    ldx       ,U        ; load the value needed by the following operation
Code_22F3           stx       Data_007B ; save the current value in working storage
                    rts                 ; return to the caller
Code_22F6           lda       #$FF      ; load the value needed by the following operation
                    sta       Data_0050 ; save the current value in working storage
Code_22FA           ldu       Data_0074 ; load the value needed by the following operation
Code_22FC           leau      $06,U     ; form the referenced address without reading memory
Code_22FE           leau      -$0C,U    ; form the referenced address without reading memory
                    cmpu      Data_0076 ; compare against the limit and set condition flags
                    bls       Code_232F ; branch when the unsigned value is at or below the limit
                    pulu      Y,X,D     ; restore the listed registers from the stack
                    cmpx      Data_0064 ; compare against the limit and set condition flags
                    bcs       Code_22FE ; branch when carry reports an unsigned underflow or error
                    bhi       Code_2312 ; branch when the unsigned value is above the limit
                    cmpy      Data_0066 ; compare against the limit and set condition flags
                    bcs       Code_22FE ; branch when carry reports an unsigned underflow or error
Code_2312           cmpx      Data_0068 ; compare against the limit and set condition flags
                    bhi       Code_232F ; branch when the unsigned value is above the limit
                    bcs       Code_231D ; branch when carry reports an unsigned underflow or error
                    cmpy      Data_006A ; compare against the limit and set condition flags
                    bhi       Code_232F ; branch when the unsigned value is above the limit
Code_231D           tst       Data_0050 ; set condition flags from the current value
                    bmi       Code_232A ; branch while the tested value is negative
                    pshs      U         ; preserve the listed registers on the stack
                    lbsr      Code_2224 ; call the referenced helper routine
                    puls      U         ; restore the listed registers from the stack
                    bra       Code_22FC ; continue at the selected control-flow target
Code_232A           lbsr      Code_250A ; call the referenced helper routine
                    bra       Code_22FE ; continue at the selected control-flow target
Code_232F           rts                 ; return to the caller
Code_2330           lbsr      Code_21DB ; call the referenced helper routine
                    ldx       Data_0040 ; load the value needed by the following operation
                    lda       ,X        ; load the value needed by the following operation
                    cmpa      #$8C      ; compare against the limit and set condition flags
                    beq       Code_234B ; branch when the compared values are equal
                    ldx       Data_0040 ; load the value needed by the following operation
                    ldu       Data_0046 ; load the value needed by the following operation
Code_233F           lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,U+       ; store the value and advance the destination pointer
                    cmpx      Data_0042 ; compare against the limit and set condition flags
                    bls       Code_233F ; branch when the unsigned value is at or below the limit
                    lda       #$8C      ; load the value needed by the following operation
                    sta       ,U        ; save the current value in working storage
Code_234B           rts                 ; return to the caller
Code_234C           lbsr      Code_21DB ; call the referenced helper routine
                    ldx       Data_0040 ; load the value needed by the following operation
Code_2351           lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpa      #$8C      ; compare against the limit and set condition flags
                    beq       Code_235D ; branch when the compared values are equal
                    cmpx      Data_0042 ; compare against the limit and set condition flags
                    bls       Code_2351 ; branch when the unsigned value is at or below the limit
                    leax      $01,X     ; form the referenced address without reading memory
Code_235D           ldu       Data_0046 ; load the value needed by the following operation
                    leax      -$01,X    ; form the referenced address without reading memory
                    ldy       Data_0078 ; load the value needed by the following operation
                    cmpx      Data_0040 ; compare against the limit and set condition flags
                    bne       Code_236A ; branch when the compared values differ
                    leay      -$06,Y    ; form the referenced address without reading memory
Code_236A           bra       Code_2376 ; continue at the selected control-flow target
Code_236C           lda       ,U+       ; fetch the next value and advance the source pointer
                    sta       ,X+       ; store the value and advance the destination pointer
                    cmpa      #$8C      ; compare against the limit and set condition flags
                    beq       Code_2391 ; branch when the compared values are equal
                    leay      -$01,Y    ; form the referenced address without reading memory
Code_2376           cmpy      #DeskMateService ; compare against the limit and set condition flags
                    ble       Code_2380 ; branch when the signed value is at or below the limit
                    cmpx      Data_0042 ; compare against the limit and set condition flags
                    bls       Code_236C ; branch when the unsigned value is at or below the limit
Code_2380           lda       ,U+       ; fetch the next value and advance the source pointer
                    sta       ,X        ; save the current value in working storage
                    cmpa      #$8C      ; compare against the limit and set condition flags
                    beq       Code_2391 ; branch when the compared values are equal
                    lda       #$8C      ; load the value needed by the following operation
                    sta       ,X        ; save the current value in working storage
                    lbsr      Code_216D ; call the referenced helper routine
                    bra       Code_23EA ; continue at the selected control-flow target
Code_2391           lbsr      Code_216D ; call the referenced helper routine
                    rts                 ; return to the caller
Data_2395           fcc       "("                            ; embedded text or resource bytes
                    fcb       $06,$09,$1D,$06,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $0C       ; table, bitmap, or initialized data bytes
Data_239D           fcc       "        Buffer Full"          ; embedded text or resource bytes
                    fcb       $0A,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "  Text will be trunca"        ; embedded text or resource bytes
                    fcc       "ted."                         ; embedded text or resource bytes
                    fcb       $0A,$0D,$0A,$0D ; table, bitmap, or initialized data bytes
                    fcc       " Press Any Key to Con"        ; embedded text or resource bytes
                    fcc       "tinue"                        ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_23EA           pshs      U,Y,X,D   ; preserve the listed registers on the stack
                    leax      >Data_2395,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       ":"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    leax      >Data_239D,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1C       ; private DeskMate service selector
                    lda       #$01      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "-"                            ; embedded text or resource bytes
                    puls      PC,U,Y,X,D ; restore the listed registers from the stack
Code_2415           ldd       Data_0076 ; load the value needed by the following operation
                    subd      Data_0072 ; subtract the operand from the running value
                    std       Data_0078 ; save the current value in working storage
                    rts                 ; return to the caller
                    fcc       "4w"                           ; embedded text or resource bytes
                    fcb       $17,$DB,$F2,$1C ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $F7       ; table, bitmap, or initialized data bytes
Data_2424           fcc       "SunMonTueWedThuFriSat"        ; embedded text or resource bytes
Data_2439           fcc       "DATE      DAY   EVENT"        ; embedded text or resource bytes
                    fcc       "S"                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
Data_2450           fcc       "Printing"                     ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_2459           ldb       Data_003A ; load the value needed by the following operation
                    lda       #$0D      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "T"                            ; embedded text or resource bytes
                    lbcs      Code_2590 ; take the distant branch when carry reports an error
                    rts                 ; return to the caller
Code_2466           sts       Addr_0002 ; save the current value in working storage
                    ldx       #Addr_0007 ; load the value needed by the following operation
                    ldy       #Addr_0005 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Q"                            ; embedded text or resource bytes
                    lbcs      Code_25A3 ; take the distant branch when carry reports an error
                    sta       Data_003A ; save the current value in working storage
                    ldx       Data_0092 ; load the value needed by the following operation
                    stx       Data_0086 ; save the current value in working storage
                    ldx       Data_0090 ; load the value needed by the following operation
                    stx       Data_0088 ; save the current value in working storage
                    leax      >Data_2450,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
                    lda       #$01      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    lbsr      Code_2633 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "N"                            ; embedded text or resource bytes
                    ldb       $1C,X     ; load the value needed by the following operation
                    cmpb      #$7D      ; compare against the limit and set condition flags
                    bls       Code_24A4 ; branch when the unsigned value is at or below the limit
                    ldb       #$7D      ; load the value needed by the following operation
Code_24A4           addb      #$FB      ; add the operand to the running value
                    stb       Data_003B ;24A6: D7 3B          '. ; save the current value in working storage
                    tst       Addr_000A ; set condition flags from the current value
                    bne       Code_24B0 ; branch when the compared values differ
                    tst       Addr_000B ; set condition flags from the current value
                    beq       Code_24E2 ; branch when the compared values are equal
Code_24B0           clr       $0D,X     ; clear the selected byte or register
                    lda       #$FF      ; load the value needed by the following operation
                    sta       $1A,X     ; save the current value in working storage
                    bsr       Code_2459 ; call the referenced helper routine
                    leax      Data_2439,PCR ; form the referenced address without reading memory
                    ldy       #Addr_0017 ; load the value needed by the following operation
                    ldb       Data_003A ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "S"                            ; embedded text or resource bytes
                    lbcs      Code_2590 ; take the distant branch when carry reports an error
                    leax      Data_1B51,PCR ; form the referenced address without reading memory
                    lda       Data_003B ;24CF: 96 3B          '. ; load the value needed by the following operation
                    adda      #$05      ; add the operand to the running value
                    ldb       #$0D      ; load the value needed by the following operation
                    stb       A,X       ; save the current value in working storage
                    deca                ; decrement the selected counter
                    ldb       #$5F      ; load the value needed by the following operation
Code_24DA           stb       A,X       ; save the current value in working storage
                    deca                ; decrement the selected counter
                    bge       Code_24DA ; branch when the signed value is at least the limit
                    lbsr      Code_25FE ; call the referenced helper routine
Code_24E2           lda       Addr_000A ; load the value needed by the following operation
                    sta       Addr_000B ; save the current value in working storage
                    lbeq      Code_258C ; take the distant branch when values are equal
                    cmpa      #$01      ; compare against the limit and set condition flags
                    lbeq      Code_2520 ; take the distant branch when values are equal
                    cmpa      #$02      ; compare against the limit and set condition flags
                    lbeq      Code_2568 ; take the distant branch when values are equal
                    ldu       Data_0074 ; load the value needed by the following operation
                    leau      -$06,U    ; form the referenced address without reading memory
                    bra       Code_2502 ; continue at the selected control-flow target
Code_24FC           pulu      Y,X,D     ; restore the listed registers from the stack
                    bsr       Code_250A ; call the referenced helper routine
                    leau      -$0C,U    ; form the referenced address without reading memory
Code_2502           cmpu      Data_0076 ; compare against the limit and set condition flags
                    bhi       Code_24FC ; branch when the unsigned value is above the limit
                    lbra      Code_257B ; continue at the distant control-flow target
Code_250A           sty       Data_0092 ; save the current value in working storage
                    stx       Data_0090 ; save the current value in working storage
                    ldx       -$0C,U    ; load the value needed by the following operation
                    stx       Data_0053 ; save the current value in working storage
                    tfr       D,X       ; copy the source register into the destination register
                    pshs      U         ; preserve the listed registers on the stack
                    lbsr      Code_21F6 ; call the referenced helper routine
                    lbsr      Code_25A8 ; call the referenced helper routine
                    puls      U         ; restore the listed registers from the stack
                    rts                 ; return to the caller
Code_2520           lbsr      Code_0D76 ; call the referenced helper routine
                    nega                ; form the two's-complement negative value
                    adda      #$06      ; add the operand to the running value
                    adda      Data_0093 ; add the operand to the running value
                    daa                 ; adjust the accumulator to packed decimal
                    sta       Data_006B ; save the current value in working storage
                    cmpa      Data_0037 ; compare against the limit and set condition flags
                    bls       Code_2540 ; branch when the unsigned value is at or below the limit
                    lda       #$99      ; load the value needed by the following operation
                    suba      Data_0037 ; subtract the operand from the running value
                    adda      #$01      ; add the operand to the running value
                    daa                 ; adjust the accumulator to packed decimal
                    adda      Data_006B ; add the operand to the running value
                    daa                 ; adjust the accumulator to packed decimal
                    sta       Data_006B ; save the current value in working storage
                    lbsr      Code_042F ; call the referenced helper routine
                    sta       Data_0092 ; save the current value in working storage
Code_2540           lda       Data_0092 ; load the value needed by the following operation
                    ldx       Data_0090 ; load the value needed by the following operation
                    sta       Data_006A ; save the current value in working storage
                    stx       Data_0068 ; save the current value in working storage
                    lda       Data_006B ; load the value needed by the following operation
                    adda      #$94      ; add the operand to the running value
                    daa                 ; adjust the accumulator to packed decimal
                    sta       Data_0067 ; save the current value in working storage
                    bgt       Code_255E ; branch when the signed value is above the limit
                    lbsr      Code_040E ; call the referenced helper routine
                    lbsr      Code_0E22 ; call the referenced helper routine
                    lda       Data_0037 ; load the value needed by the following operation
                    adda      Data_0067 ; add the operand to the running value
                    daa                 ; adjust the accumulator to packed decimal
                    sta       Data_0067 ; save the current value in working storage
Code_255E           lda       Data_0092 ; load the value needed by the following operation
                    ldx       Data_0090 ; load the value needed by the following operation
                    sta       Data_0066 ; save the current value in working storage
                    stx       Data_0064 ; save the current value in working storage
                    bra       Code_2577 ; continue at the selected control-flow target
Code_2568           clrb                ; clear the selected byte or register
                    lda       Data_0086 ; load the value needed by the following operation
                    ldx       Data_0088 ; load the value needed by the following operation
                    std       Data_0066 ; save the current value in working storage
                    stx       Data_0064 ; save the current value in working storage
                    ldb       #$31      ; load the value needed by the following operation
                    std       Data_006A ; save the current value in working storage
                    stx       Data_0068 ; save the current value in working storage
Code_2577           lbsr      Code_22F6 ; call the referenced helper routine
                    clrb                ; clear the selected byte or register
Code_257B           lda       Data_003A ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "R"                            ; embedded text or resource bytes
                    bcs       Code_2590 ; branch when carry reports an unsigned underflow or error
Code_2583           ldx       Data_0088 ; load the value needed by the following operation
                    ldd       Data_0086 ; load the value needed by the following operation
                    stx       Data_0090 ; save the current value in working storage
                    std       Data_0092 ; save the current value in working storage
Code_258B           rts                 ; return to the caller
Code_258C           bsr       Code_25A8 ; call the referenced helper routine
                    bra       Code_257B ; continue at the selected control-flow target
Code_2590           lds       Addr_0002 ; load the value needed by the following operation
                    pshs      B         ; preserve the listed registers on the stack
                    bsr       Code_2583 ; call the referenced helper routine
                    lda       Data_003A ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "R"                            ; embedded text or resource bytes
                    puls      B         ; restore the listed registers from the stack
                    cmpb      #$02      ; compare against the limit and set condition flags
                    beq       Code_258B ; branch when the compared values are equal
Code_25A3           lda       #$06      ; load the value needed by the following operation
                    lbra      Code_05EF ; continue at the distant control-flow target
Code_25A8           leax      Data_1B51,PCR ; form the referenced address without reading memory
                    clra                ; clear the selected byte or register
                    ldb       Data_0092 ; load the value needed by the following operation
                    lbsr      Code_2641 ; call the referenced helper routine
                    lda       #$2F      ; load the value needed by the following operation
                    sta       ,X+       ; store the value and advance the destination pointer
                    lda       Data_0093 ; load the value needed by the following operation
                    lsra                ; shift right and expose the low bit through carry
                    lsra                ; shift right and expose the low bit through carry
                    lsra                ; shift right and expose the low bit through carry
                    lsra                ; shift right and expose the low bit through carry
                    adda      #$30      ; add the operand to the running value
                    sta       ,X+       ; store the value and advance the destination pointer
                    lda       Data_0093 ; load the value needed by the following operation
                    anda      #$0F      ; mask off unwanted bits
                    adda      #$30      ; add the operand to the running value
                    sta       ,X+       ; store the value and advance the destination pointer
                    lda       #$2F      ; load the value needed by the following operation
                    sta       ,X+       ; store the value and advance the destination pointer
                    ldd       Data_0090 ; load the value needed by the following operation
                    lbsr      Code_2641 ; call the referenced helper routine
                    leax      $02,X     ; form the referenced address without reading memory
                    lbsr      Code_0E22 ; call the referenced helper routine
                    lbsr      Code_0D76 ; call the referenced helper routine
                    leau      Data_2424,PCR ; form the referenced address without reading memory
                    ldb       #$03      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    leau      B,U       ; form the referenced address without reading memory
                    clrb                ; clear the selected byte or register
Code_25E3           lda       B,U       ; load the value needed by the following operation
                    sta       ,X+       ; store the value and advance the destination pointer
                    incb                ; advance the selected counter
                    cmpb      #$02      ; compare against the limit and set condition flags
                    ble       Code_25E3 ; branch when the signed value is at or below the limit
                    lda       #$2E      ; load the value needed by the following operation
                    sta       ,X        ; save the current value in working storage
                    lbsr      Code_1BD1 ; call the referenced helper routine
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Data_0050 ; save the current value in working storage
                    lbsr      Code_2010 ; call the referenced helper routine
                    lbsr      Code_2459 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_25FE           leax      Data_1B51,PCR ; form the referenced address without reading memory
                    ldb       #$7F      ; load the value needed by the following operation
                    lda       #$20      ; load the value needed by the following operation
Code_2606           cmpa      B,X       ; compare against the limit and set condition flags
                    bne       Code_260F ; branch when the compared values differ
                    decb                ; decrement the selected counter
                    bge       Code_2606 ; branch when the signed value is at least the limit
                    bra       Code_2640 ; continue at the selected control-flow target
Code_260F           lda       B,X       ; load the value needed by the following operation
                    incb                ; advance the selected counter
                    cmpa      #$8B      ; compare against the limit and set condition flags
                    beq       Code_2620 ; branch when the compared values are equal
                    cmpa      #$8C      ; compare against the limit and set condition flags
                    bne       Code_2621 ; branch when the compared values differ
                    clr       Data_0056 ; clear the selected byte or register
                    lda       #$16      ; load the value needed by the following operation
                    sta       Data_0057 ; save the current value in working storage
Code_2620           decb                ; decrement the selected counter
Code_2621           lda       #$0D      ; load the value needed by the following operation
                    sta       B,X       ; save the current value in working storage
                    incb                ; advance the selected counter
                    clra                ; clear the selected byte or register
                    tfr       D,Y       ; copy the source register into the destination register
                    ldb       Data_003A ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "S"                            ; embedded text or resource bytes
                    lbcs      Code_2590 ; take the distant branch when carry reports an error
Code_2633           leax      Data_1B51,PCR ; form the referenced address without reading memory
                    ldb       #$7F      ; load the value needed by the following operation
                    lda       #$20      ; load the value needed by the following operation
Code_263B           sta       B,X       ; save the current value in working storage
                    decb                ; decrement the selected counter
                    bge       Code_263B ; branch when the signed value is at least the limit
Code_2640           rts                 ; return to the caller
Code_2641           bra       Code_2646 ; continue at the selected control-flow target
Code_2643           subd      #Data_0064 ; subtract the operand from the running value
Code_2646           cmpd      #Data_0064 ; compare against the limit and set condition flags
                    bcc       Code_2643 ; branch when carry is clear
                    bra       Code_2651 ; continue at the selected control-flow target
Code_264E           inca                ; advance the selected counter
                    subb      #$0A      ; subtract the operand from the running value
Code_2651           cmpb      #$0A      ; compare against the limit and set condition flags
                    bcc       Code_264E ; branch when carry is clear
                    adda      #$30      ; add the operand to the running value
                    sta       ,X+       ; store the value and advance the destination pointer
                    clra                ; clear the selected byte or register
                    bra       Code_265E ; continue at the selected control-flow target
Code_265C           inca                ; advance the selected counter
                    decb                ; decrement the selected counter
Code_265E           tstb                ; set condition flags from the current value
                    bgt       Code_265C ; branch when the signed value is above the limit
                    adda      #$30      ; add the operand to the running value
                    sta       ,X+       ; store the value and advance the destination pointer
                    rts                 ; return to the caller
Code_2666           pshs      U,Y,X,DP,D ; preserve the listed registers on the stack
                    bsr       Code_26D8 ; call the referenced helper routine
                    lda       ,S        ; load the value needed by the following operation
                    sta       start     ; save the current value in working storage
                    leay      $0A,U     ; form the referenced address without reading memory
                    ldb       #$07      ; load the value needed by the following operation
Code_2672           lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,Y+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bgt       Code_2672 ; branch when the signed value is above the limit
                    clr       Addr_0018 ; clear the selected byte or register
                    clr       Addr_0019 ; clear the selected byte or register
                    clr       Addr_0015 ; clear the selected byte or register
                    clr       Code_001A ; clear the selected byte or register
                    ldb       Addr_000E ; load the value needed by the following operation
                    cmpb      Addr_000C ; compare against the limit and set condition flags
                    bls       Code_268F ; branch when the unsigned value is at or below the limit
                    com       Addr_0015 ; invert every bit in the selected value
                    dec       Addr_000C ; decrement the selected counter
                    dec       Addr_000C ; decrement the selected counter
                    inc       Addr_0010 ; advance the selected counter
Code_268F           clr       Addr_0011 ; clear the selected byte or register
                    clr       Addr_0017 ; clear the selected byte or register
                    lda       start     ; load the value needed by the following operation
                    suba      Addr_000C ; subtract the operand from the running value
                    bcs       Code_269E ; branch when carry reports an unsigned underflow or error
                    inca                ; advance the selected counter
                    sta       Addr_0011 ; save the current value in working storage
                    sta       Addr_0017 ; save the current value in working storage
Code_269E           ldb       start     ; load the value needed by the following operation
                    subb      Addr_0011 ; subtract the operand from the running value
                    addb      Addr_0010 ; add the operand to the running value
                    stb       Addr_0014 ; save the current value in working storage
                    ldb       Addr_000E ; load the value needed by the following operation
                    subb      Addr_000C ; subtract the operand from the running value
                    stb       Addr_0012 ; save the current value in working storage
                    lda       Addr_0010 ; load the value needed by the following operation
                    adda      Addr_000C ; add the operand to the running value
                    deca                ; decrement the selected counter
                    sta       Addr_001D ; save the current value in working storage
                    clr       Code_0016 ; clear the selected byte or register
Code_26B5           ldb       Addr_0010 ; load the value needed by the following operation
                    addb      Code_0016 ; add the operand to the running value
                    bsr       Code_26E5 ; call the referenced helper routine
                    lda       Addr_0017 ; load the value needed by the following operation
                    lbsr      Code_26F1 ; call the referenced helper routine
                    inc       Code_0016 ; advance the selected counter
                    lda       Code_0016 ; load the value needed by the following operation
                    cmpa      Addr_000C ; compare against the limit and set condition flags
                    beq       Code_26D0 ; branch when the compared values are equal
                    inc       Addr_0017 ; advance the selected counter
                    lda       Addr_0017 ; load the value needed by the following operation
                    cmpa      Addr_000E ; compare against the limit and set condition flags
                    bne       Code_26B5 ; branch when the compared values differ
Code_26D0           lbsr      Code_2700 ; call the referenced helper routine
                    lbsr      Code_270E ; call the referenced helper routine
                    puls      PC,U,Y,X,DP,D ; restore the listed registers from the stack
Code_26D8           pshs      D         ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "/"                            ; embedded text or resource bytes
                    tfr       A,DP      ; copy the source register into the destination register
                    clrb                ; clear the selected byte or register
                    tfr       D,U       ; copy the source register into the destination register
                    puls      PC,D      ; restore the listed registers from the stack
Code_26E5           clra                ; clear the selected byte or register
                    tfr       D,Y       ; copy the source register into the destination register
                    ldb       Addr_000F ; load the value needed by the following operation
                    tfr       D,X       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_26F1           ldx       Addr_000A ; load the value needed by the following operation
                    asla                ; shift left and update carry
                    ldx       A,X       ; load the value needed by the following operation
                    clra                ; clear the selected byte or register
                    ldb       ,X+       ; fetch the next value and advance the source pointer
                    andb      #$80      ; mask off unwanted bits
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_2700           ldb       Addr_0014 ; load the value needed by the following operation
                    bsr       Code_26E5 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    ldb       Addr_000D ; load the value needed by the following operation
                    tfr       D,Y       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "$"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_270E           tst       Addr_0015 ; set condition flags from the current value
                    beq       Code_2748 ; branch when the compared values are equal
                    ldb       Addr_0010 ; load the value needed by the following operation
                    decb                ; decrement the selected counter
                    bsr       Code_2749 ; call the referenced helper routine
                    tst       Addr_0011 ; set condition flags from the current value
                    beq       Code_2729 ; branch when the compared values are equal
                    leax      Data_2AA4,PCR ; form the referenced address without reading memory
                    tst       Addr_0018 ; set condition flags from the current value
                    beq       Code_2725 ; branch when the compared values are equal
                    leax      $03,X     ; form the referenced address without reading memory
Code_2725           bsr       Code_2759 ; call the referenced helper routine
                    bra       Code_272D ; continue at the selected control-flow target
Code_2729           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "A"                            ; embedded text or resource bytes
Code_272D           ldb       Addr_001D ; load the value needed by the following operation
                    incb                ; advance the selected counter
                    bsr       Code_2749 ; call the referenced helper routine
                    ldb       Addr_0011 ; load the value needed by the following operation
                    cmpb      Addr_0012 ; compare against the limit and set condition flags
                    beq       Code_2744 ; branch when the compared values are equal
                    leax      Data_2AAA,PCR ; form the referenced address without reading memory
                    tst       Addr_0019 ; set condition flags from the current value
                    beq       Code_2742 ; branch when the compared values are equal
                    leax      $03,X     ; form the referenced address without reading memory
Code_2742           bra       Code_2759 ; continue at the selected control-flow target
Code_2744           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "A"                            ; embedded text or resource bytes
Code_2748           rts                 ; return to the caller
Code_2749           clra                ; clear the selected byte or register
                    tfr       D,Y       ; copy the source register into the destination register
                    ldb       Addr_000D ; load the value needed by the following operation
                    lsrb                ; shift right and expose the low bit through carry
                    addb      Addr_000F ; add the operand to the running value
                    decb                ; decrement the selected counter
                    tfr       D,X       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_2759           pshs      X         ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1F       ; private DeskMate service selector
                    pshs      Y         ; preserve the listed registers on the stack
                    leax      Data_2A24,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $06       ; private DeskMate service selector
                    ldx       $02,S     ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
                    puls      Y,X       ; restore the listed registers from the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $03       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_2776           pshs      U,Y,X,DP,D ; preserve the listed registers on the stack
                    lbsr      Code_26D8 ; call the referenced helper routine
                    clr       Addr_0018 ; clear the selected byte or register
                    clr       Addr_0019 ; clear the selected byte or register
                    clr       Addr_0033 ; clear the selected byte or register
                    ldb       #$80      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    sta       Code_001C ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $18       ; private DeskMate service selector
                    tsta                ; set condition flags from the current value
                    lbeq      Code_27DB ; take the distant branch when values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "E"                            ; embedded text or resource bytes
                    stb       Addr_0033 ; save the current value in working storage
                    stx       Addr_0034 ; save the current value in working storage
                    sty       Data_0036 ; save the current value in working storage
                    cmpb      #$01      ; compare against the limit and set condition flags
                    bne       Code_27AD ; branch when the compared values differ
                    lda       #$0D      ; load the value needed by the following operation
                    cmpy      #Data_00FF ; compare against the limit and set condition flags
                    bne       Code_27AB ; branch when the compared values differ
                    lda       #$05      ; load the value needed by the following operation
Code_27AB           sta       Code_001C ; save the current value in working storage
Code_27AD           tfr       Y,D       ; copy the source register into the destination register
                    cmpb      #$FF      ; compare against the limit and set condition flags
                    beq       Code_27DB ; branch when the compared values are equal
                    stb       Addr_001B ; save the current value in working storage
                    cmpb      Addr_0010 ; compare against the limit and set condition flags
                    bcs       Code_2818 ; branch when carry reports an unsigned underflow or error
                    cmpb      Addr_001D ; compare against the limit and set condition flags
                    bhi       Code_2818 ; branch when the unsigned value is above the limit
                    cmpb      Addr_0014 ; compare against the limit and set condition flags
                    beq       Code_2810 ; branch when the compared values are equal
Code_27C1           subb      Addr_0010 ; subtract the operand from the running value
                    addb      Addr_0011 ; add the operand to the running value
                    cmpb      Addr_000E ; compare against the limit and set condition flags
                    bcc       Code_2810 ; branch when carry is clear
                    pshs      B         ; preserve the listed registers on the stack
                    lbsr      Code_2700 ; call the referenced helper routine
                    lda       ,S+       ; load the value needed by the following operation
                    ldb       Addr_001B ; load the value needed by the following operation
                    stb       Addr_0014 ; save the current value in working storage
                    sta       start     ; save the current value in working storage
                    lbsr      Code_2700 ; call the referenced helper routine
                    bra       Code_280D ; continue at the selected control-flow target
Code_27DB           lda       Code_001C ; load the value needed by the following operation
                    cmpa      #$0C      ; compare against the limit and set condition flags
                    beq       Code_27ED ; branch when the compared values are equal
                    cmpa      #$0A      ; compare against the limit and set condition flags
                    beq       Code_27FB ; branch when the compared values are equal
                    tst       Code_001A ; set condition flags from the current value
                    beq       Code_2810 ; branch when the compared values are equal
                    clr       Code_001A ; clear the selected byte or register
                    bra       Code_280D ; continue at the selected control-flow target
Code_27ED           ldb       Addr_0014 ; load the value needed by the following operation
                    cmpb      Addr_0010 ; compare against the limit and set condition flags
                    lbeq      Code_2853 ; take the distant branch when values are equal
                    decb                ; decrement the selected counter
                    stb       Addr_001B ; save the current value in working storage
                    lbra      Code_27C1 ; continue at the distant control-flow target
Code_27FB           ldb       Addr_0014 ; load the value needed by the following operation
                    cmpb      Addr_001D ; compare against the limit and set condition flags
                    lbeq      Code_2821 ; take the distant branch when values are equal
                    incb                ; advance the selected counter
                    stb       Addr_001B ; save the current value in working storage
                    lbra      Code_27C1 ; continue at the distant control-flow target
Code_2809           lda       #$FF      ; load the value needed by the following operation
                    sta       Code_001A ; save the current value in working storage
Code_280D           lbsr      Code_270E ; call the referenced helper routine
Code_2810           ldb       Code_001C ; load the value needed by the following operation
                    lda       start     ; load the value needed by the following operation
                    leas      $02,S     ; form the referenced address without reading memory
                    puls      PC,U,Y,X,DP ; restore the listed registers from the stack
Code_2818           lda       Addr_001D ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    cmpa      Addr_001B ; compare against the limit and set condition flags
                    bne       Code_284A ; branch when the compared values differ
                    inc       Addr_0019 ; advance the selected counter
Code_2821           ldb       Addr_0011 ; load the value needed by the following operation
                    cmpb      Addr_0012 ; compare against the limit and set condition flags
                    beq       Code_2810 ; branch when the compared values are equal
                    inc       Addr_0011 ; advance the selected counter
                    lbsr      Code_2700 ; call the referenced helper routine
                    inc       start     ; advance the selected counter
                    bsr       Code_2877 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $26       ; private DeskMate service selector
                    ldb       Addr_001D ; load the value needed by the following operation
                    lbsr      Code_26E5 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "A"                            ; embedded text or resource bytes
                    lda       Addr_0011 ; load the value needed by the following operation
                    adda      Addr_000C ; add the operand to the running value
                    deca                ; decrement the selected counter
                    lbsr      Code_26F1 ; call the referenced helper routine
                    lbsr      Code_2700 ; call the referenced helper routine
                    bra       Code_2809 ; continue at the selected control-flow target
Code_284A           lda       Addr_0010 ; load the value needed by the following operation
                    deca                ; decrement the selected counter
                    cmpa      Addr_001B ; compare against the limit and set condition flags
                    bne       Code_280D ; branch when the compared values differ
                    inc       Addr_0018 ; advance the selected counter
Code_2853           tst       Addr_0011 ; set condition flags from the current value
                    beq       Code_2810 ; branch when the compared values are equal
                    lbsr      Code_2700 ; call the referenced helper routine
                    dec       Addr_0011 ; decrement the selected counter
                    dec       start     ; decrement the selected counter
                    bsr       Code_2877 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "'"                            ; embedded text or resource bytes
                    ldb       Addr_0010 ; load the value needed by the following operation
                    lbsr      Code_26E5 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "A"                            ; embedded text or resource bytes
                    lda       Addr_0011 ; load the value needed by the following operation
                    lbsr      Code_26F1 ; call the referenced helper routine
                    lbsr      Code_2700 ; call the referenced helper routine
                    bra       Code_2809 ; continue at the selected control-flow target
Code_2877           ldb       Addr_0010 ; load the value needed by the following operation
                    lbsr      Code_26E5 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0C       ; private DeskMate service selector
                    tfr       X,D       ; copy the source register into the destination register
                    pshs      A         ; preserve the listed registers on the stack
                    clra                ; clear the selected byte or register
                    tfr       D,X       ; copy the source register into the destination register
                    puls      B         ; restore the listed registers from the stack
                    tfr       D,Y       ; copy the source register into the destination register
                    ldu       #Addr_2000 ; load the value needed by the following operation
                    ldd       Addr_000C ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_2891           pshs      U,Y,X,DP,D ; preserve the listed registers on the stack
                    lbsr      Code_26D8 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "9"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "0"                            ; embedded text or resource bytes
                    sta       Addr_0026 ; save the current value in working storage
                    ldd       ,S        ; load the value needed by the following operation
                    stb       Addr_001F ; save the current value in working storage
                    tsta                ; set condition flags from the current value
                    bpl       Code_28C8 ; branch while the tested value is nonnegative
                    anda      #$7F      ; mask off unwanted bits
                    sta       Code_0020 ; save the current value in working storage
                    stx       Addr_0021 ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "I"                            ; embedded text or resource bytes
                    tfr       Y,D       ; copy the source register into the destination register
                    stb       Data_0023 ; save the current value in working storage
                    tfr       X,D       ; copy the source register into the destination register
                    stb       Code_0024 ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "4"                            ; embedded text or resource bytes
                    clr       Addr_001E ; clear the selected byte or register
                    lda       #$FF      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1E       ; private DeskMate service selector
Code_28C5           lbsr      Code_29E5 ; call the referenced helper routine
Code_28C8           lbsr      Code_2A00 ; call the referenced helper routine
Code_28CB           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $18       ; private DeskMate service selector
                    anda      #$80      ; mask off unwanted bits
                    ora       #$03      ; set the selected flag bits
                    tfr       A,B       ; copy the source register into the destination register
                    lbsr      start     ;28D5: 17 D7 3B       '.. ; call the referenced helper routine
                    fcb       $1C       ; private DeskMate service selector
                    tstb                ; set condition flags from the current value
                    bpl       Code_28E0 ; branch while the tested value is nonnegative
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $16       ; private DeskMate service selector
Code_28E0           sta       Addr_0025 ; save the current value in working storage
                    ldx       Addr_0021 ; load the value needed by the following operation
                    ldb       Addr_001F ; load the value needed by the following operation
                    leay      B,X       ; form the referenced address without reading memory
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bcs       Code_2904 ; branch when carry reports an unsigned underflow or error
                    cmpa      #$7E      ; compare against the limit and set condition flags
                    bhi       Code_2904 ; branch when the unsigned value is above the limit
                    tst       Addr_001E ; set condition flags from the current value
                    lbne      Code_29C5 ; take the distant branch when values differ
Code_28F6           sta       ,Y        ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "C"                            ; embedded text or resource bytes
Code_28FC           tst       $01,Y     ; set condition flags from the current value
                    beq       Code_28CB ; branch when the compared values are equal
                    inc       Addr_001F ; advance the selected counter
                    bra       Code_28C8 ; continue at the selected control-flow target
Code_2904           cmpa      #$88      ; compare against the limit and set condition flags
                    beq       Code_2953 ; branch when the compared values are equal
                    cmpa      #$08      ; compare against the limit and set condition flags
                    beq       Code_2978 ; branch when the compared values are equal
                    cmpa      #$09      ; compare against the limit and set condition flags
                    beq       Code_28FC ; branch when the compared values are equal
                    cmpa      #$C9      ; compare against the limit and set condition flags
                    lbeq      Code_299C ; take the distant branch when values are equal
                    cmpa      #$E9      ; compare against the limit and set condition flags
                    lbeq      Code_299C ; take the distant branch when values are equal
                    cmpa      #$0C      ; compare against the limit and set condition flags
                    beq       Code_2992 ; branch when the compared values are equal
                    cmpa      #$0A      ; compare against the limit and set condition flags
                    beq       Code_2980 ; branch when the compared values are equal
                    cmpa      #$8D      ; compare against the limit and set condition flags
                    bne       Code_293F ; branch when the compared values differ
                    lda       #$0D      ; load the value needed by the following operation
                    sta       Addr_0025 ; save the current value in working storage
Code_292C           lda       #$20      ; load the value needed by the following operation
                    sta       ,Y+       ; store the value and advance the destination pointer
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "C"                            ; embedded text or resource bytes
                    tst       ,Y        ; set condition flags from the current value
                    beq       Code_293F ; branch when the compared values are equal
                    inc       Addr_001F ; advance the selected counter
                    lbsr      Code_2A00 ; call the referenced helper routine
                    bra       Code_292C ; continue at the selected control-flow target
Code_293F           ldb       Addr_001F ; load the value needed by the following operation
                    lda       Addr_0026 ; load the value needed by the following operation
                    beq       Code_2949 ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "3"                            ; embedded text or resource bytes
Code_2949           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       ":"                            ; embedded text or resource bytes
                    lda       Addr_0025 ; load the value needed by the following operation
                    leas      $02,S     ; form the referenced address without reading memory
                    puls      PC,U,Y,X,DP ; restore the listed registers from the stack
Code_2953           tst       Addr_001E ; set condition flags from the current value
                    bne       Code_29AA ; branch when the compared values differ
                    tstb                ; set condition flags from the current value
                    beq       Code_296D ; branch when the compared values are equal
                    tst       $01,Y     ; set condition flags from the current value
                    bne       Code_2964 ; branch when the compared values differ
                    lda       #$20      ; load the value needed by the following operation
                    cmpa      ,Y        ; compare against the limit and set condition flags
                    bne       Code_296D ; branch when the compared values differ
Code_2964           dec       Addr_001F ; decrement the selected counter
                    lbsr      Code_2A00 ; call the referenced helper routine
                    ldx       Addr_0021 ; load the value needed by the following operation
                    ldb       Addr_001F ; load the value needed by the following operation
Code_296D           lda       #$20      ; load the value needed by the following operation
                    sta       B,X       ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "C"                            ; embedded text or resource bytes
Code_2975           lbra      Code_28CB ; continue at the distant control-flow target
Code_2978           tstb                ; set condition flags from the current value
                    beq       Code_2975 ; branch when the compared values are equal
                    dec       Addr_001F ; decrement the selected counter
                    lbra      Code_28C8 ; continue at the distant control-flow target
Code_2980           lda       Code_0020 ; load the value needed by the following operation
Code_2982           deca                ; decrement the selected counter
                    bmi       Code_298D ; branch while the tested value is negative
                    incb                ; advance the selected counter
                    tst       B,X       ; set condition flags from the current value
                    bne       Code_2982 ; branch when the compared values differ
Code_298A           lbra      Code_2949 ; continue at the distant control-flow target
Code_298D           stb       Addr_001F ; save the current value in working storage
                    lbra      Code_28C8 ; continue at the distant control-flow target
Code_2992           lda       Code_0020 ; load the value needed by the following operation
Code_2994           deca                ; decrement the selected counter
                    bmi       Code_298D ; branch while the tested value is negative
                    decb                ; decrement the selected counter
                    bmi       Code_298A ; branch while the tested value is negative
                    bra       Code_2994 ; continue at the selected control-flow target
Code_299C           lda       #$FF      ; load the value needed by the following operation
                    com       Addr_001E ; invert every bit in the selected value
                    beq       Code_29A4 ; branch when the compared values are equal
                    lda       #$01      ; load the value needed by the following operation
Code_29A4           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1E       ; private DeskMate service selector
                    bra       Code_2975 ; continue at the selected control-flow target
Code_29AA           tstb                ; set condition flags from the current value
                    bne       Code_29B0 ; branch when the compared values differ
                    incb                ; advance the selected counter
                    stb       Addr_001F ; save the current value in working storage
Code_29B0           leax      B,X       ; form the referenced address without reading memory
Code_29B2           lda       ,X+       ; fetch the next value and advance the source pointer
                    beq       Code_29BA ; branch when the compared values are equal
                    sta       -$02,X    ; save the current value in working storage
                    bra       Code_29B2 ; continue at the selected control-flow target
Code_29BA           lda       #$20      ; load the value needed by the following operation
                    sta       -$02,X    ; save the current value in working storage
                    dec       Addr_001F ; decrement the selected counter
                    bsr       Code_2A00 ; call the referenced helper routine
                    lbra      Code_28C5 ; continue at the distant control-flow target
Code_29C5           tst       $01,Y     ; set condition flags from the current value
                    lbeq      Code_28F6 ; take the distant branch when values are equal
                    pshs      Y,A       ; preserve the listed registers on the stack
Code_29CD           lda       ,Y+       ; fetch the next value and advance the source pointer
                    bne       Code_29CD ; branch when the compared values differ
                    leay      -$02,Y    ; form the referenced address without reading memory
Code_29D3           lda       ,-Y       ; load the value needed by the following operation
                    sta       $01,Y     ; save the current value in working storage
                    cmpy      $01,S     ; compare against the limit and set condition flags
                    bne       Code_29D3 ; branch when the compared values differ
                    puls      X,A       ; restore the listed registers from the stack
                    sta       ,X        ; save the current value in working storage
                    bsr       Code_29E5 ; call the referenced helper routine
                    lbra      Code_28FC ; continue at the distant control-flow target
Code_29E5           ldx       Addr_0021 ; load the value needed by the following operation
                    ldb       Addr_001F ; load the value needed by the following operation
                    pshs      B         ; preserve the listed registers on the stack
                    leax      B,X       ; form the referenced address without reading memory
Code_29ED           bsr       Code_2A00 ; call the referenced helper routine
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    beq       Code_29FB ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "C"                            ; embedded text or resource bytes
                    inc       Addr_001F ; advance the selected counter
                    bra       Code_29ED ; continue at the selected control-flow target
Code_29FB           puls      B         ; restore the listed registers from the stack
                    stb       Addr_001F ; save the current value in working storage
                    rts                 ; return to the caller
Code_2A00           ldb       Addr_001F ; load the value needed by the following operation
                    clra                ; clear the selected byte or register
Code_2A03           inca                ; advance the selected counter
                    subb      Code_0020 ; subtract the operand from the running value
                    bhi       Code_2A03 ; branch when the unsigned value is above the limit
                    beq       Code_2A0D ; branch when the compared values are equal
                    deca                ; decrement the selected counter
                    addb      Code_0020 ; add the operand to the running value
Code_2A0D           adda      Data_0023 ; add the operand to the running value
                    addb      Code_0024 ; add the operand to the running value
                    pshs      Y,X       ; preserve the listed registers on the stack
                    pshs      A         ; preserve the listed registers on the stack
                    clra                ; clear the selected byte or register
                    tfr       D,X       ; copy the source register into the destination register
                    puls      B         ; restore the listed registers from the stack
                    tfr       D,Y       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    puls      PC,Y,X    ; restore the listed registers from the stack
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $08       ; table, bitmap, or initialized data bytes
Data_2A24           fcb       $00,$03,$0C ; table, bitmap, or initialized data bytes
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
                    fcb       $00,$00,$00 ; table, bitmap, or initialized data bytes
Data_2AA4           fcb       $80,$81,$00,$84,$85,$00 ; table, bitmap, or initialized data bytes
Data_2AAA           fcb       $82,$83,$00,$86,$87,$00 ; table, bitmap, or initialized data bytes
Data_2AB0           fcb       $00,$04,$08,$18,$03,$00 ; table, bitmap, or initialized data bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
Data_2AB7           fcb       $FF       ; table, bitmap, or initialized data bytes
Data_2AB8           fcb       $07,$05   ; table, bitmap, or initialized data bytes
                    fcc       "  Save as:"                   ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_2AC5           fcb       $00,$02,$0C,$1C,$07,$00 ; table, bitmap, or initialized data bytes
                    fcb       $AA       ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
Data_2ACD           fcc       "Use "                         ; embedded text or resource bytes
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
Data_2AF8           fcc       "Filename must be 1-8"         ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "characters, begin wit"        ; embedded text or resource bytes
                    fcc       "h"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "a-z "                         ; embedded text or resource bytes
                    fcb       $26       ; table, bitmap, or initialized data bytes
                    fcc       " contain a-z or 0-9"          ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_2B3D           fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
Code_2B4E           pshs      DP        ; preserve the listed registers on the stack
                    pshs      U,Y,X,A   ; preserve the listed registers on the stack
                    lda       $06,Y     ; load the value needed by the following operation
                    sta       Data_2AB7,PCR ; save the current value in working storage
                    lbsr      Code_26D8 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       ">"                            ; embedded text or resource bytes
                    sta       Addr_0029 ; save the current value in working storage
                    clr       Addr_002A ; clear the selected byte or register
                    clr       Addr_002B ; clear the selected byte or register
                    ldx       ,Y        ; load the value needed by the following operation
                    stx       Data_0027 ; save the current value in working storage
                    leau      >Data_2B3D,PCR ; form the referenced address without reading memory
                    stu       ,Y        ; save the current value in working storage
                    lbsr      Code_2C71 ; call the referenced helper routine
                    leax      Data_2AB0,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    ldx       $01,S     ; load the value needed by the following operation
                    bne       Code_2B82 ; branch when the compared values differ
                    leax      Data_2AB8,PCR ; form the referenced address without reading memory
Code_2B82           clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
Code_2B88           ldx       #Addr_000B ; load the value needed by the following operation
                    leay      -$0B,X    ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    ldy       $03,S     ; load the value needed by the following operation
                    ldx       ,Y        ; load the value needed by the following operation
                    ldd       #Addr_9000 ; load the value needed by the following operation
Code_2B99           lbsr      Code_2891 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_2BA9 ; branch when the compared values are equal
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    beq       Code_2BE5 ; branch when the compared values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    beq       Code_2BDA ; branch when the compared values are equal
                    bra       Code_2BD6 ; continue at the selected control-flow target
Code_2BA9           pshs      U,Y,X,D   ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       ">"                            ; embedded text or resource bytes
                    pshs      A         ; preserve the listed registers on the stack
                    tst       Data_2AB7,PCR ; set condition flags from the current value
                    bne       Code_2BBB ; branch when the compared values differ
                    deca                ; decrement the selected counter
                    bpl       Code_2BBB ; branch while the tested value is nonnegative
                    inca                ; advance the selected counter
Code_2BBB           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "="                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "E"                            ; embedded text or resource bytes
                    puls      A         ; restore the listed registers from the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "="                            ; embedded text or resource bytes
                    cmpx      #Data_00FF ; compare against the limit and set condition flags
                    puls      U,Y,X,D   ; restore the listed registers from the stack
                    bne       Code_2BE5 ; branch when the compared values differ
                    lda       #$05      ; load the value needed by the following operation
                    bra       Code_2BDA ; continue at the selected control-flow target
                    fcc       "5v"                           ; embedded text or resource bytes
Code_2BD6           lda       #$0A      ; load the value needed by the following operation
                    bra       Code_2B99 ; continue at the selected control-flow target
Code_2BDA           ldx       Data_0027 ; load the value needed by the following operation
                    stx       ,Y        ; save the current value in working storage
                    sta       ,S        ; save the current value in working storage
                    clrb                ; clear the selected byte or register
                    puls      U,Y,X,A   ; restore the listed registers from the stack
                    puls      PC,DP     ; restore the listed registers from the stack
Code_2BE5           lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpa      #$20      ; compare against the limit and set condition flags
                    beq       Code_2BE5 ; branch when the compared values are equal
                    lda       ,X        ; load the value needed by the following operation
                    leax      -$01,X    ; form the referenced address without reading memory
                    cmpa      #$3A      ; compare against the limit and set condition flags
                    bne       Code_2C01 ; branch when the compared values differ
                    lda       ,X        ; load the value needed by the following operation
                    suba      #$31      ; subtract the operand from the running value
                    cmpa      #$02      ; compare against the limit and set condition flags
                    bcs       Code_2C01 ; branch when carry reports an unsigned underflow or error
                    leax      Data_2ACD,PCR ; form the referenced address without reading memory
                    bra       Code_2C12 ; continue at the selected control-flow target
Code_2C01           ldx       ,Y        ; load the value needed by the following operation
                    lda       ,S        ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "J"                            ; embedded text or resource bytes
                    andb      #$EF      ; mask off unwanted bits
                    tstb                ; set condition flags from the current value
                    beq       Code_2C5D ; branch when the compared values are equal
                    leax      Data_2AF8,PCR ; form the referenced address without reading memory
Code_2C12           pshs      X         ; preserve the listed registers on the stack
                    ldb       ,X        ; load the value needed by the following operation
                    tst       Addr_002A ; set condition flags from the current value
                    bne       Code_2C22 ; branch when the compared values differ
                    leax      Data_2AC5,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
Code_2C22           lda       Addr_0029 ; load the value needed by the following operation
                    adda      #$02      ; add the operand to the running value
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "="                            ; embedded text or resource bytes
                    cmpb      Addr_002B ; compare against the limit and set condition flags
                    beq       Code_2C34 ; branch when the compared values are equal
                    stb       Addr_002B ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "?"                            ; embedded text or resource bytes
Code_2C34           ldb       #$03      ; load the value needed by the following operation
                    stb       Addr_002A ; save the current value in working storage
                    ldy       #Addr_0001 ; load the value needed by the following operation
Code_2C3C           clra                ; clear the selected byte or register
                    ldx       #Addr_0001 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    ldx       ,S        ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    stx       ,S        ; save the current value in working storage
                    leay      $01,Y     ; form the referenced address without reading memory
                    decb                ; decrement the selected counter
                    bne       Code_2C3C ; branch when the compared values differ
                    leas      $02,S     ; form the referenced address without reading memory
                    lda       Addr_0029 ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "="                            ; embedded text or resource bytes
                    lbra      Code_2B88 ; continue at the distant control-flow target
Code_2C5D           lda       Addr_0029 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    clr       ,S        ; clear the selected byte or register
                    ldu       Data_0027 ; load the value needed by the following operation
                    ldx       ,Y        ; load the value needed by the following operation
                    stu       ,Y        ; save the current value in working storage
                    bsr       Code_2C71 ; call the referenced helper routine
                    puls      U,Y,X,A   ; restore the listed registers from the stack
                    puls      PC,DP     ; restore the listed registers from the stack
Code_2C71           lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,U+       ; store the value and advance the destination pointer
                    bne       Code_2C71 ; branch when the compared values differ
                    rts                 ; return to the caller
Data_2C78           fcc       "("                            ; embedded text or resource bytes
                    fcb       $0B,$02,$0C,$14,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U8P"                          ; embedded text or resource bytes
                    fcb       $17,$02,$18,$14,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U8"                           ; embedded text or resource bytes
Data_2C88           fcb       $02,$03,$00,$06,$05 ; table, bitmap, or initialized data bytes
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
                    fcb       $C0,$00,$00,$1F,$FE ; table, bitmap, or initialized data bytes
Data_2CBF           fcb       $00,$00,$0E,$08,$00 ; table, bitmap, or initialized data bytes
Data_2CC4           fcb       $01,$04   ; table, bitmap, or initialized data bytes
Data_2CC6           fcb       $00,$00,$C8,$00,$18,$01 ; table, bitmap, or initialized data bytes
                    fcb       $08,$00   ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $00,$01,$18,$00,$18,$01 ; table, bitmap, or initialized data bytes
                    fcc       "X"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
Code_2CD8           pshs      D         ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0F       ; private DeskMate service selector
                    cmpb      #$50      ; compare against the limit and set condition flags
                    bne       Code_2CE6 ; branch when the compared values differ
                    tfr       X,D       ; copy the source register into the destination register
                    leax      D,X       ; form the referenced address without reading memory
Code_2CE6           puls      D         ; restore the listed registers from the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "5"                            ; embedded text or resource bytes
                    lda       #$3A      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "5"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_2CF7           pshs      U,DP      ; preserve the listed registers on the stack
                    lbsr      Code_26D8 ; call the referenced helper routine
                    leas      $FE0C,S   ; form the referenced address without reading memory
                    sts       Code_002C ; save the current value in working storage
                    pshs      Y,X,D     ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $16       ; private DeskMate service selector
                    clr       Addr_0031 ; clear the selected byte or register
                    clra                ; clear the selected byte or register
                    leax      Data_2C78,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    leax      Data_2C88,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "G"                            ; embedded text or resource bytes
                    ldb       #$0C      ; load the value needed by the following operation
                    stb       ,X        ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "G"                            ; embedded text or resource bytes
                    ldb       #$02      ; load the value needed by the following operation
                    stb       ,X        ; save the current value in working storage
                    ldx       #Addr_1F1A ; load the value needed by the following operation
                    ldy       #Data_0B06 ; load the value needed by the following operation
                    lda       #$FF      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0E       ; private DeskMate service selector
                    leax      $0A,X     ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0E       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "0"                            ; embedded text or resource bytes
                    std       Addr_002E ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "3"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "2"                            ; embedded text or resource bytes
                    ldb       #$40      ; load the value needed by the following operation
                    ldx       #Addr_0002 ; load the value needed by the following operation
                    leay      -$01,X    ; form the referenced address without reading memory
                    lda       #$31      ; load the value needed by the following operation
                    bsr       Code_2CD8 ; call the referenced helper routine
                    ldx       #Addr_0007 ; load the value needed by the following operation
                    leay      -$06,X    ; form the referenced address without reading memory
                    lda       #$32      ; load the value needed by the following operation
                    lbsr      Code_2CD8 ; call the referenced helper routine
                    ldd       Addr_002E ; load the value needed by the following operation
                    tsta                ; set condition flags from the current value
                    bne       Code_2D67 ; branch when the compared values differ
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "4"                            ; embedded text or resource bytes
Code_2D67           tstb                ; set condition flags from the current value
                    bne       Code_2D6E ; branch when the compared values differ
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "1"                            ; embedded text or resource bytes
Code_2D6E           ldx       $04,S     ; load the value needed by the following operation
                    lda       [,X]      ; load the value needed by the following operation
                    suba      #$30      ; subtract the operand from the running value
                    beq       Code_2D7A ; branch when the compared values are equal
                    cmpa      #$03      ; compare against the limit and set condition flags
                    bcs       Code_2D80 ; branch when carry reports an unsigned underflow or error
Code_2D7A           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "N"                            ; embedded text or resource bytes
                    lda       ,X        ; load the value needed by the following operation
Code_2D80           ldx       #DeskMateService ; load the value needed by the following operation
                    leay      $04,X     ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "@"                            ; embedded text or resource bytes
                    sta       Code_0032 ; save the current value in working storage
                    lbsr      Code_2EB6 ; call the referenced helper routine
                    ldb       #$29      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "N"                            ; embedded text or resource bytes
                    leax      $26,X     ; form the referenced address without reading memory
                    leax      D,X       ; form the referenced address without reading memory
                    ldu       Code_002C ; load the value needed by the following operation
                    ldy       $04,S     ; load the value needed by the following operation
                    ldy       $02,Y     ; load the value needed by the following operation
                    ldd       #Code_01F4 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "L"                            ; embedded text or resource bytes
                    lbcs      Code_2EB2 ; take the distant branch when carry reports an error
                    sta       Code_0030 ; save the current value in working storage
                    beq       Code_2DE6 ; branch when the compared values are equal
                    tfr       A,B       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "K"                            ; embedded text or resource bytes
Code_2DBB           ldx       ,U        ; load the value needed by the following operation
                    leax      -$01,X    ; form the referenced address without reading memory
                    stx       ,U++      ; store the value and advance the destination pointer
                    deca                ; decrement the selected counter
                    bne       Code_2DBB ; branch when the compared values differ
                    leax      Data_2CBF,PCR ; form the referenced address without reading memory
                    ldu       Code_002C ; load the value needed by the following operation
                    stu       ,X        ; save the current value in working storage
                    lda       Code_0030 ; load the value needed by the following operation
                    sta       $04,X     ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0F       ; private DeskMate service selector
                    cmpb      #$50      ; compare against the limit and set condition flags
                    bne       Code_2DDC ; branch when the compared values differ
                    ldb       #$06      ; load the value needed by the following operation
                    stb       $05,X     ; save the current value in working storage
Code_2DDC           clra                ; clear the selected byte or register
                    lbsr      Code_2666 ; call the referenced helper routine
                    ldb       #$01      ; load the value needed by the following operation
                    stb       Data_2CC4,PCR ; save the current value in working storage
Code_2DE6           tst       Code_0030 ; set condition flags from the current value
                    beq       Code_2DEF ; branch when the compared values are equal
                    lbsr      Code_2776 ; call the referenced helper routine
                    bra       Code_2E1C ; continue at the selected control-flow target
Code_2DEF           tfr       X,U       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "E"                            ; embedded text or resource bytes
                    exg       U,X       ; exchange the two register values
                    stb       Addr_0033 ; save the current value in working storage
                    stu       Addr_0034 ; save the current value in working storage
                    sty       Data_0036 ; save the current value in working storage
                    cmpu      #Data_00FF ; compare against the limit and set condition flags
                    bne       Code_2E0C ; branch when the compared values differ
                    cmpb      #$01      ; compare against the limit and set condition flags
                    bne       Code_2E0C ; branch when the compared values differ
                    ldb       #$05      ; load the value needed by the following operation
                    bra       Code_2E1C ; continue at the selected control-flow target
Code_2E0C           clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $16       ; private DeskMate service selector
                    tfr       A,B       ; copy the source register into the destination register
                    cmpb      #$0D      ; compare against the limit and set condition flags
                    bne       Code_2E1C ; branch when the compared values differ
                    clrb                ; clear the selected byte or register
Code_2E1C           tst       Addr_0033 ; set condition flags from the current value
                    beq       Code_2E38 ; branch when the compared values are equal
                    pshs      A         ; preserve the listed registers on the stack
                    lda       Data_0037 ; load the value needed by the following operation
                    cmpa      #$03      ; compare against the limit and set condition flags
                    puls      A         ; restore the listed registers from the stack
                    bhi       Code_2E38 ; branch when the unsigned value is above the limit
                    lda       #$01      ; load the value needed by the following operation
                    ldb       Data_0035 ; load the value needed by the following operation
                    cmpb      #$05      ; compare against the limit and set condition flags
                    lbcs      Code_2D80 ; take the distant branch when carry reports an error
                    inca                ; advance the selected counter
                    lbra      Code_2D80 ; continue at the distant control-flow target
Code_2E38           cmpb      #$0D      ; compare against the limit and set condition flags
                    beq       Code_2E75 ; branch when the compared values are equal
                    cmpb      #$05      ; compare against the limit and set condition flags
                    beq       Code_2EA6 ; branch when the compared values are equal
                    cmpb      #$09      ; compare against the limit and set condition flags
                    beq       Code_2E6B ; branch when the compared values are equal
                    cmpb      #$08      ; compare against the limit and set condition flags
                    beq       Code_2E70 ; branch when the compared values are equal
                    pshs      D         ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $18       ; private DeskMate service selector
                    tstb                ; set condition flags from the current value
                    beq       Code_2E62 ; branch when the compared values are equal
                    lda       Data_0037 ; load the value needed by the following operation
                    cmpa      #$03      ; compare against the limit and set condition flags
                    bhi       Code_2E67 ; branch when the unsigned value is above the limit
                    lda       #$01      ; load the value needed by the following operation
                    ldb       Data_0035 ; load the value needed by the following operation
                    cmpb      #$05      ; compare against the limit and set condition flags
                    bcs       Code_2E60 ; branch when carry reports an unsigned underflow or error
                    inca                ; advance the selected counter
Code_2E60           bsr       Code_2EB6 ; call the referenced helper routine
Code_2E62           puls      D         ; restore the listed registers from the stack
                    lbra      Code_2DE6 ; continue at the distant control-flow target
Code_2E67           lda       Code_0032 ; load the value needed by the following operation
                    bra       Code_2E60 ; continue at the selected control-flow target
Code_2E6B           lda       #$02      ; load the value needed by the following operation
                    lbra      Code_2D80 ; continue at the distant control-flow target
Code_2E70           lda       #$01      ; load the value needed by the following operation
                    lbra      Code_2D80 ; continue at the distant control-flow target
Code_2E75           ldx       Code_002C ; load the value needed by the following operation
                    asla                ; shift left and update carry
                    ldx       A,X       ; load the value needed by the following operation
                    leax      $01,X     ; form the referenced address without reading memory
                    ldy       $04,S     ; load the value needed by the following operation
                    ldu       ,Y        ; load the value needed by the following operation
                    lda       Code_0032 ; load the value needed by the following operation
                    adda      #$30      ; add the operand to the running value
                    ldb       #$3A      ; load the value needed by the following operation
                    std       ,U++      ; store the value and advance the destination pointer
                    ldb       #$08      ; load the value needed by the following operation
Code_2E8B           lda       #$20      ; load the value needed by the following operation
                    tst       ,X        ; set condition flags from the current value
                    beq       Code_2E93 ; branch when the compared values are equal
                    lda       ,X+       ; fetch the next value and advance the source pointer
Code_2E93           sta       ,U+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bne       Code_2E8B ; branch when the compared values differ
                    clr       ,U        ; clear the selected byte or register
                    lda       ,S        ; load the value needed by the following operation
                    clr       ,S        ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "J"                            ; embedded text or resource bytes
                    stb       $01,S     ; save the current value in working storage
                    bra       Code_2EAA ; continue at the selected control-flow target
Code_2EA6           lda       #$FF      ; load the value needed by the following operation
                    sta       ,S        ; save the current value in working storage
Code_2EAA           puls      Y,X,D     ; restore the listed registers from the stack
                    leas      $01F4,S   ; form the referenced address without reading memory
                    puls      PC,U,DP   ; restore the listed registers from the stack
Code_2EB2           stb       $01,S     ; save the current value in working storage
                    bra       Code_2EAA ; continue at the selected control-flow target
Code_2EB6           pshs      X,D       ; preserve the listed registers on the stack
                    cmpa      Addr_0031 ; compare against the limit and set condition flags
                    beq       Code_2EDA ; branch when the compared values are equal
                    deca                ; decrement the selected counter
                    pshs      A         ; preserve the listed registers on the stack
                    ldd       #Data_00FF ; load the value needed by the following operation
                    tst       ,S+       ; set condition flags from the current value
                    bne       Code_2EC8 ; branch when the compared values differ
                    exg       A,B       ; exchange the two register values
Code_2EC8           leax      Data_2CC6,PCR ; form the referenced address without reading memory
                    sta       ,X        ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $13       ; private DeskMate service selector
                    leax      $09,X     ; form the referenced address without reading memory
                    stb       ,X        ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $13       ; private DeskMate service selector
Code_2EDA           puls      X,D       ; restore the listed registers from the stack
                    sta       Addr_0031 ; save the current value in working storage
                    rts                 ; return to the caller
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $80       ; table, bitmap, or initialized data bytes
Data_2EE1           fcc       "?"                            ; embedded text or resource bytes
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
Data_36E3           fcb       $CC,$CC   ; table, bitmap, or initialized data bytes
                    fcc       "33"                           ; embedded text or resource bytes
                    fcb       $CC,$CC   ; table, bitmap, or initialized data bytes
                    fcc       "33"                           ; embedded text or resource bytes
                    fcb       $CC,$CC   ; table, bitmap, or initialized data bytes
                    fcc       "33"                           ; embedded text or resource bytes
                    fcb       $CC,$CC   ; table, bitmap, or initialized data bytes
                    fcc       "33"                           ; embedded text or resource bytes

                    emod
eom                 equ       *
                    end
