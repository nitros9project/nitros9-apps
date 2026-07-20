**********************************************************************
* BBS.read - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       BBS.read
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
U0006               rmb       3         ; reserve 3 byte(s) in the module workspace
U0009               rmb       1         ; reserve 1 byte(s) in the module workspace
U000A               rmb       1         ; reserve 1 byte(s) in the module workspace
U000B               rmb       2         ; reserve 2 byte(s) in the module workspace
U000D               rmb       2         ; reserve 2 byte(s) in the module workspace
U000F               rmb       2         ; reserve 2 byte(s) in the module workspace
U0011               rmb       2         ; reserve 2 byte(s) in the module workspace
U0013               rmb       2         ; reserve 2 byte(s) in the module workspace
U0015               rmb       2         ; reserve 2 byte(s) in the module workspace
U0017               rmb       6         ; reserve 6 byte(s) in the module workspace
U001D               rmb       3         ; reserve 3 byte(s) in the module workspace
U0020               rmb       1         ; reserve 1 byte(s) in the module workspace
U0021               rmb       2         ; reserve 2 byte(s) in the module workspace
U0023               rmb       1         ; reserve 1 byte(s) in the module workspace
U0024               rmb       6         ; reserve 6 byte(s) in the module workspace
U002A               rmb       1         ; reserve 1 byte(s) in the module workspace
U002B               rmb       1         ; reserve 1 byte(s) in the module workspace
U002C               rmb       2         ; reserve 2 byte(s) in the module workspace
U002E               rmb       1         ; reserve 1 byte(s) in the module workspace
U002F               rmb       1         ; reserve 1 byte(s) in the module workspace
U0030               rmb       1         ; reserve 1 byte(s) in the module workspace
U0031               rmb       1         ; reserve 1 byte(s) in the module workspace
U0032               rmb       1         ; reserve 1 byte(s) in the module workspace
U0033               rmb       1         ; reserve 1 byte(s) in the module workspace
U0034               rmb       1         ; reserve 1 byte(s) in the module workspace
U0035               rmb       1         ; reserve 1 byte(s) in the module workspace
U0036               rmb       1         ; reserve 1 byte(s) in the module workspace
U0037               rmb       1         ; reserve 1 byte(s) in the module workspace
U0038               rmb       1         ; reserve 1 byte(s) in the module workspace
U0039               rmb       1         ; reserve 1 byte(s) in the module workspace
U003A               rmb       1         ; reserve 1 byte(s) in the module workspace
U003B               rmb       1         ; reserve 1 byte(s) in the module workspace
U003C               rmb       1         ; reserve 1 byte(s) in the module workspace
U003D               rmb       64        ; reserve 64 byte(s) in the module workspace
U007D               rmb       2         ; reserve 2 byte(s) in the module workspace
U007F               rmb       2         ; reserve 2 byte(s) in the module workspace
U0081               rmb       6         ; reserve 6 byte(s) in the module workspace
U0087               rmb       2         ; reserve 2 byte(s) in the module workspace
U0089               rmb       2         ; reserve 2 byte(s) in the module workspace
U008B               rmb       2         ; reserve 2 byte(s) in the module workspace
U008D               rmb       16        ; reserve 16 byte(s) in the module workspace
U009D               rmb       80        ; reserve 80 byte(s) in the module workspace
U00ED               rmb       2         ; reserve 2 byte(s) in the module workspace
U00EF               rmb       2         ; reserve 2 byte(s) in the module workspace
U00F1               rmb       20        ; reserve 20 byte(s) in the module workspace
U0105               rmb       30        ; reserve 30 byte(s) in the module workspace
U0123               rmb       1         ; reserve 1 byte(s) in the module workspace
U0124               rmb       1         ; reserve 1 byte(s) in the module workspace
U0125               rmb       1         ; reserve 1 byte(s) in the module workspace
U0126               rmb       1         ; reserve 1 byte(s) in the module workspace
U0127               rmb       4         ; reserve 4 byte(s) in the module workspace
U012B               rmb       2         ; reserve 2 byte(s) in the module workspace
U012D               rmb       24        ; reserve 24 byte(s) in the module workspace
U0145               rmb       40        ; reserve 40 byte(s) in the module workspace
U016D               rmb       1         ; reserve 1 byte(s) in the module workspace
U016E               rmb       399       ; reserve 399 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.read/ ; store an OS-9 high-bit-terminated string
                    fcc       "Copyright (C) 1988By Keith AlphonsoLicenced to Alpha Software TechnologiesAll rights reserved" ; store literal character data
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
L0080               fcb       $0A       ; store byte data
                    fcc       "High    message is #" ; store literal character data
