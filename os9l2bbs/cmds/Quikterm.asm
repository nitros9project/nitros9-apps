**********************************************************************
* Quikterm - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       Quikterm
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
U000D               rmb       343       ; reserve 343 byte(s) in the module workspace
U0164               rmb       2         ; reserve 2 byte(s) in the module workspace
U0166               rmb       58        ; reserve 58 byte(s) in the module workspace
U01A0               rmb       1         ; reserve 1 byte(s) in the module workspace
U01A1               rmb       3         ; reserve 3 byte(s) in the module workspace
U01A4               rmb       2         ; reserve 2 byte(s) in the module workspace
U01A6               rmb       1250      ; reserve 1250 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /Quikterm/ ; store an OS-9 high-bit-terminated string
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
                    leax      >$0308,x  ; form the address >$0308,x in x
                    pshs      x         ; save x on the stack
                    leay      >L21E0,pc ; form the address >L21E0,pc in y
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
                    leax      >,pc      ; form the address >,pc in x
                    lbsr      L0164     ; call subroutine L0164
L0061               ldd       ,y++      ; load d from ,y++
                    beq       L006A     ; branch when the values are equal or the result is zero; target L006A
                    leax      U0000,u   ; form the address U0000,u in x
                    lbsr      L0164     ; call subroutine L0164
L006A               leas      $04,s     ; adjust the system stack pointer
                    puls      x         ; restore x from the stack
                    stx       >U01A4,u  ; store x at >U01A4,u
                    sty       >U0164,u  ; store y at >U0164,u
                    ldd       #1        ; set d to the constant 1
                    std       >U01A0,u  ; store d at >U01A0,u
                    leay      >U0166,u  ; form the address >U0166,u in y
                    leax      0,s       ; form the address 0,s in x
                    lda       ,x+       ; load a from ,x+
L0086               ldb       >U01A1,u  ; load b from >U01A1,u
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
                    inc       >U01A1,u  ; increment the value at >U01A1,u
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
                    inc       >U01A1,u  ; increment the value at >U01A1,u
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
L00E2               leax      >U0164,u  ; form the address >U0164,u in x
                    pshs      x         ; save x on the stack
                    ldd       >U01A0,u  ; load d from >U01A0,u
                    pshs      d         ; save d on the stack
                    leay      U0000,u   ; form the address U0000,u in y
                    bsr       L00FC     ; call subroutine L00FC
                    lbsr      L022F     ; call subroutine L022F
                    clr       ,-s       ; clear ,-s to zero and set the condition codes
                    clr       ,-s       ; clear ,-s to zero and set the condition codes
                    lbsr      L2127     ; call subroutine L2127
L00FC               leax      >$0308,y  ; form the address >$0308,y in x
                    stx       >$01AE,y  ; store x at >$01AE,y
                    sts       >$01A2,y  ; store s at >$01A2,y
                    sts       >$01B0,y  ; store s at >$01B0,y
                    ldd       #-126     ; set d to the constant -126
L0111               leax      d,s       ; form the address d,s in x
                    cmpx      >$01B0,y  ; compare x with >$01B0,y and set the condition codes
                    bcc       L0123     ; branch when carry is clear; target L0123
                    cmpx      >$01AE,y  ; compare x with >$01AE,y and set the condition codes
                    bcs       L013D     ; branch when carry reports an error or unsigned underflow; target L013D
                    stx       >$01B0,y  ; store x at >$01B0,y
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
                    lbsr      L212D     ; call subroutine L212D
                    ldd       >$01A2,y  ; load d from >$01A2,y
                    subd      >$01B0,y  ; subtract from d using >$01B0,y
                    rts                 ; return to the caller
                    fcb       $EC       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $B0       ; store byte data
                    fcb       $A3       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $AE       ; store byte data
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
L017E               fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $B0       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $8B       ; store byte data
                    fcb       $32       ; store byte data
                    fcb       $7A       ; store byte data
                    fcb       $AE       ; store byte data
                    fcb       $6A       ; store byte data
                    fcb       $16       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $94       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $B6       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $9D       ; store byte data
                    fcb       $32       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $DA       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $B6       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $1D       ; store byte data
                    fcb       $D5       ; store byte data
                    fcb       $32       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $DA       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $B4       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $1D       ; store byte data
                    fcb       $F1       ; store byte data
                    fcb       $32       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $16       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $B6       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $1D       ; store byte data
                    fcc       "E2b0" ; store literal character data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $B8       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $B4       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcc       "O_4" ; store literal character data
                    fcb       $06       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $1C       ; store byte data
                    fcb       $B2       ; store byte data
                    fcb       $32       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $E7       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $BC       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $E7       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $C8       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $05       ; store byte data
                    fcb       $E7       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $C9       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $E7       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $C3       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $B8       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $B4       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcc       "O_4" ; store literal character data
                    fcb       $06       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $1C       ; store byte data
                    fcb       $BC       ; store byte data
                    fcb       $32       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $6A       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $0A       ; store byte data
                    fcc       "2b " ; store literal character data
                    fcb       $0A       ; store byte data
                    fcb       $8C       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $0A       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $65       ; store byte data
                    fcb       $16       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $9A       ; store byte data
                    fcc       "2f5" ; store literal character data
                    fcb       $C0       ; store byte data
L022F               pshs      u         ; save u on the stack
                    ldd       #-75      ; set d to the constant -75
                    lbsr      L0111     ; call subroutine L0111
                    leas      -$01,s    ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >$01B4,y  ; store d at >$01B4,y
                    ldd       $05,s     ; load d from the current stack frame at $05,s
                    cmpd      #1        ; compare d with #1 and set the condition codes
                    bne       L0274     ; branch when the values differ or the result is nonzero; target L0274
                    ldd       #3        ; set d to the constant 3
                    pshs      d         ; save d on the stack
                    leax      >L0F04,pc ; form the address >L0F04,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L1F04     ; call subroutine L1F04
                    leas      $04,s     ; adjust the system stack pointer
                    std       >$01B6,y  ; store d at >$01B6,y
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    bne       L02AA     ; branch when the values differ or the result is nonzero; target L02AA
                    ldd       >$01B2,y  ; load d from >$01B2,y
                    pshs      d         ; save d on the stack
                    leax      >L0F08,pc ; form the address >L0F08,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L0E44     ; call subroutine L0E44
                    leas      $04,s     ; adjust the system stack pointer
                    bra       L02AA     ; continue execution at L02AA
L0274               ldd       #3        ; set d to the constant 3
                    pshs      d         ; save d on the stack
                    ldx       $09,s     ; load x from the current stack frame at $09,s
                    ldd       $02,x     ; load d from $02,x
                    pshs      d         ; save d on the stack
                    lbsr      L1F04     ; call subroutine L1F04
                    leas      $04,s     ; adjust the system stack pointer
                    std       >$01B6,y  ; store d at >$01B6,y
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    bne       L02AA     ; branch when the values differ or the result is nonzero; target L02AA
                    ldx       $07,s     ; load x from the current stack frame at $07,s
                    ldd       $02,x     ; load d from $02,x
                    pshs      d         ; save d on the stack
                    leax      >L0F18,pc ; form the address >L0F18,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L1440     ; call subroutine L1440
                    leas      $04,s     ; adjust the system stack pointer
                    ldd       >$01B2,y  ; load d from >$01B2,y
                    pshs      d         ; save d on the stack
                    lbsr      L2127     ; call subroutine L2127
                    leas      $02,s     ; adjust the system stack pointer
L02AA               leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L1E95     ; call subroutine L1E95
                    leas      $06,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       >$01BC,y  ; store b at >$01BC,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       >$01C9,y  ; store b at >$01C9,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       >$01C8,y  ; store b at >$01C8,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       >$01C3,y  ; store b at >$01C3,y
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L1ED0     ; call subroutine L1ED0
                    leas      $06,s     ; adjust the system stack pointer
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L1E95     ; call subroutine L1E95
                    leas      $06,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       >$01B9,y  ; store b at >$01B9,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       >$01BA,y  ; store b at >$01BA,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       >$01BB,y  ; store b at >$01BB,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       >$01BC,y  ; store b at >$01BC,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       >$01BD,y  ; store b at >$01BD,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       >$01BE,y  ; store b at >$01BE,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       >$01BF,y  ; store b at >$01BF,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       >$01C0,y  ; store b at >$01C0,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       >$01C1,y  ; store b at >$01C1,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       >$01C2,y  ; store b at >$01C2,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       >$01C3,y  ; store b at >$01C3,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       >$01C4,y  ; store b at >$01C4,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       >$01C5,y  ; store b at >$01C5,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       >$01C6,y  ; store b at >$01C6,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       >$01C7,y  ; store b at >$01C7,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       >$01C8,y  ; store b at >$01C8,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       >$01C9,y  ; store b at >$01C9,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       >$01CA,y  ; store b at >$01CA,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       >$01CB,y  ; store b at >$01CB,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       >$01CC,y  ; store b at >$01CC,y
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L1ED0     ; call subroutine L1ED0
                    leas      $06,s     ; adjust the system stack pointer
                    leax      >L017E,pc ; form the address >L017E,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L20F7     ; call subroutine L20F7
                    leas      $02,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L2184     ; call subroutine L2184
                    leas      $02,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L2193     ; call subroutine L2193
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >L0F28,pc ; form the address >L0F28,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L1440     ; call subroutine L1440
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >L0F48,pc ; form the address >L0F48,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L1440     ; call subroutine L1440
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >L0F68,pc ; form the address >L0F68,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L1440     ; call subroutine L1440
                    leas      $02,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L2198     ; call subroutine L2198
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >L0F88,pc ; form the address >L0F88,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L1440     ; call subroutine L1440
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >L0F8A,pc ; form the address >L0F8A,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L1440     ; call subroutine L1440
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >L0FC6,pc ; form the address >L0FC6,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L1440     ; call subroutine L1440
                    lbra      L0455     ; continue execution at L0455
L03F7               ldd       #10       ; set d to the constant 10
                    pshs      d         ; save d on the stack
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    lbsr      L2140     ; call subroutine L2140
                    leas      $04,s     ; adjust the system stack pointer
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    lbsr      L2133     ; call subroutine L2133
                    leas      $02,s     ; adjust the system stack pointer
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    beq       L044D     ; branch when the values are equal or the result is zero; target L044D
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      $02,s     ; form the address $02,s in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    lbsr      L1F80     ; call subroutine L1F80
                    leas      $06,s     ; adjust the system stack pointer
                    ldb       0,s       ; load b from the current stack frame at 0,s
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    bsr       L045A     ; call subroutine L045A
                    std       ,s++      ; store d in the current stack frame at ,s++
                    beq       L044B     ; branch when the values are equal or the result is zero; target L044B
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      $02,s     ; form the address $02,s in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    lbsr      L1FB1     ; call subroutine L1FB1
                    leas      $06,s     ; adjust the system stack pointer
L044B               bra       L03F7     ; continue execution at L03F7
L044D               ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L2067     ; call subroutine L2067
L0455               leas      $02,s     ; adjust the system stack pointer
                    lbra      L03F7     ; continue execution at L03F7
L045A               pshs      u         ; save u on the stack
                    ldd       #-74      ; set d to the constant -74
                    lbsr      L0111     ; call subroutine L0111
                    ldb       $05,s     ; load b from the current stack frame at $05,s
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; copy the register values specified by d,x
                    lbra      L051C     ; continue execution at L051C
L046A               ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    lbsr      L1F13     ; call subroutine L1F13
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L1E95     ; call subroutine L1E95
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    stb       >$01BC,y  ; store b at >$01BC,y
                    ldd       #3        ; set d to the constant 3
                    stb       >$01C8,y  ; store b at >$01C8,y
                    ldd       #5        ; set d to the constant 5
                    stb       >$01C9,y  ; store b at >$01C9,y
                    ldd       #13       ; set d to the constant 13
                    stb       >$01C3,y  ; store b at >$01C3,y
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L1ED0     ; call subroutine L1ED0
                    leas      $06,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L2184     ; call subroutine L2184
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >L1008,pc ; form the address >L1008,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L1440     ; call subroutine L1440
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >L1020,pc ; form the address >L1020,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L1440     ; call subroutine L1440
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >L1046,pc ; form the address >L1046,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L1440     ; call subroutine L1440
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >L1064,pc ; form the address >L1064,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L1440     ; call subroutine L1440
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >L1075,pc ; form the address >L1075,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L1440     ; call subroutine L1440
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >L108B,pc ; form the address >L108B,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L1440     ; call subroutine L1440
                    leas      $02,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L2127     ; call subroutine L2127
                    leas      $02,s     ; adjust the system stack pointer
                    bra       L052A     ; continue execution at L052A
L0511               bsr       L052C     ; call subroutine L052C
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    puls      pc,u      ; restore pc,u and return to the caller
L0517               ldd       #1        ; set d to the constant 1
                    puls      pc,u      ; restore pc,u and return to the caller
L051C               cmpx      #-8       ; compare x with #-8 and set the condition codes
                    lbeq      L046A     ; branch when the values are equal or the result is zero; target L046A
                    cmpx      #-12      ; compare x with #-12 and set the condition codes
                    beq       L0511     ; branch when the values are equal or the result is zero; target L0511
                    bra       L0517     ; continue execution at L0517
