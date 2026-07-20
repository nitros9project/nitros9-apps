**********************************************************************
* suser - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       Suser
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
U0008               rmb       1         ; reserve 1 byte(s) in the module workspace
U0009               rmb       1         ; reserve 1 byte(s) in the module workspace
U000A               rmb       1         ; reserve 1 byte(s) in the module workspace
U000B               rmb       2         ; reserve 2 byte(s) in the module workspace
U000D               rmb       338       ; reserve 338 byte(s) in the module workspace
U015F               rmb       2         ; reserve 2 byte(s) in the module workspace
U0161               rmb       58        ; reserve 58 byte(s) in the module workspace
U019B               rmb       1         ; reserve 1 byte(s) in the module workspace
U019C               rmb       3         ; reserve 3 byte(s) in the module workspace
U019F               rmb       2         ; reserve 2 byte(s) in the module workspace
U01A1               rmb       938       ; reserve 938 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /Suser/ ; store an OS-9 high-bit-terminated string
                    fcb       $01       ; store byte data
L0013               lda       ,y+       ; load a from ,y+
                    sta       ,u+       ; store a at ,u+
                    leax      -$01,x    ; form the address -$01,x in x
                    bne       L0013     ; branch when the values differ or the result is nonzero; target L0013
                    rts                 ; return to the caller
start               pshs      y         ; save y on the stack
                    pshs      u         ; save u on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
L0022               sta       ,u+       ; store a at ,u+
                    decb                ; decrement b
                    bne       L0022     ; branch when the values differ or the result is nonzero; target L0022
                    ldx       0,s       ; load x from the current stack frame at 0,s
                    leau      0,x       ; form the workspace or data address 0,x in u
                    leax      >$01CB,x  ; form the address >$01CB,x in x
                    pshs      x         ; save x on the stack
                    leay      >L0F36,pc ; form the address >L0F36,pc in y
                    ldx       ,y++      ; load x from ,y++
                    beq       L003D     ; branch when the values are equal or the result is zero; target L003D
                    bsr       L0013     ; call subroutine L0013
                    ldu       $02,s     ; load u from the current stack frame at $02,s
L003D               leau      >U0001,u  ; form the workspace or data address >U0001,u in u
                    ldx       ,y++      ; load x from ,y++
                    beq       L0048     ; branch when the values are equal or the result is zero; target L0048
                    bsr       L0013     ; call subroutine L0013
                    clra                ; clear a to zero and set the condition codes
L0048               cmpu      0,s       ; compare u with 0,s and set the condition codes
L004B               beq       L0051     ; branch when the values are equal or the result is zero; target L0051
                    sta       ,u+       ; store a at ,u+
                    bra       L0048     ; continue execution at L0048
L0051               ldu       $02,s     ; load u from the current stack frame at $02,s
                    ldd       ,y++      ; load d from ,y++
                    beq       L005E     ; branch when the values are equal or the result is zero; target L005E
                    leax      >,pc      ; form the address >,pc in x
                    lbsr      L0161     ; call subroutine L0161
L005E               ldd       ,y++      ; load d from ,y++
                    beq       L0067     ; branch when the values are equal or the result is zero; target L0067
                    leax      U0000,u   ; form the address U0000,u in x
                    lbsr      L0161     ; call subroutine L0161
L0067               leas      $04,s     ; adjust the system stack pointer
                    puls      x         ; restore x from the stack
                    stx       >U019F,u  ; store x at >U019F,u
                    sty       >U015F,u  ; store y at >U015F,u
                    ldd       #1        ; set d to the constant 1
                    std       >U019B,u  ; store d at >U019B,u
                    leay      >U0161,u  ; form the address >U0161,u in y
                    leax      0,s       ; form the address 0,s in x
                    lda       ,x+       ; load a from ,x+
L0083               ldb       >U019C,u  ; load b from >U019C,u
                    cmpb      #29       ; compare b with #29 and set the condition codes
                    beq       L00DF     ; branch when the values are equal or the result is zero; target L00DF
L008B               cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L00DF     ; branch when the values are equal or the result is zero; target L00DF
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       L0097     ; branch when the values are equal or the result is zero; target L0097
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    bne       L009B     ; branch when the values differ or the result is nonzero; target L009B
L0097               lda       ,x+       ; load a from ,x+
                    bra       L008B     ; continue execution at L008B
L009B               cmpa      #34       ; compare a with #34 and set the condition codes
                    beq       L00A3     ; branch when the values are equal or the result is zero; target L00A3
                    cmpa      #39       ; compare a with #39 and set the condition codes
                    bne       L00C1     ; branch when the values differ or the result is nonzero; target L00C1
L00A3               stx       ,y++      ; store x at ,y++
                    inc       >U019C,u  ; increment the value at >U019C,u
                    pshs      a         ; save a on the stack
L00AB               lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L00B5     ; branch when the values are equal or the result is zero; target L00B5
                    cmpa      0,s       ; compare a with 0,s and set the condition codes
                    bne       L00AB     ; branch when the values differ or the result is nonzero; target L00AB
L00B5               puls      b         ; restore b from the stack
                    clr       -$01,x    ; clear -$01,x to zero and set the condition codes
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L00DF     ; branch when the values are equal or the result is zero; target L00DF
                    lda       ,x+       ; load a from ,x+
                    bra       L0083     ; continue execution at L0083
L00C1               leax      -$01,x    ; form the address -$01,x in x
                    stx       ,y++      ; store x at ,y++
                    leax      $01,x     ; form the address $01,x in x
                    inc       >U019C,u  ; increment the value at >U019C,u
L00CB               cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L00DB     ; branch when the values are equal or the result is zero; target L00DB
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       L00DB     ; branch when the values are equal or the result is zero; target L00DB
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    beq       L00DB     ; branch when the values are equal or the result is zero; target L00DB
                    lda       ,x+       ; load a from ,x+
                    bra       L00CB     ; continue execution at L00CB
L00DB               clr       -$01,x    ; clear -$01,x to zero and set the condition codes
                    bra       L0083     ; continue execution at L0083
L00DF               leax      >U015F,u  ; form the address >U015F,u in x
                    pshs      x         ; save x on the stack
                    ldd       >U019B,u  ; load d from >U019B,u
                    pshs      d         ; save d on the stack
                    leay      U0000,u   ; form the address U0000,u in y
                    bsr       L00F9     ; call subroutine L00F9
                    lbsr      L017B     ; call subroutine L017B
                    clr       ,-s       ; clear ,-s to zero and set the condition codes
                    clr       ,-s       ; clear ,-s to zero and set the condition codes
                    lbsr      L0F2A     ; call subroutine L0F2A
L00F9               leax      >$01CB,y  ; form the address >$01CB,y in x
                    stx       >$01A9,y  ; store x at >$01A9,y
                    sts       >$019D,y  ; store s at >$019D,y
                    sts       >$01AB,y  ; store s at >$01AB,y
                    ldd       #-126     ; set d to the constant -126
L010E               leax      d,s       ; form the address d,s in x
                    cmpx      >$01AB,y  ; compare x with >$01AB,y and set the condition codes
                    bcc       L0120     ; branch when carry is clear; target L0120
                    cmpx      >$01A9,y  ; compare x with >$01A9,y and set the condition codes
                    bcs       L013A     ; branch when carry reports an error or unsigned underflow; target L013A
                    stx       >$01AB,y  ; store x at >$01AB,y
L0120               rts                 ; return to the caller
L0121               fcc       "**** STACK OVERFLOW ****" ; store literal character data
                    fcb       $0D       ; store byte data
L013A               leax      <L0121,pc ; form the address <L0121,pc in x
                    ldb       #207      ; set b to the constant 207
                    pshs      b         ; save b on the stack
                    lda       #2        ; set a to the constant 2
                    ldy       #100      ; set y to the constant 100
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    clr       ,-s       ; clear ,-s to zero and set the condition codes
                    lbsr      L0F30     ; call subroutine L0F30
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
L0161               pshs      x         ; save x on the stack
                    leax      d,y       ; form the address d,y in x
                    leax      d,x       ; form the address d,x in x
                    pshs      x         ; save x on the stack
L0169               ldd       ,y++      ; load d from ,y++
                    leax      d,u       ; form the address d,u in x
                    ldd       0,x       ; load d from 0,x
                    addd      $02,s     ; add to d using $02,s
                    std       0,x       ; store d at 0,x
                    cmpy      0,s       ; compare y with 0,s and set the condition codes
                    bne       L0169     ; branch when the values differ or the result is nonzero; target L0169
                    leas      $04,s     ; adjust the system stack pointer
                    rts                 ; return to the caller
