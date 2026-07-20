**********************************************************************
* BBS.stat - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       BBS.stat
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
U0008               rmb       2         ; reserve 2 byte(s) in the module workspace
U000A               rmb       8         ; reserve 8 byte(s) in the module workspace
U0012               rmb       2         ; reserve 2 byte(s) in the module workspace
U0014               rmb       2         ; reserve 2 byte(s) in the module workspace
U0016               rmb       2         ; reserve 2 byte(s) in the module workspace
U0018               rmb       2         ; reserve 2 byte(s) in the module workspace
U001A               rmb       6         ; reserve 6 byte(s) in the module workspace
U0020               rmb       8         ; reserve 8 byte(s) in the module workspace
U0028               rmb       3         ; reserve 3 byte(s) in the module workspace
U002B               rmb       2         ; reserve 2 byte(s) in the module workspace
U002D               rmb       1         ; reserve 1 byte(s) in the module workspace
U002E               rmb       400       ; reserve 400 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.stat/ ; store an OS-9 high-bit-terminated string
L0015               fcc       "User Statistics:" ; store literal character data
                    fcb       $0D       ; store byte data
L0026               fcc       "----------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
L0055               fcc       "Last on         : " ; store literal character data
L0067               fcc       "Times called    : " ; store literal character data
L0079               fcc       "Messages left   : " ; store literal character data
L008B               fcc       "Messages read   : " ; store literal character data
L009D               fcc       "Files downloaded: " ; store literal character data
L00AF               fcc       "Files uploaded  : " ; store literal character data
L00C1               fcc       "Time this login : " ; store literal character data
L00D3               fcc       "User # to check:" ; store literal character data
L00E3               fcc       "/dd/bbs/BBS.userstats" ; store literal character data
L00F8               fcc       "           January February    March    April      May     June     July   AugustSeptember  October November December" ; store literal character data
L016D               fcc       ", 19" ; store literal character data
L0171               fcb       $3A       ; store byte data
start               leax      >L00E3,pc ; form the address >L00E3,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L0264     ; branch when carry reports an error or unsigned underflow; target L0264
                    sta       U0000,u   ; store a at U0000,u
                    os9       F$ID      ; invoke the OS-9 F$ID service
                    sty       U0006,u   ; store y at U0006,u
                    lda       #13       ; set a to the constant 13
                    sta       <U002D,u  ; store a at <U002D,u
                    ldd       U0006,u   ; load d from U0006,u
                    cmpd      #0        ; compare d with #0 and set the condition codes
                    bne       L0197     ; branch when the values differ or the result is nonzero; target L0197
                    lbsr      L03EA     ; call subroutine L03EA
L0197               leax      U0008,u   ; form the address U0008,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       U0000,u   ; load a from U0000,u
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    bcs       L01AD     ; branch when carry reports an error or unsigned underflow; target L01AD
                    ldd       U0008,u   ; load d from U0008,u
                    cmpd      U0006,u   ; compare d with U0006,u and set the condition codes
                    beq       L01B6     ; branch when the values are equal or the result is zero; target L01B6
                    bra       L0197     ; continue execution at L0197
L01AD               cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      L0265     ; branch when the values differ or the result is nonzero; target L0265
                    lbra      L0264     ; continue execution at L0264
L01B6               leax      >L0015,pc ; form the address >L0015,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L0026,pc ; form the address >L0026,pc in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L0055,pc ; form the address >L0055,pc in x
                    ldy       #18       ; set y to the constant 18
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      <U001A,u  ; form the address <U001A,u in x
                    lbsr      L0289     ; call subroutine L0289
                    leax      >L0067,pc ; form the address >L0067,pc in x
                    ldy       #18       ; set y to the constant 18
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    ldd       U000A,u   ; load d from U000A,u
                    lbsr      L0268     ; call subroutine L0268
                    leax      >L009D,pc ; form the address >L009D,pc in x
                    ldy       #18       ; set y to the constant 18
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    ldd       <U0016,u  ; load d from <U0016,u
                    lbsr      L0268     ; call subroutine L0268
                    leax      >L00AF,pc ; form the address >L00AF,pc in x
                    ldy       #18       ; set y to the constant 18
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    ldd       <U0018,u  ; load d from <U0018,u
                    lbsr      L0268     ; call subroutine L0268
                    leax      >L0079,pc ; form the address >L0079,pc in x
                    ldy       #18       ; set y to the constant 18
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    ldd       <U0012,u  ; load d from <U0012,u
                    lbsr      L0268     ; call subroutine L0268
                    leax      >L008B,pc ; form the address >L008B,pc in x
                    ldy       #18       ; set y to the constant 18
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    ldd       <U0014,u  ; load d from <U0014,u
                    lbsr      L0268     ; call subroutine L0268
                    ldd       <U0020,u  ; load d from <U0020,u
                    beq       L0257     ; branch when the values are equal or the result is zero; target L0257
                    leax      >L00C1,pc ; form the address >L00C1,pc in x
                    ldy       #18       ; set y to the constant 18
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    ldd       <U0020,u  ; load d from <U0020,u
                    lbsr      L0268     ; call subroutine L0268
