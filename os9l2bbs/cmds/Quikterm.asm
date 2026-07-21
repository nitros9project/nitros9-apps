**********************************************************************
* Quikterm - OS-9 Level 2 BBS command
*
* Syntax: Quikterm [port]
* Purpose: Run a simple terminal emulator with XMODEM transfer support.
* Alt-T enters transfer mode; port settings are configured with xmode.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
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

WorkByte_001        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_002        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_001        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_002        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_003        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_004        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_003        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_005        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_001      rmb       343       ; reserve 343 byte(s) in the module workspace
WorkWord_006        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_002      rmb       58        ; reserve 58 byte(s) in the module workspace
WorkByte_004        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_003      rmb       3         ; reserve 3 byte(s) in the module workspace
WorkWord_007        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_004      rmb       1250      ; reserve 1250 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /Quikterm/ ; store an OS-9 high-bit-terminated string
                    fcb       $01       ; store byte data
Routine_001         lda       ,y+       ; load a from ,y+
                    sta       ,u+       ; store a at ,u+
                    leax      -$01,x    ; form the address -$01,x in x
                    bne       Routine_001 ; branch when the values differ or the result is nonzero; target Routine_001
                    rts                 ; return to the caller
start               pshs      y         ; save y on the stack
                    pshs      u         ; save u on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
Branch_001          sta       ,u+       ; store a at ,u+
                    decb                ; decrement b
                    bne       Branch_001 ; branch when the values differ or the result is nonzero; target Branch_001
                    ldx       ,s        ; load x from the current stack frame at ,s
                    leau      ,x        ; form the workspace or data address ,x in u
                    leax      >$0308,x  ; form the address >$0308,x in x
                    pshs      x         ; save x on the stack
                    leay      >Data_001,pc ; form the address >Data_001,pc in y
                    ldx       ,y++      ; load x from ,y++
                    beq       Branch_002 ; branch when the values are equal or the result is zero; target Branch_002
                    bsr       Routine_001 ; call subroutine Routine_001
                    ldu       $02,s     ; load u from the current stack frame at $02,s
Branch_002          leau      >WorkByte_002,u ; form the workspace or data address >WorkByte_002,u in u
                    ldx       ,y++      ; load x from ,y++
                    beq       Branch_003 ; branch when the values are equal or the result is zero; target Branch_003
                    bsr       Routine_001 ; call subroutine Routine_001
                    clra                ; clear a to zero and set the condition codes
Branch_003          cmpu      ,s        ; compare u with ,s and set the condition codes
                    beq       Branch_004 ; branch when the values are equal or the result is zero; target Branch_004
                    sta       ,u+       ; store a at ,u+
                    bra       Branch_003 ; continue execution at Branch_003
Branch_004          ldu       $02,s     ; load u from the current stack frame at $02,s
                    ldd       ,y++      ; load d from ,y++
                    beq       Branch_005 ; branch when the values are equal or the result is zero; target Branch_005
                    leax      >0,pc     ; form the address >,pc in x
                    lbsr      Routine_002 ; call subroutine Routine_002
Branch_005          ldd       ,y++      ; load d from ,y++
                    beq       Branch_006 ; branch when the values are equal or the result is zero; target Branch_006
                    leax      WorkByte_001,u ; form the address WorkByte_001,u in x
                    lbsr      Routine_002 ; call subroutine Routine_002
Branch_006          leas      $04,s     ; adjust the system stack pointer
                    puls      x         ; restore x from the stack
                    stx       >WorkWord_007,u ; store x at >WorkWord_007,u
                    sty       >WorkWord_006,u ; store y at >WorkWord_006,u
                    ldd       #1        ; set d to the constant 1
                    std       >WorkByte_004,u ; store d at >WorkByte_004,u
                    leay      >WorkBuffer_002,u ; form the address >WorkBuffer_002,u in y
                    leax      ,s        ; form the address ,s in x
                    lda       ,x+       ; load a from ,x+
Branch_007          ldb       >WorkBuffer_003,u ; load b from >WorkBuffer_003,u
                    cmpb      #29       ; compare b with #29 and set the condition codes
                    beq       Branch_008 ; branch when the values are equal or the result is zero; target Branch_008
Branch_009          cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_008 ; branch when the values are equal or the result is zero; target Branch_008
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       Branch_010 ; branch when the values are equal or the result is zero; target Branch_010
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    bne       Branch_011 ; branch when the values differ or the result is nonzero; target Branch_011
Branch_010          lda       ,x+       ; load a from ,x+
                    bra       Branch_009 ; continue execution at Branch_009
Branch_011          cmpa      #34       ; compare a with #34 and set the condition codes
                    beq       Branch_012 ; branch when the values are equal or the result is zero; target Branch_012
                    cmpa      #39       ; compare a with #39 and set the condition codes
                    bne       Branch_013 ; branch when the values differ or the result is nonzero; target Branch_013
Branch_012          stx       ,y++      ; store x at ,y++
                    inc       >WorkBuffer_003,u ; increment the value at >WorkBuffer_003,u
                    pshs      a         ; save a on the stack
Branch_014          lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_015 ; branch when the values are equal or the result is zero; target Branch_015
                    cmpa      ,s        ; compare a with ,s and set the condition codes
                    bne       Branch_014 ; branch when the values differ or the result is nonzero; target Branch_014
Branch_015          puls      b         ; restore b from the stack
                    clr       -$01,x    ; clear -$01,x to zero and set the condition codes
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_008 ; branch when the values are equal or the result is zero; target Branch_008
                    lda       ,x+       ; load a from ,x+
                    bra       Branch_007 ; continue execution at Branch_007
Branch_013          leax      -$01,x    ; form the address -$01,x in x
                    stx       ,y++      ; store x at ,y++
                    leax      $01,x     ; form the address $01,x in x
                    inc       >WorkBuffer_003,u ; increment the value at >WorkBuffer_003,u
Branch_016          cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_017 ; branch when the values are equal or the result is zero; target Branch_017
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       Branch_017 ; branch when the values are equal or the result is zero; target Branch_017
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    beq       Branch_017 ; branch when the values are equal or the result is zero; target Branch_017
                    lda       ,x+       ; load a from ,x+
                    bra       Branch_016 ; continue execution at Branch_016
Branch_017          clr       -$01,x    ; clear -$01,x to zero and set the condition codes
                    bra       Branch_007 ; continue execution at Branch_007
Branch_008          leax      >WorkWord_006,u ; form the address >WorkWord_006,u in x
                    pshs      x         ; save x on the stack
                    ldd       >WorkByte_004,u ; load d from >WorkByte_004,u
                    pshs      d         ; save d on the stack
                    leay      WorkByte_001,u ; form the address WorkByte_001,u in y
                    bsr       Routine_003 ; call subroutine Routine_003
                    lbsr      Routine_004 ; call subroutine Routine_004
                    clr       ,-s       ; clear ,-s to zero and set the condition codes
                    clr       ,-s       ; clear ,-s to zero and set the condition codes
                    lbsr      Routine_005 ; call subroutine Routine_005
Routine_003         leax      >$0308,y  ; form the address >$0308,y in x
                    stx       >$01AE,y  ; store x at >$01AE,y
                    sts       >$01A2,y  ; store s at >$01A2,y
                    sts       >$01B0,y  ; store s at >$01B0,y
                    ldd       #-126     ; set d to the constant -126
Routine_006         leax      d,s       ; form the address d,s in x
                    cmpx      >$01B0,y  ; compare x with >$01B0,y and set the condition codes
                    bcc       Branch_018 ; branch when carry is clear; target Branch_018
                    cmpx      >$01AE,y  ; compare x with >$01AE,y and set the condition codes
                    bcs       Branch_019 ; branch when carry reports an error or unsigned underflow; target Branch_019
                    stx       >$01B0,y  ; store x at >$01B0,y
Branch_018          rts                 ; return to the caller
Text_001            fcc       "**** STACK OVERFLOW ****" ; store literal character data
                    fcb       $0D       ; store byte data
Branch_019          leax      <Text_001,pc ; form the address <Text_001,pc in x
                    ldb       #207      ; set b to the constant 207
                    pshs      b         ; save b on the stack
                    lda       #2        ; set a to the constant 2
                    ldy       #100      ; set y to the constant 100
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    clr       ,-s       ; clear ,-s to zero and set the condition codes
                    lbsr      Routine_007 ; call subroutine Routine_007
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
Routine_002         pshs      x         ; save x on the stack
                    leax      d,y       ; form the address d,y in x
                    leax      d,x       ; form the address d,x in x
                    pshs      x         ; save x on the stack
Branch_020          ldd       ,y++      ; load d from ,y++
                    leax      d,u       ; form the address d,u in x
                    ldd       ,x        ; load d from ,x
                    addd      $02,s     ; add to d using $02,s
                    std       ,x        ; store d at ,x
                    cmpy      ,s        ; compare y with ,s and set the condition codes
                    bne       Branch_020 ; branch when the values differ or the result is nonzero; target Branch_020
                    leas      $04,s     ; adjust the system stack pointer
                    rts                 ; return to the caller
Data_002            fcb       $34       ; store byte data
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
Routine_004         pshs      u         ; save u on the stack
                    ldd       #-75      ; set d to the constant -75
                    lbsr      Routine_006 ; call subroutine Routine_006
                    leas      -$01,s    ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >$01B4,y  ; store d at >$01B4,y
                    ldd       $05,s     ; load d from the current stack frame at $05,s
                    cmpd      #1        ; compare d with #1 and set the condition codes
                    bne       Branch_021 ; branch when the values differ or the result is nonzero; target Branch_021
                    ldd       #3        ; set d to the constant 3
                    pshs      d         ; save d on the stack
                    leax      >Text_002,pc ; form the address >Text_002,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_008 ; call subroutine Routine_008
                    leas      $04,s     ; adjust the system stack pointer
                    std       >$01B6,y  ; store d at >$01B6,y
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    bne       Branch_022 ; branch when the values differ or the result is nonzero; target Branch_022
                    ldd       >$01B2,y  ; load d from >$01B2,y
                    pshs      d         ; save d on the stack
                    leax      >Text_003,pc ; form the address >Text_003,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_009 ; call subroutine Routine_009
                    leas      $04,s     ; adjust the system stack pointer
                    bra       Branch_022 ; continue execution at Branch_022
Branch_021          ldd       #3        ; set d to the constant 3
                    pshs      d         ; save d on the stack
                    ldx       $09,s     ; load x from the current stack frame at $09,s
                    ldd       $02,x     ; load d from $02,x
                    pshs      d         ; save d on the stack
                    lbsr      Routine_008 ; call subroutine Routine_008
                    leas      $04,s     ; adjust the system stack pointer
                    std       >$01B6,y  ; store d at >$01B6,y
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    bne       Branch_022 ; branch when the values differ or the result is nonzero; target Branch_022
                    ldx       $07,s     ; load x from the current stack frame at $07,s
                    ldd       $02,x     ; load d from $02,x
                    pshs      d         ; save d on the stack
                    leax      >Text_004,pc ; form the address >Text_004,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $04,s     ; adjust the system stack pointer
                    ldd       >$01B2,y  ; load d from >$01B2,y
                    pshs      d         ; save d on the stack
                    lbsr      Routine_005 ; call subroutine Routine_005
                    leas      $02,s     ; adjust the system stack pointer
Branch_022          leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      Routine_011 ; call subroutine Routine_011
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
                    lbsr      Routine_012 ; call subroutine Routine_012
                    leas      $06,s     ; adjust the system stack pointer
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      Routine_011 ; call subroutine Routine_011
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
                    lbsr      Routine_012 ; call subroutine Routine_012
                    leas      $06,s     ; adjust the system stack pointer
                    leax      >Data_002,pc ; form the address >Data_002,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_013 ; call subroutine Routine_013
                    leas      $02,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      Routine_014 ; call subroutine Routine_014
                    leas      $02,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      Routine_015 ; call subroutine Routine_015
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >Text_005,pc ; form the address >Text_005,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >Text_006,pc ; form the address >Text_006,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >Text_007,pc ; form the address >Text_007,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      Routine_016 ; call subroutine Routine_016
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >Data_003,pc ; form the address >Data_003,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >Text_008,pc ; form the address >Text_008,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >Text_009,pc ; form the address >Text_009,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    lbra      Branch_023 ; continue execution at Branch_023
Branch_024          ldd       #10       ; set d to the constant 10
                    pshs      d         ; save d on the stack
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    lbsr      Routine_017 ; call subroutine Routine_017
                    leas      $04,s     ; adjust the system stack pointer
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    lbsr      Routine_018 ; call subroutine Routine_018
                    leas      $02,s     ; adjust the system stack pointer
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    beq       Branch_025 ; branch when the values are equal or the result is zero; target Branch_025
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      $02,s     ; form the address $02,s in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    lbsr      Routine_019 ; call subroutine Routine_019
                    leas      $06,s     ; adjust the system stack pointer
                    ldb       ,s        ; load b from the current stack frame at ,s
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    bsr       Routine_020 ; call subroutine Routine_020
                    std       ,s++      ; store d in the current stack frame at ,s++
                    beq       Branch_026 ; branch when the values are equal or the result is zero; target Branch_026
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      $02,s     ; form the address $02,s in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    lbsr      Routine_021 ; call subroutine Routine_021
                    leas      $06,s     ; adjust the system stack pointer
