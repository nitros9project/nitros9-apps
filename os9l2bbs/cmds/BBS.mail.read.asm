**********************************************************************
* BBS.mail.read - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       BBS.mail.read
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

U0000               rmb       1         ; reserve 1 byte(s) in the module workspace
U0001               rmb       2         ; reserve 2 byte(s) in the module workspace
U0003               rmb       1         ; reserve 1 byte(s) in the module workspace
U0004               rmb       1         ; reserve 1 byte(s) in the module workspace
U0005               rmb       3         ; reserve 3 byte(s) in the module workspace
U0008               rmb       1         ; reserve 1 byte(s) in the module workspace
U0009               rmb       1         ; reserve 1 byte(s) in the module workspace
U000A               rmb       2         ; reserve 2 byte(s) in the module workspace
U000C               rmb       8         ; reserve 8 byte(s) in the module workspace
U0014               rmb       3         ; reserve 3 byte(s) in the module workspace
U0017               rmb       1         ; reserve 1 byte(s) in the module workspace
U0018               rmb       13        ; reserve 13 byte(s) in the module workspace
U0025               rmb       1         ; reserve 1 byte(s) in the module workspace
U0026               rmb       1         ; reserve 1 byte(s) in the module workspace
U0027               rmb       1         ; reserve 1 byte(s) in the module workspace
U0028               rmb       1         ; reserve 1 byte(s) in the module workspace
U0029               rmb       1         ; reserve 1 byte(s) in the module workspace
U002A               rmb       1         ; reserve 1 byte(s) in the module workspace
U002B               rmb       1         ; reserve 1 byte(s) in the module workspace
U002C               rmb       1         ; reserve 1 byte(s) in the module workspace
U002D               rmb       1         ; reserve 1 byte(s) in the module workspace
U002E               rmb       64        ; reserve 64 byte(s) in the module workspace
U006E               rmb       80        ; reserve 80 byte(s) in the module workspace
U00BE               rmb       2         ; reserve 2 byte(s) in the module workspace
U00C0               rmb       2         ; reserve 2 byte(s) in the module workspace
U00C2               rmb       20        ; reserve 20 byte(s) in the module workspace
U00D6               rmb       30        ; reserve 30 byte(s) in the module workspace
U00F4               rmb       1         ; reserve 1 byte(s) in the module workspace
U00F5               rmb       1         ; reserve 1 byte(s) in the module workspace
U00F6               rmb       6         ; reserve 6 byte(s) in the module workspace
U00FC               rmb       2         ; reserve 2 byte(s) in the module workspace
U00FE               rmb       200       ; reserve 200 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.mail.read/ ; store an OS-9 high-bit-terminated string
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
                    fcc       "High message is #" ; store literal character data
                    fcb       $00       ; store byte data
                    fcb       $11       ; store byte data
                    fcc       "Enter message #" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcc       ">" ; store literal character data
L00A9               fcc       "BBS.mail.inx" ; store literal character data
                    fcb       $0D       ; store byte data
L00B6               fcc       "BBS.mail" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcc       "******   DELETED   ******" ; store literal character data
                    fcb       $0D       ; store byte data
L00D9               fcb       $0A       ; store byte data
                    fcb       $0A       ; store byte data
                    fcc       "From    :" ; store literal character data
L00E4               fcc       "Left on :" ; store literal character data
L00ED               fcc       "About   :" ; store literal character data
L00F6               fcb       $00       ; store byte data
                    fcb       $09       ; store byte data
L00F8               fcc       "---------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
L0138               fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
L013A               fcb       $0A       ; store byte data
                    fcc       "That's all the mail that was left for you" ; store literal character data
                    fcb       $0D       ; store byte data
L0165               fcc       "Sorry, you have no mail" ; store literal character data
                    fcb       $0D       ; store byte data
L017D               fcc       "Checking for mail..." ; store literal character data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
L0193               fcc       "Re-Read? (y/N):" ; store literal character data
                    fcb       $0D       ; store byte data

