********************************************************************
* DESK - DeskMate 3 resident desktop services
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

                    nam       DESK
                    ttl       DeskMate 3 resident desktop services

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct
atrv                set       ReEnt

                    mod       eom,name,tylg,atrv,start,$0400

name                fcs       /DESK/ ; OS-9 module name

DeskMateDispatcher
DeskMateService     equ       $0000     ; absolute address used by original code
Addr_0001           equ       $0001     ; absolute address used by original code
Addr_0002           equ       $0002     ; absolute address used by original code
Addr_0003           equ       $0003     ; absolute address used by original code
Addr_0004           equ       $0004     ; absolute address used by original code
Addr_0006           equ       $0006     ; absolute address used by original code
Addr_0008           equ       $0008     ; absolute address used by original code
Addr_000C           equ       $000C     ; absolute address used by original code
Addr_0039           equ       $0039     ; absolute address used by original code
Addr_003F           equ       $003F     ; absolute address used by original code
Addr_0041           equ       $0041     ; absolute address used by original code
Addr_0045           equ       $0045     ; absolute address used by original code
Addr_0049           equ       $0049     ; absolute address used by original code
Addr_004B           equ       $004B     ; absolute address used by original code
Addr_004F           equ       $004F     ; absolute address used by original code
Addr_0055           equ       $0055     ; absolute address used by original code
Addr_0057           equ       $0057     ; absolute address used by original code
Addr_0059           equ       $0059     ; absolute address used by original code
Addr_0061           equ       $0061     ; absolute address used by original code
Addr_0065           equ       $0065     ; absolute address used by original code
Addr_006D           equ       $006D     ; absolute address used by original code
Addr_0070           equ       $0070     ; absolute address used by original code
Addr_0072           equ       $0072     ; absolute address used by original code
Addr_0075           equ       $0075     ; absolute address used by original code
Addr_007F           equ       $007F     ; absolute address used by original code
Addr_0086           equ       $0086     ; absolute address used by original code
Addr_0095           equ       $0095     ; absolute address used by original code
Addr_00A1           equ       $00A1     ; absolute address used by original code
Addr_00A2           equ       $00A2     ; absolute address used by original code
Addr_00A4           equ       $00A4     ; absolute address used by original code
Addr_00A6           equ       $00A6     ; absolute address used by original code
Addr_00A7           equ       $00A7     ; absolute address used by original code
Addr_00A8           equ       $00A8     ; absolute address used by original code
Addr_00AA           equ       $00AA     ; absolute address used by original code
Addr_00AD           equ       $00AD     ; absolute address used by original code
Addr_00B3           equ       $00B3     ; absolute address used by original code
Addr_00C4           equ       $00C4     ; absolute address used by original code
Addr_00FF           equ       $00FF     ; absolute address used by original code
Addr_0113           equ       $0113     ; absolute address used by original code
Addr_011B           equ       $011B     ; absolute address used by original code
Addr_1281           equ       $1281     ; absolute address used by original code
Addr_12AB           equ       $12AB     ; absolute address used by original code
Addr_1B34           equ       $1B34     ; absolute address used by original code
Addr_1F40           equ       $1F40     ; absolute address used by original code
Addr_2000           equ       $2000     ; absolute address used by original code
Addr_2F50           equ       $2F50     ; absolute address used by original code
Addr_3C00           equ       $3C00     ; absolute address used by original code
Addr_3C28           equ       $3C28     ; absolute address used by original code
Addr_3E80           equ       $3E80     ; absolute address used by original code
Addr_4000           equ       $4000     ; absolute address used by original code
Addr_420A           equ       $420A     ; absolute address used by original code
Addr_6000           equ       $6000     ; absolute address used by original code
Addr_8000           equ       $8000     ; absolute address used by original code
Addr_FFFF           equ       $FFFF     ; absolute address used by original code
Addr_181A           equ       $181A     ; absolute address used by original code

Code_0011           ldy       #Addr_0001 ; load the value needed by the following operation
                    ldd       #Data_0D20 ; load the value needed by the following operation
Code_0018           cmpb      ,X+       ; compare against the limit and set condition flags
Code_001A           beq       Code_0018 ; branch when the compared values are equal
                    leax      -$01,X    ; form the referenced address without reading memory
                    pshs      Y,D       ; preserve the listed registers on the stack
                    leay      $00B4,U   ; form the referenced address without reading memory
                    sty       Addr_0004 ; save the current value in working storage
                    clrb                ; clear the selected byte or register
Code_0028           lda       B,X       ; load the value needed by the following operation
                    sta       B,Y       ; save the current value in working storage
                    beq       Code_003A ; branch when the compared values are equal
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    beq       Code_003A ; branch when the compared values are equal
                    incb                ; advance the selected counter
Code_0033           cmpb      #$2F      ; compare against the limit and set condition flags
                    bcs       Code_0028 ; branch when carry reports an unsigned underflow or error
                    decb                ; decrement the selected counter
Code_0038           clr       B,Y       ; clear the selected byte or register
Code_003A           tfr       Y,X       ; copy the source register into the destination register
Code_003C           puls      Y,D       ; restore the listed registers from the stack
Code_003E           tst       ,X        ; set condition flags from the current value
Code_0040           beq       Code_0050 ; branch when the compared values are equal
                    cmpa      ,X        ; compare against the limit and set condition flags
Code_0044           beq       Code_0050 ; branch when the compared values are equal
                    cmpb      ,X+       ; compare against the limit and set condition flags
                    bne       Code_003E ; branch when the compared values differ
Code_004A           sta       -$01,X    ; save the current value in working storage
                    stx       Addr_0006 ; save the current value in working storage
Code_004E           bra       Code_0056 ; continue at the selected control-flow target
Code_0050           stx       Addr_0006 ; save the current value in working storage
                    sta       $01,X     ; save the current value in working storage
Code_0054           bra       Code_0064 ; continue at the selected control-flow target
Code_0056           tst       ,X        ; set condition flags from the current value
                    beq       Code_0064 ; branch when the compared values are equal
                    cmpa      ,X        ; compare against the limit and set condition flags
                    beq       Code_0064 ; branch when the compared values are equal
                    leax      $01,X     ; form the referenced address without reading memory
                    leay      $01,Y     ; form the referenced address without reading memory
                    bra       Code_0056 ; continue at the selected control-flow target
Code_0064           sta       ,X        ; save the current value in working storage
                    sty       Addr_0008 ; save the current value in working storage
Code_0069           rts                 ; return to the caller
start               stu       DeskMateService ; save the current value in working storage
                    pshs      X,D       ; preserve the listed registers on the stack
                    leax      $38,U     ; form the referenced address without reading memory
                    ldb       #$7C      ; load the value needed by the following operation
Code_0073           clra                ; clear the selected byte or register
Code_0074           sta       ,X+       ; store the value and advance the destination pointer
Code_0076           decb                ; decrement the selected counter
Code_0077           bgt       Code_0074 ; branch when the signed value is above the limit
Code_0079           puls      X,D       ; restore the listed registers from the stack
Code_007B           pshs      D         ; preserve the listed registers on the stack
Code_007D           cmpd      #Addr_0001 ; compare against the limit and set condition flags
                    bne       Code_0094 ; branch when the compared values differ
                    lda       ,X        ; load the value needed by the following operation
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    beq       Code_008F ; branch when the compared values are equal
                    cmpa      #$FA      ; compare against the limit and set condition flags
                    bne       Code_0094 ; branch when the compared values differ
                    com       Code_009C ; invert every bit in the selected value
Code_008F           ldd       #DeskMateService ; load the value needed by the following operation
                    std       ,S        ; save the current value in working storage
Code_0094           puls      D         ; restore the listed registers from the stack
                    cmpd      #DeskMateService ; compare against the limit and set condition flags
Code_009A           bne       Code_00A0 ; branch when the compared values differ
Code_009C           leax      Data_1C47,PCR ; form the referenced address without reading memory
Code_00A0           lbsr      Code_0011 ; call the referenced helper routine
Code_00A3           tfr       DP,A      ; copy the source register into the destination register
Code_00A5           sta       Data_1DC6,PCR ; save the current value in working storage
Code_00A9           ldd       #Addr_00FF ; load the value needed by the following operation
Code_00AC           std       Code_0038 ; save the current value in working storage
                    lda       #$28      ; load the value needed by the following operation
Code_00B0           sta       Code_003E ; save the current value in working storage
                    ldd       #Addr_FFFF ; load the value needed by the following operation
                    std       Addr_0061 ; save the current value in working storage
                    std       Code_0069 ; save the current value in working storage
                    lda       #$18      ; load the value needed by the following operation
                    sta       Code_0074 ; save the current value in working storage
                    lda       #$01      ; load the value needed by the following operation
                    sta       Addr_003F ; save the current value in working storage
                    leax      Data_1C57,PCR ; form the referenced address without reading memory
                    leay      $0233,U   ; form the referenced address without reading memory
                    sty       Addr_006D ; save the current value in working storage
                    ldb       #$10      ; load the value needed by the following operation
                    lbsr      Code_02D9 ; call the referenced helper routine
                    leax      $0243,U   ; form the referenced address without reading memory
                    stx       Addr_0095 ; save the current value in working storage
                    ldx       Addr_0004 ; load the value needed by the following operation
                    leay      Data_1C47,PCR ; form the referenced address without reading memory
Code_00DD           lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpa      ,Y+       ; compare against the limit and set condition flags
                    bne       Code_00E9 ; branch when the compared values differ
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    bne       Code_00DD ; branch when the compared values differ
                    com       Code_0044 ; invert every bit in the selected value
Code_00E9           pshs      PC        ; preserve the listed registers on the stack
                    leax      Data_1C69,PCR ; form the referenced address without reading memory
                    lda       #$03      ; load the value needed by the following operation
                    os9       I$Open    ; request the named OS-9 service
                    lbcs      Code_1AC7 ; take the distant branch when carry reports an error
                    leas      $02,S     ; form the referenced address without reading memory
                    sta       Addr_007F ; save the current value in working storage
                    ldb       #$94      ; load the value needed by the following operation
                    ldx       #Addr_0001 ; load the value needed by the following operation
                    ldy       #Addr_FFFF ; load the value needed by the following operation
                    os9       I$SetStt  ; request the named OS-9 service
Code_0108           ldb       #$89      ; load the value needed by the following operation
                    ldx       #Code_0378 ; load the value needed by the following operation
                    ldy       #DeskMateService ; load the value needed by the following operation
                    os9       I$SetStt  ; request the named OS-9 service
                    pshs      PC        ; preserve the listed registers on the stack
                    leax      $02B4,U   ; form the referenced address without reading memory
                    lda       Addr_007F ; load the value needed by the following operation
                    ldb       #$00      ; load the value needed by the following operation
                    os9       I$GetStt  ; request the named OS-9 service
                    lbcs      Code_1AC7 ; take the distant branch when carry reports an error
                    leas      $02,S     ; form the referenced address without reading memory
                    ldb       #$1F      ; load the value needed by the following operation
                    leay      $00E4,U   ; form the referenced address without reading memory
Code_012D           lda       B,X       ; load the value needed by the following operation
                    sta       B,Y       ; save the current value in working storage
                    clr       B,X       ; clear the selected byte or register
                    decb                ; decrement the selected counter
                    bne       Code_012D ; branch when the compared values differ
                    pshs      PC        ; preserve the listed registers on the stack
                    lda       Addr_007F ; load the value needed by the following operation
                    ldb       #$00      ; load the value needed by the following operation
                    os9       I$SetStt  ; request the named OS-9 service
                    lbcs      Code_1AC7 ; take the distant branch when carry reports an error
                    leas      $02,S     ; form the referenced address without reading memory
                    pshs      PC        ; preserve the listed registers on the stack
                    leax      Data_02D8,PCR ; form the referenced address without reading memory
                    pshs      U         ; preserve the listed registers on the stack
                    os9       F$Icpt    ; request the named OS-9 service
                    puls      U         ; restore the listed registers from the stack
                    lbcs      Code_1AC7 ; take the distant branch when carry reports an error
                    leas      $02,S     ; form the referenced address without reading memory
                    lda       Addr_007F ; load the value needed by the following operation
                    ldb       #$8B      ; load the value needed by the following operation
                    ldx       #Addr_0001 ; load the value needed by the following operation
                    os9       I$SetStt  ; request the named OS-9 service
                    lbcs      Code_17BE ; take the distant branch when carry reports an error
                    stx       Code_007B ; save the current value in working storage
                    leau      $02,X     ; form the referenced address without reading memory
                    stu       Code_0079 ; save the current value in working storage
                    sty       Code_0077 ; save the current value in working storage
                    ldy       #Addr_1F40 ; load the value needed by the following operation
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
Code_0175           std       ,X++      ; store the value and advance the destination pointer
                    leay      -$01,Y    ; form the referenced address without reading memory
                    bne       Code_0175 ; branch when the compared values differ
                    ldu       DeskMateService ; load the value needed by the following operation
                    pshs      PC        ; preserve the listed registers on the stack
                    lda       Addr_007F ; load the value needed by the following operation
                    ldb       #$8C      ; load the value needed by the following operation
                    ldy       Code_0077 ; load the value needed by the following operation
                    os9       I$SetStt  ; request the named OS-9 service
                    lbcs      Code_1AC7 ; take the distant branch when carry reports an error
                    leas      $02,S     ; form the referenced address without reading memory
                    lbsr      Code_08AA ; call the referenced helper routine
                    ldu       DeskMateService ; load the value needed by the following operation
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    os9       F$Mem     ; request the named OS-9 service
                    tfr       Y,D       ; copy the source register into the destination register
                    pshs      U         ; preserve the listed registers on the stack
                    subd      ,S++      ; subtract the operand from the running value
                    std       Addr_0057 ; save the current value in working storage
                    leau      $0118,U   ; form the referenced address without reading memory
                    ldd       #Addr_011B ; load the value needed by the following operation
Code_01A8           clr       ,U+       ; clear the selected byte or register
                    subd      #Addr_0001 ; subtract the operand from the running value
                    bne       Code_01A8 ; branch when the compared values differ
                    lbsr      Code_15D8 ; call the referenced helper routine
                    lbcc      Code_022E ; take the distant branch when carry is clear
                    ldu       DeskMateService ; load the value needed by the following operation
                    leau      $0118,U   ; form the referenced address without reading memory
                    ldd       #Code_0108 ; load the value needed by the following operation
                    std       ,U        ; save the current value in working storage
                    inca                ; advance the selected counter
                    sta       $02,U     ; save the current value in working storage
                    lda       #$FF      ; load the value needed by the following operation
                    sta       $08,U     ; save the current value in working storage
                    sta       $1A,U     ; save the current value in working storage
                    sta       $25,U     ; save the current value in working storage
                    ldd       #Addr_3C28 ; load the value needed by the following operation
                    std       $1C,U     ; save the current value in working storage
                    ldd       #Addr_420A ; load the value needed by the following operation
                    std       $1E,U     ; save the current value in working storage
                    ldd       #Data_0D50 ; load the value needed by the following operation
                    sta       $20,U     ; save the current value in working storage
                    stb       $22,U     ; save the current value in working storage
                    lda       #$28      ; load the value needed by the following operation
                    sta       $23,U     ; save the current value in working storage
                    leax      Data_1C4E,PCR ; form the referenced address without reading memory
                    ldb       #$03      ; load the value needed by the following operation
                    leay      $4F,U     ; form the referenced address without reading memory
                    lbsr      Code_02D9 ; call the referenced helper routine
                    ldb       #$03      ; load the value needed by the following operation
                    leax      -$03,X    ; form the referenced address without reading memory
                    leay      $78,U     ; form the referenced address without reading memory
                    lbsr      Code_02D9 ; call the referenced helper routine
                    leax      -$03,X    ; form the referenced address without reading memory
Code_0200           leay      $00A1,U   ; form the referenced address without reading memory
                    ldb       #$08      ; load the value needed by the following operation
                    lbsr      Code_02D9 ; call the referenced helper routine
                    leax      -$08,X    ; form the referenced address without reading memory
                    leay      $00CA,U   ; form the referenced address without reading memory
                    ldb       #$08      ; load the value needed by the following operation
                    lbsr      Code_02D9 ; call the referenced helper routine
                    lda       #$02      ; load the value needed by the following operation
                    sta       $0103,U   ; save the current value in working storage
                    ldd       #Addr_2F50 ; load the value needed by the following operation
                    std       $0104,U   ; save the current value in working storage
                    ldx       Addr_006D ; load the value needed by the following operation
                    leay      $00F3,U   ; form the referenced address without reading memory
                    ldb       #$10      ; load the value needed by the following operation
                    lbsr      Code_02D9 ; call the referenced helper routine
                    bra       Code_0240 ; continue at the selected control-flow target
Code_022E           ldu       DeskMateService ; load the value needed by the following operation
                    leax      $020B,U   ; form the referenced address without reading memory
                    lbsr      Code_09FF ; call the referenced helper routine
                    tst       $013C,U   ; set condition flags from the current value
                    beq       Code_0240 ; branch when the compared values are equal
                    lbsr      Code_0A2B ; call the referenced helper routine
Code_0240           lda       #$11      ; load the value needed by the following operation
                    ldx       Addr_0004 ; load the value needed by the following operation
                    os9       F$Load    ; request the named OS-9 service
                    bcs       Code_02C2 ; branch when carry reports an unsigned underflow or error
                    stu       Addr_0002 ; save the current value in working storage
                    leax      Data_02E4,PCR ; form the referenced address without reading memory
                    leay      $01,Y     ; form the referenced address without reading memory
                    stx       ,Y++      ; store the value and advance the destination pointer
                    pshs      U,Y       ; preserve the listed registers on the stack
                    ldx       Addr_0006 ; load the value needed by the following operation
                    ldu       DeskMateService ; load the value needed by the following operation
                    pshs      Y,X       ; preserve the listed registers on the stack
                    leay      Data_1C47,PCR ; form the referenced address without reading memory
                    ldx       Addr_0004 ; load the value needed by the following operation
Code_0261           lda       ,X+       ; fetch the next value and advance the source pointer
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    beq       Code_0291 ; branch when the compared values are equal
                    cmpa      ,Y+       ; compare against the limit and set condition flags
                    beq       Code_0261 ; branch when the compared values are equal
                    puls      Y,X       ; restore the listed registers from the stack
                    ldd       #Addr_8000 ; load the value needed by the following operation
                    os9       F$Mem     ; request the named OS-9 service
                    bcc       Code_0295 ; branch when carry is clear
                    ldd       #Addr_6000 ; load the value needed by the following operation
                    os9       F$Mem     ; request the named OS-9 service
                    bcc       Code_0295 ; branch when carry is clear
                    ldd       #Addr_4000 ; load the value needed by the following operation
Code_0280           os9       F$Mem     ; request the named OS-9 service
                    bcc       Code_0295 ; branch when carry is clear
Code_0285           ldd       #Addr_2000 ; load the value needed by the following operation
                    os9       F$Mem     ; request the named OS-9 service
                    bcc       Code_0295 ; branch when carry is clear
                    lbcs      Code_1AC7 ; take the distant branch when carry reports an error
Code_0291           puls      Y,X       ; restore the listed registers from the stack
                    bra       Code_0285 ; continue at the selected control-flow target
Code_0295           tfr       Y,D       ; copy the source register into the destination register
                    leau      $0300,U   ; form the referenced address without reading memory
                    pshs      U         ; preserve the listed registers on the stack
                    subd      ,S        ; subtract the operand from the running value
                    std       Addr_0059 ; save the current value in working storage
                    subd      Addr_0008 ; subtract the operand from the running value
                    ldu       $04,S     ; load the value needed by the following operation
                    cmpd      $0B,U     ; compare against the limit and set condition flags
                    bcs       Code_02BD ; branch when carry reports an unsigned underflow or error
                    ldd       $0B,U     ; load the value needed by the following operation
                    ldu       ,S        ; load the value needed by the following operation
                    leay      D,U       ; form the referenced address without reading memory
                    ldd       Addr_0008 ; load the value needed by the following operation
                    pshs      Y,D       ; preserve the listed registers on the stack
                    lbsr      Code_02D9 ; call the referenced helper routine
                    ldd       $04,S     ; load the value needed by the following operation
                    tfr       A,DP      ; copy the source register into the destination register
                    puls      PC,U,X,D  ; restore the listed registers from the stack
Code_02BD           leas      $04,S     ; form the referenced address without reading memory
                    lbra      Code_17B6 ; continue at the distant control-flow target
Code_02C2           lda       Addr_0045 ; load the value needed by the following operation
                    cmpa      #$01      ; compare against the limit and set condition flags
                    lbne      Code_1B62 ; take the distant branch when values differ
                    clr       Addr_0045 ; clear the selected byte or register
                    ldu       DeskMateService ; load the value needed by the following operation
                    leax      Data_1C47,PCR ; form the referenced address without reading memory
                    lbsr      Code_0011 ; call the referenced helper routine
                    lbra      Code_0240 ; continue at the distant control-flow target
Data_02D8           fcc       ";"                      ;02D8: 3B             ' ; embedded text or resource bytes
Code_02D9           pshs      A         ; preserve the listed registers on the stack
Code_02DB           lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,Y+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bne       Code_02DB ; branch when the compared values differ
                    puls      PC,A      ; restore the listed registers from the stack
