**********************************************************************
* New_user - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       New_user
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
U0008               rmb       2         ; reserve 2 byte(s) in the module workspace
U000A               rmb       1         ; reserve 1 byte(s) in the module workspace
U000B               rmb       2         ; reserve 2 byte(s) in the module workspace
U000D               rmb       338       ; reserve 338 byte(s) in the module workspace
U015F               rmb       2         ; reserve 2 byte(s) in the module workspace
U0161               rmb       58        ; reserve 58 byte(s) in the module workspace
U019B               rmb       1         ; reserve 1 byte(s) in the module workspace
U019C               rmb       3         ; reserve 3 byte(s) in the module workspace
U019F               rmb       2         ; reserve 2 byte(s) in the module workspace
U01A1               rmb       1418      ; reserve 1418 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /New_user/ ; store an OS-9 high-bit-terminated string
                    fcb       $01       ; store byte data
L0016               lda       ,y+       ; load a from ,y+
                    sta       ,u+       ; store a at ,u+
                    leax      -$01,x    ; form the address -$01,x in x
                    bne       L0016     ; branch when the values differ or the result is nonzero; target L0016
                    rts                 ; return to the caller
start               pshs      y         ; save y on the stack
                    pshs      u         ; save u on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
L0025               sta       ,u+       ; store a at ,u+
                    decb                ; decrement b
                    bne       L0025     ; branch when the values differ or the result is nonzero; target L0025
                    ldx       0,s       ; load x from the current stack frame at 0,s
                    leau      0,x       ; form the workspace or data address 0,x in u
                    leax      >$03AB,x  ; form the address >$03AB,x in x
                    pshs      x         ; save x on the stack
                    leay      >L15F9,pc ; form the address >L15F9,pc in y
                    ldx       ,y++      ; load x from ,y++
                    beq       L0040     ; branch when the values are equal or the result is zero; target L0040
                    bsr       L0016     ; call subroutine L0016
                    ldu       $02,s     ; load u from the current stack frame at $02,s
L0040               leau      >U0001,u  ; form the workspace or data address >U0001,u in u
                    ldx       ,y++      ; load x from ,y++
                    beq       L004B     ; branch when the values are equal or the result is zero; target L004B
                    bsr       L0016     ; call subroutine L0016
                    clra                ; clear a to zero and set the condition codes
L004B               cmpu      0,s       ; compare u with 0,s and set the condition codes
                    beq       L0054     ; branch when the values are equal or the result is zero; target L0054
                    sta       ,u+       ; store a at ,u+
                    bra       L004B     ; continue execution at L004B
L0054               ldu       $02,s     ; load u from the current stack frame at $02,s
                    ldd       ,y++      ; load d from ,y++
                    beq       L0061     ; branch when the values are equal or the result is zero; target L0061
                    leax      0,pc      ; form the address 0,pc in x
                    lbsr      L0164     ; call subroutine L0164
L0061               ldd       ,y++      ; load d from ,y++
                    beq       L006A     ; branch when the values are equal or the result is zero; target L006A
                    leax      U0000,u   ; form the address U0000,u in x
                    lbsr      L0164     ; call subroutine L0164
L006A               leas      $04,s     ; adjust the system stack pointer
                    puls      x         ; restore x from the stack
                    stx       >U019F,u  ; store x at >U019F,u
                    sty       >U015F,u  ; store y at >U015F,u
                    ldd       #1        ; set d to the constant 1
                    std       >U019B,u  ; store d at >U019B,u
                    leay      >U0161,u  ; form the address >U0161,u in y
                    leax      0,s       ; form the address 0,s in x
                    lda       ,x+       ; load a from ,x+
L0086               ldb       >U019C,u  ; load b from >U019C,u
                    cmpb      #29       ; compare b with #29 and set the condition codes
                    beq       L00E2     ; branch when the values are equal or the result is zero; target L00E2
L008E               cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L00E2     ; branch when the values are equal or the result is zero; target L00E2
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       L009A     ; branch when the values are equal or the result is zero; target L009A
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    bne       L009E     ; branch when the values differ or the result is nonzero; target L009E
L009A               lda       ,x+       ; load a from ,x+
                    bra       L008E     ; continue execution at L008E
L009E               cmpa      #34       ; compare a with #34 and set the condition codes
                    beq       L00A6     ; branch when the values are equal or the result is zero; target L00A6
                    cmpa      #39       ; compare a with #39 and set the condition codes
                    bne       L00C4     ; branch when the values differ or the result is nonzero; target L00C4
L00A6               stx       ,y++      ; store x at ,y++
                    inc       >U019C,u  ; increment the value at >U019C,u
                    pshs      a         ; save a on the stack
L00AE               lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L00B8     ; branch when the values are equal or the result is zero; target L00B8
                    cmpa      0,s       ; compare a with 0,s and set the condition codes
                    bne       L00AE     ; branch when the values differ or the result is nonzero; target L00AE
L00B8               puls      b         ; restore b from the stack
                    clr       -$01,x    ; clear -$01,x to zero and set the condition codes
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L00E2     ; branch when the values are equal or the result is zero; target L00E2
                    lda       ,x+       ; load a from ,x+
                    bra       L0086     ; continue execution at L0086
L00C4               leax      -$01,x    ; form the address -$01,x in x
                    stx       ,y++      ; store x at ,y++
                    leax      $01,x     ; form the address $01,x in x
                    inc       >U019C,u  ; increment the value at >U019C,u
L00CE               cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L00DE     ; branch when the values are equal or the result is zero; target L00DE
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       L00DE     ; branch when the values are equal or the result is zero; target L00DE
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    beq       L00DE     ; branch when the values are equal or the result is zero; target L00DE
                    lda       ,x+       ; load a from ,x+
                    bra       L00CE     ; continue execution at L00CE
L00DE               clr       -$01,x    ; clear -$01,x to zero and set the condition codes
                    bra       L0086     ; continue execution at L0086
L00E2               leax      >U015F,u  ; form the address >U015F,u in x
                    pshs      x         ; save x on the stack
                    ldd       >U019B,u  ; load d from >U019B,u
                    pshs      d         ; save d on the stack
                    leay      U0000,u   ; form the address U0000,u in y
                    bsr       L00FC     ; call subroutine L00FC
                    lbsr      L017E     ; call subroutine L017E
                    clr       ,-s       ; clear ,-s to zero and set the condition codes
                    clr       ,-s       ; clear ,-s to zero and set the condition codes
                    lbsr      L15ED     ; call subroutine L15ED
L00FC               leax      >$03AB,y  ; form the address >$03AB,y in x
                    stx       >$01A9,y  ; store x at >$01A9,y
                    sts       >$019D,y  ; store s at >$019D,y
                    sts       >$01AB,y  ; store s at >$01AB,y
                    ldd       #-126     ; set d to the constant -126
L0111               leax      d,s       ; form the address d,s in x
                    cmpx      >$01AB,y  ; compare x with >$01AB,y and set the condition codes
                    bcc       L0123     ; branch when carry is clear; target L0123
                    cmpx      >$01A9,y  ; compare x with >$01A9,y and set the condition codes
                    bcs       L013D     ; branch when carry reports an error or unsigned underflow; target L013D
                    stx       >$01AB,y  ; store x at >$01AB,y
L0123               rts                 ; return to the caller
L0124               fcc       "**** STACK OVERFLOW ****" ; store literal character data
                    fcb       $0D       ; store byte data
L013D               leax      <L0124,pc ; form the address <L0124,pc in x
                    ldb       #207      ; set b to the constant 207
                    pshs      b         ; save b on the stack
                    lda       #2        ; set a to the constant 2
                    ldy       #100      ; set y to the constant 100
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    clr       ,-s       ; clear ,-s to zero and set the condition codes
                    lbsr      L15F3     ; call subroutine L15F3
                    ldd       >$019D,y  ; load d from >$019D,y
                    subd      >$01AB,y  ; subtract from d using >$01AB,y
                    rts                 ; return to the caller
                    fcb       $EC       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $AB       ; store byte data
                    fcb       $A3       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $39       ; store byte data
L0164               pshs      x         ; save x on the stack
                    leax      d,y       ; form the address d,y in x
                    leax      d,x       ; form the address d,x in x
                    pshs      x         ; save x on the stack
L016C               ldd       ,y++      ; load d from ,y++
                    leax      d,u       ; form the address d,u in x
                    ldd       0,x       ; load d from 0,x
                    addd      $02,s     ; add to d using $02,s
                    std       0,x       ; store d at 0,x
                    cmpy      0,s       ; compare y with 0,s and set the condition codes
                    bne       L016C     ; branch when the values differ or the result is nonzero; target L016C
                    leas      $04,s     ; adjust the system stack pointer
                    rts                 ; return to the caller
L017E               pshs      u         ; save u on the stack
                    ldd       #-77      ; set d to the constant -77
                    lbsr      L0111     ; call subroutine L0111
                    leas      -$03,s    ; adjust the system stack pointer
                    leax      >L03D2,pc ; form the address >L03D2,pc in x
                    pshs      x         ; save x on the stack
                    ldx       $0B,s     ; load x from the current stack frame at $0B,s
                    ldd       $02,x     ; load d from $02,x
                    pshs      d         ; save d on the stack
                    lbsr      L0884     ; call subroutine L0884
                    leas      $04,s     ; adjust the system stack pointer
                    std       $01,s     ; store d in the current stack frame at $01,s
                    bne       L01AE     ; branch when the values differ or the result is nonzero; target L01AE
                    ldd       >$01AD,y  ; load d from >$01AD,y
                    pshs      d         ; save d on the stack
                    leax      >L03D4,pc ; form the address >L03D4,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L03B0     ; call subroutine L03B0
                    leas      $04,s     ; adjust the system stack pointer
L01AE               ldd       #78       ; set d to the constant 78
                    lbra      L02E1     ; continue execution at L02E1
L01B4               leax      >L03E5,pc ; form the address >L03E5,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L095A     ; call subroutine L095A
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >L042F,pc ; form the address >L042F,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L095A     ; call subroutine L095A
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >L0466,pc ; form the address >L0466,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L095A     ; call subroutine L095A
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >L04A5,pc ; form the address >L04A5,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L095A     ; call subroutine L095A
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >L04F0,pc ; form the address >L04F0,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L095A     ; call subroutine L095A
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >$01AF,y  ; form the address >$01AF,y in x
                    pshs      x         ; save x on the stack
                    lbsr      L08D6     ; call subroutine L08D6
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >L0510,pc ; form the address >L0510,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L095A     ; call subroutine L095A
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >$01FF,y  ; form the address >$01FF,y in x
                    pshs      x         ; save x on the stack
                    lbsr      L08D6     ; call subroutine L08D6
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >L0530,pc ; form the address >L0530,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L095A     ; call subroutine L095A
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >$024F,y  ; form the address >$024F,y in x
                    pshs      x         ; save x on the stack
                    lbsr      L08D6     ; call subroutine L08D6
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >L0550,pc ; form the address >L0550,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L095A     ; call subroutine L095A
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >$029F,y  ; form the address >$029F,y in x
                    pshs      x         ; save x on the stack
                    lbsr      L08D6     ; call subroutine L08D6
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >L0570,pc ; form the address >L0570,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L095A     ; call subroutine L095A
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >$02EF,y  ; form the address >$02EF,y in x
                    pshs      x         ; save x on the stack
                    lbsr      L08D6     ; call subroutine L08D6
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >L0590,pc ; form the address >L0590,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L095A     ; call subroutine L095A
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >$033F,y  ; form the address >$033F,y in x
                    pshs      x         ; save x on the stack
                    lbsr      L08D6     ; call subroutine L08D6
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >$02EF,y  ; form the address >$02EF,y in x
                    pshs      x         ; save x on the stack
                    leax      >$01AF,y  ; form the address >$01AF,y in x
                    pshs      x         ; save x on the stack
                    leax      >L05B0,pc ; form the address >L05B0,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L095A     ; call subroutine L095A
                    leas      $06,s     ; adjust the system stack pointer
                    leax      >$024F,y  ; form the address >$024F,y in x
                    pshs      x         ; save x on the stack
                    leax      >$01FF,y  ; form the address >$01FF,y in x
                    pshs      x         ; save x on the stack
                    leax      >L05C7,pc ; form the address >L05C7,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L095A     ; call subroutine L095A
                    leas      $06,s     ; adjust the system stack pointer
                    leax      >$029F,y  ; form the address >$029F,y in x
                    pshs      x         ; save x on the stack
                    leax      >L05DC,pc ; form the address >L05DC,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L095A     ; call subroutine L095A
                    leas      $04,s     ; adjust the system stack pointer
                    leax      >$033F,y  ; form the address >$033F,y in x
                    pshs      x         ; save x on the stack
                    leax      >L05E7,pc ; form the address >L05E7,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L095A     ; call subroutine L095A
                    leas      $04,s     ; adjust the system stack pointer
                    leax      >L05F4,pc ; form the address >L05F4,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L095A     ; call subroutine L095A
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >$001B,y  ; form the address >$001B,y in x
                    pshs      x         ; save x on the stack
                    lbsr      L0F89     ; call subroutine L0F89
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      $02,s     ; form the address $02,s in x
                    pshs      x         ; save x on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L149A     ; call subroutine L149A
                    leas      $06,s     ; adjust the system stack pointer
                    ldb       0,s       ; load b from the current stack frame at 0,s
                    clra                ; clear a to zero and set the condition codes
                    andb      #223      ; mask b using #223
