**********************************************************************
* BBS.delete - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       BBS.delete
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
U0003               rmb       4         ; reserve 4 byte(s) in the module workspace
U0007               rmb       1         ; reserve 1 byte(s) in the module workspace
U0008               rmb       1         ; reserve 1 byte(s) in the module workspace
U0009               rmb       2         ; reserve 2 byte(s) in the module workspace
U000B               rmb       12        ; reserve 12 byte(s) in the module workspace
U0017               rmb       1         ; reserve 1 byte(s) in the module workspace
U0018               rmb       6         ; reserve 6 byte(s) in the module workspace
U001E               rmb       1         ; reserve 1 byte(s) in the module workspace
U001F               rmb       1         ; reserve 1 byte(s) in the module workspace
U0020               rmb       11        ; reserve 11 byte(s) in the module workspace
U002B               rmb       64        ; reserve 64 byte(s) in the module workspace
U006B               rmb       60        ; reserve 60 byte(s) in the module workspace
U00A7               rmb       1         ; reserve 1 byte(s) in the module workspace
U00A8               rmb       203       ; reserve 203 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.delete/ ; store an OS-9 high-bit-terminated string
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
L0082               fcc       "High message is #" ; store literal character data
L0093               fcb       $00       ; store byte data
                    fcb       $11       ; store byte data
L0095               fcc       "Enter message number to delete" ; store literal character data
                    fcb       $0D       ; store byte data
L00B4               fcc       ">Msg #    User name              Date        Subject" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcc       "-------------------------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
L0139               fcc       "BBS.msg.inx" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcc       "                                       " ; store literal character data
L016C               fcc       "          ******   DELETED   ******" ; store literal character data
                    fcb       $0D       ; store byte data
L0190               fcc       "Sorry, you cannot delete that message" ; store literal character data
                    fcb       $0D       ; store byte data

start               os9       F$ID      ; invoke the OS-9 F$ID service
                    sty       U0003,u   ; store y at U0003,u
                    ldy       #0        ; set y to the constant 0
                    os9       F$SUser   ; invoke the OS-9 F$SUser service
                    leax      >L0139,pc ; form the address >L0139,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L02C4     ; branch when carry reports an error or unsigned underflow; target L02C4
                    sta       U0000,u   ; store a at U0000,u
                    leax      <U002B,u  ; form the address <U002B,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       U0000,u   ; load a from U0000,u
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lbcs      L02C4     ; branch when carry reports an error or unsigned underflow; target L02C4
                    ldd       <U002B,u  ; load d from <U002B,u
                    leax      U000B,u   ; form the address U000B,u in x
                    lbsr      L0347     ; call subroutine L0347
                    leax      >L0082,pc ; form the address >L0082,pc in x
                    ldy       >L0093,pc ; load y from >L0093,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L02C4     ; branch when carry reports an error or unsigned underflow; target L02C4
                    leax      U000B,u   ; form the address U000B,u in x
                    ldy       #6        ; set y to the constant 6
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L02C4     ; branch when carry reports an error or unsigned underflow; target L02C4
                    leax      >L0095,pc ; form the address >L0095,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L02C4     ; branch when carry reports an error or unsigned underflow; target L02C4
                    leax      >L00B4,pc ; form the address >L00B4,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L02C4     ; branch when carry reports an error or unsigned underflow; target L02C4
                    leax      <U0018,u  ; form the address <U0018,u in x
                    ldy       #6        ; set y to the constant 6
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    lbcs      L02C4     ; branch when carry reports an error or unsigned underflow; target L02C4
                    clr       <U0017,u  ; clear <U0017,u to zero and set the condition codes
                    leax      <U0018,u  ; form the address <U0018,u in x
                    lda       #13       ; set a to the constant 13
                    sta       $02,x     ; store a at $02,x
                    lbsr      L02E0     ; call subroutine L02E0
                    cmpd      #1        ; compare d with #1 and set the condition codes
                    lbcs      L02C3     ; branch when carry reports an error or unsigned underflow; target L02C3
                    cmpd      <U002B,u  ; compare d with <U002B,u and set the condition codes
                    lbhi      L02C3     ; branch when the unsigned value is higher; target L02C3
                    std       U000B,u   ; store d at U000B,u
                    ldy       U0003,u   ; load y from U0003,u
                    beq       L0276     ; branch when the values are equal or the result is zero; target L0276
                    bsr       L0298     ; call subroutine L0298
                    leax      <U006B,u  ; form the address <U006B,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       U0000,u   ; load a from U0000,u
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    ldy       U0003,u   ; load y from U0003,u
                    cmpy      >U00A7,u  ; compare y with >U00A7,u and set the condition codes
                    lbne      L02D1     ; branch when the values differ or the result is nonzero; target L02D1
