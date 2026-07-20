**********************************************************************
* BBS.conf - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       BBS.conf
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

U0000               rmb       2         ; reserve 2 byte(s) in the module workspace
U0002               rmb       2         ; reserve 2 byte(s) in the module workspace
U0004               rmb       2         ; reserve 2 byte(s) in the module workspace
U0006               rmb       2         ; reserve 2 byte(s) in the module workspace
U0008               rmb       2         ; reserve 2 byte(s) in the module workspace
U000A               rmb       2         ; reserve 2 byte(s) in the module workspace
U000C               rmb       200       ; reserve 200 byte(s) in the module workspace
buffer              rmb       1         ; reserve 1 byte(s) in the module workspace
U00D5               rmb       419       ; reserve 419 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.conf/ ; store an OS-9 high-bit-terminated string
confdat             fcc       "Conf.dat" ; store literal character data
L001D               fcb       $0D       ; store byte data
                    fcb       $0A       ; store byte data
handle              fcc       "Enter your handle:" ; store literal character data
prompt              fcc       "Press <CTRL><Z> to exit         <CTRL><x> who's in conf mode" ; store literal character data
                    fcb       $0D       ; store byte data
line                fcc       "------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
confwho             fcc       "BBS.conf.who" ; store literal character data
                    fcb       $0D       ; store byte data

Icpt                ldx       U0006,u   ; load x from U0006,u
L00BA               ldd       ,x++      ; load d from ,x++
                    leax      $01,x     ; form the address $01,x in x
                    cmpd      U0002,u   ; compare d with U0002,u and set the condition codes
                    bne       L00BA     ; branch when the values differ or the result is nonzero; target L00BA
                    leax      -$03,x    ; form the address -$03,x in x
                    clr       0,x       ; clear 0,x to zero and set the condition codes
                    clr       $01,x     ; clear $01,x to zero and set the condition codes
                    clrb                ; clear b to zero and set the condition codes
                    pshs      u         ; save u on the stack
                    ldu       U0004,u   ; load u from U0004,u
                    os9       F$UnLink  ; invoke the OS-9 F$UnLink service
                    puls      u         ; restore u from the stack
                    clrb                ; clear b to zero and set the condition codes
                    os9       F$Exit    ; invoke the OS-9 F$Exit service
                    fcb       $3B       ; store byte data

start               leax      >Icpt,pc  ; form the address >Icpt,pc in x
                    os9       F$Icpt    ; invoke the OS-9 F$Icpt service
                    os9       F$ID      ; invoke the OS-9 F$ID service
                    leay      $01,y     ; form the address $01,y in y
                    sty       U0002,u   ; store y at U0002,u
                    leax      >handle,pc ; form the address >handle,pc in x
                    ldy       #18       ; set y to the constant 18
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    clra                ; clear a to zero and set the condition codes
                    leax      >buffer,u ; form the address >buffer,u in x
                    ldy       #20       ; set y to the constant 20
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    leax      >prompt,pc ; form the address >prompt,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >line,pc  ; form the address >line,pc in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >confdat,pc ; form the address >confdat,pc in x
                    lda       #65       ; set a to the constant 65
                    pshs      u         ; save u on the stack
                    os9       F$Link    ; invoke the OS-9 F$Link service
                    bcc       L0132     ; branch when carry is clear; target L0132
                    cmpb      #221      ; compare b with #221 and set the condition codes
                    lbne      L0263     ; branch when the values differ or the result is nonzero; target L0263
                    os9       F$Load    ; invoke the OS-9 F$Load service
                    lbcs      L0263     ; branch when carry reports an error or unsigned underflow; target L0263
L0132               tfr       u,d       ; copy the register values specified by u,d
                    puls      u         ; restore u from the stack
                    std       U0004,u   ; store d at U0004,u
                    sty       U0006,u   ; store y at U0006,u
                    leax      U000C,u   ; form the address U000C,u in x
                    stx       U0008,u   ; store x at U0008,u
                    stx       U000A,u   ; store x at U000A,u
L0141               ldd       0,y       ; load d from 0,y
                    beq       L014F     ; branch when the values are equal or the result is zero; target L014F
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    beq       L014F     ; branch when the values are equal or the result is zero; target L014F
                    leay      $03,y     ; form the address $03,y in y
                    bra       L0141     ; continue execution at L0141
L014F               ldd       U0002,u   ; load d from U0002,u
                    std       ,y++      ; store d at ,y++
                    lda       #1        ; set a to the constant 1
                    sta       0,y       ; store a at 0,y
L0157               lbsr      L015F     ; call subroutine L015F
                    lbsr      L01D3     ; call subroutine L01D3
                    bra       L0157     ; continue execution at L0157
L015F               ldx       U0006,u   ; load x from U0006,u
L0161               ldd       ,x++      ; load d from ,x++
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    lbeq      L01CE     ; branch when the values are equal or the result is zero; target L01CE
                    cmpd      U0002,u   ; compare d with U0002,u and set the condition codes
                    beq       L0174     ; branch when the values are equal or the result is zero; target L0174
                    leax      $01,x     ; form the address $01,x in x
                    bra       L0161     ; continue execution at L0161
L0174               lda       ,x+       ; load a from ,x+
                    beq       L0179     ; branch when the values are equal or the result is zero; target L0179
                    rts                 ; return to the caller
