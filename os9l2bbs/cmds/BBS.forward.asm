**********************************************************************
* BBS.forward - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       BBS.forward
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
U0003               rmb       1         ; reserve 1 byte(s) in the module workspace
U0004               rmb       1         ; reserve 1 byte(s) in the module workspace
U0005               rmb       1         ; reserve 1 byte(s) in the module workspace
U0006               rmb       1         ; reserve 1 byte(s) in the module workspace
U0007               rmb       1         ; reserve 1 byte(s) in the module workspace
U0008               rmb       2         ; reserve 2 byte(s) in the module workspace
U000A               rmb       2         ; reserve 2 byte(s) in the module workspace
U000C               rmb       2         ; reserve 2 byte(s) in the module workspace
U000E               rmb       2         ; reserve 2 byte(s) in the module workspace
U0010               rmb       6         ; reserve 6 byte(s) in the module workspace
U0016               rmb       2         ; reserve 2 byte(s) in the module workspace
U0018               rmb       2         ; reserve 2 byte(s) in the module workspace
U001A               rmb       2         ; reserve 2 byte(s) in the module workspace
U001C               rmb       18        ; reserve 18 byte(s) in the module workspace
U002E               rmb       1         ; reserve 1 byte(s) in the module workspace
U002F               rmb       1         ; reserve 1 byte(s) in the module workspace
U0030               rmb       2         ; reserve 2 byte(s) in the module workspace
U0032               rmb       2         ; reserve 2 byte(s) in the module workspace
U0034               rmb       2         ; reserve 2 byte(s) in the module workspace
U0036               rmb       6         ; reserve 6 byte(s) in the module workspace
U003C               rmb       3         ; reserve 3 byte(s) in the module workspace
U003F               rmb       1         ; reserve 1 byte(s) in the module workspace
U0040               rmb       2         ; reserve 2 byte(s) in the module workspace
U0042               rmb       1         ; reserve 1 byte(s) in the module workspace
U0043               rmb       6         ; reserve 6 byte(s) in the module workspace
U0049               rmb       1         ; reserve 1 byte(s) in the module workspace
U004A               rmb       1         ; reserve 1 byte(s) in the module workspace
U004B               rmb       2         ; reserve 2 byte(s) in the module workspace
U004D               rmb       1         ; reserve 1 byte(s) in the module workspace
U004E               rmb       1         ; reserve 1 byte(s) in the module workspace
U004F               rmb       1         ; reserve 1 byte(s) in the module workspace
U0050               rmb       1         ; reserve 1 byte(s) in the module workspace
U0051               rmb       1         ; reserve 1 byte(s) in the module workspace
U0052               rmb       1         ; reserve 1 byte(s) in the module workspace
U0053               rmb       1         ; reserve 1 byte(s) in the module workspace
U0054               rmb       1         ; reserve 1 byte(s) in the module workspace
U0055               rmb       1         ; reserve 1 byte(s) in the module workspace
U0056               rmb       1         ; reserve 1 byte(s) in the module workspace
U0057               rmb       1         ; reserve 1 byte(s) in the module workspace
U0058               rmb       1         ; reserve 1 byte(s) in the module workspace
U0059               rmb       1         ; reserve 1 byte(s) in the module workspace
U005A               rmb       1         ; reserve 1 byte(s) in the module workspace
U005B               rmb       1         ; reserve 1 byte(s) in the module workspace
U005C               rmb       64        ; reserve 64 byte(s) in the module workspace
U009C               rmb       80        ; reserve 80 byte(s) in the module workspace
U00EC               rmb       2         ; reserve 2 byte(s) in the module workspace
U00EE               rmb       2         ; reserve 2 byte(s) in the module workspace
U00F0               rmb       20        ; reserve 20 byte(s) in the module workspace
U0104               rmb       30        ; reserve 30 byte(s) in the module workspace
U0122               rmb       1         ; reserve 1 byte(s) in the module workspace
U0123               rmb       1         ; reserve 1 byte(s) in the module workspace
U0124               rmb       1         ; reserve 1 byte(s) in the module workspace
U0125               rmb       1         ; reserve 1 byte(s) in the module workspace
U0126               rmb       4         ; reserve 4 byte(s) in the module workspace
U012A               rmb       2         ; reserve 2 byte(s) in the module workspace
U012C               rmb       1         ; reserve 1 byte(s) in the module workspace
U012D               rmb       399       ; reserve 399 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.forward/ ; store an OS-9 high-bit-terminated string
                    fcc       "Copyright (C) 1988" ; store literal character data
                    fcc       "By Keith Alphonso" ; store literal character data
                    fcc       "Licenced to Alpha Software Technologies" ; store literal character data
                    fcc       "All rights reserved" ; store literal character data
                    fcb       $EC       ; store byte data
                    fcb       $E6       ; store byte data
                    fcb       $EA       ; store byte data
                    fcb       $F5       ; store byte data
                    fcb       $E9       ; store byte data
                    fcb       $A0       ; store byte data
                    fcb       $E2       ; store byte data
                    fcb       $ED       ; store byte data
                    fcb       $F1       ; store byte data
                    fcb       $E9       ; store byte data
                    fcb       $F0       ; store byte data
                    fcb       $EF       ; store byte data
                    fcb       $F4       ; store byte data
                    fcb       $F0       ; store byte data
