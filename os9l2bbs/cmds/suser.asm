**********************************************************************
* suser - OS-9 Level 2 BBS command
*
* Syntax: suser <number> [command]
* Purpose: Adopt an OS-9 user number and run a command or shell.
* Restricted sysop utility for reproducing another caller access context.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
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

WorkByte_001        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_002        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_001        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_002        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_003        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_003        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_004        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_005        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_004        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_001      rmb       338       ; reserve 338 byte(s) in the module workspace
WorkWord_005        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_002      rmb       58        ; reserve 58 byte(s) in the module workspace
WorkByte_006        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_003      rmb       3         ; reserve 3 byte(s) in the module workspace
WorkWord_006        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_004      rmb       938       ; reserve 938 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /Suser/ ; store an OS-9 high-bit-terminated string
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
                    leax      >$01CB,x  ; form the address >$01CB,x in x
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
Code_001            beq       Code_002  ; branch when the values are equal or the result is zero; target Code_002
                    sta       ,u+       ; store a at ,u+
                    bra       Branch_003 ; continue execution at Branch_003
Code_002            ldu       $02,s     ; load u from the current stack frame at $02,s
                    ldd       ,y++      ; load d from ,y++
                    beq       Branch_004 ; branch when the values are equal or the result is zero; target Branch_004
                    leax      >0,pc     ; form the address >,pc in x
                    lbsr      Routine_002 ; call subroutine Routine_002
Branch_004          ldd       ,y++      ; load d from ,y++
                    beq       Branch_005 ; branch when the values are equal or the result is zero; target Branch_005
                    leax      WorkByte_001,u ; form the address WorkByte_001,u in x
                    lbsr      Routine_002 ; call subroutine Routine_002
Branch_005          leas      $04,s     ; adjust the system stack pointer
                    puls      x         ; restore x from the stack
                    stx       >WorkWord_006,u ; store x at >WorkWord_006,u
                    sty       >WorkWord_005,u ; store y at >WorkWord_005,u
                    ldd       #1        ; set d to the constant 1
                    std       >WorkByte_006,u ; store d at >WorkByte_006,u
                    leay      >WorkBuffer_002,u ; form the address >WorkBuffer_002,u in y
                    leax      ,s        ; form the address ,s in x
                    lda       ,x+       ; load a from ,x+
Branch_006          ldb       >WorkBuffer_003,u ; load b from >WorkBuffer_003,u
                    cmpb      #29       ; compare b with #29 and set the condition codes
                    beq       Branch_007 ; branch when the values are equal or the result is zero; target Branch_007
Branch_008          cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_007 ; branch when the values are equal or the result is zero; target Branch_007
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       Branch_009 ; branch when the values are equal or the result is zero; target Branch_009
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    bne       Branch_010 ; branch when the values differ or the result is nonzero; target Branch_010
Branch_009          lda       ,x+       ; load a from ,x+
                    bra       Branch_008 ; continue execution at Branch_008
Branch_010          cmpa      #34       ; compare a with #34 and set the condition codes
                    beq       Branch_011 ; branch when the values are equal or the result is zero; target Branch_011
                    cmpa      #39       ; compare a with #39 and set the condition codes
                    bne       Branch_012 ; branch when the values differ or the result is nonzero; target Branch_012
Branch_011          stx       ,y++      ; store x at ,y++
                    inc       >WorkBuffer_003,u ; increment the value at >WorkBuffer_003,u
                    pshs      a         ; save a on the stack
Branch_013          lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_014 ; branch when the values are equal or the result is zero; target Branch_014
                    cmpa      ,s        ; compare a with ,s and set the condition codes
                    bne       Branch_013 ; branch when the values differ or the result is nonzero; target Branch_013
Branch_014          puls      b         ; restore b from the stack
                    clr       -$01,x    ; clear -$01,x to zero and set the condition codes
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_007 ; branch when the values are equal or the result is zero; target Branch_007
                    lda       ,x+       ; load a from ,x+
                    bra       Branch_006 ; continue execution at Branch_006
Branch_012          leax      -$01,x    ; form the address -$01,x in x
                    stx       ,y++      ; store x at ,y++
                    leax      $01,x     ; form the address $01,x in x
                    inc       >WorkBuffer_003,u ; increment the value at >WorkBuffer_003,u
Branch_015          cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_016 ; branch when the values are equal or the result is zero; target Branch_016
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       Branch_016 ; branch when the values are equal or the result is zero; target Branch_016
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    beq       Branch_016 ; branch when the values are equal or the result is zero; target Branch_016
                    lda       ,x+       ; load a from ,x+
                    bra       Branch_015 ; continue execution at Branch_015
Branch_016          clr       -$01,x    ; clear -$01,x to zero and set the condition codes
                    bra       Branch_006 ; continue execution at Branch_006
Branch_007          leax      >WorkWord_005,u ; form the address >WorkWord_005,u in x
                    pshs      x         ; save x on the stack
                    ldd       >WorkByte_006,u ; load d from >WorkByte_006,u
                    pshs      d         ; save d on the stack
                    leay      WorkByte_001,u ; form the address WorkByte_001,u in y
                    bsr       Routine_003 ; call subroutine Routine_003
                    lbsr      Routine_004 ; call subroutine Routine_004
                    clr       ,-s       ; clear ,-s to zero and set the condition codes
                    clr       ,-s       ; clear ,-s to zero and set the condition codes
                    lbsr      Routine_005 ; call subroutine Routine_005
Routine_003         leax      >$01CB,y  ; form the address >$01CB,y in x
                    stx       >$01A9,y  ; store x at >$01A9,y
                    sts       >$019D,y  ; store s at >$019D,y
                    sts       >$01AB,y  ; store s at >$01AB,y
                    ldd       #-126     ; set d to the constant -126
Routine_006         leax      d,s       ; form the address d,s in x
                    cmpx      >$01AB,y  ; compare x with >$01AB,y and set the condition codes
                    bcc       Branch_017 ; branch when carry is clear; target Branch_017
                    cmpx      >$01A9,y  ; compare x with >$01A9,y and set the condition codes
                    bcs       Branch_018 ; branch when carry reports an error or unsigned underflow; target Branch_018
                    stx       >$01AB,y  ; store x at >$01AB,y
Branch_017          rts                 ; return to the caller
Text_001            fcc       "**** STACK OVERFLOW ****" ; store literal character data
                    fcb       $0D       ; store byte data
Branch_018          leax      <Text_001,pc ; form the address <Text_001,pc in x
                    ldb       #207      ; set b to the constant 207
                    pshs      b         ; save b on the stack
                    lda       #2        ; set a to the constant 2
                    ldy       #100      ; set y to the constant 100
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    clr       ,-s       ; clear ,-s to zero and set the condition codes
                    lbsr      Routine_007 ; call subroutine Routine_007
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
Routine_002         pshs      x         ; save x on the stack
                    leax      d,y       ; form the address d,y in x
                    leax      d,x       ; form the address d,x in x
                    pshs      x         ; save x on the stack
Branch_019          ldd       ,y++      ; load d from ,y++
                    leax      d,u       ; form the address d,u in x
                    ldd       ,x        ; load d from ,x
                    addd      $02,s     ; add to d using $02,s
                    std       ,x        ; store d at ,x
                    cmpy      ,s        ; compare y with ,s and set the condition codes
                    bne       Branch_019 ; branch when the values differ or the result is nonzero; target Branch_019
                    leas      $04,s     ; adjust the system stack pointer
                    rts                 ; return to the caller
Routine_004         pshs      u         ; save u on the stack
                    ldd       #-284     ; set d to the constant -284
                    lbsr      Routine_006 ; call subroutine Routine_006
                    leas      >$FF34,s  ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       ,s        ; store b in the current stack frame at ,s
                    ldd       >$00D0,s  ; load d from the current stack frame at >$00D0,s
                    cmpd      #1        ; compare d with #1 and set the condition codes
                    bne       Branch_020 ; branch when the values differ or the result is nonzero; target Branch_020
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    leax      >Text_002,pc ; form the address >Text_002,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_008 ; call subroutine Routine_008
                    leas      $04,s     ; adjust the system stack pointer