L017B               pshs      u         ; save u on the stack
                    ldd       #-284     ; set d to the constant -284
                    lbsr      L010E     ; call subroutine L010E
                    leas      >$FF34,s  ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       0,s       ; store b in the current stack frame at 0,s
                    ldd       >$00D0,s  ; load d from the current stack frame at >$00D0,s
                    cmpd      #1        ; compare d with #1 and set the condition codes
                    bne       L01A4     ; branch when the values differ or the result is nonzero; target L01A4
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    leax      >L0274,pc ; form the address >L0274,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L0252     ; call subroutine L0252
                    leas      $04,s     ; adjust the system stack pointer
L01A4               ldx       >$00D2,s  ; load x from the current stack frame at >$00D2,s
                    ldd       $02,x     ; load d from $02,x
                    pshs      d         ; save d on the stack
                    lbsr      L0B4F     ; call subroutine L0B4F
                    leas      $02,s     ; adjust the system stack pointer
                    std       >$00CA,s  ; store d in the current stack frame at >$00CA,s
                    pshs      d         ; save d on the stack
                    lbsr      L0EF8     ; call subroutine L0EF8
                    leas      $02,s     ; adjust the system stack pointer
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    bne       L01D3     ; branch when the values differ or the result is nonzero; target L01D3
                    ldd       >$01AD,y  ; load d from >$01AD,y
                    pshs      d         ; save d on the stack
                    leax      >L0298,pc ; form the address >L0298,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L0252     ; call subroutine L0252
                    leas      $04,s     ; adjust the system stack pointer
L01D3               ldd       #2        ; set d to the constant 2
                    bra       L0207     ; continue execution at L0207
L01D8               ldd       >$00C8,s  ; load d from the current stack frame at >$00C8,s
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    ldx       >$00D2,s  ; load x from the current stack frame at >$00D2,s
                    leax      d,x       ; form the address d,x in x
                    ldd       0,x       ; load d from 0,x
                    pshs      d         ; save d on the stack
                    leax      $02,s     ; form the address $02,s in x
                    pshs      x         ; save x on the stack
                    lbsr      L0AF1     ; call subroutine L0AF1
                    leas      $04,s     ; adjust the system stack pointer
                    leax      >L02C1,pc ; form the address >L02C1,pc in x
                    pshs      x         ; save x on the stack
                    leax      $02,s     ; form the address $02,s in x
                    pshs      x         ; save x on the stack
                    lbsr      L0AF1     ; call subroutine L0AF1
                    leas      $04,s     ; adjust the system stack pointer
                    ldd       >$00C8,s  ; load d from the current stack frame at >$00C8,s
                    addd      #1        ; add to d using #1
L0207               std       >$00C8,s  ; store d in the current stack frame at >$00C8,s
                    ldd       >$00C8,s  ; load d from the current stack frame at >$00C8,s
                    cmpd      >$00D0,s  ; compare d with >$00D0,s and set the condition codes
                    blt       L01D8     ; branch when the signed value is less; target L01D8
                    leax      >L02C3,pc ; form the address >L02C3,pc in x
                    pshs      x         ; save x on the stack
                    leax      $02,s     ; form the address $02,s in x
                    pshs      x         ; save x on the stack
                    lbsr      L0AF1     ; call subroutine L0AF1
                    leas      $04,s     ; adjust the system stack pointer
                    ldd       #3        ; set d to the constant 3
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    ldd       #16       ; set d to the constant 16
                    pshs      d         ; save d on the stack
                    leax      $06,s     ; form the address $06,s in x
                    pshs      x         ; save x on the stack
                    leax      $08,s     ; form the address $08,s in x
                    pshs      x         ; save x on the stack
                    lbsr      L0AC8     ; call subroutine L0AC8
                    std       0,s       ; store d in the current stack frame at 0,s
                    leax      >L02C5,pc ; form the address >L02C5,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L0E9D     ; call subroutine L0E9D
                    leas      $0C,s     ; adjust the system stack pointer
                    leas      >$00CC,s  ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
L0252               pshs      u         ; save u on the stack
                    ldd       #-72      ; set d to the constant -72
                    lbsr      L010E     ; call subroutine L010E
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    pshs      d         ; save d on the stack
                    leax      >L02CC,pc ; form the address >L02CC,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      L02D0     ; call subroutine L02D0
                    leas      $04,s     ; adjust the system stack pointer
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    lbsr      L0F2A     ; call subroutine L0F2A
                    leas      $02,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
L0274               fcc       "Usage is: Suser <number> [progname]" ; store literal character data
                    fcb       $00       ; store byte data
L0298               fcc       "Sorry, you cannot change the user number" ; store literal character data
                    fcb       $00       ; store byte data
L02C1               fcb       $20       ; store byte data
                    fcb       $00       ; store byte data
L02C3               fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L02C5               fcc       "Shell" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L02CC               fcb       $25       ; store byte data
                    fcb       $73       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
L02D0               pshs      u         ; save u on the stack
                    leax      >$001B,y  ; form the address >$001B,y in x
                    stx       >$01AF,y  ; store x at >$01AF,y
                    leax      $06,s     ; form the address $06,s in x
                    pshs      x         ; save x on the stack
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    bra       L02F0     ; continue execution at L02F0
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $AF       ; store byte data
                    fcc       "0h4" ; store literal character data
                    fcb       $10       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $68       ; store byte data
L02F0               pshs      d         ; save d on the stack
                    leax      >L07A8,pc ; form the address >L07A8,pc in x
                    pshs      x         ; save x on the stack
                    bsr       L0322     ; call subroutine L0322
                    leas      $06,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $AF       ; store byte data
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
                    fcb       $01       ; store byte data
                    fcb       $AF       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $C0       ; store byte data
L0322               pshs      u         ; save u on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    leas      -$0B,s    ; adjust the system stack pointer
                    bra       L033A     ; continue execution at L033A
L032A               ldb       $08,s     ; load b from the current stack frame at $08,s
                    lbeq      L056B     ; branch when the values are equal or the result is zero; target L056B
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    jsr       [<$11,s]  ; call subroutine [<$11,s]
                    leas      $02,s     ; adjust the system stack pointer
L033A               ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    cmpb      #37       ; compare b with #37 and set the condition codes
                    bne       L032A     ; branch when the values differ or the result is nonzero; target L032A
                    ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       $02,s     ; store d in the current stack frame at $02,s
                    std       $06,s     ; store d in the current stack frame at $06,s
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    cmpb      #45       ; compare b with #45 and set the condition codes
                    bne       L035F     ; branch when the values differ or the result is nonzero; target L035F
                    ldd       #1        ; set d to the constant 1
                    std       >$01C5,y  ; store d at >$01C5,y
                    ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    bra       L0365     ; continue execution at L0365
L035F               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >$01C5,y  ; store d at >$01C5,y
L0365               ldb       $08,s     ; load b from the current stack frame at $08,s
                    cmpb      #48       ; compare b with #48 and set the condition codes
                    bne       L0370     ; branch when the values differ or the result is nonzero; target L0370
                    ldd       #48       ; set d to the constant 48
                    bra       L0373     ; continue execution at L0373
L0370               ldd       #32       ; set d to the constant 32
L0373               std       >$01C7,y  ; store d at >$01C7,y
                    bra       L0393     ; continue execution at L0393
L0379               ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    lbsr      L0BC2     ; call subroutine L0BC2
                    pshs      d         ; save d on the stack
                    ldb       $0A,s     ; load b from the current stack frame at $0A,s
                    sex                 ; sign-extend b into d
                    addd      #-48      ; add to d using #-48
                    addd      ,s++      ; add to d using ,s++
                    std       $06,s     ; store d in the current stack frame at $06,s
                    ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
L0393               ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
                    leax      >$00DF,y  ; form the address >$00DF,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       0,x       ; load b from 0,x
                    clra                ; clear a to zero and set the condition codes
                    andb      #8        ; mask b using #8
                    bne       L0379     ; branch when the values differ or the result is nonzero; target L0379
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    cmpb      #46       ; compare b with #46 and set the condition codes
                    bne       L03DC     ; branch when the values differ or the result is nonzero; target L03DC
                    ldd       #1        ; set d to the constant 1
                    std       $04,s     ; store d in the current stack frame at $04,s
                    bra       L03C6     ; continue execution at L03C6
L03B0               ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    lbsr      L0BC2     ; call subroutine L0BC2
                    pshs      d         ; save d on the stack
                    ldb       $0A,s     ; load b from the current stack frame at $0A,s
                    sex                 ; sign-extend b into d
                    addd      #-48      ; add to d using #-48
                    addd      ,s++      ; add to d using ,s++
                    std       $02,s     ; store d in the current stack frame at $02,s
L03C6               ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
                    leax      >$00DF,y  ; form the address >$00DF,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       0,x       ; load b from 0,x
                    clra                ; clear a to zero and set the condition codes
                    andb      #8        ; mask b using #8
                    bne       L03B0     ; branch when the values differ or the result is nonzero; target L03B0
                    bra       L03E0     ; continue execution at L03E0