Data_02E4           fcc       "4"                            ; embedded text or resource bytes
                    fcb       $08       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $F6,$A6,$8D,$1A,$DA,$1F ; table, bitmap, or initialized data bytes
                    fcb       $8B,$AE   ; table, bitmap, or initialized data bytes
                    fcc       "k"                            ; embedded text or resource bytes
                    fcb       $E6,$80,$AF ; table, bitmap, or initialized data bytes
                    fcc       "k0"                           ; embedded text or resource bytes
                    fcb       $8D,$18,$8F ; table, bitmap, or initialized data bytes
                    fcc       "OXI"                          ; embedded text or resource bytes
                    fcb       $EC,$8B   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8B,$AF   ; table, bitmap, or initialized data bytes
                    fcc       "h5v"                          ; embedded text or resource bytes
                    fcb       $AD,$F1   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $88       ; table, bitmap, or initialized data bytes
                    fcc       "4v"                           ; embedded text or resource bytes
Code_0309           lbsr      Code_0B00 ; call the referenced helper routine
                    ldb       #$08      ; load the value needed by the following operation
                    ldy       Code_007D ; load the value needed by the following operation
                    tst       Code_004A ; set condition flags from the current value
                    ble       Code_032C ; branch when the signed value is at or below the limit
Code_0315           lda       ,U+       ; fetch the next value and advance the source pointer
                    tst       Code_0054 ; set condition flags from the current value
                    beq       Code_031D ; branch when the compared values are equal
                    anda      ,Y+       ; mask off unwanted bits
Code_031D           eora      Addr_0049 ; toggle the selected bits
                    sta       ,X        ; save the current value in working storage
                    leax      $50,X     ; form the referenced address without reading memory
                    decb                ; decrement the selected counter
                    bne       Code_0315 ; branch when the compared values differ
                    lbsr      Code_0B12 ; call the referenced helper routine
                    puls      PC,U,Y,X,D ; restore the listed registers from the stack
Code_032C           stb       Addr_0075 ; save the current value in working storage
Code_032E           ldd       ,U++      ; fetch the next value and advance the source pointer
                    tst       Code_0054 ; set condition flags from the current value
                    beq       Code_0338 ; branch when the compared values are equal
                    anda      ,Y+       ; mask off unwanted bits
                    andb      ,Y+       ; mask off unwanted bits
Code_0338           ora       #$00      ; set the selected flag bits
                    eora      #$00      ; toggle the selected bits
                    orb       #$00      ; set the selected flag bits
                    eorb      #$00      ; toggle the selected bits
                    std       ,X        ; save the current value in working storage
                    leax      $50,X     ; form the referenced address without reading memory
                    dec       Addr_0075 ; decrement the selected counter
                    bne       Code_032E ; branch when the compared values differ
                    lbsr      Code_0B12 ; call the referenced helper routine
                    puls      PC,U,Y,X,D ; restore the listed registers from the stack
Data_034E           fcb       $AB,$00,$AF,$AC,$B9,$00 ; table, bitmap, or initialized data bytes
                    fcb       $BB,$B6,$C0,$00,$DA,$BB ; table, bitmap, or initialized data bytes
                    fcb       $FF,$00   ; table, bitmap, or initialized data bytes
Code_035C           pshs      X         ; preserve the listed registers on the stack
                    leax      >Data_034E,PCR ; form the referenced address without reading memory
Code_0362           cmpa      ,X++      ; compare against the limit and set condition flags
                    bhi       Code_0362 ; branch when the unsigned value is above the limit
                    suba      -$01,X    ; subtract the operand from the running value
                    puls      PC,X      ; restore the listed registers from the stack
Code_036A           pshs      D         ; preserve the listed registers on the stack
                    ldu       Code_003A ; load the value needed by the following operation
                    tsta                ; set condition flags from the current value
                    bmi       Code_0373 ; branch while the tested value is negative
                    ldu       Code_003C ; load the value needed by the following operation
Code_0373           anda      #$7F      ; mask off unwanted bits
                    ldb       #$10      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
Code_0378           leau      D,U       ; form the referenced address without reading memory
                    puls      PC,D      ; restore the listed registers from the stack
Code_037C           pshs      D         ; preserve the listed registers on the stack
                    ldx       Code_0079 ; load the value needed by the following operation
                    ldb       Code_0040 ; load the value needed by the following operation
                    aslb                ; shift left and update carry
                    aslb                ; shift left and update carry
                    aslb                ; shift left and update carry
                    addb      Code_0076 ; add the operand to the running value
                    lda       #$50      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    pshs      D         ; preserve the listed registers on the stack
                    ldb       Addr_0041 ; load the value needed by the following operation
                    aslb                ; shift left and update carry
                    clra                ; clear the selected byte or register
                    addd      ,S++      ; add the operand to the running value
                    leax      D,X       ; form the referenced address without reading memory
                    puls      PC,D      ; restore the listed registers from the stack
                    fcb       $8D,$0B   ; table, bitmap, or initialized data bytes
Code_0398           pshs      U,Y,X,D   ; preserve the listed registers on the stack
                    bsr       Code_035C ; call the referenced helper routine
                    bsr       Code_036A ; call the referenced helper routine
                    bsr       Code_037C ; call the referenced helper routine
                    lbra      Code_0309 ; continue at the distant control-flow target
Code_03A3           bitb      #$40      ; test the selected flag bits without changing the value
                    beq       Code_03AB ; branch when the compared values are equal
                    bsr       Code_03B6 ; call the referenced helper routine
                    bra       Code_03AD ; continue at the selected control-flow target
Code_03AB           bsr       Code_03BF ; call the referenced helper routine
Code_03AD           clr       Code_0054 ; clear the selected byte or register
                    bitb      #$80      ; test the selected flag bits without changing the value
                    beq       Code_03B5 ; branch when the compared values are equal
                    com       Code_0054 ; invert every bit in the selected value
Code_03B5           rts                 ; return to the caller
Code_03B6           tst       Addr_0049 ; set condition flags from the current value
                    bne       Code_03BE ; branch when the compared values differ
                    bsr       Code_03C8 ; call the referenced helper routine
                    com       Addr_0049 ; invert every bit in the selected value
Code_03BE           rts                 ; return to the caller
Code_03BF           tst       Addr_0049 ; set condition flags from the current value
                    beq       Code_03C7 ; branch when the compared values are equal
                    bsr       Code_03C8 ; call the referenced helper routine
                    clr       Addr_0049 ; clear the selected byte or register
Code_03C7           rts                 ; return to the caller
Code_03C8           pshs      X,A       ; preserve the listed registers on the stack
                    leax      Code_0338,PCR ; form the referenced address without reading memory
                    lda       $01,X     ; load the value needed by the following operation
                    eora      $03,X     ; toggle the selected bits
                    coma                ; invert every bit in the selected value
                    sta       $03,X     ; save the current value in working storage
                    sta       $07,X     ; save the current value in working storage
                    puls      PC,X,A    ; restore the listed registers from the stack
Code_03D9           bsr       Code_03A3 ; call the referenced helper routine
Code_03DB           pshs      U,Y,X,D   ; preserve the listed registers on the stack
                    clr       Addr_00B3 ; clear the selected byte or register
                    cmpa      #$20      ; compare against the limit and set condition flags
                    bcs       Code_03F6 ; branch when carry reports an unsigned underflow or error
                    bsr       Code_0398 ; call the referenced helper routine
                    inc       Addr_0041 ; advance the selected counter
                    lda       Code_003E ; load the value needed by the following operation
                    tst       Code_004A ; set condition flags from the current value
                    bne       Code_03EE ; branch when the compared values differ
                    deca                ; decrement the selected counter
Code_03EE           cmpa      Addr_0041 ; compare against the limit and set condition flags
                    bhi       Code_043E ; branch when the unsigned value is above the limit
                    clr       Addr_0041 ; clear the selected byte or register
                    bra       Code_041A ; continue at the selected control-flow target
Code_03F6           cmpa      #$08      ; compare against the limit and set condition flags
                    bne       Code_0416 ; branch when the compared values differ
                    lda       Addr_0041 ; load the value needed by the following operation
                    deca                ; decrement the selected counter
                    bpl       Code_040D ; branch while the tested value is nonnegative
                    tst       Code_0040 ; set condition flags from the current value
                    beq       Code_043E ;0401: 27 3B          '' ; branch when the compared values are equal
                    dec       Code_0040 ; decrement the selected counter
                    lda       Code_003E ; load the value needed by the following operation
                    tst       Code_004A ; set condition flags from the current value
                    bne       Code_040C ; branch when the compared values differ
                    deca                ; decrement the selected counter
Code_040C           deca                ; decrement the selected counter
Code_040D           sta       Addr_0041 ; save the current value in working storage
                    lda       #$20      ; load the value needed by the following operation
                    lbsr      Code_0398 ; call the referenced helper routine
                    puls      PC,U,Y,X,D ; restore the listed registers from the stack
Code_0416           cmpa      #$0A      ; compare against the limit and set condition flags
                    bne       Code_042B ; branch when the compared values differ
Code_041A           lda       Code_0040 ; load the value needed by the following operation
                    inca                ; advance the selected counter
                    cmpa      Code_0074 ; compare against the limit and set condition flags
                    bcs       Code_0427 ; branch when carry reports an unsigned underflow or error
                    lbsr      Code_04F0 ; call the referenced helper routine
                    lda       Code_0074 ; load the value needed by the following operation
                    deca                ; decrement the selected counter
Code_0427           sta       Code_0040 ; save the current value in working storage
                    puls      PC,U,Y,X,D ; restore the listed registers from the stack
Code_042B           cmpa      #$0C      ; compare against the limit and set condition flags
                    bne       Code_0436 ; branch when the compared values differ
                    clr       Addr_0041 ; clear the selected byte or register
                    clr       Code_0040 ; clear the selected byte or register
                    lbra      Code_04E4 ; continue at the distant control-flow target
Code_0436           cmpa      #$0D      ; compare against the limit and set condition flags
                    bne       Code_043E ; branch when the compared values differ
                    clr       Addr_0041 ; clear the selected byte or register
                    bra       Code_041A ; continue at the selected control-flow target
Code_043E           puls      PC,U,Y,X,D ; restore the listed registers from the stack
Code_0440           lbsr      Code_03A3 ; call the referenced helper routine
                    lbsr      Code_0B00 ; call the referenced helper routine
                    pshs      Y,X,D     ; preserve the listed registers on the stack
                    tsta                ; set condition flags from the current value
                    beq       Code_0458 ; branch when the compared values are equal
                    leax      Data_1C6F,PCR ; form the referenced address without reading memory
                    clrb                ; clear the selected byte or register
                    deca                ; decrement the selected counter
                    exg       A,B       ; exchange the two register values
                    aslb                ; shift left and update carry
                    ldd       D,X       ; load the value needed by the following operation
                    leax      D,X       ; form the referenced address without reading memory
Code_0458           tst       Addr_004B ; set condition flags from the current value
                    beq       Code_0461 ; branch when the compared values are equal
                    lbsr      Code_1148 ; call the referenced helper routine
                    bra       Code_046A ; continue at the selected control-flow target
Code_0461           lda       ,X+       ; fetch the next value and advance the source pointer
                    beq       Code_046A ; branch when the compared values are equal
                    lbsr      Code_03DB ; call the referenced helper routine
                    bra       Code_0461 ; continue at the selected control-flow target
Code_046A           lbsr      Code_0B12 ; call the referenced helper routine
                    tst       ,S        ; set condition flags from the current value
                    bne       Code_0473 ; branch when the compared values differ
                    stx       $02,S     ; save the current value in working storage
Code_0473           clrb                ; clear the selected byte or register
                    lbsr      Code_03A3 ; call the referenced helper routine
                    puls      PC,Y,X,D  ; restore the listed registers from the stack
                    fcc       "4v"                           ; embedded text or resource bytes
                    fcb       $1F,$12,$17,$06,$80,$DC ; table, bitmap, or initialized data bytes
                    fcc       "@"                            ; embedded text or resource bytes
                    fcb       $81,$18,$22 ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $D1       ; table, bitmap, or initialized data bytes
                    fcc       ">$("                          ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $26,$05   ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $D1       ; table, bitmap, or initialized data bytes
                    fcc       ">'"                           ; embedded text or resource bytes
                    fcb       $1F,$E6   ; table, bitmap, or initialized data bytes
                    fcc       "a"                            ; embedded text or resource bytes
                    fcb       $17,$FF,$0B,$17,$FE,$E1 ; table, bitmap, or initialized data bytes
                    fcb       $E6       ; table, bitmap, or initialized data bytes
                    fcc       "e"                            ; embedded text or resource bytes
                    fcb       $A6,$A0,$17,$FE,$C8,$17 ; table, bitmap, or initialized data bytes
                    fcb       $FE       ; table, bitmap, or initialized data bytes
                    fcc       "bZ'"                          ; embedded text or resource bytes
                    fcb       $0A       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $01,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "J."                           ; embedded text or resource bytes
                    fcb       $EF       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $EB,$17,$06 ; table, bitmap, or initialized data bytes
                    fcc       "]5"                           ; embedded text or resource bytes
                    fcb       $F6,$9F   ; table, bitmap, or initialized data bytes
                    fcc       "}9"                           ; embedded text or resource bytes
                    fcb       $9F       ; table, bitmap, or initialized data bytes
                    fcc       "<9"                           ; embedded text or resource bytes
                    fcb       $9F       ; table, bitmap, or initialized data bytes
                    fcc       ":9"                           ; embedded text or resource bytes
                    fcb       $9F       ; table, bitmap, or initialized data bytes
                    fcc       "} "                           ; embedded text or resource bytes
                    fcb       $02,$9F   ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $17,$04,$CC ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $9F       ; table, bitmap, or initialized data bytes
                    fcc       ": "                           ; embedded text or resource bytes
                    fcb       $F8,$9E   ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $10,$9E   ; table, bitmap, or initialized data bytes
                    fcc       ":94"                          ; embedded text or resource bytes
                    fcb       $06,$9E   ; table, bitmap, or initialized data bytes
                    fcc       "y"                            ; embedded text or resource bytes
                    fcb       $D6       ; table, bitmap, or initialized data bytes
                    fcc       "v"                            ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       "P=1"                          ; embedded text or resource bytes
                    fcb       $8B       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $86,$97   ; table, bitmap, or initialized data bytes
                    fcc       "p9"                           ; embedded text or resource bytes
Code_04E4           pshs      U,Y,X,D   ; preserve the listed registers on the stack
                    lbsr      Code_0B00 ; call the referenced helper routine
                    ldu       Code_007B ; load the value needed by the following operation
                    ldx       #Addr_3E80 ; load the value needed by the following operation
                    bra       Code_051B ; continue at the selected control-flow target
Code_04F0           pshs      U,Y,X,D   ; preserve the listed registers on the stack
                    lbsr      Code_0B00 ; call the referenced helper routine
                    ldy       #Addr_3C00 ; load the value needed by the following operation
                    ldu       Code_0079 ; load the value needed by the following operation
                    ldb       Addr_0070 ; load the value needed by the following operation
                    lda       #$08      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    lda       #$50      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    leau      D,U       ; form the referenced address without reading memory
                    coma                ; invert every bit in the selected value
                    comb                ; invert every bit in the selected value
                    addd      #Addr_0001 ; add the operand to the running value
                    leay      D,Y       ; form the referenced address without reading memory
                    leax      $0280,U   ; form the referenced address without reading memory
Code_0510           ldd       ,X++      ; fetch the next value and advance the source pointer
                    std       ,U++      ; store the value and advance the destination pointer
                    leay      -$02,Y    ; form the referenced address without reading memory
                    bne       Code_0510 ; branch when the compared values differ
                    ldx       #Code_0280 ; load the value needed by the following operation
Code_051B           lda       Code_0038 ; load the value needed by the following operation
                    tst       Addr_0049 ; set condition flags from the current value
                    beq       Code_0523 ; branch when the compared values are equal
                    lda       Addr_0039 ; load the value needed by the following operation
Code_0523           tfr       A,B       ; copy the source register into the destination register
Code_0525           std       ,U++      ; store the value and advance the destination pointer
                    leax      -$02,X    ; form the referenced address without reading memory
                    bne       Code_0525 ; branch when the compared values differ
                    lbsr      Code_0B12 ; call the referenced helper routine
                    puls      PC,U,Y,X,D ; restore the listed registers from the stack
                    fcb       $DD       ; table, bitmap, or initialized data bytes
                    fcc       "@"                            ; embedded text or resource bytes
                    fcb       $0F,$B3   ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $9E       ; table, bitmap, or initialized data bytes
                    fcc       "@94V"                         ; embedded text or resource bytes
                    fcb       $17,$05,$C3,$8D ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $A6,$80   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $1D,$91   ; table, bitmap, or initialized data bytes
                    fcc       ">'"                           ; embedded text or resource bytes
                    fcb       $19,$EC,$81 ; table, bitmap, or initialized data bytes
                    fcc       "="                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "J."                           ; embedded text or resource bytes
                    fcb       $08,$C3,$00,$06 ; table, bitmap, or initialized data bytes
                    fcc       "CS"                           ; embedded text or resource bytes
                    fcb       $C3,$00,$01 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8B,$A6,$80 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $04,$91   ; table, bitmap, or initialized data bytes
                    fcc       ">"                            ; embedded text or resource bytes
                    fcb       $26,$1B,$EC,$81 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $07,$A6   ; table, bitmap, or initialized data bytes
                    fcc       "a"                            ; embedded text or resource bytes
                    fcb       $A7,$E4,$C6 ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $A6,$80,$A7,$C0 ; table, bitmap, or initialized data bytes
                    fcc       "Zj"                           ; embedded text or resource bytes
                    fcb       $E4,$26,$F7 ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $C5       ; table, bitmap, or initialized data bytes
                    fcc       "jb"                           ; embedded text or resource bytes
                    fcb       $26,$EB   ; table, bitmap, or initialized data bytes
                    fcc       "2c"                           ; embedded text or resource bytes
                    fcb       $17,$05,$94 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $D6       ; table, bitmap, or initialized data bytes