start               os9       F$ID      ; invoke the OS-9 F$ID service
                    sty       U000C,u   ; store y at U000C,u
                    ldy       #0        ; set y to the constant 0
                    os9       F$SUser   ; invoke the OS-9 F$SUser service
                    leax      >L00A9,pc ; form the address >L00A9,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L0375     ; branch when carry reports an error or unsigned underflow; target L0375
                    sta       U0000,u   ; store a at U0000,u
                    leax      >L00B6,pc ; form the address >L00B6,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L0375     ; branch when carry reports an error or unsigned underflow; target L0375
                    sta       U0001,u   ; store a at U0001,u
                    clr       U0004,u   ; clear U0004,u to zero and set the condition codes
                    leax      >L017D,pc ; form the address >L017D,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      <U002E,u  ; form the address <U002E,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       U0000,u   ; load a from U0000,u
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lbcs      L0375     ; branch when carry reports an error or unsigned underflow; target L0375
L01ED               leax      >U00BE,u  ; form the address >U00BE,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       U0000,u   ; load a from U0000,u
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    bcs       L0207     ; branch when carry reports an error or unsigned underflow; target L0207
                    ldd       >U00FC,u  ; load d from >U00FC,u
                    cmpd      U000C,u   ; compare d with U000C,u and set the condition codes
                    bne       L01ED     ; branch when the values differ or the result is nonzero; target L01ED
                    bra       L0231     ; continue execution at L0231
L0207               cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      L0375     ; branch when the values differ or the result is nonzero; target L0375
                    tst       U0004,u   ; set condition codes from U0004,u without changing it
                    beq       L0221     ; branch when the values are equal or the result is zero; target L0221
                    leax      >L013A,pc ; form the address >L013A,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbra      L0374     ; continue execution at L0374
L0221               leax      >L0165,pc ; form the address >L0165,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbra      L0374     ; continue execution at L0374
L0231               inc       U0004,u   ; increment the value at U0004,u
                    ldd       >U00BE,u  ; load d from >U00BE,u
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    lbeq      L01ED     ; branch when the values are equal or the result is zero; target L01ED
                    leax      >L00D9,pc ; form the address >L00D9,pc in x
                    ldy       >L00F6,pc ; load y from >L00F6,pc
                    leay      $02,y     ; form the address $02,y in y
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      >U00C2,u  ; form the address >U00C2,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L0375     ; branch when carry reports an error or unsigned underflow; target L0375
                    leax      >L00E4,pc ; form the address >L00E4,pc in x
                    ldy       >L00F6,pc ; load y from >L00F6,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      <U0014,u  ; form the address <U0014,u in x
                    ldb       >U00F5,u  ; load b from >U00F5,u
                    clra                ; clear a to zero and set the condition codes
                    lbsr      L03E9     ; call subroutine L03E9
                    lda       <U0017,u  ; load a from <U0017,u
                    sta       <U0025,u  ; store a at <U0025,u
                    lda       <U0018,u  ; load a from <U0018,u
                    sta       <U0026,u  ; store a at <U0026,u
                    lda       #47       ; set a to the constant 47
                    sta       <U0027,u  ; store a at <U0027,u
                    ldb       >U00F6,u  ; load b from >U00F6,u
                    clra                ; clear a to zero and set the condition codes
                    leax      <U0014,u  ; form the address <U0014,u in x
                    lbsr      L03E9     ; call subroutine L03E9
                    lda       <U0017,u  ; load a from <U0017,u
                    sta       <U0028,u  ; store a at <U0028,u
                    lda       <U0018,u  ; load a from <U0018,u
                    sta       <U0029,u  ; store a at <U0029,u
                    lda       #47       ; set a to the constant 47
                    sta       <U002A,u  ; store a at <U002A,u
                    ldb       >U00F4,u  ; load b from >U00F4,u
                    clra                ; clear a to zero and set the condition codes
                    leax      <U0014,u  ; form the address <U0014,u in x
                    lbsr      L03E9     ; call subroutine L03E9
                    lda       <U0017,u  ; load a from <U0017,u
                    sta       <U002B,u  ; store a at <U002B,u
                    lda       <U0018,u  ; load a from <U0018,u
                    sta       <U002C,u  ; store a at <U002C,u
                    lda       #13       ; set a to the constant 13
                    sta       <U002D,u  ; store a at <U002D,u
                    leax      <U0025,u  ; form the address <U0025,u in x