L0083               fcc       "High message is #" ; store literal character data
L0094               fcb       $00       ; store byte data
                    fcb       $11       ; store byte data
L0096               fcc       "Enter starting message #" ; store literal character data
                    fcb       $0D       ; store byte data
L00AF               fcc       ">" ; store literal character data
L00B0               fcc       "BBS.msg.inx" ; store literal character data
                    fcb       $0D       ; store byte data
L00BC               fcc       "BBS.msg" ; store literal character data
                    fcb       $0D       ; store byte data
L00C4               fcc       "******   DELETED   ******" ; store literal character data
                    fcb       $0D       ; store byte data
L00DE               fcc       "Message :" ; store literal character data
L00E7               fcc       "From    :" ; store literal character data
L00F0               fcc       "To      :" ; store literal character data
L00F9               fcc       "Left on :" ; store literal character data
L0102               fcc       "About   :" ; store literal character data
L010B               fcb       $00       ; store byte data
                    fcb       $09       ; store byte data
L010D               fcc       "----------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
L014E               fcb       $0A       ; store byte data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
L0151               fcc       "Press <SPACE> to skip a message" ; store literal character data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
L0172               fcc       "BBS.msg.lst" ; store literal character data
                    fcb       $0D       ; store byte data
L017E               fcc       "/dd/bbs/BBS.userstats" ; store literal character data
                    fcb       $0D       ; store byte data
L0194               fcc       "/dd/bbs/BBS.alias" ; store literal character data
                    fcb       $0D       ; store byte data
L01A6               fcc       "Unknown User" ; store literal character data
                    fcb       $0D       ; store byte data
L01B3               fcc       "All Users" ; store literal character data
                    fcb       $0D       ; store byte data

start               os9       F$ID      ; invoke the OS-9 F$ID service
                    sty       U000A,u   ; store y at U000A,u
                    ldd       #0        ; set d to the constant 0
                    std       U0008,u   ; store d at U0008,u
                    ldy       #0        ; set y to the constant 0
                    os9       F$SUser   ; invoke the OS-9 F$SUser service
                    leax      >L00B0,pc ; form the address >L00B0,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L062E     ; branch when carry reports an error or unsigned underflow; target L062E
                    sta       U0001,u   ; store a at U0001,u
                    leax      >L0172,pc ; form the address >L0172,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    bcc       L01F8     ; branch when carry is clear; target L01F8
                    cmpb      #216      ; compare b with #216 and set the condition codes
                    lbne      L062E     ; branch when the values differ or the result is nonzero; target L062E
                    ldb       #11       ; set b to the constant 11
                    os9       I$Create  ; invoke the OS-9 I$Create service
                    lbcs      L062E     ; branch when carry reports an error or unsigned underflow; target L062E
