**********************************************************************
* BBS.who - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       BBS.who
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
U0005               rmb       2         ; reserve 2 byte(s) in the module workspace
U0007               rmb       2         ; reserve 2 byte(s) in the module workspace
U0009               rmb       200       ; reserve 200 byte(s) in the module workspace
U00D1               rmb       200       ; reserve 200 byte(s) in the module workspace
U0199               rmb       1         ; reserve 1 byte(s) in the module workspace
U019A               rmb       911       ; reserve 911 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.who/ ; store an OS-9 high-bit-terminated string
L0014               fcc       "Unknown User" ; store literal character data
                    fcb       $0D       ; store byte data
L0021               fcc       "/dd/bbs/BBS.alias" ; store literal character data
                    fcb       $0D       ; store byte data
L0033               fcc       "The following users are on-line" ; store literal character data
                    fcb       $0D       ; store byte data
L0053               fcc       "-------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
start               clra                ; clear a to zero and set the condition codes
                    leax      >U00D1,u  ; form the address >U00D1,u in x
                    ldb       #200      ; set b to the constant 200
L007A               sta       ,x+       ; store a at ,x+
                    decb                ; decrement b
                    bne       L007A     ; branch when the values differ or the result is nonzero; target L007A
                    clr       U0001,u   ; clear U0001,u to zero and set the condition codes
                    leax      >L0021,pc ; form the address >L0021,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L012E     ; branch when carry reports an error or unsigned underflow; target L012E
                    sta       U0000,u   ; store a at U0000,u
                    leax      >L0033,pc ; form the address >L0033,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L0053,pc ; form the address >L0053,pc in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
L00A8               leax      >U0199,u  ; form the address >U0199,u in x
                    lda       U0001,u   ; load a from U0001,u
                    os9       F$GPrDsc  ; invoke the OS-9 F$GPrDsc service
                    bcs       L00B7     ; branch when carry reports an error or unsigned underflow; target L00B7
                    ldd       $08,x     ; load d from $08,x
                    bsr       L00C3     ; call subroutine L00C3
L00B7               lda       U0001,u   ; load a from U0001,u
                    inca                ; increment a
                    sta       U0001,u   ; store a at U0001,u
                    cmpa      #255      ; compare a with #255 and set the condition codes
                    bcs       L00A8     ; branch when carry reports an error or unsigned underflow; target L00A8
                    lbra      L012D     ; continue execution at L012D
L00C3               leax      >U00D1,u  ; form the address >U00D1,u in x
L00C7               cmpd      0,x       ; compare d with 0,x and set the condition codes
                    beq       L00D6     ; branch when the values are equal or the result is zero; target L00D6
                    pshs      d         ; save d on the stack
                    ldd       ,x++      ; load d from ,x++
                    beq       L00D7     ; branch when the values are equal or the result is zero; target L00D7
                    puls      d         ; restore d from the stack
                    bra       L00C7     ; continue execution at L00C7
L00D6               rts                 ; return to the caller
L00D7               puls      d         ; restore d from the stack
                    std       -$02,x    ; store d at -$02,x
                    std       U0005,u   ; store d at U0005,u
                    lda       U0000,u   ; load a from U0000,u
                    pshs      u         ; save u on the stack
                    ldu       #0        ; set u to the constant 0
                    ldx       #0        ; set x to the constant 0
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    puls      u         ; restore u from the stack
L00EC               lda       U0000,u   ; load a from U0000,u
                    leax      U0009,u   ; form the address U0009,u in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    bcs       L0113     ; branch when carry reports an error or unsigned underflow; target L0113
L00F9               lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    beq       L0105     ; branch when the values are equal or the result is zero; target L0105
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       L00F9     ; branch when the values differ or the result is nonzero; target L00F9
                    bra       L00EC     ; continue execution at L00EC
