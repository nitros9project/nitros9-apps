**********************************************************************
* DLD.validate - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       DLD.validate
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
U0004               rmb       1         ; reserve 1 byte(s) in the module workspace
U0005               rmb       1         ; reserve 1 byte(s) in the module workspace
U0006               rmb       1         ; reserve 1 byte(s) in the module workspace
U0007               rmb       1         ; reserve 1 byte(s) in the module workspace
U0008               rmb       80        ; reserve 80 byte(s) in the module workspace
U0058               rmb       32        ; reserve 32 byte(s) in the module workspace
U0078               rmb       2         ; reserve 2 byte(s) in the module workspace
U007A               rmb       2         ; reserve 2 byte(s) in the module workspace
U007C               rmb       2         ; reserve 2 byte(s) in the module workspace
U007E               rmb       2         ; reserve 2 byte(s) in the module workspace
U0080               rmb       2         ; reserve 2 byte(s) in the module workspace
U0082               rmb       2         ; reserve 2 byte(s) in the module workspace
U0084               rmb       1         ; reserve 1 byte(s) in the module workspace
U0085               rmb       1         ; reserve 1 byte(s) in the module workspace
U0086               rmb       2         ; reserve 2 byte(s) in the module workspace
U0088               rmb       1         ; reserve 1 byte(s) in the module workspace
U0089               rmb       1         ; reserve 1 byte(s) in the module workspace
U008A               rmb       2         ; reserve 2 byte(s) in the module workspace
U008C               rmb       2         ; reserve 2 byte(s) in the module workspace
U008E               rmb       3         ; reserve 3 byte(s) in the module workspace
U0091               rmb       12        ; reserve 12 byte(s) in the module workspace
U009D               rmb       2         ; reserve 2 byte(s) in the module workspace
U009F               rmb       2         ; reserve 2 byte(s) in the module workspace
U00A1               rmb       27        ; reserve 27 byte(s) in the module workspace
U00BC               rmb       2         ; reserve 2 byte(s) in the module workspace
U00BE               rmb       2         ; reserve 2 byte(s) in the module workspace
U00C0               rmb       1         ; reserve 1 byte(s) in the module workspace
U00C1               rmb       64        ; reserve 64 byte(s) in the module workspace
U0101               rmb       1         ; reserve 1 byte(s) in the module workspace
U0102               rmb       8399      ; reserve 8399 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /DLD.validate/ ; store an OS-9 high-bit-terminated string
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
L0084               fcb       $0A       ; store byte data
                    fcb       $0A       ; store byte data
                    fcc       "   Enter long description now          (Blank line ends)" ; store literal character data
                    fcb       $0D       ; store byte data
L00BF               fcc       "----------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
L0100               fcc       "     Enter file keywords now            (Blank line ends)" ; store literal character data
                    fcb       $0D       ; store byte data
L013A               fcc       "Enter keyword:" ; store literal character data
L0148               fcb       $0A       ; store byte data
                    fcc       "[d]one [e]dit [C]ontinue or [L]ist" ; store literal character data
                    fcb       $0D       ; store byte data
L016C               fcc       "Enter line #" ; store literal character data
                    fcb       $0D       ; store byte data
L0179               fcb       $3E       ; store byte data
L017A               fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
L017C               fcb       $0A       ; store byte data
                    fcc       "Programs to be validated" ; store literal character data
                    fcb       $0D       ; store byte data
L0196               fcc       "File name      Description" ; store literal character data
                    fcb       $0D       ; store byte data
L01B1               fcc       "----------------------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
L01FE               fcc       "[d]ownload, [V]alidate [K]ill or [N]ext:" ; store literal character data
L0226               fcc       "DLD.lst" ; store literal character data
                    fcb       $0D       ; store byte data
L022E               fcc       "DLD.dsc" ; store literal character data
                    fcb       $0D       ; store byte data
L0236               fcc       "DLD.key" ; store literal character data
                    fcb       $0D       ; store byte data
L023E               fcc       "                                                                               " ; store literal character data
L028D               fcb       $0D       ; store byte data
                    fcb       $0A       ; store byte data
                    fcc       "Enter your download protocol" ; store literal character data
                    fcb       $0D       ; store byte data
L02AC               fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
                    fcc       "[x] xmodem" ; store literal character data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
                    fcc       "[C] xmodem (CRC)" ; store literal character data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
                    fcc       "[y] ymodem" ; store literal character data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
                    fcc       "[q] quit" ; store literal character data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
                    fcc       "Protocol?" ; store literal character data
L02EB               fcc       "dloadx" ; store literal character data
                    fcb       $0D       ; store byte data
L02F2               fcc       "dloadxc" ; store literal character data
                    fcb       $0D       ; store byte data
L02FA               fcc       "dloady" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcc       "dloadyb" ; store literal character data
                    fcb       $0D       ; store byte data