L052A               puls      pc,u      ; restore pc,u and return to the caller
L052C               pshs      u         ; save u on the stack
                    ldd       #-75      ; set d to the constant -75
                    lbsr      L0111     ; call subroutine L0111
                    leas      -$01,s    ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L2184     ; call subroutine L2184
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >L10B5,pc ; form the address >L10B5,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L1440     ; call subroutine L1440
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >$0020,y  ; form the address >$0020,y in x
                    pshs      x         ; save x on the stack
                    lbsr      L1A6F     ; call subroutine L1A6F
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      $02,s     ; form the address $02,s in x
                    pshs      x         ; save x on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L1F80     ; call subroutine L1F80
                    leas      $06,s     ; adjust the system stack pointer
                    leax      >L10D1,pc ; form the address >L10D1,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L1440     ; call subroutine L1440
                    leas      $02,s     ; adjust the system stack pointer
                    ldb       0,s       ; load b from the current stack frame at 0,s
                    clra                ; clear a to zero and set the condition codes
                    andb      #223      ; mask b using #223
                    stb       0,s       ; store b in the current stack frame at 0,s
                    cmpb      #82       ; compare b with #82 and set the condition codes
                    bne       L0580     ; branch when the values differ or the result is nonzero; target L0580
                    lbsr      L08FD     ; call subroutine L08FD
L0580               leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L1E95     ; call subroutine L1E95
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       #4371     ; set d to the constant 4371
                    std       >$01D0,y  ; store d at >$01D0,y
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L1ED0     ; call subroutine L1ED0
                    leas      $06,s     ; adjust the system stack pointer
                    ldb       0,s       ; load b from the current stack frame at 0,s
                    cmpb      #83       ; compare b with #83 and set the condition codes
                    bne       L05B9     ; branch when the values differ or the result is nonzero; target L05B9
                    bsr       L05BD     ; call subroutine L05BD
L05B9               leas      $01,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
L05BD               pshs      u         ; save u on the stack
                    ldd       #-283     ; set d to the constant -283
                    lbsr      L0111     ; call subroutine L0111
                    leas      >$FF31,s  ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    std       0,s       ; store d in the current stack frame at 0,s
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    lbsr      L214C     ; call subroutine L214C
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L1E95     ; call subroutine L1E95
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    stb       >$01BC,y  ; store b at >$01BC,y
                    ldd       #13       ; set d to the constant 13
                    stb       >$01C3,y  ; store b at >$01C3,y
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L1ED0     ; call subroutine L1ED0
                    leas      $06,s     ; adjust the system stack pointer
                    leax      >L10D3,pc ; form the address >L10D3,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L1440     ; call subroutine L1440
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >$0013,y  ; form the address >$0013,y in x
                    pshs      x         ; save x on the stack
                    ldd       #200      ; set d to the constant 200
                    pshs      d         ; save d on the stack
                    leax      $0B,s     ; form the address $0B,s in x
                    pshs      x         ; save x on the stack
                    lbsr      L13F7     ; call subroutine L13F7
                    leas      $06,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       >$01BC,y  ; store b at >$01BC,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       >$01C3,y  ; store b at >$01C3,y
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L1ED0     ; call subroutine L1ED0
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      $09,s     ; form the address $09,s in x
                    pshs      x         ; save x on the stack
                    lbsr      L1F04     ; call subroutine L1F04
                    leas      $04,s     ; adjust the system stack pointer
                    std       $04,s     ; store d in the current stack frame at $04,s
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    bne       L067B     ; branch when the values differ or the result is nonzero; target L067B
                    ldd       >$01B2,y  ; load d from >$01B2,y
                    pshs      d         ; save d on the stack
                    leax      >L10EB,pc ; form the address >L10EB,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L1440     ; call subroutine L1440
                    leas      $04,s     ; adjust the system stack pointer
                    lbra      L0C6C     ; continue execution at L0C6C
L067B               leax      >L1107,pc ; form the address >L1107,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L1440     ; call subroutine L1440
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >L1140,pc ; form the address >L1140,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L1440     ; call subroutine L1440
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L1E95     ; call subroutine L1E95
                    leas      $06,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       >$01BD,y  ; store b at >$01BD,y
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L1ED0     ; call subroutine L1ED0
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    stb       >$01D8,y  ; store b at >$01D8,y
                    ldd       #1        ; set d to the constant 1
                    stb       >$01D9,y  ; store b at >$01D9,y
                    sex                 ; sign-extend b into d
                    coma                ; complement every bit in a
                    comb                ; complement every bit in b
                    stb       >$01DA,y  ; store b at >$01DA,y
                    ldd       #128      ; set d to the constant 128
                    pshs      d         ; save d on the stack
                    leax      >$01DB,y  ; form the address >$01DB,y in x
                    pshs      x         ; save x on the stack
                    ldd       $08,s     ; load d from the current stack frame at $08,s
                    pshs      d         ; save d on the stack
                    lbsr      L1F80     ; call subroutine L1F80
                    leas      $06,s     ; adjust the system stack pointer
                    leax      >$01DB,y  ; form the address >$01DB,y in x
                    pshs      x         ; save x on the stack
                    lbsr      L0E0B     ; call subroutine L0E0B
                    leas      $02,s     ; adjust the system stack pointer
                    stb       >$025B,y  ; store b at >$025B,y
                    ldd       0,s       ; load d from the current stack frame at 0,s
                    pshs      d         ; save d on the stack
                    leax      >L1182,pc ; form the address >L1182,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L1440     ; call subroutine L1440
                    leas      $04,s     ; adjust the system stack pointer
                    leax      >$0020,y  ; form the address >$0020,y in x
                    pshs      x         ; save x on the stack
                    lbsr      L1A6F     ; call subroutine L1A6F
                    leas      $02,s     ; adjust the system stack pointer
                    lbra      L077A     ; continue execution at L077A
L0716               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L0EC9     ; call subroutine L0EC9
                    leas      $02,s     ; adjust the system stack pointer
                    cmpd      #-15      ; compare d with #-15 and set the condition codes
                    bne       L077A     ; branch when the values differ or the result is nonzero; target L077A
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L1E95     ; call subroutine L1E95
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    stb       >$01BD,y  ; store b at >$01BD,y
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L1ED0     ; call subroutine L1ED0
                    leas      $06,s     ; adjust the system stack pointer
                    leax      >L1198,pc ; form the address >L1198,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L1440     ; call subroutine L1440
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      >$0005,y  ; form the address >$0005,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    lbsr      L1FB1     ; call subroutine L1FB1
                    leas      $06,s     ; adjust the system stack pointer
                    lbra      L0C6C     ; continue execution at L0C6C
L077A               leax      $06,s     ; form the address $06,s in x
                    pshs      x         ; save x on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    lbsr      L0D73     ; call subroutine L0D73
                    leas      $08,s     ; adjust the system stack pointer
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    lbeq      L0716     ; branch when the values are equal or the result is zero; target L0716
                    ldb       $06,s     ; load b from the current stack frame at $06,s
                    cmpb      #21       ; compare b with #21 and set the condition codes
                    bne       L07B7     ; branch when the values differ or the result is nonzero; target L07B7
                    ldd       #132      ; set d to the constant 132
                    pshs      d         ; save d on the stack
                    leax      >$01D8,y  ; form the address >$01D8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    lbsr      L1FB1     ; call subroutine L1FB1
                    leas      $06,s     ; adjust the system stack pointer
L07B7               ldb       $06,s     ; load b from the current stack frame at $06,s
                    cmpb      #24       ; compare b with #24 and set the condition codes
                    bne       L0803     ; branch when the values differ or the result is nonzero; target L0803
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L1E95     ; call subroutine L1E95
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    stb       >$01BD,y  ; store b at >$01BD,y
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L1ED0     ; call subroutine L1ED0
                    leas      $06,s     ; adjust the system stack pointer
                    leax      >L11B0,pc ; form the address >L11B0,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L1440     ; call subroutine L1440
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    pshs      d         ; save d on the stack
                    lbsr      L1F13     ; call subroutine L1F13
                    lbra      L0C12     ; continue execution at L0C12
L0803               ldb       $06,s     ; load b from the current stack frame at $06,s
                    cmpb      #6        ; compare b with #6 and set the condition codes
                    lbne      L077A     ; branch when the values differ or the result is nonzero; target L077A
                    ldb       >$01D9,y  ; load b from >$01D9,y
                    addd      #1        ; add to d using #1
                    stb       >$01D9,y  ; store b at >$01D9,y
                    sex                 ; sign-extend b into d
                    coma                ; complement every bit in a
                    comb                ; complement every bit in b
                    stb       >$01DA,y  ; store b at >$01DA,y
                    ldd       0,s       ; load d from the current stack frame at 0,s
                    addd      #1        ; add to d using #1
                    std       0,s       ; store d in the current stack frame at 0,s
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    bra       L0839     ; continue execution at L0839
L0828               ldd       $02,s     ; load d from the current stack frame at $02,s
                    leax      >$01DB,y  ; form the address >$01DB,y in x
                    leax      d,x       ; form the address d,x in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       0,x       ; store b at 0,x
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    addd      #1        ; add to d using #1
L0839               std       $02,s     ; store d in the current stack frame at $02,s
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    cmpd      #127      ; compare d with #127 and set the condition codes
                    ble       L0828     ; branch when the signed value is less than or equal; target L0828
                    ldd       #128      ; set d to the constant 128
                    pshs      d         ; save d on the stack
                    leax      >$01DB,y  ; form the address >$01DB,y in x
                    pshs      x         ; save x on the stack
                    ldd       $08,s     ; load d from the current stack frame at $08,s
                    pshs      d         ; save d on the stack
                    lbsr      L1F80     ; call subroutine L1F80
                    leas      $06,s     ; adjust the system stack pointer
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    lbne      L08BB     ; branch when the values differ or the result is nonzero; target L08BB
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      >$0003,y  ; form the address >$0003,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    lbsr      L1FB1     ; call subroutine L1FB1
                    leas      $06,s     ; adjust the system stack pointer
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L1E95     ; call subroutine L1E95
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    stb       >$01BD,y  ; store b at >$01BD,y
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L1ED0     ; call subroutine L1ED0
                    leas      $06,s     ; adjust the system stack pointer
                    leax      >L11C8,pc ; form the address >L11C8,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L1440     ; call subroutine L1440
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    pshs      d         ; save d on the stack
                    lbsr      L1F13     ; call subroutine L1F13
                    leas      $02,s     ; adjust the system stack pointer
                    lbra      L0B9A     ; continue execution at L0B9A
L08BB               leax      >$01DB,y  ; form the address >$01DB,y in x
                    pshs      x         ; save x on the stack
                    lbsr      L0E0B     ; call subroutine L0E0B
                    leas      $02,s     ; adjust the system stack pointer
                    stb       >$025B,y  ; store b at >$025B,y
                    ldd       0,s       ; load d from the current stack frame at 0,s
                    pshs      d         ; save d on the stack
                    leax      >L11E1,pc ; form the address >L11E1,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L1440     ; call subroutine L1440
                    leas      $04,s     ; adjust the system stack pointer
                    leax      >$0020,y  ; form the address >$0020,y in x
                    pshs      x         ; save x on the stack
                    lbsr      L1A6F     ; call subroutine L1A6F
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #132      ; set d to the constant 132
                    pshs      d         ; save d on the stack
                    leax      >$01D8,y  ; form the address >$01D8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    lbsr      L1FB1     ; call subroutine L1FB1
                    leas      $06,s     ; adjust the system stack pointer
                    lbra      L077A     ; continue execution at L077A
L08FD               pshs      u         ; save u on the stack
                    ldd       #-283     ; set d to the constant -283
                    lbsr      L0111     ; call subroutine L0111
                    leas      >$FF31,s  ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    stb       $06,s     ; store b in the current stack frame at $06,s
                    ldd       #1        ; set d to the constant 1
                    std       $04,s     ; store d in the current stack frame at $04,s
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    lbsr      L214C     ; call subroutine L214C
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L1E95     ; call subroutine L1E95
                    leas      $06,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >$01D0,y  ; store d at >$01D0,y
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L1ED0     ; call subroutine L1ED0
                    leas      $06,s     ; adjust the system stack pointer
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L1E95     ; call subroutine L1E95
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    stb       >$01BC,y  ; store b at >$01BC,y
                    ldd       #13       ; set d to the constant 13
                    stb       >$01C3,y  ; store b at >$01C3,y
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L1ED0     ; call subroutine L1ED0
                    leas      $06,s     ; adjust the system stack pointer
                    leax      >L11F7,pc ; form the address >L11F7,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L1440     ; call subroutine L1440
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >$0013,y  ; form the address >$0013,y in x
                    pshs      x         ; save x on the stack
                    ldd       #200      ; set d to the constant 200
                    pshs      d         ; save d on the stack
                    leax      $0B,s     ; form the address $0B,s in x
                    pshs      x         ; save x on the stack
                    lbsr      L13F7     ; call subroutine L13F7
                    leas      $06,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       >$01BC,y  ; store b at >$01BC,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       >$01C3,y  ; store b at >$01C3,y
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L1ED0     ; call subroutine L1ED0
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      $09,s     ; form the address $09,s in x
                    pshs      x         ; save x on the stack
                    lbsr      L1EF5     ; call subroutine L1EF5
                    leas      $04,s     ; adjust the system stack pointer
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    beq       L09E1     ; branch when the values are equal or the result is zero; target L09E1
                    leax      >L1212,pc ; form the address >L1212,pc in x
                    lbra      L0AC4     ; continue execution at L0AC4
L09E1               ldd       #2        ; set d to the constant 2
                    pshs      d         ; save d on the stack
                    leax      $09,s     ; form the address $09,s in x
                    pshs      x         ; save x on the stack
                    lbsr      L1F25     ; call subroutine L1F25
                    leas      $04,s     ; adjust the system stack pointer
                    std       $02,s     ; store d in the current stack frame at $02,s
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    bne       L0A0B     ; branch when the values differ or the result is nonzero; target L0A0B
                    ldd       >$01B2,y  ; load d from >$01B2,y
                    pshs      d         ; save d on the stack
                    leax      >L1220,pc ; form the address >L1220,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L1440     ; call subroutine L1440
                    leas      $04,s     ; adjust the system stack pointer
                    lbra      L0C6C     ; continue execution at L0C6C
