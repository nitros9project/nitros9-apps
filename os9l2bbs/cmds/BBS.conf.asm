**********************************************************************
* BBS.conf - OS-9 Level 2 BBS command
*
* syntax: BBS.conf
* purpose: join the shared conference and exchange line-oriented messages.
* Conf.dat begins with twenty {biased user ID, notification flag} records.
* A zero flag means that a new shared message awaits that participant; one
* means it has already been displayed. The shared payload combines a 200-byte
* message area with the sender's handle so every process can redraw it.
*
* edt/rev  YYYY/MM/DD  Modified by
* comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* annotated source and normalized comments.
*          2026/07/21  Codex
* decoded participant registration, notification, and message exchange.
**********************************************************************

                    nam       BBS.conf
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; executable object module
atrv                set       ReEnt+rev ; reentrant module with revision encoded below
rev                 set       $01       ; original module revision

                    mod       eom,name,tylg,atrv,start,size ; declare the OS-9 module header and entry point

ScratchPointer      rmb       2         ; temporary pointer used for buffer bounds and lengths
BiasedUserId        rmb       2         ; os-9 user ID plus one; zero remains the vacant marker
LinkedModuleAddress rmb       2         ; linked module pointer required by f$unlink
ConferenceData      rmb       2         ; execution/data address of Conf.dat's shared bytes
MessageCursor       rmb       2         ; next position in the local message buffer
MessageStart        rmb       2         ; fixed start used for bounds and redraw length
MessageBuffer       rmb       200       ; locally composed conference message
HandleBuffer        rmb       420       ; handle begins immediately after the message area
size                equ       .         ; total per-process workspace size

name                fcs       /BBS.conf/ ; os-9 module name
ConfDataName        fcc       "Conf.dat" ; shared conference data module
CarriageReturn      fcb       C$CR      ; terminate the module name and supply a blank line
                    fcb       C$LF      ; retained separator byte from the original module
HandlePrompt        fcc       "Enter your handle:" ; local identity requested on entry
ControlPrompt       fcc       "Press <CTRL><Z> to exit         <CTRL><X> who's in conf mode" ; command reminder
                    fcb       C$CR      ; terminate the reminder
PromptDivider       fcc       "------------------------------------------------------------" ; visual separator
                    fcb       C$CR      ; terminate the divider
RosterCommand       fcc       "BBS.conf.who" ; helper spawned by CTRL-X
                    fcb       C$CR      ; terminate the module name

* Signals remove this process's participant record before releasing Conf.dat.
* Only the two-byte ID is cleared; the adjacent notification byte is ignored
* once the slot ID is zero and will be reset if the slot is reused.
SignalHandler       ldx       ConferenceData,u ; begin with participant slot zero
FindOwnSlotOnSignal ldd       ,x++      ; fetch a biased user ID
                    leax      1,x       ; skip its notification byte
                    cmpd      BiasedUserId,u ; is this the current participant?
                    bne       FindOwnSlotOnSignal ; continue through occupied records
                    leax      -3,x      ; return to the matched ID word
                    clr       ,x        ; vacate its high byte
                    clr       1,x       ; vacate its low byte
                    clrb                ; discard any prior error status
                    pshs      u         ; preserve this process's workspace
                    ldu       LinkedModuleAddress,u ; select the Conf.dat module header
                    os9       F$UnLink  ; release the shared module
                    puls      u         ; recover the workspace pointer
                    clrb                ; report a clean signal-driven exit
                    os9       F$Exit    ; terminate instead of returning from the signal
                    fcb       $3B       ; unreachable rti opcode retained from the original

start               leax      >SignalHandler,pc ; select conference cleanup for signals
                    os9       F$Icpt    ; install the signal-intercept routine
                    os9       F$ID      ; obtain the process's OS-9 user ID in Y
                    leay      1,y       ; bias it so zero can mark a vacant slot
                    sty       BiasedUserId,u ; retain the participant-table representation
                    leax      >HandlePrompt,pc ; ask for this session's display handle
                    ldy       #18       ; write the fixed prompt without a terminator
                    lda       #1        ; target standard output
                    os9       I$Write   ; display the handle prompt
                    clra                ; read the response from standard input
                    leax      >HandleBuffer,u ; keep the handle after the message buffer
                    ldy       #20       ; accept at most twenty bytes including CR
                    os9       I$ReadLn  ; capture the sender name used on every post
                    leax      >ControlPrompt,pc ; select the conference controls reminder
                    ldy       #200      ; allow I$WritLn to locate its CR
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; explain exit and roster keystrokes
                    leax      >PromptDivider,pc ; select the visual separator
                    ldy       #200      ; allow I$WritLn to locate its CR
                    os9       I$WritLn  ; separate the prompt from conference traffic

                    leax      >ConfDataName,pc ; select the shared data module
                    lda       #65       ; require a data/object module
                    pshs      u         ; preserve this process's workspace pointer
                    os9       F$Link    ; join an already active conference
                    bcc       RememberSharedModule ; use the existing shared state
                    cmpb      #221      ; was Conf.dat simply absent from memory?
                    lbne      ExitWithStatus ; propagate unexpected link errors
                    os9       F$Load    ; start the conference from the module file
                    lbcs      ExitWithStatus ; abort if Conf.dat cannot be loaded