L0179               lda       #1        ; set a to the constant 1
                    sta       -$01,x    ; store a at -$01,x
                    leax      >L001D,pc ; form the address >L001D,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    ldx       U0006,u   ; load x from U0006,u
                    leax      >$0104,x  ; form the address >$0104,x in x
                    clrb                ; clear b to zero and set the condition codes
L0191               lda       ,x+       ; load a from ,x+
                    incb                ; increment b
                    cmpa      #58       ; compare a with #58 and set the condition codes
                    beq       L019C     ; branch when the values are equal or the result is zero; target L019C
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       L0191     ; branch when the values differ or the result is nonzero; target L0191
L019C               lda       #58       ; set a to the constant 58
                    sta       -$01,x    ; store a at -$01,x
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    ldx       U0006,u   ; load x from U0006,u
                    leax      >$0104,x  ; form the address >$0104,x in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    ldx       U0006,u   ; load x from U0006,u
                    leax      <$003C,x  ; form the address <$003C,x in x
                    lda       #1        ; set a to the constant 1
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      U000C,u   ; form the address U000C,u in x
                    stx       U0000,u   ; store x at U0000,u
                    ldd       U0008,u   ; load d from U0008,u
                    subd      U0000,u   ; subtract from d using U0000,u
                    tfr       d,y       ; copy the register values specified by d,y
                    leax      U000C,u   ; form the address U000C,u in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    rts                 ; return to the caller
L01CE               ldb       #1        ; set b to the constant 1
                    lbra      L0263     ; continue execution at L0263
L01D3               clra                ; clear a to zero and set the condition codes
                    ldb       #1        ; set b to the constant 1
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    bcs       L023D     ; branch when carry reports an error or unsigned underflow; target L023D
                    ldy       #1        ; set y to the constant 1
                    ldx       U0008,u   ; load x from U0008,u
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lda       ,x+       ; load a from ,x+
                    cmpa      #8        ; compare a with #8 and set the condition codes
                    beq       L023F     ; branch when the values are equal or the result is zero; target L023F
                    cmpa      #26       ; compare a with #26 and set the condition codes
                    lbeq      L0248     ; branch when the values are equal or the result is zero; target L0248
                    cmpa      #24       ; compare a with #24 and set the condition codes
                    lbeq      L0266     ; branch when the values are equal or the result is zero; target L0266
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L020B     ; branch when the values are equal or the result is zero; target L020B
                    leay      >buffer,u ; form the address >buffer,u in y
                    sty       U0000,u   ; store y at U0000,u
                    cmpx      U0000,u   ; compare x with U0000,u and set the condition codes
                    lbeq      L023D     ; branch when the values are equal or the result is zero; target L023D
                    stx       U0008,u   ; store x at U0008,u
                    bra       L023E     ; continue execution at L023E
L020B               leax      >L001D,pc ; form the address >L001D,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    ldx       U0006,u   ; load x from U0006,u
                    leax      <$003C,x  ; form the address <$003C,x in x
                    leay      U000C,u   ; form the address U000C,u in y
                    sty       U0008,u   ; store y at U0008,u
                    ldb       #255      ; set b to the constant 255
L0224               lda       ,y+       ; load a from ,y+
                    sta       ,x+       ; store a at ,x+
                    decb                ; decrement b
                    bne       L0224     ; branch when the values differ or the result is nonzero; target L0224
                    lda       #58       ; set a to the constant 58
                    sta       ,x+       ; store a at ,x+
                    ldx       U0006,u   ; load x from U0006,u
L0231               ldd       ,x++      ; load d from ,x++
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    beq       L023D     ; branch when the values are equal or the result is zero; target L023D
                    clr       ,x+       ; clear ,x+ to zero and set the condition codes
                    bra       L0231     ; continue execution at L0231
L023D               clra                ; clear a to zero and set the condition codes
L023E               rts                 ; return to the caller
L023F               leax      -$02,x    ; form the address -$02,x in x
                    cmpx      U000A,u   ; compare x with U000A,u and set the condition codes
                    bls       L0247     ; branch when the unsigned value is lower or equal; target L0247
                    stx       U0008,u   ; store x at U0008,u
L0247               rts                 ; return to the caller
L0248               ldx       U0006,u   ; load x from U0006,u
L024A               ldd       ,x++      ; load d from ,x++
                    leax      $01,x     ; form the address $01,x in x
                    cmpd      U0002,u   ; compare d with U0002,u and set the condition codes
                    bne       L024A     ; branch when the values differ or the result is nonzero; target L024A
                    leax      -$03,x    ; form the address -$03,x in x
                    clr       0,x       ; clear 0,x to zero and set the condition codes
                    clr       $01,x     ; clear $01,x to zero and set the condition codes
                    pshs      u         ; save u on the stack
                    ldu       U0004,u   ; load u from U0004,u
                    os9       F$UnLink  ; invoke the OS-9 F$UnLink service
                    puls      u         ; restore u from the stack
                    clrb                ; clear b to zero and set the condition codes
L0263               os9       F$Exit    ; invoke the OS-9 F$Exit service
L0266               lda       #17       ; set a to the constant 17
                    ldb       #3        ; set b to the constant 3
                    ldy       #1        ; set y to the constant 1
                    leax      >confwho,pc ; form the address >confwho,pc in x
                    pshs      u         ; save u on the stack
                    leau      >L001D,pc ; form the workspace or data address >L001D,pc in u
                    os9       F$Fork    ; invoke the OS-9 F$Fork service
                    os9       F$Wait    ; invoke the OS-9 F$Wait service
                    puls      u         ; restore u from the stack
                    rts                 ; return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
