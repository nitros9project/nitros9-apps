********************************************************************
* DMHELP - DeskMate 3 help viewer
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

                    nam       DMHELP
                    ttl       DeskMate 3 help viewer

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct
atrv                set       $00

                    mod       eom,name,tylg,atrv,start,$0150

name                fcs       /DMHELP/ ; OS-9 module name

Addr_0001           equ       $0001     ; absolute address used by original code
Addr_0003           equ       $0003     ; absolute address used by original code
Addr_0004           equ       $0004     ; absolute address used by original code
Addr_0049           equ       $0049     ; absolute address used by original code
Addr_004B           equ       $004B     ; absolute address used by original code
Addr_004C           equ       $004C     ; absolute address used by original code
Addr_00FF           equ       $00FF     ; absolute address used by original code
DeskMateService     equ       $0000     ; absolute address used by original code

start               jmp       >DeskMateService ; dispatch control through the selected target
                    tfr       X,Y       ; copy the source register into the destination register
                    leax      Data_01DF,PCR ; form the referenced address without reading memory
                    tfr       X,D       ; copy the source register into the destination register
                    addd      #Data_0100 ; add the operand to the running value
                    clrb                ; clear the selected byte or register
                    tfr       A,DP      ; copy the source register into the destination register
                    tfr       D,U       ; copy the source register into the destination register
                    sts       $4E,U     ; save the current value in working storage
                    leas      $014F,U   ; form the referenced address without reading memory
                    lda       $09,Y     ; load the value needed by the following operation
                    cmpa      #$50      ; compare against the limit and set condition flags
                    beq       Code_0048 ; branch when the compared values are equal
                    leax      Data_0CA9,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $07       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $06       ; private DeskMate service selector
                    leax      Data_14AB,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
Data_0047           fcb       $08       ; private DeskMate service selector
Code_0048           tfr       Y,X       ; copy the source register into the destination register
Code_004A           lbra      Code_004D ; continue at the distant control-flow target
Code_004D           clr       Addr_0049 ; clear the selected byte or register
                    clr       Addr_004B ; clear the selected byte or register
                    pshs      X         ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "N"                            ; embedded text or resource bytes
                    puls      X         ; restore the listed registers from the stack
                    lda       $12,Y     ; load the value needed by the following operation
                    adda      #$30      ; add the operand to the running value
                    leay      $06,U     ; form the referenced address without reading memory
                    ldb       #$3A      ; load the value needed by the following operation
                    std       ,Y++      ; store the value and advance the destination pointer
                    leax      $07,X     ; form the referenced address without reading memory
Code_0066           lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,Y+       ; store the value and advance the destination pointer
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bne       Code_0066 ; branch when the compared values differ
                    clr       ,-Y       ; clear the selected byte or register
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       Addr_004C ; save the current value in working storage
                    leay      ,U        ; form the referenced address without reading memory
                    leax      $06,U     ; form the referenced address without reading memory
                    stx       ,Y        ; save the current value in working storage
                    leax      Data_01DB,PCR ; form the referenced address without reading memory
                    stx       $02,Y     ; save the current value in working storage
                    leax      $11,U     ; form the referenced address without reading memory
                    stx       $04,Y     ; save the current value in working storage
                    lda       #$36      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "J"                            ; embedded text or resource bytes
                    leax      $11,U     ; form the referenced address without reading memory
                    lda       #$05      ; load the value needed by the following operation
                    os9       I$Open    ; request the named OS-9 service
                    sta       Code_0048 ; save the current value in working storage
                    lbcs      Code_014F ; take the distant branch when carry reports an error
                    pshs      U,Y,X,D   ; preserve the listed registers on the stack
                    lda       #$14      ; load the value needed by the following operation
                    sta       Code_004D ; save the current value in working storage
Code_009F           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "E"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    dec       Code_004D ; decrement the selected counter
                    bgt       Code_009F ; branch when the signed value is above the limit
                    puls      U,Y,X,D   ; restore the listed registers from the stack
Code_00AD           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "?"                            ; embedded text or resource bytes
                    clr       Code_004A ; clear the selected byte or register