Branch_026          bra       Branch_024 ; continue execution at Branch_024
Branch_025          ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_022 ; call subroutine Routine_022
Branch_023          leas      $02,s     ; adjust the system stack pointer
                    lbra      Branch_024 ; continue execution at Branch_024
Routine_020         pshs      u         ; save u on the stack
                    ldd       #-74      ; set d to the constant -74
                    lbsr      Routine_006 ; call subroutine Routine_006
                    ldb       $05,s     ; load b from the current stack frame at $05,s
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; copy the register values specified by d,x
                    lbra      Branch_027 ; continue execution at Branch_027
Branch_028          ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    lbsr      Routine_023 ; call subroutine Routine_023
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      Routine_011 ; call subroutine Routine_011
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
                    lbsr      Routine_012 ; call subroutine Routine_012
                    leas      $06,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      Routine_014 ; call subroutine Routine_014
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >Text_010,pc ; form the address >Text_010,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >Data_004,pc ; form the address >Data_004,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >Data_005,pc ; form the address >Data_005,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >Text_011,pc ; form the address >Text_011,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >Text_012,pc ; form the address >Text_012,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >Data_006,pc ; form the address >Data_006,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      Routine_005 ; call subroutine Routine_005
                    leas      $02,s     ; adjust the system stack pointer
                    bra       Branch_029 ; continue execution at Branch_029
Branch_030          bsr       Code_001  ; call subroutine Code_001
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    puls      pc,u      ; restore pc,u and return to the caller
Branch_031          ldd       #1        ; set d to the constant 1
                    puls      pc,u      ; restore pc,u and return to the caller
Branch_027          cmpx      #-8       ; compare x with #-8 and set the condition codes
                    lbeq      Branch_028 ; branch when the values are equal or the result is zero; target Branch_028
                    cmpx      #-12      ; compare x with #-12 and set the condition codes
                    beq       Branch_030 ; branch when the values are equal or the result is zero; target Branch_030
                    bra       Branch_031 ; continue execution at Branch_031
Branch_029          puls      pc,u      ; restore pc,u and return to the caller
Code_001            pshs      u         ; save u on the stack
                    ldd       #-75      ; set d to the constant -75
                    lbsr      Routine_006 ; call subroutine Routine_006
                    leas      -$01,s    ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      Routine_014 ; call subroutine Routine_014
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >Text_013,pc ; form the address >Text_013,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >$0020,y  ; form the address >$0020,y in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_024 ; call subroutine Routine_024
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      $02,s     ; form the address $02,s in x
                    pshs      x         ; save x on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      Routine_019 ; call subroutine Routine_019
                    leas      $06,s     ; adjust the system stack pointer
                    leax      >Data_007,pc ; form the address >Data_007,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    ldb       ,s        ; load b from the current stack frame at ,s
                    clra                ; clear a to zero and set the condition codes
                    andb      #223      ; mask b using #223
                    stb       ,s        ; store b in the current stack frame at ,s
                    cmpb      #82       ; compare b with #82 and set the condition codes
                    bne       Branch_032 ; branch when the values differ or the result is nonzero; target Branch_032
                    lbsr      Routine_025 ; call subroutine Routine_025
Branch_032          leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      Routine_011 ; call subroutine Routine_011
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
                    lbsr      Routine_012 ; call subroutine Routine_012
                    leas      $06,s     ; adjust the system stack pointer
                    ldb       ,s        ; load b from the current stack frame at ,s
                    cmpb      #83       ; compare b with #83 and set the condition codes
                    bne       Branch_033 ; branch when the values differ or the result is nonzero; target Branch_033
                    bsr       Routine_026 ; call subroutine Routine_026
Branch_033          leas      $01,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_026         pshs      u         ; save u on the stack
                    ldd       #-283     ; set d to the constant -283
                    lbsr      Routine_006 ; call subroutine Routine_006
                    leas      >$FF31,s  ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    std       ,s        ; store d in the current stack frame at ,s
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    lbsr      Routine_027 ; call subroutine Routine_027
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      Routine_011 ; call subroutine Routine_011
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
                    lbsr      Routine_012 ; call subroutine Routine_012
                    leas      $06,s     ; adjust the system stack pointer
                    leax      >Text_014,pc ; form the address >Text_014,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >$0013,y  ; form the address >$0013,y in x
                    pshs      x         ; save x on the stack
                    ldd       #200      ; set d to the constant 200
                    pshs      d         ; save d on the stack
                    leax      $0B,s     ; form the address $0B,s in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_028 ; call subroutine Routine_028
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
                    lbsr      Routine_012 ; call subroutine Routine_012
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      $09,s     ; form the address $09,s in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_008 ; call subroutine Routine_008
                    leas      $04,s     ; adjust the system stack pointer
                    std       $04,s     ; store d in the current stack frame at $04,s
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    bne       Branch_034 ; branch when the values differ or the result is nonzero; target Branch_034
                    ldd       >$01B2,y  ; load d from >$01B2,y
                    pshs      d         ; save d on the stack
                    leax      >Text_015,pc ; form the address >Text_015,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $04,s     ; adjust the system stack pointer
                    lbra      Branch_035 ; continue execution at Branch_035
Branch_034          leax      >Text_016,pc ; form the address >Text_016,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >Text_017,pc ; form the address >Text_017,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      Routine_011 ; call subroutine Routine_011
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
                    lbsr      Routine_012 ; call subroutine Routine_012
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
                    lbsr      Routine_019 ; call subroutine Routine_019
                    leas      $06,s     ; adjust the system stack pointer
                    leax      >$01DB,y  ; form the address >$01DB,y in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_029 ; call subroutine Routine_029
                    leas      $02,s     ; adjust the system stack pointer
                    stb       >$025B,y  ; store b at >$025B,y
                    ldd       ,s        ; load d from the current stack frame at ,s
                    pshs      d         ; save d on the stack
                    leax      >Data_008,pc ; form the address >Data_008,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $04,s     ; adjust the system stack pointer
                    leax      >$0020,y  ; form the address >$0020,y in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_024 ; call subroutine Routine_024
                    leas      $02,s     ; adjust the system stack pointer
                    lbra      Branch_036 ; continue execution at Branch_036
Branch_037          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      Routine_030 ; call subroutine Routine_030
                    leas      $02,s     ; adjust the system stack pointer
                    cmpd      #-15      ; compare d with #-15 and set the condition codes
                    bne       Branch_036 ; branch when the values differ or the result is nonzero; target Branch_036
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      Routine_011 ; call subroutine Routine_011
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
                    lbsr      Routine_012 ; call subroutine Routine_012
                    leas      $06,s     ; adjust the system stack pointer
                    leax      >Text_018,pc ; form the address >Text_018,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      >$0005,y  ; form the address >$0005,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    lbsr      Routine_021 ; call subroutine Routine_021
                    leas      $06,s     ; adjust the system stack pointer
                    lbra      Branch_035 ; continue execution at Branch_035
Branch_036          leax      $06,s     ; form the address $06,s in x
                    pshs      x         ; save x on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    lbsr      Routine_031 ; call subroutine Routine_031
                    leas      $08,s     ; adjust the system stack pointer
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    lbeq      Branch_037 ; branch when the values are equal or the result is zero; target Branch_037
                    ldb       $06,s     ; load b from the current stack frame at $06,s
                    cmpb      #21       ; compare b with #21 and set the condition codes
                    bne       Branch_038 ; branch when the values differ or the result is nonzero; target Branch_038
                    ldd       #132      ; set d to the constant 132
                    pshs      d         ; save d on the stack
                    leax      >$01D8,y  ; form the address >$01D8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    lbsr      Routine_021 ; call subroutine Routine_021
                    leas      $06,s     ; adjust the system stack pointer
Branch_038          ldb       $06,s     ; load b from the current stack frame at $06,s
                    cmpb      #24       ; compare b with #24 and set the condition codes
                    bne       Branch_039 ; branch when the values differ or the result is nonzero; target Branch_039
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      Routine_011 ; call subroutine Routine_011
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
                    lbsr      Routine_012 ; call subroutine Routine_012
                    leas      $06,s     ; adjust the system stack pointer
                    leax      >Text_019,pc ; form the address >Text_019,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    pshs      d         ; save d on the stack
                    lbsr      Routine_023 ; call subroutine Routine_023
                    lbra      Branch_040 ; continue execution at Branch_040
Branch_039          ldb       $06,s     ; load b from the current stack frame at $06,s
                    cmpb      #6        ; compare b with #6 and set the condition codes
                    lbne      Branch_036 ; branch when the values differ or the result is nonzero; target Branch_036
                    ldb       >$01D9,y  ; load b from >$01D9,y
                    addd      #1        ; add to d using #1
                    stb       >$01D9,y  ; store b at >$01D9,y
                    sex                 ; sign-extend b into d
                    coma                ; complement every bit in a
                    comb                ; complement every bit in b
                    stb       >$01DA,y  ; store b at >$01DA,y
                    ldd       ,s        ; load d from the current stack frame at ,s
                    addd      #1        ; add to d using #1
                    std       ,s        ; store d in the current stack frame at ,s
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    bra       Branch_041 ; continue execution at Branch_041
Branch_042          ldd       $02,s     ; load d from the current stack frame at $02,s
                    leax      >$01DB,y  ; form the address >$01DB,y in x
                    leax      d,x       ; form the address d,x in x
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       ,x        ; store b at ,x
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    addd      #1        ; add to d using #1
Branch_041          std       $02,s     ; store d in the current stack frame at $02,s
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    cmpd      #127      ; compare d with #127 and set the condition codes
                    ble       Branch_042 ; branch when the signed value is less than or equal; target Branch_042
                    ldd       #128      ; set d to the constant 128
                    pshs      d         ; save d on the stack
                    leax      >$01DB,y  ; form the address >$01DB,y in x
                    pshs      x         ; save x on the stack
                    ldd       $08,s     ; load d from the current stack frame at $08,s
                    pshs      d         ; save d on the stack
                    lbsr      Routine_019 ; call subroutine Routine_019
                    leas      $06,s     ; adjust the system stack pointer
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    lbne      Branch_043 ; branch when the values differ or the result is nonzero; target Branch_043
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      >$0003,y  ; form the address >$0003,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    lbsr      Routine_021 ; call subroutine Routine_021
                    leas      $06,s     ; adjust the system stack pointer
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      Routine_011 ; call subroutine Routine_011
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
                    lbsr      Routine_012 ; call subroutine Routine_012
                    leas      $06,s     ; adjust the system stack pointer
                    leax      >Text_020,pc ; form the address >Text_020,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    pshs      d         ; save d on the stack
                    lbsr      Routine_023 ; call subroutine Routine_023
                    leas      $02,s     ; adjust the system stack pointer
                    lbra      Branch_044 ; continue execution at Branch_044
Branch_043          leax      >$01DB,y  ; form the address >$01DB,y in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_029 ; call subroutine Routine_029
                    leas      $02,s     ; adjust the system stack pointer
                    stb       >$025B,y  ; store b at >$025B,y
                    ldd       ,s        ; load d from the current stack frame at ,s
                    pshs      d         ; save d on the stack
                    leax      >Data_009,pc ; form the address >Data_009,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $04,s     ; adjust the system stack pointer
                    leax      >$0020,y  ; form the address >$0020,y in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_024 ; call subroutine Routine_024
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #132      ; set d to the constant 132
                    pshs      d         ; save d on the stack
                    leax      >$01D8,y  ; form the address >$01D8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    lbsr      Routine_021 ; call subroutine Routine_021
                    leas      $06,s     ; adjust the system stack pointer
                    lbra      Branch_036 ; continue execution at Branch_036
Routine_025         pshs      u         ; save u on the stack
                    ldd       #-283     ; set d to the constant -283
                    lbsr      Routine_006 ; call subroutine Routine_006
                    leas      >$FF31,s  ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    stb       $06,s     ; store b in the current stack frame at $06,s
                    ldd       #1        ; set d to the constant 1
                    std       $04,s     ; store d in the current stack frame at $04,s
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    lbsr      Routine_027 ; call subroutine Routine_027
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      Routine_011 ; call subroutine Routine_011
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
                    lbsr      Routine_012 ; call subroutine Routine_012
                    leas      $06,s     ; adjust the system stack pointer
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      Routine_011 ; call subroutine Routine_011
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
                    lbsr      Routine_012 ; call subroutine Routine_012
                    leas      $06,s     ; adjust the system stack pointer
                    leax      >Text_021,pc ; form the address >Text_021,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >$0013,y  ; form the address >$0013,y in x
                    pshs      x         ; save x on the stack
                    ldd       #200      ; set d to the constant 200
                    pshs      d         ; save d on the stack
                    leax      $0B,s     ; form the address $0B,s in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_028 ; call subroutine Routine_028
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
                    lbsr      Routine_012 ; call subroutine Routine_012
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      $09,s     ; form the address $09,s in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_032 ; call subroutine Routine_032
                    leas      $04,s     ; adjust the system stack pointer
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    beq       Branch_045 ; branch when the values are equal or the result is zero; target Branch_045
                    leax      >Text_022,pc ; form the address >Text_022,pc in x
                    lbra      Branch_046 ; continue execution at Branch_046
