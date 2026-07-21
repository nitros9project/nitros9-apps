**********************************************************************
* DLD.unvalidate - OS-9 Level 2 BBS command
*
* Syntax: DLD.unvalidate [directory]
* Purpose: Remove validation from an existing download-library entry.
* Updates the DLD metadata files without transferring data.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       DLD.unvalidate
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

WorkWord_001        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_002        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_001      rmb       82        ; reserve 82 byte(s) in the module workspace
WorkBuffer_002      rmb       27        ; reserve 27 byte(s) in the module workspace
WorkBuffer_003      rmb       31        ; reserve 31 byte(s) in the module workspace
WorkByte_001        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_004      rmb       464       ; reserve 464 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /DLD.unvalidate/ ; store an OS-9 high-bit-terminated string
Text_001            fcc       "DLD.lst" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcc       "DLD.dsc" ; store literal character data
                    fcb       $0D       ; store byte data
Text_002            fcc       "Enter filename to unvalidate:" ; store literal character data
Text_003            fcc       "Filename not found." ; store literal character data
                    fcb       $0D       ; store byte data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
                    fcc       "Name:Desc:--------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
Text_004            fcc       "File unvalidated." ; store literal character data
                    fcb       $0D       ; store byte data
start               lda       ,x        ; load a from ,x
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_001 ; branch when the values are equal or the result is zero; target Branch_001
                    lda       #1        ; set a to the constant 1
                    os9       I$ChgDir  ; change the current directory to the path at X
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
Branch_001          leax      >Text_001,pc ; form the address >Text_001,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    sta       WorkWord_001,u ; store a at WorkWord_001,u
Branch_003          leax      >Text_002,pc ; form the address >Text_002,pc in x
                    ldy       #29       ; set y to the constant 29
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
Branch_006          lda       WorkWord_001,u ; load a from WorkWord_001,u
                    ldb       #5        ; set b to the constant 5
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; query status code B for path A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    tfr       u,y       ; copy the register values specified by u,y
                    puls      u         ; restore u from the stack
                    stx       WorkWord_002,u ; store x at WorkWord_002,u
                    sty       WorkBuffer_001,u ; store y at WorkBuffer_001,u
                    leax      <WorkBuffer_003,u ; form the address <WorkBuffer_003,u in x
                    lda       WorkWord_001,u ; load a from WorkWord_001,u
                    ldy       #96       ; set y to the constant 96
                    clrb                ; clear b to zero and set the condition codes
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lbcs      Branch_007 ; branch when carry reports an error or unsigned underflow; target Branch_007
                    tst       >WorkByte_001,u ; set condition codes from >WorkByte_001,u without changing it
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
                    leax      >Text_003,pc ; form the address >Text_003,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbra      Branch_004 ; continue execution at Branch_004
Branch_009          clr       >WorkByte_001,u ; clear >WorkByte_001,u to zero and set the condition codes
                    ldx       WorkWord_002,u ; load x from WorkWord_002,u
                    lda       WorkWord_001,u ; load a from WorkWord_001,u
                    pshs      u         ; save u on the stack
                    ldu       WorkBuffer_001,u ; load u from WorkBuffer_001,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    puls      u         ; restore u from the stack
                    leax      <WorkBuffer_003,u ; form the address <WorkBuffer_003,u in x
                    ldy       #96       ; set y to the constant 96
                    lda       WorkWord_001,u ; load a from WorkWord_001,u
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >Text_004,pc ; form the address >Text_004,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
Branch_004          clrb                ; clear b to zero and set the condition codes
Branch_002          os9       F$Exit    ; terminate the process with status B

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