L03DC               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       $04,s     ; store d in the current stack frame at $04,s
L03E0               ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; copy the register values specified by d,x
                    lbra      L050E     ; continue execution at L050E
L03E8               ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldx       <$0015,s  ; load x from the current stack frame at <$0015,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0015,s  ; store x in the current stack frame at <$0015,s
                    ldd       -$02,x    ; load d from -$02,x
                    pshs      d         ; save d on the stack
                    lbsr      L056F     ; call subroutine L056F
                    bra       L0410     ; continue execution at L0410
L03FD               ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldx       <$0015,s  ; load x from the current stack frame at <$0015,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0015,s  ; store x in the current stack frame at <$0015,s
                    ldd       -$02,x    ; load d from -$02,x
                    pshs      d         ; save d on the stack
                    lbsr      L062C     ; call subroutine L062C
L0410               std       0,s       ; store d in the current stack frame at 0,s
                    lbra      L04F4     ; continue execution at L04F4
L0415               ldd       $06,s     ; load d from the current stack frame at $06,s
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
                    lbsr      L0674     ; call subroutine L0674
                    lbra      L04F0     ; continue execution at L04F0
L043B               ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldx       <$0015,s  ; load x from the current stack frame at <$0015,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0015,s  ; store x in the current stack frame at <$0015,s
                    ldd       -$02,x    ; load d from -$02,x
                    pshs      d         ; save d on the stack
                    leax      >$01B1,y  ; form the address >$01B1,y in x
                    pshs      x         ; save x on the stack
                    lbsr      L05B3     ; call subroutine L05B3
                    lbra      L04F0     ; continue execution at L04F0
L0457               ldd       $04,s     ; load d from the current stack frame at $04,s
                    bne       L0460     ; branch when the values differ or the result is nonzero; target L0460
                    ldd       #6        ; set d to the constant 6
                    std       $02,s     ; store d in the current stack frame at $02,s
L0460               ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    leax      <$0015,s  ; form the address <$0015,s in x
                    pshs      x         ; save x on the stack
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldb       $0E,s     ; load b from the current stack frame at $0E,s
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    lbsr      L0ABD     ; call subroutine L0ABD
                    leas      $06,s     ; adjust the system stack pointer
                    lbra      L04F2     ; continue execution at L04F2
L047A               ldx       <$0013,s  ; load x from the current stack frame at <$0013,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0013,s  ; store x in the current stack frame at <$0013,s
                    ldd       -$02,x    ; load d from -$02,x
                    lbra      L0504     ; continue execution at L0504
L0487               ldx       <$0013,s  ; load x from the current stack frame at <$0013,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0013,s  ; store x in the current stack frame at <$0013,s
                    ldd       -$02,x    ; load d from -$02,x
                    std       $09,s     ; store d in the current stack frame at $09,s
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    beq       L04CF     ; branch when the values are equal or the result is zero; target L04CF
                    ldd       $09,s     ; load d from the current stack frame at $09,s
                    std       $04,s     ; store d in the current stack frame at $04,s
                    bra       L04A9     ; continue execution at L04A9
L049D               ldb       [<$09,s]  ; load b from the current stack frame at [<$09,s]
                    beq       L04B5     ; branch when the values are equal or the result is zero; target L04B5
                    ldd       $09,s     ; load d from the current stack frame at $09,s
                    addd      #1        ; add to d using #1
                    std       $09,s     ; store d in the current stack frame at $09,s
L04A9               ldd       $02,s     ; load d from the current stack frame at $02,s
                    addd      #-1       ; add to d using #-1
                    std       $02,s     ; store d in the current stack frame at $02,s
                    subd      #-1       ; subtract from d using #-1
                    bne       L049D     ; branch when the values differ or the result is nonzero; target L049D
L04B5               ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       $0B,s     ; load d from the current stack frame at $0B,s
                    subd      $06,s     ; subtract from d using $06,s
                    pshs      d         ; save d on the stack
                    ldd       $08,s     ; load d from the current stack frame at $08,s
                    pshs      d         ; save d on the stack
                    ldd       <$0015,s  ; load d from the current stack frame at <$0015,s
                    pshs      d         ; save d on the stack
                    lbsr      L06DF     ; call subroutine L06DF
                    leas      $08,s     ; adjust the system stack pointer
                    bra       L04FE     ; continue execution at L04FE
L04CF               ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       $0B,s     ; load d from the current stack frame at $0B,s
                    bra       L04F2     ; continue execution at L04F2
L04D7               ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    bra       L04DF     ; continue execution at L04DF
                    fcb       $32       ; store byte data
                    fcb       $15       ; store byte data
L04DF               ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    leax      <$0015,s  ; form the address <$0015,s in x
                    pshs      x         ; save x on the stack
                    ldb       $0C,s     ; load b from the current stack frame at $0C,s
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    lbsr      L0A7F     ; call subroutine L0A7F
L04F0               leas      $04,s     ; adjust the system stack pointer
L04F2               pshs      d         ; save d on the stack
L04F4               ldd       <$0013,s  ; load d from the current stack frame at <$0013,s
                    pshs      d         ; save d on the stack
                    lbsr      L0741     ; call subroutine L0741
                    leas      $06,s     ; adjust the system stack pointer
L04FE               lbra      L033A     ; continue execution at L033A
L0501               ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
L0504               pshs      d         ; save d on the stack
                    jsr       [<$11,s]  ; call subroutine [<$11,s]
                    leas      $02,s     ; adjust the system stack pointer
                    lbra      L033A     ; continue execution at L033A
L050E               cmpx      #100      ; compare x with #100 and set the condition codes
                    lbeq      L03E8     ; branch when the values are equal or the result is zero; target L03E8
                    cmpx      #111      ; compare x with #111 and set the condition codes
                    lbeq      L03FD     ; branch when the values are equal or the result is zero; target L03FD
                    cmpx      #120      ; compare x with #120 and set the condition codes
                    lbeq      L0415     ; branch when the values are equal or the result is zero; target L0415
                    cmpx      #88       ; compare x with #88 and set the condition codes
                    lbeq      L0415     ; branch when the values are equal or the result is zero; target L0415
                    cmpx      #117      ; compare x with #117 and set the condition codes
                    lbeq      L043B     ; branch when the values are equal or the result is zero; target L043B
                    cmpx      #102      ; compare x with #102 and set the condition codes
                    lbeq      L0457     ; branch when the values are equal or the result is zero; target L0457
                    cmpx      #101      ; compare x with #101 and set the condition codes
                    lbeq      L0457     ; branch when the values are equal or the result is zero; target L0457
                    cmpx      #103      ; compare x with #103 and set the condition codes
                    lbeq      L0457     ; branch when the values are equal or the result is zero; target L0457
                    cmpx      #69       ; compare x with #69 and set the condition codes
                    lbeq      L0457     ; branch when the values are equal or the result is zero; target L0457
                    cmpx      #71       ; compare x with #71 and set the condition codes
                    lbeq      L0457     ; branch when the values are equal or the result is zero; target L0457
                    cmpx      #99       ; compare x with #99 and set the condition codes
                    lbeq      L047A     ; branch when the values are equal or the result is zero; target L047A
                    cmpx      #115      ; compare x with #115 and set the condition codes
                    lbeq      L0487     ; branch when the values are equal or the result is zero; target L0487
                    cmpx      #108      ; compare x with #108 and set the condition codes
                    lbeq      L04D7     ; branch when the values are equal or the result is zero; target L04D7
                    bra       L0501     ; continue execution at L0501
L056B               leas      $0B,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
L056F               pshs      u,d       ; save u,d on the stack
                    leax      >$01B1,y  ; form the address >$01B1,y in x
                    stx       0,s       ; store x in the current stack frame at 0,s
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    bge       L05A4     ; branch when the signed value is greater than or equal; target L05A4
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    nega                ; negate a
                    negb                ; negate b
                    sbca      #0        ; subtract with borrow from a using #0
                    std       $06,s     ; store d in the current stack frame at $06,s
                    bge       L0599     ; branch when the signed value is greater than or equal; target L0599
                    leax      >L07CD,pc ; form the address >L07CD,pc in x
                    pshs      x         ; save x on the stack
                    leax      >$01B1,y  ; form the address >$01B1,y in x
                    pshs      x         ; save x on the stack
                    lbsr      L0AD9     ; call subroutine L0AD9
                    leas      $04,s     ; adjust the system stack pointer
                    lbra      L0670     ; continue execution at L0670
L0599               ldd       #45       ; set d to the constant 45
                    ldx       0,s       ; load x from the current stack frame at 0,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       0,s       ; store x in the current stack frame at 0,s
                    stb       -$01,x    ; store b at -$01,x
