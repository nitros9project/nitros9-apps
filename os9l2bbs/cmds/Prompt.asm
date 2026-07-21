**********************************************************************
* Prompt - OS-9 Level 2 BBS command
*
* Syntax: Prompt <command> "prompt" [arguments]
* Purpose: Read one value, insert it into a command line, and execute that command.
* Provides parameter prompting for menu and script workflows.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       Prompt
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

WorkWord_001        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_002        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_003        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_004        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_001        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_001      rmb       599       ; reserve 599 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /Prompt/ ; store an OS-9 high-bit-terminated string
start               stx       WorkWord_004,u ; store x at WorkWord_004,u
Branch_001          lda       ,x+       ; load a from ,x+
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       Branch_002 ; branch when the values are equal or the result is zero; target Branch_002
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_002 ; branch when the values are equal or the result is zero; target Branch_002
                    bra       Branch_001 ; continue execution at Branch_001
Branch_002          lda       #13       ; set a to the constant 13
                    sta       -$01,x    ; store a at -$01,x
                    leay      WorkByte_001,u ; form the address WorkByte_001,u in y
                    clr       WorkWord_001,u ; clear WorkWord_001,u to zero and set the condition codes
Branch_003          lda       ,x+       ; load a from ,x+
                    cmpa      #34       ; compare a with #34 and set the condition codes
                    beq       Branch_004 ; branch when the values are equal or the result is zero; target Branch_004
                    sta       ,y+       ; store a at ,y+
                    inc       WorkWord_001,u ; increment the value at WorkWord_001,u
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       Branch_003 ; branch when the values differ or the result is nonzero; target Branch_003
                    lbra      Branch_005 ; continue execution at Branch_005
Branch_004          stx       WorkWord_002,u ; store x at WorkWord_002,u
                    clrb                ; clear b to zero and set the condition codes
Branch_006          lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_007 ; branch when the values are equal or the result is zero; target Branch_007
                    cmpa      #34       ; compare a with #34 and set the condition codes
                    beq       Branch_007 ; branch when the values are equal or the result is zero; target Branch_007
                    incb                ; increment b
                    bra       Branch_006 ; continue execution at Branch_006
Branch_007          stx       WorkWord_003,u ; store x at WorkWord_003,u
                    ldx       WorkWord_002,u ; load x from WorkWord_002,u
                    clra                ; clear a to zero and set the condition codes
                    pshs      y         ; save y on the stack
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    ldx       ,s        ; load x from the current stack frame at ,s
                    ldy       #80       ; set y to the constant 80
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    leay      -$01,y    ; form the address -$01,y in y
                    tfr       y,d       ; copy the register values specified by y,d
                    puls      y         ; restore y from the stack
                    leay      d,y       ; form the address d,y in y
                    addb      WorkWord_001,u ; add to b using WorkWord_001,u
                    stb       WorkWord_001,u ; store b at WorkWord_001,u
                    ldx       WorkWord_003,u ; load x from WorkWord_003,u
Branch_008          lda       ,x+       ; load a from ,x+
                    sta       ,y+       ; store a at ,y+
                    inc       WorkWord_001,u ; increment the value at WorkWord_001,u
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       Branch_008 ; branch when the values differ or the result is nonzero; target Branch_008
Branch_005          ldx       WorkWord_004,u ; load x from WorkWord_004,u
                    ldb       WorkWord_001,u ; load b from WorkWord_001,u
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       #17       ; set a to the constant 17
                    ldb       #3        ; set b to the constant 3
                    pshs      u         ; save u on the stack
                    leau      WorkByte_001,u ; form the workspace or data address WorkByte_001,u in u
                    os9       F$Fork    ; spawn the module at X with parameters at U
                    lbcs      Branch_009 ; branch when carry reports an error or unsigned underflow; target Branch_009
                    os9       F$Wait    ; wait for a child process to terminate
                    lbcs      Branch_009 ; branch when carry reports an error or unsigned underflow; target Branch_009
                    puls      u         ; restore u from the stack
                    clrb                ; clear b to zero and set the condition codes
Branch_009          os9       F$Exit    ; terminate the process with status B

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