L02E1               stb       0,s       ; store b in the current stack frame at 0,s
                    ldb       0,s       ; load b from the current stack frame at 0,s
                    cmpb      #89       ; compare b with #89 and set the condition codes
                    lbne      L01B4     ; branch when the values differ or the result is nonzero; target L01B4
                    leax      >L0611,pc ; form the address >L0611,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L095A     ; call subroutine L095A
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >L0628,pc ; form the address >L0628,pc in x
                    pshs      x         ; save x on the stack
                    ldd       $03,s     ; load d from the current stack frame at $03,s
                    pshs      d         ; save d on the stack
                    lbsr      L096C     ; call subroutine L096C
                    leas      $04,s     ; adjust the system stack pointer
                    leax      >L0636,pc ; form the address >L0636,pc in x
                    pshs      x         ; save x on the stack
                    ldd       $03,s     ; load d from the current stack frame at $03,s
                    pshs      d         ; save d on the stack
                    lbsr      L096C     ; call subroutine L096C
                    leas      $04,s     ; adjust the system stack pointer
                    leax      >$01AF,y  ; form the address >$01AF,y in x
                    pshs      x         ; save x on the stack
                    leax      >L066D,pc ; form the address >L066D,pc in x
                    pshs      x         ; save x on the stack
                    ldd       $05,s     ; load d from the current stack frame at $05,s
                    pshs      d         ; save d on the stack
                    lbsr      L096C     ; call subroutine L096C
                    leas      $06,s     ; adjust the system stack pointer
                    leax      >$01FF,y  ; form the address >$01FF,y in x
                    pshs      x         ; save x on the stack
                    leax      >L0682,pc ; form the address >L0682,pc in x
                    pshs      x         ; save x on the stack
                    ldd       $05,s     ; load d from the current stack frame at $05,s
                    pshs      d         ; save d on the stack
                    lbsr      L096C     ; call subroutine L096C
                    leas      $06,s     ; adjust the system stack pointer
                    leax      >$024F,y  ; form the address >$024F,y in x
                    pshs      x         ; save x on the stack
                    leax      >L0697,pc ; form the address >L0697,pc in x
                    pshs      x         ; save x on the stack
                    ldd       $05,s     ; load d from the current stack frame at $05,s
                    pshs      d         ; save d on the stack
                    lbsr      L096C     ; call subroutine L096C
                    leas      $06,s     ; adjust the system stack pointer
                    leax      >$029F,y  ; form the address >$029F,y in x
                    pshs      x         ; save x on the stack
                    leax      >L06AC,pc ; form the address >L06AC,pc in x
                    pshs      x         ; save x on the stack
                    ldd       $05,s     ; load d from the current stack frame at $05,s
                    pshs      d         ; save d on the stack
                    lbsr      L096C     ; call subroutine L096C
                    leas      $06,s     ; adjust the system stack pointer
                    leax      >$02EF,y  ; form the address >$02EF,y in x
                    pshs      x         ; save x on the stack
                    leax      >L06C1,pc ; form the address >L06C1,pc in x
                    pshs      x         ; save x on the stack
                    ldd       $05,s     ; load d from the current stack frame at $05,s
                    pshs      d         ; save d on the stack
                    lbsr      L096C     ; call subroutine L096C
                    leas      $06,s     ; adjust the system stack pointer
                    leax      >$033F,y  ; form the address >$033F,y in x
                    pshs      x         ; save x on the stack
                    leax      >L06D6,pc ; form the address >L06D6,pc in x
                    pshs      x         ; save x on the stack
                    ldd       $05,s     ; load d from the current stack frame at $05,s
                    pshs      d         ; save d on the stack
                    lbsr      L096C     ; call subroutine L096C
                    leas      $06,s     ; adjust the system stack pointer
                    leax      >L06EB,pc ; form the address >L06EB,pc in x
                    pshs      x         ; save x on the stack
                    ldd       $03,s     ; load d from the current stack frame at $03,s
                    pshs      d         ; save d on the stack
                    lbsr      L096C     ; call subroutine L096C
                    leas      $04,s     ; adjust the system stack pointer
                    leax      >L06ED,pc ; form the address >L06ED,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L095A     ; call subroutine L095A
                    leas      $02,s     ; adjust the system stack pointer
                    leas      $03,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
L03B0               pshs      u         ; save u on the stack
                    ldd       #-72      ; set d to the constant -72
                    lbsr      L0111     ; call subroutine L0111
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    pshs      d         ; save d on the stack
                    leax      >L072A,pc ; form the address >L072A,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L095A     ; call subroutine L095A
                    leas      $04,s     ; adjust the system stack pointer
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    lbsr      L15ED     ; call subroutine L15ED
                    leas      $02,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
L03D2               fcb       $61       ; store byte data
                    fcb       $00       ; store byte data
L03D4               fcc       "Cannot open file" ; store literal character data
                    fcb       $00       ; store byte data
L03E5               fcb       $0D       ; store byte data
                    fcc       "To be validated on this system you must enter the following information" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L042F               fcc       "Please enter the information as correctly as possible" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L0466               fcc       "any false information will result in your not being validated" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L04A5               fcc       "-------------------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L04F0               fcc       "Enter your name:==============>" ; store literal character data
                    fcb       $00       ; store byte data
L0510               fcc       "Enter your city:==============>" ; store literal character data
                    fcb       $00       ; store byte data
L0530               fcc       "Enter your state:=============>" ; store literal character data
                    fcb       $00       ; store byte data
L0550               fcc       "Enter your phone #:===========>" ; store literal character data
                    fcb       $00       ; store byte data
L0570               fcc       "Enter your alias (if any):====>" ; store literal character data
                    fcb       $00       ; store byte data
L0590               fcc       "Enter your desired password:==>" ; store literal character data
                    fcb       $00       ; store byte data
L05B0               fcb       $0D       ; store byte data
                    fcb       $0D       ; store byte data
                    fcc       "You are %s alias %s" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L05C7               fcc       "Calling from %s, %s" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L05DC               fcc       "Phone #%s" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L05E7               fcc       "Password:%s" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L05F4               fcc       "Is this information correct?" ; store literal character data
                    fcb       $00       ; store byte data
L0611               fcb       $0D       ; store byte data
                    fcc       "One moment please..." ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L0628               fcc       "New user log" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L0636               fcc       "-----------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L066D               fcc       "User name       :%s" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L0682               fcc       "City            :%s" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L0697               fcc       "State           :%s" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L06AC               fcc       "Phone #         :%s" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L06C1               fcc       "Desired alias   :%s" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L06D6               fcc       "Desired password:%s" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L06EB               fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L06ED               fcc       "Thank you, the sysop will validate you as soon as possible." ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L072A               fcb       $25       ; store byte data
                    fcb       $73       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L072E               pshs      u         ; save u on the stack
                    leau      >$000E,y  ; form the workspace or data address >$000E,y in u
L0734               ldd       U0006,u   ; load d from U0006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #3        ; mask b using #3
                    lbeq      L07A5     ; branch when the values are equal or the result is zero; target L07A5
                    leau      U000D,u   ; form the workspace or data address U000D,u in u
                    pshs      u         ; save u on the stack
                    leax      >$00DE,y  ; form the address >$00DE,y in x
                    cmpx      ,s++      ; compare x with ,s++ and set the condition codes
                    bhi       L0734     ; branch when the unsigned value is higher; target L0734
                    ldd       #200      ; set d to the constant 200
                    std       >$01AD,y  ; store d at >$01AD,y
                    lbra      L07A9     ; continue execution at L07A9
                    fcb       $35       ; store byte data
                    fcb       $C0       ; store byte data
L0755               pshs      u         ; save u on the stack
                    ldu       $08,s     ; load u from the current stack frame at $08,s
                    bne       L075F     ; branch when the values differ or the result is nonzero; target L075F
                    bsr       L072E     ; call subroutine L072E
                    tfr       d,u       ; copy the register values specified by d,u
L075F               stu       -$02,s    ; store u in the current stack frame at -$02,s
                    beq       L07A9     ; branch when the values are equal or the result is zero; target L07A9
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    std       U0008,u   ; store d at U0008,u
                    ldx       $06,s     ; load x from the current stack frame at $06,s
                    ldb       $01,x     ; load b from $01,x
                    cmpb      #43       ; compare b with #43 and set the condition codes
                    beq       L0777     ; branch when the values are equal or the result is zero; target L0777
                    ldx       $06,s     ; load x from the current stack frame at $06,s
                    ldb       $02,x     ; load b from $02,x
                    cmpb      #43       ; compare b with #43 and set the condition codes
                    bne       L077D     ; branch when the values differ or the result is nonzero; target L077D
L0777               ldd       U0006,u   ; load d from U0006,u
                    orb       #3        ; set selected bits in b using #3
                    bra       L079B     ; continue execution at L079B
L077D               ldd       U0006,u   ; load d from U0006,u
                    pshs      d         ; save d on the stack
                    ldb       [<$08,s]  ; load b from the current stack frame at [<$08,s]
                    cmpb      #114      ; compare b with #114 and set the condition codes
                    beq       L078F     ; branch when the values are equal or the result is zero; target L078F
                    ldb       [<$08,s]  ; load b from the current stack frame at [<$08,s]
                    cmpb      #100      ; compare b with #100 and set the condition codes
                    bne       L0794     ; branch when the values differ or the result is nonzero; target L0794
L078F               ldd       #1        ; set d to the constant 1
                    bra       L0797     ; continue execution at L0797
L0794               ldd       #2        ; set d to the constant 2
L0797               ora       ,s+       ; set selected bits in a using ,s+
                    orb       ,s+       ; set selected bits in b using ,s+
L079B               std       U0006,u   ; store d at U0006,u
                    ldd       U0002,u   ; load d from U0002,u
                    addd      U000B,u   ; add to d using U000B,u
                    std       U0004,u   ; store d at U0004,u
                    std       U0000,u   ; store d at U0000,u
L07A5               tfr       u,d       ; copy the register values specified by u,d
                    puls      pc,u      ; restore pc,u and return to the caller
L07A9               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    puls      pc,u      ; restore pc,u and return to the caller
L07AD               pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    leas      -$04,s    ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       0,s       ; store d in the current stack frame at 0,s
                    ldx       $0A,s     ; load x from the current stack frame at $0A,s
                    ldb       $01,x     ; load b from $01,x
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; copy the register values specified by d,x
                    bra       L07DE     ; continue execution at L07DE
