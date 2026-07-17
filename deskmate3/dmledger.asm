********************************************************************
* DMLEDGER - DeskMate 3 spreadsheet and ledger
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

                    nam       DMLEDGER
                    ttl       DeskMate 3 spreadsheet and ledger

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct
atrv                set       $00

                    mod       eom,name,tylg,atrv,start,$051C

name                fcs       /DMLEDGER/ ; OS-9 module name

Addr_0001           equ       $0001     ; absolute address used by original code
Addr_0002           equ       $0002     ; absolute address used by original code
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
Addr_0014           equ       $0014     ; absolute address used by original code
Addr_0016           equ       $0016     ; absolute address used by original code
Addr_0017           equ       $0017     ; absolute address used by original code
Addr_0019           equ       $0019     ; absolute address used by original code
Addr_001A           equ       $001A     ; absolute address used by original code
Addr_001B           equ       $001B     ; absolute address used by original code
Addr_001D           equ       $001D     ; absolute address used by original code
Addr_001F           equ       $001F     ; absolute address used by original code
Addr_0020           equ       $0020     ; absolute address used by original code
Addr_0021           equ       $0021     ; absolute address used by original code
Addr_0023           equ       $0023     ; absolute address used by original code
Addr_0024           equ       $0024     ; absolute address used by original code
Addr_0027           equ       $0027     ; absolute address used by original code
Addr_002B           equ       $002B     ; absolute address used by original code
Addr_002C           equ       $002C     ; absolute address used by original code
Addr_002D           equ       $002D     ; absolute address used by original code
Addr_002F           equ       $002F     ; absolute address used by original code
Addr_0030           equ       $0030     ; absolute address used by original code
Addr_0033           equ       $0033     ; absolute address used by original code
Addr_0035           equ       $0035     ; absolute address used by original code
Addr_0036           equ       $0036     ; absolute address used by original code
Addr_0038           equ       $0038     ; absolute address used by original code
Addr_003A           equ       $003A     ; absolute address used by original code
Addr_003C           equ       $003C     ; absolute address used by original code
Addr_003D           equ       $003D     ; absolute address used by original code
Addr_0040           equ       $0040     ; absolute address used by original code
Addr_0041           equ       $0041     ; absolute address used by original code
Addr_0042           equ       $0042     ; absolute address used by original code
Addr_0044           equ       $0044     ; absolute address used by original code
Addr_0046           equ       $0046     ; absolute address used by original code
Addr_0048           equ       $0048     ; absolute address used by original code
Addr_004A           equ       $004A     ; absolute address used by original code
Addr_004C           equ       $004C     ; absolute address used by original code
Addr_0084           equ       $0084     ; absolute address used by original code
Addr_00FF           equ       $00FF     ; absolute address used by original code
Addr_0147           equ       $0147     ; absolute address used by original code
Addr_0203           equ       $0203     ; absolute address used by original code
Addr_03E8           equ       $03E8     ; absolute address used by original code
Addr_0B06           equ       $0B06     ; absolute address used by original code
Addr_0C01           equ       $0C01     ; absolute address used by original code
Addr_0D01           equ       $0D01     ; absolute address used by original code
Addr_0F11           equ       $0F11     ; absolute address used by original code
Addr_1800           equ       $1800     ; absolute address used by original code
Addr_2000           equ       $2000     ; absolute address used by original code
Addr_200A           equ       $200A     ; absolute address used by original code
Addr_200E           equ       $200E     ; absolute address used by original code
Addr_2023           equ       $2023     ; absolute address used by original code
Addr_380C           equ       $380C     ; absolute address used by original code
Addr_414E           equ       $414E     ; absolute address used by original code
Addr_4158           equ       $4158     ; absolute address used by original code
Addr_480E           equ       $480E     ; absolute address used by original code
Addr_6010           equ       $6010     ; absolute address used by original code
Addr_601D           equ       $601D     ; absolute address used by original code
Addr_680D           equ       $680D     ; absolute address used by original code
Addr_6816           equ       $6816     ; absolute address used by original code
Addr_8200           equ       $8200     ; absolute address used by original code
Addr_9000           equ       $9000     ; absolute address used by original code
Addr_9400           equ       $9400     ; absolute address used by original code
Addr_9800           equ       $9800     ; absolute address used by original code
Addr_9900           equ       $9900     ; absolute address used by original code
Addr_B200           equ       $B200     ; absolute address used by original code
Addr_FFFC           equ       $FFFC     ; absolute address used by original code
DeskMateService     equ       $0000     ; absolute address used by original code

start               jmp       >DeskMateService ; dispatch control through the selected target
Code_0018           leas      $051C,U   ; form the referenced address without reading memory
Code_001C           pshs      X         ; preserve the listed registers on the stack
Code_001E           leax      Data_5490,PCR ; form the referenced address without reading memory
Code_0022           lbsr      start     ; invoke the patched DeskMate service dispatcher
Data_0025           fcb       $07       ; private DeskMate service selector
Code_0026           lbsr      start     ; invoke the patched DeskMate service dispatcher
Data_0029           fcb       $06       ; private DeskMate service selector
Code_002A           leax      Data_5C92,PCR ; form the referenced address without reading memory
Code_002E           lbsr      start     ; invoke the patched DeskMate service dispatcher
Data_0031           fcb       $08       ; private DeskMate service selector
Code_0032           puls      X         ; restore the listed registers from the stack
Code_0034           lbra      Code_0037 ; continue at the distant control-flow target
Code_0037           stu       DeskMateService ; save the current value in working storage
Code_0039           stx       Addr_0002 ; save the current value in working storage
Code_003B           lbsr      start     ; invoke the patched DeskMate service dispatcher
Data_003E           fcc       "3"                            ; embedded text or resource bytes
Code_003F           leay      $0154,U   ; form the referenced address without reading memory
Code_0043           ldb       #$0A      ; load the value needed by the following operation
Code_0045           lda       ,X+       ; fetch the next value and advance the source pointer
Code_0047           cmpa      #$0D      ; compare against the limit and set condition flags
Code_0049           beq       Code_0050 ; branch when the compared values are equal
Code_004B           sta       ,Y+       ; store the value and advance the destination pointer
Code_004D           decb                ; decrement the selected counter
                    bra       Code_0045 ; continue at the selected control-flow target
Code_0050           lda       #$20      ; load the value needed by the following operation
                    tstb                ; set condition flags from the current value
                    beq       Code_005A ; branch when the compared values are equal
Code_0055           sta       ,Y+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bgt       Code_0055 ; branch when the signed value is above the limit
Code_005A           clra                ; clear the selected byte or register
                    sta       ,Y+       ; store the value and advance the destination pointer
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    ldd       #Addr_2023 ; load the value needed by the following operation
Code_0064           leax      $015F,U   ; form the referenced address without reading memory
                    lbsr      Code_10BE ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    sta       ,X        ; save the current value in working storage
                    sta       -$19,X    ; save the current value in working storage
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "N"                            ; embedded text or resource bytes
                    lda       $23,X     ; load the value needed by the following operation
                    cmpa      #$28      ; compare against the limit and set condition flags
                    beq       Code_0082 ; branch when the compared values are equal
                    lbsr      Code_1B9F ; call the referenced helper routine
                    bra       Code_0085 ; continue at the selected control-flow target
Code_0082           lbsr      Code_1B69 ; call the referenced helper routine
Code_0085           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $00       ; private DeskMate service selector
                    lbsr      Code_0272 ; call the referenced helper routine
                    bsr       Code_00D9 ; call the referenced helper routine
                    lbsr      Code_0129 ; call the referenced helper routine
                    clr       Addr_0036 ; clear the selected byte or register
                    clr       Data_0031 ; clear the selected byte or register
                    clr       Addr_003C ; clear the selected byte or register
                    leax      Data_0615,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $06       ; private DeskMate service selector
                    lbsr      Code_0150 ; call the referenced helper routine
                    lbsr      Code_094E ; call the referenced helper routine
                    leax      $0154,U   ; form the referenced address without reading memory
                    lda       ,X        ; load the value needed by the following operation
                    cmpa      #$20      ; compare against the limit and set condition flags
                    beq       Code_00B2 ; branch when the compared values are equal
                    lbsr      Code_1C37 ; call the referenced helper routine
Code_00B2           lda       Addr_0007 ; load the value needed by the following operation
                    beq       Code_00BF ; branch when the compared values are equal
                    lda       Addr_0008 ; load the value needed by the following operation
                    beq       Code_00BF ; branch when the compared values are equal
                    lbsr      Code_0251 ; call the referenced helper routine
                    bra       Code_00B2 ; continue at the selected control-flow target
Code_00BF           lbsr      Code_028C ; call the referenced helper routine
                    bra       Code_00B2 ; continue at the selected control-flow target
Code_00C4           lda       Addr_0042 ; load the value needed by the following operation
                    ldb       Addr_0044 ; load the value needed by the following operation
                    sta       Data_003E ; save the current value in working storage
                    stb       Code_003F ; save the current value in working storage
                    lda       Code_0043 ; load the value needed by the following operation
                    ldb       Code_0045 ; load the value needed by the following operation
                    sta       Addr_003D ; save the current value in working storage
                    stb       Addr_0041 ; save the current value in working storage
                    lda       Addr_0046 ; load the value needed by the following operation
                    sta       Addr_0040 ; save the current value in working storage
                    rts                 ; return to the caller
Code_00D9           bsr       Code_00C4 ; call the referenced helper routine
                    ldx       Addr_0002 ; load the value needed by the following operation
                    stx       Addr_0004 ; save the current value in working storage
                    lda       #$FF      ; load the value needed by the following operation
                    sta       ,X        ; save the current value in working storage
                    sta       Addr_0038 ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    sta       Addr_0006 ; save the current value in working storage
                    sta       Addr_000F ; save the current value in working storage
                    sta       Addr_001A ; save the current value in working storage
                    sta       Data_0029 ; save the current value in working storage
                    sta       Code_002A ; save the current value in working storage
                    sta       Code_0037 ; save the current value in working storage
                    sta       Code_0047 ; save the current value in working storage
                    sta       Addr_0048 ; save the current value in working storage
                    sta       Code_0049 ; save the current value in working storage
                    clrb                ; clear the selected byte or register
                    std       Addr_002B ; save the current value in working storage
                    inca                ; advance the selected counter
                    sta       Addr_0007 ; save the current value in working storage
                    sta       Addr_0008 ; save the current value in working storage
Code_0100           sta       Addr_0009 ; save the current value in working storage
Code_0102           sta       Addr_000B ; save the current value in working storage
                    ldb       Addr_0041 ; load the value needed by the following operation
                    stb       Addr_000A ; save the current value in working storage
                    ldb       #$63      ; load the value needed by the following operation
                    pshs      B         ; preserve the listed registers on the stack
                    ldd       #Data_0702 ; load the value needed by the following operation
                    leax      $008C,U   ; form the referenced address without reading memory
                    leay      $00F0,U   ; form the referenced address without reading memory
                    stb       ,X+       ; store the value and advance the destination pointer
Code_0119           stb       ,Y+       ; store the value and advance the destination pointer
Code_011B           sta       ,X+       ; store the value and advance the destination pointer
                    stb       ,Y+       ; store the value and advance the destination pointer
                    dec       ,S        ; decrement the selected counter
                    bgt       Code_011B ; branch when the signed value is above the limit
                    leas      $01,S     ; form the referenced address without reading memory
                    lbsr      Code_0E5A ; call the referenced helper routine
                    rts                 ; return to the caller
Code_0129           leax      Data_084B,PCR ; form the referenced address without reading memory
Code_012D           ldb       #$10      ; load the value needed by the following operation
                    pshs      X,B       ; preserve the listed registers on the stack
                    stx       Data_0836,PCR ; save the current value in working storage
Code_0135           ldd       $01,S     ; load the value needed by the following operation
                    addd      ,X        ; add the operand to the running value
                    std       ,X++      ; store the value and advance the destination pointer
                    dec       ,S        ; decrement the selected counter
                    bgt       Code_0135 ; branch when the signed value is above the limit
                    leas      $03,S     ; form the referenced address without reading memory
                    leax      Data_0857,PCR ; form the referenced address without reading memory
                    stx       Data_083D,PCR ; save the current value in working storage
                    leax      $0E,X     ; form the referenced address without reading memory
                    stx       Data_0844,PCR ; save the current value in working storage
                    rts                 ; return to the caller
Code_0150           pshs      Y,X,D     ; preserve the listed registers on the stack
                    ldx       #DeskMateService ; load the value needed by the following operation
                    leay      $0F,X     ; form the referenced address without reading memory
                    ldb       Addr_0046 ; load the value needed by the following operation
                    incb                ; advance the selected counter
                    lda       Code_004B ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    subd      #Addr_0001 ; subtract the operand from the running value
                    tfr       D,U       ; copy the source register into the destination register
                    pshs      D         ; preserve the listed registers on the stack
                    ldb       #$FF      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $11       ; private DeskMate service selector
                    ldu       DeskMateService ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    ldb       #$AA      ; load the value needed by the following operation
                    ldx       #DeskMateService ; load the value needed by the following operation
                    ldy       #Data_0E4E ; load the value needed by the following operation
                    tst       Addr_004A ; set condition flags from the current value
                    beq       Code_0180 ; branch when the compared values are equal
                    leay      $02,Y     ; form the referenced address without reading memory
                    lsrb                ; shift right and expose the low bit through carry
Code_0180           ldx       #DeskMateService ; load the value needed by the following operation
                    lda       #$0E      ; load the value needed by the following operation
                    ldy       #Addr_000D ; load the value needed by the following operation
                    puls      U         ; restore the listed registers from the stack
Code_018B           pshs      Y         ; preserve the listed registers on the stack
                    pshs      X         ; preserve the listed registers on the stack
                    pshs      U         ; preserve the listed registers on the stack
                    pshs      D         ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $11       ; private DeskMate service selector
                    puls      D         ; restore the listed registers from the stack
                    puls      U         ; restore the listed registers from the stack
                    puls      X         ; restore the listed registers from the stack
                    puls      Y         ; restore the listed registers from the stack
                    leay      -$01,Y    ; form the referenced address without reading memory
                    deca                ; decrement the selected counter
                    bgt       Code_018B ; branch when the signed value is above the limit
                    ldu       DeskMateService ; load the value needed by the following operation
                    ldx       #Addr_B200 ; load the value needed by the following operation
                    lda       #$0E      ; load the value needed by the following operation
                    ldb       Addr_0046 ; load the value needed by the following operation
                    incb                ; advance the selected counter
                    tst       Addr_004A ; set condition flags from the current value
                    bne       Code_01B3 ; branch when the compared values differ
                    aslb                ; shift left and update carry
Code_01B3           tfr       D,Y       ; copy the source register into the destination register
                    lda       #$55      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0E       ; private DeskMate service selector
Code_01BB           lda       #$03      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    lbsr      Code_02F1 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    ldd       #Code_012D ; load the value needed by the following operation
                    leax      Data_0625,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    ldb       #$47      ; load the value needed by the following operation
                    leax      Data_0673,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    ldb       #$32      ; load the value needed by the following operation
                    leax      Data_06C1,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    ldb       #$38      ; load the value needed by the following operation
                    leax      Data_070D,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    ldb       #$3D      ; load the value needed by the following operation
Code_01F4           leax      Data_0759,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    ldb       #$42      ; load the value needed by the following operation
                    leax      Data_07A7,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    puls      PC,Y,X,D  ; restore the listed registers from the stack
Code_020C           lbra      Code_13D8 ; continue at the distant control-flow target
                    lbra      Code_132F ; continue at the distant control-flow target
                    lbra      Code_155B ; continue at the distant control-flow target
                    lbra      Code_4489 ; continue at the distant control-flow target
                    lbra      Code_365C ; continue at the distant control-flow target
                    lbra      Code_2FEC ; continue at the distant control-flow target
                    lbra      Code_466D ; continue at the distant control-flow target
                    lbra      Code_1F34 ; continue at the distant control-flow target
                    lbra      Code_2593 ; continue at the distant control-flow target
                    lbra      Code_29EE ; continue at the distant control-flow target
                    lbra      Code_1C75 ; continue at the distant control-flow target
                    lbra      Code_2974 ; continue at the distant control-flow target
                    lbra      Code_2ACA ; continue at the distant control-flow target
                    lbra      Code_13D8 ; continue at the distant control-flow target
                    lbra      Code_21D5 ; continue at the distant control-flow target
                    lbra      Code_13D8 ; continue at the distant control-flow target
                    lbra      Code_02DB ; continue at the distant control-flow target
                    lbra      Code_2462 ; continue at the distant control-flow target
                    lbra      Code_0609 ; continue at the distant control-flow target
                    lbra      Code_212E ; continue at the distant control-flow target
                    lbra      Code_0FBF ; continue at the distant control-flow target
                    lbra      Code_2EF2 ; continue at the distant control-flow target
                    lbra      Code_2CCF ; continue at the distant control-flow target
Code_0251           clra                ; clear the selected byte or register
                    lbsr      Code_178C ; call the referenced helper routine
Code_0255           bpl       Code_0262 ; branch while the tested value is nonnegative
                    lbsr      Code_059E ; call the referenced helper routine
                    lbsr      Code_0323 ; call the referenced helper routine
                    lbsr      Code_05F0 ; call the referenced helper routine
                    bra       Code_0265 ; continue at the selected control-flow target
Code_0262           lbsr      Code_164D ; call the referenced helper routine
Code_0265           leax      >Code_020C,PCR ; form the referenced address without reading memory
                    lda       #$03      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    jsr       B,X       ; call the referenced helper routine
                    lbsr      Code_04FE ; call the referenced helper routine
                    rts                 ; return to the caller
Code_0272           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       ","                            ; embedded text or resource bytes
                    ldd       Addr_0002 ; load the value needed by the following operation
                    pshs      D         ; preserve the listed registers on the stack
                    tfr       Y,D       ; copy the source register into the destination register
                    subd      ,S++      ; subtract the operand from the running value
                    subd      #Addr_0001 ; subtract the operand from the running value
                    std       Addr_0013 ; save the current value in working storage
                    sty       Addr_002F ; save the current value in working storage
                    rts                 ; return to the caller
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $17,$FD,$8A ; table, bitmap, or initialized data bytes
                    fcc       "W"                            ; embedded text or resource bytes
Code_028C           clra                ; clear the selected byte or register
                    lbsr      Code_178C ; call the referenced helper routine
                    tst       Addr_0007 ; set condition flags from the current value
                    beq       Code_029D ; branch when the compared values are equal
                    tst       Addr_0008 ; set condition flags from the current value
                    beq       Code_029D ; branch when the compared values are equal
                    lda       Addr_0011 ; load the value needed by the following operation
                    lbra      Code_0255 ; continue at the distant control-flow target
Code_029D           lda       Addr_0011 ; load the value needed by the following operation
                    bpl       Code_02AB ; branch while the tested value is nonnegative
                    lbsr      Code_058E ; call the referenced helper routine
                    bsr       Code_0323 ; call the referenced helper routine
                    lbsr      Code_05F0 ; call the referenced helper routine
                    bra       Code_02AE ; continue at the selected control-flow target
Code_02AB           lbsr      Code_164D ; call the referenced helper routine
Code_02AE           cmpb      #$03      ; compare against the limit and set condition flags
                    beq       Code_02CE ; branch when the compared values are equal
                    cmpb      #$06      ; compare against the limit and set condition flags
                    bne       Code_02BA ; branch when the compared values differ
                    ldb       #$14      ; load the value needed by the following operation
                    bra       Code_02CE ; continue at the selected control-flow target
Code_02BA           cmpb      #$0B      ; compare against the limit and set condition flags
                    blt       Code_02D7 ; branch when the signed value is below the limit
                    cmpb      #$0C      ; compare against the limit and set condition flags
                    bgt       Code_02C6 ; branch when the signed value is above the limit
                    addb      #$0A      ; add the operand to the running value
                    bra       Code_02CE ; continue at the selected control-flow target
Code_02C6           cmpb      #$0E      ; compare against the limit and set condition flags
                    beq       Code_02CE ; branch when the compared values are equal
                    cmpb      #$11      ; compare against the limit and set condition flags
                    bne       Code_02D7 ; branch when the compared values differ
Code_02CE           leax      Code_020C,PCR ; form the referenced address without reading memory
                    lda       #$03      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    jsr       B,X       ; call the referenced helper routine
Code_02D7           lbsr      Code_04FE ; call the referenced helper routine
                    rts                 ; return to the caller
Code_02DB           lda       Addr_0011 ; load the value needed by the following operation
                    cmpa      #$2B      ; compare against the limit and set condition flags
                    beq       Code_02ED ; branch when the compared values are equal
                    cmpa      #$2D      ; compare against the limit and set condition flags
                    beq       Code_02ED ; branch when the compared values are equal
                    cmpa      #$2E      ; compare against the limit and set condition flags
                    beq       Code_02ED ; branch when the compared values are equal
                    lbsr      Code_132F ; call the referenced helper routine
                    rts                 ; return to the caller
Code_02ED           lbsr      Code_155B ; call the referenced helper routine
                    rts                 ; return to the caller
Code_02F1           clra                ; clear the selected byte or register
                    ldb       #$01      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    leax      Data_07F5,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "6"                            ; embedded text or resource bytes
                    ldb       #$05      ; load the value needed by the following operation
                    tst       Addr_004A ; set condition flags from the current value
                    beq       Code_0308 ; branch when the compared values are equal
                    ldb       #$0B      ; load the value needed by the following operation
Code_0308           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "6"                            ; embedded text or resource bytes
                    ldb       #$0B      ; load the value needed by the following operation
                    tst       Addr_004A ; set condition flags from the current value
                    beq       Code_0319 ; branch when the compared values are equal
                    ldb       #$17      ; load the value needed by the following operation
Code_0319           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "6"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_0323           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    cmpa      #$8C      ; compare against the limit and set condition flags
                    beq       Code_0368 ; branch when the compared values are equal
Code_032B           anda      #$7F      ; mask off unwanted bits
                    cmpa      #$2F      ; compare against the limit and set condition flags
                    beq       Code_0363 ; branch when the compared values are equal
                    cmpa      #$3A      ; compare against the limit and set condition flags
                    beq       Code_035E ; branch when the compared values are equal
                    suba      #$30      ; subtract the operand from the running value
                    cmpa      #$01      ; compare against the limit and set condition flags
                    blt       Code_0366 ; branch when the signed value is below the limit
                    cmpa      #$09      ; compare against the limit and set condition flags
                    bgt       Code_0366 ; branch when the signed value is above the limit
                    beq       Code_0355 ; branch when the compared values are equal
                    cmpa      #$02      ; compare against the limit and set condition flags
                    bgt       Code_0349 ; branch when the signed value is above the limit
                    adda      #$02      ; add the operand to the running value
                    bra       Code_0357 ; continue at the selected control-flow target
Code_0349           cmpa      #$06      ; compare against the limit and set condition flags
                    bgt       Code_0351 ; branch when the signed value is above the limit
                    adda      #$04      ; add the operand to the running value
                    bra       Code_0357 ; continue at the selected control-flow target
Code_0351           adda      #$06      ; add the operand to the running value
                    bra       Code_0357 ; continue at the selected control-flow target
Code_0355           adda      #$02      ; add the operand to the running value
Code_0357           leax      Data_08F3,PCR ; form the referenced address without reading memory
                    ldb       A,X       ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_035E           lbsr      Code_1AA1 ; call the referenced helper routine
                    bra       Code_0366 ; continue at the selected control-flow target
Code_0363           lbsr      Code_1ADD ; call the referenced helper routine
Code_0366           clrb                ; clear the selected byte or register
                    rts                 ; return to the caller
Code_0368           tst       Addr_0038 ; set condition flags from the current value
                    blt       Code_0370 ; branch when the signed value is below the limit
                    tst       Code_0037 ; set condition flags from the current value
                    ble       Code_0366 ; branch when the signed value is at or below the limit
Code_0370           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    lda       #$03      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    tst       Code_0037 ; set condition flags from the current value
                    bne       Code_03C0 ; branch when the compared values differ
                    lda       #$01      ; load the value needed by the following operation
Code_0380           sta       Addr_004C ; save the current value in working storage
                    lbsr      Code_02F1 ; call the referenced helper routine
                    lda       Addr_004C ; load the value needed by the following operation
                    ldb       #$01      ; load the value needed by the following operation
                    leax      Data_07F5,PCR ; form the referenced address without reading memory
                    deca                ; decrement the selected counter
                    beq       Code_03A8 ; branch when the compared values are equal
                    ldb       #$05      ; load the value needed by the following operation
                    tst       Addr_004A ; set condition flags from the current value
                    beq       Code_0398 ; branch when the compared values are equal
                    ldb       #$0B      ; load the value needed by the following operation
Code_0398           leax      $05,X     ; form the referenced address without reading memory
                    deca                ; decrement the selected counter
                    beq       Code_03A8 ; branch when the compared values are equal
                    clra                ; clear the selected byte or register
                    ldb       #$0B      ; load the value needed by the following operation
                    tst       Addr_004A ; set condition flags from the current value
                    beq       Code_03A6 ; branch when the compared values are equal
                    ldb       #$17      ; load the value needed by the following operation
Code_03A6           leax      $06,X     ; form the referenced address without reading memory
Code_03A8           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    ldb       #$40      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "6"                            ; embedded text or resource bytes
                    tst       Addr_0038 ; set condition flags from the current value
                    blt       Code_03D9 ; branch when the signed value is below the limit
Code_03B6           clra                ; clear the selected byte or register
                    lbsr      Code_178C ; call the referenced helper routine
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    bne       Code_03B6 ; branch when the compared values differ
                    bra       Code_03C4 ; continue at the selected control-flow target
Code_03C0           lda       #$FF      ; load the value needed by the following operation
                    sta       Addr_0038 ; save the current value in working storage
Code_03C4           bsr       Code_0417 ; call the referenced helper routine
                    clr       Code_0037 ; clear the selected byte or register
                    tstb                ; set condition flags from the current value
                    blt       Code_03D4 ; branch when the signed value is below the limit
                    cmpb      #$01      ; compare against the limit and set condition flags
                    beq       Code_0363 ; branch when the compared values are equal
                    clr       Data_1C34,PCR ; clear the selected byte or register
                    rts                 ; return to the caller
Code_03D4           tfr       B,A       ; copy the source register into the destination register
                    lbra      Code_032B ; continue at the distant control-flow target
Code_03D9           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    ldb       #$00      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1C       ; private DeskMate service selector
                    beq       Code_03D9 ; branch when the compared values are equal
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    beq       Code_03C4 ; branch when the compared values are equal
                    cmpa      #$08      ; compare against the limit and set condition flags
                    bne       Code_03F6 ; branch when the compared values differ
                    lda       Addr_004C ; load the value needed by the following operation
                    cmpa      #$01      ; compare against the limit and set condition flags
                    beq       Code_03D9 ; branch when the compared values are equal
                    deca                ; decrement the selected counter
                    bra       Code_0380 ; continue at the selected control-flow target
Code_03F6           cmpa      #$09      ; compare against the limit and set condition flags
                    bne       Code_0404 ; branch when the compared values differ
                    lda       Addr_004C ; load the value needed by the following operation
                    cmpa      #$03      ; compare against the limit and set condition flags
                    beq       Code_03D9 ; branch when the compared values are equal
                    inca                ; advance the selected counter
                    lbra      Code_0380 ; continue at the distant control-flow target
Code_0404           cmpa      #$8A      ; compare against the limit and set condition flags
                    beq       Code_0411 ; branch when the compared values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    beq       Code_0411 ; branch when the compared values are equal
                    lda       Addr_004C ; load the value needed by the following operation
                    lbra      Code_0380 ; continue at the distant control-flow target
Code_0411           clrb                ; clear the selected byte or register
                    pshs      Y,X,D     ; preserve the listed registers on the stack
                    lbra      Code_01BB ; continue at the distant control-flow target
Code_0417           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    clr       Addr_001F ; clear the selected byte or register
                    lda       Addr_004C ; load the value needed by the following operation
                    sta       Data_1C34,PCR ; save the current value in working storage
                    tst       Addr_0007 ; set condition flags from the current value
                    beq       Code_042B ; branch when the compared values are equal
                    tst       Addr_0008 ; set condition flags from the current value
                    bne       Code_0433 ; branch when the compared values differ
Code_042B           cmpa      #$02      ; compare against the limit and set condition flags
                    bne       Code_0433 ; branch when the compared values differ
                    asl       Data_1C34,PCR ; shift left and update carry
Code_0433           clrb                ; clear the selected byte or register
                    leax      Data_0806,PCR ; form the referenced address without reading memory
                    deca                ; decrement the selected counter
                    beq       Code_0448 ; branch when the compared values are equal
                    leax      $10,X     ; form the referenced address without reading memory
                    addb      #$07      ; add the operand to the running value
                    deca                ; decrement the selected counter
                    beq       Code_0448 ; branch when the compared values are equal
                    leax      $10,X     ; form the referenced address without reading memory
                    addb      #$07      ; add the operand to the running value
Code_0448           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    leax      Data_0836,PCR ; form the referenced address without reading memory
                    abx                 ; add the operand to the running value
                    clra                ; clear the selected byte or register
                    lbsr      Code_4C15 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $16       ; private DeskMate service selector
Code_0459           lbsr      Code_4D25 ; call the referenced helper routine
                    tstb                ; set condition flags from the current value
                    beq       Code_0459 ; branch when the compared values are equal
                    blt       Code_0491 ; branch when the signed value is below the limit
                    cmpb      #$0D      ; compare against the limit and set condition flags
                    beq       Code_04A8 ; branch when the compared values are equal
                    cmpb      #$05      ; compare against the limit and set condition flags
                    bne       Code_0459 ; branch when the compared values differ
Code_0469           lda       Addr_004C ; load the value needed by the following operation
                    sta       Addr_0036 ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    cmpb      #$05      ; compare against the limit and set condition flags
                    beq       Code_04A5 ; branch when the compared values are equal
                    cmpb      #$8A      ; compare against the limit and set condition flags
                    beq       Code_04A5 ; branch when the compared values are equal
                    cmpb      #$B6      ; compare against the limit and set condition flags
                    bne       Code_0490 ; branch when the compared values differ
                    tst       Addr_0006 ; set condition flags from the current value
                    bne       Code_0490 ; branch when the compared values differ
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
Code_048E           bsr       Code_04FE ; call the referenced helper routine
Code_0490           rts                 ; return to the caller
Code_0491           tfr       B,A       ; copy the source register into the destination register
                    anda      #$7F      ; mask off unwanted bits
                    cmpa      #$2F      ; compare against the limit and set condition flags
                    beq       Code_0469 ; branch when the compared values are equal
                    suba      #$30      ; subtract the operand from the running value
                    cmpa      #$01      ; compare against the limit and set condition flags
                    blt       Code_0459 ; branch when the signed value is below the limit
                    cmpa      #$09      ; compare against the limit and set condition flags
                    bgt       Code_0459 ; branch when the signed value is above the limit
                    bra       Code_0469 ; continue at the selected control-flow target
Code_04A5           clrb                ; clear the selected byte or register
                    bra       Code_048E ; continue at the selected control-flow target
Code_04A8           ldb       Addr_004C ; load the value needed by the following operation
                    cmpb      #$02      ; compare against the limit and set condition flags
                    blt       Code_04B6 ; branch when the signed value is below the limit
                    bgt       Code_04B4 ; branch when the signed value is above the limit
                    adda      #$06      ; add the operand to the running value
                    bra       Code_04B6 ; continue at the selected control-flow target
Code_04B4           adda      #$0D      ; add the operand to the running value
Code_04B6           tfr       A,B       ; copy the source register into the destination register
                    leax      Data_084B,PCR ; form the referenced address without reading memory
                    aslb                ; shift left and update carry
                    ldb       [B,X]     ; load the value needed by the following operation
                    blt       Code_0459 ; branch when the signed value is below the limit
                    leax      Data_08F3,PCR ; form the referenced address without reading memory
                    ldb       A,X       ; load the value needed by the following operation
                    pshs      B         ; preserve the listed registers on the stack
                    cmpa      #$01      ; compare against the limit and set condition flags
                    bgt       Code_04D9 ; branch when the signed value is above the limit
                    beq       Code_04D5 ; branch when the compared values are equal
                    lda       #$02      ; load the value needed by the following operation
                    sta       Data_0031 ; save the current value in working storage
                    bra       Code_04D9 ; continue at the selected control-flow target
Code_04D5           lda       #$02      ; load the value needed by the following operation
                    sta       Addr_000F ; save the current value in working storage
Code_04D9           ldb       Addr_004C ; load the value needed by the following operation
                    stb       Addr_0036 ; save the current value in working storage
                    cmpa      #$0A      ; compare against the limit and set condition flags
                    bne       Code_04EB ; branch when the compared values differ
                    tst       Addr_0006 ; set condition flags from the current value
                    bne       Code_04EB ; branch when the compared values differ
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    bsr       Code_04FE ; call the referenced helper routine
Code_04EB           clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    puls      PC,B      ; restore the listed registers from the stack
Code_04FE           tst       Addr_0036 ; set condition flags from the current value
                    bne       Code_0503 ; branch when the compared values differ
                    rts                 ; return to the caller
Code_0503           pshs      B         ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    bsr       Code_0537 ; call the referenced helper routine
                    lbsr      Code_0D2A ; call the referenced helper routine
                    lda       Addr_003D ; load the value needed by the following operation
                    sta       Code_001E ; save the current value in working storage
                    lda       Addr_0036 ; load the value needed by the following operation
                    cmpa      #$02      ; compare against the limit and set condition flags
                    blt       Code_051E ; branch when the signed value is below the limit
                    bgt       Code_0522 ; branch when the signed value is above the limit
                    lda       #$07      ; load the value needed by the following operation
                    bra       Code_0524 ; continue at the selected control-flow target
Code_051E           lda       #$06      ; load the value needed by the following operation
                    bra       Code_0524 ; continue at the selected control-flow target
Code_0522           lda       #$03      ; load the value needed by the following operation
Code_0524           adda      Addr_001F ; add the operand to the running value
                    sta       Addr_001F ; save the current value in working storage
                    lbsr      Code_45F3 ; call the referenced helper routine
                    lda       #$04      ; load the value needed by the following operation
                    sta       Data_0029 ; save the current value in working storage
                    clr       Addr_0036 ; clear the selected byte or register
                    clr       Data_1C34,PCR ; clear the selected byte or register
                    puls      PC,B      ; restore the listed registers from the stack
Code_0537           pshs      Y,X       ; preserve the listed registers on the stack
                    ldb       Addr_0046 ; load the value needed by the following operation
                    incb                ; advance the selected counter
                    lda       Code_004B ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    subd      #Addr_0001 ; subtract the operand from the running value
                    tfr       D,U       ; copy the source register into the destination register
                    clrb                ; clear the selected byte or register
                    ldx       #DeskMateService ; load the value needed by the following operation
                    leay      $0E,X     ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $11       ; private DeskMate service selector
                    ldb       #$FF      ; load the value needed by the following operation
                    leay      $01,Y     ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $11       ; private DeskMate service selector
                    ldu       DeskMateService ; load the value needed by the following operation
                    pshs      D         ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    lbra      Code_01BB ; continue at the distant control-flow target
Code_0561           pshs      X,D       ; preserve the listed registers on the stack
                    ldx       Addr_0002 ; load the value needed by the following operation
Code_0565           ldd       ,X        ; load the value needed by the following operation
                    blt       Code_0582 ; branch when the signed value is below the limit
                    cmpa      Code_0022 ; compare against the limit and set condition flags
                    blt       Code_0579 ; branch when the signed value is below the limit
                    cmpa      Addr_0024 ; compare against the limit and set condition flags
                    bgt       Code_0579 ; branch when the signed value is above the limit
                    cmpb      Addr_0023 ; compare against the limit and set condition flags
                    blt       Code_0579 ; branch when the signed value is below the limit
                    cmpb      Data_0025 ; compare against the limit and set condition flags
                    ble       Code_0588 ; branch when the signed value is at or below the limit
Code_0579           ldb       $02,X     ; load the value needed by the following operation
                    andb      #$3F      ; mask off unwanted bits
                    addb      #$04      ; add the operand to the running value
                    abx                 ; add the operand to the running value
                    bra       Code_0565 ; continue at the selected control-flow target
Code_0582           leay      Data_0912,PCR ; form the referenced address without reading memory
                    bra       Code_05D7 ; continue at the selected control-flow target
Code_0588           leay      Data_0903,PCR ; form the referenced address without reading memory
                    bra       Code_05D7 ; continue at the selected control-flow target
Code_058E           pshs      X,D       ; preserve the listed registers on the stack
                    leay      Data_0930,PCR ; form the referenced address without reading memory
                    tst       Addr_0007 ; set condition flags from the current value
                    beq       Code_05D7 ; branch when the compared values are equal
                    leay      Data_0921,PCR ; form the referenced address without reading memory
                    bra       Code_05D7 ; continue at the selected control-flow target
Code_059E           pshs      X,D       ; preserve the listed registers on the stack
                    ldx       Addr_0002 ; load the value needed by the following operation
                    ldd       ,X        ; load the value needed by the following operation
                    blt       Code_05D3 ; branch when the signed value is below the limit
Code_05A6           ldb       $02,X     ; load the value needed by the following operation
                    blt       Code_05B9 ; branch when the signed value is below the limit
                    andb      #$3F      ; mask off unwanted bits
                    addb      #$04      ; add the operand to the running value
                    abx                 ; add the operand to the running value
                    ldd       ,X        ; load the value needed by the following operation
                    bgt       Code_05A6 ; branch when the signed value is above the limit
                    lda       #$80      ; load the value needed by the following operation
                    sta       Data_08E6,PCR ; save the current value in working storage
Code_05B9           tst       Code_002A ; set condition flags from the current value
                    bne       Code_05C3 ; branch when the compared values differ
                    lda       #$80      ; load the value needed by the following operation
                    sta       Data_08B5,PCR ; save the current value in working storage
Code_05C3           ldd       Addr_000D ; load the value needed by the following operation
                    bne       Code_05D1 ; branch when the compared values differ
                    lda       #$80      ; load the value needed by the following operation
                    sta       Data_08A2,PCR ; save the current value in working storage
                    sta       Data_08BF,PCR ; save the current value in working storage
Code_05D1           puls      PC,X,D    ; restore the listed registers from the stack
Code_05D3           leay      Data_093F,PCR ; form the referenced address without reading memory
Code_05D7           leax      Data_086B,PCR ; form the referenced address without reading memory
                    lda       #$80      ; load the value needed by the following operation
Code_05DD           ldb       ,Y+       ; fetch the next value and advance the source pointer
                    blt       Code_05E9 ; branch when the signed value is below the limit
                    beq       Code_05E5 ; branch when the compared values are equal
                    sta       ,X        ; save the current value in working storage
Code_05E5           bsr       Code_05EB ; call the referenced helper routine
                    bra       Code_05DD ; continue at the selected control-flow target
Code_05E9           puls      PC,X,D    ; restore the listed registers from the stack
Code_05EB           ldb       ,X+       ; fetch the next value and advance the source pointer
                    bne       Code_05EB ; branch when the compared values differ
                    rts                 ; return to the caller
Code_05F0           pshs      X,D       ; preserve the listed registers on the stack
                    ldd       #Addr_200E ; load the value needed by the following operation
                    pshs      B         ; preserve the listed registers on the stack
                    leax      Data_086B,PCR ; form the referenced address without reading memory
Code_05FB           sta       ,X        ; save the current value in working storage
                    dec       ,S        ; decrement the selected counter
                    beq       Code_0605 ; branch when the compared values are equal
                    bsr       Code_05EB ; call the referenced helper routine
                    bra       Code_05FB ; continue at the selected control-flow target
Code_0605           leas      $01,S     ; form the referenced address without reading memory
                    puls      PC,X,D    ; restore the listed registers from the stack
Code_0609           lda       #$02      ; load the value needed by the following operation
                    sta       Addr_000F ; save the current value in working storage
                    lbsr      Code_1C75 ; call the referenced helper routine
                    clr       Addr_000F ; clear the selected byte or register
                    rts                 ; return to the caller
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
Data_0615           fcc       "<<<<"                         ; embedded text or resource bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
                    fcc       "~<"                           ; embedded text or resource bytes
                    fcb       $18       ; table, bitmap, or initialized data bytes
                    fcc       "<<<<"                         ; embedded text or resource bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
                    fcc       "~<"                           ; embedded text or resource bytes
                    fcb       $18       ; table, bitmap, or initialized data bytes
Data_0625           fcc       "("                            ; embedded text or resource bytes
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
Data_0673           fcc       "("                            ; embedded text or resource bytes
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
Data_06C1           fcc       "("                            ; embedded text or resource bytes
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
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $02,$0B   ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
                    fcc       "TeP"                          ; embedded text or resource bytes
                    fcb       $C5       ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $C0,$8F,$FC,$1F ; table, bitmap, or initialized data bytes
Data_0702           fcb       $FC,$8F,$FC ; table, bitmap, or initialized data bytes
Data_0705           fcc       "C"                            ; embedded text or resource bytes
                    fcb       $C0       ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $C5       ; table, bitmap, or initialized data bytes
                    fcc       "TeU"                          ; embedded text or resource bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
Data_070D           fcc       "("                            ; embedded text or resource bytes
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
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $02,$0B   ; table, bitmap, or initialized data bytes
                    fcc       "PUR"                          ; embedded text or resource bytes
                    fcb       $15       ; table, bitmap, or initialized data bytes
                    fcc       "S"                            ; embedded text or resource bytes
                    fcb       $05,$03,$C1 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $F8       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $F0,$03,$C1 ; table, bitmap, or initialized data bytes
                    fcc       "S"                            ; embedded text or resource bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
                    fcc       "R"                            ; embedded text or resource bytes
                    fcb       $15       ; table, bitmap, or initialized data bytes
                    fcc       "PU"                           ; embedded text or resource bytes
Data_0759           fcc       "("                            ; embedded text or resource bytes
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
Data_07A7           fcc       "("                            ; embedded text or resource bytes
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
Data_07F5           fcc       "File"                         ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_07FA           fcc       "Block"                        ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_0800           fcc       "Ce"                           ; embedded text or resource bytes
Data_0802           fcc       "lls"                          ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_0806           fcc       "("                            ; embedded text or resource bytes
                    fcb       $00,$01   ; table, bitmap, or initialized data bytes
Data_0809           fcb       $09,$08,$00,$AA,$E0 ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $00,$01,$09,$08,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $04,$01,$0B,$09,$00,$AA ; table, bitmap, or initialized data bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $0A,$01,$0B,$09,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $0A,$01,$0D,$05,$00,$AA ; table, bitmap, or initialized data bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $15,$01,$0D,$05,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
Data_0836           fcb       $00,$00,$06,$07,$06,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_083D           fcb       $00,$00,$07,$09,$07,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_0844           fcb       $00,$00,$03,$0B,$03,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_084B           fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_084E           fcc       ")"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "F"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
Data_0857           fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "W"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "b"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "j"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "t"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "~"                            ; embedded text or resource bytes
                    fcb       $00,$88,$00 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $00,$93,$00,$9B,$00 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
Data_086B           fcc       " "                            ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "  open"                       ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "  close"                      ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "  save"                       ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       " 1 "                          ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "merge"                        ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       " 2 print"                     ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       " ? help"                      ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_08A2           fcc       " "                            ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "  format"                     ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       " 3 copy"                      ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_08B5           fcc       " 4 insert"                    ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_08BF           fcc       " 5 delete"                    ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       " 6 select"                    ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       " 9 formula"                   ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       " 7 find"                      ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_08E6           fcc       " 8 calculate"                 ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_08F3           fcb       $07,$0A,$0A,$07,$13,$01 ; table, bitmap, or initialized data bytes
                    fcb       $06,$09,$0C,$0B,$08,$05 ; table, bitmap, or initialized data bytes
                    fcb       $01,$03,$04,$01 ; table, bitmap, or initialized data bytes
Data_0903           fcb       $01,$01   ; table, bitmap, or initialized data bytes
Data_0905           fcb       $00,$01,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $01,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
Data_0910           fcb       $01,$FF   ; table, bitmap, or initialized data bytes
Data_0912           fcb       $01,$01,$01,$01,$01,$00 ; table, bitmap, or initialized data bytes
                    fcb       $01,$01,$01,$01,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$01,$FF ; table, bitmap, or initialized data bytes
Data_0921           fcb       $01,$01,$01,$01,$01,$00 ; table, bitmap, or initialized data bytes
                    fcb       $01,$01,$00,$00,$01,$01 ; table, bitmap, or initialized data bytes
                    fcb       $00,$01,$FF ; table, bitmap, or initialized data bytes
Data_0930           fcb       $01,$01,$01,$01,$01,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$01,$00,$00,$01,$01 ; table, bitmap, or initialized data bytes
                    fcb       $00,$01,$FF ; table, bitmap, or initialized data bytes
Data_093F           fcb       $00,$00,$01,$00,$01,$00 ; table, bitmap, or initialized data bytes
                    fcb       $01,$01,$01,$01,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$01,$FF ; table, bitmap, or initialized data bytes
Code_094E           pshs      Y,X,D     ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    lda       #$01      ; load the value needed by the following operation
                    sta       Data_0029 ; save the current value in working storage
                    tst       Addr_0036 ; set condition flags from the current value
                    beq       Code_0961 ; branch when the compared values are equal
                    lbsr      Code_0537 ; call the referenced helper routine
                    clr       Addr_0036 ; clear the selected byte or register
Code_0961           lbsr      Code_0D2A ; call the referenced helper routine
                    ldb       Addr_0009 ; load the value needed by the following operation
                    pshs      B         ; preserve the listed registers on the stack
                    lda       Addr_003D ; load the value needed by the following operation
Code_096A           clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    ldb       ,S        ; load the value needed by the following operation
                    lbsr      Code_0CCF ; call the referenced helper routine
                    inca                ; advance the selected counter
                    inc       ,S        ; advance the selected counter
                    ldb       ,S        ; load the value needed by the following operation
                    cmpb      Addr_000A ; compare against the limit and set condition flags
                    bgt       Code_0981 ; branch when the signed value is above the limit
                    cmpb      #$63      ; compare against the limit and set condition flags
                    ble       Code_096A ; branch when the signed value is at or below the limit
Code_0981           cmpa      #$15      ; compare against the limit and set condition flags
                    bgt       Code_099C ; branch when the signed value is above the limit
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    pshs      A         ; preserve the listed registers on the stack
                    ldd       #Code_2040 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $02       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $02       ; private DeskMate service selector
                    puls      A         ; restore the listed registers from the stack
                    inca                ; advance the selected counter
                    bra       Code_0981 ; continue at the selected control-flow target
Code_099C           leas      $01,S     ; form the referenced address without reading memory
                    clra                ; clear the selected byte or register
                    ldb       Addr_0042 ; load the value needed by the following operation
                    decb                ; decrement the selected counter
                    tfr       D,X       ; copy the source register into the destination register
                    ldb       Code_0043 ; load the value needed by the following operation
                    decb                ; decrement the selected counter
                    tfr       D,Y       ; copy the source register into the destination register
                    lda       Code_0045 ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    ldb       Addr_0044 ; load the value needed by the following operation
                    addb      #$02      ; add the operand to the running value
                    ldu       #Addr_2000 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "%"                            ; embedded text or resource bytes
                    ldu       DeskMateService ; load the value needed by the following operation
                    leay      $0183,U   ; form the referenced address without reading memory
                    ldx       Addr_0002 ; load the value needed by the following operation
Code_09BF           ldd       ,X        ; load the value needed by the following operation
                    blt       Code_09E8 ; branch when the signed value is below the limit
                    cmpa      Addr_0009 ; compare against the limit and set condition flags
                    blt       Code_09E2 ; branch when the signed value is below the limit
                    cmpa      Addr_000A ; compare against the limit and set condition flags
                    bgt       Code_09E2 ; branch when the signed value is above the limit
                    cmpb      Addr_000B ; compare against the limit and set condition flags
                    blt       Code_09E2 ; branch when the signed value is below the limit
                    cmpb      Addr_000C ; compare against the limit and set condition flags
                    bgt       Code_09E2 ; branch when the signed value is above the limit
                    suba      Addr_0009 ; subtract the operand from the running value
                    adda      Addr_003D ; add the operand to the running value
                    subb      Addr_000B ; subtract the operand from the running value
                    ldb       B,Y       ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    lbsr      Code_0B62 ; call the referenced helper routine
Code_09E2           lbsr      Code_0FB0 ; call the referenced helper routine
                    abx                 ; add the operand to the running value
                    bra       Code_09BF ; continue at the selected control-flow target
Code_09E8           bsr       Code_09EC ; call the referenced helper routine
                    puls      PC,Y,X,D  ; restore the listed registers from the stack
Code_09EC           tst       Addr_0006 ; set condition flags from the current value
                    beq       Code_09F1 ; branch when the compared values are equal
                    rts                 ; return to the caller
Code_09F1           ldb       Addr_0008 ; load the value needed by the following operation
                    beq       Code_09FD ; branch when the compared values are equal
                    subb      Addr_000B ; subtract the operand from the running value
                    leay      $0183,U   ; form the referenced address without reading memory
                    ldb       B,Y       ; load the value needed by the following operation
Code_09FD           lda       #$02      ; load the value needed by the following operation
                    tst       Addr_0007 ; set condition flags from the current value
                    beq       Code_0A09 ; branch when the compared values are equal
                    lda       Addr_0007 ; load the value needed by the following operation
                    suba      Addr_0009 ; subtract the operand from the running value
                    adda      Addr_003D ; add the operand to the running value
Code_0A09           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    leay      $008C,U   ; form the referenced address without reading memory
Code_0A11           ldb       Addr_0008 ; load the value needed by the following operation
                    ldb       B,Y       ; load the value needed by the following operation
                    clra                ; clear the selected byte or register
                    tfr       D,Y       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "$"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    lda       #$05      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    ldd       #Code_1601 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    ldd       Addr_0007 ; load the value needed by the following operation
                    lbsr      Code_0F2F ; call the referenced helper routine
                    stx       Addr_000D ; save the current value in working storage
                    bne       Code_0A8C ; branch when the compared values differ
                    tst       Addr_0007 ; set condition flags from the current value
                    beq       Code_0A7F ; branch when the compared values are equal
                    tst       Addr_0008 ; set condition flags from the current value
                    beq       Code_0A72 ; branch when the compared values are equal
                    leax      Data_0E16,PCR ; form the referenced address without reading memory
                    ldb       #$0A      ; load the value needed by the following operation
                    lbsr      Code_0EB7 ; call the referenced helper routine
                    ldb       #$0B      ; load the value needed by the following operation
Code_0A49           tst       Addr_004A ; set condition flags from the current value
                    bne       Code_0A4E ; branch when the compared values differ
                    aslb                ; shift left and update carry
Code_0A4E           lda       #$B2      ; load the value needed by the following operation
                    tfr       D,X       ; copy the source register into the destination register
                    pshs      B         ; preserve the listed registers on the stack
                    ldb       Addr_0046 ; load the value needed by the following operation
                    incb                ; advance the selected counter
                    tst       Addr_004A ; set condition flags from the current value
                    bne       Code_0A5C ; branch when the compared values differ
                    aslb                ; shift left and update carry
Code_0A5C           subb      ,S+       ; subtract the operand from the running value
                    lda       #$0E      ; load the value needed by the following operation
                    tfr       D,Y       ; copy the source register into the destination register
                    lda       #$55      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0E       ; private DeskMate service selector
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_0A72           leax      Data_0E20,PCR ; form the referenced address without reading memory
                    ldb       #$14      ; load the value needed by the following operation
                    lbsr      Code_0EB7 ; call the referenced helper routine
                    ldb       #$15      ; load the value needed by the following operation
                    bra       Code_0A49 ; continue at the selected control-flow target
Code_0A7F           leax      Data_0E34,PCR ; form the referenced address without reading memory
                    ldb       #$17      ; load the value needed by the following operation
                    lbsr      Code_0EB7 ; call the referenced helper routine
                    ldb       #$18      ; load the value needed by the following operation
                    bra       Code_0A49 ; continue at the selected control-flow target
Code_0A8C           lda       $02,X     ; load the value needed by the following operation
                    anda      #$C0      ; mask off unwanted bits
                    cmpa      #$80      ; compare against the limit and set condition flags
                    beq       Code_0AB1 ; branch when the compared values are equal
                    tsta                ; set condition flags from the current value
                    bne       Code_0AA4 ; branch when the compared values differ
                    leax      Data_0E0B,PCR ; form the referenced address without reading memory
                    ldb       #$05      ; load the value needed by the following operation
                    lbsr      Code_0EB7 ; call the referenced helper routine
                    ldb       #$06      ; load the value needed by the following operation
                    bra       Code_0A49 ; continue at the selected control-flow target
Code_0AA4           leax      Data_0E10,PCR ; form the referenced address without reading memory
                    ldb       #$06      ; load the value needed by the following operation
                    lbsr      Code_0EB7 ; call the referenced helper routine
                    ldb       #$07      ; load the value needed by the following operation
                    bra       Code_0A49 ; continue at the selected control-flow target
Code_0AB1           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    lda       #$05      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    ldb       $0D,X     ; load the value needed by the following operation
                    cmpb      #$03      ; compare against the limit and set condition flags
                    beq       Code_0B21 ; branch when the compared values are equal
                    clra                ; clear the selected byte or register
                    ldb       $02,X     ; load the value needed by the following operation
                    andb      #$3F      ; mask off unwanted bits
                    subb      #$0A      ; subtract the operand from the running value
                    tst       Addr_004A ; set condition flags from the current value
                    bne       Code_0AD3 ; branch when the compared values differ
                    cmpb      #$19      ; compare against the limit and set condition flags
                    ble       Code_0AD3 ; branch when the signed value is at or below the limit
                    ldd       #Code_0119 ; load the value needed by the following operation
Code_0AD3           pshs      A         ; preserve the listed registers on the stack
                    pshs      B         ; preserve the listed registers on the stack
                    pshs      X         ; preserve the listed registers on the stack
                    leax      $0E,X     ; form the referenced address without reading memory
                    lbsr      Code_0EB7 ; call the referenced helper routine
                    puls      X         ; restore the listed registers from the stack
                    ldb       Addr_0046 ; load the value needed by the following operation
                    subb      ,S        ; subtract the operand from the running value
                    ble       Code_0B01 ; branch when the signed value is at or below the limit
                    lda       #$0E      ; load the value needed by the following operation
                    tst       Addr_004A ; set condition flags from the current value
                    bne       Code_0AED ; branch when the compared values differ
                    aslb                ; shift left and update carry
Code_0AED           tfr       D,Y       ; copy the source register into the destination register
                    ldb       ,S        ; load the value needed by the following operation
                    incb                ; advance the selected counter
                    tst       Addr_004A ; set condition flags from the current value
                    bne       Code_0AF7 ; branch when the compared values differ
                    aslb                ; shift left and update carry
Code_0AF7           lda       #$B2      ; load the value needed by the following operation
                    tfr       D,X       ; copy the source register into the destination register
                    lda       #$55      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0E       ; private DeskMate service selector
Code_0B01           leas      $01,S     ; form the referenced address without reading memory
                    puls      A         ; restore the listed registers from the stack
Code_0B05           cmpa      #$01      ; compare against the limit and set condition flags
                    bne       Code_0B17 ; branch when the compared values differ
                    ldd       #Data_161B ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    lda       #$80      ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $01       ; private DeskMate service selector
Code_0B17           clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
Code_0B20           rts                 ; return to the caller
Code_0B21           leax      Data_0E4B,PCR ; form the referenced address without reading memory
                    ldb       #$0F      ; load the value needed by the following operation
                    lbsr      Code_0EB7 ; call the referenced helper routine
                    ldb       #$10      ; load the value needed by the following operation
                    lbra      Code_0A49 ; continue at the distant control-flow target
Code_0B2F           tst       Addr_0006 ; set condition flags from the current value
                    bne       Code_0B20 ; branch when the compared values differ
                    pshs      Y,X,D     ; preserve the listed registers on the stack
                    ldb       Addr_0008 ; load the value needed by the following operation
                    beq       Code_0B41 ; branch when the compared values are equal
                    subb      Addr_000B ; subtract the operand from the running value
                    leax      $0183,U   ; form the referenced address without reading memory
                    ldb       B,X       ; load the value needed by the following operation
Code_0B41           lda       #$02      ; load the value needed by the following operation
                    tst       Addr_0007 ; set condition flags from the current value
                    beq       Code_0B4D ; branch when the compared values are equal
                    lda       Addr_0007 ; load the value needed by the following operation
                    suba      Addr_0009 ; subtract the operand from the running value
                    adda      Addr_003D ; add the operand to the running value
Code_0B4D           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    leax      $008C,U   ; form the referenced address without reading memory
                    lda       Addr_0008 ; load the value needed by the following operation
                    ldb       A,X       ; load the value needed by the following operation
                    clra                ; clear the selected byte or register
                    tfr       D,Y       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "$"                            ; embedded text or resource bytes
                    puls      PC,Y,X,D  ; restore the listed registers from the stack
Code_0B62           pshs      Y,X,D     ; preserve the listed registers on the stack
                    lda       $01,X     ; load the value needed by the following operation
                    leax      $02,X     ; form the referenced address without reading memory
                    leay      $008C,U   ; form the referenced address without reading memory
                    ldb       A,Y       ; load the value needed by the following operation
                    leay      $01C9,U   ; form the referenced address without reading memory
                    pshs      B         ; preserve the listed registers on the stack
                    lda       #$20      ; load the value needed by the following operation
Code_0B76           sta       ,Y+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bne       Code_0B76 ; branch when the compared values differ
                    leay      $01C9,U   ; form the referenced address without reading memory
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    tfr       A,B       ; copy the source register into the destination register
                    anda      #$C0      ; mask off unwanted bits
                    bne       Code_0B9F ; branch when the compared values differ
                    andb      #$3F      ; mask off unwanted bits
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    bmi       Code_0B99 ; branch while the tested value is negative
                    cmpb      ,S        ; compare against the limit and set condition flags
                    bge       Code_0B99 ; branch when the signed value is at least the limit
                    lda       ,S        ; load the value needed by the following operation
                    pshs      B         ; preserve the listed registers on the stack
                    suba      ,S+       ; subtract the operand from the running value
                    leay      A,Y       ; form the referenced address without reading memory
Code_0B99           lbsr      Code_0FB7 ; call the referenced helper routine
                    lbra      Code_0BE6 ; continue at the distant control-flow target
Code_0B9F           cmpa      #$40      ; compare against the limit and set condition flags
                    beq       Code_0BCA ; branch when the compared values are equal
                    lda       $0A,X     ; load the value needed by the following operation
                    beq       Code_0BCA ; branch when the compared values are equal
                    cmpa      #$02      ; compare against the limit and set condition flags
                    bne       Code_0BB3 ; branch when the compared values differ
                    leax      Data_0DFF,PCR ; form the referenced address without reading memory
                    ldb       #$03      ; load the value needed by the following operation
                    bra       Code_0BC5 ; continue at the selected control-flow target
Code_0BB3           cmpa      #$04      ; compare against the limit and set condition flags
                    bne       Code_0BBF ; branch when the compared values differ
                    leax      Data_0E02,PCR ; form the referenced address without reading memory
                    ldb       #$09      ; load the value needed by the following operation
                    bra       Code_0BC5 ; continue at the selected control-flow target
Code_0BBF           leax      Data_0DF9,PCR ; form the referenced address without reading memory
                    ldb       #$06      ; load the value needed by the following operation
Code_0BC5           lbsr      Code_0FB7 ; call the referenced helper routine
                    bra       Code_0BE6 ; continue at the selected control-flow target
Code_0BCA           bsr       Code_0C02 ; call the referenced helper routine
                    leay      $0354,U   ; form the referenced address without reading memory
                    ldb       ,S        ; load the value needed by the following operation
                    cmpb      Addr_0010 ; compare against the limit and set condition flags
                    blt       Code_0BF5 ; branch when the signed value is below the limit
                    subb      Addr_0010 ; subtract the operand from the running value
                    lda       Addr_0010 ; load the value needed by the following operation
                    tst       Addr_004C ; set condition flags from the current value
                    beq       Code_0BDF ; branch when the compared values are equal
                    abx                 ; add the operand to the running value
Code_0BDF           ldb       ,Y+       ; fetch the next value and advance the source pointer
                    stb       ,X+       ; store the value and advance the destination pointer
                    deca                ; decrement the selected counter
                    bgt       Code_0BDF ; branch when the signed value is above the limit
Code_0BE6           puls      B         ; restore the listed registers from the stack
                    leax      $01C9,U   ; form the referenced address without reading memory
                    tst       Addr_000F ; set condition flags from the current value
                    bne       Code_0BF3 ; branch when the compared values differ
                    lbsr      Code_0EB7 ; call the referenced helper routine
Code_0BF3           puls      PC,Y,X,D  ; restore the listed registers from the stack
Code_0BF5           lda       #$2A      ; load the value needed by the following operation
                    ldb       ,S        ; load the value needed by the following operation
                    leax      $01C9,U   ; form the referenced address without reading memory
                    lbsr      Code_10BE ; call the referenced helper routine
                    bra       Code_0BE6 ; continue at the selected control-flow target
Code_0C02           ldb       #$07      ; load the value needed by the following operation
                    pshs      Y         ; preserve the listed registers on the stack
                    leay      $0354,U   ; form the referenced address without reading memory
                    pshs      Y         ; preserve the listed registers on the stack
                    clr       Addr_0010 ; clear the selected byte or register
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    pshs      A         ; preserve the listed registers on the stack
                    anda      #$08      ; mask off unwanted bits
                    beq       Code_0C1C ; branch when the compared values are equal
                    lda       #$2D      ; load the value needed by the following operation
                    sta       ,Y+       ; store the value and advance the destination pointer
                    inc       Addr_0010 ; advance the selected counter
Code_0C1C           lda       ,X        ; load the value needed by the following operation
                    bne       Code_0C2D ; branch when the compared values differ
                    leax      $01,X     ; form the referenced address without reading memory
                    decb                ; decrement the selected counter
                    bgt       Code_0C1C ; branch when the signed value is above the limit
                    lda       #$30      ; load the value needed by the following operation
                    sta       ,Y+       ; store the value and advance the destination pointer
                    inc       Addr_0010 ; advance the selected counter
                    bra       Code_0C32 ; continue at the selected control-flow target
Code_0C2D           clr       Addr_004C ; clear the selected byte or register
                    lbsr      Code_0E91 ; call the referenced helper routine
Code_0C32           lda       #$2E      ; load the value needed by the following operation
                    sta       ,Y+       ; store the value and advance the destination pointer
                    inc       Addr_0010 ; advance the selected counter
                    ldd       #Code_0102 ; load the value needed by the following operation
                    sta       Addr_004C ; save the current value in working storage
                    lbsr      Code_0E91 ; call the referenced helper routine
                    clr       Addr_004C ; clear the selected byte or register
                    puls      A         ; restore the listed registers from the stack
                    tsta                ; set condition flags from the current value
                    blt       Code_0C4B ; branch when the signed value is below the limit
                    ldb       #$01      ; load the value needed by the following operation
                    stb       Addr_004C ; save the current value in working storage
Code_0C4B           anda      #$07      ; mask off unwanted bits
                    ldb       #$04      ; load the value needed by the following operation
                    pshs      A         ; preserve the listed registers on the stack
                    subb      ,S+       ; subtract the operand from the running value
                    cmpb      #$04      ; compare against the limit and set condition flags
                    bne       Code_0C58 ; branch when the compared values differ
                    incb                ; advance the selected counter
Code_0C58           pshs      B         ; preserve the listed registers on the stack
                    ldb       Addr_0010 ; load the value needed by the following operation
                    subb      ,S+       ; subtract the operand from the running value
                    stb       Addr_0010 ; save the current value in working storage
                    ldy       ,S        ; load the value needed by the following operation
                    lda       ,Y+       ; fetch the next value and advance the source pointer
                    cmpa      #$2D      ; compare against the limit and set condition flags
                    bne       Code_0C84 ; branch when the compared values differ
                    decb                ; decrement the selected counter
Code_0C6A           lda       ,Y+       ; fetch the next value and advance the source pointer
                    cmpa      #$2E      ; compare against the limit and set condition flags
                    beq       Code_0C74 ; branch when the compared values are equal
                    cmpa      #$30      ; compare against the limit and set condition flags
                    bne       Code_0C84 ; branch when the compared values differ
Code_0C74           decb                ; decrement the selected counter
                    bgt       Code_0C6A ; branch when the signed value is above the limit
                    ldb       Addr_0010 ; load the value needed by the following operation
                    decb                ; decrement the selected counter
                    stb       Addr_0010 ; save the current value in working storage
                    ldy       ,S        ; load the value needed by the following operation
                    leax      $01,Y     ; form the referenced address without reading memory
                    lbsr      Code_0FB7 ; call the referenced helper routine
Code_0C84           ldb       Addr_0010 ; load the value needed by the following operation
                    leas      $02,S     ; form the referenced address without reading memory
                    puls      PC,X      ; restore the listed registers from the stack
Code_0C8A           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    lda       #$02      ; load the value needed by the following operation
                    sta       Data_0029 ; save the current value in working storage
                    lda       Addr_0007 ; load the value needed by the following operation
                    suba      Addr_0009 ; subtract the operand from the running value
                    adda      Addr_003D ; add the operand to the running value
                    pshs      A         ; preserve the listed registers on the stack
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    ldb       Addr_0007 ; load the value needed by the following operation
                    bsr       Code_0CCF ; call the referenced helper routine
                    ldx       Addr_0002 ; load the value needed by the following operation
                    leay      $0183,U   ; form the referenced address without reading memory
Code_0CA9           ldd       ,X        ; load the value needed by the following operation
                    blt       Code_0CCC ; branch when the signed value is below the limit
                    cmpa      Addr_0007 ; compare against the limit and set condition flags
                    bne       Code_0CC6 ; branch when the compared values differ
                    cmpb      Addr_000B ; compare against the limit and set condition flags
                    blt       Code_0CC6 ; branch when the signed value is below the limit
                    cmpb      Addr_000C ; compare against the limit and set condition flags
                    bgt       Code_0CC6 ; branch when the signed value is above the limit
                    subb      Addr_000B ; subtract the operand from the running value
                    ldb       B,Y       ; load the value needed by the following operation
                    lda       ,S        ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    lbsr      Code_0B62 ; call the referenced helper routine
Code_0CC6           lbsr      Code_0FB0 ; call the referenced helper routine
                    abx                 ; add the operand to the running value
                    bra       Code_0CA9 ; continue at the selected control-flow target
Code_0CCC           leas      $01,S     ; form the referenced address without reading memory
                    rts                 ; return to the caller
Code_0CCF           pshs      D         ; preserve the listed registers on the stack
                    clr       Code_004D ; clear the selected byte or register
Code_0CD3           cmpb      #$0A      ; compare against the limit and set condition flags
                    blt       Code_0CDD ; branch when the signed value is below the limit
                    subb      #$0A      ; subtract the operand from the running value
                    inc       Code_004D ; advance the selected counter
                    bra       Code_0CD3 ; continue at the selected control-flow target
Code_0CDD           tst       Code_004D ; set condition flags from the current value
                    bne       Code_0CEE ; branch when the compared values differ
                    pshs      B         ; preserve the listed registers on the stack
                    ldd       #Code_2040 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $02       ; private DeskMate service selector
                    puls      A         ; restore the listed registers from the stack
                    bra       Code_0CFC ; continue at the selected control-flow target
Code_0CEE           lda       Code_004D ; load the value needed by the following operation
                    adda      #$30      ; add the operand to the running value
                    pshs      B         ; preserve the listed registers on the stack
                    ldb       #$40      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $02       ; private DeskMate service selector
                    puls      A         ; restore the listed registers from the stack
Code_0CFC           adda      #$30      ; add the operand to the running value
                    ldb       #$40      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $02       ; private DeskMate service selector
                    puls      PC,D      ; restore the listed registers from the stack
Code_0D06           pshs      Y,X,B     ; preserve the listed registers on the stack
                    clra                ; clear the selected byte or register
                    subb      Addr_0010 ; subtract the operand from the running value
                    tfr       D,Y       ; copy the source register into the destination register
                    ldb       #$40      ; load the value needed by the following operation
                    leax      $01F1,U   ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $22       ; private DeskMate service selector
                    ldb       ,S        ; load the value needed by the following operation
                    addb      #$02      ; add the operand to the running value
                    stb       Addr_0010 ; save the current value in working storage
                    puls      Y,X,B     ; restore the listed registers from the stack
                    lda       #$02      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    ldb       $02,S     ; load the value needed by the following operation
                    bsr       Code_0CCF ; call the referenced helper routine
                    rts                 ; return to the caller
Code_0D2A           leax      $01F1,U   ; form the referenced address without reading memory
                    ldd       #Code_2050 ; load the value needed by the following operation
                    lbsr      Code_10BE ; call the referenced helper routine
                    lda       #$02      ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    clr       Addr_0010 ; clear the selected byte or register
                    ldb       Addr_000B ; load the value needed by the following operation
                    leax      $008C,U   ; form the referenced address without reading memory
                    leay      $0183,U   ; form the referenced address without reading memory
                    clr       Addr_004C ; clear the selected byte or register
                    pshs      Y,B       ; preserve the listed registers on the stack
Code_0D4B           lda       B,X       ; load the value needed by the following operation
                    lsra                ; shift right and expose the low bit through carry
                    ldb       Addr_004C ; load the value needed by the following operation
                    adda      B,Y       ; add the operand to the running value
                    tfr       A,B       ; copy the source register into the destination register
                    bsr       Code_0D06 ; call the referenced helper routine
                    inc       Addr_004C ; advance the selected counter
                    inc       ,S        ; advance the selected counter
                    ldb       ,S        ; load the value needed by the following operation
                    cmpb      Addr_000C ; compare against the limit and set condition flags
                    ble       Code_0D4B ; branch when the signed value is at or below the limit
                    leas      $03,S     ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0C       ; private DeskMate service selector
                    tfr       X,D       ; copy the source register into the destination register
                    clra                ; clear the selected byte or register
                    pshs      D         ; preserve the listed registers on the stack
                    ldb       Addr_0046 ; load the value needed by the following operation
                    incb                ; advance the selected counter
                    subd      ,S++      ; subtract the operand from the running value
                    beq       Code_0D7E ; branch when the compared values are equal
                    tfr       D,Y       ; copy the source register into the destination register
                    leax      $01F1,U   ; form the referenced address without reading memory
                    ldb       #$40      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $22       ; private DeskMate service selector
Code_0D7E           ldx       #Addr_1800 ; load the value needed by the following operation
                    ldy       #Data_0802 ; load the value needed by the following operation
                    tst       Addr_004A ; set condition flags from the current value
                    bne       Code_0D8B ; branch when the compared values differ
                    leay      $02,Y     ; form the referenced address without reading memory
Code_0D8B           lda       #$FF      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0E       ; private DeskMate service selector
                    leax      $02,X     ; form the referenced address without reading memory
                    ldy       #Data_084E ; load the value needed by the following operation
                    tst       Addr_004A ; set condition flags from the current value
                    bne       Code_0D9F ; branch when the compared values differ
                    leax      $02,X     ; form the referenced address without reading memory
                    leay      -$02,Y    ; form the referenced address without reading memory
Code_0D9F           clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0E       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_0DA5           pshs      Y,X,D     ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    lda       #$03      ; load the value needed by the following operation
                    sta       Data_0029 ; save the current value in working storage
                    lbsr      Code_0D2A ; call the referenced helper routine
                    leay      $0183,U   ; form the referenced address without reading memory
                    ldb       Addr_0008 ; load the value needed by the following operation
                    pshs      B         ; preserve the listed registers on the stack
Code_0DBA           subb      Addr_000B ; subtract the operand from the running value
                    ldb       B,Y       ; load the value needed by the following operation
                    pshs      B         ; preserve the listed registers on the stack
                    ldx       Addr_0002 ; load the value needed by the following operation
Code_0DC2           ldd       ,X        ; load the value needed by the following operation
                    blt       Code_0DE5 ; branch when the signed value is below the limit
                    cmpb      $01,S     ; compare against the limit and set condition flags
                    bne       Code_0DDF ; branch when the compared values differ
                    cmpa      Addr_0009 ; compare against the limit and set condition flags
                    blt       Code_0DDF ; branch when the signed value is below the limit
                    cmpa      Addr_000A ; compare against the limit and set condition flags
                    bgt       Code_0DDF ; branch when the signed value is above the limit
                    suba      Addr_0009 ; subtract the operand from the running value
                    adda      Addr_003D ; add the operand to the running value
                    ldb       ,S        ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    lbsr      Code_0B62 ; call the referenced helper routine
Code_0DDF           lbsr      Code_0FB0 ; call the referenced helper routine
                    abx                 ; add the operand to the running value
                    bra       Code_0DC2 ; continue at the selected control-flow target
Code_0DE5           leas      $01,S     ; form the referenced address without reading memory
                    dec       $01,S     ; decrement the selected counter
                    beq       Code_0DF5 ; branch when the compared values are equal
                    inc       ,S        ; advance the selected counter
                    ldb       ,S        ; load the value needed by the following operation
                    leay      $0183,U   ; form the referenced address without reading memory
                    bra       Code_0DBA ; continue at the selected control-flow target
Code_0DF5           leas      $01,S     ; form the referenced address without reading memory
                    puls      PC,Y,X,D  ; restore the listed registers from the stack
Data_0DF9           fcc       "*Error"                       ; embedded text or resource bytes
Data_0DFF           fcc       "*F*"                          ; embedded text or resource bytes
Data_0E02           fcc       "*Ove"                         ; embedded text or resource bytes
Data_0E06           fcc       "rflow"                        ; embedded text or resource bytes
Data_0E0B           fcc       "Label"                        ; embedded text or resource bytes
Data_0E10           fcc       "Number"                       ; embedded text or resource bytes
Data_0E16           fcc       "Empty cell"                   ; embedded text or resource bytes
Data_0E20           fcc       "Marker on row margin"         ; embedded text or resource bytes
Data_0E34           fcc       "Marker on column marg"        ; embedded text or resource bytes
                    fcc       "in"                           ; embedded text or resource bytes
Data_0E4B           fcc       "Inv"                          ; embedded text or resource bytes
Data_0E4E           fcc       "al"                           ; embedded text or resource bytes
Data_0E50           fcc       "id formula"                   ; embedded text or resource bytes
Code_0E5A           pshs      Y,X,D     ; preserve the listed registers on the stack
                    leax      $008C,U   ; form the referenced address without reading memory
                    leay      $0183,U   ; form the referenced address without reading memory
                    ldb       Addr_000B ; load the value needed by the following operation
                    lda       Data_003E ; load the value needed by the following operation
Code_0E68           sta       ,Y+       ; store the value and advance the destination pointer
                    adda      B,X       ; add the operand to the running value
                    cmpa      Addr_0040 ; compare against the limit and set condition flags
                    bgt       Code_0E77 ; branch when the signed value is above the limit
                    stb       Addr_000C ; save the current value in working storage
                    incb                ; advance the selected counter
                    cmpb      #$63      ; compare against the limit and set condition flags
                    ble       Code_0E68 ; branch when the signed value is at or below the limit
Code_0E77           puls      PC,Y,X,D  ; restore the listed registers from the stack
Code_0E79           ldb       Addr_000C ; load the value needed by the following operation
                    leax      $008C,U   ; form the referenced address without reading memory
                    lda       B,X       ; load the value needed by the following operation
Code_0E81           decb                ; decrement the selected counter
                    cmpb      #$01      ; compare against the limit and set condition flags
                    blt       Code_0E8C ; branch when the signed value is below the limit
                    adda      B,X       ; add the operand to the running value
                    cmpa      Code_003F ; compare against the limit and set condition flags
                    ble       Code_0E81 ; branch when the signed value is at or below the limit
Code_0E8C           incb                ; advance the selected counter
                    stb       Addr_000B ; save the current value in working storage
                    bra       Code_0E5A ; continue at the selected control-flow target
Code_0E91           lda       ,X        ; load the value needed by the following operation
                    anda      #$F0      ; mask off unwanted bits
                    lsra                ; shift right and expose the low bit through carry
                    lsra                ; shift right and expose the low bit through carry
                    lsra                ; shift right and expose the low bit through carry
                    lsra                ; shift right and expose the low bit through carry
                    adda      #$30      ; add the operand to the running value
                    tst       Addr_004C ; set condition flags from the current value
                    bne       Code_0EA5 ; branch when the compared values differ
                    inc       Addr_004C ; advance the selected counter
                    cmpa      #$30      ; compare against the limit and set condition flags
                    beq       Code_0EA9 ; branch when the compared values are equal
Code_0EA5           sta       ,Y+       ; store the value and advance the destination pointer
                    inc       Addr_0010 ; advance the selected counter
Code_0EA9           lda       ,X+       ; fetch the next value and advance the source pointer
                    anda      #$0F      ; mask off unwanted bits
                    adda      #$30      ; add the operand to the running value
                    sta       ,Y+       ; store the value and advance the destination pointer
                    inc       Addr_0010 ; advance the selected counter
                    decb                ; decrement the selected counter
                    bne       Code_0E91 ; branch when the compared values differ
                    rts                 ; return to the caller
Code_0EB7           pshs      Y,A       ; preserve the listed registers on the stack
                    clra                ; clear the selected byte or register
                    tfr       D,Y       ; copy the source register into the destination register
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $22       ; private DeskMate service selector
                    puls      PC,Y,A    ; restore the listed registers from the stack
Code_0EC3           pshs      Y,X,D     ; preserve the listed registers on the stack
                    leax      Data_126A,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    lda       #$10      ; load the value needed by the following operation
                    cmpb      #$07      ; compare against the limit and set condition flags
                    bne       Code_0ED7 ; branch when the compared values differ
                    ldb       #$04      ; load the value needed by the following operation
                    bra       Code_0ED9 ; continue at the selected control-flow target
Code_0ED7           ldb       #$08      ; load the value needed by the following operation
Code_0ED9           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    leax      $10,X     ; form the referenced address without reading memory
                    ldb       $01,S     ; load the value needed by the following operation
                    decb                ; decrement the selected counter
                    aslb                ; shift left and update carry
                    ldd       B,X       ; load the value needed by the following operation
                    leax      $0E,X     ; form the referenced address without reading memory
                    leax      D,X       ; form the referenced address without reading memory
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "6"                            ; embedded text or resource bytes
                    ldd       #Data_1207 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      Data_1317,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    ldb       #$80      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1C       ; private DeskMate service selector
                    lbsr      Code_4975 ; call the referenced helper routine
                    ldu       DeskMateService ; load the value needed by the following operation
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    tst       Addr_0006 ; set condition flags from the current value
                    bne       Code_0F2D ; branch when the compared values differ
                    tst       Addr_0036 ; set condition flags from the current value
                    beq       Code_0F22 ; branch when the compared values are equal
                    lda       #$0A      ; load the value needed by the following operation
                    sta       Addr_001F ; save the current value in working storage
                    bra       Code_0F2D ; continue at the selected control-flow target
Code_0F22           lda       #$05      ; load the value needed by the following operation
                    sta       Addr_001F ; save the current value in working storage
                    lda       #$0F      ; load the value needed by the following operation
                    sta       Code_001E ; save the current value in working storage
                    lbsr      Code_45F3 ; call the referenced helper routine
Code_0F2D           puls      PC,Y,X,D  ; restore the listed registers from the stack
Code_0F2F           pshs      D         ; preserve the listed registers on the stack
                    ldx       Addr_0002 ; load the value needed by the following operation
Code_0F33           ldd       ,X        ; load the value needed by the following operation
                    blt       Code_0F45 ; branch when the signed value is below the limit
                    cmpd      ,S        ; compare against the limit and set condition flags
                    beq       Code_0F48 ; branch when the compared values are equal
                    ldb       $02,X     ; load the value needed by the following operation
                    andb      #$3F      ; mask off unwanted bits
                    addb      #$04      ; add the operand to the running value
                    abx                 ; add the operand to the running value
                    bra       Code_0F33 ; continue at the selected control-flow target
Code_0F45           ldx       #DeskMateService ; load the value needed by the following operation
Code_0F48           puls      PC,D      ; restore the listed registers from the stack
Code_0F4A           ldy       Addr_000D ; load the value needed by the following operation
                    beq       Code_0F51 ; branch when the compared values are equal
                    bsr       Code_0F7C ; call the referenced helper routine
Code_0F51           clra                ; clear the selected byte or register
                    pshs      D         ; preserve the listed registers on the stack
                    cmpd      Addr_0013 ; compare against the limit and set condition flags
                    bgt       Code_0F73 ; branch when the signed value is above the limit
                    ldd       Addr_0013 ; load the value needed by the following operation
                    subd      ,S        ; subtract the operand from the running value
                    std       Addr_0013 ; save the current value in working storage
                    puls      D         ; restore the listed registers from the stack
                    ldy       Addr_0004 ; load the value needed by the following operation
                    sty       Addr_000D ; save the current value in working storage
                    bsr       Code_0FB7 ; call the referenced helper routine
                    lda       #$FF      ; load the value needed by the following operation
                    sta       ,Y        ; save the current value in working storage
                    sty       Addr_0004 ; save the current value in working storage
                    lda       #$01      ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_0F73           leas      $02,S     ; form the referenced address without reading memory
                    ldb       #$01      ; load the value needed by the following operation
                    lbsr      Code_0EC3 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    rts                 ; return to the caller
Code_0F7C           pshs      X,B       ; preserve the listed registers on the stack
                    tfr       Y,X       ; copy the source register into the destination register
                    bsr       Code_0FB0 ; call the referenced helper routine
                    abx                 ; add the operand to the running value
                    clra                ; clear the selected byte or register
                    pshs      D         ; preserve the listed registers on the stack
                    ldd       Addr_0004 ; load the value needed by the following operation
                    pshs      X         ; preserve the listed registers on the stack
                    subd      ,S++      ; subtract the operand from the running value
                    beq       Code_0F9F ; branch when the compared values are equal
                    leas      -$01,S    ; form the referenced address without reading memory
Code_0F90           sta       ,S        ; save the current value in working storage
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,Y+       ; store the value and advance the destination pointer
                    lda       ,S        ; load the value needed by the following operation
                    subd      #Addr_0001 ; subtract the operand from the running value
                    bgt       Code_0F90 ; branch when the signed value is above the limit
                    leas      $01,S     ; form the referenced address without reading memory
Code_0F9F           std       Addr_000D ; save the current value in working storage
                    ldd       Addr_0013 ; load the value needed by the following operation
                    addd      ,S++      ; add the operand to the running value
                    std       Addr_0013 ; save the current value in working storage
                    sty       Addr_0004 ; save the current value in working storage
                    ldb       #$FF      ; load the value needed by the following operation
                    stb       ,Y        ; save the current value in working storage
                    puls      PC,X,B    ; restore the listed registers from the stack
Code_0FB0           ldb       $02,X     ; load the value needed by the following operation
                    andb      #$3F      ; mask off unwanted bits
                    addb      #$04      ; add the operand to the running value
                    rts                 ; return to the caller
Code_0FB7           lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,Y+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bgt       Code_0FB7 ; branch when the signed value is above the limit
                    rts                 ; return to the caller
Code_0FBF           tst       Addr_0007 ; set condition flags from the current value
                    beq       Code_0FC4 ; branch when the compared values are equal
                    rts                 ; return to the caller
Code_0FC4           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    leax      Data_11D4,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    tfr       Y,D       ; copy the source register into the destination register
                    ldx       #DeskMateService ; load the value needed by the following operation
                    tfr       X,Y       ; copy the source register into the destination register
                    lbsr      start     ;0FD7: 17 F0 3B       '.. ; call the referenced helper routine
                    fcc       "D"                            ; embedded text or resource bytes
                    tfr       D,Y       ; copy the source register into the destination register
                    leax      Data_11DC,PCR ; form the referenced address without reading memory
                    ldb       #$13      ; load the value needed by the following operation
                    lbsr      Code_0EB7 ; call the referenced helper routine
                    lda       Addr_0008 ; load the value needed by the following operation
                    leax      $008C,U   ; form the referenced address without reading memory
                    ldb       A,X       ; load the value needed by the following operation
                    clra                ; clear the selected byte or register
                    cmpb      #$0A      ; compare against the limit and set condition flags
                    blt       Code_0FFD ; branch when the signed value is below the limit
                    inca                ; advance the selected counter
                    subb      #$0A      ; subtract the operand from the running value
                    cmpb      #$0A      ; compare against the limit and set condition flags
                    blt       Code_0FFD ; branch when the signed value is below the limit
                    inca                ; advance the selected counter
                    subb      #$0A      ; subtract the operand from the running value
Code_0FFD           addd      #Code_3030 ; add the operand to the running value
                    std       Addr_004C ; save the current value in working storage
                    ldd       #Data_5006 ; load the value needed by the following operation
                    leax      Data_11FE,PCR ; form the referenced address without reading memory
                    lbsr      Code_4679 ; call the referenced helper routine
                    ldd       #Code_0A09 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
Code_1013           leax      Data_11EF,PCR ; form the referenced address without reading memory
                    ldb       #$04      ; load the value needed by the following operation
                    lbsr      Code_0EB7 ; call the referenced helper routine
                    ldd       #Data_500E ; load the value needed by the following operation
                    leax      Data_1234,PCR ; form the referenced address without reading memory
                    lbsr      Code_4679 ; call the referenced helper routine
                    ldd       #Code_0A11 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    leax      Data_11F3,PCR ; form the referenced address without reading memory
                    ldb       #$0B      ; load the value needed by the following operation
                    lbsr      Code_0EB7 ; call the referenced helper routine
Code_1036           leax      $01C9,U   ; form the referenced address without reading memory
                    ldd       Addr_004C ; load the value needed by the following operation
                    std       ,X        ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    sta       $02,X     ; save the current value in working storage
                    pshs      Y,X       ; preserve the listed registers on the stack
                    ldx       #Addr_0014 ; load the value needed by the following operation
                    ldy       #DeskMateService ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    puls      Y,X       ; restore the listed registers from the stack
                    ldd       #Addr_8200 ; load the value needed by the following operation
                    lbsr      Code_118E ; call the referenced helper routine
                    cmpa      #$05      ; compare against the limit and set condition flags
                    beq       Code_10A7 ; branch when the compared values are equal
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    bne       Code_1036 ; branch when the compared values differ
                    ldd       ,X        ; load the value needed by the following operation
                    suba      #$30      ; subtract the operand from the running value
                    blt       Code_1036 ; branch when the signed value is below the limit
                    cmpa      #$09      ; compare against the limit and set condition flags
                    bgt       Code_1036 ; branch when the signed value is above the limit
                    subb      #$30      ; subtract the operand from the running value
                    blt       Code_1036 ; branch when the signed value is below the limit
                    cmpb      #$09      ; compare against the limit and set condition flags
                    bgt       Code_1036 ; branch when the signed value is above the limit
                    pshs      B         ; preserve the listed registers on the stack
                    tfr       A,B       ; copy the source register into the destination register
                    lda       #$0A      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    addb      ,S+       ; add the operand to the running value
                    cmpb      #$03      ; compare against the limit and set condition flags
                    blt       Code_1036 ; branch when the signed value is below the limit
                    cmpb      #$1C      ; compare against the limit and set condition flags
                    bgt       Code_1036 ; branch when the signed value is above the limit
                    stb       Addr_004C ; save the current value in working storage
                    ldd       #Data_5006 ; load the value needed by the following operation
                    ldx       #Data_500E ; load the value needed by the following operation
                    bsr       Code_10C4 ; call the referenced helper routine
                    lda       Code_004D ; load the value needed by the following operation
                    bmi       Code_10A7 ; branch while the tested value is negative
                    bne       Code_109D ; branch when the compared values differ
                    lda       Addr_004C ; load the value needed by the following operation
                    ldb       Addr_0008 ; load the value needed by the following operation
                    leax      $008C,U   ; form the referenced address without reading memory
                    sta       B,X       ; save the current value in working storage
                    bra       Code_10A7 ; continue at the selected control-flow target
Code_109D           leax      $008D,U   ; form the referenced address without reading memory
                    ldb       #$63      ; load the value needed by the following operation
                    lda       Addr_004C ; load the value needed by the following operation
                    bsr       Code_10BE ; call the referenced helper routine
Code_10A7           clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    lbsr      Code_0E5A ; call the referenced helper routine
                    lda       Addr_0008 ; load the value needed by the following operation
                    cmpa      Addr_000C ; compare against the limit and set condition flags
                    ble       Code_10BA ; branch when the signed value is at or below the limit
                    sta       Addr_000B ; save the current value in working storage
                    lbsr      Code_0E5A ; call the referenced helper routine
Code_10BA           lbsr      Code_094E ; call the referenced helper routine
                    rts                 ; return to the caller
Code_10BE           sta       ,X+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bgt       Code_10BE ; branch when the signed value is above the limit
                    rts                 ; return to the caller
Code_10C4           pshs      X,D       ; preserve the listed registers on the stack
                    clr       Code_004D ; clear the selected byte or register
                    clr       ,-S       ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $16       ; private DeskMate service selector
Code_10CE           ldd       $01,S     ; load the value needed by the following operation
                    leax      Data_11FE,PCR ; form the referenced address without reading memory
                    tst       Code_004D ; set condition flags from the current value
                    beq       Code_10DC ; branch when the compared values are equal
                    leax      Data_1234,PCR ; form the referenced address without reading memory
Code_10DC           lbsr      Code_4679 ; call the referenced helper routine
                    ldd       $03,S     ; load the value needed by the following operation
                    leax      Data_11FE,PCR ; form the referenced address without reading memory
                    tst       Code_004D ; set condition flags from the current value
                    bne       Code_10ED ; branch when the compared values differ
                    leax      Data_1234,PCR ; form the referenced address without reading memory
Code_10ED           lbsr      Code_4679 ; call the referenced helper routine
Code_10F0           clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    beq       Code_1117 ; branch when the compared values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    bne       Code_1101 ; branch when the compared values differ
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Code_004D ; save the current value in working storage
                    bra       Code_1160 ; continue at the selected control-flow target
Code_1101           cmpa      #$0D      ; compare against the limit and set condition flags
                    beq       Code_1160 ; branch when the compared values are equal
                    cmpa      #$08      ; compare against the limit and set condition flags
                    bne       Code_110D ; branch when the compared values differ
                    clr       Code_004D ; clear the selected byte or register
                    bra       Code_116C ; continue at the selected control-flow target
Code_110D           cmpa      #$09      ; compare against the limit and set condition flags
                    bne       Code_10F0 ; branch when the compared values differ
                    lda       #$01      ; load the value needed by the following operation
                    sta       Code_004D ; save the current value in working storage
                    bra       Code_116C ; continue at the selected control-flow target
Code_1117           lbsr      Code_4975 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    tfr       D,Y       ; copy the source register into the destination register
                    tfr       U,D       ; copy the source register into the destination register
                    ldu       DeskMateService ; load the value needed by the following operation
                    asla                ; shift left and update carry
                    asla                ; shift left and update carry
                    asla                ; shift left and update carry
                    adda      #$0C      ; add the operand to the running value
                    cmpa      $01,S     ; compare against the limit and set condition flags
                    blt       Code_1168 ; branch when the signed value is below the limit
                    pshs      A         ; preserve the listed registers on the stack
                    lda       Addr_000F ; load the value needed by the following operation
                    cmpa      #$02      ; compare against the limit and set condition flags
                    puls      A         ; restore the listed registers from the stack
                    bne       Code_1136 ; branch when the compared values differ
                    suba      #$08      ; subtract the operand from the running value
Code_1136           suba      #$18      ; subtract the operand from the running value
                    cmpa      $01,S     ; compare against the limit and set condition flags
                    bgt       Code_1168 ; branch when the signed value is above the limit
                    addb      #$03      ; add the operand to the running value
                    cmpb      $02,S     ; compare against the limit and set condition flags
                    blt       Code_1168 ; branch when the signed value is below the limit
                    subb      #$06      ; subtract the operand from the running value
                    cmpb      $02,S     ; compare against the limit and set condition flags
                    bgt       Code_114C ; branch when the signed value is above the limit
                    clr       Code_004D ; clear the selected byte or register
                    bra       Code_115C ; continue at the selected control-flow target
Code_114C           addb      #$06      ; add the operand to the running value
                    cmpb      $04,S     ; compare against the limit and set condition flags
                    blt       Code_1168 ; branch when the signed value is below the limit
                    subb      #$06      ; subtract the operand from the running value
                    cmpb      $04,S     ; compare against the limit and set condition flags
                    bgt       Code_1168 ; branch when the signed value is above the limit
                    lda       #$01      ; load the value needed by the following operation
                    sta       Code_004D ; save the current value in working storage
Code_115C           leay      ,Y        ; form the referenced address without reading memory
                    beq       Code_116C ; branch when the compared values are equal
Code_1160           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    leas      $01,S     ; form the referenced address without reading memory
                    puls      PC,X,D    ; restore the listed registers from the stack
Code_1168           leay      ,Y        ; form the referenced address without reading memory
                    bne       Code_1179 ; branch when the compared values differ
Code_116C           lda       Code_004D ; load the value needed by the following operation
                    cmpa      ,S        ; compare against the limit and set condition flags
                    lbeq      Code_10F0 ; take the distant branch when values are equal
                    sta       ,S        ; save the current value in working storage
                    lbra      Code_10CE ; continue at the distant control-flow target
Code_1179           leas      $01,S     ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "E"                            ; embedded text or resource bytes
                    cmpx      #Addr_00FF ; compare against the limit and set condition flags
                    bne       Code_118C ; branch when the compared values differ
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Code_004D ; save the current value in working storage
Code_118C           puls      PC,X,D    ; restore the listed registers from the stack
Code_118E           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $16       ; private DeskMate service selector
                    lbsr      Code_4E40 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    bne       Code_11BB ; branch when the compared values differ
                    pshs      U,Y,X,D   ; preserve the listed registers on the stack
                    lbsr      Code_4975 ; call the referenced helper routine
                    cmpb      #$01      ; compare against the limit and set condition flags
                    bne       Code_11B3 ; branch when the compared values differ
                    tfr       U,D       ; copy the source register into the destination register
                    cmpa      $04,S     ; compare against the limit and set condition flags
                    ble       Code_11AF ; branch when the signed value is at or below the limit
                    cmpa      $05,S     ; compare against the limit and set condition flags
                    bgt       Code_11AF ; branch when the signed value is above the limit
                    lda       #$0D      ; load the value needed by the following operation
                    bra       Code_11B7 ; continue at the selected control-flow target
Code_11AF           lda       #$05      ; load the value needed by the following operation
                    bra       Code_11B7 ; continue at the selected control-flow target
Code_11B3           puls      U,Y,X,D   ; restore the listed registers from the stack
                    bra       Code_118E ; continue at the selected control-flow target
Code_11B7           leas      $06,S     ; form the referenced address without reading memory
                    puls      U         ; restore the listed registers from the stack
Code_11BB           pshs      A         ; preserve the listed registers on the stack
                    lda       #$FF      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1E       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    puls      PC,A      ; restore the listed registers from the stack
Code_11C9           pshs      D         ; preserve the listed registers on the stack
                    clrb                ; clear the selected byte or register
Code_11CC           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    bne       Code_11CC ; branch when the compared values differ
                    puls      PC,D      ; restore the listed registers from the stack
Data_11D4           fcb       $00,$05,$08,$18,$04,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $18       ; table, bitmap, or initialized data bytes
Data_11DC           fcc       "Change column width"          ; embedded text or resource bytes
Data_11EF           fcc       "this"                         ; embedded text or resource bytes
Data_11F3           fcc       "all columns"                  ; embedded text or resource bytes
Data_11FE           fcc       "("                            ; embedded text or resource bytes
                    fcb       $04,$08,$05 ; table, bitmap, or initialized data bytes
                    fcc       "U_"                           ; embedded text or resource bytes
                    fcb       $00,$05,$00 ; table, bitmap, or initialized data bytes
Data_1207           fcb       $0D,$00,$05,$00 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $00,$05,$00,$C5,$00,$04 ; table, bitmap, or initialized data bytes
                    fcb       $C3,$05,$00,$05 ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $05,$00,$05,$0F,$05,$00 ; table, bitmap, or initialized data bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
                    fcc       "UU"                           ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $02,$08   ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $9C       ; table, bitmap, or initialized data bytes
                    fcc       " p "                          ; embedded text or resource bytes
                    fcb       $C0       ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $A0       ; table, bitmap, or initialized data bytes
                    fcc       ";"                      ;122C: 3B             ' ; embedded text or resource bytes
                    fcb       $A0       ; table, bitmap, or initialized data bytes
                    fcc       "/ ' *"                        ; embedded text or resource bytes
                    fcb       $A0       ; table, bitmap, or initialized data bytes
Data_1234           fcc       "("                            ; embedded text or resource bytes
                    fcb       $04,$08,$05 ; table, bitmap, or initialized data bytes
                    fcc       "UU"                           ; embedded text or resource bytes
                    fcb       $00,$05,$00,$05,$00,$05 ; table, bitmap, or initialized data bytes
                    fcb       $00,$05,$00,$05,$00,$05 ; table, bitmap, or initialized data bytes
                    fcb       $00,$05,$00,$05,$00,$05 ; table, bitmap, or initialized data bytes
                    fcb       $00,$05,$00,$05,$00,$05 ; table, bitmap, or initialized data bytes
                    fcb       $00,$05   ; table, bitmap, or initialized data bytes
                    fcc       "UU"                           ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $02,$08   ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $A0       ; table, bitmap, or initialized data bytes
                    fcc       "            *"                ; embedded text or resource bytes
                    fcb       $A0       ; table, bitmap, or initialized data bytes
Data_126A           fcc       "("                            ; embedded text or resource bytes
                    fcb       $02,$0F,$1E,$05,$00,$AA ; table, bitmap, or initialized data bytes
                    fcb       $1C       ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $02,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $05,$00,$AA,$1C,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$12,$00,$26,$00 ; table, bitmap, or initialized data bytes
                    fcc       "7"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "D"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "nNot enough memory"           ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "Can't fit data here"          ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "Disk drive error"             ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "Device error"                 ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "Label/Formula not fou"        ; embedded text or resource bytes
                    fcc       "nd"                           ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "Incompatible file"            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "Disk full. Save on an"        ; embedded text or resource bytes
                    fcc       "other disk!"                  ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1317           fcc       "Press any key to canc"        ; embedded text or resource bytes
                    fcc       "el"                           ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_132F           pshs      Y,X,D     ; preserve the listed registers on the stack
                    lda       #$01      ; load the value needed by the following operation
                    sta       Addr_001A ; save the current value in working storage
                    leax      $0193,U   ; form the referenced address without reading memory
                    ldd       Addr_0007 ; load the value needed by the following operation
                    std       ,X++      ; store the value and advance the destination pointer
                    clra                ; clear the selected byte or register
                    sta       ,X+       ; store the value and advance the destination pointer
                    ldy       Addr_000D ; load the value needed by the following operation
                    beq       Code_1354 ; branch when the compared values are equal
                    ldb       $02,Y     ; load the value needed by the following operation
                    andb      #$C0      ; mask off unwanted bits
                    bne       Code_1354 ; branch when the compared values differ
                    ldb       $03,Y     ; load the value needed by the following operation
                    bmi       Code_1354 ; branch while the tested value is negative
                    clra                ; clear the selected byte or register
                    sta       ,X+       ; store the value and advance the destination pointer
                    bra       Code_1358 ; continue at the selected control-flow target
Code_1354           lda       #$80      ; load the value needed by the following operation
                    sta       ,X+       ; store the value and advance the destination pointer
Code_1358           lbsr      Code_15FF ; call the referenced helper routine
                    lbsr      Code_166E ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    sta       Addr_0012 ; save the current value in working storage
                    sta       Addr_0017 ; save the current value in working storage
Code_1363           lbsr      Code_164D ; call the referenced helper routine
Code_1366           leay      >Data_13DA,PCR ; form the referenced address without reading memory
                    aslb                ; shift left and update carry
                    jsr       B,Y       ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    bne       Code_137D ; branch when the compared values differ
                    lda       #$01      ; load the value needed by the following operation
                    lbsr      Code_178C ; call the referenced helper routine
                    cmpa      #$88      ; compare against the limit and set condition flags
                    bne       Code_1363 ; branch when the compared values differ
                    ldb       #$0D      ; load the value needed by the following operation
                    bra       Code_1366 ; continue at the selected control-flow target
Code_137D           cmpa      #$01      ; compare against the limit and set condition flags
                    bne       Code_1384 ; branch when the compared values differ
                    lbsr      Code_09EC ; call the referenced helper routine
Code_1384           clr       Addr_001A ; clear the selected byte or register
                    puls      PC,Y,X,D  ; restore the listed registers from the stack
                    fcb       $0D,$12   ; table, bitmap, or initialized data bytes
                    fcc       "/70"                          ; embedded text or resource bytes
                    fcb       $1F,$86,$08,$97,$11 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $10,$D6,$12,$DB,$19,$96 ; table, bitmap, or initialized data bytes
                    fcb       $18,$17,$EC ; table, bitmap, or initialized data bytes
                    fcc       "x"                            ; embedded text or resource bytes
                    fcb       $0B       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C9,$00,$8C,$96,$08,$D6 ; table, bitmap, or initialized data bytes
                    fcb       $12,$E1,$86 ; table, bitmap, or initialized data bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $04,$C6   ; table, bitmap, or initialized data bytes
                    fcc       "@ "                           ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $96,$11,$17,$EC ; table, bitmap, or initialized data bytes
                    fcc       "a"                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $10,$0A,$12,$0D,$17 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $06,$0D,$15 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $02,$0A,$15 ; table, bitmap, or initialized data bytes
                    fcc       "O9"                           ; embedded text or resource bytes
                    fcb       $0D,$17,$26,$0F,$96,$12 ; table, bitmap, or initialized data bytes
                    fcb       $81,$1C   ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $09,$17,$02,$C1,$0C,$12 ; table, bitmap, or initialized data bytes
                    fcb       $96,$11,$A7,$80 ; table, bitmap, or initialized data bytes
Code_13D8           clra                ; clear the selected byte or register
                    rts                 ; return to the caller
Data_13DA           fcc       " "                            ; embedded text or resource bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $E7       ; table, bitmap, or initialized data bytes
                    fcc       " T "                          ; embedded text or resource bytes
                    fcb       $F6       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $F4       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $F2       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $EE       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $EC       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $EA       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $E8       ; table, bitmap, or initialized data bytes
                    fcc       " } "                          ; embedded text or resource bytes
                    fcb       $E4       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $92       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $0A       ; table, bitmap, or initialized data bytes
                    fcc       " A 1   o "                    ; embedded text or resource bytes
                    fcb       $D6,$8D   ; table, bitmap, or initialized data bytes
                    fcc       "7"                            ; embedded text or resource bytes
                    fcb       $81,$01   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $02,$0F,$1A ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $02,$17,$0D,$C6 ; table, bitmap, or initialized data bytes
                    fcc       "M5"                           ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $03,$86,$02 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $81,$02   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $02,$86,$01 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $8D,$1B,$81,$02 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $03,$17,$F5,$C5,$17,$10 ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
                    fcb       $86,$02   ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $0D,$17   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $94,$16,$01,$A3,$0D,$17 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $8D,$16,$01 ; table, bitmap, or initialized data bytes
                    fcc       "s"                            ; embedded text or resource bytes
                    fcb       $17,$EB,$D7,$1B,$0D,$12 ; table, bitmap, or initialized data bytes
                    fcc       "',"                           ; embedded text or resource bytes
                    fcb       $0D,$17,$26,$14 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C9,$01,$93,$D6,$12,$E7 ; table, bitmap, or initialized data bytes
                    fcb       $02,$CB,$04,$17,$FA,$F6 ; table, bitmap, or initialized data bytes
                    fcc       "M'"                           ; embedded text or resource bytes
                    fcb       $18,$0F,$1A ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $14,$17,$00 ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $17,$FA,$E9 ; table, bitmap, or initialized data bytes
                    fcc       "M'"                           ; embedded text or resource bytes
                    fcb       $0B,$0F,$1A,$9E,$0D ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $03,$17,$F7,$95,$D7,$12 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C9,$00,$8C,$D6,$08,$96 ; table, bitmap, or initialized data bytes
                    fcb       $12,$A1,$85 ; table, bitmap, or initialized data bytes
                    fcc       ".#"                           ; embedded text or resource bytes
                    fcb       $96,$17,$81,$02 ; table, bitmap, or initialized data bytes
                    fcc       "'6"                           ; embedded text or resource bytes
                    fcb       $86,$01,$97,$1A,$96,$07 ; table, bitmap, or initialized data bytes
                    fcb       $D6,$08,$17,$FA,$A3,$9F ; table, bitmap, or initialized data bytes
                    fcb       $0D,$17,$01 ; table, bitmap, or initialized data bytes
                    fcc       "n"                            ; embedded text or resource bytes
                    fcb       $17,$01,$DA ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $84       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $22,$17,$F6,$C7,$86,$01 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $0D,$1A,$26,$15,$A7,$85 ; table, bitmap, or initialized data bytes
                    fcb       $17,$F9,$B3,$D6,$08,$D1 ; table, bitmap, or initialized data bytes
                    fcb       $0C       ; table, bitmap, or initialized data bytes
                    fcc       "/"                            ; embedded text or resource bytes
                    fcb       $05,$D7,$0C,$17,$F9,$C7 ; table, bitmap, or initialized data bytes
                    fcb       $17,$01   ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $0C,$1A,$17,$F4,$94,$86 ; table, bitmap, or initialized data bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "91"                           ; embedded text or resource bytes
                    fcb       $C9,$01,$96 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C9,$00,$F0,$96,$08,$E6 ; table, bitmap, or initialized data bytes
                    fcb       $86,$0D,$15 ; table, bitmap, or initialized data bytes
                    fcc       "'*"                           ; embedded text or resource bytes
                    fcb       $0A,$15,$D1,$15 ; table, bitmap, or initialized data bytes
                    fcc       ",$"                           ; embedded text or resource bytes
                    fcb       $D6,$15,$E7,$86,$9E,$02 ; table, bitmap, or initialized data bytes
                    fcb       $EC,$84   ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $16,$D1,$08,$26,$0C,$EC ; table, bitmap, or initialized data bytes
                    fcb       $02,$84,$C0 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $06,$C4,$F8,$DA,$15,$E7 ; table, bitmap, or initialized data bytes
                    fcb       $03,$17,$FA,$C0 ; table, bitmap, or initialized data bytes
                    fcc       ": "                           ; embedded text or resource bytes
                    fcb       $E6,$0C,$17,$D6,$15 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C9,$02   ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $A6,$84,$81 ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $26,$04,$CA,$08 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $04,$81   ; table, bitmap, or initialized data bytes
                    fcc       "+"                            ; embedded text or resource bytes
                    fcb       $26,$04   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $01,$0A,$12 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $10,$9E,$0D ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $18,$A6,$02,$84,$C0 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $12,$A6,$03 ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $02,$CA,$80,$84,$07,$91 ; table, bitmap, or initialized data bytes
                    fcb       $15       ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $06       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $02,$C4,$F8,$EA,$E0 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $10,$E7,$A0,$96,$12 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $17,$C6   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $E7,$86   ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $E7,$86,$A6,$80,$0A,$12 ; table, bitmap, or initialized data bytes
                    fcb       $17,$1E   ; table, bitmap, or initialized data bytes
                    fcc       "y0"                           ; embedded text or resource bytes
                    fcb       $C9,$01,$96,$17 ; table, bitmap, or initialized data bytes
                    fcc       "'@"                           ; embedded text or resource bytes
                    fcb       $26,$0A,$A6,$C9,$01,$96 ; table, bitmap, or initialized data bytes
                    fcb       $84,$F7,$A7,$C9,$01,$96 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C9,$01,$93,$C6,$0D ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
Code_155B           pshs      Y,X,D     ; preserve the listed registers on the stack
                    lda       #$01      ; load the value needed by the following operation
                    sta       Addr_001A ; save the current value in working storage
                    leax      $0193,U   ; form the referenced address without reading memory
                    ldd       Addr_0007 ; load the value needed by the following operation
                    std       ,X++      ; store the value and advance the destination pointer
                    lda       #$49      ; load the value needed by the following operation
                    sta       ,X+       ; store the value and advance the destination pointer
                    ldd       #Addr_000A ; load the value needed by the following operation
                    lbsr      Code_10BE ; call the referenced helper routine
                    leax      $0241,U   ; form the referenced address without reading memory
                    lbsr      Code_15FF ; call the referenced helper routine
                    lbsr      Code_166E ; call the referenced helper routine
                    clr       Addr_0012 ; clear the selected byte or register
                    clr       start     ; clear the selected byte or register
                    clr       Addr_0016 ; clear the selected byte or register
                    lda       #$01      ; load the value needed by the following operation
                    sta       Addr_0017 ; save the current value in working storage
Code_1587           lbsr      Code_164D ; call the referenced helper routine
Code_158A           leay      Data_13DA,PCR ; form the referenced address without reading memory
                    aslb                ; shift left and update carry
                    jsr       B,Y       ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    bne       Code_15A1 ; branch when the compared values differ
                    lda       #$01      ; load the value needed by the following operation
                    lbsr      Code_178C ; call the referenced helper routine
                    cmpa      #$88      ; compare against the limit and set condition flags
                    bne       Code_1587 ; branch when the compared values differ
                    ldb       #$0D      ; load the value needed by the following operation
                    bra       Code_158A ; continue at the selected control-flow target
Code_15A1           cmpa      #$01      ; compare against the limit and set condition flags
                    bne       Code_15A8 ; branch when the compared values differ
                    lbsr      Code_09EC ; call the referenced helper routine
Code_15A8           clr       Addr_001A ; clear the selected byte or register
                    clr       Addr_0017 ; clear the selected byte or register
                    puls      PC,Y,X,D  ; restore the listed registers from the stack
                    fcb       $0D,$15   ; table, bitmap, or initialized data bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $16,$96,$12,$0D,$16 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $81,$0E   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $16,$17,$00,$D3,$0C,$12 ; table, bitmap, or initialized data bytes
                    fcb       $96,$11,$A7,$80 ; table, bitmap, or initialized data bytes
                    fcc       "O9"                           ; embedded text or resource bytes
                    fcb       $96,$15   ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $81,$05   ; table, bitmap, or initialized data bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $04,$97,$15 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $EA,$17,$FE,$02 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $96,$11,$81 ; table, bitmap, or initialized data bytes
                    fcc       "+'"                           ; embedded text or resource bytes
                    fcb       $19,$81   ; table, bitmap, or initialized data bytes
                    fcc       "-'"                           ; embedded text or resource bytes
                    fcb       $15,$81   ; table, bitmap, or initialized data bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $26,$EE,$0D,$15,$26,$EA ; table, bitmap, or initialized data bytes
                    fcb       $0C,$15,$17,$00,$A5,$0C ; table, bitmap, or initialized data bytes
                    fcb       $12,$96,$11,$A7,$80 ; table, bitmap, or initialized data bytes
                    fcc       "O9"                           ; embedded text or resource bytes
                    fcb       $0D,$12,$26,$D9,$0C,$16 ; table, bitmap, or initialized data bytes
                    fcb       $8D,$B0   ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
Code_15FF           pshs      X,D       ; preserve the listed registers on the stack
Code_1601           ldd       Addr_0007 ; load the value needed by the following operation
                    suba      Addr_0009 ; subtract the operand from the running value
Code_1605           adda      Addr_003D ; add the operand to the running value
                    subb      Addr_000B ; subtract the operand from the running value
                    leax      $0183,U   ; form the referenced address without reading memory
                    ldb       B,X       ; load the value needed by the following operation
                    std       Code_0018 ; save the current value in working storage
                    puls      PC,X,D    ; restore the listed registers from the stack
Data_1613           fcb       $00,$00,$00,$00,$00,$12 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00   ; table, bitmap, or initialized data bytes
Data_161B           fcb       $0E,$0E,$0E,$00,$0E,$0F ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$11,$11,$11,$11 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$11,$11 ; table, bitmap, or initialized data bytes
                    fcb       $11,$00,$11,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $01,$01,$01,$01,$01,$01 ; table, bitmap, or initialized data bytes
                    fcb       $01,$01,$01,$01,$01,$10 ; table, bitmap, or initialized data bytes
                    fcb       $01,$10,$10,$01,$02,$02 ; table, bitmap, or initialized data bytes
                    fcb       $02,$02,$02,$02,$02,$02 ; table, bitmap, or initialized data bytes
                    fcb       $02,$02   ; table, bitmap, or initialized data bytes
Code_164D           pshs      X,A       ; preserve the listed registers on the stack
                    leax      >Data_1613,PCR ; form the referenced address without reading memory
                    ldb       Addr_0011 ; load the value needed by the following operation
                    blt       Code_166B ; branch when the signed value is below the limit
                    cmpb      #$3A      ; compare against the limit and set condition flags
                    bge       Code_1667 ; branch when the signed value is at least the limit
                    cmpb      #$05      ; compare against the limit and set condition flags
                    bne       Code_1663 ; branch when the compared values differ
                    ldb       #$12      ; load the value needed by the following operation
                    puls      PC,X,A    ; restore the listed registers from the stack
Code_1663           ldb       B,X       ; load the value needed by the following operation
                    puls      PC,X,A    ; restore the listed registers from the stack
Code_1667           ldb       #$01      ; load the value needed by the following operation
                    puls      PC,X,A    ; restore the listed registers from the stack
Code_166B           clrb                ; clear the selected byte or register
                    puls      PC,X,A    ; restore the listed registers from the stack
Code_166E           pshs      X,D       ; preserve the listed registers on the stack
                    ldd       Code_0018 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    leax      $008C,U   ; form the referenced address without reading memory
                    ldb       Addr_0008 ; load the value needed by the following operation
                    lda       B,X       ; load the value needed by the following operation
                    sta       Addr_004C ; save the current value in working storage
                    ldd       #Code_2040 ; load the value needed by the following operation
Code_1683           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $02       ; private DeskMate service selector
                    dec       Addr_004C ; decrement the selected counter
                    bne       Code_1683 ; branch when the compared values differ
                    ldd       Code_0018 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    puls      PC,X,D    ; restore the listed registers from the stack
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $16       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C9,$00,$8C,$96,$08,$D6 ; table, bitmap, or initialized data bytes
                    fcb       $12,$E1,$86 ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $12,$DB,$19,$96,$18,$17 ; table, bitmap, or initialized data bytes
                    fcb       $E9       ; table, bitmap, or initialized data bytes
                    fcc       "m"                            ; embedded text or resource bytes
                    fcb       $0B,$96,$11,$C6 ; table, bitmap, or initialized data bytes
                    fcc       "@"                            ; embedded text or resource bytes
                    fcb       $17,$E9   ; table, bitmap, or initialized data bytes
                    fcc       "e"                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $96,$DB,$19,$D1 ; table, bitmap, or initialized data bytes
                    fcc       "@,"                           ; embedded text or resource bytes
                    fcb       $0B,$10,$8E,$00,$01,$17 ; table, bitmap, or initialized data bytes
                    fcb       $00,$AD,$D6,$12 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $DD,$DC,$0B ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $04,$E6,$86 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $04,$0C,$0B,$17,$F7,$89 ; table, bitmap, or initialized data bytes
                    fcb       $17,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "+"                            ; embedded text or resource bytes
                    fcb       $DC,$07,$17,$F8 ; table, bitmap, or initialized data bytes
                    fcc       "V"                            ; embedded text or resource bytes
                    fcb       $9F,$0D,$E6,$E4 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $1F,$02,$96 ; table, bitmap, or initialized data bytes
                    fcc       "="                            ; embedded text or resource bytes
                    fcb       $DB       ; table, bitmap, or initialized data bytes
                    fcc       ">"                            ; embedded text or resource bytes
                    fcb       $1F,$01,$D6 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $E0,$E0,$96 ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $1F,$03,$CC ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $00,$17,$0C ; table, bitmap, or initialized data bytes
                    fcc       "7"                            ; embedded text or resource bytes
                    fcb       $DE,$00,$17,$F6 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $E6,$E4   ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $96,$0C,$A0,$E0 ; table, bitmap, or initialized data bytes
                    fcc       "'f4"                          ; embedded text or resource bytes
                    fcb       $04,$D6,$08 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $04,$E6   ; table, bitmap, or initialized data bytes
                    fcc       "a"                            ; embedded text or resource bytes
                    fcb       $D7,$08,$17,$F6,$96 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $02,$97,$08,$90,$0B ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C9,$01,$83,$E6,$86,$DB ; table, bitmap, or initialized data bytes
                    fcb       $12,$A6,$E0,$90,$0B,$A6 ; table, bitmap, or initialized data bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $02,$E0,$E0 ; table, bitmap, or initialized data bytes
                    fcc       "/?4"                          ; embedded text or resource bytes
                    fcb       $06,$DC,$07 ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $17,$F7,$FE,$8C,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $26,$0C   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $04,$EB,$E0,$96,$18,$17 ; table, bitmap, or initialized data bytes
                    fcb       $E8,$D6,$0B ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $26,$E6   ; table, bitmap, or initialized data bytes
                    fcc       "aO"                           ; embedded text or resource bytes
                    fcb       $1F,$02,$E6,$E4,$8D,$22 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $04,$A6,$E4 ; table, bitmap, or initialized data bytes
                    fcc       "@"                            ; embedded text or resource bytes
                    fcb       $AE       ; table, bitmap, or initialized data bytes
                    fcc       "c0"                           ; embedded text or resource bytes
                    fcb       $86,$96,$18,$17,$E8,$BC ; table, bitmap, or initialized data bytes
                    fcb       $0B,$C6   ; table, bitmap, or initialized data bytes
                    fcc       "@"                            ; embedded text or resource bytes
                    fcb       $A6,$80,$17,$E8,$B4,$02 ; table, bitmap, or initialized data bytes
                    fcc       "j"                            ; embedded text or resource bytes
                    fcb       $E4       ; table, bitmap, or initialized data bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $F6       ; table, bitmap, or initialized data bytes
                    fcc       "2a"                           ; embedded text or resource bytes
                    fcb       $D6,$12,$16,$FF ; table, bitmap, or initialized data bytes
                    fcc       "FO4"                          ; embedded text or resource bytes
                    fcb       $06,$96,$18,$1F,$01 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $D6       ; table, bitmap, or initialized data bytes
                    fcc       "@"                            ; embedded text or resource bytes
                    fcb       $A3,$E1   ; table, bitmap, or initialized data bytes
                    fcc       "4 "                           ; embedded text or resource bytes
                    fcb       $A3,$E1   ; table, bitmap, or initialized data bytes
                    fcc       "/"                            ; embedded text or resource bytes
                    fcb       $0C,$86,$01,$1F,$03,$CC ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $00,$17,$0B,$A9,$DE,$00 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
Code_178C           ldb       #$80      ; load the value needed by the following operation
                    tsta                ; set condition flags from the current value
                    beq       Code_1793 ; branch when the compared values are equal
                    ldb       #$83      ; load the value needed by the following operation
Code_1793           pshs      B         ; preserve the listed registers on the stack
Code_1795           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    beq       Code_17A0 ; branch when the compared values are equal
                    sta       Addr_0011 ; save the current value in working storage
                    leas      $01,S     ; form the referenced address without reading memory
                    rts                 ; return to the caller
Code_17A0           bsr       Code_17AA ; call the referenced helper routine
                    ldb       ,S        ; load the value needed by the following operation
                    tsta                ; set condition flags from the current value
                    beq       Code_1795 ; branch when the compared values are equal
                    leas      $01,S     ; form the referenced address without reading memory
                    rts                 ; return to the caller
Code_17AA           pshs      Y,X       ; preserve the listed registers on the stack
                    lbsr      Code_4975 ; call the referenced helper routine
                    tstb                ; set condition flags from the current value
                    bne       Code_17D0 ; branch when the compared values differ
                    tfr       U,D       ; copy the source register into the destination register
                    ldu       DeskMateService ; load the value needed by the following operation
                    tsta                ; set condition flags from the current value
                    blt       Code_17CD ; branch when the signed value is below the limit
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0C       ; private DeskMate service selector
                    pshs      X         ; preserve the listed registers on the stack
                    leax      Data_1BD0,PCR ; form the referenced address without reading memory
                    bsr       Code_17F1 ; call the referenced helper routine
                    bsr       Code_1822 ; call the referenced helper routine
                    puls      D         ; restore the listed registers from the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
Code_17CD           clra                ; clear the selected byte or register
                    puls      PC,Y,X    ; restore the listed registers from the stack
Code_17D0           tfr       U,X       ; copy the source register into the destination register
                    ldu       DeskMateService ; load the value needed by the following operation
                    pshs      B         ; preserve the listed registers on the stack
                    tfr       X,D       ; copy the source register into the destination register
                    tsta                ; set condition flags from the current value
                    blt       Code_17EE ; branch when the signed value is below the limit
                    leax      Data_1BD0,PCR ; form the referenced address without reading memory
                    bsr       Code_17F1 ; call the referenced helper routine
                    pshs      Y,X,D     ; preserve the listed registers on the stack
                    bsr       Code_1822 ; call the referenced helper routine
                    puls      Y,X,D     ; restore the listed registers from the stack
                    lbsr      Code_18D3 ; call the referenced helper routine
Code_17EA           leas      $01,S     ; form the referenced address without reading memory
                    puls      PC,Y,X    ; restore the listed registers from the stack
Code_17EE           clra                ; clear the selected byte or register
                    bra       Code_17EA ; continue at the selected control-flow target
Code_17F1           tst       Addr_004A ; set condition flags from the current value
                    beq       Code_17F9 ; branch when the compared values are equal
                    leax      Data_1BE3,PCR ; form the referenced address without reading memory
Code_17F9           ldy       #Addr_0001 ; load the value needed by the following operation
                    pshs      X,D       ; preserve the listed registers on the stack
Code_17FF           cmpb      ,X        ; compare against the limit and set condition flags
                    blt       Code_180D ; branch when the signed value is below the limit
                    cmpb      $01,X     ; compare against the limit and set condition flags
                    bgt       Code_180D ; branch when the signed value is above the limit
                    cmpa      #$01      ; compare against the limit and set condition flags
                    bgt       Code_180D ; branch when the signed value is above the limit
Code_180B           puls      PC,X,D    ; restore the listed registers from the stack
Code_180D           leay      $01,Y     ; form the referenced address without reading memory
                    leax      $02,X     ; form the referenced address without reading memory
                    pshs      B         ; preserve the listed registers on the stack
                    ldb       ,X        ; load the value needed by the following operation
                    cmpb      #$FF      ; compare against the limit and set condition flags
                    puls      B         ; restore the listed registers from the stack
                    bne       Code_17FF ; branch when the compared values differ
                    clra                ; clear the selected byte or register
                    ldb       #$FF      ; load the value needed by the following operation
                    tfr       D,Y       ; copy the source register into the destination register
                    bra       Code_180B ; continue at the selected control-flow target
Code_1822           tfr       Y,D       ; copy the source register into the destination register
                    cmpb      Addr_0038 ; compare against the limit and set condition flags
                    beq       Code_1845 ; branch when the compared values are equal
                    ldb       Addr_0038 ; load the value needed by the following operation
                    blt       Code_1833 ; branch when the signed value is below the limit
                    pshs      Y,X       ; preserve the listed registers on the stack
                    clra                ; clear the selected byte or register
                    bsr       Code_1846 ; call the referenced helper routine
                    puls      Y,X       ; restore the listed registers from the stack
Code_1833           tfr       Y,D       ; copy the source register into the destination register
                    stb       Addr_0038 ; save the current value in working storage
                    cmpb      #$FF      ; compare against the limit and set condition flags
                    beq       Code_1841 ; branch when the compared values are equal
                    lda       #$40      ; load the value needed by the following operation
                    bsr       Code_1846 ; call the referenced helper routine
                    bra       Code_1845 ; continue at the selected control-flow target
Code_1841           ldb       #$FF      ; load the value needed by the following operation
                    stb       Addr_0038 ; save the current value in working storage
Code_1845           rts                 ; return to the caller
Code_1846           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    pshs      A         ; preserve the listed registers on the stack
                    pshs      B         ; preserve the listed registers on the stack
                    decb                ; decrement the selected counter
                    aslb                ; shift left and update carry
                    abx                 ; add the operand to the running value
                    ldb       ,S        ; load the value needed by the following operation
                    cmpb      #$03      ; compare against the limit and set condition flags
                    bgt       Code_188A ; branch when the signed value is above the limit
                    lda       #$03      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    clra                ; clear the selected byte or register
                    ldb       ,X        ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    puls      B         ; restore the listed registers from the stack
                    leax      Data_07F5,PCR ; form the referenced address without reading memory
                    cmpb      #$02      ; compare against the limit and set condition flags
                    blt       Code_187A ; branch when the signed value is below the limit
                    bgt       Code_1876 ; branch when the signed value is above the limit
                    leax      Data_07FA,PCR ; form the referenced address without reading memory
                    bra       Code_187A ; continue at the selected control-flow target
Code_1876           leax      Data_0800,PCR ; form the referenced address without reading memory
Code_187A           puls      B         ; restore the listed registers from the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "6"                            ; embedded text or resource bytes
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_188A           subb      #$04      ; subtract the operand from the running value
                    aslb                ; shift left and update carry
                    leax      Data_1BF6,PCR ; form the referenced address without reading memory
                    tst       Addr_004A ; set condition flags from the current value
                    beq       Code_1899 ; branch when the compared values are equal
                    leax      Data_1C02,PCR ; form the referenced address without reading memory
Code_1899           abx                 ; add the operand to the running value
                    ldd       #Addr_000D ; load the value needed by the following operation
                    pshs      D         ; preserve the listed registers on the stack
                    ldd       ,X        ; load the value needed by the following operation
                    addd      #Code_001E ; add the operand to the running value
                    tst       Addr_004A ; set condition flags from the current value
                    bne       Code_18AB ; branch when the compared values differ
                    addd      #Addr_0005 ; add the operand to the running value
Code_18AB           pshs      D         ; preserve the listed registers on the stack
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    pshs      D         ; preserve the listed registers on the stack
                    ldd       ,X        ; load the value needed by the following operation
                    pshs      D         ; preserve the listed registers on the stack
                    lda       $09,S     ; load the value needed by the following operation
                    beq       Code_18BD ; branch when the compared values are equal
                    ldb       #$FF      ; load the value needed by the following operation
                    bra       Code_18BF ; continue at the selected control-flow target
Code_18BD           ldb       #$AA      ; load the value needed by the following operation
Code_18BF           tst       Addr_004A ; set condition flags from the current value
                    beq       Code_18C4 ; branch when the compared values are equal
                    comb                ; invert every bit in the selected value
Code_18C4           pshs      B         ; preserve the listed registers on the stack
                    tfr       S,X       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $13       ; private DeskMate service selector
                    leas      $0B,S     ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_18D3           cmpy      #Addr_00FF ; compare against the limit and set condition flags
                    lbeq      Code_1969 ; take the distant branch when values are equal
                    cmpy      #Addr_0005 ; compare against the limit and set condition flags
                    lblt      Code_1947 ; take the distant branch for signed less-than
                    cmpy      #Addr_0008 ; compare against the limit and set condition flags
                    bgt       Code_192F ; branch when the signed value is above the limit
                    tfr       Y,D       ; copy the source register into the destination register
                    stb       Addr_0038 ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    ldb       $02,S     ; load the value needed by the following operation
                    cmpb      #$02      ; compare against the limit and set condition flags
                    blt       Code_18F8 ; branch when the signed value is below the limit
                    bgt       Code_1921 ; branch when the signed value is above the limit
                    lda       #$10      ; load the value needed by the following operation
Code_18F8           cmpy      #Addr_0006 ; compare against the limit and set condition flags
                    blt       Code_1904 ; branch when the signed value is below the limit
                    bgt       Code_1908 ; branch when the signed value is above the limit
Code_1900           adda      #$09      ; add the operand to the running value
                    bra       Code_191C ; continue at the selected control-flow target
Code_1904           adda      #$08      ; add the operand to the running value
                    bra       Code_191C ; continue at the selected control-flow target
Code_1908           cmpy      #Addr_0008 ; compare against the limit and set condition flags
                    beq       Code_191A ; branch when the compared values are equal
                    cmpb      #$05      ; compare against the limit and set condition flags
                    bne       Code_1916 ; branch when the compared values differ
                    adda      #$0B      ; add the operand to the running value
                    bra       Code_191C ; continue at the selected control-flow target
Code_1916           adda      #$0C      ; add the operand to the running value
                    bra       Code_191C ; continue at the selected control-flow target
Code_191A           adda      #$0A      ; add the operand to the running value
Code_191C           sta       Addr_0011 ; save the current value in working storage
                    clr       Code_0037 ; clear the selected byte or register
                    rts                 ; return to the caller
Code_1921           cmpb      #$05      ; compare against the limit and set condition flags
                    bne       Code_1929 ; branch when the compared values differ
                    lda       #$08      ; load the value needed by the following operation
                    bra       Code_18F8 ; continue at the selected control-flow target
Code_1929           cmpb      #$04      ; compare against the limit and set condition flags
                    bne       Code_18F8 ; branch when the compared values differ
                    bra       Code_1940 ; continue at the selected control-flow target
Code_192F           tst       Addr_001A ; set condition flags from the current value
                    bne       Code_1940 ; branch when the compared values differ
                    lbsr      Code_1AA1 ; call the referenced helper routine
Code_1936           tst       Addr_0006 ; set condition flags from the current value
                    beq       Code_1940 ; branch when the compared values are equal
                    lbsr      Code_2627 ; call the referenced helper routine
                    lbsr      Code_2665 ; call the referenced helper routine
Code_1940           clra                ; clear the selected byte or register
                    rts                 ; return to the caller
Code_1942           lbsr      Code_1ADD ; call the referenced helper routine
                    bra       Code_1936 ; continue at the selected control-flow target
Code_1947           clra                ; clear the selected byte or register
                    tst       Addr_001A ; set condition flags from the current value
                    bne       Code_1968 ; branch when the compared values differ
                    tst       Addr_0006 ; set condition flags from the current value
                    beq       Code_1956 ; branch when the compared values are equal
                    ldb       $02,S     ; load the value needed by the following operation
                    cmpb      #$03      ; compare against the limit and set condition flags
                    bge       Code_1968 ; branch when the signed value is at least the limit
Code_1956           cmpy      #Addr_0004 ; compare against the limit and set condition flags
                    beq       Code_1942 ; branch when the compared values are equal
                    tfr       Y,D       ; copy the source register into the destination register
                    stb       Addr_004C ; save the current value in working storage
                    stb       Addr_0038 ; save the current value in working storage
                    stb       Code_0037 ; save the current value in working storage
                    lda       #$8C      ; load the value needed by the following operation
                    sta       Addr_0011 ; save the current value in working storage
Code_1968           rts                 ; return to the caller
Code_1969           tst       Addr_001A ; set condition flags from the current value
                    bne       Code_1940 ; branch when the compared values differ
                    tfr       D,X       ; copy the source register into the destination register
                    ldb       $02,S     ; load the value needed by the following operation
                    cmpb      #$02      ; compare against the limit and set condition flags
                    bgt       Code_1989 ; branch when the signed value is above the limit
                    beq       Code_1982 ; branch when the compared values are equal
                    tst       Addr_0006 ; set condition flags from the current value
                    bne       Code_1984 ; branch when the compared values differ
                    lbsr      Code_1A10 ; call the referenced helper routine
                    beq       Code_1982 ; branch when the compared values are equal
Code_1980           bra       Code_191C ; continue at the selected control-flow target
Code_1982           clra                ; clear the selected byte or register
                    rts                 ; return to the caller
Code_1984           lda       #$05      ; load the value needed by the following operation
                    sta       Addr_0011 ; save the current value in working storage
                    rts                 ; return to the caller
Code_1989           cmpb      #$04      ; compare against the limit and set condition flags
                    beq       Code_1A0C ; branch when the compared values are equal
                    bgt       Code_1982 ; branch when the signed value is above the limit
                    tst       Addr_0006 ; set condition flags from the current value
                    bne       Code_1997 ; branch when the compared values differ
                    bsr       Code_1A10 ; call the referenced helper routine
                    bne       Code_1980 ; branch when the compared values differ
Code_1997           lda       Addr_0007 ; load the value needed by the following operation
                    ldb       Addr_0008 ; load the value needed by the following operation
                    std       Addr_003A ; save the current value in working storage
                    tfr       X,D       ; copy the source register into the destination register
                    tst       Addr_0006 ; set condition flags from the current value
                    bne       Code_19A8 ; branch when the compared values differ
                    lda       #$B6      ; load the value needed by the following operation
                    lbra      Code_191C ; continue at the distant control-flow target
Code_19A8           suba      Addr_003D ; subtract the operand from the running value
                    adda      Addr_0009 ; add the operand to the running value
                    pshs      A         ; preserve the listed registers on the stack
                    leay      $008C,U   ; form the referenced address without reading memory
                    lda       Addr_000C ; load the value needed by the following operation
                    suba      Addr_000B ; subtract the operand from the running value
                    inca                ; advance the selected counter
                    subb      Data_003E ; subtract the operand from the running value
                    bge       Code_19BC ; branch when the signed value is at least the limit
                    inca                ; advance the selected counter
Code_19BC           pshs      A         ; preserve the listed registers on the stack
                    lda       Addr_000B ; load the value needed by the following operation
                    leay      A,Y       ; form the referenced address without reading memory
                    clra                ; clear the selected byte or register
Code_19C3           adda      ,Y+       ; add the operand to the running value
                    pshs      A         ; preserve the listed registers on the stack
                    cmpb      ,S+       ; compare against the limit and set condition flags
                    blt       Code_19D6 ; branch when the signed value is below the limit
                    dec       ,S        ; decrement the selected counter
                    bgt       Code_19C3 ; branch when the signed value is above the limit
                    leas      $01,S     ; form the referenced address without reading memory
                    ldb       Addr_000C ; load the value needed by the following operation
                    incb                ; advance the selected counter
                    bra       Code_19DB ; continue at the selected control-flow target
Code_19D6           ldb       Addr_000C ; load the value needed by the following operation
                    subb      ,S+       ; subtract the operand from the running value
                    incb                ; advance the selected counter
Code_19DB           puls      A         ; restore the listed registers from the stack
                    tfr       D,X       ; copy the source register into the destination register
                    cmpa      Addr_003A ; compare against the limit and set condition flags
                    beq       Code_19ED ; branch when the compared values are equal
                    bgt       Code_19E9 ; branch when the signed value is above the limit
                    lda       #$0C      ; load the value needed by the following operation
                    bra       Code_19EE ; continue at the selected control-flow target
Code_19E9           lda       #$0A      ; load the value needed by the following operation
                    bra       Code_19EE ; continue at the selected control-flow target
Code_19ED           clra                ; clear the selected byte or register
Code_19EE           cmpb      Code_003B ;19EE: D1 3B          '. ; compare against the limit and set condition flags
                    beq       Code_19FC ; branch when the compared values are equal
                    blt       Code_19F8 ; branch when the signed value is below the limit
                    ldb       #$09      ; load the value needed by the following operation
                    bra       Code_19FD ; continue at the selected control-flow target
Code_19F8           ldb       #$08      ; load the value needed by the following operation
                    bra       Code_19FD ; continue at the selected control-flow target
Code_19FC           clrb                ; clear the selected byte or register
Code_19FD           tsta                ; set condition flags from the current value
                    bne       Code_1A03 ; branch when the compared values differ
                    tfr       B,A       ; copy the source register into the destination register
                    clrb                ; clear the selected byte or register
Code_1A03           sta       Addr_0011 ; save the current value in working storage
                    stb       Code_0039 ; save the current value in working storage
                    ldb       #$01      ; load the value needed by the following operation
                    stb       Code_0037 ; save the current value in working storage
                    rts                 ; return to the caller
Code_1A0C           clr       Code_0037 ; clear the selected byte or register
                    clra                ; clear the selected byte or register
                    rts                 ; return to the caller
Code_1A10           decb                ; decrement the selected counter
                    pshs      B         ; preserve the listed registers on the stack
                    tfr       X,D       ; copy the source register into the destination register
                    cmpa      Addr_003D ; compare against the limit and set condition flags
                    blt       Code_1A81 ; branch when the signed value is below the limit
                    pshs      A         ; preserve the listed registers on the stack
                    lda       Addr_003D ; load the value needed by the following operation
                    adda      Addr_0041 ; add the operand to the running value
                    cmpa      ,S+       ; compare against the limit and set condition flags
                    ble       Code_1A78 ; branch when the signed value is at or below the limit
                    tfr       X,D       ; copy the source register into the destination register
                    cmpb      Data_003E ; compare against the limit and set condition flags
                    blt       Code_1A8C ; branch when the signed value is below the limit
                    suba      Addr_003D ; subtract the operand from the running value
                    adda      Addr_0009 ; add the operand to the running value
                    cmpa      Addr_000A ; compare against the limit and set condition flags
                    bgt       Code_1A78 ; branch when the signed value is above the limit
Code_1A31           pshs      A         ; preserve the listed registers on the stack
                    tfr       X,D       ; copy the source register into the destination register
                    subb      Data_003E ; subtract the operand from the running value
                    lda       Addr_000C ; load the value needed by the following operation
                    suba      Addr_000B ; subtract the operand from the running value
                    inca                ; advance the selected counter
                    pshs      A         ; preserve the listed registers on the stack
                    leax      $008C,U   ; form the referenced address without reading memory
                    lda       Addr_000B ; load the value needed by the following operation
                    leax      A,X       ; form the referenced address without reading memory
                    clra                ; clear the selected byte or register
Code_1A47           adda      ,X+       ; add the operand to the running value
                    pshs      A         ; preserve the listed registers on the stack
                    cmpb      ,S+       ; compare against the limit and set condition flags
                    blt       Code_1A57 ; branch when the signed value is below the limit
                    dec       ,S        ; decrement the selected counter
                    bgt       Code_1A47 ; branch when the signed value is above the limit
                    leas      $02,S     ; form the referenced address without reading memory
                    bra       Code_1A78 ; continue at the selected control-flow target
Code_1A57           ldb       Addr_000C ; load the value needed by the following operation
                    subb      ,S+       ; subtract the operand from the running value
                    incb                ; advance the selected counter
Code_1A5C           pshs      B         ; preserve the listed registers on the stack
                    lbsr      Code_0B2F ; call the referenced helper routine
                    puls      D         ; restore the listed registers from the stack
                    exg       A,B       ; exchange the two register values
                    std       Addr_0007 ; save the current value in working storage
                    lbsr      Code_0F2F ; call the referenced helper routine
                    lbsr      Code_15FF ; call the referenced helper routine
                    lbsr      Code_09EC ; call the referenced helper routine
                    tst       Addr_0007 ; set condition flags from the current value
                    beq       Code_1A7C ; branch when the compared values are equal
                    tst       Addr_0008 ; set condition flags from the current value
                    beq       Code_1A7C ; branch when the compared values are equal
Code_1A78           clra                ; clear the selected byte or register
                    leas      $01,S     ; form the referenced address without reading memory
                    rts                 ; return to the caller
Code_1A7C           lda       #$01      ; load the value needed by the following operation
                    leas      $01,S     ; form the referenced address without reading memory
                    rts                 ; return to the caller
Code_1A81           cmpa      #$02      ; compare against the limit and set condition flags
                    bne       Code_1A78 ; branch when the compared values differ
                    tst       ,S        ; set condition flags from the current value
                    bne       Code_1A78 ; branch when the compared values differ
                    clra                ; clear the selected byte or register
                    bra       Code_1A31 ; continue at the selected control-flow target
Code_1A8C           cmpb      #$02      ; compare against the limit and set condition flags
                    bge       Code_1A78 ; branch when the signed value is at least the limit
                    tst       ,S        ; set condition flags from the current value
                    bne       Code_1A78 ; branch when the compared values differ
                    suba      Addr_003D ; subtract the operand from the running value
                    adda      Addr_0009 ; add the operand to the running value
                    cmpa      Addr_000A ; compare against the limit and set condition flags
                    bgt       Code_1A78 ; branch when the signed value is above the limit
                    pshs      A         ; preserve the listed registers on the stack
                    clrb                ; clear the selected byte or register
                    bra       Code_1A5C ; continue at the selected control-flow target
Code_1AA1           ldx       #Addr_FFFC ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "O"                            ; embedded text or resource bytes
                    leax      Data_1C0E,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "V"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "P"                            ; embedded text or resource bytes
                    ldu       DeskMateService ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "N"                            ; embedded text or resource bytes
                    lda       $23,X     ; load the value needed by the following operation
                    cmpa      #$28      ; compare against the limit and set condition flags
                    beq       Code_1AC6 ; branch when the compared values are equal
                    lbsr      Code_1B98 ; call the referenced helper routine
                    bra       Code_1AC9 ; continue at the selected control-flow target
Code_1AC6           lbsr      Code_1B2E ; call the referenced helper routine
Code_1AC9           lbsr      Code_0129 ; call the referenced helper routine
                    clr       Addr_0036 ; clear the selected byte or register
                    clr       Data_0031 ; clear the selected byte or register
                    clr       Addr_003C ; clear the selected byte or register
                    lbsr      Code_0150 ; call the referenced helper routine
                    lbsr      Code_094E ; call the referenced helper routine
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Addr_0038 ; save the current value in working storage
                    rts                 ; return to the caller
Code_1ADD           pshs      Y,X,A     ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    leax      Data_1C14,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    ldx       #Addr_FFFC ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "O"                            ; embedded text or resource bytes
                    leax      Data_1C24,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "V"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "P"                            ; embedded text or resource bytes
                    ldu       DeskMateService ; load the value needed by the following operation
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    clr       Data_1C34,PCR ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "N"                            ; embedded text or resource bytes
                    lda       $23,X     ; load the value needed by the following operation
                    cmpa      #$28      ; compare against the limit and set condition flags
                    beq       Code_1B19 ; branch when the compared values are equal
                    lbsr      Code_1B98 ; call the referenced helper routine
                    bra       Code_1B1C ; continue at the selected control-flow target
Code_1B19           lbsr      Code_1B2E ; call the referenced helper routine
Code_1B1C           lbsr      Code_0129 ; call the referenced helper routine
                    clr       Addr_0036 ; clear the selected byte or register
                    clr       Data_0031 ; clear the selected byte or register
                    clr       Addr_003C ; clear the selected byte or register
                    lbsr      Code_0150 ; call the referenced helper routine
                    lbsr      Code_094E ; call the referenced helper routine
                    clrb                ; clear the selected byte or register
                    puls      PC,Y,X,A  ; restore the listed registers from the stack
Code_1B2E           bsr       Code_1B69 ; call the referenced helper routine
                    lbsr      Code_00C4 ; call the referenced helper routine
                    lda       Addr_0008 ; load the value needed by the following operation
                    leax      $008C,U   ; form the referenced address without reading memory
                    leay      $0183,U   ; form the referenced address without reading memory
                    ldb       A,X       ; load the value needed by the following operation
                    pshs      B         ; preserve the listed registers on the stack
                    suba      Addr_000B ; subtract the operand from the running value
                    lda       A,Y       ; load the value needed by the following operation
                    adda      ,S+       ; add the operand to the running value
                    cmpa      #$26      ; compare against the limit and set condition flags
                    ble       Code_1B54 ; branch when the signed value is at or below the limit
                    lda       Addr_0008 ; load the value needed by the following operation
                    sta       Addr_000C ; save the current value in working storage
                    lbsr      Code_0E79 ; call the referenced helper routine
                    bra       Code_1B58 ; continue at the selected control-flow target
Code_1B54           lda       Addr_000B ; load the value needed by the following operation
                    sta       Addr_000C ; save the current value in working storage
Code_1B58           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $00       ; private DeskMate service selector
                    lbsr      Code_0150 ; call the referenced helper routine
                    lbsr      Code_0E5A ; call the referenced helper routine
                    lbsr      Code_15FF ; call the referenced helper routine
                    lbsr      Code_094E ; call the referenced helper routine
                    rts                 ; return to the caller
Code_1B69           clr       Addr_004A ; clear the selected byte or register
                    lda       #$10      ; load the value needed by the following operation
                    sta       Code_004B ; save the current value in working storage
                    lda       #$28      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $09       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "-"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $00       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       " "                            ; embedded text or resource bytes
                    stx       Code_0034 ; save the current value in working storage
                    lda       #$03      ; load the value needed by the following operation
                    sta       Addr_0042 ; save the current value in working storage
                    lda       #$04      ; load the value needed by the following operation
                    sta       Code_0043 ; save the current value in working storage
                    lda       #$23      ; load the value needed by the following operation
                    sta       Addr_0044 ; save the current value in working storage
                    lda       #$12      ; load the value needed by the following operation
                    sta       Code_0045 ; save the current value in working storage
                    lda       #$26      ; load the value needed by the following operation
                    sta       Addr_0046 ; save the current value in working storage
                    rts                 ; return to the caller
Code_1B98           bsr       Code_1B9F ; call the referenced helper routine
                    lbsr      Code_00C4 ; call the referenced helper routine
                    bra       Code_1B58 ; continue at the selected control-flow target
Code_1B9F           lda       #$01      ; load the value needed by the following operation
                    sta       Addr_004A ; save the current value in working storage
                    lda       #$08      ; load the value needed by the following operation
                    sta       Code_004B ; save the current value in working storage
                    lda       #$50      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $09       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "-"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $00       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       " "                            ; embedded text or resource bytes
                    stx       Code_0034 ; save the current value in working storage
                    lda       #$03      ; load the value needed by the following operation
                    sta       Addr_0042 ; save the current value in working storage
                    lda       #$04      ; load the value needed by the following operation
                    sta       Code_0043 ; save the current value in working storage
                    lda       #$4C      ; load the value needed by the following operation
                    sta       Addr_0044 ; save the current value in working storage
                    lda       #$12      ; load the value needed by the following operation
                    sta       Code_0045 ; save the current value in working storage
                    lda       #$4F      ; load the value needed by the following operation
                    sta       Addr_0046 ; save the current value in working storage
                    rts                 ; return to the caller
Data_1BD0           fcb       $01,$04,$05,$09,$0B,$0E ; table, bitmap, or initialized data bytes
                    fcb       $16,$18,$19,$1B,$1C,$1D ; table, bitmap, or initialized data bytes
                    fcb       $1E       ; table, bitmap, or initialized data bytes
                    fcc       " !"                           ; embedded text or resource bytes
                    fcb       $22       ; table, bitmap, or initialized data bytes
                    fcc       "#%"                           ; embedded text or resource bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
Data_1BE3           fcb       $01,$05,$0B,$0F,$17,$1A ; table, bitmap, or initialized data bytes
                    fcc       "-0258;=?BEGJ"           ;1BE9: 2D 30 32 35 38 3B 3D 3F 42 45 47 4A '-0258 ; embedded text or resource bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
Data_1BF6           fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "g"                            ; embedded text or resource bytes
                    fcb       $01,$93,$01,$B9,$01,$E7 ; table, bitmap, or initialized data bytes
                    fcb       $02,$0D,$02 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
Data_1C02           fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "a"                            ; embedded text or resource bytes
                    fcb       $01,$8B,$01,$B5,$01,$E1 ; table, bitmap, or initialized data bytes
                    fcb       $02,$09,$02 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
Data_1C0E           fcc       "DMALT"                        ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
Data_1C14           fcc       "("                            ; embedded text or resource bytes
                    fcb       $06,$05,$1C,$10,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $18,$05,$1E,$10,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
Data_1C24           fcc       "DMHELP"                       ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "DMLEDGER "                    ; embedded text or resource bytes
Data_1C34           fcb       $00,$00,$0D ; table, bitmap, or initialized data bytes
Code_1C37           ldd       ,X        ; load the value needed by the following operation
                    cmpb      #$3A      ; compare against the limit and set condition flags
                    bne       Code_1C45 ; branch when the compared values differ
                    suba      #$30      ; subtract the operand from the running value
                    ble       Code_1C74 ; branch when the signed value is at or below the limit
                    cmpa      #$02      ; compare against the limit and set condition flags
                    bgt       Code_1C74 ; branch when the signed value is above the limit
Code_1C45           leay      $0241,U   ; form the referenced address without reading memory
                    stx       ,Y        ; save the current value in working storage
                    leax      Data_21D1,PCR ; form the referenced address without reading memory
                    stx       $02,Y     ; save the current value in working storage
                    leax      >$004E,U  ; form the referenced address without reading memory
                    stx       $04,Y     ; save the current value in working storage
                    lda       #$36      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "J"                            ; embedded text or resource bytes
                    tstb                ; set condition flags from the current value
                    bne       Code_1C74 ; branch when the compared values differ
                    ldx       $04,Y     ; load the value needed by the following operation
                    clr       Addr_0033 ; clear the selected byte or register
                    lda       #$01      ; load the value needed by the following operation
                    os9       I$Open    ; request the named OS-9 service
                    bcs       Code_1C74 ; branch when carry reports an unsigned underflow or error
                    sta       Code_0032 ; save the current value in working storage
                    ldb       #$02      ; load the value needed by the following operation
                    stb       Data_0031 ; save the current value in working storage
                    lbra      Code_1F78 ; continue at the distant control-flow target
Code_1C74           rts                 ; return to the caller
Code_1C75           lda       Addr_000F ; load the value needed by the following operation
                    cmpa      #$02      ; compare against the limit and set condition flags
                    bne       Code_1CDF ; branch when the compared values differ
                    ldd       Addr_0002 ; load the value needed by the following operation
                    cmpd      Addr_0004 ; compare against the limit and set condition flags
                    beq       Code_1CDC ; branch when the compared values are equal
                    leax      Data_2181,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    ldd       #Data_0705 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    leax      Data_21AF,PCR ; form the referenced address without reading memory
                    ldb       #$14      ; load the value needed by the following operation
                    lbsr      Code_0EB7 ; call the referenced helper routine
                    lda       $0154,U   ; load the value needed by the following operation
                    cmpa      #$20      ; compare against the limit and set condition flags
                    beq       Code_1CCB ; branch when the compared values are equal
                    ldd       #Data_0905 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    leax      Data_21C3,PCR ; form the referenced address without reading memory
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "6"                            ; embedded text or resource bytes
                    ldd       #Data_0910 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "4"                            ; embedded text or resource bytes
                    leax      $0154,U   ; form the referenced address without reading memory
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "3"                            ; embedded text or resource bytes
Code_1CCB           ldd       #Addr_380C ; load the value needed by the following operation
                    ldx       #Code_3814 ; load the value needed by the following operation
                    lbsr      Code_10C4 ; call the referenced helper routine
                    lda       Code_004D ; load the value needed by the following operation
                    lbmi      Code_1D9C ; take the distant branch while the value is negative
                    beq       Code_1CE3 ; branch when the compared values are equal
Code_1CDC           lbra      Code_1E1B ; continue at the distant control-flow target
Code_1CDF           tst       Addr_0006 ; set condition flags from the current value
                    bne       Code_1CF1 ; branch when the compared values differ
Code_1CE3           lda       #$01      ; load the value needed by the following operation
                    sta       Code_0022 ; save the current value in working storage
                    sta       Addr_0023 ; save the current value in working storage
                    lda       #$63      ; load the value needed by the following operation
                    sta       Addr_0024 ; save the current value in working storage
                    sta       Data_0025 ; save the current value in working storage
                    bra       Code_1D2F ; continue at the selected control-flow target
Code_1CF1           leax      Data_2189,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    ldd       #Addr_0D01 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    leax      Data_2191,PCR ; form the referenced address without reading memory
                    ldb       #$1E      ; load the value needed by the following operation
                    lbsr      Code_0EB7 ; call the referenced helper routine
                    ldd       #Addr_680D ; load the value needed by the following operation
                    ldx       #Addr_6816 ; load the value needed by the following operation
                    lbsr      Code_10C4 ; call the referenced helper routine
                    lda       Code_004D ; load the value needed by the following operation
                    bmi       Code_1CDC ; branch while the tested value is negative
                    bne       Code_1D1C ; branch when the compared values differ
                    lbsr      Code_1FDB ; call the referenced helper routine
                    rts                 ; return to the caller
Code_1D1C           leax      $01F1,U   ; form the referenced address without reading memory
                    ldd       #Addr_200A ; load the value needed by the following operation
                    lbsr      Code_10BE ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    sta       ,X        ; save the current value in working storage
                    leax      $01F1,U   ; form the referenced address without reading memory
                    bra       Code_1D68 ; continue at the selected control-flow target
Code_1D2F           leax      $0154,U   ; form the referenced address without reading memory
                    lda       Addr_000F ; load the value needed by the following operation
                    cmpa      #$02      ; compare against the limit and set condition flags
                    bne       Code_1D68 ; branch when the compared values differ
                    ldb       #$0A      ; load the value needed by the following operation
Code_1D3B           lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bne       Code_1D4A ; branch when the compared values differ
                    decb                ; decrement the selected counter
                    bgt       Code_1D3B ; branch when the signed value is above the limit
                    leax      $0154,U   ; form the referenced address without reading memory
                    bra       Code_1D68 ; continue at the selected control-flow target
Code_1D4A           leay      $0241,U   ; form the referenced address without reading memory
                    leax      $0154,U   ; form the referenced address without reading memory
                    stx       ,Y        ; save the current value in working storage
                    leax      Data_21D1,PCR ; form the referenced address without reading memory
                    stx       $02,Y     ; save the current value in working storage
                    leax      >$004E,U  ; form the referenced address without reading memory
                    stx       $04,Y     ; save the current value in working storage
                    lda       #$36      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "J"                            ; embedded text or resource bytes
                    bra       Code_1DA1 ; continue at the selected control-flow target
Code_1D68           leay      $0241,U   ; form the referenced address without reading memory
                    stx       ,Y        ; save the current value in working storage
                    leax      Data_21D1,PCR ; form the referenced address without reading memory
                    stx       $02,Y     ; save the current value in working storage
                    leax      >$004E,U  ; form the referenced address without reading memory
                    stx       $04,Y     ; save the current value in working storage
                    lda       Addr_000F ; load the value needed by the following operation
                    cmpa      #$02      ; compare against the limit and set condition flags
                    bne       Code_1D89 ; branch when the compared values differ
                    clra                ; clear the selected byte or register
                    sta       $06,Y     ; save the current value in working storage
                    leax      Data_21C3,PCR ; form the referenced address without reading memory
                    bra       Code_1D90 ; continue at the selected control-flow target
Code_1D89           lda       #$18      ; load the value needed by the following operation
                    sta       $06,Y     ; save the current value in working storage
                    ldx       #DeskMateService ; load the value needed by the following operation
Code_1D90           lda       #$36      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $16       ; private DeskMate service selector
                    lbsr      Code_50FD ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_1DA1 ; branch when the compared values are equal
Code_1D9C           clr       Addr_000F ; clear the selected byte or register
                    lbra      Code_1E1B ; continue at the distant control-flow target
Code_1DA1           lbsr      Code_3738 ; call the referenced helper routine
                    ldx       $04,Y     ; load the value needed by the following operation
                    lbsr      Code_1E9A ; call the referenced helper routine
                    bcs       Code_1E1B ; branch when carry reports an unsigned underflow or error
                    sta       Code_0032 ; save the current value in working storage
                    leay      $01F1,U   ; form the referenced address without reading memory
                    ldd       #Data_4C02 ; load the value needed by the following operation
                    std       ,Y++      ; store the value and advance the destination pointer
                    ldd       Code_0022 ; load the value needed by the following operation
                    std       ,Y++      ; store the value and advance the destination pointer
                    pshs      D         ; preserve the listed registers on the stack
                    ldd       Addr_0024 ; load the value needed by the following operation
                    suba      ,S+       ; subtract the operand from the running value
                    subb      ,S+       ; subtract the operand from the running value
                    std       ,Y++      ; store the value and advance the destination pointer
                    incb                ; advance the selected counter
                    clra                ; clear the selected byte or register
                    pshs      D         ; preserve the listed registers on the stack
                    addd      ,S        ; add the operand to the running value
                    addd      #Addr_0006 ; add the operand to the running value
                    std       Addr_0027 ; save the current value in working storage
                    lda       $01,S     ; load the value needed by the following operation
                    sta       ,S        ; save the current value in working storage
                    lda       Addr_0023 ; load the value needed by the following operation
                    leax      $008C,U   ; form the referenced address without reading memory
Code_1DD9           ldb       A,X       ; load the value needed by the following operation
                    stb       ,Y+       ; store the value and advance the destination pointer
                    inca                ; advance the selected counter
                    dec       ,S        ; decrement the selected counter
                    bgt       Code_1DD9 ; branch when the signed value is above the limit
                    leas      $01,S     ; form the referenced address without reading memory
                    lda       Addr_0023 ; load the value needed by the following operation
                    leax      $00F0,U   ; form the referenced address without reading memory
Code_1DEA           ldb       A,X       ; load the value needed by the following operation
                    stb       ,Y+       ; store the value and advance the destination pointer
                    inca                ; advance the selected counter
                    dec       ,S        ; decrement the selected counter
                    bgt       Code_1DEA ; branch when the signed value is above the limit
                    leas      $01,S     ; form the referenced address without reading memory
                    ldy       Addr_0027 ; load the value needed by the following operation
                    leax      $01F1,U   ; form the referenced address without reading memory
                    lda       Code_0032 ; load the value needed by the following operation
                    lbsr      Code_1EF6 ; call the referenced helper routine
                    bcs       Code_1E16 ; branch when carry reports an unsigned underflow or error
                    tst       Addr_0006 ; set condition flags from the current value
                    bne       Code_1E34 ; branch when the compared values differ
                    ldx       Addr_0002 ; load the value needed by the following operation
                    ldd       Addr_0004 ; load the value needed by the following operation
                    subd      Addr_0002 ; subtract the operand from the running value
                    beq       Code_1E16 ; branch when the compared values are equal
                    tfr       D,Y       ; copy the source register into the destination register
                    lda       Code_0032 ; load the value needed by the following operation
                    lbsr      Code_1EF6 ; call the referenced helper routine
Code_1E16           lda       Code_0032 ; load the value needed by the following operation
                    lbsr      Code_1F1D ; call the referenced helper routine
Code_1E1B           lda       Addr_000F ; load the value needed by the following operation
                    cmpa      #$02      ; compare against the limit and set condition flags
                    bne       Code_1E25 ; branch when the compared values differ
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "W"                            ; embedded text or resource bytes
Code_1E25           tst       Addr_0006 ; set condition flags from the current value
                    bne       Code_1E2C ; branch when the compared values differ
                    lbsr      Code_094E ; call the referenced helper routine
Code_1E2C           lbsr      Code_374F ; call the referenced helper routine
                    clr       Addr_0006 ; clear the selected byte or register
                    clr       Addr_000F ; clear the selected byte or register
                    rts                 ; return to the caller
Code_1E34           clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    std       Addr_0027 ; save the current value in working storage
                    leay      $01F1,U   ; form the referenced address without reading memory
                    ldx       Addr_0002 ; load the value needed by the following operation
Code_1E3E           lbsr      Code_3768 ; call the referenced helper routine
                    ldd       ,X        ; load the value needed by the following operation
                    blt       Code_1E6B ; branch when the signed value is below the limit
                    std       Addr_004C ; save the current value in working storage
                    lbsr      Code_2747 ; call the referenced helper routine
                    cmpa      #$01      ; compare against the limit and set condition flags
                    bne       Code_1E8F ; branch when the compared values differ
                    lbsr      Code_0FB0 ; call the referenced helper routine
                    pshs      B         ; preserve the listed registers on the stack
                    clra                ; clear the selected byte or register
                    addd      Addr_0027 ; add the operand to the running value
                    cmpd      #Code_0100 ; compare against the limit and set condition flags
                    bgt       Code_1E8B ; branch when the signed value is above the limit
                    std       Addr_0027 ; save the current value in working storage
                    puls      B         ; restore the listed registers from the stack
                    lbsr      Code_0FB7 ; call the referenced helper routine
                    ldd       Addr_0027 ; load the value needed by the following operation
                    cmpd      #Code_0100 ; compare against the limit and set condition flags
                    blt       Code_1E3E ; branch when the signed value is below the limit
Code_1E6B           pshs      X         ; preserve the listed registers on the stack
                    leax      $01F1,U   ; form the referenced address without reading memory
                    ldy       Addr_0027 ; load the value needed by the following operation
                    lda       Code_0032 ; load the value needed by the following operation
                    lbsr      Code_1EF6 ; call the referenced helper routine
                    bcs       Code_1E95 ; branch when carry reports an unsigned underflow or error
                    leay      $01F1,U   ; form the referenced address without reading memory
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    std       Addr_0027 ; save the current value in working storage
                    puls      X         ; restore the listed registers from the stack
                    lda       ,X        ; load the value needed by the following operation
                    blt       Code_1E16 ; branch when the signed value is below the limit
                    bra       Code_1E3E ; continue at the selected control-flow target
Code_1E8B           leas      $01,S     ; form the referenced address without reading memory
                    bra       Code_1E6B ; continue at the selected control-flow target
Code_1E8F           lbsr      Code_0FB0 ; call the referenced helper routine
                    abx                 ; add the operand to the running value
                    bra       Code_1E3E ; continue at the selected control-flow target
Code_1E95           leas      $02,S     ; form the referenced address without reading memory
                    lbra      Code_1E16 ; continue at the distant control-flow target
Code_1E9A           pshs      X         ; preserve the listed registers on the stack
                    ldd       #Addr_0203 ; load the value needed by the following operation
                    os9       I$Create  ; request the named OS-9 service
                    puls      X         ; restore the listed registers from the stack
                    bcc       Code_1EB9 ; branch when carry is clear
                    pshs      CC        ; preserve the listed registers on the stack
                    cmpb      #$DA      ; compare against the limit and set condition flags
                    bne       Code_1ECC ; branch when the compared values differ
                    puls      CC        ; restore the listed registers from the stack
                    pshs      X         ; preserve the listed registers on the stack
                    os9       I$Delete  ; request the named OS-9 service
                    puls      X         ; restore the listed registers from the stack
                    bcs       Code_1ECA ; branch when carry reports an unsigned underflow or error
                    bra       Code_1E9A ; continue at the selected control-flow target
Code_1EB9           rts                 ; return to the caller
Code_1EBA           clr       Addr_0033 ; clear the selected byte or register
                    lda       #$01      ; load the value needed by the following operation
                    os9       I$Open    ; request the named OS-9 service
                    bcs       Code_1ECA ; branch when carry reports an unsigned underflow or error
                    rts                 ; return to the caller
Code_1EC4           os9       I$Read    ; request the named OS-9 service
                    bcs       Code_1ECA ; branch when carry reports an unsigned underflow or error
                    rts                 ; return to the caller
Code_1ECA           pshs      CC        ; preserve the listed registers on the stack
Code_1ECC           cmpb      #$D3      ; compare against the limit and set condition flags
                    bne       Code_1ED7 ; branch when the compared values differ
                    ldb       #$01      ; load the value needed by the following operation
                    stb       Addr_0033 ; save the current value in working storage
                    puls      CC        ; restore the listed registers from the stack
                    rts                 ; return to the caller
Code_1ED7           lda       Addr_000F ; load the value needed by the following operation
                    cmpa      #$03      ; compare against the limit and set condition flags
                    bne       Code_1EE5 ; branch when the compared values differ
Code_1EDD           cmpb      #$02      ; compare against the limit and set condition flags
                    beq       Code_1EF4 ; branch when the compared values are equal
                    ldb       #$04      ; load the value needed by the following operation
                    bra       Code_1EF1 ; continue at the selected control-flow target
Code_1EE5           cmpb      #$F8      ; compare against the limit and set condition flags
                    bne       Code_1EED ; branch when the compared values differ
                    ldb       #$07      ; load the value needed by the following operation
                    bra       Code_1EEF ; continue at the selected control-flow target
Code_1EED           ldb       #$03      ; load the value needed by the following operation
Code_1EEF           clr       Addr_000F ; clear the selected byte or register
Code_1EF1           lbsr      Code_0EC3 ; call the referenced helper routine
Code_1EF4           puls      PC,CC     ; restore the listed registers from the stack
Code_1EF6           pshs      Y         ; preserve the listed registers on the stack
                    os9       I$Write   ; request the named OS-9 service
                    bcs       Code_1F03 ; branch when carry reports an unsigned underflow or error
                    cmpy      ,S++      ; compare against the limit and set condition flags
                    bne       Code_1F05 ; branch when the compared values differ
                    rts                 ; return to the caller
Code_1F03           leas      $02,S     ; form the referenced address without reading memory
Code_1F05           cmpb      #$F8      ; compare against the limit and set condition flags
                    bne       Code_1ECA ; branch when the compared values differ
                    stb       Code_0049 ; save the current value in working storage
                    bra       Code_1ECA ; continue at the selected control-flow target
Code_1F0D           tfr       A,B       ; copy the source register into the destination register
                    pshs      Y         ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "S"                            ; embedded text or resource bytes
                    bcs       Code_1F03 ; branch when carry reports an unsigned underflow or error
                    cmpy      ,S++      ; compare against the limit and set condition flags
Code_1F1A           bne       Code_1ECA ; branch when the compared values differ
                    rts                 ; return to the caller
Code_1F1D           os9       I$Close   ; request the named OS-9 service
                    bcs       Code_1ECA ; branch when carry reports an unsigned underflow or error
                    tst       Code_0049 ; set condition flags from the current value
                    beq       Code_1F33 ; branch when the compared values are equal
                    pshs      X         ; preserve the listed registers on the stack
                    leax      >$004E,U  ; form the referenced address without reading memory
                    os9       I$Delete  ; request the named OS-9 service
                    clr       Code_0049 ; clear the selected byte or register
                    puls      X         ; restore the listed registers from the stack
Code_1F33           rts                 ; return to the caller
Code_1F34           leax      $01F1,U   ; form the referenced address without reading memory
                    ldd       #Addr_200A ; load the value needed by the following operation
                    lbsr      Code_10BE ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    sta       ,X        ; save the current value in working storage
                    leax      $01F1,U   ; form the referenced address without reading memory
                    lda       Data_0031 ; load the value needed by the following operation
                    cmpa      #$02      ; compare against the limit and set condition flags
                    bne       Code_1F51 ; branch when the compared values differ
                    leax      $0154,U   ; form the referenced address without reading memory
                    bra       Code_1F55 ; continue at the selected control-flow target
Code_1F51           lda       #$01      ; load the value needed by the following operation
                    sta       Data_0031 ; save the current value in working storage
Code_1F55           leay      $0241,U   ; form the referenced address without reading memory
                    stx       ,Y        ; save the current value in working storage
                    leax      Data_21D1,PCR ; form the referenced address without reading memory
                    stx       $02,Y     ; save the current value in working storage
                    leax      >$004E,U  ; form the referenced address without reading memory
                    stx       $04,Y     ; save the current value in working storage
                    lda       #$36      ; load the value needed by the following operation
                    lbsr      Code_52A6 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    bne       Code_1FCE ; branch when the compared values differ
                    ldx       $04,Y     ; load the value needed by the following operation
                    lbsr      Code_1EBA ; call the referenced helper routine
                    bcs       Code_1FCE ; branch when carry reports an unsigned underflow or error
                    sta       Code_0032 ; save the current value in working storage
Code_1F78           leax      $0241,U   ; form the referenced address without reading memory
                    ldy       #Addr_0002 ; load the value needed by the following operation
                    lbsr      Code_1EC4 ; call the referenced helper routine
                    bcs       Code_1FC9 ; branch when carry reports an unsigned underflow or error
                    ldd       ,X        ; load the value needed by the following operation
                    cmpd      #Data_4C01 ; compare against the limit and set condition flags
                    beq       Code_1F93 ; branch when the compared values are equal
                    cmpd      #Data_4C02 ; compare against the limit and set condition flags
                    bne       Code_1FD4 ; branch when the compared values differ
Code_1F93           lda       Code_0032 ; load the value needed by the following operation
                    leax      $0241,U   ; form the referenced address without reading memory
                    ldy       #Code_0100 ; load the value needed by the following operation
                    lbsr      Code_1EC4 ; call the referenced helper routine
                    bcs       Code_1FC9 ; branch when carry reports an unsigned underflow or error
                    sty       Addr_0027 ; save the current value in working storage
                    lda       Data_0031 ; load the value needed by the following operation
                    cmpa      #$02      ; compare against the limit and set condition flags
                    bne       Code_1FC0 ; branch when the compared values differ
                    ldd       Addr_0004 ; load the value needed by the following operation
                    subd      Addr_0002 ; subtract the operand from the running value
                    addd      Addr_002B ; add the operand to the running value
                    pshs      D         ; preserve the listed registers on the stack
                    ldd       Addr_0013 ; load the value needed by the following operation
                    addd      ,S++      ; add the operand to the running value
                    std       Addr_0013 ; save the current value in working storage
                    pshs      Y,X       ; preserve the listed registers on the stack
                    lbsr      Code_00D9 ; call the referenced helper routine
                    puls      Y,X       ; restore the listed registers from the stack
Code_1FC0           lbsr      Code_3738 ; call the referenced helper routine
                    lbsr      Code_2AE1 ; call the referenced helper routine
                    lbsr      Code_374F ; call the referenced helper routine
Code_1FC9           lda       Code_0032 ; load the value needed by the following operation
                    lbsr      Code_1F1D ; call the referenced helper routine
Code_1FCE           lbsr      Code_094E ; call the referenced helper routine
                    clr       Data_0031 ; clear the selected byte or register
                    rts                 ; return to the caller
Code_1FD4           ldb       #$06      ; load the value needed by the following operation
                    lbsr      Code_0EC3 ; call the referenced helper routine
                    bra       Code_1FC9 ; continue at the selected control-flow target
Code_1FDB           leay      $0241,U   ; form the referenced address without reading memory
                    leax      $015F,U   ; form the referenced address without reading memory
                    stx       ,Y        ; save the current value in working storage
                    leax      Data_21CD,PCR ; form the referenced address without reading memory
                    stx       $02,Y     ; save the current value in working storage
                    leax      >$004E,U  ; form the referenced address without reading memory
                    stx       $04,Y     ; save the current value in working storage
                    lda       #$18      ; load the value needed by the following operation
                    sta       $06,Y     ; save the current value in working storage
                    ldx       #DeskMateService ; load the value needed by the following operation
                    lda       #$36      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $16       ; private DeskMate service selector
                    lbsr      Code_50FD ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    bne       Code_2018 ; branch when the compared values differ
                    ldx       $04,Y     ; load the value needed by the following operation
                    lbsr      Code_1E9A ; call the referenced helper routine
                    bcs       Code_2018 ; branch when carry reports an unsigned underflow or error
                    sta       Code_0032 ; save the current value in working storage
                    lda       #$01      ; load the value needed by the following operation
                    sta       Addr_000F ; save the current value in working storage
                    ldd       #Code_0100 ; load the value needed by the following operation
Code_2014           std       Addr_001B ; save the current value in working storage
                    bsr       Code_201D ; call the referenced helper routine
Code_2018           clr       Addr_000F ; clear the selected byte or register
                    clr       Addr_0006 ; clear the selected byte or register
                    rts                 ; return to the caller
Code_201D           lbsr      Code_3738 ; call the referenced helper routine
Code_2020           leax      $03AE,U   ; form the referenced address without reading memory
                    tfr       X,Y       ; copy the source register into the destination register
                    ldd       #Code_0064 ; load the value needed by the following operation
                    lbsr      Code_10BE ; call the referenced helper routine
                    ldx       Addr_0002 ; load the value needed by the following operation
Code_202E           ldd       ,X        ; load the value needed by the following operation
                    blt       Code_203A ; branch when the signed value is below the limit
Code_2032           inc       A,Y       ; advance the selected counter
                    lbsr      Code_0FB0 ; call the referenced helper routine
                    abx                 ; add the operand to the running value
                    bra       Code_202E ; continue at the selected control-flow target
Code_203A           leay      $01F1,U   ; form the referenced address without reading memory
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
Code_2040           std       Addr_0027 ; save the current value in working storage
                    ldd       #Code_2020 ; load the value needed by the following operation
                    leax      $0193,U   ; form the referenced address without reading memory
                    lbsr      Code_10BE ; call the referenced helper routine
                    lda       Addr_0023 ; load the value needed by the following operation
                    sta       Addr_001F ; save the current value in working storage
Code_2050           ldd       Code_0022 ; load the value needed by the following operation
                    leax      $03AE,U   ; form the referenced address without reading memory
                    tst       A,X       ; set condition flags from the current value
                    beq       Code_2097 ; branch when the compared values are equal
                    lbsr      Code_0F2F ; call the referenced helper routine
                    leax      ,X        ; form the referenced address without reading memory
                    bne       Code_2067 ; branch when the compared values differ
                    leax      $0193,U   ; form the referenced address without reading memory
                    bra       Code_2076 ; continue at the selected control-flow target
Code_2067           lbsr      Code_0B62 ; call the referenced helper routine
                    lda       Code_0022 ; load the value needed by the following operation
                    leax      $03AE,U   ; form the referenced address without reading memory
                    dec       A,X       ; decrement the selected counter
                    leax      $01C9,U   ; form the referenced address without reading memory
Code_2076           pshs      X         ; preserve the listed registers on the stack
                    leax      $008C,U   ; form the referenced address without reading memory
                    lda       Addr_0023 ; load the value needed by the following operation
                    ldb       A,X       ; load the value needed by the following operation
                    puls      X         ; restore the listed registers from the stack
                    clra                ; clear the selected byte or register
                    pshs      D         ; preserve the listed registers on the stack
                    lbsr      Code_0FB7 ; call the referenced helper routine
                    ldd       Addr_0027 ; load the value needed by the following operation
                    addd      ,S++      ; add the operand to the running value
                    std       Addr_0027 ; save the current value in working storage
                    lda       Addr_0023 ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    sta       Addr_0023 ; save the current value in working storage
                    cmpa      Data_0025 ; compare against the limit and set condition flags
                    ble       Code_20B6 ; branch when the signed value is at or below the limit
Code_2097           lda       #$0D      ; load the value needed by the following operation
                    sta       ,Y+       ; store the value and advance the destination pointer
                    ldd       Addr_0027 ; load the value needed by the following operation
                    addd      #Addr_0001 ; add the operand to the running value
                    std       Addr_0027 ; save the current value in working storage
                    inc       Code_0022 ; advance the selected counter
                    lda       Code_0022 ; load the value needed by the following operation
                    cmpa      Addr_0024 ; compare against the limit and set condition flags
                    bgt       Code_20ED ; branch when the signed value is above the limit
                    leax      $03AE,U   ; form the referenced address without reading memory
                    tst       A,X       ; set condition flags from the current value
                    beq       Code_2097 ; branch when the compared values are equal
                    lda       Addr_001F ; load the value needed by the following operation
                    sta       Addr_0023 ; save the current value in working storage
Code_20B6           leax      $008C,U   ; form the referenced address without reading memory
                    ldb       A,X       ; load the value needed by the following operation
                    clra                ; clear the selected byte or register
                    addd      Addr_0027 ; add the operand to the running value
                    cmpd      Addr_001B ; compare against the limit and set condition flags
                    ble       Code_2050 ; branch when the signed value is at or below the limit
                    leax      $01F1,U   ; form the referenced address without reading memory
                    ldy       Addr_0027 ; load the value needed by the following operation
                    lda       Code_0032 ; load the value needed by the following operation
                    ldb       Addr_000F ; load the value needed by the following operation
                    cmpb      #$03      ; compare against the limit and set condition flags
                    bne       Code_20DA ; branch when the compared values differ
                    lbsr      Code_1F0D ; call the referenced helper routine
                    bcs       Code_2107 ; branch when carry reports an unsigned underflow or error
                    bra       Code_20DF ; continue at the selected control-flow target
Code_20DA           lbsr      Code_1EF6 ; call the referenced helper routine
                    bcs       Code_2107 ; branch when carry reports an unsigned underflow or error
Code_20DF           lbsr      Code_3768 ; call the referenced helper routine
                    leay      $01F1,U   ; form the referenced address without reading memory
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    std       Addr_0027 ; save the current value in working storage
                    lbra      Code_2050 ; continue at the distant control-flow target
Code_20ED           ldd       Addr_0027 ; load the value needed by the following operation
                    beq       Code_2107 ; branch when the compared values are equal
                    tfr       D,Y       ; copy the source register into the destination register
                    leax      $01F1,U   ; form the referenced address without reading memory
                    lda       Code_0032 ; load the value needed by the following operation
                    ldb       Addr_000F ; load the value needed by the following operation
                    cmpb      #$03      ; compare against the limit and set condition flags
                    bne       Code_2104 ; branch when the compared values differ
                    lbsr      Code_1F0D ; call the referenced helper routine
                    bra       Code_2107 ; continue at the selected control-flow target
Code_2104           lbsr      Code_1EF6 ; call the referenced helper routine
Code_2107           lda       Code_0032 ; load the value needed by the following operation
                    ldb       Addr_000F ; load the value needed by the following operation
                    cmpb      #$03      ; compare against the limit and set condition flags
                    bne       Code_211A ; branch when the compared values differ
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "R"                            ; embedded text or resource bytes
                    bcc       Code_211D ; branch when carry is clear
                    lbsr      Code_1ECA ; call the referenced helper routine
                    bra       Code_211D ; continue at the selected control-flow target
Code_211A           lbsr      Code_1F1D ; call the referenced helper routine
Code_211D           clr       Addr_000F ; clear the selected byte or register
                    clr       Addr_0006 ; clear the selected byte or register
                    lbsr      Code_374F ; call the referenced helper routine
                    rts                 ; return to the caller
Code_2125           pshs      CC        ; preserve the listed registers on the stack
                    clr       Addr_0006 ; clear the selected byte or register
                    clr       Addr_000F ; clear the selected byte or register
                    lbra      Code_1EDD ; continue at the distant control-flow target
Code_212E           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Q"                            ; embedded text or resource bytes
                    bcs       Code_2125 ; branch when carry reports an unsigned underflow or error
                    sta       Code_0032 ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "N"                            ; embedded text or resource bytes
                    clr       $0C,X     ; clear the selected byte or register
                    clr       $0D,X     ; clear the selected byte or register
                    lda       #$FF      ; load the value needed by the following operation
                    sta       $1A,X     ; save the current value in working storage
                    lda       #$03      ; load the value needed by the following operation
                    sta       Addr_000F ; save the current value in working storage
                    ldd       #Addr_0084 ; load the value needed by the following operation
                    std       Addr_001B ; save the current value in working storage
                    tst       Addr_0006 ; set condition flags from the current value
                    bne       Code_217A ; branch when the compared values differ
                    lda       #$01      ; load the value needed by the following operation
                    sta       Code_0022 ; save the current value in working storage
                    sta       Addr_0023 ; save the current value in working storage
                    sta       Addr_0024 ; save the current value in working storage
                    sta       Data_0025 ; save the current value in working storage
                    ldx       Addr_0002 ; load the value needed by the following operation
Code_215C           ldd       ,X        ; load the value needed by the following operation
                    blt       Code_2172 ; branch when the signed value is below the limit
                    cmpa      Addr_0024 ; compare against the limit and set condition flags
                    ble       Code_2166 ; branch when the signed value is at or below the limit
                    sta       Addr_0024 ; save the current value in working storage
Code_2166           cmpb      Data_0025 ; compare against the limit and set condition flags
                    ble       Code_216C ; branch when the signed value is at or below the limit
                    stb       Data_0025 ; save the current value in working storage
Code_216C           lbsr      Code_0FB0 ; call the referenced helper routine
                    abx                 ; add the operand to the running value
                    bra       Code_215C ; continue at the selected control-flow target
Code_2172           ldd       Addr_0024 ; load the value needed by the following operation
                    cmpd      Code_0022 ; compare against the limit and set condition flags
                    bne       Code_217A ; branch when the compared values differ
                    rts                 ; return to the caller
Code_217A           lbsr      Code_201D ; call the referenced helper routine
                    lbsr      Code_11C9 ; call the referenced helper routine
                    rts                 ; return to the caller
Data_2181           fcb       $00,$04,$06,$18,$05,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $18       ; table, bitmap, or initialized data bytes
Data_2189           fcb       $00,$00,$0C ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $03,$00   ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $18       ; table, bitmap, or initialized data bytes
Data_2191           fcc       "Block save     Text  "        ; embedded text or resource bytes
                    fcc       "   Ledger"                    ; embedded text or resource bytes
Data_21AF           fcc       "Save?     yes     no"         ; embedded text or resource bytes
Data_21C3           fcc       "Filename:"                    ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_21CD           fcc       "DOC"                          ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_21D1           fcc       "WKS"                          ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_21D5           lda       Addr_0011 ; load the value needed by the following operation
                    cmpa      #$0C      ; compare against the limit and set condition flags
                    beq       Code_21EB ; branch when the compared values are equal
                    cmpa      #$08      ; compare against the limit and set condition flags
                    beq       Code_21E5 ; branch when the compared values are equal
                    cmpa      #$09      ; compare against the limit and set condition flags
                    beq       Code_21E8 ; branch when the compared values are equal
                    bra       Code_2247 ; continue at the selected control-flow target
Code_21E5           lbra      Code_2290 ; continue at the distant control-flow target
Code_21E8           lbra      Code_23C7 ; continue at the distant control-flow target
Code_21EB           pshs      Y,X,B     ; preserve the listed registers on the stack
                    lda       Addr_0007 ; load the value needed by the following operation
                    cmpa      #$01      ; compare against the limit and set condition flags
                    ble       Code_2244 ; branch when the signed value is at or below the limit
                    tst       Addr_0006 ; set condition flags from the current value
                    bne       Code_21FE ; branch when the compared values differ
                    tst       Addr_001A ; set condition flags from the current value
                    bne       Code_21FE ; branch when the compared values differ
                    lbsr      Code_0B2F ; call the referenced helper routine
Code_21FE           lda       Addr_0009 ; load the value needed by the following operation
                    cmpa      Addr_0007 ; compare against the limit and set condition flags
                    bne       Code_2231 ; branch when the compared values differ
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    lda       Addr_000A ; load the value needed by the following operation
                    suba      Addr_0009 ; subtract the operand from the running value
                    inca                ; advance the selected counter
                    cmpa      Addr_0041 ; compare against the limit and set condition flags
                    blt       Code_2213 ; branch when the signed value is below the limit
                    dec       Addr_000A ; decrement the selected counter
Code_2213           dec       Addr_0009 ; decrement the selected counter
                    dec       Addr_0007 ; decrement the selected counter
                    clra                ; clear the selected byte or register
                    ldb       Addr_003D ; load the value needed by the following operation
                    tfr       D,Y       ; copy the source register into the destination register
                    ldx       #DeskMateService ; load the value needed by the following operation
                    lda       Addr_0041 ; load the value needed by the following operation
                    ldb       Addr_0040 ; load the value needed by the following operation
                    ldu       #Addr_2000 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "'"                            ; embedded text or resource bytes
                    ldu       DeskMateService ; load the value needed by the following operation
                    lbsr      Code_0C8A ; call the referenced helper routine
                    bra       Code_2233 ; continue at the selected control-flow target
Code_2231           dec       Addr_0007 ; decrement the selected counter
Code_2233           ldd       Addr_0007 ; load the value needed by the following operation
                    lbsr      Code_0F2F ; call the referenced helper routine
                    stx       Addr_000D ; save the current value in working storage
                    lbsr      Code_09EC ; call the referenced helper routine
                    lbsr      Code_11C9 ; call the referenced helper routine
                    lda       #$01      ; load the value needed by the following operation
                    puls      PC,Y,X,B  ; restore the listed registers from the stack
Code_2244           clra                ; clear the selected byte or register
                    puls      PC,Y,X,B  ; restore the listed registers from the stack
Code_2247           pshs      Y,X,B     ; preserve the listed registers on the stack
                    lda       Addr_0007 ; load the value needed by the following operation
                    cmpa      #$63      ; compare against the limit and set condition flags
                    beq       Code_2244 ; branch when the compared values are equal
                    tst       Addr_0006 ; set condition flags from the current value
                    bne       Code_225A ; branch when the compared values differ
                    tst       Addr_001A ; set condition flags from the current value
                    bne       Code_225A ; branch when the compared values differ
                    lbsr      Code_0B2F ; call the referenced helper routine
Code_225A           cmpa      Addr_000A ; compare against the limit and set condition flags
                    bne       Code_2282 ; branch when the compared values differ
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    inc       Addr_0009 ; advance the selected counter
                    inc       Addr_000A ; advance the selected counter
                    inc       Addr_0007 ; advance the selected counter
                    clra                ; clear the selected byte or register
                    ldb       Addr_003D ; load the value needed by the following operation
                    tfr       D,Y       ; copy the source register into the destination register
                    ldx       #DeskMateService ; load the value needed by the following operation
                    lda       Addr_0041 ; load the value needed by the following operation
                    ldb       Addr_0040 ; load the value needed by the following operation
                    ldu       #Addr_2000 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $26       ; private DeskMate service selector
                    ldu       DeskMateService ; load the value needed by the following operation
                    lbsr      Code_0C8A ; call the referenced helper routine
                    bra       Code_2233 ; continue at the selected control-flow target
Code_2282           tst       Addr_0007 ; set condition flags from the current value
                    beq       Code_228A ; branch when the compared values are equal
                    inc       Addr_0007 ; advance the selected counter
                    bra       Code_2233 ; continue at the selected control-flow target
Code_228A           lda       Addr_0009 ; load the value needed by the following operation
                    sta       Addr_0007 ; save the current value in working storage
                    bra       Code_2233 ; continue at the selected control-flow target
Code_2290           pshs      Y,X,B     ; preserve the listed registers on the stack
                    lda       Addr_0008 ; load the value needed by the following operation
                    cmpa      #$01      ; compare against the limit and set condition flags
                    ble       Code_22A8 ; branch when the signed value is at or below the limit
                    cmpa      Addr_000B ; compare against the limit and set condition flags
                    beq       Code_22AB ; branch when the compared values are equal
                    tst       Addr_001A ; set condition flags from the current value
                    bne       Code_22A3 ; branch when the compared values differ
                    lbsr      Code_0B2F ; call the referenced helper routine
Code_22A3           dec       Addr_0008 ; decrement the selected counter
                    lbra      Code_2233 ; continue at the distant control-flow target
Code_22A8           clra                ; clear the selected byte or register
                    puls      PC,Y,X,B  ; restore the listed registers from the stack
Code_22AB           tst       Addr_001A ; set condition flags from the current value
                    bne       Code_22B2 ; branch when the compared values differ
                    lbsr      Code_0B2F ; call the referenced helper routine
Code_22B2           lbsr      Code_23B2 ; call the referenced helper routine
                    dec       Addr_000B ; decrement the selected counter
                    dec       Addr_0008 ; decrement the selected counter
                    lbsr      Code_0E5A ; call the referenced helper routine
                    leax      $0354,U   ; form the referenced address without reading memory
                    lda       Addr_000C ; load the value needed by the following operation
                    cmpa      ,X        ; compare against the limit and set condition flags
                    bge       Code_22D7 ; branch when the signed value is at least the limit
Code_22C6           ldd       Addr_0007 ; load the value needed by the following operation
                    lbsr      Code_0F2F ; call the referenced helper routine
                    stx       Addr_000D ; save the current value in working storage
                    lbsr      Code_094E ; call the referenced helper routine
                    lbsr      Code_11C9 ; call the referenced helper routine
                    lda       #$01      ; load the value needed by the following operation
                    puls      PC,Y,X,B  ; restore the listed registers from the stack
Code_22D7           lbsr      start     ;22D7: 17 DD 3B       '.. ; call the referenced helper routine
                    fcb       $17       ; private DeskMate service selector
                    leay      $008C,U   ; form the referenced address without reading memory
                    clrb                ; clear the selected byte or register
Code_22E0           addb      A,Y       ; add the operand to the running value
                    deca                ; decrement the selected counter
                    cmpa      ,X        ; compare against the limit and set condition flags
                    bge       Code_22E0 ; branch when the signed value is at least the limit
                    lda       Code_0045 ; load the value needed by the following operation
                    pshs      D         ; preserve the listed registers on the stack
                    lda       Code_0043 ; load the value needed by the following operation
                    ldb       Data_003E ; load the value needed by the following operation
                    tfr       D,X       ; copy the source register into the destination register
                    lda       Addr_000B ; load the value needed by the following operation
                    ldb       A,Y       ; load the value needed by the following operation
                    clra                ; clear the selected byte or register
                    tfr       D,Y       ; copy the source register into the destination register
                    ldd       #Addr_2000 ; load the value needed by the following operation
                    ldu       ,S        ; load the value needed by the following operation
                    bsr       Code_2332 ; call the referenced helper routine
                    ldu       DeskMateService ; load the value needed by the following operation
                    leay      $0183,U   ; form the referenced address without reading memory
                    ldb       $01,Y     ; load the value needed by the following operation
                    addb      $01,S     ; add the operand to the running value
                    clra                ; clear the selected byte or register
                    tfr       D,X       ; copy the source register into the destination register
                    std       ,S        ; save the current value in working storage
                    ldb       Code_0043 ; load the value needed by the following operation
                    tfr       D,Y       ; copy the source register into the destination register
                    ldb       Addr_0040 ; load the value needed by the following operation
                    subd      ,S++      ; subtract the operand from the running value
                    beq       Code_2323 ; branch when the compared values are equal
                    lda       Code_0045 ; load the value needed by the following operation
                    ldu       #Addr_2000 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "%"                            ; embedded text or resource bytes
                    ldu       DeskMateService ; load the value needed by the following operation
Code_2323           lda       #$01      ; load the value needed by the following operation
                    lbsr      Code_0DA5 ; call the referenced helper routine
                    lbra      Code_2233 ; continue at the distant control-flow target
Code_232B           pshs      U,Y,X,D   ; preserve the listed registers on the stack
                    clra                ; clear the selected byte or register
                    ldb       #$5C      ; load the value needed by the following operation
                    bra       Code_233E ; continue at the selected control-flow target
Code_2332           pshs      U,Y,X,D   ; preserve the listed registers on the stack
                    lda       $07,S     ; load the value needed by the following operation
                    ldb       #$5A      ; load the value needed by the following operation
                    tst       Addr_004A ; set condition flags from the current value
                    bne       Code_233D ; branch when the compared values differ
                    asla                ; shift left and update carry
Code_233D           deca                ; decrement the selected counter
Code_233E           stb       >Code_2383,PCR ; save the current value in working storage
                    pshs      A         ; preserve the listed registers on the stack
                    ldd       $07,S     ; load the value needed by the following operation
                    tst       Addr_004A ; set condition flags from the current value
                    bne       Code_234B ; branch when the compared values differ
                    aslb                ; shift left and update carry
Code_234B           asla                ; shift left and update carry
                    asla                ; shift left and update carry
                    asla                ; shift left and update carry
                    pshs      D,CC      ; preserve the listed registers on the stack
                    ldb       $06,S     ; load the value needed by the following operation
                    aslb                ; shift left and update carry
                    aslb                ; shift left and update carry
                    aslb                ; shift left and update carry
                    lda       #$50      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    tfr       D,X       ; copy the source register into the destination register
                    ldb       $07,S     ; load the value needed by the following operation
                    tst       Addr_004A ; set condition flags from the current value
                    bne       Code_2361 ; branch when the compared values differ
                    aslb                ; shift left and update carry
Code_2361           leax      B,X       ; form the referenced address without reading memory
                    ldd       Code_0034 ; load the value needed by the following operation
                    leax      D,X       ; form the referenced address without reading memory
                    ldb       $09,S     ; load the value needed by the following operation
                    tst       Addr_004A ; set condition flags from the current value
                    bne       Code_236E ; branch when the compared values differ
                    aslb                ; shift left and update carry
Code_236E           lda       #$02      ; load the value needed by the following operation
                    bita      >Code_2383,PCR ; test the selected flag bits without changing the value
                    bne       Code_2377 ; branch when the compared values differ
                    negb                ; form the two's-complement negative value
Code_2377           leau      B,X       ; form the referenced address without reading memory
Code_2379           lda       $02,S     ; load the value needed by the following operation
                    sta       ,S        ; save the current value in working storage
                    ldb       $03,S     ; load the value needed by the following operation
Code_237F           lda       B,X       ; load the value needed by the following operation
                    sta       B,U       ; save the current value in working storage
Code_2383           nop       ;         leave processor state unchanged
                    dec       ,S        ; decrement the selected counter
                    bne       Code_237F ; branch when the compared values differ
                    leax      $50,X     ; form the referenced address without reading memory
                    leau      $50,U     ; form the referenced address without reading memory
                    dec       $01,S     ; decrement the selected counter
                    bne       Code_2379 ; branch when the compared values differ
                    leas      $03,S     ; form the referenced address without reading memory
                    puls      A         ; restore the listed registers from the stack
                    ldb       $03,S     ; load the value needed by the following operation
                    tsta                ; set condition flags from the current value
                    bne       Code_239F ; branch when the compared values differ
                    subb      $05,S     ; subtract the operand from the running value
                    addb      $07,S     ; add the operand to the running value
Code_239F           clra                ; clear the selected byte or register
                    tfr       D,X       ; copy the source register into the destination register
                    ldb       $02,S     ; load the value needed by the following operation
                    tfr       D,Y       ; copy the source register into the destination register
                    ldu       ,S        ; load the value needed by the following operation
                    lda       $06,S     ; load the value needed by the following operation
                    ldb       $05,S     ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "%"                            ; embedded text or resource bytes
                    puls      PC,U,Y,X,D ; restore the listed registers from the stack
Code_23B2           leay      $0354,U   ; form the referenced address without reading memory
                    ldd       Addr_000B ; load the value needed by the following operation
                    std       ,Y++      ; store the value and advance the destination pointer
                    leax      $0183,U   ; form the referenced address without reading memory
                    pshs      A         ; preserve the listed registers on the stack
                    subb      ,S+       ; subtract the operand from the running value
                    incb                ; advance the selected counter
                    lbsr      Code_0FB7 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_23C7           pshs      Y,X,B     ; preserve the listed registers on the stack
                    lda       Addr_0008 ; load the value needed by the following operation
                    cmpa      #$63      ; compare against the limit and set condition flags
                    beq       Code_23E9 ; branch when the compared values are equal
                    cmpa      Addr_000C ; compare against the limit and set condition flags
                    beq       Code_23EC ; branch when the compared values are equal
                    tst       Addr_001A ; set condition flags from the current value
                    bne       Code_23DA ; branch when the compared values differ
                    lbsr      Code_0B2F ; call the referenced helper routine
Code_23DA           tst       Addr_0008 ; set condition flags from the current value
                    beq       Code_23E3 ; branch when the compared values are equal
                    inc       Addr_0008 ; advance the selected counter
Code_23E0           lbra      Code_2233 ; continue at the distant control-flow target
Code_23E3           lda       Addr_000B ; load the value needed by the following operation
                    sta       Addr_0008 ; save the current value in working storage
                    bra       Code_23E0 ; continue at the selected control-flow target
Code_23E9           clra                ; clear the selected byte or register
                    puls      PC,Y,X,B  ; restore the listed registers from the stack
Code_23EC           tst       Addr_001A ; set condition flags from the current value
                    bne       Code_23F3 ; branch when the compared values differ
                    lbsr      Code_0B2F ; call the referenced helper routine
Code_23F3           bsr       Code_23B2 ; call the referenced helper routine
                    inc       Addr_000C ; advance the selected counter
                    inc       Addr_0008 ; advance the selected counter
                    lbsr      Code_0E79 ; call the referenced helper routine
                    leax      $0354,U   ; form the referenced address without reading memory
                    lda       Addr_000B ; load the value needed by the following operation
                    cmpa      $01,X     ; compare against the limit and set condition flags
                    ble       Code_2409 ; branch when the signed value is at or below the limit
                    lbra      Code_22C6 ; continue at the distant control-flow target
Code_2409           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    leay      $008C,U   ; form the referenced address without reading memory
                    clrb                ; clear the selected byte or register
Code_2412           addb      A,Y       ; add the operand to the running value
                    inca                ; advance the selected counter
                    cmpa      $01,X     ; compare against the limit and set condition flags
                    ble       Code_2412 ; branch when the signed value is at or below the limit
                    lda       Code_0045 ; load the value needed by the following operation
                    pshs      D         ; preserve the listed registers on the stack
                    lda       Addr_000B ; load the value needed by the following operation
                    suba      ,X        ; subtract the operand from the running value
                    adda      #$02      ; add the operand to the running value
                    ldb       A,X       ; load the value needed by the following operation
                    lda       Code_0043 ; load the value needed by the following operation
                    tfr       D,X       ; copy the source register into the destination register
                    subb      Data_003E ; subtract the operand from the running value
                    clra                ; clear the selected byte or register
                    tfr       D,Y       ; copy the source register into the destination register
                    ldd       #Addr_2000 ; load the value needed by the following operation
                    ldu       ,S        ; load the value needed by the following operation
                    lbsr      Code_232B ; call the referenced helper routine
                    ldu       DeskMateService ; load the value needed by the following operation
                    clra                ; clear the selected byte or register
                    ldb       $01,S     ; load the value needed by the following operation
                    addb      Data_003E ; add the operand to the running value
                    tfr       D,X       ; copy the source register into the destination register
                    ldb       Code_0043 ; load the value needed by the following operation
                    tfr       D,Y       ; copy the source register into the destination register
                    ldb       Addr_0040 ; load the value needed by the following operation
                    incb                ; advance the selected counter
                    stx       ,S        ; save the current value in working storage
                    subd      ,S++      ; subtract the operand from the running value
                    beq       Code_2457 ; branch when the compared values are equal
                    lda       Code_0045 ; load the value needed by the following operation
                    ldu       #Addr_2000 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "%"                            ; embedded text or resource bytes
                    ldu       DeskMateService ; load the value needed by the following operation
Code_2457           lda       Addr_000C ; load the value needed by the following operation
                    suba      Addr_0008 ; subtract the operand from the running value
                    inca                ; advance the selected counter
                    lbsr      Code_0DA5 ; call the referenced helper routine
                    lbra      Code_2233 ; continue at the distant control-flow target
Code_2462           lda       Addr_0011 ; load the value needed by the following operation
                    cmpa      #$12      ; compare against the limit and set condition flags
                    beq       Code_2488 ; branch when the compared values are equal
                    cmpa      #$10      ; compare against the limit and set condition flags
                    beq       Code_2498 ; branch when the compared values are equal
                    cmpa      #$11      ; compare against the limit and set condition flags
                    beq       Code_24BC ; branch when the compared values are equal
                    cmpa      #$13      ; compare against the limit and set condition flags
                    beq       Code_24D8 ; branch when the compared values are equal
                    cmpa      #$1A      ; compare against the limit and set condition flags
                    lbeq      Code_256E ; take the distant branch when values are equal
                    cmpa      #$18      ; compare against the limit and set condition flags
                    lbeq      Code_254B ; take the distant branch when values are equal
                    cmpa      #$19      ; compare against the limit and set condition flags
                    lbeq      Code_2521 ; take the distant branch when values are equal
                    bra       Code_24F1 ; continue at the selected control-flow target
Code_2488           lda       Addr_0007 ; load the value needed by the following operation
                    cmpa      #$63      ; compare against the limit and set condition flags
                    beq       Code_24B0 ; branch when the compared values are equal
                    lda       #$63      ; load the value needed by the following operation
                    sta       Addr_0009 ; save the current value in working storage
                    sta       Addr_000A ; save the current value in working storage
                    sta       Addr_0007 ; save the current value in working storage
                    bra       Code_24CA ; continue at the selected control-flow target
Code_2498           lda       Addr_0008 ; load the value needed by the following operation
                    cmpa      #$01      ; compare against the limit and set condition flags
                    bgt       Code_24B1 ; branch when the signed value is above the limit
                    tst       Addr_0006 ; set condition flags from the current value
                    bne       Code_24B0 ; branch when the compared values differ
                    tst       Addr_0007 ; set condition flags from the current value
                    beq       Code_24B0 ; branch when the compared values are equal
                    lbsr      Code_0B2F ; call the referenced helper routine
                    clr       Addr_0008 ; clear the selected byte or register
                    clr       Addr_000D ; clear the selected byte or register
                    lbsr      Code_09EC ; call the referenced helper routine
Code_24B0           rts                 ; return to the caller
Code_24B1           ldb       #$01      ; load the value needed by the following operation
                    stb       Addr_0008 ; save the current value in working storage
                    stb       Addr_000B ; save the current value in working storage
                    lbsr      Code_0E5A ; call the referenced helper routine
                    bra       Code_24CA ; continue at the selected control-flow target
Code_24BC           ldb       Addr_0008 ; load the value needed by the following operation
                    cmpb      #$63      ; compare against the limit and set condition flags
                    beq       Code_24B0 ; branch when the compared values are equal
                    ldb       #$63      ; load the value needed by the following operation
                    stb       Addr_000B ; save the current value in working storage
                    stb       Addr_000C ; save the current value in working storage
                    stb       Addr_0008 ; save the current value in working storage
Code_24CA           ldd       Addr_0007 ; load the value needed by the following operation
                    lbsr      Code_0F2F ; call the referenced helper routine
                    stx       Addr_000D ; save the current value in working storage
                    lbsr      Code_094E ; call the referenced helper routine
                    lbsr      Code_11C9 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_24D8           lda       Addr_0007 ; load the value needed by the following operation
                    cmpa      #$01      ; compare against the limit and set condition flags
                    bgt       Code_2513 ; branch when the signed value is above the limit
                    tst       Addr_0006 ; set condition flags from the current value
                    bne       Code_24B0 ; branch when the compared values differ
                    tst       Addr_0008 ; set condition flags from the current value
                    beq       Code_24B0 ; branch when the compared values are equal
                    lbsr      Code_0B2F ; call the referenced helper routine
                    clr       Addr_0007 ; clear the selected byte or register
                    clr       Addr_000D ; clear the selected byte or register
                    lbsr      Code_09EC ; call the referenced helper routine
                    rts                 ; return to the caller
Code_24F1           lda       Addr_0007 ; load the value needed by the following operation
                    beq       Code_254A ; branch when the compared values are equal
                    cmpa      #$01      ; compare against the limit and set condition flags
                    beq       Code_24D8 ; branch when the compared values are equal
                    cmpa      Addr_0009 ; compare against the limit and set condition flags
                    beq       Code_2506 ; branch when the compared values are equal
                    lbsr      Code_0B2F ; call the referenced helper routine
                    lda       Addr_0009 ; load the value needed by the following operation
                    sta       Addr_0007 ; save the current value in working storage
                    bra       Code_253D ; continue at the selected control-flow target
Code_2506           cmpa      Addr_0041 ; compare against the limit and set condition flags
                    blt       Code_2513 ; branch when the signed value is below the limit
                    sta       Addr_000A ; save the current value in working storage
                    suba      Addr_0041 ; subtract the operand from the running value
                    inca                ; advance the selected counter
                    sta       Addr_0009 ; save the current value in working storage
                    bra       Code_251B ; continue at the selected control-flow target
Code_2513           lda       #$01      ; load the value needed by the following operation
                    sta       Addr_0009 ; save the current value in working storage
                    lda       Addr_0041 ; load the value needed by the following operation
                    sta       Addr_000A ; save the current value in working storage
Code_251B           lda       Addr_0009 ; load the value needed by the following operation
                    sta       Addr_0007 ; save the current value in working storage
                    bra       Code_24CA ; continue at the selected control-flow target
Code_2521           ldb       Addr_0008 ; load the value needed by the following operation
                    cmpb      #$63      ; compare against the limit and set condition flags
                    beq       Code_254A ; branch when the compared values are equal
                    cmpb      Addr_000C ; compare against the limit and set condition flags
                    bne       Code_2536 ; branch when the compared values differ
                    stb       Addr_000B ; save the current value in working storage
                    lbsr      Code_0E5A ; call the referenced helper routine
                    ldb       Addr_000C ; load the value needed by the following operation
                    stb       Addr_0008 ; save the current value in working storage
                    bra       Code_24CA ; continue at the selected control-flow target
Code_2536           lbsr      Code_0B2F ; call the referenced helper routine
                    ldb       Addr_000C ; load the value needed by the following operation
                    stb       Addr_0008 ; save the current value in working storage
Code_253D           ldd       Addr_0007 ; load the value needed by the following operation
                    lbsr      Code_0F2F ; call the referenced helper routine
                    stx       Addr_000D ; save the current value in working storage
                    lbsr      Code_09EC ; call the referenced helper routine
                    lbsr      Code_11C9 ; call the referenced helper routine
Code_254A           rts                 ; return to the caller
Code_254B           lda       Addr_0008 ; load the value needed by the following operation
                    beq       Code_254A ; branch when the compared values are equal
                    cmpa      #$01      ; compare against the limit and set condition flags
                    lbeq      Code_2498 ; take the distant branch when values are equal
                    cmpa      Addr_000B ; compare against the limit and set condition flags
                    bne       Code_2565 ; branch when the compared values differ
                    sta       Addr_000C ; save the current value in working storage
                    lbsr      Code_0E79 ; call the referenced helper routine
                    ldb       Addr_000B ; load the value needed by the following operation
                    stb       Addr_0008 ; save the current value in working storage
                    lbra      Code_24CA ; continue at the distant control-flow target
Code_2565           lbsr      Code_0B2F ; call the referenced helper routine
                    ldb       Addr_000B ; load the value needed by the following operation
                    stb       Addr_0008 ; save the current value in working storage
                    bra       Code_253D ; continue at the selected control-flow target
Code_256E           lda       Addr_0007 ; load the value needed by the following operation
                    cmpa      #$63      ; compare against the limit and set condition flags
                    beq       Code_254A ; branch when the compared values are equal
                    cmpa      Addr_000A ; compare against the limit and set condition flags
                    bne       Code_258A ; branch when the compared values differ
                    sta       Addr_0009 ; save the current value in working storage
                    adda      Addr_0041 ; add the operand to the running value
                    deca                ; decrement the selected counter
                    cmpa      #$63      ; compare against the limit and set condition flags
                    ble       Code_2583 ; branch when the signed value is at or below the limit
                    lda       #$63      ; load the value needed by the following operation
Code_2583           sta       Addr_000A ; save the current value in working storage
                    sta       Addr_0007 ; save the current value in working storage
                    lbra      Code_24CA ; continue at the distant control-flow target
Code_258A           lbsr      Code_0B2F ; call the referenced helper routine
                    lda       Addr_000A ; load the value needed by the following operation
                    sta       Addr_0007 ; save the current value in working storage
                    bra       Code_253D ; continue at the selected control-flow target
Code_2593           pshs      Y,X,D     ; preserve the listed registers on the stack
Code_2595           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    ldx       #Addr_B200 ; load the value needed by the following operation
                    ldd       #Data_0E50 ; load the value needed by the following operation
                    tst       Addr_004A ; set condition flags from the current value
                    bne       Code_25A6 ; branch when the compared values differ
                    subd      #Addr_0002 ; subtract the operand from the running value
Code_25A6           tfr       D,Y       ; copy the source register into the destination register
                    lda       #$55      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0E       ; private DeskMate service selector
                    bsr       Code_2627 ; call the referenced helper routine
                    lda       #$01      ; load the value needed by the following operation
                    sta       Addr_0006 ; save the current value in working storage
                    clr       Data_0029 ; clear the selected byte or register
                    ldd       Addr_0007 ; load the value needed by the following operation
                    sta       Code_0022 ; save the current value in working storage
                    sta       Addr_0024 ; save the current value in working storage
                    sta       Addr_0020 ; save the current value in working storage
                    pshs      D         ; preserve the listed registers on the stack
                    stb       Addr_0023 ; save the current value in working storage
                    stb       Data_0025 ; save the current value in working storage
                    stb       Addr_0021 ; save the current value in working storage
                    lda       Addr_0009 ; load the value needed by the following operation
                    ldb       Addr_000B ; load the value needed by the following operation
                    pshs      D         ; preserve the listed registers on the stack
                    lda       Addr_000A ; load the value needed by the following operation
                    pshs      A         ; preserve the listed registers on the stack
Code_25D0           lda       Addr_0006 ; load the value needed by the following operation
                    cmpa      #$01      ; compare against the limit and set condition flags
                    bne       Code_25FF ; branch when the compared values differ
                    clra                ; clear the selected byte or register
                    lbsr      Code_178C ; call the referenced helper routine
                    bpl       Code_25E7 ; branch while the tested value is nonnegative
                    lbsr      Code_0561 ; call the referenced helper routine
                    lbsr      Code_0323 ; call the referenced helper routine
                    lbsr      Code_05F0 ; call the referenced helper routine
                    bra       Code_25EA ; continue at the selected control-flow target
Code_25E7           lbsr      Code_164D ; call the referenced helper routine
Code_25EA           leax      Data_2921,PCR ; form the referenced address without reading memory
                    lda       #$03      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    jsr       B,X       ; call the referenced helper routine
                    tst       Code_0037 ; set condition flags from the current value
                    beq       Code_25D0 ; branch when the compared values are equal
                    lda       Code_0039 ; load the value needed by the following operation
                    sta       Addr_0011 ; save the current value in working storage
                    clr       Code_0037 ; clear the selected byte or register
                    bra       Code_25E7 ; continue at the selected control-flow target
Code_25FF           cmpa      #$02      ; compare against the limit and set condition flags
                    blt       Code_260F ; branch when the signed value is below the limit
                    leas      $05,S     ; form the referenced address without reading memory
                    bgt       Code_2623 ; branch when the signed value is above the limit
                    clr       Addr_0006 ; clear the selected byte or register
                    lbsr      Code_094E ; call the referenced helper routine
                    lbra      Code_2595 ; continue at the distant control-flow target
Code_260F           puls      A         ; restore the listed registers from the stack
                    sta       Addr_000A ; save the current value in working storage
                    puls      D         ; restore the listed registers from the stack
                    sta       Addr_0009 ; save the current value in working storage
                    stb       Addr_000B ; save the current value in working storage
                    puls      D         ; restore the listed registers from the stack
                    std       Addr_0007 ; save the current value in working storage
                    lbsr      Code_0E5A ; call the referenced helper routine
                    lbsr      Code_094E ; call the referenced helper routine
Code_2623           clr       Addr_0006 ; clear the selected byte or register
                    puls      PC,Y,X,D  ; restore the listed registers from the stack
Code_2627           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    lda       #$05      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    ldd       #Code_1605 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    leax      Data_295D,PCR ; form the referenced address without reading memory
                    ldb       #$17      ; load the value needed by the following operation
                    lbsr      Code_0EB7 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
                    fcb       $17,$FB,$87 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $15,$DC   ; table, bitmap, or initialized data bytes
                    fcc       " 4"                           ; embedded text or resource bytes
                    fcb       $06,$17,$1E ; table, bitmap, or initialized data bytes
                    fcc       "25"                           ; embedded text or resource bytes
                    fcb       $06,$DD   ; table, bitmap, or initialized data bytes
                    fcc       "  "                           ; embedded text or resource bytes
                    fcb       $08,$17,$FE,$02 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $03,$17,$DE,$99 ; table, bitmap, or initialized data bytes
Code_2665           tst       Addr_0006 ; set condition flags from the current value
                    beq       Code_266D ; branch when the compared values are equal
                    bsr       Code_266E ; call the referenced helper routine
                    bsr       Code_26AC ; call the referenced helper routine
Code_266D           rts                 ; return to the caller
Code_266E           puls      D         ; restore the listed registers from the stack
                    leas      -$04,S    ; form the referenced address without reading memory
                    pshs      D         ; preserve the listed registers on the stack
                    lda       Code_0022 ; load the value needed by the following operation
                    sta       $02,S     ; save the current value in working storage
                    lda       Addr_0024 ; load the value needed by the following operation
                    sta       $03,S     ; save the current value in working storage
                    lda       Addr_0023 ; load the value needed by the following operation
                    sta       $04,S     ; save the current value in working storage
                    lda       Data_0025 ; load the value needed by the following operation
                    sta       $05,S     ; save the current value in working storage
                    lda       Addr_0007 ; load the value needed by the following operation
                    cmpa      Addr_0020 ; compare against the limit and set condition flags
                    bge       Code_2692 ; branch when the signed value is at least the limit
                    sta       Code_0022 ; save the current value in working storage
                    lda       Addr_0020 ; load the value needed by the following operation
                    sta       Addr_0024 ; save the current value in working storage
                    bra       Code_2698 ; continue at the selected control-flow target
Code_2692           sta       Addr_0024 ; save the current value in working storage
                    lda       Addr_0020 ; load the value needed by the following operation
                    sta       Code_0022 ; save the current value in working storage
Code_2698           lda       Addr_0008 ; load the value needed by the following operation
                    cmpa      Addr_0021 ; compare against the limit and set condition flags
                    bge       Code_26A5 ; branch when the signed value is at least the limit
                    sta       Addr_0023 ; save the current value in working storage
                    lda       Addr_0021 ; load the value needed by the following operation
                    sta       Data_0025 ; save the current value in working storage
                    rts                 ; return to the caller
Code_26A5           sta       Data_0025 ; save the current value in working storage
                    lda       Addr_0021 ; load the value needed by the following operation
                    sta       Addr_0023 ; save the current value in working storage
                    rts                 ; return to the caller
Code_26AC           lda       Addr_0009 ; load the value needed by the following operation
                    sta       Addr_004C ; save the current value in working storage
Code_26B0           lda       Addr_000B ; load the value needed by the following operation
                    sta       Code_004D ; save the current value in working storage
Code_26B4           bsr       Code_272E ; call the referenced helper routine
                    cmpa      #$01      ; compare against the limit and set condition flags
                    bne       Code_26F0 ; branch when the compared values differ
                    lbsr      Code_2747 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    bne       Code_26C8 ; branch when the compared values differ
                    lda       Data_0029 ; load the value needed by the following operation
                    cmpa      #$01      ; compare against the limit and set condition flags
                    beq       Code_2716 ; branch when the compared values are equal
                    bra       Code_26F5 ; continue at the selected control-flow target
Code_26C8           lda       Data_0029 ; load the value needed by the following operation
                    beq       Code_2716 ; branch when the compared values are equal
                    cmpa      #$02      ; compare against the limit and set condition flags
                    blt       Code_26F5 ; branch when the signed value is below the limit
                    beq       Code_26E0 ; branch when the compared values are equal
                    cmpa      #$04      ; compare against the limit and set condition flags
                    blt       Code_26E8 ; branch when the signed value is below the limit
                    lda       Addr_004C ; load the value needed by the following operation
                    suba      Addr_0009 ; subtract the operand from the running value
                    cmpa      Addr_001F ; compare against the limit and set condition flags
                    blt       Code_26F5 ; branch when the signed value is below the limit
                    bra       Code_2716 ; continue at the selected control-flow target
Code_26E0           lda       Addr_004C ; load the value needed by the following operation
                    cmpa      Addr_0007 ; compare against the limit and set condition flags
                    bne       Code_2716 ; branch when the compared values differ
                    bra       Code_26F5 ; continue at the selected control-flow target
Code_26E8           ldb       Code_004D ; load the value needed by the following operation
                    cmpb      Addr_0008 ; compare against the limit and set condition flags
                    bne       Code_2716 ; branch when the compared values differ
                    bra       Code_26F5 ; continue at the selected control-flow target
Code_26F0           bsr       Code_2747 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_2716 ; branch when the compared values are equal
Code_26F5           ldd       Addr_004C ; load the value needed by the following operation
                    suba      Addr_0009 ; subtract the operand from the running value
                    adda      Addr_003D ; add the operand to the running value
                    subb      Addr_000B ; subtract the operand from the running value
                    leay      $0183,U   ; form the referenced address without reading memory
                    ldb       B,Y       ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    leax      $008C,U   ; form the referenced address without reading memory
                    ldb       Code_004D ; load the value needed by the following operation
                    ldb       B,X       ; load the value needed by the following operation
                    clra                ; clear the selected byte or register
Code_2710           tfr       D,Y       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "$"                            ; embedded text or resource bytes
Code_2716           inc       Code_004D ; advance the selected counter
                    lda       Code_004D ; load the value needed by the following operation
                    cmpa      Addr_000C ; compare against the limit and set condition flags
                    ble       Code_26B4 ; branch when the signed value is at or below the limit
                    inc       Addr_004C ; advance the selected counter
                    lda       Addr_004C ; load the value needed by the following operation
                    cmpa      Addr_000A ; compare against the limit and set condition flags
                    ble       Code_26B0 ; branch when the signed value is at or below the limit
                    clr       Data_0029 ; clear the selected byte or register
                    puls      D         ; restore the listed registers from the stack
                    leas      $04,S     ; form the referenced address without reading memory
                    tfr       D,PC      ; copy the source register into the destination register
Code_272E           lda       Addr_004C ; load the value needed by the following operation
                    cmpa      $04,S     ; compare against the limit and set condition flags
                    blt       Code_2745 ; branch when the signed value is below the limit
                    cmpa      $05,S     ; compare against the limit and set condition flags
                    bgt       Code_2745 ; branch when the signed value is above the limit
                    lda       Code_004D ; load the value needed by the following operation
                    cmpa      $06,S     ; compare against the limit and set condition flags
                    blt       Code_2745 ; branch when the signed value is below the limit
                    cmpa      $07,S     ; compare against the limit and set condition flags
                    bgt       Code_2745 ; branch when the signed value is above the limit
Code_2742           lda       #$01      ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_2745           clra                ; clear the selected byte or register
                    rts                 ; return to the caller
Code_2747           lda       Addr_004C ; load the value needed by the following operation
                    cmpa      Code_0022 ; compare against the limit and set condition flags
                    blt       Code_2745 ; branch when the signed value is below the limit
                    cmpa      Addr_0024 ; compare against the limit and set condition flags
                    bgt       Code_2745 ; branch when the signed value is above the limit
                    lda       Code_004D ; load the value needed by the following operation
                    cmpa      Addr_0023 ; compare against the limit and set condition flags
                    blt       Code_2745 ; branch when the signed value is below the limit
                    cmpa      Data_0025 ; compare against the limit and set condition flags
                    bgt       Code_2745 ; branch when the signed value is above the limit
                    bra       Code_2742 ; continue at the selected control-flow target
                    fcb       $96,$22,$97,$07,$96 ; table, bitmap, or initialized data bytes
                    fcc       "#"                            ; embedded text or resource bytes
                    fcb       $97,$08,$17,$08,$84 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
Code_2769           leax      $01F5,U   ; form the referenced address without reading memory
                    clra                ; clear the selected byte or register
                    ldb       #$09      ; load the value needed by the following operation
                    lbsr      Code_10BE ; call the referenced helper routine
                    ldb       Addr_0012 ; load the value needed by the following operation
                    pshs      B         ; preserve the listed registers on the stack
                    ldd       Code_0022 ; load the value needed by the following operation
                    sta       Addr_004C ; save the current value in working storage
                    std       Code_001E ; save the current value in working storage
                    incb                ; advance the selected counter
                    cmpb      Data_0025 ; compare against the limit and set condition flags
                    bgt       Code_2786 ; branch when the signed value is above the limit
                    stb       Code_004D ; save the current value in working storage
                    bra       Code_2791 ; continue at the selected control-flow target
Code_2786           decb                ; decrement the selected counter
                    stb       Code_004D ; save the current value in working storage
                    inc       Addr_004C ; advance the selected counter
                    lda       Addr_004C ; load the value needed by the following operation
                    cmpa      Addr_0024 ; compare against the limit and set condition flags
                    bgt       Code_2808 ; branch when the signed value is above the limit
Code_2791           ldd       Addr_004C ; load the value needed by the following operation
                    lbsr      Code_0F2F ; call the referenced helper routine
                    stx       Addr_000D ; save the current value in working storage
                    leay      $01F1,U   ; form the referenced address without reading memory
                    std       ,Y++      ; store the value and advance the destination pointer
                    ldb       #$80      ; load the value needed by the following operation
                    stb       ,Y+       ; store the value and advance the destination pointer
                    leax      ,X        ; form the referenced address without reading memory
                    beq       Code_27B4 ; branch when the compared values are equal
                    ldb       $02,X     ; load the value needed by the following operation
                    andb      #$C0      ; mask off unwanted bits
                    beq       Code_27B4 ; branch when the compared values are equal
                    ldb       $03,X     ; load the value needed by the following operation
                    andb      #$F7      ; mask off unwanted bits
                    stb       ,Y+       ; store the value and advance the destination pointer
                    bra       Code_27BE ; continue at the selected control-flow target
Code_27B4           ldb       Code_004D ; load the value needed by the following operation
                    leax      $00F0,U   ; form the referenced address without reading memory
                    ldb       B,X       ; load the value needed by the following operation
                    stb       ,Y+       ; store the value and advance the destination pointer
Code_27BE           leax      $01A1,U   ; form the referenced address without reading memory
                    bsr       Code_2810 ; call the referenced helper routine
                    tst       Addr_001B ; set condition flags from the current value
                    beq       Code_27D2 ; branch when the compared values are equal
                    lda       #$03      ; load the value needed by the following operation
                    sta       $01FE,U   ; save the current value in working storage
                    clr       Data_0029 ; clear the selected byte or register
                    bra       Code_27D8 ; continue at the selected control-flow target
Code_27D2           lda       #$02      ; load the value needed by the following operation
                    sta       $01FE,U   ; save the current value in working storage
Code_27D8           leax      $01F1,U   ; form the referenced address without reading memory
                    ldb       Data_0029 ; load the value needed by the following operation
                    addb      #$0A      ; add the operand to the running value
                    orb       $02,X     ; set the selected flag bits
                    stb       $02,X     ; save the current value in working storage
                    ldb       Data_0029 ; load the value needed by the following operation
                    clr       Data_0029 ; clear the selected byte or register
                    addb      #$0E      ; add the operand to the running value
                    lbsr      Code_0F4A ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_2808 ; branch when the compared values are equal
                    inc       Code_004D ; advance the selected counter
                    lda       ,S        ; load the value needed by the following operation
                    sta       Addr_0012 ; save the current value in working storage
                    lda       Code_004D ; load the value needed by the following operation
                    cmpa      Data_0025 ; compare against the limit and set condition flags
                    ble       Code_2791 ; branch when the signed value is at or below the limit
                    lda       Addr_0023 ; load the value needed by the following operation
                    sta       Code_004D ; save the current value in working storage
                    inc       Addr_004C ; advance the selected counter
                    lda       Addr_004C ; load the value needed by the following operation
                    cmpa      Addr_0024 ; compare against the limit and set condition flags
                    ble       Code_2791 ; branch when the signed value is at or below the limit
Code_2808           leas      $01,S     ; form the referenced address without reading memory
                    rts                 ; return to the caller
                    fcb       $86,$02,$97,$06 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
Code_2810           leay      $01FF,U   ; form the referenced address without reading memory
                    clr       Addr_001B ; clear the selected byte or register
                    clr       Data_0029 ; clear the selected byte or register
                    lda       #$20      ; load the value needed by the following operation
                    ldb       Addr_0012 ; load the value needed by the following operation
Code_281C           sta       ,Y+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bgt       Code_281C ; branch when the signed value is above the limit
                    leay      $01FF,U   ; form the referenced address without reading memory
                    clrb                ; clear the selected byte or register
Code_2826           lda       B,X       ; load the value needed by the following operation
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bne       Code_282F ; branch when the compared values differ
                    incb                ; advance the selected counter
                    bra       Code_2826 ; continue at the selected control-flow target
Code_282F           cmpa      #$3F      ; compare against the limit and set condition flags
                    bne       Code_283B ; branch when the compared values differ
                    ldb       Addr_0012 ; load the value needed by the following operation
                    stb       Data_0029 ; save the current value in working storage
                    lbsr      Code_0FB7 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_283B           ldb       #$20      ; load the value needed by the following operation
Code_283D           lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpa      #$52      ; compare against the limit and set condition flags
                    beq       Code_2852 ; branch when the compared values are equal
                    cmpa      #$43      ; compare against the limit and set condition flags
                    beq       Code_2852 ; branch when the compared values are equal
Code_2847           tfr       A,B       ; copy the source register into the destination register
                    sta       ,Y+       ; store the value and advance the destination pointer
                    inc       Data_0029 ; advance the selected counter
                    dec       Addr_0012 ; decrement the selected counter
                    bgt       Code_283D ; branch when the signed value is above the limit
Code_2851           rts                 ; return to the caller
Code_2852           tst       Addr_000F ; set condition flags from the current value
                    bne       Code_287E ; branch when the compared values differ
                    cmpb      #$23      ; compare against the limit and set condition flags
                    bne       Code_287E ; branch when the compared values differ
Code_285A           sta       ,Y+       ; store the value and advance the destination pointer
                    inc       Data_0029 ; advance the selected counter
                    dec       Addr_0012 ; decrement the selected counter
                    beq       Code_2851 ; branch when the compared values are equal
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpa      #$30      ; compare against the limit and set condition flags
                    blt       Code_2847 ; branch when the signed value is below the limit
                    cmpa      #$39      ; compare against the limit and set condition flags
                    ble       Code_285A ; branch when the signed value is at or below the limit
                    cmpa      #$43      ; compare against the limit and set condition flags
                    beq       Code_285A ; branch when the compared values are equal
                    bra       Code_2847 ; continue at the selected control-flow target
Code_2872           puls      D         ; restore the listed registers from the stack
                    std       Addr_004C ; save the current value in working storage
                    inc       Addr_0012 ; advance the selected counter
                    lda       -$01,X    ; load the value needed by the following operation
Code_287A           leas      $01,S     ; form the referenced address without reading memory
                    bra       Code_285A ; continue at the selected control-flow target
Code_287E           sta       ,Y+       ; store the value and advance the destination pointer
                    inc       Data_0029 ; advance the selected counter
                    pshs      A         ; preserve the listed registers on the stack
                    leax      -$01,X    ; form the referenced address without reading memory
                    clr       Addr_0010 ; clear the selected byte or register
                    ldd       Addr_004C ; load the value needed by the following operation
                    pshs      D         ; preserve the listed registers on the stack
                    clr       Addr_001D ; clear the selected byte or register
                    lbsr      Code_347F ; call the referenced helper routine
                    tst       Addr_001D ; set condition flags from the current value
                    bne       Code_2872 ; branch when the compared values differ
                    pshs      D         ; preserve the listed registers on the stack
                    ldd       $02,S     ; load the value needed by the following operation
                    std       Addr_004C ; save the current value in working storage
                    puls      D         ; restore the listed registers from the stack
                    leas      $02,S     ; form the referenced address without reading memory
                    tst       Addr_000F ; set condition flags from the current value
                    beq       Code_28BD ; branch when the compared values are equal
                    cmpa      Code_001E ; compare against the limit and set condition flags
                    blt       Code_28D5 ; branch when the signed value is below the limit
                    cmpa      Addr_0020 ; compare against the limit and set condition flags
                    bgt       Code_28D5 ; branch when the signed value is above the limit
                    cmpb      Addr_001F ; compare against the limit and set condition flags
                    blt       Code_28D5 ; branch when the signed value is below the limit
                    cmpb      Addr_0021 ; compare against the limit and set condition flags
                    bgt       Code_28D5 ; branch when the signed value is above the limit
                    suba      Code_001E ; subtract the operand from the running value
                    adda      Code_0022 ; add the operand to the running value
                    subb      Addr_001F ; subtract the operand from the running value
                    addb      Addr_0023 ; add the operand to the running value
                    bra       Code_28C5 ; continue at the selected control-flow target
Code_28BD           suba      Code_0022 ; subtract the operand from the running value
                    subb      Addr_0023 ; subtract the operand from the running value
                    adda      Addr_004C ; add the operand to the running value
                    addb      Code_004D ; add the operand to the running value
Code_28C5           cmpa      #$63      ; compare against the limit and set condition flags
                    ble       Code_28CD ; branch when the signed value is at or below the limit
                    inc       Addr_001B ; advance the selected counter
                    bra       Code_287A ; continue at the selected control-flow target
Code_28CD           cmpb      #$63      ; compare against the limit and set condition flags
                    ble       Code_28D5 ; branch when the signed value is at or below the limit
                    inc       Addr_001B ; advance the selected counter
                    bra       Code_287A ; continue at the selected control-flow target
Code_28D5           sta       Code_0026 ; save the current value in working storage
                    puls      A         ; restore the listed registers from the stack
                    cmpa      #$52      ; compare against the limit and set condition flags
                    bne       Code_290E ; branch when the compared values differ
                    lda       Code_0026 ; load the value needed by the following operation
Code_28DF           cmpa      #$0A      ; compare against the limit and set condition flags
                    blt       Code_28FE ; branch when the signed value is below the limit
                    pshs      A         ; preserve the listed registers on the stack
                    clra                ; clear the selected byte or register
                    pshs      A         ; preserve the listed registers on the stack
                    lda       $01,S     ; load the value needed by the following operation
Code_28EA           suba      #$0A      ; subtract the operand from the running value
                    inc       ,S        ; advance the selected counter
                    cmpa      #$0A      ; compare against the limit and set condition flags
                    bge       Code_28EA ; branch when the signed value is at least the limit
                    sta       $01,S     ; save the current value in working storage
                    puls      A         ; restore the listed registers from the stack
                    adda      #$30      ; add the operand to the running value
                    sta       ,Y+       ; store the value and advance the destination pointer
                    inc       Data_0029 ; advance the selected counter
                    puls      A         ; restore the listed registers from the stack
Code_28FE           adda      #$30      ; add the operand to the running value
                    sta       ,Y+       ; store the value and advance the destination pointer
                    inc       Data_0029 ; advance the selected counter
                    tst       Addr_0016 ; set condition flags from the current value
                    beq       Code_2914 ; branch when the compared values are equal
                    lda       #$43      ; load the value needed by the following operation
                    sta       ,Y+       ; store the value and advance the destination pointer
                    inc       Data_0029 ; advance the selected counter
Code_290E           tfr       B,A       ; copy the source register into the destination register
                    clr       Addr_0016 ; clear the selected byte or register
                    bra       Code_28DF ; continue at the selected control-flow target
Code_2914           tst       Addr_0012 ; set condition flags from the current value
                    beq       Code_291D ; branch when the compared values are equal
                    ldb       #$20      ; load the value needed by the following operation
                    lbra      Code_283D ; continue at the distant control-flow target
Code_291D           rts                 ; return to the caller
                    fcb       $0F,$06   ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
Data_2921           fcb       $16,$FD   ; table, bitmap, or initialized data bytes
                    fcc       ">"                            ; embedded text or resource bytes
                    fcb       $16,$FD   ; table, bitmap, or initialized data bytes
                    fcc       ";"                      ;2926: 3B             ' ; embedded text or resource bytes
                    fcb       $16,$FD   ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
                    fcb       $16,$FD   ; table, bitmap, or initialized data bytes
                    fcc       "#"                            ; embedded text or resource bytes
                    fcb       $16,$FD   ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $16,$FE   ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $16,$1D   ; table, bitmap, or initialized data bytes
                    fcc       "7"                            ; embedded text or resource bytes
                    fcb       $16,$FD   ; table, bitmap, or initialized data bytes
                    fcc       ")"                            ; embedded text or resource bytes
                    fcb       $16,$FE,$CF,$16,$00,$AF ; table, bitmap, or initialized data bytes
                    fcb       $16,$F3   ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $16,$00   ; table, bitmap, or initialized data bytes
                    fcc       "/"                            ; embedded text or resource bytes
                    fcb       $16,$FD,$1A,$16,$FD,$17 ; table, bitmap, or initialized data bytes
                    fcb       $16,$FC,$FD,$16,$FD,$11 ; table, bitmap, or initialized data bytes
                    fcb       $16,$FD,$0E,$16,$FD,$06 ; table, bitmap, or initialized data bytes
                    fcb       $16,$FF,$C4,$16,$F7,$D1 ; table, bitmap, or initialized data bytes
Data_295D           fcc       "Select a block of cel"        ; embedded text or resource bytes
                    fcc       "ls"                           ; embedded text or resource bytes
Code_2974           tst       Addr_0006 ; set condition flags from the current value
                    bne       Code_2993 ; branch when the compared values differ
                    ldy       Addr_000D ; load the value needed by the following operation
                    beq       Code_2990 ; branch when the compared values are equal
                    lbsr      Code_0F7C ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    std       Addr_000D ; save the current value in working storage
                    lbsr      Code_15FF ; call the referenced helper routine
                    lbsr      Code_166E ; call the referenced helper routine
                    lbsr      Code_0B2F ; call the referenced helper routine
                    lbsr      Code_09EC ; call the referenced helper routine
Code_2990           clr       Addr_0006 ; clear the selected byte or register
                    rts                 ; return to the caller
Code_2993           ldx       Addr_0002 ; load the value needed by the following operation
Code_2995           ldd       ,X        ; load the value needed by the following operation
                    blt       Code_29BD ; branch when the signed value is below the limit
                    std       Addr_004C ; save the current value in working storage
                    lbsr      Code_2747 ; call the referenced helper routine
                    cmpa      #$01      ; compare against the limit and set condition flags
                    bne       Code_29B7 ; branch when the compared values differ
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    std       ,X        ; save the current value in working storage
                    lbsr      Code_0FB0 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    pshs      D         ; preserve the listed registers on the stack
                    ldd       Addr_0013 ; load the value needed by the following operation
                    addd      ,S        ; add the operand to the running value
                    std       Addr_0013 ; save the current value in working storage
                    puls      D         ; restore the listed registers from the stack
                    abx                 ; add the operand to the running value
                    bra       Code_2995 ; continue at the selected control-flow target
Code_29B7           lbsr      Code_0FB0 ; call the referenced helper routine
                    abx                 ; add the operand to the running value
                    bra       Code_2995 ; continue at the selected control-flow target
Code_29BD           ldx       Addr_0002 ; load the value needed by the following operation
Code_29BF           ldd       ,X        ; load the value needed by the following operation
                    blt       Code_2990 ; branch when the signed value is below the limit
                    beq       Code_29CB ; branch when the compared values are equal
                    lbsr      Code_0FB0 ; call the referenced helper routine
                    abx                 ; add the operand to the running value
                    bra       Code_29BF ; continue at the selected control-flow target
Code_29CB           tfr       X,Y       ; copy the source register into the destination register
Code_29CD           lbsr      Code_0FB0 ; call the referenced helper routine
                    abx                 ; add the operand to the running value
                    ldd       ,X        ; load the value needed by the following operation
                    blt       Code_29E5 ; branch when the signed value is below the limit
                    beq       Code_29CD ; branch when the compared values are equal
Code_29D7           lbsr      Code_0FB0 ; call the referenced helper routine
                    lbsr      Code_0FB7 ; call the referenced helper routine
                    ldd       ,X        ; load the value needed by the following operation
                    blt       Code_29E5 ; branch when the signed value is below the limit
                    bne       Code_29D7 ; branch when the compared values differ
                    bra       Code_29CD ; continue at the selected control-flow target
Code_29E5           sty       Addr_0004 ; save the current value in working storage
                    lda       #$FF      ; load the value needed by the following operation
                    sta       ,Y        ; save the current value in working storage
                    bra       Code_2990 ; continue at the selected control-flow target
Code_29EE           tst       Code_002A ; set condition flags from the current value
                    beq       Code_29FA ; branch when the compared values are equal
                    ldd       Addr_0013 ; load the value needed by the following operation
                    addd      Addr_002B ; add the operand to the running value
                    std       Addr_0013 ; save the current value in working storage
                    clr       Code_002A ; clear the selected byte or register
Code_29FA           tst       Addr_0006 ; set condition flags from the current value
                    bne       Code_2A10 ; branch when the compared values differ
                    ldd       Addr_0007 ; load the value needed by the following operation
                    lbsr      Code_0F2F ; call the referenced helper routine
                    leax      ,X        ; form the referenced address without reading memory
                    bne       Code_2A0A ; branch when the compared values differ
                    stx       Addr_002B ; save the current value in working storage
                    rts                 ; return to the caller
Code_2A0A           lbsr      Code_0FB0 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    bra       Code_2A37 ; continue at the selected control-flow target
Code_2A10           ldx       Addr_0002 ; load the value needed by the following operation
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    pshs      D         ; preserve the listed registers on the stack
Code_2A16           ldd       ,X        ; load the value needed by the following operation
                    blt       Code_2A30 ; branch when the signed value is below the limit
                    std       Addr_004C ; save the current value in working storage
                    lbsr      Code_2747 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_2A2A ; branch when the compared values are equal
                    lbsr      Code_0FB0 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    addd      ,S        ; add the operand to the running value
                    std       ,S        ; save the current value in working storage
Code_2A2A           lbsr      Code_0FB0 ; call the referenced helper routine
                    abx                 ; add the operand to the running value
                    bra       Code_2A16 ; continue at the selected control-flow target
Code_2A30           ldd       ,S++      ; load the value needed by the following operation
                    bne       Code_2A37 ; branch when the compared values differ
                    clr       Addr_0006 ; clear the selected byte or register
                    rts                 ; return to the caller
Code_2A37           addd      #Addr_0004 ; add the operand to the running value
                    cmpd      Addr_0013 ; compare against the limit and set condition flags
                    bgt       Code_2A7B ; branch when the signed value is above the limit
                    std       Addr_002B ; save the current value in working storage
                    ldd       Addr_0013 ; load the value needed by the following operation
                    subd      Addr_002B ; subtract the operand from the running value
                    std       Addr_0013 ; save the current value in working storage
                    ldd       Addr_002F ; load the value needed by the following operation
                    subd      Addr_002B ; subtract the operand from the running value
                    std       Addr_002D ; save the current value in working storage
                    tst       Addr_0006 ; set condition flags from the current value
                    bne       Code_2A83 ; branch when the compared values differ
                    ldy       Addr_002D ; load the value needed by the following operation
                    lda       Addr_0007 ; load the value needed by the following operation
                    sta       ,Y+       ; store the value and advance the destination pointer
                    clra                ; clear the selected byte or register
                    sta       $01,Y     ; save the current value in working storage
                    lda       Addr_0008 ; load the value needed by the following operation
                    sta       ,Y+       ; store the value and advance the destination pointer
                    clra                ; clear the selected byte or register
                    sta       $01,Y     ; save the current value in working storage
                    leay      $02,Y     ; form the referenced address without reading memory
                    sta       ,Y+       ; store the value and advance the destination pointer
                    sta       ,Y+       ; store the value and advance the destination pointer
                    ldb       $02,X     ; load the value needed by the following operation
                    andb      #$3F      ; mask off unwanted bits
                    addb      #$02      ; add the operand to the running value
                    leax      $02,X     ; form the referenced address without reading memory
                    lbsr      Code_0FB7 ; call the referenced helper routine
                    lda       #$01      ; load the value needed by the following operation
                    sta       Code_002A ; save the current value in working storage
                    lbsr      Code_11C9 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_2A7B           ldb       #$01      ; load the value needed by the following operation
                    lbsr      Code_0EC3 ; call the referenced helper routine
                    clr       Addr_0006 ; clear the selected byte or register
                    rts                 ; return to the caller
Code_2A83           ldy       Addr_002D ; load the value needed by the following operation
                    lda       Code_0022 ; load the value needed by the following operation
                    sta       ,Y+       ; store the value and advance the destination pointer
                    lda       Addr_0023 ; load the value needed by the following operation
                    sta       ,Y+       ; store the value and advance the destination pointer
                    lda       Addr_0024 ; load the value needed by the following operation
                    suba      Code_0022 ; subtract the operand from the running value
                    sta       ,Y+       ; store the value and advance the destination pointer
                    lda       Data_0025 ; load the value needed by the following operation
                    suba      Addr_0023 ; subtract the operand from the running value
                    sta       ,Y+       ; store the value and advance the destination pointer
                    ldx       Addr_0002 ; load the value needed by the following operation
Code_2A9C           ldd       ,X        ; load the value needed by the following operation
                    blt       Code_2AC3 ; branch when the signed value is below the limit
                    std       Addr_004C ; save the current value in working storage
                    lbsr      Code_2747 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_2ABD ; branch when the compared values are equal
                    pshs      X         ; preserve the listed registers on the stack
                    ldd       ,X++      ; fetch the next value and advance the source pointer
                    suba      Code_0022 ; subtract the operand from the running value
                    subb      Addr_0023 ; subtract the operand from the running value
                    std       ,Y++      ; store the value and advance the destination pointer
                    ldb       ,X        ; load the value needed by the following operation
                    andb      #$3F      ; mask off unwanted bits
                    addb      #$02      ; add the operand to the running value
                    lbsr      Code_0FB7 ; call the referenced helper routine
                    puls      X         ; restore the listed registers from the stack
Code_2ABD           lbsr      Code_0FB0 ; call the referenced helper routine
                    abx                 ; add the operand to the running value
                    bra       Code_2A9C ; continue at the selected control-flow target
Code_2AC3           clr       Addr_0006 ; clear the selected byte or register
                    lda       #$01      ; load the value needed by the following operation
                    sta       Code_002A ; save the current value in working storage
Code_2AC9           rts                 ; return to the caller
Code_2ACA           tst       Code_002A ; set condition flags from the current value
                    beq       Code_2AC9 ; branch when the compared values are equal
                    ldd       Addr_002B ; load the value needed by the following operation
                    std       Addr_0027 ; save the current value in working storage
                    ldx       Addr_002D ; load the value needed by the following operation
                    bsr       Code_2AE1 ; call the referenced helper routine
                    ldd       Addr_0007 ; load the value needed by the following operation
                    lbsr      Code_0F2F ; call the referenced helper routine
                    stx       Addr_000D ; save the current value in working storage
                    lbsr      Code_094E ; call the referenced helper routine
                    rts                 ; return to the caller
Code_2AE1           ldd       ,X        ; load the value needed by the following operation
                    std       Code_001E ; save the current value in working storage
                    adda      $02,X     ; add the operand to the running value
                    addb      $03,X     ; add the operand to the running value
                    std       Addr_0020 ; save the current value in working storage
                    ldd       Addr_0007 ; load the value needed by the following operation
                    std       Code_0022 ; save the current value in working storage
                    adda      $02,X     ; add the operand to the running value
                    addb      $03,X     ; add the operand to the running value
                    std       Addr_0024 ; save the current value in working storage
                    cmpa      #$63      ; compare against the limit and set condition flags
                    bgt       Code_2B61 ; branch when the signed value is above the limit
                    cmpb      #$63      ; compare against the limit and set condition flags
                    bgt       Code_2B61 ; branch when the signed value is above the limit
                    tst       Data_0031 ; set condition flags from the current value
                    beq       Code_2B67 ; branch when the compared values are equal
                    ldb       $03,X     ; load the value needed by the following operation
                    incb                ; advance the selected counter
                    lda       $02,X     ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    cmpa      #$63      ; compare against the limit and set condition flags
                    blt       Code_2B4D ; branch when the signed value is below the limit
                    pshs      B         ; preserve the listed registers on the stack
                    clra                ; clear the selected byte or register
                    pshs      D         ; preserve the listed registers on the stack
                    addd      ,S++      ; add the operand to the running value
                    addd      #Addr_0004 ; add the operand to the running value
                    pshs      D         ; preserve the listed registers on the stack
                    ldd       Addr_0027 ; load the value needed by the following operation
                    subd      ,S++      ; subtract the operand from the running value
                    std       Addr_0027 ; save the current value in working storage
                    lda       ,S        ; load the value needed by the following operation
                    pshs      A         ; preserve the listed registers on the stack
                    leay      $008C,U   ; form the referenced address without reading memory
                    leax      $04,X     ; form the referenced address without reading memory
                    lda       Addr_0023 ; load the value needed by the following operation
Code_2B29           ldb       ,X+       ; fetch the next value and advance the source pointer
                    stb       A,Y       ; save the current value in working storage
                    inca                ; advance the selected counter
                    dec       ,S        ; decrement the selected counter
                    bgt       Code_2B29 ; branch when the signed value is above the limit
                    leas      $01,S     ; form the referenced address without reading memory
                    lbsr      Code_0E5A ; call the referenced helper routine
                    lbsr      Code_15FF ; call the referenced helper routine
                    leay      $00F0,U   ; form the referenced address without reading memory
                    lda       Addr_0023 ; load the value needed by the following operation
Code_2B40           ldb       ,X+       ; fetch the next value and advance the source pointer
                    stb       A,Y       ; save the current value in working storage
                    inca                ; advance the selected counter
                    dec       ,S        ; decrement the selected counter
                    bgt       Code_2B40 ; branch when the signed value is above the limit
                    leas      $01,S     ; form the referenced address without reading memory
                    bra       Code_2B70 ; continue at the selected control-flow target
Code_2B4D           clra                ; clear the selected byte or register
                    pshs      D         ; preserve the listed registers on the stack
                    addd      ,S++      ; add the operand to the running value
                    addd      #Addr_0004 ; add the operand to the running value
                    leax      D,X       ; form the referenced address without reading memory
                    pshs      D         ; preserve the listed registers on the stack
                    ldd       Addr_0027 ; load the value needed by the following operation
                    subd      ,S++      ; subtract the operand from the running value
                    std       Addr_0027 ; save the current value in working storage
                    bra       Code_2B70 ; continue at the selected control-flow target
Code_2B61           ldb       #$02      ; load the value needed by the following operation
                    lbsr      Code_0EC3 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_2B67           leax      $04,X     ; form the referenced address without reading memory
                    ldd       Addr_0027 ; load the value needed by the following operation
                    subd      #Addr_0004 ; subtract the operand from the running value
                    std       Addr_0027 ; save the current value in working storage
Code_2B70           pshs      X         ; preserve the listed registers on the stack
                    lda       #$01      ; load the value needed by the following operation
                    sta       Addr_0006 ; save the current value in working storage
                    lbsr      Code_2974 ; call the referenced helper routine
                    puls      X         ; restore the listed registers from the stack
                    ldy       Addr_0004 ; load the value needed by the following operation
Code_2B7E           ldd       Addr_0027 ; load the value needed by the following operation
                    lbeq      Code_2C97 ; take the distant branch when values are equal
                    cmpd      Addr_0013 ; compare against the limit and set condition flags
                    ble       Code_2B91 ; branch when the signed value is at or below the limit
                    ldb       #$01      ; load the value needed by the following operation
                    lbsr      Code_0EC3 ; call the referenced helper routine
                    lbra      Code_2C97 ; continue at the distant control-flow target
Code_2B91           ldd       ,X        ; load the value needed by the following operation
                    adda      Code_0022 ; add the operand to the running value
                    addb      Addr_0023 ; add the operand to the running value
                    tst       Data_0031 ; set condition flags from the current value
                    beq       Code_2B9F ; branch when the compared values are equal
                    suba      Code_001E ; subtract the operand from the running value
                    subb      Addr_001F ; subtract the operand from the running value
Code_2B9F           std       Addr_004C ; save the current value in working storage
                    std       ,Y++      ; store the value and advance the destination pointer
                    pshs      Y,X       ; preserve the listed registers on the stack
                    tst       Data_0031 ; set condition flags from the current value
                    bne       Code_2BBD ; branch when the compared values differ
                    lda       $02,X     ; load the value needed by the following operation
                    anda      #$C0      ; mask off unwanted bits
                    beq       Code_2BBD ; branch when the compared values are equal
                    lda       $03,X     ; load the value needed by the following operation
                    anda      #$F8      ; mask off unwanted bits
                    leax      $00F0,U   ; form the referenced address without reading memory
                    ora       B,X       ; set the selected flag bits
                    ldx       ,S        ; load the value needed by the following operation
                    sta       $03,X     ; save the current value in working storage
Code_2BBD           ldb       $02,X     ; load the value needed by the following operation
                    tfr       B,A       ; copy the source register into the destination register
                    andb      #$C0      ; mask off unwanted bits
                    cmpb      #$80      ; compare against the limit and set condition flags
                    bne       Code_2C22 ; branch when the compared values differ
                    anda      #$3F      ; mask off unwanted bits
                    suba      #$0A      ; subtract the operand from the running value
                    sta       Addr_0012 ; save the current value in working storage
                    lda       $0D,X     ; load the value needed by the following operation
                    cmpa      #$03      ; compare against the limit and set condition flags
                    beq       Code_2C22 ; branch when the compared values are equal
                    leax      $0E,X     ; form the referenced address without reading memory
                    lda       #$01      ; load the value needed by the following operation
                    sta       Addr_000F ; save the current value in working storage
                    lbsr      Code_2810 ; call the referenced helper routine
                    clr       Addr_000F ; clear the selected byte or register
                    ldx       ,S        ; load the value needed by the following operation
                    leax      $03,X     ; form the referenced address without reading memory
                    ldy       $02,S     ; load the value needed by the following operation
                    ldb       Data_0029 ; load the value needed by the following operation
                    addb      #$0A      ; add the operand to the running value
                    orb       #$80      ; set the selected flag bits
                    stb       ,Y+       ; store the value and advance the destination pointer
                    ldb       #$0A      ; load the value needed by the following operation
                    lbsr      Code_0FB7 ; call the referenced helper routine
                    lda       Data_0031 ; load the value needed by the following operation
                    cmpa      #$02      ; compare against the limit and set condition flags
                    bne       Code_2BFE ; branch when the compared values differ
                    ldb       ,X        ; load the value needed by the following operation
                    stb       ,Y+       ; store the value and advance the destination pointer
                    bra       Code_2C18 ; continue at the selected control-flow target
Code_2BFE           tst       Addr_001B ; set condition flags from the current value
                    bne       Code_2C08 ; branch when the compared values differ
                    lda       Data_0029 ; load the value needed by the following operation
                    cmpa      #$32      ; compare against the limit and set condition flags
                    ble       Code_2C14 ; branch when the signed value is at or below the limit
Code_2C08           lda       #$03      ; load the value needed by the following operation
                    sta       ,Y+       ; store the value and advance the destination pointer
                    ldb       #$8A      ; load the value needed by the following operation
                    stb       -$0C,Y    ; save the current value in working storage
                    clr       Data_0029 ; clear the selected byte or register
                    bra       Code_2C2C ; continue at the selected control-flow target
Code_2C14           lda       #$02      ; load the value needed by the following operation
                    sta       ,Y+       ; store the value and advance the destination pointer
Code_2C18           leax      $01FF,U   ; form the referenced address without reading memory
                    ldb       Data_0029 ; load the value needed by the following operation
                    clr       Data_0029 ; clear the selected byte or register
                    bra       Code_2C29 ; continue at the selected control-flow target
Code_2C22           lbsr      Code_0FB0 ; call the referenced helper routine
                    subb      #$02      ; subtract the operand from the running value
                    leax      $02,X     ; form the referenced address without reading memory
Code_2C29           lbsr      Code_0FB7 ; call the referenced helper routine
Code_2C2C           puls      X         ; restore the listed registers from the stack
                    leas      $02,S     ; form the referenced address without reading memory
                    lbsr      Code_0FB0 ; call the referenced helper routine
                    abx                 ; add the operand to the running value
                    clra                ; clear the selected byte or register
                    pshs      D         ; preserve the listed registers on the stack
                    ldd       Addr_0027 ; load the value needed by the following operation
                    subd      ,S        ; subtract the operand from the running value
                    std       Addr_0027 ; save the current value in working storage
                    ldd       Addr_0013 ; load the value needed by the following operation
                    subd      ,S++      ; subtract the operand from the running value
                    std       Addr_0013 ; save the current value in working storage
                    tst       Data_0031 ; set condition flags from the current value
                    bne       Code_2C4E ; branch when the compared values differ
                    bra       Code_2C4B ; continue at the selected control-flow target
Code_2C49           puls      Y         ; restore the listed registers from the stack
Code_2C4B           lbra      Code_2B7E ; continue at the distant control-flow target
Code_2C4E           lbsr      Code_3768 ; call the referenced helper routine
                    pshs      Y         ; preserve the listed registers on the stack
                    leay      $0241,U   ; form the referenced address without reading memory
                    ldd       Addr_0027 ; load the value needed by the following operation
                    beq       Code_2C6F ; branch when the compared values are equal
                    cmpd      #Addr_0004 ; compare against the limit and set condition flags
                    ble       Code_2C6C ; branch when the signed value is at or below the limit
                    lbsr      Code_0FB0 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    cmpd      Addr_0027 ; compare against the limit and set condition flags
                    ble       Code_2C49 ; branch when the signed value is at or below the limit
                    ldd       Addr_0027 ; load the value needed by the following operation
Code_2C6C           lbsr      Code_0FB7 ; call the referenced helper routine
Code_2C6F           tst       Addr_0033 ; set condition flags from the current value
                    bne       Code_2C95 ; branch when the compared values differ
                    tfr       Y,X       ; copy the source register into the destination register
                    ldd       #Code_0100 ; load the value needed by the following operation
                    subd      Addr_0027 ; subtract the operand from the running value
                    tfr       D,Y       ; copy the source register into the destination register
                    lda       Code_0032 ; load the value needed by the following operation
                    lbsr      Code_1EC4 ; call the referenced helper routine
                    bcs       Code_2C95 ; branch when carry reports an unsigned underflow or error
                    tfr       Y,D       ; copy the source register into the destination register
                    tst       Addr_0033 ; set condition flags from the current value
                    bne       Code_2C95 ; branch when the compared values differ
                    addd      Addr_0027 ; add the operand to the running value
                    std       Addr_0027 ; save the current value in working storage
                    leax      $0241,U   ; form the referenced address without reading memory
                    puls      Y         ; restore the listed registers from the stack
                    bra       Code_2C4B ; continue at the selected control-flow target
Code_2C95           puls      Y         ; restore the listed registers from the stack
Code_2C97           lda       #$FF      ; load the value needed by the following operation
                    sta       ,Y        ; save the current value in working storage
                    sty       Addr_0004 ; save the current value in working storage
                    rts                 ; return to the caller
Code_2C9F           lda       #$01      ; load the value needed by the following operation
                    sta       Addr_000F ; save the current value in working storage
                    tst       Addr_0007 ; set condition flags from the current value
                    bne       Code_2CBB ; branch when the compared values differ
                    lda       #$01      ; load the value needed by the following operation
                    sta       Code_001E ; save the current value in working storage
                    sta       Code_0022 ; save the current value in working storage
                    lda       #$63      ; load the value needed by the following operation
                    sta       Addr_0020 ; save the current value in working storage
                    sta       Addr_0021 ; save the current value in working storage
                    lda       Addr_0008 ; load the value needed by the following operation
                    sta       Addr_001F ; save the current value in working storage
                    inca                ; advance the selected counter
                    sta       Addr_0023 ; save the current value in working storage
                    rts                 ; return to the caller
Code_2CBB           lda       #$01      ; load the value needed by the following operation
                    sta       Addr_001F ; save the current value in working storage
                    sta       Addr_0023 ; save the current value in working storage
                    lda       #$63      ; load the value needed by the following operation
                    sta       Addr_0021 ; save the current value in working storage
                    sta       Addr_0020 ; save the current value in working storage
                    lda       Addr_0007 ; load the value needed by the following operation
                    sta       Code_001E ; save the current value in working storage
                    inca                ; advance the selected counter
                    sta       Code_0022 ; save the current value in working storage
                    rts                 ; return to the caller
Code_2CCF           lbsr      Code_3738 ; call the referenced helper routine
                    ldx       Addr_0002 ; load the value needed by the following operation
Code_2CD4           ldd       ,X        ; load the value needed by the following operation
                    blt       Code_2D28 ; branch when the signed value is below the limit
                    tst       Addr_0007 ; set condition flags from the current value
                    bne       Code_2CE2 ; branch when the compared values differ
                    cmpb      #$63      ; compare against the limit and set condition flags
                    bne       Code_2D22 ; branch when the compared values differ
                    bra       Code_2CE6 ; continue at the selected control-flow target
Code_2CE2           cmpa      #$63      ; compare against the limit and set condition flags
                    bne       Code_2D22 ; branch when the compared values differ
Code_2CE6           leax      Data_2FA0,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    ldd       #Code_0B01 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    leax      Data_2FA8,PCR ; form the referenced address without reading memory
                    ldb       #$22      ; load the value needed by the following operation
                    lbsr      Code_0EB7 ; call the referenced helper routine
                    ldd       #Addr_0C01 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    leax      Data_2FCA,PCR ; form the referenced address without reading memory
                    ldb       #$22      ; load the value needed by the following operation
                    lbsr      Code_0EB7 ; call the referenced helper routine
                    ldd       #Addr_6010 ; load the value needed by the following operation
                    ldx       #Addr_601D ; load the value needed by the following operation
                    lbsr      Code_10C4 ; call the referenced helper routine
                    lda       Code_004D ; load the value needed by the following operation
                    beq       Code_2D28 ; branch when the compared values are equal
                    lbsr      Code_094E ; call the referenced helper routine
                    lbsr      Code_374F ; call the referenced helper routine
                    rts                 ; return to the caller
Code_2D22           lbsr      Code_0FB0 ; call the referenced helper routine
                    abx                 ; add the operand to the running value
                    bra       Code_2CD4 ; continue at the selected control-flow target
Code_2D28           lbsr      Code_2C9F ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    pshs      D         ; preserve the listed registers on the stack
                    ldx       Addr_0002 ; load the value needed by the following operation
Code_2D31           lda       ,X        ; load the value needed by the following operation
                    blt       Code_2D63 ; branch when the signed value is below the limit
                    lda       $02,X     ; load the value needed by the following operation
                    tfr       A,B       ; copy the source register into the destination register
                    anda      #$C0      ; mask off unwanted bits
                    cmpa      #$80      ; compare against the limit and set condition flags
                    bne       Code_2D5D ; branch when the compared values differ
                    andb      #$3F      ; mask off unwanted bits
                    subb      #$0A      ; subtract the operand from the running value
                    stb       Addr_0012 ; save the current value in working storage
                    pshs      X,B       ; preserve the listed registers on the stack
                    leax      $0E,X     ; form the referenced address without reading memory
                    lbsr      Code_2810 ; call the referenced helper routine
                    tst       Addr_001B ; set condition flags from the current value
                    bne       Code_2D5B ; branch when the compared values differ
                    ldb       Data_0029 ; load the value needed by the following operation
                    subb      ,S        ; subtract the operand from the running value
                    ble       Code_2D5B ; branch when the signed value is at or below the limit
                    clra                ; clear the selected byte or register
                    addd      $03,S     ; add the operand to the running value
                    std       $03,S     ; save the current value in working storage
Code_2D5B           puls      X,B       ; restore the listed registers from the stack
Code_2D5D           lbsr      Code_0FB0 ; call the referenced helper routine
                    abx                 ; add the operand to the running value
                    bra       Code_2D31 ; continue at the selected control-flow target
Code_2D63           puls      D         ; restore the listed registers from the stack
                    cmpd      Addr_0013 ; compare against the limit and set condition flags
                    ble       Code_2D75 ; branch when the signed value is at or below the limit
                    clr       Addr_000F ; clear the selected byte or register
                    ldb       #$01      ; load the value needed by the following operation
                    lbsr      Code_0EC3 ; call the referenced helper routine
                    lbsr      Code_374F ; call the referenced helper routine
                    rts                 ; return to the caller
Code_2D75           lbsr      Code_3768 ; call the referenced helper routine
                    tst       Addr_0007 ; set condition flags from the current value
                    bne       Code_2DC0 ; branch when the compared values differ
                    leax      $00EF,U   ; form the referenced address without reading memory
                    ldb       Addr_0008 ; load the value needed by the following operation
                    pshs      B         ; preserve the listed registers on the stack
                    lda       #$63      ; load the value needed by the following operation
                    suba      ,S+       ; subtract the operand from the running value
                    beq       Code_2D96 ; branch when the compared values are equal
                    pshs      A         ; preserve the listed registers on the stack
Code_2D8C           lda       ,-X       ; load the value needed by the following operation
                    sta       $01,X     ; save the current value in working storage
                    dec       ,S        ; decrement the selected counter
                    bgt       Code_2D8C ; branch when the signed value is above the limit
                    leas      $01,S     ; form the referenced address without reading memory
Code_2D96           leax      $008C,U   ; form the referenced address without reading memory
                    lda       #$07      ; load the value needed by the following operation
                    sta       B,X       ; save the current value in working storage
                    leax      $0153,U   ; form the referenced address without reading memory
                    ldb       Addr_0008 ; load the value needed by the following operation
                    pshs      B         ; preserve the listed registers on the stack
                    lda       #$63      ; load the value needed by the following operation
                    suba      ,S+       ; subtract the operand from the running value
                    beq       Code_2DB8 ; branch when the compared values are equal
                    pshs      A         ; preserve the listed registers on the stack
Code_2DAE           lda       ,-X       ; load the value needed by the following operation
                    sta       $01,X     ; save the current value in working storage
                    dec       ,S        ; decrement the selected counter
                    bgt       Code_2DAE ; branch when the signed value is above the limit
                    leas      $01,S     ; form the referenced address without reading memory
Code_2DB8           leax      $00F0,U   ; form the referenced address without reading memory
                    lda       #$02      ; load the value needed by the following operation
                    sta       B,X       ; save the current value in working storage
Code_2DC0           ldx       Addr_0002 ; load the value needed by the following operation
Code_2DC2           ldd       ,X        ; load the value needed by the following operation
                    blt       Code_2DF1 ; branch when the signed value is below the limit
                    tst       Addr_0007 ; set condition flags from the current value
                    bne       Code_2DD0 ; branch when the compared values differ
                    cmpb      #$63      ; compare against the limit and set condition flags
                    bne       Code_2DDB ; branch when the compared values differ
                    bra       Code_2DD4 ; continue at the selected control-flow target
Code_2DD0           cmpa      #$63      ; compare against the limit and set condition flags
                    bne       Code_2DE4 ; branch when the compared values differ
Code_2DD4           tfr       X,Y       ; copy the source register into the destination register
                    lbsr      Code_0F7C ; call the referenced helper routine
                    bra       Code_2DC2 ; continue at the selected control-flow target
Code_2DDB           cmpb      Addr_0008 ; compare against the limit and set condition flags
                    blt       Code_2DEB ; branch when the signed value is below the limit
                    incb                ; advance the selected counter
                    stb       $01,X     ; save the current value in working storage
                    bra       Code_2DEB ; continue at the selected control-flow target
Code_2DE4           cmpa      Addr_0007 ; compare against the limit and set condition flags
                    blt       Code_2DEB ; branch when the signed value is below the limit
                    inca                ; advance the selected counter
                    sta       ,X        ; save the current value in working storage
Code_2DEB           lbsr      Code_0FB0 ; call the referenced helper routine
                    abx                 ; add the operand to the running value
                    bra       Code_2DC2 ; continue at the selected control-flow target
Code_2DF1           lbsr      Code_2C9F ; call the referenced helper routine
Code_2DF4           ldx       Addr_0002 ; load the value needed by the following operation
Code_2DF6           lbsr      Code_3768 ; call the referenced helper routine
                    lda       ,X        ; load the value needed by the following operation
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    beq       Code_2E5D ; branch when the compared values are equal
                    lda       $02,X     ; load the value needed by the following operation
                    tfr       A,B       ; copy the source register into the destination register
                    anda      #$C0      ; mask off unwanted bits
                    cmpa      #$80      ; compare against the limit and set condition flags
                    bne       Code_2E57 ; branch when the compared values differ
                    andb      #$3F      ; mask off unwanted bits
                    subb      #$0A      ; subtract the operand from the running value
                    stb       Addr_0012 ; save the current value in working storage
                    pshs      X,B       ; preserve the listed registers on the stack
                    leax      $0E,X     ; form the referenced address without reading memory
                    lbsr      Code_2810 ; call the referenced helper routine
                    tst       Addr_001B ; set condition flags from the current value
                    bne       Code_2E51 ; branch when the compared values differ
                    ldb       Data_0029 ; load the value needed by the following operation
                    cmpb      ,S        ; compare against the limit and set condition flags
                    beq       Code_2E35 ; branch when the compared values are equal
                    blt       Code_2E28 ; branch when the signed value is below the limit
                    subb      ,S+       ; subtract the operand from the running value
                    lda       #$01      ; load the value needed by the following operation
                    bra       Code_2E2D ; continue at the selected control-flow target
Code_2E28           ldb       ,S+       ; load the value needed by the following operation
                    subb      Data_0029 ; subtract the operand from the running value
                    clra                ; clear the selected byte or register
Code_2E2D           ldx       ,S        ; load the value needed by the following operation
                    bsr       Code_2E82 ; call the referenced helper routine
                    ldb       Data_0029 ; load the value needed by the following operation
                    bra       Code_2E37 ; continue at the selected control-flow target
Code_2E35           leas      $01,S     ; form the referenced address without reading memory
Code_2E37           leax      $01FF,U   ; form the referenced address without reading memory
                    ldy       ,S        ; load the value needed by the following operation
                    addb      #$0A      ; add the operand to the running value
                    orb       #$80      ; set the selected flag bits
                    stb       $02,Y     ; save the current value in working storage
                    ldb       Data_0029 ; load the value needed by the following operation
                    leay      $0E,Y     ; form the referenced address without reading memory
                    lbsr      Code_0FB7 ; call the referenced helper routine
                    clr       Data_0029 ; clear the selected byte or register
                    puls      X         ; restore the listed registers from the stack
                    bra       Code_2E57 ; continue at the selected control-flow target
Code_2E51           puls      X,B       ; restore the listed registers from the stack
                    lda       #$03      ; load the value needed by the following operation
                    sta       $0D,X     ; save the current value in working storage
Code_2E57           lbsr      Code_0FB0 ; call the referenced helper routine
                    abx                 ; add the operand to the running value
                    bra       Code_2DF6 ; continue at the selected control-flow target
Code_2E5D           clr       Addr_000F ; clear the selected byte or register
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    std       Addr_000D ; save the current value in working storage
                    lbsr      Code_0E5A ; call the referenced helper routine
                    lda       Addr_0008 ; load the value needed by the following operation
                    cmpa      Addr_000C ; compare against the limit and set condition flags
                    ble       Code_2E71 ; branch when the signed value is at or below the limit
                    sta       Addr_000B ; save the current value in working storage
                    lbsr      Code_0E5A ; call the referenced helper routine
Code_2E71           ldd       Addr_0007 ; load the value needed by the following operation
                    lbsr      Code_0F2F ; call the referenced helper routine
                    stx       Addr_000D ; save the current value in working storage
                    lbsr      Code_094E ; call the referenced helper routine
                    lbsr      Code_374F ; call the referenced helper routine
                    lbsr      Code_11C9 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_2E82           pshs      Y,X,A     ; preserve the listed registers on the stack
                    clra                ; clear the selected byte or register
                    pshs      D         ; preserve the listed registers on the stack
                    lbsr      Code_0FB0 ; call the referenced helper routine
                    abx                 ; add the operand to the running value
                    tfr       X,D       ; copy the source register into the destination register
                    tst       $02,S     ; set condition flags from the current value
                    bne       Code_2EBB ; branch when the compared values differ
                    subd      ,S        ; subtract the operand from the running value
                    tfr       D,Y       ; copy the source register into the destination register
                    ldd       Addr_0013 ; load the value needed by the following operation
                    addd      ,S        ; add the operand to the running value
                    std       Addr_0013 ; save the current value in working storage
                    pshs      X         ; preserve the listed registers on the stack
                    ldd       Addr_0004 ; load the value needed by the following operation
                    subd      ,S++      ; subtract the operand from the running value
                    beq       Code_2EB0 ; branch when the compared values are equal
Code_2EA3           sta       ,S        ; save the current value in working storage
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,Y+       ; store the value and advance the destination pointer
                    lda       ,S        ; load the value needed by the following operation
                    subd      #Addr_0001 ; subtract the operand from the running value
                    bgt       Code_2EA3 ; branch when the signed value is above the limit
Code_2EB0           lda       #$FF      ; load the value needed by the following operation
                    sta       ,Y        ; save the current value in working storage
                    sty       Addr_0004 ; save the current value in working storage
Code_2EB7           leas      $03,S     ; form the referenced address without reading memory
                    puls      PC,Y,X    ; restore the listed registers from the stack
Code_2EBB           ldd       Addr_0004 ; load the value needed by the following operation
                    addd      ,S        ; add the operand to the running value
                    tfr       D,Y       ; copy the source register into the destination register
                    ldd       Addr_0013 ; load the value needed by the following operation
                    subd      ,S        ; subtract the operand from the running value
                    blt       Code_2EEB ; branch when the signed value is below the limit
                    std       Addr_0013 ; save the current value in working storage
                    pshs      X         ; preserve the listed registers on the stack
                    ldd       Addr_0004 ; load the value needed by the following operation
                    sty       Addr_0004 ; save the current value in working storage
                    tfr       D,X       ; copy the source register into the destination register
                    subd      ,S++      ; subtract the operand from the running value
                    beq       Code_2EE3 ; branch when the compared values are equal
Code_2ED6           sta       ,S        ; save the current value in working storage
                    lda       ,-X       ; load the value needed by the following operation
                    sta       ,-Y       ; save the current value in working storage
                    lda       ,S        ; load the value needed by the following operation
                    subd      #Addr_0001 ; subtract the operand from the running value
                    bgt       Code_2ED6 ; branch when the signed value is above the limit
Code_2EE3           ldx       Addr_0004 ; load the value needed by the following operation
                    lda       #$FF      ; load the value needed by the following operation
                    sta       ,X        ; save the current value in working storage
                    bra       Code_2EB7 ; continue at the selected control-flow target
Code_2EEB           ldb       #$01      ; load the value needed by the following operation
                    lbsr      Code_0EC3 ; call the referenced helper routine
                    bra       Code_2EB7 ; continue at the selected control-flow target
Code_2EF2           tst       Addr_0007 ; set condition flags from the current value
                    bne       Code_2F3C ; branch when the compared values differ
                    leax      $008C,U   ; form the referenced address without reading memory
                    ldb       Addr_0008 ; load the value needed by the following operation
                    abx                 ; add the operand to the running value
                    pshs      B         ; preserve the listed registers on the stack
                    lda       #$63      ; load the value needed by the following operation
                    suba      ,S+       ; subtract the operand from the running value
                    beq       Code_2F11 ; branch when the compared values are equal
                    pshs      A         ; preserve the listed registers on the stack
Code_2F07           lda       $01,X     ; load the value needed by the following operation
                    sta       ,X+       ; store the value and advance the destination pointer
                    dec       ,S        ; decrement the selected counter
                    bgt       Code_2F07 ; branch when the signed value is above the limit
                    leas      $01,S     ; form the referenced address without reading memory
Code_2F11           leax      $00EF,U   ; form the referenced address without reading memory
                    lda       #$07      ; load the value needed by the following operation
                    sta       ,X        ; save the current value in working storage
                    leax      $00F0,U   ; form the referenced address without reading memory
                    ldb       Addr_0008 ; load the value needed by the following operation
                    abx                 ; add the operand to the running value
                    pshs      B         ; preserve the listed registers on the stack
                    lda       #$63      ; load the value needed by the following operation
                    suba      ,S+       ; subtract the operand from the running value
                    beq       Code_2F34 ; branch when the compared values are equal
                    pshs      A         ; preserve the listed registers on the stack
Code_2F2A           lda       $01,X     ; load the value needed by the following operation
                    sta       ,X+       ; store the value and advance the destination pointer
                    dec       ,S        ; decrement the selected counter
                    bgt       Code_2F2A ; branch when the signed value is above the limit
                    leas      $01,S     ; form the referenced address without reading memory
Code_2F34           leax      $0153,U   ; form the referenced address without reading memory
                    lda       #$02      ; load the value needed by the following operation
                    sta       ,X        ; save the current value in working storage
Code_2F3C           ldx       Addr_0002 ; load the value needed by the following operation
Code_2F3E           ldd       ,X        ; load the value needed by the following operation
                    blt       Code_2F6D ; branch when the signed value is below the limit
                    tst       Addr_0007 ; set condition flags from the current value
                    bne       Code_2F4C ; branch when the compared values differ
                    cmpb      Addr_0008 ; compare against the limit and set condition flags
                    bne       Code_2F57 ; branch when the compared values differ
                    bra       Code_2F50 ; continue at the selected control-flow target
Code_2F4C           cmpa      Addr_0007 ; compare against the limit and set condition flags
                    bne       Code_2F60 ; branch when the compared values differ
Code_2F50           tfr       X,Y       ; copy the source register into the destination register
                    lbsr      Code_0F7C ; call the referenced helper routine
                    bra       Code_2F3E ; continue at the selected control-flow target
Code_2F57           cmpb      Addr_0008 ; compare against the limit and set condition flags
                    blt       Code_2F67 ; branch when the signed value is below the limit
                    decb                ; decrement the selected counter
                    stb       $01,X     ; save the current value in working storage
                    bra       Code_2F67 ; continue at the selected control-flow target
Code_2F60           cmpa      Addr_0007 ; compare against the limit and set condition flags
                    blt       Code_2F67 ; branch when the signed value is below the limit
                    deca                ; decrement the selected counter
                    sta       ,X        ; save the current value in working storage
Code_2F67           lbsr      Code_0FB0 ; call the referenced helper routine
                    abx                 ; add the operand to the running value
                    bra       Code_2F3E ; continue at the selected control-flow target
Code_2F6D           tst       Addr_0007 ; set condition flags from the current value
                    bne       Code_2F86 ; branch when the compared values differ
                    lda       #$01      ; load the value needed by the following operation
                    sta       Code_001E ; save the current value in working storage
                    sta       Code_0022 ; save the current value in working storage
                    lda       #$63      ; load the value needed by the following operation
                    sta       Addr_0020 ; save the current value in working storage
                    sta       Addr_0021 ; save the current value in working storage
                    lda       Addr_0008 ; load the value needed by the following operation
                    sta       Addr_0023 ; save the current value in working storage
                    inca                ; advance the selected counter
                    sta       Addr_001F ; save the current value in working storage
                    bra       Code_2F99 ; continue at the selected control-flow target
Code_2F86           lda       #$01      ; load the value needed by the following operation
                    sta       Addr_001F ; save the current value in working storage
                    sta       Addr_0023 ; save the current value in working storage
                    lda       #$63      ; load the value needed by the following operation
                    sta       Addr_0021 ; save the current value in working storage
                    sta       Addr_0020 ; save the current value in working storage
                    lda       Addr_0007 ; load the value needed by the following operation
                    sta       Code_0022 ; save the current value in working storage
                    inca                ; advance the selected counter
                    sta       Code_001E ; save the current value in working storage
Code_2F99           lda       #$01      ; load the value needed by the following operation
                    sta       Addr_000F ; save the current value in working storage
                    lbra      Code_2DF4 ; continue at the distant control-flow target
Data_2FA0           fcb       $00,$00,$0A ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $04,$00   ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $18       ; table, bitmap, or initialized data bytes
Data_2FA8           fcc       "Data in last row/col "        ; embedded text or resource bytes
                    fcc       "will be lost."                ; embedded text or resource bytes
Data_2FCA           fcc       "Continue ?        Yes"        ; embedded text or resource bytes
                    fcc       "          No "                ; embedded text or resource bytes
Code_2FEC           pshs      Y,X,D     ; preserve the listed registers on the stack
                    leax      Data_3602,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    ldx       #Addr_0002 ; load the value needed by the following operation
                    leay      -$02,X    ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    leax      Data_361A,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
Code_3007           leax      $01A1,U   ; form the referenced address without reading memory
                    ldd       #Code_2032 ; load the value needed by the following operation
                    lbsr      Code_10BE ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    sta       ,X        ; save the current value in working storage
                    tst       Addr_0006 ; set condition flags from the current value
                    bne       Code_3037 ; branch when the compared values differ
                    ldx       Addr_000D ; load the value needed by the following operation
                    beq       Code_3037 ; branch when the compared values are equal
                    lda       $02,X     ; load the value needed by the following operation
                    anda      #$C0      ; mask off unwanted bits
                    bpl       Code_3037 ; branch while the tested value is nonnegative
                    lda       $0D,X     ; load the value needed by the following operation
                    cmpa      #$03      ; compare against the limit and set condition flags
                    beq       Code_3037 ; branch when the compared values are equal
                    ldb       $02,X     ; load the value needed by the following operation
                    andb      #$3F      ; mask off unwanted bits
                    leax      $0E,X     ; form the referenced address without reading memory
                    subb      #$0A      ; subtract the operand from the running value
Code_3030           leay      $01A1,U   ; form the referenced address without reading memory
                    lbsr      Code_0FB7 ; call the referenced helper routine
Code_3037           leax      $01A1,U   ; form the referenced address without reading memory
                    pshs      Y,X       ; preserve the listed registers on the stack
                    ldx       #DeskMateService ; load the value needed by the following operation
                    leay      $01,X     ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    puls      Y,X       ; restore the listed registers from the stack
                    ldy       #Code_1013 ; load the value needed by the following operation
                    ldd       #Addr_9900 ; load the value needed by the following operation
                    tst       Addr_004A ; set condition flags from the current value
                    beq       Code_3057 ; branch when the compared values are equal
                    lda       #$B2      ; load the value needed by the following operation
                    leay      -$01,Y    ; form the referenced address without reading memory
Code_3057           lbsr      Code_118E ; call the referenced helper routine
                    cmpa      #$05      ; compare against the limit and set condition flags
                    beq       Code_3072 ; branch when the compared values are equal
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    beq       Code_3075 ; branch when the compared values are equal
                    ldy       #Code_1013 ; load the value needed by the following operation
                    ldd       #Code_1900 ; load the value needed by the following operation
                    tst       Addr_004A ; set condition flags from the current value
                    beq       Code_3070 ; branch when the compared values are equal
                    asla                ; shift left and update carry
                    leay      -$01,Y    ; form the referenced address without reading memory
Code_3070           bra       Code_3057 ; continue at the selected control-flow target
Code_3072           lbra      Code_315C ; continue at the distant control-flow target
Code_3075           ldb       #$32      ; load the value needed by the following operation
                    stb       Addr_0012 ; save the current value in working storage
                    clr       Addr_0016 ; clear the selected byte or register
                    leax      $01A1,U   ; form the referenced address without reading memory
Code_307F           lbsr      Code_3500 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_3095 ; branch when the compared values are equal
                    inc       Addr_0016 ; advance the selected counter
                    cmpa      #$61      ; compare against the limit and set condition flags
                    blt       Code_307F ; branch when the signed value is below the limit
                    cmpa      #$7A      ; compare against the limit and set condition flags
                    bgt       Code_307F ; branch when the signed value is above the limit
                    suba      #$20      ; subtract the operand from the running value
                    sta       -$01,X    ; save the current value in working storage
                    bra       Code_307F ; continue at the selected control-flow target
Code_3095           tst       Addr_0016 ; set condition flags from the current value
                    beq       Code_3072 ; branch when the compared values are equal
                    lda       #$01      ; load the value needed by the following operation
                    sta       Addr_001A ; save the current value in working storage
                    leax      $01A1,U   ; form the referenced address without reading memory
                    ldb       #$32      ; load the value needed by the following operation
                    stb       Addr_0012 ; save the current value in working storage
                    lda       Addr_0007 ; load the value needed by the following operation
                    sta       Code_001E ; save the current value in working storage
                    lda       Addr_0008 ; load the value needed by the following operation
                    sta       Addr_001F ; save the current value in working storage
                    clr       Addr_0010 ; clear the selected byte or register
                    lbsr      Code_3198 ; call the referenced helper routine
                    cmpa      #$01      ; compare against the limit and set condition flags
                    bne       Code_30CA ; branch when the compared values differ
                    ldx       #Addr_0002 ; load the value needed by the following operation
                    leay      -$02,X    ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    leax      Data_362D,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
                    lbra      Code_3007 ; continue at the distant control-flow target
Code_30CA           leax      $01A1,U   ; form the referenced address without reading memory
                    tfr       X,Y       ; copy the source register into the destination register
                    ldb       #$32      ; load the value needed by the following operation
Code_30D2           lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bne       Code_30DB ; branch when the compared values differ
                    decb                ; decrement the selected counter
                    bra       Code_30D2 ; continue at the selected control-flow target
Code_30DB           cmpb      #$32      ; compare against the limit and set condition flags
                    beq       Code_30EC ; branch when the compared values are equal
                    pshs      B         ; preserve the listed registers on the stack
Code_30E1           sta       ,Y+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    beq       Code_30EA ; branch when the compared values are equal
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    bra       Code_30E1 ; continue at the selected control-flow target
Code_30EA           puls      B         ; restore the listed registers from the stack
Code_30EC           leax      $01A1,U   ; form the referenced address without reading memory
                    abx                 ; add the operand to the running value
Code_30F1           lda       ,-X       ; load the value needed by the following operation
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bne       Code_30FA ; branch when the compared values differ
                    decb                ; decrement the selected counter
                    bgt       Code_30F1 ; branch when the signed value is above the limit
Code_30FA           stb       Addr_0012 ; save the current value in working storage
                    pshs      B         ; preserve the listed registers on the stack
                    ldd       Addr_0007 ; load the value needed by the following operation
                    lbsr      Code_0F2F ; call the referenced helper routine
                    stx       Addr_000D ; save the current value in working storage
                    tfr       X,Y       ; copy the source register into the destination register
                    puls      B         ; restore the listed registers from the stack
                    leax      $0193,U   ; form the referenced address without reading memory
                    lda       Addr_0007 ; load the value needed by the following operation
                    sta       ,X+       ; store the value and advance the destination pointer
                    lda       Addr_0008 ; load the value needed by the following operation
                    sta       ,X+       ; store the value and advance the destination pointer
                    addb      #$0A      ; add the operand to the running value
                    pshs      B         ; preserve the listed registers on the stack
                    orb       #$80      ; set the selected flag bits
                    stb       ,X+       ; store the value and advance the destination pointer
                    leay      ,Y        ; form the referenced address without reading memory
                    beq       Code_312F ; branch when the compared values are equal
                    ldb       $02,Y     ; load the value needed by the following operation
                    andb      #$C0      ; mask off unwanted bits
                    beq       Code_312F ; branch when the compared values are equal
                    ldb       $03,Y     ; load the value needed by the following operation
                    andb      #$F7      ; mask off unwanted bits
                    stb       ,X+       ; store the value and advance the destination pointer
                    bra       Code_3137 ; continue at the selected control-flow target
Code_312F           leay      $00F0,U   ; form the referenced address without reading memory
                    ldb       A,Y       ; load the value needed by the following operation
                    stb       ,X+       ; store the value and advance the destination pointer
Code_3137           clra                ; clear the selected byte or register
                    ldb       #$09      ; load the value needed by the following operation
                    lbsr      Code_10BE ; call the referenced helper routine
                    ldb       #$02      ; load the value needed by the following operation
                    stb       ,X        ; save the current value in working storage
                    leax      $0193,U   ; form the referenced address without reading memory
                    puls      B         ; restore the listed registers from the stack
                    addb      #$04      ; add the operand to the running value
                    lbsr      Code_0F4A ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_317D ; branch when the compared values are equal
                    tst       Addr_0006 ; set condition flags from the current value
                    beq       Code_315C ; branch when the compared values are equal
                    lbsr      Code_2769 ; call the referenced helper routine
Code_3156           clr       Addr_0006 ; clear the selected byte or register
                    clr       Addr_001A ; clear the selected byte or register
                    puls      PC,Y,X,D  ; restore the listed registers from the stack
Code_315C           tst       Addr_0006 ; set condition flags from the current value
                    bne       Code_3156 ; branch when the compared values differ
                    tst       Addr_0036 ; set condition flags from the current value
                    beq       Code_3172 ; branch when the compared values are equal
                    lda       #$09      ; load the value needed by the following operation
                    sta       Addr_001F ; save the current value in working storage
                    lda       Addr_0007 ; load the value needed by the following operation
                    suba      Addr_0009 ; subtract the operand from the running value
                    cmpa      #$10      ; compare against the limit and set condition flags
                    blt       Code_3156 ; branch when the signed value is below the limit
                    bra       Code_317D ; continue at the selected control-flow target
Code_3172           lda       #$05      ; load the value needed by the following operation
                    sta       Addr_001F ; save the current value in working storage
                    lda       #$0F      ; load the value needed by the following operation
                    sta       Code_001E ; save the current value in working storage
                    lbsr      Code_45F3 ; call the referenced helper routine
Code_317D           ldd       Addr_0007 ; load the value needed by the following operation
                    lbsr      Code_0F2F ; call the referenced helper routine
                    stx       Addr_000D ; save the current value in working storage
                    leax      ,X        ; form the referenced address without reading memory
                    beq       Code_3156 ; branch when the compared values are equal
                    lbsr      Code_15FF ; call the referenced helper routine
                    lbsr      Code_166E ; call the referenced helper routine
                    ldx       Addr_000D ; load the value needed by the following operation
                    lbsr      Code_0B62 ; call the referenced helper routine
                    lbsr      Code_09EC ; call the referenced helper routine
                    bra       Code_3156 ; continue at the selected control-flow target
Code_3198           leay      $01F1,U   ; form the referenced address without reading memory
                    lda       #$01      ; load the value needed by the following operation
                    sta       Addr_001B ; save the current value in working storage
                    sta       Code_001C ; save the current value in working storage
                    clr       Addr_001D ; clear the selected byte or register
                    lbsr      Code_3500 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_31C8 ; branch when the compared values are equal
                    cmpa      #$3F      ; compare against the limit and set condition flags
                    beq       Code_31D1 ; branch when the compared values are equal
                    inc       Addr_0012 ; advance the selected counter
                    leax      -$01,X    ; form the referenced address without reading memory
                    bsr       Code_31D4 ; call the referenced helper routine
                    tst       Addr_001D ; set condition flags from the current value
                    bne       Code_31C8 ; branch when the compared values differ
                    lda       Addr_001B ; load the value needed by the following operation
                    cmpa      #$01      ; compare against the limit and set condition flags
                    bne       Code_31C8 ; branch when the compared values differ
                    tst       Addr_0012 ; set condition flags from the current value
                    beq       Code_31CB ; branch when the compared values are equal
                    lbsr      Code_3500 ;31C2: 17 03 3B       '.. ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_31CB ; branch when the compared values are equal
Code_31C8           lda       #$01      ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_31CB           lda       #$FF      ; load the value needed by the following operation
                    sta       ,Y+       ; store the value and advance the destination pointer
                    clra                ; clear the selected byte or register
                    rts                 ; return to the caller
Code_31D1           lda       #$02      ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_31D4           tst       Addr_0012 ; set condition flags from the current value
                    beq       Code_31E1 ; branch when the compared values are equal
                    lbsr      Code_3500 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_31E1 ; branch when the compared values are equal
                    bsr       Code_31E6 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_31E1           lda       #$01      ; load the value needed by the following operation
                    sta       Addr_001D ; save the current value in working storage
                    rts                 ; return to the caller
Code_31E6           bsr       Code_3222 ; call the referenced helper routine
                    lbsr      Code_3500 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_3206 ; branch when the compared values are equal
                    cmpa      #$2B      ; compare against the limit and set condition flags
                    beq       Code_320B ; branch when the compared values are equal
                    cmpa      #$2D      ; compare against the limit and set condition flags
                    beq       Code_320F ; branch when the compared values are equal
                    cmpa      #$2A      ; compare against the limit and set condition flags
                    beq       Code_3213 ; branch when the compared values are equal
                    cmpa      #$2F      ; compare against the limit and set condition flags
                    beq       Code_3217 ; branch when the compared values are equal
                    cmpa      #$21      ; compare against the limit and set condition flags
                    beq       Code_3207 ; branch when the compared values are equal
                    leax      -$01,X    ; form the referenced address without reading memory
                    inc       Addr_0012 ; advance the selected counter
Code_3206           rts                 ; return to the caller
Code_3207           lda       #$05      ; load the value needed by the following operation
                    bra       Code_3219 ; continue at the selected control-flow target
Code_320B           lda       #$01      ; load the value needed by the following operation
                    bra       Code_3219 ; continue at the selected control-flow target
Code_320F           lda       #$02      ; load the value needed by the following operation
                    bra       Code_3219 ; continue at the selected control-flow target
Code_3213           lda       #$03      ; load the value needed by the following operation
                    bra       Code_3219 ; continue at the selected control-flow target
Code_3217           lda       #$04      ; load the value needed by the following operation
Code_3219           sta       $01,Y     ; save the current value in working storage
                    lda       Addr_001B ; load the value needed by the following operation
                    sta       ,Y++      ; store the value and advance the destination pointer
                    bsr       Code_31D4 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_3222           pshs      A         ; preserve the listed registers on the stack
                    cmpa      #$41      ; compare against the limit and set condition flags
                    bne       Code_3238 ; branch when the compared values differ
                    ldd       ,X        ; load the value needed by the following operation
                    cmpd      #Code_4253 ; compare against the limit and set condition flags
                    beq       Code_329C ; branch when the compared values are equal
                    cmpd      #Data_5647 ; compare against the limit and set condition flags
                    beq       Code_32A0 ; branch when the compared values are equal
                    bra       Code_3266 ; continue at the selected control-flow target
Code_3238           cmpa      #$43      ; compare against the limit and set condition flags
                    bne       Code_3246 ; branch when the compared values differ
                    ldd       ,X        ; load the value needed by the following operation
                    cmpd      #Code_4F53 ; compare against the limit and set condition flags
                    beq       Code_3294 ; branch when the compared values are equal
                    bne       Code_3266 ; branch when the compared values differ
Code_3246           cmpa      #$49      ; compare against the limit and set condition flags
                    bne       Code_3254 ; branch when the compared values differ
                    ldd       ,X        ; load the value needed by the following operation
                    cmpd      #Code_4E54 ; compare against the limit and set condition flags
                    beq       Code_32A4 ; branch when the compared values are equal
                    bra       Code_3266 ; continue at the selected control-flow target
Code_3254           cmpa      #$4D      ; compare against the limit and set condition flags
                    bne       Code_326C ; branch when the compared values differ
                    ldd       ,X        ; load the value needed by the following operation
                    cmpd      #Code_494E ; compare against the limit and set condition flags
                    beq       Code_32A8 ; branch when the compared values are equal
                    cmpd      #Addr_4158 ; compare against the limit and set condition flags
                    beq       Code_32AC ; branch when the compared values are equal
Code_3266           puls      A         ; restore the listed registers from the stack
                    lbsr      Code_333D ; call the referenced helper routine
                    rts                 ; return to the caller
Code_326C           cmpa      #$53      ; compare against the limit and set condition flags
                    bne       Code_3280 ; branch when the compared values differ
                    ldd       ,X        ; load the value needed by the following operation
                    cmpd      #Data_554D ; compare against the limit and set condition flags
                    beq       Code_3298 ; branch when the compared values are equal
                    cmpd      #Code_494E ; compare against the limit and set condition flags
                    beq       Code_3290 ; branch when the compared values are equal
                    bne       Code_3266 ; branch when the compared values differ
Code_3280           cmpa      #$54      ; compare against the limit and set condition flags
                    bne       Code_3266 ; branch when the compared values differ
                    ldd       ,X        ; load the value needed by the following operation
                    cmpd      #Addr_414E ; compare against the limit and set condition flags
                    bne       Code_3266 ; branch when the compared values differ
                    lda       #$0F      ; load the value needed by the following operation
                    bra       Code_32FF ; continue at the selected control-flow target
Code_3290           lda       #$0D      ; load the value needed by the following operation
                    bra       Code_32FF ; continue at the selected control-flow target
Code_3294           lda       #$0E      ; load the value needed by the following operation
                    bra       Code_32FF ; continue at the selected control-flow target
Code_3298           lda       #$07      ; load the value needed by the following operation
                    bra       Code_32AE ; continue at the selected control-flow target
Code_329C           lda       #$0B      ; load the value needed by the following operation
                    bra       Code_32FF ; continue at the selected control-flow target
Code_32A0           lda       #$0A      ; load the value needed by the following operation
                    bra       Code_32AE ; continue at the selected control-flow target
Code_32A4           lda       #$0C      ; load the value needed by the following operation
                    bra       Code_32FF ; continue at the selected control-flow target
Code_32A8           lda       #$08      ; load the value needed by the following operation
                    bra       Code_32AE ; continue at the selected control-flow target
Code_32AC           lda       #$09      ; load the value needed by the following operation
Code_32AE           ldb       Addr_001B ; load the value needed by the following operation
                    stb       ,Y+       ; store the value and advance the destination pointer
                    sta       ,Y+       ; store the value and advance the destination pointer
                    leas      $01,S     ; form the referenced address without reading memory
                    dec       Addr_0012 ; decrement the selected counter
                    dec       Addr_0012 ; decrement the selected counter
                    leax      $02,X     ; form the referenced address without reading memory
                    lbsr      Code_3500 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_32FA ; branch when the compared values are equal
                    cmpa      #$28      ; compare against the limit and set condition flags
                    bne       Code_32FA ; branch when the compared values differ
                    lbsr      Code_347F ; call the referenced helper routine
                    tst       Addr_001D ; set condition flags from the current value
                    bne       Code_32FA ; branch when the compared values differ
                    cmpa      Code_001E ; compare against the limit and set condition flags
                    bne       Code_32D7 ; branch when the compared values differ
                    cmpb      Addr_001F ; compare against the limit and set condition flags
                    beq       Code_32FA ; branch when the compared values are equal
                    bra       Code_32DD ; continue at the selected control-flow target
Code_32D7           bgt       Code_32FA ; branch when the signed value is above the limit
                    cmpb      Addr_001F ; compare against the limit and set condition flags
                    bne       Code_32FA ; branch when the compared values differ
Code_32DD           bgt       Code_32FA ; branch when the signed value is above the limit
                    std       ,Y++      ; store the value and advance the destination pointer
                    ldd       Code_001E ; load the value needed by the following operation
                    cmpa      -$02,Y    ; compare against the limit and set condition flags
                    bne       Code_32EA ; branch when the compared values differ
                    decb                ; decrement the selected counter
                    bra       Code_32EB ; continue at the selected control-flow target
Code_32EA           deca                ; decrement the selected counter
Code_32EB           std       ,Y++      ; store the value and advance the destination pointer
                    leay      $05,Y     ; form the referenced address without reading memory
                    lbsr      Code_3500 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_32FA ; branch when the compared values are equal
                    cmpa      #$29      ; compare against the limit and set condition flags
                    bne       Code_32FA ; branch when the compared values differ
                    rts                 ; return to the caller
Code_32FA           lda       #$01      ; load the value needed by the following operation
                    sta       Addr_001D ; save the current value in working storage
                    rts                 ; return to the caller
Code_32FF           ldb       Addr_001B ; load the value needed by the following operation
                    stb       ,Y+       ; store the value and advance the destination pointer
                    sta       ,Y+       ; store the value and advance the destination pointer
                    leas      $01,S     ; form the referenced address without reading memory
                    dec       Addr_0012 ; decrement the selected counter
                    dec       Addr_0012 ; decrement the selected counter
                    leax      $02,X     ; form the referenced address without reading memory
                    lbsr      Code_3500 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_32FA ; branch when the compared values are equal
                    cmpa      #$28      ; compare against the limit and set condition flags
                    bne       Code_32FA ; branch when the compared values differ
                    lda       Addr_001B ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    cmpa      #$0A      ; compare against the limit and set condition flags
                    beq       Code_32FA ; branch when the compared values are equal
                    sta       Addr_001B ; save the current value in working storage
                    cmpa      Code_001C ; compare against the limit and set condition flags
                    ble       Code_3326 ; branch when the signed value is at or below the limit
                    sta       Code_001C ; save the current value in working storage
Code_3326           lbsr      Code_31D4 ; call the referenced helper routine
                    tst       Addr_001D ; set condition flags from the current value
                    bne       Code_32FA ; branch when the compared values differ
                    lbsr      Code_3500 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_32FA ; branch when the compared values are equal
                    cmpa      #$29      ; compare against the limit and set condition flags
                    bne       Code_32FA ; branch when the compared values differ
                    lda       Addr_001B ; load the value needed by the following operation
                    deca                ; decrement the selected counter
                    sta       Addr_001B ; save the current value in working storage
                    rts                 ; return to the caller
Code_333D           cmpa      #$28      ; compare against the limit and set condition flags
                    bne       Code_3367 ; branch when the compared values differ
                    lda       Addr_001B ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    cmpa      #$0A      ; compare against the limit and set condition flags
                    beq       Code_336A ; branch when the compared values are equal
                    sta       Addr_001B ; save the current value in working storage
                    cmpa      Code_001C ; compare against the limit and set condition flags
                    ble       Code_3350 ; branch when the signed value is at or below the limit
                    sta       Code_001C ; save the current value in working storage
Code_3350           lbsr      Code_31D4 ; call the referenced helper routine
                    tst       Addr_001D ; set condition flags from the current value
                    bne       Code_336A ; branch when the compared values differ
                    lbsr      Code_3500 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_336A ; branch when the compared values are equal
                    cmpa      #$29      ; compare against the limit and set condition flags
                    bne       Code_336A ; branch when the compared values differ
                    lda       Addr_001B ; load the value needed by the following operation
                    deca                ; decrement the selected counter
                    sta       Addr_001B ; save the current value in working storage
                    rts                 ; return to the caller
Code_3367           bsr       Code_336F ; call the referenced helper routine
                    rts                 ; return to the caller
Code_336A           lda       #$01      ; load the value needed by the following operation
                    sta       Addr_001D ; save the current value in working storage
                    rts                 ; return to the caller
Code_336F           cmpa      #$23      ; compare against the limit and set condition flags
                    beq       Code_337D ; branch when the compared values are equal
                    cmpa      #$52      ; compare against the limit and set condition flags
                    beq       Code_3389 ; branch when the compared values are equal
                    cmpa      #$43      ; compare against the limit and set condition flags
                    bne       Code_33A3 ; branch when the compared values differ
                    bra       Code_3389 ; continue at the selected control-flow target
Code_337D           tst       Addr_0012 ; set condition flags from the current value
                    beq       Code_33EE ; branch when the compared values are equal
                    lda       ,X        ; load the value needed by the following operation
                    cmpa      #$20      ; compare against the limit and set condition flags
                    beq       Code_33EE ; branch when the compared values are equal
                    bra       Code_338D ; continue at the selected control-flow target
Code_3389           leax      -$01,X    ; form the referenced address without reading memory
                    inc       Addr_0012 ; advance the selected counter
Code_338D           lda       Addr_001B ; load the value needed by the following operation
                    sta       ,Y+       ; store the value and advance the destination pointer
                    lda       #$06      ; load the value needed by the following operation
                    sta       ,Y+       ; store the value and advance the destination pointer
                    lbsr      Code_347F ; call the referenced helper routine
                    tst       Addr_001D ; set condition flags from the current value
                    bne       Code_33A2 ; branch when the compared values differ
                    sta       ,Y+       ; store the value and advance the destination pointer
                    stb       ,Y+       ; store the value and advance the destination pointer
                    leay      $07,Y     ; form the referenced address without reading memory
Code_33A2           rts                 ; return to the caller
Code_33A3           ldb       Addr_001B ; load the value needed by the following operation
                    stb       ,Y+       ; store the value and advance the destination pointer
                    clrb                ; clear the selected byte or register
                    cmpa      #$2B      ; compare against the limit and set condition flags
                    beq       Code_33B2 ; branch when the compared values are equal
                    cmpa      #$2D      ; compare against the limit and set condition flags
                    bne       Code_33B8 ; branch when the compared values differ
                    ldb       #$40      ; load the value needed by the following operation
Code_33B2           lbsr      Code_3500 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_33EE ; branch when the compared values are equal
Code_33B8           stb       ,Y+       ; store the value and advance the destination pointer
Code_33BA           pshs      Y         ; preserve the listed registers on the stack
                    clr       Addr_004C ; clear the selected byte or register
                    clr       Code_004D ; clear the selected byte or register
                    leay      $0354,U   ; form the referenced address without reading memory
Code_33C4           cmpa      #$2E      ; compare against the limit and set condition flags
                    bne       Code_33D0 ; branch when the compared values differ
                    tst       Code_004D ; set condition flags from the current value
                    bne       Code_33EC ; branch when the compared values differ
                    inc       Code_004D ; advance the selected counter
                    bra       Code_33DE ; continue at the selected control-flow target
Code_33D0           cmpa      #$30      ; compare against the limit and set condition flags
                    blt       Code_33F3 ; branch when the signed value is below the limit
                    cmpa      #$39      ; compare against the limit and set condition flags
                    bgt       Code_33F3 ; branch when the signed value is above the limit
                    tst       Code_004D ; set condition flags from the current value
                    beq       Code_33DE ; branch when the compared values are equal
                    inc       Code_004D ; advance the selected counter
Code_33DE           inc       Addr_004C ; advance the selected counter
                    sta       ,Y+       ; store the value and advance the destination pointer
                    tst       Addr_0012 ; set condition flags from the current value
                    beq       Code_33F7 ; branch when the compared values are equal
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    dec       Addr_0012 ; decrement the selected counter
                    bra       Code_33C4 ; continue at the selected control-flow target
Code_33EC           leas      $02,S     ; form the referenced address without reading memory
Code_33EE           lda       #$01      ; load the value needed by the following operation
                    sta       Addr_001D ; save the current value in working storage
                    rts                 ; return to the caller
Code_33F3           leax      -$01,X    ; form the referenced address without reading memory
                    inc       Addr_0012 ; advance the selected counter
Code_33F7           puls      Y         ; restore the listed registers from the stack
                    lda       Addr_004C ; load the value needed by the following operation
                    beq       Code_33EE ; branch when the compared values are equal
                    suba      Code_004D ; subtract the operand from the running value
                    cmpa      #$0E      ; compare against the limit and set condition flags
                    bgt       Code_33EE ; branch when the signed value is above the limit
                    lda       Code_004D ; load the value needed by the following operation
                    tst       Addr_0017 ; set condition flags from the current value
                    bne       Code_340D ; branch when the compared values differ
                    cmpa      #$01      ; compare against the limit and set condition flags
                    beq       Code_33EE ; branch when the compared values are equal
Code_340D           cmpa      #$05      ; compare against the limit and set condition flags
                    bgt       Code_33EE ; branch when the signed value is above the limit
                    pshs      X         ; preserve the listed registers on the stack
                    tfr       Y,X       ; copy the source register into the destination register
                    ldb       #$09      ; load the value needed by the following operation
                    clra                ; clear the selected byte or register
                    lbsr      Code_10BE ; call the referenced helper routine
                    tfr       X,Y       ; copy the source register into the destination register
                    leay      -$02,Y    ; form the referenced address without reading memory
                    pshs      Y         ; preserve the listed registers on the stack
                    ldb       Addr_004C ; load the value needed by the following operation
                    tst       Code_004D ; set condition flags from the current value
                    beq       Code_3429 ; branch when the compared values are equal
                    subb      Code_004D ; subtract the operand from the running value
Code_3429           tstb                ; set condition flags from the current value
                    beq       Code_3449 ; branch when the compared values are equal
                    leax      $0354,U   ; form the referenced address without reading memory
                    abx                 ; add the operand to the running value
                    lda       ,-X       ; load the value needed by the following operation
                    suba      #$30      ; subtract the operand from the running value
                    decb                ; decrement the selected counter
                    beq       Code_3445 ; branch when the compared values are equal
                    pshs      A         ; preserve the listed registers on the stack
                    lda       ,-X       ; load the value needed by the following operation
                    decb                ; decrement the selected counter
                    suba      #$30      ; subtract the operand from the running value
                    asla                ; shift left and update carry
                    asla                ; shift left and update carry
                    asla                ; shift left and update carry
                    asla                ; shift left and update carry
                    ora       ,S+       ; set the selected flag bits
Code_3445           sta       ,-Y       ; save the current value in working storage
                    bra       Code_3429 ; continue at the selected control-flow target
Code_3449           ldy       ,S        ; load the value needed by the following operation
                    tst       Code_004D ; set condition flags from the current value
                    beq       Code_3478 ; branch when the compared values are equal
                    ldb       Addr_004C ; load the value needed by the following operation
                    subb      Code_004D ; subtract the operand from the running value
                    leax      $0354,U   ; form the referenced address without reading memory
                    incb                ; advance the selected counter
                    abx                 ; add the operand to the running value
                    ldb       Code_004D ; load the value needed by the following operation
                    decb                ; decrement the selected counter
                    beq       Code_3478 ; branch when the compared values are equal
Code_345F           lda       ,X+       ; fetch the next value and advance the source pointer
                    suba      #$30      ; subtract the operand from the running value
                    asla                ; shift left and update carry
                    asla                ; shift left and update carry
                    asla                ; shift left and update carry
                    asla                ; shift left and update carry
                    decb                ; decrement the selected counter
                    beq       Code_3473 ; branch when the compared values are equal
                    pshs      A         ; preserve the listed registers on the stack
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    decb                ; decrement the selected counter
                    suba      #$30      ; subtract the operand from the running value
                    ora       ,S+       ; set the selected flag bits
Code_3473           sta       ,Y+       ; store the value and advance the destination pointer
                    tstb                ; set condition flags from the current value
                    bgt       Code_345F ; branch when the signed value is above the limit
Code_3478           puls      Y         ; restore the listed registers from the stack
                    leay      $02,Y     ; form the referenced address without reading memory
                    puls      X         ; restore the listed registers from the stack
                    rts                 ; return to the caller
Code_347F           clr       Addr_0016 ; clear the selected byte or register
                    lda       Code_001E ; load the value needed by the following operation
                    sta       Addr_004C ; save the current value in working storage
                    ldb       Addr_001F ; load the value needed by the following operation
                    stb       Code_004D ; save the current value in working storage
                    lbsr      Code_3500 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_34F1 ; branch when the compared values are equal
                    cmpa      #$52      ; compare against the limit and set condition flags
                    beq       Code_34A1 ; branch when the compared values are equal
                    cmpa      #$72      ; compare against the limit and set condition flags
                    beq       Code_34A1 ; branch when the compared values are equal
                    cmpa      #$43      ; compare against the limit and set condition flags
                    beq       Code_349F ; branch when the compared values are equal
                    cmpa      #$63      ; compare against the limit and set condition flags
                    bne       Code_34FB ; branch when the compared values differ
Code_349F           inc       Addr_0016 ; advance the selected counter
Code_34A1           lbsr      Code_3500 ; call the referenced helper routine
                    cmpa      #$30      ; compare against the limit and set condition flags
                    blt       Code_34FB ; branch when the signed value is below the limit
                    cmpa      #$39      ; compare against the limit and set condition flags
                    bgt       Code_34FB ; branch when the signed value is above the limit
                    suba      #$30      ; subtract the operand from the running value
                    tfr       A,B       ; copy the source register into the destination register
                    bsr       Code_3500 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_34D9 ; branch when the compared values are equal
                    cmpa      #$30      ; compare against the limit and set condition flags
                    blt       Code_34D5 ; branch when the signed value is below the limit
                    cmpa      #$39      ; compare against the limit and set condition flags
                    bgt       Code_34D5 ; branch when the signed value is above the limit
                    suba      #$30      ; subtract the operand from the running value
                    aslb                ; shift left and update carry
                    pshs      B         ; preserve the listed registers on the stack
                    aslb                ; shift left and update carry
                    aslb                ; shift left and update carry
                    addb      ,S+       ; add the operand to the running value
                    pshs      A         ; preserve the listed registers on the stack
                    addb      ,S+       ; add the operand to the running value
                    bsr       Code_3500 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_34DB ; branch when the compared values are equal
                    leax      -$01,X    ; form the referenced address without reading memory
                    inc       Addr_0012 ; advance the selected counter
                    bra       Code_34DB ; continue at the selected control-flow target
Code_34D5           leax      -$01,X    ; form the referenced address without reading memory
                    inc       Addr_0012 ; advance the selected counter
Code_34D9           inc       Addr_0010 ; advance the selected counter
Code_34DB           tst       Addr_0016 ; set condition flags from the current value
                    bne       Code_34F3 ; branch when the compared values differ
                    stb       Addr_004C ; save the current value in working storage
                    cmpa      #$43      ; compare against the limit and set condition flags
                    beq       Code_34E9 ; branch when the compared values are equal
                    cmpa      #$63      ; compare against the limit and set condition flags
                    bne       Code_34F1 ; branch when the compared values differ
Code_34E9           inc       Addr_0016 ; advance the selected counter
                    leax      $01,X     ; form the referenced address without reading memory
                    dec       Addr_0012 ; decrement the selected counter
                    bra       Code_34A1 ; continue at the selected control-flow target
Code_34F1           ldb       Code_004D ; load the value needed by the following operation
Code_34F3           lda       Addr_004C ; load the value needed by the following operation
                    beq       Code_34FB ; branch when the compared values are equal
                    tstb                ; set condition flags from the current value
                    beq       Code_34FB ; branch when the compared values are equal
                    rts                 ; return to the caller
Code_34FB           lda       #$01      ; load the value needed by the following operation
                    sta       Addr_001D ; save the current value in working storage
                    rts                 ; return to the caller
Code_3500           tst       Addr_0012 ; set condition flags from the current value
                    beq       Code_350E ; branch when the compared values are equal
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bne       Code_3510 ; branch when the compared values differ
                    dec       Addr_0012 ; decrement the selected counter
                    bgt       Code_3500 ; branch when the signed value is above the limit
Code_350E           clra                ; clear the selected byte or register
                    rts                 ; return to the caller
Code_3510           dec       Addr_0012 ; decrement the selected counter
                    sta       Addr_0011 ; save the current value in working storage
                    rts                 ; return to the caller
Code_3515           pshs      Y,X       ; preserve the listed registers on the stack
                    tst       Addr_000F ; set condition flags from the current value
                    bne       Code_3525 ; branch when the compared values differ
                    leax      Data_3612,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    inc       Addr_000F ; advance the selected counter
Code_3525           ldx       #DeskMateService ; load the value needed by the following operation
                    tfr       X,Y       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    leax      Data_3646,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
                    ldx       ,S        ; load the value needed by the following operation
                    ldb       $02,X     ; load the value needed by the following operation
                    andb      #$3F      ; mask off unwanted bits
                    subb      #$0A      ; subtract the operand from the running value
                    cmpb      #$09      ; compare against the limit and set condition flags
                    bge       Code_355E ; branch when the signed value is at least the limit
                    pshs      B         ; preserve the listed registers on the stack
                    leax      $0E,X     ; form the referenced address without reading memory
                    leay      $0354,U   ; form the referenced address without reading memory
                    lbsr      Code_0FB7 ; call the referenced helper routine
                    ldb       #$09      ; load the value needed by the following operation
                    subb      ,S+       ; subtract the operand from the running value
                    lda       #$20      ; load the value needed by the following operation
                    tfr       Y,X       ; copy the source register into the destination register
                    lbsr      Code_10BE ; call the referenced helper routine
                    leax      $0354,U   ; form the referenced address without reading memory
                    bra       Code_3560 ; continue at the selected control-flow target
Code_355E           leax      $0E,X     ; form the referenced address without reading memory
Code_3560           clra                ; clear the selected byte or register
                    ldb       #$09      ; load the value needed by the following operation
                    tfr       D,Y       ; copy the source register into the destination register
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $22       ; private DeskMate service selector
                    leax      $0354,U   ; form the referenced address without reading memory
                    ldd       #Code_2014 ; load the value needed by the following operation
                    lbsr      Code_10BE ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    sta       ,X+       ; store the value and advance the destination pointer
                    ldx       ,S        ; load the value needed by the following operation
                    lda       $0D,X     ; load the value needed by the following operation
                    bne       Code_3582 ; branch when the compared values differ
                    leax      $03,X     ; form the referenced address without reading memory
                    lbsr      Code_0C02 ; call the referenced helper routine
Code_3582           leax      $0354,U   ; form the referenced address without reading memory
                    leay      $1E,X     ; form the referenced address without reading memory
                    ldb       #$15      ; load the value needed by the following operation
                    lbsr      Code_0FB7 ; call the referenced helper routine
Code_358E           leax      $0354,U   ; form the referenced address without reading memory
                    pshs      Y,X       ; preserve the listed registers on the stack
                    ldx       #Addr_0004 ; load the value needed by the following operation
                    ldy       #Addr_0001 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    puls      Y,X       ; restore the listed registers from the stack
                    ldd       #Addr_9400 ; load the value needed by the following operation
                    ldy       #Addr_0F11 ; load the value needed by the following operation
                    lbsr      Code_118E ; call the referenced helper routine
                    cmpa      #$05      ; compare against the limit and set condition flags
                    beq       Code_3600 ; branch when the compared values are equal
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    bne       Code_358E ; branch when the compared values differ
                    ldb       #$14      ; load the value needed by the following operation
                    stb       Addr_0012 ; save the current value in working storage
                    ldy       ,S        ; load the value needed by the following operation
                    leax      $0354,U   ; form the referenced address without reading memory
                    lbsr      Code_3500 ; call the referenced helper routine
                    ldb       #$F7      ; load the value needed by the following operation
                    andb      $03,Y     ; mask off unwanted bits
                    cmpa      #$2B      ; compare against the limit and set condition flags
                    beq       Code_35D1 ; branch when the compared values are equal
                    cmpa      #$2D      ; compare against the limit and set condition flags
                    bne       Code_35D7 ; branch when the compared values differ
                    ldb       #$08      ; load the value needed by the following operation
                    orb       $03,Y     ; set the selected flag bits
Code_35D1           lbsr      Code_3500 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_358E ; branch when the compared values are equal
Code_35D7           clr       Addr_001D ; clear the selected byte or register
                    pshs      B         ; preserve the listed registers on the stack
                    leay      $04,Y     ; form the referenced address without reading memory
                    lbsr      Code_33BA ; call the referenced helper routine
                    puls      B         ; restore the listed registers from the stack
                    tst       Addr_001D ; set condition flags from the current value
                    bne       Code_35EB ; branch when the compared values differ
                    lbsr      Code_3500 ; call the referenced helper routine
                    beq       Code_35F9 ; branch when the compared values are equal
Code_35EB           leay      $0354,U   ; form the referenced address without reading memory
                    leax      $1E,Y     ; form the referenced address without reading memory
                    ldb       #$15      ; load the value needed by the following operation
                    lbsr      Code_0FB7 ; call the referenced helper routine
                    bra       Code_358E ; continue at the selected control-flow target
Code_35F9           ldx       ,S        ; load the value needed by the following operation
                    stb       $03,X     ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    sta       $0D,X     ; save the current value in working storage
Code_3600           puls      PC,Y,X    ; restore the listed registers from the stack
Data_3602           fcc       "("                            ; embedded text or resource bytes
                    fcb       $04,$0F,$1C,$05,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $18       ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $04,$0F   ; table, bitmap, or initialized data bytes
                    fcc       ":"                            ; embedded text or resource bytes
                    fcb       $04,$00   ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $18       ; table, bitmap, or initialized data bytes
Data_3612           fcb       $00,$04,$0E ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $04,$00   ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $18       ; table, bitmap, or initialized data bytes
Data_361A           fcc       "Enter/Edit Formula"           ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_362D           fcc       "Incorrect Formula. Re"        ; embedded text or resource bytes
                    fcc       "do."                          ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_3646           fcc       "Enter/Edit Value for "        ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_365C           clr       Addr_001A ; clear the selected byte or register
                    lda       #$63      ; load the value needed by the following operation
                    sta       Code_001E ; save the current value in working storage
                    sta       Addr_001F ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    sta       Addr_0020 ; save the current value in working storage
                    sta       Addr_0021 ; save the current value in working storage
                    clr       Addr_000F ; clear the selected byte or register
                    leax      $018D,U   ; form the referenced address without reading memory
                    tfr       X,Y       ; copy the source register into the destination register
                    ldb       #$64      ; load the value needed by the following operation
                    clra                ; clear the selected byte or register
                    lbsr      Code_10BE ; call the referenced helper routine
                    ldx       Addr_0002 ; load the value needed by the following operation
Code_3679           lda       ,X        ; load the value needed by the following operation
                    blt       Code_36BD ; branch when the signed value is below the limit
                    ldb       $02,X     ; load the value needed by the following operation
                    bpl       Code_36B7 ; branch while the tested value is nonnegative
                    ldb       $0D,X     ; load the value needed by the following operation
                    cmpb      #$03      ; compare against the limit and set condition flags
                    beq       Code_369B ; branch when the compared values are equal
                    ldb       #$0E      ; load the value needed by the following operation
Code_3689           lda       B,X       ; load the value needed by the following operation
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bne       Code_3692 ; branch when the compared values differ
                    incb                ; advance the selected counter
                    bra       Code_3689 ; continue at the selected control-flow target
Code_3692           cmpa      #$3F      ; compare against the limit and set condition flags
                    bne       Code_369B ; branch when the compared values differ
                    lbsr      Code_3515 ; call the referenced helper routine
                    bra       Code_36B7 ; continue at the selected control-flow target
Code_369B           ldd       ,X        ; load the value needed by the following operation
                    inc       A,Y       ; advance the selected counter
                    cmpa      Code_001E ; compare against the limit and set condition flags
                    bge       Code_36A5 ; branch when the signed value is at least the limit
                    sta       Code_001E ; save the current value in working storage
Code_36A5           cmpa      Addr_0020 ; compare against the limit and set condition flags
                    ble       Code_36AB ; branch when the signed value is at or below the limit
                    sta       Addr_0020 ; save the current value in working storage
Code_36AB           cmpb      Addr_001F ; compare against the limit and set condition flags
                    bge       Code_36B1 ; branch when the signed value is at least the limit
                    stb       Addr_001F ; save the current value in working storage
Code_36B1           cmpb      Addr_0021 ; compare against the limit and set condition flags
                    ble       Code_36B7 ; branch when the signed value is at or below the limit
                    stb       Addr_0021 ; save the current value in working storage
Code_36B7           lbsr      Code_0FB0 ; call the referenced helper routine
                    abx                 ; add the operand to the running value
                    bra       Code_3679 ; continue at the selected control-flow target
Code_36BD           clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    sta       Addr_000F ; save the current value in working storage
                    lda       Code_001E ; load the value needed by the following operation
                    cmpa      Addr_0020 ; compare against the limit and set condition flags
                    ble       Code_36D0 ; branch when the signed value is at or below the limit
                    clr       Addr_001F ; clear the selected byte or register
                    leas      $02,S     ; form the referenced address without reading memory
                    bra       Code_372F ; continue at the selected control-flow target
Code_36D0           leay      A,Y       ; form the referenced address without reading memory
                    bsr       Code_3738 ; call the referenced helper routine
                    lda       Addr_001F ; load the value needed by the following operation
                    pshs      A         ; preserve the listed registers on the stack
Code_36D8           lda       Code_001E ; load the value needed by the following operation
                    ldb       Addr_001F ; load the value needed by the following operation
                    lbsr      Code_0F2F ; call the referenced helper routine
                    leax      ,X        ; form the referenced address without reading memory
                    beq       Code_370F ; branch when the compared values are equal
                    lda       $02,X     ; load the value needed by the following operation
                    tfr       A,B       ; copy the source register into the destination register
                    anda      #$C0      ; mask off unwanted bits
                    cmpa      #$80      ; compare against the limit and set condition flags
                    bne       Code_370F ; branch when the compared values differ
                    lda       $0D,X     ; load the value needed by the following operation
                    cmpa      #$03      ; compare against the limit and set condition flags
                    beq       Code_3709 ; branch when the compared values are equal
                    andb      #$3F      ; mask off unwanted bits
                    subb      #$0A      ; subtract the operand from the running value
                    stb       Addr_0012 ; save the current value in working storage
                    pshs      Y,X       ; preserve the listed registers on the stack
                    leax      $0E,X     ; form the referenced address without reading memory
                    lbsr      Code_3198 ; call the referenced helper routine
                    puls      Y,X       ; restore the listed registers from the stack
                    cmpa      #$02      ; compare against the limit and set condition flags
                    beq       Code_370F ; branch when the compared values are equal
                    lbsr      Code_37A4 ; call the referenced helper routine
Code_3709           dec       ,Y        ; decrement the selected counter
                    beq       Code_3717 ; branch when the compared values are equal
                    bsr       Code_3768 ; call the referenced helper routine
Code_370F           inc       Addr_001F ; advance the selected counter
                    lda       Addr_001F ; load the value needed by the following operation
                    cmpa      Addr_0021 ; compare against the limit and set condition flags
                    ble       Code_36D8 ; branch when the signed value is at or below the limit
Code_3717           inc       Code_001E ; advance the selected counter
                    lda       Code_001E ; load the value needed by the following operation
                    cmpa      Addr_0020 ; compare against the limit and set condition flags
                    bgt       Code_372B ; branch when the signed value is above the limit
                    leay      $01,Y     ; form the referenced address without reading memory
                    lda       ,Y        ; load the value needed by the following operation
                    beq       Code_3717 ; branch when the compared values are equal
                    lda       ,S        ; load the value needed by the following operation
                    sta       Addr_001F ; save the current value in working storage
                    bra       Code_36D8 ; continue at the selected control-flow target
Code_372B           leas      $01,S     ; form the referenced address without reading memory
                    bsr       Code_374F ; call the referenced helper routine
Code_372F           lbsr      Code_094E ; call the referenced helper routine
                    lbsr      Code_11C9 ; call the referenced helper routine
                    lda       #$01      ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_3738           pshs      X,D       ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    leax      Data_3B1A,PCR ; form the referenced address without reading memory
                    ldd       #Addr_0147 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    puls      PC,X,D    ; restore the listed registers from the stack
Code_374F           pshs      X,D       ; preserve the listed registers on the stack
                    leax      Data_0673,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    ldd       #Addr_0147 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    clr       Addr_003C ; clear the selected byte or register
                    puls      PC,X,D    ; restore the listed registers from the stack
Code_3768           pshs      X,D       ; preserve the listed registers on the stack
                    inc       Addr_003C ; advance the selected counter
                    lda       Addr_003C ; load the value needed by the following operation
                    anda      #$0F      ; mask off unwanted bits
                    bne       Code_37A2 ; branch when the compared values differ
                    leax      Data_3B1A,PCR ; form the referenced address without reading memory
                    lda       Addr_003C ; load the value needed by the following operation
                    anda      #$C0      ; mask off unwanted bits
                    beq       Code_3788 ; branch when the compared values are equal
                    cmpa      #$80      ; compare against the limit and set condition flags
                    beq       Code_3790 ; branch when the compared values are equal
                    lda       #$80      ; load the value needed by the following operation
                    leax      Data_3BB6,PCR ; form the referenced address without reading memory
                    bra       Code_3791 ; continue at the selected control-flow target
Code_3788           lda       #$40      ; load the value needed by the following operation
                    leax      Data_3B68,PCR ; form the referenced address without reading memory
                    bra       Code_3791 ; continue at the selected control-flow target
Code_3790           clra                ; clear the selected byte or register
Code_3791           sta       Addr_003C ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    ldd       #Addr_0147 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
Code_37A2           puls      PC,X,D    ; restore the listed registers from the stack
Code_37A4           pshs      Y,X,D     ; preserve the listed registers on the stack
                    clr       Addr_001D ; clear the selected byte or register
Code_37A8           leax      $01F1,U   ; form the referenced address without reading memory
                    leay      Data_3B0A,PCR ; form the referenced address without reading memory
Code_37B0           lda       ,X        ; load the value needed by the following operation
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    beq       Code_37FD ; branch when the compared values are equal
                    tsta                ; set condition flags from the current value
                    bpl       Code_37C0 ; branch while the tested value is nonnegative
                    tfr       A,B       ; copy the source register into the destination register
                    andb      #$3F      ; mask off unwanted bits
                    abx                 ; add the operand to the running value
                    bra       Code_37B0 ; continue at the selected control-flow target
Code_37C0           cmpa      Code_001C ; compare against the limit and set condition flags
                    bne       Code_37F4 ; branch when the compared values differ
                    stx       Code_0022 ; save the current value in working storage
                    ldb       $01,X     ; load the value needed by the following operation
                    andb      #$3F      ; mask off unwanted bits
                    ldb       B,Y       ; load the value needed by the following operation
                    abx                 ; add the operand to the running value
Code_37CD           lda       ,X        ; load the value needed by the following operation
                    cmpa      #$FF      ; compare against the limit and set condition flags
                    beq       Code_37E8 ; branch when the compared values are equal
                    bmi       Code_37E2 ; branch while the tested value is negative
                    cmpa      Code_001C ; compare against the limit and set condition flags
                    bne       Code_37E8 ; branch when the compared values differ
                    ldb       $01,X     ; load the value needed by the following operation
                    andb      #$3F      ; mask off unwanted bits
                    ldb       B,Y       ; load the value needed by the following operation
                    abx                 ; add the operand to the running value
                    bra       Code_37CD ; continue at the selected control-flow target
Code_37E2           anda      #$3F      ; mask off unwanted bits
                    leax      A,X       ; form the referenced address without reading memory
                    bra       Code_37CD ; continue at the selected control-flow target
Code_37E8           stx       Addr_0024 ; save the current value in working storage
                    bsr       Code_3848 ; call the referenced helper routine
                    tst       Addr_001D ; set condition flags from the current value
                    bne       Code_3805 ; branch when the compared values differ
                    ldx       Addr_0024 ; load the value needed by the following operation
                    bra       Code_37B0 ; continue at the selected control-flow target
Code_37F4           ldb       $01,X     ; load the value needed by the following operation
                    andb      #$3F      ; mask off unwanted bits
                    ldb       B,Y       ; load the value needed by the following operation
                    abx                 ; add the operand to the running value
                    bra       Code_37B0 ; continue at the selected control-flow target
Code_37FD           dec       Code_001C ; decrement the selected counter
                    bgt       Code_37A8 ; branch when the signed value is above the limit
                    tst       Addr_001D ; set condition flags from the current value
                    beq       Code_3812 ; branch when the compared values are equal
Code_3805           puls      Y,X,D     ; restore the listed registers from the stack
                    lda       Addr_001D ; load the value needed by the following operation
                    cmpa      #$02      ; compare against the limit and set condition flags
                    blt       Code_380F ; branch when the signed value is below the limit
                    lda       #$04      ; load the value needed by the following operation
Code_380F           sta       $0D,X     ; save the current value in working storage
                    rts                 ; return to the caller
Code_3812           puls      X,D       ; restore the listed registers from the stack
Code_3814           leay      $01F1,U   ; form the referenced address without reading memory
Code_3818           lda       ,Y        ; load the value needed by the following operation
                    beq       Code_3822 ; branch when the compared values are equal
                    anda      #$3F      ; mask off unwanted bits
                    leay      A,Y       ; form the referenced address without reading memory
                    bra       Code_3818 ; continue at the selected control-flow target
Code_3822           leay      $02,Y     ; form the referenced address without reading memory
                    leax      $04,X     ; form the referenced address without reading memory
                    clra                ; clear the selected byte or register
                    sta       $09,X     ; save the current value in working storage
                    lda       -$01,Y    ; load the value needed by the following operation
                    anda      #$40      ; mask off unwanted bits
                    beq       Code_3837 ; branch when the compared values are equal
                    lda       -$01,X    ; load the value needed by the following operation
                    ora       #$08      ; set the selected flag bits
                    sta       -$01,X    ; save the current value in working storage
                    bra       Code_383D ; continue at the selected control-flow target
Code_3837           lda       -$01,X    ; load the value needed by the following operation
                    anda      #$F7      ; mask off unwanted bits
                    sta       -$01,X    ; save the current value in working storage
Code_383D           ldb       #$09      ; load the value needed by the following operation
Code_383F           lda       ,Y+       ; fetch the next value and advance the source pointer
                    sta       ,X+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bgt       Code_383F ; branch when the signed value is above the limit
                    puls      PC,Y      ; restore the listed registers from the stack
Code_3848           pshs      Y,X,D     ; preserve the listed registers on the stack
                    lda       #$07      ; load the value needed by the following operation
                    sta       Code_0026 ; save the current value in working storage
Code_384E           ldx       Code_0022 ; load the value needed by the following operation
Code_3850           cmpx      Addr_0024 ; compare against the limit and set condition flags
                    beq       Code_389B ; branch when the compared values are equal
                    ldd       ,X        ; load the value needed by the following operation
                    bpl       Code_385F ; branch while the tested value is nonnegative
                    tfr       A,B       ; copy the source register into the destination register
                    andb      #$3F      ; mask off unwanted bits
                    abx                 ; add the operand to the running value
                    bra       Code_3850 ; continue at the selected control-flow target
Code_385F           andb      #$3F      ; mask off unwanted bits
                    cmpb      Code_0026 ; compare against the limit and set condition flags
                    blt       Code_3891 ; branch when the signed value is below the limit
                    pshs      B         ; preserve the listed registers on the stack
                    tfr       B,A       ; copy the source register into the destination register
                    cmpb      #$06      ; compare against the limit and set condition flags
                    blt       Code_3878 ; branch when the signed value is below the limit
                    beq       Code_387C ; branch when the compared values are equal
                    cmpb      #$0B      ; compare against the limit and set condition flags
                    bge       Code_3881 ; branch when the signed value is at least the limit
                    lbsr      Code_39AD ; call the referenced helper routine
                    bra       Code_3884 ; continue at the selected control-flow target
Code_3878           bsr       Code_38C6 ; call the referenced helper routine
                    bra       Code_3884 ; continue at the selected control-flow target
Code_387C           lbsr      Code_3962 ; call the referenced helper routine
                    bra       Code_3884 ; continue at the selected control-flow target
Code_3881           lbsr      Code_3AB6 ; call the referenced helper routine
Code_3884           puls      A         ; restore the listed registers from the stack
                    tst       Addr_001D ; set condition flags from the current value
                    bne       Code_388F ; branch when the compared values differ
                    ldb       A,Y       ; load the value needed by the following operation
                    abx                 ; add the operand to the running value
                    bra       Code_3850 ; continue at the selected control-flow target
Code_388F           puls      PC,Y,X,D  ; restore the listed registers from the stack
Code_3891           tstb                ; set condition flags from the current value
                    bne       Code_3896 ; branch when the compared values differ
                    stx       Addr_0027 ; save the current value in working storage
Code_3896           ldb       B,Y       ; load the value needed by the following operation
                    abx                 ; add the operand to the running value
                    bra       Code_3850 ; continue at the selected control-flow target
Code_389B           lda       Code_0026 ; load the value needed by the following operation
                    cmpa      #$06      ; compare against the limit and set condition flags
                    blt       Code_38A4 ; branch when the signed value is below the limit
                    deca                ; decrement the selected counter
                    bra       Code_38A6 ; continue at the selected control-flow target
Code_38A4           suba      #$02      ; subtract the operand from the running value
Code_38A6           sta       Code_0026 ; save the current value in working storage
                    bgt       Code_384E ; branch when the signed value is above the limit
                    ldx       Code_0022 ; load the value needed by the following operation
Code_38AC           cmpx      Addr_0024 ; compare against the limit and set condition flags
                    beq       Code_38C4 ; branch when the compared values are equal
                    ldd       ,X        ; load the value needed by the following operation
                    bmi       Code_38BE ; branch while the tested value is negative
                    deca                ; decrement the selected counter
                    sta       ,X        ; save the current value in working storage
                    andb      #$3F      ; mask off unwanted bits
                    ldb       B,Y       ; load the value needed by the following operation
                    abx                 ; add the operand to the running value
                    bra       Code_38AC ; continue at the selected control-flow target
Code_38BE           anda      #$3F      ; mask off unwanted bits
                    leax      A,X       ; form the referenced address without reading memory
                    bra       Code_38AC ; continue at the selected control-flow target
Code_38C4           puls      PC,Y,X,D  ; restore the listed registers from the stack
Code_38C6           pshs      Y,X,A     ; preserve the listed registers on the stack
                    lda       #$02      ; load the value needed by the following operation
                    ora       #$80      ; set the selected flag bits
                    sta       ,X+       ; store the value and advance the destination pointer
                    leax      $01,X     ; form the referenced address without reading memory
Code_38D0           ldd       ,X        ; load the value needed by the following operation
                    bpl       Code_38DA ; branch while the tested value is nonnegative
                    anda      #$3F      ; mask off unwanted bits
                    leax      A,X       ; form the referenced address without reading memory
                    bra       Code_38D0 ; continue at the selected control-flow target
Code_38DA           andb      #$3F      ; mask off unwanted bits
                    lbne      Code_395C ; take the distant branch when values differ
                    pshs      U         ; preserve the listed registers on the stack
                    leay      $0368,U   ; form the referenced address without reading memory
                    ldb       $01,X     ; load the value needed by the following operation
                    andb      #$40      ; mask off unwanted bits
                    stb       ,Y+       ; store the value and advance the destination pointer
                    pshs      X         ; preserve the listed registers on the stack
                    leax      $02,X     ; form the referenced address without reading memory
                    ldb       #$09      ; load the value needed by the following operation
                    lbsr      Code_0FB7 ; call the referenced helper routine
                    leay      $035E,U   ; form the referenced address without reading memory
                    ldx       Addr_0027 ; load the value needed by the following operation
                    ldb       $01,X     ; load the value needed by the following operation
                    andb      #$40      ; mask off unwanted bits
                    stb       ,Y+       ; store the value and advance the destination pointer
                    leax      $02,X     ; form the referenced address without reading memory
                    ldb       #$09      ; load the value needed by the following operation
                    lbsr      Code_0FB7 ; call the referenced helper routine
                    puls      Y         ; restore the listed registers from the stack
                    ldb       #$0B      ; load the value needed by the following operation
                    orb       #$80      ; set the selected flag bits
                    stb       ,Y        ; save the current value in working storage
                    leau      $0354,U   ; form the referenced address without reading memory
                    leax      $0A,U     ; form the referenced address without reading memory
                    leay      $14,U     ; form the referenced address without reading memory
                    lda       $02,S     ; load the value needed by the following operation
                    cmpa      #$02      ; compare against the limit and set condition flags
                    blt       Code_392C ; branch when the signed value is below the limit
                    beq       Code_3931 ; branch when the compared values are equal
                    cmpa      #$04      ; compare against the limit and set condition flags
                    blt       Code_3936 ; branch when the signed value is below the limit
                    beq       Code_393B ; branch when the compared values are equal
                    lbsr      Code_3E8E ; call the referenced helper routine
                    bra       Code_393E ; continue at the selected control-flow target
Code_392C           lbsr      Code_3CA6 ; call the referenced helper routine
                    bra       Code_3944 ; continue at the selected control-flow target
Code_3931           lbsr      Code_3CC6 ; call the referenced helper routine
                    bra       Code_3944 ; continue at the selected control-flow target
Code_3936           lbsr      Code_3CDA ; call the referenced helper routine
                    bra       Code_3944 ; continue at the selected control-flow target
Code_393B           lbsr      Code_3DEA ; call the referenced helper routine
Code_393E           puls      U         ; restore the listed registers from the stack
                    bcs       Code_395E ; branch when carry reports an unsigned underflow or error
                    bra       Code_3948 ; continue at the selected control-flow target
Code_3944           puls      U         ; restore the listed registers from the stack
                    bcs       Code_395C ; branch when carry reports an unsigned underflow or error
Code_3948           leax      $0354,U   ; form the referenced address without reading memory
                    ldb       ,X+       ; fetch the next value and advance the source pointer
                    ldy       Addr_0027 ; load the value needed by the following operation
                    leay      $01,Y     ; form the referenced address without reading memory
                    stb       ,Y+       ; store the value and advance the destination pointer
                    ldb       #$09      ; load the value needed by the following operation
                    lbsr      Code_0FB7 ; call the referenced helper routine
                    puls      PC,Y,X,A  ; restore the listed registers from the stack
Code_395C           lda       #$02      ; load the value needed by the following operation
Code_395E           sta       Addr_001D ; save the current value in working storage
                    puls      PC,Y,X,A  ; restore the listed registers from the stack
Code_3962           pshs      Y,X       ; preserve the listed registers on the stack
                    ldd       $02,X     ; load the value needed by the following operation
                    lbsr      Code_0F2F ; call the referenced helper routine
                    leax      ,X        ; form the referenced address without reading memory
                    beq       Code_399E ; branch when the compared values are equal
                    lda       $02,X     ; load the value needed by the following operation
                    anda      #$C0      ; mask off unwanted bits
                    beq       Code_3998 ; branch when the compared values are equal
                    cmpa      #$40      ; compare against the limit and set condition flags
                    beq       Code_397B ; branch when the compared values are equal
                    lda       $0D,X     ; load the value needed by the following operation
                    bne       Code_3998 ; branch when the compared values differ
Code_397B           ldy       ,S        ; load the value needed by the following operation
                    leay      $01,Y     ; form the referenced address without reading memory
                    lda       $03,X     ; load the value needed by the following operation
                    anda      #$08      ; mask off unwanted bits
                    beq       Code_398C ; branch when the compared values are equal
                    lda       #$40      ; load the value needed by the following operation
                    sta       ,Y+       ; store the value and advance the destination pointer
                    bra       Code_398F ; continue at the selected control-flow target
Code_398C           clra                ; clear the selected byte or register
                    sta       ,Y+       ; store the value and advance the destination pointer
Code_398F           ldb       #$09      ; load the value needed by the following operation
                    leax      $04,X     ; form the referenced address without reading memory
                    lbsr      Code_0FB7 ; call the referenced helper routine
                    puls      PC,Y,X    ; restore the listed registers from the stack
Code_3998           lda       #$01      ; load the value needed by the following operation
                    sta       Addr_001D ; save the current value in working storage
                    puls      PC,Y,X    ; restore the listed registers from the stack
Code_399E           ldd       #Addr_000A ; load the value needed by the following operation
                    ldy       ,S        ; load the value needed by the following operation
                    leay      $01,Y     ; form the referenced address without reading memory
Code_39A6           sta       ,Y+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bgt       Code_39A6 ; branch when the signed value is above the limit
                    puls      PC,Y,X    ; restore the listed registers from the stack
Code_39AD           pshs      Y,X,A     ; preserve the listed registers on the stack
                    tfr       X,Y       ; copy the source register into the destination register
                    leay      $02,Y     ; form the referenced address without reading memory
                    leax      $035E,U   ; form the referenced address without reading memory
                    clrb                ; clear the selected byte or register
                    stb       ,X+       ; store the value and advance the destination pointer
                    ldb       #$09      ; load the value needed by the following operation
                    cmpa      #$08      ; compare against the limit and set condition flags
                    bne       Code_39C4 ; branch when the compared values differ
                    lda       #$99      ; load the value needed by the following operation
                    bra       Code_39C5 ; continue at the selected control-flow target
Code_39C4           clra                ; clear the selected byte or register
Code_39C5           lbsr      Code_10BE ; call the referenced helper routine
                    clr       Addr_0010 ; clear the selected byte or register
                    lda       #$01      ; load the value needed by the following operation
                    sta       Addr_001D ; save the current value in working storage
                    ldx       Addr_0002 ; load the value needed by the following operation
Code_39D0           ldd       ,X        ; load the value needed by the following operation
                    bmi       Code_39EA ; branch while the tested value is negative
                    cmpa      ,Y        ; compare against the limit and set condition flags
                    blt       Code_39E4 ; branch when the signed value is below the limit
                    cmpb      $01,Y     ; compare against the limit and set condition flags
                    blt       Code_39E4 ; branch when the signed value is below the limit
                    cmpa      $02,Y     ; compare against the limit and set condition flags
                    bgt       Code_39E4 ; branch when the signed value is above the limit
                    cmpb      $03,Y     ; compare against the limit and set condition flags
                    ble       Code_39EC ; branch when the signed value is at or below the limit
Code_39E4           lbra      Code_3A5E ; continue at the distant control-flow target
Code_39E7           lbra      Code_3AB0 ; continue at the distant control-flow target
Code_39EA           bra       Code_3A65 ; continue at the selected control-flow target
Code_39EC           lda       $02,X     ; load the value needed by the following operation
                    anda      #$C0      ; mask off unwanted bits
                    beq       Code_39E4 ; branch when the compared values are equal
                    cmpa      #$40      ; compare against the limit and set condition flags
                    beq       Code_39FA ; branch when the compared values are equal
                    lda       $0D,X     ; load the value needed by the following operation
                    bne       Code_39E7 ; branch when the compared values differ
Code_39FA           pshs      Y,X       ; preserve the listed registers on the stack
                    leay      $0368,U   ; form the referenced address without reading memory
                    clra                ; clear the selected byte or register
                    ldb       $03,X     ; load the value needed by the following operation
                    andb      #$08      ; mask off unwanted bits
                    beq       Code_3A09 ; branch when the compared values are equal
                    lda       #$40      ; load the value needed by the following operation
Code_3A09           sta       ,Y+       ; store the value and advance the destination pointer
                    leax      $04,X     ; form the referenced address without reading memory
                    ldb       #$09      ; load the value needed by the following operation
                    lbsr      Code_0FB7 ; call the referenced helper routine
                    lda       Addr_0010 ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    daa                 ; adjust the accumulator to packed decimal
                    sta       Addr_0010 ; save the current value in working storage
                    lda       $04,S     ; load the value needed by the following operation
                    pshs      U,A       ; preserve the listed registers on the stack
                    leau      $0354,U   ; form the referenced address without reading memory
                    leax      $0A,U     ; form the referenced address without reading memory
                    leay      $14,U     ; form the referenced address without reading memory
                    cmpa      #$07      ; compare against the limit and set condition flags
                    beq       Code_3A2D ; branch when the compared values are equal
                    cmpa      #$0A      ; compare against the limit and set condition flags
                    blt       Code_3A3A ; branch when the signed value is below the limit
Code_3A2D           lbsr      Code_3CA6 ; call the referenced helper routine
                    puls      U,A       ; restore the listed registers from the stack
                    bcs       Code_3AAA ; branch when carry reports an unsigned underflow or error
                    leax      $0354,U   ; form the referenced address without reading memory
                    bra       Code_3A51 ; continue at the selected control-flow target
Code_3A3A           lbsr      Code_3C04 ; call the referenced helper routine
                    puls      U,A       ; restore the listed registers from the stack
                    beq       Code_3A5A ; branch when the compared values are equal
                    bcs       Code_3A49 ; branch when carry reports an unsigned underflow or error
                    cmpa      #$09      ; compare against the limit and set condition flags
                    beq       Code_3A5A ; branch when the compared values are equal
                    bra       Code_3A4D ; continue at the selected control-flow target
Code_3A49           cmpa      #$08      ; compare against the limit and set condition flags
                    beq       Code_3A5A ; branch when the compared values are equal
Code_3A4D           leax      $0368,U   ; form the referenced address without reading memory
Code_3A51           leay      $035E,U   ; form the referenced address without reading memory
                    ldb       #$0A      ; load the value needed by the following operation
                    lbsr      Code_0FB7 ; call the referenced helper routine
Code_3A5A           clr       Addr_001D ; clear the selected byte or register
                    puls      Y,X       ; restore the listed registers from the stack
Code_3A5E           lbsr      Code_0FB0 ; call the referenced helper routine
                    abx                 ; add the operand to the running value
                    lbra      Code_39D0 ; continue at the distant control-flow target
Code_3A65           lda       ,S        ; load the value needed by the following operation
                    cmpa      #$0A      ; compare against the limit and set condition flags
                    bne       Code_3A91 ; branch when the compared values differ
                    clra                ; clear the selected byte or register
                    leax      $0368,U   ; form the referenced address without reading memory
                    ldb       #$0A      ; load the value needed by the following operation
                    lbsr      Code_10BE ; call the referenced helper routine
                    lda       Addr_0010 ; load the value needed by the following operation
                    sta       -$03,X    ; save the current value in working storage
                    pshs      U         ; preserve the listed registers on the stack
                    leau      $0354,U   ; form the referenced address without reading memory
                    leax      $0A,U     ; form the referenced address without reading memory
                    leay      $14,U     ; form the referenced address without reading memory
                    lbsr      Code_3DEA ; call the referenced helper routine
                    puls      U         ; restore the listed registers from the stack
                    bcs       Code_3AB2 ; branch when carry reports an unsigned underflow or error
                    leax      $0354,U   ; form the referenced address without reading memory
                    bra       Code_3A95 ; continue at the selected control-flow target
Code_3A91           leax      $035E,U   ; form the referenced address without reading memory
Code_3A95           tst       Addr_001D ; set condition flags from the current value
                    bne       Code_3AB0 ; branch when the compared values differ
                    ldy       $01,S     ; load the value needed by the following operation
                    ldb       ,X+       ; fetch the next value and advance the source pointer
                    stb       $01,Y     ; save the current value in working storage
                    leay      $02,Y     ; form the referenced address without reading memory
                    ldb       #$09      ; load the value needed by the following operation
                    lbsr      Code_0FB7 ; call the referenced helper routine
                    puls      Y,X,A     ; restore the listed registers from the stack
                    rts                 ; return to the caller
Code_3AAA           leas      $04,S     ; form the referenced address without reading memory
                    lda       #$02      ; load the value needed by the following operation
                    bra       Code_3AB2 ; continue at the selected control-flow target
Code_3AB0           lda       #$01      ; load the value needed by the following operation
Code_3AB2           sta       Addr_001D ; save the current value in working storage
                    puls      PC,Y,X,A  ; restore the listed registers from the stack
Code_3AB6           pshs      Y,X,A     ; preserve the listed registers on the stack
                    lda       #$02      ; load the value needed by the following operation
                    ora       #$80      ; set the selected flag bits
                    sta       ,X+       ; store the value and advance the destination pointer
                    leax      $01,X     ; form the referenced address without reading memory
Code_3AC0           ldd       ,X        ; load the value needed by the following operation
                    bpl       Code_3ACA ; branch while the tested value is nonnegative
                    anda      #$3F      ; mask off unwanted bits
                    leax      A,X       ; form the referenced address without reading memory
                    bra       Code_3AC0 ; continue at the selected control-flow target
Code_3ACA           andb      #$3F      ; mask off unwanted bits
                    bne       Code_3B04 ; branch when the compared values differ
                    puls      A         ; restore the listed registers from the stack
                    cmpa      #$0C      ; compare against the limit and set condition flags
                    blt       Code_3AEB ; branch when the signed value is below the limit
                    beq       Code_3AF0 ; branch when the compared values are equal
                    cmpa      #$0E      ; compare against the limit and set condition flags
                    blt       Code_3AE1 ; branch when the signed value is below the limit
                    beq       Code_3AE6 ; branch when the compared values are equal
                    lbsr      Code_4294 ; call the referenced helper routine
                    puls      PC,Y,X    ; restore the listed registers from the stack
Code_3AE1           lbsr      Code_3F5D ; call the referenced helper routine
                    puls      PC,Y,X    ; restore the listed registers from the stack
Code_3AE6           lbsr      Code_4248 ; call the referenced helper routine
                    puls      PC,Y,X    ; restore the listed registers from the stack
Code_3AEB           clra                ; clear the selected byte or register
                    sta       $01,X     ; save the current value in working storage
                    puls      PC,Y,X    ; restore the listed registers from the stack
Code_3AF0           pshs      X         ; preserve the listed registers on the stack
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    std       $09,X     ; save the current value in working storage
                    leax      $01,X     ; form the referenced address without reading memory
                    lbsr      Code_3C88 ; call the referenced helper routine
                    puls      X         ; restore the listed registers from the stack
                    bne       Code_3B02 ; branch when the compared values differ
                    clra                ; clear the selected byte or register
                    sta       $01,X     ; save the current value in working storage
Code_3B02           puls      PC,Y,X    ; restore the listed registers from the stack
Code_3B04           lda       #$01      ; load the value needed by the following operation
                    sta       Addr_001D ; save the current value in working storage
                    puls      PC,Y,X,A  ; restore the listed registers from the stack
Data_3B0A           fcb       $0B,$02,$02,$02,$02,$02 ; table, bitmap, or initialized data bytes
                    fcb       $0B,$0B,$0B,$0B,$0B,$02 ; table, bitmap, or initialized data bytes
                    fcb       $02,$02,$02,$02 ; table, bitmap, or initialized data bytes
Data_3B1A           fcc       "("                            ; embedded text or resource bytes
                    fcb       $04,$0C,$AA,$AA,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC,$AA,$A3,$FF ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $CA,$8F,$FF ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $F2       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FF,$00,$0C ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FF,$FF,$FC,$8F,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $F2,$A3,$FF,$FF,$CA,$AA ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC,$AA,$AA,$AA,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$AA,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $02,$0C,$AA,$AA,$A8 ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $A3,$CA,$8E,$F2,$9E,$F9 ; table, bitmap, or initialized data bytes
                    fcc       ">"                            ; embedded text or resource bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       ">"                            ; embedded text or resource bytes
                    fcb       $1C       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC,$9F,$FD,$8F,$F2,$A3 ; table, bitmap, or initialized data bytes
                    fcb       $CA,$A8   ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
Data_3B68           fcc       "("                            ; embedded text or resource bytes
                    fcb       $04,$0C,$AA,$AA,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC,$AA,$A3,$FF,$FF,$CA ; table, bitmap, or initialized data bytes
                    fcb       $8F,$FF,$FF,$F2 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FF,$FF,$FC ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FF,$00,$0C ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FF,$CF,$FC,$8F,$FF,$F3 ; table, bitmap, or initialized data bytes
                    fcb       $F2,$A3,$FF,$FC,$CA,$AA ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC,$AA,$AA,$AA,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$AA,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $02,$0C,$AA,$AA,$A8 ; table, bitmap, or initialized data bytes
                    fcc       "+"                            ; embedded text or resource bytes
                    fcb       $A3,$CA,$8F,$F3,$9F,$F9 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FD       ; table, bitmap, or initialized data bytes
                    fcc       ">"                            ; embedded text or resource bytes
                    fcb       $1C       ; table, bitmap, or initialized data bytes
                    fcc       "?}"                           ; embedded text or resource bytes
                    fcb       $9F,$9D,$8F,$F3,$A3,$CA ; table, bitmap, or initialized data bytes
                    fcb       $A8       ; table, bitmap, or initialized data bytes
                    fcc       "+"                            ; embedded text or resource bytes
Data_3BB6           fcc       "("                            ; embedded text or resource bytes
                    fcb       $04,$0C,$AA,$AA,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC,$AA,$A3,$CF,$FF,$CA ; table, bitmap, or initialized data bytes
                    fcb       $8F,$F3,$FF,$F2 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC,$FF,$FC ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FF,$00,$0C ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FF,$FF,$FC,$8F,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $F2,$A3,$FF,$FF,$CA,$AA ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FC,$AA,$AA,$AA,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcb       $AA,$AA,$AA,$AA ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $02,$0C,$AA,$AA,$A8 ; table, bitmap, or initialized data bytes
                    fcc       "+"                            ; embedded text or resource bytes
                    fcb       $A3,$CA,$8F,$F3,$9F,$F9 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FD       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $1C       ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $FD,$9F,$FD,$8F,$F3,$A3 ; table, bitmap, or initialized data bytes
                    fcb       $CA,$A8   ; table, bitmap, or initialized data bytes
                    fcc       "+"                            ; embedded text or resource bytes
Code_3C04           lda       ,X        ; load the value needed by the following operation
                    cmpa      ,Y        ; compare against the limit and set condition flags
                    beq       Code_3C14 ; branch when the compared values are equal
                    cmpa      #$40      ; compare against the limit and set condition flags
                    bne       Code_3C11 ; branch when the compared values differ
Code_3C0E           orcc      #$01      ; set the selected flag bits
                    rts                 ; return to the caller
Code_3C11           andcc     #$FE      ; mask off unwanted bits
                    rts                 ; return to the caller
Code_3C14           pshs      A         ; preserve the listed registers on the stack
                    bsr       Code_3C33 ; call the referenced helper routine
                    puls      A         ; restore the listed registers from the stack
                    beq       Code_3C24 ; branch when the compared values are equal
                    pshs      CC        ; preserve the listed registers on the stack
                    cmpa      #$40      ; compare against the limit and set condition flags
                    beq       Code_3C25 ; branch when the compared values are equal
                    puls      CC        ; restore the listed registers from the stack
Code_3C24           rts                 ; return to the caller
Code_3C25           puls      CC        ; restore the listed registers from the stack
                    bcs       Code_3C11 ; branch when carry reports an unsigned underflow or error
                    bra       Code_3C0E ; continue at the selected control-flow target
Code_3C2B           lbsr      Code_3C33 ; call the referenced helper routine
                    bcc       Code_3C32 ; branch when carry is clear
                    exg       X,Y       ; exchange the two register values
Code_3C32           rts                 ; return to the caller
Code_3C33           pshs      Y,X       ; preserve the listed registers on the stack
                    leax      $01,X     ; form the referenced address without reading memory
                    leay      $01,Y     ; form the referenced address without reading memory
                    ldb       #$09      ; load the value needed by the following operation
Code_3C3B           lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpa      ,Y+       ; compare against the limit and set condition flags
                    bne       Code_3C44 ; branch when the compared values differ
                    decb                ; decrement the selected counter
                    bne       Code_3C3B ; branch when the compared values differ
Code_3C44           puls      Y,X       ; restore the listed registers from the stack
                    rts                 ; return to the caller
Code_3C47           pshs      U,Y,X     ; preserve the listed registers on the stack
                    leax      $0A,X     ; form the referenced address without reading memory
                    leay      $0A,Y     ; form the referenced address without reading memory
                    leau      $0A,U     ; form the referenced address without reading memory
                    ldb       #$09      ; load the value needed by the following operation
                    clra                ; clear the selected byte or register
Code_3C52           lda       ,-X       ; load the value needed by the following operation
                    adca      ,-Y       ; add the operand to the running value
                    daa                 ; adjust the accumulator to packed decimal
                    sta       ,-U       ; save the current value in working storage
                    decb                ; decrement the selected counter
                    bne       Code_3C52 ; branch when the compared values differ
                    puls      U,Y,X     ; restore the listed registers from the stack
                    rts                 ; return to the caller
Code_3C5F           pshs      U,Y,X     ; preserve the listed registers on the stack
                    leax      $0A,X     ; form the referenced address without reading memory
                    leay      $0A,Y     ; form the referenced address without reading memory
                    leau      $0A,U     ; form the referenced address without reading memory
                    ldb       #$09      ; load the value needed by the following operation
                    orcc      #$01      ; set the selected flag bits
Code_3C6B           lda       #$99      ; load the value needed by the following operation
                    adca      #$00      ; add the operand to the running value
                    suba      ,-Y       ; subtract the operand from the running value
                    sta       ,-S       ; save the current value in working storage
                    lda       ,-X       ; load the value needed by the following operation
                    adca      ,S+       ; add the operand to the running value
                    daa                 ; adjust the accumulator to packed decimal
                    sta       ,-U       ; save the current value in working storage
                    decb                ; decrement the selected counter
                    bne       Code_3C6B ; branch when the compared values differ
                    bcc       Code_3C83 ; branch when carry is clear
                    clra                ; clear the selected byte or register
                    puls      U,Y,X     ; restore the listed registers from the stack
                    rts                 ; return to the caller
Code_3C83           orcc      #$01      ; set the selected flag bits
                    puls      U,Y,X     ; restore the listed registers from the stack
                    rts                 ; return to the caller
Code_3C88           leax      $0A,X     ; form the referenced address without reading memory
                    ldb       #$09      ; load the value needed by the following operation
                    clra                ; clear the selected byte or register
Code_3C8D           lda       ,-X       ; load the value needed by the following operation
                    bne       Code_3C96 ; branch when the compared values differ
                    decb                ; decrement the selected counter
                    bne       Code_3C8D ; branch when the compared values differ
                    lda       #$00      ; load the value needed by the following operation
Code_3C96           rts                 ; return to the caller
Code_3C97           pshs      U,X       ; preserve the listed registers on the stack
                    tfr       U,X       ; copy the source register into the destination register
                    bsr       Code_3C88 ; call the referenced helper routine
                    bne       Code_3CA3 ; branch when the compared values differ
                    lda       #$00      ; load the value needed by the following operation
                    sta       ,U        ; save the current value in working storage
Code_3CA3           puls      U,X       ; restore the listed registers from the stack
                    rts                 ; return to the caller
Code_3CA6           leax      $0A,U     ; form the referenced address without reading memory
                    leay      $14,U     ; form the referenced address without reading memory
                    lbsr      Code_3C2B ; call the referenced helper routine
                    lda       ,X        ; load the value needed by the following operation
                    sta       ,U        ; save the current value in working storage
                    cmpa      ,Y        ; compare against the limit and set condition flags
                    bne       Code_3CBB ; branch when the compared values differ
                    lbsr      Code_3C47 ; call the referenced helper routine
                    bra       Code_3CBE ; continue at the selected control-flow target
Code_3CBB           lbsr      Code_3C5F ; call the referenced helper routine
Code_3CBE           pshs      CC        ; preserve the listed registers on the stack
                    lbsr      Code_3C97 ; call the referenced helper routine
                    puls      CC        ; restore the listed registers from the stack
                    rts                 ; return to the caller
Code_3CC6           leax      $0A,U     ; form the referenced address without reading memory
                    leay      $14,U     ; form the referenced address without reading memory
                    lda       ,Y        ; load the value needed by the following operation
                    bne       Code_3CD3 ; branch when the compared values differ
                    lda       #$40      ; load the value needed by the following operation
                    bra       Code_3CD5 ; continue at the selected control-flow target
Code_3CD3           lda       #$00      ; load the value needed by the following operation
Code_3CD5           sta       ,Y        ; save the current value in working storage
                    bsr       Code_3CA6 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_3CDA           tfr       U,X       ; copy the source register into the destination register
                    ldb       #$0A      ; load the value needed by the following operation
                    lbsr      Code_3DDA ; call the referenced helper routine
                    leax      $0A,U     ; form the referenced address without reading memory
                    lbsr      Code_3C88 ; call the referenced helper routine
                    beq       Code_3D66 ; branch when the compared values are equal
                    leax      $14,U     ; form the referenced address without reading memory
                    lbsr      Code_3C88 ; call the referenced helper routine
                    beq       Code_3D66 ; branch when the compared values are equal
                    leax      $0A,U     ; form the referenced address without reading memory
                    leay      $14,U     ; form the referenced address without reading memory
Code_3CF5           lbsr      Code_3C2B ; call the referenced helper routine
                    lbsr      Code_3DA2 ; call the referenced helper routine
                    lda       #$00      ; load the value needed by the following operation
                    sta       ,X        ; save the current value in working storage
                    sta       ,Y        ; save the current value in working storage
                    lbsr      Code_3D6C ; call the referenced helper routine
                    pshs      X         ; preserve the listed registers on the stack
                    leax      $1E,U     ; form the referenced address without reading memory
                    ldb       #$14      ; load the value needed by the following operation
                    lbsr      Code_3DDA ; call the referenced helper routine
                    puls      X         ; restore the listed registers from the stack
                    ldb       #$12      ; load the value needed by the following operation
Code_3D12           pshs      D         ; preserve the listed registers on the stack
                    lda       $09,Y     ; load the value needed by the following operation
                    anda      #$0F      ; mask off unwanted bits
                    beq       Code_3D31 ; branch when the compared values are equal
                    ldb       #$0A      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    pshs      U,Y,X     ; preserve the listed registers on the stack
                    leay      $1E,U     ; form the referenced address without reading memory
                    leax      $32,U     ; form the referenced address without reading memory
                    abx                 ; add the operand to the running value
                    ldb       ,X        ; load the value needed by the following operation
                    blt       Code_3D67 ; branch when the signed value is below the limit
                    tfr       Y,U       ; copy the source register into the destination register
                    lbsr      Code_3C47 ; call the referenced helper routine
                    puls      U,Y,X     ; restore the listed registers from the stack
Code_3D31           pshs      U,Y,X     ; preserve the listed registers on the stack
                    leax      $1E,U     ; form the referenced address without reading memory
                    leax      $01,X     ; form the referenced address without reading memory
                    ldb       #$12      ; load the value needed by the following operation
                    lbsr      Code_3DBC ; call the referenced helper routine
                    puls      U,Y,X     ; restore the listed registers from the stack
                    pshs      U,Y,X     ; preserve the listed registers on the stack
                    leax      $01,Y     ; form the referenced address without reading memory
                    ldb       #$09      ; load the value needed by the following operation
                    lbsr      Code_3DBC ; call the referenced helper routine
                    puls      U,Y,X     ; restore the listed registers from the stack
                    puls      D         ; restore the listed registers from the stack
                    decb                ; decrement the selected counter
                    bne       Code_3D12 ; branch when the compared values differ
                    ldb       #$07      ; load the value needed by the following operation
                    leax      $1F,U     ; form the referenced address without reading memory
Code_3D54           lda       ,X+       ; fetch the next value and advance the source pointer
                    bne       Code_3D69 ; branch when the compared values differ
                    decb                ; decrement the selected counter
                    bgt       Code_3D54 ; branch when the signed value is above the limit
                    leax      $26,U     ; form the referenced address without reading memory
                    leay      $01,U     ; form the referenced address without reading memory
                    ldb       #$09      ; load the value needed by the following operation
                    lbsr      Code_3DE2 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
Code_3D66           rts                 ; return to the caller
Code_3D67           leas      $08,S     ; form the referenced address without reading memory
Code_3D69           orcc      #$01      ; set the selected flag bits
                    rts                 ; return to the caller
Code_3D6C           pshs      U,Y,X     ; preserve the listed registers on the stack
                    pshs      X         ; preserve the listed registers on the stack
                    leax      $32,U     ; form the referenced address without reading memory
                    ldb       #$0A      ; load the value needed by the following operation
                    lbsr      Code_3DDA ; call the referenced helper routine
                    puls      X         ; restore the listed registers from the stack
                    ldb       #$09      ; load the value needed by the following operation
                    leay      $32,U     ; form the referenced address without reading memory
                    leau      $0A,Y     ; form the referenced address without reading memory
Code_3D81           pshs      D         ; preserve the listed registers on the stack
                    lbsr      Code_3C47 ; call the referenced helper routine
                    puls      D         ; restore the listed registers from the stack
                    bcs       Code_3D97 ; branch when carry reports an unsigned underflow or error
                    clra                ; clear the selected byte or register
                    sta       ,U        ; save the current value in working storage
                    leay      $0A,Y     ; form the referenced address without reading memory
                    leau      $0A,U     ; form the referenced address without reading memory
                    decb                ; decrement the selected counter
                    bne       Code_3D81 ; branch when the compared values differ
                    puls      U,Y,X     ; restore the listed registers from the stack
                    rts                 ; return to the caller
Code_3D97           lda       #$FF      ; load the value needed by the following operation
                    sta       ,U        ; save the current value in working storage
                    leau      $0A,U     ; form the referenced address without reading memory
                    decb                ; decrement the selected counter
                    bne       Code_3D97 ; branch when the compared values differ
                    puls      PC,U,Y,X  ; restore the listed registers from the stack
Code_3DA2           lda       ,X        ; load the value needed by the following operation
                    cmpa      ,Y        ; compare against the limit and set condition flags
                    bne       Code_3DAC ; branch when the compared values differ
                    lda       #$00      ; load the value needed by the following operation
                    bra       Code_3DAE ; continue at the selected control-flow target
Code_3DAC           lda       #$40      ; load the value needed by the following operation
Code_3DAE           sta       ,U        ; save the current value in working storage
                    rts                 ; return to the caller
Code_3DB1           pshs      X,D       ; preserve the listed registers on the stack
                    clra                ; clear the selected byte or register
Code_3DB4           ror       ,X+       ; rotate right through carry
                    decb                ; decrement the selected counter
                    bne       Code_3DB4 ; branch when the compared values differ
                    puls      X,D       ; restore the listed registers from the stack
                    rts                 ; return to the caller
Code_3DBC           bsr       Code_3DB1 ; call the referenced helper routine
                    bsr       Code_3DB1 ; call the referenced helper routine
                    bsr       Code_3DB1 ; call the referenced helper routine
                    bsr       Code_3DB1 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_3DC5           pshs      X,D       ; preserve the listed registers on the stack
                    abx                 ; add the operand to the running value
                    clra                ; clear the selected byte or register
Code_3DC9           rol       ,-X       ; rotate left through carry
                    decb                ; decrement the selected counter
                    bne       Code_3DC9 ; branch when the compared values differ
                    puls      X,D       ; restore the listed registers from the stack
                    rts                 ; return to the caller
Code_3DD1           bsr       Code_3DC5 ; call the referenced helper routine
                    bsr       Code_3DC5 ; call the referenced helper routine
                    bsr       Code_3DC5 ; call the referenced helper routine
                    bsr       Code_3DC5 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_3DDA           lda       #$00      ; load the value needed by the following operation
Code_3DDC           sta       ,X+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bne       Code_3DDC ; branch when the compared values differ
                    rts                 ; return to the caller
Code_3DE2           lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,Y+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bne       Code_3DE2 ; branch when the compared values differ
                    rts                 ; return to the caller
Code_3DEA           tfr       U,X       ; copy the source register into the destination register
                    ldb       #$0A      ; load the value needed by the following operation
                    lbsr      Code_3DDA ; call the referenced helper routine
                    leax      $14,U     ; form the referenced address without reading memory
                    lbsr      Code_3C88 ; call the referenced helper routine
                    lbeq      Code_3E89 ; take the distant branch when values are equal
                    leax      $0A,U     ; form the referenced address without reading memory
                    lbsr      Code_3C88 ; call the referenced helper routine
                    lbeq      Code_3E8D ; take the distant branch when values are equal
                    leax      $0A,U     ; form the referenced address without reading memory
                    leay      $14,U     ; form the referenced address without reading memory
                    lbsr      Code_3DA2 ; call the referenced helper routine
                    lda       #$00      ; load the value needed by the following operation
                    sta       ,X        ; save the current value in working storage
                    sta       ,Y        ; save the current value in working storage
                    pshs      Y,X       ; preserve the listed registers on the stack
                    leax      $1E,U     ; form the referenced address without reading memory
                    ldb       #$14      ; load the value needed by the following operation
                    lbsr      Code_3DDA ; call the referenced helper routine
                    leax      $01,U     ; form the referenced address without reading memory
                    ldb       #$09      ; load the value needed by the following operation
                    lbsr      Code_3DDA ; call the referenced helper routine
                    leax      $0B,U     ; form the referenced address without reading memory
                    leay      $28,U     ; form the referenced address without reading memory
                    ldb       #$09      ; load the value needed by the following operation
                    lbsr      Code_3DE2 ; call the referenced helper routine
                    puls      Y,X       ; restore the listed registers from the stack
                    ldb       #$17      ; load the value needed by the following operation
Code_3E31           pshs      U,D       ; preserve the listed registers on the stack
                    leax      $09,U     ; form the referenced address without reading memory
Code_3E35           pshs      X         ; preserve the listed registers on the stack
                    leax      $1E,U     ; form the referenced address without reading memory
                    leay      $14,U     ; form the referenced address without reading memory
                    pshs      U         ; preserve the listed registers on the stack
                    tfr       X,U       ; copy the source register into the destination register
                    lbsr      Code_3C5F ; call the referenced helper routine
                    puls      U         ; restore the listed registers from the stack
                    puls      X         ; restore the listed registers from the stack
                    bcs       Code_3E4E ; branch when carry reports an unsigned underflow or error
                    inc       ,X        ; advance the selected counter
                    bra       Code_3E35 ; continue at the selected control-flow target
Code_3E4E           leax      $1E,U     ; form the referenced address without reading memory
                    leay      $14,U     ; form the referenced address without reading memory
                    pshs      U         ; preserve the listed registers on the stack
                    tfr       X,U       ; copy the source register into the destination register
                    lbsr      Code_3C47 ; call the referenced helper routine
                    puls      U         ; restore the listed registers from the stack
                    puls      U,D       ; restore the listed registers from the stack
                    decb                ; decrement the selected counter
                    beq       Code_3E7D ; branch when the compared values are equal
                    pshs      U,D       ; preserve the listed registers on the stack
                    leax      $1F,U     ; form the referenced address without reading memory
                    ldb       #$14      ; load the value needed by the following operation
                    lbsr      Code_3DD1 ; call the referenced helper routine
                    leax      $01,U     ; form the referenced address without reading memory
                    ldb       ,X        ; load the value needed by the following operation
                    andb      #$F0      ; mask off unwanted bits
                    bne       Code_3E82 ; branch when the compared values differ
                    ldb       #$09      ; load the value needed by the following operation
                    lbsr      Code_3DD1 ; call the referenced helper routine
                    puls      U,D       ; restore the listed registers from the stack
                    bra       Code_3E31 ; continue at the selected control-flow target
Code_3E7D           lbsr      Code_3C97 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    rts                 ; return to the caller
Code_3E82           leas      $04,S     ; form the referenced address without reading memory
                    lda       #$02      ; load the value needed by the following operation
                    orcc      #$01      ; set the selected flag bits
                    rts                 ; return to the caller
Code_3E89           lda       #$01      ; load the value needed by the following operation
                    orcc      #$01      ; set the selected flag bits
Code_3E8D           rts                 ; return to the caller
Code_3E8E           tfr       U,X       ; copy the source register into the destination register
                    ldb       #$0A      ; load the value needed by the following operation
                    lbsr      Code_3DDA ; call the referenced helper routine
                    leax      $00AA,U   ; form the referenced address without reading memory
                    ldb       #$0A      ; load the value needed by the following operation
                    lbsr      Code_3DDA ; call the referenced helper routine
                    lda       #$01      ; load the value needed by the following operation
                    sta       -$03,X    ; save the current value in working storage
                    leax      $14,U     ; form the referenced address without reading memory
                    leax      $08,X     ; form the referenced address without reading memory
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    lbne      Code_3F53 ; take the distant branch when values differ
                    lda       ,X        ; load the value needed by the following operation
                    lbne      Code_3F53 ; take the distant branch when values differ
                    leax      $0A,U     ; form the referenced address without reading memory
                    lbsr      Code_3C88 ; call the referenced helper routine
                    bne       Code_3EC4 ; branch when the compared values differ
                    leax      $14,U     ; form the referenced address without reading memory
                    lbsr      Code_3C88 ; call the referenced helper routine
                    lbeq      Code_3F53 ; take the distant branch when values are equal
Code_3EC4           tfr       U,Y       ; copy the source register into the destination register
                    leax      $00AA,U   ; form the referenced address without reading memory
                    ldb       #$0A      ; load the value needed by the following operation
                    lbsr      Code_3DE2 ; call the referenced helper routine
                    leax      $00B4,U   ; form the referenced address without reading memory
                    leay      $14,U     ; form the referenced address without reading memory
                    lda       ,Y        ; load the value needed by the following operation
                    sta       ,X        ; save the current value in working storage
                    lda       #$00      ; load the value needed by the following operation
                    sta       ,Y        ; save the current value in working storage
                    leax      $14,U     ; form the referenced address without reading memory
                    lbsr      Code_3C88 ; call the referenced helper routine
                    beq       Code_3F51 ; branch when the compared values are equal
                    leax      $0A,U     ; form the referenced address without reading memory
                    tfr       U,Y       ; copy the source register into the destination register
                    ldb       #$0A      ; load the value needed by the following operation
                    lbsr      Code_3DE2 ; call the referenced helper routine
Code_3EEF           leax      $14,U     ; form the referenced address without reading memory
                    leay      $00AA,U   ; form the referenced address without reading memory
                    lbsr      Code_3C33 ; call the referenced helper routine
                    bne       Code_3F1C ; branch when the compared values differ
                    leax      $00B4,U   ; form the referenced address without reading memory
                    lda       ,X        ; load the value needed by the following operation
                    beq       Code_3F51 ; branch when the compared values are equal
                    leax      $00AA,U   ; form the referenced address without reading memory
                    leay      $0A,U     ; form the referenced address without reading memory
                    ldb       #$0A      ; load the value needed by the following operation
                    lbsr      Code_3DE2 ; call the referenced helper routine
                    tfr       U,X       ; copy the source register into the destination register
                    leay      $14,U     ; form the referenced address without reading memory
                    ldb       #$0A      ; load the value needed by the following operation
                    lbsr      Code_3DE2 ; call the referenced helper routine
                    lbsr      Code_3DEA ; call the referenced helper routine
                    rts                 ; return to the caller
Code_3F1C           leax      $0A,U     ; form the referenced address without reading memory
                    leay      $0096,U   ; form the referenced address without reading memory
                    ldb       #$0A      ; load the value needed by the following operation
                    lbsr      Code_3DE2 ; call the referenced helper routine
                    tfr       U,X       ; copy the source register into the destination register
                    leay      $00A0,U   ; form the referenced address without reading memory
                    ldb       #$0A      ; load the value needed by the following operation
                    lbsr      Code_3DE2 ; call the referenced helper routine
                    leax      $0096,U   ; form the referenced address without reading memory
                    leay      $00A0,U   ; form the referenced address without reading memory
                    lbsr      Code_3CF5 ; call the referenced helper routine
                    bcs       Code_3F58 ; branch when carry reports an unsigned underflow or error
                    leax      $14,U     ; form the referenced address without reading memory
                    leay      $00AA,U   ; form the referenced address without reading memory
                    pshs      U         ; preserve the listed registers on the stack
                    tfr       X,U       ; copy the source register into the destination register
                    lbsr      Code_3C5F ; call the referenced helper routine
                    puls      U         ; restore the listed registers from the stack
                    bra       Code_3EEF ; continue at the selected control-flow target
Code_3F51           clra                ; clear the selected byte or register
                    rts                 ; return to the caller
Code_3F53           lda       #$01      ; load the value needed by the following operation
                    orcc      #$01      ; set the selected flag bits
                    rts                 ; return to the caller
Code_3F58           lda       #$02      ; load the value needed by the following operation
                    orcc      #$01      ; set the selected flag bits
                    rts                 ; return to the caller
Code_3F5D           lbsr      Code_40DE ; call the referenced helper routine
                    tst       Addr_001D ; set condition flags from the current value
                    lbne      Code_40D8 ; take the distant branch when values differ
                    pshs      X         ; preserve the listed registers on the stack
Code_3F68           leay      $035E,U   ; form the referenced address without reading memory
                    ldb       #$0A      ; load the value needed by the following operation
                    lbsr      Code_0FB7 ; call the referenced helper routine
                    tfr       Y,X       ; copy the source register into the destination register
                    ldd       #Addr_000A ; load the value needed by the following operation
                    lbsr      Code_10BE ; call the referenced helper routine
                    lda       #$90      ; load the value needed by the following operation
                    sta       -$03,X    ; save the current value in working storage
                    pshs      U         ; preserve the listed registers on the stack
                    leau      $0354,U   ; form the referenced address without reading memory
                    leax      $0A,U     ; form the referenced address without reading memory
                    lbsr      Code_3C04 ; call the referenced helper routine
                    puls      U         ; restore the listed registers from the stack
                    bcs       Code_3FF7 ; branch when carry reports an unsigned underflow or error
                    beq       Code_3FF7 ; branch when the compared values are equal
                    leay      $036E,U   ; form the referenced address without reading memory
                    lda       #$02      ; load the value needed by the following operation
                    sta       ,Y+       ; store the value and advance the destination pointer
                    lda       #$70      ; load the value needed by the following operation
                    sta       ,Y        ; save the current value in working storage
                    pshs      U         ; preserve the listed registers on the stack
                    leau      $0354,U   ; form the referenced address without reading memory
                    leax      $0A,U     ; form the referenced address without reading memory
                    leay      $14,U     ; form the referenced address without reading memory
                    lbsr      Code_3C04 ; call the referenced helper routine
                    puls      U         ; restore the listed registers from the stack
                    bcs       Code_3FBC ; branch when carry reports an unsigned underflow or error
                    beq       Code_3FBC ; branch when the compared values are equal
                    leax      $036E,U   ; form the referenced address without reading memory
                    lda       #$03      ; load the value needed by the following operation
                    sta       ,X+       ; store the value and advance the destination pointer
                    lda       #$60      ; load the value needed by the following operation
                    sta       ,X        ; save the current value in working storage
                    bra       Code_3FD9 ; continue at the selected control-flow target
Code_3FBC           leax      $035E,U   ; form the referenced address without reading memory
                    ldd       #Addr_000A ; load the value needed by the following operation
                    lbsr      Code_10BE ; call the referenced helper routine
                    tfr       X,Y       ; copy the source register into the destination register
                    leax      -$04,X    ; form the referenced address without reading memory
                    lda       #$01      ; load the value needed by the following operation
                    sta       ,X+       ; store the value and advance the destination pointer
                    lda       #$80      ; load the value needed by the following operation
                    sta       ,X        ; save the current value in working storage
                    ldx       ,S        ; load the value needed by the following operation
                    ldb       #$0A      ; load the value needed by the following operation
                    lbsr      Code_0FB7 ; call the referenced helper routine
Code_3FD9           pshs      U         ; preserve the listed registers on the stack
                    leau      $0354,U   ; form the referenced address without reading memory
                    leax      $0A,U     ; form the referenced address without reading memory
                    leay      $14,U     ; form the referenced address without reading memory
                    lbsr      Code_3CC6 ; call the referenced helper routine
                    tfr       U,X       ; copy the source register into the destination register
                    puls      U         ; restore the listed registers from the stack
                    lbcs      Code_40D8 ; take the distant branch when carry reports an error
                    ldy       ,S        ; load the value needed by the following operation
                    ldb       #$0A      ; load the value needed by the following operation
                    lbsr      Code_0FB7 ; call the referenced helper routine
Code_3FF7           ldx       ,S        ; load the value needed by the following operation
                    lda       ,X        ; load the value needed by the following operation
                    adda      Addr_004C ; add the operand to the running value
                    anda      #$40      ; mask off unwanted bits
                    sta       Addr_004C ; save the current value in working storage
                    lbsr      Code_4180 ; call the referenced helper routine
                    lda       #$04      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    leay      Data_4309,PCR ; form the referenced address without reading memory
                    leay      D,Y       ; form the referenced address without reading memory
                    ldd       ,Y++      ; fetch the next value and advance the source pointer
                    pshs      D         ; preserve the listed registers on the stack
                    ldd       ,Y++      ; fetch the next value and advance the source pointer
                    pshs      D         ; preserve the listed registers on the stack
                    ldx       $04,S     ; load the value needed by the following operation
                    leax      $08,X     ; form the referenced address without reading memory
                    ldd       ,X        ; load the value needed by the following operation
                    bne       Code_4029 ; branch when the compared values differ
                    leax      $0412,U   ; form the referenced address without reading memory
                    ldd       #Addr_000A ; load the value needed by the following operation
                    lbsr      Code_10BE ; call the referenced helper routine
                    bra       Code_407E ; continue at the selected control-flow target
Code_4029           ldd       ,Y++      ; fetch the next value and advance the source pointer
                    subd      $02,S     ; subtract the operand from the running value
                    pshs      D,CC      ; preserve the listed registers on the stack
                    ldd       ,Y        ; load the value needed by the following operation
                    puls      CC        ; restore the listed registers from the stack
                    bcc       Code_4038 ; branch when carry is clear
                    subd      #Addr_0001 ; subtract the operand from the running value
Code_4038           subd      $02,S     ; subtract the operand from the running value
                    pshs      D         ; preserve the listed registers on the stack
                    ldd       #Addr_000A ; load the value needed by the following operation
                    leax      $035E,U   ; form the referenced address without reading memory
                    lbsr      Code_10BE ; call the referenced helper routine
                    tfr       S,Y       ; copy the source register into the destination register
                    lbsr      Code_4198 ; call the referenced helper routine
                    leas      $04,S     ; form the referenced address without reading memory
                    leax      $0368,U   ; form the referenced address without reading memory
                    ldd       #Addr_000A ; load the value needed by the following operation
                    lbsr      Code_10BE ; call the referenced helper routine
                    leay      -$02,X    ; form the referenced address without reading memory
                    ldx       $04,S     ; load the value needed by the following operation
                    leax      $08,X     ; form the referenced address without reading memory
                    ldd       ,X        ; load the value needed by the following operation
                    std       ,Y        ; save the current value in working storage
                    pshs      U         ; preserve the listed registers on the stack
                    leau      $0354,U   ; form the referenced address without reading memory
                    leax      $0A,U     ; form the referenced address without reading memory
                    leay      $14,U     ; form the referenced address without reading memory
                    lbsr      Code_3CDA ; call the referenced helper routine
                    tfr       U,X       ; copy the source register into the destination register
                    puls      U         ; restore the listed registers from the stack
                    bcs       Code_40D6 ; branch when carry reports an unsigned underflow or error
                    leay      $0412,U   ; form the referenced address without reading memory
                    ldb       #$0A      ; load the value needed by the following operation
                    lbsr      Code_0FB7 ; call the referenced helper routine
Code_407E           leax      $035E,U   ; form the referenced address without reading memory
                    ldd       #Addr_000A ; load the value needed by the following operation
                    lbsr      Code_10BE ; call the referenced helper routine
                    tfr       S,Y       ; copy the source register into the destination register
                    lbsr      Code_4198 ; call the referenced helper routine
                    leas      $04,S     ; form the referenced address without reading memory
                    leax      $0412,U   ; form the referenced address without reading memory
                    leay      $0368,U   ; form the referenced address without reading memory
                    ldb       #$0A      ; load the value needed by the following operation
                    lbsr      Code_0FB7 ; call the referenced helper routine
                    pshs      U         ; preserve the listed registers on the stack
                    leau      $0354,U   ; form the referenced address without reading memory
                    leax      $0A,U     ; form the referenced address without reading memory
                    leay      $14,U     ; form the referenced address without reading memory
                    lbsr      Code_3CA6 ; call the referenced helper routine
                    puls      U         ; restore the listed registers from the stack
                    bcs       Code_40D8 ; branch when carry reports an unsigned underflow or error
                    tst       Addr_0048 ; set condition flags from the current value
                    bne       Code_40C4 ; branch when the compared values differ
                    leax      $0354,U   ; form the referenced address without reading memory
                    ldd       $03,X     ; load the value needed by the following operation
                    std       $07,X     ; save the current value in working storage
                    lda       $05,X     ; load the value needed by the following operation
                    sta       $09,X     ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    std       $03,X     ; save the current value in working storage
                    std       $05,X     ; save the current value in working storage
Code_40C4           leax      $0355,U   ; form the referenced address without reading memory
                    ldy       ,S        ; load the value needed by the following operation
                    lda       Addr_004C ; load the value needed by the following operation
                    sta       ,Y+       ; store the value and advance the destination pointer
                    ldb       #$09      ; load the value needed by the following operation
                    lbsr      Code_0FB7 ; call the referenced helper routine
                    puls      PC,X      ; restore the listed registers from the stack
Code_40D6           leas      $04,S     ; form the referenced address without reading memory
Code_40D8           lda       #$01      ; load the value needed by the following operation
                    sta       Addr_001D ; save the current value in working storage
                    puls      PC,X      ; restore the listed registers from the stack
Code_40DE           leax      $01,X     ; form the referenced address without reading memory
                    pshs      X         ; preserve the listed registers on the stack
                    lda       ,X        ; load the value needed by the following operation
                    sta       Addr_004C ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    sta       ,X        ; save the current value in working storage
                    tst       Code_0047 ; set condition flags from the current value
                    beq       Code_412C ; branch when the compared values are equal
                    leay      $035E,U   ; form the referenced address without reading memory
                    ldb       #$0A      ; load the value needed by the following operation
                    lbsr      Code_0FB7 ; call the referenced helper routine
                    tfr       Y,X       ; copy the source register into the destination register
                    ldd       #Addr_000A ; load the value needed by the following operation
                    lbsr      Code_10BE ; call the referenced helper routine
                    leax      $07,Y     ; form the referenced address without reading memory
                    lda       #$57      ; load the value needed by the following operation
                    sta       ,X+       ; store the value and advance the destination pointer
                    lda       #$29      ; load the value needed by the following operation
                    sta       ,X+       ; store the value and advance the destination pointer
                    lda       #$56      ; load the value needed by the following operation
                    sta       ,X        ; save the current value in working storage
                    pshs      U         ; preserve the listed registers on the stack
                    leau      $0354,U   ; form the referenced address without reading memory
                    leax      $0A,U     ; form the referenced address without reading memory
                    leay      $14,U     ; form the referenced address without reading memory
                    lbsr      Code_3CDA ; call the referenced helper routine
                    puls      U         ; restore the listed registers from the stack
                    bcs       Code_417A ; branch when carry reports an unsigned underflow or error
                    leax      $0354,U   ; form the referenced address without reading memory
                    ldy       ,S        ; load the value needed by the following operation
                    ldb       #$0A      ; load the value needed by the following operation
                    lbsr      Code_0FB7 ; call the referenced helper routine
                    ldx       ,S        ; load the value needed by the following operation
Code_412C           leay      $035E,U   ; form the referenced address without reading memory
                    ldb       #$0A      ; load the value needed by the following operation
                    lbsr      Code_0FB7 ; call the referenced helper routine
                    tfr       Y,X       ; copy the source register into the destination register
                    ldd       #Addr_000A ; load the value needed by the following operation
                    lbsr      Code_10BE ; call the referenced helper routine
                    leax      $06,Y     ; form the referenced address without reading memory
                    lda       #$03      ; load the value needed by the following operation
                    sta       ,X+       ; store the value and advance the destination pointer
                    lda       #$60      ; load the value needed by the following operation
                    sta       ,X        ; save the current value in working storage
                    leau      $0354,U   ; form the referenced address without reading memory
Code_414B           leax      $0A,U     ; form the referenced address without reading memory
                    leay      $14,U     ; form the referenced address without reading memory
                    lbsr      Code_3CC6 ; call the referenced helper routine
                    bcs       Code_417A ; branch when carry reports an unsigned underflow or error
                    tst       ,U        ; set condition flags from the current value
                    bgt       Code_4176 ; branch when the signed value is above the limit
                    tfr       U,X       ; copy the source register into the destination register
                    lbsr      Code_3C88 ; call the referenced helper routine
                    beq       Code_4176 ; branch when the compared values are equal
                    tfr       U,X       ; copy the source register into the destination register
                    leay      $0A,U     ; form the referenced address without reading memory
                    ldb       #$0A      ; load the value needed by the following operation
                    lbsr      Code_0FB7 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    sta       ,Y        ; save the current value in working storage
                    ldy       ,S        ; load the value needed by the following operation
                    ldb       #$0A      ; load the value needed by the following operation
                    lbsr      Code_0FB7 ; call the referenced helper routine
                    bra       Code_414B ; continue at the selected control-flow target
Code_4176           ldu       DeskMateService ; load the value needed by the following operation
                    puls      PC,X      ; restore the listed registers from the stack
Code_417A           lda       #$01      ; load the value needed by the following operation
                    sta       Addr_001D ; save the current value in working storage
                    puls      PC,X      ; restore the listed registers from the stack
Code_4180           clrb                ; clear the selected byte or register
                    leay      $07,X     ; form the referenced address without reading memory
                    ldb       ,Y        ; load the value needed by the following operation
                    andb      #$F0      ; mask off unwanted bits
                    lsrb                ; shift right and expose the low bit through carry
                    lsrb                ; shift right and expose the low bit through carry
                    lsrb                ; shift right and expose the low bit through carry
                    lsrb                ; shift right and expose the low bit through carry
                    lda       #$0A      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    lda       ,Y        ; load the value needed by the following operation
                    anda      #$0F      ; mask off unwanted bits
                    pshs      A         ; preserve the listed registers on the stack
                    addb      ,S+       ; add the operand to the running value
                    clra                ; clear the selected byte or register
                    rts                 ; return to the caller
Code_4198           ldd       ,Y++      ; fetch the next value and advance the source pointer
                    bsr       Code_41F9 ; call the referenced helper routine
                    pshs      Y         ; preserve the listed registers on the stack
                    leax      $0368,U   ; form the referenced address without reading memory
                    tfr       X,Y       ; copy the source register into the destination register
                    ldd       #Addr_000A ; load the value needed by the following operation
                    lbsr      Code_10BE ; call the referenced helper routine
                    leax      -$05,X    ; form the referenced address without reading memory
                    lda       #$06      ; load the value needed by the following operation
                    sta       ,X+       ; store the value and advance the destination pointer
                    lda       #$55      ; load the value needed by the following operation
                    sta       ,X+       ; store the value and advance the destination pointer
                    lda       #$36      ; load the value needed by the following operation
                    sta       ,X+       ; store the value and advance the destination pointer
                    pshs      U         ; preserve the listed registers on the stack
                    leau      $0354,U   ; form the referenced address without reading memory
                    leax      $0A,U     ; form the referenced address without reading memory
                    lbsr      Code_3CDA ; call the referenced helper routine
                    puls      U         ; restore the listed registers from the stack
                    puls      Y         ; restore the listed registers from the stack
                    leax      $035E,U   ; form the referenced address without reading memory
                    ldd       #Addr_000A ; load the value needed by the following operation
                    lbsr      Code_10BE ; call the referenced helper routine
                    ldd       ,Y        ; load the value needed by the following operation
                    bsr       Code_41F9 ; call the referenced helper routine
                    leax      $0354,U   ; form the referenced address without reading memory
                    leay      $14,X     ; form the referenced address without reading memory
                    ldb       #$0A      ; load the value needed by the following operation
                    lbsr      Code_0FB7 ; call the referenced helper routine
                    pshs      U         ; preserve the listed registers on the stack
                    leau      $0354,U   ; form the referenced address without reading memory
                    leay      $14,U     ; form the referenced address without reading memory
                    lbsr      Code_3CA6 ; call the referenced helper routine
                    tfr       U,X       ; copy the source register into the destination register
                    puls      U         ; restore the listed registers from the stack
                    leay      $0A,X     ; form the referenced address without reading memory
                    ldb       #$0A      ; load the value needed by the following operation
                    lbsr      Code_0FB7 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_41F9           leax      -$05,X    ; form the referenced address without reading memory
Code_41FB           cmpd      #Code_2710 ; compare against the limit and set condition flags
                    bcs       Code_4208 ; branch when carry reports an unsigned underflow or error
                    subd      #Code_2710 ; subtract the operand from the running value
                    inc       ,X        ; advance the selected counter
                    bra       Code_41FB ; continue at the selected control-flow target
Code_4208           leax      $01,X     ; form the referenced address without reading memory
Code_420A           cmpd      #Addr_03E8 ; compare against the limit and set condition flags
                    bcs       Code_4217 ; branch when carry reports an unsigned underflow or error
                    subd      #Addr_03E8 ; subtract the operand from the running value
                    inc       ,X        ; advance the selected counter
                    bra       Code_420A ; continue at the selected control-flow target
Code_4217           asl       ,X        ; shift left and update carry
                    asl       ,X        ; shift left and update carry
                    asl       ,X        ; shift left and update carry
                    asl       ,X        ; shift left and update carry
Code_421F           cmpd      #Code_0064 ; compare against the limit and set condition flags
                    bcs       Code_422C ; branch when carry reports an unsigned underflow or error
                    subd      #Code_0064 ; subtract the operand from the running value
                    inc       ,X        ; advance the selected counter
                    bra       Code_421F ; continue at the selected control-flow target
Code_422C           leax      $01,X     ; form the referenced address without reading memory
Code_422E           cmpd      #Addr_000A ; compare against the limit and set condition flags
                    bcs       Code_423B ; branch when carry reports an unsigned underflow or error
                    subd      #Addr_000A ; subtract the operand from the running value
                    inc       ,X        ; advance the selected counter
                    bra       Code_422E ; continue at the selected control-flow target
Code_423B           asl       ,X        ; shift left and update carry
                    asl       ,X        ; shift left and update carry
                    asl       ,X        ; shift left and update carry
                    asl       ,X        ; shift left and update carry
                    addb      ,X        ; add the operand to the running value
                    stb       ,X        ; save the current value in working storage
                    rts                 ; return to the caller
Code_4248           lbsr      Code_40DE ; call the referenced helper routine
                    tst       Addr_001D ; set condition flags from the current value
                    lbne      Code_417A ; take the distant branch when values differ
                    pshs      X         ; preserve the listed registers on the stack
Code_4253           leay      $0368,U   ; form the referenced address without reading memory
                    ldb       #$0A      ; load the value needed by the following operation
                    lbsr      Code_0FB7 ; call the referenced helper routine
                    leax      $035E,U   ; form the referenced address without reading memory
                    ldd       #Addr_000A ; load the value needed by the following operation
                    lbsr      Code_10BE ; call the referenced helper routine
                    lda       #$90      ; load the value needed by the following operation
                    sta       -$03,X    ; save the current value in working storage
                    pshs      U         ; preserve the listed registers on the stack
                    leau      $0354,U   ; form the referenced address without reading memory
                    leax      $0A,U     ; form the referenced address without reading memory
                    leay      $14,U     ; form the referenced address without reading memory
                    lbsr      Code_3CC6 ; call the referenced helper routine
                    tfr       U,X       ; copy the source register into the destination register
                    puls      U         ; restore the listed registers from the stack
                    lbcs      Code_417A ; take the distant branch when carry reports an error
                    ldy       ,S        ; load the value needed by the following operation
                    ldb       #$0A      ; load the value needed by the following operation
                    lbsr      Code_0FB7 ; call the referenced helper routine
                    ldx       ,S        ; load the value needed by the following operation
                    lda       ,X        ; load the value needed by the following operation
                    sta       Addr_004C ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    sta       ,X        ; save the current value in working storage
                    lbra      Code_3F68 ; continue at the distant control-flow target
Code_4294           lda       #$01      ; load the value needed by the following operation
                    sta       Addr_0048 ; save the current value in working storage
                    pshs      X         ; preserve the listed registers on the stack
                    leax      $01,X     ; form the referenced address without reading memory
                    leas      -$0A,S    ; form the referenced address without reading memory
                    tfr       S,Y       ; copy the source register into the destination register
                    ldb       #$0A      ; load the value needed by the following operation
                    lbsr      Code_0FB7 ; call the referenced helper routine
                    ldx       $0A,S     ; load the value needed by the following operation
                    lbsr      Code_3F5D ; call the referenced helper routine
                    tst       Addr_001D ; set condition flags from the current value
                    bne       Code_4301 ; branch when the compared values differ
                    tfr       S,Y       ; copy the source register into the destination register
                    ldb       #$0A      ; load the value needed by the following operation
                    pshs      B         ; preserve the listed registers on the stack
Code_42B4           lda       ,X        ; load the value needed by the following operation
                    ldb       ,Y        ; load the value needed by the following operation
                    sta       ,Y+       ; store the value and advance the destination pointer
                    stb       ,X+       ; store the value and advance the destination pointer
                    dec       ,S        ; decrement the selected counter
                    bgt       Code_42B4 ; branch when the signed value is above the limit
                    leas      $01,S     ; form the referenced address without reading memory
                    ldx       $0A,S     ; load the value needed by the following operation
                    lbsr      Code_4248 ; call the referenced helper routine
                    tst       Addr_001D ; set condition flags from the current value
                    bne       Code_4301 ; branch when the compared values differ
                    leay      $0368,U   ; form the referenced address without reading memory
                    ldb       #$0A      ; load the value needed by the following operation
                    lbsr      Code_0FB7 ; call the referenced helper routine
                    leay      $035E,U   ; form the referenced address without reading memory
                    ldb       #$0A      ; load the value needed by the following operation
                    tfr       S,X       ; copy the source register into the destination register
                    lbsr      Code_0FB7 ; call the referenced helper routine
                    leas      $0A,S     ; form the referenced address without reading memory
                    pshs      U         ; preserve the listed registers on the stack
                    leau      $0354,U   ; form the referenced address without reading memory
                    leax      $0A,U     ; form the referenced address without reading memory
                    leay      $14,U     ; form the referenced address without reading memory
                    lbsr      Code_3DEA ; call the referenced helper routine
                    tfr       U,X       ; copy the source register into the destination register
                    puls      U         ; restore the listed registers from the stack
                    bcs       Code_4301 ; branch when carry reports an unsigned underflow or error
                    puls      Y         ; restore the listed registers from the stack
                    leay      $01,Y     ; form the referenced address without reading memory
                    ldb       #$0A      ; load the value needed by the following operation
                    lbsr      Code_0FB7 ; call the referenced helper routine
                    clr       Addr_0048 ; clear the selected byte or register
                    rts                 ; return to the caller
Code_4301           clr       Addr_0048 ; clear the selected byte or register
                    lda       #$01      ; load the value needed by the following operation
                    sta       Addr_001D ; save the current value in working storage
                    puls      PC,X      ; restore the listed registers from the stack
Data_4309           fcb       $00,$00,$00,$00,$A1 ; table, bitmap, or initialized data bytes
                    fcc       "Y"                            ; embedded text or resource bytes
                    fcb       $00,$1A   ; table, bitmap, or initialized data bytes
                    fcc       "@"                            ; embedded text or resource bytes
                    fcb       $9E,$00   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $DB,$BC,$00 ; table, bitmap, or initialized data bytes
                    fcc       "Op"                           ; embedded text or resource bytes
                    fcb       $9F,$00   ; table, bitmap, or initialized data bytes
                    fcc       "j"                            ; embedded text or resource bytes
                    fcb       $FD       ; table, bitmap, or initialized data bytes
                    fcc       "6"                            ; embedded text or resource bytes
                    fcb       $00,$84,$7F ; table, bitmap, or initialized data bytes
                    fcc       "n"                            ; embedded text or resource bytes
                    fcb       $00,$9F,$F5 ; table, bitmap, or initialized data bytes
                    fcc       "6"                            ; embedded text or resource bytes
                    fcb       $00,$B9   ; table, bitmap, or initialized data bytes
                    fcc       "\~"                           ; embedded text or resource bytes
                    fcb       $00,$D4,$B3 ; table, bitmap, or initialized data bytes
                    fcc       "7"                            ; embedded text or resource bytes
                    fcb       $00,$EE,$F7 ; table, bitmap, or initialized data bytes
                    fcc       "R"                            ; embedded text or resource bytes
                    fcb       $01,$08,$26,$C4,$01 ; table, bitmap, or initialized data bytes
                    fcc       "#?"                           ; embedded text or resource bytes
                    fcb       $81,$01   ; table, bitmap, or initialized data bytes
                    fcc       "=?"                           ; embedded text or resource bytes
                    fcb       $81,$01   ; table, bitmap, or initialized data bytes
                    fcc       "W$"                           ; embedded text or resource bytes
                    fcb       $BE,$01   ; table, bitmap, or initialized data bytes
                    fcc       "q"                            ; embedded text or resource bytes
                    fcb       $ED       ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $01,$8A,$96,$D8,$01,$A4 ; table, bitmap, or initialized data bytes
                    fcb       $1F,$B2,$01,$BE,$85,$C3 ; table, bitmap, or initialized data bytes
                    fcb       $01,$D7,$C7,$0F,$01,$F0 ; table, bitmap, or initialized data bytes
                    fcb       $E1,$9E,$02,$09,$D3 ; table, bitmap, or initialized data bytes
                    fcc       "{"                            ; embedded text or resource bytes
                    fcb       $02,$22,$9A,$B3,$02 ; table, bitmap, or initialized data bytes
                    fcc       ";5Y"                    ;4364: 3B 35 59       ' ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "T"                            ; embedded text or resource bytes
                    fcb       $A1,$80,$02 ; table, bitmap, or initialized data bytes
                    fcc       "l"                            ; embedded text or resource bytes
                    fcb       $DD       ; table, bitmap, or initialized data bytes
                    fcc       "B"                            ; embedded text or resource bytes
                    fcb       $02,$84,$E6,$BB,$02,$9C ; table, bitmap, or initialized data bytes
                    fcb       $BC,$0A,$02,$B4 ; table, bitmap, or initialized data bytes
                    fcc       "[T"                           ; embedded text or resource bytes
                    fcb       $02,$CC,$C2,$C2,$02,$E3 ; table, bitmap, or initialized data bytes
                    fcb       $F0,$80,$02,$FA,$E2,$BF ; table, bitmap, or initialized data bytes
                    fcb       $03,$11,$97,$B6,$03 ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $0D,$A0,$03 ; table, bitmap, or initialized data bytes
                    fcc       "?B"                           ; embedded text or resource bytes
                    fcb       $BA,$03   ; table, bitmap, or initialized data bytes
                    fcc       "U5L"                          ; embedded text or resource bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "k"                            ; embedded text or resource bytes
                    fcb       $E3,$9D,$03,$80 ; table, bitmap, or initialized data bytes
                    fcc       "K"                            ; embedded text or resource bytes
                    fcb       $FE,$03,$96 ; table, bitmap, or initialized data bytes
                    fcc       "l"                            ; embedded text or resource bytes
                    fcb       $C4,$03,$AB ; table, bitmap, or initialized data bytes
                    fcc       "DG"                           ; embedded text or resource bytes
                    fcb       $03,$C0,$D0,$E9,$03,$D4 ; table, bitmap, or initialized data bytes
                    fcb       $11,$0F,$03,$E9,$03 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $03,$FD,$A5,$9C,$04,$10 ; table, bitmap, or initialized data bytes
                    fcb       $F6,$ED,$04 ; table, bitmap, or initialized data bytes
                    fcc       "#"                            ; embedded text or resource bytes
                    fcb       $F5,$96,$04 ; table, bitmap, or initialized data bytes
                    fcc       "6"                            ; embedded text or resource bytes
                    fcb       $A0,$1C,$04 ; table, bitmap, or initialized data bytes
                    fcc       "I"                            ; embedded text or resource bytes
                    fcb       $F5,$0A,$04 ; table, bitmap, or initialized data bytes
                    fcc       "["                            ; embedded text or resource bytes
                    fcb       $F2,$F3,$04 ; table, bitmap, or initialized data bytes
                    fcc       "m"                            ; embedded text or resource bytes
                    fcb       $98       ; table, bitmap, or initialized data bytes
                    fcc       "n"                            ; embedded text or resource bytes
                    fcb       $04,$7F,$E4,$1C,$04,$90 ; table, bitmap, or initialized data bytes
                    fcb       $D4,$A4,$04,$A1 ; table, bitmap, or initialized data bytes
                    fcc       "h"                            ; embedded text or resource bytes
                    fcb       $B3,$04,$B2,$9E,$FF,$04 ; table, bitmap, or initialized data bytes
                    fcb       $C2       ; table, bitmap, or initialized data bytes
                    fcc       "vC"                           ; embedded text or resource bytes
                    fcb       $04,$D2,$ED ; table, bitmap, or initialized data bytes
                    fcc       "D"                            ; embedded text or resource bytes
                    fcb       $04,$E1,$02,$CD,$04,$F1 ; table, bitmap, or initialized data bytes
                    fcb       $B5,$B1,$04,$FF,$04,$CA ; table, bitmap, or initialized data bytes
                    fcb       $05,$0E,$EE,$FA,$05,$1B ; table, bitmap, or initialized data bytes
                    fcc       "s,"                           ; embedded text or resource bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
                    fcc       ")"                            ; embedded text or resource bytes
                    fcb       $90       ; table, bitmap, or initialized data bytes
                    fcc       "S"                            ; embedded text or resource bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
                    fcc       "6Eg"                          ; embedded text or resource bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $91       ; table, bitmap, or initialized data bytes
                    fcc       "l"                            ; embedded text or resource bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
                    fcc       "Osm"                          ; embedded text or resource bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
                    fcc       "["                            ; embedded text or resource bytes
                    fcb       $EA       ; table, bitmap, or initialized data bytes
                    fcc       "{"                            ; embedded text or resource bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
                    fcc       "f"                            ; embedded text or resource bytes
                    fcb       $F5,$B2,$05 ; table, bitmap, or initialized data bytes
                    fcc       "q"                            ; embedded text or resource bytes
                    fcb       $94       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
                    fcc       "|"                            ; embedded text or resource bytes
                    fcb       $C5       ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $05,$86,$87,$DB,$05,$90 ; table, bitmap, or initialized data bytes
                    fcb       $DB       ; table, bitmap, or initialized data bytes
                    fcc       "n"                            ; embedded text or resource bytes
                    fcb       $05,$99,$BF ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $05,$A2   ; table, bitmap, or initialized data bytes
                    fcc       "2t"                           ; embedded text or resource bytes
                    fcb       $05,$AB   ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $8C,$05,$B3,$C4,$DA,$05 ; table, bitmap, or initialized data bytes
                    fcb       $BA,$E2,$C7,$05,$C1,$8D ; table, bitmap, or initialized data bytes
                    fcb       $C5,$05,$C8,$C5 ; table, bitmap, or initialized data bytes
                    fcc       "N"                            ; embedded text or resource bytes
                    fcb       $05,$CE,$88,$E8,$05,$D4 ; table, bitmap, or initialized data bytes
                    fcb       $D8,$1E,$05,$D9,$B2,$87 ; table, bitmap, or initialized data bytes
                    fcb       $05,$DE,$17,$C2,$05,$E3 ; table, bitmap, or initialized data bytes
                    fcb       $07       ; table, bitmap, or initialized data bytes
                    fcc       "w"                            ; embedded text or resource bytes
                    fcb       $05,$E7,$81 ; table, bitmap, or initialized data bytes
                    fcc       "W"                            ; embedded text or resource bytes
                    fcb       $05,$EA,$85,$1E,$05,$ED ; table, bitmap, or initialized data bytes
                    fcb       $12,$8E,$05,$F0 ; table, bitmap, or initialized data bytes
                    fcc       ")u"                           ; embedded text or resource bytes
                    fcb       $05,$F2,$C9,$A9,$05,$F3 ; table, bitmap, or initialized data bytes
                    fcb       $F3,$0B,$05,$F4,$A5,$82 ; table, bitmap, or initialized data bytes
                    fcb       $05,$F5,$E1,$00,$05,$F5 ; table, bitmap, or initialized data bytes
                    fcb       $E1,$00,$05,$F5,$96,$80 ; table, bitmap, or initialized data bytes
                    fcb       $00,$98   ; table, bitmap, or initialized data bytes
                    fcc       "B@"                           ; embedded text or resource bytes
                    fcb       $00,$0F,$86,$A0,$00,$01 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $10,$00,$00 ; table, bitmap, or initialized data bytes
Code_4489           pshs      Y,X,D     ; preserve the listed registers on the stack
                    leax      Data_4987,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    ldx       #DeskMateService ; load the value needed by the following operation
                    tfr       X,Y       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    leax      Data_4995,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
                    clr       Addr_001F ; clear the selected byte or register
                    leax      $016A,U   ; form the referenced address without reading memory
                    leay      $0241,U   ; form the referenced address without reading memory
                    ldb       #$19      ; load the value needed by the following operation
                    lbsr      Code_0FB7 ; call the referenced helper routine
                    leax      -$19,Y    ; form the referenced address without reading memory
                    ldd       #Addr_9800 ; load the value needed by the following operation
Code_44B9           ldy       #Data_0809 ; load the value needed by the following operation
                    lbsr      Code_118E ; call the referenced helper routine
                    cmpa      #$05      ; compare against the limit and set condition flags
                    beq       Code_452F ; branch when the compared values are equal
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    beq       Code_44CD ; branch when the compared values are equal
                    ldd       #Addr_1800 ; load the value needed by the following operation
                    bra       Code_44B9 ; continue at the selected control-flow target
Code_44CD           leax      $0241,U   ; form the referenced address without reading memory
                    leay      $016A,U   ; form the referenced address without reading memory
                    ldb       #$19      ; load the value needed by the following operation
                    lbsr      Code_0FB7 ; call the referenced helper routine
                    ldd       Addr_0007 ; load the value needed by the following operation
                    std       Code_001E ; save the current value in working storage
                    leax      -$19,Y    ; form the referenced address without reading memory
                    ldb       #$18      ; load the value needed by the following operation
                    stb       Addr_0012 ; save the current value in working storage
                    clr       Addr_0010 ; clear the selected byte or register
                    lbsr      Code_3500 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_452F ; branch when the compared values are equal
                    clr       Addr_001D ; clear the selected byte or register
                    leax      -$01,X    ; form the referenced address without reading memory
                    inc       Addr_0012 ; advance the selected counter
                    lbsr      Code_347F ; call the referenced helper routine
                    tst       Addr_001D ; set condition flags from the current value
                    bne       Code_4532 ; branch when the compared values differ
                    pshs      D         ; preserve the listed registers on the stack
                    lbsr      Code_3500 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_4506 ; branch when the compared values are equal
                    puls      D         ; restore the listed registers from the stack
                    bra       Code_4532 ; continue at the selected control-flow target
Code_4506           puls      D         ; restore the listed registers from the stack
Code_4508           std       Addr_0007 ; save the current value in working storage
                    sta       Addr_0009 ; save the current value in working storage
                    stb       Addr_000B ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    lda       Addr_0007 ; load the value needed by the following operation
                    adda      Addr_0041 ; add the operand to the running value
                    cmpa      #$63      ; compare against the limit and set condition flags
                    ble       Code_451D ; branch when the signed value is at or below the limit
                    lda       #$64      ; load the value needed by the following operation
Code_451D           deca                ; decrement the selected counter
                    sta       Addr_000A ; save the current value in working storage
                    lbsr      Code_0E5A ; call the referenced helper routine
                    ldd       Addr_0007 ; load the value needed by the following operation
                    lbsr      Code_0F2F ; call the referenced helper routine
                    stx       Addr_000D ; save the current value in working storage
                    lbsr      Code_094E ; call the referenced helper routine
                    puls      PC,Y,X,D  ; restore the listed registers from the stack
Code_452F           lbra      Code_45D2 ; continue at the distant control-flow target
Code_4532           lbsr      Code_3738 ; call the referenced helper routine
                    leax      $016A,U   ; form the referenced address without reading memory
                    tfr       X,Y       ; copy the source register into the destination register
Code_453B           lda       ,X+       ; fetch the next value and advance the source pointer
                    beq       Code_454D ; branch when the compared values are equal
                    cmpa      #$61      ; compare against the limit and set condition flags
                    blt       Code_453B ; branch when the signed value is below the limit
                    cmpa      #$7A      ; compare against the limit and set condition flags
                    bgt       Code_453B ; branch when the signed value is above the limit
                    suba      #$20      ; subtract the operand from the running value
                    sta       -$01,X    ; save the current value in working storage
                    bra       Code_453B ; continue at the selected control-flow target
Code_454D           ldb       #$18      ; load the value needed by the following operation
                    leax      B,Y       ; form the referenced address without reading memory
Code_4551           lda       ,-X       ; load the value needed by the following operation
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bne       Code_455A ; branch when the compared values differ
                    decb                ; decrement the selected counter
                    bra       Code_4551 ; continue at the selected control-flow target
Code_455A           stb       Addr_004C ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    sta       Addr_0020 ; save the current value in working storage
                    lda       #$63      ; load the value needed by the following operation
                    sta       Code_001E ; save the current value in working storage
                    sta       Addr_001F ; save the current value in working storage
                    ldx       Addr_0002 ; load the value needed by the following operation
Code_4567           ldd       ,X        ; load the value needed by the following operation
                    blt       Code_45C1 ; branch when the signed value is below the limit
                    cmpa      Addr_0007 ; compare against the limit and set condition flags
                    blt       Code_45B8 ; branch when the signed value is below the limit
                    bgt       Code_4575 ; branch when the signed value is above the limit
                    cmpb      Addr_0008 ; compare against the limit and set condition flags
                    ble       Code_45B8 ; branch when the signed value is at or below the limit
Code_4575           cmpa      Code_001E ; compare against the limit and set condition flags
                    bgt       Code_45B8 ; branch when the signed value is above the limit
                    blt       Code_457F ; branch when the signed value is below the limit
                    cmpb      Addr_001F ; compare against the limit and set condition flags
                    bgt       Code_45B8 ; branch when the signed value is above the limit
Code_457F           clrb                ; clear the selected byte or register
                    lda       $02,X     ; load the value needed by the following operation
                    anda      #$C0      ; mask off unwanted bits
                    beq       Code_458C ; branch when the compared values are equal
                    cmpa      #$40      ; compare against the limit and set condition flags
                    beq       Code_45B8 ; branch when the compared values are equal
                    ldb       #$0A      ; load the value needed by the following operation
Code_458C           addb      #$04      ; add the operand to the running value
                    pshs      X         ; preserve the listed registers on the stack
                    abx                 ; add the operand to the running value
                    ldb       Addr_004C ; load the value needed by the following operation
                    leay      $016A,U   ; form the referenced address without reading memory
Code_4597           lda       ,Y+       ; fetch the next value and advance the source pointer
                    cmpa      ,X+       ; compare against the limit and set condition flags
                    beq       Code_45AB ; branch when the compared values are equal
                    cmpa      #$41      ; compare against the limit and set condition flags
                    blt       Code_45B6 ; branch when the signed value is below the limit
                    cmpa      #$5A      ; compare against the limit and set condition flags
                    bgt       Code_45B6 ; branch when the signed value is above the limit
                    adda      #$20      ; add the operand to the running value
                    cmpa      -$01,X    ; compare against the limit and set condition flags
                    bne       Code_45B6 ; branch when the compared values differ
Code_45AB           decb                ; decrement the selected counter
                    bgt       Code_4597 ; branch when the signed value is above the limit
                    lda       #$01      ; load the value needed by the following operation
                    sta       Addr_0020 ; save the current value in working storage
                    ldd       [,S]      ; load the value needed by the following operation
                    std       Code_001E ; save the current value in working storage
Code_45B6           puls      X         ; restore the listed registers from the stack
Code_45B8           ldb       $02,X     ; load the value needed by the following operation
                    andb      #$3F      ; mask off unwanted bits
                    addb      #$04      ; add the operand to the running value
                    abx                 ; add the operand to the running value
                    bra       Code_4567 ; continue at the selected control-flow target
Code_45C1           tst       Addr_0020 ; set condition flags from the current value
                    beq       Code_45CD ; branch when the compared values are equal
                    lbsr      Code_374F ; call the referenced helper routine
                    ldd       Code_001E ; load the value needed by the following operation
                    lbra      Code_4508 ;45CA: 16 FF 3B       '.. ; continue at the distant control-flow target
Code_45CD           ldb       #$05      ; load the value needed by the following operation
                    lbsr      Code_0EC3 ; call the referenced helper routine
Code_45D2           tst       Addr_0006 ; set condition flags from the current value
                    bne       Code_45EC ; branch when the compared values differ
                    tst       Addr_0036 ; set condition flags from the current value
                    beq       Code_45E2 ; branch when the compared values are equal
                    lda       Addr_001F ; load the value needed by the following operation
                    adda      #$04      ; add the operand to the running value
                    sta       Addr_001F ; save the current value in working storage
                    bra       Code_45EC ; continue at the selected control-flow target
Code_45E2           lda       #$03      ; load the value needed by the following operation
                    sta       Addr_001F ; save the current value in working storage
                    lda       #$08      ; load the value needed by the following operation
                    sta       Code_001E ; save the current value in working storage
                    bsr       Code_45F3 ; call the referenced helper routine
Code_45EC           clr       Addr_0006 ; clear the selected byte or register
                    lbsr      Code_374F ; call the referenced helper routine
                    puls      PC,Y,X,D  ; restore the listed registers from the stack
Code_45F3           lda       Addr_0007 ; load the value needed by the following operation
                    pshs      A         ; preserve the listed registers on the stack
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    clrb                ; clear the selected byte or register
                    lda       Code_001E ; load the value needed by the following operation
                    asla                ; shift left and update carry
                    asla                ; shift left and update carry
                    asla                ; shift left and update carry
                    pshs      D         ; preserve the listed registers on the stack
                    tfr       D,X       ; copy the source register into the destination register
                    lda       Addr_001F ; load the value needed by the following operation
                    asla                ; shift left and update carry
                    asla                ; shift left and update carry
                    asla                ; shift left and update carry
                    pshs      A         ; preserve the listed registers on the stack
                    ldb       #$02      ; load the value needed by the following operation
                    tst       Addr_004A ; set condition flags from the current value
                    bne       Code_4614 ; branch when the compared values differ
                    aslb                ; shift left and update carry
Code_4614           tfr       D,Y       ; copy the source register into the destination register
                    lda       #$FF      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0E       ; private DeskMate service selector
                    puls      A         ; restore the listed registers from the stack
                    ldb       #$4A      ; load the value needed by the following operation
                    tfr       D,Y       ; copy the source register into the destination register
                    puls      D         ; restore the listed registers from the stack
                    addd      #Addr_0002 ; add the operand to the running value
                    tst       Addr_004A ; set condition flags from the current value
                    bne       Code_462E ; branch when the compared values differ
                    addd      #Addr_0002 ; add the operand to the running value
Code_462E           tfr       D,X       ; copy the source register into the destination register
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0E       ; private DeskMate service selector
                    ldd       Code_001E ; load the value needed by the following operation
                    pshs      D         ; preserve the listed registers on the stack
Code_4639           suba      Addr_003D ; subtract the operand from the running value
                    adda      Addr_0009 ; add the operand to the running value
                    cmpa      #$63      ; compare against the limit and set condition flags
                    bgt       Code_4646 ; branch when the signed value is above the limit
                    sta       Addr_0007 ; save the current value in working storage
                    lbsr      Code_0C8A ; call the referenced helper routine
Code_4646           inc       ,S        ; advance the selected counter
                    lda       ,S        ; load the value needed by the following operation
                    dec       $01,S     ; decrement the selected counter
                    bgt       Code_4639 ; branch when the signed value is above the limit
                    leas      $02,S     ; form the referenced address without reading memory
                    puls      A         ; restore the listed registers from the stack
                    sta       Addr_0007 ; save the current value in working storage
                    lbsr      Code_15FF ; call the referenced helper routine
                    lda       Addr_0007 ; load the value needed by the following operation
                    beq       Code_4669 ; branch when the compared values are equal
                    suba      Addr_0009 ; subtract the operand from the running value
                    adda      Addr_003D ; add the operand to the running value
                    cmpa      Code_001E ; compare against the limit and set condition flags
                    blt       Code_466C ; branch when the signed value is below the limit
                    suba      Code_001E ; subtract the operand from the running value
                    cmpa      Addr_001F ; compare against the limit and set condition flags
                    bge       Code_466C ; branch when the signed value is at least the limit
Code_4669           lbsr      Code_09EC ; call the referenced helper routine
Code_466C           rts                 ; return to the caller
Code_466D           pshs      Y,X,D     ; preserve the listed registers on the stack
                    tst       Addr_0006 ; set condition flags from the current value
                    bne       Code_4683 ; branch when the compared values differ
                    ldx       Addr_000D ; load the value needed by the following operation
                    bne       Code_4683 ; branch when the compared values differ
                    puls      PC,Y,X,D  ; restore the listed registers from the stack
Code_4679           tst       Addr_004A ; set condition flags from the current value
                    bne       Code_467E ; branch when the compared values differ
                    aslb                ; shift left and update carry
Code_467E           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_4683           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    leax      Data_49BF,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    ldd       #Data_0905 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    leax      Data_49C7,PCR ; form the referenced address without reading memory
                    ldb       #$07      ; load the value needed by the following operation
                    lbsr      Code_0EB7 ; call the referenced helper routine
                    ldd       #Addr_480E ; load the value needed by the following operation
                    leax      Data_4A05,PCR ; form the referenced address without reading memory
                    bsr       Code_4679 ; call the referenced helper routine
                    ldb       #$15      ; load the value needed by the following operation
                    leax      Data_4A77,PCR ; form the referenced address without reading memory
                    bsr       Code_4679 ; call the referenced helper routine
                    ldd       #Code_0D06 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      Data_49D6,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    ldd       #Data_0E06 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    lda       #$01      ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    lda       #$03      ; load the value needed by the following operation
                    sta       Addr_004C ; save the current value in working storage
                    lda       #$06      ; load the value needed by the following operation
                    sta       Code_004D ; save the current value in working storage
                    tst       Addr_0006 ; set condition flags from the current value
                    bne       Code_4705 ; branch when the compared values differ
                    ldx       Addr_000D ; load the value needed by the following operation
                    lda       $03,X     ; load the value needed by the following operation
                    bpl       Code_46E9 ; branch while the tested value is nonnegative
                    lda       #$01      ; load the value needed by the following operation
                    sta       Addr_004C ; save the current value in working storage
                    ldb       #$0E      ; load the value needed by the following operation
                    bra       Code_46EF ; continue at the selected control-flow target
Code_46E9           lda       #$02      ; load the value needed by the following operation
                    sta       Addr_004C ; save the current value in working storage
                    ldb       #$15      ; load the value needed by the following operation
Code_46EF           lda       #$09      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    ldy       #Addr_0004 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "$"                            ; embedded text or resource bytes
                    ldx       Addr_000D ; load the value needed by the following operation
                    lda       $02,X     ; load the value needed by the following operation
                    anda      #$C0      ; mask off unwanted bits
                    beq       Code_4764 ; branch when the compared values are equal
Code_4705           ldd       #Code_0B05 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    leax      Data_49CE,PCR ; form the referenced address without reading memory
                    ldb       #$08      ; load the value needed by the following operation
                    lbsr      Code_0EB7 ; call the referenced helper routine
                    ldd       #Data_580E ; load the value needed by the following operation
                    leax      Data_4AE9,PCR ; form the referenced address without reading memory
                    lbsr      Code_4679 ; call the referenced helper routine
                    ldb       #$11      ; load the value needed by the following operation
                    leax      $3C,X     ; form the referenced address without reading memory
                    lbsr      Code_4679 ; call the referenced helper routine
                    ldb       #$14      ; load the value needed by the following operation
                    leax      $3C,X     ; form the referenced address without reading memory
                    lbsr      Code_4679 ; call the referenced helper routine
                    ldb       #$17      ; load the value needed by the following operation
                    leax      $3C,X     ; form the referenced address without reading memory
                    lbsr      Code_4679 ; call the referenced helper routine
                    ldb       #$1A      ; load the value needed by the following operation
                    leax      $3C,X     ; form the referenced address without reading memory
                    lbsr      Code_4679 ; call the referenced helper routine
                    tst       Addr_0006 ; set condition flags from the current value
                    bne       Code_4760 ; branch when the compared values differ
                    ldx       Addr_000D ; load the value needed by the following operation
                    ldb       $03,X     ; load the value needed by the following operation
                    andb      #$07      ; mask off unwanted bits
                    incb                ; advance the selected counter
                    stb       Code_004D ; save the current value in working storage
                    decb                ; decrement the selected counter
                    lda       #$03      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    addb      #$0E      ; add the operand to the running value
                    lda       #$0B      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    ldy       #Addr_0002 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "$"                            ; embedded text or resource bytes
Code_4760           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $16       ; private DeskMate service selector
Code_4764           leax      Data_499B,PCR ; form the referenced address without reading memory
                    tst       Addr_004A ; set condition flags from the current value
                    beq       Code_4770 ; branch when the compared values are equal
                    leax      Data_49AD,PCR ; form the referenced address without reading memory
Code_4770           lda       #$FF      ; load the value needed by the following operation
                    sta       ,X        ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $13       ; private DeskMate service selector
Code_4778           lda       #$03      ; load the value needed by the following operation
                    ldb       Addr_004C ; load the value needed by the following operation
                    leax      Data_49EE,PCR ; form the referenced address without reading memory
                    lbsr      Code_488D ; call the referenced helper routine
                    cmpa      #$05      ; compare against the limit and set condition flags
                    lbeq      Code_4824 ; take the distant branch when values are equal
                    stb       Addr_004C ; save the current value in working storage
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    beq       Code_47F5 ; branch when the compared values are equal
                    cmpa      #$0C      ; compare against the limit and set condition flags
                    beq       Code_4778 ; branch when the compared values are equal
                    tst       Addr_0006 ; set condition flags from the current value
                    bne       Code_479F ; branch when the compared values differ
                    ldx       Addr_000D ; load the value needed by the following operation
                    lda       $02,X     ; load the value needed by the following operation
                    anda      #$C0      ; mask off unwanted bits
                    beq       Code_4778 ; branch when the compared values are equal
Code_479F           leax      Data_499B,PCR ; form the referenced address without reading memory
                    tst       Addr_004A ; set condition flags from the current value
                    beq       Code_47AB ; branch when the compared values are equal
                    leax      Data_49AD,PCR ; form the referenced address without reading memory
Code_47AB           clra                ; clear the selected byte or register
                    sta       ,X        ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $13       ; private DeskMate service selector
                    leax      Data_49A4,PCR ; form the referenced address without reading memory
                    tst       Addr_004A ; set condition flags from the current value
                    beq       Code_47BE ; branch when the compared values are equal
                    leax      Data_49B6,PCR ; form the referenced address without reading memory
Code_47BE           lda       #$FF      ; load the value needed by the following operation
                    sta       ,X        ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $13       ; private DeskMate service selector
Code_47C6           lda       #$06      ; load the value needed by the following operation
                    ldb       Code_004D ; load the value needed by the following operation
                    leax      Data_49F5,PCR ; form the referenced address without reading memory
                    lbsr      Code_488D ; call the referenced helper routine
                    stb       Code_004D ; save the current value in working storage
                    cmpa      #$0C      ; compare against the limit and set condition flags
                    bne       Code_47ED ; branch when the compared values differ
                    leax      Data_49A4,PCR ; form the referenced address without reading memory
                    tst       Addr_004A ; set condition flags from the current value
                    beq       Code_47E3 ; branch when the compared values are equal
                    leax      Data_49B6,PCR ; form the referenced address without reading memory
Code_47E3           clra                ; clear the selected byte or register
                    sta       ,X        ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $13       ; private DeskMate service selector
                    lbra      Code_4764 ; continue at the distant control-flow target
Code_47ED           cmpa      #$05      ; compare against the limit and set condition flags
                    beq       Code_4824 ; branch when the compared values are equal
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    bne       Code_47C6 ; branch when the compared values differ
Code_47F5           tst       Addr_0006 ; set condition flags from the current value
                    bne       Code_4848 ; branch when the compared values differ
                    ldx       Addr_000D ; load the value needed by the following operation
                    ldb       Addr_004C ; load the value needed by the following operation
                    cmpb      #$02      ; compare against the limit and set condition flags
                    beq       Code_480B ; branch when the compared values are equal
                    bgt       Code_4813 ; branch when the signed value is above the limit
                    ldb       $03,X     ; load the value needed by the following operation
                    orb       #$80      ; set the selected flag bits
                    stb       $03,X     ; save the current value in working storage
                    bra       Code_4813 ; continue at the selected control-flow target
Code_480B           ldx       Addr_000D ; load the value needed by the following operation
                    ldb       $03,X     ; load the value needed by the following operation
                    andb      #$7F      ; mask off unwanted bits
                    stb       $03,X     ; save the current value in working storage
Code_4813           ldb       Code_004D ; load the value needed by the following operation
                    cmpb      #$06      ; compare against the limit and set condition flags
                    beq       Code_4824 ; branch when the compared values are equal
                    lda       $03,X     ; load the value needed by the following operation
                    anda      #$F8      ; mask off unwanted bits
                    decb                ; decrement the selected counter
                    pshs      B         ; preserve the listed registers on the stack
                    ora       ,S+       ; set the selected flag bits
                    sta       $03,X     ; save the current value in working storage
Code_4824           lda       #$05      ; load the value needed by the following operation
                    sta       Addr_001F ; save the current value in working storage
                    tst       Addr_0006 ; set condition flags from the current value
                    beq       Code_4830 ; branch when the compared values are equal
                    clr       Addr_0006 ; clear the selected byte or register
                    bra       Code_4846 ; continue at the selected control-flow target
Code_4830           lda       Addr_0007 ; load the value needed by the following operation
                    suba      Addr_0009 ; subtract the operand from the running value
                    cmpa      #$0C      ; compare against the limit and set condition flags
                    blt       Code_4846 ; branch when the signed value is below the limit
                    lbsr      Code_15FF ; call the referenced helper routine
                    lbsr      Code_166E ; call the referenced helper routine
                    ldx       Addr_000D ; load the value needed by the following operation
                    lbsr      Code_0B62 ; call the referenced helper routine
                    lbsr      Code_09EC ; call the referenced helper routine
Code_4846           puls      PC,Y,X,D  ; restore the listed registers from the stack
Code_4848           clr       Addr_0006 ; clear the selected byte or register
                    lda       Addr_004C ; load the value needed by the following operation
                    sta       Code_001E ; save the current value in working storage
                    lda       Code_004D ; load the value needed by the following operation
                    sta       Addr_001F ; save the current value in working storage
                    ldx       Addr_0002 ; load the value needed by the following operation
Code_4854           ldd       ,X        ; load the value needed by the following operation
                    blt       Code_4846 ; branch when the signed value is below the limit
                    std       Addr_004C ; save the current value in working storage
                    lbsr      Code_2747 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_4887 ; branch when the compared values are equal
                    lda       Code_001E ; load the value needed by the following operation
                    cmpa      #$02      ; compare against the limit and set condition flags
                    bgt       Code_4876 ; branch when the signed value is above the limit
                    beq       Code_4870 ; branch when the compared values are equal
                    ldb       $03,X     ; load the value needed by the following operation
                    orb       #$80      ; set the selected flag bits
                    stb       $03,X     ; save the current value in working storage
                    bra       Code_4876 ; continue at the selected control-flow target
Code_4870           ldb       $03,X     ; load the value needed by the following operation
                    andb      #$7F      ; mask off unwanted bits
                    stb       $03,X     ; save the current value in working storage
Code_4876           lda       Addr_001F ; load the value needed by the following operation
                    cmpa      #$06      ; compare against the limit and set condition flags
                    beq       Code_4887 ; branch when the compared values are equal
                    ldb       $03,X     ; load the value needed by the following operation
                    andb      #$F8      ; mask off unwanted bits
                    deca                ; decrement the selected counter
                    pshs      A         ; preserve the listed registers on the stack
                    orb       ,S+       ; set the selected flag bits
                    stb       $03,X     ; save the current value in working storage
Code_4887           lbsr      Code_0FB0 ; call the referenced helper routine
                    abx                 ; add the operand to the running value
                    bra       Code_4854 ; continue at the selected control-flow target
Code_488D           pshs      X,D       ; preserve the listed registers on the stack
Code_488F           ldb       #$80      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    beq       Code_48D0 ; branch when the compared values are equal
                    cmpa      #$0A      ; compare against the limit and set condition flags
                    beq       Code_48C6 ; branch when the compared values are equal
                    cmpa      #$0C      ; compare against the limit and set condition flags
                    beq       Code_48C6 ; branch when the compared values are equal
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    beq       Code_48C6 ; branch when the compared values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    beq       Code_48C6 ; branch when the compared values are equal
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bne       Code_488F ; branch when the compared values differ
Code_48AB           ldx       $02,S     ; load the value needed by the following operation
                    ldb       $01,S     ; load the value needed by the following operation
                    lbsr      Code_4957 ; call the referenced helper routine
                    ldb       $01,S     ; load the value needed by the following operation
                    cmpb      ,S        ; compare against the limit and set condition flags
                    bne       Code_48BC ; branch when the compared values differ
                    ldb       #$01      ; load the value needed by the following operation
                    bra       Code_48BD ; continue at the selected control-flow target
Code_48BC           incb                ; advance the selected counter
Code_48BD           stb       $01,S     ; save the current value in working storage
                    ldx       $02,S     ; load the value needed by the following operation
                    lbsr      Code_4957 ; call the referenced helper routine
                    bra       Code_488F ; continue at the selected control-flow target
Code_48C6           leas      $01,S     ; form the referenced address without reading memory
                    puls      PC,X,B    ; restore the listed registers from the stack
Code_48CA           leay      ,Y        ; form the referenced address without reading memory
                    beq       Code_488F ; branch when the compared values are equal
                    bra       Code_48AB ; continue at the selected control-flow target
Code_48D0           pshs      U,X       ; preserve the listed registers on the stack
                    lbsr      Code_4975 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    tfr       D,Y       ; copy the source register into the destination register
                    tfr       U,D       ; copy the source register into the destination register
                    puls      U,X       ; restore the listed registers from the stack
                    cmpa      #$09      ; compare against the limit and set condition flags
                    blt       Code_494A ; branch when the signed value is below the limit
                    cmpa      #$0E      ; compare against the limit and set condition flags
                    bgt       Code_494A ; branch when the signed value is above the limit
                    cmpb      #$04      ; compare against the limit and set condition flags
                    blt       Code_494A ; branch when the signed value is below the limit
                    cmpb      #$1B      ; compare against the limit and set condition flags
                    bgt       Code_494A ; branch when the signed value is above the limit
                    cmpa      $02,X     ; compare against the limit and set condition flags
                    beq       Code_48FD ; branch when the compared values are equal
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    beq       Code_48CA ; branch when the compared values are equal
                    bgt       Code_4946 ; branch when the signed value is above the limit
                    deca                ; decrement the selected counter
                    cmpa      $02,X     ; compare against the limit and set condition flags
                    blt       Code_4941 ; branch when the signed value is below the limit
                    bgt       Code_493D ; branch when the signed value is above the limit
Code_48FD           lda       #$01      ; load the value needed by the following operation
Code_48FF           cmpb      ,X        ; compare against the limit and set condition flags
                    blt       Code_490B ; branch when the signed value is below the limit
                    cmpb      $01,X     ; compare against the limit and set condition flags
                    bgt       Code_490B ; branch when the signed value is above the limit
                    sta       Code_0039 ; save the current value in working storage
                    bra       Code_491D ; continue at the selected control-flow target
Code_490B           leax      $03,X     ; form the referenced address without reading memory
                    inca                ; advance the selected counter
                    pshs      B         ; preserve the listed registers on the stack
                    ldb       ,X        ; load the value needed by the following operation
                    cmpb      #$FF      ; compare against the limit and set condition flags
                    puls      B         ; restore the listed registers from the stack
                    bne       Code_48FF ; branch when the compared values differ
                    ldx       $02,S     ; load the value needed by the following operation
Code_491A           lbra      Code_488F ; continue at the distant control-flow target
Code_491D           ldx       $02,S     ; load the value needed by the following operation
                    leay      ,Y        ; form the referenced address without reading memory
                    beq       Code_491A ; branch when the compared values are equal
                    ldb       $01,S     ; load the value needed by the following operation
                    bsr       Code_4957 ; call the referenced helper routine
                    ldx       $02,S     ; load the value needed by the following operation
                    ldb       Code_0039 ; load the value needed by the following operation
                    cmpb      $01,S     ; compare against the limit and set condition flags
                    beq       Code_4937 ; branch when the compared values are equal
                    stb       $01,S     ; save the current value in working storage
                    bsr       Code_4957 ; call the referenced helper routine
                    ldx       $02,S     ; load the value needed by the following operation
                    bra       Code_491A ; continue at the selected control-flow target
Code_4937           lda       ,S        ; load the value needed by the following operation
                    sta       $01,S     ; save the current value in working storage
                    bra       Code_491A ; continue at the selected control-flow target
Code_493D           lda       #$0A      ; load the value needed by the following operation
                    bra       Code_48C6 ; continue at the selected control-flow target
Code_4941           lda       #$0C      ; load the value needed by the following operation
                    lbra      Code_48C6 ; continue at the distant control-flow target
Code_4946           lda       #$0D      ; load the value needed by the following operation
                    bra       Code_494C ; continue at the selected control-flow target
Code_494A           lda       #$05      ; load the value needed by the following operation
Code_494C           leay      ,Y        ; form the referenced address without reading memory
Code_494E           beq       Code_491A ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    lbra      Code_48C6 ; continue at the distant control-flow target
Code_4957           decb                ; decrement the selected counter
                    lda       #$03      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    abx                 ; add the operand to the running value
                    lda       ,X        ; load the value needed by the following operation
                    blt       Code_4974 ; branch when the signed value is below the limit
                    ldb       $02,X     ; load the value needed by the following operation
                    exg       A,B       ; exchange the two register values
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    ldb       $01,X     ; load the value needed by the following operation
                    subb      ,X        ; subtract the operand from the running value
                    incb                ; advance the selected counter
                    clra                ; clear the selected byte or register
                    tfr       D,Y       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "$"                            ; embedded text or resource bytes
Code_4974           rts                 ; return to the caller
Code_4975           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $19       ; private DeskMate service selector
                    tst       Addr_004A ; set condition flags from the current value
                    bne       Code_4986 ; branch when the compared values differ
                    pshs      D         ; preserve the listed registers on the stack
                    tfr       U,D       ; copy the source register into the destination register
                    lsrb                ; shift right and expose the low bit through carry
                    tfr       D,U       ; copy the source register into the destination register
                    puls      D         ; restore the listed registers from the stack
Code_4986           rts                 ; return to the caller
Data_4987           fcb       $00,$04,$08 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $03,$00   ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $18       ; table, bitmap, or initialized data bytes
                    fcc       "Dest."                        ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_4995           fcc       "Find "                        ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_499B           fcb       $FF,$00   ; table, bitmap, or initialized data bytes
                    fcc       "D"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "F"                            ; embedded text or resource bytes
                    fcb       $01,$C0,$00 ; table, bitmap, or initialized data bytes
                    fcc       "R"                            ; embedded text or resource bytes
Data_49A4           fcb       $FF,$00   ; table, bitmap, or initialized data bytes
                    fcc       "D"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "V"                            ; embedded text or resource bytes
                    fcb       $01,$C2,$00 ; table, bitmap, or initialized data bytes
                    fcc       "b"                            ; embedded text or resource bytes
Data_49AD           fcb       $FF,$00,$22,$00 ; table, bitmap, or initialized data bytes
                    fcc       "F"                            ; embedded text or resource bytes
                    fcb       $00,$E0,$00 ; table, bitmap, or initialized data bytes
                    fcc       "R"                            ; embedded text or resource bytes
Data_49B6           fcb       $FF,$00,$22,$00 ; table, bitmap, or initialized data bytes
                    fcc       "V"                            ; embedded text or resource bytes
                    fcb       $00,$EC,$00 ; table, bitmap, or initialized data bytes
                    fcc       "b"                            ; embedded text or resource bytes
Data_49BF           fcb       $00,$03,$08,$1D,$08,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $18       ; table, bitmap, or initialized data bytes
Data_49C7           fcc       "Justify"                      ; embedded text or resource bytes
Data_49CE           fcc       "Fraction"                     ; embedded text or resource bytes
Data_49D6           fcc       "Press [SPACE] to choo"        ; embedded text or resource bytes
                    fcc       "se"                           ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_49EE           fcb       $0E,$11,$09,$15,$18,$09 ; table, bitmap, or initialized data bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
Data_49F5           fcb       $0E,$0F,$0B,$11,$12,$0B ; table, bitmap, or initialized data bytes
                    fcb       $14,$15,$0B,$17,$18,$0B ; table, bitmap, or initialized data bytes
                    fcb       $1A,$1B,$0B,$FF ; table, bitmap, or initialized data bytes
Data_4A05           fcc       "("                            ; embedded text or resource bytes
                    fcb       $08,$09,$0F,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$F0,$0F,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$F0 ; table, bitmap, or initialized data bytes
                    fcb       $0F,$00,$0F,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$F0,$0F,$00,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$00,$00,$F0,$0F,$0F ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$00,$00,$F0 ; table, bitmap, or initialized data bytes
                    fcb       $0F,$00,$FF,$FF,$FF,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$F0,$0F,$00,$0F,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$F0,$0F,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$F0 ; table, bitmap, or initialized data bytes
                    fcb       $0F,$FF,$FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $04,$09   ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FF,$FF,$FC ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $00,$00,$0C ; table, bitmap, or initialized data bytes
                    fcc       "00"                           ; embedded text or resource bytes
                    fcb       $00,$0C   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $FF,$F0,$0C ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $FF,$F0,$0C ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $FF,$F0,$0C ; table, bitmap, or initialized data bytes
                    fcc       "00"                           ; embedded text or resource bytes
                    fcb       $00,$0C   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $00,$00,$0C ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FF,$FF,$FC ; table, bitmap, or initialized data bytes
Data_4A77           fcc       "("                            ; embedded text or resource bytes
                    fcb       $08,$09,$0F,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$F0,$0F,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$F0 ; table, bitmap, or initialized data bytes
                    fcb       $0F,$00,$00,$00,$00,$F0 ; table, bitmap, or initialized data bytes
                    fcb       $00,$F0,$0F,$00,$00,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$00,$F0,$0F,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$FF,$FF,$FF,$F0,$F0 ; table, bitmap, or initialized data bytes
                    fcb       $0F,$00,$00,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $00,$F0,$0F,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$F0,$00,$F0,$0F,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$F0 ; table, bitmap, or initialized data bytes
                    fcb       $0F,$FF,$FF,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $04,$09   ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FF,$FF,$FC ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $00,$00,$0C ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $00,$0C,$0C ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $0F,$FF,$0C ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $0F,$FF,$CC ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $0F,$FF,$0C ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $00,$0C,$0C ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $00,$00,$0C ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FF,$FF,$FC ; table, bitmap, or initialized data bytes
Data_4AE9           fcc       "("                            ; embedded text or resource bytes
                    fcb       $04,$09   ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FF,$FF,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$00,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $0F,$C0,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<<"                           ; embedded text or resource bytes
                    fcb       $F0,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "<<"                           ; embedded text or resource bytes
                    fcb       $F0,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "<<"                           ; embedded text or resource bytes
                    fcb       $F0,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $0F,$C0,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$00,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FF,$FF,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $02,$09,$7F,$FC ; table, bitmap, or initialized data bytes
                    fcc       "`"                            ; embedded text or resource bytes
                    fcb       $0C       ; table, bitmap, or initialized data bytes
                    fcc       "c"                            ; embedded text or resource bytes
                    fcb       $8C       ; table, bitmap, or initialized data bytes
                    fcc       "f"                            ; embedded text or resource bytes
                    fcb       $CC       ; table, bitmap, or initialized data bytes
                    fcc       "f"                            ; embedded text or resource bytes
                    fcb       $CC       ; table, bitmap, or initialized data bytes
                    fcc       "f"                            ; embedded text or resource bytes
                    fcb       $CC       ; table, bitmap, or initialized data bytes
                    fcc       "c"                            ; embedded text or resource bytes
                    fcb       $8C       ; table, bitmap, or initialized data bytes
                    fcc       "`"                            ; embedded text or resource bytes
                    fcb       $0C,$7F,$FC ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $04,$09   ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FF,$FF,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$00,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $03,$C0,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $0F,$C0,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $03,$C0,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $03,$C0,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $0F,$F0,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$00,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FF,$FF,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $02,$09,$7F,$FC ; table, bitmap, or initialized data bytes
                    fcc       "`"                            ; embedded text or resource bytes
                    fcb       $0C       ; table, bitmap, or initialized data bytes
                    fcc       "a"                            ; embedded text or resource bytes
                    fcb       $8C       ; table, bitmap, or initialized data bytes
                    fcc       "c"                            ; embedded text or resource bytes
                    fcb       $8C       ; table, bitmap, or initialized data bytes
                    fcc       "a"                            ; embedded text or resource bytes
                    fcb       $8C       ; table, bitmap, or initialized data bytes
                    fcc       "a"                            ; embedded text or resource bytes
                    fcb       $8C       ; table, bitmap, or initialized data bytes
                    fcc       "c"                            ; embedded text or resource bytes
                    fcb       $CC       ; table, bitmap, or initialized data bytes
                    fcc       "`"                            ; embedded text or resource bytes
                    fcb       $0C,$7F,$FC ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $04,$09   ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FF,$FF,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$00,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<?"                           ; embedded text or resource bytes
                    fcb       $C0,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$F0,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $0F,$C0,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<<"                           ; embedded text or resource bytes
                    fcb       $00,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "<?"                           ; embedded text or resource bytes
                    fcb       $F0,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$00,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FF,$FF,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $02,$09,$7F,$FC ; table, bitmap, or initialized data bytes
                    fcc       "`"                            ; embedded text or resource bytes
                    fcb       $0C       ; table, bitmap, or initialized data bytes
                    fcc       "g"                            ; embedded text or resource bytes
                    fcb       $8C       ; table, bitmap, or initialized data bytes
                    fcc       "`"                            ; embedded text or resource bytes
                    fcb       $CC       ; table, bitmap, or initialized data bytes
                    fcc       "c"                            ; embedded text or resource bytes
                    fcb       $8C       ; table, bitmap, or initialized data bytes
                    fcc       "f"                            ; embedded text or resource bytes
                    fcb       $0C       ; table, bitmap, or initialized data bytes
                    fcc       "g"                            ; embedded text or resource bytes
                    fcb       $CC       ; table, bitmap, or initialized data bytes
                    fcc       "`"                            ; embedded text or resource bytes
                    fcb       $0C,$7F,$FC ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $04,$09   ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FF,$FF,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$00,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<?"                           ; embedded text or resource bytes
                    fcb       $C0,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$F0,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $0F,$F0,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$F0,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<?"                           ; embedded text or resource bytes
                    fcb       $C0,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$00,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FF,$FF,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $02,$09,$7F,$FC ; table, bitmap, or initialized data bytes
                    fcc       "`"                            ; embedded text or resource bytes
                    fcb       $0C       ; table, bitmap, or initialized data bytes
                    fcc       "g"                            ; embedded text or resource bytes
                    fcb       $8C       ; table, bitmap, or initialized data bytes
                    fcc       "`"                            ; embedded text or resource bytes
                    fcb       $CC       ; table, bitmap, or initialized data bytes
                    fcc       "c"                            ; embedded text or resource bytes
                    fcb       $CC       ; table, bitmap, or initialized data bytes
                    fcc       "`"                            ; embedded text or resource bytes
                    fcb       $CC       ; table, bitmap, or initialized data bytes
                    fcc       "g"                            ; embedded text or resource bytes
                    fcb       $8C       ; table, bitmap, or initialized data bytes
                    fcc       "`"                            ; embedded text or resource bytes
                    fcb       $0C,$7F,$FC ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $04,$09   ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FF,$FF,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$00,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<<"                           ; embedded text or resource bytes
                    fcb       $F0,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "<<"                           ; embedded text or resource bytes
                    fcb       $F0,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "<?"                           ; embedded text or resource bytes
                    fcb       $F0,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$F0,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$F0,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $00,$00,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FF,$FF,$F0 ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
Data_4C01           fcb       $02       ; table, bitmap, or initialized data bytes
Data_4C02           fcb       $09,$7F,$FC ; table, bitmap, or initialized data bytes
                    fcc       "`"                            ; embedded text or resource bytes
                    fcb       $0C       ; table, bitmap, or initialized data bytes
                    fcc       "f"                            ; embedded text or resource bytes
                    fcb       $CC       ; table, bitmap, or initialized data bytes
                    fcc       "f"                            ; embedded text or resource bytes
                    fcb       $CC       ; table, bitmap, or initialized data bytes
                    fcc       "g"                            ; embedded text or resource bytes
                    fcb       $CC       ; table, bitmap, or initialized data bytes
                    fcc       "`"                            ; embedded text or resource bytes
                    fcb       $CC       ; table, bitmap, or initialized data bytes
                    fcc       "`"                            ; embedded text or resource bytes
                    fcb       $CC       ; table, bitmap, or initialized data bytes
                    fcc       "`"                            ; embedded text or resource bytes
                    fcb       $0C,$7F,$FC ; table, bitmap, or initialized data bytes
Code_4C15           pshs      U,Y,X,DP,D ; preserve the listed registers on the stack
                    bsr       Code_4C87 ; call the referenced helper routine
                    lda       ,S        ; load the value needed by the following operation
                    sta       Addr_0013 ; save the current value in working storage
                    leay      $0A,U     ; form the referenced address without reading memory
                    ldb       #$07      ; load the value needed by the following operation
Code_4C21           lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,Y+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bgt       Code_4C21 ; branch when the signed value is above the limit
                    clr       Code_0018 ; clear the selected byte or register
                    clr       Addr_0019 ; clear the selected byte or register
                    clr       start     ; clear the selected byte or register
                    clr       Addr_001A ; clear the selected byte or register
                    ldb       Addr_000E ; load the value needed by the following operation
                    cmpb      Addr_000C ; compare against the limit and set condition flags
                    bls       Code_4C3E ; branch when the unsigned value is at or below the limit
                    com       start     ; invert every bit in the selected value
                    dec       Addr_000C ; decrement the selected counter
                    dec       Addr_000C ; decrement the selected counter
                    inc       Addr_0010 ; advance the selected counter
Code_4C3E           clr       Addr_0011 ; clear the selected byte or register
                    clr       Addr_0017 ; clear the selected byte or register
                    lda       Addr_0013 ; load the value needed by the following operation
                    suba      Addr_000C ; subtract the operand from the running value
                    bcs       Code_4C4D ; branch when carry reports an unsigned underflow or error
                    inca                ; advance the selected counter
                    sta       Addr_0011 ; save the current value in working storage
                    sta       Addr_0017 ; save the current value in working storage
Code_4C4D           ldb       Addr_0013 ; load the value needed by the following operation
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
                    clr       Addr_0016 ; clear the selected byte or register
Code_4C64           ldb       Addr_0010 ; load the value needed by the following operation
                    addb      Addr_0016 ; add the operand to the running value
                    bsr       Code_4C94 ; call the referenced helper routine
                    lda       Addr_0017 ; load the value needed by the following operation
                    lbsr      Code_4CA0 ; call the referenced helper routine
                    inc       Addr_0016 ; advance the selected counter
                    lda       Addr_0016 ; load the value needed by the following operation
                    cmpa      Addr_000C ; compare against the limit and set condition flags
                    beq       Code_4C7F ; branch when the compared values are equal
                    inc       Addr_0017 ; advance the selected counter
                    lda       Addr_0017 ; load the value needed by the following operation
                    cmpa      Addr_000E ; compare against the limit and set condition flags
                    bne       Code_4C64 ; branch when the compared values differ
Code_4C7F           lbsr      Code_4CAF ; call the referenced helper routine
                    lbsr      Code_4CBD ; call the referenced helper routine
                    puls      PC,U,Y,X,DP,D ; restore the listed registers from the stack
Code_4C87           pshs      D         ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "/"                            ; embedded text or resource bytes
                    tfr       A,DP      ; copy the source register into the destination register
                    clrb                ; clear the selected byte or register
                    tfr       D,U       ; copy the source register into the destination register
                    puls      PC,D      ; restore the listed registers from the stack
Code_4C94           clra                ; clear the selected byte or register
                    tfr       D,Y       ; copy the source register into the destination register
                    ldb       Addr_000F ; load the value needed by the following operation
                    tfr       D,X       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_4CA0           ldx       Addr_000A ; load the value needed by the following operation
                    asla                ; shift left and update carry
                    ldx       A,X       ; load the value needed by the following operation
                    clra                ; clear the selected byte or register
                    ldb       ,X+       ; fetch the next value and advance the source pointer
                    andb      #$80      ; mask off unwanted bits
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_4CAF           ldb       Addr_0014 ; load the value needed by the following operation
                    bsr       Code_4C94 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    ldb       Addr_000D ; load the value needed by the following operation
                    tfr       D,Y       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "$"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_4CBD           tst       start     ; set condition flags from the current value
                    beq       Code_4CF7 ; branch when the compared values are equal
                    ldb       Addr_0010 ; load the value needed by the following operation
                    decb                ; decrement the selected counter
                    bsr       Code_4CF8 ; call the referenced helper routine
                    tst       Addr_0011 ; set condition flags from the current value
                    beq       Code_4CD8 ; branch when the compared values are equal
                    leax      Data_5053,PCR ; form the referenced address without reading memory
                    tst       Code_0018 ; set condition flags from the current value
                    beq       Code_4CD4 ; branch when the compared values are equal
                    leax      $03,X     ; form the referenced address without reading memory
Code_4CD4           bsr       Code_4D08 ; call the referenced helper routine
                    bra       Code_4CDC ; continue at the selected control-flow target
Code_4CD8           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "A"                            ; embedded text or resource bytes
Code_4CDC           ldb       Addr_001D ; load the value needed by the following operation
                    incb                ; advance the selected counter
                    bsr       Code_4CF8 ; call the referenced helper routine
                    ldb       Addr_0011 ; load the value needed by the following operation
                    cmpb      Addr_0012 ; compare against the limit and set condition flags
                    beq       Code_4CF3 ; branch when the compared values are equal
                    leax      Data_5059,PCR ; form the referenced address without reading memory
                    tst       Addr_0019 ; set condition flags from the current value
                    beq       Code_4CF1 ; branch when the compared values are equal
                    leax      $03,X     ; form the referenced address without reading memory
Code_4CF1           bra       Code_4D08 ; continue at the selected control-flow target
Code_4CF3           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "A"                            ; embedded text or resource bytes
Code_4CF7           rts                 ; return to the caller
Code_4CF8           clra                ; clear the selected byte or register
                    tfr       D,Y       ; copy the source register into the destination register
                    ldb       Addr_000D ; load the value needed by the following operation
                    lsrb                ; shift right and expose the low bit through carry
                    addb      Addr_000F ; add the operand to the running value
                    decb                ; decrement the selected counter
                    tfr       D,X       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_4D08           pshs      X         ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1F       ; private DeskMate service selector
                    pshs      Y         ; preserve the listed registers on the stack
                    leax      Data_4FD3,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $06       ; private DeskMate service selector
                    ldx       $02,S     ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
                    puls      Y,X       ; restore the listed registers from the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $03       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_4D25           pshs      U,Y,X,DP,D ; preserve the listed registers on the stack
                    lbsr      Code_4C87 ; call the referenced helper routine
                    clr       Code_0018 ; clear the selected byte or register
                    clr       Addr_0019 ; clear the selected byte or register
                    clr       Addr_0033 ; clear the selected byte or register
                    ldb       #$80      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    sta       Code_001C ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $18       ; private DeskMate service selector
                    tsta                ; set condition flags from the current value
                    lbeq      Code_4D8A ; take the distant branch when values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "E"                            ; embedded text or resource bytes
                    stb       Addr_0033 ; save the current value in working storage
                    stx       Code_0034 ; save the current value in working storage
                    sty       Addr_0036 ; save the current value in working storage
                    cmpb      #$01      ; compare against the limit and set condition flags
                    bne       Code_4D5C ; branch when the compared values differ
                    lda       #$0D      ; load the value needed by the following operation
                    cmpy      #Addr_00FF ; compare against the limit and set condition flags
                    bne       Code_4D5A ; branch when the compared values differ
                    lda       #$05      ; load the value needed by the following operation
Code_4D5A           sta       Code_001C ; save the current value in working storage
Code_4D5C           tfr       Y,D       ; copy the source register into the destination register
                    cmpb      #$FF      ; compare against the limit and set condition flags
                    beq       Code_4D8A ; branch when the compared values are equal
                    stb       Addr_001B ; save the current value in working storage
                    cmpb      Addr_0010 ; compare against the limit and set condition flags
                    bcs       Code_4DC7 ; branch when carry reports an unsigned underflow or error
                    cmpb      Addr_001D ; compare against the limit and set condition flags
                    bhi       Code_4DC7 ; branch when the unsigned value is above the limit
                    cmpb      Addr_0014 ; compare against the limit and set condition flags
                    beq       Code_4DBF ; branch when the compared values are equal
Code_4D70           subb      Addr_0010 ; subtract the operand from the running value
                    addb      Addr_0011 ; add the operand to the running value
                    cmpb      Addr_000E ; compare against the limit and set condition flags
                    bcc       Code_4DBF ; branch when carry is clear
                    pshs      B         ; preserve the listed registers on the stack
                    lbsr      Code_4CAF ; call the referenced helper routine
                    lda       ,S+       ; load the value needed by the following operation
                    ldb       Addr_001B ; load the value needed by the following operation
                    stb       Addr_0014 ; save the current value in working storage
                    sta       Addr_0013 ; save the current value in working storage
                    lbsr      Code_4CAF ; call the referenced helper routine
                    bra       Code_4DBC ; continue at the selected control-flow target
Code_4D8A           lda       Code_001C ; load the value needed by the following operation
                    cmpa      #$0C      ; compare against the limit and set condition flags
                    beq       Code_4D9C ; branch when the compared values are equal
                    cmpa      #$0A      ; compare against the limit and set condition flags
                    beq       Code_4DAA ; branch when the compared values are equal
                    tst       Addr_001A ; set condition flags from the current value
                    beq       Code_4DBF ; branch when the compared values are equal
                    clr       Addr_001A ; clear the selected byte or register
                    bra       Code_4DBC ; continue at the selected control-flow target
Code_4D9C           ldb       Addr_0014 ; load the value needed by the following operation
                    cmpb      Addr_0010 ; compare against the limit and set condition flags
                    lbeq      Code_4E02 ; take the distant branch when values are equal
                    decb                ; decrement the selected counter
                    stb       Addr_001B ; save the current value in working storage
                    lbra      Code_4D70 ; continue at the distant control-flow target
Code_4DAA           ldb       Addr_0014 ; load the value needed by the following operation
                    cmpb      Addr_001D ; compare against the limit and set condition flags
                    lbeq      Code_4DD0 ; take the distant branch when values are equal
                    incb                ; advance the selected counter
                    stb       Addr_001B ; save the current value in working storage
                    lbra      Code_4D70 ; continue at the distant control-flow target
Code_4DB8           lda       #$FF      ; load the value needed by the following operation
                    sta       Addr_001A ; save the current value in working storage
Code_4DBC           lbsr      Code_4CBD ; call the referenced helper routine
Code_4DBF           ldb       Code_001C ; load the value needed by the following operation
                    lda       Addr_0013 ; load the value needed by the following operation
                    leas      $02,S     ; form the referenced address without reading memory
                    puls      PC,U,Y,X,DP ; restore the listed registers from the stack
Code_4DC7           lda       Addr_001D ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    cmpa      Addr_001B ; compare against the limit and set condition flags
                    bne       Code_4DF9 ; branch when the compared values differ
                    inc       Addr_0019 ; advance the selected counter
Code_4DD0           ldb       Addr_0011 ; load the value needed by the following operation
                    cmpb      Addr_0012 ; compare against the limit and set condition flags
                    beq       Code_4DBF ; branch when the compared values are equal
                    inc       Addr_0011 ; advance the selected counter
                    lbsr      Code_4CAF ; call the referenced helper routine
                    inc       Addr_0013 ; advance the selected counter
                    bsr       Code_4E26 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $26       ; private DeskMate service selector
                    ldb       Addr_001D ; load the value needed by the following operation
                    lbsr      Code_4C94 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "A"                            ; embedded text or resource bytes
                    lda       Addr_0011 ; load the value needed by the following operation
                    adda      Addr_000C ; add the operand to the running value
                    deca                ; decrement the selected counter
                    lbsr      Code_4CA0 ; call the referenced helper routine
                    lbsr      Code_4CAF ; call the referenced helper routine
                    bra       Code_4DB8 ; continue at the selected control-flow target
Code_4DF9           lda       Addr_0010 ; load the value needed by the following operation
                    deca                ; decrement the selected counter
                    cmpa      Addr_001B ; compare against the limit and set condition flags
                    bne       Code_4DBC ; branch when the compared values differ
                    inc       Code_0018 ; advance the selected counter
Code_4E02           tst       Addr_0011 ; set condition flags from the current value
                    beq       Code_4DBF ; branch when the compared values are equal
                    lbsr      Code_4CAF ; call the referenced helper routine
                    dec       Addr_0011 ; decrement the selected counter
                    dec       Addr_0013 ; decrement the selected counter
                    bsr       Code_4E26 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "'"                            ; embedded text or resource bytes
                    ldb       Addr_0010 ; load the value needed by the following operation
                    lbsr      Code_4C94 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "A"                            ; embedded text or resource bytes
                    lda       Addr_0011 ; load the value needed by the following operation
                    lbsr      Code_4CA0 ; call the referenced helper routine
                    lbsr      Code_4CAF ; call the referenced helper routine
                    bra       Code_4DB8 ; continue at the selected control-flow target
Code_4E26           ldb       Addr_0010 ; load the value needed by the following operation
                    lbsr      Code_4C94 ; call the referenced helper routine
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
Code_4E40           pshs      U,Y,X,DP,D ; preserve the listed registers on the stack
                    lbsr      Code_4C87 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "9"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "0"                            ; embedded text or resource bytes
                    sta       Code_0026 ; save the current value in working storage
                    ldd       ,S        ; load the value needed by the following operation
                    stb       Addr_001F ; save the current value in working storage
                    tsta                ; set condition flags from the current value
Code_4E54           bpl       Code_4E77 ; branch while the tested value is nonnegative
                    anda      #$7F      ; mask off unwanted bits
                    sta       Addr_0020 ; save the current value in working storage
                    stx       Addr_0021 ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "I"                            ; embedded text or resource bytes
                    tfr       Y,D       ; copy the source register into the destination register
                    stb       Addr_0023 ; save the current value in working storage
                    tfr       X,D       ; copy the source register into the destination register
                    stb       Addr_0024 ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "4"                            ; embedded text or resource bytes
                    clr       Code_001E ; clear the selected byte or register
                    lda       #$FF      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1E       ; private DeskMate service selector
Code_4E74           lbsr      Code_4F94 ; call the referenced helper routine
Code_4E77           lbsr      Code_4FAF ; call the referenced helper routine
Code_4E7A           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $18       ; private DeskMate service selector
                    anda      #$80      ; mask off unwanted bits
                    ora       #$03      ; set the selected flag bits
                    tfr       A,B       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1C       ; private DeskMate service selector
                    tstb                ; set condition flags from the current value
                    bpl       Code_4E8F ; branch while the tested value is nonnegative
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $16       ; private DeskMate service selector
Code_4E8F           sta       Data_0025 ; save the current value in working storage
                    ldx       Addr_0021 ; load the value needed by the following operation
                    ldb       Addr_001F ; load the value needed by the following operation
                    leay      B,X       ; form the referenced address without reading memory
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bcs       Code_4EB3 ; branch when carry reports an unsigned underflow or error
                    cmpa      #$7E      ; compare against the limit and set condition flags
                    bhi       Code_4EB3 ; branch when the unsigned value is above the limit
                    tst       Code_001E ; set condition flags from the current value
                    lbne      Code_4F74 ; take the distant branch when values differ
Code_4EA5           sta       ,Y        ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "C"                            ; embedded text or resource bytes
Code_4EAB           tst       $01,Y     ; set condition flags from the current value
                    beq       Code_4E7A ; branch when the compared values are equal
                    inc       Addr_001F ; advance the selected counter
                    bra       Code_4E77 ; continue at the selected control-flow target
Code_4EB3           cmpa      #$88      ; compare against the limit and set condition flags
                    beq       Code_4F02 ; branch when the compared values are equal
                    cmpa      #$08      ; compare against the limit and set condition flags
                    beq       Code_4F27 ; branch when the compared values are equal
                    cmpa      #$09      ; compare against the limit and set condition flags
                    beq       Code_4EAB ; branch when the compared values are equal
                    cmpa      #$C9      ; compare against the limit and set condition flags
                    lbeq      Code_4F4B ; take the distant branch when values are equal
                    cmpa      #$E9      ; compare against the limit and set condition flags
                    lbeq      Code_4F4B ; take the distant branch when values are equal
                    cmpa      #$0C      ; compare against the limit and set condition flags
                    beq       Code_4F41 ; branch when the compared values are equal
                    cmpa      #$0A      ; compare against the limit and set condition flags
                    beq       Code_4F2F ; branch when the compared values are equal
                    cmpa      #$8D      ; compare against the limit and set condition flags
                    bne       Code_4EEE ; branch when the compared values differ
                    lda       #$0D      ; load the value needed by the following operation
                    sta       Data_0025 ; save the current value in working storage
Code_4EDB           lda       #$20      ; load the value needed by the following operation
                    sta       ,Y+       ; store the value and advance the destination pointer
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "C"                            ; embedded text or resource bytes
                    tst       ,Y        ; set condition flags from the current value
                    beq       Code_4EEE ; branch when the compared values are equal
                    inc       Addr_001F ; advance the selected counter
                    lbsr      Code_4FAF ; call the referenced helper routine
                    bra       Code_4EDB ; continue at the selected control-flow target
Code_4EEE           ldb       Addr_001F ; load the value needed by the following operation
                    lda       Code_0026 ; load the value needed by the following operation
                    beq       Code_4EF8 ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "3"                            ; embedded text or resource bytes
Code_4EF8           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       ":"                            ; embedded text or resource bytes
                    lda       Data_0025 ; load the value needed by the following operation
                    leas      $02,S     ; form the referenced address without reading memory
                    puls      PC,U,Y,X,DP ; restore the listed registers from the stack
Code_4F02           tst       Code_001E ; set condition flags from the current value
                    bne       Code_4F59 ; branch when the compared values differ
                    tstb                ; set condition flags from the current value
                    beq       Code_4F1C ; branch when the compared values are equal
                    tst       $01,Y     ; set condition flags from the current value
                    bne       Code_4F13 ; branch when the compared values differ
                    lda       #$20      ; load the value needed by the following operation
                    cmpa      ,Y        ; compare against the limit and set condition flags
                    bne       Code_4F1C ; branch when the compared values differ
Code_4F13           dec       Addr_001F ; decrement the selected counter
                    lbsr      Code_4FAF ; call the referenced helper routine
                    ldx       Addr_0021 ; load the value needed by the following operation
                    ldb       Addr_001F ; load the value needed by the following operation
Code_4F1C           lda       #$20      ; load the value needed by the following operation
                    sta       B,X       ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "C"                            ; embedded text or resource bytes
Code_4F24           lbra      Code_4E7A ; continue at the distant control-flow target
Code_4F27           tstb                ; set condition flags from the current value
                    beq       Code_4F24 ; branch when the compared values are equal
                    dec       Addr_001F ; decrement the selected counter
                    lbra      Code_4E77 ; continue at the distant control-flow target
Code_4F2F           lda       Addr_0020 ; load the value needed by the following operation
Code_4F31           deca                ; decrement the selected counter
                    bmi       Code_4F3C ; branch while the tested value is negative
                    incb                ; advance the selected counter
                    tst       B,X       ; set condition flags from the current value
                    bne       Code_4F31 ; branch when the compared values differ
Code_4F39           lbra      Code_4EF8 ; continue at the distant control-flow target
Code_4F3C           stb       Addr_001F ; save the current value in working storage
                    lbra      Code_4E77 ; continue at the distant control-flow target
Code_4F41           lda       Addr_0020 ; load the value needed by the following operation
Code_4F43           deca                ; decrement the selected counter
                    bmi       Code_4F3C ; branch while the tested value is negative
                    decb                ; decrement the selected counter
                    bmi       Code_4F39 ; branch while the tested value is negative
                    bra       Code_4F43 ; continue at the selected control-flow target
Code_4F4B           lda       #$FF      ; load the value needed by the following operation
                    com       Code_001E ; invert every bit in the selected value
                    beq       Code_4F53 ; branch when the compared values are equal
                    lda       #$01      ; load the value needed by the following operation
Code_4F53           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1E       ; private DeskMate service selector
                    bra       Code_4F24 ; continue at the selected control-flow target
Code_4F59           tstb                ; set condition flags from the current value
                    bne       Code_4F5F ; branch when the compared values differ
                    incb                ; advance the selected counter
                    stb       Addr_001F ; save the current value in working storage
Code_4F5F           leax      B,X       ; form the referenced address without reading memory
Code_4F61           lda       ,X+       ; fetch the next value and advance the source pointer
                    beq       Code_4F69 ; branch when the compared values are equal
                    sta       -$02,X    ; save the current value in working storage
                    bra       Code_4F61 ; continue at the selected control-flow target
Code_4F69           lda       #$20      ; load the value needed by the following operation
                    sta       -$02,X    ; save the current value in working storage
                    dec       Addr_001F ; decrement the selected counter
                    bsr       Code_4FAF ; call the referenced helper routine
                    lbra      Code_4E74 ; continue at the distant control-flow target
Code_4F74           tst       $01,Y     ; set condition flags from the current value
                    lbeq      Code_4EA5 ; take the distant branch when values are equal
                    pshs      Y,A       ; preserve the listed registers on the stack
Code_4F7C           lda       ,Y+       ; fetch the next value and advance the source pointer
                    bne       Code_4F7C ; branch when the compared values differ
                    leay      -$02,Y    ; form the referenced address without reading memory
Code_4F82           lda       ,-Y       ; load the value needed by the following operation
                    sta       $01,Y     ; save the current value in working storage
                    cmpy      $01,S     ; compare against the limit and set condition flags
                    bne       Code_4F82 ; branch when the compared values differ
                    puls      X,A       ; restore the listed registers from the stack
                    sta       ,X        ; save the current value in working storage
                    bsr       Code_4F94 ; call the referenced helper routine
                    lbra      Code_4EAB ; continue at the distant control-flow target
Code_4F94           ldx       Addr_0021 ; load the value needed by the following operation
                    ldb       Addr_001F ; load the value needed by the following operation
                    pshs      B         ; preserve the listed registers on the stack
                    leax      B,X       ; form the referenced address without reading memory
Code_4F9C           bsr       Code_4FAF ; call the referenced helper routine
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    beq       Code_4FAA ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "C"                            ; embedded text or resource bytes
                    inc       Addr_001F ; advance the selected counter
                    bra       Code_4F9C ; continue at the selected control-flow target
Code_4FAA           puls      B         ; restore the listed registers from the stack
                    stb       Addr_001F ; save the current value in working storage
                    rts                 ; return to the caller
Code_4FAF           ldb       Addr_001F ; load the value needed by the following operation
                    clra                ; clear the selected byte or register
Code_4FB2           inca                ; advance the selected counter
                    subb      Addr_0020 ; subtract the operand from the running value
                    bhi       Code_4FB2 ; branch when the unsigned value is above the limit
                    beq       Code_4FBC ; branch when the compared values are equal
                    deca                ; decrement the selected counter
                    addb      Addr_0020 ; add the operand to the running value
Code_4FBC           adda      Addr_0023 ; add the operand to the running value
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
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $08       ; table, bitmap, or initialized data bytes
Data_4FD3           fcb       $00,$03,$0C ; table, bitmap, or initialized data bytes
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
                    fcb       $00,$03,$03 ; table, bitmap, or initialized data bytes
Data_5006           fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $0F,$03,$00,$00,$F0,$F0 ; table, bitmap, or initialized data bytes
Data_500E           fcb       $F0,$FF,$FC,$F0,$C0,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
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
Data_5053           fcb       $80,$81,$00,$84,$85,$00 ; table, bitmap, or initialized data bytes
Data_5059           fcb       $82,$83,$00,$86,$87,$00 ; table, bitmap, or initialized data bytes
Data_505F           fcb       $00,$04,$08,$18,$03,$00 ; table, bitmap, or initialized data bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
Data_5066           fcb       $FF       ; table, bitmap, or initialized data bytes
Data_5067           fcb       $07,$05   ; table, bitmap, or initialized data bytes
                    fcc       "  Save as:"                   ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_5074           fcb       $00,$02,$0C,$1C,$07,$00 ; table, bitmap, or initialized data bytes
                    fcb       $AA       ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
Data_507C           fcc       "Use "                         ; embedded text or resource bytes
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
Data_50A7           fcc       "Filename must be 1-8"         ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "characters, begin wit"        ; embedded text or resource bytes
                    fcc       "h"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "a-z "                         ; embedded text or resource bytes
                    fcb       $26       ; table, bitmap, or initialized data bytes
                    fcc       " contain a-z or 0-9"          ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_50EC           fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
Code_50FD           pshs      DP        ; preserve the listed registers on the stack
                    pshs      U,Y,X,A   ; preserve the listed registers on the stack
                    lda       $06,Y     ; load the value needed by the following operation
                    sta       Data_5066,PCR ; save the current value in working storage
                    lbsr      Code_4C87 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       ">"                            ; embedded text or resource bytes
                    sta       Data_0029 ; save the current value in working storage
                    clr       Code_002A ; clear the selected byte or register
                    clr       Addr_002B ; clear the selected byte or register
                    ldx       ,Y        ; load the value needed by the following operation
                    stx       Addr_0027 ; save the current value in working storage
                    leau      >Data_50EC,PCR ; form the referenced address without reading memory
                    stu       ,Y        ; save the current value in working storage
                    lbsr      Code_5220 ; call the referenced helper routine
                    leax      Data_505F,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    ldx       $01,S     ; load the value needed by the following operation
                    bne       Code_5131 ; branch when the compared values differ
                    leax      Data_5067,PCR ; form the referenced address without reading memory
Code_5131           clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
Code_5137           ldx       #Addr_000B ; load the value needed by the following operation
                    leay      -$0B,X    ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    ldy       $03,S     ; load the value needed by the following operation
                    ldx       ,Y        ; load the value needed by the following operation
                    ldd       #Addr_9000 ; load the value needed by the following operation
Code_5148           lbsr      Code_4E40 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_5158 ; branch when the compared values are equal
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    beq       Code_5194 ; branch when the compared values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    beq       Code_5189 ; branch when the compared values are equal
                    bra       Code_5185 ; continue at the selected control-flow target
Code_5158           pshs      U,Y,X,D   ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       ">"                            ; embedded text or resource bytes
                    pshs      A         ; preserve the listed registers on the stack
                    tst       Data_5066,PCR ; set condition flags from the current value
                    bne       Code_516A ; branch when the compared values differ
                    deca                ; decrement the selected counter
                    bpl       Code_516A ; branch while the tested value is nonnegative
                    inca                ; advance the selected counter
Code_516A           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "="                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "E"                            ; embedded text or resource bytes
                    puls      A         ; restore the listed registers from the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "="                            ; embedded text or resource bytes
                    cmpx      #Addr_00FF ; compare against the limit and set condition flags
                    puls      U,Y,X,D   ; restore the listed registers from the stack
                    bne       Code_5194 ; branch when the compared values differ
                    lda       #$05      ; load the value needed by the following operation
                    bra       Code_5189 ; continue at the selected control-flow target
                    fcc       "5v"                           ; embedded text or resource bytes
Code_5185           lda       #$0A      ; load the value needed by the following operation
                    bra       Code_5148 ; continue at the selected control-flow target
Code_5189           ldx       Addr_0027 ; load the value needed by the following operation
                    stx       ,Y        ; save the current value in working storage
                    sta       ,S        ; save the current value in working storage
                    clrb                ; clear the selected byte or register
                    puls      U,Y,X,A   ; restore the listed registers from the stack
                    puls      PC,DP     ; restore the listed registers from the stack
Code_5194           lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpa      #$20      ; compare against the limit and set condition flags
                    beq       Code_5194 ; branch when the compared values are equal
                    lda       ,X        ; load the value needed by the following operation
                    leax      -$01,X    ; form the referenced address without reading memory
                    cmpa      #$3A      ; compare against the limit and set condition flags
                    bne       Code_51B0 ; branch when the compared values differ
                    lda       ,X        ; load the value needed by the following operation
                    suba      #$31      ; subtract the operand from the running value
                    cmpa      #$02      ; compare against the limit and set condition flags
                    bcs       Code_51B0 ; branch when carry reports an unsigned underflow or error
                    leax      Data_507C,PCR ; form the referenced address without reading memory
                    bra       Code_51C1 ; continue at the selected control-flow target
Code_51B0           ldx       ,Y        ; load the value needed by the following operation
                    lda       ,S        ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "J"                            ; embedded text or resource bytes
                    andb      #$EF      ; mask off unwanted bits
                    tstb                ; set condition flags from the current value
                    beq       Code_520C ; branch when the compared values are equal
                    leax      Data_50A7,PCR ; form the referenced address without reading memory
Code_51C1           pshs      X         ; preserve the listed registers on the stack
                    ldb       ,X        ; load the value needed by the following operation
                    tst       Code_002A ; set condition flags from the current value
                    bne       Code_51D1 ; branch when the compared values differ
                    leax      Data_5074,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
Code_51D1           lda       Data_0029 ; load the value needed by the following operation
                    adda      #$02      ; add the operand to the running value
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "="                            ; embedded text or resource bytes
                    cmpb      Addr_002B ; compare against the limit and set condition flags
                    beq       Code_51E3 ; branch when the compared values are equal
                    stb       Addr_002B ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "?"                            ; embedded text or resource bytes
Code_51E3           ldb       #$03      ; load the value needed by the following operation
                    stb       Code_002A ; save the current value in working storage
                    ldy       #Addr_0001 ; load the value needed by the following operation
Code_51EB           clra                ; clear the selected byte or register
                    ldx       #Addr_0001 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    ldx       ,S        ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    stx       ,S        ; save the current value in working storage
                    leay      $01,Y     ; form the referenced address without reading memory
                    decb                ; decrement the selected counter
                    bne       Code_51EB ; branch when the compared values differ
                    leas      $02,S     ; form the referenced address without reading memory
                    lda       Data_0029 ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "="                            ; embedded text or resource bytes
                    lbra      Code_5137 ; continue at the distant control-flow target
Code_520C           lda       Data_0029 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    clr       ,S        ; clear the selected byte or register
                    ldu       Addr_0027 ; load the value needed by the following operation
                    ldx       ,Y        ; load the value needed by the following operation
                    stu       ,Y        ; save the current value in working storage
                    bsr       Code_5220 ; call the referenced helper routine
                    puls      U,Y,X,A   ; restore the listed registers from the stack
                    puls      PC,DP     ; restore the listed registers from the stack
Code_5220           lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,U+       ; store the value and advance the destination pointer
                    bne       Code_5220 ; branch when the compared values differ
                    rts                 ; return to the caller
Data_5227           fcc       "("                            ; embedded text or resource bytes
                    fcb       $0B,$02,$0C,$14,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U8P"                          ; embedded text or resource bytes
                    fcb       $17,$02,$18,$14,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U8"                           ; embedded text or resource bytes
Data_5237           fcb       $02,$03,$00,$06,$05 ; table, bitmap, or initialized data bytes
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
Data_526E           fcb       $00,$00,$0E,$08,$00 ; table, bitmap, or initialized data bytes
Data_5273           fcb       $01,$04   ; table, bitmap, or initialized data bytes
Data_5275           fcb       $00,$00,$C8,$00,$18,$01 ; table, bitmap, or initialized data bytes
                    fcb       $08,$00   ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $00,$01,$18,$00,$18,$01 ; table, bitmap, or initialized data bytes
                    fcc       "X"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
Code_5287           pshs      D         ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0F       ; private DeskMate service selector
                    cmpb      #$50      ; compare against the limit and set condition flags
                    bne       Code_5295 ; branch when the compared values differ
                    tfr       X,D       ; copy the source register into the destination register
                    leax      D,X       ; form the referenced address without reading memory
Code_5295           puls      D         ; restore the listed registers from the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "5"                            ; embedded text or resource bytes
                    lda       #$3A      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "5"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_52A6           pshs      U,DP      ; preserve the listed registers on the stack
                    lbsr      Code_4C87 ; call the referenced helper routine
                    leas      $FE0C,S   ; form the referenced address without reading memory
                    sts       Addr_002C ; save the current value in working storage
                    pshs      Y,X,D     ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $16       ; private DeskMate service selector
                    clr       Data_0031 ; clear the selected byte or register
                    clra                ; clear the selected byte or register
                    leax      Data_5227,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    leax      Data_5237,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "G"                            ; embedded text or resource bytes
                    ldb       #$0C      ; load the value needed by the following operation
                    stb       ,X        ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "G"                            ; embedded text or resource bytes
                    ldb       #$02      ; load the value needed by the following operation
                    stb       ,X        ; save the current value in working storage
                    ldx       #Code_1F1A ; load the value needed by the following operation
                    ldy       #Addr_0B06 ; load the value needed by the following operation
                    lda       #$FF      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0E       ; private DeskMate service selector
                    leax      $0A,X     ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0E       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "0"                            ; embedded text or resource bytes
                    std       Code_002E ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "3"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "2"                            ; embedded text or resource bytes
                    ldb       #$40      ; load the value needed by the following operation
                    ldx       #Addr_0002 ; load the value needed by the following operation
                    leay      -$01,X    ; form the referenced address without reading memory
                    lda       #$31      ; load the value needed by the following operation
                    bsr       Code_5287 ; call the referenced helper routine
                    ldx       #Addr_0007 ; load the value needed by the following operation
                    leay      -$06,X    ; form the referenced address without reading memory
                    lda       #$32      ; load the value needed by the following operation
                    lbsr      Code_5287 ; call the referenced helper routine
                    ldd       Code_002E ; load the value needed by the following operation
                    tsta                ; set condition flags from the current value
                    bne       Code_5316 ; branch when the compared values differ
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "4"                            ; embedded text or resource bytes
Code_5316           tstb                ; set condition flags from the current value
                    bne       Code_531D ; branch when the compared values differ
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "1"                            ; embedded text or resource bytes
Code_531D           ldx       $04,S     ; load the value needed by the following operation
                    lda       [,X]      ; load the value needed by the following operation
                    suba      #$30      ; subtract the operand from the running value
                    beq       Code_5329 ; branch when the compared values are equal
                    cmpa      #$03      ; compare against the limit and set condition flags
                    bcs       Code_532F ; branch when carry reports an unsigned underflow or error
Code_5329           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "N"                            ; embedded text or resource bytes
                    lda       ,X        ; load the value needed by the following operation
Code_532F           ldx       #DeskMateService ; load the value needed by the following operation
                    leay      $04,X     ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "@"                            ; embedded text or resource bytes
                    sta       Code_0032 ; save the current value in working storage
                    lbsr      Code_5465 ; call the referenced helper routine
                    ldb       #$29      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "N"                            ; embedded text or resource bytes
                    leax      $26,X     ; form the referenced address without reading memory
                    leax      D,X       ; form the referenced address without reading memory
                    ldu       Addr_002C ; load the value needed by the following operation
                    ldy       $04,S     ; load the value needed by the following operation
                    ldy       $02,Y     ; load the value needed by the following operation
                    ldd       #Code_01F4 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "L"                            ; embedded text or resource bytes
                    lbcs      Code_5461 ; take the distant branch when carry reports an error
                    sta       Addr_0030 ; save the current value in working storage
                    beq       Code_5395 ; branch when the compared values are equal
                    tfr       A,B       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "K"                            ; embedded text or resource bytes
Code_536A           ldx       ,U        ; load the value needed by the following operation
                    leax      -$01,X    ; form the referenced address without reading memory
                    stx       ,U++      ; store the value and advance the destination pointer
                    deca                ; decrement the selected counter
                    bne       Code_536A ; branch when the compared values differ
                    leax      Data_526E,PCR ; form the referenced address without reading memory
                    ldu       Addr_002C ; load the value needed by the following operation
                    stu       ,X        ; save the current value in working storage
                    lda       Addr_0030 ; load the value needed by the following operation
                    sta       $04,X     ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0F       ; private DeskMate service selector
                    cmpb      #$50      ; compare against the limit and set condition flags
                    bne       Code_538B ; branch when the compared values differ
                    ldb       #$06      ; load the value needed by the following operation
                    stb       $05,X     ; save the current value in working storage
Code_538B           clra                ; clear the selected byte or register
                    lbsr      Code_4C15 ; call the referenced helper routine
                    ldb       #$01      ; load the value needed by the following operation
                    stb       Data_5273,PCR ; save the current value in working storage
Code_5395           tst       Addr_0030 ; set condition flags from the current value
                    beq       Code_539E ; branch when the compared values are equal
                    lbsr      Code_4D25 ; call the referenced helper routine
                    bra       Code_53CB ; continue at the selected control-flow target
Code_539E           tfr       X,U       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "E"                            ; embedded text or resource bytes
                    exg       U,X       ; exchange the two register values
                    stb       Addr_0033 ; save the current value in working storage
                    stu       Code_0034 ; save the current value in working storage
                    sty       Addr_0036 ; save the current value in working storage
                    cmpu      #Addr_00FF ; compare against the limit and set condition flags
                    bne       Code_53BB ; branch when the compared values differ
                    cmpb      #$01      ; compare against the limit and set condition flags
                    bne       Code_53BB ; branch when the compared values differ
                    ldb       #$05      ; load the value needed by the following operation
                    bra       Code_53CB ; continue at the selected control-flow target
Code_53BB           clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $16       ; private DeskMate service selector
                    tfr       A,B       ; copy the source register into the destination register
                    cmpb      #$0D      ; compare against the limit and set condition flags
                    bne       Code_53CB ; branch when the compared values differ
                    clrb                ; clear the selected byte or register
Code_53CB           tst       Addr_0033 ; set condition flags from the current value
                    beq       Code_53E7 ; branch when the compared values are equal
                    pshs      A         ; preserve the listed registers on the stack
                    lda       Code_0037 ; load the value needed by the following operation
                    cmpa      #$03      ; compare against the limit and set condition flags
                    puls      A         ; restore the listed registers from the stack
                    bhi       Code_53E7 ; branch when the unsigned value is above the limit
                    lda       #$01      ; load the value needed by the following operation
                    ldb       Addr_0035 ; load the value needed by the following operation
                    cmpb      #$05      ; compare against the limit and set condition flags
                    lbcs      Code_532F ; take the distant branch when carry reports an error
                    inca                ; advance the selected counter
                    lbra      Code_532F ; continue at the distant control-flow target
Code_53E7           cmpb      #$0D      ; compare against the limit and set condition flags
                    beq       Code_5424 ; branch when the compared values are equal
                    cmpb      #$05      ; compare against the limit and set condition flags
                    beq       Code_5455 ; branch when the compared values are equal
                    cmpb      #$09      ; compare against the limit and set condition flags
                    beq       Code_541A ; branch when the compared values are equal
                    cmpb      #$08      ; compare against the limit and set condition flags
                    beq       Code_541F ; branch when the compared values are equal
                    pshs      D         ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $18       ; private DeskMate service selector
                    tstb                ; set condition flags from the current value
                    beq       Code_5411 ; branch when the compared values are equal
                    lda       Code_0037 ; load the value needed by the following operation
                    cmpa      #$03      ; compare against the limit and set condition flags
                    bhi       Code_5416 ; branch when the unsigned value is above the limit
                    lda       #$01      ; load the value needed by the following operation
                    ldb       Addr_0035 ; load the value needed by the following operation
                    cmpb      #$05      ; compare against the limit and set condition flags
                    bcs       Code_540F ; branch when carry reports an unsigned underflow or error
                    inca                ; advance the selected counter
Code_540F           bsr       Code_5465 ; call the referenced helper routine
Code_5411           puls      D         ; restore the listed registers from the stack
                    lbra      Code_5395 ; continue at the distant control-flow target
Code_5416           lda       Code_0032 ; load the value needed by the following operation
                    bra       Code_540F ; continue at the selected control-flow target
Code_541A           lda       #$02      ; load the value needed by the following operation
                    lbra      Code_532F ; continue at the distant control-flow target
Code_541F           lda       #$01      ; load the value needed by the following operation
                    lbra      Code_532F ; continue at the distant control-flow target
Code_5424           ldx       Addr_002C ; load the value needed by the following operation
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
Code_543A           lda       #$20      ; load the value needed by the following operation
                    tst       ,X        ; set condition flags from the current value
                    beq       Code_5442 ; branch when the compared values are equal
                    lda       ,X+       ; fetch the next value and advance the source pointer
Code_5442           sta       ,U+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bne       Code_543A ; branch when the compared values differ
                    clr       ,U        ; clear the selected byte or register
                    lda       ,S        ; load the value needed by the following operation
                    clr       ,S        ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "J"                            ; embedded text or resource bytes
                    stb       $01,S     ; save the current value in working storage
                    bra       Code_5459 ; continue at the selected control-flow target
Code_5455           lda       #$FF      ; load the value needed by the following operation
                    sta       ,S        ; save the current value in working storage
Code_5459           puls      Y,X,D     ; restore the listed registers from the stack
                    leas      $01F4,S   ; form the referenced address without reading memory
                    puls      PC,U,DP   ; restore the listed registers from the stack
Code_5461           stb       $01,S     ; save the current value in working storage
                    bra       Code_5459 ; continue at the selected control-flow target
Code_5465           pshs      X,D       ; preserve the listed registers on the stack
                    cmpa      Data_0031 ; compare against the limit and set condition flags
                    beq       Code_5489 ; branch when the compared values are equal
                    deca                ; decrement the selected counter
                    pshs      A         ; preserve the listed registers on the stack
                    ldd       #Addr_00FF ; load the value needed by the following operation
                    tst       ,S+       ; set condition flags from the current value
                    bne       Code_5477 ; branch when the compared values differ
                    exg       A,B       ; exchange the two register values
Code_5477           leax      Data_5275,PCR ; form the referenced address without reading memory
                    sta       ,X        ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $13       ; private DeskMate service selector
                    leax      $09,X     ; form the referenced address without reading memory
                    stb       ,X        ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $13       ; private DeskMate service selector
Code_5489           puls      X,D       ; restore the listed registers from the stack
                    sta       Data_0031 ; save the current value in working storage
                    rts                 ; return to the caller
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $80       ; table, bitmap, or initialized data bytes
Data_5490           fcc       "?"                            ; embedded text or resource bytes
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
                    fcb       $03,$C0,$03 ; table, bitmap, or initialized data bytes
Data_554D           fcb       $C0,$00,$00,$03,$C0,$0C ; table, bitmap, or initialized data bytes
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
Data_5647           fcc       "<?"                           ; embedded text or resource bytes
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
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_580E           fcb       $00,$00,$0F,$F0 ; table, bitmap, or initialized data bytes
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
Data_5C92           fcb       $CC,$CC   ; table, bitmap, or initialized data bytes
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