Branch_020          ldx       >$00D2,s  ; load x from the current stack frame at >$00D2,s
                    ldd       $02,x     ; load d from $02,x
                    pshs      d         ; save d on the stack
                    lbsr      Routine_009 ; call subroutine Routine_009
                    leas      $02,s     ; adjust the system stack pointer
                    std       >$00CA,s  ; store d in the current stack frame at >$00CA,s
                    pshs      d         ; save d on the stack
                    lbsr      Routine_010 ; call subroutine Routine_010
                    leas      $02,s     ; adjust the system stack pointer
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    bne       Branch_021 ; branch when the values differ or the result is nonzero; target Branch_021
                    ldd       >$01AD,y  ; load d from >$01AD,y
                    pshs      d         ; save d on the stack
                    leax      >Text_003,pc ; form the address >Text_003,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_008 ; call subroutine Routine_008
                    leas      $04,s     ; adjust the system stack pointer
Branch_021          ldd       #2        ; set d to the constant 2
                    bra       Branch_022 ; continue execution at Branch_022
Branch_023          ldd       >$00C8,s  ; load d from the current stack frame at >$00C8,s
                    aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    ldx       >$00D2,s  ; load x from the current stack frame at >$00D2,s
                    leax      d,x       ; form the address d,x in x
                    ldd       ,x        ; load d from ,x
                    pshs      d         ; save d on the stack
                    leax      $02,s     ; form the address $02,s in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_011 ; call subroutine Routine_011
                    leas      $04,s     ; adjust the system stack pointer
                    leax      >Data_002,pc ; form the address >Data_002,pc in x
                    pshs      x         ; save x on the stack
                    leax      $02,s     ; form the address $02,s in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_011 ; call subroutine Routine_011
                    leas      $04,s     ; adjust the system stack pointer
                    ldd       >$00C8,s  ; load d from the current stack frame at >$00C8,s
                    addd      #1        ; add to d using #1
Branch_022          std       >$00C8,s  ; store d in the current stack frame at >$00C8,s
                    ldd       >$00C8,s  ; load d from the current stack frame at >$00C8,s
                    cmpd      >$00D0,s  ; compare d with >$00D0,s and set the condition codes
                    blt       Branch_023 ; branch when the signed value is less; target Branch_023
                    leax      >Data_003,pc ; form the address >Data_003,pc in x
                    pshs      x         ; save x on the stack
                    leax      $02,s     ; form the address $02,s in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_011 ; call subroutine Routine_011
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
                    lbsr      Routine_012 ; call subroutine Routine_012
                    std       ,s        ; store d in the current stack frame at ,s
                    leax      >Text_004,pc ; form the address >Text_004,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_013 ; call subroutine Routine_013
                    leas      $0C,s     ; adjust the system stack pointer
                    leas      >$00CC,s  ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_008         pshs      u         ; save u on the stack
                    ldd       #-72      ; set d to the constant -72
                    lbsr      Routine_006 ; call subroutine Routine_006
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    pshs      d         ; save d on the stack
                    leax      >Data_004,pc ; form the address >Data_004,pc in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_014 ; call subroutine Routine_014
                    leas      $04,s     ; adjust the system stack pointer
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    lbsr      Routine_005 ; call subroutine Routine_005
                    leas      $02,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
Text_002            fcc       "Usage is: Suser <number> [progname]" ; store literal character data
                    fcb       $00       ; store byte data
Text_003            fcc       "Sorry, you cannot change the user number" ; store literal character data
                    fcb       $00       ; store byte data
Data_002            fcb       $20       ; store byte data
                    fcb       $00       ; store byte data
Data_003            fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Text_004            fcc       "Shell" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Data_004            fcb       $25       ; store byte data
                    fcb       $73       ; store byte data
                    fcb       $0D       ; store byte data
                    fcb       $00       ; store byte data
Routine_014         pshs      u         ; save u on the stack
                    leax      >$001B,y  ; form the address >$001B,y in x
                    stx       >$01AF,y  ; store x at >$01AF,y
                    leax      $06,s     ; form the address $06,s in x
                    pshs      x         ; save x on the stack
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    bra       Branch_024 ; continue execution at Branch_024
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
Branch_024          pshs      d         ; save d on the stack
                    leax      >Data_005,pc ; form the address >Data_005,pc in x
                    pshs      x         ; save x on the stack
                    bsr       Routine_015 ; call subroutine Routine_015
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
Routine_015         pshs      u         ; save u on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    leas      -$0B,s    ; adjust the system stack pointer
                    bra       Branch_025 ; continue execution at Branch_025
Branch_026          ldb       $08,s     ; load b from the current stack frame at $08,s
                    lbeq      Branch_027 ; branch when the values are equal or the result is zero; target Branch_027
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    jsr       [<$11,s]  ; call subroutine [<$11,s]
                    leas      $02,s     ; adjust the system stack pointer
Branch_025          ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    cmpb      #37       ; compare b with #37 and set the condition codes
                    bne       Branch_026 ; branch when the values differ or the result is nonzero; target Branch_026
                    ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       $02,s     ; store d in the current stack frame at $02,s
                    std       $06,s     ; store d in the current stack frame at $06,s
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    cmpb      #45       ; compare b with #45 and set the condition codes
                    bne       Branch_028 ; branch when the values differ or the result is nonzero; target Branch_028
                    ldd       #1        ; set d to the constant 1
                    std       >$01C5,y  ; store d at >$01C5,y
                    ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    bra       Branch_029 ; continue execution at Branch_029
Branch_028          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       >$01C5,y  ; store d at >$01C5,y
Branch_029          ldb       $08,s     ; load b from the current stack frame at $08,s
                    cmpb      #48       ; compare b with #48 and set the condition codes
                    bne       Branch_030 ; branch when the values differ or the result is nonzero; target Branch_030
                    ldd       #48       ; set d to the constant 48
                    bra       Branch_031 ; continue execution at Branch_031
Branch_030          ldd       #32       ; set d to the constant 32
Branch_031          std       >$01C7,y  ; store d at >$01C7,y
                    bra       Branch_032 ; continue execution at Branch_032
Branch_033          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    lbsr      Routine_016 ; call subroutine Routine_016
                    pshs      d         ; save d on the stack
                    ldb       $0A,s     ; load b from the current stack frame at $0A,s
                    sex                 ; sign-extend b into d
                    addd      #-48      ; add to d using #-48
                    addd      ,s++      ; add to d using ,s++
                    std       $06,s     ; store d in the current stack frame at $06,s
                    ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
Branch_032          ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
                    leax      >$00DF,y  ; form the address >$00DF,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       ,x        ; load b from ,x
                    clra                ; clear a to zero and set the condition codes
                    andb      #8        ; mask b using #8
                    bne       Branch_033 ; branch when the values differ or the result is nonzero; target Branch_033
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    cmpb      #46       ; compare b with #46 and set the condition codes
                    bne       Branch_034 ; branch when the values differ or the result is nonzero; target Branch_034
                    ldd       #1        ; set d to the constant 1
                    std       $04,s     ; store d in the current stack frame at $04,s
                    bra       Branch_035 ; continue execution at Branch_035
Branch_036          ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    lbsr      Routine_016 ; call subroutine Routine_016
                    pshs      d         ; save d on the stack
                    ldb       $0A,s     ; load b from the current stack frame at $0A,s
                    sex                 ; sign-extend b into d
                    addd      #-48      ; add to d using #-48
                    addd      ,s++      ; add to d using ,s++
                    std       $02,s     ; store d in the current stack frame at $02,s
Branch_035          ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
                    leax      >$00DF,y  ; form the address >$00DF,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       ,x        ; load b from ,x
                    clra                ; clear a to zero and set the condition codes
                    andb      #8        ; mask b using #8
                    bne       Branch_036 ; branch when the values differ or the result is nonzero; target Branch_036
                    bra       Branch_037 ; continue execution at Branch_037
Branch_034          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       $04,s     ; store d in the current stack frame at $04,s
Branch_037          ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; copy the register values specified by d,x
                    lbra      Branch_038 ; continue execution at Branch_038
Branch_039          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldx       <$0015,s  ; load x from the current stack frame at <$0015,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0015,s  ; store x in the current stack frame at <$0015,s
                    ldd       -$02,x    ; load d from -$02,x
                    pshs      d         ; save d on the stack
                    lbsr      Routine_017 ; call subroutine Routine_017
                    bra       Branch_040 ; continue execution at Branch_040
