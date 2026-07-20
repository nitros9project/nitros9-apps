**********************************************************************
* Login - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       Login
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

U0000               rmb       2         ; reserve 2 byte(s) in the module workspace
U0002               rmb       1         ; reserve 1 byte(s) in the module workspace
U0003               rmb       1         ; reserve 1 byte(s) in the module workspace
U0004               rmb       1         ; reserve 1 byte(s) in the module workspace
U0005               rmb       1         ; reserve 1 byte(s) in the module workspace
U0006               rmb       5         ; reserve 5 byte(s) in the module workspace
U000B               rmb       1         ; reserve 1 byte(s) in the module workspace
U000C               rmb       1         ; reserve 1 byte(s) in the module workspace
U000D               rmb       1         ; reserve 1 byte(s) in the module workspace
U000E               rmb       1         ; reserve 1 byte(s) in the module workspace
U000F               rmb       1         ; reserve 1 byte(s) in the module workspace
U0010               rmb       3         ; reserve 3 byte(s) in the module workspace
U0013               rmb       2         ; reserve 2 byte(s) in the module workspace
U0015               rmb       1         ; reserve 1 byte(s) in the module workspace
U0016               rmb       1         ; reserve 1 byte(s) in the module workspace
U0017               rmb       2         ; reserve 2 byte(s) in the module workspace
U0019               rmb       2         ; reserve 2 byte(s) in the module workspace
U001B               rmb       2         ; reserve 2 byte(s) in the module workspace
U001D               rmb       2         ; reserve 2 byte(s) in the module workspace
U001F               rmb       2         ; reserve 2 byte(s) in the module workspace
U0021               rmb       2         ; reserve 2 byte(s) in the module workspace
U0023               rmb       2         ; reserve 2 byte(s) in the module workspace
U0025               rmb       2         ; reserve 2 byte(s) in the module workspace
U0027               rmb       1         ; reserve 1 byte(s) in the module workspace
U0028               rmb       2         ; reserve 2 byte(s) in the module workspace
U002A               rmb       1         ; reserve 1 byte(s) in the module workspace
U002B               rmb       2         ; reserve 2 byte(s) in the module workspace
U002D               rmb       2         ; reserve 2 byte(s) in the module workspace
U002F               rmb       2         ; reserve 2 byte(s) in the module workspace
U0031               rmb       2         ; reserve 2 byte(s) in the module workspace
U0033               rmb       2         ; reserve 2 byte(s) in the module workspace
U0035               rmb       1         ; reserve 1 byte(s) in the module workspace
U0036               rmb       1         ; reserve 1 byte(s) in the module workspace
U0037               rmb       1         ; reserve 1 byte(s) in the module workspace
U0038               rmb       1         ; reserve 1 byte(s) in the module workspace
U0039               rmb       2         ; reserve 2 byte(s) in the module workspace
U003B               rmb       8         ; reserve 8 byte(s) in the module workspace
U0043               rmb       3         ; reserve 3 byte(s) in the module workspace
U0046               rmb       1         ; reserve 1 byte(s) in the module workspace
U0047               rmb       1         ; reserve 1 byte(s) in the module workspace
U0048               rmb       1         ; reserve 1 byte(s) in the module workspace
U0049               rmb       32        ; reserve 32 byte(s) in the module workspace
U0069               rmb       200       ; reserve 200 byte(s) in the module workspace
U0131               rmb       200       ; reserve 200 byte(s) in the module workspace
U01F9               rmb       400       ; reserve 400 byte(s) in the module workspace
U0389               rmb       1         ; reserve 1 byte(s) in the module workspace
U038A               rmb       599       ; reserve 599 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /Login/ ; store an OS-9 high-bit-terminated string
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
L007D               fcb       $2F       ; store byte data
                    fcb       $50       ; store byte data
                    fcb       $0D       ; store byte data
L0080               fcb       $0A       ; store byte data
                    fcc       "Enter your user name-->" ; store literal character data
L0098               fcb       $00       ; store byte data
                    fcb       $18       ; store byte data
L009A               fcc       "Enter your Password--->" ; store literal character data
L00B1               fcb       $00       ; store byte data
                    fcb       $17       ; store byte data
L00B3               fcc       "Motd" ; store literal character data
                    fcb       $0D       ; store byte data
