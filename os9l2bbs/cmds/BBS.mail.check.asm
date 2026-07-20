**********************************************************************
* BBS.mail.check - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       BBS.mail.check
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

U0000               rmb       3         ; reserve 3 byte(s) in the module workspace
U0003               rmb       1         ; reserve 1 byte(s) in the module workspace
U0004               rmb       2         ; reserve 2 byte(s) in the module workspace
U0006               rmb       1         ; reserve 1 byte(s) in the module workspace
U0007               rmb       3         ; reserve 3 byte(s) in the module workspace
U000A               rmb       1         ; reserve 1 byte(s) in the module workspace
U000B               rmb       1         ; reserve 1 byte(s) in the module workspace
U000C               rmb       2         ; reserve 2 byte(s) in the module workspace
U000E               rmb       34        ; reserve 34 byte(s) in the module workspace
U0030               rmb       64        ; reserve 64 byte(s) in the module workspace
U0070               rmb       160       ; reserve 160 byte(s) in the module workspace
U0110               rmb       60        ; reserve 60 byte(s) in the module workspace
U014C               rmb       2         ; reserve 2 byte(s) in the module workspace
U014E               rmb       1         ; reserve 1 byte(s) in the module workspace
U014F               rmb       201       ; reserve 201 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.mail.check/ ; store an OS-9 high-bit-terminated string
                    fcc       "Copyright (C) 1988" ; store literal character data
                    fcc       "By Keith Alphonso" ; store literal character data
                    fcc       "Licenced to Alpha Software Technologies" ; store literal character data
                    fcc       "All rights reserved" ; store literal character data
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
L0086               fcc       "BBS.mail.inx" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcc       "BBS.mail" ; store literal character data
                    fcb       $0D       ; store byte data
L009C               fcc       "/dd/bbs/BBS.alias" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
L00B0               fcb       $0A       ; store byte data
                    fcc       "Checking mailbox..." ; store literal character data
                    fcb       $0D       ; store byte data
L00C5               fcb       $0A       ; store byte data
                    fcc       "All previously sent mail has been read." ; store literal character data
                    fcb       $0D       ; store byte data
L00EE               fcc       "Mail to " ; store literal character data
L00F6               fcc       " has not yet been read." ; store literal character data
                    fcb       $0D       ; store byte data

start               os9       F$ID      ; invoke the OS-9 F$ID service
                    sty       U000E,u   ; store y at U000E,u
                    ldy       #0        ; set y to the constant 0
                    os9       F$SUser   ; invoke the OS-9 F$SUser service
                    leax      >L0086,pc ; form the address >L0086,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L01F3     ; branch when carry reports an error or unsigned underflow; target L01F3
                    sta       U0000,u   ; store a at U0000,u
                    clr       U0004,u   ; clear U0004,u to zero and set the condition codes
                    leax      >L009C,pc ; form the address >L009C,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L01F3     ; branch when carry reports an error or unsigned underflow; target L01F3
                    sta       U0007,u   ; store a at U0007,u
                    leax      >L00B0,pc ; form the address >L00B0,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      <U0030,u  ; form the address <U0030,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       U0000,u   ; load a from U0000,u
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lbcs      L01F3     ; branch when carry reports an error or unsigned underflow; target L01F3
L0158               leax      >U0110,u  ; form the address >U0110,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       U0000,u   ; load a from U0000,u
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    bcs       L0172     ; branch when carry reports an error or unsigned underflow; target L0172
                    ldd       >U014C,u  ; load d from >U014C,u
                    cmpd      U000E,u   ; compare d with U000E,u and set the condition codes
                    bne       L0158     ; branch when the values differ or the result is nonzero; target L0158
                    bra       L018F     ; continue execution at L018F
L0172               cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      L01F3     ; branch when the values differ or the result is nonzero; target L01F3
                    tst       U0004,u   ; set condition codes from U0004,u without changing it
                    beq       L017F     ; branch when the values are equal or the result is zero; target L017F
                    lbra      L01F2     ; continue execution at L01F2
L017F               leax      >L00C5,pc ; form the address >L00C5,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbra      L01F2     ; continue execution at L01F2
L018F               inc       <U0004    ; increment the value at <U0004
                    pshs      u         ; save u on the stack
                    lda       U0007,u   ; load a from U0007,u
                    ldx       #0        ; set x to the constant 0
                    ldu       #0        ; set u to the constant 0
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    puls      u         ; restore u from the stack
                    lbcs      L01F3     ; branch when carry reports an error or unsigned underflow; target L01F3
L01A4               lda       U0007,u   ; load a from U0007,u
                    ldy       #200      ; set y to the constant 200
                    leax      <U0070,u  ; form the address <U0070,u in x
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    lbcs      L0158     ; branch when carry reports an error or unsigned underflow; target L0158
                    clr       U0006,u   ; clear U0006,u to zero and set the condition codes
L01B6               inc       U0006,u   ; increment the value at U0006,u
                    lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    bne       L01B6     ; branch when the values differ or the result is nonzero; target L01B6
                    dec       U0006,u   ; decrement the value at U0006,u
                    lbsr      L0200     ; call subroutine L0200
                    cmpd      >U014E,u  ; compare d with >U014E,u and set the condition codes
                    bne       L01A4     ; branch when the values differ or the result is nonzero; target L01A4
                    leax      >L00EE,pc ; form the address >L00EE,pc in x
                    ldy       #8        ; set y to the constant 8
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      <U0070,u  ; form the address <U0070,u in x
                    ldb       U0006,u   ; load b from U0006,u
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      >L00F6,pc ; form the address >L00F6,pc in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbra      L0158     ; continue execution at L0158
L01F2               clrb                ; clear b to zero and set the condition codes
L01F3               pshs      b         ; save b on the stack
                    ldy       U000E,u   ; load y from U000E,u
                    os9       F$SUser   ; invoke the OS-9 F$SUser service
                    puls      b         ; restore b from the stack
                    os9       F$Exit    ; invoke the OS-9 F$Exit service
