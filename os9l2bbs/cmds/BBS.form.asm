**********************************************************************
* BBS.form - OS-9 Level 2 BBS command
*
* Syntax: BBS.form <form> <output>
* Purpose: Prompt for every field in a form definition and write the collected answers.
* Used by new-user and other configurable data-entry workflows.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
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

WorkByte_001        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_002        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_003        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_001        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_001      rmb       402       ; reserve 402 byte(s) in the module workspace
WorkByte_004        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_002      rmb       7779      ; reserve 7779 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.Form/ ; store an OS-9 high-bit-terminated string
Text_001            fcc       "------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
Text_002            fcc       "Is all information correct?" ; store literal character data
Data_001            fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data

start               stx       WorkWord_001,u ; store x at WorkWord_001,u
Branch_001          lda       ,x+       ; load a from ,x+
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    bne       Branch_001 ; branch when the values differ or the result is nonzero; target Branch_001
                    lda       #13       ; set a to the constant 13
                    sta       -$01,x    ; store a at -$01,x
                    lda       #2        ; set a to the constant 2
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    sta       WorkByte_001,u ; store a at WorkByte_001,u
                    ldb       #2        ; set b to the constant 2
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; query status code B for path A
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    puls      u         ; restore u from the stack
                    bra       Branch_003 ; continue execution at Branch_003
Branch_002          ldb       #27       ; set b to the constant 27
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    lbcs      Branch_004 ; branch when carry reports an error or unsigned underflow; target Branch_004
                    sta       WorkByte_001,u ; store a at WorkByte_001,u
Branch_003          ldx       WorkWord_001,u ; load x from WorkWord_001,u
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_004 ; branch when carry reports an error or unsigned underflow; target Branch_004
                    sta       WorkByte_002,u ; store a at WorkByte_002,u
                    leax      >WorkByte_004,u ; form the address >WorkByte_004,u in x
                    stx       WorkBuffer_001,u ; store x at WorkBuffer_001,u
Branch_005          lda       WorkByte_002,u ; load a from WorkByte_002,u
                    ldx       WorkBuffer_001,u ; load x from WorkBuffer_001,u
                    ldy       #200      ; set y to the constant 200
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lbcs      Branch_006 ; branch when carry reports an error or unsigned underflow; target Branch_006
                    leay      -$01,y    ; form the address -$01,y in y
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    tfr       y,d       ; copy the register values specified by y,d
                    leax      d,x       ; form the address d,x in x
                    ldy       #200      ; set y to the constant 200
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    tfr       y,d       ; copy the register values specified by y,d
                    leax      d,x       ; form the address d,x in x
                    stx       WorkBuffer_001,u ; store x at WorkBuffer_001,u
                    bra       Branch_005 ; continue execution at Branch_005
Branch_006          leax      >Text_002,pc ; form the address >Text_002,pc in x
                    ldy       #27       ; set y to the constant 27
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      WorkByte_003,u ; form the address WorkByte_003,u in x
                    clra                ; clear a to zero and set the condition codes
                    ldy       #1        ; set y to the constant 1
                    os9       I$Read    ; read up to Y bytes from path A into X
                    leax      >Data_001,pc ; form the address >Data_001,pc in x
                    ldy       #2        ; set y to the constant 2
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       WorkByte_003,u ; load a from WorkByte_003,u
                    anda      #223      ; mask a using #223
                    cmpa      #89       ; compare a with #89 and set the condition codes
                    beq       Branch_007 ; branch when the values are equal or the result is zero; target Branch_007
                    leax      >WorkByte_004,u ; form the address >WorkByte_004,u in x
                    stx       WorkBuffer_001,u ; store x at WorkBuffer_001,u
                    lda       WorkByte_002,u ; load a from WorkByte_002,u
                    pshs      u         ; save u on the stack
                    ldu       #0        ; set u to the constant 0
                    ldx       #0        ; set x to the constant 0
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      Branch_004 ; branch when carry reports an error or unsigned underflow; target Branch_004
                    puls      u         ; restore u from the stack
                    lbra      Branch_005 ; continue execution at Branch_005
Branch_007          leax      >WorkByte_004,u ; form the address >WorkByte_004,u in x
                    pshs      x         ; save x on the stack
                    ldd       WorkBuffer_001,u ; load d from WorkBuffer_001,u
                    subd      ,s        ; subtract from d using ,s
                    tfr       d,y       ; copy the register values specified by d,y
                    puls      x         ; restore x from the stack
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >Text_001,pc ; form the address >Text_001,pc in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    clrb                ; clear b to zero and set the condition codes
Branch_004          os9       F$Exit    ; terminate the process with status B

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