L0095               fcc       "Current message is #" ; store literal character data
L00A9               fcc       "[N]ext, [P]revious, [T]hread, [R]eply, [q]uit or Msg #" ; store literal character data
                    fcb       $0D       ; store byte data
L00E0               fcc       ">" ; store literal character data
L00E1               fcc       "BBS.msg.inx" ; store literal character data
                    fcb       $0D       ; store byte data
L00ED               fcc       "BBS.msg" ; store literal character data
                    fcb       $0D       ; store byte data
L00F5               fcc       "******   DELETED   ******" ; store literal character data
                    fcb       $0D       ; store byte data
L010F               fcc       "Message :" ; store literal character data
L0118               fcc       "From    :" ; store literal character data
L0121               fcc       "To      :" ; store literal character data
L012A               fcc       "Left on :" ; store literal character data
L0133               fcc       "About   :" ; store literal character data
L013C               fcb       $00       ; store byte data
                    fcb       $09       ; store byte data
L013E               fcc       "----------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
L017F               fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
L0181               fcc       "BBS.msg.lst" ; store literal character data
                    fcb       $0D       ; store byte data
L018D               fcc       "BBS.reply" ; store literal character data
                    fcb       $0D       ; store byte data
L0197               fcc       "/dd/bbs/BBS.userstats" ; store literal character data
                    fcb       $0D       ; store byte data
L01AD               fcc       "/dd/bbs/BBS.alias" ; store literal character data
                    fcb       $0D       ; store byte data
L01BF               fcc       "Unknown User" ; store literal character data
                    fcb       $0D       ; store byte data
L01CC               fcc       "All Users" ; store literal character data
                    fcb       $0D       ; store byte data
start               os9       F$ID      ; invoke the OS-9 F$ID service
                    sty       U000D,u   ; store y at U000D,u
                    ldy       #0        ; set y to the constant 0
                    os9       F$SUser   ; invoke the OS-9 F$SUser service
                    sty       <U0015,u  ; store y at <U0015,u
                    leax      >L00E1,pc ; form the address >L00E1,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L0700     ; branch when carry reports an error or unsigned underflow; target L0700
                    sta       U0000,u   ; store a at U0000,u
                    leax      >L0181,pc ; form the address >L0181,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    bcc       L020A     ; branch when carry is clear; target L020A
                    ldb       #3        ; set b to the constant 3
                    os9       I$Create  ; invoke the OS-9 I$Create service
                    lbcs      L0700     ; branch when carry reports an error or unsigned underflow; target L0700
L020A               sta       U0002,u   ; store a at U0002,u
                    leax      >L00ED,pc ; form the address >L00ED,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L0700     ; branch when carry reports an error or unsigned underflow; target L0700
                    sta       U0001,u   ; store a at U0001,u
                    leax      <U003D,u  ; form the address <U003D,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       U0000,u   ; load a from U0000,u
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lbcs      L0700     ; branch when carry reports an error or unsigned underflow; target L0700
                    ldd       #0        ; set d to the constant 0
                    std       <U0013,u  ; store d at <U0013,u
