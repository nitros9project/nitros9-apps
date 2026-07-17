********************************************************************
* DMDSKINI - DeskMate 3 disk initializer
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

                    nam       DMDSKINI
                    ttl       DeskMate 3 disk initializer

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct
atrv                set       $00

                    mod       eom,name,tylg,atrv,start,$01BF

name                fcs       /DMDSKINI/ ; OS-9 module name

Addr_0001           equ       $0001     ; absolute address used by original code
Addr_0002           equ       $0002     ; absolute address used by original code
Addr_0004           equ       $0004     ; absolute address used by original code
Addr_0006           equ       $0006     ; absolute address used by original code
Addr_0010           equ       $0010     ; absolute address used by original code
Addr_0011           equ       $0011     ; absolute address used by original code
DeskMateService     equ       $0000     ; absolute address used by original code

start               jmp       >DeskMateService ; dispatch control through the selected target
                    leax      >Data_0044,PCR ; form the referenced address without reading memory
                    tfr       X,D       ; copy the source register into the destination register
                    addd      #Data_0100 ; add the operand to the running value
                    clrb                ; clear the selected byte or register
                    tfr       A,DP      ; copy the source register into the destination register
                    tfr       D,U       ; copy the source register into the destination register
                    sts       $0C,U     ; save the current value in working storage
                    leas      $01BE,U   ; form the referenced address without reading memory
                    leax      Data_0DFB,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $07       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $06       ; private DeskMate service selector
                    leax      Data_15FD,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $08       ; private DeskMate service selector
                    lbra      Code_03D8 ; continue at the distant control-flow target
Data_0044           fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
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
Data_0100           fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
                    fcb       $00,$00,$00,$00,$00,$00 ; table, bitmap, or initialized data bytes
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
Data_0302           fcc       "Insert disk in drive "        ; embedded text or resource bytes
                    fcc       "0,"                           ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_031A           fcc       "Initializing disk."           ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_032D           fcc       "Disk is write protect"        ; embedded text or resource bytes
                    fcc       "ed."                          ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_0346           fcb       $22       ; table, bitmap, or initialized data bytes
                    fcc       "FORMAT"                       ; embedded text or resource bytes
                    fcb       $22       ; table, bitmap, or initialized data bytes
                    fcc       " not found,"                  ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "disk NOT initialized "        ; embedded text or resource bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_0371           fcc       "ERROR- Disk in unknow"        ; embedded text or resource bytes
                    fcc       "n"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "state, use at own ris"        ; embedded text or resource bytes
                    fcc       "k."                           ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_03A0           fcc       "Replace DeskMate disk"        ; embedded text or resource bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_03B7           fcc       "FORMAT"                       ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
Data_03BE           fcc       "/D0 R "                       ; embedded text or resource bytes
                    fcb       $22       ; table, bitmap, or initialized data bytes
                    fcc       "DeskMate"                     ; embedded text or resource bytes
                    fcb       $22,$0D   ; table, bitmap, or initialized data bytes
                    fcc       "DMMENU"                       ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       ";"                      ;03D6: 3B             ' ; embedded text or resource bytes
Data_03D7           fcb       $0C       ; table, bitmap, or initialized data bytes
Code_03D8           stu       DeskMateService ; save the current value in working storage
                    pshs      U         ; preserve the listed registers on the stack
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "N"                            ; embedded text or resource bytes
                    ldx       $16,Y     ; load the value needed by the following operation
                    stx       Addr_0002 ; save the current value in working storage
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "?"                            ; embedded text or resource bytes
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0C       ; private DeskMate service selector
                    stx       Addr_0006 ; save the current value in working storage
                    lda       #$01      ; load the value needed by the following operation
                    leax      >Data_03B7,PCR ; form the referenced address without reading memory
                    os9       F$Load    ; request the named OS-9 service
                    stu       Addr_0004 ; save the current value in working storage
                    lbcs      Code_0487 ; take the distant branch when carry reports an error
                    ldu       DeskMateService ; load the value needed by the following operation
                    leax      Data_0302,PCR ; form the referenced address without reading memory
                    leay      $0E,U     ; form the referenced address without reading memory
