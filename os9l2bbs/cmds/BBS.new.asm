**********************************************************************
* BBS.new - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       BBS.new
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
U0007               rmb       3         ; reserve 3 byte(s) in the module workspace
U000A               rmb       1         ; reserve 1 byte(s) in the module workspace
U000B               rmb       1         ; reserve 1 byte(s) in the module workspace
U000C               rmb       2         ; reserve 2 byte(s) in the module workspace
U000E               rmb       2         ; reserve 2 byte(s) in the module workspace
U0010               rmb       2         ; reserve 2 byte(s) in the module workspace
U0012               rmb       2         ; reserve 2 byte(s) in the module workspace
U0014               rmb       2         ; reserve 2 byte(s) in the module workspace
U0016               rmb       2         ; reserve 2 byte(s) in the module workspace
U0018               rmb       2         ; reserve 2 byte(s) in the module workspace
U001A               rmb       6         ; reserve 6 byte(s) in the module workspace
U0020               rmb       2         ; reserve 2 byte(s) in the module workspace
U0022               rmb       2         ; reserve 2 byte(s) in the module workspace
U0024               rmb       2         ; reserve 2 byte(s) in the module workspace
U0026               rmb       16        ; reserve 16 byte(s) in the module workspace
U0036               rmb       6         ; reserve 6 byte(s) in the module workspace
U003C               rmb       3         ; reserve 3 byte(s) in the module workspace
U003F               rmb       1         ; reserve 1 byte(s) in the module workspace
U0040               rmb       9         ; reserve 9 byte(s) in the module workspace
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

name                fcs       /BBS.new/ ; store an OS-9 high-bit-terminated string
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
L007F               fcc       "BBS.msg.inx" ; store literal character data
                    fcb       $0D       ; store byte data
L008B               fcc       "BBS.msg" ; store literal character data
                    fcb       $0D       ; store byte data
L0093               fcc       "******   DELETED   ******" ; store literal character data
                    fcb       $0D       ; store byte data
L00AD               fcc       "Message :" ; store literal character data
L00B6               fcc       "From    :" ; store literal character data
L00BF               fcc       "To      :" ; store literal character data
L00C8               fcc       "Left on :" ; store literal character data
L00D1               fcc       "About   :" ; store literal character data
L00DA               fcb       $00       ; store byte data
                    fcb       $09       ; store byte data
L00DC               fcc       "----------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
L011D               fcb       $0A       ; store byte data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
L0120               fcc       "Press <SPACE> to skip a message" ; store literal character data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
L0141               fcc       "BBS.msg.lst" ; store literal character data
                    fcb       $0D       ; store byte data
L014D               fcc       "No new messages to read." ; store literal character data
                    fcb       $0D       ; store byte data
L0166               fcc       "/dd/bbs/BBS.userstats" ; store literal character data
                    fcb       $0D       ; store byte data
L017C               fcc       "/dd/bbs/BBS.alias" ; store literal character data
                    fcb       $0D       ; store byte data
L018E               fcc       "Unknown User" ; store literal character data
                    fcb       $0D       ; store byte data
L019B               fcc       "All Users" ; store literal character data
                    fcb       $0D       ; store byte data

start               os9       F$ID      ; invoke the OS-9 F$ID service
                    sty       U000E,u   ; store y at U000E,u
                    ldy       #0        ; set y to the constant 0
                    sty       <U0014,u  ; store y at <U0014,u
                    os9       F$SUser   ; invoke the OS-9 F$SUser service
                    leax      >L007F,pc ; form the address >L007F,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L061C     ; branch when carry reports an error or unsigned underflow; target L061C
                    sta       U0001,u   ; store a at U0001,u
                    leax      >L008B,pc ; form the address >L008B,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L061C     ; branch when carry reports an error or unsigned underflow; target L061C
                    sta       U0002,u   ; store a at U0002,u
                    leax      >L0141,pc ; form the address >L0141,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    bcc       L01EE     ; branch when carry is clear; target L01EE
                    cmpb      #216      ; compare b with #216 and set the condition codes
                    lbne      L061C     ; branch when the values differ or the result is nonzero; target L061C
                    ldb       #3        ; set b to the constant 3
                    os9       I$Create  ; invoke the OS-9 I$Create service
                    lbcs      L061C     ; branch when carry reports an error or unsigned underflow; target L061C