L0231               ldd       <U003D,u  ; load d from <U003D,u
                    leax      <U0017,u  ; form the address <U0017,u in x
                    lbsr      L076A     ; call subroutine L076A
                    leax      >L0080,pc ; form the address >L0080,pc in x
                    ldy       #21       ; set y to the constant 21
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L0700     ; branch when carry reports an error or unsigned underflow; target L0700
                    leax      <U0017,u  ; form the address <U0017,u in x
                    ldy       #6        ; set y to the constant 6
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L0700     ; branch when carry reports an error or unsigned underflow; target L0700
                    ldd       <U0013,u  ; load d from <U0013,u
                    leax      <U0017,u  ; form the address <U0017,u in x
                    lbsr      L076A     ; call subroutine L076A
                    leax      >L0095,pc ; form the address >L0095,pc in x
                    ldy       #20       ; set y to the constant 20
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L0700     ; branch when carry reports an error or unsigned underflow; target L0700
                    leax      <U0017,u  ; form the address <U0017,u in x
                    ldy       #6        ; set y to the constant 6
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L0700     ; branch when carry reports an error or unsigned underflow; target L0700
                    leax      >L00A9,pc ; form the address >L00A9,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L0700     ; branch when carry reports an error or unsigned underflow; target L0700
                    leax      >L00E0,pc ; form the address >L00E0,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L0700     ; branch when carry reports an error or unsigned underflow; target L0700
                    leax      <U0024,u  ; form the address <U0024,u in x
                    ldy       #6        ; set y to the constant 6
                    clra                ; clear a to zero and set the condition codes
L02A9               os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    bcs       L02A9     ; branch when carry reports an error or unsigned underflow; target L02A9
                    lda       <U0024,u  ; load a from <U0024,u
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    blt       L02D5     ; branch when the signed value is less; target L02D5
                    anda      #223      ; mask a using #223
                    cmpa      #81       ; compare a with #81 and set the condition codes
                    lbeq      L0649     ; branch when the values are equal or the result is zero; target L0649
                    cmpa      #78       ; compare a with #78 and set the condition codes
                    lbeq      L02F4     ; branch when the values are equal or the result is zero; target L02F4
                    cmpa      #80       ; compare a with #80 and set the condition codes
                    lbeq      L0308     ; branch when the values are equal or the result is zero; target L0308
                    cmpa      #84       ; compare a with #84 and set the condition codes
                    lbeq      L0318     ; branch when the values are equal or the result is zero; target L0318
                    cmpa      #82       ; compare a with #82 and set the condition codes
                    lbeq      L035B     ; branch when the values are equal or the result is zero; target L035B
L02D5               clr       <U0023,u  ; clear <U0023,u to zero and set the condition codes
                    leax      <U0024,u  ; form the address <U0024,u in x
                    lbsr      L0703     ; call subroutine L0703
                    cmpd      #0        ; compare d with #0 and set the condition codes
                    lbeq      L0231     ; branch when the values are equal or the result is zero; target L0231
                    cmpd      <U003D,u  ; compare d with <U003D,u and set the condition codes
                    lbhi      L0231     ; branch when the unsigned value is higher; target L0231
                    std       <U0013,u  ; store d at <U0013,u
                    lbra      L0398     ; continue execution at L0398
L02F4               ldd       <U0013,u  ; load d from <U0013,u
                    addd      #1        ; add to d using #1
                    cmpd      <U003D,u  ; compare d with <U003D,u and set the condition codes
                    lbgt      L0231     ; branch when the signed value is greater; target L0231
                    std       <U0013,u  ; store d at <U0013,u
                    lbra      L0398     ; continue execution at L0398
L0308               ldd       <U0013,u  ; load d from <U0013,u
                    subd      #1        ; subtract from d using #1
                    lbeq      L0231     ; branch when the values are equal or the result is zero; target L0231
                    std       <U0013,u  ; store d at <U0013,u
                    lbra      L0398     ; continue execution at L0398
L0318               leax      >U012D,u  ; form the address >U012D,u in x
                    ldy       #64       ; set y to the constant 64
                    lda       U0000,u   ; load a from U0000,u
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    bcs       L034C     ; branch when carry reports an error or unsigned underflow; target L034C
                    ldd       <U0013,u  ; load d from <U0013,u
                    addd      #1        ; add to d using #1
                    std       <U0013,u  ; store d at <U0013,u
                    leay      >U0105,u  ; form the address >U0105,u in y
                    leax      >U0145,u  ; form the address >U0145,u in x
L0338               lda       0,x       ; load a from 0,x
                    anda      #223      ; mask a using #223
                    sta       0,x       ; store a at 0,x
                    lda       ,y+       ; load a from ,y+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L0355     ; branch when the values are equal or the result is zero; target L0355
                    anda      #223      ; mask a using #223
                    cmpa      ,x+       ; compare a with ,x+ and set the condition codes
                    bne       L0318     ; branch when the values differ or the result is nonzero; target L0318
                    bra       L0338     ; continue execution at L0338