L00B8               fcc       "Shell" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
L00BF               fcc       "BBS.users" ; store literal character data
                    fcb       $0D       ; store byte data
L00C9               fcc       "Invald name/password!!!" ; store literal character data
                    fcb       $0D       ; store byte data
L00E1               fcb       $0A       ; store byte data
                    fcc       "OS9 Level II BBS" ; store literal character data
                    fcb       $0D       ; store byte data
L00F3               fcc       "By Alpha Software Technologies" ; store literal character data
                    fcb       $0D       ; store byte data
L0112               fcc       "Copyright (c) 1988" ; store literal character data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
L0126               fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
L0128               fcc       "date" ; store literal character data
                    fcb       $0D       ; store byte data
L012D               fcb       $74       ; store byte data
                    fcb       $0D       ; store byte data
L012F               fcc       "                                       " ; store literal character data
L0156               fcc       ":" ; store literal character data
L0157               fcc       "Sorry, but I cannot log you on" ; store literal character data
                    fcb       $0D       ; store byte data
L0176               fcc       "Welcome, " ; store literal character data
                    fcb       $0D       ; store byte data
L0180               fcb       $0A       ; store byte data
                    fcc       "Verifying Password...Please wait" ; store literal character data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
L01A3               fcb       $0A       ; store byte data
                    fcc       "Entering system..." ; store literal character data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
L01B8               fcc       "Userlog" ; store literal character data
                    fcb       $0D       ; store byte data
L01C0               fcc       "     List of today's callers" ; store literal character data
                    fcb       $0D       ; store byte data
L01DD               fcc       "=================================" ; store literal character data
                    fcb       $0D       ; store byte data
L01FF               fcc       "eotd" ; store literal character data
                    fcb       $0D       ; store byte data
L0204               fcb       $58       ; store byte data
L0205               fcb       $08       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $08       ; store byte data
L0208               fcc       "/dd/bbs/BBS.userstats" ; store literal character data
                    fcb       $0D       ; store byte data
L021E               fcc       "I'm sorry but you don't have any more time on-line" ; store literal character data
                    fcb       $0D       ; store byte data
start               leax      >L007D,pc ; form the address >L007D,pc in x
                    lda       #2        ; set a to the constant 2
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    bcc       L025E     ; branch when carry is clear; target L025E
                    lda       #255      ; set a to the constant 255
L025E               sta       U0005,u   ; store a at U0005,u
                    ldy       #0        ; set y to the constant 0
                    os9       F$SUser   ; invoke the OS-9 F$SUser service
                    lbcs      L07A1     ; branch when carry reports an error or unsigned underflow; target L07A1
                    clr       U000D,u   ; clear U000D,u to zero and set the condition codes
                    leax      >L00B3,pc ; form the address >L00B3,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    bcs       L0294     ; branch when carry reports an error or unsigned underflow; target L0294
                    leax      <U0069,u  ; form the address <U0069,u in x
                    sta       U0004,u   ; store a at U0004,u
L027D               ldy       #200      ; set y to the constant 200
                    lda       U0004,u   ; load a from U0004,u
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    bcs       L028F     ; branch when carry reports an error or unsigned underflow; target L028F
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    bra       L027D     ; continue execution at L027D
L028F               lda       U0004,u   ; load a from U0004,u
                    os9       I$Close   ; invoke the OS-9 I$Close service
L0294               leax      >L00E1,pc ; form the address >L00E1,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L00F3,pc ; form the address >L00F3,pc in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L0112,pc ; form the address >L0112,pc in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
L02B7               leax      >L0080,pc ; form the address >L0080,pc in x
                    ldy       >L0098,pc ; load y from >L0098,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      >U0131,u  ; form the address >U0131,u in x
                    clra                ; clear a to zero and set the condition codes
                    ldy       #200      ; set y to the constant 200
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    bcs       L02B7     ; branch when carry reports an error or unsigned underflow; target L02B7
                    sty       <U0019,u  ; store y at <U0019,u
                    lbsr      L0869     ; call subroutine L0869
                    lbsr      L066E     ; call subroutine L066E
                    leax      >L009A,pc ; form the address >L009A,pc in x
                    ldy       >L00B1,pc ; load y from >L00B1,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      >U01F9,u  ; form the address >U01F9,u in x
