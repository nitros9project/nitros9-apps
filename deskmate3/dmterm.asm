********************************************************************
* DMTERM - DeskMate 3 terminal application
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

                    nam       DMTERM
                    ttl       DeskMate 3 terminal application

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct
atrv                set       $00

                    mod       eom,name,tylg,atrv,start,$2001

name                fcs       /DMTERM/ ; OS-9 module name

Addr_0001           equ       $0001     ; absolute address used by original code
Addr_0002           equ       $0002     ; absolute address used by original code
Addr_0003           equ       $0003     ; absolute address used by original code
Addr_0004           equ       $0004     ; absolute address used by original code
Addr_0006           equ       $0006     ; absolute address used by original code
Addr_0007           equ       $0007     ; absolute address used by original code
Addr_0008           equ       $0008     ; absolute address used by original code
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
Addr_0036           equ       $0036     ; absolute address used by original code
Addr_0039           equ       $0039     ; absolute address used by original code
Addr_0040           equ       $0040     ; absolute address used by original code
Addr_0042           equ       $0042     ; absolute address used by original code
Addr_0046           equ       $0046     ; absolute address used by original code
Addr_004A           equ       $004A     ; absolute address used by original code
Addr_0064           equ       $0064     ; absolute address used by original code
Addr_0067           equ       $0067     ; absolute address used by original code
Addr_006F           equ       $006F     ; absolute address used by original code
Addr_0072           equ       $0072     ; absolute address used by original code
Addr_0074           equ       $0074     ; absolute address used by original code
Addr_0076           equ       $0076     ; absolute address used by original code
Addr_0078           equ       $0078     ; absolute address used by original code
Addr_007A           equ       $007A     ; absolute address used by original code
Addr_007F           equ       $007F     ; absolute address used by original code
Addr_0080           equ       $0080     ; absolute address used by original code
Addr_0082           equ       $0082     ; absolute address used by original code
Addr_0084           equ       $0084     ; absolute address used by original code
Addr_0085           equ       $0085     ; absolute address used by original code
Addr_0087           equ       $0087     ; absolute address used by original code
Addr_0089           equ       $0089     ; absolute address used by original code
Addr_008B           equ       $008B     ; absolute address used by original code
Addr_0093           equ       $0093     ; absolute address used by original code
Addr_0097           equ       $0097     ; absolute address used by original code
Addr_009B           equ       $009B     ; absolute address used by original code
Addr_00CF           equ       $00CF     ; absolute address used by original code
Addr_00D1           equ       $00D1     ; absolute address used by original code
Addr_00D3           equ       $00D3     ; absolute address used by original code
Addr_00D4           equ       $00D4     ; absolute address used by original code
Addr_00D6           equ       $00D6     ; absolute address used by original code
Addr_00D7           equ       $00D7     ; absolute address used by original code
Addr_00D9           equ       $00D9     ; absolute address used by original code
Addr_013C           equ       $013C     ; absolute address used by original code
Addr_0141           equ       $0141     ; absolute address used by original code
Addr_0146           equ       $0146     ; absolute address used by original code
Addr_0203           equ       $0203     ; absolute address used by original code
Addr_020F           equ       $020F     ; absolute address used by original code
Addr_0401           equ       $0401     ; absolute address used by original code
Addr_040F           equ       $040F     ; absolute address used by original code
Addr_0601           equ       $0601     ; absolute address used by original code
Addr_060F           equ       $060F     ; absolute address used by original code
Addr_0801           equ       $0801     ; absolute address used by original code
Addr_080F           equ       $080F     ; absolute address used by original code
Addr_0A01           equ       $0A01     ; absolute address used by original code
Addr_0C01           equ       $0C01     ; absolute address used by original code
Addr_0E00           equ       $0E00     ; absolute address used by original code
Addr_0E1A           equ       $0E1A     ; absolute address used by original code
Addr_1001           equ       $1001     ; absolute address used by original code
Addr_120D           equ       $120D     ; absolute address used by original code
Addr_1601           equ       $1601     ; absolute address used by original code
Addr_1700           equ       $1700     ; absolute address used by original code
Addr_400D           equ       $400D     ; absolute address used by original code
Addr_4014           equ       $4014     ; absolute address used by original code
Addr_401A           equ       $401A     ; absolute address used by original code
Addr_4028           equ       $4028     ; absolute address used by original code
Addr_680A           equ       $680A     ; absolute address used by original code
Addr_6810           equ       $6810     ; absolute address used by original code
Addr_6814           equ       $6814     ; absolute address used by original code
Addr_681A           equ       $681A     ; absolute address used by original code
Addr_6820           equ       $6820     ; absolute address used by original code
Addr_6828           equ       $6828     ; absolute address used by original code
Addr_6834           equ       $6834     ; absolute address used by original code
Addr_7FFF           equ       $7FFF     ; absolute address used by original code
Addr_8300           equ       $8300     ; absolute address used by original code
Addr_9000           equ       $9000     ; absolute address used by original code
Addr_9014           equ       $9014     ; absolute address used by original code
Addr_901A           equ       $901A     ; absolute address used by original code
Addr_9028           equ       $9028     ; absolute address used by original code
Addr_9034           equ       $9034     ; absolute address used by original code
Addr_B24E           equ       $B24E     ; absolute address used by original code
Addr_B250           equ       $B250     ; absolute address used by original code
Addr_FFD8           equ       $FFD8     ; absolute address used by original code
Addr_FFDC           equ       $FFDC     ; absolute address used by original code
Addr_FFFF           equ       $FFFF     ; absolute address used by original code
DeskMateService     equ       $0000     ; absolute address used by original code

start               jmp       >DeskMateService ; dispatch control through the selected target
Code_0016           leas      $2000,U   ; form the referenced address without reading memory
Code_001A           pshs      X         ; preserve the listed registers on the stack
Code_001C           leax      Data_36B1,PCR ; form the referenced address without reading memory
Code_0020           lbsr      start     ; invoke the patched DeskMate service dispatcher
Data_0023           fcb       $07       ; private DeskMate service selector
Code_0024           lbsr      start     ; invoke the patched DeskMate service dispatcher
Data_0027           fcb       $06       ; private DeskMate service selector
                    leax      Data_3EB3,PCR ; form the referenced address without reading memory
Code_002C           lbsr      start     ; invoke the patched DeskMate service dispatcher
Data_002F           fcb       $08       ; private DeskMate service selector
Code_0030           puls      X         ; restore the listed registers from the stack
Code_0032           lbra      Code_0035 ; continue at the distant control-flow target
Code_0035           pshs      X         ; preserve the listed registers on the stack
Code_0037           clrb                ; clear the selected byte or register
                    tfr       DP,A      ; copy the source register into the destination register
Code_003A           tfr       D,X       ; copy the source register into the destination register
Code_003C           clr       ,X+       ; clear the selected byte or register
Code_003E           decb                ; decrement the selected counter
Code_003F           bne       Code_003C ; branch when the compared values differ
Code_0041           stu       Addr_0002 ; save the current value in working storage
                    leax      $0102,X   ; form the referenced address without reading memory
Code_0047           stx       Addr_0006 ; save the current value in working storage
Code_0049           stx       Addr_000D ; save the current value in working storage
                    lda       #$FF      ; load the value needed by the following operation
Code_004D           sta       Addr_00D6 ; save the current value in working storage
                    lbsr      Code_027C ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       ","                            ; embedded text or resource bytes
                    puls      X         ; restore the listed registers from the stack
                    stx       Addr_0004 ; save the current value in working storage
                    leas      ,Y        ; form the referenced address without reading memory
                    sts       DeskMateService ; save the current value in working storage
                    leay      $FF06,Y   ; form the referenced address without reading memory
Code_0063           sty       Addr_0008 ; save the current value in working storage
                    leay      $01,Y     ; form the referenced address without reading memory
Code_0068           sty       Addr_0093 ; save the current value in working storage
                    leay      $1E,Y     ; form the referenced address without reading memory
                    sty       Addr_0097 ; save the current value in working storage
Code_0071           lda       #$14      ; load the value needed by the following operation
                    sta       Data_0099 ; save the current value in working storage
Code_0075           tfr       DP,A      ; copy the source register into the destination register
                    sta       Addr_0082 ; save the current value in working storage
                    ldb       #$DB      ; load the value needed by the following operation
Code_007B           tfr       D,X       ; copy the source register into the destination register
Code_007D           leay      Data_01AE,PCR ; form the referenced address without reading memory
                    ldb       #$0B      ; load the value needed by the following operation
                    lbsr      Code_0170 ; call the referenced helper routine
                    lda       Addr_0082 ; load the value needed by the following operation
                    ldb       #$E6      ; load the value needed by the following operation
                    tfr       D,X       ; copy the source register into the destination register
                    leay      Data_01B9,PCR ; form the referenced address without reading memory
                    ldb       #$0F      ; load the value needed by the following operation
                    lbsr      Code_0170 ; call the referenced helper routine
Code_0095           clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
Data_0099           fcc       "7"                            ; embedded text or resource bytes
Code_009A           leax      Data_0F07,PCR ; form the referenced address without reading memory
                    tfr       DP,A      ; copy the source register into the destination register
                    ldb       #$29      ; load the value needed by the following operation
                    tfr       D,U       ; copy the source register into the destination register
                    ldd       ,X++      ; fetch the next value and advance the source pointer
                    std       ,U++      ; store the value and advance the destination pointer
                    lda       ,X        ; load the value needed by the following operation
                    sta       ,U        ; save the current value in working storage
                    lda       Addr_0082 ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    sta       Addr_000F ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       " "                            ; embedded text or resource bytes
                    stx       Code_007D ; save the current value in working storage
                    leax      Data_0313,PCR ; form the referenced address without reading memory
                    os9       F$Icpt    ; request the named OS-9 service
                    ldx       Addr_0004 ; load the value needed by the following operation
                    lda       ,X        ; load the value needed by the following operation
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    bne       Code_00D8 ; branch when the compared values differ
Code_00C6           leay      Data_017B,PCR ; form the referenced address without reading memory
                    tfr       DP,A      ; copy the source register into the destination register
                    ldb       #$9C      ; load the value needed by the following operation
                    tfr       D,X       ; copy the source register into the destination register
Code_00D0           ldb       #$32      ; load the value needed by the following operation
Code_00D2           lbsr      Code_0170 ; call the referenced helper routine
Code_00D5           lbra      Code_03EC ; continue at the distant control-flow target
Code_00D8           stx       Code_0035 ; save the current value in working storage
                    ldb       #$0B      ; load the value needed by the following operation
Code_00DC           lda       ,X+       ; fetch the next value and advance the source pointer
                    beq       Code_00E9 ; branch when the compared values are equal
                    decb                ; decrement the selected counter
                    beq       Code_00E7 ; branch when the compared values are equal
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    bne       Code_00DC ; branch when the compared values differ
Code_00E7           clr       ,-X       ; clear the selected byte or register
Code_00E9           leau      Data_0B85,PCR ; form the referenced address without reading memory
                    stu       Code_0037 ; save the current value in working storage
                    tfr       DP,A      ; copy the source register into the destination register
                    ldb       #$F5      ; load the value needed by the following operation
                    std       Addr_0039 ; save the current value in working storage
                    ldb       #$35      ; load the value needed by the following operation
                    tfr       D,Y       ; copy the source register into the destination register
                    lda       #$41      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "J"                            ; embedded text or resource bytes
Code_00FF           ldx       $04,Y     ; load the value needed by the following operation
                    lda       #$01      ; load the value needed by the following operation
                    os9       I$Open    ; request the named OS-9 service
                    bcs       Code_00C6 ; branch when carry reports an unsigned underflow or error
                    pshs      A         ; preserve the listed registers on the stack
                    tfr       DP,A      ; copy the source register into the destination register
                    ldb       #$9C      ; load the value needed by the following operation
                    tfr       D,X       ; copy the source register into the destination register
                    ldy       #Code_003A ; load the value needed by the following operation
                    lda       ,S        ; load the value needed by the following operation
                    os9       I$Read    ; request the named OS-9 service
                    bcs       Code_00C6 ; branch when carry reports an unsigned underflow or error
                    puls      A         ; restore the listed registers from the stack
                    os9       I$Close   ; request the named OS-9 service
                    lbra      Code_2180 ; continue at the distant control-flow target
                    fcb       $17,$FE,$ED,$22 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
Code_0128           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $02       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_012D           pshs      B         ; preserve the listed registers on the stack
Code_012F           ldb       Addr_007A ; load the value needed by the following operation
                    bmi       Code_013D ; branch while the tested value is negative
Code_0133           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
Code_0137           beq       Code_012F ; branch when the compared values are equal
                    andcc     #$FE      ; mask off unwanted bits
                    puls      PC,B      ; restore the listed registers from the stack
Code_013D           pshs      U,Y,X     ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $19       ; private DeskMate service selector
                    tst       Addr_009B ; set condition flags from the current value
                    beq       Code_0154 ; branch when the compared values are equal
                    pshs      D         ; preserve the listed registers on the stack
                    tfr       U,D       ; copy the source register into the destination register
                    cmpa      #$01      ; compare against the limit and set condition flags
                    bls       Code_0152 ; branch when the unsigned value is at or below the limit
                    lsrb                ; shift right and expose the low bit through carry
                    tfr       D,U       ; copy the source register into the destination register
Code_0152           puls      D         ; restore the listed registers from the stack
Code_0154           tstb                ; set condition flags from the current value
                    bne       Code_0166 ; branch when the compared values differ
                    ldb       #$FF      ; load the value needed by the following operation
                    cmpu      Code_007B ; compare against the limit and set condition flags
                    bne       Code_0164 ; branch when the compared values differ
                    puls      U,Y,X     ; restore the listed registers from the stack
                    ldb       Addr_007A ; load the value needed by the following operation
                    bra       Code_0133 ; continue at the selected control-flow target
Code_0164           stu       Code_007B ; save the current value in working storage
Code_0166           tfr       B,A       ; copy the source register into the destination register
                    puls      Y,X       ; restore the listed registers from the stack
                    leas      $02,S     ; form the referenced address without reading memory
                    orcc      #$01      ; set the selected flag bits
                    puls      PC,B      ; restore the listed registers from the stack
Code_0170           pshs      Y,X,D     ; preserve the listed registers on the stack
Code_0172           lda       ,Y+       ; fetch the next value and advance the source pointer
                    sta       ,X+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bne       Code_0172 ; branch when the compared values differ
                    puls      PC,Y,X,D  ; restore the listed registers from the stack
Data_017B           fcc       "1:TERMSTAT"                   ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "USER ID NUMBER "              ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "USER PASSWORD  "              ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "       "                      ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_01AE           fcc       "          "                   ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_01B9           fcc       "              "               ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_01C8           pshs      Y,X,D     ; preserve the listed registers on the stack
                    ldx       #Addr_0E00 ; load the value needed by the following operation
                    ldy       #Addr_B24E ; load the value needed by the following operation
                    tst       Addr_009B ; set condition flags from the current value
                    bne       Code_01D9 ; branch when the compared values differ
                    ldy       #Addr_B250 ; load the value needed by the following operation
Code_01D9           clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0E       ; private DeskMate service selector
                    puls      PC,Y,X,D  ; restore the listed registers from the stack
Data_01E0           fcc       "DMHELP"                       ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "DMTERM "                      ; embedded text or resource bytes
Data_01EE           fcb       $00,$00,$0D ; table, bitmap, or initialized data bytes
Data_01F1           fcc       "("                            ; embedded text or resource bytes
                    fcb       $06,$05   ; table, bitmap, or initialized data bytes
Data_01F4           fcb       $1C,$0F,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $1A,$05,$1C,$0F,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
Data_0200           fcb       $E0       ; table, bitmap, or initialized data bytes
Code_0201           sta       >Data_01EE,PCR ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    leax      >Data_01F1,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    ldx       #Addr_FFD8 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
Data_0218           fcc       "O"                            ; embedded text or resource bytes
                    leay      >Data_01E0,PCR ; form the referenced address without reading memory
                    ldu       Addr_0002 ; load the value needed by the following operation
                    leax      $0136,U   ; form the referenced address without reading memory
                    pshs      X         ; preserve the listed registers on the stack
                    ldb       #$11      ; load the value needed by the following operation
                    lbsr      Code_0170 ; call the referenced helper routine
                    puls      X         ; restore the listed registers from the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "V"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "P"                            ; embedded text or resource bytes
                    lbsr      Code_02A5 ; call the referenced helper routine
                    rts                 ; return to the caller
Data_0238           fcc       "DMALT"                        ; embedded text or resource bytes
                    fcb       $0D,$FC,$00,$0D ; table, bitmap, or initialized data bytes
Code_0241           tst       Addr_00D7 ; set condition flags from the current value
                    beq       Code_0256 ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "N"                            ; embedded text or resource bytes
                    tst       $24,X     ; set condition flags from the current value
                    beq       Code_0256 ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $14       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $16       ; private DeskMate service selector
Code_0256           ldx       #Addr_FFD8 ; load the value needed by the following operation
                    lda       Addr_00D6 ; load the value needed by the following operation
                    tsta                ; set condition flags from the current value
                    bne       Code_0261 ; branch when the compared values differ
                    ldx       #Addr_FFDC ; load the value needed by the following operation
Code_0261           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "O"                            ; embedded text or resource bytes
                    leax      >Data_0238,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
Data_026C           fcc       "V"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "P"                            ; embedded text or resource bytes
                    tst       Addr_00D7 ; set condition flags from the current value
                    beq       Code_0279 ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $15       ; private DeskMate service selector
Code_0279           bsr       Code_027C ; call the referenced helper routine
                    rts                 ; return to the caller
Code_027C           pshs      Y,X,D     ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "N"                            ; embedded text or resource bytes
                    lda       $23,X     ; load the value needed by the following operation
                    tst       Addr_00D6 ; set condition flags from the current value
                    beq       Code_028B ; branch when the compared values are equal
                    lda       #$28      ; load the value needed by the following operation
Code_028B           clr       Addr_009B ; clear the selected byte or register
                    cmpa      #$28      ; compare against the limit and set condition flags
                    bne       Code_0295 ; branch when the compared values differ
                    ldb       #$FF      ; load the value needed by the following operation
                    stb       Addr_009B ; save the current value in working storage
Code_0295           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "-"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $00       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $09       ; private DeskMate service selector
                    bsr       Code_02A5 ; call the referenced helper routine
                    puls      PC,Y,X,D  ; restore the listed registers from the stack
Code_02A5           tst       Addr_009B ; set condition flags from the current value
                    beq       Code_02DE ; branch when the compared values are equal
                    lda       #$AA      ; load the value needed by the following operation
                    sta       Code_009A ; save the current value in working storage
                    lda       #$27      ; load the value needed by the following operation
                    sta       Data_0099 ; save the current value in working storage
                    leax      Data_0351,PCR ; form the referenced address without reading memory
                    ldd       #Addr_6828 ; load the value needed by the following operation
                    std       ,X++      ; store the value and advance the destination pointer
                    ldd       #Addr_6834 ; load the value needed by the following operation
                    std       ,X++      ; store the value and advance the destination pointer
                    ldd       #Addr_401A ; load the value needed by the following operation
                    std       ,X++      ; store the value and advance the destination pointer
                    ldd       #Addr_4028 ; load the value needed by the following operation
                    std       ,X++      ; store the value and advance the destination pointer
                    ldd       #Addr_6814 ; load the value needed by the following operation
                    std       ,X++      ; store the value and advance the destination pointer
                    ldd       #Addr_6820 ; load the value needed by the following operation
                    std       ,X++      ; store the value and advance the destination pointer
                    ldd       #Addr_9028 ; load the value needed by the following operation
                    std       ,X++      ; store the value and advance the destination pointer
                    ldd       #Addr_9034 ; load the value needed by the following operation
                    std       ,X++      ; store the value and advance the destination pointer
                    rts                 ; return to the caller
Code_02DE           lda       #$55      ; load the value needed by the following operation
                    sta       Code_009A ; save the current value in working storage
                    lda       #$50      ; load the value needed by the following operation
                    sta       Data_0099 ; save the current value in working storage
                    leax      >Data_0351,PCR ; form the referenced address without reading memory
                    ldd       #Addr_6814 ; load the value needed by the following operation
                    std       ,X++      ; store the value and advance the destination pointer
                    ldd       #Addr_681A ; load the value needed by the following operation
                    std       ,X++      ; store the value and advance the destination pointer
                    ldd       #Addr_400D ; load the value needed by the following operation
                    std       ,X++      ; store the value and advance the destination pointer
                    ldd       #Addr_4014 ; load the value needed by the following operation
                    std       ,X++      ; store the value and advance the destination pointer
                    ldd       #Addr_680A ; load the value needed by the following operation
                    std       ,X++      ; store the value and advance the destination pointer
                    ldd       #Addr_6810 ; load the value needed by the following operation
                    std       ,X++      ; store the value and advance the destination pointer
                    ldd       #Addr_9014 ; load the value needed by the following operation
                    std       ,X++      ; store the value and advance the destination pointer
                    ldd       #Addr_901A ; load the value needed by the following operation
                    std       ,X++      ; store the value and advance the destination pointer
                    rts                 ; return to the caller
Data_0313           fcc       ";"                      ;0313: 3B             ' ; embedded text or resource bytes
Code_0314           pshs      X         ; preserve the listed registers on the stack
                    bsr       Code_0343 ; call the referenced helper routine
                    puls      X         ; restore the listed registers from the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
                    lda       #$03      ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    lda       Addr_007A ; load the value needed by the following operation
                    pshs      A         ; preserve the listed registers on the stack
                    lda       #$80      ; load the value needed by the following operation
                    sta       Addr_007A ; save the current value in working storage
Code_032D           lbsr      Code_012D ; call the referenced helper routine
                    bcc       Code_0336 ; branch when carry is clear
                    cmpa      #$01      ; compare against the limit and set condition flags
                    bne       Code_032D ; branch when the compared values differ
Code_0336           puls      A         ; restore the listed registers from the stack
                    sta       Addr_007A ; save the current value in working storage
                    rts                 ; return to the caller
Data_033B           fcb       $00,$01,$0A,$1E,$06,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
Code_0343           clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    leax      >Data_033B,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "89"                           ; embedded text or resource bytes
Data_0351           fcb       $00,$00   ; table, bitmap, or initialized data bytes
Data_0353           fcb       $00,$00   ; table, bitmap, or initialized data bytes
Data_0355           fcb       $00,$00   ; table, bitmap, or initialized data bytes
Data_0357           fcb       $00,$00   ; table, bitmap, or initialized data bytes
Data_0359           fcb       $00,$00   ; table, bitmap, or initialized data bytes
Data_035B           fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
Data_0361           fcb       $0D,$01,$AE ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $01,$AE,$B5,$0A,$BC,$B6 ; table, bitmap, or initialized data bytes
                    fcb       $1D       ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $D6,$03   ; table, bitmap, or initialized data bytes
                    fcc       "c"                            ; embedded text or resource bytes
                    fcb       $C6,$06,$C6,$0A,$01,$F7 ; table, bitmap, or initialized data bytes
                    fcb       $0C,$01,$BB,$08,$02,$07 ; table, bitmap, or initialized data bytes
                    fcb       $09,$02   ; table, bitmap, or initialized data bytes
                    fcc       "}"                            ; embedded text or resource bytes
                    fcb       $8C,$03,$09,$AF,$01,$A1 ; table, bitmap, or initialized data bytes
                    fcb       $BA,$01,$A8,$05,$07,$87 ; table, bitmap, or initialized data bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_038C           fcb       $00,$00,$A9,$01,$00,$A9 ; table, bitmap, or initialized data bytes
                    fcb       $02,$03   ; table, bitmap, or initialized data bytes
                    fcc       "q"                            ; embedded text or resource bytes
                    fcb       $03,$03   ; table, bitmap, or initialized data bytes
                    fcc       "q"                            ; embedded text or resource bytes
                    fcb       $04,$03,$92,$05,$03,$92 ; table, bitmap, or initialized data bytes
                    fcb       $06,$03,$B4,$07,$03,$B4 ; table, bitmap, or initialized data bytes
                    fcb       $08,$03,$D6,$09,$03,$D6 ; table, bitmap, or initialized data bytes
                    fcb       $0A,$00,$D1,$0B,$00,$D1 ; table, bitmap, or initialized data bytes
                    fcb       $0C,$00,$F3,$0D,$00,$F3 ; table, bitmap, or initialized data bytes
                    fcb       $0E,$01,$16,$0F,$01,$16 ; table, bitmap, or initialized data bytes
                    fcb       $10,$01   ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $11,$01   ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $12,$01   ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $13,$01   ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $14,$01   ; table, bitmap, or initialized data bytes
                    fcc       "d"                            ; embedded text or resource bytes
                    fcb       $15,$01   ; table, bitmap, or initialized data bytes
                    fcc       "d"                            ; embedded text or resource bytes
                    fcb       $16,$01,$89,$17,$01,$89 ; table, bitmap, or initialized data bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
Data_03D5           fcb       $01,$B8,$01,$D9,$01,$FB ; table, bitmap, or initialized data bytes
                    fcb       $02,$1D,$02 ; table, bitmap, or initialized data bytes
                    fcc       "B"                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "R"                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "c"                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "z"                            ; embedded text or resource bytes
                    fcb       $02,$86,$02,$92,$02,$9E ; table, bitmap, or initialized data bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_03EC           lds       DeskMateService ; load the value needed by the following operation
                    clr       Addr_007F ; clear the selected byte or register
                    lda       #$03      ; load the value needed by the following operation
                    sta       Addr_007A ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "4"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "N"                            ; embedded text or resource bytes
                    tst       $24,X     ; set condition flags from the current value
                    beq       Code_040A ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $14       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $16       ; private DeskMate service selector
Code_040A           clr       Addr_00D7 ; clear the selected byte or register
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Addr_009B ; save the current value in working storage
                    sta       Addr_00D6 ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "-"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $00       ; private DeskMate service selector
                    lda       #$28      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $09       ; private DeskMate service selector
                    lbsr      Code_02A5 ; call the referenced helper routine
Code_0423           lbsr      Code_01C8 ; call the referenced helper routine
                    lbsr      Code_0C5D ; call the referenced helper routine
                    lbsr      Code_08B2 ; call the referenced helper routine
                    lbsr      Code_0618 ; call the referenced helper routine
                    ldd       #Addr_FFFF ; load the value needed by the following operation
                    std       Code_007B ; save the current value in working storage
Code_0434           lda       #$80      ; load the value needed by the following operation
                    sta       Addr_007A ; save the current value in working storage
                    lbsr      Code_012D ; call the referenced helper routine
                    bcs       Code_0453 ; branch when carry reports an unsigned underflow or error
                    leax      Data_0361,PCR ; form the referenced address without reading memory
Code_0441           cmpa      ,X+       ; compare against the limit and set condition flags
                    beq       Code_044D ; branch when the compared values are equal
                    leax      $02,X     ; form the referenced address without reading memory
                    ldb       ,X        ; load the value needed by the following operation
                    bne       Code_0441 ; branch when the compared values differ
                    bra       Code_0434 ; continue at the selected control-flow target
Code_044D           tfr       PC,Y      ; copy the source register into the destination register
                    ldd       ,X        ; load the value needed by the following operation
                    jmp       D,Y       ; dispatch control through the selected target
Code_0453           tsta                ; set condition flags from the current value
                    bmi       Code_046E ; branch while the tested value is negative
                    cmpa      #$01      ; compare against the limit and set condition flags
                    beq       Code_045C ; branch when the compared values are equal
                    bra       Code_0434 ; continue at the selected control-flow target
Code_045C           tfr       U,D       ; copy the source register into the destination register
                    leax      Data_038C,PCR ; form the referenced address without reading memory
Code_0462           cmpa      ,X+       ; compare against the limit and set condition flags
                    beq       Code_044D ; branch when the compared values are equal
                    leax      $02,X     ; form the referenced address without reading memory
                    tst       ,X        ; set condition flags from the current value
                    bpl       Code_0462 ; branch while the tested value is nonnegative
                    bra       Code_0434 ; continue at the selected control-flow target
Code_046E           tfr       U,D       ; copy the source register into the destination register
                    cmpa      #$01      ; compare against the limit and set condition flags
                    bhi       Code_04DE ; branch when the unsigned value is above the limit
                    lbsr      Code_0E8E ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    lbeq      Code_0434 ; take the distant branch when values are equal
                    deca                ; decrement the selected counter
                    lbeq      Code_04CA ; take the distant branch when values are equal
                    deca                ; decrement the selected counter
                    lbeq      Code_04B6 ; take the distant branch when values are equal
                    deca                ; decrement the selected counter
                    lbeq      Code_048E ; take the distant branch when values are equal
                    lbra      Code_04A2 ; continue at the distant control-flow target
Code_048E           lda       Addr_007F ; load the value needed by the following operation
                    cmpa      #$03      ; compare against the limit and set condition flags
                    lbeq      Code_0434 ; take the distant branch when values are equal
                    bsr       Code_04E9 ; call the referenced helper routine
                    lbsr      Code_0CF4 ; call the referenced helper routine
                    lda       #$03      ; load the value needed by the following operation
                    sta       Addr_007F ; save the current value in working storage
                    lbra      Code_0434 ; continue at the distant control-flow target
Code_04A2           lda       Addr_007F ; load the value needed by the following operation
                    cmpa      #$04      ; compare against the limit and set condition flags
                    lbeq      Code_0434 ; take the distant branch when values are equal
                    bsr       Code_04E9 ; call the referenced helper routine
                    lbsr      Code_0D29 ; call the referenced helper routine
                    lda       #$04      ; load the value needed by the following operation
                    sta       Addr_007F ; save the current value in working storage
                    lbra      Code_0434 ; continue at the distant control-flow target
Code_04B6           lda       Addr_007F ; load the value needed by the following operation
                    cmpa      #$02      ; compare against the limit and set condition flags
                    lbeq      Code_0434 ; take the distant branch when values are equal
                    bsr       Code_04E9 ; call the referenced helper routine
                    lbsr      Code_0DE5 ; call the referenced helper routine
                    lda       #$02      ; load the value needed by the following operation
                    sta       Addr_007F ; save the current value in working storage
                    lbra      Code_0434 ; continue at the distant control-flow target
Code_04CA           lda       Addr_007F ; load the value needed by the following operation
                    cmpa      #$01      ; compare against the limit and set condition flags
                    lbeq      Code_0434 ; take the distant branch when values are equal
                    bsr       Code_04E9 ; call the referenced helper routine
                    lbsr      Code_0DB9 ; call the referenced helper routine
                    lda       #$01      ; load the value needed by the following operation
                    sta       Addr_007F ; save the current value in working storage
                    lbra      Code_0434 ; continue at the distant control-flow target
Code_04DE           lda       Addr_007F ; load the value needed by the following operation
                    lbeq      Code_0434 ; take the distant branch when values are equal
                    bsr       Code_04E9 ; call the referenced helper routine
                    lbra      Code_0434 ; continue at the distant control-flow target
Code_04E9           lbsr      Code_0DBD ; call the referenced helper routine
                    lbsr      Code_0DE9 ; call the referenced helper routine
                    lbsr      Code_0CE1 ; call the referenced helper routine
                    lbsr      Code_0D16 ; call the referenced helper routine
                    clr       Addr_007F ; clear the selected byte or register
                    rts                 ; return to the caller
                    clr       Addr_007F ; clear the selected byte or register
                    tfr       U,D       ; copy the source register into the destination register
                    lbsr      Code_0E8E ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    lbeq      Code_0517 ; take the distant branch when values are equal
                    deca                ; decrement the selected counter
                    lbeq      Code_0B15 ; take the distant branch when values are equal
                    deca                ; decrement the selected counter
                    lbeq      Code_07B2 ; take the distant branch when values are equal
                    deca                ; decrement the selected counter
                    lbne      Code_051A ; take the distant branch when values differ
                    clra                ; clear the selected byte or register
                    lbsr      Code_0201 ; call the referenced helper routine
Code_0517           lbra      Code_0423 ; continue at the distant control-flow target
Code_051A           lbsr      Code_0241 ; call the referenced helper routine
                    lbra      Code_0517 ; continue at the distant control-flow target
                    tfr       U,D       ; copy the source register into the destination register
                    cmpb      #$0B      ; compare against the limit and set condition flags
                    lbcs      Code_0434 ; take the distant branch when carry reports an error
                    clra                ; clear the selected byte or register
                    cmpb      #$11      ; compare against the limit and set condition flags
                    bcs       Code_0538 ; branch when carry reports an unsigned underflow or error
                    inca                ; advance the selected counter
                    cmpb      #$16      ; compare against the limit and set condition flags
                    bcs       Code_0538 ; branch when carry reports an unsigned underflow or error
                    inca                ; advance the selected counter
                    cmpb      #$1B      ; compare against the limit and set condition flags
                    bcs       Code_0538 ; branch when carry reports an unsigned underflow or error
                    inca                ; advance the selected counter
Code_0538           sta       Addr_00CF ; save the current value in working storage
                    lbsr      Code_0993 ; call the referenced helper routine
                    lda       #$04      ; load the value needed by the following operation
                    lbra      Code_05C9 ; continue at the distant control-flow target
                    tfr       U,D       ; copy the source register into the destination register
                    cmpb      #$0B      ; compare against the limit and set condition flags
                    lbcs      Code_0434 ; take the distant branch when carry reports an error
                    lda       #$02      ; load the value needed by the following operation
                    cmpb      #$11      ; compare against the limit and set condition flags
                    bcs       Code_055C ; branch when carry reports an unsigned underflow or error
                    lda       #$03      ; load the value needed by the following operation
                    cmpb      #$16      ; compare against the limit and set condition flags
                    bcs       Code_055C ; branch when carry reports an unsigned underflow or error
                    clra                ; clear the selected byte or register
                    cmpb      #$1A      ; compare against the limit and set condition flags
                    bcs       Code_055C ; branch when carry reports an unsigned underflow or error
                    inca                ; advance the selected counter