Branch_041          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldx       <$0015,s  ; load x from the current stack frame at <$0015,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0015,s  ; store x in the current stack frame at <$0015,s
                    ldd       -$02,x    ; load d from -$02,x
                    pshs      d         ; save d on the stack
                    lbsr      Routine_018 ; call subroutine Routine_018
Branch_040          std       ,s        ; store d in the current stack frame at ,s
                    lbra      Branch_042 ; continue execution at Branch_042
Branch_043          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldb       $0A,s     ; load b from the current stack frame at $0A,s
                    sex                 ; sign-extend b into d
                    leax      >$00DF,y  ; form the address >$00DF,y in x
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
                    lbsr      Routine_019 ; call subroutine Routine_019
                    lbra      Branch_044 ; continue execution at Branch_044
Branch_045          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldx       <$0015,s  ; load x from the current stack frame at <$0015,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0015,s  ; store x in the current stack frame at <$0015,s
                    ldd       -$02,x    ; load d from -$02,x
                    pshs      d         ; save d on the stack
                    leax      >$01B1,y  ; form the address >$01B1,y in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_020 ; call subroutine Routine_020
                    lbra      Branch_044 ; continue execution at Branch_044
Branch_046          ldd       $04,s     ; load d from the current stack frame at $04,s
                    bne       Branch_047 ; branch when the values differ or the result is nonzero; target Branch_047
                    ldd       #6        ; set d to the constant 6
                    std       $02,s     ; store d in the current stack frame at $02,s
Branch_047          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    leax      <$0015,s  ; form the address <$0015,s in x
                    pshs      x         ; save x on the stack
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldb       $0E,s     ; load b from the current stack frame at $0E,s
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    lbsr      Routine_021 ; call subroutine Routine_021
                    leas      $06,s     ; adjust the system stack pointer
                    lbra      Branch_048 ; continue execution at Branch_048
Branch_049          ldx       <$0013,s  ; load x from the current stack frame at <$0013,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0013,s  ; store x in the current stack frame at <$0013,s
                    ldd       -$02,x    ; load d from -$02,x
                    lbra      Branch_050 ; continue execution at Branch_050
Branch_051          ldx       <$0013,s  ; load x from the current stack frame at <$0013,s
                    leax      $02,x     ; form the address $02,x in x
                    stx       <$0013,s  ; store x in the current stack frame at <$0013,s
                    ldd       -$02,x    ; load d from -$02,x
                    std       $09,s     ; store d in the current stack frame at $09,s
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    beq       Branch_052 ; branch when the values are equal or the result is zero; target Branch_052
                    ldd       $09,s     ; load d from the current stack frame at $09,s
                    std       $04,s     ; store d in the current stack frame at $04,s
                    bra       Branch_053 ; continue execution at Branch_053
Branch_054          ldb       [<$09,s]  ; load b from the current stack frame at [<$09,s]
                    beq       Branch_055 ; branch when the values are equal or the result is zero; target Branch_055
                    ldd       $09,s     ; load d from the current stack frame at $09,s
                    addd      #1        ; add to d using #1
                    std       $09,s     ; store d in the current stack frame at $09,s
Branch_053          ldd       $02,s     ; load d from the current stack frame at $02,s
                    addd      #-1       ; add to d using #-1
                    std       $02,s     ; store d in the current stack frame at $02,s
                    subd      #-1       ; subtract from d using #-1
                    bne       Branch_054 ; branch when the values differ or the result is nonzero; target Branch_054
Branch_055          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       $0B,s     ; load d from the current stack frame at $0B,s
                    subd      $06,s     ; subtract from d using $06,s
                    pshs      d         ; save d on the stack
                    ldd       $08,s     ; load d from the current stack frame at $08,s
                    pshs      d         ; save d on the stack
                    ldd       <$0015,s  ; load d from the current stack frame at <$0015,s
                    pshs      d         ; save d on the stack
                    lbsr      Routine_022 ; call subroutine Routine_022
                    leas      $08,s     ; adjust the system stack pointer
                    bra       Branch_056 ; continue execution at Branch_056
Branch_052          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       $0B,s     ; load d from the current stack frame at $0B,s
                    bra       Branch_048 ; continue execution at Branch_048
Branch_057          ldb       ,u+       ; load b from ,u+
                    stb       $08,s     ; store b in the current stack frame at $08,s
                    bra       Branch_058 ; continue execution at Branch_058
                    fcb       $32       ; store byte data
                    fcb       $15       ; store byte data
Branch_058          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    leax      <$0015,s  ; form the address <$0015,s in x
                    pshs      x         ; save x on the stack
                    ldb       $0C,s     ; load b from the current stack frame at $0C,s
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    lbsr      Routine_023 ; call subroutine Routine_023
Branch_044          leas      $04,s     ; adjust the system stack pointer
Branch_048          pshs      d         ; save d on the stack
Branch_042          ldd       <$0013,s  ; load d from the current stack frame at <$0013,s
                    pshs      d         ; save d on the stack
                    lbsr      Routine_024 ; call subroutine Routine_024
                    leas      $06,s     ; adjust the system stack pointer
Branch_056          lbra      Branch_025 ; continue execution at Branch_025
Branch_059          ldb       $08,s     ; load b from the current stack frame at $08,s
                    sex                 ; sign-extend b into d
Branch_050          pshs      d         ; save d on the stack
                    jsr       [<$11,s]  ; call subroutine [<$11,s]
                    leas      $02,s     ; adjust the system stack pointer
                    lbra      Branch_025 ; continue execution at Branch_025
Branch_038          cmpx      #100      ; compare x with #100 and set the condition codes
                    lbeq      Branch_039 ; branch when the values are equal or the result is zero; target Branch_039
                    cmpx      #111      ; compare x with #111 and set the condition codes
                    lbeq      Branch_041 ; branch when the values are equal or the result is zero; target Branch_041
                    cmpx      #120      ; compare x with #120 and set the condition codes
                    lbeq      Branch_043 ; branch when the values are equal or the result is zero; target Branch_043
                    cmpx      #88       ; compare x with #88 and set the condition codes
                    lbeq      Branch_043 ; branch when the values are equal or the result is zero; target Branch_043
                    cmpx      #117      ; compare x with #117 and set the condition codes
                    lbeq      Branch_045 ; branch when the values are equal or the result is zero; target Branch_045
                    cmpx      #102      ; compare x with #102 and set the condition codes
                    lbeq      Branch_046 ; branch when the values are equal or the result is zero; target Branch_046
                    cmpx      #101      ; compare x with #101 and set the condition codes
                    lbeq      Branch_046 ; branch when the values are equal or the result is zero; target Branch_046
                    cmpx      #103      ; compare x with #103 and set the condition codes
                    lbeq      Branch_046 ; branch when the values are equal or the result is zero; target Branch_046
                    cmpx      #69       ; compare x with #69 and set the condition codes
                    lbeq      Branch_046 ; branch when the values are equal or the result is zero; target Branch_046
                    cmpx      #71       ; compare x with #71 and set the condition codes
                    lbeq      Branch_046 ; branch when the values are equal or the result is zero; target Branch_046
                    cmpx      #99       ; compare x with #99 and set the condition codes
                    lbeq      Branch_049 ; branch when the values are equal or the result is zero; target Branch_049
                    cmpx      #115      ; compare x with #115 and set the condition codes
                    lbeq      Branch_051 ; branch when the values are equal or the result is zero; target Branch_051
                    cmpx      #108      ; compare x with #108 and set the condition codes
                    lbeq      Branch_057 ; branch when the values are equal or the result is zero; target Branch_057
                    bra       Branch_059 ; continue execution at Branch_059
Branch_027          leas      $0B,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_017         pshs      u,d       ; save u,d on the stack
                    leax      >$01B1,y  ; form the address >$01B1,y in x
                    stx       ,s        ; store x in the current stack frame at ,s
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    bge       Branch_060 ; branch when the signed value is greater than or equal; target Branch_060
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    nega                ; negate a
                    negb                ; negate b
                    sbca      #0        ; subtract with borrow from a using #0
                    std       $06,s     ; store d in the current stack frame at $06,s
                    bge       Branch_061 ; branch when the signed value is greater than or equal; target Branch_061
                    leax      >Text_005,pc ; form the address >Text_005,pc in x
                    pshs      x         ; save x on the stack
                    leax      >$01B1,y  ; form the address >$01B1,y in x
                    pshs      x         ; save x on the stack
                    lbsr      Routine_025 ; call subroutine Routine_025
                    leas      $04,s     ; adjust the system stack pointer
                    lbra      Branch_062 ; continue execution at Branch_062
