**********************************************************************
* DLD.read - OS-9 Level 2 BBS command
*
* Syntax: DLD.read [directory]
* Purpose: Display the long description for a selected download.
* Correlates DLD.lst with DLD.dsc.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
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

WorkByte_001        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_002        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_001      rmb       80        ; reserve 80 byte(s) in the module workspace
WorkBuffer_002      rmb       27        ; reserve 27 byte(s) in the module workspace
WorkBuffer_003      rmb       27        ; reserve 27 byte(s) in the module workspace
WorkWord_001        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_002        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkByte_003        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_004        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_004      rmb       463       ; reserve 463 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /DLD.read/ ; store an OS-9 high-bit-terminated string
Text_001            fcc       "DLD.lst" ; store literal character data
                    fcb       $0D       ; store byte data
Text_002            fcc       "DLD.dsc" ; store literal character data
                    fcb       $0D       ; store byte data
Text_003            fcc       "Enter filename to read:" ; store literal character data
Text_004            fcc       "Filename not found." ; store literal character data
                    fcb       $0D       ; store byte data
Data_001            fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
                    fcc       "Name:" ; store literal character data
Text_005            fcc       "Desc:" ; store literal character data
Text_006            fcc       "--------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
start               lda       ,x        ; load a from ,x
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_001 ; branch when the values are equal or the result is zero; target Branch_001
                    lda       #1        ; set a to the constant 1
                    os9       I$ChgDir  ; change the current directory to the path at X
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
Branch_001          leax      >Text_001,pc ; form the address >Text_001,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    sta       WorkByte_001,u ; store a at WorkByte_001,u
                    leax      >Text_002,pc ; form the address >Text_002,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    sta       WorkByte_002,u ; store a at WorkByte_002,u
Branch_003          leax      >Text_003,pc ; form the address >Text_003,pc in x
                    ldy       #23       ; set y to the constant 23
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      <WorkBuffer_002,u ; form the address <WorkBuffer_002,u in x
                    ldy       #27       ; set y to the constant 27
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lbcs      Branch_003 ; branch when carry reports an error or unsigned underflow; target Branch_003
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    lble      Branch_004 ; branch when the signed value is less than or equal; target Branch_004
Branch_005          lda       ,x        ; load a from ,x
                    anda      #223      ; mask a using #223
                    sta       ,x+       ; store a at ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       Branch_005 ; branch when the values differ or the result is nonzero; target Branch_005
Branch_006          leax      <WorkBuffer_003,u ; form the address <WorkBuffer_003,u in x
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    ldy       #96       ; set y to the constant 96
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lbcs      Branch_007 ; branch when carry reports an error or unsigned underflow; target Branch_007
                    tst       >WorkByte_003,u ; set condition codes from >WorkByte_003,u without changing it
                    beq       Branch_006 ; branch when the values are equal or the result is zero; target Branch_006
                    leay      <WorkBuffer_002,u ; form the address <WorkBuffer_002,u in y
Branch_008          lda       ,y        ; load a from ,y
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_009 ; branch when the values are equal or the result is zero; target Branch_009
                    lda       ,x+       ; load a from ,x+
                    anda      #223      ; mask a using #223
                    cmpa      ,y+       ; compare a with ,y+ and set the condition codes
                    bne       Branch_006 ; branch when the values differ or the result is nonzero; target Branch_006
                    bra       Branch_008 ; continue execution at Branch_008
Branch_007          cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      Branch_002 ; branch when the values differ or the result is nonzero; target Branch_002
                    leax      >Text_004,pc ; form the address >Text_004,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbra      Branch_004 ; continue execution at Branch_004
Branch_009          leax      >Data_001,pc ; form the address >Data_001,pc in x
                    ldy       #7        ; set y to the constant 7
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      <WorkBuffer_003,u ; form the address <WorkBuffer_003,u in x
                    ldy       #30       ; set y to the constant 30
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Text_005,pc ; form the address >Text_005,pc in x
                    ldy       #5        ; set y to the constant 5
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >WorkByte_004,u ; form the address >WorkByte_004,u in x
                    ldy       #65       ; set y to the constant 65
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Text_006,pc ; form the address >Text_006,pc in x
                    ldy       #65       ; set y to the constant 65
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       WorkByte_002,u ; load a from WorkByte_002,u
                    ldx       >WorkWord_001,u ; load x from >WorkWord_001,u
                    pshs      u         ; save u on the stack
                    ldu       >WorkWord_002,u ; load u from >WorkWord_002,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    puls      u         ; restore u from the stack
Branch_010          lda       WorkByte_002,u ; load a from WorkByte_002,u
                    leax      WorkBuffer_001,u ; form the address WorkBuffer_001,u in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    cmpy      #1        ; compare y with #1 and set the condition codes
                    bgt       Branch_010 ; branch when the signed value is greater; target Branch_010
                    leax      >Text_006,pc ; form the address >Text_006,pc in x
                    ldy       #65       ; set y to the constant 65
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
Branch_004          clrb                ; clear b to zero and set the condition codes
Branch_002          os9       F$Exit    ; terminate the process with status B

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