L034C               cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      L0700     ; branch when the values differ or the result is nonzero; target L0700
                    lbra      L0231     ; continue execution at L0231
L0355               ldd       <U0013,u  ; load d from <U0013,u
                    lbra      L0398     ; continue execution at L0398
L035B               ldy       U000D,u   ; load y from U000D,u
                    os9       F$SUser   ; invoke the OS-9 F$SUser service
                    lda       #17       ; set a to the constant 17
                    ldb       #3        ; set b to the constant 3
                    leax      >L018D,pc ; form the address >L018D,pc in x
                    ldy       #80       ; set y to the constant 80
                    pshs      u         ; save u on the stack
                    leau      >U0105,u  ; form the workspace or data address >U0105,u in u
                    os9       F$Fork    ; invoke the OS-9 F$Fork service
                    puls      u         ; restore u from the stack
                    lbcs      L0231     ; branch when carry reports an error or unsigned underflow; target L0231
                    clrb                ; clear b to zero and set the condition codes
                    os9       F$Wait    ; invoke the OS-9 F$Wait service
                    tstb                ; set condition codes from b without changing it
                    lbne      L0231     ; branch when the values differ or the result is nonzero; target L0231
                    ldy       #0        ; set y to the constant 0
                    os9       F$SUser   ; invoke the OS-9 F$SUser service
                    ldd       <U003D,u  ; load d from <U003D,u
                    addd      #1        ; add to d using #1
                    std       <U003D,u  ; store d at <U003D,u
                    lbra      L0231     ; continue execution at L0231
L0398               lda       U0002,u   ; load a from U0002,u
                    leax      U000F,u   ; form the address U000F,u in x
                    ldy       #4        ; set y to the constant 4
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    bcs       L03D1     ; branch when carry reports an error or unsigned underflow; target L03D1
                    ldd       U000F,u   ; load d from U000F,u
                    cmpd      U000D,u   ; compare d with U000D,u and set the condition codes
                    bne       L0398     ; branch when the values differ or the result is nonzero; target L0398
                    ldd       <U0011,u  ; load d from <U0011,u
                    cmpd      <U0013,u  ; compare d with <U0013,u and set the condition codes
                    bcc       L03E8     ; branch when carry is clear; target L03E8
                    pshs      u         ; save u on the stack
                    lda       U0002,u   ; load a from U0002,u
                    ldb       #5        ; set b to the constant 5
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    leau      -$02,u    ; form the workspace or data address -$02,u in u
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    puls      u         ; restore u from the stack
                    leax      <U0013,u  ; form the address <U0013,u in x
                    ldy       #2        ; set y to the constant 2
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    bra       L03E8     ; continue execution at L03E8
L03D1               cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      L0700     ; branch when the values differ or the result is nonzero; target L0700
                    lda       U0002,u   ; load a from U0002,u
                    leax      U000D,u   ; form the address U000D,u in x
                    ldy       #2        ; set y to the constant 2
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      <U0013,u  ; form the address <U0013,u in x
                    os9       I$Write   ; invoke the OS-9 I$Write service
L03E8               clr       <U002A,u  ; clear <U002A,u to zero and set the condition codes
                    clr       <U002B,u  ; clear <U002B,u to zero and set the condition codes
                    lda       #6        ; set a to the constant 6
                    sta       U0004,u   ; store a at U0004,u
                    ldd       <U0013,u  ; load d from <U0013,u
