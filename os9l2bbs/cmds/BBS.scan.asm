**********************************************************************
* BBS.scan - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       BBS.scan
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
U0007               rmb       2         ; reserve 2 byte(s) in the module workspace
U0009               rmb       6         ; reserve 6 byte(s) in the module workspace
U000F               rmb       3         ; reserve 3 byte(s) in the module workspace
U0012               rmb       1         ; reserve 1 byte(s) in the module workspace
U0013               rmb       2         ; reserve 2 byte(s) in the module workspace
U0015               rmb       1         ; reserve 1 byte(s) in the module workspace
U0016               rmb       6         ; reserve 6 byte(s) in the module workspace
U001C               rmb       1         ; reserve 1 byte(s) in the module workspace
U001D               rmb       1         ; reserve 1 byte(s) in the module workspace
U001E               rmb       2         ; reserve 2 byte(s) in the module workspace
U0020               rmb       1         ; reserve 1 byte(s) in the module workspace
U0021               rmb       1         ; reserve 1 byte(s) in the module workspace
U0022               rmb       1         ; reserve 1 byte(s) in the module workspace
U0023               rmb       1         ; reserve 1 byte(s) in the module workspace
U0024               rmb       1         ; reserve 1 byte(s) in the module workspace
U0025               rmb       1         ; reserve 1 byte(s) in the module workspace
U0026               rmb       1         ; reserve 1 byte(s) in the module workspace
U0027               rmb       1         ; reserve 1 byte(s) in the module workspace
U0028               rmb       1         ; reserve 1 byte(s) in the module workspace
U0029               rmb       64        ; reserve 64 byte(s) in the module workspace
U0069               rmb       4         ; reserve 4 byte(s) in the module workspace
U006D               rmb       20        ; reserve 20 byte(s) in the module workspace
U0081               rmb       30        ; reserve 30 byte(s) in the module workspace
U009F               rmb       1         ; reserve 1 byte(s) in the module workspace
U00A0               rmb       1         ; reserve 1 byte(s) in the module workspace
U00A1               rmb       1         ; reserve 1 byte(s) in the module workspace
U00A2               rmb       205       ; reserve 205 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.scan/ ; store an OS-9 high-bit-terminated string
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
L0080               fcc       "High message is #" ; store literal character data
L0091               fcb       $00       ; store byte data
                    fcb       $11       ; store byte data
L0093               fcc       "Enter starting message #" ; store literal character data
                    fcb       $0D       ; store byte data
L00AC               fcc       ">" ; store literal character data
L00AD               fcc       "Msg #    User name              Date        Subject" ; store literal character data
                    fcb       $0D       ; store byte data
L00E1               fcc       "----------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
L0122               fcc       "BBS.msg.inx" ; store literal character data
                    fcb       $0D       ; store byte data
L012E               fcc       "                                       " ; store literal character data
L0155               fcc       "          ******   DELETED   ******" ; store literal character data
                    fcb       $0D       ; store byte data
