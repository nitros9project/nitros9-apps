**********************************************************************
* BBS.validate - OS-9 Level 2 BBS command
*
* Syntax: BBS.validate
* Purpose: Review pending new-user data and create an accepted BBS.users record.
* Sysop workflow over new_user_file/new_user_log and BBS.users.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
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

WorkByte_001        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_002        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_003        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_001        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_001      rmb       80        ; reserve 80 byte(s) in the module workspace
WorkByte_004        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_002      rmb       479       ; reserve 479 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.validate/ ; store an OS-9 high-bit-terminated string
Text_001            fcc       "Enter new user's name:=====>" ; store literal character data
Text_002            fcc       "Enter new user's password:=>" ; store literal character data
Text_003            fcc       "Enter new user's program:==>" ; store literal character data
Text_004            fcc       "Enter new user's number:===>" ; store literal character data
Text_005            fcc       "Enter new user's time limit>" ; store literal character data
Text_006            fcc       "Enter new user's alias:====>" ; store literal character data
Data_001            fcb       $0A       ; store byte data
                    fcc       "New BBS.users line will read as follows:" ; store literal character data
                    fcb       $0D       ; store byte data
Data_002            fcb       $0D       ; store byte data
                    fcb       $0A       ; store byte data
                    fcc       "Is this line correct? (Y/N):" ; store literal character data
Text_007            fcc       "BBS.users" ; store literal character data
                    fcb       $0D       ; store byte data
Text_008            fcc       "/dd/bbs/bbs.alias" ; store literal character data
                    fcb       $0D       ; store byte data
Data_003            fcb       $0D       ; store byte data
                    fcb       $0A       ; store byte data
start               leax      >Text_007,pc ; form the address >Text_007,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    bcc       Branch_001 ; branch when carry is clear; target Branch_001
                    cmpb      #216      ; compare b with #216 and set the condition codes
                    lbne      Branch_002 ; branch when the values differ or the result is nonzero; target Branch_002
                    os9       F$ID      ; retrieve the current process and user IDs
                    ldb       #214      ; set b to the constant 214
                    cmpy      #0        ; compare y with #0 and set the condition codes
                    lbne      Branch_002 ; branch when the values differ or the result is nonzero; target Branch_002
                    ldb       #3        ; set b to the constant 3
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
Branch_001          sta       WorkByte_001,u ; store a at WorkByte_001,u
                    leax      >Text_008,pc ; form the address >Text_008,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    bcc       Branch_003 ; branch when carry is clear; target Branch_003
                    cmpb      #216      ; compare b with #216 and set the condition codes
                    lbne      Branch_002 ; branch when the values differ or the result is nonzero; target Branch_002
                    os9       F$ID      ; retrieve the current process and user IDs
                    ldb       #214      ; set b to the constant 214
                    cmpy      #0        ; compare y with #0 and set the condition codes
                    lbne      Branch_002 ; branch when the values differ or the result is nonzero; target Branch_002
                    ldb       #11       ; set b to the constant 11
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
Branch_003          sta       WorkByte_002,u ; store a at WorkByte_002,u
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    ldb       #2        ; set b to the constant 2
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; query status code B for path A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    puls      u         ; restore u from the stack
                    lda       WorkByte_002,u ; load a from WorkByte_002,u
                    ldb       #2        ; set b to the constant 2
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; query status code B for path A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    puls      u         ; restore u from the stack
Branch_004          leax      >Text_001,pc ; form the address >Text_001,pc in x
                    ldy       #28       ; set y to the constant 28
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      WorkBuffer_001,u ; form the address WorkBuffer_001,u in x
                    clra                ; clear a to zero and set the condition codes
                    ldy       #80       ; set y to the constant 80
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    pshs      x         ; save x on the stack
Branch_005          lda       ,x        ; load a from ,x
                    cmpa      #97       ; compare a with #97 and set the condition codes
                    bcs       Branch_006 ; branch when carry reports an error or unsigned underflow; target Branch_006
                    anda      #223      ; mask a using #223
