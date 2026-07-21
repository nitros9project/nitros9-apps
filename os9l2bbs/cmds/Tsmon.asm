**********************************************************************
* Tsmon - OS-9 Level 2 BBS command
*
* syntax: Tsmon [-m] <port>
* purpose: prepare a modem port, detect caller baud, and supervise a BBS session.
* forks BBS.login and normally Monitor, then recycles the port for the next call.
*
* edt/rev  YYYY/MM/DD  Modified by
* comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* annotated source and normalized comments.
*          2026/07/21  Codex
* refined command annotations and normalized formatting.
**********************************************************************

                    nam       Tsmon
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; executable object module
atrv                set       ReEnt+rev ; reentrant module with revision encoded below
rev                 set       $01       ; original module revision

                    mod       eom,name,tylg,atrv,start,size ; declare the OS-9 module header and entry point

InputByte           rmb       1         ; byte sampled while detecting the caller's baud rate
LoginPid            rmb       1         ; process ID returned when BBS.login is forked
MonitorPid          rmb       1         ; process ID returned when Monitor is forked
SuppressMonitor     rmb       1         ; nonzero when the -m option disables Monitor
PollCountdown       rmb       1         ; wraps through 255 readiness polls before falling back
BaudCode            rmb       1         ; scf PD.BAU code currently applied to the port
PortArgument        rmb       2         ; command-line pointer to the serial device name
OptionsBuffer       rmb       32        ; scf path options returned by SS.Opt
ModemSetupBuffer    rmb       600       ; one line read from Modem.set
size                equ       .         ; total per-process workspace size

name                fcs       /Tsmon/   ; os-9 module name
                    fcc       "Copyright (C) 1988By Keith AlphonsoLicenced to Alpha Software TechnologiesAll rights reserved" ; original embedded notice
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
LoginCommand        fcc       "BBS.login" ; bbs-specific login module forked for the caller
                    fcb       C$CR      ; terminate the module name for F$Fork
MonitorCommand      fcc       "Monitor" ; carrier-loss process-tree monitor
                    fcb       C$CR      ; terminate the module name for F$Fork
EmptyParameters     fcb       C$CR      ; empty child parameter line
UnusedStatusPrefix  fcb       C$LF      ; preserved prefix from the original status text
                    fcc       "Monitoring " ; preserved but not referenced by this module
BaudDescriptions    fcc       "110  Baud 300  Baud 600  Baud 1200 Baud 2400 Baud " ; ten-byte text indexed by PD.BAU
SerialFormatText    fcc       "8 bits, no parity" ; fixed framing configured for callers
                    fcb       C$CR      ; terminate the status line
LogColumnHeadings   fcc       "User name            Date                time" ; session log headings
                    fcb       C$CR      ; terminate the heading line
LogDivider          fcc       "------------------------------------------------------------------------" ; separate log headings from entries
                    fcb       C$CR      ; terminate the divider line
LogDeviceName       fcc       "/p"      ; system path receiving session log headings
                    fcb       C$CR      ; terminate the device name
ModemSetupName      fcc       "Modem.set" ; byte-paced modem initialization commands
                    fcb       C$CR      ; terminate the file name
StatusWindowName    fcc       "/Wb"     ; local window opened before standard paths are replaced
                    fcb       C$CR      ; terminate the device name

OptionBias          equ       $20       ; bias paired with the original negative-X addressing
BaudTextWidth       equ       10        ; bytes occupied by each baud description

start               clr       SuppressMonitor,u ; enable carrier monitoring by default
                    stx       PortArgument,u ; default the device name to the full command line
ScanForOption       lda       ,x+       ; search for an option introducer before the final CR
                    cmpa      #'-'      ; is this the optional -m switch?
                    beq       ParseMonitorOption ; inspect the following option letter
                    cmpa      #C$CR     ; has the whole command line been scanned?
                    bne       ScanForOption ; continue looking for the switch
                    bra       InitializeSupervisor ; retain the original device-name pointer
