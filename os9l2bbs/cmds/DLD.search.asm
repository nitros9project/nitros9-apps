**********************************************************************
* DLD.search - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       DLD.search
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

U0000               rmb       1         ; reserve 1 byte(s) in the module workspace
U0001               rmb       1         ; reserve 1 byte(s) in the module workspace
U0002               rmb       1         ; reserve 1 byte(s) in the module workspace
U0003               rmb       1         ; reserve 1 byte(s) in the module workspace
U0004               rmb       2         ; reserve 2 byte(s) in the module workspace
U0006               rmb       2         ; reserve 2 byte(s) in the module workspace
U0008               rmb       27        ; reserve 27 byte(s) in the module workspace
U0023               rmb       12        ; reserve 12 byte(s) in the module workspace
U002F               rmb       2         ; reserve 2 byte(s) in the module workspace
U0031               rmb       2         ; reserve 2 byte(s) in the module workspace
U0033               rmb       31        ; reserve 31 byte(s) in the module workspace
U0052               rmb       1         ; reserve 1 byte(s) in the module workspace
U0053               rmb       1         ; reserve 1 byte(s) in the module workspace
U0054               rmb       463       ; reserve 463 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /DLD.search/ ; store an OS-9 high-bit-terminated string
L0017               fcc       "DLD.lst" ; store literal character data
                    fcb       $0D       ; store byte data
L001F               fcc       "DLD.key" ; store literal character data
                    fcb       $0D       ; store byte data
L0027               fcc       "Enter keyword for search:" ; store literal character data
L0040               fcc       "No files found." ; store literal character data
                    fcb       $0D       ; store byte data
L0050               fcc       "                                                                               " ; store literal character data
                    fcb       $0D       ; store byte data
L00A0               fcb       $0A       ; store byte data
                    fcc       "File name      Description" ; store literal character data
                    fcb       $0D       ; store byte data
L00BC               fcc       "--------------------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
start               clr       U0003,u   ; clear U0003,u to zero and set the condition codes
                    lda       0,x       ; load a from 0,x
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L0118     ; branch when the values are equal or the result is zero; target L0118
                    lda       #1        ; set a to the constant 1
                    os9       I$ChgDir  ; invoke the OS-9 I$ChgDir service
                    lbcs      L0244     ; branch when carry reports an error or unsigned underflow; target L0244
L0118               ldd       #-1       ; set d to the constant -1
                    std       U0006,u   ; store d at U0006,u
                    std       U0004,u   ; store d at U0004,u
                    leax      >L0017,pc ; form the address >L0017,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L0244     ; branch when carry reports an error or unsigned underflow; target L0244
                    sta       U0001,u   ; store a at U0001,u
                    leax      >L001F,pc ; form the address >L001F,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L0244     ; branch when carry reports an error or unsigned underflow; target L0244
                    sta       U0000,u   ; store a at U0000,u
L013D               leax      >L0027,pc ; form the address >L0027,pc in x
                    ldy       #25       ; set y to the constant 25
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      U0008,u   ; form the address U0008,u in x
                    ldy       #27       ; set y to the constant 27
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    lbcs      L013D     ; branch when carry reports an error or unsigned underflow; target L013D
L0158               leax      <U0023,u  ; form the address <U0023,u in x
                    ldy       #16       ; set y to the constant 16
                    lda       U0000,u   ; load a from U0000,u
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lbcs      L0198     ; branch when carry reports an error or unsigned underflow; target L0198
                    ldd       <U002F,u  ; load d from <U002F,u
                    cmpd      U0004,u   ; compare d with U0004,u and set the condition codes
                    bne       L017A     ; branch when the values differ or the result is nonzero; target L017A
                    ldd       <U0031,u  ; load d from <U0031,u
                    cmpd      U0006,u   ; compare d with U0006,u and set the condition codes
                    bne       L017A     ; branch when the values differ or the result is nonzero; target L017A
                    bra       L0158     ; continue execution at L0158
L017A               pshs      x         ; save x on the stack
L017C               lda       0,x       ; load a from 0,x
                    anda      #223      ; mask a using #223
                    sta       ,x+       ; store a at ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       L017C     ; branch when the values differ or the result is nonzero; target L017C
                    puls      x         ; restore x from the stack
                    leay      U0008,u   ; form the address U0008,u in y
L018A               lda       ,y+       ; load a from ,y+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L01B4     ; branch when the values are equal or the result is zero; target L01B4
                    anda      #223      ; mask a using #223
                    cmpa      ,x+       ; compare a with ,x+ and set the condition codes
                    bne       L0158     ; branch when the values differ or the result is nonzero; target L0158
                    bra       L018A     ; continue execution at L018A
L0198               cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      L0244     ; branch when the values differ or the result is nonzero; target L0244
                    tst       U0003,u   ; set condition codes from U0003,u without changing it
                    lbne      L0243     ; branch when the values differ or the result is nonzero; target L0243
                    leax      >L0040,pc ; form the address >L0040,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbra      L0243     ; continue execution at L0243
L01B4               pshs      u         ; save u on the stack
                    lda       U0001,u   ; load a from U0001,u
                    ldx       <U002F,u  ; load x from <U002F,u
                    ldu       <U0031,u  ; load u from <U0031,u
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    lbcs      L0244     ; branch when carry reports an error or unsigned underflow; target L0244
                    puls      u         ; restore u from the stack
                    leax      <U0033,u  ; form the address <U0033,u in x
                    ldy       #96       ; set y to the constant 96
                    lda       U0001,u   ; load a from U0001,u
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lbcs      L0244     ; branch when carry reports an error or unsigned underflow; target L0244
                    tst       <U0052,u  ; set condition codes from <U0052,u without changing it
                    lbeq      L0158     ; branch when the values are equal or the result is zero; target L0158
                    tst       U0003,u   ; set condition codes from U0003,u without changing it
                    bne       L01FE     ; branch when the values differ or the result is nonzero; target L01FE
                    leax      >L00A0,pc ; form the address >L00A0,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L00BC,pc ; form the address >L00BC,pc in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lda       #255      ; set a to the constant 255
                    sta       U0003,u   ; store a at U0003,u
L01FE               clrb                ; clear b to zero and set the condition codes
                    leax      <U0033,u  ; form the address <U0033,u in x
L0202               lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L020B     ; branch when the values are equal or the result is zero; target L020B
                    incb                ; increment b
                    bra       L0202     ; continue execution at L0202
L020B               stb       U0002,u   ; store b at U0002,u
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    leax      <U0033,u  ; form the address <U0033,u in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    ldb       #15       ; set b to the constant 15
                    subb      U0002,u   ; subtract from b using U0002,u
                    blt       L022A     ; branch when the signed value is less; target L022A
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       #1        ; set a to the constant 1
                    leax      >L0050,pc ; form the address >L0050,pc in x
                    os9       I$Write   ; invoke the OS-9 I$Write service
L022A               leax      <U0053,u  ; form the address <U0053,u in x
                    ldy       #65       ; set y to the constant 65
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    ldd       <U002F,u  ; load d from <U002F,u
                    std       U0004,u   ; store d at U0004,u
                    ldd       <U0031,u  ; load d from <U0031,u
                    std       U0006,u   ; store d at U0006,u
                    lbra      L0158     ; continue execution at L0158
L0243               clrb                ; clear b to zero and set the condition codes
L0244               os9       F$Exit    ; invoke the OS-9 F$Exit service

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