Code_0406           lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,Y+       ; store the value and advance the destination pointer
                    bne       Code_0406 ; branch when the compared values differ
                    ldx       Addr_0002 ; load the value needed by the following operation
                    lda       ,X        ; load the value needed by the following operation
                    sta       -$03,Y    ; save the current value in working storage
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      $0E,U     ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    ldd       Addr_0006 ; load the value needed by the following operation
                    lbsr      Code_052C ; call the referenced helper routine
                    cmpb      #$05      ; compare against the limit and set condition flags
                    lbeq      Code_04DD ; take the distant branch when values are equal
                    leax      >Data_03BE,PCR ; form the referenced address without reading memory
                    leay      $0E,U     ; form the referenced address without reading memory
Code_042B           lda       ,X+       ; fetch the next value and advance the source pointer
                    sta       ,Y+       ; store the value and advance the destination pointer
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    bne       Code_042B ; branch when the compared values differ
                    ldx       Addr_0002 ; load the value needed by the following operation
                    lda       ,X        ; load the value needed by the following operation
                    sta       Addr_0010 ; save the current value in working storage
Code_0439           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "?"                            ; embedded text or resource bytes
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      Data_031A,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    ldd       #Data_0100 ; load the value needed by the following operation
                    leax      Data_03B7,PCR ; form the referenced address without reading memory
                    ldy       #Addr_0011 ; load the value needed by the following operation
                    leau      $0E,U     ; form the referenced address without reading memory
                    os9       F$Fork    ; request the named OS-9 service
                    ldu       DeskMateService ; load the value needed by the following operation
                    tstb                ; set condition flags from the current value
                    bne       Code_0464 ; branch when the compared values differ
                    os9       F$Wait    ; request the named OS-9 service
                    tstb                ; set condition flags from the current value
                    lbeq      Code_04DD ; take the distant branch when values are equal
Code_0464           cmpb      #$F2      ; compare against the limit and set condition flags
                    bne       Code_0483 ; branch when the compared values differ
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "?"                            ; embedded text or resource bytes
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      Data_032D,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    ldd       Addr_0006 ; load the value needed by the following operation
                    lbsr      Code_052C ; call the referenced helper routine
                    cmpb      #$05      ; compare against the limit and set condition flags
                    lbeq      Code_04DD ; take the distant branch when values are equal
                    bra       Code_0439 ; continue at the selected control-flow target
Code_0483           cmpb      #$D8      ; compare against the limit and set condition flags
                    bne       Code_04A5 ; branch when the compared values differ
Code_0487           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "?"                            ; embedded text or resource bytes
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      Data_0346,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    ldd       Addr_0006 ; load the value needed by the following operation
                    adda      #$02      ; add the operand to the running value
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    bra       Code_04C1 ; continue at the selected control-flow target
Code_04A5           lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "?"                            ; embedded text or resource bytes
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      Data_0371,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    ldd       Addr_0006 ; load the value needed by the following operation
                    adda      #$02      ; add the operand to the running value
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
Code_04C1           ldd       Addr_0006 ; load the value needed by the following operation
                    adda      #$04      ; add the operand to the running value
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    lda       #$03      ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    lbsr      Code_0570 ; call the referenced helper routine
                    ldb       #$80      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1C       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "E"                            ; embedded text or resource bytes
Code_04DD           ldu       Addr_0004 ; load the value needed by the following operation
                    os9       F$UnLink  ; request the named OS-9 service
                    ldu       DeskMateService ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "?"                            ; embedded text or resource bytes
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    leax      Data_03A0,PCR ; form the referenced address without reading memory
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    ldd       Addr_0006 ; load the value needed by the following operation
                    adda      #$04      ; add the operand to the running value
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    lda       #$03      ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    bsr       Code_0570 ; call the referenced helper routine
                    ldb       #$80      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1C       ; private DeskMate service selector
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "E"                            ; embedded text or resource bytes
                    clra                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "7"                            ; embedded text or resource bytes
                    inca                ; advance the selected counter
                    leax      Data_03D7,PCR ; form the referenced address without reading memory
                    ldy       #Addr_0001 ; load the value needed by the following operation
                    os9       I$Write   ; request the named OS-9 service
                    clra                ; clear the selected byte or register
                    clrb                ; clear the selected byte or register
                    tfr       D,Y       ; copy the source register into the destination register
                    inca                ; advance the selected counter
                    puls      U         ; restore the listed registers from the stack
                    lds       $0C,U     ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "W"                            ; embedded text or resource bytes