L02C5               lda       ,x+       ; load a from ,x+
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       L02C5     ; branch when the values are equal or the result is zero; target L02C5
                    leax      -$01,x    ; form the address -$01,x in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L0375     ; branch when carry reports an error or unsigned underflow; target L0375
                    leax      >L00ED,pc ; form the address >L00ED,pc in x
                    ldy       >L00F6,pc ; load y from >L00F6,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      >U00D6,u  ; form the address >U00D6,u in x
                    ldy       #30       ; set y to the constant 30
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L0375     ; branch when carry reports an error or unsigned underflow; target L0375
                    bra       L02F9     ; continue execution at L02F9
L02F9               leax      >L00F8,pc ; form the address >L00F8,pc in x
                    ldy       #64       ; set y to the constant 64
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lda       U0001,u   ; load a from U0001,u
                    ldx       >U00BE,u  ; load x from >U00BE,u
                    pshs      u         ; save u on the stack
                    ldu       >U00C0,u  ; load u from >U00C0,u
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    lbcs      L0375     ; branch when carry reports an error or unsigned underflow; target L0375
                    puls      u         ; restore u from the stack
L031B               lda       U0001,u   ; load a from U0001,u
                    leax      <U006E,u  ; form the address <U006E,u in x
                    ldy       #80       ; set y to the constant 80
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bhi       L031B     ; branch when the unsigned value is higher; target L031B
                    leax      >L00F8,pc ; form the address >L00F8,pc in x
                    ldy       #64       ; set y to the constant 64
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L0193,pc ; form the address >L0193,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      U0005,u   ; form the address U0005,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    leax      >L0138,pc ; form the address >L0138,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lda       U0005,u   ; load a from U0005,u
                    cmpa      #121      ; compare a with #121 and set the condition codes
                    lbeq      L02F9     ; branch when the values are equal or the result is zero; target L02F9
                    cmpa      #89       ; compare a with #89 and set the condition codes
                    lbeq      L02F9     ; branch when the values are equal or the result is zero; target L02F9
                    lbra      L01ED     ; continue execution at L01ED
L0374               clrb                ; clear b to zero and set the condition codes
L0375               pshs      b         ; save b on the stack
                    ldy       U000C,u   ; load y from U000C,u
                    os9       F$SUser   ; invoke the OS-9 F$SUser service
                    puls      b         ; restore b from the stack
                    os9       F$Exit    ; invoke the OS-9 F$Exit service

                    pshs      y         ; save y on the stack
L0384               lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      L0457     ; branch when the values are equal or the result is zero; target L0457
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L0384     ; branch when carry reports an error or unsigned underflow; target L0384
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L0384     ; branch when the unsigned value is higher; target L0384
                    leax      -$01,x    ; form the address -$01,x in x
L0396               lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L03A2     ; branch when carry reports an error or unsigned underflow; target L03A2
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L03A2     ; branch when the unsigned value is higher; target L03A2
                    bra       L0396     ; continue execution at L0396
L03A2               pshs      x         ; save x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    clr       U0008,u   ; clear U0008,u to zero and set the condition codes
                    clr       U0009,u   ; clear U0009,u to zero and set the condition codes
                    ldd       #1        ; set d to the constant 1
                    std       U000A,u   ; store d at U000A,u
L03AF               lda       ,-x       ; load a from ,-x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L03E3     ; branch when carry reports an error or unsigned underflow; target L03E3
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L03E3     ; branch when the unsigned value is higher; target L03E3
                    suba      #48       ; subtract from a using #48
                    sta       U0003,u   ; store a at U0003,u
                    ldd       #0        ; set d to the constant 0
