**********************************************************************
* DLD.list - OS-9 Level 2 BBS command
*
* Syntax: DLD.list [directory]
* Purpose: List validated downloads and their one-line descriptions.
* Reads DLD.lst in the selected directory.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       DLD.list
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
WorkBuffer_001      rmb       31        ; reserve 31 byte(s) in the module workspace
WorkByte_004        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_005        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_002      rmb       463       ; reserve 463 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /DLD.list/ ; store an OS-9 high-bit-terminated string
Text_001            fcc       "DLD.lst" ; store literal character data
                    fcb       $0D       ; store byte data
Text_002            fcc       "No files found." ; store literal character data
                    fcb       $0D       ; store byte data
Text_003            fcc       "                                                                               " ; store literal character data
                    fcb       $0D       ; store byte data
Text_004            fcc       "File name      Description" ; store literal character data
                    fcb       $0D       ; store byte data
Text_005            fcc       "--------------------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
start               clr       WorkByte_003,u ; clear WorkByte_003,u to zero and set the condition codes
                    lda       ,x        ; load a from ,x
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
Branch_003          clra                ; clear a to zero and set the condition codes
                    ldb       #1        ; set b to the constant 1
                    os9       I$GetStt  ; query status code B for path A
                    lbcc      Branch_004 ; branch when carry is clear; target Branch_004
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    leax      WorkBuffer_001,u ; form the address WorkBuffer_001,u in x
                    ldy       #96       ; set y to the constant 96
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lbcs      Branch_005 ; branch when carry reports an error or unsigned underflow; target Branch_005
                    lda       <WorkByte_004,u ; load a from <WorkByte_004,u
                    cmpa      #255      ; compare a with #255 and set the condition codes
                    bne       Branch_003 ; branch when the values differ or the result is nonzero; target Branch_003
                    tst       WorkByte_003,u ; set condition codes from WorkByte_003,u without changing it
                    bne       Branch_006 ; branch when the values differ or the result is nonzero; target Branch_006
                    leax      >Text_004,pc ; form the address >Text_004,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Text_005,pc ; form the address >Text_005,pc in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       #255      ; set a to the constant 255
                    sta       WorkByte_003,u ; store a at WorkByte_003,u
Branch_006          clrb                ; clear b to zero and set the condition codes
                    leax      WorkBuffer_001,u ; form the address WorkBuffer_001,u in x
Branch_007          lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_008 ; branch when the values are equal or the result is zero; target Branch_008
                    incb                ; increment b
                    bra       Branch_007 ; continue execution at Branch_007
Branch_008          stb       WorkByte_002,u ; store b at WorkByte_002,u
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    leax      WorkBuffer_001,u ; form the address WorkBuffer_001,u in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    ldb       #15       ; set b to the constant 15
                    subb      WorkByte_002,u ; subtract from b using WorkByte_002,u
                    blt       Branch_009 ; branch when the signed value is less; target Branch_009
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       #1        ; set a to the constant 1
                    leax      >Text_003,pc ; form the address >Text_003,pc in x
                    os9       I$Write   ; write Y bytes from X to path A
Branch_009          leax      <WorkByte_005,u ; form the address <WorkByte_005,u in x
                    ldy       #65       ; set y to the constant 65
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbra      Branch_003 ; continue execution at Branch_003
Branch_005          cmpb      #211      ; compare b with #211 and set the condition codes
                    bne       Branch_002 ; branch when the values differ or the result is nonzero; target Branch_002
                    tst       WorkByte_003,u ; set condition codes from WorkByte_003,u without changing it
                    bne       Branch_004 ; branch when the values differ or the result is nonzero; target Branch_004
                    leax      >Text_002,pc ; form the address >Text_002,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
Branch_004          clrb                ; clear b to zero and set the condition codes
Branch_002          os9       F$Exit    ; terminate the process with status B

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
