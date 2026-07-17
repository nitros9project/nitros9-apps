********************************************************************
* DMALT - DeskMate 3 alternate application launcher
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

                    nam       DMALT
                    ttl       DeskMate 3 alternate application launcher

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct
atrv                set       $00

                    mod       eom,name,tylg,atrv,start,$03D4

name                fcs       /DMALT/ ; OS-9 module name

Addr_0001           equ       $0001     ; absolute address used by original code
Addr_0003           equ       $0003     ; absolute address used by original code
Addr_0024           equ       $0024     ; absolute address used by original code
Addr_0028           equ       $0028     ; absolute address used by original code
Addr_0029           equ       $0029     ; absolute address used by original code
Addr_002C           equ       $002C     ; absolute address used by original code
Addr_002D           equ       $002D     ; absolute address used by original code
Addr_0030           equ       $0030     ; absolute address used by original code
Addr_0039           equ       $0039     ; absolute address used by original code
Addr_EC34           equ       $EC34     ; absolute address used by original code
Addr_EEBB           equ       $EEBB     ; absolute address used by original code
Addr_FF08           equ       $FF08     ; absolute address used by original code
DeskMateService     equ       $0000     ; absolute address used by original code
Addr_0636           equ       $0636     ; absolute address used by original code

start               jmp       >DeskMateService ; dispatch control through the selected target
                    leax      Data_07C3,PCR ; form the referenced address without reading memory
                    tfr       X,D       ; copy the source register into the destination register
                    addd      #Data_0100 ; add the operand to the running value
                    clrb                ; clear the selected byte or register
                    tfr       A,DP      ; copy the source register into the destination register
                    tfr       D,U       ; copy the source register into the destination register
                    sts       $02,U     ; save the current value in working storage
                    leas      $03D3,U   ; form the referenced address without reading memory
Code_002A           leax      Data_3796,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $07       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $06       ; private DeskMate service selector
                    leax      Data_3F98,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
Data_003D           fcb       $08       ; private DeskMate service selector
                    lbra      Code_04DC ; continue at the distant control-flow target
Data_0041           fcc       "("                            ; embedded text or resource bytes
                    fcb       $06,$10,$AF,$FF,$FA,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$AA,$FF,$FF,$FF,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$AA,$FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
Data_0055           fcb       $FA,$FF,$FF,$FA,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$AA,$AA,$AA,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FA,$FF,$FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $08,$13,$AA,$AA,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AF,$FF,$FF,$FF,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$AA,$AF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $AA,$AA,$AA,$AA,$AF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$AA,$AA,$AA ; table, bitmap, or initialized data bytes
Data_00C2           fcb       $AA,$FF,$FF,$FF,$FF,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$AA,$AA,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FA,$AA,$AA,$AA,$AF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FA,$AA,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$FF,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$AF,$FF,$FF,$FF,$FA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$AA,$AA,$FF ; table, bitmap, or initialized data bytes
Data_00EA           fcb       $FF,$FF,$FF,$FA,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$FF,$FF,$FF,$FF,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$AA,$AA,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$AA,$AA,$AA ; table, bitmap, or initialized data bytes
Data_0100           fcb       $AF,$F0,$FF,$F0,$FF ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $AA,$AA   ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $00,$00,$00,$05 ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $AA,$A5,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "UU"                           ; embedded text or resource bytes
                    fcb       $AA       ; table, bitmap, or initialized data bytes
                    fcc       "UUUUUUU"                      ; embedded text or resource bytes
                    fcb       $AA       ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $05,$05,$05 ; table, bitmap, or initialized data bytes
                    fcc       "U_U"                          ; embedded text or resource bytes
                    fcb       $AA       ; table, bitmap, or initialized data bytes
                    fcc       "UUUUU_Z"                      ; embedded text or resource bytes
                    fcb       $AA       ; table, bitmap, or initialized data bytes
                    fcc       "UUUUUU"                       ; embedded text or resource bytes
                    fcb       $AA,$AA,$A5 ; table, bitmap, or initialized data bytes
                    fcc       "UUUUZ"                        ; embedded text or resource bytes
                    fcb       $AA,$AA   ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $06,$14,$AA,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FA,$AA,$AF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$AA   ; table, bitmap, or initialized data bytes
Data_014E           fcb       $AF,$00,$00,$00,$0F,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AF,$05   ; table, bitmap, or initialized data bytes
                    fcc       "UU"                           ; embedded text or resource bytes
                    fcb       $0F,$AA,$AF,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0F,$AA,$AF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$AA,$AF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$AA,$AF,$0F,$0F,$0F ; table, bitmap, or initialized data bytes
                    fcb       $0F,$AA,$AF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$AA,$AF,$0F,$0F,$0F ; table, bitmap, or initialized data bytes
                    fcb       $0F,$AA,$AF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$AA,$AF,$0F,$0F,$0F ; table, bitmap, or initialized data bytes
                    fcb       $0F,$AA,$AF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$AA,$AF,$0F,$0F,$0F ; table, bitmap, or initialized data bytes
                    fcb       $0F,$AA,$AF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$AA,$AF,$0F,$0F,$0F ; table, bitmap, or initialized data bytes
                    fcb       $0F,$AA,$AF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$AA,$AF,$0F,$0F,$0F ; table, bitmap, or initialized data bytes
                    fcb       $0F,$AA,$AF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$AA,$AA,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FA,$AA   ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $06,$11,$AA,$AA,$00,$0A ; table, bitmap, or initialized data bytes
                    fcb       $AA,$AA,$AA,$A0,$FA,$F0 ; table, bitmap, or initialized data bytes
                    fcb       $AA,$AA,$AA,$0F,$FA,$FF ; table, bitmap, or initialized data bytes
                    fcb       $0A,$AA,$A0,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $F0,$AA,$A0,$FF,$FA,$FF ; table, bitmap, or initialized data bytes
                    fcb       $F0,$AA,$0F,$FF,$FA,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$0A,$0F,$FF,$FA,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$0A,$0F,$FF,$FA,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$0A,$00,$FF,$FA,$FF ; table, bitmap, or initialized data bytes
                    fcb       $F0,$0A,$0F,$FF,$FF,$AF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$0A,$0F,$FF,$FF,$FA ; table, bitmap, or initialized data bytes
                    fcb       $FF,$0A,$0F,$FF,$FF,$FA ; table, bitmap, or initialized data bytes
                    fcb       $FF,$0A,$A0,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $F0,$AA,$A0,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $F0,$AA,$AA,$0F,$FA,$FF ; table, bitmap, or initialized data bytes
                    fcb       $0A,$AA,$AA,$A0,$FA,$F0 ; table, bitmap, or initialized data bytes
                    fcb       $AA,$AA,$AA,$AA,$00,$0A ; table, bitmap, or initialized data bytes
                    fcb       $AA,$AA   ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $06,$11,$AF,$AA,$AA,$AF ; table, bitmap, or initialized data bytes
                    fcb       $AA,$AA,$AA,$FA,$AA,$FA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$AA,$AA,$AF,$AF,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$AA,$AA,$AA,$FA,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$AA,$AF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FA,$FA,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $AF,$FF,$F0,$AA,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcb       $0F,$0F,$F0,$AA,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcb       $0F,$0F,$F0,$AA,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcb       $0F,$0F,$F0,$AA,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcb       $0F,$FF,$F0,$AA,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcb       $0F,$0F,$F0,$AA,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcb       $0F,$FF,$F0,$AA,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcb       $0F,$0F,$FA,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $AF,$FF,$FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$AF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FA,$AA,$FA,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AF,$AA   ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $06,$0E,$AA,$AA,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AF,$FF,$AA,$AA,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcb       $FF,$AA,$AA,$AA,$AA,$AF ; table, bitmap, or initialized data bytes
                    fcb       $FA,$AA,$AA,$AB,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FE,$AA,$AA,$AD ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $A5       ; table, bitmap, or initialized data bytes
                    fcc       "~"                            ; embedded text or resource bytes
                    fcb       $AA,$AA,$B5 ; table, bitmap, or initialized data bytes
                    fcc       "j"                            ; embedded text or resource bytes
                    fcb       $95,$DE,$AA,$AA,$D5 ; table, bitmap, or initialized data bytes
                    fcc       "UW^"                          ; embedded text or resource bytes
                    fcb       $AA,$AB   ; table, bitmap, or initialized data bytes
                    fcc       "UU]^"                         ; embedded text or resource bytes
                    fcb       $AA,$AD   ; table, bitmap, or initialized data bytes
                    fcc       "UUu^"                         ; embedded text or resource bytes
                    fcb       $AA,$AF,$FF,$FF,$F5 ; table, bitmap, or initialized data bytes
                    fcc       "z"                            ; embedded text or resource bytes
                    fcb       $AA,$AD   ; table, bitmap, or initialized data bytes
                    fcc       "UUu"                          ; embedded text or resource bytes
                    fcb       $EA,$AA,$AD ; table, bitmap, or initialized data bytes
                    fcc       "UUw"                          ; embedded text or resource bytes
                    fcb       $AA,$AA,$AD ; table, bitmap, or initialized data bytes
                    fcc       "UU~"                          ; embedded text or resource bytes
                    fcb       $AA,$AA,$AF,$FF,$FF,$FA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$AA   ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $04,$0C,$AA,$A8,$0A,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$8F,$F0,$AA,$A8,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$0A,$A8,$F2,$8F,$0A ; table, bitmap, or initialized data bytes
                    fcb       $AA,$F2,$8F,$0A,$AA,$A8 ; table, bitmap, or initialized data bytes
                    fcb       $F0,$AA,$AA,$A8,$F0,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$A8,$F0,$AA,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$AA,$AA,$A8,$F0,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$A8,$F0,$AA,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$AA   ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
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
                    fcb       $AA,$AA,$AA,$AA,$00 ; table, bitmap, or initialized data bytes
Data_034A           fcb       $FF       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $00,$00,$04,$02,$00 ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
                    fcc       "E"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "c"                            ; embedded text or resource bytes
                    fcb       $02,$0C,$00,$26,$FF ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $00,$FE,$02,$19,$00 ; table, bitmap, or initialized data bytes
                    fcc       "+"                            ; embedded text or resource bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "y"                            ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "#"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $01,$E2,$04 ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "K"                            ; embedded text or resource bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
                    fcc       "7"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "B"                            ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "#"                            ; embedded text or resource bytes
                    fcb       $02,$A2,$06 ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "{"                            ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $02,$D5,$06 ; table, bitmap, or initialized data bytes
                    fcc       "I"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "G"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_038B           fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00 ; table, bitmap, or initialized data bytes
Data_0395           fcc       "DMTEXT"                       ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "DMLEDGER"                     ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "DMTERM"                       ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "DMCARDS"                      ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "DMCALN"                       ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "DMPAINT"                      ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "DMMENU"                       ; embedded text or resource bytes
                    fcb       $00,$8D,$07,$97 ; table, bitmap, or initialized data bytes
                    fcc       ")"                            ; embedded text or resource bytes
                    fcb       $D7       ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $8D,$14   ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
Code_03D3           pshs      D         ; preserve the listed registers on the stack
                    ldu       DeskMateService ; load the value needed by the following operation
                    leax      $2D,U     ; form the referenced address without reading memory
                    ldd       #Data_00EA ; load the value needed by the following operation
Code_03DD           clr       ,X+       ; clear the selected byte or register
                    subd      #Addr_0001 ; subtract the operand from the running value
                    bne       Code_03DD ; branch when the compared values differ
                    puls      PC,D      ; restore the listed registers from the stack
Code_03E6           ldb       #$18      ; load the value needed by the following operation
Code_03E8           tfr       B,A       ; copy the source register into the destination register
                    clrb                ; clear the selected byte or register
                    tfr       D,X       ; copy the source register into the destination register
                    tfr       A,B       ; copy the source register into the destination register
                    lda       Addr_0029 ; load the value needed by the following operation
                    ldy       #Data_014E ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0E       ; private DeskMate service selector
                    incb                ; advance the selected counter
                    cmpb      #$C8      ; compare against the limit and set condition flags
                    bhi       Code_0414 ; branch when the unsigned value is above the limit
                    tfr       B,A       ; copy the source register into the destination register
                    clrb                ; clear the selected byte or register
                    tfr       D,X       ; copy the source register into the destination register
                    tfr       A,B       ; copy the source register into the destination register
                    lda       Code_002A ; load the value needed by the following operation
                    ldy       #Data_014E ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0E       ; private DeskMate service selector
                    incb                ; advance the selected counter
                    cmpb      #$C8      ; compare against the limit and set condition flags
                    bcs       Code_03E8 ; branch when carry reports an unsigned underflow or error
Code_0414           rts                 ; return to the caller
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $8E,$C0,$00,$10,$8E,$08 ; table, bitmap, or initialized data bytes
                    fcc       "N"                            ; embedded text or resource bytes
                    fcb       $17,$FB,$F2,$0E ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
Code_0422           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    lda       #$AA      ; load the value needed by the following operation
                    ldx       #DeskMateService ; load the value needed by the following operation
                    ldy       #Data_184E ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0E       ; private DeskMate service selector
                    leau      Data_034A,PCR ; form the referenced address without reading memory
                    leay      Data_0041,PCR ; form the referenced address without reading memory
Code_043B           lda       #$FF      ; load the value needed by the following operation
                    tfr       Y,D       ; copy the source register into the destination register
                    addd      $02,U     ; add the operand to the running value
                    ldx       $04,U     ; load the value needed by the following operation
                    exg       D,X       ; exchange the two register values
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    lda       #$01      ; load the value needed by the following operation
                    sta       ,U++      ; store the value and advance the destination pointer
                    leau      $06,U     ; form the referenced address without reading memory
                    tst       ,U        ; set condition flags from the current value
                    bne       Code_043B ; branch when the compared values differ
                    ldd       #Addr_EEBB ; load the value needed by the following operation
                    sta       Addr_0029 ; save the current value in working storage
                    stb       Code_002A ; save the current value in working storage
                    lbsr      Code_03E6 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $16       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_0462           leau      Data_038B,PCR ; form the referenced address without reading memory
                    ldb       #$01      ; load the value needed by the following operation
                    lbsr      Code_0593 ; call the referenced helper routine
                    leax      $01,U     ; form the referenced address without reading memory
                    lbsr      Code_05A1 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_0471           lda       ,Y+       ; fetch the next value and advance the source pointer
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    beq       Code_047B ; branch when the compared values are equal
                    sta       ,U+       ; store the value and advance the destination pointer
                    bra       Code_0471 ; continue at the selected control-flow target
Code_047B           clr       ,U        ; clear the selected byte or register
                    rts                 ; return to the caller
Code_047E           ldx       Addr_0039 ; load the value needed by the following operation
Code_0480           ldb       ,Y+       ; fetch the next value and advance the source pointer
                    beq       Code_048E ; branch when the compared values are equal
                    cmpb      ,X+       ; compare against the limit and set condition flags
                    beq       Code_0480 ; branch when the compared values are equal
                    inca                ; advance the selected counter
Code_0489           ldb       ,Y+       ; fetch the next value and advance the source pointer
                    bne       Code_0489 ; branch when the compared values differ
                    incb                ; advance the selected counter
Code_048E           rts                 ; return to the caller
Code_048F           pshs      Y         ; preserve the listed registers on the stack
                    clrb                ; clear the selected byte or register
                    clr       Data_003D ; clear the selected byte or register
Code_0494           lda       ,Y        ; load the value needed by the following operation
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    beq       Code_04AF ; branch when the compared values are equal
                    incb                ; advance the selected counter
                    cmpa      #$2F      ; compare against the limit and set condition flags
                    beq       Code_04AB ; branch when the compared values are equal
                    cmpa      #$5A      ; compare against the limit and set condition flags
                    ble       Code_04A7 ; branch when the signed value is at or below the limit
                    suba      #$20      ; subtract the operand from the running value
                    sta       ,Y        ; save the current value in working storage
Code_04A7           leay      $01,Y     ; form the referenced address without reading memory
                    bra       Code_0494 ; continue at the selected control-flow target
Code_04AB           stb       Data_003D ; save the current value in working storage
                    bra       Code_04A7 ; continue at the selected control-flow target
Code_04AF           puls      Y         ; restore the listed registers from the stack
                    clra                ; clear the selected byte or register
                    ldb       Data_003D ; load the value needed by the following operation
                    leay      D,Y       ; form the referenced address without reading memory
                    rts                 ; return to the caller
Code_04B7           ldu       DeskMateService ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0F       ; private DeskMate service selector
                    stb       Addr_002C ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "X"                            ; embedded text or resource bytes
                    ldu       DeskMateService ; load the value needed by the following operation
                    leau      $04,U     ; form the referenced address without reading memory
                    stu       Addr_0039 ; save the current value in working storage
                    tfr       X,Y       ; copy the source register into the destination register
                    bsr       Code_048F ; call the referenced helper routine
                    bsr       Code_0471 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    leay      Data_0395,PCR ; form the referenced address without reading memory
Code_04D4           bsr       Code_047E ; call the referenced helper routine
                    bne       Code_04D4 ; branch when the compared values differ
                    inca                ; advance the selected counter
                    sta       Addr_0028 ; save the current value in working storage
                    rts                 ; return to the caller
Code_04DC           pshs      Y,X,DP,D,CC ; preserve the listed registers on the stack
                    stu       DeskMateService ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "-"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $00       ; private DeskMate service selector
                    lbsr      Code_03D3 ; call the referenced helper routine
                    bsr       Code_04B7 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "3"                            ; embedded text or resource bytes
                    lda       #$28      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $09       ; private DeskMate service selector
                    lbsr      Code_0422 ; call the referenced helper routine
                    lbsr      Code_0462 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "0"                            ; embedded text or resource bytes
                    sta       Addr_002D ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "3"                            ; embedded text or resource bytes
Code_0507           bsr       Code_057D ; call the referenced helper routine
                    bne       Code_0537 ; branch when the compared values differ
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    beq       Code_0507 ; branch when the compared values are equal
                    cmpa      #$03      ; compare against the limit and set condition flags
                    bge       Code_0507 ; branch when the signed value is at least the limit
                    lda       #$01      ; load the value needed by the following operation
                    cmpa      Addr_0030 ; compare against the limit and set condition flags
                    lbeq      Code_05C2 ; take the distant branch when values are equal
                    bsr       Code_0593 ; call the referenced helper routine
                    cmpb      ,U        ; compare against the limit and set condition flags
                    beq       Code_0507 ; branch when the compared values are equal
                    stb       ,U        ; save the current value in working storage
                    lda       #$01      ; load the value needed by the following operation
                    cmpa      -$04,Y    ; compare against the limit and set condition flags
                    beq       Code_052B ; branch when the compared values are equal
                    bra       Code_0507 ; continue at the selected control-flow target
Code_052B           lda       #$AA      ; load the value needed by the following operation
                    sta       ,X        ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $13       ; private DeskMate service selector
                    bsr       Code_05A1 ; call the referenced helper routine
                    bra       Code_0507 ; continue at the selected control-flow target
Code_0537           cmpa      #$0D      ; compare against the limit and set condition flags
                    lbeq      Code_05C2 ; take the distant branch when values are equal
                    cmpa      #$08      ; compare against the limit and set condition flags
                    beq       Code_0559 ; branch when the compared values are equal
                    cmpa      #$09      ; compare against the limit and set condition flags
                    beq       Code_056B ; branch when the compared values are equal
                    cmpa      #$AF      ; compare against the limit and set condition flags
                    bne       Code_054D ; branch when the compared values differ
                    leay      -$0D,U    ; form the referenced address without reading memory
                    bra       Code_05C2 ; continue at the selected control-flow target
Code_054D           cmpa      #$BA      ; compare against the limit and set condition flags
                    beq       Code_0555 ; branch when the compared values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    bne       Code_0507 ; branch when the compared values differ
Code_0555           leay      -$05,U    ; form the referenced address without reading memory
                    bra       Code_05C2 ; continue at the selected control-flow target
Code_0559           dec       ,U        ; decrement the selected counter
Code_055B           leay      -$08,Y    ; form the referenced address without reading memory
                    lda       $03,Y     ; load the value needed by the following operation
                    bne       Code_0563 ; branch when the compared values differ
                    leay      $08,Y     ; form the referenced address without reading memory
Code_0563           lda       #$01      ; load the value needed by the following operation
                    cmpa      -$04,Y    ; compare against the limit and set condition flags
                    beq       Code_052B ; branch when the compared values are equal
                    bra       Code_055B ; continue at the selected control-flow target
Code_056B           inc       ,U        ; advance the selected counter
Code_056D           leay      $08,Y     ; form the referenced address without reading memory
                    lda       -$04,Y    ; load the value needed by the following operation
                    bne       Code_0575 ; branch when the compared values differ
                    leay      -$08,Y    ; form the referenced address without reading memory
Code_0575           lda       #$01      ; load the value needed by the following operation
                    cmpa      -$04,Y    ; compare against the limit and set condition flags
                    beq       Code_052B ; branch when the compared values are equal
                    bra       Code_056D ; continue at the selected control-flow target
Code_057D           ldb       #$80      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    bne       Code_0592 ; branch when the compared values differ
                    pshs      U,Y,X     ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $19       ; private DeskMate service selector
                    stb       Addr_0030 ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    tfr       U,D       ; copy the source register into the destination register
                    puls      U,Y,X     ; restore the listed registers from the stack
Code_0592           rts                 ; return to the caller
Code_0593           leay      -$05,U    ; form the referenced address without reading memory
                    incb                ; advance the selected counter
Code_0596           cmpb      $01,Y     ; compare against the limit and set condition flags
                    bge       Code_059E ; branch when the signed value is at least the limit
                    leay      -$08,Y    ; form the referenced address without reading memory
                    bra       Code_0596 ; continue at the selected control-flow target
Code_059E           ldb       $01,Y     ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_05A1           ldd       #Addr_FF08 ; load the value needed by the following operation
                    sta       ,X        ; save the current value in working storage
                    lda       $01,Y     ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    subd      #Addr_0003 ; subtract the operand from the running value
                    std       $01,X     ; save the current value in working storage
                    ldb       #$01      ; load the value needed by the following operation
                    stb       $04,X     ; save the current value in working storage
                    ldb       -$03,Y    ; load the value needed by the following operation
                    clra                ; clear the selected byte or register
                    addd      $01,X     ; add the operand to the running value
                    std       $05,X     ; save the current value in working storage
                    ldb       #$16      ; load the value needed by the following operation
                    stb       $08,X     ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $13       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_05C2           lda       -$04,Y    ; load the value needed by the following operation
                    cmpa      #$01      ; compare against the limit and set condition flags
                    lbne      Code_0507 ; take the distant branch when values differ
                    pshs      U,Y,X     ; preserve the listed registers on the stack
                    lda       #$55      ; load the value needed by the following operation
                    sta       ,X        ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $13       ; private DeskMate service selector
                    bra       Code_05D6 ; continue at the selected control-flow target
Code_05D6           tfr       PC,X      ; copy the source register into the destination register
                    ldd       $02,Y     ; load the value needed by the following operation
                    leax      D,X       ; form the referenced address without reading memory
                    tfr       X,PC      ; copy the source register into the destination register
                    ble       Code_0624 ; branch when the signed value is at or below the limit
                    leax      $0F,Y     ; form the referenced address without reading memory
                    coma                ; invert every bit in the selected value
                    tsta                ; set condition flags from the current value
                    lsra                ; shift right and expose the low bit through carry
                    comb                ; invert every bit in the selected value
                    ble       Code_062C ; branch when the signed value is at or below the limit
                    tsta                ; set condition flags from the current value
                    fcb       $41       ; table, bitmap, or initialized data bytes
                    inca                ; advance the selected counter
                    lsrb                ; shift right and expose the low bit through carry
                    bgt       Addr_0636 ; branch when the signed value is above the limit
                    inca                ; advance the selected counter
                    negb                ; form the two's-complement negative value
                    tst       Addr_0028 ; set condition flags from the current value
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    lsr       Addr_0024 ; shift right and expose the low bit through carry
                    nop       ;         leave processor state unchanged
                    neg       Data_0055 ; form the two's-complement negative value
                    subb      #$17      ; subtract the operand from the running value
                    tst       Data_00C2 ; set condition flags from the current value
                    bra       Code_0638 ; continue at the selected control-flow target
                    fcb       $17,$10,$18 ; table, bitmap, or initialized data bytes
                    fcc       " 5"                           ; embedded text or resource bytes
                    fcb       $17       ; table, bitmap, or initialized data bytes
                    fcc       ".= 0"                         ; embedded text or resource bytes
                    fcb       $17,$1C   ; table, bitmap, or initialized data bytes
                    fcc       "+ +"                          ; embedded text or resource bytes
                    fcb       $17       ; table, bitmap, or initialized data bytes
                    fcc       "'d"                           ; embedded text or resource bytes
                    fcb       $17,$FE,$0F ; table, bitmap, or initialized data bytes
                    fcc       "5p"                           ; embedded text or resource bytes
                    fcb       $17,$FF,$89 ; table, bitmap, or initialized data bytes
                    fcc       "  "                           ; embedded text or resource bytes
                    fcb       $17,$1E   ; table, bitmap, or initialized data bytes
                    fcc       "% "                           ; embedded text or resource bytes
                    fcb       $19,$96   ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $26,$04,$17 ; table, bitmap, or initialized data bytes
Code_0624           adcb      Addr_EC34 ; add the operand to the running value
                    puls      U,Y,X     ; restore the listed registers from the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
Code_062C           rolb                ; rotate left through carry
                    puls      Y,X,DP,D,CC ; restore the listed registers from the stack
                    ldu       DeskMateService ; load the value needed by the following operation
                    lds       $02,U     ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    asrb                ; shift right while preserving the sign
