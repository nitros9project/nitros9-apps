********************************************************************
* DMPAINT - DeskMate 3 paint application
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

                    nam       DMPAINT
                    ttl       DeskMate 3 paint application

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct
atrv                set       $00

                    mod       eom,name,tylg,atrv,start,$58D1

name                fcs       /DMPAINT/ ; OS-9 module name

Addr_0001           equ       $0001     ; absolute address used by original code
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
Addr_0013           equ       $0013     ; absolute address used by original code
Addr_0015           equ       $0015     ; absolute address used by original code
Addr_0016           equ       $0016     ; absolute address used by original code
Addr_0018           equ       $0018     ; absolute address used by original code
Addr_0019           equ       $0019     ; absolute address used by original code
Addr_00D6           equ       $00D6     ; absolute address used by original code
Addr_00FA           equ       $00FA     ; absolute address used by original code
Addr_00FE           equ       $00FE     ; absolute address used by original code
Addr_00FF           equ       $00FF     ; absolute address used by original code
Addr_0100           equ       $0100     ; absolute address used by original code
Addr_015E           equ       $015E     ; absolute address used by original code
Addr_0423           equ       $0423     ; absolute address used by original code
Addr_0500           equ       $0500     ; absolute address used by original code
Addr_089E           equ       $089E     ; absolute address used by original code
Addr_08A6           equ       $08A6     ; absolute address used by original code
Addr_0CB8           equ       $0CB8     ; absolute address used by original code
Addr_0CFF           equ       $0CFF     ; absolute address used by original code
Addr_0DC0           equ       $0DC0     ; absolute address used by original code
Addr_2020           equ       $2020     ; absolute address used by original code
Addr_2743           equ       $2743     ; absolute address used by original code
Addr_2768           equ       $2768     ; absolute address used by original code
Addr_2793           equ       $2793     ; absolute address used by original code
Addr_2B41           equ       $2B41     ; absolute address used by original code
Addr_3F1A           equ       $3F1A     ; absolute address used by original code
Addr_6120           equ       $6120     ; absolute address used by original code
Addr_6520           equ       $6520     ; absolute address used by original code
Addr_8080           equ       $8080     ; absolute address used by original code
Addr_8400           equ       $8400     ; absolute address used by original code
Addr_9000           equ       $9000     ; absolute address used by original code
Addr_AAAA           equ       $AAAA     ; absolute address used by original code
Addr_FD01           equ       $FD01     ; absolute address used by original code
Addr_FF01           equ       $FF01     ; absolute address used by original code
Addr_FFF8           equ       $FFF8     ; absolute address used by original code
Addr_FFFB           equ       $FFFB     ; absolute address used by original code
Addr_FFFF           equ       $FFFF     ; absolute address used by original code
DeskMateService     equ       $0000     ; absolute address used by original code
Addr_0002           equ       $0002     ; absolute address used by original code
Addr_25CE           equ       $25CE     ; absolute address used by original code
Addr_25D8           equ       $25D8     ; absolute address used by original code
Addr_2630           equ       $2630     ; absolute address used by original code
Addr_2661           equ       $2661     ; absolute address used by original code
Addr_267F           equ       $267F     ; absolute address used by original code
Addr_2686           equ       $2686     ; absolute address used by original code
Addr_268E           equ       $268E     ; absolute address used by original code
Addr_2690           equ       $2690     ; absolute address used by original code
Addr_2694           equ       $2694     ; absolute address used by original code
Addr_26A5           equ       $26A5     ; absolute address used by original code
Addr_26A8           equ       $26A8     ; absolute address used by original code
Addr_26B0           equ       $26B0     ; absolute address used by original code
Addr_26B8           equ       $26B8     ; absolute address used by original code
Addr_26D8           equ       $26D8     ; absolute address used by original code
Addr_26F0           equ       $26F0     ; absolute address used by original code
Addr_26FE           equ       $26FE     ; absolute address used by original code
Addr_270A           equ       $270A     ; absolute address used by original code
Addr_272B           equ       $272B     ; absolute address used by original code
Addr_2737           equ       $2737     ; absolute address used by original code
Addr_279A           equ       $279A     ; absolute address used by original code
Addr_2D2E           equ       $2D2E     ; absolute address used by original code

start               jmp       >DeskMateService ; dispatch control through the selected target
Code_0017           lbra      Code_0112 ; continue at the distant control-flow target
Data_001A           fcc       "("                            ; embedded text or resource bytes
Data_001B           fcb       $01       ; table, bitmap, or initialized data bytes
Data_001C           fcb       $CC       ; table, bitmap, or initialized data bytes
Data_001D           fcb       $CC       ; table, bitmap, or initialized data bytes
Data_001E           fcc       "3"                            ; embedded text or resource bytes
Data_001F           fcc       "3"                            ; embedded text or resource bytes
Data_0020           fcb       $CC       ; table, bitmap, or initialized data bytes
Data_0021           fcb       $CC       ; table, bitmap, or initialized data bytes
Data_0022           fcc       "3"                            ; embedded text or resource bytes
Data_0023           fcc       "3"                            ; embedded text or resource bytes
Data_0024           fcb       $CC       ; table, bitmap, or initialized data bytes
Data_0025           fcb       $CC       ; table, bitmap, or initialized data bytes
Data_0026           fcc       "3"                            ; embedded text or resource bytes
Data_0027           fcc       "3"                            ; embedded text or resource bytes
Data_0028           fcb       $CC       ; table, bitmap, or initialized data bytes
Data_0029           fcb       $CC       ; table, bitmap, or initialized data bytes
Data_002A           fcc       "3"                            ; embedded text or resource bytes
Data_002B           fcc       "3"                            ; embedded text or resource bytes
Data_002C           fcc       "A"                            ; embedded text or resource bytes
Data_002D           fcc       "CC"                           ; embedded text or resource bytes
Data_002F           fcc       "D"                            ; embedded text or resource bytes
Data_0030           fcc       "AT"                           ; embedded text or resource bytes
Data_0032           fcc       "A"                            ; embedded text or resource bytes
Data_0033           fcb       $00       ; table, bitmap, or initialized data bytes
Data_0034           fcb       $F0       ; table, bitmap, or initialized data bytes
Data_0035           fcb       $0F       ; table, bitmap, or initialized data bytes
Data_0036           fcb       $C0       ; table, bitmap, or initialized data bytes
Data_0037           fcc       "0"                            ; embedded text or resource bytes
                    fcb       $0C       ; table, bitmap, or initialized data bytes
Data_0039           fcb       $03       ; table, bitmap, or initialized data bytes
Data_003A           fcb       $00       ; table, bitmap, or initialized data bytes
Data_003B           fcb       $FF       ; table, bitmap, or initialized data bytes
Data_003C           fcc       "U"                            ; embedded text or resource bytes
                    fcb       $AA       ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
Data_003F           fcc       "D"                            ; embedded text or resource bytes
Data_0040           fcb       $11       ; table, bitmap, or initialized data bytes
Data_0041           fcc       "f"                            ; embedded text or resource bytes
Data_0042           fcc       "w"                            ; embedded text or resource bytes
Data_0043           fcb       $88,$99   ; table, bitmap, or initialized data bytes
Data_0045           fcb       $22,$BB   ; table, bitmap, or initialized data bytes
Data_0047           fcb       $CC,$DD   ; table, bitmap, or initialized data bytes
Data_0049           fcb       $EE       ; table, bitmap, or initialized data bytes
Data_004A           fcc       "("                            ; embedded text or resource bytes
Data_004B           fcb       $04,$08   ; table, bitmap, or initialized data bytes
Data_004D           fcb       $00       ; table, bitmap, or initialized data bytes
Data_004E           fcb       $00,$00   ; table, bitmap, or initialized data bytes
Data_0050           fcb       $0F,$AA   ; table, bitmap, or initialized data bytes
Data_0052           fcb       $AA       ; table, bitmap, or initialized data bytes
Data_0053           fcb       $AA       ; table, bitmap, or initialized data bytes
Data_0054           fcb       $FA       ; table, bitmap, or initialized data bytes
Data_0055           fcb       $A0,$00   ; table, bitmap, or initialized data bytes
Data_0057           fcb       $0F       ; table, bitmap, or initialized data bytes
Data_0058           fcb       $0A       ; table, bitmap, or initialized data bytes
Data_0059           fcb       $A0       ; table, bitmap, or initialized data bytes
Data_005A           fcb       $00       ; table, bitmap, or initialized data bytes
Data_005B           fcb       $F0       ; table, bitmap, or initialized data bytes
Data_005C           fcb       $0A       ; table, bitmap, or initialized data bytes
Data_005D           fcb       $AF       ; table, bitmap, or initialized data bytes
Data_005E           fcb       $0F       ; table, bitmap, or initialized data bytes
Data_005F           fcb       $00,$0A   ; table, bitmap, or initialized data bytes
Data_0061           fcb       $A0       ; table, bitmap, or initialized data bytes
Data_0062           fcb       $F0       ; table, bitmap, or initialized data bytes
Data_0063           fcb       $00,$0A   ; table, bitmap, or initialized data bytes
Data_0065           fcb       $A0       ; table, bitmap, or initialized data bytes
Data_0066           fcb       $00       ; table, bitmap, or initialized data bytes
Data_0067           fcb       $00,$0A   ; table, bitmap, or initialized data bytes
Data_0069           fcb       $AA,$AA   ; table, bitmap, or initialized data bytes
Data_006B           fcb       $AA,$AA   ; table, bitmap, or initialized data bytes
Data_006D           fcc       "("                            ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
Data_006F           fcb       $08       ; table, bitmap, or initialized data bytes
Data_0070           fcb       $00,$00   ; table, bitmap, or initialized data bytes
Data_0072           fcb       $00,$00   ; table, bitmap, or initialized data bytes
Data_0074           fcb       $AA,$AA   ; table, bitmap, or initialized data bytes
Data_0076           fcb       $AA,$AA   ; table, bitmap, or initialized data bytes
Data_0078           fcb       $A0,$00   ; table, bitmap, or initialized data bytes
Data_007A           fcb       $00,$0A   ; table, bitmap, or initialized data bytes
Data_007C           fcb       $A0,$00   ; table, bitmap, or initialized data bytes
Data_007E           fcb       $00       ; table, bitmap, or initialized data bytes
Data_007F           fcb       $0A       ; table, bitmap, or initialized data bytes
Data_0080           fcb       $A0       ; table, bitmap, or initialized data bytes
Data_0081           fcb       $00       ; table, bitmap, or initialized data bytes
Data_0082           fcb       $00       ; table, bitmap, or initialized data bytes
Data_0083           fcb       $0A       ; table, bitmap, or initialized data bytes
Data_0084           fcb       $A0,$00   ; table, bitmap, or initialized data bytes
Data_0086           fcb       $00,$0A   ; table, bitmap, or initialized data bytes
Data_0088           fcb       $A0       ; table, bitmap, or initialized data bytes
Data_0089           fcb       $00       ; table, bitmap, or initialized data bytes
Data_008A           fcb       $00       ; table, bitmap, or initialized data bytes
Data_008B           fcb       $0A,$AA   ; table, bitmap, or initialized data bytes
Data_008D           fcb       $AA,$AA   ; table, bitmap, or initialized data bytes
Data_008F           fcb       $AA       ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
Data_0091           fcb       $00,$01   ; table, bitmap, or initialized data bytes
Data_0093           fcb       $0A       ; table, bitmap, or initialized data bytes
Data_0094           fcb       $07       ; table, bitmap, or initialized data bytes
Data_0095           fcb       $00       ; table, bitmap, or initialized data bytes
Data_0096           fcb       $AA       ; table, bitmap, or initialized data bytes
Data_0097           fcc       " "                            ; embedded text or resource bytes
Data_0098           fcc       "("                            ; embedded text or resource bytes
Data_0099           fcb       $13,$01   ; table, bitmap, or initialized data bytes
Data_009B           fcb       $0A       ; table, bitmap, or initialized data bytes
Data_009C           fcb       $08       ; table, bitmap, or initialized data bytes
Data_009D           fcb       $00       ; table, bitmap, or initialized data bytes
Data_009E           fcb       $AA       ; table, bitmap, or initialized data bytes
Data_009F           fcc       " "                            ; embedded text or resource bytes
Data_00A0           fcc       "("                            ; embedded text or resource bytes
Data_00A1           fcb       $04       ; table, bitmap, or initialized data bytes
Data_00A2           fcb       $06       ; table, bitmap, or initialized data bytes
Data_00A3           fcb       $14       ; table, bitmap, or initialized data bytes
Data_00A4           fcb       $05,$00   ; table, bitmap, or initialized data bytes
Data_00A6           fcb       $FF       ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
Data_00A8           fcc       "("                            ; embedded text or resource bytes
                    fcb       $06       ; table, bitmap, or initialized data bytes
Data_00AA           fcb       $12,$1D   ; table, bitmap, or initialized data bytes
Data_00AC           fcb       $06       ; table, bitmap, or initialized data bytes
Data_00AD           fcb       $00,$FF   ; table, bitmap, or initialized data bytes
Data_00AF           fcc       "8"                            ; embedded text or resource bytes
Data_00B0           fcc       "("                            ; embedded text or resource bytes
Data_00B1           fcb       $03,$07   ; table, bitmap, or initialized data bytes
Data_00B3           fcb       $19,$04,$00,$FF ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_00B9           fcb       $00,$05,$08,$05,$00 ; table, bitmap, or initialized data bytes
Data_00BE           fcb       $00,$00   ; table, bitmap, or initialized data bytes
Data_00C0           fcb       $00,$06,$08,$06,$00 ; table, bitmap, or initialized data bytes
Data_00C5           fcb       $00,$00,$00,$03,$12,$03 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00   ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
Code_00CE           sta       Data_0034 ; save the current value in working storage
                    beq       Code_00DA ; branch when the compared values are equal
                    lda       #$14      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $09       ; private DeskMate service selector
                    bra       Code_00E9 ; continue at the selected control-flow target
Code_00DA           lda       #$28      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $09       ; private DeskMate service selector
                    bra       Code_00E9 ; continue at the selected control-flow target
                    fcc       "O "                           ; embedded text or resource bytes
                    fcb       $02,$86,$01 ; table, bitmap, or initialized data bytes
Code_00E7           sta       Data_0034 ; save the current value in working storage
Code_00E9           pshs      U,Y,X     ; preserve the listed registers on the stack
                    lda       #$01      ; load the value needed by the following operation
                    leay      Data_0034,PCR ; form the referenced address without reading memory
                    ldx       #Data_00A0 ; load the value needed by the following operation
                    ldu       #Data_1B80 ; load the value needed by the following operation
                    tst       Data_0034 ; set condition flags from the current value
                    bne       Code_0107 ; branch when the compared values differ
                    lda       #$03      ; load the value needed by the following operation
                    leay      Data_0036,PCR ; form the referenced address without reading memory
Code_0101           ldx       #Code_0140 ; load the value needed by the following operation
                    ldu       #Data_3700 ; load the value needed by the following operation
Code_0107           sta       Data_0036 ; save the current value in working storage
                    sty       Data_0037 ; save the current value in working storage
                    stx       Data_0039 ; save the current value in working storage
                    stu       Data_003B ;010E: DF 3B          '. ; save the current value in working storage
                    puls      PC,U,Y,X  ; restore the listed registers from the stack
Code_0112           tfr       X,S       ; copy the source register into the destination register
                    pshs      X         ; preserve the listed registers on the stack
                    leax      Data_001C,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $05       ; private DeskMate service selector
                    puls      X         ; restore the listed registers from the stack
                    pshs      U         ; preserve the listed registers on the stack
                    leau      $5291,U   ; form the referenced address without reading memory
Code_0126           clr       ,-U       ; clear the selected byte or register
                    cmpu      ,S        ; compare against the limit and set condition flags
                    bne       Code_0126 ; branch when the compared values differ
                    puls      U         ; restore the listed registers from the stack
                    stu       Data_00A2 ; save the current value in working storage
                    pshs      U,Y,X,D   ; preserve the listed registers on the stack
                    leax      Data_002C,PCR ; form the referenced address without reading memory
                    lda       #$05      ; load the value needed by the following operation
                    os9       I$Open    ; request the named OS-9 service
Code_013C           lbcs      Code_24D2 ; take the distant branch when carry reports an error
Code_0140           ldx       Data_00A2 ; load the value needed by the following operation
                    leax      $45DE,X   ; form the referenced address without reading memory
                    ldy       #Addr_0CB8 ; load the value needed by the following operation
                    os9       I$Read    ; request the named OS-9 service
                    lbcs      Code_24D2 ; take the distant branch when carry reports an error
                    os9       I$Close   ; request the named OS-9 service
                    lbcs      Code_24D2 ; take the distant branch when carry reports an error
                    puls      U,Y,X,D   ; restore the listed registers from the stack
                    stx       Data_00AD ; save the current value in working storage
                    cmpd      #Addr_0001 ; compare against the limit and set condition flags
                    bne       Code_0165 ; branch when the compared values differ
                    decb                ; decrement the selected counter
                    std       Data_00AD ; save the current value in working storage
Code_0165           leay      $0EDE,U   ; form the referenced address without reading memory
                    sty       Data_00B3 ; save the current value in working storage
                    leay      $00FE,U   ; form the referenced address without reading memory
                    sty       Data_007F ; save the current value in working storage
                    leay      $5291,U   ; form the referenced address without reading memory
                    sty       Data_006B ; save the current value in working storage
                    sty       Data_006D ; save the current value in working storage
                    leay      $30,Y     ; form the referenced address without reading memory
                    sty       Data_0067 ; save the current value in working storage
                    sty       Data_0069 ; save the current value in working storage
                    leay      $00A6,U   ; form the referenced address without reading memory
                    sty       Data_00A4 ; save the current value in working storage
                    leax      $00B5,U   ; form the referenced address without reading memory
                    stx       Data_00A6 ; save the current value in working storage
                    ldy       #Addr_000A ; load the value needed by the following operation
                    ldd       #Addr_2020 ; load the value needed by the following operation
                    lbsr      Code_2495 ; call the referenced helper routine
                    leay      Data_02A0,PCR ; form the referenced address without reading memory
                    sty       Data_00A8 ; save the current value in working storage
                    leay      $00C0,U   ; form the referenced address without reading memory
                    sty       Data_00AA ; save the current value in working storage
                    leax      $0ECE,U   ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       ")"                            ; embedded text or resource bytes
                    lbsr      Code_048D ; call the referenced helper routine
                    ldx       Data_00A2 ; load the value needed by the following operation
                    leax      $4CA1,X   ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $04       ; private DeskMate service selector
                    leax      Data_178A,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $03       ; private DeskMate service selector
                    lda       #$01      ; load the value needed by the following operation
                    lbsr      Code_00CE ; call the referenced helper routine
                    ldx       Data_00A2 ; load the value needed by the following operation
                    leax      $4CA1,X   ; form the referenced address without reading memory
                    leax      $FE00,X   ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $04       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "4"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       " "                            ; embedded text or resource bytes
                    stx       Data_00AF ; save the current value in working storage
                    leax      $0500,X   ; form the referenced address without reading memory
                    stx       Data_00B1 ; save the current value in working storage
                    ldd       Data_0039 ; load the value needed by the following operation
                    lsrb                ; shift right and expose the low bit through carry
                    std       Data_0055 ; save the current value in working storage
                    ldd       #Data_0070 ; load the value needed by the following operation
                    std       Data_0057 ; save the current value in working storage
                    ldd       #Addr_0005 ; load the value needed by the following operation
                    std       Data_0091 ; save the current value in working storage
                    lda       #$01      ; load the value needed by the following operation
                    sta       Data_0030 ; save the current value in working storage
                    inca                ; advance the selected counter
Code_01FF           sta       Data_0096 ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $00       ; private DeskMate service selector
                    lda       #$01      ; load the value needed by the following operation
                    lbsr      Code_02BE ; call the referenced helper routine
                    lbsr      Code_0257 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    lbsr      Code_35AC ; call the referenced helper routine
Code_0211           lbsr      Code_245E ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       ","                            ; embedded text or resource bytes
                    tfr       Y,S       ; copy the source register into the destination register
                    ldx       Data_00AD ; load the value needed by the following operation
                    beq       Code_0254 ; branch when the compared values are equal
                    ldb       ,X        ; load the value needed by the following operation
                    cmpb      #$30      ; compare against the limit and set condition flags
                    beq       Code_0254 ; branch when the compared values are equal
                    cmpb      #$33      ; compare against the limit and set condition flags
                    beq       Code_0254 ; branch when the compared values are equal
                    cmpb      #$34      ; compare against the limit and set condition flags
                    beq       Code_0254 ; branch when the compared values are equal
                    clr       $0A,X     ; clear the selected byte or register
                    ldy       Data_00A6 ; load the value needed by the following operation
                    lbsr      Code_07E2 ; call the referenced helper routine
                    lda       #$3E      ; load the value needed by the following operation
                    ldy       Data_00A4 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "J"                            ; embedded text or resource bytes
                    tstb                ; set condition flags from the current value
                    beq       Code_024E ; branch when the compared values are equal
                    ldx       Data_00A6 ; load the value needed by the following operation
                    ldy       #Addr_000A ; load the value needed by the following operation
                    ldd       #Addr_2020 ; load the value needed by the following operation
                    lbsr      Code_2495 ; call the referenced helper routine
                    bra       Code_0254 ; continue at the selected control-flow target
Code_024E           lbsr      Code_055C ; call the referenced helper routine
                    lbsr      Code_076D ; call the referenced helper routine
Code_0254           lbra      Addr_279A ; continue at the distant control-flow target
Code_0257           pshs      U,Y,X,D   ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $18       ; private DeskMate service selector
                    sta       Data_0032 ; save the current value in working storage
                    beq       Code_0263 ; branch when the compared values are equal
                    lda       #$02      ; load the value needed by the following operation
Code_0263           lbsr      Code_052B ; call the referenced helper routine
                    lda       Data_0052 ; load the value needed by the following operation
                    sta       Data_0053 ; save the current value in working storage
                    puls      PC,U,Y,X,D ; restore the listed registers from the stack
                    fcc       "4w"                           ; embedded text or resource bytes
                    fcb       $F6,$FF,$9A ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "Os"                           ; embedded text or resource bytes
                    fcb       $FF,$9A,$F7,$FF,$9A,$17 ; table, bitmap, or initialized data bytes
                    fcb       $00,$0F,$26,$F5 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $17,$00,$09 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $FB       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $04,$F7,$FF,$9A ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $F7       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $06,$C6,$01 ; table, bitmap, or initialized data bytes
                    fcc       "J+"                           ; embedded text or resource bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "X "                           ; embedded text or resource bytes
                    fcb       $FA,$86,$FF,$B7,$FF,$02 ; table, bitmap, or initialized data bytes
                    fcb       $F4,$FF,$00 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
Data_02A0           fcc       "PIC"                          ; embedded text or resource bytes
                    fcb       $00,$17,$04,$D0,$17 ; table, bitmap, or initialized data bytes
                    fcc       "8m"                           ; embedded text or resource bytes
                    fcb       $9E       ; table, bitmap, or initialized data bytes
                    fcc       "/4"                           ; embedded text or resource bytes
                    fcb       $10,$17   ; table, bitmap, or initialized data bytes
                    fcc       "9\5"                          ; embedded text or resource bytes
                    fcb       $10,$C1,$0D ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $07,$C1,$05,$26,$F1,$9F ; table, bitmap, or initialized data bytes
                    fcc       "/9"                           ; embedded text or resource bytes
Code_02BE           sta       Data_002B ; save the current value in working storage
Code_02C0           lda       Data_002B ; load the value needed by the following operation
                    clr       Data_0025 ; clear the selected byte or register
                    cmpa      #$10      ; compare against the limit and set condition flags
                    bcc       Code_02D1 ; branch when carry is clear
                    leay      Data_003A,PCR ; form the referenced address without reading memory
                    lda       A,Y       ; load the value needed by the following operation
                    sta       Data_002C ; save the current value in working storage
                    rts                 ; return to the caller
Code_02D1           com       Data_0025 ; invert every bit in the selected value
                    suba      #$10      ; subtract the operand from the running value
                    ldb       #$20      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    ldu       Data_00A2 ; load the value needed by the following operation
                    leau      $4710,U   ; form the referenced address without reading memory
                    leau      D,U       ; form the referenced address without reading memory
                    stu       Data_0029 ; save the current value in working storage
                    lda       #$07      ; load the value needed by the following operation
                    sta       Data_0026 ; save the current value in working storage
                    lda       #$0E      ; load the value needed by the following operation
                    tst       Data_0034 ; set condition flags from the current value
                    beq       Code_02ED ; branch when the compared values are equal
                    lsra                ; shift right and expose the low bit through carry
Code_02ED           sta       Data_0027 ; save the current value in working storage
                    lda       #$04      ; load the value needed by the following operation
                    sta       Data_0028 ; save the current value in working storage
                    rts                 ; return to the caller
                    fcb       $86,$03,$17,$FD,$1B,$10 ; table, bitmap, or initialized data bytes
                    fcb       $8D,$09   ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $17       ; table, bitmap, or initialized data bytes
Data_0300           fcb       $FD,$12,$10 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $82       ; table, bitmap, or initialized data bytes
Code_0305           clrb                ; clear the selected byte or register
                    lbsr      Code_0752 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    lda       #$80      ; load the value needed by the following operation
                    lbsr      Code_25C0 ; call the referenced helper routine
                    lda       #$80      ; load the value needed by the following operation
                    lbsr      Code_25D6 ; call the referenced helper routine
Code_0317           bsr       Code_0334 ; call the referenced helper routine
Code_0319           lbsr      Code_0CDE ; call the referenced helper routine
                    cmpb      #$0D      ; compare against the limit and set condition flags
                    beq       Code_0324 ; branch when the compared values are equal
                    cmpb      #$05      ; compare against the limit and set condition flags
                    bne       Code_0319 ; branch when the compared values differ
Code_0324           leas      $03,Y     ; form the referenced address without reading memory
                    rts                 ; return to the caller
Code_0327           asla                ; shift left and update carry
                    ldy       A,Y       ; load the value needed by the following operation
Code_032B           leax      DeskMateService,PCR ; form the referenced address without reading memory
                    tfr       X,D       ; copy the source register into the destination register
                    leay      D,Y       ; form the referenced address without reading memory
                    rts                 ; return to the caller
Code_0334           pshs      B         ; preserve the listed registers on the stack
                    lda       $04,Y     ; load the value needed by the following operation
                    sta       Addr_0011 ; save the current value in working storage
                    asla                ; shift left and update carry
                    nega                ; form the two's-complement negative value
                    leas      A,S       ; form the referenced address without reading memory
                    pshs      Y         ; preserve the listed registers on the stack
                    bsr       Code_032B ; call the referenced helper routine
                    leay      $02,S     ; form the referenced address without reading memory
Code_0344           ldx       ,U++      ; fetch the next value and advance the source pointer
                    leax      D,X       ; form the referenced address without reading memory
                    stx       ,Y++      ; store the value and advance the destination pointer
                    dec       Addr_0011 ; decrement the selected counter
                    bne       Code_0344 ; branch when the compared values differ
                    puls      X         ; restore the listed registers from the stack
                    sts       ,X        ; save the current value in working storage
                    lda       ,Y        ; load the value needed by the following operation
                    lbsr      Code_0752 ; call the referenced helper routine
                    lbsr      Code_0BCE ; call the referenced helper routine
                    lbsr      Code_075B ; call the referenced helper routine
                    leau      $01,Y     ; form the referenced address without reading memory
                    pulu      PC        ; restore the listed registers from the stack
                    fcb       $17,$04,$12,$86,$05,$17 ; table, bitmap, or initialized data bytes
                    fcb       $FC,$AA,$10 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FD   ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $17,$01,$9A ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $8D,$FD   ; table, bitmap, or initialized data bytes
                    fcc       "B3"                           ; embedded text or resource bytes
                    fcb       $8D       ; table, bitmap, or initialized data bytes
                    fcc       "#?_"                          ; embedded text or resource bytes
                    fcb       $17,$FF,$B6 ; table, bitmap, or initialized data bytes
                    fcc       "4 "                           ; embedded text or resource bytes
                    fcb       $17,$09   ; table, bitmap, or initialized data bytes
                    fcc       "["                            ; embedded text or resource bytes
                    fcb       $C1,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "',"                           ; embedded text or resource bytes
                    fcb       $C1,$05   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $12,$C1,$B2 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $18,$C1,$AF,$26,$ED ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $17,$FC   ; table, bitmap, or initialized data bytes
                    fcc       "}"                            ; embedded text or resource bytes
                    fcb       $10,$86,$01,$17,$00,$BF ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $17,$FC   ; table, bitmap, or initialized data bytes
                    fcc       "s"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "5 2#9O"                       ; embedded text or resource bytes
                    fcb       $17,$FC   ; table, bitmap, or initialized data bytes
                    fcc       "i"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "5 2#"                         ; embedded text or resource bytes
                    fcb       $16,$05   ; table, bitmap, or initialized data bytes
                    fcc       "T5 2#1"                       ; embedded text or resource bytes
                    fcb       $8D       ; table, bitmap, or initialized data bytes
                    fcc       "#D"                           ; embedded text or resource bytes
                    fcb       $17,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "iO"                           ; embedded text or resource bytes
                    fcb       $17,$FC   ; table, bitmap, or initialized data bytes
                    fcc       "R"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "n"                            ; embedded text or resource bytes
                    fcb       $A4,$17,$03,$D4,$86,$05 ; table, bitmap, or initialized data bytes
                    fcb       $17,$FC   ; table, bitmap, or initialized data bytes
                    fcc       "G"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FC,$C6,$17,$01 ; table, bitmap, or initialized data bytes
                    fcc       "71"                           ; embedded text or resource bytes
                    fcb       $8D,$FC,$E6 ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $8D,$22,$E6 ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $17,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "S4 "                          ; embedded text or resource bytes
                    fcb       $17,$08,$F8,$C1,$0D ; table, bitmap, or initialized data bytes
                    fcc       "'-"                           ; embedded text or resource bytes
                    fcb       $C1,$05   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $18,$C1,$AF,$26,$F1 ; table, bitmap, or initialized data bytes
                    fcc       "5 2#"                         ; embedded text or resource bytes
                    fcb       $17,$03   ; table, bitmap, or initialized data bytes
                    fcc       "~"                            ; embedded text or resource bytes
                    fcb       $17,$03,$AF ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $17,$FC,$14,$10,$86,$03 ; table, bitmap, or initialized data bytes
                    fcb       $16,$00   ; table, bitmap, or initialized data bytes
                    fcc       "V5 2#"                        ; embedded text or resource bytes
                    fcb       $17,$03,$AC ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $17,$FC,$03,$10 ; table, bitmap, or initialized data bytes
                    fcc       "2b"                           ; embedded text or resource bytes
                    fcb       $16       ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $19       ; table, bitmap, or initialized data bytes
                    puls      Y         ; restore the listed registers from the stack
                    leas      $03,Y     ; form the referenced address without reading memory
                    pshs      A         ; preserve the listed registers on the stack
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    lda       ,S        ; load the value needed by the following operation
                    cmpa      #$01      ; compare against the limit and set condition flags
                    bne       Code_042D ; branch when the compared values differ
                    lbsr      Code_07B9 ; call the referenced helper routine
                    bra       Code_0433 ; continue at the selected control-flow target
Code_042D           lbsr      Code_0777 ; call the referenced helper routine
                    lbsr      Code_07AB ; call the referenced helper routine
Code_0433           puls      A         ; restore the listed registers from the stack
                    leay      Code_270F,PCR ; form the referenced address without reading memory
                    lbsr      Code_0327 ; call the referenced helper routine
                    jmp       ,Y        ; dispatch control through the selected target
Data_043E           fcc       "("                            ; embedded text or resource bytes
                    fcb       $05,$05,$1E,$12,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U8"                           ; embedded text or resource bytes
Data_0446           fcc       "DMHELP"                       ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_044D           fcc       "DMPAINT "                     ; embedded text or resource bytes
Data_0455           fcb       $00,$00,$0D,$17,$03,$1C ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
Code_045C           sta       >Data_0455,PCR ; save the current value in working storage
                    lbsr      Code_0752 ; call the referenced helper routine
                    leax      >Data_043E,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    lbsr      Code_075B ; call the referenced helper routine
                    leau      >Data_044D,PCR ; form the referenced address without reading memory
                    ldd       #Addr_0100 ; load the value needed by the following operation
                    ldx       #Addr_FFFB ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "O"                            ; embedded text or resource bytes
                    leax      >Data_0446,PCR ; form the referenced address without reading memory
                    ldy       #Addr_000D ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "V"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "P"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_048D           pshs      X,D       ; preserve the listed registers on the stack
                    ldx       Data_00A2 ; load the value needed by the following operation
                    leax      $0EBE,X   ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       ")"                            ; embedded text or resource bytes
                    lda       $02,X     ; load the value needed by the following operation
                    ldb       $0A,X     ; load the value needed by the following operation
                    sta       $0A,X     ; save the current value in working storage
                    stb       $02,X     ; save the current value in working storage
                    lda       $01,X     ; load the value needed by the following operation
                    ldb       $05,X     ; load the value needed by the following operation
                    sta       $05,X     ; save the current value in working storage
                    stb       $01,X     ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "("                            ; embedded text or resource bytes
                    puls      PC,X,D    ; restore the listed registers from the stack
Code_04AF           pshs      X,D       ; preserve the listed registers on the stack
                    ldx       Data_00A2 ; load the value needed by the following operation
                    leax      $0EBE,X   ; form the referenced address without reading memory
                    lda       $02,X     ; load the value needed by the following operation
                    ldb       $0A,X     ; load the value needed by the following operation
                    sta       $0A,X     ; save the current value in working storage
                    stb       $02,X     ; save the current value in working storage
                    lda       $01,X     ; load the value needed by the following operation
                    ldb       $05,X     ; load the value needed by the following operation
                    sta       $05,X     ; save the current value in working storage
                    stb       $01,X     ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "("                            ; embedded text or resource bytes
                    puls      PC,X,D    ; restore the listed registers from the stack
Data_04CD           fcb       $F0,$00,$0D ; table, bitmap, or initialized data bytes
Data_04D0           fcc       "DMALT"                        ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
Code_04D6           lbsr      Code_0777 ; call the referenced helper routine
                    ldx       #Addr_FFF8 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "O"                            ; embedded text or resource bytes
                    leau      >Data_04CD,PCR ; form the referenced address without reading memory
                    ldd       #Addr_0100 ; load the value needed by the following operation
                    leax      >Data_04D0,PCR ; form the referenced address without reading memory
                    ldy       #Addr_0003 ; load the value needed by the following operation
                    bsr       Code_04AF ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "V"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "P"                            ; embedded text or resource bytes
                    bsr       Code_048D ; call the referenced helper routine
                    lbsr      Code_245E ; call the referenced helper routine
                    lbsr      Code_0257 ; call the referenced helper routine
                    lbra      Code_076D ; continue at the distant control-flow target
                    fcc       "2b"                           ; embedded text or resource bytes
                    fcb       $17,$02,$81 ; table, bitmap, or initialized data bytes
                    lbra      Code_2530 ; continue at the distant control-flow target
                    fcb       $17,$02   ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $17,$FB,$02 ; table, bitmap, or initialized data bytes
                    fcc       "890"                          ; embedded text or resource bytes
                    fcb       $8D,$FB,$88 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $8D,$FB,$AA ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $8D       ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $BB,$D6   ; table, bitmap, or initialized data bytes
                    fcc       "S"                            ; embedded text or resource bytes
                    fcb       $17,$FD,$E1,$C1,$05 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $22,$97   ; table, bitmap, or initialized data bytes
                    fcc       "S"                            ; embedded text or resource bytes
Code_052B           sta       Data_0052 ; save the current value in working storage
                    beq       Code_0539 ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $14       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $16       ; private DeskMate service selector
                    bra       Code_0541 ; continue at the selected control-flow target
Code_0539           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $15       ; private DeskMate service selector
Code_0541           leay      Code_2709,PCR ; form the referenced address without reading memory
                    lbsr      Code_0327 ; call the referenced helper routine
                    sty       Data_0050 ; save the current value in working storage
                    rts                 ; return to the caller
                    fcb       $86,$03,$16,$FF,$0B,$10 ; table, bitmap, or initialized data bytes
                    fcb       $9E,$A4,$86 ; table, bitmap, or initialized data bytes
                    fcc       ">"                            ; embedded text or resource bytes
                    fcb       $17,$0D,$06 ; table, bitmap, or initialized data bytes
                    fcc       "M"                            ; embedded text or resource bytes
                    fcb       $26       ; table, bitmap, or initialized data bytes
                    fcc       "F"                            ; embedded text or resource bytes
Code_055C           lda       #$01      ; load the value needed by the following operation
                    ldx       Data_00AA ; load the value needed by the following operation
                    os9       I$Open    ; request the named OS-9 service
                    bcc       Code_056A ; branch when carry is clear
                    cmpb      #$D8      ; compare against the limit and set condition flags
                    bne       Code_05E1 ; branch when the compared values differ
                    rts                 ; return to the caller
Code_056A           ldx       Data_00B3 ; load the value needed by the following operation
                    ldy       #Data_3700 ; load the value needed by the following operation
                    os9       I$Read    ; request the named OS-9 service
                    bcs       Code_05DE ; branch when carry reports an unsigned underflow or error
                    ldx       Data_00A2 ; load the value needed by the following operation
                    leax      $0EBE,X   ; form the referenced address without reading memory
                    ldy       #Addr_0010 ; load the value needed by the following operation
                    os9       I$Read    ; request the named OS-9 service
                    bcs       Code_05DE ; branch when carry reports an unsigned underflow or error
                    ldx       Data_00A2 ; load the value needed by the following operation
                    leax      $4710,X   ; form the referenced address without reading memory
                    ldy       #Data_0080 ; load the value needed by the following operation
                    os9       I$Read    ; request the named OS-9 service
                    bcs       Code_05DE ; branch when carry reports an unsigned underflow or error
                    os9       I$Close   ; request the named OS-9 service
                    bcs       Code_05DE ; branch when carry reports an unsigned underflow or error
                    ldx       Data_00A2 ; load the value needed by the following operation
                    leax      $0EBE,X   ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "("                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_05A3           leax      Data_00A8,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
Code_05AB           bsr       Code_05C3 ; call the referenced helper routine
                    ldx       #Addr_0001 ; load the value needed by the following operation
                    ldy       #Addr_0003 ; load the value needed by the following operation
                    lda       #$03      ; load the value needed by the following operation
                    bsr       Code_05FB ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1C       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $19       ; private DeskMate service selector
                    orcc      #$01      ; set the selected flag bits
                    rts                 ; return to the caller
Code_05C3           leay      Data_087C,PCR ; form the referenced address without reading memory
                    asla                ; shift left and update carry
                    ldy       A,Y       ; load the value needed by the following operation
                    lbsr      Code_032B ; call the referenced helper routine
                    tfr       Y,U       ; copy the source register into the destination register
                    ldy       ,U++      ; fetch the next value and advance the source pointer
                    ldx       ,U++      ; fetch the next value and advance the source pointer
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    tfr       U,X       ; copy the source register into the destination register
                    clra                ; clear the selected byte or register
                    bra       Code_05FF ; continue at the selected control-flow target
Code_05DE           os9       I$Close   ; request the named OS-9 service
Code_05E1           clra                ; clear the selected byte or register
                    cmpb      #$F8      ; compare against the limit and set condition flags
                    bne       Code_05A3 ; branch when the compared values differ
                    ldx       Data_00AA ; load the value needed by the following operation
                    os9       I$Delete  ; request the named OS-9 service
                    leax      Data_00A8,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    lda       #$01      ; load the value needed by the following operation
                    bsr       Code_05C3 ; call the referenced helper routine
                    lda       #$02      ; load the value needed by the following operation
                    bra       Code_05AB ; continue at the selected control-flow target
Code_05FB           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
Code_05FF           clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    rts                 ; return to the caller
                    fcb       $17,$01   ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $10,$9E,$A4,$86 ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
                    fcb       $97,$AC,$8E,$00,$00,$86 ; table, bitmap, or initialized data bytes
                    fcc       ">"                            ; embedded text or resource bytes
                    fcb       $17,$0A,$9F,$17 ; table, bitmap, or initialized data bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcb       $41       ; table, bitmap, or initialized data bytes
                    tsta                ; set condition flags from the current value
                    bne       Code_0661 ; branch when the compared values differ
Code_061D           lda       #$02      ; load the value needed by the following operation
                    ldx       Data_00AA ; load the value needed by the following operation
                    os9       I$Open    ; request the named OS-9 service
                    bcc       Code_0631 ; branch when carry is clear
                    cmpb      #$D8      ; compare against the limit and set condition flags
                    bne       Code_05E1 ; branch when the compared values differ
                    ldb       #$1B      ; load the value needed by the following operation
                    os9       I$Create  ; request the named OS-9 service
                    bcs       Code_05E1 ; branch when carry reports an unsigned underflow or error
Code_0631           ldx       Data_00B3 ; load the value needed by the following operation
                    ldy       #Data_3700 ; load the value needed by the following operation
                    os9       I$Write   ; request the named OS-9 service
                    bcs       Code_05DE ; branch when carry reports an unsigned underflow or error
                    ldx       Data_00A2 ; load the value needed by the following operation
                    leax      $0EBE,X   ; form the referenced address without reading memory
                    ldy       #Addr_0010 ; load the value needed by the following operation
                    os9       I$Write   ; request the named OS-9 service
                    bcs       Code_05DE ; branch when carry reports an unsigned underflow or error
                    ldx       Data_00A2 ; load the value needed by the following operation
                    leax      $4710,X   ; form the referenced address without reading memory
                    ldy       #Data_0080 ; load the value needed by the following operation
                    os9       I$Write   ; request the named OS-9 service
                    bcs       Code_05DE ; branch when carry reports an unsigned underflow or error
                    os9       I$Close   ; request the named OS-9 service
                    lbcs      Code_05DE ; take the distant branch when carry reports an error
Code_0661           rts                 ; return to the caller
Code_0662           ldx       #Data_3700 ; load the value needed by the following operation
                    ldu       Data_00B3 ; load the value needed by the following operation
                    clra                ; clear the selected byte or register
Code_0668           cmpa      ,U+       ; compare against the limit and set condition flags
                    bne       Code_0673 ; branch when the compared values differ
                    leax      -$01,X    ; form the referenced address without reading memory
                    bne       Code_0668 ; branch when the compared values differ
                    lbra      Code_24D2 ; continue at the distant control-flow target
Code_0673           leax      Data_00B0,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    lda       #$03      ; load the value needed by the following operation
                    lbsr      Code_05C3 ; call the referenced helper routine
                    lda       #$04      ; load the value needed by the following operation
                    lbsr      Code_05C3 ; call the referenced helper routine
                    lda       #$05      ; load the value needed by the following operation
                    lbsr      Code_05C3 ; call the referenced helper routine
                    ldy       Data_00A6 ; load the value needed by the following operation
                    lda       ,Y        ; load the value needed by the following operation
                    cmpa      #$20      ; compare against the limit and set condition flags
                    beq       Code_06A0 ; branch when the compared values are equal
                    lda       #$06      ; load the value needed by the following operation
                    lbsr      Code_05C3 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    ldx       Data_00A6 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
Code_06A0           clr       Code_0017 ; clear the selected byte or register
Code_06A2           leax      Data_004A,PCR ; form the referenced address without reading memory
                    leay      Data_006D,PCR ; form the referenced address without reading memory
                    tst       Code_0017 ; set condition flags from the current value
                    beq       Code_06B0 ; branch when the compared values are equal
                    exg       X,Y       ; exchange the two register values
Code_06B0           ldd       #Addr_3F1A ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    tfr       Y,X       ; copy the source register into the destination register
                    ldb       #$28      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
Code_06BF           clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    sta       Addr_0016 ; save the current value in working storage
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    beq       Code_0718 ; branch when the compared values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    bne       Code_06CF ; branch when the compared values differ
Code_06CE           rts                 ; return to the caller
Code_06CF           tst       Data_0052 ; set condition flags from the current value
                    beq       Code_070B ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "E"                            ; embedded text or resource bytes
                    cmpb      #$01      ; compare against the limit and set condition flags
                    bne       Code_06E3 ; branch when the compared values differ
                    cmpy      #Addr_00FF ; compare against the limit and set condition flags
                    beq       Code_06CE ; branch when the compared values are equal
                    bra       Code_0718 ; continue at the selected control-flow target
Code_06E3           cmpy      #Addr_00FF ; compare against the limit and set condition flags
                    beq       Code_070B ; branch when the compared values are equal
                    cmpx      #Addr_0009 ; compare against the limit and set condition flags
                    bcs       Code_06BF ; branch when carry reports an unsigned underflow or error
                    cmpx      #Addr_000E ; compare against the limit and set condition flags
                    bls       Code_0705 ; branch when the unsigned value is at or below the limit
                    cmpx      #Addr_0010 ; compare against the limit and set condition flags
                    bcs       Code_06BF ; branch when carry reports an unsigned underflow or error
                    cmpx      #start    ; compare against the limit and set condition flags
                    bhi       Code_06BF ; branch when the unsigned value is above the limit
Code_06FD           tst       Code_0017 ; set condition flags from the current value
                    bne       Code_06BF ; branch when the compared values differ
                    com       Code_0017 ; invert every bit in the selected value
                    bra       Code_06A2 ; continue at the selected control-flow target
Code_0705           tst       Code_0017 ; set condition flags from the current value
                    beq       Code_06BF ; branch when the compared values are equal
                    bra       Code_06A0 ; continue at the selected control-flow target
Code_070B           lda       Addr_0016 ; load the value needed by the following operation
                    cmpa      #$09      ; compare against the limit and set condition flags
                    beq       Code_06FD ; branch when the compared values are equal
                    cmpa      #$08      ; compare against the limit and set condition flags
                    beq       Code_0705 ; branch when the compared values are equal
                    lbra      Code_06BF ; continue at the distant control-flow target
Code_0718           tst       Code_0017 ; set condition flags from the current value
                    bne       Code_0739 ; branch when the compared values differ
                    ldy       Data_00A4 ; load the value needed by the following operation
                    lda       [,Y]      ; load the value needed by the following operation
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bne       Code_0734 ; branch when the compared values differ
                    clr       Data_00AC ; clear the selected byte or register
                    leax      Data_085E,PCR ; form the referenced address without reading memory
                    lda       #$3E      ; load the value needed by the following operation
                    lbsr      Code_10B6 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_0734 ; branch when the compared values are equal
                    rts                 ; return to the caller
Code_0734           lbsr      Code_061D ; call the referenced helper routine
                    bcs       Code_06CE ; branch when carry reports an unsigned underflow or error
Code_0739           lbra      Code_24D2 ; continue at the distant control-flow target
                    fcb       $86,$01,$16,$FD,$1B,$86 ; table, bitmap, or initialized data bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "4P"                           ; embedded text or resource bytes
                    fcb       $8D,$F7   ; table, bitmap, or initialized data bytes
                    fcc       "5P"                           ; embedded text or resource bytes
                    fcb       $AF,$C9,$00,$08,$96 ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "I9"                           ; embedded text or resource bytes
Code_0752           tst       Data_0052 ; set condition flags from the current value
                    beq       Code_075A ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
Code_075A           rts                 ; return to the caller
Code_075B           tst       Data_0052 ; set condition flags from the current value
                    beq       Code_0763 ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $16       ; private DeskMate service selector
Code_0763           rts                 ; return to the caller
Code_0764           ldy       Data_00B3 ; load the value needed by the following operation
                    ldu       Data_00B1 ; load the value needed by the following operation
                    ldx       #Data_3700 ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_076D           bsr       Code_0752 ; call the referenced helper routine
                    bsr       Code_0773 ; call the referenced helper routine
                    bra       Code_075B ; continue at the selected control-flow target
Code_0773           bsr       Code_0764 ; call the referenced helper routine
                    bra       Code_0781 ; continue at the selected control-flow target
Code_0777           bsr       Code_0752 ; call the referenced helper routine
                    bsr       Code_077D ; call the referenced helper routine
                    bra       Code_075B ; continue at the selected control-flow target
Code_077D           bsr       Code_0764 ; call the referenced helper routine
                    exg       U,Y       ; exchange the two register values
Code_0781           ldd       ,Y++      ; fetch the next value and advance the source pointer
                    std       ,U++      ; store the value and advance the destination pointer
                    leax      -$02,X    ; form the referenced address without reading memory
                    bne       Code_0781 ; branch when the compared values differ
                    rts                 ; return to the caller
                    fcb       $8D,$C6,$8D,$D6,$A6,$A4 ; table, bitmap, or initialized data bytes
                    fcb       $E6,$C4,$A7,$C0,$E7,$A0 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $1F,$26,$F4 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $BF,$8D,$26,$17 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $D6,$1E,$12,$8D ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $1E,$12,$26,$F5 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $B0       ; table, bitmap, or initialized data bytes
Code_07AB           bsr       Code_07C4 ; call the referenced helper routine
Code_07AD           ldy       Data_00B3 ; load the value needed by the following operation
                    lbsr      Code_287A ; call the referenced helper routine
                    bsr       Code_07CD ; call the referenced helper routine
                    bne       Code_07AD ; branch when the compared values differ
                    bra       Code_075B ; continue at the selected control-flow target
Code_07B9           bsr       Code_07C4 ; call the referenced helper routine
Code_07BB           lbsr      Code_2877 ; call the referenced helper routine
                    bsr       Code_07CD ; call the referenced helper routine
                    bne       Code_07BB ; branch when the compared values differ
                    bra       Code_075B ; continue at the selected control-flow target
Code_07C4           ldx       Data_0067 ; load the value needed by the following operation
                    clra                ; clear the selected byte or register
                    ldb       #$26      ; load the value needed by the following operation
                    std       Data_003F ; save the current value in working storage
                    bra       Code_0752 ; continue at the selected control-flow target
Code_07CD           ldb       #$14      ; load the value needed by the following operation
                    bsr       Code_07D8 ; call the referenced helper routine
                    inc       Data_003F ; advance the selected counter
                    ldb       Data_003F ; load the value needed by the following operation
                    cmpb      #$45      ; compare against the limit and set condition flags
                    rts                 ; return to the caller
Code_07D8           lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,Y+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bne       Code_07D8 ; branch when the compared values differ
                    rts                 ; return to the caller
Code_07E0           sta       ,Y+       ; store the value and advance the destination pointer
Code_07E2           lda       ,X+       ; fetch the next value and advance the source pointer
                    beq       Code_07EA ; branch when the compared values are equal
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    bne       Code_07E0 ; branch when the compared values differ
Code_07EA           rts                 ; return to the caller
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $06,$96   ; table, bitmap, or initialized data bytes
                    fcc       "= "                           ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $06,$96   ; table, bitmap, or initialized data bytes
                    fcc       ">"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       ",5"                           ; embedded text or resource bytes
                    fcb       $86,$00,$00,$00,$06 ; table, bitmap, or initialized data bytes
                    fcc       "Disk drive error"             ; embedded text or resource bytes
                    fcb       $00,$00,$00,$00,$06 ; table, bitmap, or initialized data bytes
                    fcc       "Disk full error"              ; embedded text or resource bytes
                    fcb       $00,$00,$01 ; table, bitmap, or initialized data bytes
                    neg       Addr_0001 ; form the two's-complement negative value
                    comb                ; invert every bit in the selected value
                    fcb       $61       ; table, bitmap, or initialized data bytes
                    ror       Addr_6520 ; rotate right through carry
                    lsr       $01,S     ; shift right and expose the low bit through carry
                    lsr       Addr_6120 ; shift right and expose the low bit through carry
                    clr       $0E,S     ; clear the selected byte or register
                    bra       Code_0895 ; continue at the selected control-flow target
                    fcc       "nother disk!"                 ; embedded text or resource bytes
                    fcb       $00,$00,$00,$00,$01 ; table, bitmap, or initialized data bytes
                    fcc       "save?"                        ; embedded text or resource bytes
                    fcb       $00,$00,$00,$00,$0C ; table, bitmap, or initialized data bytes
                    fcc       "yes"                          ; embedded text or resource bytes
                    fcb       $00,$00,$00,$00,$13 ; table, bitmap, or initialized data bytes
                    fcc       "no"                           ; embedded text or resource bytes
                    fcb       $00,$00,$01,$00,$01 ; table, bitmap, or initialized data bytes
Data_085E           fcc       "filename:   "                 ; embedded text or resource bytes
                    fcb       $00,$00,$00,$00,$08 ; table, bitmap, or initialized data bytes
                    fcc       "Device error"                 ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_087C           fcb       $07,$F9,$08,$0E,$08,$22 ; table, bitmap, or initialized data bytes
                    fcb       $08       ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $08       ; table, bitmap, or initialized data bytes
                    fcc       "K"                            ; embedded text or resource bytes
                    fcb       $08       ; table, bitmap, or initialized data bytes
                    fcc       "S"                            ; embedded text or resource bytes
                    fcb       $08       ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $08       ; table, bitmap, or initialized data bytes
                    fcc       "k"                            ; embedded text or resource bytes
Data_088C           fcb       $00,$00,$1B,$17,$12,$0D ; table, bitmap, or initialized data bytes
Data_0892           fcb       $00,$00,$1B ; table, bitmap, or initialized data bytes
Code_0895           coma                ; invert every bit in the selected value
                    neg       Addr_00FF ; form the two's-complement negative value
Code_0898           exg       X,DP      ; exchange the two register values
                    sync                ; wait for an interrupt request
                    tst       Addr_000D ; set condition flags from the current value
                    tst       Data_0028 ; set condition flags from the current value
                    tst       Addr_0004 ; set condition flags from the current value
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    lsr       DeskMateService ; shift right and expose the low bit through carry
                    stu       Code_3800 ; save the current value in working storage
                    neg       Addr_0002 ; form the two's-complement negative value
                    jmp       Addr_0002 ; dispatch control through the selected target
                    fcb       $00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       " dot matrix"                  ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       " color ink jet"               ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_08C9           fcb       $07,$07,$00,$07,$07,$00 ; table, bitmap, or initialized data bytes
                    fcb       $06,$03,$07,$02,$02,$05 ; table, bitmap, or initialized data bytes
                    fcb       $02,$00,$06,$01,$05,$00 ; table, bitmap, or initialized data bytes
                    fcb       $03,$01,$04,$01,$06,$06 ; table, bitmap, or initialized data bytes
                    fcb       $04,$06,$02,$02,$07,$05 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00   ; table, bitmap, or initialized data bytes
Code_08E9           pshs      A         ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "N"                            ; embedded text or resource bytes
                    lda       $0C,Y     ; load the value needed by the following operation
                    sta       Addr_000E ; save the current value in working storage
                    clr       $0C,Y     ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Q"                            ; embedded text or resource bytes
                    bcc       Code_0903 ; branch when carry is clear
                    lda       #$07      ; load the value needed by the following operation
                    lbsr      Code_05A3 ; call the referenced helper routine
                    leas      $03,S     ; form the referenced address without reading memory
                    rts                 ; return to the caller
Code_0903           sta       Addr_0008 ; save the current value in working storage
                    puls      PC,A      ; restore the listed registers from the stack
Code_0907           leax      >Addr_089E,PCR ; form the referenced address without reading memory
                    leay      >Addr_08A6,PCR ; form the referenced address without reading memory
                    leau      Code_26E5,PCR ; form the referenced address without reading memory
                    lbsr      Code_0305 ; call the referenced helper routine
                    cmpb      #$0D      ; compare against the limit and set condition flags
                    beq       Code_091B ; branch when the compared values are equal
                    rts                 ; return to the caller
Code_091B           bsr       Code_08E9 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    lbne      Code_0ABF ; take the distant branch when values differ
                    leax      Data_088C,PCR ; form the referenced address without reading memory
                    ldy       #Addr_0006 ; load the value needed by the following operation
                    lda       Addr_0008 ; load the value needed by the following operation
                    os9       I$Write   ; request the named OS-9 service
                    bcs       Code_0998 ; branch when carry reports an unsigned underflow or error
                    ldb       #$17      ; load the value needed by the following operation
                    stb       Addr_000D ; save the current value in working storage
                    ldx       #Data_009F ; load the value needed by the following operation
Code_0938           pshs      D         ; preserve the listed registers on the stack
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    cmpa      #$05      ; compare against the limit and set condition flags
                    puls      D         ; restore the listed registers from the stack
                    beq       Code_0998 ; branch when the compared values are equal
                    ldy       #DeskMateService ; load the value needed by the following operation
                    ldu       Data_0067 ; load the value needed by the following operation
                    lbsr      Code_0A01 ; call the referenced helper routine
Code_094E           lbsr      Code_0A11 ; call the referenced helper routine
                    lbsr      Code_0A2F ; call the referenced helper routine
                    ora       ,U        ; set the selected flag bits
                    sta       ,U        ; save the current value in working storage
                    orb       $01,U     ; set the selected flag bits
                    stb       $01,U     ; save the current value in working storage
                    leax      -$01,X    ; form the referenced address without reading memory
                    ldb       #$03      ; load the value needed by the following operation
                    bsr       Code_09B7 ; call the referenced helper routine
                    ldb       #$07      ; load the value needed by the following operation
                    bsr       Code_09D4 ; call the referenced helper routine
                    ldb       #$02      ; load the value needed by the following operation
                    bsr       Code_09B7 ; call the referenced helper routine
                    ldb       #$06      ; load the value needed by the following operation
                    bsr       Code_09D4 ; call the referenced helper routine
                    ldb       #$01      ; load the value needed by the following operation
                    bsr       Code_09B7 ; call the referenced helper routine
                    ldb       Addr_000D ; load the value needed by the following operation
                    decb                ; decrement the selected counter
                    beq       Code_097D ; branch when the compared values are equal
                    ldb       #$04      ; load the value needed by the following operation
                    bsr       Code_09B7 ; call the referenced helper routine
                    leax      $01,X     ; form the referenced address without reading memory
Code_097D           leax      -$01,X    ; form the referenced address without reading memory
                    leax      $07,X     ; form the referenced address without reading memory
                    leau      $FD40,U   ; form the referenced address without reading memory
                    leay      $01,Y     ; form the referenced address without reading memory
                    cmpy      #Data_00B0 ; compare against the limit and set condition flags
                    bne       Code_094E ; branch when the compared values differ
                    lbsr      Code_0A5F ; call the referenced helper routine
                    bcs       Code_0998 ; branch when carry reports an unsigned underflow or error
                    leax      -$07,X    ; form the referenced address without reading memory
                    dec       Addr_000D ; decrement the selected counter
                    bne       Code_0938 ; branch when the compared values differ
Code_0998           bsr       Code_09A9 ; call the referenced helper routine
Code_099A           lda       Addr_0008 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "R"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "N"                            ; embedded text or resource bytes
                    lda       Addr_000E ; load the value needed by the following operation
                    sta       $0C,Y     ; save the current value in working storage
                    rts                 ; return to the caller
Code_09A9           leax      Code_0898,PCR ; form the referenced address without reading memory
                    ldy       #Addr_0006 ; load the value needed by the following operation
                    lda       Addr_0008 ; load the value needed by the following operation
                    os9       I$Write   ; request the named OS-9 service
                    rts                 ; return to the caller
Code_09B7           stb       Addr_000C ; save the current value in working storage
                    bsr       Code_0A11 ; call the referenced helper routine
                    bsr       Code_0A2F ; call the referenced helper routine
                    pshs      B         ; preserve the listed registers on the stack
                    ldb       Addr_000C ; load the value needed by the following operation
                    bsr       Code_0A3A ; call the referenced helper routine
                    orb       ,U        ; set the selected flag bits
                    stb       ,U        ; save the current value in working storage
                    puls      A         ; restore the listed registers from the stack
                    ldb       Addr_000C ; load the value needed by the following operation
                    bsr       Code_0A3A ; call the referenced helper routine
                    orb       $01,U     ; set the selected flag bits
                    stb       $01,U     ; save the current value in working storage
                    leax      -$01,X    ; form the referenced address without reading memory
                    rts                 ; return to the caller
Code_09D4           stb       Addr_000C ; save the current value in working storage
                    bsr       Code_0A11 ; call the referenced helper routine
                    bsr       Code_0A2F ; call the referenced helper routine
                    pshs      B         ; preserve the listed registers on the stack
                    ldb       Addr_000C ; load the value needed by the following operation
                    bsr       Code_0A3A ; call the referenced helper routine
                    orb       ,U        ; set the selected flag bits
                    stb       ,U        ; save the current value in working storage
                    leau      $0161,U   ; form the referenced address without reading memory
                    ora       ,U        ; set the selected flag bits
                    sta       ,U        ; save the current value in working storage
                    puls      A         ; restore the listed registers from the stack
                    ldb       Addr_000C ; load the value needed by the following operation
                    bsr       Code_0A3A ; call the referenced helper routine
                    orb       $FEA0,U   ; set the selected flag bits
                    stb       $FEA0,U   ; save the current value in working storage
                    ora       $01,U     ; set the selected flag bits
                    sta       $01,U     ; save the current value in working storage
                    leax      -$01,X    ; form the referenced address without reading memory
                    rts                 ; return to the caller
Code_0A01           pshs      U,Y,X,D   ; preserve the listed registers on the stack
                    ldd       #Addr_8080 ; load the value needed by the following operation
                    ldx       #Code_0211 ; load the value needed by the following operation
Code_0A09           std       ,U++      ; store the value and advance the destination pointer
                    leax      -$01,X    ; form the referenced address without reading memory
                    bne       Code_0A09 ; branch when the compared values differ
                    puls      PC,U,Y,X,D ; restore the listed registers from the stack
Code_0A11           pshs      U,Y,X,B   ; preserve the listed registers on the stack
                    tfr       Y,D       ; copy the source register into the destination register
                    lda       #$50      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    ldu       Data_00B3 ; load the value needed by the following operation
                    leau      D,U       ; form the referenced address without reading memory
                    tfr       X,D       ; copy the source register into the destination register
                    lsrb                ; shift right and expose the low bit through carry
                    pshs      CC        ; preserve the listed registers on the stack
                    lda       D,U       ; load the value needed by the following operation
                    puls      CC        ; restore the listed registers from the stack
                    bcs       Code_0A2B ; branch when carry reports an unsigned underflow or error
                    lsra                ; shift right and expose the low bit through carry
                    lsra                ; shift right and expose the low bit through carry
                    lsra                ; shift right and expose the low bit through carry
                    lsra                ; shift right and expose the low bit through carry
Code_0A2B           anda      #$0F      ; mask off unwanted bits
                    puls      PC,U,Y,X,B ; restore the listed registers from the stack
Code_0A2F           pshs      U,Y,X     ; preserve the listed registers on the stack
                    leau      Data_08C9,PCR ; form the referenced address without reading memory
                    asla                ; shift left and update carry
                    ldd       A,U       ; load the value needed by the following operation
                    puls      PC,U,Y,X  ; restore the listed registers from the stack
Code_0A3A           pshs      U,Y,X     ; preserve the listed registers on the stack
                    cmpb      #$05      ; compare against the limit and set condition flags
                    bhi       Code_0A49 ; branch when the unsigned value is above the limit
                    exg       A,B       ; exchange the two register values
Code_0A42           aslb                ; shift left and update carry
                    deca                ; decrement the selected counter
                    bne       Code_0A42 ; branch when the compared values differ
                    clra                ; clear the selected byte or register
                    puls      PC,U,Y,X  ; restore the listed registers from the stack
Code_0A49           pshs      A         ; preserve the listed registers on the stack
                    subb      #$05      ; subtract the operand from the running value
                    clra                ; clear the selected byte or register
                    tfr       D,X       ; copy the source register into the destination register
                    puls      A         ; restore the listed registers from the stack
                    ldb       #$05      ; load the value needed by the following operation
                    bsr       Code_0A3A ; call the referenced helper routine
Code_0A56           aslb                ; shift left and update carry
                    rola                ; rotate left through carry
                    leax      -$01,X    ; form the referenced address without reading memory
                    bne       Code_0A56 ; branch when the compared values differ
                    lsrb                ; shift right and expose the low bit through carry
                    puls      PC,U,Y,X  ; restore the listed registers from the stack
Code_0A5F           pshs      U,Y,X,A   ; preserve the listed registers on the stack
                    ldx       Data_0067 ; load the value needed by the following operation
                    lda       #$0D      ; load the value needed by the following operation
                    sta       $0160,X   ; save the current value in working storage
                    sta       $02C1,X   ; save the current value in working storage
                    sta       $0422,X   ; save the current value in working storage
                    ldy       #Addr_0423 ; load the value needed by the following operation
                    lda       Addr_0008 ; load the value needed by the following operation
                    os9       I$Write   ; request the named OS-9 service
                    puls      PC,U,Y,X,A ; restore the listed registers from the stack
Data_0A7C           fcb       $01,$01,$02,$01,$03,$02 ; table, bitmap, or initialized data bytes
                    fcb       $04,$02,$04,$03 ; table, bitmap, or initialized data bytes
Data_0A86           fcc       "("                            ; embedded text or resource bytes
                    fcb       $10,$09,$09,$09,$00,$FF ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
Data_0A8E           fcb       $00,$00,$05,$07,$05,$00 ; table, bitmap, or initialized data bytes
                    fcb       $02,$00   ; table, bitmap, or initialized data bytes
                    fcc       " 1 x 1"                       ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       " 2 x 1"                       ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       " 3 x 2"                       ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       " 4 x 2"                       ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       " 4 x 3"                       ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_0AB9           fcc       " size"                        ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_0ABF           leax      >Data_0A86,PCR ; form the referenced address without reading memory
                    leay      >Data_0A8E,PCR ; form the referenced address without reading memory
                    leau      Code_26E9,PCR ; form the referenced address without reading memory
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    clra                ; clear the selected byte or register
                    leax      >Data_0AB9,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    lbsr      Code_0317 ;0AD9: 17 F8 3B       '.. ; call the referenced helper routine
                    cmpb      #$0D      ; compare against the limit and set condition flags
                    beq       Code_0AE1 ; branch when the compared values are equal
                    rts                 ; return to the caller
Code_0AE1           asla                ; shift left and update carry
                    leax      >Data_0A7C,PCR ; form the referenced address without reading memory
                    ldd       A,X       ; load the value needed by the following operation
                    std       Addr_0009 ; save the current value in working storage
                    ldb       #$3C      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    addd      #Addr_0003 ; add the operand to the running value
                    std       Addr_0002 ; save the current value in working storage
                    ldd       Data_00B3 ; load the value needed by the following operation
                    std       Addr_0006 ; save the current value in working storage
                    lda       #$B0      ; load the value needed by the following operation
                    sta       Addr_0005 ; save the current value in working storage
                    ldd       #Data_00A0 ; load the value needed by the following operation
                    std       DeskMateService ; save the current value in working storage
                    clr       Addr_0004 ; clear the selected byte or register
                    lda       Addr_0008 ; load the value needed by the following operation
                    leax      Data_0892,PCR ; form the referenced address without reading memory
                    ldy       #Addr_0006 ; load the value needed by the following operation
                    os9       I$Write   ; request the named OS-9 service
                    lbcs      Code_099A ; take the distant branch when carry reports an error
Code_0B12           clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    cmpa      #$05      ; compare against the limit and set condition flags
                    beq       Code_0B2C ; branch when the compared values are equal
                    bsr       Code_0B4E ; call the referenced helper routine
                    lda       Addr_000A ; load the value needed by the following operation
Code_0B1F           bsr       Code_0B3E ; call the referenced helper routine
                    lbcs      Code_0998 ; take the distant branch when carry reports an error
                    deca                ; decrement the selected counter
                    bne       Code_0B1F ; branch when the compared values differ
                    dec       Addr_0005 ; decrement the selected counter
                    bne       Code_0B12 ; branch when the compared values differ
Code_0B2C           leax      Code_0898,PCR ; form the referenced address without reading memory
                    leax      $05,X     ; form the referenced address without reading memory
                    ldy       #Addr_0001 ; load the value needed by the following operation
                    lda       Addr_0008 ; load the value needed by the following operation
                    os9       I$Write   ; request the named OS-9 service
                    lbra      Code_099A ; continue at the distant control-flow target
Code_0B3E           pshs      A         ; preserve the listed registers on the stack
                    ldx       Addr_000C ; load the value needed by the following operation
                    leax      $02,X     ; form the referenced address without reading memory
                    ldy       Addr_0002 ; load the value needed by the following operation
                    lda       Addr_0008 ; load the value needed by the following operation
                    os9       I$Write   ; request the named OS-9 service
                    puls      PC,A      ; restore the listed registers from the stack
Code_0B4E           ldy       Addr_0006 ; load the value needed by the following operation
                    ldx       Data_0067 ; load the value needed by the following operation
                    tfr       X,D       ; copy the source register into the destination register
                    addd      DeskMateService ; add the operand to the running value
                    std       Addr_000C ; save the current value in working storage
Code_0B59           ldb       #$02      ; load the value needed by the following operation
                    addb      Addr_0004 ; add the operand to the running value
                    lda       ,Y+       ; fetch the next value and advance the source pointer
Code_0B5F           clr       ,X        ; clear the selected byte or register
                    tst       Addr_0004 ; set condition flags from the current value
                    bne       Code_0B6B ; branch when the compared values differ
                    asla                ; shift left and update carry
                    rol       ,X        ; rotate left through carry
                    asla                ; shift left and update carry
                    rol       ,X        ; rotate left through carry
Code_0B6B           asla                ; shift left and update carry
                    rol       ,X        ; rotate left through carry
                    asla                ; shift left and update carry
                    rol       ,X+       ; rotate left through carry
                    cmpx      Addr_000C ; compare against the limit and set condition flags
                    bcc       Code_0B7A ; branch when carry is clear
                    decb                ; decrement the selected counter
                    bne       Code_0B5F ; branch when the compared values differ
                    bra       Code_0B59 ; continue at the selected control-flow target
Code_0B7A           sty       Addr_0006 ; save the current value in working storage
                    ldx       Data_0067 ; load the value needed by the following operation
                    ldy       Data_00A2 ; load the value needed by the following operation
                    leay      $0EBE,Y   ; form the referenced address without reading memory
Code_0B86           lda       ,X        ; load the value needed by the following operation
                    lda       A,Y       ; load the value needed by the following operation
                    lsra                ; shift right and expose the low bit through carry
                    lsra                ; shift right and expose the low bit through carry
                    lsra                ; shift right and expose the low bit through carry
                    sta       ,X+       ; store the value and advance the destination pointer
                    cmpx      Addr_000C ; compare against the limit and set condition flags
                    bne       Code_0B86 ; branch when the compared values differ
                    leax      $02,X     ; form the referenced address without reading memory
                    ldd       #Data_1B43 ; load the value needed by the following operation
                    std       ,X++      ; store the value and advance the destination pointer
                    lda       #$14      ; load the value needed by the following operation
                    ldb       Addr_0009 ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    stb       ,X+       ; store the value and advance the destination pointer
                    leax      B,X       ; form the referenced address without reading memory
                    ldu       Data_0067 ; load the value needed by the following operation
                    ldy       #Addr_0008 ; load the value needed by the following operation
Code_0BA9           lda       Addr_0009 ; load the value needed by the following operation
                    sta       Addr_000B ; save the current value in working storage
Code_0BAD           lda       ,U        ; load the value needed by the following operation
                    lsra                ; shift right and expose the low bit through carry
                    rol       B,X       ; rotate left through carry
                    lsra                ; shift right and expose the low bit through carry
                    rol       ,X        ; rotate left through carry
                    negb                ; form the two's-complement negative value
                    lsra                ; shift right and expose the low bit through carry
                    rol       B,X       ; rotate left through carry
                    negb                ; form the two's-complement negative value
                    leay      -$01,Y    ; form the referenced address without reading memory
                    bne       Code_0BC2 ; branch when the compared values differ
                    leay      $08,Y     ; form the referenced address without reading memory
                    leax      $01,X     ; form the referenced address without reading memory
Code_0BC2           dec       Addr_000B ; decrement the selected counter
                    bne       Code_0BAD ; branch when the compared values differ
                    leau      $01,U     ; form the referenced address without reading memory
                    cmpu      Addr_000C ; compare against the limit and set condition flags
                    bne       Code_0BA9 ; branch when the compared values differ
                    rts                 ; return to the caller
Code_0BCE           pshs      U,Y,X,DP,D ; preserve the listed registers on the stack
                    bsr       Code_0C40 ; call the referenced helper routine
                    lda       ,S        ; load the value needed by the following operation
                    sta       Addr_0013 ; save the current value in working storage
                    leay      $0A,U     ; form the referenced address without reading memory
                    ldb       #$07      ; load the value needed by the following operation
Code_0BDA           lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,Y+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bgt       Code_0BDA ; branch when the signed value is above the limit
                    clr       Addr_0018 ; clear the selected byte or register
                    clr       Addr_0019 ; clear the selected byte or register
                    clr       Addr_0015 ; clear the selected byte or register
                    clr       Data_001A ; clear the selected byte or register
                    ldb       Addr_000E ; load the value needed by the following operation
                    cmpb      Addr_000C ; compare against the limit and set condition flags
                    bls       Code_0BF7 ; branch when the unsigned value is at or below the limit
                    com       Addr_0015 ; invert every bit in the selected value
                    dec       Addr_000C ; decrement the selected counter
                    dec       Addr_000C ; decrement the selected counter
                    inc       Addr_0010 ; advance the selected counter
Code_0BF7           clr       Addr_0011 ; clear the selected byte or register
                    clr       Code_0017 ; clear the selected byte or register
                    lda       Addr_0013 ; load the value needed by the following operation
                    suba      Addr_000C ; subtract the operand from the running value
                    bcs       Code_0C06 ; branch when carry reports an unsigned underflow or error
                    inca                ; advance the selected counter
                    sta       Addr_0011 ; save the current value in working storage
                    sta       Code_0017 ; save the current value in working storage
Code_0C06           ldb       Addr_0013 ; load the value needed by the following operation
                    subb      Addr_0011 ; subtract the operand from the running value
                    addb      Addr_0010 ; add the operand to the running value
                    stb       start     ; save the current value in working storage
                    ldb       Addr_000E ; load the value needed by the following operation
                    subb      Addr_000C ; subtract the operand from the running value
                    stb       Addr_0012 ; save the current value in working storage
                    lda       Addr_0010 ; load the value needed by the following operation
                    adda      Addr_000C ; add the operand to the running value
                    deca                ; decrement the selected counter
                    sta       Data_001D ; save the current value in working storage
                    clr       Addr_0016 ; clear the selected byte or register
Code_0C1D           ldb       Addr_0010 ; load the value needed by the following operation
                    addb      Addr_0016 ; add the operand to the running value
                    bsr       Code_0C4D ; call the referenced helper routine
                    lda       Code_0017 ; load the value needed by the following operation
                    lbsr      Code_0C59 ; call the referenced helper routine
                    inc       Addr_0016 ; advance the selected counter
                    lda       Addr_0016 ; load the value needed by the following operation
                    cmpa      Addr_000C ; compare against the limit and set condition flags
                    beq       Code_0C38 ; branch when the compared values are equal
                    inc       Code_0017 ; advance the selected counter
                    lda       Code_0017 ; load the value needed by the following operation
                    cmpa      Addr_000E ; compare against the limit and set condition flags
                    bne       Code_0C1D ; branch when the compared values differ
Code_0C38           lbsr      Code_0C68 ; call the referenced helper routine
                    lbsr      Code_0C76 ; call the referenced helper routine
                    puls      PC,U,Y,X,DP,D ; restore the listed registers from the stack
Code_0C40           pshs      D         ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "/"                            ; embedded text or resource bytes
                    tfr       A,DP      ; copy the source register into the destination register
                    clrb                ; clear the selected byte or register
                    tfr       D,U       ; copy the source register into the destination register
                    puls      PC,D      ; restore the listed registers from the stack
Code_0C4D           clra                ; clear the selected byte or register
                    tfr       D,Y       ; copy the source register into the destination register
                    ldb       Addr_000F ; load the value needed by the following operation
                    tfr       D,X       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_0C59           ldx       Addr_000A ; load the value needed by the following operation
                    asla                ; shift left and update carry
                    ldx       A,X       ; load the value needed by the following operation
                    clra                ; clear the selected byte or register
                    ldb       ,X+       ; fetch the next value and advance the source pointer
                    andb      #$80      ; mask off unwanted bits
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_0C68           ldb       start     ; load the value needed by the following operation
                    bsr       Code_0C4D ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    ldb       Addr_000D ; load the value needed by the following operation
                    tfr       D,Y       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "$"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_0C76           tst       Addr_0015 ; set condition flags from the current value
                    beq       Code_0CB0 ; branch when the compared values are equal
                    ldb       Addr_0010 ; load the value needed by the following operation
                    decb                ; decrement the selected counter
                    bsr       Code_0CB1 ; call the referenced helper routine
                    tst       Addr_0011 ; set condition flags from the current value
                    beq       Code_0C91 ; branch when the compared values are equal
                    leax      Data_100C,PCR ; form the referenced address without reading memory
                    tst       Addr_0018 ; set condition flags from the current value
                    beq       Code_0C8D ; branch when the compared values are equal
                    leax      $03,X     ; form the referenced address without reading memory
Code_0C8D           bsr       Code_0CC1 ; call the referenced helper routine
                    bra       Code_0C95 ; continue at the selected control-flow target
Code_0C91           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "A"                            ; embedded text or resource bytes
Code_0C95           ldb       Data_001D ; load the value needed by the following operation
                    incb                ; advance the selected counter
                    bsr       Code_0CB1 ; call the referenced helper routine
                    ldb       Addr_0011 ; load the value needed by the following operation
                    cmpb      Addr_0012 ; compare against the limit and set condition flags
                    beq       Code_0CAC ; branch when the compared values are equal
                    leax      Data_1012,PCR ; form the referenced address without reading memory
                    tst       Addr_0019 ; set condition flags from the current value
                    beq       Code_0CAA ; branch when the compared values are equal
                    leax      $03,X     ; form the referenced address without reading memory
Code_0CAA           bra       Code_0CC1 ; continue at the selected control-flow target
Code_0CAC           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "A"                            ; embedded text or resource bytes
Code_0CB0           rts                 ; return to the caller
Code_0CB1           clra                ; clear the selected byte or register
                    tfr       D,Y       ; copy the source register into the destination register
                    ldb       Addr_000D ; load the value needed by the following operation
                    lsrb                ; shift right and expose the low bit through carry
                    addb      Addr_000F ; add the operand to the running value
                    decb                ; decrement the selected counter
                    tfr       D,X       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_0CC1           pshs      X         ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1F       ; private DeskMate service selector
                    pshs      Y         ; preserve the listed registers on the stack
                    leax      Data_0F8C,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $06       ; private DeskMate service selector
                    ldx       $02,S     ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
                    puls      Y,X       ; restore the listed registers from the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $03       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_0CDE           pshs      U,Y,X,DP,D ; preserve the listed registers on the stack
                    lbsr      Code_0C40 ; call the referenced helper routine
                    clr       Addr_0018 ; clear the selected byte or register
                    clr       Addr_0019 ; clear the selected byte or register
                    clr       Data_0033 ; clear the selected byte or register
                    ldb       #$80      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    sta       Data_001C ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $18       ; private DeskMate service selector
                    tstb                ; set condition flags from the current value
                    lbeq      Code_0D43 ; take the distant branch when values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "E"                            ; embedded text or resource bytes
                    stb       Data_0033 ; save the current value in working storage
                    stx       Data_0034 ; save the current value in working storage
                    sty       Data_0036 ; save the current value in working storage
                    cmpb      #$01      ; compare against the limit and set condition flags
                    bne       Code_0D15 ; branch when the compared values differ
                    lda       #$0D      ; load the value needed by the following operation
                    cmpy      #Addr_00FF ; compare against the limit and set condition flags
                    bne       Code_0D13 ; branch when the compared values differ
                    lda       #$05      ; load the value needed by the following operation
Code_0D13           sta       Data_001C ; save the current value in working storage
Code_0D15           tfr       Y,D       ; copy the source register into the destination register
                    cmpb      #$FF      ; compare against the limit and set condition flags
                    beq       Code_0D43 ; branch when the compared values are equal
                    stb       Data_001B ; save the current value in working storage
                    cmpb      Addr_0010 ; compare against the limit and set condition flags
                    bcs       Code_0D80 ; branch when carry reports an unsigned underflow or error
                    cmpb      Data_001D ; compare against the limit and set condition flags
                    bhi       Code_0D80 ; branch when the unsigned value is above the limit
                    cmpb      start     ; compare against the limit and set condition flags
                    beq       Code_0D78 ; branch when the compared values are equal
Code_0D29           subb      Addr_0010 ; subtract the operand from the running value
                    addb      Addr_0011 ; add the operand to the running value
                    cmpb      Addr_000E ; compare against the limit and set condition flags
                    bcc       Code_0D78 ; branch when carry is clear
                    pshs      B         ; preserve the listed registers on the stack
                    lbsr      Code_0C68 ; call the referenced helper routine
                    lda       ,S+       ; load the value needed by the following operation
                    ldb       Data_001B ; load the value needed by the following operation
                    stb       start     ; save the current value in working storage
                    sta       Addr_0013 ; save the current value in working storage
                    lbsr      Code_0C68 ; call the referenced helper routine
                    bra       Code_0D75 ; continue at the selected control-flow target
Code_0D43           lda       Data_001C ; load the value needed by the following operation
                    cmpa      #$0C      ; compare against the limit and set condition flags
                    beq       Code_0D55 ; branch when the compared values are equal
                    cmpa      #$0A      ; compare against the limit and set condition flags
                    beq       Code_0D63 ; branch when the compared values are equal
                    tst       Data_001A ; set condition flags from the current value
                    beq       Code_0D78 ; branch when the compared values are equal
                    clr       Data_001A ; clear the selected byte or register
                    bra       Code_0D75 ; continue at the selected control-flow target
Code_0D55           ldb       start     ; load the value needed by the following operation
                    cmpb      Addr_0010 ; compare against the limit and set condition flags
                    lbeq      Code_0DBB ; take the distant branch when values are equal
                    decb                ; decrement the selected counter
                    stb       Data_001B ; save the current value in working storage
                    lbra      Code_0D29 ; continue at the distant control-flow target
Code_0D63           ldb       start     ; load the value needed by the following operation
                    cmpb      Data_001D ; compare against the limit and set condition flags
                    lbeq      Code_0D89 ; take the distant branch when values are equal
                    incb                ; advance the selected counter
                    stb       Data_001B ; save the current value in working storage
                    lbra      Code_0D29 ; continue at the distant control-flow target
Code_0D71           lda       #$FF      ; load the value needed by the following operation
                    sta       Data_001A ; save the current value in working storage
Code_0D75           lbsr      Code_0C76 ; call the referenced helper routine
Code_0D78           ldb       Data_001C ; load the value needed by the following operation
                    lda       Addr_0013 ; load the value needed by the following operation
                    leas      $02,S     ; form the referenced address without reading memory
                    puls      PC,U,Y,X,DP ; restore the listed registers from the stack
Code_0D80           lda       Data_001D ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    cmpa      Data_001B ; compare against the limit and set condition flags
                    bne       Code_0DB2 ; branch when the compared values differ
                    inc       Addr_0019 ; advance the selected counter
Code_0D89           ldb       Addr_0011 ; load the value needed by the following operation
                    cmpb      Addr_0012 ; compare against the limit and set condition flags
                    beq       Code_0D78 ; branch when the compared values are equal
                    inc       Addr_0011 ; advance the selected counter
                    lbsr      Code_0C68 ; call the referenced helper routine
                    inc       Addr_0013 ; advance the selected counter
                    bsr       Code_0DDF ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $26       ; private DeskMate service selector
                    ldb       Data_001D ; load the value needed by the following operation
                    lbsr      Code_0C4D ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "A"                            ; embedded text or resource bytes
                    lda       Addr_0011 ; load the value needed by the following operation
                    adda      Addr_000C ; add the operand to the running value
                    deca                ; decrement the selected counter
                    lbsr      Code_0C59 ; call the referenced helper routine
                    lbsr      Code_0C68 ; call the referenced helper routine
                    bra       Code_0D71 ; continue at the selected control-flow target
Code_0DB2           lda       Addr_0010 ; load the value needed by the following operation
                    deca                ; decrement the selected counter
                    cmpa      Data_001B ; compare against the limit and set condition flags
                    bne       Code_0D75 ; branch when the compared values differ
                    inc       Addr_0018 ; advance the selected counter
Code_0DBB           tst       Addr_0011 ; set condition flags from the current value
                    beq       Code_0D78 ; branch when the compared values are equal
                    lbsr      Code_0C68 ; call the referenced helper routine
                    dec       Addr_0011 ; decrement the selected counter
                    dec       Addr_0013 ; decrement the selected counter
                    bsr       Code_0DDF ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "'"                            ; embedded text or resource bytes
                    ldb       Addr_0010 ; load the value needed by the following operation
                    lbsr      Code_0C4D ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "A"                            ; embedded text or resource bytes
                    lda       Addr_0011 ; load the value needed by the following operation
                    lbsr      Code_0C59 ; call the referenced helper routine
                    lbsr      Code_0C68 ; call the referenced helper routine
                    bra       Code_0D71 ; continue at the selected control-flow target
Code_0DDF           ldb       Addr_0010 ; load the value needed by the following operation
                    lbsr      Code_0C4D ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0C       ; private DeskMate service selector
                    tfr       X,D       ; copy the source register into the destination register
                    pshs      A         ; preserve the listed registers on the stack
                    clra                ; clear the selected byte or register
                    tfr       D,X       ; copy the source register into the destination register
                    puls      B         ; restore the listed registers from the stack
                    tfr       D,Y       ; copy the source register into the destination register
                    ldu       #Code_2000 ; load the value needed by the following operation
                    ldd       Addr_000C ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_0DF9           pshs      U,Y,X,DP,D ; preserve the listed registers on the stack
                    lbsr      Code_0C40 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "9"                            ; embedded text or resource bytes
Code_0E02           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "0"                            ; embedded text or resource bytes
                    sta       Data_0026 ; save the current value in working storage
                    ldd       ,S        ; load the value needed by the following operation
                    stb       Data_001F ; save the current value in working storage
                    tsta                ; set condition flags from the current value
                    bpl       Code_0E30 ; branch while the tested value is nonnegative
                    anda      #$7F      ; mask off unwanted bits
                    sta       Data_0020 ; save the current value in working storage
                    stx       Data_0021 ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "I"                            ; embedded text or resource bytes
                    tfr       Y,D       ; copy the source register into the destination register
                    stb       Data_0023 ; save the current value in working storage
                    tfr       X,D       ; copy the source register into the destination register
                    stb       Data_0024 ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "4"                            ; embedded text or resource bytes
                    clr       Data_001E ; clear the selected byte or register
                    lda       #$FF      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1E       ; private DeskMate service selector
Code_0E2D           lbsr      Code_0F4D ; call the referenced helper routine
Code_0E30           lbsr      Code_0F68 ; call the referenced helper routine
Code_0E33           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $18       ; private DeskMate service selector
                    anda      #$80      ; mask off unwanted bits
                    ora       #$03      ; set the selected flag bits
                    tfr       A,B       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1C       ; private DeskMate service selector
                    tstb                ; set condition flags from the current value
                    bpl       Code_0E48 ; branch while the tested value is nonnegative
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $16       ; private DeskMate service selector
Code_0E48           sta       Data_0025 ; save the current value in working storage
                    ldx       Data_0021 ; load the value needed by the following operation
                    ldb       Data_001F ; load the value needed by the following operation
                    leay      B,X       ; form the referenced address without reading memory
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bcs       Code_0E6C ; branch when carry reports an unsigned underflow or error
                    cmpa      #$7E      ; compare against the limit and set condition flags
                    bhi       Code_0E6C ; branch when the unsigned value is above the limit
                    tst       Data_001E ; set condition flags from the current value
                    lbne      Code_0F2D ; take the distant branch when values differ
Code_0E5E           sta       ,Y        ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "C"                            ; embedded text or resource bytes
Code_0E64           tst       $01,Y     ; set condition flags from the current value
                    beq       Code_0E33 ; branch when the compared values are equal
                    inc       Data_001F ; advance the selected counter
                    bra       Code_0E30 ; continue at the selected control-flow target
Code_0E6C           cmpa      #$88      ; compare against the limit and set condition flags
                    beq       Code_0EBB ; branch when the compared values are equal
                    cmpa      #$08      ; compare against the limit and set condition flags
                    beq       Code_0EE0 ; branch when the compared values are equal
                    cmpa      #$09      ; compare against the limit and set condition flags
                    beq       Code_0E64 ; branch when the compared values are equal
                    cmpa      #$C9      ; compare against the limit and set condition flags
                    lbeq      Code_0F04 ; take the distant branch when values are equal
                    cmpa      #$E9      ; compare against the limit and set condition flags
                    lbeq      Code_0F04 ; take the distant branch when values are equal
                    cmpa      #$0C      ; compare against the limit and set condition flags
                    beq       Code_0EFA ; branch when the compared values are equal
                    cmpa      #$0A      ; compare against the limit and set condition flags
                    beq       Code_0EE8 ; branch when the compared values are equal
                    cmpa      #$8D      ; compare against the limit and set condition flags
                    bne       Code_0EA7 ; branch when the compared values differ
                    lda       #$0D      ; load the value needed by the following operation
                    sta       Data_0025 ; save the current value in working storage
Code_0E94           lda       #$20      ; load the value needed by the following operation
                    sta       ,Y+       ; store the value and advance the destination pointer
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "C"                            ; embedded text or resource bytes
                    tst       ,Y        ; set condition flags from the current value
                    beq       Code_0EA7 ; branch when the compared values are equal
                    inc       Data_001F ; advance the selected counter
                    lbsr      Code_0F68 ; call the referenced helper routine
                    bra       Code_0E94 ; continue at the selected control-flow target
Code_0EA7           ldb       Data_001F ; load the value needed by the following operation
                    lda       Data_0026 ; load the value needed by the following operation
                    beq       Code_0EB1 ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "3"                            ; embedded text or resource bytes
Code_0EB1           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       ":"                            ; embedded text or resource bytes
                    lda       Data_0025 ; load the value needed by the following operation
                    leas      $02,S     ; form the referenced address without reading memory
                    puls      PC,U,Y,X,DP ; restore the listed registers from the stack
Code_0EBB           tst       Data_001E ; set condition flags from the current value
                    bne       Code_0F12 ; branch when the compared values differ
                    tstb                ; set condition flags from the current value
                    beq       Code_0ED5 ; branch when the compared values are equal
                    tst       $01,Y     ; set condition flags from the current value
                    bne       Code_0ECC ; branch when the compared values differ
                    lda       #$20      ; load the value needed by the following operation
                    cmpa      ,Y        ; compare against the limit and set condition flags
                    bne       Code_0ED5 ; branch when the compared values differ
Code_0ECC           dec       Data_001F ; decrement the selected counter
                    lbsr      Code_0F68 ; call the referenced helper routine
                    ldx       Data_0021 ; load the value needed by the following operation
                    ldb       Data_001F ; load the value needed by the following operation
Code_0ED5           lda       #$20      ; load the value needed by the following operation
                    sta       B,X       ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "C"                            ; embedded text or resource bytes
Code_0EDD           lbra      Code_0E33 ; continue at the distant control-flow target
Code_0EE0           tstb                ; set condition flags from the current value
                    beq       Code_0EDD ; branch when the compared values are equal
                    dec       Data_001F ; decrement the selected counter
                    lbra      Code_0E30 ; continue at the distant control-flow target
Code_0EE8           lda       Data_0020 ; load the value needed by the following operation
Code_0EEA           deca                ; decrement the selected counter
                    bmi       Code_0EF5 ; branch while the tested value is negative
                    incb                ; advance the selected counter
                    tst       B,X       ; set condition flags from the current value
                    bne       Code_0EEA ; branch when the compared values differ
Code_0EF2           lbra      Code_0EB1 ; continue at the distant control-flow target
Code_0EF5           stb       Data_001F ; save the current value in working storage
                    lbra      Code_0E30 ; continue at the distant control-flow target
Code_0EFA           lda       Data_0020 ; load the value needed by the following operation
Code_0EFC           deca                ; decrement the selected counter
                    bmi       Code_0EF5 ; branch while the tested value is negative
                    decb                ; decrement the selected counter
                    bmi       Code_0EF2 ; branch while the tested value is negative
                    bra       Code_0EFC ; continue at the selected control-flow target
Code_0F04           lda       #$FF      ; load the value needed by the following operation
                    com       Data_001E ; invert every bit in the selected value
                    beq       Code_0F0C ; branch when the compared values are equal
                    lda       #$01      ; load the value needed by the following operation
Code_0F0C           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1E       ; private DeskMate service selector
                    bra       Code_0EDD ; continue at the selected control-flow target
Code_0F12           tstb                ; set condition flags from the current value
                    bne       Code_0F18 ; branch when the compared values differ
                    incb                ; advance the selected counter
                    stb       Data_001F ; save the current value in working storage
Code_0F18           leax      B,X       ; form the referenced address without reading memory
Code_0F1A           lda       ,X+       ; fetch the next value and advance the source pointer
                    beq       Code_0F22 ; branch when the compared values are equal
                    sta       -$02,X    ; save the current value in working storage
                    bra       Code_0F1A ; continue at the selected control-flow target
Code_0F22           lda       #$20      ; load the value needed by the following operation
                    sta       -$02,X    ; save the current value in working storage
                    dec       Data_001F ; decrement the selected counter
                    bsr       Code_0F68 ; call the referenced helper routine
                    lbra      Code_0E2D ; continue at the distant control-flow target
Code_0F2D           tst       $01,Y     ; set condition flags from the current value
                    lbeq      Code_0E5E ; take the distant branch when values are equal
                    pshs      Y,A       ; preserve the listed registers on the stack
Code_0F35           lda       ,Y+       ; fetch the next value and advance the source pointer
                    bne       Code_0F35 ; branch when the compared values differ
                    leay      -$02,Y    ; form the referenced address without reading memory
Code_0F3B           lda       ,-Y       ; load the value needed by the following operation
                    sta       $01,Y     ; save the current value in working storage
                    cmpy      $01,S     ; compare against the limit and set condition flags
                    bne       Code_0F3B ; branch when the compared values differ
                    puls      X,A       ; restore the listed registers from the stack
                    sta       ,X        ; save the current value in working storage
                    bsr       Code_0F4D ; call the referenced helper routine
                    lbra      Code_0E64 ; continue at the distant control-flow target
Code_0F4D           ldx       Data_0021 ; load the value needed by the following operation
                    ldb       Data_001F ; load the value needed by the following operation
                    pshs      B         ; preserve the listed registers on the stack
                    leax      B,X       ; form the referenced address without reading memory
Code_0F55           bsr       Code_0F68 ; call the referenced helper routine
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    beq       Code_0F63 ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "C"                            ; embedded text or resource bytes
                    inc       Data_001F ; advance the selected counter
                    bra       Code_0F55 ; continue at the selected control-flow target
Code_0F63           puls      B         ; restore the listed registers from the stack
                    stb       Data_001F ; save the current value in working storage
                    rts                 ; return to the caller
Code_0F68           ldb       Data_001F ; load the value needed by the following operation
                    clra                ; clear the selected byte or register
Code_0F6B           inca                ; advance the selected counter
                    subb      Data_0020 ; subtract the operand from the running value
                    bhi       Code_0F6B ; branch when the unsigned value is above the limit
                    beq       Code_0F75 ; branch when the compared values are equal
                    deca                ; decrement the selected counter
                    addb      Data_0020 ; add the operand to the running value
Code_0F75           adda      Data_0023 ; add the operand to the running value
                    addb      Data_0024 ; add the operand to the running value
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
Data_0F8C           fcb       $00,$03,$0C ; table, bitmap, or initialized data bytes
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
Data_100C           fcb       $80,$81,$00,$84,$85,$00 ; table, bitmap, or initialized data bytes
Data_1012           fcb       $82,$83,$00,$86,$87,$00 ; table, bitmap, or initialized data bytes
Data_1018           fcb       $00,$04,$08,$18,$03,$00 ; table, bitmap, or initialized data bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
Data_101F           fcb       $FF       ; table, bitmap, or initialized data bytes
Data_1020           fcb       $07,$05   ; table, bitmap, or initialized data bytes
                    fcc       "  Save as:"                   ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_102D           fcb       $00,$02,$0C,$1C,$07,$00 ; table, bitmap, or initialized data bytes
                    fcb       $AA       ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
Data_1035           fcc       "Use "                         ; embedded text or resource bytes
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
Data_1060           fcc       "Filename must be 1-8"         ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "characters, begin wit"        ; embedded text or resource bytes
                    fcc       "h"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "a-z "                         ; embedded text or resource bytes
                    fcb       $26       ; table, bitmap, or initialized data bytes
                    fcc       " contain a-z or 0-9"          ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_10A5           fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
Code_10B6           pshs      DP        ; preserve the listed registers on the stack
                    pshs      U,Y,X,A   ; preserve the listed registers on the stack
                    lda       $06,Y     ; load the value needed by the following operation
                    sta       Data_101F,PCR ; save the current value in working storage
                    lbsr      Code_0C40 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       ">"                            ; embedded text or resource bytes
                    sta       Data_0029 ; save the current value in working storage
                    clr       Data_002A ; clear the selected byte or register
                    clr       Data_002B ; clear the selected byte or register
                    ldx       ,Y        ; load the value needed by the following operation
                    stx       Data_0027 ; save the current value in working storage
                    leau      >Data_10A5,PCR ; form the referenced address without reading memory
                    stu       ,Y        ; save the current value in working storage
                    lbsr      Code_11D9 ; call the referenced helper routine
                    leax      Data_1018,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    ldx       $01,S     ; load the value needed by the following operation
                    bne       Code_10EA ; branch when the compared values differ
                    leax      Data_1020,PCR ; form the referenced address without reading memory
Code_10EA           clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
Code_10F0           ldx       #Addr_000B ; load the value needed by the following operation
                    leay      -$0B,X    ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    ldy       $03,S     ; load the value needed by the following operation
                    ldx       ,Y        ; load the value needed by the following operation
                    ldd       #Addr_9000 ; load the value needed by the following operation
Code_1101           lbsr      Code_0DF9 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_1111 ; branch when the compared values are equal
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    beq       Code_114D ; branch when the compared values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    beq       Code_1142 ; branch when the compared values are equal
                    bra       Code_113E ; continue at the selected control-flow target
Code_1111           pshs      U,Y,X,D   ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       ">"                            ; embedded text or resource bytes
                    pshs      A         ; preserve the listed registers on the stack
                    tst       Data_101F,PCR ; set condition flags from the current value
                    bne       Code_1123 ; branch when the compared values differ
                    deca                ; decrement the selected counter
                    bpl       Code_1123 ; branch while the tested value is nonnegative
                    inca                ; advance the selected counter
Code_1123           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "="                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "E"                            ; embedded text or resource bytes
                    puls      A         ; restore the listed registers from the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "="                            ; embedded text or resource bytes
                    cmpx      #Addr_00FF ; compare against the limit and set condition flags
                    puls      U,Y,X,D   ; restore the listed registers from the stack
                    bne       Code_114D ; branch when the compared values differ
                    lda       #$05      ; load the value needed by the following operation
                    bra       Code_1142 ; continue at the selected control-flow target
                    fcc       "5v"                           ; embedded text or resource bytes
Code_113E           lda       #$0A      ; load the value needed by the following operation
                    bra       Code_1101 ; continue at the selected control-flow target
Code_1142           ldx       Data_0027 ; load the value needed by the following operation
                    stx       ,Y        ; save the current value in working storage
                    sta       ,S        ; save the current value in working storage
                    clrb                ; clear the selected byte or register
                    puls      U,Y,X,A   ; restore the listed registers from the stack
                    puls      PC,DP     ; restore the listed registers from the stack
Code_114D           lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpa      #$20      ; compare against the limit and set condition flags
                    beq       Code_114D ; branch when the compared values are equal
                    lda       ,X        ; load the value needed by the following operation
                    leax      -$01,X    ; form the referenced address without reading memory
                    cmpa      #$3A      ; compare against the limit and set condition flags
                    bne       Code_1169 ; branch when the compared values differ
                    lda       ,X        ; load the value needed by the following operation
                    suba      #$31      ; subtract the operand from the running value
                    cmpa      #$02      ; compare against the limit and set condition flags
                    bcs       Code_1169 ; branch when carry reports an unsigned underflow or error
                    leax      Data_1035,PCR ; form the referenced address without reading memory
                    bra       Code_117A ; continue at the selected control-flow target
Code_1169           ldx       ,Y        ; load the value needed by the following operation
                    lda       ,S        ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "J"                            ; embedded text or resource bytes
                    andb      #$EF      ; mask off unwanted bits
                    tstb                ; set condition flags from the current value
                    beq       Code_11C5 ; branch when the compared values are equal
                    leax      Data_1060,PCR ; form the referenced address without reading memory
Code_117A           pshs      X         ; preserve the listed registers on the stack
                    ldb       ,X        ; load the value needed by the following operation
                    tst       Data_002A ; set condition flags from the current value
                    bne       Code_118A ; branch when the compared values differ
                    leax      Data_102D,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
Code_118A           lda       Data_0029 ; load the value needed by the following operation
                    adda      #$02      ; add the operand to the running value
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "="                            ; embedded text or resource bytes
                    cmpb      Data_002B ; compare against the limit and set condition flags
                    beq       Code_119C ; branch when the compared values are equal
                    stb       Data_002B ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "?"                            ; embedded text or resource bytes
Code_119C           ldb       #$03      ; load the value needed by the following operation
                    stb       Data_002A ; save the current value in working storage
                    ldy       #Addr_0001 ; load the value needed by the following operation
Code_11A4           clra                ; clear the selected byte or register
                    ldx       #Addr_0001 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    ldx       ,S        ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    stx       ,S        ; save the current value in working storage
                    leay      $01,Y     ; form the referenced address without reading memory
                    decb                ; decrement the selected counter
                    bne       Code_11A4 ; branch when the compared values differ
                    leas      $02,S     ; form the referenced address without reading memory
                    lda       Data_0029 ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "="                            ; embedded text or resource bytes
                    lbra      Code_10F0 ; continue at the distant control-flow target
Code_11C5           lda       Data_0029 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    clr       ,S        ; clear the selected byte or register
                    ldu       Data_0027 ; load the value needed by the following operation
                    ldx       ,Y        ; load the value needed by the following operation
                    stu       ,Y        ; save the current value in working storage
                    bsr       Code_11D9 ; call the referenced helper routine
                    puls      U,Y,X,A   ; restore the listed registers from the stack
                    puls      PC,DP     ; restore the listed registers from the stack
Code_11D9           lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,U+       ; store the value and advance the destination pointer
                    bne       Code_11D9 ; branch when the compared values differ
                    rts                 ; return to the caller
                    fcc       "("                            ; embedded text or resource bytes
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
                    fcb       $06,$17,$ED,$CF,$0F,$C1 ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $26,$04,$1F,$10 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8B       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $06,$17,$ED,$C1 ; table, bitmap, or initialized data bytes
                    fcc       "D"                            ; embedded text or resource bytes
                    fcb       $17,$ED,$BD ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       ":"                            ; embedded text or resource bytes
                    fcb       $17,$ED,$B7 ; table, bitmap, or initialized data bytes
                    fcc       "594H"                         ; embedded text or resource bytes
                    fcb       $17,$F9,$DC ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $E9,$FE,$0C,$10,$DF ; table, bitmap, or initialized data bytes
                    fcc       ",46"                          ; embedded text or resource bytes
                    fcb       $17,$ED,$A4,$16,$0F ; table, bitmap, or initialized data bytes
                    fcc       "1O0"                          ; embedded text or resource bytes
                    fcb       $8D,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "h"                            ; embedded text or resource bytes
                    fcb       $17,$ED,$99 ; table, bitmap, or initialized data bytes
                    fcc       "80"                           ; embedded text or resource bytes
                    fcb       $8D,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "p"                            ; embedded text or resource bytes
                    fcb       $17,$ED,$91 ; table, bitmap, or initialized data bytes
                    fcc       "G"                            ; embedded text or resource bytes
                    fcb       $C6,$0C,$E7,$84,$17,$ED ; table, bitmap, or initialized data bytes
                    fcb       $89       ; table, bitmap, or initialized data bytes
                    fcc       "G"                            ; embedded text or resource bytes
                    fcb       $C6,$02,$E7,$84,$8E,$1F ; table, bitmap, or initialized data bytes
                    fcb       $1A,$10,$8E,$0B,$06,$86 ; table, bitmap, or initialized data bytes
                    fcb       $FF,$17,$ED ; table, bitmap, or initialized data bytes
                    fcc       "x"                            ; embedded text or resource bytes
                    fcb       $0E       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $0A,$17,$ED ; table, bitmap, or initialized data bytes
                    fcc       "r"                            ; embedded text or resource bytes
                    fcb       $0E,$17,$ED ; table, bitmap, or initialized data bytes
                    fcc       "n0"                           ; embedded text or resource bytes
                    fcb       $DD       ; table, bitmap, or initialized data bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $17,$ED   ; table, bitmap, or initialized data bytes
                    fcc       "h3"                           ; embedded text or resource bytes
                    fcb       $17,$ED   ; table, bitmap, or initialized data bytes
                    fcc       "d2"                           ; embedded text or resource bytes
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
                    fcb       $26,$04,$17,$ED ; table, bitmap, or initialized data bytes
                    fcc       "F4]"                          ; embedded text or resource bytes
                    fcb       $26,$04,$17,$ED ; table, bitmap, or initialized data bytes
                    fcc       "?1"                           ; embedded text or resource bytes
                    fcb       $AE       ; table, bitmap, or initialized data bytes
                    fcc       "d"                            ; embedded text or resource bytes
                    fcb       $A6,$94,$80 ; table, bitmap, or initialized data bytes
                    fcc       "0'"                           ; embedded text or resource bytes
                    fcb       $04,$81,$03 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $06,$17,$ED ; table, bitmap, or initialized data bytes
                    fcc       "/N"                           ; embedded text or resource bytes
                    fcb       $A6,$84,$8E,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $04,$17,$ED ; table, bitmap, or initialized data bytes
                    fcc       "$D"                           ; embedded text or resource bytes
                    fcb       $17,$ED   ; table, bitmap, or initialized data bytes
                    fcc       " @"                           ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $17,$01   ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $C6       ; table, bitmap, or initialized data bytes
                    fcc       ")="                           ; embedded text or resource bytes
                    fcb       $17,$ED,$14 ; table, bitmap, or initialized data bytes
                    fcc       "N0"                           ; embedded text or resource bytes
                    fcb       $88,$26   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8B,$DE   ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $10,$AE   ; table, bitmap, or initialized data bytes
                    fcc       "d"                            ; embedded text or resource bytes
                    fcb       $10,$AE,$22,$CC,$01,$F4 ; table, bitmap, or initialized data bytes
                    fcb       $17,$ED,$00 ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $01,$01,$97 ; table, bitmap, or initialized data bytes
                    fcc       "0'1"                          ; embedded text or resource bytes
                    fcb       $1F,$89,$17,$EC,$F2 ; table, bitmap, or initialized data bytes
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
                    fcb       $A7,$04,$17,$EC,$D9,$0F ; table, bitmap, or initialized data bytes
                    fcb       $C1       ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $26,$04,$C6,$06,$E7,$05 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $17,$F8,$86,$C6,$01,$E7 ; table, bitmap, or initialized data bytes
                    fcb       $8D,$FE,$DE,$0D ; table, bitmap, or initialized data bytes
                    fcc       "0'"                           ; embedded text or resource bytes
                    fcb       $05,$17,$F9,$89 ; table, bitmap, or initialized data bytes
                    fcc       " -"                           ; embedded text or resource bytes
                    fcb       $1F,$13,$17,$EC,$B8 ; table, bitmap, or initialized data bytes
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
                    fcb       $17,$EC,$9C,$1D,$17,$EC ; table, bitmap, or initialized data bytes
                    fcb       $98,$16,$1F,$89,$C1,$0D ; table, bitmap, or initialized data bytes
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
                    fcb       $06,$17,$EC ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $18       ; table, bitmap, or initialized data bytes
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
                    andb      -$09,X    ; mask off unwanted bits
                    ldd       $0B,X     ; load the value needed by the following operation
                    deca                ; decrement the selected counter
                    stb       $01,S     ; save the current value in working storage
                    bra       Code_1412 ; continue at the selected control-flow target
                    fcb       $86,$FF,$A7,$E4 ; table, bitmap, or initialized data bytes
Code_1412           puls      Y,X,D     ; restore the listed registers from the stack
                    leas      $01F4,S   ; form the referenced address without reading memory
                    puls      PC,U,DP   ; restore the listed registers from the stack
                    fcb       $E7       ; table, bitmap, or initialized data bytes
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
                    fcb       $EB,$DB,$13 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $09,$E7,$84,$17,$EB,$D3 ; table, bitmap, or initialized data bytes
                    fcb       $13       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $16,$97   ; table, bitmap, or initialized data bytes
                    fcc       "19("                          ; embedded text or resource bytes
                    fcb       $01,$09,$0C,$04,$00,$FF ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
                    fcb       $00,$00,$02,$0A,$02,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "o4P0"                         ; embedded text or resource bytes
                    fcb       $8D,$FF,$E9 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $8D,$FF,$ED ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $8D,$12   ; table, bitmap, or initialized data bytes
                    fcc       "{"                            ; embedded text or resource bytes
                    fcb       $17,$EE,$9C ; table, bitmap, or initialized data bytes
                    fcc       "5P"                           ; embedded text or resource bytes
                    fcb       $C1,$05,$26,$09,$AF,$C9 ; table, bitmap, or initialized data bytes
                    fcb       $00,$08,$96 ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "I9"                           ; embedded text or resource bytes
                    fcb       $0F,$9B   ; table, bitmap, or initialized data bytes
                    fcc       "M'"                           ; embedded text or resource bytes
                    fcb       $08,$96,$A1,$81,$0F ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $0C       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $06,$96,$A1,$81,$0F,$26 ; table, bitmap, or initialized data bytes
                    fcb       $04,$86   ; table, bitmap, or initialized data bytes
                    fcc       "@"                            ; embedded text or resource bytes
                    fcb       $97,$9B,$DE ; table, bitmap, or initialized data bytes
                    fcc       "ko"                           ; embedded text or resource bytes
                    fcb       $C4,$DF   ; table, bitmap, or initialized data bytes
                    fcc       "m"                            ; embedded text or resource bytes
                    fcb       $DE       ; table, bitmap, or initialized data bytes
                    fcc       "g"                            ; embedded text or resource bytes
                    fcb       $DF       ; table, bitmap, or initialized data bytes
                    fcc       "i9"                           ; embedded text or resource bytes
Code_149A           lbsr      Code_0752 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1B       ; private DeskMate service selector
                    ldy       Data_0099 ; load the value needed by the following operation
                    ldx       Data_0069 ; load the value needed by the following operation
Code_14A6           cmpx      Data_0067 ; compare against the limit and set condition flags
                    beq       Code_14B3 ; branch when the compared values are equal
                    leay      -$50,Y    ; form the referenced address without reading memory
                    ldu       ,--X      ; load the value needed by the following operation
                    stu       ,Y        ; save the current value in working storage
                    bra       Code_14A6 ; continue at the selected control-flow target
Code_14B3           stx       Data_0069 ; save the current value in working storage
                    lbra      Code_075B ; continue at the distant control-flow target
Code_14B8           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "1"                            ; embedded text or resource bytes
                    tst       Data_0034 ; set condition flags from the current value
                    bne       Code_14C4 ; branch when the compared values differ
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "2"                            ; embedded text or resource bytes
Code_14C4           bsr       Code_149A ; call the referenced helper routine
Code_14C6           ldd       Data_0096 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    tst       Data_0034 ; set condition flags from the current value
                    bne       Code_1514 ; branch when the compared values differ
                    lda       #$80      ; load the value needed by the following operation
                    sta       Addr_0012 ; save the current value in working storage
                    ldx       Data_006B ; load the value needed by the following operation
                    cmpx      Data_006D ; compare against the limit and set condition flags
                    beq       Code_14F7 ; branch when the compared values are equal
                    ldb       Data_009B ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "6"                            ; embedded text or resource bytes
                    tfr       Y,D       ; copy the source register into the destination register
                    andb      #$1F      ; mask off unwanted bits
                    stb       Data_0098 ; save the current value in working storage
                    lda       Data_0097 ; load the value needed by the following operation
                    cmpa      #$27      ; compare against the limit and set condition flags
                    bne       Code_14EF ; branch when the compared values differ
                    tstb                ; set condition flags from the current value
                    beq       Code_14F1 ; branch when the compared values are equal
Code_14EF           cmpb      #$27      ; compare against the limit and set condition flags
Code_14F1           lbeq      Code_166E ; take the distant branch when values are equal
                    bra       Code_154C ; continue at the selected control-flow target
Code_14F7           lda       #$83      ; load the value needed by the following operation
                    sta       Addr_0012 ; save the current value in working storage
                    ldd       Data_0096 ; load the value needed by the following operation
                    stb       Data_0098 ; save the current value in working storage
                    bsr       Code_1503 ; call the referenced helper routine
                    bra       Code_154C ; continue at the selected control-flow target
Code_1503           pshs      B         ; preserve the listed registers on the stack
                    ldb       #$08      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    tfr       B,A       ; copy the source register into the destination register
                    puls      B         ; restore the listed registers from the stack
                    aslb                ; shift left and update carry
                    suba      #$10      ; subtract the operand from the running value
                    std       Data_003F ; save the current value in working storage
                    lbra      Code_2877 ; continue at the distant control-flow target
Code_1514           lda       #$80      ; load the value needed by the following operation
                    ldx       Data_006B ; load the value needed by the following operation
                    cmpx      Data_006D ; compare against the limit and set condition flags
                    beq       Code_14F7 ; branch when the compared values are equal
                    sta       Addr_0012 ; save the current value in working storage
                    ldb       Data_0097 ; load the value needed by the following operation
                    stb       Data_0098 ; save the current value in working storage
Code_1522           ldb       Data_009B ; load the value needed by the following operation
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    beq       Code_1540 ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $01       ; private DeskMate service selector
                    inc       Data_0098 ; advance the selected counter
                    ldb       Data_0098 ; load the value needed by the following operation
                    lda       Data_0096 ; load the value needed by the following operation
                    cmpa      #$17      ; compare against the limit and set condition flags
                    bne       Code_153A ; branch when the compared values differ
                    cmpb      #$28      ; compare against the limit and set condition flags
                    beq       Code_1544 ; branch when the compared values are equal
Code_153A           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    bra       Code_1522 ; continue at the selected control-flow target
Code_1540           ldb       Data_0098 ; load the value needed by the following operation
                    cmpb      #$28      ; compare against the limit and set condition flags
Code_1544           lbeq      Code_166E ; take the distant branch when values are equal
                    lda       Data_0096 ; load the value needed by the following operation
                    bsr       Code_1503 ; call the referenced helper routine
Code_154C           lbsr      Code_0752 ; call the referenced helper routine
                    ldx       Data_0067 ; load the value needed by the following operation
                    lda       #$08      ; load the value needed by the following operation
Code_1553           ldu       ,Y        ; load the value needed by the following operation
                    stu       ,X++      ; store the value and advance the destination pointer
                    leay      $50,Y     ; form the referenced address without reading memory
                    deca                ; decrement the selected counter
                    bne       Code_1553 ; branch when the compared values differ
                    stx       Data_0069 ; save the current value in working storage
                    sty       Data_0099 ; save the current value in working storage
                    lbsr      Code_075B ; call the referenced helper routine
                    ldd       #Addr_8400 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $01       ; private DeskMate service selector
Code_156C           ldb       Addr_0012 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    beq       Code_15EB ; branch when the compared values are equal
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bcs       Code_15A3 ; branch when carry reports an unsigned underflow or error
                    cmpa      #$7E      ; compare against the limit and set condition flags
                    bhi       Code_15A3 ; branch when the unsigned value is above the limit
                    ldx       Data_006D ; load the value needed by the following operation
                    cmpx      Data_006B ; compare against the limit and set condition flags
                    bne       Code_158C ; branch when the compared values differ
                    pshs      X,A       ; preserve the listed registers on the stack
                    lbsr      Code_149A ; call the referenced helper routine
                    lbsr      Code_0777 ; call the referenced helper routine
                    puls      X,A       ; restore the listed registers from the stack
Code_158C           sta       ,X+       ; store the value and advance the destination pointer
                    clr       ,X        ; clear the selected byte or register
                    stx       Data_006D ; save the current value in working storage
                    lbra      Code_14C4 ; continue at the distant control-flow target
Code_1595           lda       Data_0096 ; load the value needed by the following operation
                    deca                ; decrement the selected counter
                    cmpa      #$02      ; compare against the limit and set condition flags
                    lbcc      Code_162C ; take the distant branch when carry is clear
                    lda       #$17      ; load the value needed by the following operation
                    lbra      Code_162C ; continue at the distant control-flow target
Code_15A3           cmpa      #$B2      ; compare against the limit and set condition flags
                    lbeq      Code_169C ; take the distant branch when values are equal
                    cmpa      #$BA      ; compare against the limit and set condition flags
                    lbeq      Code_16AA ; take the distant branch when values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    lbeq      Code_16B1 ; take the distant branch when values are equal
                    cmpa      #$8C      ; compare against the limit and set condition flags
                    lbeq      Code_16CA ; take the distant branch when values are equal
                    cmpa      #$AF      ; compare against the limit and set condition flags
                    lbeq      Code_16BB ; take the distant branch when values are equal
                    cmpa      #$0C      ; compare against the limit and set condition flags
                    beq       Code_1595 ; branch when the compared values are equal
                    cmpa      #$0A      ; compare against the limit and set condition flags
                    beq       Code_1623 ; branch when the compared values are equal
                    cmpa      #$08      ; compare against the limit and set condition flags
                    beq       Code_1632 ; branch when the compared values are equal
                    cmpa      #$09      ; compare against the limit and set condition flags
                    beq       Code_1642 ; branch when the compared values are equal
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    beq       Code_1650 ; branch when the compared values are equal
                    cmpa      #$88      ; compare against the limit and set condition flags
                    lbeq      Code_168A ; take the distant branch when values are equal
                    cmpa      #$12      ; compare against the limit and set condition flags
                    beq       Code_1659 ; branch when the compared values are equal
                    cmpa      #$13      ; compare against the limit and set condition flags
                    beq       Code_1661 ; branch when the compared values are equal
                    cmpa      #$10      ; compare against the limit and set condition flags
                    beq       Code_1665 ; branch when the compared values are equal
                    cmpa      #$11      ; compare against the limit and set condition flags
                    beq       Code_166A ; branch when the compared values are equal
Code_15EB           tst       Data_0052 ; set condition flags from the current value
                    lbeq      Code_156C ; take the distant branch when values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $19       ; private DeskMate service selector
                    cmpy      #Addr_0005 ; compare against the limit and set condition flags
                    lbcs      Code_16D2 ; take the distant branch when carry reports an error
                    cmpb      #$01      ; compare against the limit and set condition flags
                    lbne      Code_156C ; take the distant branch when values differ
                    tfr       Y,D       ; copy the source register into the destination register
                    lda       #$C0      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    lsra                ; shift right and expose the low bit through carry
                    tfr       A,B       ; copy the source register into the destination register
                    cmpb      #$02      ; compare against the limit and set condition flags
                    bcc       Code_1611 ; branch when carry is clear
                    ldb       #$02      ; load the value needed by the following operation
Code_1611           stb       Data_0096 ; save the current value in working storage
                    tfr       X,D       ; copy the source register into the destination register
                    lda       #$A0      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    sta       Data_0097 ; save the current value in working storage
                    ldu       Data_006B ; load the value needed by the following operation
                    clr       ,U        ; clear the selected byte or register
                    stu       Data_006D ; save the current value in working storage
                    lbra      Code_14C4 ; continue at the distant control-flow target
Code_1623           lda       Data_0096 ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    cmpa      #$18      ; compare against the limit and set condition flags
                    bcs       Code_162C ; branch when carry reports an unsigned underflow or error
                    lda       #$02      ; load the value needed by the following operation
Code_162C           ldb       Data_0098 ; load the value needed by the following operation
                    std       Data_0096 ; save the current value in working storage
                    bra       Code_1654 ; continue at the selected control-flow target
Code_1632           lda       Data_0098 ; load the value needed by the following operation
                    deca                ; decrement the selected counter
                    bge       Code_163E ; branch when the signed value is at least the limit
                    lda       #$27      ; load the value needed by the following operation
                    sta       Data_0097 ; save the current value in working storage
                    lbra      Code_1595 ; continue at the distant control-flow target
Code_163E           sta       Data_0097 ; save the current value in working storage
                    bra       Code_1654 ; continue at the selected control-flow target
Code_1642           lda       Data_0098 ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    sta       Data_0097 ; save the current value in working storage
                    cmpa      #$28      ; compare against the limit and set condition flags
                    bcs       Code_1654 ; branch when carry reports an unsigned underflow or error
                    clra                ; clear the selected byte or register
                    sta       Data_0097 ; save the current value in working storage
                    bra       Code_1623 ; continue at the selected control-flow target
Code_1650           bsr       Code_167C ; call the referenced helper routine
                    bra       Code_1656 ; continue at the selected control-flow target
Code_1654           bsr       Code_1673 ; call the referenced helper routine
Code_1656           lbra      Code_14C6 ; continue at the distant control-flow target
Code_1659           lda       #$17      ; load the value needed by the following operation
Code_165B           ldb       Data_0098 ; load the value needed by the following operation
                    std       Data_0096 ; save the current value in working storage
                    bra       Code_1654 ; continue at the selected control-flow target
Code_1661           lda       #$02      ; load the value needed by the following operation
                    bra       Code_165B ; continue at the selected control-flow target
Code_1665           clra                ; clear the selected byte or register
Code_1666           sta       Data_0097 ; save the current value in working storage
                    bra       Code_1654 ; continue at the selected control-flow target
Code_166A           lda       #$27      ; load the value needed by the following operation
                    bra       Code_1666 ; continue at the selected control-flow target
Code_166E           bsr       Code_167C ; call the referenced helper routine
                    lbra      Code_14C6 ; continue at the distant control-flow target
Code_1673           ldu       Data_006B ; load the value needed by the following operation
                    clr       ,U        ; clear the selected byte or register
                    stu       Data_006D ; save the current value in working storage
                    lbra      Code_149A ; continue at the distant control-flow target
Code_167C           bsr       Code_1673 ; call the referenced helper routine
                    lda       Data_0096 ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    cmpa      #$18      ; compare against the limit and set condition flags
                    bcs       Code_1687 ; branch when carry reports an unsigned underflow or error
                    lda       #$02      ; load the value needed by the following operation
Code_1687           sta       Data_0096 ; save the current value in working storage
                    rts                 ; return to the caller
Code_168A           ldx       Data_006D ; load the value needed by the following operation
                    cmpx      Data_006B ; compare against the limit and set condition flags
                    lbeq      Code_156C ; take the distant branch when values are equal
                    clr       ,-X       ; clear the selected byte or register
                    stx       Data_006D ; save the current value in working storage
                    lbsr      Code_076D ; call the referenced helper routine
                    lbra      Code_14C6 ; continue at the distant control-flow target
Code_169C           bsr       Code_16D2 ; call the referenced helper routine
                    lbsr      Code_0777 ; call the referenced helper routine
                    lbsr      Code_0907 ; call the referenced helper routine
Code_16A4           lbsr      Code_076D ; call the referenced helper routine
Code_16A7           lbra      Code_14C6 ; continue at the distant control-flow target
Code_16AA           bsr       Code_16D2 ; call the referenced helper routine
                    lbsr      Code_04D6 ; call the referenced helper routine
                    bra       Code_16A7 ; continue at the selected control-flow target
Code_16B1           bsr       Code_16D2 ; call the referenced helper routine
                    lbsr      Code_0777 ; call the referenced helper routine
                    lbsr      Code_0662 ; call the referenced helper routine
                    bra       Code_16A4 ; continue at the selected control-flow target
Code_16BB           bsr       Code_16D2 ; call the referenced helper routine
                    lbsr      Code_0777 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    lbsr      Code_045C ; call the referenced helper routine
                    lbsr      Code_076D ; call the referenced helper routine
                    lbra      Code_14B8 ; continue at the distant control-flow target
Code_16CA           lda       Data_0052 ; load the value needed by the following operation
                    sta       Data_0053 ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    lbsr      Code_052B ; call the referenced helper routine
Code_16D2           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "1"                            ; embedded text or resource bytes
                    lbsr      Code_149A ; call the referenced helper routine
                    bra       Code_167C ; continue at the selected control-flow target
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $06,$04,$1C,$0B,$00,$FF ; table, bitmap, or initialized data bytes
                    fcc       "8Select a background "        ; embedded text or resource bytes
                    fcc       "color."                       ; embedded text or resource bytes
                    fcb       $00,$17,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "Q"                            ; embedded text or resource bytes
                    fcb       $17,$E9,$10 ; table, bitmap, or initialized data bytes
                    fcc       "89"                           ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "o"                            ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "e"                            ; embedded text or resource bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "e0"                           ; embedded text or resource bytes
                    fcb       $8D,$1F,$86,$9F ; table, bitmap, or initialized data bytes
                    fcc       "a0"                           ; embedded text or resource bytes
                    fcb       $8D,$FF,$C5,$8D,$E6 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FF,$C7 ; table, bitmap, or initialized data bytes
                    fcc       "O_"                           ; embedded text or resource bytes
                    fcb       $17,$E8,$F3,$0A,$CC,$1C ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
                    fcb       $17,$03,$BD,$17,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $0F,$16,$D6,$A1,$C4,$03 ; table, bitmap, or initialized data bytes
                    fcb       $96,$A1   ; table, bitmap, or initialized data bytes
                    fcc       "DD"                           ; embedded text or resource bytes
                    fcb       $17,$04,$90,$17,$04 ; table, bitmap, or initialized data bytes
                    fcc       "{_"                           ; embedded text or resource bytes
                    fcb       $17,$E8,$D5,$1D,$97,$16 ; table, bitmap, or initialized data bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "R"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $00,$1E,$17,$E8,$C9 ; table, bitmap, or initialized data bytes
                    fcc       "E"                            ; embedded text or resource bytes
                    fcb       $8C,$00,$FF,$26,$07,$C1 ; table, bitmap, or initialized data bytes
                    fcb       $01,$10,$26,$00,$0F ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $C1,$01   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $0F,$17,$03,$EF,$96 ; table, bitmap, or initialized data bytes
                    fcc       "ZJ'"                          ; embedded text or resource bytes
                    fcb       $07       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $15,$17,$04,$B4 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $10,$96,$0A,$97,$A1,$96 ; table, bitmap, or initialized data bytes
                    fcb       $0F,$97,$A0 ; table, bitmap, or initialized data bytes
                    fcc       "2b"                           ; embedded text or resource bytes
                    fcb       $17,$0D,$10,$16,$0D,$B5 ; table, bitmap, or initialized data bytes
                    fcb       $96,$16,$81,$0D ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $EA,$81,$05,$10,$26,$FF ; table, bitmap, or initialized data bytes
                    fcb       $B4       ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $14,$02   ; table, bitmap, or initialized data bytes
Data_178A           fcb       $AA,$A0,$AA,$A0,$AA,$A0 ; table, bitmap, or initialized data bytes
                    fcb       $AA,$A0,$AA,$A0,$AA,$A0 ; table, bitmap, or initialized data bytes
                    fcb       $AA,$A0,$AA,$A0,$AA,$AF ; table, bitmap, or initialized data bytes
                    fcb       $AA,$AF,$AA,$AF,$AA,$AF ; table, bitmap, or initialized data bytes
                    fcb       $AA,$AF,$AA,$AF,$AA,$AF ; table, bitmap, or initialized data bytes
                    fcb       $AA,$AF,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$F0,$0F,$F0,$0F ; table, bitmap, or initialized data bytes
                    fcb       $F0,$0F,$F0,$0F,$F0,$0F ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$01 ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "V"                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $00,$98   ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $02,$04   ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $13,$00   ; table, bitmap, or initialized data bytes
                    fcc       "U04P"                         ; embedded text or resource bytes
                    fcb       $10,$9E,$12,$DC,$01 ; table, bitmap, or initialized data bytes
                    fcc       "HH1"                          ; embedded text or resource bytes
                    fcb       $A6,$1F,$98 ; table, bitmap, or initialized data bytes
                    fcc       "D1"                           ; embedded text or resource bytes
                    fcb       $A6,$D4   ; table, bitmap, or initialized data bytes
                    fcc       "6"                            ; embedded text or resource bytes
                    fcb       $9E       ; table, bitmap, or initialized data bytes
                    fcc       "7"                            ; embedded text or resource bytes
                    fcb       $E6,$85,$1F,$98 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $D0       ; table, bitmap, or initialized data bytes
                    fcc       "4t"                           ; embedded text or resource bytes
                    fcb       $8D,$E2,$E4,$A4,$17,$06 ; table, bitmap, or initialized data bytes
                    fcb       $D1,$A6   ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $8D,$04,$86,$82 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $F4       ; table, bitmap, or initialized data bytes
                    fcc       "4v"                           ; embedded text or resource bytes
                    fcb       $1F,$89   ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $8D,$FF,$8C,$8E,$00,$07 ; table, bitmap, or initialized data bytes
                    fcb       $ED,$C1   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $1F,$26,$FA,$8E,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $AF,$C1,$C4,$F0,$8E,$00 ; table, bitmap, or initialized data bytes
                    fcb       $07,$ED,$C1 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $1F,$26,$FA,$CC,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $ED,$C4   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $F6,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "o"                            ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "e"                            ; embedded text or resource bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "e0"                           ; embedded text or resource bytes
                    fcb       $8D,$1E   ; table, bitmap, or initialized data bytes
                    fcc       "N"                            ; embedded text or resource bytes
                    fcb       $9F       ; table, bitmap, or initialized data bytes
                    fcc       "a"                            ; embedded text or resource bytes
                    fcb       $17,$EF,$05 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FF,$92,$17,$E7,$C0 ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
                    fcb       $C6       ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $8E,$00   ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $10,$8E,$00 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $CE,$02   ; table, bitmap, or initialized data bytes
                    fcc       "T"                            ; embedded text or resource bytes
                    fcb       $17,$E7,$B0,$11,$CC,$09 ; table, bitmap, or initialized data bytes
                    fcc       "]"                            ; embedded text or resource bytes
                    fcb       $17,$02   ; table, bitmap, or initialized data bytes
                    fcc       "z"                            ; embedded text or resource bytes
                    fcb       $CC,$00,$00,$17,$03 ; table, bitmap, or initialized data bytes
                    fcc       "W"                            ; embedded text or resource bytes
                    fcb       $17,$03   ; table, bitmap, or initialized data bytes
                    fcc       "B"                            ; embedded text or resource bytes
                    fcb       $9E,$A2   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $89       ; table, bitmap, or initialized data bytes
                    fcc       "G"                            ; embedded text or resource bytes
                    fcb       $10,$10,$9E ; table, bitmap, or initialized data bytes
                    fcc       "g"                            ; embedded text or resource bytes
                    fcb       $C6,$80,$17,$EF ; table, bitmap, or initialized data bytes
                    fcc       "V"                            ; embedded text or resource bytes
                    fcb       $17,$EE,$CD,$17,$04 ; table, bitmap, or initialized data bytes
                    fcc       "(O"                           ; embedded text or resource bytes
                    fcb       $97,$0C,$C6,$FF,$17,$04 ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $17,$04   ; table, bitmap, or initialized data bytes
                    fcc       "Q0"                           ; embedded text or resource bytes
                    fcb       $8D,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $17,$E7   ; table, bitmap, or initialized data bytes
                    fcc       "z"                            ; embedded text or resource bytes
                    fcb       $13,$17,$00 ; table, bitmap, or initialized data bytes
                    fcc       "w"                            ; embedded text or resource bytes
                    fcb       $17,$EE,$BA,$CC,$00,$10 ; table, bitmap, or initialized data bytes
                    fcb       $DD,$05,$CC,$00,$06,$DD ; table, bitmap, or initialized data bytes
                    fcb       $07,$0F,$04 ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $17,$E7   ; table, bitmap, or initialized data bytes
                    fcc       "c"                            ; embedded text or resource bytes
                    fcb       $1D,$97,$16,$81,$0D ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $05,$81,$05,$26,$11 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $10,$9E,$A2 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $A9       ; table, bitmap, or initialized data bytes
                    fcc       "G"                            ; embedded text or resource bytes
                    fcb       $10,$9E   ; table, bitmap, or initialized data bytes
                    fcc       "g"                            ; embedded text or resource bytes
                    fcb       $C6,$80,$17,$EF,$0D ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $EF,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "R"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       ":"                            ; embedded text or resource bytes
                    fcb       $17,$E7   ; table, bitmap, or initialized data bytes
                    fcc       ">E"                           ; embedded text or resource bytes
                    fcb       $8C,$00,$FF,$26,$06,$C1 ; table, bitmap, or initialized data bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $DC       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $CB,$DD   ; table, bitmap, or initialized data bytes
                    fcc       "Y"                            ; embedded text or resource bytes
                    fcb       $10,$8C,$00,$0F ; table, bitmap, or initialized data bytes
                    fcc       "'B"                           ; embedded text or resource bytes
                    fcb       $10,$8C,$00,$10,$10 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "W"                            ; embedded text or resource bytes
                    fcb       $0D,$09   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $00,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "Y'"                           ; embedded text or resource bytes
                    fcb       $B3,$10,$8C,$00,$03,$10 ; table, bitmap, or initialized data bytes
                    fcc       "#"                            ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "E"                            ; embedded text or resource bytes
                    fcb       $8C,$00,$10 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $09,$8C,$00,$1F,$10 ; table, bitmap, or initialized data bytes
                    fcc       "#"                            ; embedded text or resource bytes
                    fcb       $00,$C5   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $9D,$17,$02 ; table, bitmap, or initialized data bytes
                    fcc       "; "                     ;1912: 3B 20          ' ; embedded text or resource bytes
                    fcb       $98,$0F,$09 ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $8D,$1D,$10,$8E,$00,$0F ; table, bitmap, or initialized data bytes
                    fcb       $8E,$00,$05,$17,$E6,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "D"                            ; embedded text or resource bytes
                    fcb       $86,$01,$17,$E6,$EA,$0A ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $81,$01,$10 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $FF,$89,$16,$FF ; table, bitmap, or initialized data bytes
                    fcc       "v"                            ; embedded text or resource bytes
                    fcb       $10,$8E,$00,$10,$8E,$00 ; table, bitmap, or initialized data bytes
                    fcb       $05,$17,$E6,$D3 ; table, bitmap, or initialized data bytes
                    fcc       "D"                            ; embedded text or resource bytes
                    fcb       $86,$02,$17,$E6,$CD,$0A ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $81,$01,$10,$26,$FF ; table, bitmap, or initialized data bytes
                    fcc       "\9"                           ; embedded text or resource bytes
                    fcb       $17,$E6,$BF ; table, bitmap, or initialized data bytes
                    fcc       "DL"                           ; embedded text or resource bytes
                    fcb       $17,$E6,$BA ; table, bitmap, or initialized data bytes
                    fcc       "B9"                           ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "4'"                           ; embedded text or resource bytes
                    fcb       $F2       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $02,$1F,$10 ; table, bitmap, or initialized data bytes
                    fcc       "T$"                           ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $1F,$17,$E6,$A8 ; table, bitmap, or initialized data bytes
                    fcc       "D5"                           ; embedded text or resource bytes
                    fcb       $02,$17,$E6,$A2 ; table, bitmap, or initialized data bytes
                    fcc       "BL"                           ; embedded text or resource bytes
                    fcb       $17,$E6,$9D ; table, bitmap, or initialized data bytes
                    fcc       "B90"                          ; embedded text or resource bytes
                    fcb       $10,$1F,$10 ; table, bitmap, or initialized data bytes
                    fcc       "T"                            ; embedded text or resource bytes
                    fcb       $D7,$02   ; table, bitmap, or initialized data bytes
                    fcc       "1:"                           ; embedded text or resource bytes
                    fcb       $1F       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $D7,$01   ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $26,$EE   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $10,$1F,$10,$D7,$02 ; table, bitmap, or initialized data bytes
                    fcc       "1:"                           ; embedded text or resource bytes
                    fcb       $1F       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $D7,$01   ; table, bitmap, or initialized data bytes
                    fcc       "94@3"                         ; embedded text or resource bytes
                    fcb       $8D,$FE,$0C,$C6,$0E ; table, bitmap, or initialized data bytes
                    fcc       "c"                            ; embedded text or resource bytes
                    fcb       $C0       ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $26,$FB   ; table, bitmap, or initialized data bytes
                    fcc       "3B"                           ; embedded text or resource bytes
                    fcb       $C6,$07   ; table, bitmap, or initialized data bytes
                    fcc       "c"                            ; embedded text or resource bytes
                    fcb       $C0,$A6,$C4 ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $84,$F0,$A7,$C0 ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $26,$F4   ; table, bitmap, or initialized data bytes
                    fcc       "5@"                           ; embedded text or resource bytes
                    fcb       $86,$82,$9E,$05,$10,$9E ; table, bitmap, or initialized data bytes
                    fcb       $07       ; table, bitmap, or initialized data bytes
                    fcc       "42"                           ; embedded text or resource bytes
                    fcb       $8D,$9A   ; table, bitmap, or initialized data bytes
                    fcc       "52"                           ; embedded text or resource bytes
                    fcb       $8D,$C1,$17,$FE ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $9E,$05,$10,$9E,$07,$8D ; table, bitmap, or initialized data bytes
                    fcb       $8C,$16,$FE,$DA,$10,$8C ; table, bitmap, or initialized data bytes
                    fcb       $00,$05   ; table, bitmap, or initialized data bytes
                    fcc       "#"                            ; embedded text or resource bytes
                    fcb       $06,$10,$8C,$00,$0E ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $03,$16,$FE,$CB,$96,$0F ; table, bitmap, or initialized data bytes
                    fcb       $17,$FE   ; table, bitmap, or initialized data bytes
                    fcc       "/"                            ; embedded text or resource bytes
                    fcb       $86,$82,$17,$ED ; table, bitmap, or initialized data bytes
                    fcc       "f"                            ; embedded text or resource bytes
                    fcb       $17,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "m"                            ; embedded text or resource bytes
                    fcb       $17,$ED   ; table, bitmap, or initialized data bytes
                    fcc       "i"                            ; embedded text or resource bytes
                    fcb       $8D,$93,$8D,$08,$96,$0C ; table, bitmap, or initialized data bytes
                    fcb       $17,$02   ; table, bitmap, or initialized data bytes
                    fcc       "i"                            ; embedded text or resource bytes
                    fcb       $16,$FE,$AF,$17,$FD,$EA ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $A4,$A4,$D4,$0F,$E7,$E2 ; table, bitmap, or initialized data bytes
                    fcb       $AA,$E0,$A7,$A4 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $D6,$04   ; table, bitmap, or initialized data bytes
                    fcc       "'=Z'"                         ; embedded text or resource bytes
                    fcb       $1E,$81,$09 ; table, bitmap, or initialized data bytes
                    fcc       "'n"                           ; embedded text or resource bytes
                    fcb       $81,$08   ; table, bitmap, or initialized data bytes
                    fcc       "'`"                           ; embedded text or resource bytes
                    fcb       $81,$8A,$26,$06,$D6,$03 ; table, bitmap, or initialized data bytes
                    fcb       $D7,$04   ; table, bitmap, or initialized data bytes
                    fcc       " %_"                          ; embedded text or resource bytes
                    fcb       $81,$89   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $F7       ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $81,$88   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $F2       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $F2,$17,$01,$E8,$96,$16 ; table, bitmap, or initialized data bytes
                    fcb       $81,$8C,$26,$0A,$D6,$04 ; table, bitmap, or initialized data bytes
                    fcb       $D7,$03,$C6,$02,$D7,$04 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $06,$81,$89,$26,$02,$0F ; table, bitmap, or initialized data bytes
                    fcb       $04,$16,$FE ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $81       ; table, bitmap, or initialized data bytes
                    fcc       " '@"                          ; embedded text or resource bytes
                    fcb       $81,$0C   ; table, bitmap, or initialized data bytes
                    fcc       "'D"                           ; embedded text or resource bytes
                    fcb       $81,$0A   ; table, bitmap, or initialized data bytes
                    fcc       "'Q"                           ; embedded text or resource bytes
                    fcb       $81,$09   ; table, bitmap, or initialized data bytes
                    fcc       "'Z"                           ; embedded text or resource bytes
                    fcb       $81,$08,$10 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "p"                            ; embedded text or resource bytes
                    fcb       $81,$8C,$26,$0A,$D6,$04 ; table, bitmap, or initialized data bytes
                    fcb       $D7,$03,$C6,$02,$D7,$04 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $D9,$81,$88,$26 ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $C6,$01,$D7,$04 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $CF,$96,$0C ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $CB       ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $17,$02,$A5 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $C5,$96,$0C,$81,$03 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $BF       ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $17,$02,$99 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $B9,$9E,$05,$10,$9E,$07 ; table, bitmap, or initialized data bytes
                    fcb       $16,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "H"                            ; embedded text or resource bytes
                    fcb       $10,$9E,$07,$10,$8C,$00 ; table, bitmap, or initialized data bytes
                    fcb       $06       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
                    fcc       "1?"                           ; embedded text or resource bytes
                    fcb       $10,$9F,$07,$16,$FE,$ED ; table, bitmap, or initialized data bytes
                    fcb       $10,$9E,$07,$10,$8C,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $F4       ; table, bitmap, or initialized data bytes
                    fcc       "1! "                          ; embedded text or resource bytes
                    fcb       $ED,$9E,$05,$0D ; table, bitmap, or initialized data bytes
                    fcc       "4'"                           ; embedded text or resource bytes
                    fcb       $05,$8C,$00,$1E ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $03,$8C,$00,$1F ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $01,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "4'"                           ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $01,$9F,$05 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $D4,$9E,$05,$8C,$00,$10 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $CD       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $1F,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "4'"                           ; embedded text or resource bytes
                    fcb       $EF       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $1F       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $EB,$DD,$9E,$86 ; table, bitmap, or initialized data bytes
                    fcc       "P="                           ; embedded text or resource bytes
                    fcb       $D3,$AF,$1F,$01,$96,$9E ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       "O3"                           ; embedded text or resource bytes
                    fcb       $8D,$E5   ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $C6,$04,$10,$8E,$00,$08 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $06,$A6,$C6,$1F,$89,$ED ; table, bitmap, or initialized data bytes
                    fcb       $84,$ED,$02 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $88       ; table, bitmap, or initialized data bytes
                    fcc       "P1?"                          ; embedded text or resource bytes
                    fcb       $26,$F5   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $06       ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $81,$10   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $16       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $89,$FD,$86 ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $26,$DD   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $89,$04   ; table, bitmap, or initialized data bytes
                    fcc       "H "                           ; embedded text or resource bytes
                    fcb       $D5,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FF,$F3,$86,$FF,$A7 ; table, bitmap, or initialized data bytes
                    fcb       $84,$96,$9E,$C6,$08 ; table, bitmap, or initialized data bytes
                    fcc       "="                            ; embedded text or resource bytes
                    fcb       $ED,$01,$C3,$00,$1C,$ED ; table, bitmap, or initialized data bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $D6,$9F,$ED ; table, bitmap, or initialized data bytes
Data_1B43           fcb       $03,$C3,$00,$07,$ED,$07 ; table, bitmap, or initialized data bytes
                    fcb       $17,$E4,$C8,$13 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $17,$E4,$C3,$19,$DD ; table, bitmap, or initialized data bytes
                    fcc       "Y"                            ; embedded text or resource bytes
                    fcb       $1F       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $86,$03   ; table, bitmap, or initialized data bytes
                    fcc       "="                            ; embedded text or resource bytes
                    fcb       $DD       ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $1F,$10,$86,$A0 ; table, bitmap, or initialized data bytes
                    fcc       "="                            ; embedded text or resource bytes
                    fcb       $10,$8E,$00,$06 ; table, bitmap, or initialized data bytes
                    fcc       "DV1?"                         ; embedded text or resource bytes
                    fcb       $26,$FA,$DD ; table, bitmap, or initialized data bytes
                    fcc       "AO"                           ; embedded text or resource bytes
                    fcb       $D6,$9E   ; table, bitmap, or initialized data bytes
                    fcc       "X"                            ; embedded text or resource bytes
                    fcb       $C0,$02,$1F,$01,$9C ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $10,$22,$00 ; table, bitmap, or initialized data bytes
                    fcc       "<0"                           ; embedded text or resource bytes
                    fcb       $0C,$9C   ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $22,$09   ; table, bitmap, or initialized data bytes
Data_1B80           fcc       "L"                            ; embedded text or resource bytes
                    fcb       $81,$03,$10,$22,$00 ; table, bitmap, or initialized data bytes
                    fcc       "/ "                           ; embedded text or resource bytes
                    fcb       $EB,$97,$0B ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $D6,$9F,$C0,$02,$1F,$01 ; table, bitmap, or initialized data bytes
                    fcb       $9C       ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $10,$22,$00,$1E ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $0E,$9C   ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $22,$09   ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $81,$03,$10,$22,$00,$11 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $EB,$D6,$0B,$10,$93,$9C ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $08       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $06,$8D,$1C ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $06,$8D,$12 ; table, bitmap, or initialized data bytes
Code_1BB6           lda       Data_009C ; load the value needed by the following operation
                    ldb       #$04      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    addb      Data_009D ; add the operand to the running value
                    stb       Addr_000A ; save the current value in working storage
                    leau      Data_003A,PCR ; form the referenced address without reading memory
                    ldb       B,U       ; load the value needed by the following operation
                    stb       Addr_000F ; save the current value in working storage
                    rts                 ; return to the caller
                    fcb       $DD,$9C   ; table, bitmap, or initialized data bytes
Code_1BCA           lda       #$FF      ; load the value needed by the following operation
                    bra       Code_1BCF ; continue at the selected control-flow target
Code_1BCE           clra                ; clear the selected byte or register
Code_1BCF           sta       Data_002C ; save the current value in working storage
                    clr       Data_0025 ; clear the selected byte or register
                    lda       Data_0034 ; load the value needed by the following operation
                    pshs      A         ; preserve the listed registers on the stack
                    lbsr      Code_0752 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    ldb       Data_009F ; load the value needed by the following operation
                    subb      #$02      ; subtract the operand from the running value
                    tfr       D,Y       ; copy the source register into the destination register
                    lda       Data_009C ; load the value needed by the following operation
                    ldb       #$0E      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    leay      D,Y       ; form the referenced address without reading memory
                    clra                ; clear the selected byte or register
                    ldb       Data_009E ; load the value needed by the following operation
                    aslb                ; shift left and update carry
                    subb      #$02      ; subtract the operand from the running value
                    tfr       D,X       ; copy the source register into the destination register
                    lda       Data_009D ; load the value needed by the following operation
                    ldb       #$0C      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    leax      D,X       ; form the referenced address without reading memory
                    stx       Data_0041 ; save the current value in working storage
                    sty       Data_0043 ; save the current value in working storage
                    leay      $0B,Y     ; form the referenced address without reading memory
                    sty       Data_0047 ; save the current value in working storage
                    leax      $0B,X     ; form the referenced address without reading memory
                    stx       Data_0045 ; save the current value in working storage
                    bsr       Code_1C0F ; call the referenced helper routine
                    puls      A         ; restore the listed registers from the stack
                    lbsr      Code_00E7 ; call the referenced helper routine
                    lbra      Code_075B ; continue at the distant control-flow target
Code_1C0F           lda       Data_0049 ; load the value needed by the following operation
                    clr       Data_0049 ; clear the selected byte or register
                    pshs      A         ; preserve the listed registers on the stack
                    lbsr      Code_2FD7 ; call the referenced helper routine
                    puls      A         ; restore the listed registers from the stack
                    sta       Data_0049 ; save the current value in working storage
                    rts                 ; return to the caller
                    fcb       $96,$16,$81,$08 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $0E,$81   ; table, bitmap, or initialized data bytes
                    rol       Data_0027 ; rotate left through carry
                    daa                 ; adjust the accumulator to packed decimal
                    cmpa      #$0C      ; compare against the limit and set condition flags
                    beq       Code_1C4C ; branch when the compared values are equal
                    cmpa      #$0A      ; compare against the limit and set condition flags
                    beq       Code_1C57 ; branch when the compared values are equal
                    bra       Code_1C3D ; continue at the selected control-flow target
                    fcb       $0D,$9D,$10 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $FF,$7F,$8D,$95,$0A,$9D ; table, bitmap, or initialized data bytes
Code_1C3B           bsr       Code_1BCA ; call the referenced helper routine
Code_1C3D           lbra      Code_1BB6 ; continue at the distant control-flow target
                    fcb       $96,$9D,$81,$03 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $F7,$8D,$86,$0C,$9D ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $EF       ; table, bitmap, or initialized data bytes
Code_1C4C           tst       Data_009C ; set condition flags from the current value
                    beq       Code_1C3D ; branch when the compared values are equal
                    lbsr      Code_1BCE ; call the referenced helper routine
                    dec       Data_009C ; decrement the selected counter
                    bra       Code_1C3B ; continue at the selected control-flow target
Code_1C57           lda       Data_009C ; load the value needed by the following operation
                    cmpa      #$03      ; compare against the limit and set condition flags
                    beq       Code_1C3D ; branch when the compared values are equal
                    lbsr      Code_1BCE ; call the referenced helper routine
                    inc       Data_009C ; advance the selected counter
                    bra       Code_1C3B ; continue at the selected control-flow target
                    fcb       $81,$03   ; table, bitmap, or initialized data bytes
                    fcc       "#"                            ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "94v"                          ; embedded text or resource bytes
                    fcb       $9E       ; table, bitmap, or initialized data bytes
                    fcc       "g"                            ; embedded text or resource bytes
                    fcb       $C6       ; table, bitmap, or initialized data bytes
                    fcc       " =0"                          ; embedded text or resource bytes
                    fcb       $8B,$A6,$E4,$AF,$E3,$C6 ; table, bitmap, or initialized data bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "="                            ; embedded text or resource bytes
                    fcb       $CB,$0A,$86,$1E,$DD ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $17,$0B,$F5,$C6,$03,$D7 ; table, bitmap, or initialized data bytes
                    fcb       $10,$AE,$E4,$C6,$08,$D7 ; table, bitmap, or initialized data bytes
                    fcb       $0E,$C6,$03,$D7,$0D,$C6 ; table, bitmap, or initialized data bytes
                    fcb       $04,$A6,$80,$A7,$A0 ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $26,$F9   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $1C,$0A,$0D,$26,$F1 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $A8       ; table, bitmap, or initialized data bytes
                    fcc       "D"                            ; embedded text or resource bytes
                    fcb       $0A,$0E,$26,$E4,$0A,$10 ; table, bitmap, or initialized data bytes
                    fcb       $26,$DA   ; table, bitmap, or initialized data bytes
                    fcc       "2b5"                          ; embedded text or resource bytes
                    fcb       $F6       ; table, bitmap, or initialized data bytes
                    fcc       "4vO"                          ; embedded text or resource bytes
                    fcb       $8D,$AF   ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $81,$04,$26,$F9 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $F6       ; table, bitmap, or initialized data bytes
                    fcc       "4v"                           ; embedded text or resource bytes
                    fcb       $D7       ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $C6       ; table, bitmap, or initialized data bytes
                    fcc       " ="                           ; embedded text or resource bytes
                    fcb       $C3,$00,$12,$DD ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $C3,$00,$1B,$DD ; table, bitmap, or initialized data bytes
                    fcc       "E"                            ; embedded text or resource bytes
                    fcb       $CC,$00   ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $DD       ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $CC,$00   ; table, bitmap, or initialized data bytes
                    fcc       "H"                            ; embedded text or resource bytes
                    fcb       $DD       ; table, bitmap, or initialized data bytes
                    fcc       "G"                            ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $17,$EA   ; table, bitmap, or initialized data bytes
                    fcc       "v"                            ; embedded text or resource bytes
                    fcb       $17,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $17,$EA   ; table, bitmap, or initialized data bytes
                    fcc       "y5"                           ; embedded text or resource bytes
                    fcb       $F6       ; table, bitmap, or initialized data bytes
                    fcc       "4v"                           ; embedded text or resource bytes
                    fcb       $9E       ; table, bitmap, or initialized data bytes
                    fcc       "g"                            ; embedded text or resource bytes
                    fcb       $C6       ; table, bitmap, or initialized data bytes
                    fcc       " =0"                          ; embedded text or resource bytes
                    fcb       $8B,$9F,$12,$10,$8E,$00 ; table, bitmap, or initialized data bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
                    fcc       "O_"                           ; embedded text or resource bytes
                    fcb       $DD,$01,$C6,$08,$D7,$10 ; table, bitmap, or initialized data bytes
                    fcb       $8E,$00,$10 ; table, bitmap, or initialized data bytes
                    fcc       "1!"                           ; embedded text or resource bytes
                    fcb       $17,$E3,$11 ; table, bitmap, or initialized data bytes
                    fcc       "D"                            ; embedded text or resource bytes
                    fcb       $C6,$10,$17,$FA,$FC,$0D ; table, bitmap, or initialized data bytes
                    fcc       "4'"                           ; embedded text or resource bytes
                    fcb       $08       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $04,$C4,$01 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $0C,$02,$17,$E2,$F9 ; table, bitmap, or initialized data bytes
                    fcc       "BZ"                           ; embedded text or resource bytes
                    fcb       $26,$E7,$0F,$02,$0C,$01 ; table, bitmap, or initialized data bytes
                    fcb       $0A,$10,$26,$D4 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $F6       ; table, bitmap, or initialized data bytes
                    fcc       "4v"                           ; embedded text or resource bytes
                    fcb       $17,$EA   ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $91,$0C   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $10,$96,$0C ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $17,$FF,$84 ; table, bitmap, or initialized data bytes
                    fcc       "S"                            ; embedded text or resource bytes
                    fcb       $A6,$E4,$97,$0C,$17,$FF ; table, bitmap, or initialized data bytes
                    fcc       "|"                            ; embedded text or resource bytes
                    fcb       $8D,$A2,$17,$EA,$16 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $F6       ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $8C,$00,$09 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $8C,$00,$11 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $07       ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $8C,$00,$19 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $17,$FF,$CC,$16,$FB ; table, bitmap, or initialized data bytes
                    fcc       "M"                            ; embedded text or resource bytes
                    fcb       $FF,$00,$EC,$00,$00,$01 ; table, bitmap, or initialized data bytes
                    fcb       $10,$00,$0D,$FF,$01,$18 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$01 ; table, bitmap, or initialized data bytes
                    fcc       "@"                            ; embedded text or resource bytes
                    fcb       $00,$0D,$FF,$01 ; table, bitmap, or initialized data bytes
                    fcc       "H"                            ; embedded text or resource bytes
                    fcb       $00,$00,$01 ; table, bitmap, or initialized data bytes
                    fcc       "p"                            ; embedded text or resource bytes
                    fcb       $00,$0D,$FF,$01 ; table, bitmap, or initialized data bytes
                    fcc       "x"                            ; embedded text or resource bytes
                    fcb       $00,$00,$01,$A0,$00,$0D ; table, bitmap, or initialized data bytes
                    fcb       $FF,$01,$A8,$00,$00,$01 ; table, bitmap, or initialized data bytes
                    fcb       $D0,$00,$0D ; table, bitmap, or initialized data bytes
Data_1D8D           fcc       "Exit"                         ; embedded text or resource bytes
                    fcb       $02,$00   ; table, bitmap, or initialized data bytes
Data_1D93           fcb       $04,$0E,$1E ; table, bitmap, or initialized data bytes
                    fcc       " $"                           ; embedded text or resource bytes
                    fcb       $26       ; table, bitmap, or initialized data bytes
                    fcc       "*,0268"                       ; embedded text or resource bytes
Code_1D9F           lbsr      Code_0752 ; call the referenced helper routine
                    lbsr      Code_077D ; call the referenced helper routine
                    lbsr      Code_3755 ; call the referenced helper routine
                    lda       #$AA      ; load the value needed by the following operation
                    sta       Data_002C ; save the current value in working storage
                    com       Data_0084 ; invert every bit in the selected value
Code_1DAE           stx       Data_0041 ; save the current value in working storage
                    cmpy      #Addr_0010 ; compare against the limit and set condition flags
                    bcc       Code_1DC5 ; branch when carry is clear
                    lbsr      Code_2C7A ; call the referenced helper routine
                    cmpy      #Addr_0010 ; compare against the limit and set condition flags
                    bcs       Code_1E1E ; branch when carry reports an unsigned underflow or error
                    ldx       Data_0041 ; load the value needed by the following operation
                    ldy       #Addr_0010 ; load the value needed by the following operation
Code_1DC5           stx       Data_0041 ; save the current value in working storage
                    sty       Data_0043 ; save the current value in working storage
                    ldd       Data_0039 ; load the value needed by the following operation
                    subd      #Data_0028 ; subtract the operand from the running value
                    cmpd      Data_0041 ; compare against the limit and set condition flags
                    bcc       Code_1DD8 ; branch when carry is clear
                    tfr       D,X       ; copy the source register into the destination register
                    bra       Code_1DC5 ; continue at the selected control-flow target
Code_1DD8           cmpy      #Data_0094 ; compare against the limit and set condition flags
                    bls       Code_1DE4 ; branch when the unsigned value is at or below the limit
                    ldy       #Data_0094 ; load the value needed by the following operation
                    bra       Code_1DC5 ; continue at the selected control-flow target
Code_1DE4           cmpx      Data_0084 ; compare against the limit and set condition flags
                    bne       Code_1DED ; branch when the compared values differ
                    cmpy      Data_0086 ; compare against the limit and set condition flags
                    beq       Code_1E0D ; branch when the compared values are equal
Code_1DED           stx       Data_0084 ; save the current value in working storage
                    sty       Data_0086 ; save the current value in working storage
                    leax      $27,X     ; form the referenced address without reading memory
                    leay      $2B,Y     ; form the referenced address without reading memory
                    stx       Data_0045 ; save the current value in working storage
                    sty       Data_0047 ; save the current value in working storage
Code_1DFD           lbsr      Code_0773 ; call the referenced helper routine
                    lbsr      Code_2FD7 ; call the referenced helper routine
                    ldx       Data_0041 ; load the value needed by the following operation
                    ldy       Data_0043 ; load the value needed by the following operation
                    stx       Data_0055 ; save the current value in working storage
                    sty       Data_0057 ; save the current value in working storage
Code_1E0D           clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    cmpa      #$8C      ; compare against the limit and set condition flags
                    bne       Code_1E21 ; branch when the compared values differ
                    lda       Data_0052 ; load the value needed by the following operation
                    sta       Data_0053 ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    lbsr      Code_052B ; call the referenced helper routine
Code_1E1E           lbra      Code_0773 ; continue at the distant control-flow target
Code_1E21           cmpa      #$B2      ; compare against the limit and set condition flags
                    bne       Code_1E30 ; branch when the compared values differ
                    lbsr      Code_0773 ; call the referenced helper routine
                    lbsr      Code_0907 ; call the referenced helper routine
Code_1E2B           lbsr      Code_0752 ; call the referenced helper routine
                    bra       Code_1DFD ; continue at the selected control-flow target
Code_1E30           cmpa      #$BA      ; compare against the limit and set condition flags
                    bne       Code_1E3C ; branch when the compared values differ
                    lbsr      Code_0773 ; call the referenced helper routine
                    lbsr      Code_04D6 ; call the referenced helper routine
                    bra       Code_1E2B ; continue at the selected control-flow target
Code_1E3C           cmpa      #$05      ; compare against the limit and set condition flags
                    bne       Code_1E48 ; branch when the compared values differ
                    lbsr      Code_076D ; call the referenced helper routine
                    lbsr      Code_0662 ; call the referenced helper routine
                    bra       Code_1E2B ; continue at the selected control-flow target
Code_1E48           cmpa      #$AF      ; compare against the limit and set condition flags
                    bne       Code_1E55 ; branch when the compared values differ
                    lbsr      Code_0773 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    lbsr      Code_045C ; call the referenced helper routine
                    bra       Code_1E2B ; continue at the selected control-flow target
Code_1E55           ldu       Data_0050 ; load the value needed by the following operation
                    jsr       ,U        ; call the referenced helper routine
                    lda       Data_005A ; load the value needed by the following operation
                    cmpa      #$01      ; compare against the limit and set condition flags
                    lbne      Code_1DAE ; take the distant branch when values differ
                    bsr       Code_1E66 ; call the referenced helper routine
                    lbra      Code_1D9F ; continue at the distant control-flow target
Code_1E66           lbsr      Code_247D ; call the referenced helper routine
                    lda       #$02      ; load the value needed by the following operation
Code_1E6B           lbsr      Code_25ED ; call the referenced helper routine
                    inca                ; advance the selected counter
                    cmpa      #$06      ; compare against the limit and set condition flags
                    bls       Code_1E6B ; branch when the unsigned value is at or below the limit
                    lbsr      Code_0752 ; call the referenced helper routine
                    lda       #$80      ; load the value needed by the following operation
                    lbsr      Code_21C4 ; call the referenced helper routine
                    ldu       Data_004E ; load the value needed by the following operation
                    stu       Data_0061 ; save the current value in working storage
                    ldx       Data_0041 ; load the value needed by the following operation
                    ldy       Data_0043 ; load the value needed by the following operation
                    stx       Data_008B ; save the current value in working storage
                    sty       Data_008D ; save the current value in working storage
Code_1E89           lbsr      Code_2BEC ; call the referenced helper routine
                    stu       Data_0094 ; save the current value in working storage
                    tfr       X,D       ; copy the source register into the destination register
                    ldx       Data_00B1 ; load the value needed by the following operation
                    lda       #$2C      ; load the value needed by the following operation
                    sta       Addr_0005 ; save the current value in working storage
Code_1E96           lda       #$28      ; load the value needed by the following operation
                    bsr       Code_1EA1 ; call the referenced helper routine
                    dec       Addr_0005 ; decrement the selected counter
                    bne       Code_1E96 ; branch when the compared values differ
                    lbra      Code_1F67 ; continue at the distant control-flow target
Code_1EA1           pshs      U,X,B     ; preserve the listed registers on the stack
                    sta       Addr_0004 ; save the current value in working storage
                    stb       DeskMateService ; save the current value in working storage
Code_1EA7           lda       DeskMateService ; load the value needed by the following operation
                    anda      Data_0036 ; mask off unwanted bits
                    ldy       Data_0037 ; load the value needed by the following operation
                    lda       A,Y       ; load the value needed by the following operation
                    tfr       A,B       ; copy the source register into the destination register
                    andb      ,U        ; mask off unwanted bits
                    bsr       Code_1EDF ; call the referenced helper routine
                    inc       DeskMateService ; advance the selected counter
                    ldb       DeskMateService ; load the value needed by the following operation
                    andb      Data_0036 ; mask off unwanted bits
                    bne       Code_1EC0 ; branch when the compared values differ
                    leau      $01,U     ; form the referenced address without reading memory
Code_1EC0           lda       -$01,Y    ; load the value needed by the following operation
                    tfr       A,B       ; copy the source register into the destination register
                    std       $00F0,X   ; save the current value in working storage
                    std       $00A0,X   ; save the current value in working storage
                    std       $50,X     ; save the current value in working storage
                    std       ,X++      ; store the value and advance the destination pointer
                    dec       Addr_0004 ; decrement the selected counter
                    bne       Code_1EA7 ; branch when the compared values differ
                    puls      U,X,B     ; restore the listed registers from the stack
                    leau      $50,U     ; form the referenced address without reading memory
                    leax      $0140,X   ; form the referenced address without reading memory
                    rts                 ; return to the caller
Code_1EDF           leay      Data_003A,PCR ; form the referenced address without reading memory
                    pshs      A         ; preserve the listed registers on the stack
Code_1EE5           lda       ,S        ; load the value needed by the following operation
                    anda      ,Y+       ; mask off unwanted bits
                    sta       ,-S       ; save the current value in working storage
                    cmpb      ,S+       ; compare against the limit and set condition flags
                    bne       Code_1EE5 ; branch when the compared values differ
                    puls      PC,B      ; restore the listed registers from the stack
Code_1EF1           pshs      U,Y,X     ; preserve the listed registers on the stack
                    tfr       Y,D       ; copy the source register into the destination register
                    aslb                ; shift left and update carry
                    lda       #$A0      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    ldy       Data_00AF ; load the value needed by the following operation
                    leay      D,Y       ; form the referenced address without reading memory
                    tfr       X,D       ; copy the source register into the destination register
                    aslb                ; shift left and update carry
                    rola                ; rotate left through carry
                    leau      D,Y       ; form the referenced address without reading memory
                    tst       Data_0025 ; set condition flags from the current value
                    beq       Code_1F14 ; branch when the compared values are equal
                    ldb       Addr_000B ; load the value needed by the following operation
                    tfr       B,A       ; copy the source register into the destination register
                    andb      Data_002C ; mask off unwanted bits
                    bsr       Code_1EDF ; call the referenced helper routine
                    lda       -$01,Y    ; load the value needed by the following operation
                    sta       Data_002C ; save the current value in working storage
Code_1F14           lda       Data_002C ; load the value needed by the following operation
                    tfr       A,B       ; copy the source register into the destination register
                    std       ,U        ; save the current value in working storage
                    std       $50,U     ; save the current value in working storage
                    std       $00A0,U   ; save the current value in working storage
                    std       $00F0,U   ; save the current value in working storage
                    puls      PC,U,Y,X  ; restore the listed registers from the stack
Code_1F27           lbsr      Code_2B99 ; call the referenced helper routine
                    pshs      U,Y,X     ; preserve the listed registers on the stack
                    lda       Data_006F ; load the value needed by the following operation
                    beq       Code_1F45 ; branch when the compared values are equal
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    beq       Code_1F47 ; branch when the compared values are equal
                    pshs      Y,X       ; preserve the listed registers on the stack
                    lbsr      Code_1F54 ; call the referenced helper routine
                    puls      Y,X       ; restore the listed registers from the stack
                    lda       ,U        ; load the value needed by the following operation
                    sta       Data_002C ; save the current value in working storage
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Data_0025 ; save the current value in working storage
                    bra       Code_1F47 ; continue at the selected control-flow target
Code_1F45           bsr       Code_1F4B ; call the referenced helper routine
Code_1F47           bsr       Code_1EF1 ; call the referenced helper routine
                    puls      PC,U,Y,X  ; restore the listed registers from the stack
Code_1F4B           pshs      Y,X       ; preserve the listed registers on the stack
                    bsr       Code_1F54 ; call the referenced helper routine
                    lbsr      Code_2B51 ; call the referenced helper routine
                    puls      PC,Y,X    ; restore the listed registers from the stack
Code_1F54           ldd       Data_008B ; load the value needed by the following operation
                    leax      D,X       ; form the referenced address without reading memory
                    ldd       Data_008D ; load the value needed by the following operation
                    leay      -$04,Y    ; form the referenced address without reading memory
                    leay      D,Y       ; form the referenced address without reading memory
                    lbsr      Code_2BEC ; call the referenced helper routine
                    lbsr      Code_2C0F ; call the referenced helper routine
                    sta       Addr_000B ; save the current value in working storage
                    rts                 ; return to the caller
Code_1F67           ldb       Data_008A ; load the value needed by the following operation
                    lbsr      Code_2183 ; call the referenced helper routine
                    lbsr      Code_0752 ; call the referenced helper routine
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Data_0093 ; save the current value in working storage
                    sta       Data_006F ; save the current value in working storage
                    clr       Data_0059 ; clear the selected byte or register
                    clr       Data_0066 ; clear the selected byte or register
                    clr       Data_005C ; clear the selected byte or register
                    ldx       Data_008F ; load the value needed by the following operation
                    ldy       Data_0091 ; load the value needed by the following operation
                    tst       Data_0052 ; set condition flags from the current value
                    beq       Code_1F88 ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $19       ; private DeskMate service selector
Code_1F88           stx       Data_0041 ; save the current value in working storage
                    sty       Data_0043 ; save the current value in working storage
                    clr       Data_0025 ; clear the selected byte or register
                    lda       Data_0066 ; load the value needed by the following operation
                    sta       Data_002C ; save the current value in working storage
                    com       Data_0066 ; invert every bit in the selected value
                    lbsr      Code_2AB9 ; call the referenced helper routine
                    stx       Data_008F ; save the current value in working storage
                    sty       Data_0091 ; save the current value in working storage
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    cmpa      #$8C      ; compare against the limit and set condition flags
                    bne       Code_1FB6 ; branch when the compared values differ
                    dec       Data_006F ; decrement the selected counter
                    lbsr      Code_2AB9 ; call the referenced helper routine
                    lda       Data_0052 ; load the value needed by the following operation
                    sta       Data_0053 ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    lbsr      Code_052B ; call the referenced helper routine
Code_1FB3           lbra      Code_20B8 ; continue at the distant control-flow target
Code_1FB6           cmpa      #$05      ; compare against the limit and set condition flags
                    lbeq      Code_21F0 ; take the distant branch when values are equal
                    cmpa      #$AF      ; compare against the limit and set condition flags
                    lbeq      Code_2329 ; take the distant branch when values are equal
                    tst       Data_0052 ; set condition flags from the current value
                    beq       Code_1FED ; branch when the compared values are equal
                    lbsr      Code_2CB6 ; call the referenced helper routine
                    pshs      A         ; preserve the listed registers on the stack
                    lda       #$28      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    aslb                ; shift left and update carry
                    rola                ; rotate left through carry
                    aslb                ; shift left and update carry
                    rola                ; rotate left through carry
                    clrb                ; clear the selected byte or register
                    exg       A,B       ; exchange the two register values
                    cmpb      #$28      ; compare against the limit and set condition flags
                    bcs       Code_1FDB ; branch when carry reports an unsigned underflow or error
                    ldb       #$27      ; load the value needed by the following operation
Code_1FDB           tfr       D,X       ; copy the source register into the destination register
                    puls      B         ; restore the listed registers from the stack
                    lda       #$30      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    aslb                ; shift left and update carry
                    rola                ; rotate left through carry
                    aslb                ; shift left and update carry
                    rola                ; rotate left through carry
                    clrb                ; clear the selected byte or register
                    exg       A,B       ; exchange the two register values
                    tfr       D,Y       ; copy the source register into the destination register
                    bra       Code_1FEF ; continue at the selected control-flow target
Code_1FED           bsr       Code_2053 ; call the referenced helper routine
Code_1FEF           cmpx      Data_0041 ; compare against the limit and set condition flags
                    bne       Code_2000 ; branch when the compared values differ
                    cmpy      Data_0043 ; compare against the limit and set condition flags
                    bne       Code_2000 ; branch when the compared values differ
                    tst       Data_0059 ; set condition flags from the current value
                    beq       Code_1F88 ; branch when the compared values are equal
                    tst       Data_005C ; set condition flags from the current value
                    bne       Code_1F88 ; branch when the compared values differ
Code_2000           stx       Data_0045 ; save the current value in working storage
                    tst       Data_0059 ; set condition flags from the current value
                    beq       Code_2024 ; branch when the compared values are equal
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Data_005C ; save the current value in working storage
                    cmpy      #Addr_0004 ; compare against the limit and set condition flags
                    bcc       Code_2014 ; branch when carry is clear
                    ldy       #Addr_0004 ; load the value needed by the following operation
Code_2014           sty       Data_0047 ; save the current value in working storage
                    lbsr      Code_02C0 ; call the referenced helper routine
                    clr       Data_006F ; clear the selected byte or register
                    lbsr      Code_304B ; call the referenced helper routine
                    com       Data_006F ; invert every bit in the selected value
                    lbra      Code_1F88 ; continue at the distant control-flow target
Code_2024           pshs      Y,X       ; preserve the listed registers on the stack
                    ldx       Data_0041 ; load the value needed by the following operation
                    ldy       Data_0043 ; load the value needed by the following operation
                    dec       Data_006F ; decrement the selected counter
                    lbsr      Code_2AB9 ; call the referenced helper routine
                    inc       Data_006F ; advance the selected counter
                    puls      Y,X       ; restore the listed registers from the stack
                    clr       Data_005C ; clear the selected byte or register
                    cmpy      #Addr_0004 ; compare against the limit and set condition flags
                    lbcc      Code_1F88 ; take the distant branch when carry is clear
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $19       ; private DeskMate service selector
                    cmpy      #Addr_0005 ; compare against the limit and set condition flags
                    lbcs      Code_1FB3 ; take the distant branch when carry reports an error
                    ldx       Data_0045 ; load the value needed by the following operation
                    ldy       #Addr_0004 ; load the value needed by the following operation
                    lbra      Code_1F88 ; continue at the distant control-flow target
Code_2053           cmpa      #$0D      ; compare against the limit and set condition flags
                    beq       Code_205B ; branch when the compared values are equal
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bne       Code_2063 ; branch when the compared values differ
Code_205B           com       Data_0059 ; invert every bit in the selected value
                    beq       Code_2063 ; branch when the compared values are equal
                    ldb       #$01      ; load the value needed by the following operation
                    stb       Data_005A ; save the current value in working storage
Code_2063           cmpa      #$12      ; compare against the limit and set condition flags
                    bne       Code_206C ; branch when the compared values differ
                    ldy       #Data_002F ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_206C           cmpa      #$13      ; compare against the limit and set condition flags
                    bne       Code_2075 ; branch when the compared values differ
                    ldy       #Addr_0004 ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_2075           cmpa      #$11      ; compare against the limit and set condition flags
                    bne       Code_207D ; branch when the compared values differ
                    ldx       #Data_0027 ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_207D           cmpa      #$10      ; compare against the limit and set condition flags
                    bne       Code_2085 ; branch when the compared values differ
                    ldx       #DeskMateService ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_2085           leau      Data_2E37,PCR ; form the referenced address without reading memory
                    ldb       #$01      ; load the value needed by the following operation
                    lbsr      Code_2D23 ; call the referenced helper routine
                    ldb       #$04      ; load the value needed by the following operation
                    lbsr      Code_2D23 ; call the referenced helper routine
                    cmpx      #DeskMateService ; compare against the limit and set condition flags
                    bge       Code_209B ; branch when the signed value is at least the limit
                    ldx       #DeskMateService ; load the value needed by the following operation
Code_209B           cmpy      #Addr_0004 ; compare against the limit and set condition flags
                    bcc       Code_20A5 ; branch when carry is clear
                    ldy       #Addr_0004 ; load the value needed by the following operation
Code_20A5           cmpx      #Data_0027 ; compare against the limit and set condition flags
                    bcs       Code_20AD ; branch when carry reports an unsigned underflow or error
                    ldx       #Data_0027 ; load the value needed by the following operation
Code_20AD           cmpy      #Data_002F ; compare against the limit and set condition flags
                    bcs       Code_20B7 ; branch when carry reports an unsigned underflow or error
                    ldy       #Data_002F ; load the value needed by the following operation
Code_20B7           rts                 ; return to the caller
Code_20B8           clr       Data_0093 ; clear the selected byte or register
                    clr       Data_0059 ; clear the selected byte or register
                    lbsr      Code_075B ; call the referenced helper routine
                    ldb       #$FF      ; load the value needed by the following operation
                    tst       Data_0052 ; set condition flags from the current value
                    bne       Code_20CF ; branch when the compared values differ
                    ldb       Data_008A ; load the value needed by the following operation
                    cmpb      #$FF      ; compare against the limit and set condition flags
                    bne       Code_20CC ; branch when the compared values differ
                    clrb                ; clear the selected byte or register
Code_20CC           lbsr      Code_219C ; call the referenced helper routine
Code_20CF           stb       Data_008A ; save the current value in working storage
Code_20D1           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $19       ; private DeskMate service selector
                    tsta                ; set condition flags from the current value
                    bne       Code_20D1 ; branch when the compared values differ
Code_20D8           clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    lbeq      Code_216F ; take the distant branch when values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    lbeq      Code_21F0 ; take the distant branch when values are equal
                    tst       Data_0052 ; set condition flags from the current value
                    beq       Code_2122 ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $19       ; private DeskMate service selector
                    std       Data_0059 ; save the current value in working storage
                    tfr       Y,D       ; copy the source register into the destination register
                    lda       #$03      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    tfr       D,Y       ; copy the source register into the destination register
                    cmpy      #Addr_0010 ; compare against the limit and set condition flags
                    lbhi      Code_1F67 ; take the distant branch for unsigned higher
                    tfr       U,D       ; copy the source register into the destination register
                    clra                ; clear the selected byte or register
                    leau      Data_1D93,PCR ; form the referenced address without reading memory
Code_2109           cmpb      ,U+       ; compare against the limit and set condition flags
                    bcs       Code_2118 ; branch when carry reports an unsigned underflow or error
                    cmpb      ,U+       ; compare against the limit and set condition flags
                    lbls      Code_218C ; take the distant branch for unsigned lower-or-same
                    inca                ; advance the selected counter
                    cmpa      #$05      ; compare against the limit and set condition flags
                    bls       Code_2109 ; branch when the unsigned value is at or below the limit
Code_2118           ldb       Data_008A ; load the value needed by the following operation
                    bsr       Code_2183 ; call the referenced helper routine
Code_211C           tst       Data_0059 ; set condition flags from the current value
                    bne       Code_2149 ; branch when the compared values differ
                    bra       Code_20D8 ; continue at the selected control-flow target
Code_2122           cmpa      #$8A      ; compare against the limit and set condition flags
                    lbeq      Code_1F67 ; take the distant branch when values are equal
                    cmpa      #$08      ; compare against the limit and set condition flags
                    beq       Code_213F ; branch when the compared values are equal
                    cmpa      #$09      ; compare against the limit and set condition flags
                    bne       Code_211C ; branch when the compared values differ
                    ldb       Data_008A ; load the value needed by the following operation
                    cmpb      #$05      ; compare against the limit and set condition flags
                    beq       Code_211C ; branch when the compared values are equal
                    lbsr      Code_2183 ; call the referenced helper routine
                    incb                ; advance the selected counter
Code_213A           lbsr      Code_219C ; call the referenced helper routine
Code_213D           bra       Code_211C ; continue at the selected control-flow target
Code_213F           ldb       Data_008A ; load the value needed by the following operation
                    beq       Code_211C ; branch when the compared values are equal
                    lbsr      Code_2183 ; call the referenced helper routine
                    decb                ; decrement the selected counter
                    bra       Code_213A ; continue at the selected control-flow target
Code_2149           tst       Data_005A ; set condition flags from the current value
                    bne       Code_2163 ; branch when the compared values differ
                    ldx       #Addr_015E ; load the value needed by the following operation
Code_2150           pshs      X         ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $19       ; private DeskMate service selector
                    puls      X         ; restore the listed registers from the stack
                    stb       Data_005A ; save the current value in working storage
                    bne       Code_2163 ; branch when the compared values differ
                    leax      -$01,X    ; form the referenced address without reading memory
                    bne       Code_2150 ; branch when the compared values differ
                    lbra      Code_20D8 ; continue at the distant control-flow target
Code_2163           dec       Data_005A ; decrement the selected counter
                    beq       Code_216F ; branch when the compared values are equal
                    lda       Data_008A ; load the value needed by the following operation
                    deca                ; decrement the selected counter
                    bne       Code_216F ; branch when the compared values differ
                    deca                ; decrement the selected counter
                    bra       Code_2171 ; continue at the selected control-flow target
Code_216F           lda       Data_008A ; load the value needed by the following operation
Code_2171           clr       Data_0059 ; clear the selected byte or register
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    beq       Code_211C ; branch when the compared values are equal
                    lbsr      Code_0752 ; call the referenced helper routine
                    leay      Addr_26A5,PCR ; form the referenced address without reading memory
                    lbsr      Code_0327 ; call the referenced helper routine
                    jmp       ,Y        ; dispatch control through the selected target
Code_2183           lda       #$80      ; load the value needed by the following operation
                    bsr       Code_219E ; call the referenced helper routine
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Data_008A ; save the current value in working storage
Code_218B           rts                 ; return to the caller
Code_218C           cmpa      Data_008A ; compare against the limit and set condition flags
                    beq       Code_211C ; branch when the compared values are equal
                    pshs      A         ; preserve the listed registers on the stack
                    ldb       Data_008A ; load the value needed by the following operation
                    bsr       Code_2183 ; call the referenced helper routine
                    puls      B         ; restore the listed registers from the stack
                    bsr       Code_219C ; call the referenced helper routine
                    bra       Code_213D ; continue at the selected control-flow target
Code_219C           lda       #$81      ; load the value needed by the following operation
Code_219E           stb       Data_008A ; save the current value in working storage
                    beq       Code_21C4 ; branch when the compared values are equal
                    cmpb      #$FF      ; compare against the limit and set condition flags
                    beq       Code_218B ; branch when the compared values are equal
                    pshs      D         ; preserve the listed registers on the stack
                    decb                ; decrement the selected counter
                    leay      Code_269B,PCR ; form the referenced address without reading memory
                    aslb                ; shift left and update carry
                    ldy       B,Y       ; load the value needed by the following operation
                    lbsr      Code_032B ; call the referenced helper routine
                    puls      D         ; restore the listed registers from the stack
                    tfr       Y,X       ; copy the source register into the destination register
                    cmpa      #$80      ; compare against the limit and set condition flags
                    lbne      Code_25C8 ; take the distant branch when values differ
                    tfr       B,A       ; copy the source register into the destination register
                    inca                ; advance the selected counter
                    lbra      Code_25D2 ; continue at the distant control-flow target
Code_21C4           pshs      D         ; preserve the listed registers on the stack
                    lda       #$03      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    ldd       #Addr_0002 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    puls      A         ; restore the listed registers from the stack
                    clrb                ; clear the selected byte or register
                    lbsr      start     ;21D6: 17 DE 3B       '.. ; call the referenced helper routine
                    fcb       $02       ; private DeskMate service selector
                    leax      Data_1D8D,PCR ; form the referenced address without reading memory
                    clrb                ; clear the selected byte or register
                    cmpa      #$80      ; compare against the limit and set condition flags
                    beq       Code_21E5 ; branch when the compared values are equal
                    ldb       #$40      ; load the value needed by the following operation
Code_21E5           clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    puls      PC,B      ; restore the listed registers from the stack
Code_21F0           clr       Data_0093 ; clear the selected byte or register
                    lda       Data_0053 ; load the value needed by the following operation
                    lbsr      Code_052B ; call the referenced helper routine
                    lbsr      Code_245E ; call the referenced helper routine
                    lbra      Code_076D ; continue at the distant control-flow target
                    fcb       $10,$9E,$8D,$10,$8C,$00 ; table, bitmap, or initialized data bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "'E1?"                         ; embedded text or resource bytes
                    fcb       $86,$01,$10,$9F,$8D,$C6 ; table, bitmap, or initialized data bytes
                    fcc       "P=4"                          ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "CS"                           ; embedded text or resource bytes
                    fcb       $C3,$00,$01,$DE,$94 ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $CB,$DF,$94 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $04,$8E   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $C0,$DE,$AF ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $C9       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$86,$04 ; table, bitmap, or initialized data bytes
                    fcc       "=CS"                          ; embedded text or resource bytes
                    fcb       $C3,$00,$01 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $CB,$EC,$A3,$ED,$C3,$EC ; table, bitmap, or initialized data bytes
                    fcb       $A3,$ED,$C3 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $1C,$26,$F4,$DE,$94,$DC ; table, bitmap, or initialized data bytes
                    fcb       $8B,$9E,$B1,$86 ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $97,$04,$17,$FC ; table, bitmap, or initialized data bytes
                    fcc       "V"                            ; embedded text or resource bytes
                    fcb       $17,$E5,$0D,$16,$FE,$87 ; table, bitmap, or initialized data bytes
                    fcb       $10,$9E,$8D,$10,$8C,$00 ; table, bitmap, or initialized data bytes
                    fcb       $94       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $F1       ; table, bitmap, or initialized data bytes
                    fcc       "1!"                           ; embedded text or resource bytes
                    fcb       $86,$01,$10,$9F,$8D,$C6 ; table, bitmap, or initialized data bytes
                    fcc       "P="                           ; embedded text or resource bytes
                    fcb       $DE,$94   ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $CB,$DF,$94,$8E ; table, bitmap, or initialized data bytes
                    fcc       "8@"                           ; embedded text or resource bytes
                    fcb       $DE,$B1,$86,$04 ; table, bitmap, or initialized data bytes
                    fcc       "=1"                           ; embedded text or resource bytes
                    fcb       $CB,$17,$E5,$0A,$DE,$94 ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $C9,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "p"                            ; embedded text or resource bytes
                    fcb       $DC,$8B,$9E,$B1 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $89       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $C0,$86   ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $97,$04,$17,$FC,$15 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $BD,$9E,$8B ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $B9,$86,$01 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $1F,$9F,$8B,$DE,$AF ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $C9       ; table, bitmap, or initialized data bytes
                    fcc       ";"                      ;229C: 3B             ' ; embedded text or resource bytes
                    fcb       $FE,$10,$8E,$00,$B1 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $0B,$AF   ; table, bitmap, or initialized data bytes
                    fcc       "B"                            ; embedded text or resource bytes
                    fcb       $AE,$C3   ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $26,$F9,$1F,$10,$E7 ; table, bitmap, or initialized data bytes
                    fcc       "B"                            ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       "(1?"                          ; embedded text or resource bytes
                    fcb       $26,$F1,$9E,$8B,$10,$9E ; table, bitmap, or initialized data bytes
                    fcb       $8D,$17,$09 ; table, bitmap, or initialized data bytes
                    fcc       "/"                            ; embedded text or resource bytes
                    fcb       $DF,$94,$DC,$8B,$9E,$B1 ; table, bitmap, or initialized data bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $97,$05,$86,$01,$97,$04 ; table, bitmap, or initialized data bytes
                    fcb       $17,$FB,$D3,$0A,$05,$26 ; table, bitmap, or initialized data bytes
                    fcb       $F5,$16,$FF ; table, bitmap, or initialized data bytes
                    fcc       "v"                            ; embedded text or resource bytes
                    fcb       $DC       ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $83,$00   ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $10,$93,$8B,$10 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
                    fcc       "j"                            ; embedded text or resource bytes
                    fcb       $9E,$8B,$86,$01 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $01,$9F,$8B,$DE,$B1,$10 ; table, bitmap, or initialized data bytes
                    fcb       $8E,$00,$B1 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $09,$AF,$C1,$AE ; table, bitmap, or initialized data bytes
                    fcc       "BJ"                           ; embedded text or resource bytes
                    fcb       $26,$F9   ; table, bitmap, or initialized data bytes
                    fcc       "3B"                           ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       "(1?"                          ; embedded text or resource bytes
                    fcb       $26,$F3,$9E,$8B,$10,$9E ; table, bitmap, or initialized data bytes
                    fcb       $8D,$17,$08,$E4,$DF,$94 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $88       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $17,$08,$DC,$1F,$10,$9E ; table, bitmap, or initialized data bytes
                    fcb       $B1       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $88       ; table, bitmap, or initialized data bytes
                    fcc       "N"                            ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $97,$05,$86,$01,$97,$04 ; table, bitmap, or initialized data bytes
                    fcb       $17,$FB,$7F,$0A,$05,$26 ; table, bitmap, or initialized data bytes
                    fcb       $F5,$16,$FF,$22 ; table, bitmap, or initialized data bytes
Code_2329           lda       #$04      ; load the value needed by the following operation
                    lbsr      Code_045C ; call the referenced helper routine
                    ldb       Data_008A ; load the value needed by the following operation
                    lbsr      Code_2183 ; call the referenced helper routine
                    ldx       Data_008B ; load the value needed by the following operation
                    ldy       Data_008D ; load the value needed by the following operation
                    lbsr      Code_0752 ; call the referenced helper routine
                    lbra      Code_1E89 ; continue at the distant control-flow target
Data_233E           fcb       $FF,$01,$F8,$00,$00,$02 ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $00,$0E   ; table, bitmap, or initialized data bytes
Data_2347           fcb       $FF,$02   ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
                    fcb       $00,$00,$02 ; table, bitmap, or initialized data bytes
                    fcc       "d"                            ; embedded text or resource bytes
                    fcb       $00,$0E   ; table, bitmap, or initialized data bytes
Data_2350           fcb       $00,$05,$06,$0D,$0E,$12 ; table, bitmap, or initialized data bytes
                    fcb       $13,$18,$1F,$22 ; table, bitmap, or initialized data bytes
                    fcc       "#"                            ; embedded text or resource bytes
                    fcb       $26       ; table, bitmap, or initialized data bytes
Data_235C           fcb       $01,$06,$0E,$13 ; table, bitmap, or initialized data bytes
                    fcc       "File"                         ; embedded text or resource bytes
                    fcb       $02,$00   ; table, bitmap, or initialized data bytes
                    fcc       "Palette"                      ; embedded text or resource bytes
                    fcb       $02,$00   ; table, bitmap, or initialized data bytes
                    fcc       "Tool"                         ; embedded text or resource bytes
                    fcb       $02,$00   ; table, bitmap, or initialized data bytes
                    fcc       "Edit"                         ; embedded text or resource bytes
                    fcb       $02,$00,$00,$00,$03,$12 ; table, bitmap, or initialized data bytes
                    fcb       $03,$00,$00,$00,$04 ; table, bitmap, or initialized data bytes
                    fcc       "   open"                      ; embedded text or resource bytes
                    fcb       $00,$04   ; table, bitmap, or initialized data bytes
                    fcc       "   close"                     ; embedded text or resource bytes
                    fcb       $00,$04   ; table, bitmap, or initialized data bytes
                    fcc       "   save"                      ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       " 2 print"                     ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       " ? help"                      ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       " brushes"                     ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       " undo"                        ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       " clear"                       ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       " pattern"                     ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       " device"                      ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       " ? help"                      ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       " erase"                       ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       " cut + paste"                 ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       " copy + paste"                ; embedded text or resource bytes
                    fcb       $00,$00   ; table, bitmap, or initialized data bytes
                    fcc       " paste"                       ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       " transparent"                 ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       " solid"                       ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       " keyboard only"               ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       " joystick"                    ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       " mouse or joystick"           ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       " standard"                    ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       " inverted"                    ; embedded text or resource bytes
                    fcb       $00,$00   ; table, bitmap, or initialized data bytes
Code_245E           bsr       Code_247D ; call the referenced helper routine
                    lda       #$04      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    ldd       #Addr_0001 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    ldb       #$05      ; load the value needed by the following operation
Code_246F           lda       #$80      ; load the value needed by the following operation
                    lbsr      Code_2577 ; call the referenced helper routine
                    decb                ; decrement the selected counter
                    bge       Code_246F ; branch when the signed value is at least the limit
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_247D           ldx       Data_00AF ; load the value needed by the following operation
                    ldd       #Addr_AAAA ; load the value needed by the following operation
                    ldy       #Addr_0500 ; load the value needed by the following operation
                    bra       Code_2492 ; continue at the selected control-flow target
                    fcb       $9E,$B1,$96,$A0,$1F,$89 ; table, bitmap, or initialized data bytes
                    fcb       $10,$8E   ; table, bitmap, or initialized data bytes
                    fcc       "7"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_2492           lbsr      Code_0752 ; call the referenced helper routine
Code_2495           std       ,X++      ; store the value and advance the destination pointer
                    leay      -$02,Y    ; form the referenced address without reading memory
                    bne       Code_2495 ; branch when the compared values differ
                    rts                 ; return to the caller
Code_249C           lbsr      Code_075B ; call the referenced helper routine
                    ldb       #$FF      ; load the value needed by the following operation
                    tst       Data_0052 ; set condition flags from the current value
                    bne       Code_24A9 ; branch when the compared values differ
                    clrb                ; clear the selected byte or register
                    lbsr      Code_2575 ; call the referenced helper routine
Code_24A9           stb       Data_004D ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
Code_24B0           inc       Data_005D ; advance the selected counter
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    lbeq      Code_251E ; take the distant branch when values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    bne       Code_24EF ; branch when the compared values differ
                    tst       Data_0052 ; set condition flags from the current value
                    lbeq      Code_2616 ; take the distant branch when values are equal
                    lbsr      Code_0777 ; call the referenced helper routine
                    lbsr      Code_0662 ; call the referenced helper routine
                    lbsr      Code_076D ; call the referenced helper routine
                    bra       Code_24EF ; continue at the selected control-flow target
Code_24D2           lbsr      Code_0752 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $15       ; private DeskMate service selector
                    lda       Data_0032 ; load the value needed by the following operation
                    beq       Code_24E1 ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $14       ; private DeskMate service selector
Code_24E1           ldx       Data_00A2 ; load the value needed by the following operation
                    leax      $0ECE,X   ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "("                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "W"                            ; embedded text or resource bytes
Code_24EF           tst       Data_0052 ; set condition flags from the current value
                    beq       Code_2551 ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $19       ; private DeskMate service selector
                    cmpb      #$01      ; compare against the limit and set condition flags
                    beq       Code_251E ; branch when the compared values are equal
                    tfr       U,D       ; copy the source register into the destination register
                    cmpy      #Addr_0004 ; compare against the limit and set condition flags
                    lbhi      Code_2616 ; take the distant branch for unsigned higher
                    clra                ; clear the selected byte or register
                    lsrb                ; shift right and expose the low bit through carry
                    leau      Data_2350,PCR ; form the referenced address without reading memory
Code_250B           cmpb      ,U+       ; compare against the limit and set condition flags
                    bcs       Code_2518 ; branch when carry reports an unsigned underflow or error
                    cmpb      ,U+       ; compare against the limit and set condition flags
                    bls       Code_2538 ; branch when the unsigned value is at or below the limit
                    inca                ; advance the selected counter
                    cmpa      #$05      ; compare against the limit and set condition flags
                    bls       Code_250B ; branch when the unsigned value is at or below the limit
Code_2518           ldb       Data_004D ; load the value needed by the following operation
                    bsr       Code_2548 ; call the referenced helper routine
Code_251C           bra       Code_24B0 ; continue at the selected control-flow target
Code_251E           lda       Data_004D ; load the value needed by the following operation
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    beq       Code_251C ; branch when the compared values are equal
                    leay      Code_26F3,PCR ; form the referenced address without reading memory
                    lbsr      Code_0327 ; call the referenced helper routine
                    jsr       ,Y        ; call the referenced helper routine
                    lbsr      Code_076D ; call the referenced helper routine
Code_2530           clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    lbra      Code_2616 ; continue at the distant control-flow target
Code_2538           cmpa      Data_004D ; compare against the limit and set condition flags
                    beq       Code_251C ; branch when the compared values are equal
                    pshs      A         ; preserve the listed registers on the stack
                    ldb       Data_004D ; load the value needed by the following operation
                    bsr       Code_2548 ; call the referenced helper routine
                    puls      B         ; restore the listed registers from the stack
                    bsr       Code_2575 ; call the referenced helper routine
                    bra       Code_251C ; continue at the selected control-flow target
Code_2548           lda       #$80      ; load the value needed by the following operation
                    bsr       Code_2577 ; call the referenced helper routine
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Data_004D ; save the current value in working storage
Code_2550           rts                 ; return to the caller
Code_2551           cmpa      #$8A      ; compare against the limit and set condition flags
                    lbeq      Code_2616 ; take the distant branch when values are equal
                    cmpa      #$08      ; compare against the limit and set condition flags
                    beq       Code_256C ; branch when the compared values are equal
                    cmpa      #$09      ; compare against the limit and set condition flags
                    bne       Code_251C ; branch when the compared values differ
                    ldb       Data_004D ; load the value needed by the following operation
                    cmpb      #$03      ; compare against the limit and set condition flags
                    beq       Code_251C ; branch when the compared values are equal
                    bsr       Code_2548 ; call the referenced helper routine
                    incb                ; advance the selected counter
Code_2568           bsr       Code_2575 ; call the referenced helper routine
                    bra       Code_251C ; continue at the selected control-flow target
Code_256C           ldb       Data_004D ; load the value needed by the following operation
                    beq       Code_251C ; branch when the compared values are equal
                    bsr       Code_2548 ; call the referenced helper routine
                    decb                ; decrement the selected counter
                    bra       Code_2568 ; continue at the selected control-flow target
Code_2575           lda       #$81      ; load the value needed by the following operation
Code_2577           stb       Data_004D ; save the current value in working storage
                    cmpb      #$04      ; compare against the limit and set condition flags
                    beq       Code_25C0 ; branch when the compared values are equal
                    cmpb      #$05      ; compare against the limit and set condition flags
                    beq       Code_25D6 ; branch when the compared values are equal
                    bhi       Code_2550 ; branch when the unsigned value is above the limit
                    pshs      D         ; preserve the listed registers on the stack
                    lda       #$04      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    leax      Data_235C,PCR ; form the referenced address without reading memory
                    ldb       B,X       ; load the value needed by the following operation
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    lda       ,S        ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $02       ; private DeskMate service selector
                    ldb       $01,S     ; load the value needed by the following operation
                    leay      Code_26B1,PCR ; form the referenced address without reading memory
                    aslb                ; shift left and update carry
                    ldy       B,Y       ; load the value needed by the following operation
                    lbsr      Code_032B ; call the referenced helper routine
                    tfr       Y,X       ; copy the source register into the destination register
                    clrb                ; clear the selected byte or register
                    puls      A         ; restore the listed registers from the stack
                    cmpa      #$80      ; compare against the limit and set condition flags
                    beq       Code_25B5 ; branch when the compared values are equal
                    ldb       #$40      ; load the value needed by the following operation
Code_25B5           clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    puls      PC,B      ; restore the listed registers from the stack
Code_25C0           leax      Data_233E,PCR ; form the referenced address without reading memory
                    cmpa      #$80      ; compare against the limit and set condition flags
                    beq       Code_25D1 ; branch when the compared values are equal
Code_25C8           lda       #$FF      ; load the value needed by the following operation
Code_25CA           sta       ,X        ; save the current value in working storage
Code_25CC           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    sync                ; wait for an interrupt request
Code_25D0           rts                 ; return to the caller
Code_25D1           clra                ; clear the selected byte or register
Code_25D2           bsr       Code_25ED ; call the referenced helper routine
Code_25D4           bra       Code_25E2 ; continue at the selected control-flow target
Code_25D6           leax      Data_2347,PCR ; form the referenced address without reading memory
Code_25DA           cmpa      #$80      ; compare against the limit and set condition flags
Code_25DC           bne       Code_25C8 ; branch when the compared values differ
Code_25DE           lda       #$01      ; load the value needed by the following operation
Code_25E0           bsr       Code_25ED ; call the referenced helper routine
Code_25E2           lda       #$AA      ; load the value needed by the following operation
                    bra       Code_25CA ; continue at the selected control-flow target
Data_25E6           fcc       "@H"                           ; embedded text or resource bytes
                    fcb       $1E       ; table, bitmap, or initialized data bytes
                    fcc       "$*06"                         ; embedded text or resource bytes
Code_25ED           pshs      U,Y,X,D   ; preserve the listed registers on the stack
                    leax      >Data_25E6,PCR ; form the referenced address without reading memory
                    ldb       A,X       ; load the value needed by the following operation
                    pshs      B         ; preserve the listed registers on the stack
                    ldy       Data_00A2 ; load the value needed by the following operation
                    leay      $45DE,Y   ; form the referenced address without reading memory
                    cmpa      #$02      ; compare against the limit and set condition flags
                    beq       Code_260A ; branch when the compared values are equal
                    bcs       Code_2605 ; branch when carry reports an unsigned underflow or error
                    deca                ; decrement the selected counter
Code_2605           ldb       #$33      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    leay      D,Y       ; form the referenced address without reading memory
Code_260A           puls      B         ; restore the listed registers from the stack
                    tfr       Y,X       ; copy the source register into the destination register
                    lda       #$01      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    puls      PC,U,Y,X,D ; restore the listed registers from the stack
Code_2616           lda       Data_0053 ; load the value needed by the following operation
                    lbsr      Code_052B ; call the referenced helper routine
                    ldb       Data_004D ; load the value needed by the following operation
                    pshs      B         ; preserve the listed registers on the stack
                    lbsr      Code_2548 ; call the referenced helper routine
                    lbsr      Code_02C0 ; call the referenced helper routine
                    lda       Data_0049 ; load the value needed by the following operation
                    cmpa      #$0C      ; compare against the limit and set condition flags
                    beq       Code_262E ; branch when the compared values are equal
                    lbsr      Code_0752 ; call the referenced helper routine
Code_262E           leay      >Code_2664,PCR ; form the referenced address without reading memory
                    bsr       Code_263B ; call the referenced helper routine
                    puls      B         ; restore the listed registers from the stack
                    stb       Data_004D ; save the current value in working storage
                    lbra      Code_249C ; continue at the distant control-flow target
Code_263B           lda       Data_0049 ; load the value needed by the following operation
Code_263D           pshs      U,X       ; preserve the listed registers on the stack
                    lbsr      Code_0327 ; call the referenced helper routine
Code_2642           puls      U,X       ; restore the listed registers from the stack
                    jmp       ,Y        ; dispatch control through the selected target
                    fcb       $26,$82   ; table, bitmap, or initialized data bytes
Code_2648           bne       Code_25CC ; branch when the compared values differ
                    bne       Addr_25CE ; branch when the compared values differ
                    bne       Code_25D0 ; branch when the compared values differ
                    bne       Code_25D2 ; branch when the compared values differ
                    bne       Code_25D4 ; branch when the compared values differ
                    bne       Code_25D6 ; branch when the compared values differ
Code_2654           bne       Addr_25D8 ; branch when the compared values differ
                    bne       Code_25DA ; branch when the compared values differ
                    bne       Code_25DC ; branch when the compared values differ
Code_265A           bne       Code_25DE ; branch when the compared values differ
                    bne       Code_25E0 ; branch when the compared values differ
                    fcb       $14       ; table, bitmap, or initialized data bytes
Code_265F           rorb                ; rotate right through carry
                    pshu      PC,S,Y,X,DP,B ; preserve the listed registers on the stack
Code_2662           asr       Data_0041 ; shift right while preserving the sign
Code_2664           beq       Addr_2630 ; branch when the compared values are equal
                    beq       Code_2662 ; branch when the compared values are equal
                    beq       Code_2642 ; branch when the compared values are equal
Code_266A           bvc       Addr_268E ; branch when signed overflow is clear
                    bvc       Code_269E ; branch when signed overflow is clear
                    bvc       Addr_26B0 ; branch when signed overflow is clear
                    bvc       Addr_2694 ; branch when signed overflow is clear
                    bvc       Code_269E ; branch when signed overflow is clear
Code_2674           bvc       Addr_26B0 ; branch when signed overflow is clear
                    beq       Addr_2661 ; branch when the compared values are equal
                    sex                 ; sign-extend accumulator B into D
                    stx       Data_0028 ; save the current value in working storage
                    fcb       $51       ; table, bitmap, or initialized data bytes
                    fcb       $14       ; table, bitmap, or initialized data bytes
                    eora      Code_3780 ; toggle the selected bits
                    beq       Code_265A ; branch when the compared values are equal
                    rts                 ; return to the caller
Code_2683           pshu      PC,X,D    ; preserve the listed registers on the stack
                    pshu      PC,Y,DP,B,CC ; preserve the listed registers on the stack
Code_2687           pshu      PC,Y,X,DP,B ; preserve the listed registers on the stack
                    pshu      PC,S,DP,D,CC ; preserve the listed registers on the stack
                    pshu      PC,X,D,CC ; preserve the listed registers on the stack
                    pshu      PC,Y,X    ; preserve the listed registers on the stack
                    pshu      PC,Y,X,DP,D,CC ; preserve the listed registers on the stack
                    pshu      PC,S,X,A  ; preserve the listed registers on the stack
                    pshu      PC,X,DP,D ; preserve the listed registers on the stack
                    pshu      PC,Y,X,B,CC ; preserve the listed registers on the stack
                    pshu      PC,S,DP   ; preserve the listed registers on the stack
                    pshu      PC,S,X,D,CC ; preserve the listed registers on the stack
Code_269B           sex                 ; sign-extend accumulator B into D
                    neg       -$03,X    ; form the two's-complement negative value
Code_269E           rol       -$03,X    ; rotate left through carry
                    fcb       $72       ; table, bitmap, or initialized data bytes
                    sex                 ; sign-extend accumulator B into D
                    fcb       $7B       ; table, bitmap, or initialized data bytes
                    sex                 ; sign-extend accumulator B into D
                    anda      #$21      ; mask off unwanted bits
                    subb      Code_2329 ; subtract the operand from the running value
                    brn       Addr_26A8 ; reserved branch that is never taken
                    bhi       Addr_26FE ; branch when the unsigned value is above the limit
                    bhi       Code_263D ; branch when the unsigned value is above the limit
Code_26AF           bhi       Addr_2686 ; branch when the unsigned value is above the limit
Code_26B1           bls       Code_2713 ; branch when the unsigned value is at or below the limit
                    bls       Code_271B ; branch when the unsigned value is at or below the limit
                    bls       Code_2726 ; branch when the unsigned value is at or below the limit
                    bls       Code_272E ; branch when the unsigned value is at or below the limit
                    bls       Code_263D ; branch when the unsigned value is at or below the limit
                    bls       Code_2648 ; branch when the unsigned value is at or below the limit
                    bls       Code_2654 ; branch when the unsigned value is at or below the limit
                    bls       Code_265F ; branch when the unsigned value is at or below the limit
                    bls       Code_266A ; branch when the unsigned value is at or below the limit
                    bls       Code_2674 ; branch when the unsigned value is at or below the limit
                    bls       Addr_267F ; branch when the unsigned value is at or below the limit
Code_26C7           bls       Code_2687 ; branch when the unsigned value is at or below the limit
                    bls       Addr_2690 ; branch when the unsigned value is at or below the limit
                    bls       Code_269B ; branch when the unsigned value is at or below the limit
                    bls       Addr_26A5 ; branch when the unsigned value is at or below the limit
                    bls       Code_26AF ; branch when the unsigned value is at or below the limit
                    bls       Addr_26B8 ; branch when the unsigned value is at or below the limit
                    bls       Code_26C7 ; branch when the unsigned value is at or below the limit
                    bcc       Addr_26D8 ; branch when carry is clear
                    bcc       Code_26E1 ; branch when carry is clear
                    bcc       Addr_26F0 ; branch when carry is clear
                    bcc       Code_26F9 ; branch when carry is clear
                    bcc       Addr_270A ; branch when carry is clear
                    bcc       Code_2716 ; branch when carry is clear
Code_26E1           bcc       Addr_272B ; branch when carry is clear
                    bcc       Addr_2737 ; branch when carry is clear
Code_26E5           asl       Data_00AD ; shift left and update carry
                    asl       Data_00B9 ; shift left and update carry
Code_26E9           dec       Data_0095 ; decrement the selected counter
                    dec       Data_009C ; decrement the selected counter
                    dec       Data_00A3 ; decrement the selected counter
                    dec       Data_00AA ; decrement the selected counter
                    dec       Data_00B1 ; decrement the selected counter
Code_26F3           com       Data_0062 ; invert every bit in the selected value
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    anda      $09,Y     ; mask off unwanted bits
                    fcb       $38       ; table, bitmap, or initialized data bytes
Code_26F9           com       Data_00C5 ; invert every bit in the selected value
                    lsr       Data_0058 ; shift right and expose the low bit through carry
                    lsr       Addr_00D6 ; shift right and expose the low bit through carry
                    fcb       $05       ; table, bitmap, or initialized data bytes
Data_2700           fcb       $51       ; table, bitmap, or initialized data bytes
                    ror       Data_0062 ; rotate right through carry
                    ror       Addr_0005 ; rotate right through carry
                    rol       Addr_0007 ; rotate left through carry
                    asr       Data_003C ; shift right while preserving the sign
Code_2709           blt       Code_2748 ; branch when the signed value is below the limit
                    bge       Data_2700 ; branch when the signed value is at least the limit
                    bge       Code_2789 ; branch when the signed value is at least the limit
Code_270F           puls      PC,Y,X,DP,A ; restore the listed registers from the stack
                    fcb       $05,$04   ; table, bitmap, or initialized data bytes
Code_2713           lbsr      Addr_2D2E ; call the referenced helper routine
Code_2716           reset     ;         perform this step of the surrounding routine
                    fcb       $05       ; table, bitmap, or initialized data bytes
                    fcb       $14       ; table, bitmap, or initialized data bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
                    inca                ; advance the selected counter
Code_271B           tst       Addr_0001 ; set condition flags from the current value
                    stu       Addr_FF01 ; save the current value in working storage
                    neg       Addr_00FF ; form the two's-complement negative value
                    neg       Addr_00FF ; form the two's-complement negative value
                    neg       Addr_00FF ; form the two's-complement negative value
Code_2726           neg       Addr_00FF ; form the two's-complement negative value
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    stu       Addr_FF01 ; save the current value in working storage
                    neg       DeskMateService ; form the two's-complement negative value
Code_272E           neg       Addr_0001 ; form the two's-complement negative value
                    stu       >Addr_00FE ; save the current value in working storage
                    stu       Code_0101 ; save the current value in working storage
                    stu       >Addr_00FF ; save the current value in working storage
                    stu       >Addr_00FF ; save the current value in working storage
                    stu       Addr_0100 ; save the current value in working storage
                    stu       >Addr_0001 ; save the current value in working storage
                    stu       Addr_0CFF ; save the current value in working storage
                    stu       Addr_FF01 ; save the current value in working storage
Code_2748           neg       Addr_00FF ; form the two's-complement negative value
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    neg       Addr_00FF ; form the two's-complement negative value
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    neg       Addr_00FF ; form the two's-complement negative value
                    std       Code_01FF ; save the current value in working storage
                    com       DeskMateService ; invert every bit in the selected value
                    stu       Addr_FD01 ; save the current value in working storage
                    stu       Data_0300 ; save the current value in working storage
                    stu       Addr_FD01 ; save the current value in working storage
                    stu       Addr_0100 ; save the current value in working storage
                    stu       Addr_0100 ; save the current value in working storage
                    stu       Addr_0100 ; save the current value in working storage
                    stu       Code_0E02 ; save the current value in working storage
                    neg       Addr_00FF ; form the two's-complement negative value
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    neg       Addr_00FF ; form the two's-complement negative value
                    orb       >Addr_00FF ; set the selected flag bits
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    neg       Addr_00FF ; form the two's-complement negative value
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    stu       >Addr_0001 ; save the current value in working storage
                    stu       >Addr_0001 ; save the current value in working storage
                    stu       >Addr_00FA ; save the current value in working storage
                    stu       >Addr_00FF ; save the current value in working storage
                    stu       >Addr_00FF ; save the current value in working storage
                    stu       >Addr_0003 ; save the current value in working storage
Code_2789           neg       Addr_00FF ; form the two's-complement negative value
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    neg       Addr_0001 ; form the two's-complement negative value
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    neg       Addr_0001 ; form the two's-complement negative value
                    stu       >Addr_0004 ; save the current value in working storage
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    neg       DeskMateService ; form the two's-complement negative value
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    stu       >Data_0096 ; save the current value in working storage
                    comb                ; invert every bit in the selected value
                    lbsr      Code_052B ; call the referenced helper routine
                    ldb       Data_004D ; load the value needed by the following operation
                    pshs      B         ; preserve the listed registers on the stack
                    lbsr      Code_2548 ; call the referenced helper routine
                    lbsr      Code_02C0 ; call the referenced helper routine
                    lda       Data_0049 ; load the value needed by the following operation
                    cmpa      #$09      ; compare against the limit and set condition flags
                    beq       Code_27B2 ; branch when the compared values are equal
                    lbsr      Code_0752 ; call the referenced helper routine
Code_27B2           leay      Code_2664,PCR ; form the referenced address without reading memory
                    bsr       Code_27BF ; call the referenced helper routine
                    puls      B         ; restore the listed registers from the stack
                    stb       Data_004D ; save the current value in working storage
                    lbra      Code_249C ; continue at the distant control-flow target
Code_27BF           lda       Data_0049 ; load the value needed by the following operation
                    pshs      U,X       ; preserve the listed registers on the stack
                    lbsr      Code_0327 ; call the referenced helper routine
                    puls      U,X       ; restore the listed registers from the stack
                    jmp       ,Y        ; dispatch control through the selected target
                    leau      Code_271B,PCR ; form the referenced address without reading memory
                    stu       Data_005F ; save the current value in working storage
                    leau      Data_3696,PCR ; form the referenced address without reading memory
                    stu       Data_0061 ; save the current value in working storage
                    bra       Code_27E1 ; continue at the selected control-flow target
                    ldu       #DeskMateService ; load the value needed by the following operation
                    stu       Data_005F ; save the current value in working storage
                    ldu       Data_004E ; load the value needed by the following operation
                    stu       Data_0061 ; save the current value in working storage
Code_27E1           leau      Code_2B51,PCR ; form the referenced address without reading memory
                    stu       Data_0063 ; save the current value in working storage
                    bra       Code_281F ; continue at the selected control-flow target
                    ldu       #DeskMateService ; load the value needed by the following operation
                    stu       Data_005F ; save the current value in working storage
                    ldu       Data_004E ; load the value needed by the following operation
                    stu       Data_0061 ; save the current value in working storage
                    leau      Data_2B44,PCR ; form the referenced address without reading memory
                    stu       Data_0063 ; save the current value in working storage
                    bra       Code_281F ; continue at the selected control-flow target
                    leau      Addr_2743,PCR ; form the referenced address without reading memory
                    stu       Data_005F ; save the current value in working storage
                    leau      $01,U     ; form the referenced address without reading memory
                    clrb                ; clear the selected byte or register
                    lda       Data_00A1 ; load the value needed by the following operation
                    cmpa      #$01      ; compare against the limit and set condition flags
                    beq       Code_280A ; branch when the compared values are equal
                    comb                ; invert every bit in the selected value
Code_280A           lda       #$0C      ; load the value needed by the following operation
Code_280C           stb       $02,U     ; save the current value in working storage
                    leau      $03,U     ; form the referenced address without reading memory
                    deca                ; decrement the selected counter
                    bne       Code_280C ; branch when the compared values differ
                    leau      Addr_2793,PCR ; form the referenced address without reading memory
                    stu       Data_0061 ; save the current value in working storage
                    leau      Data_2B83,PCR ; form the referenced address without reading memory
                    stu       Data_0063 ; save the current value in working storage
Code_281F           lbra      Code_297D ; continue at the distant control-flow target
                    leau      Code_304B,PCR ; form the referenced address without reading memory
                    stu       Data_004B ; save the current value in working storage
                    bra       Code_2848 ; continue at the selected control-flow target
                    clr       Data_0024 ; clear the selected byte or register
                    com       Data_0024 ; invert every bit in the selected value
                    bra       Code_2832 ; continue at the selected control-flow target
                    clr       Data_0024 ; clear the selected byte or register
Code_2832           leau      Code_2FD7,PCR ; form the referenced address without reading memory
                    stu       Data_004B ; save the current value in working storage
                    bra       Code_2848 ; continue at the selected control-flow target
                    clr       Data_0024 ; clear the selected byte or register
                    com       Data_0024 ; invert every bit in the selected value
                    bra       Code_2842 ; continue at the selected control-flow target
                    clr       Data_0024 ; clear the selected byte or register
Code_2842           leau      Data_317E,PCR ; form the referenced address without reading memory
                    stu       Data_004B ; save the current value in working storage
Code_2848           leau      Addr_2768,PCR ; form the referenced address without reading memory
                    stu       Data_005F ; save the current value in working storage
                    lbra      Code_2EBB ; continue at the distant control-flow target
                    leau      Addr_2768,PCR ; form the referenced address without reading memory
                    stu       Data_005F ; save the current value in working storage
                    lbra      Code_2FA5 ; continue at the distant control-flow target
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $26,$02,$86,$01,$16,$D8 ; table, bitmap, or initialized data bytes
                    fcc       "j("                           ; embedded text or resource bytes
                    fcb       $10,$01,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$A0,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0A,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
Code_2877           ldy       Data_00B1 ; load the value needed by the following operation
Code_287A           ldb       Data_003F ; load the value needed by the following operation
                    lda       #$50      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    leay      D,Y       ; form the referenced address without reading memory
                    lda       Data_0040 ; load the value needed by the following operation
                    leay      A,Y       ; form the referenced address without reading memory
                    rts                 ; return to the caller
                    fcb       $17,$DE,$C9 ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $8D,$0E,$09,$DF ; table, bitmap, or initialized data bytes
                    fcc       "a"                            ; embedded text or resource bytes
                    fcb       $CC,$00,$1D,$DD ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $CC,$00   ; table, bitmap, or initialized data bytes
                    fcc       ":"                            ; embedded text or resource bytes
                    fcb       $ED,$8D,$0B,$D2,$DE,$A2 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C9       ; table, bitmap, or initialized data bytes
                    fcc       "G"                            ; embedded text or resource bytes
                    fcb       $90,$8D   ; table, bitmap, or initialized data bytes
                    fcc       "00"                           ; embedded text or resource bytes
                    fcb       $C9       ; table, bitmap, or initialized data bytes
                    fcc       "H"                            ; embedded text or resource bytes
                    fcb       $93,$8D   ; table, bitmap, or initialized data bytes
                    fcc       "*0"                           ; embedded text or resource bytes
                    fcb       $C9       ; table, bitmap, or initialized data bytes
                    fcc       "I"                            ; embedded text or resource bytes
                    fcb       $96,$8D   ; table, bitmap, or initialized data bytes
                    fcc       "$0"                           ; embedded text or resource bytes
                    fcb       $C9       ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $99,$8D,$1E ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C9       ; table, bitmap, or initialized data bytes
                    fcc       "K"                            ; embedded text or resource bytes
                    fcb       $9C,$8D,$18,$C6,$AA,$8E ; table, bitmap, or initialized data bytes
                    fcb       $00,$E5,$10,$8E,$00,$10 ; table, bitmap, or initialized data bytes
                    fcb       $CE,$00   ; table, bitmap, or initialized data bytes
                    fcc       "x"                            ; embedded text or resource bytes
                    fcb       $17,$D7   ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $12,$8E,$01 ; table, bitmap, or initialized data bytes
                    fcc       "h"                            ; embedded text or resource bytes
                    fcb       $17,$D7   ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $12       ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $8D       ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $8D,$22,$8D,$17,$8B,$00 ; table, bitmap, or initialized data bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $8D,$1A,$8D,$18,$17,$FF ; table, bitmap, or initialized data bytes
                    fcb       $93,$86,$AA,$C6,$10,$A7 ; table, bitmap, or initialized data bytes
                    fcb       $A0       ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $26,$FB,$0C ; table, bitmap, or initialized data bytes
                    fcc       "?9"                           ; embedded text or resource bytes
                    fcb       $DC       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $8B,$10,$17,$D7,$1D,$0D ; table, bitmap, or initialized data bytes
                    fcc       "94"                           ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "e"                            ; embedded text or resource bytes
                    fcb       $8D,$EF,$0C ; table, bitmap, or initialized data bytes
                    fcc       "?5"                           ; embedded text or resource bytes
                    fcb       $90,$96   ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $16,$D7,$D6,$96 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $16,$D7,$D2 ; table, bitmap, or initialized data bytes
Code_2913           pshs      U,X,D     ; preserve the listed registers on the stack
                    lda       Data_0035 ; load the value needed by the following operation
                    lbsr      Code_00E7 ; call the referenced helper routine
                    puls      PC,U,X,D  ; restore the listed registers from the stack
                    fcb       $17,$0C   ; table, bitmap, or initialized data bytes
                    fcc       "E"                            ; embedded text or resource bytes
                    fcb       $AE,$C9   ; table, bitmap, or initialized data bytes
                    neg       Addr_0008 ; form the two's-complement negative value
Code_2923           pshs      X         ; preserve the listed registers on the stack
                    lbsr      Code_3483 ; call the referenced helper routine
                    puls      X         ; restore the listed registers from the stack
                    cmpb      #$0D      ; compare against the limit and set condition flags
                    beq       Code_2936 ; branch when the compared values are equal
                    cmpb      #$05      ; compare against the limit and set condition flags
                    bne       Code_2923 ; branch when the compared values differ
                    stx       >$0008,U  ; save the current value in working storage
Code_2936           bra       Code_2913 ; continue at the selected control-flow target
                    fcb       $17,$DE   ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $8D,$CF,$17,$FF ; table, bitmap, or initialized data bytes
                    fcc       "F3"                           ; embedded text or resource bytes
                    fcb       $8D,$0B   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $17,$0C,$1D,$AE,$C9,$00 ; table, bitmap, or initialized data bytes
                    fcb       $08       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $10,$17,$0B ; table, bitmap, or initialized data bytes
                    fcc       "35"                           ; embedded text or resource bytes
                    fcb       $10,$C1,$0D ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $11,$C1,$05 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $1C,$C1,$AF,$26,$ED,$AF ; table, bitmap, or initialized data bytes
                    fcb       $C9,$00,$08,$86,$02,$16 ; table, bitmap, or initialized data bytes
                    fcb       $DA,$F5,$8D,$AA,$D6 ; table, bitmap, or initialized data bytes
                    fcc       "I"                            ; embedded text or resource bytes
                    fcb       $D7       ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "I1"                           ; embedded text or resource bytes
                    fcb       $8D,$FC,$D3,$16,$FE ; table, bitmap, or initialized data bytes
                    fcc       "I"                            ; embedded text or resource bytes
                    fcb       $AF,$C9,$00,$08,$8D,$97 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
Code_297D           clr       Data_0059 ; clear the selected byte or register
                    clr       Data_0066 ; clear the selected byte or register
                    clr       Data_005B ; clear the selected byte or register
                    clr       Data_005C ; clear the selected byte or register
                    ldx       Data_0055 ; load the value needed by the following operation
                    ldy       Data_0057 ; load the value needed by the following operation
                    tst       Data_0052 ; set condition flags from the current value
                    beq       Code_2998 ; branch when the compared values are equal
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Data_0054 ; save the current value in working storage
                    lbsr      Code_2C7A ; call the referenced helper routine
                    lbra      Code_2A2C ; continue at the distant control-flow target
Code_2998           stx       Data_0041 ; save the current value in working storage
                    sty       Data_0043 ; save the current value in working storage
                    lda       #$01      ; load the value needed by the following operation
                    sta       Data_006F ; save the current value in working storage
                    lbsr      Code_2A6C ; call the referenced helper routine
                    ldb       Data_0049 ; load the value needed by the following operation
                    cmpb      #$01      ; compare against the limit and set condition flags
                    bne       Code_29B9 ; branch when the compared values differ
                    clr       Data_0065 ; clear the selected byte or register
                    lbsr      Code_2AB9 ; call the referenced helper routine
                    bra       Code_29C8 ; continue at the selected control-flow target
Code_29B1           ldb       Data_0049 ; load the value needed by the following operation
                    cmpb      #$01      ; compare against the limit and set condition flags
                    beq       Code_29C8 ; branch when the compared values are equal
                    clr       Data_006F ; clear the selected byte or register
Code_29B9           clr       Data_0025 ; clear the selected byte or register
                    lda       Data_0066 ; load the value needed by the following operation
                    sta       Data_002C ; save the current value in working storage
                    com       Data_0066 ; invert every bit in the selected value
                    lda       #$01      ; load the value needed by the following operation
                    sta       Data_0065 ; save the current value in working storage
                    lbsr      Code_2AB9 ; call the referenced helper routine
Code_29C8           inc       Data_005D ; advance the selected counter
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    lbsr      Code_2DC3 ; call the referenced helper routine
                    bcc       Code_29D7 ; branch when carry is clear
                    rts                 ; return to the caller
Code_29D5           bra       Code_2A52 ; continue at the selected control-flow target
Code_29D7           ldu       Data_0050 ; load the value needed by the following operation
                    jsr       ,U        ; call the referenced helper routine
                    cmpx      Data_0041 ; compare against the limit and set condition flags
                    bne       Code_29EC ; branch when the compared values differ
                    cmpy      Data_0043 ; compare against the limit and set condition flags
                    bne       Code_29EC ; branch when the compared values differ
                    tst       Data_0059 ; set condition flags from the current value
                    beq       Code_29B1 ; branch when the compared values are equal
                    tst       Data_005C ; set condition flags from the current value
                    bne       Code_29B1 ; branch when the compared values differ
Code_29EC           stx       Data_0045 ; save the current value in working storage
                    tst       Data_0059 ; set condition flags from the current value
                    beq       Code_2A26 ; branch when the compared values are equal
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Data_005C ; save the current value in working storage
                    cmpy      #Addr_0010 ; compare against the limit and set condition flags
                    bcc       Code_2A00 ; branch when carry is clear
                    ldy       #Addr_0010 ; load the value needed by the following operation
Code_2A00           sty       Data_0047 ; save the current value in working storage
                    bsr       Code_2A52 ; call the referenced helper routine
                    tst       Data_005B ; set condition flags from the current value
                    bne       Code_2A0E ; branch when the compared values differ
                    com       Data_005B ; invert every bit in the selected value
                    lbsr      Code_077D ; call the referenced helper routine
Code_2A0E           clr       Data_006F ; clear the selected byte or register
                    clr       Data_0065 ; clear the selected byte or register
                    leau      Code_2B51,PCR ;2A12: 33 8D 01 3B    '3.. ; form the referenced address without reading memory
                    cmpu      Data_0063 ; compare against the limit and set condition flags
                    bne       Code_2A1D ; branch when the compared values differ
                    com       Data_0065 ; invert every bit in the selected value
Code_2A1D           lbsr      Code_02C0 ; call the referenced helper routine
                    lbsr      Code_304B ; call the referenced helper routine
                    lbra      Code_2998 ; continue at the distant control-flow target
Code_2A26           bsr       Code_2A52 ; call the referenced helper routine
                    clr       Data_005C ; clear the selected byte or register
                    clr       Data_005B ; clear the selected byte or register
Code_2A2C           cmpy      #Addr_0010 ; compare against the limit and set condition flags
                    lbcc      Code_2998 ; take the distant branch when carry is clear
                    lbsr      Code_2C7A ; call the referenced helper routine
                    cmpy      #Addr_0010 ; compare against the limit and set condition flags
                    lbcs      Code_29D5 ; take the distant branch when carry reports an error
                    ldx       Data_0045 ; load the value needed by the following operation
                    ldy       #Addr_0010 ; load the value needed by the following operation
                    lbra      Code_2998 ; continue at the distant control-flow target
Code_2A48           pshs      X         ; preserve the listed registers on the stack
                    ldx       Data_0069 ; load the value needed by the following operation
                    ldd       Data_0067 ; load the value needed by the following operation
                    std       Data_0069 ; save the current value in working storage
                    bra       Code_2A5C ; continue at the selected control-flow target
Code_2A52           bsr       Code_2A48 ; call the referenced helper routine
Code_2A54           pshs      X         ; preserve the listed registers on the stack
                    ldx       Data_006D ; load the value needed by the following operation
                    ldd       Data_006B ; load the value needed by the following operation
                    std       Data_006D ; save the current value in working storage
Code_2A5C           std       start     ; save the current value in working storage
Code_2A5E           cmpx      start     ; compare against the limit and set condition flags
                    beq       Code_2A6A ; branch when the compared values are equal
                    ldu       ,--X      ; load the value needed by the following operation
                    lda       ,-X       ; load the value needed by the following operation
                    sta       ,U        ; save the current value in working storage
                    bra       Code_2A5E ; continue at the selected control-flow target
Code_2A6A           puls      PC,X      ; restore the listed registers from the stack
Code_2A6C           pshs      Y,X       ; preserve the listed registers on the stack
                    ldu       Data_005F ; load the value needed by the following operation
                    beq       Code_2A84 ; branch when the compared values are equal
                    lda       ,U+       ; fetch the next value and advance the source pointer
                    sta       Addr_0010 ; save the current value in working storage
Code_2A76           ldd       ,U++      ; fetch the next value and advance the source pointer
                    leax      A,X       ; form the referenced address without reading memory
                    leay      B,Y       ; form the referenced address without reading memory
                    ldb       ,U+       ; fetch the next value and advance the source pointer
                    bsr       Code_2A86 ; call the referenced helper routine
                    dec       Addr_0010 ; decrement the selected counter
                    bne       Code_2A76 ; branch when the compared values differ
Code_2A84           puls      PC,Y,X    ; restore the listed registers from the stack
Code_2A86           lbsr      Code_2BBE ; call the referenced helper routine
                    pshs      U,B       ; preserve the listed registers on the stack
                    lbsr      Code_2BF4 ; call the referenced helper routine
                    pshs      X         ; preserve the listed registers on the stack
                    ldx       Data_006D ; load the value needed by the following operation
                    bsr       Code_2AA2 ; call the referenced helper routine
                    stx       Data_006D ; save the current value in working storage
                    puls      X         ; restore the listed registers from the stack
                    lbsr      Code_2C0F ; call the referenced helper routine
                    andb      ,S+       ; mask off unwanted bits
                    lbsr      Code_2B55 ; call the referenced helper routine
                    puls      PC,U      ; restore the listed registers from the stack
Code_2AA2           cmpu      -$02,X    ; compare against the limit and set condition flags
                    beq       Code_2AB8 ; branch when the compared values are equal
                    pshs      X         ; preserve the listed registers on the stack
                    leax      -$18,S    ; form the referenced address without reading memory
                    cmpx      ,S        ; compare against the limit and set condition flags
                    puls      X         ; restore the listed registers from the stack
                    bcs       Code_2AB8 ; branch when carry reports an unsigned underflow or error
                    lda       ,U        ; load the value needed by the following operation
                    sta       ,X+       ; store the value and advance the destination pointer
                    stu       ,X++      ; store the value and advance the destination pointer
Code_2AB8           rts                 ; return to the caller
Code_2AB9           pshs      Y,X       ; preserve the listed registers on the stack
                    ldu       Data_0061 ; load the value needed by the following operation
                    lda       ,U+       ; fetch the next value and advance the source pointer
                    sta       Addr_0010 ; save the current value in working storage
                    tst       Data_0093 ; set condition flags from the current value
                    beq       Code_2B1B ; branch when the compared values are equal
Code_2AC5           lbsr      Code_1F27 ; call the referenced helper routine
                    ldd       ,U++      ; fetch the next value and advance the source pointer
                    leax      A,X       ; form the referenced address without reading memory
                    leay      B,Y       ; form the referenced address without reading memory
                    dec       Addr_0010 ; decrement the selected counter
                    bne       Code_2AC5 ; branch when the compared values differ
                    puls      PC,Y,X    ; restore the listed registers from the stack
Code_2AD4           bsr       Code_2AE2 ; call the referenced helper routine
                    ldd       ,U++      ; fetch the next value and advance the source pointer
                    leax      A,X       ; form the referenced address without reading memory
                    leay      B,Y       ; form the referenced address without reading memory
                    dec       Addr_0010 ; decrement the selected counter
                    bne       Code_2AD4 ; branch when the compared values differ
                    puls      PC,Y,X    ; restore the listed registers from the stack
Code_2AE2           lbsr      Code_2BC5 ; call the referenced helper routine
                    pshs      U         ; preserve the listed registers on the stack
                    lbsr      Code_2BF4 ; call the referenced helper routine
                    tst       Data_006F ; set condition flags from the current value
                    beq       Code_2AF8 ; branch when the compared values are equal
                    pshs      X         ; preserve the listed registers on the stack
                    ldx       Data_0069 ; load the value needed by the following operation
                    bsr       Code_2AA2 ; call the referenced helper routine
                    stx       Data_0069 ; save the current value in working storage
                    puls      X         ; restore the listed registers from the stack
Code_2AF8           pshs      Y         ; preserve the listed registers on the stack
                    tfr       X,D       ; copy the source register into the destination register
                    andb      Data_0036 ; mask off unwanted bits
                    ldy       Data_0037 ; load the value needed by the following operation
                    ldb       B,Y       ; load the value needed by the following operation
                    tfr       B,A       ; copy the source register into the destination register
                    puls      Y         ; restore the listed registers from the stack
                    tst       Data_0065 ; set condition flags from the current value
                    bne       Code_2B17 ; branch when the compared values differ
                    pshs      X,D       ; preserve the listed registers on the stack
                    ldd       Data_0063 ; load the value needed by the following operation
                    std       $02,S     ; save the current value in working storage
                    puls      D         ; restore the listed registers from the stack
                    jsr       [,S]      ; call the referenced helper routine
                    puls      PC,U,D    ; restore the listed registers from the stack
Code_2B17           bsr       Code_2B51 ; call the referenced helper routine
                    puls      PC,U      ; restore the listed registers from the stack
Code_2B1B           tst       Data_006F ; set condition flags from the current value
                    bne       Code_2AD4 ; branch when the compared values differ
                    tst       Data_0065 ; set condition flags from the current value
                    beq       Code_2AD4 ; branch when the compared values are equal
Code_2B23           lbsr      Code_2C1D ; call the referenced helper routine
                    ldd       ,U++      ; fetch the next value and advance the source pointer
                    leax      A,X       ; form the referenced address without reading memory
                    leay      B,Y       ; form the referenced address without reading memory
                    dec       Addr_0010 ; decrement the selected counter
                    bne       Code_2B23 ; branch when the compared values differ
                    puls      PC,Y,X    ; restore the listed registers from the stack
Code_2B32           sta       >Addr_2B41,PCR ; save the current value in working storage
                    lda       #$C9      ; load the value needed by the following operation
                    ldb       Data_005D ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    addd      #Addr_000D ; add the operand to the running value
                    stb       Data_005D ; save the current value in working storage
                    lda       #$05      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    rts                 ; return to the caller
Data_2B44           fcc       "4"                            ; embedded text or resource bytes
                    fcb       $06,$86,$0F,$8D,$E8,$91 ; table, bitmap, or initialized data bytes
                    fcc       "^5"                           ; embedded text or resource bytes
                    fcb       $06       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
Code_2B51           bsr       Code_2B5F ; call the referenced helper routine
Code_2B53           andb      Data_002C ; mask off unwanted bits
Code_2B55           coma                ; invert every bit in the selected value
                    anda      ,U        ; mask off unwanted bits
                    stb       ,-S       ; save the current value in working storage
                    ora       ,S+       ; set the selected flag bits
                    sta       ,U        ; save the current value in working storage
                    rts                 ; return to the caller
Code_2B5F           tst       Data_0025 ; set condition flags from the current value
                    beq       Code_2B82 ; branch when the compared values are equal
                    pshs      U,D       ; preserve the listed registers on the stack
                    tfr       X,D       ; copy the source register into the destination register
                    andb      Data_0027 ; mask off unwanted bits
                    lsrb                ; shift right and expose the low bit through carry
                    tst       Data_0034 ; set condition flags from the current value
                    bne       Code_2B6F ; branch when the compared values differ
                    lsrb                ; shift right and expose the low bit through carry
Code_2B6F           stb       ,-S       ; save the current value in working storage
                    tfr       Y,D       ; copy the source register into the destination register
                    andb      Data_0026 ; mask off unwanted bits
                    lda       Data_0028 ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    addb      ,S+       ; add the operand to the running value
                    ldu       Data_0029 ; load the value needed by the following operation
                    lda       B,U       ; load the value needed by the following operation
                    sta       Data_002C ; save the current value in working storage
                    puls      PC,U,D    ; restore the listed registers from the stack
Code_2B82           rts                 ; return to the caller
Data_2B83           fcb       $D4,$A0   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $CE       ; table, bitmap, or initialized data bytes
Data_2B87           fcc       "4"                            ; embedded text or resource bytes
                    fcb       $02,$96,$0C,$81,$02 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $04,$0F,$0C,$03 ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $0C,$0C   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $BA       ; table, bitmap, or initialized data bytes
Code_2B99           cmpy      #Addr_0004 ; compare against the limit and set condition flags
                    blt       Code_2BB7 ; branch when the signed value is below the limit
                    cmpx      #Data_0028 ; compare against the limit and set condition flags
                    bge       Code_2BB7 ; branch when the signed value is at least the limit
                    stx       -$02,S    ; save the current value in working storage
                    blt       Code_2BB7 ; branch when the signed value is below the limit
                    cmpy      #Data_0032 ; compare against the limit and set condition flags
                    bge       Code_2BB7 ; branch when the signed value is at least the limit
                    rts                 ; return to the caller
Code_2BAF           bsr       Code_2BC5 ; call the referenced helper routine
                    bsr       Code_2BF4 ; call the referenced helper routine
                    bsr       Code_2C0F ; call the referenced helper routine
                    bra       Code_2B53 ; continue at the selected control-flow target
Code_2BB7           leas      $02,S     ; form the referenced address without reading memory
                    lda       #$FF      ; load the value needed by the following operation
                    andcc     #$FB      ; mask off unwanted bits
                    rts                 ; return to the caller
Code_2BBE           sty       -$02,S    ; save the current value in working storage
                    blt       Code_2BB7 ; branch when the signed value is below the limit
                    bra       Code_2BCB ; continue at the selected control-flow target
Code_2BC5           cmpy      #Addr_0010 ; compare against the limit and set condition flags
                    blt       Code_2BB7 ; branch when the signed value is below the limit
Code_2BCB           cmpx      Data_0039 ; compare against the limit and set condition flags
                    bge       Code_2BB7 ; branch when the signed value is at least the limit
                    stx       -$02,S    ; save the current value in working storage
                    blt       Code_2BB7 ; branch when the signed value is below the limit
                    cmpy      #Data_00C0 ; compare against the limit and set condition flags
                    bge       Code_2BB7 ; branch when the signed value is at least the limit
                    rts                 ; return to the caller
Code_2BDA           bsr       Code_2BC5 ; call the referenced helper routine
                    bsr       Code_2BF4 ; call the referenced helper routine
Code_2BDE           bsr       Code_2C0F ; call the referenced helper routine
                    pshs      D         ; preserve the listed registers on the stack
                    anda      ,U        ; mask off unwanted bits
                    andb      Addr_0008 ; mask off unwanted bits
                    stb       ,-S       ; save the current value in working storage
                    cmpa      ,S+       ; compare against the limit and set condition flags
                    puls      PC,D      ; restore the listed registers from the stack
Code_2BEC           ldu       Data_00B3 ; load the value needed by the following operation
                    leau      $FB00,U   ; form the referenced address without reading memory
                    bra       Code_2BF6 ; continue at the selected control-flow target
Code_2BF4           ldu       Data_00AF ; load the value needed by the following operation
Code_2BF6           tfr       Y,D       ; copy the source register into the destination register
                    lda       #$50      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    leau      D,U       ; form the referenced address without reading memory
                    ldb       Data_0036 ; load the value needed by the following operation
                    stb       ,-S       ; save the current value in working storage
                    tfr       X,D       ; copy the source register into the destination register
Code_2C03           lsra                ; shift right and expose the low bit through carry
                    rorb                ; rotate right through carry
                    lsr       ,S        ; shift right and expose the low bit through carry
                    bne       Code_2C03 ; branch when the compared values differ
                    leau      D,U       ; form the referenced address without reading memory
                    stu       Data_002D ; save the current value in working storage
                    puls      PC,A      ; restore the listed registers from the stack
Code_2C0F           pshs      U         ; preserve the listed registers on the stack
                    tfr       X,D       ; copy the source register into the destination register
                    andb      Data_0036 ; mask off unwanted bits
                    ldu       Data_0037 ; load the value needed by the following operation
                    ldb       B,U       ; load the value needed by the following operation
                    tfr       B,A       ; copy the source register into the destination register
                    puls      PC,U      ; restore the listed registers from the stack
Code_2C1D           bsr       Code_2BC5 ; call the referenced helper routine
                    pshs      U         ; preserve the listed registers on the stack
                    ldu       Data_00AF ; load the value needed by the following operation
                    tfr       Y,D       ; copy the source register into the destination register
                    lda       #$50      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    leau      D,U       ; form the referenced address without reading memory
                    ldb       Data_0036 ; load the value needed by the following operation
                    stb       ,-S       ; save the current value in working storage
                    tfr       X,D       ; copy the source register into the destination register
Code_2C30           lsra                ; shift right and expose the low bit through carry
                    rorb                ; rotate right through carry
                    lsr       ,S        ; shift right and expose the low bit through carry
                    bne       Code_2C30 ; branch when the compared values differ
                    leau      D,U       ; form the referenced address without reading memory
                    stu       Data_002D ; save the current value in working storage
                    puls      A         ; restore the listed registers from the stack
                    pshs      U         ; preserve the listed registers on the stack
                    tfr       X,D       ; copy the source register into the destination register
                    andb      Data_0036 ; mask off unwanted bits
                    ldu       Data_0037 ; load the value needed by the following operation
                    ldb       B,U       ; load the value needed by the following operation
                    tfr       B,A       ; copy the source register into the destination register
                    puls      U         ; restore the listed registers from the stack
                    tst       Data_0025 ; set condition flags from the current value
                    beq       Code_2C6D ; branch when the compared values are equal
                    pshs      U,D       ; preserve the listed registers on the stack
                    tfr       X,D       ; copy the source register into the destination register
                    andb      Data_0027 ; mask off unwanted bits
                    lsrb                ; shift right and expose the low bit through carry
                    tst       Data_0034 ; set condition flags from the current value
                    bne       Code_2C5A ; branch when the compared values differ
                    lsrb                ; shift right and expose the low bit through carry
Code_2C5A           stb       ,-S       ; save the current value in working storage
                    tfr       Y,D       ; copy the source register into the destination register
                    andb      Data_0026 ; mask off unwanted bits
                    lda       Data_0028 ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    addb      ,S+       ; add the operand to the running value
                    ldu       Data_0029 ; load the value needed by the following operation
                    lda       B,U       ; load the value needed by the following operation
                    sta       Data_002C ; save the current value in working storage
                    puls      U,D       ; restore the listed registers from the stack
Code_2C6D           andb      Data_002C ; mask off unwanted bits
                    coma                ; invert every bit in the selected value
                    anda      ,U        ; mask off unwanted bits
                    stb       ,-S       ; save the current value in working storage
                    ora       ,S+       ; set the selected flag bits
                    sta       ,U        ; save the current value in working storage
                    puls      PC,U      ; restore the listed registers from the stack
Code_2C7A           stx       start     ; save the current value in working storage
                    bsr       Code_2CB6 ; call the referenced helper routine
                    pshs      A         ; preserve the listed registers on the stack
                    tfr       B,A       ; copy the source register into the destination register
                    aslb                ; shift left and update carry
                    cmpa      Data_0054 ; compare against the limit and set condition flags
                    bne       Code_2C8B ; branch when the compared values differ
                    ldx       start     ; load the value needed by the following operation
                    bra       Code_2CA2 ; continue at the selected control-flow target
Code_2C8B           bcs       Code_2C8E ; branch when carry reports an unsigned underflow or error
                    incb                ; advance the selected counter
Code_2C8E           sta       Data_0054 ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    tst       Data_0034 ; set condition flags from the current value
                    bne       Code_2CA0 ; branch when the compared values differ
                    aslb                ; shift left and update carry
                    rola                ; rotate left through carry
                    cmpd      #Code_013C ; compare against the limit and set condition flags
                    bne       Code_2CA0 ; branch when the compared values differ
                    addd      #Addr_0002 ; add the operand to the running value
Code_2CA0           tfr       D,X       ; copy the source register into the destination register
Code_2CA2           puls      B         ; restore the listed registers from the stack
                    lda       #$03      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    addd      #Addr_0001 ; add the operand to the running value
                    cmpd      #Data_00BE ; compare against the limit and set condition flags
                    bne       Code_2CB3 ; branch when the compared values differ
                    addd      #Addr_0001 ; add the operand to the running value
Code_2CB3           tfr       D,Y       ; copy the source register into the destination register
                    rts                 ; return to the caller
Code_2CB6           pshs      Y,X       ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $19       ; private DeskMate service selector
                    std       Data_0059 ; save the current value in working storage
                    tfr       U,D       ; copy the source register into the destination register
                    clra                ; clear the selected byte or register
                    leax      >Data_2CD3,PCR ; form the referenced address without reading memory
                    bsr       Code_2CD7 ; call the referenced helper routine
                    pshs      B         ; preserve the listed registers on the stack
                    tfr       Y,D       ; copy the source register into the destination register
                    bsr       Code_2CD7 ; call the referenced helper routine
                    tfr       B,A       ; copy the source register into the destination register
                    puls      PC,Y,X,B  ; restore the listed registers from the stack
                    fcb       $00,$00   ; table, bitmap, or initialized data bytes
Data_2CD3           fcb       $FF,$FF,$00,$00 ; table, bitmap, or initialized data bytes
Code_2CD7           cmpb      ,-X       ; compare against the limit and set condition flags
                    beq       Code_2CE5 ; branch when the compared values are equal
                    cmpb      $02,X     ; compare against the limit and set condition flags
                    beq       Code_2CE8 ; branch when the compared values are equal
Code_2CDF           lda       ,X        ; load the value needed by the following operation
                    sta       $02,X     ; save the current value in working storage
                    stb       ,X        ; save the current value in working storage
Code_2CE5           clr       $04,X     ; clear the selected byte or register
                    rts                 ; return to the caller
Code_2CE8           inc       $04,X     ; advance the selected counter
                    lda       $04,X     ; load the value needed by the following operation
                    cmpa      #$05      ; compare against the limit and set condition flags
                    beq       Code_2CDF ; branch when the compared values are equal
                    ldb       ,X        ; load the value needed by the following operation
                    rts                 ; return to the caller
                    fcb       $8D,$C1,$1F,$13,$8D,$1B ; table, bitmap, or initialized data bytes
                    fcb       $1F       ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $1E,$89,$1F ; table, bitmap, or initialized data bytes
                    fcc       "#"                            ; embedded text or resource bytes
                    fcb       $8D,$13,$1F ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $8D       ; table, bitmap, or initialized data bytes
                    fcc       "y"                            ; embedded text or resource bytes
                    fcb       $17,$00,$9C,$CE,$05,$DC ; table, bitmap, or initialized data bytes
                    fcc       "3_"                           ; embedded text or resource bytes
                    fcb       $11,$83,$00,$00,$26,$F8 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $C1,$03,$22,$04 ; table, bitmap, or initialized data bytes
                    fcc       "3_ "                          ; embedded text or resource bytes
                    fcb       $06,$C1   ; table, bitmap, or initialized data bytes
                    fcc       "<%"                           ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "3A9"                          ; embedded text or resource bytes
Code_2D23           cmpa      ,U+       ; compare against the limit and set condition flags
                    bne       Code_2D29 ; branch when the compared values differ
                    leay      B,Y       ; form the referenced address without reading memory
Code_2D29           cmpa      ,U+       ; compare against the limit and set condition flags
                    bne       Code_2D2F ; branch when the compared values differ
                    leax      B,X       ; form the referenced address without reading memory
Code_2D2F           negb                ; form the two's-complement negative value
                    cmpa      ,U+       ; compare against the limit and set condition flags
                    bne       Code_2D36 ; branch when the compared values differ
                    leay      B,Y       ; form the referenced address without reading memory
Code_2D36           cmpa      ,U+       ; compare against the limit and set condition flags
                    bne       Code_2D3C ; branch when the compared values differ
                    leax      B,X       ; form the referenced address without reading memory
Code_2D3C           rts                 ; return to the caller
                    fcb       $81,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $04,$81   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $26,$08,$03 ; table, bitmap, or initialized data bytes
                    fcc       "Y'"                           ; embedded text or resource bytes
                    fcb       $04,$C6,$01,$D7 ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $81,$12,$26,$05,$10,$8E ; table, bitmap, or initialized data bytes
                    fcb       $00,$BF   ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $81,$13,$26,$05,$10,$8E ; table, bitmap, or initialized data bytes
                    fcb       $00,$10   ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $81,$11,$26,$03,$9E ; table, bitmap, or initialized data bytes
                    fcc       "99"                           ; embedded text or resource bytes
                    fcb       $81,$10,$26,$04,$8E,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "93"                           ; embedded text or resource bytes
                    fcb       $8D,$00,$C5,$C6,$01,$8D ; table, bitmap, or initialized data bytes
                    fcb       $AD,$C6,$04,$8D,$A9,$8D ; table, bitmap, or initialized data bytes
                    fcb       $15       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $26,$8C,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $03,$8E,$00,$00,$10,$8C ; table, bitmap, or initialized data bytes
                    fcb       $00,$00   ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $04,$10,$8E,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $8C,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $03,$8E,$00,$00,$10,$8C ; table, bitmap, or initialized data bytes
                    fcb       $00,$10   ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $04,$10,$8E,$00,$10 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $9C       ; table, bitmap, or initialized data bytes
                    fcc       "9%"                           ; embedded text or resource bytes
                    fcb       $04,$9E   ; table, bitmap, or initialized data bytes
                    fcc       "90"                           ; embedded text or resource bytes
                    fcb       $1F,$10,$8C,$00,$C0 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $04,$10,$8E,$00,$BF ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
Code_2DB7           lbsr      Code_2A52 ; call the referenced helper routine
                    lbsr      Code_0777 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    lbsr      Code_045C ; call the referenced helper routine
                    bra       Code_2E09 ; continue at the selected control-flow target
Code_2DC3           pshs      U,Y,X,D   ; preserve the listed registers on the stack
                    cmpa      #$B2      ; compare against the limit and set condition flags
                    beq       Code_2E00 ; branch when the compared values are equal
                    cmpa      #$BA      ; compare against the limit and set condition flags
                    beq       Code_2E28 ; branch when the compared values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    beq       Code_2E1D ; branch when the compared values are equal
                    cmpa      #$8C      ; compare against the limit and set condition flags
                    beq       Code_2DDD ; branch when the compared values are equal
                    cmpa      #$AF      ; compare against the limit and set condition flags
                    beq       Code_2DB7 ; branch when the compared values are equal
                    andcc     #$FE      ; mask off unwanted bits
                    puls      PC,U,Y,X,D ; restore the listed registers from the stack
Code_2DDD           lda       Data_0052 ; load the value needed by the following operation
                    sta       Data_0053 ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    lbsr      Code_052B ; call the referenced helper routine
                    puls      U,Y,X,D   ; restore the listed registers from the stack
                    orcc      #$01      ; set the selected flag bits
                    pshs      CC        ; preserve the listed registers on the stack
Code_2DEB           stx       Data_0055 ; save the current value in working storage
                    sty       Data_0057 ; save the current value in working storage
                    lbsr      Code_2A52 ; call the referenced helper routine
                    pshs      A         ; preserve the listed registers on the stack
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Data_0042 ; save the current value in working storage
                    puls      A         ; restore the listed registers from the stack
                    lbsr      Code_0752 ; call the referenced helper routine
                    puls      PC,CC     ; restore the listed registers from the stack
Code_2E00           lbsr      Code_2A52 ; call the referenced helper routine
                    lbsr      Code_0777 ; call the referenced helper routine
                    lbsr      Code_0907 ; call the referenced helper routine
Code_2E09           lbsr      Code_076D ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    clr       Data_0059 ; clear the selected byte or register
                    clr       Data_005A ; clear the selected byte or register
                    puls      U,Y,X,D   ; restore the listed registers from the stack
                    andcc     #$FE      ; mask off unwanted bits
                    pshs      CC        ; preserve the listed registers on the stack
                    bra       Code_2DEB ; continue at the selected control-flow target
Code_2E1D           lbsr      Code_2A52 ; call the referenced helper routine
                    lbsr      Code_0777 ; call the referenced helper routine
                    lbsr      Code_0662 ; call the referenced helper routine
                    bra       Code_2E09 ; continue at the selected control-flow target
Code_2E28           lbsr      Code_2A52 ; call the referenced helper routine
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Data_0042 ; save the current value in working storage
                    lbsr      Code_04D6 ; call the referenced helper routine
                    lbsr      Code_0752 ; call the referenced helper routine
                    puls      PC,U,Y,X,D ; restore the listed registers from the stack
Data_2E37           fcb       $0A,$09,$0C,$08,$1A,$19 ; table, bitmap, or initialized data bytes
                    fcb       $1C,$18   ; table, bitmap, or initialized data bytes
Code_2E3F           clr       Data_0059 ; clear the selected byte or register
                    clr       Data_005A ; clear the selected byte or register
                    ldd       Data_0067 ; load the value needed by the following operation
                    std       Data_0069 ; save the current value in working storage
                    ldd       Data_006B ; load the value needed by the following operation
                    std       Data_006D ; save the current value in working storage
Code_2E4B           stx       Data_0041 ; save the current value in working storage
                    cmpy      #Addr_0010 ; compare against the limit and set condition flags
                    bcc       Code_2E64 ; branch when carry is clear
                    lbsr      Code_2C7A ; call the referenced helper routine
                    cmpy      #Addr_0010 ; compare against the limit and set condition flags
                    lbcs      Code_2E77 ; take the distant branch when carry reports an error
                    ldx       Data_0041 ; load the value needed by the following operation
                    ldy       #Addr_0010 ; load the value needed by the following operation
Code_2E64           sty       Data_0043 ; save the current value in working storage
                    lbsr      Code_2A54 ; call the referenced helper routine
                    lbsr      Code_2A6C ; call the referenced helper routine
Code_2E6D           clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    lbsr      Code_2DC3 ; call the referenced helper routine
                    bcc       Code_2E7D ; branch when carry is clear
Code_2E77           lbsr      Code_2A54 ; call the referenced helper routine
                    lda       #$FF      ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_2E7D           ldu       Data_0050 ; load the value needed by the following operation
                    jsr       ,U        ; call the referenced helper routine
                    lda       Data_0059 ; load the value needed by the following operation
                    bne       Code_2E90 ; branch when the compared values differ
Code_2E85           cmpx      Data_0041 ; compare against the limit and set condition flags
                    bne       Code_2E4B ; branch when the compared values differ
                    cmpy      Data_0043 ; compare against the limit and set condition flags
                    bne       Code_2E4B ; branch when the compared values differ
                    bra       Code_2E6D ; continue at the selected control-flow target
Code_2E90           pshs      Y,X       ; preserve the listed registers on the stack
                    ldx       #Addr_015E ; load the value needed by the following operation
Code_2E95           lda       Data_005A ; load the value needed by the following operation
                    bne       Code_2EAB ; branch when the compared values differ
                    leax      -$01,X    ; form the referenced address without reading memory
                    beq       Code_2EA7 ; branch when the compared values are equal
                    pshs      X         ; preserve the listed registers on the stack
                    ldu       Data_0050 ; load the value needed by the following operation
                    jsr       ,U        ; call the referenced helper routine
                    puls      X         ; restore the listed registers from the stack
                    bra       Code_2E95 ; continue at the selected control-flow target
Code_2EA7           puls      Y,X       ; restore the listed registers from the stack
                    bra       Code_2E85 ; continue at the selected control-flow target
Code_2EAB           puls      Y,X       ; restore the listed registers from the stack
                    stx       Data_0045 ; save the current value in working storage
                    sty       Data_0047 ; save the current value in working storage
                    clr       Data_0059 ; clear the selected byte or register
                    clr       Data_005A ; clear the selected byte or register
                    lbsr      Code_2A54 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
Code_2EBA           rts                 ; return to the caller
Code_2EBB           lda       #$FF      ; load the value needed by the following operation
                    sta       Addr_000F ; save the current value in working storage
                    sta       Data_0065 ; save the current value in working storage
                    sta       Data_0054 ; save the current value in working storage
                    sta       Data_006F ; save the current value in working storage
                    ldx       Data_0055 ; load the value needed by the following operation
                    ldy       Data_0057 ; load the value needed by the following operation
                    tst       Data_0052 ; set condition flags from the current value
                    beq       Code_2ED1 ; branch when the compared values are equal
                    lbsr      Code_2C7A ; call the referenced helper routine
Code_2ED1           leau      Data_3696,PCR ; form the referenced address without reading memory
                    stu       Data_0061 ; save the current value in working storage
                    clr       Data_0023 ; clear the selected byte or register
                    lbsr      Code_2E3F ; call the referenced helper routine
                    bne       Code_2EBA ; branch when the compared values differ
                    lbsr      Code_077D ; call the referenced helper routine
Code_2EE1           ldu       Data_004B ; load the value needed by the following operation
                    jsr       ,U        ; call the referenced helper routine
Code_2EE5           clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    cmpa      #$05      ; compare against the limit and set condition flags
                    beq       Code_2F3D ; branch when the compared values are equal
                    ldu       Data_0050 ; load the value needed by the following operation
                    jsr       ,U        ; call the referenced helper routine
                    cmpy      #Addr_0010 ; compare against the limit and set condition flags
                    bcc       Code_2EFC ; branch when carry is clear
                    ldy       #Addr_0010 ; load the value needed by the following operation
Code_2EFC           lda       Data_0049 ; load the value needed by the following operation
                    cmpa      #$06      ; compare against the limit and set condition flags
                    beq       Code_2F47 ; branch when the compared values are equal
                    lda       Data_005A ; load the value needed by the following operation
                    cmpa      #$01      ; compare against the limit and set condition flags
                    beq       Code_2F26 ; branch when the compared values are equal
Code_2F08           cmpx      Data_0045 ; compare against the limit and set condition flags
                    bne       Code_2F11 ; branch when the compared values differ
                    cmpy      Data_0047 ; compare against the limit and set condition flags
                    beq       Code_2EE5 ; branch when the compared values are equal
Code_2F11           stx       Data_0045 ; save the current value in working storage
                    sty       Data_0047 ; save the current value in working storage
                    lbsr      Code_2A48 ; call the referenced helper routine
                    bra       Code_2EE1 ; continue at the selected control-flow target
                    fcb       $9F       ; table, bitmap, or initialized data bytes
                    fcc       "E"                            ; embedded text or resource bytes
                    fcb       $10,$9F   ; table, bitmap, or initialized data bytes
                    fcc       "G"                            ; embedded text or resource bytes
                    fcb       $DC       ; table, bitmap, or initialized data bytes
                    fcc       "g"                            ; embedded text or resource bytes
                    fcb       $DD       ; table, bitmap, or initialized data bytes
                    fcc       "i "                           ; embedded text or resource bytes
                    fcb       $BB       ; table, bitmap, or initialized data bytes
Code_2F26           tst       Data_0024 ; set condition flags from the current value
                    beq       Code_2F2C ; branch when the compared values are equal
                    com       Data_0023 ; invert every bit in the selected value
Code_2F2C           lbsr      Code_2A48 ; call the referenced helper routine
                    clr       Data_006F ; clear the selected byte or register
                    ldu       Data_004E ; load the value needed by the following operation
                    stu       Data_0061 ; save the current value in working storage
                    ldu       Data_004B ; load the value needed by the following operation
                    jsr       ,U        ; call the referenced helper routine
                    com       Data_006F ; invert every bit in the selected value
Code_2F3B           bra       Code_2ED1 ; continue at the selected control-flow target
Code_2F3D           lbsr      Code_2A48 ; call the referenced helper routine
                    ldx       Data_0045 ; load the value needed by the following operation
                    ldy       Data_0047 ; load the value needed by the following operation
                    bra       Code_2F3B ; continue at the selected control-flow target
Code_2F47           lda       Data_005A ; load the value needed by the following operation
                    deca                ; decrement the selected counter
                    beq       Code_2F57 ; branch when the compared values are equal
                    deca                ; decrement the selected counter
                    beq       Code_2F7F ; branch when the compared values are equal
                    deca                ; decrement the selected counter
                    beq       Code_2F90 ; branch when the compared values are equal
                    deca                ; decrement the selected counter
                    beq       Code_2F9F ; branch when the compared values are equal
Code_2F55           bra       Code_2F08 ; continue at the selected control-flow target
Code_2F57           pshs      Y,X       ; preserve the listed registers on the stack
                    lbsr      Code_2A48 ; call the referenced helper routine
                    lbsr      Code_077D ; call the referenced helper routine
Code_2F5F           clr       Data_006F ; clear the selected byte or register
                    ldu       Data_004E ; load the value needed by the following operation
                    stu       Data_0061 ; save the current value in working storage
                    ldu       Data_004B ; load the value needed by the following operation
                    jsr       ,U        ; call the referenced helper routine
                    com       Data_006F ; invert every bit in the selected value
                    leau      Data_3696,PCR ; form the referenced address without reading memory
                    stu       Data_0061 ; save the current value in working storage
                    puls      Y,X       ; restore the listed registers from the stack
                    clr       Data_0059 ; clear the selected byte or register
                    clr       Data_005A ; clear the selected byte or register
                    stx       Data_0045 ; save the current value in working storage
                    sty       Data_0047 ; save the current value in working storage
                    lbra      Code_2EE1 ; continue at the distant control-flow target
Code_2F7F           pshs      Y,X       ; preserve the listed registers on the stack
                    lbsr      Code_2A48 ; call the referenced helper routine
Code_2F84           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $19       ; private DeskMate service selector
                    tsta                ; set condition flags from the current value
                    bne       Code_2F84 ; branch when the compared values differ
                    puls      Y,X       ; restore the listed registers from the stack
                    lbra      Code_2ED1 ; continue at the distant control-flow target
Code_2F90           tst       Addr_000F ; set condition flags from the current value
                    beq       Code_2F98 ; branch when the compared values are equal
                    clr       Addr_000F ; clear the selected byte or register
                    bra       Code_2F57 ; continue at the selected control-flow target
Code_2F98           pshs      Y,X       ; preserve the listed registers on the stack
                    lbsr      Code_2A48 ; call the referenced helper routine
                    bra       Code_2F5F ; continue at the selected control-flow target
Code_2F9F           lda       #$FF      ; load the value needed by the following operation
                    sta       Addr_000F ; save the current value in working storage
                    bra       Code_2F55 ; continue at the selected control-flow target
Code_2FA5           lda       #$FF      ; load the value needed by the following operation
                    sta       Data_0065 ; save the current value in working storage
                    sta       Data_0054 ; save the current value in working storage
                    clr       Data_006F ; clear the selected byte or register
                    ldx       Data_0055 ; load the value needed by the following operation
                    ldy       Data_0057 ; load the value needed by the following operation
                    tst       Data_0052 ; set condition flags from the current value
                    beq       Code_2FB9 ; branch when the compared values are equal
                    lbsr      Code_2C7A ; call the referenced helper routine
Code_2FB9           leau      Data_3696,PCR ; form the referenced address without reading memory
                    stu       Data_0061 ; save the current value in working storage
                    lbsr      Code_2E3F ; call the referenced helper routine
                    lbne      Code_2EBA ; take the distant branch when values differ
                    lbsr      Code_077D ; call the referenced helper routine
                    ldx       Data_0041 ; load the value needed by the following operation
                    ldy       Data_0043 ; load the value needed by the following operation
                    pshs      Y,X       ; preserve the listed registers on the stack
                    lbsr      Code_3349 ; call the referenced helper routine
                    puls      Y,X       ; restore the listed registers from the stack
                    bra       Code_2FB9 ; continue at the selected control-flow target
Code_2FD7           tst       Data_0023 ; set condition flags from the current value
                    beq       Code_300A ; branch when the compared values are equal
                    ldx       Data_0047 ; load the value needed by the following operation
                    ldd       Data_0043 ; load the value needed by the following operation
                    std       Data_0047 ; save the current value in working storage
                    pshs      X,D       ; preserve the listed registers on the stack
                    lda       #$01      ; load the value needed by the following operation
                    cmpx      Data_0043 ; compare against the limit and set condition flags
                    bhi       Code_2FEC ; branch when the unsigned value is above the limit
                    beq       Code_2FFF ; branch when the compared values are equal
                    nega                ; form the two's-complement negative value
Code_2FEC           ldx       Data_0043 ; load the value needed by the following operation
Code_2FEE           pshs      X,A       ; preserve the listed registers on the stack
                    lbsr      Code_3A7D ; call the referenced helper routine
                    puls      X,A       ; restore the listed registers from the stack
                    leax      A,X       ; form the referenced address without reading memory
                    stx       Data_0043 ; save the current value in working storage
                    stx       Data_0047 ; save the current value in working storage
                    cmpx      $02,S     ; compare against the limit and set condition flags
                    bne       Code_2FEE ; branch when the compared values differ
Code_2FFF           lbsr      Code_3A7D ; call the referenced helper routine
                    puls      X,D       ; restore the listed registers from the stack
                    stx       Data_0047 ; save the current value in working storage
                    std       Data_0043 ; save the current value in working storage
                    bra       Code_3045 ;3008: 20 3B          ' ; continue at the selected control-flow target
Code_300A           ldx       Data_0045 ; load the value needed by the following operation
                    pshs      X         ; preserve the listed registers on the stack
                    ldx       Data_0041 ; load the value needed by the following operation
                    stx       Data_0045 ; save the current value in working storage
                    bsr       Code_304B ; call the referenced helper routine
                    puls      X         ; restore the listed registers from the stack
                    stx       Data_0045 ; save the current value in working storage
                    ldy       Data_0041 ; load the value needed by the following operation
                    pshs      Y         ; preserve the listed registers on the stack
                    stx       Data_0041 ; save the current value in working storage
                    bsr       Code_304B ; call the referenced helper routine
                    puls      X         ; restore the listed registers from the stack
                    stx       Data_0041 ; save the current value in working storage
                    ldy       Data_0047 ; load the value needed by the following operation
                    pshs      Y         ; preserve the listed registers on the stack
                    ldy       Data_0043 ; load the value needed by the following operation
                    sty       Data_0047 ; save the current value in working storage
                    bsr       Code_304B ; call the referenced helper routine
                    puls      Y         ; restore the listed registers from the stack
                    sty       Data_0047 ; save the current value in working storage
                    ldx       Data_0043 ; load the value needed by the following operation
                    pshs      X         ; preserve the listed registers on the stack
                    sty       Data_0043 ; save the current value in working storage
                    bsr       Code_304B ; call the referenced helper routine
                    puls      Y         ; restore the listed registers from the stack
                    sty       Data_0043 ; save the current value in working storage
Code_3045           ldx       Data_0045 ; load the value needed by the following operation
                    ldy       Data_0047 ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_304B           lda       #$0F      ; load the value needed by the following operation
                    lbsr      Code_2B32 ; call the referenced helper routine
                    sta       Data_005E ; save the current value in working storage
                    ldd       #Code_0101 ; load the value needed by the following operation
                    std       Addr_0018 ; save the current value in working storage
                    ldd       Data_0045 ; load the value needed by the following operation
                    subd      Data_0041 ; subtract the operand from the running value
                    beq       Code_3068 ; branch when the compared values are equal
                    bpl       Code_306A ; branch while the tested value is nonnegative
                    neg       Addr_0018 ; form the two's-complement negative value
                    coma                ; invert every bit in the selected value
                    comb                ; invert every bit in the selected value
                    addd      #Addr_0001 ; add the operand to the running value
                    bra       Code_306A ; continue at the selected control-flow target
Code_3068           clr       Addr_0018 ; clear the selected byte or register
Code_306A           addd      #Addr_0001 ; add the operand to the running value
                    std       Data_001A ; save the current value in working storage
                    ldd       Data_0047 ; load the value needed by the following operation
                    subd      Data_0043 ; subtract the operand from the running value
                    beq       Code_3080 ; branch when the compared values are equal
                    bpl       Code_3082 ; branch while the tested value is nonnegative
                    neg       Addr_0019 ; form the two's-complement negative value
                    coma                ; invert every bit in the selected value
                    comb                ; invert every bit in the selected value
                    addd      #Addr_0001 ; add the operand to the running value
                    bra       Code_3082 ; continue at the selected control-flow target
Code_3080           clr       Addr_0019 ; clear the selected byte or register
Code_3082           addd      #Addr_0001 ; add the operand to the running value
                    std       Data_001C ; save the current value in working storage
                    clr       Data_0022 ; clear the selected byte or register
                    ldx       Data_0041 ; load the value needed by the following operation
                    ldy       Data_0043 ; load the value needed by the following operation
                    cmpd      Data_001A ; compare against the limit and set condition flags
                    bhi       Code_309B ; branch when the unsigned value is above the limit
                    std       Data_001E ; save the current value in working storage
                    ldd       Data_001A ; load the value needed by the following operation
                    std       Data_0020 ; save the current value in working storage
                    bra       Code_30A9 ; continue at the selected control-flow target
Code_309B           std       Data_0020 ; save the current value in working storage
                    ldd       Data_001A ; load the value needed by the following operation
                    std       Data_001E ; save the current value in working storage
                    com       Data_0022 ; invert every bit in the selected value
                    ldd       Addr_0018 ; load the value needed by the following operation
                    exg       A,B       ; exchange the two register values
                    std       Addr_0018 ; save the current value in working storage
Code_30A9           clrb                ; clear the selected byte or register
                    lda       Data_001F ; load the value needed by the following operation
                    clr       Addr_0011 ; clear the selected byte or register
Code_30AE           inc       Addr_0011 ; advance the selected counter
                    subd      Data_0020 ; subtract the operand from the running value
                    bhi       Code_30AE ; branch when the unsigned value is above the limit
                    beq       Code_30C3 ; branch when the compared values are equal
                    dec       Addr_0011 ; decrement the selected counter
                    addd      Data_0020 ; add the operand to the running value
                    aslb                ; shift left and update carry
                    rola                ; rotate left through carry
                    cmpd      Data_0020 ; compare against the limit and set condition flags
                    bcs       Code_30C3 ; branch when carry reports an unsigned underflow or error
                    inc       Addr_0011 ; advance the selected counter
Code_30C3           clra                ; clear the selected byte or register
                    ldu       Data_0020 ; load the value needed by the following operation
                    ldb       Data_0049 ; load the value needed by the following operation
                    cmpb      #$09      ; compare against the limit and set condition flags
                    bne       Code_30CE ; branch when the compared values differ
                    leau      -$01,U    ; form the referenced address without reading memory
Code_30CE           sta       Data_001E ; save the current value in working storage
                    stu       Data_0020 ; save the current value in working storage
                    lbsr      Code_2AB9 ; call the referenced helper routine
                    lda       Data_001E ; load the value needed by the following operation
                    ldu       Data_0020 ; load the value needed by the following operation
                    tst       Addr_0011 ; set condition flags from the current value
                    beq       Code_30E1 ; branch when the compared values are equal
                    adda      Addr_0011 ; add the operand to the running value
                    bcc       Code_30ED ; branch when carry is clear
Code_30E1           ldb       Addr_0019 ; load the value needed by the following operation
                    tst       Data_0022 ; set condition flags from the current value
                    beq       Code_30EB ; branch when the compared values are equal
                    leax      B,X       ; form the referenced address without reading memory
                    bra       Code_30ED ; continue at the selected control-flow target
Code_30EB           leay      B,Y       ; form the referenced address without reading memory
Code_30ED           ldb       Addr_0018 ; load the value needed by the following operation
                    tst       Data_0022 ; set condition flags from the current value
                    beq       Code_30F7 ; branch when the compared values are equal
                    leay      B,Y       ; form the referenced address without reading memory
                    bra       Code_30F9 ; continue at the selected control-flow target
Code_30F7           leax      B,X       ; form the referenced address without reading memory
Code_30F9           leau      -$01,U    ; form the referenced address without reading memory
                    cmpu      #DeskMateService ; compare against the limit and set condition flags
                    bgt       Code_30CE ; branch when the signed value is above the limit
                    ldx       Data_0045 ; load the value needed by the following operation
                    ldy       Data_0047 ; load the value needed by the following operation
                    rts                 ; return to the caller
                    fcb       $00,$04,$09,$0D,$16,$16 ; table, bitmap, or initialized data bytes
                    fcb       $16,$22,$22 ; table, bitmap, or initialized data bytes
                    fcc       "(,15:>BGKOSX\`dhlptx|"        ; embedded text or resource bytes
                    fcb       $80,$84,$88,$8B,$8F,$93 ; table, bitmap, or initialized data bytes
                    fcb       $96,$9A,$9E,$A1,$A5,$A8 ; table, bitmap, or initialized data bytes
                    fcb       $AB,$AF,$B2,$B5,$B8,$BB ; table, bitmap, or initialized data bytes
                    fcb       $BE,$C1,$C4,$C7,$CA,$CC ; table, bitmap, or initialized data bytes
                    fcb       $CF,$D2,$D4,$D7,$D9,$DB ; table, bitmap, or initialized data bytes
                    fcb       $DE,$E0,$E2,$E4,$E6,$E8 ; table, bitmap, or initialized data bytes
                    fcb       $EA,$EC,$ED,$EF,$F1,$F2 ; table, bitmap, or initialized data bytes
                    fcb       $F3,$F5,$F6,$F7,$F8,$F9 ; table, bitmap, or initialized data bytes
                    fcb       $FA,$FB,$FC,$FD,$FE,$FE ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$0F,$0A,$0C,$0A,$93 ; table, bitmap, or initialized data bytes
                    fcb       $08,$22,$FA ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $08,$D3,$08,$C1,$80 ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $02,$0A,$0A,$96,$0A ; table, bitmap, or initialized data bytes
                    fcc       "9="                           ; embedded text or resource bytes
                    fcb       $C1,$80   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "L9"                           ; embedded text or resource bytes
Data_317E           fcb       $0F,$06,$0F,$04,$0F,$02 ; table, bitmap, or initialized data bytes
                    fcb       $0F,$08,$DC ; table, bitmap, or initialized data bytes
                    fcc       "E"                            ; embedded text or resource bytes
                    fcb       $93       ; table, bitmap, or initialized data bytes
                    fcc       "A*"                           ; embedded text or resource bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
                    fcc       "CS"                           ; embedded text or resource bytes
                    fcb       $C3,$00,$01,$D7,$00,$DC ; table, bitmap, or initialized data bytes
                    fcc       "G"                            ; embedded text or resource bytes
                    fcb       $93       ; table, bitmap, or initialized data bytes
                    fcc       "C*"                           ; embedded text or resource bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
                    fcc       "CS"                           ; embedded text or resource bytes
                    fcb       $C3,$00,$01,$D7,$01 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $08,$0D,$00,$26,$0A,$0C ; table, bitmap, or initialized data bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $06,$0D,$00 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $02,$0C,$01,$0F,$07,$96 ; table, bitmap, or initialized data bytes
                    fcb       $00,$97,$03,$0F,$05,$8D ; table, bitmap, or initialized data bytes
                    fcc       "y"                            ; embedded text or resource bytes
                    fcb       $96,$03,$80,$01 ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $06,$9E   ; table, bitmap, or initialized data bytes
                    fcc       "E"                            ; embedded text or resource bytes
                    fcb       $10,$9E   ; table, bitmap, or initialized data bytes
                    fcc       "G9"                           ; embedded text or resource bytes
                    fcb       $97,$03,$D6,$00,$D7,$09 ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $8D,$93   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $A1,$80,$22,$FC ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $06,$0F,$0B ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $1F       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $1E,$E6,$01,$E0,$84,$A0 ; table, bitmap, or initialized data bytes
                    fcb       $84,$D7,$09 ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $17,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "u"                            ; embedded text or resource bytes
                    fcb       $97,$0B,$AF,$E3 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "k"                            ; embedded text or resource bytes
                    fcb       $1F,$10,$A3,$E1 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FF,$0A ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8B,$E6,$01,$E0,$84,$96 ; table, bitmap, or initialized data bytes
                    fcb       $0B,$17,$FF ; table, bitmap, or initialized data bytes
                    fcc       "o"                            ; embedded text or resource bytes
                    fcb       $97,$0B,$E6,$01,$D0,$0B ; table, bitmap, or initialized data bytes
                    fcb       $96,$01,$17,$FF ; table, bitmap, or initialized data bytes
                    fcc       "d"                            ; embedded text or resource bytes
                    fcb       $97,$05,$91,$07 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $14,$0C,$03,$0C,$07,$96 ; table, bitmap, or initialized data bytes
                    fcb       $07,$91,$05 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $04,$8D,$0E ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $F4,$0A,$03,$8D,$08 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $8D,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "#'"                           ; embedded text or resource bytes
                    fcb       $F8       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $87,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "#'-"                          ; embedded text or resource bytes
                    fcb       $9E       ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $DC       ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $DE       ; table, bitmap, or initialized data bytes
                    fcc       "E4V"                          ; embedded text or resource bytes
                    fcb       $D3,$02,$DD ; table, bitmap, or initialized data bytes
                    fcc       "E"                            ; embedded text or resource bytes
                    fcb       $EC,$E4,$93,$02,$DD ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $1F,$10,$D3,$06,$DD ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $17,$08   ; table, bitmap, or initialized data bytes
                    fcc       "+"                            ; embedded text or resource bytes
                    fcb       $1F,$10,$93,$06,$DD ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $17,$08,$22 ; table, bitmap, or initialized data bytes
                    fcc       "5V"                           ; embedded text or resource bytes
                    fcb       $DD       ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $DF       ; table, bitmap, or initialized data bytes
                    fcc       "E"                            ; embedded text or resource bytes
                    fcb       $9F       ; table, bitmap, or initialized data bytes
                    fcc       "C9"                           ; embedded text or resource bytes
                    fcb       $DC,$06,$D3 ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $1F,$02,$DC ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $D3,$02,$1F,$01,$9F,$14 ; table, bitmap, or initialized data bytes
                    fcb       $17,$F8   ; table, bitmap, or initialized data bytes
                    fcc       "D"                            ; embedded text or resource bytes
                    fcb       $DC       ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $93,$02,$1F,$01,$17,$F8 ; table, bitmap, or initialized data bytes
                    fcc       ";"                      ;327D: 3B             ' ; embedded text or resource bytes
                    fcb       $DC       ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $93,$06,$1F,$02,$17,$F8 ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $9E,$14,$16,$F8 ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
Code_328C           tst       Addr_0005 ; set condition flags from the current value
                    beq       Code_3293 ; branch when the compared values are equal
                    lbsr      Code_3441 ; call the referenced helper routine
Code_3293           clra                ; clear the selected byte or register
                    rts                 ; return to the caller
Code_3295           sta       Addr_0005 ; save the current value in working storage
                    lda       ,U        ; load the value needed by the following operation
                    cmpa      Addr_0008 ; compare against the limit and set condition flags
                    beq       Code_328C ; branch when the compared values are equal
                    pshs      X         ; preserve the listed registers on the stack
                    ldb       Data_0036 ; load the value needed by the following operation
                    stb       Addr_0011 ; save the current value in working storage
Code_32A3           tst       Addr_0005 ; set condition flags from the current value
                    bne       Code_32B0 ; branch when the compared values differ
                    lbsr      Code_2BDE ; call the referenced helper routine
                    beq       Code_32BC ; branch when the compared values are equal
                    com       Addr_0005 ; invert every bit in the selected value
                    bra       Code_32BC ; continue at the selected control-flow target
Code_32B0           lbsr      Code_2BDE ; call the referenced helper routine
                    bne       Code_32BC ; branch when the compared values differ
                    pshs      U         ; preserve the listed registers on the stack
                    lbsr      Code_343B ; call the referenced helper routine
                    puls      U         ; restore the listed registers from the stack
Code_32BC           leax      $01,X     ; form the referenced address without reading memory
                    dec       Addr_0011 ; decrement the selected counter
                    bge       Code_32A3 ; branch when the signed value is at least the limit
                    lda       Addr_0005 ; load the value needed by the following operation
                    puls      PC,X      ; restore the listed registers from the stack
Code_32C6           lbsr      Code_2BC5 ; call the referenced helper routine
                    lbsr      Code_2BF4 ; call the referenced helper routine
                    lda       ,U        ; load the value needed by the following operation
                    cmpa      Addr_0008 ; compare against the limit and set condition flags
                    rts                 ; return to the caller
Code_32D1           tst       Addr_0004 ; set condition flags from the current value
                    lblt      Code_337B ; take the distant branch for signed less-than
                    bsr       Code_32C6 ; call the referenced helper routine
Code_32D9           lbne      Code_337B ; take the distant branch when values differ
                    pshs      U,Y       ; preserve the listed registers on the stack
                    tst       Data_0025 ; set condition flags from the current value
                    bne       Code_32E7 ; branch when the compared values differ
                    ldb       Data_002C ; load the value needed by the following operation
                    bra       Code_3302 ; continue at the selected control-flow target
Code_32E7           tfr       X,D       ; copy the source register into the destination register
                    andb      Data_0027 ; mask off unwanted bits
                    lsrb                ; shift right and expose the low bit through carry
                    tst       Data_0034 ; set condition flags from the current value
                    bne       Code_32F1 ; branch when the compared values differ
                    lsrb                ; shift right and expose the low bit through carry
Code_32F1           stb       ,-S       ; save the current value in working storage
                    tfr       Y,D       ; copy the source register into the destination register
                    andb      Data_0026 ; mask off unwanted bits
                    lda       Data_0028 ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    addb      ,S+       ; add the operand to the running value
                    ldu       Data_0029 ; load the value needed by the following operation
                    ldb       B,U       ; load the value needed by the following operation
                    ldu       $02,S     ; load the value needed by the following operation
Code_3302           stb       ,U        ; save the current value in working storage
                    lda       #$FF      ; load the value needed by the following operation
                    leay      -$01,Y    ; form the referenced address without reading memory
                    cmpy      #DeskMateService ; compare against the limit and set condition flags
                    blt       Code_3318 ; branch when the signed value is below the limit
                    lda       #$50      ; load the value needed by the following operation
                    nega                ; form the two's-complement negative value
                    leau      A,U       ; form the referenced address without reading memory
                    lda       Addr_0006 ; load the value needed by the following operation
                    lbsr      Code_3295 ; call the referenced helper routine
Code_3318           sta       Addr_0006 ; save the current value in working storage
                    ldy       ,S        ; load the value needed by the following operation
                    ldu       $02,S     ; load the value needed by the following operation
                    lda       #$FF      ; load the value needed by the following operation
                    leay      $01,Y     ; form the referenced address without reading memory
                    cmpy      #Data_00C0 ; compare against the limit and set condition flags
                    bge       Code_3332 ; branch when the signed value is at least the limit
                    lda       #$50      ; load the value needed by the following operation
                    leau      A,U       ; form the referenced address without reading memory
                    lda       Addr_0007 ; load the value needed by the following operation
                    lbsr      Code_3295 ; call the referenced helper routine
Code_3332           sta       Addr_0007 ; save the current value in working storage
                    puls      U,Y       ; restore the listed registers from the stack
                    lda       Data_0036 ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    leax      A,X       ; form the referenced address without reading memory
                    cmpx      Data_0039 ; compare against the limit and set condition flags
                    lbge      Code_33E7 ; take the distant branch for signed greater-or-equal
                    leau      $01,U     ; form the referenced address without reading memory
                    lda       ,U        ; load the value needed by the following operation
                    cmpa      Addr_0008 ; compare against the limit and set condition flags
                    bra       Code_32D9 ; continue at the selected control-flow target
Code_3349           clr       Addr_0006 ; clear the selected byte or register
                    clr       Addr_0007 ; clear the selected byte or register
                    lda       #$01      ; load the value needed by the following operation
                    sta       Addr_0004 ; save the current value in working storage
                    lbsr      Code_2BDA ; call the referenced helper routine
                    pshs      X,D       ; preserve the listed registers on the stack
                    leax      Data_003A,PCR ; form the referenced address without reading memory
                    anda      ,U        ; mask off unwanted bits
Code_335C           ldb       ,S        ; load the value needed by the following operation
                    sta       ,-S       ; save the current value in working storage
                    andb      ,X+       ; mask off unwanted bits
                    cmpb      ,S+       ; compare against the limit and set condition flags
                    bne       Code_335C ; branch when the compared values differ
                    ldb       -$01,X    ; load the value needed by the following operation
                    stb       Addr_0008 ; save the current value in working storage
                    puls      X,D       ; restore the listed registers from the stack
                    stx       DeskMateService ; save the current value in working storage
                    sty       Addr_0002 ; save the current value in working storage
                    bra       Code_337B ; continue at the selected control-flow target
Code_3373           tfr       X,D       ; copy the source register into the destination register
                    andb      Data_0036 ; mask off unwanted bits
                    lbeq      Code_32D1 ; take the distant branch when values are equal
Code_337B           lbsr      Code_2BDA ; call the referenced helper routine
                    bne       Code_33E7 ; branch when the compared values differ
                    lbsr      Code_2B51 ; call the referenced helper routine
Code_3383           leay      -$01,Y    ; form the referenced address without reading memory
                    lda       Addr_0006 ; load the value needed by the following operation
                    bsr       Code_339B ; call the referenced helper routine
                    sta       Addr_0006 ; save the current value in working storage
                    leay      $02,Y     ; form the referenced address without reading memory
                    lda       Addr_0007 ; load the value needed by the following operation
                    bsr       Code_339B ; call the referenced helper routine
                    sta       Addr_0007 ; save the current value in working storage
                    leay      -$01,Y    ; form the referenced address without reading memory
                    lda       Addr_0004 ; load the value needed by the following operation
                    leax      A,X       ; form the referenced address without reading memory
                    bra       Code_3373 ; continue at the selected control-flow target
Code_339B           tst       Addr_0004 ; set condition flags from the current value
                    blt       Code_33C2 ; branch when the signed value is below the limit
                    pshs      X         ; preserve the listed registers on the stack
                    sta       Addr_0005 ; save the current value in working storage
                    beq       Code_33B6 ; branch when the compared values are equal
                    lbsr      Code_2BDA ; call the referenced helper routine
                    bne       Code_33BD ; branch when the compared values differ
                    lbsr      Code_342F ; call the referenced helper routine
                    beq       Code_33BD ; branch when the compared values are equal
                    lbsr      Code_3441 ; call the referenced helper routine
                    com       Addr_0005 ; invert every bit in the selected value
                    bra       Code_33BD ; continue at the selected control-flow target
Code_33B6           lbsr      Code_2BDA ; call the referenced helper routine
                    beq       Code_33BD ; branch when the compared values are equal
                    com       Addr_0005 ; invert every bit in the selected value
Code_33BD           puls      X         ; restore the listed registers from the stack
                    lda       Addr_0005 ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_33C2           pshs      X         ; preserve the listed registers on the stack
                    sta       Addr_0005 ; save the current value in working storage
                    beq       Code_33D1 ; branch when the compared values are equal
                    lbsr      Code_2BDA ; call the referenced helper routine
                    bne       Code_33BD ; branch when the compared values differ
                    com       Addr_0005 ; invert every bit in the selected value
                    bra       Code_33BD ; continue at the selected control-flow target
Code_33D1           lbsr      Code_2BDA ; call the referenced helper routine
                    beq       Code_33BD ; branch when the compared values are equal
Code_33D6           leax      $01,X     ; form the referenced address without reading memory
                    lbsr      Code_2BDA ; call the referenced helper routine
                    bne       Code_33BD ; branch when the compared values differ
                    bsr       Code_342F ; call the referenced helper routine
                    beq       Code_33D6 ; branch when the compared values are equal
                    bsr       Code_3441 ; call the referenced helper routine
                    com       Addr_0005 ; invert every bit in the selected value
                    bra       Code_33BD ; continue at the selected control-flow target
Code_33E7           neg       Addr_0004 ; form the two's-complement negative value
                    bgt       Code_33F7 ; branch when the signed value is above the limit
                    ldx       DeskMateService ; load the value needed by the following operation
                    ldy       Addr_0002 ; load the value needed by the following operation
                    ldd       #Addr_FFFF ; load the value needed by the following operation
                    std       Addr_0006 ; save the current value in working storage
                    bra       Code_3383 ; continue at the selected control-flow target
Code_33F7           pshs      X         ; preserve the listed registers on the stack
                    leay      -$01,Y    ; form the referenced address without reading memory
Code_33FB           leax      $01,X     ; form the referenced address without reading memory
                    cmpx      Data_0039 ; compare against the limit and set condition flags
                    bcc       Code_340C ; branch when carry is clear
                    lbsr      Code_2BDA ; call the referenced helper routine
                    bne       Code_340C ; branch when the compared values differ
                    bsr       Code_342F ; call the referenced helper routine
                    beq       Code_33FB ; branch when the compared values are equal
                    bsr       Code_3441 ; call the referenced helper routine
Code_340C           leay      $02,Y     ; form the referenced address without reading memory
                    puls      X         ; restore the listed registers from the stack
Code_3410           leax      $01,X     ; form the referenced address without reading memory
                    cmpx      Data_0039 ; compare against the limit and set condition flags
                    bcc       Code_3421 ; branch when carry is clear
                    lbsr      Code_2BDA ; call the referenced helper routine
                    bne       Code_3421 ; branch when the compared values differ
                    bsr       Code_342F ; call the referenced helper routine
                    beq       Code_3410 ; branch when the compared values are equal
                    bsr       Code_3441 ; call the referenced helper routine
Code_3421           bsr       Code_3459 ; call the referenced helper routine
                    stx       DeskMateService ; save the current value in working storage
                    sty       Addr_0002 ; save the current value in working storage
                    clr       Addr_0006 ; clear the selected byte or register
                    clr       Addr_0007 ; clear the selected byte or register
                    lbra      Code_3373 ; continue at the distant control-flow target
Code_342F           lbsr      Code_2B5F ; call the referenced helper routine
                    anda      Data_002C ; mask off unwanted bits
                    sta       ,-S       ; save the current value in working storage
                    andb      ,U        ; mask off unwanted bits
                    cmpb      ,S+       ; compare against the limit and set condition flags
                    rts                 ; return to the caller
Code_343B           bsr       Code_342F ; call the referenced helper routine
                    beq       Code_3452 ; branch when the compared values are equal
                    com       Addr_0005 ; invert every bit in the selected value
Code_3441           leau      -$18,S    ; form the referenced address without reading memory
                    cmpu      Data_0069 ; compare against the limit and set condition flags
                    bcs       Code_3452 ; branch when carry reports an unsigned underflow or error
                    ldu       Data_0069 ; load the value needed by the following operation
                    stx       ,U++      ; store the value and advance the destination pointer
                    sty       ,U++      ; store the value and advance the destination pointer
                    stu       Data_0069 ; save the current value in working storage
Code_3452           rts                 ; return to the caller
                    fcb       $8D,$DA   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $FB       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $E8       ; table, bitmap, or initialized data bytes
Code_3459           ldu       Data_0069 ; load the value needed by the following operation
                    cmpu      Data_0067 ; compare against the limit and set condition flags
                    beq       Code_3468 ; branch when the compared values are equal
                    ldy       ,--U      ; load the value needed by the following operation
                    ldx       ,--U      ; load the value needed by the following operation
                    stu       Data_0069 ; save the current value in working storage
                    rts                 ; return to the caller
Code_3468           leas      $02,S     ; form the referenced address without reading memory
                    rts                 ; return to the caller
                    fcb       $00,$10,$00 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $14,$0A,$04,$02,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $00,$1C,$08,$06,$02,$03 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00 ; table, bitmap, or initialized data bytes
Code_3483           clr       Data_005A ; clear the selected byte or register
                    ldd       $08,U     ; load the value needed by the following operation
                    std       $0A,U     ; save the current value in working storage
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    sta       Addr_0016 ; save the current value in working storage
                    tst       Data_0052 ; set condition flags from the current value
                    lbeq      Code_3519 ; take the distant branch when values are equal
                    pshs      U         ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $19       ; private DeskMate service selector
                    pshs      D         ; preserve the listed registers on the stack
                    tfr       Y,D       ; copy the source register into the destination register
                    lda       #$03      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    std       Data_0043 ; save the current value in working storage
                    tfr       U,D       ; copy the source register into the destination register
                    clra                ; clear the selected byte or register
                    aslb                ; shift left and update carry
                    std       Data_0041 ; save the current value in working storage
                    puls      D         ; restore the listed registers from the stack
                    tsta                ; set condition flags from the current value
                    bne       Code_34B3 ; branch when the compared values differ
                    tstb                ; set condition flags from the current value
                    beq       Code_34C7 ; branch when the compared values are equal
Code_34B3           ldx       #Addr_015E ; load the value needed by the following operation
Code_34B6           tstb                ; set condition flags from the current value
                    bne       Code_34C5 ; branch when the compared values differ
                    pshs      X         ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $19       ; private DeskMate service selector
                    puls      X         ; restore the listed registers from the stack
                    leax      -$01,X    ; form the referenced address without reading memory
                    bne       Code_34B6 ; branch when the compared values differ
Code_34C5           stb       Data_005A ; save the current value in working storage
Code_34C7           puls      U         ; restore the listed registers from the stack
                    ldx       $02,U     ; load the value needed by the following operation
                    ldb       $05,U     ; load the value needed by the following operation
                    incb                ; advance the selected counter
                    clra                ; clear the selected byte or register
                    cmpx      Data_0041 ; compare against the limit and set condition flags
                    bhi       Code_350F ; branch when the unsigned value is above the limit
Code_34D3           leax      B,X       ; form the referenced address without reading memory
                    cmpx      Data_0041 ; compare against the limit and set condition flags
                    bhi       Code_34E0 ; branch when the unsigned value is above the limit
                    inca                ; advance the selected counter
                    cmpa      $07,U     ; compare against the limit and set condition flags
                    bhi       Code_350F ; branch when the unsigned value is above the limit
                    bra       Code_34D3 ; continue at the selected control-flow target
Code_34E0           sta       Addr_0011 ; save the current value in working storage
                    ldx       ,U        ; load the value needed by the following operation
                    ldb       $04,U     ; load the value needed by the following operation
                    incb                ; advance the selected counter
                    clra                ; clear the selected byte or register
                    cmpx      Data_0043 ; compare against the limit and set condition flags
                    bhi       Code_350F ; branch when the unsigned value is above the limit
Code_34EC           leax      B,X       ; form the referenced address without reading memory
                    cmpx      Data_0043 ; compare against the limit and set condition flags
                    bhi       Code_34F9 ; branch when the unsigned value is above the limit
                    inca                ; advance the selected counter
                    cmpa      $06,U     ; compare against the limit and set condition flags
                    bhi       Code_350F ; branch when the unsigned value is above the limit
                    bra       Code_34EC ; continue at the selected control-flow target
Code_34F9           ldb       Data_005A ; load the value needed by the following operation
                    cmpb      #$01      ; compare against the limit and set condition flags
                    bne       Code_3503 ; branch when the compared values differ
                    ldb       #$0D      ; load the value needed by the following operation
                    stb       Addr_0016 ; save the current value in working storage
Code_3503           ldb       Addr_0011 ; load the value needed by the following operation
                    cmpd      $08,U     ; compare against the limit and set condition flags
                    beq       Code_3557 ; branch when the compared values are equal
                    std       $0A,U     ; save the current value in working storage
                    lbra      Code_354F ; continue at the distant control-flow target
Code_350F           lda       Data_005A ; load the value needed by the following operation
                    cmpa      #$01      ; compare against the limit and set condition flags
                    bne       Code_3519 ; branch when the compared values differ
                    lda       #$05      ; load the value needed by the following operation
                    sta       Addr_0016 ; save the current value in working storage
Code_3519           lda       Addr_0016 ; load the value needed by the following operation
                    cmpa      #$08      ; compare against the limit and set condition flags
                    beq       Code_352D ; branch when the compared values are equal
                    cmpa      #$09      ; compare against the limit and set condition flags
                    beq       Code_3535 ; branch when the compared values are equal
                    cmpa      #$0C      ; compare against the limit and set condition flags
                    beq       Code_353F ; branch when the compared values are equal
                    cmpa      #$0A      ; compare against the limit and set condition flags
                    beq       Code_3547 ; branch when the compared values are equal
                    bra       Code_3557 ; continue at the selected control-flow target
Code_352D           lda       $0B,U     ; load the value needed by the following operation
                    beq       Code_3557 ; branch when the compared values are equal
                    dec       $0B,U     ; decrement the selected counter
                    bra       Code_354F ; continue at the selected control-flow target
Code_3535           lda       $0B,U     ; load the value needed by the following operation
                    cmpa      $07,U     ; compare against the limit and set condition flags
                    beq       Code_3557 ; branch when the compared values are equal
                    inc       $0B,U     ; advance the selected counter
                    bra       Code_354F ; continue at the selected control-flow target
Code_353F           lda       $0A,U     ; load the value needed by the following operation
                    beq       Code_3557 ; branch when the compared values are equal
                    dec       $0A,U     ; decrement the selected counter
                    bra       Code_354F ; continue at the selected control-flow target
Code_3547           lda       $0A,U     ; load the value needed by the following operation
                    cmpa      $06,U     ; compare against the limit and set condition flags
                    beq       Code_3557 ; branch when the compared values are equal
                    inc       $0A,U     ; advance the selected counter
Code_354F           bsr       Code_3564 ; call the referenced helper routine
                    ldd       $0A,U     ; load the value needed by the following operation
                    std       $08,U     ; save the current value in working storage
                    bsr       Code_3564 ; call the referenced helper routine
Code_3557           lda       $08,U     ; load the value needed by the following operation
                    ldb       $07,U     ; load the value needed by the following operation
                    incb                ; advance the selected counter
                    mul                 ; multiply the two eight-bit accumulators
                    addb      $09,U     ; add the operand to the running value
                    tfr       B,A       ; copy the source register into the destination register
                    ldb       Addr_0016 ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_3564           lda       $08,U     ; load the value needed by the following operation
                    ldy       ,U        ; load the value needed by the following operation
                    ldb       $04,U     ; load the value needed by the following operation
                    incb                ; advance the selected counter
                    mul                 ; multiply the two eight-bit accumulators
                    leay      D,Y       ; form the referenced address without reading memory
                    lda       $09,U     ; load the value needed by the following operation
                    ldx       $02,U     ; load the value needed by the following operation
                    ldb       $05,U     ; load the value needed by the following operation
                    incb                ; advance the selected counter
                    mul                 ; multiply the two eight-bit accumulators
                    leax      D,X       ; form the referenced address without reading memory
                    lbsr      Code_0752 ; call the referenced helper routine
                    pshs      Y,X,A     ; preserve the listed registers on the stack
                    clra                ; clear the selected byte or register
Code_357F           clrb                ; clear the selected byte or register
                    ldy       $03,S     ; load the value needed by the following operation
                    leay      A,Y       ; form the referenced address without reading memory
Code_3585           ldx       $01,S     ; load the value needed by the following operation
                    leax      B,X       ; form the referenced address without reading memory
                    pshs      U,D       ; preserve the listed registers on the stack
                    lbsr      Code_2BF4 ; call the referenced helper routine
                    lbsr      Code_2C0F ; call the referenced helper routine
                    stb       ,-S       ; save the current value in working storage
                    ldb       ,U        ; load the value needed by the following operation
                    comb                ; invert every bit in the selected value
                    andb      ,S+       ; mask off unwanted bits
                    lbsr      Code_2B55 ; call the referenced helper routine
                    puls      U,D       ; restore the listed registers from the stack
                    incb                ; advance the selected counter
                    cmpb      $05,U     ; compare against the limit and set condition flags
                    bne       Code_3585 ; branch when the compared values differ
                    inca                ; advance the selected counter
                    cmpa      $04,U     ; compare against the limit and set condition flags
                    bne       Code_357F ; branch when the compared values differ
                    puls      Y,X,A     ; restore the listed registers from the stack
                    lbra      Code_075B ; continue at the distant control-flow target
Code_35AC           pshs      Y,X       ; preserve the listed registers on the stack
                    leay      Code_2683,PCR ; form the referenced address without reading memory
                    lbsr      Code_0327 ; call the referenced helper routine
                    sty       Data_004E ; save the current value in working storage
                    puls      PC,Y,X    ; restore the listed registers from the stack
                    fcb       $17,$F3   ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $8D,$0E   ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $8D,$FE,$B4,$17,$F3 ; table, bitmap, or initialized data bytes
                    fcc       "V"                            ; embedded text or resource bytes
                    fcb       $C1,$05   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $02,$8D,$E0 ; table, bitmap, or initialized data bytes
                    fcc       "93"                           ; embedded text or resource bytes
                    fcb       $8D,$00,$C5,$DF ; table, bitmap, or initialized data bytes
                    fcc       "a"                            ; embedded text or resource bytes
                    fcb       $CC       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $0E,$DD   ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $86,$03,$97,$10,$17,$D1 ; table, bitmap, or initialized data bytes
                    fcc       "s"                            ; embedded text or resource bytes
                    fcb       $17,$00   ; table, bitmap, or initialized data bytes
                    fcc       "p"                            ; embedded text or resource bytes
                    fcb       $8D       ; table, bitmap, or initialized data bytes
                    fcc       "X"                            ; embedded text or resource bytes
                    fcb       $0A,$10,$26,$FA,$C6,$AA ; table, bitmap, or initialized data bytes
                    fcb       $8E,$00   ; table, bitmap, or initialized data bytes
                    fcc       "l"                            ; embedded text or resource bytes
                    fcb       $10,$8E,$00 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $CE,$00   ; table, bitmap, or initialized data bytes
                    fcc       "K"                            ; embedded text or resource bytes
                    fcb       $17,$CA,$1D,$12 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$F5   ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $9F       ; table, bitmap, or initialized data bytes
                    fcc       "c"                            ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $86,$FF,$97 ; table, bitmap, or initialized data bytes
                    fcc       ",3"                           ; embedded text or resource bytes
                    fcb       $8D,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "{0"                           ; embedded text or resource bytes
                    fcb       $8D,$00   ; table, bitmap, or initialized data bytes
                    fcc       "~1"                           ; embedded text or resource bytes
                    fcb       $8D,$00   ; table, bitmap, or initialized data bytes
                    fcc       "b"                            ; embedded text or resource bytes
                    fcb       $86,$0C,$97,$11 ; table, bitmap, or initialized data bytes
                    fcc       "40"                           ; embedded text or resource bytes
                    fcb       $10,$AE,$C1,$17,$CD,$0F ; table, bitmap, or initialized data bytes
                    fcb       $10,$9F   ; table, bitmap, or initialized data bytes
                    fcc       "a50O"                         ; embedded text or resource bytes
                    fcb       $E6,$A0   ; table, bitmap, or initialized data bytes
                    fcc       "4`"                           ; embedded text or resource bytes
                    fcb       $1F,$02,$E6,$80 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $10,$1F,$01,$0F ; table, bitmap, or initialized data bytes
                    fcc       "o"                            ; embedded text or resource bytes
                    fcb       $17,$F4,$86 ; table, bitmap, or initialized data bytes
                    fcc       "5p"                           ; embedded text or resource bytes
                    fcb       $0A,$11,$26,$DB,$16,$D1 ; table, bitmap, or initialized data bytes
                    fcb       $1F,$86,$08,$97,$11,$DC ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $8B,$10   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$00,$19,$17,$C9,$C9 ; table, bitmap, or initialized data bytes
                    fcb       $0D,$0C   ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $0A,$11,$26,$EE,$17,$F2 ; table, bitmap, or initialized data bytes
                    fcb       $22,$86,$AA,$C6,$0E,$A7 ; table, bitmap, or initialized data bytes
                    fcb       $A0       ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $26,$FB,$0C ; table, bitmap, or initialized data bytes
                    fcc       "?9("                          ; embedded text or resource bytes
                    fcb       $0E,$01,$00,$00,$00,$A0 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$0A,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $A0,$00,$00,$0A ; table, bitmap, or initialized data bytes
                    fcc       "4444<<==FEEF"                 ; embedded text or resource bytes
                    fcb       $22       ; table, bitmap, or initialized data bytes
                    fcc       "0>K!0>K!0>J"                  ; embedded text or resource bytes
                    fcb       $1F,$26   ; table, bitmap, or initialized data bytes
                    fcc       "-3"                           ; embedded text or resource bytes
                    fcb       $1F,$26   ; table, bitmap, or initialized data bytes
                    fcc       "-3"                           ; embedded text or resource bytes
                    fcb       $1E,$26   ; table, bitmap, or initialized data bytes
                    fcc       ".2"                           ; embedded text or resource bytes
Data_3696           fcb       $01,$04,$FF,$01,$01,$01 ; table, bitmap, or initialized data bytes
                    fcb       $01,$FF,$08,$01,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $FF,$01,$01,$00,$01,$FF ; table, bitmap, or initialized data bytes
                    fcb       $00,$FF,$00,$01,$01,$02 ; table, bitmap, or initialized data bytes
                    fcb       $00,$01,$03,$00,$01,$00 ; table, bitmap, or initialized data bytes
                    fcb       $01,$04,$00,$01,$00,$01 ; table, bitmap, or initialized data bytes
                    fcb       $00,$01,$02,$FF,$01,$03 ; table, bitmap, or initialized data bytes
                    fcb       $FF,$01,$FF,$01,$01,$00 ; table, bitmap, or initialized data bytes
                    fcb       $01,$FF,$04,$FF,$01,$FF ; table, bitmap, or initialized data bytes
                    fcb       $01,$FF,$01,$02,$01,$00 ; table, bitmap, or initialized data bytes
                    fcb       $03,$01,$00,$01,$00,$04 ; table, bitmap, or initialized data bytes
                    fcb       $01,$00,$01,$00,$01,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$04,$0D,$04,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$02,$0C,$02 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00   ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $09,$0D,$0F,$06,$00,$FF ; table, bitmap, or initialized data bytes
                    fcc       "8("                           ; embedded text or resource bytes
                    fcb       $0A,$14,$0E,$04,$00,$FF ; table, bitmap, or initialized data bytes
                    fcc       "8_"                           ; embedded text or resource bytes
                    fcb       $0D,$88,$26 ; table, bitmap, or initialized data bytes
Data_3700           fcb       $02,$C6,$80,$E7,$8D,$EC ; table, bitmap, or initialized data bytes
                    fcb       $FA       ; table, bitmap, or initialized data bytes
                    fcc       "4P0"                          ; embedded text or resource bytes
                    fcb       $8D,$FF,$DF ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $8D,$FF,$CD ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $8D,$EF,$BA,$17,$CB,$ED ; table, bitmap, or initialized data bytes
                    fcc       "5P"                           ; embedded text or resource bytes
                    fcb       $C1,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $09,$AF,$C9,$00,$08,$96 ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "I9M"                          ; embedded text or resource bytes
                    fcb       $26,$03,$97 ; table, bitmap, or initialized data bytes
                    fcc       "~9"                           ; embedded text or resource bytes
                    fcb       $81,$03,$26,$04,$0D,$88 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $C7       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "4P0"                          ; embedded text or resource bytes
                    fcb       $8D,$FF,$B7 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $8D,$FF,$A4 ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $8D,$EF,$92,$17,$CB,$BD ; table, bitmap, or initialized data bytes
                    fcc       "5P"                           ; embedded text or resource bytes
                    fcb       $C1,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $04,$26,$CE,$97,$89,$D7 ; table, bitmap, or initialized data bytes
                    fcc       "~"                            ; embedded text or resource bytes
Code_3754           rts                 ; return to the caller
Code_3755           ldx       Data_0055 ; load the value needed by the following operation
                    ldy       Data_0057 ; load the value needed by the following operation
                    tst       Data_0052 ; set condition flags from the current value
                    beq       Code_3761 ; branch when the compared values are equal
                    lbsr      Code_2C7A ; call the referenced helper routine
Code_3761           leau      Data_3696,PCR ; form the referenced address without reading memory
                    stu       Data_0061 ; save the current value in working storage
                    leau      Data_2B87,PCR ; form the referenced address without reading memory
                    stu       Data_0063 ; save the current value in working storage
                    clr       Data_0059 ; clear the selected byte or register
                    clr       Data_005A ; clear the selected byte or register
                    clr       Data_0025 ; clear the selected byte or register
                    clr       Data_002C ; clear the selected byte or register
                    clr       Addr_000B ; clear the selected byte or register
                    clr       Data_0065 ; clear the selected byte or register
                    clr       Data_006F ; clear the selected byte or register
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Data_0054 ; save the current value in working storage
                    rts                 ; return to the caller
Code_3780           ldx       Data_0055 ; load the value needed by the following operation
                    ldy       Data_0057 ; load the value needed by the following operation
                    tst       Data_0052 ; set condition flags from the current value
                    beq       Code_378C ; branch when the compared values are equal
                    lbsr      Code_2C7A ; call the referenced helper routine
Code_378C           leau      Addr_2768,PCR ; form the referenced address without reading memory
                    stu       Data_005F ; save the current value in working storage
                    bsr       Code_3761 ; call the referenced helper routine
                    lda       Data_007E ; load the value needed by the following operation
                    cmpa      #$03      ; compare against the limit and set condition flags
                    lbeq      Code_39B2 ; take the distant branch when values are equal
Code_379C           lbsr      Code_2E3F ; call the referenced helper routine
                    bne       Code_3754 ; branch when the compared values differ
                    lbsr      Code_077D ; call the referenced helper routine
Code_37A4           lbsr      Code_0773 ; call the referenced helper routine
                    lbsr      Code_2FD7 ; call the referenced helper routine
Code_37AA           clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    cmpa      #$05      ; compare against the limit and set condition flags
                    bne       Code_37BD ; branch when the compared values differ
                    lbsr      Code_0773 ; call the referenced helper routine
                    ldx       Data_0045 ; load the value needed by the following operation
                    ldy       Data_0047 ; load the value needed by the following operation
                    bra       Code_379C ; continue at the selected control-flow target
Code_37BD           ldu       Data_0050 ; load the value needed by the following operation
                    jsr       ,U        ; call the referenced helper routine
                    lda       Data_005A ; load the value needed by the following operation
                    cmpa      #$01      ; compare against the limit and set condition flags
                    bne       Code_37CA ; branch when the compared values differ
                    lbra      Code_386E ; continue at the distant control-flow target
Code_37CA           cmpy      #Addr_0010 ; compare against the limit and set condition flags
                    bcc       Code_37D4 ; branch when carry is clear
                    ldy       #Addr_0010 ; load the value needed by the following operation
Code_37D4           tst       Data_007E ; set condition flags from the current value
                    beq       Code_383A ; branch when the compared values are equal
                    stx       Data_0084 ; save the current value in working storage
                    sty       Data_0086 ; save the current value in working storage
                    ldx       Data_0041 ; load the value needed by the following operation
                    ldd       Data_0084 ; load the value needed by the following operation
                    subd      Data_0041 ; subtract the operand from the running value
                    bpl       Code_37EC ; branch while the tested value is nonnegative
                    ldx       Data_0084 ; load the value needed by the following operation
                    coma                ; invert every bit in the selected value
                    comb                ; invert every bit in the selected value
                    addd      #Addr_0001 ; add the operand to the running value
Code_37EC           addd      #Addr_0001 ; add the operand to the running value
                    std       Data_0074 ; save the current value in working storage
                    std       Data_007C ; save the current value in working storage
                    stx       Data_0070 ; save the current value in working storage
                    ldx       Data_0043 ; load the value needed by the following operation
                    ldd       Data_0086 ; load the value needed by the following operation
                    subd      Data_0043 ; subtract the operand from the running value
                    bpl       Code_3804 ; branch while the tested value is nonnegative
                    ldx       Data_0086 ; load the value needed by the following operation
                    coma                ; invert every bit in the selected value
Code_3800           comb                ; invert every bit in the selected value
                    addd      #Addr_0001 ; add the operand to the running value
Code_3804           addd      #Addr_0001 ; add the operand to the running value
                    std       Data_0076 ; save the current value in working storage
                    stx       Data_0072 ; save the current value in working storage
                    ldd       Data_007C ; load the value needed by the following operation
                    beq       Code_381E ; branch when the compared values are equal
                    ldd       #DeskMateService ; load the value needed by the following operation
                    ldy       Data_003B ;3812: 10 9E 3B       '.. ; load the value needed by the following operation
                    lbsr      Code_384D ; call the referenced helper routine
                    cmpx      Data_0076 ; compare against the limit and set condition flags
                    bcc       Code_381E ; branch when carry is clear
                    stx       Data_0076 ; save the current value in working storage
Code_381E           ldd       Data_0043 ; load the value needed by the following operation
                    cmpd      Data_0072 ; compare against the limit and set condition flags
                    bne       Code_382C ; branch when the compared values differ
                    addd      Data_0076 ; add the operand to the running value
                    subd      #Addr_0001 ; subtract the operand from the running value
                    bra       Code_3833 ; continue at the selected control-flow target
Code_382C           subd      Data_0076 ; subtract the operand from the running value
                    addd      #Addr_0001 ; add the operand to the running value
                    std       Data_0072 ; save the current value in working storage
Code_3833           std       Data_0086 ; save the current value in working storage
                    ldx       Data_0084 ; load the value needed by the following operation
                    ldy       Data_0086 ; load the value needed by the following operation
Code_383A           cmpx      Data_0045 ; compare against the limit and set condition flags
                    bne       Code_3845 ; branch when the compared values differ
                    cmpy      Data_0047 ; compare against the limit and set condition flags
                    lbeq      Code_37AA ; take the distant branch when values are equal
Code_3845           stx       Data_0045 ; save the current value in working storage
                    sty       Data_0047 ; save the current value in working storage
                    lbra      Code_37A4 ; continue at the distant control-flow target
Code_384D           pshs      U,X       ; preserve the listed registers on the stack
                    ldx       #Addr_0010 ; load the value needed by the following operation
Code_3852           exg       D,Y       ; exchange the two register values
                    aslb                ; shift left and update carry
                    rola                ; rotate left through carry
                    exg       D,Y       ; exchange the two register values
                    rolb                ; rotate left through carry
                    rola                ; rotate left through carry
                    bcs       Code_3861 ; branch when carry reports an unsigned underflow or error
                    cmpd      Data_007C ; compare against the limit and set condition flags
                    bcs       Code_3865 ; branch when carry reports an unsigned underflow or error
Code_3861           subd      Data_007C ; subtract the operand from the running value
                    leay      $01,Y     ; form the referenced address without reading memory
Code_3865           leax      -$01,X    ; form the referenced address without reading memory
                    bne       Code_3852 ; branch when the compared values differ
                    puls      U,X       ; restore the listed registers from the stack
                    tfr       Y,X       ; copy the source register into the destination register
                    rts                 ; return to the caller
Code_386E           tst       Data_007E ; set condition flags from the current value
                    beq       Code_38CF ; branch when the compared values are equal
                    ldd       Data_0076 ; load the value needed by the following operation
                    std       Data_007A ; save the current value in working storage
                    ldd       Data_0074 ; load the value needed by the following operation
                    std       Data_0078 ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    ldx       Data_007F ; load the value needed by the following operation
                    ldy       #Addr_0DC0 ; load the value needed by the following operation
Code_3882           std       ,X++      ; store the value and advance the destination pointer
                    leay      -$02,Y    ; form the referenced address without reading memory
                    bne       Code_3882 ; branch when the compared values differ
Code_3888           clr       Data_0081 ; clear the selected byte or register
                    clr       Data_0082 ; clear the selected byte or register
                    clr       Data_0083 ; clear the selected byte or register
                    ldy       Data_0072 ; load the value needed by the following operation
                    ldd       Data_0076 ; load the value needed by the following operation
Code_3893           std       Addr_0002 ; save the current value in working storage
                    ldx       Data_0070 ; load the value needed by the following operation
                    ldd       Data_0074 ; load the value needed by the following operation
Code_3899           std       DeskMateService ; save the current value in working storage
                    lda       Data_007E ; load the value needed by the following operation
                    deca                ; decrement the selected counter
                    beq       Code_38F0 ; branch when the compared values are equal
                    deca                ; decrement the selected counter
                    beq       Code_3908 ; branch when the compared values are equal
                    lbsr      Code_395F ; call the referenced helper routine
Code_38A6           leax      $01,X     ; form the referenced address without reading memory
                    ldd       DeskMateService ; load the value needed by the following operation
                    subd      #Addr_0001 ; subtract the operand from the running value
                    bne       Code_3899 ; branch when the compared values differ
                    leay      $01,Y     ; form the referenced address without reading memory
                    ldd       Addr_0002 ; load the value needed by the following operation
                    subd      #Addr_0001 ; subtract the operand from the running value
                    bne       Code_3893 ; branch when the compared values differ
                    lda       Data_007E ; load the value needed by the following operation
                    cmpa      #$02      ; compare against the limit and set condition flags
                    bne       Code_38C1 ; branch when the compared values differ
                    lbsr      Code_0773 ; call the referenced helper routine
Code_38C1           lda       #$03      ; load the value needed by the following operation
                    sta       Data_007E ; save the current value in working storage
                    sta       Data_0088 ; save the current value in working storage
                    ldx       Data_0070 ; load the value needed by the following operation
                    ldy       Data_0072 ; load the value needed by the following operation
Code_38CC           lbra      Code_378C ; continue at the distant control-flow target
Code_38CF           bsr       Code_38D8 ; call the referenced helper routine
                    ldx       Data_0045 ; load the value needed by the following operation
                    ldy       Data_0047 ; load the value needed by the following operation
                    bra       Code_38CC ; continue at the selected control-flow target
Code_38D8           lda       #$FF      ; load the value needed by the following operation
                    sta       Data_0023 ; save the current value in working storage
                    lda       Data_002B ; load the value needed by the following operation
                    pshs      A         ; preserve the listed registers on the stack
                    lda       Data_00A1 ; load the value needed by the following operation
                    lbsr      Code_02BE ; call the referenced helper routine
                    lbsr      Code_2FD7 ; call the referenced helper routine
                    puls      A         ; restore the listed registers from the stack
                    lbsr      Code_02BE ; call the referenced helper routine
                    com       Data_0023 ; invert every bit in the selected value
                    rts                 ; return to the caller
Code_38F0           bsr       Code_390C ; call the referenced helper routine
                    bsr       Code_38F6 ; call the referenced helper routine
                    bra       Code_38A6 ; continue at the selected control-flow target
Code_38F6           lbsr      Code_2BF4 ; call the referenced helper routine
                    lbsr      Code_2C0F ; call the referenced helper routine
                    coma                ; invert every bit in the selected value
                    anda      ,U        ; mask off unwanted bits
                    andb      Data_00A0 ; mask off unwanted bits
                    stb       ,-S       ; save the current value in working storage
                    ora       ,S+       ; set the selected flag bits
                    sta       ,U        ; save the current value in working storage
                    rts                 ; return to the caller
Code_3908           bsr       Code_390C ; call the referenced helper routine
                    bra       Code_38A6 ; continue at the selected control-flow target
Code_390C           pshs      Y         ; preserve the listed registers on the stack
                    lbsr      Code_2BEC ; call the referenced helper routine
                    tfr       X,D       ; copy the source register into the destination register
                    andb      Data_0036 ; mask off unwanted bits
                    ldy       Data_0037 ; load the value needed by the following operation
                    lda       B,Y       ; load the value needed by the following operation
                    anda      ,U        ; mask off unwanted bits
                    cmpb      Data_0081 ; compare against the limit and set condition flags
                    beq       Code_392E ; branch when the compared values are equal
                    bcs       Code_3950 ; branch when carry reports an unsigned underflow or error
                    subb      Data_0081 ; subtract the operand from the running value
                    aslb                ; shift left and update carry
                    tst       Data_0034 ; set condition flags from the current value
                    beq       Code_392A ; branch when the compared values are equal
                    aslb                ; shift left and update carry
Code_392A           asla                ; shift left and update carry
                    decb                ; decrement the selected counter
                    bne       Code_392A ; branch when the compared values differ
Code_392E           pshs      A         ; preserve the listed registers on the stack
                    ldd       Data_007F ; load the value needed by the following operation
                    addd      Data_0082 ; add the operand to the running value
                    tfr       D,Y       ; copy the source register into the destination register
                    puls      A         ; restore the listed registers from the stack
                    ora       ,Y        ; set the selected flag bits
                    sta       ,Y        ; save the current value in working storage
Code_393C           lda       Data_0081 ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    cmpa      Data_0036 ; compare against the limit and set condition flags
                    bls       Code_394C ; branch when the unsigned value is at or below the limit
                    clra                ; clear the selected byte or register
                    ldy       Data_0082 ; load the value needed by the following operation
                    leay      $01,Y     ; form the referenced address without reading memory
                    sty       Data_0082 ; save the current value in working storage
Code_394C           sta       Data_0081 ; save the current value in working storage
                    puls      PC,Y      ; restore the listed registers from the stack
Code_3950           subb      Data_0081 ; subtract the operand from the running value
                    negb                ; form the two's-complement negative value
                    aslb                ; shift left and update carry
                    tst       Data_0034 ; set condition flags from the current value
                    beq       Code_3959 ; branch when the compared values are equal
                    aslb                ; shift left and update carry
Code_3959           lsra                ; shift right and expose the low bit through carry
                    decb                ; decrement the selected counter
                    bne       Code_3959 ; branch when the compared values differ
                    bra       Code_392E ; continue at the selected control-flow target
Code_395F           ldd       Data_007F ; load the value needed by the following operation
                    addd      Data_0082 ; add the operand to the running value
                    tfr       D,U       ; copy the source register into the destination register
                    tfr       X,D       ; copy the source register into the destination register
                    andb      Data_0036 ; mask off unwanted bits
                    tst       Data_0089 ; set condition flags from the current value
                    bne       Code_3986 ; branch when the compared values differ
                    pshs      Y,B       ; preserve the listed registers on the stack
                    ldy       Data_0037 ; load the value needed by the following operation
                    ldb       Data_0081 ; load the value needed by the following operation
                    lda       B,Y       ; load the value needed by the following operation
                    puls      Y,B       ; restore the listed registers from the stack
                    pshs      D         ; preserve the listed registers on the stack
                    anda      Data_00A0 ; mask off unwanted bits
                    sta       $01,S     ; save the current value in working storage
                    puls      A         ; restore the listed registers from the stack
                    anda      ,U        ; mask off unwanted bits
                    cmpa      ,S+       ; compare against the limit and set condition flags
                    beq       Code_399F ; branch when the compared values are equal
Code_3986           lda       ,U        ; load the value needed by the following operation
                    cmpb      Data_0081 ; compare against the limit and set condition flags
                    beq       Code_399A ; branch when the compared values are equal
                    bcs       Code_39A3 ; branch when carry reports an unsigned underflow or error
                    subb      Data_0081 ; subtract the operand from the running value
                    aslb                ; shift left and update carry
                    tst       Data_0034 ; set condition flags from the current value
                    beq       Code_3996 ; branch when the compared values are equal
                    aslb                ; shift left and update carry
Code_3996           lsra                ; shift right and expose the low bit through carry
                    decb                ; decrement the selected counter
                    bne       Code_3996 ; branch when the compared values differ
Code_399A           sta       Data_002C ; save the current value in working storage
                    lbsr      Code_2BAF ; call the referenced helper routine
Code_399F           pshs      Y         ; preserve the listed registers on the stack
                    bra       Code_393C ; continue at the selected control-flow target
Code_39A3           subb      Data_0081 ; subtract the operand from the running value
                    negb                ; form the two's-complement negative value
                    aslb                ; shift left and update carry
                    tst       Data_0034 ; set condition flags from the current value
                    beq       Code_39AC ; branch when the compared values are equal
                    aslb                ; shift left and update carry
Code_39AC           asla                ; shift left and update carry
                    decb                ; decrement the selected counter
                    bne       Code_39AC ; branch when the compared values differ
                    bra       Code_399A ; continue at the selected control-flow target
Code_39B2           ldd       Data_0078 ; load the value needed by the following operation
                    std       Data_0074 ; save the current value in working storage
                    ldd       Data_007A ; load the value needed by the following operation
                    std       Data_0076 ; save the current value in working storage
Code_39BA           stx       Data_0041 ; save the current value in working storage
                    cmpy      #Addr_0010 ; compare against the limit and set condition flags
                    bcc       Code_39D1 ; branch when carry is clear
                    lbsr      Code_2C7A ; call the referenced helper routine
                    cmpy      #Addr_0010 ; compare against the limit and set condition flags
                    bcs       Code_3A0B ; branch when carry reports an unsigned underflow or error
                    ldx       Data_0041 ; load the value needed by the following operation
                    ldy       #Addr_0010 ; load the value needed by the following operation
Code_39D1           sty       Data_0043 ; save the current value in working storage
                    ldd       Data_0041 ; load the value needed by the following operation
                    addd      Data_0074 ; add the operand to the running value
                    subd      #Addr_0001 ; subtract the operand from the running value
                    std       Data_0045 ; save the current value in working storage
                    ldd       Data_0043 ; load the value needed by the following operation
                    addd      Data_0076 ; add the operand to the running value
                    subd      #Addr_0001 ; subtract the operand from the running value
                    std       Data_0047 ; save the current value in working storage
                    lda       #$01      ; load the value needed by the following operation
                    sta       Data_006F ; save the current value in working storage
                    lbsr      Code_2A48 ; call the referenced helper routine
Code_39ED           lbsr      Code_2FD7 ; call the referenced helper routine
                    ldx       Data_0041 ; load the value needed by the following operation
                    ldy       Data_0043 ; load the value needed by the following operation
Code_39F5           clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    cmpa      #$8C      ; compare against the limit and set condition flags
                    bne       Code_3A0E ; branch when the compared values differ
                    stx       Data_0055 ; save the current value in working storage
                    sty       Data_0057 ; save the current value in working storage
                    lda       Data_0052 ; load the value needed by the following operation
                    sta       Data_0053 ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    lbsr      Code_052B ; call the referenced helper routine
Code_3A0B           lbra      Code_2A48 ; continue at the distant control-flow target
Code_3A0E           cmpa      #$B2      ; compare against the limit and set condition flags
                    bne       Code_3A23 ; branch when the compared values differ
                    lbsr      Code_2A48 ; call the referenced helper routine
                    lbsr      Code_077D ; call the referenced helper routine
                    lbsr      Code_0907 ; call the referenced helper routine
Code_3A1B           lbsr      Code_0752 ; call the referenced helper routine
                    lbsr      Code_0773 ; call the referenced helper routine
                    bra       Code_39ED ; continue at the selected control-flow target
Code_3A23           cmpa      #$05      ; compare against the limit and set condition flags
                    bne       Code_3A32 ; branch when the compared values differ
                    lbsr      Code_2A48 ; call the referenced helper routine
                    lbsr      Code_0777 ; call the referenced helper routine
                    lbsr      Code_0662 ; call the referenced helper routine
                    bra       Code_3A1B ; continue at the selected control-flow target
Code_3A32           cmpa      #$AF      ; compare against the limit and set condition flags
                    bne       Code_3A42 ; branch when the compared values differ
                    lbsr      Code_2A48 ; call the referenced helper routine
                    lbsr      Code_077D ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    lbsr      Code_045C ; call the referenced helper routine
                    bra       Code_3A1B ; continue at the selected control-flow target
Code_3A42           cmpa      #$BA      ; compare against the limit and set condition flags
                    bne       Code_3A4E ; branch when the compared values differ
                    lbsr      Code_2A48 ; call the referenced helper routine
                    lbsr      Code_04D6 ; call the referenced helper routine
                    bra       Code_3A1B ; continue at the selected control-flow target
Code_3A4E           ldu       Data_0050 ; load the value needed by the following operation
                    jsr       ,U        ; call the referenced helper routine
                    lda       Data_005A ; load the value needed by the following operation
                    cmpa      #$01      ; compare against the limit and set condition flags
                    bne       Code_3A6D ; branch when the compared values differ
                    lbsr      Code_2A48 ; call the referenced helper routine
                    lbsr      Code_077D ; call the referenced helper routine
                    ldx       Data_0041 ; load the value needed by the following operation
                    stx       Data_0055 ; save the current value in working storage
                    stx       Data_0070 ; save the current value in working storage
                    ldx       Data_0043 ; load the value needed by the following operation
                    stx       Data_0057 ; save the current value in working storage
                    stx       Data_0072 ; save the current value in working storage
                    lbra      Code_3888 ; continue at the distant control-flow target
Code_3A6D           cmpx      Data_0041 ; compare against the limit and set condition flags
                    lbne      Code_39BA ; take the distant branch when values differ
                    cmpy      Data_0043 ; compare against the limit and set condition flags
                    lbne      Code_39BA ; take the distant branch when values differ
                    lbra      Code_39F5 ; continue at the distant control-flow target
Code_3A7D           pshs      X,A       ; preserve the listed registers on the stack
                    ldd       Data_0043 ; load the value needed by the following operation
                    cmpd      #Data_00C0 ; compare against the limit and set condition flags
                    bcc       Code_3B06 ; branch when carry is clear
                    cmpd      #Addr_0010 ; compare against the limit and set condition flags
                    bcs       Code_3B06 ; branch when carry reports an unsigned underflow or error
                    ldd       Data_0045 ; load the value needed by the following operation
                    ldx       Data_0041 ; load the value needed by the following operation
                    cmpx      Data_0045 ; compare against the limit and set condition flags
                    ble       Code_3A97 ; branch when the signed value is at or below the limit
                    exg       D,X       ; exchange the two register values
Code_3A97           pshs      X         ; preserve the listed registers on the stack
                    ldy       Data_0043 ; load the value needed by the following operation
                    tfr       D,X       ; copy the source register into the destination register
                    leax      $01,X     ; form the referenced address without reading memory
Code_3AA0           leax      -$01,X    ; form the referenced address without reading memory
                    lbsr      Code_2C1D ; call the referenced helper routine
                    cmpx      #DeskMateService ; compare against the limit and set condition flags
                    beq       Code_3B04 ; branch when the compared values are equal
                    cmpx      ,S        ; compare against the limit and set condition flags
                    beq       Code_3B04 ; branch when the compared values are equal
                    tfr       X,D       ; copy the source register into the destination register
                    andb      Data_0036 ; mask off unwanted bits
                    bne       Code_3AA0 ; branch when the compared values differ
                    leax      -$01,X    ; form the referenced address without reading memory
                    cmpx      Data_0039 ; compare against the limit and set condition flags
                    blt       Code_3ABE ; branch when the signed value is below the limit
                    ldx       Data_0039 ; load the value needed by the following operation
                    leax      -$01,X    ; form the referenced address without reading memory
Code_3ABE           lbsr      Code_2BF4 ; call the referenced helper routine
                    puls      X         ; restore the listed registers from the stack
                    pshs      U         ; preserve the listed registers on the stack
Code_3AC5           lbsr      Code_2C1D ; call the referenced helper routine
                    leax      $01,X     ; form the referenced address without reading memory
                    tfr       X,D       ; copy the source register into the destination register
                    andb      Data_0036 ; mask off unwanted bits
                    bne       Code_3AC5 ; branch when the compared values differ
                    cmpx      #DeskMateService ; compare against the limit and set condition flags
                    bge       Code_3AD8 ; branch when the signed value is at least the limit
                    ldx       #DeskMateService ; load the value needed by the following operation
Code_3AD8           lbsr      Code_2BF4 ; call the referenced helper routine
                    cmpu      ,S        ; compare against the limit and set condition flags
                    bhi       Code_3B04 ; branch when the unsigned value is above the limit
                    tst       Data_0025 ; set condition flags from the current value
                    beq       Code_3B08 ; branch when the compared values are equal
                    tfr       Y,D       ; copy the source register into the destination register
                    andb      Data_0026 ; mask off unwanted bits
                    lda       Data_0028 ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    pshs      B         ; preserve the listed registers on the stack
Code_3AED           tfr       U,D       ; copy the source register into the destination register
                    andb      #$03      ; mask off unwanted bits
                    addb      ,S        ; add the operand to the running value
                    ldx       Data_0029 ; load the value needed by the following operation
                    ldb       B,X       ; load the value needed by the following operation
                    stb       ,U        ; save the current value in working storage
                    leau      $01,U     ; form the referenced address without reading memory
                    cmpu      $01,S     ; compare against the limit and set condition flags
                    bls       Code_3AED ; branch when the unsigned value is at or below the limit
                    leas      $03,S     ; form the referenced address without reading memory
                    bra       Code_3B06 ; continue at the selected control-flow target
Code_3B04           leas      $02,S     ; form the referenced address without reading memory
Code_3B06           puls      PC,X,A    ; restore the listed registers from the stack
Code_3B08           ldb       Data_002C ; load the value needed by the following operation
Code_3B0A           stb       ,U        ; save the current value in working storage
                    leau      $01,U     ; form the referenced address without reading memory
                    cmpu      ,S        ; compare against the limit and set condition flags
                    bls       Code_3B0A ; branch when the unsigned value is at or below the limit
                    leas      $02,S     ; form the referenced address without reading memory
                    bra       Code_3B06 ; continue at the selected control-flow target
                    fcb       $17,$CC   ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
                    fcb       $CC,$00,$0C,$DD ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $17,$ED   ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $CC       ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $1A,$DD,$14 ; table, bitmap, or initialized data bytes
                    fcc       "_o"                           ; embedded text or resource bytes
                    fcb       $A5       ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $D1,$15,$26,$F9 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $A8       ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $0A,$14,$26,$F1,$86,$AA ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $A7,$A5   ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $D1,$15,$26,$F9,$C6,$AA ; table, bitmap, or initialized data bytes
                    fcb       $8E,$00   ; table, bitmap, or initialized data bytes
                    fcc       "`"                            ; embedded text or resource bytes
                    fcb       $10,$8E,$00,$10,$CE,$00 ; table, bitmap, or initialized data bytes
                    fcc       "j"                            ; embedded text or resource bytes
                    fcb       $17,$C4,$C5,$12,$8E,$01 ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $17,$C4,$BE,$12 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $8D,$EF,$F6,$10,$9F ; table, bitmap, or initialized data bytes
                    fcc       "c1"                           ; embedded text or resource bytes
                    fcb       $8D,$FB   ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $10,$9F   ; table, bitmap, or initialized data bytes
                    fcc       "a"                            ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "o"                            ; embedded text or resource bytes
                    fcb       $0F,$12,$86,$05,$97,$15 ; table, bitmap, or initialized data bytes
                    fcb       $10,$8E,$00,$13,$8E,$00 ; table, bitmap, or initialized data bytes
                    fcb       $1C,$86,$04,$97,$14,$9F ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $10,$9F   ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $0D,$12,$26,$14 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $07,$9F   ; table, bitmap, or initialized data bytes
                    fcc       "E1+"                          ; embedded text or resource bytes
                    fcb       $10,$9F   ; table, bitmap, or initialized data bytes
                    fcc       "G"                            ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $86,$FF,$97 ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $17,$01,$96 ; table, bitmap, or initialized data bytes
                    fcc       " ]"                           ; embedded text or resource bytes
                    fcb       $96,$12,$17,$C7 ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $26,$0C,$1F,$B8,$C6 ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $DD       ; table, bitmap, or initialized data bytes
                    fcc       ")"                            ; embedded text or resource bytes
                    fcb       $0F,$26,$86,$01,$97 ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $9E       ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $10,$9E   ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $17,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "B"                            ; embedded text or resource bytes
                    fcb       $C6,$0C,$D7,$0C,$0F,$0E ; table, bitmap, or initialized data bytes
                    fcb       $10,$9E   ; table, bitmap, or initialized data bytes
                    fcc       ")4@"                          ; embedded text or resource bytes
                    fcb       $C6,$04,$D7,$0D,$0F,$0F ; table, bitmap, or initialized data bytes
                    fcb       $D6,$0F,$A6,$A5,$A7,$C4 ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $D7,$0F,$D1 ; table, bitmap, or initialized data bytes
                    fcc       "(%"                           ; embedded text or resource bytes
                    fcb       $02,$0F,$0F ; table, bitmap, or initialized data bytes
                    fcc       "3A"                           ; embedded text or resource bytes
                    fcb       $0A,$0D,$26,$EB ; table, bitmap, or initialized data bytes
                    fcc       "5@3"                          ; embedded text or resource bytes
                    fcb       $C8       ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $D6       ; table, bitmap, or initialized data bytes
                    fcc       "(1"                           ; embedded text or resource bytes
                    fcb       $A5,$0C,$0E,$D6,$0E,$D1 ; table, bitmap, or initialized data bytes
                    fcb       $26       ; table, bitmap, or initialized data bytes
                    fcc       "#"                            ; embedded text or resource bytes
                    fcb       $05,$0F,$0E,$10,$9E ; table, bitmap, or initialized data bytes
                    fcc       ")"                            ; embedded text or resource bytes
                    fcb       $0A,$0C,$26,$C9,$9E ; table, bitmap, or initialized data bytes
                    fcc       "A0"                           ; embedded text or resource bytes
                    fcb       $0C,$10,$9E ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $0C,$12,$0A,$14,$10,$26 ; table, bitmap, or initialized data bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
                    fcc       "w1"                           ; embedded text or resource bytes
                    fcb       $A8,$12,$0A,$15,$10,$26 ; table, bitmap, or initialized data bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
                    fcc       "g"                            ; embedded text or resource bytes
                    fcb       $16,$00,$E8 ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $17,$C4,$03,$1D,$97,$16 ; table, bitmap, or initialized data bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "R"                            ; embedded text or resource bytes
                    fcb       $17,$C3,$FB,$19 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $06,$1F   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $86,$03   ; table, bitmap, or initialized data bytes
                    fcc       "="                            ; embedded text or resource bytes
                    fcb       $DD       ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $1F       ; table, bitmap, or initialized data bytes
                    fcc       "0O"                           ; embedded text or resource bytes
                    fcb       $DD       ; table, bitmap, or initialized data bytes
                    fcc       "A5"                           ; embedded text or resource bytes
                    fcb       $06       ; table, bitmap, or initialized data bytes
                    fcc       "M"                            ; embedded text or resource bytes
                    fcb       $26,$03   ; table, bitmap, or initialized data bytes
                    tstb                ; set condition flags from the current value
                    beq       Code_3C67 ; branch when the compared values are equal
                    ldx       #Addr_015E ; load the value needed by the following operation
Code_3C33           tstb                ; set condition flags from the current value
                    bne       Code_3C42 ; branch when the compared values differ
                    pshs      X         ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $19       ; private DeskMate service selector
                    puls      X         ; restore the listed registers from the stack
                    leax      -$01,X    ; form the referenced address without reading memory
                    bne       Code_3C33 ; branch when the compared values differ
Code_3C42           cmpb      #$01      ; compare against the limit and set condition flags
                    bne       Code_3C67 ; branch when the compared values differ
                    ldx       Data_0041 ; load the value needed by the following operation
                    lda       #$05      ; load the value needed by the following operation
                    cmpx      #Addr_000D ; compare against the limit and set condition flags
                    bls       Code_3C65 ; branch when the unsigned value is at or below the limit
                    cmpx      #Data_0026 ; compare against the limit and set condition flags
                    bcc       Code_3C65 ; branch when carry is clear
                    ldy       Data_0043 ; load the value needed by the following operation
                    cmpy      #Addr_000E ; compare against the limit and set condition flags
                    bcs       Code_3C65 ; branch when carry reports an unsigned underflow or error
                    cmpy      #Data_0067 ; compare against the limit and set condition flags
                    bhi       Code_3C65 ; branch when the unsigned value is above the limit
                    lda       #$0D      ; load the value needed by the following operation
Code_3C65           sta       Addr_0016 ; save the current value in working storage
Code_3C67           clra                ; clear the selected byte or register
                    ldx       #Addr_000C ; load the value needed by the following operation
Code_3C6B           cmpx      Data_0041 ; compare against the limit and set condition flags
                    bhi       Code_3C96 ; branch when the unsigned value is above the limit
                    leax      $07,X     ; form the referenced address without reading memory
                    cmpx      Data_0041 ; compare against the limit and set condition flags
                    bhi       Code_3C7E ; branch when the unsigned value is above the limit
                    leax      -$01,X    ; form the referenced address without reading memory
                    inca                ; advance the selected counter
                    cmpa      #$03      ; compare against the limit and set condition flags
                    bhi       Code_3C96 ; branch when the unsigned value is above the limit
                    bra       Code_3C6B ; continue at the selected control-flow target
Code_3C7E           sta       Addr_000B ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    ldx       #Addr_0011 ; load the value needed by the following operation
Code_3C84           cmpx      Data_0043 ; compare against the limit and set condition flags
                    bhi       Code_3C96 ; branch when the unsigned value is above the limit
                    leax      $12,X     ; form the referenced address without reading memory
                    cmpx      Data_0043 ; compare against the limit and set condition flags
                    bhi       Code_3CD8 ; branch when the unsigned value is above the limit
                    inca                ; advance the selected counter
                    cmpa      #$04      ; compare against the limit and set condition flags
                    bhi       Code_3C96 ; branch when the unsigned value is above the limit
                    bra       Code_3C84 ; continue at the selected control-flow target
Code_3C96           lda       Addr_0016 ; load the value needed by the following operation
                    cmpa      #$08      ; compare against the limit and set condition flags
                    beq       Code_3CAA ; branch when the compared values are equal
                    cmpa      #$09      ; compare against the limit and set condition flags
                    beq       Code_3CB6 ; branch when the compared values are equal
                    cmpa      #$0C      ; compare against the limit and set condition flags
                    beq       Code_3CC2 ; branch when the compared values are equal
                    cmpa      #$0A      ; compare against the limit and set condition flags
                    beq       Code_3CCC ; branch when the compared values are equal
                    bra       Code_3CB4 ; continue at the selected control-flow target
Code_3CAA           tst       Data_0030 ; set condition flags from the current value
                    beq       Code_3CE7 ; branch when the compared values are equal
                    bsr       Code_3CF9 ; call the referenced helper routine
                    dec       Data_0030 ; decrement the selected counter
Code_3CB2           bsr       Code_3CF5 ; call the referenced helper routine
Code_3CB4           bra       Code_3CE7 ; continue at the selected control-flow target
Code_3CB6           lda       Data_0030 ; load the value needed by the following operation
                    cmpa      #$03      ; compare against the limit and set condition flags
                    beq       Code_3CB4 ; branch when the compared values are equal
                    bsr       Code_3CF9 ;3CBC: 8D 3B          '. ; call the referenced helper routine
                    inc       Data_0030 ; advance the selected counter
                    bra       Code_3CB2 ; continue at the selected control-flow target
Code_3CC2           tst       Data_002F ; set condition flags from the current value
                    beq       Code_3CB4 ; branch when the compared values are equal
                    bsr       Code_3CF9 ; call the referenced helper routine
                    dec       Data_002F ; decrement the selected counter
                    bra       Code_3CB2 ; continue at the selected control-flow target
Code_3CCC           lda       Data_002F ; load the value needed by the following operation
                    cmpa      #$04      ; compare against the limit and set condition flags
                    beq       Code_3CB4 ; branch when the compared values are equal
                    bsr       Code_3CF9 ; call the referenced helper routine
                    inc       Data_002F ; advance the selected counter
                    bra       Code_3CB2 ; continue at the selected control-flow target
Code_3CD8           ldb       Addr_000B ; load the value needed by the following operation
                    cmpd      Data_002F ; compare against the limit and set condition flags
                    beq       Code_3CE7 ; branch when the compared values are equal
                    pshs      D         ; preserve the listed registers on the stack
                    bsr       Code_3CF9 ; call the referenced helper routine
                    puls      D         ; restore the listed registers from the stack
                    bsr       Code_3CF3 ; call the referenced helper routine
Code_3CE7           lda       Data_002F ; load the value needed by the following operation
                    ldb       #$04      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    addb      Data_0030 ; add the operand to the running value
                    tfr       B,A       ; copy the source register into the destination register
                    ldb       Addr_0016 ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_3CF3           std       Data_002F ; save the current value in working storage
Code_3CF5           lda       #$FF      ; load the value needed by the following operation
                    bra       Code_3CFA ; continue at the selected control-flow target
Code_3CF9           clra                ; clear the selected byte or register
Code_3CFA           sta       Data_002C ; save the current value in working storage
                    clr       Data_0025 ; clear the selected byte or register
                    lbsr      Code_0752 ; call the referenced helper routine
                    ldy       #Addr_0011 ; load the value needed by the following operation
                    lda       Data_002F ; load the value needed by the following operation
                    ldb       #$12      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    leay      D,Y       ; form the referenced address without reading memory
                    ldx       #Data_001A ; load the value needed by the following operation
                    lda       Data_0030 ; load the value needed by the following operation
                    ldb       #$0C      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    leax      D,X       ; form the referenced address without reading memory
                    stx       Data_0041 ; save the current value in working storage
                    sty       Data_0043 ; save the current value in working storage
                    leay      $0F,Y     ; form the referenced address without reading memory
                    sty       Data_0047 ; save the current value in working storage
                    leax      $0B,X     ; form the referenced address without reading memory
                    stx       Data_0045 ; save the current value in working storage
                    bsr       Code_3D29 ; call the referenced helper routine
                    lbra      Code_075B ; continue at the distant control-flow target
Code_3D29           lda       Data_0049 ; load the value needed by the following operation
                    clr       Data_0049 ; clear the selected byte or register
                    pshs      A         ; preserve the listed registers on the stack
                    lbsr      Code_2FD7 ; call the referenced helper routine
                    puls      A         ; restore the listed registers from the stack
                    sta       Data_0049 ; save the current value in working storage
                    rts                 ; return to the caller

                    emod
eom                 equ       *
                    end