L0A0B               leax      >L123C,pc ; form the address >L123C,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L1440     ; call subroutine L1440
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >L1275,pc ; form the address >L1275,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L1440     ; call subroutine L1440
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L1E95     ; call subroutine L1E95
                    leas      $06,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       >$01BD,y  ; store b at >$01BD,y
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L1ED0     ; call subroutine L1ED0
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      >$0004,y  ; form the address >$0004,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    lbsr      L1FB1     ; call subroutine L1FB1
                    leas      $06,s     ; adjust the system stack pointer
                    lbra      L0D6A     ; continue execution at L0D6A
L0A6A               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L0EC9     ; call subroutine L0EC9
                    leas      $02,s     ; adjust the system stack pointer
                    cmpd      #-15      ; compare d with #-15 and set the condition codes
                    bne       L0ACC     ; branch when the values differ or the result is nonzero; target L0ACC
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      >$0005,y  ; form the address >$0005,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    lbsr      L1FB1     ; call subroutine L1FB1
                    leas      $06,s     ; adjust the system stack pointer
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L1E95     ; call subroutine L1E95
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    stb       >$01BD,y  ; store b at >$01BD,y
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L1ED0     ; call subroutine L1ED0
                    leas      $06,s     ; adjust the system stack pointer
                    leax      >L12B7,pc ; form the address >L12B7,pc in x
L0AC4               pshs      x         ; save x on the stack
                    lbsr      L1440     ; call subroutine L1440
                    lbra      L0C12     ; continue execution at L0C12
L0ACC               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       >$01D8,y  ; store b at >$01D8,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       0,s       ; store d in the current stack frame at 0,s
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    pshs      d         ; save d on the stack
                    leax      >L12D0,pc ; form the address >L12D0,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L1440     ; call subroutine L1440
                    leas      $04,s     ; adjust the system stack pointer
                    leax      >$0020,y  ; form the address >$0020,y in x
                    pshs      x         ; save x on the stack
                    lbsr      L1A6F     ; call subroutine L1A6F
                    leas      $02,s     ; adjust the system stack pointer
                    lbra      L0C72     ; continue execution at L0C72
L0AF3               leax      >$01D8,y  ; form the address >$01D8,y in x
                    pshs      x         ; save x on the stack
                    ldd       #10       ; set d to the constant 10
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    lbsr      L0D73     ; call subroutine L0D73
                    leas      $08,s     ; adjust the system stack pointer
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    bne       L0B35     ; branch when the values differ or the result is nonzero; target L0B35
                    leax      >L12E8,pc ; form the address >L12E8,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L1440     ; call subroutine L1440
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      >$0004,y  ; form the address >$0004,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    lbsr      L1FB1     ; call subroutine L1FB1
                    leas      $06,s     ; adjust the system stack pointer
L0B35               ldb       >$01D8,y  ; load b from >$01D8,y
                    cmpb      #4        ; compare b with #4 and set the condition codes
                    lbne      L0B9F     ; branch when the values differ or the result is nonzero; target L0B9F
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      >$0002,y  ; form the address >$0002,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    lbsr      L1FB1     ; call subroutine L1FB1
                    leas      $06,s     ; adjust the system stack pointer
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L1E95     ; call subroutine L1E95
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    stb       >$01BD,y  ; store b at >$01BD,y
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L1ED0     ; call subroutine L1ED0
                    leas      $06,s     ; adjust the system stack pointer
                    leax      >L12FC,pc ; form the address >L12FC,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L1440     ; call subroutine L1440
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    lbsr      L1F13     ; call subroutine L1F13
                    leas      $02,s     ; adjust the system stack pointer
L0B9A               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    lbra      L0D6D     ; continue execution at L0D6D
L0B9F               ldd       0,s       ; load d from the current stack frame at 0,s
                    addd      #1        ; add to d using #1
                    std       0,s       ; store d in the current stack frame at 0,s
                    subd      #1        ; subtract from d using #1
                    cmpd      #10       ; compare d with #10 and set the condition codes
                    lble      L0C17     ; branch when the signed value is less than or equal; target L0C17
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L1E95     ; call subroutine L1E95
                    leas      $06,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       >$01BD,y  ; store b at >$01BD,y
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L1ED0     ; call subroutine L1ED0
                    leas      $06,s     ; adjust the system stack pointer
                    leax      >L1316,pc ; form the address >L1316,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L1440     ; call subroutine L1440
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      >$0005,y  ; form the address >$0005,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    lbsr      L1FB1     ; call subroutine L1FB1
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    lbsr      L1F13     ; call subroutine L1F13
                    leas      $02,s     ; adjust the system stack pointer
                    leax      $07,s     ; form the address $07,s in x
                    pshs      x         ; save x on the stack
                    lbsr      L1F6B     ; call subroutine L1F6B
L0C12               leas      $02,s     ; adjust the system stack pointer
                    lbra      L0C6C     ; continue execution at L0C6C
L0C17               ldb       >$01D8,y  ; load b from >$01D8,y
                    cmpb      #24       ; compare b with #24 and set the condition codes
                    bne       L0C72     ; branch when the values differ or the result is nonzero; target L0C72
                    leax      >L1334,pc ; form the address >L1334,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L1440     ; call subroutine L1440
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    lbsr      L1F13     ; call subroutine L1F13
                    leas      $02,s     ; adjust the system stack pointer
                    leax      $07,s     ; form the address $07,s in x
                    pshs      x         ; save x on the stack
                    lbsr      L1F6B     ; call subroutine L1F6B
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L1E95     ; call subroutine L1E95
                    leas      $06,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       >$01BD,y  ; store b at >$01BD,y
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L1ED0     ; call subroutine L1ED0
                    leas      $06,s     ; adjust the system stack pointer
L0C6C               ldd       #-1       ; set d to the constant -1
                    lbra      L0D6D     ; continue execution at L0D6D
L0C72               ldb       >$01D8,y  ; load b from >$01D8,y
                    cmpb      #1        ; compare b with #1 and set the condition codes
                    lbne      L0AF3     ; branch when the values differ or the result is nonzero; target L0AF3
                    leax      >$01D9,y  ; form the address >$01D9,y in x
                    pshs      x         ; save x on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    ldd       #131      ; set d to the constant 131
                    pshs      d         ; save d on the stack
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    lbsr      L0D73     ; call subroutine L0D73
                    leas      $08,s     ; adjust the system stack pointer
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    bne       L0CBA     ; branch when the values differ or the result is nonzero; target L0CBA
                    ldd       >$01B2,y  ; load d from >$01B2,y
                    pshs      d         ; save d on the stack
                    leax      >L134C,pc ; form the address >L134C,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L1440     ; call subroutine L1440
                    leas      $04,s     ; adjust the system stack pointer
L0CAE               ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      >$0004,y  ; form the address >$0004,y in x
                    lbra      L0D5D     ; continue execution at L0D5D
L0CBA               ldb       >$01D9,y  ; load b from >$01D9,y
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    ldb       >$01DA,y  ; load b from >$01DA,y
                    sex                 ; sign-extend b into d
                    coma                ; complement every bit in a
                    comb                ; complement every bit in b
                    cmpd      ,s++      ; compare d with ,s++ and set the condition codes
                    beq       L0CDA     ; branch when the values are equal or the result is zero; target L0CDA
                    leax      >L1365,pc ; form the address >L1365,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L1440     ; call subroutine L1440
                    leas      $02,s     ; adjust the system stack pointer
                    bra       L0CAE     ; continue execution at L0CAE
L0CDA               ldb       >$01D9,y  ; load b from >$01D9,y
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
                    cmpd      ,s++      ; compare d with ,s++ and set the condition codes
                    beq       L0CF7     ; branch when the values are equal or the result is zero; target L0CF7
                    leax      >L1379,pc ; form the address >L1379,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L1440     ; call subroutine L1440
                    leas      $02,s     ; adjust the system stack pointer
                    lbra      L0CAE     ; continue execution at L0CAE
L0CF7               leax      >$01DB,y  ; form the address >$01DB,y in x
                    pshs      x         ; save x on the stack
                    lbsr      L0E0B     ; call subroutine L0E0B
                    leas      $02,s     ; adjust the system stack pointer
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    ldb       >$025B,y  ; load b from >$025B,y
                    sex                 ; sign-extend b into d
                    cmpd      ,s++      ; compare d with ,s++ and set the condition codes
                    beq       L0D32     ; branch when the values are equal or the result is zero; target L0D32
                    ldb       >$025B,y  ; load b from >$025B,y
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    leax      >$01DB,y  ; form the address >$01DB,y in x
                    pshs      x         ; save x on the stack
                    lbsr      L0E0B     ; call subroutine L0E0B
                    leas      $02,s     ; adjust the system stack pointer
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    leax      >L1387,pc ; form the address >L1387,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L1440     ; call subroutine L1440
                    leas      $06,s     ; adjust the system stack pointer
                    lbra      L0CAE     ; continue execution at L0CAE
L0D32               ldd       #128      ; set d to the constant 128
                    pshs      d         ; save d on the stack
                    leax      >$01DB,y  ; form the address >$01DB,y in x
                    pshs      x         ; save x on the stack
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    lbsr      L1FB1     ; call subroutine L1FB1
                    leas      $06,s     ; adjust the system stack pointer
                    ldb       $06,s     ; load b from the current stack frame at $06,s
                    addd      #1        ; add to d using #1
                    stb       $06,s     ; store b in the current stack frame at $06,s
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    addd      #1        ; add to d using #1
                    std       $04,s     ; store d in the current stack frame at $04,s
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      >$0002,y  ; form the address >$0002,y in x
L0D5D               pshs      x         ; save x on the stack
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    lbsr      L1FB1     ; call subroutine L1FB1
                    leas      $06,s     ; adjust the system stack pointer
L0D6A               lbra      L0A6A     ; continue execution at L0A6A
L0D6D               leas      >$00CF,s  ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
L0D73               pshs      u         ; save u on the stack
                    ldd       #-78      ; set d to the constant -78
                    lbsr      L0111     ; call subroutine L0111
                    leas      -$04,s    ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       0,s       ; store d in the current stack frame at 0,s
                    bra       L0D83     ; continue execution at L0D83
L0D83               ldd       $08,s     ; load d from the current stack frame at $08,s
                    pshs      d         ; save d on the stack
                    lbsr      L2133     ; call subroutine L2133
                    leas      $02,s     ; adjust the system stack pointer
                    std       $02,s     ; store d in the current stack frame at $02,s
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    bne       L0DC7     ; branch when the values differ or the result is nonzero; target L0DC7
                    ldd       0,s       ; load d from the current stack frame at 0,s
                    addd      #1        ; add to d using #1
                    std       0,s       ; store d in the current stack frame at 0,s
                    subd      #1        ; subtract from d using #1
                    cmpd      #60       ; compare d with #60 and set the condition codes
                    ble       L0DBB     ; branch when the signed value is less than or equal; target L0DBB
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       0,s       ; store d in the current stack frame at 0,s
                    ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    addd      #-1       ; add to d using #-1
                    std       $0C,s     ; store d in the current stack frame at $0C,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       L0DC5     ; branch when the signed value is greater; target L0DC5
                    ldd       #-1       ; set d to the constant -1
                    bra       L0E07     ; continue execution at L0E07
                    fcb       $20       ; store byte data
                    fcb       $0A       ; store byte data
L0DBB               ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L2067     ; call subroutine L2067
                    leas      $02,s     ; adjust the system stack pointer
L0DC5               bra       L0D83     ; continue execution at L0D83
L0DC7               ldd       $02,s     ; load d from the current stack frame at $02,s
                    cmpd      $0A,s     ; compare d with $0A,s and set the condition codes
                    bge       L0DF3     ; branch when the signed value is greater than or equal; target L0DF3
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    ldd       <$0010,s  ; load d from the current stack frame at <$0010,s
                    pshs      d         ; save d on the stack
                    ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    pshs      d         ; save d on the stack
                    lbsr      L1F80     ; call subroutine L1F80
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       $0E,s     ; load d from the current stack frame at $0E,s
                    addd      $02,s     ; add to d using $02,s
                    std       $0E,s     ; store d in the current stack frame at $0E,s
                    ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    subd      $02,s     ; subtract from d using $02,s
                    std       $0A,s     ; store d in the current stack frame at $0A,s
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       0,s       ; store d in the current stack frame at 0,s
                    lbra      L0D83     ; continue execution at L0D83
L0DF3               ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    pshs      d         ; save d on the stack
                    ldd       <$0010,s  ; load d from the current stack frame at <$0010,s
                    pshs      d         ; save d on the stack
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    lbsr      L1F80     ; call subroutine L1F80
                    leas      $06,s     ; adjust the system stack pointer
L0E07               leas      $04,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
L0E0B               pshs      u         ; save u on the stack
                    ldd       #-69      ; set d to the constant -69
                    lbsr      L0111     ; call subroutine L0111
                    leas      -$03,s    ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       $02,s     ; store b in the current stack frame at $02,s
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    bra       L0E34     ; continue execution at L0E34
L0E1D               ldb       $02,s     ; load b from the current stack frame at $02,s
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    ldx       $09,s     ; load x from the current stack frame at $09,s
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    leax      d,x       ; form the address d,x in x
                    ldb       0,x       ; load b from 0,x
                    sex                 ; sign-extend b into d
                    addd      ,s++      ; add to d using ,s++
                    stb       $02,s     ; store b in the current stack frame at $02,s
                    ldd       0,s       ; load d from the current stack frame at 0,s
                    addd      #1        ; add to d using #1