L05A4               ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    bsr       L05B3     ; call subroutine L05B3
                    leas      $04,s     ; adjust the system stack pointer
                    lbra      L066A     ; continue execution at L066A
L05B3               pshs      u,y,x,d   ; save u,y,x,d on the stack
                    ldu       $0A,s     ; load u from the current stack frame at $0A,s
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       $02,s     ; store d in the current stack frame at $02,s
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       0,s       ; store d in the current stack frame at 0,s
                    bra       L05D0     ; continue execution at L05D0
L05C1               ldd       0,s       ; load d from the current stack frame at 0,s
                    addd      #1        ; add to d using #1
                    std       0,s       ; store d in the current stack frame at 0,s
                    ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    subd      >$0001,y  ; subtract from d using >$0001,y
                    std       $0C,s     ; store d in the current stack frame at $0C,s
L05D0               ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    blt       L05C1     ; branch when the signed value is less; target L05C1
                    leax      >$0001,y  ; form the address >$0001,y in x
                    stx       $04,s     ; store x in the current stack frame at $04,s
                    bra       L0612     ; continue execution at L0612
L05DC               ldd       0,s       ; load d from the current stack frame at 0,s
                    addd      #1        ; add to d using #1
                    std       0,s       ; store d in the current stack frame at 0,s
L05E3               ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    subd      [<$04,s]  ; subtract from d using [<$04,s]
                    std       $0C,s     ; store d in the current stack frame at $0C,s
                    bge       L05DC     ; branch when the signed value is greater than or equal; target L05DC
                    ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    addd      [<$04,s]  ; add to d using [<$04,s]
                    std       $0C,s     ; store d in the current stack frame at $0C,s
                    ldd       0,s       ; load d from the current stack frame at 0,s
                    beq       L05FC     ; branch when the values are equal or the result is zero; target L05FC
                    ldd       #1        ; set d to the constant 1
                    std       $02,s     ; store d in the current stack frame at $02,s
L05FC               ldd       $02,s     ; load d from the current stack frame at $02,s
                    beq       L0607     ; branch when the values are equal or the result is zero; target L0607
                    ldd       0,s       ; load d from the current stack frame at 0,s
                    addd      #48       ; add to d using #48
                    stb       ,u+       ; store b at ,u+
L0607               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       0,s       ; store d in the current stack frame at 0,s
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    addd      #2        ; add to d using #2
                    std       $04,s     ; store d in the current stack frame at $04,s
L0612               ldd       $04,s     ; load d from the current stack frame at $04,s
                    cmpd      >$0009,y  ; compare d with >$0009,y and set the condition codes
                    bne       L05E3     ; branch when the values differ or the result is nonzero; target L05E3
                    ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    addd      #48       ; add to d using #48
                    stb       ,u+       ; store b at ,u+
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       U0000,u   ; store b at U0000,u
                    ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    leas      $06,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
L062C               pshs      u,d       ; save u,d on the stack
                    leax      >$01B1,y  ; form the address >$01B1,y in x
                    stx       0,s       ; store x in the current stack frame at 0,s
                    leau      >$01BB,y  ; form the workspace or data address >$01BB,y in u
L0638               ldd       $06,s     ; load d from the current stack frame at $06,s
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
                    bne       L0638     ; branch when the values differ or the result is nonzero; target L0638
                    bra       L065A     ; continue execution at L065A
L0650               ldb       U0000,u   ; load b from U0000,u
                    ldx       0,s       ; load x from the current stack frame at 0,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       0,s       ; store x in the current stack frame at 0,s
                    stb       -$01,x    ; store b at -$01,x
L065A               leau      -$01,u    ; form the workspace or data address -$01,u in u
                    pshs      u         ; save u on the stack
                    leax      >$01BB,y  ; form the address >$01BB,y in x
                    cmpx      ,s++      ; compare x with ,s++ and set the condition codes
                    bls       L0650     ; branch when the unsigned value is lower or equal; target L0650
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       [,s]      ; store b in the current stack frame at [,s]
L066A               leax      >$01B1,y  ; form the address >$01B1,y in x
                    tfr       x,d       ; copy the register values specified by x,d
L0670               leas      $02,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
L0674               pshs      u,x,d     ; save u,x,d on the stack
                    leax      >$01B1,y  ; form the address >$01B1,y in x
                    stx       $02,s     ; store x in the current stack frame at $02,s
                    leau      >$01BB,y  ; form the workspace or data address >$01BB,y in u
L0680               ldd       $08,s     ; load d from the current stack frame at $08,s
                    clra                ; clear a to zero and set the condition codes
                    andb      #15       ; mask b using #15
                    std       0,s       ; store d in the current stack frame at 0,s
                    pshs      d         ; save d on the stack
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    cmpd      #9        ; compare d with #9 and set the condition codes
                    ble       L06A2     ; branch when the signed value is less than or equal; target L06A2
                    ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    beq       L069A     ; branch when the values are equal or the result is zero; target L069A
                    ldd       #65       ; set d to the constant 65
                    bra       L069D     ; continue execution at L069D
L069A               ldd       #97       ; set d to the constant 97
L069D               addd      #-10      ; add to d using #-10
                    bra       L06A5     ; continue execution at L06A5
L06A2               ldd       #48       ; set d to the constant 48
L06A5               addd      ,s++      ; add to d using ,s++
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
                    bne       L0680     ; branch when the values differ or the result is nonzero; target L0680
                    bra       L06C5     ; continue execution at L06C5
L06BB               ldb       U0000,u   ; load b from U0000,u
                    ldx       $02,s     ; load x from the current stack frame at $02,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       $02,s     ; store x in the current stack frame at $02,s
                    stb       -$01,x    ; store b at -$01,x
L06C5               leau      -$01,u    ; form the workspace or data address -$01,u in u
                    pshs      u         ; save u on the stack
                    leax      >$01BB,y  ; form the address >$01BB,y in x
                    cmpx      ,s++      ; compare x with ,s++ and set the condition codes
                    bls       L06BB     ; branch when the unsigned value is lower or equal; target L06BB
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       [<$02,s]  ; store b in the current stack frame at [<$02,s]
                    leax      >$01B1,y  ; form the address >$01B1,y in x
                    tfr       x,d       ; copy the register values specified by x,d
                    lbra      L07B7     ; continue execution at L07B7
L06DF               pshs      u         ; save u on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    subd      $08,s     ; subtract from d using $08,s
                    std       $0A,s     ; store d in the current stack frame at $0A,s
                    ldd       >$01C5,y  ; load d from >$01C5,y
                    bne       L0714     ; branch when the values differ or the result is nonzero; target L0714
                    bra       L06FC     ; continue execution at L06FC
L06F1               ldd       >$01C7,y  ; load d from >$01C7,y
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
L06FC               ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    addd      #-1       ; add to d using #-1
                    std       $0A,s     ; store d in the current stack frame at $0A,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       L06F1     ; branch when the signed value is greater; target L06F1
                    bra       L0714     ; continue execution at L0714
L070A               ldb       ,u+       ; load b from ,u+
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
L0714               ldd       $08,s     ; load d from the current stack frame at $08,s
                    addd      #-1       ; add to d using #-1
                    std       $08,s     ; store d in the current stack frame at $08,s
                    subd      #-1       ; subtract from d using #-1
                    bne       L070A     ; branch when the values differ or the result is nonzero; target L070A
                    ldd       >$01C5,y  ; load d from >$01C5,y
                    beq       L073F     ; branch when the values are equal or the result is zero; target L073F
                    bra       L0733     ; continue execution at L0733
L0728               ldd       >$01C7,y  ; load d from >$01C7,y
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
L0733               ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    addd      #-1       ; add to d using #-1
                    std       $0A,s     ; store d in the current stack frame at $0A,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       L0728     ; branch when the signed value is greater; target L0728
L073F               puls      pc,u      ; restore pc,u and return to the caller
L0741               pshs      u         ; save u on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    ldd       $08,s     ; load d from the current stack frame at $08,s
                    pshs      d         ; save d on the stack
                    pshs      u         ; save u on the stack
                    lbsr      L0AC8     ; call subroutine L0AC8
                    leas      $02,s     ; adjust the system stack pointer
                    nega                ; negate a
                    negb                ; negate b
                    sbca      #0        ; subtract with borrow from a using #0
                    addd      ,s++      ; add to d using ,s++
                    std       $08,s     ; store d in the current stack frame at $08,s
                    ldd       >$01C5,y  ; load d from >$01C5,y
                    bne       L0783     ; branch when the values differ or the result is nonzero; target L0783
                    bra       L076B     ; continue execution at L076B
L0760               ldd       >$01C7,y  ; load d from >$01C7,y
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
L076B               ldd       $08,s     ; load d from the current stack frame at $08,s
                    addd      #-1       ; add to d using #-1
                    std       $08,s     ; store d in the current stack frame at $08,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       L0760     ; branch when the signed value is greater; target L0760
                    bra       L0783     ; continue execution at L0783
