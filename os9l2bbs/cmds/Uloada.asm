**********************************************************************
* Uloada - OS-9 Level 2 BBS command
*
* Syntax: Uloada [file]
* Purpose: Receive an ASCII upload until the protocol terminating character.
* Transfer engine selected by BBS.upload.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       Uloada
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

WorkByte_001        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_001      rmb       200       ; reserve 200 byte(s) in the module workspace
WorkByte_002        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_002      rmb       599       ; reserve 599 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /Uloada/ ; store an OS-9 high-bit-terminated string
Text_001            fcc       "Enter filename to upload" ; store literal character data
Text_002            fcc       "Press <CTRL><T> to terminal upload" ; store literal character data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
                    fcc       "Press <CTRL><X> to cancel" ; store literal character data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
Data_001            fcb       $0A       ; store byte data
                    fcb       $3A       ; store byte data
start               lda       ,x        ; load a from ,x
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       Branch_001 ; branch when the values differ or the result is nonzero; target Branch_001
                    leax      >Text_001,pc ; form the address >Text_001,pc in x
                    ldy       #24       ; set y to the constant 24
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      WorkBuffer_001,u ; form the address WorkBuffer_001,u in x
                    ldy       #200      ; set y to the constant 200
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    leax      WorkBuffer_001,u ; form the address WorkBuffer_001,u in x
Branch_001          lda       #3        ; set a to the constant 3
                    ldb       #27       ; set b to the constant 27
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    sta       WorkByte_001,u ; store a at WorkByte_001,u
                    leax      >Text_002,pc ; form the address >Text_002,pc in x
                    ldy       #63       ; set y to the constant 63
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      >Data_001,pc ; form the address >Data_001,pc in x
                    ldy       #2        ; set y to the constant 2
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
Branch_003          clra                ; clear a to zero and set the condition codes
                    ldb       #1        ; set b to the constant 1
                    os9       I$GetStt  ; query status code B for path A
                    bcs       Branch_003 ; branch when carry reports an error or unsigned underflow; target Branch_003
                    ldy       #1        ; set y to the constant 1
                    leax      >WorkByte_002,u ; form the address >WorkByte_002,u in x
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lda       ,x        ; load a from ,x
                    cmpa      #20       ; compare a with #20 and set the condition codes
                    beq       Branch_004 ; branch when the values are equal or the result is zero; target Branch_004
                    cmpa      #24       ; compare a with #24 and set the condition codes
                    beq       Branch_005 ; branch when the values are equal or the result is zero; target Branch_005
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    os9       I$Write   ; write Y bytes from X to path A
                    lda       ,x        ; load a from ,x
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_006 ; branch when the values are equal or the result is zero; target Branch_006
                    bra       Branch_003 ; continue execution at Branch_003
Branch_006          leax      >Data_001,pc ; form the address >Data_001,pc in x
                    ldy       #2        ; set y to the constant 2
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    bra       Branch_003 ; continue execution at Branch_003
Branch_005          lda       #1        ; set a to the constant 1
                    bra       Branch_002 ; continue execution at Branch_002
Branch_004          clrb                ; clear b to zero and set the condition codes
Branch_002          os9       F$Exit    ; terminate the process with status B

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
