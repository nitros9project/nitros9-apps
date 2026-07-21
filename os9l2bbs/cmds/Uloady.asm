**********************************************************************
* Uloady - OS-9 Level 2 BBS command
*
* Syntax: Uloady [file]
* Purpose: Receive a YMODEM header and data blocks.
* Extracts filename/size and handles sequencing, CRC, retry, cancel, and EOT.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       Uloady
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
WorkByte_005        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_006        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_001        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_002        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_003        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_004        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_007        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_008        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_005        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_001      rmb       32        ; reserve 32 byte(s) in the module workspace
WorkByte_009        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_010        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_002      rmb       128       ; reserve 128 byte(s) in the module workspace
WorkBuffer_003      rmb       896       ; reserve 896 byte(s) in the module workspace
WorkWord_006        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_004      rmb       32        ; reserve 32 byte(s) in the module workspace
WorkByte_011        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_005      rmb       431       ; reserve 431 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /Uloady/ ; store an OS-9 high-bit-terminated string
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
Text_001            fcc       "File open, ready to recieve..." ; store literal character data
                    fcb       $0D       ; store byte data
Text_002            fcc       "Enter filename to upload: " ; store literal character data
Text_003            fcc       "Upload aborted!" ; store literal character data
                    fcb       $0D       ; store byte data
Text_004            fcc       "Upload successful!" ; store literal character data
                    fcb       $0D       ; store byte data
start               pshs      x         ; save x on the stack
                    os9       F$ID      ; retrieve the current process and user IDs
                    ldb       #255      ; set b to the constant 255
                    os9       F$SPrior  ; set process A to priority B
                    lda       ,x        ; load a from ,x
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       Branch_001 ; branch when the values differ or the result is nonzero; target Branch_001
                    leax      >Text_002,pc ; form the address >Text_002,pc in x
                    ldy       #25       ; set y to the constant 25
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      <WorkBuffer_001,u ; form the address <WorkBuffer_001,u in x
                    ldy       #32       ; set y to the constant 32
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
Branch_001          stx       <WorkWord_005,u ; store x at <WorkWord_005,u
                    lda       #2        ; set a to the constant 2
                    ldb       #27       ; set b to the constant 27
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    sta       WorkByte_002,u ; store a at WorkByte_002,u
                    clr       WorkByte_004,u ; clear WorkByte_004,u to zero and set the condition codes
                    clr       WorkByte_003,u ; clear WorkByte_003,u to zero and set the condition codes
                    clr       >WorkBuffer_003,u ; clear >WorkBuffer_003,u to zero and set the condition codes
                    dec       >WorkBuffer_003,u ; decrement the value at >WorkBuffer_003,u
                    leax      >Text_001,pc ; form the address >Text_001,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       #6        ; set a to the constant 6
                    sta       WorkWord_002,u ; store a at WorkWord_002,u
                    leax      >WorkBuffer_004,u ; form the address >WorkBuffer_004,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$GetStt  ; query status code B for path A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    leax      >WorkByte_011,u ; form the address >WorkByte_011,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$GetStt  ; query status code B for path A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    leax      >WorkByte_011,u ; form the address >WorkByte_011,u in x
                    leax      -$20,x    ; form the address -$20,x in x
                    clr       <$002B,x  ; clear <$002B,x to zero and set the condition codes
                    clr       <$002C,x  ; clear <$002C,x to zero and set the condition codes
                    clr       <$002E,x  ; clear <$002E,x to zero and set the condition codes
                    clr       <$002F,x  ; clear <$002F,x to zero and set the condition codes
                    clr       <$0030,x  ; clear <$0030,x to zero and set the condition codes
                    clr       <$0031,x  ; clear <$0031,x to zero and set the condition codes
                    clr       <$0038,x  ; clear <$0038,x to zero and set the condition codes
                    clr       <$0039,x  ; clear <$0039,x to zero and set the condition codes
                    clr       <$0024,x  ; clear <$0024,x to zero and set the condition codes
                    clr       <$002D,x  ; clear <$002D,x to zero and set the condition codes
                    clr       <$0027,x  ; clear <$0027,x to zero and set the condition codes
                    clr       <$0028,x  ; clear <$0028,x to zero and set the condition codes
                    clr       <$0029,x  ; clear <$0029,x to zero and set the condition codes
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    leax      >WorkByte_011,u ; form the address >WorkByte_011,u in x
                    os9       I$SetStt  ; apply status operation B to path A