L0779               ldb       ,u+       ; load b from ,u+
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
L0783               ldb       U0000,u   ; load b from U0000,u
                    bne       L0779     ; branch when the values differ or the result is nonzero; target L0779
                    ldd       >$01C5,y  ; load d from >$01C5,y
                    beq       L07A6     ; branch when the values are equal or the result is zero; target L07A6
                    bra       L079A     ; continue execution at L079A
L078F               ldd       >$01C7,y  ; load d from >$01C7,y
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
L079A               ldd       $08,s     ; load d from the current stack frame at $08,s
                    addd      #-1       ; add to d using #-1
                    std       $08,s     ; store d in the current stack frame at $08,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       L078F     ; branch when the signed value is greater; target L078F
L07A6               puls      pc,u      ; restore pc,u and return to the caller
L07A8               fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $AF       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $17       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $1D       ; store byte data
L07B7               leas      $04,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
                    fcb       $34       ; store byte data
                    fcb       $40       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $AE       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $AF       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $AF       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $AF       ; store byte data
                    fcb       $E7       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $C0       ; store byte data
L07CD               fcc       "-32768" ; store literal character data
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
                    fcb       $01       ; store byte data
                    fcb       $F9       ; store byte data
                    fcb       $32       ; store byte data
                    fcb       $62       ; store byte data
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
                    fcb       $05       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $8D       ; store byte data
                    fcb       $05       ; store byte data
                    fcb       $43       ; store byte data
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
                    fcb       $03       ; store byte data
                    fcb       $98       ; store byte data
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
L089C               pshs      u,d       ; save u,d on the stack
                    leau      >$000E,y  ; form the workspace or data address >$000E,y in u
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       0,s       ; store d in the current stack frame at 0,s
                    bra       L08B2     ; continue execution at L08B2
L08A8               tfr       u,d       ; copy the register values specified by u,d
                    leau      U000D,u   ; form the workspace or data address U000D,u in u
                    pshs      d         ; save d on the stack
                    bsr       L08C5     ; call subroutine L08C5
                    leas      $02,s     ; adjust the system stack pointer
L08B2               ldd       0,s       ; load d from the current stack frame at 0,s
                    addd      #1        ; add to d using #1
                    std       0,s       ; store d in the current stack frame at 0,s
                    subd      #1        ; subtract from d using #1
                    cmpd      #16       ; compare d with #16 and set the condition codes
                    blt       L08A8     ; branch when the signed value is less; target L08A8
                    lbra      L0929     ; continue execution at L0929
L08C5               pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    leas      -$02,s    ; adjust the system stack pointer
                    cmpu      #0        ; compare u with #0 and set the condition codes
                    beq       L08D5     ; branch when the values are equal or the result is zero; target L08D5
                    ldd       U0006,u   ; load d from U0006,u
                    bne       L08DB     ; branch when the values differ or the result is nonzero; target L08DB
L08D5               ldd       #-1       ; set d to the constant -1
                    lbra      L0929     ; continue execution at L0929
L08DB               ldd       U0006,u   ; load d from U0006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #2        ; mask b using #2
                    beq       L08EA     ; branch when the values are equal or the result is zero; target L08EA
                    pshs      u         ; save u on the stack
                    bsr       L08FF     ; call subroutine L08FF
                    leas      $02,s     ; adjust the system stack pointer
                    bra       L08EC     ; continue execution at L08EC
L08EA               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
L08EC               std       0,s       ; store d in the current stack frame at 0,s
                    ldd       U0008,u   ; load d from U0008,u
                    pshs      d         ; save d on the stack
                    lbsr      L0CC2     ; call subroutine L0CC2
                    leas      $02,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       U0006,u   ; store d at U0006,u
                    ldd       0,s       ; load d from the current stack frame at 0,s
                    bra       L0929     ; continue execution at L0929
L08FF               pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    beq       L0910     ; branch when the values are equal or the result is zero; target L0910
                    ldd       U0006,u   ; load d from U0006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #34       ; mask b using #34
                    cmpd      #2        ; compare d with #2 and set the condition codes
                    beq       L0915     ; branch when the values are equal or the result is zero; target L0915
L0910               ldd       #-1       ; set d to the constant -1
                    puls      pc,u      ; restore pc,u and return to the caller
L0915               ldd       U0006,u   ; load d from U0006,u
                    anda      #128      ; mask a using #128
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    bne       L0925     ; branch when the values differ or the result is nonzero; target L0925
                    pshs      u         ; save u on the stack
                    lbsr      L09EF     ; call subroutine L09EF
                    leas      $02,s     ; adjust the system stack pointer
L0925               pshs      u         ; save u on the stack
                    bsr       L092D     ; call subroutine L092D
L0929               leas      $02,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
L092D               pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    leas      -$04,s    ; adjust the system stack pointer
                    ldd       U0006,u   ; load d from U0006,u
                    anda      #1        ; mask a using #1
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    bne       L095F     ; branch when the values differ or the result is nonzero; target L095F
                    ldd       U0000,u   ; load d from U0000,u
                    cmpd      U0004,u   ; compare d with U0004,u and set the condition codes
                    beq       L095F     ; branch when the values are equal or the result is zero; target L095F
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    pshs      u         ; save u on the stack
                    lbsr      L09EB     ; call subroutine L09EB
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       $02,x     ; load d from $02,x
                    pshs      d         ; save d on the stack
                    ldd       0,x       ; load d from 0,x
                    pshs      d         ; save d on the stack
                    ldd       U0008,u   ; load d from U0008,u
                    pshs      d         ; save d on the stack
                    lbsr      L0D89     ; call subroutine L0D89
                    leas      $08,s     ; adjust the system stack pointer
L095F               ldd       U0000,u   ; load d from U0000,u
                    subd      U0002,u   ; subtract from d using U0002,u
                    std       $02,s     ; store d in the current stack frame at $02,s
                    lbeq      L09D7     ; branch when the values are equal or the result is zero; target L09D7
                    ldd       U0006,u   ; load d from U0006,u
                    anda      #1        ; mask a using #1
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    lbeq      L09D7     ; branch when the values are equal or the result is zero; target L09D7
                    ldd       U0006,u   ; load d from U0006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #64       ; mask b using #64
                    beq       L09AE     ; branch when the values are equal or the result is zero; target L09AE
                    ldd       U0002,u   ; load d from U0002,u
                    bra       L09A6     ; continue execution at L09A6
L097F               ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    ldd       U0000,u   ; load d from U0000,u
                    pshs      d         ; save d on the stack
                    ldd       U0008,u   ; load d from U0008,u
                    pshs      d         ; save d on the stack
                    lbsr      L0D79     ; call subroutine L0D79
                    leas      $06,s     ; adjust the system stack pointer
                    std       0,s       ; store d in the current stack frame at 0,s
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    bne       L099C     ; branch when the values differ or the result is nonzero; target L099C
                    leax      $04,s     ; form the address $04,s in x
                    bra       L09C6     ; continue execution at L09C6
L099C               ldd       $02,s     ; load d from the current stack frame at $02,s
                    subd      0,s       ; subtract from d using 0,s
                    std       $02,s     ; store d in the current stack frame at $02,s
                    ldd       U0000,u   ; load d from U0000,u
                    addd      0,s       ; add to d using 0,s
L09A6               std       U0000,u   ; store d at U0000,u
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    bne       L097F     ; branch when the values differ or the result is nonzero; target L097F
                    bra       L09D7     ; continue execution at L09D7
L09AE               ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    ldd       U0002,u   ; load d from U0002,u
                    pshs      d         ; save d on the stack
                    ldd       U0008,u   ; load d from U0008,u
                    pshs      d         ; save d on the stack
                    lbsr      L0D60     ; call subroutine L0D60
                    leas      $06,s     ; adjust the system stack pointer
                    cmpd      $02,s     ; compare d with $02,s and set the condition codes
                    beq       L09D7     ; branch when the values are equal or the result is zero; target L09D7
                    bra       L09C8     ; continue execution at L09C8
L09C6               leas      -$04,x    ; adjust the system stack pointer
L09C8               ldd       U0006,u   ; load d from U0006,u
                    orb       #32       ; set selected bits in b using #32
                    std       U0006,u   ; store d at U0006,u
                    ldd       U0004,u   ; load d from U0004,u
                    std       U0000,u   ; store d at U0000,u
                    ldd       #-1       ; set d to the constant -1
                    bra       L09E7     ; continue execution at L09E7