Branch_045          ldd       #2        ; set d to the constant 2
                    pshs      d         ; save d on the stack
                    leax      $09,s     ; form the address $09,s in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_033 ; call subroutine Routine_033
                    leas      $04,s     ; adjust the system stack pointer
                    std       $02,s     ; store d in the current stack frame at $02,s
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    bne       Branch_047 ; branch when the values differ or the result is nonzero; target Branch_047
                    ldd       >$01B2,y  ; load d from >$01B2,y
                    pshs      d         ; save d on the stack
                    leax      >Text_023,pc ; form the address >Text_023,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $04,s     ; adjust the system stack pointer
                    lbra      Branch_035 ; continue execution at Branch_035
Branch_047          leax      >Text_024,pc ; form the address >Text_024,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >Text_025,pc ; form the address >Text_025,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      Routine_011 ; call subroutine Routine_011
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
                    lbsr      Routine_012 ; call subroutine Routine_012
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      >$0004,y  ; form the address >$0004,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    lbsr      Routine_021 ; call subroutine Routine_021
                    leas      $06,s     ; adjust the system stack pointer
                    lbra      Branch_048 ; continue execution at Branch_048
Code_002            clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      Routine_030 ; call subroutine Routine_030
                    leas      $02,s     ; adjust the system stack pointer
                    cmpd      #-15      ; compare d with #-15 and set the condition codes
                    bne       Branch_049 ; branch when the values differ or the result is nonzero; target Branch_049
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      >$0005,y  ; form the address >$0005,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    lbsr      Routine_021 ; call subroutine Routine_021
                    leas      $06,s     ; adjust the system stack pointer
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      Routine_011 ; call subroutine Routine_011
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
                    lbsr      Routine_012 ; call subroutine Routine_012
                    leas      $06,s     ; adjust the system stack pointer
                    leax      >Data_010,pc ; form the address >Data_010,pc in x
Branch_046          pshs      x         ; save x on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    lbra      Branch_040 ; continue execution at Branch_040
Branch_049          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       >$01D8,y  ; store b at >$01D8,y
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       ,s        ; store d in the current stack frame at ,s
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    pshs      d         ; save d on the stack
                    leax      >Data_011,pc ; form the address >Data_011,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $04,s     ; adjust the system stack pointer
                    leax      >$0020,y  ; form the address >$0020,y in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_024 ; call subroutine Routine_024
                    leas      $02,s     ; adjust the system stack pointer
                    lbra      Branch_050 ; continue execution at Branch_050
Branch_051          leax      >$01D8,y  ; form the address >$01D8,y in x
                    pshs      x         ; save x on the stack
                    ldd       #10       ; set d to the constant 10
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    lbsr      Routine_031 ; call subroutine Routine_031
                    leas      $08,s     ; adjust the system stack pointer
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    bne       Branch_052 ; branch when the values differ or the result is nonzero; target Branch_052
                    leax      >Text_026,pc ; form the address >Text_026,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      >$0004,y  ; form the address >$0004,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    lbsr      Routine_021 ; call subroutine Routine_021
                    leas      $06,s     ; adjust the system stack pointer
Branch_052          ldb       >$01D8,y  ; load b from >$01D8,y
                    cmpb      #4        ; compare b with #4 and set the condition codes
                    lbne      Branch_053 ; branch when the values differ or the result is nonzero; target Branch_053
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      >$0002,y  ; form the address >$0002,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    lbsr      Routine_021 ; call subroutine Routine_021
                    leas      $06,s     ; adjust the system stack pointer
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      Routine_011 ; call subroutine Routine_011
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
                    lbsr      Routine_012 ; call subroutine Routine_012
                    leas      $06,s     ; adjust the system stack pointer
                    leax      >Text_027,pc ; form the address >Text_027,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    lbsr      Routine_023 ; call subroutine Routine_023
                    leas      $02,s     ; adjust the system stack pointer
Branch_044          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    lbra      Branch_054 ; continue execution at Branch_054
Branch_053          ldd       ,s        ; load d from the current stack frame at ,s
                    addd      #1        ; add to d using #1
                    std       ,s        ; store d in the current stack frame at ,s
                    subd      #1        ; subtract from d using #1
                    cmpd      #10       ; compare d with #10 and set the condition codes
                    lble      Branch_055 ; branch when the signed value is less than or equal; target Branch_055
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      Routine_011 ; call subroutine Routine_011
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
                    lbsr      Routine_012 ; call subroutine Routine_012
                    leas      $06,s     ; adjust the system stack pointer
                    leax      >Text_028,pc ; form the address >Text_028,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      >$0005,y  ; form the address >$0005,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    lbsr      Routine_021 ; call subroutine Routine_021
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    lbsr      Routine_023 ; call subroutine Routine_023
                    leas      $02,s     ; adjust the system stack pointer
                    leax      $07,s     ; form the address $07,s in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_034 ; call subroutine Routine_034
Branch_040          leas      $02,s     ; adjust the system stack pointer
                    lbra      Branch_035 ; continue execution at Branch_035
Branch_055          ldb       >$01D8,y  ; load b from >$01D8,y
                    cmpb      #24       ; compare b with #24 and set the condition codes
                    bne       Branch_050 ; branch when the values differ or the result is nonzero; target Branch_050
                    leax      >Text_029,pc ; form the address >Text_029,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    lbsr      Routine_023 ; call subroutine Routine_023
                    leas      $02,s     ; adjust the system stack pointer
                    leax      $07,s     ; form the address $07,s in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_034 ; call subroutine Routine_034
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      Routine_011 ; call subroutine Routine_011
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
                    lbsr      Routine_012 ; call subroutine Routine_012
                    leas      $06,s     ; adjust the system stack pointer
Branch_035          ldd       #-1       ; set d to the constant -1
                    lbra      Branch_054 ; continue execution at Branch_054
Branch_050          ldb       >$01D8,y  ; load b from >$01D8,y
                    cmpb      #1        ; compare b with #1 and set the condition codes
                    lbne      Branch_051 ; branch when the values differ or the result is nonzero; target Branch_051
                    leax      >$01D9,y  ; form the address >$01D9,y in x
                    pshs      x         ; save x on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    ldd       #131      ; set d to the constant 131
                    pshs      d         ; save d on the stack
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    lbsr      Routine_031 ; call subroutine Routine_031
                    leas      $08,s     ; adjust the system stack pointer
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    bne       Branch_056 ; branch when the values differ or the result is nonzero; target Branch_056
                    ldd       >$01B2,y  ; load d from >$01B2,y
                    pshs      d         ; save d on the stack
                    leax      >Text_030,pc ; form the address >Text_030,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $04,s     ; adjust the system stack pointer
Branch_057          ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      >$0004,y  ; form the address >$0004,y in x
                    lbra      Branch_058 ; continue execution at Branch_058
Branch_056          ldb       >$01D9,y  ; load b from >$01D9,y
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    ldb       >$01DA,y  ; load b from >$01DA,y
                    sex                 ; sign-extend b into d
                    coma                ; complement every bit in a
                    comb                ; complement every bit in b
                    cmpd      ,s++      ; compare d with ,s++ and set the condition codes
                    beq       Branch_059 ; branch when the values are equal or the result is zero; target Branch_059
                    leax      >Text_031,pc ; form the address >Text_031,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    bra       Branch_057 ; continue execution at Branch_057
Branch_059          ldb       >$01D9,y  ; load b from >$01D9,y
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
                    cmpd      ,s++      ; compare d with ,s++ and set the condition codes
                    beq       Branch_060 ; branch when the values are equal or the result is zero; target Branch_060
                    leax      >Text_032,pc ; form the address >Text_032,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    lbra      Branch_057 ; continue execution at Branch_057
Branch_060          leax      >$01DB,y  ; form the address >$01DB,y in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_029 ; call subroutine Routine_029
                    leas      $02,s     ; adjust the system stack pointer
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    ldb       >$025B,y  ; load b from >$025B,y
                    sex                 ; sign-extend b into d
                    cmpd      ,s++      ; compare d with ,s++ and set the condition codes
                    beq       Branch_061 ; branch when the values are equal or the result is zero; target Branch_061
                    ldb       >$025B,y  ; load b from >$025B,y
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    leax      >$01DB,y  ; form the address >$01DB,y in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_029 ; call subroutine Routine_029
                    leas      $02,s     ; adjust the system stack pointer
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    leax      >Text_033,pc ; form the address >Text_033,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $06,s     ; adjust the system stack pointer
                    lbra      Branch_057 ; continue execution at Branch_057
Branch_061          ldd       #128      ; set d to the constant 128
                    pshs      d         ; save d on the stack
                    leax      >$01DB,y  ; form the address >$01DB,y in x
                    pshs      x         ; save x on the stack
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    lbsr      Routine_021 ; call subroutine Routine_021
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
Branch_058          pshs      x         ; save x on the stack
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    lbsr      Routine_021 ; call subroutine Routine_021
                    leas      $06,s     ; adjust the system stack pointer
Branch_048          lbra      Code_002  ; continue execution at Code_002
Branch_054          leas      >$00CF,s  ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_031         pshs      u         ; save u on the stack
                    ldd       #-78      ; set d to the constant -78
                    lbsr      Routine_006 ; call subroutine Routine_006
                    leas      -$04,s    ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       ,s        ; store d in the current stack frame at ,s
                    bra       Branch_062 ; continue execution at Branch_062
Branch_062          ldd       $08,s     ; load d from the current stack frame at $08,s
                    pshs      d         ; save d on the stack
                    lbsr      Routine_018 ; call subroutine Routine_018
                    leas      $02,s     ; adjust the system stack pointer
                    std       $02,s     ; store d in the current stack frame at $02,s
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    bne       Branch_063 ; branch when the values differ or the result is nonzero; target Branch_063
                    ldd       ,s        ; load d from the current stack frame at ,s
                    addd      #1        ; add to d using #1
                    std       ,s        ; store d in the current stack frame at ,s
                    subd      #1        ; subtract from d using #1
                    cmpd      #60       ; compare d with #60 and set the condition codes
                    ble       Branch_064 ; branch when the signed value is less than or equal; target Branch_064
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       ,s        ; store d in the current stack frame at ,s
                    ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    addd      #-1       ; add to d using #-1
                    std       $0C,s     ; store d in the current stack frame at $0C,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       Branch_065 ; branch when the signed value is greater; target Branch_065
                    ldd       #-1       ; set d to the constant -1
                    bra       Branch_066 ; continue execution at Branch_066
                    fcb       $20       ; store byte data
                    fcb       $0A       ; store byte data
Branch_064          ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_022 ; call subroutine Routine_022
                    leas      $02,s     ; adjust the system stack pointer
Branch_065          bra       Branch_062 ; continue execution at Branch_062
Branch_063          ldd       $02,s     ; load d from the current stack frame at $02,s
                    cmpd      $0A,s     ; compare d with $0A,s and set the condition codes
                    bge       Branch_067 ; branch when the signed value is greater than or equal; target Branch_067
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    ldd       <$0010,s  ; load d from the current stack frame at <$0010,s
                    pshs      d         ; save d on the stack
                    ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    pshs      d         ; save d on the stack
                    lbsr      Routine_019 ; call subroutine Routine_019
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       $0E,s     ; load d from the current stack frame at $0E,s
                    addd      $02,s     ; add to d using $02,s
                    std       $0E,s     ; store d in the current stack frame at $0E,s
                    ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    subd      $02,s     ; subtract from d using $02,s
                    std       $0A,s     ; store d in the current stack frame at $0A,s
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       ,s        ; store d in the current stack frame at ,s
                    lbra      Branch_062 ; continue execution at Branch_062
Branch_067          ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    pshs      d         ; save d on the stack
                    ldd       <$0010,s  ; load d from the current stack frame at <$0010,s
                    pshs      d         ; save d on the stack
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    lbsr      Routine_019 ; call subroutine Routine_019
                    leas      $06,s     ; adjust the system stack pointer
Branch_066          leas      $04,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_029         pshs      u         ; save u on the stack
                    ldd       #-69      ; set d to the constant -69
                    lbsr      Routine_006 ; call subroutine Routine_006
                    leas      -$03,s    ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       $02,s     ; store b in the current stack frame at $02,s
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    bra       Branch_068 ; continue execution at Branch_068
Branch_069          ldb       $02,s     ; load b from the current stack frame at $02,s
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    ldx       $09,s     ; load x from the current stack frame at $09,s
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    leax      d,x       ; form the address d,x in x
                    ldb       ,x        ; load b from ,x
                    sex                 ; sign-extend b into d
                    addd      ,s++      ; add to d using ,s++
                    stb       $02,s     ; store b in the current stack frame at $02,s
                    ldd       ,s        ; load d from the current stack frame at ,s
                    addd      #1        ; add to d using #1
