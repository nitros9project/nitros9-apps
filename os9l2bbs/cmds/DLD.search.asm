**********************************************************************
* DLD.search - OS-9 Level 2 BBS command
*
* Syntax: DLD.search [directory]
* Purpose: Search download keywords and report matching files.
* Correlates DLD.key entries with DLD.lst.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       DLD.search
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
WorkByte_004        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkWord_001        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_002        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_001      rmb       27        ; reserve 27 byte(s) in the module workspace
WorkBuffer_002      rmb       12        ; reserve 12 byte(s) in the module workspace
WorkWord_003        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_004        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_003      rmb       31        ; reserve 31 byte(s) in the module workspace
WorkByte_005        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkByte_006        rmb       1         ; reserve 1 byte(s) in the module workspace
WorkBuffer_004      rmb       463       ; reserve 463 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /DLD.search/ ; store an OS-9 high-bit-terminated string
Text_001            fcc       "DLD.lst" ; store literal character data
                    fcb       $0D       ; store byte data
Text_002            fcc       "DLD.key" ; store literal character data
                    fcb       $0D       ; store byte data
Text_003            fcc       "Enter keyword for search:" ; store literal character data
Text_004            fcc       "No files found." ; store literal character data
                    fcb       $0D       ; store byte data
Text_005            fcc       "                                                                               " ; store literal character data
                    fcb       $0D       ; store byte data
Data_001            fcb       $0A       ; store byte data
                    fcc       "File name      Description" ; store literal character data
                    fcb       $0D       ; store byte data
Text_006            fcc       "--------------------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
start               clr       WorkByte_004,u ; clear WorkByte_004,u to zero and set the condition codes
                    lda       ,x        ; load a from ,x
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_001 ; branch when the values are equal or the result is zero; target Branch_001
                    lda       #1        ; set a to the constant 1
                    os9       I$ChgDir  ; change the current directory to the path at X
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
Branch_001          ldd       #-1       ; set d to the constant -1
                    std       WorkWord_002,u ; store d at WorkWord_002,u
                    std       WorkWord_001,u ; store d at WorkWord_001,u
                    leax      >Text_001,pc ; form the address >Text_001,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    sta       WorkByte_002,u ; store a at WorkByte_002,u
                    leax      >Text_002,pc ; form the address >Text_002,pc in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Open    ; open the path at X using access mode A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    sta       WorkByte_001,u ; store a at WorkByte_001,u
Branch_003          leax      >Text_003,pc ; form the address >Text_003,pc in x
                    ldy       #25       ; set y to the constant 25
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      WorkBuffer_001,u ; form the address WorkBuffer_001,u in x
                    ldy       #27       ; set y to the constant 27
                    clra                ; clear a to zero and set the condition codes
                    os9       I$ReadLn  ; read a CR-terminated line from path A into X
                    lbcs      Branch_003 ; branch when carry reports an error or unsigned underflow; target Branch_003
Branch_004          leax      <WorkBuffer_002,u ; form the address <WorkBuffer_002,u in x
                    ldy       #16       ; set y to the constant 16
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lbcs      Branch_005 ; branch when carry reports an error or unsigned underflow; target Branch_005
                    ldd       <WorkWord_003,u ; load d from <WorkWord_003,u
                    cmpd      WorkWord_001,u ; compare d with WorkWord_001,u and set the condition codes
                    bne       Branch_006 ; branch when the values differ or the result is nonzero; target Branch_006
                    ldd       <WorkWord_004,u ; load d from <WorkWord_004,u
                    cmpd      WorkWord_002,u ; compare d with WorkWord_002,u and set the condition codes
                    bne       Branch_006 ; branch when the values differ or the result is nonzero; target Branch_006
                    bra       Branch_004 ; continue execution at Branch_004