L0309               fcb       $0A       ; store byte data
                    fcc       "Enter a one line description" ; store literal character data
                    fcb       $0D       ; store byte data
L0327               fcc       "Delete file? (y/N):" ; store literal character data
L033A               fcb       $08       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $08       ; store byte data
start               lda       0,x       ; load a from 0,x
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L034C     ; branch when the values are equal or the result is zero; target L034C
                    lda       #1        ; set a to the constant 1
                    os9       I$ChgDir  ; invoke the OS-9 I$ChgDir service
                    lbcs      L088E     ; branch when carry reports an error or unsigned underflow; target L088E
L034C               leax      >L0236,pc ; form the address >L0236,pc in x
                    lda       #2        ; set a to the constant 2
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    bcc       L0366     ; branch when carry is clear; target L0366
                    cmpb      #216      ; compare b with #216 and set the condition codes
                    lbne      L088E     ; branch when the values differ or the result is nonzero; target L088E
                    ldb       #27       ; set b to the constant 27
                    os9       I$Create  ; invoke the OS-9 I$Create service
                    lbcs      L088E     ; branch when carry reports an error or unsigned underflow; target L088E
L0366               sta       U0003,u   ; store a at U0003,u
                    leax      >L022E,pc ; form the address >L022E,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    bcc       L0382     ; branch when carry is clear; target L0382
                    cmpb      #216      ; compare b with #216 and set the condition codes
                    lbne      L088E     ; branch when the values differ or the result is nonzero; target L088E
                    ldb       #27       ; set b to the constant 27
                    os9       I$Create  ; invoke the OS-9 I$Create service
                    lbcs      L088E     ; branch when carry reports an error or unsigned underflow; target L088E
L0382               sta       U0004,u   ; store a at U0004,u
                    leax      >L017C,pc ; form the address >L017C,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L0196,pc ; form the address >L0196,pc in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L01B1,pc ; form the address >L01B1,pc in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    ldx       #0        ; set x to the constant 0
                    stx       <U0078,u  ; store x at <U0078,u
                    stx       <U007A,u  ; store x at <U007A,u
                    stx       <U007C,u  ; store x at <U007C,u
                    stx       <U007E,u  ; store x at <U007E,u
                    leax      >L0226,pc ; form the address >L0226,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L088E     ; branch when carry reports an error or unsigned underflow; target L088E
                    sta       U0002,u   ; store a at U0002,u
L03C5               ldd       <U0078,u  ; load d from <U0078,u
                    std       >U0080,u  ; store d at >U0080,u
                    ldd       <U007A,u  ; load d from <U007A,u
                    std       >U0082,u  ; store d at >U0082,u
                    lda       U0002,u   ; load a from U0002,u
                    pshs      u         ; save u on the stack
                    ldx       <U0078,u  ; load x from <U0078,u
                    ldu       <U007A,u  ; load u from <U007A,u
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    puls      u         ; restore u from the stack
                    leax      >U00A1,u  ; form the address >U00A1,u in x
                    ldy       #96       ; set y to the constant 96
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lbcs      L0507     ; branch when carry reports an error or unsigned underflow; target L0507
                    pshs      u         ; save u on the stack
                    ldb       #5        ; set b to the constant 5
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    tfr       u,y       ; copy the register values specified by u,y
                    puls      u         ; restore u from the stack
                    stx       <U0078,u  ; store x at <U0078,u
                    sty       <U007A,u  ; store y at <U007A,u
                    tst       >U00C0,u  ; set condition codes from >U00C0,u without changing it
                    lbne      L07F2     ; branch when the values differ or the result is nonzero; target L07F2
                    clrb                ; clear b to zero and set the condition codes
                    leax      >U00A1,u  ; form the address >U00A1,u in x
L0410               lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L0419     ; branch when the values are equal or the result is zero; target L0419
                    incb                ; increment b
                    bra       L0410     ; continue execution at L0410
L0419               stb       U0006,u   ; store b at U0006,u
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    leax      >U00A1,u  ; form the address >U00A1,u in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    ldb       #15       ; set b to the constant 15
                    subb      U0006,u   ; subtract from b using U0006,u
                    blt       L0439     ; branch when the signed value is less; target L0439
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       #1        ; set a to the constant 1
                    leax      >L023E,pc ; form the address >L023E,pc in x
                    os9       I$Write   ; invoke the OS-9 I$Write service