Branch_003          tst       WorkWord_002,u ; set condition codes from WorkWord_002,u without changing it
                    beq       Branch_004 ; branch when the values are equal or the result is zero; target Branch_004
                    dec       WorkWord_002,u ; decrement the value at WorkWord_002,u
                    lda       #67       ; set a to the constant 67
                    sta       WorkByte_001,u ; store a at WorkByte_001,u
                    bra       Branch_005 ; continue execution at Branch_005
Branch_004          lda       #21       ; set a to the constant 21
                    sta       WorkByte_001,u ; store a at WorkByte_001,u
Branch_005          leax      WorkByte_001,u ; form the address WorkByte_001,u in x
                    lda       #1        ; set a to the constant 1
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    clr       WorkByte_005,u ; clear WorkByte_005,u to zero and set the condition codes
                    clr       WorkByte_006,u ; clear WorkByte_006,u to zero and set the condition codes
                    lda       WorkByte_004,u ; load a from WorkByte_004,u
                    inca                ; increment a
                    sta       WorkByte_004,u ; store a at WorkByte_004,u
                    cmpa      #10       ; compare a with #10 and set the condition codes
                    bcs       Branch_006 ; branch when carry reports an error or unsigned underflow; target Branch_006
                    ldb       #1        ; set b to the constant 1
                    lbra      Branch_007 ; continue execution at Branch_007
Branch_006          clra                ; clear a to zero and set the condition codes
                    ldb       #1        ; set b to the constant 1
                    os9       I$GetStt  ; query status code B for path A
                    bcc       Branch_008 ; branch when carry is clear; target Branch_008
                    ldy       WorkByte_005,u ; load y from WorkByte_005,u
                    leay      $01,y     ; form the address $01,y in y
                    sty       WorkByte_005,u ; store y at WorkByte_005,u
                    cmpy      #5376     ; compare y with #5376 and set the condition codes
                    bcc       Branch_003 ; branch when carry is clear; target Branch_003
                    bra       Branch_006 ; continue execution at Branch_006
Branch_008          leax      WorkByte_001,u ; form the address WorkByte_001,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    cmpa      #1        ; compare a with #1 and set the condition codes
                    beq       Branch_009 ; branch when the values are equal or the result is zero; target Branch_009
                    cmpa      #2        ; compare a with #2 and set the condition codes
                    beq       Branch_010 ; branch when the values are equal or the result is zero; target Branch_010
                    cmpa      #4        ; compare a with #4 and set the condition codes
                    lbeq      Branch_011 ; branch when the values are equal or the result is zero; target Branch_011
                    cmpa      #24       ; compare a with #24 and set the condition codes
                    lbeq      Branch_012 ; branch when the values are equal or the result is zero; target Branch_012
                    bra       Branch_006 ; continue execution at Branch_006
Branch_010          leax      <WorkByte_009,u ; form the address <WorkByte_009,u in x
                    tst       WorkWord_002,u ; set condition codes from WorkWord_002,u without changing it
                    beq       Branch_013 ; branch when the values are equal or the result is zero; target Branch_013
                    ldy       #1028     ; set y to the constant 1028
                    bra       Branch_014 ; continue execution at Branch_014
Branch_013          ldy       #1027     ; set y to the constant 1027
Branch_014          sty       WorkWord_001,u ; store y at WorkWord_001,u
                    clr       WorkByte_005,u ; clear WorkByte_005,u to zero and set the condition codes
                    clr       WorkByte_006,u ; clear WorkByte_006,u to zero and set the condition codes
                    bsr       Routine_001 ; call subroutine Routine_001
                    lbcs      Branch_004 ; branch when carry reports an error or unsigned underflow; target Branch_004
                    inc       WorkByte_003,u ; increment the value at WorkByte_003,u
                    lbra      Branch_015 ; continue execution at Branch_015
Branch_009          leax      <WorkByte_009,u ; form the address <WorkByte_009,u in x
                    tst       WorkWord_002,u ; set condition codes from WorkWord_002,u without changing it
                    beq       Branch_016 ; branch when the values are equal or the result is zero; target Branch_016
                    ldy       #132      ; set y to the constant 132
                    bra       Branch_017 ; continue execution at Branch_017
Branch_016          ldy       #131      ; set y to the constant 131
Branch_017          sty       WorkWord_001,u ; store y at WorkWord_001,u
                    clr       WorkByte_005,u ; clear WorkByte_005,u to zero and set the condition codes
                    clr       WorkByte_006,u ; clear WorkByte_006,u to zero and set the condition codes
                    bsr       Routine_001 ; call subroutine Routine_001
                    lbcs      Branch_004 ; branch when carry reports an error or unsigned underflow; target Branch_004
                    inc       WorkByte_003,u ; increment the value at WorkByte_003,u
                    lbra      Branch_018 ; continue execution at Branch_018