L0E34               std       0,s       ; store d in the current stack frame at 0,s
                    ldd       0,s       ; load d from the current stack frame at 0,s
                    cmpd      #127      ; compare d with #127 and set the condition codes
                    ble       L0E1D     ; branch when the signed value is less than or equal; target L0E1D
                    ldb       $02,s     ; load b from the current stack frame at $02,s
                    leas      $03,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
L0E44               pshs      u         ; save u on the stack
                    ldd       #-74      ; set d to the constant -74
                    lbsr      L0111     ; call subroutine L0111
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    lbsr      L1F13     ; call subroutine L1F13
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L1E95     ; call subroutine L1E95
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    stb       >$01BC,y  ; store b at >$01BC,y
                    ldd       #3        ; set d to the constant 3
                    stb       >$01C8,y  ; store b at >$01C8,y
                    ldd       #5        ; set d to the constant 5
                    stb       >$01C9,y  ; store b at >$01C9,y
                    ldd       #13       ; set d to the constant 13
                    stb       >$01C3,y  ; store b at >$01C3,y
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L1ED0     ; call subroutine L1ED0
                    leas      $06,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L2184     ; call subroutine L2184
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    pshs      d         ; save d on the stack
                    leax      >L139E,pc ; form the address >L139E,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L1440     ; call subroutine L1440
                    leas      $04,s     ; adjust the system stack pointer
                    leax      >L13A2,pc ; form the address >L13A2,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L1440     ; call subroutine L1440
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    lbsr      L2127     ; call subroutine L2127
                    bra       L0F00     ; continue execution at L0F00
L0EC9               pshs      u         ; save u on the stack
                    ldd       #-76      ; set d to the constant -76
                    lbsr      L0111     ; call subroutine L0111
                    leas      -$02,s    ; adjust the system stack pointer
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      L1E95     ; call subroutine L1E95
                    leas      $04,s     ; adjust the system stack pointer
                    stb       $01,s     ; store b in the current stack frame at $01,s
                    bne       L0EF9     ; branch when the values differ or the result is nonzero; target L0EF9
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      $02,s     ; form the address $02,s in x
                    pshs      x         ; save x on the stack
                    ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    pshs      d         ; save d on the stack
                    lbsr      L1F80     ; call subroutine L1F80
                    leas      $06,s     ; adjust the system stack pointer
                    bra       L0EFD     ; continue execution at L0EFD
L0EF9               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       0,s       ; store b in the current stack frame at 0,s
L0EFD               ldb       0,s       ; load b from the current stack frame at 0,s
                    sex                 ; sign-extend b into d
L0F00               leas      $02,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
L0F04               fcc       "/t2" ; store literal character data
                    fcb       $00       ; store byte data
L0F08               fcc       "Cannot open /t2" ; store literal character data
                    fcb       $00       ; store byte data
L0F18               fcc       "Cannot open %s" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L0F28               fcc       "Quik terminal Version 1.00    " ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L0F48               fcc       "By Alpha Software Technologies" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L0F68               fcc       "Released for shareware, 1988  " ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L0F88               fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L0F8A               fcc       "Press <ALT><x> to exit          <ALT><T> to transfer files" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L0FC6               fcc       "----------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L1008               fcc       "Quik terminal...exited" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L1020               fcb       $0D       ; store byte data
                    fcc       "For a free catalog please write to:" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L1046               fcb       $0D       ; store byte data
                    fcc       "Alpha Software Technologies" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L1064               fcc       "2810 Buffon St." ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L1075               fcc       "Chalmette, La. 70043" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L108B               fcb       $0D       ; store byte data
                    fcc       "or leave mail for 'ALPHASOFT' on DELPHI" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L10B5               fcc       "[R]ecieve or [s]end a file:" ; store literal character data
                    fcb       $00       ; store byte data
L10D1               fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L10D3               fcc       "Enter filename to send:" ; store literal character data
                    fcb       $00       ; store byte data
L10EB               fcc       "Cannot open file, error %d" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L1107               fcc       "Sending file                    press <ALT><q> to abort" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L1140               fcc       "----------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L1182               fcb       $0D       ; store byte data
                    fcc       "Sending block #%05u " ; store literal character data
                    fcb       $00       ; store byte data
L1198               fcc       "File transfer aborted!" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L11B0               fcc       "File transfer aborted!" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L11C8               fcc       "File transfer complete." ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L11E1               fcb       $0D       ; store byte data
                    fcc       "Sending block #%05u " ; store literal character data
                    fcb       $00       ; store byte data
L11F7               fcc       "Enter filename to recieve:" ; store literal character data
                    fcb       $00       ; store byte data
L1212               fcc       "File exists!" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L1220               fcc       "Cannot open file, error %d" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L123C               fcc       "Recieving file                  press <ALT><q> to abort" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L1275               fcc       "----------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L12B7               fcb       $0D       ; store byte data
                    fcc       "File transfer aborted!" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L12D0               fcb       $0D       ; store byte data
                    fcc       "Recieving block #%05u " ; store literal character data
                    fcb       $00       ; store byte data
L12E8               fcc       "Timeout/read error" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L12FC               fcc       "File receive successful." ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L1316               fcc       "Too many errors...I give up!" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L1334               fcc       "File transfer aborted!" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L134C               fcc       "Timeout/read error %d!!" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L1365               fcc       "Block # scrambled!" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L1379               fcc       "Bad block #!" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L1387               fcc       "Bad checksum! %d / %d" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L139E               fcb       $25       ; store byte data
                    fcb       $73       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L13A2               fcc       "Stupid terminal...exited" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $46       ; store byte data
                    fcb       $EE       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $E7       ; store byte data
                    fcb       $C0       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $13       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $07       ; store byte data
                    fcb       $90       ; store byte data
                    fcb       $32       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $83       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $08       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $83       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $26       ; store byte data
                    fcb       $E1       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $83       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $FF       ; store byte data
                    fcb       $26       ; store byte data
                    fcb       $04       ; store byte data
                    fcc       "O_ " ; store literal character data
                    fcb       $06       ; store byte data
                    fcb       $4F       ; store byte data
                    fcb       $5F       ; store byte data
                    fcb       $E7       ; store byte data
                    fcb       $C4       ; store byte data
                    fcb       $EC       ; store byte data
                    fcc       "f2b5" ; store literal character data
                    fcb       $C0       ; store byte data
L13F7               pshs      u         ; save u on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    leas      -$04,s    ; adjust the system stack pointer
                    ldd       $08,s     ; load d from the current stack frame at $08,s
                    std       0,s       ; store d in the current stack frame at 0,s
                    bra       L1411     ; continue execution at L1411
L1403               ldd       $02,s     ; load d from the current stack frame at $02,s
                    ldx       0,s       ; load x from the current stack frame at 0,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       0,s       ; store x in the current stack frame at 0,s
                    stb       -$01,x    ; store b at -$01,x
                    cmpb      #13       ; compare b with #13 and set the condition codes
                    beq       L142A     ; branch when the values are equal or the result is zero; target L142A
L1411               tfr       u,d       ; copy the register values specified by u,d
                    leau      -$01,u    ; form the workspace or data address -$01,u in u
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    ble       L142A     ; branch when the signed value is less than or equal; target L142A
                    ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    pshs      d         ; save d on the stack
                    lbsr      L1B5F     ; call subroutine L1B5F
                    leas      $02,s     ; adjust the system stack pointer
                    std       $02,s     ; store d in the current stack frame at $02,s
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    bne       L1403     ; branch when the values differ or the result is nonzero; target L1403
L142A               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       [,s]      ; store b in the current stack frame at [,s]
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    bne       L143A     ; branch when the values differ or the result is nonzero; target L143A
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    bra       L143C     ; continue execution at L143C
L143A               ldd       $08,s     ; load d from the current stack frame at $08,s
L143C               leas      $04,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
L1440               pshs      u         ; save u on the stack
                    leax      >$0020,y  ; form the address >$0020,y in x
                    stx       >$02DA,y  ; store x at >$02DA,y
                    leax      $06,s     ; form the address $06,s in x
                    pshs      x         ; save x on the stack
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    bra       L1460     ; continue execution at L1460
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $DA       ; store byte data
                    fcc       "0h4" ; store literal character data
                    fcb       $10       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $68       ; store byte data
L1460               pshs      d         ; save d on the stack
                    leax      >L1918,pc ; form the address >L1918,pc in x
                    pshs      x         ; save x on the stack
                    bsr       L1492     ; call subroutine L1492
                    leas      $06,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $DA       ; store byte data
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
                    fcb       $02       ; store byte data
                    fcb       $DA       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $C0       ; store byte data
L1492               pshs      u         ; save u on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    leas      -$0B,s    ; adjust the system stack pointer
                    bra       L14AA     ; continue execution at L14AA
L149A               ldb       $08,s     ; load b from the current stack frame at $08,s
                    lbeq      L16DB     ; branch when the values are equal or the result is zero; target L16DB
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    jsr       [<$11,s]  ; call subroutine [<$11,s]
                    leas      $02,s     ; adjust the system stack pointer
L14AA               ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    cmpb      #37       ; compare b with #37 and set the condition codes
                    bne       L149A     ; branch when the values differ or the result is nonzero; target L149A
                    ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       $02,s     ; store d in the current stack frame at $02,s
                    std       $06,s     ; store d in the current stack frame at $06,s
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    cmpb      #45       ; compare b with #45 and set the condition codes
                    bne       L14CF     ; branch when the values differ or the result is nonzero; target L14CF
                    ldd       #1        ; set d to the constant 1
                    std       >$02F0,y  ; store d at >$02F0,y
                    ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    bra       L14D5     ; continue execution at L14D5
L14CF               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >$02F0,y  ; store d at >$02F0,y
L14D5               ldb       $08,s     ; load b from the current stack frame at $08,s
                    cmpb      #48       ; compare b with #48 and set the condition codes
                    bne       L14E0     ; branch when the values differ or the result is nonzero; target L14E0
                    ldd       #48       ; set d to the constant 48
                    bra       L14E3     ; continue execution at L14E3
L14E0               ldd       #32       ; set d to the constant 32
L14E3               std       >$02F2,y  ; store d at >$02F2,y
                    bra       L1503     ; continue execution at L1503
L14E9               ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    lbsr      L1E13     ; call subroutine L1E13
                    pshs      d         ; save d on the stack
                    ldb       $0A,s     ; load b from the current stack frame at $0A,s
                    sex                 ; sign-extend b into d
                    addd      #-48      ; add to d using #-48
                    addd      ,s++      ; add to d using ,s++
                    std       $06,s     ; store d in the current stack frame at $06,s
                    ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
L1503               ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
                    leax      >$00E4,y  ; form the address >$00E4,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       0,x       ; load b from 0,x
                    clra                ; clear a to zero and set the condition codes
                    andb      #8        ; mask b using #8
                    bne       L14E9     ; branch when the values differ or the result is nonzero; target L14E9
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    cmpb      #46       ; compare b with #46 and set the condition codes
                    bne       L154C     ; branch when the values differ or the result is nonzero; target L154C
                    ldd       #1        ; set d to the constant 1
                    std       $04,s     ; store d in the current stack frame at $04,s
                    bra       L1536     ; continue execution at L1536
L1520               ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    lbsr      L1E13     ; call subroutine L1E13
                    pshs      d         ; save d on the stack
                    ldb       $0A,s     ; load b from the current stack frame at $0A,s
                    sex                 ; sign-extend b into d
                    addd      #-48      ; add to d using #-48
                    addd      ,s++      ; add to d using ,s++
                    std       $02,s     ; store d in the current stack frame at $02,s
L1536               ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
                    leax      >$00E4,y  ; form the address >$00E4,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       0,x       ; load b from 0,x
                    clra                ; clear a to zero and set the condition codes
                    andb      #8        ; mask b using #8
                    bne       L1520     ; branch when the values differ or the result is nonzero; target L1520
                    bra       L1550     ; continue execution at L1550
L154C               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       $04,s     ; store d in the current stack frame at $04,s
L1550               ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; copy the register values specified by d,x
                    lbra      L167E     ; continue execution at L167E
L1558               ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldx       <$0015,s  ; load x from the current stack frame at <$0015,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0015,s  ; store x in the current stack frame at <$0015,s
                    ldd       -$02,x    ; load d from -$02,x
                    pshs      d         ; save d on the stack
                    lbsr      L16DF     ; call subroutine L16DF
                    bra       L1580     ; continue execution at L1580
L156D               ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldx       <$0015,s  ; load x from the current stack frame at <$0015,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0015,s  ; store x in the current stack frame at <$0015,s
                    ldd       -$02,x    ; load d from -$02,x
                    pshs      d         ; save d on the stack
                    lbsr      L179C     ; call subroutine L179C
L1580               std       0,s       ; store d in the current stack frame at 0,s
                    lbra      L1664     ; continue execution at L1664
L1585               ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldb       $0A,s     ; load b from the current stack frame at $0A,s
                    sex                 ; sign-extend b into d
                    leax      >$00E4,y  ; form the address >$00E4,y in x
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
                    lbsr      L17E4     ; call subroutine L17E4
                    lbra      L1660     ; continue execution at L1660
L15AB               ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldx       <$0015,s  ; load x from the current stack frame at <$0015,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0015,s  ; store x in the current stack frame at <$0015,s
                    ldd       -$02,x    ; load d from -$02,x
                    pshs      d         ; save d on the stack
                    leax      >$02DC,y  ; form the address >$02DC,y in x
                    pshs      x         ; save x on the stack
                    lbsr      L1723     ; call subroutine L1723
                    lbra      L1660     ; continue execution at L1660