L0439               leax      >U00C1,u  ; form the address >U00C1,u in x
                    ldy       #65       ; set y to the constant 65
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
L0446               leax      >L01FE,pc ; form the address >L01FE,pc in x
                    ldy       #40       ; set y to the constant 40
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      U0005,u   ; form the address U0005,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    leax      >L028D,pc ; form the address >L028D,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lda       U0005,u   ; load a from U0005,u
                    anda      #223      ; mask a using #223
                    cmpa      #86       ; compare a with #86 and set the condition codes
                    lbeq      L0489     ; branch when the values are equal or the result is zero; target L0489
                    cmpa      #68       ; compare a with #68 and set the condition codes
                    lbeq      L077A     ; branch when the values are equal or the result is zero; target L077A
                    cmpa      #78       ; compare a with #78 and set the condition codes
                    lbeq      L07F2     ; branch when the values are equal or the result is zero; target L07F2
                    cmpa      #75       ; compare a with #75 and set the condition codes
                    lbeq      L0821     ; branch when the values are equal or the result is zero; target L0821
                    lbra      L0446     ; continue execution at L0446
L0489               leax      >L0309,pc ; form the address >L0309,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L0179,pc ; form the address >L0179,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      >U00C1,u  ; form the address >U00C1,u in x
                    ldy       #64       ; set y to the constant 64
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    lda       #255      ; set a to the constant 255
                    sta       >U00C0,u  ; store a at >U00C0,u
                    lda       U0004,u   ; load a from U0004,u
                    ldb       #2        ; set b to the constant 2
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    lbcs      L088E     ; branch when carry reports an error or unsigned underflow; target L088E
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    lbcs      L088E     ; branch when carry reports an error or unsigned underflow; target L088E
                    tfr       u,y       ; copy the register values specified by u,y
                    puls      u         ; restore u from the stack
                    stx       >U00BC,u  ; store x at >U00BC,u
                    sty       >U00BE,u  ; store y at >U00BE,u
                    lda       U0002,u   ; load a from U0002,u
                    pshs      u         ; save u on the stack
                    ldx       <U007C,u  ; load x from <U007C,u
                    ldu       <U007E,u  ; load u from <U007E,u
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    puls      u         ; restore u from the stack
                    leax      >U00A1,u  ; form the address >U00A1,u in x
                    ldy       #96       ; set y to the constant 96
                    lda       U0002,u   ; load a from U0002,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    pshs      u         ; save u on the stack
                    ldb       #5        ; set b to the constant 5
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    tfr       u,y       ; copy the register values specified by u,y
                    puls      u         ; restore u from the stack
                    stx       <U007C,u  ; store x at <U007C,u
                    sty       <U007E,u  ; store y at <U007E,u
                    lbra      L0521     ; continue execution at L0521
L0507               cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      L088E     ; branch when the values differ or the result is nonzero; target L088E
                    lda       U0002,u   ; load a from U0002,u
                    ldb       #2        ; set b to the constant 2
                    pshs      u         ; save u on the stack
                    ldx       <U007C,u  ; load x from <U007C,u
                    ldu       <U007E,u  ; load u from <U007E,u
                    os9       I$SetStt  ; invoke the OS-9 I$SetStt service
                    puls      u         ; restore u from the stack
                    lbra      L088D     ; continue execution at L088D
L0521               lda       U0003,u   ; load a from U0003,u
                    ldb       #2        ; set b to the constant 2
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    lbcs      L088E     ; branch when carry reports an error or unsigned underflow; target L088E
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    lbcs      L088E     ; branch when carry reports an error or unsigned underflow; target L088E
                    puls      u         ; restore u from the stack
                    leax      >L0100,pc ; form the address >L0100,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L00BF,pc ; form the address >L00BF,pc in x
                    ldy       #65       ; set y to the constant 65
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    ldd       >U0080,u  ; load d from >U0080,u
                    std       >U009D,u  ; store d at >U009D,u
                    ldd       >U0082,u  ; load d from >U0082,u
                    std       >U009F,u  ; store d at >U009F,u
L0561               leax      >L013A,pc ; form the address >L013A,pc in x
                    ldy       #14       ; set y to the constant 14
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      >U0091,u  ; form the address >U0091,u in x
                    ldy       #12       ; set y to the constant 12
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    lbcs      L0561     ; branch when carry reports an error or unsigned underflow; target L0561
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    lbls      L0591     ; branch when the unsigned value is lower or equal; target L0591
                    lda       U0003,u   ; load a from U0003,u
                    ldy       #16       ; set y to the constant 16
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    bra       L0561     ; continue execution at L0561
L0591               leax      >L0084,pc ; form the address >L0084,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L088E     ; branch when carry reports an error or unsigned underflow; target L088E
                    leax      >L00BF,pc ; form the address >L00BF,pc in x
                    ldy       #80       ; set y to the constant 80
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L088E     ; branch when carry reports an error or unsigned underflow; target L088E
                    ldd       #0        ; set d to the constant 0
                    std       >U0084,u  ; store d at >U0084,u
                    sta       U0007,u   ; store a at U0007,u
