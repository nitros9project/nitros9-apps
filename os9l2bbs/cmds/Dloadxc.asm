**********************************************************************
* Dloadxc - OS-9 Level 2 BBS command
*
* Syntax: Dloadxc [file]
* Purpose: Send XMODEM blocks protected by CRC-16.
* Handles ACK/NAK, retry, cancel, end-of-transfer, and timeout state.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       Dloadxc
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

WorkByte_001        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_002        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_003        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_004        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_001        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_005        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_002        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_003        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_001      rmb       10        ; reserve 10 byte(s) in the module workspace
WorkByte_006        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_007        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_008        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_002      rmb       128       ; reserve 128 byte(s) in the module workspace
WorkByte_009        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_010        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_003      rmb       32        ; reserve 32 byte(s) in the module workspace
WorkWord_004        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_011        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_004      rmb       231       ; reserve 231 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /Dloadxc/ ; store an OS-9 high-bit-terminated string
                    fcc       "Copyright (C) 1988By Keith AlphonsoLicenced to Alpha Software TechnologiesAll rights reserved" ; store literal character data
                    fcb       $EC       ; store byte data
                    fcb       $E6       ; store byte data
                    fcb       $EA       ; store byte data
                    fcb       $F5       ; store byte data
                    fcb       $E9       ; store byte data
                    fcb       $A0       ; store byte data
                    fcb       $E2       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $F1       ; store byte data
                    fcb       $E9       ; store byte data
                    fcb       $F0       ; store byte data
                    fcb       $EF       ; store byte data
                    fcb       $F4       ; store byte data
                    fcb       $F0       ; store byte data
Text_001            fcc       "Enter filename to download-->" ; store literal character data
Data_001            fcb       $00       ; store byte data
                    fcb       $1D       ; store byte data
Text_002            fcc       "File open, ready to send..." ; store literal character data
                    fcb       $0D       ; store byte data
Text_003            fcc       "File transfer successful" ; store literal character data
                    fcb       $0D       ; store byte data
Text_004            fcc       "File transfer unsuccessful" ; store literal character data
                    fcb       $0D       ; store byte data
Text_005            fcc       "Press <CTRL><X> to abort" ; store literal character data
                    fcb       $0D       ; store byte data
Data_002            fcb       $04       ; store byte data
Data_003            fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
Text_006            fcc       "Total number of blocks to download:" ; store literal character data
Routine_001         lda       #255      ; set a to the constant 255
                    sta       WorkByte_003,u ; store a at WorkByte_003,u
                    leax      >WorkByte_011,u ; form the address >WorkByte_011,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$GetStt  ; query status code B for path A
                    leax      -$20,x    ; form the address -$20,x in x
                    clr       <$0024,x  ; clear <$0024,x to zero and set the condition codes
                    leax      >WorkByte_011,u ; form the address >WorkByte_011,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$SetStt  ; apply status operation B to path A
                    rts                 ; return to the caller
start               lda       ,x        ; load a from ,x
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       Branch_001 ; branch when the values differ or the result is nonzero; target Branch_001
                    leax      >Text_001,pc ; form the address >Text_001,pc in x
                    ldy       >Data_001,pc ; load y from >Data_001,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >WorkBuffer_003,u ; form the address >WorkBuffer_003,u in x
                    ldy       #32       ; set y to the constant 32
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
Branch_001          stx       >WorkWord_004,u ; store x at >WorkWord_004,u
                    lbsr      Routine_001 ; call subroutine Routine_001
                    lda       #1        ; set a to the constant 1
                    ldx       >WorkWord_004,u ; load x from >WorkWord_004,u
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    sta       WorkByte_001,u ; store a at WorkByte_001,u
                    leax      >Text_006,pc ; form the address >Text_006,pc in x
                    ldy       #35       ; set y to the constant 35
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    ldb       #2        ; set b to the constant 2
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; query status code B for path A
                    tfr       u,y       ; copy the register values specified by u,y
                    puls      u         ; restore u from the stack
                    lda       #7        ; set a to the constant 7
                    sta       WorkByte_005,u ; store a at WorkByte_005,u