Code_055C           sta       Code_00D0 ; save the current value in working storage
                    lbsr      Code_09D4 ; call the referenced helper routine
                    lda       #$05      ; load the value needed by the following operation
                    bra       Code_05C9 ; continue at the selected control-flow target
                    tfr       U,D       ; copy the source register into the destination register
                    cmpb      #$0B      ; compare against the limit and set condition flags
                    lbcs      Code_0434 ; take the distant branch when carry reports an error
                    lda       #$01      ; load the value needed by the following operation
                    cmpb      #$13      ; compare against the limit and set condition flags
                    bcs       Code_057A ; branch when carry reports an unsigned underflow or error
                    lda       #$FF      ; load the value needed by the following operation
                    cmpb      #$19      ; compare against the limit and set condition flags
                    bcs       Code_057A ; branch when carry reports an unsigned underflow or error
                    inca                ; advance the selected counter
Code_057A           sta       Addr_00D1 ; save the current value in working storage
                    lbsr      Code_0A0F ; call the referenced helper routine
                    lda       #$06      ; load the value needed by the following operation
                    bra       Code_05C9 ; continue at the selected control-flow target
                    tfr       U,D       ; copy the source register into the destination register
                    cmpb      #$0B      ; compare against the limit and set condition flags
                    lbcs      Code_0434 ; take the distant branch when carry reports an error
                    lda       #$FF      ; load the value needed by the following operation
                    cmpb      #$13      ; compare against the limit and set condition flags
                    bcs       Code_0592 ; branch when carry reports an unsigned underflow or error
                    clra                ; clear the selected byte or register
Code_0592           sta       Code_00D2 ; save the current value in working storage
                    lbsr      Code_0A45 ; call the referenced helper routine
                    lda       #$07      ; load the value needed by the following operation
                    bra       Code_05C9 ; continue at the selected control-flow target
                    tfr       U,D       ; copy the source register into the destination register
                    cmpb      #$0B      ; compare against the limit and set condition flags
                    lbcs      Code_0434 ; take the distant branch when carry reports an error
                    lda       #$FF      ; load the value needed by the following operation
                    cmpb      #$13      ; compare against the limit and set condition flags
                    bcs       Code_05AA ; branch when carry reports an unsigned underflow or error
                    clra                ; clear the selected byte or register
Code_05AA           sta       Addr_00D3 ; save the current value in working storage
                    lbsr      Code_0A75 ; call the referenced helper routine
                    lda       #$08      ; load the value needed by the following operation
                    bra       Code_05C9 ; continue at the selected control-flow target
                    tfr       U,D       ; copy the source register into the destination register
                    cmpb      #$0B      ; compare against the limit and set condition flags
                    lbcs      Code_0434 ; take the distant branch when carry reports an error
                    lda       #$FF      ; load the value needed by the following operation
                    cmpb      #$13      ; compare against the limit and set condition flags
                    bcs       Code_05C2 ; branch when carry reports an unsigned underflow or error
                    clra                ; clear the selected byte or register
Code_05C2           sta       Addr_00D4 ; save the current value in working storage
                    lbsr      Code_0AA5 ; call the referenced helper routine
                    lda       #$09      ; load the value needed by the following operation
Code_05C9           pshs      A         ; preserve the listed registers on the stack
                    lbsr      Code_0643 ; call the referenced helper routine
                    puls      A         ; restore the listed registers from the stack
                    sta       Addr_0033 ; save the current value in working storage
                    lbsr      Code_0618 ; call the referenced helper routine
                    lbra      Code_0434 ; continue at the distant control-flow target
                    tfr       U,D       ; copy the source register into the destination register
                    cmpb      #$0B      ; compare against the limit and set condition flags
                    lbcs      Code_0434 ; take the distant branch when carry reports an error
                    lda       #$FF      ; load the value needed by the following operation
                    cmpb      #$13      ; compare against the limit and set condition flags
                    bcs       Code_05E7 ; branch when carry reports an unsigned underflow or error
                    clra                ; clear the selected byte or register
Code_05E7           sta       Code_00D5 ; save the current value in working storage
                    lbsr      Code_0AD5 ; call the referenced helper routine
                    lda       #$0A      ; load the value needed by the following operation
                    bra       Code_05C9 ; continue at the selected control-flow target
                    clra                ; clear the selected byte or register
                    lbsr      Code_0201 ; call the referenced helper routine
                    lbra      Code_0423 ; continue at the distant control-flow target
                    lbsr      Code_0241 ; call the referenced helper routine
                    lbra      Code_0423 ; continue at the distant control-flow target
                    ldb       Addr_0033 ; load the value needed by the following operation
                    leax      Data_03D5,PCR ; form the referenced address without reading memory
                    aslb                ; shift left and update carry
                    ldd       B,X       ; load the value needed by the following operation
                    tfr       PC,Y      ; copy the source register into the destination register
                    jmp       D,Y       ; dispatch control through the selected target
                    bsr       Code_0643 ; call the referenced helper routine
                    lda       Addr_0033 ; load the value needed by the following operation
                    beq       Code_0613 ; branch when the compared values are equal
                    deca                ; decrement the selected counter
                    sta       Addr_0033 ; save the current value in working storage
Code_0613           bsr       Code_0618 ; call the referenced helper routine
                    lbra      Code_0434 ; continue at the distant control-flow target
Code_0618           lda       #$FF      ; load the value needed by the following operation
Code_061A           sta       Addr_0084 ; save the current value in working storage
                    ldb       Addr_0033 ; load the value needed by the following operation
                    aslb                ; shift left and update carry
                    addb      #$02      ; add the operand to the running value
                    lda       #$08      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    tfr       D,U       ; copy the source register into the destination register
                    leax      -$02,U    ; form the referenced address without reading memory
                    stx       Addr_0087 ; save the current value in working storage
                    leax      $09,U     ; form the referenced address without reading memory
                    stx       Addr_008B ; save the current value in working storage
                    ldd       #Addr_0002 ; load the value needed by the following operation
                    std       Addr_0085 ; save the current value in working storage
                    ldd       #Data_0218 ; load the value needed by the following operation
                    std       Addr_0089 ; save the current value in working storage
                    tfr       DP,A      ; copy the source register into the destination register
                    ldb       #$84      ; load the value needed by the following operation
                    tfr       D,X       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $13       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_0643           clra                ; clear the selected byte or register
                    bra       Code_061A ; continue at the selected control-flow target
                    bsr       Code_0643 ; call the referenced helper routine
                    lda       Addr_0033 ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    cmpa      #$0A      ; compare against the limit and set condition flags
                    bhi       Code_0651 ; branch when the unsigned value is above the limit
                    sta       Addr_0033 ; save the current value in working storage
Code_0651           bsr       Code_0618 ; call the referenced helper routine
                    lbra      Code_0434 ; continue at the distant control-flow target
                    lda       Addr_0033 ; load the value needed by the following operation
                    cmpa      #$04      ; compare against the limit and set condition flags
                    lbcs      Code_0434 ; take the distant branch when carry reports an error
                    bne       Code_066D ; branch when the compared values differ
                    lda       Addr_00CF ; load the value needed by the following operation
                    deca                ; decrement the selected counter
                    bmi       Code_066A ; branch while the tested value is negative
                    sta       Addr_00CF ; save the current value in working storage
                    lbsr      Code_0993 ; call the referenced helper routine
Code_066A           lbra      Code_0434 ; continue at the distant control-flow target
Code_066D           cmpa      #$06      ; compare against the limit and set condition flags
                    bhi       Code_069A ; branch when the unsigned value is above the limit
                    beq       Code_0688 ; branch when the compared values are equal
                    lda       Code_00D0 ; load the value needed by the following operation
                    deca                ; decrement the selected counter
                    bpl       Code_067A ; branch while the tested value is nonnegative
                    lda       #$03      ; load the value needed by the following operation
Code_067A           cmpa      #$01      ; compare against the limit and set condition flags
                    lbeq      Code_0434 ; take the distant branch when values are equal
                    sta       Code_00D0 ; save the current value in working storage
                    lbsr      Code_09D4 ; call the referenced helper routine
                    lbra      Code_0434 ; continue at the distant control-flow target
Code_0688           lda       Addr_00D1 ; load the value needed by the following operation
                    beq       Code_0690 ; branch when the compared values are equal
                    lda       #$01      ; load the value needed by the following operation
                    bra       Code_0692 ; continue at the selected control-flow target
Code_0690           lda       #$FF      ; load the value needed by the following operation
Code_0692           sta       Addr_00D1 ; save the current value in working storage
                    lbsr      Code_0A0F ; call the referenced helper routine
                    lbra      Code_0434 ; continue at the distant control-flow target
Code_069A           cmpa      #$08      ; compare against the limit and set condition flags
                    bhi       Code_06B4 ; branch when the unsigned value is above the limit
                    beq       Code_06AA ; branch when the compared values are equal
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Code_00D2 ; save the current value in working storage
                    lbsr      Code_0A45 ; call the referenced helper routine
                    lbra      Code_0434 ; continue at the distant control-flow target
Code_06AA           lda       #$FF      ; load the value needed by the following operation
                    sta       Addr_00D3 ; save the current value in working storage
                    lbsr      Code_0A75 ; call the referenced helper routine
                    lbra      Code_0434 ; continue at the distant control-flow target
Code_06B4           cmpa      #$0A      ; compare against the limit and set condition flags
                    bcc       Code_06C2 ; branch when carry is clear
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Addr_00D4 ; save the current value in working storage
                    lbsr      Code_0AA5 ; call the referenced helper routine
                    lbra      Code_0434 ; continue at the distant control-flow target
Code_06C2           lda       #$FF      ; load the value needed by the following operation
                    sta       Code_00D5 ; save the current value in working storage
                    lbsr      Code_0AD5 ; call the referenced helper routine
                    lbra      Code_0434 ; continue at the distant control-flow target
                    lda       Addr_0033 ; load the value needed by the following operation
                    cmpa      #$04      ; compare against the limit and set condition flags
                    lbcs      Code_0434 ; take the distant branch when carry reports an error
                    bne       Code_06E5 ; branch when the compared values differ
                    lda       Addr_00CF ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    cmpa      #$03      ; compare against the limit and set condition flags
                    bhi       Code_06E2 ; branch when the unsigned value is above the limit
                    sta       Addr_00CF ; save the current value in working storage
                    lbsr      Code_0993 ; call the referenced helper routine
Code_06E2           lbra      Code_0434 ; continue at the distant control-flow target
Code_06E5           cmpa      #$06      ; compare against the limit and set condition flags
                    bhi       Code_0714 ; branch when the unsigned value is above the limit
                    beq       Code_0701 ; branch when the compared values are equal
                    lda       Code_00D0 ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    cmpa      #$02      ; compare against the limit and set condition flags
                    lbeq      Code_0434 ; take the distant branch when values are equal
                    cmpa      #$04      ; compare against the limit and set condition flags
                    bne       Code_06F9 ; branch when the compared values differ
                    clra                ; clear the selected byte or register
Code_06F9           sta       Code_00D0 ; save the current value in working storage
                    lbsr      Code_09D4 ; call the referenced helper routine
                    lbra      Code_0434 ; continue at the distant control-flow target
Code_0701           lda       Addr_00D1 ; load the value needed by the following operation
                    beq       Code_070C ; branch when the compared values are equal
                    bpl       Code_070A ; branch while the tested value is nonnegative
                    clra                ; clear the selected byte or register
                    bra       Code_070C ; continue at the selected control-flow target
Code_070A           lda       #$FF      ; load the value needed by the following operation
Code_070C           sta       Addr_00D1 ; save the current value in working storage
                    lbsr      Code_0A0F ; call the referenced helper routine
                    lbra      Code_0434 ; continue at the distant control-flow target
Code_0714           cmpa      #$08      ; compare against the limit and set condition flags
                    bhi       Code_072A ; branch when the unsigned value is above the limit
                    beq       Code_0722 ; branch when the compared values are equal
                    clr       Code_00D2 ; clear the selected byte or register
                    lbsr      Code_0A45 ; call the referenced helper routine
                    lbra      Code_0434 ; continue at the distant control-flow target
Code_0722           clr       Addr_00D3 ; clear the selected byte or register
                    lbsr      Code_0A75 ; call the referenced helper routine
                    lbra      Code_0434 ; continue at the distant control-flow target
Code_072A           cmpa      #$0A      ; compare against the limit and set condition flags
                    bcc       Code_0736 ; branch when carry is clear
                    clr       Addr_00D4 ; clear the selected byte or register
                    lbsr      Code_0AA5 ; call the referenced helper routine
                    lbra      Code_0434 ; continue at the distant control-flow target
Code_0736           clr       Code_00D5 ; clear the selected byte or register
                    lbsr      Code_0AD5 ; call the referenced helper routine
                    lbra      Code_0434 ; continue at the distant control-flow target
Data_073E           fcb       $0D,$00,$1E,$08,$00,$05 ; table, bitmap, or initialized data bytes
                    fcb       $09,$00,$10,$8A,$00,$02 ; table, bitmap, or initialized data bytes
                    fcb       $05,$00,$02,$AF,$FE ; table, bitmap, or initialized data bytes
                    fcc       "i"                            ; embedded text or resource bytes
                    fcb       $BA,$FE   ; table, bitmap, or initialized data bytes
                    fcc       "p"                            ; embedded text or resource bytes
                    fcb       $00,$03   ; table, bitmap, or initialized data bytes
                    fcc       "g"                            ; embedded text or resource bytes
                    fcb       $00,$04   ; table, bitmap, or initialized data bytes
                    clr       Addr_0034 ; clear the selected byte or register
                    lbsr      Code_04E9 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    sta       Addr_007A ; save the current value in working storage
                    lda       Addr_0034 ; load the value needed by the following operation
                    bne       Code_0769 ; branch when the compared values differ
                    lbsr      Code_0DB9 ; call the referenced helper routine
                    bra       Code_076C ; continue at the selected control-flow target
Code_0769           lbsr      Code_0DE5 ; call the referenced helper routine
Code_076C           lbsr      Code_012D ; call the referenced helper routine
                    leax      >Data_073E,PCR ; form the referenced address without reading memory
Code_0773           cmpa      ,X+       ; compare against the limit and set condition flags
                    beq       Code_077F ; branch when the compared values are equal
                    leax      $02,X     ; form the referenced address without reading memory
                    ldb       ,X        ; load the value needed by the following operation
                    bne       Code_0773 ; branch when the compared values differ
                    bra       Code_076C ; continue at the selected control-flow target
Code_077F           lda       #$83      ; load the value needed by the following operation
                    sta       Addr_007A ; save the current value in working storage
                    ldd       ,X        ; load the value needed by the following operation
                    tfr       PC,Y      ; copy the source register into the destination register
                    jmp       D,Y       ; dispatch control through the selected target
                    fcb       $16,$FC   ; table, bitmap, or initialized data bytes
                    fcc       "`"                            ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       "4'"                           ; embedded text or resource bytes
                    fcb       $CD,$0A   ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $17,$06   ; table, bitmap, or initialized data bytes
                    fcc       "T "                           ; embedded text or resource bytes
                    fcb       $C6,$96   ; table, bitmap, or initialized data bytes
                    fcc       "4L"                           ; embedded text or resource bytes
                    fcb       $81,$01,$22,$BF,$97 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $17,$06,$1A ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $B8,$96   ; table, bitmap, or initialized data bytes
                    fcc       "4H0"                          ; embedded text or resource bytes
                    fcb       $8D,$FF,$A8,$1F ; table, bitmap, or initialized data bytes
                    fcc       "R"                            ; embedded text or resource bytes
                    fcb       $EC,$86   ; table, bitmap, or initialized data bytes
                    fcc       "n"                            ; embedded text or resource bytes
                    fcb       $AB       ; table, bitmap, or initialized data bytes
Code_07B2           lbsr      Code_19F8 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    bne       Code_07BD ; branch when the compared values differ
                    lda       #$03      ; load the value needed by the following operation
                    lbsr      Code_0201 ; call the referenced helper routine
Code_07BD           lbra      Code_0423 ; continue at the distant control-flow target
                    lbsr      Code_0643 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    sta       Addr_0033 ; save the current value in working storage
                    lbsr      Code_0618 ; call the referenced helper routine
                    ldd       #Addr_020F ; load the value needed by the following operation
                    lbsr      Code_0E17 ; call the referenced helper routine
                    tfr       DP,A      ; copy the source register into the destination register
                    ldb       #$9C      ; load the value needed by the following operation
                    tfr       D,X       ; copy the source register into the destination register
                    lda       #$8A      ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
                    lbsr      Code_3061 ; call the referenced helper routine
                    lbsr      Code_08D5 ; call the referenced helper routine
                    lbra      Code_0434 ; continue at the distant control-flow target
                    lbsr      Code_0643 ; call the referenced helper routine
                    lda       #$01      ; load the value needed by the following operation
                    sta       Addr_0033 ; save the current value in working storage
                    lbsr      Code_0618 ; call the referenced helper routine
                    ldd       #Addr_040F ; load the value needed by the following operation
                    lbsr      Code_0E17 ; call the referenced helper routine
                    tfr       DP,A      ; copy the source register into the destination register
                    ldb       #$A7      ; load the value needed by the following operation
                    tfr       D,X       ; copy the source register into the destination register
                    lda       #$8F      ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
                    lbsr      Code_3061 ; call the referenced helper routine
                    lbsr      Code_08D5 ; call the referenced helper routine
                    lbra      Code_0434 ; continue at the distant control-flow target
                    lbsr      Code_0643 ; call the referenced helper routine
                    lda       #$02      ; load the value needed by the following operation
                    sta       Addr_0033 ; save the current value in working storage
                    lbsr      Code_0618 ; call the referenced helper routine
                    ldd       #Addr_060F ; load the value needed by the following operation
                    lbsr      Code_0E17 ; call the referenced helper routine
                    tfr       DP,A      ; copy the source register into the destination register
                    ldb       #$B7      ; load the value needed by the following operation
                    tfr       D,X       ; copy the source register into the destination register
                    lda       #$8F      ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
                    lbsr      Code_3061 ; call the referenced helper routine
                    lbsr      Code_08D5 ; call the referenced helper routine
                    lbra      Code_0434 ; continue at the distant control-flow target
                    lbsr      Code_0643 ; call the referenced helper routine
                    lda       #$03      ; load the value needed by the following operation
                    sta       Addr_0033 ; save the current value in working storage
                    lbsr      Code_0618 ; call the referenced helper routine
                    ldd       #Addr_080F ; load the value needed by the following operation
                    lbsr      Code_0E17 ; call the referenced helper routine
                    tfr       DP,A      ; copy the source register into the destination register
                    ldb       #$C7      ; load the value needed by the following operation
                    tfr       D,X       ; copy the source register into the destination register
                    lda       #$87      ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
                    lbsr      Code_3061 ; call the referenced helper routine
                    lbsr      Code_0963 ; call the referenced helper routine
                    lbsr      Code_2D88 ; call the referenced helper routine
                    lbra      Code_0434 ; continue at the distant control-flow target
                    fcb       $96,$CF   ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $81,$04   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $97,$CF,$17,$01 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $16,$FB,$DA,$96,$D0,$8B ; table, bitmap, or initialized data bytes
                    fcb       $01,$81,$04 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $97,$D0,$17,$01 ; table, bitmap, or initialized data bytes
                    fcc       "l"                            ; embedded text or resource bytes
                    fcb       $16,$FB,$C9,$96,$D1 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $07       ; table, bitmap, or initialized data bytes
                    fcc       "O "                           ; embedded text or resource bytes
                    fcb       $06,$86,$01 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $02,$86,$FF,$97,$D1,$17 ; table, bitmap, or initialized data bytes
                    fcb       $01,$90,$16,$FB,$B2,$96 ; table, bitmap, or initialized data bytes
                    fcb       $D2,$88,$FF,$97,$D2,$17 ; table, bitmap, or initialized data bytes
                    fcb       $01,$BA,$16,$FB,$A6,$96 ; table, bitmap, or initialized data bytes
                    fcb       $D3,$88,$FF,$97,$D3,$17 ; table, bitmap, or initialized data bytes
                    fcb       $01,$DE,$16,$FB,$9A,$96 ; table, bitmap, or initialized data bytes
                    fcb       $D4,$88,$FF,$97,$D4,$17 ; table, bitmap, or initialized data bytes
                    fcb       $02,$02,$16,$FB,$8E,$96 ; table, bitmap, or initialized data bytes
                    fcb       $D5,$88,$FF,$97,$D5,$17 ; table, bitmap, or initialized data bytes
                    fcb       $02,$26,$16,$FB,$82 ; table, bitmap, or initialized data bytes
Code_08B2           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    bsr       Code_08D5 ; call the referenced helper routine
                    lbsr      Code_0963 ; call the referenced helper routine
                    lbsr      Code_0993 ; call the referenced helper routine
                    lbsr      Code_09D4 ; call the referenced helper routine
                    lbsr      Code_0A0F ; call the referenced helper routine
                    lbsr      Code_0A45 ; call the referenced helper routine
                    lbsr      Code_0A75 ; call the referenced helper routine
                    lbsr      Code_0AA5 ; call the referenced helper routine
                    lbsr      Code_0AD5 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $16       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_08D5           ldd       #Code_0201 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    leax      Data_1FC3,PCR ; form the referenced address without reading memory
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "3"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "4"                            ; embedded text or resource bytes
                    ldd       #Addr_020F ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    tfr       DP,A      ; copy the source register into the destination register
                    ldb       #$9C      ; load the value needed by the following operation
                    tfr       D,X       ; copy the source register into the destination register
                    ldy       #Addr_000A ; load the value needed by the following operation
                    ldb       #$00      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $22       ; private DeskMate service selector
                    ldd       #Addr_0401 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    leax      Data_1FD2,PCR ; form the referenced address without reading memory
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "3"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "4"                            ; embedded text or resource bytes
                    ldd       #Addr_040F ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    tfr       DP,A      ; copy the source register into the destination register
                    ldb       #$A7      ; load the value needed by the following operation
                    tfr       D,X       ; copy the source register into the destination register
                    ldy       #Addr_000F ; load the value needed by the following operation
                    ldb       #$00      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $22       ; private DeskMate service selector
                    ldd       #Addr_0601 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    leax      Data_1FDD,PCR ; form the referenced address without reading memory
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "3"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "4"                            ; embedded text or resource bytes
                    ldd       #Addr_060F ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    tfr       DP,A      ; copy the source register into the destination register
                    ldb       #$B7      ; load the value needed by the following operation
                    tfr       D,X       ; copy the source register into the destination register
                    ldy       #Addr_000F ; load the value needed by the following operation
                    ldb       #$00      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $22       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_0963           ldd       #Addr_0801 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    leax      Data_1FE8,PCR ; form the referenced address without reading memory
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "3"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "4"                            ; embedded text or resource bytes
                    ldd       #Addr_080F ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    tfr       DP,A      ; copy the source register into the destination register
                    ldb       #$C7      ; load the value needed by the following operation
                    tfr       D,X       ; copy the source register into the destination register
                    ldy       #Addr_0007 ; load the value needed by the following operation
                    ldb       #$00      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $22       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_0993           ldd       #Addr_0A01 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    leax      Data_1FF4,PCR ; form the referenced address without reading memory
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "3"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "4"                            ; embedded text or resource bytes
                    lda       #$0A      ; load the value needed by the following operation
                    ldy       #Addr_0003 ; load the value needed by the following operation
                    ldb       Addr_00CF ; load the value needed by the following operation
                    beq       Code_09C9 ; branch when the compared values are equal
                    leay      $01,Y     ; form the referenced address without reading memory
                    cmpb      #$02      ; compare against the limit and set condition flags
                    bcs       Code_09C1 ; branch when carry reports an unsigned underflow or error
                    bhi       Code_09C5 ; branch when the unsigned value is above the limit
                    ldb       #$16      ; load the value needed by the following operation
                    bra       Code_09CB ; continue at the selected control-flow target
Code_09C1           ldb       #$11      ; load the value needed by the following operation
                    bra       Code_09CB ; continue at the selected control-flow target
Code_09C5           ldb       #$1B      ; load the value needed by the following operation
                    bra       Code_09CB ; continue at the selected control-flow target
Code_09C9           ldb       #$0D      ; load the value needed by the following operation
Code_09CB           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "$"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_09D4           ldd       #Addr_0C01 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    leax      Data_2016,PCR ; form the referenced address without reading memory
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "3"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "4"                            ; embedded text or resource bytes
                    ldb       #$16      ; load the value needed by the following operation
                    lda       Code_00D0 ; load the value needed by the following operation
                    beq       Code_0A00 ; branch when the compared values are equal
                    ldb       #$1A      ; load the value needed by the following operation
                    cmpa      #$02      ; compare against the limit and set condition flags
                    bcs       Code_0A00 ; branch when carry reports an unsigned underflow or error
                    bhi       Code_09FE ; branch when the unsigned value is above the limit
                    ldb       #$0D      ; load the value needed by the following operation
                    bra       Code_0A00 ; continue at the selected control-flow target
Code_09FE           ldb       #$11      ; load the value needed by the following operation
Code_0A00           lda       #$0C      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    ldy       #Addr_0003 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "$"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_0A0F           ldd       #Code_0E01 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    leax      Data_2038,PCR ; form the referenced address without reading memory
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "3"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "4"                            ; embedded text or resource bytes
                    ldd       #Addr_0E1A ; load the value needed by the following operation
                    ldy       #Addr_0004 ; load the value needed by the following operation
                    tst       Addr_00D1 ; set condition flags from the current value
                    beq       Code_0A3C ; branch when the compared values are equal
                    bpl       Code_0A3A ; branch while the tested value is nonnegative
                    ldb       #$14      ; load the value needed by the following operation
                    leay      -$01,Y    ; form the referenced address without reading memory
                    bra       Code_0A3C ; continue at the selected control-flow target
Code_0A3A           ldb       #$0D      ; load the value needed by the following operation
Code_0A3C           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "$"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_0A45           ldd       #Addr_1001 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    leax      Data_2058,PCR ; form the referenced address without reading memory
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "3"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "4"                            ; embedded text or resource bytes
                    ldd       #Code_100D ; load the value needed by the following operation
                    ldy       #Addr_0002 ; load the value needed by the following operation
                    tst       Code_00D2 ; set condition flags from the current value
                    bne       Code_0A6C ; branch when the compared values differ
                    ldb       #$16      ; load the value needed by the following operation
                    leay      $01,Y     ; form the referenced address without reading memory
Code_0A6C           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "$"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_0A75           ldd       #Code_1201 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    leax      Data_2075,PCR ; form the referenced address without reading memory
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "3"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "4"                            ; embedded text or resource bytes
                    ldd       #Addr_120D ; load the value needed by the following operation
                    ldy       #Addr_0002 ; load the value needed by the following operation
                    tst       Addr_00D3 ; set condition flags from the current value
                    bne       Code_0A9C ; branch when the compared values differ
                    ldb       #$16      ; load the value needed by the following operation
                    leay      $01,Y     ; form the referenced address without reading memory
Code_0A9C           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "$"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_0AA5           ldd       #Code_1401 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    leax      Data_2091,PCR ; form the referenced address without reading memory
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "3"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "4"                            ; embedded text or resource bytes
                    ldd       #Code_140D ; load the value needed by the following operation
                    ldy       #Addr_0002 ; load the value needed by the following operation
                    tst       Addr_00D4 ; set condition flags from the current value
                    bne       Code_0ACC ; branch when the compared values differ
                    ldb       #$16      ; load the value needed by the following operation
                    leay      $01,Y     ; form the referenced address without reading memory
Code_0ACC           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "$"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_0AD5           ldd       #Addr_1601 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    leax      Data_20AB,PCR ; form the referenced address without reading memory
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "3"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "4"                            ; embedded text or resource bytes
                    ldd       #Data_160D ; load the value needed by the following operation
                    ldy       #Addr_0002 ; load the value needed by the following operation
                    tst       Code_00D5 ; set condition flags from the current value
                    bne       Code_0AFC ; branch when the compared values differ
                    ldb       #$16      ; load the value needed by the following operation
                    leay      $01,Y     ; form the referenced address without reading memory
Code_0AFC           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "$"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Data_0B05           fcb       $00       ; table, bitmap, or initialized data bytes
Data_0B06           fcb       $06,$00   ; table, bitmap, or initialized data bytes
                    fcc       "S"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "l"                            ; embedded text or resource bytes
                    fcb       $00,$CD   ; table, bitmap, or initialized data bytes
Data_0B0D           fcb       $00,$00,$01,$09,$06,$00 ; table, bitmap, or initialized data bytes
                    fcb       $AA,$E0   ; table, bitmap, or initialized data bytes
Code_0B15           leax      >Data_0B0D,PCR ; form the referenced address without reading memory
                    lbsr      Code_1267 ; call the referenced helper routine
                    tfr       DP,A      ; copy the source register into the destination register
                    ldb       #$19      ; load the value needed by the following operation
                    std       Code_003C ; save the current value in working storage
                    tfr       D,X       ; copy the source register into the destination register
                    leau      Data_1E00,PCR ; form the referenced address without reading memory
                    stu       ,X++      ; store the value and advance the destination pointer
                    leau      Data_1E07,PCR ; form the referenced address without reading memory
                    stu       ,X++      ; store the value and advance the destination pointer
                    leau      Data_1E0F,PCR ; form the referenced address without reading memory
                    stu       ,X++      ; store the value and advance the destination pointer
                    leau      Data_1E37,PCR ; form the referenced address without reading memory
                    stu       ,X        ; save the current value in working storage
                    lda       #$04      ; load the value needed by the following operation
                    sta       Code_003E ; save the current value in working storage
                    sta       Addr_0040 ; save the current value in working storage
                    lda       #$07      ; load the value needed by the following operation
                    sta       Code_003F ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    sta       Code_0041 ; save the current value in working storage
                    sta       Addr_0042 ; save the current value in working storage
                    tfr       DP,A      ; copy the source register into the destination register
                    ldb       #$3C      ; load the value needed by the following operation
                    tfr       D,X       ; copy the source register into the destination register
                    clra                ; clear the selected byte or register
                    lbsr      Code_2E36 ; call the referenced helper routine
Code_0B55           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    lbsr      Code_2F46 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    cmpb      #$0D      ; compare against the limit and set condition flags
                    beq       Code_0B71 ; branch when the compared values are equal
                    cmpb      #$AF      ; compare against the limit and set condition flags
                    lbeq      Code_0C50 ; take the distant branch when values are equal
                    cmpb      #$05      ; compare against the limit and set condition flags
                    bne       Code_0B55 ; branch when the compared values differ
                    lbra      Code_0423 ; continue at the distant control-flow target
Code_0B71           pshs      A         ; preserve the listed registers on the stack
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    puls      A         ; restore the listed registers from the stack
                    leax      >Data_0B05,PCR ; form the referenced address without reading memory
                    asla                ; shift left and update carry
                    ldd       A,X       ; load the value needed by the following operation
                    tfr       PC,Y      ; copy the source register into the destination register
                    jmp       D,Y       ; dispatch control through the selected target
Data_0B85           fcc       "DMC"                          ; embedded text or resource bytes
                    fcb       $00,$96,$82,$C6,$DB,$DD ; table, bitmap, or initialized data bytes
                    fcc       "50"                           ; embedded text or resource bytes
                    fcb       $8D,$FF,$F2,$9F ; table, bitmap, or initialized data bytes
                    fcc       "7"                            ; embedded text or resource bytes
                    fcb       $C6,$F5,$DD ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $1F,$B8,$C6 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $1F,$02,$86 ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $17       ; table, bitmap, or initialized data bytes
                    fcc       ")#M"                          ; embedded text or resource bytes
                    fcb       $26,$1F,$86,$01,$9E ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $84       ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $19,$97,$11,$1F,$B8,$C6 ; table, bitmap, or initialized data bytes
                    fcb       $9C,$1F,$01,$10,$8E,$00 ; table, bitmap, or initialized data bytes
                    fcc       ":"                            ; embedded text or resource bytes
                    fcb       $96,$11,$10 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $89,$96,$11,$10 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $8F,$16,$F8 ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $17,$0C,$93 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $F8       ; table, bitmap, or initialized data bytes
Data_0BCE           fcb       $00,$04,$07,$18,$03,$00 ; table, bitmap, or initialized data bytes
                    fcb       $FF,$E0   ; table, bitmap, or initialized data bytes
                    leax      >Data_0BCE,PCR ; form the referenced address without reading memory
                    lbsr      Code_1579 ; call the referenced helper routine
                    lda       Code_0032 ; load the value needed by the following operation
                    lbmi      Code_03EC ; take the distant branch while the value is negative
                    bne       Code_0BE7 ; branch when the compared values differ
                    bsr       Code_0BF4 ; call the referenced helper routine
Code_0BE7           lbsr      Code_2D88 ; call the referenced helper routine
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "W"                            ; embedded text or resource bytes
                    bsr       Code_0BF4 ; call the referenced helper routine
                    lbra      Code_0423 ; continue at the distant control-flow target