L05BA               ldd       >U0084,u  ; load d from >U0084,u
                    addd      #1        ; add to d using #1
                    std       >U0084,u  ; store d at >U0084,u
                    cmpd      #99       ; compare d with #99 and set the condition codes
                    bge       L05D6     ; branch when the signed value is greater than or equal; target L05D6
                    lbsr      L06EF     ; call subroutine L06EF
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bls       L05D6     ; branch when the unsigned value is lower or equal; target L05D6
                    bra       L05BA     ; continue execution at L05BA
L05D6               leax      >L0148,pc ; form the address >L0148,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L0179,pc ; form the address >L0179,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      U0005,u   ; form the address U0005,u in x
                    clra                ; clear a to zero and set the condition codes
                    ldy       #1        ; set y to the constant 1
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    leax      >L017A,pc ; form the address >L017A,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lda       U0005,u   ; load a from U0005,u
                    anda      #223      ; mask a using #223
                    cmpa      #68       ; compare a with #68 and set the condition codes
                    lbeq      L0742     ; branch when the values are equal or the result is zero; target L0742
                    cmpa      #69       ; compare a with #69 and set the condition codes
                    beq       L062C     ; branch when the values are equal or the result is zero; target L062C
                    cmpa      #67       ; compare a with #67 and set the condition codes
                    beq       L061F     ; branch when the values are equal or the result is zero; target L061F
                    cmpa      #76       ; compare a with #76 and set the condition codes
                    lbeq      L06A6     ; branch when the values are equal or the result is zero; target L06A6
                    bra       L05D6     ; continue execution at L05D6
L061F               ldd       >U0084,u  ; load d from >U0084,u
                    subd      #1        ; subtract from d using #1
                    std       >U0084,u  ; store d at >U0084,u
                    bra       L05BA     ; continue execution at L05BA
L062C               leax      >L016C,pc ; form the address >L016C,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L0179,pc ; form the address >L0179,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    clra                ; clear a to zero and set the condition codes
                    leax      >U008E,u  ; form the address >U008E,u in x
                    ldy       #3        ; set y to the constant 3
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    lbsr      L0A1D     ; call subroutine L0A1D
                    cmpd      >U0084,u  ; compare d with >U0084,u and set the condition codes
                    lbcc      L05D6     ; branch when carry is clear; target L05D6
                    std       >U008C,u  ; store d at >U008C,u
                    leax      >U008E,u  ; form the address >U008E,u in x
                    lbsr      L0A96     ; call subroutine L0A96
                    leax      >U008E,u  ; form the address >U008E,u in x
                    lda       #58       ; set a to the constant 58
                    sta       $02,x     ; store a at $02,x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    ldd       >U008C,u  ; load d from >U008C,u
                    leax      >U0101,u  ; form the address >U0101,u in x
                    lda       #80       ; set a to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      d,x       ; form the address d,x in x
                    ldy       #80       ; set y to the constant 80
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    tfr       y,d       ; copy the register values specified by y,d
                    stb       U0007,u   ; store b at U0007,u
                    dec       U0007,u   ; decrement the value at U0007,u
                    leay      U0008,u   ; form the address U0008,u in y
L0696               lda       ,x+       ; load a from ,x+
                    sta       ,y+       ; store a at ,y+
                    decb                ; decrement b
                    bne       L0696     ; branch when the values differ or the result is nonzero; target L0696
                    ldd       >U008C,u  ; load d from >U008C,u
                    bsr       L06EF     ; call subroutine L06EF
                    lbra      L05D6     ; continue execution at L05D6
L06A6               ldd       #0        ; set d to the constant 0
                    std       >U0084,u  ; store d at >U0084,u
L06AD               ldd       >U0084,u  ; load d from >U0084,u
                    addd      #1        ; add to d using #1
                    std       >U0084,u  ; store d at >U0084,u
                    leax      >U008E,u  ; form the address >U008E,u in x
                    lbsr      L0A96     ; call subroutine L0A96
                    leax      >U008E,u  ; form the address >U008E,u in x
                    lda       #58       ; set a to the constant 58
                    sta       $02,x     ; store a at $02,x
                    lda       #1        ; set a to the constant 1
                    ldy       #3        ; set y to the constant 3
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      >U0101,u  ; form the address >U0101,u in x
                    ldd       >U0084,u  ; load d from >U0084,u
                    lda       #80       ; set a to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      d,x       ; form the address d,x in x
                    ldy       #80       ; set y to the constant 80
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bhi       L06AD     ; branch when the unsigned value is higher; target L06AD
                    lbra      L05D6     ; continue execution at L05D6