L15C7               ldd       $04,s     ; load d from the current stack frame at $04,s
                    bne       L15D0     ; branch when the values differ or the result is nonzero; target L15D0
                    ldd       #6        ; set d to the constant 6
                    std       $02,s     ; store d in the current stack frame at $02,s
L15D0               ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    leax      <$0015,s  ; form the address <$0015,s in x
                    pshs      x         ; save x on the stack
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldb       $0E,s     ; load b from the current stack frame at $0E,s
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    lbsr      L1D81     ; call subroutine L1D81
                    leas      $06,s     ; adjust the system stack pointer
                    lbra      L1662     ; continue execution at L1662
L15EA               ldx       <$0013,s  ; load x from the current stack frame at <$0013,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0013,s  ; store x in the current stack frame at <$0013,s
                    ldd       -$02,x    ; load d from -$02,x
                    lbra      L1674     ; continue execution at L1674
L15F7               ldx       <$0013,s  ; load x from the current stack frame at <$0013,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0013,s  ; store x in the current stack frame at <$0013,s
                    ldd       -$02,x    ; load d from -$02,x
                    std       $09,s     ; store d in the current stack frame at $09,s
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    beq       L163F     ; branch when the values are equal or the result is zero; target L163F
                    ldd       $09,s     ; load d from the current stack frame at $09,s
                    std       $04,s     ; store d in the current stack frame at $04,s
                    bra       L1619     ; continue execution at L1619
L160D               ldb       [<$09,s]  ; load b from the current stack frame at [<$09,s]
                    beq       L1625     ; branch when the values are equal or the result is zero; target L1625
                    ldd       $09,s     ; load d from the current stack frame at $09,s
                    addd      #1        ; add to d using #1
                    std       $09,s     ; store d in the current stack frame at $09,s
L1619               ldd       $02,s     ; load d from the current stack frame at $02,s
                    addd      #-1       ; add to d using #-1
                    std       $02,s     ; store d in the current stack frame at $02,s
                    subd      #-1       ; subtract from d using #-1
                    bne       L160D     ; branch when the values differ or the result is nonzero; target L160D
L1625               ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       $0B,s     ; load d from the current stack frame at $0B,s
                    subd      $06,s     ; subtract from d using $06,s
                    pshs      d         ; save d on the stack
                    ldd       $08,s     ; load d from the current stack frame at $08,s
                    pshs      d         ; save d on the stack
                    ldd       <$0015,s  ; load d from the current stack frame at <$0015,s
                    pshs      d         ; save d on the stack
                    lbsr      L184F     ; call subroutine L184F
                    leas      $08,s     ; adjust the system stack pointer
                    bra       L166E     ; continue execution at L166E
L163F               ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       $0B,s     ; load d from the current stack frame at $0B,s
                    bra       L1662     ; continue execution at L1662
L1647               ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    bra       L164F     ; continue execution at L164F
                    fcb       $32       ; store byte data
                    fcb       $15       ; store byte data
L164F               ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    leax      <$0015,s  ; form the address <$0015,s in x
                    pshs      x         ; save x on the stack
                    ldb       $0C,s     ; load b from the current stack frame at $0C,s
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    lbsr      L1D43     ; call subroutine L1D43
L1660               leas      $04,s     ; adjust the system stack pointer
L1662               pshs      d         ; save d on the stack
L1664               ldd       <$0013,s  ; load d from the current stack frame at <$0013,s
                    pshs      d         ; save d on the stack
                    lbsr      L18B1     ; call subroutine L18B1
                    leas      $06,s     ; adjust the system stack pointer
L166E               lbra      L14AA     ; continue execution at L14AA
L1671               ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
L1674               pshs      d         ; save d on the stack
                    jsr       [<$11,s]  ; call subroutine [<$11,s]
                    leas      $02,s     ; adjust the system stack pointer
                    lbra      L14AA     ; continue execution at L14AA
L167E               cmpx      #100      ; compare x with #100 and set the condition codes
                    lbeq      L1558     ; branch when the values are equal or the result is zero; target L1558
                    cmpx      #111      ; compare x with #111 and set the condition codes
                    lbeq      L156D     ; branch when the values are equal or the result is zero; target L156D
                    cmpx      #120      ; compare x with #120 and set the condition codes
                    lbeq      L1585     ; branch when the values are equal or the result is zero; target L1585
                    cmpx      #88       ; compare x with #88 and set the condition codes
                    lbeq      L1585     ; branch when the values are equal or the result is zero; target L1585
                    cmpx      #117      ; compare x with #117 and set the condition codes
                    lbeq      L15AB     ; branch when the values are equal or the result is zero; target L15AB
                    cmpx      #102      ; compare x with #102 and set the condition codes
                    lbeq      L15C7     ; branch when the values are equal or the result is zero; target L15C7
                    cmpx      #101      ; compare x with #101 and set the condition codes
                    lbeq      L15C7     ; branch when the values are equal or the result is zero; target L15C7
                    cmpx      #103      ; compare x with #103 and set the condition codes
                    lbeq      L15C7     ; branch when the values are equal or the result is zero; target L15C7
                    cmpx      #69       ; compare x with #69 and set the condition codes
                    lbeq      L15C7     ; branch when the values are equal or the result is zero; target L15C7
                    cmpx      #71       ; compare x with #71 and set the condition codes
                    lbeq      L15C7     ; branch when the values are equal or the result is zero; target L15C7
                    cmpx      #99       ; compare x with #99 and set the condition codes
                    lbeq      L15EA     ; branch when the values are equal or the result is zero; target L15EA
                    cmpx      #115      ; compare x with #115 and set the condition codes
                    lbeq      L15F7     ; branch when the values are equal or the result is zero; target L15F7
                    cmpx      #108      ; compare x with #108 and set the condition codes
                    lbeq      L1647     ; branch when the values are equal or the result is zero; target L1647
                    bra       L1671     ; continue execution at L1671
L16DB               leas      $0B,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
L16DF               pshs      u,d       ; save u,d on the stack
                    leax      >$02DC,y  ; form the address >$02DC,y in x
                    stx       0,s       ; store x in the current stack frame at 0,s
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    bge       L1714     ; branch when the signed value is greater than or equal; target L1714
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    nega                ; negate a
                    negb                ; negate b
                    sbca      #0        ; subtract with borrow from a using #0
                    std       $06,s     ; store d in the current stack frame at $06,s
                    bge       L1709     ; branch when the signed value is greater than or equal; target L1709
                    leax      >L193D,pc ; form the address >L193D,pc in x
                    pshs      x         ; save x on the stack
                    leax      >$02DC,y  ; form the address >$02DC,y in x
                    pshs      x         ; save x on the stack
                    lbsr      L1D9D     ; call subroutine L1D9D
                    leas      $04,s     ; adjust the system stack pointer
                    lbra      L17E0     ; continue execution at L17E0
L1709               ldd       #45       ; set d to the constant 45
                    ldx       0,s       ; load x from the current stack frame at 0,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       0,s       ; store x in the current stack frame at 0,s
                    stb       -$01,x    ; store b at -$01,x
L1714               ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    bsr       L1723     ; call subroutine L1723
                    leas      $04,s     ; adjust the system stack pointer
                    lbra      L17DA     ; continue execution at L17DA
L1723               pshs      u,y,x,d   ; save u,y,x,d on the stack
                    ldu       $0A,s     ; load u from the current stack frame at $0A,s
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       $02,s     ; store d in the current stack frame at $02,s
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       0,s       ; store d in the current stack frame at 0,s
                    bra       L1740     ; continue execution at L1740
L1731               ldd       0,s       ; load d from the current stack frame at 0,s
                    addd      #1        ; add to d using #1
                    std       0,s       ; store d in the current stack frame at 0,s
                    ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    subd      >$0006,y  ; subtract from d using >$0006,y
                    std       $0C,s     ; store d in the current stack frame at $0C,s
L1740               ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    blt       L1731     ; branch when the signed value is less; target L1731
                    leax      >$0006,y  ; form the address >$0006,y in x
                    stx       $04,s     ; store x in the current stack frame at $04,s
                    bra       L1782     ; continue execution at L1782
L174C               ldd       0,s       ; load d from the current stack frame at 0,s
                    addd      #1        ; add to d using #1
                    std       0,s       ; store d in the current stack frame at 0,s
L1753               ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    subd      [<$04,s]  ; subtract from d using [<$04,s]
                    std       $0C,s     ; store d in the current stack frame at $0C,s
                    bge       L174C     ; branch when the signed value is greater than or equal; target L174C
                    ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    addd      [<$04,s]  ; add to d using [<$04,s]
                    std       $0C,s     ; store d in the current stack frame at $0C,s
                    ldd       0,s       ; load d from the current stack frame at 0,s
                    beq       L176C     ; branch when the values are equal or the result is zero; target L176C
                    ldd       #1        ; set d to the constant 1
                    std       $02,s     ; store d in the current stack frame at $02,s
L176C               ldd       $02,s     ; load d from the current stack frame at $02,s
                    beq       L1777     ; branch when the values are equal or the result is zero; target L1777
                    ldd       0,s       ; load d from the current stack frame at 0,s
                    addd      #48       ; add to d using #48
                    stb       ,u+       ; store b at ,u+
L1777               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       0,s       ; store d in the current stack frame at 0,s
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    addd      #2        ; add to d using #2
                    std       $04,s     ; store d in the current stack frame at $04,s
L1782               ldd       $04,s     ; load d from the current stack frame at $04,s
                    cmpd      >$000E,y  ; compare d with >$000E,y and set the condition codes
                    bne       L1753     ; branch when the values differ or the result is nonzero; target L1753
                    ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    addd      #48       ; add to d using #48
                    stb       ,u+       ; store b at ,u+
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       U0000,u   ; store b at U0000,u
                    ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    leas      $06,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
L179C               pshs      u,d       ; save u,d on the stack
                    leax      >$02DC,y  ; form the address >$02DC,y in x
                    stx       0,s       ; store x in the current stack frame at 0,s
                    leau      >$02E6,y  ; form the workspace or data address >$02E6,y in u
L17A8               ldd       $06,s     ; load d from the current stack frame at $06,s
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
                    bne       L17A8     ; branch when the values differ or the result is nonzero; target L17A8
                    bra       L17CA     ; continue execution at L17CA
L17C0               ldb       U0000,u   ; load b from U0000,u
                    ldx       0,s       ; load x from the current stack frame at 0,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       0,s       ; store x in the current stack frame at 0,s
                    stb       -$01,x    ; store b at -$01,x
L17CA               leau      -$01,u    ; form the workspace or data address -$01,u in u
                    pshs      u         ; save u on the stack
                    leax      >$02E6,y  ; form the address >$02E6,y in x
                    cmpx      ,s++      ; compare x with ,s++ and set the condition codes
                    bls       L17C0     ; branch when the unsigned value is lower or equal; target L17C0
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       [,s]      ; store b in the current stack frame at [,s]
L17DA               leax      >$02DC,y  ; form the address >$02DC,y in x
                    tfr       x,d       ; copy the register values specified by x,d
L17E0               leas      $02,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
L17E4               pshs      u,x,d     ; save u,x,d on the stack
                    leax      >$02DC,y  ; form the address >$02DC,y in x
                    stx       $02,s     ; store x in the current stack frame at $02,s
                    leau      >$02E6,y  ; form the workspace or data address >$02E6,y in u
L17F0               ldd       $08,s     ; load d from the current stack frame at $08,s
                    clra                ; clear a to zero and set the condition codes
                    andb      #15       ; mask b using #15
                    std       0,s       ; store d in the current stack frame at 0,s
                    pshs      d         ; save d on the stack
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    cmpd      #9        ; compare d with #9 and set the condition codes
                    ble       L1812     ; branch when the signed value is less than or equal; target L1812
                    ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    beq       L180A     ; branch when the values are equal or the result is zero; target L180A
                    ldd       #65       ; set d to the constant 65
                    bra       L180D     ; continue execution at L180D
L180A               ldd       #97       ; set d to the constant 97
L180D               addd      #-10      ; add to d using #-10
                    bra       L1815     ; continue execution at L1815
L1812               ldd       #48       ; set d to the constant 48
L1815               addd      ,s++      ; add to d using ,s++
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
                    bne       L17F0     ; branch when the values differ or the result is nonzero; target L17F0
                    bra       L1835     ; continue execution at L1835
L182B               ldb       U0000,u   ; load b from U0000,u
                    ldx       $02,s     ; load x from the current stack frame at $02,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       $02,s     ; store x in the current stack frame at $02,s
                    stb       -$01,x    ; store b at -$01,x
L1835               leau      -$01,u    ; form the workspace or data address -$01,u in u
                    pshs      u         ; save u on the stack
                    leax      >$02E6,y  ; form the address >$02E6,y in x
                    cmpx      ,s++      ; compare x with ,s++ and set the condition codes
                    bls       L182B     ; branch when the unsigned value is lower or equal; target L182B
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       [<$02,s]  ; store b in the current stack frame at [<$02,s]
                    leax      >$02DC,y  ; form the address >$02DC,y in x
                    tfr       x,d       ; copy the register values specified by x,d
                    lbra      L1927     ; continue execution at L1927
L184F               pshs      u         ; save u on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    subd      $08,s     ; subtract from d using $08,s
                    std       $0A,s     ; store d in the current stack frame at $0A,s
                    ldd       >$02F0,y  ; load d from >$02F0,y
                    bne       L1884     ; branch when the values differ or the result is nonzero; target L1884
                    bra       L186C     ; continue execution at L186C
