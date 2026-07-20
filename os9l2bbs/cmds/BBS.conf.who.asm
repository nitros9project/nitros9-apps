**********************************************************************
* BBS.conf.who - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       BBS.conf.who
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
U0004               rmb       1         ; reserve 1 byte(s) in the module workspace
U0005               rmb       1         ; reserve 1 byte(s) in the module workspace
U0006               rmb       2         ; reserve 2 byte(s) in the module workspace
dataddr             rmb       2         ; reserve 2 byte(s) in the module workspace
U000A               rmb       2         ; reserve 2 byte(s) in the module workspace
U000C               rmb       200       ; reserve 200 byte(s) in the module workspace
U00D4               rmb       1         ; reserve 1 byte(s) in the module workspace
U00D5               rmb       599       ; reserve 599 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.conf.who/ ; store an OS-9 high-bit-terminated string
confdat             fcc       "Conf.dat" ; store literal character data
                    fcb       $0D       ; store byte data
bbsalias            fcc       "/dd/bbs/BBS.alias" ; store literal character data
                    fcb       $0D       ; store byte data
noone               fcc       "No one is in conference" ; store literal character data
                    fcb       $0D       ; store byte data
these               fcc       "These people are in conference" ; store literal character data
                    fcb       $0D       ; store byte data
line                fcc       "------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data

start               leax      >confdat,pc ; form the address >confdat,pc in x
                    lda       #65       ; set a to the constant 65
                    pshs      u         ; save u on the stack
                    os9       F$Link    ; Link to Conf.dat
                    lbcs      L00E6     ; Branch if conference empty
                    tfr       u,d       ; Move module offset to D
                    puls      u         ; restore u from the stack
                    std       dataddr,u ; Save module offset
                    sty       U000A,u   ; store y at U000A,u
                    leax      >these,pc ; form the address >these,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >line,pc  ; form the address >line,pc in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    ldx       U000A,u   ; load x from U000A,u
L00BC               ldd       ,x++      ; load d from ,x++
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    beq       L00D8     ; branch when the values are equal or the result is zero; target L00D8
                    leax      $01,x     ; form the address $01,x in x
                    cmpd      #0        ; compare d with #0 and set the condition codes
                    beq       L00BC     ; branch when the values are equal or the result is zero; target L00BC
                    pshs      x         ; save x on the stack
                    subd      #1        ; subtract from d using #1
                    lbsr      L00F7     ; call subroutine L00F7
                    puls      x         ; restore x from the stack
                    bra       L00BC     ; continue execution at L00BC
L00D8               clrb                ; clear b to zero and set the condition codes
                    pshs      u         ; save u on the stack
                    ldu       dataddr,u ; load u from dataddr,u
                    os9       F$UnLink  ; invoke the OS-9 F$UnLink service
                    puls      u         ; restore u from the stack
                    clrb                ; clear b to zero and set the condition codes
                    os9       F$Exit    ; invoke the OS-9 F$Exit service
L00E6               leax      >noone,pc ; form the address >noone,pc in x
                    lda       #1        ; set a to the constant 1
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    clrb                ; clear b to zero and set the condition codes
                    os9       F$Exit    ; invoke the OS-9 F$Exit service
L00F7               std       U0002,u   ; store d at U0002,u
                    leax      >bbsalias,pc ; form the address >bbsalias,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L0203     ; branch when carry reports an error or unsigned underflow; target L0203
                    sta       U0000,u   ; store a at U0000,u
L0108               leax      U000C,u   ; form the address U000C,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       U0000,u   ; load a from U0000,u
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    lbcs      L0203     ; branch when carry reports an error or unsigned underflow; target L0203
L0117               lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    bne       L0117     ; branch when the values differ or the result is nonzero; target L0117
                    lbsr      L0147     ; call subroutine L0147
                    cmpd      U0002,u   ; compare d with U0002,u and set the condition codes
                    bne       L0108     ; branch when the values differ or the result is nonzero; target L0108
                    leax      U000C,u   ; form the address U000C,u in x
                    leay      >U00D4,u  ; form the address >U00D4,u in y
L012B               lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    beq       L0135     ; branch when the values are equal or the result is zero; target L0135
                    sta       ,y+       ; store a at ,y+
                    bra       L012B     ; continue execution at L012B
L0135               lda       #13       ; set a to the constant 13
                    sta       0,y       ; store a at 0,y
                    leax      >U00D4,u  ; form the address >U00D4,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    rts                 ; return to the caller