L07C0               ldx       $0A,s     ; load x from the current stack frame at $0A,s
                    ldb       $02,x     ; load b from $02,x
                    cmpb      #43       ; compare b with #43 and set the condition codes
                    bne       L07CD     ; branch when the values differ or the result is nonzero; target L07CD
                    ldd       #7        ; set d to the constant 7
                    bra       L07D5     ; continue execution at L07D5
L07CD               ldd       #4        ; set d to the constant 4
                    bra       L07D5     ; continue execution at L07D5
L07D2               ldd       #3        ; set d to the constant 3
L07D5               std       0,s       ; store d in the current stack frame at 0,s
                    bra       L07EE     ; continue execution at L07EE
L07D9               leax      $04,s     ; form the address $04,s in x
                    lbra      L0846     ; continue execution at L0846
L07DE               stx       -$02,s    ; store x in the current stack frame at -$02,s
                    beq       L07EE     ; branch when the values are equal or the result is zero; target L07EE
                    cmpx      #120      ; compare x with #120 and set the condition codes
                    beq       L07C0     ; branch when the values are equal or the result is zero; target L07C0
                    cmpx      #43       ; compare x with #43 and set the condition codes
                    beq       L07D2     ; branch when the values are equal or the result is zero; target L07D2
                    bra       L07D9     ; continue execution at L07D9
L07EE               ldb       [<$0A,s]  ; load b from the current stack frame at [<$0A,s]
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; copy the register values specified by d,x
                    lbra      L0853     ; continue execution at L0853
L07F7               ldd       0,s       ; load d from the current stack frame at 0,s
                    orb       #1        ; set selected bits in b using #1
                    bra       L0839     ; continue execution at L0839
L07FD               ldd       0,s       ; load d from the current stack frame at 0,s
                    orb       #2        ; set selected bits in b using #2
                    pshs      d         ; save d on the stack
                    pshs      u         ; save u on the stack
                    lbsr      L141E     ; call subroutine L141E
                    leas      $04,s     ; adjust the system stack pointer
                    std       $02,s     ; store d in the current stack frame at $02,s
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    beq       L0828     ; branch when the values are equal or the result is zero; target L0828
                    ldd       #2        ; set d to the constant 2
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    pshs      d         ; save d on the stack
                    ldd       $08,s     ; load d from the current stack frame at $08,s
                    pshs      d         ; save d on the stack
                    lbsr      L14F4     ; call subroutine L14F4
                    leas      $08,s     ; adjust the system stack pointer
                    bra       L086D     ; continue execution at L086D
L0828               ldd       0,s       ; load d from the current stack frame at 0,s
                    orb       #2        ; set selected bits in b using #2
                    pshs      d         ; save d on the stack
                    pshs      u         ; save u on the stack
                    lbsr      L143F     ; call subroutine L143F
                    bra       L0840     ; continue execution at L0840
L0835               ldd       0,s       ; load d from the current stack frame at 0,s
                    orb       #129      ; set selected bits in b using #129
L0839               pshs      d         ; save d on the stack
                    pshs      u         ; save u on the stack
                    lbsr      L141E     ; call subroutine L141E
L0840               leas      $04,s     ; adjust the system stack pointer
                    std       $02,s     ; store d in the current stack frame at $02,s
                    bra       L086D     ; continue execution at L086D
L0846               leas      -$04,x    ; adjust the system stack pointer
L0848               ldd       #203      ; set d to the constant 203
                    std       >$01AD,y  ; store d at >$01AD,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    bra       L086F     ; continue execution at L086F
L0853               cmpx      #114      ; compare x with #114 and set the condition codes
                    lbeq      L07F7     ; branch when the values are equal or the result is zero; target L07F7
                    cmpx      #97       ; compare x with #97 and set the condition codes
                    lbeq      L07FD     ; branch when the values are equal or the result is zero; target L07FD
                    cmpx      #119      ; compare x with #119 and set the condition codes
                    beq       L0828     ; branch when the values are equal or the result is zero; target L0828
                    cmpx      #100      ; compare x with #100 and set the condition codes
                    beq       L0835     ; branch when the values are equal or the result is zero; target L0835
                    bra       L0848     ; continue execution at L0848
L086D               ldd       $02,s     ; load d from the current stack frame at $02,s
L086F               leas      $04,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
                    fcc       "4@O_4" ; store literal character data
                    fcb       $06       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $68       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $68       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $16       ; store byte data
                    fcb       $00       ; store byte data
                    fcc       "K" ; store literal character data
L0884               pshs      u         ; save u on the stack
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    lbsr      L07AD     ; call subroutine L07AD
                    leas      $04,s     ; adjust the system stack pointer
                    tfr       d,u       ; copy the register values specified by d,u
                    cmpu      #-1       ; compare u with #-1 and set the condition codes
                    bne       L089F     ; branch when the values differ or the result is nonzero; target L089F
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    bra       L08D4     ; continue execution at L08D4
L089F               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    bra       L08C7     ; continue execution at L08C7
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $68       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $A3       ; store byte data
                    fcb       $32       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $FE       ; store byte data
                    fcb       $F4       ; store byte data
                    fcb       $32       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $EF       ; store byte data
                    fcb       $7E       ; store byte data
                    fcb       $2C       ; store byte data
                    fcb       $04       ; store byte data
                    fcc       "O_ " ; store literal character data
                    fcb       $0F       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $68       ; store byte data
L08C7               pshs      d         ; save d on the stack
                    ldd       $08,s     ; load d from the current stack frame at $08,s
                    pshs      d         ; save d on the stack
                    pshs      u         ; save u on the stack
                    lbsr      L0755     ; call subroutine L0755
                    leas      $06,s     ; adjust the system stack pointer
L08D4               puls      pc,u      ; restore pc,u and return to the caller
L08D6               pshs      u,d       ; save u,d on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    bra       L08E0     ; continue execution at L08E0
L08DC               ldd       0,s       ; load d from the current stack frame at 0,s
                    stb       ,u+       ; store b at ,u+
L08E0               leax      >$000E,y  ; form the address >$000E,y in x
                    pshs      x         ; save x on the stack
                    lbsr      L1079     ; call subroutine L1079
                    leas      $02,s     ; adjust the system stack pointer
                    std       0,s       ; store d in the current stack frame at 0,s
                    cmpd      #13       ; compare d with #13 and set the condition codes
                    beq       L08FB     ; branch when the values are equal or the result is zero; target L08FB
                    ldd       0,s       ; load d from the current stack frame at 0,s
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    bne       L08DC     ; branch when the values differ or the result is nonzero; target L08DC
L08FB               ldd       0,s       ; load d from the current stack frame at 0,s
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    bne       L0907     ; branch when the values differ or the result is nonzero; target L0907
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    bra       L090D     ; continue execution at L090D
L0907               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       U0000,u   ; store b at U0000,u
                    ldd       $06,s     ; load d from the current stack frame at $06,s
L090D               leas      $02,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $EE       ; store byte data
                    fcc       "f2|" ; store literal character data
                    fcb       $EC       ; store byte data
                    fcb       $68       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $0E       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $AE       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $AF       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $E7       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $C1       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $19       ; store byte data
                    fcb       $1F       ; store byte data
                    fcc       "03_" ; store literal character data
                    fcb       $ED       ; store byte data
                    fcb       $7E       ; store byte data
                    fcb       $2F       ; store byte data
                    fcb       $11       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $6C       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $07       ; store byte data
                    fcc       "?2b" ; store literal character data
                    fcb       $ED       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $83       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $26       ; store byte data
                    fcb       $D9       ; store byte data
                    fcb       $4F       ; store byte data
                    fcb       $5F       ; store byte data
                    fcb       $E7       ; store byte data
                    fcb       $F4       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $83       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $26       ; store byte data
                    fcb       $04       ; store byte data
                    fcc       "O_ " ; store literal character data
                    fcb       $02       ; store byte data
                    fcb       $EC       ; store byte data
                    fcc       "h2d5" ; store literal character data
                    fcb       $C0       ; store byte data
L095A               pshs      u         ; save u on the stack
                    leax      >$001B,y  ; form the address >$001B,y in x
                    stx       >$038F,y  ; store x at >$038F,y
                    leax      $06,s     ; form the address $06,s in x
                    pshs      x         ; save x on the stack
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    bra       L097A     ; continue execution at L097A
L096C               pshs      u         ; save u on the stack
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    std       >$038F,y  ; store d at >$038F,y
                    leax      $08,s     ; form the address $08,s in x
                    pshs      x         ; save x on the stack
                    ldd       $08,s     ; load d from the current stack frame at $08,s
L097A               pshs      d         ; save d on the stack
                    leax      >L0E32,pc ; form the address >L0E32,pc in x
                    pshs      x         ; save x on the stack
                    bsr       L09AC     ; call subroutine L09AC
                    leas      $06,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $8F       ; store byte data
                    fcc       "0h4" ; store literal character data
                    fcb       $10       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $68       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $8D       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $8D       ; store byte data
                    fcb       $0C       ; store byte data
                    fcc       "2fO_" ; store literal character data
                    fcb       $E7       ; store byte data
                    fcb       $B9       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $8F       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $C0       ; store byte data
L09AC               pshs      u         ; save u on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    leas      -$0B,s    ; adjust the system stack pointer
                    bra       L09C4     ; continue execution at L09C4
L09B4               ldb       $08,s     ; load b from the current stack frame at $08,s
                    lbeq      L0BF5     ; branch when the values are equal or the result is zero; target L0BF5
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    jsr       [<$11,s]  ; call subroutine [<$11,s]
                    leas      $02,s     ; adjust the system stack pointer
L09C4               ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    cmpb      #37       ; compare b with #37 and set the condition codes
                    bne       L09B4     ; branch when the values differ or the result is nonzero; target L09B4
                    ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       $02,s     ; store d in the current stack frame at $02,s
                    std       $06,s     ; store d in the current stack frame at $06,s
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    cmpb      #45       ; compare b with #45 and set the condition codes
                    bne       L09E9     ; branch when the values differ or the result is nonzero; target L09E9
                    ldd       #1        ; set d to the constant 1
                    std       >$03A5,y  ; store d at >$03A5,y
                    ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    bra       L09EF     ; continue execution at L09EF
L09E9               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >$03A5,y  ; store d at >$03A5,y
L09EF               ldb       $08,s     ; load b from the current stack frame at $08,s
                    cmpb      #48       ; compare b with #48 and set the condition codes
                    bne       L09FA     ; branch when the values differ or the result is nonzero; target L09FA
                    ldd       #48       ; set d to the constant 48
                    bra       L09FD     ; continue execution at L09FD
L09FA               ldd       #32       ; set d to the constant 32
L09FD               std       >$03A7,y  ; store d at >$03A7,y
                    bra       L0A1D     ; continue execution at L0A1D
L0A03               ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    lbsr      L132D     ; call subroutine L132D
                    pshs      d         ; save d on the stack
                    ldb       $0A,s     ; load b from the current stack frame at $0A,s
                    sex                 ; sign-extend b into d
                    addd      #-48      ; add to d using #-48
                    addd      ,s++      ; add to d using ,s++
                    std       $06,s     ; store d in the current stack frame at $06,s
                    ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
L0A1D               ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
                    leax      >$00DF,y  ; form the address >$00DF,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       0,x       ; load b from 0,x
                    clra                ; clear a to zero and set the condition codes
                    andb      #8        ; mask b using #8
                    bne       L0A03     ; branch when the values differ or the result is nonzero; target L0A03
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    cmpb      #46       ; compare b with #46 and set the condition codes
                    bne       L0A66     ; branch when the values differ or the result is nonzero; target L0A66
                    ldd       #1        ; set d to the constant 1
                    std       $04,s     ; store d in the current stack frame at $04,s
                    bra       L0A50     ; continue execution at L0A50
