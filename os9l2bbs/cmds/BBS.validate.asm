**********************************************************************
* BBS.validate - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       BBS.validate
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
U0003               rmb       2         ; reserve 2 byte(s) in the module workspace
U0005               rmb       80        ; reserve 80 byte(s) in the module workspace
U0055               rmb       1         ; reserve 1 byte(s) in the module workspace
U0056               rmb       479       ; reserve 479 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.validate/ ; store an OS-9 high-bit-terminated string
L0019               fcc       "Enter new user's name:=====>" ; store literal character data
L0035               fcc       "Enter new user's password:=>" ; store literal character data
L0051               fcc       "Enter new user's program:==>" ; store literal character data
L006D               fcc       "Enter new user's number:===>" ; store literal character data
L0089               fcc       "Enter new user's time limit>" ; store literal character data
L00A5               fcc       "Enter new user's alias:====>" ; store literal character data
L00C1               fcb       $0A       ; store byte data
                    fcc       "New BBS.users line will read as follows:" ; store literal character data
                    fcb       $0D       ; store byte data
L00EB               fcb       $0D       ; store byte data
                    fcb       $0A       ; store byte data
                    fcc       "Is this line correct? (y/N):" ; store literal character data
L0109               fcc       "BBS.users" ; store literal character data
                    fcb       $0D       ; store byte data
L0113               fcc       "/dd/bbs/bbs.alias" ; store literal character data
                    fcb       $0D       ; store byte data
L0125               fcb       $0D       ; store byte data
                    fcb       $0A       ; store byte data
start               leax      >L0109,pc ; form the address >L0109,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    bcc       L014E     ; branch when carry is clear; target L014E
                    cmpb      #216      ; compare b with #216 and set the condition codes
                    lbne      L02F1     ; branch when the values differ or the result is nonzero; target L02F1
                    os9       F$ID      ; invoke the OS-9 F$ID service
                    ldb       #214      ; set b to the constant 214
                    cmpy      #0        ; compare y with #0 and set the condition codes
                    lbne      L02F1     ; branch when the values differ or the result is nonzero; target L02F1
                    ldb       #3        ; set b to the constant 3
                    os9       I$Create  ; invoke the OS-9 I$Create service
                    lbcs      L02F1     ; branch when carry reports an error or unsigned underflow; target L02F1
L014E               sta       U0000,u   ; store a at U0000,u
                    leax      >L0113,pc ; form the address >L0113,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    bcc       L0177     ; branch when carry is clear; target L0177
                    cmpb      #216      ; compare b with #216 and set the condition codes
                    lbne      L02F1     ; branch when the values differ or the result is nonzero; target L02F1
                    os9       F$ID      ; invoke the OS-9 F$ID service
                    ldb       #214      ; set b to the constant 214
                    cmpy      #0        ; compare y with #0 and set the condition codes
                    lbne      L02F1     ; branch when the values differ or the result is nonzero; target L02F1
                    ldb       #11       ; set b to the constant 11
                    os9       I$Create  ; invoke the OS-9 I$Create service
                    lbcs      L02F1     ; branch when carry reports an error or unsigned underflow; target L02F1
L0177               sta       U0001,u   ; store a at U0001,u
                    lda       U0000,u   ; load a from U0000,u
                    ldb       #2        ; set b to the constant 2
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    lbcs      L02F1     ; branch when carry reports an error or unsigned underflow; target L02F1
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    lbcs      L02F1     ; branch when carry reports an error or unsigned underflow; target L02F1
                    puls      u         ; restore u from the stack
                    lda       U0001,u   ; load a from U0001,u
                    ldb       #2        ; set b to the constant 2
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    lbcs      L02F1     ; branch when carry reports an error or unsigned underflow; target L02F1
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    lbcs      L02F1     ; branch when carry reports an error or unsigned underflow; target L02F1
                    puls      u         ; restore u from the stack
L01A5               leax      >L0019,pc ; form the address >L0019,pc in x
                    ldy       #28       ; set y to the constant 28
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      U0005,u   ; form the address U0005,u in x
                    clra                ; clear a to zero and set the condition codes
                    ldy       #80       ; set y to the constant 80
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    pshs      x         ; save x on the stack
L01BE               lda       0,x       ; load a from 0,x
                    cmpa      #97       ; compare a with #97 and set the condition codes
                    bcs       L01C6     ; branch when carry reports an error or unsigned underflow; target L01C6
                    anda      #223      ; mask a using #223