L02EF               ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    bcs       L02EF     ; branch when carry reports an error or unsigned underflow; target L02EF
                    lda       0,x       ; load a from 0,x
                    cmpa      #8        ; compare a with #8 and set the condition codes
                    beq       L032F     ; branch when the values are equal or the result is zero; target L032F
                    pshs      x         ; save x on the stack
                    leax      >L0204,pc ; form the address >L0204,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    puls      x         ; restore x from the stack
                    lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       L02EF     ; branch when the values differ or the result is nonzero; target L02EF
                    leax      >U01F9,u  ; form the address >U01F9,u in x
                    lbsr      L0869     ; call subroutine L0869
                    leax      >L0126,pc ; form the address >L0126,pc in x
                    ldy       #2        ; set y to the constant 2
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbsr      L0685     ; call subroutine L0685
                    bra       L0351     ; continue execution at L0351
L032F               leay      >U01F9,u  ; form the address >U01F9,u in y
                    sty       <U0015,u  ; store y at <U0015,u
                    cmpx      <U0015,u  ; compare x with <U0015,u and set the condition codes
                    beq       L02EF     ; branch when the values are equal or the result is zero; target L02EF
                    pshs      x         ; save x on the stack
                    leax      >L0205,pc ; form the address >L0205,pc in x
                    ldy       #3        ; set y to the constant 3
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    puls      x         ; restore x from the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    bra       L02EF     ; continue execution at L02EF
L0351               leax      >L0180,pc ; form the address >L0180,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L00BF,pc ; form the address >L00BF,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L07A1     ; branch when carry reports an error or unsigned underflow; target L07A1
                    sta       U0003,u   ; store a at U0003,u
L036D               leax      <U0069,u  ; form the address <U0069,u in x
                    ldb       #200      ; set b to the constant 200
                    lda       #13       ; set a to the constant 13
L0374               sta       ,x+       ; store a at ,x+
                    decb                ; decrement b
                    bne       L0374     ; branch when the values differ or the result is nonzero; target L0374
                    leax      <U0069,u  ; form the address <U0069,u in x
                    clr       U000C,u   ; clear U000C,u to zero and set the condition codes
                    lda       U0003,u   ; load a from U0003,u
                    ldy       #200      ; set y to the constant 200
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    bcs       L0403     ; branch when carry reports an error or unsigned underflow; target L0403
                    lbsr      L0869     ; call subroutine L0869
                    leay      >U0131,u  ; form the address >U0131,u in y
L0390               lda       ,y+       ; load a from ,y+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L03A4     ; branch when the values are equal or the result is zero; target L03A4
                    cmpa      #90       ; compare a with #90 and set the condition codes
                    bls       L039C     ; branch when the unsigned value is lower or equal; target L039C
                    anda      #223      ; mask a using #223
L039C               cmpa      ,x+       ; compare a with ,x+ and set the condition codes
                    bne       L036D     ; branch when the values differ or the result is nonzero; target L036D
                    inc       U000C,u   ; increment the value at U000C,u
                    bra       L0390     ; continue execution at L0390
L03A4               lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    bne       L036D     ; branch when the values differ or the result is nonzero; target L036D
                    leay      >U01F9,u  ; form the address >U01F9,u in y
L03AE               lda       ,y+       ; load a from ,y+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L03C0     ; branch when the values are equal or the result is zero; target L03C0
                    cmpa      #90       ; compare a with #90 and set the condition codes
                    bls       L03BA     ; branch when the unsigned value is lower or equal; target L03BA
                    anda      #223      ; mask a using #223
L03BA               cmpa      ,x+       ; compare a with ,x+ and set the condition codes
                    bne       L036D     ; branch when the values differ or the result is nonzero; target L036D
                    bra       L03AE     ; continue execution at L03AE
L03C0               lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    bne       L036D     ; branch when the values differ or the result is nonzero; target L036D
                    leay      >U0389,u  ; form the address >U0389,u in y
                    clr       <U0017,u  ; clear <U0017,u to zero and set the condition codes
L03CD               inc       <U0017,u  ; increment the value at <U0017,u
                    lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    beq       L03DE     ; branch when the values are equal or the result is zero; target L03DE
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L03DE     ; branch when the values are equal or the result is zero; target L03DE
                    sta       ,y+       ; store a at ,y+
                    bra       L03CD     ; continue execution at L03CD