L0A3A               ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    lbsr      L132D     ; call subroutine L132D
                    pshs      d         ; save d on the stack
                    ldb       $0A,s     ; load b from the current stack frame at $0A,s
                    sex                 ; sign-extend b into d
                    addd      #-48      ; add to d using #-48
                    addd      ,s++      ; add to d using ,s++
                    std       $02,s     ; store d in the current stack frame at $02,s
L0A50               ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
                    leax      >$00DF,y  ; form the address >$00DF,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       0,x       ; load b from 0,x
                    clra                ; clear a to zero and set the condition codes
                    andb      #8        ; mask b using #8
                    bne       L0A3A     ; branch when the values differ or the result is nonzero; target L0A3A
                    bra       L0A6A     ; continue execution at L0A6A
L0A66               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       $04,s     ; store d in the current stack frame at $04,s
L0A6A               ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; copy the register values specified by d,x
                    lbra      L0B98     ; continue execution at L0B98
L0A72               ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldx       <$0015,s  ; load x from the current stack frame at <$0015,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0015,s  ; store x in the current stack frame at <$0015,s
                    ldd       -$02,x    ; load d from -$02,x
                    pshs      d         ; save d on the stack
                    lbsr      L0BF9     ; call subroutine L0BF9
                    bra       L0A9A     ; continue execution at L0A9A
L0A87               ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldx       <$0015,s  ; load x from the current stack frame at <$0015,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0015,s  ; store x in the current stack frame at <$0015,s
                    ldd       -$02,x    ; load d from -$02,x
                    pshs      d         ; save d on the stack
                    lbsr      L0CB6     ; call subroutine L0CB6
L0A9A               std       0,s       ; store d in the current stack frame at 0,s
                    lbra      L0B7E     ; continue execution at L0B7E
L0A9F               ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldb       $0A,s     ; load b from the current stack frame at $0A,s
                    sex                 ; sign-extend b into d
                    leax      >$00DF,y  ; form the address >$00DF,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       0,x       ; load b from 0,x
                    clra                ; clear a to zero and set the condition codes
                    andb      #2        ; mask b using #2
                    pshs      d         ; save d on the stack
                    ldx       <$0017,s  ; load x from the current stack frame at <$0017,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0017,s  ; store x in the current stack frame at <$0017,s
                    ldd       -$02,x    ; load d from -$02,x
                    pshs      d         ; save d on the stack
                    lbsr      L0CFE     ; call subroutine L0CFE
                    lbra      L0B7A     ; continue execution at L0B7A
L0AC5               ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldx       <$0015,s  ; load x from the current stack frame at <$0015,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0015,s  ; store x in the current stack frame at <$0015,s
                    ldd       -$02,x    ; load d from -$02,x
                    pshs      d         ; save d on the stack
                    leax      >$0391,y  ; form the address >$0391,y in x
                    pshs      x         ; save x on the stack
                    lbsr      L0C3D     ; call subroutine L0C3D
                    lbra      L0B7A     ; continue execution at L0B7A
L0AE1               ldd       $04,s     ; load d from the current stack frame at $04,s
                    bne       L0AEA     ; branch when the values differ or the result is nonzero; target L0AEA
                    ldd       #6        ; set d to the constant 6
                    std       $02,s     ; store d in the current stack frame at $02,s
L0AEA               ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    leax      <$0015,s  ; form the address <$0015,s in x
                    pshs      x         ; save x on the stack
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldb       $0E,s     ; load b from the current stack frame at $0E,s
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    lbsr      L129B     ; call subroutine L129B
                    leas      $06,s     ; adjust the system stack pointer
                    lbra      L0B7C     ; continue execution at L0B7C
L0B04               ldx       <$0013,s  ; load x from the current stack frame at <$0013,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0013,s  ; store x in the current stack frame at <$0013,s
                    ldd       -$02,x    ; load d from -$02,x
                    lbra      L0B8E     ; continue execution at L0B8E
L0B11               ldx       <$0013,s  ; load x from the current stack frame at <$0013,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0013,s  ; store x in the current stack frame at <$0013,s
                    ldd       -$02,x    ; load d from -$02,x
                    std       $09,s     ; store d in the current stack frame at $09,s
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    beq       L0B59     ; branch when the values are equal or the result is zero; target L0B59
                    ldd       $09,s     ; load d from the current stack frame at $09,s
                    std       $04,s     ; store d in the current stack frame at $04,s
                    bra       L0B33     ; continue execution at L0B33
L0B27               ldb       [<$09,s]  ; load b from the current stack frame at [<$09,s]
                    beq       L0B3F     ; branch when the values are equal or the result is zero; target L0B3F
                    ldd       $09,s     ; load d from the current stack frame at $09,s
                    addd      #1        ; add to d using #1
                    std       $09,s     ; store d in the current stack frame at $09,s
L0B33               ldd       $02,s     ; load d from the current stack frame at $02,s
                    addd      #-1       ; add to d using #-1
                    std       $02,s     ; store d in the current stack frame at $02,s
                    subd      #-1       ; subtract from d using #-1
                    bne       L0B27     ; branch when the values differ or the result is nonzero; target L0B27
L0B3F               ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       $0B,s     ; load d from the current stack frame at $0B,s
                    subd      $06,s     ; subtract from d using $06,s
                    pshs      d         ; save d on the stack
                    ldd       $08,s     ; load d from the current stack frame at $08,s
                    pshs      d         ; save d on the stack
                    ldd       <$0015,s  ; load d from the current stack frame at <$0015,s
                    pshs      d         ; save d on the stack
                    lbsr      L0D69     ; call subroutine L0D69
                    leas      $08,s     ; adjust the system stack pointer
                    bra       L0B88     ; continue execution at L0B88
L0B59               ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       $0B,s     ; load d from the current stack frame at $0B,s
                    bra       L0B7C     ; continue execution at L0B7C
L0B61               ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    bra       L0B69     ; continue execution at L0B69
                    fcb       $32       ; store byte data
                    fcb       $15       ; store byte data
L0B69               ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    leax      <$0015,s  ; form the address <$0015,s in x
                    pshs      x         ; save x on the stack
                    ldb       $0C,s     ; load b from the current stack frame at $0C,s
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    lbsr      L125D     ; call subroutine L125D
L0B7A               leas      $04,s     ; adjust the system stack pointer
L0B7C               pshs      d         ; save d on the stack
L0B7E               ldd       <$0013,s  ; load d from the current stack frame at <$0013,s
                    pshs      d         ; save d on the stack
                    lbsr      L0DCB     ; call subroutine L0DCB
                    leas      $06,s     ; adjust the system stack pointer
L0B88               lbra      L09C4     ; continue execution at L09C4
L0B8B               ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
L0B8E               pshs      d         ; save d on the stack
                    jsr       [<$11,s]  ; call subroutine [<$11,s]
                    leas      $02,s     ; adjust the system stack pointer
                    lbra      L09C4     ; continue execution at L09C4
L0B98               cmpx      #100      ; compare x with #100 and set the condition codes
                    lbeq      L0A72     ; branch when the values are equal or the result is zero; target L0A72
                    cmpx      #111      ; compare x with #111 and set the condition codes
                    lbeq      L0A87     ; branch when the values are equal or the result is zero; target L0A87
                    cmpx      #120      ; compare x with #120 and set the condition codes
                    lbeq      L0A9F     ; branch when the values are equal or the result is zero; target L0A9F
                    cmpx      #88       ; compare x with #88 and set the condition codes
                    lbeq      L0A9F     ; branch when the values are equal or the result is zero; target L0A9F
                    cmpx      #117      ; compare x with #117 and set the condition codes
                    lbeq      L0AC5     ; branch when the values are equal or the result is zero; target L0AC5
                    cmpx      #102      ; compare x with #102 and set the condition codes
                    lbeq      L0AE1     ; branch when the values are equal or the result is zero; target L0AE1
                    cmpx      #101      ; compare x with #101 and set the condition codes
                    lbeq      L0AE1     ; branch when the values are equal or the result is zero; target L0AE1
                    cmpx      #103      ; compare x with #103 and set the condition codes
                    lbeq      L0AE1     ; branch when the values are equal or the result is zero; target L0AE1
                    cmpx      #69       ; compare x with #69 and set the condition codes
                    lbeq      L0AE1     ; branch when the values are equal or the result is zero; target L0AE1
                    cmpx      #71       ; compare x with #71 and set the condition codes
                    lbeq      L0AE1     ; branch when the values are equal or the result is zero; target L0AE1
                    cmpx      #99       ; compare x with #99 and set the condition codes
                    lbeq      L0B04     ; branch when the values are equal or the result is zero; target L0B04
                    cmpx      #115      ; compare x with #115 and set the condition codes
                    lbeq      L0B11     ; branch when the values are equal or the result is zero; target L0B11
                    cmpx      #108      ; compare x with #108 and set the condition codes
                    lbeq      L0B61     ; branch when the values are equal or the result is zero; target L0B61
                    bra       L0B8B     ; continue execution at L0B8B
L0BF5               leas      $0B,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
L0BF9               pshs      u,d       ; save u,d on the stack
                    leax      >$0391,y  ; form the address >$0391,y in x
                    stx       0,s       ; store x in the current stack frame at 0,s
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    bge       L0C2E     ; branch when the signed value is greater than or equal; target L0C2E
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    nega                ; negate a
                    negb                ; negate b
                    sbca      #0        ; subtract with borrow from a using #0
                    std       $06,s     ; store d in the current stack frame at $06,s
                    bge       L0C23     ; branch when the signed value is greater than or equal; target L0C23
                    leax      >L0E57,pc ; form the address >L0E57,pc in x
                    pshs      x         ; save x on the stack
                    leax      >$0391,y  ; form the address >$0391,y in x
                    pshs      x         ; save x on the stack
                    lbsr      L12B7     ; call subroutine L12B7
                    leas      $04,s     ; adjust the system stack pointer
                    lbra      L0CFA     ; continue execution at L0CFA
L0C23               ldd       #45       ; set d to the constant 45
                    ldx       0,s       ; load x from the current stack frame at 0,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       0,s       ; store x in the current stack frame at 0,s
                    stb       -$01,x    ; store b at -$01,x
L0C2E               ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    bsr       L0C3D     ; call subroutine L0C3D
                    leas      $04,s     ; adjust the system stack pointer
                    lbra      L0CF4     ; continue execution at L0CF4
L0C3D               pshs      u,y,x,d   ; save u,y,x,d on the stack
                    ldu       $0A,s     ; load u from the current stack frame at $0A,s
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       $02,s     ; store d in the current stack frame at $02,s
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       0,s       ; store d in the current stack frame at 0,s
                    bra       L0C5A     ; continue execution at L0C5A
L0C4B               ldd       0,s       ; load d from the current stack frame at 0,s
                    addd      #1        ; add to d using #1
                    std       0,s       ; store d in the current stack frame at 0,s
                    ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    subd      >$0001,y  ; subtract from d using >$0001,y
                    std       $0C,s     ; store d in the current stack frame at $0C,s
L0C5A               ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    blt       L0C4B     ; branch when the signed value is less; target L0C4B
                    leax      >$0001,y  ; form the address >$0001,y in x
                    stx       $04,s     ; store x in the current stack frame at $04,s
                    bra       L0C9C     ; continue execution at L0C9C
L0C66               ldd       0,s       ; load d from the current stack frame at 0,s
                    addd      #1        ; add to d using #1
                    std       0,s       ; store d in the current stack frame at 0,s
L0C6D               ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    subd      [<$04,s]  ; subtract from d using [<$04,s]
                    std       $0C,s     ; store d in the current stack frame at $0C,s
                    bge       L0C66     ; branch when the signed value is greater than or equal; target L0C66
                    ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    addd      [<$04,s]  ; add to d using [<$04,s]
                    std       $0C,s     ; store d in the current stack frame at $0C,s
                    ldd       0,s       ; load d from the current stack frame at 0,s
                    beq       L0C86     ; branch when the values are equal or the result is zero; target L0C86
                    ldd       #1        ; set d to the constant 1
                    std       $02,s     ; store d in the current stack frame at $02,s
