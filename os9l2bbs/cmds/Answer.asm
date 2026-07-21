**********************************************************************
* Answer - OS-9 Level 2 BBS command
*
* syntax: Answer
* purpose: attach the sysop to a pending BBS.chat request and relay both streams.
* coordination: discovers BBS.chat by process module name and links its shared mailbox.
*
* edt/rev  YYYY/MM/DD  Modified by
* comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* annotated source and normalized comments.
*          2026/07/21  Codex
* refined command annotations and normalized formatting.
**********************************************************************

                    nam       answer
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; executable object module
atrv                set       ReEnt+rev ; reentrant module with revision encoded below
rev                 set       $01       ; original module revision

                    mod       eom,name,tylg,atrv,start,size ; declare the OS-9 module header and entry point

ChatPid             rmb       1         ; process ID of the discovered BBS.chat instance
ChatPidReserved     rmb       3         ; unused tail of the original four-byte allocation
OperatorByte        rmb       1         ; single sysop keystroke read from standard input
ChatInputPath       rmb       1         ; zero-initialized path closed when chat ends
CandidatePid        rmb       1         ; process ID currently being examined
CandidateScratch    rmb       4         ; unused tail of the original five-byte allocation
OriginalArguments   rmb       2         ; preserved but otherwise unused command-line pointer
ChatMailbox         rmb       2         ; pointer to BBS.chat shared ready/character fields
ProcessDescriptor   rmb       512       ; buffer populated by F$GPrDsc during discovery
CopiedModuleBuffer  rmb       432       ; remote module header followed by its copied name
size                equ       .         ; total per-process workspace size

name                fcs       /answer/  ; os-9 module name
                    fcc       "Copyright (C) 1988By Keith Alphonso" ; original embedded notice
                    fcc       "Licenced to Alpha Software Technologies" ; original licensee text
                    fcc       "All rights reserved" ; original rights statement
LicensePayload      fcb       $EC       ; opaque high-bit-set licensing payload
                    fcb       $E6       ; preserve licensing payload byte two
                    fcb       $EA       ; preserve licensing payload byte three
                    fcb       $F5       ; preserve licensing payload byte four
                    fcb       $E9       ; preserve licensing payload byte five
                    fcb       $A0       ; preserve licensing payload byte six
                    fcb       $E2       ; preserve licensing payload byte seven
                    fcb       $ED       ; preserve licensing payload byte eight
                    fcb       $F1       ; preserve licensing payload byte nine
                    fcb       $E9       ; preserve licensing payload byte ten
                    fcb       $F0       ; preserve licensing payload byte eleven
                    fcb       $EF       ; preserve licensing payload byte twelve
                    fcb       $F4       ; preserve licensing payload byte thirteen
                    fcb       $F0       ; preserve the original payload terminator
AnsweringMessage    fcc       "Answering call..." ; sysop-side connection status
                    fcc       "Press <ALT><X> when finished." ; operator exit instruction
                    fcb       C$CR      ; terminate the combined status line
LineFeed            fcb       C$LF      ; lf appended after each relayed CR
                    fcb       C$CR      ; unused adjacent CR preserved from the original
ChatModuleName      fcs       "BBS.chat" ; high-bit-terminated discovery and link name
NoChatMessage       fcc       "Sorry, no one has requested to chat!" ; no-process response
                    fcb       C$CR      ; terminate the response
ChatDivider         fcc       "----------------------------------------------------------------" ; visual relay separator
                    fcb       C$CR      ; terminate the divider
UnusedDeviceName    fcc       "/t2"     ; preserved but unreferenced serial-device text
                    fcb       C$CR      ; terminate the unused path name

ChatAnswerSignal    equ       129       ; private signal interpreted by BBS.chat as sysop arrival
MailboxReadyOffset  equ       2         ; ready byte located after BBS.chat's entry branch
MailboxCharOffset   equ       3         ; shared character immediately following ready byte
AltXCharacter       equ       248       ; coco keyboard code used to end the sysop relay

start               stx       OriginalArguments,u ; retain the unused parameter pointer
                    lda       #2        ; process IDs zero and one are not caller commands
                    sta       CandidatePid,u ; begin discovery with process two