Code_0580           pshs      A         ; preserve the listed registers on the stack
                    pshs      B         ; preserve the listed registers on the stack
                    ldu       Code_0079 ; load the value needed by the following operation
                    clr       ,-S       ; clear the selected byte or register
                    ldb       #$50      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    addd      ,S+       ; add the operand to the running value
                    leau      D,U       ; form the referenced address without reading memory
                    puls      B         ; restore the listed registers from the stack
                    puls      PC,A      ; restore the listed registers from the stack
                    fcc       "4F"                           ; embedded text or resource bytes
                    fcb       $17,$05   ; table, bitmap, or initialized data bytes
                    fcc       "h"                            ; embedded text or resource bytes
                    fcb       $0F,$80,$97,$81,$0F,$82 ; table, bitmap, or initialized data bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "J/"                           ; embedded text or resource bytes
                    fcb       $11       ; table, bitmap, or initialized data bytes
                    fcc       "H"                            ; embedded text or resource bytes
                    fcb       $AA,$E4,$A1,$E4 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $0A,$03,$80 ; table, bitmap, or initialized data bytes
                    fcc       "m"                            ; embedded text or resource bytes
                    fcb       $E4       ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $04,$86,$CC,$97,$81,$1F ; table, bitmap, or initialized data bytes
                    fcb       $10,$8D,$C9,$0D,$82 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $06,$86   ; table, bitmap, or initialized data bytes
                    fcc       "c"                            ; embedded text or resource bytes
                    fcb       $A7,$8D,$00,$0A,$96,$81 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $22,$E6   ; table, bitmap, or initialized data bytes
                    fcc       "b"                            ; embedded text or resource bytes
                    fcb       $E7,$E4,$C6 ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $A7,$C0   ; table, bitmap, or initialized data bytes
                    fcc       "Zj"                           ; embedded text or resource bytes
                    fcb       $E4,$26,$F9 ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $C5,$98,$80 ; table, bitmap, or initialized data bytes
                    fcc       "ja"                           ; embedded text or resource bytes
                    fcb       $26,$EB,$86,$A7,$A7,$8D ; table, bitmap, or initialized data bytes
                    fcb       $FF,$EB   ; table, bitmap, or initialized data bytes
                    fcc       "2c"                           ; embedded text or resource bytes
                    fcb       $17,$05   ; table, bitmap, or initialized data bytes
                    fcc       "-5"                           ; embedded text or resource bytes
                    fcb       $C6       ; table, bitmap, or initialized data bytes
                    fcc       "4F"                           ; embedded text or resource bytes
                    fcb       $17,$05,$14,$0F,$82,$03 ; table, bitmap, or initialized data bytes
                    fcb       $82       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $C1       ; table, bitmap, or initialized data bytes
                    fcc       "46"                           ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "J."                           ; embedded text or resource bytes
                    fcb       $04,$1F   ; table, bitmap, or initialized data bytes
                    fcc       " 1"                           ; embedded text or resource bytes
                    fcb       $AB       ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $A9,$08,$00,$DC ; table, bitmap, or initialized data bytes
                    fcc       "@HHH"                         ; embedded text or resource bytes
                    fcb       $9B       ; table, bitmap, or initialized data bytes
                    fcc       "v"                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "J."                           ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "X"                            ; embedded text or resource bytes
                    fcb       $1F,$01,$8D,$D7 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $B6       ; table, bitmap, or initialized data bytes
                    fcc       "4v"                           ; embedded text or resource bytes
                    fcb       $17,$04,$E9,$DE ; table, bitmap, or initialized data bytes
                    fcc       "@"                            ; embedded text or resource bytes
                    fcb       $1F,$10,$D7,$81,$D7,$85 ; table, bitmap, or initialized data bytes
                    fcb       $EB       ; table, bitmap, or initialized data bytes
                    fcc       "a"                            ; embedded text or resource bytes
                    fcb       $D7,$83,$1F ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $D7,$80,$D7,$84,$EB,$E4 ; table, bitmap, or initialized data bytes
                    fcb       $D7,$82,$DC,$84,$91 ; table, bitmap, or initialized data bytes
                    fcc       "t.#"                          ; embedded text or resource bytes
                    fcb       $D1       ; table, bitmap, or initialized data bytes
                    fcc       ">."                           ; embedded text or resource bytes
                    fcb       $12,$DD   ; table, bitmap, or initialized data bytes
                    fcc       "@"                            ; embedded text or resource bytes
                    fcb       $EC       ; table, bitmap, or initialized data bytes
                    fcc       "f"                            ; embedded text or resource bytes
                    fcb       $17,$FD   ; table, bitmap, or initialized data bytes
                    fcc       "X"                            ; embedded text or resource bytes
                    fcb       $DC,$84   ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $D1,$83   ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $04,$D7,$85 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $E6,$D6,$81,$D7,$85 ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $91,$82   ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $04,$97,$84 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $D9,$DF   ; table, bitmap, or initialized data bytes
                    fcc       "@_"                           ; embedded text or resource bytes
                    fcb       $17,$FD   ; table, bitmap, or initialized data bytes
                    fcc       "G"                            ; embedded text or resource bytes
                    fcb       $17,$04,$B3 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $F6,$FF,$FF,$FF,$FF,$0F ; table, bitmap, or initialized data bytes
                    fcb       $0F,$0F,$0F,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcc       "??"                           ; embedded text or resource bytes
                    fcb       $0F,$0F,$03,$03,$FF,$7F ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $1F,$0F,$07,$03,$01,$F0 ; table, bitmap, or initialized data bytes
                    fcb       $F0,$F0,$F0,$FF,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$C0,$C0,$F0,$F0,$FC ; table, bitmap, or initialized data bytes
                    fcb       $FC,$FF,$FF,$80,$C0,$E0 ; table, bitmap, or initialized data bytes
                    fcb       $F0,$F8,$FC,$FE,$FF ; table, bitmap, or initialized data bytes
                    fcc       "4v"                           ; embedded text or resource bytes
                    fcb       $17,$04   ; table, bitmap, or initialized data bytes
                    fcc       "j1"                           ; embedded text or resource bytes
                    fcb       $8D,$FF,$C7,$0D ; table, bitmap, or initialized data bytes
                    fcc       "J-"                           ; embedded text or resource bytes
                    fcb       $0B       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $07       ; table, bitmap, or initialized data bytes
                    fcc       "]'"                           ; embedded text or resource bytes
                    fcb       $02,$C6,$FF ; table, bitmap, or initialized data bytes
                    fcc       "1(1("                         ; embedded text or resource bytes
                    fcb       $8D       ; table, bitmap, or initialized data bytes
                    fcc       "d3H"                          ; embedded text or resource bytes
                    fcb       $E6       ; table, bitmap, or initialized data bytes
                    fcc       "c"                            ; embedded text or resource bytes
                    fcb       $C4,$07,$8D,$1B,$A6 ; table, bitmap, or initialized data bytes
                    fcc       "a "                           ; embedded text or resource bytes
                    fcb       $02,$A7,$80 ; table, bitmap, or initialized data bytes
                    fcc       "3H"                           ; embedded text or resource bytes
                    fcb       $11,$A3   ; table, bitmap, or initialized data bytes
                    fcc       "f#"                           ; embedded text or resource bytes
                    fcb       $F7,$E6   ; table, bitmap, or initialized data bytes
                    fcc       "g"                            ; embedded text or resource bytes
                    fcb       $C4,$07   ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $A8,$18,$8D,$05,$17,$04 ; table, bitmap, or initialized data bytes
                    fcc       "F5"                           ; embedded text or resource bytes
                    fcb       $F6,$A6,$A5,$A4 ; table, bitmap, or initialized data bytes
                    fcc       "c4"                           ; embedded text or resource bytes
                    fcb       $02,$A6,$A5 ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $A4,$84,$AA,$E0,$A7,$80 ; table, bitmap, or initialized data bytes
                    fcc       "94v"                          ; embedded text or resource bytes
                    fcb       $17,$04,$1D,$EC,$01,$10 ; table, bitmap, or initialized data bytes
                    fcb       $AE,$05,$EE,$07,$AE,$03 ; table, bitmap, or initialized data bytes
                    fcc       "4v"                           ; embedded text or resource bytes
                    fcb       $AE       ; table, bitmap, or initialized data bytes
                    fcc       "j"                            ; embedded text or resource bytes
                    fcb       $E6,$84,$AE,$E4,$10,$AE ; table, bitmap, or initialized data bytes
                    fcc       "f"                            ; embedded text or resource bytes
                    fcb       $EE       ; table, bitmap, or initialized data bytes
                    fcc       "d"                            ; embedded text or resource bytes
                    fcb       $8D,$96,$10,$AE ; table, bitmap, or initialized data bytes
                    fcc       "b"                            ; embedded text or resource bytes
                    fcb       $8D,$91,$EE ; table, bitmap, or initialized data bytes
                    fcc       "f"                            ; embedded text or resource bytes
                    fcb       $8D       ; table, bitmap, or initialized data bytes
                    fcc       ";"                      ;0703: 3B             ' ; embedded text or resource bytes
                    fcb       $AE       ; table, bitmap, or initialized data bytes
                    fcc       "d"                            ; embedded text or resource bytes
                    fcb       $8D       ; table, bitmap, or initialized data bytes
                    fcc       "72h"                          ; embedded text or resource bytes
                    fcb       $17,$04,$05 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $F6,$9E   ; table, bitmap, or initialized data bytes
                    fcc       "y"                            ; embedded text or resource bytes
                    fcb       $EC       ; table, bitmap, or initialized data bytes
                    fcc       "d"                            ; embedded text or resource bytes
                    fcb       $C4,$F8,$1F,$03 ; table, bitmap, or initialized data bytes
                    fcc       "DVDVDV0"                      ; embedded text or resource bytes
                    fcb       $8B,$E6   ; table, bitmap, or initialized data bytes
                    fcc       "g"                            ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       "P=0"                          ; embedded text or resource bytes
                    fcb       $8B       ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $0F,$0F,$0F,$0F,$F0,$F0 ; table, bitmap, or initialized data bytes
                    fcb       $F0,$F0   ; table, bitmap, or initialized data bytes
                    fcc       "??"                           ; embedded text or resource bytes
                    fcb       $CF,$CF,$F3,$F3,$FC,$FC ; table, bitmap, or initialized data bytes
                    fcb       $7F,$BF,$DF,$EF,$F7,$FB ; table, bitmap, or initialized data bytes
                    fcb       $FD,$FE   ; table, bitmap, or initialized data bytes
                    fcc       "4v"                           ; embedded text or resource bytes
                    fcb       $17,$03,$BC ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $8D,$FF,$DF,$0D ; table, bitmap, or initialized data bytes
                    fcc       "J-"                           ; embedded text or resource bytes
                    fcb       $0B       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $07       ; table, bitmap, or initialized data bytes
                    fcc       "]'"                           ; embedded text or resource bytes
                    fcb       $02,$C6,$FF ; table, bitmap, or initialized data bytes
                    fcc       "3H3H"                         ; embedded text or resource bytes
                    fcb       $DF,$80,$8D,$B4,$DE,$80 ; table, bitmap, or initialized data bytes
                    fcb       $E6       ; table, bitmap, or initialized data bytes
                    fcc       "c"                            ; embedded text or resource bytes
                    fcb       $C4,$07,$A6,$C5,$97,$80 ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $A4       ; table, bitmap, or initialized data bytes
                    fcc       "a"                            ; embedded text or resource bytes
                    fcb       $97,$81,$E6 ; table, bitmap, or initialized data bytes
                    fcc       "g"                            ; embedded text or resource bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
                    fcc       "e\"                           ; embedded text or resource bytes
                    fcb       $A6,$84,$94,$80,$9A,$81 ; table, bitmap, or initialized data bytes
                    fcb       $A7,$84   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $88       ; table, bitmap, or initialized data bytes
                    fcc       "PZ"                           ; embedded text or resource bytes
                    fcb       $26,$F2,$17,$03,$92 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $F6       ; table, bitmap, or initialized data bytes
                    fcc       "46"                           ; embedded text or resource bytes
                    fcb       $17,$03   ; table, bitmap, or initialized data bytes
                    fcc       "y"                            ; embedded text or resource bytes
                    fcb       $1F,$10   ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $04,$1F   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $1F,$98   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $04,$1F,$02 ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $1F,$01,$EC,$E4 ; table, bitmap, or initialized data bytes
                    fcc       "J'"                           ; embedded text or resource bytes
                    fcb       $0B,$0F,$80,$8D ; table, bitmap, or initialized data bytes
                    fcc       "@"                            ; embedded text or resource bytes
                    fcb       $17,$03   ; table, bitmap, or initialized data bytes
                    fcc       "p5"                           ; embedded text or resource bytes
                    fcb       $B6,$1F,$12 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $04,$1F   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $1F,$89   ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $1E,$02   ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $1F,$01   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $04,$86,$01,$17,$FE ; table, bitmap, or initialized data bytes
                    fcc       "Y5"                           ; embedded text or resource bytes
                    fcb       $B6       ; table, bitmap, or initialized data bytes
                    fcc       "46"                           ; embedded text or resource bytes
                    fcb       $17,$03   ; table, bitmap, or initialized data bytes
                    fcc       "@"                            ; embedded text or resource bytes
                    fcb       $1F,$10   ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $04,$1F   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $1F,$98   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $04,$1F,$01 ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $1F,$02,$EC,$E4 ; table, bitmap, or initialized data bytes
                    fcc       "J'"                           ; embedded text or resource bytes
                    fcb       $D0,$0F,$80,$03,$80,$8D ; table, bitmap, or initialized data bytes
                    fcb       $05,$17,$03 ; table, bitmap, or initialized data bytes
                    fcc       "55"                           ; embedded text or resource bytes
                    fcb       $B6       ; table, bitmap, or initialized data bytes
                    fcc       "4v"                           ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "J."                           ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "XHHH4"                        ; embedded text or resource bytes
                    fcb       $06       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $04,$1F,$10,$0D,$80 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $08,$AB   ; table, bitmap, or initialized data bytes
                    fcc       "cHHHJ "                       ; embedded text or resource bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "HHH"                          ; embedded text or resource bytes
                    fcb       $C6       ; table, bitmap, or initialized data bytes
                    fcc       "P="                           ; embedded text or resource bytes
                    fcb       $1E,$10   ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "J."                           ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "X0"                           ; embedded text or resource bytes
                    fcb       $8B,$1F   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $0D,$80   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $08,$AB   ; table, bitmap, or initialized data bytes
                    fcc       "cHHHJ "                       ; embedded text or resource bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "HHH"                          ; embedded text or resource bytes
                    fcb       $C6       ; table, bitmap, or initialized data bytes
                    fcc       "P="                           ; embedded text or resource bytes
                    fcb       $1E       ; table, bitmap, or initialized data bytes
                    fcc       " O"                           ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "J."                           ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "X1"                           ; embedded text or resource bytes
                    fcb       $AB,$DC   ; table, bitmap, or initialized data bytes
                    fcc       "y0"                           ; embedded text or resource bytes
                    fcb       $8B       ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $AB,$A6,$80,$A7,$A0 ; table, bitmap, or initialized data bytes
                    fcc       "j"                            ; embedded text or resource bytes
                    fcb       $E4,$26,$F8 ; table, bitmap, or initialized data bytes
                    fcc       "ja'"                          ; embedded text or resource bytes
                    fcb       $1C,$C6   ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
                    fcc       "bO"                           ; embedded text or resource bytes
                    fcb       $0D,$80   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $09,$C6   ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $EB       ; table, bitmap, or initialized data bytes
                    fcc       "bCS"                          ; embedded text or resource bytes
                    fcb       $C3,$00,$01 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8B       ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $AB,$E6   ; table, bitmap, or initialized data bytes
                    fcc       "b"                            ; embedded text or resource bytes
                    fcb       $E7,$E4   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $D8       ; table, bitmap, or initialized data bytes
                    fcc       "2c"                           ; embedded text or resource bytes
                    fcb       $EC       ; table, bitmap, or initialized data bytes
                    fcc       "b"                            ; embedded text or resource bytes
                    fcb       $A0       ; table, bitmap, or initialized data bytes
                    fcc       "d"                            ; embedded text or resource bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
                    fcc       "e4"                           ; embedded text or resource bytes
                    fcb       $06       ; table, bitmap, or initialized data bytes
                    fcc       "M' ."                         ; embedded text or resource bytes
                    fcb       $0A       ; table, bitmap, or initialized data bytes
                    fcc       "@"                            ; embedded text or resource bytes
                    fcb       $A7,$E4   ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $E6       ; table, bitmap, or initialized data bytes
                    fcc       "d"                            ; embedded text or resource bytes
                    fcb       $1F,$02   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $09       ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $E6       ; table, bitmap, or initialized data bytes
                    fcc       "d"                            ; embedded text or resource bytes
                    fcb       $EB       ; table, bitmap, or initialized data bytes
                    fcc       "b"                            ; embedded text or resource bytes
                    fcb       $E0,$E4,$1F,$02,$E6 ; table, bitmap, or initialized data bytes
                    fcc       "e"                            ; embedded text or resource bytes
                    fcb       $1F,$01,$A6,$E4,$E6 ; table, bitmap, or initialized data bytes
                    fcc       "c"                            ; embedded text or resource bytes
                    fcb       $17,$FD,$8E,$E6 ; table, bitmap, or initialized data bytes
                    fcc       "a'"                           ; embedded text or resource bytes
                    fcb       $1E       ; table, bitmap, or initialized data bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $08       ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $E7       ; table, bitmap, or initialized data bytes
                    fcc       "aO"                           ; embedded text or resource bytes
                    fcb       $E6       ; table, bitmap, or initialized data bytes
                    fcc       "e "                           ; embedded text or resource bytes
                    fcb       $07       ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $E6       ; table, bitmap, or initialized data bytes
                    fcc       "e"                            ; embedded text or resource bytes
                    fcb       $EB       ; table, bitmap, or initialized data bytes
                    fcc       "c"                            ; embedded text or resource bytes
                    fcb       $E0       ; table, bitmap, or initialized data bytes
                    fcc       "a"                            ; embedded text or resource bytes
                    fcb       $1F,$01,$E6 ; table, bitmap, or initialized data bytes
                    fcc       "d"                            ; embedded text or resource bytes
                    fcb       $1F,$02,$A6 ; table, bitmap, or initialized data bytes
                    fcc       "b"                            ; embedded text or resource bytes
                    fcb       $E6       ; table, bitmap, or initialized data bytes
                    fcc       "a"                            ; embedded text or resource bytes
                    fcb       $17,$FD   ; table, bitmap, or initialized data bytes
                    fcc       "l2b5"                         ; embedded text or resource bytes
                    fcb       $F6       ; table, bitmap, or initialized data bytes
Code_08AA           pshs      U,Y,X,D   ; preserve the listed registers on the stack
                    leas      -$04,S    ; form the referenced address without reading memory
                    tfr       S,X       ; copy the source register into the destination register
                    ldd       #Code_1B31 ; load the value needed by the following operation
                    std       ,X        ; save the current value in working storage
                    ldu       Addr_006D ; load the value needed by the following operation
                    tst       Code_004A ; set condition flags from the current value
                    blt       Code_08DF ; branch when the signed value is below the limit
                    beq       Code_08C9 ; branch when the compared values are equal
                    clra                ; clear the selected byte or register
                    ldb       ,U        ; load the value needed by the following operation
                    bsr       Code_08EF ; call the referenced helper routine
                    inca                ; advance the selected counter
                    ldb       $0F,U     ; load the value needed by the following operation
                    bsr       Code_08EF ; call the referenced helper routine
                    bra       Code_08E9 ; continue at the selected control-flow target
Code_08C9           clra                ; clear the selected byte or register
                    ldb       ,U        ; load the value needed by the following operation
                    bsr       Code_08EF ; call the referenced helper routine
                    inca                ; advance the selected counter
                    ldb       $01,U     ; load the value needed by the following operation
                    bsr       Code_08EF ; call the referenced helper routine
                    inca                ; advance the selected counter
                    ldb       $02,U     ; load the value needed by the following operation
                    bsr       Code_08EF ; call the referenced helper routine
                    inca                ; advance the selected counter
                    ldb       $0F,U     ; load the value needed by the following operation
                    bsr       Code_08EF ; call the referenced helper routine
                    bra       Code_08E9 ; continue at the selected control-flow target
Code_08DF           lda       #$10      ; load the value needed by the following operation
Code_08E1           deca                ; decrement the selected counter
                    ldb       A,U       ; load the value needed by the following operation
                    bsr       Code_08EF ; call the referenced helper routine
                    tsta                ; set condition flags from the current value
                    bne       Code_08E1 ; branch when the compared values differ
Code_08E9           leas      $04,S     ; form the referenced address without reading memory
                    bsr       Code_08FE ; call the referenced helper routine
                    puls      PC,U,Y,X,D ; restore the listed registers from the stack
Code_08EF           pshs      U,Y,X,A   ; preserve the listed registers on the stack
                    std       $02,X     ; save the current value in working storage
                    ldy       #Addr_0004 ; load the value needed by the following operation
                    lda       Addr_007F ; load the value needed by the following operation
                    os9       I$Write   ; request the named OS-9 service
                    puls      PC,U,Y,X,A ; restore the listed registers from the stack
Code_08FE           pshs      U,Y,X,D   ; preserve the listed registers on the stack
                    leas      -$03,S    ; form the referenced address without reading memory
                    tfr       S,X       ; copy the source register into the destination register
                    ldd       #Addr_1B34 ; load the value needed by the following operation
                    std       ,X        ; save the current value in working storage
                    clr       $02,X     ; clear the selected byte or register
                    lda       Addr_007F ; load the value needed by the following operation
                    ldy       #Addr_0003 ; load the value needed by the following operation
                    os9       I$Write   ; request the named OS-9 service
                    leas      $03,S     ; form the referenced address without reading memory
                    puls      PC,U,Y,X,D ; restore the listed registers from the stack
                    fcc       "4v"                           ; embedded text or resource bytes
                    fcb       $0F,$B3,$D6 ; table, bitmap, or initialized data bytes
                    fcc       "AT"                           ; embedded text or resource bytes
                    fcb       $DE       ; table, bitmap, or initialized data bytes
                    fcc       "{"                            ; embedded text or resource bytes
                    fcb       $8E       ; table, bitmap, or initialized data bytes
                    fcc       "X"                            ; embedded text or resource bytes
                    fcb       $10,$10,$8E,$00,$01,$81 ; table, bitmap, or initialized data bytes
                    fcc       "(-I4"                         ; embedded text or resource bytes
                    fcb       $01,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "J5"                           ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $0E,$0C   ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $8E,$12,$08,$10,$8E,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$D6   ; table, bitmap, or initialized data bytes
                    fcc       "AX3^3B"                       ; embedded text or resource bytes
                    fcb       $DF       ; table, bitmap, or initialized data bytes
                    fcc       "y4"                           ; embedded text or resource bytes
                    fcb       $06,$1F,$10,$A7,$8D,$FA ; table, bitmap, or initialized data bytes
                    fcc       "@"                            ; embedded text or resource bytes
                    fcb       $E7,$8D,$FA ; table, bitmap, or initialized data bytes
                    fcc       "$5"                           ; embedded text or resource bytes
                    fcb       $06,$97   ; table, bitmap, or initialized data bytes
                    fcc       ">"                            ; embedded text or resource bytes
                    fcb       $D7       ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $1F       ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $10,$9E   ; table, bitmap, or initialized data bytes
                    fcc       "w"                            ; embedded text or resource bytes
                    fcb       $96,$7F,$C6,$8E,$10 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $8E,$17,$FF ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $9E       ; table, bitmap, or initialized data bytes
                    fcc       "}"                            ; embedded text or resource bytes
                    fcb       $8D       ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $9E       ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $8D,$26,$9E ; table, bitmap, or initialized data bytes
                    fcc       ":"                            ; embedded text or resource bytes
                    fcb       $8D,$22   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $F6,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "J-"                           ; embedded text or resource bytes
                    fcb       $1A,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $DF       ; table, bitmap, or initialized data bytes
                    fcc       "y"                            ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       ">"                            ; embedded text or resource bytes
                    fcb       $10,$9E   ; table, bitmap, or initialized data bytes
                    fcc       "w"                            ; embedded text or resource bytes
                    fcb       $96,$7F,$C6,$8E,$8E,$00 ; table, bitmap, or initialized data bytes
                    fcb       $02,$10   ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $8E,$17,$FF,$17 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $F6       ; table, bitmap, or initialized data bytes
                    fcc       "46"                           ; embedded text or resource bytes
                    fcb       $EC,$1E   ; table, bitmap, or initialized data bytes
                    fcc       "M'"                           ; embedded text or resource bytes
                    fcb       $17,$91   ; table, bitmap, or initialized data bytes
                    fcc       ">'"                           ; embedded text or resource bytes
                    fcb       $13,$96   ; table, bitmap, or initialized data bytes
                    fcc       ">"                            ; embedded text or resource bytes
                    fcb       $A7,$1E,$86,$08 ; table, bitmap, or initialized data bytes
                    fcc       "="                            ; embedded text or resource bytes
                    fcb       $1F,$02,$0D ; table, bitmap, or initialized data bytes
                    fcc       "J."                           ; embedded text or resource bytes
                    fcb       $04,$8D,$22 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $B6,$8D,$02 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $B6       ; table, bitmap, or initialized data bytes
                    fcc       "4v3"                          ; embedded text or resource bytes
                    fcb       $84,$8D,$08 ; table, bitmap, or initialized data bytes
                    fcc       "3A1?"                         ; embedded text or resource bytes
                    fcb       $26,$F8   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $F6,$8D,$00,$A6,$80,$C6 ; table, bitmap, or initialized data bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "Hi"                           ; embedded text or resource bytes
                    fcb       $C4       ; table, bitmap, or initialized data bytes
                    fcc       "HZ"                           ; embedded text or resource bytes
                    fcb       $26,$F9   ; table, bitmap, or initialized data bytes
                    fcc       "94vXI3"                       ; embedded text or resource bytes
                    fcb       $8B,$EC,$E4 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8B       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $1F,$8D,$06 ; table, bitmap, or initialized data bytes
                    fcc       "1?"                           ; embedded text or resource bytes
                    fcb       $26,$F8   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $F6,$8D,$00,$C6,$04 ; table, bitmap, or initialized data bytes
                    fcc       "d"                            ; embedded text or resource bytes
                    fcb       $84       ; table, bitmap, or initialized data bytes
                    fcc       "FGZ"                          ; embedded text or resource bytes
                    fcb       $26,$F9,$A7,$C2 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $D6       ; table, bitmap, or initialized data bytes
                    fcc       ">"                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "J,"                           ; embedded text or resource bytes
                    fcb       $02,$C6,$14 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "v9"                           ; embedded text or resource bytes