L0C86               ldd       $02,s     ; load d from the current stack frame at $02,s
                    beq       L0C91     ; branch when the values are equal or the result is zero; target L0C91
                    ldd       0,s       ; load d from the current stack frame at 0,s
                    addd      #48       ; add to d using #48
                    stb       ,u+       ; store b at ,u+
L0C91               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       0,s       ; store d in the current stack frame at 0,s
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    addd      #2        ; add to d using #2
                    std       $04,s     ; store d in the current stack frame at $04,s
L0C9C               ldd       $04,s     ; load d from the current stack frame at $04,s
                    cmpd      >$0009,y  ; compare d with >$0009,y and set the condition codes
                    bne       L0C6D     ; branch when the values differ or the result is nonzero; target L0C6D
                    ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    addd      #48       ; add to d using #48
                    stb       ,u+       ; store b at ,u+
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       U0000,u   ; store b at U0000,u
                    ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    leas      $06,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
L0CB6               pshs      u,d       ; save u,d on the stack
                    leax      >$0391,y  ; form the address >$0391,y in x
                    stx       0,s       ; store x in the current stack frame at 0,s
                    leau      >$039B,y  ; form the workspace or data address >$039B,y in u
L0CC2               ldd       $06,s     ; load d from the current stack frame at $06,s
                    clra                ; clear a to zero and set the condition codes
                    andb      #7        ; mask b using #7
                    addd      #48       ; add to d using #48
                    stb       ,u+       ; store b at ,u+
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    lsra                ; shift a right logically
                    rorb                ; rotate b right through carry
                    lsra                ; shift a right logically
                    rorb                ; rotate b right through carry
                    lsra                ; shift a right logically
                    rorb                ; rotate b right through carry
                    std       $06,s     ; store d in the current stack frame at $06,s
                    bne       L0CC2     ; branch when the values differ or the result is nonzero; target L0CC2
                    bra       L0CE4     ; continue execution at L0CE4
L0CDA               ldb       U0000,u   ; load b from U0000,u
                    ldx       0,s       ; load x from the current stack frame at 0,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       0,s       ; store x in the current stack frame at 0,s
                    stb       -$01,x    ; store b at -$01,x
L0CE4               leau      -$01,u    ; form the workspace or data address -$01,u in u
                    pshs      u         ; save u on the stack
                    leax      >$039B,y  ; form the address >$039B,y in x
                    cmpx      ,s++      ; compare x with ,s++ and set the condition codes
                    bls       L0CDA     ; branch when the unsigned value is lower or equal; target L0CDA
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       [,s]      ; store b in the current stack frame at [,s]
L0CF4               leax      >$0391,y  ; form the address >$0391,y in x
                    tfr       x,d       ; copy the register values specified by x,d
L0CFA               leas      $02,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
L0CFE               pshs      u,x,d     ; save u,x,d on the stack
                    leax      >$0391,y  ; form the address >$0391,y in x
                    stx       $02,s     ; store x in the current stack frame at $02,s
                    leau      >$039B,y  ; form the workspace or data address >$039B,y in u
L0D0A               ldd       $08,s     ; load d from the current stack frame at $08,s
                    clra                ; clear a to zero and set the condition codes
                    andb      #15       ; mask b using #15
                    std       0,s       ; store d in the current stack frame at 0,s
                    pshs      d         ; save d on the stack
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    cmpd      #9        ; compare d with #9 and set the condition codes
                    ble       L0D2C     ; branch when the signed value is less than or equal; target L0D2C
                    ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    beq       L0D24     ; branch when the values are equal or the result is zero; target L0D24
                    ldd       #65       ; set d to the constant 65
                    bra       L0D27     ; continue execution at L0D27
L0D24               ldd       #97       ; set d to the constant 97
L0D27               addd      #-10      ; add to d using #-10
                    bra       L0D2F     ; continue execution at L0D2F
L0D2C               ldd       #48       ; set d to the constant 48
L0D2F               addd      ,s++      ; add to d using ,s++
                    stb       ,u+       ; store b at ,u+
                    ldd       $08,s     ; load d from the current stack frame at $08,s
                    lsra                ; shift a right logically
                    rorb                ; rotate b right through carry
                    lsra                ; shift a right logically
                    rorb                ; rotate b right through carry
                    lsra                ; shift a right logically
                    rorb                ; rotate b right through carry
                    lsra                ; shift a right logically
                    rorb                ; rotate b right through carry
                    anda      #15       ; mask a using #15
                    std       $08,s     ; store d in the current stack frame at $08,s
                    bne       L0D0A     ; branch when the values differ or the result is nonzero; target L0D0A
                    bra       L0D4F     ; continue execution at L0D4F
L0D45               ldb       U0000,u   ; load b from U0000,u
                    ldx       $02,s     ; load x from the current stack frame at $02,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       $02,s     ; store x in the current stack frame at $02,s
                    stb       -$01,x    ; store b at -$01,x
L0D4F               leau      -$01,u    ; form the workspace or data address -$01,u in u
                    pshs      u         ; save u on the stack
                    leax      >$039B,y  ; form the address >$039B,y in x
                    cmpx      ,s++      ; compare x with ,s++ and set the condition codes
                    bls       L0D45     ; branch when the unsigned value is lower or equal; target L0D45
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       [<$02,s]  ; store b in the current stack frame at [<$02,s]
                    leax      >$0391,y  ; form the address >$0391,y in x
                    tfr       x,d       ; copy the register values specified by x,d
                    lbra      L0E41     ; continue execution at L0E41
L0D69               pshs      u         ; save u on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    subd      $08,s     ; subtract from d using $08,s
                    std       $0A,s     ; store d in the current stack frame at $0A,s
                    ldd       >$03A5,y  ; load d from >$03A5,y
                    bne       L0D9E     ; branch when the values differ or the result is nonzero; target L0D9E
                    bra       L0D86     ; continue execution at L0D86
L0D7B               ldd       >$03A7,y  ; load d from >$03A7,y
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
L0D86               ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    addd      #-1       ; add to d using #-1
                    std       $0A,s     ; store d in the current stack frame at $0A,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       L0D7B     ; branch when the signed value is greater; target L0D7B
                    bra       L0D9E     ; continue execution at L0D9E
L0D94               ldb       ,u+       ; load b from ,u+
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
L0D9E               ldd       $08,s     ; load d from the current stack frame at $08,s
                    addd      #-1       ; add to d using #-1
                    std       $08,s     ; store d in the current stack frame at $08,s
                    subd      #-1       ; subtract from d using #-1
                    bne       L0D94     ; branch when the values differ or the result is nonzero; target L0D94
                    ldd       >$03A5,y  ; load d from >$03A5,y
                    beq       L0DC9     ; branch when the values are equal or the result is zero; target L0DC9
                    bra       L0DBD     ; continue execution at L0DBD
L0DB2               ldd       >$03A7,y  ; load d from >$03A7,y
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
L0DBD               ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    addd      #-1       ; add to d using #-1
                    std       $0A,s     ; store d in the current stack frame at $0A,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       L0DB2     ; branch when the signed value is greater; target L0DB2
L0DC9               puls      pc,u      ; restore pc,u and return to the caller
L0DCB               pshs      u         ; save u on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    ldd       $08,s     ; load d from the current stack frame at $08,s
                    pshs      d         ; save d on the stack
                    pshs      u         ; save u on the stack
                    lbsr      L12A6     ; call subroutine L12A6
                    leas      $02,s     ; adjust the system stack pointer
                    nega                ; negate a
                    negb                ; negate b
                    sbca      #0        ; subtract with borrow from a using #0
                    addd      ,s++      ; add to d using ,s++
                    std       $08,s     ; store d in the current stack frame at $08,s
                    ldd       >$03A5,y  ; load d from >$03A5,y
                    bne       L0E0D     ; branch when the values differ or the result is nonzero; target L0E0D
                    bra       L0DF5     ; continue execution at L0DF5
L0DEA               ldd       >$03A7,y  ; load d from >$03A7,y
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
L0DF5               ldd       $08,s     ; load d from the current stack frame at $08,s
                    addd      #-1       ; add to d using #-1
                    std       $08,s     ; store d in the current stack frame at $08,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       L0DEA     ; branch when the signed value is greater; target L0DEA
                    bra       L0E0D     ; continue execution at L0E0D
L0E03               ldb       ,u+       ; load b from ,u+
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
L0E0D               ldb       U0000,u   ; load b from U0000,u
                    bne       L0E03     ; branch when the values differ or the result is nonzero; target L0E03
                    ldd       >$03A5,y  ; load d from >$03A5,y
                    beq       L0E30     ; branch when the values are equal or the result is zero; target L0E30
                    bra       L0E24     ; continue execution at L0E24
L0E19               ldd       >$03A7,y  ; load d from >$03A7,y
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
L0E24               ldd       $08,s     ; load d from the current stack frame at $08,s
                    addd      #-1       ; add to d using #-1
                    std       $08,s     ; store d in the current stack frame at $08,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       L0E19     ; branch when the signed value is greater; target L0E19
L0E30               puls      pc,u      ; restore pc,u and return to the caller
L0E32               fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $8F       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $1D       ; store byte data
L0E41               leas      $04,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $AE       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $8F       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $AF       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $8F       ; store byte data
                    fcb       $E7       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $C0       ; store byte data
L0E57               fcc       "-32768" ; store literal character data
                    fcb       $00       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $EE       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $46       ; store byte data
                    fcb       $84       ; store byte data
                    fcb       $80       ; store byte data
                    fcb       $C4       ; store byte data
                    fcb       $22       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $83       ; store byte data
                    fcb       $80       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $14       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $46       ; store byte data
                    fcb       $4F       ; store byte data
                    fcb       $C4       ; store byte data
                    fcb       $22       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $83       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $26       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $03       ; store byte data
                    fcc       "M2b" ; store literal character data
                    fcb       $EC       ; store byte data
                    fcb       $46       ; store byte data
                    fcb       $4F       ; store byte data
                    fcb       $C4       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcc       "0g4" ; store literal character data
                    fcb       $10       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $48       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $46       ; store byte data
                    fcb       $4F       ; store byte data
                    fcb       $C4       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $8D       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $43       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $8D       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $24       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $AD       ; store byte data
                    fcb       $84       ; store byte data
                    fcb       $32       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $83       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $26       ; store byte data
                    fcb       $4A       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $46       ; store byte data
                    fcb       $CA       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $46       ; store byte data
                    fcb       $16       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $DC       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $46       ; store byte data
                    fcb       $84       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $5F       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $7E       ; store byte data
                    fcb       $26       ; store byte data
                    fcb       $07       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $EB       ; store byte data
                    fcb       $32       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $C4       ; store byte data
                    fcb       $C3       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $C4       ; store byte data
                    fcb       $83       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $E7       ; store byte data
                    fcb       $84       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $C4       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $A3       ; store byte data
                    fcb       $44       ; store byte data
                    fcb       $24       ; store byte data
                    fcb       $0F       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $46       ; store byte data
                    fcb       $4F       ; store byte data
                    fcb       $C4       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $13       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $83       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $26       ; store byte data
                    fcb       $0B       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $BE       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $E1       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $26       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $9B       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $C0       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $EE       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $08       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $79       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $FF       ; store byte data
                    fcc       "F2d" ; store literal character data
                    fcb       $EC       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $3B       ; store byte data
                    fcb       $16       ; store byte data
                    fcb       $01       ; store byte data
                    fcc       "K" ; store literal character data
L0F26               pshs      u,d       ; save u,d on the stack
                    leau      >$000E,y  ; form the workspace or data address >$000E,y in u
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       0,s       ; store d in the current stack frame at 0,s
                    bra       L0F3C     ; continue execution at L0F3C
