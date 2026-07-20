**********************************************************************
* Prompt - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
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

U0000               rmb       2         ; reserve 2 byte(s) in the module workspace
U0002               rmb       2         ; reserve 2 byte(s) in the module workspace
U0004               rmb       2         ; reserve 2 byte(s) in the module workspace
U0006               rmb       2         ; reserve 2 byte(s) in the module workspace
U0008               rmb       1         ; reserve 1 byte(s) in the module workspace
U0009               rmb       599       ; reserve 599 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /Prompt/ ; store an OS-9 high-bit-terminated string
start               stx       U0006,u   ; store x at U0006,u
L0015               lda       ,x+       ; load a from ,x+
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       L0021     ; branch when the values are equal or the result is zero; target L0021
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L0021     ; branch when the values are equal or the result is zero; target L0021
                    bra       L0015     ; continue execution at L0015
L0021               lda       #13       ; set a to the constant 13
                    sta       -$01,x    ; store a at -$01,x
                    leay      U0008,u   ; form the address U0008,u in y
                    clr       U0000,u   ; clear U0000,u to zero and set the condition codes
L0029               lda       ,x+       ; load a from ,x+
                    cmpa      #34       ; compare a with #34 and set the condition codes
                    beq       L003A     ; branch when the values are equal or the result is zero; target L003A
                    sta       ,y+       ; store a at ,y+
                    inc       U0000,u   ; increment the value at U0000,u
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       L0029     ; branch when the values differ or the result is nonzero; target L0029
                    lbra      L007A     ; continue execution at L007A
L003A               stx       U0002,u   ; store x at U0002,u
                    clrb                ; clear b to zero and set the condition codes
L003D               lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L004A     ; branch when the values are equal or the result is zero; target L004A
                    cmpa      #34       ; compare a with #34 and set the condition codes
                    beq       L004A     ; branch when the values are equal or the result is zero; target L004A
                    incb                ; increment b
                    bra       L003D     ; continue execution at L003D
L004A               stx       U0004,u   ; store x at U0004,u
                    ldx       U0002,u   ; load x from U0002,u
                    clra                ; clear a to zero and set the condition codes
                    pshs      y         ; save y on the stack
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    ldx       0,s       ; load x from the current stack frame at 0,s
                    ldy       #80       ; set y to the constant 80
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    leay      -$01,y    ; form the address -$01,y in y
                    tfr       y,d       ; copy the register values specified by y,d
                    puls      y         ; restore y from the stack
                    leay      d,y       ; form the address d,y in y
                    addb      U0000,u   ; add to b using U0000,u
                    stb       U0000,u   ; store b at U0000,u
                    ldx       U0004,u   ; load x from U0004,u
L0070               lda       ,x+       ; load a from ,x+
                    sta       ,y+       ; store a at ,y+
                    inc       U0000,u   ; increment the value at U0000,u
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       L0070     ; branch when the values differ or the result is nonzero; target L0070
L007A               ldx       U0006,u   ; load x from U0006,u
                    ldb       U0000,u   ; load b from U0000,u
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       #17       ; set a to the constant 17
                    ldb       #3        ; set b to the constant 3
                    pshs      u         ; save u on the stack
                    leau      U0008,u   ; form the workspace or data address U0008,u in u
                    os9       F$Fork    ; invoke the OS-9 F$Fork service
                    lbcs      L009A     ; branch when carry reports an error or unsigned underflow; target L009A
                    os9       F$Wait    ; invoke the OS-9 F$Wait service
                    lbcs      L009A     ; branch when carry reports an error or unsigned underflow; target L009A
                    puls      u         ; restore u from the stack
                    clrb                ; clear b to zero and set the condition codes
L009A               os9       F$Exit    ; invoke the OS-9 F$Exit service

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