L03C0               tst       U0003,u   ; set condition codes from U0003,u without changing it
                    beq       L03CA     ; branch when the values are equal or the result is zero; target L03CA
                    addd      U000A,u   ; add to d using U000A,u
                    dec       U0003,u   ; decrement the value at U0003,u
                    bra       L03C0     ; continue execution at L03C0
L03CA               addd      U0008,u   ; add to d using U0008,u
                    std       U0008,u   ; store d at U0008,u
                    lda       #10       ; set a to the constant 10
                    sta       U0003,u   ; store a at U0003,u
                    ldd       #0        ; set d to the constant 0
L03D5               tst       U0003,u   ; set condition codes from U0003,u without changing it
                    beq       L03DF     ; branch when the values are equal or the result is zero; target L03DF
                    addd      U000A,u   ; add to d using U000A,u
                    dec       U0003,u   ; decrement the value at U0003,u
                    bra       L03D5     ; continue execution at L03D5
L03DF               std       U000A,u   ; store d at U000A,u
                    bra       L03AF     ; continue execution at L03AF
L03E3               ldd       U0008,u   ; load d from U0008,u
                    puls      x         ; restore x from the stack
                    puls      pc,y      ; restore pc,y and return to the caller
L03E9               pshs      x         ; save x on the stack
                    std       U0008,u   ; store d at U0008,u
                    lda       #48       ; set a to the constant 48
                    sta       0,x       ; store a at 0,x
                    sta       $01,x     ; store a at $01,x
                    sta       $02,x     ; store a at $02,x
                    sta       $03,x     ; store a at $03,x
                    sta       $04,x     ; store a at $04,x
                    ldd       #10000    ; set d to the constant 10000
                    std       U000A,u   ; store d at U000A,u
                    ldd       U0008,u   ; load d from U0008,u
                    lbsr      L0448     ; call subroutine L0448
                    ldd       #1000     ; set d to the constant 1000
                    std       U000A,u   ; store d at U000A,u
                    ldd       U0008,u   ; load d from U0008,u
                    bsr       L0448     ; call subroutine L0448
                    ldd       #100      ; set d to the constant 100
                    std       U000A,u   ; store d at U000A,u
                    ldd       U0008,u   ; load d from U0008,u
                    bsr       L0448     ; call subroutine L0448
                    ldd       #10       ; set d to the constant 10
                    std       U000A,u   ; store d at U000A,u
                    ldd       U0008,u   ; load d from U0008,u
                    bsr       L0448     ; call subroutine L0448
                    ldd       #1        ; set d to the constant 1
                    std       U000A,u   ; store d at U000A,u
                    ldd       U0008,u   ; load d from U0008,u
                    bsr       L0448     ; call subroutine L0448
                    lda       #13       ; set a to the constant 13
                    sta       0,x       ; store a at 0,x
                    puls      x         ; restore x from the stack
                    ldb       #32       ; set b to the constant 32
L042F               lda       0,x       ; load a from 0,x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bne       L0439     ; branch when the values differ or the result is nonzero; target L0439
                    stb       ,x+       ; store b at ,x+
                    bra       L042F     ; continue execution at L042F
L0439               lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L0445     ; branch when carry reports an error or unsigned underflow; target L0445
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L0445     ; branch when the unsigned value is higher; target L0445
                    bra       L0439     ; continue execution at L0439
L0445               leax      -$01,x    ; form the address -$01,x in x
                    rts                 ; return to the caller
L0448               subd      U000A,u   ; subtract from d using U000A,u
                    bcs       L0450     ; branch when carry reports an error or unsigned underflow; target L0450
                    inc       0,x       ; increment the value at 0,x
                    bra       L0448     ; continue execution at L0448
L0450               addd      U000A,u   ; add to d using U000A,u
                    std       U0008,u   ; store d at U0008,u
                    leax      $01,x     ; form the address $01,x in x
                    rts                 ; return to the caller
L0457               ldd       #-1       ; set d to the constant -1
                    puls      pc,y      ; restore pc,y and return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