Branch_003          tfr       x,d       ; copy the register values specified by x,d
                    lsra                ; shift a right logically
                    rorb                ; rotate b right through carry
                    tfr       d,x       ; copy the register values specified by d,x
                    tfr       y,d       ; copy the register values specified by y,d
                    rora                ; rotate a right through carry
                    rorb                ; rotate b right through carry
                    tfr       d,y       ; copy the register values specified by d,y
                    dec       WorkByte_005,u ; decrement the value at WorkByte_005,u
                    bne       Branch_003 ; branch when the values differ or the result is nonzero; target Branch_003
                    tfr       y,d       ; copy the register values specified by y,d
                    leax      WorkBuffer_001,u ; form the address WorkBuffer_001,u in x
                    addd      #1        ; add to d using #1
                    lbsr      Routine_002 ; call subroutine Routine_002
                    leax      WorkBuffer_001,u ; form the address WorkBuffer_001,u in x
                    ldy       #5        ; set y to the constant 5
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >Data_003,pc ; form the address >Data_003,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Text_005,pc ; form the address >Text_005,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Text_002,pc ; form the address >Text_002,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
Branch_004          leax      WorkByte_002,u ; form the address WorkByte_002,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lda       WorkByte_002,u ; load a from WorkByte_002,u
                    cmpa      #67       ; compare a with #67 and set the condition codes
                    beq       Branch_005 ; branch when the values are equal or the result is zero; target Branch_005
                    cmpa      #24       ; compare a with #24 and set the condition codes
                    lbeq      Branch_006 ; branch when the values are equal or the result is zero; target Branch_006
                    cmpa      #21       ; compare a with #21 and set the condition codes
                    bne       Branch_004 ; branch when the values differ or the result is nonzero; target Branch_004
                    bra       Branch_007 ; continue execution at Branch_007
Branch_005          clr       WorkByte_003,u ; clear WorkByte_003,u to zero and set the condition codes
Branch_007          lda       #1        ; set a to the constant 1
                    sta       <WorkByte_006,u ; store a at <WorkByte_006,u
                    sta       <WorkByte_007,u ; store a at <WorkByte_007,u
                    coma                ; complement every bit in a
                    sta       <WorkByte_008,u ; store a at <WorkByte_008,u
Branch_008          leax      <WorkBuffer_002,u ; form the address <WorkBuffer_002,u in x
                    ldy       #128      ; set y to the constant 128
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lbcs      Branch_009 ; branch when carry reports an error or unsigned underflow; target Branch_009
                    cmpy      #128      ; compare y with #128 and set the condition codes
                    beq       Branch_010 ; branch when the values are equal or the result is zero; target Branch_010
                    tfr       y,d       ; copy the register values specified by y,d
                    leax      d,x       ; form the address d,x in x
                    clra                ; clear a to zero and set the condition codes
Branch_011          sta       ,x+       ; store a at ,x+
                    leay      $01,y     ; form the address $01,y in y
                    cmpy      #128      ; compare y with #128 and set the condition codes
                    bcs       Branch_011 ; branch when carry reports an error or unsigned underflow; target Branch_011
                    leax      <WorkBuffer_002,u ; form the address <WorkBuffer_002,u in x
Branch_010          tst       WorkByte_003,u ; set condition codes from WorkByte_003,u without changing it
                    beq       Branch_012 ; branch when the values are equal or the result is zero; target Branch_012
                    clr       >WorkByte_009,u ; clear >WorkByte_009,u to zero and set the condition codes
                    ldb       #128      ; set b to the constant 128
Branch_013          lda       ,x+       ; load a from ,x+
                    adda      >WorkByte_009,u ; add to a using >WorkByte_009,u
                    sta       >WorkByte_009,u ; store a at >WorkByte_009,u
                    decb                ; decrement b
                    bne       Branch_013 ; branch when the values differ or the result is nonzero; target Branch_013
                    bra       Branch_014 ; continue execution at Branch_014
Branch_012          ldd       #0        ; set d to the constant 0
                    std       >WorkByte_009,u ; store d at >WorkByte_009,u
                    lda       #128      ; set a to the constant 128
                    sta       WorkByte_004,u ; store a at WorkByte_004,u