L03F5               aslb                ; shift b left arithmetically
                    rola                ; rotate a left through carry
                    rol       <U002B,u  ; rotate left through carry the value at <U002B,u
                    dec       U0004,u   ; decrement the value at U0004,u
                    bne       L03F5     ; branch when the values differ or the result is nonzero; target L03F5
                    std       <U002C,u  ; store d at <U002C,u
                    ldx       <U002A,u  ; load x from <U002A,u
                    lda       U0000,u   ; load a from U0000,u
                    pshs      u         ; save u on the stack
                    ldu       <U002C,u  ; load u from <U002C,u
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    lbcs      L0700     ; branch when carry reports an error or unsigned underflow; target L0700
                    puls      u         ; restore u from the stack
                    lda       U0000,u   ; load a from U0000,u
                    ldy       #64       ; set y to the constant 64
                    leax      >U00ED,u  ; form the address >U00ED,u in x
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lbcs      L0231     ; branch when carry reports an error or unsigned underflow; target L0231
                    leax      >L017F,pc ; form the address >L017F,pc in x
                    ldy       #2        ; set y to the constant 2
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    ldd       <U0013,u  ; load d from <U0013,u
                    leax      <U001D,u  ; form the address <U001D,u in x
                    lbsr      L076A     ; call subroutine L076A
                    leax      >L010F,pc ; form the address >L010F,pc in x
                    ldy       >L013C,pc ; load y from >L013C,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    lbcs      L0700     ; branch when carry reports an error or unsigned underflow; target L0700
                    leax      <U001D,u  ; form the address <U001D,u in x
L0450               lda       ,x+       ; load a from ,x+
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       L0450     ; branch when the values are equal or the result is zero; target L0450
                    leax      -$01,x    ; form the address -$01,x in x
                    ldy       #6        ; set y to the constant 6
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L0700     ; branch when carry reports an error or unsigned underflow; target L0700
                    ldd       >U00ED,u  ; load d from >U00ED,u
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    lbeq      L05E6     ; branch when the values are equal or the result is zero; target L05E6
                    leax      >L0118,pc ; form the address >L0118,pc in x
                    ldy       >L013C,pc ; load y from >L013C,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      >U00F1,u  ; form the address >U00F1,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L0700     ; branch when carry reports an error or unsigned underflow; target L0700
                    leax      >L0121,pc ; form the address >L0121,pc in x
                    ldy       >L013C,pc ; load y from >L013C,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    ldd       >U012B,u  ; load d from >U012B,u
                    cmpd      #-1       ; compare d with #-1 and set the condition codes
                    beq       L0508     ; branch when the values are equal or the result is zero; target L0508
                    leax      >L01AD,pc ; form the address >L01AD,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L0700     ; branch when carry reports an error or unsigned underflow; target L0700
                    sta       U0003,u   ; store a at U0003,u
L04B7               leax      >U016D,u  ; form the address >U016D,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       U0003,u   ; load a from U0003,u
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    bcs       L04F3     ; branch when carry reports an error or unsigned underflow; target L04F3
                    leax      >U016D,u  ; form the address >U016D,u in x
