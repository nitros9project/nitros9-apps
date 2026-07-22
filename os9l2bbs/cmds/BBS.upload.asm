**********************************************************************
* BBS.upload - OS-9 Level 2 BBS command
*
* Syntax: BBS.upload [directory]
* Purpose: Select an upload protocol, receive a file, and register it for validation.
* Dispatches Uload* and updates BBS.userstats after success.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* Annotated source and normalized comments.
*          2026/07/21  Codex
* Refined command annotations and normalized formatting.
*          2026/07/22  Codex
* Decoded protocol dispatch, DLD registration, and upload accounting.
**********************************************************************

                    nam       BBS.upload
                    ttl       program module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Prgrm+Objct ; define a program-object module
atrv                set       ReEnt+rev ; mark the module reentrant at revision one
rev                 set       $01       ; retain the original module revision

                    mod       eom,name,tylg,atrv,start,size ; emit the OS-9 module header

ProtocolChoice      rmb       1
DldListPathNum      rmb       2         ; path number occupies the first byte
StatsPathNum        rmb       13        ; first byte is path number; remainder separates records
CallerUserId        rmb       2
* one 32-byte BBS.userstats record
StatsUserId         rmb       2
StatsLoginCount     rmb       2
StatsLastLoginTime  rmb       6
StatsMessagesLeft   rmb       2
StatsMessagesRead   rmb       2
StatsDownloads      rmb       2
StatsUploads        rmb       16        ; first word is uploads; remainder completes the record
* one 96-byte DLD.lst record being prepared for this upload
UploadFilename      rmb       27
UploadSizeHigh      rmb       2
UploadSizeLow       rmb       2
UploadValidationFlag rmb       1
UploadDescription   rmb       64
* overlapping 96-byte scan buffer; byte 31 is the validation flag
ScanRecord          rmb       31
ScanValidationFlag  rmb       1
ScanRecordTail      rmb       8499
size                equ       .         ; reserve the complete per-process workspace

name                fcs       /BBS.upload/ ; publish the command name in the module header
                    fcc       "Copyright (C) 1988By Keith AlphonsoLicenced to Alpha Software TechnologiesAll rights reserved"
* Preserve the original high-bit bytes adjoining the embedded copyright notice.
                    fcb       $EC
                    fcb       $E6
                    fcb       $EA
                    fcb       $F5
                    fcb       $E9
                    fcb       $A0
                    fcb       $E2
                    fcb       $ED
                    fcb       $F1
                    fcb       $E9
                    fcb       $F0
                    fcb       $EF
                    fcb       $F4
                    fcb       $F0
XmodemProgram       fcc       "Uloadx"
                    fcb       $0D       ; terminate the child module name
XmodemCrcProgram    fcc       "Uloadxc"
                    fcb       $0D       ; terminate the child module name
YmodemProgram       fcc       "Uloady"
                    fcb       $0D       ; terminate the child module name
UnusedYmodemBatchProgram fcc       "Uloadyb" ; retained name has no menu dispatch path
                    fcb       $0D
AsciiProgram        fcc       "Uloada"
                    fcb       $0D       ; terminate the child module name
ProtocolTitle       fcc       "Enter your upload protocol"
                    fcb       $0D
ProtocolMenu        fcb       $0A
                    fcb       $0D
                    fcc       "[A] Ascii"
                    fcb       $0A
                    fcb       $0D
                    fcc       "[X] xmodem"
                    fcb       $0A
                    fcb       $0D
                    fcc       "[C] xmodem (CRC)"
                    fcb       $0A
                    fcb       $0D
                    fcc       "[Y] ymodem"
                    fcb       $0A
                    fcb       $0D
                    fcc       "[Q] quit"
                    fcb       $0A
                    fcb       $0D
                    fcc       "Protocol?"
FilenamePrompt      fcc       "Enter filename to upload:"
DldListName         fcc       "DLD.lst"
                    fcb       $0D
PromptReturn        fcb       $0D
                    fcb       $0A