Branch_068          std       ,s        ; store d in the current stack frame at ,s
                    ldd       ,s        ; load d from the current stack frame at ,s
                    cmpd      #127      ; compare d with #127 and set the condition codes
                    ble       Branch_069 ; branch when the signed value is less than or equal; target Branch_069
                    ldb       $02,s     ; load b from the current stack frame at $02,s
                    leas      $03,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_009         pshs      u         ; save u on the stack
                    ldd       #-74      ; set d to the constant -74
                    lbsr      Routine_006 ; call subroutine Routine_006
                    ldd       >$01B6,y  ; load d from >$01B6,y
                    pshs      d         ; save d on the stack
                    lbsr      Routine_023 ; call subroutine Routine_023
                    leas      $02,s     ; adjust the system stack pointer
                    leax      >$01B8,y  ; form the address >$01B8,y in x
                    pshs      x         ; save x on the stack
                    ldd       >$01B4,y  ; load d from >$01B4,y
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      Routine_011 ; call subroutine Routine_011
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
                    lbsr      Routine_012 ; call subroutine Routine_012
                    leas      $06,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      Routine_014 ; call subroutine Routine_014
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    pshs      d         ; save d on the stack
                    leax      >Data_012,pc ; form the address >Data_012,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $04,s     ; adjust the system stack pointer
                    leax      >Text_034,pc ; form the address >Text_034,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    lbsr      Routine_005 ; call subroutine Routine_005
                    bra       Branch_070 ; continue execution at Branch_070
Routine_030         pshs      u         ; save u on the stack
                    ldd       #-76      ; set d to the constant -76
                    lbsr      Routine_006 ; call subroutine Routine_006
                    leas      -$02,s    ; adjust the system stack pointer
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    lbsr      Routine_011 ; call subroutine Routine_011
                    leas      $04,s     ; adjust the system stack pointer
                    stb       $01,s     ; store b in the current stack frame at $01,s
                    bne       Branch_071 ; branch when the values differ or the result is nonzero; target Branch_071
                    ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      $02,s     ; form the address $02,s in x
                    pshs      x         ; save x on the stack
                    ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    pshs      d         ; save d on the stack
                    lbsr      Routine_019 ; call subroutine Routine_019
                    leas      $06,s     ; adjust the system stack pointer
                    bra       Branch_072 ; continue execution at Branch_072
Branch_071          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       ,s        ; store b in the current stack frame at ,s
Branch_072          ldb       ,s        ; load b from the current stack frame at ,s
                    sex                 ; sign-extend b into d
Branch_070          leas      $02,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
Text_002            fcc       "/t2" ; store literal character data
                    fcb       $00       ; store byte data
Text_003            fcc       "Cannot open /t2" ; store literal character data
                    fcb       $00       ; store byte data
Text_004            fcc       "Cannot open %s" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Text_005            fcc       "Quik terminal Version 1.00    " ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Text_006            fcc       "By Alpha Software Technologies" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Text_007            fcc       "Released for shareware, 1988  " ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Data_003            fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Text_008            fcc       "Press <ALT><X> to exit          <ALT><T> to transfer files" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Text_009            fcc       "----------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Text_010            fcc       "Quik terminal...exited" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Data_004            fcb       $0D       ; store byte data
                    fcc       "For a free catalog please write to:" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Data_005            fcb       $0D       ; store byte data
                    fcc       "Alpha Software Technologies" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Text_011            fcc       "2810 Buffon St." ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Text_012            fcc       "Chalmette, La. 70043" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Data_006            fcb       $0D       ; store byte data
                    fcc       "or leave mail for 'ALPHASOFT' on DELPHI" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Text_013            fcc       "[R]ecieve or [S]end a file:" ; store literal character data
                    fcb       $00       ; store byte data
Data_007            fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Text_014            fcc       "Enter filename to send:" ; store literal character data
                    fcb       $00       ; store byte data
Text_015            fcc       "Cannot open file, error %d" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Text_016            fcc       "Sending file                    press <ALT><Q> to abort" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Text_017            fcc       "----------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Data_008            fcb       $0D       ; store byte data
                    fcc       "Sending block #%05u " ; store literal character data
                    fcb       $00       ; store byte data
Text_018            fcc       "File transfer aborted!" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Text_019            fcc       "File transfer aborted!" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Text_020            fcc       "File transfer complete." ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Data_009            fcb       $0D       ; store byte data
                    fcc       "Sending block #%05u " ; store literal character data
                    fcb       $00       ; store byte data
Text_021            fcc       "Enter filename to recieve:" ; store literal character data
                    fcb       $00       ; store byte data
Text_022            fcc       "File exists!" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Text_023            fcc       "Cannot open file, error %d" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Text_024            fcc       "Recieving file                  press <ALT><Q> to abort" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Text_025            fcc       "----------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Data_010            fcb       $0D       ; store byte data
                    fcc       "File transfer aborted!" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Data_011            fcb       $0D       ; store byte data
                    fcc       "Recieving block #%05u " ; store literal character data
                    fcb       $00       ; store byte data
Text_026            fcc       "Timeout/read error" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Text_027            fcc       "File receive successful." ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Text_028            fcc       "Too many errors...I give up!" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Text_029            fcc       "File transfer aborted!" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Text_030            fcc       "Timeout/read error %d!!" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Text_031            fcc       "Block # scrambled!" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Text_032            fcc       "Bad block #!" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Text_033            fcc       "Bad checksum! %d / %d" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Data_012            fcb       $25       ; store byte data
                    fcb       $73       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Text_034            fcc       "Stupid terminal...exited" ; store literal character data
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
Routine_028         pshs      u         ; save u on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    leas      -$04,s    ; adjust the system stack pointer
                    ldd       $08,s     ; load d from the current stack frame at $08,s
                    std       ,s        ; store d in the current stack frame at ,s
                    bra       Branch_073 ; continue execution at Branch_073
Branch_074          ldd       $02,s     ; load d from the current stack frame at $02,s
                    ldx       ,s        ; load x from the current stack frame at ,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       ,s        ; store x in the current stack frame at ,s
                    stb       -$01,x    ; store b at -$01,x
                    cmpb      #13       ; compare b with #13 and set the condition codes
                    beq       Branch_075 ; branch when the values are equal or the result is zero; target Branch_075
Branch_073          tfr       u,d       ; copy the register values specified by u,d
                    leau      -$01,u    ; form the workspace or data address -$01,u in u
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    ble       Branch_075 ; branch when the signed value is less than or equal; target Branch_075
                    ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    pshs      d         ; save d on the stack
                    lbsr      Routine_035 ; call subroutine Routine_035
                    leas      $02,s     ; adjust the system stack pointer
                    std       $02,s     ; store d in the current stack frame at $02,s
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    bne       Branch_074 ; branch when the values differ or the result is nonzero; target Branch_074
Branch_075          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       [,s]      ; store b in the current stack frame at [,s]
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    bne       Branch_076 ; branch when the values differ or the result is nonzero; target Branch_076
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    bra       Branch_077 ; continue execution at Branch_077
Branch_076          ldd       $08,s     ; load d from the current stack frame at $08,s
Branch_077          leas      $04,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_010         pshs      u         ; save u on the stack
                    leax      >$0020,y  ; form the address >$0020,y in x
                    stx       >$02DA,y  ; store x at >$02DA,y
                    leax      $06,s     ; form the address $06,s in x
                    pshs      x         ; save x on the stack
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    bra       Branch_078 ; continue execution at Branch_078
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
Branch_078          pshs      d         ; save d on the stack
                    leax      >Data_013,pc ; form the address >Data_013,pc in x
                    pshs      x         ; save x on the stack
                    bsr       Routine_036 ; call subroutine Routine_036
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
Routine_036         pshs      u         ; save u on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    leas      -$0B,s    ; adjust the system stack pointer
                    bra       Branch_079 ; continue execution at Branch_079
Branch_080          ldb       $08,s     ; load b from the current stack frame at $08,s
                    lbeq      Branch_081 ; branch when the values are equal or the result is zero; target Branch_081
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    jsr       [<$11,s]  ; call subroutine [<$11,s]
                    leas      $02,s     ; adjust the system stack pointer
Branch_079          ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    cmpb      #37       ; compare b with #37 and set the condition codes
                    bne       Branch_080 ; branch when the values differ or the result is nonzero; target Branch_080
                    ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       $02,s     ; store d in the current stack frame at $02,s
                    std       $06,s     ; store d in the current stack frame at $06,s
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    cmpb      #45       ; compare b with #45 and set the condition codes
                    bne       Branch_082 ; branch when the values differ or the result is nonzero; target Branch_082
                    ldd       #1        ; set d to the constant 1
                    std       >$02F0,y  ; store d at >$02F0,y
                    ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    bra       Branch_083 ; continue execution at Branch_083
Branch_082          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >$02F0,y  ; store d at >$02F0,y
Branch_083          ldb       $08,s     ; load b from the current stack frame at $08,s
                    cmpb      #48       ; compare b with #48 and set the condition codes
                    bne       Branch_084 ; branch when the values differ or the result is nonzero; target Branch_084
                    ldd       #48       ; set d to the constant 48
                    bra       Branch_085 ; continue execution at Branch_085
Branch_084          ldd       #32       ; set d to the constant 32
Branch_085          std       >$02F2,y  ; store d at >$02F2,y
                    bra       Branch_086 ; continue execution at Branch_086
Branch_087          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    lbsr      Routine_037 ; call subroutine Routine_037
                    pshs      d         ; save d on the stack
                    ldb       $0A,s     ; load b from the current stack frame at $0A,s
                    sex                 ; sign-extend b into d
                    addd      #-48      ; add to d using #-48
                    addd      ,s++      ; add to d using ,s++
                    std       $06,s     ; store d in the current stack frame at $06,s
                    ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
Branch_086          ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
                    leax      >$00E4,y  ; form the address >$00E4,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       ,x        ; load b from ,x
                    clra                ; clear a to zero and set the condition codes
                    andb      #8        ; mask b using #8
                    bne       Branch_087 ; branch when the values differ or the result is nonzero; target Branch_087
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    cmpb      #46       ; compare b with #46 and set the condition codes
                    bne       Branch_088 ; branch when the values differ or the result is nonzero; target Branch_088
                    ldd       #1        ; set d to the constant 1
                    std       $04,s     ; store d in the current stack frame at $04,s
                    bra       Branch_089 ; continue execution at Branch_089
Branch_090          ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    lbsr      Routine_037 ; call subroutine Routine_037
                    pshs      d         ; save d on the stack
                    ldb       $0A,s     ; load b from the current stack frame at $0A,s
                    sex                 ; sign-extend b into d
                    addd      #-48      ; add to d using #-48
                    addd      ,s++      ; add to d using ,s++
                    std       $02,s     ; store d in the current stack frame at $02,s
Branch_089          ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
                    leax      >$00E4,y  ; form the address >$00E4,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       ,x        ; load b from ,x
                    clra                ; clear a to zero and set the condition codes
                    andb      #8        ; mask b using #8
                    bne       Branch_090 ; branch when the values differ or the result is nonzero; target Branch_090
                    bra       Branch_091 ; continue execution at Branch_091
Branch_088          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       $04,s     ; store d in the current stack frame at $04,s
Branch_091          ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; copy the register values specified by d,x
                    lbra      Branch_092 ; continue execution at Branch_092
Branch_093          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldx       <$0015,s  ; load x from the current stack frame at <$0015,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0015,s  ; store x in the current stack frame at <$0015,s
                    ldd       -$02,x    ; load d from -$02,x
                    pshs      d         ; save d on the stack
                    lbsr      Routine_038 ; call subroutine Routine_038
                    bra       Branch_094 ; continue execution at Branch_094
Branch_095          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldx       <$0015,s  ; load x from the current stack frame at <$0015,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0015,s  ; store x in the current stack frame at <$0015,s
                    ldd       -$02,x    ; load d from -$02,x
                    pshs      d         ; save d on the stack
                    lbsr      Routine_039 ; call subroutine Routine_039
Branch_094          std       ,s        ; store d in the current stack frame at ,s
                    lbra      Branch_096 ; continue execution at Branch_096
Branch_097          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldb       $0A,s     ; load b from the current stack frame at $0A,s
                    sex                 ; sign-extend b into d
                    leax      >$00E4,y  ; form the address >$00E4,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       ,x        ; load b from ,x
                    clra                ; clear a to zero and set the condition codes
                    andb      #2        ; mask b using #2
                    pshs      d         ; save d on the stack
                    ldx       <$0017,s  ; load x from the current stack frame at <$0017,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0017,s  ; store x in the current stack frame at <$0017,s
                    ldd       -$02,x    ; load d from -$02,x
                    pshs      d         ; save d on the stack
                    lbsr      Routine_040 ; call subroutine Routine_040
                    lbra      Branch_098 ; continue execution at Branch_098
Branch_099          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldx       <$0015,s  ; load x from the current stack frame at <$0015,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0015,s  ; store x in the current stack frame at <$0015,s
                    ldd       -$02,x    ; load d from -$02,x
                    pshs      d         ; save d on the stack
                    leax      >$02DC,y  ; form the address >$02DC,y in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_041 ; call subroutine Routine_041
                    lbra      Branch_098 ; continue execution at Branch_098
Branch_100          ldd       $04,s     ; load d from the current stack frame at $04,s
                    bne       Branch_101 ; branch when the values differ or the result is nonzero; target Branch_101
                    ldd       #6        ; set d to the constant 6
                    std       $02,s     ; store d in the current stack frame at $02,s