Code_0638           puls      U,Y,X     ; restore the listed registers from the stack
                    lda       #$FF      ; load the value needed by the following operation
                    sta       ,X        ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $13       ; private DeskMate service selector
                    ldd       #Addr_EEBB ; load the value needed by the following operation
                    sta       Addr_0029 ; save the current value in working storage
                    stb       Code_002A ; save the current value in working storage
                    pshs      U,Y,X     ; preserve the listed registers on the stack
                    lbsr      Code_03E6 ; call the referenced helper routine
                    puls      U,Y,X     ; restore the listed registers from the stack
                    lbra      Code_0507 ; continue at the distant control-flow target
                    fcb       $17,$F9,$BC,$17,$17,$F9 ; table, bitmap, or initialized data bytes
                    fcb       $B8       ; table, bitmap, or initialized data bytes
                    fcc       ">4"                           ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FF,$90,$17,$F9,$AE ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
                    fcb       $0F,$D6,$0F,$D8,$DE,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0F,$D9   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "m"                            ; embedded text or resource bytes
                    fcb       $86,$05,$10 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $84,$97,$D5,$10 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $00,$B2   ; table, bitmap, or initialized data bytes
                    fcc       "4v"                           ; embedded text or resource bytes
                    fcb       $86,$14,$97,$DA,$17,$F9 ; table, bitmap, or initialized data bytes
                    fcb       $8D       ; table, bitmap, or initialized data bytes
                    fcc       "E"                            ; embedded text or resource bytes
                    fcb       $17,$F9,$89,$1D,$0A,$DA ; table, bitmap, or initialized data bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $F4       ; table, bitmap, or initialized data bytes
                    fcc       "5v"                           ; embedded text or resource bytes
                    fcb       $17,$F9,$7F,$17,$17,$F9 ; table, bitmap, or initialized data bytes
                    fcc       "{?"                           ; embedded text or resource bytes
                    fcb       $0F,$D7,$10,$8E,$00,$01 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C9,$00,$D4,$96,$D5,$10 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $89,$10   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "y"                            ; embedded text or resource bytes
                    fcb       $96,$D4,$81 ; table, bitmap, or initialized data bytes
                    fcc       "^'>"                          ; embedded text or resource bytes
                    fcb       $81       ; table, bitmap, or initialized data bytes
                    fcc       "~"                            ; embedded text or resource bytes
                    fcb       $26,$04,$0C,$D8 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $E1,$D6,$D8,$D1,$D9 ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $DB       ; table, bitmap, or initialized data bytes
                    fcc       ".."                           ; embedded text or resource bytes
                    fcb       $81       ; table, bitmap, or initialized data bytes
                    fcc       "\',"                          ; embedded text or resource bytes
                    fcb       $C6       ; table, bitmap, or initialized data bytes
                    fcc       "@"                            ; embedded text or resource bytes
                    fcb       $81       ; table, bitmap, or initialized data bytes
                    fcc       "`'"                           ; embedded text or resource bytes
                    fcb       $06,$81   ; table, bitmap, or initialized data bytes
                    fcc       "|"                            ; embedded text or resource bytes
                    fcb       $26,$08,$C6,$80,$D8,$D6 ; table, bitmap, or initialized data bytes
                    fcb       $D7,$D6   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $C3,$81,$0D,$26,$0C,$17 ; table, bitmap, or initialized data bytes
                    fcb       $F9       ; table, bitmap, or initialized data bytes
                    fcc       "4B"                           ; embedded text or resource bytes
                    fcb       $86,$0A,$17,$F9 ; table, bitmap, or initialized data bytes
                    fcc       ".B "                          ; embedded text or resource bytes
                    fcb       $B3,$D6,$D6,$17,$F9,$26 ; table, bitmap, or initialized data bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $AB,$0C,$D7,$17,$F9,$1E ; table, bitmap, or initialized data bytes
                    fcb       $16,$C6,$80,$17,$F9,$18 ; table, bitmap, or initialized data bytes
                    fcb       $1D,$81,$05 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "M"                            ; embedded text or resource bytes
                    fcb       $26,$0F,$17,$F9,$0D ; table, bitmap, or initialized data bytes
                    fcc       "E"                            ; embedded text or resource bytes
                    fcb       $C1,$01,$26,$EB,$8C,$00 ; table, bitmap, or initialized data bytes
                    fcb       $FF,$26,$02,$0C,$D7,$0D ; table, bitmap, or initialized data bytes
                    fcb       $D7,$10   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
                    fcc       "y"                            ; embedded text or resource bytes
                    fcb       $17,$F8,$F8 ; table, bitmap, or initialized data bytes
                    fcc       "E"                            ; embedded text or resource bytes
                    fcb       $96,$D5,$10 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $8F       ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $16,$00,$96 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$00   ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $17,$F8,$E7 ; table, bitmap, or initialized data bytes
                    fcc       "F "                           ; embedded text or resource bytes
                    fcb       $1B       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$00   ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $17,$F8,$DD ; table, bitmap, or initialized data bytes
                    fcc       "F"                            ; embedded text or resource bytes
                    fcb       $8E,$00,$00,$10,$8E,$00 ; table, bitmap, or initialized data bytes
                    fcb       $01,$17,$F8,$D2 ; table, bitmap, or initialized data bytes
                    fcc       "D0"                           ; embedded text or resource bytes
                    fcb       $8D,$00   ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $17,$F8,$CA ; table, bitmap, or initialized data bytes
                    fcc       "F"                            ; embedded text or resource bytes
                    fcb       $8E,$00,$00,$10,$8E,$00 ; table, bitmap, or initialized data bytes
                    fcb       $03,$17,$F8,$BF ; table, bitmap, or initialized data bytes
                    fcc       "D0"                           ; embedded text or resource bytes
                    fcb       $8D,$00   ; table, bitmap, or initialized data bytes
                    fcc       "G"                            ; embedded text or resource bytes
                    fcb       $17,$F8,$B7 ; table, bitmap, or initialized data bytes
                    fcc       "F"                            ; embedded text or resource bytes
                    fcb       $8E,$00,$00,$10,$8E,$00 ; table, bitmap, or initialized data bytes
                    fcb       $04,$17,$F8,$AC ; table, bitmap, or initialized data bytes
                    fcc       "D0"                           ; embedded text or resource bytes
                    fcb       $8D,$00   ; table, bitmap, or initialized data bytes
                    fcc       "B"                            ; embedded text or resource bytes
                    fcb       $17,$F8,$A4 ; table, bitmap, or initialized data bytes
                    fcc       "F"                            ; embedded text or resource bytes
                    fcb       $C6,$80,$17,$F8,$9E,$1C ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $A0       ; table, bitmap, or initialized data bytes
                    fcc       "Disk read error"              ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "Can not find"                 ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "help file."                   ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "Press any key"                ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "to continue."                 ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $02,$17,$F8 ; table, bitmap, or initialized data bytes
                    fcc       "S7"                           ; embedded text or resource bytes
                    fcb       $16,$FE   ; table, bitmap, or initialized data bytes
                    fcc       "u"                            ; embedded text or resource bytes
Data_07C3           fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
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
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $04,$08,$0A,$AA,$AA,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0A,$00,$0A,$00,$0A,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0A,$00,$0A,$00,$0A,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0A,$00,$0A,$00,$0A,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0A,$00,$0A,$00,$0A,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0A,$AA,$AA,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $04,$08,$0A,$AA,$AF,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0A,$00,$0E,$00,$0A,$00 ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $00,$0A,$00,$CA,$00,$08 ; table, bitmap, or initialized data bytes
                    fcb       $C3,$0A,$00,$0A ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $0A,$00,$0A,$0F,$0A,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0A,$AA,$AA,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $08,$10,$03,$FF,$FF,$C0 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$0F,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$F0,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0F,$FF,$FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $F0,$00,$0F,$FF,$FF,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FF,$FF,$FC,$00,$0F,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$FF,$FF,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0F,$FF,$FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$00,$0F,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$00,$0F,$00 ; table, bitmap, or initialized data bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $03,$C0   ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $00,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F3,$FC,$F3,$CF ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $00,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F3,$FC,$F3,$CF ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $00,$0F,$00,$F3,$FC,$03 ; table, bitmap, or initialized data bytes
                    fcb       $C0       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $00,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $00,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FF,$FF,$FF,$C0 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $00,$0F,$FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$00,$0F,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$FF,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $08,$10,$03,$FF,$FF,$C0 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$0F,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$F0,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0F,$FF,$FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $F0,$00,$0F,$FF,$FF,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FF,$FF,$FC,$00,$0F,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$FF,$FF,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0F,$FF,$FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$00,$0F,$FC,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $CF,$FF,$FF,$00,$0F,$FC ; table, bitmap, or initialized data bytes
                    fcb       $FC,$0C,$00,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $00,$0F,$00,$FF,$CF,$CF ; table, bitmap, or initialized data bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $00,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F0,$0F,$CF,$C0 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $00,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $F3,$CF,$CF,$CF ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $00,$0F,$00,$F0,$0F,$CF ; table, bitmap, or initialized data bytes
                    fcb       $C0       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $00,$0F,$FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$00,$0F,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$FF,$00,$0F ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $00,$03   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $15,$00   ; table, bitmap, or initialized data bytes
                    fcc       "U0("                          ; embedded text or resource bytes
                    fcb       $02,$06   ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $05,$00   ; table, bitmap, or initialized data bytes
                    fcc       "U0 Directory not foun"        ; embedded text or resource bytes
                    fcc       "d"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "create it       cance"        ; embedded text or resource bytes
                    fcc       "l edit"                       ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "Illegal directory nam"        ; embedded text or resource bytes
                    fcc       "e"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "Disk drive error"             ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       " is   Specify pathnam"        ; embedded text or resource bytes
                    fcc       "es for folders:"              ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       " edit               d"        ; embedded text or resource bytes
                    fcc       "one              canc"        ; embedded text or resource bytes
                    fcc       "el"                           ; embedded text or resource bytes
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
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $06       ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $0A       ; table, bitmap, or initialized data bytes
                    fcc       "l"                            ; embedded text or resource bytes
                    fcb       $0E,$8C,$12,$00,$08,$1E ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $08,$80,$02 ; table, bitmap, or initialized data bytes
                    fcc       "42O"                          ; embedded text or resource bytes
                    fcb       $1F,$01,$E6,$E0 ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $1F,$02,$17,$F0,$AA ; table, bitmap, or initialized data bytes
                    fcc       "D5"                           ; embedded text or resource bytes
                    fcb       $B0,$1E,$89,$E6 ; table, bitmap, or initialized data bytes
                    fcc       "b"                            ; embedded text or resource bytes
                    fcb       $C0,$1C,$ED,$84 ; table, bitmap, or initialized data bytes
                    fcc       "94"                           ; embedded text or resource bytes
                    fcb       $06,$8D,$F3,$17,$F0,$97 ; table, bitmap, or initialized data bytes
                    fcc       "G5"                           ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $06,$8D,$E9,$17,$F0,$8D ; table, bitmap, or initialized data bytes
                    fcc       "G5"                           ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $06,$1F,$10 ; table, bitmap, or initialized data bytes
                    fcc       "X"                            ; embedded text or resource bytes
                    fcb       $1F,$01,$1F ; table, bitmap, or initialized data bytes
                    fcc       " X"                           ; embedded text or resource bytes
                    fcb       $1F,$02,$17,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "{#5"                          ; embedded text or resource bytes
                    fcb       $86,$17,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "uN"                           ; embedded text or resource bytes
                    fcb       $9F       ; table, bitmap, or initialized data bytes
                    fcc       ".0"                           ; embedded text or resource bytes
                    fcb       $88       ; table, bitmap, or initialized data bytes
                    fcc       "O3"                           ; embedded text or resource bytes
                    fcb       $8D,$FE,$FE,$86,$04,$97 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $C6       ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $A6,$80,$26,$02,$86 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $A7,$C0   ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $26,$F5,$A6,$80,$A7,$C0 ; table, bitmap, or initialized data bytes
                    fcb       $0A       ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $26,$EB   ; table, bitmap, or initialized data bytes
                    fcc       "93"                           ; embedded text or resource bytes
                    fcb       $8D,$FF,$85 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $8D,$FE,$DC ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $8E,$02,$14 ; table, bitmap, or initialized data bytes
                    fcc       "4R0"                          ; embedded text or resource bytes
                    fcb       $8D,$FD,$92,$81,$02 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FD,$05,$A6,$C0,$C6 ; table, bitmap, or initialized data bytes
                    fcb       $02,$17,$FF,$92,$A6,$C4 ; table, bitmap, or initialized data bytes
                    fcb       $C6,$06,$17,$FF ; table, bitmap, or initialized data bytes
                    fcc       "p"                            ; embedded text or resource bytes
                    fcb       $A6,$E4,$8B ; table, bitmap, or initialized data bytes
                    fcc       "1_"                           ; embedded text or resource bytes
                    fcb       $17,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "4 "                           ; embedded text or resource bytes
                    fcb       $10,$8E,$00,$04 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FE   ; table, bitmap, or initialized data bytes
                    fcc       "W"                            ; embedded text or resource bytes
                    fcb       $17,$F0,$13,$22,$A6,$C0 ; table, bitmap, or initialized data bytes
                    fcb       $C6,$0B,$17,$FF ; table, bitmap, or initialized data bytes
                    fcc       "R5 "                          ; embedded text or resource bytes
                    fcb       $A6,$A0,$17,$F0,$04,$02 ; table, bitmap, or initialized data bytes
                    fcc       "jb"                           ; embedded text or resource bytes
                    fcb       $26,$F6,$A6 ; table, bitmap, or initialized data bytes
                    fcc       "_L"                           ; embedded text or resource bytes
                    fcb       $C6,$0B,$17,$FF ; table, bitmap, or initialized data bytes
                    fcc       ">"                            ; embedded text or resource bytes
                    fcb       $86,$14,$A7 ; table, bitmap, or initialized data bytes
                    fcc       "b_ja"                         ; embedded text or resource bytes
                    fcb       $26,$E5   ; table, bitmap, or initialized data bytes
                    fcc       "1!"                           ; embedded text or resource bytes
                    fcb       $86,$02,$A7 ; table, bitmap, or initialized data bytes
                    fcc       "al"                           ; embedded text or resource bytes
                    fcb       $E4,$A6,$E4,$81,$04,$26 ; table, bitmap, or initialized data bytes
                    fcb       $9D,$8D,$02 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $D2,$CC,$14,$06 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FE   ; table, bitmap, or initialized data bytes
                    fcc       ";"                      ;103C: 3B             ' ; embedded text or resource bytes
                    fcb       $8D,$1C,$CC,$A4,$08 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FC   ; table, bitmap, or initialized data bytes
                    fcc       "u"                            ; embedded text or resource bytes
                    fcb       $17,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "50"                           ; embedded text or resource bytes
                    fcb       $8D,$FC   ; table, bitmap, or initialized data bytes
                    fcc       "I3"                           ; embedded text or resource bytes
                    fcb       $8D,$FF,$03,$E6,$C0 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $05,$17,$FF,$26 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $F7       ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $17,$FE,$FB ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $17,$EF,$B0 ; table, bitmap, or initialized data bytes
                    fcc       "691"                          ; embedded text or resource bytes
                    fcb       $8D,$FE,$EB ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FE,$EB,$A6,$C4,$17 ; table, bitmap, or initialized data bytes
                    fcb       $00,$E2,$8D ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $10,$26,$00,$8C,$81,$03 ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $0B,$D6   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C1,$01,$26,$05,$86,$05 ; table, bitmap, or initialized data bytes
                    fcb       $16,$00   ; table, bitmap, or initialized data bytes
                    fcc       "}"                            ; embedded text or resource bytes
                    fcb       $81,$05   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $E7,$81,$17 ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $E3,$81,$14 ; table, bitmap, or initialized data bytes
                    fcc       "$6"                           ; embedded text or resource bytes
                    fcb       $D6       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C1,$01,$26,$D9 ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $19       ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $A1       ; table, bitmap, or initialized data bytes
                    fcc       "A$"                           ; embedded text or resource bytes
                    fcb       $1A       ; table, bitmap, or initialized data bytes
                    fcc       "3^ "                          ; embedded text or resource bytes
                    fcb       $F8,$C6,$80,$17,$EF ; table, bitmap, or initialized data bytes
                    fcc       "j"                            ; embedded text or resource bytes
                    fcb       $1D,$26,$0D ; table, bitmap, or initialized data bytes
                    fcc       "4p"                           ; embedded text or resource bytes
                    fcb       $17,$EF   ; table, bitmap, or initialized data bytes
                    fcc       "b"                            ; embedded text or resource bytes
                    fcb       $19,$D7   ; table, bitmap, or initialized data bytes
                    fcc       "0O"                           ; embedded text or resource bytes
                    fcb       $1F       ; table, bitmap, or initialized data bytes
                    fcc       "05p9"                         ; embedded text or resource bytes
                    fcb       $A6,$84,$A1,$C4 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $B2,$17,$00,$91,$A6,$C4 ; table, bitmap, or initialized data bytes
                    fcb       $A7,$84   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $A6       ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $8D,$FE,$89,$C1 ; table, bitmap, or initialized data bytes
                    fcc       "3,"                           ; embedded text or resource bytes
                    fcb       $08       ; table, bitmap, or initialized data bytes
                    fcc       "1?"                           ; embedded text or resource bytes
                    fcb       $C1,$1D   ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "1?"                           ; embedded text or resource bytes
                    fcb       $E6,$01,$E1,$A4 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $02,$8D,$0A,$96 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $81,$01,$10 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $00,$8B   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $87,$86,$A4 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FB,$A4,$17,$FE,$89 ; table, bitmap, or initialized data bytes
                    fcb       $E6,$A4   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FB,$C0,$17,$FE,$80 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $10,$E7,$01 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $81,$0A   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $17,$81,$0C ; table, bitmap, or initialized data bytes
                    fcc       "'!"                           ; embedded text or resource bytes
                    fcb       $81,$09   ; table, bitmap, or initialized data bytes
                    fcc       "'0"                           ; embedded text or resource bytes
                    fcb       $81,$08   ; table, bitmap, or initialized data bytes
                    fcc       "'6"                           ; embedded text or resource bytes
                    fcb       $81,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "'\"                           ; embedded text or resource bytes
                    fcb       $81,$05   ; table, bitmap, or initialized data bytes
                    fcc       "'f"                           ; embedded text or resource bytes
                    fcb       $16,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "S"                            ; embedded text or resource bytes
                    fcb       $A6,$C4,$8D ; table, bitmap, or initialized data bytes
                    fcc       "13B"                          ; embedded text or resource bytes
                    fcb       $A6,$C4,$26,$12 ; table, bitmap, or initialized data bytes
                    fcc       "3X "                          ; embedded text or resource bytes
                    fcb       $0C,$A6,$C4,$8D ; table, bitmap, or initialized data bytes
                    fcc       "#3^"                          ; embedded text or resource bytes
                    fcb       $A6       ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $26,$02   ; table, bitmap, or initialized data bytes
                    fcc       "3H"                           ; embedded text or resource bytes
                    fcb       $A6,$C4,$A7,$84,$16,$FF ; table, bitmap, or initialized data bytes
                    fcc       "/"                            ; embedded text or resource bytes
                    fcb       $E6,$A0,$A6,$A4,$26,$99 ; table, bitmap, or initialized data bytes
                    fcc       "1= "                          ; embedded text or resource bytes
                    fcb       $95,$E6,$A4,$A6,$A2,$26 ; table, bitmap, or initialized data bytes
                    fcb       $8F       ; table, bitmap, or initialized data bytes
                    fcc       "1# "                          ; embedded text or resource bytes
                    fcb       $8B       ; table, bitmap, or initialized data bytes
                    fcc       "40"                           ; embedded text or resource bytes
                    fcb       $80,$02,$8B,$04,$C6,$01 ; table, bitmap, or initialized data bytes
                    fcb       $1F,$01,$10,$8E,$14,$06 ; table, bitmap, or initialized data bytes
                    fcb       $17,$FE   ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $8B,$06,$C6,$0B,$1F,$01 ; table, bitmap, or initialized data bytes
                    fcb       $10,$8E,$14,$19,$17,$FE ; table, bitmap, or initialized data bytes
                    fcb       $17       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $B0,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $A6,$A4,$81,$08 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $08,$81,$1E,$10 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $02,$0C   ; table, bitmap, or initialized data bytes
                    fcc       "C94p"                         ; embedded text or resource bytes
                    fcb       $CC,$14,$01,$17,$01,$E7 ; table, bitmap, or initialized data bytes
                    fcb       $17,$EE,$84 ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $CC,$14,$08,$17,$FD,$C4 ; table, bitmap, or initialized data bytes
                    fcb       $86,$01   ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $17,$EE   ; table, bitmap, or initialized data bytes
                    fcc       "w"                            ; embedded text or resource bytes
                    fcb       $0A,$CC,$15,$08,$17,$FD ; table, bitmap, or initialized data bytes
                    fcb       $B7,$86,$02 ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $17,$EE   ; table, bitmap, or initialized data bytes
                    fcc       "j"                            ; embedded text or resource bytes
                    fcb       $0A,$17,$01,$FE ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $04,$A6   ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $C6,$0B,$17,$FD,$A4,$CC ; table, bitmap, or initialized data bytes
                    fcb       $94,$00,$17,$EE ; table, bitmap, or initialized data bytes
                    fcc       "W"                            ; embedded text or resource bytes
                    fcb       $16,$17   ; table, bitmap, or initialized data bytes
                    fcc       "$DM"                          ; embedded text or resource bytes
                    fcb       $26,$26   ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $06       ; table, bitmap, or initialized data bytes
                    fcc       "4p"                           ; embedded text or resource bytes
                    fcb       $17,$EE   ; table, bitmap, or initialized data bytes
                    fcc       "I"                            ; embedded text or resource bytes
                    fcb       $19,$1F   ; table, bitmap, or initialized data bytes
                    fcc       "05p"                          ; embedded text or resource bytes
                    fcb       $81,$14,$26,$06 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $06,$86,$0D ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $10,$81,$15 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $04,$81,$03,$22,$06 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $06,$86,$05 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $06,$81,$05 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $09,$81,$0D ; table, bitmap, or initialized data bytes
                    fcc       "'G"                           ; embedded text or resource bytes
                    fcb       $CC,$14,$00 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $C7       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $04,$1F,$13,$9E ; table, bitmap, or initialized data bytes
                    fcc       ".0"                           ; embedded text or resource bytes
                    fcb       $88       ; table, bitmap, or initialized data bytes
                    fcc       "OZ+"                          ; embedded text or resource bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $88       ; table, bitmap, or initialized data bytes
                    fcc       ") "                           ; embedded text or resource bytes
                    fcb       $F8,$86,$01,$97 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $17,$FD,$9E ; table, bitmap, or initialized data bytes
                    fcc       "O5"                           ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "4w1"                          ; embedded text or resource bytes
                    fcb       $84,$C6,$FF ; table, bitmap, or initialized data bytes
                    fcc       "O4"                           ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $A6,$A5   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $0A,$81   ; table, bitmap, or initialized data bytes
                    fcc       " '"                           ; embedded text or resource bytes
                    fcb       $F7,$A7,$80 ; table, bitmap, or initialized data bytes
                    fcc       "l"                            ; embedded text or resource bytes
                    fcb       $E4       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $F1       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $02,$81   ; table, bitmap, or initialized data bytes
                    fcc       "('"                           ; embedded text or resource bytes
                    fcb       $07,$C6   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $E7,$80   ; table, bitmap, or initialized data bytes
                    fcc       "L "                           ; embedded text or resource bytes
                    fcb       $F5       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $F7,$8D,$D7 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $88       ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $A6,$A2,$81 ; table, bitmap, or initialized data bytes
                    fcc       " '"                           ; embedded text or resource bytes
                    fcb       $FA,$81   ; table, bitmap, or initialized data bytes
                    fcc       "/"                            ; embedded text or resource bytes
                    fcb       $26,$04,$86 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $A7,$A4,$E6,$84,$C1 ; table, bitmap, or initialized data bytes
                    fcc       "/'"                           ; embedded text or resource bytes
                    fcb       $09       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $04,$1F,$13,$C6,$D7,$16 ; table, bitmap, or initialized data bytes
                    fcb       $00,$BB,$86,$81,$10 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $84,$10   ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $01,$03,$17,$ED,$AD ; table, bitmap, or initialized data bytes
                    fcc       ">"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "?L"                           ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "="                            ; embedded text or resource bytes
                    fcb       $17,$ED,$A4,$17 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FB,$7F,$17,$ED,$9C ; table, bitmap, or initialized data bytes
                    fcc       "80"                           ; embedded text or resource bytes
                    fcb       $8D,$FB,$7F,$17,$FD,$E0 ; table, bitmap, or initialized data bytes
                    fcb       $CC,$05,$05 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FB,$8A,$17,$FD,$D3 ; table, bitmap, or initialized data bytes
                    fcc       "\4"                           ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "m"                            ; embedded text or resource bytes
                    fcb       $E4       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $15,$CC   ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FA   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $17,$FC,$E5,$C6,$1B ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$F9,$F7,$17,$FC,$DC ; table, bitmap, or initialized data bytes
                    fcc       "o"                            ; embedded text or resource bytes
                    fcb       $E4,$D6   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C1,$01   ; table, bitmap, or initialized data bytes
                    fcc       "'N"                           ; embedded text or resource bytes
                    fcb       $17,$FD,$F6,$26 ; table, bitmap, or initialized data bytes
                    fcc       "/"                            ; embedded text or resource bytes
                    fcb       $81,$0A   ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $F7,$81,$07 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $F3,$C1,$03 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $EF,$C1   ; table, bitmap, or initialized data bytes
                    fcc       "4$"                           ; embedded text or resource bytes
                    fcb       $EB,$C1,$1C ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $C8       ; table, bitmap, or initialized data bytes
                    fcc       "m"                            ; embedded text or resource bytes
                    fcb       $E4,$26,$DD,$CC ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$F9,$C8,$17,$FC,$AD ; table, bitmap, or initialized data bytes
                    fcb       $C6,$1B   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$F9,$E4,$17,$FC,$A4 ; table, bitmap, or initialized data bytes
                    fcb       $E7,$E4   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $C6,$81,$08 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $10,$81,$09 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $0C,$81,$0D ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $0E,$81,$05,$26,$BC,$A7 ; table, bitmap, or initialized data bytes
                    fcb       $E4       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $06,$A6,$E4 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $D1       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $93,$96   ; table, bitmap, or initialized data bytes
                    fcc       "='"                           ; embedded text or resource bytes
                    fcb       $08,$96   ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $17,$ED,$11 ; table, bitmap, or initialized data bytes
                    fcc       "7"                            ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "="                            ; embedded text or resource bytes
                    fcb       $17,$00,$A3,$1F,$13,$A6 ; table, bitmap, or initialized data bytes
                    fcb       $E4,$26   ; table, bitmap, or initialized data bytes
                    fcc       "Q"                            ; embedded text or resource bytes
                    fcb       $C6,$BF,$10 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $85       ; table, bitmap, or initialized data bytes
                    fcc       "$O"                           ; embedded text or resource bytes
                    fcb       $17,$EC,$FB ; table, bitmap, or initialized data bytes
                    fcc       ">"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $17,$EC,$F5,$17 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FA,$D0,$17,$EC,$ED ; table, bitmap, or initialized data bytes
                    fcc       "80"                           ; embedded text or resource bytes
                    fcb       $8D,$FB,$18,$86,$04,$C1 ; table, bitmap, or initialized data bytes
                    fcb       $D7,$26,$08,$C6,$05 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FA,$F5 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $02,$C6,$08,$17,$FD,$1E ; table, bitmap, or initialized data bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $17,$EC,$D0 ; table, bitmap, or initialized data bytes
                    fcc       "7"                            ; embedded text or resource bytes
                    fcb       $C6,$80,$17,$EC,$CA,$1D ; table, bitmap, or initialized data bytes
                    fcc       "M"                            ; embedded text or resource bytes
                    fcb       $26,$10   ; table, bitmap, or initialized data bytes
                    fcc       "4v"                           ; embedded text or resource bytes
                    fcb       $17,$EC,$C1,$19,$C1,$01 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "5v "                          ; embedded text or resource bytes
                    fcb       $E9       ; table, bitmap, or initialized data bytes
                    fcc       "5v"                           ; embedded text or resource bytes
                    fcb       $1F       ; table, bitmap, or initialized data bytes
                    fcc       "15"                           ; embedded text or resource bytes
                    fcb       $04,$16,$FE,$92 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $04,$CC,$14,$01,$8D,$08 ; table, bitmap, or initialized data bytes
                    fcb       $CC,$15,$01,$8D,$03 ; table, bitmap, or initialized data bytes
                    fcc       "O5"                           ; embedded text or resource bytes
                    fcb       $F4,$17,$FB,$E4,$CC ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $00,$8E,$00 ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $17,$EC,$94,$02 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $1F,$26,$F8 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $A7,$80   ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $26,$FB   ; table, bitmap, or initialized data bytes
                    fcc       "O9"                           ; embedded text or resource bytes
                    fcb       $9E       ; table, bitmap, or initialized data bytes
                    fcc       ".0"                           ; embedded text or resource bytes
                    fcb       $88       ; table, bitmap, or initialized data bytes
                    fcc       "O1"                           ; embedded text or resource bytes
                    fcb       $8D,$FB,$0F,$C6,$A4,$A6 ; table, bitmap, or initialized data bytes
                    fcb       $A0,$81   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $26,$01   ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $A7,$80   ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $26,$F4,$17,$EC ; table, bitmap, or initialized data bytes
                    fcc       "kMC9_0"                       ; embedded text or resource bytes
                    fcb       $8D,$FA,$F6,$A6,$C4,$80 ; table, bitmap, or initialized data bytes
                    fcc       ",'"                           ; embedded text or resource bytes
                    fcb       $08       ; table, bitmap, or initialized data bytes
                    fcc       "\0"                           ; embedded text or resource bytes
                    fcb       $88       ; table, bitmap, or initialized data bytes
                    fcc       ")"                            ; embedded text or resource bytes
                    fcb       $80       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $26,$F8   ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $CC,$00,$00,$17,$F0,$06 ; table, bitmap, or initialized data bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "="                            ; embedded text or resource bytes
                    fcb       $17,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $17,$EC   ; table, bitmap, or initialized data bytes
                    fcc       "F"                            ; embedded text or resource bytes
                    fcb       $0F,$D7   ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $17,$EC   ; table, bitmap, or initialized data bytes
                    fcc       "@Y0"                          ; embedded text or resource bytes
                    fcb       $8D,$FB,$80,$CC ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $08,$ED,$81,$17,$FB,$BB ; table, bitmap, or initialized data bytes
                    fcb       $17,$EC   ; table, bitmap, or initialized data bytes
                    fcc       "0>4"                          ; embedded text or resource bytes
                    fcb       $02,$17,$EC ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $17       ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $8E,$18,$00,$10,$8E,$A8 ; table, bitmap, or initialized data bytes
                    fcc       "@"                            ; embedded text or resource bytes
                    fcb       $17,$EC,$1E,$0E ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$F9,$F1,$17,$EC,$16 ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
                    fcb       $CC,$03,$06,$17,$FB ; table, bitmap, or initialized data bytes
                    fcc       "V0"                           ; embedded text or resource bytes
                    fcb       $8D,$FA   ; table, bitmap, or initialized data bytes
                    fcc       "PO_"                          ; embedded text or resource bytes
                    fcb       $17,$EC,$06,$0A,$17,$FB ; table, bitmap, or initialized data bytes
                    fcb       $B1,$17,$FC ; table, bitmap, or initialized data bytes
                    fcc       "Q4"                           ; embedded text or resource bytes
                    fcb       $01,$A6   ; table, bitmap, or initialized data bytes
                    fcc       "a"                            ; embedded text or resource bytes
                    fcb       $17,$EB,$F8 ; table, bitmap, or initialized data bytes
                    fcc       "75"                           ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $0B       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FB   ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $CC       ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $08,$ED,$84 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $BB       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $02,$17,$EB,$E3 ; table, bitmap, or initialized data bytes
                    fcc       "Y9P"                          ; embedded text or resource bytes
                    fcb       $06,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "0x"                           ; embedded text or resource bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       "000000000"                    ; embedded text or resource bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       "x0"                           ; embedded text or resource bytes
                    fcb       $C0,$CC,$DC,$FF,$DC,$CC ; table, bitmap, or initialized data bytes
                    fcb       $C0,$C0,$03 ; table, bitmap, or initialized data bytes
                    fcc       "3;"                     ;144C: 33 3B          '3 ; embedded text or resource bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
                    fcc       ";3"                     ;144F: 3B 33          ' ; embedded text or resource bytes
                    fcb       $03,$03,$FF,$E7,$C3,$C3 ; table, bitmap, or initialized data bytes
                    fcb       $E7,$FF,$E7,$C3,$C3,$E7 ; table, bitmap, or initialized data bytes
                    fcb       $FF,$E7,$C3,$C3,$E7,$FF ; table, bitmap, or initialized data bytes
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
                    fcb       $00,$00,$00,$00,$02,$00 ; table, bitmap, or initialized data bytes
                    fcb       $03,$03,$00,$0A,$02,$02 ; table, bitmap, or initialized data bytes
                    fcb       $16,$03,$08,$15,$03,$0A ; table, bitmap, or initialized data bytes
                    fcb       $18,$00   ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $00,$03   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $15,$00   ; table, bitmap, or initialized data bytes
                    fcc       "U0("                          ; embedded text or resource bytes
                    fcb       $01,$08   ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $10,$00   ; table, bitmap, or initialized data bytes
                    fcc       "U0("                          ; embedded text or resource bytes
                    fcb       $03,$14   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $03,$00   ; table, bitmap, or initialized data bytes
                    fcc       "U0Printer baud rate i"        ; embedded text or resource bytes
                    fcc       "s:"                           ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "600"                          ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "1200"                         ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "2400"                         ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "4800"                         ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "9600"                         ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "Paper is:"                    ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "Continuous        Sin"        ; embedded text or resource bytes
                    fcc       "gle sheet"                    ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "Printer carriage widt"        ; embedded text or resource bytes
                    fcc       "h:"                           ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "Printer device:"              ; embedded text or resource bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "/P"                           ; embedded text or resource bytes
                    fcb       $0D,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "Value is out of range"        ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "Improper value(s)"            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "Press [ENTER] to cont"        ; embedded text or resource bytes
                    fcc       "inue"                         ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "Press [BREAK] to canc"        ; embedded text or resource bytes
                    fcc       "el"                           ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "42O"                          ; embedded text or resource bytes
                    fcb       $1F,$01   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $03,$E6,$E0,$1F,$02,$17 ; table, bitmap, or initialized data bytes
                    fcb       $EA       ; table, bitmap, or initialized data bytes
                    fcc       ",D5"                          ; embedded text or resource bytes
                    fcb       $B0,$A6,$80,$26,$FC ; table, bitmap, or initialized data bytes
                    fcc       "94V"                          ; embedded text or resource bytes
                    fcb       $1F,$10   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8B       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $88       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $1F       ; table, bitmap, or initialized data bytes
                    fcc       "03"                           ; embedded text or resource bytes
                    fcb       $CB       ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $C8       ; table, bitmap, or initialized data bytes
                    fcc       "05"                           ; embedded text or resource bytes
                    fcb       $06,$17,$EA,$0F,$11 ; table, bitmap, or initialized data bytes
                    fcc       "5P94"                         ; embedded text or resource bytes
                    fcb       $16,$1F,$10 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8B       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $88       ; table, bitmap, or initialized data bytes
                    fcc       "05"                           ; embedded text or resource bytes
                    fcb       $06,$17,$E9,$FD,$12 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $CC,$00,$00,$17,$ED,$AB ; table, bitmap, or initialized data bytes
                    fcb       $17,$ED,$F3,$17,$E9,$ED ; table, bitmap, or initialized data bytes
                    fcb       $0F,$D7   ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $17,$E9,$E7 ; table, bitmap, or initialized data bytes
                    fcc       ">4"                           ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $17,$02,$C3,$17,$03 ; table, bitmap, or initialized data bytes
                    fcc       "N"                            ; embedded text or resource bytes
                    fcb       $17,$E9,$DA ; table, bitmap, or initialized data bytes
                    fcc       "N"                            ; embedded text or resource bytes
                    fcb       $9F       ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $10,$9F   ; table, bitmap, or initialized data bytes
                    fcc       "51"                           ; embedded text or resource bytes
                    fcb       $8D,$FE   ; table, bitmap, or initialized data bytes
                    fcc       "Q"                            ; embedded text or resource bytes
                    fcb       $10,$9F   ; table, bitmap, or initialized data bytes
                    fcc       "7"                            ; embedded text or resource bytes
                    fcb       $17,$04   ; table, bitmap, or initialized data bytes
                    fcc       "y"                            ; embedded text or resource bytes
                    fcb       $17,$04,$CD,$17,$04,$EC ; table, bitmap, or initialized data bytes
                    fcb       $17,$02,$F0,$A6,$C4,$10 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $01,$16,$EC ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $17,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "|"                            ; embedded text or resource bytes
                    fcb       $A6,$C4,$8A,$80 ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $17,$1F,$9F ; table, bitmap, or initialized data bytes
                    fcc       "M"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $81,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $12,$81,$0A ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $0E,$81,$0C ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $1A,$81,$05,$10 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $00,$9F,$A6,$C4 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $E2,$A6,$C4,$17,$06 ; table, bitmap, or initialized data bytes
                    fcc       "I%"                           ; embedded text or resource bytes
                    fcb       $C5       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "J*"                           ; embedded text or resource bytes
                    fcb       $FB,$8D   ; table, bitmap, or initialized data bytes
                    fcc       "v "                           ; embedded text or resource bytes
                    fcb       $BC,$A6   ; table, bitmap, or initialized data bytes
                    fcc       "_'"                           ; embedded text or resource bytes
                    fcb       $B8,$17,$06 ; table, bitmap, or initialized data bytes
                    fcc       "7%"                           ; embedded text or resource bytes
                    fcb       $B3       ; table, bitmap, or initialized data bytes
                    fcc       "3]"                           ; embedded text or resource bytes
                    fcb       $A6,$C4   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $1F       ; table, bitmap, or initialized data bytes
                    fcc       "J*"                           ; embedded text or resource bytes
                    fcb       $FB,$E6   ; table, bitmap, or initialized data bytes
                    fcc       "CO"                           ; embedded text or resource bytes
                    fcb       $1F,$02,$EC ; table, bitmap, or initialized data bytes
                    fcc       "D"                            ; embedded text or resource bytes
                    fcb       $8D       ; table, bitmap, or initialized data bytes
                    fcc       "f "                           ; embedded text or resource bytes
                    fcb       $9F,$17,$04,$8B,$81,$03 ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $0C       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $04,$D6   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C1,$01   ; table, bitmap, or initialized data bytes
                    fcc       "']5"                          ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $8C,$81,$15,$10 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "U4"                           ; embedded text or resource bytes
                    fcb       $04,$17,$06,$03 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $04,$10   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
                    fcc       "{"                            ; embedded text or resource bytes
                    fcb       $81,$14,$10 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $00,$94,$8D ; table, bitmap, or initialized data bytes
                    fcc       "+"                            ; embedded text or resource bytes
                    fcb       $9E       ; table, bitmap, or initialized data bytes
                    fcc       "73"                           ; embedded text or resource bytes
                    fcb       $88,$16,$C1,$06,$10 ; table, bitmap, or initialized data bytes
                    fcc       "#"                            ; embedded text or resource bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
                    fcc       "h"                            ; embedded text or resource bytes
                    fcb       $C1,$17   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $07       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $0E       ; table, bitmap, or initialized data bytes
                    fcc       "3L"                           ; embedded text or resource bytes
                    fcb       $16,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "]"                            ; embedded text or resource bytes
                    fcb       $C1,$12   ; table, bitmap, or initialized data bytes
                    fcc       "#"                            ; embedded text or resource bytes
                    fcb       $0A       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $07       ; table, bitmap, or initialized data bytes
                    fcc       "3F"                           ; embedded text or resource bytes
                    fcb       $81,$07,$10 ; table, bitmap, or initialized data bytes
                    fcc       "#"                            ; embedded text or resource bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
                    fcc       "O0"                           ; embedded text or resource bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "3C"                           ; embedded text or resource bytes
                    fcb       $16,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "H4"                           ; embedded text or resource bytes
                    fcb       $06,$E6,$C0 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $1F,$02,$EC,$C1,$8D,$02 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $86,$17,$FE,$C5,$17,$E8 ; table, bitmap, or initialized data bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       "$95"                          ; embedded text or resource bytes
                    fcb       $04,$8D,$E7,$17,$02,$26 ; table, bitmap, or initialized data bytes
                    fcb       $16,$01,$A5,$17,$E8,$ED ; table, bitmap, or initialized data bytes
                    fcc       ">4"                           ; embedded text or resource bytes
                    fcb       $02,$17,$E8,$E7,$17,$86 ; table, bitmap, or initialized data bytes
                    fcb       $02,$17,$E8,$E1,$10 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FD,$93,$17,$E8,$D9 ; table, bitmap, or initialized data bytes
                    fcc       "80"                           ; embedded text or resource bytes
                    fcb       $8D,$FE   ; table, bitmap, or initialized data bytes
                    fcc       "V"                            ; embedded text or resource bytes
                    fcb       $CC,$00,$01,$17,$02 ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $C6,$80,$17,$E8,$C9,$1C ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $8E,$A2,$03,$10,$8E,$1A ; table, bitmap, or initialized data bytes
                    fcc       "D"                            ; embedded text or resource bytes
                    fcb       $17,$E8,$BD,$0E,$17,$01 ; table, bitmap, or initialized data bytes
                    fcb       $EC       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $02,$17,$E8,$B4 ; table, bitmap, or initialized data bytes
                    fcc       "7"                            ; embedded text or resource bytes
                    fcb       $17,$01,$C4,$9E ; table, bitmap, or initialized data bytes
                    fcc       "73"                           ; embedded text or resource bytes
                    fcb       $88,$16,$16,$FE,$E1,$17 ; table, bitmap, or initialized data bytes
                    fcb       $FF,$96,$9E ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $DE       ; table, bitmap, or initialized data bytes
                    fcc       "7"                            ; embedded text or resource bytes
                    fcb       $17,$01,$EB,$E7,$88,$1F ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $04,$17,$01,$CF,$E7,$88 ; table, bitmap, or initialized data bytes
                    fcb       $1C,$EB,$E0,$C1,$84,$22 ; table, bitmap, or initialized data bytes
                    fcb       $9D,$D7   ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $17,$01,$D5,$E7,$88 ; table, bitmap, or initialized data bytes
                    fcc       " 4"                           ; embedded text or resource bytes
                    fcb       $04,$17,$01,$B9,$E7,$88 ; table, bitmap, or initialized data bytes
                    fcb       $1D,$EB,$E4,$E7,$E4,$17 ; table, bitmap, or initialized data bytes
                    fcb       $01,$AF,$E7,$88,$1E,$E1 ; table, bitmap, or initialized data bytes
                    fcb       $E0,$10   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
                    fcc       "}"                            ; embedded text or resource bytes
                    fcb       $17,$E8   ; table, bitmap, or initialized data bytes
                    fcc       "jM"                           ; embedded text or resource bytes
                    fcb       $17,$01   ; table, bitmap, or initialized data bytes
                    fcc       "I0"                           ; embedded text or resource bytes
                    fcb       $8D,$FD   ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $CC,$00,$01,$17,$01,$C0 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $8D,$03,$BD ; table, bitmap, or initialized data bytes
                    fcc       "O4"                           ; embedded text or resource bytes
                    fcb       $02,$EC,$A1,$81 ; table, bitmap, or initialized data bytes
                    fcc       "X'"                           ; embedded text or resource bytes
                    fcb       $04,$86,$03 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $02,$86,$02,$17,$01,$AA ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $81,$04   ; table, bitmap, or initialized data bytes
                    fcc       "/"                            ; embedded text or resource bytes
                    fcb       $E8,$10,$9E ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $A6,$A4,$80,$02,$C6 ; table, bitmap, or initialized data bytes
                    fcc       "X"                            ; embedded text or resource bytes
                    fcb       $17,$03,$D0,$8B,$02,$A7 ; table, bitmap, or initialized data bytes
                    fcb       $A4       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FD,$18,$CC,$04,$01 ; table, bitmap, or initialized data bytes
                    fcb       $17,$01,$89,$CC,$06,$03 ; table, bitmap, or initialized data bytes
                    fcb       $17,$01,$83,$9E ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $A6,$88   ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $C6       ; table, bitmap, or initialized data bytes
                    fcc       "x"                            ; embedded text or resource bytes
                    fcb       $17,$04   ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $A7,$88   ; table, bitmap, or initialized data bytes
                    fcc       "!0"                           ; embedded text or resource bytes
                    fcb       $8D,$FD   ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $CC,$08,$01,$17,$01 ; table, bitmap, or initialized data bytes
                    fcc       "l"                            ; embedded text or resource bytes
                    fcb       $9E       ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $E6,$88,$22 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $8D,$FC,$91,$17,$02,$C8 ; table, bitmap, or initialized data bytes
                    fcc       "0="                           ; embedded text or resource bytes
                    fcb       $CC,$08,$16,$17,$01 ; table, bitmap, or initialized data bytes
                    fcc       "X0"                           ; embedded text or resource bytes
                    fcb       $1C,$17,$03,$17,$86,$83 ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $17,$1D,$DA ; table, bitmap, or initialized data bytes
                    fcc       "M"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $00,$A4,$81,$0D ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $15,$81,$05,$10 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $00,$A7,$86,$03 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $E9,$10,$8E,$00,$03,$CC ; table, bitmap, or initialized data bytes
                    fcb       $08,$16,$17,$FE,$CA ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $8D,$F3   ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $03,$17,$04,$7F ; table, bitmap, or initialized data bytes
