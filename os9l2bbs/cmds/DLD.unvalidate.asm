**********************************************************************
* DLD.unvalidate - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       DLD.unvalidate
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
U0004               rmb       82        ; reserve 82 byte(s) in the module workspace
U0056               rmb       27        ; reserve 27 byte(s) in the module workspace
U0071               rmb       31        ; reserve 31 byte(s) in the module workspace
U0090               rmb       1         ; reserve 1 byte(s) in the module workspace
U0091               rmb       464       ; reserve 464 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /DLD.unvalidate/ ; store an OS-9 high-bit-terminated string
L001B               fcc       "DLD.lst" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcc       "DLD.dsc" ; store literal character data
                    fcb       $0D       ; store byte data
L002B               fcc       "Enter filename to unvalidate:" ; store literal character data
L0048               fcc       "Filename not found." ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
                    fcc       "Name:Desc:--------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
L00A7               fcc       "File unvalidated." ; store literal character data
                    fcb       $0D       ; store byte data
start               lda       0,x       ; load a from 0,x
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L00C8     ; branch when the values are equal or the result is zero; target L00C8
                    lda       #1        ; set a to the constant 1
                    os9       I$ChgDir  ; invoke the OS-9 I$ChgDir service
                    lbcs      L018A     ; branch when carry reports an error or unsigned underflow; target L018A
L00C8               leax      >L001B,pc ; form the address >L001B,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L018A     ; branch when carry reports an error or unsigned underflow; target L018A
                    sta       U0000,u   ; store a at U0000,u
L00D7               leax      >L002B,pc ; form the address >L002B,pc in x
                    ldy       #29       ; set y to the constant 29
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      <U0056,u  ; form the address <U0056,u in x
                    ldy       #27       ; set y to the constant 27
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    lbcs      L00D7     ; branch when carry reports an error or unsigned underflow; target L00D7
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    lble      L0189     ; branch when the signed value is less than or equal; target L0189
L00FB               lda       0,x       ; load a from 0,x
                    anda      #223      ; mask a using #223
                    sta       ,x+       ; store a at ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       L00FB     ; branch when the values differ or the result is nonzero; target L00FB
L0105               lda       U0000,u   ; load a from U0000,u
                    ldb       #5        ; set b to the constant 5
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    lbcs      L018A     ; branch when carry reports an error or unsigned underflow; target L018A
                    tfr       u,y       ; copy the register values specified by u,y
                    puls      u         ; restore u from the stack
                    stx       U0002,u   ; store x at U0002,u
                    sty       U0004,u   ; store y at U0004,u
                    leax      <U0071,u  ; form the address <U0071,u in x
                    lda       U0000,u   ; load a from U0000,u
                    ldy       #96       ; set y to the constant 96
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lbcs      L0145     ; branch when carry reports an error or unsigned underflow; target L0145
                    tst       >U0090,u  ; set condition codes from >U0090,u without changing it
                    beq       L0105     ; branch when the values are equal or the result is zero; target L0105
                    leay      <U0056,u  ; form the address <U0056,u in y
L0135               lda       0,y       ; load a from 0,y
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L015B     ; branch when the values are equal or the result is zero; target L015B
                    lda       ,x+       ; load a from ,x+
                    anda      #223      ; mask a using #223
                    cmpa      ,y+       ; compare a with ,y+ and set the condition codes
                    bne       L0105     ; branch when the values differ or the result is nonzero; target L0105
                    bra       L0135     ; continue execution at L0135
L0145               cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      L018A     ; branch when the values differ or the result is nonzero; target L018A
                    leax      >L0048,pc ; form the address >L0048,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbra      L0189     ; continue execution at L0189
L015B               clr       >U0090,u  ; clear >U0090,u to zero and set the condition codes
                    ldx       U0002,u   ; load x from U0002,u
                    lda       U0000,u   ; load a from U0000,u
                    pshs      u         ; save u on the stack
                    ldu       U0004,u   ; load u from U0004,u
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    lbcs      L018A     ; branch when carry reports an error or unsigned underflow; target L018A
                    puls      u         ; restore u from the stack
                    leax      <U0071,u  ; form the address <U0071,u in x
                    ldy       #96       ; set y to the constant 96
                    lda       U0000,u   ; load a from U0000,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      >L00A7,pc ; form the address >L00A7,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
L0189               clrb                ; clear b to zero and set the condition codes
L018A               os9       F$Exit    ; invoke the OS-9 F$Exit service

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