L0257               leax      >L0026,pc ; form the address >L0026,pc in x
                    lda       #1        ; set a to the constant 1
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
L0264               clrb                ; clear b to zero and set the condition codes
L0265               os9       F$Exit    ; invoke the OS-9 F$Exit service
L0268               leax      <U0028,u  ; form the address <U0028,u in x
                    lbsr      L0395     ; call subroutine L0395
                    leax      <U0028,u  ; form the address <U0028,u in x
L0271               lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    beq       L0271     ; branch when the values are equal or the result is zero; target L0271
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       L027D     ; branch when the values differ or the result is nonzero; target L027D
                    leax      -$01,x    ; form the address -$01,x in x
L027D               leax      -$01,x    ; form the address -$01,x in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    rts                 ; return to the caller
L0289               lda       $01,x     ; load a from $01,x
                    ldb       #9        ; set b to the constant 9
                    mul                 ; multiply a by b and return the product in d
                    pshs      x         ; save x on the stack
                    leax      >L00F8,pc ; form the address >L00F8,pc in x
                    leax      d,x       ; form the address d,x in x
                    ldy       #10       ; set y to the constant 10
L029A               lda       ,x+       ; load a from ,x+
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    bne       L02A4     ; branch when the values differ or the result is nonzero; target L02A4
                    leay      -$01,y    ; form the address -$01,y in y
                    bne       L029A     ; branch when the values differ or the result is nonzero; target L029A
L02A4               leax      -$01,x    ; form the address -$01,x in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    ldx       0,s       ; load x from the current stack frame at 0,s
                    ldb       $02,x     ; load b from $02,x
                    clra                ; clear a to zero and set the condition codes
                    leax      <U0028,u  ; form the address <U0028,u in x
                    lbsr      L0395     ; call subroutine L0395
                    leax      <U0028,u  ; form the address <U0028,u in x
                    leax      $03,x     ; form the address $03,x in x
                    ldy       #2        ; set y to the constant 2
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      >L016D,pc ; form the address >L016D,pc in x
                    ldy       #4        ; set y to the constant 4
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    ldx       0,s       ; load x from the current stack frame at 0,s
                    ldb       0,x       ; load b from 0,x
                    clra                ; clear a to zero and set the condition codes
                    leax      <U0028,u  ; form the address <U0028,u in x
                    lbsr      L0395     ; call subroutine L0395
                    leax      <U002B,u  ; form the address <U002B,u in x
                    ldy       #2        ; set y to the constant 2
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      >L00F8,pc ; form the address >L00F8,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    clra                ; clear a to zero and set the condition codes
                    ldx       0,s       ; load x from the current stack frame at 0,s
                    ldb       $03,x     ; load b from $03,x
                    leax      <U0028,u  ; form the address <U0028,u in x
                    lbsr      L0395     ; call subroutine L0395
                    leax      <U002B,u  ; form the address <U002B,u in x
                    ldy       #2        ; set y to the constant 2
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      >L0171,pc ; form the address >L0171,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    clra                ; clear a to zero and set the condition codes
                    ldx       0,s       ; load x from the current stack frame at 0,s
                    ldb       $04,x     ; load b from $04,x
                    leax      <U0028,u  ; form the address <U0028,u in x
                    lbsr      L0395     ; call subroutine L0395
                    leax      <U0028,u  ; form the address <U0028,u in x
                    leax      $03,x     ; form the address $03,x in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    puls      pc,x      ; restore pc,x and return to the caller
L032E               pshs      y         ; save y on the stack
L0330               lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      L03E5     ; branch when the values are equal or the result is zero; target L03E5
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L0330     ; branch when carry reports an error or unsigned underflow; target L0330
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L0330     ; branch when the unsigned value is higher; target L0330
                    leax      -$01,x    ; form the address -$01,x in x