ParseMonitorOption  lda       ,x+       ; fetch the letter following the hyphen
                    anda      #$DF      ; normalize an ASCII letter to uppercase
                    cmpa      #'M'      ; only -m has meaning here
                    bne       InitializeSupervisor ; ignore an unrecognized option
                    lda       #$FF      ; mark Monitor as suppressed
                    sta       SuppressMonitor,u ; retain the option for each subsequent call
                    stx       PortArgument,u ; the serial device name follows -m

InitializeSupervisor leax     >StatusWindowName,pc ; select the local status window
                    lda       #UPDAT.   ; open the status window for input and output
                    os9       I$Open    ; occupy the next available path with /Wb
                    leax      >IgnoreSignalHandler,pc ; select a one-byte RTI intercept handler
                    os9       F$Icpt    ; prevent ordinary signals from ending the supervisor

* standard paths are rebuilt around the serial device for every call. Before
* that loop starts, initialize the session log destination with column headings.
                    clra                ; select inherited standard input
                    os9       I$Close   ; release path zero
                    inca                ; select inherited standard output
                    os9       I$Close   ; release path one
                    inca                ; select inherited standard error
                    os9       I$Close   ; release path two
                    leax      >LogDeviceName,pc ; select the session log destination
                    lda       #WRITE.   ; open it for output
                    os9       I$Open    ; obtain the log path in A
                    leax      >LogColumnHeadings,pc ; select the log's column labels
                    ldy       #200      ; allow I$WritLn to find the terminating CR
                    os9       I$WritLn  ; write one heading line to the log path
                    leax      >LogDivider,pc ; select the horizontal divider
                    ldy       #80       ; bound the divider write beyond its CR
                    os9       I$WritLn  ; finish the log header
                    os9       I$Close   ; release the log path

BeginCallCycle      ldx       PortArgument,u ; select the configured serial device
                    lda       #UPDAT.   ; request bidirectional access
                    os9       I$Open    ; install the port as standard input path zero
                    os9       I$Dup     ; duplicate it as standard output path one
                    os9       I$Dup     ; duplicate it as standard error path two

* Modem.set may contain several CR-terminated setup commands. Send each byte to
* the modem separately, pausing five ticks between non-CR bytes.
                    leax      >ModemSetupName,pc ; select the optional initialization file
                    lda       #READ.    ; open it for input
                    os9       I$Open    ; obtain its path number in A
                    bcs       ConfigurePort ; continue when no setup file is available
ReadSetupLine       leax      <ModemSetupBuffer,u ; receive one modem command
                    ldy       #200      ; cap each setup line at 200 bytes
                    os9       I$ReadLn  ; read through its terminating CR
                    bcs       CloseSetupFile ; eof or an error ends initialization
                    pshs      a         ; preserve the setup-file path
SendSetupByte       lda       #1        ; send through standard output to the modem
                    ldy       #1        ; transmit exactly the current byte
                    os9       I$Write   ; write that byte without line processing
                    lda       ,x        ; inspect the byte just transmitted
                    cmpa      #C$CR     ; did it terminate this setup command?
                    beq       NextSetupLine ; do not delay after its CR
                    leax      1,x       ; advance to the following command byte
                    pshs      x         ; preserve the transmit cursor while sleeping
                    ldx       #5        ; pace modem command characters by five ticks
                    os9       F$Sleep   ; give the modem time to consume the byte
                    puls      x         ; recover the transmit cursor
                    bra       SendSetupByte ; continue through this setup command
NextSetupLine       puls      a         ; recover the setup-file path
                    bra       ReadSetupLine ; fetch another command from the file
CloseSetupFile      os9       I$Close   ; release Modem.set after EOF

