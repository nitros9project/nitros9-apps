**********************************************************************
* BBS.chat - OS-9 Level 2 BBS command
*
* syntax: BBS.chat
* purpose: page the sysop and exchange characters with the Answer command.
* coordination: signals and a two-byte mailbox embedded immediately after start.
*
* edt/rev  YYYY/MM/DD  Modified by
* comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* annotated source and normalized comments.
*          2026/07/21  Codex
* refined command annotations and normalized formatting.
**********************************************************************

                    nam       BBS.chat
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; executable object module
atrv                set       ReEnt+rev ; reentrant module with revision encoded below
rev                 set       $01       ; original module revision

                    mod       eom,name,tylg,atrv,start,size ; declare the OS-9 module header and entry point

DefaultBeepCount    rmb       1         ; bell bursts issued during each paging round
BeepsRemaining      rmb       1         ; bells left in the current burst
WaitingForSysop     rmb       1         ; nonzero until Answer sends its private signal
ReservedFlags       rmb       2         ; unused tail of the original three-byte flag area
PagingRoundsLeft    rmb       1         ; remaining bell/dot rounds before giving up
SysopWindowPath     rmb       1         ; open path to /w used for audible paging
OriginalArguments   rmb       2         ; preserved but otherwise unused command-line pointer
ReservedWorkspace   rmb       400       ; retain the command's original minimum data allocation
size                equ       .         ; total per-process workspace size

name                fcs       /BBS.chat/ ; os-9 module name

PagingMessage       fcc       "Paging Sysop...Please wait" ; caller status while Answer is sought
                    fcb       C$CR      ; terminate the display line

NoAnswerMessage     fcc       "Sorry, but the sysop does not seem to be home!" ; timeout response
                    fcb       C$CR      ; terminate the display line

LineFeed            fcb       C$LF      ; local LF appended after each relayed CR
                    fcb       C$CR      ; unused adjacent CR preserved from the original

SysopWindowName     fcc       "/w"      ; window used to alert the local operator
                    fcb       C$CR      ; terminate the path name

PagingDot           fcc       "."       ; progress marker written to the caller
                    fcb       C$CR      ; unused adjacent CR preserved from the original

BellCharacter       fcb       C$BELL    ; audible alert written to /w

* Answer links this module and receives its execution address in Y. Keeping the
* mailbox at start+2/start+3 lets both processes exchange one byte without a
* separate shared-data module.
start               bra       InitializeChat ; skip over the shared mailbox at process entry

MailboxReady        fcb       0         ; nonzero while MailboxCharacter awaits consumption
MailboxCharacter    fcb       0         ; single character travelling in either direction

InitializeChat      stx       OriginalArguments,u ; retain the unused parameter pointer
                    lda       #10       ; ring ten times in each paging burst
                    sta       DefaultBeepCount,u ; retain the burst length

* Set up the signal intercept handler
                    leax      >HandleSignal,pc ; select the chat coordination handler
                    os9       F$Icpt    ; intercept Answer's private signal and shutdown requests

                    lda       #$FF      ; begin in the unanswered state
                    sta       WaitingForSysop,u ; a private signal clears this byte
                    lda       #10       ; allow ten paging rounds
                    sta       PagingRoundsLeft,u ; retain the timeout counter

* Open /w for read/write
                    leax      >SysopWindowName,pc ; select the local paging window
                    lda       #UPDAT.   ; open it for input and output
                    os9       I$Open    ; obtain the window path in A
                    lbcs      ExitWithStatus ; propagate a window-open failure
                    sta       SysopWindowPath,u ; retain the path for bell output

* Inform the user we are paging the sysop
                    leax      >PagingMessage,pc ; select the caller status line
                    ldy       #200      ; allow I$WritLn to locate its CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; announce that the sysop is being paged

**************************************************
* Page the sysop to join the chat
PageLoop            lda       DefaultBeepCount,u ; recover the configured burst length
                    sta       BeepsRemaining,u ; restart the bell burst

* Ding the sysop
RingSysopBell       leax      >BellCharacter,pc ; select the audible alert byte
                    lda       SysopWindowPath,u ; target the local operator window
                    ldy       #1        ; write exactly one bell
                    os9       I$Write   ; sound the alert
                    lbcs      ExitWithStatus ; propagate a paging-window failure
                    ldx       #4        ; space bells by four scheduler ticks
                    os9       F$Sleep   ; make the repeated alerts distinct
                    dec       BeepsRemaining,u ; account for this bell
                    bne       RingSysopBell ; finish the current burst

                    ldx       #90       ; pause between paging bursts
                    os9       F$Sleep   ; give the sysop time to run Answer
                    tst       WaitingForSysop,u ; did Answer send its private signal?
                    beq       SysopAnswered ; begin relaying once the flag is cleared