start               leax      >L0122,pc ; form the address >L0122,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L0369     ; branch when carry reports an error or unsigned underflow; target L0369
                    sta       U0000,u   ; store a at U0000,u
                    leax      <U0029,u  ; form the address <U0029,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       U0000,u   ; load a from U0000,u
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lbcs      L0369     ; branch when carry reports an error or unsigned underflow; target L0369
                    ldd       <U0029,u  ; load d from <U0029,u
                    leax      U0009,u   ; form the address U0009,u in x
                    lbsr      L03D3     ; call subroutine L03D3
                    leax      >L0080,pc ; form the address >L0080,pc in x
                    ldy       >L0091,pc ; load y from >L0091,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L0369     ; branch when carry reports an error or unsigned underflow; target L0369
                    leax      U0009,u   ; form the address U0009,u in x
                    ldy       #6        ; set y to the constant 6
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L0369     ; branch when carry reports an error or unsigned underflow; target L0369
                    leax      >L0093,pc ; form the address >L0093,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L0369     ; branch when carry reports an error or unsigned underflow; target L0369
                    leax      >L00AC,pc ; form the address >L00AC,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L0369     ; branch when carry reports an error or unsigned underflow; target L0369
                    leax      <U0016,u  ; form the address <U0016,u in x
                    ldy       #6        ; set y to the constant 6
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    lbcs      L0369     ; branch when carry reports an error or unsigned underflow; target L0369
                    clr       <U0015,u  ; clear <U0015,u to zero and set the condition codes
                    leax      <U0016,u  ; form the address <U0016,u in x
                    lbsr      L036C     ; call subroutine L036C
                    cmpd      #1        ; compare d with #1 and set the condition codes
                    lbcs      L0368     ; branch when carry reports an error or unsigned underflow; target L0368
                    cmpd      <U0029,u  ; compare d with <U0029,u and set the condition codes
                    lbhi      L0368     ; branch when the unsigned value is higher; target L0368
                    std       U0009,u   ; store d at U0009,u
                    clr       <U001C,u  ; clear <U001C,u to zero and set the condition codes
                    clr       <U001D,u  ; clear <U001D,u to zero and set the condition codes
                    lda       #6        ; set a to the constant 6
                    sta       U0001,u   ; store a at U0001,u
                    ldd       U0009,u   ; load d from U0009,u
L0215               aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    rol       <U001D,u  ; rotate left through carry the value at <U001D,u
                    dec       U0001,u   ; decrement the value at U0001,u
                    bne       L0215     ; branch when the values differ or the result is nonzero; target L0215
                    std       <U001E,u  ; store d at <U001E,u
                    ldx       <U001C,u  ; load x from <U001C,u
                    lda       U0000,u   ; load a from U0000,u
                    pshs      u         ; save u on the stack
                    ldu       <U001E,u  ; load u from <U001E,u
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    lbcs      L0369     ; branch when carry reports an error or unsigned underflow; target L0369
                    puls      u         ; restore u from the stack
                    leax      >L00AD,pc ; form the address >L00AD,pc in x
                    ldy       #80       ; set y to the constant 80
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L0369     ; branch when carry reports an error or unsigned underflow; target L0369
                    leax      >L00E1,pc ; form the address >L00E1,pc in x
                    ldy       #80       ; set y to the constant 80
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L0369     ; branch when carry reports an error or unsigned underflow; target L0369
L0254               lda       U0000,u   ; load a from U0000,u
                    ldy       #64       ; set y to the constant 64
                    leax      <U0069,u  ; form the address <U0069,u in x
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lbcs      L0368     ; branch when carry reports an error or unsigned underflow; target L0368
                    ldd       <U0069,u  ; load d from <U0069,u
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    lbeq      L0351     ; branch when the values are equal or the result is zero; target L0351
                    ldd       U0009,u   ; load d from U0009,u
                    leax      U000F,u   ; form the address U000F,u in x
                    lbsr      L03D3     ; call subroutine L03D3
                    ldd       U0009,u   ; load d from U0009,u
                    addd      #1        ; add to d using #1
                    std       U0009,u   ; store d at U0009,u
                    leax      U000F,u   ; form the address U000F,u in x
                    ldy       #5        ; set y to the constant 5
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L0369     ; branch when carry reports an error or unsigned underflow; target L0369
                    leax      >L012E,pc ; form the address >L012E,pc in x
                    ldy       #4        ; set y to the constant 4
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L0369     ; branch when carry reports an error or unsigned underflow; target L0369
                    leax      <U006D,u  ; form the address <U006D,u in x
                    clr       U0003,u   ; clear U0003,u to zero and set the condition codes
                    clr       U0004,u   ; clear U0004,u to zero and set the condition codes
L02A2               lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L02AC     ; branch when the values are equal or the result is zero; target L02AC
                    inc       U0004,u   ; increment the value at U0004,u
                    bra       L02A2     ; continue execution at L02A2