L06EF               leax      >U008E,u  ; form the address >U008E,u in x
                    pshs      d         ; save d on the stack
                    lbsr      L0A96     ; call subroutine L0A96
                    leax      >U008E,u  ; form the address >U008E,u in x
                    lda       #58       ; set a to the constant 58
                    sta       $02,x     ; store a at $02,x
                    lda       #1        ; set a to the constant 1
                    ldy       #3        ; set y to the constant 3
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L088E     ; branch when carry reports an error or unsigned underflow; target L088E
                    leax      U0008,u   ; form the address U0008,u in x
                    ldb       U0007,u   ; load b from U0007,u
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    puls      d         ; restore d from the stack
                    lda       #80       ; set a to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      >U0101,u  ; form the address >U0101,u in x
                    leax      d,x       ; form the address d,x in x
                    leay      U0008,u   ; form the address U0008,u in y
                    ldb       #80       ; set b to the constant 80
                    lda       U0007,u   ; load a from U0007,u
                    beq       L073B     ; branch when the values are equal or the result is zero; target L073B
                    sta       >U0088,u  ; store a at >U0088,u
L0730               lda       ,y+       ; load a from ,y+
                    sta       ,x+       ; store a at ,x+
                    decb                ; decrement b
                    dec       >U0088,u  ; decrement the value at >U0088,u
                    bne       L0730     ; branch when the values differ or the result is nonzero; target L0730
L073B               clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    lbsr      L0891     ; call subroutine L0891
                    rts                 ; return to the caller
L0742               lda       #0        ; set a to the constant 0
                    sta       >U0086,u  ; store a at >U0086,u
L0748               lda       >U0086,u  ; load a from >U0086,u
                    inca                ; increment a
                    sta       >U0086,u  ; store a at >U0086,u
                    cmpa      >U0085,u  ; compare a with >U0085,u and set the condition codes
                    bhi       L0777     ; branch when the unsigned value is higher; target L0777
                    ldb       #80       ; set b to the constant 80
                    mul                 ; multiply a by b and return the product in d
                    leax      >U0101,u  ; form the address >U0101,u in x
                    leax      d,x       ; form the address d,x in x
                    ldy       #80       ; set y to the constant 80
                    lda       U0004,u   ; load a from U0004,u
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L088E     ; branch when carry reports an error or unsigned underflow; target L088E
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bls       L0777     ; branch when the unsigned value is lower or equal; target L0777
                    tfr       y,d       ; copy the register values specified by y,d
                    bra       L0748     ; continue execution at L0748
L0777               lbra      L03C5     ; continue execution at L03C5
L077A               leax      >L02AC,pc ; form the address >L02AC,pc in x
                    ldy       #63       ; set y to the constant 63
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      U0005,u   ; form the address U0005,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    leax      >L028D,pc ; form the address >L028D,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lda       U0005,u   ; load a from U0005,u
                    anda      #223      ; mask a using #223
                    cmpa      #88       ; compare a with #88 and set the condition codes
                    beq       L07B6     ; branch when the values are equal or the result is zero; target L07B6
                    cmpa      #67       ; compare a with #67 and set the condition codes
                    beq       L07BC     ; branch when the values are equal or the result is zero; target L07BC
                    cmpa      #89       ; compare a with #89 and set the condition codes
                    beq       L07C2     ; branch when the values are equal or the result is zero; target L07C2
                    cmpa      #81       ; compare a with #81 and set the condition codes
                    lbeq      L088D     ; branch when the values are equal or the result is zero; target L088D
                    bra       L077A     ; continue execution at L077A
L07B6               leax      >L02EB,pc ; form the address >L02EB,pc in x
                    bra       L07CC     ; continue execution at L07CC
L07BC               leax      >L02F2,pc ; form the address >L02F2,pc in x
                    bra       L07CC     ; continue execution at L07CC
L07C2               leax      >L02FA,pc ; form the address >L02FA,pc in x
                    bra       L07CC     ; continue execution at L07CC
                    fcb       $30       ; store byte data
                    fcb       $8D       ; store byte data
                    fcb       $FB       ; store byte data
                    fcb       $35       ; store byte data
L07CC               ldb       U0006,u   ; load b from U0006,u
                    incb                ; increment b
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       #17       ; set a to the constant 17
                    ldb       #3        ; set b to the constant 3
                    pshs      u         ; save u on the stack
                    leau      >U00A1,u  ; form the workspace or data address >U00A1,u in u
                    os9       F$Fork    ; invoke the OS-9 F$Fork service
                    lbcs      L088E     ; branch when carry reports an error or unsigned underflow; target L088E
                    clrb                ; clear b to zero and set the condition codes
                    os9       F$Wait    ; invoke the OS-9 F$Wait service
                    lbcs      L088E     ; branch when carry reports an error or unsigned underflow; target L088E
                    puls      u         ; restore u from the stack
                    tstb                ; set condition codes from b without changing it
                    lbne      L077A     ; branch when the values differ or the result is nonzero; target L077A