L01EE               sta       U0003,u   ; store a at U0003,u
                    leax      <U005C,u  ; form the address <U005C,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       U0001,u   ; load a from U0001,u
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lbcs      L061C     ; branch when carry reports an error or unsigned underflow; target L061C
L0200               lda       U0003,u   ; load a from U0003,u
                    leax      <U0010,u  ; form the address <U0010,u in x
                    ldy       #4        ; set y to the constant 4
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    bcs       L0221     ; branch when carry reports an error or unsigned underflow; target L0221
                    ldd       <U0010,u  ; load d from <U0010,u
                    cmpd      U000E,u   ; compare d with U000E,u and set the condition codes
                    bne       L0200     ; branch when the values differ or the result is nonzero; target L0200
                    ldd       <U0012,u  ; load d from <U0012,u
                    addd      #1        ; add to d using #1
                    std       <U0036,u  ; store d at <U0036,u
                    bra       L022D     ; continue execution at L022D
L0221               cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      L061C     ; branch when the values differ or the result is nonzero; target L061C
                    ldd       #1        ; set d to the constant 1
                    std       <U0036,u  ; store d at <U0036,u
L022D               ldd       <U0036,u  ; load d from <U0036,u
                    cmpd      <U005C,u  ; compare d with <U005C,u and set the condition codes
                    lbhi      L060E     ; branch when the unsigned value is higher; target L060E
                    clr       <U0049,u  ; clear <U0049,u to zero and set the condition codes
                    clr       <U004A,u  ; clear <U004A,u to zero and set the condition codes
                    lda       #6        ; set a to the constant 6
                    sta       U0005,u   ; store a at U0005,u
                    ldd       <U0036,u  ; load d from <U0036,u
L0245               aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    rol       <U004A,u  ; rotate left through carry the value at <U004A,u
                    dec       U0005,u   ; decrement the value at U0005,u
                    bne       L0245     ; branch when the values differ or the result is nonzero; target L0245
                    std       <U004B,u  ; store d at <U004B,u
                    ldx       <U0049,u  ; load x from <U0049,u
                    lda       U0001,u   ; load a from U0001,u
                    pshs      u         ; save u on the stack
                    ldu       <U004B,u  ; load u from <U004B,u
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    lbcs      L061C     ; branch when carry reports an error or unsigned underflow; target L061C
                    puls      u         ; restore u from the stack
                    ldd       <U0036,u  ; load d from <U0036,u
                    subd      #1        ; subtract from d using #1
                    std       <U0036,u  ; store d at <U0036,u
                    lda       U0003,u   ; load a from U0003,u
                    pshs      u         ; save u on the stack
                    ldu       #0        ; set u to the constant 0
                    tfr       u,x       ; copy the register values specified by u,x
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    puls      u         ; restore u from the stack
                    lbcs      L061C     ; branch when carry reports an error or unsigned underflow; target L061C
L027F               lda       U0003,u   ; load a from U0003,u
                    leax      <U0010,u  ; form the address <U0010,u in x
                    ldy       #4        ; set y to the constant 4
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    bcs       L02C6     ; branch when carry reports an error or unsigned underflow; target L02C6
                    ldd       <U0010,u  ; load d from <U0010,u
                    cmpd      U000E,u   ; compare d with U000E,u and set the condition codes
                    bne       L027F     ; branch when the values differ or the result is nonzero; target L027F
                    ldd       <U0012,u  ; load d from <U0012,u
                    cmpd      <U005C,u  ; compare d with <U005C,u and set the condition codes
                    bcc       L02E5     ; branch when carry is clear; target L02E5
                    pshs      u         ; save u on the stack
                    lda       U0003,u   ; load a from U0003,u
                    ldb       #5        ; set b to the constant 5
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    lbcs      L061C     ; branch when carry reports an error or unsigned underflow; target L061C
                    leau      -$02,u    ; form the workspace or data address -$02,u in u
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    puls      u         ; restore u from the stack
                    lbcs      L061C     ; branch when carry reports an error or unsigned underflow; target L061C
                    leax      <U005C,u  ; form the address <U005C,u in x
                    ldy       #2        ; set y to the constant 2
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L061C     ; branch when carry reports an error or unsigned underflow; target L061C
                    bra       L02E5     ; continue execution at L02E5