DescriptionPrompt   fcc       "Enter a one-line description of this file"
                    fcb       $0D
DescriptionMarker   fcb       $3E
                    fcb       $0D
UserStatsPath       fcc       "/dd/bbs/BBS.userstats"
                    fcb       $0D
* The optional argument selects the directory that will receive the upload.
* After the child succeeds, a pending DLD record and user statistic are updated.
start               lda       ,x        ; inspect the optional upload-directory argument
                    cmpa      #13       ; recognize a bare invocation
                    beq       OpenDldList ; keep the current execution directory when absent
                    lda       #1        ; select execution-directory semantics
                    os9       I$ChgDir  ; enter the directory that will receive the upload
                    lbcs      ExitWithStatus ; preserve a directory-change failure
OpenDldList         leax      >DldListName,pc ; select the directory's download catalog
                    lda       #3        ; request read/write catalog access
                    os9       I$Open    ; open an existing DLD.lst
                    bcs       CreateDldList ; create the catalog only when it is absent
                    sta       DldListPathNum,u ; retain its path number for scans and writes
                    bra       PromptProtocol ; proceed to transfer selection
CreateDldList       cmpb      #216      ; distinguish path-not-found from other open errors
                    lbne      ExitWithStatus ; preserve an unexpected open failure
                    ldb       #27       ; use the package's writable data-file attributes
                    os9       I$Create  ; create the missing DLD.lst
                    lbcs      ExitWithStatus ; preserve a creation failure
                    sta       DldListPathNum,u ; retain the new catalog path number
PromptProtocol      leax      >ProtocolTitle,pc ; point at the protocol-selection heading
                    ldy       #200      ; allow I$WritLn to find the terminator
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; introduce the upload protocol menu
                    leax      >ProtocolMenu,pc ; prepare the four protocol choices
                    ldy       #74       ; write the exact menu block
                    lda       #1        ; direct the menu to the terminal
                    os9       I$Write   ; leave the cursor after the protocol prompt
                    leax      ProtocolChoice,u ; receive one menu keystroke
                    ldy       #1        ; accept exactly one byte
                    lda       #1        ; read from terminal path one, as in the original
                    os9       I$Read    ; wait for a protocol choice
                    leax      >PromptReturn,pc ; select the CR used to echo the choice
                    ldy       #1        ; output only the CR, not its adjacent LF
                    lda       #1        ; direct it to the terminal
                    os9       I$WritLn  ; advance the terminal after the keystroke
                    lda       ProtocolChoice,u ; recover the raw selection
                    anda      #223      ; make the protocol choice case-insensitive
                    cmpa      #65       ; test for ASCII transfer
                    lbeq      SelectAscii ; launch the plain-text receiver
                    cmpa      #88       ; test for checksum XMODEM
                    lbeq      SelectXmodem ; launch the checksum XMODEM receiver
                    cmpa      #67       ; test for CRC XMODEM
                    lbeq      SelectXmodemCrc ; launch the CRC receiver
                    cmpa      #89       ; test for YMODEM
                    lbeq      SelectYmodem ; launch the mixed-size receiver
                    cmpa      #81       ; test for an explicit quit
                    lbeq      ExitSuccessfully ; leave without starting a child
                    bra       OpenDldList ; preserve the original catalog reopen on invalid input
