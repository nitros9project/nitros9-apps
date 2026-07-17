********************************************************************
* DMMENU - DeskMate 3 desktop menu
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

                    nam       DMMENU
                    ttl       DeskMate 3 desktop menu

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct
atrv                set       $00

                    mod       eom,name,tylg,atrv,start,$1957

name                fcs       /DMMENU/ ; OS-9 module name

Addr_0001           equ       $0001     ; absolute address used by original code
Addr_0002           equ       $0002     ; absolute address used by original code
Addr_0003           equ       $0003     ; absolute address used by original code
Addr_0004           equ       $0004     ; absolute address used by original code
Addr_0005           equ       $0005     ; absolute address used by original code
Addr_0006           equ       $0006     ; absolute address used by original code
Addr_0007           equ       $0007     ; absolute address used by original code
Addr_000E           equ       $000E     ; absolute address used by original code
Addr_0010           equ       $0010     ; absolute address used by original code
Addr_001E           equ       $001E     ; absolute address used by original code
Addr_001F           equ       $001F     ; absolute address used by original code
Addr_0021           equ       $0021     ; absolute address used by original code
Addr_0025           equ       $0025     ; absolute address used by original code
Addr_0026           equ       $0026     ; absolute address used by original code
Addr_0029           equ       $0029     ; absolute address used by original code
Addr_002B           equ       $002B     ; absolute address used by original code
Addr_002D           equ       $002D     ; absolute address used by original code
Addr_002E           equ       $002E     ; absolute address used by original code
Addr_0031           equ       $0031     ; absolute address used by original code
Addr_0033           equ       $0033     ; absolute address used by original code
Addr_0034           equ       $0034     ; absolute address used by original code
Addr_0601           equ       $0601     ; absolute address used by original code
Addr_0701           equ       $0701     ; absolute address used by original code
Addr_0803           equ       $0803     ; absolute address used by original code
Addr_0910           equ       $0910     ; absolute address used by original code
Addr_0D26           equ       $0D26     ; absolute address used by original code
Addr_0E4E           equ       $0E4E     ; absolute address used by original code
Addr_1721           equ       $1721     ; absolute address used by original code
Addr_1D01           equ       $1D01     ; absolute address used by original code
Addr_1F00           equ       $1F00     ; absolute address used by original code
Addr_202D           equ       $202D     ; absolute address used by original code
Addr_203D           equ       $203D     ; absolute address used by original code
Addr_2707           equ       $2707     ; absolute address used by original code
Addr_2E00           equ       $2E00     ; absolute address used by original code
Addr_2E48           equ       $2E48     ; absolute address used by original code
Addr_323A           equ       $323A     ; absolute address used by original code
Addr_4095           equ       $4095     ; absolute address used by original code
Addr_409B           equ       $409B     ; absolute address used by original code
Addr_4828           equ       $4828     ; absolute address used by original code
Addr_4C50           equ       $4C50     ; absolute address used by original code
Addr_6041           equ       $6041     ; absolute address used by original code
Addr_8002           equ       $8002     ; absolute address used by original code
Addr_9001           equ       $9001     ; absolute address used by original code
Addr_9F3F           equ       $9F3F     ; absolute address used by original code
Addr_9F42           equ       $9F42     ; absolute address used by original code
Addr_A020           equ       $A020     ; absolute address used by original code
Addr_A038           equ       $A038     ; absolute address used by original code
Addr_FE05           equ       $FE05     ; absolute address used by original code
Addr_FFD8           equ       $FFD8     ; absolute address used by original code
Addr_FFFB           equ       $FFFB     ; absolute address used by original code
DeskMateService     equ       $0000     ; absolute address used by original code

start               jmp       >DeskMateService ; dispatch control through the selected target
                    leas      $1956,U   ; form the referenced address without reading memory
                    pshs      X         ; preserve the listed registers on the stack
                    leax      Data_37B8,PCR ; form the referenced address without reading memory
Code_0020           lbsr      start     ; invoke the patched DeskMate service dispatcher
Data_0023           fcb       $07       ; private DeskMate service selector
Code_0024           lbsr      start     ; invoke the patched DeskMate service dispatcher
Data_0027           fcb       $06       ; private DeskMate service selector
                    leax      Data_3FBA,PCR ; form the referenced address without reading memory
Code_002C           lbsr      start     ; invoke the patched DeskMate service dispatcher
Data_002F           fcb       $08       ; private DeskMate service selector
Code_0030           puls      X         ; restore the listed registers from the stack
Code_0032           lbra      Code_0320 ; continue at the distant control-flow target
Data_0035           fcc       "("                            ; embedded text or resource bytes
Data_0036           fcb       $04       ; table, bitmap, or initialized data bytes
Data_0037           fcb       $0C       ; table, bitmap, or initialized data bytes
Data_0038           fcb       $AA       ; table, bitmap, or initialized data bytes
Data_0039           fcb       $A8       ; table, bitmap, or initialized data bytes
Data_003A           fcb       $0A       ; table, bitmap, or initialized data bytes
Data_003B           fcb       $AA       ; table, bitmap, or initialized data bytes
Data_003C           fcb       $AA       ; table, bitmap, or initialized data bytes
Data_003D           fcb       $8F       ; table, bitmap, or initialized data bytes
Data_003E           fcb       $F0       ; table, bitmap, or initialized data bytes
Data_003F           fcb       $AA,$A8   ; table, bitmap, or initialized data bytes
Data_0041           fcb       $FF       ; table, bitmap, or initialized data bytes
Data_0042           fcb       $FF       ; table, bitmap, or initialized data bytes
Data_0043           fcb       $0A       ; table, bitmap, or initialized data bytes
Data_0044           fcb       $A8,$F2   ; table, bitmap, or initialized data bytes
Data_0046           fcb       $8F,$0A   ; table, bitmap, or initialized data bytes
Data_0048           fcb       $AA,$F2   ; table, bitmap, or initialized data bytes
Data_004A           fcb       $8F,$0A   ; table, bitmap, or initialized data bytes
Data_004C           fcb       $AA,$A8   ; table, bitmap, or initialized data bytes
Data_004E           fcb       $F0,$AA,$AA,$A8,$F0,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$A8,$F0,$AA,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA       ; table, bitmap, or initialized data bytes
Data_005B           fcb       $AA       ; table, bitmap, or initialized data bytes
Data_005C           fcb       $AA       ; table, bitmap, or initialized data bytes
Data_005D           fcb       $A8       ; table, bitmap, or initialized data bytes
Data_005E           fcb       $F0       ; table, bitmap, or initialized data bytes
Data_005F           fcb       $AA       ; table, bitmap, or initialized data bytes
Data_0060           fcb       $AA       ; table, bitmap, or initialized data bytes
Data_0061           fcb       $A8       ; table, bitmap, or initialized data bytes
Data_0062           fcb       $F0,$AA,$AA,$AA,$AA,$AA ; table, bitmap, or initialized data bytes
Data_0068           fcc       "("                            ; embedded text or resource bytes
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
Data_0083           fcb       $A3       ; table, bitmap, or initialized data bytes
Data_0084           fcb       $FF,$FF,$CA,$A8,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $AA       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC,$AA,$AA,$8F,$F2,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$A3,$CA,$AA,$AA,$A8 ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $AA       ; table, bitmap, or initialized data bytes
Data_009B           fcc       "("                            ; embedded text or resource bytes
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
Data_00BF           fcc       "?"                            ; embedded text or resource bytes
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
Data_00CE           fcc       "("                            ; embedded text or resource bytes
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
                    fcb       $AA,$AA   ; table, bitmap, or initialized data bytes
Data_00FF           fcb       $AA       ; table, bitmap, or initialized data bytes
Data_0100           fcb       $AA       ; table, bitmap, or initialized data bytes
Data_0101           fcc       "("                            ; embedded text or resource bytes
                    fcb       $04,$08,$0A,$AA,$AF,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0A,$00,$0E,$00 ; table, bitmap, or initialized data bytes
Data_010C           fcb       $0A,$00   ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $00,$0A,$00,$CA,$00,$08 ; table, bitmap, or initialized data bytes
                    fcb       $C3,$0A,$00,$0A ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $0A,$00,$0A,$0F,$0A,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0A,$AA,$AA,$00 ; table, bitmap, or initialized data bytes
Data_0124           fcc       "("                            ; embedded text or resource bytes
                    fcb       $04,$08,$0A,$AA,$AA,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0A,$00,$0A,$00,$0A,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0A,$00,$0A,$00,$0A,$00 ; table, bitmap, or initialized data bytes
Data_0137           fcb       $0A,$00,$0A,$00,$0A ; table, bitmap, or initialized data bytes
Data_013C           fcb       $00,$0A,$00,$0A,$00 ; table, bitmap, or initialized data bytes
Data_0141           fcb       $0A,$00,$0A,$AA,$AA ; table, bitmap, or initialized data bytes
Data_0146           fcb       $00       ; table, bitmap, or initialized data bytes
Data_0147           fcc       "("                            ; embedded text or resource bytes
                    fcb       $08,$13,$FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
Data_014E           fcb       $FF,$FF,$FF,$FF,$C0,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$03 ; table, bitmap, or initialized data bytes
                    fcb       $CF,$FF,$FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$F3,$CF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$F3,$CF,$F0 ; table, bitmap, or initialized data bytes
                    fcb       $0F,$C3,$00,$F0,$0F,$F3 ; table, bitmap, or initialized data bytes
                    fcb       $CF       ; table, bitmap, or initialized data bytes
Data_0173           fcb       $F3,$CF   ; table, bitmap, or initialized data bytes
                    fcc       "?<"                           ; embedded text or resource bytes
                    fcb       $F3,$CF,$F3,$CF,$F3,$CF ; table, bitmap, or initialized data bytes
                    fcc       "?<"                           ; embedded text or resource bytes
                    fcb       $F3,$CF,$F3,$CF,$F0,$0F ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $00,$F0,$0F,$F3,$CF,$F3 ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$FF,$CF,$F3 ; table, bitmap, or initialized data bytes
                    fcb       $CF,$F3,$FF,$FF,$FF,$F0 ; table, bitmap, or initialized data bytes
                    fcb       $0F,$F3,$CF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$F3,$CF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$FF,$FF,$F3 ; table, bitmap, or initialized data bytes
                    fcb       $CF,$FF,$FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$F3,$CF,$FF,$FC,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FF,$F3,$CF,$FF,$FC,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FF,$F3,$CF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$F3,$CF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$FF,$FF,$F3 ; table, bitmap, or initialized data bytes
                    fcb       $C0,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$03,$FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
Data_01E2           fcc       "("                            ; embedded text or resource bytes
                    fcb       $08,$13,$FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$FF,$C0,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$03 ; table, bitmap, or initialized data bytes
                    fcb       $CF,$FF,$FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$F3,$CF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$F3,$CF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $CF,$FF,$F3,$FF,$FF,$F3 ; table, bitmap, or initialized data bytes
                    fcb       $CF,$FF,$CF,$03,$00 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $0F,$F3,$CF,$F0,$0F,$F3 ; table, bitmap, or initialized data bytes
                    fcb       $F3,$FF,$CF,$F3,$CF,$F3 ; table, bitmap, or initialized data bytes
                    fcb       $CC,$03,$F3,$F0,$0F,$F3 ; table, bitmap, or initialized data bytes
                    fcb       $CF,$F3,$CC,$F3,$F3,$F3 ; table, bitmap, or initialized data bytes
                    fcb       $CF,$F3,$CF,$F0,$0C,$03 ; table, bitmap, or initialized data bytes
                    fcb       $F3,$F0,$0F,$F3,$CF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$FF,$FF,$F3 ; table, bitmap, or initialized data bytes
                    fcb       $CF,$FF,$FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$F3,$CF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$F3,$CF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FC,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FF,$F3,$CF,$FF,$FC ; table, bitmap, or initialized data bytes
Data_0258           fcb       $00,$00   ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FF,$F3,$CF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$F3,$CF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$FF,$FF,$F3 ; table, bitmap, or initialized data bytes
                    fcb       $C0,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$03,$FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
Data_027D           fcc       "("                            ; embedded text or resource bytes
                    fcb       $08,$14   ; table, bitmap, or initialized data bytes
                    fcc       "fff"                          ; embedded text or resource bytes
                    fcb       $00,$00   ; table, bitmap, or initialized data bytes
                    fcc       "fff"                          ; embedded text or resource bytes
                    fcb       $99,$99,$99,$7F,$FC,$99 ; table, bitmap, or initialized data bytes
                    fcb       $99,$99   ; table, bitmap, or initialized data bytes
                    fcc       "ff"                           ; embedded text or resource bytes
                    fcb       $00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "ff"                           ; embedded text or resource bytes
                    fcb       $99,$99   ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FF,$FF,$FC,$19,$99 ; table, bitmap, or initialized data bytes
                    fcc       "fl"                           ; embedded text or resource bytes
                    fcb       $FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcc       "6f"                           ; embedded text or resource bytes
                    fcb       $99,$90,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $09,$99   ; table, bitmap, or initialized data bytes
                    fcc       "ff"                           ; embedded text or resource bytes
                    fcb       $CC,$FC,$FC,$F3 ; table, bitmap, or initialized data bytes
                    fcc       "ff"                           ; embedded text or resource bytes
                    fcb       $99,$99,$CC,$FC,$FC,$F3 ; table, bitmap, or initialized data bytes
                    fcb       $99,$99   ; table, bitmap, or initialized data bytes
                    fcc       "ff"                           ; embedded text or resource bytes
                    fcb       $CC,$FC,$FC,$F3 ; table, bitmap, or initialized data bytes
                    fcc       "ff"                           ; embedded text or resource bytes
                    fcb       $99,$99,$CC,$FC,$FC,$F3 ; table, bitmap, or initialized data bytes
                    fcb       $99,$99   ; table, bitmap, or initialized data bytes
                    fcc       "ff"                           ; embedded text or resource bytes
                    fcb       $CC,$FC,$FC,$F3 ; table, bitmap, or initialized data bytes
                    fcc       "ff"                           ; embedded text or resource bytes
                    fcb       $99,$99,$CC,$FC,$FC,$F3 ; table, bitmap, or initialized data bytes
                    fcb       $99,$99   ; table, bitmap, or initialized data bytes
                    fcc       "ff"                           ; embedded text or resource bytes
                    fcb       $CC,$FC,$FC,$F3 ; table, bitmap, or initialized data bytes
                    fcc       "ff"                           ; embedded text or resource bytes
                    fcb       $99,$99,$CC,$FC,$FC,$F3 ; table, bitmap, or initialized data bytes
                    fcb       $99,$99   ; table, bitmap, or initialized data bytes
                    fcc       "ff"                           ; embedded text or resource bytes
                    fcb       $CC,$FC,$FC,$F3 ; table, bitmap, or initialized data bytes
                    fcc       "ff"                           ; embedded text or resource bytes
                    fcb       $99,$99,$CC,$FC,$FC,$F3 ; table, bitmap, or initialized data bytes
                    fcb       $99,$99   ; table, bitmap, or initialized data bytes
Data_0300           fcc       "ff"                           ; embedded text or resource bytes
                    fcb       $CC,$FC,$FC,$F3 ; table, bitmap, or initialized data bytes
                    fcc       "f"                            ; embedded text or resource bytes
Data_0307           fcc       "f"                            ; embedded text or resource bytes
                    fcb       $99,$99,$C0,$00,$00,$03 ; table, bitmap, or initialized data bytes
                    fcb       $99,$99   ; table, bitmap, or initialized data bytes
                    fcc       "ff"                           ; embedded text or resource bytes
                    fcb       $00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "ff"                           ; embedded text or resource bytes
                    fcb       $99,$90,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $09,$99   ; table, bitmap, or initialized data bytes
Code_0320           lbsr      Code_0337 ; call the referenced helper routine
                    lda       Addr_002E ; load the value needed by the following operation
                    cmpa      #$03      ; compare against the limit and set condition flags
                    lbcc      Code_0965 ; take the distant branch when carry is clear
                    ldb       Data_002F ; load the value needed by the following operation
                    stb       Addr_002E ; save the current value in working storage
                    lbsr      Code_09AF ; call the referenced helper routine
                    sta       Addr_002E ; save the current value in working storage
                    lbra      Code_0B07 ; continue at the distant control-flow target
Code_0337           pshs      Y,X,D     ; preserve the listed registers on the stack
                    stu       DeskMateService ; save the current value in working storage
                    ldd       #Data_182A ; load the value needed by the following operation
Code_033E           clr       D,U       ; clear the selected byte or register
                    subd      #Addr_0001 ; subtract the operand from the running value
                    bne       Code_033E ; branch when the compared values differ
                    dec       Data_003C ; decrement the selected counter
                    dec       Code_0030 ; decrement the selected counter
                    leax      Data_041B,PCR ; form the referenced address without reading memory
                    os9       F$Icpt    ; request the named OS-9 service
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "-"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $00       ; private DeskMate service selector
                    lda       #$28      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $09       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       " "                            ; embedded text or resource bytes
                    stx       Data_003F ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "3"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "N"                            ; embedded text or resource bytes
                    clr       $08,X     ; clear the selected byte or register
                    lda       #$03      ; load the value needed by the following operation
                    ldb       #$03      ; load the value needed by the following operation
                    tst       $10,Y     ; set condition flags from the current value
                    beq       Code_0388 ; branch when the compared values are equal
                    tst       $11,Y     ; set condition flags from the current value
                    beq       Code_0388 ; branch when the compared values are equal
                    ldd       $11,Y     ; load the value needed by the following operation
Code_0388           std       Addr_002E ; save the current value in working storage
                    lda       $13,Y     ; load the value needed by the following operation
                    sta       Data_003B ;038D: 97 3B          '. ; save the current value in working storage
                    tst       $10,Y     ; set condition flags from the current value
                    bne       Code_03C1 ; branch when the compared values differ
                    ldd       #Addr_0910 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      Data_0422,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    leax      Data_0494,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $13       ; private DeskMate service selector
                    leax      Data_049D,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $13       ; private DeskMate service selector
                    ldb       #$05      ; load the value needed by the following operation
                    ldx       #DeskMateService ; load the value needed by the following operation
Code_03BA           leax      -$01,X    ; form the referenced address without reading memory
                    bne       Code_03BA ; branch when the compared values differ
                    decb                ; decrement the selected counter
                    bne       Code_03BA ; branch when the compared values differ
Code_03C1           lbsr      Code_04F9 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "-"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $00       ; private DeskMate service selector
                    lda       #$28      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $09       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       " "                            ; embedded text or resource bytes
                    stx       Data_003F ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "N"                            ; embedded text or resource bytes
                    tst       $24,X     ; set condition flags from the current value
                    beq       Code_03E5 ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $14       ; private DeskMate service selector
Code_03E5           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "3"                            ; embedded text or resource bytes
                    lbsr      Code_05F8 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "N"                            ; embedded text or resource bytes
                    tst       $10,Y     ; set condition flags from the current value
                    bne       Code_0416 ; branch when the compared values differ
                    lda       #$FF      ; load the value needed by the following operation
                    sta       $10,Y     ; save the current value in working storage
                    ldx       #Addr_FFD8 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "O"                            ; embedded text or resource bytes
Code_0401           leax      >Data_041C,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "V"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "P"                            ; embedded text or resource bytes
                    ldu       DeskMateService ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $00       ; private DeskMate service selector
                    lbsr      Code_05F8 ; call the referenced helper routine
Code_0416           lbsr      Code_1380 ; call the referenced helper routine
                    puls      PC,Y,X,D  ; restore the listed registers from the stack
Data_041B           fcc       ";"                      ;041B: 3B             ' ; embedded text or resource bytes
Data_041C           fcc       "DMTIM"                        ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
Data_0422           fcc       "DeskMate 3"                   ; embedded text or resource bytes
                    fcb       $0D,$0D,$08,$08,$08,$08 ; table, bitmap, or initialized data bytes
                    fcb       $08,$08,$08,$08,$08 ; table, bitmap, or initialized data bytes
                    fcc       "Copyright 1987 TANDY "        ; embedded text or resource bytes
                    fcc       "Corp."                        ; embedded text or resource bytes
                    fcb       $0D,$0D,$08,$08,$08,$08 ; table, bitmap, or initialized data bytes
                    fcb       $08,$08,$08,$08,$08,$08 ; table, bitmap, or initialized data bytes
                    fcb       $08,$08   ; table, bitmap, or initialized data bytes
                    fcc       "All Rights Reserved."         ; embedded text or resource bytes
                    fcb       $0D,$0D,$08,$08,$08,$08 ; table, bitmap, or initialized data bytes
                    fcb       $08,$08,$08,$08,$08,$08 ; table, bitmap, or initialized data bytes
                    fcb       $08,$08,$08 ; table, bitmap, or initialized data bytes
                    fcc       "Version: 01.00.00"            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_0494           fcb       $AA,$00,$88,$00 ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $02,$08,$00,$87 ; table, bitmap, or initialized data bytes
Data_049D           fcb       $AA,$00,$8C,$00 ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $02,$05,$00,$85 ; table, bitmap, or initialized data bytes
Data_04A6           fcc       "DMAPPS"                       ; embedded text or resource bytes
                    fcb       $0D,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "was not found or was "        ; embedded text or resource bytes
                    fcc       "misread."                     ; embedded text or resource bytes
                    fcb       $0D,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "Press any key to exit"        ; embedded text or resource bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_04E4           fcc       "This folder is empty"         ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_04F9           pshs      Y,X,D     ; preserve the listed registers on the stack
                    lda       #$05      ; load the value needed by the following operation
                    leax      >Data_04A6,PCR ; form the referenced address without reading memory
                    os9       I$Open    ; request the named OS-9 service
                    bcs       Code_051D ; branch when carry reports an unsigned underflow or error
                    sta       Data_005B ; save the current value in working storage
                    clr       Code_0032 ; clear the selected byte or register
Code_050A           lda       Data_005B ; load the value needed by the following operation
                    leax      $1262,U   ; form the referenced address without reading memory
                    ldy       #Data_0173 ; load the value needed by the following operation
                    os9       I$Read    ; request the named OS-9 service
                    bcc       Code_0545 ; branch when carry is clear
                    cmpb      #$D3      ; compare against the limit and set condition flags
                    beq       Code_0575 ; branch when the compared values are equal
Code_051D           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "-"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $00       ; private DeskMate service selector
Code_0525           ldd       #Data_0300 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      Data_04A6,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1C       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "N"                            ; embedded text or resource bytes
                    dec       $08,X     ; decrement the selected counter
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "W"                            ; embedded text or resource bytes
Code_0545           leay      $01B4,U   ; form the referenced address without reading memory
                    ldb       #$0D      ; load the value needed by the following operation
                    bsr       Code_057C ; call the referenced helper routine
                    leay      $0284,U   ; form the referenced address without reading memory
                    ldb       #$0D      ; load the value needed by the following operation
                    bsr       Code_057C ; call the referenced helper routine
                    leay      $0354,U   ; form the referenced address without reading memory
                    ldb       #$03      ; load the value needed by the following operation
                    bsr       Code_057C ; call the referenced helper routine
                    leay      $0384,U   ; form the referenced address without reading memory
                    ldb       #$F3      ; load the value needed by the following operation
                    bsr       Code_057C ; call the referenced helper routine
                    leay      $0B22,U   ; form the referenced address without reading memory
                    ldb       #$63      ; load the value needed by the following operation
                    bsr       Code_057C ; call the referenced helper routine
                    inc       Code_0032 ; advance the selected counter
                    lda       #$08      ; load the value needed by the following operation
                    cmpa      Code_0032 ; compare against the limit and set condition flags
                    bne       Code_050A ; branch when the compared values differ
Code_0575           lda       Data_005B ; load the value needed by the following operation
                    os9       I$Close   ; request the named OS-9 service
                    puls      PC,Y,X,D  ; restore the listed registers from the stack
Code_057C           lda       Code_0032 ; load the value needed by the following operation
                    stb       Data_005C ; save the current value in working storage
                    mul                 ; multiply the two eight-bit accumulators
                    leay      D,Y       ; form the referenced address without reading memory
                    ldb       Data_005C ; load the value needed by the following operation
Code_0585           lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,Y+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bne       Code_0585 ; branch when the compared values differ
                    rts                 ; return to the caller
Code_058D           pshs      Y,X,D     ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "N"                            ; embedded text or resource bytes
                    ldd       Addr_002E ; load the value needed by the following operation
                    std       $11,Y     ; save the current value in working storage
                    lda       Data_003B ;0598: 96 3B          '. ; load the value needed by the following operation
                    sta       $13,Y     ; save the current value in working storage
                    puls      PC,Y,X,D  ; restore the listed registers from the stack
Code_059F           rts                 ; return to the caller
Code_05A0           rts                 ; return to the caller
Data_05A1           fcc       " Files "                      ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_05A9           fcc       " Folder "                     ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_05B2           fcc       " Disk "                       ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_05B9           fcc       " Programs in fo"              ; embedded text or resource bytes
Data_05C8           fcc       "lder   "                      ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_05D0           fcc       " Data files in folder"        ; embedded text or resource bytes
                    fcc       "   "                          ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_05E9           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    lbsr      Code_0613 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    lbsr      Code_0774 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_05F8           pshs      Y,X,A     ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    lda       #$AA      ; load the value needed by the following operation
                    ldx       #DeskMateService ; load the value needed by the following operation
                    ldy       #Addr_0E4E ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0E       ; private DeskMate service selector
                    bsr       Code_0613 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    puls      PC,Y,X,A  ; restore the listed registers from the stack
Code_0613           pshs      X,D       ; preserve the listed registers on the stack
                    lbsr      Code_0670 ; call the referenced helper routine
                    lbsr      Code_0685 ; call the referenced helper routine
                    lbsr      Code_069A ; call the referenced helper routine
                    ldd       #Data_0137 ; load the value needed by the following operation
                    leax      Data_0035,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    ldd       #Data_0141 ; load the value needed by the following operation
                    leax      Data_0068,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    ldd       #Data_013C ; load the value needed by the following operation
                    leax      Data_009B,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    ldd       #Data_0146 ; load the value needed by the following operation
                    leax      Data_00CE,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    puls      PC,X,D    ; restore the listed registers from the stack
Data_064C           fcb       $00,$1C,$00 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "F"                            ; embedded text or resource bytes
                    fcb       $00,$94,$00,$B4,$00,$A4 ; table, bitmap, or initialized data bytes
                    fcb       $00,$C4   ; table, bitmap, or initialized data bytes
Data_065A           fcb       $00,$16,$00 ; table, bitmap, or initialized data bytes
                    fcc       "+"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "@"                            ; embedded text or resource bytes
                    fcb       $00,$8C,$00,$AC,$00,$9C ; table, bitmap, or initialized data bytes
                    fcb       $00,$BC   ; table, bitmap, or initialized data bytes
                    pshs      X,D       ; preserve the listed registers on the stack
                    lda       #$40      ; load the value needed by the following operation
                    sta       Data_005B ; save the current value in working storage
                    bra       Code_0674 ; continue at the selected control-flow target
Code_0670           pshs      X,D       ; preserve the listed registers on the stack
                    clr       Data_005B ; clear the selected byte or register
Code_0674           ldd       #Addr_0001 ; load the value needed by the following operation
                    leax      Data_05A1,PCR ; form the referenced address without reading memory
                    bra       Code_06A5 ; continue at the selected control-flow target
                    pshs      X,D       ; preserve the listed registers on the stack
                    lda       #$40      ; load the value needed by the following operation
                    sta       Data_005B ; save the current value in working storage
                    bra       Code_0689 ; continue at the selected control-flow target
Code_0685           pshs      X,D       ; preserve the listed registers on the stack
                    clr       Data_005B ; clear the selected byte or register
Code_0689           ldd       #Addr_0007 ; load the value needed by the following operation
                    leax      Data_05A9,PCR ; form the referenced address without reading memory
                    bra       Code_06A5 ; continue at the selected control-flow target
                    pshs      X,D       ; preserve the listed registers on the stack
                    lda       #$40      ; load the value needed by the following operation
                    sta       Data_005B ; save the current value in working storage
                    bra       Code_069E ; continue at the selected control-flow target
Code_069A           pshs      X,D       ; preserve the listed registers on the stack
                    clr       Data_005B ; clear the selected byte or register
Code_069E           ldd       #Addr_000E ; load the value needed by the following operation
                    leax      Data_05B2,PCR ; form the referenced address without reading memory
Code_06A5           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    lda       #$03      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    clra                ; clear the selected byte or register
                    ldb       Data_005B ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    puls      PC,X,D    ; restore the listed registers from the stack
Data_06BC           fcb       $00,$01,$B8,$00,$00,$01 ; table, bitmap, or initialized data bytes
                    fcb       $D8,$00,$0D ; table, bitmap, or initialized data bytes
Data_06C5           fcb       $00,$01,$E0,$00,$00,$02 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$0D ; table, bitmap, or initialized data bytes
Data_06CE           fcb       $00,$02,$08,$00,$00,$02 ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $00,$0D   ; table, bitmap, or initialized data bytes
Data_06D7           fcb       $00,$02   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $00,$00,$02 ; table, bitmap, or initialized data bytes
                    fcc       "R"                            ; embedded text or resource bytes
                    fcb       $00,$0D   ; table, bitmap, or initialized data bytes
                    pshs      X,D       ; preserve the listed registers on the stack
                    lda       #$FF      ; load the value needed by the following operation
                    bra       Code_06EA ; continue at the selected control-flow target
                    pshs      X,D       ; preserve the listed registers on the stack
                    lda       #$AA      ; load the value needed by the following operation
Code_06EA           leax      >Data_06BC,PCR ; form the referenced address without reading memory
                    bra       Code_071E ; continue at the selected control-flow target
                    pshs      X,D       ; preserve the listed registers on the stack
                    lda       #$FF      ; load the value needed by the following operation
                    bra       Code_06FA ; continue at the selected control-flow target
                    pshs      X,D       ; preserve the listed registers on the stack
                    lda       #$AA      ; load the value needed by the following operation
Code_06FA           leax      >Data_06CE,PCR ; form the referenced address without reading memory
                    bra       Code_071E ; continue at the selected control-flow target
                    pshs      X,D       ; preserve the listed registers on the stack
Code_0702           lda       #$FF      ; load the value needed by the following operation
                    bra       Code_070A ; continue at the selected control-flow target
Code_0706           pshs      X,D       ; preserve the listed registers on the stack
                    lda       #$AA      ; load the value needed by the following operation
Code_070A           leax      >Data_06C5,PCR ; form the referenced address without reading memory
                    bra       Code_071E ; continue at the selected control-flow target
                    pshs      X,D       ; preserve the listed registers on the stack
                    lda       #$FF      ; load the value needed by the following operation
                    bra       Code_071A ; continue at the selected control-flow target
                    pshs      X,D       ; preserve the listed registers on the stack
                    lda       #$AA      ; load the value needed by the following operation
Code_071A           leax      >Data_06D7,PCR ; form the referenced address without reading memory
Code_071E           sta       ,X        ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $13       ; private DeskMate service selector
                    puls      PC,X,D    ; restore the listed registers from the stack