Branch_015          lda       ,x+       ; load a from ,x+
                    clrb                ; clear b to zero and set the condition codes
                    eora      >WorkByte_009,u ; toggle selected bits in a using >WorkByte_009,u
                    eorb      >WorkByte_010,u ; toggle selected bits in b using >WorkByte_010,u
                    std       >WorkByte_009,u ; store d at >WorkByte_009,u
                    lda       #8        ; set a to the constant 8
                    sta       WorkWord_001,u ; store a at WorkWord_001,u
Branch_016          lda       >WorkByte_009,u ; load a from >WorkByte_009,u
                    bita      #128      ; test selected bits in a using #128
                    beq       Branch_017 ; branch when the values are equal or the result is zero; target Branch_017
                    ldd       >WorkByte_009,u ; load d from >WorkByte_009,u
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    eora      #16       ; toggle selected bits in a using #16
                    eorb      #33       ; toggle selected bits in b using #33
                    std       >WorkByte_009,u ; store d at >WorkByte_009,u
                    bra       Branch_018 ; continue execution at Branch_018
Branch_017          aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    std       >WorkByte_009,u ; store d at >WorkByte_009,u
Branch_018          dec       WorkWord_001,u ; decrement the value at WorkWord_001,u
                    bne       Branch_016 ; branch when the values differ or the result is nonzero; target Branch_016
                    dec       WorkByte_004,u ; decrement the value at WorkByte_004,u
                    bne       Branch_015 ; branch when the values differ or the result is nonzero; target Branch_015
                    ldd       >WorkByte_009,u ; load d from >WorkByte_009,u
Branch_014          leax      <WorkByte_006,u ; form the address <WorkByte_006,u in x
                    tst       WorkByte_003,u ; set condition codes from WorkByte_003,u without changing it
                    beq       Branch_019 ; branch when the values are equal or the result is zero; target Branch_019
                    ldy       #132      ; set y to the constant 132
                    bra       Branch_020 ; continue execution at Branch_020
Branch_019          ldy       #133      ; set y to the constant 133
Branch_020          lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      WorkByte_002,u ; form the address WorkByte_002,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lda       WorkByte_002,u ; load a from WorkByte_002,u
                    cmpa      #21       ; compare a with #21 and set the condition codes
                    beq       Branch_014 ; branch when the values are equal or the result is zero; target Branch_014
                    cmpa      #6        ; compare a with #6 and set the condition codes
                    beq       Branch_021 ; branch when the values are equal or the result is zero; target Branch_021
                    cmpa      #24       ; compare a with #24 and set the condition codes
                    beq       Branch_006 ; branch when the values are equal or the result is zero; target Branch_006
                    lda       #1        ; set a to the constant 1
                    bra       Branch_002 ; continue execution at Branch_002
Branch_021          lda       <WorkByte_007,u ; load a from <WorkByte_007,u
                    inca                ; increment a
                    sta       <WorkByte_007,u ; store a at <WorkByte_007,u
                    coma                ; complement every bit in a
                    sta       <WorkByte_008,u ; store a at <WorkByte_008,u
                    lbra      Branch_008 ; continue execution at Branch_008
Branch_009          cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      Branch_002 ; branch when the values differ or the result is nonzero; target Branch_002
                    leax      >Data_002,pc ; form the address >Data_002,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      WorkByte_002,u ; form the address WorkByte_002,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lda       WorkByte_002,u ; load a from WorkByte_002,u
                    cmpa      #6        ; compare a with #6 and set the condition codes
                    bne       Branch_006 ; branch when the values differ or the result is nonzero; target Branch_006
                    leax      >Text_003,pc ; form the address >Text_003,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    bra       Branch_022 ; continue execution at Branch_022
Branch_006          leax      >Text_004,pc ; form the address >Text_004,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
Branch_022          clrb                ; clear b to zero and set the condition codes
Branch_002          pshs      b         ; save b on the stack
                    bsr       Routine_003 ; call subroutine Routine_003
                    puls      b         ; restore b from the stack
                    os9       F$Exit    ; terminate the process with status B