* start detection at 1200 baud with local echo disabled. The biased indexed
* operands below address PD.BAU and PD.EKO in the unchanged 32-byte option block.
ConfigurePort       leax      OptionsBuffer,u ; receive standard input's SCF options
                    clra                ; select standard input
                    clrb                ; request SS.Opt
                    os9       I$GetStt  ; snapshot the current path options
                    leax      -OptionBias,x ; retain the original biased addressing base
                    lda       #B1200    ; try 1200 baud first
                    sta       BaudCode,u ; record the detection rate
                    sta       <(PD.BAU-PD.OPT)+OptionBias,x ; update the option block's baud code
                    clr       <(PD.EKO-PD.OPT)+OptionBias,x ; suppress echo during detection
                    leax      OptionsBuffer,u ; restore the option block's true base
                    clra                ; select standard input
                    clrb                ; request SS.Opt
                    os9       I$SetStt  ; apply baud and echo changes to the port
                    clr       PollCountdown,u ; let the first decrement wrap to 255

* poll for a byte every two ticks. Exhausting the countdown reapplies the full
* port setup; a failed one-byte read falls back to 300 baud after ten ticks.
PollForCaller       dec       PollCountdown,u ; consume one readiness attempt
                    beq       ConfigurePort ; restart detection after 256 attempts
                    ldx       #2        ; wait two scheduler ticks per poll
                    os9       F$Sleep   ; yield while the modem remains idle
                    clra                ; query standard input
                    ldb       #SS.Ready ; ask whether at least one byte is buffered
                    os9       I$GetStt  ; avoid blocking until a caller byte arrives
                    bcs       PollForCaller ; keep waiting when the path is not ready
                    leax      InputByte,u ; receive the candidate carriage return
                    clr       ,x        ; remove stale input before reading
                    ldy       #1        ; consume exactly one byte
                    clra                ; read standard input
                    os9       I$Read    ; sample the byte at the current baud rate
                    bcc       ClassifyCallerByte ; process a successful read
                    ldx       #10       ; pause before the low-speed fallback
                    os9       F$Sleep   ; let transient line conditions settle
                    lda       #B300     ; fall back to 300 baud after a read error
                    bsr       ApplyBaudCode ; update the live serial path
                    clr       PollCountdown,u ; restart the readiness window
                    bra       PollForCaller ; resume detection

* a clean CR confirms the current rate. Other decoded bytes alternate the test
* between 2400 and 300 baud until a CR is recognizable.
ClassifyCallerByte  lda       InputByte,u ; inspect the decoded caller byte
                    cmpa      #C$CR     ; a carriage return confirms synchronization
                    beq       StartCallerSession ; enter the BBS at this rate
                    clr       PollCountdown,u ; give the new rate a full poll window
                    lda       BaudCode,u ; identify the rate used for this byte
                    cmpa      #B2400    ; was 2400 baud already being tested?
                    beq       TryLowBaud ; return to 300 after a bad 2400-baud byte
                    lda       #B2400    ; otherwise try the high supported rate
                    sta       BaudCode,u ; retain it for the next classification
                    bsr       ApplyBaudCode ; change the port to 2400 baud
                    bra       PollForCaller ; await another caller byte
TryLowBaud          lda       #B300     ; alternate back to 300 baud
                    sta       BaudCode,u ; retain the new detection rate
                    bsr       ApplyBaudCode ; change the port to 300 baud
                    bra       PollForCaller ; await another caller byte

ApplyBaudCode       leax      OptionsBuffer,u ; select the cached SCF option block
                    leax      -OptionBias,x ; reproduce the original biased base
                    sta       <(PD.BAU-PD.OPT)+OptionBias,x ; replace only its baud field
                    leax      OptionsBuffer,u ; restore the block's true base
                    clra                ; select standard input
                    clrb                ; request SS.Opt
                    os9       I$SetStt  ; apply the caller-selected baud rate
                    rts                 ; resume the detection loop