Data_0726           fcb       $FF,$00,$0B,$00,$1C,$01 ; table, bitmap, or initialized data bytes
                    fcb       $FB,$00,$B8 ; table, bitmap, or initialized data bytes
Data_072F           fcb       $FF,$00,$0A,$00,$1B,$01 ; table, bitmap, or initialized data bytes
                    fcb       $FC,$00,$B9 ; table, bitmap, or initialized data bytes
Data_0738           fcb       $FF,$00,$09,$00,$1A,$01 ; table, bitmap, or initialized data bytes
                    fcb       $FD,$00,$BA ; table, bitmap, or initialized data bytes
Data_0741           fcb       $FF,$00,$08,$00,$19,$01 ; table, bitmap, or initialized data bytes
                    fcb       $FE,$00,$BB ; table, bitmap, or initialized data bytes
Data_074A           fcb       $FF,$00,$07,$00,$19,$01 ; table, bitmap, or initialized data bytes
                    fcb       $FF,$00,$BB ; table, bitmap, or initialized data bytes
Data_0753           fcb       $FF,$00   ; table, bitmap, or initialized data bytes
                    fcc       "j"                            ; embedded text or resource bytes
                    fcb       $00,$15,$01,$99,$00 ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
Data_075C           fcb       $FF,$00   ; table, bitmap, or initialized data bytes
                    fcc       "i"                            ; embedded text or resource bytes
                    fcb       $00,$14,$01,$9A,$00,$22 ; table, bitmap, or initialized data bytes
Data_0765           fcb       $FF,$00   ; table, bitmap, or initialized data bytes
                    fcc       "h"                            ; embedded text or resource bytes
                    fcb       $00,$13,$01,$9B,$00 ; table, bitmap, or initialized data bytes
                    fcc       "#"                            ; embedded text or resource bytes
Data_076E           fcc       "Trash"                        ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_0774           pshs      Y,X,D     ; preserve the listed registers on the stack
                    lbsr      Code_08FA ; call the referenced helper routine
                    leax      >Data_074A,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $13       ; private DeskMate service selector
                    lbsr      Code_093D ; call the referenced helper routine
                    leax      >Data_0741,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $13       ; private DeskMate service selector
                    lbsr      Code_093D ; call the referenced helper routine
                    leax      >Data_0738,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $13       ; private DeskMate service selector
                    lbsr      Code_093D ; call the referenced helper routine
                    leax      >Data_072F,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $13       ; private DeskMate service selector
                    lbsr      Code_093D ; call the referenced helper routine
                    leax      Data_0726,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $13       ; private DeskMate service selector
                    lbsr      Code_093D ; call the referenced helper routine
                    lda       #$55      ; load the value needed by the following operation
                    ldx       #Data_160D ; load the value needed by the following operation
                    ldy       #Addr_0D26 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0E       ; private DeskMate service selector
                    leax      >Data_0765,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $13       ; private DeskMate service selector
                    lbsr      Code_093D ; call the referenced helper routine
                    leax      >Data_075C,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $13       ; private DeskMate service selector
                    lbsr      Code_093D ; call the referenced helper routine
                    leax      Data_0753,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $13       ; private DeskMate service selector
                    lbsr      Code_093D ; call the referenced helper routine
                    ldd       #Data_0307 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    leax      $0120,U   ; form the referenced address without reading memory
                    leay      Data_05B9,PCR ; form the referenced address without reading memory
                    tst       Code_002C ; set condition flags from the current value
                    beq       Code_07F5 ; branch when the compared values are equal
                    leay      Data_05D0,PCR ; form the referenced address without reading memory
Code_07F5           lda       ,Y+       ; fetch the next value and advance the source pointer
                    sta       ,X+       ; store the value and advance the destination pointer
                    bne       Code_07F5 ; branch when the compared values differ
                    lda       Addr_002E ; load the value needed by the following operation
                    adda      #$30      ; add the operand to the running value
                    sta       -$03,X    ; save the current value in working storage
Code_0801           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "2"                            ; embedded text or resource bytes
                    clra                ; clear the selected byte or register
                    ldb       #$40      ; load the value needed by the following operation
                    leax      $0120,U   ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "6"                            ; embedded text or resource bytes
Code_0810           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "1"                            ; embedded text or resource bytes
                    puls      PC,Y,X,D  ; restore the listed registers from the stack
Code_0816           pshs      X,D       ; preserve the listed registers on the stack
                    lbsr      Code_090B ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    ldb       #$04      ; load the value needed by the following operation
                    std       Data_005B ; save the current value in working storage
Code_0820           lda       #$20      ; load the value needed by the following operation
                    ldb       Data_005B ; load the value needed by the following operation
                    leax      Data_01E2,PCR ; form the referenced address without reading memory
                    cmpb      #$02      ; compare against the limit and set condition flags
                    bcs       Code_0830 ; branch when carry reports an unsigned underflow or error
                    leax      Data_0147,PCR ; form the referenced address without reading memory
Code_0830           mul                 ; multiply the two eight-bit accumulators
                    tfr       B,A       ; copy the source register into the destination register
                    clrb                ; clear the selected byte or register
                    addd      #Code_2141 ; add the operand to the running value
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    lda       #$04      ; load the value needed by the following operation
                    ldb       Data_005B ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    tfr       B,A       ; copy the source register into the destination register
                    clrb                ; clear the selected byte or register
                    addd      #Code_0525 ; add the operand to the running value
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    lda       Data_005B ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
                    adda      #$31      ; add the operand to the running value
                    ldb       #$40      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $01       ; private DeskMate service selector
                    inc       Data_005B ; advance the selected counter
                    dec       Data_005C ; decrement the selected counter
                    bne       Code_0820 ; branch when the compared values differ
                    ldd       #Addr_9F42 ; load the value needed by the following operation
                    leax      Data_027D,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    ldd       #Addr_1721 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    leax      Data_076E,PCR ; form the referenced address without reading memory
                    clra                ; clear the selected byte or register
                    ldb       #$40      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "2"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "6"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "1"                            ; embedded text or resource bytes
                    ldd       #Addr_0004 ; load the value needed by the following operation
Code_0883           lbsr      Code_0894 ; call the referenced helper routine
                    decb                ; decrement the selected counter
                    bne       Code_0883 ; branch when the compared values differ
                    puls      PC,X,D    ; restore the listed registers from the stack
Data_088B           fcb       $00,$02   ; table, bitmap, or initialized data bytes
                    fcc       "N"                            ; embedded text or resource bytes
                    fcb       $00,$00,$02 ; table, bitmap, or initialized data bytes
                    fcc       "a"                            ; embedded text or resource bytes
                    fcb       $00,$00   ; table, bitmap, or initialized data bytes
Code_0894           pshs      X,D       ; preserve the listed registers on the stack
                    leax      >Data_088B,PCR ; form the referenced address without reading memory
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    bne       Code_08A1 ; branch when the compared values differ
                    coma                ; invert every bit in the selected value
                    bra       Code_08AA ; continue at the selected control-flow target
Code_08A1           cmpa      #$00      ; compare against the limit and set condition flags
                    bne       Code_08A8 ; branch when the compared values differ
                    coma                ; invert every bit in the selected value
                    bra       Code_08AA ; continue at the selected control-flow target
Code_08A8           lda       #$AA      ; load the value needed by the following operation
Code_08AA           sta       ,X        ; save the current value in working storage
                    lda       #$20      ; load the value needed by the following operation
                    decb                ; decrement the selected counter
                    mul                 ; multiply the two eight-bit accumulators
                    std       Data_005B ; save the current value in working storage
                    addd      #Data_0027 ; add the operand to the running value
                    std       $03,X     ; save the current value in working storage
                    ldd       #Code_0030 ; load the value needed by the following operation
                    addd      Data_005B ; add the operand to the running value
                    std       $07,X     ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $13       ; private DeskMate service selector
                    leax      >Data_088B,PCR ; form the referenced address without reading memory
                    ldd       $01,X     ; load the value needed by the following operation
                    subd      #Addr_0001 ; subtract the operand from the running value
                    std       $01,X     ; save the current value in working storage
                    ldd       $03,X     ; load the value needed by the following operation
                    subd      #Addr_0001 ; subtract the operand from the running value
                    std       $03,X     ; save the current value in working storage
                    ldd       $05,X     ; load the value needed by the following operation
                    addd      #Addr_0001 ; add the operand to the running value
                    std       $05,X     ; save the current value in working storage
                    ldd       $07,X     ; load the value needed by the following operation
                    addd      #Addr_0001 ; add the operand to the running value
                    std       $07,X     ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $13       ; private DeskMate service selector
                    leax      >Data_088B,PCR ; form the referenced address without reading memory
                    ldd       $01,X     ; load the value needed by the following operation
                    addd      #Addr_0001 ; add the operand to the running value
                    std       $01,X     ; save the current value in working storage
                    ldd       $05,X     ; load the value needed by the following operation
                    subd      #Addr_0001 ; subtract the operand from the running value
                    std       $05,X     ; save the current value in working storage
                    puls      PC,X,D    ; restore the listed registers from the stack
Code_08FA           pshs      Y,X,A     ; preserve the listed registers on the stack
                    lda       #$55      ; load the value needed by the following operation
                    ldx       #Addr_1D01 ; load the value needed by the following operation
                    ldy       #Addr_9F3F ; load the value needed by the following operation
Code_0905           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0E       ; private DeskMate service selector
                    puls      PC,Y,X,A  ; restore the listed registers from the stack
Code_090B           pshs      Y,X,D     ; preserve the listed registers on the stack
                    ldb       #$0E      ; load the value needed by the following operation
Code_090F           tfr       B,A       ; copy the source register into the destination register
                    clrb                ; clear the selected byte or register
                    tfr       D,X       ; copy the source register into the destination register
                    tfr       A,B       ; copy the source register into the destination register
                    lda       #$99      ; load the value needed by the following operation
                    ldy       #Data_014E ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0E       ; private DeskMate service selector
                    incb                ; advance the selected counter
                    cmpb      #$C8      ; compare against the limit and set condition flags
                    bhi       Code_093B ; branch when the unsigned value is above the limit
                    tfr       B,A       ; copy the source register into the destination register
                    clrb                ; clear the selected byte or register
                    tfr       D,X       ; copy the source register into the destination register
                    tfr       A,B       ; copy the source register into the destination register
                    lda       #$66      ; load the value needed by the following operation
                    ldy       #Data_014E ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0E       ; private DeskMate service selector
                    incb                ; advance the selected counter
                    cmpb      #$C8      ; compare against the limit and set condition flags
                    bcs       Code_090F ; branch when carry reports an unsigned underflow or error
Code_093B           puls      PC,Y,X,D  ; restore the listed registers from the stack
Code_093D           pshs      U,Y,X,D   ; preserve the listed registers on the stack
                    pshs      X         ; preserve the listed registers on the stack
                    clrb                ; clear the selected byte or register
                    ldy       $03,X     ; load the value needed by the following operation
                    ldu       $07,X     ; load the value needed by the following operation
                    ldx       $05,X     ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $12       ; private DeskMate service selector
                    puls      X         ; restore the listed registers from the stack
                    ldy       $07,X     ; load the value needed by the following operation
                    ldu       $05,X     ; load the value needed by the following operation
                    ldx       $01,X     ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $11       ; private DeskMate service selector
                    puls      PC,U,Y,X,D ; restore the listed registers from the stack
                    fcb       $FF,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00 ; table, bitmap, or initialized data bytes
Code_0965           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    clr       Code_002C ; clear the selected byte or register
                    ldu       DeskMateService ; load the value needed by the following operation
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    std       Data_0037 ; save the current value in working storage
                    clr       Data_0036 ; clear the selected byte or register
                    clr       Data_0035 ; clear the selected byte or register
                    lbsr      Code_0816 ; call the referenced helper routine
                    lda       #$55      ; load the value needed by the following operation
                    ldb       Addr_002E ; load the value needed by the following operation
                    lbsr      Code_0894 ; call the referenced helper routine
                    lbsr      Code_05E9 ; call the referenced helper routine
                    lbsr      Code_09AF ; call the referenced helper routine
                    lbsr      Code_0A64 ; call the referenced helper routine
                    lda       #$FF      ; load the value needed by the following operation
                    lbsr      Code_0CAD ; call the referenced helper routine
                    lbra      Code_0CFA ; continue at the distant control-flow target
Data_0990           fcc       "Can't open or read th"        ; embedded text or resource bytes
                    fcc       "is folder"                    ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_09AF           pshs      Y,X,D     ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "2"                            ; embedded text or resource bytes
                    leax      $63,U     ; form the referenced address without reading memory
                    lda       #$07      ; load the value needed by the following operation
Code_09BA           clr       A,X       ; clear the selected byte or register
                    deca                ; decrement the selected counter
                    bpl       Code_09BA ; branch while the tested value is nonnegative
                    clr       Addr_002D ; clear the selected byte or register
                    clr       Addr_0033 ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "N"                            ; embedded text or resource bytes
                    leax      $26,X     ; form the referenced address without reading memory
                    lda       Addr_002E ; load the value needed by the following operation
                    sta       Data_002F ; save the current value in working storage
                    ldb       #$29      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    leax      D,X       ; form the referenced address without reading memory
                    lda       ,X        ; load the value needed by the following operation
                    bne       Code_09E0 ; branch when the compared values differ
                    ldd       #Addr_2E00 ; load the value needed by the following operation
                    leax      $0120,U   ; form the referenced address without reading memory
                    std       ,X        ; save the current value in working storage
Code_09E0           lda       #$85      ; load the value needed by the following operation
                    os9       I$Open    ; request the named OS-9 service
                    bcs       Code_0A2A ; branch when carry reports an unsigned underflow or error
                    sta       Addr_002D ; save the current value in working storage
Code_09E9           lda       Addr_002D ; load the value needed by the following operation
                    leax      $0120,U   ; form the referenced address without reading memory
                    ldy       #Code_0020 ; load the value needed by the following operation
                    os9       I$Read    ; request the named OS-9 service
                    bcs       Code_0A2A ; branch when carry reports an unsigned underflow or error
                    lda       Code_0032 ; load the value needed by the following operation
                    deca                ; decrement the selected counter
                    sta       Data_005B ; save the current value in working storage
                    ldb       #$0D      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    leay      $01B4,U   ; form the referenced address without reading memory
                    leay      D,Y       ; form the referenced address without reading memory
                    leax      $0120,U   ; form the referenced address without reading memory
Code_0A0A           ldb       #$0C      ; load the value needed by the following operation
Code_0A0C           lda       B,X       ; load the value needed by the following operation
                    anda      #$DF      ; mask off unwanted bits
                    cmpa      B,Y       ; compare against the limit and set condition flags
                    bne       Code_0A22 ; branch when the compared values differ
                    decb                ; decrement the selected counter
                    bpl       Code_0A0C ; branch while the tested value is nonnegative
                    lda       #$FF      ; load the value needed by the following operation
                    ldb       Data_005B ; load the value needed by the following operation
                    leax      $63,U     ; form the referenced address without reading memory
                    sta       B,X       ; save the current value in working storage
                    bra       Code_09E9 ; continue at the selected control-flow target
Code_0A22           leay      -$0D,Y    ; form the referenced address without reading memory
                    dec       Data_005B ; decrement the selected counter
                    bpl       Code_0A0A ; branch while the tested value is nonnegative
                    bra       Code_09E9 ; continue at the selected control-flow target
Code_0A2A           cmpb      #$D3      ; compare against the limit and set condition flags
                    bne       Code_0A45 ; branch when the compared values differ
                    lda       #$FF      ; load the value needed by the following operation
                    leax      $63,U     ; form the referenced address without reading memory
                    leay      $73,U     ; form the referenced address without reading memory
Code_0A36           inca                ; advance the selected counter
                    cmpa      #$08      ; compare against the limit and set condition flags
                    beq       Code_0A57 ; branch when the compared values are equal
                    tst       ,X+       ; set condition flags from the current value
                    beq       Code_0A36 ; branch when the compared values are equal
                    sta       ,Y+       ; store the value and advance the destination pointer
                    inc       Addr_0033 ; advance the selected counter
                    bra       Code_0A36 ; continue at the selected control-flow target
Code_0A45           ldd       #Addr_0701 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    clra                ; clear the selected byte or register
                    ldb       #$40      ; load the value needed by the following operation
                    leax      Data_0990,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "6"                            ; embedded text or resource bytes
Code_0A57           lda       Addr_002D ; load the value needed by the following operation
                    beq       Code_0A5E ; branch when the compared values are equal
                    os9       I$Close   ; request the named OS-9 service
Code_0A5E           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "1"                            ; embedded text or resource bytes
                    puls      PC,Y,X,D  ; restore the listed registers from the stack
Code_0A64           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "2"                            ; embedded text or resource bytes
                    pshs      Y,X,D     ; preserve the listed registers on the stack
                    tst       Addr_0033 ; set condition flags from the current value
                    bne       Code_0A88 ; branch when the compared values differ
                    ldd       #Code_0905 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    leax      Data_04E4,PCR ; form the referenced address without reading memory
                    clra                ; clear the selected byte or register
                    ldb       #$40      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "6"                            ; embedded text or resource bytes
                    lda       #$42      ; load the value needed by the following operation
                    ldb       #$04      ; load the value needed by the following operation
                    std       Data_0039 ; save the current value in working storage
                    bra       Code_0AF4 ; continue at the selected control-flow target
Code_0A88           lda       #$5F      ; load the value needed by the following operation
                    ldb       #$05      ; load the value needed by the following operation
                    std       Data_0039 ; save the current value in working storage
                    lda       Data_0035 ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
Code_0A91           std       Data_005B ; save the current value in working storage
                    leay      $73,U     ; form the referenced address without reading memory
                    lda       A,Y       ; load the value needed by the following operation
                    sta       Data_0060 ; save the current value in working storage
                    ldb       #$F3      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    leax      $0384,U   ; form the referenced address without reading memory
                    leax      D,X       ; form the referenced address without reading memory
                    ldb       Data_005C ; load the value needed by the following operation
                    lda       #$03      ; load the value needed by the following operation
                    lbsr      Code_0AFA ; call the referenced helper routine
                    std       Data_005D ; save the current value in working storage
                    ldb       #$38      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    stb       Data_005F ; save the current value in working storage
                    lda       Data_005E ; load the value needed by the following operation
                    ldb       #$14      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    lda       Data_005F ; load the value needed by the following operation
                    addd      #Addr_2707 ; add the operand to the running value
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    lda       Data_005D ; load the value needed by the following operation
                    ldb       #$07      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    stb       Data_005F ; save the current value in working storage
                    lda       Data_005E ; load the value needed by the following operation
                    ldb       #$0A      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    lda       Data_005F ; load the value needed by the following operation
                    addd      #Addr_0803 ; add the operand to the running value
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    lda       Data_005B ; load the value needed by the following operation
                    lda       Data_0060 ; load the value needed by the following operation
                    ldb       #$0D      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    leax      $0284,U   ; form the referenced address without reading memory
                    leax      D,X       ; form the referenced address without reading memory
                    clra                ; clear the selected byte or register
                    ldb       #$40      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "6"                            ; embedded text or resource bytes
                    ldd       Data_005B ; load the value needed by the following operation
                    incb                ; advance the selected counter
                    cmpb      #$08      ; compare against the limit and set condition flags
                    beq       Code_0AF4 ; branch when the compared values are equal
                    inca                ; advance the selected counter
                    cmpa      Addr_0033 ; compare against the limit and set condition flags
                    bne       Code_0A91 ; branch when the compared values differ
Code_0AF4           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "1"                            ; embedded text or resource bytes
                    puls      PC,Y,X,D  ; restore the listed registers from the stack
Code_0AFA           sta       Data_005D ; save the current value in working storage
                    clra                ; clear the selected byte or register
Code_0AFD           subb      Data_005D ; subtract the operand from the running value
                    bcs       Code_0B04 ; branch when carry reports an unsigned underflow or error
                    inca                ; advance the selected counter
                    bra       Code_0AFD ; continue at the selected control-flow target
Code_0B04           addb      Data_005D ; add the operand to the running value
                    rts                 ; return to the caller
Code_0B07           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Code_002C ; save the current value in working storage
                    ldu       DeskMateService ; load the value needed by the following operation
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    std       Data_0037 ; save the current value in working storage
                    clr       Data_0036 ; clear the selected byte or register
                    clr       Data_0035 ; clear the selected byte or register
                    lbsr      Code_0816 ; call the referenced helper routine
                    lda       #$55      ; load the value needed by the following operation
                    ldb       Addr_002E ; load the value needed by the following operation
                    lbsr      Code_0894 ; call the referenced helper routine
                    lbsr      Code_05E9 ; call the referenced helper routine
                    lbsr      Code_0B34 ; call the referenced helper routine
                    lbsr      Code_0BFC ; call the referenced helper routine
                    lda       #$FF      ; load the value needed by the following operation
                    lbsr      Code_0CAD ; call the referenced helper routine
                    lbra      Code_0CFA ; continue at the distant control-flow target
Code_0B34           pshs      Y,X,D     ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "2"                            ; embedded text or resource bytes
                    ldd       #Data_05C8 ; load the value needed by the following operation
                    leax      $1162,U   ; form the referenced address without reading memory
                    leay      $1262,U   ; form the referenced address without reading memory
Code_0B45           clr       D,Y       ; clear the selected byte or register
                    subd      #Addr_0001 ; subtract the operand from the running value
                    bne       Code_0B45 ; branch when the compared values differ
                    ldb       #$80      ; load the value needed by the following operation
Code_0B4E           sty       ,X++      ; store the value and advance the destination pointer
                    leay      $0A,Y     ; form the referenced address without reading memory
                    decb                ; decrement the selected counter
                    bne       Code_0B4E ; branch when the compared values differ
                    clr       Addr_002D ; clear the selected byte or register
                    clr       Addr_0034 ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "N"                            ; embedded text or resource bytes
                    leax      $26,X     ; form the referenced address without reading memory
                    lda       Addr_002E ; load the value needed by the following operation
                    ldb       #$29      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    leax      D,X       ; form the referenced address without reading memory
                    tst       ,X        ; set condition flags from the current value
                    bne       Code_0B75 ; branch when the compared values differ
                    ldd       #Addr_2E00 ; load the value needed by the following operation
                    leax      $0120,U   ; form the referenced address without reading memory
                    std       ,X        ; save the current value in working storage
Code_0B75           lda       #$81      ; load the value needed by the following operation
                    os9       I$Open    ; request the named OS-9 service
                    lbcs      Code_0A45 ; take the distant branch when carry reports an error
                    sta       Addr_002D ; save the current value in working storage
Code_0B80           lda       Addr_002D ; load the value needed by the following operation
                    leax      $0120,U   ; form the referenced address without reading memory
                    ldy       #Code_0020 ; load the value needed by the following operation
                    os9       I$Read    ; request the named OS-9 service
                    bcs       Code_0BE8 ; branch when carry reports an unsigned underflow or error
                    ldb       #$09      ; load the value needed by the following operation
Code_0B91           lda       ,X+       ; fetch the next value and advance the source pointer
                    beq       Code_0B80 ; branch when the compared values are equal
                    cmpa      #$2E      ; compare against the limit and set condition flags
                    beq       Code_0B9E ; branch when the compared values are equal
                    decb                ; decrement the selected counter
                    beq       Code_0B80 ; branch when the compared values are equal
                    bra       Code_0B91 ; continue at the selected control-flow target
Code_0B9E           lda       Code_0032 ; load the value needed by the following operation
                    deca                ; decrement the selected counter
                    sta       Data_005B ; save the current value in working storage
                    ldb       #$03      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    leay      $0354,U   ; form the referenced address without reading memory
                    leay      D,Y       ; form the referenced address without reading memory
Code_0BAC           ldb       #$02      ; load the value needed by the following operation
Code_0BAE           lda       B,X       ; load the value needed by the following operation
                    anda      #$DF      ; mask off unwanted bits
                    cmpa      B,Y       ; compare against the limit and set condition flags
                    bne       Code_0BE0 ; branch when the compared values differ
                    decb                ; decrement the selected counter
                    bpl       Code_0BAE ; branch while the tested value is nonnegative
                    leax      $0120,U   ; form the referenced address without reading memory
                    leay      $1262,U   ; form the referenced address without reading memory
                    lda       Addr_0034 ; load the value needed by the following operation
                    ldb       #$0A      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    leay      D,Y       ; form the referenced address without reading memory
                    lda       Data_005B ; load the value needed by the following operation
                    sta       ,Y+       ; store the value and advance the destination pointer
Code_0BCC           lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpa      #$2E      ; compare against the limit and set condition flags
                    beq       Code_0BD6 ; branch when the compared values are equal
                    sta       ,Y+       ; store the value and advance the destination pointer
                    bra       Code_0BCC ; continue at the selected control-flow target
Code_0BD6           inc       Addr_0034 ; advance the selected counter
                    lda       #$80      ; load the value needed by the following operation
                    cmpa      Addr_0034 ; compare against the limit and set condition flags
                    bne       Code_0B80 ; branch when the compared values differ
                    bra       Code_0BEE ; continue at the selected control-flow target
Code_0BE0           leay      -$03,Y    ; form the referenced address without reading memory
                    dec       Data_005B ; decrement the selected counter
                    bmi       Code_0B80 ; branch while the tested value is negative
                    bra       Code_0BAC ; continue at the selected control-flow target
Code_0BE8           cmpb      #$D3      ; compare against the limit and set condition flags
                    lbne      Code_0A45 ; take the distant branch when values differ
Code_0BEE           lda       Addr_002D ; load the value needed by the following operation
                    os9       I$Close   ; request the named OS-9 service
                    lbsr      Code_2713 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "1"                            ; embedded text or resource bytes
                    puls      PC,Y,X,D  ; restore the listed registers from the stack
Code_0BFC           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "2"                            ; embedded text or resource bytes
                    pshs      Y,X,D     ; preserve the listed registers on the stack
                    tst       Addr_0034 ; set condition flags from the current value
                    bne       Code_0C20 ; branch when the compared values differ
                    ldd       #Code_0905 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    leax      Data_04E4,PCR ; form the referenced address without reading memory
                    clra                ; clear the selected byte or register
                    ldb       #$40      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    lda       #$42      ; load the value needed by the following operation
                    ldb       #$04      ; load the value needed by the following operation
                    std       Data_0039 ; save the current value in working storage
                    bra       Code_0C97 ; continue at the selected control-flow target
Code_0C20           lda       #$7F      ; load the value needed by the following operation
                    ldb       #$07      ; load the value needed by the following operation
                    std       Data_0039 ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    ldb       Data_0035 ; load the value needed by the following operation
Code_0C29           std       Data_005B ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    aslb                ; shift left and update carry
                    leay      $1162,U   ; form the referenced address without reading memory
                    ldy       D,Y       ; load the value needed by the following operation
                    lda       ,Y+       ; fetch the next value and advance the source pointer
                    ldb       #$63      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    leax      $0B22,U   ; form the referenced address without reading memory
                    leax      D,X       ; form the referenced address without reading memory
                    lda       #$03      ; load the value needed by the following operation
                    ldb       Data_005B ; load the value needed by the following operation
                    lbsr      Code_0AFA ; call the referenced helper routine
                    std       Data_005D ; save the current value in working storage
                    ldb       #$20      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    stb       Data_005F ; save the current value in working storage
                    lda       #$14      ; load the value needed by the following operation
                    ldb       Data_005E ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    lda       Data_005F ; load the value needed by the following operation
                    addd      #Addr_2707 ; add the operand to the running value
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    lda       #$04      ; load the value needed by the following operation
                    ldb       Data_005D ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    stb       Data_005F ; save the current value in working storage
                    lda       #$0A      ; load the value needed by the following operation
                    ldb       Data_005E ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    lda       Data_005F ; load the value needed by the following operation
                    addd      #Code_0702 ; add the operand to the running value
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    pshs      Y         ; preserve the listed registers on the stack
                    asla                ; shift left and update carry
                    asla                ; shift left and update carry
                    asla                ; shift left and update carry
                    aslb                ; shift left and update carry
                    tfr       D,X       ; copy the source register into the destination register
                    ldy       #Code_0810 ; load the value needed by the following operation
                    lda       #$55      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0E       ; private DeskMate service selector
                    puls      X         ; restore the listed registers from the stack
                    clra                ; clear the selected byte or register
                    ldb       #$40      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "6"                            ; embedded text or resource bytes
                    ldd       Data_005B ; load the value needed by the following operation
                    incb                ; advance the selected counter
                    cmpb      Addr_0034 ; compare against the limit and set condition flags
                    beq       Code_0C97 ; branch when the compared values are equal
                    inca                ; advance the selected counter
                    cmpa      #$0C      ; compare against the limit and set condition flags
                    bne       Code_0C29 ; branch when the compared values differ
Code_0C97           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "1"                            ; embedded text or resource bytes
                    puls      PC,Y,X,D  ; restore the listed registers from the stack
Data_0C9D           fcb       $00,$0F,$00 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $00,$AF,$00 ; table, bitmap, or initialized data bytes
                    fcc       "K"                            ; embedded text or resource bytes
Data_0CA5           fcb       $00,$18,$00 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $00,$9E,$00 ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
Code_0CAD           pshs      Y,X,D     ; preserve the listed registers on the stack
                    tst       Code_002C ; set condition flags from the current value
                    bne       Code_0CC0 ; branch when the compared values differ
                    tst       Addr_0033 ; set condition flags from the current value
                    beq       Code_0CF8 ; branch when the compared values are equal
                    ldx       #Addr_A038 ; load the value needed by the following operation
                    leay      >Data_0C9D,PCR ; form the referenced address without reading memory
                    bra       Code_0CCB ; continue at the selected control-flow target
Code_0CC0           tst       Addr_0034 ; set condition flags from the current value
                    beq       Code_0CF8 ; branch when the compared values are equal
                    ldx       #Addr_A020 ; load the value needed by the following operation
                    leay      >Data_0CA5,PCR ; form the referenced address without reading memory
Code_0CCB           stx       Data_005D ; save the current value in working storage
                    leax      $52,U     ; form the referenced address without reading memory
                    sta       ,X        ; save the current value in working storage
                    lda       Data_0038 ; load the value needed by the following operation
                    ldb       Data_005D ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    std       Data_005B ; save the current value in working storage
                    addd      ,Y        ; add the operand to the running value
                    std       $01,X     ; save the current value in working storage
                    ldd       Data_005B ; load the value needed by the following operation
                    addd      $04,Y     ; add the operand to the running value
                    std       $05,X     ; save the current value in working storage
                    lda       Data_0037 ; load the value needed by the following operation
                    ldb       Data_005E ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    std       Data_005B ; save the current value in working storage
                    addd      $02,Y     ; add the operand to the running value
                    std       $03,X     ; save the current value in working storage
                    ldd       Data_005B ; load the value needed by the following operation
                    addd      $06,Y     ; add the operand to the running value
                    std       $07,X     ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $13       ; private DeskMate service selector