L02C6               cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      L061C     ; branch when the values differ or the result is nonzero; target L061C
                    lda       U0003,u   ; load a from U0003,u
                    leax      U000E,u   ; form the address U000E,u in x
                    ldy       #2        ; set y to the constant 2
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L061C     ; branch when carry reports an error or unsigned underflow; target L061C
                    leax      <U005C,u  ; form the address <U005C,u in x
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L061C     ; branch when carry reports an error or unsigned underflow; target L061C
L02E5               lda       U0003,u   ; load a from U0003,u
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lbcs      L061C     ; branch when carry reports an error or unsigned underflow; target L061C
                    leax      >L0120,pc ; form the address >L0120,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
L02FB               lda       U0001,u   ; load a from U0001,u
                    ldy       #64       ; set y to the constant 64
                    leax      >U00EC,u  ; form the address >U00EC,u in x
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lbcs      L055D     ; branch when carry reports an error or unsigned underflow; target L055D
                    ldd       <U0036,u  ; load d from <U0036,u
                    addd      #1        ; add to d using #1
                    std       <U0036,u  ; store d at <U0036,u
                    leax      >L011D,pc ; form the address >L011D,pc in x
                    ldy       #2        ; set y to the constant 2
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    ldd       <U0036,u  ; load d from <U0036,u
                    leax      <U003C,u  ; form the address <U003C,u in x
                    lbsr      L0686     ; call subroutine L0686
                    leax      >L00AD,pc ; form the address >L00AD,pc in x
                    ldy       >L00DA,pc ; load y from >L00DA,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L061C     ; branch when carry reports an error or unsigned underflow; target L061C
                    leax      <U003C,u  ; form the address <U003C,u in x
L0340               lda       ,x+       ; load a from ,x+
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       L0340     ; branch when the values are equal or the result is zero; target L0340
                    leax      -$01,x    ; form the address -$01,x in x
                    ldy       #6        ; set y to the constant 6
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L061C     ; branch when carry reports an error or unsigned underflow; target L061C
                    ldd       >U00EC,u  ; load d from >U00EC,u
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    lbeq      L04D6     ; branch when the values are equal or the result is zero; target L04D6
                    leax      >L00B6,pc ; form the address >L00B6,pc in x
                    ldy       >L00DA,pc ; load y from >L00DA,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      >U00F0,u  ; form the address >U00F0,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L061C     ; branch when carry reports an error or unsigned underflow; target L061C
                    leax      >L00BF,pc ; form the address >L00BF,pc in x
                    ldy       >L00DA,pc ; load y from >L00DA,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    ldd       >U012A,u  ; load d from >U012A,u
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    beq       L03F8     ; branch when the values are equal or the result is zero; target L03F8
                    leax      >L017C,pc ; form the address >L017C,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L061C     ; branch when carry reports an error or unsigned underflow; target L061C
                    sta       U0004,u   ; store a at U0004,u
L03A7               leax      >U012C,u  ; form the address >U012C,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       U0004,u   ; load a from U0004,u
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    bcs       L03E3     ; branch when carry reports an error or unsigned underflow; target L03E3
                    leax      >U012C,u  ; form the address >U012C,u in x
