**********************************************************************
* Answer - OS-9 Level 2 BBS command
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
**********************************************************************

                    nam       answer
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; set assembly-time module attribute tylg
atrv                set       ReEnt+rev ; set assembly-time module attribute atrv
rev                 set       $01       ; set assembly-time module attribute rev

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

ChatId              rmb       4         ; reserve 4 byte(s) in the module workspace
ReadBuf             rmb       1         ; reserve 1 byte(s) in the module workspace
U0005               rmb       1         ; reserve 1 byte(s) in the module workspace
ProcId              rmb       5         ; reserve 5 byte(s) in the module workspace
memtop              rmb       2         ; reserve 2 byte(s) in the module workspace
U000D               rmb       2         ; reserve 2 byte(s) in the module workspace
ProcDesc            rmb       512       ; reserve 512 byte(s) in the module workspace
ProcBuf             rmb       1         ; reserve 1 byte(s) in the module workspace
U0210               rmb       431       ; reserve 431 byte(s) in the module workspace
size                equ       .         ; define the assembly-time value for size

name                fcs       /answer/ ; store an OS-9 high-bit-terminated string
                    fcc       "Copyright (C) 1988By Keith Alphonso" ; store literal character data
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
Answer              fcc       "Answering call..." ; store literal character data
                    fcc       "Press <ALT><x> when finished." ; store literal character data
                    fcb       $0D       ; store byte data
lf_cr               fcb       $0A       ; store byte data
                    fcb       $0D       ; store byte data
BBS_Chat            fcs       "BBS.chat" ; store an OS-9 high-bit-terminated string
NoChat              fcc       "Sorry, no one has requested to chat!" ; store literal character data
                    fcb       $0D       ; store byte data
Line                fcc       "----------------------------------------------------------------" ; store literal character data
                    fcb       $0D       ; store byte data
                    fcc       "/t2" ; store literal character data
                    fcb       $0D       ; store byte data

start               stx       memtop,u  ; store x at memtop,u
                    lda       #2        ; set a to the constant 2
                    sta       ProcId,u  ; store a at ProcId,u

* Check all process descriptors until we find BBS_Chat
ProcLoop            lda       ProcId,u  ; load a from ProcId,u
                    lbeq      L0257     ; ProcId=0 so exit the loop
                    leax      ProcDesc,u ; Point to process descriptor buffer
                    os9       F$GPrDsc  ; Get the process descriptor
                    bcs       NextProc  ; Process does not exist, so skip it
                    leay      <$0040,x  ; Point to P$DATImg
                    tfr       y,d       ; Put P$DATImg in D
                    ldx       <$0011,x  ; Get the P$Modul offset
                    ldy       #9        ; Gonna copy 9 bytes
                    pshs      u         ; Save a copy of U
                    leau      >ProcBuf,u ; Point to the buffer
                    os9       F$CpyMem  ; Copy the module header
                    lbcs      ErrExit   ; Exit on error
                    pshs      d         ; Save the DAT image pointer
                    ldd       ReadBuf,u ; Get the M$Name offset
                    leax      d,x       ; Point to the buffer
                    puls      d         ; Get the DAT image pointer
                    ldy       #32       ; Gonna copy 32 bytes
                    os9       F$CpyMem  ; Copy the module name
                    lbcs      ErrExit   ; Exit on error
                    puls      u         ; Restore U

* Have we found BBS_Chat yet?
                    leax      >ProcBuf,u ; form the address >ProcBuf,u in x
                    leay      >BBS_Chat,pc ; form the address >BBS_Chat,pc in y

CmpNames            lda       ,x+       ; load a from ,x+
                    cmpa      ,y+       ; compare a with ,y+ and set the condition codes
                    bne       NextProc  ; This isn't BBS_Chat, try again
                    tsta                ; set condition codes from a without changing it
                    bpl       CmpNames  ; Names match so far, try next char

                    lda       ProcId,u  ; load a from ProcId,u
                    sta       ChatId,u  ; store a at ChatId,u
                    bra       ChatSignl ; Found BBS_Chat, so exit loop

NextProc            inc       ProcId,u  ; increment the value at ProcId,u
                    bra       ProcLoop  ; continue execution at ProcLoop

ChatSignl           lda       ChatId,u  ; Get BBS_Chat process Id
                    ldb       #129      ; Signal code
                    os9       F$Send    ; Send $81 signal to BBS_Chat
                    bcc       L018E     ; Branch if signal received
                    ldx       #1        ; BBS_Chat has signal pending...
                    os9       F$Sleep   ; ... so sleep a bit ...
                    bra       ChatSignl ; ... and try again