Code_0CF8           puls      PC,Y,X,D  ; restore the listed registers from the stack
Code_0CFA           ldb       #$80      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    clrb                ; clear the selected byte or register
                    tsta                ; set condition flags from the current value
                    lbeq      Code_1152 ; take the distant branch when values are equal
                    cmpa      #$0C      ; compare against the limit and set condition flags
                    bne       Code_0D10 ; branch when the compared values differ
Code_0D0A           lda       #$FF      ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
                    lbra      Code_0EA6 ; continue at the distant control-flow target
Code_0D10           cmpa      #$0A      ; compare against the limit and set condition flags
                    bne       Code_0D1A ; branch when the compared values differ
Code_0D14           lda       #$01      ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
                    lbra      Code_0EA6 ; continue at the distant control-flow target
Code_0D1A           cmpa      #$08      ; compare against the limit and set condition flags
                    bne       Code_0D23 ; branch when the compared values differ
                    ldb       #$FF      ; load the value needed by the following operation
                    lbra      Code_0EA5 ; continue at the distant control-flow target
Code_0D23           cmpa      #$09      ; compare against the limit and set condition flags
                    bne       Code_0D2C ; branch when the compared values differ
                    ldb       #$01      ; load the value needed by the following operation
                    lbra      Code_0EA5 ; continue at the distant control-flow target
Code_0D2C           cmpa      #$1C      ; compare against the limit and set condition flags
                    bne       Code_0D45 ; branch when the compared values differ
Code_0D30           lda       Data_0037 ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
                    nega                ; form the two's-complement negative value
                    lbne      Code_0EA6 ; take the distant branch when values differ
                    lda       #$FE      ; load the value needed by the following operation
                    tst       Code_002C ; set condition flags from the current value
                    lbeq      Code_0EA6 ; take the distant branch when values are equal
                    lda       #$FC      ; load the value needed by the following operation
                    lbra      Code_0EA6 ; continue at the distant control-flow target
Code_0D45           cmpa      #$1A      ; compare against the limit and set condition flags
                    bne       Code_0D67 ; branch when the compared values differ
Code_0D49           lda       Data_0037 ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
                    coma                ; invert every bit in the selected value
                    tst       Code_002C ; set condition flags from the current value
                    beq       Code_0D5C ; branch when the compared values are equal
                    adda      #$04      ; add the operand to the running value
                    lbne      Code_0EA6 ; take the distant branch when values differ
                    lda       #$04      ; load the value needed by the following operation
                    lbra      Code_0EA6 ; continue at the distant control-flow target
Code_0D5C           adda      #$02      ; add the operand to the running value
                    lbne      Code_0EA6 ; take the distant branch when values differ
                    lda       #$02      ; load the value needed by the following operation
                    lbra      Code_0EA6 ; continue at the distant control-flow target
Code_0D67           cmpa      #$18      ; compare against the limit and set condition flags
                    beq       Code_0D99 ; branch when the compared values are equal
                    cmpa      #$19      ; compare against the limit and set condition flags
                    beq       Code_0DA7 ; branch when the compared values are equal
                    cmpa      #$13      ; compare against the limit and set condition flags
                    bne       Code_0D7E ; branch when the compared values differ
Code_0D73           lda       Data_0036 ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
                    nega                ; form the two's-complement negative value
                    lbeq      Code_0CFA ; take the distant branch when values are equal
                    lbra      Code_0EA6 ; continue at the distant control-flow target
Code_0D7E           cmpa      #$12      ; compare against the limit and set condition flags
                    bne       Code_0D95 ; branch when the compared values differ
Code_0D82           lda       Addr_0033 ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
                    tst       Code_002C ; set condition flags from the current value
                    beq       Code_0D8B ; branch when the compared values are equal
                    lda       Addr_0034 ; load the value needed by the following operation
Code_0D8B           deca                ; decrement the selected counter
                    suba      Data_0036 ; subtract the operand from the running value
                    lbeq      Code_0CFA ; take the distant branch when values are equal
                    lbra      Code_0EA6 ; continue at the distant control-flow target
Code_0D95           cmpa      #$10      ; compare against the limit and set condition flags
                    bne       Code_0DA3 ; branch when the compared values differ
Code_0D99           ldb       Data_0038 ; load the value needed by the following operation
                    lbeq      Code_0CFA ; take the distant branch when values are equal
                    negb                ; form the two's-complement negative value
                    lbra      Code_0EA5 ; continue at the distant control-flow target
Code_0DA3           cmpa      #$11      ; compare against the limit and set condition flags
                    bne       Code_0DC0 ; branch when the compared values differ
Code_0DA7           ldb       Data_0038 ; load the value needed by the following operation
                    comb                ; invert every bit in the selected value
                    tst       Code_002C ; set condition flags from the current value
                    beq       Code_0DB7 ; branch when the compared values are equal
                    addb      #$03      ; add the operand to the running value
                    lbeq      Code_0CFA ; take the distant branch when values are equal
                    lbra      Code_0EA5 ; continue at the distant control-flow target
Code_0DB7           addb      #$03      ; add the operand to the running value
                    lbeq      Code_0CFA ; take the distant branch when values are equal
                    lbra      Code_0EA5 ; continue at the distant control-flow target
Code_0DC0           cmpa      #$B5      ; compare against the limit and set condition flags
                    bne       Code_0DD6 ; branch when the compared values differ
Code_0DC4           lda       Data_0039 ; load the value needed by the following operation
                    bita      #$10      ; test the selected flag bits without changing the value
                    lbeq      Code_0CFA ; take the distant branch when values are equal
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Code_0030 ; save the current value in working storage
                    lbsr      Code_236D ; call the referenced helper routine
                    lbra      Code_102E ; continue at the distant control-flow target
Code_0DD6           cmpa      #$B6      ; compare against the limit and set condition flags
                    bne       Code_0DEC ; branch when the compared values differ
                    lda       Data_0039 ; load the value needed by the following operation
                    bita      #$20      ; test the selected flag bits without changing the value
                    lbeq      Code_0CFA ; take the distant branch when values are equal
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Code_0030 ; save the current value in working storage
                    lbsr      Code_247B ; call the referenced helper routine
                    lbra      Code_102E ; continue at the distant control-flow target
Code_0DEC           cmpa      #$0D      ; compare against the limit and set condition flags
                    bne       Code_0DFB ; branch when the compared values differ
                    lda       Data_0039 ; load the value needed by the following operation
                    bita      #$01      ; test the selected flag bits without changing the value
                    lbne      Code_16DE ; take the distant branch when values differ
                    lbra      Code_0CFA ; continue at the distant control-flow target
Code_0DFB           cmpa      #$8C      ; compare against the limit and set condition flags
                    lbeq      Code_0FAA ; take the distant branch when values are equal
                    cmpa      #$89      ; compare against the limit and set condition flags
                    lbeq      Code_10A1 ; take the distant branch when values are equal
                    bra       Code_0E18 ; continue at the selected control-flow target
                    fcb       $17,$F2,$07 ; table, bitmap, or initialized data bytes
                    fcc       "Nj"                           ; embedded text or resource bytes
                    fcb       $08       ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $A7,$A8,$10 ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $17,$F1,$FC ; table, bitmap, or initialized data bytes
                    fcc       "W"                            ; embedded text or resource bytes
Code_0E18           cmpa      #$AF      ; compare against the limit and set condition flags
                    bne       Code_0E23 ; branch when the compared values differ
Code_0E1C           clra                ; clear the selected byte or register
                    lbsr      Code_13F8 ; call the referenced helper routine
                    lbra      Code_102E ; continue at the distant control-flow target
Code_0E23           cmpa      #$BA      ; compare against the limit and set condition flags
                    lbeq      Code_1399 ; take the distant branch when values are equal
                    cmpa      #$B7      ; compare against the limit and set condition flags
                    bne       Code_0E3F ; branch when the compared values differ
                    lda       #$04      ; load the value needed by the following operation
                    anda      Data_0039 ; mask off unwanted bits
                    lbeq      Code_0CFA ; take the distant branch when values are equal
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Code_0030 ; save the current value in working storage
                    lbsr      Code_1863 ; call the referenced helper routine
                    lbra      Code_102E ; continue at the distant control-flow target
Code_0E3F           cmpa      #$B3      ; compare against the limit and set condition flags
                    bne       Code_0E55 ; branch when the compared values differ
Code_0E43           lda       #$08      ; load the value needed by the following operation
                    anda      Data_0039 ; mask off unwanted bits
                    lbeq      Code_0CFA ; take the distant branch when values are equal
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Code_0030 ; save the current value in working storage
                    lbsr      Code_1CFA ; call the referenced helper routine
                    lbra      Code_102E ; continue at the distant control-flow target
Code_0E55           cmpa      #$B8      ; compare against the limit and set condition flags
                    bne       Code_0E6B ; branch when the compared values differ
                    lda       #$02      ; load the value needed by the following operation
                    anda      Data_003A ; mask off unwanted bits
                    lbeq      Code_0CFA ; take the distant branch when values are equal
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Code_0030 ; save the current value in working storage
                    lbsr      Code_26C2 ; call the referenced helper routine
                    lbra      Code_102E ; continue at the distant control-flow target
Code_0E6B           cmpa      #$B2      ; compare against the limit and set condition flags
                    bne       Code_0E81 ; branch when the compared values differ
                    lda       #$01      ; load the value needed by the following operation
                    anda      Data_003A ; mask off unwanted bits
                    lbeq      Code_0CFA ; take the distant branch when values are equal
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Code_0030 ; save the current value in working storage
                    lbsr      Code_289B ; call the referenced helper routine
                    lbra      Code_102E ; continue at the distant control-flow target
Code_0E81           cmpa      #$E3      ; compare against the limit and set condition flags
                    bne       Code_0E8A ; branch when the compared values differ
                    ldx       #DeskMateService ; load the value needed by the following operation
                    bra       Code_0E9C ; continue at the selected control-flow target
Code_0E8A           cmpa      #$ED      ; compare against the limit and set condition flags
                    bne       Code_0E93 ; branch when the compared values differ
                    ldx       #Addr_0002 ; load the value needed by the following operation
                    bra       Code_0E9C ; continue at the selected control-flow target
Code_0E93           cmpa      #$F2      ; compare against the limit and set condition flags
                    lbne      Code_0CFA ; take the distant branch when values differ
                    ldx       #Addr_0001 ; load the value needed by the following operation
Code_0E9C           clra                ; clear the selected byte or register
                    ldb       #$92      ; load the value needed by the following operation
                    os9       I$SetStt  ; request the named OS-9 service
                    lbra      Code_0CFA ; continue at the distant control-flow target
Code_0EA5           clra                ; clear the selected byte or register
Code_0EA6           clr       Data_003D ; clear the selected byte or register
Code_0EA8           stb       Data_005B ; save the current value in working storage
                    tst       Code_002C ; set condition flags from the current value
                    bne       Code_0F1D ; branch when the compared values differ
                    tst       Addr_0033 ; set condition flags from the current value
                    lbeq      Code_0CFA ; take the distant branch when values are equal
                    ldb       #$03      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    addb      Data_005B ; add the operand to the running value
                    addb      Data_0036 ; add the operand to the running value
                    bpl       Code_0EBE ; branch while the tested value is nonnegative
                    clrb                ; clear the selected byte or register
Code_0EBE           cmpb      Addr_0033 ; compare against the limit and set condition flags
                    bcs       Code_0ECB ; branch when carry reports an unsigned underflow or error
                    tst       Data_003D ; set condition flags from the current value
                    lbne      Code_0CFA ; take the distant branch when values differ
                    ldb       Addr_0033 ; load the value needed by the following operation
                    decb                ; decrement the selected counter
Code_0ECB           cmpb      Data_0036 ; compare against the limit and set condition flags
                    lbeq      Code_0CFA ; take the distant branch when values are equal
                    lda       #$55      ; load the value needed by the following operation
                    lbsr      Code_0CAD ; call the referenced helper routine
                    stb       Data_0036 ; save the current value in working storage
                    clr       Data_005B ; clear the selected byte or register
Code_0EDA           cmpb      Data_0035 ; compare against the limit and set condition flags
                    bcc       Code_0EEA ; branch when carry is clear
                    lda       Data_0035 ; load the value needed by the following operation
                    suba      #$03      ; subtract the operand from the running value
                    sta       Data_0035 ; save the current value in working storage
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Data_005B ; save the current value in working storage
                    bra       Code_0EDA ; continue at the selected control-flow target
Code_0EEA           lda       Data_0035 ; load the value needed by the following operation
                    adda      #$08      ; add the operand to the running value
                    sta       Data_005C ; save the current value in working storage
                    cmpb      Data_005C ; compare against the limit and set condition flags
                    bcs       Code_0F00 ; branch when carry reports an unsigned underflow or error
                    lda       Data_0035 ; load the value needed by the following operation
                    adda      #$03      ; add the operand to the running value
                    sta       Data_0035 ; save the current value in working storage
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Data_005B ; save the current value in working storage
                    bra       Code_0EEA ; continue at the selected control-flow target
Code_0F00           tst       Data_005B ; set condition flags from the current value
                    beq       Code_0F14 ; branch when the compared values are equal
                    lda       #$55      ; load the value needed by the following operation
                    ldx       #Addr_9001 ; load the value needed by the following operation
                    ldy       #Data_281A ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0E       ; private DeskMate service selector
                    lbsr      Code_0A64 ; call the referenced helper routine
Code_0F14           ldb       Data_0036 ; load the value needed by the following operation
                    subb      Data_0035 ; subtract the operand from the running value
                    lda       #$03      ; load the value needed by the following operation
                    lbra      Code_0F89 ; continue at the distant control-flow target
Code_0F1D           tst       Addr_0034 ; set condition flags from the current value
                    lbeq      Code_0CFA ; take the distant branch when values are equal
                    ldb       #$03      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    addb      Data_005B ; add the operand to the running value
                    addb      Data_0036 ; add the operand to the running value
                    bpl       Code_0F2D ; branch while the tested value is nonnegative
                    clrb                ; clear the selected byte or register
Code_0F2D           cmpb      Addr_0034 ; compare against the limit and set condition flags
                    bcs       Code_0F3A ; branch when carry reports an unsigned underflow or error
                    tst       Data_003D ; set condition flags from the current value
                    lbne      Code_0CFA ; take the distant branch when values differ
                    ldb       Addr_0034 ; load the value needed by the following operation
                    decb                ; decrement the selected counter
Code_0F3A           cmpb      Data_0036 ; compare against the limit and set condition flags
                    lbeq      Code_0CFA ; take the distant branch when values are equal
                    lda       #$55      ; load the value needed by the following operation
                    lbsr      Code_0CAD ; call the referenced helper routine
                    stb       Data_0036 ; save the current value in working storage
                    clr       Data_005B ; clear the selected byte or register
Code_0F49           cmpb      Data_0035 ; compare against the limit and set condition flags
                    bcc       Code_0F59 ; branch when carry is clear
                    lda       Data_0035 ; load the value needed by the following operation
                    suba      #$03      ; subtract the operand from the running value
                    sta       Data_0035 ; save the current value in working storage
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Data_005B ; save the current value in working storage
                    bra       Code_0F49 ; continue at the selected control-flow target
Code_0F59           lda       Data_0035 ; load the value needed by the following operation
                    adda      #$0C      ; add the operand to the running value
                    sta       Data_005C ; save the current value in working storage
                    cmpb      Data_005C ; compare against the limit and set condition flags
                    bcs       Code_0F6F ; branch when carry reports an unsigned underflow or error
                    lda       Data_0035 ; load the value needed by the following operation
                    adda      #$03      ; add the operand to the running value
                    sta       Data_0035 ; save the current value in working storage
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Data_005B ; save the current value in working storage
                    bra       Code_0F59 ; continue at the selected control-flow target
Code_0F6F           tst       Data_005B ; set condition flags from the current value
                    beq       Code_0F83 ; branch when the compared values are equal
                    lda       #$55      ; load the value needed by the following operation
                    ldx       #Addr_8002 ; load the value needed by the following operation
                    ldy       #Addr_203D ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0E       ; private DeskMate service selector
                    lbsr      Code_0BFC ; call the referenced helper routine
Code_0F83           ldb       Data_0036 ; load the value needed by the following operation
                    subb      Data_0035 ; subtract the operand from the running value
                    lda       #$03      ; load the value needed by the following operation
Code_0F89           lbsr      Code_0AFA ; call the referenced helper routine
                    std       Data_0037 ; save the current value in working storage
                    lda       #$FF      ; load the value needed by the following operation
                    lbsr      Code_0CAD ; call the referenced helper routine
                    tst       Data_003D ; set condition flags from the current value
                    lbeq      Code_0CFA ; take the distant branch when values are equal
                    lda       Data_0041 ; load the value needed by the following operation
                    cmpa      #$02      ; compare against the limit and set condition flags
                    bne       Code_0FA7 ; branch when the compared values differ
                    lda       Data_0039 ; load the value needed by the following operation
                    bita      #$01      ; test the selected flag bits without changing the value
                    lbne      Code_16DE ; take the distant branch when values differ
Code_0FA7           lbra      Code_0CFA ; continue at the distant control-flow target
Code_0FAA           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    lda       #$55      ; load the value needed by the following operation
                    lbsr      Code_0CAD ; call the referenced helper routine
                    tst       Data_003C ; set condition flags from the current value
                    bmi       Code_0FBC ; branch while the tested value is negative
                    lbsr      Code_1076 ; call the referenced helper routine
                    bra       Code_0FD2 ; continue at the selected control-flow target
Code_0FBC           tst       Code_0030 ; set condition flags from the current value
                    bmi       Code_0FD2 ; branch while the tested value is negative
                    lda       #$00      ; load the value needed by the following operation
                    ldb       Addr_0031 ; load the value needed by the following operation
                    lbsr      Code_0894 ; call the referenced helper routine
                    lda       #$AA      ; load the value needed by the following operation
                    ldb       Addr_002E ; load the value needed by the following operation
                    lbsr      Code_0894 ; call the referenced helper routine
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Code_0030 ; save the current value in working storage
Code_0FD2           clr       Data_003C ; clear the selected byte or register
                    lbsr      Code_1084 ; call the referenced helper routine
Code_0FD7           clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1C       ; private DeskMate service selector
                    tsta                ; set condition flags from the current value
                    beq       Code_0FD7 ; branch when the compared values are equal
                    cmpa      #$09      ; compare against the limit and set condition flags
                    bne       Code_0FE8 ; branch when the compared values differ
                    ldb       #$01      ; load the value needed by the following operation
                    lbra      Code_105A ; continue at the distant control-flow target
Code_0FE8           cmpa      #$08      ; compare against the limit and set condition flags
                    bne       Code_0FF1 ; branch when the compared values differ
                    ldb       #$FF      ; load the value needed by the following operation
                    lbra      Code_105A ; continue at the distant control-flow target
Code_0FF1           cmpa      #$05      ; compare against the limit and set condition flags
                    beq       Code_0FF9 ; branch when the compared values are equal
                    cmpa      #$8A      ; compare against the limit and set condition flags
                    bne       Code_100B ; branch when the compared values differ
Code_0FF9           lbsr      Code_1076 ; call the referenced helper routine
                    lda       #$FF      ; load the value needed by the following operation
                    lbsr      Code_0CAD ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "E"                            ; embedded text or resource bytes
                    lbsr      Code_1380 ; call the referenced helper routine
                    lbra      Code_0CFA ; continue at the distant control-flow target
Code_100B           cmpa      #$0D      ; compare against the limit and set condition flags
                    lbne      Code_0FD7 ; take the distant branch when values differ
Code_1011           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    leax      Data_14E7,PCR ; form the referenced address without reading memory
                    lbsr      Code_108E ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       ">"                            ; embedded text or resource bytes
                    deca                ; decrement the selected counter
                    bmi       Code_102B ; branch while the tested value is negative
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
Code_102B           lbsr      Code_168A ; call the referenced helper routine
Code_102E           lda       #$55      ; load the value needed by the following operation
                    lbsr      Code_0CAD ; call the referenced helper routine
                    lbsr      Code_0816 ; call the referenced helper routine
                    lbsr      Code_08FA ; call the referenced helper routine
                    lbsr      Code_05E9 ; call the referenced helper routine
                    lda       #$55      ; load the value needed by the following operation
                    ldb       Addr_002E ; load the value needed by the following operation
                    lbsr      Code_0894 ; call the referenced helper routine
                    tst       Code_002C ; set condition flags from the current value
                    beq       Code_104C ; branch when the compared values are equal
                    lbsr      Code_0BFC ; call the referenced helper routine
                    bra       Code_104F ; continue at the selected control-flow target
Code_104C           lbsr      Code_0A64 ; call the referenced helper routine
Code_104F           lda       #$FF      ; load the value needed by the following operation
                    lbsr      Code_0CAD ; call the referenced helper routine
                    lbsr      Code_1380 ; call the referenced helper routine
                    lbra      Code_0CFA ; continue at the distant control-flow target
Code_105A           addb      Data_003C ; add the operand to the running value
                    bpl       Code_105F ; branch while the tested value is nonnegative
                    clrb                ; clear the selected byte or register
Code_105F           cmpb      #$03      ; compare against the limit and set condition flags
                    bcs       Code_1065 ; branch when carry reports an unsigned underflow or error
                    ldb       #$02      ; load the value needed by the following operation
Code_1065           cmpb      Data_003C ; compare against the limit and set condition flags
                    lbeq      Code_0FD7 ; take the distant branch when values are equal
                    lbsr      Code_1076 ; call the referenced helper routine
                    stb       Data_003C ; save the current value in working storage
                    lbsr      Code_1084 ; call the referenced helper routine
                    lbra      Code_0FD7 ; continue at the distant control-flow target
Code_1076           pshs      X,A       ; preserve the listed registers on the stack
                    leax      Data_065A,PCR ; form the referenced address without reading memory
                    bsr       Code_108E ; call the referenced helper routine
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Data_003C ; save the current value in working storage
                    puls      PC,X,A    ; restore the listed registers from the stack
Code_1084           pshs      X         ; preserve the listed registers on the stack
                    leax      Data_064C,PCR ; form the referenced address without reading memory
                    bsr       Code_108E ; call the referenced helper routine
                    puls      PC,X      ; restore the listed registers from the stack
Code_108E           pshs      D         ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    ldb       Data_003C ; load the value needed by the following operation
                    aslb                ; shift left and update carry
                    ldd       B,X       ; load the value needed by the following operation
                    jsr       D,X       ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    puls      PC,D      ; restore the listed registers from the stack
Code_10A1           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    lda       #$AA      ; load the value needed by the following operation
                    lbsr      Code_0CAD ; call the referenced helper routine
                    tst       Data_003C ; set condition flags from the current value
                    bmi       Code_10B1 ; branch while the tested value is negative
                    lbsr      Code_1076 ; call the referenced helper routine
Code_10B1           tst       Code_0030 ; set condition flags from the current value
                    bmi       Code_10C0 ; branch while the tested value is negative
                    lda       #$00      ; load the value needed by the following operation
                    ldb       Addr_0031 ; load the value needed by the following operation
                    lbsr      Code_0894 ; call the referenced helper routine
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Code_0030 ; save the current value in working storage
Code_10C0           ldb       Addr_002E ; load the value needed by the following operation
                    stb       Addr_0031 ; save the current value in working storage
                    lda       #$FF      ; load the value needed by the following operation
                    lbsr      Code_0894 ; call the referenced helper routine
Code_10C9           clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1C       ; private DeskMate service selector
                    tsta                ; set condition flags from the current value
                    beq       Code_10C9 ; branch when the compared values are equal
                    cmpa      #$0A      ; compare against the limit and set condition flags
                    bne       Code_10D9 ; branch when the compared values differ
                    ldb       #$01      ; load the value needed by the following operation
                    bra       Code_112B ; continue at the selected control-flow target
Code_10D9           cmpa      #$0C      ; compare against the limit and set condition flags
                    bne       Code_10E1 ; branch when the compared values differ
                    ldb       #$FF      ; load the value needed by the following operation
                    bra       Code_112B ; continue at the selected control-flow target
Code_10E1           cmpa      #$05      ; compare against the limit and set condition flags
                    beq       Code_10E9 ; branch when the compared values are equal
                    cmpa      #$88      ; compare against the limit and set condition flags
                    bne       Code_110A ; branch when the compared values differ
Code_10E9           lda       #$00      ; load the value needed by the following operation
                    ldb       Addr_0031 ; load the value needed by the following operation
                    lbsr      Code_0894 ; call the referenced helper routine
                    lda       #$55      ; load the value needed by the following operation
                    ldb       Addr_002E ; load the value needed by the following operation
                    lbsr      Code_0894 ; call the referenced helper routine
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Code_0030 ; save the current value in working storage
                    lda       #$FF      ; load the value needed by the following operation
                    lbsr      Code_0CAD ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "E"                            ; embedded text or resource bytes
                    lbsr      Code_1380 ; call the referenced helper routine
                    lbra      Code_0CFA ; continue at the distant control-flow target
Code_110A           cmpa      #$0D      ; compare against the limit and set condition flags
                    bne       Code_10C9 ; branch when the compared values differ
Code_110E           lda       #$55      ; load the value needed by the following operation
                    ldb       Addr_0031 ; load the value needed by the following operation
                    stb       Addr_002E ; save the current value in working storage
                    lbsr      Code_0894 ; call the referenced helper routine
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Code_0030 ; save the current value in working storage
                    lda       #$00      ; load the value needed by the following operation
                    lbsr      Code_0CAD ; call the referenced helper routine
                    lda       Addr_002E ; load the value needed by the following operation
                    cmpa      #$03      ; compare against the limit and set condition flags
                    lbcc      Code_0965 ; take the distant branch when carry is clear
                    lbra      Code_0B07 ; continue at the distant control-flow target
Code_112B           addb      Addr_0031 ; add the operand to the running value
                    bgt       Code_1131 ; branch when the signed value is above the limit
                    ldb       #$01      ; load the value needed by the following operation
Code_1131           cmpb      #$04      ; compare against the limit and set condition flags
                    bcs       Code_1137 ; branch when carry reports an unsigned underflow or error
                    ldb       #$04      ; load the value needed by the following operation
Code_1137           cmpb      Addr_0031 ; compare against the limit and set condition flags
                    lbeq      Code_10C9 ; take the distant branch when values are equal
                    tfr       B,A       ; copy the source register into the destination register
                    ldb       Addr_0031 ; load the value needed by the following operation
                    sta       Addr_0031 ; save the current value in working storage
                    lda       #$00      ; load the value needed by the following operation
                    lbsr      Code_0894 ; call the referenced helper routine
                    lda       #$FF      ; load the value needed by the following operation
                    ldb       Addr_0031 ; load the value needed by the following operation
                    lbsr      Code_0894 ; call the referenced helper routine
                    lbra      Code_10C9 ; continue at the distant control-flow target
Code_1152           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $19       ; private DeskMate service selector
                    stb       Data_0041 ; save the current value in working storage
                    stu       Data_0042 ; save the current value in working storage
                    ldu       DeskMateService ; load the value needed by the following operation
                    tfr       Y,D       ; copy the source register into the destination register
                    lda       #$03      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    std       Data_0044 ; save the current value in working storage
                    tfr       X,D       ; copy the source register into the destination register
                    lda       #$0A      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    std       Data_0046 ; save the current value in working storage
                    leax      Data_1285,PCR ; form the referenced address without reading memory
                    lbsr      Code_135B ; call the referenced helper routine
                    bcc       Code_117D ; branch when carry is clear
                    tst       Data_003C ; set condition flags from the current value
                    bmi       Code_11F2 ; branch while the tested value is negative
                    lbsr      Code_1076 ; call the referenced helper routine
                    lbra      Code_0CFA ; continue at the distant control-flow target
Code_117D           tst       Code_0030 ; set condition flags from the current value
                    lbeq      Code_10E9 ; take the distant branch when values are equal
                    cmpb      Data_003C ; compare against the limit and set condition flags
                    beq       Code_1193 ; branch when the compared values are equal
                    tst       Data_003C ; set condition flags from the current value
                    bmi       Code_118E ; branch while the tested value is negative
                    lbsr      Code_1076 ; call the referenced helper routine
Code_118E           stb       Data_003C ; save the current value in working storage
                    lbsr      Code_1084 ; call the referenced helper routine
Code_1193           lda       Data_0041 ; load the value needed by the following operation
                    lbeq      Code_0CFA ; take the distant branch when values are equal
                    cmpa      #$01      ; compare against the limit and set condition flags
                    bne       Code_11B5 ; branch when the compared values differ
                    cmpb      #$03      ; compare against the limit and set condition flags
                    lbcs      Code_1011 ; take the distant branch when carry reports an error
                    lbeq      Code_0E1C ; take the distant branch when values are equal
                    cmpb      #$05      ; compare against the limit and set condition flags
                    lbgt      Code_1399 ; take the distant branch for signed greater-than
                    lblt      Code_0D0A ; take the distant branch for signed less-than
                    lbeq      Code_0D14 ; take the distant branch when values are equal
Code_11B5           cmpa      #$02      ; compare against the limit and set condition flags
                    bne       Code_11C8 ; branch when the compared values differ
                    cmpb      #$04      ; compare against the limit and set condition flags
                    lbeq      Code_0D30 ; take the distant branch when values are equal
                    cmpb      #$05      ; compare against the limit and set condition flags
                    lbeq      Code_0D49 ; take the distant branch when values are equal
                    lbra      Code_0CFA ; continue at the distant control-flow target
Code_11C8           cmpa      #$03      ; compare against the limit and set condition flags
                    lbne      Code_11DD ; take the distant branch when values differ
                    cmpb      #$04      ; compare against the limit and set condition flags
                    lbeq      Code_0D0A ; take the distant branch when values are equal
                    cmpb      #$05      ; compare against the limit and set condition flags
                    lbeq      Code_0D14 ; take the distant branch when values are equal
                    lbra      Code_0CFA ; continue at the distant control-flow target
Code_11DD           cmpa      #$05      ; compare against the limit and set condition flags
                    lbne      Code_1152 ; take the distant branch when values differ
                    cmpb      #$04      ; compare against the limit and set condition flags
                    lbeq      Code_0D73 ; take the distant branch when values are equal
                    cmpb      #$05      ; compare against the limit and set condition flags
                    lbeq      Code_0D82 ; take the distant branch when values are equal
                    lbra      Code_0CFA ; continue at the distant control-flow target
Code_11F2           leax      Data_12B0,PCR ; form the referenced address without reading memory
                    lbsr      Code_135B ; call the referenced helper routine
                    bcc       Code_1202 ; branch when carry is clear
                    tst       Code_0030 ; set condition flags from the current value
                    bne       Code_122F ; branch when the compared values differ
                    lbra      Code_10E9 ; continue at the distant control-flow target
Code_1202           tst       Code_0030 ; set condition flags from the current value
                    beq       Code_120E ; branch when the compared values are equal
                    clr       Code_0030 ; clear the selected byte or register
                    lda       Addr_002E ; load the value needed by the following operation
                    sta       Addr_0031 ; save the current value in working storage
                    bra       Code_1212 ; continue at the selected control-flow target