Branch_101          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    leax      <$0015,s  ; form the address <$0015,s in x
                    pshs      x         ; save x on the stack
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldb       $0E,s     ; load b from the current stack frame at $0E,s
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    lbsr      Routine_042 ; call subroutine Routine_042
                    leas      $06,s     ; adjust the system stack pointer
                    lbra      Branch_102 ; continue execution at Branch_102
Branch_103          ldx       <$0013,s  ; load x from the current stack frame at <$0013,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0013,s  ; store x in the current stack frame at <$0013,s
                    ldd       -$02,x    ; load d from -$02,x
                    lbra      Branch_104 ; continue execution at Branch_104
Branch_105          ldx       <$0013,s  ; load x from the current stack frame at <$0013,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0013,s  ; store x in the current stack frame at <$0013,s
                    ldd       -$02,x    ; load d from -$02,x
                    std       $09,s     ; store d in the current stack frame at $09,s
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    beq       Branch_106 ; branch when the values are equal or the result is zero; target Branch_106
                    ldd       $09,s     ; load d from the current stack frame at $09,s
                    std       $04,s     ; store d in the current stack frame at $04,s
                    bra       Branch_107 ; continue execution at Branch_107
Branch_108          ldb       [<$09,s]  ; load b from the current stack frame at [<$09,s]
                    beq       Branch_109 ; branch when the values are equal or the result is zero; target Branch_109
                    ldd       $09,s     ; load d from the current stack frame at $09,s
                    addd      #1        ; add to d using #1
                    std       $09,s     ; store d in the current stack frame at $09,s
Branch_107          ldd       $02,s     ; load d from the current stack frame at $02,s
                    addd      #-1       ; add to d using #-1
                    std       $02,s     ; store d in the current stack frame at $02,s
                    subd      #-1       ; subtract from d using #-1
                    bne       Branch_108 ; branch when the values differ or the result is nonzero; target Branch_108
Branch_109          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       $0B,s     ; load d from the current stack frame at $0B,s
                    subd      $06,s     ; subtract from d using $06,s
                    pshs      d         ; save d on the stack
                    ldd       $08,s     ; load d from the current stack frame at $08,s
                    pshs      d         ; save d on the stack
                    ldd       <$0015,s  ; load d from the current stack frame at <$0015,s
                    pshs      d         ; save d on the stack
                    lbsr      Routine_043 ; call subroutine Routine_043
                    leas      $08,s     ; adjust the system stack pointer
                    bra       Branch_110 ; continue execution at Branch_110
Branch_106          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       $0B,s     ; load d from the current stack frame at $0B,s
                    bra       Branch_102 ; continue execution at Branch_102
Branch_111          ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    bra       Branch_112 ; continue execution at Branch_112
                    fcb       $32       ; store byte data
                    fcb       $15       ; store byte data
Branch_112          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    leax      <$0015,s  ; form the address <$0015,s in x
                    pshs      x         ; save x on the stack
                    ldb       $0C,s     ; load b from the current stack frame at $0C,s
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    lbsr      Routine_044 ; call subroutine Routine_044
Branch_098          leas      $04,s     ; adjust the system stack pointer
Branch_102          pshs      d         ; save d on the stack
Branch_096          ldd       <$0013,s  ; load d from the current stack frame at <$0013,s
                    pshs      d         ; save d on the stack
                    lbsr      Routine_045 ; call subroutine Routine_045
                    leas      $06,s     ; adjust the system stack pointer
Branch_110          lbra      Branch_079 ; continue execution at Branch_079
Branch_113          ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
Branch_104          pshs      d         ; save d on the stack
                    jsr       [<$11,s]  ; call subroutine [<$11,s]
                    leas      $02,s     ; adjust the system stack pointer
                    lbra      Branch_079 ; continue execution at Branch_079
Branch_092          cmpx      #100      ; compare x with #100 and set the condition codes
                    lbeq      Branch_093 ; branch when the values are equal or the result is zero; target Branch_093
                    cmpx      #111      ; compare x with #111 and set the condition codes
                    lbeq      Branch_095 ; branch when the values are equal or the result is zero; target Branch_095
                    cmpx      #120      ; compare x with #120 and set the condition codes
                    lbeq      Branch_097 ; branch when the values are equal or the result is zero; target Branch_097
                    cmpx      #88       ; compare x with #88 and set the condition codes
                    lbeq      Branch_097 ; branch when the values are equal or the result is zero; target Branch_097
                    cmpx      #117      ; compare x with #117 and set the condition codes
                    lbeq      Branch_099 ; branch when the values are equal or the result is zero; target Branch_099
                    cmpx      #102      ; compare x with #102 and set the condition codes
                    lbeq      Branch_100 ; branch when the values are equal or the result is zero; target Branch_100
                    cmpx      #101      ; compare x with #101 and set the condition codes
                    lbeq      Branch_100 ; branch when the values are equal or the result is zero; target Branch_100
                    cmpx      #103      ; compare x with #103 and set the condition codes
                    lbeq      Branch_100 ; branch when the values are equal or the result is zero; target Branch_100
                    cmpx      #69       ; compare x with #69 and set the condition codes
                    lbeq      Branch_100 ; branch when the values are equal or the result is zero; target Branch_100
                    cmpx      #71       ; compare x with #71 and set the condition codes
                    lbeq      Branch_100 ; branch when the values are equal or the result is zero; target Branch_100
                    cmpx      #99       ; compare x with #99 and set the condition codes
                    lbeq      Branch_103 ; branch when the values are equal or the result is zero; target Branch_103
                    cmpx      #115      ; compare x with #115 and set the condition codes
                    lbeq      Branch_105 ; branch when the values are equal or the result is zero; target Branch_105
                    cmpx      #108      ; compare x with #108 and set the condition codes
                    lbeq      Branch_111 ; branch when the values are equal or the result is zero; target Branch_111
                    bra       Branch_113 ; continue execution at Branch_113
Branch_081          leas      $0B,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_038         pshs      u,d       ; save u,d on the stack
                    leax      >$02DC,y  ; form the address >$02DC,y in x
                    stx       ,s        ; store x in the current stack frame at ,s
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    bge       Branch_114 ; branch when the signed value is greater than or equal; target Branch_114
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    nega                ; negate a
                    negb                ; negate b
                    sbca      #0        ; subtract with borrow from a using #0
                    std       $06,s     ; store d in the current stack frame at $06,s
                    bge       Branch_115 ; branch when the signed value is greater than or equal; target Branch_115
                    leax      >Text_035,pc ; form the address >Text_035,pc in x
                    pshs      x         ; save x on the stack
                    leax      >$02DC,y  ; form the address >$02DC,y in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_046 ; call subroutine Routine_046
                    leas      $04,s     ; adjust the system stack pointer
                    lbra      Branch_116 ; continue execution at Branch_116
Branch_115          ldd       #45       ; set d to the constant 45
                    ldx       ,s        ; load x from the current stack frame at ,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       ,s        ; store x in the current stack frame at ,s
                    stb       -$01,x    ; store b at -$01,x
Branch_114          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    bsr       Routine_041 ; call subroutine Routine_041
                    leas      $04,s     ; adjust the system stack pointer
                    lbra      Branch_117 ; continue execution at Branch_117
Routine_041         pshs      u,y,x,d   ; save u,y,x,d on the stack
                    ldu       $0A,s     ; load u from the current stack frame at $0A,s
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       $02,s     ; store d in the current stack frame at $02,s
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       ,s        ; store d in the current stack frame at ,s
                    bra       Branch_118 ; continue execution at Branch_118
Branch_119          ldd       ,s        ; load d from the current stack frame at ,s
                    addd      #1        ; add to d using #1
                    std       ,s        ; store d in the current stack frame at ,s
                    ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    subd      >$0006,y  ; subtract from d using >$0006,y
                    std       $0C,s     ; store d in the current stack frame at $0C,s
Branch_118          ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    blt       Branch_119 ; branch when the signed value is less; target Branch_119
                    leax      >$0006,y  ; form the address >$0006,y in x
                    stx       $04,s     ; store x in the current stack frame at $04,s
                    bra       Branch_120 ; continue execution at Branch_120
Branch_121          ldd       ,s        ; load d from the current stack frame at ,s
                    addd      #1        ; add to d using #1
                    std       ,s        ; store d in the current stack frame at ,s
Branch_122          ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    subd      [<$04,s]  ; subtract from d using [<$04,s]
                    std       $0C,s     ; store d in the current stack frame at $0C,s
                    bge       Branch_121 ; branch when the signed value is greater than or equal; target Branch_121
                    ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    addd      [<$04,s]  ; add to d using [<$04,s]
                    std       $0C,s     ; store d in the current stack frame at $0C,s
                    ldd       ,s        ; load d from the current stack frame at ,s
                    beq       Branch_123 ; branch when the values are equal or the result is zero; target Branch_123
                    ldd       #1        ; set d to the constant 1
                    std       $02,s     ; store d in the current stack frame at $02,s
Branch_123          ldd       $02,s     ; load d from the current stack frame at $02,s
                    beq       Branch_124 ; branch when the values are equal or the result is zero; target Branch_124
                    ldd       ,s        ; load d from the current stack frame at ,s
                    addd      #48       ; add to d using #48
                    stb       ,u+       ; store b at ,u+
Branch_124          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       ,s        ; store d in the current stack frame at ,s
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    addd      #2        ; add to d using #2
                    std       $04,s     ; store d in the current stack frame at $04,s
Branch_120          ldd       $04,s     ; load d from the current stack frame at $04,s
                    cmpd      >$000E,y  ; compare d with >$000E,y and set the condition codes
                    bne       Branch_122 ; branch when the values differ or the result is nonzero; target Branch_122
                    ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    addd      #48       ; add to d using #48
                    stb       ,u+       ; store b at ,u+
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       WorkByte_001,u ; store b at WorkByte_001,u
                    ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    leas      $06,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_039         pshs      u,d       ; save u,d on the stack
                    leax      >$02DC,y  ; form the address >$02DC,y in x
                    stx       ,s        ; store x in the current stack frame at ,s
                    leau      >$02E6,y  ; form the workspace or data address >$02E6,y in u
Branch_125          ldd       $06,s     ; load d from the current stack frame at $06,s
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
                    bne       Branch_125 ; branch when the values differ or the result is nonzero; target Branch_125
                    bra       Branch_126 ; continue execution at Branch_126
Branch_127          ldb       WorkByte_001,u ; load b from WorkByte_001,u
                    ldx       ,s        ; load x from the current stack frame at ,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       ,s        ; store x in the current stack frame at ,s
                    stb       -$01,x    ; store b at -$01,x
Branch_126          leau      -$01,u    ; form the workspace or data address -$01,u in u
                    pshs      u         ; save u on the stack
                    leax      >$02E6,y  ; form the address >$02E6,y in x
                    cmpx      ,s++      ; compare x with ,s++ and set the condition codes
                    bls       Branch_127 ; branch when the unsigned value is lower or equal; target Branch_127
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       [,s]      ; store b in the current stack frame at [,s]
Branch_117          leax      >$02DC,y  ; form the address >$02DC,y in x
                    tfr       x,d       ; copy the register values specified by x,d
Branch_116          leas      $02,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_040         pshs      u,x,d     ; save u,x,d on the stack
                    leax      >$02DC,y  ; form the address >$02DC,y in x
                    stx       $02,s     ; store x in the current stack frame at $02,s
                    leau      >$02E6,y  ; form the workspace or data address >$02E6,y in u
Branch_128          ldd       $08,s     ; load d from the current stack frame at $08,s
                    clra                ; clear a to zero and set the condition codes
                    andb      #15       ; mask b using #15
                    std       ,s        ; store d in the current stack frame at ,s
                    pshs      d         ; save d on the stack
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    cmpd      #9        ; compare d with #9 and set the condition codes
                    ble       Branch_129 ; branch when the signed value is less than or equal; target Branch_129
                    ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    beq       Branch_130 ; branch when the values are equal or the result is zero; target Branch_130
                    ldd       #65       ; set d to the constant 65
                    bra       Branch_131 ; continue execution at Branch_131
Branch_130          ldd       #97       ; set d to the constant 97
Branch_131          addd      #-10      ; add to d using #-10
                    bra       Branch_132 ; continue execution at Branch_132
Branch_129          ldd       #48       ; set d to the constant 48
Branch_132          addd      ,s++      ; add to d using ,s++
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
                    bne       Branch_128 ; branch when the values differ or the result is nonzero; target Branch_128
                    bra       Branch_133 ; continue execution at Branch_133
Branch_134          ldb       WorkByte_001,u ; load b from WorkByte_001,u
                    ldx       $02,s     ; load x from the current stack frame at $02,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       $02,s     ; store x in the current stack frame at $02,s
                    stb       -$01,x    ; store b at -$01,x
Branch_133          leau      -$01,u    ; form the workspace or data address -$01,u in u
                    pshs      u         ; save u on the stack
                    leax      >$02E6,y  ; form the address >$02E6,y in x
                    cmpx      ,s++      ; compare x with ,s++ and set the condition codes
                    bls       Branch_134 ; branch when the unsigned value is lower or equal; target Branch_134
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       [<$02,s]  ; store b in the current stack frame at [<$02,s]
                    leax      >$02DC,y  ; form the address >$02DC,y in x
                    tfr       x,d       ; copy the register values specified by x,d
                    lbra      Branch_135 ; continue execution at Branch_135