Code_00B7           ldy       #Addr_0001 ; load the value needed by the following operation
                    leax      $47,U     ; form the referenced address without reading memory
                    lda       Code_0048 ; load the value needed by the following operation
                    os9       I$Read    ; request the named OS-9 service
                    lbcs      Code_0145 ; take the distant branch when carry reports an error
                    lda       Data_0047 ; load the value needed by the following operation
                    cmpa      #$5E      ; compare against the limit and set condition flags
                    beq       Code_010B ; branch when the compared values are equal
                    cmpa      #$7E      ; compare against the limit and set condition flags
                    bne       Code_00D5 ; branch when the compared values differ
                    inc       Addr_004B ; advance the selected counter
                    bra       Code_00B7 ; continue at the selected control-flow target
Code_00D5           ldb       Addr_004B ; load the value needed by the following operation
                    cmpb      Addr_004C ; compare against the limit and set condition flags
                    blt       Code_00B7 ; branch when the signed value is below the limit
                    bgt       Code_010B ; branch when the signed value is above the limit
                    cmpa      #$5C      ; compare against the limit and set condition flags
                    beq       Code_010D ; branch when the compared values are equal
                    ldb       #$40      ; load the value needed by the following operation
                    cmpa      #$60      ; compare against the limit and set condition flags
                    beq       Code_00ED ; branch when the compared values are equal
                    cmpa      #$7C      ; compare against the limit and set condition flags
                    bne       Code_00F3 ; branch when the compared values differ
                    ldb       #$80      ; load the value needed by the following operation
Code_00ED           eorb      Addr_0049 ; toggle the selected bits
                    stb       Addr_0049 ; save the current value in working storage
                    bra       Code_00B7 ; continue at the selected control-flow target
Code_00F3           cmpa      #$0D      ; compare against the limit and set condition flags
                    bne       Code_0103 ; branch when the compared values differ
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "B"                            ; embedded text or resource bytes
                    lda       #$0A      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
Data_0100           fcc       "B"                            ; embedded text or resource bytes
                    bra       Code_00B7 ; continue at the selected control-flow target
Code_0103           ldb       Addr_0049 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $02       ; private DeskMate service selector
                    bra       Code_00B7 ; continue at the selected control-flow target
Code_010B           inc       Code_004A ; advance the selected counter
Code_010D           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $16       ; private DeskMate service selector
Code_0111           ldb       #$80      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    cmpa      #$05      ; compare against the limit and set condition flags
                    beq       Code_012B ; branch when the compared values are equal
                    tsta                ; set condition flags from the current value
                    bne       Code_012D ; branch when the compared values differ
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "E"                            ; embedded text or resource bytes
                    cmpb      #$01      ; compare against the limit and set condition flags
                    bne       Code_0111 ; branch when the compared values differ
                    cmpx      #Addr_00FF ; compare against the limit and set condition flags
                    bne       Code_012D ; branch when the compared values differ
Code_012B           inc       Code_004A ; advance the selected counter
Code_012D           tst       Code_004A ; set condition flags from the current value
                    lbeq      Code_00AD ; take the distant branch when values are equal
Code_0133           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "E"                            ; embedded text or resource bytes
                    lda       Code_0048 ; load the value needed by the following operation
                    os9       I$Close   ; request the named OS-9 service
                    clrb                ; clear the selected byte or register
                    lds       $4E,U     ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "W"                            ; embedded text or resource bytes
Code_0145           leax      >Data_0198,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
                    bra       Code_016A ; continue at the selected control-flow target
Code_014F           leax      >Data_01A8,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
                    ldx       #DeskMateService ; load the value needed by the following operation
                    ldy       #Addr_0001 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    leax      >Data_01B5,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
Code_016A           ldx       #DeskMateService ; load the value needed by the following operation
                    ldy       #Addr_0003 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    leax      >Data_01C0,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
                    ldx       #DeskMateService ; load the value needed by the following operation
                    ldy       #Addr_0004 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    leax      >Data_01CE,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
                    ldb       #$80      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1C       ; private DeskMate service selector
                    bra       Code_0133 ; continue at the selected control-flow target