Code_120E           cmpb      Addr_0031 ; compare against the limit and set condition flags
                    beq       Code_1224 ; branch when the compared values are equal
Code_1212           pshs      B         ; preserve the listed registers on the stack
                    lda       #$00      ; load the value needed by the following operation
                    ldb       Addr_0031 ; load the value needed by the following operation
                    lbsr      Code_0894 ; call the referenced helper routine
                    puls      B         ; restore the listed registers from the stack
                    stb       Addr_0031 ; save the current value in working storage
                    lda       #$FF      ; load the value needed by the following operation
                    lbsr      Code_0894 ; call the referenced helper routine
Code_1224           lda       Data_0041 ; load the value needed by the following operation
                    cmpa      #$01      ; compare against the limit and set condition flags
                    lbeq      Code_110E ; take the distant branch when values are equal
                    lbra      Code_0CFA ; continue at the distant control-flow target
Code_122F           leax      Data_12C9,PCR ; form the referenced address without reading memory
                    tst       Code_002C ; set condition flags from the current value
                    beq       Code_123B ; branch when the compared values are equal
                    leax      Data_1300,PCR ; form the referenced address without reading memory
Code_123B           lbsr      Code_135B ; call the referenced helper routine
                    lbcs      Code_0CFA ; take the distant branch when carry reports an error
                    std       Data_005B ; save the current value in working storage
                    lda       Data_0041 ; load the value needed by the following operation
                    cmpa      #$01      ; compare against the limit and set condition flags
                    bne       Code_1257 ; branch when the compared values differ
Code_124A           lda       #$FF      ; load the value needed by the following operation
                    sta       Data_003D ; save the current value in working storage
                    ldd       Data_005B ; load the value needed by the following operation
                    suba      Data_0037 ; subtract the operand from the running value
                    subb      Data_0038 ; subtract the operand from the running value
                    lbra      Code_0EA8 ; continue at the distant control-flow target
Code_1257           cmpa      #$02      ; compare against the limit and set condition flags
                    bne       Code_126D ; branch when the compared values differ
                    ldd       Data_005B ; load the value needed by the following operation
                    cmpd      Data_0037 ; compare against the limit and set condition flags
                    bne       Code_124A ; branch when the compared values differ
                    lda       Data_0039 ; load the value needed by the following operation
                    bita      #$01      ; test the selected flag bits without changing the value
                    lbne      Code_16DE ; take the distant branch when values differ
                    lbra      Code_0CFA ; continue at the distant control-flow target
Code_126D           cmpa      #$03      ; compare against the limit and set condition flags
                    lbne      Code_0CFA ; take the distant branch when values differ
                    ldd       Data_005B ; load the value needed by the following operation
                    cmpd      Data_0037 ; compare against the limit and set condition flags
                    bne       Code_124A ; branch when the compared values differ
                    lda       Data_0039 ; load the value needed by the following operation
                    bita      #$01      ; test the selected flag bits without changing the value
                    lbne      Code_2D13 ; take the distant branch when values differ
                    lbra      Code_0CFA ; continue at the distant control-flow target
Data_1285           fcb       $07,$01,$0B,$00,$01,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$0E,$1A,$00,$01,$00 ; table, bitmap, or initialized data bytes
                    fcb       $01,$1C   ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $00,$01,$00,$02 ; table, bitmap, or initialized data bytes
                    fcc       "7:"                           ; embedded text or resource bytes
                    fcb       $00,$01,$00,$03 ; table, bitmap, or initialized data bytes
                    fcc       "<?"                           ; embedded text or resource bytes
                    fcb       $00,$01,$00,$04 ; table, bitmap, or initialized data bytes
                    fcc       "AD"                           ; embedded text or resource bytes
                    fcb       $00,$01,$00,$05 ; table, bitmap, or initialized data bytes
                    fcc       "FI"                           ; embedded text or resource bytes
                    fcb       $00,$01,$00,$06 ; table, bitmap, or initialized data bytes
Data_12B0           fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "AM"                           ; embedded text or resource bytes
                    fcb       $03,$06,$00,$01 ; table, bitmap, or initialized data bytes
                    fcc       "AM"                           ; embedded text or resource bytes
                    fcb       $07,$0A,$00,$02 ; table, bitmap, or initialized data bytes
                    fcc       "AM"                           ; embedded text or resource bytes
                    fcb       $0B,$0E,$00,$03 ; table, bitmap, or initialized data bytes
                    fcc       "AM"                           ; embedded text or resource bytes
                    fcb       $0F,$12,$00,$04 ; table, bitmap, or initialized data bytes
Data_12C9           fcb       $09,$02,$16,$04,$09,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$18   ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $04,$09,$00,$01 ; table, bitmap, or initialized data bytes
                    fcc       ",@"                           ; embedded text or resource bytes
                    fcb       $04,$09,$00,$02,$02,$16 ; table, bitmap, or initialized data bytes
                    fcb       $0B,$10,$01,$00,$18 ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $0B,$10,$01,$01 ; table, bitmap, or initialized data bytes
                    fcc       ",@"                           ; embedded text or resource bytes
                    fcb       $0B,$10,$01,$02,$02,$16 ; table, bitmap, or initialized data bytes
                    fcb       $12,$16,$02,$00,$18 ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $12,$16,$02,$01 ; table, bitmap, or initialized data bytes
                    fcc       ",@"                           ; embedded text or resource bytes
                    fcb       $12,$16,$02,$02 ; table, bitmap, or initialized data bytes
Data_1300           fcb       $0F,$02,$16,$04,$07,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$18   ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $04,$07,$00,$01 ; table, bitmap, or initialized data bytes
                    fcc       ",@"                           ; embedded text or resource bytes
                    fcb       $04,$07,$00,$02,$02,$16 ; table, bitmap, or initialized data bytes
                    fcb       $08,$0B,$01,$00,$18 ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $08,$0B,$01,$01 ; table, bitmap, or initialized data bytes
                    fcc       ",@"                           ; embedded text or resource bytes
                    fcb       $08,$0B,$01,$02,$02,$16 ; table, bitmap, or initialized data bytes
                    fcb       $0C,$0F,$02,$00,$18 ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $0C,$0F,$02,$01 ; table, bitmap, or initialized data bytes
                    fcc       ",@"                           ; embedded text or resource bytes
                    fcb       $0C,$0F,$02,$02,$02,$16 ; table, bitmap, or initialized data bytes
                    fcb       $10,$13,$03,$00,$18 ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $10,$13,$03,$01 ; table, bitmap, or initialized data bytes
                    fcc       ",@"                           ; embedded text or resource bytes
                    fcb       $10,$13,$03,$02,$02,$16 ; table, bitmap, or initialized data bytes
                    fcb       $14,$17,$04,$00,$18 ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $14,$17,$04,$01 ; table, bitmap, or initialized data bytes
                    fcc       ",@"                           ; embedded text or resource bytes
                    fcb       $14,$17,$04,$02 ; table, bitmap, or initialized data bytes
Code_135B           pshs      X         ; preserve the listed registers on the stack
                    ldb       ,X+       ; fetch the next value and advance the source pointer
Code_135F           lda       Data_0043 ; load the value needed by the following operation
                    cmpa      ,X        ; compare against the limit and set condition flags
                    bcs       Code_1378 ; branch when carry reports an unsigned underflow or error
                    cmpa      $01,X     ; compare against the limit and set condition flags
                    bhi       Code_1378 ; branch when the unsigned value is above the limit
                    lda       Data_0042 ; load the value needed by the following operation
                    cmpa      $02,X     ; compare against the limit and set condition flags
                    bcs       Code_1378 ; branch when carry reports an unsigned underflow or error
                    cmpa      $03,X     ; compare against the limit and set condition flags
                    bhi       Code_1378 ; branch when the unsigned value is above the limit
                    clra                ; clear the selected byte or register
                    ldd       $04,X     ; load the value needed by the following operation
                    bra       Code_137E ; continue at the selected control-flow target
Code_1378           leax      $06,X     ; form the referenced address without reading memory
                    decb                ; decrement the selected counter
                    bne       Code_135F ; branch when the compared values differ
                    comb                ; invert every bit in the selected value
Code_137E           puls      PC,X      ; restore the listed registers from the stack
Code_1380           pshs      Y,X,D     ; preserve the listed registers on the stack
Code_1382           clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    tsta                ; set condition flags from the current value
                    bne       Code_1382 ; branch when the compared values differ
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "E"                            ; embedded text or resource bytes
                    puls      PC,Y,X,D  ; restore the listed registers from the stack
Data_1390           fcb       $FC,$00,$0D ; table, bitmap, or initialized data bytes
Data_1393           fcc       "DMALT"                        ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
Code_1399           ldx       #Addr_FFD8 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "O"                            ; embedded text or resource bytes
                    lbsr      Code_05A0 ; call the referenced helper routine
                    leau      >Data_1390,PCR ; form the referenced address without reading memory
                    ldd       #Data_0100 ; load the value needed by the following operation
                    leax      >Data_1393,PCR ; form the referenced address without reading memory
                    ldy       #Addr_0003 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "V"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "P"                            ; embedded text or resource bytes
                    ldu       DeskMateService ; load the value needed by the following operation
                    lbsr      Code_059F ; call the referenced helper routine
                    lda       Addr_002E ; load the value needed by the following operation
                    ldb       Data_002F ; load the value needed by the following operation
                    stb       Addr_002E ; save the current value in working storage
                    lbsr      Code_09AF ; call the referenced helper routine
                    sta       Addr_002E ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $00       ; private DeskMate service selector
                    lbsr      Code_05F8 ; call the referenced helper routine
                    tst       Code_002C ; set condition flags from the current value
                    lbeq      Code_0965 ; take the distant branch when values are equal
                    lbra      Code_0B07 ; continue at the distant control-flow target
Data_13DF           fcb       $00,$01,$04,$1E,$13,$00 ; table, bitmap, or initialized data bytes
                    fcb       $AA,$F0   ; table, bitmap, or initialized data bytes
Data_13E7           fcc       "DMHELP"                       ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_13EE           fcc       "DMMENU "                      ; embedded text or resource bytes
Data_13F5           fcb       $00,$00,$0D ; table, bitmap, or initialized data bytes
Code_13F8           pshs      U,Y,X,D   ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    leax      >Data_13DF,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "N"                            ; embedded text or resource bytes
                    leax      $26,X     ; form the referenced address without reading memory
                    clr       ,X        ; clear the selected byte or register
                    ldx       #Addr_FFD8 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "O"                            ; embedded text or resource bytes
                    leau      >Data_13EE,PCR ; form the referenced address without reading memory
                    lda       ,S        ; load the value needed by the following operation
                    sta       >Data_13F5,PCR ; save the current value in working storage
                    leax      >Data_13E7,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "V"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "P"                            ; embedded text or resource bytes
                    leax      >Data_13DF,PCR ; form the referenced address without reading memory
                    lbsr      Code_16B2 ; call the referenced helper routine
                    puls      PC,U,Y,X,D ; restore the listed registers from the stack
Data_1435           fcb       $00,$00,$01,$0A,$09,$00 ; table, bitmap, or initialized data bytes
                    fcb       $AA,$E0,$00,$06,$01,$0C ; table, bitmap, or initialized data bytes
                    fcb       $05,$00,$AA,$E0,$00,$0D ; table, bitmap, or initialized data bytes
                    fcb       $01,$0B,$06,$00,$AA,$E0 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$07,$08,$07,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$03,$0A,$03 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$04,$09 ; table, bitmap, or initialized data bytes
                    fcb       $04,$00,$00,$00,$08 ; table, bitmap, or initialized data bytes
                    fcc       " open"                        ; embedded text or resource bytes
                    fcb       $00,$00,$08 ; table, bitmap, or initialized data bytes
                    fcc       " close"                       ; embedded text or resource bytes
                    fcb       $00,$00   ; table, bitmap, or initialized data bytes
                    fcc       "7 status"                     ; embedded text or resource bytes
                    fcb       $00,$00   ; table, bitmap, or initialized data bytes
                    fcc       "3 copy"                       ; embedded text or resource bytes
                    fcb       $00,$00   ; table, bitmap, or initialized data bytes
                    fcc       "5 delete"                     ; embedded text or resource bytes
                    fcb       $00,$00   ; table, bitmap, or initialized data bytes
                    fcc       "6 rename"                     ; embedded text or resource bytes
                    fcb       $00,$00   ; table, bitmap, or initialized data bytes
                    fcc       "? help"                       ; embedded text or resource bytes
                    fcb       $00,$00   ; table, bitmap, or initialized data bytes
                    fcc       "2 print"                      ; embedded text or resource bytes
                    fcb       $00,$00   ; table, bitmap, or initialized data bytes
                    fcc       "8 sort data"                  ; embedded text or resource bytes
                    fcb       $00,$00   ; table, bitmap, or initialized data bytes
                    fcc       "? help"                       ; embedded text or resource bytes
                    fcb       $00,$00,$08 ; table, bitmap, or initialized data bytes
                    fcc       " initialize"                  ; embedded text or resource bytes
                    fcb       $00,$00,$08 ; table, bitmap, or initialized data bytes
                    fcc       " backup"                      ; embedded text or resource bytes
                    fcb       $00,$00,$08 ; table, bitmap, or initialized data bytes
                    fcc       " swap"                        ; embedded text or resource bytes
                    fcb       $00,$00   ; table, bitmap, or initialized data bytes
                    fcc       "? help"                       ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_14E7           fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $00,$BF,$01 ; table, bitmap, or initialized data bytes
                    fcc       "53"                           ; embedded text or resource bytes
                    fcb       $C9,$01   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $EF,$84,$E6,$04,$10,$AF ; table, bitmap, or initialized data bytes
                    fcb       $C1       ; table, bitmap, or initialized data bytes
                    fcc       "Z'"                           ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "o"                            ; embedded text or resource bytes
                    fcb       $A0       ; table, bitmap, or initialized data bytes
                    fcc       "D%"                           ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "j?m"                          ; embedded text or resource bytes
                    fcb       $A0,$26,$FC ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $ED,$DE,$00 ; table, bitmap, or initialized data bytes
                    fcc       "946"                          ; embedded text or resource bytes
                    fcb       $86,$03,$17,$EB,$01,$10 ; table, bitmap, or initialized data bytes
                    fcb       $17,$EA,$FD ; table, bitmap, or initialized data bytes
                    fcc       "Y0"                           ; embedded text or resource bytes
                    fcb       $8D,$FF,$1A,$17,$EA,$F5 ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       "90"                           ; embedded text or resource bytes
                    fcb       $8D,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "(1"                           ; embedded text or resource bytes
                    fcb       $8D,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $8D,$C2   ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $17,$1A,$26,$17,$1B ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $C1,$0D,$26 ; table, bitmap, or initialized data bytes
                    fcc       "K"                            ; embedded text or resource bytes
                    fcb       $17,$EA,$DA,$17,$D6 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "[TJ*"                         ; embedded text or resource bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $EB,$17,$EA,$CC ; table, bitmap, or initialized data bytes
                    fcc       "YO"                           ; embedded text or resource bytes
                    fcb       $17,$EA,$C7,$10,$96 ; table, bitmap, or initialized data bytes
                    fcc       "["                            ; embedded text or resource bytes
                    fcb       $81,$01   ; table, bitmap, or initialized data bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $07,$10   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $F8,$B2,$16,$01,$84,$81 ; table, bitmap, or initialized data bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $0C       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $05,$17,$03,$00 ; table, bitmap, or initialized data bytes
                    fcc       " :"                           ; embedded text or resource bytes
                    fcb       $17,$07,$92 ; table, bitmap, or initialized data bytes
                    fcc       " 5"                           ; embedded text or resource bytes
                    fcb       $81,$05   ; table, bitmap, or initialized data bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $0C       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $05,$17,$0D,$FA ; table, bitmap, or initialized data bytes
                    fcc       " *"                           ; embedded text or resource bytes
                    fcb       $17,$0F,$03 ; table, bitmap, or initialized data bytes
                    fcc       " %"                           ; embedded text or resource bytes
                    fcb       $86,$01,$17,$FE ; table, bitmap, or initialized data bytes
                    fcc       "y "                           ; embedded text or resource bytes
                    fcb       $1E,$86,$02,$C1,$B7 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $AF       ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $C1,$B3   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $AA       ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $C1,$B5   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $A5       ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $C1,$B6   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $A0       ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $C1,$AF   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $9B,$C1,$05,$26,$90 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $17,$EA   ; table, bitmap, or initialized data bytes
                    fcc       "p"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $B6       ; table, bitmap, or initialized data bytes
                    fcc       "46"                           ; embedded text or resource bytes
                    fcb       $86,$03,$17,$EA ; table, bitmap, or initialized data bytes
                    fcc       "f"                            ; embedded text or resource bytes
                    fcb       $10,$17,$EA ; table, bitmap, or initialized data bytes
                    fcc       "bY0"                          ; embedded text or resource bytes
                    fcb       $8D,$FE,$87,$17,$EA ; table, bitmap, or initialized data bytes
                    fcc       "Z8"                           ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       ":0"                           ; embedded text or resource bytes
                    fcb       $8D,$FE,$94 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $8D,$FE,$DD,$17,$FF,$26 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $17,$19,$8A,$17,$1A,$97 ; table, bitmap, or initialized data bytes
                    fcb       $C1,$0D,$26 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $17,$EA   ; table, bitmap, or initialized data bytes
                    fcc       ">"                            ; embedded text or resource bytes
                    fcb       $17,$D6   ; table, bitmap, or initialized data bytes
                    fcc       ":"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "[TJ*"                         ; embedded text or resource bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $EB,$17,$EA ; table, bitmap, or initialized data bytes
                    fcc       "0YO"                          ; embedded text or resource bytes
                    fcb       $17,$EA   ; table, bitmap, or initialized data bytes
                    fcc       "+"                            ; embedded text or resource bytes
                    fcb       $10,$96   ; table, bitmap, or initialized data bytes
                    fcc       "["                            ; embedded text or resource bytes
                    fcb       $81,$01   ; table, bitmap, or initialized data bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $0C       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $05,$17,$12,$A7 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $1F,$17,$10,$C9 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $1A,$86,$02,$17,$FD,$F8 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $13       ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $C1,$B2   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $CB       ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $C1,$B8   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $C6       ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
Data_160D           fcb       $C1,$AF   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $C1,$C1,$05,$26,$B6 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $17,$E9,$FA,$10 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $B6       ; table, bitmap, or initialized data bytes
                    fcc       "46"                           ; embedded text or resource bytes
                    fcb       $86,$03,$17,$E9,$F0,$10 ; table, bitmap, or initialized data bytes
                    fcb       $17,$E9,$EC ; table, bitmap, or initialized data bytes
                    fcc       "Y0"                           ; embedded text or resource bytes
                    fcb       $8D,$FE,$19,$17,$E9,$E4 ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
                    fcb       $86,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FE   ; table, bitmap, or initialized data bytes
                    fcc       "%1"                           ; embedded text or resource bytes
                    fcb       $8D,$FE,$85,$17,$FE,$B0 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $17,$19,$14,$17,$1A ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $C1,$0D,$26 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $17,$E9,$C8,$17,$17,$E9 ; table, bitmap, or initialized data bytes
                    fcb       $C4       ; table, bitmap, or initialized data bytes
                    fcc       "Y"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "[O"                           ; embedded text or resource bytes
                    fcb       $17,$E9,$BD,$10,$96 ; table, bitmap, or initialized data bytes
                    fcc       "["                            ; embedded text or resource bytes
                    fcb       $81,$02   ; table, bitmap, or initialized data bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $15       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $0E,$81,$01 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $05,$17,$13,$D8 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $1B,$17,$14 ; table, bitmap, or initialized data bytes
                    fcc       "Z "                           ; embedded text or resource bytes
                    fcb       $16,$17,$15,$96 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $11,$86,$03,$17,$FD,$81 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $0A,$86,$03,$C1,$AF ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $C9,$C1,$05,$26,$BE ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $17,$E9,$8C,$10 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $B6       ; table, bitmap, or initialized data bytes
Code_168A           pshs      Y,X,D     ; preserve the listed registers on the stack
                    leax      Data_1435,PCR ; form the referenced address without reading memory
                    lda       #$08      ; load the value needed by the following operation
                    ldb       Data_003C ; load the value needed by the following operation
                    bmi       Code_16B0 ; branch while the tested value is negative
                    mul                 ; multiply the two eight-bit accumulators
                    abx                 ; add the operand to the running value
                    lda       $04,X     ; load the value needed by the following operation
                    asla                ; shift left and update carry
                    asla                ; shift left and update carry
                    asla                ; shift left and update carry
                    ldb       $03,X     ; load the value needed by the following operation
                    aslb                ; shift left and update carry
                    tfr       D,Y       ; copy the source register into the destination register
                    lda       #$0E      ; load the value needed by the following operation
                    ldb       $01,X     ; load the value needed by the following operation
                    tfr       D,X       ; copy the source register into the destination register
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0E       ; private DeskMate service selector
                    lbsr      Code_1076 ; call the referenced helper routine
Code_16B0           puls      PC,Y,X,D  ; restore the listed registers from the stack
Code_16B2           pshs      Y,X,D     ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       ">"                            ; embedded text or resource bytes
                    deca                ; decrement the selected counter
                    bmi       Code_16C3 ; branch while the tested value is negative
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
Code_16C3           lda       $04,X     ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    asla                ; shift left and update carry
                    asla                ; shift left and update carry
                    asla                ; shift left and update carry
                    ldb       $03,X     ; load the value needed by the following operation
                    aslb                ; shift left and update carry
                    tfr       D,Y       ; copy the source register into the destination register
                    lda       $02,X     ; load the value needed by the following operation
                    asla                ; shift left and update carry
                    asla                ; shift left and update carry
                    asla                ; shift left and update carry
                    ldb       $01,X     ; load the value needed by the following operation
                    tfr       D,X       ; copy the source register into the destination register
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0E       ; private DeskMate service selector
                    puls      PC,Y,X,D  ; restore the listed registers from the stack
Code_16DE           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    lbsr      Code_058D ; call the referenced helper routine
                    lda       Data_0036 ; load the value needed by the following operation
                    leax      $73,U     ; form the referenced address without reading memory
                    lda       A,X       ; load the value needed by the following operation
                    leax      $0100,U   ; form the referenced address without reading memory
                    ldb       #$0D      ; load the value needed by the following operation
                    stb       ,X        ; save the current value in working storage
                    ldy       #Addr_0001 ; load the value needed by the following operation
                    tst       Code_002C ; set condition flags from the current value
                    beq       Code_1726 ; branch when the compared values are equal
                    clra                ; clear the selected byte or register
                    ldb       Data_0036 ; load the value needed by the following operation
                    aslb                ; shift left and update carry
                    leay      $1162,U   ; form the referenced address without reading memory
                    ldy       D,Y       ; load the value needed by the following operation
                    lda       ,Y+       ; fetch the next value and advance the source pointer
                    sta       Data_005B ; save the current value in working storage
                    lda       Addr_002E ; load the value needed by the following operation
                    adda      #$30      ; add the operand to the running value
                    sta       ,X+       ; store the value and advance the destination pointer
                    lda       #$3A      ; load the value needed by the following operation
                    sta       ,X+       ; store the value and advance the destination pointer
                    ldb       #$03      ; load the value needed by the following operation
Code_1717           incb                ; advance the selected counter
                    lda       ,Y+       ; fetch the next value and advance the source pointer
                    sta       ,X+       ; store the value and advance the destination pointer
                    bne       Code_1717 ; branch when the compared values differ
                    tfr       D,Y       ; copy the source register into the destination register
                    lda       #$0D      ; load the value needed by the following operation
                    sta       -$01,X    ; save the current value in working storage
                    lda       Data_005B ; load the value needed by the following operation
Code_1726           pshs      Y,A       ; preserve the listed registers on the stack
                    leax      $63,U     ; form the referenced address without reading memory
                    tst       A,X       ; set condition flags from the current value
                    bne       Code_1791 ; branch when the compared values differ
                    lda       Data_002F ; load the value needed by the following operation
                    eora      #$07      ; toggle the selected bits
                    ldb       Addr_002E ; load the value needed by the following operation
                    sta       Addr_002E ; save the current value in working storage
                    lbsr      Code_09AF ; call the referenced helper routine
                    stb       Addr_002E ; save the current value in working storage
                    lda       ,S        ; load the value needed by the following operation
                    tst       A,X       ; set condition flags from the current value
                    bne       Code_1791 ; branch when the compared values differ
                    lbsr      Code_168A ; call the referenced helper routine
                    lbsr      Code_0774 ; call the referenced helper routine
                    lda       #$00      ; load the value needed by the following operation
                    lbsr      Code_0CAD ; call the referenced helper routine
                    lbsr      Code_08FA ; call the referenced helper routine
                    puls      Y,A       ; restore the listed registers from the stack
                    ldb       #$0D      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    leax      $0284,U   ; form the referenced address without reading memory
                    leax      D,X       ; form the referenced address without reading memory
                    ldd       #Code_0401 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    ldd       #Addr_0601 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      >Data_17ED,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    ldd       #Code_0801 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    lda       #$03      ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1C       ; private DeskMate service selector
                    lbsr      Code_08FA ; call the referenced helper routine
                    lbra      Code_102E ; continue at the distant control-flow target
Code_1791           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "N"                            ; embedded text or resource bytes
                    leax      $26,X     ; form the referenced address without reading memory
                    leay      $0140,U   ; form the referenced address without reading memory
                    tfr       X,U       ; copy the source register into the destination register
                    lda       Data_002F ; load the value needed by the following operation
                    ldb       #$29      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    leax      D,X       ; form the referenced address without reading memory
                    lda       ,X        ; load the value needed by the following operation
                    sta       ,U        ; save the current value in working storage
                    beq       Code_17B7 ; branch when the compared values are equal
Code_17AB           lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,Y+       ; store the value and advance the destination pointer
                    sta       ,U+       ; store the value and advance the destination pointer
                    bne       Code_17AB ; branch when the compared values differ
                    lda       #$2F      ; load the value needed by the following operation
                    sta       -$01,Y    ; save the current value in working storage
Code_17B7           ldu       DeskMateService ; load the value needed by the following operation
                    leax      $01B4,U   ; form the referenced address without reading memory
                    puls      A         ; restore the listed registers from the stack
                    ldb       #$0D      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    leax      D,X       ; form the referenced address without reading memory
Code_17C4           lda       ,X+       ; fetch the next value and advance the source pointer
                    anda      #$7F      ; mask off unwanted bits
                    sta       ,Y+       ; store the value and advance the destination pointer
                    bne       Code_17C4 ; branch when the compared values differ
                    lda       #$20      ; load the value needed by the following operation
                    sta       -$01,Y    ; save the current value in working storage
                    puls      D         ; restore the listed registers from the stack
                    leax      $0100,U   ; form the referenced address without reading memory
Code_17D6           lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,Y+       ; store the value and advance the destination pointer
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    bne       Code_17D6 ; branch when the compared values differ
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "-"                            ; embedded text or resource bytes
                    lbsr      Code_05A0 ; call the referenced helper routine
                    leax      $0140,U   ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "U"                            ; embedded text or resource bytes
Data_17ED           fcc       "isn't in either progr"        ; embedded text or resource bytes
                    fcc       "am folder"                    ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_180C           fcb       $00,$01,$05,$1A,$0B,$00 ; table, bitmap, or initialized data bytes
                    fcb       $AA,$F0   ; table, bitmap, or initialized data bytes
Data_1814           fcc       "Status of  "                  ; embedded text or resource bytes
Data_181F           fcb       $00       ; table, bitmap, or initialized data bytes
Data_1820           fcc       "SIZE: "                       ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1827           fcc       "DAT"                          ; embedded text or resource bytes
Data_182A           fcc       "E: "                          ; embedded text or resource bytes
                    fcb       $01,$01   ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $01,$01   ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $01,$01   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $01,$01   ; table, bitmap, or initialized data bytes
                    fcc       ":"                            ; embedded text or resource bytes
                    fcb       $01,$01   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "M"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_183F           fcc       "Can't find "                  ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_184B           fcb       $98,$96,$80,$0F ; table, bitmap, or initialized data bytes
                    fcc       "B@"                           ; embedded text or resource bytes
                    fcb       $01,$86,$A0,$00 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $10,$00,$03,$E8,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "d"                            ; embedded text or resource bytes
                    fcb       $00,$00,$0A,$00,$00,$01 ; table, bitmap, or initialized data bytes
Code_1863           pshs      Y,X,D     ; preserve the listed registers on the stack
                    leax      >Data_180C,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    lda       Data_0036 ; load the value needed by the following operation
                    leay      >Data_1814,PCR ; form the referenced address without reading memory
                    leax      $0100,U   ; form the referenced address without reading memory
                    lbsr      Code_1A15 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "?"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0C       ; private DeskMate service selector
                    stx       Data_005C ; save the current value in working storage
Code_1884           ldd       Data_005C ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      $0100,U   ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    leax      $0100,U   ; form the referenced address without reading memory
                    leax      $0B,X     ; form the referenced address without reading memory
                    clra                ; clear the selected byte or register
                    lbsr      Code_18F8 ; call the referenced helper routine
                    bcs       Code_18E2 ; branch when carry reports an unsigned underflow or error
                    ldd       Data_005C ; load the value needed by the following operation
                    adda      #$02      ; add the operand to the running value
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      $017A,U   ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    ldd       Data_005C ; load the value needed by the following operation
                    adda      #$03      ; add the operand to the running value
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    tst       Data_005B ; set condition flags from the current value
                    bpl       Code_18E2 ; branch while the tested value is nonnegative
                    clr       Data_005B ; clear the selected byte or register
                    lda       Data_005C ; load the value needed by the following operation
                    adda      #$05      ; add the operand to the running value
                    sta       Data_005C ; save the current value in working storage
                    leax      $0100,U   ; form the referenced address without reading memory
Code_18D0           tst       ,X+       ; set condition flags from the current value
                    bne       Code_18D0 ; branch when the compared values differ
                    ldd       #Addr_2E48 ; load the value needed by the following operation
                    std       -$01,X    ; save the current value in working storage
                    ldd       #Addr_4C50 ; load the value needed by the following operation
                    std       $01,X     ; save the current value in working storage
                    clr       $03,X     ; clear the selected byte or register
                    bra       Code_1884 ; continue at the selected control-flow target
Code_18E2           lbsr      Code_1380 ; call the referenced helper routine
                    ldb       #$80      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1C       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "E"                            ; embedded text or resource bytes
                    leax      Data_180C,PCR ; form the referenced address without reading memory
                    lbsr      Code_16B2 ; call the referenced helper routine
                    puls      PC,Y,X,D  ; restore the listed registers from the stack
