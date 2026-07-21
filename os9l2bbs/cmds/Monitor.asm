**********************************************************************
* Monitor - OS-9 Level 2 BBS command
*
* Syntax: Monitor
* Purpose: Watch carrier detect and terminate the caller process tree after hangup.
* Normally started by Tsmon beside BBS.login.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       Monitor
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
WorkWord_002        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_001      rmb       32        ; reserve 32 byte(s) in the module workspace
WorkBuffer_002      rmb       255       ; reserve 255 byte(s) in the module workspace
WorkByte_005        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_006        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_003      rmb       711       ; reserve 711 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /Monitor/ ; store an OS-9 high-bit-terminated string
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
start               lda       ,x        ; load a from ,x
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_001 ; branch when the values are equal or the result is zero; target Branch_001
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Close   ; close path A
                    inca                ; increment a
                    os9       I$Close   ; close path A
                    inca                ; increment a
                    os9       I$Close   ; close path A
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    os9       I$Dup     ; duplicate path A into the next free path number
                    os9       I$Dup     ; duplicate path A into the next free path number
Branch_001          clra                ; clear a to zero and set the condition codes
                    ldb       #14       ; set b to the constant 14
                    leax      WorkBuffer_001,u ; form the address WorkBuffer_001,u in x
                    os9       I$GetStt  ; query status code B for path A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    lda       #241      ; set a to the constant 241
                    pshs      u         ; save u on the stack
                    os9       F$Link    ; link the module named at X
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    tfr       u,y       ; copy the register values specified by u,y
                    puls      u         ; restore u from the stack
                    ldx       $0F,y     ; load x from $0F,y
                    leax      $01,x     ; form the address $01,x in x
                    stx       WorkWord_001,u ; store x at WorkWord_001,u
Branch_003          ldx       #1        ; set x to the constant 1
                    os9       F$Sleep   ; sleep for the number of ticks in X
                    ldx       WorkWord_001,u ; load x from WorkWord_001,u
                    lda       ,x        ; load a from ,x
                    bita      #32       ; test selected bits in a using #32
                    beq       Branch_003 ; branch when the values are equal or the result is zero; target Branch_003
                    os9       F$ID      ; retrieve the current process and user IDs
                    sta       WorkByte_003,u ; store a at WorkByte_003,u
                    leax      >WorkByte_005,u ; form the address >WorkByte_005,u in x
                    os9       F$GPrDsc  ; copy the requested process descriptor into X
                    lda       >WorkByte_006,u ; load a from >WorkByte_006,u
                    sta       WorkByte_001,u ; store a at WorkByte_001,u
                    lda       #255      ; set a to the constant 255
                    sta       WorkByte_002,u ; store a at WorkByte_002,u
                    clr       WorkByte_004,u ; clear WorkByte_004,u to zero and set the condition codes
                    leax      <WorkBuffer_002,u ; form the address <WorkBuffer_002,u in x
                    stx       WorkWord_002,u ; store x at WorkWord_002,u
Branch_004          lda       WorkByte_002,u ; load a from WorkByte_002,u
Branch_005          leax      >WorkByte_005,u ; form the address >WorkByte_005,u in x
                    os9       F$GPrDsc  ; copy the requested process descriptor into X
                    bcs       Branch_006 ; branch when carry reports an error or unsigned underflow; target Branch_006
                    lda       >WorkByte_006,u ; load a from >WorkByte_006,u
                    cmpa      WorkByte_001,u ; compare a with WorkByte_001,u and set the condition codes
                    beq       Branch_007 ; branch when the values are equal or the result is zero; target Branch_007
                    cmpa      #0        ; compare a with #0 and set the condition codes
                    beq       Branch_006 ; branch when the values are equal or the result is zero; target Branch_006
                    bra       Branch_005 ; continue execution at Branch_005
Branch_008          clrb                ; clear b to zero and set the condition codes
Branch_002          os9       F$Exit    ; terminate the process with status B
Branch_007          lda       WorkByte_002,u ; load a from WorkByte_002,u
                    cmpa      WorkByte_003,u ; compare a with WorkByte_003,u and set the condition codes
                    beq       Branch_006 ; branch when the values are equal or the result is zero; target Branch_006
                    ldx       WorkWord_002,u ; load x from WorkWord_002,u
                    sta       ,x+       ; store a at ,x+
                    stx       WorkWord_002,u ; store x at WorkWord_002,u
                    inc       WorkByte_004,u ; increment the value at WorkByte_004,u
Branch_006          dec       WorkByte_002,u ; decrement the value at WorkByte_002,u
                    cmpa      #3        ; compare a with #3 and set the condition codes
                    beq       Branch_009 ; branch when the values are equal or the result is zero; target Branch_009
                    bra       Branch_004 ; continue execution at Branch_004
Branch_009          leax      <WorkBuffer_002,u ; form the address <WorkBuffer_002,u in x
Branch_010          tst       WorkByte_004,u ; set condition codes from WorkByte_004,u without changing it
                    lbeq      Branch_008 ; branch when the values are equal or the result is zero; target Branch_008
                    dec       WorkByte_004,u ; decrement the value at WorkByte_004,u
                    lda       ,x+       ; load a from ,x+
                    clrb                ; clear b to zero and set the condition codes
Branch_011          os9       F$Send    ; send signal B to process A
                    bcc       Branch_010 ; branch when carry is clear; target Branch_010
                    pshs      x,a       ; save x,a on the stack
                    ldx       #1        ; set x to the constant 1
                    os9       F$Sleep   ; sleep for the number of ticks in X
                    puls      x,a       ; restore x,a from the stack
                    bra       Branch_011 ; continue execution at Branch_011

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