L1861               ldd       >$02F2,y  ; load d from >$02F2,y
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
L186C               ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    addd      #-1       ; add to d using #-1
                    std       $0A,s     ; store d in the current stack frame at $0A,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       L1861     ; branch when the signed value is greater; target L1861
                    bra       L1884     ; continue execution at L1884
L187A               ldb       ,u+       ; load b from ,u+
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
L1884               ldd       $08,s     ; load d from the current stack frame at $08,s
                    addd      #-1       ; add to d using #-1
                    std       $08,s     ; store d in the current stack frame at $08,s
                    subd      #-1       ; subtract from d using #-1
                    bne       L187A     ; branch when the values differ or the result is nonzero; target L187A
                    ldd       >$02F0,y  ; load d from >$02F0,y
                    beq       L18AF     ; branch when the values are equal or the result is zero; target L18AF
                    bra       L18A3     ; continue execution at L18A3
L1898               ldd       >$02F2,y  ; load d from >$02F2,y
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
L18A3               ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    addd      #-1       ; add to d using #-1
                    std       $0A,s     ; store d in the current stack frame at $0A,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       L1898     ; branch when the signed value is greater; target L1898
L18AF               puls      pc,u      ; restore pc,u and return to the caller
L18B1               pshs      u         ; save u on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    ldd       $08,s     ; load d from the current stack frame at $08,s
                    pshs      d         ; save d on the stack
                    pshs      u         ; save u on the stack
                    lbsr      L1D8C     ; call subroutine L1D8C
                    leas      $02,s     ; adjust the system stack pointer
                    nega                ; negate a
                    negb                ; negate b
                    sbca      #0        ; subtract with borrow from a using #0
                    addd      ,s++      ; add to d using ,s++
                    std       $08,s     ; store d in the current stack frame at $08,s
                    ldd       >$02F0,y  ; load d from >$02F0,y
                    bne       L18F3     ; branch when the values differ or the result is nonzero; target L18F3
                    bra       L18DB     ; continue execution at L18DB
L18D0               ldd       >$02F2,y  ; load d from >$02F2,y
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
L18DB               ldd       $08,s     ; load d from the current stack frame at $08,s
                    addd      #-1       ; add to d using #-1
                    std       $08,s     ; store d in the current stack frame at $08,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       L18D0     ; branch when the signed value is greater; target L18D0
                    bra       L18F3     ; continue execution at L18F3
L18E9               ldb       ,u+       ; load b from ,u+
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
L18F3               ldb       U0000,u   ; load b from U0000,u
                    bne       L18E9     ; branch when the values differ or the result is nonzero; target L18E9
                    ldd       >$02F0,y  ; load d from >$02F0,y
                    beq       L1916     ; branch when the values are equal or the result is zero; target L1916
                    bra       L190A     ; continue execution at L190A
L18FF               ldd       >$02F2,y  ; load d from >$02F2,y
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
L190A               ldd       $08,s     ; load d from the current stack frame at $08,s
                    addd      #-1       ; add to d using #-1
                    std       $08,s     ; store d in the current stack frame at $08,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       L18FF     ; branch when the signed value is greater; target L18FF
L1916               puls      pc,u      ; restore pc,u and return to the caller
L1918               fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $DA       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $1D       ; store byte data
L1927               leas      $04,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $AE       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $DA       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $AF       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $DA       ; store byte data
                    fcb       $E7       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $C0       ; store byte data
L193D               fcc       "-32768" ; store literal character data
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
L1A0C               pshs      u,d       ; save u,d on the stack
                    leau      >$0013,y  ; form the workspace or data address >$0013,y in u
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       0,s       ; store d in the current stack frame at 0,s
                    bra       L1A22     ; continue execution at L1A22
L1A18               tfr       u,d       ; copy the register values specified by u,d
                    leau      U000D,u   ; form the workspace or data address U000D,u in u
                    pshs      d         ; save d on the stack
                    bsr       L1A35     ; call subroutine L1A35
                    leas      $02,s     ; adjust the system stack pointer
L1A22               ldd       0,s       ; load d from the current stack frame at 0,s
                    addd      #1        ; add to d using #1
                    std       0,s       ; store d in the current stack frame at 0,s
                    subd      #1        ; subtract from d using #1
                    cmpd      #16       ; compare d with #16 and set the condition codes
                    blt       L1A18     ; branch when the signed value is less; target L1A18
                    lbra      L1A99     ; continue execution at L1A99
L1A35               pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    leas      -$02,s    ; adjust the system stack pointer
                    cmpu      #0        ; compare u with #0 and set the condition codes
                    beq       L1A45     ; branch when the values are equal or the result is zero; target L1A45
                    ldd       U0006,u   ; load d from U0006,u
                    bne       L1A4B     ; branch when the values differ or the result is nonzero; target L1A4B
L1A45               ldd       #-1       ; set d to the constant -1
                    lbra      L1A99     ; continue execution at L1A99
L1A4B               ldd       U0006,u   ; load d from U0006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #2        ; mask b using #2
                    beq       L1A5A     ; branch when the values are equal or the result is zero; target L1A5A
                    pshs      u         ; save u on the stack
                    bsr       L1A6F     ; call subroutine L1A6F
                    leas      $02,s     ; adjust the system stack pointer
                    bra       L1A5C     ; continue execution at L1A5C
L1A5A               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
L1A5C               std       0,s       ; store d in the current stack frame at 0,s
                    ldd       U0008,u   ; load d from U0008,u
                    pshs      d         ; save d on the stack
                    lbsr      L1F13     ; call subroutine L1F13
                    leas      $02,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       U0006,u   ; store d at U0006,u
                    ldd       0,s       ; load d from the current stack frame at 0,s
                    bra       L1A99     ; continue execution at L1A99
L1A6F               pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    beq       L1A80     ; branch when the values are equal or the result is zero; target L1A80
                    ldd       U0006,u   ; load d from U0006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #34       ; mask b using #34
                    cmpd      #2        ; compare d with #2 and set the condition codes
                    beq       L1A85     ; branch when the values are equal or the result is zero; target L1A85
L1A80               ldd       #-1       ; set d to the constant -1
                    puls      pc,u      ; restore pc,u and return to the caller
L1A85               ldd       U0006,u   ; load d from U0006,u
                    anda      #128      ; mask a using #128
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    bne       L1A95     ; branch when the values differ or the result is nonzero; target L1A95
                    pshs      u         ; save u on the stack
                    lbsr      L1CB3     ; call subroutine L1CB3
                    leas      $02,s     ; adjust the system stack pointer
L1A95               pshs      u         ; save u on the stack
                    bsr       L1A9D     ; call subroutine L1A9D
L1A99               leas      $02,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
L1A9D               pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    leas      -$04,s    ; adjust the system stack pointer
                    ldd       U0006,u   ; load d from U0006,u
                    anda      #1        ; mask a using #1
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    bne       L1ACF     ; branch when the values differ or the result is nonzero; target L1ACF
                    ldd       U0000,u   ; load d from U0000,u
                    cmpd      U0004,u   ; compare d with U0004,u and set the condition codes
                    beq       L1ACF     ; branch when the values are equal or the result is zero; target L1ACF
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    pshs      u         ; save u on the stack
                    lbsr      L1B5B     ; call subroutine L1B5B
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       $02,x     ; load d from $02,x
                    pshs      d         ; save d on the stack
                    ldd       0,x       ; load d from 0,x
                    pshs      d         ; save d on the stack
                    ldd       U0008,u   ; load d from U0008,u
                    pshs      d         ; save d on the stack
                    lbsr      L1FDA     ; call subroutine L1FDA
                    leas      $08,s     ; adjust the system stack pointer
L1ACF               ldd       U0000,u   ; load d from U0000,u
                    subd      U0002,u   ; subtract from d using U0002,u
                    std       $02,s     ; store d in the current stack frame at $02,s
                    lbeq      L1B47     ; branch when the values are equal or the result is zero; target L1B47
                    ldd       U0006,u   ; load d from U0006,u
                    anda      #1        ; mask a using #1
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    lbeq      L1B47     ; branch when the values are equal or the result is zero; target L1B47
                    ldd       U0006,u   ; load d from U0006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #64       ; mask b using #64
                    beq       L1B1E     ; branch when the values are equal or the result is zero; target L1B1E
                    ldd       U0002,u   ; load d from U0002,u
                    bra       L1B16     ; continue execution at L1B16
L1AEF               ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    ldd       U0000,u   ; load d from U0000,u
                    pshs      d         ; save d on the stack
                    ldd       U0008,u   ; load d from U0008,u
                    pshs      d         ; save d on the stack
                    lbsr      L1FCA     ; call subroutine L1FCA
                    leas      $06,s     ; adjust the system stack pointer
                    std       0,s       ; store d in the current stack frame at 0,s
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    bne       L1B0C     ; branch when the values differ or the result is nonzero; target L1B0C
                    leax      $04,s     ; form the address $04,s in x
                    bra       L1B36     ; continue execution at L1B36
L1B0C               ldd       $02,s     ; load d from the current stack frame at $02,s
                    subd      0,s       ; subtract from d using 0,s
                    std       $02,s     ; store d in the current stack frame at $02,s
                    ldd       U0000,u   ; load d from U0000,u
                    addd      0,s       ; add to d using 0,s
L1B16               std       U0000,u   ; store d at U0000,u
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    bne       L1AEF     ; branch when the values differ or the result is nonzero; target L1AEF
                    bra       L1B47     ; continue execution at L1B47
L1B1E               ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    ldd       U0002,u   ; load d from U0002,u
                    pshs      d         ; save d on the stack
                    ldd       U0008,u   ; load d from U0008,u
                    pshs      d         ; save d on the stack
                    lbsr      L1FB1     ; call subroutine L1FB1
                    leas      $06,s     ; adjust the system stack pointer
                    cmpd      $02,s     ; compare d with $02,s and set the condition codes
                    beq       L1B47     ; branch when the values are equal or the result is zero; target L1B47
                    bra       L1B38     ; continue execution at L1B38
L1B36               leas      -$04,x    ; adjust the system stack pointer
L1B38               ldd       U0006,u   ; load d from U0006,u
                    orb       #32       ; set selected bits in b using #32
                    std       U0006,u   ; store d at U0006,u
                    ldd       U0004,u   ; load d from U0004,u
                    std       U0000,u   ; store d at U0000,u
                    ldd       #-1       ; set d to the constant -1
                    bra       L1B57     ; continue execution at L1B57
L1B47               ldd       U0006,u   ; load d from U0006,u
                    ora       #1        ; set selected bits in a using #1
                    std       U0006,u   ; store d at U0006,u
                    ldd       U0002,u   ; load d from U0002,u
                    std       U0000,u   ; store d at U0000,u
                    addd      U000B,u   ; add to d using U000B,u
                    std       U0004,u   ; store d at U0004,u
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
L1B57               leas      $04,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
L1B5B               pshs      u         ; save u on the stack
                    puls      pc,u      ; restore pc,u and return to the caller
L1B5F               pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    beq       L1BAB     ; branch when the values are equal or the result is zero; target L1BAB
                    ldd       U0006,u   ; load d from U0006,u
                    anda      #1        ; mask a using #1
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    bne       L1BAB     ; branch when the values differ or the result is nonzero; target L1BAB
                    ldd       U0000,u   ; load d from U0000,u
                    cmpd      U0004,u   ; compare d with U0004,u and set the condition codes
                    bcc       L1B87     ; branch when carry is clear; target L1B87
                    ldd       U0000,u   ; load d from U0000,u
                    addd      #1        ; add to d using #1
                    std       U0000,u   ; store d at U0000,u
                    subd      #1        ; subtract from d using #1
                    tfr       d,x       ; copy the register values specified by d,x
                    ldb       0,x       ; load b from 0,x
                    clra                ; clear a to zero and set the condition codes
                    lbra      L1CB1     ; continue execution at L1CB1
L1B87               pshs      u         ; save u on the stack
                    lbsr      L1BFA     ; call subroutine L1BFA
                    lbra      L1CAF     ; continue execution at L1CAF
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
L1BAB               ldd       #-1       ; set d to the constant -1
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
L1BFA               pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    leas      -$02,s    ; adjust the system stack pointer
                    ldd       U0006,u   ; load d from U0006,u
                    anda      #128      ; mask a using #128
                    andb      #49       ; mask b using #49
                    cmpd      #-32767   ; compare d with #-32767 and set the condition codes
                    beq       L1C20     ; branch when the values are equal or the result is zero; target L1C20
                    ldd       U0006,u   ; load d from U0006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #49       ; mask b using #49
                    cmpd      #1        ; compare d with #1 and set the condition codes
                    lbne      L1C99     ; branch when the values differ or the result is nonzero; target L1C99
                    pshs      u         ; save u on the stack
                    lbsr      L1CB3     ; call subroutine L1CB3
                    leas      $02,s     ; adjust the system stack pointer
L1C20               leax      >$0013,y  ; form the address >$0013,y in x
                    pshs      x         ; save x on the stack
                    cmpu      ,s++      ; compare u with ,s++ and set the condition codes
                    bne       L1C3D     ; branch when the values differ or the result is nonzero; target L1C3D
                    ldd       U0006,u   ; load d from U0006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #64       ; mask b using #64
                    beq       L1C3D     ; branch when the values are equal or the result is zero; target L1C3D
                    leax      >$0020,y  ; form the address >$0020,y in x
                    pshs      x         ; save x on the stack
                    lbsr      L1A6F     ; call subroutine L1A6F
                    leas      $02,s     ; adjust the system stack pointer
