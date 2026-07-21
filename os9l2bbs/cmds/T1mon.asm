**********************************************************************
* T1mon - OS-9 Level 2 BBS command
*
* syntax: T1mon <port>
* purpose: supervise 300-baud calls on the CoCo 3 internal serial port.
* initializes the modem, waits for CR, runs BBS.login, and recycles the port.
*
* edt/rev  YYYY/MM/DD  Modified by
* comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* annotated source and normalized comments.
*          2026/07/21  Codex
* refined command annotations and normalized formatting.
**********************************************************************

                    nam       T1mon
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; executable object module
atrv                set       ReEnt+rev ; reentrant module with revision encoded below
rev                 set       $01       ; original module revision

                    mod       eom,name,tylg,atrv,start,size ; declare the OS-9 module header and entry point

InputByte           rmb       1         ; byte read while waiting for the caller's CR
LoginPid            rmb       1         ; process ID returned by the BBS.login fork
LoginPidReserved    rmb       1         ; unused high byte from the original word allocation
ReservedModeFlag    rmb       1         ; initialized to $FF but otherwise unused
ReservedPollState   rmb       1         ; cleared before input but otherwise unused
BaudCode            rmb       1         ; fixed SCF PD.BAU value applied to the port
PortArgument        rmb       2         ; command-line pointer to the serial device name
OptionsBuffer       rmb       32        ; scf path options returned by SS.Opt
ModemSetupBuffer    rmb       600       ; one line read from Modem.set
size                equ       .         ; total per-process workspace size

name                fcs       /T1mon/   ; os-9 module name
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
UnusedMonitorName   fcc       "Monitor" ; preserved string; t1mon never forks it
                    fcb       C$CR      ; terminate the unused module name
EmptyParameters     fcb       C$CR      ; empty child parameter line
UnusedStatusPrefix  fcb       C$LF      ; preserved prefix from the original status text
                    fcc       "Monitoring " ; preserved but not referenced by this module
BaudDescriptions    fcc       "110  Baud 300  Baud 600  Baud 1200 Baud 2400 Baud " ; ten-byte text indexed by PD.BAU
SerialFormatText    fcc       "8 bits, no parity" ; fixed caller framing
                    fcb       C$CR      ; terminate the status line
LogColumnHeadings   fcc       "User name            Date                time" ; session log headings
                    fcb       C$CR      ; terminate the heading line
LogDivider          fcc       "------------------------------------------------------------------------" ; separate headings from log entries
                    fcb       C$CR      ; terminate the divider line
LogDeviceName       fcc       "/p"      ; system path receiving session log headings
                    fcb       C$CR      ; terminate the device name
ModemSetupName      fcc       "Modem.set" ; modem initialization commands
                    fcb       C$CR      ; terminate the file name

OptionBias          equ       $20       ; bias paired with the original negative-X addressing
BaudTextWidth       equ       10        ; bytes occupied by each baud description

start               clr       ReservedModeFlag,u ; preserve the original redundant initialization
                    stx       PortArgument,u ; retain the serial device argument
                    lda       #$FF      ; set the historical mode byte
                    sta       ReservedModeFlag,u ; preserve it despite no later read
                    leax      >IgnoreSignalHandler,pc ; select the do-nothing signal handler
                    os9       F$Icpt    ; prevent ordinary signals from ending the supervisor

* initialize the same session-log header used by Tsmon before taking ownership
* of the serial port as standard input, output, and error.
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
                    os9       I$WritLn  ; write one heading line
                    leax      >LogDivider,pc ; select the horizontal divider
                    ldy       #80       ; bound the divider write beyond its CR
                    os9       I$WritLn  ; finish the log header
                    os9       I$Close   ; release the log path

BeginCallCycle      ldx       PortArgument,u ; select the configured serial device
                    lda       #UPDAT.   ; request bidirectional access
                    os9       I$Open    ; install the port as standard input path zero
                    lbcs      ReportSessionError ; retry after a failed device open
                    os9       I$Dup     ; duplicate it as standard output path one
                    os9       I$Dup     ; duplicate it as standard error path two

* unlike Tsmon's paced writes, T1mon sends each Modem.set command as a complete
* CR-terminated line because this low-speed path has no baud-detection cycle.
                    leax      >ModemSetupName,pc ; select the optional initialization file
                    lda       #READ.    ; open it for input
                    os9       I$Open    ; obtain its path number in A
                    bcs       ConfigurePort ; continue when the setup file is absent
