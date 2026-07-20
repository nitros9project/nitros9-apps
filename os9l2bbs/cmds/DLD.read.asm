**********************************************************************
* DLD.read - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       DLD.read
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
U0002               rmb       80        ; reserve 80 byte(s) in the module workspace
U0052               rmb       27        ; reserve 27 byte(s) in the module workspace
U006D               rmb       27        ; reserve 27 byte(s) in the module workspace
U0088               rmb       2         ; reserve 2 byte(s) in the module workspace
U008A               rmb       2         ; reserve 2 byte(s) in the module workspace
U008C               rmb       1         ; reserve 1 byte(s) in the module workspace
U008D               rmb       1         ; reserve 1 byte(s) in the module workspace
U008E               rmb       463       ; reserve 463 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /DLD.read/ ; store an OS-9 high-bit-terminated string
L0015               fcc       "DLD.lst" ; store literal character data
                    fcb       $0D       ; store byte data
L001D               fcc       "DLD.dsc" ; store literal character data
                    fcb       $0D       ; store byte data
L0025               fcc       "Enter filename to read:" ; store literal character data
L003C               fcc       "Filename not found." ; store literal character data
                    fcb       $0D       ; store byte data
L0050               fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
                    fcc       "Name:" ; store literal character data
L0057               fcc       "Desc:" ; store literal character data
L005C               fcc       "--------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
start               lda       0,x       ; load a from 0,x
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L00AA     ; branch when the values are equal or the result is zero; target L00AA
                    lda       #1        ; set a to the constant 1
                    os9       I$ChgDir  ; invoke the OS-9 I$ChgDir service
                    lbcs      L01A7     ; branch when carry reports an error or unsigned underflow; target L01A7
L00AA               leax      >L0015,pc ; form the address >L0015,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L01A7     ; branch when carry reports an error or unsigned underflow; target L01A7
                    sta       U0000,u   ; store a at U0000,u
                    leax      >L001D,pc ; form the address >L001D,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; invoke the OS-9 I$Open service
                    lbcs      L01A7     ; branch when carry reports an error or unsigned underflow; target L01A7
                    sta       U0001,u   ; store a at U0001,u
L00C8               leax      >L0025,pc ; form the address >L0025,pc in x
                    ldy       #23       ; set y to the constant 23
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      <U0052,u  ; form the address <U0052,u in x
                    ldy       #27       ; set y to the constant 27
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    lbcs      L00C8     ; branch when carry reports an error or unsigned underflow; target L00C8
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    lble      L01A6     ; branch when the signed value is less than or equal; target L01A6
L00EC               lda       0,x       ; load a from 0,x
                    anda      #223      ; mask a using #223
                    sta       ,x+       ; store a at ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       L00EC     ; branch when the values differ or the result is nonzero; target L00EC
L00F6               leax      <U006D,u  ; form the address <U006D,u in x
                    lda       U0000,u   ; load a from U0000,u
                    ldy       #96       ; set y to the constant 96
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$Read    ; invoke the OS-9 I$Read service
                    lbcs      L0120     ; branch when carry reports an error or unsigned underflow; target L0120
                    tst       >U008C,u  ; set condition codes from >U008C,u without changing it
                    beq       L00F6     ; branch when the values are equal or the result is zero; target L00F6
                    leay      <U0052,u  ; form the address <U0052,u in y
L0110               lda       0,y       ; load a from 0,y
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       L0136     ; branch when the values are equal or the result is zero; target L0136
                    lda       ,x+       ; load a from ,x+
                    anda      #223      ; mask a using #223
                    cmpa      ,y+       ; compare a with ,y+ and set the condition codes
                    bne       L00F6     ; branch when the values differ or the result is nonzero; target L00F6
                    bra       L0110     ; continue execution at L0110
L0120               cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      L01A7     ; branch when the values differ or the result is nonzero; target L01A7
                    leax      >L003C,pc ; form the address >L003C,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lbra      L01A6     ; continue execution at L01A6
L0136               leax      >L0050,pc ; form the address >L0050,pc in x
                    ldy       #7        ; set y to the constant 7
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      <U006D,u  ; form the address <U006D,u in x
                    ldy       #30       ; set y to the constant 30
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L0057,pc ; form the address >L0057,pc in x
                    ldy       #5        ; set y to the constant 5
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    leax      >U008D,u  ; form the address >U008D,u in x
                    ldy       #65       ; set y to the constant 65
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    leax      >L005C,pc ; form the address >L005C,pc in x
                    ldy       #65       ; set y to the constant 65
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    lda       U0001,u   ; load a from U0001,u
                    ldx       >U0088,u  ; load x from >U0088,u
                    pshs      u         ; save u on the stack
                    ldu       >U008A,u  ; load u from >U008A,u
                    os9       I$Seek    ; invoke the OS-9 I$Seek service
                    puls      u         ; restore u from the stack
L017F               lda       U0001,u   ; load a from U0001,u
                    leax      U0002,u   ; form the address U0002,u in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$ReadLn  ; invoke the OS-9 I$ReadLn service
                    lbcs      L01A7     ; branch when carry reports an error or unsigned underflow; target L01A7
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bgt       L017F     ; branch when the signed value is greater; target L017F
                    leax      >L005C,pc ; form the address >L005C,pc in x
                    ldy       #65       ; set y to the constant 65
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
L01A6               clrb                ; clear b to zero and set the condition codes
L01A7               os9       F$Exit    ; invoke the OS-9 F$Exit service

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