Code_0BF4           tfr       DP,A      ; copy the source register into the destination register
                    ldb       #$9C      ; load the value needed by the following operation
                    std       Code_0035 ; save the current value in working storage
                    leax      >Data_0B85,PCR ; form the referenced address without reading memory
                    stx       Code_0037 ; save the current value in working storage
                    lda       Addr_0082 ; load the value needed by the following operation
                    ldb       #$F5      ; load the value needed by the following operation
                    std       Addr_0039 ; save the current value in working storage
                    ldb       #$35      ; load the value needed by the following operation
                    tfr       D,Y       ; copy the source register into the destination register
                    lda       #$41      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "J"                            ; embedded text or resource bytes
                    ldx       $04,Y     ; load the value needed by the following operation
                    ldd       #Addr_0203 ; load the value needed by the following operation
                    os9       I$Create  ; request the named OS-9 service
                    bcs       Code_0C42 ; branch when carry reports an unsigned underflow or error
Code_0C1A           sta       Addr_0011 ; save the current value in working storage
                    ldy       #Code_003A ; load the value needed by the following operation
                    tfr       DP,A      ; copy the source register into the destination register
                    ldb       #$9C      ; load the value needed by the following operation
                    tfr       D,X       ; copy the source register into the destination register
                    lda       Addr_0011 ; load the value needed by the following operation
                    os9       I$Write   ; request the named OS-9 service
                    pshs      CC        ; preserve the listed registers on the stack
                    lda       Addr_0011 ; load the value needed by the following operation
                    os9       I$Close   ; request the named OS-9 service
                    puls      CC        ; restore the listed registers from the stack
                    bcc       Code_0C41 ; branch when carry is clear
                    tfr       DP,A      ; copy the source register into the destination register
                    ldb       #$F5      ; load the value needed by the following operation
                    tfr       D,X       ; copy the source register into the destination register
                    os9       I$Delete  ; request the named OS-9 service
                    bra       Code_0C4B ; continue at the selected control-flow target
Code_0C41           rts                 ; return to the caller
Code_0C42           lda       #$02      ; load the value needed by the following operation
                    os9       I$Open    ; request the named OS-9 service
                    bcs       Code_0C4B ; branch when carry reports an unsigned underflow or error
                    bra       Code_0C1A ; continue at the selected control-flow target
Code_0C4B           lbsr      Code_185F ; call the referenced helper routine
                    bra       Code_0C41 ; continue at the selected control-flow target
Code_0C50           clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    lda       #$01      ; load the value needed by the following operation
                    lbsr      Code_0201 ; call the referenced helper routine
                    lbra      Code_0423 ; continue at the distant control-flow target
Code_0C5D           clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    lbsr      Code_0E27 ; call the referenced helper routine
                    bsr       Code_0C79 ; call the referenced helper routine
                    lbsr      Code_0DBD ; call the referenced helper routine
                    lbsr      Code_0DE9 ; call the referenced helper routine
                    bsr       Code_0CE1 ; call the referenced helper routine
                    lbsr      Code_0D16 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_0C79           ldb       Code_009A ; load the value needed by the following operation
                    ldx       #DeskMateService ; load the value needed by the following operation
                    ldy       #DeskMateService ; load the value needed by the following operation
                    pshs      U         ; preserve the listed registers on the stack
                    ldu       #Data_026C ; load the value needed by the following operation
                    lda       #$0E      ; load the value needed by the following operation
Code_0C89           pshs      A         ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $11       ; private DeskMate service selector
                    leay      $01,Y     ; form the referenced address without reading memory
                    puls      A         ; restore the listed registers from the stack
                    deca                ; decrement the selected counter
                    bne       Code_0C89 ; branch when the compared values differ
                    puls      U         ; restore the listed registers from the stack
                    rts                 ; return to the caller
Data_0C99           fcb       $00,$01,$B8,$00,$00,$01 ; table, bitmap, or initialized data bytes
                    fcb       $D8,$00,$0D ; table, bitmap, or initialized data bytes
Data_0CA2           fcb       $00,$01,$E0,$00,$00,$02 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$0D ; table, bitmap, or initialized data bytes
Data_0CAB           fcb       $00,$02,$08,$00,$00,$02 ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $00,$0D   ; table, bitmap, or initialized data bytes
Data_0CB4           fcb       $00,$02   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $00,$00,$02 ; table, bitmap, or initialized data bytes
                    fcc       "R"                            ; embedded text or resource bytes
                    fcb       $00,$0D   ; table, bitmap, or initialized data bytes
Data_0CBD           fcb       $00,$01,$AF,$00,$00,$01 ; table, bitmap, or initialized data bytes
                    fcb       $CF,$00,$0D ; table, bitmap, or initialized data bytes
Data_0CC6           fcb       $00,$01,$D7,$00,$00,$01 ; table, bitmap, or initialized data bytes
                    fcb       $F7,$00,$0D ; table, bitmap, or initialized data bytes
Data_0CCF           fcb       $00,$01,$FF,$00,$00,$02 ; table, bitmap, or initialized data bytes
                    fcb       $1F,$00,$0D ; table, bitmap, or initialized data bytes
Data_0CD8           fcb       $00,$02   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $00,$00,$02 ; table, bitmap, or initialized data bytes
                    fcc       "I"                            ; embedded text or resource bytes
                    fcb       $00,$0D   ; table, bitmap, or initialized data bytes
Code_0CE1           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    ldd       #Code_0137 ; load the value needed by the following operation
                    leax      Data_1CC8,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    lda       Code_009A ; load the value needed by the following operation
                    bra       Code_0CFB ; continue at the selected control-flow target
Code_0CF4           lda       #$FF      ; load the value needed by the following operation
                    tst       Addr_009B ; set condition flags from the current value
                    bne       Code_0CFB ; branch when the compared values differ
                    clra                ; clear the selected byte or register
Code_0CFB           leax      >Data_0C99,PCR ; form the referenced address without reading memory
                    tst       Addr_009B ; set condition flags from the current value
                    bne       Code_0D07 ; branch when the compared values differ
                    leax      >Data_0CBD,PCR ; form the referenced address without reading memory
Code_0D07           sta       ,X        ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $13       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_0D16           ldd       #Addr_0146 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    leax      Data_1D16,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    lda       Code_009A ; load the value needed by the following operation
                    bra       Code_0D30 ; continue at the selected control-flow target
Code_0D29           lda       #$FF      ; load the value needed by the following operation
                    tst       Addr_009B ; set condition flags from the current value
                    bne       Code_0D30 ; branch when the compared values differ
                    clra                ; clear the selected byte or register
Code_0D30           leax      >Data_0CB4,PCR ; form the referenced address without reading memory
                    tst       Addr_009B ; set condition flags from the current value
                    bne       Code_0D3C ; branch when the compared values differ
                    leax      >Data_0CD8,PCR ; form the referenced address without reading memory
Code_0D3C           sta       ,X        ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $13       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_0D4B           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    ldd       #Addr_013C ; load the value needed by the following operation
                    leax      Data_1D64,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    lda       Code_009A ; load the value needed by the following operation
                    bra       Code_0D65 ; continue at the selected control-flow target
Code_0D5E           lda       #$FF      ; load the value needed by the following operation
                    tst       Addr_009B ; set condition flags from the current value
                    bne       Code_0D65 ; branch when the compared values differ
                    clra                ; clear the selected byte or register
Code_0D65           leax      Data_0CA2,PCR ; form the referenced address without reading memory
                    tst       Addr_009B ; set condition flags from the current value
                    bne       Code_0D71 ; branch when the compared values differ
                    leax      Data_0CC6,PCR ; form the referenced address without reading memory
Code_0D71           sta       ,X        ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $13       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_0D80           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    ldd       #Addr_0141 ; load the value needed by the following operation
                    leax      Data_1DB2,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    lda       Code_009A ; load the value needed by the following operation
                    bra       Code_0D9E ; continue at the selected control-flow target
Code_0D97           lda       #$FF      ; load the value needed by the following operation
                    tst       Addr_009B ; set condition flags from the current value
                    bne       Code_0D9E ; branch when the compared values differ
                    clra                ; clear the selected byte or register
Code_0D9E           leax      Data_0CAB,PCR ; form the referenced address without reading memory
                    tst       Addr_009B ; set condition flags from the current value
                    bne       Code_0DAA ; branch when the compared values differ
                    leax      Data_0CCF,PCR ; form the referenced address without reading memory
Code_0DAA           sta       ,X        ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $13       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_0DB9           lda       #$40      ; load the value needed by the following operation
                    bra       Code_0DBE ; continue at the selected control-flow target
Code_0DBD           clra                ; clear the selected byte or register
Code_0DBE           pshs      A         ; preserve the listed registers on the stack
                    lda       #$03      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    ldd       #Addr_0001 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    puls      B         ; restore the listed registers from the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    leax      Data_20C5,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "6"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_0DE5           lda       #$40      ; load the value needed by the following operation
                    bra       Code_0DEA ; continue at the selected control-flow target
Code_0DE9           clra                ; clear the selected byte or register
Code_0DEA           pshs      A         ; preserve the listed registers on the stack
                    lda       #$03      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    ldd       #Addr_0007 ; load the value needed by the following operation
                    tst       Addr_009B ; set condition flags from the current value
                    bne       Code_0DFB ; branch when the compared values differ
                    ldb       #$0E      ; load the value needed by the following operation
Code_0DFB           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    puls      B         ; restore the listed registers from the stack
Code_0E01           leax      Data_20CA,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "6"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_0E17           pshs      Y,X,D     ; preserve the listed registers on the stack
                    pshs      A         ; preserve the listed registers on the stack
                    tfr       D,X       ; copy the source register into the destination register
                    ldb       ,S+       ; load the value needed by the following operation
                    tfr       D,Y       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    puls      PC,Y,X,D  ; restore the listed registers from the stack
Code_0E27           pshs      Y,X,D     ; preserve the listed registers on the stack
                    leax      >Data_0E33,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    puls      PC,Y,X,D  ; restore the listed registers from the stack
Data_0E33           fcb       $00,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $18,$00,$00,$AA ; table, bitmap, or initialized data bytes
Data_0E3B           fcb       $01,$08,$01,$0E,$15,$02 ; table, bitmap, or initialized data bytes
                    fcc       "7:"                           ; embedded text or resource bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "FI"                           ; embedded text or resource bytes
                    fcb       $04,$FF   ; table, bitmap, or initialized data bytes
Data_0E48           fcb       $01,$08,$01,$0E,$15,$02 ; table, bitmap, or initialized data bytes
                    fcc       "7:"                           ; embedded text or resource bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "<?"                           ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "AD"                           ; embedded text or resource bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
                    fcc       "FI"                           ; embedded text or resource bytes
                    fcb       $06,$FF   ; table, bitmap, or initialized data bytes
Data_0E5B           fcb       $01,$08,$01,$0E,$11,$02 ; table, bitmap, or initialized data bytes
                    fcc       "78"                           ; embedded text or resource bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "<="                           ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "AB"                           ; embedded text or resource bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
                    fcc       "FG"                           ; embedded text or resource bytes
                    fcb       $06,$FF,$01,$08,$01,$0E ; table, bitmap, or initialized data bytes
                    fcb       $15,$02,$1C ; table, bitmap, or initialized data bytes
                    fcc       "#"                            ; embedded text or resource bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "7:"                           ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "FI"                           ; embedded text or resource bytes
                    fcb       $05,$FF,$01,$08,$01,$0E ; table, bitmap, or initialized data bytes
                    fcb       $11,$02,$1C,$1F,$03 ; table, bitmap, or initialized data bytes
                    fcc       "78"                           ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "FG"                           ; embedded text or resource bytes
                    fcb       $05,$FF   ; table, bitmap, or initialized data bytes
Code_0E8E           pshs      X         ; preserve the listed registers on the stack
                    leax      >Data_0E3B,PCR ; form the referenced address without reading memory
                    lbsr      Code_0EBC ; call the referenced helper routine
                    puls      PC,X      ; restore the listed registers from the stack
Code_0E99           pshs      X         ; preserve the listed registers on the stack
                    leax      >Data_0E48,PCR ; form the referenced address without reading memory
                    tst       Addr_009B ; set condition flags from the current value
                    bne       Code_0EA7 ; branch when the compared values differ
                    leax      >Data_0E5B,PCR ; form the referenced address without reading memory
Code_0EA7           lbsr      Code_0EBC ; call the referenced helper routine
                    puls      PC,X      ; restore the listed registers from the stack
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FF,$BC,$0D,$9B,$26 ; table, bitmap, or initialized data bytes
                    fcb       $F1       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FF,$C4 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $EB       ; table, bitmap, or initialized data bytes
Code_0EBC           lda       #$FF      ; load the value needed by the following operation
                    cmpa      ,X        ; compare against the limit and set condition flags
                    beq       Code_0ED1 ; branch when the compared values are equal
                    cmpb      ,X        ; compare against the limit and set condition flags
                    bcs       Code_0ED1 ; branch when carry reports an unsigned underflow or error
                    cmpb      $01,X     ; compare against the limit and set condition flags
                    bhi       Code_0ECD ; branch when the unsigned value is above the limit
                    lda       $02,X     ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_0ECD           leax      $03,X     ; form the referenced address without reading memory
                    bra       Code_0EBC ; continue at the selected control-flow target
Code_0ED1           clra                ; clear the selected byte or register
                    rts                 ; return to the caller
Data_0ED3           fcb       $0A,$0C,$26,$0C,$0C,$99 ; table, bitmap, or initialized data bytes
                    fcb       $8C,$01,$9F,$B2,$06,$DE ; table, bitmap, or initialized data bytes
                    fcb       $B8,$08   ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $B9,$09,$05,$B6,$12,$0A ; table, bitmap, or initialized data bytes
                    fcb       $B7,$F4   ; table, bitmap, or initialized data bytes
                    fcc       "v"                            ; embedded text or resource bytes
                    fcb       $C6,$02,$1A,$D6,$0A ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $1A,$0C,$15,$1C,$0C ; table, bitmap, or initialized data bytes
                    fcc       "c"                            ; embedded text or resource bytes
                    fcb       $12,$0C,$D4,$13,$0C,$CE ; table, bitmap, or initialized data bytes
                    fcb       $AF,$01   ; table, bitmap, or initialized data bytes
                    fcc       "y"                            ; embedded text or resource bytes
                    fcb       $BA,$01,$7F,$05,$05,$E0 ; table, bitmap, or initialized data bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_0F07           fcc       "DOC"                          ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_0F0B           clr       Addr_00D6 ; clear the selected byte or register
                    clr       Addr_00D7 ; clear the selected byte or register
                    lda       #$80      ; load the value needed by the following operation
                    sta       Addr_007A ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "N"                            ; embedded text or resource bytes
                    tst       $24,X     ; set condition flags from the current value
                    beq       Code_0F24 ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $14       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $16       ; private DeskMate service selector
Code_0F24           lbsr      Code_027C ; call the referenced helper routine
                    lbsr      Code_13B7 ; call the referenced helper routine
                    stx       Addr_000A ; save the current value in working storage
Code_0F2C           lds       DeskMateService ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "-"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $00       ; private DeskMate service selector
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    clr       Addr_007F ; clear the selected byte or register
                    lbsr      Code_0C79 ; call the referenced helper routine
                    lbsr      Code_10DA ; call the referenced helper routine
                    lds       DeskMateService ; load the value needed by the following operation
                    lbsr      Code_1C89 ; call the referenced helper routine
Code_0F4B           lda       #$02      ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    lds       DeskMateService ; load the value needed by the following operation
                    lbsr      Code_1A7B ; call the referenced helper routine
                    ldd       #Addr_FFFF ; load the value needed by the following operation
                    std       Code_007B ; save the current value in working storage
Code_0F5D           lbsr      Code_012D ; call the referenced helper routine
                    bcs       Code_0F7B ; branch when carry reports an unsigned underflow or error
                    leax      Data_0ED3,PCR ; form the referenced address without reading memory
Code_0F66           cmpa      ,X+       ; compare against the limit and set condition flags
                    beq       Code_0F72 ; branch when the compared values are equal
                    leax      $02,X     ; form the referenced address without reading memory
                    ldb       ,X        ; load the value needed by the following operation
                    bne       Code_0F66 ; branch when the compared values differ
                    bra       Code_0F5D ; continue at the selected control-flow target
Code_0F72           ldd       ,X        ; load the value needed by the following operation
                    tfr       PC,Y      ; copy the source register into the destination register
                    jsr       D,Y       ; call the referenced helper routine
                    lbra      Code_0F4B ; continue at the distant control-flow target
Code_0F7B           tsta                ; set condition flags from the current value
                    lbmi      Code_102D ; take the distant branch while the value is negative
                    cmpa      #$01      ; compare against the limit and set condition flags
                    beq       Code_0FB8 ; branch when the compared values are equal
                    cmpa      #$03      ; compare against the limit and set condition flags
                    beq       Code_0FB8 ; branch when the compared values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    lbeq      Code_1005 ; take the distant branch when values are equal
                    cmpa      #$02      ; compare against the limit and set condition flags
                    bne       Code_0F5D ; branch when the compared values differ
                    tfr       U,D       ; copy the source register into the destination register
                    cmpa      #$01      ; compare against the limit and set condition flags
                    bhi       Code_0F5D ; branch when the unsigned value is above the limit
                    lbsr      Code_0E99 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    lbeq      Code_0F5D ; take the distant branch when values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    lbne      Code_0FAC ; take the distant branch when values differ
                    lbsr      Code_1B8B ; call the referenced helper routine
                    lbra      Code_0F4B ; continue at the distant control-flow target
Code_0FAC           cmpa      #$04      ; compare against the limit and set condition flags
                    lbne      Code_0F5D ; take the distant branch when values differ
                    lbsr      Code_1BD9 ; call the referenced helper routine
                    lbra      Code_0F4B ; continue at the distant control-flow target
Code_0FB8           tfr       U,D       ; copy the source register into the destination register
                    cmpa      #$01      ; compare against the limit and set condition flags
                    bhi       Code_0F5D ; branch when the unsigned value is above the limit
                    lbsr      Code_0E99 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    lbeq      Code_0F5D ; take the distant branch when values are equal
                    deca                ; decrement the selected counter
                    lbne      Code_0FD1 ; take the distant branch when values differ
                    lbsr      Code_1190 ; call the referenced helper routine
                    lbra      Code_0F4B ; continue at the distant control-flow target
Code_0FD1           deca                ; decrement the selected counter
                    lbne      Code_0FDC ; take the distant branch when values differ
                    lbsr      Code_19D2 ; call the referenced helper routine
                    lbra      Code_0F4B ; continue at the distant control-flow target
Code_0FDC           deca                ; decrement the selected counter
                    lbne      Code_0FE9 ; take the distant branch when values differ
                    lda       #$02      ; load the value needed by the following operation
                    lbsr      Code_0201 ; call the referenced helper routine
                    lbra      Code_0F4B ; continue at the distant control-flow target
Code_0FE9           deca                ; decrement the selected counter
                    lbne      Code_0FF4 ; take the distant branch when values differ
                    lbsr      Code_1C0F ; call the referenced helper routine
                    lbra      Code_0F4B ; continue at the distant control-flow target
Code_0FF4           deca                ; decrement the selected counter
                    lbne      Code_0FFF ; take the distant branch when values differ
                    lbsr      Code_1B9C ; call the referenced helper routine
                    lbra      Code_0F4B ; continue at the distant control-flow target
Code_0FFF           lbsr      Code_0241 ; call the referenced helper routine
                    lbra      Code_0F2C ; continue at the distant control-flow target
Code_1005           tfr       U,D       ; copy the source register into the destination register
                    cmpa      #$01      ; compare against the limit and set condition flags
                    lbhi      Code_0F5D ; take the distant branch for unsigned higher
Code_100D           lbsr      Code_0E99 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    lbeq      Code_0F5D ; take the distant branch when values are equal
                    cmpa      #$04      ; compare against the limit and set condition flags
                    lbne      Code_1021 ; take the distant branch when values differ
                    lbsr      Code_1C44 ; call the referenced helper routine
                    lbra      Code_0F4B ; continue at the distant control-flow target
Code_1021           cmpa      #$05      ; compare against the limit and set condition flags
                    lbne      Code_0F5D ; take the distant branch when values differ
                    lbsr      Code_1C4A ; call the referenced helper routine
                    lbra      Code_0F4B ; continue at the distant control-flow target
Code_102D           tfr       U,D       ; copy the source register into the destination register
                    cmpa      #$01      ; compare against the limit and set condition flags
                    lbhi      Code_10CF ; take the distant branch for unsigned higher
                    lbsr      Code_0E99 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    lbeq      Code_0F5D ; take the distant branch when values are equal
                    deca                ; decrement the selected counter
                    lbne      Code_1057 ; take the distant branch when values differ
                    lda       Addr_007F ; load the value needed by the following operation
                    cmpa      #$01      ; compare against the limit and set condition flags
                    lbeq      Code_0F5D ; take the distant branch when values are equal
                    lbsr      Code_10DA ; call the referenced helper routine
                    lbsr      Code_0DB9 ; call the referenced helper routine
                    lda       #$01      ; load the value needed by the following operation
                    sta       Addr_007F ; save the current value in working storage
                    lbra      Code_0F5D ; continue at the distant control-flow target
Code_1057           deca                ; decrement the selected counter
                    lbne      Code_1070 ; take the distant branch when values differ
                    lda       Addr_007F ; load the value needed by the following operation
                    cmpa      #$02      ; compare against the limit and set condition flags
                    lbeq      Code_0F5D ; take the distant branch when values are equal
                    bsr       Code_10DA ; call the referenced helper routine
                    lbsr      Code_0DE5 ; call the referenced helper routine
                    lda       #$02      ; load the value needed by the following operation
                    sta       Addr_007F ; save the current value in working storage
                    lbra      Code_0F5D ; continue at the distant control-flow target
Code_1070           deca                ; decrement the selected counter
                    lbne      Code_1089 ; take the distant branch when values differ
                    lda       Addr_007F ; load the value needed by the following operation
                    cmpa      #$03      ; compare against the limit and set condition flags
                    lbeq      Code_0F5D ; take the distant branch when values are equal
                    bsr       Code_10DA ; call the referenced helper routine
                    lbsr      Code_0CF4 ; call the referenced helper routine
                    lda       #$03      ; load the value needed by the following operation
                    sta       Addr_007F ; save the current value in working storage
                    lbra      Code_0F5D ; continue at the distant control-flow target
Code_1089           deca                ; decrement the selected counter
                    lbne      Code_10A2 ; take the distant branch when values differ
                    lda       Addr_007F ; load the value needed by the following operation
                    cmpa      #$04      ; compare against the limit and set condition flags
                    lbeq      Code_0F5D ; take the distant branch when values are equal
                    bsr       Code_10DA ; call the referenced helper routine
                    lbsr      Code_0D5E ; call the referenced helper routine
                    lda       #$04      ; load the value needed by the following operation
                    sta       Addr_007F ; save the current value in working storage
                    lbra      Code_0F5D ; continue at the distant control-flow target
Code_10A2           deca                ; decrement the selected counter
                    lbne      Code_10BB ; take the distant branch when values differ
                    lda       Addr_007F ; load the value needed by the following operation
                    cmpa      #$05      ; compare against the limit and set condition flags
                    lbeq      Code_0F5D ; take the distant branch when values are equal
                    bsr       Code_10DA ; call the referenced helper routine
                    lbsr      Code_0D97 ; call the referenced helper routine
                    lda       #$05      ; load the value needed by the following operation
                    sta       Addr_007F ; save the current value in working storage
                    lbra      Code_0F5D ; continue at the distant control-flow target
Code_10BB           lda       Addr_007F ; load the value needed by the following operation
                    cmpa      #$06      ; compare against the limit and set condition flags
                    lbeq      Code_0F5D ; take the distant branch when values are equal
                    bsr       Code_10DA ; call the referenced helper routine
                    lbsr      Code_0D29 ; call the referenced helper routine
                    lda       #$06      ; load the value needed by the following operation
                    sta       Addr_007F ; save the current value in working storage
                    lbra      Code_0F5D ; continue at the distant control-flow target
Code_10CF           lda       Addr_007F ; load the value needed by the following operation
                    lbeq      Code_0F5D ; take the distant branch when values are equal
                    bsr       Code_10DA ; call the referenced helper routine
                    lbra      Code_0F5D ; continue at the distant control-flow target
Code_10DA           lbsr      Code_0DBD ; call the referenced helper routine
                    lbsr      Code_0DE9 ; call the referenced helper routine
                    lbsr      Code_0CE1 ; call the referenced helper routine
                    lbsr      Code_0D4B ; call the referenced helper routine
                    lbsr      Code_0D80 ; call the referenced helper routine
                    lbsr      Code_0D16 ; call the referenced helper routine
                    clr       Addr_007F ; clear the selected byte or register
                    rts                 ; return to the caller
                    lda       #$02      ; load the value needed by the following operation
                    lbsr      Code_0201 ; call the referenced helper routine
                    rts                 ; return to the caller
                    lbsr      Code_0241 ; call the referenced helper routine
                    lbra      Code_0F2C ; continue at the distant control-flow target
Data_10FB           fcb       $0D,$00,$1E,$08,$00,$05 ; table, bitmap, or initialized data bytes
                    fcb       $09,$00,$10,$8A,$00,$02 ; table, bitmap, or initialized data bytes
                    fcb       $05,$00,$02,$AF,$FF,$AA ; table, bitmap, or initialized data bytes
                    fcb       $BA,$FF,$B0,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $08       ; table, bitmap, or initialized data bytes
                    fcc       "f"                            ; embedded text or resource bytes
                    clr       Addr_0034 ; clear the selected byte or register
                    lda       Addr_007F ; load the value needed by the following operation
                    beq       Code_111E ; branch when the compared values are equal
                    lbsr      Code_10DA ; call the referenced helper routine
Code_111E           lda       Addr_0034 ; load the value needed by the following operation
                    bne       Code_1127 ; branch when the compared values differ
                    lbsr      Code_0DB9 ; call the referenced helper routine
                    bra       Code_112A ; continue at the selected control-flow target
Code_1127           lbsr      Code_0DE5 ; call the referenced helper routine
Code_112A           lbsr      Code_012D ; call the referenced helper routine
                    leax      >Data_10FB,PCR ; form the referenced address without reading memory
Code_1131           cmpa      ,X+       ; compare against the limit and set condition flags
                    beq       Code_113D ; branch when the compared values are equal
                    leax      $02,X     ; form the referenced address without reading memory
                    ldb       ,X        ; load the value needed by the following operation
                    bne       Code_1131 ; branch when the compared values differ
                    bra       Code_112A ; continue at the selected control-flow target
Code_113D           pshs      X         ; preserve the listed registers on the stack
                    puls      X         ; restore the listed registers from the stack
                    ldd       ,X        ; load the value needed by the following operation
                    tfr       PC,Y      ; copy the source register into the destination register
                    jmp       D,Y       ; dispatch control through the selected target
                    fcb       $16,$FD,$E2,$96 ; table, bitmap, or initialized data bytes
                    fcc       "4'"                           ; embedded text or resource bytes
                    fcb       $D0,$0A   ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $17,$FC,$96 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $C9,$96   ; table, bitmap, or initialized data bytes
                    fcc       "4L"                           ; embedded text or resource bytes
                    fcb       $81,$01,$22,$C2,$97 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $17,$FC   ; table, bitmap, or initialized data bytes
                    fcc       "\ "                           ; embedded text or resource bytes
                    fcb       $BB,$96   ; table, bitmap, or initialized data bytes
                    fcc       "4H0"                          ; embedded text or resource bytes
                    fcb       $8D,$FF,$A7,$1F ; table, bitmap, or initialized data bytes
                    fcc       "R"                            ; embedded text or resource bytes
                    fcb       $EC,$86   ; table, bitmap, or initialized data bytes
                    fcc       "n"                            ; embedded text or resource bytes
                    fcb       $AB       ; table, bitmap, or initialized data bytes
Data_1170           fcb       $00,$1D,$02,$F4,$00 ; table, bitmap, or initialized data bytes
                    fcc       "o"                            ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "{"                            ; embedded text or resource bytes
Data_1178           fcb       $03,$F2,$05 ; table, bitmap, or initialized data bytes
                    fcc       ">"                            ; embedded text or resource bytes
                    fcb       $06,$19,$05,$08 ; table, bitmap, or initialized data bytes
Data_1180           fcc       "("                            ; embedded text or resource bytes
                    fcb       $00,$01,$0B,$0A,$00,$AA ; table, bitmap, or initialized data bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $00,$01,$0B,$0A,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
Code_1190           leax      >Data_1180,PCR ; form the referenced address without reading memory
                    lbsr      Code_1267 ; call the referenced helper routine
                    tfr       DP,A      ; copy the source register into the destination register
                    ldb       #$19      ; load the value needed by the following operation
                    std       Code_003C ; save the current value in working storage
                    tfr       D,X       ; copy the source register into the destination register
                    clra                ; clear the selected byte or register
                    ldu       Addr_0006 ; load the value needed by the following operation
                    cmpu      Addr_000D ; compare against the limit and set condition flags
                    bne       Code_11A9 ; branch when the compared values differ
                    lda       #$80      ; load the value needed by the following operation
Code_11A9           leau      Data_1E00,PCR ; form the referenced address without reading memory
                    stu       ,X++      ; store the value and advance the destination pointer
                    leau      Data_1E07,PCR ; form the referenced address without reading memory
                    stu       ,X++      ; store the value and advance the destination pointer
                    leau      Data_1E0F,PCR ; form the referenced address without reading memory
                    tsta                ; set condition flags from the current value
                    beq       Code_11C0 ; branch when the compared values are equal
                    leau      Data_1E5C,PCR ; form the referenced address without reading memory
Code_11C0           stu       ,X++      ; store the value and advance the destination pointer
                    leau      Data_1E16,PCR ; form the referenced address without reading memory
                    tsta                ; set condition flags from the current value
                    beq       Code_11CD ; branch when the compared values are equal
                    leau      Data_1E64,PCR ; form the referenced address without reading memory
Code_11CD           stu       ,X++      ; store the value and advance the destination pointer
                    leau      Data_1E1E,PCR ; form the referenced address without reading memory
                    tsta                ; set condition flags from the current value
                    beq       Code_11DA ; branch when the compared values are equal
                    leau      Data_1E6D,PCR ; form the referenced address without reading memory
Code_11DA           stu       ,X++      ; store the value and advance the destination pointer
                    leau      Data_1E26,PCR ; form the referenced address without reading memory
                    stu       ,X++      ; store the value and advance the destination pointer
                    leau      Data_1E2D,PCR ; form the referenced address without reading memory
                    stu       ,X++      ; store the value and advance the destination pointer
                    leau      Data_1E37,PCR ; form the referenced address without reading memory
                    stu       ,X        ; save the current value in working storage
                    lda       #$08      ; load the value needed by the following operation
                    sta       Code_003E ; save the current value in working storage
                    sta       Addr_0040 ; save the current value in working storage
                    lda       #$09      ; load the value needed by the following operation
                    sta       Code_003F ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    sta       Code_0041 ; save the current value in working storage
                    sta       Addr_0042 ; save the current value in working storage
                    tfr       DP,A      ; copy the source register into the destination register
                    ldb       #$3C      ; load the value needed by the following operation
Code_1201           tfr       D,X       ; copy the source register into the destination register
                    clra                ; clear the selected byte or register
                    lbsr      Code_2E36 ; call the referenced helper routine
Code_1207           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    lbsr      Code_2F46 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    cmpb      #$05      ; compare against the limit and set condition flags
                    lbeq      Code_0F2C ; take the distant branch when values are equal
                    cmpb      #$0D      ; compare against the limit and set condition flags
                    beq       Code_1250 ; branch when the compared values are equal
                    cmpb      #$B2      ; compare against the limit and set condition flags
                    bne       Code_1223 ; branch when the compared values differ
                    clrb                ; clear the selected byte or register
                    bra       Code_123B ; continue at the selected control-flow target
Code_1223           cmpb      #$B9      ; compare against the limit and set condition flags
                    bne       Code_122B ; branch when the compared values differ
                    ldb       #$02      ; load the value needed by the following operation
                    bra       Code_123B ; continue at the selected control-flow target
Code_122B           cmpb      #$B8      ; compare against the limit and set condition flags
                    bne       Code_1233 ; branch when the compared values differ
                    ldb       #$01      ; load the value needed by the following operation
                    bra       Code_123B ; continue at the selected control-flow target
Code_1233           cmpb      #$AF      ; compare against the limit and set condition flags
                    bne       Code_1207 ; branch when the compared values differ
                    ldb       #$03      ; load the value needed by the following operation
                    bra       Code_123B ; continue at the selected control-flow target
Code_123B           clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    aslb                ; shift left and update carry
                    leax      Data_1178,PCR ; form the referenced address without reading memory
                    ldd       B,X       ; load the value needed by the following operation
                    leax      >Code_1262,PCR ; form the referenced address without reading memory
                    jsr       D,X       ; call the referenced helper routine
                    lbra      Code_0F2C ; continue at the distant control-flow target
Code_1250           pshs      A         ; preserve the listed registers on the stack
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    puls      A         ; restore the listed registers from the stack
                    leax      Data_1170,PCR ; form the referenced address without reading memory
                    asla                ; shift left and update carry
                    ldd       A,X       ; load the value needed by the following operation
                    tfr       PC,Y      ; copy the source register into the destination register
Code_1262           jsr       D,Y       ; call the referenced helper routine
                    lbra      Code_0F2C ; continue at the distant control-flow target