L01F8               sta       U0003,u   ; store a at U0003,u
                    leax      >L00BC,pc ; form the address >L00BC,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L062E     ; branch when carry reports an error or unsigned underflow; target L062E
                    sta       U0002,u   ; store a at U0002,u
                    leax      <U005C,u  ; form the address <U005C,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       U0001,u   ; load a from U0001,u
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lbcs      L062E     ; branch when carry reports an error or unsigned underflow; target L062E
                    ldd       <U005C,u  ; load d from <U005C,u
                    leax      <U0036,u  ; form the address <U0036,u in x
                    lbsr      L06A1     ; call subroutine L06A1
                    leax      >L0083,pc ; form the address >L0083,pc in x
                    ldy       >L0094,pc ; load y from >L0094,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L062E     ; branch when carry reports an error or unsigned underflow; target L062E
                    leax      <U0036,u  ; form the address <U0036,u in x
                    ldy       #6        ; set y to the constant 6
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L062E     ; branch when carry reports an error or unsigned underflow; target L062E
                    leax      >L0096,pc ; form the address >L0096,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L062E     ; branch when carry reports an error or unsigned underflow; target L062E
                    leax      >L00AF,pc ; form the address >L00AF,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L062E     ; branch when carry reports an error or unsigned underflow; target L062E
                    leax      <U0043,u  ; form the address <U0043,u in x
                    ldy       #6        ; set y to the constant 6
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    lbcs      L062E     ; branch when carry reports an error or unsigned underflow; target L062E
                    clr       <U0042,u  ; clear <U0042,u to zero and set the condition codes
                    leax      <U0043,u  ; form the address <U0043,u in x
                    lbsr      L0631     ; call subroutine L0631
                    cmpd      #1        ; compare d with #1 and set the condition codes
                    lbcs      L062D     ; branch when carry reports an error or unsigned underflow; target L062D
                    cmpd      <U005C,u  ; compare d with <U005C,u and set the condition codes
                    lbhi      L062D     ; branch when the unsigned value is higher; target L062D
                    std       <U0036,u  ; store d at <U0036,u
                    clr       <U0049,u  ; clear <U0049,u to zero and set the condition codes
                    clr       <U004A,u  ; clear <U004A,u to zero and set the condition codes
                    lda       #6        ; set a to the constant 6
                    sta       U0005,u   ; store a at U0005,u
                    ldd       <U0036,u  ; load d from <U0036,u
L029A               aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    rol       <U004A,u  ; rotate left through carry the value at <U004A,u
                    dec       U0005,u   ; decrement the value at U0005,u
                    bne       L029A     ; branch when the values differ or the result is nonzero; target L029A
                    std       <U004B,u  ; store d at <U004B,u
                    ldx       <U0049,u  ; load x from <U0049,u
                    lda       U0001,u   ; load a from U0001,u
                    pshs      u         ; save u on the stack
                    ldu       <U004B,u  ; load u from <U004B,u
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    lbcs      L062E     ; branch when carry reports an error or unsigned underflow; target L062E
                    puls      u         ; restore u from the stack
                    ldd       <U0036,u  ; load d from <U0036,u
                    subd      #1        ; subtract from d using #1
                    std       <U0036,u  ; store d at <U0036,u
L02C2               lda       U0003,u   ; load a from U0003,u
                    leax      <U0032,u  ; form the address <U0032,u in x
                    ldy       #4        ; set y to the constant 4
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    bcs       L02FD     ; branch when carry reports an error or unsigned underflow; target L02FD
                    ldd       <U0032,u  ; load d from <U0032,u
                    cmpd      U000A,u   ; compare d with U000A,u and set the condition codes
                    bne       L02C2     ; branch when the values differ or the result is nonzero; target L02C2
                    ldd       <U0034,u  ; load d from <U0034,u
                    cmpd      <U005C,u  ; compare d with <U005C,u and set the condition codes
                    bcc       L0314     ; branch when carry is clear; target L0314
                    pshs      u         ; save u on the stack
                    lda       U0003,u   ; load a from U0003,u
                    ldb       #5        ; set b to the constant 5
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    leau      -$02,u    ; form the workspace or data address -$02,u in u
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    puls      u         ; restore u from the stack
                    leax      <U005C,u  ; form the address <U005C,u in x
                    ldy       #2        ; set y to the constant 2
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    bra       L0314     ; continue execution at L0314
L02FD               cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      L062E     ; branch when the values differ or the result is nonzero; target L062E
                    lda       U0003,u   ; load a from U0003,u
                    leax      U000A,u   ; form the address U000A,u in x
                    ldy       #2        ; set y to the constant 2
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      <U005C,u  ; form the address <U005C,u in x
                    os9       I$Write   ; invoke the OS-9 I$Write service