RememberSharedModule
                    tfr       u,d       ; retain the module pointer used by F$UnLink
                    puls      u         ; recover this process's workspace pointer
                    std       LinkedModuleAddress,u ; remember the linked module header
                    sty       ConferenceData,u ; remember the shared data-area address
                    leax      MessageBuffer,u ; initialize an empty local composition
                    stx       MessageCursor,u ; place the cursor at its first byte
                    stx       MessageStart,u ; retain the lower bound for backspace

* Claim the first vacated zero slot or the first never-used $FFFF slot. Each
* record is three bytes: biased user ID followed by its notification flag.
FindRegistrationSlot
                    ldd       ,y        ; inspect this slot's biased user ID
                    beq       RegisterParticipant ; reuse a vacated slot
                    cmpd      #-1       ; is this the first never-used slot?
                    beq       RegisterParticipant ; extend the compact roster here
                    leay      3,y       ; advance to the next participant record
                    bra       FindRegistrationSlot ; continue until a slot is available
RegisterParticipant ldd       BiasedUserId,u ; identify this participant
                    std       ,y++      ; occupy the slot and select its flag
                    lda       #1        ; no conference message is pending initially
                    sta       ,y        ; mark existing shared text as consumed

ConferenceLoop      lbsr      DisplayPendingMessage ; show traffic posted by any participant
                    lbsr      PollConferenceInput ; accept at most one local keystroke
                    bra       ConferenceLoop ; alternate continuously between both directions

* Locate this participant's flag. A zero flag means another process posted a
* message since the last poll; setting it to one acknowledges that message.
DisplayPendingMessage
                    ldx       ConferenceData,u ; begin with participant slot zero
FindOwnNotification ldd       ,x++      ; fetch a biased user ID
                    cmpd      #-1       ; did the search run beyond the active roster?
                    lbeq      ExitMissingRegistration ; treat a vanished slot as fatal
                    cmpd      BiasedUserId,u ; is this the current participant?
                    beq       CheckNotification ; inspect its pending-message flag
                    leax      1,x       ; skip the unrelated participant's flag
                    bra       FindOwnNotification ; continue through the roster
CheckNotification   lda       ,x+       ; fetch the current participant's flag
                    beq       RenderSharedMessage ; zero announces unread shared text
                    rts                 ; leave already-consumed text undisplayed
RenderSharedMessage lda       #1        ; acknowledge the pending message
                    sta       -1,x      ; prevent it from being printed again
                    leax      >CarriageReturn,pc ; begin incoming traffic on a fresh line
                    ldy       #1        ; write only the CR byte
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; move below the local composition

* Posting copies 255 bytes beginning with the 200-byte message buffer into
* Conf.dat+60. Consequently the sender handle begins at shared offset 260.
* Render the handle first, then the CR-terminated message, then redraw any
* partial local composition so asynchronous traffic does not erase it.
                    ldx       ConferenceData,u ; select the shared payload base
                    leax      >$0104,x  ; move to the copied sender handle
                    clrb                ; count handle bytes for I$Write
FindHandleEnd       lda       ,x+       ; scan the shared sender handle
                    incb                ; include this byte in the output length
                    cmpa      #':'      ; was a prior reader's colon encountered?
                    beq       WriteSharedHandle ; reuse the existing delimiter
                    cmpa      #C$CR     ; is this the handle's original terminator?
                    bne       FindHandleEnd ; continue through the handle
WriteSharedHandle   lda       #':'      ; display a colon between sender and message
                    sta       -1,x      ; replace CR or preserve an existing colon
                    clra                ; form the 16-bit handle length in D
                    tfr       d,y       ; pass that length to I$Write
                    ldx       ConferenceData,u ; return to the shared payload base
                    leax      >$0104,x  ; select the sender handle again
                    lda       #1        ; target standard output
                    os9       I$Write   ; print the sender handle and colon
                    ldx       ConferenceData,u ; return to the shared payload base
                    leax      <$003C,x  ; select the CR-terminated message at offset 60
                    lda       #1        ; target standard output
                    ldy       #200      ; bound the conference message
                    os9       I$WritLn  ; print the incoming message
                    leax      MessageBuffer,u ; select the local partial composition
                    stx       ScratchPointer,u ; retain its starting address
                    ldd       MessageCursor,u ; locate the next local input position
                    subd      ScratchPointer,u ; compute the number of typed bytes
                    tfr       d,y       ; pass the redraw length to I$Write
                    leax      MessageBuffer,u ; restart at the local message beginning
                    lda       #1        ; target standard output
                    os9       I$Write   ; redraw text interrupted by the incoming message
                    rts                 ; resume the bidirectional conference loop