Code_09FF           pshs      U,Y,X,D   ; preserve the listed registers on the stack
                    ldy       Addr_006D ; load the value needed by the following operation
                    ldb       #$10      ; load the value needed by the following operation
                    lbsr      Code_02D9 ; call the referenced helper routine
                    lbsr      Code_08AA ; call the referenced helper routine
                    puls      PC,U,Y,X,D ; restore the listed registers from the stack
                    fcc       "46"                           ; embedded text or resource bytes
                    fcb       $9E       ; table, bitmap, or initialized data bytes
                    fcc       "m"                            ; embedded text or resource bytes
                    fcb       $10,$AE   ; table, bitmap, or initialized data bytes
                    fcc       "b"                            ; embedded text or resource bytes
                    fcb       $C6,$10,$17,$F8,$BF ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $B6       ; table, bitmap, or initialized data bytes
                    fcc       "M"                            ; embedded text or resource bytes
                    fcb       $26,$04,$0F ; table, bitmap, or initialized data bytes
                    fcc       "L "                           ; embedded text or resource bytes
                    fcb       $04,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "L9"                           ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       "L9"                           ; embedded text or resource bytes
Code_0A2B           tst       Code_004E ; set condition flags from the current value
                    bne       Code_0A3A ; branch when the compared values differ
                    clr       Code_004E ; clear the selected byte or register
                    com       Code_004E ; invert every bit in the selected value
                    tst       Addr_004F ; set condition flags from the current value
                    beq       Code_0A3A ; branch when the compared values are equal
                    lbsr      Code_0A96 ; call the referenced helper routine
Code_0A3A           rts                 ; return to the caller
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "N'"                           ; embedded text or resource bytes
                    fcb       $07,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "O'"                           ; embedded text or resource bytes
                    fcb       $03,$17,$00,$E8,$0F ; table, bitmap, or initialized data bytes
                    fcc       "N9"                           ; embedded text or resource bytes
Data_0A49           fcb       $FF,$FF,$0C,$00,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $0F,$00,$FC,$FF,$0C,$C0 ; table, bitmap, or initialized data bytes
                    fcb       $FC       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $0C       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $FC,$0F,$0C,$0C,$FC ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $0C       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $FF,$FF,$0F,$F0,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $0C       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
Data_0A69           fcb       $FF,$FF,$F0,$00,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$00,$F0,$FF,$F0,$F0 ; table, bitmap, or initialized data bytes
                    fcb       $F0,$0F,$F0,$0F,$F0,$0F ; table, bitmap, or initialized data bytes
                    fcb       $F0,$0F,$F0,$FF,$F0,$FF ; table, bitmap, or initialized data bytes
                    fcb       $FF,$FF,$FF,$F0,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcb       $F0,$F0   ; table, bitmap, or initialized data bytes
Code_0A89           tst       Code_004E ; set condition flags from the current value
                    beq       Code_0A95 ; branch when the compared values are equal
                    tst       Addr_004F ; set condition flags from the current value
                    bne       Code_0A95 ; branch when the compared values differ
                    bsr       Code_0A96 ; call the referenced helper routine
                    com       Addr_004F ; invert every bit in the selected value
Code_0A95           rts                 ; return to the caller
Code_0A96           pshs      U,Y,X,D   ; preserve the listed registers on the stack
                    leax      >Data_0A49,PCR ; form the referenced address without reading memory
                    tst       Code_004A ; set condition flags from the current value
                    bge       Code_0AA4 ; branch when the signed value is at least the limit
                    leax      >Data_0A69,PCR ; form the referenced address without reading memory
Code_0AA4           ldy       DeskMateService ; load the value needed by the following operation
                    leay      $0104,Y   ; form the referenced address without reading memory
                    ldd       Addr_0065 ; load the value needed by the following operation
                    pshs      B         ; preserve the listed registers on the stack
                    aslb                ; shift left and update carry
                    addb      ,S        ; add the operand to the running value
                    stb       ,S        ; save the current value in working storage
                    exg       A,B       ; exchange the two register values
                    lbsr      Code_0580 ; call the referenced helper routine
                    ldb       #$C0      ; load the value needed by the following operation
                    subb      ,S+       ; subtract the operand from the running value
                    cmpb      #$08      ; compare against the limit and set condition flags
                    bls       Code_0AC3 ; branch when the unsigned value is at or below the limit
                    ldb       #$08      ; load the value needed by the following operation
Code_0AC3           stb       ,Y+       ; store the value and advance the destination pointer
                    pshs      B         ; preserve the listed registers on the stack
                    stu       ,Y++      ; store the value and advance the destination pointer
                    lda       Addr_0065 ; load the value needed by the following operation
                    suba      #$4F      ; subtract the operand from the running value
                    tst       Code_004A ; set condition flags from the current value
                    bne       Code_0AD3 ; branch when the compared values differ
                    adda      #$02      ; add the operand to the running value
Code_0AD3           sta       ,Y+       ; store the value and advance the destination pointer
                    beq       Code_0AEE ; branch when the compared values are equal
Code_0AD7           ldd       ,U        ; load the value needed by the following operation
                    std       ,Y++      ; store the value and advance the destination pointer
                    anda      ,X+       ; mask off unwanted bits
                    andb      ,X+       ; mask off unwanted bits
                    ora       ,X+       ; set the selected flag bits
                    orb       ,X+       ; set the selected flag bits
                    std       ,U        ; save the current value in working storage
                    leau      $50,U     ; form the referenced address without reading memory
                    dec       ,S        ; decrement the selected counter
                    bne       Code_0AD7 ; branch when the compared values differ
                    puls      PC,U,Y,X,D,CC ; restore the listed registers from the stack
Code_0AEE           lda       ,U        ; load the value needed by the following operation
                    sta       ,Y+       ; store the value and advance the destination pointer
                    anda      ,X++      ; mask off unwanted bits
                    ora       ,X++      ; set the selected flag bits
                    sta       ,U        ; save the current value in working storage
                    leau      $50,U     ; form the referenced address without reading memory
                    decb                ; decrement the selected counter
                    bne       Code_0AEE ; branch when the compared values differ
                    puls      PC,U,Y,X,D,CC ; restore the listed registers from the stack
Code_0B00           pshs      A         ; preserve the listed registers on the stack
                    tst       Addr_0072 ; set condition flags from the current value
                    bne       Code_0B0E ; branch when the compared values differ
                    lda       Addr_004F ; load the value needed by the following operation
                    sta       Code_0073 ; save the current value in working storage
                    beq       Code_0B0E ; branch when the compared values are equal
                    bsr       Code_0B21 ; call the referenced helper routine
Code_0B0E           inc       Addr_0072 ; advance the selected counter
                    puls      PC,A      ; restore the listed registers from the stack
Code_0B12           pshs      CC        ; preserve the listed registers on the stack
                    dec       Addr_0072 ; decrement the selected counter
                    bne       Code_0B1F ; branch when the compared values differ
                    tst       Code_0073 ; set condition flags from the current value
                    beq       Code_0B1F ; branch when the compared values are equal
                    lbsr      Code_0A89 ; call the referenced helper routine
Code_0B1F           puls      PC,CC     ; restore the listed registers from the stack
Code_0B21           tst       Code_004E ; set condition flags from the current value
                    beq       Code_0B2D ; branch when the compared values are equal
                    tst       Addr_004F ; set condition flags from the current value
                    beq       Code_0B2D ; branch when the compared values are equal
                    bsr       Code_0B2E ; call the referenced helper routine
                    clr       Addr_004F ; clear the selected byte or register
Code_0B2D           rts                 ; return to the caller
Code_0B2E           pshs      U,Y,D     ; preserve the listed registers on the stack
                    ldy       DeskMateService ; load the value needed by the following operation
                    leay      $0104,Y   ; form the referenced address without reading memory
                    ldb       ,Y+       ; fetch the next value and advance the source pointer
                    pshs      B         ; preserve the listed registers on the stack
                    ldu       ,Y++      ; fetch the next value and advance the source pointer
                    tst       ,Y+       ; set condition flags from the current value
                    beq       Code_0B4E ; branch when the compared values are equal
Code_0B41           ldd       ,Y++      ; fetch the next value and advance the source pointer
                    std       ,U        ; save the current value in working storage
                    leau      $50,U     ; form the referenced address without reading memory
                    dec       ,S        ; decrement the selected counter
                    bne       Code_0B41 ; branch when the compared values differ
                    puls      PC,U,Y,D,CC ; restore the listed registers from the stack
Code_0B4E           lda       ,Y+       ; fetch the next value and advance the source pointer
                    sta       ,U        ; save the current value in working storage
                    leau      $50,U     ; form the referenced address without reading memory
                    decb                ; decrement the selected counter
                    bne       Code_0B4E ; branch when the compared values differ
                    puls      PC,U,Y,D,CC ; restore the listed registers from the stack
                    fcb       $DC       ; table, bitmap, or initialized data bytes
                    fcc       "N9"                           ; embedded text or resource bytes
                    fcb       $17,$00,$BA,$0D,$9D ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $02,$DC   ; table, bitmap, or initialized data bytes
                    fcc       "["                            ; embedded text or resource bytes
                    fcb       $0F,$9D,$DD ; table, bitmap, or initialized data bytes
                    fcc       "["                            ; embedded text or resource bytes
                    fcb       $8D,$0A,$DC ; table, bitmap, or initialized data bytes
                    fcc       "["                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "N"                            ; embedded text or resource bytes
                    fcb       $26,$03,$CE,$FF,$FF ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $1F       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $D7       ; table, bitmap, or initialized data bytes
                    fcc       "^"                            ; embedded text or resource bytes
                    fcb       $1F,$10,$D7 ; table, bitmap, or initialized data bytes
                    fcc       "]"                            ; embedded text or resource bytes
                    fcb       $9E,$00   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $88       ; table, bitmap, or initialized data bytes
                    fcc       "a"                            ; embedded text or resource bytes
                    fcb       $D6       ; table, bitmap, or initialized data bytes
                    fcc       "^"                            ; embedded text or resource bytes
                    fcb       $17,$00   ; table, bitmap, or initialized data bytes
                    fcc       "x"                            ; embedded text or resource bytes
                    fcb       $D6       ; table, bitmap, or initialized data bytes
                    fcc       "]"                            ; embedded text or resource bytes
                    fcb       $17,$00   ; table, bitmap, or initialized data bytes
                    fcc       "s"                            ; embedded text or resource bytes
                    fcb       $DC       ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $DD       ; table, bitmap, or initialized data bytes
                    fcc       "]M'"                          ; embedded text or resource bytes
                    fcb       $12,$81   ; table, bitmap, or initialized data bytes
                    fcc       "?'"                           ; embedded text or resource bytes
                    fcb       $0E,$90   ; table, bitmap, or initialized data bytes
                    fcc       "g"                            ; embedded text or resource bytes
                    fcb       $81,$FB   ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $08,$81,$05 ; table, bitmap, or initialized data bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $04,$9B   ; table, bitmap, or initialized data bytes
                    fcc       "h "                           ; embedded text or resource bytes
                    fcb       $0B,$86   ; table, bitmap, or initialized data bytes
                    fcc       "B"                            ; embedded text or resource bytes
                    fcb       $D6       ; table, bitmap, or initialized data bytes
                    fcc       "]"                            ; embedded text or resource bytes
                    fcb       $D7       ; table, bitmap, or initialized data bytes
                    fcc       "g="                           ; embedded text or resource bytes
                    fcb       $9B       ; table, bitmap, or initialized data bytes
                    fcc       "]"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "h"                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $26,$06,$81 ; table, bitmap, or initialized data bytes
                    fcc       "N-"                           ; embedded text or resource bytes
                    fcb       $02,$86   ; table, bitmap, or initialized data bytes
                    fcc       "M"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "e"                            ; embedded text or resource bytes
                    fcb       $D6       ; table, bitmap, or initialized data bytes
                    fcc       "^"                            ; embedded text or resource bytes
                    fcb       $D7       ; table, bitmap, or initialized data bytes
                    fcc       "f4"                           ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "X"                            ; embedded text or resource bytes
                    fcb       $EB,$E0,$D1 ; table, bitmap, or initialized data bytes
                    fcc       "v%"                           ; embedded text or resource bytes
                    fcb       $02,$D0   ; table, bitmap, or initialized data bytes
                    fcc       "vTTT"                         ; embedded text or resource bytes
                    fcb       $D7       ; table, bitmap, or initialized data bytes
                    fcc       "l"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "k"                            ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       "N"                            ; embedded text or resource bytes
                    fcb       $9A       ; table, bitmap, or initialized data bytes
                    fcc       "O'"                           ; embedded text or resource bytes
                    fcb       $13,$DC   ; table, bitmap, or initialized data bytes
                    fcc       "e"                            ; embedded text or resource bytes
                    fcb       $10,$93   ; table, bitmap, or initialized data bytes
                    fcc       "i'"                           ; embedded text or resource bytes
                    fcb       $0C,$DD   ; table, bitmap, or initialized data bytes
                    fcc       "i"                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "O'"                           ; embedded text or resource bytes
                    fcb       $06,$17,$FF ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
                    fcb       $17,$FE,$9D,$86,$FF,$97 ; table, bitmap, or initialized data bytes
                    fcc       "M"                            ; embedded text or resource bytes
                    fcb       $DC       ; table, bitmap, or initialized data bytes
                    fcc       "k"                            ; embedded text or resource bytes
                    fcb       $1E,$89,$1F,$03 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $D6       ; table, bitmap, or initialized data bytes
                    fcc       "]"                            ; embedded text or resource bytes
                    fcb       $1F,$01,$D6 ; table, bitmap, or initialized data bytes
                    fcc       "^"                            ; embedded text or resource bytes
                    fcb       $1F,$02   ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $E1,$82   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $0A,$E1,$02 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $09,$A6,$84,$A7,$02,$E7 ; table, bitmap, or initialized data bytes
                    fcb       $84       ; table, bitmap, or initialized data bytes
                    fcc       "o"                            ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "9l"                           ; embedded text or resource bytes
                    fcb       $04,$A6,$04,$81,$05 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $EF       ; table, bitmap, or initialized data bytes
                    fcc       "94@2"                         ; embedded text or resource bytes
                    fcb       $E8,$E0,$1F ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $96,$7F,$C6,$89,$10,$8E ; table, bitmap, or initialized data bytes
                    fcb       $00,$01,$10 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $8D       ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $0D,$8E,$00 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $10,$8E,$00 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $CC,$00,$00,$16,$00,$91 ; table, bitmap, or initialized data bytes
                    fcc       "m"                            ; embedded text or resource bytes
                    fcb       $84       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $EF,$A6,$01,$84,$01,$81 ; table, bitmap, or initialized data bytes
                    fcb       $01,$26,$E7,$0D,$9D ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $06,$CC,$00,$00,$16,$00 ; table, bitmap, or initialized data bytes
                    fcc       "Q"                            ; embedded text or resource bytes
                    fcb       $A6,$05,$26,$02,$0F,$99 ; table, bitmap, or initialized data bytes
                    fcc       "m"                            ; embedded text or resource bytes
                    fcb       $08,$26   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $0F,$98   ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $A6,$0E   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $1B,$0D,$99,$26,$17,$81 ; table, bitmap, or initialized data bytes
                    fcc       "$%"                           ; embedded text or resource bytes
                    fcb       $08,$C6,$04,$86,$FF,$97 ; table, bitmap, or initialized data bytes
                    fcb       $99       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $0B,$C6,$01,$A6,$0C,$81 ; table, bitmap, or initialized data bytes
                    fcb       $1C       ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $F2,$03,$98 ; table, bitmap, or initialized data bytes
                    fcc       "_O "                          ; embedded text or resource bytes
                    fcb       $22       ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $0D,$99   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $06,$0D,$98,$26,$17,$0F ; table, bitmap, or initialized data bytes
                    fcb       $99,$0D,$98 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $08,$C6,$02,$86,$FF,$97 ; table, bitmap, or initialized data bytes
                    fcb       $99       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $09       ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $A6,$0C,$81 ; table, bitmap, or initialized data bytes
                    fcc       "$%"                           ; embedded text or resource bytes
                    fcb       $02,$C6,$03,$86,$80 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $06,$10,$AE,$88,$18 ; table, bitmap, or initialized data bytes
                    fcc       "m"                            ; embedded text or resource bytes
                    fcb       $88,$17,$26,$08,$CC,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$CE,$00,$0A,$8D,$1C ; table, bitmap, or initialized data bytes
                    fcc       "4 "                           ; embedded text or resource bytes
                    fcb       $10,$AE,$88,$1A ; table, bitmap, or initialized data bytes
                    fcc       "m"                            ; embedded text or resource bytes
                    fcb       $88,$17,$26,$08,$CC,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$CE,$00,$03,$8D,$09 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $06       ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $E8       ; table, bitmap, or initialized data bytes
                    fcc       " 5"                           ; embedded text or resource bytes
                    fcb       $C0       ; table, bitmap, or initialized data bytes
                    fcc       "4P"                           ; embedded text or resource bytes
                    fcb       $DF,$9A,$8E,$00,$10,$1E ; table, bitmap, or initialized data bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "XI"                           ; embedded text or resource bytes
                    fcb       $1E,$02   ; table, bitmap, or initialized data bytes
                    fcc       "YI%"                          ; embedded text or resource bytes
                    fcb       $05,$10,$93,$9A ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $04,$93,$9A ; table, bitmap, or initialized data bytes
                    fcc       "1!0"                          ; embedded text or resource bytes
                    fcb       $1F,$26,$E9 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $D0,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "F"                            ; embedded text or resource bytes
                    fcb       $26,$04,$8D,$0C,$03 ; table, bitmap, or initialized data bytes
                    fcc       "F9"                           ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "F'"                           ; embedded text or resource bytes
                    fcb       $04,$8D,$03,$0F ; table, bitmap, or initialized data bytes
                    fcc       "F94"                          ; embedded text or resource bytes
                    fcb       $16,$17,$FD,$F8,$17,$F6 ; table, bitmap, or initialized data bytes
                    fcc       "q"                            ; embedded text or resource bytes
                    fcb       $C6,$08   ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $04,$96   ; table, bitmap, or initialized data bytes
                    fcc       ">"                            ; embedded text or resource bytes
                    fcb       $80       ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "B'"                           ; embedded text or resource bytes
                    fcb       $0D,$C6,$C0 ; table, bitmap, or initialized data bytes
                    fcc       "M"                            ; embedded text or resource bytes
                    fcb       $26,$02,$C6,$F0,$E8,$84 ; table, bitmap, or initialized data bytes
Data_0D20           fcb       $E7,$84   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $07       ; table, bitmap, or initialized data bytes
                    fcc       "c"                            ; embedded text or resource bytes
                    fcb       $84       ; table, bitmap, or initialized data bytes
                    fcc       "M"                            ; embedded text or resource bytes
                    fcb       $26,$02   ; table, bitmap, or initialized data bytes
                    fcc       "c"                            ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $88       ; table, bitmap, or initialized data bytes
                    fcc       "Pj"                           ; embedded text or resource bytes
                    fcb       $E4,$26,$E1,$17,$FD,$DD ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "44"                           ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "V"                            ; embedded text or resource bytes
                    fcb       $96,$7F,$C6,$01,$10 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $8D       ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $0E,$9E,$00 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $88       ; table, bitmap, or initialized data bytes
                    fcc       "V"                            ; embedded text or resource bytes
                    fcb       $10,$8E,$00,$01,$96,$7F ; table, bitmap, or initialized data bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