Routine_043         pshs      u         ; save u on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    subd      $08,s     ; subtract from d using $08,s
                    std       $0A,s     ; store d in the current stack frame at $0A,s
                    ldd       >$02F0,y  ; load d from >$02F0,y
                    bne       Branch_136 ; branch when the values differ or the result is nonzero; target Branch_136
                    bra       Branch_137 ; continue execution at Branch_137
Branch_138          ldd       >$02F2,y  ; load d from >$02F2,y
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
Branch_137          ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    addd      #-1       ; add to d using #-1
                    std       $0A,s     ; store d in the current stack frame at $0A,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       Branch_138 ; branch when the signed value is greater; target Branch_138
                    bra       Branch_136 ; continue execution at Branch_136
Branch_139          ldb       ,u+       ; load b from ,u+
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
Branch_136          ldd       $08,s     ; load d from the current stack frame at $08,s
                    addd      #-1       ; add to d using #-1
                    std       $08,s     ; store d in the current stack frame at $08,s
                    subd      #-1       ; subtract from d using #-1
                    bne       Branch_139 ; branch when the values differ or the result is nonzero; target Branch_139
                    ldd       >$02F0,y  ; load d from >$02F0,y
                    beq       Branch_140 ; branch when the values are equal or the result is zero; target Branch_140
                    bra       Branch_141 ; continue execution at Branch_141
Branch_142          ldd       >$02F2,y  ; load d from >$02F2,y
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
Branch_141          ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    addd      #-1       ; add to d using #-1
                    std       $0A,s     ; store d in the current stack frame at $0A,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       Branch_142 ; branch when the signed value is greater; target Branch_142
Branch_140          puls      pc,u      ; restore pc,u and return to the caller
Routine_045         pshs      u         ; save u on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    ldd       $08,s     ; load d from the current stack frame at $08,s
                    pshs      d         ; save d on the stack
                    pshs      u         ; save u on the stack
                    lbsr      Routine_047 ; call subroutine Routine_047
                    leas      $02,s     ; adjust the system stack pointer
                    nega                ; negate a
                    negb                ; negate b
                    sbca      #0        ; subtract with borrow from a using #0
                    addd      ,s++      ; add to d using ,s++
                    std       $08,s     ; store d in the current stack frame at $08,s
                    ldd       >$02F0,y  ; load d from >$02F0,y
                    bne       Branch_143 ; branch when the values differ or the result is nonzero; target Branch_143
                    bra       Branch_144 ; continue execution at Branch_144
Branch_145          ldd       >$02F2,y  ; load d from >$02F2,y
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
Branch_144          ldd       $08,s     ; load d from the current stack frame at $08,s
                    addd      #-1       ; add to d using #-1
                    std       $08,s     ; store d in the current stack frame at $08,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       Branch_145 ; branch when the signed value is greater; target Branch_145
                    bra       Branch_143 ; continue execution at Branch_143
Branch_146          ldb       ,u+       ; load b from ,u+
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
Branch_143          ldb       WorkByte_001,u ; load b from WorkByte_001,u
                    bne       Branch_146 ; branch when the values differ or the result is nonzero; target Branch_146
                    ldd       >$02F0,y  ; load d from >$02F0,y
                    beq       Branch_147 ; branch when the values are equal or the result is zero; target Branch_147
                    bra       Branch_148 ; continue execution at Branch_148
Branch_149          ldd       >$02F2,y  ; load d from >$02F2,y
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
Branch_148          ldd       $08,s     ; load d from the current stack frame at $08,s
                    addd      #-1       ; add to d using #-1
                    std       $08,s     ; store d in the current stack frame at $08,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       Branch_149 ; branch when the signed value is greater; target Branch_149
Branch_147          puls      pc,u      ; restore pc,u and return to the caller
Data_013            fcb       $34       ; store byte data
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
Branch_135          leas      $04,s     ; adjust the system stack pointer
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
Text_035            fcc       "-32768" ; store literal character data
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
Routine_048         pshs      u,d       ; save u,d on the stack
                    leau      >$0013,y  ; form the workspace or data address >$0013,y in u
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       ,s        ; store d in the current stack frame at ,s
                    bra       Branch_150 ; continue execution at Branch_150
Branch_151          tfr       u,d       ; copy the register values specified by u,d
                    leau      WorkBuffer_001,u ; form the workspace or data address WorkBuffer_001,u in u
                    pshs      d         ; save d on the stack
                    bsr       Routine_049 ; call subroutine Routine_049
                    leas      $02,s     ; adjust the system stack pointer
Branch_150          ldd       ,s        ; load d from the current stack frame at ,s
                    addd      #1        ; add to d using #1
                    std       ,s        ; store d in the current stack frame at ,s
                    subd      #1        ; subtract from d using #1
                    cmpd      #16       ; compare d with #16 and set the condition codes
                    blt       Branch_151 ; branch when the signed value is less; target Branch_151
                    lbra      Branch_152 ; continue execution at Branch_152
Routine_049         pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    leas      -$02,s    ; adjust the system stack pointer
                    cmpu      #0        ; compare u with #0 and set the condition codes
                    beq       Branch_153 ; branch when the values are equal or the result is zero; target Branch_153
                    ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    bne       Branch_154 ; branch when the values differ or the result is nonzero; target Branch_154
Branch_153          ldd       #-1       ; set d to the constant -1
                    lbra      Branch_152 ; continue execution at Branch_152
Branch_154          ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #2        ; mask b using #2
                    beq       Branch_155 ; branch when the values are equal or the result is zero; target Branch_155
                    pshs      u         ; save u on the stack
                    bsr       Routine_024 ; call subroutine Routine_024
                    leas      $02,s     ; adjust the system stack pointer
                    bra       Branch_156 ; continue execution at Branch_156
Branch_155          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
Branch_156          std       ,s        ; store d in the current stack frame at ,s
                    ldd       WorkWord_004,u ; load d from WorkWord_004,u
                    pshs      d         ; save d on the stack
                    lbsr      Routine_023 ; call subroutine Routine_023
                    leas      $02,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       WorkWord_003,u ; store d at WorkWord_003,u
                    ldd       ,s        ; load d from the current stack frame at ,s
                    bra       Branch_152 ; continue execution at Branch_152
Routine_024         pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    beq       Branch_157 ; branch when the values are equal or the result is zero; target Branch_157
                    ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #34       ; mask b using #34
                    cmpd      #2        ; compare d with #2 and set the condition codes
                    beq       Branch_158 ; branch when the values are equal or the result is zero; target Branch_158
Branch_157          ldd       #-1       ; set d to the constant -1
                    puls      pc,u      ; restore pc,u and return to the caller
Branch_158          ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    anda      #128      ; mask a using #128
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    bne       Branch_159 ; branch when the values differ or the result is nonzero; target Branch_159
                    pshs      u         ; save u on the stack
                    lbsr      Routine_050 ; call subroutine Routine_050
                    leas      $02,s     ; adjust the system stack pointer
Branch_159          pshs      u         ; save u on the stack
                    bsr       Routine_051 ; call subroutine Routine_051
Branch_152          leas      $02,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_051         pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    leas      -$04,s    ; adjust the system stack pointer
                    ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    anda      #1        ; mask a using #1
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    bne       Branch_160 ; branch when the values differ or the result is nonzero; target Branch_160
                    ldd       WorkByte_001,u ; load d from WorkByte_001,u
                    cmpd      WorkWord_002,u ; compare d with WorkWord_002,u and set the condition codes
                    beq       Branch_160 ; branch when the values are equal or the result is zero; target Branch_160
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    pshs      u         ; save u on the stack
                    lbsr      Routine_052 ; call subroutine Routine_052
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       $02,x     ; load d from $02,x
                    pshs      d         ; save d on the stack
                    ldd       ,x        ; load d from ,x
                    pshs      d         ; save d on the stack
                    ldd       WorkWord_004,u ; load d from WorkWord_004,u
                    pshs      d         ; save d on the stack
                    lbsr      Routine_053 ; call subroutine Routine_053
                    leas      $08,s     ; adjust the system stack pointer
Branch_160          ldd       WorkByte_001,u ; load d from WorkByte_001,u
                    subd      WorkWord_001,u ; subtract from d using WorkWord_001,u
                    std       $02,s     ; store d in the current stack frame at $02,s
                    lbeq      Branch_161 ; branch when the values are equal or the result is zero; target Branch_161
                    ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    anda      #1        ; mask a using #1
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    lbeq      Branch_161 ; branch when the values are equal or the result is zero; target Branch_161
                    ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #64       ; mask b using #64
                    beq       Branch_162 ; branch when the values are equal or the result is zero; target Branch_162
                    ldd       WorkWord_001,u ; load d from WorkWord_001,u
                    bra       Branch_163 ; continue execution at Branch_163
Branch_164          ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    ldd       WorkByte_001,u ; load d from WorkByte_001,u
                    pshs      d         ; save d on the stack
                    ldd       WorkWord_004,u ; load d from WorkWord_004,u
                    pshs      d         ; save d on the stack
                    lbsr      Routine_054 ; call subroutine Routine_054
                    leas      $06,s     ; adjust the system stack pointer
                    std       ,s        ; store d in the current stack frame at ,s
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    bne       Branch_165 ; branch when the values differ or the result is nonzero; target Branch_165
                    leax      $04,s     ; form the address $04,s in x
                    bra       Branch_166 ; continue execution at Branch_166
Branch_165          ldd       $02,s     ; load d from the current stack frame at $02,s
                    subd      ,s        ; subtract from d using ,s
                    std       $02,s     ; store d in the current stack frame at $02,s
                    ldd       WorkByte_001,u ; load d from WorkByte_001,u
                    addd      ,s        ; add to d using ,s
Branch_163          std       WorkByte_001,u ; store d at WorkByte_001,u
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    bne       Branch_164 ; branch when the values differ or the result is nonzero; target Branch_164
                    bra       Branch_161 ; continue execution at Branch_161
Branch_162          ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    ldd       WorkWord_001,u ; load d from WorkWord_001,u
                    pshs      d         ; save d on the stack
                    ldd       WorkWord_004,u ; load d from WorkWord_004,u
                    pshs      d         ; save d on the stack
                    lbsr      Routine_021 ; call subroutine Routine_021
                    leas      $06,s     ; adjust the system stack pointer
                    cmpd      $02,s     ; compare d with $02,s and set the condition codes
                    beq       Branch_161 ; branch when the values are equal or the result is zero; target Branch_161
                    bra       Branch_167 ; continue execution at Branch_167
Branch_166          leas      -$04,x    ; adjust the system stack pointer
Branch_167          ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    orb       #32       ; set selected bits in b using #32
                    std       WorkWord_003,u ; store d at WorkWord_003,u
                    ldd       WorkWord_002,u ; load d from WorkWord_002,u
                    std       WorkByte_001,u ; store d at WorkByte_001,u
                    ldd       #-1       ; set d to the constant -1
                    bra       Branch_168 ; continue execution at Branch_168
Branch_161          ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    ora       #1        ; set selected bits in a using #1
                    std       WorkWord_003,u ; store d at WorkWord_003,u
                    ldd       WorkWord_001,u ; load d from WorkWord_001,u
                    std       WorkByte_001,u ; store d at WorkByte_001,u
                    addd      WorkWord_005,u ; add to d using WorkWord_005,u
                    std       WorkWord_002,u ; store d at WorkWord_002,u
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
Branch_168          leas      $04,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_052         pshs      u         ; save u on the stack
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_035         pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    beq       Branch_169 ; branch when the values are equal or the result is zero; target Branch_169
                    ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    anda      #1        ; mask a using #1
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    bne       Branch_169 ; branch when the values differ or the result is nonzero; target Branch_169
                    ldd       WorkByte_001,u ; load d from WorkByte_001,u
                    cmpd      WorkWord_002,u ; compare d with WorkWord_002,u and set the condition codes
                    bcc       Branch_170 ; branch when carry is clear; target Branch_170
                    ldd       WorkByte_001,u ; load d from WorkByte_001,u
                    addd      #1        ; add to d using #1
                    std       WorkByte_001,u ; store d at WorkByte_001,u
                    subd      #1        ; subtract from d using #1
                    tfr       d,x       ; copy the register values specified by d,x
                    ldb       ,x        ; load b from ,x
                    clra                ; clear a to zero and set the condition codes
                    lbra      Branch_171 ; continue execution at Branch_171
Branch_170          pshs      u         ; save u on the stack
                    lbsr      Routine_055 ; call subroutine Routine_055
                    lbra      Branch_172 ; continue execution at Branch_172
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
Branch_169          ldd       #-1       ; set d to the constant -1
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
Routine_055         pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    leas      -$02,s    ; adjust the system stack pointer
                    ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    anda      #128      ; mask a using #128
                    andb      #49       ; mask b using #49
                    cmpd      #-32767   ; compare d with #-32767 and set the condition codes
                    beq       Branch_173 ; branch when the values are equal or the result is zero; target Branch_173
                    ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #49       ; mask b using #49
                    cmpd      #1        ; compare d with #1 and set the condition codes
                    lbne      Branch_174 ; branch when the values differ or the result is nonzero; target Branch_174
                    pshs      u         ; save u on the stack
                    lbsr      Routine_050 ; call subroutine Routine_050
                    leas      $02,s     ; adjust the system stack pointer