L04CA               lda       ,x+       ; load a from ,x+
                    cmpa      #44       ; compare a with #44 and set the condition codes
                    bne       L04CA     ; branch when the values differ or the result is nonzero; target L04CA
                    lda       #13       ; set a to the constant 13
                    sta       -$01,x    ; store a at -$01,x
                    lbsr      L0703     ; call subroutine L0703
                    cmpd      >U012B,u  ; compare d with >U012B,u and set the condition codes
                    bne       L04B7     ; branch when the values differ or the result is nonzero; target L04B7
                    leax      >U016D,u  ; form the address >U016D,u in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lda       U0003,u   ; load a from U0003,u
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lbra      L0515     ; continue execution at L0515
L04F3               leax      >L01BF,pc ; form the address >L01BF,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lda       U0003,u   ; load a from U0003,u
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lbra      L0515     ; continue execution at L0515
L0508               leax      >L01CC,pc ; form the address >L01CC,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
L0515               leax      >L012A,pc ; form the address >L012A,pc in x
                    ldy       >L013C,pc ; load y from >L013C,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      <U001D,u  ; form the address <U001D,u in x
                    ldb       >U0124,u  ; load b from >U0124,u
                    clra                ; clear a to zero and set the condition codes
                    lbsr      L076A     ; call subroutine L076A
                    lda       <U0020,u  ; load a from <U0020,u
                    sta       <U002E,u  ; store a at <U002E,u
                    lda       <U0021,u  ; load a from <U0021,u
                    sta       <U002F,u  ; store a at <U002F,u
                    lda       #47       ; set a to the constant 47
                    sta       <U0030,u  ; store a at <U0030,u
                    ldb       >U0125,u  ; load b from >U0125,u
                    clra                ; clear a to zero and set the condition codes
                    leax      <U001D,u  ; form the address <U001D,u in x
                    lbsr      L076A     ; call subroutine L076A
                    lda       <U0020,u  ; load a from <U0020,u
                    sta       <U0031,u  ; store a at <U0031,u
                    lda       <U0021,u  ; load a from <U0021,u
                    sta       <U0032,u  ; store a at <U0032,u
                    lda       #47       ; set a to the constant 47
                    sta       <U0033,u  ; store a at <U0033,u
                    ldb       >U0123,u  ; load b from >U0123,u
                    clra                ; clear a to zero and set the condition codes
                    leax      <U001D,u  ; form the address <U001D,u in x
                    lbsr      L076A     ; call subroutine L076A
                    lda       <U0020,u  ; load a from <U0020,u
                    sta       <U0034,u  ; store a at <U0034,u
                    lda       <U0021,u  ; load a from <U0021,u
                    sta       <U0035,u  ; store a at <U0035,u
                    lda       #32       ; set a to the constant 32
                    sta       <U0036,u  ; store a at <U0036,u
                    ldb       >U0126,u  ; load b from >U0126,u
                    clra                ; clear a to zero and set the condition codes
                    leax      <U001D,u  ; form the address <U001D,u in x
                    lbsr      L076A     ; call subroutine L076A
                    lda       <U0020,u  ; load a from <U0020,u
                    sta       <U0037,u  ; store a at <U0037,u
                    lda       <U0021,u  ; load a from <U0021,u
                    sta       <U0038,u  ; store a at <U0038,u
                    lda       #58       ; set a to the constant 58
                    sta       <U0039,u  ; store a at <U0039,u
                    ldb       >U0127,u  ; load b from >U0127,u
                    clra                ; clear a to zero and set the condition codes
                    leax      <U001D,u  ; form the address <U001D,u in x
                    lbsr      L076A     ; call subroutine L076A
                    lda       <U0020,u  ; load a from <U0020,u
                    sta       <U003A,u  ; store a at <U003A,u
                    lda       <U0021,u  ; load a from <U0021,u
                    sta       <U003B,u  ; store a at <U003B,u
                    lda       #13       ; set a to the constant 13
                    sta       <U003C,u  ; store a at <U003C,u
                    leax      <U002E,u  ; form the address <U002E,u in x
L05B2               lda       ,x+       ; load a from ,x+
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    beq       L05B2     ; branch when the values are equal or the result is zero; target L05B2
                    leax      -$01,x    ; form the address -$01,x in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L0700     ; branch when carry reports an error or unsigned underflow; target L0700
                    leax      >L0133,pc ; form the address >L0133,pc in x
                    ldy       >L013C,pc ; load y from >L013C,pc
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      >U0105,u  ; form the address >U0105,u in x
                    ldy       #30       ; set y to the constant 30
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbcs      L0700     ; branch when carry reports an error or unsigned underflow; target L0700
                    bra       L05F6     ; continue execution at L05F6
L05E6               leax      >L00F5,pc ; form the address >L00F5,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbra      L0231     ; continue execution at L0231
L05F6               leax      >L013E,pc ; form the address >L013E,pc in x
                    ldy       #80       ; set y to the constant 80
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lda       U0001,u   ; load a from U0001,u
                    ldx       >U00ED,u  ; load x from >U00ED,u
                    pshs      u         ; save u on the stack
                    ldu       >U00EF,u  ; load u from >U00EF,u
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    lbcs      L0700     ; branch when carry reports an error or unsigned underflow; target L0700
                    puls      u         ; restore u from the stack
L0618               lda       U0001,u   ; load a from U0001,u
                    leax      >U009D,u  ; form the address >U009D,u in x
                    ldy       #80       ; set y to the constant 80
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bhi       L0618     ; branch when the unsigned value is higher; target L0618
                    leax      >L013E,pc ; form the address >L013E,pc in x
                    ldy       #80       ; set y to the constant 80
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    ldd       <U0015,u  ; load d from <U0015,u
                    addd      #1        ; add to d using #1
                    std       <U0015,u  ; store d at <U0015,u
                    lbra      L0231     ; continue execution at L0231
L0649               leax      >L0197,pc ; form the address >L0197,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    bcc       L065D     ; branch when carry is clear; target L065D
                    ldb       #27       ; set b to the constant 27
                    os9       I$Create  ; invoke the OS-9 I$Create service
                    lbcs      L0700     ; branch when carry reports an error or unsigned underflow; target L0700