L0342               lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L034E     ; branch when carry reports an error or unsigned underflow; target L034E
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L034E     ; branch when the unsigned value is higher; target L034E
                    bra       L0342     ; continue execution at L0342
L034E               pshs      x         ; save x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    clr       U0002,u   ; clear U0002,u to zero and set the condition codes
                    clr       U0003,u   ; clear U0003,u to zero and set the condition codes
                    ldd       #1        ; set d to the constant 1
                    std       U0004,u   ; store d at U0004,u
L035B               lda       ,-x       ; load a from ,-x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L038F     ; branch when carry reports an error or unsigned underflow; target L038F
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L038F     ; branch when the unsigned value is higher; target L038F
                    suba      #48       ; subtract from a using #48
                    sta       U0001,u   ; store a at U0001,u
                    ldd       #0        ; set d to the constant 0
L036C               tst       U0001,u   ; set condition codes from U0001,u without changing it
                    beq       L0376     ; branch when the values are equal or the result is zero; target L0376
                    addd      U0004,u   ; add to d using U0004,u
                    dec       U0001,u   ; decrement the value at U0001,u
                    bra       L036C     ; continue execution at L036C
L0376               addd      U0002,u   ; add to d using U0002,u
                    std       U0002,u   ; store d at U0002,u
                    lda       #10       ; set a to the constant 10
                    sta       U0001,u   ; store a at U0001,u
                    ldd       #0        ; set d to the constant 0
L0381               tst       U0001,u   ; set condition codes from U0001,u without changing it
                    beq       L038B     ; branch when the values are equal or the result is zero; target L038B
                    addd      U0004,u   ; add to d using U0004,u
                    dec       U0001,u   ; decrement the value at U0001,u
                    bra       L0381     ; continue execution at L0381
L038B               std       U0004,u   ; store d at U0004,u
                    bra       L035B     ; continue execution at L035B
L038F               ldd       U0002,u   ; load d from U0002,u
                    puls      x         ; restore x from the stack
                    puls      pc,y      ; restore pc,y and return to the caller
L0395               std       U0002,u   ; store d at U0002,u
                    lda       #48       ; set a to the constant 48
                    sta       0,x       ; store a at 0,x
                    sta       $01,x     ; store a at $01,x
                    sta       $02,x     ; store a at $02,x
                    sta       $03,x     ; store a at $03,x
                    sta       $04,x     ; store a at $04,x
                    ldd       #10000    ; set d to the constant 10000
                    std       U0004,u   ; store d at U0004,u
                    ldd       U0002,u   ; load d from U0002,u
                    lbsr      L03D6     ; call subroutine L03D6
                    ldd       #1000     ; set d to the constant 1000
                    std       U0004,u   ; store d at U0004,u
                    ldd       U0002,u   ; load d from U0002,u
                    bsr       L03D6     ; call subroutine L03D6
                    ldd       #100      ; set d to the constant 100
                    std       U0004,u   ; store d at U0004,u
                    ldd       U0002,u   ; load d from U0002,u
                    bsr       L03D6     ; call subroutine L03D6
                    ldd       #10       ; set d to the constant 10
                    std       U0004,u   ; store d at U0004,u
                    ldd       U0002,u   ; load d from U0002,u
                    bsr       L03D6     ; call subroutine L03D6
                    ldd       #1        ; set d to the constant 1
                    std       U0004,u   ; store d at U0004,u
                    ldd       U0002,u   ; load d from U0002,u
                    bsr       L03D6     ; call subroutine L03D6
                    lda       #13       ; set a to the constant 13
                    sta       0,x       ; store a at 0,x
                    rts                 ; return to the caller
L03D6               subd      U0004,u   ; subtract from d using U0004,u
                    bcs       L03DE     ; branch when carry reports an error or unsigned underflow; target L03DE
                    inc       0,x       ; increment the value at 0,x
                    bra       L03D6     ; continue execution at L03D6
L03DE               addd      U0004,u   ; add to d using U0004,u
                    std       U0002,u   ; store d at U0002,u
                    leax      $01,x     ; form the address $01,x in x
                    rts                 ; return to the caller
L03E5               ldb       #1        ; set b to the constant 1
                    lbra      L0265     ; continue execution at L0265
L03EA               leax      >L00D3,pc ; form the address >L00D3,pc in x
                    ldy       #16       ; set y to the constant 16
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      <U0028,u  ; form the address <U0028,u in x
                    ldy       #5        ; set y to the constant 5
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    lbsr      L032E     ; call subroutine L032E
                    std       U0006,u   ; store d at U0006,u
                    rts                 ; return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
