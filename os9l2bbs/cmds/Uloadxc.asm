**********************************************************************
* Uloadxc - OS-9 Level 2 BBS command
*
* Syntax: Uloadxc [file]
* Purpose: Receive XMODEM blocks using CRC-16.
* Validates block numbers/CRC and handles retries, cancel, and EOT.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       Uloadxc
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
WorkByte_007        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_008        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_009        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_010        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_011        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_001        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_001      rmb       32        ; reserve 32 byte(s) in the module workspace
WorkByte_012        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_013        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_002      rmb       128       ; reserve 128 byte(s) in the module workspace
WorkWord_002        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_003      rmb       32        ; reserve 32 byte(s) in the module workspace
WorkByte_014        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_004      rmb       431       ; reserve 431 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /Uloadxc/ ; store an OS-9 high-bit-terminated string
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
                    leax      WorkBuffer_001,u ; form the address WorkBuffer_001,u in x
                    ldy       #32       ; set y to the constant 32
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
Branch_001          stx       WorkWord_001,u ; store x at WorkWord_001,u
                    lda       #2        ; set a to the constant 2
                    ldb       #27       ; set b to the constant 27
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    sta       WorkByte_002,u ; store a at WorkByte_002,u
                    clr       WorkByte_004,u ; clear WorkByte_004,u to zero and set the condition codes
                    clr       WorkByte_003,u ; clear WorkByte_003,u to zero and set the condition codes
                    clr       >WorkWord_002,u ; clear >WorkWord_002,u to zero and set the condition codes
                    dec       >WorkWord_002,u ; decrement the value at >WorkWord_002,u
                    leax      >Text_001,pc ; form the address >Text_001,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       #4        ; set a to the constant 4
                    sta       WorkByte_007,u ; store a at WorkByte_007,u
                    leax      >WorkBuffer_003,u ; form the address >WorkBuffer_003,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$GetStt  ; query status code B for path A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    leax      >WorkByte_014,u ; form the address >WorkByte_014,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$GetStt  ; query status code B for path A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    leax      >WorkByte_014,u ; form the address >WorkByte_014,u in x
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
                    leax      >WorkByte_014,u ; form the address >WorkByte_014,u in x
                    os9       I$SetStt  ; apply status operation B to path A
Branch_003          tst       WorkByte_007,u ; set condition codes from WorkByte_007,u without changing it
                    beq       Branch_004 ; branch when the values are equal or the result is zero; target Branch_004
                    dec       WorkByte_007,u ; decrement the value at WorkByte_007,u
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
                    lda       WorkByte_005,u ; load a from WorkByte_005,u
                    inca                ; increment a
                    sta       WorkByte_005,u ; store a at WorkByte_005,u
                    cmpa      #254      ; compare a with #254 and set the condition codes
                    bcc       Branch_003 ; branch when carry is clear; target Branch_003
                    ldx       #2        ; set x to the constant 2
                    os9       F$Sleep   ; sleep for the number of ticks in X
                    bra       Branch_006 ; continue execution at Branch_006
Branch_008          leax      WorkByte_001,u ; form the address WorkByte_001,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    cmpa      #1        ; compare a with #1 and set the condition codes
                    beq       Branch_009 ; branch when the values are equal or the result is zero; target Branch_009
                    cmpa      #4        ; compare a with #4 and set the condition codes
                    lbeq      Branch_010 ; branch when the values are equal or the result is zero; target Branch_010
                    cmpa      #24       ; compare a with #24 and set the condition codes
                    lbeq      Branch_011 ; branch when the values are equal or the result is zero; target Branch_011
                    bra       Branch_006 ; continue execution at Branch_006
Branch_009          leax      <WorkByte_012,u ; form the address <WorkByte_012,u in x
                    tst       WorkByte_007,u ; set condition codes from WorkByte_007,u without changing it
                    beq       Branch_012 ; branch when the values are equal or the result is zero; target Branch_012
                    lda       #132      ; set a to the constant 132
                    bra       Branch_013 ; continue execution at Branch_013