Code_1267           pshs      X         ; preserve the listed registers on the stack
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    lda       #$03      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    puls      X         ; restore the listed registers from the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
                    lda       Addr_0082 ; load the value needed by the following operation
                    ldb       #$DB      ; load the value needed by the following operation
                    std       Code_0035 ; save the current value in working storage
                    leax      Data_0F07,PCR ; form the referenced address without reading memory
                    stx       Code_0037 ; save the current value in working storage
                    ldb       #$F5      ; load the value needed by the following operation
                    std       Addr_0039 ; save the current value in working storage
                    ldb       #$35      ; load the value needed by the following operation
                    tfr       D,Y       ; copy the source register into the destination register
                    lda       #$41      ; load the value needed by the following operation
                    lbsr      Code_34C7 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    bne       Code_12C6 ; branch when the compared values differ
                    lda       #$01      ; load the value needed by the following operation
                    ldx       Addr_0039 ; load the value needed by the following operation
                    os9       I$Open    ; request the named OS-9 service
                    bcs       Code_12C7 ; branch when carry reports an unsigned underflow or error
                    sta       Addr_0011 ; save the current value in working storage
                    ldx       Addr_0006 ; load the value needed by the following operation
                    ldd       Addr_0008 ; load the value needed by the following operation
                    subd      Addr_0006 ; subtract the operand from the running value
                    tfr       D,Y       ; copy the source register into the destination register
                    leay      -$01,Y    ; form the referenced address without reading memory
                    lda       Addr_0011 ; load the value needed by the following operation
                    os9       I$Read    ; request the named OS-9 service
                    ldx       Addr_0006 ; load the value needed by the following operation
                    stx       Addr_000A ; save the current value in working storage
                    tfr       Y,D       ; copy the source register into the destination register
                    leax      D,X       ; form the referenced address without reading memory
                    stx       Addr_000D ; save the current value in working storage
                    clr       Addr_000C ; clear the selected byte or register
                    lda       Addr_0011 ; load the value needed by the following operation
                    os9       I$Close   ; request the named OS-9 service
Code_12C6           rts                 ; return to the caller
Code_12C7           ldx       Addr_0006 ; load the value needed by the following operation
                    stx       Addr_000D ; save the current value in working storage
                    clr       Addr_000C ; clear the selected byte or register
                    lbsr      Code_185F ; call the referenced helper routine
                    rts                 ; return to the caller
                    lda       #$E0      ; load the value needed by the following operation
                    sta       Addr_0018 ; save the current value in working storage
                    ldx       Addr_0006 ; load the value needed by the following operation
                    cmpx      Addr_000D ; compare against the limit and set condition flags
                    bne       Code_12DC ; branch when the compared values differ
                    rts                 ; return to the caller
Code_12DC           lda       Addr_0082 ; load the value needed by the following operation
                    ldb       #$DB      ; load the value needed by the following operation
                    std       Addr_0012 ; save the current value in working storage
                    leax      Data_0F07,PCR ; form the referenced address without reading memory
                    stx       Addr_0014 ; save the current value in working storage
                    ldb       #$F5      ; load the value needed by the following operation
                    std       Code_0016 ; save the current value in working storage
                    ldb       #$12      ; load the value needed by the following operation
                    tfr       D,Y       ; copy the source register into the destination register
                    ldx       #DeskMateService ; load the value needed by the following operation
                    tst       Addr_0074 ; set condition flags from the current value
                    beq       Code_12FB ; branch when the compared values are equal
                    leax      Data_1E76,PCR ; form the referenced address without reading memory
Code_12FB           lda       #$41      ; load the value needed by the following operation
                    lbsr      Code_331E ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    lbne      Code_0F0B ; take the distant branch when values differ
                    lbsr      Code_13B7 ; call the referenced helper routine
                    stx       Addr_002D ; save the current value in working storage
                    ldd       #Addr_0203 ; load the value needed by the following operation
                    ldx       Code_0016 ; load the value needed by the following operation
                    os9       I$Create  ; request the named OS-9 service
                    bcs       Code_134F ;1312: 25 3B          '% ; branch when carry reports an unsigned underflow or error
Code_1314           sta       Addr_0011 ; save the current value in working storage
                    lda       Addr_000C ; load the value needed by the following operation
                    bne       Code_135A ; branch when the compared values differ
                    ldx       Addr_0006 ; load the value needed by the following operation
                    ldd       Addr_000D ; load the value needed by the following operation
                    subd      Addr_0006 ; subtract the operand from the running value
                    tfr       D,Y       ; copy the source register into the destination register
                    pshs      Y,X       ; preserve the listed registers on the stack
Code_1324           lda       ,X        ; load the value needed by the following operation
                    anda      #$7F      ; mask off unwanted bits
                    sta       ,X+       ; store the value and advance the destination pointer
                    leay      -$01,Y    ; form the referenced address without reading memory
                    bne       Code_1324 ; branch when the compared values differ
                    puls      Y,X       ; restore the listed registers from the stack
                    lda       Addr_0011 ; load the value needed by the following operation
                    os9       I$Write   ; request the named OS-9 service
                    bcs       Code_133D ; branch when carry reports an unsigned underflow or error
                    lda       Addr_0011 ; load the value needed by the following operation
                    os9       I$Close   ; request the named OS-9 service
                    rts                 ; return to the caller
Code_133D           lda       Addr_0011 ; load the value needed by the following operation
                    os9       I$Close   ; request the named OS-9 service
                    tfr       DP,A      ; copy the source register into the destination register
                    ldb       #$F5      ; load the value needed by the following operation
                    tfr       D,X       ; copy the source register into the destination register
                    os9       I$Delete  ; request the named OS-9 service
Code_134B           lbsr      Code_185F ; call the referenced helper routine
                    rts                 ; return to the caller
Code_134F           lda       #$02      ; load the value needed by the following operation
                    ldx       Code_0016 ; load the value needed by the following operation
                    os9       I$Open    ; request the named OS-9 service
                    bcs       Code_134B ; branch when carry reports an unsigned underflow or error
                    bra       Code_1314 ; continue at the selected control-flow target
Code_135A           lda       #$01      ; load the value needed by the following operation
                    sta       Data_002F ; save the current value in working storage
                    lda       Addr_0082 ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    clrb                ; clear the selected byte or register
                    tfr       D,U       ; copy the source register into the destination register
Code_1364           bsr       Code_13A2 ; call the referenced helper routine
                    bcs       Code_1387 ; branch when carry reports an unsigned underflow or error
                    anda      #$7F      ; mask off unwanted bits
                    sta       ,U+       ; store the value and advance the destination pointer
                    inc       Data_002F ; advance the selected counter
                    bne       Code_1364 ; branch when the compared values differ
                    lda       Addr_0082 ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    clrb                ; clear the selected byte or register
                    tfr       D,X       ; copy the source register into the destination register
                    ldb       Data_002F ; load the value needed by the following operation
                    decb                ; decrement the selected counter
                    clra                ; clear the selected byte or register
                    tfr       D,Y       ; copy the source register into the destination register
                    lda       Addr_0011 ; load the value needed by the following operation
                    os9       I$Write   ; request the named OS-9 service
                    lbcs      Code_133D ; take the distant branch when carry reports an error
                    bra       Code_135A ; continue at the selected control-flow target
Code_1387           lda       Addr_0082 ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    clrb                ; clear the selected byte or register
                    tfr       D,X       ; copy the source register into the destination register
                    ldb       Data_002F ; load the value needed by the following operation
                    decb                ; decrement the selected counter
                    clra                ; clear the selected byte or register
                    tfr       D,Y       ; copy the source register into the destination register
                    lda       Addr_0011 ; load the value needed by the following operation
                    os9       I$Write   ; request the named OS-9 service
                    lbcs      Code_133D ; take the distant branch when carry reports an error
                    lda       Addr_0011 ; load the value needed by the following operation
                    os9       I$Close   ; request the named OS-9 service
                    rts                 ; return to the caller
Code_13A2           ldx       Addr_002D ; load the value needed by the following operation
                    cmpx      Addr_000D ; compare against the limit and set condition flags
                    beq       Code_13B4 ; branch when the compared values are equal
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpx      Addr_0008 ; compare against the limit and set condition flags
                    bne       Code_13B0 ; branch when the compared values differ
                    ldx       Addr_0006 ; load the value needed by the following operation
Code_13B0           stx       Addr_002D ; save the current value in working storage
                    clrb                ; clear the selected byte or register
                    rts                 ; return to the caller
Code_13B4           orcc      #$01      ; set the selected flag bits
                    rts                 ; return to the caller
Code_13B7           ldx       Addr_0006 ; load the value needed by the following operation
                    lda       Addr_000C ; load the value needed by the following operation
                    beq       Code_13C7 ; branch when the compared values are equal
                    ldx       Addr_000D ; load the value needed by the following operation
                    leax      $01,X     ; form the referenced address without reading memory
                    cmpx      Addr_0008 ; compare against the limit and set condition flags
                    bcs       Code_13C7 ; branch when carry reports an unsigned underflow or error
                    ldx       Addr_0006 ; load the value needed by the following operation
Code_13C7           rts                 ; return to the caller
Data_13C8           fcb       $05,$00   ; table, bitmap, or initialized data bytes
                    fcc       "K"                            ; embedded text or resource bytes
                    fcb       $0D,$00   ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $08,$FF,$E5,$09,$00 ; table, bitmap, or initialized data bytes
                    fcc       "7"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_13D5           fcb       $00,$00,$0C ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $03,$00   ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
                    ldx       Addr_0006 ; load the value needed by the following operation
                    cmpx      Addr_000D ; compare against the limit and set condition flags
                    lbeq      Code_1460 ; take the distant branch when values are equal
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    leax      >Data_13D5,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    leax      Data_1E80,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
Code_13FA           bsr       Code_1461 ; call the referenced helper routine
                    clr       Code_0032 ; clear the selected byte or register
Code_13FE           lbsr      Code_012D ; call the referenced helper routine
Code_1401           bcs       Code_1419 ; branch when carry reports an unsigned underflow or error
                    leax      >Data_13C8,PCR ; form the referenced address without reading memory
Code_1407           cmpa      ,X+       ; compare against the limit and set condition flags
                    beq       Code_1413 ; branch when the compared values are equal
                    leax      $02,X     ; form the referenced address without reading memory
Code_140D           ldb       ,X        ; load the value needed by the following operation
                    bne       Code_1407 ; branch when the compared values differ
                    bra       Code_13FE ; continue at the selected control-flow target
Code_1413           tfr       PC,Y      ; copy the source register into the destination register
                    ldd       ,X        ; load the value needed by the following operation
                    jmp       D,Y       ; dispatch control through the selected target
Code_1419           leax      Data_1CBA,PCR ; form the referenced address without reading memory
                    tsta                ; set condition flags from the current value
                    bmi       Code_1438 ; branch while the tested value is negative
                    cmpa      #$01      ; compare against the limit and set condition flags
                    bne       Code_13FE ; branch when the compared values differ
                    tfr       U,D       ; copy the source register into the destination register
                    cmpa      ,X+       ; compare against the limit and set condition flags
                    bcs       Code_1454 ; branch when carry reports an unsigned underflow or error
                    cmpa      ,X+       ; compare against the limit and set condition flags
                    bhi       Code_1454 ; branch when the unsigned value is above the limit
                    cmpb      ,X+       ; compare against the limit and set condition flags
                    bhi       Code_1460 ; branch when the unsigned value is above the limit
                    cmpb      ,X+       ; compare against the limit and set condition flags
                    bcs       Code_1454 ; branch when carry reports an unsigned underflow or error
                    bra       Code_1458 ; continue at the selected control-flow target
Code_1438           tfr       U,D       ; copy the source register into the destination register
                    cmpa      ,X+       ; compare against the limit and set condition flags
                    bcs       Code_13FE ; branch when carry reports an unsigned underflow or error
                    cmpa      ,X+       ; compare against the limit and set condition flags
                    bhi       Code_13FE ; branch when the unsigned value is above the limit
                    cmpb      ,X+       ; compare against the limit and set condition flags
                    bhi       Code_144C ; branch when the unsigned value is above the limit
                    cmpb      ,X+       ; compare against the limit and set condition flags
                    bcs       Code_13FE ; branch when carry reports an unsigned underflow or error
                    bra       Code_13FA ; continue at the selected control-flow target
Code_144C           lda       #$FF      ; load the value needed by the following operation
                    sta       Code_0032 ; save the current value in working storage
                    bsr       Code_147E ; call the referenced helper routine
                    bra       Code_13FE ; continue at the selected control-flow target
Code_1454           lda       Code_0032 ; load the value needed by the following operation
                    bne       Code_1460 ; branch when the compared values differ
Code_1458           ldx       Addr_0006 ; load the value needed by the following operation
                    stx       Addr_000D ; save the current value in working storage
                    clr       Addr_000C ; clear the selected byte or register
                    stx       Addr_000A ; save the current value in working storage
Code_1460           rts                 ; return to the caller
Code_1461           leax      Data_0351,PCR ; form the referenced address without reading memory
                    ldd       ,X        ; load the value needed by the following operation
                    leax      >Data_149B,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    leax      Data_0353,PCR ; form the referenced address without reading memory
                    ldd       ,X        ; load the value needed by the following operation
                    leax      >Data_14D1,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_147E           leax      Data_0351,PCR ; form the referenced address without reading memory
                    ldd       ,X        ; load the value needed by the following operation
                    leax      >Data_14D1,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    leax      Data_0353,PCR ; form the referenced address without reading memory
                    ldd       ,X        ; load the value needed by the following operation
                    leax      >Data_149B,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    rts                 ; return to the caller
Data_149B           fcc       "("                            ; embedded text or resource bytes
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
                    fcc       ";"                      ;14C9: 3B             ' ; embedded text or resource bytes
                    fcb       $A0       ; table, bitmap, or initialized data bytes
                    fcc       "/ ' *"                        ; embedded text or resource bytes
                    fcb       $A0       ; table, bitmap, or initialized data bytes
Data_14D1           fcc       "("                            ; embedded text or resource bytes
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
                    fcb       $A0       ; table, bitmap, or initialized data bytes
Data_1507           fcb       $05,$00   ; table, bitmap, or initialized data bytes
                    fcc       "Q"                            ; embedded text or resource bytes
                    fcb       $0D,$00   ; table, bitmap, or initialized data bytes
                    fcc       "H"                            ; embedded text or resource bytes
                    fcb       $08,$00   ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $09,$FF,$E3,$00 ; table, bitmap, or initialized data bytes
Code_1514           leax      Data_0355,PCR ; form the referenced address without reading memory
                    ldd       ,X        ; load the value needed by the following operation
                    leax      Data_149B,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    leax      Data_0357,PCR ; form the referenced address without reading memory
                    ldd       ,X        ; load the value needed by the following operation
                    leax      >Data_14D1,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_1531           leax      Data_0355,PCR ; form the referenced address without reading memory
                    ldd       ,X        ; load the value needed by the following operation
                    leax      >Data_14D1,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    leax      Data_0357,PCR ; form the referenced address without reading memory
                    ldd       ,X        ; load the value needed by the following operation
                    leax      Data_149B,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    rts                 ; return to the caller
Data_154E           fcb       $00,$04,$07,$18,$04,$00 ; table, bitmap, or initialized data bytes
                    fcb       $FF,$E0   ; table, bitmap, or initialized data bytes
                    ldx       Addr_0006 ; load the value needed by the following operation
                    cmpx      Addr_000D ; compare against the limit and set condition flags
                    beq       Code_1571 ; branch when the compared values are equal
                    leax      >Data_154E,PCR ; form the referenced address without reading memory
                    bsr       Code_1579 ; call the referenced helper routine
                    lda       Code_0032 ; load the value needed by the following operation
                    lbmi      Code_0F0B ; take the distant branch while the value is negative
                    bne       Code_1571 ; branch when the compared values differ
                    clr       Addr_0018 ; clear the selected byte or register
                    com       Addr_0074 ; invert every bit in the selected value
                    lbsr      Code_12DC ; call the referenced helper routine
Code_1571           lbsr      Code_2D88 ; call the referenced helper routine
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "W"                            ; embedded text or resource bytes
Code_1579           pshs      X         ; preserve the listed registers on the stack
                    lda       #$80      ; load the value needed by the following operation
                    sta       Addr_007A ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    puls      X         ; restore the listed registers from the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    leax      Data_1E9E,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
Code_1592           bsr       Code_1531 ; call the referenced helper routine
                    lda       #$0F      ; load the value needed by the following operation
                    sta       Code_0032 ; save the current value in working storage
Code_1598           lbsr      Code_012D ; call the referenced helper routine
                    bcs       Code_15B3 ; branch when carry reports an unsigned underflow or error
                    leax      Data_1507,PCR ; form the referenced address without reading memory
Code_15A1           cmpa      ,X+       ; compare against the limit and set condition flags
                    beq       Code_15AD ; branch when the compared values are equal
                    leax      $02,X     ; form the referenced address without reading memory
                    ldb       ,X        ; load the value needed by the following operation
                    bne       Code_15A1 ; branch when the compared values differ
                    bra       Code_1598 ; continue at the selected control-flow target
Code_15AD           tfr       PC,Y      ; copy the source register into the destination register
                    ldd       ,X        ; load the value needed by the following operation
                    jmp       D,Y       ; dispatch control through the selected target
Code_15B3           leax      Data_1CC3,PCR ; form the referenced address without reading memory
                    tsta                ; set condition flags from the current value
                    bmi       Code_15D7 ; branch while the tested value is negative
                    cmpa      #$01      ; compare against the limit and set condition flags
                    bne       Code_1598 ; branch when the compared values differ
                    tfr       U,D       ; copy the source register into the destination register
                    cmpa      ,X+       ; compare against the limit and set condition flags
                    bcs       Code_1600 ; branch when carry reports an unsigned underflow or error
                    cmpa      ,X+       ; compare against the limit and set condition flags
                    bhi       Code_1600 ; branch when the unsigned value is above the limit
                    cmpb      ,X+       ; compare against the limit and set condition flags
                    bcs       Code_1600 ; branch when carry reports an unsigned underflow or error
                    cmpb      ,X+       ; compare against the limit and set condition flags
                    bcs       Code_15F8 ; branch when carry reports an unsigned underflow or error
                    cmpb      ,X+       ; compare against the limit and set condition flags
                    bhi       Code_1600 ; branch when the unsigned value is above the limit
                    lbra      Code_15FB ; continue at the distant control-flow target
Code_15D7           tfr       U,D       ; copy the source register into the destination register
                    cmpa      ,X+       ; compare against the limit and set condition flags
                    bcs       Code_1598 ; branch when carry reports an unsigned underflow or error
                    cmpa      ,X+       ; compare against the limit and set condition flags
                    bhi       Code_1598 ; branch when the unsigned value is above the limit
                    cmpb      ,X+       ; compare against the limit and set condition flags
                    bcs       Code_1598 ; branch when carry reports an unsigned underflow or error
                    cmpb      ,X+       ; compare against the limit and set condition flags
                    bcs       Code_15F0 ; branch when carry reports an unsigned underflow or error
                    cmpb      ,X+       ; compare against the limit and set condition flags
                    bhi       Code_1598 ; branch when the unsigned value is above the limit
                    lbra      Code_1592 ; continue at the distant control-flow target
Code_15F0           lbsr      Code_1514 ; call the referenced helper routine
                    clr       Code_0032 ; clear the selected byte or register
                    bra       Code_1598 ; continue at the selected control-flow target
                    fcc       "9"                            ; embedded text or resource bytes
Code_15F8           clr       Code_0032 ; clear the selected byte or register
                    rts                 ; return to the caller
Code_15FB           lda       #$0F      ; load the value needed by the following operation
                    sta       Code_0032 ; save the current value in working storage
                    rts                 ; return to the caller
Code_1600           lda       #$FF      ; load the value needed by the following operation
                    sta       Code_0032 ; save the current value in working storage
                    rts                 ; return to the caller
Data_1605           fcb       $0D,$00   ; table, bitmap, or initialized data bytes
                    fcc       "H"                            ; embedded text or resource bytes
                    fcb       $08,$FF,$E4,$09,$00 ; table, bitmap, or initialized data bytes
Data_160D           fcc       "?"                            ; embedded text or resource bytes
                    fcb       $05,$00,$81,$00 ; table, bitmap, or initialized data bytes
Code_1612           leax      Data_0359,PCR ; form the referenced address without reading memory
                    ldd       ,X        ; load the value needed by the following operation
                    leax      Data_149B,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    leax      Data_035B,PCR ; form the referenced address without reading memory
                    ldd       ,X        ; load the value needed by the following operation
                    leax      Data_14D1,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_162F           leax      Data_0359,PCR ; form the referenced address without reading memory
                    ldd       ,X        ; load the value needed by the following operation
                    leax      Data_14D1,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    leax      Data_035B,PCR ; form the referenced address without reading memory
                    ldd       ,X        ; load the value needed by the following operation
                    leax      Data_149B,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0D       ; private DeskMate service selector
                    rts                 ; return to the caller
Data_164C           fcb       $00,$03,$0C,$1A,$03,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
                    ldx       Addr_0006 ; load the value needed by the following operation
                    cmpx      Addr_000D ; compare against the limit and set condition flags
                    lbeq      Code_171B ; take the distant branch when values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "N"                            ; embedded text or resource bytes
                    clra                ; clear the selected byte or register
                    sta       $0C,X     ; save the current value in working storage
                    sta       $0D,X     ; save the current value in working storage
                    deca                ; decrement the selected counter
                    sta       $1A,X     ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    leax      >Data_164C,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    leax      Data_1EB2,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
Code_167E           lbsr      Code_1612 ; call the referenced helper routine
                    clr       Code_0032 ; clear the selected byte or register
Code_1683           lbsr      Code_012D ; call the referenced helper routine
                    bcs       Code_169E ; branch when carry reports an unsigned underflow or error
                    leax      Data_1605,PCR ; form the referenced address without reading memory
Code_168C           cmpa      ,X+       ; compare against the limit and set condition flags
                    beq       Code_1698 ; branch when the compared values are equal
                    leax      $02,X     ; form the referenced address without reading memory
                    ldb       ,X        ; load the value needed by the following operation
                    bne       Code_168C ; branch when the compared values differ
                    bra       Code_1683 ; continue at the selected control-flow target
Code_1698           tfr       PC,Y      ; copy the source register into the destination register
                    ldd       ,X        ; load the value needed by the following operation
                    jmp       D,Y       ; dispatch control through the selected target
Code_169E           leax      Data_1CBE,PCR ; form the referenced address without reading memory
                    tsta                ; set condition flags from the current value
                    bmi       Code_16C1 ; branch while the tested value is negative
                    cmpa      #$01      ; compare against the limit and set condition flags
                    bne       Code_1683 ; branch when the compared values differ
                    tfr       U,D       ; copy the source register into the destination register
                    cmpa      ,X+       ; compare against the limit and set condition flags
                    bcs       Code_16E2 ; branch when carry reports an unsigned underflow or error
                    cmpa      ,X+       ; compare against the limit and set condition flags
                    bhi       Code_16E2 ; branch when the unsigned value is above the limit
                    cmpb      ,X+       ; compare against the limit and set condition flags
                    bcs       Code_16E2 ; branch when carry reports an unsigned underflow or error
                    cmpb      ,X+       ; compare against the limit and set condition flags
                    bcs       Code_16E6 ; branch when carry reports an unsigned underflow or error
                    cmpb      ,X+       ; compare against the limit and set condition flags
                    bcs       Code_171C ; branch when carry reports an unsigned underflow or error
                    bra       Code_16E2 ; continue at the selected control-flow target
Code_16C1           tfr       U,D       ; copy the source register into the destination register
                    cmpa      ,X+       ; compare against the limit and set condition flags
                    bcs       Code_1683 ; branch when carry reports an unsigned underflow or error
                    cmpa      ,X+       ; compare against the limit and set condition flags
                    bhi       Code_1683 ; branch when the unsigned value is above the limit
                    cmpb      ,X+       ; compare against the limit and set condition flags
                    bcs       Code_1683 ; branch when carry reports an unsigned underflow or error
                    cmpb      ,X+       ; compare against the limit and set condition flags
                    bcs       Code_167E ; branch when carry reports an unsigned underflow or error
                    cmpb      ,X+       ; compare against the limit and set condition flags
                    bcs       Code_16D9 ; branch when carry reports an unsigned underflow or error
                    bra       Code_1683 ; continue at the selected control-flow target
Code_16D9           lbsr      Code_162F ; call the referenced helper routine
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Code_0032 ; save the current value in working storage
                    bra       Code_1683 ; continue at the selected control-flow target
Code_16E2           lda       Code_0032 ; load the value needed by the following operation
                    bne       Code_171C ; branch when the compared values differ
Code_16E6           bsr       Code_1756 ; call the referenced helper routine
                    beq       Code_171B ; branch when the compared values are equal
                    lbsr      Code_13B7 ; call the referenced helper routine
Code_16ED           cmpx      Addr_000D ; compare against the limit and set condition flags
                    beq       Code_170D ; branch when the compared values are equal
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    pshs      X         ; preserve the listed registers on the stack
                    anda      #$7F      ; mask off unwanted bits
                    ldb       Addr_0011 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "T"                            ; embedded text or resource bytes
                    puls      X         ; restore the listed registers from the stack
                    bcs       Code_1715 ; branch when carry reports an unsigned underflow or error
                    cmpb      #$02      ; compare against the limit and set condition flags
                    beq       Code_1715 ; branch when the compared values are equal
                    cmpx      Addr_0008 ; compare against the limit and set condition flags
                    bne       Code_16ED ; branch when the compared values differ
                    ldx       Addr_0006 ; load the value needed by the following operation
                    bra       Code_16ED ; continue at the selected control-flow target
Code_170D           lda       #$0D      ; load the value needed by the following operation
                    ldb       Addr_0011 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "T"                            ; embedded text or resource bytes
Code_1715           lda       Addr_0011 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "R"                            ; embedded text or resource bytes
Code_171B           rts                 ; return to the caller
Code_171C           bsr       Code_1756 ; call the referenced helper routine
                    beq       Code_171B ; branch when the compared values are equal
                    ldx       Addr_000A ; load the value needed by the following operation
                    stx       Addr_002D ; save the current value in working storage
                    lda       #$16      ; load the value needed by the following operation
Code_1726           pshs      A         ; preserve the listed registers on the stack
                    ldx       Addr_002D ; load the value needed by the following operation
                    lbsr      Code_1AA2 ; call the referenced helper routine
                    stx       Addr_002D ; save the current value in working storage
                    puls      A         ; restore the listed registers from the stack
                    deca                ; decrement the selected counter
                    bne       Code_1726 ; branch when the compared values differ
                    ldx       Addr_000A ; load the value needed by the following operation
Code_1736           cmpx      Addr_002D ; compare against the limit and set condition flags
                    beq       Code_170D ; branch when the compared values are equal
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    pshs      X         ; preserve the listed registers on the stack
                    anda      #$7F      ; mask off unwanted bits
                    ldb       Addr_0011 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "T"                            ; embedded text or resource bytes
                    puls      X         ; restore the listed registers from the stack
                    bcs       Code_1715 ; branch when carry reports an unsigned underflow or error
                    cmpb      #$02      ; compare against the limit and set condition flags
                    beq       Code_1715 ; branch when the compared values are equal
                    cmpx      Addr_0008 ; compare against the limit and set condition flags
                    bne       Code_1736 ; branch when the compared values differ
                    ldx       Addr_0006 ; load the value needed by the following operation
                    bra       Code_1736 ; continue at the selected control-flow target
Code_1756           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Q"                            ; embedded text or resource bytes
                    bcs       Code_1761 ; branch when carry reports an unsigned underflow or error
                    sta       Addr_0011 ; save the current value in working storage
                    lda       #$FF      ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_1761           leax      Data_1ECA,PCR ; form the referenced address without reading memory
                    lbsr      Code_0314 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    rts                 ; return to the caller
                    lda       #$04      ; load the value needed by the following operation
                    lbsr      Code_0201 ; call the referenced helper routine
                    rts                 ; return to the caller
Data_1770           fcb       $00,$08,$14,$0F,$03,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
Data_1778           fcb       $00,$01,$0C,$1F,$03,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
Code_1780           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $19       ; private DeskMate service selector
                    tfr       U,D       ; copy the source register into the destination register
                    cmpa      #$0F      ; compare against the limit and set condition flags
                    lbhi      Code_1856 ; take the distant branch for unsigned higher
                    cmpa      #$0C      ; compare against the limit and set condition flags
                    lbcs      Code_1856 ; take the distant branch when carry reports an error
                    cmpb      #$1C      ; compare against the limit and set condition flags
                    lbhi      Code_1856 ; take the distant branch for unsigned higher
                    cmpb      #$03      ; compare against the limit and set condition flags
                    lbcs      Code_1856 ; take the distant branch when carry reports an error
                    bra       Code_17D8 ; continue at the selected control-flow target
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    leax      >Data_1778,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    leax      Data_1EE7,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
                    leax      Data_0F07,PCR ; form the referenced address without reading memory
                    ldd       ,X++      ; fetch the next value and advance the source pointer
                    std       Addr_0029 ; save the current value in working storage
                    ldd       ,X        ; load the value needed by the following operation
                    std       Addr_002B ; save the current value in working storage
                    tfr       DP,A      ; copy the source register into the destination register
                    ldb       #$29      ; load the value needed by the following operation
                    tfr       D,X       ; copy the source register into the destination register
                    ldd       #Addr_8300 ; load the value needed by the following operation
                    lbsr      Code_3061 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    lbeq      Code_1780 ; take the distant branch when values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    lbeq      Code_1856 ; take the distant branch when values are equal
Code_17D8           lda       Addr_0082 ; load the value needed by the following operation
                    ldb       #$DB      ; load the value needed by the following operation
                    std       Code_0035 ; save the current value in working storage
                    ldb       #$29      ; load the value needed by the following operation
                    std       Code_0037 ; save the current value in working storage
                    ldb       #$F5      ; load the value needed by the following operation
                    std       Addr_0039 ; save the current value in working storage
                    ldb       #$35      ; load the value needed by the following operation
                    tfr       D,Y       ; copy the source register into the destination register
                    lda       #$41      ; load the value needed by the following operation
                    lbsr      Code_34C7 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    bne       Code_1856 ; branch when the compared values differ
                    lda       #$01      ; load the value needed by the following operation
                    ldx       Addr_0039 ; load the value needed by the following operation
                    os9       I$Open    ; request the named OS-9 service
                    lbcs      Code_1863 ; take the distant branch when carry reports an error
                    sta       Addr_0011 ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    leax      Data_1770,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    leax      Data_1EDA,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
                    clr       Code_0049 ; clear the selected byte or register
                    lbsr      Code_2CC9 ; call the referenced helper routine
                    lbcs      Code_186B ; take the distant branch when carry reports an error
Code_181D           tfr       DP,A      ; copy the source register into the destination register
                    inca                ; advance the selected counter
                    clrb                ; clear the selected byte or register
                    tfr       D,X       ; copy the source register into the destination register
                    stx       Addr_002D ; save the current value in working storage
                    lda       Addr_0011 ; load the value needed by the following operation
                    ldy       #Code_00FF ; load the value needed by the following operation
                    os9       I$Read    ; request the named OS-9 service
                    bcs       Code_184E ; branch when carry reports an unsigned underflow or error
                    tfr       Y,D       ; copy the source register into the destination register
                    stb       Data_002F ; save the current value in working storage
Code_1834           clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    beq       Code_183F ; branch when the compared values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    beq       Code_184E ; branch when the compared values are equal
Code_183F           ldx       Addr_002D ; load the value needed by the following operation
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    stx       Addr_002D ; save the current value in working storage
                    lbsr      Code_2B57 ; call the referenced helper routine
                    dec       Data_002F ; decrement the selected counter
                    bne       Code_1834 ; branch when the compared values differ
                    bra       Code_181D ; continue at the selected control-flow target
Code_184E           lda       Addr_0011 ; load the value needed by the following operation
                    os9       I$Close   ; request the named OS-9 service
                    lbsr      Code_2D6E ; call the referenced helper routine
Code_1856           rts                 ; return to the caller
Code_1857           leax      Data_1F00,PCR ; form the referenced address without reading memory
                    lbsr      Code_0314 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_185F           cmpb      #$F8      ; compare against the limit and set condition flags
                    beq       Code_1857 ; branch when the compared values are equal
Code_1863           leax      Data_1F2D,PCR ; form the referenced address without reading memory
                    lbsr      Code_0314 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_186B           leax      Data_1F43,PCR ; form the referenced address without reading memory
                    lbsr      Code_0314 ; call the referenced helper routine
                    rts                 ; return to the caller
Data_1873           fcb       $00,$02,$08,$1D,$03,$00 ; table, bitmap, or initialized data bytes
                    fcb       $FF,$E0   ; table, bitmap, or initialized data bytes
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    leax      >Data_1873,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    lda       Addr_0082 ; load the value needed by the following operation
                    ldb       #$E6      ; load the value needed by the following operation
                    std       Addr_0012 ; save the current value in working storage
                    leax      Data_0F07,PCR ; form the referenced address without reading memory
                    stx       Addr_0014 ; save the current value in working storage
                    ldb       #$F5      ; load the value needed by the following operation
                    std       Code_0016 ; save the current value in working storage
                    ldb       #$12      ; load the value needed by the following operation
                    tfr       D,Y       ; copy the source register into the destination register
                    clra                ; clear the selected byte or register
                    sta       $06,Y     ; save the current value in working storage
                    leax      Data_1F5B,PCR ; form the referenced address without reading memory
                    lda       #$41      ; load the value needed by the following operation
                    lbsr      Code_331E ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    bne       Code_1916 ; branch when the compared values differ
                    ldd       #Addr_0203 ; load the value needed by the following operation
                    ldx       Code_0016 ; load the value needed by the following operation
                    pshs      X         ; preserve the listed registers on the stack
                    os9       I$Create  ; request the named OS-9 service
                    puls      X         ; restore the listed registers from the stack
                    lbcs      Code_196F ; take the distant branch when carry reports an error