Code_18F8           pshs      U,Y,X,D   ; preserve the listed registers on the stack
                    leay      $0120,U   ; form the referenced address without reading memory
                    stx       ,Y        ; save the current value in working storage
                    leax      Data_181F,PCR ; form the referenced address without reading memory
                    stx       $02,Y     ; save the current value in working storage
                    leax      $0140,U   ; form the referenced address without reading memory
                    stx       $04,Y     ; save the current value in working storage
                    lda       #$3A      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "J"                            ; embedded text or resource bytes
                    lda       #$01      ; load the value needed by the following operation
                    leax      $0140,U   ; form the referenced address without reading memory
                    os9       I$Open    ; request the named OS-9 service
                    lbcs      Code_19DD ; take the distant branch when carry reports an error
                    sta       Addr_002D ; save the current value in working storage
                    ldb       #$0F      ; load the value needed by the following operation
                    leax      $0120,U   ; form the referenced address without reading memory
                    ldy       #Addr_0010 ; load the value needed by the following operation
                    os9       I$GetStt  ; request the named OS-9 service
                    lbcs      Code_19DD ; take the distant branch when carry reports an error
                    leay      Data_1820,PCR ; form the referenced address without reading memory
                    leau      $017A,U   ; form the referenced address without reading memory
Code_193A           lda       ,Y+       ; fetch the next value and advance the source pointer
                    sta       ,U+       ; store the value and advance the destination pointer
                    bne       Code_193A ; branch when the compared values differ
                    leau      -$01,U    ; form the referenced address without reading memory
                    leax      $0A,X     ; form the referenced address without reading memory
                    leay      Data_184B,PCR ; form the referenced address without reading memory
                    lda       #$08      ; load the value needed by the following operation
                    sta       Data_005E ; save the current value in working storage
                    clr       Data_005F ; clear the selected byte or register
                    deca                ; decrement the selected counter
Code_194F           clr       A,U       ; clear the selected byte or register
                    deca                ; decrement the selected counter
                    bpl       Code_194F ; branch while the tested value is nonnegative
Code_1954           ldd       $01,X     ; load the value needed by the following operation
                    subd      $01,Y     ; subtract the operand from the running value
                    std       $01,X     ; save the current value in working storage
                    ldb       ,X        ; load the value needed by the following operation
                    sbcb      ,Y        ; subtract the operand from the running value
                    stb       ,X        ; save the current value in working storage
                    bcs       Code_1966 ; branch when carry reports an unsigned underflow or error
                    inc       ,U        ; advance the selected counter
                    bra       Code_1954 ; continue at the selected control-flow target
Code_1966           ldd       $01,X     ; load the value needed by the following operation
                    addd      $01,Y     ; add the operand to the running value
                    std       $01,X     ; save the current value in working storage
                    ldb       ,X        ; load the value needed by the following operation
                    adcb      ,Y        ; add the operand to the running value
                    stb       ,X        ; save the current value in working storage
                    leay      $03,Y     ; form the referenced address without reading memory
                    lda       ,U        ; load the value needed by the following operation
                    bne       Code_1982 ; branch when the compared values differ
                    ldb       #$01      ; load the value needed by the following operation
                    cmpb      Data_005E ; compare against the limit and set condition flags
                    beq       Code_1982 ; branch when the compared values are equal
                    tst       Data_005F ; set condition flags from the current value
                    beq       Code_1988 ; branch when the compared values are equal
Code_1982           adda      #$30      ; add the operand to the running value
                    sta       ,U+       ; store the value and advance the destination pointer
                    dec       Data_005F ; decrement the selected counter
Code_1988           dec       Data_005E ; decrement the selected counter
                    bne       Code_1954 ; branch when the compared values differ
                    clr       ,U+       ; clear the selected byte or register
                    leay      Data_1827,PCR ; form the referenced address without reading memory
Code_1992           lda       ,Y+       ; fetch the next value and advance the source pointer
                    sta       ,U+       ; store the value and advance the destination pointer
                    bne       Code_1992 ; branch when the compared values differ
                    leau      -$0C,U    ; form the referenced address without reading memory
                    leax      -$07,X    ; form the referenced address without reading memory
                    lbsr      Code_19F9 ; call the referenced helper routine
                    leax      $01,X     ; form the referenced address without reading memory
                    leau      -$06,U    ; form the referenced address without reading memory
                    lbsr      Code_19F9 ; call the referenced helper routine
                    leax      $01,X     ; form the referenced address without reading memory
                    leau      $03,U     ; form the referenced address without reading memory
                    lbsr      Code_19F9 ; call the referenced helper routine
                    leax      $01,X     ; form the referenced address without reading memory
                    leau      $06,U     ; form the referenced address without reading memory
                    lda       #$41      ; load the value needed by the following operation
                    sta       $06,U     ; save the current value in working storage
                    lda       ,X        ; load the value needed by the following operation
                    bne       Code_19BD ; branch when the compared values differ
                    lda       #$0C      ; load the value needed by the following operation
                    bra       Code_19C9 ; continue at the selected control-flow target
Code_19BD           cmpa      #$0C      ; compare against the limit and set condition flags
                    bcs       Code_19C9 ; branch when carry reports an unsigned underflow or error
                    beq       Code_19C5 ; branch when the compared values are equal
                    suba      #$0C      ; subtract the operand from the running value
Code_19C5           ldb       #$50      ; load the value needed by the following operation
                    stb       $06,U     ; save the current value in working storage
Code_19C9           sta       ,X        ; save the current value in working storage
                    lbsr      Code_19F9 ; call the referenced helper routine
                    leax      $01,X     ; form the referenced address without reading memory
                    leau      $03,U     ; form the referenced address without reading memory
                    lbsr      Code_19F9 ; call the referenced helper routine
                    lda       Addr_002D ; load the value needed by the following operation
                    os9       I$Close   ; request the named OS-9 service
                    clrb                ; clear the selected byte or register
                    bra       Code_19F7 ; continue at the selected control-flow target
Code_19DD           tst       ,S        ; set condition flags from the current value
                    bne       Code_19F1 ; branch when the compared values differ
                    ldd       Data_005C ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      Data_183F,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
Code_19F1           lda       Addr_002D ; load the value needed by the following operation
                    os9       I$Close   ; request the named OS-9 service
                    comb                ; invert every bit in the selected value
Code_19F7           puls      PC,U,Y,X,D ; restore the listed registers from the stack
Code_19F9           pshs      D         ; preserve the listed registers on the stack
                    ldd       #Data_3030 ; load the value needed by the following operation
                    std       ,U        ; save the current value in working storage
                    lda       ,X        ; load the value needed by the following operation
Code_1A02           suba      #$0A      ; subtract the operand from the running value
                    bcs       Code_1A0A ; branch when carry reports an unsigned underflow or error
                    inc       ,U        ; advance the selected counter
                    bra       Code_1A02 ; continue at the selected control-flow target
Code_1A0A           adda      #$0A      ; add the operand to the running value
Code_1A0C           deca                ; decrement the selected counter
                    bmi       Code_1A13 ; branch while the tested value is negative
                    inc       $01,U     ; advance the selected counter
                    bra       Code_1A0C ; continue at the selected control-flow target
Code_1A13           puls      PC,D      ; restore the listed registers from the stack
Code_1A15           pshs      Y,X,D     ; preserve the listed registers on the stack
Code_1A17           lda       ,Y+       ; fetch the next value and advance the source pointer
                    sta       ,X+       ; store the value and advance the destination pointer
                    bne       Code_1A17 ; branch when the compared values differ
                    lda       Addr_002E ; load the value needed by the following operation
                    adda      #$30      ; add the operand to the running value
                    ldb       #$3A      ; load the value needed by the following operation
                    std       -$01,X    ; save the current value in working storage
                    leax      $01,X     ; form the referenced address without reading memory
                    lda       ,S        ; load the value needed by the following operation
                    leay      $73,U     ; form the referenced address without reading memory
                    lda       A,Y       ; load the value needed by the following operation
                    ldb       #$0D      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    leay      $01B4,U   ; form the referenced address without reading memory
                    leay      D,Y       ; form the referenced address without reading memory
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Data_005B ; save the current value in working storage
                    tst       Code_002C ; set condition flags from the current value
                    beq       Code_1A4E ; branch when the compared values are equal
                    ldb       ,S        ; load the value needed by the following operation
                    clra                ; clear the selected byte or register
                    aslb                ; shift left and update carry
                    leay      $1162,U   ; form the referenced address without reading memory
                    ldy       D,Y       ; load the value needed by the following operation
                    lda       ,Y+       ; fetch the next value and advance the source pointer
                    sta       Data_005B ; save the current value in working storage
Code_1A4E           lda       ,Y+       ; fetch the next value and advance the source pointer
                    anda      #$7F      ; mask off unwanted bits
                    sta       ,X+       ; store the value and advance the destination pointer
                    bne       Code_1A4E ; branch when the compared values differ
                    lda       Data_005B ; load the value needed by the following operation
                    bmi       Code_1A71 ; branch while the tested value is negative
                    ldb       #$03      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    leay      $0354,U   ; form the referenced address without reading memory
                    leay      D,Y       ; form the referenced address without reading memory
                    lda       #$2E      ; load the value needed by the following operation
                    ldb       ,Y        ; load the value needed by the following operation
                    std       -$01,X    ; save the current value in working storage
                    ldd       $01,Y     ; load the value needed by the following operation
                    andb      #$7F      ; mask off unwanted bits
                    std       $01,X     ; save the current value in working storage
                    clr       $03,X     ; clear the selected byte or register
Code_1A71           puls      PC,Y,X,D  ; restore the listed registers from the stack
Data_1A73           fcb       $00,$01,$06,$1E,$09,$00 ; table, bitmap, or initialized data bytes
                    fcb       $AA,$F0   ; table, bitmap, or initialized data bytes
Data_1A7B           fcc       "Copy "                        ; embedded text or resource bytes
Data_1A80           fcb       $00       ; table, bitmap, or initialized data bytes
Data_1A81           fcc       "  To "                        ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1A87           fcc       "Edit destination name"        ; embedded text or resource bytes
                    fcc       " or"                          ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1AA0           fcc       "Use "                         ; embedded text or resource bytes
                    fcb       $22       ; table, bitmap, or initialized data bytes
                    fcc       "1:"                           ; embedded text or resource bytes
                    fcb       $22       ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $22       ; table, bitmap, or initialized data bytes
                    fcc       "2:"                           ; embedded text or resource bytes
                    fcb       $22       ; table, bitmap, or initialized data bytes
                    fcc       " for data folders,"           ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "and "                         ; embedded text or resource bytes
                    fcb       $22       ; table, bitmap, or initialized data bytes
                    fcc       "3:"                           ; embedded text or resource bytes
                    fcb       $22       ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $22       ; table, bitmap, or initialized data bytes
                    fcc       "4:"                           ; embedded text or resource bytes
                    fcb       $22       ; table, bitmap, or initialized data bytes
                    fcc       " for program folders"         ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1AE2           fcc       "Filename must be 1-8 "        ; embedded text or resource bytes
                    fcc       "characters,"                  ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "begin with a-z,"              ; embedded text or resource bytes
                    fcb       $00,$26   ; table, bitmap, or initialized data bytes
                    fcc       " contain a-z or 0-9."         ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1B29           fcc       "Folders and files are"        ; embedded text or resource bytes
                    fcc       " identical,"                  ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "is this a single disk"        ; embedded text or resource bytes
                    fcc       " copy ?"                      ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1B67           fcc       "Press any key to canc"        ; embedded text or resource bytes
                    fcc       "el."                          ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1B80           fcc       "Destination folder no"        ; embedded text or resource bytes
                    fcc       "t found or"                   ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1BA0           fcc       "disk is write protect"        ; embedded text or resource bytes
                    fcc       "ed"                           ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1BB8           fcc       "File exists, overwrit"        ; embedded text or resource bytes
                    fcc       "e it?"                        ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1BD3           fcb       $08,$08,$08,$08 ; table, bitmap, or initialized data bytes
                    fcc       "Yes"                          ; embedded text or resource bytes
                    fcb       $08,$08,$08,$08,$08,$08 ; table, bitmap, or initialized data bytes
                    fcc       "No"                           ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1BE3           fcc       "Can't OPEN or READ so"        ; embedded text or resource bytes
                    fcc       "urce file"                    ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1C02           fcc       "Can't WRITE destinati"        ; embedded text or resource bytes
                    fcc       "on file"                      ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1C1F           fcc       "Disk is full, can't c"        ; embedded text or resource bytes
                    fcc       "opy file"                     ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1C3D           fcc       "Copy the help file ?"         ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1C52           fcc       "Working"                      ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1C5A           fcc       "/D0/CONFIG.DESK"              ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1C6A           fcc       "Destination disk does"        ; embedded text or resource bytes
                    fcc       " not contain"                 ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "DeskMate. Copy cancel"        ; embedded text or resource bytes
                    fcc       "led!"                         ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1CA6           fcc       "Put source disk in dr"        ; embedded text or resource bytes
                    fcc       "ive 0"                        ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1CC1           fcc       "Put destination disk "        ; embedded text or resource bytes
                    fcc       "in drive 0"                   ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1CE1           fcc       "Copy Complete"                ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1CEF           fcc       "          "                   ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_1CFA           pshs      U,Y,X,D   ; preserve the listed registers on the stack
                    leax      Data_1A73,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    clr       Data_0083 ; clear the selected byte or register
                    lda       Data_0036 ; load the value needed by the following operation
                    leax      $0100,U   ; form the referenced address without reading memory
                    leay      Data_1A81,PCR ; form the referenced address without reading memory
                    lbsr      Code_1A15 ; call the referenced helper routine
                    tst       Data_003E ; set condition flags from the current value
                    bne       Code_1D25 ; branch when the compared values differ
                    lda       Addr_002E ; load the value needed by the following operation
                    eora      #$03      ; toggle the selected bits
                    anda      #$03      ; mask off unwanted bits
                    bne       Code_1D21 ; branch when the compared values differ
                    lda       #$04      ; load the value needed by the following operation
Code_1D21           adda      #$30      ; add the operand to the running value
                    sta       $05,X     ; save the current value in working storage
Code_1D25           lda       Data_0036 ; load the value needed by the following operation
                    leax      $0120,U   ; form the referenced address without reading memory
                    leay      Data_1A7B,PCR ; form the referenced address without reading memory
                    lbsr      Code_1A15 ; call the referenced helper routine
Code_1D32           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "?"                            ; embedded text or resource bytes
                    ldx       #DeskMateService ; load the value needed by the following operation
                    stx       Data_005C ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "4"                            ; embedded text or resource bytes
                    tst       Code_002C ; set condition flags from the current value
                    lbne      Code_1DE4 ; take the distant branch when values differ
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      $0120,U   ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    ldd       Data_005C ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    lbsr      Code_268F ; call the referenced helper routine
                    adda      #$02      ; add the operand to the running value
                    std       Data_005C ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      $0105,U   ; form the referenced address without reading memory
                    stx       Data_005E ; save the current value in working storage
                    leax      -$05,X    ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "3"                            ; embedded text or resource bytes
                    lbsr      Code_2224 ; call the referenced helper routine
                    tst       Data_005B ; set condition flags from the current value
                    bmi       Code_1D81 ; branch while the tested value is negative
                    ldd       Data_005C ; load the value needed by the following operation
                    lbsr      Code_268F ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      Data_1C3D,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
Code_1D81           lbsr      Code_1380 ; call the referenced helper routine
                    lda       #$FF      ; load the value needed by the following operation
                    lbsr      Code_21EB ; call the referenced helper routine
                    leax      $60,U     ; form the referenced address without reading memory
                    lda       $0105,U   ; load the value needed by the following operation
                    sta       ,X        ; save the current value in working storage
                    clr       $01,X     ; clear the selected byte or register
                    ldd       Data_005C ; load the value needed by the following operation
                    addd      #Addr_FE05 ; add the operand to the running value
                    lbsr      Code_268F ; call the referenced helper routine
                    lda       #$81      ; load the value needed by the following operation
Code_1D9E           clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $16       ; private DeskMate service selector
                    lbsr      Code_3183 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "3"                            ; embedded text or resource bytes
                    tsta                ; set condition flags from the current value
                    beq       Code_1DB9 ; branch when the compared values are equal
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    beq       Code_1DCC ; branch when the compared values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    beq       Code_1DC3 ; branch when the compared values are equal
                    lda       #$01      ; load the value needed by the following operation
                    bra       Code_1D9E ; continue at the selected control-flow target
Code_1DB9           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "E"                            ; embedded text or resource bytes
                    cmpy      #Addr_0006 ; compare against the limit and set condition flags
                    bcs       Code_1DCC ; branch when carry reports an unsigned underflow or error
Code_1DC3           tst       Data_005B ; set condition flags from the current value
                    lbmi      Code_2170 ; take the distant branch while the value is negative
                    lbra      Code_21E0 ; continue at the distant control-flow target
Code_1DCC           lda       Data_0060 ; load the value needed by the following operation
                    cmpa      #$33      ; compare against the limit and set condition flags
                    beq       Code_1DD8 ; branch when the compared values are equal
                    cmpa      #$34      ; compare against the limit and set condition flags
                    lbne      Code_1EB4 ; take the distant branch when values differ
Code_1DD8           sta       $0105,U   ; save the current value in working storage
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $01       ; private DeskMate service selector
                    lbra      Code_1F1D ; continue at the distant control-flow target
Code_1DE4           leax      $0120,U   ; form the referenced address without reading memory
                    leay      Addr_409B,PCR ; form the referenced address without reading memory
                    sty       Data_005E ; save the current value in working storage
Code_1DEF           lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,Y+       ; store the value and advance the destination pointer
                    cmpa      #$2E      ; compare against the limit and set condition flags
                    bne       Code_1DEF ; branch when the compared values differ
                    clr       -$01,Y    ; clear the selected byte or register
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      Addr_409B,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    lda       Data_005B ; load the value needed by the following operation
                    ldb       #$63      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    leax      $0B22,U   ; form the referenced address without reading memory
                    leax      D,X       ; form the referenced address without reading memory
                    ldd       #Data_3D28 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    lbsr      Code_2224 ; call the referenced helper routine
                    ldd       Data_005C ; load the value needed by the following operation
                    adda      #$03      ; add the operand to the running value
                    std       Data_005C ; save the current value in working storage
                    lbsr      Code_268F ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      Data_1A87,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "3"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    lbsr      Code_1380 ; call the referenced helper routine
                    lda       #$FF      ; load the value needed by the following operation
                    lbsr      Code_21EB ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "4"                            ; embedded text or resource bytes
                    ldd       Data_005C ; load the value needed by the following operation
                    suba      #$02      ; subtract the operand from the running value
                    lbsr      Code_268F ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      Data_1A81,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    ldd       Data_005C ; load the value needed by the following operation
                    suba      #$02      ; subtract the operand from the running value
                    addb      #$05      ; add the operand to the running value
                    lbsr      Code_268F ; call the referenced helper routine
                    ldd       #Code_200A ; load the value needed by the following operation
                    leax      Addr_409B,PCR ; form the referenced address without reading memory
Code_1E5C           sta       ,X+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bne       Code_1E5C ; branch when the compared values differ
                    stb       ,X        ; save the current value in working storage
                    leax      -$0A,X    ; form the referenced address without reading memory
                    leay      $0105,U   ; form the referenced address without reading memory
Code_1E69           lda       ,Y+       ; fetch the next value and advance the source pointer
                    cmpa      #$2E      ; compare against the limit and set condition flags
                    beq       Code_1E73 ; branch when the compared values are equal
                    sta       ,X+       ; store the value and advance the destination pointer
                    bra       Code_1E69 ; continue at the selected control-flow target
Code_1E73           lda       #$8A      ; load the value needed by the following operation
Code_1E75           clrb                ; clear the selected byte or register
                    leax      Addr_409B,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $16       ; private DeskMate service selector
                    lbsr      Code_3183 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "3"                            ; embedded text or resource bytes
                    tsta                ; set condition flags from the current value
                    beq       Code_1E96 ; branch when the compared values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    lbeq      Code_21E0 ; take the distant branch when values are equal
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    beq       Code_1EA6 ; branch when the compared values are equal
                    lda       #$0A      ; load the value needed by the following operation
                    bra       Code_1E75 ; continue at the selected control-flow target
Code_1E96           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "E"                            ; embedded text or resource bytes
                    cmpy      #Addr_0006 ; compare against the limit and set condition flags
                    lbcc      Code_21E0 ; take the distant branch when carry is clear
                    leax      Addr_409B,PCR ; form the referenced address without reading memory
Code_1EA6           ldd       ,X        ; load the value needed by the following operation
                    cmpd      #Data_313A ; compare against the limit and set condition flags
                    beq       Code_1EC7 ; branch when the compared values are equal
                    cmpd      #Addr_323A ; compare against the limit and set condition flags
                    beq       Code_1EC7 ; branch when the compared values are equal
Code_1EB4           lbsr      Code_2224 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      Data_1AA0,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    ldd       Data_005C ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    lbra      Code_1F68 ; continue at the distant control-flow target
Code_1EC7           lda       ,X+       ; fetch the next value and advance the source pointer
                    beq       Code_1ED5 ; branch when the compared values are equal
                    cmpa      #$20      ; compare against the limit and set condition flags
                    beq       Code_1ED5 ; branch when the compared values are equal
                    cmpa      #$2E      ; compare against the limit and set condition flags
                    beq       Code_1F4B ; branch when the compared values are equal
                    bra       Code_1EC7 ; continue at the selected control-flow target
Code_1ED5           clr       -$01,X    ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "4"                            ; embedded text or resource bytes
                    ldd       Data_005C ; load the value needed by the following operation
                    addd      #Addr_FE05 ; add the operand to the running value
                    lbsr      Code_268F ; call the referenced helper routine
                    pshs      X,D       ; preserve the listed registers on the stack
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      Data_1CEF,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    puls      D         ; restore the listed registers from the stack
                    lbsr      Code_268F ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      Addr_409B,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "3"                            ; embedded text or resource bytes
                    puls      X         ; restore the listed registers from the stack
                    lda       Data_005B ; load the value needed by the following operation
                    ldb       #$03      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    leay      $0354,U   ; form the referenced address without reading memory
                    leay      D,Y       ; form the referenced address without reading memory
                    lda       #$2E      ; load the value needed by the following operation
                    ldb       ,Y        ; load the value needed by the following operation
                    std       -$01,X    ; save the current value in working storage
                    ldd       $01,Y     ; load the value needed by the following operation
                    andb      #$7F      ; mask off unwanted bits
                    std       $01,X     ; save the current value in working storage
                    clr       $03,X     ; clear the selected byte or register
Code_1F1D           lda       #$3A      ; load the value needed by the following operation
                    leay      Addr_4095,PCR ; form the referenced address without reading memory
                    leax      $0125,U   ; form the referenced address without reading memory
                    stx       ,Y        ; save the current value in working storage
                    leax      Data_1A80,PCR ; form the referenced address without reading memory
                    stx       $02,Y     ; save the current value in working storage
                    leax      $0140,U   ; form the referenced address without reading memory
                    stx       $04,Y     ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "J"                            ; embedded text or resource bytes
                    ldx       Data_005E ; load the value needed by the following operation
                    stx       ,Y        ; save the current value in working storage
                    leax      $017A,U   ; form the referenced address without reading memory
                    stx       $04,Y     ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "J"                            ; embedded text or resource bytes
                    bitb      #$02      ; test the selected flag bits without changing the value
                    beq       Code_1F8A ; branch when the compared values are equal
Code_1F4B           lbsr      Code_2224 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      Data_1AE2,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    ldd       Data_005C ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    lbsr      Code_268F ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    ldd       Data_005C ; load the value needed by the following operation
                    adda      #$02      ; add the operand to the running value
Code_1F68           lbsr      Code_268F ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    ldd       Data_005C ; load the value needed by the following operation
                    adda      #$03      ; add the operand to the running value
                    lbsr      Code_268F ; call the referenced helper routine
                    lda       #$03      ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1C       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "E"                            ; embedded text or resource bytes
                    lbra      Code_1D32 ; continue at the distant control-flow target
Code_1F8A           leax      $0140,U   ; form the referenced address without reading memory
                    leay      $017A,U   ; form the referenced address without reading memory
Code_1F92           lda       ,X+       ; fetch the next value and advance the source pointer
                    beq       Code_1F9C ; branch when the compared values are equal
                    cmpa      ,Y+       ; compare against the limit and set condition flags
                    bne       Code_1FEA ; branch when the compared values differ
                    bra       Code_1F92 ; continue at the selected control-flow target
Code_1F9C           lbsr      Code_2224 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      Data_1B29,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    ldd       Data_005C ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    lbsr      Code_268F ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    ldd       Data_005C ; load the value needed by the following operation
                    adda      #$02      ; add the operand to the running value
                    pshs      D         ; preserve the listed registers on the stack
                    lbsr      Code_268F ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      Data_1BD3,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    puls      D         ; restore the listed registers from the stack
                    adda      #$07      ; add the operand to the running value
                    asla                ; shift left and update carry
                    asla                ; shift left and update carry
                    asla                ; shift left and update carry
                    inca                ; advance the selected counter
                    addb      #$06      ; add the operand to the running value
                    tfr       D,X       ; copy the source register into the destination register
                    addb      #$10      ; add the operand to the running value
                    tfr       D,Y       ; copy the source register into the destination register
                    clra                ; clear the selected byte or register
                    lbsr      Code_2773 ; call the referenced helper routine
                    dec       Data_0083 ; decrement the selected counter
                    tstb                ; set condition flags from the current value
                    beq       Code_1FEA ; branch when the compared values are equal
                    tst       Data_005B ; set condition flags from the current value
                    lbmi      Code_2170 ; take the distant branch while the value is negative
                    lbra      Code_21E0 ; continue at the distant control-flow target
Code_1FEA           lbsr      Code_2224 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      Data_1C52,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    leax      $0140,U   ; form the referenced address without reading memory
                    lda       #$05      ; load the value needed by the following operation
                    tst       Code_002C ; set condition flags from the current value
                    beq       Code_2003 ; branch when the compared values are equal
                    lda       #$01      ; load the value needed by the following operation
Code_2003           os9       I$Open    ; request the named OS-9 service
                    bcc       Code_2011 ; branch when carry is clear
Code_2008           ldd       Data_005C ; load the value needed by the following operation
Code_200A           leax      Data_1BE3,PCR ; form the referenced address without reading memory
                    lbra      Code_21B2 ; continue at the distant control-flow target
Code_2011           sta       Data_0061 ; save the current value in working storage
                    leax      Addr_4095,PCR ; form the referenced address without reading memory
                    ldy       #Addr_1F00 ; load the value needed by the following operation
                    os9       I$Read    ; request the named OS-9 service
                    sty       Data_0084 ; save the current value in working storage
                    leax      Data_1BE3,PCR ; form the referenced address without reading memory
                    lbcs      Code_2114 ; take the distant branch when carry reports an error
                    lda       #$FF      ; load the value needed by the following operation
                    lbsr      Code_2276 ; call the referenced helper routine
                    clrb                ; clear the selected byte or register
                    cmpa      #$05      ; compare against the limit and set condition flags
                    lbeq      Code_2114 ; take the distant branch when values are equal
                    tst       Data_0083 ; set condition flags from the current value
                    beq       Code_205D ; branch when the compared values are equal
                    lbsr      Code_22C4 ; call the referenced helper routine
                    bcc       Code_205D ; branch when carry is clear
                    lbsr      Code_2224 ; call the referenced helper routine
Code_2041           clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      Data_1C6A,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    ldd       Data_005C ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    lbsr      Code_268F ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    incb                ; advance the selected counter
                    leax      -$01,X    ; form the referenced address without reading memory
                    lbra      Code_2114 ; continue at the distant control-flow target
Code_205D           ldd       #Data_0307 ; load the value needed by the following operation
                    tst       Code_002C ; set condition flags from the current value
                    beq       Code_2066 ; branch when the compared values are equal
                    ldb       #$0B      ; load the value needed by the following operation
Code_2066           leax      $017A,U   ; form the referenced address without reading memory
                    os9       I$Create  ; request the named OS-9 service
                    sta       Data_0062 ; save the current value in working storage
                    leax      Addr_4095,PCR ; form the referenced address without reading memory
                    lbcc      Code_2135 ; take the distant branch when carry is clear
                    cmpb      #$DA      ; compare against the limit and set condition flags
                    beq       Code_2097 ; branch when the compared values are equal
                    cmpb      #$F8      ; compare against the limit and set condition flags
                    bne       Code_2086 ; branch when the compared values differ
                    leax      Data_1C1F,PCR ; form the referenced address without reading memory
                    lbra      Code_2114 ; continue at the distant control-flow target
Code_2086           lda       Data_005C ; load the value needed by the following operation
                    suba      #$03      ; subtract the operand from the running value
                    sta       Data_005C ; save the current value in working storage
                    leax      Data_1B80,PCR ; form the referenced address without reading memory
                    lbsr      Code_223B ; call the referenced helper routine
                    clrb                ; clear the selected byte or register
                    lbra      Code_2114 ; continue at the distant control-flow target
Code_2097           lbsr      Code_2224 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      Data_1BB8,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    ldd       Data_005C ; load the value needed by the following operation
                    adda      #$02      ; add the operand to the running value
                    pshs      D         ; preserve the listed registers on the stack
                    lbsr      Code_268F ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    puls      D         ; restore the listed registers from the stack
                    addd      #Code_0706 ; add the operand to the running value
                    asla                ; shift left and update carry
                    asla                ; shift left and update carry
                    asla                ; shift left and update carry
                    inca                ; advance the selected counter
                    incb                ; advance the selected counter
                    tfr       D,X       ; copy the source register into the destination register
                    addb      #$0E      ; add the operand to the running value
                    tfr       D,Y       ; copy the source register into the destination register
                    clra                ; clear the selected byte or register
                    lbsr      Code_2773 ; call the referenced helper routine
                    tstb                ; set condition flags from the current value
                    beq       Code_20D8 ; branch when the compared values are equal
                    lda       Data_0061 ; load the value needed by the following operation
                    os9       I$Close   ; request the named OS-9 service
                    tst       Data_005B ; set condition flags from the current value
                    lbmi      Code_2170 ; take the distant branch while the value is negative
                    lbra      Code_21E0 ; continue at the distant control-flow target
Code_20D8           lbsr      Code_2224 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      Data_1C52,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    leax      $017A,U   ; form the referenced address without reading memory
                    os9       I$Delete  ; request the named OS-9 service
                    bcs       Code_2086 ; branch when carry reports an unsigned underflow or error
                    lbra      Code_205D ; continue at the distant control-flow target
Code_20F1           clra                ; clear the selected byte or register
                    lbsr      Code_2276 ; call the referenced helper routine
                    clrb                ; clear the selected byte or register
                    cmpa      #$05      ; compare against the limit and set condition flags
                    beq       Code_2110 ; branch when the compared values are equal
                    lda       Data_0061 ; load the value needed by the following operation
                    leax      Addr_4095,PCR ; form the referenced address without reading memory
                    ldy       #Addr_1F00 ; load the value needed by the following operation
                    os9       I$Read    ; request the named OS-9 service
                    sty       Data_0084 ; save the current value in working storage
                    bcc       Code_212B ; branch when carry is clear
                    leax      Data_1BE3,PCR ; form the referenced address without reading memory
Code_2110           pshs      B         ; preserve the listed registers on the stack
                    puls      B         ; restore the listed registers from the stack