Branch_061          ldd       #45       ; set d to the constant 45
                    ldx       ,s        ; load x from the current stack frame at ,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       ,s        ; store x in the current stack frame at ,s
                    stb       -$01,x    ; store b at -$01,x
Branch_060          ldd       $06,s     ; load d from the current stack frame at $06,s
                    pshs      d         ; save d on the stack
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    bsr       Routine_020 ; call subroutine Routine_020
                    leas      $04,s     ; adjust the system stack pointer
                    lbra      Branch_063 ; continue execution at Branch_063
Routine_020         pshs      u,y,x,d   ; save u,y,x,d on the stack
                    ldu       $0A,s     ; load u from the current stack frame at $0A,s
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       $02,s     ; store d in the current stack frame at $02,s
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       ,s        ; store d in the current stack frame at ,s
                    bra       Branch_064 ; continue execution at Branch_064
Branch_065          ldd       ,s        ; load d from the current stack frame at ,s
                    addd      #1        ; add to d using #1
                    std       ,s        ; store d in the current stack frame at ,s
                    ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    subd      >$0001,y  ; subtract from d using >$0001,y
                    std       $0C,s     ; store d in the current stack frame at $0C,s
Branch_064          ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    blt       Branch_065 ; branch when the signed value is less; target Branch_065
                    leax      >$0001,y  ; form the address >$0001,y in x
                    stx       $04,s     ; store x in the current stack frame at $04,s
                    bra       Branch_066 ; continue execution at Branch_066
Branch_067          ldd       ,s        ; load d from the current stack frame at ,s
                    addd      #1        ; add to d using #1
                    std       ,s        ; store d in the current stack frame at ,s
Branch_068          ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    subd      [<$04,s]  ; subtract from d using [<$04,s]
                    std       $0C,s     ; store d in the current stack frame at $0C,s
                    bge       Branch_067 ; branch when the signed value is greater than or equal; target Branch_067
                    ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    addd      [<$04,s]  ; add to d using [<$04,s]
                    std       $0C,s     ; store d in the current stack frame at $0C,s
                    ldd       ,s        ; load d from the current stack frame at ,s
                    beq       Branch_069 ; branch when the values are equal or the result is zero; target Branch_069
                    ldd       #1        ; set d to the constant 1
                    std       $02,s     ; store d in the current stack frame at $02,s
Branch_069          ldd       $02,s     ; load d from the current stack frame at $02,s
                    beq       Branch_070 ; branch when the values are equal or the result is zero; target Branch_070
                    ldd       ,s        ; load d from the current stack frame at ,s
                    addd      #48       ; add to d using #48
                    stb       ,u+       ; store b at ,u+
Branch_070          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       ,s        ; store d in the current stack frame at ,s
                    ldd       $04,s     ; load d from the current stack frame at $04,s
                    addd      #2        ; add to d using #2
                    std       $04,s     ; store d in the current stack frame at $04,s
Branch_066          ldd       $04,s     ; load d from the current stack frame at $04,s
                    cmpd      >$0009,y  ; compare d with >$0009,y and set the condition codes
                    bne       Branch_068 ; branch when the values differ or the result is nonzero; target Branch_068
                    ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    addd      #48       ; add to d using #48
                    stb       ,u+       ; store b at ,u+
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       WorkByte_001,u ; store b at WorkByte_001,u
                    ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    leas      $06,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_018         pshs      u,d       ; save u,d on the stack
                    leax      >$01B1,y  ; form the address >$01B1,y in x
                    stx       ,s        ; store x in the current stack frame at ,s
                    leau      >$01BB,y  ; form the workspace or data address >$01BB,y in u
Branch_071          ldd       $06,s     ; load d from the current stack frame at $06,s
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
                    bne       Branch_071 ; branch when the values differ or the result is nonzero; target Branch_071
                    bra       Branch_072 ; continue execution at Branch_072
Branch_073          ldb       WorkByte_001,u ; load b from WorkByte_001,u
                    ldx       ,s        ; load x from the current stack frame at ,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       ,s        ; store x in the current stack frame at ,s
                    stb       -$01,x    ; store b at -$01,x
Branch_072          leau      -$01,u    ; form the workspace or data address -$01,u in u
                    pshs      u         ; save u on the stack
                    leax      >$01BB,y  ; form the address >$01BB,y in x
                    cmpx      ,s++      ; compare x with ,s++ and set the condition codes
                    bls       Branch_073 ; branch when the unsigned value is lower or equal; target Branch_073
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       [,s]      ; store b in the current stack frame at [,s]
Branch_063          leax      >$01B1,y  ; form the address >$01B1,y in x
                    tfr       x,d       ; copy the register values specified by x,d
Branch_062          leas      $02,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_019         pshs      u,x,d     ; save u,x,d on the stack
                    leax      >$01B1,y  ; form the address >$01B1,y in x
                    stx       $02,s     ; store x in the current stack frame at $02,s
                    leau      >$01BB,y  ; form the workspace or data address >$01BB,y in u
Branch_074          ldd       $08,s     ; load d from the current stack frame at $08,s
                    clra                ; clear a to zero and set the condition codes
                    andb      #15       ; mask b using #15
                    std       ,s        ; store d in the current stack frame at ,s
                    pshs      d         ; save d on the stack
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    cmpd      #9        ; compare d with #9 and set the condition codes
                    ble       Branch_075 ; branch when the signed value is less than or equal; target Branch_075
                    ldd       $0C,s     ; load d from the current stack frame at $0C,s
                    beq       Branch_076 ; branch when the values are equal or the result is zero; target Branch_076
                    ldd       #65       ; set d to the constant 65
                    bra       Branch_077 ; continue execution at Branch_077
Branch_076          ldd       #97       ; set d to the constant 97
Branch_077          addd      #-10      ; add to d using #-10
                    bra       Branch_078 ; continue execution at Branch_078
Branch_075          ldd       #48       ; set d to the constant 48
Branch_078          addd      ,s++      ; add to d using ,s++
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
                    bne       Branch_074 ; branch when the values differ or the result is nonzero; target Branch_074
                    bra       Branch_079 ; continue execution at Branch_079
Branch_080          ldb       WorkByte_001,u ; load b from WorkByte_001,u
                    ldx       $02,s     ; load x from the current stack frame at $02,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       $02,s     ; store x in the current stack frame at $02,s
                    stb       -$01,x    ; store b at -$01,x
Branch_079          leau      -$01,u    ; form the workspace or data address -$01,u in u
                    pshs      u         ; save u on the stack
                    leax      >$01BB,y  ; form the address >$01BB,y in x
                    cmpx      ,s++      ; compare x with ,s++ and set the condition codes
                    bls       Branch_080 ; branch when the unsigned value is lower or equal; target Branch_080
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    stb       [<$02,s]  ; store b in the current stack frame at [<$02,s]
                    leax      >$01B1,y  ; form the address >$01B1,y in x
                    tfr       x,d       ; copy the register values specified by x,d
                    lbra      Branch_081 ; continue execution at Branch_081
Routine_022         pshs      u         ; save u on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    subd      $08,s     ; subtract from d using $08,s
                    std       $0A,s     ; store d in the current stack frame at $0A,s
                    ldd       >$01C5,y  ; load d from >$01C5,y
                    bne       Branch_082 ; branch when the values differ or the result is nonzero; target Branch_082
                    bra       Branch_083 ; continue execution at Branch_083
Branch_084          ldd       >$01C7,y  ; load d from >$01C7,y
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
Branch_083          ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    addd      #-1       ; add to d using #-1
                    std       $0A,s     ; store d in the current stack frame at $0A,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       Branch_084 ; branch when the signed value is greater; target Branch_084
                    bra       Branch_082 ; continue execution at Branch_082
Branch_085          ldb       ,u+       ; load b from ,u+
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
Branch_082          ldd       $08,s     ; load d from the current stack frame at $08,s
                    addd      #-1       ; add to d using #-1
                    std       $08,s     ; store d in the current stack frame at $08,s
                    subd      #-1       ; subtract from d using #-1
                    bne       Branch_085 ; branch when the values differ or the result is nonzero; target Branch_085
                    ldd       >$01C5,y  ; load d from >$01C5,y
                    beq       Branch_086 ; branch when the values are equal or the result is zero; target Branch_086
                    bra       Branch_087 ; continue execution at Branch_087
