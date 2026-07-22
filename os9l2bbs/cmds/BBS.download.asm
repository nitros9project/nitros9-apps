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
*          2026/07/22  Codex
* Decoded protocol dispatch and download-statistics accounting.
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

ProtocolChoice      rmb       1
StatsPathNum        rmb       1
CallerUserId        rmb       2
* one 32-byte BBS.userstats record
StatsUserId         rmb       2
StatsLoginCount     rmb       2
StatsLastLoginTime  rmb       6
StatsMessagesLeft   rmb       2
StatsMessagesRead   rmb       2
StatsDownloads      rmb       2
StatsUploads        rmb       2
StatsRecordTail     rmb       414       ; first 10 bytes complete the statistics record
size                equ       .         ; define the assembly-time value for size

name                fcs       /BBS.download/ ; publish the command name in the module header
UnusedProtocolTitle fcc       "Enter your download protocol" ; retained title not included in the menu write
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
                    fcc       "Protocol?" ; menu intentionally ends without CR for inline input
XmodemProgram       fcc       "dloadx"
                    fcb       $0D       ; terminate the child module name
XmodemCrcProgram    fcc       "dloadxc"
                    fcb       $0D       ; terminate the child module name
YmodemProgram       fcc       "dloady"
                    fcb       $0D       ; terminate the child module name
UnusedYmodemBatchProgram fcc       "dloadyb" ; retained protocol name without a dispatch choice
                    fcb       $0D       ; terminate the retained module name
AsciiProgram        fcc       "Dloada"
                    fcb       $0D       ; terminate the child module name
ChildParameterReturn fcb       $0D       ; one-byte empty parameter passed to the child
                    fcb       $0A       ; adjacent byte is retained but excluded from the fork
UserStatsPath       fcc       "/dd/bbs/BBS.userstats"
                    fcb       $0D       ; terminate the absolute statistics pathname

* an optional path becomes the execution directory used by the selected
* downloader.  The protocol menu dispatches one of four independent modules.
start               lda       ,x        ; inspect the optional download-directory argument
                    cmpa      #13       ; recognize a bare invocation
                    beq       PromptProtocol ; keep the current execution directory when absent
                    lda       #1        ; select execution-directory semantics
                    os9       I$ChgDir  ; enter the directory containing downloadable files
                    lbcs      ExitWithStatus ; preserve a directory-change failure
PromptProtocol      leax      >ProtocolMenu,pc ; prepare the four protocol choices
                    ldy       #74       ; write the exact menu block
                    lda       #1        ; direct the menu to the terminal
                    os9       I$Write   ; leave the cursor after the protocol prompt
                    leax      ProtocolChoice,u ; receive one menu keystroke
                    ldy       #1        ; accept exactly one byte
                    clra                ; select standard input
                    os9       I$Read    ; wait for a protocol choice
                    leax      >ChildParameterReturn,pc ; select the CR used for terminal echo
                    ldy       #1        ; output only the CR, not its adjacent LF
                    lda       #1        ; direct it to the terminal
                    os9       I$Write   ; move to the next terminal line
                    lda       ProtocolChoice,u ; recover the raw selection
                    anda      #223      ; make the menu case-insensitive
                    cmpa      #65       ; test for ASCII transfer
                    beq       SelectAscii ; dispatch Dloada
                    cmpa      #88       ; test for checksum XMODEM
                    beq       SelectXmodem ; dispatch dloadx
                    cmpa      #89       ; test for YMODEM
                    beq       SelectYmodem ; dispatch dloady
                    cmpa      #67       ; test for CRC XMODEM
                    beq       SelectXmodemCrc ; dispatch dloadxc
                    cmpa      #81       ; test for an explicit quit
                    lbeq      ExitSuccessfully ; leave without starting a child
                    bra       PromptProtocol ; reject any unrecognized keystroke
SelectXmodem        leax      >XmodemProgram,pc ; select the checksum XMODEM engine
                    bra       ForkSelectedProtocol ; use the common child lifecycle
SelectYmodem        leax      >YmodemProgram,pc ; select the YMODEM engine
                    bra       ForkSelectedProtocol ; use the common child lifecycle
SelectXmodemCrc     leax      >XmodemCrcProgram,pc ; select the CRC XMODEM engine
                    bra       ForkSelectedProtocol ; use the common child lifecycle
SelectAscii         leax      >AsciiProgram,pc ; select the plain-text engine
                    bra       ForkSelectedProtocol ; use the common child lifecycle

* fork the downloader with a one-byte empty command line.  Statistics are
* updated only after the child exits successfully.
ForkSelectedProtocol ldy       #1        ; pass a one-byte parameter area to the child
                    lda       #17       ; request an executable program module
                    ldb       #3        ; grant the child three additional data pages
                    pshs      u         ; preserve the workspace pointer across fork and wait
                    leau      >ChildParameterReturn,pc ; pass a CR-only command line
                    os9       F$Fork    ; start the selected protocol engine
                    lbcs      ExitWithStatus ; propagate a fork failure without touching statistics
                    clrb                ; clear stale status before waiting
                    os9       F$Wait    ; collect the downloader's termination status
                    lbcs      ExitWithStatus ; propagate a wait failure
                    cmpb      #0        ; require the child to report success
                    lbne      ExitWithStatus ; return the downloader's failure status
                    puls      u         ; recover the module workspace pointer
                    leax      >UserStatsPath,pc ; select the shared per-user statistics file
                    lda       #3        ; request read/write access
                    os9       I$Open    ; open the existing statistics database
                    bcc       StatsFileReady ; scan it when it already exists
                    ldb       #27       ; use the package's writable data-file attributes
                    os9       I$Create  ; create a missing statistics database
                    lbcs      ExitWithStatus ; preserve a create failure