ExitMissingRegistration
                    ldb       #1        ; report the missing participant record
                    lbra      ExitWithStatus ; terminate because shared state is inconsistent

* Poll standard input without blocking. Ordinary bytes extend the 200-byte
* local composition; backspace retreats the cursor, CR publishes it, CTRL-Z
* leaves the conference, and CTRL-X temporarily runs the roster command.
PollConferenceInput clra                ; select standard input
                    ldb       #1        ; request the ready-byte count
                    os9       I$GetStt  ; test whether a keystroke is available
                    bcs       ReturnFromInput ; keep polling when no byte is ready
                    ldy       #1        ; consume exactly one byte
                    ldx       MessageCursor,u ; receive it at the current cursor
                    os9       I$Read    ; read the pending keystroke
                    lda       ,x+       ; inspect it and tentatively advance the cursor
                    cmpa      #C$BSP    ; did the user erase the previous byte?
                    beq       HandleBackspace ; retreat within the local buffer
                    cmpa      #26       ; did the user press CTRL-Z?
                    lbeq      LeaveConference ; unregister and exit
                    cmpa      #24       ; did the user press CTRL-X?
                    lbeq      ShowConferenceRoster ; run BBS.conf.who synchronously
                    cmpa      #C$CR     ; did the user finish this message?
                    beq       PublishMessage ; copy it into shared state
                    leay      >HandleBuffer,u ; one past the 200-byte message area
                    sty       ScratchPointer,u ; retain the hard upper bound
                    cmpx      ScratchPointer,u ; did this byte fill the final position?
                    lbeq      ReturnFromInput ; stop advancing once the buffer is full
                    stx       MessageCursor,u ; accept the ordinary character
                    bra       InputActionComplete ; resume polling shared traffic

PublishMessage      leax      >CarriageReturn,pc ; move the terminal to a fresh line
                    ldy       #1        ; write only the CR byte
                    lda       #1        ; target standard output
                    os9       I$WritLn  ; finish the locally echoed input line
                    ldx       ConferenceData,u ; select the shared data-area base
                    leax      <$003C,x  ; skip the twenty participant records
                    leay      MessageBuffer,u ; select message followed by handle
                    sty       MessageCursor,u ; reset local composition for the next line
                    ldb       #255      ; publish message plus the leading handle region
CopySharedPayload   lda       ,y+       ; fetch the next local payload byte
                    sta       ,x+       ; make it visible to all linked processes
                    decb                ; count down the fixed transfer
                    bne       CopySharedPayload ; continue through all 255 bytes
                    lda       #':'      ; guard the shared handle scan with a delimiter
                    sta       ,x+       ; terminate the copied payload at offset 315
                    ldx       ConferenceData,u ; begin at participant slot zero
NotifyParticipant   ldd       ,x++      ; fetch the next biased user ID
                    cmpd      #-1       ; has the active roster ended?
                    beq       ReturnFromInput ; finish once all participants are notified
                    clr       ,x+       ; mark the shared message unread for this user
                    bra       NotifyParticipant ; notify every occupied or vacated slot

ReturnFromInput     clra                ; preserve the original successful poll result
InputActionComplete rts                 ; resume the main conference loop

HandleBackspace     leax      -2,x      ; undo the input advance and remove one prior byte
                    cmpx      MessageStart,u ; would this retreat before the buffer start?
                    bls       BackspaceComplete ; ignore backspace at the beginning
                    stx       MessageCursor,u ; accept the shortened composition
BackspaceComplete   rts                 ; resume polling shared traffic

LeaveConference     ldx       ConferenceData,u ; begin with participant slot zero
FindOwnSlotOnExit   ldd       ,x++      ; fetch a biased user ID
                    leax      1,x       ; skip its notification byte
                    cmpd      BiasedUserId,u ; is this the current participant?
                    bne       FindOwnSlotOnExit ; continue until the record is found
                    leax      -3,x      ; return to the matched ID word
                    clr       ,x        ; vacate its high byte
                    clr       1,x       ; vacate its low byte
                    pshs      u         ; preserve this process's workspace
                    ldu       LinkedModuleAddress,u ; select the Conf.dat module header
                    os9       F$UnLink  ; release the shared conference state
                    puls      u         ; recover the workspace pointer
                    clrb                ; report a successful voluntary exit
ExitWithStatus      os9       F$Exit    ; return status B to the invoking process

ShowConferenceRoster
                    lda       #17       ; fork an executable object module
                    ldb       #3        ; grant the child three 256-byte pages
                    ldy       #1        ; pass a one-byte parameter area
                    leax      >RosterCommand,pc ; select BBS.conf.who
                    pshs      u         ; preserve this process's workspace
                    leau      >CarriageReturn,pc ; supply an empty command line
                    os9       F$Fork    ; start the roster command
                    os9       F$Wait    ; keep conference input paused until it finishes
                    puls      u         ; recover the workspace pointer
                    rts                 ; return to conference polling

                    emod                ; emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end                 ; end the assembly source
