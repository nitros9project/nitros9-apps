**********************************************************************
* BBS.page - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       BBS.page
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

U0000               rmb       8         ; reserve 8 byte(s) in the module workspace
U0008               rmb       41        ; reserve 41 byte(s) in the module workspace
U0031               rmb       463       ; reserve 463 byte(s) in the module workspace
U0200               rmb       1         ; reserve 1 byte(s) in the module workspace
U0201               rmb       1         ; reserve 1 byte(s) in the module workspace
U0202               rmb       1         ; reserve 1 byte(s) in the module workspace
U0203               rmb       1         ; reserve 1 byte(s) in the module workspace
U0204               rmb       2         ; reserve 2 byte(s) in the module workspace
U0206               rmb       2         ; reserve 2 byte(s) in the module workspace
U0208               rmb       2         ; reserve 2 byte(s) in the module workspace
U020A               rmb       2         ; reserve 2 byte(s) in the module workspace
U020C               rmb       1         ; reserve 1 byte(s) in the module workspace
U020D               rmb       1         ; reserve 1 byte(s) in the module workspace
U020E               rmb       2         ; reserve 2 byte(s) in the module workspace
U0210               rmb       2         ; reserve 2 byte(s) in the module workspace
U0212               rmb       64        ; reserve 64 byte(s) in the module workspace
U0252               rmb       64        ; reserve 64 byte(s) in the module workspace
U0292               rmb       1         ; reserve 1 byte(s) in the module workspace
U0293               rmb       64        ; reserve 64 byte(s) in the module workspace
U02D3               rmb       200       ; reserve 200 byte(s) in the module workspace
U039B               rmb       200       ; reserve 200 byte(s) in the module workspace
U0463               rmb       1         ; reserve 1 byte(s) in the module workspace
U0464               rmb       599       ; reserve 599 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.page/ ; store an OS-9 high-bit-terminated string
L0015               fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
L0017               fcc       "/dd/bbs/BBS.alias" ; store literal character data
                    fcb       $0D       ; store byte data
L0029               fcc       "User not currently on-line!" ; store literal character data
                    fcb       $0D       ; store byte data
L0045               fcc       "User not in the alias list!" ; store literal character data
                    fcb       $0D       ; store byte data
L0061               fcc       "User name to page:" ; store literal character data
L0073               fcc       "Sending message now..." ; store literal character data
                    fcb       $0D       ; store byte data
L008A               fcc       "Message recieved by user" ; store literal character data
                    fcb       $0D       ; store byte data
L00A3               fcc       "Enter message to send:" ; store literal character data
L00B9               fcb       $07       ; store byte data
                    fcb       $07       ; store byte data
                    fcb       $07       ; store byte data
                    fcb       $07       ; store byte data
                    fcc       "Page from " ; store literal character data
start               leax      >L0061,pc ; form the address >L0061,pc in x
                    ldy       #18       ; set y to the constant 18
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L034A     ; branch when carry reports an error or unsigned underflow; target L034A
                    leax      >U039B,u  ; form the address >U039B,u in x
                    ldy       #200      ; set y to the constant 200
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    lbcs      L034A     ; branch when carry reports an error or unsigned underflow; target L034A
                    leax      >L0017,pc ; form the address >L0017,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L034A     ; branch when carry reports an error or unsigned underflow; target L034A
                    sta       >U0200,u  ; store a at >U0200,u
L00F9               leax      >U02D3,u  ; form the address >U02D3,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       >U0200,u  ; load a from >U0200,u
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    lbcs      L0134     ; branch when carry reports an error or unsigned underflow; target L0134
                    leay      >U039B,u  ; form the address >U039B,u in y
L0110               lda       0,x       ; load a from 0,x
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    beq       L011E     ; branch when the values are equal or the result is zero; target L011E
                    anda      #223      ; mask a using #223
                    sta       ,x+       ; store a at ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       L0110     ; branch when the values differ or the result is nonzero; target L0110
L011E               leax      >U02D3,u  ; form the address >U02D3,u in x
                    leay      >U039B,u  ; form the address >U039B,u in y
L0126               lda       ,y+       ; load a from ,y+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L0144     ; branch when the values are equal or the result is zero; target L0144
                    anda      #223      ; mask a using #223
                    cmpa      ,x+       ; compare a with ,x+ and set the condition codes
                    bne       L00F9     ; branch when the values differ or the result is nonzero; target L00F9
                    bra       L0126     ; continue execution at L0126
