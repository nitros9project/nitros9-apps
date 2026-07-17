********************************************************************
* DMCARDS - DeskMate 3 card-file application
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

                    nam       DMCARDS
                    ttl       DeskMate 3 card-file application

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct
atrv                set       $00

                    mod       eom,name,tylg,atrv,start,$320B

name                fcs       /DMCARDS/ ; OS-9 module name

Addr_0001           equ       $0001     ; absolute address used by original code
Addr_0002           equ       $0002     ; absolute address used by original code
Addr_0003           equ       $0003     ; absolute address used by original code
Addr_0004           equ       $0004     ; absolute address used by original code
Addr_0006           equ       $0006     ; absolute address used by original code
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
Addr_001A           equ       $001A     ; absolute address used by original code
Addr_001C           equ       $001C     ; absolute address used by original code
Addr_001E           equ       $001E     ; absolute address used by original code
Addr_001F           equ       $001F     ; absolute address used by original code
Addr_0020           equ       $0020     ; absolute address used by original code
Addr_0022           equ       $0022     ; absolute address used by original code
Addr_0023           equ       $0023     ; absolute address used by original code
Addr_0026           equ       $0026     ; absolute address used by original code
Addr_0027           equ       $0027     ; absolute address used by original code
Addr_002A           equ       $002A     ; absolute address used by original code
Addr_002B           equ       $002B     ; absolute address used by original code
Addr_002C           equ       $002C     ; absolute address used by original code
Addr_002F           equ       $002F     ; absolute address used by original code
Addr_0032           equ       $0032     ; absolute address used by original code
Addr_0034           equ       $0034     ; absolute address used by original code
Addr_0035           equ       $0035     ; absolute address used by original code
Addr_024E           equ       $024E     ; absolute address used by original code
Addr_0372           equ       $0372     ; absolute address used by original code
Addr_084E           equ       $084E     ; absolute address used by original code
Addr_0D01           equ       $0D01     ; absolute address used by original code
Addr_0E00           equ       $0E00     ; absolute address used by original code
Addr_0E4E           equ       $0E4E     ; absolute address used by original code
Addr_9000           equ       $9000     ; absolute address used by original code
Addr_A100           equ       $A100     ; absolute address used by original code
Addr_C000           equ       $C000     ; absolute address used by original code
Addr_FFD8           equ       $FFD8     ; absolute address used by original code
Addr_FFF8           equ       $FFF8     ; absolute address used by original code
DeskMateService     equ       $0000     ; absolute address used by original code

start               jmp       >DeskMateService ; dispatch control through the selected target
Code_0017           leas      $320A,U   ; form the referenced address without reading memory
Code_001B           pshs      X         ; preserve the listed registers on the stack
Code_001D           leax      Data_46A5,PCR ; form the referenced address without reading memory
Code_0021           lbsr      start     ; invoke the patched DeskMate service dispatcher
Data_0024           fcb       $07       ; private DeskMate service selector
Code_0025           lbsr      start     ; invoke the patched DeskMate service dispatcher
Data_0028           fcb       $06       ; private DeskMate service selector
Code_0029           leax      Data_4EA7,PCR ; form the referenced address without reading memory
Code_002D           lbsr      start     ; invoke the patched DeskMate service dispatcher
Data_0030           fcb       $08       ; private DeskMate service selector
Code_0031           puls      X         ; restore the listed registers from the stack
Code_0033           lbra      Code_0153 ; continue at the distant control-flow target
Data_0036           fcc       "("                            ; embedded text or resource bytes
Data_0037           fcb       $0B       ; table, bitmap, or initialized data bytes
Data_0038           fcb       $CC       ; table, bitmap, or initialized data bytes
Data_0039           fcb       $CC       ; table, bitmap, or initialized data bytes
Data_003A           fcb       $CC       ; table, bitmap, or initialized data bytes
Data_003B           fcb       $CC       ; table, bitmap, or initialized data bytes
Data_003C           fcb       $CC       ; table, bitmap, or initialized data bytes
Data_003D           fcb       $CC,$CC   ; table, bitmap, or initialized data bytes
Data_003F           fcb       $CC       ; table, bitmap, or initialized data bytes
Data_0040           fcb       $CC       ; table, bitmap, or initialized data bytes
Data_0041           fcb       $CC       ; table, bitmap, or initialized data bytes
Data_0042           fcb       $CC       ; table, bitmap, or initialized data bytes
Data_0043           fcb       $CC       ; table, bitmap, or initialized data bytes
Data_0044           fcb       $CC,$CC   ; table, bitmap, or initialized data bytes
Data_0046           fcb       $CC       ; table, bitmap, or initialized data bytes
Data_0047           fcb       $CC,$00   ; table, bitmap, or initialized data bytes
Data_0049           fcb       $00,$00   ; table, bitmap, or initialized data bytes
Data_004B           fcb       $00,$00   ; table, bitmap, or initialized data bytes
Data_004D           fcb       $00,$03   ; table, bitmap, or initialized data bytes
Data_004F           fcc       "0"                            ; embedded text or resource bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
Data_0051           fcc       "0"                            ; embedded text or resource bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
Data_0053           fcc       "0"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_0055           fcb       $00,$00   ; table, bitmap, or initialized data bytes
Data_0057           fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "333333333333"                 ; embedded text or resource bytes
Data_0064           fcc       "3333"                         ; embedded text or resource bytes
                    fcb       $0F,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FF,$FF,$FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $F0,$FF,$FC,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$FF,$FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FF,$0F,$FF,$03,$FF,$03 ; table, bitmap, or initialized data bytes
                    fcb       $FF,$03,$FF,$03,$FF,$03 ; table, bitmap, or initialized data bytes
                    fcb       $FF,$03,$FF,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$03,$FF,$03,$FF,$03 ; table, bitmap, or initialized data bytes
                    fcb       $FF,$03,$FF,$03,$FF,$03 ; table, bitmap, or initialized data bytes
                    fcb       $FF,$03,$FF,$03,$FF,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$0F ; table, bitmap, or initialized data bytes
                    fcb       $F0,$0F,$F0,$0F,$F0,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00 ; table, bitmap, or initialized data bytes
Data_00E8           fcc       "("                            ; embedded text or resource bytes
                    fcb       $04,$08,$0A,$AA,$AA,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0A,$00,$0A,$00,$0A,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0A,$00,$0A,$00,$0A,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0A,$00,$0A,$00 ; table, bitmap, or initialized data bytes
Data_00FF           fcb       $0A       ; table, bitmap, or initialized data bytes
Data_0100           fcb       $00,$0A,$00,$0A,$00,$0A ; table, bitmap, or initialized data bytes
                    fcb       $00,$0A,$AA,$AA,$00 ; table, bitmap, or initialized data bytes
Data_010B           fcc       "("                            ; embedded text or resource bytes
                    fcb       $04,$08,$0A,$AA,$AF,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0A,$00,$0E,$00,$0A,$00 ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $00,$0A,$00,$CA,$00,$08 ; table, bitmap, or initialized data bytes
                    fcb       $C3,$0A,$00,$0A ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $0A,$00,$0A,$0F,$0A,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0A,$AA,$AA,$00 ; table, bitmap, or initialized data bytes
Data_012E           fcc       "("                            ; embedded text or resource bytes
                    fcb       $FF,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $1A,$00,$FF,$80 ; table, bitmap, or initialized data bytes
Data_0136           fcc       "FIL"                          ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_013A           fcc       "TMP"                          ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_013E           fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $18       ; table, bitmap, or initialized data bytes
Data_0145           fcc       "  File Name: "                ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_0153           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "3"                            ; embedded text or resource bytes
                    lda       #$28      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $09       ; private DeskMate service selector
                    ldb       #$0A      ; load the value needed by the following operation
                    leay      $59,U     ; form the referenced address without reading memory
Code_0162           lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    beq       Code_016F ; branch when the compared values are equal
                    sta       ,Y+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bne       Code_0162 ; branch when the compared values differ
                    bra       Code_0176 ; continue at the selected control-flow target
Code_016F           lda       #$20      ; load the value needed by the following operation
                    sta       ,Y+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bne       Code_016F ; branch when the compared values differ
Code_0176           stb       ,Y+       ; store the value and advance the destination pointer
                    leax      Data_0038,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $06       ; private DeskMate service selector
Code_0180           lda       #$28      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $09       ; private DeskMate service selector
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    leax      >Data_012E,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    lbsr      Code_1A8D ; call the referenced helper routine
                    lda       #$05      ; load the value needed by the following operation
                    leax      $30D9,U   ; form the referenced address without reading memory
Code_01A0           clr       ,X+       ; clear the selected byte or register
                    deca                ; decrement the selected counter
                    bne       Code_01A0 ; branch when the compared values differ
                    lbsr      Code_30B5 ; call the referenced helper routine
                    clr       Data_0028 ; clear the selected byte or register
                    clr       Code_0029 ; clear the selected byte or register
                    clr       Addr_002B ; clear the selected byte or register
                    clr       Data_003B ;01AE: 0F 3B          '. ; clear the selected byte or register
                    clr       Addr_002C ; clear the selected byte or register
                    clr       Data_0030 ; clear the selected byte or register
                    clr       Data_0039 ; clear the selected byte or register
                    clr       Data_0038 ; clear the selected byte or register
                    lda       #$12      ; load the value needed by the following operation
                    sta       Addr_0012 ; save the current value in working storage
                    lda       #$02      ; load the value needed by the following operation
                    sta       Addr_0011 ; save the current value in working storage
                    lbsr      Code_04B4 ; call the referenced helper routine
                    lda       $59,U     ; load the value needed by the following operation
                    cmpa      #$30      ; compare against the limit and set condition flags
                    beq       Code_01D6 ; branch when the compared values are equal
                    cmpa      #$33      ; compare against the limit and set condition flags
                    beq       Code_01D6 ; branch when the compared values are equal
                    cmpa      #$34      ; compare against the limit and set condition flags
                    beq       Code_01D6 ; branch when the compared values are equal
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bne       Code_01DE ; branch when the compared values differ
Code_01D6           lbsr      Code_0596 ; call the referenced helper routine
                    lbsr      Code_2BD1 ; call the referenced helper routine
                    bra       Code_01E4 ; continue at the selected control-flow target
Code_01DE           lbsr      Code_056C ; call the referenced helper routine
                    tstb                ; set condition flags from the current value
                    bmi       Code_01D6 ; branch while the tested value is negative
Code_01E4           lbsr      Code_0572 ; call the referenced helper routine
                    lbsr      Code_2052 ; call the referenced helper routine
                    lbsr      Code_056C ; call the referenced helper routine
                    lbsr      Code_2CC9 ; call the referenced helper routine
                    leax      $088B,U   ; form the referenced address without reading memory
                    lbsr      Code_1EB3 ; call the referenced helper routine
                    lbcs      Code_04C2 ; take the distant branch when carry reports an error
                    lbsr      Code_2350 ; call the referenced helper routine
                    ldd       #Addr_0D01 ; load the value needed by the following operation
                    cmpd      $136A,U   ; compare against the limit and set condition flags
                    bne       Code_020F ; branch when the compared values differ
                    lda       #$20      ; load the value needed by the following operation
                    ldb       #$27      ; load the value needed by the following operation
                    lbsr      Code_05EA ; call the referenced helper routine
Code_020F           lda       #$27      ; load the value needed by the following operation
                    sta       Data_0041 ; save the current value in working storage
                    lda       #$18      ; load the value needed by the following operation
                    sta       Data_0042 ; save the current value in working storage
                    lbsr      Code_3A23 ; call the referenced helper routine
                    ldd       #Code_0D80 ; load the value needed by the following operation
                    cmpd      $136A,U   ; compare against the limit and set condition flags
                    lbne      Code_1FDD ; take the distant branch when values differ
                    lbsr      Code_3725 ; call the referenced helper routine
                    ldd       #DeskMateService ; load the value needed by the following operation
                    std       $1371,U   ; save the current value in working storage
                    lbsr      Code_2437 ; call the referenced helper routine
                    bne       Code_023A ; branch when the compared values differ
                    lbsr      Code_1E60 ; call the referenced helper routine
                    bra       Code_0242 ; continue at the selected control-flow target
Code_023A           lbsr      Code_23EC ; call the referenced helper routine
                    bne       Code_0242 ; branch when the compared values differ
                    lbsr      Code_1E32 ; call the referenced helper routine
Code_0242           ldb       #$80      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    lbne      Code_02E3 ; take the distant branch when values differ
                    lbsr      Code_3AA5 ; call the referenced helper routine
Code_024F           tsta                ; set condition flags from the current value
                    beq       Code_0242 ; branch when the compared values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    beq       Code_0288 ; branch when the compared values are equal
                    cmpa      #$03      ; compare against the limit and set condition flags
                    lbeq      Code_02B3 ; take the distant branch when values are equal
                    cmpa      #$02      ; compare against the limit and set condition flags
                    beq       Code_029E ; branch when the compared values are equal
                    cmpa      #$01      ; compare against the limit and set condition flags
                    bne       Code_0242 ; branch when the compared values differ
                    lda       Addr_0026 ; load the value needed by the following operation
                    cmpa      #$00      ; compare against the limit and set condition flags
                    lbeq      Code_03BD ; take the distant branch when values are equal
                    cmpa      #$01      ; compare against the limit and set condition flags
                    lbeq      Code_038F ; take the distant branch when values are equal
                    cmpa      #$02      ; compare against the limit and set condition flags
                    lbeq      Code_03C8 ; take the distant branch when values are equal
                    cmpa      #$03      ; compare against the limit and set condition flags
                    beq       Code_02E7 ; branch when the compared values are equal
                    cmpa      #$04      ; compare against the limit and set condition flags
                    beq       Code_02F1 ; branch when the compared values are equal
                    cmpa      #$07      ; compare against the limit and set condition flags
                    lbeq      Code_050C ; take the distant branch when values are equal
                    bra       Code_0242 ; continue at the selected control-flow target
Code_0288           lbsr      Code_23EC ; call the referenced helper routine
                    beq       Code_0242 ; branch when the compared values are equal
                    lda       Addr_0026 ; load the value needed by the following operation
                    cmpa      #$03      ; compare against the limit and set condition flags
                    lbeq      Code_0332 ; take the distant branch when values are equal
                    cmpa      #$04      ; compare against the limit and set condition flags
                    lbeq      Code_0341 ; take the distant branch when values are equal
                    lbra      Code_044F ; continue at the distant control-flow target
Code_029E           ldb       Addr_0026 ; load the value needed by the following operation
                    cmpb      #$03      ; compare against the limit and set condition flags
                    beq       Code_02FA ; branch when the compared values are equal
                    cmpb      #$04      ; compare against the limit and set condition flags
                    beq       Code_0303 ; branch when the compared values are equal
                    lbsr      Code_3C03 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    lbne      Code_0242 ; take the distant branch when values differ
                    lbra      Code_030C ; continue at the distant control-flow target
Code_02B3           lda       Addr_0026 ; load the value needed by the following operation
                    cmpa      #$04      ; compare against the limit and set condition flags
                    beq       Code_02BF ; branch when the compared values are equal
                    cmpa      #$03      ; compare against the limit and set condition flags
                    lbne      Code_0242 ; take the distant branch when values differ
Code_02BF           pshs      A         ; preserve the listed registers on the stack
Code_02C1           cmpa      #$03      ; compare against the limit and set condition flags
                    bne       Code_02CA ; branch when the compared values differ
                    lbsr      Code_383E ; call the referenced helper routine
                    bra       Code_02CD ; continue at the selected control-flow target
Code_02CA           lbsr      Code_381C ; call the referenced helper routine
Code_02CD           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $16       ; private DeskMate service selector
                    lbsr      Code_3AA5 ; call the referenced helper routine
                    cmpa      #$04      ; compare against the limit and set condition flags
                    beq       Code_02DE ; branch when the compared values are equal
                    lda       Addr_0026 ; load the value needed by the following operation
                    cmpa      ,S        ; compare against the limit and set condition flags
                    beq       Code_02C1 ; branch when the compared values are equal
Code_02DE           leas      $01,S     ; form the referenced address without reading memory
                    lbra      Code_024F ; continue at the distant control-flow target
Code_02E3           cmpa      #$0C      ; compare against the limit and set condition flags
                    bne       Code_02ED ; branch when the compared values differ
Code_02E7           lbsr      Code_383E ; call the referenced helper routine
Code_02EA           lbra      Code_0242 ; continue at the distant control-flow target
Code_02ED           cmpa      #$0A      ; compare against the limit and set condition flags
                    bne       Code_02F6 ; branch when the compared values differ
Code_02F1           lbsr      Code_381C ; call the referenced helper routine
                    bra       Code_02EA ; continue at the selected control-flow target
Code_02F6           cmpa      #$1C      ; compare against the limit and set condition flags
                    bne       Code_02FF ; branch when the compared values differ
Code_02FA           lbsr      Code_38B9 ; call the referenced helper routine
                    bra       Code_02EA ; continue at the selected control-flow target
Code_02FF           cmpa      #$1A      ; compare against the limit and set condition flags
                    bne       Code_0308 ; branch when the compared values differ
Code_0303           lbsr      Code_38F5 ; call the referenced helper routine
                    bra       Code_02EA ; continue at the selected control-flow target
Code_0308           cmpa      #$0D      ; compare against the limit and set condition flags
                    bne       Code_031C ; branch when the compared values differ
Code_030C           lbsr      Code_23EC ; call the referenced helper routine
                    beq       Code_02EA ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       ":"                            ; embedded text or resource bytes
                    lbra      Code_1052 ; continue at the distant control-flow target
Code_031C           cmpa      #$05      ; compare against the limit and set condition flags
                    lbeq      Code_0547 ; take the distant branch when values are equal
                    cmpa      #$BA      ; compare against the limit and set condition flags
                    lbeq      Code_050C ; take the distant branch when values are equal
                    cmpa      #$AF      ; compare against the limit and set condition flags
                    lbeq      Code_03C8 ; take the distant branch when values are equal
                    cmpa      #$13      ; compare against the limit and set condition flags
                    bne       Code_033D ; branch when the compared values differ
Code_0332           lbsr      Code_2402 ; call the referenced helper routine
Code_0335           lbsr      Code_392C ; call the referenced helper routine
                    lbsr      Code_3725 ; call the referenced helper routine
                    bra       Code_02EA ; continue at the selected control-flow target
Code_033D           cmpa      #$12      ; compare against the limit and set condition flags
                    bne       Code_0346 ; branch when the compared values differ
Code_0341           lbsr      Code_23F9 ; call the referenced helper routine
                    bra       Code_0335 ; continue at the selected control-flow target
Code_0346           cmpa      #$B2      ; compare against the limit and set condition flags
                    bne       Code_0352 ; branch when the compared values differ
                    lbsr      Code_23EC ; call the referenced helper routine
                    beq       Code_02EA ; branch when the compared values are equal
                    lbra      Code_03E1 ; continue at the distant control-flow target
Code_0352           cmpa      #$B4      ; compare against the limit and set condition flags
                    bne       Code_035E ; branch when the compared values differ
                    lbsr      Code_2437 ; call the referenced helper routine
                    beq       Code_02EA ; branch when the compared values are equal
                    lbra      Code_150D ; continue at the distant control-flow target
Code_035E           cmpa      #$B6      ; compare against the limit and set condition flags
                    bne       Code_036C ; branch when the compared values differ
                    lbsr      Code_23EC ; call the referenced helper routine
                    lbeq      Code_02EA ; take the distant branch when values are equal
                    lbra      Code_0437 ; continue at the distant control-flow target
Code_036C           cmpa      #$B5      ; compare against the limit and set condition flags
                    bne       Code_037A ; branch when the compared values differ
                    lbsr      Code_23EC ; call the referenced helper routine
                    lbeq      Code_02EA ; take the distant branch when values are equal
                    lbra      Code_0462 ; continue at the distant control-flow target
Code_037A           cmpa      #$8C      ; compare against the limit and set condition flags
                    lbne      Code_02EA ; take the distant branch when values differ
                    ldb       Addr_0026 ; load the value needed by the following operation
                    lbpl      Code_0242 ; take the distant branch while the value is nonnegative
                    lbsr      Code_1323 ; call the referenced helper routine
                    tst       Addr_001F ; set condition flags from the current value
                    bmi       Code_03D8 ; branch while the tested value is negative
                    beq       Code_03BD ; branch when the compared values are equal
Code_038F           lbsr      Code_1B77 ; call the referenced helper routine
                    cmpb      #$05      ; compare against the limit and set condition flags
                    beq       Code_03CB ; branch when the compared values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    beq       Code_03C8 ; branch when the compared values are equal
                    cmpa      #$03      ; compare against the limit and set condition flags
                    lbeq      Code_0433 ; take the distant branch when values are equal
                    cmpa      #$02      ; compare against the limit and set condition flags
                    lbeq      Code_0462 ; take the distant branch when values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    beq       Code_03C8 ; branch when the compared values are equal
                    cmpa      #$00      ; compare against the limit and set condition flags
                    lbeq      Code_1052 ; take the distant branch when values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "?"                            ; embedded text or resource bytes
                    cmpa      #$01      ; compare against the limit and set condition flags
Code_03B6           lbeq      Code_150D ; take the distant branch when values are equal
                    lbra      Code_0A10 ; continue at the distant control-flow target
Code_03BD           lbsr      Code_1B30 ; call the referenced helper routine
                    cmpb      #$05      ; compare against the limit and set condition flags
                    beq       Code_03CB ; branch when the compared values are equal
                    cmpa      #$02      ; compare against the limit and set condition flags
                    bne       Code_03DB ; branch when the compared values differ
Code_03C8           lbsr      Code_1D60 ; call the referenced helper routine
Code_03CB           lbsr      Code_3DA9 ; call the referenced helper routine
                    lbsr      Code_2BD1 ; call the referenced helper routine
                    lbsr      Code_3725 ; call the referenced helper routine
                    clr       Data_0039 ; clear the selected byte or register
                    clr       Data_0038 ; clear the selected byte or register
Code_03D8           lbra      Code_0242 ; continue at the distant control-flow target
Code_03DB           cmpa      #$00      ; compare against the limit and set condition flags
                    lbeq      Code_0547 ; take the distant branch when values are equal
Code_03E1           lbsr      Code_2DCA ; call the referenced helper routine
                    bcs       Code_041D ; branch when carry reports an unsigned underflow or error
                    bsr       Code_0425 ; call the referenced helper routine
                    bne       Code_0404 ; branch when the compared values differ
Code_03EA           stx       Data_0049 ; save the current value in working storage
                    sty       Addr_000C ; save the current value in working storage
                    lbsr      Code_2CF5 ; call the referenced helper routine
                    bcs       Code_041A ; branch when carry reports an unsigned underflow or error
                    lbsr      Code_3A06 ; call the referenced helper routine
                    ldx       Data_0049 ; load the value needed by the following operation
                    ldy       Addr_000C ; load the value needed by the following operation
                    lbsr      Code_39F5 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_03EA ; branch when the compared values are equal
                    bra       Code_041A ; continue at the selected control-flow target
Code_0404           lbsr      Code_23F9 ; call the referenced helper routine
                    ldx       Addr_000C ; load the value needed by the following operation
Code_0409           cmpx      Addr_0006 ; compare against the limit and set condition flags
                    beq       Code_041A ; branch when the compared values are equal
                    stx       Addr_000C ; save the current value in working storage
                    lbsr      Code_2CF5 ; call the referenced helper routine
                    bcs       Code_041A ; branch when carry reports an unsigned underflow or error
                    ldx       Addr_000C ; load the value needed by the following operation
                    leax      $04,X     ; form the referenced address without reading memory
                    bra       Code_0409 ; continue at the selected control-flow target
Code_041A           lbsr      Code_2DFF ; call the referenced helper routine
Code_041D           lbsr      Code_23F9 ; call the referenced helper routine
                    lbsr      Code_392C ; call the referenced helper routine
                    bra       Code_03CB ; continue at the selected control-flow target
Code_0425           leax      $1373,U   ; form the referenced address without reading memory
                    leay      $66,U     ; form the referenced address without reading memory
                    leay      $03,Y     ; form the referenced address without reading memory
                    lbsr      Code_39F5 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    rts                 ; return to the caller
Code_0433           bsr       Code_043E ; call the referenced helper routine
                    bra       Code_03CB ; continue at the selected control-flow target
Code_0437           bsr       Code_043E ; call the referenced helper routine
                    lbsr      Code_3725 ; call the referenced helper routine
                    bra       Code_045F ; continue at the selected control-flow target
Code_043E           ldx       Data_0049 ; load the value needed by the following operation
                    lda       ,X        ; load the value needed by the following operation
                    cmpa      #$2A      ; compare against the limit and set condition flags
                    beq       Code_044B ; branch when the compared values are equal
                    lbsr      Code_3A0A ; call the referenced helper routine
                    bra       Code_044E ; continue at the selected control-flow target
Code_044B           lbsr      Code_3A06 ; call the referenced helper routine
Code_044E           rts                 ; return to the caller
Code_044F           lbsr      Code_23EC ; call the referenced helper routine
                    beq       Code_045F ; branch when the compared values are equal
                    lbsr      Code_3BFD ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    bne       Code_045F ; branch when the compared values differ
                    bsr       Code_043E ; call the referenced helper routine
                    lbsr      Code_3725 ; call the referenced helper routine
Code_045F           lbra      Code_0242 ; continue at the distant control-flow target
Code_0462           bsr       Code_0425 ; call the referenced helper routine
                    bne       Code_0481 ; branch when the compared values differ
Code_0466           stx       Data_0049 ; save the current value in working storage
                    sty       Addr_000C ; save the current value in working storage
                    lbsr      Code_2478 ; call the referenced helper routine
                    lbsr      Code_39DE ; call the referenced helper routine
                    ldx       Data_0049 ; load the value needed by the following operation
                    ldy       Addr_000C ; load the value needed by the following operation
                    lbsr      Code_39F5 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_0466 ; branch when the compared values are equal
                    lbsr      Code_23F9 ; call the referenced helper routine
                    bra       Code_0487 ; continue at the selected control-flow target
Code_0481           lbsr      Code_2478 ; call the referenced helper routine
                    lbsr      Code_39DE ; call the referenced helper routine
Code_0487           lbsr      Code_392C ; call the referenced helper routine
                    lbsr      Code_23EC ; call the referenced helper routine
                    bne       Code_0492 ; branch when the compared values differ
                    lbsr      Code_1E32 ; call the referenced helper routine
Code_0492           lbra      Code_03CB ; continue at the distant control-flow target
Code_0495           leax      $1351,U   ; form the referenced address without reading memory
Code_0499           lda       ,X        ; load the value needed by the following operation
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    beq       Code_04A3 ; branch when the compared values are equal
                    leax      $01,X     ; form the referenced address without reading memory
                    bra       Code_0499 ; continue at the selected control-flow target
Code_04A3           stx       Data_0047 ; save the current value in working storage
                    leax      $66,U     ; form the referenced address without reading memory
                    pshs      X         ; preserve the listed registers on the stack
                    ldd       Data_0064 ; load the value needed by the following operation
                    subd      #Addr_0002 ; subtract the operand from the running value
                    addd      ,S++      ; add the operand to the running value
                    std       Addr_0006 ; save the current value in working storage
                    rts                 ; return to the caller
Code_04B4           lbsr      Code_2B14 ; call the referenced helper routine
                    lbsr      Code_2BD1 ; call the referenced helper routine
                    lbsr      Code_2C8C ; call the referenced helper routine
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Addr_0026 ; save the current value in working storage
                    rts                 ; return to the caller
Code_04C2           lda       #$27      ; load the value needed by the following operation
                    sta       Data_0041 ; save the current value in working storage
                    lda       #$18      ; load the value needed by the following operation
                    sta       Data_0042 ; save the current value in working storage
                    leax      $088B,U   ; form the referenced address without reading memory
                    lbsr      Code_2281 ; call the referenced helper routine
                    leax      $1373,U   ; form the referenced address without reading memory
                    lda       #$FF      ; load the value needed by the following operation
                    sta       ,X        ; save the current value in working storage
                    stx       Data_0049 ; save the current value in working storage
                    stx       Data_004D ; save the current value in working storage
                    stx       Data_004F ; save the current value in working storage
                    stx       Data_004B ; save the current value in working storage
                    lbsr      Code_1E32 ; call the referenced helper routine
                    ldd       #DeskMateService ; load the value needed by the following operation
                    std       $1371,U   ; save the current value in working storage
                    lbra      Code_06CF ; continue at the distant control-flow target
Code_04EE           bsr       Code_04B4 ; call the referenced helper routine
                    lbsr      Code_2CC9 ; call the referenced helper routine
                    lbsr      Code_3725 ; call the referenced helper routine
                    clr       Data_0039 ; clear the selected byte or register
                    clr       Data_0038 ; clear the selected byte or register
                    clr       Data_003B ;04FA: 0F 3B          '. ; clear the selected byte or register
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Addr_0026 ; save the current value in working storage
                    lbra      Code_0242 ; continue at the distant control-flow target
Data_0503           fcb       $FC,$00,$0D ; table, bitmap, or initialized data bytes
Data_0506           fcc       "DMALT"                        ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
Code_050C           ldx       #Addr_FFD8 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "O"                            ; embedded text or resource bytes
                    leas      -$06,S    ; form the referenced address without reading memory
                    pshs      U         ; preserve the listed registers on the stack
                    lbsr      Code_1E67 ; call the referenced helper routine
                    leau      >Data_0503,PCR ; form the referenced address without reading memory
                    ldd       #Data_0100 ; load the value needed by the following operation
                    leax      >Data_0506,PCR ; form the referenced address without reading memory
                    ldy       #Addr_0003 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "V"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "P"                            ; embedded text or resource bytes
                    puls      U         ; restore the listed registers from the stack
                    lda       #$01      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    lbsr      Code_1A8D ; call the referenced helper routine
                    lbsr      Code_1E86 ; call the referenced helper routine
                    leas      $06,S     ; form the referenced address without reading memory
                    bra       Code_04EE ; continue at the selected control-flow target
Code_0547           clr       Code_0031 ; clear the selected byte or register
                    lbsr      Code_3511 ; call the referenced helper routine
                    lbsr      Code_3A11 ; call the referenced helper routine
                    lda       #$FF      ; load the value needed by the following operation
                    sta       $1371,U   ; save the current value in working storage
                    lbsr      Code_22C6 ; call the referenced helper routine
Code_0558           lda       #$01      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    lbsr      Code_1EBD ; call the referenced helper routine
Code_0561           lbsr      Code_0572 ; call the referenced helper routine
                    lbsr      Code_1FE3 ; call the referenced helper routine
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "W"                            ; embedded text or resource bytes
Code_056C           leax      Data_0136,PCR ; form the referenced address without reading memory
                    bra       Code_0576 ; continue at the selected control-flow target
Code_0572           leax      Data_013A,PCR ; form the referenced address without reading memory
Code_0576           pshs      X         ; preserve the listed registers on the stack
                    lda       #$3C      ; load the value needed by the following operation
                    leay      Data_013E,PCR ; form the referenced address without reading memory
                    leax      $59,U     ; form the referenced address without reading memory
                    stx       ,Y++      ; store the value and advance the destination pointer
                    puls      X         ; restore the listed registers from the stack
                    stx       ,Y++      ; store the value and advance the destination pointer
                    leax      $088B,U   ; form the referenced address without reading memory
                    stx       ,Y        ; save the current value in working storage
                    leay      Data_013E,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "J"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_0596           leax      $59,U     ; form the referenced address without reading memory
                    ldb       #$0A      ; load the value needed by the following operation
                    lda       #$20      ; load the value needed by the following operation
Code_059D           sta       ,X+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bne       Code_059D ; branch when the compared values differ
                    lda       #$3C      ; load the value needed by the following operation
                    leay      Data_013E,PCR ; form the referenced address without reading memory
                    leax      $59,U     ; form the referenced address without reading memory
                    stx       ,Y++      ; store the value and advance the destination pointer
                    leax      Data_0136,PCR ; form the referenced address without reading memory
                    stx       ,Y++      ; store the value and advance the destination pointer
                    leax      $088B,U   ; form the referenced address without reading memory
                    stx       ,Y        ; save the current value in working storage
                    leay      Data_013E,PCR ; form the referenced address without reading memory
                    leax      Data_0145,PCR ; form the referenced address without reading memory
                    lbsr      Code_4312 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    bne       Code_0561 ; branch when the compared values differ
                    rts                 ; return to the caller
Code_05C8           pshs      D         ; preserve the listed registers on the stack
                    bra       Code_05D0 ; continue at the selected control-flow target
Code_05CC           pshs      D         ; preserve the listed registers on the stack
                    tfr       B,A       ; copy the source register into the destination register
Code_05D0           cmpa      #$7E      ; compare against the limit and set condition flags
                    beq       Code_05E3 ; branch when the compared values are equal
                    tsta                ; set condition flags from the current value
                    bpl       Code_05E7 ; branch while the tested value is nonnegative
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    beq       Code_05DF ; branch when the compared values are equal
                    cmpa      #$A8      ; compare against the limit and set condition flags
                    bgt       Code_05E7 ; branch when the signed value is above the limit
Code_05DF           lda       #$FF      ; load the value needed by the following operation
                    puls      PC,D      ; restore the listed registers from the stack
Code_05E3           lda       #$01      ; load the value needed by the following operation
                    puls      PC,D      ; restore the listed registers from the stack
Code_05E7           clra                ; clear the selected byte or register
                    puls      PC,D      ; restore the listed registers from the stack
Code_05EA           pshs      B         ; preserve the listed registers on the stack
                    sta       Data_0041 ; save the current value in working storage
                    bsr       Code_061F ; call the referenced helper routine
                    bsr       Code_0648 ; call the referenced helper routine
                    puls      A         ; restore the listed registers from the stack
                    sta       Data_0041 ; save the current value in working storage
                    bsr       Code_0661 ; call the referenced helper routine
                    lbsr      Code_06A6 ; call the referenced helper routine
                    ldd       #Code_0D80 ; load the value needed by the following operation
                    std       $136A,U   ; save the current value in working storage
                    lbsr      Code_242F ; call the referenced helper routine
                    lbsr      Code_23CF ; call the referenced helper routine
                    ldd       $1371,U   ; load the value needed by the following operation
                    pshs      D         ; preserve the listed registers on the stack
                    ldd       #Addr_0001 ; load the value needed by the following operation
                    std       $1371,U   ; save the current value in working storage
                    lbsr      Code_22C6 ; call the referenced helper routine
                    puls      D         ; restore the listed registers from the stack
                    std       $1371,U   ; save the current value in working storage
                    rts                 ; return to the caller
Code_061F           leax      $0519,U   ; form the referenced address without reading memory
Code_0623           lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    beq       Code_063B ; branch when the compared values are equal
                    lda       Data_0041 ; load the value needed by the following operation
Code_062B           leax      A,X       ; form the referenced address without reading memory
                    tst       ,X        ; set condition flags from the current value
                    bmi       Code_0623 ; branch while the tested value is negative
                    leay      $03,X     ; form the referenced address without reading memory
                    bsr       Code_063C ; call the referenced helper routine
                    lda       Data_0041 ; load the value needed by the following operation
                    suba      #$02      ; subtract the operand from the running value
                    bra       Code_062B ; continue at the selected control-flow target
Code_063B           rts                 ; return to the caller
Code_063C           pshs      X         ; preserve the listed registers on the stack
Code_063E           lda       ,Y+       ; fetch the next value and advance the source pointer
                    sta       ,X+       ; store the value and advance the destination pointer
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    bne       Code_063E ; branch when the compared values differ
                    puls      PC,X      ; restore the listed registers from the stack
Code_0648           leax      $0519,U   ; form the referenced address without reading memory
Code_064C           lda       ,X        ; load the value needed by the following operation
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    beq       Code_0660 ; branch when the compared values are equal
                    cmpa      #$7E      ; compare against the limit and set condition flags
                    beq       Code_065A ; branch when the compared values are equal
                    leax      $01,X     ; form the referenced address without reading memory
                    bra       Code_064C ; continue at the selected control-flow target
Code_065A           leay      $01,X     ; form the referenced address without reading memory
                    bsr       Code_063C ; call the referenced helper routine
                    bra       Code_064C ; continue at the selected control-flow target
Code_0660           rts                 ; return to the caller
Code_0661           lda       #$7F      ; load the value needed by the following operation
                    sta       Data_0043 ; save the current value in working storage
                    leax      $0519,U   ; form the referenced address without reading memory
Code_0669           lda       ,X+       ; fetch the next value and advance the source pointer
                    lbsr      Code_05C8 ; call the referenced helper routine
                    bpl       Code_0678 ; branch while the tested value is nonnegative
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    beq       Code_068A ; branch when the compared values are equal
Code_0674           ldb       Data_0041 ; load the value needed by the following operation
                    bra       Code_0669 ; continue at the selected control-flow target
Code_0678           decb                ; decrement the selected counter
                    bne       Code_0669 ; branch when the compared values differ
                    lda       ,X        ; load the value needed by the following operation
                    lbsr      Code_05C8 ; call the referenced helper routine
                    bmi       Code_0669 ; branch while the tested value is negative
                    ldb       #$03      ; load the value needed by the following operation
                    bsr       Code_068B ; call the referenced helper routine
                    leax      $01,X     ; form the referenced address without reading memory
                    bra       Code_0674 ; continue at the selected control-flow target
Code_068A           rts                 ; return to the caller
Code_068B           pshs      Y,X       ; preserve the listed registers on the stack
Code_068D           lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    bne       Code_068D ; branch when the compared values differ
                    leay      B,X       ; form the referenced address without reading memory
Code_0695           lda       ,-X       ; load the value needed by the following operation
                    sta       ,-Y       ; save the current value in working storage
                    cmpx      ,S        ; compare against the limit and set condition flags
                    bne       Code_0695 ; branch when the compared values differ
                    lda       Data_0043 ; load the value needed by the following operation
Code_069F           sta       ,X+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bne       Code_069F ; branch when the compared values differ
                    puls      PC,Y,X    ; restore the listed registers from the stack
Code_06A6           lda       #$7E      ; load the value needed by the following operation
                    sta       Data_0043 ; save the current value in working storage
                    leay      $0519,U   ; form the referenced address without reading memory
Code_06AE           lda       ,Y+       ; fetch the next value and advance the source pointer
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    beq       Code_06CE ; branch when the compared values are equal
                    tfr       Y,X       ; copy the source register into the destination register
                    ldb       Data_0041 ; load the value needed by the following operation
Code_06B8           lda       ,X+       ; fetch the next value and advance the source pointer
                    lbsr      Code_05C8 ; call the referenced helper routine
                    bmi       Code_06C8 ; branch while the tested value is negative
                    decb                ; decrement the selected counter
                    bne       Code_06B8 ; branch when the compared values differ
Code_06C2           lda       Data_0041 ; load the value needed by the following operation
                    leay      A,Y       ; form the referenced address without reading memory
                    bra       Code_06AE ; continue at the selected control-flow target
Code_06C8           leax      -$01,X    ; form the referenced address without reading memory
                    bsr       Code_068B ; call the referenced helper routine
                    bra       Code_06C2 ; continue at the selected control-flow target
Code_06CE           rts                 ; return to the caller
Code_06CF           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $00       ; private DeskMate service selector
                    lbsr      Code_2B42 ; call the referenced helper routine
Code_06D6           lda       #$02      ; load the value needed by the following operation
                    sta       Addr_0015 ; save the current value in working storage
                    sta       Addr_001E ; save the current value in working storage
                    lda       #$03      ; load the value needed by the following operation
                    sta       Data_0039 ; save the current value in working storage
                    sta       Data_0038 ; save the current value in working storage
                    leax      $0519,U   ; form the referenced address without reading memory
                    stx       Data_0044 ; save the current value in working storage
                    lda       #$FF      ; load the value needed by the following operation
                    sta       ,X        ; save the current value in working storage
                    leax      $1351,U   ; form the referenced address without reading memory
                    stx       Data_0047 ; save the current value in working storage
Code_06F2           lbsr      Code_0789 ; call the referenced helper routine
                    tstb                ; set condition flags from the current value
                    bne       Code_0726 ; branch when the compared values differ
                    tsta                ; set condition flags from the current value
                    beq       Code_06F2 ; branch when the compared values are equal
                    lda       $0519,U   ; load the value needed by the following operation
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    lbeq      Code_265A ; take the distant branch when values are equal
Code_0705           pshs      Y,X       ; preserve the listed registers on the stack
                    bsr       Code_0711 ; call the referenced helper routine
                    lbsr      Code_0EEF ; call the referenced helper routine
                    puls      Y,X       ; restore the listed registers from the stack
                    lbra      Code_0A51 ; continue at the distant control-flow target
Code_0711           lbsr      Code_23CF ; call the referenced helper routine
                    lbsr      Code_22C6 ; call the referenced helper routine
                    clr       Code_0017 ; clear the selected byte or register
                    clr       Code_0031 ; clear the selected byte or register
                    lda       #$01      ; load the value needed by the following operation
                    sta       Addr_001E ; save the current value in working storage
                    sta       Addr_0027 ; save the current value in working storage
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Addr_0026 ; save the current value in working storage
                    rts                 ; return to the caller
Code_0726           tsta                ; set condition flags from the current value
                    beq       Code_0705 ; branch when the compared values are equal
                    lda       Addr_0026 ; load the value needed by the following operation
                    bmi       Code_075D ; branch while the tested value is negative
                    cmpa      #$02      ; compare against the limit and set condition flags
                    beq       Code_0740 ; branch when the compared values are equal
                    lda       $0519,U   ; load the value needed by the following operation
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    lbeq      Code_265A ; take the distant branch when values are equal
                    bsr       Code_0711 ; call the referenced helper routine
                    lbra      Code_0F96 ; continue at the distant control-flow target
Code_0740           lda       $0519,U   ; load the value needed by the following operation
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    beq       Code_074A ; branch when the compared values are equal
                    bsr       Code_0711 ; call the referenced helper routine
Code_074A           lbsr      Code_1D60 ; call the referenced helper routine
                    lbsr      Code_3DA9 ; call the referenced helper routine
                    lda       $0519,U   ; load the value needed by the following operation
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    lbeq      Code_26E7 ; take the distant branch when values are equal
                    lbra      Code_0FAE ; continue at the distant control-flow target
Code_075D           lda       $0519,U   ; load the value needed by the following operation
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    lbeq      Code_265A ; take the distant branch when values are equal
                    bsr       Code_0711 ; call the referenced helper routine
                    lbsr      Code_3A23 ; call the referenced helper routine
                    lbra      Code_04EE ; continue at the distant control-flow target
Code_076F           lda       Addr_0015 ; load the value needed by the following operation
                    cmpa      Data_0042 ; compare against the limit and set condition flags
                    beq       Code_0785 ; branch when the compared values are equal
                    bsr       Code_0786 ; call the referenced helper routine
Code_0777           tstb                ; set condition flags from the current value
                    bne       Code_0785 ; branch when the compared values differ
                    tsta                ; set condition flags from the current value
                    bne       Code_0785 ; branch when the compared values differ
                    lda       #$01      ; load the value needed by the following operation
                    sta       Code_0017 ; save the current value in working storage
                    bsr       Code_0789 ; call the referenced helper routine
                    bra       Code_0777 ; continue at the selected control-flow target
Code_0785           rts                 ; return to the caller
Code_0786           lbsr      Code_2501 ; call the referenced helper routine
Code_0789           bsr       Code_07BF ; call the referenced helper routine
                    tstb                ; set condition flags from the current value
                    bne       Code_07B7 ; branch when the compared values differ
                    tsta                ; set condition flags from the current value
                    bne       Code_07AC ; branch when the compared values differ
                    lbsr      Code_08A4 ; call the referenced helper routine
                    tstb                ; set condition flags from the current value
                    bne       Code_07B7 ; branch when the compared values differ
                    lbsr      Code_09E0 ; call the referenced helper routine
                    lbsr      Code_0CD8 ;079A: 17 05 3B       '.. ; call the referenced helper routine
                    lda       Addr_0015 ; load the value needed by the following operation
                    cmpa      Data_0042 ; compare against the limit and set condition flags
                    bne       Code_07A9 ; branch when the compared values differ
                    lda       #$01      ; load the value needed by the following operation
                    sta       Addr_001C ; save the current value in working storage
                    bra       Code_07AE ; continue at the selected control-flow target
Code_07A9           clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    rts                 ; return to the caller
Code_07AC           clr       Addr_001C ; clear the selected byte or register
Code_07AE           lbsr      Code_260B ; call the referenced helper routine
                    lbsr      Code_25F9 ; call the referenced helper routine
                    lda       #$FF      ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
Code_07B7           rts                 ; return to the caller
Code_07B8           ldx       Data_0044 ; load the value needed by the following operation
                    sta       ,X+       ; store the value and advance the destination pointer
                    stx       Data_0044 ; save the current value in working storage
                    rts                 ; return to the caller
Code_07BF           lda       Addr_0015 ; load the value needed by the following operation
                    sta       Addr_0010 ; save the current value in working storage
                    clr       Addr_000F ; clear the selected byte or register
                    lbsr      Code_098D ; call the referenced helper routine
                    ldx       Data_0044 ; load the value needed by the following operation
                    stx       Code_002D ; save the current value in working storage
                    lda       #$81      ; load the value needed by the following operation
                    bsr       Code_07B8 ; call the referenced helper routine
                    clr       Addr_001C ; clear the selected byte or register
                    ldb       #$0C      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "9"                            ; embedded text or resource bytes
Code_07D8           lda       #$2E      ; load the value needed by the following operation
                    bsr       Code_07B8 ; call the referenced helper routine
                    lda       #$20      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "C"                            ; embedded text or resource bytes
                    lbsr      Code_099E ; call the referenced helper routine
                    decb                ; decrement the selected counter
                    bne       Code_07D8 ; branch when the compared values differ
                    lda       #$3A      ; load the value needed by the following operation
                    bsr       Code_07B8 ; call the referenced helper routine
                    lda       #$20      ; load the value needed by the following operation
                    lbsr      Code_07B8 ; call the referenced helper routine
                    sta       Data_003A ; save the current value in working storage
                    clr       Addr_000F ; clear the selected byte or register
                    lbsr      Code_098D ; call the referenced helper routine
                    ldx       Code_002D ; load the value needed by the following operation
                    leax      $01,X     ; form the referenced address without reading memory
                    stx       Data_0044 ; save the current value in working storage
Code_07FE           ldb       #$83      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    bne       Code_080D ; branch when the compared values differ
                    lbsr      Code_3B4A ; call the referenced helper routine
                    tstb                ; set condition flags from the current value
                    beq       Code_07FE ; branch when the compared values are equal
                    rts                 ; return to the caller
Code_080D           cmpa      #$09      ; compare against the limit and set condition flags
                    bne       Code_0816 ; branch when the compared values differ
                    lbsr      Code_0BA3 ; call the referenced helper routine
                    bra       Code_07FE ; continue at the selected control-flow target
Code_0816           cmpa      #$08      ; compare against the limit and set condition flags
                    bne       Code_081F ; branch when the compared values differ
                    lbsr      Code_0BD2 ; call the referenced helper routine
                    bra       Code_07FE ; continue at the selected control-flow target
Code_081F           cmpa      #$8C      ; compare against the limit and set condition flags
                    bne       Code_0834 ; branch when the compared values differ
                    lda       #$08      ; load the value needed by the following operation
Code_0825           sta       Addr_0026 ; save the current value in working storage
                    ldx       Code_002D ; load the value needed by the following operation
                    stx       Data_0044 ; save the current value in working storage
                    lda       #$FF      ; load the value needed by the following operation
                    sta       ,X        ; save the current value in working storage
                    bsr       Code_088F ; call the referenced helper routine
                    tfr       A,B       ; copy the source register into the destination register
                    rts                 ; return to the caller
Code_0834           cmpa      #$AF      ; compare against the limit and set condition flags
                    bne       Code_083C ; branch when the compared values differ
                    lda       #$02      ; load the value needed by the following operation
                    bra       Code_0825 ; continue at the selected control-flow target
Code_083C           cmpa      #$88      ; compare against the limit and set condition flags
                    bne       Code_0845 ; branch when the compared values differ
                    lbsr      Code_0C02 ; call the referenced helper routine
                    bra       Code_07FE ; continue at the selected control-flow target
Code_0845           cmpa      #$0D      ; compare against the limit and set condition flags
                    beq       Code_086F ; branch when the compared values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    bne       Code_0851 ; branch when the compared values differ
                    lda       #$FF      ; load the value needed by the following operation
                    bra       Code_0825 ; continue at the selected control-flow target
Code_0851           cmpa      #$0C      ; compare against the limit and set condition flags
                    bne       Code_0869 ; branch when the compared values differ
                    lda       Addr_0010 ; load the value needed by the following operation
                    cmpa      #$02      ; compare against the limit and set condition flags
                    lbeq      Code_07FE ; take the distant branch when values are equal
                    bsr       Code_088F ; call the referenced helper routine
                    ldx       Code_002D ; load the value needed by the following operation
                    stx       Data_0044 ; save the current value in working storage
                    lda       #$FF      ; load the value needed by the following operation
                    sta       ,X        ; save the current value in working storage
                    clrb                ; clear the selected byte or register
                    rts                 ; return to the caller
Code_0869           lbsr      Code_0C62 ; call the referenced helper routine
                    lbra      Code_07FE ; continue at the distant control-flow target
Code_086F           clr       Addr_000F ; clear the selected byte or register
                    lbsr      Code_098D ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       ":"                            ; embedded text or resource bytes
                    ldx       Code_002D ; load the value needed by the following operation
                    leax      $01,X     ; form the referenced address without reading memory
                    ldb       #$0E      ; load the value needed by the following operation
Code_087E           lda       ,X+       ; fetch the next value and advance the source pointer
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "C"                            ; embedded text or resource bytes
                    lbsr      Code_099E ; call the referenced helper routine
                    decb                ; decrement the selected counter
                    bne       Code_087E ; branch when the compared values differ
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    stx       Data_0044 ; save the current value in working storage
                    rts                 ; return to the caller
Code_088F           clr       Addr_000F ; clear the selected byte or register
                    lbsr      Code_098D ; call the referenced helper routine
                    ldb       #$0C      ; load the value needed by the following operation
                    lda       #$20      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       ":"                            ; embedded text or resource bytes
Code_089C           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "B"                            ; embedded text or resource bytes
                    decb                ; decrement the selected counter
                    bne       Code_089C ; branch when the compared values differ
                    rts                 ; return to the caller
Code_08A4           ldb       Data_0041 ; load the value needed by the following operation
                    subb      #$0E      ; subtract the operand from the running value
Code_08A8           lda       #$20      ; load the value needed by the following operation
                    lbsr      Code_07B8 ; call the referenced helper routine
                    lda       #$82      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "C"                            ; embedded text or resource bytes
                    lbsr      Code_099E ; call the referenced helper routine
                    decb                ; decrement the selected counter
                    bne       Code_08A8 ; branch when the compared values differ
                    lda       #$01      ; load the value needed by the following operation
                    sta       Addr_001C ; save the current value in working storage
                    lbsr      Code_09C6 ; call the referenced helper routine
                    ldy       #DeskMateService ; load the value needed by the following operation
Code_08C4           ldb       #$80      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    bne       Code_08D3 ; branch when the compared values differ
                    lbsr      Code_3B4A ; call the referenced helper routine
                    tstb                ; set condition flags from the current value
                    beq       Code_08C4 ; branch when the compared values are equal
                    rts                 ; return to the caller
Code_08D3           cmpa      #$05      ; compare against the limit and set condition flags
                    bne       Code_08E1 ; branch when the compared values differ
                    lda       #$FF      ; load the value needed by the following operation
Code_08D9           sta       Addr_0026 ; save the current value in working storage
                    lbsr      Code_3B99 ; call the referenced helper routine
                    ldb       #$FF      ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_08E1           cmpa      #$8C      ; compare against the limit and set condition flags
                    bne       Code_08E9 ; branch when the compared values differ
                    lda       #$08      ; load the value needed by the following operation
                    bra       Code_08D9 ; continue at the selected control-flow target
Code_08E9           cmpa      #$AF      ; compare against the limit and set condition flags
                    bne       Code_08F1 ; branch when the compared values differ
                    lda       #$02      ; load the value needed by the following operation
                    bra       Code_08D9 ; continue at the selected control-flow target
Code_08F1           cmpa      #$0D      ; compare against the limit and set condition flags
                    lbeq      Code_0971 ; take the distant branch when values are equal
                    cmpa      #$0C      ; compare against the limit and set condition flags
                    beq       Code_0936 ;08F9: 27 3B          '' ; branch when the compared values are equal
                    cmpa      #$0A      ; compare against the limit and set condition flags
                    bne       Code_08C4 ; branch when the compared values differ
                    lda       Data_0042 ; load the value needed by the following operation
                    deca                ; decrement the selected counter
                    cmpa      Addr_0010 ; compare against the limit and set condition flags
                    beq       Code_08C4 ; branch when the compared values are equal
                    lda       #$02      ; load the value needed by the following operation
                    sta       Addr_000F ; save the current value in working storage
                    inc       Addr_0010 ; advance the selected counter
                    lbsr      Code_098D ; call the referenced helper routine
                    ldb       #$03      ; load the value needed by the following operation
Code_0911           lda       #$7F      ; load the value needed by the following operation
                    lbsr      Code_07B8 ; call the referenced helper routine
                    decb                ; decrement the selected counter
                    bne       Code_0911 ; branch when the compared values differ
                    ldb       Data_0041 ; load the value needed by the following operation
                    subb      #$02      ; subtract the operand from the running value
Code_091D           lda       #$82      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "C"                            ; embedded text or resource bytes
                    lbsr      Code_099E ; call the referenced helper routine
                    lda       #$20      ; load the value needed by the following operation
                    lbsr      Code_07B8 ; call the referenced helper routine
                    decb                ; decrement the selected counter
                    bne       Code_091D ; branch when the compared values differ
                    lbsr      Code_09C6 ; call the referenced helper routine
                    leay      $01,Y     ; form the referenced address without reading memory
                    lbra      Code_08C4 ; continue at the distant control-flow target
Code_0936           cmpy      #DeskMateService ; compare against the limit and set condition flags
                    lbeq      Code_08C4 ; take the distant branch when values are equal
                    lda       #$02      ; load the value needed by the following operation
                    sta       Addr_000F ; save the current value in working storage
                    lbsr      Code_098D ; call the referenced helper routine
                    ldb       Data_0041 ; load the value needed by the following operation
                    subb      #$02      ; subtract the operand from the running value
                    lda       #$20      ; load the value needed by the following operation
Code_094B           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "C"                            ; embedded text or resource bytes
                    lbsr      Code_099E ; call the referenced helper routine
                    decb                ; decrement the selected counter
                    bne       Code_094B ; branch when the compared values differ
                    lbsr      Code_09C6 ; call the referenced helper routine
                    lda       Data_0041 ; load the value needed by the following operation
                    deca                ; decrement the selected counter
                    sta       Addr_000F ; save the current value in working storage
                    dec       Addr_0010 ; decrement the selected counter
                    lbsr      Code_098D ; call the referenced helper routine
                    leay      -$01,Y    ; form the referenced address without reading memory
                    ldx       Data_0044 ; load the value needed by the following operation
                    lda       Data_0041 ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    nega                ; form the two's-complement negative value
                    leax      A,X       ; form the referenced address without reading memory
                    stx       Data_0044 ; save the current value in working storage
                    lbra      Code_08C4 ; continue at the distant control-flow target
Code_0971           lbsr      Code_281D ; call the referenced helper routine
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    bne       Code_097D ; branch when the compared values differ
                    lbsr      Code_0FE6 ; call the referenced helper routine
                    bra       Code_0971 ; continue at the selected control-flow target
Code_097D           sta       Data_0046 ; save the current value in working storage
                    ora       #$80      ; set the selected flag bits
                    ldx       Code_002D ; load the value needed by the following operation
                    sta       ,X        ; save the current value in working storage
                    clrb                ; clear the selected byte or register
                    lda       #$FF      ; load the value needed by the following operation
                    ldx       Data_0044 ; load the value needed by the following operation
                    sta       ,X        ; save the current value in working storage
                    rts                 ; return to the caller
Code_098D           pshs      Y,X,D     ; preserve the listed registers on the stack
                    clra                ; clear the selected byte or register
                    ldb       Addr_000F ; load the value needed by the following operation
                    tfr       D,X       ; copy the source register into the destination register
                    ldb       Addr_0010 ; load the value needed by the following operation
                    tfr       D,Y       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    puls      PC,Y,X,D  ; restore the listed registers from the stack
Code_099E           pshs      D         ; preserve the listed registers on the stack
                    lda       Data_0041 ; load the value needed by the following operation
                    deca                ; decrement the selected counter
                    cmpa      Addr_000F ; compare against the limit and set condition flags
                    beq       Code_09AE ; branch when the compared values are equal
                    inc       Addr_000F ; advance the selected counter
Code_09A9           lbsr      Code_098D ; call the referenced helper routine
                    puls      PC,D      ; restore the listed registers from the stack
Code_09AE           clr       Addr_000F ; clear the selected byte or register
                    inc       Addr_0010 ; advance the selected counter
                    lbsr      Code_098D ; call the referenced helper routine
                    lda       #$20      ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $02       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $01       ; private DeskMate service selector
                    lda       #$02      ; load the value needed by the following operation
                    sta       Addr_000F ; save the current value in working storage
                    bra       Code_09A9 ; continue at the selected control-flow target
Code_09C6           pshs      A         ; preserve the listed registers on the stack
                    lda       Addr_000F ; load the value needed by the following operation
                    cmpa      #$02      ; compare against the limit and set condition flags
                    beq       Code_09D2 ; branch when the compared values are equal
                    dec       Addr_000F ; decrement the selected counter
                    bra       Code_09DB ; continue at the selected control-flow target
Code_09D2           lda       >$0041,U  ; load the value needed by the following operation
                    deca                ; decrement the selected counter
                    sta       Addr_000F ; save the current value in working storage
                    dec       Addr_0010 ; decrement the selected counter
Code_09DB           lbsr      Code_098D ; call the referenced helper routine
                    puls      PC,A      ; restore the listed registers from the stack
Code_09E0           pshs      X,A       ; preserve the listed registers on the stack
                    ldx       Data_0047 ; load the value needed by the following operation
                    lda       Data_0046 ; load the value needed by the following operation
                    sta       ,X+       ; store the value and advance the destination pointer
                    stx       Data_0047 ; save the current value in working storage
                    lda       #$FF      ; load the value needed by the following operation
                    sta       ,X        ; save the current value in working storage
                    puls      PC,X,A    ; restore the listed registers from the stack
Code_09F0           pshs      Y,X,A     ; preserve the listed registers on the stack
                    leax      $1351,U   ; form the referenced address without reading memory
                    bsr       Code_09FC ; call the referenced helper routine
                    stx       Data_0047 ; save the current value in working storage
                    puls      PC,Y,X,A  ; restore the listed registers from the stack
Code_09FC           pshs      A         ; preserve the listed registers on the stack
Code_09FE           lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpa      ,S        ; compare against the limit and set condition flags
                    bne       Code_09FE ; branch when the compared values differ
Code_0A04           lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       -$02,X    ; save the current value in working storage
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    bne       Code_0A04 ; branch when the compared values differ
                    leax      -$02,X    ; form the referenced address without reading memory
                    puls      PC,A      ; restore the listed registers from the stack
Code_0A10           lbsr      Code_2B42 ; call the referenced helper routine
                    clr       Code_0017 ; clear the selected byte or register
                    clr       Code_0031 ; clear the selected byte or register
                    lbsr      Code_0EEF ; call the referenced helper routine
Code_0A1A           lda       #$FF      ; load the value needed by the following operation
                    sta       Addr_0026 ; save the current value in working storage
                    lbsr      Code_0CD8 ; call the referenced helper routine
                    leax      $0519,U   ; form the referenced address without reading memory
                    lda       ,X        ; load the value needed by the following operation
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    lbeq      Code_265A ; take the distant branch when values are equal
                    lda       #$01      ; load the value needed by the following operation
                    sta       Addr_001E ; save the current value in working storage
                    sta       Addr_0027 ; save the current value in working storage
                    clr       Data_003A ; clear the selected byte or register
                    lda       #$03      ; load the value needed by the following operation
                    sta       Data_0039 ; save the current value in working storage
                    sta       Data_0038 ; save the current value in working storage
                    lda       #$0D      ; load the value needed by the following operation
                    sta       Addr_000F ; save the current value in working storage
                    lda       #$02      ; load the value needed by the following operation
                    sta       Addr_0010 ; save the current value in working storage
                    lbsr      Code_098D ; call the referenced helper routine
                    leax      $12E1,U   ; form the referenced address without reading memory
                    stx       Data_0051 ; save the current value in working storage
                    lbsr      Code_257B ; call the referenced helper routine
                    clr       Addr_001C ; clear the selected byte or register
Code_0A51           ldb       #$83      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    bne       Code_0A6F ; branch when the compared values differ
                    lbsr      Code_3B28 ; call the referenced helper routine
Code_0A5C           tsta                ; set condition flags from the current value
                    beq       Code_0A51 ; branch when the compared values are equal
                    lda       Addr_0026 ; load the value needed by the following operation
                    cmpa      #$08      ; compare against the limit and set condition flags
                    lbeq      Code_0F96 ; take the distant branch when values are equal
                    cmpa      #$02      ; compare against the limit and set condition flags
                    lbeq      Code_0FAB ; take the distant branch when values are equal
                    bra       Code_0A51 ; continue at the selected control-flow target
Code_0A6F           cmpa      #$0C      ; compare against the limit and set condition flags
                    bne       Code_0A78 ; branch when the compared values differ
                    lbsr      Code_0B1D ; call the referenced helper routine
                    bra       Code_0A51 ; continue at the selected control-flow target
Code_0A78           cmpa      #$0A      ; compare against the limit and set condition flags
                    bne       Code_0A81 ; branch when the compared values differ
                    lbsr      Code_0B58 ; call the referenced helper routine
                    bra       Code_0A51 ; continue at the selected control-flow target
Code_0A81           cmpa      #$09      ; compare against the limit and set condition flags
                    bne       Code_0A8A ; branch when the compared values differ
                    lbsr      Code_0BA3 ; call the referenced helper routine
                    bra       Code_0A51 ; continue at the selected control-flow target
Code_0A8A           cmpa      #$08      ; compare against the limit and set condition flags
                    bne       Code_0AA4 ; branch when the compared values differ
                    tst       Addr_001C ; set condition flags from the current value
                    beq       Code_0A97 ; branch when the compared values are equal
                    lbsr      Code_0BD2 ; call the referenced helper routine
                    bra       Code_0AA2 ; continue at the selected control-flow target
Code_0A97           tst       Addr_000F ; set condition flags from the current value
                    beq       Code_0AA2 ; branch when the compared values are equal
                    dec       Addr_000F ; decrement the selected counter
                    lbsr      Code_098D ; call the referenced helper routine
                    leax      -$01,X    ; form the referenced address without reading memory
Code_0AA2           bra       Code_0B1A ; continue at the selected control-flow target
Code_0AA4           cmpa      #$13      ; compare against the limit and set condition flags
                    bne       Code_0AAD ; branch when the compared values differ
                    lbsr      Code_2604 ; call the referenced helper routine
                    bra       Code_0B1A ; continue at the selected control-flow target
Code_0AAD           cmpa      #$12      ; compare against the limit and set condition flags
                    bne       Code_0AB6 ; branch when the compared values differ
                    lbsr      Code_25F6 ; call the referenced helper routine
                    bra       Code_0B1A ; continue at the selected control-flow target
Code_0AB6           cmpa      #$11      ; compare against the limit and set condition flags
                    bne       Code_0ABF ; branch when the compared values differ
Code_0ABA           lbsr      Code_25D3 ; call the referenced helper routine
                    bra       Code_0B1A ; continue at the selected control-flow target
Code_0ABF           cmpa      #$10      ; compare against the limit and set condition flags
                    bne       Code_0AC8 ; branch when the compared values differ
Code_0AC3           lbsr      Code_25D9 ; call the referenced helper routine
                    bra       Code_0B1A ; continue at the selected control-flow target
Code_0AC8           cmpa      #$19      ; compare against the limit and set condition flags
                    beq       Code_0ABA ; branch when the compared values are equal
                    cmpa      #$18      ; compare against the limit and set condition flags
                    beq       Code_0AC3 ; branch when the compared values are equal
                    cmpa      #$AF      ; compare against the limit and set condition flags
                    lbeq      Code_0FAB ; take the distant branch when values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    lbeq      Code_0FC8 ; take the distant branch when values are equal
                    cmpa      #$B5      ; compare against the limit and set condition flags
                    bne       Code_0AEF ; branch when the compared values differ
                    pshs      X         ; preserve the listed registers on the stack
                    leax      $12E1,U   ; form the referenced address without reading memory
                    tst       $05,X     ; set condition flags from the current value
                    puls      X         ; restore the listed registers from the stack
                    bmi       Code_0B1A ; branch while the tested value is negative
                    lbra      Code_0C8A ; continue at the distant control-flow target
Code_0AEF           cmpa      #$88      ; compare against the limit and set condition flags
                    bne       Code_0AF8 ; branch when the compared values differ
                    lbsr      Code_0C02 ; call the referenced helper routine
                    bra       Code_0B1A ; continue at the selected control-flow target
Code_0AF8           cmpa      #$8C      ; compare against the limit and set condition flags
                    bne       Code_0B04 ; branch when the compared values differ
                    tst       Addr_0026 ; set condition flags from the current value
                    lbmi      Code_0F96 ; take the distant branch while the value is negative
                    bra       Code_0B1A ; continue at the selected control-flow target
Code_0B04           cmpa      #$0D      ; compare against the limit and set condition flags
                    bne       Code_0B0D ; branch when the compared values differ
                    lbsr      Code_25DF ; call the referenced helper routine
                    bra       Code_0B1A ; continue at the selected control-flow target
Code_0B0D           tst       Addr_001C ; set condition flags from the current value
                    beq       Code_0B17 ; branch when the compared values are equal
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bne       Code_0B17 ; branch when the compared values differ
                    lda       #$7F      ; load the value needed by the following operation
Code_0B17           lbsr      Code_0C62 ; call the referenced helper routine
Code_0B1A           lbra      Code_0A51 ; continue at the distant control-flow target
Code_0B1D           tst       Addr_001C ; set condition flags from the current value
                    bne       Code_0B25 ; branch when the compared values differ
                    lbsr      Code_25CC ; call the referenced helper routine
                    rts                 ; return to the caller
Code_0B25           lbsr      Code_0F70 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_0B4A ; branch when the compared values are equal
                    bpl       Code_0B3D ; branch while the tested value is nonnegative
                    pshs      X         ; preserve the listed registers on the stack
                    leax      $12E1,U   ; form the referenced address without reading memory
                    cmpx      Data_0051 ; compare against the limit and set condition flags
                    puls      X         ; restore the listed registers from the stack
                    beq       Code_0B3D ; branch when the compared values are equal
                    lbsr      Code_25CC ; call the referenced helper routine
                    rts                 ; return to the caller
Code_0B3D           lbsr      Code_25AA ; call the referenced helper routine
                    inc       Addr_000F ; advance the selected counter
                    lbsr      Code_098D ; call the referenced helper routine
                    leax      $01,X     ; form the referenced address without reading memory
                    leay      $01,Y     ; form the referenced address without reading memory
                    rts                 ; return to the caller
Code_0B4A           dec       Addr_0010 ; decrement the selected counter
                    lbsr      Code_098D ; call the referenced helper routine
                    lda       Data_0041 ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    nega                ; form the two's-complement negative value
                    leax      A,X       ; form the referenced address without reading memory
                    leay      A,Y       ; form the referenced address without reading memory
                    rts                 ; return to the caller
Code_0B58           tst       Addr_001C ; set condition flags from the current value
                    bne       Code_0B6F ; branch when the compared values differ
                    lbsr      Code_0DB1 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    bne       Code_0B66 ; branch when the compared values differ
                    lbsr      Code_25BA ; call the referenced helper routine
                    rts                 ; return to the caller
Code_0B66           lda       Addr_0015 ; load the value needed by the following operation
                    cmpa      Data_0042 ; compare against the limit and set condition flags
                    lbne      Code_0C74 ; take the distant branch when values differ
                    rts                 ; return to the caller
Code_0B6F           lbsr      Code_0F50 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_0B7B ; branch when the compared values are equal
                    bmi       Code_0B87 ; branch while the tested value is negative
                    lbsr      Code_25BA ; call the referenced helper routine
                    rts                 ; return to the caller
Code_0B7B           inc       Addr_0010 ; advance the selected counter
                    lbsr      Code_098D ; call the referenced helper routine
                    lda       Data_0041 ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    leax      A,X       ; form the referenced address without reading memory
                    leay      A,Y       ; form the referenced address without reading memory
Code_0B87           rts                 ; return to the caller
                    fcb       $96,$10,$81,$02 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $F9,$0A,$10,$17,$FD,$FA ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $BA,$96   ; table, bitmap, or initialized data bytes
                    fcc       "BJ"                           ; embedded text or resource bytes
                    fcb       $91,$10   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $EB,$0C,$10,$17,$FD,$EC ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $DD       ; table, bitmap, or initialized data bytes
Code_0BA3           tst       Addr_001C ; set condition flags from the current value
                    beq       Code_0BCB ; branch when the compared values are equal
                    lda       $01,X     ; load the value needed by the following operation
                    lbsr      Code_05C8 ; call the referenced helper routine
                    bmi       Code_0BCA ; branch while the tested value is negative
                    lda       Data_0041 ; load the value needed by the following operation
                    deca                ; decrement the selected counter
                    cmpa      Addr_000F ; compare against the limit and set condition flags
                    bne       Code_0BC1 ; branch when the compared values differ
                    lda       #$02      ; load the value needed by the following operation
                    sta       Addr_000F ; save the current value in working storage
                    inc       Addr_0010 ; advance the selected counter
                    leax      $04,X     ; form the referenced address without reading memory
                    leay      $04,Y     ; form the referenced address without reading memory
                    bra       Code_0BC7 ; continue at the selected control-flow target
Code_0BC1           inc       Addr_000F ; advance the selected counter
                    leax      $01,X     ; form the referenced address without reading memory
                    leay      $01,Y     ; form the referenced address without reading memory
Code_0BC7           lbsr      Code_098D ; call the referenced helper routine
Code_0BCA           rts                 ; return to the caller
Code_0BCB           lda       #$0B      ; load the value needed by the following operation
                    cmpa      Addr_000F ; compare against the limit and set condition flags
                    bne       Code_0BC1 ; branch when the compared values differ
                    rts                 ; return to the caller
Code_0BD2           tst       Addr_001C ; set condition flags from the current value
                    beq       Code_0BFA ; branch when the compared values are equal
                    lda       -$0F,X    ; load the value needed by the following operation
                    lbsr      Code_05C8 ; call the referenced helper routine
                    bmi       Code_0BF9 ; branch while the tested value is negative
                    lda       #$02      ; load the value needed by the following operation
                    cmpa      Addr_000F ; compare against the limit and set condition flags
                    bne       Code_0BF0 ; branch when the compared values differ
                    lda       Data_0041 ; load the value needed by the following operation
                    deca                ; decrement the selected counter
                    sta       Addr_000F ; save the current value in working storage
                    dec       Addr_0010 ; decrement the selected counter
                    leax      -$04,X    ; form the referenced address without reading memory
                    leay      -$04,Y    ; form the referenced address without reading memory
                    bra       Code_0BF6 ; continue at the selected control-flow target
Code_0BF0           dec       Addr_000F ; decrement the selected counter
                    leax      -$01,X    ; form the referenced address without reading memory
                    leay      -$01,Y    ; form the referenced address without reading memory
Code_0BF6           lbsr      Code_098D ; call the referenced helper routine
Code_0BF9           rts                 ; return to the caller
Code_0BFA           lda       -$01,X    ; load the value needed by the following operation
                    lbsr      Code_05C8 ; call the referenced helper routine
                    bpl       Code_0BF0 ; branch while the tested value is nonnegative
                    rts                 ; return to the caller
Code_0C02           tst       Addr_001C ; set condition flags from the current value
                    beq       Code_0C26 ; branch when the compared values are equal
                    lda       -$0F,X    ; load the value needed by the following operation
                    lbsr      Code_05C8 ; call the referenced helper routine
                    bmi       Code_0C4C ; branch while the tested value is negative
                    lda       $01,X     ; load the value needed by the following operation
                    lbsr      Code_05C8 ; call the referenced helper routine
                    bpl       Code_0C1A ; branch while the tested value is nonnegative
                    lda       ,X        ; load the value needed by the following operation
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bne       Code_0C1C ; branch when the compared values differ
Code_0C1A           bsr       Code_0BD2 ; call the referenced helper routine
Code_0C1C           lda       #$8A      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "C"                            ; embedded text or resource bytes
                    lda       #$20      ; load the value needed by the following operation
                    bra       Code_0C46 ; continue at the selected control-flow target
Code_0C26           lda       -$01,X    ; load the value needed by the following operation
                    lbsr      Code_05C8 ; call the referenced helper routine
                    bmi       Code_0C4C ; branch while the tested value is negative
                    lda       -$0C,X    ; load the value needed by the following operation
                    lbsr      Code_05C8 ; call the referenced helper routine
                    bpl       Code_0C3A ; branch while the tested value is nonnegative
                    lda       ,X        ; load the value needed by the following operation
                    cmpa      #$2E      ; compare against the limit and set condition flags
                    bne       Code_0C3C ; branch when the compared values differ
Code_0C3A           bsr       Code_0BD2 ; call the referenced helper routine
Code_0C3C           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "9"                            ; embedded text or resource bytes
                    lda       #$2E      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "C"                            ; embedded text or resource bytes
Code_0C46           sta       ,X        ; save the current value in working storage
Code_0C48           lda       #$01      ; load the value needed by the following operation
                    sta       Code_0017 ; save the current value in working storage
Code_0C4C           rts                 ; return to the caller
Code_0C4D           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "9"                            ; embedded text or resource bytes
                    cmpa      #$20      ; compare against the limit and set condition flags
                    blt       Code_0C60 ; branch when the signed value is below the limit
                    cmpa      #$7F      ; compare against the limit and set condition flags
                    bgt       Code_0C60 ; branch when the signed value is above the limit
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "C"                            ; embedded text or resource bytes
                    sta       ,X        ; save the current value in working storage
                    rts                 ; return to the caller
Code_0C60           clra                ; clear the selected byte or register
                    rts                 ; return to the caller
Code_0C62           bsr       Code_0C4D ; call the referenced helper routine
                    beq       Code_0C4C ; branch when the compared values are equal
                    lbsr      Code_0BA3 ; call the referenced helper routine
                    bra       Code_0C48 ; continue at the selected control-flow target
Code_0C6B           bsr       Code_0C4D ; call the referenced helper routine
                    beq       Code_0C4C ; branch when the compared values are equal
                    lbsr      Code_15D8 ; call the referenced helper routine
                    bra       Code_0C48 ; continue at the selected control-flow target
Code_0C74           lbsr      Code_076F ; call the referenced helper routine
                    tstb                ; set condition flags from the current value
                    lbeq      Code_0A51 ; take the distant branch when values are equal
                    tsta                ; set condition flags from the current value
                    lbeq      Code_0A51 ; take the distant branch when values are equal
                    lda       Addr_0026 ; load the value needed by the following operation
                    lbmi      Code_0FC8 ; take the distant branch while the value is negative
                    lbra      Code_0A5C ; continue at the distant control-flow target
Code_0C8A           tst       Data_003A ; set condition flags from the current value
                    bne       Code_0CD0 ; branch when the compared values differ
                    lbsr      Code_2753 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    bne       Code_0CD0 ; branch when the compared values differ
                    lbsr      Code_25AA ; call the referenced helper routine
                    lbsr      Code_098D ; call the referenced helper routine
                    lda       Addr_0010 ; load the value needed by the following operation
                    cmpa      #$02      ; compare against the limit and set condition flags
                    bne       Code_0CA6 ; branch when the compared values differ
                    lbsr      Code_0DB1 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    bne       Code_0CD0 ; branch when the compared values differ
Code_0CA6           leax      -$0E,X    ; form the referenced address without reading memory
                    lda       ,X        ; load the value needed by the following operation
                    anda      #$7F      ; mask off unwanted bits
                    lbsr      Code_2840 ; call the referenced helper routine
                    lbsr      Code_09F0 ; call the referenced helper routine
                    ldy       Data_0051 ; load the value needed by the following operation
                    lda       $05,Y     ; load the value needed by the following operation
                    bmi       Code_0CC0 ; branch while the tested value is negative
                    ldy       $06,Y     ; load the value needed by the following operation
                    leay      -$0E,Y    ; form the referenced address without reading memory
Code_0CBE           lda       ,Y+       ; fetch the next value and advance the source pointer
Code_0CC0           sta       ,X+       ; store the value and advance the destination pointer
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    bne       Code_0CBE ; branch when the compared values differ
                    leax      -$01,X    ; form the referenced address without reading memory
                    stx       Data_0044 ; save the current value in working storage
                    lda       #$01      ; load the value needed by the following operation
                    sta       Code_0017 ; save the current value in working storage
                    sta       Code_0031 ; save the current value in working storage
Code_0CD0           clr       Data_003A ; clear the selected byte or register
                    lbsr      Code_3DA9 ; call the referenced helper routine
                    lbra      Code_0A1A ; continue at the distant control-flow target
Code_0CD8           lbsr      Code_1613 ; call the referenced helper routine
                    lbsr      Code_3DA9 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    lda       #$02      ; load the value needed by the following operation
                    sta       Addr_0010 ; save the current value in working storage
                    leax      $0519,U   ; form the referenced address without reading memory
                    leay      $12E1,U   ; form the referenced address without reading memory
                    sty       Data_0051 ; save the current value in working storage
Code_0CF2           clr       Addr_000F ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    lda       Addr_0010 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    clrb                ; clear the selected byte or register
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    lbeq      Code_0D8B ; take the distant branch when values are equal
                    lda       #$0D      ; load the value needed by the following operation
                    pshs      A         ; preserve the listed registers on the stack
Code_0D08           lda       ,X+       ; fetch the next value and advance the source pointer
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $02       ; private DeskMate service selector
                    inc       Addr_000F ; advance the selected counter
                    dec       ,S        ; decrement the selected counter
                    bne       Code_0D08 ; branch when the compared values differ
                    leas      $01,S     ; form the referenced address without reading memory
                    pshs      Y,X       ; preserve the listed registers on the stack
                    ldy       Data_0051 ; load the value needed by the following operation
                    lda       Addr_0010 ; load the value needed by the following operation
                    sta       ,Y+       ; store the value and advance the destination pointer
                    stx       ,Y++      ; store the value and advance the destination pointer
                    ldx       $02,S     ; load the value needed by the following operation
                    stx       ,Y++      ; store the value and advance the destination pointer
                    sty       Data_0051 ; save the current value in working storage
                    puls      Y,X       ; restore the listed registers from the stack
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $02       ; private DeskMate service selector
                    inc       Addr_000F ; advance the selected counter
Code_0D32           lda       ,X+       ; fetch the next value and advance the source pointer
                    lbsr      Code_05C8 ; call the referenced helper routine
                    bmi       Code_0D86 ; branch while the tested value is negative
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bne       Code_0D3F ; branch when the compared values differ
                    lda       #$81      ; load the value needed by the following operation
Code_0D3F           ldb       Data_0041 ; load the value needed by the following operation
                    decb                ; decrement the selected counter
                    cmpb      Addr_000F ; compare against the limit and set condition flags
                    bne       Code_0D56 ; branch when the compared values differ
                    ldb       Data_0042 ; load the value needed by the following operation
                    decb                ; decrement the selected counter
                    cmpb      Addr_0010 ; compare against the limit and set condition flags
                    bne       Code_0D56 ; branch when the compared values differ
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $01       ; private DeskMate service selector
                    inc       Addr_0010 ; advance the selected counter
                    bra       Code_0D32 ; continue at the selected control-flow target
Code_0D56           clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $02       ; private DeskMate service selector
                    lda       Data_0041 ; load the value needed by the following operation
                    deca                ; decrement the selected counter
                    cmpa      Addr_000F ; compare against the limit and set condition flags
                    bne       Code_0D82 ; branch when the compared values differ
                    inc       Addr_0010 ; advance the selected counter
                    lda       ,X        ; load the value needed by the following operation
                    lbsr      Code_05C8 ; call the referenced helper routine
                    bmi       Code_0D88 ; branch while the tested value is negative
                    clr       Addr_000F ; clear the selected byte or register
                    lbsr      Code_098D ; call the referenced helper routine
                    lda       #$02      ; load the value needed by the following operation
                    sta       Addr_000F ; save the current value in working storage
                    lda       #$20      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $02       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $02       ; private DeskMate service selector
                    leax      $03,X     ; form the referenced address without reading memory
Code_0D80           bra       Code_0D32 ; continue at the selected control-flow target
Code_0D82           inc       Addr_000F ; advance the selected counter
                    bra       Code_0D32 ; continue at the selected control-flow target
Code_0D86           leax      -$01,X    ; form the referenced address without reading memory
Code_0D88           lbra      Code_0CF2 ; continue at the distant control-flow target
Code_0D8B           leax      -$01,X    ; form the referenced address without reading memory
                    stx       Data_0044 ; save the current value in working storage
                    ldy       Data_0051 ; load the value needed by the following operation
                    lda       #$FF      ; load the value needed by the following operation
                    sta       ,Y        ; save the current value in working storage
                    lda       Addr_0010 ; load the value needed by the following operation
                    sta       Addr_0015 ; save the current value in working storage
                    cmpa      Data_0042 ; compare against the limit and set condition flags
                    beq       Code_0DAB ; branch when the compared values are equal
                    clr       Addr_000F ; clear the selected byte or register
                    lbsr      Code_098D ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       ":"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "@"                            ; embedded text or resource bytes
Code_0DAB           lbsr      Code_1E49 ; call the referenced helper routine
                    clr       Data_003A ; clear the selected byte or register
                    rts                 ; return to the caller
Code_0DB1           pshs      X         ; preserve the listed registers on the stack
                    ldx       Data_0051 ; load the value needed by the following operation
                    tst       $05,X     ; set condition flags from the current value
                    puls      X         ; restore the listed registers from the stack
                    bmi       Code_0DBE ; branch while the tested value is negative
                    clra                ; clear the selected byte or register
                    bra       Code_0DC0 ; continue at the selected control-flow target
Code_0DBE           lda       #$01      ; load the value needed by the following operation
Code_0DC0           tsta                ; set condition flags from the current value
                    rts                 ; return to the caller
Code_0DC2           lbsr      Code_0EDD ; call the referenced helper routine
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Addr_0026 ; save the current value in working storage
                    leax      $1351,U   ; form the referenced address without reading memory
                    pshs      X         ; preserve the listed registers on the stack
                    ldd       Data_0047 ; load the value needed by the following operation
                    subd      ,S++      ; subtract the operand from the running value
                    leax      $30DE,U   ; form the referenced address without reading memory
                    leax      B,X       ; form the referenced address without reading memory
                    stx       Data_0053 ; save the current value in working storage
Code_0DDB           lbsr      Code_0F15 ; call the referenced helper routine
                    lbsr      Code_260B ; call the referenced helper routine
                    leay      $30DE,U   ; form the referenced address without reading memory
                    tfr       Y,D       ; copy the source register into the destination register
                    pshs      B         ; preserve the listed registers on the stack
                    ldd       Data_0053 ; load the value needed by the following operation
                    subb      ,S+       ; subtract the operand from the running value
                    addb      #$30      ; add the operand to the running value
                    pshs      B         ; preserve the listed registers on the stack
Code_0DF1           ldb       #$83      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    bne       Code_0E0F ; branch when the compared values differ
                    lbsr      Code_3DF3 ; call the referenced helper routine
                    tstb                ; set condition flags from the current value
                    beq       Code_0DF1 ; branch when the compared values are equal
                    lda       Addr_0026 ; load the value needed by the following operation
                    bmi       Code_0DF1 ; branch while the tested value is negative
                    cmpa      #$08      ; compare against the limit and set condition flags
                    lbeq      Code_0E2C ; take the distant branch when values are equal
Code_0E09           lbsr      Code_0EEF ; call the referenced helper routine
                    lbra      Code_0FAB ; continue at the distant control-flow target
Code_0E0F           cmpa      #$0D      ; compare against the limit and set condition flags
                    lbeq      Code_0E9A ; take the distant branch when values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    lbeq      Code_0E9C ; take the distant branch when values are equal
                    cmpa      #$0C      ; compare against the limit and set condition flags
                    bne       Code_0E24 ; branch when the compared values differ
                    lbsr      Code_0EF5 ; call the referenced helper routine
                    bra       Code_0DF1 ; continue at the selected control-flow target
Code_0E24           cmpa      #$AF      ; compare against the limit and set condition flags
                    beq       Code_0E09 ; branch when the compared values are equal
                    cmpa      #$8C      ; compare against the limit and set condition flags
                    bne       Code_0E39 ; branch when the compared values differ
Code_0E2C           lda       #$01      ; load the value needed by the following operation
                    sta       Data_003A ; save the current value in working storage
                    lbsr      Code_0EA2 ; call the referenced helper routine
                    lbsr      Code_0EEF ; call the referenced helper routine
                    lbra      Code_0F96 ; continue at the distant control-flow target
Code_0E39           cmpa      #$0A      ; compare against the limit and set condition flags
                    bne       Code_0E47 ; branch when the compared values differ
                    lbsr      Code_0DB1 ; call the referenced helper routine
                    bne       Code_0DF1 ; branch when the compared values differ
                    lbsr      Code_0F08 ; call the referenced helper routine
                    bra       Code_0DF1 ; continue at the selected control-flow target
Code_0E47           cmpa      #$31      ; compare against the limit and set condition flags
                    blt       Code_0DF1 ; branch when the signed value is below the limit
                    cmpa      #$35      ; compare against the limit and set condition flags
                    bgt       Code_0DF1 ; branch when the signed value is above the limit
                    cmpa      ,S        ; compare against the limit and set condition flags
                    bgt       Code_0DF1 ; branch when the signed value is above the limit
                    leas      $01,S     ; form the referenced address without reading memory
                    tfr       A,B       ; copy the source register into the destination register
                    subb      #$30      ; subtract the operand from the running value
                    lda       -$0E,X    ; load the value needed by the following operation
                    anda      #$7F      ; mask off unwanted bits
                    leax      $30DE,U   ; form the referenced address without reading memory
                    lbsr      Code_09FC ; call the referenced helper routine
                    stx       Data_0053 ; save the current value in working storage
                    leax      $30DE,U   ; form the referenced address without reading memory
                    decb                ; decrement the selected counter
                    leax      B,X       ; form the referenced address without reading memory
                    pshs      X         ; preserve the listed registers on the stack
                    ldx       Data_0053 ; load the value needed by the following operation
                    leax      $01,X     ; form the referenced address without reading memory
                    stx       Data_0053 ; save the current value in working storage
Code_0E75           cmpx      ,S        ; compare against the limit and set condition flags
                    beq       Code_0E7F ; branch when the compared values are equal
                    ldb       ,-X       ; load the value needed by the following operation
                    stb       $01,X     ; save the current value in working storage
                    bra       Code_0E75 ; continue at the selected control-flow target
Code_0E7F           puls      X         ; restore the listed registers from the stack
                    sta       ,X        ; save the current value in working storage
                    lbsr      Code_260B ; call the referenced helper routine
Code_0E86           lda       #$20      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "C"                            ; embedded text or resource bytes
                    ldx       Data_0051 ; load the value needed by the following operation
                    tst       $05,X     ; set condition flags from the current value
                    bmi       Code_0E97 ; branch while the tested value is negative
                    lbsr      Code_0F08 ; call the referenced helper routine
                    bra       Code_0E86 ; continue at the selected control-flow target
Code_0E97           lbra      Code_0DDB ; continue at the distant control-flow target
Code_0E9A           bsr       Code_0EA2 ; call the referenced helper routine
Code_0E9C           lbsr      Code_0EEF ; call the referenced helper routine
                    lbra      Code_0A1A ; continue at the distant control-flow target
Code_0EA2           tst       Code_0031 ; set condition flags from the current value
                    beq       Code_0EB8 ; branch when the compared values are equal
                    lbsr      Code_100B ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_0EB2 ; branch when the compared values are equal
                    lbsr      Code_1E27 ; call the referenced helper routine
                    lbsr      Code_3511 ; call the referenced helper routine
Code_0EB2           lbsr      Code_285A ; call the referenced helper routine
                    lbsr      Code_22C6 ; call the referenced helper routine
Code_0EB8           bsr       Code_0ED3 ; call the referenced helper routine
                    lbsr      Code_1013 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_0ED2 ; branch when the compared values are equal
                    lbsr      Code_1DE0 ; call the referenced helper routine
                    lbsr      Code_35E0 ; call the referenced helper routine
                    lbsr      Code_100F ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_0ED2 ; branch when the compared values are equal
                    lbsr      Code_3767 ; call the referenced helper routine
                    lbsr      Code_3A23 ; call the referenced helper routine
Code_0ED2           rts                 ; return to the caller
Code_0ED3           leax      $30DE,U   ; form the referenced address without reading memory
                    leay      $1351,U   ; form the referenced address without reading memory
                    bra       Code_0EE5 ; continue at the selected control-flow target
Code_0EDD           leay      $30DE,U   ; form the referenced address without reading memory
Code_0EE1           leax      $1351,U   ; form the referenced address without reading memory
Code_0EE5           ldb       #$19      ; load the value needed by the following operation
Code_0EE7           lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,Y+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bne       Code_0EE7 ; branch when the compared values differ
                    rts                 ; return to the caller
Code_0EEF           leay      $3110,U   ; form the referenced address without reading memory
                    bra       Code_0EE1 ; continue at the selected control-flow target
Code_0EF5           lda       Addr_0010 ; load the value needed by the following operation
                    cmpa      #$02      ; compare against the limit and set condition flags
                    beq       Code_0F07 ; branch when the compared values are equal
                    ldx       Data_0051 ; load the value needed by the following operation
                    leax      -$05,X    ; form the referenced address without reading memory
Code_0EFF           stx       Data_0051 ; save the current value in working storage
                    lbsr      Code_25AA ; call the referenced helper routine
                    lbsr      Code_098D ; call the referenced helper routine
Code_0F07           rts                 ; return to the caller
Code_0F08           lda       Data_0042 ; load the value needed by the following operation
                    deca                ; decrement the selected counter
                    cmpa      Addr_0010 ; compare against the limit and set condition flags
                    beq       Code_0F07 ; branch when the compared values are equal
                    ldx       Data_0051 ; load the value needed by the following operation
                    leax      $05,X     ; form the referenced address without reading memory
                    bra       Code_0EFF ; continue at the selected control-flow target
Code_0F15           pshs      Y,D       ; preserve the listed registers on the stack
                    ldb       #$05      ; load the value needed by the following operation
                    leay      $30DE,U   ; form the referenced address without reading memory
                    lda       #$31      ; load the value needed by the following operation
                    pshs      A         ; preserve the listed registers on the stack
Code_0F21           lda       ,Y        ; load the value needed by the following operation
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    beq       Code_0F4C ; branch when the compared values are equal
                    pshs      Y         ; preserve the listed registers on the stack
                    lbsr      Code_260B ; call the referenced helper routine
                    puls      Y         ; restore the listed registers from the stack
Code_0F2E           lda       -$0E,X    ; load the value needed by the following operation
                    anda      #$7F      ; mask off unwanted bits
                    cmpa      ,Y        ; compare against the limit and set condition flags
                    beq       Code_0F3F ; branch when the compared values are equal
                    pshs      Y         ; preserve the listed registers on the stack
                    lbsr      Code_0F08 ; call the referenced helper routine
                    puls      Y         ; restore the listed registers from the stack
                    bra       Code_0F2E ; continue at the selected control-flow target
Code_0F3F           lda       ,S        ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "C"                            ; embedded text or resource bytes
                    inc       ,S        ; advance the selected counter
                    leay      $01,Y     ; form the referenced address without reading memory
                    decb                ; decrement the selected counter
                    bne       Code_0F21 ; branch when the compared values differ
Code_0F4C           leas      $01,S     ; form the referenced address without reading memory
                    puls      PC,Y,D    ; restore the listed registers from the stack
Code_0F50           pshs      X,B       ; preserve the listed registers on the stack
                    ldb       Data_0041 ; load the value needed by the following operation
                    incb                ; advance the selected counter
Code_0F55           leax      $01,X     ; form the referenced address without reading memory
                    lda       ,X        ; load the value needed by the following operation
                    lbsr      Code_05C8 ; call the referenced helper routine
                    bmi       Code_0F64 ; branch while the tested value is negative
                    decb                ; decrement the selected counter
                    bne       Code_0F55 ; branch when the compared values differ
                    clra                ; clear the selected byte or register
                    puls      PC,X,B    ; restore the listed registers from the stack
Code_0F64           cmpa      #$FF      ; compare against the limit and set condition flags
                    beq       Code_0F6C ; branch when the compared values are equal
                    lda       #$01      ; load the value needed by the following operation
                    puls      PC,X,B    ; restore the listed registers from the stack
Code_0F6C           lda       #$FF      ; load the value needed by the following operation
                    puls      PC,X,B    ; restore the listed registers from the stack
Code_0F70           pshs      X,B       ; preserve the listed registers on the stack
                    ldb       Data_0041 ; load the value needed by the following operation
                    incb                ; advance the selected counter
Code_0F75           lda       -$0F,X    ; load the value needed by the following operation
                    lbsr      Code_05C8 ; call the referenced helper routine
                    bmi       Code_0F84 ; branch while the tested value is negative
                    leax      -$01,X    ; form the referenced address without reading memory
                    decb                ; decrement the selected counter
                    bne       Code_0F75 ; branch when the compared values differ
                    clra                ; clear the selected byte or register
                    puls      PC,X,B    ; restore the listed registers from the stack
Code_0F84           lda       Data_0041 ; load the value needed by the following operation
                    suba      #$13      ; subtract the operand from the running value
                    pshs      A         ; preserve the listed registers on the stack
                    cmpb      ,S+       ; compare against the limit and set condition flags
                    bgt       Code_0F92 ; branch when the signed value is above the limit
                    lda       #$01      ; load the value needed by the following operation
                    puls      PC,X,B    ; restore the listed registers from the stack
Code_0F92           lda       #$FF      ; load the value needed by the following operation
                    puls      PC,X,B    ; restore the listed registers from the stack
Code_0F96           lda       $0519,U   ; load the value needed by the following operation
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    lbeq      Code_265A ; take the distant branch when values are equal
                    lbsr      Code_1C6A ; call the referenced helper routine
                    cmpb      #$05      ; compare against the limit and set condition flags
                    beq       Code_0FAE ; branch when the compared values are equal
                    cmpa      #$03      ; compare against the limit and set condition flags
                    bne       Code_0FB4 ; branch when the compared values differ
Code_0FAB           lbsr      Code_1D60 ; call the referenced helper routine
Code_0FAE           lbsr      Code_3DA9 ; call the referenced helper routine
                    lbra      Code_0A1A ; continue at the distant control-flow target
Code_0FB4           cmpa      #$00      ; compare against the limit and set condition flags
                    lbeq      Code_0C8A ; take the distant branch when values are equal
                    cmpa      #$02      ; compare against the limit and set condition flags
                    beq       Code_0FC8 ; branch when the compared values are equal
                    pshs      X,A       ; preserve the listed registers on the stack
                    lbsr      Code_0CD8 ; call the referenced helper routine
                    puls      X,A       ; restore the listed registers from the stack
                    lbra      Code_0DC2 ; continue at the distant control-flow target
Code_0FC8           tst       Code_0017 ; set condition flags from the current value
                    beq       Code_0FE0 ; branch when the compared values are equal
                    lbsr      Code_1038 ; call the referenced helper routine
                    lbsr      Code_242F ; call the referenced helper routine
                    lbsr      Code_23CF ; call the referenced helper routine
                    lbsr      Code_22C6 ; call the referenced helper routine
                    clr       Data_0030 ; clear the selected byte or register
                    tst       Code_0031 ; set condition flags from the current value
                    beq       Code_0FE0 ; branch when the compared values are equal
                    bsr       Code_0FE6 ; call the referenced helper routine
Code_0FE0           lbsr      Code_3A23 ; call the referenced helper routine
                    lbra      Code_04EE ; continue at the distant control-flow target
Code_0FE6           bsr       Code_100B ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_0FF1 ; branch when the compared values are equal
                    lbsr      Code_1E27 ; call the referenced helper routine
                    lbsr      Code_3511 ; call the referenced helper routine
Code_0FF1           bsr       Code_1013 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_1004 ; branch when the compared values are equal
                    lbsr      Code_1DE0 ; call the referenced helper routine
                    lbsr      Code_35E0 ; call the referenced helper routine
                    bsr       Code_100F ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_1004 ; branch when the compared values are equal
                    lbsr      Code_3767 ; call the referenced helper routine
Code_1004           lbsr      Code_285A ; call the referenced helper routine
                    lbsr      Code_22C6 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_100B           ldb       #$19      ; load the value needed by the following operation
                    bra       Code_1015 ; continue at the selected control-flow target
Code_100F           ldb       #$02      ; load the value needed by the following operation
                    bra       Code_1015 ; continue at the selected control-flow target
Code_1013           ldb       #$05      ; load the value needed by the following operation
Code_1015           leax      $3110,U   ; form the referenced address without reading memory
                    leay      $1351,U   ; form the referenced address without reading memory
Code_101D           lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    beq       Code_102F ; branch when the compared values are equal
                    cmpa      ,Y+       ; compare against the limit and set condition flags
                    bne       Code_102C ; branch when the compared values differ
                    decb                ; decrement the selected counter
                    bne       Code_101D ; branch when the compared values differ
Code_102A           clra                ; clear the selected byte or register
                    rts                 ; return to the caller
Code_102C           lda       #$01      ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_102F           lda       ,Y        ; load the value needed by the following operation
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    beq       Code_102A ; branch when the compared values are equal
                    lda       #$FF      ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_1038           leax      $0519,U   ; form the referenced address without reading memory
Code_103C           leax      $0F,X     ; form the referenced address without reading memory
Code_103E           lda       ,X+       ; fetch the next value and advance the source pointer
                    bmi       Code_1047 ; branch while the tested value is negative
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bne       Code_103E ; branch when the compared values differ
                    rts                 ; return to the caller
Code_1047           leax      -$01,X    ; form the referenced address without reading memory
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    bne       Code_103C ; branch when the compared values differ
                    lda       #$20      ; load the value needed by the following operation
                    sta       -$01,X    ; save the current value in working storage
                    rts                 ; return to the caller
Code_1052           lbsr      Code_2496 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "?"                            ; embedded text or resource bytes
Code_1059           lbsr      Code_2B2E ; call the referenced helper routine
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Addr_0026 ; save the current value in working storage
                    clr       Addr_0027 ; clear the selected byte or register
                    lda       #$07      ; load the value needed by the following operation
                    sta       Data_0039 ; save the current value in working storage
                    sta       Data_0038 ; save the current value in working storage
                    clr       Addr_001E ; clear the selected byte or register
                    lda       #$01      ; load the value needed by the following operation
                    sta       Addr_001C ; save the current value in working storage
                    bra       Code_1073 ; continue at the selected control-flow target
Code_1070           lbsr      Code_2496 ; call the referenced helper routine
Code_1073           lbsr      Code_1620 ; call the referenced helper routine
                    tst       Data_003B ;1076: 0D 3B          '. ; set condition flags from the current value
                    beq       Code_107D ; branch when the compared values are equal
                    lbsr      Code_1392 ; call the referenced helper routine
Code_107D           clr       Code_001D ; clear the selected byte or register
                    clr       Code_0017 ; clear the selected byte or register
                    lbsr      Code_117D ; call the referenced helper routine
Code_1084           ldb       #$83      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    lbne      Code_1105 ; take the distant branch when values differ
                    lbsr      Code_3AE9 ; call the referenced helper routine
                    pshs      D         ; preserve the listed registers on the stack
                    lbsr      Code_15F0 ; call the referenced helper routine
                    puls      D         ; restore the listed registers from the stack
Code_1098           tsta                ; set condition flags from the current value
                    beq       Code_1084 ; branch when the compared values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    beq       Code_10C7 ; branch when the compared values are equal
                    cmpa      #$03      ; compare against the limit and set condition flags
                    beq       Code_10D7 ; branch when the compared values are equal
                    cmpa      #$01      ; compare against the limit and set condition flags
                    bne       Code_1084 ; branch when the compared values differ
                    lda       Addr_0026 ; load the value needed by the following operation
                    cmpa      #$00      ; compare against the limit and set condition flags
                    lbeq      Code_12BB ; take the distant branch when values are equal
                    cmpa      #$01      ; compare against the limit and set condition flags
                    lbeq      Code_127C ; take the distant branch when values are equal
                    cmpa      #$02      ; compare against the limit and set condition flags
                    lbeq      Code_1287 ; take the distant branch when values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    lbeq      Code_1112 ; take the distant branch when values are equal
                    cmpa      #$06      ; compare against the limit and set condition flags
                    beq       Code_1109 ; branch when the compared values are equal
                    bra       Code_1084 ; continue at the selected control-flow target
Code_10C7           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    lda       Addr_0026 ; load the value needed by the following operation
                    cmpa      #$06      ; compare against the limit and set condition flags
                    beq       Code_111B ; branch when the compared values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    beq       Code_113B ; branch when the compared values are equal
                    bra       Code_1084 ; continue at the selected control-flow target
Code_10D7           lda       Addr_0026 ; load the value needed by the following operation
                    cmpa      #$06      ; compare against the limit and set condition flags
                    beq       Code_10F3 ; branch when the compared values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    bne       Code_1084 ; branch when the compared values differ
Code_10E1           lbsr      Code_120C ; call the referenced helper routine
                    lbsr      Code_3AE9 ; call the referenced helper routine
                    cmpa      #$04      ; compare against the limit and set condition flags
                    beq       Code_10F1 ; branch when the compared values are equal
                    ldb       Addr_0026 ; load the value needed by the following operation
                    cmpb      #$05      ; compare against the limit and set condition flags
                    beq       Code_10E1 ; branch when the compared values are equal
Code_10F1           bra       Code_1098 ; continue at the selected control-flow target
Code_10F3           lbsr      Code_11A1 ; call the referenced helper routine
                    lbsr      Code_3AE9 ; call the referenced helper routine
                    cmpa      #$04      ; compare against the limit and set condition flags
                    beq       Code_1103 ; branch when the compared values are equal
                    ldb       Addr_0026 ; load the value needed by the following operation
                    cmpa      #$06      ; compare against the limit and set condition flags
                    beq       Code_10F3 ; branch when the compared values are equal
Code_1103           bra       Code_1098 ; continue at the selected control-flow target
Code_1105           cmpa      #$19      ; compare against the limit and set condition flags
                    bne       Code_110E ; branch when the compared values differ
Code_1109           lbsr      Code_11A1 ; call the referenced helper routine
                    bra       Code_117A ; continue at the selected control-flow target
Code_110E           cmpa      #$18      ; compare against the limit and set condition flags
                    bne       Code_1117 ; branch when the compared values differ
Code_1112           lbsr      Code_120C ; call the referenced helper routine
                    bra       Code_117A ; continue at the selected control-flow target
Code_1117           cmpa      #$11      ; compare against the limit and set condition flags
                    bne       Code_1137 ; branch when the compared values differ
Code_111B           tst       Addr_002C ; set condition flags from the current value
                    bne       Code_117A ; branch when the compared values differ
                    bsr       Code_118B ; call the referenced helper routine
                    lbsr      Code_2402 ; call the referenced helper routine
Code_1124           lbsr      Code_392C ; call the referenced helper routine
                    lbsr      Code_2496 ; call the referenced helper routine
                    lbsr      Code_137C ; call the referenced helper routine
                    lbsr      Code_117D ; call the referenced helper routine
                    clr       Code_0017 ; clear the selected byte or register
                    lbsr      Code_1895 ; call the referenced helper routine
                    bra       Code_117A ; continue at the selected control-flow target
Code_1137           cmpa      #$10      ; compare against the limit and set condition flags
                    bne       Code_1146 ; branch when the compared values differ
Code_113B           tst       Addr_002C ; set condition flags from the current value
                    bne       Code_117A ;113D: 26 3B          '& ; branch when the compared values differ
                    bsr       Code_118B ; call the referenced helper routine
                    lbsr      Code_23F9 ; call the referenced helper routine
                    bra       Code_1124 ; continue at the selected control-flow target
Code_1146           cmpa      #$05      ; compare against the limit and set condition flags
                    lbeq      Code_12E9 ; take the distant branch when values are equal
                    cmpa      #$AF      ; compare against the limit and set condition flags
                    lbeq      Code_1287 ; take the distant branch when values are equal
                    cmpa      #$B7      ; compare against the limit and set condition flags
                    lbeq      Code_12CA ; take the distant branch when values are equal
                    cmpa      #$B5      ; compare against the limit and set condition flags
                    lbeq      Code_1243 ; take the distant branch when values are equal
                    cmpa      #$B2      ; compare against the limit and set condition flags
                    lbeq      Code_12A5 ; take the distant branch when values are equal
                    cmpa      #$8C      ; compare against the limit and set condition flags
                    bne       Code_1171 ; branch when the compared values differ
                    ldb       Addr_0026 ; load the value needed by the following operation
                    cmpb      #$FF      ; compare against the limit and set condition flags
                    bne       Code_117A ; branch when the compared values differ
                    lbra      Code_126F ; continue at the distant control-flow target
Code_1171           lbsr      Code_14CB ; call the referenced helper routine
                    lbsr      Code_1856 ; call the referenced helper routine
                    lbsr      Code_15F0 ; call the referenced helper routine
Code_117A           lbra      Code_1084 ; continue at the distant control-flow target
Code_117D           lbsr      Code_260B ; call the referenced helper routine
                    lda       #$01      ; load the value needed by the following operation
                    sta       Addr_001C ; save the current value in working storage
                    lbsr      Code_250D ; call the referenced helper routine
                    lbsr      Code_15F0 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_118B           lbsr      Code_1895 ; call the referenced helper routine
                    tst       Code_0017 ; set condition flags from the current value
                    beq       Code_11A0 ; branch when the compared values are equal
                    lbsr      Code_2478 ; call the referenced helper routine
                    lbsr      Code_39DE ; call the referenced helper routine
                    lbsr      Code_2445 ; call the referenced helper routine
                    lbsr      Code_39AF ; call the referenced helper routine
                    clr       Code_0017 ; clear the selected byte or register
Code_11A0           rts                 ; return to the caller
Code_11A1           bsr       Code_11F5 ; call the referenced helper routine
                    tst       Addr_002C ; set condition flags from the current value
                    beq       Code_11B7 ; branch when the compared values are equal
                    lda       #$01      ; load the value needed by the following operation
                    sta       Addr_002F ; save the current value in working storage
                    tst       Code_0017 ; set condition flags from the current value
                    beq       Code_11B4 ; branch when the compared values are equal
                    bsr       Code_11CE ; call the referenced helper routine
                    lbra      Code_147A ; continue at the distant control-flow target
Code_11B4           lbra      Code_1437 ; continue at the distant control-flow target
Code_11B7           pshs      X         ; preserve the listed registers on the stack
                    ldx       Addr_000C ; load the value needed by the following operation
                    leax      $04,X     ; form the referenced address without reading memory
                    cmpx      Addr_0006 ; compare against the limit and set condition flags
                    puls      X         ; restore the listed registers from the stack
                    bne       Code_11C9 ; branch when the compared values differ
                    lbsr      Code_13AE ; call the referenced helper routine
                    lbra      Code_123F ; continue at the distant control-flow target
Code_11C9           bsr       Code_11CE ; call the referenced helper routine
                    lbra      Code_1235 ; continue at the distant control-flow target
Code_11CE           tst       Code_0017 ; set condition flags from the current value
                    beq       Code_11D6 ; branch when the compared values are equal
                    bsr       Code_11DA ; call the referenced helper routine
                    blt       Code_11D9 ; branch when the signed value is below the limit
Code_11D6           lbsr      Code_3891 ; call the referenced helper routine
Code_11D9           rts                 ; return to the caller
Code_11DA           pshs      Y,X       ; preserve the listed registers on the stack
                    ldx       Addr_000C ; load the value needed by the following operation
                    pshs      X         ; preserve the listed registers on the stack
                    lbsr      Code_118B ; call the referenced helper routine
                    puls      X         ; restore the listed registers from the stack
                    ldy       Addr_000C ; load the value needed by the following operation
                    pshs      Y         ; preserve the listed registers on the stack
                    stx       Addr_000C ; save the current value in working storage
                    lbsr      Code_392C ; call the referenced helper routine
                    ldx       Addr_000C ; load the value needed by the following operation
                    cmpx      ,S++      ; compare against the limit and set condition flags
                    puls      PC,Y,X    ; restore the listed registers from the stack
Code_11F5           lbsr      Code_1895 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1B       ; private DeskMate service selector
                    lbsr      Code_2501 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_1200           tst       Code_0017 ; set condition flags from the current value
                    beq       Code_1208 ; branch when the compared values are equal
                    bsr       Code_11DA ; call the referenced helper routine
                    bgt       Code_120B ; branch when the signed value is above the limit
Code_1208           lbsr      Code_386C ; call the referenced helper routine
Code_120B           rts                 ; return to the caller
Code_120C           bsr       Code_11F5 ; call the referenced helper routine
                    tst       Addr_002C ; set condition flags from the current value
                    beq       Code_1220 ; branch when the compared values are equal
                    clr       Addr_002F ; clear the selected byte or register
                    tst       Code_0017 ; set condition flags from the current value
                    beq       Code_121D ; branch when the compared values are equal
                    bsr       Code_1200 ; call the referenced helper routine
                    lbra      Code_147A ; continue at the distant control-flow target
Code_121D           lbra      Code_1437 ; continue at the distant control-flow target
Code_1220           pshs      X         ; preserve the listed registers on the stack
                    leax      >$0066,U  ; form the referenced address without reading memory
                    leax      $03,X     ; form the referenced address without reading memory
                    cmpx      Addr_000C ; compare against the limit and set condition flags
                    puls      X         ; restore the listed registers from the stack
                    bne       Code_1233 ; branch when the compared values differ
                    lbsr      Code_13D6 ; call the referenced helper routine
                    bra       Code_123F ; continue at the selected control-flow target
Code_1233           bsr       Code_1200 ; call the referenced helper routine
Code_1235           lbsr      Code_2496 ; call the referenced helper routine
                    lbsr      Code_137C ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $16       ; private DeskMate service selector
Code_123F           lbsr      Code_117D ;123F: 17 FF 3B       '.. ; call the referenced helper routine
                    rts                 ; return to the caller
Code_1243           lbsr      Code_1895 ; call the referenced helper routine
                    lbsr      Code_2478 ; call the referenced helper routine
                    lbsr      Code_39DE ; call the referenced helper routine
                    lbsr      Code_392C ; call the referenced helper routine
                    lbsr      Code_3DA9 ; call the referenced helper routine
                    lbsr      Code_23EC ; call the referenced helper routine
                    bne       Code_125D ; branch when the compared values differ
                    lbsr      Code_1E32 ; call the referenced helper routine
                    lbra      Code_12F2 ; continue at the distant control-flow target
Code_125D           tst       Addr_002C ; set condition flags from the current value
                    lbne      Code_1457 ; take the distant branch when values differ
                    lbsr      Code_2496 ; call the referenced helper routine
                    lbsr      Code_1620 ; call the referenced helper routine
                    lbsr      Code_117D ; call the referenced helper routine
                    lbra      Code_1084 ; continue at the distant control-flow target
Code_126F           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1B       ; private DeskMate service selector
                    lbsr      Code_1323 ; call the referenced helper routine
                    tst       Addr_001F ; set condition flags from the current value
                    bmi       Code_129F ; branch while the tested value is negative
                    beq       Code_12BB ; branch when the compared values are equal
Code_127C           lbsr      Code_1C25 ; call the referenced helper routine
                    cmpb      #$05      ; compare against the limit and set condition flags
                    beq       Code_128A ; branch when the compared values are equal
                    cmpa      #$02      ; compare against the limit and set condition flags
                    bne       Code_12A2 ; branch when the compared values differ
Code_1287           lbsr      Code_1D60 ; call the referenced helper routine
Code_128A           lbsr      Code_3DA9 ; call the referenced helper routine
                    lbsr      Code_1620 ; call the referenced helper routine
                    clr       Data_0028 ; clear the selected byte or register
                    clr       Code_0029 ; clear the selected byte or register
                    clr       Addr_002B ; clear the selected byte or register
                    lda       #$07      ; load the value needed by the following operation
                    sta       Data_0039 ; save the current value in working storage
                    sta       Data_0038 ; save the current value in working storage
                    lbsr      Code_117D ; call the referenced helper routine
Code_129F           lbra      Code_1084 ; continue at the distant control-flow target
Code_12A2           tsta                ; set condition flags from the current value
                    beq       Code_1243 ; branch when the compared values are equal
Code_12A5           tst       Addr_002C ; set condition flags from the current value
                    lbne      Code_1492 ; take the distant branch when values differ
                    lbsr      Code_1895 ; call the referenced helper routine
                    lbsr      Code_2DCA ; call the referenced helper routine
                    bcs       Code_12B9 ; branch when carry reports an unsigned underflow or error
                    lbsr      Code_2CF8 ; call the referenced helper routine
                    lbsr      Code_2DFF ; call the referenced helper routine
Code_12B9           bra       Code_128A ; continue at the selected control-flow target
Code_12BB           lbsr      Code_1BE8 ; call the referenced helper routine
                    cmpb      #$05      ; compare against the limit and set condition flags
                    beq       Code_128A ; branch when the compared values are equal
                    cmpa      #$02      ; compare against the limit and set condition flags
                    beq       Code_1287 ; branch when the compared values are equal
                    cmpa      #$00      ; compare against the limit and set condition flags
                    beq       Code_12E9 ; branch when the compared values are equal
Code_12CA           lbsr      Code_1895 ; call the referenced helper routine
                    tst       Code_0017 ; set condition flags from the current value
                    beq       Code_12D3 ; branch when the compared values are equal
                    bsr       Code_12FD ; call the referenced helper routine
Code_12D3           lbsr      Code_2E06 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    bne       Code_12E1 ; branch when the compared values differ
                    lda       #$01      ; load the value needed by the following operation
                    sta       Data_003B ;12DB: 97 3B          '. ; save the current value in working storage
                    clr       Addr_002C ; clear the selected byte or register
                    bra       Code_12E3 ; continue at the selected control-flow target
Code_12E1           clr       Data_003B ;12E1: 0F 3B          '. ; clear the selected byte or register
Code_12E3           lbsr      Code_2496 ; call the referenced helper routine
                    lbra      Code_1059 ; continue at the distant control-flow target
Code_12E9           lbsr      Code_1895 ; call the referenced helper routine
                    tst       Code_0017 ; set condition flags from the current value
                    beq       Code_12F2 ; branch when the compared values are equal
                    bsr       Code_12FD ; call the referenced helper routine
Code_12F2           clr       Addr_002B ; clear the selected byte or register
                    clr       Data_0028 ; clear the selected byte or register
                    clr       Code_0029 ; clear the selected byte or register
                    clr       Addr_002C ; clear the selected byte or register
                    lbra      Code_04EE ; continue at the distant control-flow target
Code_12FD           ldx       Addr_000C ; load the value needed by the following operation
                    pshs      X         ; preserve the listed registers on the stack
                    lbsr      Code_2478 ; call the referenced helper routine
                    lbsr      Code_39DE ; call the referenced helper routine
                    lbsr      Code_2445 ;1307: 17 11 3B       '.. ; call the referenced helper routine
                    lbsr      Code_39AF ; call the referenced helper routine
                    puls      X         ; restore the listed registers from the stack
                    ldy       Addr_000C ; load the value needed by the following operation
                    pshs      Y         ; preserve the listed registers on the stack
                    stx       Addr_000C ; save the current value in working storage
                    lbsr      Code_392C ; call the referenced helper routine
                    ldx       Addr_000C ; load the value needed by the following operation
                    cmpx      ,S++      ; compare against the limit and set condition flags
                    blt       Code_1322 ; branch when the signed value is below the limit
                    lbsr      Code_3891 ; call the referenced helper routine
Code_1322           rts                 ; return to the caller
Code_1323           clr       Addr_001F ; clear the selected byte or register
                    lbsr      Code_2ABD ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
Code_132C           ldb       #$00      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1C       ; private DeskMate service selector
                    cmpa      #$09      ; compare against the limit and set condition flags
                    beq       Code_134E ; branch when the compared values are equal
                    cmpa      #$08      ; compare against the limit and set condition flags
                    beq       Code_135C ; branch when the compared values are equal
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    beq       Code_136A ; branch when the compared values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    beq       Code_1346 ; branch when the compared values are equal
                    cmpa      #$8A      ; compare against the limit and set condition flags
                    bne       Code_132C ; branch when the compared values differ
Code_1346           lbsr      Code_3DA9 ; call the referenced helper routine
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Addr_001F ; save the current value in working storage
                    rts                 ; return to the caller
Code_134E           tst       Addr_001F ; set condition flags from the current value
                    bne       Code_135A ; branch when the compared values differ
                    lbsr      Code_2AB8 ; call the referenced helper routine
                    lbsr      Code_2ACE ; call the referenced helper routine
                    inc       Addr_001F ; advance the selected counter
Code_135A           bra       Code_132C ; continue at the selected control-flow target
Code_135C           tst       Addr_001F ; set condition flags from the current value
                    beq       Code_1368 ; branch when the compared values are equal
                    lbsr      Code_2AC9 ; call the referenced helper routine
                    lbsr      Code_2ABD ; call the referenced helper routine
                    clr       Addr_001F ; clear the selected byte or register
Code_1368           bra       Code_132C ; continue at the selected control-flow target
Code_136A           rts                 ; return to the caller
Code_136B           leax      $088B,U   ; form the referenced address without reading memory
                    leay      $0BFD,U   ; form the referenced address without reading memory
Code_1373           lda       ,Y+       ; fetch the next value and advance the source pointer
                    sta       ,X+       ; store the value and advance the destination pointer
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    bne       Code_1373 ; branch when the compared values differ
                    rts                 ; return to the caller
Code_137C           lbsr      Code_1620 ; call the referenced helper routine
                    clr       Data_0028 ; clear the selected byte or register
                    clr       Code_0029 ; clear the selected byte or register
                    clr       Addr_002B ; clear the selected byte or register
                    rts                 ; return to the caller
Data_1386           fcc       "   No Match"                  ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_1392           leax      >Data_13FA,PCR ; form the referenced address without reading memory
                    leay      >Data_1386,PCR ; form the referenced address without reading memory
                    clr       Data_0028 ; clear the selected byte or register
                    clr       Code_0029 ; clear the selected byte or register
                    bra       Code_13C1 ; continue at the selected control-flow target
Data_13A0           fcc       "  End of File"                ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_13AE           tst       Data_0028 ; set condition flags from the current value
                    bne       Code_13C6 ; branch when the compared values differ
                    lbsr      Code_2501 ; call the referenced helper routine
                    leax      >Data_13FA,PCR ; form the referenced address without reading memory
                    leay      >Data_13A0,PCR ; form the referenced address without reading memory
                    inc       Data_0028 ; advance the selected counter
                    clr       Code_0029 ; clear the selected byte or register
Code_13C1           bsr       Code_140C ; call the referenced helper routine
                    lbsr      Code_117D ; call the referenced helper routine
Code_13C6           rts                 ; return to the caller
Data_13C7           fcc       " Front of File"               ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_13D6           tst       Code_0029 ; set condition flags from the current value
                    bne       Code_13C6 ; branch when the compared values differ
                    lbsr      Code_2501 ; call the referenced helper routine
                    leax      >Data_13FA,PCR ; form the referenced address without reading memory
                    leay      >Data_13C7,PCR ; form the referenced address without reading memory
                    inc       Code_0029 ; advance the selected counter
                    clr       Data_0028 ; clear the selected byte or register
                    bra       Code_13C1 ; continue at the selected control-flow target
Data_13EB           fcc       " End of Search"               ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_13FA           fcc       "("                            ; embedded text or resource bytes
                    fcb       $0B,$14,$11,$03,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $0C       ; table, bitmap, or initialized data bytes
Code_1402           leax      >Data_13FA,PCR ; form the referenced address without reading memory
                    leay      >Data_13EB,PCR ; form the referenced address without reading memory
                    bra       Code_140C ; continue at the selected control-flow target
Code_140C           lda       Addr_000F ; load the value needed by the following operation
                    ldb       Addr_0010 ; load the value needed by the following operation
                    pshs      D         ; preserve the listed registers on the stack
                    bsr       Code_1424 ; call the referenced helper routine
                    lda       #$01      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    puls      D         ; restore the listed registers from the stack
                    sta       Addr_000F ; save the current value in working storage
                    stb       Addr_0010 ; save the current value in working storage
                    lbsr      Code_098D ; call the referenced helper routine
                    rts                 ; return to the caller
Code_1424           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       ":"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    tfr       Y,X       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_1437           lbsr      Code_32A8 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    bne       Code_144D ; branch when the compared values differ
                    tst       Addr_002B ; set condition flags from the current value
                    bne       Code_1448 ; branch when the compared values differ
Code_1441           lda       #$01      ; load the value needed by the following operation
                    sta       Addr_002B ; save the current value in working storage
                    lbsr      Code_1402 ; call the referenced helper routine
Code_1448           lbsr      Code_2496 ; call the referenced helper routine
                    bra       Code_1453 ; continue at the selected control-flow target
Code_144D           lbsr      Code_2496 ; call the referenced helper routine
Code_1450           lbsr      Code_137C ; call the referenced helper routine
Code_1453           lbsr      Code_117D ; call the referenced helper routine
                    rts                 ; return to the caller
Code_1457           lda       #$01      ; load the value needed by the following operation
                    sta       Addr_002F ; save the current value in working storage
                    lbsr      Code_1895 ; call the referenced helper routine
                    lbsr      Code_3296 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_1469 ; branch when the compared values are equal
Code_1464           bsr       Code_144D ; call the referenced helper routine
                    lbra      Code_1084 ; continue at the distant control-flow target
Code_1469           clr       Addr_002F ; clear the selected byte or register
                    lbsr      Code_32A8 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    bne       Code_1464 ; branch when the compared values differ
                    clr       Addr_002C ; clear the selected byte or register
                    lda       #$01      ; load the value needed by the following operation
                    sta       Data_003B ;1475: 97 3B          '. ; save the current value in working storage
                    lbra      Code_1070 ; continue at the distant control-flow target
Code_147A           lbsr      Code_3296 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    bne       Code_144D ; branch when the compared values differ
                    clr       Addr_002C ; clear the selected byte or register
                    lbsr      Code_2496 ; call the referenced helper routine
                    lbsr      Code_137C ; call the referenced helper routine
                    lbsr      Code_1392 ; call the referenced helper routine
                    lda       #$01      ; load the value needed by the following operation
                    sta       Data_003B ;148D: 97 3B          '. ; save the current value in working storage
                    lbra      Code_117D ; continue at the distant control-flow target
Code_1492           lbsr      Code_1895 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1B       ; private DeskMate service selector
                    lbsr      Code_3DA9 ; call the referenced helper routine
                    lbsr      Code_2DCA ; call the referenced helper routine
                    bcc       Code_14A6 ; branch when carry is clear
                    bsr       Code_1450 ; call the referenced helper routine
                    lbra      Code_1084 ; continue at the distant control-flow target
Code_14A6           inc       Addr_002F ; advance the selected counter
Code_14A8           lbsr      Code_137C ; call the referenced helper routine
                    lbsr      Code_2CF8 ; call the referenced helper routine
                    bcs       Code_14C3 ; branch when carry reports an unsigned underflow or error
                    lbsr      Code_32A8 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_14BB ; branch when the compared values are equal
                    lbsr      Code_2496 ; call the referenced helper routine
                    bra       Code_14A8 ; continue at the selected control-flow target
Code_14BB           lbsr      Code_2DFF ; call the referenced helper routine
                    bsr       Code_1441 ; call the referenced helper routine
                    lbra      Code_1084 ; continue at the distant control-flow target
Code_14C3           lbsr      Code_2DFF ; call the referenced helper routine
                    bsr       Code_1448 ; call the referenced helper routine
                    lbra      Code_1084 ; continue at the distant control-flow target
Code_14CB           tst       Data_0028 ; set condition flags from the current value
                    bne       Code_14DB ; branch when the compared values differ
                    tst       Code_0029 ; set condition flags from the current value
                    bne       Code_14DB ; branch when the compared values differ
                    tst       Data_003B ;14D3: 0D 3B          '. ; set condition flags from the current value
                    bne       Code_14DB ; branch when the compared values differ
                    tst       Addr_002B ; set condition flags from the current value
                    beq       Code_150C ; branch when the compared values are equal
Code_14DB           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1B       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    pshs      D         ; preserve the listed registers on the stack
                    lda       Addr_000F ; load the value needed by the following operation
                    ldb       Addr_0010 ; load the value needed by the following operation
                    pshs      Y,X,D     ; preserve the listed registers on the stack
                    ldd       Data_0051 ; load the value needed by the following operation
                    pshs      D         ; preserve the listed registers on the stack
                    lbsr      Code_1620 ; call the referenced helper routine
                    puls      D         ; restore the listed registers from the stack
                    std       Data_0051 ; save the current value in working storage
                    lbsr      Code_250D ; call the referenced helper routine
                    puls      Y,X,D     ; restore the listed registers from the stack
                    sta       Addr_000F ; save the current value in working storage
                    stb       Addr_0010 ; save the current value in working storage
                    lbsr      Code_098D ; call the referenced helper routine
                    clr       Data_0028 ; clear the selected byte or register
                    clr       Code_0029 ; clear the selected byte or register
                    clr       Addr_002B ; clear the selected byte or register
                    clr       Data_003B ;1508: 0F 3B          '. ; clear the selected byte or register
                    puls      D         ; restore the listed registers from the stack
Code_150C           rts                 ; return to the caller
Code_150D           lbsr      Code_2B4C ; call the referenced helper routine
                    clr       Addr_0027 ; clear the selected byte or register
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Addr_0026 ; save the current value in working storage
                    clr       Addr_001E ; clear the selected byte or register
Code_1518           lbsr      Code_179C ; call the referenced helper routine
                    clr       Code_001D ; clear the selected byte or register
                    lbsr      Code_3DA9 ; call the referenced helper routine
                    lbsr      Code_1620 ; call the referenced helper routine
Code_1523           lda       #$05      ; load the value needed by the following operation
                    sta       Data_0039 ; save the current value in working storage
                    sta       Data_0038 ; save the current value in working storage
                    lbsr      Code_260B ; call the referenced helper routine
                    lda       #$01      ; load the value needed by the following operation
                    sta       Addr_001C ; save the current value in working storage
                    lbsr      Code_250D ; call the referenced helper routine
Code_1533           lbsr      Code_15F0 ; call the referenced helper routine
Code_1536           ldb       #$83      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    bne       Code_155B ; branch when the compared values differ
                    lbsr      Code_3BCA ; call the referenced helper routine
                    pshs      A         ; preserve the listed registers on the stack
                    lbsr      Code_15F0 ; call the referenced helper routine
                    puls      A         ; restore the listed registers from the stack
                    tsta                ; set condition flags from the current value
                    beq       Code_1536 ; branch when the compared values are equal
                    lda       Addr_0026 ; load the value needed by the following operation
                    cmpa      #$09      ; compare against the limit and set condition flags
                    lbeq      Code_17F3 ; take the distant branch when values are equal
                    cmpa      #$02      ; compare against the limit and set condition flags
                    lbeq      Code_17FE ; take the distant branch when values are equal
                    bra       Code_1536 ; continue at the selected control-flow target
Code_155B           cmpa      #$8C      ; compare against the limit and set condition flags
                    bne       Code_1567 ; branch when the compared values differ
                    tst       Addr_0026 ; set condition flags from the current value
                    lbmi      Code_17F3 ; take the distant branch while the value is negative
                    bra       Code_1536 ; continue at the selected control-flow target
Code_1567           cmpa      #$05      ; compare against the limit and set condition flags
                    lbeq      Code_182A ; take the distant branch when values are equal
                    cmpa      #$AF      ; compare against the limit and set condition flags
                    lbeq      Code_17FE ; take the distant branch when values are equal
                    cmpa      #$B4      ; compare against the limit and set condition flags
                    lbeq      Code_180E ; take the distant branch when values are equal
                    lbsr      Code_1856 ; call the referenced helper routine
                    bra       Code_1533 ; continue at the selected control-flow target
Code_157E           lda       -$0F,X    ; load the value needed by the following operation
                    lbsr      Code_05C8 ; call the referenced helper routine
                    bmi       Code_15B1 ; branch while the tested value is negative
                    lda       $01,X     ; load the value needed by the following operation
                    lbsr      Code_05C8 ; call the referenced helper routine
                    bpl       Code_1592 ; branch while the tested value is nonnegative
                    lda       #$20      ; load the value needed by the following operation
                    cmpa      ,X        ; compare against the limit and set condition flags
                    bne       Code_15B4 ; branch when the compared values differ
Code_1592           lda       Addr_000F ; load the value needed by the following operation
                    ldb       Addr_0010 ; load the value needed by the following operation
                    pshs      Y,X,D     ; preserve the listed registers on the stack
Code_1598           lbsr      Code_0BD2 ; call the referenced helper routine
                    lda       #$20      ; load the value needed by the following operation
                    cmpa      ,Y        ; compare against the limit and set condition flags
                    beq       Code_15B2 ; branch when the compared values are equal
                    lda       -$0F,Y    ; load the value needed by the following operation
                    lbsr      Code_05C8 ; call the referenced helper routine
                    bpl       Code_1598 ; branch while the tested value is nonnegative
Code_15A8           puls      Y,X,D     ; restore the listed registers from the stack
                    sta       Addr_000F ; save the current value in working storage
                    stb       Addr_0010 ; save the current value in working storage
                    lbsr      Code_098D ; call the referenced helper routine
Code_15B1           rts                 ; return to the caller
Code_15B2           leas      $06,S     ; form the referenced address without reading memory
Code_15B4           sta       Code_0017 ; save the current value in working storage
                    sta       ,X        ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "C"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_15BD           lda       Addr_000F ; load the value needed by the following operation
                    ldb       Addr_0010 ; load the value needed by the following operation
                    pshs      Y,X,D     ; preserve the listed registers on the stack
Code_15C3           lbsr      Code_0BD2 ; call the referenced helper routine
                    lda       #$20      ; load the value needed by the following operation
                    cmpa      ,Y        ; compare against the limit and set condition flags
                    beq       Code_15D5 ; branch when the compared values are equal
                    lda       -$0F,Y    ; load the value needed by the following operation
                    lbsr      Code_05C8 ; call the referenced helper routine
                    bpl       Code_15C3 ; branch while the tested value is nonnegative
                    bra       Code_15A8 ; continue at the selected control-flow target
Code_15D5           leas      $06,S     ; form the referenced address without reading memory
                    rts                 ; return to the caller
Code_15D8           lda       Addr_000F ; load the value needed by the following operation
                    ldb       Addr_0010 ; load the value needed by the following operation
                    pshs      Y,X,D     ; preserve the listed registers on the stack
Code_15DE           lbsr      Code_0BA3 ; call the referenced helper routine
                    lda       #$20      ; load the value needed by the following operation
                    cmpa      ,Y        ; compare against the limit and set condition flags
                    beq       Code_15D5 ; branch when the compared values are equal
                    lda       $01,Y     ; load the value needed by the following operation
                    lbsr      Code_05C8 ; call the referenced helper routine
                    bpl       Code_15DE ; branch while the tested value is nonnegative
                    bra       Code_15A8 ; continue at the selected control-flow target
Code_15F0           lda       #$20      ; load the value needed by the following operation
                    cmpa      ,Y        ; compare against the limit and set condition flags
                    beq       Code_1612 ; branch when the compared values are equal
                    lda       $01,Y     ; load the value needed by the following operation
                    lbsr      Code_05C8 ; call the referenced helper routine
                    bmi       Code_1602 ; branch while the tested value is negative
                    lbsr      Code_0BA3 ; call the referenced helper routine
                    bra       Code_15F0 ; continue at the selected control-flow target
Code_1602           lbsr      Code_0DB1 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_160D ; branch when the compared values are equal
                    lbsr      Code_2604 ; call the referenced helper routine
                    bra       Code_15F0 ; continue at the selected control-flow target
Code_160D           lbsr      Code_25BA ; call the referenced helper routine
                    bra       Code_15F0 ; continue at the selected control-flow target
Code_1612           rts                 ; return to the caller
Code_1613           clra                ; clear the selected byte or register
                    ldx       #Addr_0E00 ; load the value needed by the following operation
                    ldy       #Addr_024E ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0E       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_1620           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    bsr       Code_1613 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    leax      $088B,U   ; form the referenced address without reading memory
                    clr       Addr_000F ; clear the selected byte or register
                    lda       #$02      ; load the value needed by the following operation
                    sta       Addr_0010 ; save the current value in working storage
Code_1635           lbsr      Code_098D ; call the referenced helper routine
                    lda       ,X        ; load the value needed by the following operation
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    beq       Code_1656 ; branch when the compared values are equal
                    leax      $01,X     ; form the referenced address without reading memory
                    clrb                ; clear the selected byte or register
                    pshs      D         ; preserve the listed registers on the stack
                    clra                ; clear the selected byte or register
                    ldb       Data_0041 ; load the value needed by the following operation
                    tfr       D,Y       ; copy the source register into the destination register
                    puls      D         ; restore the listed registers from the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $22       ; private DeskMate service selector
                    lda       Data_0041 ; load the value needed by the following operation
                    leax      A,X       ; form the referenced address without reading memory
                    inc       Addr_0010 ; advance the selected counter
                    bra       Code_1635 ; continue at the selected control-flow target
Code_1656           lda       Addr_0010 ; load the value needed by the following operation
                    cmpa      Data_0042 ; compare against the limit and set condition flags
                    bge       Code_1664 ; branch when the signed value is at least the limit
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       ":"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "@"                            ; embedded text or resource bytes
Code_1664           lda       Addr_0010 ; load the value needed by the following operation
                    sta       Addr_0015 ; save the current value in working storage
                    bsr       Code_166B ; call the referenced helper routine
                    rts                 ; return to the caller
Code_166B           leax      $12E1,U   ; form the referenced address without reading memory
                    stx       Data_0051 ; save the current value in working storage
                    leax      $088B,U   ; form the referenced address without reading memory
                    leay      $0519,U   ; form the referenced address without reading memory
                    ldb       #$02      ; load the value needed by the following operation
Code_167B           lda       ,X        ; load the value needed by the following operation
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    beq       Code_16B0 ; branch when the compared values are equal
                    cmpa      #$7F      ; compare against the limit and set condition flags
                    bne       Code_168F ; branch when the compared values differ
                    lda       Data_0041 ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    leax      A,X       ; form the referenced address without reading memory
                    leay      A,Y       ; form the referenced address without reading memory
                    incb                ; advance the selected counter
                    bra       Code_167B ; continue at the selected control-flow target
Code_168F           leax      $0E,X     ; form the referenced address without reading memory
                    leay      $0E,Y     ; form the referenced address without reading memory
                    pshs      Y,X       ; preserve the listed registers on the stack
                    ldy       Data_0051 ; load the value needed by the following operation
                    stb       ,Y+       ; store the value and advance the destination pointer
                    stx       ,Y++      ; store the value and advance the destination pointer
                    ldx       $02,S     ; load the value needed by the following operation
                    stx       ,Y++      ; store the value and advance the destination pointer
                    sty       Data_0051 ; save the current value in working storage
                    puls      Y,X       ; restore the listed registers from the stack
                    lda       Data_0041 ; load the value needed by the following operation
                    suba      #$0D      ; subtract the operand from the running value
                    leax      A,X       ; form the referenced address without reading memory
                    leay      A,Y       ; form the referenced address without reading memory
                    incb                ; advance the selected counter
                    bra       Code_167B ; continue at the selected control-flow target
Code_16B0           ldy       Data_0051 ; load the value needed by the following operation
                    lda       #$FF      ; load the value needed by the following operation
                    sta       ,Y        ; save the current value in working storage
                    rts                 ; return to the caller
Code_16B8           pshs      U         ; preserve the listed registers on the stack
                    tfr       X,Y       ; copy the source register into the destination register
Code_16BC           leay      $01,Y     ; form the referenced address without reading memory
                    leau      $01,U     ; form the referenced address without reading memory
                    lda       ,Y        ; load the value needed by the following operation
                    lbsr      Code_05C8 ; call the referenced helper routine
                    bpl       Code_16BC ; branch while the tested value is nonnegative
Code_16C7           lda       ,-Y       ; load the value needed by the following operation
                    leau      -$01,U    ; form the referenced address without reading memory
                    cmpa      #$20      ; compare against the limit and set condition flags
                    beq       Code_16C7 ; branch when the compared values are equal
                    lda       -$0E,Y    ; load the value needed by the following operation
                    lbsr      Code_05C8 ; call the referenced helper routine
                    bmi       Code_16DC ; branch while the tested value is negative
                    lda       ,U        ; load the value needed by the following operation
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bne       Code_16C7 ; branch when the compared values differ
Code_16DC           leay      $01,Y     ; form the referenced address without reading memory
                    puls      U         ; restore the listed registers from the stack
                    rts                 ; return to the caller
Code_16E1           lbsr      Code_179C ; call the referenced helper routine
                    leax      $088B,U   ; form the referenced address without reading memory
Code_16E8           lda       ,X+       ; fetch the next value and advance the source pointer
                    bpl       Code_16E8 ; branch while the tested value is nonnegative
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    beq       Code_1714 ; branch when the compared values are equal
                    anda      #$7F      ; mask off unwanted bits
                    lbsr      Code_176B ; call the referenced helper routine
                    tstb                ; set condition flags from the current value
                    bne       Code_16E8 ; branch when the compared values differ
                    leax      $0E,X     ; form the referenced address without reading memory
Code_16FA           lda       ,X        ; load the value needed by the following operation
                    lbsr      Code_05C8 ; call the referenced helper routine
                    bmi       Code_16E8 ; branch while the tested value is negative
                    cmpa      #$20      ; compare against the limit and set condition flags
                    beq       Code_1709 ; branch when the compared values are equal
                    leax      $01,X     ; form the referenced address without reading memory
                    bra       Code_16FA ; continue at the selected control-flow target
Code_1709           lda       ,Y+       ; fetch the next value and advance the source pointer
                    lbsr      Code_05C8 ; call the referenced helper routine
                    bmi       Code_16E8 ; branch while the tested value is negative
                    sta       ,X+       ; store the value and advance the destination pointer
                    bra       Code_16FA ; continue at the selected control-flow target
Code_1714           rts                 ; return to the caller
Code_1715           leax      $088B,U   ; form the referenced address without reading memory
                    leay      $0BFD,U   ; form the referenced address without reading memory
                    pshs      U         ; preserve the listed registers on the stack
                    leau      $0519,U   ; form the referenced address without reading memory
                    lda       ,X        ; load the value needed by the following operation
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    beq       Code_1767 ; branch when the compared values are equal
Code_1729           sta       ,Y+       ; store the value and advance the destination pointer
                    leax      $0F,X     ; form the referenced address without reading memory
                    leau      $0F,U     ; form the referenced address without reading memory
                    pshs      Y         ; preserve the listed registers on the stack
                    lbsr      Code_16B8 ; call the referenced helper routine
                    puls      D         ; restore the listed registers from the stack
                    pshs      Y         ; preserve the listed registers on the stack
                    tfr       D,Y       ; copy the source register into the destination register
Code_173A           cmpx      ,S        ; compare against the limit and set condition flags
                    bge       Code_1752 ; branch when the signed value is at least the limit
                    lda       ,U        ; load the value needed by the following operation
                    cmpa      #$20      ; compare against the limit and set condition flags
                    beq       Code_174A ; branch when the compared values are equal
                    leax      $01,X     ; form the referenced address without reading memory
                    leau      $01,U     ; form the referenced address without reading memory
                    bra       Code_173A ; continue at the selected control-flow target
Code_174A           lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,Y+       ; store the value and advance the destination pointer
                    leau      $01,U     ; form the referenced address without reading memory
                    bra       Code_173A ; continue at the selected control-flow target
Code_1752           leas      $02,S     ; form the referenced address without reading memory
Code_1754           leau      $01,U     ; form the referenced address without reading memory
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    lbsr      Code_05C8 ; call the referenced helper routine
                    bpl       Code_1754 ; branch while the tested value is nonnegative
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    beq       Code_1767 ; branch when the compared values are equal
                    leax      -$01,X    ; form the referenced address without reading memory
                    leau      -$01,U    ; form the referenced address without reading memory
                    bra       Code_1729 ; continue at the selected control-flow target
Code_1767           sta       ,Y+       ; store the value and advance the destination pointer
                    puls      PC,U      ; restore the listed registers from the stack
Code_176B           pshs      A         ; preserve the listed registers on the stack
                    leay      $0BFD,U   ; form the referenced address without reading memory
Code_1771           lda       ,Y+       ; fetch the next value and advance the source pointer
                    bpl       Code_1771 ; branch while the tested value is nonnegative
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    beq       Code_1783 ; branch when the compared values are equal
                    anda      #$7F      ; mask off unwanted bits
                    cmpa      ,S        ; compare against the limit and set condition flags
                    bne       Code_1771 ; branch when the compared values differ
                    leas      $01,S     ; form the referenced address without reading memory
                    clrb                ; clear the selected byte or register
                    rts                 ; return to the caller
Code_1783           leas      $01,S     ; form the referenced address without reading memory
                    ldb       #$01      ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_1788           leax      $0F6F,U   ; form the referenced address without reading memory
                    leay      $088B,U   ; form the referenced address without reading memory
                    bra       Code_17A4 ; continue at the selected control-flow target
Code_1792           leax      $088B,U   ; form the referenced address without reading memory
                    leay      $0F6F,U   ; form the referenced address without reading memory
                    bra       Code_17A4 ; continue at the selected control-flow target
Code_179C           leax      $0519,U   ; form the referenced address without reading memory
                    leay      $088B,U   ; form the referenced address without reading memory
Code_17A4           lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    beq       Code_17AE ; branch when the compared values are equal
                    sta       ,Y+       ; store the value and advance the destination pointer
                    bra       Code_17A4 ; continue at the selected control-flow target
Code_17AE           sta       ,Y+       ; store the value and advance the destination pointer
                    rts                 ; return to the caller
Code_17B1           cmpa      #$20      ; compare against the limit and set condition flags
                    bge       Code_17B6 ; branch when the signed value is at least the limit
                    rts                 ; return to the caller
Code_17B6           pshs      U,Y,X,A   ; preserve the listed registers on the stack
Code_17B8           leay      $01,Y     ; form the referenced address without reading memory
                    leax      $01,X     ; form the referenced address without reading memory
                    lda       ,X        ; load the value needed by the following operation
                    lbsr      Code_05C8 ; call the referenced helper routine
                    bpl       Code_17B8 ; branch while the tested value is nonnegative
Code_17C3           leax      -$01,X    ; form the referenced address without reading memory
                    leay      -$01,Y    ; form the referenced address without reading memory
                    lda       ,Y        ; load the value needed by the following operation
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bne       Code_17C3 ; branch when the compared values differ
Code_17CD           cmpx      $01,S     ; compare against the limit and set condition flags
                    beq       Code_17E5 ; branch when the compared values are equal
                    pshs      X         ; preserve the listed registers on the stack
Code_17D3           leax      -$01,X    ; form the referenced address without reading memory
                    leay      -$01,Y    ; form the referenced address without reading memory
                    lda       ,Y        ; load the value needed by the following operation
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bne       Code_17D3 ; branch when the compared values differ
                    puls      U         ; restore the listed registers from the stack
                    lda       ,X        ; load the value needed by the following operation
                    sta       ,U        ; save the current value in working storage
                    bra       Code_17CD ; continue at the selected control-flow target
Code_17E5           puls      A         ; restore the listed registers from the stack
                    sta       ,X        ; save the current value in working storage
                    puls      U,Y,X     ; restore the listed registers from the stack
                    lbsr      Code_24A5 ; call the referenced helper routine
                    lda       #$01      ; load the value needed by the following operation
                    sta       Code_0017 ; save the current value in working storage
                    rts                 ; return to the caller
Code_17F3           lbsr      Code_1CB8 ; call the referenced helper routine
                    cmpb      #$05      ; compare against the limit and set condition flags
                    beq       Code_1801 ; branch when the compared values are equal
                    cmpa      #$02      ; compare against the limit and set condition flags
                    bne       Code_180A ; branch when the compared values differ
Code_17FE           lbsr      Code_1D60 ; call the referenced helper routine
Code_1801           lbsr      Code_3DA9 ; call the referenced helper routine
                    lbsr      Code_1620 ; call the referenced helper routine
                    lbra      Code_1523 ; continue at the distant control-flow target
Code_180A           cmpa      #$01      ; compare against the limit and set condition flags
                    beq       Code_182A ; branch when the compared values are equal
Code_180E           bsr       Code_1818 ; call the referenced helper routine
                    lbsr      Code_2437 ; call the referenced helper routine
                    beq       Code_1831 ; branch when the compared values are equal
                    lbra      Code_1518 ; continue at the distant control-flow target
Code_1818           lbsr      Code_2445 ; call the referenced helper routine
                    bcs       Code_1823 ; branch when carry reports an unsigned underflow or error
                    lbsr      Code_39AF ; call the referenced helper routine
                    lbsr      Code_1E36 ; call the referenced helper routine
Code_1823           lbsr      Code_3DA9 ; call the referenced helper routine
                    lbsr      Code_1895 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_182A           bsr       Code_1818 ; call the referenced helper routine
                    lbsr      Code_2437 ; call the referenced helper routine
                    bne       Code_1833 ; branch when the compared values differ
Code_1831           bsr       Code_184F ; call the referenced helper routine
Code_1833           lbsr      Code_392C ; call the referenced helper routine
                    lbra      Code_04EE ; continue at the distant control-flow target
Data_1839           fcc       "   File is now full"          ; embedded text or resource bytes
                    fcb       $0A,$0D,$00 ; table, bitmap, or initialized data bytes
Code_184F           leay      >Data_1839,PCR ; form the referenced address without reading memory
                    lbra      Code_1FC8 ; continue at the distant control-flow target
Code_1856           cmpa      #$13      ; compare against the limit and set condition flags
                    lbeq      Code_2604 ; take the distant branch when values are equal
                    cmpa      #$12      ; compare against the limit and set condition flags
                    lbeq      Code_25F6 ; take the distant branch when values are equal
                    cmpa      #$0C      ; compare against the limit and set condition flags
                    lbeq      Code_18BB ; take the distant branch when values are equal
                    cmpa      #$0A      ; compare against the limit and set condition flags
                    lbeq      Code_0B58 ; take the distant branch when values are equal
                    cmpa      #$09      ; compare against the limit and set condition flags
                    lbeq      Code_15D8 ; take the distant branch when values are equal
                    cmpa      #$08      ; compare against the limit and set condition flags
                    lbeq      Code_15BD ; take the distant branch when values are equal
                    cmpa      #$88      ; compare against the limit and set condition flags
                    bne       Code_1887 ; branch when the compared values differ
                    tst       Code_001D ; set condition flags from the current value
                    lbeq      Code_157E ; take the distant branch when values are equal
                    lbra      Code_27D0 ; continue at the distant control-flow target
Code_1887           cmpa      #$E9      ; compare against the limit and set condition flags
                    bne       Code_189E ; branch when the compared values differ
                    tst       Code_001D ; set condition flags from the current value
                    bne       Code_1895 ; branch when the compared values differ
                    lda       #$01      ; load the value needed by the following operation
                    sta       Code_001D ; save the current value in working storage
                    bra       Code_1899 ; continue at the selected control-flow target
Code_1895           clr       Code_001D ; clear the selected byte or register
                    lda       #$FF      ; load the value needed by the following operation
Code_1899           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1E       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_189E           cmpa      #$0D      ; compare against the limit and set condition flags
                    bne       Code_18AC ; branch when the compared values differ
                    lbsr      Code_0DB1 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    bne       Code_18AB ; branch when the compared values differ
                    lbsr      Code_25BA ; call the referenced helper routine
Code_18AB           rts                 ; return to the caller
Code_18AC           tst       Code_001D ; set condition flags from the current value
                    beq       Code_18B7 ; branch when the compared values are equal
                    lbsr      Code_17B1 ; call the referenced helper routine
                    lbsr      Code_15D8 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_18B7           lbsr      Code_0C6B ; call the referenced helper routine
                    rts                 ; return to the caller
Code_18BB           lbsr      Code_0F70 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    bmi       Code_18EB ; branch while the tested value is negative
                    pshs      X         ; preserve the listed registers on the stack
                    lbsr      Code_0B1D ; call the referenced helper routine
                    lda       Addr_000F ; load the value needed by the following operation
                    ldb       Addr_0010 ; load the value needed by the following operation
                    pshs      Y,X,D     ; preserve the listed registers on the stack
Code_18CC           cmpx      $06,S     ; compare against the limit and set condition flags
                    beq       Code_18DB ; branch when the compared values are equal
                    lda       #$20      ; load the value needed by the following operation
                    cmpa      ,Y        ; compare against the limit and set condition flags
                    beq       Code_18E8 ; branch when the compared values are equal
                    lbsr      Code_0BA3 ; call the referenced helper routine
                    bra       Code_18CC ; continue at the selected control-flow target
Code_18DB           puls      Y,X,D     ; restore the listed registers from the stack
                    sta       Addr_000F ; save the current value in working storage
                    stb       Addr_0010 ; save the current value in working storage
                    lbsr      Code_098D ; call the referenced helper routine
                    leas      $02,S     ; form the referenced address without reading memory
                    bra       Code_18BB ; continue at the selected control-flow target
Code_18E8           leas      $08,S     ; form the referenced address without reading memory
                    rts                 ; return to the caller
Code_18EB           pshs      X         ; preserve the listed registers on the stack
                    leax      $12E1,U   ; form the referenced address without reading memory
                    cmpx      Data_0051 ; compare against the limit and set condition flags
                    puls      X         ; restore the listed registers from the stack
                    bne       Code_18FA ; branch when the compared values differ
                    lbra      Code_15F0 ; continue at the distant control-flow target
Code_18FA           lbsr      Code_25CC ; call the referenced helper routine
                    bsr       Code_1903 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    bne       Code_18EB ; branch when the compared values differ
                    rts                 ; return to the caller
Code_1903           lda       #$20      ; load the value needed by the following operation
                    cmpa      ,Y        ; compare against the limit and set condition flags
                    beq       Code_1915 ; branch when the compared values are equal
                    lda       $01,Y     ; load the value needed by the following operation
                    lbsr      Code_05C8 ; call the referenced helper routine
                    bmi       Code_1917 ; branch while the tested value is negative
                    lbsr      Code_0BA3 ; call the referenced helper routine
                    bra       Code_1903 ; continue at the selected control-flow target
Code_1915           clra                ; clear the selected byte or register
                    rts                 ; return to the caller
Code_1917           lda       #$01      ; load the value needed by the following operation
                    rts                 ; return to the caller
Data_191A           fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       " 5 delete"                    ; embedded text or resource bytes
                    fcb       $00,$01   ; table, bitmap, or initialized data bytes
                    fcc       " 2 print"                     ; embedded text or resource bytes
                    fcb       $00,$01   ; table, bitmap, or initialized data bytes
                    fcc       " ? help"                      ; embedded text or resource bytes
                    fcb       $00,$01,$04 ; table, bitmap, or initialized data bytes
                    fcc       "   exit"                      ; embedded text or resource bytes
                    fcb       $00,$01   ; table, bitmap, or initialized data bytes
                    fcc       " 7 find"                      ; embedded text or resource bytes
                    fcb       $00,$01   ; table, bitmap, or initialized data bytes
                    fcc       " ? help"                      ; embedded text or resource bytes
                    fcb       $00,$01   ; table, bitmap, or initialized data bytes
                    fcc       " 4 add"                       ; embedded text or resource bytes
                    fcb       $00,$01,$04 ; table, bitmap, or initialized data bytes
                    fcc       "   exit"                      ; embedded text or resource bytes
                    fcb       $00,$01   ; table, bitmap, or initialized data bytes
                    fcc       " ? help"                      ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_196F           fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       " 5 delete field"              ; embedded text or resource bytes
                    fcb       $00,$01,$04 ; table, bitmap, or initialized data bytes
                    fcc       "   sort order"                ; embedded text or resource bytes
                    fcb       $00,$01,$04 ; table, bitmap, or initialized data bytes
                    fcc       "   exit"                      ; embedded text or resource bytes
                    fcb       $00,$01   ; table, bitmap, or initialized data bytes
                    fcc       " ? help"                      ; embedded text or resource bytes
                    fcb       $00,$01,$04 ; table, bitmap, or initialized data bytes
                    fcc       "   close"                     ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_19AE           fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       " 2 print"                     ; embedded text or resource bytes
                    fcb       $00,$01   ; table, bitmap, or initialized data bytes
                    fcc       " ? help"                      ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_19C1           fcb       $01,$04   ; table, bitmap, or initialized data bytes
                    fcc       "   view"                      ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_19CB           fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       " 4 insert"                    ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_19D6           fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       " 5 delete"                    ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_19E1           fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       " 6 mark"                      ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_19EA           fcb       $01,$03   ; table, bitmap, or initialized data bytes
                    fcc       "   format"                    ; embedded text or resource bytes
                    fcb       $00,$01   ; table, bitmap, or initialized data bytes
                    fcc       " ? help"                      ; embedded text or resource bytes
                    fcb       $00,$01,$01 ; table, bitmap, or initialized data bytes
                    fcc       " 1"                           ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       " less"                        ; embedded text or resource bytes
                    fcb       $00,$01   ; table, bitmap, or initialized data bytes
                    fcc       " 2 greater"                   ; embedded text or resource bytes
                    fcb       $00,$01   ; table, bitmap, or initialized data bytes
                    fcc       " 3 equal"                     ; embedded text or resource bytes
                    fcb       $00,$01   ; table, bitmap, or initialized data bytes
                    fcc       " 7 find"                      ; embedded text or resource bytes
                    fcb       $00,$01,$04 ; table, bitmap, or initialized data bytes
                    fcc       "   clear"                     ; embedded text or resource bytes
                    fcb       $00,$01   ; table, bitmap, or initialized data bytes
                    fcc       " 6 mark"                      ; embedded text or resource bytes
                    fcb       $00,$01,$04 ; table, bitmap, or initialized data bytes
                    fcc       "   exit"                      ; embedded text or resource bytes
                    fcb       $00,$01   ; table, bitmap, or initialized data bytes
                    fcc       " ? help"                      ; embedded text or resource bytes
                    fcb       $00,$FF   ; table, bitmap, or initialized data bytes
Data_1A51           fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
Data_1A57           fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
Data_1A5D           fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
Data_1A63           fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00   ; table, bitmap, or initialized data bytes
Data_1A6B           fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
Data_1A71           fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
Data_1A7D           fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00 ; table, bitmap, or initialized data bytes
Code_1A8D           leay      >Data_1A51,PCR ; form the referenced address without reading memory
                    leax      Data_1C1E,PCR ; form the referenced address without reading memory
                    sty       ,X        ; save the current value in working storage
                    leay      >Data_1A57,PCR ; form the referenced address without reading memory
                    leax      Data_1BE1,PCR ; form the referenced address without reading memory
                    sty       ,X        ; save the current value in working storage
                    leay      >Data_1A5D,PCR ; form the referenced address without reading memory
                    leax      Data_1CB1,PCR ; form the referenced address without reading memory
                    sty       ,X        ; save the current value in working storage
                    leay      >Data_1A63,PCR ; form the referenced address without reading memory
                    leax      Data_1C63,PCR ; form the referenced address without reading memory
                    sty       ,X        ; save the current value in working storage
                    leay      >Data_1A6B,PCR ; form the referenced address without reading memory
                    leax      >Data_1B29,PCR ; form the referenced address without reading memory
                    sty       ,X        ; save the current value in working storage
                    leay      >Data_1A71,PCR ; form the referenced address without reading memory
                    leax      Data_1B70,PCR ; form the referenced address without reading memory
                    sty       ,X        ; save the current value in working storage
                    leay      >Data_1A7D,PCR ; form the referenced address without reading memory
                    leax      Data_1CF1,PCR ; form the referenced address without reading memory
                    sty       ,X        ; save the current value in working storage
                    leax      Data_191A,PCR ; form the referenced address without reading memory
                    leay      Data_1A51,PCR ; form the referenced address without reading memory
Code_1AE2           stx       ,Y++      ; store the value and advance the destination pointer
Code_1AE4           tst       ,X+       ; set condition flags from the current value
                    bne       Code_1AE4 ; branch when the compared values differ
                    tst       ,X        ; set condition flags from the current value
                    bpl       Code_1AE2 ; branch while the tested value is nonnegative
                    rts                 ; return to the caller
Code_1AED           sta       Data_0039 ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1B       ; private DeskMate service selector
                    lda       #$03      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_1B06           pshs      D         ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    lda       #$01      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       ":"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    puls      PC,D      ; restore the listed registers from the stack
Data_1B21           fcc       "("                            ; embedded text or resource bytes
                    fcb       $00,$01,$0A,$07,$00,$AA ; table, bitmap, or initialized data bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
Data_1B29           fcb       $00,$00,$05,$08,$03,$00 ; table, bitmap, or initialized data bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
Code_1B30           lda       #$01      ; load the value needed by the following operation
                    leax      >Data_1B21,PCR ; form the referenced address without reading memory
                    lbsr      Code_1AED ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    leax      >Data_1B29,PCR ; form the referenced address without reading memory
                    lbsr      Code_3E2A ; call the referenced helper routine
Code_1B41           lbsr      Code_3F3A ; call the referenced helper routine
                    cmpb      #$05      ; compare against the limit and set condition flags
                    beq       Code_1B60 ; branch when the compared values are equal
                    cmpb      #$AF      ; compare against the limit and set condition flags
                    beq       Code_1B64 ; branch when the compared values are equal
                    cmpb      #$0D      ; compare against the limit and set condition flags
                    beq       Code_1B56 ; branch when the compared values are equal
                    cmpb      #$B2      ; compare against the limit and set condition flags
                    bne       Code_1B41 ; branch when the compared values differ
                    lda       #$01      ; load the value needed by the following operation
Code_1B56           cmpa      #$01      ; compare against the limit and set condition flags
                    bne       Code_1B60 ; branch when the compared values differ
                    ldx       Addr_000C ; load the value needed by the following operation
                    cmpx      Addr_0006 ; compare against the limit and set condition flags
                    beq       Code_1B41 ; branch when the compared values are equal
Code_1B60           lbsr      Code_1B06 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_1B64           lda       #$02      ; load the value needed by the following operation
                    bra       Code_1B60 ; continue at the selected control-flow target
Data_1B68           fcc       "("                            ; embedded text or resource bytes
                    fcb       $05,$01,$0A,$0A,$00,$AA ; table, bitmap, or initialized data bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
Data_1B70           fcb       $00,$00,$08,$08,$06,$00 ; table, bitmap, or initialized data bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
Code_1B77           lda       #$02      ; load the value needed by the following operation
                    leax      >Data_1B68,PCR ; form the referenced address without reading memory
                    lbsr      Code_1AED ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    leax      >Data_1B70,PCR ; form the referenced address without reading memory
                    lbsr      Code_3E2A ; call the referenced helper routine
Code_1B88           lbsr      Code_3F3A ; call the referenced helper routine
                    cmpb      #$05      ; compare against the limit and set condition flags
                    beq       Code_1BD5 ; branch when the compared values are equal
                    cmpb      #$0D      ; compare against the limit and set condition flags
                    beq       Code_1BB8 ; branch when the compared values are equal
                    cmpb      #$AF      ; compare against the limit and set condition flags
                    bne       Code_1B9B ; branch when the compared values differ
                    lda       #$05      ; load the value needed by the following operation
                    bra       Code_1BD5 ; continue at the selected control-flow target
Code_1B9B           cmpb      #$B4      ; compare against the limit and set condition flags
                    bne       Code_1BA8 ; branch when the compared values differ
                    lbsr      Code_2437 ; call the referenced helper routine
                    beq       Code_1B88 ; branch when the compared values are equal
                    lda       #$01      ; load the value needed by the following operation
                    bra       Code_1BD5 ; continue at the selected control-flow target
Code_1BA8           cmpb      #$B6      ; compare against the limit and set condition flags
                    bne       Code_1BB0 ; branch when the compared values differ
                    lda       #$03      ; load the value needed by the following operation
                    bra       Code_1BCF ; continue at the selected control-flow target
Code_1BB0           cmpb      #$B5      ; compare against the limit and set condition flags
                    bne       Code_1B88 ; branch when the compared values differ
                    lda       #$02      ; load the value needed by the following operation
                    bra       Code_1BCF ; continue at the selected control-flow target
Code_1BB8           cmpa      #$01      ; compare against the limit and set condition flags
                    bne       Code_1BC3 ; branch when the compared values differ
                    lbsr      Code_2437 ; call the referenced helper routine
                    beq       Code_1B88 ; branch when the compared values are equal
                    bra       Code_1BD5 ; continue at the selected control-flow target
Code_1BC3           cmpa      #$00      ; compare against the limit and set condition flags
                    beq       Code_1BCF ; branch when the compared values are equal
                    cmpa      #$03      ; compare against the limit and set condition flags
                    beq       Code_1BCF ; branch when the compared values are equal
                    cmpa      #$02      ; compare against the limit and set condition flags
                    bne       Code_1BD5 ; branch when the compared values differ
Code_1BCF           ldx       Addr_000C ; load the value needed by the following operation
                    cmpx      Addr_0006 ; compare against the limit and set condition flags
                    beq       Code_1B88 ; branch when the compared values are equal
Code_1BD5           lbsr      Code_1B06 ; call the referenced helper routine
                    rts                 ; return to the caller
Data_1BD9           fcc       "("                            ; embedded text or resource bytes
                    fcb       $00,$01,$09,$07,$00,$AA ; table, bitmap, or initialized data bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
Data_1BE1           fcb       $00,$00,$05,$07,$03,$00 ; table, bitmap, or initialized data bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
Code_1BE8           lda       #$08      ; load the value needed by the following operation
                    leax      >Data_1BD9,PCR ; form the referenced address without reading memory
                    lbsr      Code_1AED ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    leax      >Data_1BE1,PCR ; form the referenced address without reading memory
                    lbsr      Code_3E2A ; call the referenced helper routine
Code_1BF9           lbsr      Code_3F3A ; call the referenced helper routine
                    cmpb      #$0D      ; compare against the limit and set condition flags
                    beq       Code_1C12 ; branch when the compared values are equal
                    cmpb      #$05      ; compare against the limit and set condition flags
                    beq       Code_1C12 ; branch when the compared values are equal
                    cmpb      #$AF      ; compare against the limit and set condition flags
                    bne       Code_1C0C ; branch when the compared values differ
                    lda       #$02      ; load the value needed by the following operation
                    bra       Code_1C12 ; continue at the selected control-flow target
Code_1C0C           cmpb      #$B7      ; compare against the limit and set condition flags
                    bne       Code_1BF9 ; branch when the compared values differ
                    lda       #$01      ; load the value needed by the following operation
Code_1C12           lbsr      Code_1B06 ; call the referenced helper routine
                    rts                 ; return to the caller
Data_1C16           fcc       "("                            ; embedded text or resource bytes
                    fcb       $05,$01,$0A,$07,$00,$AA ; table, bitmap, or initialized data bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
Data_1C1E           fcb       $00,$00,$05,$08,$03,$00 ; table, bitmap, or initialized data bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
Code_1C25           lda       #$09      ; load the value needed by the following operation
                    leax      >Data_1C16,PCR ; form the referenced address without reading memory
                    lbsr      Code_1AED ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    leax      >Data_1C1E,PCR ; form the referenced address without reading memory
                    lbsr      Code_3E2A ; call the referenced helper routine
Code_1C36           lbsr      Code_3F3A ; call the referenced helper routine
                    cmpb      #$0D      ; compare against the limit and set condition flags
                    beq       Code_1C57 ; branch when the compared values are equal
                    cmpb      #$05      ; compare against the limit and set condition flags
                    beq       Code_1C57 ; branch when the compared values are equal
                    cmpb      #$AF      ; compare against the limit and set condition flags
                    bne       Code_1C49 ; branch when the compared values differ
                    lda       #$02      ; load the value needed by the following operation
                    bra       Code_1C57 ; continue at the selected control-flow target
Code_1C49           cmpb      #$B5      ; compare against the limit and set condition flags
                    bne       Code_1C51 ; branch when the compared values differ
                    lda       #$00      ; load the value needed by the following operation
                    bra       Code_1C57 ; continue at the selected control-flow target
Code_1C51           cmpb      #$B2      ; compare against the limit and set condition flags
                    bne       Code_1C36 ; branch when the compared values differ
                    lda       #$01      ; load the value needed by the following operation
Code_1C57           lbsr      Code_1B06 ; call the referenced helper routine
                    rts                 ; return to the caller
Data_1C5B           fcc       "("                            ; embedded text or resource bytes
                    fcb       $00,$01,$0E,$08,$00,$AA ; table, bitmap, or initialized data bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
Data_1C63           fcb       $00,$00,$06,$0C,$04,$00 ; table, bitmap, or initialized data bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
Code_1C6A           pshs      X         ; preserve the listed registers on the stack
                    lbsr      Code_2AE3 ; call the referenced helper routine
                    lda       #$04      ; load the value needed by the following operation
                    leax      >Data_1C5B,PCR ; form the referenced address without reading memory
                    lbsr      Code_1AED ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    leax      >Data_1C63,PCR ; form the referenced address without reading memory
                    lbsr      Code_3E2A ; call the referenced helper routine
Code_1C80           lbsr      Code_3F3A ; call the referenced helper routine
                    cmpb      #$05      ; compare against the limit and set condition flags
                    beq       Code_1CA4 ; branch when the compared values are equal
                    cmpb      #$0D      ; compare against the limit and set condition flags
                    beq       Code_1C98 ; branch when the compared values are equal
                    cmpb      #$AF      ; compare against the limit and set condition flags
                    bne       Code_1C93 ; branch when the compared values differ
                    lda       #$03      ; load the value needed by the following operation
                    bra       Code_1CA4 ; continue at the selected control-flow target
Code_1C93           cmpb      #$B5      ; compare against the limit and set condition flags
                    bne       Code_1C80 ; branch when the compared values differ
                    clra                ; clear the selected byte or register
Code_1C98           cmpa      #$00      ; compare against the limit and set condition flags
                    bne       Code_1CA4 ; branch when the compared values differ
                    leax      $12E1,U   ; form the referenced address without reading memory
                    tst       $05,X     ; set condition flags from the current value
                    bmi       Code_1C80 ; branch while the tested value is negative
Code_1CA4           lbsr      Code_1B06 ; call the referenced helper routine
                    puls      PC,X      ; restore the listed registers from the stack
Data_1CA9           fcc       "("                            ; embedded text or resource bytes
                    fcb       $00,$01,$09,$07,$00,$AA ; table, bitmap, or initialized data bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
Data_1CB1           fcb       $00,$00,$05,$07,$03,$00 ; table, bitmap, or initialized data bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
Code_1CB8           lbsr      Code_2AF5 ; call the referenced helper routine
                    lda       #$06      ; load the value needed by the following operation
                    leax      >Data_1CA9,PCR ; form the referenced address without reading memory
                    lbsr      Code_1AED ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    leax      >Data_1CB1,PCR ; form the referenced address without reading memory
                    lbsr      Code_3E2A ; call the referenced helper routine
Code_1CCC           lbsr      Code_3F3A ; call the referenced helper routine
                    cmpb      #$0D      ; compare against the limit and set condition flags
                    beq       Code_1CE5 ; branch when the compared values are equal
                    cmpb      #$05      ; compare against the limit and set condition flags
                    beq       Code_1CE5 ; branch when the compared values are equal
                    cmpb      #$AF      ; compare against the limit and set condition flags
                    bne       Code_1CDF ; branch when the compared values differ
                    lda       #$02      ; load the value needed by the following operation
                    bra       Code_1CE5 ; continue at the selected control-flow target
Code_1CDF           cmpb      #$B4      ; compare against the limit and set condition flags
                    bne       Code_1CCC ; branch when the compared values differ
                    lda       #$00      ; load the value needed by the following operation
Code_1CE5           lbsr      Code_1B06 ; call the referenced helper routine
                    rts                 ; return to the caller
Data_1CE9           fcc       "("                            ; embedded text or resource bytes
                    fcb       $00,$01,$0B,$0C,$00,$AA ; table, bitmap, or initialized data bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
Data_1CF1           fcb       $00,$00,$0A,$09,$08,$00 ; table, bitmap, or initialized data bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
Code_1CF8           lda       #$0B      ; load the value needed by the following operation
                    leax      >Data_1CE9,PCR ; form the referenced address without reading memory
                    lbsr      Code_1AED ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    leax      >Data_1CF1,PCR ; form the referenced address without reading memory
                    lbsr      Code_3E2A ; call the referenced helper routine
Code_1D09           lbsr      Code_3F3A ; call the referenced helper routine
                    cmpb      #$0D      ; compare against the limit and set condition flags
                    beq       Code_1D42 ; branch when the compared values are equal
                    cmpb      #$05      ; compare against the limit and set condition flags
                    beq       Code_1D42 ; branch when the compared values are equal
                    cmpb      #$AF      ; compare against the limit and set condition flags
                    bne       Code_1D1C ; branch when the compared values differ
                    lda       #$07      ; load the value needed by the following operation
                    bra       Code_1D42 ; continue at the selected control-flow target
Code_1D1C           cmpb      #$B1      ; compare against the limit and set condition flags
                    bne       Code_1D24 ; branch when the compared values differ
                    lda       #$00      ; load the value needed by the following operation
                    bra       Code_1D42 ; continue at the selected control-flow target
Code_1D24           cmpb      #$B2      ; compare against the limit and set condition flags
                    bne       Code_1D2C ; branch when the compared values differ
                    lda       #$01      ; load the value needed by the following operation
                    bra       Code_1D42 ; continue at the selected control-flow target
Code_1D2C           cmpb      #$B3      ; compare against the limit and set condition flags
                    bne       Code_1D34 ; branch when the compared values differ
                    lda       #$02      ; load the value needed by the following operation
                    bra       Code_1D42 ; continue at the selected control-flow target
Code_1D34           cmpb      #$B7      ; compare against the limit and set condition flags
                    bne       Code_1D3C ; branch when the compared values differ
                    lda       #$03      ; load the value needed by the following operation
                    bra       Code_1D42 ; continue at the selected control-flow target
Code_1D3C           cmpb      #$B6      ; compare against the limit and set condition flags
                    bne       Code_1D09 ; branch when the compared values differ
                    lda       #$05      ; load the value needed by the following operation
Code_1D42           lbsr      Code_1B06 ; call the referenced helper routine
                    rts                 ; return to the caller
Data_1D46           fcc       "DMHELP"                       ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "DMCARDS "                     ; embedded text or resource bytes
Data_1D55           fcb       $00,$00,$0D ; table, bitmap, or initialized data bytes
Data_1D58           fcc       "("                            ; embedded text or resource bytes
                    fcb       $05,$03,$1E,$11,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $18       ; table, bitmap, or initialized data bytes
Code_1D60           pshs      Y,X,A     ; preserve the listed registers on the stack
                    lda       Data_0039 ; load the value needed by the following operation
                    sta       >Data_1D55,PCR ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1B       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       ":"                            ; embedded text or resource bytes
                    leax      >Data_1D58,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    ldx       #Addr_FFF8 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "O"                            ; embedded text or resource bytes
                    leas      -$06,S    ; form the referenced address without reading memory
                    pshs      U         ; preserve the listed registers on the stack
                    lbsr      Code_1E67 ; call the referenced helper routine
                    leax      >Data_1D46,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "V"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "P"                            ; embedded text or resource bytes
                    puls      U         ; restore the listed registers from the stack
                    lda       #$01      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    lbsr      Code_1A8D ; call the referenced helper routine
                    lbsr      Code_1E86 ; call the referenced helper routine
                    leas      $06,S     ; form the referenced address without reading memory
                    lbsr      Code_3DA9 ; call the referenced helper routine
                    lda       Data_0038 ; load the value needed by the following operation
                    sta       Data_0039 ; save the current value in working storage
                    puls      PC,Y,X,A  ; restore the listed registers from the stack
Data_1DB3           fcc       " PLEASE WAIT WHILE   "        ; embedded text or resource bytes
                    fcc       "I SORT THE FILE"              ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1DD8           fcc       "("                            ; embedded text or resource bytes
                    fcb       $09,$08,$15,$04,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $18       ; table, bitmap, or initialized data bytes
Code_1DE0           leax      >Data_1DD8,PCR ; form the referenced address without reading memory
                    leay      >Data_1DB3,PCR ; form the referenced address without reading memory
                    lbra      Code_140C ; continue at the distant control-flow target
Data_1DEB           fcc       "    PLEASE WAIT WHILE"        ; embedded text or resource bytes
                    fcc       "      I DELETE THE DA"        ; embedded text or resource bytes
                    fcc       "TA FIELDS"                    ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1E1F           fcc       "("                            ; embedded text or resource bytes
                    fcb       $06,$07,$1C,$04,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $18       ; table, bitmap, or initialized data bytes
Code_1E27           leax      >Data_1E1F,PCR ; form the referenced address without reading memory
                    leay      >Data_1DEB,PCR ; form the referenced address without reading memory
                    lbra      Code_140C ; continue at the distant control-flow target
Code_1E32           lda       #$FF      ; load the value needed by the following operation
                    bra       Code_1E38 ; continue at the selected control-flow target
Code_1E36           lda       #$01      ; load the value needed by the following operation
Code_1E38           sta       Data_19AE,PCR ; save the current value in working storage
                    sta       Data_19C1,PCR ; save the current value in working storage
                    sta       Data_19E1,PCR ; save the current value in working storage
                    sta       Data_19D6,PCR ; save the current value in working storage
                    rts                 ; return to the caller
Code_1E49           leax      $12E1,U   ; form the referenced address without reading memory
                    tst       $05,X     ; set condition flags from the current value
                    bmi       Code_1E55 ; branch while the tested value is negative
                    lda       #$01      ; load the value needed by the following operation
                    bra       Code_1E57 ; continue at the selected control-flow target
Code_1E55           lda       #$FF      ; load the value needed by the following operation
Code_1E57           sta       Data_196F,PCR ; save the current value in working storage
                    rts                 ; return to the caller
Code_1E5C           lda       #$01      ; load the value needed by the following operation
                    bra       Code_1E62 ; continue at the selected control-flow target
Code_1E60           lda       #$FF      ; load the value needed by the following operation
Code_1E62           sta       Data_19CB,PCR ; save the current value in working storage
                    rts                 ; return to the caller
Code_1E67           lda       Data_19D6,PCR ; load the value needed by the following operation
                    ldb       Data_19EA,PCR ; load the value needed by the following operation
                    std       $04,S     ; save the current value in working storage
                    lda       Data_19CB,PCR ; load the value needed by the following operation
                    ldb       Data_19E1,PCR ; load the value needed by the following operation
                    std       $06,S     ; save the current value in working storage
                    lda       Data_19AE,PCR ; load the value needed by the following operation
                    ldb       Data_19C1,PCR ; load the value needed by the following operation
                    std       $08,S     ; save the current value in working storage
                    rts                 ; return to the caller
Code_1E86           ldd       $02,S     ; load the value needed by the following operation
                    sta       Data_19D6,PCR ; save the current value in working storage
                    stb       Data_19EA,PCR ; save the current value in working storage
                    ldd       $04,S     ; load the value needed by the following operation
                    sta       Data_19CB,PCR ; save the current value in working storage
                    stb       Data_19E1,PCR ; save the current value in working storage
                    ldd       $06,S     ; load the value needed by the following operation
                    sta       Data_19AE,PCR ; save the current value in working storage
                    stb       Data_19C1,PCR ; save the current value in working storage
                    rts                 ; return to the caller
Code_1EA5           lda       #$03      ; load the value needed by the following operation
                    ldb       #$03      ; load the value needed by the following operation
                    os9       I$Create  ; request the named OS-9 service
                    lbcs      Code_1FB5 ; take the distant branch when carry reports an error
                    sta       Addr_0008 ; save the current value in working storage
                    rts                 ; return to the caller
Code_1EB3           lda       #$03      ; load the value needed by the following operation
                    os9       I$Open    ; request the named OS-9 service
                    bcs       Code_1EBC ; branch when carry reports an unsigned underflow or error
                    sta       Addr_0008 ; save the current value in working storage
Code_1EBC           rts                 ; return to the caller
Code_1EBD           lda       Addr_0008 ; load the value needed by the following operation
                    os9       I$Close   ; request the named OS-9 service
                    rts                 ; return to the caller
Code_1EC3           lda       Addr_0008 ; load the value needed by the following operation
                    os9       I$Read    ; request the named OS-9 service
                    lbcs      Code_1FB5 ; take the distant branch when carry reports an error
                    rts                 ; return to the caller
Code_1ECD           lda       Addr_0008 ; load the value needed by the following operation
                    os9       I$Write   ; request the named OS-9 service
                    bcc       Code_1EDD ; branch when carry is clear
                    cmpb      #$F8      ; compare against the limit and set condition flags
                    lbeq      Code_2009 ; take the distant branch when values are equal
                    lbra      Code_1FB5 ; continue at the distant control-flow target
Code_1EDD           rts                 ; return to the caller
Code_1EDE           lda       Addr_0008 ; load the value needed by the following operation
                    os9       I$Write   ; request the named OS-9 service
                    bcc       Code_1EEE ; branch when carry is clear
                    cmpb      #$F8      ; compare against the limit and set condition flags
                    lbne      Code_1FB5 ; take the distant branch when values differ
                    lbra      Code_202C ; continue at the distant control-flow target
Code_1EEE           rts                 ; return to the caller
Code_1EEF           lda       Addr_0008 ; load the value needed by the following operation
                    os9       I$Write   ; request the named OS-9 service
                    lbcs      Code_1FB5 ; take the distant branch when carry reports an error
                    rts                 ; return to the caller
Code_1EF9           lda       Addr_0008 ; load the value needed by the following operation
                    os9       I$Seek    ; request the named OS-9 service
                    lbcs      Code_1FB5 ; take the distant branch when carry reports an error
                    rts                 ; return to the caller
Data_1F03           fcc       "   Disk Drive Error  "        ; embedded text or resource bytes
                    fcc       "    Or Write Protecte"        ; embedded text or resource bytes
                    fcc       "d"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1F2F           fcc       "       disk full"             ; embedded text or resource bytes
                    fcb       $0A,$0D,$00 ; table, bitmap, or initialized data bytes
Data_1F42           fcc       "   Disk is n"                 ; embedded text or resource bytes
Data_1F4E           fcc       "ow full"                      ; embedded text or resource bytes
                    fcb       $0A,$0D,$00 ; table, bitmap, or initialized data bytes
Data_1F58           fcc       "   Insufficient disk "        ; embedded text or resource bytes
                    fcc       "          space"              ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1F7D           fcc       "   Incompatible file"         ; embedded text or resource bytes
                    fcb       $0A,$0D,$00 ; table, bitmap, or initialized data bytes
Data_1F94           fcb       $0A,$0D   ; table, bitmap, or initialized data bytes
                    fcc       " Press Any Key To Exi"        ; embedded text or resource bytes
                    fcc       "t"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1FAD           fcc       "("                            ; embedded text or resource bytes
                    fcb       $07,$09,$19,$05,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $0C       ; table, bitmap, or initialized data bytes
Code_1FB5           cmpb      #$48      ; compare against the limit and set condition flags
                    beq       Code_1FBF ; branch when the compared values are equal
                    leay      Data_1F03,PCR ; form the referenced address without reading memory
                    bra       Code_1FC3 ; continue at the selected control-flow target
Code_1FBF           leay      Data_1F2F,PCR ; form the referenced address without reading memory
Code_1FC3           bsr       Code_1FC8 ; call the referenced helper routine
                    lbra      Code_0558 ; continue at the distant control-flow target
Code_1FC8           leax      >Data_1FAD,PCR ; form the referenced address without reading memory
                    lbsr      Code_1424 ; call the referenced helper routine
                    leax      >Data_1F94,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1C       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_1FDD           leay      >Data_1F7D,PCR ; form the referenced address without reading memory
                    bra       Code_1FC3 ; continue at the selected control-flow target
Code_1FE3           lbsr      Code_0572 ; call the referenced helper routine
                    leax      $088B,U   ; form the referenced address without reading memory
                    os9       I$Delete  ; request the named OS-9 service
                    rts                 ; return to the caller
Code_1FEE           leay      Data_1F42,PCR ; form the referenced address without reading memory
                    bsr       Code_1FC8 ; call the referenced helper routine
                    lda       #$03      ; load the value needed by the following operation
                    pshs      A         ; preserve the listed registers on the stack
Code_1FF8           bsr       Code_1FE3 ; call the referenced helper routine
                    bcc       Code_2005 ; branch when carry is clear
                    dec       ,S        ; decrement the selected counter
                    bne       Code_1FF8 ; branch when the compared values differ
Code_2000           leas      $01,S     ; form the referenced address without reading memory
                    lda       #$01      ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_2005           leas      $01,S     ; form the referenced address without reading memory
                    clra                ; clear the selected byte or register
                    rts                 ; return to the caller
Code_2009           pshs      X         ; preserve the listed registers on the stack
                    bsr       Code_1FEE ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    lbne      Code_1FB5 ; take the distant branch when values differ
                    leax      >$0009,U  ; form the referenced address without reading memory
                    lbsr      Code_233E ; call the referenced helper routine
                    puls      Y         ; restore the listed registers from the stack
                    lbsr      Code_21E9 ; call the referenced helper routine
                    lbsr      Code_1EEF ; call the referenced helper routine
                    tfr       Y,D       ; copy the source register into the destination register
                    lbsr      Code_2331 ; call the referenced helper routine
                    lbsr      Code_22C6 ; call the referenced helper routine
                    lbra      Code_0558 ; continue at the distant control-flow target
Code_202C           ldd       #DeskMateService ; load the value needed by the following operation
                    std       $1371,U   ; save the current value in working storage
                    bsr       Code_1FEE ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    lbne      Code_1FB5 ; take the distant branch when values differ
                    lbsr      Code_22AD ; call the referenced helper routine
                    leax      >$0064,U  ; form the referenced address without reading memory
                    lbsr      Code_1EEF ; call the referenced helper routine
                    ldy       #Addr_0022 ; load the value needed by the following operation
                    leax      $1351,U   ; form the referenced address without reading memory
                    lbsr      Code_1EEF ; call the referenced helper routine
                    lbra      Code_0558 ; continue at the distant control-flow target
Code_2052           bsr       Code_2079 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_2078 ; branch when the compared values are equal
                    cmpa      #$02      ; compare against the limit and set condition flags
                    beq       Code_206A ; branch when the compared values are equal
                    cmpb      #$DA      ; compare against the limit and set condition flags
                    bne       Code_2064 ; branch when the compared values differ
                    lbsr      Code_1FE3 ; call the referenced helper routine
                    bcc       Code_2052 ; branch when carry is clear
Code_2064           leay      Data_1F03,PCR ; form the referenced address without reading memory
                    bra       Code_206E ; continue at the selected control-flow target
Code_206A           leay      Data_1F58,PCR ; form the referenced address without reading memory
Code_206E           lbsr      Code_1FC8 ; call the referenced helper routine
                    lbsr      Code_1FE3 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "W"                            ; embedded text or resource bytes
Code_2078           rts                 ; return to the caller
Code_2079           lbsr      Code_0572 ; call the referenced helper routine
                    leax      $088B,U   ; form the referenced address without reading memory
                    ldd       #Code_0303 ; load the value needed by the following operation
                    os9       I$Create  ; request the named OS-9 service
                    bcs       Code_209E ; branch when carry reports an unsigned underflow or error
                    sta       Data_003C ; save the current value in working storage
                    leax      $1373,U   ; form the referenced address without reading memory
                    ldy       #Code_03B6 ; load the value needed by the following operation
                    os9       I$Write   ; request the named OS-9 service
                    bcs       Code_209E ; branch when carry reports an unsigned underflow or error
                    lda       Data_003C ; load the value needed by the following operation
                    os9       I$Close   ; request the named OS-9 service
                    clra                ; clear the selected byte or register
                    rts                 ; return to the caller
Code_209E           cmpb      #$F8      ; compare against the limit and set condition flags
                    beq       Code_20A5 ; branch when the compared values are equal
                    lda       #$01      ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_20A5           lda       #$02      ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_20A8           ldd       Addr_0002 ; load the value needed by the following operation
                    subd      DeskMateService ; subtract the operand from the running value
                    subd      #Addr_0004 ; subtract the operand from the running value
                    bne       Code_20B4 ; branch when the compared values differ
                    ldd       #Addr_0004 ; load the value needed by the following operation
Code_20B4           lsra                ; shift right and expose the low bit through carry
                    rorb                ; rotate right through carry
                    bitb      #$02      ; test the selected flag bits without changing the value
                    beq       Code_20BD ; branch when the compared values are equal
                    addd      #Addr_0002 ; add the operand to the running value
Code_20BD           addd      DeskMateService ; add the operand to the running value
                    std       Addr_0004 ; save the current value in working storage
                    rts                 ; return to the caller
Code_20C2           pshs      A         ; preserve the listed registers on the stack
Code_20C4           lda       ,X+       ; fetch the next value and advance the source pointer
                    bpl       Code_20C4 ; branch while the tested value is nonnegative
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    beq       Code_20D5 ; branch when the compared values are equal
                    anda      #$7F      ; mask off unwanted bits
                    cmpa      ,S        ; compare against the limit and set condition flags
                    bne       Code_20C4 ; branch when the compared values differ
                    clrb                ; clear the selected byte or register
                    puls      PC,A      ; restore the listed registers from the stack
Code_20D5           ldb       #$01      ; load the value needed by the following operation
                    puls      PC,A      ; restore the listed registers from the stack
Code_20D9           pshs      A         ; preserve the listed registers on the stack
                    tfr       B,A       ; copy the source register into the destination register
                    bsr       Code_20E3 ; call the referenced helper routine
                    tfr       A,B       ; copy the source register into the destination register
                    puls      A         ; restore the listed registers from the stack
Code_20E3           cmpa      #$61      ; compare against the limit and set condition flags
                    blt       Code_20ED ; branch when the signed value is below the limit
                    cmpa      #$7A      ; compare against the limit and set condition flags
                    bgt       Code_20ED ; branch when the signed value is above the limit
                    anda      #$5F      ; mask off unwanted bits
Code_20ED           rts                 ; return to the caller
Code_20EE           lda       ,X+       ; fetch the next value and advance the source pointer
                    lbsr      Code_05C8 ; call the referenced helper routine
                    bmi       Code_2108 ; branch while the tested value is negative
                    ldb       ,Y+       ; fetch the next value and advance the source pointer
                    lbsr      Code_05CC ; call the referenced helper routine
                    bmi       Code_2112 ; branch while the tested value is negative
                    bsr       Code_20D9 ; call the referenced helper routine
                    pshs      B         ; preserve the listed registers on the stack
                    cmpa      ,S+       ; compare against the limit and set condition flags
                    beq       Code_20EE ; branch when the compared values are equal
                    bgt       Code_2112 ; branch when the signed value is above the limit
                    bra       Code_210F ; continue at the selected control-flow target
Code_2108           ldb       ,Y+       ; fetch the next value and advance the source pointer
                    lbsr      Code_05CC ; call the referenced helper routine
                    bmi       Code_2115 ; branch while the tested value is negative
Code_210F           lda       #$02      ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_2112           lda       #$01      ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_2115           clra                ; clear the selected byte or register
                    rts                 ; return to the caller
Code_2117           bsr       Code_2126 ; call the referenced helper routine
                    pshs      X         ; preserve the listed registers on the stack
                    tfr       Y,X       ; copy the source register into the destination register
                    bsr       Code_2126 ; call the referenced helper routine
                    tfr       X,Y       ; copy the source register into the destination register
                    puls      X         ; restore the listed registers from the stack
                    bsr       Code_20EE ; call the referenced helper routine
                    rts                 ; return to the caller
Code_2126           pshs      X         ; preserve the listed registers on the stack
                    lbsr      Code_20C2 ; call the referenced helper routine
                    tstb                ; set condition flags from the current value
                    beq       Code_2132 ; branch when the compared values are equal
                    puls      X         ; restore the listed registers from the stack
                    bra       Code_2134 ; continue at the selected control-flow target
Code_2132           leas      $02,S     ; form the referenced address without reading memory
Code_2134           rts                 ; return to the caller
Code_2135           leax      $1351,U   ; form the referenced address without reading memory
                    ldb       #$05      ; load the value needed by the following operation
Code_213B           tstb                ; set condition flags from the current value
                    beq       Code_2158 ; branch when the compared values are equal
                    decb                ; decrement the selected counter
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    beq       Code_2158 ; branch when the compared values are equal
                    pshs      X,B       ; preserve the listed registers on the stack
                    leax      $088B,U   ; form the referenced address without reading memory
                    leay      $0BFD,U   ; form the referenced address without reading memory
                    lbsr      Code_2117 ; call the referenced helper routine
                    puls      X,B       ; restore the listed registers from the stack
                    tsta                ; set condition flags from the current value
                    beq       Code_213B ; branch when the compared values are equal
                    rts                 ; return to the caller
Code_2158           clra                ; clear the selected byte or register
                    rts                 ; return to the caller
Code_215A           ldd       Addr_0006 ; load the value needed by the following operation
                    std       Addr_0002 ; save the current value in working storage
                    leax      >$0066,U  ; form the referenced address without reading memory
                    tfr       X,D       ; copy the source register into the destination register
                    addd      #Addr_0003 ; add the operand to the running value
                    std       DeskMateService ; save the current value in working storage
                    cmpd      Addr_0002 ; compare against the limit and set condition flags
                    beq       Code_21C3 ; branch when the compared values are equal
                    lda       $1351,U   ; load the value needed by the following operation
                    leax      $088B,U   ; form the referenced address without reading memory
                    lbsr      Code_20C2 ; call the referenced helper routine
                    tstb                ; set condition flags from the current value
                    beq       Code_2180 ; branch when the compared values are equal
                    lda       #$20      ; load the value needed by the following operation
                    bra       Code_2182 ; continue at the selected control-flow target
Code_2180           lda       ,X        ; load the value needed by the following operation
Code_2182           lbsr      Code_20E3 ; call the referenced helper routine
                    sta       Addr_000E ; save the current value in working storage
Code_2187           lbsr      Code_20A8 ; call the referenced helper routine
                    tfr       D,X       ; copy the source register into the destination register
                    cmpd      Addr_0002 ; compare against the limit and set condition flags
                    beq       Code_21B2 ; branch when the compared values are equal
                    lda       Addr_000E ; load the value needed by the following operation
                    cmpa      ,X+       ; compare against the limit and set condition flags
                    bgt       Code_21AC ; branch when the signed value is above the limit
                    blt       Code_21A6 ; branch when the signed value is below the limit
                    lbsr      Code_21C6 ; call the referenced helper routine
                    lbsr      Code_2135 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_21C5 ; branch when the compared values are equal
                    cmpa      #$01      ; compare against the limit and set condition flags
                    beq       Code_21AC ; branch when the compared values are equal
Code_21A6           ldd       Addr_0004 ; load the value needed by the following operation
                    std       Addr_0002 ; save the current value in working storage
                    bra       Code_2187 ; continue at the selected control-flow target
Code_21AC           ldd       Addr_0004 ; load the value needed by the following operation
                    std       DeskMateService ; save the current value in working storage
                    bra       Code_2187 ; continue at the selected control-flow target
Code_21B2           leax      -$03,X    ; form the referenced address without reading memory
                    lbsr      Code_21C6 ; call the referenced helper routine
                    lbsr      Code_2135 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_21C1 ; branch when the compared values are equal
                    cmpa      #$01      ; compare against the limit and set condition flags
                    beq       Code_21C5 ; branch when the compared values are equal
Code_21C1           ldd       DeskMateService ; load the value needed by the following operation
Code_21C3           std       Addr_0004 ; save the current value in working storage
Code_21C5           rts                 ; return to the caller
Code_21C6           leay      $0BFD,U   ; form the referenced address without reading memory
                    lbsr      Code_21CE ; call the referenced helper routine
                    rts                 ; return to the caller
Code_21CE           lbsr      Code_233E ; call the referenced helper routine
                    tfr       Y,X       ; copy the source register into the destination register
                    ldy       #Addr_0372 ; load the value needed by the following operation
                    lbsr      Code_1EC3 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_21DB           lbsr      Code_233E ; call the referenced helper routine
                    bsr       Code_21E9 ; call the referenced helper routine
                    lbsr      Code_1ECD ; call the referenced helper routine
                    tfr       Y,D       ; copy the source register into the destination register
                    lbsr      Code_2331 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_21E9           tfr       Y,X       ; copy the source register into the destination register
                    pshs      X         ; preserve the listed registers on the stack
                    ldy       #DeskMateService ; load the value needed by the following operation
Code_21F1           lda       ,X+       ; fetch the next value and advance the source pointer
                    leay      $01,Y     ; form the referenced address without reading memory
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    bne       Code_21F1 ; branch when the compared values differ
                    puls      X         ; restore the listed registers from the stack
                    rts                 ; return to the caller
Code_21FC           pshs      Y,X       ; preserve the listed registers on the stack
                    ldx       Addr_0006 ; load the value needed by the following operation
                    leay      $04,X     ; form the referenced address without reading memory
                    sty       Addr_0006 ; save the current value in working storage
Code_2205           cmpx      $02,S     ; compare against the limit and set condition flags
                    beq       Code_220F ; branch when the compared values are equal
                    lda       ,-X       ; load the value needed by the following operation
                    sta       ,-Y       ; save the current value in working storage
                    bra       Code_2205 ; continue at the selected control-flow target
Code_220F           lda       $1351,U   ; load the value needed by the following operation
                    leax      $088B,U   ; form the referenced address without reading memory
                    lbsr      Code_20C2 ; call the referenced helper routine
                    tstb                ; set condition flags from the current value
                    beq       Code_2221 ; branch when the compared values are equal
                    lda       #$20      ; load the value needed by the following operation
                    bra       Code_222A ; continue at the selected control-flow target
Code_2221           lda       ,X        ; load the value needed by the following operation
                    bpl       Code_2227 ; branch while the tested value is nonnegative
                    lda       #$20      ; load the value needed by the following operation
Code_2227           lbsr      Code_20E3 ; call the referenced helper routine
Code_222A           puls      Y,X       ; restore the listed registers from the stack
                    sty       Addr_000C ; save the current value in working storage
                    sta       ,Y+       ; store the value and advance the destination pointer
                    ldb       #$03      ; load the value needed by the following operation
Code_2233           lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,Y+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bne       Code_2233 ; branch when the compared values differ
                    rts                 ; return to the caller
Code_223B           ldx       Addr_0006 ; load the value needed by the following operation
                    pshs      X         ; preserve the listed registers on the stack
                    leax      $04,Y     ; form the referenced address without reading memory
Code_2241           cmpx      ,S        ; compare against the limit and set condition flags
                    bge       Code_224B ; branch when the signed value is at least the limit
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,Y+       ; store the value and advance the destination pointer
                    bra       Code_2241 ; continue at the selected control-flow target
Code_224B           sty       Addr_0006 ; save the current value in working storage
                    leas      $02,S     ; form the referenced address without reading memory
                    rts                 ; return to the caller
Code_2251           pshs      X         ; preserve the listed registers on the stack
                    lbsr      Code_215A ; call the referenced helper routine
                    ldy       Addr_0004 ; load the value needed by the following operation
                    leax      >$0009,U  ; form the referenced address without reading memory
                    lbsr      Code_21FC ; call the referenced helper routine
                    leax      >$0009,U  ; form the referenced address without reading memory
                    puls      Y         ; restore the listed registers from the stack
                    lbsr      Code_21DB ; call the referenced helper routine
                    rts                 ; return to the caller
Code_226A           tfr       Y,X       ; copy the source register into the destination register
                    lbsr      Code_233E ; call the referenced helper routine
                    lda       #$80      ; load the value needed by the following operation
                    sta       $0BFD,U   ; save the current value in working storage
                    leax      $0BFD,U   ; form the referenced address without reading memory
                    ldy       #Addr_0001 ; load the value needed by the following operation
                    lbsr      Code_1ECD ; call the referenced helper routine
                    rts                 ; return to the caller
Code_2281           lbsr      Code_1EA5 ; call the referenced helper routine
                    leax      >$0066,U  ; form the referenced address without reading memory
                    leax      $03,X     ; form the referenced address without reading memory
                    stx       Addr_0006 ; save the current value in working storage
                    stx       Addr_000C ; save the current value in working storage
                    leax      >$0009,U  ; form the referenced address without reading memory
                    clr       ,X+       ; clear the selected byte or register
                    clr       ,X+       ; clear the selected byte or register
                    lda       #$03      ; load the value needed by the following operation
                    sta       ,X        ; save the current value in working storage
                    leax      $136C,U   ; form the referenced address without reading memory
                    lda       #$05      ; load the value needed by the following operation
Code_22A0           clr       ,X+       ; clear the selected byte or register
                    deca                ; decrement the selected counter
                    bne       Code_22A0 ; branch when the compared values differ
                    ldd       #Code_0D80 ; load the value needed by the following operation
                    std       $136A,U   ; save the current value in working storage
                    rts                 ; return to the caller
Code_22AD           leax      >$0009,U  ; form the referenced address without reading memory
                    lbsr      Code_233E ; call the referenced helper routine
                    leax      >$0066,U  ; form the referenced address without reading memory
                    pshs      X         ; preserve the listed registers on the stack
                    ldd       Addr_0006 ; load the value needed by the following operation
                    subd      ,S++      ; subtract the operand from the running value
                    addd      #Addr_0002 ; add the operand to the running value
                    std       Data_0064 ; save the current value in working storage
                    tfr       D,Y       ; copy the source register into the destination register
                    rts                 ; return to the caller
Code_22C6           pshs      U         ; preserve the listed registers on the stack
                    ldx       #DeskMateService ; load the value needed by the following operation
                    ldu       #DeskMateService ; load the value needed by the following operation
                    lbsr      Code_1EF9 ; call the referenced helper routine
                    puls      U         ; restore the listed registers from the stack
                    leax      >$0009,U  ; form the referenced address without reading memory
                    ldy       #Addr_0003 ; load the value needed by the following operation
                    lbsr      Code_1EEF ; call the referenced helper routine
                    bsr       Code_22AD ; call the referenced helper routine
                    leax      >$0064,U  ; form the referenced address without reading memory
                    lbsr      Code_1EDE ; call the referenced helper routine
                    ldy       $1371,U   ; load the value needed by the following operation
                    bne       Code_22FB ; branch when the compared values differ
                    ldy       #Addr_0022 ; load the value needed by the following operation
                    leax      $1351,U   ; form the referenced address without reading memory
                    lbsr      Code_1EDE ; call the referenced helper routine
                    bra       Code_2318 ; continue at the selected control-flow target
Code_22FB           ldy       #DeskMateService ; load the value needed by the following operation
                    leax      $1373,U   ; form the referenced address without reading memory
Code_2303           leay      $01,Y     ; form the referenced address without reading memory
                    tst       ,X+       ; set condition flags from the current value
                    bpl       Code_2303 ; branch while the tested value is nonnegative
                    sty       $1371,U   ; save the current value in working storage
                    leay      $22,Y     ; form the referenced address without reading memory
                    leax      $1351,U   ; form the referenced address without reading memory
                    lbsr      Code_1EDE ; call the referenced helper routine
Code_2318           pshs      U         ; preserve the listed registers on the stack
                    ldx       #DeskMateService ; load the value needed by the following operation
                    ldu       #DeskMateService ; load the value needed by the following operation
                    lbsr      Code_1EF9 ; call the referenced helper routine
                    puls      U         ; restore the listed registers from the stack
                    leax      $0BFD,U   ; form the referenced address without reading memory
                    ldy       #Addr_0001 ; load the value needed by the following operation
                    lbsr      Code_1EC3 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_2331           addd      >$000A,U  ; add the operand to the running value
                    std       >$000A,U  ; save the current value in working storage
                    bcc       Code_233D ; branch when carry is clear
                    inc       Addr_0009 ; advance the selected counter
Code_233D           rts                 ; return to the caller
Code_233E           pshs      U         ; preserve the listed registers on the stack
                    pshs      D         ; preserve the listed registers on the stack
                    ldu       $01,X     ; load the value needed by the following operation
                    clra                ; clear the selected byte or register
                    ldb       ,X        ; load the value needed by the following operation
                    tfr       D,X       ; copy the source register into the destination register
                    puls      D         ; restore the listed registers from the stack
                    lbsr      Code_1EF9 ; call the referenced helper routine
                    puls      PC,U      ; restore the listed registers from the stack
Code_2350           pshs      U         ; preserve the listed registers on the stack
                    ldx       #DeskMateService ; load the value needed by the following operation
                    ldu       #DeskMateService ; load the value needed by the following operation
                    lbsr      Code_1EF9 ; call the referenced helper routine
                    puls      U         ; restore the listed registers from the stack
                    leax      >$0009,U  ; form the referenced address without reading memory
                    ldy       #Addr_0003 ; load the value needed by the following operation
                    lbsr      Code_1EC3 ; call the referenced helper routine
                    leax      >$0009,U  ; form the referenced address without reading memory
                    lbsr      Code_233E ; call the referenced helper routine
                    leax      >$0064,U  ; form the referenced address without reading memory
                    ldy       #Addr_0002 ; load the value needed by the following operation
                    lbsr      Code_1EC3 ; call the referenced helper routine
                    leax      >$0009,U  ; form the referenced address without reading memory
                    lbsr      Code_233E ; call the referenced helper routine
                    leax      >$0064,U  ; form the referenced address without reading memory
                    ldy       Data_0064 ; load the value needed by the following operation
                    lbsr      Code_1EC3 ; call the referenced helper routine
                    leax      $1351,U   ; form the referenced address without reading memory
                    ldy       #Addr_0022 ; load the value needed by the following operation
                    lbsr      Code_1EC3 ; call the referenced helper routine
                    lbsr      Code_0495 ; call the referenced helper routine
                    ldy       $1371,U   ; load the value needed by the following operation
                    beq       Code_23BC ; branch when the compared values are equal
                    leax      $1373,U   ; form the referenced address without reading memory
                    lbsr      Code_1EC3 ; call the referenced helper routine
                    leax      $1373,U   ; form the referenced address without reading memory
                    stx       Data_004D ; save the current value in working storage
                    stx       Data_0049 ; save the current value in working storage
Code_23AF           tst       ,X+       ; set condition flags from the current value
                    bpl       Code_23AF ; branch while the tested value is nonnegative
                    leax      -$01,X    ; form the referenced address without reading memory
                    stx       Data_004B ; save the current value in working storage
                    lbsr      Code_23F9 ; call the referenced helper routine
                    bra       Code_23BF ; continue at the selected control-flow target
Code_23BC           lbsr      Code_3767 ; call the referenced helper routine
Code_23BF           lbsr      Code_23C3 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_23C3           leax      >$0066,U  ; form the referenced address without reading memory
                    leay      $0519,U   ; form the referenced address without reading memory
                    lbsr      Code_21CE ; call the referenced helper routine
                    rts                 ; return to the caller
Code_23CF           leax      >$0009,U  ; form the referenced address without reading memory
                    leay      >$0066,U  ; form the referenced address without reading memory
                    ldb       #$03      ; load the value needed by the following operation
Code_23D9           lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,Y+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bne       Code_23D9 ; branch when the compared values differ
                    leax      >$0009,U  ; form the referenced address without reading memory
                    leay      $0519,U   ; form the referenced address without reading memory
                    lbsr      Code_21DB ; call the referenced helper routine
                    rts                 ; return to the caller
Code_23EC           pshs      X         ; preserve the listed registers on the stack
                    leax      >$0066,U  ; form the referenced address without reading memory
                    leax      $03,X     ; form the referenced address without reading memory
                    cmpx      Addr_0006 ; compare against the limit and set condition flags
                    puls      X         ; restore the listed registers from the stack
                    rts                 ; return to the caller
Code_23F9           leax      >$0066,U  ; form the referenced address without reading memory
                    leax      $03,X     ; form the referenced address without reading memory
                    stx       Addr_000C ; save the current value in working storage
                    rts                 ; return to the caller
Code_2402           ldx       Addr_0006 ; load the value needed by the following operation
                    leax      -$04,X    ; form the referenced address without reading memory
                    stx       Addr_000C ; save the current value in working storage
                    rts                 ; return to the caller
Code_2409           ldx       Addr_000C ; load the value needed by the following operation
                    leax      $04,X     ; form the referenced address without reading memory
                    cmpx      Addr_0006 ; compare against the limit and set condition flags
                    beq       Code_2415 ; branch when the compared values are equal
                    stx       Addr_000C ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    rts                 ; return to the caller
Code_2415           lda       #$01      ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_2418           leax      >$0066,U  ; form the referenced address without reading memory
                    leax      $03,X     ; form the referenced address without reading memory
                    pshs      X         ; preserve the listed registers on the stack
                    ldx       Addr_000C ; load the value needed by the following operation
                    cmpx      ,S++      ; compare against the limit and set condition flags
                    beq       Code_242C ; branch when the compared values are equal
                    leax      -$04,X    ; form the referenced address without reading memory
                    stx       Addr_000C ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    rts                 ; return to the caller
Code_242C           lda       #$01      ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_242F           leay      >$0066,U  ; form the referenced address without reading memory
                    lbsr      Code_226A ; call the referenced helper routine
                    rts                 ; return to the caller
Code_2437           pshs      X         ; preserve the listed registers on the stack
                    leax      >$0066,U  ; form the referenced address without reading memory
                    leax      $04B3,X   ; form the referenced address without reading memory
                    cmpx      Addr_0006 ; compare against the limit and set condition flags
                    puls      PC,X      ; restore the listed registers from the stack
Code_2445           lbsr      Code_1715 ; call the referenced helper routine
                    lbsr      Code_136B ; call the referenced helper routine
                    bsr       Code_2463 ; call the referenced helper routine
                    bcs       Code_2462 ; branch when carry reports an unsigned underflow or error
                    leax      $088B,U   ; form the referenced address without reading memory
                    lbsr      Code_2251 ; call the referenced helper routine
                    lbsr      Code_22C6 ; call the referenced helper routine
                    bsr       Code_2437 ; call the referenced helper routine
                    bne       Code_2460 ; branch when the compared values differ
                    lbsr      Code_1E60 ; call the referenced helper routine
Code_2460           andcc     #$FE      ; mask off unwanted bits
Code_2462           rts                 ; return to the caller
Code_2463           pshs      Y,X,D     ; preserve the listed registers on the stack
                    leax      $088B,U   ; form the referenced address without reading memory
Code_2469           lda       ,X+       ; fetch the next value and advance the source pointer
                    bpl       Code_2474 ; branch while the tested value is nonnegative
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    bne       Code_2469 ; branch when the compared values differ
                    comb                ; invert every bit in the selected value
                    bra       Code_2476 ; continue at the selected control-flow target
Code_2474           andcc     #$FE      ; mask off unwanted bits
Code_2476           puls      PC,Y,X,D  ; restore the listed registers from the stack
Code_2478           ldy       Addr_000C ; load the value needed by the following operation
                    leay      $01,Y     ; form the referenced address without reading memory
                    lbsr      Code_226A ; call the referenced helper routine
                    ldy       Addr_000C ; load the value needed by the following operation
                    lbsr      Code_223B ; call the referenced helper routine
                    lbsr      Code_22C6 ; call the referenced helper routine
                    ldx       Addr_000C ; load the value needed by the following operation
                    cmpx      Addr_0006 ; compare against the limit and set condition flags
                    bne       Code_2492 ; branch when the compared values differ
                    lbsr      Code_2418 ; call the referenced helper routine
Code_2492           lbsr      Code_1E5C ; call the referenced helper routine
                    rts                 ; return to the caller
Code_2496           ldx       Addr_000C ; load the value needed by the following operation
                    leax      $01,X     ; form the referenced address without reading memory
                    leay      $0BFD,U   ; form the referenced address without reading memory
                    lbsr      Code_21CE ; call the referenced helper routine
                    lbsr      Code_16E1 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_24A5           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    lda       Addr_000F ; load the value needed by the following operation
                    ldb       Addr_0010 ; load the value needed by the following operation
                    pshs      Y,X,D     ; preserve the listed registers on the stack
                    ldb       Data_0041 ; load the value needed by the following operation
                    subb      Addr_000F ; subtract the operand from the running value
                    clra                ; clear the selected byte or register
                    tfr       D,Y       ; copy the source register into the destination register
                    tfr       B,A       ; copy the source register into the destination register
                    ldb       #$40      ; load the value needed by the following operation
                    stb       Addr_0034 ; save the current value in working storage
                    bra       Code_24D6 ; continue at the selected control-flow target
Code_24BE           lda       #$40      ; load the value needed by the following operation
                    sta       Addr_0034 ; save the current value in working storage
                    bra       Code_24C6 ; continue at the selected control-flow target
Code_24C4           clr       Addr_0034 ; clear the selected byte or register
Code_24C6           lbsr      Code_2566 ; call the referenced helper routine
                    pshs      Y,X,D     ; preserve the listed registers on the stack
                    ldb       Data_0041 ; load the value needed by the following operation
                    subb      #$0E      ; subtract the operand from the running value
                    clra                ; clear the selected byte or register
                    tfr       D,Y       ; copy the source register into the destination register
                    tfr       B,A       ; copy the source register into the destination register
                    ldb       Addr_0034 ; load the value needed by the following operation
Code_24D6           lbsr      start     ;24D6: 17 DB 3B       '.. ; call the referenced helper routine
                    fcb       $22       ; private DeskMate service selector
                    leax      A,X       ; form the referenced address without reading memory
                    ldb       Data_0041 ; load the value needed by the following operation
                    subb      #$02      ; subtract the operand from the running value
                    clra                ; clear the selected byte or register
                    tfr       D,Y       ; copy the source register into the destination register
Code_24E3           tst       ,X        ; set condition flags from the current value
                    bmi       Code_2558 ; branch while the tested value is negative
                    leax      $03,X     ; form the referenced address without reading memory
                    inc       Addr_0010 ; advance the selected counter
                    lda       Addr_0010 ; load the value needed by the following operation
                    ldb       #$02      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    ldb       Addr_0034 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $22       ; private DeskMate service selector
                    ldb       Data_0041 ; load the value needed by the following operation
                    subb      #$02      ; subtract the operand from the running value
                    leax      B,X       ; form the referenced address without reading memory
                    bra       Code_24E3 ; continue at the selected control-flow target
Code_2501           tst       Addr_001C ; set condition flags from the current value
                    lbeq      Code_2581 ; take the distant branch when values are equal
                    tst       Addr_001E ; set condition flags from the current value
                    beq       Code_24C4 ; branch when the compared values are equal
                    bra       Code_2521 ; continue at the selected control-flow target
Code_250D           tst       Addr_001C ; set condition flags from the current value
                    lbeq      Code_257B ; take the distant branch when values are equal
                    tst       Addr_001E ; set condition flags from the current value
                    beq       Code_24BE ; branch when the compared values are equal
                    lda       #$8A      ; load the value needed by the following operation
                    sta       Addr_0034 ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "9"                            ; embedded text or resource bytes
                    bra       Code_2529 ; continue at the selected control-flow target
Code_2521           lda       #$81      ; load the value needed by the following operation
                    sta       Addr_0034 ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       ":"                            ; embedded text or resource bytes
Code_2529           bsr       Code_2566 ;2529: 8D 3B          '. ; call the referenced helper routine
                    pshs      Y,X,D     ; preserve the listed registers on the stack
Code_252D           lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bne       Code_2535 ; branch when the compared values differ
                    lda       Addr_0034 ; load the value needed by the following operation
Code_2535           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "C"                            ; embedded text or resource bytes
                    lda       Data_0041 ; load the value needed by the following operation
                    deca                ; decrement the selected counter
                    cmpa      Addr_000F ; compare against the limit and set condition flags
                    beq       Code_2544 ; branch when the compared values are equal
                    inc       Addr_000F ; advance the selected counter
                    bra       Code_2553 ; continue at the selected control-flow target
Code_2544           lda       ,X        ; load the value needed by the following operation
                    lbsr      Code_05C8 ; call the referenced helper routine
                    bmi       Code_2558 ; branch while the tested value is negative
                    lda       #$02      ; load the value needed by the following operation
                    sta       Addr_000F ; save the current value in working storage
                    inc       Addr_0010 ; advance the selected counter
                    leax      $03,X     ; form the referenced address without reading memory
Code_2553           lbsr      Code_098D ; call the referenced helper routine
                    bra       Code_252D ; continue at the selected control-flow target
Code_2558           lda       #$01      ; load the value needed by the following operation
                    sta       Addr_001C ; save the current value in working storage
                    puls      Y,X,D     ; restore the listed registers from the stack
Code_255E           stb       Addr_0010 ; save the current value in working storage
                    sta       Addr_000F ; save the current value in working storage
Code_2562           lbsr      Code_098D ; call the referenced helper routine
                    rts                 ; return to the caller
Code_2566           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    lbsr      Code_25AA ; call the referenced helper routine
                    leax      $01,X     ; form the referenced address without reading memory
                    leay      $01,Y     ; form the referenced address without reading memory
                    inc       Addr_000F ; advance the selected counter
                    lbsr      Code_098D ; call the referenced helper routine
                    lda       Addr_000F ; load the value needed by the following operation
                    ldb       Addr_0010 ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_257B           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "9"                            ; embedded text or resource bytes
                    bra       Code_2585 ; continue at the selected control-flow target
Code_2581           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       ":"                            ; embedded text or resource bytes
Code_2585           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    lbsr      Code_25AA ; call the referenced helper routine
                    leax      -$0D,X    ; form the referenced address without reading memory
                    leay      -$0D,Y    ; form the referenced address without reading memory
                    clr       Addr_000F ; clear the selected byte or register
                    lbsr      Code_098D ; call the referenced helper routine
                    pshs      X         ; preserve the listed registers on the stack
                    ldb       #$0C      ; load the value needed by the following operation
Code_2599           lda       ,X+       ; fetch the next value and advance the source pointer
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "B"                            ; embedded text or resource bytes
                    decb                ; decrement the selected counter
                    bne       Code_2599 ; branch when the compared values differ
                    clr       Addr_001C ; clear the selected byte or register
                    puls      X         ; restore the listed registers from the stack
                    clr       Addr_000F ; clear the selected byte or register
                    bra       Code_2562 ; continue at the selected control-flow target
Code_25AA           ldx       Data_0051 ; load the value needed by the following operation
                    lda       ,X        ; load the value needed by the following operation
                    sta       Addr_0010 ; save the current value in working storage
                    lda       #$0D      ; load the value needed by the following operation
                    sta       Addr_000F ; save the current value in working storage
                    ldy       $03,X     ; load the value needed by the following operation
                    ldx       $01,X     ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_25BA           bsr       Code_25C3 ; call the referenced helper routine
                    lbsr      Code_0F08 ; call the referenced helper routine
Code_25BF           lbsr      Code_250D ; call the referenced helper routine
                    rts                 ; return to the caller
Code_25C3           lbsr      Code_2501 ;25C3: 17 FF 3B       '.. ; call the referenced helper routine
Code_25C6           bsr       Code_25AA ; call the referenced helper routine
                    lbsr      Code_098D ; call the referenced helper routine
                    rts                 ; return to the caller
Code_25CC           bsr       Code_25C3 ; call the referenced helper routine
                    lbsr      Code_0EF5 ; call the referenced helper routine
                    bra       Code_25BF ; continue at the selected control-flow target
Code_25D3           bsr       Code_25C3 ; call the referenced helper routine
                    inc       Addr_001C ; advance the selected counter
                    bra       Code_25BF ; continue at the selected control-flow target
Code_25D9           bsr       Code_25C3 ; call the referenced helper routine
                    clr       Addr_001C ; clear the selected byte or register
                    bra       Code_25BF ; continue at the selected control-flow target
Code_25DF           tst       Addr_001C ; set condition flags from the current value
                    beq       Code_25D3 ; branch when the compared values are equal
                    lbsr      Code_0DB1 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_25F2 ; branch when the compared values are equal
                    lda       Addr_0015 ; load the value needed by the following operation
                    cmpa      Data_0042 ; compare against the limit and set condition flags
                    lbne      Code_0C74 ; take the distant branch when values differ
                    rts                 ; return to the caller
Code_25F2           bsr       Code_25D9 ; call the referenced helper routine
                    bra       Code_25BA ; continue at the selected control-flow target
Code_25F6           lbsr      Code_2501 ; call the referenced helper routine
Code_25F9           lbsr      Code_0DB1 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    bne       Code_25BF ; branch when the compared values differ
                    lbsr      Code_0F08 ; call the referenced helper routine
                    bra       Code_25F9 ; continue at the selected control-flow target
Code_2604           lbsr      Code_2501 ; call the referenced helper routine
                    bsr       Code_260B ; call the referenced helper routine
                    bra       Code_25BF ; continue at the selected control-flow target
Code_260B           leax      $12E1,U   ; form the referenced address without reading memory
                    stx       Data_0051 ; save the current value in working storage
                    bra       Code_25C6 ; continue at the selected control-flow target
Data_2613           fcb       $0E       ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $07,$07,$00,$0E ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $08,$08,$01,$FF,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$0F   ; table, bitmap, or initialized data bytes
Data_2622           fcc       "     Quit And Delete "        ; embedded text or resource bytes
                    fcc       "File      Return To F"        ; embedded text or resource bytes
                    fcc       "ormat"                        ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_2652           fcc       "("                            ; embedded text or resource bytes
                    fcb       $06,$06,$1C,$04,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $18       ; table, bitmap, or initialized data bytes
Code_265A           lbsr      Code_3DA9 ; call the referenced helper routine
                    leax      >Data_2652,PCR ; form the referenced address without reading memory
                    leay      >Data_2622,PCR ; form the referenced address without reading memory
                    bsr       Code_2669 ; call the referenced helper routine
                    bra       Code_267C ; continue at the selected control-flow target
Code_2669           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       ":"                            ; embedded text or resource bytes
                    tfr       Y,X       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_2678           tst       Addr_001C ; set condition flags from the current value
                    bne       Code_2681 ; branch when the compared values differ
Code_267C           lbsr      Code_2705 ; call the referenced helper routine
Code_267F           bsr       Code_26BB ; call the referenced helper routine
Code_2681           ldb       #$80      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    bne       Code_26A3 ; branch when the compared values differ
                    lbsr      Code_3A71 ; call the referenced helper routine
                    cmpb      #$01      ; compare against the limit and set condition flags
                    beq       Code_26CA ; branch when the compared values are equal
                    ldd       Addr_0013 ; load the value needed by the following operation
                    leax      Data_2613,PCR ; form the referenced address without reading memory
                    lbsr      Code_3A56 ; call the referenced helper routine
                    cmpb      #$00      ; compare against the limit and set condition flags
                    beq       Code_26B3 ; branch when the compared values are equal
                    cmpb      #$01      ; compare against the limit and set condition flags
                    beq       Code_2678 ; branch when the compared values are equal
                    bra       Code_2681 ; continue at the selected control-flow target
Code_26A3           cmpa      #$0D      ; compare against the limit and set condition flags
                    beq       Code_26D3 ; branch when the compared values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    beq       Code_26D7 ; branch when the compared values are equal
                    cmpa      #$0A      ; compare against the limit and set condition flags
                    beq       Code_2678 ; branch when the compared values are equal
                    cmpa      #$0C      ; compare against the limit and set condition flags
                    bne       Code_2681 ; branch when the compared values differ
Code_26B3           tst       Addr_001C ; set condition flags from the current value
                    beq       Code_2681 ; branch when the compared values are equal
                    bsr       Code_2712 ; call the referenced helper routine
                    bra       Code_267F ; continue at the selected control-flow target
Code_26BB           lda       #$36      ; load the value needed by the following operation
                    ldb       #$12      ; load the value needed by the following operation
                    bsr       Code_26C5 ; call the referenced helper routine
                    tfr       Y,X       ; copy the source register into the destination register
                    lda       #$41      ; load the value needed by the following operation
Code_26C5           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_26CA           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "E"                            ; embedded text or resource bytes
                    cmpx      #Data_00FF ; compare against the limit and set condition flags
                    beq       Code_26E7 ; branch when the compared values are equal
Code_26D3           tst       Addr_001C ; set condition flags from the current value
                    bne       Code_26E7 ; branch when the compared values differ
Code_26D7           lbsr      Code_1EBD ; call the referenced helper routine
                    lbsr      Code_056C ; call the referenced helper routine
                    leax      $088B,U   ; form the referenced address without reading memory
                    os9       I$Delete  ; request the named OS-9 service
                    lbra      Code_0561 ; continue at the distant control-flow target
Code_26E7           lda       #$01      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    clr       Addr_000F ; clear the selected byte or register
                    lda       #$02      ; load the value needed by the following operation
                    sta       Addr_0010 ; save the current value in working storage
                    lbsr      Code_098D ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       ":"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "@"                            ; embedded text or resource bytes
                    lbra      Code_06D6 ; continue at the distant control-flow target
Code_2705           leax      Data_00E8,PCR ; form the referenced address without reading memory
                    leay      Data_010B,PCR ; form the referenced address without reading memory
                    lda       #$01      ; load the value needed by the following operation
                    sta       Addr_001C ; save the current value in working storage
                    rts                 ; return to the caller
Code_2712           leax      Data_010B,PCR ; form the referenced address without reading memory
                    leay      Data_00E8,PCR ; form the referenced address without reading memory
                    clr       Addr_001C ; clear the selected byte or register
                    rts                 ; return to the caller
Data_271D           fcc       "("                            ; embedded text or resource bytes
                    fcb       $0B,$06,$11,$05,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $18       ; table, bitmap, or initialized data bytes
Data_2725           fcc       " Are You Sure? "              ; embedded text or resource bytes
                    fcb       $0A,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "    Yes    No"                ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_2744           fcb       $19       ; table, bitmap, or initialized data bytes
                    fcc       "#"                            ; embedded text or resource bytes
                    fcb       $08,$09,$00 ; table, bitmap, or initialized data bytes
                    fcc       "(2"                           ; embedded text or resource bytes
                    fcb       $08,$09,$01,$FF,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$02   ; table, bitmap, or initialized data bytes
Code_2753           leax      >Data_271D,PCR ; form the referenced address without reading memory
                    leay      >Data_2725,PCR ; form the referenced address without reading memory
                    lbsr      Code_2669 ; call the referenced helper routine
                    bra       Code_2764 ; continue at the selected control-flow target
Code_2760           tst       Addr_001C ; set condition flags from the current value
                    beq       Code_2768 ; branch when the compared values are equal
Code_2764           bsr       Code_2712 ; call the referenced helper routine
Code_2766           bsr       Code_27A3 ;2766: 8D 3B          '. ; call the referenced helper routine
Code_2768           ldb       #$80      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    bne       Code_278A ; branch when the compared values differ
                    lbsr      Code_3A71 ; call the referenced helper routine
                    cmpb      #$01      ; compare against the limit and set condition flags
                    beq       Code_27B2 ;2775: 27 3B          '' ; branch when the compared values are equal
                    ldd       Addr_0013 ; load the value needed by the following operation
                    leax      >Data_2744,PCR ; form the referenced address without reading memory
                    lbsr      Code_3A56 ; call the referenced helper routine
                    cmpb      #$00      ; compare against the limit and set condition flags
                    beq       Code_2760 ; branch when the compared values are equal
                    cmpb      #$01      ; compare against the limit and set condition flags
                    beq       Code_279A ; branch when the compared values are equal
                    bra       Code_2768 ; continue at the selected control-flow target
Code_278A           cmpa      #$0D      ; compare against the limit and set condition flags
                    beq       Code_27BB ; branch when the compared values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    beq       Code_27BF ; branch when the compared values are equal
                    cmpa      #$08      ; compare against the limit and set condition flags
                    beq       Code_2760 ; branch when the compared values are equal
                    cmpa      #$09      ; compare against the limit and set condition flags
                    bne       Code_2768 ; branch when the compared values differ
Code_279A           tst       Addr_001C ; set condition flags from the current value
                    bne       Code_2768 ; branch when the compared values differ
                    lbsr      Code_2705 ; call the referenced helper routine
                    bra       Code_2766 ; continue at the selected control-flow target
Code_27A3           lda       #$48      ; load the value needed by the following operation
                    ldb       #$1C      ; load the value needed by the following operation
                    bsr       Code_27AD ; call the referenced helper routine
                    tfr       Y,X       ; copy the source register into the destination register
                    ldb       #$2A      ; load the value needed by the following operation
Code_27AD           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_27B2           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "E"                            ; embedded text or resource bytes
                    cmpx      #Data_00FF ; compare against the limit and set condition flags
                    beq       Code_27BF ; branch when the compared values are equal
Code_27BB           lda       Addr_001C ; load the value needed by the following operation
                    bra       Code_27C1 ; continue at the selected control-flow target
Code_27BF           lda       #$01      ; load the value needed by the following operation
Code_27C1           pshs      A         ; preserve the listed registers on the stack
                    lda       #$01      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    puls      A         ; restore the listed registers from the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_27D0           lda       -$0F,X    ; load the value needed by the following operation
                    lbsr      Code_05C8 ; call the referenced helper routine
                    bmi       Code_27F6 ; branch while the tested value is negative
                    lda       Addr_000F ; load the value needed by the following operation
                    ldb       Addr_0010 ; load the value needed by the following operation
                    pshs      Y,X,D     ; preserve the listed registers on the stack
Code_27DD           lbsr      Code_0BD2 ; call the referenced helper routine
                    lda       #$20      ; load the value needed by the following operation
                    cmpa      ,Y        ; compare against the limit and set condition flags
                    beq       Code_27F4 ; branch when the compared values are equal
                    lda       -$0F,Y    ; load the value needed by the following operation
                    lbsr      Code_05C8 ; call the referenced helper routine
                    bpl       Code_27DD ; branch while the tested value is nonnegative
                    puls      Y,X,D     ; restore the listed registers from the stack
                    lbsr      Code_255E ; call the referenced helper routine
                    bra       Code_27F6 ; continue at the selected control-flow target
Code_27F4           leas      $06,S     ; form the referenced address without reading memory
Code_27F6           pshs      Y,X       ; preserve the listed registers on the stack
                    pshs      U         ; preserve the listed registers on the stack
Code_27FA           tfr       X,U       ; copy the source register into the destination register
Code_27FC           leay      $01,Y     ; form the referenced address without reading memory
                    leax      $01,X     ; form the referenced address without reading memory
                    lda       ,Y        ; load the value needed by the following operation
                    lbsr      Code_05C8 ; call the referenced helper routine
                    bmi       Code_2811 ; branch while the tested value is negative
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bne       Code_27FC ; branch when the compared values differ
                    lda       ,X        ; load the value needed by the following operation
                    sta       ,U        ; save the current value in working storage
                    bra       Code_27FA ; continue at the selected control-flow target
Code_2811           lda       #$20      ; load the value needed by the following operation
                    sta       ,U        ; save the current value in working storage
                    puls      U         ; restore the listed registers from the stack
                    puls      Y,X       ; restore the listed registers from the stack
                    lbsr      Code_24A5 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_281D           pshs      X,B       ; preserve the listed registers on the stack
                    ldd       #Code_0180 ; load the value needed by the following operation
                    leax      $136C,U   ; form the referenced address without reading memory
Code_2826           bitb      ,X        ; test the selected flag bits without changing the value
                    beq       Code_283A ; branch when the compared values are equal
                    inca                ; advance the selected counter
                    lsrb                ; shift right and expose the low bit through carry
                    bcc       Code_2826 ; branch when carry is clear
                    leax      $01,X     ; form the referenced address without reading memory
                    ldb       #$80      ; load the value needed by the following operation
                    cmpa      #$28      ; compare against the limit and set condition flags
                    bcs       Code_2826 ; branch when carry reports an unsigned underflow or error
                    lda       #$FF      ; load the value needed by the following operation
                    puls      PC,X,B    ; restore the listed registers from the stack
Code_283A           orb       ,X        ; set the selected flag bits
                    stb       ,X        ; save the current value in working storage
                    puls      PC,X,B    ; restore the listed registers from the stack
Code_2840           pshs      X,D       ; preserve the listed registers on the stack
                    leax      $30D9,U   ; form the referenced address without reading memory
                    ldb       #$80      ; load the value needed by the following operation
Code_2848           deca                ; decrement the selected counter
                    beq       Code_2854 ; branch when the compared values are equal
                    lsrb                ; shift right and expose the low bit through carry
                    bcc       Code_2848 ; branch when carry is clear
                    leax      $01,X     ; form the referenced address without reading memory
                    ldb       #$80      ; load the value needed by the following operation
                    bra       Code_2848 ; continue at the selected control-flow target
Code_2854           orb       ,X        ; set the selected flag bits
                    stb       ,X        ; save the current value in working storage
                    puls      PC,X,D    ; restore the listed registers from the stack
Code_285A           ldb       #$05      ; load the value needed by the following operation
                    leax      $136C,U   ; form the referenced address without reading memory
                    leay      $30D9,U   ; form the referenced address without reading memory
Code_2864           lda       ,Y        ; load the value needed by the following operation
                    clr       ,Y+       ; clear the selected byte or register
                    coma                ; invert every bit in the selected value
                    anda      ,X        ; mask off unwanted bits
                    sta       ,X+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bne       Code_2864 ; branch when the compared values differ
                    rts                 ; return to the caller
Data_2871           fcc       "("                            ; embedded text or resource bytes
                    fcb       $04,$0C,$AA,$A8,$0A,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$8F,$F0,$AA,$A8,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$0A,$A8,$F2,$8F,$0A ; table, bitmap, or initialized data bytes
                    fcb       $AA,$F2,$8F,$0A,$AA,$A8 ; table, bitmap, or initialized data bytes
                    fcb       $F0,$AA,$AA,$A8,$F0,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$A8,$F0,$AA,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$AA,$AA,$A8,$F0,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$A8,$F0,$AA,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$AA   ; table, bitmap, or initialized data bytes
Data_28A4           fcc       "("                            ; embedded text or resource bytes
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
Data_28D7           fcc       "("                            ; embedded text or resource bytes
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
Data_290A           fcc       "("                            ; embedded text or resource bytes
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
Data_293D           fcc       "("                            ; embedded text or resource bytes
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
Data_2970           fcc       "("                            ; embedded text or resource bytes
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
Data_29A3           fcb       $00,$01,$B8,$00,$00,$01 ; table, bitmap, or initialized data bytes
                    fcb       $DA,$00,$0D ; table, bitmap, or initialized data bytes
Data_29AC           fcb       $00,$01,$E0,$00,$00,$02 ; table, bitmap, or initialized data bytes
                    fcb       $02,$00,$0D ; table, bitmap, or initialized data bytes
Data_29B5           fcb       $00,$02,$08,$00,$00,$02 ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $00,$0D   ; table, bitmap, or initialized data bytes
Data_29BE           fcb       $00,$02   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $00,$00,$02 ; table, bitmap, or initialized data bytes
                    fcc       "R"                            ; embedded text or resource bytes
                    fcb       $00,$0D   ; table, bitmap, or initialized data bytes
Code_29C7           pshs      A         ; preserve the listed registers on the stack
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    lda       #$03      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    clra                ; clear the selected byte or register
                    puls      B         ; restore the listed registers from the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    rts                 ; return to the caller
Data_29E9           fcc       "File"                         ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_29EE           clra                ; clear the selected byte or register
Code_29EF           ldb       #$01      ; load the value needed by the following operation
                    leax      >Data_29E9,PCR ; form the referenced address without reading memory
                    bra       Code_29C7 ; continue at the selected control-flow target
Data_29F7           fcc       "Card"                         ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_29FC           clra                ; clear the selected byte or register
Code_29FD           ldb       #$06      ; load the value needed by the following operation
                    leax      >Data_29F7,PCR ; form the referenced address without reading memory
                    bra       Code_29C7 ; continue at the selected control-flow target
Code_2A05           lda       #$FF      ; load the value needed by the following operation
                    bra       Code_2A0B ; continue at the selected control-flow target
Code_2A09           lda       #$AA      ; load the value needed by the following operation
Code_2A0B           sta       >Data_29A3,PCR ; save the current value in working storage
                    leax      >Data_29A3,PCR ; form the referenced address without reading memory
Code_2A13           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $13       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_2A20           ldb       #$37      ; load the value needed by the following operation
                    leax      Data_2871,PCR ; form the referenced address without reading memory
                    bra       Code_2A56 ; continue at the selected control-flow target
Code_2A28           lda       #$FF      ; load the value needed by the following operation
                    bra       Code_2A2E ; continue at the selected control-flow target
Code_2A2C           lda       #$AA      ; load the value needed by the following operation
Code_2A2E           sta       Data_29AC,PCR ; save the current value in working storage
                    leax      Data_29AC,PCR ; form the referenced address without reading memory
                    bra       Code_2A13 ; continue at the selected control-flow target
Code_2A38           ldb       #$3C      ; load the value needed by the following operation
                    leax      Data_28A4,PCR ; form the referenced address without reading memory
                    bra       Code_2A56 ; continue at the selected control-flow target
Code_2A40           lda       #$FF      ; load the value needed by the following operation
                    bra       Code_2A46 ; continue at the selected control-flow target
Code_2A44           lda       #$AA      ; load the value needed by the following operation
Code_2A46           sta       Data_29B5,PCR ; save the current value in working storage
                    leax      Data_29B5,PCR ; form the referenced address without reading memory
                    bra       Code_2A13 ; continue at the selected control-flow target
Code_2A50           ldb       #$41      ; load the value needed by the following operation
                    leax      Data_28D7,PCR ; form the referenced address without reading memory
Code_2A56           lda       #$01      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_2A65           ldb       #$3C      ; load the value needed by the following operation
                    leax      Data_290A,PCR ; form the referenced address without reading memory
                    bra       Code_2A56 ; continue at the selected control-flow target
Code_2A6D           ldb       #$41      ; load the value needed by the following operation
                    leax      Data_293D,PCR ; form the referenced address without reading memory
                    bra       Code_2A56 ; continue at the selected control-flow target
Code_2A75           lda       #$FF      ; load the value needed by the following operation
                    bra       Code_2A7B ; continue at the selected control-flow target
Code_2A79           lda       #$AA      ; load the value needed by the following operation
Code_2A7B           sta       Data_29BE,PCR ; save the current value in working storage
                    leax      Data_29BE,PCR ;2A7F: 30 8D FF 3B    '0.. ; form the referenced address without reading memory
                    bra       Code_2A13 ; continue at the selected control-flow target
Code_2A85           ldb       #$46      ; load the value needed by the following operation
                    leax      Data_2970,PCR ; form the referenced address without reading memory
                    bra       Code_2A56 ; continue at the selected control-flow target
Data_2A8D           fcc       "Format"                       ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_2A94           clra                ; clear the selected byte or register
Code_2A95           leax      >Data_2A8D,PCR ; form the referenced address without reading memory
Code_2A99           ldb       #$01      ; load the value needed by the following operation
                    lbra      Code_29C7 ; continue at the distant control-flow target
Data_2A9E           fcc       "Insert"                       ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_2AA5           clra                ; clear the selected byte or register
Code_2AA6           leax      >Data_2A9E,PCR ; form the referenced address without reading memory
                    bra       Code_2A99 ; continue at the selected control-flow target
Data_2AAC           fcc       "Find"                         ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_2AB1           clra                ; clear the selected byte or register
Code_2AB2           leax      >Data_2AAC,PCR ; form the referenced address without reading memory
                    bra       Code_2A99 ; continue at the selected control-flow target
Code_2AB8           pshs      Y,X,D     ; preserve the listed registers on the stack
                    clra                ; clear the selected byte or register
                    bra       Code_2AC4 ; continue at the selected control-flow target
Code_2ABD           pshs      Y,X,D     ; preserve the listed registers on the stack
                    clra                ; clear the selected byte or register
                    sta       Addr_0026 ; save the current value in working storage
                    lda       #$40      ; load the value needed by the following operation
Code_2AC4           lbsr      Code_29EF ; call the referenced helper routine
                    bra       Code_2AD9 ; continue at the selected control-flow target
Code_2AC9           pshs      Y,X,D     ; preserve the listed registers on the stack
                    clra                ; clear the selected byte or register
                    bra       Code_2AD6 ; continue at the selected control-flow target
Code_2ACE           pshs      Y,X,D     ; preserve the listed registers on the stack
                    lda       #$01      ; load the value needed by the following operation
                    sta       Addr_0026 ; save the current value in working storage
                    lda       #$40      ; load the value needed by the following operation
Code_2AD6           lbsr      Code_29FD ; call the referenced helper routine
Code_2AD9           lbsr      Code_098D ; call the referenced helper routine
                    puls      PC,Y,X,D  ; restore the listed registers from the stack
Code_2ADE           pshs      Y,X,D     ; preserve the listed registers on the stack
                    clra                ; clear the selected byte or register
                    bra       Code_2AEB ; continue at the selected control-flow target
Code_2AE3           pshs      Y,X,D     ; preserve the listed registers on the stack
                    lda       #$08      ; load the value needed by the following operation
                    sta       Addr_0026 ; save the current value in working storage
                    lda       #$40      ; load the value needed by the following operation
Code_2AEB           lbsr      Code_2A95 ; call the referenced helper routine
                    bra       Code_2AD9 ; continue at the selected control-flow target
Code_2AF0           pshs      Y,X,D     ; preserve the listed registers on the stack
                    clra                ; clear the selected byte or register
                    bra       Code_2AFD ; continue at the selected control-flow target
Code_2AF5           pshs      Y,X,D     ; preserve the listed registers on the stack
                    lda       #$09      ; load the value needed by the following operation
                    sta       Addr_0026 ; save the current value in working storage
                    lda       #$40      ; load the value needed by the following operation
Code_2AFD           lbsr      Code_2AA6 ; call the referenced helper routine
                    bra       Code_2AD9 ; continue at the selected control-flow target
Code_2B02           pshs      Y,X,D     ; preserve the listed registers on the stack
                    clra                ; clear the selected byte or register
                    bra       Code_2B0F ; continue at the selected control-flow target
Code_2B07           pshs      Y,X,D     ; preserve the listed registers on the stack
                    lda       #$0A      ; load the value needed by the following operation
                    sta       Addr_0026 ; save the current value in working storage
                    lda       #$40      ; load the value needed by the following operation
Code_2B0F           lbsr      Code_2AB2 ; call the referenced helper routine
                    bra       Code_2AD9 ; continue at the selected control-flow target
Code_2B14           lbsr      Code_2B5A ; call the referenced helper routine
                    lbsr      Code_29FC ; call the referenced helper routine
                    lbsr      Code_29EE ; call the referenced helper routine
                    lbsr      Code_2A20 ; call the referenced helper routine
                    lbsr      Code_2A38 ; call the referenced helper routine
                    lbsr      Code_2A50 ; call the referenced helper routine
                    lbsr      Code_2A85 ; call the referenced helper routine
Code_2B29           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_2B2E           lbsr      Code_2B5A ; call the referenced helper routine
                    lbsr      Code_29FC ; call the referenced helper routine
                    lbsr      Code_29EE ; call the referenced helper routine
                    lbsr      Code_2A20 ; call the referenced helper routine
                    lbsr      Code_2A65 ; call the referenced helper routine
                    lbsr      Code_2A6D ; call the referenced helper routine
                    bra       Code_2B29 ; continue at the selected control-flow target
Code_2B42           bsr       Code_2B5A ; call the referenced helper routine
                    lbsr      Code_2A94 ; call the referenced helper routine
Code_2B47           lbsr      Code_2A20 ; call the referenced helper routine
                    bra       Code_2B29 ; continue at the selected control-flow target
Code_2B4C           bsr       Code_2B5A ; call the referenced helper routine
                    lbsr      Code_2AA5 ; call the referenced helper routine
                    bra       Code_2B47 ; continue at the selected control-flow target
Code_2B53           bsr       Code_2B5A ; call the referenced helper routine
                    lbsr      Code_2AB1 ; call the referenced helper routine
                    bra       Code_2B47 ; continue at the selected control-flow target
Code_2B5A           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    lda       #$AA      ; load the value needed by the following operation
                    ldx       #DeskMateService ; load the value needed by the following operation
                    ldy       #Addr_0E4E ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0E       ; private DeskMate service selector
                    fcc       "9"                            ; embedded text or resource bytes
Data_2B6C           fcc       "       "                      ; embedded text or resource bytes
Data_2B73           fcc       " "                            ; embedded text or resource bytes
                    fcb       $83,$84,$84,$84,$84,$84 ; table, bitmap, or initialized data bytes
                    fcb       $84,$84,$84,$84,$84,$84 ; table, bitmap, or initialized data bytes
                    fcb       $84,$84,$84,$84,$84,$85 ; table, bitmap, or initialized data bytes
                    fcb       $88,$86,$86,$86,$86,$86 ; table, bitmap, or initialized data bytes
                    fcb       $86,$86,$86,$86,$86,$86 ; table, bitmap, or initialized data bytes
                    fcb       $86,$86,$86,$86,$86,$86 ; table, bitmap, or initialized data bytes
                    fcb       $87,$89   ; table, bitmap, or initialized data bytes
Data_2B9A           fcc       " "                            ; embedded text or resource bytes
Data_2B9B           fcc       "        "                     ; embedded text or resource bytes
                    fcb       $86,$86,$86,$86,$86,$86 ; table, bitmap, or initialized data bytes
                    fcb       $86,$86,$86,$86,$86,$86 ; table, bitmap, or initialized data bytes
                    fcb       $86,$86,$86,$86,$86,$87 ; table, bitmap, or initialized data bytes
                    fcb       $84,$84,$84,$84,$84,$84 ; table, bitmap, or initialized data bytes
                    fcb       $84,$84,$84,$84,$84,$84 ; table, bitmap, or initialized data bytes
                    fcb       $84,$84,$84,$84,$84,$85 ; table, bitmap, or initialized data bytes
                    fcb       $89,$89   ; table, bitmap, or initialized data bytes
Data_2BC9           fcc       "("                            ; embedded text or resource bytes
                    fcb       $0C,$14,$10,$03,$00,$FF ; table, bitmap, or initialized data bytes
                    fcb       $18       ; table, bitmap, or initialized data bytes
Code_2BD1           lbsr      Code_1613 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    clrb                ; clear the selected byte or register
                    lda       #$02      ; load the value needed by the following operation
                    sta       Addr_0010 ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    ldb       #$09      ; load the value needed by the following operation
                    lda       #$20      ; load the value needed by the following operation
                    bsr       Code_2C53 ; call the referenced helper routine
                    lda       #$83      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $02       ; private DeskMate service selector
                    lda       #$84      ; load the value needed by the following operation
                    ldb       #$10      ; load the value needed by the following operation
                    bsr       Code_2C53 ; call the referenced helper routine
                    lda       #$85      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $02       ; private DeskMate service selector
                    lda       #$20      ; load the value needed by the following operation
                    ldb       #$0C      ; load the value needed by the following operation
                    bsr       Code_2C53 ; call the referenced helper routine
                    bsr       Code_2C49 ; call the referenced helper routine
                    clrb                ; clear the selected byte or register
                    ldy       #Addr_0027 ; load the value needed by the following operation
                    leax      >Data_2B9A,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $22       ; private DeskMate service selector
                    leax      Data_2B6C,PCR ; form the referenced address without reading memory
                    pshs      X         ; preserve the listed registers on the stack
                    leax      >Data_2B9B,PCR ; form the referenced address without reading memory
                    pshs      X         ; preserve the listed registers on the stack
                    lda       #$07      ; load the value needed by the following operation
                    pshs      A         ; preserve the listed registers on the stack
Code_2C1F           bsr       Code_2C49 ; call the referenced helper routine
                    clrb                ; clear the selected byte or register
                    ldy       #Addr_0027 ; load the value needed by the following operation
                    ldx       $03,S     ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $22       ; private DeskMate service selector
                    leax      $01,X     ; form the referenced address without reading memory
                    stx       $03,S     ; save the current value in working storage
                    bsr       Code_2C49 ; call the referenced helper routine
                    clrb                ; clear the selected byte or register
                    ldy       #Addr_0027 ; load the value needed by the following operation
                    ldx       $01,S     ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $22       ; private DeskMate service selector
                    leax      $01,X     ; form the referenced address without reading memory
                    stx       $01,S     ; save the current value in working storage
                    dec       ,S        ; decrement the selected counter
                    bne       Code_2C1F ; branch when the compared values differ
                    leas      $05,S     ; form the referenced address without reading memory
                    bra       Code_2C61 ; continue at the selected control-flow target
Code_2C49           clrb                ; clear the selected byte or register
                    inc       Addr_0010 ; advance the selected counter
                    lda       Addr_0010 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_2C53           pshs      B         ; preserve the listed registers on the stack
                    clrb                ; clear the selected byte or register
Code_2C56           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $02       ; private DeskMate service selector
                    dec       ,S        ; decrement the selected counter
                    bne       Code_2C56 ; branch when the compared values differ
                    leas      $01,S     ; form the referenced address without reading memory
                    rts                 ; return to the caller
Code_2C61           bsr       Code_2C49 ; call the referenced helper routine
                    clrb                ; clear the selected byte or register
                    ldy       #Addr_0027 ; load the value needed by the following operation
                    leax      Data_2B73,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $22       ; private DeskMate service selector
                    bsr       Code_2C49 ; call the referenced helper routine
                    lda       #$20      ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $02       ; private DeskMate service selector
                    lda       #$84      ; load the value needed by the following operation
                    ldb       #$23      ; load the value needed by the following operation
                    bsr       Code_2C53 ; call the referenced helper routine
                    lda       #$85      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $02       ; private DeskMate service selector
                    lda       #$89      ; load the value needed by the following operation
                    ldb       #$02      ; load the value needed by the following operation
                    bsr       Code_2C53 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_2C8C           bsr       Code_2C49 ; call the referenced helper routine
                    lda       #$20      ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $02       ; private DeskMate service selector
                    lda       #$84      ; load the value needed by the following operation
                    ldb       #$24      ; load the value needed by the following operation
                    bsr       Code_2C53 ; call the referenced helper routine
                    lda       #$89      ; load the value needed by the following operation
                    ldb       #$02      ; load the value needed by the following operation
                    bsr       Code_2C53 ; call the referenced helper routine
                    lda       #$55      ; load the value needed by the following operation
                    ldx       #Addr_A100 ; load the value needed by the following operation
                    ldy       #Data_1F4E ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0E       ; private DeskMate service selector
                    clra                ; clear the selected byte or register
                    ldx       #Addr_C000 ; load the value needed by the following operation
                    ldy       #Addr_084E ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0E       ; private DeskMate service selector
                    lda       #$04      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    leax      Data_2BC9,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_2CC9           lda       #$04      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    lda       #$15      ; load the value needed by the following operation
                    ldb       #$10      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    clrb                ; clear the selected byte or register
                    leax      >$0059,U  ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "6"                            ; embedded text or resource bytes
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    lda       #$01      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_2CEC           pshs      X         ; preserve the listed registers on the stack
                    leax      $28,X     ; form the referenced address without reading memory
                    stx       Data_003D ; save the current value in working storage
                    puls      PC,X      ; restore the listed registers from the stack
Code_2CF5           lbsr      Code_2496 ; call the referenced helper routine
Code_2CF8           leax      $088B,U   ; form the referenced address without reading memory
                    bsr       Code_2CEC ; call the referenced helper routine
                    leax      $01,X     ; form the referenced address without reading memory
                    leay      $30F7,U   ; form the referenced address without reading memory
                    clr       Code_0033 ; clear the selected byte or register
Code_2D06           lda       ,Y+       ; fetch the next value and advance the source pointer
                    cmpa      #$2A      ; compare against the limit and set condition flags
                    beq       Code_2D16 ; branch when the compared values are equal
                    leax      $0F,X     ; form the referenced address without reading memory
Code_2D0E           tst       ,X+       ; set condition flags from the current value
                    bpl       Code_2D0E ; branch while the tested value is nonnegative
                    leax      -$01,X    ; form the referenced address without reading memory
                    bra       Code_2D61 ; continue at the selected control-flow target
Code_2D16           tst       Code_0033 ; set condition flags from the current value
                    beq       Code_2D24 ; branch when the compared values are equal
                    lda       #$0D      ; load the value needed by the following operation
                    bsr       Code_2D78 ; call the referenced helper routine
                    lbcs      Code_2DD0 ; take the distant branch when carry reports an error
                    clr       Code_0033 ; clear the selected byte or register
Code_2D24           ldb       #$0E      ; load the value needed by the following operation
Code_2D26           lda       ,X+       ; fetch the next value and advance the source pointer
                    bsr       Code_2D78 ; call the referenced helper routine
                    lbcs      Code_2DD0 ; take the distant branch when carry reports an error
                    decb                ; decrement the selected counter
                    bne       Code_2D26 ; branch when the compared values differ
Code_2D31           lda       ,X        ; load the value needed by the following operation
                    bmi       Code_2D61 ; branch while the tested value is negative
                    cmpx      Data_003D ; compare against the limit and set condition flags
                    bne       Code_2D3F ; branch when the compared values differ
                    bsr       Code_2CEC ; call the referenced helper routine
                    leax      $03,X     ; form the referenced address without reading memory
                    bra       Code_2D31 ; continue at the selected control-flow target
Code_2D3F           leax      $01,X     ; form the referenced address without reading memory
                    cmpa      #$7F      ; compare against the limit and set condition flags
                    bne       Code_2D47 ; branch when the compared values differ
                    lda       #$20      ; load the value needed by the following operation
Code_2D47           bsr       Code_2D78 ; call the referenced helper routine
                    lbcs      Code_2DD0 ; take the distant branch when carry reports an error
                    bne       Code_2D31 ; branch when the compared values differ
                    lda       ,X        ; load the value needed by the following operation
                    bmi       Code_2D61 ; branch while the tested value is negative
                    lda       #$20      ; load the value needed by the following operation
                    bsr       Code_2D78 ; call the referenced helper routine
                    bcs       Code_2DD0 ; branch when carry reports an unsigned underflow or error
                    lda       #$20      ; load the value needed by the following operation
                    bsr       Code_2D78 ; call the referenced helper routine
                    bcs       Code_2DD0 ; branch when carry reports an unsigned underflow or error
                    bra       Code_2D31 ; continue at the selected control-flow target
Code_2D61           bsr       Code_2CEC ; call the referenced helper routine
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    bne       Code_2D06 ; branch when the compared values differ
                    lda       #$0D      ; load the value needed by the following operation
                    bsr       Code_2D78 ; call the referenced helper routine
                    bcs       Code_2DD0 ; branch when carry reports an unsigned underflow or error
                    lda       #$0D      ; load the value needed by the following operation
                    bsr       Code_2D78 ; call the referenced helper routine
                    bcs       Code_2DD0 ; branch when carry reports an unsigned underflow or error
                    andcc     #$FE      ; mask off unwanted bits
                    rts                 ; return to the caller
Code_2D78           pshs      B         ; preserve the listed registers on the stack
                    ldb       Data_0036 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "T"                            ; embedded text or resource bytes
                    bcs       Code_2D90 ; branch when carry reports an unsigned underflow or error
                    inc       Code_0033 ; advance the selected counter
                    lda       Code_0033 ; load the value needed by the following operation
                    cmpa      Data_0037 ; compare against the limit and set condition flags
                    bne       Code_2D8C ; branch when the compared values differ
                    clr       Code_0033 ; clear the selected byte or register
Code_2D8C           andcc     #$FE      ; mask off unwanted bits
                    puls      PC,B      ; restore the listed registers from the stack
Code_2D90           leas      $01,S     ; form the referenced address without reading memory
                    rts                 ; return to the caller
Data_2D93           fcc       "      Device Error"           ; embedded text or resource bytes
                    fcb       $0D,$0A,$0D,$0A ; table, bitmap, or initialized data bytes
                    fcc       " Press Any Key to Can"        ; embedded text or resource bytes
                    fcc       "cel"                          ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_2DC2           fcc       "("                            ; embedded text or resource bytes
                    fcb       $06,$0C,$1B,$05,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $18       ; table, bitmap, or initialized data bytes
Code_2DCA           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Q"                            ; embedded text or resource bytes
                    bcc       Code_2DEA ; branch when carry is clear
Code_2DD0           cmpb      #$02      ; compare against the limit and set condition flags
                    beq       Code_2DE8 ; branch when the compared values are equal
                    leax      >Data_2DC2,PCR ; form the referenced address without reading memory
                    leay      >Data_2D93,PCR ; form the referenced address without reading memory
                    lbsr      Code_140C ; call the referenced helper routine
                    ldb       #$80      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1C       ; private DeskMate service selector
                    lbsr      Code_3A71 ; call the referenced helper routine
Code_2DE8           comb                ; invert every bit in the selected value
                    rts                 ; return to the caller
Code_2DEA           sta       Data_0036 ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "N"                            ; embedded text or resource bytes
                    clr       $0C,X     ; clear the selected byte or register
                    clr       $0D,X     ; clear the selected byte or register
                    lda       #$FF      ; load the value needed by the following operation
                    sta       $1A,X     ; save the current value in working storage
                    lda       $1C,X     ; load the value needed by the following operation
                    sta       Data_0037 ; save the current value in working storage
                    rts                 ; return to the caller
Code_2DFF           lda       Data_0036 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "R"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_2E06           lbsr      Code_2B53 ; call the referenced helper routine
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Addr_0026 ; save the current value in working storage
                    clr       Addr_0027 ; clear the selected byte or register
                    clr       Addr_002B ; clear the selected byte or register
                    clr       Addr_001E ; clear the selected byte or register
                    tst       Data_0030 ; set condition flags from the current value
                    beq       Code_2E22 ; branch when the compared values are equal
                    lbsr      Code_1788 ; call the referenced helper routine
                    lbsr      Code_3079 ; call the referenced helper routine
                    lbsr      Code_1620 ; call the referenced helper routine
                    bra       Code_2E33 ; continue at the selected control-flow target
Code_2E22           lbsr      Code_179C ; call the referenced helper routine
                    clr       Code_001D ; clear the selected byte or register
                    lbsr      Code_2AB1 ; call the referenced helper routine
                    lbsr      Code_3079 ; call the referenced helper routine
                    lbsr      Code_2EA8 ; call the referenced helper routine
                    lbsr      Code_1620 ; call the referenced helper routine
Code_2E33           lda       #$0A      ; load the value needed by the following operation
                    sta       Data_0039 ; save the current value in working storage
                    sta       Data_0038 ; save the current value in working storage
                    lbsr      Code_260B ; call the referenced helper routine
                    lbsr      Code_250D ; call the referenced helper routine
Code_2E3F           lbsr      Code_15F0 ; call the referenced helper routine
Code_2E42           ldb       #$83      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    bne       Code_2E67 ; branch when the compared values differ
                    lbsr      Code_3BEB ; call the referenced helper routine
                    pshs      D         ; preserve the listed registers on the stack
                    lbsr      Code_15F0 ; call the referenced helper routine
                    puls      D         ; restore the listed registers from the stack
                    tsta                ; set condition flags from the current value
                    beq       Code_2E42 ; branch when the compared values are equal
                    lda       Addr_0026 ; load the value needed by the following operation
                    cmpa      #$02      ; compare against the limit and set condition flags
                    lbeq      Code_2ED3 ; take the distant branch when values are equal
                    cmpa      #$0A      ; compare against the limit and set condition flags
                    lbeq      Code_2EBA ; take the distant branch when values are equal
                    bra       Code_2E42 ; continue at the selected control-flow target
Code_2E67           cmpa      #$8C      ; compare against the limit and set condition flags
                    bne       Code_2E73 ; branch when the compared values differ
                    tst       Addr_0026 ; set condition flags from the current value
                    lbmi      Code_2EBA ; take the distant branch while the value is negative
                    bra       Code_2E42 ; continue at the selected control-flow target
Code_2E73           cmpa      #$05      ; compare against the limit and set condition flags
                    bne       Code_2E7F ; branch when the compared values differ
                    lbsr      Code_3097 ; call the referenced helper routine
                    clr       Data_0028 ; clear the selected byte or register
                    clr       Code_0029 ; clear the selected byte or register
                    rts                 ; return to the caller
Code_2E7F           cmpa      #$AF      ; compare against the limit and set condition flags
                    lbeq      Code_2ED3 ; take the distant branch when values are equal
                    cmpa      #$B1      ; compare against the limit and set condition flags
                    lbeq      Code_2F0D ; take the distant branch when values are equal
                    cmpa      #$B2      ; compare against the limit and set condition flags
                    lbeq      Code_2F11 ; take the distant branch when values are equal
                    cmpa      #$B3      ; compare against the limit and set condition flags
                    lbeq      Code_2F15 ; take the distant branch when values are equal
                    cmpa      #$B7      ; compare against the limit and set condition flags
                    lbeq      Code_2F5B ; take the distant branch when values are equal
                    cmpa      #$B6      ; compare against the limit and set condition flags
                    lbeq      Code_2F3C ; take the distant branch when values are equal
                    lbsr      Code_1856 ; call the referenced helper routine
                    bra       Code_2E3F ; continue at the selected control-flow target
Code_2EA8           lbsr      Code_260B ; call the referenced helper routine
Code_2EAB           lda       #$3D      ; load the value needed by the following operation
                    sta       ,X        ; save the current value in working storage
                    lbsr      Code_0DB1 ; call the referenced helper routine
                    bne       Code_2EB9 ; branch when the compared values differ
                    lbsr      Code_0F08 ; call the referenced helper routine
                    bra       Code_2EAB ; continue at the selected control-flow target
Code_2EB9           rts                 ; return to the caller
Code_2EBA           lbsr      Code_2B07 ; call the referenced helper routine
                    lbsr      Code_1CF8 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       ":"                            ; embedded text or resource bytes
                    cmpb      #$05      ; compare against the limit and set condition flags
                    beq       Code_2ED6 ; branch when the compared values are equal
                    pshs      Y,X,D     ; preserve the listed registers on the stack
                    lbsr      Code_1895 ; call the referenced helper routine
                    puls      Y,X,D     ; restore the listed registers from the stack
                    cmpa      #$07      ; compare against the limit and set condition flags
                    bne       Code_2EDF ; branch when the compared values differ
Code_2ED3           lbsr      Code_1D60 ; call the referenced helper routine
Code_2ED6           lbsr      Code_3DA9 ; call the referenced helper routine
                    lbsr      Code_1620 ; call the referenced helper routine
                    lbra      Code_2E33 ; continue at the distant control-flow target
Code_2EDF           cmpa      #$03      ; compare against the limit and set condition flags
                    lbeq      Code_2F5B ; take the distant branch when values are equal
                    cmpa      #$06      ; compare against the limit and set condition flags
                    bne       Code_2EF1 ; branch when the compared values differ
                    lbsr      Code_3097 ; call the referenced helper routine
                    clr       Data_0028 ; clear the selected byte or register
                    clr       Code_0029 ; clear the selected byte or register
                    rts                 ; return to the caller
Code_2EF1           pshs      A         ; preserve the listed registers on the stack
                    lbsr      Code_3DA9 ; call the referenced helper routine
                    puls      A         ; restore the listed registers from the stack
                    cmpa      #$00      ; compare against the limit and set condition flags
                    beq       Code_2F0D ; branch when the compared values are equal
                    cmpa      #$01      ; compare against the limit and set condition flags
                    beq       Code_2F11 ; branch when the compared values are equal
                    cmpa      #$02      ; compare against the limit and set condition flags
                    beq       Code_2F15 ; branch when the compared values are equal
                    cmpa      #$04      ; compare against the limit and set condition flags
                    lbeq      Code_3061 ; take the distant branch when values are equal
                    lbra      Code_2F3C ; continue at the distant control-flow target
Code_2F0D           lda       #$3C      ; load the value needed by the following operation
                    bra       Code_2F17 ; continue at the selected control-flow target
Code_2F11           lda       #$3E      ; load the value needed by the following operation
                    bra       Code_2F17 ; continue at the selected control-flow target
Code_2F15           lda       #$3D      ; load the value needed by the following operation
Code_2F17           pshs      A         ; preserve the listed registers on the stack
                    ldx       Data_0051 ; load the value needed by the following operation
                    pshs      X         ; preserve the listed registers on the stack
                    lbsr      Code_1620 ; call the referenced helper routine
                    puls      X         ; restore the listed registers from the stack
                    stx       Data_0051 ; save the current value in working storage
                    lbsr      Code_25AA ; call the referenced helper routine
                    lbsr      Code_098D ; call the referenced helper routine
                    puls      A         ; restore the listed registers from the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "C"                            ; embedded text or resource bytes
                    sta       ,X        ; save the current value in working storage
Code_2F32           lbsr      Code_250D ; call the referenced helper routine
                    lda       Data_0038 ; load the value needed by the following operation
                    sta       Data_0039 ; save the current value in working storage
                    lbra      Code_2E3F ; continue at the distant control-flow target
Code_2F3C           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1B       ; private DeskMate service selector
                    ldx       Data_0051 ; load the value needed by the following operation
                    ldx       $01,X     ; load the value needed by the following operation
                    lda       #$3A      ; load the value needed by the following operation
                    cmpa      -$01,X    ; compare against the limit and set condition flags
                    bne       Code_2F4C ; branch when the compared values differ
                    lda       #$2A      ; load the value needed by the following operation
Code_2F4C           sta       -$01,X    ; save the current value in working storage
                    ldd       Data_0051 ; load the value needed by the following operation
                    pshs      D         ; preserve the listed registers on the stack
                    lbsr      Code_1620 ; call the referenced helper routine
                    puls      D         ; restore the listed registers from the stack
                    std       Data_0051 ; save the current value in working storage
                    bra       Code_2F32 ; continue at the selected control-flow target
Code_2F5B           lbsr      Code_3097 ; call the referenced helper routine
                    lbsr      Code_1792 ; call the referenced helper routine
                    bsr       Code_2F67 ; call the referenced helper routine
                    lbsr      Code_31A1 ;2F63: 17 02 3B       '.. ; call the referenced helper routine
                    rts                 ; return to the caller
Code_2F67           lbsr      Code_260B ; call the referenced helper routine
                    lda       #$01      ; load the value needed by the following operation
                    sta       Addr_002C ; save the current value in working storage
                    sta       Data_0030 ; save the current value in working storage
Code_2F70           lbsr      Code_2FD4 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_2F82 ; branch when the compared values are equal
                    bpl       Code_2F8A ; branch while the tested value is nonnegative
                    ldx       Data_0051 ; load the value needed by the following operation
                    ldx       $01,X     ; load the value needed by the following operation
                    lda       #$01      ; load the value needed by the following operation
                    sta       ,X        ; save the current value in working storage
                    bra       Code_2F8A ; continue at the selected control-flow target
Code_2F82           ldx       Data_0051 ; load the value needed by the following operation
                    ldx       $01,X     ; load the value needed by the following operation
                    lda       #$20      ; load the value needed by the following operation
                    sta       ,X        ; save the current value in working storage
Code_2F8A           lbsr      Code_2FA6 ; call the referenced helper routine
                    lbsr      Code_25AA ; call the referenced helper routine
                    lbsr      Code_098D ; call the referenced helper routine
                    lbsr      Code_0DB1 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    bne       Code_2F9F ; branch when the compared values differ
                    lbsr      Code_0F08 ; call the referenced helper routine
                    lbra      Code_2F70 ; continue at the distant control-flow target
Code_2F9F           lbsr      Code_1715 ; call the referenced helper routine
                    lbsr      Code_136B ; call the referenced helper routine
                    rts                 ; return to the caller
Code_2FA6           ldx       Data_0051 ; load the value needed by the following operation
                    ldx       $01,X     ; load the value needed by the following operation
                    lda       -$0E,X    ; load the value needed by the following operation
                    anda      #$7F      ; mask off unwanted bits
                    pshs      A         ; preserve the listed registers on the stack
                    leax      $1351,U   ; form the referenced address without reading memory
                    leay      $30C0,U   ; form the referenced address without reading memory
Code_2FB8           lda       ,X        ; load the value needed by the following operation
                    cmpa      ,S        ; compare against the limit and set condition flags
                    beq       Code_2FC4 ; branch when the compared values are equal
                    leax      $01,X     ; form the referenced address without reading memory
                    leay      $01,Y     ; form the referenced address without reading memory
                    bra       Code_2FB8 ; continue at the selected control-flow target
Code_2FC4           leas      $01,S     ; form the referenced address without reading memory
                    ldx       Data_0051 ; load the value needed by the following operation
                    ldx       $01,X     ; load the value needed by the following operation
                    lda       ,X        ; load the value needed by the following operation
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bne       Code_2FD1 ; branch when the compared values differ
                    clra                ; clear the selected byte or register
Code_2FD1           sta       ,Y        ; save the current value in working storage
                    rts                 ; return to the caller
Code_2FD4           leay      $01,Y     ; form the referenced address without reading memory
                    leax      $01,X     ; form the referenced address without reading memory
                    bsr       Code_300F ; call the referenced helper routine
                    bmi       Code_3008 ; branch while the tested value is negative
                    cmpa      #$2A      ; compare against the limit and set condition flags
                    bne       Code_2FF9 ; branch when the compared values differ
                    pshs      Y,X       ; preserve the listed registers on the stack
                    bsr       Code_300F ; call the referenced helper routine
                    bmi       Code_3006 ; branch while the tested value is negative
                    cmpa      #$2A      ; compare against the limit and set condition flags
                    beq       Code_3006 ; branch when the compared values are equal
Code_2FEA           bsr       Code_300F ; call the referenced helper routine
                    bmi       Code_300A ; branch while the tested value is negative
                    cmpa      #$2A      ; compare against the limit and set condition flags
                    bne       Code_2FEA ; branch when the compared values differ
                    puls      Y,X       ; restore the listed registers from the stack
                    lbsr      Code_301E ; call the referenced helper routine
                    bra       Code_3003 ; continue at the selected control-flow target
Code_2FF9           cmpa      #$20      ; compare against the limit and set condition flags
                    bne       Code_300C ; branch when the compared values differ
                    bsr       Code_300F ; call the referenced helper routine
                    bmi       Code_3008 ; branch while the tested value is negative
                    bra       Code_2FF9 ; continue at the selected control-flow target
Code_3003           lda       #$FF      ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_3006           leas      $04,S     ; form the referenced address without reading memory
Code_3008           clra                ; clear the selected byte or register
                    rts                 ; return to the caller
Code_300A           leas      $04,S     ; form the referenced address without reading memory
Code_300C           lda       #$01      ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_300F           lda       ,X+       ; fetch the next value and advance the source pointer
                    lbsr      Code_05C8 ; call the referenced helper routine
                    bmi       Code_301D ; branch while the tested value is negative
                    ldb       ,Y+       ; fetch the next value and advance the source pointer
                    cmpb      #$20      ; compare against the limit and set condition flags
                    bne       Code_300F ; branch when the compared values differ
                    tsta                ; set condition flags from the current value
Code_301D           rts                 ; return to the caller
Code_301E           pshs      U         ; preserve the listed registers on the stack
Code_3020           lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpa      #$2A      ; compare against the limit and set condition flags
                    beq       Code_3049 ; branch when the compared values are equal
                    ldb       ,Y+       ; fetch the next value and advance the source pointer
                    cmpb      #$20      ; compare against the limit and set condition flags
                    beq       Code_3045 ; branch when the compared values are equal
                    tfr       X,U       ; copy the source register into the destination register
                    leau      -$02,U    ; form the referenced address without reading memory
Code_3030           lda       ,X+       ; fetch the next value and advance the source pointer
                    lbsr      Code_05C8 ; call the referenced helper routine
                    bmi       Code_304F ; branch while the tested value is negative
                    ldb       ,Y+       ; fetch the next value and advance the source pointer
                    cmpb      #$20      ; compare against the limit and set condition flags
                    bne       Code_3030 ; branch when the compared values differ
                    cmpa      #$2A      ; compare against the limit and set condition flags
                    beq       Code_304F ; branch when the compared values are equal
                    sta       ,U        ; save the current value in working storage
                    bra       Code_3020 ; continue at the selected control-flow target
Code_3045           sta       -$02,X    ; save the current value in working storage
                    bra       Code_3020 ; continue at the selected control-flow target
Code_3049           puls      U         ; restore the listed registers from the stack
                    leax      -$02,X    ; form the referenced address without reading memory
                    bra       Code_3053 ; continue at the selected control-flow target
Code_304F           tfr       U,X       ; copy the source register into the destination register
                    puls      U         ; restore the listed registers from the stack
Code_3053           lda       #$20      ; load the value needed by the following operation
Code_3055           ldb       ,X        ; load the value needed by the following operation
                    lbsr      Code_05CC ; call the referenced helper routine
                    bmi       Code_3060 ; branch while the tested value is negative
                    sta       ,X+       ; store the value and advance the destination pointer
                    bra       Code_3055 ; continue at the selected control-flow target
Code_3060           rts                 ; return to the caller
Code_3061           lbsr      Code_179C ; call the referenced helper routine
                    bsr       Code_30B5 ; call the referenced helper routine
                    lbsr      Code_3DA9 ; call the referenced helper routine
                    bsr       Code_3079 ; call the referenced helper routine
                    lbsr      Code_2EA8 ; call the referenced helper routine
                    lbsr      Code_1620 ; call the referenced helper routine
                    clr       Addr_002C ; clear the selected byte or register
                    lbsr      Code_1792 ; call the referenced helper routine
                    lbra      Code_2E33 ; continue at the distant control-flow target
Code_3079           leax      $088B,U   ; form the referenced address without reading memory
                    leay      $30F7,U   ; form the referenced address without reading memory
Code_3081           lda       ,X        ; load the value needed by the following operation
                    bmi       Code_308C ; branch while the tested value is negative
Code_3085           lda       Data_0041 ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    leax      A,X       ; form the referenced address without reading memory
                    bra       Code_3081 ; continue at the selected control-flow target
Code_308C           cmpa      #$FF      ; compare against the limit and set condition flags
                    beq       Code_3096 ; branch when the compared values are equal
                    lda       ,Y+       ; fetch the next value and advance the source pointer
                    sta       $0D,X     ; save the current value in working storage
                    bra       Code_3085 ; continue at the selected control-flow target
Code_3096           rts                 ; return to the caller
Code_3097           leax      $088B,U   ; form the referenced address without reading memory
                    leay      $30F7,U   ; form the referenced address without reading memory
Code_309F           lda       ,X        ; load the value needed by the following operation
                    bmi       Code_30AA ; branch while the tested value is negative
Code_30A3           lda       Data_0041 ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    leax      A,X       ; form the referenced address without reading memory
                    bra       Code_309F ; continue at the selected control-flow target
Code_30AA           cmpa      #$FF      ; compare against the limit and set condition flags
                    beq       Code_30B4 ; branch when the compared values are equal
                    lda       $0D,X     ; load the value needed by the following operation
                    sta       ,Y+       ; store the value and advance the destination pointer
                    bra       Code_30A3 ; continue at the selected control-flow target
Code_30B4           rts                 ; return to the caller
Code_30B5           ldb       #$19      ; load the value needed by the following operation
                    leax      $30F7,U   ; form the referenced address without reading memory
                    lda       #$2A      ; load the value needed by the following operation
Code_30BD           sta       ,X+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bne       Code_30BD ; branch when the compared values differ
                    rts                 ; return to the caller
Code_30C3           ldb       Data_0040 ; load the value needed by the following operation
                    cmpb      #$3D      ; compare against the limit and set condition flags
                    rts                 ; return to the caller
Code_30C8           clr       Data_003F ; clear the selected byte or register
Code_30CA           lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpa      #$2A      ; compare against the limit and set condition flags
                    beq       Code_3126 ; branch when the compared values are equal
                    cmpa      #$3F      ; compare against the limit and set condition flags
                    bne       Code_30E2 ; branch when the compared values differ
                    bsr       Code_30C3 ; call the referenced helper routine
                    bne       Code_3120 ; branch when the compared values differ
                    sta       Data_003F ; save the current value in working storage
                    inc       Addr_0016 ; advance the selected counter
                    lda       ,Y+       ; fetch the next value and advance the source pointer
                    bmi       Code_3111 ; branch while the tested value is negative
                    bra       Code_30CA ; continue at the selected control-flow target
Code_30E2           lbsr      Code_05C8 ; call the referenced helper routine
                    bmi       Code_30FB ; branch while the tested value is negative
                    ldb       ,Y+       ; fetch the next value and advance the source pointer
                    lbsr      Code_05CC ; call the referenced helper routine
                    bmi       Code_3111 ; branch while the tested value is negative
                    lbsr      Code_20D9 ; call the referenced helper routine
                    pshs      B         ; preserve the listed registers on the stack
                    cmpa      ,S+       ; compare against the limit and set condition flags
                    beq       Code_30CA ; branch when the compared values are equal
                    bgt       Code_3111 ; branch when the signed value is above the limit
                    bra       Code_3102 ; continue at the selected control-flow target
Code_30FB           ldb       ,Y+       ; fetch the next value and advance the source pointer
                    lbsr      Code_05CC ; call the referenced helper routine
                    bmi       Code_3128 ; branch while the tested value is negative
Code_3102           bsr       Code_30C3 ; call the referenced helper routine
                    bne       Code_310E ; branch when the compared values differ
                    tst       Data_003F ; set condition flags from the current value
                    beq       Code_310E ; branch when the compared values are equal
                    tst       Addr_002F ; set condition flags from the current value
                    bne       Code_311D ; branch when the compared values differ
Code_310E           lda       #$01      ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_3111           bsr       Code_30C3 ; call the referenced helper routine
                    bne       Code_311D ; branch when the compared values differ
                    tst       Data_003F ; set condition flags from the current value
                    beq       Code_311D ; branch when the compared values are equal
                    tst       Addr_002F ; set condition flags from the current value
                    beq       Code_310E ; branch when the compared values are equal
Code_311D           lda       #$FF      ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_3120           cmpb      #$3C      ; compare against the limit and set condition flags
                    beq       Code_311D ; branch when the compared values are equal
                    bra       Code_310E ; continue at the selected control-flow target
Code_3126           inc       Addr_0016 ; advance the selected counter
Code_3128           clra                ; clear the selected byte or register
                    rts                 ; return to the caller
Code_312A           pshs      Y,X       ; preserve the listed registers on the stack
                    leax      $088B,U   ; form the referenced address without reading memory
                    lbsr      Code_20C2 ; call the referenced helper routine
                    tstb                ; set condition flags from the current value
                    beq       Code_313A ; branch when the compared values are equal
                    leax      $088B,U   ; form the referenced address without reading memory
Code_313A           pshs      X         ; preserve the listed registers on the stack
                    leax      $0BFD,U   ; form the referenced address without reading memory
                    lbsr      Code_20C2 ; call the referenced helper routine
                    tstb                ; set condition flags from the current value
                    beq       Code_314A ; branch when the compared values are equal
                    leax      $0BFD,U   ; form the referenced address without reading memory
Code_314A           tfr       X,Y       ; copy the source register into the destination register
                    puls      X         ; restore the listed registers from the stack
                    lbsr      Code_30C8 ; call the referenced helper routine
                    puls      PC,Y,X    ; restore the listed registers from the stack
Code_3153           leax      $30C0,U   ; form the referenced address without reading memory
                    leay      $1351,U   ; form the referenced address without reading memory
                    clr       Addr_0016 ; clear the selected byte or register
Code_315D           ldb       ,Y        ; load the value needed by the following operation
                    cmpb      #$FF      ; compare against the limit and set condition flags
                    beq       Code_3184 ; branch when the compared values are equal
                    ldb       ,X        ; load the value needed by the following operation
                    stb       Data_0040 ; save the current value in working storage
                    cmpb      #$00      ; compare against the limit and set condition flags
                    beq       Code_317B ; branch when the compared values are equal
                    cmpb      #$3D      ; compare against the limit and set condition flags
                    beq       Code_3171 ; branch when the compared values are equal
                    inc       Addr_0016 ; advance the selected counter
Code_3171           lda       ,Y        ; load the value needed by the following operation
                    lbsr      Code_312A ; call the referenced helper routine
                    ldb       ,X        ; load the value needed by the following operation
                    tsta                ; set condition flags from the current value
                    bne       Code_3183 ; branch when the compared values differ
Code_317B           leax      $01,X     ; form the referenced address without reading memory
                    leay      $01,Y     ; form the referenced address without reading memory
                    tst       Addr_0016 ; set condition flags from the current value
                    beq       Code_315D ; branch when the compared values are equal
Code_3183           rts                 ; return to the caller
Code_3184           ldb       -$01,X    ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_3187           ldd       DeskMateService ; load the value needed by the following operation
                    pshs      D         ; preserve the listed registers on the stack
                    ldd       Addr_0002 ; load the value needed by the following operation
                    subd      ,S++      ; subtract the operand from the running value
                    bitb      #$04      ; test the selected flag bits without changing the value
                    beq       Code_319A ; branch when the compared values are equal
                    lsra                ; shift right and expose the low bit through carry
                    rorb                ; rotate right through carry
                    subd      #Addr_0002 ; subtract the operand from the running value
                    bra       Code_319C ; continue at the selected control-flow target
Code_319A           lsra                ; shift right and expose the low bit through carry
                    rorb                ; rotate right through carry
Code_319C           addd      DeskMateService ; add the operand to the running value
                    std       Addr_0004 ; save the current value in working storage
                    rts                 ; return to the caller
Code_31A1           clr       Addr_002F ; clear the selected byte or register
                    ldx       Addr_000C ; load the value needed by the following operation
                    stx       Addr_0018 ; save the current value in working storage
                    leax      $30C0,U   ; form the referenced address without reading memory
                    lda       ,X        ; load the value needed by the following operation
                    cmpa      #$3D      ; compare against the limit and set condition flags
                    beq       Code_31BF ; branch when the compared values are equal
                    cmpa      #$3E      ; compare against the limit and set condition flags
                    beq       Code_31BF ; branch when the compared values are equal
                    leax      >$0066,U  ; form the referenced address without reading memory
                    leax      $03,X     ; form the referenced address without reading memory
                    stx       Addr_000C ; save the current value in working storage
                    bra       Code_3216 ; continue at the selected control-flow target
Code_31BF           ldd       Addr_0006 ; load the value needed by the following operation
                    std       Addr_0002 ; save the current value in working storage
                    leax      >$0066,U  ; form the referenced address without reading memory
                    tfr       X,D       ; copy the source register into the destination register
                    addd      #Addr_0003 ; add the operand to the running value
                    std       DeskMateService ; save the current value in working storage
                    cmpd      Addr_0002 ; compare against the limit and set condition flags
                    beq       Code_3212 ; branch when the compared values are equal
Code_31D3           ldd       DeskMateService ; load the value needed by the following operation
                    cmpd      Addr_0002 ; compare against the limit and set condition flags
                    beq       Code_3212 ; branch when the compared values are equal
                    lbsr      Code_3187 ; call the referenced helper routine
                    tfr       D,X       ; copy the source register into the destination register
                    cmpd      DeskMateService ; compare against the limit and set condition flags
                    bne       Code_31F3 ; branch when the compared values differ
                    leax      $01,X     ; form the referenced address without reading memory
                    lbsr      Code_21C6 ; call the referenced helper routine
                    lbsr      Code_3153 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    bmi       Code_3212 ; branch while the tested value is negative
                    ldd       DeskMateService ; load the value needed by the following operation
                    bra       Code_3214 ; continue at the selected control-flow target
Code_31F3           ldx       Addr_0004 ; load the value needed by the following operation
                    leax      $01,X     ; form the referenced address without reading memory
                    lbsr      Code_21C6 ; call the referenced helper routine
                    lbsr      Code_3153 ; call the referenced helper routine
                    cmpb      #$3C      ; compare against the limit and set condition flags
                    beq       Code_320C ; branch when the compared values are equal
                    tsta                ; set condition flags from the current value
                    beq       Code_320C ; branch when the compared values are equal
                    bpl       Code_320C ; branch while the tested value is nonnegative
                    ldd       Addr_0004 ; load the value needed by the following operation
                    std       DeskMateService ; save the current value in working storage
                    bra       Code_31D3 ; continue at the selected control-flow target
Code_320C           ldd       Addr_0004 ; load the value needed by the following operation
                    std       Addr_0002 ; save the current value in working storage
                    bra       Code_31D3 ; continue at the selected control-flow target
Code_3212           ldd       Addr_0002 ; load the value needed by the following operation
Code_3214           std       Addr_000C ; save the current value in working storage
Code_3216           lbsr      Code_329A ; call the referenced helper routine
                    rts                 ; return to the caller
Code_321A           leax      $30C0,U   ; form the referenced address without reading memory
                    leay      $1351,U   ; form the referenced address without reading memory
                    leax      $01,X     ; form the referenced address without reading memory
                    leay      $01,Y     ; form the referenced address without reading memory
Code_3226           ldb       ,Y        ; load the value needed by the following operation
                    cmpb      #$FF      ; compare against the limit and set condition flags
                    beq       Code_326A ; branch when the compared values are equal
                    ldb       ,X        ; load the value needed by the following operation
                    stb       Data_0040 ; save the current value in working storage
                    beq       Code_3262 ; branch when the compared values are equal
                    cmpb      #$01      ; compare against the limit and set condition flags
                    beq       Code_3257 ; branch when the compared values are equal
                    lda       ,Y        ; load the value needed by the following operation
                    lbsr      Code_312A ; call the referenced helper routine
                    ldb       ,X        ; load the value needed by the following operation
                    cmpb      #$3C      ; compare against the limit and set condition flags
                    beq       Code_324B ; branch when the compared values are equal
                    cmpb      #$3D      ; compare against the limit and set condition flags
                    beq       Code_3251 ; branch when the compared values are equal
                    cmpa      #$01      ; compare against the limit and set condition flags
                    beq       Code_3262 ; branch when the compared values are equal
                    bra       Code_3268 ; continue at the selected control-flow target
Code_324B           cmpa      #$FF      ; compare against the limit and set condition flags
                    beq       Code_3262 ; branch when the compared values are equal
                    bra       Code_3268 ; continue at the selected control-flow target
Code_3251           cmpa      #$00      ; compare against the limit and set condition flags
                    beq       Code_3262 ; branch when the compared values are equal
                    bra       Code_3268 ; continue at the selected control-flow target
Code_3257           lda       ,Y        ; load the value needed by the following operation
                    lbsr      Code_33C1 ; call the referenced helper routine
                    cmpa      #$01      ; compare against the limit and set condition flags
                    beq       Code_3268 ; branch when the compared values are equal
                    bra       Code_3262 ; continue at the selected control-flow target
Code_3262           leax      $01,X     ; form the referenced address without reading memory
                    leay      $01,Y     ; form the referenced address without reading memory
                    bra       Code_3226 ; continue at the selected control-flow target
Code_3268           clra                ; clear the selected byte or register
                    rts                 ; return to the caller
Code_326A           lda       #$01      ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_326D           leax      $30C0,U   ; form the referenced address without reading memory
                    leay      $1351,U   ; form the referenced address without reading memory
                    ldb       ,X        ; load the value needed by the following operation
                    stb       Data_0040 ; save the current value in working storage
                    beq       Code_3285 ; branch when the compared values are equal
                    lda       ,Y        ; load the value needed by the following operation
                    cmpb      #$01      ; compare against the limit and set condition flags
                    beq       Code_3287 ; branch when the compared values are equal
                    lbsr      Code_312A ; call the referenced helper routine
                    rts                 ; return to the caller
Code_3285           clra                ; clear the selected byte or register
                    rts                 ; return to the caller
Code_3287           lbsr      Code_33C1 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_328B           lbsr      Code_1788 ; call the referenced helper routine
                    lbsr      Code_2F67 ; call the referenced helper routine
                    ldx       Addr_000C ; load the value needed by the following operation
                    stx       Addr_0018 ; save the current value in working storage
                    rts                 ; return to the caller
Code_3296           bsr       Code_328B ; call the referenced helper routine
                    bra       Code_32CC ; continue at the selected control-flow target
Code_329A           ldx       Addr_000C ; load the value needed by the following operation
                    cmpx      Addr_0006 ; compare against the limit and set condition flags
                    lbeq      Code_3373 ; take the distant branch when values are equal
                    lda       #$01      ; load the value needed by the following operation
                    sta       Addr_002F ; save the current value in working storage
                    bra       Code_32CC ; continue at the selected control-flow target
Code_32A8           bsr       Code_328B ; call the referenced helper routine
                    tst       Addr_002F ; set condition flags from the current value
                    beq       Code_32BA ; branch when the compared values are equal
                    leax      $04,X     ; form the referenced address without reading memory
                    cmpx      Addr_0006 ; compare against the limit and set condition flags
                    lbeq      Code_3373 ; take the distant branch when values are equal
                    stx       Addr_000C ; save the current value in working storage
                    bra       Code_32CC ; continue at the selected control-flow target
Code_32BA           leay      >$0066,U  ; form the referenced address without reading memory
                    leay      $03,Y     ; form the referenced address without reading memory
                    pshs      Y         ; preserve the listed registers on the stack
                    cmpx      ,S++      ; compare against the limit and set condition flags
                    lbeq      Code_3373 ; take the distant branch when values are equal
                    leax      -$04,X    ; form the referenced address without reading memory
                    stx       Addr_000C ; save the current value in working storage
Code_32CC           leax      $30C0,U   ; form the referenced address without reading memory
                    lda       ,X        ; load the value needed by the following operation
                    sta       Addr_000E ; save the current value in working storage
Code_32D4           ldx       Addr_000C ; load the value needed by the following operation
                    leax      $01,X     ; form the referenced address without reading memory
                    lbsr      Code_21C6 ; call the referenced helper routine
                    lbsr      Code_326D ; call the referenced helper routine
                    ldb       Addr_000E ; load the value needed by the following operation
                    beq       Code_3331 ; branch when the compared values are equal
                    cmpb      #$01      ; compare against the limit and set condition flags
                    lbeq      Code_3367 ; take the distant branch when values are equal
                    cmpb      #$3E      ; compare against the limit and set condition flags
                    beq       Code_3321 ; branch when the compared values are equal
                    cmpb      #$3C      ; compare against the limit and set condition flags
                    beq       Code_330B ; branch when the compared values are equal
                    cmpa      #$00      ; compare against the limit and set condition flags
                    bne       Code_32FC ; branch when the compared values differ
                    lbsr      Code_321A ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    bne       Code_335F ; branch when the compared values differ
                    bra       Code_3339 ; continue at the selected control-flow target
Code_32FC           tst       Addr_002F ; set condition flags from the current value
                    bne       Code_3304 ; branch when the compared values differ
                    cmpa      #$01      ; compare against the limit and set condition flags
                    bra       Code_3306 ; continue at the selected control-flow target
Code_3304           cmpa      #$FF      ; compare against the limit and set condition flags
Code_3306           beq       Code_3339 ; branch when the compared values are equal
                    lbra      Code_3373 ; continue at the distant control-flow target
Code_330B           tst       Addr_002F ; set condition flags from the current value
                    bne       Code_3315 ; branch when the compared values differ
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    bne       Code_331F ; branch when the compared values differ
                    bra       Code_3319 ; continue at the selected control-flow target
Code_3315           cmpa      #$FF      ; compare against the limit and set condition flags
                    bne       Code_3373 ; branch when the compared values differ
Code_3319           lbsr      Code_321A ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    bne       Code_335F ; branch when the compared values differ
Code_331F           bra       Code_3339 ; continue at the selected control-flow target
Code_3321           cmpa      #$FF      ; compare against the limit and set condition flags
                    beq       Code_3339 ; branch when the compared values are equal
                    cmpa      #$00      ; compare against the limit and set condition flags
                    beq       Code_3339 ; branch when the compared values are equal
                    lbsr      Code_321A ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    bne       Code_335F ; branch when the compared values differ
                    bra       Code_3339 ; continue at the selected control-flow target
Code_3331           lbsr      Code_321A ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    bne       Code_335F ; branch when the compared values differ
                    bra       Code_3339 ; continue at the selected control-flow target
Code_3339           tst       Addr_002F ; set condition flags from the current value
                    beq       Code_334A ; branch when the compared values are equal
                    ldx       Addr_000C ; load the value needed by the following operation
                    leax      $04,X     ; form the referenced address without reading memory
                    cmpx      Addr_0006 ; compare against the limit and set condition flags
                    beq       Code_3373 ; branch when the compared values are equal
                    stx       Addr_000C ; save the current value in working storage
                    lbra      Code_32D4 ; continue at the distant control-flow target
Code_334A           ldx       Addr_000C ; load the value needed by the following operation
                    leay      >$0066,U  ; form the referenced address without reading memory
                    leay      $03,Y     ; form the referenced address without reading memory
                    pshs      Y         ; preserve the listed registers on the stack
                    cmpx      ,S++      ; compare against the limit and set condition flags
                    beq       Code_3373 ; branch when the compared values are equal
                    leax      -$04,X    ; form the referenced address without reading memory
                    stx       Addr_000C ; save the current value in working storage
                    lbra      Code_32D4 ; continue at the distant control-flow target
Code_335F           lbsr      Code_392C ; call the referenced helper routine
                    lda       #$01      ; load the value needed by the following operation
                    sta       Addr_002A ; save the current value in working storage
                    rts                 ; return to the caller
Code_3367           cmpa      #$01      ; compare against the limit and set condition flags
                    beq       Code_3339 ; branch when the compared values are equal
                    lbsr      Code_321A ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    bne       Code_335F ; branch when the compared values differ
                    bra       Code_3339 ; continue at the selected control-flow target
Code_3373           ldx       Addr_0018 ; load the value needed by the following operation
                    stx       Addr_000C ; save the current value in working storage
                    lbsr      Code_392C ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    clr       Addr_002A ; clear the selected byte or register
                    rts                 ; return to the caller
Code_337E           pshs      X         ; preserve the listed registers on the stack
                    clr       Addr_001C ; clear the selected byte or register
Code_3382           ldb       ,Y+       ; fetch the next value and advance the source pointer
                    lbsr      Code_05CC ; call the referenced helper routine
                    bmi       Code_33B1 ; branch while the tested value is negative
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    lbsr      Code_05C8 ; call the referenced helper routine
                    bmi       Code_33BD ; branch while the tested value is negative
                    lbsr      Code_20D9 ; call the referenced helper routine
                    pshs      A         ; preserve the listed registers on the stack
                    cmpb      ,S+       ; compare against the limit and set condition flags
                    bne       Code_33A4 ; branch when the compared values differ
                    tst       Addr_001C ; set condition flags from the current value
                    bne       Code_3382 ; branch when the compared values differ
                    sty       Code_002D ; save the current value in working storage
                    inc       Addr_001C ; advance the selected counter
                    bra       Code_3382 ; continue at the selected control-flow target
Code_33A4           tst       Addr_001C ; set condition flags from the current value
                    beq       Code_33AD ; branch when the compared values are equal
                    ldy       Code_002D ; load the value needed by the following operation
                    clr       Addr_001C ; clear the selected byte or register
Code_33AD           ldx       ,S        ; load the value needed by the following operation
                    bra       Code_3382 ; continue at the selected control-flow target
Code_33B1           lda       ,X        ; load the value needed by the following operation
                    lbsr      Code_05C8 ; call the referenced helper routine
                    bmi       Code_33BD ; branch while the tested value is negative
                    leas      $02,S     ; form the referenced address without reading memory
                    lda       #$01      ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_33BD           leas      $02,S     ; form the referenced address without reading memory
                    clra                ; clear the selected byte or register
                    rts                 ; return to the caller
Code_33C1           pshs      Y,X       ; preserve the listed registers on the stack
                    leax      $088B,U   ; form the referenced address without reading memory
                    lbsr      Code_20C2 ; call the referenced helper routine
                    tstb                ; set condition flags from the current value
                    beq       Code_33D1 ; branch when the compared values are equal
                    leax      $088B,U   ; form the referenced address without reading memory
Code_33D1           pshs      X         ; preserve the listed registers on the stack
                    leax      $0BFD,U   ; form the referenced address without reading memory
                    lbsr      Code_20C2 ; call the referenced helper routine
                    tstb                ; set condition flags from the current value
                    beq       Code_33E1 ; branch when the compared values are equal
                    leax      $0BFD,U   ; form the referenced address without reading memory
Code_33E1           tfr       X,Y       ; copy the source register into the destination register
                    puls      X         ; restore the listed registers from the stack
                    lbsr      Code_337E ; call the referenced helper routine
                    puls      PC,Y,X    ; restore the listed registers from the stack
Code_33EA           pshs      U         ; preserve the listed registers on the stack
                    clra                ; clear the selected byte or register
                    ldb       Addr_0020 ; load the value needed by the following operation
                    pshs      D         ; preserve the listed registers on the stack
                    lda       Addr_0008 ; load the value needed by the following operation
                    pshs      A         ; preserve the listed registers on the stack
                    ldd       >$0021,U  ; load the value needed by the following operation
                    tfr       D,U       ; copy the source register into the destination register
                    puls      X,A       ; restore the listed registers from the stack
                    lbsr      Code_1EF9 ; call the referenced helper routine
                    puls      PC,U      ; restore the listed registers from the stack
Code_3402           pshs      U         ; preserve the listed registers on the stack
                    clra                ; clear the selected byte or register
                    ldb       Addr_0023 ; load the value needed by the following operation
                    pshs      D         ; preserve the listed registers on the stack
                    lda       Addr_0008 ; load the value needed by the following operation
                    pshs      A         ; preserve the listed registers on the stack
                    ldd       >$0024,U  ; load the value needed by the following operation
                    tfr       D,U       ; copy the source register into the destination register
                    puls      X,A       ; restore the listed registers from the stack
                    lbsr      Code_1EF9 ; call the referenced helper routine
                    puls      PC,U      ; restore the listed registers from the stack
Code_341A           pshs      D         ; preserve the listed registers on the stack
                    ldd       #Addr_0001 ; load the value needed by the following operation
                    addd      >$0024,U  ; add the operand to the running value
                    std       >$0024,U  ; save the current value in working storage
                    bcc       Code_342B ; branch when carry is clear
                    inc       Addr_0023 ; advance the selected counter
Code_342B           puls      PC,D      ; restore the listed registers from the stack
Code_342D           pshs      D         ; preserve the listed registers on the stack
                    ldd       #Addr_0001 ; load the value needed by the following operation
                    addd      >$0021,U  ; add the operand to the running value
                    std       >$0021,U  ; save the current value in working storage
                    bcc       Code_343E ; branch when carry is clear
                    inc       Addr_0020 ; advance the selected counter
Code_343E           puls      PC,D      ; restore the listed registers from the stack
Code_3440           pshs      Y,X,D     ; preserve the listed registers on the stack
                    leax      >$0020,U  ; form the referenced address without reading memory
                    leay      >$0023,U  ; form the referenced address without reading memory
                    ldb       #$03      ; load the value needed by the following operation
Code_344C           lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,Y+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bne       Code_344C ; branch when the compared values differ
                    puls      PC,Y,X,D  ; restore the listed registers from the stack
Code_3455           leax      $01,X     ; form the referenced address without reading memory
                    leay      >$0020,U  ; form the referenced address without reading memory
                    ldb       #$03      ; load the value needed by the following operation
Code_345D           lda       ,Y+       ; fetch the next value and advance the source pointer
                    sta       ,X+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bne       Code_345D ; branch when the compared values differ
                    rts                 ; return to the caller
Code_3465           leax      >$0023,U  ; form the referenced address without reading memory
Code_3469           leay      >$0009,U  ; form the referenced address without reading memory
                    ldb       #$03      ; load the value needed by the following operation
Code_346F           lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpa      ,Y+       ; compare against the limit and set condition flags
                    bne       Code_347A ; branch when the compared values differ
                    decb                ; decrement the selected counter
                    bne       Code_346F ; branch when the compared values differ
                    clra                ; clear the selected byte or register
                    rts                 ; return to the caller
Code_347A           lda       #$01      ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_347D           leax      >$0020,U  ; form the referenced address without reading memory
                    bra       Code_3469 ; continue at the selected control-flow target
Code_3483           lbsr      Code_3499 ; call the referenced helper routine
                    lbsr      Code_342D ; call the referenced helper routine
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    bne       Code_3483 ; branch when the compared values differ
                    rts                 ; return to the caller
Code_348E           lbsr      Code_3499 ; call the referenced helper routine
                    lbsr      Code_341A ; call the referenced helper routine
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    bne       Code_348E ; branch when the compared values differ
                    rts                 ; return to the caller
Code_3499           leax      $0BFD,U   ; form the referenced address without reading memory
Code_349D           pshs      X         ; preserve the listed registers on the stack
                    ldy       #Addr_0001 ; load the value needed by the following operation
                    lda       Addr_0008 ; load the value needed by the following operation
                    lbsr      Code_1EC3 ; call the referenced helper routine
                    puls      X         ; restore the listed registers from the stack
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    rts                 ; return to the caller
Code_34AD           leax      $0BFD,U   ; form the referenced address without reading memory
                    sta       ,X+       ; store the value and advance the destination pointer
Code_34B3           bsr       Code_349D ; call the referenced helper routine
                    lbsr      Code_341A ; call the referenced helper routine
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    bne       Code_34B3 ; branch when the compared values differ
                    rts                 ; return to the caller
Code_34BD           leax      >$0066,U  ; form the referenced address without reading memory
                    leax      -$01,X    ; form the referenced address without reading memory
                    bsr       Code_34D7 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_34D2 ; branch when the compared values are equal
Code_34C8           leax      $04,X     ; form the referenced address without reading memory
                    bsr       Code_34D7 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    bne       Code_34C8 ; branch when the compared values differ
                    clr       Addr_0032 ; clear the selected byte or register
                    rts                 ; return to the caller
Code_34D2           lda       #$01      ; load the value needed by the following operation
                    sta       Addr_0032 ; save the current value in working storage
                    rts                 ; return to the caller
Code_34D7           pshs      X         ; preserve the listed registers on the stack
                    ldb       #$03      ; load the value needed by the following operation
                    leax      $01,X     ; form the referenced address without reading memory
                    leay      >$0023,U  ; form the referenced address without reading memory
Code_34E1           lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpa      ,Y+       ; compare against the limit and set condition flags
                    bne       Code_34EE ; branch when the compared values differ
                    decb                ; decrement the selected counter
                    bne       Code_34E1 ; branch when the compared values differ
                    puls      X         ; restore the listed registers from the stack
                    clra                ; clear the selected byte or register
                    rts                 ; return to the caller
Code_34EE           puls      X         ; restore the listed registers from the stack
                    lda       #$01      ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_34F3           lbsr      Code_33EA ; call the referenced helper routine
                    leax      $0BFD,U   ; form the referenced address without reading memory
Code_34FA           ldy       #Addr_0001 ; load the value needed by the following operation
                    lda       Addr_0008 ; load the value needed by the following operation
                    pshs      X         ; preserve the listed registers on the stack
                    lbsr      Code_1ECD ; call the referenced helper routine
                    lbsr      Code_342D ; call the referenced helper routine
                    puls      X         ; restore the listed registers from the stack
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    bne       Code_34FA ; branch when the compared values differ
                    rts                 ; return to the caller
Code_3511           leax      >$0020,U  ; form the referenced address without reading memory
                    clr       ,X+       ; clear the selected byte or register
                    clr       ,X+       ; clear the selected byte or register
                    lda       #$03      ; load the value needed by the following operation
                    sta       ,X        ; save the current value in working storage
                    lbsr      Code_33EA ; call the referenced helper routine
Code_3520           lbsr      Code_3499 ; call the referenced helper routine
                    cmpa      #$80      ; compare against the limit and set condition flags
                    beq       Code_353B ; branch when the compared values are equal
                    tst       Code_0031 ; set condition flags from the current value
                    bne       Code_3556 ; branch when the compared values differ
                    lbsr      Code_342D ; call the referenced helper routine
                    lbsr      Code_3483 ; call the referenced helper routine
                    lbsr      Code_347D ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    lbeq      Code_35DF ; take the distant branch when values are equal
                    bra       Code_3520 ; continue at the selected control-flow target
Code_353B           lbsr      Code_3440 ; call the referenced helper routine
                    lbsr      Code_341A ; call the referenced helper routine
Code_3541           lbsr      Code_348E ; call the referenced helper routine
                    lbsr      Code_3465 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_3595 ; branch when the compared values are equal
                    lbsr      Code_3499 ; call the referenced helper routine
                    cmpa      #$80      ; compare against the limit and set condition flags
                    bne       Code_3559 ; branch when the compared values differ
                    lbsr      Code_341A ; call the referenced helper routine
                    bra       Code_3541 ; continue at the selected control-flow target
Code_3556           lbsr      Code_3440 ; call the referenced helper routine
Code_3559           pshs      A         ; preserve the listed registers on the stack
                    lbsr      Code_34BD ; call the referenced helper routine
                    lbsr      Code_3455 ; call the referenced helper routine
                    puls      A         ; restore the listed registers from the stack
                    lbsr      Code_341A ; call the referenced helper routine
                    lbsr      Code_34AD ; call the referenced helper routine
                    tst       Code_0031 ; set condition flags from the current value
                    beq       Code_3574 ; branch when the compared values are equal
                    tst       Addr_0032 ; set condition flags from the current value
                    bne       Code_3574 ; branch when the compared values differ
                    lbsr      Code_3661 ; call the referenced helper routine
Code_3574           lbsr      Code_34F3 ; call the referenced helper routine
                    lbsr      Code_3402 ; call the referenced helper routine
                    lbsr      Code_3465 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_3595 ; branch when the compared values are equal
Code_3580           lbsr      Code_3499 ; call the referenced helper routine
                    cmpa      #$80      ; compare against the limit and set condition flags
                    bne       Code_3559 ; branch when the compared values differ
                    lbsr      Code_341A ; call the referenced helper routine
                    lbsr      Code_348E ; call the referenced helper routine
                    lbsr      Code_3465 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_3595 ; branch when the compared values are equal
                    bra       Code_3580 ; continue at the selected control-flow target
Code_3595           leax      >$0020,U  ; form the referenced address without reading memory
                    leay      >$0009,U  ; form the referenced address without reading memory
                    ldb       #$03      ; load the value needed by the following operation
Code_359F           lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,Y+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bne       Code_359F ; branch when the compared values differ
                    lbsr      Code_22C6 ; call the referenced helper routine
                    ldx       >$000A,U  ; load the value needed by the following operation
                    lda       >$0009,U  ; load the value needed by the following operation
                    pshs      X,A       ; preserve the listed registers on the stack
                    ldx       >$0064,U  ; load the value needed by the following operation
                    leax      $22,X     ; form the referenced address without reading memory
                    tfr       X,D       ; copy the source register into the destination register
                    lbsr      Code_2331 ; call the referenced helper routine
                    pshs      U         ; preserve the listed registers on the stack
                    clra                ; clear the selected byte or register
                    ldb       >$0009,U  ; load the value needed by the following operation
                    tfr       D,X       ; copy the source register into the destination register
                    ldu       >$000A,U  ; load the value needed by the following operation
                    lda       Addr_0008 ; load the value needed by the following operation
                    ldb       #$02      ; load the value needed by the following operation
                    os9       I$SetStt  ; request the named OS-9 service
                    puls      U         ; restore the listed registers from the stack
                    puls      X,A       ; restore the listed registers from the stack
                    sta       >$0009,U  ; save the current value in working storage
                    stx       >$000A,U  ; save the current value in working storage
Code_35DF           rts                 ; return to the caller
Code_35E0           ldx       Addr_0006 ; load the value needed by the following operation
                    pshs      X         ; preserve the listed registers on the stack
                    leax      >$0066,U  ; form the referenced address without reading memory
                    leax      $03,X     ; form the referenced address without reading memory
                    stx       Addr_0006 ; save the current value in working storage
                    lbsr      Code_23F9 ; call the referenced helper routine
                    ldx       Addr_000C ; load the value needed by the following operation
Code_35F1           cmpx      ,S        ; compare against the limit and set condition flags
                    beq       Code_3623 ; branch when the compared values are equal
                    leax      $01,X     ; form the referenced address without reading memory
                    leay      $30DE,U   ; form the referenced address without reading memory
                    ldb       #$03      ; load the value needed by the following operation
Code_35FD           lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,Y+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bne       Code_35FD ; branch when the compared values differ
                    lbsr      Code_2496 ; call the referenced helper routine
                    lbsr      Code_136B ; call the referenced helper routine
                    lbsr      Code_215A ; call the referenced helper routine
                    ldy       Addr_0004 ; load the value needed by the following operation
                    ldx       Addr_000C ; load the value needed by the following operation
                    pshs      X         ; preserve the listed registers on the stack
                    leax      $30DE,U   ; form the referenced address without reading memory
                    lbsr      Code_21FC ; call the referenced helper routine
                    puls      X         ; restore the listed registers from the stack
                    leax      $04,X     ; form the referenced address without reading memory
                    stx       Addr_000C ; save the current value in working storage
                    bra       Code_35F1 ; continue at the selected control-flow target
Code_3623           leas      $02,S     ; form the referenced address without reading memory
                    lbsr      Code_22C6 ; call the referenced helper routine
                    lbsr      Code_23F9 ; call the referenced helper routine
                    lbsr      Code_392C ; call the referenced helper routine
                    rts                 ; return to the caller
Code_362F           pshs      X,B       ; preserve the listed registers on the stack
                    leax      $1351,U   ; form the referenced address without reading memory
Code_3635           ldb       ,X+       ; fetch the next value and advance the source pointer
                    cmpb      #$FF      ; compare against the limit and set condition flags
                    beq       Code_3644 ; branch when the compared values are equal
                    pshs      B         ; preserve the listed registers on the stack
                    cmpa      ,S+       ; compare against the limit and set condition flags
                    bne       Code_3635 ; branch when the compared values differ
                    clra                ; clear the selected byte or register
                    puls      PC,X,B    ; restore the listed registers from the stack
Code_3644           lda       #$01      ; load the value needed by the following operation
                    puls      PC,X,B    ; restore the listed registers from the stack
Code_3648           pshs      Y,X       ; preserve the listed registers on the stack
                    leay      $01,X     ; form the referenced address without reading memory
Code_364C           lda       ,Y        ; load the value needed by the following operation
                    lbsr      Code_05C8 ; call the referenced helper routine
                    bmi       Code_3657 ; branch while the tested value is negative
                    leay      $01,Y     ; form the referenced address without reading memory
                    bra       Code_364C ; continue at the selected control-flow target
Code_3657           lda       ,Y+       ; fetch the next value and advance the source pointer
                    sta       ,X+       ; store the value and advance the destination pointer
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    bne       Code_3657 ; branch when the compared values differ
                    puls      PC,Y,X    ; restore the listed registers from the stack
Code_3661           pshs      U,Y,X,D   ; preserve the listed registers on the stack
                    leax      $0BFD,U   ; form the referenced address without reading memory
Code_3667           lda       ,X        ; load the value needed by the following operation
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    beq       Code_3683 ; branch when the compared values are equal
                    anda      #$7F      ; mask off unwanted bits
                    bsr       Code_362F ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_3678 ; branch when the compared values are equal
                    bsr       Code_3648 ; call the referenced helper routine
                    bra       Code_3667 ; continue at the selected control-flow target
Code_3678           leax      $01,X     ; form the referenced address without reading memory
                    lda       ,X        ; load the value needed by the following operation
                    lbsr      Code_05C8 ; call the referenced helper routine
                    bmi       Code_3667 ; branch while the tested value is negative
                    bra       Code_3678 ; continue at the selected control-flow target
Code_3683           leax      $0BFD,U   ; form the referenced address without reading memory
                    lda       ,X        ; load the value needed by the following operation
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    bne       Code_3697 ; branch when the compared values differ
                    lda       $1351,U   ; load the value needed by the following operation
                    sta       ,X+       ; store the value and advance the destination pointer
                    lda       #$FF      ; load the value needed by the following operation
                    sta       ,X        ; save the current value in working storage
Code_3697           puls      PC,U,Y,X,D ; restore the listed registers from the stack
Code_3699           pshs      X         ; preserve the listed registers on the stack
                    ldb       #$0C      ; load the value needed by the following operation
Code_369D           lda       ,Y+       ; fetch the next value and advance the source pointer
                    cmpa      #$20      ; compare against the limit and set condition flags
                    beq       Code_36AA ; branch when the compared values are equal
Code_36A3           sta       ,U+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bne       Code_369D ; branch when the compared values differ
                    puls      PC,X      ; restore the listed registers from the stack
Code_36AA           lda       ,X+       ; fetch the next value and advance the source pointer
                    bra       Code_36A3 ; continue at the selected control-flow target
Code_36AE           pshs      B         ; preserve the listed registers on the stack
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       $3129,U   ; save the current value in working storage
                    ldy       Data_0055 ; load the value needed by the following operation
                    pshs      U         ; preserve the listed registers on the stack
                    leau      $312A,U   ; form the referenced address without reading memory
                    bsr       Code_3699 ; call the referenced helper routine
                    puls      U         ; restore the listed registers from the stack
                    leax      $0C,X     ; form the referenced address without reading memory
                    ldy       Data_0057 ; load the value needed by the following operation
                    cmpy      #DeskMateService ; compare against the limit and set condition flags
                    bne       Code_36D0 ; branch when the compared values differ
                    tfr       X,Y       ; copy the source register into the destination register
Code_36D0           pshs      U         ; preserve the listed registers on the stack
                    leau      $3136,U   ; form the referenced address without reading memory
                    bsr       Code_3699 ; call the referenced helper routine
                    puls      U         ; restore the listed registers from the stack
                    leax      $0C,X     ; form the referenced address without reading memory
                    pshs      X         ; preserve the listed registers on the stack
                    lda       #$03      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    ldb       #$40      ; load the value needed by the following operation
                    ldy       #Addr_000D ; load the value needed by the following operation
                    leax      $3129,U   ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $22       ; private DeskMate service selector
                    lda       #$01      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    inc       Addr_0010 ; advance the selected counter
                    lda       Addr_0010 ; load the value needed by the following operation
                    ldb       Addr_000F ; load the value needed by the following operation
                    addb      #$12      ; add the operand to the running value
                    stb       Addr_000F ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    ldb       #$27      ; load the value needed by the following operation
                    subb      Addr_000F ; subtract the operand from the running value
                    cmpb      #$0C      ; compare against the limit and set condition flags
                    bge       Code_3713 ; branch when the signed value is at least the limit
                    clra                ; clear the selected byte or register
                    tfr       D,Y       ; copy the source register into the destination register
                    bra       Code_3717 ; continue at the selected control-flow target
Code_3713           ldy       #Addr_000C ; load the value needed by the following operation
Code_3717           ldb       #$40      ; load the value needed by the following operation
                    leax      $3136,U   ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $22       ; private DeskMate service selector
                    puls      X         ; restore the listed registers from the stack
                    puls      PC,B      ; restore the listed registers from the stack
Code_3725           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    ldb       #$01      ; load the value needed by the following operation
                    stb       Addr_000F ; save the current value in working storage
                    lda       #$12      ; load the value needed by the following operation
                    sta       Addr_0010 ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    ldx       Data_0049 ; load the value needed by the following operation
                    pshs      X         ; preserve the listed registers on the stack
                    ldx       Data_004D ; load the value needed by the following operation
                    ldb       #$09      ; load the value needed by the following operation
Code_373D           lda       ,X        ; load the value needed by the following operation
                    bmi       Code_375F ; branch while the tested value is negative
                    stx       Data_004F ; save the current value in working storage
                    lbsr      Code_36AE ; call the referenced helper routine
                    decb                ; decrement the selected counter
                    beq       Code_375F ; branch when the compared values are equal
                    pshs      B         ; preserve the listed registers on the stack
                    lda       Addr_0010 ; load the value needed by the following operation
                    suba      #$03      ; subtract the operand from the running value
                    sta       Addr_0010 ; save the current value in working storage
                    ldb       Addr_000F ; load the value needed by the following operation
                    subb      #$11      ; subtract the operand from the running value
                    stb       Addr_000F ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    puls      B         ; restore the listed registers from the stack
                    bra       Code_373D ; continue at the selected control-flow target
Code_375F           puls      X         ; restore the listed registers from the stack
                    stx       Data_0049 ; save the current value in working storage
                    lbsr      Code_37E0 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_3767           leax      $1373,U   ; form the referenced address without reading memory
                    stx       Data_004D ; save the current value in working storage
                    tfr       X,Y       ; copy the source register into the destination register
                    lbsr      Code_23F9 ; call the referenced helper routine
                    ldx       Addr_000C ; load the value needed by the following operation
Code_3774           cmpx      Addr_0006 ; compare against the limit and set condition flags
                    beq       Code_37A8 ; branch when the compared values are equal
                    leax      $01,X     ; form the referenced address without reading memory
                    leay      $0BFD,U   ; form the referenced address without reading memory
                    lbsr      Code_21CE ; call the referenced helper routine
                    leax      $0BFD,U   ; form the referenced address without reading memory
                    ldy       Data_004D ; load the value needed by the following operation
                    lda       #$20      ; load the value needed by the following operation
                    sta       ,Y+       ; store the value and advance the destination pointer
                    lda       $1351,U   ; load the value needed by the following operation
                    bsr       Code_37BB ; call the referenced helper routine
                    leax      $0BFD,U   ; form the referenced address without reading memory
                    lda       $1352,U   ; load the value needed by the following operation
                    bsr       Code_37BB ; call the referenced helper routine
                    sty       Data_004D ; save the current value in working storage
                    ldx       Addr_000C ; load the value needed by the following operation
                    leax      $04,X     ; form the referenced address without reading memory
                    stx       Addr_000C ; save the current value in working storage
                    lbra      Code_3774 ; continue at the distant control-flow target
Code_37A8           sty       Data_004B ; save the current value in working storage
                    lda       #$FF      ; load the value needed by the following operation
                    sta       ,Y        ; save the current value in working storage
                    lbsr      Code_23F9 ; call the referenced helper routine
                    leax      $1373,U   ; form the referenced address without reading memory
                    stx       Data_004D ; save the current value in working storage
                    stx       Data_0049 ; save the current value in working storage
                    rts                 ; return to the caller
Code_37BB           ldb       #$0C      ; load the value needed by the following operation
                    pshs      B         ; preserve the listed registers on the stack
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    beq       Code_37D3 ; branch when the compared values are equal
                    lbsr      Code_20C2 ; call the referenced helper routine
                    tstb                ; set condition flags from the current value
                    bne       Code_37D3 ; branch when the compared values differ
Code_37C9           lda       ,X+       ; fetch the next value and advance the source pointer
                    bmi       Code_37D3 ; branch while the tested value is negative
                    sta       ,Y+       ; store the value and advance the destination pointer
                    dec       ,S        ; decrement the selected counter
                    bne       Code_37C9 ; branch when the compared values differ
Code_37D3           puls      B         ; restore the listed registers from the stack
                    lda       #$20      ; load the value needed by the following operation
Code_37D7           tstb                ; set condition flags from the current value
                    beq       Code_37DF ; branch when the compared values are equal
                    sta       ,Y+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bra       Code_37D7 ; continue at the selected control-flow target
Code_37DF           rts                 ; return to the caller
Code_37E0           clrb                ; clear the selected byte or register
Code_37E1           lbsr      Code_23EC ; call the referenced helper routine
                    beq       Code_381B ; branch when the compared values are equal
                    pshs      B         ; preserve the listed registers on the stack
                    lda       Addr_0012 ; load the value needed by the following operation
                    ldb       Addr_0011 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    puls      B         ; restore the listed registers from the stack
                    lda       #$03      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    ldx       Data_0049 ; load the value needed by the following operation
                    leax      $01,X     ; form the referenced address without reading memory
                    ldy       Data_0055 ; load the value needed by the following operation
                    pshs      U,B       ; preserve the listed registers on the stack
                    leau      $312A,U   ; form the referenced address without reading memory
                    lbsr      Code_3699 ; call the referenced helper routine
                    puls      U,B       ; restore the listed registers from the stack
                    leax      $312A,U   ; form the referenced address without reading memory
                    ldy       #Addr_000C ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $22       ; private DeskMate service selector
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
Code_381B           rts                 ; return to the caller
Code_381C           leax      >$0066,U  ; form the referenced address without reading memory
                    leax      $03,X     ; form the referenced address without reading memory
                    cmpx      Addr_000C ; compare against the limit and set condition flags
                    beq       Code_383D ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    ldb       #$40      ; load the value needed by the following operation
                    bsr       Code_37E1 ; call the referenced helper routine
                    lbsr      Code_386C ;382E: 17 00 3B       '.. ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    bmi       Code_383A ; branch while the tested value is negative
                    beq       Code_383A ; branch when the compared values are equal
                    lbsr      Code_3725 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_383A           clrb                ; clear the selected byte or register
                    bsr       Code_37E1 ; call the referenced helper routine
Code_383D           rts                 ; return to the caller
Code_383E           ldx       Addr_000C ; load the value needed by the following operation
                    leax      $04,X     ; form the referenced address without reading memory
                    cmpx      Addr_0006 ; compare against the limit and set condition flags
                    beq       Code_385C ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    ldb       #$40      ; load the value needed by the following operation
                    bsr       Code_37E1 ; call the referenced helper routine
                    bsr       Code_3891 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    bmi       Code_3859 ; branch while the tested value is negative
                    beq       Code_3859 ; branch when the compared values are equal
                    lbsr      Code_3725 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_3859           clrb                ; clear the selected byte or register
                    bsr       Code_37E1 ; call the referenced helper routine
Code_385C           rts                 ; return to the caller
Code_385D           ldx       Data_0049 ; load the value needed by the following operation
                    leax      -$19,X    ; form the referenced address without reading memory
Code_3862           stx       Data_0049 ; save the current value in working storage
                    rts                 ; return to the caller
Code_3865           ldx       Data_0049 ; load the value needed by the following operation
                    leax      $19,X     ; form the referenced address without reading memory
                    bra       Code_3862 ; continue at the selected control-flow target
Code_386C           lbsr      Code_23EC ; call the referenced helper routine
                    beq       Code_38B6 ; branch when the compared values are equal
                    lbsr      Code_2418 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    bne       Code_38B6 ; branch when the compared values differ
                    bsr       Code_385D ; call the referenced helper routine
                    cmpx      Data_004D ; compare against the limit and set condition flags
                    bge       Code_3889 ; branch when the signed value is at least the limit
                    stx       Data_004D ; save the current value in working storage
                    ldx       Data_004F ; load the value needed by the following operation
                    leax      -$19,X    ; form the referenced address without reading memory
                    stx       Data_004F ; save the current value in working storage
                    lda       #$01      ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_3889           dec       Addr_0011 ; decrement the selected counter
                    inc       Addr_0012 ; advance the selected counter
                    inc       Addr_0012 ; advance the selected counter
                    clra                ; clear the selected byte or register
                    rts                 ; return to the caller
Code_3891           lbsr      Code_23EC ; call the referenced helper routine
                    beq       Code_38B6 ; branch when the compared values are equal
                    lbsr      Code_2409 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    bne       Code_38B6 ; branch when the compared values differ
                    bsr       Code_3865 ; call the referenced helper routine
                    cmpx      Data_004F ; compare against the limit and set condition flags
                    ble       Code_38AE ; branch when the signed value is at or below the limit
                    stx       Data_004F ; save the current value in working storage
                    ldx       Data_004D ; load the value needed by the following operation
                    leax      $19,X     ; form the referenced address without reading memory
                    stx       Data_004D ; save the current value in working storage
                    lda       #$01      ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_38AE           inc       Addr_0011 ; advance the selected counter
                    dec       Addr_0012 ; decrement the selected counter
                    dec       Addr_0012 ; decrement the selected counter
                    clra                ; clear the selected byte or register
                    rts                 ; return to the caller
Code_38B6           lda       #$FF      ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_38B9           ldx       Addr_000C ; load the value needed by the following operation
                    leax      $04,X     ; form the referenced address without reading memory
                    cmpx      Addr_0006 ; compare against the limit and set condition flags
                    beq       Code_38F4 ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    ldb       #$40      ; load the value needed by the following operation
                    lbsr      Code_37E1 ; call the referenced helper routine
                    lda       Addr_0012 ; load the value needed by the following operation
                    cmpa      #$02      ; compare against the limit and set condition flags
                    bne       Code_38E5 ; branch when the compared values differ
                    lda       #$08      ; load the value needed by the following operation
                    pshs      A         ; preserve the listed registers on the stack
Code_38D4           lbsr      Code_3891 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    bmi       Code_38DE ; branch while the tested value is negative
                    dec       ,S        ; decrement the selected counter
                    bne       Code_38D4 ; branch when the compared values differ
Code_38DE           leas      $01,S     ; form the referenced address without reading memory
                    lbsr      Code_3725 ; call the referenced helper routine
                    bra       Code_38F1 ; continue at the selected control-flow target
Code_38E5           lbsr      Code_3891 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    bmi       Code_38F1 ; branch while the tested value is negative
                    lda       Addr_0012 ; load the value needed by the following operation
                    cmpa      #$02      ; compare against the limit and set condition flags
                    bne       Code_38E5 ; branch when the compared values differ
Code_38F1           lbsr      Code_37E0 ; call the referenced helper routine
Code_38F4           rts                 ; return to the caller
Code_38F5           leax      >$0066,U  ; form the referenced address without reading memory
                    leax      $03,X     ; form the referenced address without reading memory
                    cmpx      Addr_000C ; compare against the limit and set condition flags
                    beq       Code_38F4 ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    ldb       #$40      ; load the value needed by the following operation
                    lbsr      Code_37E1 ; call the referenced helper routine
                    lda       Addr_0012 ; load the value needed by the following operation
                    cmpa      #$12      ; compare against the limit and set condition flags
                    bne       Code_391E ; branch when the compared values differ
                    lda       #$08      ; load the value needed by the following operation
                    pshs      A         ; preserve the listed registers on the stack
Code_3912           lbsr      Code_386C ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    bmi       Code_391C ; branch while the tested value is negative
                    dec       ,S        ; decrement the selected counter
                    bne       Code_3912 ; branch when the compared values differ
Code_391C           bra       Code_38DE ; continue at the selected control-flow target
Code_391E           lbsr      Code_386C ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    bmi       Code_38F1 ; branch while the tested value is negative
                    lda       Addr_0012 ; load the value needed by the following operation
                    cmpa      #$12      ; compare against the limit and set condition flags
                    bne       Code_391E ; branch when the compared values differ
                    bra       Code_38F1 ; continue at the selected control-flow target
Code_392C           ldx       Addr_000C ; load the value needed by the following operation
                    pshs      X         ; preserve the listed registers on the stack
                    lbsr      Code_23F9 ; call the referenced helper routine
                    leax      $1373,U   ; form the referenced address without reading memory
                    stx       Data_0049 ; save the current value in working storage
                    ldy       Addr_000C ; load the value needed by the following operation
Code_393C           cmpy      ,S        ; compare against the limit and set condition flags
                    beq       Code_3948 ; branch when the compared values are equal
                    leay      $04,Y     ; form the referenced address without reading memory
                    lbsr      Code_3865 ; call the referenced helper routine
                    bra       Code_393C ; continue at the selected control-flow target
Code_3948           puls      Y         ; restore the listed registers from the stack
                    sty       Addr_000C ; save the current value in working storage
                    leax      $1373,U   ; form the referenced address without reading memory
                    pshs      X         ; preserve the listed registers on the stack
                    ldx       Data_0049 ; load the value needed by the following operation
                    leay      $00C8,X   ; form the referenced address without reading memory
Code_3959           cmpy      Data_004B ; compare against the limit and set condition flags
                    blt       Code_3970 ; branch when the signed value is below the limit
                    cmpx      ,S        ; compare against the limit and set condition flags
                    beq       Code_396A ; branch when the compared values are equal
                    leax      -$19,X    ; form the referenced address without reading memory
                    leay      -$19,Y    ; form the referenced address without reading memory
                    bra       Code_3959 ; continue at the selected control-flow target
Code_396A           ldy       Data_004B ; load the value needed by the following operation
                    leay      -$19,Y    ; form the referenced address without reading memory
Code_3970           leas      $02,S     ; form the referenced address without reading memory
                    stx       Data_004D ; save the current value in working storage
                    sty       Data_004F ; save the current value in working storage
                    lda       #$12      ; load the value needed by the following operation
                    sta       Addr_0012 ; save the current value in working storage
                    lda       #$02      ; load the value needed by the following operation
                    sta       Addr_0011 ; save the current value in working storage
                    ldx       Data_004D ; load the value needed by the following operation
Code_3981           cmpx      Data_0049 ; compare against the limit and set condition flags
                    beq       Code_3990 ; branch when the compared values are equal
                    leax      $19,X     ; form the referenced address without reading memory
                    dec       Addr_0012 ; decrement the selected counter
                    dec       Addr_0012 ; decrement the selected counter
                    inc       Addr_0011 ; advance the selected counter
                    bra       Code_3981 ; continue at the selected control-flow target
Code_3990           rts                 ; return to the caller
Code_3991           leax      $088B,U   ; form the referenced address without reading memory
                    ldy       Data_0049 ; load the value needed by the following operation
                    lda       #$20      ; load the value needed by the following operation
                    sta       ,Y+       ; store the value and advance the destination pointer
                    lda       $1351,U   ; load the value needed by the following operation
                    lbsr      Code_37BB ; call the referenced helper routine
                    leax      $088B,U   ; form the referenced address without reading memory
                    lda       $1352,U   ; load the value needed by the following operation
                    lbsr      Code_37BB ; call the referenced helper routine
                    rts                 ; return to the caller
Code_39AF           lbsr      Code_392C ; call the referenced helper routine
                    ldd       Data_0049 ; load the value needed by the following operation
                    cmpd      Data_004B ; compare against the limit and set condition flags
                    beq       Code_39D7 ; branch when the compared values are equal
                    pshs      D         ; preserve the listed registers on the stack
                    ldx       Data_004B ; load the value needed by the following operation
                    leay      $19,X     ; form the referenced address without reading memory
                    sty       Data_004B ; save the current value in working storage
Code_39C3           lda       ,-X       ; load the value needed by the following operation
                    sta       ,-Y       ; save the current value in working storage
                    cmpx      ,S        ; compare against the limit and set condition flags
                    bne       Code_39C3 ; branch when the compared values differ
                    leas      $02,S     ; form the referenced address without reading memory
Code_39CD           lbsr      Code_3991 ; call the referenced helper routine
                    ldx       Data_004B ; load the value needed by the following operation
                    lda       #$FF      ; load the value needed by the following operation
                    sta       ,X        ; save the current value in working storage
                    rts                 ; return to the caller
Code_39D7           addd      #Addr_0019 ; add the operand to the running value
                    std       Data_004B ; save the current value in working storage
                    bra       Code_39CD ; continue at the selected control-flow target
Code_39DE           ldx       Data_0049 ; load the value needed by the following operation
                    leay      $19,X     ; form the referenced address without reading memory
Code_39E3           cmpy      Data_004B ; compare against the limit and set condition flags
                    beq       Code_39EE ; branch when the compared values are equal
                    lda       ,Y+       ; fetch the next value and advance the source pointer
                    sta       ,X+       ; store the value and advance the destination pointer
                    bra       Code_39E3 ; continue at the selected control-flow target
Code_39EE           stx       Data_004B ; save the current value in working storage
                    lda       #$FF      ; load the value needed by the following operation
                    sta       ,X        ; save the current value in working storage
                    rts                 ; return to the caller
Code_39F5           lda       ,X        ; load the value needed by the following operation
                    bmi       Code_3A05 ; branch while the tested value is negative
                    cmpa      #$2A      ; compare against the limit and set condition flags
                    beq       Code_3A04 ; branch when the compared values are equal
                    leax      $19,X     ; form the referenced address without reading memory
                    leay      $04,Y     ; form the referenced address without reading memory
                    bra       Code_39F5 ; continue at the selected control-flow target
Code_3A04           clra                ; clear the selected byte or register
Code_3A05           rts                 ; return to the caller
Code_3A06           lda       #$20      ; load the value needed by the following operation
                    bra       Code_3A0C ; continue at the selected control-flow target
Code_3A0A           lda       #$2A      ; load the value needed by the following operation
Code_3A0C           ldx       Data_0049 ; load the value needed by the following operation
                    sta       ,X        ; save the current value in working storage
                    rts                 ; return to the caller
Code_3A11           lda       #$20      ; load the value needed by the following operation
                    leax      $1373,U   ; form the referenced address without reading memory
Code_3A17           tst       ,X        ; set condition flags from the current value
                    bmi       Code_3A22 ; branch while the tested value is negative
                    sta       ,X        ; save the current value in working storage
                    leax      $19,X     ; form the referenced address without reading memory
                    bra       Code_3A17 ; continue at the selected control-flow target
Code_3A22           rts                 ; return to the caller
Code_3A23           lda       $1351,U   ; load the value needed by the following operation
                    bsr       Code_3A3D ; call the referenced helper routine
                    stx       Data_0055 ; save the current value in working storage
                    lda       $1352,U   ; load the value needed by the following operation
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    beq       Code_3A38 ; branch when the compared values are equal
                    bsr       Code_3A3D ; call the referenced helper routine
Code_3A35           stx       Data_0057 ; save the current value in working storage
                    rts                 ; return to the caller
Code_3A38           ldx       #DeskMateService ; load the value needed by the following operation
                    bra       Code_3A35 ; continue at the selected control-flow target
Code_3A3D           pshs      A         ; preserve the listed registers on the stack
                    leax      $0519,U   ; form the referenced address without reading memory
Code_3A43           lda       ,X        ; load the value needed by the following operation
                    anda      #$7F      ; mask off unwanted bits
                    cmpa      ,S        ; compare against the limit and set condition flags
                    beq       Code_3A52 ; branch when the compared values are equal
                    lda       Data_0041 ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    leax      A,X       ; form the referenced address without reading memory
                    bra       Code_3A43 ; continue at the selected control-flow target
Code_3A52           leax      $0F,X     ; form the referenced address without reading memory
                    puls      PC,A      ; restore the listed registers from the stack
Code_3A56           cmpb      ,X        ; compare against the limit and set condition flags
                    blt       Code_3A69 ; branch when the signed value is below the limit
                    cmpb      $01,X     ; compare against the limit and set condition flags
                    bgt       Code_3A69 ; branch when the signed value is above the limit
                    cmpa      $02,X     ; compare against the limit and set condition flags
                    blt       Code_3A69 ; branch when the signed value is below the limit
                    cmpa      $03,X     ; compare against the limit and set condition flags
                    bgt       Code_3A69 ; branch when the signed value is above the limit
Code_3A66           ldb       $04,X     ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_3A69           leax      $05,X     ; form the referenced address without reading memory
                    tst       ,X        ; set condition flags from the current value
                    bmi       Code_3A66 ; branch while the tested value is negative
                    bra       Code_3A56 ; continue at the selected control-flow target
Code_3A71           pshs      Y,X       ; preserve the listed registers on the stack
                    pshs      U         ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $19       ; private DeskMate service selector
                    tfr       U,X       ; copy the source register into the destination register
                    puls      U         ; restore the listed registers from the stack
                    stx       Addr_0013 ; save the current value in working storage
                    puls      Y,X       ; restore the listed registers from the stack
                    rts                 ; return to the caller
Data_3A82           fcb       $00,$07,$00,$01,$00,$08 ; table, bitmap, or initialized data bytes
                    fcb       $12,$00,$01,$01 ; table, bitmap, or initialized data bytes
                    fcc       "6:"                           ; embedded text or resource bytes
                    fcb       $00,$01,$02 ; table, bitmap, or initialized data bytes
                    fcc       ";?"                     ;3A91: 3B 3F          ' ; embedded text or resource bytes
                    fcb       $00,$01,$03 ; table, bitmap, or initialized data bytes
                    fcc       "@D"                           ; embedded text or resource bytes
                    fcb       $00,$01,$04 ; table, bitmap, or initialized data bytes
                    fcc       "EI"                           ; embedded text or resource bytes
                    fcb       $00,$01,$07,$FF,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$0F   ; table, bitmap, or initialized data bytes
Code_3AA5           lbsr      Code_3A71 ; call the referenced helper routine
                    cmpb      #$01      ; compare against the limit and set condition flags
                    beq       Code_3AC7 ; branch when the compared values are equal
                    pshs      B         ; preserve the listed registers on the stack
                    ldd       Addr_0013 ; load the value needed by the following operation
                    leax      >Data_3A82,PCR ; form the referenced address without reading memory
                    lbsr      Code_3A56 ; call the referenced helper routine
                    cmpb      #$0F      ; compare against the limit and set condition flags
                    beq       Code_3AC1 ; branch when the compared values are equal
                    lbsr      Code_3D5C ; call the referenced helper routine
                    puls      A         ; restore the listed registers from the stack
                    rts                 ; return to the caller
Code_3AC1           lbsr      Code_3DA9 ; call the referenced helper routine
                    puls      A         ; restore the listed registers from the stack
                    rts                 ; return to the caller
Code_3AC7           lbsr      Code_3C03 ; call the referenced helper routine
                    rts                 ; return to the caller
Data_3ACB           fcb       $00,$07,$00,$01,$00,$08 ; table, bitmap, or initialized data bytes
                    fcb       $12,$00,$01,$01 ; table, bitmap, or initialized data bytes
                    fcc       "6:"                           ; embedded text or resource bytes
                    fcb       $00,$01,$02 ; table, bitmap, or initialized data bytes
                    fcc       ";?"                     ;3ADA: 3B 3F          ' ; embedded text or resource bytes
                    fcb       $00,$01,$05 ; table, bitmap, or initialized data bytes
                    fcc       "@D"                           ; embedded text or resource bytes
                    fcb       $00,$01,$06,$FF,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$0F   ; table, bitmap, or initialized data bytes
Code_3AE9           lbsr      Code_3A71 ; call the referenced helper routine
                    cmpb      #$01      ; compare against the limit and set condition flags
                    beq       Code_3B09 ; branch when the compared values are equal
                    pshs      Y,X,B     ; preserve the listed registers on the stack
                    ldd       Addr_0013 ; load the value needed by the following operation
                    leax      >Data_3ACB,PCR ; form the referenced address without reading memory
                    lbsr      Code_3A56 ; call the referenced helper routine
                    cmpb      #$0F      ; compare against the limit and set condition flags
                    bge       Code_3B04 ; branch when the signed value is at least the limit
                    lbsr      Code_3D5C ; call the referenced helper routine
                    puls      PC,Y,X,A  ; restore the listed registers from the stack
Code_3B04           lbsr      Code_3DA9 ; call the referenced helper routine
                    puls      PC,Y,X,A  ; restore the listed registers from the stack
Code_3B09           ldd       Addr_0013 ; load the value needed by the following operation
                    cmpa      #$02      ; compare against the limit and set condition flags
                    blt       Code_3B16 ; branch when the signed value is below the limit
                    clr       Code_0033 ; clear the selected byte or register
                    lbsr      Code_3C74 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    rts                 ; return to the caller
Code_3B16           lda       #$01      ; load the value needed by the following operation
                    rts                 ; return to the caller
Data_3B19           fcb       $00,$0D,$00,$01,$08 ; table, bitmap, or initialized data bytes
                    fcc       "6:"                           ; embedded text or resource bytes
                    fcb       $00,$01,$02,$FF,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$0F   ; table, bitmap, or initialized data bytes
Code_3B28           lbsr      Code_3A71 ; call the referenced helper routine
                    cmpb      #$01      ; compare against the limit and set condition flags
                    beq       Code_3B09 ; branch when the compared values are equal
                    pshs      Y,X       ; preserve the listed registers on the stack
                    leax      >Data_3B19,PCR ; form the referenced address without reading memory
Code_3B35           ldd       Addr_0013 ; load the value needed by the following operation
                    lbsr      Code_3A56 ; call the referenced helper routine
                    cmpb      #$0F      ; compare against the limit and set condition flags
                    bge       Code_3B44 ; branch when the signed value is at least the limit
                    lbsr      Code_3D5C ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    puls      PC,Y,X    ; restore the listed registers from the stack
Code_3B44           lbsr      Code_3DA9 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    puls      PC,Y,X    ; restore the listed registers from the stack
Code_3B4A           lbsr      Code_3A71 ; call the referenced helper routine
                    cmpb      #$01      ; compare against the limit and set condition flags
                    beq       Code_3B6C ; branch when the compared values are equal
Code_3B51           pshs      Y,X       ; preserve the listed registers on the stack
                    ldd       Addr_0013 ; load the value needed by the following operation
                    leax      >Data_3B19,PCR ; form the referenced address without reading memory
                    lbsr      Code_3A56 ; call the referenced helper routine
                    cmpb      #$0F      ; compare against the limit and set condition flags
                    bge       Code_3B67 ; branch when the signed value is at least the limit
                    lbsr      Code_3D5C ; call the referenced helper routine
Code_3B63           clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    puls      PC,Y,X    ; restore the listed registers from the stack
Code_3B67           lbsr      Code_3DA9 ; call the referenced helper routine
                    bra       Code_3B63 ; continue at the selected control-flow target
Code_3B6C           ldd       Addr_0013 ; load the value needed by the following operation
                    cmpa      Addr_0015 ; compare against the limit and set condition flags
                    bge       Code_3B96 ; branch when the signed value is at least the limit
                    bsr       Code_3B99 ; call the referenced helper routine
                    ldd       Addr_0013 ; load the value needed by the following operation
                    cmpa      #$02      ; compare against the limit and set condition flags
                    blt       Code_3B83 ; branch when the signed value is below the limit
                    sta       Code_0033 ; save the current value in working storage
                    lbsr      Code_3C74 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    ldb       #$01      ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_3B83           tst       $0519,U   ; set condition flags from the current value
                    bmi       Code_3B91 ; branch while the tested value is negative
                    clr       Addr_001C ; clear the selected byte or register
                    lbsr      Code_260B ; call the referenced helper routine
                    lbsr      Code_25F9 ; call the referenced helper routine
Code_3B91           lda       #$01      ; load the value needed by the following operation
                    ldb       #$01      ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_3B96           clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    rts                 ; return to the caller
Code_3B99           ldx       Code_002D ; load the value needed by the following operation
                    stx       Data_0044 ; save the current value in working storage
                    lda       #$FF      ; load the value needed by the following operation
                    sta       ,X        ; save the current value in working storage
                    clr       Addr_000F ; clear the selected byte or register
                    lda       Addr_0015 ; load the value needed by the following operation
                    sta       Addr_0010 ; save the current value in working storage
                    lbsr      Code_098D ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1B       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       ":"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "@"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Data_3BBB           fcb       $00,$0D,$00,$01,$09 ; table, bitmap, or initialized data bytes
                    fcc       "6:"                           ; embedded text or resource bytes
                    fcb       $00,$01,$02,$FF,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$0F   ; table, bitmap, or initialized data bytes
Code_3BCA           lbsr      Code_3A71 ; call the referenced helper routine
                    cmpb      #$01      ; compare against the limit and set condition flags
                    lbeq      Code_3B09 ; take the distant branch when values are equal
                    pshs      Y,X       ; preserve the listed registers on the stack
                    leax      >Data_3BBB,PCR ; form the referenced address without reading memory
                    lbra      Code_3B35 ; continue at the distant control-flow target
Data_3BDC           fcb       $00,$0C,$00,$01,$0A ; table, bitmap, or initialized data bytes
                    fcc       "6:"                           ; embedded text or resource bytes
                    fcb       $00,$01,$02,$FF,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$0F   ; table, bitmap, or initialized data bytes
Code_3BEB           lbsr      Code_3A71 ; call the referenced helper routine
                    cmpb      #$01      ; compare against the limit and set condition flags
                    lbeq      Code_3B09 ; take the distant branch when values are equal
                    pshs      Y,X       ; preserve the listed registers on the stack
                    leax      >Data_3BDC,PCR ; form the referenced address without reading memory
                    lbra      Code_3B35 ; continue at the distant control-flow target
Code_3BFD           lda       #$01      ; load the value needed by the following operation
                    sta       Addr_0035 ; save the current value in working storage
                    bra       Code_3C05 ; continue at the selected control-flow target
Code_3C03           clr       Addr_0035 ; clear the selected byte or register
Code_3C05           ldd       Addr_0013 ; load the value needed by the following operation
                    cmpa      #$02      ; compare against the limit and set condition flags
                    blt       Code_3C55 ; branch when the signed value is below the limit
                    cmpa      #$13      ; compare against the limit and set condition flags
                    bgt       Code_3C55 ; branch when the signed value is above the limit
                    bita      #$01      ; test the selected flag bits without changing the value
                    beq       Code_3C14 ; branch when the compared values are equal
                    deca                ; decrement the selected counter
Code_3C14           cmpa      Addr_0012 ; compare against the limit and set condition flags
                    bgt       Code_3C58 ; branch when the signed value is above the limit
                    beq       Code_3C72 ; branch when the compared values are equal
                    pshs      A         ; preserve the listed registers on the stack
                    lda       Addr_0011 ; load the value needed by the following operation
                    ldb       Addr_0012 ; load the value needed by the following operation
                    ldx       Addr_000C ; load the value needed by the following operation
                    ldy       Data_0049 ; load the value needed by the following operation
                    pshs      Y,X,D     ; preserve the listed registers on the stack
                    ldb       #$40      ; load the value needed by the following operation
                    lbsr      Code_37E1 ; call the referenced helper routine
Code_3C2C           lbsr      Code_3891 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    bmi       Code_3C44 ; branch while the tested value is negative
                    lda       Addr_0012 ; load the value needed by the following operation
                    cmpa      $06,S     ; compare against the limit and set condition flags
                    bne       Code_3C2C ; branch when the compared values differ
                    tst       Addr_0035 ; set condition flags from the current value
                    bne       Code_3C40 ; branch when the compared values differ
                    clrb                ; clear the selected byte or register
                    lbsr      Code_37E1 ; call the referenced helper routine
Code_3C40           leas      $07,S     ; form the referenced address without reading memory
                    bra       Code_3C72 ; continue at the selected control-flow target
Code_3C44           puls      Y,X,D     ; restore the listed registers from the stack
                    sta       Addr_0011 ; save the current value in working storage
                    stb       Addr_0012 ; save the current value in working storage
                    stx       Addr_000C ; save the current value in working storage
                    sty       Data_0049 ; save the current value in working storage
                    leas      $01,S     ; form the referenced address without reading memory
                    clrb                ; clear the selected byte or register
                    lbsr      Code_37E1 ; call the referenced helper routine
Code_3C55           lda       #$01      ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_3C58           pshs      A         ; preserve the listed registers on the stack
                    ldb       #$40      ; load the value needed by the following operation
                    lbsr      Code_37E1 ; call the referenced helper routine
Code_3C5F           lbsr      Code_386C ; call the referenced helper routine
                    lda       Addr_0012 ; load the value needed by the following operation
                    cmpa      ,S        ; compare against the limit and set condition flags
                    bne       Code_3C5F ; branch when the compared values differ
                    tst       Addr_0035 ; set condition flags from the current value
                    bne       Code_3C70 ; branch when the compared values differ
                    clrb                ; clear the selected byte or register
                    lbsr      Code_37E1 ; call the referenced helper routine
Code_3C70           leas      $01,S     ; form the referenced address without reading memory
Code_3C72           clra                ; clear the selected byte or register
                    rts                 ; return to the caller
Code_3C74           pshs      Y,X       ; preserve the listed registers on the stack
                    cmpa      Addr_0015 ; compare against the limit and set condition flags
                    lbge      Code_3CEB ; take the distant branch for signed greater-or-equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1B       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    lbsr      Code_14CB ; call the referenced helper routine
                    pshs      B         ; preserve the listed registers on the stack
                    leay      $12E1,U   ; form the referenced address without reading memory
Code_3C8D           cmpa      ,Y        ; compare against the limit and set condition flags
                    blt       Code_3C99 ; branch when the signed value is below the limit
                    leay      $05,Y     ; form the referenced address without reading memory
                    ldb       ,Y        ; load the value needed by the following operation
                    cmpb      #$FF      ; compare against the limit and set condition flags
                    bne       Code_3C8D ; branch when the compared values differ
Code_3C99           leay      -$05,Y    ;3C99: 31 3B          '1 ; form the referenced address without reading memory
                    puls      B         ; restore the listed registers from the stack
                    cmpa      ,Y        ; compare against the limit and set condition flags
                    bgt       Code_3CF8 ; branch when the signed value is above the limit
                    cmpb      #$1A      ; compare against the limit and set condition flags
                    bge       Code_3CF8 ; branch when the signed value is at least the limit
                    tst       Addr_0027 ; set condition flags from the current value
                    beq       Code_3CEB ; branch when the compared values are equal
                    leas      $04,S     ; form the referenced address without reading memory
                    tst       Code_0033 ; set condition flags from the current value
                    bne       Code_3CC6 ; branch when the compared values differ
                    cmpy      Data_0051 ; compare against the limit and set condition flags
                    bne       Code_3CC6 ; branch when the compared values differ
                    tst       Addr_001C ; set condition flags from the current value
                    bne       Code_3CC6 ; branch when the compared values differ
                    lbsr      Code_25AA ; call the referenced helper routine
                    leax      -$0D,X    ; form the referenced address without reading memory
                    leay      -$0D,Y    ; form the referenced address without reading memory
                    clr       Addr_000F ; clear the selected byte or register
                    lbsr      Code_098D ; call the referenced helper routine
                    bra       Code_3CD2 ; continue at the selected control-flow target
Code_3CC6           bsr       Code_3CED ; call the referenced helper routine
                    sty       Data_0051 ; save the current value in working storage
                    pshs      B         ; preserve the listed registers on the stack
                    lbsr      Code_257B ; call the referenced helper routine
                    puls      B         ; restore the listed registers from the stack
Code_3CD2           lsrb                ; shift right and expose the low bit through carry
Code_3CD3           cmpb      Addr_000F ; compare against the limit and set condition flags
                    beq       Code_3CE5 ; branch when the compared values are equal
                    lda       #$0B      ; load the value needed by the following operation
                    cmpa      Addr_000F ; compare against the limit and set condition flags
                    beq       Code_3CE5 ; branch when the compared values are equal
                    inc       Addr_000F ; advance the selected counter
                    leax      $01,X     ; form the referenced address without reading memory
                    leay      $01,Y     ; form the referenced address without reading memory
                    bra       Code_3CD3 ; continue at the selected control-flow target
Code_3CE5           lbsr      Code_098D ; call the referenced helper routine
                    clr       Addr_001C ; clear the selected byte or register
                    rts                 ; return to the caller
Code_3CEB           puls      PC,Y,X    ; restore the listed registers from the stack
Code_3CED           pshs      Y,X,D     ; preserve the listed registers on the stack
                    tst       Code_0033 ; set condition flags from the current value
                    bne       Code_3CF6 ; branch when the compared values differ
                    lbsr      Code_2501 ; call the referenced helper routine
Code_3CF6           puls      PC,Y,X,D  ; restore the listed registers from the stack
Code_3CF8           leas      $04,S     ; form the referenced address without reading memory
                    tst       Code_0033 ; set condition flags from the current value
                    bne       Code_3D19 ; branch when the compared values differ
                    cmpy      Data_0051 ; compare against the limit and set condition flags
                    bne       Code_3D19 ; branch when the compared values differ
                    tst       Addr_001C ; set condition flags from the current value
                    beq       Code_3D19 ; branch when the compared values are equal
                    pshs      A         ; preserve the listed registers on the stack
                    lbsr      Code_25AA ; call the referenced helper routine
                    puls      A         ; restore the listed registers from the stack
                    leax      $01,X     ; form the referenced address without reading memory
                    leay      $01,Y     ; form the referenced address without reading memory
                    inc       Addr_000F ; advance the selected counter
                    lbsr      Code_098D ; call the referenced helper routine
                    bra       Code_3D2A ; continue at the selected control-flow target
Code_3D19           lbsr      Code_3CED ; call the referenced helper routine
                    sty       Data_0051 ; save the current value in working storage
                    pshs      D         ; preserve the listed registers on the stack
                    lda       #$01      ; load the value needed by the following operation
                    sta       Addr_001C ; save the current value in working storage
                    lbsr      Code_250D ; call the referenced helper routine
                    puls      D         ; restore the listed registers from the stack
Code_3D2A           cmpa      Addr_0010 ; compare against the limit and set condition flags
                    beq       Code_3D32 ; branch when the compared values are equal
                    bsr       Code_3D3F ; call the referenced helper routine
                    bra       Code_3D2A ; continue at the selected control-flow target
Code_3D32           lsrb                ; shift right and expose the low bit through carry
Code_3D33           cmpb      Addr_000F ; compare against the limit and set condition flags
                    ble       Code_3D3B ; branch when the signed value is at or below the limit
                    bsr       Code_3D3F ; call the referenced helper routine
                    bra       Code_3D33 ; continue at the selected control-flow target
Code_3D3B           lbsr      Code_098D ; call the referenced helper routine
                    rts                 ; return to the caller
Code_3D3F           pshs      D         ; preserve the listed registers on the stack
                    leax      $01,X     ; form the referenced address without reading memory
                    leay      $01,Y     ; form the referenced address without reading memory
                    lda       Data_0041 ; load the value needed by the following operation
                    deca                ; decrement the selected counter
                    cmpa      Addr_000F ; compare against the limit and set condition flags
                    beq       Code_3D50 ; branch when the compared values are equal
                    inc       Addr_000F ; advance the selected counter
                    puls      PC,D      ; restore the listed registers from the stack
Code_3D50           inc       Addr_0010 ; advance the selected counter
                    lda       #$02      ; load the value needed by the following operation
                    sta       Addr_000F ; save the current value in working storage
                    leax      $03,X     ; form the referenced address without reading memory
                    leay      $03,Y     ; form the referenced address without reading memory
                    puls      PC,D      ; restore the listed registers from the stack
Code_3D5C           cmpb      Addr_0026 ; compare against the limit and set condition flags
                    bne       Code_3D61 ; branch when the compared values differ
                    rts                 ; return to the caller
Code_3D61           pshs      D         ; preserve the listed registers on the stack
                    lbsr      Code_3DA9 ; call the referenced helper routine
                    puls      D         ; restore the listed registers from the stack
                    stb       Addr_0026 ; save the current value in working storage
                    cmpb      #$00      ; compare against the limit and set condition flags
                    lbeq      Code_2ABD ; take the distant branch when values are equal
                    cmpb      #$01      ; compare against the limit and set condition flags
                    lbeq      Code_2ACE ; take the distant branch when values are equal
                    cmpb      #$02      ; compare against the limit and set condition flags
                    lbeq      Code_2A05 ; take the distant branch when values are equal
                    cmpb      #$03      ; compare against the limit and set condition flags
                    lbeq      Code_2A28 ; take the distant branch when values are equal
                    cmpb      #$04      ; compare against the limit and set condition flags
                    lbeq      Code_2A40 ; take the distant branch when values are equal
                    cmpb      #$05      ; compare against the limit and set condition flags
                    lbeq      Code_2A28 ; take the distant branch when values are equal
                    cmpb      #$06      ; compare against the limit and set condition flags
                    lbeq      Code_2A40 ; take the distant branch when values are equal
                    cmpb      #$07      ; compare against the limit and set condition flags
                    lbeq      Code_2A75 ; take the distant branch when values are equal
                    cmpb      #$08      ; compare against the limit and set condition flags
                    lbeq      Code_2AE3 ; take the distant branch when values are equal
                    cmpb      #$09      ; compare against the limit and set condition flags
                    lbeq      Code_2AF5 ; take the distant branch when values are equal
                    lbra      Code_2B07 ; continue at the distant control-flow target
Code_3DA9           ldb       Addr_0026 ; load the value needed by the following operation
                    cmpb      #$FF      ; compare against the limit and set condition flags
                    bne       Code_3DB0 ; branch when the compared values differ
                    rts                 ; return to the caller
Code_3DB0           lda       #$FF      ; load the value needed by the following operation
                    sta       Addr_0026 ; save the current value in working storage
                    cmpb      #$00      ; compare against the limit and set condition flags
                    lbeq      Code_2AB8 ; take the distant branch when values are equal
                    cmpb      #$01      ; compare against the limit and set condition flags
                    lbeq      Code_2AC9 ; take the distant branch when values are equal
                    cmpb      #$02      ; compare against the limit and set condition flags
                    lbeq      Code_2A09 ; take the distant branch when values are equal
                    cmpb      #$03      ; compare against the limit and set condition flags
                    lbeq      Code_2A2C ; take the distant branch when values are equal
                    cmpb      #$04      ; compare against the limit and set condition flags
                    lbeq      Code_2A44 ; take the distant branch when values are equal
                    cmpb      #$05      ; compare against the limit and set condition flags
                    lbeq      Code_2A2C ; take the distant branch when values are equal
                    cmpb      #$06      ; compare against the limit and set condition flags
                    lbeq      Code_2A44 ; take the distant branch when values are equal
                    cmpb      #$07      ; compare against the limit and set condition flags
                    lbeq      Code_2A79 ; take the distant branch when values are equal
                    cmpb      #$08      ; compare against the limit and set condition flags
                    lbeq      Code_2ADE ; take the distant branch when values are equal
                    cmpb      #$09      ; compare against the limit and set condition flags
                    lbeq      Code_2AF0 ; take the distant branch when values are equal
                    lbra      Code_2B02 ; continue at the distant control-flow target
Code_3DF3           lbsr      Code_3A71 ; call the referenced helper routine
                    pshs      B         ; preserve the listed registers on the stack
                    lbsr      Code_3B51 ; call the referenced helper routine
                    puls      B         ; restore the listed registers from the stack
                    cmpb      #$01      ; compare against the limit and set condition flags
                    bne       Code_3E25 ; branch when the compared values differ
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1B       ; private DeskMate service selector
                    ldd       Addr_0013 ; load the value needed by the following operation
                    cmpa      Addr_0015 ; compare against the limit and set condition flags
                    bge       Code_3E25 ; branch when the signed value is at least the limit
                    cmpa      #$01      ; compare against the limit and set condition flags
                    ble       Code_3E27 ; branch when the signed value is at or below the limit
                    leax      $12E1,U   ; form the referenced address without reading memory
Code_3E13           cmpa      ,X        ; compare against the limit and set condition flags
                    bcs       Code_3E1B ; branch when carry reports an unsigned underflow or error
                    leax      $05,X     ; form the referenced address without reading memory
                    bra       Code_3E13 ; continue at the selected control-flow target
Code_3E1B           leax      -$05,X    ; form the referenced address without reading memory
                    stx       Data_0051 ; save the current value in working storage
                    lbsr      Code_25AA ; call the referenced helper routine
                    lbsr      Code_098D ; call the referenced helper routine
Code_3E25           clrb                ; clear the selected byte or register
                    rts                 ; return to the caller
Code_3E27           ldb       #$01      ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_3E2A           pshs      U,Y,X,DP,D ; preserve the listed registers on the stack
                    bsr       Code_3E9C ; call the referenced helper routine
                    lda       ,S        ; load the value needed by the following operation
                    sta       Addr_0013 ; save the current value in working storage
                    leay      $0A,U     ; form the referenced address without reading memory
                    ldb       #$07      ; load the value needed by the following operation
Code_3E36           lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,Y+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bgt       Code_3E36 ; branch when the signed value is above the limit
                    clr       Addr_0018 ; clear the selected byte or register
                    clr       Addr_0019 ; clear the selected byte or register
                    clr       Addr_0015 ; clear the selected byte or register
                    clr       Addr_001A ; clear the selected byte or register
                    ldb       Addr_000E ; load the value needed by the following operation
                    cmpb      Addr_000C ; compare against the limit and set condition flags
                    bls       Code_3E53 ; branch when the unsigned value is at or below the limit
                    com       Addr_0015 ; invert every bit in the selected value
                    dec       Addr_000C ; decrement the selected counter
                    dec       Addr_000C ; decrement the selected counter
                    inc       Addr_0010 ; advance the selected counter
Code_3E53           clr       Addr_0011 ; clear the selected byte or register
                    clr       Code_0017 ; clear the selected byte or register
                    lda       Addr_0013 ; load the value needed by the following operation
                    suba      Addr_000C ; subtract the operand from the running value
                    bcs       Code_3E62 ; branch when carry reports an unsigned underflow or error
                    inca                ; advance the selected counter
                    sta       Addr_0011 ; save the current value in working storage
                    sta       Code_0017 ; save the current value in working storage
Code_3E62           ldb       Addr_0013 ; load the value needed by the following operation
                    subb      Addr_0011 ; subtract the operand from the running value
                    addb      Addr_0010 ; add the operand to the running value
                    stb       start     ; save the current value in working storage
                    ldb       Addr_000E ; load the value needed by the following operation
                    subb      Addr_000C ; subtract the operand from the running value
                    stb       Addr_0012 ; save the current value in working storage
                    lda       Addr_0010 ; load the value needed by the following operation
                    adda      Addr_000C ; add the operand to the running value
                    deca                ; decrement the selected counter
                    sta       Code_001D ; save the current value in working storage
                    clr       Addr_0016 ; clear the selected byte or register
Code_3E79           ldb       Addr_0010 ; load the value needed by the following operation
                    addb      Addr_0016 ; add the operand to the running value
                    bsr       Code_3EA9 ; call the referenced helper routine
                    lda       Code_0017 ; load the value needed by the following operation
                    lbsr      Code_3EB5 ; call the referenced helper routine
                    inc       Addr_0016 ; advance the selected counter
                    lda       Addr_0016 ; load the value needed by the following operation
                    cmpa      Addr_000C ; compare against the limit and set condition flags
                    beq       Code_3E94 ; branch when the compared values are equal
                    inc       Code_0017 ; advance the selected counter
                    lda       Code_0017 ; load the value needed by the following operation
                    cmpa      Addr_000E ; compare against the limit and set condition flags
                    bne       Code_3E79 ; branch when the compared values differ
Code_3E94           lbsr      Code_3EC4 ; call the referenced helper routine
                    lbsr      Code_3ED2 ; call the referenced helper routine
                    puls      PC,U,Y,X,DP,D ; restore the listed registers from the stack
Code_3E9C           pshs      D         ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "/"                            ; embedded text or resource bytes
                    tfr       A,DP      ; copy the source register into the destination register
                    clrb                ; clear the selected byte or register
                    tfr       D,U       ; copy the source register into the destination register
                    puls      PC,D      ; restore the listed registers from the stack
Code_3EA9           clra                ; clear the selected byte or register
                    tfr       D,Y       ; copy the source register into the destination register
                    ldb       Addr_000F ; load the value needed by the following operation
                    tfr       D,X       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_3EB5           ldx       Addr_000A ; load the value needed by the following operation
                    asla                ; shift left and update carry
                    ldx       A,X       ; load the value needed by the following operation
                    clra                ; clear the selected byte or register
                    ldb       ,X+       ; fetch the next value and advance the source pointer
                    andb      #$80      ; mask off unwanted bits
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_3EC4           ldb       start     ; load the value needed by the following operation
                    bsr       Code_3EA9 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    ldb       Addr_000D ; load the value needed by the following operation
                    tfr       D,Y       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "$"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_3ED2           tst       Addr_0015 ; set condition flags from the current value
                    beq       Code_3F0C ; branch when the compared values are equal
                    ldb       Addr_0010 ; load the value needed by the following operation
                    decb                ; decrement the selected counter
                    bsr       Code_3F0D ; call the referenced helper routine
                    tst       Addr_0011 ; set condition flags from the current value
                    beq       Code_3EED ; branch when the compared values are equal
                    leax      Data_4268,PCR ; form the referenced address without reading memory
                    tst       Addr_0018 ; set condition flags from the current value
                    beq       Code_3EE9 ; branch when the compared values are equal
                    leax      $03,X     ; form the referenced address without reading memory
Code_3EE9           bsr       Code_3F1D ; call the referenced helper routine
                    bra       Code_3EF1 ; continue at the selected control-flow target
Code_3EED           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "A"                            ; embedded text or resource bytes
Code_3EF1           ldb       Code_001D ; load the value needed by the following operation
                    incb                ; advance the selected counter
                    bsr       Code_3F0D ; call the referenced helper routine
                    ldb       Addr_0011 ; load the value needed by the following operation
                    cmpb      Addr_0012 ; compare against the limit and set condition flags
                    beq       Code_3F08 ; branch when the compared values are equal
                    leax      Data_426E,PCR ; form the referenced address without reading memory
                    tst       Addr_0019 ; set condition flags from the current value
                    beq       Code_3F06 ; branch when the compared values are equal
                    leax      $03,X     ; form the referenced address without reading memory
Code_3F06           bra       Code_3F1D ; continue at the selected control-flow target
Code_3F08           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "A"                            ; embedded text or resource bytes
Code_3F0C           rts                 ; return to the caller
Code_3F0D           clra                ; clear the selected byte or register
                    tfr       D,Y       ; copy the source register into the destination register
                    ldb       Addr_000D ; load the value needed by the following operation
                    lsrb                ; shift right and expose the low bit through carry
                    addb      Addr_000F ; add the operand to the running value
                    decb                ; decrement the selected counter
                    tfr       D,X       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_3F1D           pshs      X         ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1F       ; private DeskMate service selector
                    pshs      Y         ; preserve the listed registers on the stack
                    leax      Data_41E8,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $06       ; private DeskMate service selector
                    ldx       $02,S     ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
                    puls      Y,X       ; restore the listed registers from the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $03       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_3F3A           pshs      U,Y,X,DP,D ; preserve the listed registers on the stack
                    lbsr      Code_3E9C ; call the referenced helper routine
                    clr       Addr_0018 ; clear the selected byte or register
                    clr       Addr_0019 ; clear the selected byte or register
                    clr       Code_0033 ; clear the selected byte or register
                    ldb       #$80      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    sta       Addr_001C ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $18       ; private DeskMate service selector
                    tsta                ; set condition flags from the current value
                    lbeq      Code_3F9F ; take the distant branch when values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "E"                            ; embedded text or resource bytes
                    stb       Code_0033 ; save the current value in working storage
                    stx       Addr_0034 ; save the current value in working storage
                    sty       Data_0036 ; save the current value in working storage
                    cmpb      #$01      ; compare against the limit and set condition flags
                    bne       Code_3F71 ; branch when the compared values differ
                    lda       #$0D      ; load the value needed by the following operation
                    cmpy      #Data_00FF ; compare against the limit and set condition flags
                    bne       Code_3F6F ; branch when the compared values differ
                    lda       #$05      ; load the value needed by the following operation
Code_3F6F           sta       Addr_001C ; save the current value in working storage
Code_3F71           tfr       Y,D       ; copy the source register into the destination register
                    cmpb      #$FF      ; compare against the limit and set condition flags
                    beq       Code_3F9F ; branch when the compared values are equal
                    stb       Code_001B ; save the current value in working storage
                    cmpb      Addr_0010 ; compare against the limit and set condition flags
                    bcs       Code_3FDC ; branch when carry reports an unsigned underflow or error
                    cmpb      Code_001D ; compare against the limit and set condition flags
                    bhi       Code_3FDC ; branch when the unsigned value is above the limit
                    cmpb      start     ; compare against the limit and set condition flags
                    beq       Code_3FD4 ; branch when the compared values are equal
Code_3F85           subb      Addr_0010 ; subtract the operand from the running value
                    addb      Addr_0011 ; add the operand to the running value
                    cmpb      Addr_000E ; compare against the limit and set condition flags
                    bcc       Code_3FD4 ; branch when carry is clear
                    pshs      B         ; preserve the listed registers on the stack
                    lbsr      Code_3EC4 ; call the referenced helper routine
                    lda       ,S+       ; load the value needed by the following operation
                    ldb       Code_001B ; load the value needed by the following operation
                    stb       start     ; save the current value in working storage
                    sta       Addr_0013 ; save the current value in working storage
                    lbsr      Code_3EC4 ; call the referenced helper routine
                    bra       Code_3FD1 ; continue at the selected control-flow target
Code_3F9F           lda       Addr_001C ; load the value needed by the following operation
                    cmpa      #$0C      ; compare against the limit and set condition flags
                    beq       Code_3FB1 ; branch when the compared values are equal
                    cmpa      #$0A      ; compare against the limit and set condition flags
                    beq       Code_3FBF ; branch when the compared values are equal
                    tst       Addr_001A ; set condition flags from the current value
                    beq       Code_3FD4 ; branch when the compared values are equal
                    clr       Addr_001A ; clear the selected byte or register
                    bra       Code_3FD1 ; continue at the selected control-flow target
Code_3FB1           ldb       start     ; load the value needed by the following operation
                    cmpb      Addr_0010 ; compare against the limit and set condition flags
                    lbeq      Code_4017 ; take the distant branch when values are equal
                    decb                ; decrement the selected counter
                    stb       Code_001B ; save the current value in working storage
                    lbra      Code_3F85 ; continue at the distant control-flow target
Code_3FBF           ldb       start     ; load the value needed by the following operation
                    cmpb      Code_001D ; compare against the limit and set condition flags
                    lbeq      Code_3FE5 ; take the distant branch when values are equal
                    incb                ; advance the selected counter
                    stb       Code_001B ; save the current value in working storage
                    lbra      Code_3F85 ; continue at the distant control-flow target
Code_3FCD           lda       #$FF      ; load the value needed by the following operation
                    sta       Addr_001A ; save the current value in working storage
Code_3FD1           lbsr      Code_3ED2 ; call the referenced helper routine
Code_3FD4           ldb       Addr_001C ; load the value needed by the following operation
                    lda       Addr_0013 ; load the value needed by the following operation
                    leas      $02,S     ; form the referenced address without reading memory
                    puls      PC,U,Y,X,DP ; restore the listed registers from the stack
Code_3FDC           lda       Code_001D ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    cmpa      Code_001B ; compare against the limit and set condition flags
                    bne       Code_400E ; branch when the compared values differ
                    inc       Addr_0019 ; advance the selected counter
Code_3FE5           ldb       Addr_0011 ; load the value needed by the following operation
                    cmpb      Addr_0012 ; compare against the limit and set condition flags
                    beq       Code_3FD4 ; branch when the compared values are equal
                    inc       Addr_0011 ; advance the selected counter
                    lbsr      Code_3EC4 ; call the referenced helper routine
                    inc       Addr_0013 ; advance the selected counter
                    bsr       Code_403B ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $26       ; private DeskMate service selector
                    ldb       Code_001D ; load the value needed by the following operation
                    lbsr      Code_3EA9 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "A"                            ; embedded text or resource bytes
                    lda       Addr_0011 ; load the value needed by the following operation
                    adda      Addr_000C ; add the operand to the running value
                    deca                ; decrement the selected counter
                    lbsr      Code_3EB5 ; call the referenced helper routine
                    lbsr      Code_3EC4 ; call the referenced helper routine
                    bra       Code_3FCD ; continue at the selected control-flow target
Code_400E           lda       Addr_0010 ; load the value needed by the following operation
                    deca                ; decrement the selected counter
                    cmpa      Code_001B ; compare against the limit and set condition flags
                    bne       Code_3FD1 ; branch when the compared values differ
                    inc       Addr_0018 ; advance the selected counter
Code_4017           tst       Addr_0011 ; set condition flags from the current value
                    beq       Code_3FD4 ; branch when the compared values are equal
                    lbsr      Code_3EC4 ; call the referenced helper routine
                    dec       Addr_0011 ; decrement the selected counter
                    dec       Addr_0013 ; decrement the selected counter
                    bsr       Code_403B ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "'"                            ; embedded text or resource bytes
                    ldb       Addr_0010 ; load the value needed by the following operation
                    lbsr      Code_3EA9 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "A"                            ; embedded text or resource bytes
                    lda       Addr_0011 ; load the value needed by the following operation
                    lbsr      Code_3EB5 ; call the referenced helper routine
                    lbsr      Code_3EC4 ; call the referenced helper routine
                    bra       Code_3FCD ; continue at the selected control-flow target
Code_403B           ldb       Addr_0010 ; load the value needed by the following operation
                    lbsr      Code_3EA9 ; call the referenced helper routine
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
Code_4055           pshs      U,Y,X,DP,D ; preserve the listed registers on the stack
                    lbsr      Code_3E9C ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "9"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "0"                            ; embedded text or resource bytes
                    sta       Addr_0026 ; save the current value in working storage
                    ldd       ,S        ; load the value needed by the following operation
                    stb       Addr_001F ; save the current value in working storage
                    tsta                ; set condition flags from the current value
                    bpl       Code_408C ; branch while the tested value is nonnegative
                    anda      #$7F      ; mask off unwanted bits
                    sta       Addr_0020 ; save the current value in working storage
                    stx       Code_0021 ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "I"                            ; embedded text or resource bytes
                    tfr       Y,D       ; copy the source register into the destination register
                    stb       Addr_0023 ; save the current value in working storage
                    tfr       X,D       ; copy the source register into the destination register
                    stb       Data_0024 ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "4"                            ; embedded text or resource bytes
                    clr       Addr_001E ; clear the selected byte or register
                    lda       #$FF      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1E       ; private DeskMate service selector
Code_4089           lbsr      Code_41A9 ; call the referenced helper routine
Code_408C           lbsr      Code_41C4 ; call the referenced helper routine
Code_408F           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $18       ; private DeskMate service selector
                    anda      #$80      ; mask off unwanted bits
                    ora       #$03      ; set the selected flag bits
                    tfr       A,B       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1C       ; private DeskMate service selector
                    tstb                ; set condition flags from the current value
                    bpl       Code_40A4 ; branch while the tested value is nonnegative
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $16       ; private DeskMate service selector
Code_40A4           sta       Code_0025 ; save the current value in working storage
                    ldx       Code_0021 ; load the value needed by the following operation
                    ldb       Addr_001F ; load the value needed by the following operation
                    leay      B,X       ; form the referenced address without reading memory
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bcs       Code_40C8 ; branch when carry reports an unsigned underflow or error
                    cmpa      #$7E      ; compare against the limit and set condition flags
                    bhi       Code_40C8 ; branch when the unsigned value is above the limit
                    tst       Addr_001E ; set condition flags from the current value
                    lbne      Code_4189 ; take the distant branch when values differ
Code_40BA           sta       ,Y        ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "C"                            ; embedded text or resource bytes
Code_40C0           tst       $01,Y     ; set condition flags from the current value
                    beq       Code_408F ; branch when the compared values are equal
                    inc       Addr_001F ; advance the selected counter
                    bra       Code_408C ; continue at the selected control-flow target
Code_40C8           cmpa      #$88      ; compare against the limit and set condition flags
                    beq       Code_4117 ; branch when the compared values are equal
                    cmpa      #$08      ; compare against the limit and set condition flags
                    beq       Code_413C ; branch when the compared values are equal
                    cmpa      #$09      ; compare against the limit and set condition flags
                    beq       Code_40C0 ; branch when the compared values are equal
                    cmpa      #$C9      ; compare against the limit and set condition flags
                    lbeq      Code_4160 ; take the distant branch when values are equal
                    cmpa      #$E9      ; compare against the limit and set condition flags
                    lbeq      Code_4160 ; take the distant branch when values are equal
                    cmpa      #$0C      ; compare against the limit and set condition flags
                    beq       Code_4156 ; branch when the compared values are equal
                    cmpa      #$0A      ; compare against the limit and set condition flags
                    beq       Code_4144 ; branch when the compared values are equal
                    cmpa      #$8D      ; compare against the limit and set condition flags
                    bne       Code_4103 ; branch when the compared values differ
                    lda       #$0D      ; load the value needed by the following operation
                    sta       Code_0025 ; save the current value in working storage
Code_40F0           lda       #$20      ; load the value needed by the following operation
                    sta       ,Y+       ; store the value and advance the destination pointer
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "C"                            ; embedded text or resource bytes
                    tst       ,Y        ; set condition flags from the current value
                    beq       Code_4103 ; branch when the compared values are equal
                    inc       Addr_001F ; advance the selected counter
                    lbsr      Code_41C4 ; call the referenced helper routine
                    bra       Code_40F0 ; continue at the selected control-flow target
Code_4103           ldb       Addr_001F ; load the value needed by the following operation
                    lda       Addr_0026 ; load the value needed by the following operation
                    beq       Code_410D ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "3"                            ; embedded text or resource bytes
Code_410D           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       ":"                            ; embedded text or resource bytes
                    lda       Code_0025 ; load the value needed by the following operation
                    leas      $02,S     ; form the referenced address without reading memory
                    puls      PC,U,Y,X,DP ; restore the listed registers from the stack
Code_4117           tst       Addr_001E ; set condition flags from the current value
                    bne       Code_416E ; branch when the compared values differ
                    tstb                ; set condition flags from the current value
                    beq       Code_4131 ; branch when the compared values are equal
                    tst       $01,Y     ; set condition flags from the current value
                    bne       Code_4128 ; branch when the compared values differ
                    lda       #$20      ; load the value needed by the following operation
                    cmpa      ,Y        ; compare against the limit and set condition flags
                    bne       Code_4131 ; branch when the compared values differ
Code_4128           dec       Addr_001F ; decrement the selected counter
                    lbsr      Code_41C4 ; call the referenced helper routine
                    ldx       Code_0021 ; load the value needed by the following operation
                    ldb       Addr_001F ; load the value needed by the following operation
Code_4131           lda       #$20      ; load the value needed by the following operation
                    sta       B,X       ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "C"                            ; embedded text or resource bytes
Code_4139           lbra      Code_408F ; continue at the distant control-flow target
Code_413C           tstb                ; set condition flags from the current value
                    beq       Code_4139 ; branch when the compared values are equal
                    dec       Addr_001F ; decrement the selected counter
                    lbra      Code_408C ; continue at the distant control-flow target
Code_4144           lda       Addr_0020 ; load the value needed by the following operation
Code_4146           deca                ; decrement the selected counter
                    bmi       Code_4151 ; branch while the tested value is negative
                    incb                ; advance the selected counter
                    tst       B,X       ; set condition flags from the current value
                    bne       Code_4146 ; branch when the compared values differ
Code_414E           lbra      Code_410D ; continue at the distant control-flow target
Code_4151           stb       Addr_001F ; save the current value in working storage
                    lbra      Code_408C ; continue at the distant control-flow target
Code_4156           lda       Addr_0020 ; load the value needed by the following operation
Code_4158           deca                ; decrement the selected counter
                    bmi       Code_4151 ; branch while the tested value is negative
                    decb                ; decrement the selected counter
                    bmi       Code_414E ; branch while the tested value is negative
                    bra       Code_4158 ; continue at the selected control-flow target
Code_4160           lda       #$FF      ; load the value needed by the following operation
                    com       Addr_001E ; invert every bit in the selected value
                    beq       Code_4168 ; branch when the compared values are equal
                    lda       #$01      ; load the value needed by the following operation
Code_4168           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1E       ; private DeskMate service selector
                    bra       Code_4139 ; continue at the selected control-flow target
Code_416E           tstb                ; set condition flags from the current value
                    bne       Code_4174 ; branch when the compared values differ
                    incb                ; advance the selected counter
                    stb       Addr_001F ; save the current value in working storage
Code_4174           leax      B,X       ; form the referenced address without reading memory
Code_4176           lda       ,X+       ; fetch the next value and advance the source pointer
                    beq       Code_417E ; branch when the compared values are equal
                    sta       -$02,X    ; save the current value in working storage
                    bra       Code_4176 ; continue at the selected control-flow target
Code_417E           lda       #$20      ; load the value needed by the following operation
                    sta       -$02,X    ; save the current value in working storage
                    dec       Addr_001F ; decrement the selected counter
                    bsr       Code_41C4 ; call the referenced helper routine
                    lbra      Code_4089 ; continue at the distant control-flow target
Code_4189           tst       $01,Y     ; set condition flags from the current value
                    lbeq      Code_40BA ; take the distant branch when values are equal
                    pshs      Y,A       ; preserve the listed registers on the stack
Code_4191           lda       ,Y+       ; fetch the next value and advance the source pointer
                    bne       Code_4191 ; branch when the compared values differ
                    leay      -$02,Y    ; form the referenced address without reading memory
Code_4197           lda       ,-Y       ; load the value needed by the following operation
                    sta       $01,Y     ; save the current value in working storage
                    cmpy      $01,S     ; compare against the limit and set condition flags
                    bne       Code_4197 ; branch when the compared values differ
                    puls      X,A       ; restore the listed registers from the stack
                    sta       ,X        ; save the current value in working storage
                    bsr       Code_41A9 ; call the referenced helper routine
                    lbra      Code_40C0 ; continue at the distant control-flow target
Code_41A9           ldx       Code_0021 ; load the value needed by the following operation
                    ldb       Addr_001F ; load the value needed by the following operation
                    pshs      B         ; preserve the listed registers on the stack
                    leax      B,X       ; form the referenced address without reading memory
Code_41B1           bsr       Code_41C4 ; call the referenced helper routine
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    beq       Code_41BF ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "C"                            ; embedded text or resource bytes
                    inc       Addr_001F ; advance the selected counter
                    bra       Code_41B1 ; continue at the selected control-flow target
Code_41BF           puls      B         ; restore the listed registers from the stack
                    stb       Addr_001F ; save the current value in working storage
                    rts                 ; return to the caller
Code_41C4           ldb       Addr_001F ; load the value needed by the following operation
                    clra                ; clear the selected byte or register
Code_41C7           inca                ; advance the selected counter
                    subb      Addr_0020 ; subtract the operand from the running value
                    bhi       Code_41C7 ; branch when the unsigned value is above the limit
                    beq       Code_41D1 ; branch when the compared values are equal
                    deca                ; decrement the selected counter
                    addb      Addr_0020 ; add the operand to the running value
Code_41D1           adda      Addr_0023 ; add the operand to the running value
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
Data_41E8           fcb       $00,$03,$0C ; table, bitmap, or initialized data bytes
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
Data_4268           fcb       $80,$81,$00,$84,$85,$00 ; table, bitmap, or initialized data bytes
Data_426E           fcb       $82,$83,$00,$86,$87,$00 ; table, bitmap, or initialized data bytes
Data_4274           fcb       $00,$04,$08,$18,$03,$00 ; table, bitmap, or initialized data bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
Data_427B           fcb       $FF       ; table, bitmap, or initialized data bytes
Data_427C           fcb       $07,$05   ; table, bitmap, or initialized data bytes
                    fcc       "  Save as:"                   ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_4289           fcb       $00,$02,$0C,$1C,$07,$00 ; table, bitmap, or initialized data bytes
                    fcb       $AA       ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
Data_4291           fcc       "Use "                         ; embedded text or resource bytes
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
Data_42BC           fcc       "Filename must be 1-8"         ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "characters, begin wit"        ; embedded text or resource bytes
                    fcc       "h"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "a-z "                         ; embedded text or resource bytes
                    fcb       $26       ; table, bitmap, or initialized data bytes
                    fcc       " contain a-z or 0-9"          ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_4301           fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
Code_4312           pshs      DP        ; preserve the listed registers on the stack
                    pshs      U,Y,X,A   ; preserve the listed registers on the stack
                    lda       $06,Y     ; load the value needed by the following operation
                    sta       Data_427B,PCR ; save the current value in working storage
                    lbsr      Code_3E9C ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       ">"                            ; embedded text or resource bytes
                    sta       Code_0029 ; save the current value in working storage
                    clr       Addr_002A ; clear the selected byte or register
                    clr       Addr_002B ; clear the selected byte or register
                    ldx       ,Y        ; load the value needed by the following operation
                    stx       Addr_0027 ; save the current value in working storage
                    leau      >Data_4301,PCR ; form the referenced address without reading memory
                    stu       ,Y        ; save the current value in working storage
                    lbsr      Code_4435 ; call the referenced helper routine
                    leax      Data_4274,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    ldx       $01,S     ; load the value needed by the following operation
                    bne       Code_4346 ; branch when the compared values differ
                    leax      Data_427C,PCR ; form the referenced address without reading memory
Code_4346           clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
Code_434C           ldx       #Addr_000B ; load the value needed by the following operation
                    leay      -$0B,X    ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    ldy       $03,S     ; load the value needed by the following operation
                    ldx       ,Y        ; load the value needed by the following operation
                    ldd       #Addr_9000 ; load the value needed by the following operation
Code_435D           lbsr      Code_4055 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_436D ; branch when the compared values are equal
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    beq       Code_43A9 ; branch when the compared values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    beq       Code_439E ; branch when the compared values are equal
                    bra       Code_439A ; continue at the selected control-flow target
Code_436D           pshs      U,Y,X,D   ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       ">"                            ; embedded text or resource bytes
                    pshs      A         ; preserve the listed registers on the stack
                    tst       Data_427B,PCR ; set condition flags from the current value
                    bne       Code_437F ; branch when the compared values differ
                    deca                ; decrement the selected counter
                    bpl       Code_437F ; branch while the tested value is nonnegative
                    inca                ; advance the selected counter
Code_437F           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "="                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "E"                            ; embedded text or resource bytes
                    puls      A         ; restore the listed registers from the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "="                            ; embedded text or resource bytes
                    cmpx      #Data_00FF ; compare against the limit and set condition flags
                    puls      U,Y,X,D   ; restore the listed registers from the stack
                    bne       Code_43A9 ; branch when the compared values differ
                    lda       #$05      ; load the value needed by the following operation
                    bra       Code_439E ; continue at the selected control-flow target
                    fcc       "5v"                           ; embedded text or resource bytes
Code_439A           lda       #$0A      ; load the value needed by the following operation
                    bra       Code_435D ; continue at the selected control-flow target
Code_439E           ldx       Addr_0027 ; load the value needed by the following operation
                    stx       ,Y        ; save the current value in working storage
                    sta       ,S        ; save the current value in working storage
                    clrb                ; clear the selected byte or register
                    puls      U,Y,X,A   ; restore the listed registers from the stack
                    puls      PC,DP     ; restore the listed registers from the stack
Code_43A9           lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpa      #$20      ; compare against the limit and set condition flags
                    beq       Code_43A9 ; branch when the compared values are equal
                    lda       ,X        ; load the value needed by the following operation
                    leax      -$01,X    ; form the referenced address without reading memory
                    cmpa      #$3A      ; compare against the limit and set condition flags
                    bne       Code_43C5 ; branch when the compared values differ
                    lda       ,X        ; load the value needed by the following operation
                    suba      #$31      ; subtract the operand from the running value
                    cmpa      #$02      ; compare against the limit and set condition flags
                    bcs       Code_43C5 ; branch when carry reports an unsigned underflow or error
                    leax      Data_4291,PCR ; form the referenced address without reading memory
                    bra       Code_43D6 ; continue at the selected control-flow target
Code_43C5           ldx       ,Y        ; load the value needed by the following operation
                    lda       ,S        ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "J"                            ; embedded text or resource bytes
                    andb      #$EF      ; mask off unwanted bits
                    tstb                ; set condition flags from the current value
                    beq       Code_4421 ; branch when the compared values are equal
                    leax      Data_42BC,PCR ; form the referenced address without reading memory
Code_43D6           pshs      X         ; preserve the listed registers on the stack
                    ldb       ,X        ; load the value needed by the following operation
                    tst       Addr_002A ; set condition flags from the current value
                    bne       Code_43E6 ; branch when the compared values differ
                    leax      Data_4289,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
Code_43E6           lda       Code_0029 ; load the value needed by the following operation
                    adda      #$02      ; add the operand to the running value
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "="                            ; embedded text or resource bytes
                    cmpb      Addr_002B ; compare against the limit and set condition flags
                    beq       Code_43F8 ; branch when the compared values are equal
                    stb       Addr_002B ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "?"                            ; embedded text or resource bytes
Code_43F8           ldb       #$03      ; load the value needed by the following operation
                    stb       Addr_002A ; save the current value in working storage
                    ldy       #Addr_0001 ; load the value needed by the following operation
Code_4400           clra                ; clear the selected byte or register
                    ldx       #Addr_0001 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    ldx       ,S        ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    stx       ,S        ; save the current value in working storage
                    leay      $01,Y     ; form the referenced address without reading memory
                    decb                ; decrement the selected counter
                    bne       Code_4400 ; branch when the compared values differ
                    leas      $02,S     ; form the referenced address without reading memory
                    lda       Code_0029 ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "="                            ; embedded text or resource bytes
                    lbra      Code_434C ; continue at the distant control-flow target
Code_4421           lda       Code_0029 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    clr       ,S        ; clear the selected byte or register
                    ldu       Addr_0027 ; load the value needed by the following operation
                    ldx       ,Y        ; load the value needed by the following operation
                    stu       ,Y        ; save the current value in working storage
                    bsr       Code_4435 ; call the referenced helper routine
                    puls      U,Y,X,A   ; restore the listed registers from the stack
                    puls      PC,DP     ; restore the listed registers from the stack
Code_4435           lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,U+       ; store the value and advance the destination pointer
                    bne       Code_4435 ; branch when the compared values differ
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
                    fcb       $06,$17,$BB ; table, bitmap, or initialized data bytes
                    fcc       "s"                            ; embedded text or resource bytes
                    fcb       $0F,$C1   ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $26,$04,$1F,$10 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8B       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $06,$17,$BB ; table, bitmap, or initialized data bytes
                    fcc       "eD"                           ; embedded text or resource bytes
                    fcb       $17,$BB   ; table, bitmap, or initialized data bytes
                    fcc       "a5"                           ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       ":"                            ; embedded text or resource bytes
                    fcb       $17,$BB   ; table, bitmap, or initialized data bytes
                    fcc       "[594H"                        ; embedded text or resource bytes
                    fcb       $17,$F9,$DC ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $E9,$FE,$0C,$10,$DF ; table, bitmap, or initialized data bytes
                    fcc       ",46"                          ; embedded text or resource bytes
                    fcb       $17,$BB   ; table, bitmap, or initialized data bytes
                    fcc       "H"                            ; embedded text or resource bytes
                    fcb       $16,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "1O0"                          ; embedded text or resource bytes
                    fcb       $8D,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "h"                            ; embedded text or resource bytes
                    fcb       $17,$BB   ; table, bitmap, or initialized data bytes
                    fcc       "=80"                          ; embedded text or resource bytes
                    fcb       $8D,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "p"                            ; embedded text or resource bytes
                    fcb       $17,$BB   ; table, bitmap, or initialized data bytes
                    fcc       "5G"                           ; embedded text or resource bytes
                    fcb       $C6,$0C,$E7,$84,$17,$BB ; table, bitmap, or initialized data bytes
                    fcc       "-G"                           ; embedded text or resource bytes
                    fcb       $C6,$02,$E7,$84,$8E,$1F ; table, bitmap, or initialized data bytes
                    fcb       $1A,$10,$8E,$0B,$06,$86 ; table, bitmap, or initialized data bytes
                    fcb       $FF,$17,$BB,$1C,$0E ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $0A,$17,$BB,$16,$0E,$17 ; table, bitmap, or initialized data bytes
                    fcb       $BB,$12   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $DD       ; table, bitmap, or initialized data bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $17,$BB,$0C ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $17,$BB,$08 ; table, bitmap, or initialized data bytes
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
                    fcb       $26,$04,$17,$BA,$EA ; table, bitmap, or initialized data bytes
                    fcc       "4]"                           ; embedded text or resource bytes
                    fcb       $26,$04,$17,$BA,$E3 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $AE       ; table, bitmap, or initialized data bytes
                    fcc       "d"                            ; embedded text or resource bytes
                    fcb       $A6,$94,$80 ; table, bitmap, or initialized data bytes
                    fcc       "0'"                           ; embedded text or resource bytes
                    fcb       $04,$81,$03 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $06,$17,$BA,$D3 ; table, bitmap, or initialized data bytes
                    fcc       "N"                            ; embedded text or resource bytes
                    fcb       $A6,$84,$8E,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $04,$17,$BA,$C8 ; table, bitmap, or initialized data bytes
                    fcc       "D"                            ; embedded text or resource bytes
                    fcb       $17,$BA,$C4 ; table, bitmap, or initialized data bytes
                    fcc       "@"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $17,$01   ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $C6       ; table, bitmap, or initialized data bytes
                    fcc       ")="                           ; embedded text or resource bytes
                    fcb       $17,$BA,$B8 ; table, bitmap, or initialized data bytes
                    fcc       "N0"                           ; embedded text or resource bytes
                    fcb       $88,$26   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8B,$DE   ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $10,$AE   ; table, bitmap, or initialized data bytes
                    fcc       "d"                            ; embedded text or resource bytes
                    fcb       $10,$AE,$22,$CC,$01,$F4 ; table, bitmap, or initialized data bytes
                    fcb       $17,$BA,$A4 ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $01,$01,$97 ; table, bitmap, or initialized data bytes
                    fcc       "0'1"                          ; embedded text or resource bytes
                    fcb       $1F,$89,$17,$BA,$96 ; table, bitmap, or initialized data bytes
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
                    fcb       $A7,$04,$17,$BA ; table, bitmap, or initialized data bytes
                    fcc       "}"                            ; embedded text or resource bytes
                    fcb       $0F,$C1   ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $26,$04,$C6,$06,$E7,$05 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $17,$F8,$86,$C6,$01,$E7 ; table, bitmap, or initialized data bytes
                    fcb       $8D,$FE,$DE,$0D ; table, bitmap, or initialized data bytes
                    fcc       "0'"                           ; embedded text or resource bytes
                    fcb       $05,$17,$F9,$89 ; table, bitmap, or initialized data bytes
                    fcc       " -"                           ; embedded text or resource bytes
                    fcb       $1F,$13,$17,$BA ; table, bitmap, or initialized data bytes
                    fcc       "\E"                           ; embedded text or resource bytes
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
                    fcb       $17,$BA   ; table, bitmap, or initialized data bytes
                    fcc       "@"                            ; embedded text or resource bytes
                    fcb       $1D,$17,$BA ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
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
                    fcb       $06,$17,$BA,$03,$18 ; table, bitmap, or initialized data bytes
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
                    fcb       $E4,$17,$B9,$AF ; table, bitmap, or initialized data bytes
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
                    fcb       $B9,$7F,$13 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $09,$E7,$84,$17,$B9 ; table, bitmap, or initialized data bytes
                    fcc       "w"                            ; embedded text or resource bytes
                    fcb       $13       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $16,$97   ; table, bitmap, or initialized data bytes
                    fcc       "19("                          ; embedded text or resource bytes
                    fcb       $80       ; table, bitmap, or initialized data bytes
Data_46A5           fcc       "?"                            ; embedded text or resource bytes
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
                    fcb       $03,$C0,$0F,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC,$0F,$F0,$03,$C0,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
Data_4EA7           fcb       $CC,$CC   ; table, bitmap, or initialized data bytes
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