SelectAscii         leax      >FilenamePrompt,pc ; point at the upload filename prompt
                    ldy       #25       ; supply the prompt byte count
                    lda       #1        ; select standard output
                    os9       I$Write   ; emit the selected prompt or record
                    leax      <UploadFilename,u ; receive or reference the 27-byte filename field
                    ldy       #27       ; limit input to the filename field
                    clra                ; read the filename from standard input
                    os9       I$ReadLn  ; collect the caller's text response
                    bcs       SelectAscii ; retry the ASCII filename prompt after an input error
                    cmpy      #1        ; distinguish an empty CR-only filename
                    lbls      ExitSuccessfully ; treat an empty filename as cancellation
                    lda       #17       ; request an executable program module
                    ldb       #3        ; grant the child three additional data pages
                    leax      >AsciiProgram,pc ; select the plain-text upload engine
                    pshs      u         ; preserve the workspace pointer across the child lifecycle
                    leau      <UploadFilename,u ; pass the filename field as the child command line
                    os9       F$Fork    ; start the selected upload engine
                    lbcs      ExitWithStatus ; propagate a fork failure
                    clrb                ; clear stale child status before waiting
                    os9       F$Wait    ; collect the upload engine's completion status
                    tstb                ; require a successful child exit
                    lbne      ExitWithStatus ; propagate the receiver's failure status
                    puls      u         ; recover the module workspace pointer
                    lbra      FindExistingDldRecord ; register the successfully received file
SelectXmodem        leax      >FilenamePrompt,pc ; point at the upload filename prompt
                    ldy       #25       ; supply the prompt byte count
                    lda       #1        ; select standard output
                    os9       I$Write   ; emit the selected prompt or record
                    leax      <UploadFilename,u ; receive or reference the 27-byte filename field
                    ldy       #27       ; limit input to the filename field
                    clra                ; read the filename from standard input
                    os9       I$ReadLn  ; collect the caller's text response
                    bcs       SelectXmodem ; retry the XMODEM filename prompt after an input error
                    cmpy      #1        ; distinguish an empty CR-only filename
                    lbls      ExitSuccessfully ; treat an empty filename as cancellation
                    lda       #17       ; request an executable program module
                    ldb       #3        ; grant the child three additional data pages
                    leax      >XmodemProgram,pc ; select checksum XMODEM reception
                    pshs      u         ; preserve the workspace pointer across the child lifecycle
                    leau      <UploadFilename,u ; pass the filename field as the child command line
                    os9       F$Fork    ; start the selected upload engine
                    lbcs      ExitWithStatus ; preserve the OS-9 or child failure status
                    clrb                ; clear stale child status before waiting
                    os9       F$Wait    ; collect the upload engine's completion status
                    tstb                ; require a successful child exit
                    lbne      ExitWithStatus ; propagate a child or service failure
                    puls      u         ; recover the module workspace pointer
                    lbra      FindExistingDldRecord ; register the successfully received file
SelectXmodemCrc     leax      >FilenamePrompt,pc ; point at the upload filename prompt
                    ldy       #25       ; supply the prompt byte count
                    lda       #1        ; select standard output
                    os9       I$Write   ; emit the selected prompt or record
                    leax      <UploadFilename,u ; receive or reference the 27-byte filename field
                    ldy       #27       ; limit input to the filename field
                    clra                ; read the filename from standard input
                    os9       I$ReadLn  ; collect the caller's text response
                    bcs       SelectXmodemCrc ; retry the CRC filename prompt after an input error
                    cmpy      #1        ; distinguish an empty CR-only filename
                    lbls      ExitSuccessfully ; treat an empty filename as cancellation
                    lda       #17       ; request an executable program module
                    ldb       #3        ; grant the child three additional data pages
                    leax      >XmodemCrcProgram,pc ; select CRC-16 XMODEM reception
                    pshs      u         ; preserve the workspace pointer across fork and wait
                    leau      <UploadFilename,u ; pass the filename field as the child command line
                    os9       F$Fork    ; start the selected protocol engine
                    lbcs      ExitWithStatus ; propagate a fork failure without touching statistics
                    clrb                ; clear stale status before waiting
                    os9       F$Wait    ; collect the upload engine's termination status
                    lbcs      ExitWithStatus ; propagate a wait failure
                    tstb                ; require a successful child exit
                    lbne      ExitWithStatus ; return the receiver's failure status
                    puls      u         ; recover the module workspace pointer
                    lbra      FindExistingDldRecord ; register the successfully received file