L03BA               lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    bne       L03BA     ; branch when the values differ or the result is nonzero; target L03BA
                    lda       #13       ; set a to the constant 13
                    sta       -$01,x    ; store a at -$01,x
                    lbsr      L061F     ; call subroutine L061F
                    cmpd      >U012A,u  ; compare d with >U012A,u and set the condition codes
                    bne       L03A7     ; branch when the values differ or the result is nonzero; target L03A7
                    leax      >U012C,u  ; form the address >U012C,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lda       U0004,u   ; load a from U0004,u
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lbra      L0405     ; continue execution at L0405
L03E3               leax      >L018E,pc ; form the address >L018E,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lda       U0004,u   ; load a from U0004,u
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lbra      L0405     ; continue execution at L0405
L03F8               leax      >L019B,pc ; form the address >L019B,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
L0405               leax      >L00C8,pc ; form the address >L00C8,pc in x
                    ldy       >L00DA,pc ; load y from >L00DA,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      <U003C,u  ; form the address <U003C,u in x
                    ldb       >U0123,u  ; load b from >U0123,u
                    clra                ; clear a to zero and set the condition codes
                    lbsr      L0686     ; call subroutine L0686
                    lda       <U003F,u  ; load a from <U003F,u
                    sta       <U004D,u  ; store a at <U004D,u
                    lda       <U0040,u  ; load a from <U0040,u
                    sta       <U004E,u  ; store a at <U004E,u
                    lda       #47       ; set a to the constant 47
                    sta       <U004F,u  ; store a at <U004F,u
                    ldb       >U0124,u  ; load b from >U0124,u
                    clra                ; clear a to zero and set the condition codes
                    leax      <U003C,u  ; form the address <U003C,u in x
                    lbsr      L0686     ; call subroutine L0686
                    lda       <U003F,u  ; load a from <U003F,u
                    sta       <U0050,u  ; store a at <U0050,u
                    lda       <U0040,u  ; load a from <U0040,u
                    sta       <U0051,u  ; store a at <U0051,u
                    lda       #47       ; set a to the constant 47
                    sta       <U0052,u  ; store a at <U0052,u
                    ldb       >U0122,u  ; load b from >U0122,u
                    clra                ; clear a to zero and set the condition codes
                    leax      <U003C,u  ; form the address <U003C,u in x
                    lbsr      L0686     ; call subroutine L0686
                    lda       <U003F,u  ; load a from <U003F,u
                    sta       <U0053,u  ; store a at <U0053,u
                    lda       <U0040,u  ; load a from <U0040,u
                    sta       <U0054,u  ; store a at <U0054,u
                    lda       #32       ; set a to the constant 32
                    sta       <U0055,u  ; store a at <U0055,u
                    ldb       >U0125,u  ; load b from >U0125,u
                    clra                ; clear a to zero and set the condition codes
                    leax      <U003C,u  ; form the address <U003C,u in x
                    lbsr      L0686     ; call subroutine L0686
                    lda       <U003F,u  ; load a from <U003F,u
                    sta       <U0056,u  ; store a at <U0056,u
                    lda       <U0040,u  ; load a from <U0040,u
                    sta       <U0057,u  ; store a at <U0057,u
                    lda       #58       ; set a to the constant 58
                    sta       <U0058,u  ; store a at <U0058,u
                    ldb       >U0126,u  ; load b from >U0126,u
                    clra                ; clear a to zero and set the condition codes
                    leax      <U003C,u  ; form the address <U003C,u in x
                    lbsr      L0686     ; call subroutine L0686
                    lda       <U003F,u  ; load a from <U003F,u
                    sta       <U0059,u  ; store a at <U0059,u
                    lda       <U0040,u  ; load a from <U0040,u
                    sta       <U005A,u  ; store a at <U005A,u
                    lda       #13       ; set a to the constant 13
                    sta       <U005B,u  ; store a at <U005B,u
                    leax      <U004D,u  ; form the address <U004D,u in x
L04A2               lda       ,x+       ; load a from ,x+
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       L04A2     ; branch when the values are equal or the result is zero; target L04A2
                    leax      -$01,x    ; form the address -$01,x in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L061C     ; branch when carry reports an error or unsigned underflow; target L061C
                    leax      >L00D1,pc ; form the address >L00D1,pc in x
                    ldy       >L00DA,pc ; load y from >L00DA,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      >U0104,u  ; form the address >U0104,u in x
                    ldy       #30       ; set y to the constant 30
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L061C     ; branch when carry reports an error or unsigned underflow; target L061C
                    bra       L04E6     ; continue execution at L04E6
L04D6               leax      >L0093,pc ; form the address >L0093,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbra      L02FB     ; continue execution at L02FB
L04E6               leax      >L00DC,pc ; form the address >L00DC,pc in x
                    ldy       #80       ; set y to the constant 80
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lda       U0002,u   ; load a from U0002,u
                    ldx       >U00EC,u  ; load x from >U00EC,u
                    pshs      u         ; save u on the stack
                    ldu       >U00EE,u  ; load u from >U00EE,u
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    lbcs      L061C     ; branch when carry reports an error or unsigned underflow; target L061C
                    puls      u         ; restore u from the stack
L0508               clra                ; clear a to zero and set the condition codes
                    ldb       #1        ; set b to the constant 1
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    bcs       L0521     ; branch when carry reports an error or unsigned underflow; target L0521
                    leax      U0000,u   ; form the address U0000,u in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lda       U0000,u   ; load a from U0000,u
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    lbeq      L02FB     ; branch when the values are equal or the result is zero; target L02FB
L0521               lda       U0002,u   ; load a from U0002,u
                    leax      >U009C,u  ; form the address >U009C,u in x
                    ldy       #80       ; set y to the constant 80
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bhi       L0508     ; branch when the unsigned value is higher; target L0508
                    leax      >L00DC,pc ; form the address >L00DC,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L011D,pc ; form the address >L011D,pc in x
                    ldy       #5        ; set y to the constant 5
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    ldd       <U0014,u  ; load d from <U0014,u
                    addd      #1        ; add to d using #1
                    std       <U0014,u  ; store d at <U0014,u
                    lbra      L02FB     ; continue execution at L02FB