L0314               lda       U0003,u   ; load a from U0003,u
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    leax      >L0151,pc ; form the address >L0151,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
L0326               lda       U0001,u   ; load a from U0001,u
                    ldy       #64       ; set y to the constant 64
                    leax      >U00EC,u  ; form the address >U00EC,u in x
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lbcs      L0586     ; branch when carry reports an error or unsigned underflow; target L0586
                    ldd       <U0036,u  ; load d from <U0036,u
                    addd      #1        ; add to d using #1
                    std       <U0036,u  ; store d at <U0036,u
                    leax      >L014E,pc ; form the address >L014E,pc in x
                    ldy       #2        ; set y to the constant 2
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    ldd       <U0036,u  ; load d from <U0036,u
                    leax      <U003C,u  ; form the address <U003C,u in x
                    lbsr      L06A1     ; call subroutine L06A1
                    leax      >L00DE,pc ; form the address >L00DE,pc in x
                    ldy       >L010B,pc ; load y from >L010B,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L062E     ; branch when carry reports an error or unsigned underflow; target L062E
                    leax      <U003C,u  ; form the address <U003C,u in x
L036B               lda       ,x+       ; load a from ,x+
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       L036B     ; branch when the values are equal or the result is zero; target L036B
                    leax      -$01,x    ; form the address -$01,x in x
                    ldy       #6        ; set y to the constant 6
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L062E     ; branch when carry reports an error or unsigned underflow; target L062E
                    ldd       >U00EC,u  ; load d from >U00EC,u
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    lbeq      L0501     ; branch when the values are equal or the result is zero; target L0501
                    leax      >L00E7,pc ; form the address >L00E7,pc in x
                    ldy       >L010B,pc ; load y from >L010B,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      >U00F0,u  ; form the address >U00F0,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L062E     ; branch when carry reports an error or unsigned underflow; target L062E
                    leax      >L00F0,pc ; form the address >L00F0,pc in x
                    ldy       >L010B,pc ; load y from >L010B,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    ldd       >U012A,u  ; load d from >U012A,u
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    beq       L0423     ; branch when the values are equal or the result is zero; target L0423
                    leax      >L0194,pc ; form the address >L0194,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L062E     ; branch when carry reports an error or unsigned underflow; target L062E
                    sta       U0004,u   ; store a at U0004,u
L03D2               leax      >U012C,u  ; form the address >U012C,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       U0004,u   ; load a from U0004,u
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    bcs       L040E     ; branch when carry reports an error or unsigned underflow; target L040E
                    leax      >U012C,u  ; form the address >U012C,u in x