* Write "answering call..."
L018E               leax      >Answer,pc ; form the address >Answer,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service

* Write a line of dashes
                    leax      >Line,pc  ; form the address >Line,pc in x
                    ldy       #65       ; set y to the constant 65
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service

* Link to BBS_Chat
                    leax      >BBS_Chat,pc ; form the address >BBS_Chat,pc in x
                    lda       #17       ; set a to the constant 17
                    pshs      u         ; save u on the stack
                    os9       F$Link    ; invoke the OS-9 F$Link service
                    lbcs      ErrExit   ; Exit on error

                    puls      u         ; restore u from the stack
                    sty       U000D,u   ; store y at U000D,u

ChkInput            clra                ; clear a to zero and set the condition codes
                    ldb       #1        ; SS.Ready
                    os9       I$GetStt  ; invoke the OS-9 I$GetStt service
                    bcc       L01F4     ; Data is waiting so go read it
                    ldx       U000D,u   ; load x from U000D,u
                    tst       $02,x     ; set condition codes from $02,x without changing it
                    beq       ChkInput  ; branch when the values are equal or the result is zero; target ChkInput

Loop                pshs      x         ; save x on the stack
                    leax      $03,x     ; form the address $03,x in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    puls      x         ; restore x from the stack
                    lda       $03,x     ; load a from $03,x
                    cmpa      #13       ; Is it a CR?
                    bne       L01F0     ; No, don't write LF

* Write LF after each CR
                    pshs      x         ; save x on the stack
                    leax      >lf_cr,pc ; form the address >lf_cr,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; invoke the OS-9 I$Write service
                    puls      x         ; restore x from the stack

L01F0               clr       $02,x     ; Clear the counter
                    bra       ChkInput  ; Check for more data

L01F4               leax      ReadBuf,u ; form the address ReadBuf,u in x
                    ldy       #1        ; set y to the constant 1
                    os9       I$Read    ; Read one character
                    lbcs      ErrExit   ; Exit on error
                    lda       0,x       ; Get the character read
                    cmpa      #248      ; Is it ALT+X?
                    beq       L0243     ; Yes, so exit
                    cmpa      #13       ; Is it a CR?
                    bne       L021A     ; No, don't write LF

* Write LF after each CR
                    leax      >lf_cr,pc ; form the address >lf_cr,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; Write LF

                    lda       #13       ; Put the CR back in A
L021A               ldx       U000D,u   ; load x from U000D,u
                    pshs      cc        ; save cc on the stack
                    orcc      #80       ; set selected condition-code bits using #80
                    tst       $02,x     ; set condition codes from $02,x without changing it
                    bne       L023E     ; branch when the values differ or the result is nonzero; target L023E
                    sta       $03,x     ; store a at $03,x
                    lda       #1        ; set a to the constant 1
                    sta       $02,x     ; store a at $02,x
                    puls      cc        ; restore cc from the stack

* Wait for something to reset the flag at 2,X
L022C               lda       $02,x     ; load a from $02,x
                    lbeq      ChkInput  ; branch when the values are equal or the result is zero; target ChkInput
                    pshs      x         ; save x on the stack
                    ldx       #1        ; set x to the constant 1
                    os9       F$Sleep   ; invoke the OS-9 F$Sleep service
                    puls      x         ; restore x from the stack
                    bra       L022C     ; continue execution at L022C

L023E               puls      cc        ; restore cc from the stack
                    lbra      Loop      ; continue execution at Loop

L0243               lda       U0005,u   ; load a from U0005,u
                    os9       I$Close   ; invoke the OS-9 I$Close service
                    lda       ChatId,u  ; load a from ChatId,u
                    ldb       #2        ; set b to the constant 2
                    os9       F$Send    ; invoke the OS-9 F$Send service
                    ldx       #60       ; set x to the constant 60
                    os9       F$Sleep   ; invoke the OS-9 F$Sleep service
                    bra       Exit      ; continue execution at Exit

L0257               leax      >NoChat,pc ; form the address >NoChat,pc in x
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; invoke the OS-9 I$WritLn service
                    ldb       #1        ; set b to the constant 1
                    bra       ErrExit   ; continue execution at ErrExit

Exit                clrb                ; clear b to zero and set the condition codes
ErrExit             os9       F$Exit    ; invoke the OS-9 F$Exit service

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