Data_0D50           fcc       "?"                            ; embedded text or resource bytes
                    fcb       $89,$96   ; table, bitmap, or initialized data bytes
                    fcc       "V5"                           ; embedded text or resource bytes
                    fcb       $B4,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "H "                           ; embedded text or resource bytes
                    fcb       $04,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "H"                            ; embedded text or resource bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "H4t"                          ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "V]*"                          ; embedded text or resource bytes
                    fcb       $03,$17,$FD ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $E6,$E4   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $1E,$C5,$02 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $1A,$C5,$01 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $13,$0A   ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $26,$06,$86 ; table, bitmap, or initialized data bytes
                    fcc       "`"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "G"                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "G"                            ; embedded text or resource bytes
                    fcb       $26,$05,$17,$FF ; table, bitmap, or initialized data bytes
                    fcc       "u "                           ; embedded text or resource bytes
                    fcb       $03,$17,$FF ; table, bitmap, or initialized data bytes
                    fcc       "g"                            ; embedded text or resource bytes
                    fcb       $17,$FF,$AA,$97 ; table, bitmap, or initialized data bytes
                    fcc       "V"                            ; embedded text or resource bytes
                    fcb       $26,$0E,$0D ; table, bitmap, or initialized data bytes
                    fcc       "H'"                           ; embedded text or resource bytes
                    fcb       $14,$17,$FD,$C5 ; table, bitmap, or initialized data bytes
                    fcc       "]'"                           ; embedded text or resource bytes
                    fcb       $CD,$03,$9D,$96 ; table, bitmap, or initialized data bytes
                    fcc       "Vm"                           ; embedded text or resource bytes
                    fcb       $E4       ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $03,$17,$FD ; table, bitmap, or initialized data bytes
                    fcc       "{"                            ; embedded text or resource bytes
                    fcb       $17,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "QM5"                          ; embedded text or resource bytes
                    fcb       $F4,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "BM+"                          ; embedded text or resource bytes
                    fcb       $02,$03   ; table, bitmap, or initialized data bytes
                    fcc       "B94"                          ; embedded text or resource bytes
                    fcb       $16,$97,$97,$97,$92 ; table, bitmap, or initialized data bytes
                    fcc       "HHH"                          ; embedded text or resource bytes
                    fcb       $9E,$95   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $86,$9F,$93,$17,$01 ; table, bitmap, or initialized data bytes
                    fcc       "95"                           ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       "4v"                           ; embedded text or resource bytes
                    fcb       $D6,$97,$C1,$04 ; table, bitmap, or initialized data bytes
                    fcc       "'?\"                          ; embedded text or resource bytes
                    fcb       $D7,$97,$D7,$92 ; table, bitmap, or initialized data bytes
                    fcc       "XXX"                          ; embedded text or resource bytes
                    fcb       $10,$9E,$95 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $A5,$10,$9F,$93,$E6,$80 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $06,$D1   ; table, bitmap, or initialized data bytes
                    fcc       ">'"                           ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $08,$C6,$07,$17,$F4,$EA ; table, bitmap, or initialized data bytes
                    fcb       $10,$9E,$93,$8D ; table, bitmap, or initialized data bytes
                    fcc       "%O_"                          ; embedded text or resource bytes
                    fcb       $ED,$26,$EC,$A4,$1E,$89 ; table, bitmap, or initialized data bytes
                    fcc       "L\"                           ; embedded text or resource bytes
                    fcb       $17,$F7   ; table, bitmap, or initialized data bytes
                    fcc       "/"                            ; embedded text or resource bytes
                    fcb       $10,$9E,$00 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $A9,$02   ; table, bitmap, or initialized data bytes
                    fcc       "k"                            ; embedded text or resource bytes
                    fcb       $D6,$92   ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $A7,$A5,$97,$91 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $F6       ; table, bitmap, or initialized data bytes
                    fcc       "OXIXIXI94 "                   ; embedded text or resource bytes
                    fcb       $9E,$00   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $89,$02,$B4,$E6,$A4 ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "J."                           ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "X"                            ; embedded text or resource bytes
                    fcb       $8D,$E6,$83,$00,$01,$ED ; table, bitmap, or initialized data bytes
                    fcb       $01,$10   ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $00,$95,$10,$83,$02,$80 ; table, bitmap, or initialized data bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $00,$8D,$E6 ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $8D,$D1,$DB ; table, bitmap, or initialized data bytes
                    fcc       "v$"                           ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $C3,$00,$07,$ED,$03 ; table, bitmap, or initialized data bytes
                    fcc       "-}"                           ; embedded text or resource bytes
                    fcb       $10,$83,$00,$C0 ; table, bitmap, or initialized data bytes
                    fcc       ",w"                           ; embedded text or resource bytes
                    fcb       $E6,$A4,$EB,$22 ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "J."                           ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "X"                            ; embedded text or resource bytes
                    fcb       $8D,$B3,$ED,$05 ; table, bitmap, or initialized data bytes
                    fcc       "-g"                           ; embedded text or resource bytes
                    fcb       $10,$83,$02,$80 ; table, bitmap, or initialized data bytes
                    fcc       ",a"                           ; embedded text or resource bytes
                    fcb       $E6       ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $EB       ; table, bitmap, or initialized data bytes
                    fcc       "#"                            ; embedded text or resource bytes
                    fcb       $8D,$A3,$83,$00,$08,$DB ; table, bitmap, or initialized data bytes
                    fcc       "v$"                           ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $ED,$07   ; table, bitmap, or initialized data bytes
                    fcc       "-O"                           ; embedded text or resource bytes
                    fcb       $10,$83,$00,$C0 ; table, bitmap, or initialized data bytes
                    fcc       ",I"                           ; embedded text or resource bytes
                    fcb       $86,$08,$E6,$26 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "]'>"                          ; embedded text or resource bytes
                    fcb       $A6       ; table, bitmap, or initialized data bytes
                    fcc       "%T%"                          ; embedded text or resource bytes
                    fcb       $02,$A6   ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $A7,$84,$17,$F8 ; table, bitmap, or initialized data bytes
                    fcc       "I4"                           ; embedded text or resource bytes
                    fcb       $04,$EC,$01,$0D ; table, bitmap, or initialized data bytes
                    fcc       "J."                           ; embedded text or resource bytes
                    fcb       $03,$83,$00,$01,$83,$00 ; table, bitmap, or initialized data bytes
                    fcb       $01,$ED,$01,$EC,$03,$83 ; table, bitmap, or initialized data bytes
                    fcb       $00,$01,$ED,$03,$EC,$05 ; table, bitmap, or initialized data bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "J."                           ; embedded text or resource bytes
                    fcb       $03,$C3,$00,$01,$C3,$00 ; table, bitmap, or initialized data bytes
                    fcb       $01,$ED,$05,$EC,$07,$C3 ; table, bitmap, or initialized data bytes
                    fcb       $00,$01,$ED,$07 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $04       ; table, bitmap, or initialized data bytes
                    fcc       "j"                            ; embedded text or resource bytes
                    fcb       $E4,$26,$BF ; table, bitmap, or initialized data bytes
                    fcc       "2a"                           ; embedded text or resource bytes
                    fcb       $EC,$A4,$1E,$89 ; table, bitmap, or initialized data bytes
                    fcc       "L\HHH"                        ; embedded text or resource bytes
                    fcb       $9B       ; table, bitmap, or initialized data bytes
                    fcc       "v"                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "J."                           ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "X"                            ; embedded text or resource bytes
                    fcb       $1F,$01,$A6 ; table, bitmap, or initialized data bytes
                    fcc       "$4"                           ; embedded text or resource bytes
                    fcb       $02,$EC,$22,$83,$02,$02 ; table, bitmap, or initialized data bytes
                    fcb       $1E,$89   ; table, bitmap, or initialized data bytes
                    fcc       "HHH"                          ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "J."                           ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "X"                            ; embedded text or resource bytes
                    fcb       $1F,$02   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $02,$17,$F6,$9E ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $A0       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $16,$D6,$91,$CA ; table, bitmap, or initialized data bytes
                    fcc       "@ "                           ; embedded text or resource bytes
                    fcb       $06       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $16,$D6,$91,$C4,$BF,$D7 ; table, bitmap, or initialized data bytes
                    fcb       $91,$9E,$00 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $89,$02   ; table, bitmap, or initialized data bytes
                    fcc       "k"                            ; embedded text or resource bytes
                    fcb       $96,$92,$E7,$86 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       "4v"                           ; embedded text or resource bytes
                    fcb       $8D,$0E,$17,$F8 ; table, bitmap, or initialized data bytes
                    fcc       "h5"                           ; embedded text or resource bytes
                    fcb       $F6       ; table, bitmap, or initialized data bytes
                    fcc       "4v"                           ; embedded text or resource bytes
                    fcb       $8D,$05,$17,$F8,$98 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $F6,$10,$9E,$93 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $E6,$A4   ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $1F,$01,$E6 ; table, bitmap, or initialized data bytes
                    fcc       "!\"                           ; embedded text or resource bytes
                    fcb       $1F,$03,$EC,$22,$83,$02 ; table, bitmap, or initialized data bytes
                    fcb       $02,$1E,$89 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $06,$D6,$91,$86 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $1F,$02,$1E ; table, bitmap, or initialized data bytes
                    fcc       "#5"                           ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       "46"                           ; embedded text or resource bytes
                    fcb       $10,$9E,$93,$9E ; table, bitmap, or initialized data bytes
                    fcc       "@4"                           ; embedded text or resource bytes
                    fcb       $10,$E6,$26 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $04,$E6,$22,$C0,$02,$E0 ; table, bitmap, or initialized data bytes
                    fcb       $E4,$E7,$E4,$86 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $D6,$91,$17,$F4 ; table, bitmap, or initialized data bytes
                    fcc       "4j"                           ; embedded text or resource bytes
                    fcb       $E4       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $06       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $01,$9F   ; table, bitmap, or initialized data bytes
                    fcc       "@ "                           ; embedded text or resource bytes
                    fcb       $F3       ; table, bitmap, or initialized data bytes
                    fcc       "2a5"                          ; embedded text or resource bytes
                    fcb       $10,$9F   ; table, bitmap, or initialized data bytes
                    fcc       "@5"                           ; embedded text or resource bytes
                    fcb       $B6,$8E,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $84       ; table, bitmap, or initialized data bytes
                    fcc       "46"                           ; embedded text or resource bytes
                    fcb       $A6       ; table, bitmap, or initialized data bytes
                    fcc       "e"                            ; embedded text or resource bytes
                    fcb       $10,$9E,$93,$A7 ; table, bitmap, or initialized data bytes
                    fcc       "'L"                           ; embedded text or resource bytes
                    fcb       $AB       ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $E6       ; table, bitmap, or initialized data bytes
                    fcc       "c"                            ; embedded text or resource bytes
                    fcb       $E7,$26   ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $EB,$A4,$17,$F5,$A1 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $B6       ; table, bitmap, or initialized data bytes
                    fcc       "40"                           ; embedded text or resource bytes
                    fcb       $8D,$DF   ; table, bitmap, or initialized data bytes
                    fcc       "50"                           ; embedded text or resource bytes
                    fcb       $8D,$AD   ; table, bitmap, or initialized data bytes
                    fcc       "4v"                           ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       "@"                            ; embedded text or resource bytes
                    fcb       $10,$9E,$93,$E6,$A4 ; table, bitmap, or initialized data bytes
                    fcc       "L\HHH"                        ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "J."                           ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "X"                            ; embedded text or resource bytes
                    fcb       $1F,$01,$A6 ; table, bitmap, or initialized data bytes
                    fcc       "#"                            ; embedded text or resource bytes
                    fcb       $80,$03,$A0 ; table, bitmap, or initialized data bytes
                    fcc       "''"                           ; embedded text or resource bytes
                    fcb       $1B       ; table, bitmap, or initialized data bytes
                    fcc       "HHH"                          ; embedded text or resource bytes
                    fcb       $E6,$22,$C0,$02,$0D ; table, bitmap, or initialized data bytes
                    fcc       "J."                           ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "X"                            ; embedded text or resource bytes
                    fcb       $1F,$03,$A6 ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $0D,$91   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $02,$A6   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $1F       ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $17,$F5,$C2 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $F6       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $26,$97,$92 ; table, bitmap, or initialized data bytes
                    fcc       "HHH"                          ; embedded text or resource bytes
                    fcb       $10,$9E,$95 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $A6,$10,$9F,$93,$EC,$26 ; table, bitmap, or initialized data bytes
                    fcb       $1E,$89   ; table, bitmap, or initialized data bytes
                    fcc       "L\"                           ; embedded text or resource bytes
                    fcb       $AB       ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $EB,$A4,$17,$F5 ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $10,$9E,$00 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $A9,$02   ; table, bitmap, or initialized data bytes
                    fcc       "k"                            ; embedded text or resource bytes
                    fcb       $96,$92,$E6,$A6,$D7,$91 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $A6,$96,$92 ; table, bitmap, or initialized data bytes
                    fcc       "94@"                          ; embedded text or resource bytes
                    fcb       $17,$FB   ; table, bitmap, or initialized data bytes
                    fcc       "W4"                           ; embedded text or resource bytes
                    fcb       $06       ; table, bitmap, or initialized data bytes
                    fcc       "4@"                           ; embedded text or resource bytes
                    fcb       $10,$9E,$93,$1F ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "J."                           ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "T"                            ; embedded text or resource bytes
                    fcb       $E0,$A4   ; table, bitmap, or initialized data bytes
                    fcc       "/'Z"                          ; embedded text or resource bytes
                    fcb       $E7       ; table, bitmap, or initialized data bytes
                    fcc       "a"                            ; embedded text or resource bytes
                    fcb       $E6,$22,$C0,$03,$E1 ; table, bitmap, or initialized data bytes
                    fcc       "a-"                           ; embedded text or resource bytes
                    fcb       $1C,$A0   ; table, bitmap, or initialized data bytes
                    fcc       "!/"                           ; embedded text or resource bytes
                    fcb       $18       ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $A7,$E4,$A6 ; table, bitmap, or initialized data bytes
                    fcc       "#"                            ; embedded text or resource bytes
                    fcb       $80,$03,$A1,$E4 ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $E6       ; table, bitmap, or initialized data bytes
                    fcc       "a"                            ; embedded text or resource bytes
                    fcb       $1F,$01,$E6,$E4,$1F,$02 ; table, bitmap, or initialized data bytes
                    fcc       "2b5"                          ; embedded text or resource bytes
                    fcb       $C6,$8E,$00,$FF ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $84       ; table, bitmap, or initialized data bytes
                    fcc       "2b5"                          ; embedded text or resource bytes
                    fcb       $C6       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $12,$17,$FA,$B3,$A6,$80 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $04,$8D,$0B ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $F8,$17,$FA,$BA ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $92,$0F,$80 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $04,$0F,$80,$0C,$80 ; table, bitmap, or initialized data bytes
                    fcc       "4v"                           ; embedded text or resource bytes
                    fcb       $81,$0A   ; table, bitmap, or initialized data bytes
                    fcc       "'+"                           ; embedded text or resource bytes
                    fcb       $81,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "'+"                           ; embedded text or resource bytes
                    fcb       $D6,$91,$17,$F3 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $0D,$80   ; table, bitmap, or initialized data bytes
                    fcc       "' "                           ; embedded text or resource bytes
                    fcb       $10,$9E,$93,$E6,$22,$C0 ; table, bitmap, or initialized data bytes
                    fcb       $03,$E1,$26 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $11       ; table, bitmap, or initialized data bytes
                    fcc       "l"                            ; embedded text or resource bytes
                    fcb       $26,$EC,$26,$1E,$89 ; table, bitmap, or initialized data bytes
                    fcc       "L\"                           ; embedded text or resource bytes
                    fcb       $AB       ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $EB,$A4,$17,$F4,$A1 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $F6,$8D,$08,$8D,$17 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $F6,$8D,$02 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $F6,$10,$9E,$93 ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $E7,$26   ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $EB,$A4,$A6 ; table, bitmap, or initialized data bytes
                    fcc       "'L"                           ; embedded text or resource bytes
                    fcb       $AB       ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $16,$F4,$84,$10,$9E,$93 ; table, bitmap, or initialized data bytes
                    fcb       $E6       ; table, bitmap, or initialized data bytes
                    fcc       "#"                            ; embedded text or resource bytes
                    fcb       $C0,$03   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $16,$E1   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $FE       ; table, bitmap, or initialized data bytes
                    fcc       "X"                            ; embedded text or resource bytes
                    fcb       $EC,$26   ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $E7       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $1E,$89   ; table, bitmap, or initialized data bytes
                    fcc       "L\"                           ; embedded text or resource bytes
                    fcb       $AB       ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $EB,$A4,$16,$F4 ; table, bitmap, or initialized data bytes
                    fcc       "e"                            ; embedded text or resource bytes
                    fcb       $17,$FE,$A6,$16,$FE ; table, bitmap, or initialized data bytes
                    fcc       "u46"                          ; embedded text or resource bytes
                    fcb       $10,$9E,$93,$A6,$02 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $0C,$91   ; table, bitmap, or initialized data bytes
                    fcc       ">'"                           ; embedded text or resource bytes
                    fcb       $08,$EC,$03 ; table, bitmap, or initialized data bytes
                    fcc       "="                            ; embedded text or resource bytes
                    fcb       $C3,$00,$05 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8B,$EC,$A4 ; table, bitmap, or initialized data bytes
                    fcc       "L\"                           ; embedded text or resource bytes
                    fcb       $1E,$89   ; table, bitmap, or initialized data bytes
                    fcc       "HHH"                          ; embedded text or resource bytes
                    fcb       $AB,$01,$0D ; table, bitmap, or initialized data bytes
                    fcc       "J."                           ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "X"                            ; embedded text or resource bytes
                    fcb       $EB,$81,$17,$F4 ; table, bitmap, or initialized data bytes
                    fcc       "=5"                           ; embedded text or resource bytes
                    fcb       $B6       ; table, bitmap, or initialized data bytes
                    fcc       "4v"                           ; embedded text or resource bytes
                    fcb       $10,$9E,$93,$A6,$84 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $06,$91   ; table, bitmap, or initialized data bytes
                    fcc       ">'"                           ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $0A,$17,$F9,$F1 ; table, bitmap, or initialized data bytes
                    fcc       "4v"                           ; embedded text or resource bytes
                    fcb       $86,$08,$E6,$A4 ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
                    fcc       "J."                           ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "X="                           ; embedded text or resource bytes
                    fcb       $E3,$02,$ED,$E4,$E3,$06 ; table, bitmap, or initialized data bytes
                    fcb       $ED       ; table, bitmap, or initialized data bytes
                    fcc       "d"                            ; embedded text or resource bytes
                    fcb       $86,$08,$E6 ; table, bitmap, or initialized data bytes
                    fcc       "!\="                          ; embedded text or resource bytes
                    fcb       $E3,$04,$ED ; table, bitmap, or initialized data bytes
                    fcc       "b"                            ; embedded text or resource bytes
                    fcb       $E3,$08,$ED ; table, bitmap, or initialized data bytes
                    fcc       "f"                            ; embedded text or resource bytes
                    fcb       $E6,$01,$16,$F5,$BB ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $06,$9E,$93,$EC,$06 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $1F,$02   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $04,$1F,$01 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
Code_1148           lbsr      Code_0B00 ; call the referenced helper routine
Code_114B           lda       ,X+       ; fetch the next value and advance the source pointer
                    beq       Code_1153 ; branch when the compared values are equal
                    bsr       Code_1157 ; call the referenced helper routine
                    bra       Code_114B ; continue at the selected control-flow target
Code_1153           lbsr      Code_0B12 ; call the referenced helper routine
                    rts                 ; return to the caller
Code_1157           pshs      X,B       ; preserve the listed registers on the stack
                    lbsr      Code_0B00 ; call the referenced helper routine
                    tst       Code_004A ; set condition flags from the current value
                    bgt       Code_1168 ; branch when the signed value is above the limit
                    cmpa      #$1F      ; compare against the limit and set condition flags
                    bhi       Code_116D ; branch when the unsigned value is above the limit
                    cmpa      #$09      ; compare against the limit and set condition flags
                    bcs       Code_116D ; branch when carry reports an unsigned underflow or error
Code_1168           lbsr      Code_03D9 ; call the referenced helper routine
                    bra       Code_118F ; continue at the selected control-flow target
Code_116D           tst       Addr_00B3 ; set condition flags from the current value
                    bne       Code_1174 ; branch when the compared values differ
                    lbsr      Code_1353 ; call the referenced helper routine
Code_1174           clr       Addr_00AA ; clear the selected byte or register
                    bitb      #$40      ; test the selected flag bits without changing the value
                    beq       Code_117C ; branch when the compared values are equal
                    com       Addr_00AA ; invert every bit in the selected value
Code_117C           clr       Code_0054 ; clear the selected byte or register
                    bitb      #$80      ; test the selected flag bits without changing the value
                    beq       Code_1184 ; branch when the compared values are equal
                    com       Code_0054 ; invert every bit in the selected value
Code_1184           bsr       Code_1194 ; call the referenced helper routine
                    lda       Addr_00A7 ; load the value needed by the following operation
                    ldy       Addr_00AD ; load the value needed by the following operation
                    ldb       #$FF      ; load the value needed by the following operation
                    stb       Addr_00B3 ; save the current value in working storage
Code_118F           lbsr      Code_0B12 ; call the referenced helper routine
                    puls      PC,X,B    ; restore the listed registers from the stack
Code_1194           pshs      U,Y,X,D   ; preserve the listed registers on the stack
                    clr       Addr_00A1 ; clear the selected byte or register
                    clr       Addr_00A2 ; clear the selected byte or register
                    ldd       #Addr_FFFF ; load the value needed by the following operation
                    std       Code_00A3 ; save the current value in working storage
                    lda       #$0F      ; load the value needed by the following operation
                    sta       Addr_00A6 ; save the current value in working storage
                    lda       #$10      ; load the value needed by the following operation
                    sta       Code_00A5 ; save the current value in working storage
                    ldb       ,S        ; load the value needed by the following operation
                    beq       Code_11CC ; branch when the compared values are equal
                    cmpb      #$08      ; compare against the limit and set condition flags
                    bhi       Code_11CC ; branch when the unsigned value is above the limit
                    aslb                ; shift left and update carry