L01C6               sta       ,x+       ; store a at ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       L01BE     ; branch when the values differ or the result is nonzero; target L01BE
                    puls      x         ; restore x from the stack
                    tfr       y,d       ; copy the register values specified by y,d
                    leax      d,x       ; form the address d,x in x
                    lda       #44       ; set a to the constant 44
                    sta       -$01,x    ; store a at -$01,x
                    pshs      x         ; save x on the stack
                    leax      >L0035,pc ; form the address >L0035,pc in x
                    ldy       #28       ; set y to the constant 28
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    puls      x         ; restore x from the stack
                    ldy       #80       ; set y to the constant 80
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    pshs      x         ; save x on the stack
L01F1               lda       0,x       ; load a from 0,x
                    cmpa      #97       ; compare a with #97 and set the condition codes
                    bcs       L01F9     ; branch when carry reports an error or unsigned underflow; target L01F9
                    anda      #223      ; mask a using #223
L01F9               sta       ,x+       ; store a at ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       L01F1     ; branch when the values differ or the result is nonzero; target L01F1
                    puls      x         ; restore x from the stack
                    tfr       y,d       ; copy the register values specified by y,d
                    leax      d,x       ; form the address d,x in x
                    lda       #44       ; set a to the constant 44
                    sta       -$01,x    ; store a at -$01,x
                    pshs      x         ; save x on the stack
                    leax      >L0051,pc ; form the address >L0051,pc in x
                    ldy       #28       ; set y to the constant 28
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    puls      x         ; restore x from the stack
                    clra                ; clear a to zero and set the condition codes
                    ldy       #80       ; set y to the constant 80
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    tfr       y,d       ; copy the register values specified by y,d
                    leax      d,x       ; form the address d,x in x
                    lda       #44       ; set a to the constant 44
                    sta       -$01,x    ; store a at -$01,x
                    pshs      x         ; save x on the stack
                    leax      >L00A5,pc ; form the address >L00A5,pc in x
                    ldy       #28       ; set y to the constant 28
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      <U0055,u  ; form the address <U0055,u in x
                    ldy       #80       ; set y to the constant 80
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    tfr       y,d       ; copy the register values specified by y,d
                    leax      d,x       ; form the address d,x in x
                    lda       #44       ; set a to the constant 44
                    sta       -$01,x    ; store a at -$01,x
                    stx       U0003,u   ; store x at U0003,u
                    leax      >L006D,pc ; form the address >L006D,pc in x
                    ldy       #28       ; set y to the constant 28
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    puls      x         ; restore x from the stack
                    ldy       #80       ; set y to the constant 80
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    ldy       U0003,u   ; load y from U0003,u
L0268               lda       ,x+       ; load a from ,x+
                    sta       ,y+       ; store a at ,y+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       L0268     ; branch when the values differ or the result is nonzero; target L0268
                    lda       #44       ; set a to the constant 44
                    sta       -$01,x    ; store a at -$01,x
                    pshs      x         ; save x on the stack
                    leax      >L0089,pc ; form the address >L0089,pc in x
                    ldy       #28       ; set y to the constant 28
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    puls      x         ; restore x from the stack
                    ldy       #80       ; set y to the constant 80
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    leax      >L00C1,pc ; form the address >L00C1,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      U0005,u   ; form the address U0005,u in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L00EB,pc ; form the address >L00EB,pc in x
                    ldy       #30       ; set y to the constant 30
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      U0002,u   ; form the address U0002,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    leax      >L0125,pc ; form the address >L0125,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lda       U0002,u   ; load a from U0002,u
                    anda      #223      ; mask a using #223
                    cmpa      #89       ; compare a with #89 and set the condition codes
                    lbne      L01A5     ; branch when the values differ or the result is nonzero; target L01A5
                    lda       U0000,u   ; load a from U0000,u
                    leax      U0005,u   ; form the address U0005,u in x
                    ldy       #81       ; set y to the constant 81
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L02F1     ; branch when carry reports an error or unsigned underflow; target L02F1
                    lda       U0001,u   ; load a from U0001,u
                    leax      <U0055,u  ; form the address <U0055,u in x
                    ldy       #81       ; set y to the constant 81
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L02F1     ; branch when carry reports an error or unsigned underflow; target L02F1
                    clrb                ; clear b to zero and set the condition codes
L02F1               os9       F$Exit    ; invoke the OS-9 F$Exit service

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