* Write a dot on /w
                    leax      >PagingDot,pc ; select the caller progress marker
                    ldy       #1        ; write only the dot, not its adjacent CR
                    lda       #1        ; target standard output
                    os9       I$Write   ; show that paging is still active
                    dec       PagingRoundsLeft,u ; consume one unanswered round
                    bne       PageLoop  ; repeat until all ten rounds expire

* Nobody's home so inform the user and exit
                    leax      >NoAnswerMessage,pc ; select the paging-timeout response
                    ldy       #200      ; allow I$WritLn to locate its CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; tell the caller that the sysop did not answer
                    lbra      ExitSuccess ; return normally after the timeout

SysopAnswered       clr       >MailboxReady,pc ; initialize the shared mailbox as empty

* Wait for the user or the sysop to press a key
PollChatInputs      clra                ; query caller input on path zero
                    ldb       #SS.Ready ; test without blocking
                    os9       I$GetStt  ; ask whether the caller typed a character
                    bcc       ReadCallerCharacter ; consume ready caller input
                    tst       >MailboxReady,pc ; did Answer queue a sysop character?
                    beq       PollChatInputs ; continue until either endpoint is ready

* Echo the sysop's char to the user
WriteSysopCharacter leax      >MailboxCharacter,pc ; select Answer's queued character
                    ldy       #1        ; relay exactly one byte
                    lda       #1        ; target caller output
                    os9       I$Write   ; display the sysop character remotely

                    lda       >MailboxCharacter,pc ; inspect it for newline translation
                    cmpa      #C$CR     ; does the remote terminal need a following LF?
                    bne       ReleaseMailbox ; ordinary characters need no translation

* Append LF to CR on the output path
                    leax      >LineFeed,pc ; select the local LF byte
                    ldy       #1        ; append exactly one byte
                    lda       #1        ; target caller output
                    os9       I$Write   ; complete the remote newline

ReleaseMailbox      clr       >MailboxReady,pc ; acknowledge Answer's queued character
                    bra       PollChatInputs ; service the next ready endpoint

ReadCallerCharacter tst       >MailboxReady,pc ; is a sysop character already pending?
                    bne       WriteSysopCharacter ; service it before overwriting the mailbox

* Read one character from the user
                    leax      >MailboxCharacter,pc ; read directly into the shared byte
                    ldy       #1        ; consume one caller character
                    clra                ; select standard input
                    os9       I$Read    ; block only after SS.Ready confirmed input

                    lda       ,x        ; retain the caller byte across optional LF output
                    cmpa      #C$CR     ; mirror a local LF after caller CR
                    bne       PublishCallerCharacter ; queue ordinary bytes immediately

* Append an LF to the CR
                    leax      >LineFeed,pc ; select the local LF byte
                    ldy       #1        ; append exactly one byte
                    lda       #1        ; target caller output
                    os9       I$Write   ; echo the complete newline to the caller

PublishCallerCharacter pshs   cc        ; preserve the caller's interrupt state
                    orcc      #IntMasks ; make mailbox test-and-set atomic
                    tst       >MailboxReady,pc ; did Answer publish concurrently?
                    bne       ServiceConcurrentSysopChar ; preserve the existing sysop byte
                    lda       #1        ; mark the caller byte ready for Answer
                    sta       >MailboxReady,pc ; publish the shared mailbox contents
                    puls      cc        ; restore interrupt masks

* Sleep until the flag is cleared
WaitForAnswerConsume lda      >MailboxReady,pc ; has Answer consumed the caller byte?
                    lbeq      PollChatInputs ; resume once the mailbox becomes free
                    ldx       #1        ; yield one scheduler tick
                    os9       F$Sleep   ; let Answer run and clear the ready flag
                    bra       WaitForAnswerConsume ; wait for acknowledgement

ServiceConcurrentSysopChar puls cc       ; restore interrupt masks
                    lbra      WriteSysopCharacter ; relay the pre-existing sysop byte first

ExitSuccess         clrb                ; return success after chat or paging timeout
ExitWithStatus      os9       F$Exit    ; return status B to the invoking menu

* Interrupt service handler
HandleSignal        cmpb      #S$Abort  ; signal two ends the caller-side chat process
                    beq       ExitFromSignal ; terminate immediately
                    cmpb      #S$Intrpt ; leave keyboard-interrupt handling unchanged
                    beq       ReturnFromSignal ; ignore signal three
                    clr       WaitingForSysop,u ; any private signal means Answer attached
ReturnFromSignal    rti                 ; resume the interrupted paging or relay loop

ExitFromSignal      clrb                ; report a clean sysop-initiated shutdown
                    os9       F$Exit    ; terminate from the intercept handler

                    emod                ; append the OS-9 module CRC placeholder and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end                 ; finish this assembly unit
