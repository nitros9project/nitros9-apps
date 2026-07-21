**********************************************************************
* BBS.download - OS-9 Level 2 BBS command
*
* Syntax: BBS.download [directory]
* Purpose: Select a validated file and dispatch the requested download protocol engine.
* Uses DLD metadata and updates BBS.userstats after successful transfer.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
**********************************************************************

                    nam       BBS.download
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
WorkWord_001        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_002        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_003        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_001      rmb       6         ; reserve 6 byte(s) in the module workspace
WorkWord_004        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_005        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_006        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkWord_007        rmb       2         ; reserve 2 byte(s) in the module workspace
WorkBuffer_002      rmb       414       ; reserve 414 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.download/ ; store an OS-9 high-bit-terminated string
                    fcc       "Enter your download protocol" ; store literal character data
                    fcb       $0D       ; store byte data
Data_001            fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
                    fcc       "[A] Ascii" ; store literal character data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
                    fcc       "[X] xmodem" ; store literal character data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
                    fcc       "[C] xmodem (CRC)" ; store literal character data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
                    fcc       "[Y] ymodem" ; store literal character data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
                    fcc       "[Q] quit" ; store literal character data
                    fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
                    fcc       "Protocol?" ; store literal character data
Text_001            fcc       "dloadx" ; store literal character data
                    fcb       $0D       ; store byte data
Text_002            fcc       "dloadxc" ; store literal character data
                    fcb       $0D       ; store byte data
Text_003            fcc       "dloady" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcc       "dloadyb" ; store literal character data
                    fcb       $0D       ; store byte data
Text_004            fcc       "Dloada" ; store literal character data
                    fcb       $0D       ; store byte data
Data_002            fcb       $0D       ; store byte data
                    fcb       $0A       ; store byte data
Text_005            fcc       "/dd/bbs/BBS.userstats" ; store literal character data
                    fcb       $0D       ; store byte data

start               lda       ,x        ; load a from ,x
                    cmpa      #13       ; compare a with #13 and set the condition codes
                    beq       Branch_001 ; branch when the values are equal or the result is zero; target Branch_001
                    lda       #1        ; set a to the constant 1
                    os9       I$ChgDir  ; change the current directory to the path at X
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
Branch_001          leax      >Data_001,pc ; form the address >Data_001,pc in x
                    ldy       #74       ; set y to the constant 74
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    leax      WorkByte_001,u ; form the address WorkByte_001,u in x
                    ldy       #1        ; set y to the constant 1
                    clra                ; clear a to zero and set the condition codes
                    os9       I$Read    ; read up to Y bytes from path A into X
                    leax      >Data_002,pc ; form the address >Data_002,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    lda       WorkByte_001,u ; load a from WorkByte_001,u
                    anda      #223      ; mask a using #223
                    cmpa      #65       ; compare a with #65 and set the condition codes
                    beq       Branch_003 ; branch when the values are equal or the result is zero; target Branch_003
                    cmpa      #88       ; compare a with #88 and set the condition codes
                    beq       Branch_004 ; branch when the values are equal or the result is zero; target Branch_004
                    cmpa      #89       ; compare a with #89 and set the condition codes
                    beq       Branch_005 ; branch when the values are equal or the result is zero; target Branch_005
                    cmpa      #67       ; compare a with #67 and set the condition codes
                    beq       Branch_006 ; branch when the values are equal or the result is zero; target Branch_006
                    cmpa      #81       ; compare a with #81 and set the condition codes
                    lbeq      Branch_007 ; branch when the values are equal or the result is zero; target Branch_007
                    bra       Branch_001 ; continue execution at Branch_001
Branch_004          leax      >Text_001,pc ; form the address >Text_001,pc in x
                    bra       Branch_008 ; continue execution at Branch_008
Branch_005          leax      >Text_003,pc ; form the address >Text_003,pc in x
                    bra       Branch_008 ; continue execution at Branch_008
Branch_006          leax      >Text_002,pc ; form the address >Text_002,pc in x
                    bra       Branch_008 ; continue execution at Branch_008
Branch_003          leax      >Text_004,pc ; form the address >Text_004,pc in x
                    bra       Branch_008 ; continue execution at Branch_008
