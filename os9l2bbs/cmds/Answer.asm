**********************************************************************
* Answer - OS-9 Level 2 BBS command
*
* Syntax: Answer
* Purpose: Attach the sysop to a pending BBS.chat request and relay both character streams.
* Coordination: locates/signals BBS.chat and uses its shared one-character mailbox.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
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

ChatId              rmb       4         ; BBS.chat process ID followed by private scratch bytes
ReadBuf             rmb       1         ; single operator keystroke read from standard input
InputPath           rmb       1         ; caller input path closed when the chat session ends
ProcId              rmb       5         ; process ID being tested plus descriptor-copy scratch
memtop              rmb       2         ; top of memory supplied by the OS-9 program loader
ChatMailbox         rmb       2         ; pointer to BBS.chat shared ready/character fields
ProcDesc            rmb       512       ; buffer populated by F$GPrDsc for process discovery
ProcBuf             rmb       1         ; copied module header/name used to identify BBS.chat
ProcessScratch      rmb       431       ; remainder of the process descriptor/name workspace
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
                    fcc       "Press <ALT><X> when finished." ; store literal character data
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
                    lbeq      NoChatProcess ; process IDs wrapped without finding BBS.chat
                    leax      ProcDesc,u ; point to process descriptor buffer
                    os9       F$GPrDsc  ; get the process descriptor
                    bcs       NextProc  ; process does not exist, so skip it
                    leay      <$0040,x  ; point to P$DATImg
                    tfr       y,d       ; put P$DATImg in D
                    ldx       <$0011,x  ; get the P$Modul offset
                    ldy       #9        ; gonna copy 9 bytes
                    pshs      u         ; save a copy of U
                    leau      >ProcBuf,u ; point to the buffer
                    os9       F$CpyMem  ; copy the module header
                    lbcs      ErrExit   ; exit on error
                    pshs      d         ; save the DAT image pointer
                    ldd       ReadBuf,u ; get the M$Name offset
                    leax      d,x       ; point to the buffer
                    puls      d         ; get the DAT image pointer
                    ldy       #32       ; gonna copy 32 bytes
                    os9       F$CpyMem  ; copy the module name
                    lbcs      ErrExit   ; exit on error
                    puls      u         ; restore U

* Have we found BBS_Chat yet?
                    leax      >ProcBuf,u ; form the address >ProcBuf,u in x
                    leay      >BBS_Chat,pc ; form the address >BBS_Chat,pc in y

CmpNames            lda       ,x+       ; load a from ,x+
                    cmpa      ,y+       ; compare a with ,y+ and set the condition codes
                    bne       NextProc  ; this isn't BBS_Chat, try again
                    tsta                ; set condition codes from a without changing it
                    bpl       CmpNames  ; names match so far, try next char

                    lda       ProcId,u  ; load a from ProcId,u
                    sta       ChatId,u  ; store a at ChatId,u
                    bra       ChatSignl ; found BBS_Chat, so exit loop

NextProc            inc       ProcId,u  ; increment the value at ProcId,u
                    bra       ProcLoop  ; continue execution at ProcLoop

ChatSignl           lda       ChatId,u  ; get BBS_Chat process Id
                    ldb       #129      ; signal code
                    os9       F$Send    ; send $81 signal to BBS_Chat
                    bcc       BeginChatRelay ; bbs.chat accepted the sysop-answer signal
                    ldx       #1        ; bbs_Chat has signal pending...
                    os9       F$Sleep   ; ... so sleep a bit ...
                    bra       ChatSignl ; ... and try again

* Write "answering call..."
BeginChatRelay      leax      >Answer,pc ; tell the sysop that the shared chat is active
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A

* Write a line of dashes
                    leax      >Line,pc  ; form the address >Line,pc in x
                    ldy       #65       ; set y to the constant 65
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A

* Link to BBS_Chat
                    leax      >BBS_Chat,pc ; form the address >BBS_Chat,pc in x
                    lda       #17       ; set a to the constant 17
                    pshs      u         ; save u on the stack
                    os9       F$Link    ; link the module named at X
                    lbcs      ErrExit   ; exit on error

                    puls      u         ; restore u from the stack
                    sty       ChatMailbox,u ; retain the shared ready flag/character mailbox