L0105               lda       #13       ; set a to the constant 13
                    sta       -$01,x    ; store a at -$01,x
                    lbsr      L0131     ; call subroutine L0131
                    cmpd      U0005,u   ; compare d with U0005,u and set the condition codes
                    beq       L0121     ; branch when the values are equal or the result is zero; target L0121
                    bra       L00EC     ; continue execution at L00EC
L0113               leax      >L0014,pc ; form the address >L0014,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    rts                 ; return to the caller
L0121               leax      U0009,u   ; form the address U0009,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    rts                 ; return to the caller
L012D               clrb                ; clear b to zero and set the condition codes
L012E               os9       F$Exit    ; invoke the OS-9 F$Exit service
L0131               pshs      y         ; save y on the stack
L0133               lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      L01E8     ; branch when the values are equal or the result is zero; target L01E8
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L0133     ; branch when carry reports an error or unsigned underflow; target L0133
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L0133     ; branch when the unsigned value is higher; target L0133
                    leax      -$01,x    ; form the address -$01,x in x
L0145               lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L0151     ; branch when carry reports an error or unsigned underflow; target L0151
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L0151     ; branch when the unsigned value is higher; target L0151
                    bra       L0145     ; continue execution at L0145
L0151               pshs      x         ; save x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    clr       U0003,u   ; clear U0003,u to zero and set the condition codes
                    clr       U0004,u   ; clear U0004,u to zero and set the condition codes
                    ldd       #1        ; set d to the constant 1
                    std       U0007,u   ; store d at U0007,u
L015E               lda       ,-x       ; load a from ,-x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L0192     ; branch when carry reports an error or unsigned underflow; target L0192
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L0192     ; branch when the unsigned value is higher; target L0192
                    suba      #48       ; subtract from a using #48
                    sta       U0002,u   ; store a at U0002,u
                    ldd       #0        ; set d to the constant 0
L016F               tst       U0002,u   ; set condition codes from U0002,u without changing it
                    beq       L0179     ; branch when the values are equal or the result is zero; target L0179
                    addd      U0007,u   ; add to d using U0007,u
                    dec       U0002,u   ; decrement the value at U0002,u
                    bra       L016F     ; continue execution at L016F
L0179               addd      U0003,u   ; add to d using U0003,u
                    std       U0003,u   ; store d at U0003,u
                    lda       #10       ; set a to the constant 10
                    sta       U0002,u   ; store a at U0002,u
                    ldd       #0        ; set d to the constant 0
L0184               tst       U0002,u   ; set condition codes from U0002,u without changing it
                    beq       L018E     ; branch when the values are equal or the result is zero; target L018E
                    addd      U0007,u   ; add to d using U0007,u
                    dec       U0002,u   ; decrement the value at U0002,u
                    bra       L0184     ; continue execution at L0184
L018E               std       U0007,u   ; store d at U0007,u
                    bra       L015E     ; continue execution at L015E
L0192               ldd       U0003,u   ; load d from U0003,u
                    puls      x         ; restore x from the stack
                    puls      pc,y      ; restore pc,y and return to the caller
                    fcb       $ED       ; store byte data
                    fcb       $43       ; store byte data
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
                    fcb       $47       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $43       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $29       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $E8       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $47       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $43       ; store byte data
                    fcb       $8D       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $47       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $43       ; store byte data
                    fcb       $8D       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $0A       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $47       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $43       ; store byte data
                    fcb       $8D       ; store byte data
                    fcb       $0E       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $47       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $43       ; store byte data
                    fcb       $8D       ; store byte data
                    fcb       $05       ; store byte data
                    fcb       $86       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $A7       ; store byte data
                    fcb       $84       ; store byte data
                    fcb       $39       ; store byte data
                    fcb       $A3       ; store byte data
                    fcb       $47       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $6C       ; store byte data
                    fcb       $84       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $F8       ; store byte data
                    fcb       $E3       ; store byte data
                    fcb       $47       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $43       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $39       ; store byte data
L01E8               ldd       #0        ; set d to the constant 0
                    rts                 ; return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