Code_2114           pshs      B         ; preserve the listed registers on the stack
                    lda       Data_0061 ; load the value needed by the following operation
                    os9       I$Close   ; request the named OS-9 service
                    puls      B         ; restore the listed registers from the stack
                    tstb                ; set condition flags from the current value
                    lbeq      Code_21E0 ; take the distant branch when values are equal
                    cmpb      #$D3      ; compare against the limit and set condition flags
                    beq       Code_216C ; branch when the compared values are equal
                    ldd       Data_005C ; load the value needed by the following operation
                    lbra      Code_21B2 ; continue at the distant control-flow target
Code_212B           lda       #$FF      ; load the value needed by the following operation
                    lbsr      Code_2276 ; call the referenced helper routine
                    clrb                ; clear the selected byte or register
                    cmpa      #$05      ; compare against the limit and set condition flags
                    beq       Code_2110 ; branch when the compared values are equal
Code_2135           lda       Data_0062 ; load the value needed by the following operation
                    ldy       Data_0084 ; load the value needed by the following operation
                    os9       I$Write   ; request the named OS-9 service
                    bcs       Code_214E ; branch when carry reports an unsigned underflow or error
                    ldd       Data_0084 ; load the value needed by the following operation
Code_2141           cmpd      #Addr_1F00 ; compare against the limit and set condition flags
                    beq       Code_20F1 ; branch when the compared values are equal
                    lda       Data_0062 ; load the value needed by the following operation
                    os9       I$Close   ; request the named OS-9 service
                    bra       Code_20F1 ; continue at the selected control-flow target
Code_214E           pshs      B         ; preserve the listed registers on the stack
                    lda       Data_0062 ; load the value needed by the following operation
                    os9       I$Close   ; request the named OS-9 service
                    leax      $017A,U   ; form the referenced address without reading memory
                    os9       I$Delete  ; request the named OS-9 service
                    puls      B         ; restore the listed registers from the stack
                    leax      Data_1C02,PCR ; form the referenced address without reading memory
                    cmpb      #$F8      ; compare against the limit and set condition flags
                    bne       Code_2110 ; branch when the compared values differ
                    leax      Data_1C1F,PCR ; form the referenced address without reading memory
                    bra       Code_2110 ; continue at the selected control-flow target
Code_216C           tst       Data_005B ; set condition flags from the current value
                    bpl       Code_2195 ; branch while the tested value is nonnegative
Code_2170           clr       Data_005B ; clear the selected byte or register
                    leax      $0120,U   ; form the referenced address without reading memory
                    leay      $0100,U   ; form the referenced address without reading memory
Code_217A           leax      $01,X     ; form the referenced address without reading memory
                    tst       ,Y+       ; set condition flags from the current value
                    bne       Code_217A ; branch when the compared values differ
                    ldd       #Addr_2E48 ; load the value needed by the following operation
                    std       -$01,X    ; save the current value in working storage
                    std       -$01,Y    ; save the current value in working storage
                    ldd       #Addr_4C50 ; load the value needed by the following operation
                    std       $01,X     ; save the current value in working storage
                    std       $01,Y     ; save the current value in working storage
                    clr       $03,X     ; clear the selected byte or register
                    clr       $03,Y     ; clear the selected byte or register
                    lbra      Code_1D32 ; continue at the distant control-flow target
Code_2195           lbsr      Code_2224 ; call the referenced helper routine
                    leax      Data_1CE1,PCR ; form the referenced address without reading memory
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    ldd       Data_005C ; load the value needed by the following operation
                    adda      #$03      ; add the operand to the running value
                    lbsr      Code_268F ; call the referenced helper routine
                    lda       #$03      ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    bra       Code_21CC ; continue at the selected control-flow target
Code_21B2           lbsr      Code_268F ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    ldd       Data_005C ; load the value needed by the following operation
                    adda      #$03      ; add the operand to the running value
                    lbsr      Code_268F ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      Data_1B67,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
Code_21CC           lbsr      Code_1380 ; call the referenced helper routine
                    ldb       #$80      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1C       ; private DeskMate service selector
                    lbsr      start     ;21D5: 17 DE 3B       '.. ; call the referenced helper routine
                    fcc       "E"                            ; embedded text or resource bytes
                    tst       Code_002C ; set condition flags from the current value
                    beq       Code_21E0 ; branch when the compared values are equal
                    lbsr      Code_0B34 ; call the referenced helper routine
Code_21E0           clr       Data_003E ; clear the selected byte or register
                    leax      Data_1A73,PCR ; form the referenced address without reading memory
                    lbsr      Code_16B2 ; call the referenced helper routine
                    puls      PC,U,Y,X,D ; restore the listed registers from the stack
Code_21EB           pshs      U,Y,X,D   ; preserve the listed registers on the stack
                    ldd       Data_005C ; load the value needed by the following operation
                    adda      #$02      ; add the operand to the running value
                    lbsr      Code_268F ; call the referenced helper routine
                    lda       #$01      ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    ldd       Data_005C ; load the value needed by the following operation
                    adda      #$03      ; add the operand to the running value
                    lbsr      Code_268F ; call the referenced helper routine
                    lda       #$02      ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    puls      A         ; restore the listed registers from the stack
                    tsta                ; set condition flags from the current value
                    bmi       Code_2222 ; branch while the tested value is negative
                    lbsr      Code_1380 ; call the referenced helper routine
Code_2211           ldb       #$80      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1C       ; private DeskMate service selector
                    tsta                ; set condition flags from the current value
                    beq       Code_2222 ; branch when the compared values are equal
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    beq       Code_2222 ; branch when the compared values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    bne       Code_2211 ; branch when the compared values differ
Code_2222           puls      PC,U,Y,X,B ; restore the listed registers from the stack
Code_2224           pshs      Y,X       ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    ldx       #DeskMateService ; load the value needed by the following operation
                    ldy       #Addr_0003 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "@"                            ; embedded text or resource bytes
                    puls      PC,Y,X    ; restore the listed registers from the stack
Code_223B           pshs      Y,X,D     ; preserve the listed registers on the stack
                    bsr       Code_2224 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    ldd       Data_005C ; load the value needed by the following operation
                    adda      #$04      ; add the operand to the running value
                    lbsr      Code_268F ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      Data_1BA0,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    ldd       Data_005C ; load the value needed by the following operation
                    adda      #$05      ; add the operand to the running value
                    lbsr      Code_268F ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      Data_1B67,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    lbsr      Code_1380 ; call the referenced helper routine
                    ldb       #$80      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1C       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "E"                            ; embedded text or resource bytes
                    puls      PC,Y,X,D  ; restore the listed registers from the stack
Code_2276           pshs      Y,X,D     ; preserve the listed registers on the stack
                    tst       Data_0083 ; set condition flags from the current value
                    beq       Code_22C2 ; branch when the compared values are equal
                    leax      $0086,U   ; form the referenced address without reading memory
                    leay      Data_1CA6,PCR ; form the referenced address without reading memory
                    tst       ,S        ; set condition flags from the current value
                    beq       Code_228C ; branch when the compared values are equal
                    leay      Data_1CC1,PCR ; form the referenced address without reading memory
Code_228C           lda       ,Y+       ; fetch the next value and advance the source pointer
                    sta       ,X+       ; store the value and advance the destination pointer
                    bne       Code_228C ; branch when the compared values differ
                    lda       $0142,U   ; load the value needed by the following operation
                    sta       -$02,X    ; save the current value in working storage
                    lbsr      Code_2224 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      $0086,U   ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    ldd       Data_005C ; load the value needed by the following operation
                    adda      #$03      ; add the operand to the running value
                    lbsr      Code_268F ; call the referenced helper routine
                    lda       #$03      ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    lbsr      Code_1380 ; call the referenced helper routine
                    ldb       #$80      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1C       ; private DeskMate service selector
                    sta       ,S        ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "E"                            ; embedded text or resource bytes
Code_22C2           puls      PC,Y,X,D  ; restore the listed registers from the stack
Code_22C4           pshs      Y,X,D     ; preserve the listed registers on the stack
                    leax      Data_1C5A,PCR ; form the referenced address without reading memory
                    leay      $0086,U   ; form the referenced address without reading memory
Code_22CE           lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,Y+       ; store the value and advance the destination pointer
                    bne       Code_22CE ; branch when the compared values differ
                    leax      $0086,U   ; form the referenced address without reading memory
                    lda       $0142,U   ; load the value needed by the following operation
                    cmpa      #$31      ; compare against the limit and set condition flags
                    bne       Code_22E2 ; branch when the compared values differ
                    sta       $02,X     ; save the current value in working storage
Code_22E2           lda       #$01      ; load the value needed by the following operation
                    os9       I$Open    ; request the named OS-9 service
                    bcs       Code_2334 ; branch when carry reports an unsigned underflow or error
                    sta       Data_0062 ; save the current value in working storage
                    lda       $0105,U   ; load the value needed by the following operation
                    suba      #$30      ; subtract the operand from the running value
                    ldb       #$29      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    ldx       #DeskMateService ; load the value needed by the following operation
                    ldu       #Addr_0026 ; load the value needed by the following operation
                    leau      D,U       ; form the referenced address without reading memory
                    lda       Data_0062 ; load the value needed by the following operation
                    os9       I$Seek    ; request the named OS-9 service
                    ldu       DeskMateService ; load the value needed by the following operation
                    bcs       Code_232B ; branch when carry reports an unsigned underflow or error
                    leax      $017A,U   ; form the referenced address without reading memory
                    ldy       #Addr_0029 ; load the value needed by the following operation
                    os9       I$Read    ; request the named OS-9 service
                    bcs       Code_232B ; branch when carry reports an unsigned underflow or error
                    leay      $0127,U   ; form the referenced address without reading memory
                    lda       $0142,U   ; load the value needed by the following operation
                    sta       $02,X     ; save the current value in working storage
Code_231C           tst       ,X+       ; set condition flags from the current value
                    bne       Code_231C ; branch when the compared values differ
                    lda       #$2F      ; load the value needed by the following operation
                    sta       -$01,X    ; save the current value in working storage
Code_2324           lda       ,Y+       ; fetch the next value and advance the source pointer
                    sta       ,X+       ; store the value and advance the destination pointer
                    bne       Code_2324 ; branch when the compared values differ
                    clrb                ; clear the selected byte or register
Code_232B           pshs      CC        ; preserve the listed registers on the stack
                    lda       Data_0062 ; load the value needed by the following operation
                    os9       I$Close   ; request the named OS-9 service
                    puls      CC        ; restore the listed registers from the stack
Code_2334           puls      PC,Y,X,D  ; restore the listed registers from the stack
Data_2336           fcb       $00,$01,$07,$1A,$08,$00 ; table, bitmap, or initialized data bytes
                    fcb       $AA,$F0   ; table, bitmap, or initialized data bytes
Data_233E           fcc       "Delete: "                     ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_2347           fcc       "Delete help file ?"           ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_235A           fcc       "Can't find file or"           ; embedded text or resource bytes
Data_236C           fcb       $00       ; table, bitmap, or initialized data bytes
Code_236D           pshs      U,Y,X,D   ; preserve the listed registers on the stack
                    leax      >Data_2336,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    clr       Data_005E ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "?"                            ; embedded text or resource bytes
                    ldx       #DeskMateService ; load the value needed by the following operation
                    stx       Data_005C ; save the current value in working storage
                    lda       Data_0036 ; load the value needed by the following operation
                    leax      $0100,U   ; form the referenced address without reading memory
                    leay      >Data_233E,PCR ; form the referenced address without reading memory
                    lbsr      Code_1A15 ; call the referenced helper routine
Code_238F           clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    inc       Data_005C ; advance the selected counter
                    inc       Data_005C ; advance the selected counter
                    clra                ; clear the selected byte or register
                    lbsr      Code_21EB ; call the referenced helper routine
                    dec       Data_005C ; decrement the selected counter
                    dec       Data_005C ; decrement the selected counter
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    beq       Code_23BA ; branch when the compared values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    beq       Code_23B3 ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "E"                            ; embedded text or resource bytes
                    cmpy      #Addr_0005 ; compare against the limit and set condition flags
                    bcs       Code_23BA ; branch when carry reports an unsigned underflow or error
Code_23B3           tst       Data_005B ; set condition flags from the current value
                    bmi       Code_23F2 ;23B5: 2B 3B          '+ ; branch while the tested value is negative
                    lbra      Code_2452 ; continue at the distant control-flow target
Code_23BA           leay      $0120,U   ; form the referenced address without reading memory
                    leax      $0108,U   ; form the referenced address without reading memory
                    stx       ,Y        ; save the current value in working storage
                    leax      >Data_236C,PCR ; form the referenced address without reading memory
                    stx       $02,Y     ; save the current value in working storage
                    leax      $017A,U   ; form the referenced address without reading memory
                    stx       $04,Y     ; save the current value in working storage
                    lda       #$58      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "J"                            ; embedded text or resource bytes
                    lbsr      Code_2224 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      Data_1C52,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    leax      $017A,U   ; form the referenced address without reading memory
                    os9       I$Delete  ; request the named OS-9 service
                    bcs       Code_2428 ; branch when carry reports an unsigned underflow or error
                    lda       Data_005B ; load the value needed by the following operation
                    sta       Data_005E ; save the current value in working storage
                    bpl       Code_2433 ; branch while the tested value is nonnegative
Code_23F2           clr       Data_005B ; clear the selected byte or register
                    leax      $0100,U   ; form the referenced address without reading memory
Code_23F8           tst       ,X+       ; set condition flags from the current value
                    bne       Code_23F8 ; branch when the compared values differ
                    ldd       #Addr_2E48 ; load the value needed by the following operation
                    std       -$01,X    ; save the current value in working storage
                    ldd       #Addr_4C50 ; load the value needed by the following operation
                    std       $01,X     ; save the current value in working storage
                    clr       $03,X     ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "?"                            ; embedded text or resource bytes
                    leax      $0100,U   ; form the referenced address without reading memory
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    tst       Data_005E ; set condition flags from the current value
                    bmi       Code_23BA ; branch while the tested value is negative
                    ldd       Data_005C ; load the value needed by the following operation
                    adda      #$03      ; add the operand to the running value
                    lbsr      Code_268F ; call the referenced helper routine
                    leax      Data_2347,PCR ; form the referenced address without reading memory
                    lbra      Code_238F ; continue at the distant control-flow target
Code_2428           tst       Data_005E ; set condition flags from the current value
                    bmi       Code_243C ; branch while the tested value is negative
                    leax      Data_235A,PCR ; form the referenced address without reading memory
                    lbsr      Code_223B ; call the referenced helper routine
Code_2433           tst       Code_002C ; set condition flags from the current value
                    beq       Code_243C ; branch when the compared values are equal
                    lbsr      Code_0B34 ; call the referenced helper routine
                    bra       Code_243F ; continue at the selected control-flow target
Code_243C           lbsr      Code_09AF ; call the referenced helper routine
Code_243F           lda       #$00      ; load the value needed by the following operation
                    leax      $52,U     ; form the referenced address without reading memory
                    sta       ,X        ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $13       ; private DeskMate service selector
                    clr       Data_0035 ; clear the selected byte or register
                    clr       Data_0036 ; clear the selected byte or register
                    clr       Data_0037 ; clear the selected byte or register
                    clr       Data_0038 ; clear the selected byte or register
Code_2452           leax      Data_2336,PCR ; form the referenced address without reading memory
                    lbsr      Code_16B2 ; call the referenced helper routine
                    puls      PC,U,Y,X,D ; restore the listed registers from the stack
Data_245B           fcc       "DMLOAD"                       ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
Data_2462           fcb       $0C       ; table, bitmap, or initialized data bytes
Data_2463           fcb       $00,$01,$08,$1E,$09,$00 ; table, bitmap, or initialized data bytes
                    fcb       $AA,$F0   ; table, bitmap, or initialized data bytes
Data_246B           fcc       "Rename "                      ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_2473           fcc       "    as "                      ; embedded text or resource bytes
Data_247A           fcb       $00       ; table, bitmap, or initialized data bytes
Code_247B           pshs      U,Y,X,D   ; preserve the listed registers on the stack
                    leax      >Data_2463,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
Code_2485           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "?"                            ; embedded text or resource bytes
                    ldx       #DeskMateService ; load the value needed by the following operation
                    stx       Data_005C ; save the current value in working storage
                    lda       Data_0036 ; load the value needed by the following operation
                    leax      $0100,U   ; form the referenced address without reading memory
                    leay      >Data_2473,PCR ; form the referenced address without reading memory
                    lbsr      Code_1A15 ; call the referenced helper routine
                    leax      $09,X     ; form the referenced address without reading memory
                    clr       ,X+       ; clear the selected byte or register
                    ldd       #Code_2008 ; load the value needed by the following operation
Code_24A2           sta       ,X+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bne       Code_24A2 ; branch when the compared values differ
                    stb       ,X        ; save the current value in working storage
                    lda       Data_0036 ; load the value needed by the following operation
                    leax      $0120,U   ; form the referenced address without reading memory
                    leay      >Data_246B,PCR ; form the referenced address without reading memory
                    lbsr      Code_1A15 ; call the referenced helper routine
                    leay      $1762,U   ; form the referenced address without reading memory
Code_24BA           lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,Y+       ; store the value and advance the destination pointer
                    cmpa      #$2E      ; compare against the limit and set condition flags
                    bne       Code_24BA ; branch when the compared values differ
                    clr       -$01,Y    ; clear the selected byte or register
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      $1762,U   ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "4"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "3"                            ; embedded text or resource bytes
                    lda       Data_005B ; load the value needed by the following operation
                    ldb       #$63      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    leax      $0B22,U   ; form the referenced address without reading memory
                    leax      D,X       ; form the referenced address without reading memory
                    ldd       #Addr_4828 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    ldd       Data_005C ; load the value needed by the following operation
                    adda      #$05      ; add the operand to the running value
                    lbsr      Code_268F ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      Data_1A87,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    ldd       Data_005C ; load the value needed by the following operation
                    adda      #$06      ; add the operand to the running value
                    lbsr      Code_268F ; call the referenced helper routine
                    lda       #$02      ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    ldd       Data_005C ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    lbsr      Code_268F ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      $0100,U   ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "4"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    ldd       Data_005C ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    addb      #$09      ; add the operand to the running value
                    lbsr      Code_268F ; call the referenced helper routine
                    lbsr      Code_1380 ; call the referenced helper routine
                    clrb                ; clear the selected byte or register
                    lda       #$88      ; load the value needed by the following operation
Code_2529           leax      $010A,U   ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $16       ; private DeskMate service selector
                    lbsr      Code_3183 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "3"                            ; embedded text or resource bytes
                    tsta                ; set condition flags from the current value
                    beq       Code_254B ; branch when the compared values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    lbeq      Code_267A ; take the distant branch when values are equal
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    lbeq      Code_255B ; take the distant branch when values are equal
                    lda       #$08      ; load the value needed by the following operation
                    bra       Code_2529 ; continue at the selected control-flow target
Code_254B           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "E"                            ; embedded text or resource bytes
                    cmpy      #Addr_0006 ; compare against the limit and set condition flags
                    lbcc      Code_2686 ; take the distant branch when carry is clear
                    leax      $010A,U   ; form the referenced address without reading memory
Code_255B           lda       ,X+       ; fetch the next value and advance the source pointer
                    ldb       #$07      ; load the value needed by the following operation
                    bra       Code_2571 ; continue at the selected control-flow target
Code_2561           lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpa      #$20      ; compare against the limit and set condition flags
                    beq       Code_257F ; branch when the compared values are equal
                    cmpa      #$30      ; compare against the limit and set condition flags
                    lbcs      Code_263A ; take the distant branch when carry reports an error
                    cmpa      #$39      ; compare against the limit and set condition flags
                    ble       Code_257F ; branch when the signed value is at or below the limit
Code_2571           anda      #$DF      ; mask off unwanted bits
                    cmpa      #$41      ; compare against the limit and set condition flags
                    lbcs      Code_263A ; take the distant branch when carry reports an error
                    cmpa      #$5A      ; compare against the limit and set condition flags
                    lbhi      Code_263A ; take the distant branch for unsigned higher
Code_257F           decb                ; decrement the selected counter
                    bpl       Code_2561 ; branch while the tested value is nonnegative
                    leay      $0140,U   ; form the referenced address without reading memory
                    leax      $0127,U   ; form the referenced address without reading memory
                    stx       ,Y        ; save the current value in working storage
                    leax      Data_247A,PCR ; form the referenced address without reading memory
                    stx       $02,Y     ; save the current value in working storage
                    leax      $1762,U   ; form the referenced address without reading memory
                    stx       $04,Y     ; save the current value in working storage
                    lda       #$58      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "J"                            ; embedded text or resource bytes
                    ldx       $04,Y     ; load the value needed by the following operation
                    leay      $010A,U   ; form the referenced address without reading memory
                    clrb                ; clear the selected byte or register
Code_25A5           incb                ; advance the selected counter
                    tst       ,X+       ; set condition flags from the current value
                    bne       Code_25A5 ; branch when the compared values differ
                    lda       #$20      ; load the value needed by the following operation
                    sta       -$01,X    ; save the current value in working storage
Code_25AE           incb                ; advance the selected counter
                    lda       ,Y+       ; fetch the next value and advance the source pointer
                    sta       ,X+       ; store the value and advance the destination pointer
                    beq       Code_25B9 ; branch when the compared values are equal
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bne       Code_25AE ; branch when the compared values differ
Code_25B9           lda       #$2E      ; load the value needed by the following operation
                    sta       -$01,X    ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    addb      #$04      ; add the operand to the running value
                    std       Data_005E ; save the current value in working storage
                    lda       Data_005B ; load the value needed by the following operation
                    ldb       #$03      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    leay      $0354,U   ; form the referenced address without reading memory
                    leay      D,Y       ; form the referenced address without reading memory
                    ldd       ,Y        ; load the value needed by the following operation
                    std       ,X        ; save the current value in working storage
                    lda       $02,Y     ; load the value needed by the following operation
                    anda      #$7F      ; mask off unwanted bits
                    ldb       #$0D      ; load the value needed by the following operation
                    std       $02,X     ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    lbsr      Code_2224 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      Data_1C52,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    ldd       #Data_0100 ; load the value needed by the following operation
                    leax      Data_246B,PCR ; form the referenced address without reading memory
                    ldy       Data_005E ; load the value needed by the following operation
                    pshs      Y,D       ; preserve the listed registers on the stack
                    leay      $17,U     ; form the referenced address without reading memory
Code_25F9           lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,Y+       ; store the value and advance the destination pointer
                    bne       Code_25F9 ; branch when the compared values differ
                    puls      Y,D       ; restore the listed registers from the stack
                    leax      $17,U     ; form the referenced address without reading memory
                    leau      $1762,U   ; form the referenced address without reading memory
                    pshs      U,Y,X,D   ; preserve the listed registers on the stack
                    ldu       DeskMateService ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "N"                            ; embedded text or resource bytes
                    sts       $16,Y     ; save the current value in working storage
                    ldx       #Addr_FFFB ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "O"                            ; embedded text or resource bytes
                    leax      Data_245B,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "V"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "P"                            ; embedded text or resource bytes
                    puls      U,Y,X,D   ; restore the listed registers from the stack
                    ldu       DeskMateService ; load the value needed by the following operation
                    lda       #$01      ; load the value needed by the following operation
                    leax      Data_2462,PCR ; form the referenced address without reading memory
                    ldy       #Addr_0001 ; load the value needed by the following operation
                    os9       I$Write   ; request the named OS-9 service
                    bra       Code_267A ; continue at the selected control-flow target
Code_263A           lbsr      Code_2224 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      Data_1AE2,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    ldd       Data_005C ; load the value needed by the following operation
                    adda      #$04      ; add the operand to the running value
                    lbsr      Code_268F ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    ldd       Data_005C ; load the value needed by the following operation
                    adda      #$05      ; add the operand to the running value
                    lbsr      Code_268F ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    ldd       Data_005C ; load the value needed by the following operation
                    adda      #$06      ; add the operand to the running value
                    lbsr      Code_268F ; call the referenced helper routine
                    lda       #$03      ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1C       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "E"                            ; embedded text or resource bytes
                    lbra      Code_2485 ; continue at the distant control-flow target
Code_267A           tst       Code_002C ; set condition flags from the current value
                    beq       Code_2683 ; branch when the compared values are equal
                    lbsr      Code_0B34 ; call the referenced helper routine
                    bra       Code_2686 ; continue at the selected control-flow target
Code_2683           lbsr      Code_09AF ; call the referenced helper routine
Code_2686           leax      Data_2463,PCR ; form the referenced address without reading memory
                    lbsr      Code_16B2 ; call the referenced helper routine
                    puls      PC,U,Y,X,D ; restore the listed registers from the stack
Code_268F           pshs      Y,X,D     ; preserve the listed registers on the stack
                    pshs      A         ; preserve the listed registers on the stack
                    clra                ; clear the selected byte or register
                    tfr       D,X       ; copy the source register into the destination register
                    ldb       ,S+       ; load the value needed by the following operation
                    tfr       D,Y       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    puls      PC,Y,X,D  ; restore the listed registers from the stack
Data_26A0           fcb       $00,$07,$04,$10,$06,$00 ; table, bitmap, or initialized data bytes
                    fcb       $AA,$F0   ; table, bitmap, or initialized data bytes
Data_26A8           fcc       "Sort by:"                     ; embedded text or resource bytes
                    fcb       $00,$07,$07 ; table, bitmap, or initialized data bytes
                    fcc       " icon"                        ; embedded text or resource bytes
                    fcb       $07,$07,$07 ; table, bitmap, or initialized data bytes
                    fcc       " alpha"                       ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_26C2           pshs      U,Y,X,D   ; preserve the listed registers on the stack
                    leax      >Data_26A0,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "?"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0C       ; private DeskMate service selector
                    stx       Data_005B ; save the current value in working storage
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Addr_002B ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      >Data_26A8,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    ldd       Data_005B ; load the value needed by the following operation
                    adda      #$02      ; add the operand to the running value
                    pshs      D         ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    puls      D         ; restore the listed registers from the stack
                    asla                ; shift left and update carry
                    asla                ; shift left and update carry
                    asla                ; shift left and update carry
                    addb      #$08      ; add the operand to the running value
                    tfr       D,X       ; copy the source register into the destination register
                    addb      #$0D      ; add the operand to the running value
                    tfr       D,Y       ; copy the source register into the destination register
                    lda       Data_003B ;2701: 96 3B          '. ; load the value needed by the following operation
                    lbsr      Code_2773 ; call the referenced helper routine
                    cmpb      #$FF      ; compare against the limit and set condition flags
                    beq       Code_2757 ; branch when the compared values are equal
                    stb       Data_003B ;270A: D7 3B          '. ; save the current value in working storage
                    lda       #$00      ; load the value needed by the following operation
                    lbsr      Code_0CAD ; call the referenced helper routine
                    puls      U,Y,X,D   ; restore the listed registers from the stack
Code_2713           pshs      U,Y,X,D   ; preserve the listed registers on the stack
                    ldb       Addr_0034 ; load the value needed by the following operation
                    beq       Code_2757 ; branch when the compared values are equal
                    leax      $1262,U   ; form the referenced address without reading memory
                    leau      $1162,U   ; form the referenced address without reading memory
                    stx       Data_005B ; save the current value in working storage
                    stu       Data_005D ; save the current value in working storage
                    tst       Data_003B ;2725: 0D 3B          '. ; set condition flags from the current value
                    bne       Code_2741 ; branch when the compared values differ
Code_2729           inc       ,X        ; advance the selected counter
                    leax      $0A,X     ; form the referenced address without reading memory
                    decb                ; decrement the selected counter
                    bne       Code_2729 ; branch when the compared values differ
                    ldb       Addr_0034 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "K"                            ; embedded text or resource bytes
                    ldx       Data_005B ; load the value needed by the following operation
Code_2738           dec       ,X        ; decrement the selected counter
                    leax      $0A,X     ; form the referenced address without reading memory
                    decb                ; decrement the selected counter
                    bne       Code_2738 ; branch when the compared values differ
                    bra       Code_2757 ; continue at the selected control-flow target
Code_2741           inc       $01,U     ; advance the selected counter
                    leau      $02,U     ; form the referenced address without reading memory
                    decb                ; decrement the selected counter
                    bne       Code_2741 ; branch when the compared values differ
                    ldb       Addr_0034 ; load the value needed by the following operation
                    ldu       Data_005D ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "K"                            ; embedded text or resource bytes
Code_2750           dec       $01,U     ; decrement the selected counter
                    leau      $02,U     ; form the referenced address without reading memory
                    decb                ; decrement the selected counter
                    bne       Code_2750 ; branch when the compared values differ
Code_2757           lda       Addr_002B ; load the value needed by the following operation
                    beq       Code_2764 ; branch when the compared values are equal
                    clr       Addr_002B ; clear the selected byte or register
                    leax      Data_26A0,PCR ; form the referenced address without reading memory
                    lbsr      Code_16B2 ; call the referenced helper routine
Code_2764           puls      PC,U,Y,X,D ; restore the listed registers from the stack
Data_2766           fcb       $02       ; table, bitmap, or initialized data bytes
Data_2767           fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$01 ; table, bitmap, or initialized data bytes
Code_2773           pshs      U,Y,X,A   ; preserve the listed registers on the stack
                    ldb       #$02      ; load the value needed by the following operation
                    leax      >Data_2767,PCR ; form the referenced address without reading memory
                    leay      $01,S     ; form the referenced address without reading memory
Code_277D           lda       $01,Y     ; load the value needed by the following operation
                    deca                ; decrement the selected counter
                    sta       ,X        ; save the current value in working storage
                    adda      #$05      ; add the operand to the running value
                    sta       $01,X     ; save the current value in working storage
                    lda       ,Y        ; load the value needed by the following operation
                    lsra                ; shift right and expose the low bit through carry
                    lsra                ; shift right and expose the low bit through carry
                    lsra                ; shift right and expose the low bit through carry
                    deca                ; decrement the selected counter
                    sta       $02,X     ; save the current value in working storage
                    adda      #$02      ; add the operand to the running value
                    sta       $03,X     ; save the current value in working storage
                    leax      $06,X     ; form the referenced address without reading memory
                    leay      $02,Y     ; form the referenced address without reading memory
                    decb                ; decrement the selected counter
                    bne       Code_277D ; branch when the compared values differ
                    lbsr      Code_1380 ; call the referenced helper routine
Code_279C           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $19       ; private DeskMate service selector
                    cmpd      #DeskMateService ; compare against the limit and set condition flags
                    bne       Code_279C ; branch when the compared values differ
                    clr       Data_0041 ; clear the selected byte or register
                    bra       Code_27DF ; continue at the selected control-flow target