* restore echo, report the detected line format, and fork the two processes that
* own the caller session. Both children receive an empty CR-only parameter line.
StartCallerSession  leax      OptionsBuffer,u ; select the cached SCF option block
                    leax      -OptionBias,x ; reproduce the original biased base
                    lda       #1        ; enable normal terminal echo
                    sta       <(PD.EKO-PD.OPT)+OptionBias,x ; set the SCF echo flag
                    leax      OptionsBuffer,u ; restore the block's true base
                    clra                ; select standard input
                    clrb                ; request SS.Opt
                    os9       I$SetStt  ; publish the echo change
                    leax      -OptionBias,x ; recover the biased option address
                    ldb       <(PD.BAU-PD.OPT)+OptionBias,x ; index the active baud description
                    lda       #BaudTextWidth ; convert the baud code to a text offset
                    mul                 ; form baud code times ten in D
                    leax      >BaudDescriptions,pc ; select the description table
                    leax      d,x       ; advance to the active ten-byte entry
                    ldy       #BaudTextWidth ; write exactly one baud description
                    lda       #1        ; target the caller's standard output
                    os9       I$Write   ; report the detected baud rate
                    leax      >SerialFormatText,pc ; select the framing description
                    ldy       #200      ; allow I$WritLn to locate its CR
                    os9       I$WritLn  ; complete the connection report
                    leax      >LoginCommand,pc ; select the BBS-specific login module
                    ldy       #1        ; pass one CR as an empty parameter line
                    pshs      u         ; preserve Tsmon's workspace across both forks
                    leau      >EmptyParameters,pc ; supply the child parameter line
                    lda       #Prgrm+Objct ; require a 6809 executable module
                    ldb       #3        ; grant the child the original three-page minimum
                    os9       F$Fork    ; begin caller authentication and the BBS session
                    lbcs      ReportSessionError ; recover from a login-fork failure
                    ldu       ,s        ; inspect Tsmon's workspace without popping it
                    sta       LoginPid,u ; remember which child owns the login session
                    lda       SuppressMonitor,u ; honor the optional -m mode
                    bne       RestoreSupervisorWorkspace ; skip carrier monitoring when requested
                    leau      >EmptyParameters,pc ; supply Monitor's empty parameter line
                    leax      >MonitorCommand,pc ; select the carrier-loss monitor
                    lda       #Prgrm+Objct ; require a 6809 executable module
                    os9       F$Fork    ; start the sibling process-tree monitor
                    lbcs      ReportSessionError ; recover from a monitor-fork failure
RestoreSupervisorWorkspace puls u       ; recover Tsmon's workspace pointer
                    lbcs      ReportSessionError ; preserve the fork error across PULS
                    sta       MonitorPid,u ; remember Monitor's PID or the -m sentinel

* whichever child exits first determines cleanup. A normal login exit receives a
* one-second grace period before signal zero stops Monitor; carrier loss instead
* lets Monitor tear down the caller tree. The second wait reaps the sibling.
                    os9       F$Wait    ; wait for either session child to terminate
                    pshs      a         ; preserve the returned child process ID
                    clra                ; select standard input
                    os9       I$Close   ; release the serial input path
                    inca                ; select standard output
                    os9       I$Close   ; release the serial output path
                    inca                ; select standard error
                    os9       I$Close   ; release the serial error path
                    puls      a         ; recover the child process ID
                    cmpa      LoginPid,u ; did the login/BBS child finish first?
                    bne       ReapRemainingChild ; monitor already handled carrier loss
                    ldx       #60       ; allow one second for session shutdown
                    os9       F$Sleep   ; give descendants time to exit cleanly
                    lda       MonitorPid,u ; select the carrier monitor process
                    clrb                ; signal zero requests unconditional termination
                    os9       F$Send    ; stop Monitor after an orderly logout
ReapRemainingChild  os9       F$Wait    ; reap the other child or the -m no-child error
                    lbra      BeginCallCycle ; reopen the port for the next caller
ReportSessionError  os9       F$PErr    ; report a child-launch error on standard error
                    lbra      BeginCallCycle ; recycle the port instead of terminating
IgnoreSignalHandler fcb       $3B       ; raw 6809 RTI used by F$Icpt to ignore signals

                    emod                ; append the OS-9 module CRC placeholder and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end                 ; finish this assembly unit