ReadSetupLine       leax      <ModemSetupBuffer,u ; receive one modem command
                    ldy       #200      ; cap each setup line at 200 bytes
                    os9       I$ReadLn  ; read through its terminating CR
                    bcs       CloseSetupFile ; eof or an error ends initialization
                    pshs      a         ; preserve the setup-file path
                    lda       #1        ; target standard output to the modem
                    ldy       #200      ; allow I$WritLn to find the command's CR
                    os9       I$WritLn  ; transmit the complete setup command
                    puls      a         ; recover the setup-file path
                    bra       ReadSetupLine ; fetch another command
CloseSetupFile      os9       I$Close   ; release Modem.set after EOF

* force the internal serial port to 300 baud with echo disabled, then block on
* one-byte reads until a carriage return establishes a caller session.
ConfigurePort       leax      OptionsBuffer,u ; receive standard input's SCF options
                    clra                ; select standard input
                    clrb                ; request SS.Opt
                    os9       I$GetStt  ; snapshot the current path options
                    leax      -OptionBias,x ; retain the original biased addressing base
                    lda       #B300     ; the internal port is limited to 300 baud here
                    sta       BaudCode,u ; record the fixed rate
                    sta       <(PD.BAU-PD.OPT)+OptionBias,x ; update the option block's baud code
                    clr       <(PD.EKO-PD.OPT)+OptionBias,x ; suppress echo while awaiting CR
                    leax      OptionsBuffer,u ; restore the option block's true base
                    clra                ; select standard input
                    clrb                ; request SS.Opt
                    os9       I$SetStt  ; apply baud and echo changes
                    clr       ReservedPollState,u ; preserve the original unused clear
WaitForCallerCr     leax      InputByte,u ; receive one serial byte
                    clr       ,x        ; remove stale input first
                    ldy       #1        ; request exactly one byte
                    clra                ; read standard input
                    os9       I$Read    ; block until the internal port supplies data
                    bcc       CheckCallerByte ; inspect a successful read
                    ldx       #10       ; pause after a serial read error
                    os9       F$Sleep   ; let the device recover for ten ticks
                    bra       WaitForCallerCr ; retry indefinitely
CheckCallerByte     lda       InputByte,u ; inspect the decoded serial byte
                    cmpa      #C$CR     ; only carriage return starts a session
                    beq       StartCallerSession ; accept the waiting caller
                    bra       WaitForCallerCr ; discard all other input

* restore echo, report the fixed line format, and run BBS.login alone. The
* embedded Monitor name and the second F$Wait are unused remnants of Tsmon's
* two-child supervision pattern and are preserved exactly.
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
                    os9       I$Write   ; report the 300-baud connection
                    leax      >SerialFormatText,pc ; select the framing description
                    ldy       #200      ; allow I$WritLn to locate its CR
                    os9       I$WritLn  ; complete the connection report
                    leax      >LoginCommand,pc ; select the BBS-specific login module
                    ldy       #1        ; pass one CR as an empty parameter line
                    pshs      u         ; preserve T1mon's workspace across the fork
                    leau      >EmptyParameters,pc ; supply the child parameter line
                    lda       #Prgrm+Objct ; require a 6809 executable module
                    ldb       #3        ; grant the child the original three-page minimum
                    os9       F$Fork    ; begin caller authentication and the BBS session
                    lbcs      ReportSessionError ; preserve the original fork-error path
                    ldu       ,s        ; access workspace without popping its saved pointer
                    sta       LoginPid,u ; retain the child PID despite no later use
                    puls      u         ; recover T1mon's workspace pointer
                    os9       F$Wait    ; wait for the login/BBS session to finish
                    lbcs      ReportSessionError ; report an abnormal wait failure
                    clra                ; select standard input
                    os9       I$Close   ; release the serial input path
                    inca                ; select standard output
                    os9       I$Close   ; release the serial output path
                    inca                ; select standard error
                    os9       I$Close   ; release the serial error path
                    os9       F$Wait    ; preserve the historical no-second-child wait
                    lbra      BeginCallCycle ; reopen the port for the next caller
ReportSessionError  os9       F$PErr    ; report the current OS-9 error
                    lbra      BeginCallCycle ; recycle the port instead of terminating
IgnoreSignalHandler rti                 ; ignore intercepted signals and resume execution

                    emod                ; append the OS-9 module CRC placeholder and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end                 ; finish this assembly unit