Code_27AA           ldb       #$80      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    clrb                ; clear the selected byte or register
                    cmpa      #$08      ; compare against the limit and set condition flags
                    beq       Code_27D9 ; branch when the compared values are equal
                    incb                ; advance the selected counter
                    cmpa      #$09      ; compare against the limit and set condition flags
                    beq       Code_27D9 ; branch when the compared values are equal
                    ldb       ,S        ; load the value needed by the following operation
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    beq       Code_2818 ; branch when the compared values are equal
                    ldb       #$FF      ; load the value needed by the following operation
                    cmpa      #$05      ; compare against the limit and set condition flags
                    beq       Code_2818 ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $19       ; private DeskMate service selector
                    stb       Data_0041 ; save the current value in working storage
                    stu       Data_0042 ; save the current value in working storage
                    ldu       DeskMateService ; load the value needed by the following operation
                    leax      >Data_2766,PCR ; form the referenced address without reading memory
                    lbsr      Code_135B ; call the referenced helper routine
                    bcs       Code_2801 ; branch when carry reports an unsigned underflow or error
Code_27D9           cmpb      ,S        ; compare against the limit and set condition flags
                    beq       Code_2801 ; branch when the compared values are equal
                    stb       ,S        ; save the current value in working storage
Code_27DF           leax      Data_0101,PCR ; form the referenced address without reading memory
                    leay      Data_0124,PCR ; form the referenced address without reading memory
                    tst       ,S        ; set condition flags from the current value
                    beq       Code_27F3 ; branch when the compared values are equal
                    leax      Data_0124,PCR ; form the referenced address without reading memory
                    leay      Data_0101,PCR ; form the referenced address without reading memory
Code_27F3           ldd       $01,S     ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    ldd       $03,S     ; load the value needed by the following operation
                    tfr       Y,X       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
Code_2801           lda       Data_0041 ; load the value needed by the following operation
                    cmpa      #$01      ; compare against the limit and set condition flags
                    bne       Code_27AA ; branch when the compared values differ
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "E"                            ; embedded text or resource bytes
                    ldb       #$FF      ; load the value needed by the following operation
                    sty       $03,S     ; save the current value in working storage
                    cmpy      #Data_00FF ; compare against the limit and set condition flags
                    beq       Code_2818 ; branch when the compared values are equal
                    ldb       ,S        ; load the value needed by the following operation
Code_2818           puls      PC,U,Y,X,A ; restore the listed registers from the stack
Data_281A           fcb       $00,$05,$03,$18,$06,$00 ; table, bitmap, or initialized data bytes
                    fcb       $AA,$F0   ; table, bitmap, or initialized data bytes
Data_2822           fcc       "  FILE               "        ; embedded text or resource bytes
                    fcc       "SIZE     DATE     TIM"        ; embedded text or resource bytes
                    fcc       "E"                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
Data_284E           fcc       "================== =="        ; embedded text or resource bytes
                    fcc       "====== ======== ====="        ; embedded text or resource bytes
                    fcc       "==="                          ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
Data_287C           fcc       "Device error"                 ; embedded text or resource bytes
Data_2888           fcb       $00       ; table, bitmap, or initialized data bytes
Data_2889           fcc       "Printing folder "             ; embedded text or resource bytes
                    fcb       $00,$00   ; table, bitmap, or initialized data bytes
Code_289B           pshs      Y,X,D     ; preserve the listed registers on the stack
                    leax      Data_281A,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "?"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0C       ; private DeskMate service selector
                    stx       Data_005C ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Q"                            ; embedded text or resource bytes
                    lbcs      Code_29BC ; take the distant branch when carry reports an error
                    sta       Data_0062 ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "N"                            ; embedded text or resource bytes
                    clr       $0C,X     ; clear the selected byte or register
                    clr       $0D,X     ; clear the selected byte or register
                    lda       #$FF      ; load the value needed by the following operation
                    sta       $1A,X     ; save the current value in working storage
                    lda       Addr_002E ; load the value needed by the following operation
                    adda      #$30      ; add the operand to the running value
                    leax      >Data_2889,PCR ; form the referenced address without reading memory
                    sta       $10,X     ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "?"                            ; embedded text or resource bytes
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    lda       Addr_0033 ; load the value needed by the following operation
                    tst       Code_002C ; set condition flags from the current value
                    beq       Code_28E3 ; branch when the compared values are equal
                    lda       Addr_0034 ; load the value needed by the following operation
Code_28E3           clrb                ; clear the selected byte or register
                    std       Data_0060 ; save the current value in working storage
                    ldb       Data_0062 ; load the value needed by the following operation
                    leax      Data_2822,PCR ; form the referenced address without reading memory
                    ldy       #Code_002C ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "S"                            ; embedded text or resource bytes
                    bcs       Code_2971 ; branch when carry reports an unsigned underflow or error
                    ldb       Data_0062 ; load the value needed by the following operation
                    leax      Data_284E,PCR ; form the referenced address without reading memory
                    ldy       #Addr_002E ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "S"                            ; embedded text or resource bytes
                    bcs       Code_2971 ; branch when carry reports an unsigned underflow or error
Code_2906           lda       Data_0061 ; load the value needed by the following operation
                    leax      $0100,U   ; form the referenced address without reading memory
                    leay      Data_2888,PCR ; form the referenced address without reading memory
                    lbsr      Code_1A15 ; call the referenced helper routine
Code_2913           lda       #$FF      ; load the value needed by the following operation
                    lbsr      Code_18F8 ; call the referenced helper routine
                    lbcs      Code_2983 ; take the distant branch when carry reports an error
                    ldd       #Addr_202D ; load the value needed by the following operation
                    leay      Addr_4095,PCR ; form the referenced address without reading memory
Code_2923           sta       ,Y+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bne       Code_2923 ; branch when the compared values differ
                    leay      Addr_4095,PCR ; form the referenced address without reading memory
Code_292C           incb                ; advance the selected counter
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,Y+       ; store the value and advance the destination pointer
                    bne       Code_292C ; branch when the compared values differ
                    lda       #$20      ; load the value needed by the following operation
                    sta       -$01,Y    ; save the current value in working storage
                    negb                ; form the two's-complement negative value
                    addb      #$13      ; add the operand to the running value
                    leay      B,Y       ; form the referenced address without reading memory
                    clrb                ; clear the selected byte or register
                    leax      $0180,U   ; form the referenced address without reading memory
Code_2941           incb                ; advance the selected counter
                    tst       B,X       ; set condition flags from the current value
                    bne       Code_2941 ; branch when the compared values differ
                    negb                ; form the two's-complement negative value
                    addb      #$08      ; add the operand to the running value
                    leay      B,Y       ; form the referenced address without reading memory
Code_294B           lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,Y+       ; store the value and advance the destination pointer
                    bne       Code_294B ; branch when the compared values differ
                    lda       #$20      ; load the value needed by the following operation
                    sta       -$01,Y    ; save the current value in working storage
                    leax      $06,X     ; form the referenced address without reading memory
Code_2957           lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,Y+       ; store the value and advance the destination pointer
                    bne       Code_2957 ; branch when the compared values differ
                    lda       #$0D      ; load the value needed by the following operation
                    sta       -$01,Y    ; save the current value in working storage
                    ldb       Data_0062 ; load the value needed by the following operation
                    leax      Addr_4095,PCR ; form the referenced address without reading memory
                    ldy       #Addr_002E ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "S"                            ; embedded text or resource bytes
                    bcc       Code_2983 ; branch when carry is clear
Code_2971           pshs      B         ; preserve the listed registers on the stack
                    lda       Data_0062 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "R"                            ; embedded text or resource bytes
                    puls      B         ; restore the listed registers from the stack
                    cmpb      #$02      ; compare against the limit and set condition flags
                    lbeq      Code_29E6 ; take the distant branch when values are equal
                    bra       Code_29BC ; continue at the selected control-flow target
Code_2983           tst       Data_005B ; set condition flags from the current value
                    bpl       Code_29A4 ; branch while the tested value is nonnegative
                    clr       Data_005B ; clear the selected byte or register
                    leax      $0100,U   ; form the referenced address without reading memory
                    pshs      X         ; preserve the listed registers on the stack
Code_298F           tst       ,X+       ; set condition flags from the current value
                    bne       Code_298F ; branch when the compared values differ
                    ldd       #Addr_2E48 ; load the value needed by the following operation
                    std       -$01,X    ; save the current value in working storage
                    ldd       #Addr_4C50 ; load the value needed by the following operation
                    std       $01,X     ; save the current value in working storage
                    clr       $03,X     ; clear the selected byte or register
                    puls      X         ; restore the listed registers from the stack
                    lbra      Code_2913 ; continue at the distant control-flow target
Code_29A4           inc       Data_0061 ; advance the selected counter
                    dec       Data_0060 ; decrement the selected counter
                    lbne      Code_2906 ; take the distant branch when values differ
                    lda       #$0D      ; load the value needed by the following operation
                    ldb       Data_0062 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "T"                            ; embedded text or resource bytes
                    lda       Data_0062 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "R"                            ; embedded text or resource bytes
                    bra       Code_29E6 ; continue at the selected control-flow target
Code_29BC           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "?"                            ; embedded text or resource bytes
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      Data_287C,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    ldd       Data_005C ; load the value needed by the following operation
                    adda      #$03      ; add the operand to the running value
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      Data_1B67,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    ldb       #$80      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1C       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "E"                            ; embedded text or resource bytes
Code_29E6           leax      Data_281A,PCR ; form the referenced address without reading memory
                    lbsr      Code_16B2 ; call the referenced helper routine
                    puls      PC,Y,X,D  ; restore the listed registers from the stack
                    fcb       $00,$03,$03,$1A,$07,$00 ; table, bitmap, or initialized data bytes
                    fcb       $AA,$E0   ; table, bitmap, or initialized data bytes
                    fcc       "Initialize:"                  ; embedded text or resource bytes
                    fcb       $00,$08,$08 ; table, bitmap, or initialized data bytes
                    fcc       "Drive 0"                      ; embedded text or resource bytes
                    fcb       $08,$08,$08,$08 ; table, bitmap, or initialized data bytes
                    fcc       "Drive 1"                      ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "Loading disk init. ut"        ; embedded text or resource bytes
                    fcc       "ilities"                      ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "DMDSKINI"                     ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $16       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C9,$17   ; table, bitmap, or initialized data bytes
                    fcc       "b3"                           ; embedded text or resource bytes
                    fcb       $8D,$FF,$A7,$EF,$84 ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $8D,$FF,$A9,$EF,$02,$CC ; table, bitmap, or initialized data bytes
                    fcb       $01,$0A,$ED,$04 ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $8D,$FF,$BF,$EF,$06 ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $8D,$FF,$D6,$EF,$08,$CC ; table, bitmap, or initialized data bytes
                    fcb       $04,$08,$ED,$0A,$CC,$04 ; table, bitmap, or initialized data bytes
                    fcb       $14,$ED,$0C ; table, bitmap, or initialized data bytes
                    fcc       "O_"                           ; embedded text or resource bytes
                    fcb       $ED,$0E,$DE,$00,$17,$00 ; table, bitmap, or initialized data bytes
                    fcb       $8B       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $96,$00,$02,$04,$1D,$07 ; table, bitmap, or initialized data bytes
                    fcb       $00,$AA,$E0 ; table, bitmap, or initialized data bytes
                    fcc       "Backup:"                      ; embedded text or resource bytes
                    fcb       $00,$08,$08 ; table, bitmap, or initialized data bytes
                    fcc       "D0 to D0"                     ; embedded text or resource bytes
                    fcb       $08,$08,$08,$08,$02 ; table, bitmap, or initialized data bytes
                    fcc       "D0 to D1"                     ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "Loading disk backup u"        ; embedded text or resource bytes
                    fcc       "tilities"                     ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "DMBACKUP"                     ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $16       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C9,$17   ; table, bitmap, or initialized data bytes
                    fcc       "b3"                           ; embedded text or resource bytes
                    fcb       $8D,$FF,$A7,$EF,$84 ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $8D,$FF,$A9,$EF,$02,$CC ; table, bitmap, or initialized data bytes
                    fcb       $01,$0B,$ED,$04 ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $8D,$FF,$BE,$EF,$06 ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $8D,$FF,$D6,$EF,$08,$CC ; table, bitmap, or initialized data bytes
                    fcb       $05,$06,$ED,$0A,$CC,$05 ; table, bitmap, or initialized data bytes
                    fcb       $14,$ED,$0C,$86,$FF,$C6 ; table, bitmap, or initialized data bytes
                    fcb       $FF,$ED,$0E,$DE,$00,$17 ; table, bitmap, or initialized data bytes
                    fcb       $00,$02   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       "46"                           ; embedded text or resource bytes
                    fcb       $AE,$84,$17,$D5,$0D ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
                    fcb       $17,$D5,$09 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $8E,$00,$00,$9F ; table, bitmap, or initialized data bytes
                    fcc       "[O_"                          ; embedded text or resource bytes
                    fcb       $10,$AE   ; table, bitmap, or initialized data bytes
                    fcc       "b"                            ; embedded text or resource bytes
                    fcb       $AE,$22,$17,$D4,$F9,$0A ; table, bitmap, or initialized data bytes
                    fcb       $DC       ; table, bitmap, or initialized data bytes
                    fcc       "["                            ; embedded text or resource bytes
                    fcb       $AB       ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $17,$FB   ; table, bitmap, or initialized data bytes
                    fcc       "mO_"                          ; embedded text or resource bytes
                    fcb       $17,$D4,$EC,$0A,$DC ; table, bitmap, or initialized data bytes
                    fcc       "["                            ; embedded text or resource bytes
                    fcb       $8B,$03,$17,$FB ; table, bitmap, or initialized data bytes
                    fcc       "`"                            ; embedded text or resource bytes
                    fcb       $86,$01   ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $17,$D4,$DE,$0A,$DC ; table, bitmap, or initialized data bytes
                    fcc       "["                            ; embedded text or resource bytes
                    fcb       $8B,$04,$17,$FB ; table, bitmap, or initialized data bytes
                    fcc       "R"                            ; embedded text or resource bytes
                    fcb       $86,$02   ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $17,$D4,$D0,$0A,$EC ; table, bitmap, or initialized data bytes
                    fcc       "*LHHHL"                       ; embedded text or resource bytes
                    fcb       $1F,$01,$EB ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $1F,$02   ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $17,$FC,$1E,$17,$D4,$BB ; table, bitmap, or initialized data bytes
                    fcb       $17,$C1,$FF ; table, bitmap, or initialized data bytes
                    fcc       "'^"                           ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "A'"                           ; embedded text or resource bytes
                    fcb       $0E,$D7   ; table, bitmap, or initialized data bytes
                    fcc       "b"                            ; embedded text or resource bytes
                    fcb       $17,$D4,$AD ; table, bitmap, or initialized data bytes
                    fcc       "E"                            ; embedded text or resource bytes
                    fcb       $10,$8C,$00,$04 ; table, bitmap, or initialized data bytes
                    fcc       "$N"                           ; embedded text or resource bytes
                    fcb       $D6       ; table, bitmap, or initialized data bytes
                    fcc       "b"                            ; embedded text or resource bytes
                    fcb       $CB       ; table, bitmap, or initialized data bytes
                    fcc       "01"                           ; embedded text or resource bytes
                    fcb       $C9,$01,$00,$E7,$A4,$86 ; table, bitmap, or initialized data bytes
                    fcb       $0D,$A7   ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $17,$D4,$95 ; table, bitmap, or initialized data bytes
                    fcc       "?O_"                          ; embedded text or resource bytes
                    fcb       $10,$AE   ; table, bitmap, or initialized data bytes
                    fcc       "b"                            ; embedded text or resource bytes
                    fcb       $AE,$26,$17,$D4,$8A,$0A ; table, bitmap, or initialized data bytes
                    fcb       $AE       ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $9F       ; table, bitmap, or initialized data bytes
                    fcc       "["                            ; embedded text or resource bytes
                    fcb       $17,$D4,$82 ; table, bitmap, or initialized data bytes
                    fcc       "N0"                           ; embedded text or resource bytes
                    fcb       $C9,$01,$00,$AF,$A8,$16 ; table, bitmap, or initialized data bytes
                    fcb       $8E,$FF,$FB,$17,$D4 ; table, bitmap, or initialized data bytes
                    fcc       "tO"                           ; embedded text or resource bytes
                    fcb       $AE       ; table, bitmap, or initialized data bytes
                    fcc       "bm"                           ; embedded text or resource bytes
                    fcb       $0E,$26,$08,$9E ; table, bitmap, or initialized data bytes
                    fcc       "["                            ; embedded text or resource bytes
                    fcb       $17,$D4   ; table, bitmap, or initialized data bytes
                    fcc       "hV "                          ; embedded text or resource bytes
                    fcb       $09,$17,$D9,$DC,$9E ; table, bitmap, or initialized data bytes
                    fcc       "["                            ; embedded text or resource bytes
                    fcb       $17,$D4   ; table, bitmap, or initialized data bytes
                    fcc       "]U"                           ; embedded text or resource bytes
                    fcb       $17,$D4   ; table, bitmap, or initialized data bytes
                    fcc       "YP"                           ; embedded text or resource bytes
                    fcb       $AE       ; table, bitmap, or initialized data bytes
                    fcc       "b"                            ; embedded text or resource bytes
                    fcb       $AE,$84,$17,$EA,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $B6,$00,$03,$05,$1A,$08 ; table, bitmap, or initialized data bytes
                    fcb       $00,$AA,$E0 ; table, bitmap, or initialized data bytes
                    fcc       "Swap execution direct"        ; embedded text or resource bytes
                    fcc       "ory to:"                      ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "/D0/CMDS"                     ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "Directory not found"          ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "460"                          ; embedded text or resource bytes
                    fcb       $8D,$FF,$B8,$17,$D4,$04 ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
                    fcb       $17,$D4,$00 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $8E,$00,$00,$9F ; table, bitmap, or initialized data bytes
                    fcc       "\O_0"                         ; embedded text or resource bytes
                    fcb       $8D,$FF,$AD,$17,$D3,$F1 ; table, bitmap, or initialized data bytes
                    fcb       $0A,$DC   ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $8B,$04,$17,$FA ; table, bitmap, or initialized data bytes
                    fcc       "e"                            ; embedded text or resource bytes
                    fcb       $86,$01   ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $17,$D3,$E3,$0A,$DC ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $8B,$05,$17,$FA ; table, bitmap, or initialized data bytes
                    fcc       "W"                            ; embedded text or resource bytes
                    fcb       $86,$02   ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $17,$D3,$D5,$0A,$C6,$1F ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C9,$01   ; table, bitmap, or initialized data bytes
                    fcc       "z1"                           ; embedded text or resource bytes
                    fcb       $8D,$FF,$A0,$A6,$A0,$A7 ; table, bitmap, or initialized data bytes
                    fcb       $80,$26,$FA,$86 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $A7,$1F,$A7,$80 ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $26,$FB,$E7,$84,$DC ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $C3,$01,$02,$17,$FA ; table, bitmap, or initialized data bytes
                    fcc       "-_"                           ; embedded text or resource bytes
                    fcb       $86,$94   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C9,$01   ; table, bitmap, or initialized data bytes
                    fcc       "z"                            ; embedded text or resource bytes
                    fcb       $17,$D3,$A7,$16,$17,$05 ; table, bitmap, or initialized data bytes
                    fcb       $13,$17,$D3,$A0 ; table, bitmap, or initialized data bytes
                    fcc       "3M'"                          ; embedded text or resource bytes
                    fcb       $0E,$81,$05,$10 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $00,$84,$81,$0D ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $14,$86,$14 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $E0,$17,$D3,$8B ; table, bitmap, or initialized data bytes
                    fcc       "E"                            ; embedded text or resource bytes
                    fcb       $10,$8C,$00,$05,$10 ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "p0"                           ; embedded text or resource bytes
                    fcb       $C9,$01   ; table, bitmap, or initialized data bytes
                    fcc       "z"                            ; embedded text or resource bytes
                    fcb       $A6,$80   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $04,$81   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $26,$F8,$86,$0D,$A7,$1F ; table, bitmap, or initialized data bytes
                    fcb       $86,$04   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C9,$01   ; table, bitmap, or initialized data bytes
                    fcc       "z"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       "%/"                           ; embedded text or resource bytes
                    fcb       $17,$D3   ; table, bitmap, or initialized data bytes
                    fcc       "dN0"                          ; embedded text or resource bytes
                    fcb       $88,$26   ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $C9,$01   ; table, bitmap, or initialized data bytes
                    fcc       "z"                            ; embedded text or resource bytes
                    fcb       $E6,$A0,$E7,$80,$C1,$0D ; table, bitmap, or initialized data bytes
                    fcb       $26,$F8   ; table, bitmap, or initialized data bytes
                    fcc       "O_"                           ; embedded text or resource bytes
                    fcb       $DD       ; table, bitmap, or initialized data bytes
                    fcc       "7"                            ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "6"                            ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $D6       ; table, bitmap, or initialized data bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       "/"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $17,$DC,$DF,$D7 ; table, bitmap, or initialized data bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       ",'+"                          ; embedded text or resource bytes
                    fcb       $17,$DE   ; table, bitmap, or initialized data bytes
                    fcc       "[ "                           ; embedded text or resource bytes
                    fcb       $26,$17,$F5 ; table, bitmap, or initialized data bytes
                    fcc       "FO_0"                         ; embedded text or resource bytes
                    fcb       $8D,$FF,$0E,$17,$D3 ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $0A,$DC   ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $8B,$05,$17,$F9,$A0 ; table, bitmap, or initialized data bytes
                    fcc       "O_0"                          ; embedded text or resource bytes
                    fcb       $8D,$EE   ; table, bitmap, or initialized data bytes
                    fcc       "r"                            ; embedded text or resource bytes
                    fcb       $17,$D3,$1B,$0A,$17,$D3 ; table, bitmap, or initialized data bytes
                    fcb       $17,$1C,$17,$D3,$13 ; table, bitmap, or initialized data bytes
                    fcc       "E0"                           ; embedded text or resource bytes
                    fcb       $C8       ; table, bitmap, or initialized data bytes
                    fcc       "Ro"                           ; embedded text or resource bytes
                    fcb       $84,$17,$D3,$0A,$13 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FE,$B6,$17,$E9,$A1 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $B6       ; table, bitmap, or initialized data bytes
Code_2D13           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    lda       #$55      ; load the value needed by the following operation
                    ldb       Addr_002E ; load the value needed by the following operation
                    lbsr      Code_0894 ; call the referenced helper routine
                    ldx       #Addr_6041 ; load the value needed by the following operation
                    ldy       #Data_010C ; load the value needed by the following operation
                    leau      Data_2E1D,PCR ; form the referenced address without reading memory
                    tst       Code_002C ; set condition flags from the current value
                    bne       Code_2D34 ; branch when the compared values differ
                    ldx       #Code_2041 ; load the value needed by the following operation
                    leau      Data_2E30,PCR ; form the referenced address without reading memory
Code_2D34           lda       #$99      ; load the value needed by the following operation
                    ldb       #$34      ; load the value needed by the following operation
                    stu       Data_0061 ; save the current value in working storage
                    ldu       DeskMateService ; load the value needed by the following operation
Code_2D3C           lda       #$99      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0E       ; private DeskMate service selector
                    decb                ; decrement the selected counter
                    beq       Code_2D61 ; branch when the compared values are equal
                    lda       #$66      ; load the value needed by the following operation
                    pshs      D         ; preserve the listed registers on the stack
                    tfr       X,D       ; copy the source register into the destination register
                    inca                ; advance the selected counter
                    tfr       D,X       ; copy the source register into the destination register
                    puls      D         ; restore the listed registers from the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0E       ; private DeskMate service selector
                    decb                ; decrement the selected counter
                    pshs      D         ; preserve the listed registers on the stack
                    tfr       X,D       ; copy the source register into the destination register
                    inca                ; advance the selected counter
                    tfr       D,X       ; copy the source register into the destination register
                    puls      D         ; restore the listed registers from the stack
                    tstb                ; set condition flags from the current value
                    bne       Code_2D3C ; branch when the compared values differ
Code_2D61           lda       #$AA      ; load the value needed by the following operation
                    leax      $52,U     ; form the referenced address without reading memory
                    sta       ,X        ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $13       ; private DeskMate service selector
                    ldd       Data_0044 ; load the value needed by the following operation
                    subd      $03,X     ; subtract the operand from the running value
                    std       Data_0048 ; save the current value in working storage
                    ldd       Data_0046 ; load the value needed by the following operation
                    subd      $01,X     ; subtract the operand from the running value
                    std       Data_004A ; save the current value in working storage
                    ldd       $07,X     ; load the value needed by the following operation
                    subd      $03,X     ; subtract the operand from the running value
                    std       Data_004C ; save the current value in working storage
                    ldd       $05,X     ; load the value needed by the following operation
                    subd      $01,X     ; subtract the operand from the running value
                    std       Data_004E ; save the current value in working storage
                    lda       #$AA      ; load the value needed by the following operation
                    sta       ,X        ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    leay      Addr_4095,PCR ; form the referenced address without reading memory
                    lbsr      Code_2F14 ; call the referenced helper routine
Code_2D90           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $19       ; private DeskMate service selector
                    stb       Data_0041 ; save the current value in working storage
                    stu       Data_0042 ; save the current value in working storage
                    ldu       DeskMateService ; load the value needed by the following operation
                    cmpb      #$04      ; compare against the limit and set condition flags
                    beq       Code_2DD3 ; branch when the compared values are equal
                    tfr       Y,D       ; copy the source register into the destination register
                    lda       #$03      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    tfr       D,Y       ; copy the source register into the destination register
                    tfr       X,D       ; copy the source register into the destination register
                    incb                ; advance the selected counter
                    lda       #$0A      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    tfr       D,X       ; copy the source register into the destination register
                    cmpx      Data_0046 ; compare against the limit and set condition flags
                    bne       Code_2DB6 ; branch when the compared values differ
                    cmpy      Data_0044 ; compare against the limit and set condition flags
                    beq       Code_2D90 ; branch when the compared values are equal
Code_2DB6           stx       Data_0046 ; save the current value in working storage
                    sty       Data_0044 ; save the current value in working storage
                    lda       #$FF      ; load the value needed by the following operation
                    leax      $52,U     ; form the referenced address without reading memory
                    leay      Addr_4095,PCR ; form the referenced address without reading memory
                    sync                ; wait for an interrupt request
                    lbsr      Code_2F14 ; call the referenced helper routine
                    lbsr      Code_2E43 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    lbsr      Code_2F14 ; call the referenced helper routine
                    sync                ; wait for an interrupt request
                    sync                ; wait for an interrupt request
                    bra       Code_2D90 ; continue at the selected control-flow target
Code_2DD3           lda       #$FF      ; load the value needed by the following operation
                    leax      $52,U     ; form the referenced address without reading memory
                    leay      Addr_4095,PCR ; form the referenced address without reading memory
                    lbsr      Code_2F14 ; call the referenced helper routine
                    lda       #$FF      ; load the value needed by the following operation
                    lbsr      Code_0CAD ; call the referenced helper routine
                    lbsr      Code_0816 ; call the referenced helper routine
                    lbsr      Code_0774 ; call the referenced helper routine
                    tst       Code_002C ; set condition flags from the current value
                    bne       Code_2DF3 ; branch when the compared values differ
                    lbsr      Code_0A64 ; call the referenced helper routine
                    bra       Code_2DF6 ; continue at the selected control-flow target
Code_2DF3           lbsr      Code_0BFC ; call the referenced helper routine
Code_2DF6           lda       #$FF      ; load the value needed by the following operation
                    lbsr      Code_0CAD ; call the referenced helper routine
                    lda       #$55      ; load the value needed by the following operation
                    ldb       Addr_002E ; load the value needed by the following operation
                    lbsr      Code_0894 ; call the referenced helper routine
                    ldx       Data_0061 ; load the value needed by the following operation
                    lbsr      Code_135B ; call the referenced helper routine
                    lbcs      Code_0CFA ; take the distant branch when carry reports an error
                    tstb                ; set condition flags from the current value
                    lbeq      Code_0DC4 ; take the distant branch when values are equal
                    clr       Data_003E ; clear the selected byte or register
                    cmpb      Addr_002E ; compare against the limit and set condition flags
                    lbne      Code_0E43 ; take the distant branch when values differ
                    dec       Data_003E ; decrement the selected counter
                    lbra      Code_0E43 ; continue at the distant control-flow target
Data_2E1D           fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "AO"                           ; embedded text or resource bytes
                    fcb       $03,$06,$00,$01 ; table, bitmap, or initialized data bytes
                    fcc       "AO"                           ; embedded text or resource bytes
                    fcb       $07,$0A,$00,$02 ; table, bitmap, or initialized data bytes
                    fcc       "AO"                           ; embedded text or resource bytes
                    fcb       $13,$17,$00,$00 ; table, bitmap, or initialized data bytes
Data_2E30           fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "AO"                           ; embedded text or resource bytes
                    fcb       $0B,$0E,$00,$03 ; table, bitmap, or initialized data bytes
                    fcc       "AO"                           ; embedded text or resource bytes
                    fcb       $0F,$12,$00,$04 ; table, bitmap, or initialized data bytes
                    fcc       "AO"                           ; embedded text or resource bytes
                    fcb       $13,$17,$00,$00 ; table, bitmap, or initialized data bytes
Code_2E43           pshs      D         ; preserve the listed registers on the stack
                    ldd       Data_0046 ; load the value needed by the following operation
                    subd      Data_004A ; subtract the operand from the running value
                    bcc       Code_2E4D ; branch when carry is clear
                    ldd       Data_0046 ; load the value needed by the following operation
Code_2E4D           std       $01,X     ; save the current value in working storage
                    addd      Data_004E ; add the operand to the running value
                    cmpd      #Data_0258 ; compare against the limit and set condition flags
                    bls       Code_2E61 ; branch when the unsigned value is at or below the limit
                    ldd       #Data_0258 ; load the value needed by the following operation
                    subd      Data_004E ; subtract the operand from the running value
                    std       $01,X     ; save the current value in working storage
                    ldd       #Data_0258 ; load the value needed by the following operation
Code_2E61           std       $05,X     ; save the current value in working storage
                    ldd       Data_0044 ; load the value needed by the following operation
                    subd      Data_0048 ; subtract the operand from the running value
                    bcc       Code_2E6B ; branch when carry is clear
                    ldd       Data_0044 ; load the value needed by the following operation
Code_2E6B           std       $03,X     ; save the current value in working storage
                    addd      Data_004C ; add the operand to the running value
                    cmpd      #Data_00BF ; compare against the limit and set condition flags
                    bls       Code_2E7F ; branch when the unsigned value is at or below the limit
                    ldd       #Data_00BF ; load the value needed by the following operation
                    subd      Data_004C ; subtract the operand from the running value
                    std       $03,X     ; save the current value in working storage
                    ldd       #Data_00BF ; load the value needed by the following operation
Code_2E7F           std       $07,X     ; save the current value in working storage
                    puls      PC,D      ; restore the listed registers from the stack