L0276               bsr       L0298     ; call subroutine L0298
                    leax      <U006B,u  ; form the address <U006B,u in x
                    ldd       #-1       ; set d to the constant -1
                    std       0,x       ; store d at 0,x
                    ldy       #64       ; set y to the constant 64
                    lda       U0000,u   ; load a from U0000,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      >L016C,pc ; form the address >L016C,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    bra       L02C3     ; continue execution at L02C3
L0298               clr       <U001E,u  ; clear <U001E,u to zero and set the condition codes
                    clr       <U001F,u  ; clear <U001F,u to zero and set the condition codes
                    lda       #6        ; set a to the constant 6
                    sta       U0001,u   ; store a at U0001,u
                    ldd       U000B,u   ; load d from U000B,u
L02A4               aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    rol       <U001F,u  ; rotate left through carry the value at <U001F,u
                    dec       U0001,u   ; decrement the value at U0001,u
                    bne       L02A4     ; branch when the values differ or the result is nonzero; target L02A4
                    std       <U0020,u  ; store d at <U0020,u
                    ldx       <U001E,u  ; load x from <U001E,u
                    lda       U0000,u   ; load a from U0000,u
                    pshs      u         ; save u on the stack
                    ldu       <U0020,u  ; load u from <U0020,u
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    lbcs      L02C4     ; branch when carry reports an error or unsigned underflow; target L02C4
                    puls      pc,u      ; restore pc,u and return to the caller
L02C3               clrb                ; clear b to zero and set the condition codes
L02C4               pshs      b         ; save b on the stack
                    ldy       U0003,u   ; load y from U0003,u
                    os9       F$SUser   ; invoke the OS-9 F$SUser service
                    puls      b         ; restore b from the stack
                    os9       F$Exit    ; invoke the OS-9 F$Exit service
L02D1               leax      >L0190,pc ; form the address >L0190,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    bra       L02C3     ; continue execution at L02C3
L02E0               pshs      y         ; save y on the stack
L02E2               lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      L03B5     ; branch when the values are equal or the result is zero; target L03B5
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L02E2     ; branch when carry reports an error or unsigned underflow; target L02E2
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L02E2     ; branch when the unsigned value is higher; target L02E2
                    leax      -$01,x    ; form the address -$01,x in x
L02F4               lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L0300     ; branch when carry reports an error or unsigned underflow; target L0300
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L0300     ; branch when the unsigned value is higher; target L0300
                    bra       L02F4     ; continue execution at L02F4
L0300               pshs      x         ; save x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    clr       U0007,u   ; clear U0007,u to zero and set the condition codes
                    clr       U0008,u   ; clear U0008,u to zero and set the condition codes
                    ldd       #1        ; set d to the constant 1
                    std       U0009,u   ; store d at U0009,u
L030D               lda       ,-x       ; load a from ,-x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L0341     ; branch when carry reports an error or unsigned underflow; target L0341
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L0341     ; branch when the unsigned value is higher; target L0341
                    suba      #48       ; subtract from a using #48
                    sta       U0002,u   ; store a at U0002,u
                    ldd       #0        ; set d to the constant 0
