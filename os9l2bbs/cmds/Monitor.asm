**********************************************************************
* Monitor - OS-9 Level 2 BBS command
*
* syntax: Monitor [device]
* purpose: watch carrier detect and terminate the caller process tree after hangup.
* normally started by Tsmon beside BBS.login; an optional device replaces paths 0-2.
*
* edt/rev  YYYY/MM/DD  Modified by
* comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* annotated source and normalized comments.
*          2026/07/21  Codex
* refined command annotations and normalized formatting.
**********************************************************************

                    nam       Monitor
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; executable object module
atrv                set       ReEnt+rev ; reentrant module with revision encoded below
rev                 set       $01       ; original module revision

                    mod       eom,name,tylg,atrv,start,size ; declare the OS-9 module header and entry point

CallerRootPid       rmb       1         ; parent shared by Monitor and the caller session
CandidatePid        rmb       1         ; process ID currently being examined
MonitorPid          rmb       1         ; monitor's own process ID, excluded from cleanup
TargetCount         rmb       1         ; number of descendant process IDs collected
CarrierStatusAddress rmb      2         ; acia status register derived from the device descriptor
TargetWriteCursor   rmb       2         ; next slot in TargetPids
DeviceName          rmb       32        ; ss.DevNm result for standard path zero
TargetPids          rmb       255       ; descendant processes to terminate after hangup
ProcessDescriptorId rmb       1         ; p$ID from the F$GPrDsc result
ProcessDescriptorParent rmb   1         ; p$PID used to walk ancestry
ProcessDescriptorTail rmb     62        ; remaining Level 2 process descriptor bytes
ReservedWorkspace   rmb       649       ; retain the command's original data allocation
size                equ       .         ; total per-process workspace size

CarrierLostMask     equ       $20       ; 6551 status bit set when data carrier is absent

name                fcs       /Monitor/ ; os-9 module name
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
start               lda       ,x        ; inspect the optional device argument
                    cmpa      #C$CR     ; a blank command line keeps inherited standard paths
                    beq       ResolveDeviceDescriptor ; use path zero's current device

* when a device is supplied, replace standard input, output, and error with it.
                    clra                ; select standard input path zero
                    os9       I$Close   ; release the inherited input path
                    inca                ; select standard output path one
                    os9       I$Close   ; release the inherited output path
                    inca                ; select standard error path two
                    os9       I$Close   ; release the inherited error path
                    lda       #UPDAT.   ; open the supplied device for reading and writing
                    os9       I$Open    ; install it as the next free path, normally zero
                    lbcs      ExitWithStatus ; preserve device-open errors
                    os9       I$Dup     ; duplicate it into standard output
                    os9       I$Dup     ; duplicate it into standard error

* resolve path zero to its device descriptor, then derive the memory-mapped ACIA
* status register from the low word of the descriptor's three-byte M$Port field.
ResolveDeviceDescriptor clra            ; query standard input path zero
                    ldb       #SS.DevNm ; request its device-descriptor module name
                    leax      DeviceName,u ; receive the 32-byte high-bit-terminated name
                    os9       I$GetStt  ; identify the active serial device
                    lbcs      ExitWithStatus ; preserve descriptor-name failures
                    lda       #Devic+Objct ; require an object-code device descriptor
                    pshs      u         ; protect the workspace while F$Link returns module U
                    os9       F$Link    ; link the named descriptor module
                    lbcs      ExitWithStatus ; stop if the descriptor cannot be linked
                    tfr       u,y       ; retain the linked module base outside U
                    puls      u         ; recover the workspace pointer
                    ldx       M$Port+1,y ; fetch the port address's low sixteen bits
                    leax      1,x       ; advance from the ACIA data register to status
                    stx       CarrierStatusAddress,u ; retain the carrier-status address

WaitForCarrierLoss  ldx       #1        ; poll at one-tick intervals
                    os9       F$Sleep   ; yield the processor between status reads
                    ldx       CarrierStatusAddress,u ; select the ACIA status register
                    lda       ,x        ; sample its current modem-status bits
                    bita      #CarrierLostMask ; test data-carrier detect's inactive state
                    beq       WaitForCarrierLoss ; remain dormant while carrier is present

* Monitor and the login/session process are siblings under Tsmon. Save that shared
* parent, then scan process IDs downward and walk each candidate's parent chain.
                    os9       F$ID      ; obtain Monitor's own process ID in A
                    sta       MonitorPid,u ; exclude this process from the cleanup list
                    leax      >ProcessDescriptorId,u ; receive Monitor's process descriptor
                    os9       F$GPrDsc  ; obtain its direct parent process ID
                    lda       >ProcessDescriptorParent,u ; identify the Tsmon/root process
                    sta       CallerRootPid,u ; use it as the ancestry boundary
                    lda       #255      ; begin at the highest one-byte process ID
                    sta       CandidatePid,u ; initialize the downward scan
                    clr       TargetCount,u ; no descendants have been collected yet
                    leax      <TargetPids,u ; select the first output slot
                    stx       TargetWriteCursor,u ; retain the append position

ExamineCandidate    lda       CandidatePid,u ; begin with this original process ID
WalkParentChain     leax      >ProcessDescriptorId,u ; receive the candidate descriptor
                    os9       F$GPrDsc  ; inspect process A
                    bcs       AdvanceCandidate ; nonexistent IDs have no descendants
                    lda       >ProcessDescriptorParent,u ; move to this process's parent
                    cmpa      CallerRootPid,u ; did the ancestry reach Tsmon?
                    beq       RecordDescendant ; collect the original candidate
                    cmpa      #0        ; process zero ends an unrelated ancestry chain
                    beq       AdvanceCandidate ; reject this candidate
                    bra       WalkParentChain ; continue upward through its ancestors

ExitSuccess         clrb                ; finish normally after all targets are signaled
ExitWithStatus      os9       F$Exit    ; return status B to the invoking process

RecordDescendant    lda       CandidatePid,u ; recover the original descendant ID
                    cmpa      MonitorPid,u ; never terminate the monitor itself
                    beq       AdvanceCandidate ; omit it from the target list
                    ldx       TargetWriteCursor,u ; select the next target slot
                    sta       ,x+       ; append the descendant process ID
                    stx       TargetWriteCursor,u ; retain the following free slot
                    inc       TargetCount,u ; account for the collected target
AdvanceCandidate    dec       CandidatePid,u ; continue with the next lower process ID
                    cmpa      #3        ; stop when ancestry traversal leaves the historical bound in A
                    beq       TerminateTargets ; stop the process-table scan
                    bra       ExamineCandidate ; inspect the next candidate ancestry

* signal zero is OS-9's unconditional process termination request. Retry transient
* failures one tick at a time so every collected descendant is handled.
TerminateTargets    leax      <TargetPids,u ; restart at the collected process IDs
NextTarget          tst       TargetCount,u ; are any descendants still pending?
                    lbeq      ExitSuccess ; leave once the list is exhausted
                    dec       TargetCount,u ; consume the target about to be signaled
                    lda       ,x+       ; select its process ID
                    clrb                ; signal zero requests unconditional termination
RetryTermination    os9       F$Send    ; terminate process A
                    bcc       NextTarget ; continue after OS-9 accepts the signal
                    pshs      x,a       ; preserve the list cursor and process ID
                    ldx       #1        ; wait one scheduler tick before retrying
                    os9       F$Sleep   ; allow the target or kernel state to advance
                    puls      x,a       ; recover the target and list cursor
                    bra       RetryTermination ; repeat until the signal is accepted

                    emod                ; append the OS-9 module CRC placeholder and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end                 ; finish this assembly unit