L03E5               lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    bne       L03E5     ; branch when the values differ or the result is nonzero; target L03E5
                    lda       #13       ; set a to the constant 13
                    sta       -$01,x    ; store a at -$01,x
                    lbsr      L0631     ; call subroutine L0631
                    cmpd      >U012A,u  ; compare d with >U012A,u and set the condition codes
                    bne       L03D2     ; branch when the values differ or the result is nonzero; target L03D2
                    leax      >U012C,u  ; form the address >U012C,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lda       U0004,u   ; load a from U0004,u
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lbra      L0430     ; continue execution at L0430
L040E               leax      >L01A6,pc ; form the address >L01A6,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lda       U0004,u   ; load a from U0004,u
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lbra      L0430     ; continue execution at L0430
L0423               leax      >L01B3,pc ; form the address >L01B3,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
L0430               leax      >L00F9,pc ; form the address >L00F9,pc in x
                    ldy       >L010B,pc ; load y from >L010B,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      <U003C,u  ; form the address <U003C,u in x
                    ldb       >U0123,u  ; load b from >U0123,u
                    clra                ; clear a to zero and set the condition codes
                    lbsr      L06A1     ; call subroutine L06A1
                    lda       <U003F,u  ; load a from <U003F,u
                    sta       <U004D,u  ; store a at <U004D,u
                    lda       <U0040,u  ; load a from <U0040,u
                    sta       <U004E,u  ; store a at <U004E,u
                    lda       #47       ; set a to the constant 47
                    sta       <U004F,u  ; store a at <U004F,u
                    ldb       >U0124,u  ; load b from >U0124,u
                    clra                ; clear a to zero and set the condition codes
                    leax      <U003C,u  ; form the address <U003C,u in x
                    lbsr      L06A1     ; call subroutine L06A1
                    lda       <U003F,u  ; load a from <U003F,u
                    sta       <U0050,u  ; store a at <U0050,u
                    lda       <U0040,u  ; load a from <U0040,u
                    sta       <U0051,u  ; store a at <U0051,u
                    lda       #47       ; set a to the constant 47
                    sta       <U0052,u  ; store a at <U0052,u
                    ldb       >U0122,u  ; load b from >U0122,u
                    clra                ; clear a to zero and set the condition codes
                    leax      <U003C,u  ; form the address <U003C,u in x
                    lbsr      L06A1     ; call subroutine L06A1
                    lda       <U003F,u  ; load a from <U003F,u
                    sta       <U0053,u  ; store a at <U0053,u
                    lda       <U0040,u  ; load a from <U0040,u
                    sta       <U0054,u  ; store a at <U0054,u
                    lda       #32       ; set a to the constant 32
                    sta       <U0055,u  ; store a at <U0055,u
                    ldb       >U0125,u  ; load b from >U0125,u
                    clra                ; clear a to zero and set the condition codes
                    leax      <U003C,u  ; form the address <U003C,u in x
                    lbsr      L06A1     ; call subroutine L06A1
                    lda       <U003F,u  ; load a from <U003F,u
                    sta       <U0056,u  ; store a at <U0056,u
                    lda       <U0040,u  ; load a from <U0040,u
                    sta       <U0057,u  ; store a at <U0057,u
                    lda       #58       ; set a to the constant 58
                    sta       <U0058,u  ; store a at <U0058,u
                    ldb       >U0126,u  ; load b from >U0126,u
                    clra                ; clear a to zero and set the condition codes
                    leax      <U003C,u  ; form the address <U003C,u in x
                    lbsr      L06A1     ; call subroutine L06A1
                    lda       <U003F,u  ; load a from <U003F,u
                    sta       <U0059,u  ; store a at <U0059,u
                    lda       <U0040,u  ; load a from <U0040,u
                    sta       <U005A,u  ; store a at <U005A,u
                    lda       #13       ; set a to the constant 13
                    sta       <U005B,u  ; store a at <U005B,u
                    leax      <U004D,u  ; form the address <U004D,u in x
L04CD               lda       ,x+       ; load a from ,x+
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       L04CD     ; branch when the values are equal or the result is zero; target L04CD
                    leax      -$01,x    ; form the address -$01,x in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L062E     ; branch when carry reports an error or unsigned underflow; target L062E
                    leax      >L0102,pc ; form the address >L0102,pc in x
                    ldy       >L010B,pc ; load y from >L010B,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      >U0104,u  ; form the address >U0104,u in x
                    ldy       #30       ; set y to the constant 30
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L062E     ; branch when carry reports an error or unsigned underflow; target L062E
                    bra       L0511     ; continue execution at L0511
L0501               leax      >L00C4,pc ; form the address >L00C4,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbra      L0326     ; continue execution at L0326
L0511               leax      >L010D,pc ; form the address >L010D,pc in x
                    ldy       #80       ; set y to the constant 80
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lda       U0002,u   ; load a from U0002,u
                    ldx       >U00EC,u  ; load x from >U00EC,u
                    pshs      u         ; save u on the stack
                    ldu       >U00EE,u  ; load u from >U00EE,u
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    lbcs      L062E     ; branch when carry reports an error or unsigned underflow; target L062E
                    puls      u         ; restore u from the stack
L0533               clra                ; clear a to zero and set the condition codes
                    ldb       #1        ; set b to the constant 1
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    bcs       L054C     ; branch when carry reports an error or unsigned underflow; target L054C
                    leax      U0000,u   ; form the address U0000,u in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lda       U0000,u   ; load a from U0000,u
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    lbeq      L0326     ; branch when the values are equal or the result is zero; target L0326
L054C               lda       U0002,u   ; load a from U0002,u
                    leax      >U009C,u  ; form the address >U009C,u in x
                    ldy       #80       ; set y to the constant 80
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bhi       L0533     ; branch when the unsigned value is higher; target L0533
                    leax      >L010D,pc ; form the address >L010D,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L014E,pc ; form the address >L014E,pc in x
                    ldy       #5        ; set y to the constant 5
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    ldd       U0008,u   ; load d from U0008,u
                    addd      #1        ; add to d using #1
                    std       U0008,u   ; store d at U0008,u
                    lbra      L0326     ; continue execution at L0326