L055D               leax      >L0166,pc ; form the address >L0166,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    bcc       L0571     ; branch when carry is clear; target L0571
                    ldb       #27       ; set b to the constant 27
                    os9       I$Create  ; invoke the OS-9 I$Create service
                    lbcs      L061C     ; branch when carry reports an error or unsigned underflow; target L061C
L0571               sta       U0007,u   ; store a at U0007,u
L0573               leax      <U0016,u  ; form the address <U0016,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       U0007,u   ; load a from U0007,u
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    bcs       L058B     ; branch when carry reports an error or unsigned underflow; target L058B
                    ldd       <U0016,u  ; load d from <U0016,u
                    cmpd      U000E,u   ; compare d with U000E,u and set the condition codes
                    bne       L0573     ; branch when the values differ or the result is nonzero; target L0573
                    bra       L0594     ; continue execution at L0594
L058B               cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      L061C     ; branch when the values differ or the result is nonzero; target L061C
                    lbra      L05D2     ; continue execution at L05D2
L0594               ldd       <U0022,u  ; load d from <U0022,u
                    addd      <U0014,u  ; add to d using <U0014,u
                    std       <U0022,u  ; store d at <U0022,u
                    lda       U0007,u   ; load a from U0007,u
                    ldb       #5        ; set b to the constant 5
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    tfr       u,d       ; copy the register values specified by u,d
                    subd      #32       ; subtract from d using #32
                    bge       L05AF     ; branch when the signed value is greater than or equal; target L05AF
                    leax      -$01,x    ; form the address -$01,x in x
L05AF               ldu       0,s       ; load u from the current stack frame at 0,s
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       U0007,u   ; load a from U0007,u
                    tfr       y,u       ; copy the register values specified by y,u
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    lbcs      L061C     ; branch when carry reports an error or unsigned underflow; target L061C
                    puls      u         ; restore u from the stack
                    leax      <U0016,u  ; form the address <U0016,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       U0007,u   ; load a from U0007,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lbra      L061B     ; continue execution at L061B
L05D2               leax      <U0016,u  ; form the address <U0016,u in x
                    ldd       #1        ; set d to the constant 1
                    std       <U0018,u  ; store d at <U0018,u
                    std       <U0022,u  ; store d at <U0022,u
                    ldd       #0        ; set d to the constant 0
                    std       <U0020,u  ; store d at <U0020,u
                    std       <U0026,u  ; store d at <U0026,u
                    std       <U0024,u  ; store d at <U0024,u
                    ldd       U000E,u   ; load d from U000E,u
                    std       <U0016,u  ; store d at <U0016,u
                    leax      <U001A,u  ; form the address <U001A,u in x
                    os9       F$Time    ; invoke the OS-9 F$Time service
                    lbcs      L061C     ; branch when carry reports an error or unsigned underflow; target L061C
                    leax      <U0016,u  ; form the address <U0016,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       U0007,u   ; load a from U0007,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lbcs      L061C     ; branch when carry reports an error or unsigned underflow; target L061C
                    bra       L061B     ; continue execution at L061B
L060E               leax      >L014D,pc ; form the address >L014D,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
L061B               clrb                ; clear b to zero and set the condition codes
L061C               os9       F$Exit    ; invoke the OS-9 F$Exit service
L061F               pshs      y         ; save y on the stack
L0621               lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      L06F4     ; branch when the values are equal or the result is zero; target L06F4
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L0621     ; branch when carry reports an error or unsigned underflow; target L0621
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L0621     ; branch when the unsigned value is higher; target L0621
                    leax      -$01,x    ; form the address -$01,x in x
L0633               lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L063F     ; branch when carry reports an error or unsigned underflow; target L063F
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L063F     ; branch when the unsigned value is higher; target L063F
                    bra       L0633     ; continue execution at L0633
L063F               pshs      x         ; save x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    clr       U000A,u   ; clear U000A,u to zero and set the condition codes
                    clr       U000B,u   ; clear U000B,u to zero and set the condition codes
                    ldd       #1        ; set d to the constant 1
                    std       U000C,u   ; store d at U000C,u