L02AC               leax      <U006D,u  ; form the address <U006D,u in x
                    ldy       U0003,u   ; load y from U0003,u
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L0369     ; branch when carry reports an error or unsigned underflow; target L0369
                    ldd       #22       ; set d to the constant 22
                    subd      U0003,u   ; subtract from d using U0003,u
                    tfr       d,y       ; copy the register values specified by d,y
                    leax      >L012E,pc ; form the address >L012E,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L0369     ; branch when carry reports an error or unsigned underflow; target L0369
                    leax      U000F,u   ; form the address U000F,u in x
                    ldb       >U00A0,u  ; load b from >U00A0,u
                    clra                ; clear a to zero and set the condition codes
                    lbsr      L03D3     ; call subroutine L03D3
                    lda       <U0012,u  ; load a from <U0012,u
                    sta       <U0020,u  ; store a at <U0020,u
                    lda       <U0013,u  ; load a from <U0013,u
                    sta       <U0021,u  ; store a at <U0021,u
                    lda       #47       ; set a to the constant 47
                    sta       <U0022,u  ; store a at <U0022,u
                    ldb       >U00A1,u  ; load b from >U00A1,u
                    clra                ; clear a to zero and set the condition codes
                    leax      U000F,u   ; form the address U000F,u in x
                    lbsr      L03D3     ; call subroutine L03D3
                    lda       <U0012,u  ; load a from <U0012,u
                    sta       <U0023,u  ; store a at <U0023,u
                    lda       <U0013,u  ; load a from <U0013,u
                    sta       <U0024,u  ; store a at <U0024,u
                    lda       #47       ; set a to the constant 47
                    sta       <U0025,u  ; store a at <U0025,u
                    ldb       >U009F,u  ; load b from >U009F,u
                    clra                ; clear a to zero and set the condition codes
                    leax      U000F,u   ; form the address U000F,u in x
                    lbsr      L03D3     ; call subroutine L03D3
                    lda       <U0012,u  ; load a from <U0012,u
                    sta       <U0026,u  ; store a at <U0026,u
                    lda       <U0013,u  ; load a from <U0013,u
                    sta       <U0027,u  ; store a at <U0027,u
                    lda       #13       ; set a to the constant 13
                    sta       <U0028,u  ; store a at <U0028,u
                    leax      <U0020,u  ; form the address <U0020,u in x
                    ldy       #8        ; set y to the constant 8
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L0369     ; branch when carry reports an error or unsigned underflow; target L0369
                    ldy       #5        ; set y to the constant 5
                    leax      >L012E,pc ; form the address >L012E,pc in x
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L0369     ; branch when carry reports an error or unsigned underflow; target L0369
                    leax      >U0081,u  ; form the address >U0081,u in x
                    ldy       #30       ; set y to the constant 30
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L0369     ; branch when carry reports an error or unsigned underflow; target L0369
                    lbra      L0254     ; continue execution at L0254
L0351               ldd       U0009,u   ; load d from U0009,u
                    addd      #1        ; add to d using #1
                    std       U0009,u   ; store d at U0009,u
                    leax      >L0155,pc ; form the address >L0155,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbra      L0254     ; continue execution at L0254
L0368               clrb                ; clear b to zero and set the condition codes
L0369               os9       F$Exit    ; invoke the OS-9 F$Exit service
L036C               pshs      y         ; save y on the stack
L036E               lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      L0441     ; branch when the values are equal or the result is zero; target L0441
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L036E     ; branch when carry reports an error or unsigned underflow; target L036E
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L036E     ; branch when the unsigned value is higher; target L036E
                    leax      -$01,x    ; form the address -$01,x in x
L0380               lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L038C     ; branch when carry reports an error or unsigned underflow; target L038C
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L038C     ; branch when the unsigned value is higher; target L038C
                    bra       L0380     ; continue execution at L0380
L038C               pshs      x         ; save x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    clr       U0005,u   ; clear U0005,u to zero and set the condition codes
                    clr       U0006,u   ; clear U0006,u to zero and set the condition codes
                    ldd       #1        ; set d to the constant 1
                    std       U0007,u   ; store d at U0007,u
L0399               lda       ,-x       ; load a from ,-x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L03CD     ; branch when carry reports an error or unsigned underflow; target L03CD
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L03CD     ; branch when the unsigned value is higher; target L03CD
                    suba      #48       ; subtract from a using #48
                    sta       U0002,u   ; store a at U0002,u
                    ldd       #0        ; set d to the constant 0