L03DE               pshs      y,x       ; save y,x on the stack
                    lbsr      L07A4     ; call subroutine L07A4
                    puls      y,x       ; restore y,x from the stack
                    lda       #13       ; set a to the constant 13
                    sta       0,y       ; store a at 0,y
                    inc       <U0017,u  ; increment the value at <U0017,u
                    bsr       L0437     ; call subroutine L0437
                    std       <U001D,u  ; store d at <U001D,u
                    tfr       d,y       ; copy the register values specified by d,y
                    os9       F$SUser   ; invoke the OS-9 F$SUser service
                    bsr       L0437     ; call subroutine L0437
                    std       <U001B,u  ; store d at <U001B,u
                    lda       U0003,u   ; load a from U0003,u
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lbra      L04A5     ; continue execution at L04A5
L0403               leax      >L00C9,pc ; form the address >L00C9,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lda       U0003,u   ; load a from U0003,u
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    inc       U000D,u   ; increment the value at U000D,u
                    lda       U000D,u   ; load a from U000D,u
                    cmpa      #3        ; compare a with #3 and set the condition codes
                    bgt       L0425     ; branch when the signed value is greater; target L0425
                    lbra      L02B7     ; continue execution at L02B7
L0420               ldd       #0        ; set d to the constant 0
                    puls      pc,y      ; restore pc,y and return to the caller
L0425               leax      >L0157,pc ; form the address >L0157,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    pshs      u         ; save u on the stack
                    lbra      L069E     ; continue execution at L069E
L0437               pshs      y         ; save y on the stack
L0439               lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L0420     ; branch when the values are equal or the result is zero; target L0420
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L0439     ; branch when carry reports an error or unsigned underflow; target L0439
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L0439     ; branch when the unsigned value is higher; target L0439
                    leax      -$01,x    ; form the address -$01,x in x
L0449               lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L0455     ; branch when carry reports an error or unsigned underflow; target L0455
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L0455     ; branch when the unsigned value is higher; target L0455
                    bra       L0449     ; continue execution at L0449
L0455               pshs      x         ; save x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    clr       <U0015,u  ; clear <U0015,u to zero and set the condition codes
                    clr       <U0016,u  ; clear <U0016,u to zero and set the condition codes
                    ldd       #1        ; set d to the constant 1
                    std       <U0013,u  ; store d at <U0013,u
L0465               lda       ,-x       ; load a from ,-x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L049E     ; branch when carry reports an error or unsigned underflow; target L049E
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L049E     ; branch when the unsigned value is higher; target L049E
                    suba      #48       ; subtract from a using #48
                    sta       U000B,u   ; store a at U000B,u
                    ldd       #0        ; set d to the constant 0
L0476               tst       U000B,u   ; set condition codes from U000B,u without changing it
                    beq       L0481     ; branch when the values are equal or the result is zero; target L0481
                    addd      <U0013,u  ; add to d using <U0013,u
                    dec       U000B,u   ; decrement the value at U000B,u
                    bra       L0476     ; continue execution at L0476
L0481               addd      <U0015,u  ; add to d using <U0015,u
                    std       <U0015,u  ; store d at <U0015,u
                    lda       #10       ; set a to the constant 10
                    sta       U000B,u   ; store a at U000B,u
                    ldd       #0        ; set d to the constant 0
L048E               tst       U000B,u   ; set condition codes from U000B,u without changing it
                    beq       L0499     ; branch when the values are equal or the result is zero; target L0499
                    addd      <U0013,u  ; add to d using <U0013,u
                    dec       U000B,u   ; decrement the value at U000B,u
                    bra       L048E     ; continue execution at L048E
L0499               std       <U0013,u  ; store d at <U0013,u
                    bra       L0465     ; continue execution at L0465
L049E               ldd       <U0015,u  ; load d from <U0015,u
                    puls      x         ; restore x from the stack
                    puls      pc,y      ; restore pc,y and return to the caller
L04A5               leax      >L0176,pc ; form the address >L0176,pc in x
                    lda       #1        ; set a to the constant 1
                    ldy       #9        ; set y to the constant 9
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L07A1     ; branch when carry reports an error or unsigned underflow; target L07A1
                    leax      >U0131,u  ; form the address >U0131,u in x
                    ldb       U000C,u   ; load b from U000C,u
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       U0005,u   ; load a from U0005,u
                    bmi       L04C6     ; branch when the result is negative; target L04C6
                    os9       I$Write   ; invoke the OS-9 I$Write service