Routine_001         clra                ; clear a to zero and set the condition codes
                    ldb       #1        ; set b to the constant 1
                    os9       I$GetStt  ; query status code B for path A
                    bcc       Branch_019 ; branch when carry is clear; target Branch_019
                    ldy       WorkByte_005,u ; load y from WorkByte_005,u
                    leay      $01,y     ; form the address $01,y in y
                    sty       WorkByte_005,u ; store y at WorkByte_005,u
                    cmpy      #4096     ; compare y with #4096 and set the condition codes
                    bhi       Branch_020 ; branch when the unsigned value is higher; target Branch_020
                    bra       Routine_001 ; continue execution at Routine_001
Branch_019          clr       WorkByte_005,u ; clear WorkByte_005,u to zero and set the condition codes
                    clr       WorkByte_006,u ; clear WorkByte_006,u to zero and set the condition codes
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcs       Branch_021 ; branch when carry reports an error or unsigned underflow; target Branch_021
                    tfr       y,d       ; copy the register values specified by y,d
                    leax      d,x       ; form the address d,x in x
                    ldd       WorkWord_001,u ; load d from WorkWord_001,u
                    sty       WorkWord_001,u ; store y at WorkWord_001,u
                    subd      WorkWord_001,u ; subtract from d using WorkWord_001,u
                    std       WorkWord_001,u ; store d at WorkWord_001,u
                    bne       Routine_001 ; branch when the values differ or the result is nonzero; target Routine_001
                    rts                 ; return to the caller
Branch_020          lda       #255      ; set a to the constant 255
                    rola                ; rotate a left through carry
                    rts                 ; return to the caller
Branch_021          pshs      x         ; save x on the stack
                    ldx       #60       ; set x to the constant 60
                    os9       F$Sleep   ; sleep for the number of ticks in X
                    puls      x         ; restore x from the stack
                    clra                ; clear a to zero and set the condition codes
                    ldb       #1        ; set b to the constant 1
                    os9       I$GetStt  ; query status code B for path A
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lda       #255      ; set a to the constant 255
                    rola                ; rotate a left through carry
                    rts                 ; return to the caller
Branch_018          lda       <WorkByte_009,u ; load a from <WorkByte_009,u
                    inca                ; increment a
                    cmpa      WorkByte_003,u ; compare a with WorkByte_003,u and set the condition codes
                    lbeq      Branch_022 ; branch when the values are equal or the result is zero; target Branch_022
                    deca                ; decrement a
                    cmpa      WorkByte_003,u ; compare a with WorkByte_003,u and set the condition codes
                    beq       Branch_023 ; branch when the values are equal or the result is zero; target Branch_023
                    dec       WorkByte_003,u ; decrement the value at WorkByte_003,u
                    lbra      Branch_004 ; continue execution at Branch_004
Branch_023          coma                ; complement every bit in a
                    cmpa      <WorkByte_010,u ; compare a with <WorkByte_010,u and set the condition codes
                    beq       Branch_024 ; branch when the values are equal or the result is zero; target Branch_024
                    dec       WorkByte_003,u ; decrement the value at WorkByte_003,u
                    lbra      Branch_004 ; continue execution at Branch_004
Branch_024          leax      <WorkBuffer_002,u ; form the address <WorkBuffer_002,u in x
                    tst       WorkWord_002,u ; set condition codes from WorkWord_002,u without changing it
                    bne       Branch_025 ; branch when the values differ or the result is nonzero; target Branch_025
                    ldb       #128      ; set b to the constant 128
                    clra                ; clear a to zero and set the condition codes
Branch_026          adda      ,x+       ; add to a using ,x+
                    decb                ; decrement b
                    bne       Branch_026 ; branch when the values differ or the result is nonzero; target Branch_026
                    cmpa      >WorkBuffer_003,u ; compare a with >WorkBuffer_003,u and set the condition codes
                    lbeq      Branch_027 ; branch when the values are equal or the result is zero; target Branch_027
                    dec       WorkByte_003,u ; decrement the value at WorkByte_003,u
                    lbra      Branch_004 ; continue execution at Branch_004