L0F32               tfr       u,d       ; copy the register values specified by u,d
                    leau      U000D,u   ; form the workspace or data address U000D,u in u
                    pshs      d         ; save d on the stack
                    bsr       L0F4F     ; call subroutine L0F4F
                    leas      $02,s     ; adjust the system stack pointer
L0F3C               ldd       0,s       ; load d from the current stack frame at 0,s
                    addd      #1        ; add to d using #1
                    std       0,s       ; store d in the current stack frame at 0,s
                    subd      #1        ; subtract from d using #1
                    cmpd      #16       ; compare d with #16 and set the condition codes
                    blt       L0F32     ; branch when the signed value is less; target L0F32
                    lbra      L0FB3     ; continue execution at L0FB3
L0F4F               pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    leas      -$02,s    ; adjust the system stack pointer
                    cmpu      #0        ; compare u with #0 and set the condition codes
                    beq       L0F5F     ; branch when the values are equal or the result is zero; target L0F5F
                    ldd       U0006,u   ; load d from U0006,u
                    bne       L0F65     ; branch when the values differ or the result is nonzero; target L0F65
L0F5F               ldd       #-1       ; set d to the constant -1
                    lbra      L0FB3     ; continue execution at L0FB3
L0F65               ldd       U0006,u   ; load d from U0006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #2        ; mask b using #2
                    beq       L0F74     ; branch when the values are equal or the result is zero; target L0F74
                    pshs      u         ; save u on the stack
                    bsr       L0F89     ; call subroutine L0F89
                    leas      $02,s     ; adjust the system stack pointer
                    bra       L0F76     ; continue execution at L0F76
L0F74               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
L0F76               std       0,s       ; store d in the current stack frame at 0,s
                    ldd       U0008,u   ; load d from U0008,u
                    pshs      d         ; save d on the stack
                    lbsr      L142D     ; call subroutine L142D
                    leas      $02,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       U0006,u   ; store d at U0006,u
                    ldd       0,s       ; load d from the current stack frame at 0,s
                    bra       L0FB3     ; continue execution at L0FB3
L0F89               pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    beq       L0F9A     ; branch when the values are equal or the result is zero; target L0F9A
                    ldd       U0006,u   ; load d from U0006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #34       ; mask b using #34
                    cmpd      #2        ; compare d with #2 and set the condition codes
                    beq       L0F9F     ; branch when the values are equal or the result is zero; target L0F9F
L0F9A               ldd       #-1       ; set d to the constant -1
                    puls      pc,u      ; restore pc,u and return to the caller
L0F9F               ldd       U0006,u   ; load d from U0006,u
                    anda      #128      ; mask a using #128
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    bne       L0FAF     ; branch when the values differ or the result is nonzero; target L0FAF
                    pshs      u         ; save u on the stack
                    lbsr      L11CD     ; call subroutine L11CD
                    leas      $02,s     ; adjust the system stack pointer
L0FAF               pshs      u         ; save u on the stack
                    bsr       L0FB7     ; call subroutine L0FB7
L0FB3               leas      $02,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
L0FB7               pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    leas      -$04,s    ; adjust the system stack pointer
                    ldd       U0006,u   ; load d from U0006,u
                    anda      #1        ; mask a using #1
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    bne       L0FE9     ; branch when the values differ or the result is nonzero; target L0FE9
                    ldd       U0000,u   ; load d from U0000,u
                    cmpd      U0004,u   ; compare d with U0004,u and set the condition codes
                    beq       L0FE9     ; branch when the values are equal or the result is zero; target L0FE9
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    pshs      u         ; save u on the stack
                    lbsr      L1075     ; call subroutine L1075
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       $02,x     ; load d from $02,x
                    pshs      d         ; save d on the stack
                    ldd       0,x       ; load d from 0,x
                    pshs      d         ; save d on the stack
                    ldd       U0008,u   ; load d from U0008,u
                    pshs      d         ; save d on the stack
                    lbsr      L14F4     ; call subroutine L14F4
                    leas      $08,s     ; adjust the system stack pointer
L0FE9               ldd       U0000,u   ; load d from U0000,u
                    subd      U0002,u   ; subtract from d using U0002,u
                    std       $02,s     ; store d in the current stack frame at $02,s
                    lbeq      L1061     ; branch when the values are equal or the result is zero; target L1061
                    ldd       U0006,u   ; load d from U0006,u
                    anda      #1        ; mask a using #1
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    lbeq      L1061     ; branch when the values are equal or the result is zero; target L1061
                    ldd       U0006,u   ; load d from U0006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #64       ; mask b using #64
                    beq       L1038     ; branch when the values are equal or the result is zero; target L1038
                    ldd       U0002,u   ; load d from U0002,u
                    bra       L1030     ; continue execution at L1030
L1009               ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    ldd       U0000,u   ; load d from U0000,u
                    pshs      d         ; save d on the stack
                    ldd       U0008,u   ; load d from U0008,u
                    pshs      d         ; save d on the stack
                    lbsr      L14E4     ; call subroutine L14E4
                    leas      $06,s     ; adjust the system stack pointer
                    std       0,s       ; store d in the current stack frame at 0,s
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    bne       L1026     ; branch when the values differ or the result is nonzero; target L1026
                    leax      $04,s     ; form the address $04,s in x
                    bra       L1050     ; continue execution at L1050
L1026               ldd       $02,s     ; load d from the current stack frame at $02,s
                    subd      0,s       ; subtract from d using 0,s
                    std       $02,s     ; store d in the current stack frame at $02,s
                    ldd       U0000,u   ; load d from U0000,u
                    addd      0,s       ; add to d using 0,s
L1030               std       U0000,u   ; store d at U0000,u
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    bne       L1009     ; branch when the values differ or the result is nonzero; target L1009
                    bra       L1061     ; continue execution at L1061
L1038               ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    ldd       U0002,u   ; load d from U0002,u
                    pshs      d         ; save d on the stack
                    ldd       U0008,u   ; load d from U0008,u
                    pshs      d         ; save d on the stack
                    lbsr      L14CB     ; call subroutine L14CB
                    leas      $06,s     ; adjust the system stack pointer
                    cmpd      $02,s     ; compare d with $02,s and set the condition codes
                    beq       L1061     ; branch when the values are equal or the result is zero; target L1061
                    bra       L1052     ; continue execution at L1052
L1050               leas      -$04,x    ; adjust the system stack pointer
L1052               ldd       U0006,u   ; load d from U0006,u
                    orb       #32       ; set selected bits in b using #32
                    std       U0006,u   ; store d at U0006,u
                    ldd       U0004,u   ; load d from U0004,u
                    std       U0000,u   ; store d at U0000,u
                    ldd       #-1       ; set d to the constant -1
                    bra       L1071     ; continue execution at L1071
L1061               ldd       U0006,u   ; load d from U0006,u
                    ora       #1        ; set selected bits in a using #1
                    std       U0006,u   ; store d at U0006,u
                    ldd       U0002,u   ; load d from U0002,u
                    std       U0000,u   ; store d at U0000,u
                    addd      U000B,u   ; add to d using U000B,u
                    std       U0004,u   ; store d at U0004,u
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
L1071               leas      $04,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
L1075               pshs      u         ; save u on the stack
                    puls      pc,u      ; restore pc,u and return to the caller
L1079               pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    beq       L10C5     ; branch when the values are equal or the result is zero; target L10C5
                    ldd       U0006,u   ; load d from U0006,u
                    anda      #1        ; mask a using #1
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    bne       L10C5     ; branch when the values differ or the result is nonzero; target L10C5
                    ldd       U0000,u   ; load d from U0000,u
                    cmpd      U0004,u   ; compare d with U0004,u and set the condition codes
                    bcc       L10A1     ; branch when carry is clear; target L10A1
                    ldd       U0000,u   ; load d from U0000,u
                    addd      #1        ; add to d using #1
                    std       U0000,u   ; store d at U0000,u
                    subd      #1        ; subtract from d using #1
                    tfr       d,x       ; copy the register values specified by d,x
                    ldb       0,x       ; load b from 0,x
                    clra                ; clear a to zero and set the condition codes
                    lbra      L11CB     ; continue execution at L11CB
L10A1               pshs      u         ; save u on the stack
                    lbsr      L1114     ; call subroutine L1114
                    lbra      L11C9     ; continue execution at L11C9
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $EE       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $16       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $46       ; store byte data
                    fcb       $4F       ; store byte data
                    fcb       $C4       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $0F       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $83       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $07       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $C4       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $A3       ; store byte data
                    fcb       $42       ; store byte data
                    fcb       $22       ; store byte data
                    fcb       $05       ; store byte data
L10C5               ldd       #-1       ; set d to the constant -1
                    puls      pc,u      ; restore pc,u and return to the caller
                    fcb       $EC       ; store byte data
                    fcb       $C4       ; store byte data
                    fcb       $C3       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $C4       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $E7       ; store byte data
                    fcb       $84       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $C0       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $EE       ; store byte data
                    fcc       "d2|4@" ; store literal character data
                    fcb       $17       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $93       ; store byte data
                    fcb       $32       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $83       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $0F       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $84       ; store byte data
                    fcb       $32       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $83       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $26       ; store byte data
                    fcb       $05       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $0C       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $08       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $95       ; store byte data
                    fcb       $E3       ; store byte data
                    fcb       $E4       ; store byte data
                    fcc       "2d5" ; store literal character data
                    fcb       $C0       ; store byte data
L1114               pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    leas      -$02,s    ; adjust the system stack pointer
                    ldd       U0006,u   ; load d from U0006,u
                    anda      #128      ; mask a using #128
                    andb      #49       ; mask b using #49
                    cmpd      #-32767   ; compare d with #-32767 and set the condition codes
                    beq       L113A     ; branch when the values are equal or the result is zero; target L113A
                    ldd       U0006,u   ; load d from U0006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #49       ; mask b using #49
                    cmpd      #1        ; compare d with #1 and set the condition codes
                    lbne      L11B3     ; branch when the values differ or the result is nonzero; target L11B3
                    pshs      u         ; save u on the stack
                    lbsr      L11CD     ; call subroutine L11CD
                    leas      $02,s     ; adjust the system stack pointer
L113A               leax      >$000E,y  ; form the address >$000E,y in x
                    pshs      x         ; save x on the stack
                    cmpu      ,s++      ; compare u with ,s++ and set the condition codes
                    bne       L1157     ; branch when the values differ or the result is nonzero; target L1157
                    ldd       U0006,u   ; load d from U0006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #64       ; mask b using #64
                    beq       L1157     ; branch when the values are equal or the result is zero; target L1157
                    leax      >$001B,y  ; form the address >$001B,y in x
                    pshs      x         ; save x on the stack
                    lbsr      L0F89     ; call subroutine L0F89
                    leas      $02,s     ; adjust the system stack pointer
L1157               ldd       U0006,u   ; load d from U0006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #8        ; mask b using #8
                    beq       L1183     ; branch when the values are equal or the result is zero; target L1183
                    ldd       U000B,u   ; load d from U000B,u
                    pshs      d         ; save d on the stack
                    ldd       U0002,u   ; load d from U0002,u
                    pshs      d         ; save d on the stack
                    ldd       U0008,u   ; load d from U0008,u
                    pshs      d         ; save d on the stack
                    ldd       U0006,u   ; load d from U0006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #64       ; mask b using #64
                    beq       L1177     ; branch when the values are equal or the result is zero; target L1177
                    leax      >L14BB,pc ; form the address >L14BB,pc in x
                    bra       L117B     ; continue execution at L117B
L1177               leax      >L149A,pc ; form the address >L149A,pc in x
L117B               tfr       x,d       ; copy the register values specified by x,d
                    tfr       d,x       ; copy the register values specified by d,x
                    jsr       0,x       ; call subroutine 0,x
                    bra       L1195     ; continue execution at L1195
L1183               ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      U000A,u   ; form the address U000A,u in x
                    stx       U0002,u   ; store x at U0002,u
                    pshs      x         ; save x on the stack
                    ldd       U0008,u   ; load d from U0008,u
                    pshs      d         ; save d on the stack
                    lbsr      L149A     ; call subroutine L149A