Code_11B0           pshs      B         ; preserve the listed registers on the stack
                    stb       Code_00A5 ; save the current value in working storage
                    ldd       #Addr_8000 ; load the value needed by the following operation
Code_11B7           dec       ,S        ; decrement the selected counter
                    beq       Code_11BF ; branch when the compared values are equal
                    asra                ; shift right while preserving the sign
                    rorb                ; rotate right through carry
                    bra       Code_11B7 ; continue at the selected control-flow target
Code_11BF           std       Code_00A3 ; save the current value in working storage
                    leas      $01,S     ; form the referenced address without reading memory
                    ldx       Code_003C ; load the value needed by the following operation
                    ldd       #Code_0200 ; load the value needed by the following operation
                    leax      D,X       ; form the referenced address without reading memory
                    bra       Code_1239 ; continue at the selected control-flow target
Code_11CC           ldx       Code_003C ; load the value needed by the following operation
                    lda       ,S        ; load the value needed by the following operation
                    tsta                ; set condition flags from the current value
                    bpl       Code_11D5 ; branch while the tested value is nonnegative
                    ldx       Code_003A ; load the value needed by the following operation
Code_11D5           anda      #$7F      ; mask off unwanted bits
                    ldb       #$10      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    leax      D,X       ; form the referenced address without reading memory
                    tfr       X,Y       ; copy the source register into the destination register
                    ldb       #$07      ; load the value needed by the following operation
                    pshs      B         ; preserve the listed registers on the stack
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
Code_11E4           ora       ,X+       ; set the selected flag bits
                    orb       ,X+       ; set the selected flag bits
                    dec       ,S        ; decrement the selected counter
                    bpl       Code_11E4 ; branch while the tested value is nonnegative
                    tfr       Y,X       ; copy the source register into the destination register
                    leas      $01,S     ; form the referenced address without reading memory
                    tsta                ; set condition flags from the current value
                    bne       Code_11FA ; branch when the compared values differ
                    tstb                ; set condition flags from the current value
                    bne       Code_11FA ; branch when the compared values differ
                    ldb       #$08      ; load the value needed by the following operation
                    bra       Code_11B0 ; continue at the selected control-flow target
Code_11FA           pshs      D         ; preserve the listed registers on the stack
                    lsra                ; shift right and expose the low bit through carry
                    rorb                ; rotate right through carry
                    lsra                ; shift right and expose the low bit through carry
                    rorb                ; rotate right through carry
                    lsra                ; shift right and expose the low bit through carry
                    rorb                ; rotate right through carry
                    lsra                ; shift right and expose the low bit through carry
                    rorb                ; rotate right through carry
                    ora       ,S        ; set the selected flag bits
                    orb       $01,S     ; set the selected flag bits
                    pshs      CC        ; preserve the listed registers on the stack
                    rolb                ; rotate left through carry
                    rola                ; rotate left through carry
                    puls      CC        ; restore the listed registers from the stack
                    rolb                ; rotate left through carry
                    rola                ; rotate left through carry
                    std       ,S        ; save the current value in working storage
Code_1212           aslb                ; shift left and update carry
                    rola                ; rotate left through carry
                    bcs       Code_1220 ; branch when carry reports an unsigned underflow or error
                    dec       Addr_00A6 ; decrement the selected counter
                    dec       Code_00A5 ; decrement the selected counter
                    lsr       Code_00A3 ; shift right and expose the low bit through carry
                    ror       Addr_00A4 ; rotate right through carry
                    bra       Code_1212 ; continue at the selected control-flow target
Code_1220           ldy       Code_00A3 ; load the value needed by the following operation
                    puls      D         ; restore the listed registers from the stack
Code_1225           lsra                ; shift right and expose the low bit through carry
                    rorb                ; rotate right through carry
                    bcs       Code_1231 ; branch when carry reports an unsigned underflow or error
                    dec       Code_00A5 ; decrement the selected counter
                    asl       Addr_00A4 ; shift left and update carry
                    rol       Code_00A3 ; rotate left through carry
                    bra       Code_1225 ; continue at the selected control-flow target
Code_1231           tfr       Y,D       ; copy the source register into the destination register
                    anda      Code_00A3 ; mask off unwanted bits
                    andb      Addr_00A4 ; mask off unwanted bits
                    std       Code_00A3 ; save the current value in working storage
Code_1239           lda       Addr_00A7 ; load the value needed by the following operation
                    suba      Addr_00A6 ; subtract the operand from the running value
                    bmi       Code_124E ; branch while the tested value is negative
                    ldy       #Code_00B0 ; load the value needed by the following operation
                    sty       >Addr_1281,PCR ; save the current value in working storage
                    ldy       #Addr_0086 ; load the value needed by the following operation
                    bra       Code_125D ; continue at the selected control-flow target
Code_124E           adda      #$10      ; add the operand to the running value
                    ldy       #Addr_00C4 ; load the value needed by the following operation
                    sty       >Addr_1281,PCR ; save the current value in working storage
                    ldy       #Code_009A ; load the value needed by the following operation
Code_125D           sta       Addr_00A8 ; save the current value in working storage
                    sty       >Addr_12AB,PCR ; save the current value in working storage
                    ldu       Addr_00AD ; load the value needed by the following operation
                    lda       Addr_00A7 ; load the value needed by the following operation
                    suba      Code_00A5 ; subtract the operand from the running value
                    bcc       Code_1274 ; branch when carry is clear
                    leau      $02,U     ; form the referenced address without reading memory
                    stu       Addr_00AD ; save the current value in working storage
                    leau      -$02,U    ; form the referenced address without reading memory
                    anda      #$0F      ; mask off unwanted bits
Code_1274           sta       Addr_00A7 ; save the current value in working storage
                    pshs      X         ; preserve the listed registers on the stack
                    lda       Addr_00A8 ; load the value needed by the following operation
                    ldx       DeskMateService ; load the value needed by the following operation
                    leax      $00A1,X   ; form the referenced address without reading memory
                    lbsr      Code_1333 ; call the referenced helper routine
                    puls      X         ; restore the listed registers from the stack
                    ldy       Code_007D ; load the value needed by the following operation
                    ldb       #$08      ; load the value needed by the following operation
                    stb       Code_00A9 ; save the current value in working storage
Code_128C           ldd       ,X++      ; fetch the next value and advance the source pointer
                    pshs      X         ; preserve the listed registers on the stack
                    ldx       DeskMateService ; load the value needed by the following operation
                    leax      $00AF,X   ; form the referenced address without reading memory
                    clr       ,X        ; clear the selected byte or register
                    clr       $01,X     ; clear the selected byte or register
                    std       $02,X     ; save the current value in working storage
                    tst       Code_0054 ; set condition flags from the current value
                    beq       Code_12A6 ; branch when the compared values are equal
                    anda      ,Y+       ; mask off unwanted bits
                    andb      ,Y+       ; mask off unwanted bits
                    std       $02,X     ; save the current value in working storage
Code_12A6           pshs      Y         ; preserve the listed registers on the stack
                    lda       Addr_00A8 ; load the value needed by the following operation
                    lbsr      Code_1333 ; call the referenced helper routine
                    ldb       #$04      ; load the value needed by the following operation
                    ldy       DeskMateService ; load the value needed by the following operation
                    leay      $00A1,Y   ; form the referenced address without reading memory
Code_12B6           lda       ,Y+       ; fetch the next value and advance the source pointer
                    anda      Addr_00AA ; mask off unwanted bits
                    eora      ,X        ; toggle the selected bits
                    sta       ,X+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bne       Code_12B6 ; branch when the compared values differ
                    tst       Code_00AC ; set condition flags from the current value
                    bne       Code_12DC ; branch when the compared values differ
                    ldx       DeskMateService ; load the value needed by the following operation
                    leax      $00A1,X   ; form the referenced address without reading memory
                    tfr       U,Y       ; copy the source register into the destination register
                    ldb       #$04      ; load the value needed by the following operation
Code_12CF           com       ,X        ; invert every bit in the selected value
                    lda       ,Y        ; load the value needed by the following operation
                    anda      ,X        ; mask off unwanted bits
                    sta       ,Y+       ; store the value and advance the destination pointer
                    com       ,X+       ; invert every bit in the selected value
                    decb                ; decrement the selected counter
                    bne       Code_12CF ; branch when the compared values differ
Code_12DC           tst       Addr_00AA ; set condition flags from the current value
                    beq       Code_1311 ; branch when the compared values are equal
                    tst       Code_00AC ; set condition flags from the current value
                    beq       Code_1311 ; branch when the compared values are equal
                    ldy       DeskMateService ; load the value needed by the following operation
                    leax      $00AF,Y   ; form the referenced address without reading memory
                    leay      $00A1,Y   ; form the referenced address without reading memory
                    ldb       #$04      ; load the value needed by the following operation
Code_12F1           lda       ,Y+       ; fetch the next value and advance the source pointer
                    eora      ,X        ; toggle the selected bits
                    sta       ,X+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bne       Code_12F1 ; branch when the compared values differ
                    tfr       U,Y       ; copy the source register into the destination register
                    ldx       DeskMateService ; load the value needed by the following operation
                    leax      $00AF,X   ; form the referenced address without reading memory
                    ldb       #$04      ; load the value needed by the following operation
Code_1304           lda       ,Y        ; load the value needed by the following operation
                    ora       ,X        ; set the selected flag bits
                    eora      ,X+       ; toggle the selected bits
                    sta       ,Y+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bne       Code_1304 ; branch when the compared values differ
                    bra       Code_1324 ; continue at the selected control-flow target
Code_1311           ldx       DeskMateService ; load the value needed by the following operation
                    leax      $00AF,X   ; form the referenced address without reading memory
                    tfr       U,Y       ; copy the source register into the destination register
                    ldb       #$04      ; load the value needed by the following operation
Code_131B           lda       ,X+       ; fetch the next value and advance the source pointer
                    ora       ,Y        ; set the selected flag bits
                    sta       ,Y+       ; store the value and advance the destination pointer
                    decb                ; decrement the selected counter
                    bne       Code_131B ; branch when the compared values differ
Code_1324           leau      $50,U     ; form the referenced address without reading memory
                    puls      Y         ; restore the listed registers from the stack
                    puls      X         ; restore the listed registers from the stack
                    dec       Code_00A9 ; decrement the selected counter
                    lbne      Code_128C ; take the distant branch when values differ
                    puls      PC,U,Y,X,D ; restore the listed registers from the stack
Code_1333           deca                ; decrement the selected counter
                    bmi       Code_133C ; branch while the tested value is negative
                    asl       $03,X     ; shift left and update carry
                    rol       $02,X     ; rotate left through carry
                    bra       Code_1333 ; continue at the selected control-flow target
Code_133C           ldd       ,X        ; load the value needed by the following operation
                    ldy       $02,X     ; load the value needed by the following operation
                    std       $02,X     ; save the current value in working storage
                    sty       ,X        ; save the current value in working storage
                    rts                 ; return to the caller
                    fcc       "h"                            ; embedded text or resource bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "i"                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "i"                            ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "i"                            ; embedded text or resource bytes
                    fcb       $84       ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $26,$F5   ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
Code_1353           pshs      D         ; preserve the listed registers on the stack
                    lda       Code_0040 ; load the value needed by the following operation
                    asla                ; shift left and update carry
                    asla                ; shift left and update carry
                    asla                ; shift left and update carry
                    adda      Code_0076 ; add the operand to the running value
                    ldb       #$50      ; load the value needed by the following operation
                    mul                 ; multiply the two eight-bit accumulators
                    pshs      D         ; preserve the listed registers on the stack
                    clra                ; clear the selected byte or register
                    ldb       Addr_0041 ; load the value needed by the following operation
                    aslb                ; shift left and update carry
                    addd      ,S++      ; add the operand to the running value
                    addd      Code_0079 ; add the operand to the running value
                    std       Addr_00AD ; save the current value in working storage
                    lda       #$0F      ; load the value needed by the following operation
                    sta       Addr_00A7 ; save the current value in working storage
                    puls      PC,D      ; restore the listed registers from the stack
                    fcb       $0F,$AC   ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $0F,$AC,$03,$AC ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "K"                            ; embedded text or resource bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "K9"                           ; embedded text or resource bytes
                    fcb       $0F       ; table, bitmap, or initialized data bytes
                    fcc       "K9"                           ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       "K"                            ; embedded text or resource bytes
                    fcb       $D6,$AC   ; table, bitmap, or initialized data bytes
                    fcc       "9_4V"                         ; embedded text or resource bytes
                    fcb       $97,$86   ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $DD,$80,$DD,$82,$DE,$00 ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $C9,$01,$18,$E6 ; table, bitmap, or initialized data bytes
                    fcc       "A\"                           ; embedded text or resource bytes
                    fcb       $D7,$84,$0F,$85,$AE ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $EE,$A4,$C6 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $17,$00,$C9,$10 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $00,$BD,$E6 ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $C1       ; table, bitmap, or initialized data bytes
                    fcc       ":'"                           ; embedded text or resource bytes
                    fcb       $12       ; table, bitmap, or initialized data bytes
                    fcc       "4@"                           ; embedded text or resource bytes
                    fcb       $DE,$00   ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $C9,$01,$18,$A6,$C4 ; table, bitmap, or initialized data bytes
                    fcc       "5@+2"                         ; embedded text or resource bytes
                    fcb       $03,$85   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $02,$80   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $81,$04,$10,$22,$00,$9B ; table, bitmap, or initialized data bytes
                    fcb       $C6       ; table, bitmap, or initialized data bytes
                    fcc       ")="                           ; embedded text or resource bytes
                    fcb       $DE,$00   ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $C9,$01,$18 ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $C8,$26   ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $CB,$17,$00,$94,$26,$13 ; table, bitmap, or initialized data bytes
                    fcb       $EE,$A4,$0D,$85,$26,$02 ; table, bitmap, or initialized data bytes
                    fcc       "3B"                           ; embedded text or resource bytes
                    fcb       $C6,$A0,$0F,$80,$17,$00 ; table, bitmap, or initialized data bytes
                    fcb       $83       ; table, bitmap, or initialized data bytes
                    fcc       "'y "                          ; embedded text or resource bytes
                    fcb       $1B,$A6,$C0 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $05,$17,$00,$83 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $F7,$0F,$80,$EE,$A4,$0D ; table, bitmap, or initialized data bytes
                    fcb       $85,$26,$02 ; table, bitmap, or initialized data bytes
                    fcc       "3B"                           ; embedded text or resource bytes
                    fcb       $8D       ; table, bitmap, or initialized data bytes
                    fcc       "j'd"                          ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       "/ B"                          ; embedded text or resource bytes
                    fcb       $C6,$82,$A6,$C0 ; table, bitmap, or initialized data bytes
                    fcc       "'@"                           ; embedded text or resource bytes
                    fcb       $0D,$81   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $1A,$81   ; table, bitmap, or initialized data bytes
                    fcc       " '4"                          ; embedded text or resource bytes
                    fcb       $81       ; table, bitmap, or initialized data bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $26,$0A,$97,$82,$C6,$10 ; table, bitmap, or initialized data bytes
                    fcb       $EA       ; table, bitmap, or initialized data bytes
                    fcc       "a"                            ; embedded text or resource bytes
                    fcb       $E7       ; table, bitmap, or initialized data bytes
                    fcc       "a "                           ; embedded text or resource bytes
                    fcb       $16,$81   ; table, bitmap, or initialized data bytes
                    fcc       "0%<"                          ; embedded text or resource bytes
                    fcb       $81       ; table, bitmap, or initialized data bytes
                    fcc       "9#"                           ; embedded text or resource bytes
                    fcb       $0E,$97,$81,$8A ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $81       ; table, bitmap, or initialized data bytes
                    fcc       "a%0"                          ; embedded text or resource bytes
                    fcb       $81       ; table, bitmap, or initialized data bytes
                    fcc       "z"                            ; embedded text or resource bytes
                    fcb       $22       ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $A6       ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $0A,$84,$D6,$84,$DA,$83 ; table, bitmap, or initialized data bytes
                    fcb       $DA,$82,$26,$06,$C6,$01 ; table, bitmap, or initialized data bytes
                    fcb       $EA       ; table, bitmap, or initialized data bytes
                    fcc       "a"                            ; embedded text or resource bytes
                    fcb       $E7       ; table, bitmap, or initialized data bytes
                    fcc       "a"                            ; embedded text or resource bytes
                    fcb       $8D       ; table, bitmap, or initialized data bytes
                    fcc       "+ "                           ; embedded text or resource bytes
                    fcb       $BA,$03,$83 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $16,$0D,$82,$26,$12,$0F ; table, bitmap, or initialized data bytes
                    fcb       $80,$EE,$22,$8D,$10 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $0A,$86   ; table, bitmap, or initialized data bytes
                    fcc       ". "                           ; embedded text or resource bytes
                    fcb       $E8,$C6,$84,$EA ; table, bitmap, or initialized data bytes
                    fcc       "a"                            ; embedded text or resource bytes
                    fcb       $E7       ; table, bitmap, or initialized data bytes
                    fcc       "ao"                           ; embedded text or resource bytes
                    fcb       $84       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $D6,$A6,$C0 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $06,$81   ; table, bitmap, or initialized data bytes
                    fcc       " '"                           ; embedded text or resource bytes
                    fcb       $F8       ; table, bitmap, or initialized data bytes
                    fcc       "3_9"                          ; embedded text or resource bytes
                    fcb       $81       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $26,$03,$97,$80 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $0D,$80   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $06       ; table, bitmap, or initialized data bytes
                    fcc       "2b"                           ; embedded text or resource bytes
                    fcb       $C6,$82   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $DC,$0D,$86,$26,$07,$C6 ; table, bitmap, or initialized data bytes
                    fcb       $88,$EA   ; table, bitmap, or initialized data bytes
                    fcc       "c"                            ; embedded text or resource bytes
                    fcb       $E7       ; table, bitmap, or initialized data bytes
                    fcc       "c9"                           ; embedded text or resource bytes
                    fcb       $0A,$86,$A7,$80 ; table, bitmap, or initialized data bytes
                    fcc       "94v"                          ; embedded text or resource bytes
                    fcb       $D7,$81,$0A,$81 ; table, bitmap, or initialized data bytes
                    fcc       "'2"                           ; embedded text or resource bytes
                    fcb       $EE       ; table, bitmap, or initialized data bytes
                    fcc       "f"                            ; embedded text or resource bytes
                    fcb       $0F,$80,$D6,$81,$AE,$C4 ; table, bitmap, or initialized data bytes
                    fcb       $10,$AE   ; table, bitmap, or initialized data bytes
                    fcc       "B"                            ; embedded text or resource bytes
                    fcb       $A6,$A0,$8D ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $97,$82,$A6,$80 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $14,$8D,$1D,$91,$82 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $F0       ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $0C,$AE,$C4,$10,$AE ; table, bitmap, or initialized data bytes
                    fcc       "B"                            ; embedded text or resource bytes
                    fcb       $10,$AF,$C4,$AF ; table, bitmap, or initialized data bytes
                    fcc       "B"                            ; embedded text or resource bytes
                    fcb       $0C,$80   ; table, bitmap, or initialized data bytes
                    fcc       "3BZ"                          ; embedded text or resource bytes
                    fcb       $26,$D8,$0D,$80,$26,$CA ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $F6,$81   ; table, bitmap, or initialized data bytes
                    fcc       "A%"                           ; embedded text or resource bytes
                    fcb       $06,$81   ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $22,$02,$8A ; table, bitmap, or initialized data bytes
                    fcc       " 9"                           ; embedded text or resource bytes
                    fcb       $17,$F6,$1B ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $E8,$E0,$10,$DF,$80 ; table, bitmap, or initialized data bytes
                    fcc       "O4r"                          ; embedded text or resource bytes
                    fcb       $DF,$82   ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $CB,$83,$00,$02,$DD,$84 ; table, bitmap, or initialized data bytes
                    fcb       $A6,$A0,$81 ; table, bitmap, or initialized data bytes
                    fcc       " '"                           ; embedded text or resource bytes
                    fcb       $FA       ; table, bitmap, or initialized data bytes
                    fcc       "1?"                           ; embedded text or resource bytes
                    fcb       $10,$9F,$86 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $10,$9E,$00 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $89,$01,$18,$A6,$01,$97 ; table, bitmap, or initialized data bytes
                    fcb       $90       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $10,$A6,$84,$80 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $81,$04,$22,$0B,$C6 ; table, bitmap, or initialized data bytes
                    fcc       ")="                           ; embedded text or resource bytes
                    fcb       $9E,$00   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $89,$01   ; table, bitmap, or initialized data bytes
                    fcc       ">0"                           ; embedded text or resource bytes
                    fcb       $8B,$86,$89,$10 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $84       ; table, bitmap, or initialized data bytes
                    fcc       "%J"                           ; embedded text or resource bytes
                    fcb       $97,$89,$9E,$80,$10,$8E ; table, bitmap, or initialized data bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $96,$89,$10 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $89       ; table, bitmap, or initialized data bytes
                    fcc       "%."                           ; embedded text or resource bytes
                    fcb       $8D       ; table, bitmap, or initialized data bytes
                    fcc       "G"                            ; embedded text or resource bytes
                    fcb       $26,$EF,$D6,$88 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $EB       ; table, bitmap, or initialized data bytes
                    fcc       ":"                            ; embedded text or resource bytes
                    fcb       $10,$9E,$82 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $CB,$04   ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $06,$DC,$84,$A3,$E1 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $DC,$DD,$84 ; table, bitmap, or initialized data bytes
                    fcc       "o"                            ; embedded text or resource bytes
                    fcb       $C2,$A6,$82,$A7,$C2,$0A ; table, bitmap, or initialized data bytes
                    fcb       $88,$26,$F8,$EF,$A1 ; table, bitmap, or initialized data bytes
                    fcc       "o"                            ; embedded text or resource bytes
                    fcb       $C2,$10,$9F,$82 ; table, bitmap, or initialized data bytes
                    fcc       "l"                            ; embedded text or resource bytes
                    fcb       $E4       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $C5       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $04,$96,$89,$10 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $8F       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $04,$C1,$D3 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $0B,$1A,$01 ; table, bitmap, or initialized data bytes
                    fcc       "5r2"                          ; embedded text or resource bytes
                    fcb       $E8       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $17,$F5,$94 ; table, bitmap, or initialized data bytes
                    fcc       "9O "                          ; embedded text or resource bytes
                    fcb       $F4       ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $10,$9E,$86 ; table, bitmap, or initialized data bytes
                    fcc       "m"                            ; embedded text or resource bytes
                    fcb       $A4       ; table, bitmap, or initialized data bytes
                    fcc       "'7"                           ; embedded text or resource bytes
                    fcb       $A6,$85   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $0B       ; table, bitmap, or initialized data bytes
                    fcc       "+"                            ; embedded text or resource bytes
                    fcb       $09,$81   ; table, bitmap, or initialized data bytes
                    fcc       ".'"                           ; embedded text or resource bytes
                    fcb       $08       ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $D1,$90   ; table, bitmap, or initialized data bytes
                    fcc       "#"                            ; embedded text or resource bytes
                    fcb       $F1,$1C,$FB ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $D7,$88   ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $A6,$A4,$26,$08 ; table, bitmap, or initialized data bytes
                    fcc       "Zm"                           ; embedded text or resource bytes
                    fcb       $85       ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $F1,$1A,$04 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $81       ; table, bitmap, or initialized data bytes
                    fcc       " '"                           ; embedded text or resource bytes
                    fcb       $F4,$A6,$85,$84 ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $A1,$A4   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $06,$8A   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $A1,$A4,$26,$DC ; table, bitmap, or initialized data bytes
                    fcc       "1! "                          ; embedded text or resource bytes
                    fcb       $DD,$A6,$85 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $D4       ; table, bitmap, or initialized data bytes
                    fcc       "+"                            ; embedded text or resource bytes
                    fcb       $07       ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $D1,$90   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $F5       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $CB,$84,$7F,$A7,$85 ; table, bitmap, or initialized data bytes
                    fcc       "\@"                           ; embedded text or resource bytes
                    fcb       $A7,$85   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $C4       ; table, bitmap, or initialized data bytes