Code_2E83           pshs      U,Y,X,D   ; preserve the listed registers on the stack
                    lda       $05,S     ; load the value needed by the following operation
                    ldb       #$50      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    pshs      D         ; preserve the listed registers on the stack
                    tfr       U,D       ; copy the source register into the destination register
                    lsra                ; shift right and expose the low bit through carry
                    rorb                ; rotate right through carry
                    lsra                ; shift right and expose the low bit through carry
                    rorb                ; rotate right through carry
                    lsra                ; shift right and expose the low bit through carry
                    rorb                ; rotate right through carry
                    addd      ,S        ; add the operand to the running value
                    std       Data_005B ; save the current value in working storage
                    tfr       X,D       ; copy the source register into the destination register
                    lsra                ; shift right and expose the low bit through carry
                    rorb                ; rotate right through carry
                    lsra                ; shift right and expose the low bit through carry
                    rorb                ; rotate right through carry
                    lsra                ; shift right and expose the low bit through carry
                    rorb                ; rotate right through carry
                    addd      ,S++      ; add the operand to the running value
                    tfr       D,X       ; copy the source register into the destination register
                    ldd       Data_003F ; load the value needed by the following operation
                    leax      D,X       ; form the referenced address without reading memory
                    addd      Data_005B ; add the operand to the running value
                    std       Data_005B ; save the current value in working storage
                    ldy       Data_005D ; load the value needed by the following operation
                    tst       Data_005F ; set condition flags from the current value
                    beq       Code_2EBD ; branch when the compared values are equal
Code_2EB3           lda       ,Y+       ; fetch the next value and advance the source pointer
                    sta       ,X+       ; store the value and advance the destination pointer
                    cmpx      Data_005B ; compare against the limit and set condition flags
                    bls       Code_2EB3 ; branch when the unsigned value is at or below the limit
                    bra       Code_2EC5 ; continue at the selected control-flow target
Code_2EBD           lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,Y+       ; store the value and advance the destination pointer
                    cmpx      Data_005B ; compare against the limit and set condition flags
                    bls       Code_2EBD ; branch when the unsigned value is at or below the limit
Code_2EC5           sty       Data_005D ; save the current value in working storage
                    puls      PC,U,Y,X,D ; restore the listed registers from the stack
Code_2ECA           pshs      U,Y,X,D   ; preserve the listed registers on the stack
                    tfr       X,D       ; copy the source register into the destination register
                    lsra                ; shift right and expose the low bit through carry
                    rorb                ; rotate right through carry
                    lsra                ; shift right and expose the low bit through carry
                    rorb                ; rotate right through carry
                    lsra                ; shift right and expose the low bit through carry
                    rorb                ; rotate right through carry
                    pshs      D         ; preserve the listed registers on the stack
                    tfr       U,D       ; copy the source register into the destination register
                    lda       #$50      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    addd      ,S        ; add the operand to the running value
                    std       Data_005B ; save the current value in working storage
                    tfr       Y,D       ; copy the source register into the destination register
                    lda       #$50      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    addd      ,S++      ; add the operand to the running value
                    tfr       D,X       ; copy the source register into the destination register
                    ldd       Data_003F ; load the value needed by the following operation
                    leax      D,X       ; form the referenced address without reading memory
                    addd      Data_005B ; add the operand to the running value
                    std       Data_005B ; save the current value in working storage
                    ldy       Data_005D ; load the value needed by the following operation
                    tst       Data_005F ; set condition flags from the current value
                    beq       Code_2F04 ; branch when the compared values are equal
Code_2EF7           lda       ,Y+       ; fetch the next value and advance the source pointer
                    sta       ,X        ; save the current value in working storage
                    leax      $50,X     ; form the referenced address without reading memory
                    cmpx      Data_005B ; compare against the limit and set condition flags
                    bls       Code_2EF7 ; branch when the unsigned value is at or below the limit
                    bra       Code_2F0F ; continue at the selected control-flow target
Code_2F04           lda       ,X        ; load the value needed by the following operation
                    sta       ,Y+       ; store the value and advance the destination pointer
                    leax      $50,X     ; form the referenced address without reading memory
                    cmpx      Data_005B ; compare against the limit and set condition flags
                    bls       Code_2F04 ; branch when the unsigned value is at or below the limit
Code_2F0F           sty       Data_005D ; save the current value in working storage
                    puls      PC,U,Y,X,D ; restore the listed registers from the stack
Code_2F14           sta       Data_005F ; save the current value in working storage
                    sty       Data_005D ; save the current value in working storage
                    pshs      U,Y,X,B   ; preserve the listed registers on the stack
                    ldb       ,X+       ; fetch the next value and advance the source pointer
                    ldy       ,X++      ; fetch the next value and advance the source pointer
                    ldu       ,X++      ; fetch the next value and advance the source pointer
                    pshs      U,Y       ; preserve the listed registers on the stack
                    ldy       ,X++      ; fetch the next value and advance the source pointer
                    ldu       ,X        ; load the value needed by the following operation
                    pshs      U,Y       ; preserve the listed registers on the stack
                    ldx       $04,S     ; load the value needed by the following operation
                    ldy       $02,S     ; load the value needed by the following operation
                    ldu       ,S        ; load the value needed by the following operation
                    lbsr      Code_2E83 ; call the referenced helper routine
                    ldy       $06,S     ; load the value needed by the following operation
                    lbsr      Code_2E83 ; call the referenced helper routine
                    ldx       $04,S     ; load the value needed by the following operation
                    ldu       $02,S     ; load the value needed by the following operation
                    lbsr      Code_2ECA ; call the referenced helper routine
                    ldx       ,S        ; load the value needed by the following operation
                    lbsr      Code_2ECA ; call the referenced helper routine
                    leas      $08,S     ; form the referenced address without reading memory
                    ldx       $01,S     ; load the value needed by the following operation
                    tst       Data_005F ; set condition flags from the current value
                    bne       Code_2F53 ; branch when the compared values differ
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $13       ; private DeskMate service selector
Code_2F53           puls      PC,U,Y,X,B ; restore the listed registers from the stack
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
Code_2FC7           pshs      D         ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "/"                            ; embedded text or resource bytes
                    tfr       A,DP      ; copy the source register into the destination register
                    clrb                ; clear the selected byte or register
                    tfr       D,U       ; copy the source register into the destination register
                    puls      PC,D      ; restore the listed registers from the stack
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $1F,$02,$D6,$0F,$1F,$01 ; table, bitmap, or initialized data bytes
                    fcb       $17,$D0   ; table, bitmap, or initialized data bytes
                    fcc       "5D9"                          ; embedded text or resource bytes
                    fcb       $9E,$0A   ; table, bitmap, or initialized data bytes
                    fcc       "H"                            ; embedded text or resource bytes
                    fcb       $AE,$86   ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $E6,$80,$C4,$80,$17,$D0 ; table, bitmap, or initialized data bytes
                    fcb       $26,$0A   ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $D6,$14,$8D,$E1 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $D6,$0D,$1F,$02,$17,$D0 ; table, bitmap, or initialized data bytes
                    fcb       $18       ; table, bitmap, or initialized data bytes
                    fcc       "$9"                           ; embedded text or resource bytes
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
                    fcb       $8D,$03   ; table, bitmap, or initialized data bytes
                    fcc       "i"                            ; embedded text or resource bytes
                    fcb       $0D,$18   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $03,$8D   ; table, bitmap, or initialized data bytes
                    fcc       "2 "                           ; embedded text or resource bytes
                    fcb       $04,$17,$CF,$F8 ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $D6,$1D   ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $8D,$17,$D6,$11,$D1,$12 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $0C       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$03   ; table, bitmap, or initialized data bytes
                    fcc       "R"                            ; embedded text or resource bytes
                    fcb       $0D,$19   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
Data_3030           fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $15,$17,$CF,$DD ; table, bitmap, or initialized data bytes
                    fcc       "A9O"                          ; embedded text or resource bytes
                    fcb       $1F,$02,$D6,$0D ; table, bitmap, or initialized data bytes
                    fcc       "T"                            ; embedded text or resource bytes
                    fcb       $DB,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $1F,$01,$17,$CF,$CD ; table, bitmap, or initialized data bytes
                    fcc       "D94"                          ; embedded text or resource bytes
                    fcb       $10,$17,$CF,$C6,$1F ; table, bitmap, or initialized data bytes
                    fcc       "4 0"                          ; embedded text or resource bytes
                    fcb       $8D,$02,$A3,$17,$CF,$BC ; table, bitmap, or initialized data bytes
                    fcb       $06,$AE   ; table, bitmap, or initialized data bytes
                    fcc       "b"                            ; embedded text or resource bytes
                    fcb       $17,$CF,$B6 ; table, bitmap, or initialized data bytes
                    fcc       "F50"                          ; embedded text or resource bytes
                    fcb       $17,$CF,$B0,$03 ; table, bitmap, or initialized data bytes
                    fcc       "94~"                          ; embedded text or resource bytes
                    fcb       $17,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "]"                            ; embedded text or resource bytes
                    fcb       $0F,$18,$0F,$19,$0F ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $C6,$80,$17,$CF,$9E,$1D ; table, bitmap, or initialized data bytes
                    fcb       $97,$1C,$17,$CF,$98,$18 ; table, bitmap, or initialized data bytes
                    fcc       "M"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $17,$CF,$8F ; table, bitmap, or initialized data bytes
                    fcc       "E"                            ; embedded text or resource bytes
                    fcb       $D7       ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $9F       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $10,$9F   ; table, bitmap, or initialized data bytes
                    fcc       "6]'"                          ; embedded text or resource bytes
                    fcb       $10,$C1,$01,$26,$EE,$86 ; table, bitmap, or initialized data bytes
                    fcb       $0D,$10,$8C,$00,$FF,$26 ; table, bitmap, or initialized data bytes
                    fcb       $02,$86,$05,$97,$1C,$1F ; table, bitmap, or initialized data bytes
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
                    fcc       "/"                            ; embedded text or resource bytes
                    fcb       $A6,$E0,$D6,$1B,$D7,$14 ; table, bitmap, or initialized data bytes
                    fcb       $97,$13,$17,$FF ; table, bitmap, or initialized data bytes
                    fcc       "$ 2"                          ; embedded text or resource bytes
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
                    fcb       $FF,$97,$1A,$17,$FE,$FB ; table, bitmap, or initialized data bytes
                    fcb       $D6,$1C,$96,$13 ; table, bitmap, or initialized data bytes
                    fcc       "2b5"                          ; embedded text or resource bytes
                    fcb       $F8,$96,$1D ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $91,$1B,$26 ; table, bitmap, or initialized data bytes
                    fcc       "+"                            ; embedded text or resource bytes
                    fcb       $0C,$19,$D6,$11,$D1,$12 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $E9,$0C,$11,$17,$FE,$D1 ; table, bitmap, or initialized data bytes
                    fcb       $0C,$13,$8D ; table, bitmap, or initialized data bytes
                    fcc       "G"                            ; embedded text or resource bytes
                    fcb       $17,$CE,$EE,$26,$D6,$1D ; table, bitmap, or initialized data bytes
                    fcb       $17,$FE,$A9,$17,$CE,$E5 ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $96,$11,$9B,$0C ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $17,$FE,$A9,$17,$FE,$B5 ; table, bitmap, or initialized data bytes
Data_313A           fcc       " "                            ; embedded text or resource bytes
                    fcb       $BF,$96,$10 ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $91,$1B,$26,$BC,$0C,$18 ; table, bitmap, or initialized data bytes
                    fcb       $0D,$11   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $B9,$17,$FE,$A3,$0A,$11 ; table, bitmap, or initialized data bytes
                    fcb       $0A,$13,$8D,$17,$17,$CE ; table, bitmap, or initialized data bytes
                    fcb       $BE       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $D6,$10,$17,$FE ; table, bitmap, or initialized data bytes
                    fcc       "y"                            ; embedded text or resource bytes
                    fcb       $17,$CE,$B5 ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $96,$11,$17,$FE ; table, bitmap, or initialized data bytes
                    fcc       "|"                            ; embedded text or resource bytes
                    fcb       $17,$FE,$88 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $92,$D6,$10,$17,$FE ; table, bitmap, or initialized data bytes
                    fcc       "f"                            ; embedded text or resource bytes
                    fcb       $17,$CE,$A2,$0C,$1F,$10 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $1F,$01   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $04,$1F,$02,$CE ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $00,$DC,$0C ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
Code_3183           pshs      U,Y,X,DP,D ; preserve the listed registers on the stack
                    lbsr      Code_2FC7 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "9"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "0"                            ; embedded text or resource bytes
                    sta       Addr_0026 ; save the current value in working storage
                    ldd       ,S        ; load the value needed by the following operation
                    stb       Addr_001F ; save the current value in working storage
                    tsta                ; set condition flags from the current value
                    bpl       Code_31BA ; branch while the tested value is nonnegative
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
Code_31B7           lbsr      Code_32B8 ; call the referenced helper routine
Code_31BA           lbsr      Code_32D3 ; call the referenced helper routine
Code_31BD           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $18       ; private DeskMate service selector
                    anda      #$80      ; mask off unwanted bits
                    ora       #$03      ; set the selected flag bits
                    tfr       A,B       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1C       ; private DeskMate service selector
                    tstb                ; set condition flags from the current value
                    bpl       Code_31D2 ; branch while the tested value is nonnegative
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $16       ; private DeskMate service selector
Code_31D2           sta       Addr_0025 ; save the current value in working storage
                    ldx       Addr_0021 ; load the value needed by the following operation
                    ldb       Addr_001F ; load the value needed by the following operation
                    leay      B,X       ; form the referenced address without reading memory
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bcs       Code_31F6 ; branch when carry reports an unsigned underflow or error
                    cmpa      #$7E      ; compare against the limit and set condition flags
                    bhi       Code_31F6 ; branch when the unsigned value is above the limit
                    tst       Addr_001E ; set condition flags from the current value
                    lbne      Code_3298 ; take the distant branch when values differ
Code_31E8           sta       ,Y        ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "C"                            ; embedded text or resource bytes
Code_31EE           tst       $01,Y     ; set condition flags from the current value
                    beq       Code_31BD ; branch when the compared values are equal
                    inc       Addr_001F ; advance the selected counter
                    bra       Code_31BA ; continue at the selected control-flow target
Code_31F6           cmpa      #$88      ; compare against the limit and set condition flags
                    beq       Code_3226 ; branch when the compared values are equal
                    cmpa      #$08      ; compare against the limit and set condition flags
                    beq       Code_324B ; branch when the compared values are equal
                    cmpa      #$09      ; compare against the limit and set condition flags
                    beq       Code_31EE ; branch when the compared values are equal
                    cmpa      #$C9      ; compare against the limit and set condition flags
                    beq       Code_326F ; branch when the compared values are equal
                    cmpa      #$E9      ; compare against the limit and set condition flags
                    beq       Code_326F ; branch when the compared values are equal
                    cmpa      #$0C      ; compare against the limit and set condition flags
                    beq       Code_3265 ; branch when the compared values are equal
                    cmpa      #$0A      ; compare against the limit and set condition flags
                    beq       Code_3253 ; branch when the compared values are equal
                    ldb       Addr_001F ; load the value needed by the following operation
                    lda       Addr_0026 ; load the value needed by the following operation
                    beq       Code_321C ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "3"                            ; embedded text or resource bytes
Code_321C           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       ":"                            ; embedded text or resource bytes
                    lda       Addr_0025 ; load the value needed by the following operation
                    leas      $02,S     ; form the referenced address without reading memory
                    puls      PC,U,Y,X,DP ; restore the listed registers from the stack
Code_3226           tst       Addr_001E ; set condition flags from the current value
                    bne       Code_327D ; branch when the compared values differ
                    tstb                ; set condition flags from the current value
                    beq       Code_3240 ; branch when the compared values are equal
                    tst       $01,Y     ; set condition flags from the current value
                    bne       Code_3237 ; branch when the compared values differ
                    lda       #$20      ; load the value needed by the following operation
                    cmpa      ,Y        ; compare against the limit and set condition flags
                    bne       Code_3240 ; branch when the compared values differ
Code_3237           dec       Addr_001F ; decrement the selected counter
                    lbsr      Code_32D3 ; call the referenced helper routine
                    ldx       Addr_0021 ; load the value needed by the following operation
                    ldb       Addr_001F ; load the value needed by the following operation
Code_3240           lda       #$20      ; load the value needed by the following operation
                    sta       B,X       ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "C"                            ; embedded text or resource bytes
Code_3248           lbra      Code_31BD ; continue at the distant control-flow target
Code_324B           tstb                ; set condition flags from the current value
                    beq       Code_3248 ; branch when the compared values are equal
                    dec       Addr_001F ; decrement the selected counter
                    lbra      Code_31BA ; continue at the distant control-flow target
Code_3253           lda       Code_0020 ; load the value needed by the following operation
Code_3255           deca                ; decrement the selected counter
                    bmi       Code_3260 ; branch while the tested value is negative
                    incb                ; advance the selected counter
                    tst       B,X       ; set condition flags from the current value
                    bne       Code_3255 ; branch when the compared values differ
Code_325D           lbra      Code_321C ; continue at the distant control-flow target
Code_3260           stb       Addr_001F ; save the current value in working storage
                    lbra      Code_31BA ; continue at the distant control-flow target
Code_3265           lda       Code_0020 ; load the value needed by the following operation
Code_3267           deca                ; decrement the selected counter
                    bmi       Code_3260 ; branch while the tested value is negative
                    decb                ; decrement the selected counter
                    bmi       Code_325D ; branch while the tested value is negative
                    bra       Code_3267 ; continue at the selected control-flow target
Code_326F           lda       #$FF      ; load the value needed by the following operation
                    com       Addr_001E ; invert every bit in the selected value
                    beq       Code_3277 ; branch when the compared values are equal
                    lda       #$01      ; load the value needed by the following operation
Code_3277           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1E       ; private DeskMate service selector
                    bra       Code_3248 ; continue at the selected control-flow target
Code_327D           tstb                ; set condition flags from the current value
                    bne       Code_3283 ; branch when the compared values differ
                    incb                ; advance the selected counter
                    stb       Addr_001F ; save the current value in working storage
Code_3283           leax      B,X       ; form the referenced address without reading memory
Code_3285           lda       ,X+       ; fetch the next value and advance the source pointer
                    beq       Code_328D ; branch when the compared values are equal
                    sta       -$02,X    ; save the current value in working storage
                    bra       Code_3285 ; continue at the selected control-flow target
Code_328D           lda       #$20      ; load the value needed by the following operation
                    sta       -$02,X    ; save the current value in working storage
                    dec       Addr_001F ; decrement the selected counter
                    bsr       Code_32D3 ; call the referenced helper routine
                    lbra      Code_31B7 ; continue at the distant control-flow target
Code_3298           tst       $01,Y     ; set condition flags from the current value
                    lbeq      Code_31E8 ; take the distant branch when values are equal
                    pshs      Y,A       ; preserve the listed registers on the stack
Code_32A0           lda       ,Y+       ; fetch the next value and advance the source pointer
                    bne       Code_32A0 ; branch when the compared values differ
                    leay      -$02,Y    ; form the referenced address without reading memory
Code_32A6           lda       ,-Y       ; load the value needed by the following operation
                    sta       $01,Y     ; save the current value in working storage
                    cmpy      $01,S     ; compare against the limit and set condition flags
                    bne       Code_32A6 ; branch when the compared values differ
                    puls      X,A       ; restore the listed registers from the stack
                    sta       ,X        ; save the current value in working storage
                    bsr       Code_32B8 ; call the referenced helper routine
                    lbra      Code_31EE ; continue at the distant control-flow target
Code_32B8           ldx       Addr_0021 ; load the value needed by the following operation
                    ldb       Addr_001F ; load the value needed by the following operation
                    pshs      B         ; preserve the listed registers on the stack
                    leax      B,X       ; form the referenced address without reading memory
Code_32C0           bsr       Code_32D3 ; call the referenced helper routine
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    beq       Code_32CE ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "C"                            ; embedded text or resource bytes
                    inc       Addr_001F ; advance the selected counter
                    bra       Code_32C0 ; continue at the selected control-flow target
Code_32CE           puls      B         ; restore the listed registers from the stack
                    stb       Addr_001F ; save the current value in working storage
                    rts                 ; return to the caller
Code_32D3           ldb       Addr_001F ; load the value needed by the following operation
                    clra                ; clear the selected byte or register
Code_32D6           inca                ; advance the selected counter
                    subb      Code_0020 ; subtract the operand from the running value
                    bhi       Code_32D6 ; branch when the unsigned value is above the limit
                    beq       Code_32E0 ; branch when the compared values are equal
                    deca                ; decrement the selected counter
                    addb      Code_0020 ; add the operand to the running value
Code_32E0           adda      Data_0023 ; add the operand to the running value
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
                    fcb       $17,$FB,$99,$17,$CB,$E2 ; table, bitmap, or initialized data bytes
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
                    fcb       $01,$03   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FF   ; table, bitmap, or initialized data bytes
                    fcc       ":"                            ; embedded text or resource bytes
                    fcb       $17,$CB,$C7 ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
                    fcb       $AE       ; table, bitmap, or initialized data bytes
                    fcc       "a"                            ; embedded text or resource bytes
                    fcb       $26,$04   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "6O_"                          ; embedded text or resource bytes
                    fcb       $17,$CB,$B9,$0A,$8E,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0B       ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $15,$17,$CB,$B0 ; table, bitmap, or initialized data bytes
                    fcc       "D"                            ; embedded text or resource bytes
                    fcb       $10,$AE   ; table, bitmap, or initialized data bytes
                    fcc       "c"                            ; embedded text or resource bytes
                    fcb       $AE,$A4,$CC,$90,$00,$17 ; table, bitmap, or initialized data bytes
                    fcb       $FD,$14   ; table, bitmap, or initialized data bytes
                    fcc       "M'"                           ; embedded text or resource bytes
                    fcb       $0A,$81,$0D ; table, bitmap, or initialized data bytes
                    fcc       "'F"                           ; embedded text or resource bytes
                    fcb       $81,$05   ; table, bitmap, or initialized data bytes
                    fcc       "'7 14v"                       ; embedded text or resource bytes
                    fcb       $17,$CB,$92 ; table, bitmap, or initialized data bytes
                    fcc       ">4"                           ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "m"                            ; embedded text or resource bytes
                    fcb       $8D,$FF,$02,$26,$04 ; table, bitmap, or initialized data bytes
                    fcc       "J*"                           ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $17,$CB,$82 ; table, bitmap, or initialized data bytes
                    fcc       "="                            ; embedded text or resource bytes
                    fcb       $17,$CB   ; table, bitmap, or initialized data bytes
                    fcc       "~E5"                          ; embedded text or resource bytes
                    fcb       $02,$17,$CB ; table, bitmap, or initialized data bytes
                    fcc       "x="                           ; embedded text or resource bytes
                    fcb       $C1,$01,$26,$0B,$8C,$00 ; table, bitmap, or initialized data bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
                    fcc       "5v"                           ; embedded text or resource bytes
                    fcb       $26,$15,$86,$05 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $06       ; table, bitmap, or initialized data bytes
                    fcc       "5v"                           ; embedded text or resource bytes
                    fcb       $86,$0A   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $BB,$9E   ; table, bitmap, or initialized data bytes
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
                    fcb       $8D,$FE,$CA ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $11,$AE,$A4,$A6,$E4,$17 ; table, bitmap, or initialized data bytes
                    fcb       $CB       ; table, bitmap, or initialized data bytes
                    fcc       "4J"                           ; embedded text or resource bytes
                    fcb       $C4,$EF   ; table, bitmap, or initialized data bytes
                    fcc       "]'O0"                         ; embedded text or resource bytes
                    fcb       $8D,$FE,$E2 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $10,$E6,$84,$0D ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $26,$08   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FE,$A3,$17,$CB,$1B ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       ")"                            ; embedded text or resource bytes
                    fcb       $8B,$02,$17,$CB,$13 ; table, bitmap, or initialized data bytes
                    fcc       "="                            ; embedded text or resource bytes
                    fcb       $D1       ; table, bitmap, or initialized data bytes
                    fcc       "+'"                           ; embedded text or resource bytes
                    fcb       $06,$D7   ; table, bitmap, or initialized data bytes
                    fcc       "+"                            ; embedded text or resource bytes
                    fcb       $17,$CB,$09 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $C6,$03,$D7 ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $10,$8E,$00,$01 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $8E,$00,$01,$17,$CA,$F9 ; table, bitmap, or initialized data bytes
                    fcc       "D"                            ; embedded text or resource bytes
                    fcb       $AE,$E4,$17,$CA,$F3,$0A ; table, bitmap, or initialized data bytes
                    fcb       $AF,$E4   ; table, bitmap, or initialized data bytes
                    fcc       "1!Z"                          ; embedded text or resource bytes
                    fcb       $26,$EB   ; table, bitmap, or initialized data bytes
                    fcc       "2b"                           ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       ")L"                           ; embedded text or resource bytes
                    fcb       $17,$CA,$E3 ; table, bitmap, or initialized data bytes
                    fcc       "="                            ; embedded text or resource bytes
                    fcb       $16,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       ")"                            ; embedded text or resource bytes
                    fcb       $17,$CA,$DA ; table, bitmap, or initialized data bytes
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
                    fcb       $06,$17,$CA ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $0F,$C1   ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $26,$04,$1F,$10 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8B       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $06,$17,$CA ; table, bitmap, or initialized data bytes
                    fcc       "QD"                           ; embedded text or resource bytes
                    fcb       $17,$CA   ; table, bitmap, or initialized data bytes
                    fcc       "M5"                           ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       ":"                            ; embedded text or resource bytes
                    fcb       $17,$CA   ; table, bitmap, or initialized data bytes
                    fcc       "G594H"                        ; embedded text or resource bytes
                    fcb       $17,$F9,$F4 ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $E9,$FE,$0C,$10,$DF ; table, bitmap, or initialized data bytes
                    fcc       ",46"                          ; embedded text or resource bytes
                    fcb       $17,$CA   ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $16,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "1O0"                          ; embedded text or resource bytes
                    fcb       $8D,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "h"                            ; embedded text or resource bytes
                    fcb       $17,$CA   ; table, bitmap, or initialized data bytes
                    fcc       ")80"                          ; embedded text or resource bytes
                    fcb       $8D,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "p"                            ; embedded text or resource bytes
                    fcb       $17,$CA   ; table, bitmap, or initialized data bytes
                    fcc       "!G"                           ; embedded text or resource bytes
                    fcb       $C6,$0C,$E7,$84,$17,$CA ; table, bitmap, or initialized data bytes
                    fcb       $19       ; table, bitmap, or initialized data bytes
                    fcc       "G"                            ; embedded text or resource bytes
                    fcb       $C6,$02,$E7,$84,$8E,$1F ; table, bitmap, or initialized data bytes
                    fcb       $1A,$10,$8E,$0B,$06,$86 ; table, bitmap, or initialized data bytes
                    fcb       $FF,$17,$CA,$08,$0E ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $0A,$17,$CA,$02,$0E,$17 ; table, bitmap, or initialized data bytes
                    fcb       $C9,$FE   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $DD       ; table, bitmap, or initialized data bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $17,$C9,$F8 ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $17,$C9,$F4 ; table, bitmap, or initialized data bytes
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
                    fcb       $26,$04,$17,$C9,$D6 ; table, bitmap, or initialized data bytes
                    fcc       "4]"                           ; embedded text or resource bytes
                    fcb       $26,$04,$17,$C9,$CF ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $AE       ; table, bitmap, or initialized data bytes
                    fcc       "d"                            ; embedded text or resource bytes
                    fcb       $A6,$94,$80 ; table, bitmap, or initialized data bytes
                    fcc       "0'"                           ; embedded text or resource bytes
                    fcb       $04,$81,$03 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $06,$17,$C9,$BF ; table, bitmap, or initialized data bytes
                    fcc       "N"                            ; embedded text or resource bytes
                    fcb       $A6,$84,$8E,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $04,$17,$C9,$B4 ; table, bitmap, or initialized data bytes
                    fcc       "D"                            ; embedded text or resource bytes
                    fcb       $17,$C9,$B0 ; table, bitmap, or initialized data bytes
                    fcc       "@"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $17,$01   ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $C6       ; table, bitmap, or initialized data bytes
                    fcc       ")="                           ; embedded text or resource bytes
                    fcb       $17,$C9,$A4 ; table, bitmap, or initialized data bytes
                    fcc       "N0"                           ; embedded text or resource bytes
                    fcb       $88,$26   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8B,$DE   ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $10,$AE   ; table, bitmap, or initialized data bytes
                    fcc       "d"                            ; embedded text or resource bytes
                    fcb       $10,$AE,$22,$CC,$01,$F4 ; table, bitmap, or initialized data bytes
                    fcb       $17,$C9,$90 ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $01,$01,$97 ; table, bitmap, or initialized data bytes
                    fcc       "0'1"                          ; embedded text or resource bytes
                    fcb       $1F,$89,$17,$C9,$82 ; table, bitmap, or initialized data bytes
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
                    fcb       $A7,$04,$17,$C9 ; table, bitmap, or initialized data bytes
                    fcc       "i"                            ; embedded text or resource bytes
                    fcb       $0F,$C1   ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $26,$04,$C6,$06,$E7,$05 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $17,$F8,$9E,$C6,$01,$E7 ; table, bitmap, or initialized data bytes
                    fcb       $8D,$FE,$DE,$0D ; table, bitmap, or initialized data bytes
                    fcc       "0'"                           ; embedded text or resource bytes
                    fcb       $05,$17,$F9,$A1 ; table, bitmap, or initialized data bytes
                    fcc       " -"                           ; embedded text or resource bytes
                    fcb       $1F,$13,$17,$C9 ; table, bitmap, or initialized data bytes
                    fcc       "HE"                           ; embedded text or resource bytes
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
                    fcb       $17,$C9   ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $1D,$17,$C9 ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
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
                    fcb       $06,$17,$C8,$EF,$18 ; table, bitmap, or initialized data bytes
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
                    fcb       $E4,$17,$C8,$9B ; table, bitmap, or initialized data bytes
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
                    fcb       $C8       ; table, bitmap, or initialized data bytes
                    fcc       "k"                            ; embedded text or resource bytes
                    fcb       $13       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $09,$E7,$84,$17,$C8 ; table, bitmap, or initialized data bytes
                    fcc       "c"                            ; embedded text or resource bytes
                    fcb       $13       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $16,$97   ; table, bitmap, or initialized data bytes
                    fcc       "19("                          ; embedded text or resource bytes
                    fcb       $80       ; table, bitmap, or initialized data bytes
Data_37B8           fcc       "?"                            ; embedded text or resource bytes
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
                    fcb       $00,$00   ; table, bitmap, or initialized data bytes
Data_3D28           fcb       $F0       ; table, bitmap, or initialized data bytes
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
Data_3FBA           fcb       $CC,$CC   ; table, bitmap, or initialized data bytes
                    fcc       "33"                           ; embedded text or resource bytes
                    fcb       $CC,$CC   ; table, bitmap, or initialized data bytes
                    fcc       "33"                           ; embedded text or resource bytes
                    fcb       $CC,$CC   ; table, bitmap, or initialized data bytes
                    fcc       "33"                           ; embedded text or resource bytes
                    fcb       $CC,$CC   ; table, bitmap, or initialized data bytes
                    fcc       "33"                           ; embedded text or resource bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00   ; table, bitmap, or initialized data bytes

                    emod
eom                 equ       *
                    end