L065D               sta       U0006,u   ; store a at U0006,u
L065F               leax      <U007D,u  ; form the address <U007D,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       U0006,u   ; load a from U0006,u
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    bcs       L0677     ; branch when carry reports an error or unsigned underflow; target L0677
                    ldd       <U007D,u  ; load d from <U007D,u
                    cmpd      U000D,u   ; compare d with U000D,u and set the condition codes
                    bne       L065F     ; branch when the values differ or the result is nonzero; target L065F
                    bra       L0680     ; continue execution at L0680
L0677               cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      L0700     ; branch when the values differ or the result is nonzero; target L0700
                    lbra      L06C0     ; continue execution at L06C0
L0680               ldd       >U0089,u  ; load d from >U0089,u
                    addd      <U0015,u  ; add to d using <U0015,u
                    std       >U0089,u  ; store d at >U0089,u
                    lda       U0006,u   ; load a from U0006,u
                    ldb       #5        ; set b to the constant 5
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    tfr       u,d       ; copy the register values specified by u,d
                    subd      #32       ; subtract from d using #32
                    bge       L069D     ; branch when the signed value is greater than or equal; target L069D
                    leax      -$01,x    ; form the address -$01,x in x
L069D               ldu       0,s       ; load u from the current stack frame at 0,s
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       U0006,u   ; load a from U0006,u
                    tfr       y,u       ; copy the register values specified by y,u
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    lbcs      L0700     ; branch when carry reports an error or unsigned underflow; target L0700
                    puls      u         ; restore u from the stack
                    leax      <U007D,u  ; form the address <U007D,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       U0006,u   ; load a from U0006,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lbra      L06FF     ; continue execution at L06FF
L06C0               leax      <U007D,u  ; form the address <U007D,u in x
                    ldd       #1        ; set d to the constant 1
                    std       <U007F,u  ; store d at <U007F,u
                    std       >U0089,u  ; store d at >U0089,u
                    ldd       #0        ; set d to the constant 0
                    std       >U0087,u  ; store d at >U0087,u
                    std       >U008D,u  ; store d at >U008D,u
                    std       >U008B,u  ; store d at >U008B,u
                    ldd       U000D,u   ; load d from U000D,u
                    std       <U007D,u  ; store d at <U007D,u
                    leax      >U0081,u  ; form the address >U0081,u in x
                    os9       F$Time    ; invoke the OS-9 F$Time service
                    lbcs      L0700     ; branch when carry reports an error or unsigned underflow; target L0700
                    leax      <U007D,u  ; form the address <U007D,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       U0006,u   ; load a from U0006,u
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lbcs      L0700     ; branch when carry reports an error or unsigned underflow; target L0700
L06FF               clrb                ; clear b to zero and set the condition codes
L0700               os9       F$Exit    ; invoke the OS-9 F$Exit service
L0703               pshs      y         ; save y on the stack
L0705               lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    lbeq      L07D8     ; branch when the values are equal or the result is zero; target L07D8
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L0705     ; branch when carry reports an error or unsigned underflow; target L0705
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L0705     ; branch when the unsigned value is higher; target L0705
                    leax      -$01,x    ; form the address -$01,x in x
L0717               lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L0723     ; branch when carry reports an error or unsigned underflow; target L0723
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L0723     ; branch when the unsigned value is higher; target L0723
                    bra       L0717     ; continue execution at L0717
L0723               pshs      x         ; save x on the stack
                    leax      -$01,x    ; form the address -$01,x in x
                    clr       U0009,u   ; clear U0009,u to zero and set the condition codes
                    clr       U000A,u   ; clear U000A,u to zero and set the condition codes
                    ldd       #1        ; set d to the constant 1
                    std       U000B,u   ; store d at U000B,u
L0730               lda       ,-x       ; load a from ,-x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L0764     ; branch when carry reports an error or unsigned underflow; target L0764
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L0764     ; branch when the unsigned value is higher; target L0764
                    suba      #48       ; subtract from a using #48
                    sta       U0005,u   ; store a at U0005,u
                    ldd       #0        ; set d to the constant 0