Routine_003         leax      >WorkByte_011,u ; form the address >WorkByte_011,u in x
                    leax      -$20,x    ; form the address -$20,x in x
                    lda       #1        ; set a to the constant 1
                    sta       <$0024,x  ; store a at <$0024,x
                    leax      >WorkByte_011,u ; form the address >WorkByte_011,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$SetStt  ; apply status operation B to path A
                    rts                 ; return to the caller
                    fcb       $34       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $A6       ; store byte data
                    fcb       $80       ; store byte data
                    fcb       $81       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $FA       ; store byte data
                    fcb       $81       ; store byte data
                    fcb       $39       ; store byte data
                    fcb       $22       ; store byte data
                    fcb       $F6       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $A6       ; store byte data
                    fcb       $80       ; store byte data
                    fcb       $81       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $81       ; store byte data
                    fcb       $39       ; store byte data
                    fcb       $22       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $F4       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $1F       ; store byte data
                    fcc       "oGoH" ; store literal character data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $49       ; store byte data
                    fcb       $A6       ; store byte data
                    fcb       $82       ; store byte data
                    fcb       $81       ; store byte data
                    fcc       "0%." ; store literal character data
                    fcb       $81       ; store byte data
                    fcc       /9"*/ ; store literal character data
                    fcb       $80       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $A7       ; store byte data
                    fcb       $45       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcc       "mE'" ; store literal character data
                    fcb       $06       ; store byte data
                    fcb       $E3       ; store byte data
                    fcc       "IjE " ; store literal character data
                    fcb       $F6       ; store byte data
                    fcb       $E3       ; store byte data
                    fcb       $47       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $47       ; store byte data
                    fcb       $86       ; store byte data
                    fcb       $0A       ; store byte data
                    fcb       $A7       ; store byte data
                    fcb       $45       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcc       "mE'" ; store literal character data
                    fcb       $06       ; store byte data
                    fcb       $E3       ; store byte data
                    fcc       "IjE " ; store literal character data
                    fcb       $F6       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $49       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $47       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $A0       ; store byte data
Routine_002         std       WorkWord_002,u ; store d at WorkWord_002,u
                    lda       #48       ; set a to the constant 48
                    sta       ,x        ; store a at ,x
                    sta       $01,x     ; store a at $01,x
                    sta       $02,x     ; store a at $02,x
                    sta       $03,x     ; store a at $03,x
                    sta       $04,x     ; store a at $04,x
                    ldd       #10000    ; set d to the constant 10000
                    std       WorkWord_003,u ; store d at WorkWord_003,u
                    ldd       WorkWord_002,u ; load d from WorkWord_002,u
                    lbsr      Routine_004 ; call subroutine Routine_004
                    ldd       #1000     ; set d to the constant 1000
                    std       WorkWord_003,u ; store d at WorkWord_003,u
                    ldd       WorkWord_002,u ; load d from WorkWord_002,u
                    bsr       Routine_004 ; call subroutine Routine_004
                    ldd       #100      ; set d to the constant 100
                    std       WorkWord_003,u ; store d at WorkWord_003,u
                    ldd       WorkWord_002,u ; load d from WorkWord_002,u
                    bsr       Routine_004 ; call subroutine Routine_004
                    ldd       #10       ; set d to the constant 10
                    std       WorkWord_003,u ; store d at WorkWord_003,u
                    ldd       WorkWord_002,u ; load d from WorkWord_002,u
                    bsr       Routine_004 ; call subroutine Routine_004
                    ldd       #1        ; set d to the constant 1
                    std       WorkWord_003,u ; store d at WorkWord_003,u
                    ldd       WorkWord_002,u ; load d from WorkWord_002,u
                    bsr       Routine_004 ; call subroutine Routine_004
                    lda       #13       ; set a to the constant 13
                    sta       ,x        ; store a at ,x
                    rts                 ; return to the caller
Routine_004         subd      WorkWord_003,u ; subtract from d using WorkWord_003,u
                    bcs       Branch_023 ; branch when carry reports an error or unsigned underflow; target Branch_023
                    inc       ,x        ; increment the value at ,x
                    bra       Routine_004 ; continue execution at Routine_004
Branch_023          addd      WorkWord_003,u ; add to d using WorkWord_003,u
                    std       WorkWord_002,u ; store d at WorkWord_002,u
                    leax      $01,x     ; form the address $01,x in x
                    rts                 ; return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