Branch_012          lda       #131      ; set a to the constant 131
Branch_013          sta       WorkByte_006,u ; store a at WorkByte_006,u
                    clr       WorkByte_005,u ; clear WorkByte_005,u to zero and set the condition codes
                    bsr       Routine_001 ; call subroutine Routine_001
                    lbcs      Branch_004 ; branch when carry reports an error or unsigned underflow; target Branch_004
                    inc       WorkByte_003,u ; increment the value at WorkByte_003,u
                    lbra      Branch_014 ; continue execution at Branch_014
Routine_001         clra                ; clear a to zero and set the condition codes
                    ldb       #1        ; set b to the constant 1
                    os9       I$GetStt  ; query status code B for path A
                    bcc       Branch_015 ; branch when carry is clear; target Branch_015
                    inc       WorkByte_005,u ; increment the value at WorkByte_005,u
                    lda       WorkByte_005,u ; load a from WorkByte_005,u
                    cmpa      #255      ; compare a with #255 and set the condition codes
                    bhi       Branch_016 ; branch when the unsigned value is higher; target Branch_016
                    pshs      x         ; save x on the stack
                    ldx       #1        ; set x to the constant 1
                    os9       F$Sleep   ; sleep for the number of ticks in X
                    puls      x         ; restore x from the stack
                    bra       Routine_001 ; continue execution at Routine_001
Branch_015          clr       WorkByte_005,u ; clear WorkByte_005,u to zero and set the condition codes
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcs       Branch_017 ; branch when carry reports an error or unsigned underflow; target Branch_017
                    tfr       y,d       ; copy the register values specified by y,d
                    leax      b,x       ; form the address b,x in x
                    lda       WorkByte_006,u ; load a from WorkByte_006,u
                    stb       WorkByte_006,u ; store b at WorkByte_006,u
                    suba      WorkByte_006,u ; subtract from a using WorkByte_006,u
                    sta       WorkByte_006,u ; store a at WorkByte_006,u
                    bne       Routine_001 ; branch when the values differ or the result is nonzero; target Routine_001
                    rts                 ; return to the caller
Branch_016          lda       #255      ; set a to the constant 255
                    rola                ; rotate a left through carry
                    rts                 ; return to the caller
Branch_017          pshs      x         ; save x on the stack
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
Branch_014          lda       <WorkByte_012,u ; load a from <WorkByte_012,u
                    inca                ; increment a
                    cmpa      WorkByte_003,u ; compare a with WorkByte_003,u and set the condition codes
                    lbeq      Branch_018 ; branch when the values are equal or the result is zero; target Branch_018
                    deca                ; decrement a
                    cmpa      WorkByte_003,u ; compare a with WorkByte_003,u and set the condition codes
                    beq       Branch_019 ; branch when the values are equal or the result is zero; target Branch_019
                    dec       WorkByte_003,u ; decrement the value at WorkByte_003,u
                    lbra      Branch_004 ; continue execution at Branch_004
Branch_019          coma                ; complement every bit in a
                    cmpa      <WorkByte_013,u ; compare a with <WorkByte_013,u and set the condition codes
                    beq       Branch_020 ; branch when the values are equal or the result is zero; target Branch_020
                    dec       WorkByte_003,u ; decrement the value at WorkByte_003,u
                    lbra      Branch_004 ; continue execution at Branch_004
Branch_020          leax      <WorkBuffer_002,u ; form the address <WorkBuffer_002,u in x
                    tst       WorkByte_007,u ; set condition codes from WorkByte_007,u without changing it
                    bne       Branch_021 ; branch when the values differ or the result is nonzero; target Branch_021
                    ldb       #128      ; set b to the constant 128
                    clra                ; clear a to zero and set the condition codes
Branch_022          adda      ,x+       ; add to a using ,x+
                    decb                ; decrement b
                    bne       Branch_022 ; branch when the values differ or the result is nonzero; target Branch_022
                    cmpa      >WorkWord_002,u ; compare a with >WorkWord_002,u and set the condition codes
                    lbeq      Branch_023 ; branch when the values are equal or the result is zero; target Branch_023
                    dec       WorkByte_003,u ; decrement the value at WorkByte_003,u
                    lbra      Branch_004 ; continue execution at Branch_004