L064C               lda       ,-x       ; load a from ,-x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L0680     ; branch when carry reports an error or unsigned underflow; target L0680
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L0680     ; branch when the unsigned value is higher; target L0680
                    suba      #48       ; subtract from a using #48
                    sta       U0006,u   ; store a at U0006,u
                    ldd       #0        ; set d to the constant 0
L065D               tst       U0006,u   ; set condition codes from U0006,u without changing it
                    beq       L0667     ; branch when the values are equal or the result is zero; target L0667
                    addd      U000C,u   ; add to d using U000C,u
                    dec       U0006,u   ; decrement the value at U0006,u
                    bra       L065D     ; continue execution at L065D
L0667               addd      U000A,u   ; add to d using U000A,u
                    std       U000A,u   ; store d at U000A,u
                    lda       #10       ; set a to the constant 10
                    sta       U0006,u   ; store a at U0006,u
                    ldd       #0        ; set d to the constant 0
L0672               tst       U0006,u   ; set condition codes from U0006,u without changing it
                    beq       L067C     ; branch when the values are equal or the result is zero; target L067C
                    addd      U000C,u   ; add to d using U000C,u
                    dec       U0006,u   ; decrement the value at U0006,u
                    bra       L0672     ; continue execution at L0672
L067C               std       U000C,u   ; store d at U000C,u
                    bra       L064C     ; continue execution at L064C
L0680               ldd       U000A,u   ; load d from U000A,u
                    puls      x         ; restore x from the stack
                    puls      pc,y      ; restore pc,y and return to the caller
L0686               pshs      x         ; save x on the stack
                    std       U000A,u   ; store d at U000A,u
                    lda       #48       ; set a to the constant 48
                    sta       0,x       ; store a at 0,x
                    sta       $01,x     ; store a at $01,x
                    sta       $02,x     ; store a at $02,x
                    sta       $03,x     ; store a at $03,x
                    sta       $04,x     ; store a at $04,x
                    ldd       #10000    ; set d to the constant 10000
                    std       U000C,u   ; store d at U000C,u
                    ldd       U000A,u   ; load d from U000A,u
                    lbsr      L06E5     ; call subroutine L06E5
                    ldd       #1000     ; set d to the constant 1000
                    std       U000C,u   ; store d at U000C,u
                    ldd       U000A,u   ; load d from U000A,u
                    bsr       L06E5     ; call subroutine L06E5
                    ldd       #100      ; set d to the constant 100
                    std       U000C,u   ; store d at U000C,u
                    ldd       U000A,u   ; load d from U000A,u
                    bsr       L06E5     ; call subroutine L06E5
                    ldd       #10       ; set d to the constant 10
                    std       U000C,u   ; store d at U000C,u
                    ldd       U000A,u   ; load d from U000A,u
                    bsr       L06E5     ; call subroutine L06E5
                    ldd       #1        ; set d to the constant 1
                    std       U000C,u   ; store d at U000C,u
                    ldd       U000A,u   ; load d from U000A,u
                    bsr       L06E5     ; call subroutine L06E5
                    lda       #13       ; set a to the constant 13
                    sta       0,x       ; store a at 0,x
                    puls      x         ; restore x from the stack
                    ldb       #32       ; set b to the constant 32
L06CC               lda       0,x       ; load a from 0,x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bne       L06D6     ; branch when the values differ or the result is nonzero; target L06D6
                    stb       ,x+       ; store b at ,x+
                    bra       L06CC     ; continue execution at L06CC
L06D6               lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L06E2     ; branch when carry reports an error or unsigned underflow; target L06E2
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L06E2     ; branch when the unsigned value is higher; target L06E2
                    bra       L06D6     ; continue execution at L06D6
L06E2               leax      -$01,x    ; form the address -$01,x in x
                    rts                 ; return to the caller
L06E5               subd      U000C,u   ; subtract from d using U000C,u
                    bcs       L06ED     ; branch when carry reports an error or unsigned underflow; target L06ED
                    inc       0,x       ; increment the value at 0,x
                    bra       L06E5     ; continue execution at L06E5
L06ED               addd      U000C,u   ; add to d using U000C,u
                    std       U000A,u   ; store d at U000A,u
                    leax      $01,x     ; form the address $01,x in x
                    rts                 ; return to the caller
L06F4               ldd       #-1       ; set d to the constant -1
                    puls      pc,y      ; restore pc,y and return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