Code_15D8           pshs      U,Y,X,A   ; preserve the listed registers on the stack
                    leax      Data_1C3B,PCR ; form the referenced address without reading memory
                    lda       #$01      ; load the value needed by the following operation
                    os9       I$Open    ; request the named OS-9 service
                    bcs       Code_1604 ; branch when carry reports an unsigned underflow or error
                    ldx       DeskMateService ; load the value needed by the following operation
                    leax      $0118,X   ; form the referenced address without reading memory
                    ldy       #Addr_0113 ; load the value needed by the following operation
                    os9       I$Read    ; request the named OS-9 service
                    pshs      B,CC      ; preserve the listed registers on the stack
                    ldb       #$08      ; load the value needed by the following operation
Code_15F6           leax      $0113,X   ; form the referenced address without reading memory
                    clr       ,X+       ; clear the selected byte or register
                    decb                ; decrement the selected counter
                    bne       Code_15F6 ; branch when the compared values differ
                    os9       I$Close   ; request the named OS-9 service
                    puls      B,CC      ; restore the listed registers from the stack
Code_1604           puls      PC,U,Y,X,A ; restore the listed registers from the stack
Code_1606           pshs      U,Y,X,D   ; preserve the listed registers on the stack
                    leax      Data_1C3B,PCR ; form the referenced address without reading memory
                    lda       #$02      ; load the value needed by the following operation
                    os9       I$Open    ; request the named OS-9 service
                    bcc       Code_161E ; branch when carry is clear
                    cmpb      #$D8      ; compare against the limit and set condition flags
                    bne       Code_1635 ; branch when the compared values differ
                    ldb       #$1B      ; load the value needed by the following operation
                    os9       I$Create  ; request the named OS-9 service
                    bcs       Code_1635 ; branch when carry reports an unsigned underflow or error
Code_161E           ldx       DeskMateService ; load the value needed by the following operation
                    leax      $0118,X   ; form the referenced address without reading memory
                    ldy       #Addr_0113 ; load the value needed by the following operation
                    os9       I$Write   ; request the named OS-9 service
                    bcs       Code_1632 ; branch when carry reports an unsigned underflow or error
                    os9       I$Close   ; request the named OS-9 service
                    bcc       Code_1638 ; branch when carry is clear
Code_1632           os9       I$Close   ; request the named OS-9 service
Code_1635           stb       $01,S     ; save the current value in working storage
                    comb                ; invert every bit in the selected value
Code_1638           puls      PC,U,Y,X,D ; restore the listed registers from the stack
                    fcb       $9E,$00   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $89,$01,$18 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $89,$01,$03 ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $A6       ; table, bitmap, or initialized data bytes
                    fcc       "b_"                           ; embedded text or resource bytes
                    fcb       $D3       ; table, bitmap, or initialized data bytes
                    fcc       "Y"                            ; embedded text or resource bytes
                    fcb       $1F,$02,$DC ; table, bitmap, or initialized data bytes
                    fcc       "Yo"                           ; embedded text or resource bytes
                    fcb       $7F       ; table, bitmap, or initialized data bytes
                    fcc       "94t"                          ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       "q"                            ; embedded text or resource bytes
                    fcb       $81,$04   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $04,$86,$FF ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $F4,$0C   ; table, bitmap, or initialized data bytes
                    fcc       "q"                            ; embedded text or resource bytes
                    fcb       $C6,$11   ; table, bitmap, or initialized data bytes
                    fcc       "="                            ; embedded text or resource bytes
                    fcb       $DE,$00   ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $C9,$02   ; table, bitmap, or initialized data bytes
                    fcc       "p3"                           ; embedded text or resource bytes
                    fcb       $CB,$AF,$C1,$DC ; table, bitmap, or initialized data bytes
                    fcc       "N"                            ; embedded text or resource bytes
                    fcb       $ED,$C1,$96 ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $A7,$C0,$DC ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $93,$02,$ED,$C1,$DC ; table, bitmap, or initialized data bytes
                    fcc       ":"                            ; embedded text or resource bytes
                    fcb       $93,$02,$ED,$C1,$96 ; table, bitmap, or initialized data bytes
                    fcc       "I"                            ; embedded text or resource bytes
                    fcb       $D6       ; table, bitmap, or initialized data bytes
                    fcc       "B"                            ; embedded text or resource bytes
                    fcb       $ED,$C1,$96 ; table, bitmap, or initialized data bytes
                    fcc       "v"                            ; embedded text or resource bytes
                    fcb       $D6       ; table, bitmap, or initialized data bytes
                    fcc       "p"                            ; embedded text or resource bytes
                    fcb       $ED,$C1,$96,$AC,$D6 ; table, bitmap, or initialized data bytes
                    fcc       "K"                            ; embedded text or resource bytes
                    fcb       $ED,$C1,$DC ; table, bitmap, or initialized data bytes
                    fcc       "}"                            ; embedded text or resource bytes
                    fcb       $93,$02,$ED,$C1 ; table, bitmap, or initialized data bytes
                    fcc       "O5"                           ; embedded text or resource bytes
                    fcb       $F4       ; table, bitmap, or initialized data bytes
                    fcc       "4t"                           ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       "qJ*"                          ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $F4,$97   ; table, bitmap, or initialized data bytes
                    fcc       "q"                            ; embedded text or resource bytes
                    fcb       $C6,$11   ; table, bitmap, or initialized data bytes
                    fcc       "="                            ; embedded text or resource bytes
                    fcb       $DE,$00   ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $C9,$02   ; table, bitmap, or initialized data bytes
                    fcc       "p3"                           ; embedded text or resource bytes
                    fcb       $CB,$EC,$C1 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "T"                            ; embedded text or resource bytes
                    fcb       $A6,$C0   ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $0A       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $05,$17,$F3 ; table, bitmap, or initialized data bytes
                    fcc       "l "                           ; embedded text or resource bytes
                    fcb       $03,$17,$F3 ; table, bitmap, or initialized data bytes
                    fcc       "wT"                           ; embedded text or resource bytes
                    fcb       $A6,$C0   ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $0A       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $05,$17,$F3,$BB ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $03,$17,$F4 ; table, bitmap, or initialized data bytes
                    fcc       "N"                            ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       "(m"                           ; embedded text or resource bytes
                    fcb       $C0       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $06       ; table, bitmap, or initialized data bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "D "                           ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "HT$"                          ; embedded text or resource bytes
                    fcb       $09,$9E,$00 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $89,$01,$18,$A6,$88 ; table, bitmap, or initialized data bytes
                    fcc       "#4"                           ; embedded text or resource bytes
                    fcb       $06,$DC,$02,$AE,$C1 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8B,$9F   ; table, bitmap, or initialized data bytes
                    fcc       "<"                            ; embedded text or resource bytes
                    fcb       $AE,$C1   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8B,$9F   ; table, bitmap, or initialized data bytes
                    fcc       ":"                            ; embedded text or resource bytes
                    fcb       $AE       ; table, bitmap, or initialized data bytes
                    fcc       "F0"                           ; embedded text or resource bytes
                    fcb       $8B,$9F   ; table, bitmap, or initialized data bytes
                    fcc       "}5"                           ; embedded text or resource bytes
                    fcb       $06,$17,$F2,$12 ; table, bitmap, or initialized data bytes
                    fcc       "T"                            ; embedded text or resource bytes
                    fcb       $A6,$C0   ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $0A       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $05,$17,$EC,$A6 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $03,$17,$EC,$AA ; table, bitmap, or initialized data bytes
                    fcc       "T"                            ; embedded text or resource bytes
                    fcb       $A6,$C0   ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $02,$97   ; table, bitmap, or initialized data bytes
                    fcc       "BT"                           ; embedded text or resource bytes
                    fcb       $A6,$C0   ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $02,$97   ; table, bitmap, or initialized data bytes
                    fcc       "v"                            ; embedded text or resource bytes
                    fcb       $E6,$E0   ; table, bitmap, or initialized data bytes
                    fcc       "T"                            ; embedded text or resource bytes
                    fcb       $A6,$C0   ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $02,$97   ; table, bitmap, or initialized data bytes
                    fcc       "pT"                           ; embedded text or resource bytes
                    fcb       $A6,$C0   ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $02,$97,$AC ; table, bitmap, or initialized data bytes
                    fcc       "T"                            ; embedded text or resource bytes
                    fcb       $A6,$C0   ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $02,$97   ; table, bitmap, or initialized data bytes
                    fcc       "KO5"                          ; embedded text or resource bytes
                    fcb       $F4,$86,$01,$97 ; table, bitmap, or initialized data bytes
                    fcc       "E"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "D"                            ; embedded text or resource bytes
Code_1743           ldu       DeskMateService ; load the value needed by the following operation
                    lbsr      Code_0011 ; call the referenced helper routine
                    pshs      PC        ; preserve the listed registers on the stack
                    ldu       Addr_0002 ; load the value needed by the following operation
                    os9       F$UnLink  ; request the named OS-9 service
                    lbcs      Code_1ABD ; take the distant branch when carry reports an error
                    leas      $02,S     ; form the referenced address without reading memory
                    ldu       DeskMateService ; load the value needed by the following operation
                    leau      $0300,U   ; form the referenced address without reading memory
                    leas      $00FE,U   ; form the referenced address without reading memory
                    ldd       Addr_0057 ; load the value needed by the following operation
                    os9       F$Mem     ; request the named OS-9 service
                    lbra      Code_0240 ; continue at the distant control-flow target
                    fcc       "4v"                           ; embedded text or resource bytes
                    fcb       $EC       ; table, bitmap, or initialized data bytes
                    fcc       "k"                            ; embedded text or resource bytes
                    fcb       $93,$02,$ED ; table, bitmap, or initialized data bytes
                    fcc       "k"                            ; embedded text or resource bytes
                    fcb       $86,$02,$97 ; table, bitmap, or initialized data bytes
                    fcc       "E"                            ; embedded text or resource bytes
                    fcb       $DE,$00   ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $C9,$02,$B4,$A6,$80,$A7 ; table, bitmap, or initialized data bytes
                    fcb       $A0,$81,$0D,$26,$F8 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $80,$DE,$02,$10 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $02,$10   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "12b"                          ; embedded text or resource bytes
                    fcb       $9E,$00   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $89,$02,$B4,$86,$11,$10 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $01,$10   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $00,$12,$DF,$02 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$EB   ; table, bitmap, or initialized data bytes
                    fcc       "?1!"                          ; embedded text or resource bytes
                    fcb       $AF,$A1,$9E,$00 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $89,$02,$B4,$1F ; table, bitmap, or initialized data bytes
                    fcc       "%2{"                          ; embedded text or resource bytes
                    fcb       $16,$00   ; table, bitmap, or initialized data bytes
                    fcc       "{"                            ; embedded text or resource bytes
Code_17B6           lda       Addr_0045 ; load the value needed by the following operation
                    cmpa      #$01      ; compare against the limit and set condition flags
                    beq       Addr_181A ; branch when the compared values are equal
                    bgt       Code_1824 ; branch when the signed value is above the limit
Code_17BE           lbsr      Code_1606 ; call the referenced helper routine
                    ldu       Addr_0002 ; load the value needed by the following operation
                    os9       F$UnLink  ; request the named OS-9 service
Code_17C6           lda       Addr_007F ; load the value needed by the following operation
                    leax      Data_1C67,PCR ; form the referenced address without reading memory
                    ldy       #Addr_0002 ; load the value needed by the following operation
                    os9       I$Write   ; request the named OS-9 service
                    lda       Addr_007F ; load the value needed by the following operation
                    ldb       #$8C      ; load the value needed by the following operation
                    ldy       #DeskMateService ; load the value needed by the following operation
                    os9       I$SetStt  ; request the named OS-9 service
                    lda       Addr_007F ; load the value needed by the following operation
                    ldb       #$8D      ; load the value needed by the following operation
                    ldy       Code_0077 ; load the value needed by the following operation
                    os9       I$SetStt  ; request the named OS-9 service
                    ldx       DeskMateService ; load the value needed by the following operation
                    leax      $00E4,X   ; form the referenced address without reading memory
                    lda       Addr_007F ; load the value needed by the following operation
                    ldb       #$00      ; load the value needed by the following operation
                    os9       I$SetStt  ; request the named OS-9 service
                    tst       Code_009C ; set condition flags from the current value
                    beq       Code_1810 ; branch when the compared values are equal
                    ldx       DeskMateService ; load the value needed by the following operation
                    leas      $0100,X   ; form the referenced address without reading memory
                    ldb       #$01      ; load the value needed by the following operation
                    leax      >Code_1814,PCR ; form the referenced address without reading memory
                    ldy       #DeskMateService ; load the value needed by the following operation
                    leau      $05,X     ; form the referenced address without reading memory
                    lda       #$11      ; load the value needed by the following operation
                    os9       F$Chain   ; request the named OS-9 service
Code_1810           clrb                ; clear the selected byte or register
                    os9       F$Exit    ; request the named OS-9 service
Code_1814           comb                ; invert every bit in the selected value
                    asla                ; shift left and update carry
                    fcb       $45       ; table, bitmap, or initialized data bytes
                    inca                ; advance the selected counter
                    inca                ; advance the selected counter
                    tst       Addr_004F ; set condition flags from the current value
                    sta       Addr_0045 ; save the current value in working storage
                    leax      Data_1C47,PCR ; form the referenced address without reading memory
                    lbra      Code_1743 ; continue at the distant control-flow target
Code_1824           pshs      PC        ; preserve the listed registers on the stack
                    ldu       Addr_0002 ; load the value needed by the following operation
                    os9       F$UnLink  ; request the named OS-9 service
                    lbcs      Code_1ABD ; take the distant branch when carry reports an error
                    leas      $02,S     ; form the referenced address without reading memory
                    dec       Addr_0045 ; decrement the selected counter
                    ldx       Addr_0004 ; load the value needed by the following operation
                    leay      Data_1C47,PCR ; form the referenced address without reading memory
                    clrb                ; clear the selected byte or register
Code_183A           lda       B,X       ; load the value needed by the following operation
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    beq       Code_1849 ; branch when the compared values are equal
                    anda      #$DF      ; mask off unwanted bits
                    cmpa      B,Y       ; compare against the limit and set condition flags
                    bne       Code_184B ; branch when the compared values differ
                    incb                ; advance the selected counter
                    bra       Code_183A ; continue at the selected control-flow target