L09D7               ldd       U0006,u   ; load d from U0006,u
                    ora       #1        ; set selected bits in a using #1
                    std       U0006,u   ; store d at U0006,u
                    ldd       U0002,u   ; load d from U0002,u
                    std       U0000,u   ; store d at U0000,u
                    addd      U000B,u   ; add to d using U000B,u
                    std       U0004,u   ; store d at U0004,u
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
L09E7               leas      $04,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
L09EB               pshs      u         ; save u on the stack
                    puls      pc,u      ; restore pc,u and return to the caller
L09EF               pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    ldd       U0006,u   ; load d from U0006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #192      ; mask b using #192
                    bne       L0A27     ; branch when the values differ or the result is nonzero; target L0A27
                    leas      -$20,s    ; adjust the system stack pointer
                    leax      0,s       ; form the address 0,s in x
                    pshs      x         ; save x on the stack
                    ldd       U0008,u   ; load d from U0008,u
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      L0C44     ; call subroutine L0C44
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       U0006,u   ; load d from U0006,u
                    pshs      d         ; save d on the stack
                    ldb       $02,s     ; load b from the current stack frame at $02,s
                    bne       L0A1B     ; branch when the values differ or the result is nonzero; target L0A1B
                    ldd       #64       ; set d to the constant 64
                    bra       L0A1E     ; continue execution at L0A1E
L0A1B               ldd       #128      ; set d to the constant 128
L0A1E               ora       ,s+       ; set selected bits in a using ,s+
                    orb       ,s+       ; set selected bits in b using ,s+
                    std       U0006,u   ; store d at U0006,u
                    leas      <$0020,s  ; adjust the system stack pointer
L0A27               ldd       U0006,u   ; load d from U0006,u
                    ora       #128      ; set selected bits in a using #128
                    std       U0006,u   ; store d at U0006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #12       ; mask b using #12
                    beq       L0A34     ; branch when the values are equal or the result is zero; target L0A34
                    puls      pc,u      ; restore pc,u and return to the caller
L0A34               ldd       U000B,u   ; load d from U000B,u
                    bne       L0A49     ; branch when the values differ or the result is nonzero; target L0A49
                    ldd       U0006,u   ; load d from U0006,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #64       ; mask b using #64
                    beq       L0A44     ; branch when the values are equal or the result is zero; target L0A44
                    ldd       #128      ; set d to the constant 128
                    bra       L0A47     ; continue execution at L0A47
L0A44               ldd       #256      ; set d to the constant 256
L0A47               std       U000B,u   ; store d at U000B,u
L0A49               ldd       U0002,u   ; load d from U0002,u
                    bne       L0A5E     ; branch when the values differ or the result is nonzero; target L0A5E
                    ldd       U000B,u   ; load d from U000B,u
                    pshs      d         ; save d on the stack
                    lbsr      L0E47     ; call subroutine L0E47
                    leas      $02,s     ; adjust the system stack pointer
                    std       U0002,u   ; store d at U0002,u
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    beq       L0A66     ; branch when the values are equal or the result is zero; target L0A66
L0A5E               ldd       U0006,u   ; load d from U0006,u
                    orb       #8        ; set selected bits in b using #8
                    std       U0006,u   ; store d at U0006,u
                    bra       L0A75     ; continue execution at L0A75
L0A66               ldd       U0006,u   ; load d from U0006,u
                    orb       #4        ; set selected bits in b using #4
                    std       U0006,u   ; store d at U0006,u
                    leax      U000A,u   ; form the address U000A,u in x
                    stx       U0002,u   ; store x at U0002,u
                    ldd       #1        ; set d to the constant 1
                    std       U000B,u   ; store d at U000B,u
L0A75               ldd       U0002,u   ; load d from U0002,u
                    addd      U000B,u   ; add to d using U000B,u
                    std       U0004,u   ; store d at U0004,u
                    std       U0000,u   ; store d at U0000,u
                    puls      pc,u      ; restore pc,u and return to the caller
L0A7F               pshs      u         ; save u on the stack
                    ldb       $05,s     ; load b from the current stack frame at $05,s
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; copy the register values specified by d,x
                    bra       L0AA5     ; continue execution at L0AA5
L0A88               ldd       [<$06,s]  ; load d from the current stack frame at [<$06,s]
                    addd      #4        ; add to d using #4
                    std       [<$06,s]  ; store d in the current stack frame at [<$06,s]
                    leax      >L0ABC,pc ; form the address >L0ABC,pc in x
                    bra       L0AA1     ; continue execution at L0AA1
L0A97               ldb       $05,s     ; load b from the current stack frame at $05,s
                    stb       >$000C,y  ; store b at >$000C,y
                    leax      >$000B,y  ; form the address >$000B,y in x
L0AA1               tfr       x,d       ; copy the register values specified by x,d
                    puls      pc,u      ; restore pc,u and return to the caller
L0AA5               cmpx      #100      ; compare x with #100 and set the condition codes
                    beq       L0A88     ; branch when the values are equal or the result is zero; target L0A88
                    cmpx      #111      ; compare x with #111 and set the condition codes
                    lbeq      L0A88     ; branch when the values are equal or the result is zero; target L0A88
                    cmpx      #120      ; compare x with #120 and set the condition codes
                    lbeq      L0A88     ; branch when the values are equal or the result is zero; target L0A88
                    bra       L0A97     ; continue execution at L0A97
                    fcb       $35       ; store byte data
                    fcb       $C0       ; store byte data
L0ABC               fcb       $00       ; store byte data
L0ABD               pshs      u         ; save u on the stack
                    leax      >L0AC7,pc ; form the address >L0AC7,pc in x
                    tfr       x,d       ; copy the register values specified by x,d
                    puls      pc,u      ; restore pc,u and return to the caller
L0AC7               fcb       $00       ; store byte data
L0AC8               pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
L0ACC               ldb       ,u+       ; load b from ,u+
                    bne       L0ACC     ; branch when the values differ or the result is nonzero; target L0ACC
                    tfr       u,d       ; copy the register values specified by u,d
                    subd      $04,s     ; subtract from d using $04,s
                    addd      #-1       ; add to d using #-1
                    puls      pc,u      ; restore pc,u and return to the caller
L0AD9               pshs      u         ; save u on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    leas      -$02,s    ; adjust the system stack pointer
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    std       0,s       ; store d in the current stack frame at 0,s
L0AE3               ldb       ,u+       ; load b from ,u+
                    ldx       0,s       ; load x from the current stack frame at 0,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       0,s       ; store x in the current stack frame at 0,s
                    stb       -$01,x    ; store b at -$01,x
                    bne       L0AE3     ; branch when the values differ or the result is nonzero; target L0AE3
                    bra       L0B18     ; continue execution at L0B18
L0AF1               pshs      u         ; save u on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    leas      -$02,s    ; adjust the system stack pointer
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    std       0,s       ; store d in the current stack frame at 0,s
L0AFB               ldx       0,s       ; load x from the current stack frame at 0,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       0,s       ; store x in the current stack frame at 0,s
                    ldb       -$01,x    ; load b from -$01,x
                    bne       L0AFB     ; branch when the values differ or the result is nonzero; target L0AFB
                    ldd       0,s       ; load d from the current stack frame at 0,s
                    addd      #-1       ; add to d using #-1
                    std       0,s       ; store d in the current stack frame at 0,s
L0B0C               ldb       ,u+       ; load b from ,u+
                    ldx       0,s       ; load x from the current stack frame at 0,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       0,s       ; store x in the current stack frame at 0,s
                    stb       -$01,x    ; store b at -$01,x
                    bne       L0B0C     ; branch when the values differ or the result is nonzero; target L0B0C
L0B18               ldd       $06,s     ; load d from the current stack frame at $06,s
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
L0B4F               pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    leas      -$05,s    ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       $01,s     ; store d in the current stack frame at $01,s
L0B59               ldb       ,u+       ; load b from ,u+
                    stb       0,s       ; store b in the current stack frame at 0,s
                    cmpb      #32       ; compare b with #32 and set the condition codes
                    beq       L0B59     ; branch when the values are equal or the result is zero; target L0B59
                    ldb       0,s       ; load b from the current stack frame at 0,s
                    cmpb      #9        ; compare b with #9 and set the condition codes
                    lbeq      L0B59     ; branch when the values are equal or the result is zero; target L0B59
                    ldb       0,s       ; load b from the current stack frame at 0,s
                    cmpb      #45       ; compare b with #45 and set the condition codes
                    bne       L0B74     ; branch when the values differ or the result is nonzero; target L0B74
                    ldd       #1        ; set d to the constant 1
                    bra       L0B76     ; continue execution at L0B76