Branch_021          lda       #128      ; set a to the constant 128
                    sta       WorkByte_008,u ; store a at WorkByte_008,u
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       WorkByte_010,u ; store d at WorkByte_010,u
Branch_024          lda       ,x+       ; load a from ,x+
                    clrb                ; clear b to zero and set the condition codes
                    eora      WorkByte_010,u ; toggle selected bits in a using WorkByte_010,u
                    eorb      WorkByte_011,u ; toggle selected bits in b using WorkByte_011,u
                    std       WorkByte_010,u ; store d at WorkByte_010,u
                    lda       #8        ; set a to the constant 8
                    sta       WorkByte_009,u ; store a at WorkByte_009,u
Branch_025          ldd       WorkByte_010,u ; load d from WorkByte_010,u
                    bita      #128      ; test selected bits in a using #128
                    beq       Branch_026 ; branch when the values are equal or the result is zero; target Branch_026
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    eora      #16       ; toggle selected bits in a using #16
                    eorb      #33       ; toggle selected bits in b using #33
                    std       WorkByte_010,u ; store d at WorkByte_010,u
                    bra       Branch_027 ; continue execution at Branch_027
Branch_026          aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    std       WorkByte_010,u ; store d at WorkByte_010,u
Branch_027          dec       WorkByte_009,u ; decrement the value at WorkByte_009,u
                    bne       Branch_025 ; branch when the values differ or the result is nonzero; target Branch_025
                    dec       WorkByte_008,u ; decrement the value at WorkByte_008,u
                    bne       Branch_024 ; branch when the values differ or the result is nonzero; target Branch_024
                    ldd       WorkByte_010,u ; load d from WorkByte_010,u
                    cmpd      >WorkWord_002,u ; compare d with >WorkWord_002,u and set the condition codes
                    beq       Branch_023 ; branch when the values are equal or the result is zero; target Branch_023
                    dec       WorkByte_003,u ; decrement the value at WorkByte_003,u
                    lbra      Branch_004 ; continue execution at Branch_004
Branch_023          lda       WorkByte_002,u ; load a from WorkByte_002,u
                    leax      <WorkBuffer_002,u ; form the address <WorkBuffer_002,u in x
                    ldy       #128      ; set y to the constant 128
                    os9       I$Write   ; write Y bytes from X to path A
                    bra       Branch_028 ; continue execution at Branch_028
Branch_018          dec       WorkByte_003,u ; decrement the value at WorkByte_003,u
Branch_028          ldx       #60       ; set x to the constant 60
                    os9       F$Sleep   ; sleep for the number of ticks in X
                    lda       #6        ; set a to the constant 6
                    sta       WorkByte_001,u ; store a at WorkByte_001,u
                    lda       #1        ; set a to the constant 1
                    leax      WorkByte_001,u ; form the address WorkByte_001,u in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    clr       WorkByte_004,u ; clear WorkByte_004,u to zero and set the condition codes
                    lbra      Branch_006 ; continue execution at Branch_006
Branch_010          lda       #6        ; set a to the constant 6
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
Branch_011          bsr       Routine_002 ; call subroutine Routine_002
                    leax      >Text_003,pc ; form the address >Text_003,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       WorkByte_002,u ; load a from WorkByte_002,u
                    os9       I$Close   ; close path A
                    ldx       WorkWord_001,u ; load x from WorkWord_001,u
                    os9       I$Delete  ; delete the path named at X
                    lbcs      Branch_007 ; branch when carry reports an error or unsigned underflow; target Branch_007
                    ldb       #1        ; set b to the constant 1
                    bra       Branch_007 ; continue execution at Branch_007
Routine_002         leax      >WorkBuffer_003,u ; form the address >WorkBuffer_003,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$SetStt  ; apply status operation B to path A
                    rts                 ; return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