StatsFileReady      sta       StatsPathNum,u ; retain the statistics path number
                    os9       F$ID      ; obtain the caller's OS-9 user ID
                    sty       CallerUserId,u ; retain the record key for the scan

* BBS.userstats uses 32-byte records keyed by their leading user ID.  Updating
* an existing record requires seeking back one record from the current position.
FindStatsRecord     leax      StatsUserId,u ; receive one complete statistics record
                    ldy       #32       ; preserve the fixed database stride
                    lda       StatsPathNum,u ; select the statistics stream
                    os9       I$Read    ; fetch the next user's counters
                    bcs       StatsScanEnded ; distinguish an absent user from an I/O error
                    ldd       StatsUserId,u ; inspect the record's account key
                    cmpd      CallerUserId,u ; compare it with the downloader's user ID
                    bne       FindStatsRecord ; continue until the caller's record is found
                    bra       IncrementDownloadCount ; update the existing download counter
StatsScanEnded      cmpb      #211      ; recognize OS-9 end-of-file as an absent record
                    lbne      ExitWithStatus ; preserve an actual statistics read error
                    lbra      CreateStatsRecord ; append the package's historical initial record
IncrementDownloadCount
stk_saved_workspace equ       0         ; saved u at the top of stack after the temporary push
                    ldd       <StatsDownloads,u ; fetch the caller's cumulative download count
                    addd      #1        ; account for the successful child transfer
                    std       <StatsDownloads,u ; retain the incremented count
                    lda       StatsPathNum,u ; select the statistics stream
                    ldb       #5        ; request its current 32-bit file position
                    pshs      u         ; save workspace u before GetStat returns the low offset in u
                    os9       I$GetStt  ; obtain the position immediately after the matched record
                    tfr       u,d       ; move the low offset word where subtraction is convenient
                    subd      #32       ; back up by one fixed statistics record
                    bge       HaveStatsWriteOffset ; retain the high word when no borrow occurred
                    leax      -$01,x    ; propagate the low-word borrow into the high word
HaveStatsWriteOffset ldu       stk_saved_workspace,s ; recover workspace access without popping it
                    tfr       d,y       ; preserve the calculated low offset word
                    lda       StatsPathNum,u ; recover the path number through workspace u
                    tfr       y,u       ; complete the target x:u seek position
                    os9       I$Seek    ; return to the beginning of the matched record
                    lbcs      ExitWithStatus ; preserve a seek failure
                    puls      u         ; restore the workspace pointer and balance the stack
                    leax      StatsUserId,u ; select the modified 32-byte record
                    ldy       #32       ; rewrite exactly one database record
                    lda       StatsPathNum,u ; select BBS.userstats
                    os9       I$Write   ; commit the incremented download count
                    os9       I$Close   ; release the statistics file
                    lbra      ExitSuccessfully ; report the completed transfer and accounting

* historical behavior for a missing user is asymmetric: it seeds login count
* and messages-read to one, but initializes the download count itself to zero.
CreateStatsRecord   leax      StatsUserId,u ; prepare a new record at its leading user-ID field
                    ldd       #1        ; select the historical nonzero initializer
                    std       StatsLoginCount,u ; seed the login count
                    std       <StatsMessagesRead,u ; seed messages-read, as in the original binary
                    ldd       #0        ; clear the other initialized counters
                    std       StatsMessagesLeft,u ; begin with no messages posted
                    std       <StatsUploads,u ; begin with no uploads
                    std       <StatsDownloads,u ; preserve the original zero download count anomaly
                    ldd       CallerUserId,u ; fetch the successful downloader's account ID
                    std       StatsUserId,u ; key the appended record to that caller
                    leax      StatsLastLoginTime,u ; select the record's six-byte timestamp field
                    os9       F$Time    ; stamp the newly created record with the current time
                    lbcs      ExitWithStatus ; preserve a clock-service error
                    leax      StatsUserId,u ; select the completed new record
                    ldy       #32       ; append one fixed-size record
                    lda       StatsPathNum,u ; select the statistics database
                    os9       I$Write   ; append the caller's initial counters
                    os9       I$Close   ; release the statistics file
                    lbcs      ExitWithStatus ; preserve a close failure reported by the original flow
ExitSuccessfully    clrb                ; report a successful quit or completed download
ExitWithStatus      os9       F$Exit    ; return success or the preserved OS-9 status

                    emod                ; emit the OS-9 module CRC and trailer
eom                 equ       *         ; mark the module end for the size expression
                    end                 ; end the assembly source