Code_052C           pshs      Y,X,D     ; preserve the listed registers on the stack
                    adda      #$03      ; add the operand to the running value
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    lda       #$01      ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    ldd       ,S        ; load the value needed by the following operation
                    adda      #$04      ; add the operand to the running value
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0B       ; private DeskMate service selector
                    lda       #$02      ; load the value needed by the following operation
                    clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $0A       ; private DeskMate service selector
                    bsr       Code_0570 ; call the referenced helper routine
Code_054C           ldb       #$80      ; load the value needed by the following operation
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    cmpa      #$0D      ; compare against the limit and set condition flags
                    beq       Code_056C ; branch when the compared values are equal
                    cmpa      #$05      ; compare against the limit and set condition flags
                    beq       Code_056C ; branch when the compared values are equal
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "E"                            ; embedded text or resource bytes
                    cmpb      #$01      ; compare against the limit and set condition flags
                    bne       Code_054C ; branch when the compared values differ
                    lda       #$05      ; load the value needed by the following operation
                    cmpy      #Addr_0004 ; compare against the limit and set condition flags
                    bcc       Code_056C ; branch when carry is clear
                    lda       #$0D      ; load the value needed by the following operation
Code_056C           sta       $01,S     ; save the current value in working storage
                    puls      PC,Y,X,D  ; restore the listed registers from the stack