Code_18BB           sta       Addr_0011 ; save the current value in working storage
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Code_0049 ; save the current value in working storage
                    lbsr      Code_2CC9 ; call the referenced helper routine
                    lbcs      Code_186B ; take the distant branch when carry reports an error
                    lbsr      Code_1990 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $15       ; private DeskMate service selector
                    tfr       DP,A      ; copy the source register into the destination register
                    inca                ; advance the selected counter
                    clrb                ; clear the selected byte or register
                    std       Addr_002D ; save the current value in working storage
                    lda       #$01      ; load the value needed by the following operation
                    sta       Data_002F ; save the current value in working storage
Code_18D9           lbsr      Code_2B6A ; call the referenced helper routine
                    bcs       Code_18E8 ; branch when carry reports an unsigned underflow or error
                    ldx       Addr_002D ; load the value needed by the following operation
                    sta       ,X+       ; store the value and advance the destination pointer
                    stx       Addr_002D ; save the current value in working storage
                    inc       Data_002F ; advance the selected counter
                    beq       Code_1917 ; branch when the compared values are equal
Code_18E8           clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    beq       Code_18D9 ; branch when the compared values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    beq       Code_18F8 ; branch when the compared values are equal
                    lbsr      Code_2B57 ; call the referenced helper routine
                    bra       Code_18D9 ; continue at the selected control-flow target
Code_18F8           ldb       Data_002F ; load the value needed by the following operation
                    decb                ; decrement the selected counter
                    clra                ; clear the selected byte or register
                    tfr       D,Y       ; copy the source register into the destination register
                    tfr       DP,A      ; copy the source register into the destination register
                    inca                ; advance the selected counter
                    clrb                ; clear the selected byte or register
                    tfr       D,X       ; copy the source register into the destination register
                    lda       Addr_0011 ; load the value needed by the following operation
                    os9       I$Write   ; request the named OS-9 service
                    bcs       Code_195D ; branch when carry reports an unsigned underflow or error
Code_190B           lda       Addr_0011 ; load the value needed by the following operation
                    os9       I$Close   ; request the named OS-9 service
                    lbsr      Code_2D6E ; call the referenced helper routine
                    lbsr      Code_2B35 ; call the referenced helper routine
Code_1916           rts                 ; return to the caller
Code_1917           lda       #$13      ; load the value needed by the following operation
                    lbsr      Code_2B57 ;1919: 17 12 3B       '.. ; call the referenced helper routine
                    lbsr      Code_19C2 ; call the referenced helper routine
                    ldx       #Addr_7FFF ; load the value needed by the following operation
Code_1922           leax      -$01,X    ; form the referenced address without reading memory
                    bne       Code_1922 ; branch when the compared values differ
                    lda       Addr_0082 ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    clrb                ; clear the selected byte or register
                    tfr       D,X       ; copy the source register into the destination register
                    lda       Addr_0011 ; load the value needed by the following operation
                    ldy       #Code_00FF ; load the value needed by the following operation
                    os9       I$Write   ; request the named OS-9 service
                    bcs       Code_195D ; branch when carry reports an unsigned underflow or error
                    lda       Addr_0082 ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    clrb                ; clear the selected byte or register
                    std       Addr_002D ; save the current value in working storage
                    lda       #$01      ; load the value needed by the following operation
                    sta       Data_002F ; save the current value in working storage
Code_1941           lbsr      Code_2B6A ; call the referenced helper routine
                    bcs       Code_1952 ; branch when carry reports an unsigned underflow or error
                    ldx       Addr_002D ; load the value needed by the following operation
                    sta       ,X+       ; store the value and advance the destination pointer
                    stx       Addr_002D ; save the current value in working storage
                    inc       Data_002F ; advance the selected counter
                    beq       Code_1917 ; branch when the compared values are equal
                    bra       Code_1941 ; continue at the selected control-flow target
Code_1952           lda       #$11      ; load the value needed by the following operation
                    lbsr      Code_2B57 ; call the referenced helper routine
                    lbsr      Code_19B2 ; call the referenced helper routine
                    lbra      Code_18D9 ; continue at the distant control-flow target
Code_195D           cmpb      #$F8      ; compare against the limit and set condition flags
                    beq       Code_1966 ; branch when the compared values are equal
                    lbsr      Code_185F ; call the referenced helper routine
                    bra       Code_190B ; continue at the selected control-flow target
Code_1966           leax      Data_1F67,PCR ; form the referenced address without reading memory
                    lbsr      Code_0314 ; call the referenced helper routine
                    bra       Code_190B ; continue at the selected control-flow target
Code_196F           lda       #$02      ; load the value needed by the following operation
                    os9       I$Open    ; request the named OS-9 service
                    bcs       Code_1979 ; branch when carry reports an unsigned underflow or error
                    lbra      Code_18BB ; continue at the distant control-flow target
Code_1979           lbsr      Code_185F ; call the referenced helper routine
                    lbsr      Code_2B35 ; call the referenced helper routine
                    rts                 ; return to the caller
Data_1980           fcb       $00,$01,$0E,$1D,$03,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
Data_1988           fcb       $00,$08,$12,$11,$03,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
Code_1990           clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    leax      >Data_1980,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    leax      Data_1F8D,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    leax      >Data_1988,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
Code_19B2           pshs      Y,X,D     ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "?"                            ; embedded text or resource bytes
                    leax      Data_1FA7,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
                    puls      PC,Y,X,D  ; restore the listed registers from the stack
Code_19C2           pshs      Y,X,D     ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "?"                            ; embedded text or resource bytes
                    leax      Data_1FB6,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
                    puls      PC,Y,X,D  ; restore the listed registers from the stack
Code_19D2           lbsr      Code_19F8 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    bne       Code_19DD ; branch when the compared values differ
                    lda       #$03      ; load the value needed by the following operation
                    lbsr      Code_0201 ; call the referenced helper routine
Code_19DD           lbra      Code_0F2C ; continue at the distant control-flow target
Data_19E0           fcb       $F4,$A1,$07,$16,$E9,$82 ; table, bitmap, or initialized data bytes
                    fcb       $00,$0A   ; table, bitmap, or initialized data bytes
Data_19E8           fcc       "("                            ; embedded text or resource bytes
                    fcb       $06,$01,$0C,$06,$00,$AA ; table, bitmap, or initialized data bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $0D,$01,$0C,$06,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
Code_19F8           leax      >Data_19E8,PCR ; form the referenced address without reading memory
                    lbsr      Code_1267 ; call the referenced helper routine
                    tfr       DP,A      ; copy the source register into the destination register
                    ldb       #$19      ; load the value needed by the following operation
                    std       Code_003C ; save the current value in working storage
                    tfr       D,X       ; copy the source register into the destination register
                    leau      Data_1E3E,PCR ; form the referenced address without reading memory
                    stu       ,X++      ; store the value and advance the destination pointer
                    leau      Data_1E47,PCR ; form the referenced address without reading memory
                    stu       ,X++      ; store the value and advance the destination pointer
                    leau      Data_1E52,PCR ;1A13: 33 8D 04 3B    '3.. ; form the referenced address without reading memory
                    stu       ,X++      ; store the value and advance the destination pointer
                    leau      Data_1E37,PCR ; form the referenced address without reading memory
                    stu       ,X        ; save the current value in working storage
                    lda       #$04      ; load the value needed by the following operation
                    sta       Code_003E ; save the current value in working storage
                    sta       Addr_0040 ; save the current value in working storage
                    lda       #$0A      ; load the value needed by the following operation
                    sta       Code_003F ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    sta       Code_0041 ; save the current value in working storage
                    sta       Addr_0042 ; save the current value in working storage
                    tfr       DP,A      ; copy the source register into the destination register
                    ldb       #$3C      ; load the value needed by the following operation
                    tfr       D,X       ; copy the source register into the destination register
                    clra                ; clear the selected byte or register
                    lbsr      Code_2E36 ; call the referenced helper routine
Code_1A38           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    lbsr      Code_2F46 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    cmpb      #$AF      ; compare against the limit and set condition flags
                    beq       Code_1A74 ; branch when the compared values are equal
                    cmpb      #$05      ; compare against the limit and set condition flags
                    beq       Code_1A6C ; branch when the compared values are equal
                    cmpb      #$B5      ; compare against the limit and set condition flags
                    lbeq      Code_0F0B ; take the distant branch when values are equal
                    cmpb      #$B6      ; compare against the limit and set condition flags
                    lbeq      Code_2180 ; take the distant branch when values are equal
                    cmpb      #$B7      ; compare against the limit and set condition flags
                    lbeq      Code_03EC ; take the distant branch when values are equal
                    cmpb      #$0D      ; compare against the limit and set condition flags
                    bne       Code_1A38 ; branch when the compared values differ
                    leax      Data_19E0,PCR ; form the referenced address without reading memory
                    asla                ; shift left and update carry
                    ldd       A,X       ; load the value needed by the following operation
                    tfr       PC,Y      ; copy the source register into the destination register
                    jmp       D,Y       ; dispatch control through the selected target
Code_1A6C           clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    lda       #$FF      ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_1A74           clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    clra                ; clear the selected byte or register
                    rts                 ; return to the caller
Code_1A7B           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $17       ; private DeskMate service selector
                    ldx       Addr_000A ; load the value needed by the following operation
                    lda       #$16      ; load the value needed by the following operation
                    sta       Data_002F ; save the current value in working storage
                    stx       Addr_002D ; save the current value in working storage
                    ldd       #Data_0200 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
Code_1A8E           ldx       Addr_002D ; load the value needed by the following operation
                    bsr       Code_1AA2 ; call the referenced helper routine
                    stx       Addr_002D ; save the current value in working storage
                    lbsr      Code_1B6F ; call the referenced helper routine
                    dec       Data_002F ; decrement the selected counter
                    bne       Code_1A8E ; branch when the compared values differ
                    stx       Code_0030 ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $16       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_1AA2           clrb                ; clear the selected byte or register
                    lda       Addr_0082 ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    tfr       D,U       ; copy the source register into the destination register
                    tfr       D,Y       ; copy the source register into the destination register
                    ldb       Data_0099 ; load the value needed by the following operation
                    lda       ,X        ; load the value needed by the following operation
                    ora       #$80      ; set the selected flag bits
                    sta       ,X        ; save the current value in working storage
                    cmpx      Addr_000D ; compare against the limit and set condition flags
                    lbeq      Code_1B5B ; take the distant branch when values are equal
                    pshs      X         ; preserve the listed registers on the stack
Code_1ABA           lda       ,X        ; load the value needed by the following operation
                    anda      #$7F      ; mask off unwanted bits
                    cmpa      #$1F      ; compare against the limit and set condition flags
                    bhi       Code_1AD3 ; branch when the unsigned value is above the limit
                    leax      $01,X     ; form the referenced address without reading memory
                    cmpx      Addr_0008 ; compare against the limit and set condition flags
                    bcs       Code_1ACA ; branch when carry reports an unsigned underflow or error
                    ldx       Addr_0006 ; load the value needed by the following operation
Code_1ACA           cmpx      Addr_000D ; compare against the limit and set condition flags
                    bne       Code_1ABA ; branch when the compared values differ
                    puls      X         ; restore the listed registers from the stack
                    lbra      Code_1B5B ; continue at the distant control-flow target
Code_1AD3           leas      $02,S     ; form the referenced address without reading memory
Code_1AD5           lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpx      Addr_0008 ; compare against the limit and set condition flags
                    bcs       Code_1ADD ; branch when carry reports an unsigned underflow or error
                    ldx       Addr_0006 ; load the value needed by the following operation
Code_1ADD           cmpx      Addr_000D ; compare against the limit and set condition flags
                    beq       Code_1B44 ; branch when the compared values are equal
                    anda      #$7F      ; mask off unwanted bits
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bcs       Code_1B30 ; branch when carry reports an unsigned underflow or error
Code_1AE7           sta       ,Y+       ; store the value and advance the destination pointer
                    cmpx      Addr_000D ; compare against the limit and set condition flags
                    beq       Code_1B24 ; branch when the compared values are equal
                    decb                ; decrement the selected counter
                    bne       Code_1AD5 ; branch when the compared values differ
                    lda       ,X        ; load the value needed by the following operation
                    anda      #$7F      ; mask off unwanted bits
                    cmpa      #$21      ; compare against the limit and set condition flags
                    bcs       Code_1B23 ; branch when carry reports an unsigned underflow or error
                    clrb                ; clear the selected byte or register
                    stb       ,Y        ; save the current value in working storage
Code_1AFB           lda       ,-Y       ; load the value needed by the following operation
                    cmpa      #$20      ; compare against the limit and set condition flags
                    beq       Code_1B08 ; branch when the compared values are equal
                    incb                ; advance the selected counter
                    cmpb      #$0A      ; compare against the limit and set condition flags
                    bcs       Code_1AFB ; branch when carry reports an unsigned underflow or error
                    bra       Code_1B23 ; continue at the selected control-flow target
Code_1B08           tstb                ; set condition flags from the current value
                    beq       Code_1B23 ; branch when the compared values are equal
                    tfr       B,A       ; copy the source register into the destination register
Code_1B0D           leax      -$01,X    ; form the referenced address without reading memory
                    cmpx      Addr_0006 ; compare against the limit and set condition flags
                    bcc       Code_1B17 ; branch when carry is clear
                    ldx       Addr_0008 ; load the value needed by the following operation
                    leax      -$01,X    ; form the referenced address without reading memory
Code_1B17           deca                ; decrement the selected counter
                    bne       Code_1B0D ; branch when the compared values differ
                    leay      $01,Y     ; form the referenced address without reading memory
                    lda       #$20      ; load the value needed by the following operation
Code_1B1E           sta       ,Y+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bne       Code_1B1E ; branch when the compared values differ
Code_1B23           rts                 ; return to the caller
Code_1B24           decb                ; decrement the selected counter
                    beq       Code_1B2D ; branch when the compared values are equal
                    lda       #$20      ; load the value needed by the following operation
                    sta       ,Y+       ; store the value and advance the destination pointer
                    bra       Code_1B24 ; continue at the selected control-flow target
Code_1B2D           clr       ,Y        ; clear the selected byte or register
                    rts                 ; return to the caller
Code_1B30           cmpa      #$0D      ; compare against the limit and set condition flags
                    beq       Code_1B51 ; branch when the compared values are equal
                    cmpa      #$0A      ; compare against the limit and set condition flags
                    beq       Code_1B51 ; branch when the compared values are equal
                    cmpa      #$0C      ; compare against the limit and set condition flags
                    beq       Code_1B51 ; branch when the compared values are equal
                    cmpa      #$09      ; compare against the limit and set condition flags
                    bne       Code_1AD5 ; branch when the compared values differ
                    lda       #$20      ; load the value needed by the following operation
                    bra       Code_1AE7 ; continue at the selected control-flow target
Code_1B44           cmpa      #$1F      ; compare against the limit and set condition flags
                    bhi       Code_1B4A ; branch when the unsigned value is above the limit
                    lda       #$20      ; load the value needed by the following operation
Code_1B4A           anda      #$7F      ; mask off unwanted bits
                    sta       ,Y+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    beq       Code_1B5A ; branch when the compared values are equal
Code_1B51           lda       #$20      ; load the value needed by the following operation
Code_1B53           sta       ,Y+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bne       Code_1B53 ; branch when the compared values differ
                    clr       ,Y        ; clear the selected byte or register
Code_1B5A           rts                 ; return to the caller
Code_1B5B           tfr       DP,A      ; copy the source register into the destination register
                    inca                ; advance the selected counter
                    clrb                ; clear the selected byte or register
                    tfr       D,U       ; copy the source register into the destination register
                    tfr       D,Y       ; copy the source register into the destination register
                    lda       #$20      ; load the value needed by the following operation
                    ldb       Data_0099 ; load the value needed by the following operation
Code_1B67           sta       ,Y+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bne       Code_1B67 ; branch when the compared values differ
                    clr       ,Y        ; clear the selected byte or register
                    rts                 ; return to the caller
Code_1B6F           clra                ; clear the selected byte or register
                    ldb       Data_0099 ; load the value needed by the following operation
                    tfr       D,Y       ; copy the source register into the destination register
                    ldb       #$00      ; load the value needed by the following operation
                    tfr       U,X       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $22       ; private DeskMate service selector
                    lda       Data_002F ; load the value needed by the following operation
                    cmpa      #$01      ; compare against the limit and set condition flags
                    beq       Code_1B8A ; branch when the compared values are equal
                    lda       #$0A      ; load the value needed by the following operation
                    ldb       #$00      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $02       ; private DeskMate service selector
Code_1B8A           rts                 ; return to the caller
Code_1B8B           lda       #$16      ; load the value needed by the following operation
Code_1B8D           pshs      A         ; preserve the listed registers on the stack
                    ldx       Addr_000A ; load the value needed by the following operation
                    lbsr      Code_1AA2 ; call the referenced helper routine
                    stx       Addr_000A ; save the current value in working storage
                    puls      A         ; restore the listed registers from the stack
                    deca                ; decrement the selected counter
                    bne       Code_1B8D ; branch when the compared values differ
                    rts                 ; return to the caller
Code_1B9C           lda       #$16      ; load the value needed by the following operation
                    ldb       Data_0099 ; load the value needed by the following operation
                    ldx       #DeskMateService ; load the value needed by the following operation
                    ldy       #Addr_0002 ; load the value needed by the following operation
                    ldu       #Data_2000 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $26       ; private DeskMate service selector
                    ldd       #Addr_1700 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    ldx       Addr_000A ; load the value needed by the following operation
                    lbsr      Code_1AA2 ; call the referenced helper routine
                    stx       Addr_000A ; save the current value in working storage
                    stx       Addr_002D ; save the current value in working storage
                    lda       #$16      ; load the value needed by the following operation
Code_1BC0           pshs      A         ; preserve the listed registers on the stack
                    ldx       Addr_002D ; load the value needed by the following operation
                    lbsr      Code_1AA2 ; call the referenced helper routine
                    stx       Addr_002D ; save the current value in working storage
                    puls      A         ; restore the listed registers from the stack
                    deca                ; decrement the selected counter
                    bne       Code_1BC0 ; branch when the compared values differ
                    inca                ; advance the selected counter
                    sta       Data_002F ; save the current value in working storage
                    bsr       Code_1B6F ; call the referenced helper routine
                    lds       DeskMateService ; load the value needed by the following operation
                    lbra      Code_0F5D ; continue at the distant control-flow target
Code_1BD9           lda       #$16      ; load the value needed by the following operation
Code_1BDB           pshs      A         ; preserve the listed registers on the stack
                    bsr       Code_1BE5 ; call the referenced helper routine
                    puls      A         ; restore the listed registers from the stack
                    deca                ; decrement the selected counter
                    bne       Code_1BDB ; branch when the compared values differ
                    rts                 ; return to the caller
Code_1BE5           lbsr      Code_13B7 ; call the referenced helper routine
                    cmpx      Addr_000A ; compare against the limit and set condition flags
                    beq       Code_1C07 ; branch when the compared values are equal
                    ldx       Addr_000A ; load the value needed by the following operation
Code_1BEE           leax      -$01,X    ; form the referenced address without reading memory
                    cmpx      Addr_0006 ; compare against the limit and set condition flags
                    bcc       Code_1BFC ; branch when carry is clear
                    lda       Addr_000C ; load the value needed by the following operation
                    beq       Code_1C0A ; branch when the compared values are equal
                    ldx       Addr_0008 ; load the value needed by the following operation
                    leax      -$01,X    ; form the referenced address without reading memory
Code_1BFC           lda       ,X        ; load the value needed by the following operation
                    bmi       Code_1C07 ; branch while the tested value is negative
                    cmpx      Addr_000D ; compare against the limit and set condition flags
                    bne       Code_1BEE ; branch when the compared values differ
                    lbsr      Code_13B7 ; call the referenced helper routine
Code_1C07           stx       Addr_000A ; save the current value in working storage
                    rts                 ; return to the caller
Code_1C0A           ldx       Addr_0006 ; load the value needed by the following operation
                    stx       Addr_000A ; save the current value in working storage
                    rts                 ; return to the caller
Code_1C0F           ldx       Addr_000A ; load the value needed by the following operation
                    pshs      X         ; preserve the listed registers on the stack
                    bsr       Code_1BE5 ; call the referenced helper routine
                    puls      X         ; restore the listed registers from the stack
                    cmpx      Addr_000A ; compare against the limit and set condition flags
                    beq       Code_1C3E ; branch when the compared values are equal
                    lda       #$16      ; load the value needed by the following operation
                    ldb       Data_0099 ; load the value needed by the following operation
                    ldx       #DeskMateService ; load the value needed by the following operation
                    ldy       #Addr_0002 ; load the value needed by the following operation
                    ldu       #Data_2000 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "'"                            ; embedded text or resource bytes
                    ldd       #Data_0200 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    ldx       Addr_000A ; load the value needed by the following operation
                    lbsr      Code_1AA2 ; call the referenced helper routine
                    clr       Data_002F ; clear the selected byte or register
                    lbsr      Code_1B6F ; call the referenced helper routine
Code_1C3E           lds       DeskMateService ; load the value needed by the following operation
                    lbra      Code_0F5D ; continue at the distant control-flow target
Code_1C44           lbsr      Code_13B7 ; call the referenced helper routine
                    stx       Addr_000A ; save the current value in working storage
                    rts                 ; return to the caller
Code_1C4A           ldx       Addr_000A ; load the value needed by the following operation
                    lbsr      Code_1AA2 ; call the referenced helper routine
                    cmpx      Addr_000A ; compare against the limit and set condition flags
                    beq       Code_1C57 ; branch when the compared values are equal
                    stx       Addr_000A ; save the current value in working storage
                    bra       Code_1C4A ; continue at the selected control-flow target
Code_1C57           lbsr      Code_1BD9 ; call the referenced helper routine
                    rts                 ; return to the caller
                    fcb       $86,$FF,$97,$9B,$C6 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $1F,$98   ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $D1,$99,$26,$08,$0F,$9B ; table, bitmap, or initialized data bytes
                    fcb       $C6       ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $1F,$98   ; table, bitmap, or initialized data bytes
                    fcc       "LL"                           ; embedded text or resource bytes
                    fcb       $17,$E3,$A0,$09,$17,$E3 ; table, bitmap, or initialized data bytes
                    fcb       $9C       ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $17,$E3,$98,$00,$17,$E6 ; table, bitmap, or initialized data bytes
                    fcb       $26,$17,$EF,$F7,$17,$F4 ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $17,$FD,$F3 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
Code_1C89           ldx       Addr_0006 ; load the value needed by the following operation
                    cmpx      Addr_000D ; compare against the limit and set condition flags
                    beq       Code_1CB9 ; branch when the compared values are equal
                    ldy       Addr_000A ; load the value needed by the following operation
Code_1C92           lda       ,X        ; load the value needed by the following operation
                    anda      #$7F      ; mask off unwanted bits
                    sta       ,X+       ; store the value and advance the destination pointer
                    cmpx      Addr_000D ; compare against the limit and set condition flags
                    bne       Code_1C92 ; branch when the compared values differ
                    pshs      Y         ; preserve the listed registers on the stack
                    lbsr      Code_13B7 ; call the referenced helper routine
                    puls      D         ; restore the listed registers from the stack
Code_1CA3           stx       Addr_002D ; save the current value in working storage
                    stx       Addr_000A ; save the current value in working storage
                    pshs      D         ; preserve the listed registers on the stack
                    cmpx      ,S++      ; compare against the limit and set condition flags
                    bhi       Code_1CB6 ; branch when the unsigned value is above the limit
                    pshs      D         ; preserve the listed registers on the stack
                    lbsr      Code_1AA2 ; call the referenced helper routine
                    puls      D         ; restore the listed registers from the stack
                    bra       Code_1CA3 ; continue at the selected control-flow target
Code_1CB6           lbsr      Code_1BE5 ; call the referenced helper routine
Code_1CB9           rts                 ; return to the caller
Data_1CBA           fcb       $0C,$0E,$18,$13 ; table, bitmap, or initialized data bytes
Data_1CBE           fcb       $0C,$0E,$08,$0F,$1C ; table, bitmap, or initialized data bytes
Data_1CC3           fcb       $07,$09,$0B,$12,$19 ; table, bitmap, or initialized data bytes
Data_1CC8           fcc       "("                            ; embedded text or resource bytes
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
Data_1D16           fcc       "("                            ; embedded text or resource bytes
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
Data_1D64           fcc       "("                            ; embedded text or resource bytes
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
Data_1DB2           fcc       "("                            ; embedded text or resource bytes
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
Data_1E00           fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "  open"                       ; embedded text or resource bytes
Data_1E07           fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "  close"                      ; embedded text or resource bytes
Data_1E0F           fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "  save"                       ; embedded text or resource bytes
Data_1E16           fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "  erase"                      ; embedded text or resource bytes
Data_1E1E           fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "2 print"                      ; embedded text or resource bytes
Data_1E26           fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "8 send"                       ; embedded text or resource bytes
Data_1E2D           fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "9 receive"                    ; embedded text or resource bytes
Data_1E37           fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "? help"                       ; embedded text or resource bytes
Data_1E3E           fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "5 memory"                     ; embedded text or resource bytes
Data_1E47           fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "6 terminal"                   ; embedded text or resource bytes
Data_1E52           fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "7 status"                     ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1E5C           fcb       $80       ; table, bitmap, or initialized data bytes
                    fcc       "  save"                       ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1E64           fcb       $80       ; table, bitmap, or initialized data bytes
                    fcc       "  erase"                      ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1E6D           fcb       $80       ; table, bitmap, or initialized data bytes
                    fcc       "2 print"                      ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1E76           fcc       "filename:"                    ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1E80           fcc       "erase memory file?   "        ; embedded text or resource bytes
                    fcc       "yes   no"                     ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1E9E           fcc       " save?    yes    no"          ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1EB2           fcc       "print   all   this pa"        ; embedded text or resource bytes
                    fcc       "ge"                           ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1ECA           fcb       $0D,$0A   ; table, bitmap, or initialized data bytes
                    fcc       " Device error"                ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1EDA           fcc       "SENDING file"                 ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1EE7           fcc       "ENTER extension to us"        ; embedded text or resource bytes
                    fcc       "e: "                          ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1F00           fcc       " Disk is full."               ; embedded text or resource bytes
                    fcb       $0D,$0A   ; table, bitmap, or initialized data bytes
                    fcc       "Save data "                   ; embedded text or resource bytes
Data_1F1A           fcc       "on another disk!"             ; embedded text or resource bytes
                    fcb       $0D,$0A,$00 ; table, bitmap, or initialized data bytes
Data_1F2D           fcb       $0D,$0A   ; table, bitmap, or initialized data bytes
                    fcc       " Disk drive error"            ; embedded text or resource bytes
                    fcb       $0D,$0A,$00 ; table, bitmap, or initialized data bytes
Data_1F43           fcb       $0D,$0A   ; table, bitmap, or initialized data bytes
                    fcc       " RS232 driver error"          ; embedded text or resource bytes
                    fcb       $0D,$0A,$00 ; table, bitmap, or initialized data bytes
Data_1F5B           fcc       "receive as:"                  ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1F67           fcc       " Disk is full."               ; embedded text or resource bytes
                    fcb       $0D,$0A   ; table, bitmap, or initialized data bytes
                    fcc       "Can't receive file."          ; embedded text or resource bytes
                    fcb       $0D,$0A,$00 ; table, bitmap, or initialized data bytes
Data_1F8D           fcc       "PRESS break when fini"        ; embedded text or resource bytes
                    fcc       "shed"                         ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1FA7           fcc       "receiving file"               ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1FB6           fcc       "writing file"                 ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1FC3           fcc       "Save status as"               ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1FD2           fcc       "User key 8"                   ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1FDD           fcc       "User key 9"                   ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1FE8           fcc       "Serial port"                  ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1FF4           fcc       "Baud rate"                    ; embedded text or resource bytes
                    fcb       $08,$08,$08 ; table, bitmap, or initialized data bytes
Data_2000           fcb       $06       ; table, bitmap, or initialized data bytes
                    fcc       "300"                          ; embedded text or resource bytes
                    fcb       $07       ; table, bitmap, or initialized data bytes
                    fcc       "1200"                         ; embedded text or resource bytes
                    fcb       $07,$03   ; table, bitmap, or initialized data bytes
                    fcc       "2400"                         ; embedded text or resource bytes
                    fcb       $07,$02   ; table, bitmap, or initialized data bytes
                    fcc       "4800"                         ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_2016           fcc       "Word size"                    ; embedded text or resource bytes
                    fcb       $08,$08,$08,$08,$01 ; table, bitmap, or initialized data bytes
                    fcc       "7/1"                          ; embedded text or resource bytes
                    fcb       $08,$02   ; table, bitmap, or initialized data bytes
                    fcc       "7/2"                          ; embedded text or resource bytes
                    fcb       $08,$08   ; table, bitmap, or initialized data bytes
                    fcc       "8/1"                          ; embedded text or resource bytes
                    fcb       $08,$02   ; table, bitmap, or initialized data bytes
                    fcc       "8/2"                          ; embedded text or resource bytes
                    fcb       $08,$00   ; table, bitmap, or initialized data bytes
Data_2038           fcc       "Parity"                       ; embedded text or resource bytes
                    fcb       $08,$08,$08,$08,$08,$08 ; table, bitmap, or initialized data bytes
                    fcb       $05       ; table, bitmap, or initialized data bytes
                    fcc       "even"                         ; embedded text or resource bytes
                    fcb       $08,$08,$08 ; table, bitmap, or initialized data bytes
                    fcc       "odd"                          ; embedded text or resource bytes
                    fcb       $08,$08,$08 ; table, bitmap, or initialized data bytes
                    fcc       "none"                         ; embedded text or resource bytes
                    fcb       $08,$00   ; table, bitmap, or initialized data bytes
Data_2058           fcc       "Ascii filter"                 ; embedded text or resource bytes
                    fcb       $08,$08,$08 ; table, bitmap, or initialized data bytes
                    fcc       "on"                           ; embedded text or resource bytes
                    fcb       $08,$08,$08,$08,$08,$08 ; table, bitmap, or initialized data bytes
                    fcb       $08       ; table, bitmap, or initialized data bytes
                    fcc       "off"                          ; embedded text or resource bytes
                    fcb       $08,$00   ; table, bitmap, or initialized data bytes
Data_2075           fcc       "Line feed"                    ; embedded text or resource bytes
                    fcb       $08,$08,$08,$08,$02 ; table, bitmap, or initialized data bytes
                    fcc       "on"                           ; embedded text or resource bytes
                    fcb       $08,$08,$08,$08,$08,$08 ; table, bitmap, or initialized data bytes
                    fcb       $08       ; table, bitmap, or initialized data bytes
                    fcc       "off"                          ; embedded text or resource bytes
                    fcb       $08,$00   ; table, bitmap, or initialized data bytes
Data_2091           fcc       "Echo"                         ; embedded text or resource bytes
                    fcb       $08,$08,$08,$08,$08,$08 ; table, bitmap, or initialized data bytes
                    fcb       $08,$08   ; table, bitmap, or initialized data bytes
                    fcc       "on"                           ; embedded text or resource bytes
                    fcb       $08,$08,$08,$08,$08,$08 ; table, bitmap, or initialized data bytes
                    fcb       $08       ; table, bitmap, or initialized data bytes
                    fcc       "off"                          ; embedded text or resource bytes
                    fcb       $08,$00   ; table, bitmap, or initialized data bytes
Data_20AB           fcc       "Wordwrap"                     ; embedded text or resource bytes
                    fcb       $08,$08,$08,$08 ; table, bitmap, or initialized data bytes
                    fcc       "on"                           ; embedded text or resource bytes
                    fcb       $08,$08,$08,$08,$08,$08 ; table, bitmap, or initialized data bytes
                    fcb       $08       ; table, bitmap, or initialized data bytes
                    fcc       "off"                          ; embedded text or resource bytes
                    fcb       $08,$00   ; table, bitmap, or initialized data bytes