Branch_088          ldd       >$01C7,y  ; load d from >$01C7,y
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
Branch_087          ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    addd      #-1       ; add to d using #-1
                    std       $0A,s     ; store d in the current stack frame at $0A,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       Branch_088 ; branch when the signed value is greater; target Branch_088
Branch_086          puls      pc,u      ; restore pc,u and return to the caller
Routine_024         pshs      u         ; save u on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    ldd       $08,s     ; load d from the current stack frame at $08,s
                    pshs      d         ; save d on the stack
                    pshs      u         ; save u on the stack
                    lbsr      Routine_012 ; call subroutine Routine_012
                    leas      $02,s     ; adjust the system stack pointer
                    nega                ; negate a
                    negb                ; negate b
                    sbca      #0        ; subtract with borrow from a using #0
                    addd      ,s++      ; add to d using ,s++
                    std       $08,s     ; store d in the current stack frame at $08,s
                    ldd       >$01C5,y  ; load d from >$01C5,y
                    bne       Branch_089 ; branch when the values differ or the result is nonzero; target Branch_089
                    bra       Branch_090 ; continue execution at Branch_090
Branch_091          ldd       >$01C7,y  ; load d from >$01C7,y
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
Branch_090          ldd       $08,s     ; load d from the current stack frame at $08,s
                    addd      #-1       ; add to d using #-1
                    std       $08,s     ; store d in the current stack frame at $08,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       Branch_091 ; branch when the signed value is greater; target Branch_091
                    bra       Branch_089 ; continue execution at Branch_089
Branch_092          ldb       ,u+       ; load b from ,u+
                    sex                 ; sign-extend b into d
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
Branch_089          ldb       WorkByte_001,u ; load b from WorkByte_001,u
                    bne       Branch_092 ; branch when the values differ or the result is nonzero; target Branch_092
                    ldd       >$01C5,y  ; load d from >$01C5,y
                    beq       Branch_093 ; branch when the values are equal or the result is zero; target Branch_093
                    bra       Branch_094 ; continue execution at Branch_094
Branch_095          ldd       >$01C7,y  ; load d from >$01C7,y
                    pshs      d         ; save d on the stack
                    jsr       [<$06,s]  ; call subroutine [<$06,s]
                    leas      $02,s     ; adjust the system stack pointer
Branch_094          ldd       $08,s     ; load d from the current stack frame at $08,s
                    addd      #-1       ; add to d using #-1
                    std       $08,s     ; store d in the current stack frame at $08,s
                    subd      #-1       ; subtract from d using #-1
                    bgt       Branch_095 ; branch when the signed value is greater; target Branch_095
Branch_093          puls      pc,u      ; restore pc,u and return to the caller
Data_005            fcb       $34       ; store byte data
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
Branch_081          leas      $04,s     ; adjust the system stack pointer
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
Text_005            fcc       "-32768" ; store literal character data
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
Routine_026         pshs      u,d       ; save u,d on the stack
                    leau      >$000E,y  ; form the workspace or data address >$000E,y in u
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       ,s        ; store d in the current stack frame at ,s
                    bra       Branch_096 ; continue execution at Branch_096
Branch_097          tfr       u,d       ; copy the register values specified by u,d
                    leau      WorkBuffer_001,u ; form the workspace or data address WorkBuffer_001,u in u
                    pshs      d         ; save d on the stack
                    bsr       Routine_027 ; call subroutine Routine_027
                    leas      $02,s     ; adjust the system stack pointer
Branch_096          ldd       ,s        ; load d from the current stack frame at ,s
                    addd      #1        ; add to d using #1
                    std       ,s        ; store d in the current stack frame at ,s
                    subd      #1        ; subtract from d using #1
                    cmpd      #16       ; compare d with #16 and set the condition codes
                    blt       Branch_097 ; branch when the signed value is less; target Branch_097
                    lbra      Branch_098 ; continue execution at Branch_098
Routine_027         pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    leas      -$02,s    ; adjust the system stack pointer
                    cmpu      #0        ; compare u with #0 and set the condition codes
                    beq       Branch_099 ; branch when the values are equal or the result is zero; target Branch_099
                    ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    bne       Branch_100 ; branch when the values differ or the result is nonzero; target Branch_100
Branch_099          ldd       #-1       ; set d to the constant -1
                    lbra      Branch_098 ; continue execution at Branch_098
Branch_100          ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #2        ; mask b using #2
                    beq       Branch_101 ; branch when the values are equal or the result is zero; target Branch_101
                    pshs      u         ; save u on the stack
                    bsr       Routine_028 ; call subroutine Routine_028
                    leas      $02,s     ; adjust the system stack pointer
                    bra       Branch_102 ; continue execution at Branch_102
Branch_101          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
Branch_102          std       ,s        ; store d in the current stack frame at ,s
                    ldd       WorkByte_003,u ; load d from WorkByte_003,u
                    pshs      d         ; save d on the stack
                    lbsr      Routine_029 ; call subroutine Routine_029
                    leas      $02,s     ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       WorkWord_003,u ; store d at WorkWord_003,u
                    ldd       ,s        ; load d from the current stack frame at ,s
                    bra       Branch_098 ; continue execution at Branch_098
Routine_028         pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    beq       Branch_103 ; branch when the values are equal or the result is zero; target Branch_103
                    ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #34       ; mask b using #34
                    cmpd      #2        ; compare d with #2 and set the condition codes
                    beq       Branch_104 ; branch when the values are equal or the result is zero; target Branch_104
Branch_103          ldd       #-1       ; set d to the constant -1
                    puls      pc,u      ; restore pc,u and return to the caller
Branch_104          ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    anda      #128      ; mask a using #128
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    bne       Branch_105 ; branch when the values differ or the result is nonzero; target Branch_105
                    pshs      u         ; save u on the stack
                    lbsr      Routine_030 ; call subroutine Routine_030
                    leas      $02,s     ; adjust the system stack pointer
Branch_105          pshs      u         ; save u on the stack
                    bsr       Routine_031 ; call subroutine Routine_031
Branch_098          leas      $02,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_031         pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    leas      -$04,s    ; adjust the system stack pointer
                    ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    anda      #1        ; mask a using #1
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    bne       Branch_106 ; branch when the values differ or the result is nonzero; target Branch_106
                    ldd       WorkByte_001,u ; load d from WorkByte_001,u
                    cmpd      WorkWord_002,u ; compare d with WorkWord_002,u and set the condition codes
                    beq       Branch_106 ; branch when the values are equal or the result is zero; target Branch_106
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    pshs      u         ; save u on the stack
                    lbsr      Routine_032 ; call subroutine Routine_032
                    leas      $02,s     ; adjust the system stack pointer
                    ldd       $02,x     ; load d from $02,x
                    pshs      d         ; save d on the stack
                    ldd       ,x        ; load d from ,x
                    pshs      d         ; save d on the stack
                    ldd       WorkByte_003,u ; load d from WorkByte_003,u
                    pshs      d         ; save d on the stack
                    lbsr      Routine_033 ; call subroutine Routine_033
                    leas      $08,s     ; adjust the system stack pointer
Branch_106          ldd       WorkByte_001,u ; load d from WorkByte_001,u
                    subd      WorkWord_001,u ; subtract from d using WorkWord_001,u
                    std       $02,s     ; store d in the current stack frame at $02,s
                    lbeq      Branch_107 ; branch when the values are equal or the result is zero; target Branch_107
                    ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    anda      #1        ; mask a using #1
                    clrb                ; clear b to zero and set the condition codes
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    lbeq      Branch_107 ; branch when the values are equal or the result is zero; target Branch_107
                    ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #64       ; mask b using #64
                    beq       Branch_108 ; branch when the values are equal or the result is zero; target Branch_108
                    ldd       WorkWord_001,u ; load d from WorkWord_001,u
                    bra       Branch_109 ; continue execution at Branch_109