L1195               leas      $06,s     ; adjust the system stack pointer
                    std       0,s       ; store d in the current stack frame at 0,s
                    ldd       0,s       ; load d from the current stack frame at 0,s
                    bgt       L11B8     ; branch when the signed value is greater; target L11B8
                    ldd       U0006,u   ; load d from U0006,u
                    pshs      d         ; save d on the stack
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    beq       L11AA     ; branch when the values are equal or the result is zero; target L11AA
                    ldd       #32       ; set d to the constant 32
                    bra       L11AD     ; continue execution at L11AD
L11AA               ldd       #16       ; set d to the constant 16
L11AD               ora       ,s+       ; set selected bits in a using ,s+
                    orb       ,s+       ; set selected bits in b using ,s+
                    std       U0006,u   ; store d at U0006,u
L11B3               ldd       #-1       ; set d to the constant -1
                    bra       L11C9     ; continue execution at L11C9
L11B8               ldd       U0002,u   ; load d from U0002,u
                    addd      #1        ; add to d using #1
                    std       U0000,u   ; store d at U0000,u
                    ldd       U0002,u   ; load d from U0002,u
                    addd      0,s       ; add to d using 0,s
                    std       U0004,u   ; store d at U0004,u
                    ldb       [<$02,u]  ; load b from [<$02,u]
                    clra                ; clear a to zero and set the condition codes
L11C9               leas      $02,s     ; adjust the system stack pointer
L11CB               puls      pc,u      ; restore pc,u and return to the caller
L11CD               pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    ldd       U0006,u   ; load d from U0006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #192      ; mask b using #192
                    bne       L1205     ; branch when the values differ or the result is nonzero; target L1205
                    leas      -$20,s    ; adjust the system stack pointer
                    leax      0,s       ; form the address 0,s in x
                    pshs      x         ; save x on the stack
                    ldd       U0008,u   ; load d from U0008,u
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L13AF     ; call subroutine L13AF
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       U0006,u   ; load d from U0006,u
                    pshs      d         ; save d on the stack
                    ldb       $02,s     ; load b from the current stack frame at $02,s
                    bne       L11F9     ; branch when the values differ or the result is nonzero; target L11F9
                    ldd       #64       ; set d to the constant 64
                    bra       L11FC     ; continue execution at L11FC
L11F9               ldd       #128      ; set d to the constant 128
L11FC               ora       ,s+       ; set selected bits in a using ,s+
                    orb       ,s+       ; set selected bits in b using ,s+
                    std       U0006,u   ; store d at U0006,u
                    leas      <$0020,s  ; adjust the system stack pointer
L1205               ldd       U0006,u   ; load d from U0006,u
                    ora       #128      ; set selected bits in a using #128
                    std       U0006,u   ; store d at U0006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #12       ; mask b using #12
                    beq       L1212     ; branch when the values are equal or the result is zero; target L1212
                    puls      pc,u      ; restore pc,u and return to the caller
L1212               ldd       U000B,u   ; load d from U000B,u
                    bne       L1227     ; branch when the values differ or the result is nonzero; target L1227
                    ldd       U0006,u   ; load d from U0006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #64       ; mask b using #64
                    beq       L1222     ; branch when the values are equal or the result is zero; target L1222
                    ldd       #128      ; set d to the constant 128
                    bra       L1225     ; continue execution at L1225
L1222               ldd       #256      ; set d to the constant 256
L1225               std       U000B,u   ; store d at U000B,u
L1227               ldd       U0002,u   ; load d from U0002,u
                    bne       L123C     ; branch when the values differ or the result is nonzero; target L123C
                    ldd       U000B,u   ; load d from U000B,u
                    pshs      d         ; save d on the stack
                    lbsr      L15B2     ; call subroutine L15B2
                    leas      $02,s     ; adjust the system stack pointer
                    std       U0002,u   ; store d at U0002,u
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    beq       L1244     ; branch when the values are equal or the result is zero; target L1244
L123C               ldd       U0006,u   ; load d from U0006,u
                    orb       #8        ; set selected bits in b using #8
                    std       U0006,u   ; store d at U0006,u
                    bra       L1253     ; continue execution at L1253
L1244               ldd       U0006,u   ; load d from U0006,u
                    orb       #4        ; set selected bits in b using #4
                    std       U0006,u   ; store d at U0006,u
                    leax      U000A,u   ; form the address U000A,u in x
                    stx       U0002,u   ; store x at U0002,u
                    ldd       #1        ; set d to the constant 1
                    std       U000B,u   ; store d at U000B,u
L1253               ldd       U0002,u   ; load d from U0002,u
                    addd      U000B,u   ; add to d using U000B,u
                    std       U0004,u   ; store d at U0004,u
                    std       U0000,u   ; store d at U0000,u
                    puls      pc,u      ; restore pc,u and return to the caller
L125D               pshs      u         ; save u on the stack
                    ldb       $05,s     ; load b from the current stack frame at $05,s
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; copy the register values specified by d,x
                    bra       L1283     ; continue execution at L1283
L1266               ldd       [<$06,s]  ; load d from the current stack frame at [<$06,s]
                    addd      #4        ; add to d using #4
                    std       [<$06,s]  ; store d in the current stack frame at [<$06,s]
                    leax      >L129A,pc ; form the address >L129A,pc in x
                    bra       L127F     ; continue execution at L127F
L1275               ldb       $05,s     ; load b from the current stack frame at $05,s
                    stb       >$000C,y  ; store b at >$000C,y
                    leax      >$000B,y  ; form the address >$000B,y in x
L127F               tfr       x,d       ; copy the register values specified by x,d
                    puls      pc,u      ; restore pc,u and return to the caller
L1283               cmpx      #100      ; compare x with #100 and set the condition codes
                    beq       L1266     ; branch when the values are equal or the result is zero; target L1266
                    cmpx      #111      ; compare x with #111 and set the condition codes
                    lbeq      L1266     ; branch when the values are equal or the result is zero; target L1266
                    cmpx      #120      ; compare x with #120 and set the condition codes
                    lbeq      L1266     ; branch when the values are equal or the result is zero; target L1266
                    bra       L1275     ; continue execution at L1275
                    fcb       $35       ; store byte data
                    fcb       $C0       ; store byte data
L129A               fcb       $00       ; store byte data
L129B               pshs      u         ; save u on the stack
                    leax      >L12A5,pc ; form the address >L12A5,pc in x
                    tfr       x,d       ; copy the register values specified by x,d
                    puls      pc,u      ; restore pc,u and return to the caller
L12A5               fcb       $00       ; store byte data
L12A6               pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
L12AA               ldb       ,u+       ; load b from ,u+
                    bne       L12AA     ; branch when the values differ or the result is nonzero; target L12AA
                    tfr       u,d       ; copy the register values specified by u,d
                    subd      $04,s     ; subtract from d using $04,s
                    addd      #-1       ; add to d using #-1
                    puls      pc,u      ; restore pc,u and return to the caller
L12B7               pshs      u         ; save u on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    leas      -$02,s    ; adjust the system stack pointer
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    std       0,s       ; store d in the current stack frame at 0,s
L12C1               ldb       ,u+       ; load b from ,u+
                    ldx       0,s       ; load x from the current stack frame at 0,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       0,s       ; store x in the current stack frame at 0,s
                    stb       -$01,x    ; store b at -$01,x
                    bne       L12C1     ; branch when the values differ or the result is nonzero; target L12C1
                    bra       L12F6     ; continue execution at L12F6
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $EE       ; store byte data
                    fcc       "f2~" ; store literal character data
                    fcb       $EC       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $AE       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $AF       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $E6       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $26       ; store byte data
                    fcb       $F6       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $C3       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $E6       ; store byte data
                    fcb       $C0       ; store byte data
                    fcb       $AE       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $AF       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $E7       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $26       ; store byte data
                    fcb       $F4       ; store byte data
L12F6               ldd       $06,s     ; load d from the current stack frame at $06,s
                    leas      $02,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $EE       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $AE       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $AF       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $E6       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $26       ; store byte data
                    fcb       $04       ; store byte data
                    fcc       "O_5" ; store literal character data
                    fcb       $C0       ; store byte data
                    fcb       $33       ; store byte data
                    fcb       $41       ; store byte data
                    fcb       $E6       ; store byte data
                    fcb       $C4       ; store byte data
                    fcb       $1D       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $E6       ; store byte data
                    fcb       $F8       ; store byte data
                    fcb       $08       ; store byte data
                    fcb       $1D       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $A3       ; store byte data
                    fcb       $E1       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $E2       ; store byte data
                    fcb       $E6       ; store byte data
                    fcb       $F8       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $1D       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $E6       ; store byte data
                    fcb       $C4       ; store byte data
                    fcb       $1D       ; store byte data
                    fcb       $A3       ; store byte data
                    fcb       $E1       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $C0       ; store byte data
L132D               tsta                ; set condition codes from a without changing it
                    bne       L1342     ; branch when the values differ or the result is nonzero; target L1342
                    tst       $02,s     ; set condition codes from $02,s without changing it
                    bne       L1342     ; branch when the values differ or the result is nonzero; target L1342
                    lda       $03,s     ; load a from the current stack frame at $03,s
                    mul                 ; multiply a by b and return the product in d
                    ldx       0,s       ; load x from the current stack frame at 0,s
                    stx       $02,s     ; store x in the current stack frame at $02,s
                    ldx       #0        ; set x to the constant 0
                    std       0,s       ; store d in the current stack frame at 0,s
                    puls      pc,d      ; restore pc,d and return to the caller
L1342               pshs      d         ; save d on the stack
                    ldd       #0        ; set d to the constant 0
                    pshs      d         ; save d on the stack
                    pshs      d         ; save d on the stack
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    ldb       $09,s     ; load b from the current stack frame at $09,s
                    mul                 ; multiply a by b and return the product in d
                    std       $02,s     ; store d in the current stack frame at $02,s
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    mul                 ; multiply a by b and return the product in d
                    addd      $01,s     ; add to d using $01,s
                    std       $01,s     ; store d in the current stack frame at $01,s
                    bcc       L135F     ; branch when carry is clear; target L135F
                    inc       0,s       ; increment the value at 0,s
L135F               lda       $04,s     ; load a from the current stack frame at $04,s
                    ldb       $09,s     ; load b from the current stack frame at $09,s
                    mul                 ; multiply a by b and return the product in d
                    addd      $01,s     ; add to d using $01,s
                    std       $01,s     ; store d in the current stack frame at $01,s
                    bcc       L136C     ; branch when carry is clear; target L136C
                    inc       0,s       ; increment the value at 0,s
L136C               lda       $04,s     ; load a from the current stack frame at $04,s
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    mul                 ; multiply a by b and return the product in d
                    addd      0,s       ; add to d using 0,s
                    std       0,s       ; store d in the current stack frame at 0,s
                    ldx       $06,s     ; load x from the current stack frame at $06,s
                    stx       $08,s     ; store x in the current stack frame at $08,s
                    ldx       0,s       ; load x from the current stack frame at 0,s
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    leas      $08,s     ; adjust the system stack pointer
                    rts                 ; return to the caller
                    fcb       $5D       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $13       ; store byte data
                    fcc       "gbfcZ&" ; store literal character data
                    fcb       $F9       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $0A       ; store byte data
                    fcb       $5D       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $07       ; store byte data
                    fcc       "dbfcZ&" ; store literal character data
                    fcb       $F9       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $E4       ; store byte data
                    fcc       "2d9]'" ; store literal character data
                    fcb       $F0       ; store byte data
                    fcc       "hcibZ&" ; store literal character data
                    fcb       $F9       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $E7       ; store byte data