L031E               tst       U0002,u   ; set condition codes from U0002,u without changing it
                    beq       L0328     ; branch when the values are equal or the result is zero; target L0328
                    addd      U0009,u   ; add to d using U0009,u
                    dec       U0002,u   ; decrement the value at U0002,u
                    bra       L031E     ; continue execution at L031E
L0328               addd      U0007,u   ; add to d using U0007,u
                    std       U0007,u   ; store d at U0007,u
                    lda       #10       ; set a to the constant 10
                    sta       U0002,u   ; store a at U0002,u
                    ldd       #0        ; set d to the constant 0
L0333               tst       U0002,u   ; set condition codes from U0002,u without changing it
                    beq       L033D     ; branch when the values are equal or the result is zero; target L033D
                    addd      U0009,u   ; add to d using U0009,u
                    dec       U0002,u   ; decrement the value at U0002,u
                    bra       L0333     ; continue execution at L0333
L033D               std       U0009,u   ; store d at U0009,u
                    bra       L030D     ; continue execution at L030D
L0341               ldd       U0007,u   ; load d from U0007,u
                    puls      x         ; restore x from the stack
                    puls      pc,y      ; restore pc,y and return to the caller
L0347               pshs      x         ; save x on the stack
                    std       U0007,u   ; store d at U0007,u
                    lda       #48       ; set a to the constant 48
                    sta       0,x       ; store a at 0,x
                    sta       $01,x     ; store a at $01,x
                    sta       $02,x     ; store a at $02,x
                    sta       $03,x     ; store a at $03,x
                    sta       $04,x     ; store a at $04,x
                    ldd       #10000    ; set d to the constant 10000
                    std       U0009,u   ; store d at U0009,u
                    ldd       U0007,u   ; load d from U0007,u
                    lbsr      L03A6     ; call subroutine L03A6
                    ldd       #1000     ; set d to the constant 1000
                    std       U0009,u   ; store d at U0009,u
                    ldd       U0007,u   ; load d from U0007,u
                    bsr       L03A6     ; call subroutine L03A6
                    ldd       #100      ; set d to the constant 100
                    std       U0009,u   ; store d at U0009,u
                    ldd       U0007,u   ; load d from U0007,u
                    bsr       L03A6     ; call subroutine L03A6
                    ldd       #10       ; set d to the constant 10
                    std       U0009,u   ; store d at U0009,u
                    ldd       U0007,u   ; load d from U0007,u
                    bsr       L03A6     ; call subroutine L03A6
                    ldd       #1        ; set d to the constant 1
                    std       U0009,u   ; store d at U0009,u
                    ldd       U0007,u   ; load d from U0007,u
                    bsr       L03A6     ; call subroutine L03A6
                    lda       #13       ; set a to the constant 13
                    sta       0,x       ; store a at 0,x
                    puls      x         ; restore x from the stack
                    ldb       #32       ; set b to the constant 32
L038D               lda       0,x       ; load a from 0,x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bne       L0397     ; branch when the values differ or the result is nonzero; target L0397
                    stb       ,x+       ; store b at ,x+
                    bra       L038D     ; continue execution at L038D
L0397               lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L03A3     ; branch when carry reports an error or unsigned underflow; target L03A3
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L03A3     ; branch when the unsigned value is higher; target L03A3
                    bra       L0397     ; continue execution at L0397
L03A3               leax      -$01,x    ; form the address -$01,x in x
                    rts                 ; return to the caller
L03A6               subd      U0009,u   ; subtract from d using U0009,u
                    bcs       L03AE     ; branch when carry reports an error or unsigned underflow; target L03AE
                    inc       0,x       ; increment the value at 0,x
                    bra       L03A6     ; continue execution at L03A6
L03AE               addd      U0009,u   ; add to d using U0009,u
                    std       U0007,u   ; store d at U0007,u
                    leax      $01,x     ; form the address $01,x in x
                    rts                 ; return to the caller
L03B5               ldd       #-1       ; set d to the constant -1
                    puls      pc,y      ; restore pc,y and return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