Branch_173          leax      >$0013,y  ; form the address >$0013,y in x
                    pshs      x         ; save x on the stack
                    cmpu      ,s++      ; compare u with ,s++ and set the condition codes
                    bne       Branch_175 ; branch when the values differ or the result is nonzero; target Branch_175
                    ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #64       ; mask b using #64
                    beq       Branch_175 ; branch when the values are equal or the result is zero; target Branch_175
                    leax      >$0020,y  ; form the address >$0020,y in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_024 ; call subroutine Routine_024
                    leas      $02,s     ; adjust the system stack pointer
Branch_175          ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #8        ; mask b using #8
                    beq       Branch_176 ; branch when the values are equal or the result is zero; target Branch_176
                    ldd       WorkWord_005,u ; load d from WorkWord_005,u
                    pshs      d         ; save d on the stack
                    ldd       WorkWord_001,u ; load d from WorkWord_001,u
                    pshs      d         ; save d on the stack
                    ldd       WorkWord_004,u ; load d from WorkWord_004,u
                    pshs      d         ; save d on the stack
                    ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #64       ; mask b using #64
                    beq       Branch_177 ; branch when the values are equal or the result is zero; target Branch_177
                    leax      >Data_014,pc ; form the address >Data_014,pc in x
                    bra       Branch_178 ; continue execution at Branch_178
Branch_177          leax      >Routine_019,pc ; form the address >Routine_019,pc in x
Branch_178          tfr       x,d       ; copy the register values specified by x,d
                    tfr       d,x       ; copy the register values specified by d,x
                    jsr       ,x        ; call subroutine ,x
                    bra       Branch_179 ; continue execution at Branch_179
Branch_176          ldd       #1        ; set d to the constant 1
                    pshs      d         ; save d on the stack
                    leax      WorkByte_003,u ; form the address WorkByte_003,u in x
                    stx       WorkWord_001,u ; store x at WorkWord_001,u
                    pshs      x         ; save x on the stack
                    ldd       WorkWord_004,u ; load d from WorkWord_004,u
                    pshs      d         ; save d on the stack
                    lbsr      Routine_019 ; call subroutine Routine_019
Branch_179          leas      $06,s     ; adjust the system stack pointer
                    std       ,s        ; store d in the current stack frame at ,s
                    ldd       ,s        ; load d from the current stack frame at ,s
                    bgt       Branch_180 ; branch when the signed value is greater; target Branch_180
                    ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    pshs      d         ; save d on the stack
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    beq       Branch_181 ; branch when the values are equal or the result is zero; target Branch_181
                    ldd       #32       ; set d to the constant 32
                    bra       Branch_182 ; continue execution at Branch_182
Branch_181          ldd       #16       ; set d to the constant 16
Branch_182          ora       ,s+       ; set selected bits in a using ,s+
                    orb       ,s+       ; set selected bits in b using ,s+
                    std       WorkWord_003,u ; store d at WorkWord_003,u
Branch_174          ldd       #-1       ; set d to the constant -1
                    bra       Branch_172 ; continue execution at Branch_172
Branch_180          ldd       WorkWord_001,u ; load d from WorkWord_001,u
                    addd      #1        ; add to d using #1
                    std       WorkByte_001,u ; store d at WorkByte_001,u
                    ldd       WorkWord_001,u ; load d from WorkWord_001,u
                    addd      ,s        ; add to d using ,s
                    std       WorkWord_002,u ; store d at WorkWord_002,u
                    ldb       [<$02,u]  ; load b from [<$02,u]
                    clra                ; clear a to zero and set the condition codes
Branch_172          leas      $02,s     ; adjust the system stack pointer
Branch_171          puls      pc,u      ; restore pc,u and return to the caller
Routine_050         pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #192      ; mask b using #192
                    bne       Branch_183 ; branch when the values differ or the result is nonzero; target Branch_183
                    leas      -$20,s    ; adjust the system stack pointer
                    leax      ,s        ; form the address ,s in x
                    pshs      x         ; save x on the stack
                    ldd       WorkWord_004,u ; load d from WorkWord_004,u
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      Routine_011 ; call subroutine Routine_011
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    pshs      d         ; save d on the stack
                    ldb       $02,s     ; load b from the current stack frame at $02,s
                    bne       Branch_184 ; branch when the values differ or the result is nonzero; target Branch_184
                    ldd       #64       ; set d to the constant 64
                    bra       Branch_185 ; continue execution at Branch_185
Branch_184          ldd       #128      ; set d to the constant 128
Branch_185          ora       ,s+       ; set selected bits in a using ,s+
                    orb       ,s+       ; set selected bits in b using ,s+
                    std       WorkWord_003,u ; store d at WorkWord_003,u
                    leas      <$0020,s  ; adjust the system stack pointer
Branch_183          ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    ora       #128      ; set selected bits in a using #128
                    std       WorkWord_003,u ; store d at WorkWord_003,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #12       ; mask b using #12
                    beq       Branch_186 ; branch when the values are equal or the result is zero; target Branch_186
                    puls      pc,u      ; restore pc,u and return to the caller
Branch_186          ldd       WorkWord_005,u ; load d from WorkWord_005,u
                    bne       Branch_187 ; branch when the values differ or the result is nonzero; target Branch_187
                    ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #64       ; mask b using #64
                    beq       Branch_188 ; branch when the values are equal or the result is zero; target Branch_188
                    ldd       #128      ; set d to the constant 128
                    bra       Branch_189 ; continue execution at Branch_189
Branch_188          ldd       #256      ; set d to the constant 256
Branch_189          std       WorkWord_005,u ; store d at WorkWord_005,u
Branch_187          ldd       WorkWord_001,u ; load d from WorkWord_001,u
                    bne       Branch_190 ; branch when the values differ or the result is nonzero; target Branch_190
                    ldd       WorkWord_005,u ; load d from WorkWord_005,u
                    pshs      d         ; save d on the stack
                    lbsr      Routine_056 ; call subroutine Routine_056
                    leas      $02,s     ; adjust the system stack pointer
                    std       WorkWord_001,u ; store d at WorkWord_001,u
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    beq       Branch_191 ; branch when the values are equal or the result is zero; target Branch_191
Branch_190          ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    orb       #8        ; set selected bits in b using #8
                    std       WorkWord_003,u ; store d at WorkWord_003,u
                    bra       Branch_192 ; continue execution at Branch_192
Branch_191          ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    orb       #4        ; set selected bits in b using #4
                    std       WorkWord_003,u ; store d at WorkWord_003,u
                    leax      WorkByte_003,u ; form the address WorkByte_003,u in x
                    stx       WorkWord_001,u ; store x at WorkWord_001,u
                    ldd       #1        ; set d to the constant 1
                    std       WorkWord_005,u ; store d at WorkWord_005,u
Branch_192          ldd       WorkWord_001,u ; load d from WorkWord_001,u
                    addd      WorkWord_005,u ; add to d using WorkWord_005,u
                    std       WorkWord_002,u ; store d at WorkWord_002,u
                    std       WorkByte_001,u ; store d at WorkByte_001,u
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_044         pshs      u         ; save u on the stack
                    ldb       $05,s     ; load b from the current stack frame at $05,s
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; copy the register values specified by d,x
                    bra       Branch_193 ; continue execution at Branch_193
Branch_194          ldd       [<$06,s]  ; load d from the current stack frame at [<$06,s]
                    addd      #4        ; add to d using #4
                    std       [<$06,s]  ; store d in the current stack frame at [<$06,s]
                    leax      >Data_015,pc ; form the address >Data_015,pc in x
                    bra       Branch_195 ; continue execution at Branch_195
Branch_196          ldb       $05,s     ; load b from the current stack frame at $05,s
                    stb       >$0011,y  ; store b at >$0011,y
                    leax      >$0010,y  ; form the address >$0010,y in x
Branch_195          tfr       x,d       ; copy the register values specified by x,d
                    puls      pc,u      ; restore pc,u and return to the caller
Branch_193          cmpx      #100      ; compare x with #100 and set the condition codes
                    beq       Branch_194 ; branch when the values are equal or the result is zero; target Branch_194
                    cmpx      #111      ; compare x with #111 and set the condition codes
                    lbeq      Branch_194 ; branch when the values are equal or the result is zero; target Branch_194
                    cmpx      #120      ; compare x with #120 and set the condition codes
                    lbeq      Branch_194 ; branch when the values are equal or the result is zero; target Branch_194
                    bra       Branch_196 ; continue execution at Branch_196
                    fcb       $35       ; store byte data
                    fcb       $C0       ; store byte data
Data_015            fcb       $00       ; store byte data
Routine_042         pshs      u         ; save u on the stack
                    leax      >Data_016,pc ; form the address >Data_016,pc in x
                    tfr       x,d       ; copy the register values specified by x,d
                    puls      pc,u      ; restore pc,u and return to the caller
Data_016            fcb       $00       ; store byte data
Routine_047         pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
Branch_197          ldb       ,u+       ; load b from ,u+
                    bne       Branch_197 ; branch when the values differ or the result is nonzero; target Branch_197
                    tfr       u,d       ; copy the register values specified by u,d
                    subd      $04,s     ; subtract from d using $04,s
                    addd      #-1       ; add to d using #-1
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_046         pshs      u         ; save u on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    leas      -$02,s    ; adjust the system stack pointer
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    std       ,s        ; store d in the current stack frame at ,s
Branch_198          ldb       ,u+       ; load b from ,u+
                    ldx       ,s        ; load x from the current stack frame at ,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       ,s        ; store x in the current stack frame at ,s
                    stb       -$01,x    ; store b at -$01,x
                    bne       Branch_198 ; branch when the values differ or the result is nonzero; target Branch_198
                    bra       Branch_199 ; continue execution at Branch_199
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
Branch_199          ldd       $06,s     ; load d from the current stack frame at $06,s
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
Routine_037         tsta                ; set condition codes from a without changing it
                    bne       Branch_200 ; branch when the values differ or the result is nonzero; target Branch_200
                    tst       $02,s     ; set condition codes from $02,s without changing it
                    bne       Branch_200 ; branch when the values differ or the result is nonzero; target Branch_200
                    lda       $03,s     ; load a from the current stack frame at $03,s
                    mul                 ; multiply a by b and return the product in d
                    ldx       ,s        ; load x from the current stack frame at ,s
                    stx       $02,s     ; store x in the current stack frame at $02,s
                    ldx       #0        ; set x to the constant 0
                    std       ,s        ; store d in the current stack frame at ,s
                    puls      pc,d      ; restore pc,d and return to the caller
Branch_200          pshs      d         ; save d on the stack
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
                    bcc       Branch_201 ; branch when carry is clear; target Branch_201
                    inc       ,s        ; increment the value at ,s
Branch_201          lda       $04,s     ; load a from the current stack frame at $04,s
                    ldb       $09,s     ; load b from the current stack frame at $09,s
                    mul                 ; multiply a by b and return the product in d
                    addd      $01,s     ; add to d using $01,s
                    std       $01,s     ; store d in the current stack frame at $01,s
                    bcc       Branch_202 ; branch when carry is clear; target Branch_202
                    inc       ,s        ; increment the value at ,s
Branch_202          lda       $04,s     ; load a from the current stack frame at $04,s
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    mul                 ; multiply a by b and return the product in d
                    addd      ,s        ; add to d using ,s
                    std       ,s        ; store d in the current stack frame at ,s
                    ldx       $06,s     ; load x from the current stack frame at $06,s
                    stx       $08,s     ; store x in the current stack frame at $08,s
                    ldx       ,s        ; load x from the current stack frame at ,s
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
Routine_011         lda       $05,s     ; load a from the current stack frame at $05,s
                    ldb       $03,s     ; load b from the current stack frame at $03,s
                    beq       Branch_203 ; branch when the values are equal or the result is zero; target Branch_203
                    cmpb      #1        ; compare b with #1 and set the condition codes
                    beq       Branch_204 ; branch when the values are equal or the result is zero; target Branch_204
                    cmpb      #6        ; compare b with #6 and set the condition codes
                    beq       Branch_204 ; branch when the values are equal or the result is zero; target Branch_204
                    cmpb      #2        ; compare b with #2 and set the condition codes
                    beq       Branch_205 ; branch when the values are equal or the result is zero; target Branch_205
                    cmpb      #5        ; compare b with #5 and set the condition codes
                    beq       Branch_205 ; branch when the values are equal or the result is zero; target Branch_205
                    ldb       #208      ; set b to the constant 208
                    lbra      Branch_206 ; continue execution at Branch_206
Branch_205          pshs      u         ; save u on the stack
                    os9       I$GetStt  ; query status code B for path A
                    bcc       Branch_207 ; branch when carry is clear; target Branch_207
                    puls      u         ; restore u from the stack
                    lbra      Branch_206 ; continue execution at Branch_206
Branch_207          stx       [<$08,s]  ; store x in the current stack frame at [<$08,s]
                    ldx       $08,s     ; load x from the current stack frame at $08,s
                    stu       $02,x     ; store u at $02,x
                    puls      u         ; restore u from the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    rts                 ; return to the caller