Branch_110          ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    ldd       WorkByte_001,u ; load d from WorkByte_001,u
                    pshs      d         ; save d on the stack
                    ldd       WorkByte_003,u ; load d from WorkByte_003,u
                    pshs      d         ; save d on the stack
                    lbsr      Routine_034 ; call subroutine Routine_034
                    leas      $06,s     ; adjust the system stack pointer
                    std       ,s        ; store d in the current stack frame at ,s
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    bne       Branch_111 ; branch when the values differ or the result is nonzero; target Branch_111
                    leax      $04,s     ; form the address $04,s in x
                    bra       Branch_112 ; continue execution at Branch_112
Branch_111          ldd       $02,s     ; load d from the current stack frame at $02,s
                    subd      ,s        ; subtract from d using ,s
                    std       $02,s     ; store d in the current stack frame at $02,s
                    ldd       WorkByte_001,u ; load d from WorkByte_001,u
                    addd      ,s        ; add to d using ,s
Branch_109          std       WorkByte_001,u ; store d at WorkByte_001,u
                    ldd       $02,s     ; load d from the current stack frame at $02,s
                    bne       Branch_110 ; branch when the values differ or the result is nonzero; target Branch_110
                    bra       Branch_107 ; continue execution at Branch_107
Branch_108          ldd       $02,s     ; load d from the current stack frame at $02,s
                    pshs      d         ; save d on the stack
                    ldd       WorkWord_001,u ; load d from WorkWord_001,u
                    pshs      d         ; save d on the stack
                    ldd       WorkByte_003,u ; load d from WorkByte_003,u
                    pshs      d         ; save d on the stack
                    lbsr      Routine_035 ; call subroutine Routine_035
                    leas      $06,s     ; adjust the system stack pointer
                    cmpd      $02,s     ; compare d with $02,s and set the condition codes
                    beq       Branch_107 ; branch when the values are equal or the result is zero; target Branch_107
                    bra       Branch_113 ; continue execution at Branch_113
Branch_112          leas      -$04,x    ; adjust the system stack pointer
Branch_113          ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    orb       #32       ; set selected bits in b using #32
                    std       WorkWord_003,u ; store d at WorkWord_003,u
                    ldd       WorkWord_002,u ; load d from WorkWord_002,u
                    std       WorkByte_001,u ; store d at WorkByte_001,u
                    ldd       #-1       ; set d to the constant -1
                    bra       Branch_114 ; continue execution at Branch_114
Branch_107          ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    ora       #1        ; set selected bits in a using #1
                    std       WorkWord_003,u ; store d at WorkWord_003,u
                    ldd       WorkWord_001,u ; load d from WorkWord_001,u
                    std       WorkByte_001,u ; store d at WorkByte_001,u
                    addd      WorkWord_004,u ; add to d using WorkWord_004,u
                    std       WorkWord_002,u ; store d at WorkWord_002,u
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
Branch_114          leas      $04,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_032         pshs      u         ; save u on the stack
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_030         pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #192      ; mask b using #192
                    bne       Branch_115 ; branch when the values differ or the result is nonzero; target Branch_115
                    leas      -$20,s    ; adjust the system stack pointer
                    leax      ,s        ; form the address ,s in x
                    pshs      x         ; save x on the stack
                    ldd       WorkByte_003,u ; load d from WorkByte_003,u
                    pshs      d         ; save d on the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      d         ; save d on the stack
                    lbsr      Routine_036 ; call subroutine Routine_036
                    leas      $06,s     ; adjust the system stack pointer
                    ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    pshs      d         ; save d on the stack
                    ldb       $02,s     ; load b from the current stack frame at $02,s
                    bne       Branch_116 ; branch when the values differ or the result is nonzero; target Branch_116
                    ldd       #64       ; set d to the constant 64
                    bra       Branch_117 ; continue execution at Branch_117
Branch_116          ldd       #128      ; set d to the constant 128
Branch_117          ora       ,s+       ; set selected bits in a using ,s+
                    orb       ,s+       ; set selected bits in b using ,s+
                    std       WorkWord_003,u ; store d at WorkWord_003,u
                    leas      <$0020,s  ; adjust the system stack pointer
Branch_115          ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    ora       #128      ; set selected bits in a using #128
                    std       WorkWord_003,u ; store d at WorkWord_003,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #12       ; mask b using #12
                    beq       Branch_118 ; branch when the values are equal or the result is zero; target Branch_118
                    puls      pc,u      ; restore pc,u and return to the caller
Branch_118          ldd       WorkWord_004,u ; load d from WorkWord_004,u
                    bne       Branch_119 ; branch when the values differ or the result is nonzero; target Branch_119
                    ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    clra                ; clear a to zero and set the condition codes
                    andb      #64       ; mask b using #64
                    beq       Branch_120 ; branch when the values are equal or the result is zero; target Branch_120
                    ldd       #128      ; set d to the constant 128
                    bra       Branch_121 ; continue execution at Branch_121
Branch_120          ldd       #256      ; set d to the constant 256
Branch_121          std       WorkWord_004,u ; store d at WorkWord_004,u
Branch_119          ldd       WorkWord_001,u ; load d from WorkWord_001,u
                    bne       Branch_122 ; branch when the values differ or the result is nonzero; target Branch_122
                    ldd       WorkWord_004,u ; load d from WorkWord_004,u
                    pshs      d         ; save d on the stack
                    lbsr      Routine_037 ; call subroutine Routine_037
                    leas      $02,s     ; adjust the system stack pointer
                    std       WorkWord_001,u ; store d at WorkWord_001,u
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    beq       Branch_123 ; branch when the values are equal or the result is zero; target Branch_123
Branch_122          ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    orb       #8        ; set selected bits in b using #8
                    std       WorkWord_003,u ; store d at WorkWord_003,u
                    bra       Branch_124 ; continue execution at Branch_124
Branch_123          ldd       WorkWord_003,u ; load d from WorkWord_003,u
                    orb       #4        ; set selected bits in b using #4
                    std       WorkWord_003,u ; store d at WorkWord_003,u
                    leax      WorkByte_005,u ; form the address WorkByte_005,u in x
                    stx       WorkWord_001,u ; store x at WorkWord_001,u
                    ldd       #1        ; set d to the constant 1
                    std       WorkWord_004,u ; store d at WorkWord_004,u
Branch_124          ldd       WorkWord_001,u ; load d from WorkWord_001,u
                    addd      WorkWord_004,u ; add to d using WorkWord_004,u
                    std       WorkWord_002,u ; store d at WorkWord_002,u
                    std       WorkByte_001,u ; store d at WorkByte_001,u
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_023         pshs      u         ; save u on the stack
                    ldb       $05,s     ; load b from the current stack frame at $05,s
                    sex                 ; sign-extend b into d
                    tfr       d,x       ; copy the register values specified by d,x
                    bra       Branch_125 ; continue execution at Branch_125
Branch_126          ldd       [<$06,s]  ; load d from the current stack frame at [<$06,s]
                    addd      #4        ; add to d using #4
                    std       [<$06,s]  ; store d in the current stack frame at [<$06,s]
                    leax      >Data_006,pc ; form the address >Data_006,pc in x
                    bra       Branch_127 ; continue execution at Branch_127
Branch_128          ldb       $05,s     ; load b from the current stack frame at $05,s
                    stb       >$000C,y  ; store b at >$000C,y
                    leax      >$000B,y  ; form the address >$000B,y in x
Branch_127          tfr       x,d       ; copy the register values specified by x,d
                    puls      pc,u      ; restore pc,u and return to the caller
Branch_125          cmpx      #100      ; compare x with #100 and set the condition codes
                    beq       Branch_126 ; branch when the values are equal or the result is zero; target Branch_126
                    cmpx      #111      ; compare x with #111 and set the condition codes
                    lbeq      Branch_126 ; branch when the values are equal or the result is zero; target Branch_126
                    cmpx      #120      ; compare x with #120 and set the condition codes
                    lbeq      Branch_126 ; branch when the values are equal or the result is zero; target Branch_126
                    bra       Branch_128 ; continue execution at Branch_128
                    fcb       $35       ; store byte data
                    fcb       $C0       ; store byte data
Data_006            fcb       $00       ; store byte data
Routine_021         pshs      u         ; save u on the stack
                    leax      >Data_007,pc ; form the address >Data_007,pc in x
                    tfr       x,d       ; copy the register values specified by x,d
                    puls      pc,u      ; restore pc,u and return to the caller