L0741               tst       U0005,u   ; set condition codes from U0005,u without changing it
                    beq       L074B     ; branch when the values are equal or the result is zero; target L074B
                    addd      U000B,u   ; add to d using U000B,u
                    dec       U0005,u   ; decrement the value at U0005,u
                    bra       L0741     ; continue execution at L0741
L074B               addd      U0009,u   ; add to d using U0009,u
                    std       U0009,u   ; store d at U0009,u
                    lda       #10       ; set a to the constant 10
                    sta       U0005,u   ; store a at U0005,u
                    ldd       #0        ; set d to the constant 0
L0756               tst       U0005,u   ; set condition codes from U0005,u without changing it
                    beq       L0760     ; branch when the values are equal or the result is zero; target L0760
                    addd      U000B,u   ; add to d using U000B,u
                    dec       U0005,u   ; decrement the value at U0005,u
                    bra       L0756     ; continue execution at L0756
L0760               std       U000B,u   ; store d at U000B,u
                    bra       L0730     ; continue execution at L0730
L0764               ldd       U0009,u   ; load d from U0009,u
                    puls      x         ; restore x from the stack
                    puls      pc,y      ; restore pc,y and return to the caller
L076A               pshs      x         ; save x on the stack
                    std       U0009,u   ; store d at U0009,u
                    lda       #48       ; set a to the constant 48
                    sta       0,x       ; store a at 0,x
                    sta       $01,x     ; store a at $01,x
                    sta       $02,x     ; store a at $02,x
                    sta       $03,x     ; store a at $03,x
                    sta       $04,x     ; store a at $04,x
                    ldd       #10000    ; set d to the constant 10000
                    std       U000B,u   ; store d at U000B,u
                    ldd       U0009,u   ; load d from U0009,u
                    lbsr      L07C9     ; call subroutine L07C9
                    ldd       #1000     ; set d to the constant 1000
                    std       U000B,u   ; store d at U000B,u
                    ldd       U0009,u   ; load d from U0009,u
                    bsr       L07C9     ; call subroutine L07C9
                    ldd       #100      ; set d to the constant 100
                    std       U000B,u   ; store d at U000B,u
                    ldd       U0009,u   ; load d from U0009,u
                    bsr       L07C9     ; call subroutine L07C9
                    ldd       #10       ; set d to the constant 10
                    std       U000B,u   ; store d at U000B,u
                    ldd       U0009,u   ; load d from U0009,u
                    bsr       L07C9     ; call subroutine L07C9
                    ldd       #1        ; set d to the constant 1
                    std       U000B,u   ; store d at U000B,u
                    ldd       U0009,u   ; load d from U0009,u
                    bsr       L07C9     ; call subroutine L07C9
                    lda       #13       ; set a to the constant 13
                    sta       0,x       ; store a at 0,x
                    puls      x         ; restore x from the stack
                    ldb       #32       ; set b to the constant 32
L07B0               lda       0,x       ; load a from 0,x
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bne       L07BA     ; branch when the values differ or the result is nonzero; target L07BA
                    stb       ,x+       ; store b at ,x+
                    bra       L07B0     ; continue execution at L07B0
L07BA               lda       ,x+       ; load a from ,x+
                    cmpa      #48       ; compare a with #48 and set the condition codes
                    bcs       L07C6     ; branch when carry reports an error or unsigned underflow; target L07C6
                    cmpa      #57       ; compare a with #57 and set the condition codes
                    bhi       L07C6     ; branch when the unsigned value is higher; target L07C6
                    bra       L07BA     ; continue execution at L07BA
L07C6               leax      -$01,x    ; form the address -$01,x in x
                    rts                 ; return to the caller
L07C9               subd      U000B,u   ; subtract from d using U000B,u
                    bcs       L07D1     ; branch when carry reports an error or unsigned underflow; target L07D1
                    inc       0,x       ; increment the value at 0,x
                    bra       L07C9     ; continue execution at L07C9
L07D1               addd      U000B,u   ; add to d using U000B,u
                    std       U0009,u   ; store d at U0009,u
                    leax      $01,x     ; form the address $01,x in x
                    rts                 ; return to the caller
L07D8               ldd       #-1       ; set d to the constant -1
                    puls      pc,y      ; restore pc,y and return to the caller

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