L0134               leax      >L0045,pc ; form the address >L0045,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbra      L0349     ; continue execution at L0349
L0144               lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    bne       L00F9     ; branch when the values differ or the result is nonzero; target L00F9
                    lbsr      L034D     ; call subroutine L034D
                    std       >U020A,u  ; store d at >U020A,u
                    lda       >U0200,u  ; load a from >U0200,u
                    pshs      u         ; save u on the stack
                    ldu       #0        ; set u to the constant 0
                    ldx       #0        ; set x to the constant 0
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    lbcs      L034A     ; branch when carry reports an error or unsigned underflow; target L034A
                    os9       F$ID      ; invoke the OS-9 F$ID service
                    sty       >U0210,u  ; store y at >U0210,u
L016C               leax      >U0463,u  ; form the address >U0463,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       >U0200,u  ; load a from >U0200,u
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    lbcs      L034A     ; branch when carry reports an error or unsigned underflow; target L034A
L017F               lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    bne       L017F     ; branch when the values differ or the result is nonzero; target L017F
                    lda       #13       ; set a to the constant 13
                    sta       -$01,x    ; store a at -$01,x
                    lbsr      L034D     ; call subroutine L034D
                    cmpd      >U0210,u  ; compare d with >U0210,u and set the condition codes
                    bne       L016C     ; branch when the values differ or the result is nonzero; target L016C
                    clr       >U0202,u  ; clear >U0202,u to zero and set the condition codes
L0197               lda       >U0202,u  ; load a from >U0202,u
                    inca                ; increment a
                    sta       >U0202,u  ; store a at >U0202,u
                    beq       L01B4     ; branch when the values are equal or the result is zero; target L01B4
                    leax      U0000,u   ; form the address U0000,u in x
                    os9       F$GPrDsc  ; invoke the OS-9 F$GPrDsc service
                    bcs       L0197     ; branch when carry reports an error or unsigned underflow; target L0197
                    ldd       U0008,u   ; load d from U0008,u
                    cmpd      >U020A,u  ; compare d with >U020A,u and set the condition codes
                    bne       L0197     ; branch when the values differ or the result is nonzero; target L0197
                    bra       L01C4     ; continue execution at L01C4
L01B4               leax      >L0029,pc ; form the address >L0029,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbra      L0349     ; continue execution at L0349
L01C4               lbsr      L0245     ; call subroutine L0245
                    leax      >L00A3,pc ; form the address >L00A3,pc in x
                    ldy       #22       ; set y to the constant 22
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      >U02D3,u  ; form the address >U02D3,u in x
                    ldy       #200      ; set y to the constant 200
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    lbcs      L034A     ; branch when carry reports an error or unsigned underflow; target L034A
                    leax      >L0073,pc ; form the address >L0073,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lda       #47       ; set a to the constant 47
                    sta       >U0292,u  ; store a at >U0292,u
                    leax      >U0292,u  ; form the address >U0292,u in x
                    lda       #2        ; set a to the constant 2
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L034A     ; branch when carry reports an error or unsigned underflow; target L034A
                    sta       >U0201,u  ; store a at >U0201,u
                    leax      >L00B9,pc ; form the address >L00B9,pc in x
                    ldy       #14       ; set y to the constant 14
                    lda       >U0201,u  ; load a from >U0201,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      >U0463,u  ; form the address >U0463,u in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >U02D3,u  ; form the address >U02D3,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       >U0201,u  ; load a from >U0201,u
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L034A     ; branch when carry reports an error or unsigned underflow; target L034A
                    leax      >L008A,pc ; form the address >L008A,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbra      L0349     ; continue execution at L0349