L0B74               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
L0B76               std       $03,s     ; store d in the current stack frame at $03,s
                    ldb       0,s       ; load b from the current stack frame at 0,s
                    cmpb      #45       ; compare b with #45 and set the condition codes
                    beq       L0B9C     ; branch when the values are equal or the result is zero; target L0B9C
                    ldb       0,s       ; load b from the current stack frame at 0,s
                    cmpb      #43       ; compare b with #43 and set the condition codes
                    bne       L0BA0     ; branch when the values differ or the result is nonzero; target L0BA0
                    bra       L0B9C     ; continue execution at L0B9C
L0B86               ldd       $01,s     ; load d from the current stack frame at $01,s
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    lbsr      L0BC2     ; call subroutine L0BC2
                    pshs      d         ; save d on the stack
                    ldb       $02,s     ; load b from the current stack frame at $02,s
                    sex                 ; sign-extend b into d
                    addd      ,s++      ; add to d using ,s++
                    addd      #-48      ; add to d using #-48
                    std       $01,s     ; store d in the current stack frame at $01,s
L0B9C               ldb       ,u+       ; load b from ,u+
                    stb       0,s       ; store b in the current stack frame at 0,s
L0BA0               ldb       0,s       ; load b from the current stack frame at 0,s
                    sex                 ; sign-extend b into d
                    leax      >$00DF,y  ; form the address >$00DF,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       0,x       ; load b from 0,x
                    clra                ; clear a to zero and set the condition codes
                    andb      #8        ; mask b using #8
                    bne       L0B86     ; branch when the values differ or the result is nonzero; target L0B86
                    ldd       $03,s     ; load d from the current stack frame at $03,s
                    beq       L0BBC     ; branch when the values are equal or the result is zero; target L0BBC
                    ldd       $01,s     ; load d from the current stack frame at $01,s
                    nega                ; negate a
                    negb                ; negate b
                    sbca      #0        ; subtract with borrow from a using #0
                    bra       L0BBE     ; continue execution at L0BBE
L0BBC               ldd       $01,s     ; load d from the current stack frame at $01,s
L0BBE               leas      $05,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
L0BC2               tsta                ; set condition codes from a without changing it
                    bne       L0BD7     ; branch when the values differ or the result is nonzero; target L0BD7
                    tst       $02,s     ; set condition codes from $02,s without changing it
                    bne       L0BD7     ; branch when the values differ or the result is nonzero; target L0BD7
                    lda       $03,s     ; load a from the current stack frame at $03,s
                    mul                 ; multiply a by b and return the product in d
                    ldx       0,s       ; load x from the current stack frame at 0,s
                    stx       $02,s     ; store x in the current stack frame at $02,s
                    ldx       #0        ; set x to the constant 0
                    std       0,s       ; store d in the current stack frame at 0,s
                    puls      pc,d      ; restore pc,d and return to the caller
L0BD7               pshs      d         ; save d on the stack
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
                    bcc       L0BF4     ; branch when carry is clear; target L0BF4
                    inc       0,s       ; increment the value at 0,s
L0BF4               lda       $04,s     ; load a from the current stack frame at $04,s
                    ldb       $09,s     ; load b from the current stack frame at $09,s
                    mul                 ; multiply a by b and return the product in d
                    addd      $01,s     ; add to d using $01,s
                    std       $01,s     ; store d in the current stack frame at $01,s
                    bcc       L0C01     ; branch when carry is clear; target L0C01
                    inc       0,s       ; increment the value at 0,s
L0C01               lda       $04,s     ; load a from the current stack frame at $04,s
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
L0C44               lda       $05,s     ; load a from the current stack frame at $05,s
                    ldb       $03,s     ; load b from the current stack frame at $03,s
                    beq       L0C77     ; branch when the values are equal or the result is zero; target L0C77
                    cmpb      #1        ; compare b with #1 and set the condition codes
                    beq       L0C79     ; branch when the values are equal or the result is zero; target L0C79
                    cmpb      #6        ; compare b with #6 and set the condition codes
                    beq       L0C79     ; branch when the values are equal or the result is zero; target L0C79
                    cmpb      #2        ; compare b with #2 and set the condition codes
                    beq       L0C5F     ; branch when the values are equal or the result is zero; target L0C5F
                    cmpb      #5        ; compare b with #5 and set the condition codes
                    beq       L0C5F     ; branch when the values are equal or the result is zero; target L0C5F
                    ldb       #208      ; set b to the constant 208
                    lbra      L0F1C     ; continue execution at L0F1C
L0C5F               pshs      u         ; save u on the stack
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    bcc       L0C6B     ; branch when carry is clear; target L0C6B
                    puls      u         ; restore u from the stack
                    lbra      L0F1C     ; continue execution at L0F1C
L0C6B               stx       [<$08,s]  ; store x in the current stack frame at [<$08,s]
                    ldx       $08,s     ; load x from the current stack frame at $08,s
                    stu       $02,x     ; store u at $02,x
                    puls      u         ; restore u from the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    rts                 ; return to the caller
L0C77               ldx       $06,s     ; load x from the current stack frame at $06,s
L0C79               os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    lbra      L0F25     ; continue execution at L0F25
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
                    fcb       $02       ; store byte data
                    fcb       $8E       ; store byte data
                    fcb       $AE       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $8E       ; store byte data
                    fcb       $16       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $8F       ; store byte data
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
                    fcb       $02       ; store byte data
                    fcb       $81       ; store byte data
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
                    fcb       $02       ; store byte data
                    fcb       $72       ; store byte data
                    fcb       $AE       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $A6       ; store byte data
                    fcb       $65       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $84       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $5E       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $89       ; store byte data
                    fcb       $4F       ; store byte data
                    fcb       $39       ; store byte data
L0CC2               lda       $03,s     ; load a from the current stack frame at $03,s
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lbra      L0F25     ; continue execution at L0F25
                    fcb       $AE       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $E6       ; store byte data
                    fcb       $65       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $85       ; store byte data
                    fcb       $16       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $51       ; store byte data
                    fcb       $AE       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $A6       ; store byte data
                    fcb       $65       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $89       ; store byte data
                    fcb       $C4       ; store byte data
                    fcb       $24       ; store byte data
                    fcb       $CA       ; store byte data
                    fcb       $0B       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $83       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $89       ; store byte data
                    fcb       $4F       ; store byte data
                    fcb       $39       ; store byte data
                    fcb       $C1       ; store byte data
                    fcb       $DA       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $26       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $2F       ; store byte data
                    fcb       $A6       ; store byte data
                    fcb       $65       ; store byte data
                    fcb       $85       ; store byte data
                    fcb       $80       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $26       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $84       ; store byte data
                    fcb       $07       ; store byte data
                    fcb       $AE       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $84       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $1C       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $42       ; store byte data
                    fcb       $8E       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $33       ; store byte data
                    fcb       $84       ; store byte data
                    fcb       $C6       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $8E       ; store byte data
                    fcc       "5B$" ; store literal character data
                    fcb       $D3       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $8F       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $16       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $AE       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $87       ; store byte data
                    fcb       $16       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $A6       ; store byte data
                    fcb       $63       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $82       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $F1       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $89       ; store byte data
                    fcc       "O94 " ; store literal character data
                    fcb       $AE       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $A6       ; store byte data
                    fcb       $65       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $AE       ; store byte data
                    fcc       "h4 " ; store literal character data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $89       ; store byte data
                    fcb       $24       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $C1       ; store byte data
                    fcb       $D3       ; store byte data
                    fcb       $26       ; store byte data
                    fcb       $04       ; store byte data
                    fcc       "O_5" ; store literal character data
                    fcb       $B0       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $30       ; store byte data
                    fcb       $16       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $D0       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $20       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $B0       ; store byte data
                    fcb       $34       ; store byte data
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
L0D60               pshs      y         ; save y on the stack
                    ldy       $08,s     ; load y from the current stack frame at $08,s
                    beq       L0D75     ; branch when the values are equal or the result is zero; target L0D75
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    ldx       $06,s     ; load x from the current stack frame at $06,s
                    os9       I$Write   ; invoke the OS-9 I$Write service
L0D6E               bcc       L0D75     ; branch when carry is clear; target L0D75
                    puls      y         ; restore y from the stack
                    lbra      L0F1C     ; continue execution at L0F1C
L0D75               tfr       y,d       ; copy the register values specified by y,d
                    puls      pc,y      ; restore pc,y and return to the caller
L0D79               pshs      y         ; save y on the stack
                    ldy       $08,s     ; load y from the current stack frame at $08,s
                    beq       L0D75     ; branch when the values are equal or the result is zero; target L0D75
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    ldx       $06,s     ; load x from the current stack frame at $06,s
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    bra       L0D6E     ; continue execution at L0D6E
L0D89               pshs      u         ; save u on the stack
                    ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    bne       L0D97     ; branch when the values differ or the result is nonzero; target L0D97
                    ldu       #0        ; set u to the constant 0
                    ldx       #0        ; set x to the constant 0
                    bra       L0DCB     ; continue execution at L0DCB