Data_20C5           fcc       "File"                         ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_20CA           fcc       "View"                         ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_20CF           fcc       "User"                         ; embedded text or resource bytes
                    fcb       $00,$00   ; table, bitmap, or initialized data bytes
                    fcc       "8 user key"                   ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "9 user key"                   ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_20EB           fcc       "Error occured opening"        ; embedded text or resource bytes
                    fcc       " RS232 driver."               ; embedded text or resource bytes
                    fcb       $0D,$0A   ; table, bitmap, or initialized data bytes
                    fcc       "Can't open terminal m"        ; embedded text or resource bytes
                    fcc       "ode."                         ; embedded text or resource bytes
                    fcb       $0D,$0A,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       " send file"                   ; embedded text or resource bytes
                    fcb       $00,$00   ; table, bitmap, or initialized data bytes
                    fcc       " recv file"                   ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "xmodem protocol?     "        ; embedded text or resource bytes
                    fcc       "yes   no"                     ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "timeout in sec.      "        ; embedded text or resource bytes
                    fcc       "10    60"                     ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_2180           lda       #$FF      ; load the value needed by the following operation
                    sta       Addr_00D7 ; save the current value in working storage
                    lds       DeskMateService ; load the value needed by the following operation
                    lda       #$03      ; load the value needed by the following operation
                    sta       Addr_007A ; save the current value in working storage
                    clr       Code_0049 ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $15       ; private DeskMate service selector
                    clr       Addr_00D6 ; clear the selected byte or register
                    lbsr      Code_027C ; call the referenced helper routine
                    ldx       Addr_0093 ; load the value needed by the following operation
                    stx       Code_0095 ; save the current value in working storage
                    ldx       Addr_0097 ; load the value needed by the following operation
                    clr       ,X        ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "-"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $00       ; private DeskMate service selector
                    lbsr      Code_2DB3 ; call the referenced helper routine
                    lda       #$02      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "!"                            ; embedded text or resource bytes
                    lda       #$02      ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    lbsr      Code_2CC9 ; call the referenced helper routine
                    lbcs      Code_2D46 ; take the distant branch when carry reports an error
Code_21BD           tst       Code_00D8 ; set condition flags from the current value
                    beq       Code_21CF ; branch when the compared values are equal
                    ldx       Addr_00D9 ; load the value needed by the following operation
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    stx       Addr_00D9 ; save the current value in working storage
                    dec       Code_00D8 ; decrement the selected counter
                    bne       Code_21D4 ; branch when the compared values differ
                    lda       #$0D      ; load the value needed by the following operation
                    bra       Code_21D4 ; continue at the selected control-flow target
Code_21CF           lbsr      Code_21F2 ; call the referenced helper routine
                    beq       Code_21D7 ; branch when the compared values are equal
Code_21D4           lbsr      Code_2328 ; call the referenced helper routine
Code_21D7           lbsr      Code_2B6A ; call the referenced helper routine
                    bcs       Code_21ED ; branch when carry reports an unsigned underflow or error
                    lbsr      Code_230F ; call the referenced helper routine
                    lbsr      Code_21F9 ; call the referenced helper routine
                    lbsr      Code_2B6A ; call the referenced helper routine
                    bcs       Code_21ED ; branch when carry reports an unsigned underflow or error
                    lbsr      Code_230F ; call the referenced helper routine
                    lbsr      Code_21F9 ; call the referenced helper routine
Code_21ED           lbsr      Code_2B4F ; call the referenced helper routine
                    bra       Code_21BD ; continue at the selected control-flow target
Code_21F2           ldb       #$03      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_21F9           tst       Code_00D5 ; set condition flags from the current value
                    lbeq      Code_229B ; take the distant branch when values are equal
                    ldx       Code_0095 ; load the value needed by the following operation
                    sta       ,X+       ; store the value and advance the destination pointer
                    cmpx      Addr_0097 ; compare against the limit and set condition flags
                    bls       Code_2209 ; branch when the unsigned value is at or below the limit
                    ldx       Addr_0093 ; load the value needed by the following operation
Code_2209           stx       Code_0095 ; save the current value in working storage
                    anda      #$5F      ; mask off unwanted bits
                    cmpa      #$41      ; compare against the limit and set condition flags
                    bcs       Code_227E ; branch when carry reports an unsigned underflow or error
                    cmpa      #$5A      ; compare against the limit and set condition flags
                    bhi       Code_227E ; branch when the unsigned value is above the limit
                    pshs      X         ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0C       ; private DeskMate service selector
                    tfr       X,D       ; copy the source register into the destination register
                    puls      X         ; restore the listed registers from the stack
                    tstb                ; set condition flags from the current value
                    bne       Code_227E ; branch when the compared values differ
                    tsta                ; set condition flags from the current value
                    beq       Code_227E ; branch when the compared values are equal
                    ldx       Code_0095 ; load the value needed by the following operation
                    bsr       Code_2285 ; call the referenced helper routine
                    bsr       Code_2285 ; call the referenced helper routine
                    anda      #$5F      ; mask off unwanted bits
                    cmpa      #$41      ; compare against the limit and set condition flags
                    bcs       Code_227E ; branch when carry reports an unsigned underflow or error
                    cmpa      #$5A      ; compare against the limit and set condition flags
                    bhi       Code_227E ; branch when the unsigned value is above the limit
                    ldb       #$02      ; load the value needed by the following operation
Code_2237           bsr       Code_2285 ; call the referenced helper routine
                    anda      #$5F      ; mask off unwanted bits
                    cmpa      #$41      ; compare against the limit and set condition flags
                    bcs       Code_224A ; branch when carry reports an unsigned underflow or error
                    cmpa      #$5A      ; compare against the limit and set condition flags
                    bhi       Code_224A ; branch when the unsigned value is above the limit
                    incb                ; advance the selected counter
                    cmpb      #$0C      ; compare against the limit and set condition flags
                    bcs       Code_2237 ; branch when carry reports an unsigned underflow or error
                    bra       Code_227E ; continue at the selected control-flow target
Code_224A           pshs      B         ; preserve the listed registers on the stack
                    pshs      X         ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0C       ; private DeskMate service selector
                    tfr       X,D       ; copy the source register into the destination register
                    puls      X         ; restore the listed registers from the stack
                    deca                ; decrement the selected counter
                    ldb       Data_0099 ; load the value needed by the following operation
                    subb      ,S        ; subtract the operand from the running value
                    incb                ; advance the selected counter
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    ldb       ,S        ; load the value needed by the following operation
                    decb                ; decrement the selected counter
Code_2263           lda       #$20      ; load the value needed by the following operation
                    pshs      B         ; preserve the listed registers on the stack
                    lbsr      Code_229B ; call the referenced helper routine
                    puls      B         ; restore the listed registers from the stack
                    decb                ; decrement the selected counter
                    bne       Code_2263 ; branch when the compared values differ
                    ldb       ,S+       ; load the value needed by the following operation
Code_2271           bsr       Code_2290 ; call the referenced helper routine
                    pshs      B         ; preserve the listed registers on the stack
                    lbsr      Code_229B ; call the referenced helper routine
                    puls      B         ; restore the listed registers from the stack
                    decb                ; decrement the selected counter
                    bne       Code_2271 ; branch when the compared values differ
                    rts                 ; return to the caller
Code_227E           ldx       Code_0095 ; load the value needed by the following operation
                    bsr       Code_2285 ; call the referenced helper routine
                    lbra      Code_229B ; continue at the distant control-flow target
Code_2285           leax      -$01,X    ; form the referenced address without reading memory
                    cmpx      Addr_0093 ; compare against the limit and set condition flags
                    bcc       Code_228D ; branch when carry is clear
                    ldx       Addr_0097 ; load the value needed by the following operation
Code_228D           lda       ,X        ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_2290           leax      $01,X     ; form the referenced address without reading memory
                    cmpx      Addr_0097 ; compare against the limit and set condition flags
                    bls       Code_2298 ; branch when the unsigned value is at or below the limit
                    ldx       Addr_0093 ; load the value needed by the following operation
Code_2298           lda       ,X        ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_229B           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1B       ; private DeskMate service selector
                    anda      #$7F      ; mask off unwanted bits
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bcs       Code_22AA ; branch when carry reports an unsigned underflow or error
                    ldb       #$00      ; load the value needed by the following operation
                    lbra      Code_0128 ; continue at the distant control-flow target
Code_22AA           cmpa      #$0D      ; compare against the limit and set condition flags
                    beq       Code_22BF ; branch when the compared values are equal
                    cmpa      #$0A      ; compare against the limit and set condition flags
                    beq       Code_22CF ; branch when the compared values are equal
                    cmpa      #$09      ; compare against the limit and set condition flags
                    beq       Code_22D6 ; branch when the compared values are equal
                    cmpa      #$08      ; compare against the limit and set condition flags
                    beq       Code_22F6 ; branch when the compared values are equal
                    cmpa      #$0C      ; compare against the limit and set condition flags
                    beq       Code_2305 ; branch when the compared values are equal
                    rts                 ; return to the caller
Code_22BF           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0C       ; private DeskMate service selector
                    tfr       X,D       ; copy the source register into the destination register
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    ldb       Addr_00D3 ; load the value needed by the following operation
                    bne       Code_22CF ; branch when the compared values differ
                    rts                 ; return to the caller
Code_22CF           lda       #$0A      ; load the value needed by the following operation
                    ldb       #$00      ; load the value needed by the following operation
                    lbra      Code_0128 ; continue at the distant control-flow target
Code_22D6           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0C       ; private DeskMate service selector
                    tfr       X,D       ; copy the source register into the destination register
                    andb      #$F8      ; mask off unwanted bits
                    addb      #$08      ; add the operand to the running value
                    cmpb      #$20      ; compare against the limit and set condition flags
                    bcs       Code_22F1 ; branch when carry reports an unsigned underflow or error
                    clrb                ; clear the selected byte or register
                    inca                ; advance the selected counter
                    cmpa      #$18      ; compare against the limit and set condition flags
                    bcs       Code_22F1 ; branch when carry reports an unsigned underflow or error
                    deca                ; decrement the selected counter
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    bra       Code_22CF ; continue at the selected control-flow target
Code_22F1           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_22F6           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0C       ; private DeskMate service selector
                    cmpx      #Data_0200 ; compare against the limit and set condition flags
                    beq       Code_2304 ; branch when the compared values are equal
                    ldb       #$00      ; load the value needed by the following operation
                    lbra      Code_0128 ; continue at the distant control-flow target
Code_2304           rts                 ; return to the caller
Code_2305           ldd       #Data_0200 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    lbra      Code_01C8 ; continue at the distant control-flow target
Code_230F           ldx       Addr_000D ; load the value needed by the following operation
                    cmpa      #$08      ; compare against the limit and set condition flags
                    bne       Code_2319 ; branch when the compared values differ
                    leax      -$01,X    ; form the referenced address without reading memory
                    bra       Code_2325 ; continue at the selected control-flow target
Code_2319           sta       ,X+       ; store the value and advance the destination pointer
                    cmpx      Addr_0008 ; compare against the limit and set condition flags
                    bcs       Code_2325 ; branch when carry reports an unsigned underflow or error
                    ldx       Addr_0006 ; load the value needed by the following operation
                    ldb       #$FF      ; load the value needed by the following operation
                    stb       Addr_000C ; save the current value in working storage
Code_2325           stx       Addr_000D ; save the current value in working storage
                    rts                 ; return to the caller
Code_2328           tsta                ; set condition flags from the current value
                    bmi       Code_235A ; branch while the tested value is negative
                    cmpa      #$05      ; compare against the limit and set condition flags
                    beq       Code_2343 ; branch when the compared values are equal
Code_232F           ldb       #$FF      ; load the value needed by the following operation
                    stb       Code_0071 ; save the current value in working storage
                    ldb       Addr_00D4 ; load the value needed by the following operation
                    beq       Code_2340 ; branch when the compared values are equal
                    pshs      D         ; preserve the listed registers on the stack
                    bsr       Code_230F ; call the referenced helper routine
                    lbsr      Code_21F9 ; call the referenced helper routine
                    puls      D         ; restore the listed registers from the stack
Code_2340           sta       Code_004D ; save the current value in working storage
                    rts                 ; return to the caller
Code_2343           clra                ; clear the selected byte or register
                    ldb       #$27      ; load the value needed by the following operation
                    os9       I$GetStt  ; request the named OS-9 service
                    anda      #$02      ; mask off unwanted bits
                    beq       Code_2351 ; branch when the compared values are equal
                    lda       #$05      ; load the value needed by the following operation
                    bra       Code_232F ; continue at the selected control-flow target
Code_2351           lbsr      Code_2D6E ; call the referenced helper routine
                    lbsr      Code_2B35 ; call the referenced helper routine
                    lbra      Code_03EC ; continue at the distant control-flow target
Code_235A           cmpa      #$B5      ; compare against the limit and set condition flags
                    lbeq      Code_2B47 ; take the distant branch when values are equal
                    cmpa      #$B7      ; compare against the limit and set condition flags
                    beq       Code_2351 ; branch when the compared values are equal
                    cmpa      #$B8      ; compare against the limit and set condition flags
                    beq       Code_2386 ; branch when the compared values are equal
                    cmpa      #$B9      ; compare against the limit and set condition flags
                    beq       Code_238A ; branch when the compared values are equal
                    cmpa      #$8C      ; compare against the limit and set condition flags
                    beq       Code_23D2 ; branch when the compared values are equal
                    cmpa      #$AF      ; compare against the limit and set condition flags
                    beq       Code_23A9 ; branch when the compared values are equal
                    cmpa      #$BA      ; compare against the limit and set condition flags
                    beq       Code_23B2 ; branch when the compared values are equal
                    cmpa      #$8D      ; compare against the limit and set condition flags
                    beq       Code_2381 ; branch when the compared values are equal
                    cmpa      #$89      ; compare against the limit and set condition flags
                    beq       Code_2381 ; branch when the compared values are equal
                    rts                 ; return to the caller
Code_2381           anda      #$7F      ; mask off unwanted bits
                    lbra      Code_232F ; continue at the distant control-flow target
Code_2386           ldb       #$A7      ; load the value needed by the following operation
                    bra       Code_238C ; continue at the selected control-flow target
Code_238A           ldb       #$B7      ; load the value needed by the following operation
Code_238C           tfr       DP,A      ; copy the source register into the destination register
                    tfr       D,X       ; copy the source register into the destination register
                    leay      $0E,X     ; form the referenced address without reading memory
                    ldb       #$0F      ; load the value needed by the following operation
Code_2394           lda       ,Y        ; load the value needed by the following operation
                    beq       Code_239C ; branch when the compared values are equal
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bne       Code_23A3 ; branch when the compared values differ
Code_239C           decb                ; decrement the selected counter
                    beq       Code_23A8 ; branch when the compared values are equal
                    leay      -$01,Y    ; form the referenced address without reading memory
                    bra       Code_2394 ; continue at the selected control-flow target
Code_23A3           incb                ; advance the selected counter
                    stb       Code_00D8 ; save the current value in working storage
                    stx       Addr_00D9 ; save the current value in working storage
Code_23A8           rts                 ; return to the caller
Code_23A9           lda       #$05      ; load the value needed by the following operation
                    lbsr      Code_0201 ; call the referenced helper routine
                    lbsr      Code_2305 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_23B2           lbsr      Code_0241 ; call the referenced helper routine
                    lbsr      Code_2DB3 ; call the referenced helper routine
                    lbsr      Code_2305 ; call the referenced helper routine
                    rts                 ; return to the caller
Data_23BC           fcb       $0D,$00   ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $08,$00,$15,$09,$00,$1F ; table, bitmap, or initialized data bytes
                    fcb       $8A,$00,$0F,$05,$00,$0F ; table, bitmap, or initialized data bytes
                    fcb       $AF,$FF,$A6,$BA,$FF,$AF ; table, bitmap, or initialized data bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Code_23D2           clr       Addr_0034 ; clear the selected byte or register
                    lbsr      Code_2DFE ; call the referenced helper routine
Code_23D7           lda       Addr_0034 ; load the value needed by the following operation
                    bne       Code_23E0 ; branch when the compared values differ
                    lbsr      Code_0DB9 ; call the referenced helper routine
                    bra       Code_23EC ; continue at the selected control-flow target
Code_23E0           cmpa      #$02      ; compare against the limit and set condition flags
                    bcc       Code_23E9 ; branch when carry is clear
                    lbsr      Code_0DE5 ; call the referenced helper routine
                    bra       Code_23EC ; continue at the selected control-flow target
Code_23E9           lbsr      Code_2DCB ; call the referenced helper routine
Code_23EC           lbsr      Code_012D ; call the referenced helper routine
                    leax      >Data_23BC,PCR ; form the referenced address without reading memory
Code_23F3           cmpa      ,X+       ; compare against the limit and set condition flags
                    beq       Code_23FF ; branch when the compared values are equal
                    leax      $02,X     ; form the referenced address without reading memory
                    ldb       ,X        ; load the value needed by the following operation
                    bne       Code_23F3 ; branch when the compared values differ
                    bra       Code_23EC ; continue at the selected control-flow target
Code_23FF           ldd       ,X        ; load the value needed by the following operation
                    tfr       PC,Y      ; copy the source register into the destination register
                    jmp       D,Y       ; dispatch control through the selected target
Code_2405           lbsr      Code_0DBD ; call the referenced helper routine
                    lbsr      Code_2DCF ; call the referenced helper routine
                    lbsr      Code_0DE9 ; call the referenced helper routine
                    lbsr      Code_0CE1 ; call the referenced helper routine
                    rts                 ; return to the caller
                    bsr       Code_2405 ; call the referenced helper routine
                    lbsr      Code_2E0A ; call the referenced helper routine
                    rts                 ; return to the caller
                    lda       Addr_0034 ; load the value needed by the following operation
                    beq       Code_23D7 ; branch when the compared values are equal
                    dec       Addr_0034 ; decrement the selected counter
                    bsr       Code_2405 ; call the referenced helper routine
                    bra       Code_23D7 ; continue at the selected control-flow target
                    lda       Addr_0034 ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    cmpa      #$02      ; compare against the limit and set condition flags
                    bhi       Code_23D7 ; branch when the unsigned value is above the limit
                    sta       Addr_0034 ; save the current value in working storage
                    bsr       Code_2405 ; call the referenced helper routine
                    bra       Code_23D7 ; continue at the selected control-flow target
Data_242F           fcb       $00,$CD,$06,$E4,$00 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    lda       Addr_0034 ; load the value needed by the following operation
                    asla                ; shift left and update carry
                    leax      >Data_242F,PCR ; form the referenced address without reading memory
                    ldd       A,X       ; load the value needed by the following operation
                    jmp       D,X       ; dispatch control through the selected target
                    fcb       $00,$83,$00,$88,$00,$91 ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $0D,$01,$0D,$05,$00,$AA ; table, bitmap, or initialized data bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $1B,$01,$0D,$05,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $E0,$17,$06,$DC ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FF,$E9,$17,$EE,$07 ; table, bitmap, or initialized data bytes
                    fcb       $1F,$B8,$C6,$19,$DD ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $1F,$01   ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $8D,$FC   ; table, bitmap, or initialized data bytes
                    fcc       "h"                            ; embedded text or resource bytes
                    fcb       $EF,$81   ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $8D,$FC   ; table, bitmap, or initialized data bytes
                    fcc       "m"                            ; embedded text or resource bytes
                    fcb       $EF,$81   ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $8D,$F9,$BF,$EF,$84,$86 ; table, bitmap, or initialized data bytes
                    fcb       $03,$97   ; table, bitmap, or initialized data bytes
                    fcc       ">"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "@"                            ; embedded text or resource bytes
                    fcb       $86,$0A,$97 ; table, bitmap, or initialized data bytes
                    fcc       "?O"                           ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "B"                            ; embedded text or resource bytes
                    fcb       $1F,$B8,$C6 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $1F,$01   ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $17,$09,$A3,$17,$DB ; table, bitmap, or initialized data bytes
                    fcc       "}Y"                           ; embedded text or resource bytes
                    fcb       $17,$0A,$AC,$17,$DB ; table, bitmap, or initialized data bytes
                    fcc       "vY"                           ; embedded text or resource bytes
                    fcb       $C1,$AF,$10 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $C1,$05,$10 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $C1,$B8,$10 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $00,$13,$C1,$B9,$10 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $00,$12,$C1,$0D,$26,$D9 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FF,$82 ; table, bitmap, or initialized data bytes
                    fcc       "H"                            ; embedded text or resource bytes
                    fcb       $EC,$86   ; table, bitmap, or initialized data bytes
                    fcc       "n"                            ; embedded text or resource bytes
                    fcb       $8B,$17,$FE,$C0 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $03,$17,$FE,$BF,$17,$FF ; table, bitmap, or initialized data bytes
                    fcc       "7"                            ; embedded text or resource bytes
                    fcb       $8D,$09   ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $86,$06,$17,$DD ; table, bitmap, or initialized data bytes
                    fcc       "+"                            ; embedded text or resource bytes
                    fcb       $17,$FF   ; table, bitmap, or initialized data bytes
                    fcc       ",O"                           ; embedded text or resource bytes
                    fcb       $17,$DB   ; table, bitmap, or initialized data bytes
                    fcc       "6"                            ; embedded text or resource bytes
                    fcb       $10,$17,$DB ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $15,$17,$FE ; table, bitmap, or initialized data bytes
                    fcc       " 9"                           ; embedded text or resource bytes
                    fcb       $00,$9F,$04,$EA,$06,$0A ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $00,$01,$0E,$05,$00,$AA ; table, bitmap, or initialized data bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $00,$01,$0E,$05,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $E0,$17,$06 ; table, bitmap, or initialized data bytes
                    fcc       "60"                           ; embedded text or resource bytes
                    fcb       $8D,$FF,$E9,$17,$ED ; table, bitmap, or initialized data bytes
                    fcc       "a"                            ; embedded text or resource bytes
                    fcb       $1F,$B8,$C6,$19,$DD ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $1F,$01   ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $8D,$FC,$1A,$EF,$81 ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $8D,$FC   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $EF,$81   ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $8D,$F9,$19,$EF,$84,$86 ; table, bitmap, or initialized data bytes
                    fcb       $03,$97   ; table, bitmap, or initialized data bytes
                    fcc       ">"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "@"                            ; embedded text or resource bytes
                    fcb       $86,$0B,$97 ; table, bitmap, or initialized data bytes
                    fcc       "?O"                           ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "B"                            ; embedded text or resource bytes
                    fcb       $1F,$B8,$C6 ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $1F,$01   ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $17,$08,$FD,$17,$DA,$D7 ; table, bitmap, or initialized data bytes
                    fcc       "Y"                            ; embedded text or resource bytes
                    fcb       $17,$0A,$06,$17,$DA,$D0 ; table, bitmap, or initialized data bytes
                    fcc       "Y"                            ; embedded text or resource bytes
                    fcb       $C1,$AF,$10 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $05,$A6,$C1,$05,$10 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $05,$A5,$C1,$0D,$26,$E5 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FF,$8E ; table, bitmap, or initialized data bytes
                    fcc       "H"                            ; embedded text or resource bytes
                    fcb       $EC,$86   ; table, bitmap, or initialized data bytes
                    fcc       "n"                            ; embedded text or resource bytes
                    fcb       $8B,$00,$01,$0C,$1F,$03 ; table, bitmap, or initialized data bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $E0,$17,$DA,$AB,$19,$1F ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $81,$0F,$10,$22,$00,$C3 ; table, bitmap, or initialized data bytes
                    fcb       $81,$0C,$10 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $00,$BD,$C1,$1C,$10,$22 ; table, bitmap, or initialized data bytes
                    fcb       $00,$B7,$C1,$03,$10 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $00,$B1   ; table, bitmap, or initialized data bytes
                    fcc       " =O"                          ; embedded text or resource bytes
                    fcb       $17,$DA,$8A,$10 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $17,$DA,$85 ; table, bitmap, or initialized data bytes
                    fcc       "70"                           ; embedded text or resource bytes
                    fcb       $8D,$FF,$CA,$17,$DA ; table, bitmap, or initialized data bytes
                    fcc       "}80"                          ; embedded text or resource bytes
                    fcb       $8D,$F9   ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $17,$DA   ; table, bitmap, or initialized data bytes
                    fcc       "uF0"                          ; embedded text or resource bytes
                    fcb       $8D,$E9   ; table, bitmap, or initialized data bytes
                    fcc       "d"                            ; embedded text or resource bytes
                    fcb       $EC,$81,$DD ; table, bitmap, or initialized data bytes
                    fcc       ")"                            ; embedded text or resource bytes
                    fcb       $EC,$84,$DD ; table, bitmap, or initialized data bytes
                    fcc       "+"                            ; embedded text or resource bytes
                    fcb       $1F,$B8,$C6 ; table, bitmap, or initialized data bytes
                    fcc       ")"                            ; embedded text or resource bytes
                    fcb       $1F,$01,$CC,$83,$00,$17 ; table, bitmap, or initialized data bytes
                    fcb       $0A,$AA   ; table, bitmap, or initialized data bytes
                    fcc       "M"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $FF,$A9,$81,$05,$10 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "r"                            ; embedded text or resource bytes
                    fcb       $96,$82,$C6,$DB,$DD ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $C6       ; table, bitmap, or initialized data bytes
                    fcc       ")"                            ; embedded text or resource bytes
                    fcb       $DD       ; table, bitmap, or initialized data bytes
                    fcc       "7"                            ; embedded text or resource bytes
                    fcb       $C6,$F5,$DD ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $C6       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $1F,$02,$86 ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $17,$0E,$EE ; table, bitmap, or initialized data bytes
                    fcc       "M"                            ; embedded text or resource bytes
                    fcb       $26       ; table, bitmap, or initialized data bytes
                    fcc       "X"                            ; embedded text or resource bytes
                    fcb       $86,$01,$9E ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $84,$10   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $05,$18,$97,$11,$17,$00 ; table, bitmap, or initialized data bytes
                    fcc       "g4"                           ; embedded text or resource bytes
                    fcb       $02,$17,$FE,$14,$17,$FD ; table, bitmap, or initialized data bytes
                    fcb       $11,$A6,$E0,$10 ; table, bitmap, or initialized data bytes
                    fcc       "+"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $10,$26,$03,$00,$1F,$B8 ; table, bitmap, or initialized data bytes
                    fcc       "L_"                           ; embedded text or resource bytes
                    fcb       $1F,$01,$9F ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $96,$11,$10,$8E,$00,$FF ; table, bitmap, or initialized data bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $89       ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $1E,$1F   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $D7       ; table, bitmap, or initialized data bytes
                    fcc       "/_"                           ; embedded text or resource bytes
                    fcb       $17,$D9,$FA,$1D ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $04,$81,$05 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $0F,$9E   ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $A6,$80,$9F ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $17,$05   ; table, bitmap, or initialized data bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $0A       ; table, bitmap, or initialized data bytes
                    fcc       "/"                            ; embedded text or resource bytes
                    fcb       $26,$E8   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $CF,$96,$11,$10 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $8F,$17,$FD,$CE,$17,$FC ; table, bitmap, or initialized data bytes
                    fcb       $CB,$17,$FE,$9C ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $05,$00   ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $0D,$00   ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $08,$00   ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $09,$FF,$E4,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $0C       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $03,$00   ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $17,$D9,$BC,$10 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $17,$D9,$B7 ; table, bitmap, or initialized data bytes
                    fcc       "70"                           ; embedded text or resource bytes
                    fcb       $8D,$FF,$EA,$17,$D9,$AF ; table, bitmap, or initialized data bytes
                    fcc       "80"                           ; embedded text or resource bytes
                    fcb       $8D,$FA,$DB,$17,$D9,$A7 ; table, bitmap, or initialized data bytes
                    fcc       "F"                            ; embedded text or resource bytes
                    fcb       $17,$EE,$0E,$0F ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $17,$DA,$B8 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $16       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FF,$C3,$A1,$80 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $08       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $02,$E6,$84,$26,$F6 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $EB,$1F   ; table, bitmap, or initialized data bytes
                    fcc       "R"                            ; embedded text or resource bytes
                    fcb       $EC,$84   ; table, bitmap, or initialized data bytes
                    fcc       "n"                            ; embedded text or resource bytes
                    fcb       $AB       ; table, bitmap, or initialized data bytes
                    fcc       "M+"                           ; embedded text or resource bytes
                    fcb       $18,$81,$01,$26,$DE,$1F ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $81,$0C   ; table, bitmap, or initialized data bytes
                    fcc       "%+"                           ; embedded text or resource bytes
                    fcb       $81,$0E,$22 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $C1,$18,$22 ; table, bitmap, or initialized data bytes
                    fcc       "+"                            ; embedded text or resource bytes
                    fcb       $C1,$13   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $1F       ; table, bitmap, or initialized data bytes
                    fcc       " '"                           ; embedded text or resource bytes
                    fcb       $1F       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $81,$0C   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $C4,$81,$0E,$22,$C0,$C1 ; table, bitmap, or initialized data bytes
                    fcb       $18,$22,$B7,$C1,$13 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $B8       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $00,$86,$FF,$97 ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $17,$ED,$9E ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $AD,$96   ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $26,$06   ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $86,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "9O9O"                         ; embedded text or resource bytes
                    fcb       $17,$D9   ; table, bitmap, or initialized data bytes
                    fcc       "@70"                          ; embedded text or resource bytes
                    fcb       $8D,$00   ; table, bitmap, or initialized data bytes
                    fcc       "o"                            ; embedded text or resource bytes
                    fcb       $17,$D9   ; table, bitmap, or initialized data bytes
                    fcc       "880"                          ; embedded text or resource bytes
                    fcb       $8D,$FA,$82,$17,$D9 ; table, bitmap, or initialized data bytes
                    fcc       "0F"                           ; embedded text or resource bytes
                    fcb       $86,$0A,$97,$8D,$8D ; table, bitmap, or initialized data bytes
                    fcc       "r"                            ; embedded text or resource bytes
                    fcb       $17,$DA   ; table, bitmap, or initialized data bytes
                    fcc       "@%"                           ; embedded text or resource bytes
                    fcb       $16       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$00   ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $A1,$80   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $08       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $02,$E6,$84,$26,$F6 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $EB,$1F   ; table, bitmap, or initialized data bytes
                    fcc       "R"                            ; embedded text or resource bytes
                    fcb       $EC,$84   ; table, bitmap, or initialized data bytes
                    fcc       "n"                            ; embedded text or resource bytes
                    fcb       $AB       ; table, bitmap, or initialized data bytes
                    fcc       "M+"                           ; embedded text or resource bytes
                    fcb       $18,$81,$01,$26,$DE,$1F ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $81,$0C   ; table, bitmap, or initialized data bytes
                    fcc       "%2"                           ; embedded text or resource bytes
                    fcb       $81,$0E,$22 ; table, bitmap, or initialized data bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $C1,$18,$22 ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $C1,$13   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $26       ; table, bitmap, or initialized data bytes
                    fcc       " $"                           ; embedded text or resource bytes
                    fcb       $1F       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $81,$0C   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $C4,$81,$0E,$22,$C0,$C1 ; table, bitmap, or initialized data bytes
                    fcb       $18,$22,$0E,$C1,$13 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $B8       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $00,$8D,$26,$86,$0A,$97 ; table, bitmap, or initialized data bytes
                    fcb       $8D       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $AE,$8D   ; table, bitmap, or initialized data bytes
                    fcc       ";"                      ;273D: 3B             ' ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $97,$8D   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $A6,$86,$7F ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $00,$00,$11 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $03,$00   ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $E0,$05,$00 ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $0D,$00   ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $08,$00   ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $09,$00   ; table, bitmap, or initialized data bytes
                    fcc       ";"                      ;275A: 3B             ' ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$DB,$FD,$EC,$84 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$ED   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $17,$D8,$AA,$0D ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$DB,$F1,$EC,$84 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$ED   ; table, bitmap, or initialized data bytes
                    fcc       "]"                            ; embedded text or resource bytes
                    fcb       $17,$D8,$9C,$0D ; table, bitmap, or initialized data bytes
                    fcc       "90"                           ; embedded text or resource bytes
                    fcb       $8D,$DB,$E0,$EC,$84 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$ED   ; table, bitmap, or initialized data bytes
                    fcc       "N"                            ; embedded text or resource bytes
                    fcb       $17,$D8,$8D,$0D ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$DB,$D4,$EC,$84 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$ED,$0A,$17,$D8,$7F ; table, bitmap, or initialized data bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $17,$06,$8F,$86,$15,$17 ; table, bitmap, or initialized data bytes
                    fcb       $02,$05,$0F,$8E,$8D ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $9E,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $03,$10,$8E,$00,$80,$96 ; table, bitmap, or initialized data bytes
                    fcb       $11,$10   ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $8A       ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $0C       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $05,$86,$18,$17,$01,$EB ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $05,$16,$03,$08,$86,$06 ; table, bitmap, or initialized data bytes
                    fcb       $17,$01,$E1 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $DC,$17,$03,$A3 ; table, bitmap, or initialized data bytes
                    fcc       "$:"                           ; embedded text or resource bytes
                    fcb       $86,$06,$17,$01,$D5,$10 ; table, bitmap, or initialized data bytes
                    fcb       $DE,$00,$17,$02,$9A,$16 ; table, bitmap, or initialized data bytes
                    fcb       $F9,$E6,$9E,$0F,$C6,$83 ; table, bitmap, or initialized data bytes
                    fcb       $8D       ; table, bitmap, or initialized data bytes
                    fcc       "B%$"                          ; embedded text or resource bytes
                    fcb       $81,$04   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $E1,$81,$01,$26,$1C,$A7 ; table, bitmap, or initialized data bytes
                    fcb       $80,$8D   ; table, bitmap, or initialized data bytes
                    fcc       "4%"                           ; embedded text or resource bytes
                    fcb       $16,$A7,$80 ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $26,$F7,$9E,$0F,$A6,$01 ; table, bitmap, or initialized data bytes
                    fcb       $91,$8E   ; table, bitmap, or initialized data bytes
                    fcc       "'!"                           ; embedded text or resource bytes
                    fcb       $17,$00,$F3,$A1,$89,$00 ; table, bitmap, or initialized data bytes
                    fcb       $83       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $0C,$17,$03 ; table, bitmap, or initialized data bytes
                    fcc       "d$"                           ; embedded text or resource bytes
                    fcb       $FB,$86,$15,$17,$01,$96 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $C8,$9E,$0F,$A6,$01,$97 ; table, bitmap, or initialized data bytes
                    fcb       $8E,$86   ; table, bitmap, or initialized data bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $17,$FA,$81 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $8D,$F2   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $B8       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $14,$96,$8D,$97,$91,$8E ; table, bitmap, or initialized data bytes
                    fcb       $01,$00,$9F,$8F,$17,$03 ; table, bitmap, or initialized data bytes
                    fcc       "="                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $00,$8D,$17,$F9,$BE ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $06,$81,$05,$10 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $00,$86,$9E,$8F ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $1F,$9F,$8F,$26,$E6,$0A ; table, bitmap, or initialized data bytes
                    fcb       $91,$26,$DD,$17,$D7,$C8 ; table, bitmap, or initialized data bytes
                    fcb       $1B,$17,$D9 ; table, bitmap, or initialized data bytes
                    fcc       "y0"                           ; embedded text or resource bytes
                    fcb       $8D,$00   ; table, bitmap, or initialized data bytes
                    fcc       "x"                            ; embedded text or resource bytes
                    fcb       $17,$D7,$BD ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
                    fcb       $8E,$00,$01,$10,$8E,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$17,$D7,$B2 ; table, bitmap, or initialized data bytes
                    fcc       "DO_0"                         ; embedded text or resource bytes
                    fcb       $8D,$00   ; table, bitmap, or initialized data bytes
                    fcc       "k"                            ; embedded text or resource bytes
                    fcb       $17,$D7,$A8,$0A,$8E,$00 ; table, bitmap, or initialized data bytes
                    fcb       $01,$10,$8E,$00,$02,$17 ; table, bitmap, or initialized data bytes
                    fcb       $D7,$9D   ; table, bitmap, or initialized data bytes
                    fcc       "D"                            ; embedded text or resource bytes
                    fcb       $86,$01,$17,$D7,$97,$0A ; table, bitmap, or initialized data bytes
                    fcb       $8E,$00,$01,$10,$8E,$00 ; table, bitmap, or initialized data bytes
                    fcb       $03,$17,$D7,$8C ; table, bitmap, or initialized data bytes
                    fcc       "D"                            ; embedded text or resource bytes
                    fcb       $86,$02,$17,$D7,$86,$0A ; table, bitmap, or initialized data bytes
                    fcc       "O_O_"                         ; embedded text or resource bytes
                    fcb       $17,$D7   ; table, bitmap, or initialized data bytes
                    fcc       "~"                            ; embedded text or resource bytes
                    fcb       $1C       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $F8       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $02,$17,$D7 ; table, bitmap, or initialized data bytes
                    fcc       "v?O"                          ; embedded text or resource bytes
                    fcb       $17,$D7   ; table, bitmap, or initialized data bytes
                    fcc       "q7"                           ; embedded text or resource bytes
                    fcb       $17,$D9,$22,$CC,$02,$00 ; table, bitmap, or initialized data bytes
                    fcb       $17,$D7   ; table, bitmap, or initialized data bytes
                    fcc       "g"                            ; embedded text or resource bytes
                    fcb       $0B,$17,$D7 ; table, bitmap, or initialized data bytes
                    fcc       "c"                            ; embedded text or resource bytes
                    fcb       $1A       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $02,$81,$05 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $0B,$17,$05 ; table, bitmap, or initialized data bytes
                    fcc       "n"                            ; embedded text or resource bytes
                    fcb       $1A,$01   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $94,$1C,$FE ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $94,$10,$DE,$00,$17,$01 ; table, bitmap, or initialized data bytes
                    fcb       $A6,$16,$F8,$F2,$00,$05 ; table, bitmap, or initialized data bytes
                    fcb       $08,$1F,$06,$00,$FF,$E0 ; table, bitmap, or initialized data bytes
                    fcc       "Timed out. Want to co"        ; embedded text or resource bytes
                    fcc       "ntinue?"                      ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $10,$9E,$0F,$C6,$83 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $AB,$80   ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $26,$FB   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $90,$17,$05 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $17,$FF,$1B ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $FB,$81,$15,$26,$F7,$17 ; table, bitmap, or initialized data bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "]%"                           ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $F9,$0F,$92,$86,$01,$97 ; table, bitmap, or initialized data bytes
                    fcb       $8E,$9E,$0F,$86,$01,$A7 ; table, bitmap, or initialized data bytes
                    fcb       $80,$96,$8E,$A7,$80 ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $A7,$80,$10,$8E,$00,$80 ; table, bitmap, or initialized data bytes
                    fcb       $96,$11,$10 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $89       ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $07,$C1,$D3 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $17,$16,$FC,$F9,$10,$8C ; table, bitmap, or initialized data bytes
                    fcb       $00,$80   ; table, bitmap, or initialized data bytes
                    fcc       "%$"                           ; embedded text or resource bytes
                    fcb       $8D,$B2,$9E,$0F,$A7,$89 ; table, bitmap, or initialized data bytes
                    fcb       $00,$83,$8D ; table, bitmap, or initialized data bytes
                    fcc       "6"                            ; embedded text or resource bytes
                    fcb       $0D,$92   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $CD,$86,$04,$8D ; table, bitmap, or initialized data bytes
                    fcc       "U"                            ; embedded text or resource bytes
                    fcb       $17,$FE,$CE ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $F7,$81,$06,$26,$F3,$10 ; table, bitmap, or initialized data bytes
                    fcb       $DE,$00,$17,$01,$11,$16 ; table, bitmap, or initialized data bytes
                    fcb       $F8       ; table, bitmap, or initialized data bytes
                    fcc       "]"                            ; embedded text or resource bytes
                    fcb       $9E,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $03,$1F   ; table, bitmap, or initialized data bytes
                    fcc       " 0"                           ; embedded text or resource bytes
                    fcb       $8B,$ED,$E3,$CC,$00,$80 ; table, bitmap, or initialized data bytes
                    fcb       $A3,$E1,$86,$1A,$A7,$80 ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $26,$F9,$86,$FF,$97,$92 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $C0       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $10,$9E,$0F,$C6,$84,$A6 ; table, bitmap, or initialized data bytes
                    fcb       $80,$8D,$1D ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $26,$F9,$17,$FE,$93 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $F0,$84,$7F,$81,$06 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $06,$81,$15 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $E6       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $EF,$0C,$8E,$86 ; table, bitmap, or initialized data bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $17,$F8,$FA ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $90       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $16,$17,$F8 ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $26,$11,$A6,$E4,$17,$01 ; table, bitmap, or initialized data bytes
                    fcb       $A8,$86,$0A,$C6 ; table, bitmap, or initialized data bytes
                    fcc       "dZ"                           ; embedded text or resource bytes
                    fcb       $26,$FD   ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $26,$F8   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $96,$81,$05,$26,$E6,$10 ; table, bitmap, or initialized data bytes
                    fcb       $DE,$00,$17,$00,$A9,$16 ; table, bitmap, or initialized data bytes
                    fcb       $F7,$F5,$00,$02,$08,$1D ; table, bitmap, or initialized data bytes
                    fcb       $03,$00,$FF,$E0 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $17,$D6   ; table, bitmap, or initialized data bytes
                    fcc       "?70"                          ; embedded text or resource bytes
                    fcb       $8D,$FF,$EF,$17,$D6 ; table, bitmap, or initialized data bytes
                    fcc       "78"                           ; embedded text or resource bytes
                    fcb       $96,$82,$C6,$E6,$DD,$12 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$E5   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $9F,$14,$C6,$F5,$DD,$16 ; table, bitmap, or initialized data bytes
                    fcb       $C6,$12,$1F,$02 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $A7,$26   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$F5   ; table, bitmap, or initialized data bytes
                    fcc       "c"                            ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $17,$09   ; table, bitmap, or initialized data bytes
                    fcc       "!M"                           ; embedded text or resource bytes
                    fcb       $26       ; table, bitmap, or initialized data bytes
                    fcc       "v"                            ; embedded text or resource bytes
                    fcb       $CC,$02,$03,$9E,$16 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $10,$10   ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $83       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $10,$10   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $00,$C7,$97,$11,$86,$FF ; table, bitmap, or initialized data bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "I"                            ; embedded text or resource bytes
                    fcb       $17,$02,$B0,$17,$D5,$F7 ; table, bitmap, or initialized data bytes
                    fcb       $15,$17,$FC ; table, bitmap, or initialized data bytes
                    fcc       "34"                           ; embedded text or resource bytes
                    fcb       $02,$17,$F9,$E0,$17,$F8 ; table, bitmap, or initialized data bytes
                    fcb       $DD,$A6,$E0,$10 ; table, bitmap, or initialized data bytes
                    fcc       "+"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "@"                            ; embedded text or resource bytes
                    fcb       $10,$26,$FD ; table, bitmap, or initialized data bytes
                    fcc       "d"                            ; embedded text or resource bytes
                    fcb       $1F,$B8   ; table, bitmap, or initialized data bytes
                    fcc       "L_"                           ; embedded text or resource bytes
                    fcb       $DD       ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $86,$01,$97 ; table, bitmap, or initialized data bytes
                    fcc       "/"                            ; embedded text or resource bytes
                    fcb       $17,$01   ; table, bitmap, or initialized data bytes
                    fcc       "+%"                           ; embedded text or resource bytes
                    fcb       $0A,$9E   ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $A7,$80,$9F ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $0C       ; table, bitmap, or initialized data bytes
                    fcc       "/':_"                         ; embedded text or resource bytes
                    fcb       $17,$D5,$C4,$1D ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $EA,$81,$05 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $05,$17,$00,$FE ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $E1,$D6   ; table, bitmap, or initialized data bytes
                    fcc       "/ZO"                          ; embedded text or resource bytes
                    fcb       $1F,$02,$1F,$B8 ; table, bitmap, or initialized data bytes
                    fcc       "L_"                           ; embedded text or resource bytes
                    fcb       $1F,$01,$96,$11,$10 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $8A       ; table, bitmap, or initialized data bytes
                    fcc       "%W"                           ; embedded text or resource bytes
                    fcb       $96,$11,$10 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $8F,$17,$00,$BF,$0F ; table, bitmap, or initialized data bytes
                    fcc       "I"                            ; embedded text or resource bytes
                    fcb       $17,$02   ; table, bitmap, or initialized data bytes
                    fcc       "N"                            ; embedded text or resource bytes
                    fcb       $17,$F9,$87,$17,$F8,$84 ; table, bitmap, or initialized data bytes
                    fcb       $17,$FA   ; table, bitmap, or initialized data bytes
                    fcc       "U9"                           ; embedded text or resource bytes
                    fcb       $86,$13,$17,$00,$CD,$8E ; table, bitmap, or initialized data bytes
                    fcb       $7F,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $1F,$26,$FC,$96,$82 ; table, bitmap, or initialized data bytes
                    fcc       "L_"                           ; embedded text or resource bytes
                    fcb       $1F,$01,$96,$11,$10,$8E ; table, bitmap, or initialized data bytes
                    fcb       $00,$FF,$10 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $8A       ; table, bitmap, or initialized data bytes
                    fcc       "%#"                           ; embedded text or resource bytes
                    fcb       $96,$82   ; table, bitmap, or initialized data bytes
                    fcc       "L_"                           ; embedded text or resource bytes
                    fcb       $DD       ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $86,$01,$97 ; table, bitmap, or initialized data bytes
                    fcc       "/"                            ; embedded text or resource bytes
                    fcb       $17,$00,$BB ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $0C,$9E   ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $A7,$80,$9F ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $0C       ; table, bitmap, or initialized data bytes
                    fcc       "/'"                           ; embedded text or resource bytes
                    fcb       $CA       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $EF,$86,$11,$17,$00,$95 ; table, bitmap, or initialized data bytes
                    fcb       $16,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "w"                            ; embedded text or resource bytes
                    fcb       $C1,$F8   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $05,$17,$00 ; table, bitmap, or initialized data bytes
                    fcc       "3 "                           ; embedded text or resource bytes
                    fcb       $A0       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$F4,$95,$17,$D8 ; table, bitmap, or initialized data bytes
                    fcc       "? "                           ; embedded text or resource bytes
                    fcb       $97,$C1,$DA,$26,$09,$86 ; table, bitmap, or initialized data bytes
                    fcb       $02,$10   ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $84,$10   ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $8D,$19,$17,$F9,$1C,$17 ; table, bitmap, or initialized data bytes
                    fcb       $F8,$19,$17,$00 ; table, bitmap, or initialized data bytes
                    fcc       "F9"                           ; embedded text or resource bytes
                    fcb       $86,$07,$17,$D7,$0C,$17 ; table, bitmap, or initialized data bytes
                    fcb       $F9,$0D,$17,$F9,$DE,$17 ; table, bitmap, or initialized data bytes
                    fcb       $F8,$07   ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $C1,$F8   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $08       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$F4,$26,$17,$D8,$0A ; table, bitmap, or initialized data bytes
                    fcc       "90"                           ; embedded text or resource bytes
                    fcb       $8D,$F3,$F1,$17,$D8,$02 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $17,$02   ; table, bitmap, or initialized data bytes
                    fcc       "X"                            ; embedded text or resource bytes
                    fcb       $8D,$1D,$17,$EE,$DD ; table, bitmap, or initialized data bytes
                    fcc       "M"                            ; embedded text or resource bytes
                    fcb       $26,$05,$86,$03,$17,$D6 ; table, bitmap, or initialized data bytes
                    fcb       $DE,$17,$F8,$DF,$17,$F7 ; table, bitmap, or initialized data bytes
                    fcb       $DC,$17,$01,$9D,$10 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $02,$16,$17,$D4,$E0,$15 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