L0245               leax      >L0015,pc ; form the address >L0015,pc in x
                    tfr       x,d       ; copy the register values specified by x,d
                    ldx       #76       ; set x to the constant 76
                    ldy       #2        ; set y to the constant 2
                    pshs      u         ; save u on the stack
                    leau      >U0212,u  ; form the workspace or data address >U0212,u in u
                    os9       F$CpyMem  ; invoke the OS-9 F$CpyMem service
                    lbcs      L034A     ; branch when carry reports an error or unsigned underflow; target L034A
                    puls      u         ; restore u from the stack
                    leax      >L0015,pc ; form the address >L0015,pc in x
                    tfr       x,d       ; copy the register values specified by x,d
                    ldx       >U0212,u  ; load x from >U0212,u
                    ldy       #64       ; set y to the constant 64
                    pshs      u         ; save u on the stack
                    leau      >U0212,u  ; form the workspace or data address >U0212,u in u
                    os9       F$CpyMem  ; invoke the OS-9 F$CpyMem service
                    puls      u         ; restore u from the stack
                    leax      >U0212,u  ; form the address >U0212,u in x
                    tfr       x,d       ; copy the register values specified by x,d
                    ldx       #136      ; set x to the constant 136
                    ldy       #2        ; set y to the constant 2
                    pshs      u         ; save u on the stack
                    leau      >U0204,u  ; form the workspace or data address >U0204,u in u
                    os9       F$CpyMem  ; invoke the OS-9 F$CpyMem service
                    lbcs      L034A     ; branch when carry reports an error or unsigned underflow; target L034A
                    puls      u         ; restore u from the stack
                    leax      >U0212,u  ; form the address >U0212,u in x
                    tfr       x,d       ; copy the register values specified by x,d
                    ldx       >U0204,u  ; load x from >U0204,u
                    ldy       #64       ; set y to the constant 64
                    pshs      u         ; save u on the stack
                    leau      >U0252,u  ; form the workspace or data address >U0252,u in u
                    os9       F$CpyMem  ; invoke the OS-9 F$CpyMem service
                    lbcs      L034A     ; branch when carry reports an error or unsigned underflow; target L034A
                    puls      u         ; restore u from the stack
                    ldb       <U0031,u  ; load b from <U0031,u
                    lsrb                ; shift b right logically
                    lsrb                ; shift b right logically
                    leax      >U0252,u  ; form the address >U0252,u in x
                    lda       b,x       ; load a from b,x
                    pshs      a         ; save a on the stack
                    ldb       <U0031,u  ; load b from <U0031,u
                    andb      #3        ; mask b using #3
                    lda       #64       ; set a to the constant 64
                    mul                 ; multiply a by b and return the product in d
                    puls      a         ; restore a from the stack
                    addb      #3        ; add to b using #3
                    tfr       d,x       ; copy the register values specified by d,x
                    leay      >U0212,u  ; form the address >U0212,u in y
                    tfr       y,d       ; copy the register values specified by y,d
                    ldy       #2        ; set y to the constant 2
                    pshs      u         ; save u on the stack
                    leau      >U0206,u  ; form the workspace or data address >U0206,u in u
                    os9       F$CpyMem  ; invoke the OS-9 F$CpyMem service
                    puls      u         ; restore u from the stack
                    ldx       >U0206,u  ; load x from >U0206,u
                    leax      $04,x     ; form the address $04,x in x
                    leay      >U0212,u  ; form the address >U0212,u in y
                    tfr       y,d       ; copy the register values specified by y,d
                    ldy       #2        ; set y to the constant 2
                    pshs      u         ; save u on the stack
                    leau      >U0206,u  ; form the workspace or data address >U0206,u in u
                    os9       F$CpyMem  ; invoke the OS-9 F$CpyMem service
                    puls      u         ; restore u from the stack
                    leax      >U0212,u  ; form the address >U0212,u in x
                    tfr       x,d       ; copy the register values specified by x,d
                    ldx       >U0206,u  ; load x from >U0206,u
                    leax      $04,x     ; form the address $04,x in x
                    ldy       #2        ; set y to the constant 2
                    pshs      u         ; save u on the stack
                    leau      >U0208,u  ; form the workspace or data address >U0208,u in u
                    os9       F$CpyMem  ; invoke the OS-9 F$CpyMem service
                    puls      u         ; restore u from the stack
                    ldx       >U0206,u  ; load x from >U0206,u
                    ldd       >U0208,u  ; load d from >U0208,u
                    leax      d,x       ; form the address d,x in x
                    leay      >U0212,u  ; form the address >U0212,u in y
                    tfr       y,d       ; copy the register values specified by y,d
                    ldy       #64       ; set y to the constant 64
                    pshs      u         ; save u on the stack
                    leau      >U0293,u  ; form the workspace or data address >U0293,u in u
                    os9       F$CpyMem  ; invoke the OS-9 F$CpyMem service
                    puls      u         ; restore u from the stack
                    leax      >U0293,u  ; form the address >U0293,u in x