* scan active process descriptors and copy each process's module name from its
* DAT image until the high-bit-terminated name matches BBS.chat.
ScanProcesses       lda       CandidatePid,u ; select the process being examined
                    lbeq      NoChatProcess ; process IDs wrapped without finding BBS.chat
                    leax      ProcessDescriptor,u ; receive the candidate descriptor
                    os9       F$GPrDsc  ; inspect process A
                    bcs       AdvanceProcess ; nonexistent IDs have no module name
                    leay      <P$DATImg,x ; locate the descriptor's DAT image
                    tfr       y,d       ; supply that image pointer to F$CpyMem
                    ldx       <$0011,x  ; select the process module's logical offset
                    ldy       #9        ; copy enough header bytes to include M$Name
                    pshs      u         ; preserve Answer's workspace pointer
                    leau      >CopiedModuleBuffer,u ; receive the remote module header
                    os9       F$CpyMem  ; copy nine bytes from the candidate process
                    lbcs      ExitWithStatus ; propagate a cross-process copy failure
                    pshs      d         ; preserve the candidate DAT image pointer
                    ldd       M$Name,u  ; read the copied module-name offset
                    leax      d,x       ; select that name within the remote module
                    puls      d         ; restore the DAT image for the second copy
                    ldy       #32       ; allow up to 32 bytes for the module name
                    os9       F$CpyMem  ; copy the candidate's high-bit-terminated name
                    lbcs      ExitWithStatus ; propagate a name-copy failure
                    puls      u         ; recover Answer's workspace pointer

                    leax      >CopiedModuleBuffer,u ; select the copied candidate name
                    leay      >ChatModuleName,pc ; select the expected module name

CompareModuleNames  lda       ,x+       ; fetch the next candidate name byte
                    cmpa      ,y+       ; require the expected byte at the same position
                    bne       AdvanceProcess ; reject the first mismatch
                    tsta                ; test the OS-9 high-bit name terminator
                    bpl       CompareModuleNames ; continue through ordinary characters

                    lda       CandidatePid,u ; recover the matching process ID
                    sta       ChatPid,u ; retain it for signalling and shutdown
                    bra       SignalChatProcess ; notify BBS.chat that the sysop answered

AdvanceProcess      inc       CandidatePid,u ; inspect the next one-byte process ID
                    bra       ScanProcesses ; continue until a match or wraparound

SignalChatProcess   lda       ChatPid,u ; address the discovered BBS.chat process
                    ldb       #ChatAnswerSignal ; select its private answer notification
                    os9       F$Send    ; wake BBS.chat and clear its waiting flag
                    bcc       BeginChatRelay ; bbs.chat accepted the sysop-answer signal
                    ldx       #1        ; wait while another signal remains pending
                    os9       F$Sleep   ; allow BBS.chat to run its intercept handler
                    bra       SignalChatProcess ; retry until OS-9 accepts the signal

* Write "answering call..."
BeginChatRelay      leax      >AnsweringMessage,pc ; select the operator instructions
                    ldy       #200      ; allow I$WritLn to locate their CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; announce the active relay

* Write a line of dashes
                    leax      >ChatDivider,pc ; select the 64-character separator
                    ldy       #65       ; include its terminating CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; separate instructions from chat text

* Link to BBS_Chat
                    leax      >ChatModuleName,pc ; select BBS.chat by name
                    lda       #Prgrm+Objct ; require a 6809 executable module
                    pshs      u         ; preserve Answer's workspace during F$Link
                    os9       F$Link    ; obtain the linked module's execution address in Y
                    lbcs      ExitWithStatus ; propagate a module-link failure

                    puls      u         ; recover Answer's workspace pointer
                    sty       ChatMailbox,u ; retain BBS.chat's entry/mailbox base

* Relay whichever side has a character ready.  The caller side deposits a
* character in shared offset 3 and raises the ready byte at offset 2.  The
* sysop side is standard input and is polled with SS.Ready.
PollChatInputs      clra                ; select the sysop's standard input path
                    ldb       #SS.Ready ; request a nonblocking readiness test
                    os9       I$GetStt  ; test whether the sysop typed a character
                    bcc       ReadOperatorKey ; consume the pending operator keystroke
                    ldx       ChatMailbox,u ; inspect the caller-to-sysop mailbox instead
                    tst       MailboxReadyOffset,x ; caller raised this when the character is valid
                    beq       PollChatInputs ; neither endpoint has input yet