Code_1849           clr       Addr_0045 ; clear the selected byte or register
Code_184B           lda       Addr_0045 ; load the value needed by the following operation
                    anda      Code_0044 ; mask off unwanted bits
                    sta       Addr_0045 ; save the current value in working storage
                    pshs      PC        ; preserve the listed registers on the stack
                    lda       #$11      ; load the value needed by the following operation
                    os9       F$Load    ; request the named OS-9 service
                    lbcs      Code_1AC7 ; take the distant branch when carry reports an error
                    leas      $07,S     ; form the referenced address without reading memory
                    stu       Addr_0002 ; save the current value in working storage
                    tfr       U,D       ; copy the source register into the destination register
                    addd      $0C,S     ; add the operand to the running value
                    std       $0C,S     ; save the current value in working storage
                    leax      Data_02E4,PCR ; form the referenced address without reading memory
                    leay      $01,Y     ; form the referenced address without reading memory
                    stx       ,Y++      ; store the value and advance the destination pointer
                    puls      PC,U,Y,X,D,CC ; restore the listed registers from the stack
                    fcb       $1F,$B8   ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $9E,$04,$10,$9E,$06,$DC ; table, bitmap, or initialized data bytes
                    fcb       $08       ; table, bitmap, or initialized data bytes
                    fcc       "94p2"                         ; embedded text or resource bytes
                    fcb       $E8,$9C,$DE,$00 ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $C9,$01,$18 ; table, bitmap, or initialized data bytes
                    fcc       "o"                            ; embedded text or resource bytes
                    fcb       $C8,$1B,$0F ; table, bitmap, or initialized data bytes
                    fcc       "o0"                           ; embedded text or resource bytes
                    fcb       $C9,$01,$04,$EC,$84,$81 ; table, bitmap, or initialized data bytes
                    fcc       "/'3"                          ; embedded text or resource bytes
                    fcb       $03       ; table, bitmap, or initialized data bytes
                    fcc       "o"                            ; embedded text or resource bytes
                    fcb       $C1       ; table, bitmap, or initialized data bytes
                    fcc       ":'"                           ; embedded text or resource bytes
                    fcb       $18,$80   ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $81,$02   ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $12,$C6,$08 ; table, bitmap, or initialized data bytes
                    fcc       ":"                            ; embedded text or resource bytes
                    fcb       $A6,$82,$A7,$02 ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $26,$F9,$A6,$C4,$8B ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C6       ; table, bitmap, or initialized data bytes
                    fcc       ":"                            ; embedded text or resource bytes
                    fcb       $ED,$84   ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $E4,$AF,$A4 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C9,$01,$0F,$AF,$22 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $26,$AF   ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $17,$FA,$C0,$AE ; table, bitmap, or initialized data bytes
                    fcc       "$4"                           ; embedded text or resource bytes
                    fcb       $10,$10   ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $87       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $10,$86,$02,$10 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $84       ; table, bitmap, or initialized data bytes
                    fcc       "%3"                           ; embedded text or resource bytes
                    fcb       $97,$80   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $C9,$01,$04,$EC,$84,$C4 ; table, bitmap, or initialized data bytes
                    fcb       $DF,$10,$83 ; table, bitmap, or initialized data bytes
                    fcc       "/P"                           ; embedded text or resource bytes
                    fcb       $26       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $A6,$02,$84,$DF,$26,$1A ; table, bitmap, or initialized data bytes
                    fcc       "o"                            ; embedded text or resource bytes
                    fcb       $C8,$1B   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $E4,$96,$80 ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $8D       ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $C9,$01,$03,$E6,$A4,$E7 ; table, bitmap, or initialized data bytes
                    fcb       $88,$15   ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $8E       ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $17       ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $96,$80   ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $01,$C1,$D8,$26,$0C ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $01,$AE   ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $CC,$02   ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $83       ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $E8       ; table, bitmap, or initialized data bytes
                    fcc       "d5"                           ; embedded text or resource bytes
                    fcb       $F0,$10   ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $8F       ; table, bitmap, or initialized data bytes
                    fcc       "94"                           ; embedded text or resource bytes
                    fcb       $16       ; table, bitmap, or initialized data bytes
                    fcc       "1!1?'"                        ; embedded text or resource bytes
                    fcb       $15,$A6,$80 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $11,$8D,$12 ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $F4,$E7   ; table, bitmap, or initialized data bytes
                    fcc       "aS4"                          ; embedded text or resource bytes
                    fcb       $01,$1F,$10,$A3 ; table, bitmap, or initialized data bytes
                    fcc       "c"                            ; embedded text or resource bytes
                    fcb       $1F,$02   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "_ "                           ; embedded text or resource bytes
                    fcb       $F3       ; table, bitmap, or initialized data bytes
                    fcc       "4v"                           ; embedded text or resource bytes
                    fcb       $0F,$88,$97,$8C,$D7,$87 ; table, bitmap, or initialized data bytes
                    fcb       $DE,$00   ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $C9,$01,$18 ; table, bitmap, or initialized data bytes
                    fcc       "m"                            ; embedded text or resource bytes
                    fcb       $C8,$1A   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $1D,$17,$01 ; table, bitmap, or initialized data bytes
                    fcc       "?o"                           ; embedded text or resource bytes
                    fcb       $C8,$1A,$0D ; table, bitmap, or initialized data bytes
                    fcc       "o"                            ; embedded text or resource bytes
                    fcb       $26,$05   ; table, bitmap, or initialized data bytes
                    fcc       "m"                            ; embedded text or resource bytes
                    fcb       $C8       ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $26,$0E   ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $E1,$C8   ; table, bitmap, or initialized data bytes
                    fcc       " '"                           ; embedded text or resource bytes
                    fcb       $08       ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $86,$0A,$17,$00,$AA ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $F3,$96,$8C,$81,$1F,$22 ; table, bitmap, or initialized data bytes
                    fcb       $18,$81,$0D,$26,$06,$03 ; table, bitmap, or initialized data bytes
                    fcb       $88,$0F,$8C ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $19,$81,$0A ; table, bitmap, or initialized data bytes
                    fcc       "'."                           ; embedded text or resource bytes
                    fcb       $81,$0C,$10,$26,$01,$05 ; table, bitmap, or initialized data bytes
                    fcb       $0F,$8C   ; table, bitmap, or initialized data bytes
                    fcc       " /lL"                         ; embedded text or resource bytes
                    fcb       $E6       ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $E1,$C8,$1C,$10 ; table, bitmap, or initialized data bytes
                    fcc       "#"                            ; embedded text or resource bytes
                    fcb       $00,$F6,$E6 ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $EB,$C8,$1F,$E1,$C8,$22 ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $04,$86,$0D,$8D ; table, bitmap, or initialized data bytes
                    fcc       "qoL"                          ; embedded text or resource bytes
                    fcb       $0D,$8C   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "lL"                           ; embedded text or resource bytes
                    fcb       $17,$00,$E8 ; table, bitmap, or initialized data bytes
                    fcc       "lM"                           ; embedded text or resource bytes
                    fcb       $E6       ; table, bitmap, or initialized data bytes
                    fcc       "M"                            ; embedded text or resource bytes
                    fcb       $E1,$C8,$1D,$10 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $00,$D2,$0D ; table, bitmap, or initialized data bytes
                    fcc       "o"                            ; embedded text or resource bytes
                    fcb       $26,$05   ; table, bitmap, or initialized data bytes
                    fcc       "m"                            ; embedded text or resource bytes
                    fcb       $C8       ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $26       ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $E6       ; table, bitmap, or initialized data bytes
                    fcc       "M"                            ; embedded text or resource bytes
                    fcb       $EB,$C8   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $E1,$C8,$1E ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $08,$86,$0A,$8D ; table, bitmap, or initialized data bytes
                    fcc       "DlM "                         ; embedded text or resource bytes
                    fcb       $EE       ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $E1,$C8   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $00,$AD,$86,$0A,$8D ; table, bitmap, or initialized data bytes
                    fcc       "4\ "                          ; embedded text or resource bytes
                    fcb       $F2,$E6,$C8,$11 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $1F,$01,$E6,$C8,$12,$1F ; table, bitmap, or initialized data bytes
                    fcb       $02,$17,$F5 ; table, bitmap, or initialized data bytes
                    fcc       "~"                            ; embedded text or resource bytes
                    fcb       $A6       ; table, bitmap, or initialized data bytes
                    fcc       "N"                            ; embedded text or resource bytes
                    fcb       $26,$04,$AE ; table, bitmap, or initialized data bytes
                    fcc       "O'"                           ; embedded text or resource bytes
                    fcb       $06,$E6,$C8,$19,$17,$EA ; table, bitmap, or initialized data bytes
                    fcc       "7"                            ; embedded text or resource bytes
                    fcb       $17,$F3   ; table, bitmap, or initialized data bytes
                    fcc       "N"                            ; embedded text or resource bytes
                    fcb       $81,$05,$26 ; table, bitmap, or initialized data bytes
                    fcc       ")"                            ; embedded text or resource bytes
                    fcb       $C6,$02   ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $8D,$1D,$96,$8C,$26,$05 ; table, bitmap, or initialized data bytes
                    fcb       $0D,$88   ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $97,$88,$96,$87,$9E,$00 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $89,$00,$88,$10,$8E,$00 ; table, bitmap, or initialized data bytes
                    fcb       $01,$10   ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $8A       ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "92b"                          ; embedded text or resource bytes
                    fcb       $E7       ; table, bitmap, or initialized data bytes
                    fcc       "aS5"                          ; embedded text or resource bytes
                    fcb       $F6,$97,$89 ; table, bitmap, or initialized data bytes
                    fcc       "4@"                           ; embedded text or resource bytes
                    fcb       $17,$F1,$1D ; table, bitmap, or initialized data bytes
                    fcc       "5@"                           ; embedded text or resource bytes
                    fcb       $D7,$8A,$AE,$C8,$13 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $1E,$A6,$80 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $BC       ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $14,$81,$80,$26,$04,$0D ; table, bitmap, or initialized data bytes
                    fcb       $8A,$26,$10,$81,$85,$22 ; table, bitmap, or initialized data bytes
                    fcb       $08,$84,$80,$91,$8A ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $06       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $E6,$91,$89,$26,$E2,$AE ; table, bitmap, or initialized data bytes
                    fcb       $C8,$15,$26,$18,$A6,$C8 ; table, bitmap, or initialized data bytes
                    fcb       $18       ; table, bitmap, or initialized data bytes
                    fcc       "' "                           ; embedded text or resource bytes
                    fcb       $E6,$C8,$17 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $1B,$D7,$8B,$E6,$C8,$19 ; table, bitmap, or initialized data bytes
                    fcb       $17,$E9   ; table, bitmap, or initialized data bytes
                    fcc       "["                            ; embedded text or resource bytes
                    fcb       $0A,$8B,$26,$F9 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $0D,$EC,$C8,$11,$17,$EA ; table, bitmap, or initialized data bytes
                    fcb       $A6       ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $E6,$C8,$19,$17,$E9,$AF ; table, bitmap, or initialized data bytes
                    fcb       $8D,$08   ; table, bitmap, or initialized data bytes
                    fcc       "oM"                           ; embedded text or resource bytes
                    fcb       $17,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "}O5"                          ; embedded text or resource bytes
                    fcb       $F6,$86,$0D,$17,$FF ; table, bitmap, or initialized data bytes
                    fcc       "~_"                           ; embedded text or resource bytes
                    fcb       $E1,$C8,$1F ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $08       ; table, bitmap, or initialized data bytes
                    fcc       "\"                            ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $17,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "r "                           ; embedded text or resource bytes
                    fcb       $F3       ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $17,$F2,$A4,$81,$05,$26 ; table, bitmap, or initialized data bytes
                    fcb       $05,$C6,$02,$16,$FF ; table, bitmap, or initialized data bytes
                    fcc       "w99"                          ; embedded text or resource bytes
Code_1ABD           pshs      U,Y,X,D   ; preserve the listed registers on the stack
                    ldu       DeskMateService ; load the value needed by the following operation
                    lda       #$FF      ; load the value needed by the following operation
                    sta       Addr_0055 ; save the current value in working storage
                    bra       Code_1ACD ; continue at the selected control-flow target
Code_1AC7           pshs      U,Y,X,D   ; preserve the listed registers on the stack
                    ldu       DeskMateService ; load the value needed by the following operation
                    clr       Addr_0055 ; clear the selected byte or register
Code_1ACD           lbsr      Code_1B40 ; call the referenced helper routine
                    leax      Data_1CBE,PCR ; form the referenced address without reading memory
Code_1AD4           leax      $03,X     ; form the referenced address without reading memory
                    cmpb      ,X        ; compare against the limit and set condition flags
                    bhi       Code_1AD4 ; branch when the unsigned value is above the limit
                    ldd       $01,X     ; load the value needed by the following operation
                    leay      Data_1CF7,PCR ; form the referenced address without reading memory
                    leax      D,Y       ; form the referenced address without reading memory
                    lda       ,X+       ; fetch the next value and advance the source pointer
                    pshs      A         ; preserve the listed registers on the stack
                    ldy       ,X++      ; fetch the next value and advance the source pointer
                    lda       #$02      ; load the value needed by the following operation
                    tst       Addr_0055 ; set condition flags from the current value
                    bne       Code_1AF4 ; branch when the compared values differ
                    os9       I$Write   ; request the named OS-9 service
                    bra       Code_1AF9 ; continue at the selected control-flow target
Code_1AF4           clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    lbsr      Code_0440 ; call the referenced helper routine
Code_1AF9           leax      Data_1D6D,PCR ; form the referenced address without reading memory
                    ldy       #Code_0033 ; load the value needed by the following operation
                    tst       ,S+       ; set condition flags from the current value
                    beq       Code_1B13 ; branch when the compared values are equal
                    leax      Code_17BE,PCR ; form the referenced address without reading memory
                    stx       ,S        ; save the current value in working storage
                    leax      Data_1DA0,PCR ; form the referenced address without reading memory
                    ldy       #Code_001A ; load the value needed by the following operation
Code_1B13           lda       #$02      ; load the value needed by the following operation
                    tst       Addr_0055 ; set condition flags from the current value
                    bne       Code_1B1E ; branch when the compared values differ
                    os9       I$Write   ; request the named OS-9 service
                    bra       Code_1B23 ; continue at the selected control-flow target
Code_1B1E           clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    lbsr      Code_0440 ; call the referenced helper routine
Code_1B23           leax      $43,U     ; form the referenced address without reading memory
                    ldy       #Addr_0001 ; load the value needed by the following operation
                    lda       #$00      ; load the value needed by the following operation
                    os9       I$Read    ; request the named OS-9 service
                    bcs       Code_1B23 ; branch when carry reports an unsigned underflow or error
Code_1B31           lda       ,X        ; load the value needed by the following operation
                    cmpa      #$05      ; compare against the limit and set condition flags
                    puls      U,Y,X,D   ; restore the listed registers from the stack
                    lbeq      Code_17BE ; take the distant branch when values are equal
                    lbsr      Code_1B40 ; call the referenced helper routine
                    jmp       [,S]      ; dispatch control through the selected target
Code_1B40           pshs      U,Y,X,D   ; preserve the listed registers on the stack
                    ldu       DeskMateService ; load the value needed by the following operation
                    tst       Addr_0055 ; set condition flags from the current value
                    bne       Code_1B5A ; branch when the compared values differ
                    lda       #$0C      ; load the value needed by the following operation
                    leax      $43,U     ; form the referenced address without reading memory
                    sta       ,X        ; save the current value in working storage
                    ldy       #Addr_0001 ; load the value needed by the following operation
                    lda       #$02      ; load the value needed by the following operation
                    os9       I$Write   ; request the named OS-9 service
                    puls      PC,U,Y,X,D ; restore the listed registers from the stack
Code_1B5A           clrb                ; clear the selected byte or register
                    lda       #$0C      ; load the value needed by the following operation
                    lbsr      Code_03D9 ; call the referenced helper routine
                    puls      PC,U,Y,X,D ; restore the listed registers from the stack
Code_1B62           pshs      X         ; preserve the listed registers on the stack
                    ldy       #Addr_FFFF ; load the value needed by the following operation
Code_1B68           lda       ,X+       ; fetch the next value and advance the source pointer
                    leay      $01,Y     ; form the referenced address without reading memory
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    bne       Code_1B68 ; branch when the compared values differ
                    lda       #$02      ; load the value needed by the following operation
                    puls      X         ; restore the listed registers from the stack
                    os9       I$Write   ; request the named OS-9 service
                    leax      Data_1DBA,PCR ; form the referenced address without reading memory
                    ldy       #Addr_000C ; load the value needed by the following operation
                    lda       #$02      ; load the value needed by the following operation
                    os9       I$Write   ; request the named OS-9 service
                    lbra      Code_17C6 ; continue at the distant control-flow target
                    fcb       $E9       ; table, bitmap, or initialized data bytes
                    fcc       "]"                            ; embedded text or resource bytes
                    fcb       $E8,$0F,$E8 ; table, bitmap, or initialized data bytes
                    fcc       "R"                            ; embedded text or resource bytes
                    fcb       $E9       ; table, bitmap, or initialized data bytes
                    fcc       "6"                            ; embedded text or resource bytes
                    fcb       $E9       ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $E9       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $E9       ; table, bitmap, or initialized data bytes
                    fcc       "C"                            ; embedded text or resource bytes
                    fcb       $E9       ; table, bitmap, or initialized data bytes
                    fcc       "="                            ; embedded text or resource bytes
                    fcb       $E9       ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $ED,$91,$E8,$B9,$E9,$A9 ; table, bitmap, or initialized data bytes
                    fcb       $E9,$AE,$E9,$B1,$EA,$0C ; table, bitmap, or initialized data bytes
                    fcb       $EE       ; table, bitmap, or initialized data bytes
                    fcc       "l"                            ; embedded text or resource bytes
                    fcb       $EE       ; table, bitmap, or initialized data bytes
                    fcc       "u"                            ; embedded text or resource bytes
                    fcb       $EB,$0A,$EB,$B8,$EB ; table, bitmap, or initialized data bytes
                    fcc       "W"                            ; embedded text or resource bytes
                    fcb       $EE,$A4,$EE,$B4,$EF,$02 ; table, bitmap, or initialized data bytes
                    fcb       $EF,$9A,$EF,$D3,$EF,$D6 ; table, bitmap, or initialized data bytes
                    fcb       $F1       ; table, bitmap, or initialized data bytes
                    fcc       "j"                            ; embedded text or resource bytes
                    fcb       $F1       ; table, bitmap, or initialized data bytes
                    fcc       "s"                            ; embedded text or resource bytes
                    fcb       $F1,$D3,$F1,$CF,$F2 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $E9       ; table, bitmap, or initialized data bytes
                    fcc       "G"                            ; embedded text or resource bytes
                    fcb       $E9       ; table, bitmap, or initialized data bytes
                    fcc       "M"                            ; embedded text or resource bytes
                    fcb       $E9       ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $E8,$F2,$EA ; table, bitmap, or initialized data bytes
                    fcc       "`"                            ; embedded text or resource bytes
                    fcb       $EA       ; table, bitmap, or initialized data bytes
                    fcc       "k"                            ; embedded text or resource bytes
                    fcb       $EA,$8B,$EB,$FB,$EC ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $EE       ; table, bitmap, or initialized data bytes
                    fcc       "x"                            ; embedded text or resource bytes
                    fcb       $EE,$87,$EE,$95,$EE,$A1 ; table, bitmap, or initialized data bytes
                    fcb       $FA,$BE,$E8 ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
                    fcb       $E8       ; table, bitmap, or initialized data bytes
                    fcc       "/"                            ; embedded text or resource bytes
                    fcb       $FC,$E9,$F7,$FA,$F7,$EA ; table, bitmap, or initialized data bytes
                    fcb       $F7,$ED,$F7,$F2,$F7,$F7 ; table, bitmap, or initialized data bytes
                    fcb       $F5,$D0,$F5,$C1,$F2 ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $F2       ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $F3       ; table, bitmap, or initialized data bytes
                    fcc       "p"                            ; embedded text or resource bytes
                    fcb       $F3       ; table, bitmap, or initialized data bytes
                    fcc       "x"                            ; embedded text or resource bytes
                    fcb       $F3,$8C,$F3,$95,$F4 ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $F4       ; table, bitmap, or initialized data bytes
                    fcc       "w"                            ; embedded text or resource bytes
                    fcb       $F4,$0A,$F4,$10,$F3,$BF ; table, bitmap, or initialized data bytes
                    fcb       $F4,$D7,$F4,$D3,$F3,$F2 ; table, bitmap, or initialized data bytes
                    fcb       $F4       ; table, bitmap, or initialized data bytes
                    fcc       "z"                            ; embedded text or resource bytes
                    fcb       $F4,$C1,$F5 ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $F5       ; table, bitmap, or initialized data bytes
                    fcc       "v"                            ; embedded text or resource bytes
                    fcb       $F5,$B0,$F7,$FF,$F9,$14 ; table, bitmap, or initialized data bytes
                    fcb       $F9       ; table, bitmap, or initialized data bytes
                    fcc       "["                            ; embedded text or resource bytes
                    fcb       $FA,$7F,$FA,$B3,$FA,$CA ; table, bitmap, or initialized data bytes
                    fcb       $FB,$14,$FC,$F4,$FD,$9B ; table, bitmap, or initialized data bytes
                    fcb       $FD,$9F,$FD,$BF,$FB,$B6 ; table, bitmap, or initialized data bytes
                    fcb       $FB,$E0,$FC ; table, bitmap, or initialized data bytes
                    fcc       "/"                            ; embedded text or resource bytes
                    fcb       $FC,$EC,$FF ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
Data_1C3B           fcc       "CONFIG.DESK"                  ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
Data_1C47           fcc       "DMMENU"                       ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
Data_1C4E           fcc       "/D0/CMDS"                     ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_1C57           fcb       $00,$1B,$09,$22 ; table, bitmap, or initialized data bytes
                    fcc       "'(6"                          ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       ",8"                           ; embedded text or resource bytes
                    fcb       $1D,$0C,$12,$1A,$07 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
Data_1C67           fcb       $1B       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
Data_1C69           fcc       "/TERM"                        ; embedded text or resource bytes
                    fcb       $0D       ; table, bitmap, or initialized data bytes
Data_1C6F           fcb       $00,$06,$00 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "8Press [ENTER] to con"        ; embedded text or resource bytes
                    fcc       "tinue"                        ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "Press [BREAK] to canc"        ; embedded text or resource bytes
                    fcc       "el"                           ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "Press any key to cont"        ; embedded text or resource bytes
                    fcc       "in"                           ; embedded text or resource bytes
Data_1CBE           fcc       "ue"                           ; embedded text or resource bytes
                    fcb       $00,$C5,$00,$00,$C7,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$CA,$00 ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $CC,$00   ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $CD,$00   ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $CF,$00   ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $D2,$00,$00,$D3,$00 ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $D5,$00,$00,$DA,$00 ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $E3,$00,$00,$E6,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $E8,$00   ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $E9,$00,$00,$EC,$00 ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $ED,$00   ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $EF,$00,$00,$FF,$00 ; table, bitmap, or initialized data bytes
                    fcc       "Y"                            ; embedded text or resource bytes
Data_1CF7           fcb       $00,$00   ; table, bitmap, or initialized data bytes
                    fcc       "/"                            ; embedded text or resource bytes
                    fcb       $0D,$0A   ; table, bitmap, or initialized data bytes
                    fcc       "DeskMate Error"               ; embedded text or resource bytes
                    fcb       $0D,$0A   ; table, bitmap, or initialized data bytes
                    fcc       "If retries fail, try "        ; embedded text or resource bytes
                    fcc       "reboot"                       ; embedded text or resource bytes
                    fcb       $0D,$0A,$00,$00,$15,$0D ; table, bitmap, or initialized data bytes
                    fcb       $0A       ; table, bitmap, or initialized data bytes
                    fcc       "Not Enough Memory"            ; embedded text or resource bytes
                    fcb       $0D,$0A,$00,$00,$0C,$0D ; table, bitmap, or initialized data bytes
                    fcb       $0A       ; table, bitmap, or initialized data bytes
                    fcc       "Bad File"                     ; embedded text or resource bytes
                    fcb       $0D,$0A,$00,$00,$1A,$0D ; table, bitmap, or initialized data bytes
                    fcb       $0A       ; table, bitmap, or initialized data bytes
                    fcc       "Error From Disk Acces"        ; embedded text or resource bytes
                    fcc       "s"                            ; embedded text or resource bytes
                    fcb       $0D,$0A   ; table, bitmap, or initialized data bytes
Data_1D6D           fcb       $0D,$0A   ; table, bitmap, or initialized data bytes
                    fcc       "Press any key to retr"        ; embedded text or resource bytes
                    fcc       "y,"                           ; embedded text or resource bytes
                    fcb       $0D,$0A   ; table, bitmap, or initialized data bytes
                    fcc       "Press [BREAK] to abor"        ; embedded text or resource bytes
                    fcc       "t"                            ; embedded text or resource bytes
                    fcb       $0D,$0A   ; table, bitmap, or initialized data bytes
Data_1DA0           fcb       $0D,$0A   ; table, bitmap, or initialized data bytes
                    fcc       "Press any key to abor"        ; embedded text or resource bytes
                    fcc       "t"                            ; embedded text or resource bytes
                    fcb       $0D,$0A   ; table, bitmap, or initialized data bytes
Data_1DBA           fcc       " not found"                   ; embedded text or resource bytes
                    fcb       $0D,$0A   ; table, bitmap, or initialized data bytes
Data_1DC6           fcb       $00       ; table, bitmap, or initialized data bytes

                    emod
eom                 equ       *
                    end