Data_007            fcb       $00       ; store byte data
Routine_012         pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
Branch_129          ldb       ,u+       ; load b from ,u+
                    bne       Branch_129 ; branch when the values differ or the result is nonzero; target Branch_129
                    tfr       u,d       ; copy the register values specified by u,d
                    subd      $04,s     ; subtract from d using $04,s
                    addd      #-1       ; add to d using #-1
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_025         pshs      u         ; save u on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    leas      -$02,s    ; adjust the system stack pointer
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    std       ,s        ; store d in the current stack frame at ,s
Branch_130          ldb       ,u+       ; load b from ,u+
                    ldx       ,s        ; load x from the current stack frame at ,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       ,s        ; store x in the current stack frame at ,s
                    stb       -$01,x    ; store b at -$01,x
                    bne       Branch_130 ; branch when the values differ or the result is nonzero; target Branch_130
                    bra       Branch_131 ; continue execution at Branch_131
Routine_011         pshs      u         ; save u on the stack
                    ldu       $06,s     ; load u from the current stack frame at $06,s
                    leas      -$02,s    ; adjust the system stack pointer
                    ldd       $06,s     ; load d from the current stack frame at $06,s
                    std       ,s        ; store d in the current stack frame at ,s
Branch_132          ldx       ,s        ; load x from the current stack frame at ,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       ,s        ; store x in the current stack frame at ,s
                    ldb       -$01,x    ; load b from -$01,x
                    bne       Branch_132 ; branch when the values differ or the result is nonzero; target Branch_132
                    ldd       ,s        ; load d from the current stack frame at ,s
                    addd      #-1       ; add to d using #-1
                    std       ,s        ; store d in the current stack frame at ,s
Branch_133          ldb       ,u+       ; load b from ,u+
                    ldx       ,s        ; load x from the current stack frame at ,s
                    leax      $01,x     ; form the address $01,x in x
                    stx       ,s        ; store x in the current stack frame at ,s
                    stb       -$01,x    ; store b at -$01,x
                    bne       Branch_133 ; branch when the values differ or the result is nonzero; target Branch_133
Branch_131          ldd       $06,s     ; load d from the current stack frame at $06,s
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
Routine_009         pshs      u         ; save u on the stack
                    ldu       $04,s     ; load u from the current stack frame at $04,s
                    leas      -$05,s    ; adjust the system stack pointer
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    std       $01,s     ; store d in the current stack frame at $01,s
Branch_134          ldb       ,u+       ; load b from ,u+
                    stb       ,s        ; store b in the current stack frame at ,s
                    cmpb      #32       ; compare b with #32 and set the condition codes
                    beq       Branch_134 ; branch when the values are equal or the result is zero; target Branch_134
                    ldb       ,s        ; load b from the current stack frame at ,s
                    cmpb      #9        ; compare b with #9 and set the condition codes
                    lbeq      Branch_134 ; branch when the values are equal or the result is zero; target Branch_134
                    ldb       ,s        ; load b from the current stack frame at ,s
                    cmpb      #45       ; compare b with #45 and set the condition codes
                    bne       Branch_135 ; branch when the values differ or the result is nonzero; target Branch_135
                    ldd       #1        ; set d to the constant 1
                    bra       Branch_136 ; continue execution at Branch_136
Branch_135          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
Branch_136          std       $03,s     ; store d in the current stack frame at $03,s
                    ldb       ,s        ; load b from the current stack frame at ,s
                    cmpb      #45       ; compare b with #45 and set the condition codes
                    beq       Branch_137 ; branch when the values are equal or the result is zero; target Branch_137
                    ldb       ,s        ; load b from the current stack frame at ,s
                    cmpb      #43       ; compare b with #43 and set the condition codes
                    bne       Branch_138 ; branch when the values differ or the result is nonzero; target Branch_138
                    bra       Branch_137 ; continue execution at Branch_137
Branch_139          ldd       $01,s     ; load d from the current stack frame at $01,s
                    pshs      d         ; save d on the stack
                    ldd       #10       ; set d to the constant 10
                    lbsr      Routine_016 ; call subroutine Routine_016
                    pshs      d         ; save d on the stack
                    ldb       $02,s     ; load b from the current stack frame at $02,s
                    sex                 ; sign-extend b into d
                    addd      ,s++      ; add to d using ,s++
                    addd      #-48      ; add to d using #-48
                    std       $01,s     ; store d in the current stack frame at $01,s
Branch_137          ldb       ,u+       ; load b from ,u+
                    stb       ,s        ; store b in the current stack frame at ,s
Branch_138          ldb       ,s        ; load b from the current stack frame at ,s
                    sex                 ; sign-extend b into d
                    leax      >$00DF,y  ; form the address >$00DF,y in x
                    leax      d,x       ; form the address d,x in x
                    ldb       ,x        ; load b from ,x
                    clra                ; clear a to zero and set the condition codes
                    andb      #8        ; mask b using #8
                    bne       Branch_139 ; branch when the values differ or the result is nonzero; target Branch_139
                    ldd       $03,s     ; load d from the current stack frame at $03,s
                    beq       Branch_140 ; branch when the values are equal or the result is zero; target Branch_140
                    ldd       $01,s     ; load d from the current stack frame at $01,s
                    nega                ; negate a
                    negb                ; negate b
                    sbca      #0        ; subtract with borrow from a using #0
                    bra       Branch_141 ; continue execution at Branch_141
Branch_140          ldd       $01,s     ; load d from the current stack frame at $01,s
Branch_141          leas      $05,s     ; adjust the system stack pointer
                    puls      pc,u      ; restore pc,u and return to the caller
Routine_016         tsta                ; set condition codes from a without changing it
                    bne       Branch_142 ; branch when the values differ or the result is nonzero; target Branch_142
                    tst       $02,s     ; set condition codes from $02,s without changing it
                    bne       Branch_142 ; branch when the values differ or the result is nonzero; target Branch_142
                    lda       $03,s     ; load a from the current stack frame at $03,s
                    mul                 ; multiply a by b and return the product in d
                    ldx       ,s        ; load x from the current stack frame at ,s
                    stx       $02,s     ; store x in the current stack frame at $02,s
                    ldx       #0        ; set x to the constant 0
                    std       ,s        ; store d in the current stack frame at ,s
                    puls      pc,d      ; restore pc,d and return to the caller
Branch_142          pshs      d         ; save d on the stack
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
                    bcc       Branch_143 ; branch when carry is clear; target Branch_143
                    inc       ,s        ; increment the value at ,s
Branch_143          lda       $04,s     ; load a from the current stack frame at $04,s
                    ldb       $09,s     ; load b from the current stack frame at $09,s
                    mul                 ; multiply a by b and return the product in d
                    addd      $01,s     ; add to d using $01,s
                    std       $01,s     ; store d in the current stack frame at $01,s
                    bcc       Branch_144 ; branch when carry is clear; target Branch_144
                    inc       ,s        ; increment the value at ,s
Branch_144          lda       $04,s     ; load a from the current stack frame at $04,s
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
Routine_036         lda       $05,s     ; load a from the current stack frame at $05,s
                    ldb       $03,s     ; load b from the current stack frame at $03,s
                    beq       Branch_145 ; branch when the values are equal or the result is zero; target Branch_145
                    cmpb      #1        ; compare b with #1 and set the condition codes
                    beq       Branch_146 ; branch when the values are equal or the result is zero; target Branch_146
                    cmpb      #6        ; compare b with #6 and set the condition codes
                    beq       Branch_146 ; branch when the values are equal or the result is zero; target Branch_146
                    cmpb      #2        ; compare b with #2 and set the condition codes
                    beq       Branch_147 ; branch when the values are equal or the result is zero; target Branch_147
                    cmpb      #5        ; compare b with #5 and set the condition codes
                    beq       Branch_147 ; branch when the values are equal or the result is zero; target Branch_147
                    ldb       #208      ; set b to the constant 208
                    lbra      Branch_148 ; continue execution at Branch_148
Branch_147          pshs      u         ; save u on the stack
                    os9       I$GetStt  ; query status code B for path A
                    bcc       Branch_149 ; branch when carry is clear; target Branch_149
                    puls      u         ; restore u from the stack
                    lbra      Branch_148 ; continue execution at Branch_148