L1C3D               ldd       U0006,u   ; load d from U0006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #8        ; mask b using #8
                    beq       L1C69     ; branch when the values are equal or the result is zero; target L1C69
                    ldd       U000B,u   ; load d from U000B,u
                    pshs      d         ; save d on the stack
                    ldd       U0002,u   ; load d from U0002,u
                    pshs      d         ; save d on the stack
                    ldd       U0008,u   ; load d from U0008,u
                    pshs      d         ; save d on the stack
                    ldd       U0006,u   ; load d from U0006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #64       ; mask b using #64
                    beq       L1C5D     ; branch when the values are equal or the result is zero; target L1C5D
                    leax      >L1FA1,pc ; form the address >L1FA1,pc in x
                    bra       L1C61     ; continue execution at L1C61
L1C5D               leax      >L1F80,pc ; form the address >L1F80,pc in x
L1C61               tfr       x,d       ; copy the register values specified by x,d
                    tfr       d,x       ; copy the register values specified by d,x
                    jsr       0,x       ; call subroutine 0,x
                    bra       L1C7B     ; continue execution at L1C7B
L1C69               ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      U000A,u   ; form the address U000A,u in x
                    stx       U0002,u   ; store x at U0002,u
                    pshs      x         ; save x on the stack
                    ldd       U0008,u   ; load d from U0008,u
                    pshs      d         ; save d on the stack
                    lbsr      L1F80     ; call subroutine L1F80
L1C7B               leas      $06,s     ; adjust the system stack pointer
                    std       0,s       ; store d in the current stack frame at 0,s
                    ldd       0,s       ; load d from the current stack frame at 0,s
                    bgt       L1C9E     ; branch when the signed value is greater; target L1C9E
                    ldd       U0006,u   ; load d from U0006,u
                    pshs      d         ; save d on the stack
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    beq       L1C90     ; branch when the values are equal or the result is zero; target L1C90
                    ldd       #32       ; set d to the constant 32
                    bra       L1C93     ; continue execution at L1C93
L1C90               ldd       #16       ; set d to the constant 16
L1C93               ora       ,s+       ; set selected bits in a using ,s+
                    orb       ,s+       ; set selected bits in b using ,s+
                    std       U0006,u   ; store d at U0006,u
L1C99               ldd       #-1       ; set d to the constant -1
                    bra       L1CAF     ; continue execution at L1CAF
L1C9E               ldd       U0002,u   ; load d from U0002,u
                    addd      #1        ; add to d using #1
                    std       U0000,u   ; store d at U0000,u
                    ldd       U0002,u   ; load d from U0002,u
                    addd      0,s       ; add to d using 0,s
                    std       U0004,u   ; store d at U0004,u
                    ldb       [<$02,u]  ; load b from [<$02,u]
                    clra                ; clear a to zero and set the condition codes
L1CAF               leas      $02,s     ; adjust the system stack pointer
L1CB1               puls      pc,u      ; restore pc,u and return to the caller
L1CB3               pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    ldd       U0006,u   ; load d from U0006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #192      ; mask b using #192
                    bne       L1CEB     ; branch when the values differ or the result is nonzero; target L1CEB
                    leas      -$20,s    ; adjust the system stack pointer
                    leax      0,s       ; form the address 0,s in x
                    pshs      x         ; save x on the stack
                    ldd       U0008,u   ; load d from U0008,u
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L1E95     ; call subroutine L1E95
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       U0006,u   ; load d from U0006,u
                    pshs      d         ; save d on the stack
                    ldb       $02,s     ; load b from the current stack frame at $02,s
                    bne       L1CDF     ; branch when the values differ or the result is nonzero; target L1CDF
                    ldd       #64       ; set d to the constant 64
                    bra       L1CE2     ; continue execution at L1CE2
L1CDF               ldd       #128      ; set d to the constant 128
L1CE2               ora       ,s+       ; set selected bits in a using ,s+
                    orb       ,s+       ; set selected bits in b using ,s+
                    std       U0006,u   ; store d at U0006,u
                    leas      <$0020,s  ; adjust the system stack pointer
L1CEB               ldd       U0006,u   ; load d from U0006,u
                    ora       #128      ; set selected bits in a using #128
                    std       U0006,u   ; store d at U0006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #12       ; mask b using #12
                    beq       L1CF8     ; branch when the values are equal or the result is zero; target L1CF8
                    puls      pc,u      ; restore pc,u and return to the caller
L1CF8               ldd       U000B,u   ; load d from U000B,u
                    bne       L1D0D     ; branch when the values differ or the result is nonzero; target L1D0D
                    ldd       U0006,u   ; load d from U0006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #64       ; mask b using #64
                    beq       L1D08     ; branch when the values are equal or the result is zero; target L1D08
                    ldd       #128      ; set d to the constant 128
                    bra       L1D0B     ; continue execution at L1D0B
L1D08               ldd       #256      ; set d to the constant 256
L1D0B               std       U000B,u   ; store d at U000B,u
L1D0D               ldd       U0002,u   ; load d from U0002,u
                    bne       L1D22     ; branch when the values differ or the result is nonzero; target L1D22
                    ldd       U000B,u   ; load d from U000B,u
                    pshs      d         ; save d on the stack
                    lbsr      L20CA     ; call subroutine L20CA
                    leas      $02,s     ; adjust the system stack pointer
                    std       U0002,u   ; store d at U0002,u
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    beq       L1D2A     ; branch when the values are equal or the result is zero; target L1D2A
L1D22               ldd       U0006,u   ; load d from U0006,u
                    orb       #8        ; set selected bits in b using #8
                    std       U0006,u   ; store d at U0006,u
                    bra       L1D39     ; continue execution at L1D39
L1D2A               ldd       U0006,u   ; load d from U0006,u
                    orb       #4        ; set selected bits in b using #4
                    std       U0006,u   ; store d at U0006,u
                    leax      U000A,u   ; form the address U000A,u in x
                    stx       U0002,u   ; store x at U0002,u
                    ldd       #1        ; set d to the constant 1
                    std       U000B,u   ; store d at U000B,u
L1D39               ldd       U0002,u   ; load d from U0002,u
                    addd      U000B,u   ; add to d using U000B,u
                    std       U0004,u   ; store d at U0004,u
                    std       U0000,u   ; store d at U0000,u
                    puls      pc,u      ; restore pc,u and return to the caller
L1D43               pshs      u         ; save u on the stack
                    ldb       $05,s     ; load b from the current stack frame at $05,s
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; copy the register values specified by d,x
                    bra       L1D69     ; continue execution at L1D69
L1D4C               ldd       [<$06,s]  ; load d from the current stack frame at [<$06,s]
                    addd      #4        ; add to d using #4
                    std       [<$06,s]  ; store d in the current stack frame at [<$06,s]
                    leax      >L1D80,pc ; form the address >L1D80,pc in x
                    bra       L1D65     ; continue execution at L1D65
L1D5B               ldb       $05,s     ; load b from the current stack frame at $05,s
                    stb       >$0011,y  ; store b at >$0011,y
                    leax      >$0010,y  ; form the address >$0010,y in x
L1D65               tfr       x,d       ; copy the register values specified by x,d
                    puls      pc,u      ; restore pc,u and return to the caller
L1D69               cmpx      #100      ; compare x with #100 and set the condition codes
                    beq       L1D4C     ; branch when the values are equal or the result is zero; target L1D4C
                    cmpx      #111      ; compare x with #111 and set the condition codes
                    lbeq      L1D4C     ; branch when the values are equal or the result is zero; target L1D4C
                    cmpx      #120      ; compare x with #120 and set the condition codes
                    lbeq      L1D4C     ; branch when the values are equal or the result is zero; target L1D4C
                    bra       L1D5B     ; continue execution at L1D5B
                    fcb       $35       ; store byte data
                    fcb       $C0       ; store byte data
L1D80               fcb       $00       ; store byte data
L1D81               pshs      u         ; save u on the stack
                    leax      >L1D8B,pc ; form the address >L1D8B,pc in x
                    tfr       x,d       ; copy the register values specified by x,d
                    puls      pc,u      ; restore pc,u and return to the caller
L1D8B               fcb       $00       ; store byte data
L1D8C               pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
L1D90               ldb       ,u+       ; load b from ,u+
                    bne       L1D90     ; branch when the values differ or the result is nonzero; target L1D90
                    tfr       u,d       ; copy the register values specified by u,d
                    subd      $04,s     ; subtract from d using $04,s
                    addd      #-1       ; add to d using #-1
                    puls      pc,u      ; restore pc,u and return to the caller
L1D9D               pshs      u         ; save u on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    leas      -$02,s    ; adjust the system stack pointer
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    std       0,s       ; store d in the current stack frame at 0,s
L1DA7               ldb       ,u+       ; load b from ,u+
                    ldx       0,s       ; load x from the current stack frame at 0,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       0,s       ; store x in the current stack frame at 0,s
                    stb       -$01,x    ; store b at -$01,x
                    bne       L1DA7     ; branch when the values differ or the result is nonzero; target L1DA7
                    bra       L1DDC     ; continue execution at L1DDC
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
L1DDC               ldd       $06,s     ; load d from the current stack frame at $06,s
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
L1E13               tsta                ; set condition codes from a without changing it
                    bne       L1E28     ; branch when the values differ or the result is nonzero; target L1E28
                    tst       $02,s     ; set condition codes from $02,s without changing it
                    bne       L1E28     ; branch when the values differ or the result is nonzero; target L1E28
                    lda       $03,s     ; load a from the current stack frame at $03,s
                    mul                 ; multiply a by b and return the product in d
                    ldx       0,s       ; load x from the current stack frame at 0,s
                    stx       $02,s     ; store x in the current stack frame at $02,s
                    ldx       #0        ; set x to the constant 0
                    std       0,s       ; store d in the current stack frame at 0,s
                    puls      pc,d      ; restore pc,d and return to the caller
L1E28               pshs      d         ; save d on the stack
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
                    bcc       L1E45     ; branch when carry is clear; target L1E45
                    inc       0,s       ; increment the value at 0,s
L1E45               lda       $04,s     ; load a from the current stack frame at $04,s
                    ldb       $09,s     ; load b from the current stack frame at $09,s
                    mul                 ; multiply a by b and return the product in d
                    addd      $01,s     ; add to d using $01,s
                    std       $01,s     ; store d in the current stack frame at $01,s
                    bcc       L1E52     ; branch when carry is clear; target L1E52
                    inc       0,s       ; increment the value at 0,s
L1E52               lda       $04,s     ; load a from the current stack frame at $04,s
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
L1E95               lda       $05,s     ; load a from the current stack frame at $05,s
                    ldb       $03,s     ; load b from the current stack frame at $03,s
                    beq       L1EC8     ; branch when the values are equal or the result is zero; target L1EC8
                    cmpb      #1        ; compare b with #1 and set the condition codes
                    beq       L1ECA     ; branch when the values are equal or the result is zero; target L1ECA
                    cmpb      #6        ; compare b with #6 and set the condition codes
                    beq       L1ECA     ; branch when the values are equal or the result is zero; target L1ECA
                    cmpb      #2        ; compare b with #2 and set the condition codes
                    beq       L1EB0     ; branch when the values are equal or the result is zero; target L1EB0
                    cmpb      #5        ; compare b with #5 and set the condition codes
                    beq       L1EB0     ; branch when the values are equal or the result is zero; target L1EB0
                    ldb       #208      ; set b to the constant 208
                    lbra      L2119     ; continue execution at L2119
L1EB0               pshs      u         ; save u on the stack
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    bcc       L1EBC     ; branch when carry is clear; target L1EBC
                    puls      u         ; restore u from the stack
                    lbra      L2119     ; continue execution at L2119
L1EBC               stx       [<$08,s]  ; store x in the current stack frame at [<$08,s]
                    ldx       $08,s     ; load x from the current stack frame at $08,s
                    stu       $02,x     ; store u at $02,x
                    puls      u         ; restore u from the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    rts                 ; return to the caller
L1EC8               ldx       $06,s     ; load x from the current stack frame at $06,s
L1ECA               os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    lbra      L2122     ; continue execution at L2122
L1ED0               lda       $05,s     ; load a from the current stack frame at $05,s
                    ldb       $03,s     ; load b from the current stack frame at $03,s
                    beq       L1EDF     ; branch when the values are equal or the result is zero; target L1EDF
                    cmpb      #2        ; compare b with #2 and set the condition codes
                    beq       L1EE7     ; branch when the values are equal or the result is zero; target L1EE7
                    ldb       #208      ; set b to the constant 208
                    lbra      L2119     ; continue execution at L2119
L1EDF               ldx       $06,s     ; load x from the current stack frame at $06,s
                    os9       I$SetStt  ; invoke the OS-9 I$SetStt service
                    lbra      L2122     ; continue execution at L2122
L1EE7               pshs      u         ; save u on the stack
                    ldx       $08,s     ; load x from the current stack frame at $08,s
                    ldu       $0A,s     ; load u from the current stack frame at $0A,s
                    os9       I$SetStt  ; invoke the OS-9 I$SetStt service
                    puls      u         ; restore u from the stack
                    lbra      L2122     ; continue execution at L2122
L1EF5               ldx       $02,s     ; load x from the current stack frame at $02,s
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    bcs       L1F01     ; branch when carry reports an error or unsigned underflow; target L1F01
                    os9       I$Close   ; invoke the OS-9 I$Close service
L1F01               lbra      L2122     ; continue execution at L2122
L1F04               ldx       $02,s     ; load x from the current stack frame at $02,s
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L2119     ; branch when carry reports an error or unsigned underflow; target L2119
                    tfr       a,b       ; copy the register values specified by a,b
                    clra                ; clear a to zero and set the condition codes
                    rts                 ; return to the caller