L04C6               lbcs      L07A1     ; branch when carry reports an error or unsigned underflow; target L07A1
                    lda       #1        ; set a to the constant 1
                    leay      $01,y     ; form the address $01,y in y
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L07A1     ; branch when carry reports an error or unsigned underflow; target L07A1
                    leax      >L01A3,pc ; form the address >L01A3,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    ldb       #21       ; set b to the constant 21
                    subb      U000C,u   ; subtract from b using U000C,u
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    leax      >L012F,pc ; form the address >L012F,pc in x
                    lda       U0005,u   ; load a from U0005,u
                    bmi       L04F4     ; branch when the result is negative; target L04F4
                    os9       I$Write   ; invoke the OS-9 I$Write service
L04F4               lbcs      L07A1     ; branch when carry reports an error or unsigned underflow; target L07A1
                    pshs      u         ; save u on the stack
                    lda       #1        ; set a to the constant 1
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lda       U0005,u   ; load a from U0005,u
                    bmi       L0529     ; branch when the result is negative; target L0529
                    os9       I$Dup     ; invoke the OS-9 I$Dup service
                    leax      >L0128,pc ; form the address >L0128,pc in x
                    leau      >L012D,pc ; form the workspace or data address >L012D,pc in u
                    ldy       #2        ; set y to the constant 2
                    lda       #17       ; set a to the constant 17
                    ldb       #3        ; set b to the constant 3
                    os9       F$Fork    ; invoke the OS-9 F$Fork service
                    lbcs      L07A1     ; branch when carry reports an error or unsigned underflow; target L07A1
                    os9       F$Wait    ; invoke the OS-9 F$Wait service
                    lbcs      L07A1     ; branch when carry reports an error or unsigned underflow; target L07A1
                    lda       #1        ; set a to the constant 1
                    os9       I$Close   ; invoke the OS-9 I$Close service
L0529               clra                ; clear a to zero and set the condition codes
                    os9       I$Dup     ; invoke the OS-9 I$Dup service
                    puls      u         ; restore u from the stack
                    leax      >L0208,pc ; form the address >L0208,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    bcc       L0543     ; branch when carry is clear; target L0543
                    ldb       #27       ; set b to the constant 27
                    os9       I$Create  ; invoke the OS-9 I$Create service
                    lbcs      L07A1     ; branch when carry reports an error or unsigned underflow; target L07A1
L0543               sta       <U0010,u  ; store a at <U0010,u
L0546               leax      <U0023,u  ; form the address <U0023,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       <U0010,u  ; load a from <U0010,u
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    bcs       L0560     ; branch when carry reports an error or unsigned underflow; target L0560
                    ldd       <U0023,u  ; load d from <U0023,u
                    cmpd      <U001D,u  ; compare d with <U001D,u and set the condition codes
                    bne       L0546     ; branch when the values differ or the result is nonzero; target L0546
                    bra       L0579     ; continue execution at L0579
L0560               cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      L07A1     ; branch when the values differ or the result is nonzero; target L07A1
                    lbra      L05EA     ; continue execution at L05EA
L0569               leax      >L021E,pc ; form the address >L021E,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbra      L069E     ; continue execution at L069E
L0579               ldd       <U0025,u  ; load d from <U0025,u
                    addd      #1        ; add to d using #1
                    std       <U0025,u  ; store d at <U0025,u
                    leax      <U0027,u  ; form the address <U0027,u in x
                    os9       F$Time    ; invoke the OS-9 F$Time service
                    lda       <U0035,u  ; load a from <U0035,u
                    cmpa      <U0027,u  ; compare a with <U0027,u and set the condition codes
                    bne       L059B     ; branch when the values differ or the result is nonzero; target L059B
                    ldd       <U0036,u  ; load d from <U0036,u
                    cmpd      <U0028,u  ; compare d with <U0028,u and set the condition codes
                    bne       L059B     ; branch when the values differ or the result is nonzero; target L059B
                    bra       L05A1     ; continue execution at L05A1