SelectYmodem        leax      >FilenamePrompt,pc ; point at the upload filename prompt
                    ldy       #25       ; supply the prompt byte count
                    lda       #1        ; select standard output
                    os9       I$Write   ; emit the selected prompt or record
                    leax      <UploadFilename,u ; receive or reference the 27-byte filename field
                    ldy       #27       ; limit input to the filename field
                    clra                ; read the filename from standard input
                    os9       I$ReadLn  ; collect the caller's text response
                    bcs       SelectYmodem ; retry the 1K filename prompt after an input error
                    cmpy      #1        ; distinguish an empty CR-only filename
                    lbls      ExitSuccessfully ; treat an empty filename as cancellation
                    lda       #17       ; request an executable program module
                    ldb       #3        ; grant the child three additional data pages
                    leax      >YmodemProgram,pc ; select mixed-size SOH/STX reception
                    pshs      u         ; preserve the workspace pointer across the child lifecycle
                    leau      <UploadFilename,u ; pass the filename field as the child command line
                    os9       F$Fork    ; start the selected upload engine
                    lbcs      ExitWithStatus ; preserve the OS-9 or child failure status
                    clrb                ; clear stale child status before waiting
                    os9       F$Wait    ; collect the upload engine's completion status
                    lbcs      ExitWithStatus ; preserve the OS-9 or child failure status
                    tstb                ; require a successful child exit
                    lbne      ExitWithStatus ; propagate a child or service failure
                    puls      u         ; recover the module workspace pointer
                    lbra      FindExistingDldRecord ; register the successfully received file
* Retain the original unreachable machine-code fragment following YMODEM dispatch.
                    fcb       $86
                    fcb       $11
                    fcb       $10
                    fcb       $8E
                    fcb       $00
                    fcb       $01
                    fcb       $C6
                    fcb       $03
                    fcb       $30
                    fcb       $8D
                    fcb       $FD
                    fcc       "~4@3"
                    fcb       $C9
                    fcb       $01
                    fcb       $2D
                    fcb       $10
                    fcb       $3F
                    fcb       $03
                    fcb       $10
                    fcb       $25
                    fcb       $01
                    fcb       $8B
                    fcb       $5F
                    fcb       $10
                    fcb       $3F
                    fcb       $04
                    fcb       $10
                    fcb       $25
                    fcb       $01
                    fcb       $83
                    fcb       $5D
                    fcb       $10
                    fcb       $26
                    fcb       $01
                    fcc       "~5@"
* Reject duplicate filenames before reusing or appending a catalog slot.
FindExistingDldRecord lda       DldListPathNum,u ; select the open download catalog
                    leax      >ScanRecord,u ; receive one catalog record in the scan buffer
                    ldy       #96       ; preserve the fixed DLD.lst record size
                    os9       I$Read    ; fetch the next registered download
                    bcs       DldScanEnded ; distinguish end-of-file from a read error
                    leay      <UploadFilename,u ; compare against the newly received filename
CompareFilenameLoop lda       ,x+       ; fetch the next catalog filename byte
                    cmpa      ,y+       ; compare it with the corresponding upload byte
                    bne       FindExistingDldRecord ; advance when the names differ
                    cmpa      #13       ; recognize the common filename terminator
                    beq       DuplicateFound ; refuse an already registered filename
                    bra       CompareFilenameLoop ; continue across the matching prefix
DuplicateFound      ldb       #218      ; report the package's duplicate-name error
                    lbra      ExitWithStatus ; leave the existing record untouched
DldScanEnded        cmpb      #211      ; accept only normal end-of-file
                    lbne      ExitWithStatus ; preserve an actual catalog read error
                    lda       DldListPathNum,u ; select DLD.lst for rewinding
                    ldb       #5        ; request an absolute seek
                    ldx       #0        ; clear the high offset word
                    pshs      u         ; preserve workspace access during the seek
                    ldu       #0        ; clear the low offset word
                    os9       I$Seek    ; return to the beginning of DLD.lst
                    puls      u         ; recover the module workspace pointer