L0586               leax      >L017E,pc ; form the address >L017E,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    bcc       L059A     ; branch when carry is clear; target L059A
                    ldb       #27       ; set b to the constant 27
                    os9       I$Create  ; invoke the OS-9 I$Create service
                    lbcs      L062E     ; branch when carry reports an error or unsigned underflow; target L062E
L059A               sta       U0007,u   ; store a at U0007,u
L059C               leax      U000C,u   ; form the address U000C,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       U0007,u   ; load a from U0007,u
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    bcs       L05B2     ; branch when carry reports an error or unsigned underflow; target L05B2
                    ldd       U000C,u   ; load d from U000C,u
                    cmpd      U000A,u   ; compare d with U000A,u and set the condition codes
                    bne       L059C     ; branch when the values differ or the result is nonzero; target L059C
                    bra       L05BB     ; continue execution at L05BB
L05B2               cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      L062E     ; branch when the values differ or the result is nonzero; target L062E
                    lbra      L05F7     ; continue execution at L05F7
L05BB               ldd       <U0018,u  ; load d from <U0018,u
                    addd      U0008,u   ; add to d using U0008,u
                    std       <U0018,u  ; store d at <U0018,u
                    lda       U0007,u   ; load a from U0007,u
                    ldb       #5        ; set b to the constant 5
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    tfr       u,d       ; copy the register values specified by u,d
                    subd      #32       ; subtract from d using #32
                    bge       L05D5     ; branch when the signed value is greater than or equal; target L05D5
                    leax      -$01,x    ; form the address -$01,x in x
L05D5               ldu       0,s       ; load u from the current stack frame at 0,s
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       U0007,u   ; load a from U0007,u
                    tfr       y,u       ; copy the register values specified by y,u
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    lbcs      L062E     ; branch when carry reports an error or unsigned underflow; target L062E
                    puls      u         ; restore u from the stack
                    leax      U000C,u   ; form the address U000C,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       U0007,u   ; load a from U0007,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lbra      L062D     ; continue execution at L062D
L05F7               leax      U000C,u   ; form the address U000C,u in x
                    ldd       #1        ; set d to the constant 1
                    std       U000E,u   ; store d at U000E,u
                    std       <U0018,u  ; store d at <U0018,u
                    ldd       #0        ; set d to the constant 0
                    std       <U0016,u  ; store d at <U0016,u
                    std       <U001C,u  ; store d at <U001C,u
                    std       <U001A,u  ; store d at <U001A,u
                    ldd       U000A,u   ; load d from U000A,u
                    std       U000C,u   ; store d at U000C,u
                    leax      <U0010,u  ; form the address <U0010,u in x
                    os9       F$Time    ; invoke the OS-9 F$Time service
                    lbcs      L062E     ; branch when carry reports an error or unsigned underflow; target L062E
                    leax      U000C,u   ; form the address U000C,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       U0007,u   ; load a from U0007,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lbcs      L062E     ; branch when carry reports an error or unsigned underflow; target L062E
L062D               clrb                ; clear b to zero and set the condition codes
L062E               os9       F$Exit    ; invoke the OS-9 F$Exit service
L0631               pshs      y         ; save y on the stack
L0633               lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      L071D     ; branch when the values are equal or the result is zero; target L071D
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L0633     ; branch when carry reports an error or unsigned underflow; target L0633
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L0633     ; branch when the unsigned value is higher; target L0633
                    leax      -$01,x    ; form the address -$01,x in x
L0645               lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L0651     ; branch when carry reports an error or unsigned underflow; target L0651
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L0651     ; branch when the unsigned value is higher; target L0651
                    bra       L0645     ; continue execution at L0645
L0651               pshs      x         ; save x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    clr       <U002E,u  ; clear <U002E,u to zero and set the condition codes
                    clr       <U002F,u  ; clear <U002F,u to zero and set the condition codes
                    ldd       #1        ; set d to the constant 1
                    std       <U0030,u  ; store d at <U0030,u