Branch_203          ldx       $06,s     ; load x from the current stack frame at $06,s
Branch_204          os9       I$GetStt  ; query status code B for path A
                    lbra      Branch_208 ; continue execution at Branch_208
Routine_012         lda       $05,s     ; load a from the current stack frame at $05,s
                    ldb       $03,s     ; load b from the current stack frame at $03,s
                    beq       Branch_209 ; branch when the values are equal or the result is zero; target Branch_209
                    cmpb      #2        ; compare b with #2 and set the condition codes
                    beq       Branch_210 ; branch when the values are equal or the result is zero; target Branch_210
                    ldb       #208      ; set b to the constant 208
                    lbra      Branch_206 ; continue execution at Branch_206
Branch_209          ldx       $06,s     ; load x from the current stack frame at $06,s
                    os9       I$SetStt  ; apply status operation B to path A
                    lbra      Branch_208 ; continue execution at Branch_208
Branch_210          pshs      u         ; save u on the stack
                    ldx       $08,s     ; load x from the current stack frame at $08,s
                    ldu       $0A,s     ; load u from the current stack frame at $0A,s
                    os9       I$SetStt  ; apply status operation B to path A
                    puls      u         ; restore u from the stack
                    lbra      Branch_208 ; continue execution at Branch_208
Routine_032         ldx       $02,s     ; load x from the current stack frame at $02,s
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    os9       I$Open    ; open the path at X using access mode A
                    bcs       Branch_211 ; branch when carry reports an error or unsigned underflow; target Branch_211
                    os9       I$Close   ; close path A
Branch_211          lbra      Branch_208 ; continue execution at Branch_208
Routine_008         ldx       $02,s     ; load x from the current stack frame at $02,s
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_206 ; branch when carry reports an error or unsigned underflow; target Branch_206
                    tfr       a,b       ; copy the register values specified by a,b
                    clra                ; clear a to zero and set the condition codes
                    rts                 ; return to the caller
Routine_023         lda       $03,s     ; load a from the current stack frame at $03,s
                    os9       I$Close   ; close path A
                    lbra      Branch_208 ; continue execution at Branch_208
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
Routine_033         ldx       $02,s     ; load x from the current stack frame at $02,s
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    tfr       a,b       ; copy the register values specified by a,b
                    andb      #36       ; mask b using #36
                    orb       #11       ; set selected bits in b using #11
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    bcs       Branch_212 ; branch when carry reports an error or unsigned underflow; target Branch_212
Branch_213          tfr       a,b       ; copy the register values specified by a,b
                    clra                ; clear a to zero and set the condition codes
                    rts                 ; return to the caller
Branch_212          cmpb      #218      ; compare b with #218 and set the condition codes
                    lbne      Branch_206 ; branch when the values differ or the result is nonzero; target Branch_206
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    bita      #128      ; test selected bits in a using #128
                    lbne      Branch_206 ; branch when the values differ or the result is nonzero; target Branch_206
                    anda      #7        ; mask a using #7
                    ldx       $02,s     ; load x from the current stack frame at $02,s
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_206 ; branch when carry reports an error or unsigned underflow; target Branch_206
                    pshs      u,a       ; save u,a on the stack
                    ldx       #0        ; set x to the constant 0
                    leau      ,x        ; form the workspace or data address ,x in u
                    ldb       #2        ; set b to the constant 2
                    os9       I$SetStt  ; apply status operation B to path A
                    puls      u,a       ; restore u,a from the stack
                    bcc       Branch_213 ; branch when carry is clear; target Branch_213
                    pshs      b         ; save b on the stack
                    os9       I$Close   ; close path A
                    puls      b         ; restore b from the stack
                    lbra      Branch_206 ; continue execution at Branch_206
Routine_034         ldx       $02,s     ; load x from the current stack frame at $02,s
                    os9       I$Delete  ; delete the path named at X
                    lbra      Branch_208 ; continue execution at Branch_208
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
Routine_019         pshs      y         ; save y on the stack
                    ldx       $06,s     ; load x from the current stack frame at $06,s
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    ldy       $08,s     ; load y from the current stack frame at $08,s
                    pshs      y         ; save y on the stack
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcc       Branch_214 ; branch when carry is clear; target Branch_214
                    cmpb      #211      ; compare b with #211 and set the condition codes
                    bne       Branch_215 ; branch when the values differ or the result is nonzero; target Branch_215
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    puls      pc,y,x    ; restore pc,y,x and return to the caller
Branch_215          puls      y,x       ; restore y,x from the stack
                    lbra      Branch_206 ; continue execution at Branch_206
Branch_214          tfr       y,d       ; copy the register values specified by y,d
                    puls      pc,y,x    ; restore pc,y,x and return to the caller
Data_014            fcb       $34       ; store byte data
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
Routine_021         pshs      y         ; save y on the stack
                    ldy       $08,s     ; load y from the current stack frame at $08,s
                    beq       Branch_216 ; branch when the values are equal or the result is zero; target Branch_216
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    ldx       $06,s     ; load x from the current stack frame at $06,s
                    os9       I$Write   ; write Y bytes from X to path A
Branch_217          bcc       Branch_216 ; branch when carry is clear; target Branch_216
                    puls      y         ; restore y from the stack
                    lbra      Branch_206 ; continue execution at Branch_206
Branch_216          tfr       y,d       ; copy the register values specified by y,d
                    puls      pc,y      ; restore pc,y and return to the caller
Routine_054         pshs      y         ; save y on the stack
                    ldy       $08,s     ; load y from the current stack frame at $08,s
                    beq       Branch_216 ; branch when the values are equal or the result is zero; target Branch_216
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    ldx       $06,s     ; load x from the current stack frame at $06,s
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    bra       Branch_217 ; continue execution at Branch_217
Routine_053         pshs      u         ; save u on the stack
                    ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    bne       Branch_218 ; branch when the values differ or the result is nonzero; target Branch_218
                    ldu       #0        ; set u to the constant 0
                    ldx       #0        ; set x to the constant 0
                    bra       Branch_219 ; continue execution at Branch_219
Branch_218          cmpd      #1        ; compare d with #1 and set the condition codes
                    beq       Branch_220 ; branch when the values are equal or the result is zero; target Branch_220
                    cmpd      #2        ; compare d with #2 and set the condition codes
                    beq       Branch_221 ; branch when the values are equal or the result is zero; target Branch_221
                    ldb       #247      ; set b to the constant 247
Branch_222          clra                ; clear a to zero and set the condition codes
                    std       >$01B2,y  ; store d at >$01B2,y
                    ldd       #-1       ; set d to the constant -1
                    leax      >$01A6,y  ; form the address >$01A6,y in x
                    std       ,x        ; store d at ,x
                    std       $02,x     ; store d at $02,x
                    puls      pc,u      ; restore pc,u and return to the caller
Branch_221          lda       $05,s     ; load a from the current stack frame at $05,s
                    ldb       #2        ; set b to the constant 2
                    os9       I$GetStt  ; query status code B for path A
                    bcs       Branch_222 ; branch when carry reports an error or unsigned underflow; target Branch_222
                    bra       Branch_219 ; continue execution at Branch_219
Branch_220          lda       $05,s     ; load a from the current stack frame at $05,s
                    ldb       #5        ; set b to the constant 5
                    os9       I$GetStt  ; query status code B for path A
                    bcs       Branch_222 ; branch when carry reports an error or unsigned underflow; target Branch_222
Branch_219          tfr       u,d       ; copy the register values specified by u,d
                    addd      $08,s     ; add to d using $08,s
                    std       >$01A8,y  ; store d at >$01A8,y
                    tfr       d,u       ; copy the register values specified by d,u
                    tfr       x,d       ; copy the register values specified by x,d
                    adcb      $07,s     ; add with carry to b using $07,s
                    adca      $06,s     ; add with carry to a using $06,s
                    bmi       Branch_222 ; branch when the result is negative; target Branch_222
                    tfr       d,x       ; copy the register values specified by d,x
                    std       >$01A6,y  ; store d at >$01A6,y
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    bcs       Branch_222 ; branch when carry reports an error or unsigned underflow; target Branch_222
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
Routine_022         ldx       $02,s     ; load x from the current stack frame at $02,s
                    os9       F$Sleep   ; sleep for the number of ticks in X
                    lbcs      Branch_206 ; branch when carry reports an error or unsigned underflow; target Branch_206
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
Routine_056         ldd       $02,s     ; load d from the current stack frame at $02,s
                    addd      >$01AE,y  ; add to d using >$01AE,y
                    bcs       Branch_223 ; branch when carry reports an error or unsigned underflow; target Branch_223
                    cmpd      >$01B0,y  ; compare d with >$01B0,y and set the condition codes
                    bcc       Branch_223 ; branch when carry is clear; target Branch_223
                    pshs      d         ; save d on the stack
                    ldx       >$01AE,y  ; load x from >$01AE,y
                    clra                ; clear a to zero and set the condition codes
Branch_224          cmpx      ,s        ; compare x with ,s and set the condition codes
                    bcc       Branch_225 ; branch when carry is clear; target Branch_225
                    sta       ,x+       ; store a at ,x+
                    bra       Branch_224 ; continue execution at Branch_224
Branch_225          ldd       >$01AE,y  ; load d from >$01AE,y
                    puls      x         ; restore x from the stack
                    stx       >$01AE,y  ; store x at >$01AE,y
                    rts                 ; return to the caller
Branch_223          ldd       #-1       ; set d to the constant -1
                    rts                 ; return to the caller
Routine_013         pshs      u         ; save u on the stack
                    tfr       y,u       ; copy the register values specified by y,u
                    ldx       $04,s     ; load x from the current stack frame at $04,s
                    stx       >$02F6,y  ; store x at >$02F6,y
                    leax      >Data_017,pc ; form the address >Data_017,pc in x
                    os9       F$Icpt    ; install the signal-intercept routine at X
                    puls      u         ; restore u from the stack
                    lbra      Branch_208 ; continue execution at Branch_208
Data_017            fcb       $1F       ; store byte data
                    fcc       "2O4" ; store literal character data
                    fcb       $06       ; store byte data
                    fcb       $AD       ; store byte data
                    fcb       $B9       ; store byte data
                    fcb       $02       ; store byte data
                    fcb       $F6       ; store byte data
                    fcc       "2b;" ; store literal character data
Branch_206          clra                ; clear a to zero and set the condition codes
                    std       >$01B2,y  ; store d at >$01B2,y
                    ldd       #-1       ; set d to the constant -1
                    rts                 ; return to the caller
Branch_208          bcs       Branch_206 ; branch when carry reports an error or unsigned underflow; target Branch_206
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    rts                 ; return to the caller
Routine_005         lbsr      Code_003  ; call subroutine Code_003
                    lbsr      Routine_048 ; call subroutine Routine_048
Routine_007         ldd       $02,s     ; load d from the current stack frame at $02,s
                    os9       F$Exit    ; terminate the process with status B
Code_003            rts                 ; return to the caller
Routine_018         lda       $03,s     ; load a from the current stack frame at $03,s
                    ldb       #1        ; set b to the constant 1
                    os9       I$GetStt  ; query status code B for path A
                    lbcs      Branch_206 ; branch when carry reports an error or unsigned underflow; target Branch_206
                    clra                ; clear a to zero and set the condition codes
                    rts                 ; return to the caller
Routine_017         lda       $03,s     ; load a from the current stack frame at $03,s
                    ldb       #26       ; set b to the constant 26
                    ldx       $04,s     ; load x from the current stack frame at $04,s
                    os9       I$SetStt  ; apply status operation B to path A
                    lbra      Branch_208 ; continue execution at Branch_208
Routine_027         lda       $03,s     ; load a from the current stack frame at $03,s
                    ldb       #27       ; set b to the constant 27
                    os9       I$SetStt  ; apply status operation B to path A
                    lbra      Branch_208 ; continue execution at Branch_208
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
Routine_014         ldb       #12       ; set b to the constant 12
                    bra       Branch_226 ; continue execution at Branch_226
                    fcb       $C6       ; store byte data
                    fcb       $0D       ; store byte data
Branch_226          stb       >$02F8,y  ; store b at >$02F8,y
                    ldb       #1        ; set b to the constant 1
                    lbra      Branch_227 ; continue execution at Branch_227
Routine_015         ldd       #7968     ; set d to the constant 7968
                    bra       Branch_228 ; continue execution at Branch_228
Routine_016         ldd       #7969     ; set d to the constant 7969
                    bra       Branch_228 ; continue execution at Branch_228
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
Branch_228          std       >$02F8,y  ; store d at >$02F8,y
                    ldb       #2        ; set b to the constant 2
                    lbra      Branch_227 ; continue execution at Branch_227
Branch_227          clra                ; clear a to zero and set the condition codes
                    leax      >$02F8,y  ; form the address >$02F8,y in x
                    pshs      y         ; save y on the stack
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      y         ; restore y from the stack
                    bcs       Branch_229 ; branch when carry reports an error or unsigned underflow; target Branch_229
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    rts                 ; return to the caller
Branch_229          clra                ; clear a to zero and set the condition codes
                    std       >$01B2,y  ; store d at >$01B2,y
                    ldd       #-1       ; set d to the constant -1
                    rts                 ; return to the caller
Data_001            fcb       $00       ; store byte data
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