* Reuse the first record whose flag is one; otherwise append at end-of-file.
FindUnvalidatedRecord lda       DldListPathNum,u ; select the rewound catalog
                    leax      >ScanRecord,u ; receive the next 96-byte record
                    ldy       #96       ; preserve the catalog stride
                    os9       I$Read    ; scan for a reusable validation slot
                    bcs       ValidationScanEnded ; append only after normal end-of-file
                    lda       >ScanValidationFlag,u ; inspect the record's validation state
                    cmpa      #1        ; identify the package's reusable-slot marker
                    bne       FindUnvalidatedRecord ; skip records with other states
                    lda       DldListPathNum,u ; select the catalog stream
                    ldb       #5        ; request its current 32-bit position
stk_dld_workspace   equ       0         ; saved workspace u at the current stack top
                    pshs      u         ; preserve workspace u while GetStat returns offset in u
                    os9       I$GetStt  ; obtain the position after the reusable record
                    tfr       u,d       ; move the low offset word for subtraction
                    subd      #96       ; back up by one complete catalog record
                    bge       HaveDldWriteOffset ; retain the high word when no borrow occurs
                    leax      -$01,x    ; propagate the low-word borrow
HaveDldWriteOffset  ldy       stk_dld_workspace,s ; recover workspace access without popping
                    tfr       d,u       ; install the calculated low seek word
                    lda       $01,y     ; recover the path number from workspace
                    os9       I$Seek    ; position path A at the 32-bit offset in X:U
                    puls      u         ; recover the module workspace pointer
                    bra       CollectDescription ; overwrite the reusable record
ValidationScanEnded cmpb      #211      ; recognize normal catalog end-of-file
                    lbne      ExitWithStatus ; preserve an actual scan failure
CollectDescription  ldx       #0        ; initialize the high file-size word
                    ldy       #0        ; initialize the low file-size word
                    stx       <UploadSizeHigh,u ; temporarily clear the catalog size field
                    sty       <UploadSizeLow,u ; complete the temporary zero size
                    leax      >DescriptionPrompt,pc ; ask for catalog metadata
                    ldy       #200      ; allow I$WritLn to find the terminator
                    lda       #1        ; select standard output
                    os9       I$WritLn  ; write a CR-terminated line from X to path A
                    leax      >DescriptionMarker,pc ; place a prompt marker on the input line
                    ldy       #1        ; emit only the marker byte
                    os9       I$Write   ; emit the selected prompt or record
                    leax      <UploadDescription,u ; receive the one-line catalog description
                    ldy       #64       ; limit input to the description field
                    clra                ; read from standard input
                    os9       I$ReadLn  ; collect the upload description
                    clr       <UploadValidationFlag,u ; mark the new record pending validation
                    leax      <UploadFilename,u ; select the complete prepared DLD record
                    ldy       #-1       ; use the original unknown-size sentinel
                    sty       <UploadSizeHigh,u ; mark the high size word unknown
                    sty       <UploadSizeLow,u ; mark the low size word unknown
                    ldy       #96       ; write exactly one DLD.lst record
                    lda       DldListPathNum,u ; select the catalog stream
                    os9       I$Write   ; replace the slot or append the new record
                    leax      >UserStatsPath,pc ; select the shared per-user statistics file
                    lda       #3        ; request read/write access
                    os9       I$Open    ; open the existing statistics database
                    bcc       StatsFileReady ; scan the existing statistics database
                    ldb       #27       ; use the package's writable data-file attributes
                    os9       I$Create  ; create a missing statistics database
                    lbcs      ExitWithStatus ; preserve a create failure
StatsFileReady      sta       StatsPathNum,u ; retain the statistics path number
                    os9       F$ID      ; obtain the caller's OS-9 user ID
                    sty       <CallerUserId,u ; retain the caller's record key