L0147               pshs      y         ; save y on the stack
L0149               lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      L01FE     ; branch when the values are equal or the result is zero; target L01FE
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L0149     ; branch when carry reports an error or unsigned underflow; target L0149
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L0149     ; branch when the unsigned value is higher; target L0149
                    leax      -$01,x    ; form the address -$01,x in x
L015B               lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L0167     ; branch when carry reports an error or unsigned underflow; target L0167
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L0167     ; branch when the unsigned value is higher; target L0167
                    bra       L015B     ; continue execution at L015B
L0167               pshs      x         ; save x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    clr       U0004,u   ; clear U0004,u to zero and set the condition codes
                    clr       U0005,u   ; clear U0005,u to zero and set the condition codes
                    ldd       #1        ; set d to the constant 1
                    std       U0006,u   ; store d at U0006,u
L0174               lda       ,-x       ; load a from ,-x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L01A8     ; branch when carry reports an error or unsigned underflow; target L01A8
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L01A8     ; branch when the unsigned value is higher; target L01A8
                    suba      #48       ; subtract from a using #48
                    sta       U0001,u   ; store a at U0001,u
                    ldd       #0        ; set d to the constant 0
L0185               tst       U0001,u   ; set condition codes from U0001,u without changing it
                    beq       L018F     ; branch when the values are equal or the result is zero; target L018F
                    addd      U0006,u   ; add to d using U0006,u
                    dec       U0001,u   ; decrement the value at U0001,u
                    bra       L0185     ; continue execution at L0185
L018F               addd      U0004,u   ; add to d using U0004,u
                    std       U0004,u   ; store d at U0004,u
                    lda       #10       ; set a to the constant 10
                    sta       U0001,u   ; store a at U0001,u
                    ldd       #0        ; set d to the constant 0
L019A               tst       U0001,u   ; set condition codes from U0001,u without changing it
                    beq       L01A4     ; branch when the values are equal or the result is zero; target L01A4
                    addd      U0006,u   ; add to d using U0006,u
                    dec       U0001,u   ; decrement the value at U0001,u
                    bra       L019A     ; continue execution at L019A
L01A4               std       U0006,u   ; store d at U0006,u
                    bra       L0174     ; continue execution at L0174
L01A8               ldd       U0004,u   ; load d from U0004,u
                    puls      x         ; restore x from the stack
                    puls      pc,y      ; restore pc,y and return to the caller

unused              std       U0004,u   ; store d at U0004,u
                    lda       #48       ; set a to the constant 48
                    sta       0,x       ; store a at 0,x
                    sta       $01,x     ; store a at $01,x
                    sta       $02,x     ; store a at $02,x
                    sta       $03,x     ; store a at $03,x
                    sta       $04,x     ; store a at $04,x
                    ldd       #10000    ; set d to the constant 10000
                    std       U0006,u   ; store d at U0006,u
                    ldd       U0004,u   ; load d from U0004,u
                    lbsr      L01EF     ; call subroutine L01EF
                    ldd       #1000     ; set d to the constant 1000
                    std       U0006,u   ; store d at U0006,u
                    ldd       U0004,u   ; load d from U0004,u
                    bsr       L01EF     ; call subroutine L01EF
                    ldd       #100      ; set d to the constant 100
                    std       U0006,u   ; store d at U0006,u
                    ldd       U0004,u   ; load d from U0004,u
                    bsr       L01EF     ; call subroutine L01EF
                    ldd       #10       ; set d to the constant 10
                    std       U0006,u   ; store d at U0006,u
                    ldd       U0004,u   ; load d from U0004,u
                    bsr       L01EF     ; call subroutine L01EF
                    ldd       #1        ; set d to the constant 1
                    std       U0006,u   ; store d at U0006,u
                    ldd       U0004,u   ; load d from U0004,u
                    bsr       L01EF     ; call subroutine L01EF
                    lda       #13       ; set a to the constant 13
                    sta       0,x       ; store a at 0,x
                    rts                 ; return to the caller
L01EF               subd      U0006,u   ; subtract from d using U0006,u
                    bcs       L01F7     ; branch when carry reports an error or unsigned underflow; target L01F7
                    inc       0,x       ; increment the value at 0,x
                    bra       L01EF     ; continue execution at L01EF
L01F7               addd      U0006,u   ; add to d using U0006,u
                    std       U0004,u   ; store d at U0004,u
                    leax      $01,x     ; form the address $01,x in x
                    rts                 ; return to the caller
L01FE               lda       #1        ; set a to the constant 1
                    bra       L0203     ; continue execution at L0203
                    fcb       $5F       ; store byte data
L0203               os9       F$Exit    ; invoke the OS-9 F$Exit service

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