WriteCallerChar     pshs      x         ; preserve the shared mailbox base across I$Write
                    leax      MailboxCharOffset,x ; point X at the caller's deposited character
                    ldy       #1        ; relay exactly one mailbox character
                    lda       #1        ; send it to the sysop's standard output
                    os9       I$Write   ; display the caller character locally
                    puls      x         ; recover the mailbox base needed for acknowledgement
                    lda       MailboxCharOffset,x ; retain the byte for newline handling
                    cmpa      #C$CR     ; os-9 text output needs an LF paired with caller CR
                    bne       AcknowledgeCallerChar ; ordinary characters need no translation

* Write LF after each CR
                    pshs      x         ; preserve the shared mailbox pointer
                    leax      >LineFeed,pc ; select the LF byte
                    ldy       #1        ; append exactly one byte
                    lda       #1        ; target standard output
                    os9       I$Write   ; complete the local newline
                    puls      x         ; recover the shared mailbox pointer

AcknowledgeCallerChar clr       MailboxReadyOffset,x ; release the slot back to BBS.chat
                    bra       PollChatInputs ; service the next ready endpoint

ReadOperatorKey     leax      OperatorByte,u ; receive the pending sysop keystroke
                    ldy       #1        ; consume one key selected by SS.Ready
                    os9       I$Read    ; read without waiting because readiness was confirmed
                    lbcs      ExitWithStatus ; propagate an input-path failure
                    lda       ,x        ; obtain the operator key for routing/translation
                    cmpa      #AltXCharacter ; alt-X is the documented end-chat command
                    beq       EndChatSession ; notify BBS.chat and return to the sysop menu
                    cmpa      #C$CR     ; mirror a local newline before forwarding CR
                    bne       QueueOperatorChar ; forward other keys unchanged

* Write LF after each CR
                    leax      >LineFeed,pc ; select the LF byte
                    ldy       #1        ; append exactly one byte
                    lda       #1        ; target standard output
                    os9       I$Write   ; complete the local newline

                    lda       #C$CR     ; restore the caller-bound CR after writing LF
QueueOperatorChar   ldx       ChatMailbox,u ; address the sysop-to-caller mailbox
                    pshs      cc        ; preserve the operator's interrupt state
                    orcc      #IntMasks ; make mailbox test-and-set atomic
                    tst       MailboxReadyOffset,x ; is another character already pending?
                    bne       CallerCharPending ; do not overwrite an unconsumed caller character
                    sta       MailboxCharOffset,x ; deposit the operator character
                    lda       #1        ; mark that character ready
                    sta       MailboxReadyOffset,x ; publish the mailbox contents
                    puls      cc        ; restore interrupt masks

* Wait for something to reset the flag at 2,X
WaitForChatConsume  lda       MailboxReadyOffset,x ; has BBS.chat consumed the key?
                    lbeq      PollChatInputs ; resume polling once the mailbox is free
                    pshs      x         ; preserve the mailbox pointer during cooperative sleep
                    ldx       #1        ; yield for one tick instead of busy-spinning
                    os9       F$Sleep   ; let BBS.chat run and consume the queued character
                    puls      x         ; restore the shared mailbox pointer
                    bra       WaitForChatConsume ; remain here until BBS.chat acknowledges it

CallerCharPending   puls      cc        ; restore interrupt state without altering the mailbox
                    lbra      WriteCallerChar ; service the existing caller character first

EndChatSession      lda       ChatInputPath,u ; select the zero-initialized input path
                    os9       I$Close   ; release the chat input path before signalling shutdown
                    lda       ChatPid,u ; address the BBS.chat process discovered at startup
                    ldb       #S$Abort  ; signal two tells BBS.chat the sysop disconnected
                    os9       F$Send    ; wake/terminate the caller-side chat handler
                    ldx       #60       ; allow one second for BBS.chat to finish cleanly
                    os9       F$Sleep   ; avoid racing the shared module teardown
                    bra       Exit      ; report successful completion to the invoking menu

NoChatProcess       leax      >NoChatMessage,pc ; select the no-request response
                    ldy       #200      ; allow I$WritLn to locate its CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; explain why no relay can be established
                    ldb       #1        ; return the original not-found status
                    bra       ExitWithStatus ; finish without scanning again

Exit                clrb                ; report a normal operator-ended chat
ExitWithStatus      os9       F$Exit    ; return status B to the invoking process

                    emod                ; append the OS-9 module CRC placeholder and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end                 ; finish this assembly unit