* BBS.userstats uses 32-byte records keyed by their leading user ID.
FindStatsRecord     leax      <StatsUserId,u ; receive one complete statistics record
                    ldy       #32       ; preserve the fixed database stride
                    lda       StatsPathNum,u ; select the statistics stream
                    os9       I$Read    ; fetch the next user's counters
                    bcs       StatsScanEnded ; distinguish an absent user from an I/O error
                    ldd       <StatsUserId,u ; inspect the record's account key
                    cmpd      <CallerUserId,u ; compare it with the uploader's user ID
                    bne       FindStatsRecord ; continue until the caller's record is found
                    bra       IncrementUploadCount ; update the existing upload counter
StatsScanEnded      cmpb      #211      ; recognize OS-9 end-of-file as an absent record
                    lbne      ExitWithStatus ; preserve an actual statistics read error
                    lbra      CreateStatsRecord ; append the package's historical initial record
IncrementUploadCount ldd       <StatsUploads,u ; fetch the caller's cumulative upload count
                    addd      #1        ; account for the successful child transfer
                    std       <StatsUploads,u ; retain the incremented count
                    lda       StatsPathNum,u ; select the statistics stream
                    ldb       #5        ; request its current 32-bit file position
stk_stats_workspace equ       0         ; saved workspace u at the current stack top
                    pshs      u         ; save workspace u before GetStat returns the low offset in u
                    os9       I$GetStt  ; obtain the position immediately after the matched record
                    tfr       u,d       ; move the low offset word where subtraction is convenient
                    subd      #32       ; back up by one fixed statistics record
                    bge       HaveStatsWriteOffset ; retain the high word when no borrow occurred
                    leax      -$01,x    ; propagate the low-word borrow into the high word
HaveStatsWriteOffset ldu       stk_stats_workspace,s ; recover workspace access without popping
                    tfr       d,y       ; preserve the calculated low offset word
                    lda       StatsPathNum,u ; recover the path number through workspace u
                    tfr       y,u       ; complete the target x:u seek position
                    os9       I$Seek    ; return to the beginning of the matched record
                    lbcs      ExitWithStatus ; preserve a seek failure
                    puls      u         ; restore the workspace pointer and balance the stack
                    leax      <StatsUserId,u ; select the modified 32-byte record
                    ldy       #32       ; rewrite exactly one database record
                    lda       StatsPathNum,u ; select BBS.userstats
                    os9       I$Write   ; commit the incremented upload count
                    os9       I$Close   ; release the statistics file
                    lbra      ExitSuccessfully ; report the completed transfer and accounting
CreateStatsRecord   leax      <StatsUserId,u ; prepare a new record at its user-ID field
                    ldd       #1        ; select the historical nonzero initializer
                    std       <StatsLoginCount,u ; seed the login count
                    std       <StatsMessagesRead,u ; seed messages-read, as in the original binary
                    ldd       #0        ; clear the remaining initialized counters
                    std       <StatsMessagesLeft,u ; begin with no messages posted
                    std       <StatsUploads,u ; begin with no uploads
                    std       <StatsDownloads,u ; preserve the original zero download count anomaly
                    ldd       <CallerUserId,u ; fetch the successful uploader's account ID
                    std       <StatsUserId,u ; key the appended record to that caller
                    leax      <StatsLastLoginTime,u ; select the six-byte timestamp field
                    os9       F$Time    ; stamp the newly created record with the current time
                    lbcs      ExitWithStatus ; preserve a clock-service error
                    leax      <StatsUserId,u ; select the completed new record
                    ldy       #32       ; append one fixed-size record
                    lda       StatsPathNum,u ; select the statistics database
                    os9       I$Write   ; append the caller's initial counters
                    os9       I$Close   ; release the statistics file
                    lbcs      ExitWithStatus ; preserve a close failure reported by the original flow
ExitSuccessfully    clrb                ; report a successful quit or completed upload
ExitWithStatus      os9       F$Exit    ; return success or the preserved OS-9 status

                    emod                ; emit the OS-9 module CRC and trailer
eom                 equ       *         ; mark the module end for the size expression
                    end                 ; end the assembly source