L03AA               tst       U0002,u   ; set condition codes from U0002,u without changing it
                    beq       L03B4     ; branch when the values are equal or the result is zero; target L03B4
                    addd      U0007,u   ; add to d using U0007,u
                    dec       U0002,u   ; decrement the value at U0002,u
                    bra       L03AA     ; continue execution at L03AA
L03B4               addd      U0005,u   ; add to d using U0005,u
                    std       U0005,u   ; store d at U0005,u
                    lda       #10       ; set a to the constant 10
                    sta       U0002,u   ; store a at U0002,u
                    ldd       #0        ; set d to the constant 0
L03BF               tst       U0002,u   ; set condition codes from U0002,u without changing it
                    beq       L03C9     ; branch when the values are equal or the result is zero; target L03C9
                    addd      U0007,u   ; add to d using U0007,u
                    dec       U0002,u   ; decrement the value at U0002,u
                    bra       L03BF     ; continue execution at L03BF
L03C9               std       U0007,u   ; store d at U0007,u
                    bra       L0399     ; continue execution at L0399
L03CD               ldd       U0005,u   ; load d from U0005,u
                    puls      x         ; restore x from the stack
                    puls      pc,y      ; restore pc,y and return to the caller
L03D3               pshs      x         ; save x on the stack
                    std       U0005,u   ; store d at U0005,u
                    lda       #48       ; set a to the constant 48
                    sta       0,x       ; store a at 0,x
                    sta       $01,x     ; store a at $01,x
                    sta       $02,x     ; store a at $02,x
                    sta       $03,x     ; store a at $03,x
                    sta       $04,x     ; store a at $04,x
                    ldd       #10000    ; set d to the constant 10000
                    std       U0007,u   ; store d at U0007,u
                    ldd       U0005,u   ; load d from U0005,u
                    lbsr      L0432     ; call subroutine L0432
                    ldd       #1000     ; set d to the constant 1000
                    std       U0007,u   ; store d at U0007,u
                    ldd       U0005,u   ; load d from U0005,u
                    bsr       L0432     ; call subroutine L0432
                    ldd       #100      ; set d to the constant 100
                    std       U0007,u   ; store d at U0007,u
                    ldd       U0005,u   ; load d from U0005,u
                    bsr       L0432     ; call subroutine L0432
                    ldd       #10       ; set d to the constant 10
                    std       U0007,u   ; store d at U0007,u
                    ldd       U0005,u   ; load d from U0005,u
                    bsr       L0432     ; call subroutine L0432
                    ldd       #1        ; set d to the constant 1
                    std       U0007,u   ; store d at U0007,u
                    ldd       U0005,u   ; load d from U0005,u
                    bsr       L0432     ; call subroutine L0432
                    lda       #13       ; set a to the constant 13
                    sta       0,x       ; store a at 0,x
                    puls      x         ; restore x from the stack
                    ldb       #32       ; set b to the constant 32
L0419               lda       0,x       ; load a from 0,x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bne       L0423     ; branch when the values differ or the result is nonzero; target L0423
                    stb       ,x+       ; store b at ,x+
                    bra       L0419     ; continue execution at L0419
L0423               lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L042F     ; branch when carry reports an error or unsigned underflow; target L042F
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L042F     ; branch when the unsigned value is higher; target L042F
                    bra       L0423     ; continue execution at L0423
L042F               leax      -$01,x    ; form the address -$01,x in x
                    rts                 ; return to the caller
L0432               subd      U0007,u   ; subtract from d using U0007,u
                    bcs       L043A     ; branch when carry reports an error or unsigned underflow; target L043A
                    inc       0,x       ; increment the value at 0,x
                    bra       L0432     ; continue execution at L0432
L043A               addd      U0007,u   ; add to d using U0007,u
                    std       U0005,u   ; store d at U0005,u
                    leax      $01,x     ; form the address $01,x in x
                    rts                 ; return to the caller
L0441               ldd       #-1       ; set d to the constant -1
                    puls      pc,y      ; restore pc,y and return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