L059B               ldd       <U001B,u  ; load d from <U001B,u
                    std       <U003B,u  ; store d at <U003B,u
L05A1               ldd       <U003B,u  ; load d from <U003B,u
                    cmpd      #1        ; compare d with #1 and set the condition codes
                    lbeq      L0569     ; branch when the values are equal or the result is zero; target L0569
                    lda       <U0010,u  ; load a from <U0010,u
                    ldb       #5        ; set b to the constant 5
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    tfr       u,d       ; copy the register values specified by u,d
                    subd      #32       ; subtract from d using #32
                    bge       L05BF     ; branch when the signed value is greater than or equal; target L05BF
                    leax      -$01,x    ; form the address -$01,x in x
L05BF               ldu       0,s       ; load u from the current stack frame at 0,s
                    stx       <U001F,u  ; store x at <U001F,u
                    std       <U0021,u  ; store d at <U0021,u
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       <U0010,u  ; load a from <U0010,u
                    tfr       y,u       ; copy the register values specified by y,u
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    lbcs      L07A1     ; branch when carry reports an error or unsigned underflow; target L07A1
                    puls      u         ; restore u from the stack
                    leax      <U0023,u  ; form the address <U0023,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       <U0010,u  ; load a from <U0010,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lbra      L064D     ; continue execution at L064D
L05EA               leax      <U0023,u  ; form the address <U0023,u in x
                    ldd       #1        ; set d to the constant 1
                    std       <U0025,u  ; store d at <U0025,u
                    ldd       #0        ; set d to the constant 0
                    std       <U002D,u  ; store d at <U002D,u
                    std       <U002F,u  ; store d at <U002F,u
                    std       <U0033,u  ; store d at <U0033,u
                    std       <U0031,u  ; store d at <U0031,u
                    std       <U0035,u  ; store d at <U0035,u
                    std       <U0037,u  ; store d at <U0037,u
                    std       <U0039,u  ; store d at <U0039,u
                    ldd       <U001B,u  ; load d from <U001B,u
                    std       <U003B,u  ; store d at <U003B,u
                    ldd       <U001D,u  ; load d from <U001D,u
                    std       <U0023,u  ; store d at <U0023,u
                    leax      <U0027,u  ; form the address <U0027,u in x
                    os9       F$Time    ; invoke the OS-9 F$Time service
                    lbcs      L07A1     ; branch when carry reports an error or unsigned underflow; target L07A1
                    lda       <U0010,u  ; load a from <U0010,u
                    ldb       #5        ; set b to the constant 5
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    lbcs      L07A1     ; branch when carry reports an error or unsigned underflow; target L07A1
                    tfr       u,d       ; copy the register values specified by u,d
                    puls      u         ; restore u from the stack
                    stx       <U001F,u  ; store x at <U001F,u
                    std       <U0021,u  ; store d at <U0021,u
                    leax      <U0023,u  ; form the address <U0023,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       <U0010,u  ; load a from <U0010,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L07A1     ; branch when carry reports an error or unsigned underflow; target L07A1
                    os9       I$Close   ; invoke the OS-9 I$Close service
L064D               pshs      u         ; save u on the stack
                    ldb       <U0017,u  ; load b from <U0017,u
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    leax      >L00B8,pc ; form the address >L00B8,pc in x
                    leau      >U0389,u  ; form the workspace or data address >U0389,u in u
                    lda       #17       ; set a to the constant 17
                    ldb       #3        ; set b to the constant 3
                    os9       F$Fork    ; invoke the OS-9 F$Fork service
                    lbcs      L07A1     ; branch when carry reports an error or unsigned underflow; target L07A1
                    os9       F$Wait    ; invoke the OS-9 F$Wait service
                    lbra      L06D1     ; continue execution at L06D1
L066E               leax      <U0049,u  ; form the address <U0049,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    leax      -$20,x    ; form the address -$20,x in x
                    clr       <$0024,x  ; clear <$0024,x to zero and set the condition codes
                    leax      <U0049,u  ; form the address <U0049,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$SetStt  ; invoke the OS-9 I$SetStt service
                    rts                 ; return to the caller
L0685               leax      <U0049,u  ; form the address <U0049,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    leax      -$20,x    ; form the address -$20,x in x
                    lda       #1        ; set a to the constant 1
                    sta       <$0024,x  ; store a at <$0024,x
                    leax      <U0049,u  ; form the address <U0049,u in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$SetStt  ; invoke the OS-9 I$SetStt service
                    rts                 ; return to the caller