* Relay whichever side has a character ready.  The caller side deposits a
* character in shared offset 3 and raises the ready byte at offset 2.  The
* sysop side is standard input and is polled with SS.Ready.
PollChatInputs      clra                ; select the sysop's standard input path
                    ldb       #1        ; request SS.Ready without blocking
                    os9       I$GetStt  ; test whether the sysop typed a character
                    bcc       ReadOperatorKey ; consume the pending operator keystroke
                    ldx       ChatMailbox,u ; inspect the caller-to-sysop mailbox instead
                    tst       $02,x     ; caller has raised this byte when offset 3 is valid
                    beq       PollChatInputs ; neither endpoint has input yet

WriteCallerChar     pshs      x         ; preserve the shared mailbox base across I$Write
                    leax      $03,x     ; point X at the caller's deposited character
                    ldy       #1        ; relay exactly one mailbox character
                    lda       #1        ; send it to the sysop's standard output
                    os9       I$Write   ; display the caller character locally
                    puls      x         ; recover the mailbox base needed for acknowledgement
                    lda       $03,x     ; retain the relayed character for CR handling
                    cmpa      #13       ; os-9 text output needs an LF paired with caller CR
                    bne       AcknowledgeCallerChar ; ordinary characters need no translation

* Write LF after each CR
                    pshs      x         ; save x on the stack
                    leax      >lf_cr,pc ; form the address >lf_cr,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write Y bytes from X to path A
                    puls      x         ; restore x from the stack

AcknowledgeCallerChar clr       $02,x     ; release the mailbox slot back to BBS.chat
                    bra       PollChatInputs ; service the next ready endpoint

ReadOperatorKey     leax      ReadBuf,u ; receive the pending sysop keystroke here
                    ldy       #1        ; consume one key selected by SS.Ready
                    os9       I$Read    ; read without waiting because readiness was confirmed
                    lbcs      ErrExit   ; propagate an input-path failure to OS-9
                    lda       ,x        ; obtain the operator key for routing/translation
                    cmpa      #248      ; alt-X is the documented end-chat command
                    beq       EndChatSession ; notify BBS.chat and return to the sysop menu
                    cmpa      #13       ; mirror a local newline before forwarding CR
                    bne       QueueOperatorChar ; forward other keys unchanged

* Write LF after each CR
                    leax      >lf_cr,pc ; form the address >lf_cr,pc in x
                    ldy       #1        ; set y to the constant 1
                    lda       #1        ; set a to the constant 1
                    os9       I$Write   ; write LF

                    lda       #13       ; put the CR back in A
QueueOperatorChar   ldx       ChatMailbox,u ; address the sysop-to-caller mailbox
                    pshs      cc        ; save cc on the stack
                    orcc      #80       ; set selected condition-code bits using #80
                    tst       $02,x     ; set condition codes from $02,x without changing it
                    bne       CallerCharPending ; do not overwrite an unconsumed caller character
                    sta       $03,x     ; store a at $03,x
                    lda       #1        ; set a to the constant 1
                    sta       $02,x     ; store a at $02,x
                    puls      cc        ; restore cc from the stack

* Wait for something to reset the flag at 2,X
WaitForChatConsume  lda       $02,x     ; bbs.chat clears ready after sending the key remotely
                    lbeq      PollChatInputs ; resume polling once the mailbox is free
                    pshs      x         ; preserve the mailbox pointer during cooperative sleep
                    ldx       #1        ; yield for one tick instead of busy-spinning
                    os9       F$Sleep   ; let BBS.chat run and consume the queued character
                    puls      x         ; restore the shared mailbox pointer
                    bra       WaitForChatConsume ; remain here until BBS.chat acknowledges it

CallerCharPending   puls      cc        ; restore interrupt state without altering the mailbox
                    lbra      WriteCallerChar ; service the existing caller character first

EndChatSession      lda       InputPath,u ; close the caller-side input path used by this helper
                    os9       I$Close   ; release the chat input path before signalling shutdown
                    lda       ChatId,u  ; address the BBS.chat process discovered at startup
                    ldb       #2        ; signal 2 tells BBS.chat that the sysop has disconnected
                    os9       F$Send    ; wake/terminate the caller-side chat handler
                    ldx       #60       ; allow one second for BBS.chat to finish cleanly
                    os9       F$Sleep   ; avoid racing the shared module teardown
                    bra       Exit      ; report successful completion to the invoking menu

NoChatProcess       leax      >NoChat,pc ; explain why Answer cannot establish a relay
                    ldy       #200      ; set y to the constant 200
                    lda       #1        ; set a to the constant 1
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    ldb       #1        ; set b to the constant 1
                    bra       ErrExit   ; continue execution at ErrExit

Exit                clrb                ; clear b to zero and set the condition codes
ErrExit             os9       F$Exit    ; terminate the process with status B

                    emod      ;         emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end       ;         end the assembly source