Branch_149          stx       [<$08,s]  ; store x in the current stack frame at [<$08,s]
                    ldx       $08,s     ; load x from the current stack frame at $08,s
                    stu       $02,x     ; store u at $02,x
                    puls      u         ; restore u from the stack
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    rts                 ; return to the caller
Branch_145          ldx       $06,s     ; load x from the current stack frame at $06,s
Branch_146          os9       I$GetStt  ; query status code B for path A
                    lbra      Branch_150 ; continue execution at Branch_150
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
Routine_029         lda       $03,s     ; load a from the current stack frame at $03,s
                    os9       I$Close   ; close path A
                    lbra      Branch_150 ; continue execution at Branch_150
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
Routine_035         pshs      y         ; save y on the stack
                    ldy       $08,s     ; load y from the current stack frame at $08,s
                    beq       Branch_151 ; branch when the values are equal or the result is zero; target Branch_151
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    ldx       $06,s     ; load x from the current stack frame at $06,s
                    os9       I$Write   ; write Y bytes from X to path A
Branch_152          bcc       Branch_151 ; branch when carry is clear; target Branch_151
                    puls      y         ; restore y from the stack
                    lbra      Branch_148 ; continue execution at Branch_148
Branch_151          tfr       y,d       ; copy the register values specified by y,d
                    puls      pc,y      ; restore pc,y and return to the caller
Routine_034         pshs      y         ; save y on the stack
                    ldy       $08,s     ; load y from the current stack frame at $08,s
                    beq       Branch_151 ; branch when the values are equal or the result is zero; target Branch_151
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    ldx       $06,s     ; load x from the current stack frame at $06,s
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    bra       Branch_152 ; continue execution at Branch_152
Routine_033         pshs      u         ; save u on the stack
                    ldd       $0A,s     ; load d from the current stack frame at $0A,s
                    bne       Branch_153 ; branch when the values differ or the result is nonzero; target Branch_153
                    ldu       #0        ; set u to the constant 0
                    ldx       #0        ; set x to the constant 0
                    bra       Branch_154 ; continue execution at Branch_154
Branch_153          cmpd      #1        ; compare d with #1 and set the condition codes
                    beq       Branch_155 ; branch when the values are equal or the result is zero; target Branch_155
                    cmpd      #2        ; compare d with #2 and set the condition codes
                    beq       Branch_156 ; branch when the values are equal or the result is zero; target Branch_156
                    ldb       #247      ; set b to the constant 247
Branch_157          clra                ; clear a to zero and set the condition codes
                    std       >$01AD,y  ; store d at >$01AD,y
                    ldd       #-1       ; set d to the constant -1
                    leax      >$01A1,y  ; form the address >$01A1,y in x
                    std       ,x        ; store d at ,x
                    std       $02,x     ; store d at $02,x
                    puls      pc,u      ; restore pc,u and return to the caller
Branch_156          lda       $05,s     ; load a from the current stack frame at $05,s
                    ldb       #2        ; set b to the constant 2
                    os9       I$GetStt  ; query status code B for path A
                    bcs       Branch_157 ; branch when carry reports an error or unsigned underflow; target Branch_157
                    bra       Branch_154 ; continue execution at Branch_154
Branch_155          lda       $05,s     ; load a from the current stack frame at $05,s
                    ldb       #5        ; set b to the constant 5
                    os9       I$GetStt  ; query status code B for path A
                    bcs       Branch_157 ; branch when carry reports an error or unsigned underflow; target Branch_157
Branch_154          tfr       u,d       ; copy the register values specified by u,d
                    addd      $08,s     ; add to d using $08,s
                    std       >$01A3,y  ; store d at >$01A3,y
                    tfr       d,u       ; copy the register values specified by d,u
                    tfr       x,d       ; copy the register values specified by x,d
                    adcb      $07,s     ; add with carry to b using $07,s
                    adca      $06,s     ; add with carry to a using $06,s
                    bmi       Branch_157 ; branch when the result is negative; target Branch_157
                    tfr       d,x       ; copy the register values specified by d,x
                    std       >$01A1,y  ; store d at >$01A1,y
                    lda       $05,s     ; load a from the current stack frame at $05,s
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    bcs       Branch_157 ; branch when carry reports an error or unsigned underflow; target Branch_157
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
Routine_037         ldd       $02,s     ; load d from the current stack frame at $02,s
                    addd      >$01A9,y  ; add to d using >$01A9,y
                    bcs       Branch_158 ; branch when carry reports an error or unsigned underflow; target Branch_158
                    cmpd      >$01AB,y  ; compare d with >$01AB,y and set the condition codes
                    bcc       Branch_158 ; branch when carry is clear; target Branch_158
                    pshs      d         ; save d on the stack
                    ldx       >$01A9,y  ; load x from >$01A9,y
                    clra                ; clear a to zero and set the condition codes
Branch_159          cmpx      ,s        ; compare x with ,s and set the condition codes
                    bcc       Branch_160 ; branch when carry is clear; target Branch_160
                    sta       ,x+       ; store a at ,x+
                    bra       Branch_159 ; continue execution at Branch_159
Branch_160          ldd       >$01A9,y  ; load d from >$01A9,y
                    puls      x         ; restore x from the stack
                    stx       >$01A9,y  ; store x at >$01A9,y
                    rts                 ; return to the caller
Branch_158          ldd       #-1       ; set d to the constant -1
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
Routine_013         leau      ,s        ; form the workspace or data address ,s in u
                    leas      >$00FF,y  ; adjust the system stack pointer
                    ldx       WorkWord_001,u ; load x from WorkWord_001,u
                    ldy       WorkWord_002,u ; load y from WorkWord_002,u
                    lda       WorkByte_004,u ; load a from WorkByte_004,u
                    asla                ; shift a left arithmetically
                    asla                ; shift a left arithmetically
                    asla                ; shift a left arithmetically
                    asla                ; shift a left arithmetically
                    ora       WorkWord_004,u ; set selected bits in a using WorkWord_004,u
                    ldb       WorkBuffer_001,u ; load b from WorkBuffer_001,u
                    ldu       WorkWord_003,u ; load u from WorkWord_003,u
                    os9       F$Chain   ; replace this process with the module at X
                    os9       F$Exit    ; terminate the process with status B
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
Routine_038         pshs      y         ; save y on the stack
                    os9       F$ID      ; retrieve the current process and user IDs
                    bcc       Branch_161 ; branch when carry is clear; target Branch_161
Branch_162          puls      y         ; restore y from the stack
                    lbra      Branch_148 ; continue execution at Branch_148
Branch_161          tfr       y,d       ; copy the register values specified by y,d
                    puls      pc,y      ; restore pc,y and return to the caller
Routine_010         pshs      y         ; save y on the stack
                    bsr       Routine_038 ; call subroutine Routine_038
                    std       -$02,s    ; store d in the current stack frame at -$02,s
                    beq       Branch_163 ; branch when the values are equal or the result is zero; target Branch_163
                    ldb       #214      ; set b to the constant 214
                    bra       Branch_162 ; continue execution at Branch_162
Branch_163          ldy       $04,s     ; load y from the current stack frame at $04,s
                    os9       F$SUser   ; change the process user ID to Y
                    bcc       Branch_164 ; branch when carry is clear; target Branch_164
                    cmpb      #208      ; compare b with #208 and set the condition codes
                    bne       Branch_162 ; branch when the values differ or the result is nonzero; target Branch_162
                    tfr       y,d       ; copy the register values specified by y,d
                    ldy       >Code_001 ; load y from >Code_001
                    std       $09,y     ; store d at $09,y
Branch_164          clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    puls      pc,y      ; restore pc,y and return to the caller
Branch_148          clra                ; clear a to zero and set the condition codes
                    std       >$01AD,y  ; store d at >$01AD,y
                    ldd       #-1       ; set d to the constant -1
                    rts                 ; return to the caller
Branch_150          bcs       Branch_148 ; branch when carry reports an error or unsigned underflow; target Branch_148
                    clra                ; clear a to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    rts                 ; return to the caller
Routine_005         lbsr      Code_003  ; call subroutine Code_003
                    lbsr      Routine_026 ; call subroutine Routine_026
Routine_007         ldd       $02,s     ; load d from the current stack frame at $02,s
                    os9       F$Exit    ; terminate the process with status B
Code_003            rts                 ; return to the caller
Data_001            fcb       $00       ; store byte data
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