L069E               puls      u         ; restore u from the stack
                    ldy       #0        ; set y to the constant 0
                    os9       F$SUser   ; invoke the OS-9 F$SUser service
                    leax      >L01FF,pc ; form the address >L01FF,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    bcs       L06CD     ; branch when carry reports an error or unsigned underflow; target L06CD
                    sta       U0002,u   ; store a at U0002,u
L06B4               leax      <U0069,u  ; form the address <U0069,u in x
                    lda       U0002,u   ; load a from U0002,u
                    ldy       #200      ; set y to the constant 200
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    bcs       L06CD     ; branch when carry reports an error or unsigned underflow; target L06CD
                    lda       #1        ; set a to the constant 1
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    bra       L06B4     ; continue execution at L06B4
L06CD               clrb                ; clear b to zero and set the condition codes
                    os9       F$Exit    ; invoke the OS-9 F$Exit service
L06D1               puls      u         ; restore u from the stack
                    ldy       #0        ; set y to the constant 0
                    os9       F$SUser   ; invoke the OS-9 F$SUser service
                    leax      >L01FF,pc ; form the address >L01FF,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    bcs       L0700     ; branch when carry reports an error or unsigned underflow; target L0700
                    sta       U0002,u   ; store a at U0002,u
L06E7               leax      <U0069,u  ; form the address <U0069,u in x
                    lda       U0002,u   ; load a from U0002,u
                    ldy       #200      ; set y to the constant 200
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    bcs       L0700     ; branch when carry reports an error or unsigned underflow; target L0700
                    lda       #1        ; set a to the constant 1
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    bra       L06E7     ; continue execution at L06E7
L0700               cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      L07A1     ; branch when the values differ or the result is nonzero; target L07A1
                    leax      >L0208,pc ; form the address >L0208,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    sta       <U0010,u  ; store a at <U0010,u
                    lbcs      L07A1     ; branch when carry reports an error or unsigned underflow; target L07A1
                    pshs      u         ; save u on the stack
                    ldx       <U001F,u  ; load x from <U001F,u
                    ldu       <U0021,u  ; load u from <U0021,u
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    puls      u         ; restore u from the stack
                    leax      <U0023,u  ; form the address <U0023,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       <U0010,u  ; load a from <U0010,u
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    leax      <U0035,u  ; form the address <U0035,u in x
                    os9       F$Time    ; invoke the OS-9 F$Time service
                    ldd       <U001B,u  ; load d from <U001B,u
                    cmpd      #0        ; compare d with #0 and set the condition codes
                    beq       L0781     ; branch when the values are equal or the result is zero; target L0781
                    lda       <U0027,u  ; load a from <U0027,u
                    cmpa      <U0035,u  ; compare a with <U0035,u and set the condition codes
                    bne       L077B     ; branch when the values differ or the result is nonzero; target L077B
                    ldd       <U0028,u  ; load d from <U0028,u
                    cmpd      <U0036,u  ; compare d with <U0036,u and set the condition codes
                    bne       L077B     ; branch when the values differ or the result is nonzero; target L077B
                    lda       <U0038,u  ; load a from <U0038,u
                    suba      <U002A,u  ; subtract from a using <U002A,u
                    ldb       #60       ; set b to the constant 60
                    mul                 ; multiply a by b and return the product in d
                    std       <U001B,u  ; store d at <U001B,u
                    lda       <U0039,u  ; load a from <U0039,u
                    suba      <U002B,u  ; subtract from a using <U002B,u
                    tfr       a,b       ; copy the register values specified by a,b
                    sex                 ; sign-extend b into d
                    addd      <U001B,u  ; add to d using <U001B,u
                    std       <U001B,u  ; store d at <U001B,u
                    ldd       <U003B,u  ; load d from <U003B,u
                    subd      <U001B,u  ; subtract from d using <U001B,u
                    bgt       L0776     ; branch when the signed value is greater; target L0776
                    ldd       #1        ; set d to the constant 1
L0776               std       <U003B,u  ; store d at <U003B,u
                    bra       L0781     ; continue execution at L0781