Branch_006          sta       ,x+       ; store a at ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       Branch_005 ; branch when the values differ or the result is nonzero; target Branch_005
                    puls      x         ; restore x from the stack
                    tfr       y,d       ; copy the register values specified by y,d
                    leax      d,x       ; form the address d,x in x
                    lda       #44       ; set a to the constant 44
                    sta       -$01,x    ; store a at -$01,x
                    pshs      x         ; save x on the stack
                    leax      >Text_002,pc ; form the address >Text_002,pc in x
                    ldy       #28       ; set y to the constant 28
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      x         ; restore x from the stack
                    ldy       #80       ; set y to the constant 80
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    pshs      x         ; save x on the stack
Branch_007          lda       ,x        ; load a from ,x
                    cmpa      #97       ; compare a with #97 and set the condition codes
                    bcs       Branch_008 ; branch when carry reports an error or unsigned underflow; target Branch_008
                    anda      #223      ; mask a using #223
Branch_008          sta       ,x+       ; store a at ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       Branch_007 ; branch when the values differ or the result is nonzero; target Branch_007
                    puls      x         ; restore x from the stack
                    tfr       y,d       ; copy the register values specified by y,d
                    leax      d,x       ; form the address d,x in x
                    lda       #44       ; set a to the constant 44
                    sta       -$01,x    ; store a at -$01,x
                    pshs      x         ; save x on the stack
                    leax      >Text_003,pc ; form the address >Text_003,pc in x
                    ldy       #28       ; set y to the constant 28
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      x         ; restore x from the stack
                    clra                ; clear a to zero and set the condition codes
                    ldy       #80       ; set y to the constant 80
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    tfr       y,d       ; copy the register values specified by y,d
                    leax      d,x       ; form the address d,x in x
                    lda       #44       ; set a to the constant 44
                    sta       -$01,x    ; store a at -$01,x
                    pshs      x         ; save x on the stack
                    leax      >Text_006,pc ; form the address >Text_006,pc in x
                    ldy       #28       ; set y to the constant 28
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      <WorkByte_004,u ; form the address <WorkByte_004,u in x
                    ldy       #80       ; set y to the constant 80
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    tfr       y,d       ; copy the register values specified by y,d
                    leax      d,x       ; form the address d,x in x
                    lda       #44       ; set a to the constant 44
                    sta       -$01,x    ; store a at -$01,x
                    stx       WorkWord_001,u ; store x at WorkWord_001,u
                    leax      >Text_004,pc ; form the address >Text_004,pc in x
                    ldy       #28       ; set y to the constant 28
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      x         ; restore x from the stack
                    ldy       #80       ; set y to the constant 80
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    ldy       WorkWord_001,u ; load y from WorkWord_001,u
Branch_009          lda       ,x+       ; load a from ,x+
                    sta       ,y+       ; store a at ,y+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       Branch_009 ; branch when the values differ or the result is nonzero; target Branch_009
                    lda       #44       ; set a to the constant 44
                    sta       -$01,x    ; store a at -$01,x
                    pshs      x         ; save x on the stack
                    leax      >Text_005,pc ; form the address >Text_005,pc in x
                    ldy       #28       ; set y to the constant 28
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      x         ; restore x from the stack
                    ldy       #80       ; set y to the constant 80
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    leax      >Data_001,pc ; form the address >Data_001,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      WorkBuffer_001,u ; form the address WorkBuffer_001,u in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Data_002,pc ; form the address >Data_002,pc in x
                    ldy       #30       ; set y to the constant 30
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      WorkByte_003,u ; form the address WorkByte_003,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; read up to Y bytes from path A into X
                    leax      >Data_003,pc ; form the address >Data_003,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       WorkByte_003,u ; load a from WorkByte_003,u
                    anda      #223      ; mask a using #223
                    cmpa      #89       ; compare a with #89 and set the condition codes
                    lbne      Branch_004 ; branch when the values differ or the result is nonzero; target Branch_004
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    leax      WorkBuffer_001,u ; form the address WorkBuffer_001,u in x
                    ldy       #81       ; set y to the constant 81
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    lda       WorkByte_002,u ; load a from WorkByte_002,u
                    leax      <WorkByte_004,u ; form the address <WorkByte_004,u in x
                    ldy       #81       ; set y to the constant 81
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    clrb                ; clear b to zero and set the condition codes
Branch_002          os9       F$Exit    ; terminate the process with status B

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