Branch_025          ldy       #128      ; set y to the constant 128
                    sty       WorkWord_003,u ; store y at WorkWord_003,u
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       WorkByte_007,u ; store d at WorkByte_007,u
Branch_028          lda       ,x+       ; load a from ,x+
                    clrb                ; clear b to zero and set the condition codes
                    eora      WorkByte_007,u ; toggle selected bits in a using WorkByte_007,u
                    eorb      WorkByte_008,u ; toggle selected bits in b using WorkByte_008,u
                    std       WorkByte_007,u ; store d at WorkByte_007,u
                    lda       #8        ; set a to the constant 8
                    sta       WorkWord_004,u ; store a at WorkWord_004,u
Branch_029          ldd       WorkByte_007,u ; load d from WorkByte_007,u
                    bita      #128      ; test selected bits in a using #128
                    beq       Branch_030 ; branch when the values are equal or the result is zero; target Branch_030
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    eora      #16       ; toggle selected bits in a using #16
                    eorb      #33       ; toggle selected bits in b using #33
                    std       WorkByte_007,u ; store d at WorkByte_007,u
                    bra       Branch_031 ; continue execution at Branch_031
Branch_030          aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    std       WorkByte_007,u ; store d at WorkByte_007,u
Branch_031          dec       WorkWord_004,u ; decrement the value at WorkWord_004,u
                    bne       Branch_029 ; branch when the values differ or the result is nonzero; target Branch_029
                    ldy       WorkWord_003,u ; load y from WorkWord_003,u
                    leay      -$01,y    ; form the address -$01,y in y
                    sty       WorkWord_003,u ; store y at WorkWord_003,u
                    bne       Branch_028 ; branch when the values differ or the result is nonzero; target Branch_028
                    ldd       WorkByte_007,u ; load d from WorkByte_007,u
                    cmpd      >WorkBuffer_003,u ; compare d with >WorkBuffer_003,u and set the condition codes
                    beq       Branch_027 ; branch when the values are equal or the result is zero; target Branch_027
                    dec       WorkByte_003,u ; decrement the value at WorkByte_003,u
                    lbra      Branch_004 ; continue execution at Branch_004
Branch_027          lda       WorkByte_002,u ; load a from WorkByte_002,u
                    leax      <WorkBuffer_002,u ; form the address <WorkBuffer_002,u in x
                    ldy       #128      ; set y to the constant 128
                    os9       I$Write   ; write Y bytes from X to path A
                    lbra      Branch_032 ; continue execution at Branch_032
Branch_015          lda       <WorkByte_009,u ; load a from <WorkByte_009,u
                    inca                ; increment a
                    cmpa      WorkByte_003,u ; compare a with WorkByte_003,u and set the condition codes
                    lbeq      Branch_022 ; branch when the values are equal or the result is zero; target Branch_022
                    deca                ; decrement a
                    cmpa      WorkByte_003,u ; compare a with WorkByte_003,u and set the condition codes
                    beq       Branch_033 ; branch when the values are equal or the result is zero; target Branch_033
                    dec       WorkByte_003,u ; decrement the value at WorkByte_003,u
                    lbra      Branch_004 ; continue execution at Branch_004
Branch_033          coma                ; complement every bit in a
                    cmpa      <WorkByte_010,u ; compare a with <WorkByte_010,u and set the condition codes
                    beq       Branch_034 ; branch when the values are equal or the result is zero; target Branch_034
                    dec       WorkByte_003,u ; decrement the value at WorkByte_003,u
                    lbra      Branch_004 ; continue execution at Branch_004
Branch_034          leax      <WorkBuffer_002,u ; form the address <WorkBuffer_002,u in x
                    tst       WorkWord_002,u ; set condition codes from WorkWord_002,u without changing it
                    bne       Branch_035 ; branch when the values differ or the result is nonzero; target Branch_035
                    ldy       #1024     ; set y to the constant 1024
                    clra                ; clear a to zero and set the condition codes
Branch_036          adda      ,x+       ; add to a using ,x+
                    leay      -$01,y    ; form the address -$01,y in y
                    bne       Branch_036 ; branch when the values differ or the result is nonzero; target Branch_036
                    cmpa      >WorkWord_006,u ; compare a with >WorkWord_006,u and set the condition codes
                    lbeq      Branch_027 ; branch when the values are equal or the result is zero; target Branch_027
                    dec       WorkByte_003,u ; decrement the value at WorkByte_003,u
                    lbra      Branch_004 ; continue execution at Branch_004