L07F2               lda       U0002,u   ; load a from U0002,u
                    pshs      u         ; save u on the stack
                    ldx       <U007C,u  ; load x from <U007C,u
                    ldu       <U007E,u  ; load u from <U007E,u
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    puls      u         ; restore u from the stack
                    leax      >U00A1,u  ; form the address >U00A1,u in x
                    ldy       #96       ; set y to the constant 96
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    pshs      u         ; save u on the stack
                    ldb       #5        ; set b to the constant 5
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    tfr       u,y       ; copy the register values specified by u,y
                    puls      u         ; restore u from the stack
                    stx       <U007C,u  ; store x at <U007C,u
                    sty       <U007E,u  ; store y at <U007E,u
                    lbra      L03C5     ; continue execution at L03C5
L0821               leax      >L0327,pc ; form the address >L0327,pc in x
                    ldy       #19       ; set y to the constant 19
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      U0005,u   ; form the address U0005,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    leax      >L017A,pc ; form the address >L017A,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lda       U0005,u   ; load a from U0005,u
                    anda      #223      ; mask a using #223
                    cmpa      #89       ; compare a with #89 and set the condition codes
                    lbne      L07F2     ; branch when the values differ or the result is nonzero; target L07F2
                    leax      >U00A1,u  ; form the address >U00A1,u in x
                    os9       I$Delete  ; invoke the OS-9 I$Delete service
                    lda       #1        ; set a to the constant 1
                    sta       >U00C0,u  ; store a at >U00C0,u
                    lda       U0002,u   ; load a from U0002,u
                    pshs      u         ; save u on the stack
                    ldx       <U007C,u  ; load x from <U007C,u
                    ldu       <U007E,u  ; load u from <U007E,u
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    puls      u         ; restore u from the stack
                    leax      >U00A1,u  ; form the address >U00A1,u in x
                    ldy       #96       ; set y to the constant 96
                    lda       U0002,u   ; load a from U0002,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    pshs      u         ; save u on the stack
                    ldb       #5        ; set b to the constant 5
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    tfr       u,y       ; copy the register values specified by u,y
                    puls      u         ; restore u from the stack
                    stx       <U007C,u  ; store x at <U007C,u
                    sty       <U007E,u  ; store y at <U007E,u
                    lbra      L03C5     ; continue execution at L03C5
L088D               clrb                ; clear b to zero and set the condition codes
L088E               os9       F$Exit    ; invoke the OS-9 F$Exit service
L0891               lbsr      L09E8     ; call subroutine L09E8
                    ldb       U0007,u   ; load b from U0007,u
                    leay      b,y       ; form the address b,y in y
                    pshs      y         ; save y on the stack
                    negb                ; negate b
                    sex                 ; sign-extend b into d
                    leay      d,y       ; form the address d,y in y
                    clr       U0007,u   ; clear U0007,u to zero and set the condition codes
                    cmpy      #0        ; compare y with #0 and set the condition codes
                    lbeq      L0960     ; branch when the values are equal or the result is zero; target L0960
                    pshs      y,x       ; save y,x on the stack
                    lda       #13       ; set a to the constant 13
L08AC               sta       ,x+       ; store a at ,x+
                    leay      -$01,y    ; form the address -$01,y in y
                    bne       L08AC     ; branch when the values differ or the result is nonzero; target L08AC
                    puls      y,x       ; restore y,x from the stack
L08B4               pshs      y,x       ; save y,x on the stack
                    leax      U0005,u   ; form the address U0005,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    bcs       L08ED     ; branch when carry reports an error or unsigned underflow; target L08ED
                    lda       U0005,u   ; load a from U0005,u
                    cmpa      #1        ; compare a with #1 and set the condition codes
                    beq       L08F1     ; branch when the values are equal or the result is zero; target L08F1
                    cmpa      #8        ; compare a with #8 and set the condition codes
                    beq       L0913     ; branch when the values are equal or the result is zero; target L0913
                    cmpa      #24       ; compare a with #24 and set the condition codes
                    beq       L0937     ; branch when the values are equal or the result is zero; target L0937
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      L095E     ; branch when the values are equal or the result is zero; target L095E
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    bcs       L08ED     ; branch when carry reports an error or unsigned underflow; target L08ED
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    puls      y,x       ; restore y,x from the stack
                    lda       U0005,u   ; load a from U0005,u
                    sta       ,x+       ; store a at ,x+
                    leay      -$01,y    ; form the address -$01,y in y
                    lbeq      L0987     ; branch when the values are equal or the result is zero; target L0987
                    bra       L08B4     ; continue execution at L08B4
L08ED               puls      y,x       ; restore y,x from the stack
                    bra       L08B4     ; continue execution at L08B4