Code_0570           pshs      Y,X,D     ; preserve the listed registers on the stack
Code_0572           clrb                ; clear the selected byte or register
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcb       $1D       ; private DeskMate service selector
                    tsta                ; set condition flags from the current value
                    bne       Code_0572 ; branch when the compared values differ
                    lbsr      start     ; invoke the patched DeskMate service dispatcher
                    fcc       "E"                            ; embedded text or resource bytes
                    puls      PC,Y,X,D  ; restore the listed registers from the stack
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
                    fcb       $06,$17,$FA,$1E ; table, bitmap, or initialized data bytes
                    fcc       "/"                            ; embedded text or resource bytes
                    fcb       $1F,$8B   ; table, bitmap, or initialized data bytes
                    fcc       "_"                            ; embedded text or resource bytes
                    fcb       $1F,$03   ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $1F,$02,$D6,$0F,$1F,$01 ; table, bitmap, or initialized data bytes
                    fcb       $17,$FA,$0C ; table, bitmap, or initialized data bytes
                    fcc       "D9"                           ; embedded text or resource bytes
                    fcb       $9E,$0A   ; table, bitmap, or initialized data bytes
                    fcc       "H"                            ; embedded text or resource bytes
                    fcb       $AE,$86   ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $E6,$80,$C4,$80,$17,$F9 ; table, bitmap, or initialized data bytes
                    fcb       $FD,$0A   ; table, bitmap, or initialized data bytes
                    fcc       "9"                            ; embedded text or resource bytes
                    fcb       $D6,$14,$8D,$E1 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $D6,$0D,$1F,$02,$17,$F9 ; table, bitmap, or initialized data bytes
                    fcb       $EF       ; table, bitmap, or initialized data bytes
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
                    fcb       $8D,$03,$85,$0D,$18 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $03,$8D   ; table, bitmap, or initialized data bytes
                    fcc       "2 "                           ; embedded text or resource bytes
                    fcb       $04,$17,$F9,$CF ; table, bitmap, or initialized data bytes
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
                    fcb       $15,$17,$F9,$B4 ; table, bitmap, or initialized data bytes
                    fcc       "A9O"                          ; embedded text or resource bytes
                    fcb       $1F,$02,$D6,$0D ; table, bitmap, or initialized data bytes
                    fcc       "T"                            ; embedded text or resource bytes
                    fcb       $DB,$0F   ; table, bitmap, or initialized data bytes
                    fcc       "Z"                            ; embedded text or resource bytes
                    fcb       $1F,$01,$17,$F9,$A4 ; table, bitmap, or initialized data bytes
                    fcc       "D94"                          ; embedded text or resource bytes
                    fcb       $10,$17,$F9,$9D,$1F ; table, bitmap, or initialized data bytes
                    fcc       "4 0"                          ; embedded text or resource bytes
                    fcb       $8D,$02,$BF,$17,$F9,$93 ; table, bitmap, or initialized data bytes
                    fcb       $06,$AE   ; table, bitmap, or initialized data bytes
                    fcc       "b"                            ; embedded text or resource bytes
                    fcb       $17,$F9,$8D ; table, bitmap, or initialized data bytes
                    fcc       "F50"                          ; embedded text or resource bytes
                    fcb       $17,$F9,$87,$03 ; table, bitmap, or initialized data bytes
                    fcc       "94~"                          ; embedded text or resource bytes
                    fcb       $17,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "]"                            ; embedded text or resource bytes
                    fcb       $0F,$18,$0F,$19,$0F ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $C6,$80,$17,$F9 ; table, bitmap, or initialized data bytes
                    fcc       "u"                            ; embedded text or resource bytes
                    fcb       $1D,$97,$1C,$17,$F9 ; table, bitmap, or initialized data bytes
                    fcc       "o"                            ; embedded text or resource bytes
                    fcb       $18       ; table, bitmap, or initialized data bytes
                    fcc       "M"                            ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
                    fcc       "I"                            ; embedded text or resource bytes
                    fcb       $17,$F9   ; table, bitmap, or initialized data bytes
                    fcc       "fE"                           ; embedded text or resource bytes
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
                    fcb       $17,$F8,$C8,$26,$D6,$1D ; table, bitmap, or initialized data bytes
                    fcb       $17,$FE,$AC,$17,$F8,$BF ; table, bitmap, or initialized data bytes
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
                    fcb       $0A,$13,$8D,$17,$17,$F8 ; table, bitmap, or initialized data bytes
                    fcb       $98       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $D6,$10,$17,$FE ; table, bitmap, or initialized data bytes
                    fcc       "|"                            ; embedded text or resource bytes
                    fcb       $17,$F8,$8F ; table, bitmap, or initialized data bytes
                    fcc       "A"                            ; embedded text or resource bytes
                    fcb       $96,$11,$17,$FE,$7F,$17 ; table, bitmap, or initialized data bytes
                    fcb       $FE,$8B   ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $92,$D6,$10,$17,$FE ; table, bitmap, or initialized data bytes
                    fcc       "i"                            ; embedded text or resource bytes
                    fcb       $17,$F8   ; table, bitmap, or initialized data bytes
                    fcc       "|"                            ; embedded text or resource bytes
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
                    fcb       $17,$F8   ; table, bitmap, or initialized data bytes
                    fcc       "b9"                           ; embedded text or resource bytes
                    fcb       $17,$F8   ; table, bitmap, or initialized data bytes
                    fcc       "^0"                           ; embedded text or resource bytes
                    fcb       $97,$26,$EC,$E4,$D7,$1F ; table, bitmap, or initialized data bytes
                    fcc       "M*!"                          ; embedded text or resource bytes
                    fcb       $84,$7F,$97 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $9F       ; table, bitmap, or initialized data bytes
                    fcc       "!"                            ; embedded text or resource bytes
                    fcb       $17,$F8   ; table, bitmap, or initialized data bytes
                    fcc       "KI"                           ; embedded text or resource bytes
                    fcb       $1F       ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $D7       ; table, bitmap, or initialized data bytes
                    fcc       "#"                            ; embedded text or resource bytes
                    fcb       $1F,$10,$D7 ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $17,$F8   ; table, bitmap, or initialized data bytes
                    fcc       "?4"                           ; embedded text or resource bytes
                    fcb       $0F,$1E,$86,$FF,$17,$F8 ; table, bitmap, or initialized data bytes
                    fcc       "7"                            ; embedded text or resource bytes
                    fcb       $1E,$17,$01,$1D,$17,$01 ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $17,$F8   ; table, bitmap, or initialized data bytes
                    fcc       "-"                            ; embedded text or resource bytes
                    fcb       $18,$84,$80,$8A,$03,$1F ; table, bitmap, or initialized data bytes
                    fcb       $89,$17,$F8 ; table, bitmap, or initialized data bytes
                    fcc       "#"                            ; embedded text or resource bytes
                    fcb       $1C       ; table, bitmap, or initialized data bytes
                    fcc       "]*"                           ; embedded text or resource bytes
                    fcb       $04,$17,$F8,$1C,$16,$97 ; table, bitmap, or initialized data bytes
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
                    fcb       $00,$CF,$A7,$A4,$17,$F8 ; table, bitmap, or initialized data bytes
                    fcb       $00       ; table, bitmap, or initialized data bytes
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
                    fcb       $A7,$A0,$17,$F7,$C8 ; table, bitmap, or initialized data bytes
                    fcc       "Cm"                           ; embedded text or resource bytes
                    fcb       $A4       ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $07,$0C,$1F,$17,$00,$C3 ; table, bitmap, or initialized data bytes
                    fcc       " "                            ; embedded text or resource bytes
                    fcb       $ED,$D6,$1F,$96,$26 ; table, bitmap, or initialized data bytes
                    fcc       "'"                            ; embedded text or resource bytes
                    fcb       $04,$17,$F7,$B3 ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $17,$F7,$AF ; table, bitmap, or initialized data bytes
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
                    fcb       $A7,$85,$17,$F7,$87 ; table, bitmap, or initialized data bytes
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
                    fcb       $02,$86,$01,$17,$F7 ; table, bitmap, or initialized data bytes
                    fcc       "T"                            ; embedded text or resource bytes
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
                    fcb       $08,$17,$F7,$05 ; table, bitmap, or initialized data bytes
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
                    fcb       $04,$1F,$02,$17,$F6,$DC ; table, bitmap, or initialized data bytes
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
                    fcb       $17,$F5,$9D ; table, bitmap, or initialized data bytes
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
                    fcb       $17,$F5,$82 ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
                    fcb       $AE       ; table, bitmap, or initialized data bytes
                    fcc       "a"                            ; embedded text or resource bytes
                    fcb       $26,$04   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "6O_"                          ; embedded text or resource bytes
                    fcb       $17,$F5   ; table, bitmap, or initialized data bytes
                    fcc       "t"                            ; embedded text or resource bytes
                    fcb       $0A,$8E,$00,$0B ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $15,$17,$F5 ; table, bitmap, or initialized data bytes
                    fcc       "kD"                           ; embedded text or resource bytes
                    fcb       $10,$AE   ; table, bitmap, or initialized data bytes
                    fcc       "c"                            ; embedded text or resource bytes
                    fcb       $AE,$A4,$CC,$90,$00,$17 ; table, bitmap, or initialized data bytes
                    fcb       $FC,$F5   ; table, bitmap, or initialized data bytes
                    fcc       "M'"                           ; embedded text or resource bytes
                    fcb       $0A,$81,$0D ; table, bitmap, or initialized data bytes
                    fcc       "'B"                           ; embedded text or resource bytes
                    fcb       $81,$05   ; table, bitmap, or initialized data bytes
                    fcc       "'3 -4v"                       ; embedded text or resource bytes
                    fcb       $17,$F5   ; table, bitmap, or initialized data bytes
                    fcc       "M>4"                          ; embedded text or resource bytes
                    fcb       $02       ; table, bitmap, or initialized data bytes
                    fcc       "m"                            ; embedded text or resource bytes
                    fcb       $8D,$FF,$02,$26,$04 ; table, bitmap, or initialized data bytes
                    fcc       "J*"                           ; embedded text or resource bytes
                    fcb       $01       ; table, bitmap, or initialized data bytes
                    fcc       "L"                            ; embedded text or resource bytes
                    fcb       $17,$F5   ; table, bitmap, or initialized data bytes
                    fcc       "=="                           ; embedded text or resource bytes
                    fcb       $17,$F5   ; table, bitmap, or initialized data bytes
                    fcc       "9E5"                          ; embedded text or resource bytes
                    fcb       $02,$17,$F5 ; table, bitmap, or initialized data bytes
                    fcc       "3="                           ; embedded text or resource bytes
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
                    fcb       $F4,$F3   ; table, bitmap, or initialized data bytes
                    fcc       "J"                            ; embedded text or resource bytes
                    fcb       $C4,$EF   ; table, bitmap, or initialized data bytes
                    fcc       "]'O0"                         ; embedded text or resource bytes
                    fcb       $8D,$FE,$E6 ; table, bitmap, or initialized data bytes
                    fcc       "4"                            ; embedded text or resource bytes
                    fcb       $10,$E6,$84,$0D ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $26,$08   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8D,$FE,$A7,$17,$F4,$DA ; table, bitmap, or initialized data bytes
                    fcc       "8"                            ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       ")"                            ; embedded text or resource bytes
                    fcb       $8B,$02,$17,$F4,$D2 ; table, bitmap, or initialized data bytes
                    fcc       "="                            ; embedded text or resource bytes
                    fcb       $D1       ; table, bitmap, or initialized data bytes
                    fcc       "+'"                           ; embedded text or resource bytes
                    fcb       $06,$D7   ; table, bitmap, or initialized data bytes
                    fcc       "+"                            ; embedded text or resource bytes
                    fcb       $17,$F4,$C8 ; table, bitmap, or initialized data bytes
                    fcc       "?"                            ; embedded text or resource bytes
                    fcb       $C6,$03,$D7 ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $10,$8E,$00,$01 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $8E,$00,$01,$17,$F4,$B8 ; table, bitmap, or initialized data bytes
                    fcc       "D"                            ; embedded text or resource bytes
                    fcb       $AE,$E4,$17,$F4,$B2,$0A ; table, bitmap, or initialized data bytes
                    fcb       $AF,$E4   ; table, bitmap, or initialized data bytes
                    fcc       "1!Z"                          ; embedded text or resource bytes
                    fcb       $26,$EB   ; table, bitmap, or initialized data bytes
                    fcc       "2b"                           ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       ")L"                           ; embedded text or resource bytes
                    fcb       $17,$F4,$A2 ; table, bitmap, or initialized data bytes
                    fcc       "="                            ; embedded text or resource bytes
                    fcb       $16,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "+"                            ; embedded text or resource bytes
                    fcb       $96       ; table, bitmap, or initialized data bytes
                    fcc       ")"                            ; embedded text or resource bytes
                    fcb       $17,$F4,$99 ; table, bitmap, or initialized data bytes
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
                    fcb       $06,$17,$F4,$1E,$0F,$C1 ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $26,$04,$1F,$10 ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8B       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $06,$17,$F4,$10 ; table, bitmap, or initialized data bytes
                    fcc       "D"                            ; embedded text or resource bytes
                    fcb       $17,$F4,$0C ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $86       ; table, bitmap, or initialized data bytes
                    fcc       ":"                            ; embedded text or resource bytes
                    fcb       $17,$F4,$06 ; table, bitmap, or initialized data bytes
                    fcc       "594H"                         ; embedded text or resource bytes
                    fcb       $17,$F9,$DC ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $E9,$FE,$0C,$10,$DF ; table, bitmap, or initialized data bytes
                    fcc       ",46"                          ; embedded text or resource bytes
                    fcb       $17,$F3,$F3,$16,$0F ; table, bitmap, or initialized data bytes
                    fcc       "1O0"                          ; embedded text or resource bytes
                    fcb       $8D,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "h"                            ; embedded text or resource bytes
                    fcb       $17,$F3,$E8 ; table, bitmap, or initialized data bytes
                    fcc       "80"                           ; embedded text or resource bytes
                    fcb       $8D,$FF   ; table, bitmap, or initialized data bytes
                    fcc       "p"                            ; embedded text or resource bytes
                    fcb       $17,$F3,$E0 ; table, bitmap, or initialized data bytes
                    fcc       "G"                            ; embedded text or resource bytes
                    fcb       $C6,$0C,$E7,$84,$17,$F3 ; table, bitmap, or initialized data bytes
                    fcb       $D8       ; table, bitmap, or initialized data bytes
                    fcc       "G"                            ; embedded text or resource bytes
                    fcb       $C6,$02,$E7,$84,$8E,$1F ; table, bitmap, or initialized data bytes
                    fcb       $1A,$10,$8E,$0B,$06,$86 ; table, bitmap, or initialized data bytes
                    fcb       $FF,$17,$F3,$C7,$0E ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $0A,$17,$F3,$C1,$0E,$17 ; table, bitmap, or initialized data bytes
                    fcb       $F3,$BD   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $DD       ; table, bitmap, or initialized data bytes
                    fcc       "."                            ; embedded text or resource bytes
                    fcb       $17,$F3,$B7 ; table, bitmap, or initialized data bytes
                    fcc       "3"                            ; embedded text or resource bytes
                    fcb       $17,$F3,$B3 ; table, bitmap, or initialized data bytes
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
                    fcb       $26,$04,$17,$F3,$95 ; table, bitmap, or initialized data bytes
                    fcc       "4]"                           ; embedded text or resource bytes
                    fcb       $26,$04,$17,$F3,$8E ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $AE       ; table, bitmap, or initialized data bytes
                    fcc       "d"                            ; embedded text or resource bytes
                    fcb       $A6,$94,$80 ; table, bitmap, or initialized data bytes
                    fcc       "0'"                           ; embedded text or resource bytes
                    fcb       $04,$81,$03 ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $06,$17,$F3 ; table, bitmap, or initialized data bytes
                    fcc       "~N"                           ; embedded text or resource bytes
                    fcb       $A6,$84,$8E,$00,$00 ; table, bitmap, or initialized data bytes
                    fcc       "1"                            ; embedded text or resource bytes
                    fcb       $04,$17,$F3 ; table, bitmap, or initialized data bytes
                    fcc       "sD"                           ; embedded text or resource bytes
                    fcb       $17,$F3   ; table, bitmap, or initialized data bytes
                    fcc       "o@"                           ; embedded text or resource bytes
                    fcb       $97       ; table, bitmap, or initialized data bytes
                    fcc       "2"                            ; embedded text or resource bytes
                    fcb       $17,$01   ; table, bitmap, or initialized data bytes
                    fcc       "$"                            ; embedded text or resource bytes
                    fcb       $C6       ; table, bitmap, or initialized data bytes
                    fcc       ")="                           ; embedded text or resource bytes
                    fcb       $17,$F3   ; table, bitmap, or initialized data bytes
                    fcc       "cN0"                          ; embedded text or resource bytes
                    fcb       $88,$26   ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $8B,$DE   ; table, bitmap, or initialized data bytes
                    fcc       ","                            ; embedded text or resource bytes
                    fcb       $10,$AE   ; table, bitmap, or initialized data bytes
                    fcc       "d"                            ; embedded text or resource bytes
                    fcb       $10,$AE,$22,$CC,$01,$F4 ; table, bitmap, or initialized data bytes
                    fcb       $17,$F3   ; table, bitmap, or initialized data bytes
                    fcc       "OL"                           ; embedded text or resource bytes
                    fcb       $10       ; table, bitmap, or initialized data bytes
                    fcc       "%"                            ; embedded text or resource bytes
                    fcb       $01,$01,$97 ; table, bitmap, or initialized data bytes
                    fcc       "0'1"                          ; embedded text or resource bytes
                    fcb       $1F,$89,$17,$F3 ; table, bitmap, or initialized data bytes
                    fcc       "AK"                           ; embedded text or resource bytes
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
                    fcb       $A7,$04,$17,$F3 ; table, bitmap, or initialized data bytes
                    fcc       "("                            ; embedded text or resource bytes
                    fcb       $0F,$C1   ; table, bitmap, or initialized data bytes
                    fcc       "P"                            ; embedded text or resource bytes
                    fcb       $26,$04,$C6,$06,$E7,$05 ; table, bitmap, or initialized data bytes
                    fcc       "O"                            ; embedded text or resource bytes
                    fcb       $17,$F8,$86,$C6,$01,$E7 ; table, bitmap, or initialized data bytes
                    fcb       $8D,$FE,$DE,$0D ; table, bitmap, or initialized data bytes
                    fcc       "0'"                           ; embedded text or resource bytes
                    fcb       $05,$17,$F9,$89 ; table, bitmap, or initialized data bytes
                    fcc       " -"                           ; embedded text or resource bytes
                    fcb       $1F,$13,$17,$F3,$07 ; table, bitmap, or initialized data bytes
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
                    fcb       $17,$F2,$EB,$1D,$17,$F2 ; table, bitmap, or initialized data bytes
                    fcb       $E7,$16,$1F,$89,$C1,$0D ; table, bitmap, or initialized data bytes
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
                    fcb       $06,$17,$F2,$AE,$18 ; table, bitmap, or initialized data bytes
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
                    fcb       $E4,$17,$F2 ; table, bitmap, or initialized data bytes
                    fcc       "ZJ"                           ; embedded text or resource bytes
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
                    fcb       $F2       ; table, bitmap, or initialized data bytes
                    fcc       "*"                            ; embedded text or resource bytes
                    fcb       $13       ; table, bitmap, or initialized data bytes
                    fcc       "0"                            ; embedded text or resource bytes
                    fcb       $09,$E7,$84,$17,$F2,$22 ; table, bitmap, or initialized data bytes
                    fcb       $13       ; table, bitmap, or initialized data bytes
                    fcc       "5"                            ; embedded text or resource bytes
                    fcb       $16,$97   ; table, bitmap, or initialized data bytes
                    fcc       "19("                          ; embedded text or resource bytes
                    fcb       $80       ; table, bitmap, or initialized data bytes
Data_0DFB           fcc       "?"                            ; embedded text or resource bytes
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
Data_15FD           fcb       $CC,$CC   ; table, bitmap, or initialized data bytes
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