Branch_006          pshs      x         ; save x on the stack
Branch_007          lda       ,x        ; load a from ,x
                    anda      #223      ; mask a using #223
                    sta       ,x+       ; store a at ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    bne       Branch_007 ; branch when the values differ or the result is nonzero; target Branch_007
                    puls      x         ; restore x from the stack
                    leay      WorkBuffer_001,u ; form the address WorkBuffer_001,u in y
Branch_008          lda       ,y+       ; load a from ,y+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_009 ; branch when the values are equal or the result is zero; target Branch_009
                    anda      #223      ; mask a using #223
                    cmpa      ,x+       ; compare a with ,x+ and set the condition codes
                    bne       Branch_004 ; branch when the values differ or the result is nonzero; target Branch_004
                    bra       Branch_008 ; continue execution at Branch_008
Branch_005          cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      Branch_002 ; branch when the values differ or the result is nonzero; target Branch_002
                    tst       WorkByte_004,u ; set condition codes from WorkByte_004,u without changing it
                    lbne      Branch_010 ; branch when the values differ or the result is nonzero; target Branch_010
                    leax      >Text_004,pc ; form the address >Text_004,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lbra      Branch_010 ; continue execution at Branch_010
Branch_009          pshs      u         ; save u on the stack
                    lda       WorkByte_002,u ; load a from WorkByte_002,u
                    ldx       <WorkWord_003,u ; load x from <WorkWord_003,u
                    ldu       <WorkWord_004,u ; load u from <WorkWord_004,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    puls      u         ; restore u from the stack
                    leax      <WorkBuffer_003,u ; form the address <WorkBuffer_003,u in x
                    ldy       #96       ; set y to the constant 96
                    lda       WorkByte_002,u ; load a from WorkByte_002,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    tst       <WorkByte_005,u ; set condition codes from <WorkByte_005,u without changing it
                    lbeq      Branch_004 ; branch when the values are equal or the result is zero; target Branch_004
                    tst       WorkByte_004,u ; set condition codes from WorkByte_004,u without changing it
                    bne       Branch_011 ; branch when the values differ or the result is nonzero; target Branch_011
                    leax      >Data_001,pc ; form the address >Data_001,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >Text_006,pc ; form the address >Text_006,pc in x
                    ldy       #200      ; set y to the constant 200
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    lda       #255      ; set a to the constant 255
                    sta       WorkByte_004,u ; store a at WorkByte_004,u
Branch_011          clrb                ; clear b to zero and set the condition codes
                    leax      <WorkBuffer_003,u ; form the address <WorkBuffer_003,u in x
Branch_012          lda       ,x+       ; load a from ,x+
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_013 ; branch when the values are equal or the result is zero; target Branch_013
                    incb                ; increment b
                    bra       Branch_012 ; continue execution at Branch_012
Branch_013          stb       WorkByte_003,u ; store b at WorkByte_003,u
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    leax      <WorkBuffer_003,u ; form the address <WorkBuffer_003,u in x
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    ldb       #15       ; set b to the constant 15
                    subb      WorkByte_003,u ; subtract from b using WorkByte_003,u
                    blt       Branch_014 ; branch when the signed value is less; target Branch_014
                    clra                ; clear a to zero and set the condition codes
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       #1        ; set a to the constant 1
                    leax      >Text_005,pc ; form the address >Text_005,pc in x
                    os9       I$Write   ; write Y bytes from X to path A
Branch_014          leax      <WorkByte_006,u ; form the address <WorkByte_006,u in x
                    ldy       #65       ; set y to the constant 65
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    ldd       <WorkWord_003,u ; load d from <WorkWord_003,u
                    std       WorkWord_001,u ; store d at WorkWord_001,u
                    ldd       <WorkWord_004,u ; load d from <WorkWord_004,u
                    std       WorkWord_002,u ; store d at WorkWord_002,u
                    lbra      Branch_004 ; continue execution at Branch_004
Branch_010          clrb                ; clear b to zero and set the condition codes
Branch_002          os9       F$Exit    ; terminate the process with status B

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