L13AF               lda       $05,s     ; load a from the current stack frame at $05,s
                    ldb       $03,s     ; load b from the current stack frame at $03,s
                    beq       L13E2     ; branch when the values are equal or the result is zero; target L13E2
                    cmpb      #1        ; compare b with #1 and set the condition codes
                    beq       L13E4     ; branch when the values are equal or the result is zero; target L13E4
                    cmpb      #6        ; compare b with #6 and set the condition codes
                    beq       L13E4     ; branch when the values are equal or the result is zero; target L13E4
                    cmpb      #2        ; compare b with #2 and set the condition codes
                    beq       L13CA     ; branch when the values are equal or the result is zero; target L13CA
                    cmpb      #5        ; compare b with #5 and set the condition codes
                    beq       L13CA     ; branch when the values are equal or the result is zero; target L13CA
                    ldb       #208      ; set b to the constant 208
                    lbra      L15DF     ; continue execution at L15DF
L13CA               pshs      u         ; save u on the stack
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    bcc       L13D6     ; branch when carry is clear; target L13D6
                    puls      u         ; restore u from the stack
                    lbra      L15DF     ; continue execution at L15DF
L13D6               stx       [<$08,s]  ; store x in the current stack frame at [<$08,s]
                    ldx       $08,s     ; load x from the current stack frame at $08,s
                    stu       $02,x     ; store u at $02,x
                    puls      u         ; restore u from the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    rts                 ; return to the caller
L13E2               ldx       $06,s     ; load x from the current stack frame at $06,s
L13E4               os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    lbra      L15E8     ; continue execution at L15E8
                    fcb       $A6       ; store byte data
                    fcb       $65       ; store byte data
                    fcb       $E6       ; store byte data
                    fcb       $63       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $09       ; store byte data
                    fcb       $C1       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $C6       ; store byte data
                    fcb       $D0       ; store byte data
                    fcb       $16       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $E6       ; store byte data
                    fcb       $AE       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $8E       ; store byte data
                    fcb       $16       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $E7       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $AE       ; store byte data
                    fcb       $68       ; store byte data
                    fcb       $EE       ; store byte data
                    fcb       $6A       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $8E       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $16       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $D9       ; store byte data
                    fcb       $AE       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $A6       ; store byte data
                    fcb       $65       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $84       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $8F       ; store byte data
                    fcb       $16       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $CA       ; store byte data
L141E               ldx       $02,s     ; load x from the current stack frame at $02,s
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L15DF     ; branch when carry reports an error or unsigned underflow; target L15DF
                    tfr       a,b       ; copy the register values specified by a,b
                    clra                ; clear a to zero and set the condition codes
                    rts                 ; return to the caller
L142D               lda       $03,s     ; load a from the current stack frame at $03,s
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lbra      L15E8     ; continue execution at L15E8
                    fcb       $AE       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $E6       ; store byte data
                    fcb       $65       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $85       ; store byte data
                    fcb       $16       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $A9       ; store byte data
L143F               ldx       $02,s     ; load x from the current stack frame at $02,s
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    tfr       a,b       ; copy the register values specified by a,b
                    andb      #36       ; mask b using #36
                    orb       #11       ; set selected bits in b using #11
                    os9       I$Create  ; invoke the OS-9 I$Create service
                    bcs       L1452     ; branch when carry reports an error or unsigned underflow; target L1452
L144E               tfr       a,b       ; copy the register values specified by a,b
                    clra                ; clear a to zero and set the condition codes
                    rts                 ; return to the caller
L1452               cmpb      #218      ; compare b with #218 and set the condition codes
                    lbne      L15DF     ; branch when the values differ or the result is nonzero; target L15DF
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    bita      #128      ; test selected bits in a using #128
                    lbne      L15DF     ; branch when the values differ or the result is nonzero; target L15DF
                    anda      #7        ; mask a using #7
                    ldx       $02,s     ; load x from the current stack frame at $02,s
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L15DF     ; branch when carry reports an error or unsigned underflow; target L15DF
                    pshs      u,a       ; save u,a on the stack
                    ldx       #0        ; set x to the constant 0
                    leau      0,x       ; form the workspace or data address 0,x in u
                    ldb       #2        ; set b to the constant 2
                    os9       I$SetStt  ; invoke the OS-9 I$SetStt service
                    puls      u,a       ; restore u,a from the stack
                    bcc       L144E     ; branch when carry is clear; target L144E
                    pshs      b         ; save b on the stack
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    puls      b         ; restore b from the stack
                    lbra      L15DF     ; continue execution at L15DF
                    fcb       $AE       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $87       ; store byte data
                    fcb       $16       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $5B       ; store byte data
                    fcb       $A6       ; store byte data
                    fcb       $63       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $82       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $49       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $89       ; store byte data
                    fcc       "O9" ; store literal character data
L149A               pshs      y         ; save y on the stack
                    ldx       $06,s     ; load x from the current stack frame at $06,s
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    ldy       $08,s     ; load y from the current stack frame at $08,s
                    pshs      y         ; save y on the stack
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    bcc       L14B7     ; branch when carry is clear; target L14B7
                    cmpb      #211      ; compare b with #211 and set the condition codes
                    bne       L14B2     ; branch when the values differ or the result is nonzero; target L14B2
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    puls      pc,y,x    ; restore pc,y,x and return to the caller
L14B2               puls      y,x       ; restore y,x from the stack
                    lbra      L15DF     ; continue execution at L15DF
L14B7               tfr       y,d       ; copy the register values specified by y,d
                    puls      pc,y,x    ; restore pc,y,x and return to the caller
L14BB               fcb       $34       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $A6       ; store byte data
                    fcb       $65       ; store byte data
                    fcb       $AE       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $AE       ; store byte data
                    fcc       "h4 " ; store literal character data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $8B       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $DD       ; store byte data
L14CB               pshs      y         ; save y on the stack
                    ldy       $08,s     ; load y from the current stack frame at $08,s
                    beq       L14E0     ; branch when the values are equal or the result is zero; target L14E0
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    ldx       $06,s     ; load x from the current stack frame at $06,s
                    os9       I$Write   ; invoke the OS-9 I$Write service
L14D9               bcc       L14E0     ; branch when carry is clear; target L14E0
                    puls      y         ; restore y from the stack
                    lbra      L15DF     ; continue execution at L15DF
L14E0               tfr       y,d       ; copy the register values specified by y,d
                    puls      pc,y      ; restore pc,y and return to the caller
L14E4               pshs      y         ; save y on the stack
                    ldy       $08,s     ; load y from the current stack frame at $08,s
                    beq       L14E0     ; branch when the values are equal or the result is zero; target L14E0
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    ldx       $06,s     ; load x from the current stack frame at $06,s
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    bra       L14D9     ; continue execution at L14D9
L14F4               pshs      u         ; save u on the stack
                    ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    bne       L1502     ; branch when the values differ or the result is nonzero; target L1502
                    ldu       #0        ; set u to the constant 0
                    ldx       #0        ; set x to the constant 0
                    bra       L1536     ; continue execution at L1536
L1502               cmpd      #1        ; compare d with #1 and set the condition codes
                    beq       L152D     ; branch when the values are equal or the result is zero; target L152D
                    cmpd      #2        ; compare d with #2 and set the condition codes
                    beq       L1522     ; branch when the values are equal or the result is zero; target L1522
                    ldb       #247      ; set b to the constant 247
L1510               clra                ; clear a to zero and set the condition codes
                    std       >$01AD,y  ; store d at >$01AD,y
                    ldd       #-1       ; set d to the constant -1
                    leax      >$01A1,y  ; form the address >$01A1,y in x
                    std       0,x       ; store d at 0,x
                    std       $02,x     ; store d at $02,x
                    puls      pc,u      ; restore pc,u and return to the caller
L1522               lda       $05,s     ; load a from the current stack frame at $05,s
                    ldb       #2        ; set b to the constant 2
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    bcs       L1510     ; branch when carry reports an error or unsigned underflow; target L1510
                    bra       L1536     ; continue execution at L1536
L152D               lda       $05,s     ; load a from the current stack frame at $05,s
                    ldb       #5        ; set b to the constant 5
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    bcs       L1510     ; branch when carry reports an error or unsigned underflow; target L1510
L1536               tfr       u,d       ; copy the register values specified by u,d
                    addd      $08,s     ; add to d using $08,s
                    std       >$01A3,y  ; store d at >$01A3,y
                    tfr       d,u       ; copy the register values specified by d,u
                    tfr       x,d       ; copy the register values specified by x,d
                    adcb      $07,s     ; add with carry to b using $07,s
                    adca      $06,s     ; add with carry to a using $06,s
                    bmi       L1510     ; branch when the result is negative; target L1510
                    tfr       d,x       ; copy the register values specified by d,x
                    std       >$01A1,y  ; store d at >$01A1,y
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    bcs       L1510     ; branch when carry reports an error or unsigned underflow; target L1510
                    leax      >$01A1,y  ; form the address >$01A1,y in x
                    puls      pc,u      ; restore pc,u and return to the caller
                    fcb       $EC       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $9F       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $A3       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $E3       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $9F       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $A3       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $07       ; store byte data
                    fcb       $1F       ; store byte data
                    fcc       " 5 $" ; store literal character data
                    fcb       $06       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcc       "2b9" ; store literal character data
                    fcb       $ED       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $9F       ; store byte data
                    fcb       $E3       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $A3       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $32       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $A3       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $9F       ; store byte data
                    fcb       $A3       ; store byte data
                    fcb       $E1       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $4F       ; store byte data
                    fcb       $AE       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $A7       ; store byte data
                    fcb       $80       ; store byte data
                    fcb       $AC       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $9F       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $F8       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $86       ; store byte data
L15B2               ldd       $02,s     ; load d from the current stack frame at $02,s
                    addd      >$01A9,y  ; add to d using >$01A9,y
                    bcs       L15DB     ; branch when carry reports an error or unsigned underflow; target L15DB
                    cmpd      >$01AB,y  ; compare d with >$01AB,y and set the condition codes
                    bcc       L15DB     ; branch when carry is clear; target L15DB
                    pshs      d         ; save d on the stack
                    ldx       >$01A9,y  ; load x from >$01A9,y
                    clra                ; clear a to zero and set the condition codes
L15C8               cmpx      0,s       ; compare x with 0,s and set the condition codes
                    bcc       L15D0     ; branch when carry is clear; target L15D0
                    sta       ,x+       ; store a at ,x+
                    bra       L15C8     ; continue execution at L15C8
L15D0               ldd       >$01A9,y  ; load d from >$01A9,y
                    puls      x         ; restore x from the stack
                    stx       >$01A9,y  ; store x at >$01A9,y
                    rts                 ; return to the caller
L15DB               ldd       #-1       ; set d to the constant -1
                    rts                 ; return to the caller
L15DF               clra                ; clear a to zero and set the condition codes
                    std       >$01AD,y  ; store d at >$01AD,y
                    ldd       #-1       ; set d to the constant -1
                    rts                 ; return to the caller
L15E8               bcs       L15DF     ; branch when carry reports an error or unsigned underflow; target L15DF
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    rts                 ; return to the caller
L15ED               lbsr      L15F8     ; call subroutine L15F8
                    lbsr      L0F26     ; call subroutine L0F26
L15F3               ldd       $02,s     ; load d from the current stack frame at $02,s
                    os9       F$Exit    ; invoke the OS-9 F$Exit service
L15F8               rts                 ; return to the caller
L15F9               fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $5E       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $E8       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $0A       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $09       ; store byte data
                    fcb       $6C       ; store byte data
                    fcb       $78       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $42       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $11       ; store byte data
                    fcb       $11       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $11       ; store byte data
                    fcb       $11       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $01       ; store byte data
                    fcc       "0               HHHHHHHHHH       BBBBBB" ; store literal character data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcc       "      DDDDDD" ; store literal character data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $04       ; store byte data
                    fcc       "    " ; store literal character data
                    fcb       $01       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $09       ; store byte data
                    fcc       "New_user" ; store literal character data
                    fcb       $00       ; store byte data

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