Branch_008          ldy       #1        ; set y to the constant 1
                    lda       #17       ; set a to the constant 17
                    ldb       #3        ; set b to the constant 3
                    pshs      u         ; save u on the stack
                    leau      >Data_002,pc ; form the workspace or data address >Data_002,pc in u
                    os9       F$Fork    ; spawn the module at X with parameters at U
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    clrb                ; clear b to zero and set the condition codes
                    os9       F$Wait    ; wait for a child process to terminate
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    cmpb      #0        ; compare b with #0 and set the condition codes
                    lbne      Branch_002 ; branch when the values differ or the result is nonzero; target Branch_002
                    puls      u         ; restore u from the stack
                    leax      >Text_005,pc ; form the address >Text_005,pc in x
                    lda       #3        ; set a to the constant 3
                    os9       I$Open    ; open the path at X using access mode A
                    bcc       Branch_009 ; branch when carry is clear; target Branch_009
                    ldb       #27       ; set b to the constant 27
                    os9       I$Create  ; create the path at X with mode A and attributes B
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
Branch_009          sta       WorkByte_002,u ; store a at WorkByte_002,u
                    os9       F$ID      ; retrieve the current process and user IDs
                    sty       WorkWord_001,u ; store y at WorkWord_001,u
Branch_010          leax      WorkWord_002,u ; form the address WorkWord_002,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       WorkByte_002,u ; load a from WorkByte_002,u
                    os9       I$Read    ; read up to Y bytes from path A into X
                    bcs       Branch_011 ; branch when carry reports an error or unsigned underflow; target Branch_011
                    ldd       WorkWord_002,u ; load d from WorkWord_002,u
                    cmpd      WorkWord_001,u ; compare d with WorkWord_001,u and set the condition codes
                    bne       Branch_010 ; branch when the values differ or the result is nonzero; target Branch_010
                    bra       Branch_012 ; continue execution at Branch_012
Branch_011          cmpb      #211      ; compare b with #211 and set the condition codes
                    lbne      Branch_002 ; branch when the values differ or the result is nonzero; target Branch_002
                    lbra      Branch_013 ; continue execution at Branch_013
Branch_012          ldd       <WorkWord_006,u ; load d from <WorkWord_006,u
                    addd      #1        ; add to d using #1
                    std       <WorkWord_006,u ; store d at <WorkWord_006,u
                    lda       WorkByte_002,u ; load a from WorkByte_002,u
                    ldb       #5        ; set b to the constant 5
                    pshs      u         ; save u on the stack
                    os9       I$GetStt  ; query status code B for path A
                    tfr       u,d       ; copy the register values specified by u,d
                    subd      #32       ; subtract from d using #32
                    bge       Branch_014 ; branch when the signed value is greater than or equal; target Branch_014
                    leax      -$01,x    ; form the address -$01,x in x
Branch_014          ldu       ,s        ; load u from the current stack frame at ,s
                    tfr       d,y       ; copy the register values specified by d,y
                    lda       WorkByte_002,u ; load a from WorkByte_002,u
                    tfr       y,u       ; copy the register values specified by y,u
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    puls      u         ; restore u from the stack
                    leax      WorkWord_002,u ; form the address WorkWord_002,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       WorkByte_002,u ; load a from WorkByte_002,u
                    os9       I$Write   ; write Y bytes from X to path A
                    os9       I$Close   ; close path A
                    lbra      Branch_007 ; continue execution at Branch_007
Branch_013          leax      WorkWord_002,u ; form the address WorkWord_002,u in x
                    ldd       #1        ; set d to the constant 1
                    std       WorkWord_003,u ; store d at WorkWord_003,u
                    std       <WorkWord_005,u ; store d at <WorkWord_005,u
                    ldd       #0        ; set d to the constant 0
                    std       WorkWord_004,u ; store d at WorkWord_004,u
                    std       <WorkWord_007,u ; store d at <WorkWord_007,u
                    std       <WorkWord_006,u ; store d at <WorkWord_006,u
                    ldd       WorkWord_001,u ; load d from WorkWord_001,u
                    std       WorkWord_002,u ; store d at WorkWord_002,u
                    leax      WorkBuffer_001,u ; form the address WorkBuffer_001,u in x
                    os9       F$Time    ; read the current system date and time
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
                    leax      WorkWord_002,u ; form the address WorkWord_002,u in x
                    ldy       #32       ; set y to the constant 32
                    lda       WorkByte_002,u ; load a from WorkByte_002,u
                    os9       I$Write   ; write Y bytes from X to path A
                    os9       I$Close   ; close path A
                    lbcs      Branch_002 ; branch when carry reports an error or unsigned underflow; target Branch_002
Branch_007          clrb                ; clear b to zero and set the condition codes
Branch_002          os9       F$Exit    ; terminate the process with status B

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