L0661               lda       ,-x       ; load a from ,-x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L069A     ; branch when carry reports an error or unsigned underflow; target L069A
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L069A     ; branch when the unsigned value is higher; target L069A
                    suba      #48       ; subtract from a using #48
                    sta       U0006,u   ; store a at U0006,u
                    ldd       #0        ; set d to the constant 0
L0672               tst       U0006,u   ; set condition codes from U0006,u without changing it
                    beq       L067D     ; branch when the values are equal or the result is zero; target L067D
                    addd      <U0030,u  ; add to d using <U0030,u
                    dec       U0006,u   ; decrement the value at U0006,u
                    bra       L0672     ; continue execution at L0672
L067D               addd      <U002E,u  ; add to d using <U002E,u
                    std       <U002E,u  ; store d at <U002E,u
                    lda       #10       ; set a to the constant 10
                    sta       U0006,u   ; store a at U0006,u
                    ldd       #0        ; set d to the constant 0
L068A               tst       U0006,u   ; set condition codes from U0006,u without changing it
                    beq       L0695     ; branch when the values are equal or the result is zero; target L0695
                    addd      <U0030,u  ; add to d using <U0030,u
                    dec       U0006,u   ; decrement the value at U0006,u
                    bra       L068A     ; continue execution at L068A
L0695               std       <U0030,u  ; store d at <U0030,u
                    bra       L0661     ; continue execution at L0661
L069A               ldd       <U002E,u  ; load d from <U002E,u
                    puls      x         ; restore x from the stack
                    puls      pc,y      ; restore pc,y and return to the caller
L06A1               pshs      x         ; save x on the stack
                    std       <U002E,u  ; store d at <U002E,u
                    lda       #48       ; set a to the constant 48
                    sta       0,x       ; store a at 0,x
                    sta       $01,x     ; store a at $01,x
                    sta       $02,x     ; store a at $02,x
                    sta       $03,x     ; store a at $03,x
                    sta       $04,x     ; store a at $04,x
                    ldd       #10000    ; set d to the constant 10000
                    std       <U0030,u  ; store d at <U0030,u
                    ldd       <U002E,u  ; load d from <U002E,u
                    lbsr      L070B     ; call subroutine L070B
                    ldd       #1000     ; set d to the constant 1000
                    std       <U0030,u  ; store d at <U0030,u
                    ldd       <U002E,u  ; load d from <U002E,u
                    bsr       L070B     ; call subroutine L070B
                    ldd       #100      ; set d to the constant 100
                    std       <U0030,u  ; store d at <U0030,u
                    ldd       <U002E,u  ; load d from <U002E,u
                    bsr       L070B     ; call subroutine L070B
                    ldd       #10       ; set d to the constant 10
                    std       <U0030,u  ; store d at <U0030,u
                    ldd       <U002E,u  ; load d from <U002E,u
                    bsr       L070B     ; call subroutine L070B
                    ldd       #1        ; set d to the constant 1
                    std       <U0030,u  ; store d at <U0030,u
                    ldd       <U002E,u  ; load d from <U002E,u
                    bsr       L070B     ; call subroutine L070B
                    lda       #13       ; set a to the constant 13
                    sta       0,x       ; store a at 0,x
                    puls      x         ; restore x from the stack
                    ldb       #32       ; set b to the constant 32
L06F2               lda       0,x       ; load a from 0,x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bne       L06FC     ; branch when the values differ or the result is nonzero; target L06FC
                    stb       ,x+       ; store b at ,x+
                    bra       L06F2     ; continue execution at L06F2
L06FC               lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L0708     ; branch when carry reports an error or unsigned underflow; target L0708
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L0708     ; branch when the unsigned value is higher; target L0708
                    bra       L06FC     ; continue execution at L06FC
L0708               leax      -$01,x    ; form the address -$01,x in x
                    rts                 ; return to the caller
L070B               subd      <U0030,u  ; subtract from d using <U0030,u
                    bcs       L0714     ; branch when carry reports an error or unsigned underflow; target L0714
                    inc       0,x       ; increment the value at 0,x
                    bra       L070B     ; continue execution at L070B
L0714               addd      <U0030,u  ; add to d using <U0030,u
                    std       <U002E,u  ; store d at <U002E,u
                    leax      $01,x     ; form the address $01,x in x
                    rts                 ; return to the caller
L071D               ldd       #-1       ; set d to the constant -1
                    puls      pc,y      ; restore pc,y and return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
