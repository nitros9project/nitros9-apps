**********************************************************************
* BBS.form - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       BBS.Form
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
U0005               rmb       402       ; reserve 402 byte(s) in the module workspace
U0197               rmb       1         ; reserve 1 byte(s) in the module workspace
U0198               rmb       7779      ; reserve 7779 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.Form/ ; store an OS-9 high-bit-terminated string
L0015               fcc       "------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
L0040               fcc       "Is all information correct?" ; store literal character data
L005B               fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data

start               stx       U0003,u   ; store x at U0003,u
L005F               lda       ,x+       ; load a from ,x+
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    bne       L005F     ; branch when the values differ or the result is nonzero; target L005F
                    lda       #13       ; set a to the constant 13
                    sta       -$01,x    ; store a at -$01,x
                    lda       #2        ; set a to the constant 2
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L0082     ; branch when carry reports an error or unsigned underflow; target L0082
                    sta       U0000,u   ; store a at U0000,u
                    ldb       #2        ; set b to the constant 2
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    puls      u         ; restore u from the stack
                    bra       L008D     ; continue execution at L008D
L0082               ldb       #27       ; set b to the constant 27
                    os9       I$Create  ; invoke the OS-9 I$Create service
                    lbcs      L0131     ; branch when carry reports an error or unsigned underflow; target L0131
                    sta       U0000,u   ; store a at U0000,u
L008D               ldx       U0003,u   ; load x from U0003,u
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L0131     ; branch when carry reports an error or unsigned underflow; target L0131
                    sta       U0001,u   ; store a at U0001,u
                    leax      >U0197,u  ; form the address >U0197,u in x
                    stx       U0005,u   ; store x at U0005,u
L00A0               lda       U0001,u   ; load a from U0001,u
                    ldx       U0005,u   ; load x from U0005,u
                    ldy       #200      ; set y to the constant 200
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    lbcs      L00CA     ; branch when carry reports an error or unsigned underflow; target L00CA
                    leay      -$01,y    ; form the address -$01,y in y
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    tfr       y,d       ; copy the register values specified by y,d
                    leax      d,x       ; form the address d,x in x
                    ldy       #200      ; set y to the constant 200
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    tfr       y,d       ; copy the register values specified by y,d
                    leax      d,x       ; form the address d,x in x
                    stx       U0005,u   ; store x at U0005,u
                    bra       L00A0     ; continue execution at L00A0
L00CA               leax      >L0040,pc ; form the address >L0040,pc in x
                    ldy       #27       ; set y to the constant 27
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      U0002,u   ; form the address U0002,u in x
                    clra                ; clear a to zero and set the condition codes
                    ldy       #1        ; set y to the constant 1
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    leax      >L005B,pc ; form the address >L005B,pc in x
                    ldy       #2        ; set y to the constant 2
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lda       U0002,u   ; load a from U0002,u
                    anda      #223      ; mask a using #223
                    cmpa      #89       ; compare a with #89 and set the condition codes
                    beq       L0112     ; branch when the values are equal or the result is zero; target L0112
                    leax      >U0197,u  ; form the address >U0197,u in x
                    stx       U0005,u   ; store x at U0005,u
                    lda       U0001,u   ; load a from U0001,u
                    pshs      u         ; save u on the stack
                    ldu       #0        ; set u to the constant 0
                    ldx       #0        ; set x to the constant 0
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    lbcs      L0131     ; branch when carry reports an error or unsigned underflow; target L0131
                    puls      u         ; restore u from the stack
                    lbra      L00A0     ; continue execution at L00A0
L0112               leax      >U0197,u  ; form the address >U0197,u in x
                    pshs      x         ; save x on the stack
                    ldd       U0005,u   ; load d from U0005,u
                    subd      0,s       ; subtract from d using 0,s
                    tfr       d,y       ; copy the register values specified by d,y
                    puls      x         ; restore x from the stack
                    lda       U0000,u   ; load a from U0000,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      >L0015,pc ; form the address >L0015,pc in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    clrb                ; clear b to zero and set the condition codes
L0131               os9       F$Exit    ; invoke the OS-9 F$Exit service

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