L033C               lda       ,x+       ; load a from ,x+
                    bpl       L033C     ; branch when the result is nonnegative; target L033C
                    anda      #127      ; mask a using #127
                    sta       -$01,x    ; store a at -$01,x
                    lda       #13       ; set a to the constant 13
                    sta       0,x       ; store a at 0,x
                    rts                 ; return to the caller
L0349               clrb                ; clear b to zero and set the condition codes
L034A               os9       F$Exit    ; invoke the OS-9 F$Exit service
L034D               pshs      y         ; save y on the stack
L034F               lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      L043E     ; branch when the values are equal or the result is zero; target L043E
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L034F     ; branch when carry reports an error or unsigned underflow; target L034F
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L034F     ; branch when the unsigned value is higher; target L034F
                    leax      -$01,x    ; form the address -$01,x in x
L0361               lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L036D     ; branch when carry reports an error or unsigned underflow; target L036D
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L036D     ; branch when the unsigned value is higher; target L036D
                    bra       L0361     ; continue execution at L0361
L036D               pshs      x         ; save x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    clr       >U020C,u  ; clear >U020C,u to zero and set the condition codes
                    clr       >U020D,u  ; clear >U020D,u to zero and set the condition codes
                    ldd       #1        ; set d to the constant 1
                    std       >U020E,u  ; store d at >U020E,u
L0380               lda       ,-x       ; load a from ,-x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L03CA     ; branch when carry reports an error or unsigned underflow; target L03CA
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L03CA     ; branch when the unsigned value is higher; target L03CA
                    suba      #48       ; subtract from a using #48
                    sta       >U0203,u  ; store a at >U0203,u
                    ldd       #0        ; set d to the constant 0
L0393               tst       >U0203,u  ; set condition codes from >U0203,u without changing it
                    beq       L03A3     ; branch when the values are equal or the result is zero; target L03A3
                    addd      >U020E,u  ; add to d using >U020E,u
                    dec       >U0203,u  ; decrement the value at >U0203,u
                    bra       L0393     ; continue execution at L0393
L03A3               addd      >U020C,u  ; add to d using >U020C,u
                    std       >U020C,u  ; store d at >U020C,u
                    lda       #10       ; set a to the constant 10
                    sta       >U0203,u  ; store a at >U0203,u
                    ldd       #0        ; set d to the constant 0
L03B4               tst       >U0203,u  ; set condition codes from >U0203,u without changing it
                    beq       L03C4     ; branch when the values are equal or the result is zero; target L03C4
                    addd      >U020E,u  ; add to d using >U020E,u
                    dec       >U0203,u  ; decrement the value at >U0203,u
                    bra       L03B4     ; continue execution at L03B4
L03C4               std       >U020E,u  ; store d at >U020E,u
                    bra       L0380     ; continue execution at L0380
L03CA               ldd       >U020C,u  ; load d from >U020C,u
                    puls      x         ; restore x from the stack
                    puls      pc,y      ; restore pc,y and return to the caller
                    fcb       $ED       ; store byte data
                    fcb       $C9       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $0C       ; store byte data
                    fcb       $86       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $A7       ; store byte data
                    fcb       $84       ; store byte data
                    fcb       $A7       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $A7       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $A7       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $A7       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $C9       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $0E       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $C9       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $0C       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $39       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $E8       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $C9       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $0E       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $C9       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $0C       ; store byte data
                    fcb       $8D       ; store byte data
                    fcb       $2C       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $C9       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $0E       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $C9       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $0C       ; store byte data
                    fcb       $8D       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $0A       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $C9       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $0E       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $C9       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $0C       ; store byte data
                    fcb       $8D       ; store byte data
                    fcb       $12       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $C9       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $0E       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $C9       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $0C       ; store byte data
                    fcb       $8D       ; store byte data
                    fcb       $05       ; store byte data
                    fcb       $86       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $A7       ; store byte data
                    fcb       $84       ; store byte data
                    fcb       $39       ; store byte data
                    fcb       $A3       ; store byte data
                    fcb       $C9       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $0E       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $6C       ; store byte data
                    fcb       $84       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $F6       ; store byte data
                    fcb       $E3       ; store byte data
                    fcb       $C9       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $0E       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $C9       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $0C       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $39       ; store byte data
L043E               ldb       #1        ; set b to the constant 1
                    lbra      L034A     ; continue execution at L034A

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
