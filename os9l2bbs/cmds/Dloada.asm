**********************************************************************
* Dloada - OS-9 Level 2 BBS command
*
* Syntax: Dloada [file]
* Purpose: Send a file as unframed ASCII data.
* Transfer engine selected by BBS.download.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       Dloada
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

WorkByte_001        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_001      rmb       32        ; reserve 32 byte(s) in the module workspace
WorkByte_002        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_002      rmb       599       ; reserve 599 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /Dloada/ ; store an OS-9 high-bit-terminated string
Text_001            fcc       "Enter filename to Download-->" ; store literal character data
Text_002            fcc       "Press <SPACE> to abort" ; store literal character data
                    fcb       $0D       ; store byte data
Text_003            fcc       "Press <ENTER> to begin" ; store literal character data
                    fcb       $0D       ; store byte data
Data_001            fcb       $18       ; store byte data
Data_002            fcb       $20       ; store byte data
start               lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    bcs       Branch_001 ; branch when carry reports an error or unsigned underflow; target Branch_001
                    bra       Branch_002 ; continue execution at Branch_002
Branch_001          leax      >Text_001,pc ; form the address >Text_001,pc in x
                    ldy       #29       ; set y to the constant 29
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      WorkBuffer_001,u ; form the address WorkBuffer_001,u in x
                    ldy       #32       ; set y to the constant 32
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    leax      WorkBuffer_001,u ; form the address WorkBuffer_001,u in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_003 ; branch when carry reports an error or unsigned underflow; target Branch_003
Branch_002          sta       WorkByte_001,u ; store a at WorkByte_001,u
                    leax      >Text_002,pc ; form the address >Text_002,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Text_003,pc ; form the address >Text_003,pc in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
Branch_004          leax      <WorkByte_002,u ; form the address <WorkByte_002,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lda       <WorkByte_002,u ; load a from <WorkByte_002,u
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    lbeq      Branch_005 ; branch when the values are equal or the result is zero; target Branch_005
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       Branch_004 ; branch when the values differ or the result is nonzero; target Branch_004
                    leax      >Data_001,pc ; form the address >Data_001,pc in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
Branch_006          lda       WorkByte_001,u ; load a from WorkByte_001,u
                    leax      <WorkByte_002,u ; form the address <WorkByte_002,u in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    bcs       Branch_005 ; branch when carry reports an error or unsigned underflow; target Branch_005
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    clra                ; clear a to zero and set the condition codes
                    ldb       #1        ; set b to the constant 1
                    os9       I$GetStt  ; query status code B for path A
                    bcs       Branch_006 ; branch when carry reports an error or unsigned underflow; target Branch_006
                    ldy       #1        ; set y to the constant 1
                    leax      <WorkByte_002,u ; form the address <WorkByte_002,u in x
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lda       ,x        ; load a from ,x
                    cmpa      #32       ; compare a with #32 and set the condition codes
                    bne       Branch_006 ; branch when the values differ or the result is nonzero; target Branch_006
Branch_005          clrb                ; clear b to zero and set the condition codes
Branch_003          pshs      b         ; save b on the stack
                    leax      >Data_002,pc ; form the address >Data_002,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      b         ; restore b from the stack
                    os9       F$Exit    ; terminate the process with status B

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
