**********************************************************************
* BBS.download - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       BBS.download
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
U0002               rmb       2         ; reserve 2 byte(s) in the module workspace
U0004               rmb       2         ; reserve 2 byte(s) in the module workspace
U0006               rmb       2         ; reserve 2 byte(s) in the module workspace
U0008               rmb       6         ; reserve 6 byte(s) in the module workspace
U000E               rmb       2         ; reserve 2 byte(s) in the module workspace
U0010               rmb       2         ; reserve 2 byte(s) in the module workspace
U0012               rmb       2         ; reserve 2 byte(s) in the module workspace
U0014               rmb       2         ; reserve 2 byte(s) in the module workspace
U0016               rmb       414       ; reserve 414 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.download/ ; store an OS-9 high-bit-terminated string
                    fcc       "Enter your download protocol" ; store literal character data
                    fcb       $0D       ; store byte data
L0036               fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
                    fcc       "[a] Ascii" ; store literal character data
                    fcb       $0A       ; store byte data
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
L0080               fcc       "dloadx" ; store literal character data
                    fcb       $0D       ; store byte data
L0087               fcc       "dloadxc" ; store literal character data
                    fcb       $0D       ; store byte data
L008F               fcc       "dloady" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcc       "dloadyb" ; store literal character data
                    fcb       $0D       ; store byte data
L009E               fcc       "Dloada" ; store literal character data
                    fcb       $0D       ; store byte data
L00A5               fcb       $0D       ; store byte data
                    fcb       $0A       ; store byte data
L00A7               fcc       "/dd/bbs/BBS.userstats" ; store literal character data
                    fcb       $0D       ; store byte data

start               lda       0,x       ; load a from 0,x
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L00CC     ; branch when the values are equal or the result is zero; target L00CC
                    lda       #1        ; set a to the constant 1
                    os9       I$ChgDir  ; invoke the OS-9 I$ChgDir service
                    lbcs      L01F6     ; branch when carry reports an error or unsigned underflow; target L01F6
L00CC               leax      >L0036,pc ; form the address >L0036,pc in x
                    ldy       #74       ; set y to the constant 74
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      U0000,u   ; form the address U0000,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    leax      >L00A5,pc ; form the address >L00A5,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lda       U0000,u   ; load a from U0000,u
                    anda      #223      ; mask a using #223
                    cmpa      #65       ; compare a with #65 and set the condition codes
                    beq       L011E     ; branch when the values are equal or the result is zero; target L011E
                    cmpa      #88       ; compare a with #88 and set the condition codes
                    beq       L010C     ; branch when the values are equal or the result is zero; target L010C
                    cmpa      #89       ; compare a with #89 and set the condition codes
                    beq       L0112     ; branch when the values are equal or the result is zero; target L0112
                    cmpa      #67       ; compare a with #67 and set the condition codes
                    beq       L0118     ; branch when the values are equal or the result is zero; target L0118
                    cmpa      #81       ; compare a with #81 and set the condition codes
                    lbeq      L01F5     ; branch when the values are equal or the result is zero; target L01F5
                    bra       L00CC     ; continue execution at L00CC
L010C               leax      >L0080,pc ; form the address >L0080,pc in x
                    bra       L0124     ; continue execution at L0124
L0112               leax      >L008F,pc ; form the address >L008F,pc in x
                    bra       L0124     ; continue execution at L0124
L0118               leax      >L0087,pc ; form the address >L0087,pc in x
                    bra       L0124     ; continue execution at L0124
L011E               leax      >L009E,pc ; form the address >L009E,pc in x
                    bra       L0124     ; continue execution at L0124
L0124               ldy       #1        ; set y to the constant 1
                    lda       #17       ; set a to the constant 17
                    ldb       #3        ; set b to the constant 3
                    pshs      u         ; save u on the stack
                    leau      >L00A5,pc ; form the workspace or data address >L00A5,pc in u
                    os9       F$Fork    ; invoke the OS-9 F$Fork service
                    lbcs      L01F6     ; branch when carry reports an error or unsigned underflow; target L01F6
                    clrb                ; clear b to zero and set the condition codes
                    os9       F$Wait    ; invoke the OS-9 F$Wait service
                    lbcs      L01F6     ; branch when carry reports an error or unsigned underflow; target L01F6
                    cmpb      #0        ; compare b with #0 and set the condition codes
                    lbne      L01F6     ; branch when the values differ or the result is nonzero; target L01F6
                    puls      u         ; restore u from the stack
                    leax      >L00A7,pc ; form the address >L00A7,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    bcc       L015D     ; branch when carry is clear; target L015D
                    ldb       #27       ; set b to the constant 27
                    os9       I$Create  ; invoke the OS-9 I$Create service
                    lbcs      L01F6     ; branch when carry reports an error or unsigned underflow; target L01F6
L015D               sta       U0001,u   ; store a at U0001,u
                    os9       F$ID      ; invoke the OS-9 F$ID service
                    sty       U0002,u   ; store y at U0002,u
L0165               leax      U0004,u   ; form the address U0004,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       U0001,u   ; load a from U0001,u
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    bcs       L017B     ; branch when carry reports an error or unsigned underflow; target L017B
                    ldd       U0004,u   ; load d from U0004,u
                    cmpd      U0002,u   ; compare d with U0002,u and set the condition codes
                    bne       L0165     ; branch when the values differ or the result is nonzero; target L0165
                    bra       L0184     ; continue execution at L0184
L017B               cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      L01F6     ; branch when the values differ or the result is nonzero; target L01F6
                    lbra      L01C1     ; continue execution at L01C1
L0184               ldd       <U0012,u  ; load d from <U0012,u
                    addd      #1        ; add to d using #1
                    std       <U0012,u  ; store d at <U0012,u
                    lda       U0001,u   ; load a from U0001,u
                    ldb       #5        ; set b to the constant 5
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    tfr       u,d       ; copy the register values specified by u,d
                    subd      #32       ; subtract from d using #32
                    bge       L019F     ; branch when the signed value is greater than or equal; target L019F
                    leax      -$01,x    ; form the address -$01,x in x
L019F               ldu       0,s       ; load u from the current stack frame at 0,s
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       U0001,u   ; load a from U0001,u
                    tfr       y,u       ; copy the register values specified by y,u
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    lbcs      L01F6     ; branch when carry reports an error or unsigned underflow; target L01F6
                    puls      u         ; restore u from the stack
                    leax      U0004,u   ; form the address U0004,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       U0001,u   ; load a from U0001,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lbra      L01F5     ; continue execution at L01F5
L01C1               leax      U0004,u   ; form the address U0004,u in x
                    ldd       #1        ; set d to the constant 1
                    std       U0006,u   ; store d at U0006,u
                    std       <U0010,u  ; store d at <U0010,u
                    ldd       #0        ; set d to the constant 0
                    std       U000E,u   ; store d at U000E,u
                    std       <U0014,u  ; store d at <U0014,u
                    std       <U0012,u  ; store d at <U0012,u
                    ldd       U0002,u   ; load d from U0002,u
                    std       U0004,u   ; store d at U0004,u
                    leax      U0008,u   ; form the address U0008,u in x
                    os9       F$Time    ; invoke the OS-9 F$Time service
                    lbcs      L01F6     ; branch when carry reports an error or unsigned underflow; target L01F6
                    leax      U0004,u   ; form the address U0004,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       U0001,u   ; load a from U0001,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lbcs      L01F6     ; branch when carry reports an error or unsigned underflow; target L01F6
L01F5               clrb                ; clear b to zero and set the condition codes
L01F6               os9       F$Exit    ; invoke the OS-9 F$Exit service

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