Data_184E           fcc       "%"                            ; embedded text or resource bytes
                    fcb       $C8,$96   ; table, bitmap, or initialized data bytes
                    fcc       "-4"                           ; embedded text or resource bytes
                    fcb       $02,$E1,$E0 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $C0,$9E   ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $E7,$88,$22 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FC,$DF,$CC,$0A,$01 ; table, bitmap, or initialized data bytes
                    fcb       $17,$01,$0F,$10,$9E ; table, bitmap, or initialized data bytes
                    fcc       "51!0"                         ; embedded text or resource bytes
                    fcb       $8D,$FD,$03,$C6,$0A,$A6 ; table, bitmap, or initialized data bytes
                    fcb       $A0,$26,$02,$86 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $A7,$80   ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $26,$F5   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $16,$CC,$0A,$0F,$17,$00 ; table, bitmap, or initialized data bytes
                    fcb       $F1       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $15,$17,$02,$B0,$86,$8A ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $17,$1D   ; table, bitmap, or initialized data bytes
                    fcc       "sM'R"                         ; embedded text or resource bytes
                    fcb       $81,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $13,$81,$05 ; table, bitmap, or initialized data bytes
                    fcc       "'U"                           ; embedded text or resource bytes
                    fcb       $86,$0A   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $ED,$10,$8E,$00,$0A,$CC ; table, bitmap, or initialized data bytes
                    fcb       $0A,$0F,$17,$FE ; table, bitmap, or initialized data bytes
                    fcc       "g9"                           ; embedded text or resource bytes
                    fcb       $8D,$F3,$10,$9E ; table, bitmap, or initialized data bytes
                    fcc       "51!0"                         ; embedded text or resource bytes
                    fcb       $8D,$FC,$BE,$C6,$0A,$A6 ; table, bitmap, or initialized data bytes
                    fcb       $80,$81   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $26,$01   ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $A7,$A0   ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $26,$F4,$17,$E7 ; table, bitmap, or initialized data bytes
                    fcc       "LM5"                          ; embedded text or resource bytes
                    fcb       $02,$17,$E7 ; table, bitmap, or initialized data bytes
                    fcc       "F7"                           ; embedded text or resource bytes
                    fcb       $17,$E7   ; table, bitmap, or initialized data bytes
                    fcc       "BY9"                          ; embedded text or resource bytes
                    fcb       $17,$02   ; table, bitmap, or initialized data bytes
                    fcc       "e"                            ; embedded text or resource bytes
                    fcb       $81,$09   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $06,$81,$16,$10,$26,$FF ; table, bitmap, or initialized data bytes
                    fcc       "h"                            ; embedded text or resource bytes
                    fcb       $17,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $16,$FE   ; table, bitmap, or initialized data bytes
                    fcc       "7"                            ; embedded text or resource bytes
                    fcb       $17,$02   ; table, bitmap, or initialized data bytes
                    fcc       "R"                            ; embedded text or resource bytes
                    fcb       $81,$09   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $04,$81,$16,$26,$BA,$8D ; table, bitmap, or initialized data bytes
                    fcb       $AD,$16,$FE ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $8D       ; table, bitmap, or initialized data bytes
                    fcc       "N"                            ; embedded text or resource bytes
                    fcb       $17,$E7,$18,$17 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FB,$C2 ; table, bitmap, or initialized data bytes
                    fcc       "]4"                           ; embedded text or resource bytes
                    fcb       $01,$CC,$0D,$02,$DD ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $CC,$0C,$02,$DD ; table, bitmap, or initialized data bytes
                    fcc       ";5"                     ;190B: 3B 35          ' ; embedded text or resource bytes
                    fcb       $01,$26,$12,$CC,$12,$02 ; table, bitmap, or initialized data bytes
                    fcb       $DD       ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $CC,$11,$02,$DD ; table, bitmap, or initialized data bytes
                    fcc       ";0"                     ;1919: 3B 30          ' ; embedded text or resource bytes
                    fcb       $18,$17,$E6,$F3 ; table, bitmap, or initialized data bytes
                    fcc       "8 "                           ; embedded text or resource bytes
                    fcb       $04,$17,$E6,$ED ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
                    fcb       $DC       ; table, bitmap, or initialized data bytes
                    fcc       ";"                      ;1927: 3B             ' ; embedded text or resource bytes
                    fcb       $17,$FC,$AD ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FC   ; table, bitmap, or initialized data bytes
                    fcc       "w"                            ; embedded text or resource bytes
                    fcb       $17,$E6,$E0 ; table, bitmap, or initialized data bytes
                    fcc       "F"                            ; embedded text or resource bytes
                    fcb       $DC       ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $17,$FC,$A0 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FC,$84,$17,$E6,$D3 ; table, bitmap, or initialized data bytes
                    fcc       "F9"                           ; embedded text or resource bytes
                    fcb       $86,$05   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $17,$E6,$C9,$10 ; table, bitmap, or initialized data bytes
                    fcc       "9_"                           ; embedded text or resource bytes
                    fcb       $A6,$C0,$80 ; table, bitmap, or initialized data bytes
                    fcc       " '"                           ; embedded text or resource bytes
                    fcb       $05,$80,$10,$C6 ; table, bitmap, or initialized data bytes
                    fcc       "d=4"                          ; embedded text or resource bytes
                    fcb       $04,$8D,$04,$EB,$E4 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $82       ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $A6,$C0,$80 ; table, bitmap, or initialized data bytes
                    fcc       " '"                           ; embedded text or resource bytes
                    fcb       $05,$80,$10,$C6,$0A ; table, bitmap, or initialized data bytes
                    fcc       "="                            ; embedded text or resource bytes
                    fcb       $A6,$C0,$80 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $A7,$C4,$EB,$C4 ; table, bitmap, or initialized data bytes
                    fcc       "o"                            ; embedded text or resource bytes
                    fcb       $C0       ; table, bitmap, or initialized data bytes
                    fcc       "94 "                          ; embedded text or resource bytes
                    fcb       $17,$FC   ; table, bitmap, or initialized data bytes
                    fcc       "]_"                           ; embedded text or resource bytes
                    fcb       $17,$E6,$93 ; table, bitmap, or initialized data bytes
                    fcc       "65 9"                         ; embedded text or resource bytes
                    fcb       $86,$FF,$8E ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $0E,$10,$8E ; table, bitmap, or initialized data bytes
                    fcc       "p "                           ; embedded text or resource bytes
                    fcb       $17,$E6,$83,$0E ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FA,$9F,$17,$E6 ; table, bitmap, or initialized data bytes
                    fcc       "{"                            ; embedded text or resource bytes
                    fcb       $06,$96   ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $17,$E6   ; table, bitmap, or initialized data bytes
                    fcc       "u"                            ; embedded text or resource bytes
                    fcb       $09,$CC,$00,$07 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $06,$CC,$02,$02 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $06       ; table, bitmap, or initialized data bytes
                    fcc       "ob"                           ; embedded text or resource bytes
                    fcb       $17,$00,$BD ; table, bitmap, or initialized data bytes
                    fcc       "lb"                           ; embedded text or resource bytes
                    fcb       $17,$00,$B8 ; table, bitmap, or initialized data bytes
                    fcc       "jc"                           ; embedded text or resource bytes
                    fcb       $26,$F2   ; table, bitmap, or initialized data bytes
                    fcc       "2d"                           ; embedded text or resource bytes
                    fcb       $C6,$FF,$8E,$00 ; table, bitmap, or initialized data bytes
                    fcc       " 1"                           ; embedded text or resource bytes
                    fcb       $08,$CE,$00,$97,$17,$FC ; table, bitmap, or initialized data bytes
                    fcc       ")0"                           ; embedded text or resource bytes
                    fcb       $88,$10,$17,$00,$D3,$8E ; table, bitmap, or initialized data bytes
                    fcb       $00,$97,$17,$00,$CD,$17 ; table, bitmap, or initialized data bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
                    fcc       "m"                            ; embedded text or resource bytes
                    fcb       $CC,$00,$02,$17,$FB,$FE ; table, bitmap, or initialized data bytes
                    fcb       $17,$00,$B1,$CC,$00,$11 ; table, bitmap, or initialized data bytes
                    fcb       $17,$FB,$F5,$17,$00,$A8 ; table, bitmap, or initialized data bytes
                    fcb       $CC,$00,$05,$17,$FB,$EC ; table, bitmap, or initialized data bytes
                    fcb       $86,$82,$17,$00,$A7,$17 ; table, bitmap, or initialized data bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
                    fcc       "Q"                            ; embedded text or resource bytes
                    fcb       $C6,$FF,$10,$8E,$00 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8E,$00,$B0,$CE,$00,$DF ; table, bitmap, or initialized data bytes
                    fcb       $17,$FB,$EB,$10,$8E,$00 ; table, bitmap, or initialized data bytes
                    fcb       $A0,$17,$FB,$E4,$10,$8E ; table, bitmap, or initialized data bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "@3"                           ; embedded text or resource bytes
                    fcb       $C8,$E8,$17,$FB,$DA,$10 ; table, bitmap, or initialized data bytes
                    fcb       $8E,$00,$98,$17,$FB,$D3 ; table, bitmap, or initialized data bytes
                    fcc       "1?"                           ; embedded text or resource bytes
                    fcb       $17,$00,$90,$10,$8E,$00 ; table, bitmap, or initialized data bytes
                    fcc       "@"                            ; embedded text or resource bytes
                    fcb       $17,$00,$89,$C6,$FF,$10 ; table, bitmap, or initialized data bytes
                    fcb       $8E,$00   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $CE,$00,$97,$8E,$00,$BA ; table, bitmap, or initialized data bytes
                    fcb       $17,$FB,$D1 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $A8,$10   ; table, bitmap, or initialized data bytes
                    fcc       "3H0"                          ; embedded text or resource bytes
                    fcb       $88,$18,$17,$FB,$C6,$CC ; table, bitmap, or initialized data bytes
                    fcb       $01,$16,$17,$FB,$91,$8D ; table, bitmap, or initialized data bytes
                    fcc       "I"                            ; embedded text or resource bytes
                    fcb       $CC,$04,$16,$17,$FB,$89 ; table, bitmap, or initialized data bytes
                    fcb       $8D       ; table, bitmap, or initialized data bytes
                    fcc       "E"                            ; embedded text or resource bytes
                    fcb       $CC,$0E,$16,$17,$FB,$81 ; table, bitmap, or initialized data bytes
                    fcb       $8D       ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $CC,$02,$19,$17,$FB ; table, bitmap, or initialized data bytes
                    fcc       "y"                            ; embedded text or resource bytes
                    fcb       $8D       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $CC,$0F,$19,$17,$FB ; table, bitmap, or initialized data bytes
                    fcc       "q"                            ; embedded text or resource bytes
                    fcb       $8D       ; table, bitmap, or initialized data bytes
                    fcc       ")9"                           ; embedded text or resource bytes
                    fcb       $17,$FB   ; table, bitmap, or initialized data bytes
                    fcc       "k"                            ; embedded text or resource bytes
                    fcb       $86,$84,$E6 ; table, bitmap, or initialized data bytes
                    fcc       "d'"                           ; embedded text or resource bytes
                    fcb       $02,$86,$85,$8D ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $A6       ; table, bitmap, or initialized data bytes
                    fcc       "b"                            ; embedded text or resource bytes
                    fcb       $C6,$13,$17,$FB ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $86,$84,$E6 ; table, bitmap, or initialized data bytes
                    fcc       "d'"                           ; embedded text or resource bytes
                    fcb       $02,$86,$85,$8D,$10,$EC ; table, bitmap, or initialized data bytes
                    fcc       "bL"                           ; embedded text or resource bytes
                    fcb       $A7       ; table, bitmap, or initialized data bytes
                    fcc       "b9"                           ; embedded text or resource bytes
                    fcb       $86,$83   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $06,$86,$81 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $02,$86,$80 ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $17,$E5   ; table, bitmap, or initialized data bytes
                    fcc       "v"                            ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "9_"                           ; embedded text or resource bytes
                    fcb       $86,$16,$10,$8E,$00 ; table, bitmap, or initialized data bytes
                    fcc       "@3"                           ; embedded text or resource bytes
                    fcb       $22,$17,$FB ; table, bitmap, or initialized data bytes
                    fcc       "]1$J"                         ; embedded text or resource bytes
                    fcb       $26,$F6   ; table, bitmap, or initialized data bytes
                    fcc       "9_"                           ; embedded text or resource bytes
                    fcb       $86,$19,$8E,$00 ; table, bitmap, or initialized data bytes
                    fcc       "03"                           ; embedded text or resource bytes
                    fcb       $02,$17,$FB ; table, bitmap, or initialized data bytes
                    fcc       "30"                           ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $26,$F6   ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $E6,$88,$1F,$8D ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $ED,$A1,$E6,$88,$1C,$8D ; table, bitmap, or initialized data bytes
                    fcb       $11,$E6,$88 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $8D       ; table, bitmap, or initialized data bytes
                    fcc       "'1!"                          ; embedded text or resource bytes
                    fcb       $ED,$A1,$E6,$88,$1D,$8D ; table, bitmap, or initialized data bytes
                    fcb       $03,$E6,$88,$1E ; table, bitmap, or initialized data bytes
                    fcc       "1!"                           ; embedded text or resource bytes
                    fcb       $8D       ; table, bitmap, or initialized data bytes
                    fcc       "#"                            ; embedded text or resource bytes
                    fcb       $A7,$A0,$8D,$13,$ED,$A1 ; table, bitmap, or initialized data bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $A1       ; table, bitmap, or initialized data bytes
                    fcc       "="                            ; embedded text or resource bytes
                    fcb       $22,$0A,$A6 ; table, bitmap, or initialized data bytes
                    fcc       ">"                            ; embedded text or resource bytes
                    fcb       $81       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $26,$04,$86 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $A7       ; table, bitmap, or initialized data bytes
                    fcc       ">9O"                          ; embedded text or resource bytes
                    fcb       $C0,$0A   ; table, bitmap, or initialized data bytes
                    fcc       "+"                            ; embedded text or resource bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "L "                           ; embedded text or resource bytes
                    fcb       $F9,$CB   ; table, bitmap, or initialized data bytes
                    fcc       ": "                           ; embedded text or resource bytes
                    fcb       $0A       ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $C0       ; table, bitmap, or initialized data bytes
                    fcc       "d%"                           ; embedded text or resource bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "L "                           ; embedded text or resource bytes
                    fcb       $F9,$CB   ; table, bitmap, or initialized data bytes
                    fcc       "dM'"                          ; embedded text or resource bytes
                    fcb       $03,$8B   ; table, bitmap, or initialized data bytes
                    fcc       "09"                           ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       " 9"                           ; embedded text or resource bytes
                    fcb       $9E       ; table, bitmap, or initialized data bytes
                    fcc       "73"                           ; embedded text or resource bytes
                    fcb       $88,$16   ; table, bitmap, or initialized data bytes
                    fcc       "4P"                           ; embedded text or resource bytes
                    fcb       $17,$FE,$1F,$17,$E4,$ED ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $A6,$C0   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $0E,$EC,$C1,$17,$FA,$A9 ; table, bitmap, or initialized data bytes
                    fcb       $17,$E4,$E0 ; table, bitmap, or initialized data bytes
                    fcc       "F"                            ; embedded text or resource bytes
                    fcb       $17,$FA,$B3 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $EE       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $D0,$C6,$80,$17,$E4,$D3 ; table, bitmap, or initialized data bytes
                    fcb       $1D,$26   ; table, bitmap, or initialized data bytes
                    fcc       "$4p"                          ; embedded text or resource bytes
                    fcb       $17,$E4,$CB,$19,$D7 ; table, bitmap, or initialized data bytes
                    fcc       "0O4"                          ; embedded text or resource bytes
                    fcb       $01,$1F   ; table, bitmap, or initialized data bytes
                    fcc       "04"                           ; embedded text or resource bytes
                    fcb       $02,$86,$05,$97 ; table, bitmap, or initialized data bytes
                    fcc       "=OX"                          ; embedded text or resource bytes
                    fcb       $D0       ; table, bitmap, or initialized data bytes
                    fcc       "=%"                           ; embedded text or resource bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "L "                           ; embedded text or resource bytes
                    fcb       $F9,$1E,$89 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "5p94"                         ; embedded text or resource bytes
                    fcb       $06,$1E,$89 ; table, bitmap, or initialized data bytes
                    fcc       "H"                            ; embedded text or resource bytes
                    fcb       $C0       ; table, bitmap, or initialized data bytes
                    fcc       "H"                            ; embedded text or resource bytes
                    fcb       $ED,$84,$17,$E4,$9F ; table, bitmap, or initialized data bytes
                    fcc       "G5"                           ; embedded text or resource bytes
                    fcb       $06       ; table, bitmap, or initialized data bytes
                    fcc       "9X"                           ; embedded text or resource bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "X"                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "X"                            ; embedded text or resource bytes
                    fcb       $17       ; table, bitmap, or initialized data bytes
                    fcc       "`"                            ; embedded text or resource bytes
                    fcb       $06       ; table, bitmap, or initialized data bytes
                    fcc       "`"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "42"                           ; embedded text or resource bytes
                    fcb       $E6,$E4   ; table, bitmap, or initialized data bytes
                    fcc       "XO0"                          ; embedded text or resource bytes
                    fcb       $8D,$F1   ; table, bitmap, or initialized data bytes
                    fcc       "01"                           ; embedded text or resource bytes
                    fcb       $8D,$FF,$E8,$EC,$AB,$17 ; table, bitmap, or initialized data bytes
                    fcb       $FF,$D3   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$F0,$FE ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $E1,$E4   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $0B       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "XO"                           ; embedded text or resource bytes
                    fcb       $EC,$AB,$17,$FF,$C1 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $C1,$04   ; table, bitmap, or initialized data bytes
                    fcc       "/"                            ; embedded text or resource bytes
                    fcb       $EC       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $B2,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "04"                           ; embedded text or resource bytes
                    fcb       $16,$A7,$E4,$17,$FF,$C9 ; table, bitmap, or initialized data bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       "94"                           ; embedded text or resource bytes
                    fcb       $04,$D6   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C1,$01,$10 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $00,$F5   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $04,$17,$FF ; table, bitmap, or initialized data bytes
                    fcc       "q"                            ; embedded text or resource bytes
                    fcb       $26       ; table, bitmap, or initialized data bytes
                    fcc       ">"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $C1,$02   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $E7,$C1,$1E ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $E3,$81,$14 ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $DF,$81,$09 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $DB,$C1,$09 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $08,$C1,$13 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $0F,$86,$02 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $15,$81,$0C ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $04,$86,$03 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "O "                           ; embedded text or resource bytes
                    fcb       $0A,$81,$0C ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $04,$86,$04 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $02,$86,$01,$A1,$E4 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $B6,$17,$FF ; table, bitmap, or initialized data bytes
                    fcc       "|"                            ; embedded text or resource bytes
                    fcb       $A7,$E4   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $AF,$81,$08 ; table, bitmap, or initialized data bytes
                    fcc       "'!"                           ; embedded text or resource bytes
                    fcb       $81,$09   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $0D,$81,$0D,$10 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $00,$B4,$81,$05,$26,$AB ; table, bitmap, or initialized data bytes
                    fcb       $16,$00,$8F,$A6,$E4,$81 ; table, bitmap, or initialized data bytes
                    fcb       $04,$26,$02,$86,$FF ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $A7,$E4,$17,$FF ; table, bitmap, or initialized data bytes
                    fcc       "U "                           ; embedded text or resource bytes
                    fcb       $8A,$A6,$E4,$81,$00,$26 ; table, bitmap, or initialized data bytes
                    fcb       $02,$86,$05 ; table, bitmap, or initialized data bytes
                    fcc       "J "                           ; embedded text or resource bytes
                    fcb       $EE,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "04"                           ; embedded text or resource bytes
                    fcb       $16       ; table, bitmap, or initialized data bytes
                    fcc       "M"                            ; embedded text or resource bytes
                    fcb       $26       ; table, bitmap, or initialized data bytes
                    fcc       "="                            ; embedded text or resource bytes
                    fcb       $C6,$03,$A6 ; table, bitmap, or initialized data bytes
                    fcc       "a0"                           ; embedded text or resource bytes
                    fcb       $8D,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "s"                            ; embedded text or resource bytes
                    fcb       $17,$FF,$1C,$C6,$10 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "E"                            ; embedded text or resource bytes
                    fcb       $17,$FF,$13 ; table, bitmap, or initialized data bytes
                    fcc       "o"                            ; embedded text or resource bytes
                    fcb       $E4       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $04,$D6   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C1,$01   ; table, bitmap, or initialized data bytes
                    fcc       "'[5"                          ; embedded text or resource bytes
                    fcb       $04,$17,$FE,$D7,$26 ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
                    fcb       $C1,$02   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $ED,$C1,$1E ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $E9,$81,$14 ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $E5,$81,$09 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $E1,$C1,$0E ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $1E       ; table, bitmap, or initialized data bytes
                    fcc       "m"                            ; embedded text or resource bytes
                    fcb       $E4,$26,$D9,$C6,$03,$A6 ; table, bitmap, or initialized data bytes
                    fcc       "a0"                           ; embedded text or resource bytes
                    fcb       $8D,$F0,$11,$17,$FE,$DF ; table, bitmap, or initialized data bytes
                    fcb       $C6,$10   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $17,$FE,$D6,$C6,$01,$E7 ; table, bitmap, or initialized data bytes
                    fcb       $E4       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $BF       ; table, bitmap, or initialized data bytes
                    fcc       "m"                            ; embedded text or resource bytes
                    fcb       $E4       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $BB       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $A3,$81,$08 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $11,$81,$09 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $0D,$81,$0D ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $22,$81,$05,$26,$B3 ; table, bitmap, or initialized data bytes
                    fcc       "2f"                           ; embedded text or resource bytes
                    fcb       $16,$FA   ; table, bitmap, or initialized data bytes
                    fcc       "j"                            ; embedded text or resource bytes
                    fcb       $A6,$E4   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $C7,$16,$FF,$87 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $04,$C1,$02 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $EE,$C1,$1E ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $EA,$81,$09 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $E6,$81,$16 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $E2       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       "4R"                           ; embedded text or resource bytes
                    fcb       $C6,$01,$A6,$C4,$81,$02 ; table, bitmap, or initialized data bytes
                    fcb       $26,$18,$8D ; table, bitmap, or initialized data bytes
                    fcc       "@"                            ; embedded text or resource bytes
                    fcb       $A6,$84,$81 ; table, bitmap, or initialized data bytes
                    fcc       " '"                           ; embedded text or resource bytes
                    fcb       $0B,$81   ; table, bitmap, or initialized data bytes
                    fcc       "0%Y"                          ; embedded text or resource bytes
                    fcb       $81       ; table, bitmap, or initialized data bytes
                    fcc       ":$U]'>Z"                      ; embedded text or resource bytes
                    fcb       $A6,$01   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $01,$8D,$26,$26,$10 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $1F,$8D   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $A1,$01   ; table, bitmap, or initialized data bytes
                    fcc       "'="                           ; embedded text or resource bytes
                    fcb       $A1,$02   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $EC       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $1F,$A6,$80,$81 ; table, bitmap, or initialized data bytes
                    fcc       " '"                           ; embedded text or resource bytes
                    fcb       $08,$81   ; table, bitmap, or initialized data bytes
                    fcc       "0%+"                          ; embedded text or resource bytes
                    fcb       $81       ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $22       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $A6,$84   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $C6       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $06,$A6,$01,$81 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $26,$05,$E6,$84,$ED,$84 ; table, bitmap, or initialized data bytes
                    fcc       "O5"                           ; embedded text or resource bytes
                    fcb       $86,$A6,$C4,$81,$02 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $0B       ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $1F,$17,$FC,$18 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $07,$C1,$0A ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "O5"                           ; embedded text or resource bytes
                    fcb       $D2,$17,$E2,$D3 ; table, bitmap, or initialized data bytes
                    fcc       ">4"                           ; embedded text or resource bytes
                    fcb       $02,$17,$E2,$CD,$17,$86 ; table, bitmap, or initialized data bytes
                    fcb       $02,$17,$E2,$C7,$10 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$F7   ; table, bitmap, or initialized data bytes
                    fcc       "y"                            ; embedded text or resource bytes
                    fcb       $17,$E2,$BF ; table, bitmap, or initialized data bytes
                    fcc       "80"                           ; embedded text or resource bytes
                    fcb       $8D,$F8,$26,$CC,$00,$01 ; table, bitmap, or initialized data bytes
                    fcb       $17,$FC,$18,$C6,$80,$17 ; table, bitmap, or initialized data bytes
                    fcb       $E2,$AF,$1C ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $8E,$A2,$03,$10,$8E,$1A ; table, bitmap, or initialized data bytes
                    fcc       "D"                            ; embedded text or resource bytes
                    fcb       $17,$E2,$A3,$0E,$17,$FB ; table, bitmap, or initialized data bytes
                    fcb       $D2       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $02,$17,$E2,$9A ; table, bitmap, or initialized data bytes
                    fcc       "7"                            ; embedded text or resource bytes
                    fcb       $17,$FB,$AA ; table, bitmap, or initialized data bytes
                    fcc       "C5"                           ; embedded text or resource bytes
                    fcb       $D2       ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $04,$07   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $0C,$00   ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $C0,$1F,$1D,$1F,$1E,$1F ; table, bitmap, or initialized data bytes
                    fcb       $1E,$1F,$1F,$1E,$1F,$1E ; table, bitmap, or initialized data bytes
                    fcb       $1F       ; table, bitmap, or initialized data bytes
                    fcc       "Date is:"                     ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "Time is:"                     ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "Press [BREAK] to canc"        ; embedded text or resource bytes
                    fcc       "el"                           ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "Press [ENTER] to cont"        ; embedded text or resource bytes
                    fcc       "inue"                         ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "Format is : MM/DD/YY "        ; embedded text or resource bytes
                    fcc       "        "                     ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "Format is : HH:MM:SS "        ; embedded text or resource bytes
                    fcc       "AM or PM"                     ; embedded text or resource bytes
                    fcb       $00,$A6,$80,$26,$FC ; table, bitmap, or initialized data bytes
                    fcc       "94"                           ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $1F,$01,$E6,$E0,$1F,$02 ; table, bitmap, or initialized data bytes
                    fcc       "90"                           ; embedded text or resource bytes
                    fcb       $C8       ; table, bitmap, or initialized data bytes
                    fcc       "K"                            ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $C6,$13,$A7,$80 ; table, bitmap, or initialized data bytes
                    fcc       "Z*"                           ; embedded text or resource bytes
                    fcb       $FB       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C8       ; table, bitmap, or initialized data bytes
                    fcc       "Ko"                           ; embedded text or resource bytes
                    fcb       $08       ; table, bitmap, or initialized data bytes
                    fcc       "_0"                           ; embedded text or resource bytes
                    fcb       $C8       ; table, bitmap, or initialized data bytes
                    fcc       "f"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $15,$17,$03 ; table, bitmap, or initialized data bytes
                    fcc       "f0"                           ; embedded text or resource bytes
                    fcb       $8D,$FF   ; table, bitmap, or initialized data bytes
                    fcc       ">"                            ; embedded text or resource bytes
                    fcb       $17,$E1,$CE ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
                    fcb       $17,$E1,$CA ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $CC,$01,$01,$17,$FF,$C9 ; table, bitmap, or initialized data bytes
                    fcb       $17,$E1,$C0 ; table, bitmap, or initialized data bytes
                    fcc       "D0"                           ; embedded text or resource bytes
                    fcb       $8D,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $17,$E1,$B8 ; table, bitmap, or initialized data bytes
                    fcc       "F"                            ; embedded text or resource bytes
                    fcb       $CC,$01,$0A,$17,$FF,$B7 ; table, bitmap, or initialized data bytes
                    fcb       $17,$E1,$AE ; table, bitmap, or initialized data bytes
                    fcc       "D0"                           ; embedded text or resource bytes
                    fcb       $C8       ; table, bitmap, or initialized data bytes
                    fcc       "K"                            ; embedded text or resource bytes
                    fcb       $17,$E1,$A7 ; table, bitmap, or initialized data bytes
                    fcc       "F"                            ; embedded text or resource bytes
                    fcb       $CC,$03,$0A,$17,$FF,$A6 ; table, bitmap, or initialized data bytes
                    fcb       $17,$E1,$9D ; table, bitmap, or initialized data bytes
                    fcc       "D0"                           ; embedded text or resource bytes
                    fcb       $C8       ; table, bitmap, or initialized data bytes
                    fcc       "T"                            ; embedded text or resource bytes
                    fcb       $17,$E1,$96 ; table, bitmap, or initialized data bytes
                    fcc       "F"                            ; embedded text or resource bytes
                    fcb       $CC,$03,$01,$17,$FF,$95 ; table, bitmap, or initialized data bytes
                    fcb       $17,$E1,$8C ; table, bitmap, or initialized data bytes
                    fcc       "D0"                           ; embedded text or resource bytes
                    fcb       $8D,$FF,$11,$17,$E1,$84 ; table, bitmap, or initialized data bytes
                    fcc       "F"                            ; embedded text or resource bytes
                    fcb       $17,$FF,$81 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $10,$CC,$08,$01,$17,$FF ; table, bitmap, or initialized data bytes
                    fcc       "~"                            ; embedded text or resource bytes
                    fcb       $17,$E1   ; table, bitmap, or initialized data bytes
                    fcc       "uD5"                          ; embedded text or resource bytes
                    fcb       $10,$17,$E1 ; table, bitmap, or initialized data bytes
                    fcc       "oF"                           ; embedded text or resource bytes
                    fcb       $17,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "l4"                           ; embedded text or resource bytes
                    fcb       $10,$CC,$07,$01,$17,$FF ; table, bitmap, or initialized data bytes
                    fcc       "i"                            ; embedded text or resource bytes
                    fcb       $17,$E1   ; table, bitmap, or initialized data bytes
                    fcc       "`D5"                          ; embedded text or resource bytes
                    fcb       $10,$17,$E1 ; table, bitmap, or initialized data bytes
                    fcc       "ZF"                           ; embedded text or resource bytes
                    fcb       $86,$88,$97 ; table, bitmap, or initialized data bytes
                    fcc       "C946"                         ; embedded text or resource bytes
                    fcb       $CC,$05,$01,$17,$FF ; table, bitmap, or initialized data bytes
                    fcc       "R"                            ; embedded text or resource bytes
                    fcb       $17,$E1   ; table, bitmap, or initialized data bytes
                    fcc       "ID"                           ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $C6,$1E,$17,$E1 ; table, bitmap, or initialized data bytes
                    fcc       "ABZ"                          ; embedded text or resource bytes
                    fcb       $26,$F9   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $B6,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "o"                            ; embedded text or resource bytes
                    fcb       $CC,$01,$0A,$17,$FF ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $17,$E1   ; table, bitmap, or initialized data bytes
                    fcc       "0D"                           ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       "C0"                           ; embedded text or resource bytes
                    fcb       $C8       ; table, bitmap, or initialized data bytes
                    fcc       "K "                           ; embedded text or resource bytes
                    fcb       $11,$0C   ; table, bitmap, or initialized data bytes
                    fcc       "o"                            ; embedded text or resource bytes
                    fcb       $CC,$03,$0A,$17,$FF,$26 ; table, bitmap, or initialized data bytes
                    fcb       $17,$E1,$1D ; table, bitmap, or initialized data bytes
                    fcc       "D"                            ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       "C0"                           ; embedded text or resource bytes
                    fcb       $C8       ; table, bitmap, or initialized data bytes
                    fcc       "T"                            ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "@_"                           ; embedded text or resource bytes
                    fcb       $17,$17,$02 ; table, bitmap, or initialized data bytes
                    fcc       "M"                            ; embedded text or resource bytes
                    fcb       $26       ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $17,$E1,$0B ; table, bitmap, or initialized data bytes
                    fcc       "E4"                           ; embedded text or resource bytes
                    fcb       $04,$10,$8C,$00,$FF ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $0F,$8C,$00,$FF ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $0A,$10,$8C,$00,$08 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $04,$86,$0D ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $02,$86,$05 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $04,$C1,$01,$26,$1E,$10 ; table, bitmap, or initialized data bytes
                    fcb       $8C,$00,$01 ; table, bitmap, or initialized data bytes
                    fcc       "/"                            ; embedded text or resource bytes
                    fcb       $10,$10,$8C,$00,$03 ; table, bitmap, or initialized data bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $12,$86   ; table, bitmap, or initialized data bytes
                    fcc       "D"                            ; embedded text or resource bytes
                    fcb       $17,$E0,$DA,$02,$86,$0A ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $08,$86   ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $17,$E0,$D0,$02,$86,$0C ; table, bitmap, or initialized data bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "B'"                           ; embedded text or resource bytes
                    fcb       $05,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "B"                            ; embedded text or resource bytes
                    fcb       $17,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "p"                            ; embedded text or resource bytes
                    fcb       $81,$05,$10 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $00,$A3,$81,$0C,$26,$22 ; table, bitmap, or initialized data bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "o'"                           ; embedded text or resource bytes
                    fcb       $1E,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "B"                            ; embedded text or resource bytes
                    fcb       $26,$03,$17,$FF ; table, bitmap, or initialized data bytes
                    fcc       "["                            ; embedded text or resource bytes
                    fcb       $CC,$03,$0A,$17,$FE,$AF ; table, bitmap, or initialized data bytes
                    fcb       $17,$E0,$A6 ; table, bitmap, or initialized data bytes
                    fcc       "D0"                           ; embedded text or resource bytes
                    fcb       $C8       ; table, bitmap, or initialized data bytes
                    fcc       "T"                            ; embedded text or resource bytes
                    fcb       $10,$8E,$00,$0B,$17,$E0 ; table, bitmap, or initialized data bytes
                    fcb       $9B,$22   ; table, bitmap, or initialized data bytes
                    fcc       " 2"                           ; embedded text or resource bytes
                    fcb       $81,$0A,$26,$1B,$0D ; table, bitmap, or initialized data bytes
                    fcc       "o"                            ; embedded text or resource bytes
                    fcb       $26,$17,$CC,$01,$0A,$17 ; table, bitmap, or initialized data bytes
                    fcb       $FE,$90,$17,$E0,$87 ; table, bitmap, or initialized data bytes
                    fcc       "D0"                           ; embedded text or resource bytes
                    fcb       $C8       ; table, bitmap, or initialized data bytes
                    fcc       "K"                            ; embedded text or resource bytes
                    fcb       $10,$8E,$00,$08,$17,$E0 ; table, bitmap, or initialized data bytes
                    fcc       "|"                            ; embedded text or resource bytes
                    fcb       $22       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $13,$81,$0D ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $0D,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "o"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $86,$8B,$97 ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $16,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "@"                            ; embedded text or resource bytes
                    fcb       $0C       ; table, bitmap, or initialized data bytes
                    fcc       "@"                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "o"                            ; embedded text or resource bytes
                    fcb       $26,$0A,$0C ; table, bitmap, or initialized data bytes
                    fcc       "o0"                           ; embedded text or resource bytes
                    fcb       $C8       ; table, bitmap, or initialized data bytes
                    fcc       "K1"                           ; embedded text or resource bytes
                    fcb       $C8       ; table, bitmap, or initialized data bytes
                    fcc       "c "                           ; embedded text or resource bytes
                    fcb       $08,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "o0"                           ; embedded text or resource bytes
                    fcb       $C8       ; table, bitmap, or initialized data bytes
                    fcc       "T1"                           ; embedded text or resource bytes
                    fcb       $C8       ; table, bitmap, or initialized data bytes
                    fcc       "`"                            ; embedded text or resource bytes
                    fcb       $8D       ; table, bitmap, or initialized data bytes
                    fcc       "4')"                          ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "z"                            ; embedded text or resource bytes
                    fcb       $17,$00,$A8,$0D ; table, bitmap, or initialized data bytes
                    fcc       "o'"                           ; embedded text or resource bytes
                    fcb       $0A,$96   ; table, bitmap, or initialized data bytes
                    fcc       "z"                            ; embedded text or resource bytes
                    fcb       $81,$03   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $04,$0C   ; table, bitmap, or initialized data bytes
                    fcc       "B 2"                          ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "z'."                          ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "o'"                           ; embedded text or resource bytes
                    fcb       $05,$17,$01,$15 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $03,$17,$01 ; table, bitmap, or initialized data bytes
                    fcc       "M"                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "B'"                           ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $1C       ; table, bitmap, or initialized data bytes
                    fcc       " >0"                          ; embedded text or resource bytes
                    fcb       $C8       ; table, bitmap, or initialized data bytes
                    fcc       "f"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $16       ; table, bitmap, or initialized data bytes
                    fcc       "94"                           ; embedded text or resource bytes
                    fcb       $10,$D6   ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $C4,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $A6,$80,$81 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $26,$03   ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $26,$F7   ; table, bitmap, or initialized data bytes
                    fcc       "]5"                           ; embedded text or resource bytes
                    fcb       $90,$CC,$05,$01,$17,$FE ; table, bitmap, or initialized data bytes
                    fcb       $07,$17,$DF,$FE ; table, bitmap, or initialized data bytes
                    fcc       "D"                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "o'"                           ; embedded text or resource bytes
                    fcb       $0B       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FD,$BA,$17,$DF,$F2 ; table, bitmap, or initialized data bytes
                    fcc       "F"                            ; embedded text or resource bytes
                    fcb       $16,$FE,$B3 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FD,$CD,$17,$DF,$E7 ; table, bitmap, or initialized data bytes
                    fcc       "F"                            ; embedded text or resource bytes
                    fcb       $16,$FE,$BB,$0D ; table, bitmap, or initialized data bytes
                    fcc       "o'"                           ; embedded text or resource bytes
                    fcb       $1C,$CC,$01,$0A,$17,$FD ; table, bitmap, or initialized data bytes
                    fcb       $DF,$17,$DF,$D6 ; table, bitmap, or initialized data bytes
                    fcc       "D0"                           ; embedded text or resource bytes
                    fcb       $C8       ; table, bitmap, or initialized data bytes
                    fcc       "K"                            ; embedded text or resource bytes
                    fcb       $10,$8E,$00,$08,$17,$DF ; table, bitmap, or initialized data bytes
                    fcb       $CB,$22,$86,$8B,$97 ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $16,$FE,$9B,$CC,$03,$0A ; table, bitmap, or initialized data bytes
                    fcb       $17,$FD,$C3,$17,$DF,$BA ; table, bitmap, or initialized data bytes
                    fcc       "D0"                           ; embedded text or resource bytes
                    fcb       $C8       ; table, bitmap, or initialized data bytes
                    fcc       "T"                            ; embedded text or resource bytes
                    fcb       $10,$8E,$00,$0B,$17,$DF ; table, bitmap, or initialized data bytes
                    fcb       $AF,$22,$0D ; table, bitmap, or initialized data bytes
                    fcc       "@'"                           ; embedded text or resource bytes
                    fcb       $04,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "B'"                           ; embedded text or resource bytes
                    fcb       $85,$86,$88,$97 ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $16,$FE   ; table, bitmap, or initialized data bytes
                    fcc       "d4 _1"                        ; embedded text or resource bytes
                    fcb       $C9,$00,$8B,$A6,$80 ; table, bitmap, or initialized data bytes
                    fcc       "'k"                           ; embedded text or resource bytes
                    fcb       $81       ; table, bitmap, or initialized data bytes
                    fcc       "0%"                           ; embedded text or resource bytes
                    fcb       $1B,$81   ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $22,$17,$0F ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $C1,$02   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $05,$A7,$A5 ; table, bitmap, or initialized data bytes
                    fcc       "\ "                           ; embedded text or resource bytes
                    fcb       $E9       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $02,$A6   ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $A7,$A4   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $02,$A7   ; table, bitmap, or initialized data bytes
                    fcc       "! "                           ; embedded text or resource bytes
                    fcb       $DD,$81   ; table, bitmap, or initialized data bytes
                    fcc       " '*"                          ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $26,$04,$97 ; table, bitmap, or initialized data bytes
                    fcc       "A "                           ; embedded text or resource bytes
                    fcb       $22,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "o"                            ; embedded text or resource bytes
                    fcb       $26,$1C,$81 ; table, bitmap, or initialized data bytes
                    fcc       "M'"                           ; embedded text or resource bytes
                    fcb       $04,$81   ; table, bitmap, or initialized data bytes
                    fcc       "m"                            ; embedded text or resource bytes
                    fcb       $26,$14,$96 ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $84,$DF,$81 ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $26,$04,$97 ; table, bitmap, or initialized data bytes
                    fcc       "D "                           ; embedded text or resource bytes
                    fcb       $0A,$81   ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $26,$04,$97 ; table, bitmap, or initialized data bytes
                    fcc       "D "                           ; embedded text or resource bytes
                    fcb       $02,$0C   ; table, bitmap, or initialized data bytes
                    fcc       "B"                            ; embedded text or resource bytes
                    fcb       $C1,$01,$26,$0C ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $02,$A6,$A4,$A7 ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $A7,$A4   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "5 ]'"                         ; embedded text or resource bytes
                    fcb       $07,$0C   ; table, bitmap, or initialized data bytes
                    fcc       "z"                            ; embedded text or resource bytes
                    fcb       $17,$00,$90,$A7,$A0 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $8A       ; table, bitmap, or initialized data bytes
                    fcc       "]'"                           ; embedded text or resource bytes
                    fcb       $0B       ; table, bitmap, or initialized data bytes
                    fcc       "5 "                           ; embedded text or resource bytes
                    fcb       $17,$00,$84,$A7,$A0,$0C ; table, bitmap, or initialized data bytes
                    fcc       "z4 5"                         ; embedded text or resource bytes
                    fcb       $A0       ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $C8       ; table, bitmap, or initialized data bytes
                    fcc       "c"                            ; embedded text or resource bytes
                    fcb       $A6,$22,$81 ; table, bitmap, or initialized data bytes
                    fcc       "c"                            ; embedded text or resource bytes
                    fcb       $22       ; table, bitmap, or initialized data bytes
                    fcc       "l"                            ; embedded text or resource bytes
                    fcb       $A6,$A4   ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $81,$0B,$22 ; table, bitmap, or initialized data bytes
                    fcc       "e"                            ; embedded text or resource bytes
                    fcb       $E6       ; table, bitmap, or initialized data bytes
                    fcc       "!'a0"                         ; embedded text or resource bytes
                    fcb       $8D,$FC   ; table, bitmap, or initialized data bytes
                    fcc       "v"                            ; embedded text or resource bytes
                    fcb       $E1,$86,$22 ; table, bitmap, or initialized data bytes
                    fcc       "Y"                            ; embedded text or resource bytes
                    fcb       $81,$01,$26,$0A,$C1,$1D ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $06,$A6,$22,$84,$03,$26 ; table, bitmap, or initialized data bytes
                    fcc       "K0"                           ; embedded text or resource bytes
                    fcb       $C8       ; table, bitmap, or initialized data bytes
                    fcc       "c1"                           ; embedded text or resource bytes
                    fcb       $C8       ; table, bitmap, or initialized data bytes
                    fcc       "f"                            ; embedded text or resource bytes
                    fcb       $A6,$80,$A7 ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $A6,$80,$A7,$22,$A6,$80 ; table, bitmap, or initialized data bytes
                    fcb       $A7,$A4   ; table, bitmap, or initialized data bytes
                    fcc       "91"                           ; embedded text or resource bytes
                    fcb       $C8       ; table, bitmap, or initialized data bytes
                    fcc       "`"                            ; embedded text or resource bytes
                    fcb       $A6,$A0,$81,$0C,$22 ; table, bitmap, or initialized data bytes
                    fcc       "/"                            ; embedded text or resource bytes
                    fcb       $D6       ; table, bitmap, or initialized data bytes
                    fcc       "D"                            ; embedded text or resource bytes
                    fcb       $C1       ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $26,$04,$8B,$0C ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $05,$81,$0C,$26,$01 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $A7       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $A6,$A0,$81 ; table, bitmap, or initialized data bytes
                    fcc       ";"                      ;2153: 3B             ' ; embedded text or resource bytes
                    fcb       $22,$18,$A6,$A0,$81 ; table, bitmap, or initialized data bytes
                    fcc       ";"                      ;2159: 3B             ' ; embedded text or resource bytes
                    fcb       $22,$12   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C8       ; table, bitmap, or initialized data bytes
                    fcc       "`1"                           ; embedded text or resource bytes
                    fcb       $C8       ; table, bitmap, or initialized data bytes
                    fcc       "f"                            ; embedded text or resource bytes
                    fcb       $C6,$03,$A6,$80,$A7,$A5 ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $C1,$06,$26,$F7 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $0C       ; table, bitmap, or initialized data bytes
                    fcc       "B"                            ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "D94"                          ; embedded text or resource bytes
                    fcb       $14       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C9,$00,$8B,$E6,$80 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $C0       ; table, bitmap, or initialized data bytes
                    fcc       "0'"                           ; embedded text or resource bytes
                    fcb       $05,$8B,$0A ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $26,$FB,$AB,$80,$80 ; table, bitmap, or initialized data bytes
                    fcc       "05"                           ; embedded text or resource bytes
                    fcb       $94       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $16       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C9,$00,$8B ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $C0,$0A   ; table, bitmap, or initialized data bytes
                    fcc       "+"                            ; embedded text or resource bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "L "                           ; embedded text or resource bytes
                    fcb       $F9,$CB   ; table, bitmap, or initialized data bytes
                    fcc       ":"                            ; embedded text or resource bytes
                    fcb       $8B       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $ED,$81   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C8       ; table, bitmap, or initialized data bytes
                    fcc       "f"                            ; embedded text or resource bytes
                    fcb       $E6,$01,$8D,$E3 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $C8       ; table, bitmap, or initialized data bytes
                    fcc       "K0"                           ; embedded text or resource bytes
                    fcb       $C9,$00,$8B,$EC,$81,$ED ; table, bitmap, or initialized data bytes
                    fcb       $A1       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $10,$86   ; table, bitmap, or initialized data bytes
                    fcc       "/"                            ; embedded text or resource bytes
                    fcb       $A7,$A0,$E6,$02,$8D,$CC ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C9,$00,$8B,$EC,$81,$ED ; table, bitmap, or initialized data bytes
                    fcb       $A1       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $10,$86   ; table, bitmap, or initialized data bytes
                    fcc       "/"                            ; embedded text or resource bytes
                    fcb       $A7,$A0,$E6,$84,$8D,$B8 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C9,$00,$8B,$EC,$81,$ED ; table, bitmap, or initialized data bytes
                    fcb       $A1       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $C8       ; table, bitmap, or initialized data bytes
                    fcc       "T"                            ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "D"                            ; embedded text or resource bytes
                    fcb       $A7       ; table, bitmap, or initialized data bytes
                    fcc       ")"                            ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       "M"                            ; embedded text or resource bytes
                    fcb       $A7       ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $E6,$03,$C1,$0C ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $08,$C0,$0C,$86 ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "D"                            ; embedded text or resource bytes
                    fcb       $A7       ; table, bitmap, or initialized data bytes
                    fcc       ")]"                           ; embedded text or resource bytes
                    fcb       $26,$02,$CB,$0C,$8D,$8A ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C9,$00,$8B,$EC,$81,$ED ; table, bitmap, or initialized data bytes
                    fcb       $A1       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $10,$86   ; table, bitmap, or initialized data bytes
                    fcc       ":"                            ; embedded text or resource bytes
                    fcb       $A7,$A0,$E6,$04,$17,$FF ; table, bitmap, or initialized data bytes
                    fcc       "u4"                           ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C9,$00,$8B,$EC,$81,$ED ; table, bitmap, or initialized data bytes
                    fcb       $A1       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $10,$86   ; table, bitmap, or initialized data bytes
                    fcc       ":"                            ; embedded text or resource bytes
                    fcb       $A7,$A0,$E6,$05,$17,$FF ; table, bitmap, or initialized data bytes
                    fcc       "`0"                           ; embedded text or resource bytes
                    fcb       $C9,$00,$8B,$EC,$81,$ED ; table, bitmap, or initialized data bytes
                    fcb       $A1       ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $CC,$EE,$BB,$17,$E1,$8E ; table, bitmap, or initialized data bytes
                    fcb       $17,$DD,$D3 ; table, bitmap, or initialized data bytes
                    fcc       ">4"                           ; embedded text or resource bytes
                    fcb       $02,$17,$DD,$CD,$17,$17 ; table, bitmap, or initialized data bytes
                    fcb       $FB,$D9,$17,$DD,$C6,$16 ; table, bitmap, or initialized data bytes
                    fcb       $17,$FC,$87 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $02,$17,$DD,$BD ; table, bitmap, or initialized data bytes
                    fcc       "79("                          ; embedded text or resource bytes
                    fcb       $05,$07,$1C,$0B,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $C0       ; table, bitmap, or initialized data bytes
                    fcc       "Choose type of cursor"        ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "control device:"              ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "Mouse or Joystick"            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "Keyboard only"                ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "Press [ENTER] to cont"        ; embedded text or resource bytes
                    fcc       "inue"                         ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "Press [BREAK] to canc"        ; embedded text or resource bytes
                    fcc       "el"                           ; embedded text or resource bytes
                    fcb       $00,$A6,$80,$26,$FC ; table, bitmap, or initialized data bytes
                    fcc       "94"                           ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $1F,$01,$E6,$E0,$1F,$02 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $17,$DD   ; table, bitmap, or initialized data bytes
                    fcc       ")"                            ; embedded text or resource bytes
                    fcb       $17       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "i"                            ; embedded text or resource bytes
                    fcb       $17,$DD   ; table, bitmap, or initialized data bytes
                    fcc       "!8"                           ; embedded text or resource bytes
                    fcb       $17,$DD,$1D ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $17,$DD,$19 ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $CC,$00,$01,$17,$FF,$DC ; table, bitmap, or initialized data bytes
                    fcb       $17,$DD,$0F ; table, bitmap, or initialized data bytes
                    fcc       "D0"                           ; embedded text or resource bytes
                    fcb       $8D,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "W"                            ; embedded text or resource bytes
                    fcb       $17,$DD,$07 ; table, bitmap, or initialized data bytes
                    fcc       "F"                            ; embedded text or resource bytes
                    fcb       $17,$FF,$C8 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $10,$CC,$01,$03,$17,$FF ; table, bitmap, or initialized data bytes
                    fcb       $C5,$17,$DC,$F8 ; table, bitmap, or initialized data bytes
                    fcc       "D5"                           ; embedded text or resource bytes
                    fcb       $10,$17,$DC,$F2 ; table, bitmap, or initialized data bytes
                    fcc       "F"                            ; embedded text or resource bytes
                    fcb       $17,$FF,$B3 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $10,$CC,$03,$06,$17,$FF ; table, bitmap, or initialized data bytes
                    fcb       $B0,$17,$DC,$E3 ; table, bitmap, or initialized data bytes
                    fcc       "D5"                           ; embedded text or resource bytes
                    fcb       $10,$17,$DC,$DD ; table, bitmap, or initialized data bytes
                    fcc       "F"                            ; embedded text or resource bytes
                    fcb       $17,$FF,$9E ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $10,$CC,$05,$06,$17,$FF ; table, bitmap, or initialized data bytes
                    fcb       $9B,$17,$DC,$CE ; table, bitmap, or initialized data bytes
                    fcc       "D5"                           ; embedded text or resource bytes
                    fcb       $10,$17,$DC,$C8 ; table, bitmap, or initialized data bytes
                    fcc       "F"                            ; embedded text or resource bytes
                    fcb       $17,$FF,$89 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $10,$CC,$07,$01,$17,$FF ; table, bitmap, or initialized data bytes
                    fcb       $86,$17,$DC,$B9 ; table, bitmap, or initialized data bytes
                    fcc       "D5"                           ; embedded text or resource bytes
                    fcb       $10,$17,$DC,$B3 ; table, bitmap, or initialized data bytes
                    fcc       "F"                            ; embedded text or resource bytes
                    fcb       $17,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "t4"                           ; embedded text or resource bytes
                    fcb       $10,$CC,$08,$01,$17,$FF ; table, bitmap, or initialized data bytes
                    fcc       "q"                            ; embedded text or resource bytes
                    fcb       $17,$DC,$A4 ; table, bitmap, or initialized data bytes
                    fcc       "D5"                           ; embedded text or resource bytes
                    fcb       $10,$17,$DC,$9E ; table, bitmap, or initialized data bytes
                    fcc       "F"                            ; embedded text or resource bytes
                    fcb       $CE,$02   ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $DF       ; table, bitmap, or initialized data bytes
                    fcc       "{"                            ; embedded text or resource bytes
                    fcb       $CE,$02,$18,$8D,$05,$17 ; table, bitmap, or initialized data bytes
                    fcb       $DC,$90,$16 ; table, bitmap, or initialized data bytes
                    fcc       "94"                           ; embedded text or resource bytes
                    fcb       $06,$EF   ; table, bitmap, or initialized data bytes
                    fcc       "~'"                           ; embedded text or resource bytes
                    fcb       $1A,$DC   ; table, bitmap, or initialized data bytes
                    fcc       "{0"                           ; embedded text or resource bytes
                    fcb       $8D,$E9,$06,$ED,$84,$17 ; table, bitmap, or initialized data bytes
                    fcb       $DC       ; table, bitmap, or initialized data bytes
                    fcc       "}G"                           ; embedded text or resource bytes
                    fcb       $1F       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $DD       ; table, bitmap, or initialized data bytes
                    fcc       "{0"                           ; embedded text or resource bytes
                    fcb       $8D,$E9,$1D,$ED,$84,$17 ; table, bitmap, or initialized data bytes
                    fcb       $DC       ; table, bitmap, or initialized data bytes
                    fcc       "oG5"                          ; embedded text or resource bytes
                    fcb       $86,$CE,$00,$00,$C6,$80 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $17,$DC   ; table, bitmap, or initialized data bytes
                    fcc       "c"                            ; embedded text or resource bytes
                    fcb       $1D,$26   ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $17,$DC   ; table, bitmap, or initialized data bytes
                    fcc       "]E4"                          ; embedded text or resource bytes
                    fcb       $04,$8C,$00,$FF ; table, bitmap, or initialized data bytes
                    fcc       "'$"                           ; embedded text or resource bytes
                    fcb       $10,$8C,$00,$FF ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $1E,$86,$0D,$10,$8C,$00 ; table, bitmap, or initialized data bytes
                    fcb       $08       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $16,$10,$8C,$00,$05 ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $0B,$10,$8C,$00,$07 ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $0F,$CE,$02 ; table, bitmap, or initialized data bytes
                    fcc       "( "                           ; embedded text or resource bytes
                    fcb       $0A,$CE,$02,$18 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $05,$CE,$00,$00,$86,$05 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $04,$C1,$01 ; table, bitmap, or initialized data bytes
                    fcc       "'-"                           ; embedded text or resource bytes
                    fcb       $11,$93   ; table, bitmap, or initialized data bytes
                    fcc       "{'"                           ; embedded text or resource bytes
                    fcb       $B5,$8D,$91 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $B1,$81,$05 ; table, bitmap, or initialized data bytes
                    fcc       "'H"                           ; embedded text or resource bytes
                    fcb       $81,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $1C,$81,$0C,$26,$05,$CE ; table, bitmap, or initialized data bytes
                    fcb       $02,$18   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $07,$81,$0A,$26,$9C,$CE ; table, bitmap, or initialized data bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $11,$93   ; table, bitmap, or initialized data bytes
                    fcc       "{"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $FF,$92,$17,$FF ; table, bitmap, or initialized data bytes
                    fcc       "m "                           ; embedded text or resource bytes
                    fcb       $8D,$81,$05 ; table, bitmap, or initialized data bytes
                    fcc       "'$"                           ; embedded text or resource bytes
                    fcb       $86,$01,$DE ; table, bitmap, or initialized data bytes
                    fcc       "{"                            ; embedded text or resource bytes
                    fcb       $11,$83,$02,$18 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $07,$17,$DB,$E8,$15 ; table, bitmap, or initialized data bytes
                    fcc       "O "                           ; embedded text or resource bytes
                    fcb       $08,$17,$DB,$E1,$14,$17 ; table, bitmap, or initialized data bytes
                    fcb       $DB,$DD,$16,$17,$DB,$D9 ; table, bitmap, or initialized data bytes
                    fcc       "N"                            ; embedded text or resource bytes
                    fcb       $A7,$88   ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $17,$DB,$D2 ; table, bitmap, or initialized data bytes
                    fcc       "M9"                           ; embedded text or resource bytes
                    fcb       $CC,$EE,$BB,$17,$DF,$82 ; table, bitmap, or initialized data bytes
                    fcb       $17,$DB,$C7 ; table, bitmap, or initialized data bytes
                    fcc       ">"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $17,$FE,$95,$17,$FF ; table, bitmap, or initialized data bytes
                    fcc       "R"                            ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $17,$DB,$B9 ; table, bitmap, or initialized data bytes
                    fcc       "79ACCDATA"                    ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "BG"                           ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "FG"                           ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "CB"                           ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "WB"                           ; embedded text or resource bytes
                    fcb       $00,$00,$1B,$09,$22 ; table, bitmap, or initialized data bytes
                    fcc       "'(6"                          ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       ",8"                           ; embedded text or resource bytes
                    fcb       $1D,$0C,$12,$1A,$07 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $00,$FF,$11,$22 ; table, bitmap, or initialized data bytes
                    fcc       "3DUfw"                        ; embedded text or resource bytes
                    fcb       $88,$99,$AA,$BB,$CC,$DD ; table, bitmap, or initialized data bytes
                    fcb       $EE       ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $00,$00   ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $18,$00,$11,$C0,$FF,$01 ; table, bitmap, or initialized data bytes
                    fcc       "t"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "~"                            ; embedded text or resource bytes
                    fcb       $01,$90,$00,$8A,$FF,$01 ; table, bitmap, or initialized data bytes
                    fcb       $D4,$00   ; table, bitmap, or initialized data bytes
                    fcc       "~"                            ; embedded text or resource bytes
                    fcb       $01,$F0,$00,$8A,$FF,$02 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "~"                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $00,$8A,$FF,$01 ; table, bitmap, or initialized data bytes
                    fcc       "x"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "s"                            ; embedded text or resource bytes
                    fcb       $01,$88,$00 ; table, bitmap, or initialized data bytes
                    fcc       "w"                            ; embedded text or resource bytes
                    fcb       $FF,$01,$D8,$00 ; table, bitmap, or initialized data bytes
                    fcc       "s"                            ; embedded text or resource bytes
                    fcb       $01,$E8,$00 ; table, bitmap, or initialized data bytes
                    fcc       "w"                            ; embedded text or resource bytes
                    fcb       $FF,$02   ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "s"                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "H"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "w40 Columns"                  ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "80 Columns"                   ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "Reset Colors  "               ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "Select Columns"               ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "Select Palette"               ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "Modify Color  "               ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "Mode: "                       ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $04,$08,$22,$22,$22,$22 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $00,$00,$02 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $00,$00,$02 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $00,$00,$02 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $00,$00,$02 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $00,$00,$02 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $00,$00,$02,$22,$22,$22 ; table, bitmap, or initialized data bytes
                    fcb       $22       ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $04,$08,$22,$22,$22 ; table, bitmap, or initialized data bytes
                    fcc       "/ "                           ; embedded text or resource bytes
                    fcb       $00,$00,$F2 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $00,$0F,$02 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $00,$F0,$02 ; table, bitmap, or initialized data bytes
                    fcc       "/"                            ; embedded text or resource bytes
                    fcb       $0F,$00,$02 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $F0,$00,$02 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $00,$00,$02,$22,$22,$22 ; table, bitmap, or initialized data bytes
                    fcb       $22,$09,$00,$06,$08,$00 ; table, bitmap, or initialized data bytes
                    fcb       $09,$8A,$00,$0C,$0D,$00 ; table, bitmap, or initialized data bytes
                    fcc       "Z "                           ; embedded text or resource bytes
                    fcb       $00,$0C,$00,$09,$00,$16 ; table, bitmap, or initialized data bytes
                    fcb       $08,$00   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $0C,$00   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $0A,$00   ; table, bitmap, or initialized data bytes
                    fcc       ">"                            ; embedded text or resource bytes
                    fcb       $89,$00   ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $8C,$00   ; table, bitmap, or initialized data bytes
                    fcc       "N"                            ; embedded text or resource bytes
                    fcb       $0D,$00   ; table, bitmap, or initialized data bytes
                    fcc       "Z "                           ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $00,$09,$00,$89,$08,$00 ; table, bitmap, or initialized data bytes
                    fcc       "e"                            ; embedded text or resource bytes
                    fcb       $0C,$00,$97,$0A,$00,$AD ; table, bitmap, or initialized data bytes
                    fcb       $88,$00,$0C,$8C,$00 ; table, bitmap, or initialized data bytes
                    fcc       "N"                            ; embedded text or resource bytes
                    fcb       $0D,$00   ; table, bitmap, or initialized data bytes
                    fcc       "Z "                           ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "]R"                           ; embedded text or resource bytes
                    fcb       $00,$B8   ; table, bitmap, or initialized data bytes
                    fcc       "G"                            ; embedded text or resource bytes
                    fcb       $00,$BA   ; table, bitmap, or initialized data bytes
                    fcc       "B"                            ; embedded text or resource bytes
                    fcb       $00,$BC   ; table, bitmap, or initialized data bytes
                    fcc       "r"                            ; embedded text or resource bytes
                    fcb       $00,$B8   ; table, bitmap, or initialized data bytes
                    fcc       "g"                            ; embedded text or resource bytes
                    fcb       $00,$BA   ; table, bitmap, or initialized data bytes
                    fcc       "b"                            ; embedded text or resource bytes
                    fcb       $00,$BC,$00,$97,$A5 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $D0,$A5   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "L "                           ; embedded text or resource bytes
                    fcb       $F9,$DB,$A5 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $DE,$00   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C9,$00,$B3 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $A7,$84,$17,$DA ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $13,$DE,$00 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C9,$00,$B3,$86,$FF,$A7 ; table, bitmap, or initialized data bytes
                    fcb       $84,$86,$04,$D6,$90 ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $17,$FF,$D4 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $06,$CE,$00 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $0D,$94   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "3X"                           ; embedded text or resource bytes
                    fcb       $A6       ; table, bitmap, or initialized data bytes
                    fcc       "a"                            ; embedded text or resource bytes
                    fcb       $C6       ; table, bitmap, or initialized data bytes
                    fcc       "H=3"                          ; embedded text or resource bytes
                    fcb       $CB,$EF,$01,$CC,$00,$1C ; table, bitmap, or initialized data bytes
                    fcb       $0D,$94   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $03,$CC,$00 ; table, bitmap, or initialized data bytes
                    fcc       "-3"                           ; embedded text or resource bytes
                    fcb       $CB,$EF,$05,$CE,$00 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $0D,$94   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "3^"                           ; embedded text or resource bytes
                    fcb       $A6,$E4,$C6 ; table, bitmap, or initialized data bytes
                    fcc       " =3"                          ; embedded text or resource bytes
                    fcb       $CB,$EF,$03,$CC,$00,$0F ; table, bitmap, or initialized data bytes
                    fcb       $0D,$94   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $03,$CC,$00,$13 ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $CB,$EF,$07,$17,$D9,$E1 ; table, bitmap, or initialized data bytes
                    fcb       $13       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $10,$9E,$AA ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $A7,$84,$17,$D9,$D4,$13 ; table, bitmap, or initialized data bytes
                    fcb       $96,$A5,$97,$A2 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $10,$9F,$A0,$8C,$00 ; table, bitmap, or initialized data bytes
                    fcc       "6-"                           ; embedded text or resource bytes
                    fcb       $15,$8C,$00 ; table, bitmap, or initialized data bytes
                    fcc       "B- "                          ; embedded text or resource bytes
                    fcb       $97,$9C   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FE   ; table, bitmap, or initialized data bytes
                    fcc       "R"                            ; embedded text or resource bytes
                    fcb       $9F,$AA   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FE   ; table, bitmap, or initialized data bytes
                    fcc       "g"                            ; embedded text or resource bytes
                    fcb       $9F,$AC   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $1E,$97,$9A ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FE   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $9F,$AA   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FE   ; table, bitmap, or initialized data bytes
                    fcc       "E"                            ; embedded text or resource bytes
                    fcb       $9F,$AC   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $0E,$97,$9B ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FE   ; table, bitmap, or initialized data bytes
                    fcc       ")"                            ; embedded text or resource bytes
                    fcb       $9F,$AA   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FE   ; table, bitmap, or initialized data bytes
                    fcc       ">"                            ; embedded text or resource bytes
                    fcb       $9F,$AC,$9E,$AC ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $A7,$84,$17,$D9,$8B,$13 ; table, bitmap, or initialized data bytes
                    fcb       $9E,$AA   ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $A7,$84,$17,$D9,$82,$13 ; table, bitmap, or initialized data bytes
                    fcb       $9E,$AC,$A7,$84,$10,$AF ; table, bitmap, or initialized data bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "1$"                           ; embedded text or resource bytes
                    fcb       $10,$AF,$07,$17,$D9 ; table, bitmap, or initialized data bytes
                    fcc       "r"                            ; embedded text or resource bytes
                    fcb       $13       ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $86,$03,$D7,$A5,$90,$A5 ; table, bitmap, or initialized data bytes
                    fcb       $1E,$89,$86,$10 ; table, bitmap, or initialized data bytes
                    fcc       "="                            ; embedded text or resource bytes
                    fcb       $96,$A5   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $08,$81,$03 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $08,$C0,$02 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $05,$C0,$05 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $10,$8E,$00 ; table, bitmap, or initialized data bytes
                    fcc       "HO1"                          ; embedded text or resource bytes
                    fcb       $AB       ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $D6,$93   ; table, bitmap, or initialized data bytes
                    fcc       "VVVV"                         ; embedded text or resource bytes
                    fcb       $C4,$03,$8D,$D2,$8E,$00 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $17,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "^"                            ; embedded text or resource bytes
                    fcb       $D6,$93   ; table, bitmap, or initialized data bytes
                    fcc       "VV"                           ; embedded text or resource bytes
                    fcb       $C4,$03,$8D,$C4,$8E,$00 ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $17,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $D6,$93,$C4,$03,$8D,$B8 ; table, bitmap, or initialized data bytes
                    fcb       $8E,$00   ; table, bitmap, or initialized data bytes
                    fcc       "N"                            ; embedded text or resource bytes
                    fcb       $17,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "D94"                          ; embedded text or resource bytes
                    fcb       $06,$CC,$03,$FF ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $06,$DC,$A6,$1F,$13 ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $CB       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $06,$17,$D9,$0F,$11 ; table, bitmap, or initialized data bytes
                    fcc       "J'"                           ; embedded text or resource bytes
                    fcb       $0A       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $06,$DC,$A8 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8B       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $06       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $E5       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $86,$C6,$FF,$17,$D8,$FA ; table, bitmap, or initialized data bytes
                    fcb       $12       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $88       ; table, bitmap, or initialized data bytes
                    fcc       "`9"                           ; embedded text or resource bytes
                    fcb       $8E,$01   ; table, bitmap, or initialized data bytes
                    fcc       "h"                            ; embedded text or resource bytes
                    fcb       $10,$8E,$00 ; table, bitmap, or initialized data bytes
                    fcc       "H"                            ; embedded text or resource bytes
                    fcb       $CC,$00   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $DD,$A6,$CC,$00 ; table, bitmap, or initialized data bytes
                    fcc       "`"                            ; embedded text or resource bytes
                    fcb       $DD,$A8,$C6,$FF,$8D,$BF ; table, bitmap, or initialized data bytes
                    fcb       $8E,$01   ; table, bitmap, or initialized data bytes
                    fcc       "h"                            ; embedded text or resource bytes
                    fcb       $10,$8E,$00 ; table, bitmap, or initialized data bytes
                    fcc       "x"                            ; embedded text or resource bytes
                    fcb       $8D,$B6,$CC,$00,$08,$DD ; table, bitmap, or initialized data bytes
                    fcb       $A6,$CC,$00 ; table, bitmap, or initialized data bytes
                    fcc       "`"                            ; embedded text or resource bytes
                    fcb       $DD,$A8,$86,$03,$10,$8E ; table, bitmap, or initialized data bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "X"                            ; embedded text or resource bytes
                    fcb       $8E,$01   ; table, bitmap, or initialized data bytes
                    fcc       "|"                            ; embedded text or resource bytes
                    fcb       $8D,$A1   ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $A8,$10   ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $26,$F5,$8E,$01,$80,$10 ; table, bitmap, or initialized data bytes
                    fcb       $8E,$00   ; table, bitmap, or initialized data bytes
                    fcc       "H"                            ; embedded text or resource bytes
                    fcb       $CE,$00   ; table, bitmap, or initialized data bytes
                    fcc       "x"                            ; embedded text or resource bytes
                    fcb       $8D,$B1,$8D,$AF,$8D,$AD ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $C6,$04   ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $14,$A6,$C0,$17,$D8,$A2 ; table, bitmap, or initialized data bytes
                    fcb       $0E       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $09       ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $26,$F5,$AE ; table, bitmap, or initialized data bytes
                    fcc       "a0"                           ; embedded text or resource bytes
                    fcb       $89       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $00,$AF   ; table, bitmap, or initialized data bytes
                    fcc       "a"                            ; embedded text or resource bytes
                    fcb       $C6,$04   ; table, bitmap, or initialized data bytes
                    fcc       "j"                            ; embedded text or resource bytes
                    fcb       $E4,$26,$E7 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $92,$0F,$B2,$17,$D8,$87 ; table, bitmap, or initialized data bytes
                    fcb       $17,$86,$05 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FC,$C9,$10 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $84,$10   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $01,$FF,$97,$8E,$8E,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$CE,$06,$C3,$10 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $88,$96,$8E ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$11,$EC,$10,$8E,$05 ; table, bitmap, or initialized data bytes
                    fcb       $F0,$10   ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $89,$10   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $01,$E3,$17,$D8 ; table, bitmap, or initialized data bytes
                    fcc       "Z0"                           ; embedded text or resource bytes
                    fcb       $97,$8F,$17,$D8 ; table, bitmap, or initialized data bytes
                    fcc       "T4"                           ; embedded text or resource bytes
                    fcb       $17,$D8   ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$0F,$CF,$86 ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $A7,$1E,$17,$D8 ; table, bitmap, or initialized data bytes
                    fcc       "D"                            ; embedded text or resource bytes
                    fcb       $07,$86,$14,$17,$D8 ; table, bitmap, or initialized data bytes
                    fcc       ">"                            ; embedded text or resource bytes
                    fcb       $09,$97,$B2,$DE,$00 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C9,$00,$BC,$17,$D8 ; table, bitmap, or initialized data bytes
                    fcc       "2)0"                          ; embedded text or resource bytes
                    fcb       $C9,$00,$CC,$17,$D8 ; table, bitmap, or initialized data bytes
                    fcc       "*)"                           ; embedded text or resource bytes
                    fcb       $17,$D8,$26 ; table, bitmap, or initialized data bytes
                    fcc       "(0"                           ; embedded text or resource bytes
                    fcb       $8D,$FC,$A6,$9F,$AA ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FC,$98,$17,$D8,$18 ; table, bitmap, or initialized data bytes
                    fcc       "83"                           ; embedded text or resource bytes
                    fcb       $8D,$FC,$80,$8E ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $06,$10,$8E,$10,$04,$17 ; table, bitmap, or initialized data bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
                    fcc       "^"                            ; embedded text or resource bytes
                    fcb       $86,$01,$97,$90,$97,$91 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $97,$94,$17,$FD,$C5,$86 ; table, bitmap, or initialized data bytes
                    fcb       $01,$97,$94,$17,$FD,$BE ; table, bitmap, or initialized data bytes
                    fcb       $DE,$00   ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $C9,$00,$BC,$A6,$C4,$17 ; table, bitmap, or initialized data bytes
                    fcb       $02,$26,$17,$FE,$F3,$17 ; table, bitmap, or initialized data bytes
                    fcb       $00,$D8,$CC,$10,$18,$17 ; table, bitmap, or initialized data bytes
                    fcb       $D7,$DF,$0B ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       "R"                            ; embedded text or resource bytes
                    fcb       $17,$D7,$D8,$01,$CC,$10 ; table, bitmap, or initialized data bytes
                    fcb       $1E,$17,$D7,$D1,$0B ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       "G"                            ; embedded text or resource bytes
                    fcb       $17,$D7,$CA,$01,$CC,$10 ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $17,$D7,$C3,$0B ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       "B"                            ; embedded text or resource bytes
                    fcb       $17,$D7,$BC,$01,$17,$FE ; table, bitmap, or initialized data bytes
                    fcc       "l"                            ; embedded text or resource bytes
                    fcb       $17,$FE,$F9,$96 ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $81,$04   ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $18,$CC,$04,$08,$17,$D7 ; table, bitmap, or initialized data bytes
                    fcb       $A9,$0B   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FC   ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $17,$00,$8D,$CC,$04,$1C ; table, bitmap, or initialized data bytes
                    fcb       $17,$D7,$9B,$0B,$17,$00 ; table, bitmap, or initialized data bytes
                    fcb       $83,$CC,$15,$08,$17,$D7 ; table, bitmap, or initialized data bytes
                    fcb       $91,$0B,$86,$01 ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $17,$D7,$8A,$0A,$CC,$16 ; table, bitmap, or initialized data bytes
                    fcb       $08,$17,$D7,$83,$0B,$86 ; table, bitmap, or initialized data bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $17,$D7   ; table, bitmap, or initialized data bytes
                    fcc       "|"                            ; embedded text or resource bytes
                    fcb       $0A,$96   ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $81,$04   ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $1F,$96   ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $97,$97,$97,$98,$81 ; table, bitmap, or initialized data bytes
                    fcc       "P'"                           ; embedded text or resource bytes
                    fcb       $0A,$CC   ; table, bitmap, or initialized data bytes
                    fcc       " 0"                           ; embedded text or resource bytes
                    fcb       $DD,$A3,$CE ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $08       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $08,$CC   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $08,$DD,$A3,$CE ; table, bitmap, or initialized data bytes
                    fcc       " 0"                           ; embedded text or resource bytes
                    fcb       $17,$00,$C1,$C6,$11,$8E ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$10,$8E,$00,$16 ; table, bitmap, or initialized data bytes
                    fcb       $CE,$02,$80,$17,$D7 ; table, bitmap, or initialized data bytes
                    fcc       "G"                            ; embedded text or resource bytes
                    fcb       $11       ; table, bitmap, or initialized data bytes
                    fcc       "1!"                           ; embedded text or resource bytes
                    fcb       $17,$D7   ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $11,$CC,$00,$03,$17,$01 ; table, bitmap, or initialized data bytes
                    fcb       $DA,$17,$D7 ; table, bitmap, or initialized data bytes
                    fcc       "7D"                           ; embedded text or resource bytes
                    fcb       $DE,$00   ; table, bitmap, or initialized data bytes
                    fcc       "0D"                           ; embedded text or resource bytes
                    fcb       $8D,$1C,$86,$01,$D6 ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $C1,$03   ; table, bitmap, or initialized data bytes
                    fcc       "/"                            ; embedded text or resource bytes
                    fcb       $02,$86,$03,$97,$96,$8D ; table, bitmap, or initialized data bytes
                    fcc       "E"                            ; embedded text or resource bytes
                    fcb       $17,$D7,$1F,$16,$17,$D7 ; table, bitmap, or initialized data bytes
                    fcb       $1B       ; table, bitmap, or initialized data bytes
                    fcc       "N"                            ; embedded text or resource bytes
                    fcb       $A6,$88   ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $97,$92   ; table, bitmap, or initialized data bytes
                    fcc       "9O_"                          ; embedded text or resource bytes
                    fcb       $17,$D7,$0F,$0A ; table, bitmap, or initialized data bytes
                    fcc       "94"                           ; embedded text or resource bytes
                    fcb       $10,$CC,$09,$03,$17,$D7 ; table, bitmap, or initialized data bytes
                    fcb       $05,$0B   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FB   ; table, bitmap, or initialized data bytes
                    fcc       "Q"                            ; embedded text or resource bytes
                    fcb       $17,$FF,$E9,$CC,$09,$08 ; table, bitmap, or initialized data bytes
                    fcb       $17,$D6,$F7,$0B,$17,$FF ; table, bitmap, or initialized data bytes
                    fcb       $DF,$CC,$09,$11,$17,$D6 ; table, bitmap, or initialized data bytes
                    fcb       $ED,$0B,$17,$FF,$D5,$CC ; table, bitmap, or initialized data bytes
                    fcb       $09,$0C,$17,$D6,$E3,$0B ; table, bitmap, or initialized data bytes
                    fcb       $17,$FF,$CB ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $90       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $02,$CC,$00,$10,$17,$01 ; table, bitmap, or initialized data bytes
                    fcc       "u"                            ; embedded text or resource bytes
                    fcb       $17,$D6,$D2 ; table, bitmap, or initialized data bytes
                    fcc       "D0"                           ; embedded text or resource bytes
                    fcb       $8D,$FB,$DA,$8D,$B7 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $02,$8D,$01 ; table, bitmap, or initialized data bytes
                    fcc       "946"                          ; embedded text or resource bytes
                    fcb       $81,$02   ; table, bitmap, or initialized data bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $08       ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $0C       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FB,$B8 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $11       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FB,$A3 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $0B       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FB,$8E ; table, bitmap, or initialized data bytes
                    fcc       "M"                            ; embedded text or resource bytes
                    fcb       $26,$04   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FB   ; table, bitmap, or initialized data bytes
                    fcc       "x"                            ; embedded text or resource bytes
                    fcb       $CC,$00,$16 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $10,$17,$01 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $17,$D6,$9C ; table, bitmap, or initialized data bytes
                    fcc       "D5"                           ; embedded text or resource bytes
                    fcb       $10,$8D,$83 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $B6,$EF   ; table, bitmap, or initialized data bytes
                    fcc       "~'"                           ; embedded text or resource bytes
                    fcb       $16,$DC,$A3 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FB,$9F,$17,$D6,$88 ; table, bitmap, or initialized data bytes
                    fcb       $0D,$DF,$A3,$1F ; table, bitmap, or initialized data bytes
                    fcc       "00"                           ; embedded text or resource bytes
                    fcb       $8D,$FB,$B6,$17,$D6 ; table, bitmap, or initialized data bytes
                    fcc       "|"                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "92b"                          ; embedded text or resource bytes
                    fcb       $96,$B2   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $03,$17,$03,$B4,$16,$03 ; table, bitmap, or initialized data bytes
                    fcb       $E2,$10,$8C,$00,$0A ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $15,$10,$8C,$00,$0C ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $0C,$10,$8C,$00,$0E ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $03,$C6,$00 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $C6,$01   ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $C6,$02   ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $C6,$03   ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $8D,$00,$04,$9C ; table, bitmap, or initialized data bytes
                    fcc       "F"                            ; embedded text or resource bytes
                    fcb       $04,$9B   ; table, bitmap, or initialized data bytes
                    fcc       "F"                            ; embedded text or resource bytes
                    fcb       $04,$9A   ; table, bitmap, or initialized data bytes
                    fcc       "F9"                           ; embedded text or resource bytes
                    fcb       $DC,$9A,$DD,$9D,$96,$9C ; table, bitmap, or initialized data bytes
                    fcb       $97,$9F   ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $8D,$E9   ; table, bitmap, or initialized data bytes
                    fcc       "DD"                           ; embedded text or resource bytes
                    fcb       $17,$00,$8B,$A7,$84 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C9,$00,$BC,$17,$D6 ; table, bitmap, or initialized data bytes
                    fcc       "+("                           ; embedded text or resource bytes
                    fcb       $DC,$9D,$DD,$9A,$96,$9F ; table, bitmap, or initialized data bytes
                    fcb       $97,$9C,$17,$FD ; table, bitmap, or initialized data bytes
                    fcc       "c9"                           ; embedded text or resource bytes
                    fcb       $D6,$95,$C1,$01,$26,$0B ; table, bitmap, or initialized data bytes
                    fcb       $8D,$A8,$17,$FC,$A3,$17 ; table, bitmap, or initialized data bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $8D,$CA   ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $C1,$03,$26,$FB,$8D,$EF ; table, bitmap, or initialized data bytes
                    fcb       $17,$D6,$04,$19,$C1,$04 ; table, bitmap, or initialized data bytes
                    fcb       $26,$F6   ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $86,$01,$97,$94,$17,$FB ; table, bitmap, or initialized data bytes
                    fcb       $B2       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $06,$96,$91,$81,$04 ; table, bitmap, or initialized data bytes
                    fcc       "/"                            ; embedded text or resource bytes
                    fcb       $16,$81,$08 ; table, bitmap, or initialized data bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $12,$17,$FE,$DB,$96,$90 ; table, bitmap, or initialized data bytes
                    fcb       $81,$04   ; table, bitmap, or initialized data bytes
                    fcc       "/"                            ; embedded text or resource bytes
                    fcb       $09,$81,$08 ; table, bitmap, or initialized data bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $05,$EC,$E4,$17,$FB,$94 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $06,$8D   ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $A6,$84,$17,$00,$0B,$17 ; table, bitmap, or initialized data bytes
                    fcb       $FC,$81,$17,$FD,$0E,$96 ; table, bitmap, or initialized data bytes
                    fcb       $90,$97,$91 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $0F,$93   ; table, bitmap, or initialized data bytes
                    fcc       "HH4"                          ; embedded text or resource bytes
                    fcb       $02,$84,$E0,$97,$A5 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "HHH"                          ; embedded text or resource bytes
                    fcb       $C6,$03,$08,$A5,$09,$93 ; table, bitmap, or initialized data bytes
                    fcc       "H"                            ; embedded text or resource bytes
                    fcb       $09,$93   ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $26,$F6   ; table, bitmap, or initialized data bytes
                    fcc       "94"                           ; embedded text or resource bytes
                    fcb       $06,$DE,$00 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C9,$00,$BC,$D6,$90 ; table, bitmap, or initialized data bytes
                    fcc       "Z'"                           ; embedded text or resource bytes
                    fcb       $09,$C1,$01 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "Z "                           ; embedded text or resource bytes
                    fcb       $02,$C6,$0F ; table, bitmap, or initialized data bytes
                    fcc       "O0"                           ; embedded text or resource bytes
                    fcb       $8B       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       "40OL"                         ; embedded text or resource bytes
                    fcb       $C6,$04,$8E,$00,$0C,$AC ; table, bitmap, or initialized data bytes
                    fcb       $E4       ; table, bitmap, or initialized data bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $08       ; table, bitmap, or initialized data bytes
                    fcc       "Z'"                           ; embedded text or resource bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
                    fcc       "L0"                           ; embedded text or resource bytes
                    fcb       $09       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $F4,$C6,$04,$10,$8E,$00 ; table, bitmap, or initialized data bytes
                    fcb       $09,$10,$AC ; table, bitmap, or initialized data bytes
                    fcc       "b."                           ; embedded text or resource bytes
                    fcb       $09       ; table, bitmap, or initialized data bytes
                    fcc       "Z'"                           ; embedded text or resource bytes
                    fcb       $06,$8B,$04 ; table, bitmap, or initialized data bytes
                    fcc       "1$ "                          ; embedded text or resource bytes
                    fcb       $F2,$97,$90 ; table, bitmap, or initialized data bytes
                    fcc       "5094"                         ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $1F,$01,$E6,$E0,$1F,$02 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $CE,$00,$00,$C6,$80 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $17,$D5   ; table, bitmap, or initialized data bytes
                    fcc       "M"                            ; embedded text or resource bytes
                    fcb       $1D,$10,$26,$01 ; table, bitmap, or initialized data bytes
                    fcc       "v"                            ; embedded text or resource bytes
                    fcb       $17,$D5   ; table, bitmap, or initialized data bytes
                    fcc       "E"                            ; embedded text or resource bytes
                    fcb       $19,$D7,$95,$1F ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$DE,$10,$8C,$00,$16 ; table, bitmap, or initialized data bytes
                    fcc       "'S"                           ; embedded text or resource bytes
                    fcb       $86,$0D,$10,$8C,$00,$02 ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $15,$10,$8C,$00,$05 ; table, bitmap, or initialized data bytes
                    fcc       "-M"                           ; embedded text or resource bytes
                    fcb       $10,$8C,$00,$14,$10 ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $00,$84,$96,$92 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $C8,$16,$00,$F4,$9C,$AE ; table, bitmap, or initialized data bytes
                    fcb       $26,$05,$10,$9C,$B0 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $10,$9F,$AE,$10,$9F,$B0 ; table, bitmap, or initialized data bytes
                    fcb       $86,$00,$91,$96 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $05,$97,$96,$17,$FE ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $96,$95,$81,$01,$26,$A6 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$F9   ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $17,$D4,$F5 ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $DE,$00   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C9,$00,$BC,$17,$D4,$EB ; table, bitmap, or initialized data bytes
                    fcc       ")"                            ; embedded text or resource bytes
                    fcb       $17,$FE,$E9 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $8F,$86,$05,$CE,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $16,$00,$C1,$96 ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $81,$04   ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $81,$9C,$AE,$26,$05,$10 ; table, bitmap, or initialized data bytes
                    fcb       $9C,$B0   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $10,$9F,$AE,$10,$9F,$B0 ; table, bitmap, or initialized data bytes
                    fcb       $86,$01,$91,$96 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $05,$97,$96,$17,$FD,$F8 ; table, bitmap, or initialized data bytes
                    fcb       $8C,$00   ; table, bitmap, or initialized data bytes
                    fcc       "(."                           ; embedded text or resource bytes
                    fcb       $07,$CE   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $08,$C6   ; table, bitmap, or initialized data bytes
                    fcc       "( "                           ; embedded text or resource bytes
                    fcb       $05,$CE   ; table, bitmap, or initialized data bytes
                    fcc       " 0"                           ; embedded text or resource bytes
                    fcb       $C6       ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $D7,$97,$11,$93,$A3,$10 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
                    fcc       "N"                            ; embedded text or resource bytes
                    fcb       $17,$FE,$0C,$16,$FF ; table, bitmap, or initialized data bytes
                    fcc       "H"                            ; embedded text or resource bytes
                    fcb       $86,$02,$8C,$00 ; table, bitmap, or initialized data bytes
                    fcc       "(."                           ; embedded text or resource bytes
                    fcb       $02,$86,$03,$9C,$AE,$26 ; table, bitmap, or initialized data bytes
                    fcb       $05,$10,$9C,$B0 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $0E,$9F,$AE,$10,$9F,$B0 ; table, bitmap, or initialized data bytes
                    fcb       $91,$96   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $05,$97,$96,$17,$FD,$B8 ; table, bitmap, or initialized data bytes
                    fcb       $96,$95,$81,$01,$10,$26 ; table, bitmap, or initialized data bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $86,$02,$8C,$00 ; table, bitmap, or initialized data bytes
                    fcc       "(."                           ; embedded text or resource bytes
                    fcb       $09,$17,$FE,$DE,$17,$FE ; table, bitmap, or initialized data bytes
                    fcc       "k"                            ; embedded text or resource bytes
                    fcb       $16,$FF,$10,$10,$8C,$00 ; table, bitmap, or initialized data bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "-3"                           ; embedded text or resource bytes
                    fcb       $9F,$A0,$9E,$AA ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $A7,$84,$17,$D4 ; table, bitmap, or initialized data bytes
                    fcc       "V"                            ; embedded text or resource bytes
                    fcb       $13,$9E,$A0,$8C,$00 ; table, bitmap, or initialized data bytes
                    fcc       "6-"                           ; embedded text or resource bytes
                    fcb       $0B,$8C,$00 ; table, bitmap, or initialized data bytes
                    fcc       "B-"                           ; embedded text or resource bytes
                    fcb       $0C       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$F8,$DC ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $0A       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$F8,$C4 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$F8,$C7,$9F,$AA ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $A7,$84,$17,$D4 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $13,$16,$FE,$D7,$17,$FE ; table, bitmap, or initialized data bytes
                    fcb       $0C,$16,$FE,$D1,$96,$95 ; table, bitmap, or initialized data bytes
                    fcb       $81,$01,$10,$26,$FE,$C9 ; table, bitmap, or initialized data bytes
                    fcb       $8D,$0C   ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $96,$95,$81,$01,$10,$26 ; table, bitmap, or initialized data bytes
                    fcb       $FE,$BE,$8D,$26 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $17,$D4,$0E ; table, bitmap, or initialized data bytes
                    fcc       "N"                            ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $81,$04   ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $07,$96,$97,$A7,$88 ; table, bitmap, or initialized data bytes
                    fcc       "#"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       ",0"                           ; embedded text or resource bytes
                    fcb       $89,$00,$F3,$DE,$00 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $C9,$00,$BC,$C6,$10,$A6 ; table, bitmap, or initialized data bytes
                    fcb       $A0,$A7,$80 ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $26,$F9   ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $DE,$00   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C9,$00,$CC,$17,$D3,$E3 ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $81,$04   ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $09,$17,$D3,$D9 ; table, bitmap, or initialized data bytes
                    fcc       "N"                            ; embedded text or resource bytes
                    fcb       $96,$98,$A7,$88 ; table, bitmap, or initialized data bytes
                    fcc       "#9"                           ; embedded text or resource bytes
                    fcb       $81,$05   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $BA,$81,$13,$10 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $FE,$CC,$D6,$96,$C1,$01 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $0B,$C1,$02 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $0D,$C1,$03 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $0F,$16,$FE ; table, bitmap, or initialized data bytes
                    fcc       "a0"                           ; embedded text or resource bytes
                    fcb       $8D,$F9,$0D ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $0A       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$F9   ; table, bitmap, or initialized data bytes
                    fcc       "0 "                           ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$F9,$11,$A1,$80 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $09       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $02,$E6,$84,$26,$F6,$16 ; table, bitmap, or initialized data bytes
                    fcb       $FE       ; table, bitmap, or initialized data bytes
                    fcc       "D"                            ; embedded text or resource bytes
                    fcb       $1F       ; table, bitmap, or initialized data bytes
                    fcc       "R"                            ; embedded text or resource bytes
                    fcb       $EC,$84   ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $AB,$1F   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $16,$FE,$DD,$16,$FE,$D3 ; table, bitmap, or initialized data bytes
                    fcb       $86,$03,$97,$96,$17,$FC ; table, bitmap, or initialized data bytes
                    fcb       $BF,$16,$FE ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $96,$90   ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $81,$11,$26,$02,$86,$01 ; table, bitmap, or initialized data bytes
                    fcb       $97,$90,$17,$FD ; table, bitmap, or initialized data bytes
                    fcc       "v"                            ; embedded text or resource bytes
                    fcb       $16,$FE,$1B,$96,$90 ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $26,$F3,$86,$10 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $EF,$96,$90,$81,$04 ; table, bitmap, or initialized data bytes
                    fcc       "/"                            ; embedded text or resource bytes
                    fcb       $04,$80,$04 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $E5,$8B,$0C ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $E1,$96,$90,$8B,$04,$81 ; table, bitmap, or initialized data bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "/"                            ; embedded text or resource bytes
                    fcb       $D9,$80,$10 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $D5,$86,$02 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $C0,$96   ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $81,$04,$10 ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $FD,$EC,$86,$01 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $B4,$16,$FF,$1C,$96 ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $81,$04   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $F3       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $A7,$9E,$A0,$8C,$00 ; table, bitmap, or initialized data bytes
                    fcc       "6-"                           ; embedded text or resource bytes
                    fcb       $0F,$8C,$00 ; table, bitmap, or initialized data bytes
                    fcc       "B-"                           ; embedded text or resource bytes
                    fcb       $11,$8E,$00 ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $96,$9B,$97,$A2,$16,$FE ; table, bitmap, or initialized data bytes
                    fcb       $BD,$8E,$00 ; table, bitmap, or initialized data bytes
                    fcc       "N"                            ; embedded text or resource bytes
                    fcb       $96,$9C   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $F4,$8E,$00 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $96,$9A   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $ED,$9E,$A0,$8C,$00 ; table, bitmap, or initialized data bytes
                    fcc       "6-"                           ; embedded text or resource bytes
                    fcb       $E1,$8C,$00 ; table, bitmap, or initialized data bytes
                    fcc       "B-"                           ; embedded text or resource bytes
                    fcb       $E6       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $EB,$D6,$A2 ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $C1,$04,$26,$01 ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $9E,$A0,$17,$F9,$84,$17 ; table, bitmap, or initialized data bytes
                    fcb       $F9,$13,$17,$FC,$AA,$16 ; table, bitmap, or initialized data bytes
                    fcb       $FD,$95,$D6,$A2,$26,$04 ; table, bitmap, or initialized data bytes
                    fcb       $C6,$03   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $EA       ; table, bitmap, or initialized data bytes
                    fcc       "Z "                           ; embedded text or resource bytes
                    fcb       $E7       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $C8       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $B5       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $BD,$96,$8E ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$0A   ; table, bitmap, or initialized data bytes
                    fcc       "V"                            ; embedded text or resource bytes
                    fcb       $10,$8E,$08,$02,$10 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $89,$10   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $96,$8E,$10 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $8F,$10   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       "F"                            ; embedded text or resource bytes
                    fcb       $8D,$01   ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $17,$D2,$BA ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $17,$D2,$B6,$00,$96,$8F ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $04,$17,$D2,$AE ; table, bitmap, or initialized data bytes
                    fcc       "30"                           ; embedded text or resource bytes
                    fcb       $8D,$0A   ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $17,$D2,$A6,$07,$86 ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $17,$D2,$A0,$09 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $17,$D6,$9E,$17,$D2,$98 ; table, bitmap, or initialized data bytes
                    fcc       ">"                            ; embedded text or resource bytes
                    fcb       $97,$8D,$17,$FA,$06,$17 ; table, bitmap, or initialized data bytes
                    fcb       $FD       ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $17,$FF,$B2,$96,$8D,$17 ; table, bitmap, or initialized data bytes
                    fcb       $D2,$87   ; table, bitmap, or initialized data bytes
                    fcc       "794@"                         ; embedded text or resource bytes
                    fcb       $8D,$17   ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $02,$1E,$12,$A6,$84 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $02,$A1,$A4,$26,$04,$8D ; table, bitmap, or initialized data bytes
                    fcb       $1C       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $02,$8D   ; table, bitmap, or initialized data bytes
                    fcc       "'5B"                          ; embedded text or resource bytes
                    fcb       $A7,$C4   ; table, bitmap, or initialized data bytes
                    fcc       "940"                          ; embedded text or resource bytes
                    fcb       $C6,$14   ; table, bitmap, or initialized data bytes
                    fcc       "1!0"                          ; embedded text or resource bytes
                    fcb       $01,$A6,$80,$A0,$A0,$26 ; table, bitmap, or initialized data bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $26,$F7   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $B0,$C6,$14 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $A6,$85,$A9,$A5,$19,$A7 ; table, bitmap, or initialized data bytes
                    fcb       $C5       ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $26,$F6   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $11,$C6,$14 ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $86,$99,$89,$00,$A0,$A5 ; table, bitmap, or initialized data bytes
                    fcb       $A9,$85,$19,$A7,$C5 ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $26,$F2   ; table, bitmap, or initialized data bytes
                    fcc       "I"                            ; embedded text or resource bytes
                    fcb       $84,$FE,$A7,$C5 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $8D       ; table, bitmap, or initialized data bytes
                    fcc       "p'_"                          ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "l"                            ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "r"                            ; embedded text or resource bytes
                    fcb       $8D       ; table, bitmap, or initialized data bytes
                    fcc       "~"                            ; embedded text or resource bytes
                    fcb       $C6,$14   ; table, bitmap, or initialized data bytes
                    fcc       "Z'T"                          ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "l'"                           ; embedded text or resource bytes
                    fcb       $03,$17,$00,$84,$A6,$85 ; table, bitmap, or initialized data bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "r"                            ; embedded text or resource bytes
                    fcb       $26,$06   ; table, bitmap, or initialized data bytes
                    fcc       "DDDD'"                        ; embedded text or resource bytes
                    fcb       $EA,$84,$0F ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $E9       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $14,$97   ; table, bitmap, or initialized data bytes
                    fcc       "q"                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "l+"                           ; embedded text or resource bytes
                    fcb       $1D,$03   ; table, bitmap, or initialized data bytes
                    fcc       "l"                            ; embedded text or resource bytes
                    fcb       $C0,$09   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $11       ; table, bitmap, or initialized data bytes
                    fcc       "+"                            ; embedded text or resource bytes
                    fcb       $08       ; table, bitmap, or initialized data bytes
                    fcc       "XZ+"                          ; embedded text or resource bytes
                    fcb       $0B,$8D   ; table, bitmap, or initialized data bytes
                    fcc       "| "                           ; embedded text or resource bytes
                    fcb       $F9       ; table, bitmap, or initialized data bytes
                    fcc       "PX"                           ; embedded text or resource bytes
                    fcb       $8D       ; table, bitmap, or initialized data bytes
                    fcc       "XZ"                           ; embedded text or resource bytes
                    fcb       $26,$FB,$0D ; table, bitmap, or initialized data bytes
                    fcc       "r"                            ; embedded text or resource bytes
                    fcb       $26,$02,$8D ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $9E,$89,$10,$9E,$87,$DE ; table, bitmap, or initialized data bytes
                    fcb       $89,$8D,$86,$0A ; table, bitmap, or initialized data bytes
                    fcc       "q"                            ; embedded text or resource bytes
                    fcb       $26,$F3   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $14,$8D   ; table, bitmap, or initialized data bytes
                    fcc       ">"                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "r"                            ; embedded text or resource bytes
                    fcb       $26,$B6   ; table, bitmap, or initialized data bytes
                    fcc       "Z "                           ; embedded text or resource bytes
                    fcb       $B3,$9E,$89,$96 ; table, bitmap, or initialized data bytes
                    fcc       "m"                            ; embedded text or resource bytes
                    fcb       $A7,$84,$10,$9E,$87,$17 ; table, bitmap, or initialized data bytes
                    fcb       $04,$E3,$16,$03,$E7,$9E ; table, bitmap, or initialized data bytes
                    fcb       $83,$10,$9E,$87,$DE,$89 ; table, bitmap, or initialized data bytes
                    fcb       $17,$04,$C6,$0F ; table, bitmap, or initialized data bytes
                    fcc       "m4@"                          ; embedded text or resource bytes
                    fcb       $DE,$83,$17,$01,$CD ; table, bitmap, or initialized data bytes
                    fcc       "M5"                           ; embedded text or resource bytes
                    fcb       $C0       ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $E6,$80,$E1,$A0 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "m3A9"                         ; embedded text or resource bytes
                    fcb       $10,$9E,$83 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $03,$10,$9E,$87 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $04,$86,$04 ; table, bitmap, or initialized data bytes
                    fcc       "4 "                           ; embedded text or resource bytes
                    fcb       $C6,$14,$1C,$FE ; table, bitmap, or initialized data bytes
                    fcc       "i"                            ; embedded text or resource bytes
                    fcb       $A5       ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $26,$FB   ; table, bitmap, or initialized data bytes
                    fcc       "5 J"                          ; embedded text or resource bytes
                    fcb       $26,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $84,$10,$9E,$83 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $03,$10,$9E,$87 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $04,$86,$04 ; table, bitmap, or initialized data bytes
                    fcc       "4 "                           ; embedded text or resource bytes
                    fcb       $C6,$14   ; table, bitmap, or initialized data bytes
                    fcc       "1!"                           ; embedded text or resource bytes
                    fcb       $1C,$FE   ; table, bitmap, or initialized data bytes
                    fcc       "f"                            ; embedded text or resource bytes
                    fcb       $A0       ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $26,$FB   ; table, bitmap, or initialized data bytes
                    fcc       "5 J"                          ; embedded text or resource bytes
                    fcb       $26,$EE   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $84,$8D,$9D,$10 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $03,$89,$8D,$AD,$8D ; table, bitmap, or initialized data bytes
                    fcc       "m"                            ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "r"                            ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "s"                            ; embedded text or resource bytes
                    fcb       $8D,$B0,$A6,$84 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $FA,$8D,$AA,$C6,$13,$A6 ; table, bitmap, or initialized data bytes
                    fcb       $85,$26,$03 ; table, bitmap, or initialized data bytes
                    fcc       "Z*"                           ; embedded text or resource bytes
                    fcb       $F9       ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $C5,$84,$0F ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $02,$03   ; table, bitmap, or initialized data bytes
                    fcc       "r4@"                          ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "q"                            ; embedded text or resource bytes
                    fcb       $9E,$83,$10,$9E,$87,$17 ; table, bitmap, or initialized data bytes
                    fcb       $FE,$BF   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "]"                            ; embedded text or resource bytes
                    fcb       $26,$1D,$9E,$87,$10,$9E ; table, bitmap, or initialized data bytes
                    fcb       $83,$DE,$87,$17,$FE,$D2 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $0B,$0C   ; table, bitmap, or initialized data bytes
                    fcc       "q"                            ; embedded text or resource bytes
                    fcb       $DE,$87,$17,$01 ; table, bitmap, or initialized data bytes
                    fcc       "2'"                           ; embedded text or resource bytes
                    fcb       $08       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $E9,$17,$03 ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $17,$FE,$B0,$96 ; table, bitmap, or initialized data bytes
                    fcc       "q"                            ; embedded text or resource bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "r'"                           ; embedded text or resource bytes
                    fcb       $0A       ; table, bitmap, or initialized data bytes
                    fcc       "HHHH5@"                       ; embedded text or resource bytes
                    fcb       $A7,$C4   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $06       ; table, bitmap, or initialized data bytes
                    fcc       "5@"                           ; embedded text or resource bytes
                    fcb       $AA,$C4,$A7,$C0,$17,$FF ; table, bitmap, or initialized data bytes
                    fcc       "p"                            ; embedded text or resource bytes
                    fcb       $0A       ; table, bitmap, or initialized data bytes
                    fcc       "s"                            ; embedded text or resource bytes
                    fcb       $26,$B5,$16,$FF,$19 ; table, bitmap, or initialized data bytes
                    fcc       "46"                           ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "r"                            ; embedded text or resource bytes
                    fcb       $10,$9E,$83,$C6,$15 ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $A6,$A5   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $FB,$84,$0F,$26,$02,$03 ; table, bitmap, or initialized data bytes
                    fcc       "r"                            ; embedded text or resource bytes
                    fcb       $C0,$0A   ; table, bitmap, or initialized data bytes
                    fcc       "+"                            ; embedded text or resource bytes
                    fcb       $13       ; table, bitmap, or initialized data bytes
                    fcc       "]'"                           ; embedded text or resource bytes
                    fcb       $07       ; table, bitmap, or initialized data bytes
                    fcc       "X"                            ; embedded text or resource bytes
                    fcb       $17,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "1Z"                           ; embedded text or resource bytes
                    fcb       $26,$FA,$0D ; table, bitmap, or initialized data bytes
                    fcc       "r'"                           ; embedded text or resource bytes
                    fcb       $14,$17,$FF ; table, bitmap, or initialized data bytes
                    fcc       "E "                           ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "PX"                           ; embedded text or resource bytes
                    fcb       $17,$FF   ; table, bitmap, or initialized data bytes
                    fcc       ">Z"                           ; embedded text or resource bytes
                    fcb       $26,$FA,$0D ; table, bitmap, or initialized data bytes
                    fcc       "r'"                           ; embedded text or resource bytes
                    fcb       $03,$17,$FF ; table, bitmap, or initialized data bytes
                    fcc       "45"                           ; embedded text or resource bytes
                    fcb       $B6       ; table, bitmap, or initialized data bytes
                    fcc       "4V"                           ; embedded text or resource bytes
                    fcb       $9E,$81,$DE,$83,$A6,$80 ; table, bitmap, or initialized data bytes
                    fcb       $A7,$C0,$8D ; table, bitmap, or initialized data bytes
                    fcc       "H"                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "v"                            ; embedded text or resource bytes
                    fcb       $26,$05,$86 ; table, bitmap, or initialized data bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $A7,$85   ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $D7       ; table, bitmap, or initialized data bytes
                    fcc       "mZ+"                          ; embedded text or resource bytes
                    fcb       $06,$A6,$85,$81 ; table, bitmap, or initialized data bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $26,$F7,$10,$9E,$8B ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $04,$86,$14,$A0,$E0 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $A6,$E6,$80,$C1 ; table, bitmap, or initialized data bytes
                    fcc       ".'"                           ; embedded text or resource bytes
                    fcb       $FA,$0A   ; table, bitmap, or initialized data bytes
                    fcc       "m'"                           ; embedded text or resource bytes
                    fcb       $04,$E7,$A0 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $F2,$9E,$8B,$C6,$14,$A6 ; table, bitmap, or initialized data bytes
                    fcb       $80,$80   ; table, bitmap, or initialized data bytes
                    fcc       "0HHHH4"                       ; embedded text or resource bytes
                    fcb       $02,$A6,$80,$80 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $AA,$E0,$A7,$C0 ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $26,$EB   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $D6       ; table, bitmap, or initialized data bytes
                    fcc       "4F"                           ; embedded text or resource bytes
                    fcb       $DE,$8B,$86 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C6       ; table, bitmap, or initialized data bytes
                    fcc       "+"                            ; embedded text or resource bytes
                    fcb       $17,$03,$CE,$A7,$C4 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $C6       ; table, bitmap, or initialized data bytes
                    fcc       "4P"                           ; embedded text or resource bytes
                    fcb       $8D,$ED,$9E,$8B ; table, bitmap, or initialized data bytes
                    fcc       "o"                            ; embedded text or resource bytes
                    fcb       $88       ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $8D       ; table, bitmap, or initialized data bytes
                    fcc       "^';"                    ;2FD4: 5E 27 3B       '^' ; embedded text or resource bytes
                    fcb       $E6,$C0,$E7,$80,$8D ; table, bitmap, or initialized data bytes
                    fcc       ">"                            ; embedded text or resource bytes
                    fcb       $C6       ; table, bitmap, or initialized data bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $E7,$80,$8D ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
                    fcb       $9E,$8B   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $01,$86   ; table, bitmap, or initialized data bytes
                    fcc       "+4"                           ; embedded text or resource bytes
                    fcb       $02,$A6,$85,$81 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $26,$05   ; table, bitmap, or initialized data bytes
                    fcc       "j"                            ; embedded text or resource bytes
                    fcb       $E4       ; table, bitmap, or initialized data bytes
                    fcc       "\ "                           ; embedded text or resource bytes
                    fcb       $F5,$A6,$85 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $04,$A7,$80 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $F8,$A6,$82,$81 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $26,$04   ; table, bitmap, or initialized data bytes
                    fcc       "j"                            ; embedded text or resource bytes
                    fcb       $E4       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $F6       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $02,$9E,$8B,$8D ; table, bitmap, or initialized data bytes
                    fcc       "45"                           ; embedded text or resource bytes
                    fcb       $D0       ; table, bitmap, or initialized data bytes
                    fcc       "4P"                           ; embedded text or resource bytes
                    fcb       $17,$03,$85,$0C ; table, bitmap, or initialized data bytes
                    fcc       "p"                            ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "l5"                           ; embedded text or resource bytes
                    fcb       $D0,$C6,$0A,$A6,$C4 ; table, bitmap, or initialized data bytes
                    fcc       "DDDD"                         ; embedded text or resource bytes
                    fcb       $8B       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $A7,$80,$A6,$C0,$84,$0F ; table, bitmap, or initialized data bytes
                    fcb       $8B       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $A7,$80   ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $26,$EB   ; table, bitmap, or initialized data bytes
                    fcc       "94D3A"                        ; embedded text or resource bytes
                    fcb       $C6,$14   ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $AA,$C0   ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $26,$FB   ; table, bitmap, or initialized data bytes
                    fcc       "M5"                           ; embedded text or resource bytes
                    fcb       $C4,$C6,$01,$D7 ; table, bitmap, or initialized data bytes
                    fcc       "m"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "l"                            ; embedded text or resource bytes
                    fcb       $81,$0A,$22,$0A,$E6,$86 ; table, bitmap, or initialized data bytes
                    fcb       $C1       ; table, bitmap, or initialized data bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $26       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $0A       ; table, bitmap, or initialized data bytes
                    fcc       "l ,"                          ; embedded text or resource bytes
                    fcb       $E6,$86,$C1 ; table, bitmap, or initialized data bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $26,$0D,$0F ; table, bitmap, or initialized data bytes
                    fcc       "mJ'"                          ; embedded text or resource bytes
                    fcb       $AF,$81,$0A,$22,$F1,$97 ; table, bitmap, or initialized data bytes
                    fcc       "l "                           ; embedded text or resource bytes
                    fcb       $19,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "m'!"                          ; embedded text or resource bytes
                    fcb       $C1       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $26,$03   ; table, bitmap, or initialized data bytes
                    fcc       "J "                           ; embedded text or resource bytes
                    fcb       $E2       ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $81,$0A   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $06,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "m'"                           ; embedded text or resource bytes
                    fcb       $11       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $D7       ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "l"                            ; embedded text or resource bytes
                    fcb       $9E,$8B,$10,$9E,$81,$D6 ; table, bitmap, or initialized data bytes
                    fcc       "l\"                           ; embedded text or resource bytes
                    fcb       $17,$02,$A8 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "n94B"                         ; embedded text or resource bytes
                    fcb       $C6,$03,$DB ; table, bitmap, or initialized data bytes
                    fcc       "w0"                           ; embedded text or resource bytes
                    fcb       $8D,$04   ; table, bitmap, or initialized data bytes
                    fcc       "_1"                           ; embedded text or resource bytes
                    fcb       $8D,$04,$ED ; table, bitmap, or initialized data bytes
                    fcc       "m"                            ; embedded text or resource bytes
                    fcb       $84       ; table, bitmap, or initialized data bytes
                    fcc       "+"                            ; embedded text or resource bytes
                    fcb       $0F,$A1,$85 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $0B,$11,$A3,$84 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $06       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $22       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $ED       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $C2       ; table, bitmap, or initialized data bytes
                    fcc       "4v"                           ; embedded text or resource bytes
                    fcb       $AF       ; table, bitmap, or initialized data bytes
                    fcc       "~'"                           ; embedded text or resource bytes
                    fcb       $1B,$1F,$13 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $E6       ; table, bitmap, or initialized data bytes
                    fcc       "B'"                           ; embedded text or resource bytes
                    fcb       $14       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $06,$E6,$C4,$1F,$01,$E6 ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $1F,$02,$17,$CF ; table, bitmap, or initialized data bytes
                    fcc       "DD5 "                         ; embedded text or resource bytes
                    fcb       $17,$CF   ; table, bitmap, or initialized data bytes
                    fcc       ">$5"                          ; embedded text or resource bytes
                    fcb       $F6,$C6,$80,$CE,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $17,$CF   ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $1D,$26   ; table, bitmap, or initialized data bytes
                    fcc       "I"                            ; embedded text or resource bytes
                    fcb       $17,$CF   ; table, bitmap, or initialized data bytes
                    fcc       "-E4"                          ; embedded text or resource bytes
                    fcb       $04,$1F,$10 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $04,$1F   ; table, bitmap, or initialized data bytes
                    fcc       " 5"                           ; embedded text or resource bytes
                    fcb       $02,$1F,$03 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "]"                            ; embedded text or resource bytes
                    fcb       $26       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $11,$93   ; table, bitmap, or initialized data bytes
                    fcc       "{'"                           ; embedded text or resource bytes
                    fcb       $DB,$DF   ; table, bitmap, or initialized data bytes
                    fcc       "{"                            ; embedded text or resource bytes
                    fcb       $86,$FF,$8D,$8F ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $12       ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $C9,$FF,$00,$8D,$87 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $0A,$9E   ; table, bitmap, or initialized data bytes
                    fcc       "}"                            ; embedded text or resource bytes
                    fcb       $8D,$A4,$0F ; table, bitmap, or initialized data bytes
                    fcc       "}"                            ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "~ "                           ; embedded text or resource bytes
                    fcb       $C1,$9C   ; table, bitmap, or initialized data bytes
                    fcc       "}'"                           ; embedded text or resource bytes
                    fcb       $BD,$8D,$98,$10,$9E ; table, bitmap, or initialized data bytes
                    fcc       "}"                            ; embedded text or resource bytes
                    fcb       $9F       ; table, bitmap, or initialized data bytes
                    fcc       "}"                            ; embedded text or resource bytes
                    fcb       $1F       ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $8D,$8F   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $B0,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "x"                            ; embedded text or resource bytes
                    fcb       $86,$FF,$81,$0D,$26,$02 ; table, bitmap, or initialized data bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       "="                            ; embedded text or resource bytes
                    fcb       $81,$05,$26,$02,$8D ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $81       ; table, bitmap, or initialized data bytes
                    fcc       "a%"                           ; embedded text or resource bytes
                    fcb       $06,$81   ; table, bitmap, or initialized data bytes
                    fcc       "z"                            ; embedded text or resource bytes
                    fcb       $22,$02,$84,$DF,$81 ; table, bitmap, or initialized data bytes
                    fcc       "B'"                           ; embedded text or resource bytes
                    fcb       $92,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "y"                            ; embedded text or resource bytes
                    fcb       $17,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "G'"                           ; embedded text or resource bytes
                    fcb       $0B,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "w3"                           ; embedded text or resource bytes
                    fcb       $C9,$FF,$00,$17,$FF ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $26,$10   ; table, bitmap, or initialized data bytes
                    fcc       "M*"                           ; embedded text or resource bytes
                    fcb       $04,$C6,$04,$A6,$03,$8D ; table, bitmap, or initialized data bytes
                    fcb       $16,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "y"                            ; embedded text or resource bytes
                    fcb       $26,$C7,$16,$FF ; table, bitmap, or initialized data bytes
                    fcc       "p"                            ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "w"                            ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "x"                            ; embedded text or resource bytes
                    fcb       $16,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "i2b"                          ; embedded text or resource bytes
                    fcb       $16,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "d2b94"                        ; embedded text or resource bytes
                    fcb       $06,$EC,$A4 ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $8D,$04   ; table, bitmap, or initialized data bytes
                    fcc       "H3"                           ; embedded text or resource bytes
                    fcb       $CB       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $06       ; table, bitmap, or initialized data bytes
                    fcc       "n"                            ; embedded text or resource bytes
                    fcb       $C4,$8D   ; table, bitmap, or initialized data bytes
                    fcc       ")"                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "z"                            ; embedded text or resource bytes
                    fcb       $26,$12,$17,$02,$0D,$0C ; table, bitmap, or initialized data bytes
                    fcc       "p"                            ; embedded text or resource bytes
                    fcb       $16,$01,$C1,$8D,$1B,$0D ; table, bitmap, or initialized data bytes
                    fcc       "v"                            ; embedded text or resource bytes
                    fcb       $26,$16   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $02,$8D,$13,$D6 ; table, bitmap, or initialized data bytes
                    fcc       "z"                            ; embedded text or resource bytes
                    fcb       $C1,$0A   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $0C,$9E,$81 ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $D7       ; table, bitmap, or initialized data bytes
                    fcc       "z0"                           ; embedded text or resource bytes
                    fcb       $85,$A7,$84,$17,$01,$A7 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "o"                            ; embedded text or resource bytes
                    fcb       $26,$04,$0D ; table, bitmap, or initialized data bytes
                    fcc       "t'"                           ; embedded text or resource bytes
                    fcb       $0A,$DE,$83,$17,$01 ; table, bitmap, or initialized data bytes
                    fcc       "g"                            ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "t"                            ; embedded text or resource bytes
                    fcb       $17,$01   ; table, bitmap, or initialized data bytes
                    fcc       "^9"                           ; embedded text or resource bytes
                    fcb       $8D,$0F,$8D,$03,$0C ; table, bitmap, or initialized data bytes
                    fcc       "t9"                           ; embedded text or resource bytes
                    fcb       $DE,$87,$17,$FD,$FC,$D6 ; table, bitmap, or initialized data bytes
                    fcc       "l"                            ; embedded text or resource bytes
                    fcb       $D7       ; table, bitmap, or initialized data bytes
                    fcc       "z91"                          ; embedded text or resource bytes
                    fcb       $8D,$00   ; table, bitmap, or initialized data bytes
                    fcc       "^"                            ; embedded text or resource bytes
                    fcb       $D6       ; table, bitmap, or initialized data bytes
                    fcc       "z4 "                          ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "t'"                           ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $D7       ; table, bitmap, or initialized data bytes
                    fcc       "z"                            ; embedded text or resource bytes
                    fcb       $17,$01   ; table, bitmap, or initialized data bytes
                    fcc       "I"                            ; embedded text or resource bytes
                    fcb       $17,$01   ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $D6       ; table, bitmap, or initialized data bytes
                    fcc       "z"                            ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "t"                            ; embedded text or resource bytes
                    fcb       $0C       ; table, bitmap, or initialized data bytes
                    fcc       "v"                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "z"                            ; embedded text or resource bytes
                    fcb       $26,$04,$0D ; table, bitmap, or initialized data bytes
                    fcc       "p'"                           ; embedded text or resource bytes
                    fcb       $0B,$17,$FD ; table, bitmap, or initialized data bytes
                    fcc       "n"                            ; embedded text or resource bytes
                    fcb       $17,$01,$B6,$10,$9E,$7F ; table, bitmap, or initialized data bytes
                    fcb       $AD,$A4   ; table, bitmap, or initialized data bytes
                    fcc       "5 "                           ; embedded text or resource bytes
                    fcb       $10,$9F,$7F,$16,$01,$91 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $8D,$FB,$D4 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $8D,$FC,$A1 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $0A       ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $8D,$00,$1C ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $8D,$00,$12,$0D ; table, bitmap, or initialized data bytes
                    fcc       "t'"                           ; embedded text or resource bytes
                    fcb       $B4,$D6   ; table, bitmap, or initialized data bytes
                    fcc       "l"                            ; embedded text or resource bytes
                    fcb       $D7       ; table, bitmap, or initialized data bytes
                    fcc       "z "                           ; embedded text or resource bytes
                    fcb       $AE,$9E,$83,$10,$9E,$87 ; table, bitmap, or initialized data bytes
                    fcb       $DE,$87   ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $9E,$83   ; table, bitmap, or initialized data bytes
                    fcc       "c"                            ; embedded text or resource bytes
                    fcb       $84,$8D,$F2,$17,$FB ; table, bitmap, or initialized data bytes
                    fcc       "S"                            ; embedded text or resource bytes
                    fcb       $8D,$8D,$0D ; table, bitmap, or initialized data bytes
                    fcc       "n"                            ; embedded text or resource bytes
                    fcb       $26,$03,$16,$01,$12,$9E ; table, bitmap, or initialized data bytes
                    fcb       $81       ; table, bitmap, or initialized data bytes
                    fcc       "o"                            ; embedded text or resource bytes
                    fcb       $80,$86   ; table, bitmap, or initialized data bytes
                    fcc       "E"                            ; embedded text or resource bytes
                    fcb       $A7,$84,$17,$01,$05,$17 ; table, bitmap, or initialized data bytes
                    fcb       $00,$D0,$0C ; table, bitmap, or initialized data bytes
                    fcc       "p 2"                          ; embedded text or resource bytes
                    fcb       $8D       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $8D       ; table, bitmap, or initialized data bytes
                    fcc       "G"                            ; embedded text or resource bytes
                    fcb       $17,$FB   ; table, bitmap, or initialized data bytes
                    fcc       "11"                           ; embedded text or resource bytes
                    fcb       $8D,$00   ; table, bitmap, or initialized data bytes
                    fcc       "J4 "                          ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "u"                            ; embedded text or resource bytes
                    fcb       $DE,$85,$17,$FD,$CA ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $02,$03   ; table, bitmap, or initialized data bytes
                    fcc       "u"                            ; embedded text or resource bytes
                    fcb       $DE,$85,$17,$FD ; table, bitmap, or initialized data bytes
                    fcc       "X"                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "n'"                           ; embedded text or resource bytes
                    fcb       $09,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "n"                            ; embedded text or resource bytes
                    fcb       $AD,$F1,$17,$00,$A2 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $C4       ; table, bitmap, or initialized data bytes
                    fcc       "5 "                           ; embedded text or resource bytes
                    fcb       $8D,$B7   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "2b"                           ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "w"                            ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "x9"                           ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "x%2"                          ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "t'"                           ; embedded text or resource bytes
                    fcb       $04,$D6   ; table, bitmap, or initialized data bytes
                    fcc       "l"                            ; embedded text or resource bytes
                    fcb       $D7       ; table, bitmap, or initialized data bytes
                    fcc       "z"                            ; embedded text or resource bytes
                    fcb       $17,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
                    fcb       $D7       ; table, bitmap, or initialized data bytes
                    fcc       "z"                            ; embedded text or resource bytes
                    fcb       $0C       ; table, bitmap, or initialized data bytes
                    fcc       "t9"                           ; embedded text or resource bytes
                    fcb       $9E,$87,$10,$9E,$85,$DE ; table, bitmap, or initialized data bytes
                    fcb       $85       ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $8D,$E2,$8D,$F4 ; table, bitmap, or initialized data bytes
                    fcc       "c"                            ; embedded text or resource bytes
                    fcb       $84,$17,$FA,$DC,$9E,$87 ; table, bitmap, or initialized data bytes
                    fcc       "c"                            ; embedded text or resource bytes
                    fcb       $84       ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $8D,$FF,$9E ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $A5,$86,$80,$97 ; table, bitmap, or initialized data bytes
                    fcc       "x"                            ; embedded text or resource bytes
                    fcb       $0C       ; table, bitmap, or initialized data bytes
                    fcc       "w92b"                         ; embedded text or resource bytes
                    fcb       $C6,$FF,$D7 ; table, bitmap, or initialized data bytes
                    fcc       "y "                           ; embedded text or resource bytes
                    fcb       $BD,$04   ; table, bitmap, or initialized data bytes
                    fcc       "x%"                           ; embedded text or resource bytes
                    fcb       $F6,$17,$00,$C9,$DE,$85 ; table, bitmap, or initialized data bytes
                    fcb       $17,$FE,$F5,$8D ; table, bitmap, or initialized data bytes
                    fcc       "}"                            ; embedded text or resource bytes
                    fcb       $0C       ; table, bitmap, or initialized data bytes
                    fcc       "z"                            ; embedded text or resource bytes
                    fcb       $0C       ; table, bitmap, or initialized data bytes
                    fcc       "o "                           ; embedded text or resource bytes
                    fcb       $A9,$C1,$03 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $D9,$04   ; table, bitmap, or initialized data bytes
                    fcc       "x%"                           ; embedded text or resource bytes
                    fcb       $DE,$DE,$85,$8D ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "u"                            ; embedded text or resource bytes
                    fcb       $D6       ; table, bitmap, or initialized data bytes
                    fcc       "z"                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "o'"                           ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $8D       ; table, bitmap, or initialized data bytes
                    fcc       "` "                           ; embedded text or resource bytes
                    fcb       $E5,$C1,$03 ; table, bitmap, or initialized data bytes
                    fcc       "' "                           ; embedded text or resource bytes
                    fcb       $08       ; table, bitmap, or initialized data bytes
                    fcc       "x%"                           ; embedded text or resource bytes
                    fcb       $C5,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "t"                            ; embedded text or resource bytes
                    fcb       $26,$09,$DE,$83,$8D,$1C ; table, bitmap, or initialized data bytes
                    fcb       $17,$00,$90,$8D ; table, bitmap, or initialized data bytes
                    fcc       "G "                           ; embedded text or resource bytes
                    fcb       $CE,$08   ; table, bitmap, or initialized data bytes
                    fcc       "x%"                           ; embedded text or resource bytes
                    fcb       $B2,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "t"                            ; embedded text or resource bytes
                    fcb       $8D,$0B,$17,$00,$CD ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $F1,$86,$01 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $9E,$8D   ; table, bitmap, or initialized data bytes
                    fcc       "y"                            ; embedded text or resource bytes
                    fcb       $DE,$87   ; table, bitmap, or initialized data bytes
                    fcc       "4f"                           ; embedded text or resource bytes
                    fcb       $C6,$14   ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $8D       ; table, bitmap, or initialized data bytes
                    fcc       "jo"                           ; embedded text or resource bytes
                    fcb       $C4       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $E6,$9E,$87,$10,$9E,$83 ; table, bitmap, or initialized data bytes
                    fcb       $C6,$14,$A6,$85,$A7,$A5 ; table, bitmap, or initialized data bytes
                    fcc       "Z*"                           ; embedded text or resource bytes
                    fcb       $F9       ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "z'"                           ; embedded text or resource bytes
                    fcb       $11,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "p"                            ; embedded text or resource bytes
                    fcb       $26,$0D,$9E,$81 ; table, bitmap, or initialized data bytes
                    fcc       "c"                            ; embedded text or resource bytes
                    fcb       $84,$D6   ; table, bitmap, or initialized data bytes
                    fcc       "z"                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "o'"                           ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $8D,$03   ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $C6,$01,$10,$8E,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $8D       ; table, bitmap, or initialized data bytes
                    fcc       "W]"                           ; embedded text or resource bytes
                    fcb       $26,$01   ; table, bitmap, or initialized data bytes
                    fcc       "\4"                           ; embedded text or resource bytes
                    fcb       $16,$C0,$0C ; table, bitmap, or initialized data bytes
                    fcc       "SO"                           ; embedded text or resource bytes
                    fcb       $1F,$01,$17,$CC,$A8 ; table, bitmap, or initialized data bytes
                    fcc       "D"                            ; embedded text or resource bytes
                    fcb       $E6       ; table, bitmap, or initialized data bytes
                    fcc       "a"                            ; embedded text or resource bytes
                    fcb       $9E,$81,$86 ; table, bitmap, or initialized data bytes
                    fcc       " m"                           ; embedded text or resource bytes
                    fcb       $80       ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $02,$86   ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $17,$CC,$98 ; table, bitmap, or initialized data bytes
                    fcc       "B"                            ; embedded text or resource bytes
                    fcb       $A6,$80,$81 ; table, bitmap, or initialized data bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $26,$02,$0C ; table, bitmap, or initialized data bytes
                    fcc       "vZ*"                          ; embedded text or resource bytes
                    fcb       $F1,$86   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "u'"                           ; embedded text or resource bytes
                    fcb       $02,$86,$84,$17,$CC,$81 ; table, bitmap, or initialized data bytes
                    fcc       "C5"                           ; embedded text or resource bytes
                    fcb       $96,$A7,$C5 ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $26,$FB   ; table, bitmap, or initialized data bytes
                    fcc       "94F"                          ; embedded text or resource bytes
                    fcb       $DE,$81,$C6,$0B,$86 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "o"                            ; embedded text or resource bytes
                    fcb       $C4,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "z"                            ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "v"                            ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "p"                            ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "n"                            ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "o5"                           ; embedded text or resource bytes
                    fcb       $C6       ; table, bitmap, or initialized data bytes
                    fcc       "46"                           ; embedded text or resource bytes
                    fcb       $8E,$00,$01,$10,$8E,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$17,$CC ; table, bitmap, or initialized data bytes
                    fcc       "TD"                           ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $C6,$0C,$17,$CC ; table, bitmap, or initialized data bytes
                    fcc       "LBZ"                          ; embedded text or resource bytes
                    fcb       $26,$F9   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $B6       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C9,$00,$8D ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $C9,$00,$81,$AF,$A1 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $0C,$C6,$05,$AF,$A1 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $88,$15   ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $26,$F8,$17,$CC ; table, bitmap, or initialized data bytes
                    fcc       "-:"                           ; embedded text or resource bytes
                    fcb       $8D,$B2,$17,$FF ; table, bitmap, or initialized data bytes
                    fcc       "h1"                           ; embedded text or resource bytes
                    fcb       $8D,$FE   ; table, bitmap, or initialized data bytes
                    fcc       "F"                            ; embedded text or resource bytes
                    fcb       $10,$9F,$7F ; table, bitmap, or initialized data bytes
                    fcc       "94@3"                         ; embedded text or resource bytes
                    fcb       $8D,$01,$01 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $E6,$C0,$1F,$01,$E6,$C1 ; table, bitmap, or initialized data bytes
                    fcb       $1F,$02,$17,$CC,$0D ; table, bitmap, or initialized data bytes
                    fcc       "D"                            ; embedded text or resource bytes
                    fcb       $A6,$C0,$17,$CC,$07,$02 ; table, bitmap, or initialized data bytes
                    fcb       $A6,$C0,$17,$CC,$01,$02 ; table, bitmap, or initialized data bytes
                    fcc       "m"                            ; embedded text or resource bytes
                    fcb       $C4       ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $E3       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $C0       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$01,$D2,$17,$CB,$F3 ; table, bitmap, or initialized data bytes
                    fcc       "80"                           ; embedded text or resource bytes
                    fcb       $8D,$00,$86,$17,$CB,$EB ; table, bitmap, or initialized data bytes
                    fcb       $06,$96   ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $17,$CB,$E5,$09 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $8D,$01,$94,$EC,$A1 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $0C,$17,$CB,$D9,$0B,$EC ; table, bitmap, or initialized data bytes
                    fcb       $A1,$17,$CB,$D3,$01 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $17,$CB,$CC ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $CC,$EE,$BB,$17,$CF ; table, bitmap, or initialized data bytes
                    fcc       "}"                            ; embedded text or resource bytes
                    fcb       $17,$CB,$C2 ; table, bitmap, or initialized data bytes
                    fcc       ">4"                           ; embedded text or resource bytes
                    fcb       $02,$17,$CB,$BC,$0F,$D7 ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $17,$CB,$B6,$17,$8D,$16 ; table, bitmap, or initialized data bytes
                    fcb       $8D,$B7,$17,$FF,$8F,$17 ; table, bitmap, or initialized data bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
                    fcc       "e"                            ; embedded text or resource bytes
                    fcb       $17,$CB,$A8,$16,$17,$FC ; table, bitmap, or initialized data bytes
                    fcc       "i5"                           ; embedded text or resource bytes
                    fcb       $02,$17,$CB,$9F ; table, bitmap, or initialized data bytes
                    fcc       "790"                          ; embedded text or resource bytes
                    fcb       $8D,$01   ; table, bitmap, or initialized data bytes
                    fcc       "m"                            ; embedded text or resource bytes
                    fcb       $17,$CB,$96 ; table, bitmap, or initialized data bytes
                    fcc       "80"                           ; embedded text or resource bytes
                    fcb       $8D,$01   ; table, bitmap, or initialized data bytes
                    fcc       "W"                            ; embedded text or resource bytes
                    fcb       $CC,$01,$02,$8D,$07,$DE ; table, bitmap, or initialized data bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "0D"                           ; embedded text or resource bytes
                    fcb       $CC,$03,$02,$8D,$07 ; table, bitmap, or initialized data bytes
                    fcc       "O_"                           ; embedded text or resource bytes
                    fcb       $17,$CB   ; table, bitmap, or initialized data bytes
                    fcc       "~"                            ; embedded text or resource bytes
                    fcb       $0A       ; table, bitmap, or initialized data bytes
                    fcc       "9404"                         ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $1F,$01,$E6,$E0,$1F,$02 ; table, bitmap, or initialized data bytes
                    fcb       $17,$CB   ; table, bitmap, or initialized data bytes
                    fcc       "nD509("                       ; embedded text or resource bytes
                    fcb       $05,$EE   ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $E5       ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $D5       ; table, bitmap, or initialized data bytes
                    fcc       "UUUUUUUUUUUU"                 ; embedded text or resource bytes
                    fcb       $EE       ; table, bitmap, or initialized data bytes
                    fcc       "U^UVUUUUUUUUUUUUUUUUU"        ; embedded text or resource bytes
                    fcc       "UUU"                          ; embedded text or resource bytes
                    fcb       $D5       ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $E5       ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $EE       ; table, bitmap, or initialized data bytes
                    fcc       "UUUUUUUUUUUUVU^U"             ; embedded text or resource bytes
                    fcb       $EE,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "<<?"                          ; embedded text or resource bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       "<<<<"                         ; embedded text or resource bytes
                    fcb       $00,$00,$00,$00,$03,$08 ; table, bitmap, or initialized data bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $00,$03,$06,$01 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $00,$05,$06,$01 ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $00,$07,$06,$01 ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $00,$03,$04,$01 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $00,$05,$04,$01 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $00,$07,$04,$01 ; table, bitmap, or initialized data bytes
                    fcc       "6"                            ; embedded text or resource bytes
                    fcb       $00,$03,$02,$01 ; table, bitmap, or initialized data bytes
                    fcc       "7"                            ; embedded text or resource bytes
                    fcb       $00,$05,$02,$01 ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
                    fcb       $00,$07,$02,$01 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $00,$05,$08,$01 ; table, bitmap, or initialized data bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $00,$07,$08,$01 ; table, bitmap, or initialized data bytes
                    fcc       "="                            ; embedded text or resource bytes
                    fcb       $00,$09,$08,$01 ; table, bitmap, or initialized data bytes
                    fcc       ";"                      ;3539: 3B             ' ; embedded text or resource bytes
                    fcb       $00,$09,$08,$01 ; table, bitmap, or initialized data bytes
                    fcc       "+"                            ; embedded text or resource bytes
                    fcb       $00,$09,$06,$01 ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $00,$09,$02,$01 ; table, bitmap, or initialized data bytes
                    fcc       "/"                            ; embedded text or resource bytes
                    fcb       $00,$09,$04,$01 ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $00,$09,$04,$01 ; table, bitmap, or initialized data bytes
                    fcc       ":"                            ; embedded text or resource bytes
                    fcb       $00,$09,$04,$01 ; table, bitmap, or initialized data bytes
                    fcc       "X"                            ; embedded text or resource bytes
                    fcb       $00,$0B,$02,$01 ; table, bitmap, or initialized data bytes
                    fcc       "S"                            ; embedded text or resource bytes
                    fcb       $00,$0B,$04,$02 ; table, bitmap, or initialized data bytes
                    fcc       "CE"                           ; embedded text or resource bytes
                    fcb       $0B,$06,$02 ; table, bitmap, or initialized data bytes
                    fcc       "CA"                           ; embedded text or resource bytes
                    fcb       $00,$02,$02 ; table, bitmap, or initialized data bytes
                    fcc       "MC"                           ; embedded text or resource bytes
                    fcb       $00,$04,$02 ; table, bitmap, or initialized data bytes
                    fcc       "MR"                           ; embedded text or resource bytes
                    fcb       $00,$06,$02 ; table, bitmap, or initialized data bytes
                    fcc       "M-"                           ; embedded text or resource bytes
                    fcb       $00,$08,$02 ; table, bitmap, or initialized data bytes
                    fcc       "M;"                     ;357A: 4D 3B          'M ; embedded text or resource bytes
                    fcb       $00,$08,$02 ; table, bitmap, or initialized data bytes
                    fcc       "M+"                           ; embedded text or resource bytes
                    fcb       $0B,$08,$03 ; table, bitmap, or initialized data bytes
                    fcc       "BR"                           ; embedded text or resource bytes
                    fcb       $0D,$08,$00 ; table, bitmap, or initialized data bytes
                    fcc       "K"                            ; embedded text or resource bytes
                    fcb       $00,$80,$FB,$BE,$FB,$D4 ; table, bitmap, or initialized data bytes
                    fcb       $FB,$D4,$FB,$D4,$FB,$D4 ; table, bitmap, or initialized data bytes
                    fcb       $FB,$D4,$FB,$D4,$FB,$D4 ; table, bitmap, or initialized data bytes
                    fcb       $FB,$D4,$FB,$D4,$FB,$CC ; table, bitmap, or initialized data bytes
                    fcb       $FB,$FC,$FC ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       "I"                            ; embedded text or resource bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $FD       ; table, bitmap, or initialized data bytes
                    fcc       "w"                            ; embedded text or resource bytes
                    fcb       $FD       ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $FD       ; table, bitmap, or initialized data bytes
                    fcc       "H"                            ; embedded text or resource bytes
                    fcb       $FD,$18,$FD,$04,$FC,$E2 ; table, bitmap, or initialized data bytes
                    fcb       $FC,$8F,$FC,$8F,$FB,$AD ; table, bitmap, or initialized data bytes
                    fcb       $FB,$A8,$0C,$0F,$80,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0C,$1E,$81,$00,$16,$0F ; table, bitmap, or initialized data bytes
                    fcb       $82,$00,$16,$1E,$83,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00   ; table, bitmap, or initialized data bytes
                    fcc       "Application :"                ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $01,$04,$0F,$07,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $C0       ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $0F,$0C,$10,$0B ; table, bitmap, or initialized data bytes
                    fcc       "UU"                           ; embedded text or resource bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $06,$17,$CA,$17 ; table, bitmap, or initialized data bytes
                    fcc       "/"                            ; embedded text or resource bytes
                    fcb       $1F,$8B   ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $1F,$03   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       "4~"                           ; embedded text or resource bytes
                    fcb       $17,$FF,$EE,$17,$CA,$07 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $17,$CA,$03 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $97,$26,$EC,$E4,$D7,$1F ; table, bitmap, or initialized data bytes
                    fcc       "M*!"                          ; embedded text or resource bytes
                    fcb       $84,$7F,$97 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $9F       ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $17,$C9,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "I"                            ; embedded text or resource bytes
                    fcb       $1F       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $D7       ; table, bitmap, or initialized data bytes
                    fcc       "#"                            ; embedded text or resource bytes
                    fcb       $1F,$10,$D7 ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $17,$C9,$E4 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $0F,$1E,$86,$FF,$17,$C9 ; table, bitmap, or initialized data bytes
                    fcb       $DC,$1E,$17,$01,$1D,$17 ; table, bitmap, or initialized data bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $17,$C9,$D2,$18,$84,$80 ; table, bitmap, or initialized data bytes
                    fcb       $8A,$03,$1F,$89,$17,$C9 ; table, bitmap, or initialized data bytes
                    fcb       $C8,$1C   ; table, bitmap, or initialized data bytes
                    fcc       "]*"                           ; embedded text or resource bytes
                    fcb       $04,$17,$C9,$C1,$16,$97 ; table, bitmap, or initialized data bytes
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
                    fcb       $00,$CF,$A7,$A4,$17,$C9 ; table, bitmap, or initialized data bytes
                    fcb       $A5       ; table, bitmap, or initialized data bytes
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
                    fcb       $A7,$A0,$17,$C9 ; table, bitmap, or initialized data bytes
                    fcc       "mCm"                          ; embedded text or resource bytes
                    fcb       $A4       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $07,$0C,$1F,$17,$00,$C3 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $ED,$D6,$1F,$96,$26 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $04,$17,$C9 ; table, bitmap, or initialized data bytes
                    fcc       "X3"                           ; embedded text or resource bytes
                    fcb       $17,$C9   ; table, bitmap, or initialized data bytes
                    fcc       "T:"                           ; embedded text or resource bytes
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
                    fcb       $A7,$85,$17,$C9 ; table, bitmap, or initialized data bytes
                    fcc       ",C"                           ; embedded text or resource bytes
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
                    fcb       $02,$86,$01,$17,$C8,$F9 ; table, bitmap, or initialized data bytes
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
                    fcb       $08,$17,$C8,$AA ; table, bitmap, or initialized data bytes
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
                    fcb       $04,$1F,$02,$17,$C8,$81 ; table, bitmap, or initialized data bytes
                    fcc       "D5"                           ; embedded text or resource bytes
                    fcb       $B0       ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $80       ; table, bitmap, or initialized data bytes
Data_3796           fcc       "?"                            ; embedded text or resource bytes
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
Data_3F98           fcb       $CC,$CC   ; table, bitmap, or initialized data bytes
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