L08F1               puls      y,x       ; restore y,x from the stack
                    leay      -$01,y    ; form the address -$01,y in y
                    beq       L090E     ; branch when the values are equal or the result is zero; target L090E
                    lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L090C     ; branch when the values are equal or the result is zero; target L090C
                    pshs      y,x       ; save y,x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    bra       L08F1     ; continue execution at L08F1
L090C               leax      -$01,x    ; form the address -$01,x in x
L090E               leay      $01,y     ; form the address $01,y in y
                    lbra      L08B4     ; continue execution at L08B4
L0913               puls      y,x       ; restore y,x from the stack
                    leay      $01,y     ; form the address $01,y in y
                    cmpy      0,s       ; compare y with 0,s and set the condition codes
                    bhi       L0932     ; branch when the unsigned value is higher; target L0932
                    pshs      y,x       ; save y,x on the stack
                    leax      >L033A,pc ; form the address >L033A,pc in x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    puls      y,x       ; restore y,x from the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    lbra      L08B4     ; continue execution at L08B4
L0932               leay      -$01,y    ; form the address -$01,y in y
                    lbra      L08B4     ; continue execution at L08B4
L0937               puls      y,x       ; restore y,x from the stack
                    leay      $01,y     ; form the address $01,y in y
                    cmpy      0,s       ; compare y with 0,s and set the condition codes
                    bhi       L0932     ; branch when the unsigned value is higher; target L0932
                    pshs      y,x       ; save y,x on the stack
                    leax      >L033A,pc ; form the address >L033A,pc in x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    puls      y,x       ; restore y,x from the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    cmpy      0,s       ; compare y with 0,s and set the condition codes
                    lbhi      L08B4     ; branch when the unsigned value is higher; target L08B4
                    pshs      y,x       ; save y,x on the stack
                    bra       L0937     ; continue execution at L0937
L095E               puls      y,x       ; restore y,x from the stack
L0960               lda       #13       ; set a to the constant 13
                    sta       ,x+       ; store a at ,x+
                    pshs      y,x       ; save y,x on the stack
                    leax      >L017A,pc ; form the address >L017A,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    puls      y,x       ; restore y,x from the stack
                    puls      d         ; restore d from the stack
                    pshs      y         ; save y on the stack
                    subd      0,s       ; subtract from d using 0,s
                    leas      $02,s     ; adjust the system stack pointer
                    tfr       d,y       ; copy the register values specified by d,y
                    leay      $01,y     ; form the address $01,y in y
                    lbsr      L0A01     ; call subroutine L0A01
                    rts                 ; return to the caller
                    fcc       "50" ; store literal character data
L0987               puls      d         ; restore d from the stack
                    pshs      y         ; save y on the stack
                    subd      0,s       ; subtract from d using 0,s
                    leas      $02,s     ; adjust the system stack pointer
                    addd      #1        ; add to d using #1
                    tfr       d,y       ; copy the register values specified by d,y
                    clrb                ; clear b to zero and set the condition codes
L0995               leay      -$01,y    ; form the address -$01,y in y
                    beq       L09B3     ; branch when the values are equal or the result is zero; target L09B3
                    lda       ,-x       ; load a from ,-x
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       L09C4     ; branch when the values are equal or the result is zero; target L09C4
                    pshs      y,x       ; save y,x on the stack
                    leax      >L033A,pc ; form the address >L033A,pc in x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    incb                ; increment b
                    puls      y,x       ; restore y,x from the stack
                    bra       L0995     ; continue execution at L0995
L09B3               lda       #13       ; set a to the constant 13
                    sta       <$004F,x  ; store a at <$004F,x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    puls      y         ; restore y from the stack
                    rts                 ; return to the caller
L09C4               lda       #13       ; set a to the constant 13
                    sta       ,x+       ; store a at ,x+
                    pshs      y,x       ; save y,x on the stack
                    stb       U0007,u   ; store b at U0007,u
                    leay      U0008,u   ; form the address U0008,u in y
L09CE               lda       ,x+       ; load a from ,x+
                    sta       ,y+       ; store a at ,y+
                    decb                ; decrement b
                    bne       L09CE     ; branch when the values differ or the result is nonzero; target L09CE
                    leax      >L017A,pc ; form the address >L017A,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    puls      y,x       ; restore y,x from the stack
                    lbsr      L0A01     ; call subroutine L0A01
                    rts                 ; return to the caller
L09E8               pshs      y,x,d     ; save y,x,d on the stack
                    leax      <U0058,u  ; form the address <U0058,u in x
                    clra                ; clear a to zero and set the condition codes
                    ldb       #0        ; set b to the constant 0
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    leax      -$20,x    ; form the address -$20,x in x
                    clr       <$0024,x  ; clear <$0024,x to zero and set the condition codes
                    leax      <$0020,x  ; form the address <$0020,x in x
                    os9       I$SetStt  ; invoke the OS-9 I$SetStt service
                    puls      pc,y,x,d  ; restore pc,y,x,d and return to the caller