L0200               pshs      y         ; save y on the stack
L0202               lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      L02D5     ; branch when the values are equal or the result is zero; target L02D5
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L0202     ; branch when carry reports an error or unsigned underflow; target L0202
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L0202     ; branch when the unsigned value is higher; target L0202
                    leax      -$01,x    ; form the address -$01,x in x
L0214               lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L0220     ; branch when carry reports an error or unsigned underflow; target L0220
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L0220     ; branch when the unsigned value is higher; target L0220
                    bra       L0214     ; continue execution at L0214
L0220               pshs      x         ; save x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    clr       U000A,u   ; clear U000A,u to zero and set the condition codes
                    clr       U000B,u   ; clear U000B,u to zero and set the condition codes
                    ldd       #1        ; set d to the constant 1
                    std       U000C,u   ; store d at U000C,u
L022D               lda       ,-x       ; load a from ,-x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L0261     ; branch when carry reports an error or unsigned underflow; target L0261
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L0261     ; branch when the unsigned value is higher; target L0261
                    suba      #48       ; subtract from a using #48
                    sta       U0003,u   ; store a at U0003,u
                    ldd       #0        ; set d to the constant 0
L023E               tst       U0003,u   ; set condition codes from U0003,u without changing it
                    beq       L0248     ; branch when the values are equal or the result is zero; target L0248
                    addd      U000C,u   ; add to d using U000C,u
                    dec       U0003,u   ; decrement the value at U0003,u
                    bra       L023E     ; continue execution at L023E
L0248               addd      U000A,u   ; add to d using U000A,u
                    std       U000A,u   ; store d at U000A,u
                    lda       #10       ; set a to the constant 10
                    sta       U0003,u   ; store a at U0003,u
                    ldd       #0        ; set d to the constant 0
L0253               tst       U0003,u   ; set condition codes from U0003,u without changing it
                    beq       L025D     ; branch when the values are equal or the result is zero; target L025D
                    addd      U000C,u   ; add to d using U000C,u
                    dec       U0003,u   ; decrement the value at U0003,u
                    bra       L0253     ; continue execution at L0253
L025D               std       U000C,u   ; store d at U000C,u
                    bra       L022D     ; continue execution at L022D
L0261               ldd       U000A,u   ; load d from U000A,u
                    puls      x         ; restore x from the stack
                    puls      pc,y      ; restore pc,y and return to the caller

                    pshs      x         ; save x on the stack
                    std       U000A,u   ; store d at U000A,u
                    lda       #48       ; set a to the constant 48
                    sta       0,x       ; store a at 0,x
                    sta       $01,x     ; store a at $01,x
                    sta       $02,x     ; store a at $02,x
                    sta       $03,x     ; store a at $03,x
                    sta       $04,x     ; store a at $04,x
                    ldd       #10000    ; set d to the constant 10000
                    std       U000C,u   ; store d at U000C,u
                    ldd       U000A,u   ; load d from U000A,u
                    lbsr      L02C6     ; call subroutine L02C6
                    ldd       #1000     ; set d to the constant 1000
                    std       U000C,u   ; store d at U000C,u
                    ldd       U000A,u   ; load d from U000A,u
                    bsr       L02C6     ; call subroutine L02C6
                    ldd       #100      ; set d to the constant 100
                    std       U000C,u   ; store d at U000C,u
                    ldd       U000A,u   ; load d from U000A,u
                    bsr       L02C6     ; call subroutine L02C6
                    ldd       #10       ; set d to the constant 10
                    std       U000C,u   ; store d at U000C,u
                    ldd       U000A,u   ; load d from U000A,u
                    bsr       L02C6     ; call subroutine L02C6
                    ldd       #1        ; set d to the constant 1
                    std       U000C,u   ; store d at U000C,u
                    ldd       U000A,u   ; load d from U000A,u
                    bsr       L02C6     ; call subroutine L02C6
                    lda       #13       ; set a to the constant 13
                    sta       0,x       ; store a at 0,x
                    puls      x         ; restore x from the stack
                    ldb       #32       ; set b to the constant 32
L02AD               lda       0,x       ; load a from 0,x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bne       L02B7     ; branch when the values differ or the result is nonzero; target L02B7
                    stb       ,x+       ; store b at ,x+
                    bra       L02AD     ; continue execution at L02AD
L02B7               lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L02C3     ; branch when carry reports an error or unsigned underflow; target L02C3
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L02C3     ; branch when the unsigned value is higher; target L02C3
                    bra       L02B7     ; continue execution at L02B7
L02C3               leax      -$01,x    ; form the address -$01,x in x
                    rts                 ; return to the caller
L02C6               subd      U000C,u   ; subtract from d using U000C,u
                    bcs       L02CE     ; branch when carry reports an error or unsigned underflow; target L02CE
                    inc       0,x       ; increment the value at 0,x
                    bra       L02C6     ; continue execution at L02C6
L02CE               addd      U000C,u   ; add to d using U000C,u
                    std       U000A,u   ; store d at U000A,u
                    leax      $01,x     ; form the address $01,x in x
                    rts                 ; return to the caller
L02D5               ldd       #-1       ; set d to the constant -1
                    puls      pc,y      ; restore pc,y and return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