L0D97               cmpd      #1        ; compare d with #1 and set the condition codes
                    beq       L0DC2     ; branch when the values are equal or the result is zero; target L0DC2
                    cmpd      #2        ; compare d with #2 and set the condition codes
                    beq       L0DB7     ; branch when the values are equal or the result is zero; target L0DB7
                    ldb       #247      ; set b to the constant 247
L0DA5               clra                ; clear a to zero and set the condition codes
                    std       >$01AD,y  ; store d at >$01AD,y
                    ldd       #-1       ; set d to the constant -1
                    leax      >$01A1,y  ; form the address >$01A1,y in x
                    std       0,x       ; store d at 0,x
                    std       $02,x     ; store d at $02,x
                    puls      pc,u      ; restore pc,u and return to the caller
L0DB7               lda       $05,s     ; load a from the current stack frame at $05,s
                    ldb       #2        ; set b to the constant 2
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    bcs       L0DA5     ; branch when carry reports an error or unsigned underflow; target L0DA5
                    bra       L0DCB     ; continue execution at L0DCB
L0DC2               lda       $05,s     ; load a from the current stack frame at $05,s
                    ldb       #5        ; set b to the constant 5
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    bcs       L0DA5     ; branch when carry reports an error or unsigned underflow; target L0DA5
L0DCB               tfr       u,d       ; copy the register values specified by u,d
                    addd      $08,s     ; add to d using $08,s
                    std       >$01A3,y  ; store d at >$01A3,y
                    tfr       d,u       ; copy the register values specified by d,u
                    tfr       x,d       ; copy the register values specified by x,d
                    adcb      $07,s     ; add with carry to b using $07,s
                    adca      $06,s     ; add with carry to a using $06,s
                    bmi       L0DA5     ; branch when the result is negative; target L0DA5
                    tfr       d,x       ; copy the register values specified by d,x
                    std       >$01A1,y  ; store d at >$01A1,y
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    bcs       L0DA5     ; branch when carry reports an error or unsigned underflow; target L0DA5
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
                    fcb       $01       ; store byte data
                    fcb       $C9       ; store byte data
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
                    fcb       $01       ; store byte data
                    fcb       $C9       ; store byte data
                    fcb       $A3       ; store byte data
                    fcb       $E4       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $C9       ; store byte data
                    fcb       $32       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $EC       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $C9       ; store byte data
                    fcb       $34       ; store byte data
                    fcb       $06       ; store byte data
                    fcb       $A3       ; store byte data
                    fcb       $64       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $A9       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $C9       ; store byte data
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
L0E47               ldd       $02,s     ; load d from the current stack frame at $02,s
                    addd      >$01A9,y  ; add to d using >$01A9,y
                    bcs       L0E70     ; branch when carry reports an error or unsigned underflow; target L0E70
                    cmpd      >$01AB,y  ; compare d with >$01AB,y and set the condition codes
                    bcc       L0E70     ; branch when carry is clear; target L0E70
                    pshs      d         ; save d on the stack
                    ldx       >$01A9,y  ; load x from >$01A9,y
                    clra                ; clear a to zero and set the condition codes
L0E5D               cmpx      0,s       ; compare x with 0,s and set the condition codes
                    bcc       L0E65     ; branch when carry is clear; target L0E65
                    sta       ,x+       ; store a at ,x+
                    bra       L0E5D     ; continue execution at L0E5D
L0E65               ldd       >$01A9,y  ; load d from >$01A9,y
                    puls      x         ; restore x from the stack
                    stx       >$01A9,y  ; store x at >$01A9,y
                    rts                 ; return to the caller
L0E70               ldd       #-1       ; set d to the constant -1
                    rts                 ; return to the caller
                    fcb       $A6       ; store byte data
                    fcb       $63       ; store byte data
                    fcb       $E6       ; store byte data
                    fcb       $65       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $08       ; store byte data
                    fcb       $16       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $A7       ; store byte data
                    fcb       $4F       ; store byte data
                    fcb       $5F       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $95       ; store byte data
                    fcb       $AE       ; store byte data
                    fcb       $62       ; store byte data
                    fcb       $27       ; store byte data
                    fcb       $04       ; store byte data
                    fcb       $E7       ; store byte data
                    fcb       $01       ; store byte data
                    fcb       $6F       ; store byte data
                    fcb       $84       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $89       ; store byte data
                    fcb       $4F       ; store byte data
                    fcb       $39       ; store byte data
                    fcb       $A6       ; store byte data
                    fcb       $63       ; store byte data
                    fcb       $E6       ; store byte data
                    fcb       $65       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $16       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $88       ; store byte data
L0E9D               leau      0,s       ; form the workspace or data address 0,s in u
                    leas      >$00FF,y  ; adjust the system stack pointer
                    ldx       U0002,u   ; load x from U0002,u
                    ldy       U0004,u   ; load y from U0004,u
                    lda       U0009,u   ; load a from U0009,u
                    asla                ; shift a left arithmetically
                    asla                ; shift a left arithmetically
                    asla                ; shift a left arithmetically
                    asla                ; shift a left arithmetically
                    ora       U000B,u   ; set selected bits in a using U000B,u
                    ldb       U000D,u   ; load b from U000D,u
                    ldu       U0006,u   ; load u from U0006,u
                    os9       F$Chain   ; invoke the OS-9 F$Chain service
                    os9       F$Exit    ; invoke the OS-9 F$Exit service
                    fcb       $34       ; store byte data
                    fcb       $60       ; store byte data
                    fcb       $AE       ; store byte data
                    fcb       $66       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $AE       ; store byte data
                    fcb       $68       ; store byte data
                    fcb       $EE       ; store byte data
                    fcb       $6A       ; store byte data
                    fcb       $A6       ; store byte data
                    fcb       $6D       ; store byte data
                    fcb       $AA       ; store byte data
                    fcb       $6F       ; store byte data
                    fcb       $E6       ; store byte data
                    fcb       $E8       ; store byte data
                    fcb       $11       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $03       ; store byte data
                    fcb       $35       ; store byte data
                    fcb       $60       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $49       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $89       ; store byte data
                    fcc       "O94 " ; store literal character data
                    fcb       $10       ; store byte data
                    fcb       $3F       ; store byte data
                    fcb       $0C       ; store byte data
                    fcc       "5 $" ; store literal character data
                    fcb       $04       ; store byte data
                    fcb       $10       ; store byte data
                    fcb       $25       ; store byte data
                    fcb       $00       ; store byte data
                    fcb       $38       ; store byte data
                    fcb       $1F       ; store byte data
                    fcb       $89       ; store byte data
                    fcc       "O9" ; store literal character data
L0EE8               pshs      y         ; save y on the stack
                    os9       F$ID      ; invoke the OS-9 F$ID service
                    bcc       L0EF4     ; branch when carry is clear; target L0EF4
L0EEF               puls      y         ; restore y from the stack
                    lbra      L0F1C     ; continue execution at L0F1C
L0EF4               tfr       y,d       ; copy the register values specified by y,d
                    puls      pc,y      ; restore pc,y and return to the caller
L0EF8               pshs      y         ; save y on the stack
                    bsr       L0EE8     ; call subroutine L0EE8
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    beq       L0F04     ; branch when the values are equal or the result is zero; target L0F04
                    ldb       #214      ; set b to the constant 214
                    bra       L0EEF     ; continue execution at L0EEF
L0F04               ldy       $04,s     ; load y from the current stack frame at $04,s
                    os9       F$SUser   ; invoke the OS-9 F$SUser service
                    bcc       L0F18     ; branch when carry is clear; target L0F18
                    cmpb      #208      ; compare b with #208 and set the condition codes
                    bne       L0EEF     ; branch when the values differ or the result is nonzero; target L0EEF
                    tfr       y,d       ; copy the register values specified by y,d
                    ldy       >L004B    ; load y from >L004B
                    std       $09,y     ; store d at $09,y
L0F18               clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    puls      pc,y      ; restore pc,y and return to the caller
L0F1C               clra                ; clear a to zero and set the condition codes
                    std       >$01AD,y  ; store d at >$01AD,y
                    ldd       #-1       ; set d to the constant -1
                    rts                 ; return to the caller
L0F25               bcs       L0F1C     ; branch when carry reports an error or unsigned underflow; target L0F1C
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    rts                 ; return to the caller
L0F2A               lbsr      L0F35     ; call subroutine L0F35
                    lbsr      L089C     ; call subroutine L089C
L0F30               ldd       $02,s     ; load d from the current stack frame at $02,s
                    os9       F$Exit    ; invoke the OS-9 F$Exit service
L0F35               rts                 ; return to the caller
L0F36               fcb       $00       ; store byte data
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
                    fcc       "Suser" ; store literal character data
                    fcb       $00       ; store byte data

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