L0A01               pshs      y,x,d     ; save y,x,d on the stack
                    leax      <U0058,u  ; form the address <U0058,u in x
                    clra                ; clear a to zero and set the condition codes
                    ldb       #0        ; set b to the constant 0
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    leax      -$20,x    ; form the address -$20,x in x
                    lda       #1        ; set a to the constant 1
                    sta       <$0024,x  ; store a at <$0024,x
                    leax      <$0020,x  ; form the address <$0020,x in x
                    clra                ; clear a to zero and set the condition codes
                    os9       I$SetStt  ; invoke the OS-9 I$SetStt service
                    puls      pc,y,x,d  ; restore pc,y,x,d and return to the caller
L0A1D               pshs      y         ; save y on the stack
L0A1F               lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      L0AD7     ; branch when the values are equal or the result is zero; target L0AD7
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L0A1F     ; branch when carry reports an error or unsigned underflow; target L0A1F
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L0A1F     ; branch when the unsigned value is higher; target L0A1F
                    leax      -$01,x    ; form the address -$01,x in x
L0A31               lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L0A3D     ; branch when carry reports an error or unsigned underflow; target L0A3D
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L0A3D     ; branch when the unsigned value is higher; target L0A3D
                    bra       L0A31     ; continue execution at L0A31
L0A3D               pshs      x         ; save x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    clr       >U0088,u  ; clear >U0088,u to zero and set the condition codes
                    clr       >U0089,u  ; clear >U0089,u to zero and set the condition codes
                    ldd       #1        ; set d to the constant 1
                    std       >U008A,u  ; store d at >U008A,u
L0A50               lda       ,-x       ; load a from ,-x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L0A8E     ; branch when carry reports an error or unsigned underflow; target L0A8E
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L0A8E     ; branch when the unsigned value is higher; target L0A8E
                    suba      #48       ; subtract from a using #48
                    sta       U0001,u   ; store a at U0001,u
                    ldd       #0        ; set d to the constant 0
L0A61               tst       U0001,u   ; set condition codes from U0001,u without changing it
                    beq       L0A6D     ; branch when the values are equal or the result is zero; target L0A6D
                    addd      >U008A,u  ; add to d using >U008A,u
                    dec       U0001,u   ; decrement the value at U0001,u
                    bra       L0A61     ; continue execution at L0A61
L0A6D               addd      >U0088,u  ; add to d using >U0088,u
                    std       >U0088,u  ; store d at >U0088,u
                    lda       #10       ; set a to the constant 10
                    sta       U0001,u   ; store a at U0001,u
                    ldd       #0        ; set d to the constant 0
L0A7C               tst       U0001,u   ; set condition codes from U0001,u without changing it
                    beq       L0A88     ; branch when the values are equal or the result is zero; target L0A88
                    addd      >U008A,u  ; add to d using >U008A,u
                    dec       U0001,u   ; decrement the value at U0001,u
                    bra       L0A7C     ; continue execution at L0A7C
L0A88               std       >U008A,u  ; store d at >U008A,u
                    bra       L0A50     ; continue execution at L0A50
L0A8E               ldd       >U0088,u  ; load d from >U0088,u
                    puls      x         ; restore x from the stack
                    puls      pc,y      ; restore pc,y and return to the caller
L0A96               pshs      y         ; save y on the stack
                    std       >U0088,u  ; store d at >U0088,u
                    lda       #48       ; set a to the constant 48
                    sta       0,x       ; store a at 0,x
                    sta       $01,x     ; store a at $01,x
                    ldd       #10       ; set d to the constant 10
                    std       >U008A,u  ; store d at >U008A,u
                    ldd       >U0088,u  ; load d from >U0088,u
                    bsr       L0AC2     ; call subroutine L0AC2
                    ldd       #1        ; set d to the constant 1
                    std       >U008A,u  ; store d at >U008A,u
                    ldd       >U0088,u  ; load d from >U0088,u
                    bsr       L0AC2     ; call subroutine L0AC2
                    lda       #13       ; set a to the constant 13
                    sta       0,x       ; store a at 0,x
                    puls      pc,y      ; restore pc,y and return to the caller
L0AC2               subd      >U008A,u  ; subtract from d using >U008A,u
                    bcs       L0ACC     ; branch when carry reports an error or unsigned underflow; target L0ACC
                    inc       0,x       ; increment the value at 0,x
                    bra       L0AC2     ; continue execution at L0AC2
L0ACC               addd      >U008A,u  ; add to d using >U008A,u
                    std       >U0088,u  ; store d at >U0088,u
                    leax      $01,x     ; form the address $01,x in x
                    rts                 ; return to the caller
L0AD7               ldd       #-1       ; set d to the constant -1
                    puls      pc,y      ; restore pc,y and return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