Data_0198           fcc       "Disk read error"              ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_01A8           fcc       "Can not find"                 ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_01B5           fcc       "help file."                   ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_01C0           fcc       "Press any key"                ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_01CE           fcc       "to continue."                 ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_01DB           fcc       "HLP"                          ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_01DF           fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
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
                    fcb       $06,$17,$FB ; table, bitmap, or initialized data bytes
                    fcc       "n/"                           ; embedded text or resource bytes
                    fcb       $1F,$8B   ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $1F,$03   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $1F,$02,$D6,$0F,$1F,$01 ; table, bitmap, or initialized data bytes
                    fcb       $17,$FB   ; table, bitmap, or initialized data bytes
                    fcc       "\D9"                          ; embedded text or resource bytes
                    fcb       $9E,$0A   ; table, bitmap, or initialized data bytes
                    fcc       "H"                            ; embedded text or resource bytes
                    fcb       $AE,$86   ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $E6,$80,$C4,$80,$17,$FB ; table, bitmap, or initialized data bytes
                    fcc       "M"                            ; embedded text or resource bytes
                    fcb       $0A       ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $D6,$14,$8D,$E1 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $D6,$0D,$1F,$02,$17,$FB ; table, bitmap, or initialized data bytes
                    fcc       "?$9"                          ; embedded text or resource bytes
                    fcb       $0D,$15   ; table, bitmap, or initialized data bytes
                    fcc       "'6"                           ; embedded text or resource bytes
                    fcb       $D6,$10   ; table, bitmap, or initialized data bytes
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
                    fcb       $04,$17,$FB,$1F ; table, bitmap, or initialized data bytes
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
                    fcb       $15,$17,$FB,$04 ; table, bitmap, or initialized data bytes
                    fcc       "A9O"                          ; embedded text or resource bytes
                    fcb       $1F,$02,$D6,$0D ; table, bitmap, or initialized data bytes
                    fcc       "T"                            ; embedded text or resource bytes
                    fcb       $DB,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $1F,$01,$17,$FA,$F4 ; table, bitmap, or initialized data bytes
                    fcc       "D94"                          ; embedded text or resource bytes
                    fcb       $10,$17,$FA,$ED,$1F ; table, bitmap, or initialized data bytes
                    fcc       "4 0"                          ; embedded text or resource bytes
                    fcb       $8D,$02,$BF,$17,$FA,$E3 ; table, bitmap, or initialized data bytes
                    fcb       $06,$AE   ; table, bitmap, or initialized data bytes
                    fcc       "b"                            ; embedded text or resource bytes
                    fcb       $17,$FA,$DD ; table, bitmap, or initialized data bytes
                    fcc       "F50"                          ; embedded text or resource bytes
                    fcb       $17,$FA,$D7,$03 ; table, bitmap, or initialized data bytes
                    fcc       "94~"                          ; embedded text or resource bytes
                    fcb       $17,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "]"                            ; embedded text or resource bytes
                    fcb       $0F,$18,$0F,$19,$0F ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $C6,$80,$17,$FA,$C5,$1D ; table, bitmap, or initialized data bytes
                    fcb       $97,$1C,$17,$FA,$BF,$18 ; table, bitmap, or initialized data bytes
                    fcc       "M"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "I"                            ; embedded text or resource bytes
                    fcb       $17,$FA,$B6 ; table, bitmap, or initialized data bytes
                    fcc       "E"                            ; embedded text or resource bytes
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
                    fcb       $17,$FA,$18,$26,$D6,$1D ; table, bitmap, or initialized data bytes
                    fcb       $17,$FE,$AC,$17,$FA,$0F ; table, bitmap, or initialized data bytes
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
                    fcb       $0A,$13,$8D,$17,$17,$F9 ; table, bitmap, or initialized data bytes
                    fcb       $E8       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $D6,$10,$17,$FE ; table, bitmap, or initialized data bytes
                    fcc       "|"                            ; embedded text or resource bytes
                    fcb       $17,$F9,$DF ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $96,$11,$17,$FE,$7F,$17 ; table, bitmap, or initialized data bytes
                    fcb       $FE,$8B   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $92,$D6,$10,$17,$FE ; table, bitmap, or initialized data bytes
                    fcc       "i"                            ; embedded text or resource bytes
                    fcb       $17,$F9,$CC,$0C,$1F,$10 ; table, bitmap, or initialized data bytes
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
                    fcb       $17,$F9,$B2 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $17,$F9,$AE ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $97,$26,$EC,$E4,$D7,$1F ; table, bitmap, or initialized data bytes
                    fcc       "M*!"                          ; embedded text or resource bytes
                    fcb       $84,$7F,$97 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $9F       ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $17,$F9,$9B ; table, bitmap, or initialized data bytes
                    fcc       "I"                            ; embedded text or resource bytes
                    fcb       $1F       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $D7       ; table, bitmap, or initialized data bytes
                    fcc       "#"                            ; embedded text or resource bytes
                    fcb       $1F,$10,$D7 ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $17,$F9,$8F ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $0F,$1E,$86,$FF,$17,$F9 ; table, bitmap, or initialized data bytes
                    fcb       $87,$1E,$17,$01,$1D,$17 ; table, bitmap, or initialized data bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $17,$F9   ; table, bitmap, or initialized data bytes
                    fcc       "}"                            ; embedded text or resource bytes
                    fcb       $18,$84,$80,$8A,$03,$1F ; table, bitmap, or initialized data bytes
                    fcb       $89,$17,$F9 ; table, bitmap, or initialized data bytes
                    fcc       "s"                            ; embedded text or resource bytes
                    fcb       $1C       ; table, bitmap, or initialized data bytes
                    fcc       "]*"                           ; embedded text or resource bytes
                    fcb       $04,$17,$F9 ; table, bitmap, or initialized data bytes
                    fcc       "l"                            ; embedded text or resource bytes
                    fcb       $16,$97   ; table, bitmap, or initialized data bytes
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
                    fcb       $00,$CF,$A7,$A4,$17,$F9 ; table, bitmap, or initialized data bytes
                    fcc       "PCm!'"                        ; embedded text or resource bytes
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
                    fcb       $A7,$A0,$17,$F9,$18 ; table, bitmap, or initialized data bytes
                    fcc       "Cm"                           ; embedded text or resource bytes
                    fcb       $A4       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $07,$0C,$1F,$17,$00,$C3 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $ED,$D6,$1F,$96,$26 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $04,$17,$F9,$03 ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $17,$F8,$FF ; table, bitmap, or initialized data bytes
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
                    fcb       $A7,$85,$17,$F8,$D7 ; table, bitmap, or initialized data bytes
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
                    fcb       $02,$86,$01,$17,$F8,$A4 ; table, bitmap, or initialized data bytes
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
                    fcb       $08,$17,$F8 ; table, bitmap, or initialized data bytes
                    fcc       "UC"                           ; embedded text or resource bytes
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
                    fcb       $04,$1F,$02,$17,$F8 ; table, bitmap, or initialized data bytes
                    fcc       ",D5"                          ; embedded text or resource bytes
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
                    fcb       $17,$F6,$ED ; table, bitmap, or initialized data bytes
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
                    fcb       $17,$F6,$D2 ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
                    fcb       $AE       ; table, bitmap, or initialized data bytes
                    fcc       "a"                            ; embedded text or resource bytes
                    fcb       $26,$04   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "6O_"                          ; embedded text or resource bytes
                    fcb       $17,$F6,$C4,$0A,$8E,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0B       ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $15,$17,$F6,$BB ; table, bitmap, or initialized data bytes
                    fcc       "D"                            ; embedded text or resource bytes
                    fcb       $10,$AE   ; table, bitmap, or initialized data bytes
                    fcc       "c"                            ; embedded text or resource bytes
                    fcb       $AE,$A4,$CC,$90,$00,$17 ; table, bitmap, or initialized data bytes
                    fcb       $FC,$F5   ; table, bitmap, or initialized data bytes
                    fcc       "M'"                           ; embedded text or resource bytes
                    fcb       $0A,$81,$0D ; table, bitmap, or initialized data bytes
                    fcc       "'B"                           ; embedded text or resource bytes
                    fcb       $81,$05   ; table, bitmap, or initialized data bytes
                    fcc       "'3 -4v"                       ; embedded text or resource bytes
                    fcb       $17,$F6,$9D ; table, bitmap, or initialized data bytes
                    fcc       ">4"                           ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "m"                            ; embedded text or resource bytes
                    fcb       $8D,$FF,$02,$26,$04 ; table, bitmap, or initialized data bytes
                    fcc       "J*"                           ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $17,$F6,$8D ; table, bitmap, or initialized data bytes
                    fcc       "="                            ; embedded text or resource bytes
                    fcb       $17,$F6,$89 ; table, bitmap, or initialized data bytes
                    fcc       "E5"                           ; embedded text or resource bytes
                    fcb       $02,$17,$F6,$83 ; table, bitmap, or initialized data bytes
                    fcc       "="                            ; embedded text or resource bytes
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
                    fcb       $F6       ; table, bitmap, or initialized data bytes
                    fcc       "CJ"                           ; embedded text or resource bytes
                    fcb       $C4,$EF   ; table, bitmap, or initialized data bytes
                    fcc       "]'O0"                         ; embedded text or resource bytes
                    fcb       $8D,$FE,$E6 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $10,$E6,$84,$0D ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $26,$08   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FE,$A7,$17,$F6 ; table, bitmap, or initialized data bytes
                    fcc       "*8"                           ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       ")"                            ; embedded text or resource bytes
                    fcb       $8B,$02,$17,$F6,$22 ; table, bitmap, or initialized data bytes
                    fcc       "="                            ; embedded text or resource bytes
                    fcb       $D1       ; table, bitmap, or initialized data bytes
                    fcc       "+'"                           ; embedded text or resource bytes
                    fcb       $06,$D7   ; table, bitmap, or initialized data bytes
                    fcc       "+"                            ; embedded text or resource bytes
                    fcb       $17,$F6,$18 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $C6,$03,$D7 ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $10,$8E,$00,$01 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $8E,$00,$01,$17,$F6,$08 ; table, bitmap, or initialized data bytes
                    fcc       "D"                            ; embedded text or resource bytes
                    fcb       $AE,$E4,$17,$F6,$02,$0A ; table, bitmap, or initialized data bytes
                    fcb       $AF,$E4   ; table, bitmap, or initialized data bytes
                    fcc       "1!Z"                          ; embedded text or resource bytes
                    fcb       $26,$EB   ; table, bitmap, or initialized data bytes
                    fcc       "2b"                           ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       ")L"                           ; embedded text or resource bytes
                    fcb       $17,$F5,$F2 ; table, bitmap, or initialized data bytes
                    fcc       "="                            ; embedded text or resource bytes
                    fcb       $16,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "+"                            ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       ")"                            ; embedded text or resource bytes
                    fcb       $17,$F5,$E9 ; table, bitmap, or initialized data bytes
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
                    fcb       $06,$17,$F5 ; table, bitmap, or initialized data bytes
                    fcc       "n"                            ; embedded text or resource bytes
                    fcb       $0F,$C1   ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $26,$04,$1F,$10 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8B       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $06,$17,$F5 ; table, bitmap, or initialized data bytes
                    fcc       "`D"                           ; embedded text or resource bytes
                    fcb       $17,$F5   ; table, bitmap, or initialized data bytes
                    fcc       "\5"                           ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       ":"                            ; embedded text or resource bytes
                    fcb       $17,$F5   ; table, bitmap, or initialized data bytes
                    fcc       "V594H"                        ; embedded text or resource bytes
                    fcb       $17,$F9,$DC ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $E9,$FE,$0C,$10,$DF ; table, bitmap, or initialized data bytes
                    fcc       ",46"                          ; embedded text or resource bytes
                    fcb       $17,$F5   ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $16,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "1O0"                          ; embedded text or resource bytes
                    fcb       $8D,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "h"                            ; embedded text or resource bytes
                    fcb       $17,$F5   ; table, bitmap, or initialized data bytes
                    fcc       "880"                          ; embedded text or resource bytes
                    fcb       $8D,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "p"                            ; embedded text or resource bytes
                    fcb       $17,$F5   ; table, bitmap, or initialized data bytes
                    fcc       "0G"                           ; embedded text or resource bytes
                    fcb       $C6,$0C,$E7,$84,$17,$F5 ; table, bitmap, or initialized data bytes
                    fcc       "(G"                           ; embedded text or resource bytes
                    fcb       $C6,$02,$E7,$84,$8E,$1F ; table, bitmap, or initialized data bytes
                    fcb       $1A,$10,$8E,$0B,$06,$86 ; table, bitmap, or initialized data bytes
                    fcb       $FF,$17,$F5,$17,$0E ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $0A,$17,$F5,$11,$0E,$17 ; table, bitmap, or initialized data bytes
                    fcb       $F5,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $DD       ; table, bitmap, or initialized data bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $17,$F5,$07 ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $17,$F5,$03 ; table, bitmap, or initialized data bytes
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
                    fcb       $26,$04,$17,$F4,$E5 ; table, bitmap, or initialized data bytes
                    fcc       "4]"                           ; embedded text or resource bytes
                    fcb       $26,$04,$17,$F4,$DE ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $AE       ; table, bitmap, or initialized data bytes
                    fcc       "d"                            ; embedded text or resource bytes
                    fcb       $A6,$94,$80 ; table, bitmap, or initialized data bytes
                    fcc       "0'"                           ; embedded text or resource bytes
                    fcb       $04,$81,$03 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $06,$17,$F4,$CE ; table, bitmap, or initialized data bytes
                    fcc       "N"                            ; embedded text or resource bytes
                    fcb       $A6,$84,$8E,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $04,$17,$F4,$C3 ; table, bitmap, or initialized data bytes
                    fcc       "D"                            ; embedded text or resource bytes
                    fcb       $17,$F4,$BF ; table, bitmap, or initialized data bytes
                    fcc       "@"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $17,$01   ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $C6       ; table, bitmap, or initialized data bytes
                    fcc       ")="                           ; embedded text or resource bytes
                    fcb       $17,$F4,$B3 ; table, bitmap, or initialized data bytes
                    fcc       "N0"                           ; embedded text or resource bytes
                    fcb       $88,$26   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8B,$DE   ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $10,$AE   ; table, bitmap, or initialized data bytes
                    fcc       "d"                            ; embedded text or resource bytes
                    fcb       $10,$AE,$22,$CC,$01,$F4 ; table, bitmap, or initialized data bytes
                    fcb       $17,$F4,$9F ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $01,$01,$97 ; table, bitmap, or initialized data bytes
                    fcc       "0'1"                          ; embedded text or resource bytes
                    fcb       $1F,$89,$17,$F4,$91 ; table, bitmap, or initialized data bytes
                    fcc       "K"                            ; embedded text or resource bytes
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
                    fcb       $A7,$04,$17,$F4 ; table, bitmap, or initialized data bytes
                    fcc       "x"                            ; embedded text or resource bytes
                    fcb       $0F,$C1   ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $26,$04,$C6,$06,$E7,$05 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $17,$F8,$86,$C6,$01,$E7 ; table, bitmap, or initialized data bytes
                    fcb       $8D,$FE,$DE,$0D ; table, bitmap, or initialized data bytes
                    fcc       "0'"                           ; embedded text or resource bytes
                    fcb       $05,$17,$F9,$89 ; table, bitmap, or initialized data bytes
                    fcc       " -"                           ; embedded text or resource bytes
                    fcb       $1F,$13,$17,$F4 ; table, bitmap, or initialized data bytes
                    fcc       "WE"                           ; embedded text or resource bytes
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
                    fcb       $17,$F4   ; table, bitmap, or initialized data bytes
                    fcc       ";"                      ;0BD7: 3B             ' ; embedded text or resource bytes
                    fcb       $1D,$17,$F4 ; table, bitmap, or initialized data bytes
                    fcc       "7"                            ; embedded text or resource bytes
                    fcb       $16,$1F,$89,$C1,$0D,$26 ; table, bitmap, or initialized data bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
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
                    fcb       $06,$17,$F3,$FE,$18 ; table, bitmap, or initialized data bytes
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
                    fcb       $E4,$17,$F3,$AA ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
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
                    fcb       $F3       ; table, bitmap, or initialized data bytes
                    fcc       "z"                            ; embedded text or resource bytes
                    fcb       $13       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $09,$E7,$84,$17,$F3 ; table, bitmap, or initialized data bytes
                    fcc       "r"                            ; embedded text or resource bytes
                    fcb       $13       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $16,$97   ; table, bitmap, or initialized data bytes
                    fcc       "19("                          ; embedded text or resource bytes
                    fcb       $80       ; table, bitmap, or initialized data bytes
Data_0CA9           fcc       "?"                            ; embedded text or resource bytes
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
Data_14AB           fcb       $CC,$CC   ; table, bitmap, or initialized data bytes
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