Branch_035          ldy       #1024     ; set y to the constant 1024
                    sty       WorkWord_003,u ; store y at WorkWord_003,u
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       WorkByte_007,u ; store d at WorkByte_007,u
Branch_037          lda       ,x+       ; load a from ,x+
                    clrb                ; clear b to zero and set the condition codes
                    eora      WorkByte_007,u ; toggle selected bits in a using WorkByte_007,u
                    eorb      WorkByte_008,u ; toggle selected bits in b using WorkByte_008,u
                    std       WorkByte_007,u ; store d at WorkByte_007,u
                    lda       #8        ; set a to the constant 8
                    sta       WorkWord_004,u ; store a at WorkWord_004,u
Branch_038          ldd       WorkByte_007,u ; load d from WorkByte_007,u
                    bita      #128      ; test selected bits in a using #128
                    beq       Branch_039 ; branch when the values are equal or the result is zero; target Branch_039
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    eora      #16       ; toggle selected bits in a using #16
                    eorb      #33       ; toggle selected bits in b using #33
                    std       WorkByte_007,u ; store d at WorkByte_007,u
                    bra       Branch_040 ; continue execution at Branch_040
Branch_039          aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    std       WorkByte_007,u ; store d at WorkByte_007,u
Branch_040          dec       WorkWord_004,u ; decrement the value at WorkWord_004,u
                    bne       Branch_038 ; branch when the values differ or the result is nonzero; target Branch_038
                    ldy       WorkWord_003,u ; load y from WorkWord_003,u
                    leay      -$01,y    ; form the address -$01,y in y
                    sty       WorkWord_003,u ; store y at WorkWord_003,u
                    bne       Branch_037 ; branch when the values differ or the result is nonzero; target Branch_037
                    ldd       WorkByte_007,u ; load d from WorkByte_007,u
                    cmpd      >WorkWord_006,u ; compare d with >WorkWord_006,u and set the condition codes
                    beq       Branch_041 ; branch when the values are equal or the result is zero; target Branch_041
                    dec       WorkByte_003,u ; decrement the value at WorkByte_003,u
                    lbra      Branch_004 ; continue execution at Branch_004
Branch_041          lda       WorkByte_002,u ; load a from WorkByte_002,u
                    leax      <WorkBuffer_002,u ; form the address <WorkBuffer_002,u in x
                    ldy       #1024     ; set y to the constant 1024
                    os9       I$Write   ; write Y bytes from X to path A
                    bra       Branch_032 ; continue execution at Branch_032
Branch_022          dec       WorkByte_003,u ; decrement the value at WorkByte_003,u
Branch_032          ldx       #10       ; set x to the constant 10
                    os9       F$Sleep   ; sleep for the number of ticks in X
                    lda       #6        ; set a to the constant 6
                    sta       WorkByte_001,u ; store a at WorkByte_001,u
                    lda       #1        ; set a to the constant 1
                    leax      WorkByte_001,u ; form the address WorkByte_001,u in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    clr       WorkByte_004,u ; clear WorkByte_004,u to zero and set the condition codes
                    lbra      Branch_006 ; continue execution at Branch_006
Branch_011          lda       #6        ; set a to the constant 6
                    sta       WorkByte_001,u ; store a at WorkByte_001,u
                    lda       #1        ; set a to the constant 1
                    leax      WorkByte_001,u ; form the address WorkByte_001,u in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    lda       WorkByte_002,u ; load a from WorkByte_002,u
                    os9       I$Close   ; close path A
                    lbsr      Routine_002 ; call subroutine Routine_002
                    leax      >Text_004,pc ; form the address >Text_004,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    clrb                ; clear b to zero and set the condition codes
Branch_007          pshs      b         ; save b on the stack
                    lbsr      Routine_002 ; call subroutine Routine_002
                    puls      b         ; restore b from the stack
Branch_002          os9       F$Exit    ; terminate the process with status B
Branch_012          bsr       Routine_002 ; call subroutine Routine_002
                    leax      >Text_003,pc ; form the address >Text_003,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       WorkByte_002,u ; load a from WorkByte_002,u
                    os9       I$Close   ; close path A
                    ldx       <WorkWord_005,u ; load x from <WorkWord_005,u
                    os9       I$Delete  ; delete the path named at X
                    lbcs      Branch_007 ; branch when carry reports an error or unsigned underflow; target Branch_007
                    ldb       #1        ; set b to the constant 1
                    bra       Branch_007 ; continue execution at Branch_007
Routine_002         leax      >WorkBuffer_004,u ; form the address >WorkBuffer_004,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$SetStt  ; apply status operation B to path A
                    rts                 ; return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