Code_2B35           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "N"                            ; embedded text or resource bytes
                    lda       $24,X     ; load the value needed by the following operation
                    beq       Code_2B46 ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $14       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $16       ; private DeskMate service selector
Code_2B46           rts                 ; return to the caller
Code_2B47           lbsr      Code_2D6E ; call the referenced helper routine
                    bsr       Code_2B35 ; call the referenced helper routine
                    lbra      Code_0F0B ; continue at the distant control-flow target
Code_2B4F           ldb       Code_0071 ; load the value needed by the following operation
                    beq       Code_2B68 ; branch when the compared values are equal
                    clr       Code_0071 ; clear the selected byte or register
                    lda       Code_004D ; load the value needed by the following operation
Code_2B57           sta       Addr_0072 ; save the current value in working storage
                    tfr       DP,A      ; copy the source register into the destination register
                    ldb       #$72      ; load the value needed by the following operation
                    tfr       D,X       ; copy the source register into the destination register
                    lda       Addr_004A ; load the value needed by the following operation
                    ldy       #Addr_0001 ; load the value needed by the following operation
                    os9       I$Write   ; request the named OS-9 service
Code_2B68           rts                 ; return to the caller
                    fcc       "9"                            ; embedded text or resource bytes
Code_2B6A           lda       Code_0075 ; load the value needed by the following operation
                    bne       Code_2B9C ; branch when the compared values differ
                    lda       Addr_004A ; load the value needed by the following operation
                    ldb       #$01      ; load the value needed by the following operation
                    os9       I$GetStt  ; request the named OS-9 service
                    bcs       Code_2B95 ; branch when carry reports an unsigned underflow or error
                    leax      >Data_2BC9,PCR ; form the referenced address without reading memory
                    clra                ; clear the selected byte or register
                    tfr       D,Y       ; copy the source register into the destination register
                    stx       Addr_0076 ; save the current value in working storage
                    lda       Addr_004A ; load the value needed by the following operation
                    os9       I$Read    ; request the named OS-9 service
                    bcs       Code_2B99 ; branch when carry reports an unsigned underflow or error
                    tfr       Y,D       ; copy the source register into the destination register
                    ldu       Addr_0076 ; load the value needed by the following operation
                    leau      D,U       ; form the referenced address without reading memory
                    stu       Addr_0078 ; save the current value in working storage
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Code_0075 ; save the current value in working storage
                    bra       Code_2B9C ; continue at the selected control-flow target
Code_2B95           cmpb      #$F6      ; compare against the limit and set condition flags
                    beq       Code_2B99 ; branch when the compared values are equal
Code_2B99           orcc      #$01      ; set the selected flag bits
                    rts                 ; return to the caller
Code_2B9C           ldx       Addr_0076 ; load the value needed by the following operation
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    stx       Addr_0076 ; save the current value in working storage
                    cmpx      Addr_0078 ; compare against the limit and set condition flags
                    bne       Code_2BA8 ; branch when the compared values differ
                    clr       Code_0075 ; clear the selected byte or register
Code_2BA8           tst       Code_00D2 ; set condition flags from the current value
                    beq       Code_2BC6 ; branch when the compared values are equal
                    anda      #$7F      ; mask off unwanted bits
                    cmpa      #$1F      ; compare against the limit and set condition flags
                    bhi       Code_2BC6 ; branch when the unsigned value is above the limit
                    cmpa      #$08      ; compare against the limit and set condition flags
                    beq       Code_2BC6 ; branch when the compared values are equal
                    cmpa      #$09      ; compare against the limit and set condition flags
                    beq       Code_2BC6 ; branch when the compared values are equal
                    cmpa      #$0A      ; compare against the limit and set condition flags
                    beq       Code_2BC6 ; branch when the compared values are equal
                    cmpa      #$0C      ; compare against the limit and set condition flags
                    beq       Code_2BC6 ; branch when the compared values are equal
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    bne       Code_2B99 ; branch when the compared values differ
Code_2BC6           andcc     #$FE      ; mask off unwanted bits
                    rts                 ; return to the caller
Data_2BC9           fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
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
Code_2CC9           lbsr      Code_2D6F ; call the referenced helper routine
                    lbcs      Code_2D45 ; take the distant branch when carry reports an error
                    lbsr      Code_2D53 ; call the referenced helper routine
                    lbcs      Code_2D45 ; take the distant branch when carry reports an error
                    lbsr      Code_2D99 ; call the referenced helper routine
                    pshs      U,Y,X,D   ; preserve the listed registers on the stack
                    tfr       DP,A      ; copy the source register into the destination register
                    ldb       #$4F      ; load the value needed by the following operation
                    tfr       D,X       ; copy the source register into the destination register
                    ldb       #$20      ; load the value needed by the following operation
                    lda       Code_0063 ; load the value needed by the following operation
Code_2CE6           clr       ,X+       ; clear the selected byte or register
                    decb                ; decrement the selected counter
                    bne       Code_2CE6 ; branch when the compared values differ
                    sta       Code_0063 ; save the current value in working storage
                    puls      U,Y,X,D   ; restore the listed registers from the stack
                    lda       Code_0063 ; load the value needed by the following operation
                    anda      #$0F      ; mask off unwanted bits
                    ldb       Addr_00D1 ; load the value needed by the following operation
                    beq       Code_2CFF ; branch when the compared values are equal
                    bmi       Code_2CFD ; branch while the tested value is negative
                    ora       #$60      ; set the selected flag bits
                    bra       Code_2CFF ; continue at the selected control-flow target
Code_2CFD           ora       #$20      ; set the selected flag bits
Code_2CFF           sta       Code_0063 ; save the current value in working storage
                    lda       #$01      ; load the value needed by the following operation
                    ldb       Addr_00CF ; load the value needed by the following operation
                    beq       Code_2D17 ; branch when the compared values are equal
                    cmpb      #$02      ; compare against the limit and set condition flags
                    bhi       Code_2D11 ; branch when the unsigned value is above the limit
                    bcs       Code_2D15 ; branch when carry reports an unsigned underflow or error
                    lda       #$04      ; load the value needed by the following operation
                    bra       Code_2D17 ; continue at the selected control-flow target
Code_2D11           lda       #$05      ; load the value needed by the following operation
                    bra       Code_2D17 ; continue at the selected control-flow target
Code_2D15           lda       #$03      ; load the value needed by the following operation
Code_2D17           ldb       Code_00D0 ; load the value needed by the following operation
                    beq       Code_2D2B ; branch when the compared values are equal
                    cmpb      #$02      ; compare against the limit and set condition flags
                    bcs       Code_2D29 ; branch when carry reports an unsigned underflow or error
                    beq       Code_2D25 ; branch when the compared values are equal
                    ora       #$A0      ; set the selected flag bits
                    bra       Code_2D2B ; continue at the selected control-flow target
Code_2D25           ora       #$20      ; set the selected flag bits
                    bra       Code_2D2B ; continue at the selected control-flow target
Code_2D29           ora       #$80      ; set the selected flag bits
Code_2D2B           sta       Addr_0064 ; save the current value in working storage
                    lda       Code_0049 ; load the value needed by the following operation
                    beq       Code_2D38 ; branch when the compared values are equal
                    clra                ; clear the selected byte or register
                    sta       Addr_0067 ; save the current value in working storage
                    sta       Code_0068 ; save the current value in working storage
                    bra       Code_2D40 ; continue at the selected control-flow target
Code_2D38           lda       #$11      ; load the value needed by the following operation
                    sta       Addr_0067 ; save the current value in working storage
                    lda       #$13      ; load the value needed by the following operation
                    sta       Code_0068 ; save the current value in working storage
Code_2D40           lbsr      Code_2DA6 ; call the referenced helper routine
                    andcc     #$FE      ; mask off unwanted bits
Code_2D45           rts                 ; return to the caller
Code_2D46           leax      Data_20EB,PCR ; form the referenced address without reading memory
                    lbsr      Code_0314 ; call the referenced helper routine
                    lbsr      Code_2B35 ; call the referenced helper routine
                    lbra      Code_03EC ; continue at the distant control-flow target
Code_2D53           clra                ; clear the selected byte or register
                    lda       Addr_0046 ; load the value needed by the following operation
                    bmi       Code_2D6D ; branch while the tested value is negative
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Addr_0046 ; save the current value in working storage
                    lda       Addr_0082 ; load the value needed by the following operation
                    ldb       #$C7      ; load the value needed by the following operation
                    tfr       D,X       ; copy the source register into the destination register
                    stx       Addr_006F ; save the current value in working storage
                    lda       #$03      ; load the value needed by the following operation
                    os9       I$Open    ; request the named OS-9 service
                    bcs       Code_2D6D ; branch when carry reports an unsigned underflow or error
                    sta       Addr_004A ; save the current value in working storage
Code_2D6D           rts                 ; return to the caller
Code_2D6E           rts                 ; return to the caller
Code_2D6F           clra                ; clear the selected byte or register
                    lda       Addr_0046 ; load the value needed by the following operation
                    bne       Code_2D87 ; branch when the compared values differ
                    lda       Addr_0082 ; load the value needed by the following operation
                    ldb       #$C8      ; load the value needed by the following operation
                    tfr       D,X       ; copy the source register into the destination register
                    lda       #$03      ; load the value needed by the following operation
                    os9       I$Attach  ; request the named OS-9 service
                    bcs       Code_2D87 ; branch when carry reports an unsigned underflow or error
                    stu       Code_0047 ; save the current value in working storage
                    lda       #$0F      ; load the value needed by the following operation
                    sta       Addr_0046 ; save the current value in working storage
Code_2D87           rts                 ; return to the caller
Code_2D88           lda       Addr_0046 ; load the value needed by the following operation
                    beq       Code_2D98 ; branch when the compared values are equal
                    lda       Addr_004A ; load the value needed by the following operation
                    os9       I$Close   ; request the named OS-9 service
                    ldu       Code_0047 ; load the value needed by the following operation
                    os9       I$Detach  ; request the named OS-9 service
                    clr       Addr_0046 ; clear the selected byte or register
Code_2D98           rts                 ; return to the caller
Code_2D99           tfr       DP,A      ; copy the source register into the destination register
                    ldb       #$4F      ; load the value needed by the following operation
                    tfr       D,X       ; copy the source register into the destination register
                    lda       Addr_004A ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
                    os9       I$GetStt  ; request the named OS-9 service
                    rts                 ; return to the caller
Code_2DA6           tfr       DP,A      ; copy the source register into the destination register
                    ldb       #$4F      ; load the value needed by the following operation
                    tfr       D,X       ; copy the source register into the destination register
                    lda       Addr_004A ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
                    os9       I$SetStt  ; request the named OS-9 service
                    rts                 ; return to the caller
Code_2DB3           clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    lbsr      Code_0C79 ; call the referenced helper routine
                    bsr       Code_2DCF ; call the referenced helper routine
                    lbsr      Code_0DE9 ; call the referenced helper routine
                    lbsr      Code_0DBD ; call the referenced helper routine
                    lbsr      Code_0CE1 ; call the referenced helper routine
                    lbsr      Code_0D16 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_2DCB           lda       #$40      ; load the value needed by the following operation
                    bra       Code_2DD0 ; continue at the selected control-flow target
Code_2DCF           clra                ; clear the selected byte or register
Code_2DD0           pshs      A         ; preserve the listed registers on the stack
                    lda       #$03      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    ldd       #Addr_000E ; load the value needed by the following operation
                    tst       Addr_009B ; set condition flags from the current value
                    bne       Code_2DE2 ; branch when the compared values differ
                    ldd       #Code_001C ; load the value needed by the following operation
Code_2DE2           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    puls      B         ; restore the listed registers from the stack
                    leax      Data_20CF,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "6"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "Y"                            ; embedded text or resource bytes
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $10       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_2DFE           pshs      X         ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0C       ; private DeskMate service selector
                    stx       Addr_0080 ; save the current value in working storage
                    clr       Addr_007A ; clear the selected byte or register
                    puls      PC,X      ; restore the listed registers from the stack
Code_2E0A           pshs      D         ; preserve the listed registers on the stack
                    ldd       Addr_0080 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    lda       #$03      ; load the value needed by the following operation
                    sta       Addr_007A ; save the current value in working storage
                    puls      PC,D      ; restore the listed registers from the stack
                    fcc       "File Xfer begun"              ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $16       ; table, bitmap, or initialized data bytes
                    fcc       "O_0"                          ; embedded text or resource bytes
                    fcb       $8D,$FF,$E8,$17,$D1,$E0 ; table, bitmap, or initialized data bytes
                    fcb       $0A       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
Code_2E36           pshs      U,Y,X,DP,D ; preserve the listed registers on the stack
                    bsr       Code_2EA8 ; call the referenced helper routine
                    lda       ,S        ; load the value needed by the following operation
                    sta       start     ; save the current value in working storage
                    leay      $0A,U     ; form the referenced address without reading memory
                    ldb       #$07      ; load the value needed by the following operation
Code_2E42           lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,Y+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bgt       Code_2E42 ; branch when the signed value is above the limit
                    clr       Addr_0018 ; clear the selected byte or register
                    clr       Addr_0019 ; clear the selected byte or register
                    clr       Addr_0015 ; clear the selected byte or register
                    clr       Code_001A ; clear the selected byte or register
                    ldb       Addr_000E ; load the value needed by the following operation
                    cmpb      Addr_000C ; compare against the limit and set condition flags
                    bls       Code_2E5F ; branch when the unsigned value is at or below the limit
                    com       Addr_0015 ; invert every bit in the selected value
                    dec       Addr_000C ; decrement the selected counter
                    dec       Addr_000C ; decrement the selected counter
                    inc       Addr_0010 ; advance the selected counter
Code_2E5F           clr       Addr_0011 ; clear the selected byte or register
                    clr       Addr_0017 ; clear the selected byte or register
                    lda       start     ; load the value needed by the following operation
                    suba      Addr_000C ; subtract the operand from the running value
                    bcs       Code_2E6E ; branch when carry reports an unsigned underflow or error
                    inca                ; advance the selected counter
                    sta       Addr_0011 ; save the current value in working storage
                    sta       Addr_0017 ; save the current value in working storage
Code_2E6E           ldb       start     ; load the value needed by the following operation
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
Code_2E85           ldb       Addr_0010 ; load the value needed by the following operation
                    addb      Code_0016 ; add the operand to the running value
                    bsr       Code_2EB5 ; call the referenced helper routine
                    lda       Addr_0017 ; load the value needed by the following operation
                    lbsr      Code_2EC1 ; call the referenced helper routine
                    inc       Code_0016 ; advance the selected counter
                    lda       Code_0016 ; load the value needed by the following operation
                    cmpa      Addr_000C ; compare against the limit and set condition flags
                    beq       Code_2EA0 ; branch when the compared values are equal
                    inc       Addr_0017 ; advance the selected counter
                    lda       Addr_0017 ; load the value needed by the following operation
                    cmpa      Addr_000E ; compare against the limit and set condition flags
                    bne       Code_2E85 ; branch when the compared values differ
Code_2EA0           lbsr      Code_2ED0 ; call the referenced helper routine
                    lbsr      Code_2EDE ; call the referenced helper routine
                    puls      PC,U,Y,X,DP,D ; restore the listed registers from the stack
Code_2EA8           pshs      D         ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "/"                            ; embedded text or resource bytes
                    tfr       A,DP      ; copy the source register into the destination register
                    clrb                ; clear the selected byte or register
                    tfr       D,U       ; copy the source register into the destination register
                    puls      PC,D      ; restore the listed registers from the stack
Code_2EB5           clra                ; clear the selected byte or register
                    tfr       D,Y       ; copy the source register into the destination register
                    ldb       Addr_000F ; load the value needed by the following operation
                    tfr       D,X       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_2EC1           ldx       Addr_000A ; load the value needed by the following operation
                    asla                ; shift left and update carry
                    ldx       A,X       ; load the value needed by the following operation
                    clra                ; clear the selected byte or register
                    ldb       ,X+       ; fetch the next value and advance the source pointer
                    andb      #$80      ; mask off unwanted bits
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_2ED0           ldb       Addr_0014 ; load the value needed by the following operation
                    bsr       Code_2EB5 ; call the referenced helper routine
                    clra                ; clear the selected byte or register
                    ldb       Addr_000D ; load the value needed by the following operation
                    tfr       D,Y       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "$"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_2EDE           tst       Addr_0015 ; set condition flags from the current value
                    beq       Code_2F18 ; branch when the compared values are equal
                    ldb       Addr_0010 ; load the value needed by the following operation
                    decb                ; decrement the selected counter
                    bsr       Code_2F19 ; call the referenced helper routine
                    tst       Addr_0011 ; set condition flags from the current value
                    beq       Code_2EF9 ; branch when the compared values are equal
                    leax      Data_3274,PCR ; form the referenced address without reading memory
                    tst       Addr_0018 ; set condition flags from the current value
                    beq       Code_2EF5 ; branch when the compared values are equal
                    leax      $03,X     ; form the referenced address without reading memory
Code_2EF5           bsr       Code_2F29 ; call the referenced helper routine
                    bra       Code_2EFD ; continue at the selected control-flow target
Code_2EF9           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "A"                            ; embedded text or resource bytes
Code_2EFD           ldb       Addr_001D ; load the value needed by the following operation
                    incb                ; advance the selected counter
                    bsr       Code_2F19 ; call the referenced helper routine
                    ldb       Addr_0011 ; load the value needed by the following operation
                    cmpb      Addr_0012 ; compare against the limit and set condition flags
                    beq       Code_2F14 ; branch when the compared values are equal
                    leax      Data_327A,PCR ; form the referenced address without reading memory
                    tst       Addr_0019 ; set condition flags from the current value
                    beq       Code_2F12 ; branch when the compared values are equal
                    leax      $03,X     ; form the referenced address without reading memory
Code_2F12           bra       Code_2F29 ; continue at the selected control-flow target
Code_2F14           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "A"                            ; embedded text or resource bytes
Code_2F18           rts                 ; return to the caller
Code_2F19           clra                ; clear the selected byte or register
                    tfr       D,Y       ; copy the source register into the destination register
                    ldb       Addr_000D ; load the value needed by the following operation
                    lsrb                ; shift right and expose the low bit through carry
                    addb      Addr_000F ; add the operand to the running value
                    decb                ; decrement the selected counter
                    tfr       D,X       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_2F29           pshs      X         ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1F       ; private DeskMate service selector
                    pshs      Y         ; preserve the listed registers on the stack
                    leax      Data_31F4,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $06       ; private DeskMate service selector
                    ldx       $02,S     ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "F"                            ; embedded text or resource bytes
                    puls      Y,X       ; restore the listed registers from the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $03       ; private DeskMate service selector
                    rts                 ; return to the caller
Code_2F46           pshs      U,Y,X,DP,D ; preserve the listed registers on the stack
                    lbsr      Code_2EA8 ; call the referenced helper routine
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
                    lbeq      Code_2FAB ; take the distant branch when values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "E"                            ; embedded text or resource bytes
                    stb       Addr_0033 ; save the current value in working storage
                    stx       Addr_0034 ; save the current value in working storage
                    sty       Addr_0036 ; save the current value in working storage
                    cmpb      #$01      ; compare against the limit and set condition flags
                    bne       Code_2F7D ; branch when the compared values differ
                    lda       #$0D      ; load the value needed by the following operation
                    cmpy      #Code_00FF ; compare against the limit and set condition flags
                    bne       Code_2F7B ; branch when the compared values differ
                    lda       #$05      ; load the value needed by the following operation
Code_2F7B           sta       Code_001C ; save the current value in working storage
Code_2F7D           tfr       Y,D       ; copy the source register into the destination register
                    cmpb      #$FF      ; compare against the limit and set condition flags
                    beq       Code_2FAB ; branch when the compared values are equal
                    stb       Addr_001B ; save the current value in working storage
                    cmpb      Addr_0010 ; compare against the limit and set condition flags
                    bcs       Code_2FE8 ; branch when carry reports an unsigned underflow or error
                    cmpb      Addr_001D ; compare against the limit and set condition flags
                    bhi       Code_2FE8 ; branch when the unsigned value is above the limit
                    cmpb      Addr_0014 ; compare against the limit and set condition flags
                    beq       Code_2FE0 ; branch when the compared values are equal