L1F13               lda       $03,s     ; load a from the current stack frame at $03,s
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lbra      L2122     ; continue execution at L2122
                    fcb       $AE       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $E6       ; store byte data
                    fcb       $65       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $85       ; store byte data
                    fcb       $16       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $FD       ; store byte data
L1F25               ldx       $02,s     ; load x from the current stack frame at $02,s
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    tfr       a,b       ; copy the register values specified by a,b
                    andb      #36       ; mask b using #36
                    orb       #11       ; set selected bits in b using #11
                    os9       I$Create  ; invoke the OS-9 I$Create service
                    bcs       L1F38     ; branch when carry reports an error or unsigned underflow; target L1F38
L1F34               tfr       a,b       ; copy the register values specified by a,b
                    clra                ; clear a to zero and set the condition codes
                    rts                 ; return to the caller
L1F38               cmpb      #218      ; compare b with #218 and set the condition codes
                    lbne      L2119     ; branch when the values differ or the result is nonzero; target L2119
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    bita      #128      ; test selected bits in a using #128
                    lbne      L2119     ; branch when the values differ or the result is nonzero; target L2119
                    anda      #7        ; mask a using #7
                    ldx       $02,s     ; load x from the current stack frame at $02,s
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L2119     ; branch when carry reports an error or unsigned underflow; target L2119
                    pshs      u,a       ; save u,a on the stack
                    ldx       #0        ; set x to the constant 0
                    leau      0,x       ; form the workspace or data address 0,x in u
                    ldb       #2        ; set b to the constant 2
                    os9       I$SetStt  ; invoke the OS-9 I$SetStt service
                    puls      u,a       ; restore u,a from the stack
                    bcc       L1F34     ; branch when carry is clear; target L1F34
                    pshs      b         ; save b on the stack
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    puls      b         ; restore b from the stack
                    lbra      L2119     ; continue execution at L2119
L1F6B               ldx       $02,s     ; load x from the current stack frame at $02,s
                    os9       I$Delete  ; invoke the OS-9 I$Delete service
                    lbra      L2122     ; continue execution at L2122
                    fcb       $A6       ; store byte data
                    fcb       $63       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $82       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $9D       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $89       ; store byte data
                    fcc       "O9" ; store literal character data
L1F80               pshs      y         ; save y on the stack
                    ldx       $06,s     ; load x from the current stack frame at $06,s
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    ldy       $08,s     ; load y from the current stack frame at $08,s
                    pshs      y         ; save y on the stack
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    bcc       L1F9D     ; branch when carry is clear; target L1F9D
                    cmpb      #211      ; compare b with #211 and set the condition codes
                    bne       L1F98     ; branch when the values differ or the result is nonzero; target L1F98
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    puls      pc,y,x    ; restore pc,y,x and return to the caller
L1F98               puls      y,x       ; restore y,x from the stack
                    lbra      L2119     ; continue execution at L2119
L1F9D               tfr       y,d       ; copy the register values specified by y,d
                    puls      pc,y,x    ; restore pc,y,x and return to the caller
L1FA1               fcb       $34       ; store byte data
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
L1FB1               pshs      y         ; save y on the stack
                    ldy       $08,s     ; load y from the current stack frame at $08,s
                    beq       L1FC6     ; branch when the values are equal or the result is zero; target L1FC6
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    ldx       $06,s     ; load x from the current stack frame at $06,s
                    os9       I$Write   ; invoke the OS-9 I$Write service
L1FBF               bcc       L1FC6     ; branch when carry is clear; target L1FC6
                    puls      y         ; restore y from the stack
                    lbra      L2119     ; continue execution at L2119
L1FC6               tfr       y,d       ; copy the register values specified by y,d
                    puls      pc,y      ; restore pc,y and return to the caller
L1FCA               pshs      y         ; save y on the stack
                    ldy       $08,s     ; load y from the current stack frame at $08,s
                    beq       L1FC6     ; branch when the values are equal or the result is zero; target L1FC6
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    ldx       $06,s     ; load x from the current stack frame at $06,s
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    bra       L1FBF     ; continue execution at L1FBF
L1FDA               pshs      u         ; save u on the stack
                    ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    bne       L1FE8     ; branch when the values differ or the result is nonzero; target L1FE8
                    ldu       #0        ; set u to the constant 0
                    ldx       #0        ; set x to the constant 0
                    bra       L201C     ; continue execution at L201C
L1FE8               cmpd      #1        ; compare d with #1 and set the condition codes
                    beq       L2013     ; branch when the values are equal or the result is zero; target L2013
                    cmpd      #2        ; compare d with #2 and set the condition codes
                    beq       L2008     ; branch when the values are equal or the result is zero; target L2008
                    ldb       #247      ; set b to the constant 247
L1FF6               clra                ; clear a to zero and set the condition codes
                    std       >$01B2,y  ; store d at >$01B2,y
                    ldd       #-1       ; set d to the constant -1
                    leax      >$01A6,y  ; form the address >$01A6,y in x
                    std       0,x       ; store d at 0,x
                    std       $02,x     ; store d at $02,x
                    puls      pc,u      ; restore pc,u and return to the caller
L2008               lda       $05,s     ; load a from the current stack frame at $05,s
                    ldb       #2        ; set b to the constant 2
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    bcs       L1FF6     ; branch when carry reports an error or unsigned underflow; target L1FF6
                    bra       L201C     ; continue execution at L201C
L2013               lda       $05,s     ; load a from the current stack frame at $05,s
                    ldb       #5        ; set b to the constant 5
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    bcs       L1FF6     ; branch when carry reports an error or unsigned underflow; target L1FF6
L201C               tfr       u,d       ; copy the register values specified by u,d
                    addd      $08,s     ; add to d using $08,s
                    std       >$01A8,y  ; store d at >$01A8,y
                    tfr       d,u       ; copy the register values specified by d,u
                    tfr       x,d       ; copy the register values specified by x,d
                    adcb      $07,s     ; add with carry to b using $07,s
                    adca      $06,s     ; add with carry to a using $06,s
                    bmi       L1FF6     ; branch when the result is negative; target L1FF6
                    tfr       d,x       ; copy the register values specified by d,x
                    std       >$01A6,y  ; store d at >$01A6,y
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    bcs       L1FF6     ; branch when carry reports an error or unsigned underflow; target L1FF6
                    leax      >$01A6,y  ; form the address >$01A6,y in x
                    puls      pc,u      ; restore pc,u and return to the caller
                    fcb       $39       ; store byte data
                    fcb       $8E       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $5F       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $0A       ; store byte data
                    fcb       $16       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $CD       ; store byte data
                    fcc       "94`" ; store literal character data
                    fcb       $AE       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $AE       ; store byte data
                    fcb       $68       ; store byte data
                    fcb       $EE       ; store byte data
                    fcb       $6A       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $E0       ; store byte data
                    fcb       $A6       ; store byte data
                    fcb       $63       ; store byte data
                    fcb       $E6       ; store byte data
                    fcb       $65       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $0F       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $B3       ; store byte data
                    fcb       $39       ; store byte data
L2067               ldx       $02,s     ; load x from the current stack frame at $02,s
                    os9       F$Sleep   ; invoke the OS-9 F$Sleep service
                    lbcs      L2119     ; branch when carry reports an error or unsigned underflow; target L2119
                    tfr       x,d       ; copy the register values specified by x,d
                    rts                 ; return to the caller
                    fcb       $EC       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $A4       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $A3       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $F4       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $E3       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $A4       ; store byte data
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
                    fcb       $A4       ; store byte data
                    fcb       $E3       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $F4       ; store byte data
                    fcb       $A3       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $F4       ; store byte data
                    fcb       $32       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $F4       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $A3       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $F4       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $A4       ; store byte data
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
                    fcb       $A4       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $F8       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $86       ; store byte data
L20CA               ldd       $02,s     ; load d from the current stack frame at $02,s
                    addd      >$01AE,y  ; add to d using >$01AE,y
                    bcs       L20F3     ; branch when carry reports an error or unsigned underflow; target L20F3
                    cmpd      >$01B0,y  ; compare d with >$01B0,y and set the condition codes
                    bcc       L20F3     ; branch when carry is clear; target L20F3
                    pshs      d         ; save d on the stack
                    ldx       >$01AE,y  ; load x from >$01AE,y
                    clra                ; clear a to zero and set the condition codes
L20E0               cmpx      0,s       ; compare x with 0,s and set the condition codes
                    bcc       L20E8     ; branch when carry is clear; target L20E8
                    sta       ,x+       ; store a at ,x+
                    bra       L20E0     ; continue execution at L20E0
L20E8               ldd       >$01AE,y  ; load d from >$01AE,y
                    puls      x         ; restore x from the stack
                    stx       >$01AE,y  ; store x at >$01AE,y
                    rts                 ; return to the caller
L20F3               ldd       #-1       ; set d to the constant -1
                    rts                 ; return to the caller
L20F7               pshs      u         ; save u on the stack
                    tfr       y,u       ; copy the register values specified by y,u
                    ldx       $04,s     ; load x from the current stack frame at $04,s
                    stx       >$02F6,y  ; store x at >$02F6,y
                    leax      >L210D,pc ; form the address >L210D,pc in x
                    os9       F$Icpt    ; invoke the OS-9 F$Icpt service
                    puls      u         ; restore u from the stack
                    lbra      L2122     ; continue execution at L2122
L210D               fcb       $1F       ; store byte data
                    fcc       "2O4" ; store literal character data
                    fcb       $06       ; store byte data
                    fcb       $AD       ; store byte data
                    fcb       $B9       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $F6       ; store byte data
                    fcc       "2b;" ; store literal character data
L2119               clra                ; clear a to zero and set the condition codes
                    std       >$01B2,y  ; store d at >$01B2,y
                    ldd       #-1       ; set d to the constant -1
                    rts                 ; return to the caller
L2122               bcs       L2119     ; branch when carry reports an error or unsigned underflow; target L2119
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    rts                 ; return to the caller
L2127               lbsr      L2132     ; call subroutine L2132
                    lbsr      L1A0C     ; call subroutine L1A0C
L212D               ldd       $02,s     ; load d from the current stack frame at $02,s
                    os9       F$Exit    ; invoke the OS-9 F$Exit service
L2132               rts                 ; return to the caller
L2133               lda       $03,s     ; load a from the current stack frame at $03,s
                    ldb       #1        ; set b to the constant 1
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    lbcs      L2119     ; branch when carry reports an error or unsigned underflow; target L2119
                    clra                ; clear a to zero and set the condition codes
                    rts                 ; return to the caller
L2140               lda       $03,s     ; load a from the current stack frame at $03,s
                    ldb       #26       ; set b to the constant 26
                    ldx       $04,s     ; load x from the current stack frame at $04,s
                    os9       I$SetStt  ; invoke the OS-9 I$SetStt service
                    lbra      L2122     ; continue execution at L2122
L214C               lda       $03,s     ; load a from the current stack frame at $03,s
                    ldb       #27       ; set b to the constant 27
                    os9       I$SetStt  ; invoke the OS-9 I$SetStt service
                    lbra      L2122     ; continue execution at L2122
                    fcb       $C6       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $C6       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $2C       ; store byte data
                    fcb       $C6       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $28       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $05       ; store byte data
                    fcc       "  R" ; store literal character data
                    fcb       $CC       ; store byte data
                    fcb       $05       ; store byte data
                    fcc       "! M" ; store literal character data
                    fcb       $C6       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $1A       ; store byte data
                    fcb       $C6       ; store byte data
                    fcb       $07       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $16       ; store byte data
                    fcb       $C6       ; store byte data
                    fcb       $08       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $12       ; store byte data
                    fcb       $C6       ; store byte data
                    fcb       $09       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $0E       ; store byte data
                    fcb       $C6       ; store byte data
                    fcb       $0A       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $0A       ; store byte data
                    fcb       $C6       ; store byte data
                    fcb       $0B       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $06       ; store byte data
L2184               ldb       #12       ; set b to the constant 12
                    bra       L218A     ; continue execution at L218A
                    fcb       $C6       ; store byte data
                    fcb       $0D       ; store byte data
L218A               stb       >$02F8,y  ; store b at >$02F8,y
                    ldb       #1        ; set b to the constant 1
                    lbra      L21C2     ; continue execution at L21C2
L2193               ldd       #7968     ; set d to the constant 7968
                    bra       L21B9     ; continue execution at L21B9
L2198               ldd       #7969     ; set d to the constant 7969
                    bra       L21B9     ; continue execution at L21B9
                    fcb       $CC       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $22       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $23       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $12       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $24       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $08       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $CC       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $31       ; store byte data
L21B9               std       >$02F8,y  ; store d at >$02F8,y
                    ldb       #2        ; set b to the constant 2
                    lbra      L21C2     ; continue execution at L21C2
L21C2               clra                ; clear a to zero and set the condition codes
                    leax      >$02F8,y  ; form the address >$02F8,y in x
                    pshs      y         ; save y on the stack
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    puls      y         ; restore y from the stack
                    bcs       L21D7     ; branch when carry reports an error or unsigned underflow; target L21D7
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    rts                 ; return to the caller
L21D7               clra                ; clear a to zero and set the condition codes
                    std       >$01B2,y  ; store d at >$01B2,y
                    ldd       #-1       ; set d to the constant -1
                    rts                 ; return to the caller
L21E0               fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $63       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $15       ; store byte data
                    fcb       $18       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $E8       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $0A       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $0E       ; store byte data
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
                    fcb       $0E       ; store byte data
                    fcc       "Terminal" ; store literal character data
                    fcb       $00       ; store byte data

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