L077B               ldd       <U001B,u  ; load d from <U001B,u
                    std       <U003B,u  ; store d at <U003B,u
L0781               lda       <U0010,u  ; load a from <U0010,u
                    pshs      u         ; save u on the stack
                    ldx       <U001F,u  ; load x from <U001F,u
                    ldu       <U0021,u  ; load u from <U0021,u
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    puls      u         ; restore u from the stack
                    leax      <U0023,u  ; form the address <U0023,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       <U0010,u  ; load a from <U0010,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    bcs       L07A1     ; branch when carry reports an error or unsigned underflow; target L07A1
                    clrb                ; clear b to zero and set the condition codes
L07A1               os9       F$Exit    ; invoke the OS-9 F$Exit service
L07A4               leax      >L01B8,pc ; form the address >L01B8,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    bcc       L07D6     ; branch when carry is clear; target L07D6
                    cmpb      #216      ; compare b with #216 and set the condition codes
                    lbne      L07A1     ; branch when the values differ or the result is nonzero; target L07A1
                    leax      >L01B8,pc ; form the address >L01B8,pc in x
                    lda       #3        ; set a to the constant 3
                    ldb       #11       ; set b to the constant 11
                    os9       I$Create  ; invoke the OS-9 I$Create service
                    leax      >L01C0,pc ; form the address >L01C0,pc in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L01DD,pc ; form the address >L01DD,pc in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
L07D6               sta       U0006,u   ; store a at U0006,u
                    pshs      u         ; save u on the stack
                    ldb       #2        ; set b to the constant 2
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    puls      u         ; restore u from the stack
                    leax      >U0131,u  ; form the address >U0131,u in x
                    ldy       <U0019,u  ; load y from <U0019,u
                    leay      -$01,y    ; form the address -$01,y in y
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    sty       <U0015,u  ; store y at <U0015,u
                    ldd       #24       ; set d to the constant 24
                    subd      <U0015,u  ; subtract from d using <U0015,u
                    blt       L0808     ; branch when the signed value is less; target L0808
                    tfr       d,y       ; copy the register values specified by d,y
                    leax      >L012F,pc ; form the address >L012F,pc in x
                    lda       U0006,u   ; load a from U0006,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
L0808               leax      <U0043,u  ; form the address <U0043,u in x
                    os9       F$Time    ; invoke the OS-9 F$Time service
                    bsr       L0814     ; call subroutine L0814
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    rts                 ; return to the caller
L0814               lda       <U0046,u  ; load a from <U0046,u
                    bsr       L084B     ; call subroutine L084B
                    leax      >L0156,pc ; form the address >L0156,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       U0006,u   ; load a from U0006,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lda       <U0047,u  ; load a from <U0047,u
                    bsr       L084B     ; call subroutine L084B
                    leax      >L0156,pc ; form the address >L0156,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       U0006,u   ; load a from U0006,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lda       <U0048,u  ; load a from <U0048,u
                    bsr       L084B     ; call subroutine L084B
                    leax      >L0126,pc ; form the address >L0126,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       U0006,u   ; load a from U0006,u
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    rts                 ; return to the caller
L084B               clrb                ; clear b to zero and set the condition codes
L084C               cmpa      #10       ; compare a with #10 and set the condition codes
                    blt       L0855     ; branch when the signed value is less; target L0855
                    incb                ; increment b
                    suba      #10       ; subtract from a using #10
                    bra       L084C     ; continue execution at L084C
L0855               addb      #48       ; add to b using #48
                    stb       U000E,u   ; store b at U000E,u
                    adda      #48       ; add to a using #48
                    sta       U000F,u   ; store a at U000F,u
                    leax      U000E,u   ; form the address U000E,u in x
                    ldy       #2        ; set y to the constant 2
                    lda       U0006,u   ; load a from U0006,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    rts                 ; return to the caller
L0869               pshs      x         ; save x on the stack
L086B               lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L087B     ; branch when the values are equal or the result is zero; target L087B
                    cmpa      #90       ; compare a with #90 and set the condition codes
                    bls       L086B     ; branch when the unsigned value is lower or equal; target L086B
                    anda      #223      ; mask a using #223
                    sta       -$01,x    ; store a at -$01,x
                    bra       L086B     ; continue execution at L086B
L087B               puls      pc,x      ; restore pc,x and return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