Code_2F91           subb      Addr_0010 ; subtract the operand from the running value
                    addb      Addr_0011 ; add the operand to the running value
                    cmpb      Addr_000E ; compare against the limit and set condition flags
                    bcc       Code_2FE0 ; branch when carry is clear
                    pshs      B         ; preserve the listed registers on the stack
                    lbsr      Code_2ED0 ; call the referenced helper routine
                    lda       ,S+       ; load the value needed by the following operation
                    ldb       Addr_001B ; load the value needed by the following operation
                    stb       Addr_0014 ; save the current value in working storage
                    sta       start     ; save the current value in working storage
                    lbsr      Code_2ED0 ; call the referenced helper routine
                    bra       Code_2FDD ; continue at the selected control-flow target
Code_2FAB           lda       Code_001C ; load the value needed by the following operation
                    cmpa      #$0C      ; compare against the limit and set condition flags
                    beq       Code_2FBD ; branch when the compared values are equal
                    cmpa      #$0A      ; compare against the limit and set condition flags
                    beq       Code_2FCB ; branch when the compared values are equal
                    tst       Code_001A ; set condition flags from the current value
                    beq       Code_2FE0 ; branch when the compared values are equal
                    clr       Code_001A ; clear the selected byte or register
                    bra       Code_2FDD ; continue at the selected control-flow target
Code_2FBD           ldb       Addr_0014 ; load the value needed by the following operation
                    cmpb      Addr_0010 ; compare against the limit and set condition flags
                    lbeq      Code_3023 ; take the distant branch when values are equal
                    decb                ; decrement the selected counter
                    stb       Addr_001B ; save the current value in working storage
                    lbra      Code_2F91 ; continue at the distant control-flow target
Code_2FCB           ldb       Addr_0014 ; load the value needed by the following operation
                    cmpb      Addr_001D ; compare against the limit and set condition flags
                    lbeq      Code_2FF1 ; take the distant branch when values are equal
                    incb                ; advance the selected counter
                    stb       Addr_001B ; save the current value in working storage
                    lbra      Code_2F91 ; continue at the distant control-flow target
Code_2FD9           lda       #$FF      ; load the value needed by the following operation
                    sta       Code_001A ; save the current value in working storage
Code_2FDD           lbsr      Code_2EDE ; call the referenced helper routine
Code_2FE0           ldb       Code_001C ; load the value needed by the following operation
                    lda       start     ; load the value needed by the following operation
                    leas      $02,S     ; form the referenced address without reading memory
                    puls      PC,U,Y,X,DP ; restore the listed registers from the stack
Code_2FE8           lda       Addr_001D ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    cmpa      Addr_001B ; compare against the limit and set condition flags
                    bne       Code_301A ; branch when the compared values differ
                    inc       Addr_0019 ; advance the selected counter
Code_2FF1           ldb       Addr_0011 ; load the value needed by the following operation
                    cmpb      Addr_0012 ; compare against the limit and set condition flags
                    beq       Code_2FE0 ; branch when the compared values are equal
                    inc       Addr_0011 ; advance the selected counter
                    lbsr      Code_2ED0 ; call the referenced helper routine
                    inc       start     ; advance the selected counter
                    bsr       Code_3047 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $26       ; private DeskMate service selector
                    ldb       Addr_001D ; load the value needed by the following operation
                    lbsr      Code_2EB5 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "A"                            ; embedded text or resource bytes
                    lda       Addr_0011 ; load the value needed by the following operation
                    adda      Addr_000C ; add the operand to the running value
                    deca                ; decrement the selected counter
                    lbsr      Code_2EC1 ; call the referenced helper routine
                    lbsr      Code_2ED0 ; call the referenced helper routine
                    bra       Code_2FD9 ; continue at the selected control-flow target
Code_301A           lda       Addr_0010 ; load the value needed by the following operation
                    deca                ; decrement the selected counter
                    cmpa      Addr_001B ; compare against the limit and set condition flags
                    bne       Code_2FDD ; branch when the compared values differ
                    inc       Addr_0018 ; advance the selected counter
Code_3023           tst       Addr_0011 ; set condition flags from the current value
                    beq       Code_2FE0 ; branch when the compared values are equal
                    lbsr      Code_2ED0 ; call the referenced helper routine
                    dec       Addr_0011 ; decrement the selected counter
                    dec       start     ; decrement the selected counter
                    bsr       Code_3047 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "'"                            ; embedded text or resource bytes
                    ldb       Addr_0010 ; load the value needed by the following operation
                    lbsr      Code_2EB5 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "A"                            ; embedded text or resource bytes
                    lda       Addr_0011 ; load the value needed by the following operation
                    lbsr      Code_2EC1 ; call the referenced helper routine
                    lbsr      Code_2ED0 ; call the referenced helper routine
                    bra       Code_2FD9 ; continue at the selected control-flow target
Code_3047           ldb       Addr_0010 ; load the value needed by the following operation
                    lbsr      Code_2EB5 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0C       ; private DeskMate service selector
                    tfr       X,D       ; copy the source register into the destination register
                    pshs      A         ; preserve the listed registers on the stack
                    clra                ; clear the selected byte or register
                    tfr       D,X       ; copy the source register into the destination register
                    puls      B         ; restore the listed registers from the stack
                    tfr       D,Y       ; copy the source register into the destination register
                    ldu       #Data_2000 ; load the value needed by the following operation
                    ldd       Addr_000C ; load the value needed by the following operation
                    rts                 ; return to the caller
Code_3061           pshs      U,Y,X,DP,D ; preserve the listed registers on the stack
                    lbsr      Code_2EA8 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "9"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "0"                            ; embedded text or resource bytes
                    sta       Addr_0026 ; save the current value in working storage
                    ldd       ,S        ; load the value needed by the following operation
                    stb       Addr_001F ; save the current value in working storage
                    tsta                ; set condition flags from the current value
                    bpl       Code_3098 ; branch while the tested value is nonnegative
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
Code_3095           lbsr      Code_31B5 ; call the referenced helper routine
Code_3098           lbsr      Code_31D0 ; call the referenced helper routine
Code_309B           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $18       ; private DeskMate service selector
                    anda      #$80      ; mask off unwanted bits
                    ora       #$03      ; set the selected flag bits
                    tfr       A,B       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1C       ; private DeskMate service selector
                    tstb                ; set condition flags from the current value
                    bpl       Code_30B0 ; branch while the tested value is nonnegative
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $16       ; private DeskMate service selector
Code_30B0           sta       Addr_0025 ; save the current value in working storage
                    ldx       Addr_0021 ; load the value needed by the following operation
                    ldb       Addr_001F ; load the value needed by the following operation
                    leay      B,X       ; form the referenced address without reading memory
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bcs       Code_30D4 ; branch when carry reports an unsigned underflow or error
                    cmpa      #$7E      ; compare against the limit and set condition flags
                    bhi       Code_30D4 ; branch when the unsigned value is above the limit
                    tst       Addr_001E ; set condition flags from the current value
                    lbne      Code_3195 ; take the distant branch when values differ
Code_30C6           sta       ,Y        ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "C"                            ; embedded text or resource bytes
Code_30CC           tst       $01,Y     ; set condition flags from the current value
                    beq       Code_309B ; branch when the compared values are equal
                    inc       Addr_001F ; advance the selected counter
                    bra       Code_3098 ; continue at the selected control-flow target
Code_30D4           cmpa      #$88      ; compare against the limit and set condition flags
                    beq       Code_3123 ; branch when the compared values are equal
                    cmpa      #$08      ; compare against the limit and set condition flags
                    beq       Code_3148 ; branch when the compared values are equal
                    cmpa      #$09      ; compare against the limit and set condition flags
                    beq       Code_30CC ; branch when the compared values are equal
                    cmpa      #$C9      ; compare against the limit and set condition flags
                    lbeq      Code_316C ; take the distant branch when values are equal
                    cmpa      #$E9      ; compare against the limit and set condition flags
                    lbeq      Code_316C ; take the distant branch when values are equal
                    cmpa      #$0C      ; compare against the limit and set condition flags
                    beq       Code_3162 ; branch when the compared values are equal
                    cmpa      #$0A      ; compare against the limit and set condition flags
                    beq       Code_3150 ; branch when the compared values are equal
                    cmpa      #$8D      ; compare against the limit and set condition flags
                    bne       Code_310F ; branch when the compared values differ
                    lda       #$0D      ; load the value needed by the following operation
                    sta       Addr_0025 ; save the current value in working storage
Code_30FC           lda       #$20      ; load the value needed by the following operation
                    sta       ,Y+       ; store the value and advance the destination pointer
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "C"                            ; embedded text or resource bytes
                    tst       ,Y        ; set condition flags from the current value
                    beq       Code_310F ; branch when the compared values are equal
                    inc       Addr_001F ; advance the selected counter
                    lbsr      Code_31D0 ; call the referenced helper routine
                    bra       Code_30FC ; continue at the selected control-flow target
Code_310F           ldb       Addr_001F ; load the value needed by the following operation
                    lda       Addr_0026 ; load the value needed by the following operation
                    beq       Code_3119 ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "3"                            ; embedded text or resource bytes
Code_3119           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       ":"                            ; embedded text or resource bytes
                    lda       Addr_0025 ; load the value needed by the following operation
                    leas      $02,S     ; form the referenced address without reading memory
                    puls      PC,U,Y,X,DP ; restore the listed registers from the stack
Code_3123           tst       Addr_001E ; set condition flags from the current value
                    bne       Code_317A ; branch when the compared values differ
                    tstb                ; set condition flags from the current value
                    beq       Code_313D ; branch when the compared values are equal
                    tst       $01,Y     ; set condition flags from the current value
                    bne       Code_3134 ; branch when the compared values differ
                    lda       #$20      ; load the value needed by the following operation
                    cmpa      ,Y        ; compare against the limit and set condition flags
                    bne       Code_313D ; branch when the compared values differ
Code_3134           dec       Addr_001F ; decrement the selected counter
                    lbsr      Code_31D0 ; call the referenced helper routine
                    ldx       Addr_0021 ; load the value needed by the following operation
                    ldb       Addr_001F ; load the value needed by the following operation
Code_313D           lda       #$20      ; load the value needed by the following operation
                    sta       B,X       ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "C"                            ; embedded text or resource bytes
Code_3145           lbra      Code_309B ; continue at the distant control-flow target
Code_3148           tstb                ; set condition flags from the current value
                    beq       Code_3145 ; branch when the compared values are equal
                    dec       Addr_001F ; decrement the selected counter
                    lbra      Code_3098 ; continue at the distant control-flow target
Code_3150           lda       Code_0020 ; load the value needed by the following operation
Code_3152           deca                ; decrement the selected counter
                    bmi       Code_315D ; branch while the tested value is negative
                    incb                ; advance the selected counter
                    tst       B,X       ; set condition flags from the current value
                    bne       Code_3152 ; branch when the compared values differ
Code_315A           lbra      Code_3119 ; continue at the distant control-flow target
Code_315D           stb       Addr_001F ; save the current value in working storage
                    lbra      Code_3098 ; continue at the distant control-flow target
Code_3162           lda       Code_0020 ; load the value needed by the following operation
Code_3164           deca                ; decrement the selected counter
                    bmi       Code_315D ; branch while the tested value is negative
                    decb                ; decrement the selected counter
                    bmi       Code_315A ; branch while the tested value is negative
                    bra       Code_3164 ; continue at the selected control-flow target
Code_316C           lda       #$FF      ; load the value needed by the following operation
                    com       Addr_001E ; invert every bit in the selected value
                    beq       Code_3174 ; branch when the compared values are equal
                    lda       #$01      ; load the value needed by the following operation
Code_3174           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1E       ; private DeskMate service selector
                    bra       Code_3145 ; continue at the selected control-flow target
Code_317A           tstb                ; set condition flags from the current value
                    bne       Code_3180 ; branch when the compared values differ
                    incb                ; advance the selected counter
                    stb       Addr_001F ; save the current value in working storage
Code_3180           leax      B,X       ; form the referenced address without reading memory
Code_3182           lda       ,X+       ; fetch the next value and advance the source pointer
                    beq       Code_318A ; branch when the compared values are equal
                    sta       -$02,X    ; save the current value in working storage
                    bra       Code_3182 ; continue at the selected control-flow target
Code_318A           lda       #$20      ; load the value needed by the following operation
                    sta       -$02,X    ; save the current value in working storage
                    dec       Addr_001F ; decrement the selected counter
                    bsr       Code_31D0 ; call the referenced helper routine
                    lbra      Code_3095 ; continue at the distant control-flow target
Code_3195           tst       $01,Y     ; set condition flags from the current value
                    lbeq      Code_30C6 ; take the distant branch when values are equal
                    pshs      Y,A       ; preserve the listed registers on the stack
Code_319D           lda       ,Y+       ; fetch the next value and advance the source pointer
                    bne       Code_319D ; branch when the compared values differ
                    leay      -$02,Y    ; form the referenced address without reading memory
Code_31A3           lda       ,-Y       ; load the value needed by the following operation
                    sta       $01,Y     ; save the current value in working storage
                    cmpy      $01,S     ; compare against the limit and set condition flags
                    bne       Code_31A3 ; branch when the compared values differ
                    puls      X,A       ; restore the listed registers from the stack
                    sta       ,X        ; save the current value in working storage
                    bsr       Code_31B5 ; call the referenced helper routine
                    lbra      Code_30CC ; continue at the distant control-flow target
Code_31B5           ldx       Addr_0021 ; load the value needed by the following operation
                    ldb       Addr_001F ; load the value needed by the following operation
                    pshs      B         ; preserve the listed registers on the stack
                    leax      B,X       ; form the referenced address without reading memory
Code_31BD           bsr       Code_31D0 ; call the referenced helper routine
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    beq       Code_31CB ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "C"                            ; embedded text or resource bytes
                    inc       Addr_001F ; advance the selected counter
                    bra       Code_31BD ; continue at the selected control-flow target
Code_31CB           puls      B         ; restore the listed registers from the stack
                    stb       Addr_001F ; save the current value in working storage
                    rts                 ; return to the caller
Code_31D0           ldb       Addr_001F ; load the value needed by the following operation
                    clra                ; clear the selected byte or register
Code_31D3           inca                ; advance the selected counter
                    subb      Code_0020 ; subtract the operand from the running value
                    bhi       Code_31D3 ; branch when the unsigned value is above the limit
                    beq       Code_31DD ; branch when the compared values are equal
                    deca                ; decrement the selected counter
                    addb      Code_0020 ; add the operand to the running value
Code_31DD           adda      Data_0023 ; add the operand to the running value
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
Data_31F4           fcb       $00,$03,$0C ; table, bitmap, or initialized data bytes
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
Data_3274           fcb       $80,$81,$00,$84,$85,$00 ; table, bitmap, or initialized data bytes
Data_327A           fcb       $82,$83,$00,$86,$87,$00 ; table, bitmap, or initialized data bytes
Data_3280           fcb       $00,$04,$08,$18,$03,$00 ; table, bitmap, or initialized data bytes
                    fcb       $FF       ; table, bitmap, or initialized data bytes
Data_3287           fcb       $FF       ; table, bitmap, or initialized data bytes
Data_3288           fcb       $07,$05   ; table, bitmap, or initialized data bytes
                    fcc       "  Save as:"                   ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_3295           fcb       $00,$02,$0C,$1C,$07,$00 ; table, bitmap, or initialized data bytes
                    fcb       $AA       ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
Data_329D           fcc       "Use "                         ; embedded text or resource bytes
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
Data_32C8           fcc       "Filename must be 1-8"         ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "characters, begin wit"        ; embedded text or resource bytes
                    fcc       "h"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "a-z "                         ; embedded text or resource bytes
                    fcb       $26       ; table, bitmap, or initialized data bytes
                    fcc       " contain a-z or 0-9"          ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_330D           fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
Code_331E           pshs      DP        ; preserve the listed registers on the stack
                    pshs      U,Y,X,A   ; preserve the listed registers on the stack
                    lda       $06,Y     ; load the value needed by the following operation
                    sta       Data_3287,PCR ; save the current value in working storage
                    lbsr      Code_2EA8 ; call the referenced helper routine
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       ">"                            ; embedded text or resource bytes
                    sta       Addr_0029 ; save the current value in working storage
                    clr       Addr_002A ; clear the selected byte or register
                    clr       Addr_002B ; clear the selected byte or register
                    ldx       ,Y        ; load the value needed by the following operation
                    stx       Data_0027 ; save the current value in working storage
                    leau      >Data_330D,PCR ; form the referenced address without reading memory
                    stu       ,Y        ; save the current value in working storage
                    lbsr      Code_3441 ; call the referenced helper routine
                    leax      Data_3280,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    ldx       $01,S     ; load the value needed by the following operation
                    bne       Code_3352 ; branch when the compared values differ
                    leax      Data_3288,PCR ; form the referenced address without reading memory
Code_3352           clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
Code_3358           ldx       #Addr_000B ; load the value needed by the following operation
                    leay      -$0B,X    ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    ldy       $03,S     ; load the value needed by the following operation
                    ldx       ,Y        ; load the value needed by the following operation
                    ldd       #Addr_9000 ; load the value needed by the following operation
Code_3369           lbsr      Code_3061 ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    beq       Code_3379 ; branch when the compared values are equal
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    beq       Code_33B5 ; branch when the compared values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    beq       Code_33AA ; branch when the compared values are equal
                    bra       Code_33A6 ; continue at the selected control-flow target
Code_3379           pshs      U,Y,X,D   ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       ">"                            ; embedded text or resource bytes
                    pshs      A         ; preserve the listed registers on the stack
                    tst       Data_3287,PCR ; set condition flags from the current value
                    bne       Code_338B ; branch when the compared values differ
                    deca                ; decrement the selected counter
                    bpl       Code_338B ; branch while the tested value is nonnegative
                    inca                ; advance the selected counter
Code_338B           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "="                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "E"                            ; embedded text or resource bytes
                    puls      A         ; restore the listed registers from the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "="                            ; embedded text or resource bytes
                    cmpx      #Code_00FF ; compare against the limit and set condition flags
                    puls      U,Y,X,D   ; restore the listed registers from the stack
                    bne       Code_33B5 ; branch when the compared values differ
                    lda       #$05      ; load the value needed by the following operation
                    bra       Code_33AA ; continue at the selected control-flow target
                    fcc       "5v"                           ; embedded text or resource bytes
Code_33A6           lda       #$0A      ; load the value needed by the following operation
                    bra       Code_3369 ; continue at the selected control-flow target
Code_33AA           ldx       Data_0027 ; load the value needed by the following operation
                    stx       ,Y        ; save the current value in working storage
                    sta       ,S        ; save the current value in working storage
                    clrb                ; clear the selected byte or register
                    puls      U,Y,X,A   ; restore the listed registers from the stack
                    puls      PC,DP     ; restore the listed registers from the stack
Code_33B5           lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpa      #$20      ; compare against the limit and set condition flags
                    beq       Code_33B5 ; branch when the compared values are equal
                    lda       ,X        ; load the value needed by the following operation
                    leax      -$01,X    ; form the referenced address without reading memory
                    cmpa      #$3A      ; compare against the limit and set condition flags
                    bne       Code_33D1 ; branch when the compared values differ
                    lda       ,X        ; load the value needed by the following operation
                    suba      #$31      ; subtract the operand from the running value
                    cmpa      #$02      ; compare against the limit and set condition flags
                    bcs       Code_33D1 ; branch when carry reports an unsigned underflow or error
                    leax      Data_329D,PCR ; form the referenced address without reading memory
                    bra       Code_33E2 ; continue at the selected control-flow target
Code_33D1           ldx       ,Y        ; load the value needed by the following operation
                    lda       ,S        ; load the value needed by the following operation
                    lbsr      start     ;33D5: 17 CC 3B       '.. ; call the referenced helper routine
                    fcc       "J"                            ; embedded text or resource bytes
                    andb      #$EF      ; mask off unwanted bits
                    tstb                ; set condition flags from the current value
                    beq       Code_342D ; branch when the compared values are equal
                    leax      Data_32C8,PCR ; form the referenced address without reading memory
Code_33E2           pshs      X         ; preserve the listed registers on the stack
                    ldb       ,X        ; load the value needed by the following operation
                    tst       Addr_002A ; set condition flags from the current value
                    bne       Code_33F2 ; branch when the compared values differ
                    leax      Data_3295,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
Code_33F2           lda       Addr_0029 ; load the value needed by the following operation
                    adda      #$02      ; add the operand to the running value
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "="                            ; embedded text or resource bytes
                    cmpb      Addr_002B ; compare against the limit and set condition flags
                    beq       Code_3404 ; branch when the compared values are equal
                    stb       Addr_002B ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "?"                            ; embedded text or resource bytes
Code_3404           ldb       #$03      ; load the value needed by the following operation
                    stb       Addr_002A ; save the current value in working storage
                    ldy       #Addr_0001 ; load the value needed by the following operation
Code_340C           clra                ; clear the selected byte or register
                    ldx       #Addr_0001 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    ldx       ,S        ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    stx       ,S        ; save the current value in working storage
                    leay      $01,Y     ; form the referenced address without reading memory
                    decb                ; decrement the selected counter
                    bne       Code_340C ; branch when the compared values differ
                    leas      $02,S     ; form the referenced address without reading memory
                    lda       Addr_0029 ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "="                            ; embedded text or resource bytes
                    lbra      Code_3358 ; continue at the distant control-flow target
Code_342D           lda       Addr_0029 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    clr       ,S        ; clear the selected byte or register
                    ldu       Data_0027 ; load the value needed by the following operation
                    ldx       ,Y        ; load the value needed by the following operation
                    stu       ,Y        ; save the current value in working storage
                    bsr       Code_3441 ; call the referenced helper routine
                    puls      U,Y,X,A   ; restore the listed registers from the stack
                    puls      PC,DP     ; restore the listed registers from the stack
Code_3441           lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,U+       ; store the value and advance the destination pointer
                    bne       Code_3441 ; branch when the compared values differ
                    rts                 ; return to the caller
Data_3448           fcc       "("                            ; embedded text or resource bytes
                    fcb       $0B,$02,$0C,$14,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U8P"                          ; embedded text or resource bytes
                    fcb       $17,$02,$18,$14,$00 ; table, bitmap, or initialized data bytes
                    fcc       "U8"                           ; embedded text or resource bytes
Data_3458           fcb       $02,$03,$00,$06,$05 ; table, bitmap, or initialized data bytes
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
Data_348F           fcb       $00,$00,$0E,$08,$00 ; table, bitmap, or initialized data bytes
Data_3494           fcb       $01,$04   ; table, bitmap, or initialized data bytes
Data_3496           fcb       $00,$00,$C8,$00,$18,$01 ; table, bitmap, or initialized data bytes
                    fcb       $08,$00   ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $00,$01,$18,$00,$18,$01 ; table, bitmap, or initialized data bytes
                    fcc       "X"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
Code_34A8           pshs      D         ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0F       ; private DeskMate service selector
                    cmpb      #$50      ; compare against the limit and set condition flags
                    bne       Code_34B6 ; branch when the compared values differ
                    tfr       X,D       ; copy the source register into the destination register
                    leax      D,X       ; form the referenced address without reading memory
Code_34B6           puls      D         ; restore the listed registers from the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "5"                            ; embedded text or resource bytes
                    lda       #$3A      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "5"                            ; embedded text or resource bytes
                    rts                 ; return to the caller
Code_34C7           pshs      U,DP      ; preserve the listed registers on the stack
                    lbsr      Code_2EA8 ; call the referenced helper routine
                    leas      $FE0C,S   ; form the referenced address without reading memory
                    sts       Code_002C ; save the current value in working storage
                    pshs      Y,X,D     ; preserve the listed registers on the stack
                    lbsr      start     ;34D5: 17 CB 3B       '.. ; call the referenced helper routine
                    fcb       $16       ; private DeskMate service selector
                    clr       Addr_0031 ; clear the selected byte or register
                    clra                ; clear the selected byte or register
                    leax      Data_3448,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "8"                            ; embedded text or resource bytes
                    leax      Data_3458,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "G"                            ; embedded text or resource bytes
                    ldb       #$0C      ; load the value needed by the following operation
                    stb       ,X        ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "G"                            ; embedded text or resource bytes
                    ldb       #$02      ; load the value needed by the following operation
                    stb       ,X        ; save the current value in working storage
                    ldx       #Data_1F1A ; load the value needed by the following operation
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
                    bsr       Code_34A8 ; call the referenced helper routine
                    ldx       #Addr_0007 ; load the value needed by the following operation
                    leay      -$06,X    ; form the referenced address without reading memory
                    lda       #$32      ; load the value needed by the following operation
                    lbsr      Code_34A8 ; call the referenced helper routine
                    ldd       Addr_002E ; load the value needed by the following operation
                    tsta                ; set condition flags from the current value
                    bne       Code_3537 ; branch when the compared values differ
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "4"                            ; embedded text or resource bytes
Code_3537           tstb                ; set condition flags from the current value
                    bne       Code_353E ; branch when the compared values differ
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "1"                            ; embedded text or resource bytes
Code_353E           ldx       $04,S     ; load the value needed by the following operation
                    lda       [,X]      ; load the value needed by the following operation
                    suba      #$30      ; subtract the operand from the running value
                    beq       Code_354A ; branch when the compared values are equal
                    cmpa      #$03      ; compare against the limit and set condition flags
                    bcs       Code_3550 ; branch when carry reports an unsigned underflow or error
Code_354A           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "N"                            ; embedded text or resource bytes
                    lda       ,X        ; load the value needed by the following operation
Code_3550           ldx       #DeskMateService ; load the value needed by the following operation
                    leay      $04,X     ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "D"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "@"                            ; embedded text or resource bytes
                    sta       Code_0032 ; save the current value in working storage
                    lbsr      Code_3686 ; call the referenced helper routine
                    ldb       #$29      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "N"                            ; embedded text or resource bytes
                    leax      $26,X     ; form the referenced address without reading memory
                    leax      D,X       ; form the referenced address without reading memory
                    ldu       Code_002C ; load the value needed by the following operation
                    ldy       $04,S     ; load the value needed by the following operation
                    ldy       $02,Y     ; load the value needed by the following operation
                    ldd       #Data_01F4 ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "L"                            ; embedded text or resource bytes
                    lbcs      Code_3682 ; take the distant branch when carry reports an error
                    sta       Code_0030 ; save the current value in working storage
                    beq       Code_35B6 ; branch when the compared values are equal
                    tfr       A,B       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "K"                            ; embedded text or resource bytes
Code_358B           ldx       ,U        ; load the value needed by the following operation
                    leax      -$01,X    ; form the referenced address without reading memory
                    stx       ,U++      ; store the value and advance the destination pointer
                    deca                ; decrement the selected counter
                    bne       Code_358B ; branch when the compared values differ
                    leax      Data_348F,PCR ; form the referenced address without reading memory
                    ldu       Code_002C ; load the value needed by the following operation
                    stu       ,X        ; save the current value in working storage
                    lda       Code_0030 ; load the value needed by the following operation
                    sta       $04,X     ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0F       ; private DeskMate service selector
                    cmpb      #$50      ; compare against the limit and set condition flags
                    bne       Code_35AC ; branch when the compared values differ
                    ldb       #$06      ; load the value needed by the following operation
                    stb       $05,X     ; save the current value in working storage
Code_35AC           clra                ; clear the selected byte or register
                    lbsr      Code_2E36 ; call the referenced helper routine
                    ldb       #$01      ; load the value needed by the following operation
                    stb       Data_3494,PCR ; save the current value in working storage
Code_35B6           tst       Code_0030 ; set condition flags from the current value
                    beq       Code_35BF ; branch when the compared values are equal
                    lbsr      Code_2F46 ; call the referenced helper routine
                    bra       Code_35EC ; continue at the selected control-flow target
Code_35BF           tfr       X,U       ; copy the source register into the destination register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "E"                            ; embedded text or resource bytes
                    exg       U,X       ; exchange the two register values
                    stb       Addr_0033 ; save the current value in working storage
                    stu       Addr_0034 ; save the current value in working storage
                    sty       Addr_0036 ; save the current value in working storage
                    cmpu      #Code_00FF ; compare against the limit and set condition flags
                    bne       Code_35DC ; branch when the compared values differ
                    cmpb      #$01      ; compare against the limit and set condition flags
                    bne       Code_35DC ; branch when the compared values differ
                    ldb       #$05      ; load the value needed by the following operation
                    bra       Code_35EC ; continue at the selected control-flow target
Code_35DC           clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $16       ; private DeskMate service selector
                    tfr       A,B       ; copy the source register into the destination register
                    cmpb      #$0D      ; compare against the limit and set condition flags
                    bne       Code_35EC ; branch when the compared values differ
                    clrb                ; clear the selected byte or register
Code_35EC           tst       Addr_0033 ; set condition flags from the current value
                    beq       Code_3608 ; branch when the compared values are equal
                    pshs      A         ; preserve the listed registers on the stack
                    lda       Code_0037 ; load the value needed by the following operation
                    cmpa      #$03      ; compare against the limit and set condition flags
                    puls      A         ; restore the listed registers from the stack
                    bhi       Code_3608 ; branch when the unsigned value is above the limit
                    lda       #$01      ; load the value needed by the following operation
                    ldb       Code_0035 ; load the value needed by the following operation
                    cmpb      #$05      ; compare against the limit and set condition flags
                    lbcs      Code_3550 ; take the distant branch when carry reports an error
                    inca                ; advance the selected counter
                    lbra      Code_3550 ; continue at the distant control-flow target
Code_3608           cmpb      #$0D      ; compare against the limit and set condition flags
                    beq       Code_3645 ; branch when the compared values are equal
                    cmpb      #$05      ; compare against the limit and set condition flags
                    beq       Code_3676 ; branch when the compared values are equal
                    cmpb      #$09      ; compare against the limit and set condition flags
                    beq       Code_363B ; branch when the compared values are equal
                    cmpb      #$08      ; compare against the limit and set condition flags
                    beq       Code_3640 ; branch when the compared values are equal
                    pshs      D         ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $18       ; private DeskMate service selector
                    tstb                ; set condition flags from the current value
                    beq       Code_3632 ; branch when the compared values are equal
                    lda       Code_0037 ; load the value needed by the following operation
                    cmpa      #$03      ; compare against the limit and set condition flags
                    bhi       Code_3637 ; branch when the unsigned value is above the limit
                    lda       #$01      ; load the value needed by the following operation
                    ldb       Code_0035 ; load the value needed by the following operation
                    cmpb      #$05      ; compare against the limit and set condition flags
                    bcs       Code_3630 ; branch when carry reports an unsigned underflow or error
                    inca                ; advance the selected counter
Code_3630           bsr       Code_3686 ; call the referenced helper routine
Code_3632           puls      D         ; restore the listed registers from the stack
                    lbra      Code_35B6 ; continue at the distant control-flow target
Code_3637           lda       Code_0032 ; load the value needed by the following operation
                    bra       Code_3630 ; continue at the selected control-flow target
Code_363B           lda       #$02      ; load the value needed by the following operation
                    lbra      Code_3550 ; continue at the distant control-flow target
Code_3640           lda       #$01      ; load the value needed by the following operation
                    lbra      Code_3550 ; continue at the distant control-flow target
Code_3645           ldx       Code_002C ; load the value needed by the following operation
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
Code_365B           lda       #$20      ; load the value needed by the following operation
                    tst       ,X        ; set condition flags from the current value
                    beq       Code_3663 ; branch when the compared values are equal
                    lda       ,X+       ; fetch the next value and advance the source pointer
Code_3663           sta       ,U+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bne       Code_365B ; branch when the compared values differ
                    clr       ,U        ; clear the selected byte or register
                    lda       ,S        ; load the value needed by the following operation
                    clr       ,S        ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "J"                            ; embedded text or resource bytes
                    stb       $01,S     ; save the current value in working storage
                    bra       Code_367A ; continue at the selected control-flow target
Code_3676           lda       #$FF      ; load the value needed by the following operation
                    sta       ,S        ; save the current value in working storage
Code_367A           puls      Y,X,D     ; restore the listed registers from the stack
                    leas      $01F4,S   ; form the referenced address without reading memory
                    puls      PC,U,DP   ; restore the listed registers from the stack
Code_3682           stb       $01,S     ; save the current value in working storage
                    bra       Code_367A ; continue at the selected control-flow target
Code_3686           pshs      X,D       ; preserve the listed registers on the stack
                    cmpa      Addr_0031 ; compare against the limit and set condition flags
                    beq       Code_36AA ; branch when the compared values are equal
                    deca                ; decrement the selected counter
                    pshs      A         ; preserve the listed registers on the stack
                    ldd       #Code_00FF ; load the value needed by the following operation
                    tst       ,S+       ; set condition flags from the current value
                    bne       Code_3698 ; branch when the compared values differ
                    exg       A,B       ; exchange the two register values
Code_3698           leax      Data_3496,PCR ; form the referenced address without reading memory
                    sta       ,X        ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $13       ; private DeskMate service selector
                    leax      $09,X     ; form the referenced address without reading memory
                    stb       ,X        ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $13       ; private DeskMate service selector
Code_36AA           puls      X,D       ; restore the listed registers from the stack
                    sta       Addr_0031 ; save the current value in working storage
                    rts                 ; return to the caller
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $80       ; table, bitmap, or initialized data bytes
Data_36B1           fcc       "?"                            ; embedded text or resource bytes
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
Data_3EB3           fcb       $CC,$CC   ; table, bitmap, or initialized data bytes
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
